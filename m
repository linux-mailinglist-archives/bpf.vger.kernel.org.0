Return-Path: <bpf+bounces-18685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EB881E92C
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69251C20CEC
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 19:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91C17F8;
	Tue, 26 Dec 2023 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK3//YxB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCEC1852
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 19:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d4414ec9c7so3582825ad.0
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 11:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703617935; x=1704222735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rn6iIsum+b6kmR4581Z0EKGq5rMcJt9n3ejwgYBQG0Y=;
        b=ZK3//YxBpbG7dt65jwTl9PD2ZRs8lB5QgQqae3q8c1biJ0i0WMx5wCR+cy1c/4CDDR
         6oG5E8MmJ/AodilvD6hH141yPr8AXEXGtT6v54txQ1qo8lryDkqz0C44oKk0mTtDJupz
         TRUUKoS5tuMvByiMiiwYIRT0feqmAxfvVPfLcFB3AM64n8+G9V2c5Jy65+wJg8NVciy0
         Oq6BB9UjqeD+3zm6dGM4NdOvJDJZ60dSmMot7vIQSlYoGsJWO1J+dat/KzrpjsGxspTh
         cCkV7voVilJkYeXkT3sORvbEZDRVMGD3aJcu3g+omTm30CQpCj+G7xVDl6azueYoP069
         wyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703617935; x=1704222735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rn6iIsum+b6kmR4581Z0EKGq5rMcJt9n3ejwgYBQG0Y=;
        b=p4B+CDZISw7bi6pKdB/yvoNRmKtgE3qAAvUmju2D0Py3vXTYngmOJRDKGWd9v4EqAo
         yKT6wzZmiqptAOeRKTl7bUFc3EY3YcBfBkgt9Pwxp95wdJ3yNPfrx5Hwmk62iJ6/v8/A
         hpUUdQTB2Cm/MxIi+QK9r4Q1csbsyq1y1S5KKS3GAB3f/CD4piUxZaCzAimVIuUXntPT
         OM8LjzpfLA6nvrhhEYyWMsEeX+97KCKan3iiHrl1zw0D4wClUYi0skOxEW3dIW3AY4JR
         ng2463uwKVxmL0b4SGnIrcTAGWIj44o2eT/zhQU7BfwLnZ/n+38WYdEn1bC7/tXKIQzm
         Ogjw==
X-Gm-Message-State: AOJu0Yy7pHsWdFRNAQKAE/omnMlyuPDnHpTzcYFtisa0G30hRL/wYBtq
	46XU7S5QScgidoBwWaC2txcimk/RF7Q=
X-Google-Smtp-Source: AGHT+IFrmX43Og+fr5wzIuZrzW2DXtla1SfoXJGPCphv3v4Whi0xHWkuZvq44m7a+lWgWxMNkWJQTg==
X-Received: by 2002:a17:902:ea04:b0:1d4:55e0:bd0e with SMTP id s4-20020a170902ea0400b001d455e0bd0emr1820992plg.18.1703617935041;
        Tue, 26 Dec 2023 11:12:15 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:500::4:bc9b])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001d3acd7480fsm10306058pll.105.2023.12.26.11.12.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Dec 2023 11:12:14 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	dxu@dxuuu.xyz,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 bpf-next 6/6] selftests/bpf: Convert profiler.c to bpf_cmp.
Date: Tue, 26 Dec 2023 11:11:48 -0800
Message-Id: <20231226191148.48536-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
References: <20231226191148.48536-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Convert profiler[123].c to "volatile compare" to compare barrier_var() approach vs bpf_cmp_likely() vs bpf_cmp_unlikely().

bpf_cmp_unlikely() produces correct code, but takes much longer to verify:

./veristat -C -e prog,insns,states before after_with_unlikely
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

bpf_cmp_likely() is equivalent to barrier_var():

