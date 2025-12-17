Return-Path: <bpf+bounces-76843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8A2CC6D86
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 10:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F99B303A1B1
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 09:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADE133EAE6;
	Wed, 17 Dec 2025 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dpvEGav0"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED34133DEE6
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964064; cv=none; b=EBQKaviGlYU7+tPhbeq57FDJ7hNkC47UAgltE8rIV3xrx4HKfYNNqVWjXD++WRpR2foAcTqX+O+XreUZ+m8KxCAwp/FKY/cZvlOvYodjiznjLXHrOBpsCnFK+poBnvUJ8JBJLXiWXaXJCcWzKiUXwr/HgT98dR0aaJpkr7Vdvt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964064; c=relaxed/simple;
	bh=8d0Kv05QbIY3V6VZgRLzYlCzx44ZNAZYWZcMIbzy/j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEqCudNhdx30w/xhVKgo89OjBz9zTe4/YvjXR5CmTyuCLXBWlSgsIZa60XKKdrJ6RCZfanRg0lcL31EceBsYh01UEcEX6GQ2SSgCRUQ9Ge8ZI1lDRWQzPFmFbBqXIIj2UvkKb4Lu7U7a2X+Osvyrk30UzoQtXb9HDWDs6tTXKas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dpvEGav0; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1765964061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUM9tN+SRSk9se9w/GBygwPxcQRVLd8zM/nzUyQmYq4=;
	b=dpvEGav0CQXGktLmWV23c6eYuovr1ahiBRFsrOAyDkihHQdt9qOuyMYmbOtxO5rIXCz+Ub
	g0inWUkTZLYEji60/+/8nd1vfKZA9tFDD2/D8fzsfv2TPHm3rILOVDM8WPn/nPcaKm8HMc
	9xnkudCW/TmEeW40I8rMAvYhmgUOSJE=
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
	kan.liang@linux.intel.com,
	song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v7 2/2] bpf: Hold the perf callchain entry until used completely
Date: Wed, 17 Dec 2025 17:33:26 +0800
Message-ID: <20251217093326.1745307-3-chen.dylane@linux.dev>
In-Reply-To: <20251217093326.1745307-1-chen.dylane@linux.dev>
References: <20251217093326.1745307-1-chen.dylane@linux.dev>
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

Acked-by: Yonghong Song <yonghong.song@linux.dev>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 68 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index da3d328f5c1..3bdd99a630d 100644
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
+		__get_perf_callchain_user(&ctx, regs, 0);
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
@@ -328,20 +355,25 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
 	u32 max_depth;
+	int rctx, ret;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false, 0);
+
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
@@ -435,6 +467,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	bool kernel = !user;
 	int err = -EINVAL;
 	u64 *ips;
+	int rctx;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -467,18 +500,26 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = trace_in;
 		trace->nr = min_t(u32, trace->nr, max_depth);
 	} else if (kernel && task) {
-		trace = get_callchain_entry_for_task(task, max_depth);
+		trace = get_callchain_entry_for_task(&rctx, task, max_depth);
 	} else {
-		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask, false, 0);
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
 
@@ -497,6 +538,9 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (may_fault)
 		rcu_read_unlock();
 
+	if (!trace_in)
+		bpf_put_perf_callchain(rctx);
+
 	if (user_build_id)
 		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
 
-- 
2.48.1


