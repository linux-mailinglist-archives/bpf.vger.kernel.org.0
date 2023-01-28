Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D8767F2B8
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjA1AHz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjA1AHo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:44 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE18CC4A
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 16:07:36 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RMN99L037302;
        Sat, 28 Jan 2023 00:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8GfHZxvULSNO4iTwmZyWA5D/3kpSnomXXnRqGO2bucs=;
 b=srU5dOaHazA9u0ms9gomkE8mcAYFY1R6W6NoSvxR2IdpQ2n/5OeBhIxVr0l6NGNCk0oj
 +hQQzMYCdITkZDKWK1lGDK2UpCu7EV8GpybWVuol4xA0Yw3yhihteQqAtHS4rERN4xFy
 8YiVFAtqW0Y94nt0cBIYp3t8C7BgyY3KJWclZblin8b6LqZMGUd1k7DIH6X4IdrPJ19X
 BOx9PmKf1Po1Sp1hsk/F/YBCUqhFoTykgXApxAPSkoQN9r3mKa6IthviaEXMWuJLGGmE
 APxgX0kfBOk9NOMOptcmgdgy7Ag7P49jQCJnPWQ53PjdmT6GLKr4g7RTb73JqtH/jyki JQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncm3tecbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:23 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFItv6016228;
        Sat, 28 Jan 2023 00:07:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dtkt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Jan 2023 00:07:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30S07ILu43450712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 28 Jan 2023 00:07:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 504712004B;
        Sat, 28 Jan 2023 00:07:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C77C220043;
        Sat, 28 Jan 2023 00:07:17 +0000 (GMT)
