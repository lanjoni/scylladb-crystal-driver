require "db"
require "db/spec"
require "../../src/scylladb/dbapi"

private def assert_single_read(rs, value_type, value)
    rs.move_next.should be_true
    rs.read(value_type).should eq(value)
    rs.move_next.should be_false
end

class ScyllaDBSpecs < DB::DriverSpecs(ScyllaDB::DBApi::Primitive)
    def include_shared_specs
        it "gets column count", prepared: :both do |db|
            db.exec sql_create_table_person
            db.query "select * from person" do |rs|
                rs.column_count.should eq(3)
            end
        end

        it "gets column name", prepared: :both do |db|
            db.exec sql_create_table_person

            db.query "select name, age from person" do |rs|
                rs.column_name(0).should eq("name")
                rs.column_name(1).should eq("age")
            end
        end

        it "gets many rows from table" do |db|
            db.exec sql_create_table_person
            db.exec sql_insert_person, "foo", 10
            db.exec sql_insert_person, "bar", 20
            db.exec sql_insert_person, "baz", 30

            names = [] of String
            ages = [] of Int32

            db.query sql_select_person do |rs|
                rs.each do
                    names << rs.read(String)
                    ages << rs.read(Int32)
                end

                names.sort.should eq(["bar", "baz", "foo"])
                ages.sort.should eq([10, 20, 30])
            end
        end
    end
end