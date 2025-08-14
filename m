Return-Path: <bpf+bounces-65608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0CBB25CE3
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 09:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633E57B58F7
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539892690F9;
	Thu, 14 Aug 2025 07:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhFAjdoL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A625DB06;
	Thu, 14 Aug 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755155876; cv=none; b=bpBG4pTxMx2YgcC8WY8TiZbQ9aI+TSjbt/kOxAR4P3TGANMdiFdJ24XLqbers2Iohp+DDBPZGM30GiFuXkKOdmgq5I4HwSxEtnipN+TLqLpEFjQNi7xd0iCfCgsIN2AEXoNNc58JZd0VQK6USFebU4uLjDa11KFDLChSH9nMIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755155876; c=relaxed/simple;
	bh=Wm2qdxRnDJvd/5aGLY/oyhdsp1MSPFfFQ9r/DRTCpr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxK2aoQsvLAuM1AWJ4V19nnwDFlqeDV4DxL5gwNrF3deEZVTSAjxsqFa/PRf+tSoxmPOCjiv5c3JdtmvtkvBXHkDr/Ntt46hfwpndxtDQ0APISKejvG6/H5xX5kdY9jdiew95zDeZbDhgU5o2/+ATK/Pg5v9O6F9h4jxw42BqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhFAjdoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62EEC4CEF7;
	Thu, 14 Aug 2025 07:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755155876;
	bh=Wm2qdxRnDJvd/5aGLY/oyhdsp1MSPFfFQ9r/DRTCpr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IhFAjdoLmd2zCg0en6wVI/mTCNqPPfTOwY1eikoXfgH5sWlAo1wfslyxyImtYxRgJ
	 AM6e9iFzlZ0CmxPNqRQx9RSqyvZJVoZA0CIsax9+TO+Pe6wKPoyyYdhpuegdaUtI+I
	 349RpQ32lB4PTq9NpOnSWEFR2nL2JZugq9NOFPAvXd14dokh3Wxgaw6CUkAC/3LtTM
	 +bLAXznsiZbIjS1RNeawHVysG9nWK/aGYRbeUYIMAn7NJUQBr3qq1CVRwu6/EMC7ca
	 bUJhcMmXEI4WKuZ5eo5SbsgiYULidMWZJpCSFpvXDDXdathEPudmNyU2zH9784AZ7T
	 XEdCErZW5nALw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Song Liu <song@kernel.org>,
	Howard Chu <howardchu95@gmail.com>,
	Jakub Brnak <jbrnak@redhat.com>
Subject: [PATCH 1/5] perf trace: use standard syscall tracepoint structs for augmentation
Date: Thu, 14 Aug 2025 00:17:50 -0700
Message-ID: <20250814071754.193265-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250814071754.193265-1-namhyung@kernel.org>
References: <20250814071754.193265-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Brnak <jbrnak@redhat.com>

Replace custom syscall structs with the standard trace_event_raw_sys_enter
and trace_event_raw_sys_exit from vmlinux.h.
This fixes a data structure misalignment issue discovered on RHEL-9, which
prevented BPF programs from correctly accessing syscall arguments.
This change also aims to improve compatibility between different version
of the perf tool and kernel by using CO-RE so BPF code can correclty
adjust field offsets.

Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
[ coding style updates and fix a BPF verifier issue ]
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 62 ++++++++-----------
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h    | 14 +++++
 2 files changed, 40 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index cb86e261b4de0685..2c9bcc6b8cb0c06c 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -60,18 +60,6 @@ struct syscalls_sys_exit {
 	__uint(max_entries, 512);
 } syscalls_sys_exit SEC(".maps");
 
-struct syscall_enter_args {
-	unsigned long long common_tp_fields;
-	long		   syscall_nr;
-	unsigned long	   args[6];
-};
-
-struct syscall_exit_args {
-	unsigned long long common_tp_fields;
-	long		   syscall_nr;
-	long		   ret;
-};
-
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
@@ -115,7 +103,7 @@ struct pids_filtered {
 } pids_filtered SEC(".maps");
 
 struct augmented_args_payload {
-	struct syscall_enter_args args;
+	struct trace_event_raw_sys_enter args;
 	struct augmented_arg arg, arg2; // We have to reserve space for two arguments (rename, etc)
 };
 
@@ -135,7 +123,7 @@ struct beauty_map_enter {
 } beauty_map_enter SEC(".maps");
 
 struct beauty_payload_enter {
-	struct syscall_enter_args args;
+	struct trace_event_raw_sys_enter args;
 	struct augmented_arg aug_args[6];
 };
 
@@ -192,7 +180,7 @@ unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const
 }
 
 SEC("tp/raw_syscalls/sys_enter")
-int syscall_unaugmented(struct syscall_enter_args *args)
+int syscall_unaugmented(struct trace_event_raw_sys_enter *args)
 {
 	return 1;
 }
@@ -204,7 +192,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
  * filename.
  */
 SEC("tp/syscalls/sys_enter_connect")
