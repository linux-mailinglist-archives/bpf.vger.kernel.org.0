Return-Path: <bpf+bounces-69465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D8B96E48
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 19:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D261032129B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DACD329F16;
	Tue, 23 Sep 2025 16:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pOa8lpLr"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1F329F09
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 16:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758646783; cv=none; b=lbwYvjerlwc6+6V4p7oXv6T9ZZj8udxrzp7dk5rz3NP8P2XKudRXl6qN0tgHmaPFk7kl8loD9n76vNBF0ECVNBhoCqU8TGDOpdAhq9OGr8NM85o8Nw/BafhvfKMFDpczGQfLwCZU8lCQVP44Y6BIxKisXW1OHYPIPhdKHxGxUo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758646783; c=relaxed/simple;
	bh=0t1zFi9nttC26jmxoZL/rGyyeP3D5IhH0mSkl5ix+HM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fGK4Jv8VKZ1174TrgU/8BhTh7nO4oCYd2AWdGi6f5XVoCu3AcaLdHRZZMjanOswNkTHj6LeiUd8cquGHimlRnPaBbIDX+hxdyiQcKjF+aHDpmhbvZCzvv1EpQGp+YkW7A8UkYTdCvfYFoDdRwRm67q2imoD8WM1mYjORu4dvHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pOa8lpLr; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758646779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/yv/EjLcVmv16kNK9RUEZeVdPoYyfddBCGEjLmOaBiI=;
	b=pOa8lpLrJmDGHdl9WZYLpEOYwVz42/M/WM2i/P45tt60440My084SxoRCTO18vVQvMtGSl
	whzl8kGPNr2Z3aDbzHxqjYOd8kJPMG+CXovdv/w+f9rCKJueRGHmz/pJ+TymBVhlb+s5yW
	3pWmHIBURbRyuQScuv2+oKwnte/YMko=
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
Subject: [PATCH bpf-next v5 3/3] selftests/bpf: Add stacktrace map lookup_and_delete_elem test case
Date: Wed, 24 Sep 2025 00:58:49 +0800
Message-ID: <20250923165849.1524622-3-chen.dylane@linux.dev>
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

Add tests for stacktrace map lookup and delete:
1. use bpf_map_lookup_and_delete_elem to lookup and delete the target
   stack_id,
2. lookup the deleted stack_id again to double check.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 .../testing/selftests/bpf/prog_tests/stacktrace_map.c | 11 ++++++++++-
 tools/testing/selftests/bpf/progs/stacktrace_map.c    |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
index 26a2bd25a6f..f06bfef0bc8 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -7,7 +7,8 @@ void test_stacktrace_map(void)
 	struct stacktrace_map *skel;
 	int stackid_hmap_fd, stackmap_fd, stack_amap_fd;
 	int err, stack_trace_len;
-	__u32 duration = 0;
+	__u32 stack_id, duration = 0;
+	__u64 val[PERF_MAX_STACK_DEPTH];
 
 	skel = stacktrace_map__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
@@ -54,6 +55,14 @@ void test_stacktrace_map(void)
 		  "err %d errno %d\n", err, errno))
 		goto out;
 
+	stack_id = skel->bss->stack_id;
+	err = bpf_map_lookup_and_delete_elem(stackmap_fd, &stack_id,  val);
+	if (!ASSERT_OK(err, "lookup and delete target stack_id"))
+		goto out;
+
+	err = bpf_map_lookup_elem(stackmap_fd, &stack_id, val);
+	if (!ASSERT_EQ(err, -ENOENT, "lookup deleted stack_id"))
+		goto out;
 out:
 	stacktrace_map__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/stacktrace_map.c b/tools/testing/selftests/bpf/progs/stacktrace_map.c
index 9090d561312..7abf702a6ce 100644
--- a/tools/testing/selftests/bpf/progs/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/stacktrace_map.c
@@ -44,6 +44,7 @@ struct sched_switch_args {
 };
 
 int control = 0;
+__u32 stack_id;
 SEC("tracepoint/sched/sched_switch")
 int oncpu(struct sched_switch_args *ctx)
 {
@@ -57,6 +58,7 @@ int oncpu(struct sched_switch_args *ctx)
 	/* The size of stackmap and stackid_hmap should be the same */
 	key = bpf_get_stackid(ctx, &stackmap, 0);
 	if ((int)key >= 0) {
+		stack_id = key;
 		bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
 		stack_p = bpf_map_lookup_elem(&stack_amap, &key);
 		if (stack_p)
-- 
2.48.1


