Return-Path: <bpf+bounces-18480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CE581AD99
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 04:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48EE1F24074
	for <lists+bpf@lfdr.de>; Thu, 21 Dec 2023 03:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812095247;
	Thu, 21 Dec 2023 03:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDlTQ373"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9755248
	for <bpf@vger.kernel.org>; Thu, 21 Dec 2023 03:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5d33574f64eso4410607b3.3
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 19:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703129956; x=1703734756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckfU6Z7Nt5U3SQPRDeUbq4aMzV3aaSiJNI2YazpkATI=;
        b=dDlTQ373y2RkelPGXhtF/YTNpBp6NFgwP9m/x3UL7YGqO+eg95aT1yx4e4Dygt1Ptp
         exrYEb5Vrf7V8Q7JeWBcH9ZOhKHRpWSBrbqyKe2pK7GJsBoFT24B/ofMbzAQ2mD8Efdf
         EuE1rDFgL9kUrQPVX7iZmv2qq5hdcZWJBnVSdP+1hwwVVINXkJpg/sA6f03g5OfGVC6d
         nl0b82Huu81yW6IPhGk2OWW4jHx0teEgnuTKYNT46tw69xf8IuZYMQlAVngdj9y8Kfrm
         AByMhd69eQ0saEdrnDRz3Ecd/6OAq5eYBkN8IwN+HirlFwu2SglWrRStpraZFiwU7j15
         T1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703129956; x=1703734756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckfU6Z7Nt5U3SQPRDeUbq4aMzV3aaSiJNI2YazpkATI=;
        b=oSqz0ut8cFVlVuPlvbQq4Ld6tmIQ5oCt1YhjhR3NtHDCEruQSefL9oxJkiEEDr9N+n
         KGPsw5p9HGbUL/wFBkBXg7J9Q0eOwbhWrZ4GzoLOhfapTfPN0e3NogqwhjCjqznYfZPN
         eq7OiTIkU2QdpkY4dAHI+Ot0xEaVKZucsEYSilrhPgQB8rj55ZVm98yObvXOVszbPxTU
         DBA34qOLbFckI6tQFRbImRmAjEc1W7AJw5j5BXXoKBFma2CSxkTQMWP8SV5WLncchG3J
         gv/uJpwa2BScDEfxa1eCDOzAc/Q/br7fV69c7kFs96ayC2kKFWg1nlxrsMlXpAQF77N0
         qkJA==
X-Gm-Message-State: AOJu0YyA4yf+WebZJz7tDMFhjvIk3wEaomcaGzg4s+R8GO8pBWjf69SW
	QQ2hQVQubuS0qVkt+B9G44g=
X-Google-Smtp-Source: AGHT+IEPtuRtpPuN/DP/kRojneFFuoyUH6DMUxV/EDSKEMEs3H+RzvHeSnhkRoFgsGuaDeubJgrMIg==
X-Received: by 2002:a81:83d1:0:b0:5e7:9bdd:b2cf with SMTP id t200-20020a8183d1000000b005e79bddb2cfmr629741ywf.3.1703129956322;
        Wed, 20 Dec 2023 19:39:16 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::4:ec38])
        by smtp.gmail.com with ESMTPSA id h15-20020a170902ac8f00b001bc930d4517sm483521plr.42.2023.12.20.19.39.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Dec 2023 19:39:15 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: daniel@iogearbox.net
Cc: andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	kernel-team@fb.com
Subject: [RFC PATCH v2 bpf-next 5/5] selftests/bpf: Attempt to convert profiler.c to bpf_cmp.
Date: Wed, 20 Dec 2023 19:38:54 -0800
Message-Id: <20231221033854.38397-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Convert profiler.c to bpf_cmp() macro to compare barrier_var() approach vs bpf_cmp().

It works, but the results are not good:

./veristat -C -e prog,insns,states before after
Program                               Insns (A)  Insns (B)  Insns       (DIFF)  States (A)  States (B)  States     (DIFF)
------------------------------------  ---------  ---------  ------------------  ----------  ----------  -----------------
kprobe__proc_sys_write                     1603      19606  +18003 (+1123.08%)         123        1678  +1555 (+1264.23%)
kprobe__vfs_link                          11815      70305   +58490 (+495.05%)         971        4967   +3996 (+411.53%)
kprobe__vfs_symlink                        5464      42896   +37432 (+685.07%)         434        3126   +2692 (+620.28%)
kprobe_ret__do_filp_open                   5641      44578   +38937 (+690.25%)         446        3162   +2716 (+608.97%)
raw_tracepoint__sched_process_exec         2770      35962  +33192 (+1198.27%)         226        3121  +2895 (+1280.97%)
raw_tracepoint__sched_process_exit         1526       2135      +609 (+39.91%)         133         208      +75 (+56.39%)
raw_tracepoint__sched_process_fork          265        337       +72 (+27.17%)          19          24       +5 (+26.32%)
tracepoint__syscalls__sys_enter_kill      18782     140407  +121625 (+647.56%)        1286       12176  +10890 (+846.81%)

