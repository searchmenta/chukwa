/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.hadoop.chukwa.rest.objects;

// Generated May 28, 2009 3:39:53 PM by Hibernate Tools 3.2.4.GA
import java.sql.Timestamp;

/**
 * HadoopRpc generated by hbm2java
 */
public class HadoopRpc implements java.io.Serializable {
    static final long serialVersionUID = -3494635921225579072L;

    private Timestamp timestamp;
    private String host;
    private Double rpcProcessingTimeAvgTime;
    private Double rpcProcessingTimeNumOps;
    private Double rpcQueueTimeAvgTime;
    private Double rpcQueueTimeNumOps;
    private Double getBuildVersionAvgTime;
    private Double getBuildVersionNumOps;
    private Double getJobCountersAvgTime;
    private Double getJobCountersNumOps;
    private Double getJobProfileAvgTime;
    private Double getJobProfileNumOps;
    private Double getJobStatusAvgTime;
    private Double getJobStatusNumOps;
    private Double getNewJobIdAvgTime;
    private Double getNewJobIdNumOps;
    private Double getProtocolVersionAvgTime;
    private Double getProtocolVersionNumOps;
    private Double getSystemDirAvgTime;
    private Double getSystemDirNumOps;
    private Double getTaskCompletionEventsAvgTime;
    private Double getTaskCompletionEventsNumOps;
    private Double getTaskDiagnosticsAvgTime;
    private Double getTaskDiagnosticsNumOps;
    private Double heartbeatAvgTime;
    private Double heartbeatNumOps;
    private Double killJobAvgTime;
    private Double killJobNumOps;
    private Double submitJobAvgTime;
    private Double submitJobNumOps;

    public HadoopRpc() {
    }

    public HadoopRpc(Timestamp timestampe,
		     String host,
		     Double rpcProcessingTimeAvgTime, Double rpcProcessingTimeNumOps,
		     Double rpcQueueTimeAvgTime, Double rpcQueueTimeNumOps,
		     Double getBuildVersionAvgTime, Double getBuildVersionNumOps,
		     Double getJobCountersAvgTime, Double getJobCountersNumOps,
		     Double getJobProfileAvgTime, Double getJobProfileNumOps,
		     Double getJobStatusAvgTime, Double getJobStatusNumOps,
		     Double getNewJobIdAvgTime, Double getNewJobIdNumOps,
		     Double getProtocolVersionAvgTime, Double getProtocolVersionNumOps,
		     Double getSystemDirAvgTime, Double getSystemDirNumOps,
		     Double getTaskCompletionEventsAvgTime,
		     Double getTaskCompletionEventsNumOps,
		     Double getTaskDiagnosticsAvgTime, Double getTaskDiagnosticsNumOps,
		     Double heartbeatAvgTime, Double heartbeatNumOps,
		     Double killJobAvgTime, Double killJobNumOps,
		     Double submitJobAvgTime, Double submitJobNumOps) {
	this.timestamp=timestamp;
	this.host=host;
	this.rpcProcessingTimeAvgTime = rpcProcessingTimeAvgTime;
	this.rpcProcessingTimeNumOps = rpcProcessingTimeNumOps;
	this.rpcQueueTimeAvgTime = rpcQueueTimeAvgTime;
	this.rpcQueueTimeNumOps = rpcQueueTimeNumOps;
	this.getBuildVersionAvgTime = getBuildVersionAvgTime;
	this.getBuildVersionNumOps = getBuildVersionNumOps;
	this.getJobCountersAvgTime = getJobCountersAvgTime;
	this.getJobCountersNumOps = getJobCountersNumOps;
	this.getJobProfileAvgTime = getJobProfileAvgTime;
	this.getJobProfileNumOps = getJobProfileNumOps;
	this.getJobStatusAvgTime = getJobStatusAvgTime;
	this.getJobStatusNumOps = getJobStatusNumOps;
	this.getNewJobIdAvgTime = getNewJobIdAvgTime;
	this.getNewJobIdNumOps = getNewJobIdNumOps;
	this.getProtocolVersionAvgTime = getProtocolVersionAvgTime;
	this.getProtocolVersionNumOps = getProtocolVersionNumOps;
	this.getSystemDirAvgTime = getSystemDirAvgTime;
	this.getSystemDirNumOps = getSystemDirNumOps;
	this.getTaskCompletionEventsAvgTime = getTaskCompletionEventsAvgTime;
	this.getTaskCompletionEventsNumOps = getTaskCompletionEventsNumOps;
	this.getTaskDiagnosticsAvgTime = getTaskDiagnosticsAvgTime;
	this.getTaskDiagnosticsNumOps = getTaskDiagnosticsNumOps;
	this.heartbeatAvgTime = heartbeatAvgTime;
	this.heartbeatNumOps = heartbeatNumOps;
	this.killJobAvgTime = killJobAvgTime;
	this.killJobNumOps = killJobNumOps;
	this.submitJobAvgTime = submitJobAvgTime;
	this.submitJobNumOps = submitJobNumOps;
    }

