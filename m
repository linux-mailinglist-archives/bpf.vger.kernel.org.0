Return-Path: <bpf+bounces-69759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185C5BA0F2C
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E024A1FF3
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941023112D8;
	Thu, 25 Sep 2025 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A1UiF3We"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF030F929
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822674; cv=none; b=uGTVMCkdLPRQ/8VflHdsvsE6dzhv/GscfQ+Y6lRKA9hBD6LIiA4Qe0K18/6tFydIB3ARposdaBit1zbLnyOnKHyW9r1SSUiHZPM4Zl9cvxg3avQRYzrVVpaIRd4Vqdd8F+u09YmgmuP5MwRqLo9XR/TlRcA+s5dGqkn9dLNtFz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822674; c=relaxed/simple;
	bh=weR3jvYnwxRW5YU5Ji3DbJwlQ9k4y/ABjvv8+oO2aYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWaz7iub0MeCZFQYXy5JjIQqV6hH8DUjwM4lHou2M641E2hhHfpVD8J/mPdsolxjMPAnmIFk8Am8+OB27u1h9d+Jr2idczLfQEpWyjB6yqH+F29hXHqLNuB11jJgWa5xbmAptkXUTE97/OS1ZIDjrR4bKDN1tTn6hqkUFeQNsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A1UiF3We; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758822670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnna/wEcMMwUopHMkFKwrmkUV474k6uWBW0KzqxD1og=;
	b=A1UiF3We4TD1ZDek1ext4+wGdfKxznYKHUD9dohDyN5kzoRqicgdGF2CSktS1I4RkUEbd5
	IvdslvvqUpNlwLkYidttFAX3BNFs21KvKU/sNzPY60JGYG6SQLOVOfHU0yC6gDYze9+B9f
	wlZj7sLoy6X8jc7ofM7cpMoP9RmlYaU=
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
Subject: [PATCH bpf-next v6 2/3] selftests/bpf: Refactor stacktrace_map case with skeleton
Date: Fri, 26 Sep 2025 01:50:29 +0800
Message-ID: <20250925175030.1615837-2-chen.dylane@linux.dev>
In-Reply-To: <20250925175030.1615837-1-chen.dylane@linux.dev>
References: <20250925175030.1615837-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The loading method of the stacktrace_map test case looks too outdated,
refactor it with skeleton, and we can use global avariable feature in
the next patch.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../selftests/bpf/prog_tests/stacktrace_map.c | 52 ++++++++-----------
 .../bpf/prog_tests/stacktrace_map_raw_tp.c    |  2 +-
 ...test_stacktrace_map.c => stacktrace_map.c} |  0
 3 files changed, 22 insertions(+), 32 deletions(-)
 rename tools/testing/selftests/bpf/progs/{test_stacktrace_map.c => stacktrace_map.c} (100%)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 84a7e405e91..0a79bf1d354 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -1,46 +1,38 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "stacktrace_map.skel.h"
 
 void test_stacktrace_map(void)
 {
+	struct stacktrace_map *skel;
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
-	const char *prog_name = "oncpu";
-	int err, prog_fd, stack_trace_len;
-	const char *file = "./test_stacktrace_map.bpf.o";
+	int err, stack_trace_len;
 	__u32 key, val, duration = 0;
-	struct bpf_program *prog;
-	struct bpf_object *obj;
-	struct bpf_link *link;
 
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
+	control_map_fd = bpf_map__fd(skel->maps.control_map);
 	if (CHECK_FAIL(control_map_fd < 0))
-		goto disable_pmu;
+		goto out;
 
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
 
@@ -55,21 +47,19 @@ void test_stacktrace_map(void)
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
diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
index e0cb4697b4b..e985d51d3d4 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map_raw_tp.c
@@ -5,7 +5,7 @@ void test_stacktrace_map_raw_tp(void)
 {
 	const char *prog_name = "oncpu";
 	int control_map_fd, stackid_hmap_fd, stackmap_fd;
-	const char *file = "./test_stacktrace_map.bpf.o";
+	const char *file = "./stacktrace_map.bpf.o";
 	__u32 key, val, duration = 0;
 	int err, prog_fd;
 	struct bpf_program *prog;
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/stacktrace_map.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/test_stacktrace_map.c
rename to tools/testing/selftests/bpf/progs/stacktrace_map.c
-- 
2.48.1