To be investigated.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/profiler.inc.h        | 67 ++++++-------------
 tools/testing/selftests/bpf/progs/profiler2.c |  1 +
 tools/testing/selftests/bpf/progs/profiler3.c |  1 +
 3 files changed, 21 insertions(+), 48 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index ba99d17dac54..c7546ed341e5 100644
--- a/tools/testing/selftests/bpf/progs/profiler.inc.h
+++ b/tools/testing/selftests/bpf/progs/profiler.inc.h
@@ -7,6 +7,7 @@
 
 #include "profiler.h"
 #include "err.h"
+#include "bpf_experimental.h"
 
 #ifndef NULL
 #define NULL 0
@@ -221,8 +222,7 @@ static INLINE void* read_full_cgroup_path(struct kernfs_node* cgroup_node,
 			return payload;
 		if (cgroup_node == cgroup_root_node)
 			*root_pos = payload - payload_start;
-		if (filepart_length <= MAX_PATH) {
-			barrier_var(filepart_length);
+		if (bpf_cmp(filepart_length, <=, MAX_PATH)) {
 			payload += filepart_length;
 		}
 		cgroup_node = BPF_CORE_READ(cgroup_node, parent);
@@ -305,9 +305,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
 	size_t cgroup_root_length =
 		bpf_probe_read_kernel_str(payload, MAX_PATH,
 					  BPF_CORE_READ(root_kernfs, name));
-	barrier_var(cgroup_root_length);
-	if (cgroup_root_length <= MAX_PATH) {
-		barrier_var(cgroup_root_length);
+	if (bpf_cmp(cgroup_root_length, <=, MAX_PATH)) {
 		cgroup_data->cgroup_root_length = cgroup_root_length;
 		payload += cgroup_root_length;
 	}
@@ -315,9 +313,7 @@ static INLINE void* populate_cgroup_info(struct cgroup_data_t* cgroup_data,
 	size_t cgroup_proc_length =
 		bpf_probe_read_kernel_str(payload, MAX_PATH,
 					  BPF_CORE_READ(proc_kernfs, name));
-	barrier_var(cgroup_proc_length);
-	if (cgroup_proc_length <= MAX_PATH) {
-		barrier_var(cgroup_proc_length);
+	if (bpf_cmp(cgroup_proc_length, <=, MAX_PATH)) {
 		cgroup_data->cgroup_proc_length = cgroup_proc_length;
 		payload += cgroup_proc_length;
 	}
@@ -347,9 +343,7 @@ static INLINE void* populate_var_metadata(struct var_metadata_t* metadata,
 	metadata->comm_length = 0;
 
 	size_t comm_length = bpf_core_read_str(payload, TASK_COMM_LEN, &task->comm);
-	barrier_var(comm_length);
-	if (comm_length <= TASK_COMM_LEN) {
-		barrier_var(comm_length);
+	if (bpf_cmp(comm_length, <=, TASK_COMM_LEN)) {
 		metadata->comm_length = comm_length;
 		payload += comm_length;
 	}
@@ -484,7 +478,7 @@ static INLINE size_t
 read_absolute_file_path_from_dentry(struct dentry* filp_dentry, void* payload)
 {
 	size_t length = 0;
-	size_t filepart_length;
+	u32 filepart_length;
 	struct dentry* parent_dentry;
 
 #ifdef UNROLL
@@ -494,10 +488,8 @@ read_absolute_file_path_from_dentry(struct dentry* filp_dentry, void* payload)
 		filepart_length =
 			bpf_probe_read_kernel_str(payload, MAX_PATH,
 						  BPF_CORE_READ(filp_dentry, d_name.name));
-		barrier_var(filepart_length);
-		if (filepart_length > MAX_PATH)
+		if (bpf_cmp(filepart_length, >, MAX_PATH))
 			break;
-		barrier_var(filepart_length);
 		payload += filepart_length;
 		length += filepart_length;
 
@@ -579,9 +571,7 @@ ssize_t BPF_KPROBE(kprobe__proc_sys_write,
 
 	size_t sysctl_val_length = bpf_probe_read_kernel_str(payload,
 							     CTL_MAXNAME, buf);
-	barrier_var(sysctl_val_length);
-	if (sysctl_val_length <= CTL_MAXNAME) {
-		barrier_var(sysctl_val_length);
+	if (bpf_cmp(sysctl_val_length, <=, CTL_MAXNAME)) {
 		sysctl_data->sysctl_val_length = sysctl_val_length;
 		payload += sysctl_val_length;
 	}
@@ -590,9 +580,7 @@ ssize_t BPF_KPROBE(kprobe__proc_sys_write,
 		bpf_probe_read_kernel_str(payload, MAX_PATH,
 					  BPF_CORE_READ(filp, f_path.dentry,
 							d_name.name));
-	barrier_var(sysctl_path_length);
-	if (sysctl_path_length <= MAX_PATH) {
-		barrier_var(sysctl_path_length);
+	if (bpf_cmp(sysctl_path_length, <=, MAX_PATH)) {
 		sysctl_data->sysctl_path_length = sysctl_path_length;
 		payload += sysctl_path_length;
 	}
@@ -658,9 +646,7 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 			kill_data->kill_target_cgroup_proc_length = 0;
 
 			size_t comm_length = bpf_core_read_str(payload, TASK_COMM_LEN, &task->comm);
-			barrier_var(comm_length);
-			if (comm_length <= TASK_COMM_LEN) {
-				barrier_var(comm_length);
+			if (bpf_cmp(comm_length, <=, TASK_COMM_LEN)) {
 				kill_data->kill_target_name_length = comm_length;
 				payload += comm_length;
 			}
@@ -669,9 +655,7 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 				bpf_probe_read_kernel_str(payload,
 							  KILL_TARGET_LEN,
 							  BPF_CORE_READ(proc_kernfs, name));
-			barrier_var(cgroup_proc_length);
-			if (cgroup_proc_length <= KILL_TARGET_LEN) {
-				barrier_var(cgroup_proc_length);
+			if (bpf_cmp(cgroup_proc_length, <=, KILL_TARGET_LEN)) {
 				kill_data->kill_target_cgroup_proc_length = cgroup_proc_length;
 				payload += cgroup_proc_length;
 			}
@@ -731,9 +715,7 @@ int raw_tracepoint__sched_process_exec(struct bpf_raw_tracepoint_args* ctx)
 	const char* filename = BPF_CORE_READ(bprm, filename);
 	size_t bin_path_length =
 		bpf_probe_read_kernel_str(payload, MAX_FILENAME_LEN, filename);
-	barrier_var(bin_path_length);
-	if (bin_path_length <= MAX_FILENAME_LEN) {
-		barrier_var(bin_path_length);
+	if (bpf_cmp(bin_path_length, <=, MAX_FILENAME_LEN)) {
 		proc_exec_data->bin_path_length = bin_path_length;
 		payload += bin_path_length;
 	}
@@ -743,8 +725,7 @@ int raw_tracepoint__sched_process_exec(struct bpf_raw_tracepoint_args* ctx)
 	unsigned int cmdline_length = probe_read_lim(payload, arg_start,
 						     arg_end - arg_start, MAX_ARGS_LEN);
 
-	if (cmdline_length <= MAX_ARGS_LEN) {
-		barrier_var(cmdline_length);
+	if (bpf_cmp(cmdline_length, <=, MAX_ARGS_LEN)) {
 		proc_exec_data->cmdline_length = cmdline_length;
 		payload += cmdline_length;
 	}
@@ -820,10 +801,8 @@ int kprobe_ret__do_filp_open(struct pt_regs* ctx)
 					      filemod_data->payload);
 	payload = populate_cgroup_info(&filemod_data->cgroup_data, task, payload);
 
-	size_t len = read_absolute_file_path_from_dentry(filp_dentry, payload);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	u32 len = read_absolute_file_path_from_dentry(filp_dentry, payload);
+	if (bpf_cmp(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->dst_filepath_length = len;
 	}
@@ -876,17 +855,13 @@ int BPF_KPROBE(kprobe__vfs_link,
 	payload = populate_cgroup_info(&filemod_data->cgroup_data, task, payload);
 
 	size_t len = read_absolute_file_path_from_dentry(old_dentry, payload);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	if (bpf_cmp(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->src_filepath_length = len;
 	}
 
 	len = read_absolute_file_path_from_dentry(new_dentry, payload);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	if (bpf_cmp(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->dst_filepath_length = len;
 	}
@@ -936,16 +911,12 @@ int BPF_KPROBE(kprobe__vfs_symlink, struct inode* dir, struct dentry* dentry,
 
 	size_t len = bpf_probe_read_kernel_str(payload, MAX_FILEPATH_LENGTH,
 					       oldname);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	if (bpf_cmp(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->src_filepath_length = len;
 	}
 	len = read_absolute_file_path_from_dentry(dentry, payload);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	if (bpf_cmp(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->dst_filepath_length = len;
 	}
diff --git a/tools/testing/selftests/bpf/progs/profiler2.c b/tools/testing/selftests/bpf/progs/profiler2.c
index 0f32a3cbf556..2e1193cc4fae 100644
--- a/tools/testing/selftests/bpf/progs/profiler2.c
+++ b/tools/testing/selftests/bpf/progs/profiler2.c
@@ -3,4 +3,5 @@
 #define barrier_var(var) /**/
 /* undef #define UNROLL */
 #define INLINE /**/
+#define bpf_cmp(lhs, op, rhs) lhs op rhs
 #include "profiler.inc.h"
diff --git a/tools/testing/selftests/bpf/progs/profiler3.c b/tools/testing/selftests/bpf/progs/profiler3.c
index 6249fc31ccb0..bf08523c1744 100644
--- a/tools/testing/selftests/bpf/progs/profiler3.c
+++ b/tools/testing/selftests/bpf/progs/profiler3.c
@@ -3,4 +3,5 @@
 #define barrier_var(var) /**/
 #define UNROLL
 #define INLINE __noinline
+#define bpf_cmp(lhs, op, rhs) lhs op rhs
 #include "profiler.inc.h"
-- 
2.34.1