-int sys_enter_connect(struct syscall_enter_args *args)
+int sys_enter_connect(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *sockaddr_arg = (const void *)args->args[1];
@@ -225,7 +213,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_sendto")
-int sys_enter_sendto(struct syscall_enter_args *args)
+int sys_enter_sendto(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *sockaddr_arg = (const void *)args->args[4];
@@ -243,7 +231,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_open")
-int sys_enter_open(struct syscall_enter_args *args)
+int sys_enter_open(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *filename_arg = (const void *)args->args[0];
@@ -258,7 +246,7 @@ int sys_enter_open(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_openat")
-int sys_enter_openat(struct syscall_enter_args *args)
+int sys_enter_openat(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *filename_arg = (const void *)args->args[1];
@@ -273,7 +261,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_rename")
-int sys_enter_rename(struct syscall_enter_args *args)
+int sys_enter_rename(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[0],
@@ -304,7 +292,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_renameat2")
-int sys_enter_renameat2(struct syscall_enter_args *args)
+int sys_enter_renameat2(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[1],
@@ -346,7 +334,7 @@ struct perf_event_attr_size {
 };
 
 SEC("tp/syscalls/sys_enter_perf_event_open")
-int sys_enter_perf_event_open(struct syscall_enter_args *args)
+int sys_enter_perf_event_open(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const struct perf_event_attr_size *attr = (const struct perf_event_attr_size *)args->args[0], *attr_read;
@@ -378,7 +366,7 @@ int sys_enter_perf_event_open(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_clock_nanosleep")
-int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
+int sys_enter_clock_nanosleep(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *rqtp_arg = (const void *)args->args[2];
@@ -399,7 +387,7 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 }
 
 SEC("tp/syscalls/sys_enter_nanosleep")
-int sys_enter_nanosleep(struct syscall_enter_args *args)
+int sys_enter_nanosleep(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *req_arg = (const void *)args->args[0];
@@ -429,7 +417,7 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
 	return bpf_map_lookup_elem(pids, &pid) != NULL;
 }
 
-static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
+static int augment_sys_enter(void *ctx, struct trace_event_raw_sys_enter *args)
 {
 	bool augmented, do_output = false;
 	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
@@ -444,7 +432,7 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 		return 1;
 
 	/* use syscall number to get beauty_map entry */
-	nr             = (__u32)args->syscall_nr;
+	nr             = (__u32)args->id;
 	beauty_map     = bpf_map_lookup_elem(&beauty_map_enter, &nr);
 
 	/* set up payload for output */
@@ -454,8 +442,8 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 	if (beauty_map == NULL || payload == NULL)
 		return 1;
 
-	/* copy the sys_enter header, which has the syscall_nr */
-	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
+	/* copy the sys_enter header, which has the id */
+	__builtin_memcpy(&payload->args, args, sizeof(*args));
 
 	/*
 	 * Determine what type of argument and how many bytes to read from user space, using the
@@ -489,9 +477,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 			index = -(size + 1);
 			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
 			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
-			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
+			aug_size = args->args[index];
 
 			if (aug_size > 0) {
+				if (aug_size > TRACE_AUG_MAX_BUF)
+					aug_size = TRACE_AUG_MAX_BUF;
 				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
 					augmented = true;
 			}
@@ -515,14 +505,14 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
 		}
 	}
 
-	if (!do_output || (sizeof(struct syscall_enter_args) + output) > sizeof(struct beauty_payload_enter))
+	if (!do_output || (sizeof(*args) + output) > sizeof(*payload))
 		return 1;
 
-	return augmented__beauty_output(ctx, payload, sizeof(struct syscall_enter_args) + output);
+	return augmented__beauty_output(ctx, payload, sizeof(*args) + output);
 }
 
 SEC("tp/raw_syscalls/sys_enter")
-int sys_enter(struct syscall_enter_args *args)
+int sys_enter(struct trace_event_raw_sys_enter *args)
 {
 	struct augmented_args_payload *augmented_args;
 	/*
@@ -550,16 +540,16 @@ int sys_enter(struct syscall_enter_args *args)
 	 * unaugmented tracepoint payload.
 	 */
 	if (augment_sys_enter(args, &augmented_args->args))
-		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_nr);
+		bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.id);
 
 	// If not found on the PROG_ARRAY syscalls map, then we're filtering it:
 	return 0;
 }
 
 SEC("tp/raw_syscalls/sys_exit")
-int sys_exit(struct syscall_exit_args *args)
+int sys_exit(struct trace_event_raw_sys_exit *args)
 {
-	struct syscall_exit_args exit_args;
+	struct trace_event_raw_sys_exit exit_args;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
@@ -570,7 +560,7 @@ int sys_exit(struct syscall_exit_args *args)
 	 * "!raw_syscalls:unaugmented" that will just return 1 to return the
 	 * unaugmented tracepoint payload.
 	 */
-	bpf_tail_call(args, &syscalls_sys_exit, exit_args.syscall_nr);
+	bpf_tail_call(args, &syscalls_sys_exit, exit_args.id);
 	/*
 	 * If not found on the PROG_ARRAY syscalls map, then we're filtering it:
 	 */
diff --git a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
index a59ce912be18cd0f..b8b2347268633cdf 100644
--- a/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
+++ b/tools/perf/util/bpf_skel/vmlinux/vmlinux.h
@@ -212,4 +212,18 @@ struct pglist_data {
 	int nr_zones;
 } __attribute__((preserve_access_index));
 
+struct trace_event_raw_sys_enter {
+	struct trace_entry ent;
+	long int id;
+	long unsigned int args[6];
+	char __data[0];
+} __attribute__((preserve_access_index));
+
+struct trace_event_raw_sys_exit {
+	struct trace_entry ent;
+	long int id;
+	long int ret;
+	char __data[0];
+} __attribute__((preserve_access_index));
+
 #endif // __VMLINUX_H
-- 
2.51.0.rc1.167.g924127e9c0-goog


