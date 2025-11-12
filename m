Return-Path: <bpf+bounces-74312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F9DC53866
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 17:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42787500C23
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 16:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1482834029E;
	Wed, 12 Nov 2025 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hc2A6lJ7"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480E92BF00B
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965168; cv=none; b=rSdyI/YxdBhFyJUvEe7m5P81yYrKR48XYoNBhxkbczw5ahUMaDU7rqot2wVUZc9T+3zMoHC8Pq6b4F3xwfMj0DYdUWxZNehtvnsidfL82SF7D7uSg3jvwOZ6/A8brQ4LrdlmlG4GRJUt1h+B4HVZYh1TbEENQgQUjEWXQDyIEJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965168; c=relaxed/simple;
	bh=RMRa8Q6ayawYi21qORb4H3++uTkFrXR1cUC5uQ7UhUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqrMuyf7HhgDQgqU3+290kjcUFOExhejRpNlHM+OI7Uanzi71Hd+nuJsjMjSPmz5owMYxO5q8dNVuqWlGU/oyM4T5mWKJnDUsaR733yJ3mnpdUMVDLcEuxw5OXC/qF+8ZSDKXFrN/OZKzv7lM8xxVCbQCWOTrJWfpvUHlvaaOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hc2A6lJ7; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762965163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mtXUOdznhUmZcR4XZKkageB0d5MGuAnQnq36wg+kOAg=;
	b=Hc2A6lJ7AX0YAWwEH4hpV5gqPnSP+43TbPSYyaDnMauGYA5fZG/lbLB7qYx57o8TGDO3s2
	OGXdAXhqWF/u0PrpI8ZSQjCuFSRkfu29mL7cPJ0hWu+VMpsn5kKF0Nt1jgKIqH46m0yIRa
	KJdGaySHfDKBJgCt+gskfaSr9F2b46E=
From: Tao Chen <chen.dylane@linux.dev>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v6 2/2] bpf: Hold the perf callchain entry until used completely
Date: Thu, 13 Nov 2025 00:31:48 +0800
Message-ID: <20251112163148.100949-3-chen.dylane@linux.dev>
In-Reply-To: <20251112163148.100949-1-chen.dylane@linux.dev>
References: <20251112163148.100949-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

As Alexei noted, get_perf_callchain() return values may be reused
if a task is preempted after the BPF program enters migrate disable
mode. The perf_callchain_entres has a small stack of entries, and
we can reuse it as follows:

1. get the perf callchain entry
2. BPF use...
3. put the perf callchain entry

And Peter suggested that get_recursion_context used with preemption
disabled, so we should disable preemption at BPF side.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 67 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2365541c81d..64ace4ed50e 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -210,13 +210,14 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 }
 
 static struct perf_callchain_entry *
-get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
+get_callchain_entry_for_task(int *rctx, struct task_struct *task, u32 max_depth)
 {
 #ifdef CONFIG_STACKTRACE
 	struct perf_callchain_entry *entry;
-	int rctx;
 
-	entry = get_callchain_entry(&rctx);
+	preempt_disable();
+	entry = get_callchain_entry(rctx);
+	preempt_enable();
 
 	if (!entry)
 		return NULL;
@@ -238,8 +239,6 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 			to[i] = (u64)(from[i]);
 	}
 
-	put_callchain_entry(rctx);
-
 	return entry;
 #else /* CONFIG_STACKTRACE */
 	return NULL;
@@ -320,6 +319,34 @@ static long __bpf_get_stackid(struct bpf_map *map,
 	return id;
 }
 
+static struct perf_callchain_entry *
+bpf_get_perf_callchain(int *rctx, struct pt_regs *regs, bool kernel, bool user,
+		       int max_stack, bool crosstask)
+{
+	struct perf_callchain_entry_ctx ctx;
+	struct perf_callchain_entry *entry;
+
+	preempt_disable();
+	entry = get_callchain_entry(rctx);
+	preempt_enable();
+
+	if (unlikely(!entry))
+		return NULL;
+
+	__init_perf_callchain_ctx(&ctx, entry, max_stack, false);
+	if (kernel)
+		__get_perf_callchain_kernel(&ctx, regs);
+	if (user && !crosstask)
+		__get_perf_callchain_user(&ctx, regs);
+
+	return entry;
+}
+
+static void bpf_put_perf_callchain(int rctx)
+{
+	put_callchain_entry(rctx);
+}
+
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags)
 {
@@ -328,20 +355,24 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
 	u32 max_depth;
+	int rctx, ret;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
+	trace = bpf_get_perf_callchain(&rctx, regs, kernel, user, max_depth,
+				       false);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(map, trace, flags);
+	ret = __bpf_get_stackid(map, trace, flags);
+	bpf_put_perf_callchain(rctx);
+
+	return ret;
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -435,6 +466,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	bool kernel = !user;
 	int err = -EINVAL;
 	u64 *ips;
+	int rctx;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -467,18 +499,26 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = trace_in;
 		trace->nr = min_t(u32, trace->nr, max_depth);
 	} else if (kernel && task) {
-		trace = get_callchain_entry_for_task(task, max_depth);
+		trace = get_callchain_entry_for_task(&rctx, task, max_depth);
 	} else {
-		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false);
+		trace = bpf_get_perf_callchain(&rctx, regs, kernel, user, max_depth,
+					       crosstask);
 	}
 
-	if (unlikely(!trace) || trace->nr < skip) {
+	if (unlikely(!trace)) {
 		if (may_fault)
 			rcu_read_unlock();
 		goto err_fault;
 	}
 
+	if (trace->nr < skip) {
+		if (may_fault)
+			rcu_read_unlock();
+		if (!trace_in)
+			bpf_put_perf_callchain(rctx);
+		goto err_fault;
+	}
+
 	trace_nr = trace->nr - skip;
 	copy_len = trace_nr * elem_size;
 
@@ -497,6 +537,9 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (may_fault)
 		rcu_read_unlock();
 
+	if (!trace_in)
+		bpf_put_perf_callchain(rctx);
+
 	if (user_build_id)
 		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
 
-- 
2.48.1


