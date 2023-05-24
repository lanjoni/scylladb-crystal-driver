module ScyllaDB
    {% if flag?(:static) %}
    @[Link("scylladb_static")]
    {% else %}
    @[Link("scylladb")]
    {% end %}
    lib LibScylla
      VERSION_MAJOR = 2
      VERSION_MINOR = 14
      VERSION_PATCH = 1
      INET_V4_LENGTH = 4
      INET_V6_LENGTH = 16
      INET_STRING_LENGTH = 46
      UUID_STRING_LENGTH = 37
      LOG_MAX_MESSAGE_SIZE = 1024
      False = 0_i64
      True = 1_i64
      fun execution_profile_new = scylla_execution_profile_new : ScyllaExecProfile
      type ScyllaExecProfile = Void*
      fun execution_profile_free = scylla_execution_profile_free(profile : ScyllaExecProfile)
      fun execution_profile_set_request_timeout = scylla_execution_profile_set_request_timeout(profile : ScyllaExecProfile, timeout_ms : Uint64T) : ScyllaError
      alias Uint64T = LibC::ULongLong
      enum ScyllaError
        Ok = 0
        ErrorLibBadParams = 16777217
        ErrorLibNoStreams = 16777218
        ErrorLibUnableToInit = 16777219
        ErrorLibMessageEncode = 16777220
        ErrorLibHostResolution = 16777221
        ErrorLibUnexpectedResponse = 16777222
        ErrorLibRequestQueueFull = 16777223
        ErrorLibNoAvailableIoThread = 16777224
        ErrorLibWriteError = 16777225
        ErrorLibNoHostsAvailable = 16777226
        ErrorLibIndexOutOfBounds = 16777227
        ErrorLibInvalidItemCount = 16777228
        ErrorLibInvalidValueType = 16777229
        ErrorLibRequestTimedOut = 16777230
        ErrorLibUnableToSetKeyspace = 16777231
        ErrorLibCallbackAlreadySet = 16777232
        ErrorLibInvalidStatementType = 16777233
        ErrorLibNameDoesNotExist = 16777234
        ErrorLibUnableToDetermineProtocol = 16777235
        ErrorLibNullValue = 16777236
        ErrorLibNotImplemented = 16777237
        ErrorLibUnableToConnect = 16777238
        ErrorLibUnableToClose = 16777239
        ErrorLibNoPagingState = 16777240
        ErrorLibParameterUnset = 16777241
        ErrorLibInvalidErrorResultType = 16777242
        ErrorLibInvalidFutureType = 16777243
        ErrorLibInternalError = 16777244
        ErrorLibInvalidCustomType = 16777245
        ErrorLibInvalidData = 16777246
        ErrorLibNotEnoughData = 16777247
        ErrorLibInvalidState = 16777248
        ErrorLibNoCustomPayload = 16777249
        ErrorLibExecutionProfileInvalid = 16777250
        ErrorLibNoTracingId = 16777251
        ErrorServerServerError = 33554432
        ErrorServerProtocolError = 33554442
        ErrorServerBadCredentials = 33554688
        ErrorServerUnavailable = 33558528
        ErrorServerOverloaded = 33558529
        ErrorServerIsBootstrapping = 33558530
        ErrorServerTruncateError = 33558531
        ErrorServerWriteTimeout = 33558784
        ErrorServerReadTimeout = 33559040
        ErrorServerReadFailure = 33559296
        ErrorServerFunctionFailure = 33559552
        ErrorServerWriteFailure = 33559808
        ErrorServerSyntaxError = 33562624
        ErrorServerUnauthorized = 33562880
        ErrorServerInvalidQuery = 33563136
        ErrorServerConfigError = 33563392
        ErrorServerAlreadyExists = 33563648
        ErrorServerUnprepared = 33563904
        ErrorSslInvalidCert = 50331649
        ErrorSslInvalidPrivateKey = 50331650
        ErrorSslNoPeerCert = 50331651
        ErrorSslInvalidPeerCert = 50331652
        ErrorSslIdentityMismatch = 50331653
        ErrorSslProtocolError = 50331654
        ErrorSslClosed = 50331655
        ErrorLastEntry = 50331656
      end
      fun execution_profile_set_consistency = scylla_execution_profile_set_consistency(profile : ScyllaExecProfile, consistency : ScyllaConsistency) : ScyllaError
      enum ScyllaConsistency
        ConsistencyUnknown = 65535
        ConsistencyAny = 0
        ConsistencyOne = 1
        ConsistencyTwo = 2
        ConsistencyThree = 3
        ConsistencyQuorum = 4
        ConsistencyAll = 5
        ConsistencyLocalQuorum = 6
        ConsistencyEachQuorum = 7
        ConsistencySerial = 8
        ConsistencyLocalSerial = 9
        ConsistencyLocalOne = 10
      end
      fun execution_profile_set_serial_consistency = scylla_execution_profile_set_serial_consistency(profile : ScyllaExecProfile, serial_consistency : ScyllaConsistency) : ScyllaError
      fun execution_profile_set_load_balance_round_robin = scylla_execution_profile_set_load_balance_round_robin(profile : ScyllaExecProfile) : ScyllaError
      fun execution_profile_set_load_balance_dc_aware = scylla_execution_profile_set_load_balance_dc_aware(profile : ScyllaExecProfile, local_dc : LibC::Char*, used_hosts_per_remote_dc : LibC::UInt, allow_remote_dcs_for_local_cl : BoolT) : ScyllaError
      enum BoolT
        False = 0
        True = 1
      end
      fun execution_profile_set_load_balance_dc_aware_n = scylla_execution_profile_set_load_balance_dc_aware_n(profile : ScyllaExecProfile, local_dc : LibC::Char*, local_dc_length : LibC::SizeT, used_hosts_per_remote_dc : LibC::UInt, allow_remote_dcs_for_local_cl : BoolT) : ScyllaError
      fun execution_profile_set_token_aware_routing = scylla_execution_profile_set_token_aware_routing(profile : ScyllaExecProfile, enabled : BoolT) : ScyllaError
      fun execution_profile_set_token_aware_routing_shuffle_replicas = scylla_execution_profile_set_token_aware_routing_shuffle_replicas(profile : ScyllaExecProfile, enabled : BoolT) : ScyllaError
      fun execution_profile_set_latency_aware_routing = scylla_execution_profile_set_latency_aware_routing(profile : ScyllaExecProfile, enabled : BoolT) : ScyllaError
      fun execution_profile_set_latency_aware_routing_settings = scylla_execution_profile_set_latency_aware_routing_settings(profile : ScyllaExecProfile, exclusion_threshold : DoubleT, scale_ms : Uint64T, retry_period_ms : Uint64T, update_rate_ms : Uint64T, min_measured : Uint64T) : ScyllaError
      alias DoubleT = LibC::Double
      fun execution_profile_set_whitelist_filtering = scylla_execution_profile_set_whitelist_filtering(profile : ScyllaExecProfile, hosts : LibC::Char*) : ScyllaError
      fun execution_profile_set_whitelist_filtering_n = scylla_execution_profile_set_whitelist_filtering_n(profile : ScyllaExecProfile, hosts : LibC::Char*, hosts_length : LibC::SizeT) : ScyllaError
      fun execution_profile_set_blacklist_filtering = scylla_execution_profile_set_blacklist_filtering(profile : ScyllaExecProfile, hosts : LibC::Char*) : ScyllaError
      fun execution_profile_set_blacklist_filtering_n = scylla_execution_profile_set_blacklist_filtering_n(profile : ScyllaExecProfile, hosts : LibC::Char*, hosts_length : LibC::SizeT) : ScyllaError
      fun execution_profile_set_whitelist_dc_filtering = scylla_execution_profile_set_whitelist_dc_filtering(profile : ScyllaExecProfile, dcs : LibC::Char*) : ScyllaError
      fun execution_profile_set_whitelist_dc_filtering_n = scylla_execution_profile_set_whitelist_dc_filtering_n(profile : ScyllaExecProfile, dcs : LibC::Char*, dcs_length : LibC::SizeT) : ScyllaError
      fun execution_profile_set_blacklist_dc_filtering = scylla_execution_profile_set_blacklist_dc_filtering(profile : ScyllaExecProfile, dcs : LibC::Char*) : ScyllaError
      fun execution_profile_set_blacklist_dc_filtering_n = scylla_execution_profile_set_blacklist_dc_filtering_n(profile : ScyllaExecProfile, dcs : LibC::Char*, dcs_length : LibC::SizeT) : ScyllaError
      fun execution_profile_set_retry_policy = scylla_execution_profile_set_retry_policy(profile : ScyllaExecProfile, retry_policy : ScyllaRetryPolicy) : ScyllaError
      type ScyllaRetryPolicy = Void*
      fun execution_profile_set_constant_speculative_execution_policy = scylla_execution_profile_set_constant_speculative_execution_policy(profile : ScyllaExecProfile, constant_delay_ms : Int64T, max_speculative_executions : LibC::Int) : ScyllaError
      alias Int64T = LibC::LongLong
      fun execution_profile_set_no_speculative_execution_policy = scylla_execution_profile_set_no_speculative_execution_policy(profile : ScyllaExecProfile) : ScyllaError
      fun cluster_new = scylla_cluster_new : ScyllaCluster
      type ScyllaCluster = Void*
      fun cluster_free = scylla_cluster_free(cluster : ScyllaCluster)
      fun cluster_set_contact_points = scylla_cluster_set_contact_points(cluster : ScyllaCluster, contact_points : LibC::Char*) : ScyllaError
      fun cluster_set_contact_points_n = scylla_cluster_set_contact_points_n(cluster : ScyllaCluster, contact_points : LibC::Char*, contact_points_length : LibC::SizeT) : ScyllaError
      fun cluster_set_port = scylla_cluster_set_port(cluster : ScyllaCluster, port : LibC::Int) : ScyllaError
      fun cluster_set_local_address = scylla_cluster_set_local_address(cluster : ScyllaCluster, name : LibC::Char*) : ScyllaError
      fun cluster_set_local_address_n = scylla_cluster_set_local_address_n(cluster : ScyllaCluster, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaError
      fun cluster_set_ssl = scylla_cluster_set_ssl(cluster : ScyllaCluster, ssl : ScyllaSsl)
      type ScyllaSsl = Void*
      fun cluster_set_authenticator_callbacks = scylla_cluster_set_authenticator_callbacks(cluster : ScyllaCluster, exchange_callbacks : ScyllaAuthenticatorCallbacks*, cleanup_callback : ScyllaAuthenticatorDataCleanupCallback, data : Void*) : ScyllaError
      struct ScyllaAuthenticatorCallbacks
        initial_callback : ScyllaAuthenticatorInitialCallback
        challenge_callback : ScyllaAuthenticatorChallengeCallback
        success_callback : ScyllaAuthenticatorSuccessCallback
        cleanup_callback : ScyllaAuthenticatorCleanupCallback
      end
      type ScyllaAuthenticator = Void*
      alias ScyllaAuthenticatorInitialCallback = (ScyllaAuthenticator, Void* -> Void)
      alias ScyllaAuthenticatorChallengeCallback = (ScyllaAuthenticator, Void*, LibC::Char*, LibC::SizeT -> Void)
      alias ScyllaAuthenticatorSuccessCallback = (ScyllaAuthenticator, Void*, LibC::Char*, LibC::SizeT -> Void)
      alias ScyllaAuthenticatorCleanupCallback = (ScyllaAuthenticator, Void* -> Void)
      alias ScyllaAuthenticatorDataCleanupCallback = (Void* -> Void)
      fun cluster_set_protocol_version = scylla_cluster_set_protocol_version(cluster : ScyllaCluster, protocol_version : LibC::Int) : ScyllaError
      fun cluster_set_use_beta_protocol_version = scylla_cluster_set_use_beta_protocol_version(cluster : ScyllaCluster, enable : BoolT) : ScyllaError
      fun cluster_set_consistency = scylla_cluster_set_consistency(cluster : ScyllaCluster, consistency : ScyllaConsistency) : ScyllaError
      fun cluster_set_serial_consistency = scylla_cluster_set_serial_consistency(cluster : ScyllaCluster, consistency : ScyllaConsistency) : ScyllaError
      fun cluster_set_num_threads_io = scylla_cluster_set_num_threads_io(cluster : ScyllaCluster, num_threads : LibC::UInt) : ScyllaError
      fun cluster_set_queue_size_io = scylla_cluster_set_queue_size_io(cluster : ScyllaCluster, queue_size : LibC::UInt) : ScyllaError
      fun cluster_set_queue_size_event = scylla_cluster_set_queue_size_event(cluster : ScyllaCluster, queue_size : LibC::UInt) : ScyllaError
      fun cluster_set_core_connections_per_host = scylla_cluster_set_core_connections_per_host(cluster : ScyllaCluster, num_connections : LibC::UInt) : ScyllaError
      fun cluster_set_max_connections_per_host = scylla_cluster_set_max_connections_per_host(cluster : ScyllaCluster, num_connections : LibC::UInt) : ScyllaError
      fun cluster_set_reconnect_wait_time = scylla_cluster_set_reconnect_wait_time(cluster : ScyllaCluster, wait_time : LibC::UInt)
      fun cluster_set_constant_reconnect = scylla_cluster_set_constant_reconnect(cluster : ScyllaCluster, delay_ms : Uint64T)
      fun cluster_set_exponential_reconnect = scylla_cluster_set_exponential_reconnect(cluster : ScyllaCluster, base_delay_ms : Uint64T, max_delay_ms : Uint64T) : ScyllaError
      fun cluster_set_coalesce_delay = scylla_cluster_set_coalesce_delay(cluster : ScyllaCluster, delay_us : Int64T) : ScyllaError
      fun cluster_set_new_request_ratio = scylla_cluster_set_new_request_ratio(cluster : ScyllaCluster, ratio : Int32T) : ScyllaError
      alias Int32T = LibC::Int
      fun cluster_set_max_concurrent_creation = scylla_cluster_set_max_concurrent_creation(cluster : ScyllaCluster, num_connections : LibC::UInt) : ScyllaError
      fun cluster_set_max_concurrent_requests_threshold = scylla_cluster_set_max_concurrent_requests_threshold(cluster : ScyllaCluster, num_requests : LibC::UInt) : ScyllaError
      fun cluster_set_max_requests_per_flush = scylla_cluster_set_max_requests_per_flush(cluster : ScyllaCluster, num_requests : LibC::UInt) : ScyllaError
      fun cluster_set_write_bytes_high_water_mark = scylla_cluster_set_write_bytes_high_water_mark(cluster : ScyllaCluster, num_bytes : LibC::UInt) : ScyllaError
      fun cluster_set_write_bytes_low_water_mark = scylla_cluster_set_write_bytes_low_water_mark(cluster : ScyllaCluster, num_bytes : LibC::UInt) : ScyllaError
      fun cluster_set_pending_requests_high_water_mark = scylla_cluster_set_pending_requests_high_water_mark(cluster : ScyllaCluster, num_requests : LibC::UInt) : ScyllaError
      fun cluster_set_pending_requests_low_water_mark = scylla_cluster_set_pending_requests_low_water_mark(cluster : ScyllaCluster, num_requests : LibC::UInt) : ScyllaError
      fun cluster_set_connect_timeout = scylla_cluster_set_connect_timeout(cluster : ScyllaCluster, timeout_ms : LibC::UInt)
      fun cluster_set_request_timeout = scylla_cluster_set_request_timeout(cluster : ScyllaCluster, timeout_ms : LibC::UInt)
      fun cluster_set_resolve_timeout = scylla_cluster_set_resolve_timeout(cluster : ScyllaCluster, timeout_ms : LibC::UInt)
      fun cluster_set_max_schema_wait_time = scylla_cluster_set_max_schema_wait_time(cluster : ScyllaCluster, wait_time_ms : LibC::UInt)
      fun cluster_set_tracing_max_wait_time = scylla_cluster_set_tracing_max_wait_time(cluster : ScyllaCluster, max_wait_time_ms : LibC::UInt)
      fun cluster_set_tracing_retry_wait_time = scylla_cluster_set_tracing_retry_wait_time(cluster : ScyllaCluster, retry_wait_time_ms : LibC::UInt)
      fun cluster_set_tracing_consistency = scylla_cluster_set_tracing_consistency(cluster : ScyllaCluster, consistency : ScyllaConsistency)
      fun cluster_set_credentials = scylla_cluster_set_credentials(cluster : ScyllaCluster, username : LibC::Char*, password : LibC::Char*)
      fun cluster_set_credentials_n = scylla_cluster_set_credentials_n(cluster : ScyllaCluster, username : LibC::Char*, username_length : LibC::SizeT, password : LibC::Char*, password_length : LibC::SizeT)
      fun cluster_set_load_balance_round_robin = scylla_cluster_set_load_balance_round_robin(cluster : ScyllaCluster)
      fun cluster_set_load_balance_dc_aware = scylla_cluster_set_load_balance_dc_aware(cluster : ScyllaCluster, local_dc : LibC::Char*, used_hosts_per_remote_dc : LibC::UInt, allow_remote_dcs_for_local_cl : BoolT) : ScyllaError
      fun cluster_set_load_balance_dc_aware_n = scylla_cluster_set_load_balance_dc_aware_n(cluster : ScyllaCluster, local_dc : LibC::Char*, local_dc_length : LibC::SizeT, used_hosts_per_remote_dc : LibC::UInt, allow_remote_dcs_for_local_cl : BoolT) : ScyllaError
      fun cluster_set_token_aware_routing = scylla_cluster_set_token_aware_routing(cluster : ScyllaCluster, enabled : BoolT)
      fun cluster_set_token_aware_routing_shuffle_replicas = scylla_cluster_set_token_aware_routing_shuffle_replicas(cluster : ScyllaCluster, enabled : BoolT)
      fun cluster_set_latency_aware_routing = scylla_cluster_set_latency_aware_routing(cluster : ScyllaCluster, enabled : BoolT)
      fun cluster_set_latency_aware_routing_settings = scylla_cluster_set_latency_aware_routing_settings(cluster : ScyllaCluster, exclusion_threshold : DoubleT, scale_ms : Uint64T, retry_period_ms : Uint64T, update_rate_ms : Uint64T, min_measured : Uint64T)
      fun cluster_set_whitelist_filtering = scylla_cluster_set_whitelist_filtering(cluster : ScyllaCluster, hosts : LibC::Char*)
      fun cluster_set_whitelist_filtering_n = scylla_cluster_set_whitelist_filtering_n(cluster : ScyllaCluster, hosts : LibC::Char*, hosts_length : LibC::SizeT)
      fun cluster_set_blacklist_filtering = scylla_cluster_set_blacklist_filtering(cluster : ScyllaCluster, hosts : LibC::Char*)
      fun cluster_set_blacklist_filtering_n = scylla_cluster_set_blacklist_filtering_n(cluster : ScyllaCluster, hosts : LibC::Char*, hosts_length : LibC::SizeT)
      fun cluster_set_whitelist_dc_filtering = scylla_cluster_set_whitelist_dc_filtering(cluster : ScyllaCluster, dcs : LibC::Char*)
      fun cluster_set_whitelist_dc_filtering_n = scylla_cluster_set_whitelist_dc_filtering_n(cluster : ScyllaCluster, dcs : LibC::Char*, dcs_length : LibC::SizeT)
      fun cluster_set_blacklist_dc_filtering = scylla_cluster_set_blacklist_dc_filtering(cluster : ScyllaCluster, dcs : LibC::Char*)
      fun cluster_set_blacklist_dc_filtering_n = scylla_cluster_set_blacklist_dc_filtering_n(cluster : ScyllaCluster, dcs : LibC::Char*, dcs_length : LibC::SizeT)
      fun cluster_set_tcp_nodelay = scylla_cluster_set_tcp_nodelay(cluster : ScyllaCluster, enabled : BoolT)
      fun cluster_set_tcp_keepalive = scylla_cluster_set_tcp_keepalive(cluster : ScyllaCluster, enabled : BoolT, delay_secs : LibC::UInt)
      fun cluster_set_timestamp_gen = scylla_cluster_set_timestamp_gen(cluster : ScyllaCluster, timestamp_gen : ScyllaTimestampGen)
      type ScyllaTimestampGen = Void*
      fun cluster_set_connection_heartbeat_interval = scylla_cluster_set_connection_heartbeat_interval(cluster : ScyllaCluster, interval_secs : LibC::UInt)
      fun cluster_set_connection_idle_timeout = scylla_cluster_set_connection_idle_timeout(cluster : ScyllaCluster, timeout_secs : LibC::UInt)
      fun cluster_set_retry_policy = scylla_cluster_set_retry_policy(cluster : ScyllaCluster, retry_policy : ScyllaRetryPolicy)
      fun cluster_set_use_schema = scylla_cluster_set_use_schema(cluster : ScyllaCluster, enabled : BoolT)
      fun cluster_set_use_hostname_resolution = scylla_cluster_set_use_hostname_resolution(cluster : ScyllaCluster, enabled : BoolT) : ScyllaError
      fun cluster_set_use_randomized_contact_points = scylla_cluster_set_use_randomized_contact_points(cluster : ScyllaCluster, enabled : BoolT) : ScyllaError
      fun cluster_set_constant_speculative_execution_policy = scylla_cluster_set_constant_speculative_execution_policy(cluster : ScyllaCluster, constant_delay_ms : Int64T, max_speculative_executions : LibC::Int) : ScyllaError
      fun cluster_set_no_speculative_execution_policy = scylla_cluster_set_no_speculative_execution_policy(cluster : ScyllaCluster) : ScyllaError
      fun cluster_set_max_reusable_write_objects = scylla_cluster_set_max_reusable_write_objects(cluster : ScyllaCluster, num_objects : LibC::UInt) : ScyllaError
      fun cluster_set_execution_profile = scylla_cluster_set_execution_profile(cluster : ScyllaCluster, name : LibC::Char*, profile : ScyllaExecProfile) : ScyllaError
      fun cluster_set_execution_profile_n = scylla_cluster_set_execution_profile_n(cluster : ScyllaCluster, name : LibC::Char*, name_length : LibC::SizeT, profile : ScyllaExecProfile) : ScyllaError
      fun cluster_set_prepare_on_all_hosts = scylla_cluster_set_prepare_on_all_hosts(cluster : ScyllaCluster, enabled : BoolT) : ScyllaError
      fun cluster_set_prepare_on_up_or_add_host = scylla_cluster_set_prepare_on_up_or_add_host(cluster : ScyllaCluster, enabled : BoolT) : ScyllaError
      fun cluster_set_no_compact = scylla_cluster_set_no_compact(cluster : ScyllaCluster, enabled : BoolT) : ScyllaError
      fun cluster_set_host_listener_callback = scylla_cluster_set_host_listener_callback(cluster : ScyllaCluster, callback : ScyllaHostListenerCallback, data : Void*) : ScyllaError
      enum ScyllaHostListenerEvent
        HostListenerEventUp = 0
        HostListenerEventDown = 1
        HostListenerEventAdd = 2
        HostListenerEventRemove = 3
      end
      struct ScyllaInet
        address : Uint8T[16]
        address_length : Uint8T
      end
      alias ScyllaHostListenerCallback = (ScyllaHostListenerEvent, ScyllaInet, Void* -> Void)
      alias Uint8T = UInt8
      fun cluster_set_cloud_secure_connection_bundle = scylla_cluster_set_cloud_secure_connection_bundle(cluster : ScyllaCluster, path : LibC::Char*) : ScyllaError
      fun cluster_set_cloud_secure_connection_bundle_n = scylla_cluster_set_cloud_secure_connection_bundle_n(cluster : ScyllaCluster, path : LibC::Char*, path_length : LibC::SizeT) : ScyllaError
      fun cluster_set_cloud_secure_connection_bundle_no_ssl_lib_init = scylla_cluster_set_cloud_secure_connection_bundle_no_ssl_lib_init(cluster : ScyllaCluster, path : LibC::Char*) : ScyllaError
      fun cluster_set_cloud_secure_connection_bundle_no_ssl_lib_init_n = scylla_cluster_set_cloud_secure_connection_bundle_no_ssl_lib_init_n(cluster : ScyllaCluster, path : LibC::Char*, path_length : LibC::SizeT) : ScyllaError
      fun session_new = scylla_session_new : ScyllaSession
      type ScyllaSession = Void*
      fun session_free = scylla_session_free(session : ScyllaSession)
      fun session_connect = scylla_session_connect(session : ScyllaSession, cluster : ScyllaCluster) : ScyllaFuture
      type ScyllaFuture = Void*
      fun session_connect_keyspace = scylla_session_connect_keyspace(session : ScyllaSession, cluster : ScyllaCluster, keyspace : LibC::Char*) : ScyllaFuture
      fun session_connect_keyspace_n = scylla_session_connect_keyspace_n(session : ScyllaSession, cluster : ScyllaCluster, keyspace : LibC::Char*, keyspace_length : LibC::SizeT) : ScyllaFuture
      fun session_close = scylla_session_close(session : ScyllaSession) : ScyllaFuture
      fun session_prepare = scylla_session_prepare(session : ScyllaSession, query : LibC::Char*) : ScyllaFuture
      fun session_prepare_n = scylla_session_prepare_n(session : ScyllaSession, query : LibC::Char*, query_length : LibC::SizeT) : ScyllaFuture
      fun session_prepare_from_existing = scylla_session_prepare_from_existing(session : ScyllaSession, statement : ScyllaStatement) : ScyllaFuture
      type ScyllaStatement = Void*
      fun session_execute = scylla_session_execute(session : ScyllaSession, statement : ScyllaStatement) : ScyllaFuture
      fun session_execute_batch = scylla_session_execute_batch(session : ScyllaSession, batch : ScyllaBatch) : ScyllaFuture
      type ScyllaBatch = Void*
      fun session_get_schema_meta = scylla_session_get_schema_meta(session : ScyllaSession) : ScyllaSchemaMeta
      type ScyllaSchemaMeta = Void*
      fun session_get_metrics = scylla_session_get_metrics(session : ScyllaSession, output : ScyllaMetrics*)
      struct ScyllaMetrics
        requests : ScyllaMetricsRequests
        stats : ScyllaMetricsStats
        errors : ScyllaMetricsErrors
      end
      struct ScyllaMetricsRequests
        min : Uint64T
        max : Uint64T
        mean : Uint64T
        stddev : Uint64T
        median : Uint64T
        percentile_75th : Uint64T
        percentile_95th : Uint64T
        percentile_98th : Uint64T
        percentile_99th : Uint64T
        percentile_999th : Uint64T
        mean_rate : DoubleT
        one_minute_rate : DoubleT
        five_minute_rate : DoubleT
        fifteen_minute_rate : DoubleT
      end
      struct ScyllaMetricsStats
        total_connections : Uint64T
        available_connections : Uint64T
        exceeded_pending_requests_water_mark : Uint64T
        exceeded_write_bytes_water_mark : Uint64T
      end
      struct ScyllaMetricsErrors
        connection_timeouts : Uint64T
        pending_request_timeouts : Uint64T
        request_timeouts : Uint64T
      end
      fun session_get_speculative_execution_metrics = scylla_session_get_speculative_execution_metrics(session : ScyllaSession, output : ScyllaSpeculativeExecutionMetrics*)
      struct ScyllaSpeculativeExecutionMetrics
        min : Uint64T
        max : Uint64T
        mean : Uint64T
        stddev : Uint64T
        median : Uint64T
        percentile_75th : Uint64T
        percentile_95th : Uint64T
        percentile_98th : Uint64T
        percentile_99th : Uint64T
        percentile_999th : Uint64T
        count : Uint64T
        percentage : DoubleT
      end
      fun schema_meta_free = scylla_schema_meta_free(schema_meta : ScyllaSchemaMeta)
      fun schema_meta_snapshot_version = scylla_schema_meta_snapshot_version(schema_meta : ScyllaSchemaMeta) : Uint32T
      alias Uint32T = LibC::UInt
      fun schema_meta_version = scylla_schema_meta_version(schema_meta : ScyllaSchemaMeta) : ScyllaVersion
      struct ScyllaVersion
        major_version : LibC::Int
        minor_version : LibC::Int
        patch_version : LibC::Int
      end
      fun schema_meta_keyspace_by_name = scylla_schema_meta_keyspace_by_name(schema_meta : ScyllaSchemaMeta, keyspace : LibC::Char*) : ScyllaKeyspaceMeta
      type ScyllaKeyspaceMeta = Void*
      fun schema_meta_keyspace_by_name_n = scylla_schema_meta_keyspace_by_name_n(schema_meta : ScyllaSchemaMeta, keyspace : LibC::Char*, keyspace_length : LibC::SizeT) : ScyllaKeyspaceMeta
      fun keyspace_meta_name = scylla_keyspace_meta_name(keyspace_meta : ScyllaKeyspaceMeta, name : LibC::Char**, name_length : LibC::SizeT*)
      fun keyspace_meta_is_virtual = scylla_keyspace_meta_is_virtual(keyspace_meta : ScyllaKeyspaceMeta) : BoolT
      fun keyspace_meta_table_by_name = scylla_keyspace_meta_table_by_name(keyspace_meta : ScyllaKeyspaceMeta, table : LibC::Char*) : ScyllaTableMeta
      type ScyllaTableMeta = Void*
      fun keyspace_meta_table_by_name_n = scylla_keyspace_meta_table_by_name_n(keyspace_meta : ScyllaKeyspaceMeta, table : LibC::Char*, table_length : LibC::SizeT) : ScyllaTableMeta
      fun keyspace_meta_materialized_view_by_name = scylla_keyspace_meta_materialized_view_by_name(keyspace_meta : ScyllaKeyspaceMeta, view : LibC::Char*) : ScyllaMaterializedViewMeta
      type ScyllaMaterializedViewMeta = Void*
      fun keyspace_meta_materialized_view_by_name_n = scylla_keyspace_meta_materialized_view_by_name_n(keyspace_meta : ScyllaKeyspaceMeta, view : LibC::Char*, view_length : LibC::SizeT) : ScyllaMaterializedViewMeta
      fun keyspace_meta_user_type_by_name = scylla_keyspace_meta_user_type_by_name(keyspace_meta : ScyllaKeyspaceMeta, type : LibC::Char*) : ScyllaDataType
      type ScyllaDataType = Void*
      fun keyspace_meta_user_type_by_name_n = scylla_keyspace_meta_user_type_by_name_n(keyspace_meta : ScyllaKeyspaceMeta, type : LibC::Char*, type_length : LibC::SizeT) : ScyllaDataType
      fun keyspace_meta_function_by_name = scylla_keyspace_meta_function_by_name(keyspace_meta : ScyllaKeyspaceMeta, name : LibC::Char*, arguments : LibC::Char*) : ScyllaFunctionMeta
      type ScyllaFunctionMeta = Void*
      fun keyspace_meta_function_by_name_n = scylla_keyspace_meta_function_by_name_n(keyspace_meta : ScyllaKeyspaceMeta, name : LibC::Char*, name_length : LibC::SizeT, arguments : LibC::Char*, arguments_length : LibC::SizeT) : ScyllaFunctionMeta
      fun keyspace_meta_aggregate_by_name = scylla_keyspace_meta_aggregate_by_name(keyspace_meta : ScyllaKeyspaceMeta, name : LibC::Char*, arguments : LibC::Char*) : ScyllaAggregateMeta
      type ScyllaAggregateMeta = Void*
      fun keyspace_meta_aggregate_by_name_n = scylla_keyspace_meta_aggregate_by_name_n(keyspace_meta : ScyllaKeyspaceMeta, name : LibC::Char*, name_length : LibC::SizeT, arguments : LibC::Char*, arguments_length : LibC::SizeT) : ScyllaAggregateMeta
      fun keyspace_meta_field_by_name = scylla_keyspace_meta_field_by_name(keyspace_meta : ScyllaKeyspaceMeta, name : LibC::Char*) : ScyllaValue
      type ScyllaValue = Void*
      fun keyspace_meta_field_by_name_n = scylla_keyspace_meta_field_by_name_n(keyspace_meta : ScyllaKeyspaceMeta, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaValue
      fun table_meta_name = scylla_table_meta_name(table_meta : ScyllaTableMeta, name : LibC::Char**, name_length : LibC::SizeT*)
      fun table_meta_is_virtual = scylla_table_meta_is_virtual(table_meta : ScyllaTableMeta) : BoolT
      fun table_meta_column_by_name = scylla_table_meta_column_by_name(table_meta : ScyllaTableMeta, column : LibC::Char*) : ScyllaColumnMeta
      type ScyllaColumnMeta = Void*
      fun table_meta_column_by_name_n = scylla_table_meta_column_by_name_n(table_meta : ScyllaTableMeta, column : LibC::Char*, column_length : LibC::SizeT) : ScyllaColumnMeta
      fun table_meta_column_count = scylla_table_meta_column_count(table_meta : ScyllaTableMeta) : LibC::SizeT
      fun table_meta_column = scylla_table_meta_column(table_meta : ScyllaTableMeta, index : LibC::SizeT) : ScyllaColumnMeta
      fun table_meta_index_by_name = scylla_table_meta_index_by_name(table_meta : ScyllaTableMeta, index : LibC::Char*) : ScyllaIndexMeta
      type ScyllaIndexMeta = Void*
      fun table_meta_index_by_name_n = scylla_table_meta_index_by_name_n(table_meta : ScyllaTableMeta, index : LibC::Char*, index_length : LibC::SizeT) : ScyllaIndexMeta
      fun table_meta_index_count = scylla_table_meta_index_count(table_meta : ScyllaTableMeta) : LibC::SizeT
      fun table_meta_index = scylla_table_meta_index(table_meta : ScyllaTableMeta, index : LibC::SizeT) : ScyllaIndexMeta
      fun table_meta_materialized_view_by_name = scylla_table_meta_materialized_view_by_name(table_meta : ScyllaTableMeta, view : LibC::Char*) : ScyllaMaterializedViewMeta
      fun table_meta_materialized_view_by_name_n = scylla_table_meta_materialized_view_by_name_n(table_meta : ScyllaTableMeta, view : LibC::Char*, view_length : LibC::SizeT) : ScyllaMaterializedViewMeta
      fun table_meta_materialized_view_count = scylla_table_meta_materialized_view_count(table_meta : ScyllaTableMeta) : LibC::SizeT
      fun table_meta_materialized_view = scylla_table_meta_materialized_view(table_meta : ScyllaTableMeta, index : LibC::SizeT) : ScyllaMaterializedViewMeta
      fun table_meta_partition_key_count = scylla_table_meta_partition_key_count(table_meta : ScyllaTableMeta) : LibC::SizeT
      fun table_meta_partition_key = scylla_table_meta_partition_key(table_meta : ScyllaTableMeta, index : LibC::SizeT) : ScyllaColumnMeta
      fun table_meta_clustering_key_count = scylla_table_meta_clustering_key_count(table_meta : ScyllaTableMeta) : LibC::SizeT
      fun table_meta_clustering_key = scylla_table_meta_clustering_key(table_meta : ScyllaTableMeta, index : LibC::SizeT) : ScyllaColumnMeta
      fun table_meta_clustering_key_order = scylla_table_meta_clustering_key_order(table_meta : ScyllaTableMeta, index : LibC::SizeT) : ScyllaClusteringOrder
      enum ScyllaClusteringOrder
        ClusteringOrderNone = 0
        ClusteringOrderAsc = 1
        ClusteringOrderDesc = 2
      end
      fun table_meta_field_by_name = scylla_table_meta_field_by_name(table_meta : ScyllaTableMeta, name : LibC::Char*) : ScyllaValue
      fun table_meta_field_by_name_n = scylla_table_meta_field_by_name_n(table_meta : ScyllaTableMeta, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaValue
      fun materialized_view_meta_column_by_name = scylla_materialized_view_meta_column_by_name(view_meta : ScyllaMaterializedViewMeta, column : LibC::Char*) : ScyllaColumnMeta
      fun materialized_view_meta_column_by_name_n = scylla_materialized_view_meta_column_by_name_n(view_meta : ScyllaMaterializedViewMeta, column : LibC::Char*, column_length : LibC::SizeT) : ScyllaColumnMeta
      fun materialized_view_meta_name = scylla_materialized_view_meta_name(view_meta : ScyllaMaterializedViewMeta, name : LibC::Char**, name_length : LibC::SizeT*)
      fun materialized_view_meta_base_table = scylla_materialized_view_meta_base_table(view_meta : ScyllaMaterializedViewMeta) : ScyllaTableMeta
      fun materialized_view_meta_column_count = scylla_materialized_view_meta_column_count(view_meta : ScyllaMaterializedViewMeta) : LibC::SizeT
      fun materialized_view_meta_column = scylla_materialized_view_meta_column(view_meta : ScyllaMaterializedViewMeta, index : LibC::SizeT) : ScyllaColumnMeta
      fun materialized_view_meta_partition_key_count = scylla_materialized_view_meta_partition_key_count(view_meta : ScyllaMaterializedViewMeta) : LibC::SizeT
      fun materialized_view_meta_partition_key = scylla_materialized_view_meta_partition_key(view_meta : ScyllaMaterializedViewMeta, index : LibC::SizeT) : ScyllaColumnMeta
      fun materialized_view_meta_clustering_key_count = scylla_materialized_view_meta_clustering_key_count(view_meta : ScyllaMaterializedViewMeta) : LibC::SizeT
      fun materialized_view_meta_clustering_key = scylla_materialized_view_meta_clustering_key(view_meta : ScyllaMaterializedViewMeta, index : LibC::SizeT) : ScyllaColumnMeta
      fun materialized_view_meta_clustering_key_order = scylla_materialized_view_meta_clustering_key_order(view_meta : ScyllaMaterializedViewMeta, index : LibC::SizeT) : ScyllaClusteringOrder
      fun materialized_view_meta_field_by_name = scylla_materialized_view_meta_field_by_name(view_meta : ScyllaMaterializedViewMeta, name : LibC::Char*) : ScyllaValue
      fun materialized_view_meta_field_by_name_n = scylla_materialized_view_meta_field_by_name_n(view_meta : ScyllaMaterializedViewMeta, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaValue
      fun column_meta_name = scylla_column_meta_name(column_meta : ScyllaColumnMeta, name : LibC::Char**, name_length : LibC::SizeT*)
      fun column_meta_type = scylla_column_meta_type(column_meta : ScyllaColumnMeta) : ScyllaColumnType
      enum ScyllaColumnType
        ColumnTypeRegular = 0
        ColumnTypePartitionKey = 1
        ColumnTypeClusteringKey = 2
        ColumnTypeStatic = 3
        ColumnTypeCompactValue = 4
      end
      fun column_meta_data_type = scylla_column_meta_data_type(column_meta : ScyllaColumnMeta) : ScyllaDataType
      fun column_meta_field_by_name = scylla_column_meta_field_by_name(column_meta : ScyllaColumnMeta, name : LibC::Char*) : ScyllaValue
      fun column_meta_field_by_name_n = scylla_column_meta_field_by_name_n(column_meta : ScyllaColumnMeta, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaValue
      fun index_meta_name = scylla_index_meta_name(index_meta : ScyllaIndexMeta, name : LibC::Char**, name_length : LibC::SizeT*)
      fun index_meta_type = scylla_index_meta_type(index_meta : ScyllaIndexMeta) : ScyllaIndexType
      enum ScyllaIndexType
        IndexTypeUnknown = 0
        IndexTypeKeys = 1
        IndexTypeCustom = 2
        IndexTypeComposites = 3
      end
      fun index_meta_target = scylla_index_meta_target(index_meta : ScyllaIndexMeta, target : LibC::Char**, target_length : LibC::SizeT*)
      fun index_meta_options = scylla_index_meta_options(index_meta : ScyllaIndexMeta) : ScyllaValue
      fun index_meta_field_by_name = scylla_index_meta_field_by_name(index_meta : ScyllaIndexMeta, name : LibC::Char*) : ScyllaValue
      fun index_meta_field_by_name_n = scylla_index_meta_field_by_name_n(index_meta : ScyllaIndexMeta, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaValue
      fun function_meta_name = scylla_function_meta_name(function_meta : ScyllaFunctionMeta, name : LibC::Char**, name_length : LibC::SizeT*)
      fun function_meta_full_name = scylla_function_meta_full_name(function_meta : ScyllaFunctionMeta, full_name : LibC::Char**, full_name_length : LibC::SizeT*)
      fun function_meta_body = scylla_function_meta_body(function_meta : ScyllaFunctionMeta, body : LibC::Char**, body_length : LibC::SizeT*)
      fun function_meta_language = scylla_function_meta_language(function_meta : ScyllaFunctionMeta, language : LibC::Char**, language_length : LibC::SizeT*)
      fun function_meta_called_on_null_input = scylla_function_meta_called_on_null_input(function_meta : ScyllaFunctionMeta) : BoolT
      fun function_meta_argument_count = scylla_function_meta_argument_count(function_meta : ScyllaFunctionMeta) : LibC::SizeT
      fun function_meta_argument = scylla_function_meta_argument(function_meta : ScyllaFunctionMeta, index : LibC::SizeT, name : LibC::Char**, name_length : LibC::SizeT*, type : ScyllaDataType*) : ScyllaError
      fun function_meta_argument_type_by_name = scylla_function_meta_argument_type_by_name(function_meta : ScyllaFunctionMeta, name : LibC::Char*) : ScyllaDataType
      fun function_meta_argument_type_by_name_n = scylla_function_meta_argument_type_by_name_n(function_meta : ScyllaFunctionMeta, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaDataType
      fun function_meta_return_type = scylla_function_meta_return_type(function_meta : ScyllaFunctionMeta) : ScyllaDataType
      fun function_meta_field_by_name = scylla_function_meta_field_by_name(function_meta : ScyllaFunctionMeta, name : LibC::Char*) : ScyllaValue
      fun function_meta_field_by_name_n = scylla_function_meta_field_by_name_n(function_meta : ScyllaFunctionMeta, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaValue
      fun aggregate_meta_name = scylla_aggregate_meta_name(aggregate_meta : ScyllaAggregateMeta, name : LibC::Char**, name_length : LibC::SizeT*)
      fun aggregate_meta_full_name = scylla_aggregate_meta_full_name(aggregate_meta : ScyllaAggregateMeta, full_name : LibC::Char**, full_name_length : LibC::SizeT*)
      fun aggregate_meta_argument_count = scylla_aggregate_meta_argument_count(aggregate_meta : ScyllaAggregateMeta) : LibC::SizeT
      fun aggregate_meta_argument_type = scylla_aggregate_meta_argument_type(aggregate_meta : ScyllaAggregateMeta, index : LibC::SizeT) : ScyllaDataType
      fun aggregate_meta_return_type = scylla_aggregate_meta_return_type(aggregate_meta : ScyllaAggregateMeta) : ScyllaDataType
      fun aggregate_meta_state_type = scylla_aggregate_meta_state_type(aggregate_meta : ScyllaAggregateMeta) : ScyllaDataType
      fun aggregate_meta_state_func = scylla_aggregate_meta_state_func(aggregate_meta : ScyllaAggregateMeta) : ScyllaFunctionMeta
      fun aggregate_meta_final_func = scylla_aggregate_meta_final_func(aggregate_meta : ScyllaAggregateMeta) : ScyllaFunctionMeta
      fun aggregate_meta_init_cond = scylla_aggregate_meta_init_cond(aggregate_meta : ScyllaAggregateMeta) : ScyllaValue
      fun aggregate_meta_field_by_name = scylla_aggregate_meta_field_by_name(aggregate_meta : ScyllaAggregateMeta, name : LibC::Char*) : ScyllaValue
      fun aggregate_meta_field_by_name_n = scylla_aggregate_meta_field_by_name_n(aggregate_meta : ScyllaAggregateMeta, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaValue
      fun ssl_new = scylla_ssl_new : ScyllaSsl
      fun ssl_new_no_lib_init = scylla_ssl_new_no_lib_init : ScyllaSsl
      fun ssl_free = scylla_ssl_free(ssl : ScyllaSsl)
      fun ssl_add_trusted_cert = scylla_ssl_add_trusted_cert(ssl : ScyllaSsl, cert : LibC::Char*) : ScyllaError
      fun ssl_add_trusted_cert_n = scylla_ssl_add_trusted_cert_n(ssl : ScyllaSsl, cert : LibC::Char*, cert_length : LibC::SizeT) : ScyllaError
      fun ssl_set_verify_flags = scylla_ssl_set_verify_flags(ssl : ScyllaSsl, flags : LibC::Int)
      fun ssl_set_cert = scylla_ssl_set_cert(ssl : ScyllaSsl, cert : LibC::Char*) : ScyllaError
      fun ssl_set_cert_n = scylla_ssl_set_cert_n(ssl : ScyllaSsl, cert : LibC::Char*, cert_length : LibC::SizeT) : ScyllaError
      fun ssl_set_private_key = scylla_ssl_set_private_key(ssl : ScyllaSsl, key : LibC::Char*, password : LibC::Char*) : ScyllaError
      fun ssl_set_private_key_n = scylla_ssl_set_private_key_n(ssl : ScyllaSsl, key : LibC::Char*, key_length : LibC::SizeT, password : LibC::Char*, password_length : LibC::SizeT) : ScyllaError
      fun authenticator_address = scylla_authenticator_address(auth : ScyllaAuthenticator, address : ScyllaInet*)
      fun authenticator_hostname = scylla_authenticator_hostname(auth : ScyllaAuthenticator, length : LibC::SizeT*) : LibC::Char*
      fun authenticator_class_name = scylla_authenticator_class_name(auth : ScyllaAuthenticator, length : LibC::SizeT*) : LibC::Char*
      fun authenticator_exchange_data = scylla_authenticator_exchange_data(auth : ScyllaAuthenticator) : Void*
      fun authenticator_set_exchange_data = scylla_authenticator_set_exchange_data(auth : ScyllaAuthenticator, exchange_data : Void*)
      fun authenticator_response = scylla_authenticator_response(auth : ScyllaAuthenticator, size : LibC::SizeT) : LibC::Char*
      fun authenticator_set_response = scylla_authenticator_set_response(auth : ScyllaAuthenticator, response : LibC::Char*, response_size : LibC::SizeT)
      fun authenticator_set_error = scylla_authenticator_set_error(auth : ScyllaAuthenticator, message : LibC::Char*)
      fun authenticator_set_error_n = scylla_authenticator_set_error_n(auth : ScyllaAuthenticator, message : LibC::Char*, message_length : LibC::SizeT)
      fun future_free = scylla_future_free(future : ScyllaFuture)
      fun future_set_callback = scylla_future_set_callback(future : ScyllaFuture, callback : ScyllaFutureCallback, data : Void*) : ScyllaError
      alias ScyllaFutureCallback = (ScyllaFuture, Void* -> Void)
      fun future_ready = scylla_future_ready(future : ScyllaFuture) : BoolT
      fun future_wait = scylla_future_wait(future : ScyllaFuture)
      fun future_wait_timed = scylla_future_wait_timed(future : ScyllaFuture, timeout_us : DurationT) : BoolT
      alias DurationT = Uint64T
      fun future_get_result = scylla_future_get_result(future : ScyllaFuture) : ScyllaResult
      type ScyllaResult = Void*
      fun future_get_error_result = scylla_future_get_error_result(future : ScyllaFuture) : ScyllaErrorResult
      type ScyllaErrorResult = Void*
      fun future_get_prepared = scylla_future_get_prepared(future : ScyllaFuture) : ScyllaPrepared
      type ScyllaPrepared = Void*
      fun future_error_code = scylla_future_error_code(future : ScyllaFuture) : ScyllaError
      fun future_error_message = scylla_future_error_message(future : ScyllaFuture, message : LibC::Char**, message_length : LibC::SizeT*)
      fun future_tracing_id = scylla_future_tracing_id(future : ScyllaFuture, tracing_id : ScyllaUuid*) : ScyllaError
      struct ScyllaUuid
        time_and_version : Uint64T
        clock_seq_and_node : Uint64T
      end
      fun future_custom_payload_item_count = scylla_future_custom_payload_item_count(future : ScyllaFuture) : LibC::SizeT
      fun future_custom_payload_item = scylla_future_custom_payload_item(future : ScyllaFuture, index : LibC::SizeT, name : LibC::Char**, name_length : LibC::SizeT*, value : ByteT**, value_size : LibC::SizeT*) : ScyllaError
      alias ByteT = Uint8T
      fun statement_new = scylla_statement_new(query : LibC::Char*, parameter_count : LibC::SizeT) : ScyllaStatement
      fun statement_new_n = scylla_statement_new_n(query : LibC::Char*, query_length : LibC::SizeT, parameter_count : LibC::SizeT) : ScyllaStatement
      fun statement_reset_parameters = scylla_statement_reset_parameters(statement : ScyllaStatement, count : LibC::SizeT) : ScyllaError
      fun statement_free = scylla_statement_free(statement : ScyllaStatement)
      fun statement_add_key_index = scylla_statement_add_key_index(statement : ScyllaStatement, index : LibC::SizeT) : ScyllaError
      fun statement_set_keyspace = scylla_statement_set_keyspace(statement : ScyllaStatement, keyspace : LibC::Char*) : ScyllaError
      fun statement_set_keyspace_n = scylla_statement_set_keyspace_n(statement : ScyllaStatement, keyspace : LibC::Char*, keyspace_length : LibC::SizeT) : ScyllaError
      fun statement_set_consistency = scylla_statement_set_consistency(statement : ScyllaStatement, consistency : ScyllaConsistency) : ScyllaError
      fun statement_set_serial_consistency = scylla_statement_set_serial_consistency(statement : ScyllaStatement, serial_consistency : ScyllaConsistency) : ScyllaError
      fun statement_set_paging_size = scylla_statement_set_paging_size(statement : ScyllaStatement, page_size : LibC::Int) : ScyllaError
      fun statement_set_paging_state = scylla_statement_set_paging_state(statement : ScyllaStatement, result : ScyllaResult) : ScyllaError
      fun statement_set_paging_state_token = scylla_statement_set_paging_state_token(statement : ScyllaStatement, paging_state : LibC::Char*, paging_state_size : LibC::SizeT) : ScyllaError
      fun statement_set_timestamp = scylla_statement_set_timestamp(statement : ScyllaStatement, timestamp : Int64T) : ScyllaError
      fun statement_set_request_timeout = scylla_statement_set_request_timeout(statement : ScyllaStatement, timeout_ms : Uint64T) : ScyllaError
      fun statement_set_is_idempotent = scylla_statement_set_is_idempotent(statement : ScyllaStatement, is_idempotent : BoolT) : ScyllaError
      fun statement_set_retry_policy = scylla_statement_set_retry_policy(statement : ScyllaStatement, retry_policy : ScyllaRetryPolicy) : ScyllaError
      fun statement_set_custom_payload = scylla_statement_set_custom_payload(statement : ScyllaStatement, payload : ScyllaCustomPayload) : ScyllaError
      type ScyllaCustomPayload = Void*
      fun statement_set_execution_profile = scylla_statement_set_execution_profile(statement : ScyllaStatement, name : LibC::Char*) : ScyllaError
      fun statement_set_execution_profile_n = scylla_statement_set_execution_profile_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaError
      fun statement_set_tracing = scylla_statement_set_tracing(statement : ScyllaStatement, enabled : BoolT) : ScyllaError
      fun statement_set_host = scylla_statement_set_host(statement : ScyllaStatement, host : LibC::Char*, port : LibC::Int) : ScyllaError
      fun statement_set_host_n = scylla_statement_set_host_n(statement : ScyllaStatement, host : LibC::Char*, host_length : LibC::SizeT, port : LibC::Int) : ScyllaError
      fun statement_set_host_inet = scylla_statement_set_host_inet(statement : ScyllaStatement, host : ScyllaInet*, port : LibC::Int) : ScyllaError
      fun statement_bind_null = scylla_statement_bind_null(statement : ScyllaStatement, index : LibC::SizeT) : ScyllaError
      fun statement_bind_null_by_name = scylla_statement_bind_null_by_name(statement : ScyllaStatement, name : LibC::Char*) : ScyllaError
      fun statement_bind_null_by_name_n = scylla_statement_bind_null_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaError
      fun statement_bind_int8 = scylla_statement_bind_int8(statement : ScyllaStatement, index : LibC::SizeT, value : Int8T) : ScyllaError
      alias Int8T = LibC::Char
      fun statement_bind_int8_by_name = scylla_statement_bind_int8_by_name(statement : ScyllaStatement, name : LibC::Char*, value : Int8T) : ScyllaError
      fun statement_bind_int8_by_name_n = scylla_statement_bind_int8_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : Int8T) : ScyllaError
      fun statement_bind_int16 = scylla_statement_bind_int16(statement : ScyllaStatement, index : LibC::SizeT, value : Int16T) : ScyllaError
      alias Int16T = LibC::Short
      fun statement_bind_int16_by_name = scylla_statement_bind_int16_by_name(statement : ScyllaStatement, name : LibC::Char*, value : Int16T) : ScyllaError
      fun statement_bind_int16_by_name_n = scylla_statement_bind_int16_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : Int16T) : ScyllaError
      fun statement_bind_int32 = scylla_statement_bind_int32(statement : ScyllaStatement, index : LibC::SizeT, value : Int32T) : ScyllaError
      fun statement_bind_int32_by_name = scylla_statement_bind_int32_by_name(statement : ScyllaStatement, name : LibC::Char*, value : Int32T) : ScyllaError
      fun statement_bind_int32_by_name_n = scylla_statement_bind_int32_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : Int32T) : ScyllaError
      fun statement_bind_uint32 = scylla_statement_bind_uint32(statement : ScyllaStatement, index : LibC::SizeT, value : Uint32T) : ScyllaError
      fun statement_bind_uint32_by_name = scylla_statement_bind_uint32_by_name(statement : ScyllaStatement, name : LibC::Char*, value : Uint32T) : ScyllaError
      fun statement_bind_uint32_by_name_n = scylla_statement_bind_uint32_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : Uint32T) : ScyllaError
      fun statement_bind_int64 = scylla_statement_bind_int64(statement : ScyllaStatement, index : LibC::SizeT, value : Int64T) : ScyllaError
      fun statement_bind_int64_by_name = scylla_statement_bind_int64_by_name(statement : ScyllaStatement, name : LibC::Char*, value : Int64T) : ScyllaError
      fun statement_bind_int64_by_name_n = scylla_statement_bind_int64_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : Int64T) : ScyllaError
      fun statement_bind_float = scylla_statement_bind_float(statement : ScyllaStatement, index : LibC::SizeT, value : FloatT) : ScyllaError
      alias FloatT = LibC::Float
      fun statement_bind_float_by_name = scylla_statement_bind_float_by_name(statement : ScyllaStatement, name : LibC::Char*, value : FloatT) : ScyllaError
      fun statement_bind_float_by_name_n = scylla_statement_bind_float_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : FloatT) : ScyllaError
      fun statement_bind_double = scylla_statement_bind_double(statement : ScyllaStatement, index : LibC::SizeT, value : DoubleT) : ScyllaError
      fun statement_bind_double_by_name = scylla_statement_bind_double_by_name(statement : ScyllaStatement, name : LibC::Char*, value : DoubleT) : ScyllaError
      fun statement_bind_double_by_name_n = scylla_statement_bind_double_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : DoubleT) : ScyllaError
      fun statement_bind_bool = scylla_statement_bind_bool(statement : ScyllaStatement, index : LibC::SizeT, value : BoolT) : ScyllaError
      fun statement_bind_bool_by_name = scylla_statement_bind_bool_by_name(statement : ScyllaStatement, name : LibC::Char*, value : BoolT) : ScyllaError
      fun statement_bind_bool_by_name_n = scylla_statement_bind_bool_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : BoolT) : ScyllaError
      fun statement_bind_string = scylla_statement_bind_string(statement : ScyllaStatement, index : LibC::SizeT, value : LibC::Char*) : ScyllaError
      fun statement_bind_string_n = scylla_statement_bind_string_n(statement : ScyllaStatement, index : LibC::SizeT, value : LibC::Char*, value_length : LibC::SizeT) : ScyllaError
      fun statement_bind_string_by_name = scylla_statement_bind_string_by_name(statement : ScyllaStatement, name : LibC::Char*, value : LibC::Char*) : ScyllaError
      fun statement_bind_string_by_name_n = scylla_statement_bind_string_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : LibC::Char*, value_length : LibC::SizeT) : ScyllaError
      fun statement_bind_bytes = scylla_statement_bind_bytes(statement : ScyllaStatement, index : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun statement_bind_bytes_by_name = scylla_statement_bind_bytes_by_name(statement : ScyllaStatement, name : LibC::Char*, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun statement_bind_bytes_by_name_n = scylla_statement_bind_bytes_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun statement_bind_custom = scylla_statement_bind_custom(statement : ScyllaStatement, index : LibC::SizeT, class_name : LibC::Char*, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun statement_bind_custom_n = scylla_statement_bind_custom_n(statement : ScyllaStatement, index : LibC::SizeT, class_name : LibC::Char*, class_name_length : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun statement_bind_custom_by_name = scylla_statement_bind_custom_by_name(statement : ScyllaStatement, name : LibC::Char*, class_name : LibC::Char*, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun statement_bind_custom_by_name_n = scylla_statement_bind_custom_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, class_name : LibC::Char*, class_name_length : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun statement_bind_uuid = scylla_statement_bind_uuid(statement : ScyllaStatement, index : LibC::SizeT, value : ScyllaUuid) : ScyllaError
      fun statement_bind_uuid_by_name = scylla_statement_bind_uuid_by_name(statement : ScyllaStatement, name : LibC::Char*, value : ScyllaUuid) : ScyllaError
      fun statement_bind_uuid_by_name_n = scylla_statement_bind_uuid_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : ScyllaUuid) : ScyllaError
      fun statement_bind_inet = scylla_statement_bind_inet(statement : ScyllaStatement, index : LibC::SizeT, value : ScyllaInet) : ScyllaError
      fun statement_bind_inet_by_name = scylla_statement_bind_inet_by_name(statement : ScyllaStatement, name : LibC::Char*, value : ScyllaInet) : ScyllaError
      fun statement_bind_inet_by_name_n = scylla_statement_bind_inet_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, value : ScyllaInet) : ScyllaError
      fun statement_bind_decimal = scylla_statement_bind_decimal(statement : ScyllaStatement, index : LibC::SizeT, varint : ByteT*, varint_size : LibC::SizeT, scale : Int32T) : ScyllaError
      fun statement_bind_decimal_by_name = scylla_statement_bind_decimal_by_name(statement : ScyllaStatement, name : LibC::Char*, varint : ByteT*, varint_size : LibC::SizeT, scale : Int32T) : ScyllaError
      fun statement_bind_decimal_by_name_n = scylla_statement_bind_decimal_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, varint : ByteT*, varint_size : LibC::SizeT, scale : Int32T) : ScyllaError
      fun statement_bind_duration = scylla_statement_bind_duration(statement : ScyllaStatement, index : LibC::SizeT, months : Int32T, days : Int32T, nanos : Int64T) : ScyllaError
      fun statement_bind_duration_by_name = scylla_statement_bind_duration_by_name(statement : ScyllaStatement, name : LibC::Char*, months : Int32T, days : Int32T, nanos : Int64T) : ScyllaError
      fun statement_bind_duration_by_name_n = scylla_statement_bind_duration_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, months : Int32T, days : Int32T, nanos : Int64T) : ScyllaError
      fun statement_bind_collection = scylla_statement_bind_collection(statement : ScyllaStatement, index : LibC::SizeT, collection : ScyllaCollection) : ScyllaError
      type ScyllaCollection = Void*
      fun statement_bind_collection_by_name = scylla_statement_bind_collection_by_name(statement : ScyllaStatement, name : LibC::Char*, collection : ScyllaCollection) : ScyllaError
      fun statement_bind_collection_by_name_n = scylla_statement_bind_collection_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, collection : ScyllaCollection) : ScyllaError
      fun statement_bind_tuple = scylla_statement_bind_tuple(statement : ScyllaStatement, index : LibC::SizeT, tuple : ScyllaTuple) : ScyllaError
      type ScyllaTuple = Void*
      fun statement_bind_tuple_by_name = scylla_statement_bind_tuple_by_name(statement : ScyllaStatement, name : LibC::Char*, tuple : ScyllaTuple) : ScyllaError
      fun statement_bind_tuple_by_name_n = scylla_statement_bind_tuple_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, tuple : ScyllaTuple) : ScyllaError
      fun statement_bind_user_type = scylla_statement_bind_user_type(statement : ScyllaStatement, index : LibC::SizeT, user_type : ScyllaUserType) : ScyllaError
      type ScyllaUserType = Void*
      fun statement_bind_user_type_by_name = scylla_statement_bind_user_type_by_name(statement : ScyllaStatement, name : LibC::Char*, user_type : ScyllaUserType) : ScyllaError
      fun statement_bind_user_type_by_name_n = scylla_statement_bind_user_type_by_name_n(statement : ScyllaStatement, name : LibC::Char*, name_length : LibC::SizeT, user_type : ScyllaUserType) : ScyllaError
      fun prepared_free = scylla_prepared_free(prepared : ScyllaPrepared)
      fun prepared_bind = scylla_prepared_bind(prepared : ScyllaPrepared) : ScyllaStatement
      fun prepared_parameter_name = scylla_prepared_parameter_name(prepared : ScyllaPrepared, index : LibC::SizeT, name : LibC::Char**, name_length : LibC::SizeT*) : ScyllaError
      fun prepared_parameter_data_type = scylla_prepared_parameter_data_type(prepared : ScyllaPrepared, index : LibC::SizeT) : ScyllaDataType
      fun prepared_parameter_data_type_by_name = scylla_prepared_parameter_data_type_by_name(prepared : ScyllaPrepared, name : LibC::Char*) : ScyllaDataType
      fun prepared_parameter_data_type_by_name_n = scylla_prepared_parameter_data_type_by_name_n(prepared : ScyllaPrepared, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaDataType
      fun batch_new = scylla_batch_new(type : ScyllaBatchType) : ScyllaBatch
      enum ScyllaBatchType
        BatchTypeLogged = 0
        BatchTypeUnlogged = 1
        BatchTypeCounter = 2
      end
      fun batch_free = scylla_batch_free(batch : ScyllaBatch)
      fun batch_set_keyspace = scylla_batch_set_keyspace(batch : ScyllaBatch, keyspace : LibC::Char*) : ScyllaError
      fun batch_set_keyspace_n = scylla_batch_set_keyspace_n(batch : ScyllaBatch, keyspace : LibC::Char*, keyspace_length : LibC::SizeT) : ScyllaError
      fun batch_set_consistency = scylla_batch_set_consistency(batch : ScyllaBatch, consistency : ScyllaConsistency) : ScyllaError
      fun batch_set_serial_consistency = scylla_batch_set_serial_consistency(batch : ScyllaBatch, serial_consistency : ScyllaConsistency) : ScyllaError
      fun batch_set_timestamp = scylla_batch_set_timestamp(batch : ScyllaBatch, timestamp : Int64T) : ScyllaError
      fun batch_set_request_timeout = scylla_batch_set_request_timeout(batch : ScyllaBatch, timeout_ms : Uint64T) : ScyllaError
      fun batch_set_is_idempotent = scylla_batch_set_is_idempotent(batch : ScyllaBatch, is_idempotent : BoolT) : ScyllaError
      fun batch_set_retry_policy = scylla_batch_set_retry_policy(batch : ScyllaBatch, retry_policy : ScyllaRetryPolicy) : ScyllaError
      fun batch_set_custom_payload = scylla_batch_set_custom_payload(batch : ScyllaBatch, payload : ScyllaCustomPayload) : ScyllaError
      fun batch_set_tracing = scylla_batch_set_tracing(batch : ScyllaBatch, enabled : BoolT) : ScyllaError
      fun batch_add_statement = scylla_batch_add_statement(batch : ScyllaBatch, statement : ScyllaStatement) : ScyllaError
      fun batch_set_execution_profile = scylla_batch_set_execution_profile(batch : ScyllaBatch, name : LibC::Char*) : ScyllaError
      fun batch_set_execution_profile_n = scylla_batch_set_execution_profile_n(batch : ScyllaBatch, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaError
      fun data_type_new = scylla_data_type_new(type : ScyllaValueType) : ScyllaDataType
      enum ScyllaValueType
        ValueTypeUnknown = 65535
        ValueTypeCustom = 0
        ValueTypeAscii = 1
        ValueTypeBigint = 2
        ValueTypeBlob = 3
        ValueTypeBoolean = 4
        ValueTypeCounter = 5
        ValueTypeDecimal = 6
        ValueTypeDouble = 7
        ValueTypeFloat = 8
        ValueTypeInt = 9
        ValueTypeText = 10
        ValueTypeTimestamp = 11
        ValueTypeUuid = 12
        ValueTypeVarchar = 13
        ValueTypeVarint = 14
        ValueTypeTimeuuid = 15
        ValueTypeInet = 16
        ValueTypeDate = 17
        ValueTypeTime = 18
        ValueTypeSmallInt = 19
        ValueTypeTinyInt = 20
        ValueTypeDuration = 21
        ValueTypeList = 32
        ValueTypeMap = 33
        ValueTypeSet = 34
        ValueTypeUdt = 48
        ValueTypeTuple = 49
        ValueTypeLastEntry = 50
      end
      fun data_type_new_from_existing = scylla_data_type_new_from_existing(data_type : ScyllaDataType) : ScyllaDataType
      fun data_type_new_tuple = scylla_data_type_new_tuple(item_count : LibC::SizeT) : ScyllaDataType
      fun data_type_new_udt = scylla_data_type_new_udt(field_count : LibC::SizeT) : ScyllaDataType
      fun data_type_free = scylla_data_type_free(data_type : ScyllaDataType)
      fun data_type_type = scylla_data_type_type(data_type : ScyllaDataType) : ScyllaValueType
      fun data_type_is_frozen = scylla_data_type_is_frozen(data_type : ScyllaDataType) : BoolT
      fun data_type_type_name = scylla_data_type_type_name(data_type : ScyllaDataType, type_name : LibC::Char**, type_name_length : LibC::SizeT*) : ScyllaError
      fun data_type_set_type_name = scylla_data_type_set_type_name(data_type : ScyllaDataType, type_name : LibC::Char*) : ScyllaError
      fun data_type_set_type_name_n = scylla_data_type_set_type_name_n(data_type : ScyllaDataType, type_name : LibC::Char*, type_name_length : LibC::SizeT) : ScyllaError
      fun data_type_keyspace = scylla_data_type_keyspace(data_type : ScyllaDataType, keyspace : LibC::Char**, keyspace_length : LibC::SizeT*) : ScyllaError
      fun data_type_set_keyspace = scylla_data_type_set_keyspace(data_type : ScyllaDataType, keyspace : LibC::Char*) : ScyllaError
      fun data_type_set_keyspace_n = scylla_data_type_set_keyspace_n(data_type : ScyllaDataType, keyspace : LibC::Char*, keyspace_length : LibC::SizeT) : ScyllaError
      fun data_type_class_name = scylla_data_type_class_name(data_type : ScyllaDataType, class_name : LibC::Char**, class_name_length : LibC::SizeT*) : ScyllaError
      fun data_type_set_class_name = scylla_data_type_set_class_name(data_type : ScyllaDataType, class_name : LibC::Char*) : ScyllaError
      fun data_type_set_class_name_n = scylla_data_type_set_class_name_n(data_type : ScyllaDataType, class_name : LibC::Char*, class_name_length : LibC::SizeT) : ScyllaError
      fun data_type_sub_type_count = scylla_data_type_sub_type_count(data_type : ScyllaDataType) : LibC::SizeT
      fun data_sub_type_count = scylla_data_sub_type_count(data_type : ScyllaDataType) : LibC::SizeT
      fun data_type_sub_data_type = scylla_data_type_sub_data_type(data_type : ScyllaDataType, index : LibC::SizeT) : ScyllaDataType
      fun data_type_sub_data_type_by_name = scylla_data_type_sub_data_type_by_name(data_type : ScyllaDataType, name : LibC::Char*) : ScyllaDataType
      fun data_type_sub_data_type_by_name_n = scylla_data_type_sub_data_type_by_name_n(data_type : ScyllaDataType, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaDataType
      fun data_type_sub_type_name = scylla_data_type_sub_type_name(data_type : ScyllaDataType, index : LibC::SizeT, name : LibC::Char**, name_length : LibC::SizeT*) : ScyllaError
      fun data_type_add_sub_type = scylla_data_type_add_sub_type(data_type : ScyllaDataType, sub_data_type : ScyllaDataType) : ScyllaError
      fun data_type_add_sub_type_by_name = scylla_data_type_add_sub_type_by_name(data_type : ScyllaDataType, name : LibC::Char*, sub_data_type : ScyllaDataType) : ScyllaError
      fun data_type_add_sub_type_by_name_n = scylla_data_type_add_sub_type_by_name_n(data_type : ScyllaDataType, name : LibC::Char*, name_length : LibC::SizeT, sub_data_type : ScyllaDataType) : ScyllaError
      fun data_type_add_sub_value_type = scylla_data_type_add_sub_value_type(data_type : ScyllaDataType, sub_value_type : ScyllaValueType) : ScyllaError
      fun data_type_add_sub_value_type_by_name = scylla_data_type_add_sub_value_type_by_name(data_type : ScyllaDataType, name : LibC::Char*, sub_value_type : ScyllaValueType) : ScyllaError
      fun data_type_add_sub_value_type_by_name_n = scylla_data_type_add_sub_value_type_by_name_n(data_type : ScyllaDataType, name : LibC::Char*, name_length : LibC::SizeT, sub_value_type : ScyllaValueType) : ScyllaError
      fun collection_new = scylla_collection_new(type : ScyllaCollectionType, item_count : LibC::SizeT) : ScyllaCollection
      enum ScyllaCollectionType
        CollectionTypeList = 32
        CollectionTypeMap = 33
        CollectionTypeSet = 34
      end
      fun collection_new_from_data_type = scylla_collection_new_from_data_type(data_type : ScyllaDataType, item_count : LibC::SizeT) : ScyllaCollection
      fun collection_free = scylla_collection_free(collection : ScyllaCollection)
      fun collection_data_type = scylla_collection_data_type(collection : ScyllaCollection) : ScyllaDataType
      fun collection_append_int8 = scylla_collection_append_int8(collection : ScyllaCollection, value : Int8T) : ScyllaError
      fun collection_append_int16 = scylla_collection_append_int16(collection : ScyllaCollection, value : Int16T) : ScyllaError
      fun collection_append_int32 = scylla_collection_append_int32(collection : ScyllaCollection, value : Int32T) : ScyllaError
      fun collection_append_uint32 = scylla_collection_append_uint32(collection : ScyllaCollection, value : Uint32T) : ScyllaError
      fun collection_append_int64 = scylla_collection_append_int64(collection : ScyllaCollection, value : Int64T) : ScyllaError
      fun collection_append_float = scylla_collection_append_float(collection : ScyllaCollection, value : FloatT) : ScyllaError
      fun collection_append_double = scylla_collection_append_double(collection : ScyllaCollection, value : DoubleT) : ScyllaError
      fun collection_append_bool = scylla_collection_append_bool(collection : ScyllaCollection, value : BoolT) : ScyllaError
      fun collection_append_string = scylla_collection_append_string(collection : ScyllaCollection, value : LibC::Char*) : ScyllaError
      fun collection_append_string_n = scylla_collection_append_string_n(collection : ScyllaCollection, value : LibC::Char*, value_length : LibC::SizeT) : ScyllaError
      fun collection_append_bytes = scylla_collection_append_bytes(collection : ScyllaCollection, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun collection_append_custom = scylla_collection_append_custom(collection : ScyllaCollection, class_name : LibC::Char*, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun collection_append_custom_n = scylla_collection_append_custom_n(collection : ScyllaCollection, class_name : LibC::Char*, class_name_length : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun collection_append_uuid = scylla_collection_append_uuid(collection : ScyllaCollection, value : ScyllaUuid) : ScyllaError
      fun collection_append_inet = scylla_collection_append_inet(collection : ScyllaCollection, value : ScyllaInet) : ScyllaError
      fun collection_append_decimal = scylla_collection_append_decimal(collection : ScyllaCollection, varint : ByteT*, varint_size : LibC::SizeT, scale : Int32T) : ScyllaError
      fun collection_append_duration = scylla_collection_append_duration(collection : ScyllaCollection, months : Int32T, days : Int32T, nanos : Int64T) : ScyllaError
      fun collection_append_collection = scylla_collection_append_collection(collection : ScyllaCollection, value : ScyllaCollection) : ScyllaError
      fun collection_append_tuple = scylla_collection_append_tuple(collection : ScyllaCollection, value : ScyllaTuple) : ScyllaError
      fun collection_append_user_type = scylla_collection_append_user_type(collection : ScyllaCollection, value : ScyllaUserType) : ScyllaError
      fun tuple_new = scylla_tuple_new(item_count : LibC::SizeT) : ScyllaTuple
      fun tuple_new_from_data_type = scylla_tuple_new_from_data_type(data_type : ScyllaDataType) : ScyllaTuple
      fun tuple_free = scylla_tuple_free(tuple : ScyllaTuple)
      fun tuple_data_type = scylla_tuple_data_type(tuple : ScyllaTuple) : ScyllaDataType
      fun tuple_set_null = scylla_tuple_set_null(tuple : ScyllaTuple, index : LibC::SizeT) : ScyllaError
      fun tuple_set_int8 = scylla_tuple_set_int8(tuple : ScyllaTuple, index : LibC::SizeT, value : Int8T) : ScyllaError
      fun tuple_set_int16 = scylla_tuple_set_int16(tuple : ScyllaTuple, index : LibC::SizeT, value : Int16T) : ScyllaError
      fun tuple_set_int32 = scylla_tuple_set_int32(tuple : ScyllaTuple, index : LibC::SizeT, value : Int32T) : ScyllaError
      fun tuple_set_uint32 = scylla_tuple_set_uint32(tuple : ScyllaTuple, index : LibC::SizeT, value : Uint32T) : ScyllaError
      fun tuple_set_int64 = scylla_tuple_set_int64(tuple : ScyllaTuple, index : LibC::SizeT, value : Int64T) : ScyllaError
      fun tuple_set_float = scylla_tuple_set_float(tuple : ScyllaTuple, index : LibC::SizeT, value : FloatT) : ScyllaError
      fun tuple_set_double = scylla_tuple_set_double(tuple : ScyllaTuple, index : LibC::SizeT, value : DoubleT) : ScyllaError
      fun tuple_set_bool = scylla_tuple_set_bool(tuple : ScyllaTuple, index : LibC::SizeT, value : BoolT) : ScyllaError
      fun tuple_set_string = scylla_tuple_set_string(tuple : ScyllaTuple, index : LibC::SizeT, value : LibC::Char*) : ScyllaError
      fun tuple_set_string_n = scylla_tuple_set_string_n(tuple : ScyllaTuple, index : LibC::SizeT, value : LibC::Char*, value_length : LibC::SizeT) : ScyllaError
      fun tuple_set_bytes = scylla_tuple_set_bytes(tuple : ScyllaTuple, index : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun tuple_set_custom = scylla_tuple_set_custom(tuple : ScyllaTuple, index : LibC::SizeT, class_name : LibC::Char*, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun tuple_set_custom_n = scylla_tuple_set_custom_n(tuple : ScyllaTuple, index : LibC::SizeT, class_name : LibC::Char*, class_name_length : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun tuple_set_uuid = scylla_tuple_set_uuid(tuple : ScyllaTuple, index : LibC::SizeT, value : ScyllaUuid) : ScyllaError
      fun tuple_set_inet = scylla_tuple_set_inet(tuple : ScyllaTuple, index : LibC::SizeT, value : ScyllaInet) : ScyllaError
      fun tuple_set_decimal = scylla_tuple_set_decimal(tuple : ScyllaTuple, index : LibC::SizeT, varint : ByteT*, varint_size : LibC::SizeT, scale : Int32T) : ScyllaError
      fun tuple_set_duration = scylla_tuple_set_duration(tuple : ScyllaTuple, index : LibC::SizeT, months : Int32T, days : Int32T, nanos : Int64T) : ScyllaError
      fun tuple_set_collection = scylla_tuple_set_collection(tuple : ScyllaTuple, index : LibC::SizeT, value : ScyllaCollection) : ScyllaError
      fun tuple_set_tuple = scylla_tuple_set_tuple(tuple : ScyllaTuple, index : LibC::SizeT, value : ScyllaTuple) : ScyllaError
      fun tuple_set_user_type = scylla_tuple_set_user_type(tuple : ScyllaTuple, index : LibC::SizeT, value : ScyllaUserType) : ScyllaError
      fun user_type_new_from_data_type = scylla_user_type_new_from_data_type(data_type : ScyllaDataType) : ScyllaUserType
      fun user_type_free = scylla_user_type_free(user_type : ScyllaUserType)
      fun user_type_data_type = scylla_user_type_data_type(user_type : ScyllaUserType) : ScyllaDataType
      fun user_type_set_null = scylla_user_type_set_null(user_type : ScyllaUserType, index : LibC::SizeT) : ScyllaError
      fun user_type_set_null_by_name = scylla_user_type_set_null_by_name(user_type : ScyllaUserType, name : LibC::Char*) : ScyllaError
      fun user_type_set_null_by_name_n = scylla_user_type_set_null_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaError
      fun user_type_set_int8 = scylla_user_type_set_int8(user_type : ScyllaUserType, index : LibC::SizeT, value : Int8T) : ScyllaError
      fun user_type_set_int8_by_name = scylla_user_type_set_int8_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : Int8T) : ScyllaError
      fun user_type_set_int8_by_name_n = scylla_user_type_set_int8_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : Int8T) : ScyllaError
      fun user_type_set_int16 = scylla_user_type_set_int16(user_type : ScyllaUserType, index : LibC::SizeT, value : Int16T) : ScyllaError
      fun user_type_set_int16_by_name = scylla_user_type_set_int16_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : Int16T) : ScyllaError
      fun user_type_set_int16_by_name_n = scylla_user_type_set_int16_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : Int16T) : ScyllaError
      fun user_type_set_int32 = scylla_user_type_set_int32(user_type : ScyllaUserType, index : LibC::SizeT, value : Int32T) : ScyllaError
      fun user_type_set_int32_by_name = scylla_user_type_set_int32_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : Int32T) : ScyllaError
      fun user_type_set_int32_by_name_n = scylla_user_type_set_int32_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : Int32T) : ScyllaError
      fun user_type_set_uint32 = scylla_user_type_set_uint32(user_type : ScyllaUserType, index : LibC::SizeT, value : Uint32T) : ScyllaError
      fun user_type_set_uint32_by_name = scylla_user_type_set_uint32_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : Uint32T) : ScyllaError
      fun user_type_set_uint32_by_name_n = scylla_user_type_set_uint32_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : Uint32T) : ScyllaError
      fun user_type_set_int64 = scylla_user_type_set_int64(user_type : ScyllaUserType, index : LibC::SizeT, value : Int64T) : ScyllaError
      fun user_type_set_int64_by_name = scylla_user_type_set_int64_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : Int64T) : ScyllaError
      fun user_type_set_int64_by_name_n = scylla_user_type_set_int64_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : Int64T) : ScyllaError
      fun user_type_set_float = scylla_user_type_set_float(user_type : ScyllaUserType, index : LibC::SizeT, value : FloatT) : ScyllaError
      fun user_type_set_float_by_name = scylla_user_type_set_float_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : FloatT) : ScyllaError
      fun user_type_set_float_by_name_n = scylla_user_type_set_float_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : FloatT) : ScyllaError
      fun user_type_set_double = scylla_user_type_set_double(user_type : ScyllaUserType, index : LibC::SizeT, value : DoubleT) : ScyllaError
      fun user_type_set_double_by_name = scylla_user_type_set_double_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : DoubleT) : ScyllaError
      fun user_type_set_double_by_name_n = scylla_user_type_set_double_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : DoubleT) : ScyllaError
      fun user_type_set_bool = scylla_user_type_set_bool(user_type : ScyllaUserType, index : LibC::SizeT, value : BoolT) : ScyllaError
      fun user_type_set_bool_by_name = scylla_user_type_set_bool_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : BoolT) : ScyllaError
      fun user_type_set_bool_by_name_n = scylla_user_type_set_bool_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : BoolT) : ScyllaError
      fun user_type_set_string = scylla_user_type_set_string(user_type : ScyllaUserType, index : LibC::SizeT, value : LibC::Char*) : ScyllaError
      fun user_type_set_string_n = scylla_user_type_set_string_n(user_type : ScyllaUserType, index : LibC::SizeT, value : LibC::Char*, value_length : LibC::SizeT) : ScyllaError
      fun user_type_set_string_by_name = scylla_user_type_set_string_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : LibC::Char*) : ScyllaError
      fun user_type_set_string_by_name_n = scylla_user_type_set_string_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : LibC::Char*, value_length : LibC::SizeT) : ScyllaError
      fun user_type_set_bytes = scylla_user_type_set_bytes(user_type : ScyllaUserType, index : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun user_type_set_bytes_by_name = scylla_user_type_set_bytes_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun user_type_set_bytes_by_name_n = scylla_user_type_set_bytes_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun user_type_set_custom = scylla_user_type_set_custom(user_type : ScyllaUserType, index : LibC::SizeT, class_name : LibC::Char*, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun user_type_set_custom_n = scylla_user_type_set_custom_n(user_type : ScyllaUserType, index : LibC::SizeT, class_name : LibC::Char*, class_name_length : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun user_type_set_custom_by_name = scylla_user_type_set_custom_by_name(user_type : ScyllaUserType, name : LibC::Char*, class_name : LibC::Char*, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun user_type_set_custom_by_name_n = scylla_user_type_set_custom_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, class_name : LibC::Char*, class_name_length : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT) : ScyllaError
      fun user_type_set_uuid = scylla_user_type_set_uuid(user_type : ScyllaUserType, index : LibC::SizeT, value : ScyllaUuid) : ScyllaError
      fun user_type_set_uuid_by_name = scylla_user_type_set_uuid_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : ScyllaUuid) : ScyllaError
      fun user_type_set_uuid_by_name_n = scylla_user_type_set_uuid_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : ScyllaUuid) : ScyllaError
      fun user_type_set_inet = scylla_user_type_set_inet(user_type : ScyllaUserType, index : LibC::SizeT, value : ScyllaInet) : ScyllaError
      fun user_type_set_inet_by_name = scylla_user_type_set_inet_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : ScyllaInet) : ScyllaError
      fun user_type_set_inet_by_name_n = scylla_user_type_set_inet_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : ScyllaInet) : ScyllaError
      fun user_type_set_decimal = scylla_user_type_set_decimal(user_type : ScyllaUserType, index : LibC::SizeT, varint : ByteT*, varint_size : LibC::SizeT, scale : LibC::Int) : ScyllaError
      fun user_type_set_decimal_by_name = scylla_user_type_set_decimal_by_name(user_type : ScyllaUserType, name : LibC::Char*, varint : ByteT*, varint_size : LibC::SizeT, scale : LibC::Int) : ScyllaError
      fun user_type_set_decimal_by_name_n = scylla_user_type_set_decimal_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, varint : ByteT*, varint_size : LibC::SizeT, scale : LibC::Int) : ScyllaError
      fun user_type_set_duration = scylla_user_type_set_duration(user_type : ScyllaUserType, index : LibC::SizeT, months : Int32T, days : Int32T, nanos : Int64T) : ScyllaError
      fun user_type_set_duration_by_name = scylla_user_type_set_duration_by_name(user_type : ScyllaUserType, name : LibC::Char*, months : Int32T, days : Int32T, nanos : Int64T) : ScyllaError
      fun user_type_set_duration_by_name_n = scylla_user_type_set_duration_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, months : Int32T, days : Int32T, nanos : Int64T) : ScyllaError
      fun user_type_set_collection = scylla_user_type_set_collection(user_type : ScyllaUserType, index : LibC::SizeT, value : ScyllaCollection) : ScyllaError
      fun user_type_set_collection_by_name = scylla_user_type_set_collection_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : ScyllaCollection) : ScyllaError
      fun user_type_set_collection_by_name_n = scylla_user_type_set_collection_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : ScyllaCollection) : ScyllaError
      fun user_type_set_tuple = scylla_user_type_set_tuple(user_type : ScyllaUserType, index : LibC::SizeT, value : ScyllaTuple) : ScyllaError
      fun user_type_set_tuple_by_name = scylla_user_type_set_tuple_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : ScyllaTuple) : ScyllaError
      fun user_type_set_tuple_by_name_n = scylla_user_type_set_tuple_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : ScyllaTuple) : ScyllaError
      fun user_type_set_user_type = scylla_user_type_set_user_type(user_type : ScyllaUserType, index : LibC::SizeT, value : ScyllaUserType) : ScyllaError
      fun user_type_set_user_type_by_name = scylla_user_type_set_user_type_by_name(user_type : ScyllaUserType, name : LibC::Char*, value : ScyllaUserType) : ScyllaError
      fun user_type_set_user_type_by_name_n = scylla_user_type_set_user_type_by_name_n(user_type : ScyllaUserType, name : LibC::Char*, name_length : LibC::SizeT, value : ScyllaUserType) : ScyllaError
      fun result_free = scylla_result_free(result : ScyllaResult)
      fun result_row_count = scylla_result_row_count(result : ScyllaResult) : LibC::SizeT
      fun result_column_count = scylla_result_column_count(result : ScyllaResult) : LibC::SizeT
      fun result_column_name = scylla_result_column_name(result : ScyllaResult, index : LibC::SizeT, name : LibC::Char**, name_length : LibC::SizeT*) : ScyllaError
      fun result_column_type = scylla_result_column_type(result : ScyllaResult, index : LibC::SizeT) : ScyllaValueType
      fun result_column_data_type = scylla_result_column_data_type(result : ScyllaResult, index : LibC::SizeT) : ScyllaDataType
      fun result_first_row = scylla_result_first_row(result : ScyllaResult) : ScyllaRow
      type ScyllaRow = Void*
      fun result_has_more_pages = scylla_result_has_more_pages(result : ScyllaResult) : BoolT
      fun result_paging_state_token = scylla_result_paging_state_token(result : ScyllaResult, paging_state : LibC::Char**, paging_state_size : LibC::SizeT*) : ScyllaError
      fun error_result_free = scylla_error_result_free(error_result : ScyllaErrorResult)
      fun error_result_code = scylla_error_result_code(error_result : ScyllaErrorResult) : ScyllaError
      fun error_result_consistency = scylla_error_result_consistency(error_result : ScyllaErrorResult) : ScyllaConsistency
      fun error_result_responses_received = scylla_error_result_responses_received(error_result : ScyllaErrorResult) : Int32T
      fun error_result_responses_required = scylla_error_result_responses_required(error_result : ScyllaErrorResult) : Int32T
      fun error_result_num_failures = scylla_error_result_num_failures(error_result : ScyllaErrorResult) : Int32T
      fun error_result_data_present = scylla_error_result_data_present(error_result : ScyllaErrorResult) : BoolT
      fun error_result_write_type = scylla_error_result_write_type(error_result : ScyllaErrorResult) : ScyllaWriteType
      enum ScyllaWriteType
        WriteTypeUnknown = 0
        WriteTypeSimple = 1
        WriteTypeBatch = 2
        WriteTypeUnloggedBatch = 3
        WriteTypeCounter = 4
        WriteTypeBatchLog = 5
        WriteTypeCas = 6
        WriteTypeView = 7
        WriteTypeCdc = 8
      end
      fun error_result_keyspace = scylla_error_result_keyspace(error_result : ScyllaErrorResult, keyspace : LibC::Char**, keyspace_length : LibC::SizeT*) : ScyllaError
      fun error_result_table = scylla_error_result_table(error_result : ScyllaErrorResult, table : LibC::Char**, table_length : LibC::SizeT*) : ScyllaError
      fun error_result_function = scylla_error_result_function(error_result : ScyllaErrorResult, function : LibC::Char**, function_length : LibC::SizeT*) : ScyllaError
      fun error_num_arg_types = scylla_error_num_arg_types(error_result : ScyllaErrorResult) : LibC::SizeT
      fun error_result_arg_type = scylla_error_result_arg_type(error_result : ScyllaErrorResult, index : LibC::SizeT, arg_type : LibC::Char**, arg_type_length : LibC::SizeT*) : ScyllaError
      fun iterator_free = scylla_iterator_free(iterator : ScyllaIterator)
      type ScyllaIterator = Void*
      fun iterator_type = scylla_iterator_type(iterator : ScyllaIterator) : ScyllaIteratorType
      enum ScyllaIteratorType
        IteratorTypeResult = 0
        IteratorTypeRow = 1
        IteratorTypeCollection = 2
        IteratorTypeMap = 3
        IteratorTypeTuple = 4
        IteratorTypeUserTypeField = 5
        IteratorTypeMetaField = 6
        IteratorTypeKeyspaceMeta = 7
        IteratorTypeTableMeta = 8
        IteratorTypeTypeMeta = 9
        IteratorTypeFunctionMeta = 10
        IteratorTypeAggregateMeta = 11
        IteratorTypeColumnMeta = 12
        IteratorTypeIndexMeta = 13
        IteratorTypeMaterializedViewMeta = 14
      end
      fun iterator_from_result = scylla_iterator_from_result(result : ScyllaResult) : ScyllaIterator
      fun iterator_from_row = scylla_iterator_from_row(row : ScyllaRow) : ScyllaIterator
      fun iterator_from_collection = scylla_iterator_from_collection(value : ScyllaValue) : ScyllaIterator
      fun iterator_from_map = scylla_iterator_from_map(value : ScyllaValue) : ScyllaIterator
      fun iterator_from_tuple = scylla_iterator_from_tuple(value : ScyllaValue) : ScyllaIterator
      fun iterator_fields_from_user_type = scylla_iterator_fields_from_user_type(value : ScyllaValue) : ScyllaIterator
      fun iterator_keyspaces_from_schema_meta = scylla_iterator_keyspaces_from_schema_meta(schema_meta : ScyllaSchemaMeta) : ScyllaIterator
      fun iterator_tables_from_keyspace_meta = scylla_iterator_tables_from_keyspace_meta(keyspace_meta : ScyllaKeyspaceMeta) : ScyllaIterator
      fun iterator_materialized_views_from_keyspace_meta = scylla_iterator_materialized_views_from_keyspace_meta(keyspace_meta : ScyllaKeyspaceMeta) : ScyllaIterator
      fun iterator_user_types_from_keyspace_meta = scylla_iterator_user_types_from_keyspace_meta(keyspace_meta : ScyllaKeyspaceMeta) : ScyllaIterator
      fun iterator_functions_from_keyspace_meta = scylla_iterator_functions_from_keyspace_meta(keyspace_meta : ScyllaKeyspaceMeta) : ScyllaIterator
      fun iterator_aggregates_from_keyspace_meta = scylla_iterator_aggregates_from_keyspace_meta(keyspace_meta : ScyllaKeyspaceMeta) : ScyllaIterator
      fun iterator_fields_from_keyspace_meta = scylla_iterator_fields_from_keyspace_meta(keyspace_meta : ScyllaKeyspaceMeta) : ScyllaIterator
      fun iterator_columns_from_table_meta = scylla_iterator_columns_from_table_meta(table_meta : ScyllaTableMeta) : ScyllaIterator
      fun iterator_indexes_from_table_meta = scylla_iterator_indexes_from_table_meta(table_meta : ScyllaTableMeta) : ScyllaIterator
      fun iterator_materialized_views_from_table_meta = scylla_iterator_materialized_views_from_table_meta(table_meta : ScyllaTableMeta) : ScyllaIterator
      fun iterator_fields_from_table_meta = scylla_iterator_fields_from_table_meta(table_meta : ScyllaTableMeta) : ScyllaIterator
      fun iterator_columns_from_materialized_view_meta = scylla_iterator_columns_from_materialized_view_meta(view_meta : ScyllaMaterializedViewMeta) : ScyllaIterator
      fun iterator_fields_from_materialized_view_meta = scylla_iterator_fields_from_materialized_view_meta(view_meta : ScyllaMaterializedViewMeta) : ScyllaIterator
      fun iterator_fields_from_column_meta = scylla_iterator_fields_from_column_meta(column_meta : ScyllaColumnMeta) : ScyllaIterator
      fun iterator_fields_from_index_meta = scylla_iterator_fields_from_index_meta(index_meta : ScyllaIndexMeta) : ScyllaIterator
      fun iterator_fields_from_function_meta = scylla_iterator_fields_from_function_meta(function_meta : ScyllaFunctionMeta) : ScyllaIterator
      fun iterator_fields_from_aggregate_meta = scylla_iterator_fields_from_aggregate_meta(aggregate_meta : ScyllaAggregateMeta) : ScyllaIterator
      fun iterator_next = scylla_iterator_next(iterator : ScyllaIterator) : BoolT
      fun iterator_get_row = scylla_iterator_get_row(iterator : ScyllaIterator) : ScyllaRow
      fun iterator_get_column = scylla_iterator_get_column(iterator : ScyllaIterator) : ScyllaValue
      fun iterator_get_value = scylla_iterator_get_value(iterator : ScyllaIterator) : ScyllaValue
      fun iterator_get_map_key = scylla_iterator_get_map_key(iterator : ScyllaIterator) : ScyllaValue
      fun iterator_get_map_value = scylla_iterator_get_map_value(iterator : ScyllaIterator) : ScyllaValue
      fun iterator_get_user_type_field_name = scylla_iterator_get_user_type_field_name(iterator : ScyllaIterator, name : LibC::Char**, name_length : LibC::SizeT*) : ScyllaError
      fun iterator_get_user_type_field_value = scylla_iterator_get_user_type_field_value(iterator : ScyllaIterator) : ScyllaValue
      fun iterator_get_keyspace_meta = scylla_iterator_get_keyspace_meta(iterator : ScyllaIterator) : ScyllaKeyspaceMeta
      fun iterator_get_table_meta = scylla_iterator_get_table_meta(iterator : ScyllaIterator) : ScyllaTableMeta
      fun iterator_get_materialized_view_meta = scylla_iterator_get_materialized_view_meta(iterator : ScyllaIterator) : ScyllaMaterializedViewMeta
      fun iterator_get_user_type = scylla_iterator_get_user_type(iterator : ScyllaIterator) : ScyllaDataType
      fun iterator_get_function_meta = scylla_iterator_get_function_meta(iterator : ScyllaIterator) : ScyllaFunctionMeta
      fun iterator_get_aggregate_meta = scylla_iterator_get_aggregate_meta(iterator : ScyllaIterator) : ScyllaAggregateMeta
      fun iterator_get_column_meta = scylla_iterator_get_column_meta(iterator : ScyllaIterator) : ScyllaColumnMeta
      fun iterator_get_index_meta = scylla_iterator_get_index_meta(iterator : ScyllaIterator) : ScyllaIndexMeta
      fun iterator_get_meta_field_name = scylla_iterator_get_meta_field_name(iterator : ScyllaIterator, name : LibC::Char**, name_length : LibC::SizeT*) : ScyllaError
      fun iterator_get_meta_field_value = scylla_iterator_get_meta_field_value(iterator : ScyllaIterator) : ScyllaValue
      fun row_get_column = scylla_row_get_column(row : ScyllaRow, index : LibC::SizeT) : ScyllaValue
      fun row_get_column_by_name = scylla_row_get_column_by_name(row : ScyllaRow, name : LibC::Char*) : ScyllaValue
      fun row_get_column_by_name_n = scylla_row_get_column_by_name_n(row : ScyllaRow, name : LibC::Char*, name_length : LibC::SizeT) : ScyllaValue
      fun value_data_type = scylla_value_data_type(value : ScyllaValue) : ScyllaDataType
      fun value_get_int8 = scylla_value_get_int8(value : ScyllaValue, output : Int8T*) : ScyllaError
      fun value_get_int16 = scylla_value_get_int16(value : ScyllaValue, output : Int16T*) : ScyllaError
      fun value_get_int32 = scylla_value_get_int32(value : ScyllaValue, output : Int32T*) : ScyllaError
      fun value_get_uint32 = scylla_value_get_uint32(value : ScyllaValue, output : Uint32T*) : ScyllaError
      fun value_get_int64 = scylla_value_get_int64(value : ScyllaValue, output : Int64T*) : ScyllaError
      fun value_get_float = scylla_value_get_float(value : ScyllaValue, output : FloatT*) : ScyllaError
      fun value_get_double = scylla_value_get_double(value : ScyllaValue, output : DoubleT*) : ScyllaError
      fun value_get_bool = scylla_value_get_bool(value : ScyllaValue, output : BoolT*) : ScyllaError
      fun value_get_uuid = scylla_value_get_uuid(value : ScyllaValue, output : ScyllaUuid*) : ScyllaError
      fun value_get_inet = scylla_value_get_inet(value : ScyllaValue, output : ScyllaInet*) : ScyllaError
      fun value_get_string = scylla_value_get_string(value : ScyllaValue, output : LibC::Char**, output_size : LibC::SizeT*) : ScyllaError
      fun value_get_bytes = scylla_value_get_bytes(value : ScyllaValue, output : ByteT**, output_size : LibC::SizeT*) : ScyllaError
      fun value_get_decimal = scylla_value_get_decimal(value : ScyllaValue, varint : ByteT**, varint_size : LibC::SizeT*, scale : Int32T*) : ScyllaError
      fun value_get_duration = scylla_value_get_duration(value : ScyllaValue, months : Int32T*, days : Int32T*, nanos : Int64T*) : ScyllaError
      fun value_type = scylla_value_type(value : ScyllaValue) : ScyllaValueType
      fun value_is_null = scylla_value_is_null(value : ScyllaValue) : BoolT
      fun value_is_collection = scylla_value_is_collection(value : ScyllaValue) : BoolT
      fun value_is_duration = scylla_value_is_duration(value : ScyllaValue) : BoolT
      fun value_item_count = scylla_value_item_count(collection : ScyllaValue) : LibC::SizeT
      fun value_primary_sub_type = scylla_value_primary_sub_type(collection : ScyllaValue) : ScyllaValueType
      fun value_secondary_sub_type = scylla_value_secondary_sub_type(collection : ScyllaValue) : ScyllaValueType
      fun uuid_gen_new = scylla_uuid_gen_new : ScyllaUuidGen
      type ScyllaUuidGen = Void*
      fun uuid_gen_new_with_node = scylla_uuid_gen_new_with_node(node : Uint64T) : ScyllaUuidGen
      fun uuid_gen_free = scylla_uuid_gen_free(uuid_gen : ScyllaUuidGen)
      fun uuid_gen_time = scylla_uuid_gen_time(uuid_gen : ScyllaUuidGen, output : ScyllaUuid*)
      fun uuid_gen_random = scylla_uuid_gen_random(uuid_gen : ScyllaUuidGen, output : ScyllaUuid*)
      fun uuid_gen_from_time = scylla_uuid_gen_from_time(uuid_gen : ScyllaUuidGen, timestamp : Uint64T, output : ScyllaUuid*)
      fun uuid_min_from_time = scylla_uuid_min_from_time(time : Uint64T, output : ScyllaUuid*)
      fun uuid_max_from_time = scylla_uuid_max_from_time(time : Uint64T, output : ScyllaUuid*)
      fun uuid_timestamp = scylla_uuid_timestamp(uuid : ScyllaUuid) : Uint64T
      fun uuid_version = scylla_uuid_version(uuid : ScyllaUuid) : Uint8T
      fun uuid_string = scylla_uuid_string(uuid : ScyllaUuid, output : LibC::Char*)
      fun uuid_from_string = scylla_uuid_from_string(str : LibC::Char*, output : ScyllaUuid*) : ScyllaError
      fun uuid_from_string_n = scylla_uuid_from_string_n(str : LibC::Char*, str_length : LibC::SizeT, output : ScyllaUuid*) : ScyllaError
      fun timestamp_gen_server_side_new = scylla_timestamp_gen_server_side_new : ScyllaTimestampGen
      fun timestamp_gen_monotonic_new = scylla_timestamp_gen_monotonic_new : ScyllaTimestampGen
      fun timestamp_gen_monotonic_new_with_settings = scylla_timestamp_gen_monotonic_new_with_settings(warning_threshold_us : Int64T, warning_interval_ms : Int64T) : ScyllaTimestampGen
      fun timestamp_gen_free = scylla_timestamp_gen_free(timestamp_gen : ScyllaTimestampGen)
      fun retry_policy_default_new = scylla_retry_policy_default_new : ScyllaRetryPolicy
      fun retry_policy_downgrading_consistency_new = scylla_retry_policy_downgrading_consistency_new : ScyllaRetryPolicy
      fun retry_policy_fallthrough_new = scylla_retry_policy_fallthrough_new : ScyllaRetryPolicy
      fun retry_policy_logging_new = scylla_retry_policy_logging_new(child_retry_policy : ScyllaRetryPolicy) : ScyllaRetryPolicy
      fun retry_policy_free = scylla_retry_policy_free(policy : ScyllaRetryPolicy)
      fun custom_payload_new = scylla_custom_payload_new : ScyllaCustomPayload
      fun custom_payload_free = scylla_custom_payload_free(payload : ScyllaCustomPayload)
      fun custom_payload_set = scylla_custom_payload_set(payload : ScyllaCustomPayload, name : LibC::Char*, value : ByteT*, value_size : LibC::SizeT)
      fun custom_payload_set_n = scylla_custom_payload_set_n(payload : ScyllaCustomPayload, name : LibC::Char*, name_length : LibC::SizeT, value : ByteT*, value_size : LibC::SizeT)
      fun custom_payload_remove = scylla_custom_payload_remove(payload : ScyllaCustomPayload, name : LibC::Char*)
      fun custom_payload_remove_n = scylla_custom_payload_remove_n(payload : ScyllaCustomPayload, name : LibC::Char*, name_length : LibC::SizeT)
      fun consistency_string = scylla_consistency_string(consistency : ScyllaConsistency) : LibC::Char*
      fun write_type_string = scylla_write_type_string(write_type : ScyllaWriteType) : LibC::Char*
      fun error_desc = scylla_error_desc(error : ScyllaError) : LibC::Char*
      fun log_cleanup = scylla_log_cleanup
      fun log_set_level = scylla_log_set_level(log_level : ScyllaLogLevel)
      enum ScyllaLogLevel
        LogDisabled = 0
        LogCritical = 1
        LogError = 2
        LogWarn = 3
        LogInfo = 4
        LogDebug = 5
        LogTrace = 6
        LogLastEntry = 7
      end
      fun log_set_callback = scylla_log_set_callback(callback : ScyllaLogCallback, data : Void*)
      struct ScyllaLogMessage
        time_ms : Uint64T
        severity : ScyllaLogLevel
        file : LibC::Char*
        line : LibC::Int
        function : LibC::Char*
        message : LibC::Char[1024]
      end
      alias ScyllaLogCallback = (ScyllaLogMessage*, Void* -> Void)
      fun log_set_queue_size = scylla_log_set_queue_size(queue_size : LibC::SizeT)
      fun log_level_string = scylla_log_level_string(log_level : ScyllaLogLevel) : LibC::Char*
      fun inet_init_v4 = scylla_inet_init_v4(address : Uint8T*) : ScyllaInet
      fun inet_init_v6 = scylla_inet_init_v6(address : Uint8T*) : ScyllaInet
      fun inet_string = scylla_inet_string(inet : ScyllaInet, output : LibC::Char*)
      fun inet_from_string = scylla_inet_from_string(str : LibC::Char*, output : ScyllaInet*) : ScyllaError
      fun inet_from_string_n = scylla_inet_from_string_n(str : LibC::Char*, str_length : LibC::SizeT, output : ScyllaInet*) : ScyllaError
      fun date_from_epoch = scylla_date_from_epoch(epoch_secs : Int64T) : Uint32T
      fun time_from_epoch = scylla_time_from_epoch(epoch_secs : Int64T) : Int64T
      fun date_time_to_epoch = scylla_date_time_to_epoch(date : Uint32T, time : Int64T) : Int64T
      fun alloc_set_functions = scylla_alloc_set_functions(malloc_func : ScyllaMallocFunction, realloc_func : ScyllaReallocFunction, free_func : ScyllaFreeFunction)
      alias ScyllaMallocFunction = (LibC::SizeT -> Void*)
      alias ScyllaReallocFunction = (Void*, LibC::SizeT -> Void*)
      alias ScyllaFreeFunction = (Void* -> Void)
    end
  end