    public Timestamp getTimestamp() {
	return this.timestamp;
    }

    public void setTimestamp(Timestamp timestamp) {
	this.timestamp=timestamp;
    }

    public String getHost() {
	return this.host;
    }

    public void setHost(String host) {
	this.host=host;
    }


    public Double getRpcProcessingTimeAvgTime() {
	return this.rpcProcessingTimeAvgTime;
    }

    public void setRpcProcessingTimeAvgTime(Double rpcProcessingTimeAvgTime) {
	this.rpcProcessingTimeAvgTime = rpcProcessingTimeAvgTime;
    }

    public Double getRpcProcessingTimeNumOps() {
	return this.rpcProcessingTimeNumOps;
    }

    public void setRpcProcessingTimeNumOps(Double rpcProcessingTimeNumOps) {
	this.rpcProcessingTimeNumOps = rpcProcessingTimeNumOps;
    }

    public Double getRpcQueueTimeAvgTime() {
	return this.rpcQueueTimeAvgTime;
    }

    public void setRpcQueueTimeAvgTime(Double rpcQueueTimeAvgTime) {
	this.rpcQueueTimeAvgTime = rpcQueueTimeAvgTime;
    }

    public Double getRpcQueueTimeNumOps() {
	return this.rpcQueueTimeNumOps;
    }

    public void setRpcQueueTimeNumOps(Double rpcQueueTimeNumOps) {
	this.rpcQueueTimeNumOps = rpcQueueTimeNumOps;
    }

    public Double getGetBuildVersionAvgTime() {
	return this.getBuildVersionAvgTime;
    }

    public void setGetBuildVersionAvgTime(Double getBuildVersionAvgTime) {
	this.getBuildVersionAvgTime = getBuildVersionAvgTime;
    }

    public Double getGetBuildVersionNumOps() {
	return this.getBuildVersionNumOps;
    }

    public void setGetBuildVersionNumOps(Double getBuildVersionNumOps) {
	this.getBuildVersionNumOps = getBuildVersionNumOps;
    }

    public Double getGetJobCountersAvgTime() {
	return this.getJobCountersAvgTime;
    }

    public void setGetJobCountersAvgTime(Double getJobCountersAvgTime) {
	this.getJobCountersAvgTime = getJobCountersAvgTime;
    }

    public Double getGetJobCountersNumOps() {
	return this.getJobCountersNumOps;
    }

    public void setGetJobCountersNumOps(Double getJobCountersNumOps) {
	this.getJobCountersNumOps = getJobCountersNumOps;
    }

    public Double getGetJobProfileAvgTime() {
	return this.getJobProfileAvgTime;
    }

    public void setGetJobProfileAvgTime(Double getJobProfileAvgTime) {
	this.getJobProfileAvgTime = getJobProfileAvgTime;
    }

    public Double getGetJobProfileNumOps() {
	return this.getJobProfileNumOps;
    }

    public void setGetJobProfileNumOps(Double getJobProfileNumOps) {
	this.getJobProfileNumOps = getJobProfileNumOps;
    }

    public Double getGetJobStatusAvgTime() {
	return this.getJobStatusAvgTime;
    }

    public void setGetJobStatusAvgTime(Double getJobStatusAvgTime) {
	this.getJobStatusAvgTime = getJobStatusAvgTime;
    }

    public Double getGetJobStatusNumOps() {
	return this.getJobStatusNumOps;
    }

    public void setGetJobStatusNumOps(Double getJobStatusNumOps) {
	this.getJobStatusNumOps = getJobStatusNumOps;
    }

