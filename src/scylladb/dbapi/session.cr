require "db"
require "../libscylla"
require "./cluster"

module ScylladB
    module DBApi
        # Represents a ScyllaDB session
        class Session < DB::Connection
            class ConnectError < DB::Error
            end

            @scylla_session : LibScylla::ScyllaSession
            @cluster : Cluster

            def initialize(context : DB::ConnectionContext)
                super(context)
                @cluster = Cluster.acquire(context)
                @scylla_session = LibScylla.session_new
                connect(context.uri.path)
            end

            def to_unsafe
                @scylla_session
            end


            def connect(path : String?)
                keyspace = if path && path.size > 1
                                URI.decode(path[1..-1])
                           else
                                nil 
                           end

                scylla_connect_future = if keyspace
                                            LibScylla.session_connect_keyspace(@scylla_session, @cluster, keyspace)
                                        else
                                            LibScylla.session_connect(@scylla_session, @cluster)
                                        end
                begin
                    Error.from_future(scylla_connect_future, ConnectError)
                ensure
                    LibScylla.future_free(scylla_connect_future)
                end
            end

            def do_close
                LibScylla.session_free(@scylla_session)
                @cluster.do_close
            end

            def build_prepared_statement(query) : DB::Statement 
                PreparedStatement.new(self, query, @cluster.paging_size)
            end

            def build_unprepared_statement(query) : DB::Statement
                RawStatement.new(self, query, @cluster.paging_size)
            end
        end
    end
end