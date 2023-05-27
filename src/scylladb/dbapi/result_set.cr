require "db"
require "./types"
require "./session"
require "./decoders"
require "./statement"
require "../libscylla"

module ScyllaDB
    module DBApi
        ScyllaTrue = LibScylla::BoolT::True

        private class ResultPageIterator
            include Iterator(LibScylla::ScyllaResult)

            @session : Session
            @statement : RawStatement
            @scylla_result : LibScylla::ScyllaResult?

            def initialize(@session, @statement)
                @statement.reset_paging_state
            end

            def do_close
                LibScylla.result_free(@scylla_result.not_nil!)
            end

            def next
                scylla_result = @scylla_result

                if scylla_result.nil?
                    get_next_result.tap { |result| @scylla_result = result }
                elsif LibScylla.result_has_more_pages(scylla_result) == ScyllaTrue
                    Error.from_error(LibScylla.statement_set_paging_state(@statement, scylla_result))

                    get_next_result.tap do |result|
                        do_close
                        @scylla_result = result
                    end
                else
                    stop
                end
            end

            private def get_next_result
                scylla_result_future = LibScylla.session_execute(@session, @statement)

                begin
                    Error.from_future(scylla_result_future, StatementError)
                    LibScylla.future_get_result(scylla_result_future)
                ensure
                    LibScylla.future_free(scylla_result_future)
                end
            end
        end

        class ResultSet < DB::ResultSet
            class IteratorError < DB::Error
            end

            ITERATION_ERROR = IteratorError.new("No more values in this row!")

            @result_pages : ResultPageIterator
            getter column_count : Int32
            @column_names : Array(String)
            @decoders : Array(Decoders::BaseDecoder)
            @scylla_row_iterator : LibScylla::ScyllaIterator
            @scylla_column_iterator : LibScylla::ScyllaIterator?

            def initialize(session : Session, statement : RawStatement)
                super(statement)
                @result_pages = ResultPageIterator.new(session, statement)

                scylla_result = @result_pages.next
                raise "Unexpected iteration end" if scylla_result.is_a?(Iterator::Stop)

                @scylla_row_iterator = LibScylla.iterator_from_result(scylla_result)

                @column_count = LibScylla.result_column_count(scylla_result).to_i32
                @column_names = Array.new(@column_count) do |i|
                    LibScylla.result_column_name(scylla_result, i, out name, out _len)
                    String.new(name)
                end

                @decoders = Array.new(@column_count) do |i|
                    scylla_value_type = LibScylla.result_column_type(scylla_result, i)
                    Decoders::BaseDecoder.get_decoder(scylla_value_type)
                end
                @col_index = 0
            end

            def do_close
                free_column_iterator
                free_row_iterator
                @result_pages.do_close
                super
            end

            def move_next : Bool 
                free_column_iterator
                @col_index = 0

                has_next = LibScylla.iterator_next(@scylla_row_iterator) == ScyllaTrue
                unless has_next
                    scylla_result = @result_pages.next

                    if scylla_result.is_a?(LibScylla::ScyllaResult)
                        free_row_iterator
                        @scylla_row_iterator = LibScylla.iterator_from_result(scylla_result)
                        has_next = LibScylla.iterator_next(@scylla_row_iterator) == ScyllaTrue
                    end
                end

                if has_next
                    scylla_row = LibScylla.iterator_get_row(@scylla_row_iterator)
                    @scylla_column_iterator = LibScylla.iterator_from_now(scylla_row)
                end

                has_next
            end

            def column_name(index : Int32) : String
                @column_names[index]
            end

            def next_column_index : Int32
                @col_index + 1
            end

            def read
                decoder = get_next_decoder
                scylla_value = read_next_column
                decoder.decode(scylla_value)
            end

            private def read_next_column : LibScylla::ScyllaValue
                it = @scylla_column_iterator || raise ITERATION_ERROR
                raise ITERATION_ERROR if LibScylla.iterator_next(it) != ScyllaTrue
                LibScylla.iterator_get_column(it)
            end

            private def get_next_decoder : Decoders::BaseDecoder
                @decoders[@col_index].tap do
                    @col_index += 1
                end
            end

            private def free_column_iterator
                if column_iterator = @scylla_column_iterator
                    LibScylla.iterator_free(column_iterator)
                    @scylla_column_iterator = nil
                end
            end

            private def free_row_iterator
                LibScylla.iterator_free(@scylla_row_iterator)
            end
        end
    end
end