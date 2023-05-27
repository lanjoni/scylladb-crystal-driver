require "spectator"
require "../src/scylladb/dbapi"

module DBHelper
    def self.setup
        ScyllaDB::LibScylla.log_set_level(
            ScyllaDB::LibScylla::ScyllaLogLevel::LogDisabled
        )

        DB.open(host) do |db|
            db.exec "drop keyspace if exists crystal_scylladb_dbapi_test"
            db.exec <<-CQL
                create keyspace crystal_scylladb_dbapi_test
                with replication = { 'class': 'SimpleStrategy',
                                     'replication_factor': 1}
            CQL
        end
    end

    def self.connect(params : String = "")
        DB.open(db_uri(params)) { |db| yield(db) }
    end

    def self.connect(params : String = "")
        DB.open(db_uri(params))
    end

    private def self.db_uri(params : String)
        "#{host}/crystal_scylladb_dbapi_test?#{params}"
    end

    private def self.host
        "scylladb://scylladb:scylladb@127.0.0.1"
    end
end