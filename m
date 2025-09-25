Return-Path: <bpf+bounces-69760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F37EBA0F47
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 19:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11CA762591A
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8FA3074A7;
	Thu, 25 Sep 2025 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lOe2r/pl"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C4527510B
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 17:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758822703; cv=none; b=ckUWALbJtvHhdUNy3dBSgFKGeMDSxcpo5jtVfR6BnOY8VFlBVuqi3jHFpAsVOEkSKZ9T83dU+gnlUj97g7XHdqODuk8byxoj2q7zM5FZimpuZjbyQSN/itlfpeFcGVkpXET14BRjGdr23pOrnLPhqVsIsZSut5Huh8bbQPdBUZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758822703; c=relaxed/simple;
	bh=eFBj+NoRKyq6AH3ee4KSftiKcIQfTiMoqJOXeFXkdY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBJkqUJTEtcwM9hW+YdfYt18CDlHad3fOvd5ADcoYEx0S/nED5qMCLJN+d0XtEjLYt+tQdpislGK7opP7C95rK/Zr2tOwN5ajB4nIHthDxNGTT8XOeA0xmWKG6WDwWk0Eu2lh6koKSW3v3sFYb6R2lywx+DNcyfczyrMlyAblBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lOe2r/pl; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758822689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mqpGJZ8+w8yeo86Csrw9+o+7ikJ4DiTggwOMxAIVJ5Q=;
	b=lOe2r/plgHrxiTmNZ3v9xGHsiIijtOLwC0YoSRRIrfA8i+lbGrq/XJoGneNIzDG7JSbebs
	bi1ix7i9kv90HlmPp6yb/+ubL9al9hyCUyY/F0CbMfZLjUpNhtbVJFvq0huTjbLXKszGIW
	GQ9ZHBnfVOTEVSNoPK19iMjZFakXI1M=
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
Subject: [PATCH bpf-next v6 3/3] selftests/bpf: Add stacktrace map lookup_and_delete_elem test case
Date: Fri, 26 Sep 2025 01:50:30 +0800
Message-ID: <20250925175030.1615837-3-chen.dylane@linux.dev>
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
index 0a79bf1d354..ec93918fe3c 100644
--- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
@@ -7,7 +7,8 @@ void test_stacktrace_map(void)
 	struct stacktrace_map *skel;
 	int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
 	int err, stack_trace_len;
-	__u32 key, val, duration = 0;
+	__u32 key, val, stack_id, duration = 0;
+	__u64 stack[PERF_MAX_STACK_DEPTH];
 
 	skel = stacktrace_map__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
@@ -60,6 +61,14 @@ void test_stacktrace_map(void)
 		  "err %d errno %d\n", err, errno))
 		goto out;
 
+	stack_id = skel->bss->stack_id;
+	err = bpf_map_lookup_and_delete_elem(stackmap_fd, &stack_id,  stack);
+	if (!ASSERT_OK(err, "lookup and delete target stack_id"))
+		goto out;
+
+	err = bpf_map_lookup_elem(stackmap_fd, &stack_id, stack);
+	if (!ASSERT_EQ(err, -ENOENT, "lookup deleted stack_id"))
+		goto out;
 out:
 	stacktrace_map__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/stacktrace_map.c b/tools/testing/selftests/bpf/progs/stacktrace_map.c
index 47568007b66..0c77df05be7 100644
--- a/tools/testing/selftests/bpf/progs/stacktrace_map.c
+++ b/tools/testing/selftests/bpf/progs/stacktrace_map.c
@@ -50,6 +50,7 @@ struct sched_switch_args {
 	int next_prio;
 };
 
+__u32 stack_id;
 SEC("tracepoint/sched/sched_switch")
 int oncpu(struct sched_switch_args *ctx)
 {
@@ -64,6 +65,7 @@ int oncpu(struct sched_switch_args *ctx)
 	/* The size of stackmap and stackid_hmap should be the same */
 	key = bpf_get_stackid(ctx, &stackmap, 0);
 	if ((int)key >= 0) {
+		stack_id = key;
 		bpf_map_update_elem(&stackid_hmap, &key, &val, 0);
 		stack_p = bpf_map_lookup_elem(&stack_amap, &key);
 		if (stack_p)
-- 
2.48.1


