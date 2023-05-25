require "db"
require "../libscylla"
require "./session"
require "./binder"

module ScylladB
    module DBApi
        class StatementError < DB::Error
        end

        class RawStatement < DB::Statement
            @scylla_result_future : LibScylla::ScyllaFuture?
            @scylla_statement : LibScylla::ScyllaStatement
            @session : ScyllaDB::DBApi::Session

            def initialize(session, cql : String, paging_size)
                initialize(session, create_statement(cql), cql, paging_size)
            end

            def initialize(@session, @scylla_statement, cql : String, paging_size : UInt64?)
                super(@session, cql)
                if paging_size
                    LibScylla.statement_set_paging_size(@scylla_statement, paging_size)
                end
            end

            def do_close
                LibScylla.statement_free(@scylla_statement)
                super
            end

            def to_unsafe
                @scylla_statement
            end

            def reset_paging_state
                LibScylla.statement_set_paging_state_token(@scylla_statement, "", 0)
            end

            protected def create_statement(cql)
                LibScylla.statement_new(cql, 0)
            end

            protected def perform_query(argds : Enumerable) : ResultSet
                rebind_params(args)
                ResultSet.new(@session, self)
            end

            protected def perform_execs(args : Enumerable) : DB::ExecResult
                rebind_params(args)
                
                scylla_result_future = LibScylla.session_execute(@session, @scylla_statement)

                begin
                    Error.from_future(scylla_result_future, StatementError)
                ensure
                    LibScylla.future_free(scylla_result_future)
                end

                DB::ExecResult.new(0, 0)
            end

            protected def rebind_params(args : Enumerable)
                LibScylla.statement_reset_parameters(@scylla_statement, args.size)
                args.each_with_index do |arg, i|
                    ValueBinder.new(@scylla_statement, i).bind(arg)
                end
            end
        end

        class PreparedStatement < DB::Statement
            @scylla_prepared : LibScylla::ScyllaPrepared
            @statement : RawStatement

            class StatementPrepareError < DB::Error
            end

            def initialize(@session : DBApi::Session, cql : String, paging_size : UInt64?)
                super(@session, cql)
                @scylla_prepared = prepare(@session, cql)
                scylla_statement = create_statement(@scylla_prepared)
                @statement = RawStatement.new(@session, scylla_statement, cql, paging_size)
            end

            def do_close
                @statement.do_close
                LibScylla.prepared_free(@scylla_prepared)
                super
            end

            protected def prepare(session, cql)
                scylla_prepare_future = LibScylla.session_prepare(session, cql)

                begin
                    Error.from_future(scylla_prepare_future, StatementPrepareError)
                    LibScylla.future_get_prepared(scylla_prepare_future)
                ensure
                    LibScylla.future_free(scylla_prepare_future)
                end
            end

            protected def create_statement(scylla_prepared : LibScylla::ScyllaPrepared)
                LibScylla.prepared_bind(scylla_prepared)
            end

            def perform_query(*args, **options) : DB::ResultSet
                @statement.perform_query(*args, **options)
            end

            def perform_exec(*args, **options) : DB::ExecResult
                @statement.perform_exec(*args, **options)
            end
        end
    end
end