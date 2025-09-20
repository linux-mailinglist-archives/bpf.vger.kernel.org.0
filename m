Return-Path: <bpf+bounces-69048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5D2B8BBC6
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D81C219B2
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCF8263F44;
	Sat, 20 Sep 2025 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZL28fDK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AD6260592;
	Sat, 20 Sep 2025 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329989; cv=none; b=tAHcfkyFqJH+wadVCpJXTqFiN0VZE0i5ANcq25j5V7rAxuFb4B+QZBa2GmEzEMVwJ/9HRSxHMIGnJXKDx0dZRFgCLZ097DIykPZgzLyEZCHRPX6fabqc8K+9s/OuHShrqee8MTO5ArnvqphpsroxYVGUHvUbD4FjlDd9i4yTP2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329989; c=relaxed/simple;
	bh=ZovXVgvJbgne57qv36tXiuhbvu6li5QdYOL0paZtyu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GV0YXfDmeR/ZsmnT7HQBKq0Eyoorp6A3jjeqy7U+VivskcMAHCLGqgC3joW+boxqIgpWScTkpBV59rdlimM5Hp3+mpDaZYE3sBarJiEm4q3lA6OCUBgq1LAOAlSBHNy8Lu/6CSIeQJz5vvg0ZiM2wf9lwUC22ZJzPWLYlMGcTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZL28fDK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871A5C4CEF0;
	Sat, 20 Sep 2025 00:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329987;
	bh=ZovXVgvJbgne57qv36tXiuhbvu6li5QdYOL0paZtyu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qZL28fDK/gQWG59/KydwPH0b4KaDoidanoDQxh5P0bmvJ5Jfpg2HfDm4dUg3qas9c
	 obzznMC7d3HGNU2Kadd61XzOCYOn4w7tZ0cNLsVevTqSnyiTvaNzNmHIl7fYWOVWeQ
	 XwjvYO9Roe+JvfemlHbVvEVKt4mlRNQ5/OOggq7bvZBk6ET9B8eZCGw4LD2D1LQiU4
	 o6FAvBCzc9LM1QoDG9VKSUMGW5DAryLWaJqxA7U4Udm1UqFFUL28yCCbhPPtF8xLmA
	 +o5dxSvkHG97t52AlHMRYOH/SXSzRm5+awu1OOsOSxJLAk7EaIAHFXQPKUpoKUZd8d
	 gCCLNJpSub8zQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 13/46] sched_ext: Drop scx_kf_exit() and scx_kf_error()
Date: Fri, 19 Sep 2025 14:58:36 -1000
Message-ID: <20250920005931.2753828-14-tj@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920005931.2753828-1-tj@kernel.org>
References: <20250920005931.2753828-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intention behind scx_kf_exit/error() was that when called from kfuncs,
scx_kf_exit/error() would be able to implicitly determine the scx_sched
instance being operated on and thus wouldn't need the @sch parameter passed
in explicitly. This turned out to be unnecessarily complicated to implement
and not have enough practical benefits. Replace scx_kf_exit/error() usages
with scx_exit/error() which take an explicit @sch parameter.

- Add the @sch parameter to scx_kf_allowed(), scx_kf_allowed_on_arg_tasks,
  mark_direct_dispatch() and other intermediate functions transitively.

- In callers that don't already have @sch available, grab RCU, read
  $scx_root, verify it's not NULL and use it.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c      | 126 +++++++++++++++++++++++-----------------
 kernel/sched/ext_idle.c |  25 +++++---
 2 files changed, 88 insertions(+), 63 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1455f8c56d5c..0c99a55f199b 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -151,24 +151,7 @@ static __printf(4, 5) void scx_exit(struct scx_sched *sch,
 	va_end(args);
 }
 
