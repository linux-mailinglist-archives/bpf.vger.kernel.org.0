Return-Path: <bpf+bounces-69217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9296BB91921
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE851667AF
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E91E19DF66;
	Mon, 22 Sep 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IhpQHHhJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCDF134CF
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549837; cv=none; b=KW014hn1uUTPf25He8aRWQViwMq5o48V6PqCt02hu0Lrkumg5Vvmsn2JUdum7cKtdNCxHg7kRuS+9lmdeH9s8LQOz9iHAHSYMZ4r/XxlVGGy4D+iezJfQSPnjVfTULiKcfPdvHXdftfAas45UWAA/oQoJVSE8Cm0RRRlZcY2rNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549837; c=relaxed/simple;
	bh=LPdID9fGrA4DlPTN6+jVDftsW6sq3M1Jvx3IrSZXyUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CcMWwPhQuEmdqTJB712DvZsJl5l0Q74+mWPxeQtYHg6e/3g9Ee9G6gYrXiNkp32Mwfsl1h6xdsvYzLI1N3zs025yvXyIQAo5x3tN5B6VIWldj6af5mfnEMDAHP3MZF+2vWjy7gG7Z2zk/DddGbSQ3BGsalhuNYuFYOR7hG3iHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IhpQHHhJ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758549834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YcVOCJTY7UDVODwqXS6fkKZden+CY0bv6ATLTG4+6UM=;
	b=IhpQHHhJHmtnX0e7XIrAyO2LM14p14dSXSgCY4cM/4aJ1G3A2+R8g+8u2/2/TYjLHd/ci9
	TVr/SnFWAfW5TA7Zd/pboc9KMXJj9lhX0lcOAFaZB2UKuQ9sWg5V7AkBG3omSAoCe/Wf4+
	ap89G7a9Ite1OWTxZY7W2VXG8rsTFrg=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add stacktrace map lookup_and_delete_elem test case
Date: Mon, 22 Sep 2025 22:03:17 +0800
Message-ID: <20250922140317.1468691-2-chen.dylane@linux.dev>
In-Reply-To: <20250922140317.1468691-1-chen.dylane@linux.dev>
References: <20250922140317.1468691-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add tests for stacktrace map lookup and delete:
1. use bpf_map_lookup_and_delete_elem to lookup and delete the target
   stack_id,
2. lookup the deleted stack_id again to double check.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../selftests/bpf/prog_tests/stacktrace_map.c | 21 ++++++++++++++++++-
 .../selftests/bpf/progs/test_stacktrace_map.c |  8 +++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 84a7e405e91..d50659fc25e 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -3,7 +3,7 @@
 
 void test_stacktrace_map(void)
 {
-	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
+	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd, stack_key_map_fd;
 	const char *prog_name = "oncpu";
 	int err, prog_fd, stack_trace_len;
 	const char *file = "./test_stacktrace_map.bpf.o";
@@ -11,6 +11,8 @@ void test_stacktrace_map(void)
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_link *link;
+	__u32 stack_id;
+	char val_buf[PERF_MAX_STACK_DEPTH * sizeof(struct bpf_stack_build_id)];
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
@@ -41,6 +43,10 @@ void test_stacktrace_map(void)
 	if (CHECK_FAIL(stack_amap_fd < 0))
 		goto disable_pmu;
 
+	stack_key_map_fd = bpf_find_map(__func__, obj, "stack_key_map");
+	if (CHECK_FAIL(stack_key_map_fd < 0))
+		goto disable_pmu;
+
 	/* give some time for bpf program run */
 	sleep(1);
 
@@ -68,6 +74,19 @@ void test_stacktrace_map(void)
 		  "err %d errno %d\n", err, errno))
 		goto disable_pmu;
 
+	err = bpf_map_lookup_elem(stack_key_map_fd, &key, &stack_id);
+	if (CHECK(err, "stack_key_map lookup", "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = bpf_map_lookup_and_delete_elem(stackmap_fd, &stack_id, &val_buf);
+	if (CHECK(err, "stackmap lookup and delete",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = bpf_map_lookup_elem(stackmap_fd, &stack_id, &val_buf);
+	CHECK((!err || errno != ENOENT), "stackmap lookup deleted stack_id",
+	      "err %d errno %d\n", err, errno);
+
 disable_pmu:
 	bpf_link__destroy(link);
 close_prog:
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
index 47568007b66..3bede76c151 100644
--- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
@@ -38,6 +38,13 @@ struct {
 	__type(value, stack_trace_t);
 } stack_amap SEC(".maps");
 
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} stack_key_map SEC(".maps");
+
 /* taken from /sys/kernel/tracing/events/sched/sched_switch/format */
 struct sched_switch_args {
 	unsigned long long pad;
@@ -64,6 +71,7 @@ int oncpu(struct sched_switch_args *ctx)
 	/* The size of stackmap and stackid_hmap should be the same */
 	key = bpf_get_stackid(ctx, &stackmap, 0);
 	if ((int)key >= 0) {
+		bpf_map_update_elem(&stack_key_map, &val, &key, 0);
 		bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
 		stack_p = bpf_map_lookup_elem(&stack_amap, &key);
 		if (stack_p)
-- 
2.48.1