Received: from heavy.ibmuc.com (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 28 Jan 2023 00:07:17 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH bpf-next v2 20/31] selftests/bpf: Fix profiler on s390x
Date:   Sat, 28 Jan 2023 01:06:39 +0100
Message-Id: <20230128000650.1516334-21-iii@linux.ibm.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128000650.1516334-1-iii@linux.ibm.com>
References: <20230128000650.1516334-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WZef-y3fPanUYJgpAv_gWK2UZXE9RZ9O
X-Proofpoint-ORIG-GUID: WZef-y3fPanUYJgpAv_gWK2UZXE9RZ9O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 mlxlogscore=568 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270216
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use bpf_probe_read_kernel() and bpf_probe_read_kernel_str() instead
of bpf_probe_read() and bpf_probe_read_kernel().

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 .../selftests/bpf/progs/profiler.inc.h        | 62 ++++++++++++-------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index 92331053dba3..68a3fd7387a4 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -156,10 +156,10 @@ probe_read_lim(void* dst, void* src, unsigned long len, unsigned long max)
 {
 	len = len < max ? len : max;
 	if (len > 1) {
-		if (bpf_probe_read(dst, len, src))
+		if (bpf_probe_read_kernel(dst, len, src))
 			return 0;
 	} else if (len == 1) {
-		if (bpf_probe_read(dst, 1, src))
+		if (bpf_probe_read_kernel(dst, 1, src))
 			return 0;
 	}
 	return len;
@@ -216,7 +216,8 @@ static INLINE void* read_full_cgroup_path(struct kernfs_node* cgroup_node,
 #endif
 	for (int i = 0; i < MAX_CGROUPS_PATH_DEPTH; i++) {
 		filepart_length =
-			bpf_probe_read_str(payload, MAX_PATH, BPF_CORE_READ(cgroup_node, name));
+			bpf_probe_read_kernel_str(payload, MAX_PATH,
+						  BPF_CORE_READ(cgroup_node, name));
 		if (!cgroup_node)
 			return payload;
 		if (cgroup_node == cgroup_root_node)
@@ -303,7 +304,8 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
 	cgroup_data->cgroup_full_length = 0;
 
 	size_t cgroup_root_length =
-		bpf_probe_read_str(payload, MAX_PATH, BPF_CORE_READ(root_kernfs, name));
+		bpf_probe_read_kernel_str(payload, MAX_PATH,
+					  BPF_CORE_READ(root_kernfs, name));
 	barrier_var(cgroup_root_length);
 	if (cgroup_root_length <= MAX_PATH) {
 		barrier_var(cgroup_root_length);
@@ -312,7 +314,8 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
 	}
 
 	size_t cgroup_proc_length =
-		bpf_probe_read_str(payload, MAX_PATH, BPF_CORE_READ(proc_kernfs, name));
+		bpf_probe_read_kernel_str(payload, MAX_PATH,
+					  BPF_CORE_READ(proc_kernfs, name));
 	barrier_var(cgroup_proc_length);
 	if (cgroup_proc_length <= MAX_PATH) {
 		barrier_var(cgroup_proc_length);
@@ -395,7 +398,8 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 		arr_struct = bpf_map_lookup_elem(&data_heap, &zero);
 		if (arr_struct == NULL)
 			return 0;
-		bpf_probe_read(&arr_struct->array[0], sizeof(arr_struct->array[0]), kill_data);
+		bpf_probe_read_kernel(&arr_struct->array[0],
+				      sizeof(arr_struct->array[0]), kill_data);
 	} else {
 		int index = get_var_spid_index(arr_struct, spid);
 
@@ -409,8 +413,9 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 #endif
 			for (int i = 0; i < ARRAY_SIZE(arr_struct->array); i++)
 				if (arr_struct->array[i].meta.pid == 0) {
-					bpf_probe_read(&arr_struct->array[i],
-						       sizeof(arr_struct->array[i]), kill_data);
+					bpf_probe_read_kernel(&arr_struct->array[i],
+							      sizeof(arr_struct->array[i]),
+							      kill_data);
 					bpf_map_update_elem(&var_tpid_to_data, &tpid,
 							    arr_struct, 0);
 
@@ -427,17 +432,17 @@ static INLINE int trace_var_sys_kill(void* ctx, int tpid, int sig)
 		if (delta_sec < STALE_INFO) {
 			kill_data->kill_count++;
 			kill_data->last_kill_time = bpf_ktime_get_ns();
-			bpf_probe_read(&arr_struct->array[index],
-				       sizeof(arr_struct->array[index]),
-				       kill_data);
+			bpf_probe_read_kernel(&arr_struct->array[index],
+					      sizeof(arr_struct->array[index]),
+					      kill_data);
 		} else {
 			struct var_kill_data_t* kill_data =
 				get_var_kill_data(ctx, spid, tpid, sig);
 			if (kill_data == NULL)
 				return 0;
-			bpf_probe_read(&arr_struct->array[index],
-				       sizeof(arr_struct->array[index]),
-				       kill_data);
+			bpf_probe_read_kernel(&arr_struct->array[index],
+					      sizeof(arr_struct->array[index]),
+					      kill_data);
 		}
 	}
 	bpf_map_update_elem(&var_tpid_to_data, &tpid, arr_struct, 0);
@@ -487,8 +492,9 @@ read_absolute_file_path_from_dentry(struct dentry* filp_dentry, void* payload)
 #pragma unroll
 #endif
 	for (int i = 0; i < MAX_PATH_DEPTH; i++) {
-		filepart_length = bpf_probe_read_str(payload, MAX_PATH,
-						     BPF_CORE_READ(filp_dentry, d_name.name));
+		filepart_length =
+			bpf_probe_read_kernel_str(payload, MAX_PATH,
+						  BPF_CORE_READ(filp_dentry, d_name.name));
 		barrier_var(filepart_length);
 		if (filepart_length > MAX_PATH)
 			break;
@@ -572,7 +578,8 @@ ssize_t BPF_KPROBE(kprobe__proc_sys_write,
 	sysctl_data->sysctl_val_length = 0;
 	sysctl_data->sysctl_path_length = 0;
 
-	size_t sysctl_val_length = bpf_probe_read_str(payload, CTL_MAXNAME, buf);
+	size_t sysctl_val_length = bpf_probe_read_kernel_str(payload,
+							     CTL_MAXNAME, buf);
 	barrier_var(sysctl_val_length);
 	if (sysctl_val_length <= CTL_MAXNAME) {
 		barrier_var(sysctl_val_length);
@@ -580,8 +587,10 @@ ssize_t BPF_KPROBE(kprobe__proc_sys_write,
 		payload += sysctl_val_length;
 	}
 
-	size_t sysctl_path_length = bpf_probe_read_str(payload, MAX_PATH,
-						       BPF_CORE_READ(filp, f_path.dentry, d_name.name));
+	size_t sysctl_path_length =
+		bpf_probe_read_kernel_str(payload, MAX_PATH,
+					  BPF_CORE_READ(filp, f_path.dentry,
+							d_name.name));
 	barrier_var(sysctl_path_length);
 	if (sysctl_path_length <= MAX_PATH) {
 		barrier_var(sysctl_path_length);
@@ -638,7 +647,8 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 		struct var_kill_data_t* past_kill_data = &arr_struct->array[i];
 
 		if (past_kill_data != NULL && past_kill_data->kill_target_pid == tpid) {
-			bpf_probe_read(kill_data, sizeof(*past_kill_data), past_kill_data);
+			bpf_probe_read_kernel(kill_data, sizeof(*past_kill_data),
+					      past_kill_data);
 			void* payload = kill_data->payload;
 			size_t offset = kill_data->payload_length;
 			if (offset >= MAX_METADATA_PAYLOAD_LEN + MAX_CGROUP_PAYLOAD_LEN)
@@ -656,8 +666,10 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 				payload += comm_length;
 			}
 
-			size_t cgroup_proc_length = bpf_probe_read_str(payload, KILL_TARGET_LEN,
-								       BPF_CORE_READ(proc_kernfs, name));
+			size_t cgroup_proc_length =
+				bpf_probe_read_kernel_str(payload,
+							  KILL_TARGET_LEN,
+							  BPF_CORE_READ(proc_kernfs, name));
 			barrier_var(cgroup_proc_length);
 			if (cgroup_proc_length <= KILL_TARGET_LEN) {
 				barrier_var(cgroup_proc_length);
@@ -718,7 +730,8 @@ int raw_tracepoint__sched_process_exec(struct bpf_raw_tracepoint_args* ctx)
 	proc_exec_data->parent_start_time = BPF_CORE_READ(parent_task, start_time);
 
 	const char* filename = BPF_CORE_READ(bprm, filename);
-	size_t bin_path_length = bpf_probe_read_str(payload, MAX_FILENAME_LEN, filename);
+	size_t bin_path_length =
+		bpf_probe_read_kernel_str(payload, MAX_FILENAME_LEN, filename);
 	barrier_var(bin_path_length);
 	if (bin_path_length <= MAX_FILENAME_LEN) {
 		barrier_var(bin_path_length);
@@ -922,7 +935,8 @@ int BPF_KPROBE(kprobe__vfs_symlink, struct inode* dir, struct dentry* dentry,
 					      filemod_data->payload);
 	payload = populate_cgroup_info(&filemod_data->cgroup_data, task, payload);
 
-	size_t len = bpf_probe_read_str(payload, MAX_FILEPATH_LENGTH, oldname);
+	size_t len = bpf_probe_read_kernel_str(payload, MAX_FILEPATH_LENGTH,
+					       oldname);
 	barrier_var(len);
 	if (len <= MAX_FILEPATH_LENGTH) {
 		barrier_var(len);
-- 
2.39.1