-static __printf(3, 4) void scx_kf_exit(enum scx_exit_kind kind, s64 exit_code,
-				       const char *fmt, ...)
-{
-	struct scx_sched *sch;
-	va_list args;
-
-	rcu_read_lock();
-	sch = rcu_dereference(scx_root);
-	if (sch) {
-		va_start(args, fmt);
-		scx_vexit(sch, kind, exit_code, fmt, args);
-		va_end(args);
-	}
-	rcu_read_unlock();
-}
-
 #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
-#define scx_kf_error(fmt, args...)	scx_kf_exit(SCX_EXIT_ERROR, 0, fmt, ##args)
 
 #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
 
@@ -329,11 +312,11 @@ do {										\
 })
 
 /* @mask is constant, always inline to cull unnecessary branches */
-static __always_inline bool scx_kf_allowed(u32 mask)
+static __always_inline bool scx_kf_allowed(struct scx_sched *sch, u32 mask)
 {
 	if (unlikely(!(current->scx.kf_mask & mask))) {
-		scx_kf_error("kfunc with mask 0x%x called from an operation only allowing 0x%x",
-			     mask, current->scx.kf_mask);
+		scx_error(sch, "kfunc with mask 0x%x called from an operation only allowing 0x%x",
+			  mask, current->scx.kf_mask);
 		return false;
 	}
 
@@ -346,13 +329,13 @@ static __always_inline bool scx_kf_allowed(u32 mask)
 	 */
 	if (unlikely(highest_bit(mask) == SCX_KF_CPU_RELEASE &&
 		     (current->scx.kf_mask & higher_bits(SCX_KF_CPU_RELEASE)))) {
-		scx_kf_error("cpu_release kfunc called from a nested operation");
+		scx_error(sch, "cpu_release kfunc called from a nested operation");
 		return false;
 	}
 
 	if (unlikely(highest_bit(mask) == SCX_KF_DISPATCH &&
 		     (current->scx.kf_mask & higher_bits(SCX_KF_DISPATCH)))) {
-		scx_kf_error("dispatch kfunc called from a nested operation");
+		scx_error(sch, "dispatch kfunc called from a nested operation");
 		return false;
 	}
 
@@ -360,15 +343,16 @@ static __always_inline bool scx_kf_allowed(u32 mask)
 }
 
 /* see SCX_CALL_OP_TASK() */
