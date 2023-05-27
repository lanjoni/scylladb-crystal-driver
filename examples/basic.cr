require "../src/scylladb/dbapi"

DB.open("scylladb://root@127.0.0.1") do |db|
    db.exec("drop keyspace if exists crystal_scylladb_dbapi_test")
    db.exec(<<-CQL)
        create keyspace crystal_scylladb_dbapi_test
        with replication = { 'class': 'SimpleStrategy', 'replication_factor': 1 }
    
    CQL
end

DB.open("scylladb://127.0.0.1/crystal_scylladb_dbapi_test") do |db|
    db.exec(<<-CQL)
        create table posts (
            id timeuuid primary key,
            title text,
            body text,
            created_at timestamp
        )
    CQL

    db.exec("insert into posts (id, title, body, created_at) values (?, ?, ?, now())",
            "Hello World", "Hello World, Crystal is here!", Time.now
    )

    db.query("select title, body, created_at from posts") do |rs|
        rs.each do
            title = rs.read(String)
            body = rs.read(String)
            created_at = rs.read(Time)
            puts title
            puts "(#{created_at})"
            puts body
        end
    end
end