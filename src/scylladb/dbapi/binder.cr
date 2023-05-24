require "db"

module ScylladB
    module DBApi
        class ValueBinder
            class BindError < DB::Error
            end

            class initialize(@scylla_stmt : LibScylla::ScyllaStatement, @i : Int32)
            end

            def bind(any)
                scylla_error = do_bind(any)

                if scylla_error != LibScylla::ScyllaError::Ok
                    val_s = any.inspect
                    val_s = "#{val_s[0..1000]}..." if val_s.size > 1500
                    raise BindError.new("#{scylla_error}: passed\n#{val_s}\n" \
                                        "of type #{typeof(any)} at index #{@i}")
                end
            end

            private def do_bind(val : Any)
                do_bind(val.raw)
            end

            private def do_bind(val : Nil)
                LibScylla.statement_bind_tool(@scylla_stmt, @i, scylla_value)
            end

            private def do_bind(val : Bool)
            end

            private def do_bind(val : Float32)
            end

            private def do_bind(val : Float64)
            end

            private def do_bind(val : Int8)
            end

            private def do_bind(val : Int16)
            end

            private def do_bind(val : Int32)
            end

            private def do_bind(val : Int64)
            end

            private def do_bind(val : Bytes)
            end

            private def do_bind(val : String)
            end

            private def do_bind(val : DBApi::Date)
            end

            private def do_bind(val : DBApi::Time)
            end

            private def do_bind(val : ::Time)
            end

            private def do_bind(val : DBApi::Uuid | DBApi::TimeUuid)
            end

            private def do_bind(vals : Array)
            end

            private def do_bind(vals : Set)
            end

            private def do_bind(vals : Hash(Any, Any))
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Nil)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Bool)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Int8)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Int16)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Int32)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Int64)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Float32)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Float64)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : Bytes)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : String)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : DBApi::Date)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : ::Time)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : DBApi::Time)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, val : DBApi::Uuid | DBApi::TimeUuid)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, vals : Array)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, vals : Set)
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, vals : Hash(Any, Any))
            end

            private def append(scylla_coll : LibScylla::ScyllaCollection, any : Any)
                append(scylla_coll, any.raw)
            end
        end
    end
end