    public Double getGetNewJobIdAvgTime() {
	return this.getNewJobIdAvgTime;
    }

    public void setGetNewJobIdAvgTime(Double getNewJobIdAvgTime) {
	this.getNewJobIdAvgTime = getNewJobIdAvgTime;
    }

    public Double getGetNewJobIdNumOps() {
	return this.getNewJobIdNumOps;
    }

    public void setGetNewJobIdNumOps(Double getNewJobIdNumOps) {
	this.getNewJobIdNumOps = getNewJobIdNumOps;
    }

    public Double getGetProtocolVersionAvgTime() {
	return this.getProtocolVersionAvgTime;
    }

    public void setGetProtocolVersionAvgTime(Double getProtocolVersionAvgTime) {
	this.getProtocolVersionAvgTime = getProtocolVersionAvgTime;
    }

    public Double getGetProtocolVersionNumOps() {
	return this.getProtocolVersionNumOps;
    }

    public void setGetProtocolVersionNumOps(Double getProtocolVersionNumOps) {
	this.getProtocolVersionNumOps = getProtocolVersionNumOps;
    }

    public Double getGetSystemDirAvgTime() {
	return this.getSystemDirAvgTime;
    }

    public void setGetSystemDirAvgTime(Double getSystemDirAvgTime) {
	this.getSystemDirAvgTime = getSystemDirAvgTime;
    }

    public Double getGetSystemDirNumOps() {
	return this.getSystemDirNumOps;
    }

    public void setGetSystemDirNumOps(Double getSystemDirNumOps) {
	this.getSystemDirNumOps = getSystemDirNumOps;
    }

    public Double getGetTaskCompletionEventsAvgTime() {
	return this.getTaskCompletionEventsAvgTime;
    }

    public void setGetTaskCompletionEventsAvgTime(
						  Double getTaskCompletionEventsAvgTime) {
	this.getTaskCompletionEventsAvgTime = getTaskCompletionEventsAvgTime;
    }

    public Double getGetTaskCompletionEventsNumOps() {
	return this.getTaskCompletionEventsNumOps;
    }

    public void setGetTaskCompletionEventsNumOps(
						 Double getTaskCompletionEventsNumOps) {
	this.getTaskCompletionEventsNumOps = getTaskCompletionEventsNumOps;
    }

    public Double getGetTaskDiagnosticsAvgTime() {
	return this.getTaskDiagnosticsAvgTime;
    }

    public void setGetTaskDiagnosticsAvgTime(Double getTaskDiagnosticsAvgTime) {
	this.getTaskDiagnosticsAvgTime = getTaskDiagnosticsAvgTime;
    }

    public Double getGetTaskDiagnosticsNumOps() {
	return this.getTaskDiagnosticsNumOps;
    }

    public void setGetTaskDiagnosticsNumOps(Double getTaskDiagnosticsNumOps) {
	this.getTaskDiagnosticsNumOps = getTaskDiagnosticsNumOps;
    }

    public Double getHeartbeatAvgTime() {
	return this.heartbeatAvgTime;
    }

    public void setHeartbeatAvgTime(Double heartbeatAvgTime) {
	this.heartbeatAvgTime = heartbeatAvgTime;
    }

    public Double getHeartbeatNumOps() {
	return this.heartbeatNumOps;
    }

    public void setHeartbeatNumOps(Double heartbeatNumOps) {
	this.heartbeatNumOps = heartbeatNumOps;
    }

    public Double getKillJobAvgTime() {
	return this.killJobAvgTime;
    }

    public void setKillJobAvgTime(Double killJobAvgTime) {
	this.killJobAvgTime = killJobAvgTime;
    }

    public Double getKillJobNumOps() {
	return this.killJobNumOps;
    }

    public void setKillJobNumOps(Double killJobNumOps) {
	this.killJobNumOps = killJobNumOps;
    }

    public Double getSubmitJobAvgTime() {
	return this.submitJobAvgTime;
    }

    public void setSubmitJobAvgTime(Double submitJobAvgTime) {
	this.submitJobAvgTime = submitJobAvgTime;
    }

    public Double getSubmitJobNumOps() {
	return this.submitJobNumOps;
    }

    public void setSubmitJobNumOps(Double submitJobNumOps) {
	this.submitJobNumOps = submitJobNumOps;
    }

}