./veristat -C -e prog,insns,states before after_with_likely
Program                               Insns (A)  Insns (B)  Insns   (DIFF)  States (A)  States (B)  States (DIFF)
------------------------------------  ---------  ---------  --------------  ----------  ----------  -------------
kprobe__proc_sys_write                     1603       1663    +60 (+3.74%)         123         127    +4 (+3.25%)
kprobe__vfs_link                          11815      12090   +275 (+2.33%)         971         971    +0 (+0.00%)
kprobe__vfs_symlink                        5464       5448    -16 (-0.29%)         434         426    -8 (-1.84%)
kprobe_ret__do_filp_open                   5641       5739    +98 (+1.74%)         446         446    +0 (+0.00%)
raw_tracepoint__sched_process_exec         2770       2608   -162 (-5.85%)         226         216   -10 (-4.42%)
raw_tracepoint__sched_process_exit         1526       1526     +0 (+0.00%)         133         133    +0 (+0.00%)
raw_tracepoint__sched_process_fork          265        265     +0 (+0.00%)          19          19    +0 (+0.00%)
tracepoint__syscalls__sys_enter_kill      18782      18970   +188 (+1.00%)        1286        1286    +0 (+0.00%)
kprobe__proc_sys_write                     2700       2809   +109 (+4.04%)         107         109    +2 (+1.87%)
kprobe__vfs_link                          12238      12366   +128 (+1.05%)         267         269    +2 (+0.75%)
kprobe__vfs_symlink                        7139       7365   +226 (+3.17%)         167         175    +8 (+4.79%)
kprobe_ret__do_filp_open                   7264       7070   -194 (-2.67%)         180         182    +2 (+1.11%)
raw_tracepoint__sched_process_exec         3768       3453   -315 (-8.36%)         211         199   -12 (-5.69%)
raw_tracepoint__sched_process_exit         3138       3138     +0 (+0.00%)          83          83    +0 (+0.00%)
raw_tracepoint__sched_process_fork          265        265     +0 (+0.00%)          19          19    +0 (+0.00%)
tracepoint__syscalls__sys_enter_kill      26679      24327  -2352 (-8.82%)        1067        1037   -30 (-2.81%)
kprobe__proc_sys_write                     1833       1833     +0 (+0.00%)         157         157    +0 (+0.00%)
kprobe__vfs_link                           9995      10127   +132 (+1.32%)         803         803    +0 (+0.00%)
kprobe__vfs_symlink                        5606       5672    +66 (+1.18%)         451         451    +0 (+0.00%)
kprobe_ret__do_filp_open                   5716       5782    +66 (+1.15%)         462         462    +0 (+0.00%)
raw_tracepoint__sched_process_exec         3042       3042     +0 (+0.00%)         278         278    +0 (+0.00%)
raw_tracepoint__sched_process_exit         1680       1680     +0 (+0.00%)         146         146    +0 (+0.00%)
raw_tracepoint__sched_process_fork          299        299     +0 (+0.00%)          25          25    +0 (+0.00%)
tracepoint__syscalls__sys_enter_kill      18372      18372     +0 (+0.00%)        1558        1558    +0 (+0.00%)

default (mcpu=v3), no_alu32, cpuv4 have similar differences.

Note one place where bpf_nop_mov() is used to workaround the verifier lack of link
between the scalar register and its spill to stack.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/profiler.inc.h        | 64 ++++++-------------
 1 file changed, 18 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/profiler.inc.h b/tools/testing/selftests/bpf/progs/profiler.inc.h
