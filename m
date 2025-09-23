Return-Path: <bpf+bounces-69463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47883B96E36
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 18:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA2A3211B8
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72A6329F0F;
	Tue, 23 Sep 2025 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xi8NwDMr"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FDF3294FE;
	Tue, 23 Sep 2025 16:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646763; cv=none; b=aKRfupgmnQNu8FojVNEL3KsAPSkHd0VKdRcyYg4SA5aTERQEELT1fFi87hsi37NnqzwWp0UiCfyRm0I7LtDEMxRcEZ5qGiNf/emNgccRfgRn/K0bxLRNDazKHrPEZ4r7dxq80kyXgA23A6qowqOAA7/rY65vFKRWm2e17p/ena4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646763; c=relaxed/simple;
	bh=8Ty8KQ9n9TPqw9Tb/MuXHVfUNyFyfi6c6Nov/cW7ZxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyesgNBIuEdfDCMd05ouVYpv+CTitcYrJHK81fBo1uQXYKVXk6AcWEH9dgLsnqYhCLKA9p4ytqTW6gorY3UtyFUEeWrHMQNySt+/CtPVUomiEqAH6P5G3wgCvYaqsqOAi3yX9ZESWRhTHSkFIZRFWVKRQ2s7b5qB+q8+alMptKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xi8NwDMr; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758646759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6UvuxZ+i80V8bbs5SWt3esDUbLo+oSEXiaP5wij/A4=;
	b=Xi8NwDMrLC8Iobv15MpS8+YsHh1v1g3zyjsaDspP9v/rGMxfYemgnIBBPu2VJxTpgi6ITW
	iNCZDsM7SwwzLLhb0H1Tp9Q/A17gnIkGum3LN4jso4F/Wn7wQGj/m1UkPpeFHJoU/9gPSi
	w97lWm4dczwyvGzp8/aE2t1fxR2ileI=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v5 2/3] selftests/bpf: Refactor stacktrace_map case with skeleton
Date: Wed, 24 Sep 2025 00:58:48 +0800
Message-ID: <20250923165849.1524622-2-chen.dylane@linux.dev>
In-Reply-To: <20250923165849.1524622-1-chen.dylane@linux.dev>
References: <20250923165849.1524622-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The loading method of the stacktrace_map test case looks too outdated,
refactor it with skeleton and replace control_map with control global
variable.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../selftests/bpf/prog_tests/stacktrace_map.c | 60 +++++++------------
 ...test_stacktrace_map.c => stacktrace_map.c} | 15 ++---
 2 files changed, 26 insertions(+), 49 deletions(-)
 rename tools/testing/selftests/bpf/progs/{test_stacktrace_map.c => stacktrace_map.c} (83%)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 84a7e405e91..26a2bd25a6f 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -1,53 +1,39 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "stacktrace_map.skel.h"
 
 void test_stacktrace_map(void)
 {
-	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
-	const char *prog_name = "oncpu";
-	int err, prog_fd, stack_trace_len;
-	const char *file = "./test_stacktrace_map.bpf.o";
-	__u32 key, val, duration = 0;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	struct bpf_link *link;
+	struct stacktrace_map *skel;
+	int stackid_hmap_fd, stackmap_fd, stack_amap_fd;
+	int err, stack_trace_len;
+	__u32 duration = 0;
 
-	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
-	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
+	skel = stacktrace_map__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
 		return;
 
-	prog = bpf_object__find_program_by_name(obj, prog_name);
-	if (CHECK(!prog, "find_prog", "prog '%s' not found\n", prog_name))
-		goto close_prog;
-
-	link = bpf_program__attach_tracepoint(prog, "sched", "sched_switch");
-	if (!ASSERT_OK_PTR(link, "attach_tp"))
-		goto close_prog;
-
 	/* find map fds */
-	control_map_fd = bpf_find_map(__func__, obj, "control_map");
-	if (CHECK_FAIL(control_map_fd < 0))
-		goto disable_pmu;
-
-	stackid_hmap_fd = bpf_find_map(__func__, obj, "stackid_hmap");
+	stackid_hmap_fd = bpf_map__fd(skel->maps.stackid_hmap);
 	if (CHECK_FAIL(stackid_hmap_fd < 0))
-		goto disable_pmu;
+		goto out;
 
-	stackmap_fd = bpf_find_map(__func__, obj, "stackmap");
+	stackmap_fd = bpf_map__fd(skel->maps.stackmap);
 	if (CHECK_FAIL(stackmap_fd < 0))
-		goto disable_pmu;
+		goto out;
 
-	stack_amap_fd = bpf_find_map(__func__, obj, "stack_amap");
+	stack_amap_fd = bpf_map__fd(skel->maps.stack_amap);
 	if (CHECK_FAIL(stack_amap_fd < 0))
-		goto disable_pmu;
+		goto out;
 
+	err = stacktrace_map__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto out;
 	/* give some time for bpf program run */
 	sleep(1);
 
 	/* disable stack trace collection */
-	key = 0;
-	val = 1;
-	bpf_map_update_elem(control_map_fd, &key, &val, 0);
+	skel->bss->control = 1;
 
 	/* for every element in stackid_hmap, we can find a corresponding one
 	 * in stackmap, and vice versa.
@@ -55,21 +41,19 @@ void test_stacktrace_map(void)
 	err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
 	if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
 		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
+		goto out;
 
 	err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
 	if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
 		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
+		goto out;
 
 	stack_trace_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
 	err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
 	if (CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
 		  "err %d errno %d\n", err, errno))
-		goto disable_pmu;
+		goto out;
 
-disable_pmu:
-	bpf_link__destroy(link);
-close_prog:
-	bpf_object__close(obj);
+out:
+	stacktrace_map__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/stacktrace_map.c
similarity index 83%
rename from tools/testing/selftests/bpf/progs/test_stacktrace_map.c
rename to tools/testing/selftests/bpf/progs/stacktrace_map.c
index 47568007b66..9090d561312 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/stacktrace_map.c
@@ -8,13 +8,6 @@
 #define PERF_MAX_STACK_DEPTH         127
 #endif
 
-struct {
-	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
-	__type(key, __u32);
-	__type(value, __u32);
-} control_map SEC(".maps");
-
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(max_entries, 16384);
@@ -50,16 +43,16 @@ struct sched_switch_args {
 	int next_prio;
 };
 
+int control = 0;
 SEC("tracepoint/sched/sched_switch")
 int oncpu(struct sched_switch_args *ctx)
 {
 	__u32 max_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
-	__u32 key = 0, val = 0, *value_p;
+	__u32 key = 0, val = 0;
 	void *stack_p;
 
-	value_p = bpf_map_lookup_elem(&control_map, &key);
-	if (value_p && *value_p)
-		return 0; /* skip if non-zero *value_p */
+	if (control)
+		return 0;
 
 	/* The size of stackmap and stackid_hmap should be the same */
 	key = bpf_get_stackid(ctx, &stackmap, 0);
-- 
2.48.1


