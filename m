Return-Path: <bpf+bounces-69080-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474EBB8BC9F
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483CAB62702
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F012E7BBB;
	Sat, 20 Sep 2025 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDOW1W/4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED02E7BDA;
	Sat, 20 Sep 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330023; cv=none; b=C1qDOETT2fQSdUpJsKGfdmciHYYDqlxcIfmBxjZQzIktckc5QuwJVNWFpSU/hy5mFjeuBfISGF4+FiQKPn9C8Bc7Q/65Ya4RgpZhfnNDhB/k7Avn+F7bZF/Fr51z3mUCHQ8wDZFCerEuNl/7VIzuWi009FWlLgnoxx+m63Tu7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330023; c=relaxed/simple;
	bh=H5RM8PLZUSiKjhGEDcC+asXpNUC+GAHDLO1nQGxWiJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnxJX1wHjQiLQwpWdGc3P0j42tqgWVboWhA3bi914L9u78qSqMsLF1HFTx/f5LvLgkDyUE4puFvzK9WAMOWfrByWtmFf/gIe4xEBHwE/2KavCezSs2zeti/tbSH8y1NnYwlFakO7cgKOwjuD61SBUqFclbPlb++6Vo8rN+bP0ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDOW1W/4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F30EC4CEF5;
	Sat, 20 Sep 2025 01:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330023;
	bh=H5RM8PLZUSiKjhGEDcC+asXpNUC+GAHDLO1nQGxWiJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDOW1W/4C4ppKlY3Xibua/BbfKDiPc93o7hEhs9ZvdnSzsNghDsuZWcYZrqxXrXE3
	 I6Cj14KLcuwkgEyGMR5IoOiX3ME64ULI5byhDLJ10/l9/EkIVZL1S5S8vMKDKqYskw
	 ZGw0ZkhIIyJlLPkko3bMSb7DkVrnaPtcUEXA+dzhkNOgDpEaS6gyqohPveNjMohfsi
	 LLGOApwveKnBSpi8PF7n9py3sUt1/W5eXrBKeZPRFa2k4+2P8bt6xqKouZFdLcbB70
	 Yv7W6jw6G3hIN6y0zCKvRgKtcLY+7DzixEYSmEb+caWJ7nZlXScp0/gZaMAuJ/RN2M
	 oy9mITD14mX4Q==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 46/46] sched_ext: Add basic building blocks for nested sub-scheduler dispatching
Date: Fri, 19 Sep 2025 14:59:09 -1000
Message-ID: <20250920005931.2753828-47-tj@kernel.org>
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

This is an early-stage partial implementation that demonstrates the core
building blocks for nested sub-scheduler dispatching. While significant
work remains in the enqueue path and other areas, this patch establishes
the fundamental mechanisms needed for hierarchical scheduler operation.

The key building blocks introduced include:

- Private stack support for ops.dispatch() to prevent stack overflow when
  walking down nested schedulers during dispatch operations

- scx_bpf_sub_dispatch() kfunc that allows parent schedulers to trigger
  dispatch operations on their direct child schedulers

- Proper parent-child relationship validation to ensure dispatch requests
  are only made to legitimate child schedulers

- Updated scx_dispatch_sched() to handle both nested and non-nested
  invocations with appropriate kf_mask handling

The qmap scheduler is updated to demonstrate the functionality by calling
scx_bpf_sub_dispatch() on registered child schedulers when it has no
tasks in its own queues.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       | 116 ++++++++++++++++++++---
 kernel/sched/sched.h                     |   3 +
 tools/sched_ext/include/scx/common.bpf.h |   2 +
 tools/sched_ext/scx_qmap.bpf.c           |  37 +++++++-
 4 files changed, 145 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 0d865e017115..99462d0da543 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2253,8 +2253,14 @@ static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
 	dspc->cursor = 0;
 }
 
-static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
-			       struct task_struct *prev)
+/*
+ * One user of this function is scx_bpf_dispatch() which can be called
+ * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
+ * from the call frame.
+ */
+static __always_inline bool
+scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
+		   struct task_struct *prev, bool nested)
 {
 	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
@@ -2280,8 +2286,23 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	do {
 		dspc->nr_tasks = 0;
 
-		SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq,
-			    cpu_of(rq), prev_on_sch ? prev : NULL);
+		if (nested) {
+			/*
+			 * If nested, don't update kf_mask as the originating
+			 * invocation would already have set it up.
+			 */
+			SCX_CALL_OP(sch, 0, dispatch, rq,
+				    cpu_of(rq), prev_on_sch ? prev : NULL);
+		} else {
+			/*
+			 * If not nested, stash @prev so that nested invocations
+			 * can access it.
+			 */
+			rq->scx.sub_dispatch_prev = prev;
+			SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq,
+				    cpu_of(rq), prev_on_sch ? prev : NULL);
+			rq->scx.sub_dispatch_prev = NULL;
+		}
 
 		flush_dispatch_buf(sch, rq);
 
@@ -2314,7 +2335,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root, *pos;
+	struct scx_sched *sch = scx_root;
 
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |= SCX_RQ_IN_BALANCE;
@@ -2358,13 +2379,8 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (rq->scx.local_dsq.nr)
 		goto has_tasks;
 