-static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
+static __always_inline bool scx_kf_allowed_on_arg_tasks(struct scx_sched *sch,
+							u32 mask,
 							struct task_struct *p)
 {
-	if (!scx_kf_allowed(mask))
+	if (!scx_kf_allowed(sch, mask))
 		return false;
 
 	if (unlikely((p != current->scx.kf_tasks[0] &&
 		      p != current->scx.kf_tasks[1]))) {
-		scx_kf_error("called on a task not being operated on");
+		scx_error(sch, "called on a task not being operated on");
 		return false;
 	}
 
@@ -1115,7 +1099,8 @@ static struct scx_dispatch_q *find_dsq_for_dispatch(struct scx_sched *sch,
 	return dsq;
 }
 
-static void mark_direct_dispatch(struct task_struct *ddsp_task,
+static void mark_direct_dispatch(struct scx_sched *sch,
+				 struct task_struct *ddsp_task,
 				 struct task_struct *p, u64 dsq_id,
 				 u64 enq_flags)
 {
@@ -1129,10 +1114,10 @@ static void mark_direct_dispatch(struct task_struct *ddsp_task,
 	/* @p must match the task on the enqueue path */
 	if (unlikely(p != ddsp_task)) {
 		if (IS_ERR(ddsp_task))
-			scx_kf_error("%s[%d] already direct-dispatched",
+			scx_error(sch, "%s[%d] already direct-dispatched",
 				  p->comm, p->pid);
 		else
-			scx_kf_error("scheduling for %s[%d] but trying to direct-dispatch %s[%d]",
+			scx_error(sch, "scheduling for %s[%d] but trying to direct-dispatch %s[%d]",
 				  ddsp_task->comm, ddsp_task->pid,
 				  p->comm, p->pid);
 		return;
@@ -5243,18 +5228,18 @@ void __init init_sched_ext_class(void)
 static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p,
 				    u64 enq_flags)
 {
-	if (!scx_kf_allowed(SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
+	if (!scx_kf_allowed(sch, SCX_KF_ENQUEUE | SCX_KF_DISPATCH))
 		return false;
 
 	lockdep_assert_irqs_disabled();
 
 	if (unlikely(!p)) {
-		scx_kf_error("called with NULL task");
+		scx_error(sch, "called with NULL task");
 		return false;
 	}
 
 	if (unlikely(enq_flags & __SCX_ENQ_INTERNAL_MASK)) {
-		scx_kf_error("invalid enq_flags 0x%llx", enq_flags);
+		scx_error(sch, "invalid enq_flags 0x%llx", enq_flags);
 		return false;
 	}
 
@@ -5269,12 +5254,12 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 
 	ddsp_task = __this_cpu_read(direct_dispatch_task);
 	if (ddsp_task) {
-		mark_direct_dispatch(ddsp_task, p, dsq_id, enq_flags);
+		mark_direct_dispatch(sch, ddsp_task, p, dsq_id, enq_flags);
 		return;
 	}
 
 	if (unlikely(dspc->cursor >= scx_dsp_max_batch)) {
-		scx_kf_error("dispatch buffer overflow");
+		scx_error(sch, "dispatch buffer overflow");
 		return;
 	}
 
@@ -5410,7 +5395,8 @@ static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
 	bool in_balance;
 	unsigned long flags;
 
-	if (!scx_kf_allowed_if_unlocked() && !scx_kf_allowed(SCX_KF_DISPATCH))
+	if (!scx_kf_allowed_if_unlocked() &&
+	    !scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
 	/*
@@ -5495,7 +5481,15 @@ __bpf_kfunc_start_defs();
  */
 __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
 {
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return 0;
+
+	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return 0;
 
 	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
@@ -5510,14 +5504,21 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(void)
 __bpf_kfunc void scx_bpf_dispatch_cancel(void)
 {
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_sched *sch;
 
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return;
+
+	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return;
 
 	if (dspc->cursor > 0)
 		dspc->cursor--;
 	else
-		scx_kf_error("dispatch buffer underflow");
+		scx_error(sch, "dispatch buffer underflow");
 }
 
 /**
@@ -5540,7 +5541,7 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id)
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
 
-	if (!scx_kf_allowed(SCX_KF_DISPATCH))
+	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
 	flush_dispatch_buf(sch, dspc->rq);
@@ -5687,12 +5688,18 @@ __bpf_kfunc_start_defs();
  */
 __bpf_kfunc u32 scx_bpf_reenqueue_local(void)
 {
+	struct scx_sched *sch;
 	LIST_HEAD(tasks);
 	u32 nr_enqueued = 0;
 	struct rq *rq;
 	struct task_struct *p, *n;
 
-	if (!scx_kf_allowed(SCX_KF_CPU_RELEASE))
+	guard(rcu)();
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return 0;
+
+	if (!scx_kf_allowed(sch, SCX_KF_CPU_RELEASE))
 		return 0;
 
 	rq = cpu_rq(smp_processor_id());
@@ -5837,7 +5844,7 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 		struct rq *target_rq = cpu_rq(cpu);
 
 		if (unlikely(flags & (SCX_KICK_PREEMPT | SCX_KICK_WAIT)))
-			scx_kf_error("PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
+			scx_error(sch, "PREEMPT/WAIT cannot be used with SCX_KICK_IDLE");
 
 		if (raw_spin_rq_trylock(target_rq)) {
 			if (can_skip_idle_kick(target_rq)) {
@@ -6070,20 +6077,20 @@ static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
 
 	if (data__sz % 8 || data__sz > MAX_BPRINTF_VARARGS * 8 ||
 	    (data__sz && !data)) {
-		scx_kf_error("invalid data=%p and data__sz=%u", (void *)data, data__sz);
+		scx_error(sch, "invalid data=%p and data__sz=%u", (void *)data, data__sz);
 		return -EINVAL;
 	}
 
 	ret = copy_from_kernel_nofault(data_buf, data, data__sz);
 	if (ret < 0) {
-		scx_kf_error("failed to read data fields (%d)", ret);
+		scx_error(sch, "failed to read data fields (%d)", ret);
 		return ret;
 	}
 
 	ret = bpf_bprintf_prepare(fmt, UINT_MAX, data_buf, data__sz / 8,
 				  &bprintf_data);
 	if (ret < 0) {
-		scx_kf_error("format preparation failed (%d)", ret);
+		scx_error(sch, "format preparation failed (%d)", ret);
 		return ret;
 	}
 
@@ -6091,7 +6098,7 @@ static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
 			  bprintf_data.bin_args);
 	bpf_bprintf_cleanup(&bprintf_data);
 	if (ret < 0) {
-		scx_kf_error("(\"%s\", %p, %u) failed to format", fmt, data, data__sz);
+		scx_error(sch, "(\"%s\", %p, %u) failed to format", fmt, data, data__sz);
 		return ret;
 	}
 
@@ -6127,7 +6134,7 @@ __bpf_kfunc void scx_bpf_exit_bstr(s64 exit_code, char *fmt,
 	sch = rcu_dereference_bh(scx_root);
 	if (likely(sch) &&
 	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
-		scx_kf_exit(SCX_EXIT_UNREG_BPF, exit_code, "%s", scx_exit_bstr_buf.line);
+		scx_exit(sch, SCX_EXIT_UNREG_BPF, exit_code, "%s", scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
 }
 
@@ -6150,7 +6157,7 @@ __bpf_kfunc void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
 	sch = rcu_dereference_bh(scx_root);
 	if (likely(sch) &&
 	    bstr_format(sch, &scx_exit_bstr_buf, fmt, data, data__sz) >= 0)
-		scx_kf_exit(SCX_EXIT_ERROR_BPF, 0, "%s", scx_exit_bstr_buf.line);
+		scx_exit(sch, SCX_EXIT_ERROR_BPF, 0, "%s", scx_exit_bstr_buf.line);
 	raw_spin_unlock_irqrestore(&scx_exit_bstr_buf_lock, flags);
 }
 
@@ -6181,7 +6188,7 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 		return;
 
 	if (raw_smp_processor_id() != dd->cpu) {
-		scx_kf_error("scx_bpf_dump() must only be called from ops.dump() and friends");
+		scx_error(sch, "scx_bpf_dump() must only be called from ops.dump() and friends");
 		return;
 	}
 
@@ -6285,7 +6292,7 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
 		return;
 
 	if (unlikely(perf > SCX_CPUPERF_ONE)) {
-		scx_kf_error("Invalid cpuperf target %u for CPU %d", perf, cpu);
+		scx_error(sch, "Invalid cpuperf target %u for CPU %d", perf, cpu);
 		return;
 	}
 
@@ -6298,7 +6305,7 @@ __bpf_kfunc void scx_bpf_cpuperf_set(s32 cpu, u32 perf)
 		 * to the corresponding CPU to prevent ABBA deadlocks.
 		 */
 		if (locked_rq && rq != locked_rq) {
-			scx_kf_error("Invalid target CPU %d", cpu);
+			scx_error(sch, "Invalid target CPU %d", cpu);
 			return;
 		}
 
@@ -6422,16 +6429,20 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
  */
 __bpf_kfunc struct rq *scx_bpf_locked_rq(void)
 {
+	struct scx_sched *sch;
 	struct rq *rq;
 
-	preempt_disable();
+	guard(preempt)();
+
+	sch = rcu_dereference_sched(scx_root);
+	if (unlikely(!sch))
+		return NULL;
+
 	rq = scx_locked_rq();
 	if (!rq) {
-		preempt_enable();
-		scx_kf_error("accessing rq without holding rq lock");
+		scx_error(sch, "accessing rq without holding rq lock");
 		return NULL;
 	}
-	preempt_enable();
 
 	return rq;
 }
@@ -6474,8 +6485,15 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
 {
 	struct task_group *tg = p->sched_task_group;
 	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		goto out;
 
-	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
+	if (!scx_kf_allowed_on_arg_tasks(sch, __SCX_KF_RQ_LOCKED, p))
 		goto out;
 
 	cgrp = tg_cgrp(tg);
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index a576ec10522e..c57779f0ad57 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -822,7 +822,7 @@ void scx_idle_disable(void)
 static int validate_node(struct scx_sched *sch, int node)
 {
 	if (!static_branch_likely(&scx_builtin_idle_per_node)) {
-		scx_kf_error("per-node idle tracking is disabled");
+		scx_error(sch, "per-node idle tracking is disabled");
 		return -EOPNOTSUPP;
 	}
 
@@ -832,13 +832,13 @@ static int validate_node(struct scx_sched *sch, int node)
 
 	/* Make sure node is in a valid range */
 	if (node < 0 || node >= nr_node_ids) {
-		scx_kf_error("invalid node %d", node);
+		scx_error(sch, "invalid node %d", node);
 		return -EINVAL;
 	}
 
 	/* Make sure the node is part of the set of possible nodes */
 	if (!node_possible(node)) {
-		scx_kf_error("unavailable node %d", node);
+		scx_error(sch, "unavailable node %d", node);
 		return -EINVAL;
 	}
 
@@ -852,7 +852,7 @@ static bool check_builtin_idle_enabled(struct scx_sched *sch)
 	if (static_branch_likely(&scx_builtin_idle_enabled))
 		return true;
 
-	scx_kf_error("built-in idle tracking is disabled");
+	scx_error(sch, "built-in idle tracking is disabled");
 	return false;
 }
 
@@ -880,7 +880,7 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 	if (scx_kf_allowed_if_unlocked()) {
 		rq = task_rq_lock(p, &rf);
 	} else {
-		if (!scx_kf_allowed(SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE))
+		if (!scx_kf_allowed(sch, SCX_KF_SELECT_CPU | SCX_KF_ENQUEUE))
 			return -EPERM;
 		rq = scx_locked_rq();
 	}
@@ -1048,7 +1048,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask(void)
 		return cpu_none_mask;
 
 	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
-		scx_kf_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		scx_error(sch, "SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
 		return cpu_none_mask;
 	}
 
@@ -1107,7 +1107,7 @@ __bpf_kfunc const struct cpumask *scx_bpf_get_idle_smtmask(void)
 		return cpu_none_mask;
 
 	if (static_branch_unlikely(&scx_builtin_idle_per_node)) {
-		scx_kf_error("SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
+		scx_error(sch, "SCX_OPS_BUILTIN_IDLE_PER_NODE enabled");
 		return cpu_none_mask;
 	}
 
@@ -1235,7 +1235,7 @@ __bpf_kfunc s32 scx_bpf_pick_idle_cpu(const struct cpumask *cpus_allowed,
 		return -ENODEV;
 
 	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
-		scx_kf_error("per-node idle tracking is enabled");
+		scx_error(sch, "per-node idle tracking is enabled");
 		return -EBUSY;
 	}
 
@@ -1316,10 +1316,17 @@ __bpf_kfunc s32 scx_bpf_pick_any_cpu_node(const struct cpumask *cpus_allowed,
 __bpf_kfunc s32 scx_bpf_pick_any_cpu(const struct cpumask *cpus_allowed,
 				     u64 flags)
 {
+	struct scx_sched *sch;
 	s32 cpu;
 
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (unlikely(!sch))
+		return -ENODEV;
+
 	if (static_branch_maybe(CONFIG_NUMA, &scx_builtin_idle_per_node)) {
-		scx_kf_error("per-node idle tracking is enabled");
+		scx_error(sch, "per-node idle tracking is enabled");
 		return -EBUSY;
 	}
 
-- 
2.51.0