index ba99d17dac54..de3b6e4e4d0a 100644
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
+		if (bpf_cmp_likely(filepart_length, <=, MAX_PATH)) {
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
+	if (bpf_cmp_likely(cgroup_root_length, <=, MAX_PATH)) {
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
+	if (bpf_cmp_likely(cgroup_proc_length, <=, MAX_PATH)) {
 		cgroup_data->cgroup_proc_length = cgroup_proc_length;
 		payload += cgroup_proc_length;
 	}
@@ -347,9 +343,7 @@ static INLINE void* populate_var_metadata(struct var_metadata_t* metadata,
 	metadata->comm_length = 0;
 
 	size_t comm_length = bpf_core_read_str(payload, TASK_COMM_LEN, &task->comm);
-	barrier_var(comm_length);
-	if (comm_length <= TASK_COMM_LEN) {
-		barrier_var(comm_length);
+	if (bpf_cmp_likely(comm_length, <=, TASK_COMM_LEN)) {
 		metadata->comm_length = comm_length;
 		payload += comm_length;
 	}
@@ -494,10 +488,9 @@ read_absolute_file_path_from_dentry(struct dentry* filp_dentry, void* payload)
 		filepart_length =
 			bpf_probe_read_kernel_str(payload, MAX_PATH,
 						  BPF_CORE_READ(filp_dentry, d_name.name));
-		barrier_var(filepart_length);
-		if (filepart_length > MAX_PATH)
+		bpf_nop_mov(filepart_length);
+		if (bpf_cmp_unlikely(filepart_length, >, MAX_PATH))
 			break;
-		barrier_var(filepart_length);
 		payload += filepart_length;
 		length += filepart_length;
 
@@ -579,9 +572,7 @@ ssize_t BPF_KPROBE(kprobe__proc_sys_write,
 
 	size_t sysctl_val_length = bpf_probe_read_kernel_str(payload,
 							     CTL_MAXNAME, buf);
-	barrier_var(sysctl_val_length);
-	if (sysctl_val_length <= CTL_MAXNAME) {
-		barrier_var(sysctl_val_length);
+	if (bpf_cmp_likely(sysctl_val_length, <=, CTL_MAXNAME)) {
 		sysctl_data->sysctl_val_length = sysctl_val_length;
 		payload += sysctl_val_length;
 	}
@@ -590,9 +581,7 @@ ssize_t BPF_KPROBE(kprobe__proc_sys_write,
 		bpf_probe_read_kernel_str(payload, MAX_PATH,
 					  BPF_CORE_READ(filp, f_path.dentry,
 							d_name.name));
-	barrier_var(sysctl_path_length);
-	if (sysctl_path_length <= MAX_PATH) {
-		barrier_var(sysctl_path_length);
+	if (bpf_cmp_likely(sysctl_path_length, <=, MAX_PATH)) {
 		sysctl_data->sysctl_path_length = sysctl_path_length;
 		payload += sysctl_path_length;
 	}
@@ -658,9 +647,7 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 			kill_data->kill_target_cgroup_proc_length = 0;
 
 			size_t comm_length = bpf_core_read_str(payload, TASK_COMM_LEN, &task->comm);
-			barrier_var(comm_length);
-			if (comm_length <= TASK_COMM_LEN) {
-				barrier_var(comm_length);
+			if (bpf_cmp_likely(comm_length, <=, TASK_COMM_LEN)) {
 				kill_data->kill_target_name_length = comm_length;
 				payload += comm_length;
 			}
@@ -669,9 +656,7 @@ int raw_tracepoint__sched_process_exit(void* ctx)
 				bpf_probe_read_kernel_str(payload,
 							  KILL_TARGET_LEN,
 							  BPF_CORE_READ(proc_kernfs, name));
-			barrier_var(cgroup_proc_length);
-			if (cgroup_proc_length <= KILL_TARGET_LEN) {
-				barrier_var(cgroup_proc_length);
+			if (bpf_cmp_likely(cgroup_proc_length, <=, KILL_TARGET_LEN)) {
 				kill_data->kill_target_cgroup_proc_length = cgroup_proc_length;
 				payload += cgroup_proc_length;
 			}
@@ -731,9 +716,7 @@ int raw_tracepoint__sched_process_exec(struct bpf_raw_tracepoint_args* ctx)
 	const char* filename = BPF_CORE_READ(bprm, filename);
 	size_t bin_path_length =
 		bpf_probe_read_kernel_str(payload, MAX_FILENAME_LEN, filename);
-	barrier_var(bin_path_length);
-	if (bin_path_length <= MAX_FILENAME_LEN) {
-		barrier_var(bin_path_length);
+	if (bpf_cmp_likely(bin_path_length, <=, MAX_FILENAME_LEN)) {
 		proc_exec_data->bin_path_length = bin_path_length;
 		payload += bin_path_length;
 	}
@@ -743,8 +726,7 @@ int raw_tracepoint__sched_process_exec(struct bpf_raw_tracepoint_args* ctx)
 	unsigned int cmdline_length = probe_read_lim(payload, arg_start,
 						     arg_end - arg_start, MAX_ARGS_LEN);
 
-	if (cmdline_length <= MAX_ARGS_LEN) {
-		barrier_var(cmdline_length);
+	if (bpf_cmp_likely(cmdline_length, <=, MAX_ARGS_LEN)) {
 		proc_exec_data->cmdline_length = cmdline_length;
 		payload += cmdline_length;
 	}
@@ -821,9 +803,7 @@ int kprobe_ret__do_filp_open(struct pt_regs* ctx)
 	payload = populate_cgroup_info(&filemod_data->cgroup_data, task, payload);
 
 	size_t len = read_absolute_file_path_from_dentry(filp_dentry, payload);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	if (bpf_cmp_likely(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->dst_filepath_length = len;
 	}
@@ -876,17 +856,13 @@ int BPF_KPROBE(kprobe__vfs_link,
 	payload = populate_cgroup_info(&filemod_data->cgroup_data, task, payload);
 
 	size_t len = read_absolute_file_path_from_dentry(old_dentry, payload);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	if (bpf_cmp_likely(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->src_filepath_length = len;
 	}
 
 	len = read_absolute_file_path_from_dentry(new_dentry, payload);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	if (bpf_cmp_likely(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->dst_filepath_length = len;
 	}
@@ -936,16 +912,12 @@ int BPF_KPROBE(kprobe__vfs_symlink, struct inode* dir, struct dentry* dentry,
 
 	size_t len = bpf_probe_read_kernel_str(payload, MAX_FILEPATH_LENGTH,
 					       oldname);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	if (bpf_cmp_likely(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->src_filepath_length = len;
 	}
 	len = read_absolute_file_path_from_dentry(dentry, payload);
-	barrier_var(len);
-	if (len <= MAX_FILEPATH_LENGTH) {
-		barrier_var(len);
+	if (bpf_cmp_likely(len, <=, MAX_FILEPATH_LENGTH)) {
 		payload += len;
 		filemod_data->dst_filepath_length = len;
 	}
-- 
2.34.1


