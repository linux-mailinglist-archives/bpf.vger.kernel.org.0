Return-Path: <bpf+bounces-67702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D009B48C4E
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 13:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2AA3A7098
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1462E7BD0;
	Mon,  8 Sep 2025 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P6XFPDbR"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB102E22BF
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331418; cv=none; b=TOFO5VbDXn66fhDdjp9NeR71W/VA9xhShCSHOo6iI6u/bO/6JkFJ5zAR2+7iua1FqZlmYZTlR4RmbtMRJnEuK7BS4amQOtVnCK7r9Uc4kc9r3I/7wMcNWR/UT5RuvDbmFfKXxpWNTh3JtgSCJP2Rype+RZXIXbz+65zaDpmGgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331418; c=relaxed/simple;
	bh=/WJcxv4OoQMS+Qse6yqKRPagTPyb/5KjlFjkAk0XX4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=saaM2fIucWeigh9MCalNe1OI8u0Ziw37XvF4CjXuBhhigO2W5JI4y30OcGViLbgFNJBoDJhJRtj/OL7IZq9FUWU+IKFLoXle4h1bQsRd9rc6mnbvDvuc5QRW12a5Od0sI5AX5dWRy901qrQTVfcPryZhTUBF3mGOvxmh2g+NFpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P6XFPDbR; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757331414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3X+inMotr0BojlB7iVkKlq2cvmy97iRehYoI8X0czVQ=;
	b=P6XFPDbRtOhbB4dn+qoSwMEHQQ6rYZ9zojkEKoymKPBzQd/5yrmTc6BqaPvs5lF7aZMYDN
	agpCJFMs410tFfO0u+SvhfUuZwu4uMnBKpNS5uPKfdHk10RTqd+iVdRpYsyKJgLvqpOFqh
	ylI975mFawfjdx8TkD3ApusUSzCiZwU=
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add stacktrace map lookup_and_delete_elem test case
Date: Mon,  8 Sep 2025 19:36:22 +0800
Message-ID: <20250908113622.810652-2-chen.dylane@linux.dev>
In-Reply-To: <20250908113622.810652-1-chen.dylane@linux.dev>
References: <20250908113622.810652-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

...
test_stacktrace_map:PASS:compare_stack_ips stackmap vs. stack_amap 0 nsec
test_stacktrace_map:PASS:stack_key_map lookup 0 nsec
test_stacktrace_map:PASS:stackmap lookup and detele 0 nsec
 #397     stacktrace_map:OK
...

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../selftests/bpf/prog_tests/stacktrace_map.c  | 18 +++++++++++++++++-
 .../selftests/bpf/progs/test_stacktrace_map.c  | 12 +++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 84a7e405e91..496c4dcf4ea 100644
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
@@ -11,6 +11,9 @@ void test_stacktrace_map(void)
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	struct bpf_link *link;
+	__u32 stackmap_key;
+	char val_buf[PERF_MAX_STACK_DEPTH *
+		sizeof(struct bpf_stack_build_id)];
 
 	err = bpf_prog_test_load(file, BPF_PROG_TYPE_TRACEPOINT, &obj, &prog_fd);
 	if (CHECK(err, "prog_load", "err %d errno %d\n", err, errno))
@@ -41,6 +44,10 @@ void test_stacktrace_map(void)
 	if (CHECK_FAIL(stack_amap_fd < 0))
 		goto disable_pmu;
 
+	stack_key_map_fd = bpf_find_map(__func__, obj, "stack_key_map");
+	if (CHECK_FAIL(stack_key_map_fd < 0))
+		goto disable_pmu;
+
 	/* give some time for bpf program run */
 	sleep(1);
 
@@ -68,6 +75,15 @@ void test_stacktrace_map(void)
 		  "err %d errno %d\n", err, errno))
 		goto disable_pmu;
 
+	err = bpf_map_lookup_elem(stack_key_map_fd, &key, &stackmap_key);
+	if (CHECK(err, "stack_key_map lookup", "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
+	err = bpf_map_lookup_and_delete_elem(stackmap_fd, &stackmap_key, &val_buf);
+	if (CHECK(err, "stackmap lookup and detele",
+		  "err %d errno %d\n", err, errno))
+		goto disable_pmu;
+
 disable_pmu:
 	bpf_link__destroy(link);
 close_prog:
diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
index 47568007b66..d036e8e9c83 100644
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
@@ -54,7 +61,7 @@ SEC("tracepoint/sched/sched_switch")
 int oncpu(struct sched_switch_args *ctx)
 {
 	__u32 max_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
-	__u32 key = 0, val = 0, *value_p;
+	__u32 key = 0, val = 0, *value_p, stackmap_key = 0;
 	void *stack_p;
 
 	value_p = bpf_map_lookup_elem(&control_map, &key);
@@ -64,6 +71,9 @@ int oncpu(struct sched_switch_args *ctx)
 	/* The size of stackmap and stackid_hmap should be the same */
 	key = bpf_get_stackid(ctx, &stackmap, 0);
 	if ((int)key >= 0) {
+		val = key;
+		bpf_map_update_elem(&stack_key_map, &stackmap_key, &val, 0);
+		val = 0;
 		bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
 		stack_p = bpf_map_lookup_elem(&stack_amap, &key);
 		if (stack_p)
-- 
2.48.1


