#insert into [node_util] select starttime, avg(unused) as unused, avg(used) as used from (select DATE_FORMAT(m.LAUNCH_TIME,'%Y-%m-%d %H:%i:%s') as starttime,sum(AvgCPUBusy*j.NumOfMachines/(60*100)) as unused,sum((100-AvgCPUBusy)*j.NumOfMachines/(60*100)) as used from HodJobDigest d join HodJob j on (d.HodID = j.HodID) join MRJob m on (m.HodID = j.HodID) where m.LAUNCH_TIME >= '2008-09-12 21:11' and m.LAUNCH_TIME <= '2008-09-12 22:11' and d.Timestamp >= m.LAUNCH_TIME and d.Timestamp <= m.FINISH_TIME group by m.MRJobID order by m.LAUNCH_TIME) as t group by t.starttime 
#insert into [jobtype_util] select CASE WHEN MRJobName like 'PigLatin%' THEN 'Pig' WHEN MRJobName like 'streamjob%' THEN 'Streaming' WHEN MRJobName like '%abacus%' THEN 'Abacus' ELSE 'Other' END as m, count(*)*j.NumOfMachines/60 as nodehours,count(distinct(MRJobID)) as jobs from HodJobDigest d join HodJob j on (d.HodID = j.HodID) join MRJob m on (m.HodID = j.HodID) where d.Timestamp >= '2008-09-12 21:11' and d.Timestamp <= '2008-09-12 22:11' and d.Timestamp >= m.LAUNCH_TIME and d.Timestamp <= m.FINISH_TIME group by CASE WHEN MRJobName like 'PigLatin%' THEN 'Pig' WHEN MRJobName like 'streamjob%' THEN 'Streaming' WHEN MRJobName like '%abacus%' THEN 'Abacus' ELSE 'Other' END order by CASE WHEN MRJobName like 'PigLatin%' THEN 'Pig' WHEN MRJobName like 'streamjob%' THEN 'Streaming' WHEN MRJobName like '%abacus%' THEN 'Abacus' ELSE 'Other' END
#insert into [a] select d.Timestamp as starttime,((AvgCPUBusy * j.NumOfMachines) / (sum(j.NumOfMachines) * 1)) as used from Digest d join HodJob j on (d.HodID = j.HodID) where d.Timestamp >= '[past_10_minutes]' and d.Timestamp <= '[now]' group by d.Timestamp order by d.Timestamp 
#insert into [b] select m, sum(foo.nodehours) as nodehours from (select m.MRJobID, round(avg(if(AvgCPUBusy is null,0,AvgCPUBusy)),0) as m, count(*)*j.NumOfMachines/60 as nodehours from HodJobDigest d join HodJob j on (d.HodID = j.HodID) join MRJob m on (m.HodID = j.HodID) where d.Timestamp >= '[past_10_minutes]' and d.Timestamp <= '[now]' and d.Timestamp >= m.LAUNCH_TIME and d.Timestamp <= m.FINISH_TIME group by m.MRJobID) as foo group by m; 
#insert into [c] select if(AvgCPUBusy is null,0,AvgCPUBusy) as m, CASE WHEN MRJobName like 'PigLatin%' THEN 'Pig' WHEN MRJobName like 'streamjob%' THEN 'Streaming' WHEN MRJobName like '%abacus%' THEN 'Abacus' ELSE 'Other' END as interface, count(*)*j.NumOfMachines/60 as nodehours,count(distinct(MRJobID)) as jobs from HodJobDigest d join HodJob j on (d.HodID = j.HodID) join MRJob m on (m.HodID = j.HodID) where d.Timestamp >= '[past_10_minutes]' and d.Timestamp <= '[now]' and d.Timestamp >= m.LAUNCH_TIME and d.Timestamp <= m.FINISH_TIME group by AvgCPUBusy,CASE WHEN MRJobName like 'PigLatin%' THEN 'Pig' WHEN MRJobName like 'streamjob%' THEN 'Streaming' WHEN MRJobName like '%abacus%' THEN 'Abacus' ELSE 'Other' END order by if(AvgCPUBusy is null,0,AvgCPUBusy)
#insert into [cluster_hadoop_mapred] (select [avg(hadoop_mapred_job)] from [hadoop_mapred_job] where timestamp between '[past_15_minutes]' and '[now]' group by timestamp);
replace into [cluster_system_metrics] (select [avg(system_metrics)] from [system_metrics] where timestamp between '[past_15_minutes]' and '[past_5_minutes]' group by timestamp);
set @ph='',@p_block_reports_num_ops:=0,@p_block_verification_failures:=0,@p_blocks_read:=0,@p_blocks_removed:=0,@p_blocks_replicated:=0,@p_blocks_verified:=0,@p_blocks_written:=0,@p_bytes_read:=0,@p_bytes_written:=0,@p_copy_block_op_num_ops:=0,@p_heart_beats_num_ops:=0,@p_read_block_op_num_ops:=0,@p_read_metadata_op_num_ops:=0,@p_reads_from_local_client:=0,@p_reads_from_remote_client:=0,@p_replace_block_op_num_ops:=0,@p_write_block_op_num_ops:=0,@p_writes_from_local_client:=0,@p_writes_from_remote_client:=0;
replace into [dfs_throughput] (select timestamp,count(host),avg(block_reports_avg_time),sum(block_reports_num_ops),sum(block_verification_failures),sum(blocks_read),sum(blocks_removed),sum(blocks_replicated),sum(blocks_verified),sum(blocks_written),sum(bytes_read),sum(bytes_written),avg(copy_block_op_avg_time),sum(copy_block_op_num_ops),avg(heart_beats_avg_time),sum(heart_beats_num_ops),avg(read_block_op_avg_time),sum(read_block_op_num_ops),avg(read_metadata_op_avg_time),sum(read_metadata_op_num_ops),sum(reads_from_local_client),sum(reads_from_remote_client),avg(replace_block_op_avg_time),sum(replace_block_op_num_ops),count(session_id),avg(write_block_op_avg_time),sum(write_block_op_num_ops),sum(writes_from_local_client),sum(writes_from_remote_client) from (select timestamp,host,block_reports_avg_time,case host when @ph then block_reports_num_ops-@p_block_reports_num_ops else 0 end as block_reports_num_ops, case host when @ph then block_verification_failures-@p_block_verification_failures else 0 end as block_verification_failures,case host when @ph then blocks_read-@p_blocks_read else 0 end as blocks_read,case host when @ph then blocks_removed-@p_blocks_removed else 0 end as blocks_removed,case host when @ph then blocks_replicated-@p_blocks_replicated else 0 end as blocks_replicated,case host when @ph then blocks_verified-@p_blocks_verified else 0 end as blocks_verified,case host when @ph then blocks_written-@p_blocks_written else 0 end as blocks_written,case host when @ph then bytes_read-@p_bytes_read else 0 end as bytes_read,case host when @ph then bytes_written-@p_bytes_written else 0 end as bytes_written,copy_block_op_avg_time,case host when @ph then copy_block_op_num_ops-@p_copy_block_op_num_ops else 0 end as copy_block_op_num_ops,heart_beats_avg_time,case host when @ph then heart_beats_num_ops-@p_heart_beats_num_ops else 0 end as heart_beats_num_ops,read_block_op_avg_time,case host when @ph then read_block_op_num_ops-@p_read_block_op_num_ops else 0 end as read_block_op_num_ops,read_metadata_op_avg_time,case host when @ph then read_metadata_op_num_ops-@p_read_metadata_op_num_ops else 0 end as read_metadata_op_num_ops,case host when @ph then reads_from_local_client-@p_reads_from_local_client else 0 end as reads_from_local_client,case host when @ph then reads_from_remote_client-@p_reads_from_remote_client else 0 end as reads_from_remote_client,replace_block_op_avg_time,case host when @ph then replace_block_op_num_ops-@p_replace_block_op_num_ops else 0 end as replace_block_op_num_ops,session_id,write_block_op_avg_time,case host when @ph then write_block_op_num_ops-@p_write_block_op_num_ops else 0 end as write_block_op_num_ops,case host when @ph then writes_from_local_client-@p_writes_from_local_client else 0 end as writes_from_local_client,case host when @ph then writes_from_remote_client-@p_writes_from_remote_client else 0 end as writes_from_remote_client,@ph:=host,@p_block_reports_num_ops:=block_reports_num_ops,@p_block_verification_failures:=block_verification_failures,@p_blocks_read:=blocks_read,@p_blocks_removed:=blocks_removed,@p_blocks_replicated:=blocks_replicated,@p_blocks_verified:=blocks_verified,@p_blocks_written:=blocks_written,@p_bytes_read:=bytes_read,@p_bytes_written:=bytes_written,@p_copy_block_op_num_ops:=copy_block_op_num_ops,@p_heart_beats_num_ops:=heart_beats_num_ops,@p_read_block_op_num_ops:=read_block_op_num_ops,@p_read_metadata_op_num_ops:=read_metadata_op_num_ops,@p_reads_from_local_client:=reads_from_local_client,@p_reads_from_remote_client:=reads_from_remote_client,@p_replace_block_op_num_ops:=replace_block_op_num_ops,@p_write_block_op_num_ops:=write_block_op_num_ops,@p_writes_from_local_client:=writes_from_local_client,@p_writes_from_remote_client:=writes_from_remote_client from [dfs_datanode] where timestamp between '[past_15_minutes]' and '[past_5_minutes]' group by host,timestamp) as a where timestamp!='[past_15_minutes]' group by timestamp);
replace into [cluster_disk] (select a.timestamp,a.mount,a.used,a.available,a.used_percent from (select from_unixtime(unix_timestamp(timestamp)-unix_timestamp(timestamp)%60)as timestamp,mount,avg(used) as used,avg(available) as available,avg(used_percent) as used_percent from [disk] where timestamp between '[past_15_minutes]' and '[past_5_minutes]' group by timestamp,mount) as a group by a.timestamp, a.mount);
#replace delayed into [hod_job_digest] (select timestamp,d.hodid,d.userid,[avg(system_metrics)] from (select a.HodID,b.host as machine,a.userid,a.starttime,a.endtime from [HodJob] a join [hod_machine] b on (a.HodID = b.HodID) where endtime between '[past_15_minutes]' and '[past_5_minutes]') as d,[system_metrics] where timestamp between d.starttime and d.endtime and host=d.machine group by hodid,timestamp);
replace into [cluster_hadoop_rpc] (select timestamp, count(host), avg(rpc_processing_time_avg_time), sum(rpc_processing_time_num_ops), avg(rpc_queue_time_avg_time), sum(rpc_queue_time_num_ops), avg(get_build_version_avg_time), sum(get_build_version_num_ops), avg(get_job_counters_avg_time), sum(get_job_counters_num_ops), avg(get_job_profile_avg_time), sum(get_job_profile_num_ops), avg(get_job_status_avg_time), sum(get_job_status_num_ops), avg(get_new_job_id_avg_time), sum(get_new_job_id_num_ops), avg(get_protocol_version_avg_time), sum(get_protocol_version_num_ops), avg(get_system_dir_avg_time), sum(get_system_dir_num_ops), avg(get_task_completion_events_avg_time), sum(get_task_completion_events_num_ops), avg(get_task_diagnostics_avg_time), sum(get_task_diagnostics_num_ops), avg(heartbeat_avg_time), sum(heartbeat_num_ops), avg(killJob_avg_time), sum(killJob_num_ops), avg(submit_job_avg_time), sum(submit_job_num_ops) from [hadoop_rpc] where timestamp between '[past_15_minutes]' and '[past_5_minutes]' group by timestamp);
#replace into [user_util] (select timestamp, j.UserID as user, sum(j.NumOfMachines) as node_total, sum(cpu_idle_pcnt*j.NumOfMachines) as cpu_unused, sum((cpu_user_pcnt+cpu_system_pcnt)*j.NumOfMachines) as cpu_used, avg(cpu_user_pcnt+cpu_system_pcnt) as cpu_used_pcnt, sum((100-(sda_busy_pcnt+sdb_busy_pcnt+sdc_busy_pcnt+sdd_busy_pcnt)/4)*j.NumOfMachines) as disk_unused, sum(((sda_busy_pcnt+sdb_busy_pcnt+sdc_busy_pcnt+sdd_busy_pcnt)/4)*j.NumOfMachines) as disk_used, avg(((sda_busy_pcnt+sdb_busy_pcnt+sdc_busy_pcnt+sdd_busy_pcnt)/4)) as disk_used_pcnt, sum((100-eth0_busy_pcnt)*j.NumOfMachines) as network_unused, sum(eth0_busy_pcnt*j.NumOfMachines) as network_used, avg(eth0_busy_pcnt) as network_used_pcnt, sum((100-mem_used_pcnt)*j.NumOfMachines) as memory_unused, sum(mem_used_pcnt*j.NumOfMachines) as memory_used, avg(mem_used_pcnt) as memory_used_pcnt from [hod_job_digest] d,[HodJob] j where (d.HodID = j.HodID) and Timestamp between '[past_15_minutes]' and '[past_5_minutes]' group by j.UserID);
replace into [util] (select [hdfs_usage].timestamp as timestamp, mr_usage.user, queue, sum(bytes) as bytes, sum(slot_time)/3600 as slot_hours from [hdfs_usage], (select job.finish_time as timestamp,job.user,queue,sum(([mr_task].finish_time-[mr_task].start_time)*[mr_task].attempts) as slot_time from [mr_task],  (select job_id,user,queue,launch_time,finish_time from [mr_job] where finish_time between '[past_20_minutes]' and '[now]') as job  where [mr_task].job_id=job.job_id group by floor(unix_timestamp(timestamp)/3600),user,queue) as mr_usage where mr_usage.user=[hdfs_usage].user and [hdfs_usage].timestamp between '[past_20_minutes]' and '[now]' group by floor(unix_timestamp([hdfs_usage].timestamp)/3600), user);
#
# Down sample metrics for charts
replace into [system_metrics_month] (select [group_avg(system_metrics)] from [system_metrics_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),host);
replace into [system_metrics_quarter] (select [group_avg(system_metrics)] from [system_metrics_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),host);
replace into [system_metrics_year] (select [group_avg(system_metrics)] from [system_metrics_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),host);
replace into [system_metrics_decade] (select [group_avg(system_metrics)] from [system_metrics_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),host);
#
replace into [dfs_namenode_month] (select [group_avg(dfs_namenode)] from [dfs_namenode_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),host);
replace into [dfs_namenode_quarter] (select [group_avg(dfs_namenode)] from [dfs_namenode_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),host);
replace into [dfs_namenode_year] (select [group_avg(dfs_namenode)] from [dfs_namenode_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),host);
replace into [dfs_namenode_decade] (select [group_avg(dfs_namenode)] from [dfs_namenode_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),host);
#
replace into [dfs_datanode_month] (select [group_avg(dfs_datanode)] from [dfs_datanode_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),host);
replace into [dfs_datanode_quarter] (select [group_avg(dfs_datanode)] from [dfs_datanode_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),host);
replace into [dfs_datanode_year] (select [group_avg(dfs_datanode)] from [dfs_datanode_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),host);
replace into [dfs_datanode_decade] (select [group_avg(dfs_datanode)] from [dfs_datanode_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),host);
#
replace into [hadoop_rpc_month] (select [group_avg(hadoop_rpc)] from [hadoop_rpc_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),host);
replace into [hadoop_rpc_quarter] (select [group_avg(hadoop_rpc)] from [hadoop_rpc_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),host);
replace into [hadoop_rpc_year] (select [group_avg(hadoop_rpc)] from [hadoop_rpc_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),host);
replace into [hadoop_rpc_decade] (select [group_avg(hadoop_rpc)]	from [hadoop_rpc_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),host);
#
replace into [cluster_hadoop_rpc_month] (select [avg(cluster_hadoop_rpc)] from [cluster_hadoop_rpc_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300));
replace into [cluster_hadoop_rpc_quarter] (select [avg(cluster_hadoop_rpc)] from [cluster_hadoop_rpc_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800));
replace into [cluster_hadoop_rpc_year] (select [avg(cluster_hadoop_rpc)] from [cluster_hadoop_rpc_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800));
replace into [cluster_hadoop_rpc_decade] (select [avg(cluster_hadoop_rpc)] from [cluster_hadoop_rpc_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200));
#
replace into [hadoop_mapred_month] (select [group_avg(hadoop_mapred)] from [hadoop_mapred_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),host);
replace into [hadoop_mapred_quarter] (select [group_avg(hadoop_mapred)] from [hadoop_mapred_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),host);
replace into [hadoop_mapred_year] (select [group_avg(hadoop_mapred)] from [hadoop_mapred_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),host);
replace into [hadoop_mapred_decade] (select [group_avg(hadoop_mapred)] from [hadoop_mapred_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),host);
#
replace into [hadoop_jvm_month] (select [group_avg(hadoop_jvm)] from [hadoop_jvm_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),host,process_name);
replace into [hadoop_jvm_quarter] (select [group_avg(hadoop_jvm)] from [hadoop_jvm_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),host,process_name);
replace into [hadoop_jvm_year] (select [group_avg(hadoop_jvm)] from [hadoop_jvm_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),host,process_name);
replace into [hadoop_jvm_decade] (select [group_avg(hadoop_jvm)] from [hadoop_jvm_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),host,process_name);
#
replace into [dfs_throughput_month] (select [avg(dfs_throughput)] from [dfs_throughput_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300));
replace into [dfs_throughput_quarter] (select [avg(dfs_throughput)] from [dfs_throughput_month] where timestamp between '[past_180_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800));
replace into [dfs_throughput_year] (select [avg(dfs_throughput)]	from [dfs_throughput_quarter] where timestamp between '[past_1080_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800));
replace into [dfs_throughput_decade] (select [avg(dfs_throughput)] from [dfs_throughput_year] where timestamp between '[past_4320_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200));
#
replace into [node_activity_month] (select [avg(node_activity)] from [node_activity_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300));
replace into [node_activity_quarter] (select [avg(node_activity)] from [node_activity_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800));
replace into [node_activity_year] (select [avg(node_activity)] from [node_activity_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800));
replace into [node_activity_decade] (select [avg(node_activity)] from [node_activity_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200));
#
replace into [dfs_fsnamesystem_month] (select [group_avg(dfs_fsnamesystem)] from [dfs_fsnamesystem_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),host);
replace into [dfs_fsnamesystem_quarter] (select [group_avg(dfs_fsnamesystem)] from [dfs_fsnamesystem_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),host);
replace into [dfs_fsnamesystem_year] (select [group_avg(dfs_fsnamesystem)] from [dfs_fsnamesystem_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),host);
replace into [dfs_fsnamesystem_decade] (select [group_avg(dfs_fsnamesystem)] from [dfs_fsnamesystem_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),host);
#
replace into [disk_month] (select [group_avg(disk)] from [disk_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),host,mount);
replace into [disk_quarter] (select [group_avg(disk)] from [disk_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),host,mount);
replace into [disk_year] (select [group_avg(disk)] from [disk_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),host,mount);
replace into [disk_decade] (select [group_avg(disk)] from [disk_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),host,mount);
#
replace into [cluster_disk_month] (select [group_avg(cluster_disk)] from [cluster_disk_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),mount);
replace into [cluster_disk_quarter] (select [group_avg(cluster_disk)] from [cluster_disk_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),mount);
replace into [cluster_disk_year] (select [group_avg(cluster_disk)] from [cluster_disk_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),mount);
replace into [cluster_disk_decade] (select [group_avg(cluster_disk)] from [cluster_disk_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),mount);
#
replace into [cluster_system_metrics_month] (select [avg(cluster_system_metrics)] from [cluster_system_metrics_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300));
replace into [cluster_system_metrics_quarter] (select [avg(cluster_system_metrics)] from [cluster_system_metrics_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800));
replace into [cluster_system_metrics_year] (select [avg(cluster_system_metrics)] from [cluster_system_metrics_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800));
replace into [cluster_system_metrics_decade] (select [avg(cluster_system_metrics)] from [cluster_system_metrics_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200));
#
#replace into [hod_job_digest_month] (select [group_avg(hod_job_digest)] from [hod_job_digest_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),HodID);
#replace into [hod_job_digest_quarter] (select [group_avg(hod_job_digest)] from [hod_job_digest_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),HodID);
#replace into [hod_job_digest_year] (select [group_avg(hod_job_digest)] from [hod_job_digest_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),HodID);
#replace into [hod_job_digest_decade] (select [group_avg(hod_job_digest)] from [hod_job_digest_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),HodID);
#
#replace into [user_util_month] (select [group_avg(user_util)] from [user_util_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/300),user);
#replace into [user_util_quarter] (select [group_avg(user_util)] from [user_util_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),user);
#replace into [user_util_year] (select [group_avg(user_util)] from [user_util_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),user);
#replace into [user_util_decade] (select [group_avg(user_util)] from [user_util_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),user);
#
replace into [mr_job_month] (select * from [mr_job_week] where finish_time between '[past_15_minutes]' and '[now]');
replace into [mr_job_quarter] (select * from [mr_job_week] where finish_time between '[past_15_minutes]' and '[now]');
replace into [mr_job_year] (select * from [mr_job_week] where finish_time between '[past_15_minutes]' and '[now]');
replace into [mr_job_decade] (select * from [mr_job_week] where finish_time between '[past_15_minutes]' and '[now]');
#
replace into [mr_task_month] (select * from [mr_task_week] where finish_time between '[past_15_minutes]' and '[now]');
replace into [mr_task_quarter] (select * from [mr_task_week] where finish_time between '[past_15_minutes]' and '[now]');
replace into [mr_task_year] (select * from [mr_task_week] where finish_time between '[past_15_minutes]' and '[now]');
replace into [mr_task_decade] (select * from [mr_task_week] where finish_time between '[past_15_minutes]' and '[now]');
#
replace into [util_month] (select timestamp,user,queue,bytes,slot_hours from [util_week] where timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/600),user);
replace into [util_quarter] (select timestamp,user,queue,sum(bytes)/3,sum(slot_hours)/3 from [util_month] where timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/1800),user);
replace into [util_year] (select timestamp,user,queue,sum(bytes)/8,sum(slot_hours)/8 from [util_quarter] where timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/10800),user);
replace into [util_decade] (select timestamp,user,queue,sum(bytes)/4,sum(slot_hours)/4 from [util_year] where timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(Timestamp)/43200),user);
#
replace into [chunkqueue_month] (select chukwa_timestamp,recordname,hostname,contextname,AVG(removedchunk),avg(queuesize),AVG(removedchunk_raw),AVG(datasize),AVG(fullqueue),avg(addedchunk_rate),AVG(addedchunk_raw),AVG(period),AVG(addedchunk),avg(removedchunk_rate)  from [chunkqueue_week] where chukwa_timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/300),recordname,hostname,contextname);
replace into [chunkqueue_quarter] (select chukwa_timestamp,recordname,hostname,contextname,AVG(removedchunk),avg(queuesize),AVG(removedchunk_raw),AVG(datasize),AVG(fullqueue),avg(addedchunk_rate),AVG(addedchunk_raw),AVG(period),AVG(addedchunk),avg(removedchunk_rate)  from [chunkqueue_month] where chukwa_timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/1800),recordname,hostname,contextname);
replace into [chunkqueue_year] (select chukwa_timestamp,recordname,hostname,contextname,AVG(removedchunk),avg(queuesize),AVG(removedchunk_raw),AVG(datasize),AVG(fullqueue),avg(addedchunk_rate),AVG(addedchunk_raw),AVG(period),AVG(addedchunk),avg(removedchunk_rate)  from [chunkqueue_quarter] where chukwa_timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/10800),recordname,hostname,contextname);
replace into [chunkqueue_decade] (select chukwa_timestamp,recordname,hostname,contextname,AVG(removedchunk),avg(queuesize),AVG(removedchunk_raw),AVG(datasize),AVG(fullqueue),avg(addedchunk_rate),AVG(addedchunk_raw),AVG(period),AVG(addedchunk),avg(removedchunk_rate)  from [chunkqueue_year] where chukwa_timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/43200),recordname,hostname,contextname);
#
replace into [chukwaagent_month] (select chukwa_timestamp,recordname,hostname,contextname,avg(addedadaptor_rate),avg(addedadaptor_raw),avg(removedadaptor_rate),avg(removedadaptor),avg(period),avg(adaptorcount),avg(removedadaptor_raw),avg(process),avg(addedadaptor)  from [chukwaagent_week] where chukwa_timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/300),recordname,hostname,contextname);
replace into [chukwaagent_quarter] (select chukwa_timestamp,recordname,hostname,contextname,avg(addedadaptor_rate),avg(addedadaptor_raw),avg(removedadaptor_rate),avg(removedadaptor),avg(period),avg(adaptorcount),avg(removedadaptor_raw),avg(process),avg(addedadaptor)  from [chukwaagent_month] where chukwa_timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/1800),recordname,hostname,contextname);
replace into [chukwaagent_year] (select chukwa_timestamp,recordname,hostname,contextname,avg(addedadaptor_rate),avg(addedadaptor_raw),avg(removedadaptor_rate),avg(removedadaptor),avg(period),avg(adaptorcount),avg(removedadaptor_raw),avg(process),avg(addedadaptor)  from [chukwaagent_quarter] where chukwa_timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/10800),recordname,hostname,contextname);
replace into [chukwaagent_decade] (select chukwa_timestamp,recordname,hostname,contextname,avg(addedadaptor_rate),avg(addedadaptor_raw),avg(removedadaptor_rate),avg(removedadaptor),avg(period),avg(adaptorcount),avg(removedadaptor_raw),avg(process),avg(addedadaptor)  from [chukwaagent_year] where chukwa_timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/43200),recordname,hostname,contextname);
#
replace into [chukwahttpsender_month] (select chukwa_timestamp,recordname,hostname,contextname,avg(httppost_rate),avg(httpthrowable_raw),avg(httpexception_rate),avg(httpthrowable),avg(httpthrowable_rate),avg(collectorrollover_rate),avg(httppost_raw),avg(period),avg(httpexception_raw),avg(httppost),avg(httptimeoutexception),avg(httptimeoutexception_raw),avg(collectorrollover_raw),avg(collectorrollover),avg(httptimeoutexception_rate),avg(httpexception)  from [chukwahttpsender_week] where chukwa_timestamp between '[past_15_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/300),recordname,hostname,contextname);
replace into [chukwahttpsender_quarter] (select chukwa_timestamp,recordname,hostname,contextname,avg(httppost_rate),avg(httpthrowable_raw),avg(httpexception_rate),avg(httpthrowable),avg(httpthrowable_rate),avg(collectorrollover_rate),avg(httppost_raw),avg(period),avg(httpexception_raw),avg(httppost),avg(httptimeoutexception),avg(httptimeoutexception_raw),avg(collectorrollover_raw),avg(collectorrollover),avg(httptimeoutexception_rate),avg(httpexception)  from [chukwahttpsender_month] where chukwa_timestamp between '[past_90_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/1800),recordname,hostname,contextname);
replace into [chukwahttpsender_year] (select chukwa_timestamp,recordname,hostname,contextname,avg(httppost_rate),avg(httpthrowable_raw),avg(httpexception_rate),avg(httpthrowable),avg(httpthrowable_rate),avg(collectorrollover_rate),avg(httppost_raw),avg(period),avg(httpexception_raw),avg(httppost),avg(httptimeoutexception),avg(httptimeoutexception_raw),avg(collectorrollover_raw),avg(collectorrollover),avg(httptimeoutexception_rate),avg(httpexception)  from [chukwahttpsender_quarter] where chukwa_timestamp between '[past_540_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/10800),recordname,hostname,contextname);
replace into [chukwahttpsender_decade] (select chukwa_timestamp,recordname,hostname,contextname,avg(httppost_rate),avg(httpthrowable_raw),avg(httpexception_rate),avg(httpthrowable),avg(httpthrowable_rate),avg(collectorrollover_rate),avg(httppost_raw),avg(period),avg(httpexception_raw),avg(httppost),avg(httptimeoutexception),avg(httptimeoutexception_raw),avg(collectorrollover_raw),avg(collectorrollover),avg(httptimeoutexception_rate),avg(httpexception)  from [chukwahttpsender_year] where chukwa_timestamp between '[past_2160_minutes]' and '[now]' group by FLOOR(UNIX_TIMESTAMP(chukwa_timestamp)/43200),recordname,hostname,contextname);

replace into [mr_job_conf_month] (select * from [mr_job_conf_week] where ts between '[past_15_minutes]' and '[now]');
replace into [mr_job_conf_quarter] (select * from [mr_job_conf_week] where ts between '[past_15_minutes]' and '[now]');
replace into [mr_job_conf_year] (select * from [mr_job_conf_week] where ts between '[past_15_minutes]' and '[now]');
replace into [mr_job_conf_decade] (select * from [mr_job_conf_week] where ts between '[past_15_minutes]' and '[now]');

replace into [user_job_summary_month] (select FLOOR(UNIX_TIMESTAMP(timestamp)/300),userid, sum(totalJobs), sum(dataLocalMaps), sum(rackLoaclMaps), sum(removeMaps), sum(mapInputBytes), sum(reduceOutputRecords), sum(mapSlotHours), sum(reduceSlotHours), sum(totalMaps), sum(totalReduces) from [user_job_summary_week] where ts between '[past_15_minutes]' and '[now]') group by FLOOR(UNIX_TIMESTAMP(timestamp)/300),userid);
replace into [user_job_summary_quarter] (select FLOOR(UNIX_TIMESTAMP(timestamp)/1800),userid, sum(totalJobs), sum(dataLocalMaps), sum(rackLoaclMaps), sum(removeMaps), sum(mapInputBytes), sum(reduceOutputRecords), sum(mapSlotHours), sum(reduceSlotHours), sum(totalMaps), sum(totalReduces) from [user_job_summary_week] where ts between '[past_90_minutes]' and '[now]') group by FLOOR(UNIX_TIMESTAMP(timestamp)/1800),userid);
replace into [user_job_summary_year] (select FLOOR(UNIX_TIMESTAMP(timestamp)/10800),userid, sum(totalJobs), sum(dataLocalMaps), sum(rackLoaclMaps), sum(removeMaps), sum(mapInputBytes), sum(reduceOutputRecords), sum(mapSlotHours), sum(reduceSlotHours), sum(totalMaps), sum(totalReduces) from [user_job_summary_week] where ts between '[past_540_minutes]' and '[now]') group by FLOOR(UNIX_TIMESTAMP(timestamp)/10800),userid);
replace into [user_job_summary_decade] (select FLOOR(UNIX_TIMESTAMP(timestamp)/43200),userid, sum(totalJobs), sum(dataLocalMaps), sum(rackLoaclMaps), sum(removeMaps), sum(mapInputBytes), sum(reduceOutputRecords), sum(mapSlotHours), sum(reduceSlotHours), sum(totalMaps), sum(totalReduces) from [user_job_summary_week] where ts between '[past_2160_minutes]' and '[now]') group by FLOOR(UNIX_TIMESTAMP(timestamp)/43200),userid);
