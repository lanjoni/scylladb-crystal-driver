module ScylladB
    module DBApi
        # TODO: handle errors properly with tests.
        module Error
            def self.from_future(scylla_future : LibScylla::ScyllaFuture, err_class : Class)
                Fiber.yield

                error_code = LibScylla.future_error_code(scylla_future)
                return if error_code == LibScylla::ScyllaError::Ok

                LibScylla.future_error_message(scylla_future, out msg, out len)
                error_message = String.new(msg, len)
                raise err_class.new("#{error_code}: #{error_message}")
            end

            def self.from_error(scylla_error : LibScylla::ScyllaError, err_class = DB::Error)
                if scylla_error != LibScylla::ScyllaError::Ok
                    raise err_class.new(scylla_error.to_s)
                end
            end
        end
    end
end