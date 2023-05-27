require "../spec_helper"
require "../../src/scylladb/dbapi"

Spectator.describe "Async" do
    before_all do
        DBHelper.setup

        DBHelper.connect do |db|
            db.exec "drop table if exists books"
            db.exec "create table books (id timeuuid primary key, title text)"
        end
    end

    let(db) { DBHelper.connect }

    after_each { db.close }

    before_each do
        db.exec "truncate table books"
    end

    it "runs queries asynchronously" do
        db.exec("insert into books (id, title) values (now(), ?)", "History")
        chan = Channel(String).new

        spawn do
            db.query("select title from books") do |rs|
                rs.each { chan.send("0: #{rs.read(String)}") }
            end
        end

        spawn do
            chan.send("i: query")
            db.query("select title from books") do |rs|
                rs.each { chan.send("1: #{rs.read(String)}") }
            end
        end

        expect(Array.new(3) { chan.receive }.first).to eq("1: query")
    end
end