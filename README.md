<div align="center">
  <a href="https://github.com/lanjoni/scylladb-crystal-driver">
    <img src="https://www.scylladb.com/wp-content/uploads/scylla-opensource-1.png" alt="ScyllaDB Logo" width="150">
    <img src="https://cdn.freebiesupply.com/logos/large/2x/crystal-1-logo-png-transparent.png" alt="Crystal Logo" width="150">
  </a>
  
  <h1 align="center">ScyllaDB Crystal Driver</h1>

  <p align="center">
    A Crystal wrapper around the <a href="https://github.com/kaukas/crystal-cassandra">Crystal DB API for Cassandra</a> and <a href="https://github.com/scylladb/cpp-driver">C/C++ Driver for ScyllaDB</a>.
    <br />
    <br />
    <a href="https://docs.scylladb.com/stable/"><strong>Explore the ScyllaDB docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/lanjoni/scylladb-crystal-driver/issues">Report Bug</a>
    ·
    <a href="https://github.com/lanjoni/scylladb-crystal-driver/issues">Request Feature</a>
  </p>
</div>

## About

This project aims to build an environment for interoperability and use of ScyllaDB with the Crystal programming language, aiming at building a driver and wrapper for communication.

## Installation

Please make sure you have installed the [C/C++ Driver for ScyllaDB](https://github.com/scylladb/cpp-driver).

Then add this to your application's `shard.yml`:

```yml
dependencies:
  scylladb:
    github: lanjoni/scylladb-crystal-driver
```

## Documentation

- [ScyllaDB Documentation](https://docs.scylladb.com/stable/)
- [C/C++ Driver for ScyllaDB](https://github.com/scylladb/cpp-driver)
- [Crystal DB API for Cassandra](https://github.com/kaukas/crystal-cassandra)
- [DataStax C/C++ Driver](https://docs.datastax.com/en/developer/cpp-driver/2.10/)

## Usage

From the [basic example](https://github.com/lanjoni/scylladb-crystal-driver/blob/main/examples/basic.cr):

```cr
require "cassandra/dbapi"

DB.open("cassandra://127.0.0.1/test") do |db|
  db.exec(<<-CQL)
    create table posts (
      id timeuuid primary key,
      title text,
      body text,
      created_at timestamp
    )
  CQL
  db.exec("insert into posts (id, title, body, created_at) values (now(), ?, ?, ?)",
          "Hello World",
          "Hello, World. I have a story to tell.",
          Time.now)
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
```
Please refer to [crystal-db](https://github.com/crystal-lang/crystal-db) for further usage instructions.

## Types

`scylladb-crystal-driver` supports [all the `DB::Any`](https://crystal-lang.github.io/crystal-db/api/0.5.0/DB/Any.html) primitive types plus `Int8`, `Int16` and some additional value types:
- `date` maps to `ScyllaDB::DBApi::Date`
- `time` maps to `ScyllaDB::DBApi::Time`
- `uuid` maps to `ScyllaDB::DBApi::Uuid`
- `timeuuid` maps to `ScyllaDB:DBApi::TimeUuid`

Some of the collection types are also supported:
- `list` maps to `Array`
- `set` maps to `Set`
- `map` maps to `Hash`

## Development

After installation is complete run:

```sh
$ crystal spec
```
> This command runs the tests to verify that everything is working correctly.

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Contributors

* [lanjoni](https://github.com/lanjoni) -
  **João Lanjoni** <<guto@lanjoni.dev>> (he/him)