-	/*
-	 * TEMPORARY - Dispatch all scheds. This will be replaced by BPF-driven
-	 * hierarchical operation.
-	 */
-	list_for_each_entry_rcu(pos, &scx_sched_all, all)
-		if (scx_dispatch_sched(pos, rq, prev))
-			goto has_tasks;
+	if (scx_dispatch_sched(sch, rq, prev, false))
+		goto has_tasks;
 
 	/*
 	 * Didn't find another task to run. Keep running @prev unless
@@ -5883,6 +5899,20 @@ static int bpf_scx_init_member(const struct btf_type *t,
 	return 0;
 }
 
+#ifdef CONFIG_EXT_SUB_SCHED
+static void scx_pstack_recursion_on_dispatch(struct bpf_prog *prog)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(prog->aux);
+	if (unlikely(!sch))
+		return;
+
+	scx_error(sch, "dispatch recursion detected");
+}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 static int bpf_scx_check_member(const struct btf_type *t,
 				const struct btf_member *member,
 				const struct bpf_prog *prog)
@@ -5908,6 +5938,22 @@ static int bpf_scx_check_member(const struct btf_type *t,
 			return -EINVAL;
 	}
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * Enable private stack for operations that can nest along the
+	 * hierarchy.
+	 *
+	 * XXX - Ideally, we should only do this for scheds that allow
+	 * sub-scheds and sub-scheds themselves but I don't know how to access
+	 * struct_ops from here.
+	 */
+	switch (moff) {
+	case offsetof(struct sched_ext_ops, dispatch):
+		prog->aux->priv_stack_requested = true;
+		prog->aux->recursion_detected = scx_pstack_recursion_on_dispatch;
+	}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 	return 0;
 }
 
@@ -6799,6 +6845,49 @@ __bpf_kfunc bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter,
 			    p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
 }
 
+#ifdef CONFIG_EXT_SUB_SCHED
+/**
+ * scx_bpf_sub_dispatch - Trigger dispatching on a child scheduler
+ * @cgroup_id: cgroup ID of the child scheduler to dispatch
+ * @aux__prog: magic BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Allows a parent scheduler to trigger dispatching on one of its direct
+ * child schedulers. The child scheduler runs its dispatch operation to
+ * move tasks from dispatch queues to the local runqueue.
+ *
+ * Returns: true on success, false if cgroup_id is invalid, not a direct
+ * child, or caller lacks dispatch permission.
+ */
+__bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id,
+				      const struct bpf_prog_aux *aux__prog)
+{
+	struct rq *this_rq = this_rq();
+	struct scx_sched *parent, *child;
+
+	guard(rcu)();
+	parent = scx_prog_sched(aux__prog);
+	if (unlikely(!parent))
+		return false;
+
+	if (!scx_kf_allowed(parent, SCX_KF_DISPATCH))
+		return false;
+
+	child = scx_find_sub_sched(cgroup_id);
+
+	if (unlikely(!child))
+		return false;
+
+	if (unlikely(scx_parent(child) != parent)) {
+		scx_error(parent, "trying to dispatch a distant sub-sched on cgroup %llu",
+			  cgroup_id);
+		return false;
+	}
+
+	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_prev,
+				  true);
+}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
@@ -6809,6 +6898,9 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
+#ifdef CONFIG_EXT_SUB_SCHED
+BTF_ID_FLAGS(func, scx_bpf_sub_dispatch)
+#endif
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index cd6bdcdf9314..0aa0caa84308 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -777,6 +777,9 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_preempt;
 	cpumask_var_t		cpus_to_wait;
 	unsigned long		pnt_seq;
+
+	struct task_struct	*sub_dispatch_prev;
+
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 6bf75f970237..a1890790d58c 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -140,6 +140,8 @@ struct cgroup *scx_bpf_task_cgroup(struct task_struct *p, const struct bpf_prog_
 #define scx_bpf_task_cgroup(p) scx_bpf_task_cgroup((p), NULL)
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
+bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+#define scx_bpf_sub_dispatch(cgroup_id) scx_bpf_sub_dispatch((cgroup_id), NULL)
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 15e15cb234dc..9927cd1064e7 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -48,6 +48,9 @@ const volatile bool suppress_dump;
 u64 nr_highpri_queued;
 u32 test_error_cnt;
 
+#define MAX_SUB_SCHEDS		8
+u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
+
 UEI_DEFINE(uei);
 
 struct qmap {
@@ -452,6 +455,12 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 		cpuc->dsp_cnt = 0;
 	}
 
+	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
+		if (sub_sched_cgroup_ids[i] &&
+		    scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
+			return;
+	}
+
 	/*
 	 * No other tasks. @prev will keep running. Update its core_sched_seq as
 	 * if the task were enqueued and dispatched immediately.
@@ -877,7 +886,32 @@ void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
 
 s32 BPF_STRUCT_OPS(qmap_sub_attach, struct scx_sub_attach_args *args)
 {
-	return 0;
+	int i;
+
+	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
+		if (!sub_sched_cgroup_ids[i]) {
+			sub_sched_cgroup_ids[i] = args->ops->sub_cgroup_id;
+			bpf_printk("attaching sub-sched[%d] on %s",
+				   i, args->cgroup_path);
+			return 0;
+		}
+	}
+
+	return -ENOSPC;
+}
+
+void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
+{
+	int i;
+
+	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
+		if (sub_sched_cgroup_ids[i] == args->ops->sub_cgroup_id) {
+			sub_sched_cgroup_ids[i] = 0;
+			bpf_printk("detaching sub-sched[%d] on %s",
+				   i, args->cgroup_path);
+			break;
+		}
+	}
 }
 
 SCX_OPS_DEFINE(qmap_ops,
@@ -896,6 +930,7 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .cgroup_set_weight	= (void *)qmap_cgroup_set_weight,
 	       .cgroup_set_bandwidth	= (void *)qmap_cgroup_set_bandwidth,
 	       .sub_attach		= (void *)qmap_sub_attach,
+	       .sub_detach		= (void *)qmap_sub_detach,
 	       .cpu_online		= (void *)qmap_cpu_online,
 	       .cpu_offline		= (void *)qmap_cpu_offline,
 	       .init			= (void *)qmap_init,
-- 
2.51.0


