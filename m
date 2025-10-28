Return-Path: <bpf+bounces-72584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EA8C15D51
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 17:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB27461D86
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 16:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F1288C3D;
	Tue, 28 Oct 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a0PCiNY5"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0BC2750E6
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668810; cv=none; b=SSMHcv38XtEZoL3+hRhRL57/fTSZe4goyNZ6yVEFqga0NehM/AE55o6EuCXjZp1GjTyvzLfzsbkPP6FMyMhxA8lhlbXOQ2CYaj/I6F8DKNddRBcAaGJ7VLYaYgSLtLa0EuV9joENhWvtixD4jj/pAHvE+qbCRyAONK+2nshYUG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668810; c=relaxed/simple;
	bh=C77mCOcYKZDT1tjjWTbER/wZyL1dVdsIKBcn719SqSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bA0mIOmTtWDemGbT836Mh5vpnSorojQbSm8tMdyIId11KaQJ/wVUKoL6n0OMZ+JvdDnOheErugtjFkasHqcc5pJDmbv/0uR3MjICm7QN6hRjZa3l8CClHuSUuc/fYA2EiQluBINS7qmRZmWC+pvqfz2mb8pxojtLpYwFvY9yd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a0PCiNY5; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761668805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K3lqjGd6Xn2XO6sjJZ+0OWHHK1rsFpO56tXY2t0cYhs=;
	b=a0PCiNY5lQxcHytYeRlIhR7nevUi+ijJoAYHK+qLd1TLrzdawejupjN6sogsllFKiSQeAn
	4bULc/bSvMz6MnUftVg13hbmMM9VqgOjoH8gIYqMxd9ae7QuTEVljlbvPjZy19zS5qtV+A
	YP7mC8PAUdlB/KflPDUOvUWtd9XNsxo=
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
Subject: [PATCH bpf-next v4 2/2] bpf: Hold the perf callchain entry until used completely
Date: Wed, 29 Oct 2025 00:25:02 +0800
Message-ID: <20251028162502.3418817-3-chen.dylane@linux.dev>
In-Reply-To: <20251028162502.3418817-1-chen.dylane@linux.dev>
References: <20251028162502.3418817-1-chen.dylane@linux.dev>
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

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 kernel/bpf/stackmap.c | 61 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index e28b35c7e0b..70d38249083 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -188,13 +188,12 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 }
 
 static struct perf_callchain_entry *
-get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
+get_callchain_entry_for_task(int *rctx, struct task_struct *task, u32 max_depth)
 {
 #ifdef CONFIG_STACKTRACE
 	struct perf_callchain_entry *entry;
-	int rctx;
 
-	entry = get_callchain_entry(&rctx);
+	entry = get_callchain_entry(rctx);
 
 	if (!entry)
 		return NULL;
@@ -216,8 +215,6 @@ get_callchain_entry_for_task(struct task_struct *task, u32 max_depth)
 			to[i] = (u64)(from[i]);
 	}
 
-	put_callchain_entry(rctx);
-
 	return entry;
 #else /* CONFIG_STACKTRACE */
 	return NULL;
@@ -297,6 +294,31 @@ static long __bpf_get_stackid(struct bpf_map *map,
 	return id;
 }
 
+static struct perf_callchain_entry *
+bpf_get_perf_callchain(int *rctx, struct pt_regs *regs, bool kernel, bool user,
+		       int max_stack, bool crosstask)
+{
+	struct perf_callchain_entry_ctx ctx;
+	struct perf_callchain_entry *entry;
+
+	entry = get_callchain_entry(rctx);
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
+static void bpf_put_callchain_entry(int rctx)
+{
+	put_callchain_entry(rctx);
+}
+
 BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	   u64, flags)
 {
@@ -305,6 +327,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	bool user = flags & BPF_F_USER_STACK;
 	struct perf_callchain_entry *trace;
 	bool kernel = !user;
+	int rctx, ret;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -314,14 +337,15 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false);
-
+	trace = bpf_get_perf_callchain(&rctx, regs, kernel, user, max_depth, false);
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
 
-	return __bpf_get_stackid(map, trace, flags);
+	ret = __bpf_get_stackid(map, trace, flags);
+	bpf_put_callchain_entry(rctx);
+
+	return ret;
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
@@ -415,6 +439,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	bool kernel = !user;
 	int err = -EINVAL;
 	u64 *ips;
+	int rctx;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_USER_BUILD_ID)))
@@ -449,17 +474,24 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (trace_in)
 		trace = trace_in;
 	else if (kernel && task)
-		trace = get_callchain_entry_for_task(task, max_depth);
+		trace = get_callchain_entry_for_task(&rctx, task, max_depth);
 	else
-		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   crosstask);
+		trace = bpf_get_perf_callchain(&rctx, regs, kernel, user, max_depth, crosstask);
 
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
+			bpf_put_callchain_entry(rctx);
+		goto err_fault;
+	}
+
 	trace_nr = trace->nr - skip;
 	trace_nr = (trace_nr <= num_elem) ? trace_nr : num_elem;
 	copy_len = trace_nr * elem_size;
@@ -479,6 +511,9 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	if (may_fault)
 		rcu_read_unlock();
 
+	if (!trace_in)
+		bpf_put_callchain_entry(rctx);
+
 	if (user_build_id)
 		stack_map_get_build_id_offset(buf, trace_nr, user, may_fault);
 
-- 
2.48.1


