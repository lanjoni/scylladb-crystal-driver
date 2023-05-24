require "../libscylla"

module Scylla
    module DBApi
        # Represents a ScyllaDB cluster.
        class Cluster
            @@clusters = {} of String => Cluster

            def self.acquire(context : DB::ConnectionContext)
                uri_s = context.uri.to_s
                cluster = @@clusters.fetch(uri_s) do
                    @@clusters[uri_s] = Cluster.new(context)
                end

                cluster.add_reference
            end

            @acquire_count = Atomic(Int32).new(0)
            @uri_s : String
            getter paging_size : Uint64?

            @scylla_cluster : LibScylla::ScyllaCluster

            def initialize(context : DB::ConnectionContext)
                @uri_s = context.uri.to_s
                @scylla_cluster = LibScylla.cluster_new

                host = context.uri.host || "127.0.0.1"
                LibScylla.cluster_set_contact_points(@scylla_cluster, host)

                user = context.uri.user
                password = context.uri.password

                if user && password
                    LibScylla.cluster_set_credentials(@scylla_cluster, user, password)
                end

                params = HTTP::Params.parse(context.uri.query || "")
                @paging_size = params["paging_size"]?.try(&.to_u64?)
            end

            def do_close
                @acquire_count.sub(1)
                return if @acquire_count.get > 0

                LibScylla.cluster_free(@scylla_cluster)
                @@clusters.delete(@uri_s)
            end

            def to_unsafe
                @scylla_cluster
            end

            protected def add_reference
                @acquire_count.add(1)
                self
            end
        end
    end
end