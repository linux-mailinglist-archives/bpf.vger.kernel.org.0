Return-Path: <bpf+bounces-69065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 459A6B8BC2C
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB051C22674
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC54A2DCF57;
	Sat, 20 Sep 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/VLxki/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238822DC774;
	Sat, 20 Sep 2025 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330008; cv=none; b=GBOxWXlXUOBe9bFJ2ydenvv067nmyIcbVUNgmF6k7ot4uPrDxU4o8ZBYZn0QawXD8CLEoSvWXFzWuDFZVXZa3bkhOETvjC6KU1zbh1n2qMvmDq6vBcENWQ+YcXRZJH9kXXQMzHYT0cCs/AzwxN8MPrsYN1f2PZx4O7Pa30hYEWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330008; c=relaxed/simple;
	bh=TAkAW9x7u+WRS0Mf8gluXxV6gtOJuasdHYc2bHNtf4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/z+/uqfezkONXZUb3qi6y/SgbicwC1tEPC8nVobzYdqLmG61TvudxnmzFFC56RMxl3yInqOpy9+BAiPaKt9yTcZ2KDrUc5cl1L/g/1r46U3ajqz/IiuCKlPYl22ORdaabEeYUGZaHrwRAVtQaFKqLAQ/+V6ER/kBv6trSYcMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/VLxki/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB39C4CEF0;
	Sat, 20 Sep 2025 01:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330008;
	bh=TAkAW9x7u+WRS0Mf8gluXxV6gtOJuasdHYc2bHNtf4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A/VLxki/OujzM1eZgZdUeaUJq8DUqSOUOjIky/3q2j5yKuMPCw7wo2gWXAjpL0ESL
	 fdzuR7Pgt6i3TSHJAU6t3/qt/NinQa61ozKS0fNPm17ntWoo0NfgDoP00LQn4PqhOg
	 FRH/A7ez4Oucm4pTSzAY828pWEGW2m4F1MNTsbk+Dlq9netWQe1LtvxcoXoX2+jglf
	 9Jc/pqI/oDgR5Occ8EHKtXVwLQKGqZ8z9jMp95zIoqGTc86w8wU2lHOpNGgG78SIn6
	 G/NsywOoL1OBaLqxKIzsHktK/erWiYYzBU8KZElioBNJzvoWT9XeiufWM6hzVpNhff
	 YZ0exoF+kT6iA==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 31/46] sched_ext: Move bypass_depth into scx_sched
Date: Fri, 19 Sep 2025 14:58:54 -1000
Message-ID: <20250920005931.2753828-32-tj@kernel.org>
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

In preparation of multiple scheduler support, make bypass state
per-scx_sched:

- Replace global scx_bypass_depth with scx_sched_pcpu->bypass_depth.

- SCX_RQ_BYPASSING is replaced with SCX_SCHED_PCPU_BYPASSING which is stored
  in newly added scx_sched_pcpu->flags.

- Add @sch to scx_bypass().

- Rename scx_rq_bypassing() to scx_bypassing() and replace @rq with @cpu as
  the state is now in scx_sched_pcpu.

No behavior changes expected.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 100 ++++++++++++++++++++----------------
 kernel/sched/ext_idle.c     |   3 +-
 kernel/sched/ext_internal.h |  12 ++++-
 kernel/sched/sched.h        |   1 -
 4 files changed, 67 insertions(+), 49 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b8a1a950c74..5f22a79e19ec 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -51,7 +51,6 @@ DEFINE_STATIC_PERCPU_RWSEM(scx_fork_rwsem);
 static atomic_t scx_enable_state_var = ATOMIC_INIT(SCX_DISABLED);
 static unsigned long scx_in_softlockup;
 static atomic_t scx_breather_depth = ATOMIC_INIT(0);
-static int scx_bypass_depth;
 static bool scx_init_task_enabled;
 static bool scx_switching_all;
 DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
@@ -1382,7 +1381,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	if (!scx_rq_online(rq))
 		goto local;
 
-	if (scx_rq_bypassing(rq)) {
+	if (scx_bypassing(sch, cpu_of(rq))) {
 		__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
 		goto global;
 	}
@@ -2218,7 +2217,8 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * See scx_disable_workfn() for the explanation on the bypassing
 		 * test.
 		 */
-		if (prev_on_rq && prev->scx.slice && !scx_rq_bypassing(rq)) {
+		if (prev_on_rq && prev->scx.slice &&
+		    !scx_bypassing(sch, cpu_of(rq))) {
 			rq->scx.flags |= SCX_RQ_BAL_KEEP;
 			goto has_tasks;
 		}
@@ -2232,7 +2232,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		goto has_tasks;
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) ||
-	    scx_rq_bypassing(rq) || !scx_rq_online(rq))
+	    scx_bypassing(sch, cpu_of(rq)) || !scx_rq_online(rq))
 		goto no_tasks;
 
 	dspc->rq = rq;
@@ -2282,7 +2282,8 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
 	if (prev_on_rq &&
-	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_rq_bypassing(rq))) {
+	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) ||
+	     scx_bypassing(sch, cpu_of(rq)))) {
 		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		__scx_add_event(sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
 		goto has_tasks;
@@ -2477,7 +2478,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		 * forcing a different task. Leave it at the head of the local
 		 * DSQ.
 		 */
-		if (p->scx.slice && !scx_rq_bypassing(rq)) {
+		if (p->scx.slice && !scx_bypassing(sch, cpu_of(rq))) {
 			dispatch_enqueue(sch, &rq->scx.local_dsq, p,
 					 SCX_ENQ_HEAD);
 			goto switch_class;
@@ -2568,7 +2569,8 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 		if (unlikely(!p->scx.slice)) {
 			struct scx_sched *sch = scx_task_sched(p);
 
-			if (!scx_rq_bypassing(rq) && !sch->warned_zero_slice) {
+			if (!scx_bypassing(sch, cpu_of(rq)) &&
+			    !sch->warned_zero_slice) {
 				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in %s()\n",
 						p->comm, p->pid, __func__);
 				sch->warned_zero_slice = true;
@@ -2611,7 +2613,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	 * verifier.
 	 */
 	if (sch_a == sch_b && SCX_HAS_OP(sch_a, core_sched_before) &&
-	    !scx_rq_bypassing(task_rq(a)))
+	    !scx_bypassing(sch_a, task_cpu(a)))
 		return SCX_CALL_OP_2TASKS_RET(sch_a, SCX_KF_REST, core_sched_before,
 					      NULL,
 					      (struct task_struct *)a,
@@ -2624,7 +2626,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flags)
 {
 	struct scx_sched *sch = scx_task_sched(p);
-	bool rq_bypass;
+	bool bypassing;
 
 	/*
 	 * sched_exec() calls with %WF_EXEC when @p is about to exec(2) as it
@@ -2639,8 +2641,8 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	if (unlikely(wake_flags & WF_EXEC))
 		return prev_cpu;
 
-	rq_bypass = scx_rq_bypassing(task_rq(p));
-	if (likely(SCX_HAS_OP(sch, select_cpu)) && !rq_bypass) {
+	bypassing = scx_bypassing(sch, task_cpu(p));
+	if (likely(SCX_HAS_OP(sch, select_cpu)) && !bypassing) {
 		s32 cpu;
 		struct task_struct **ddsp_taskp;
 
@@ -2670,7 +2672,7 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 		}
 		p->scx.selected_cpu = cpu;
 
-		if (rq_bypass)
+		if (bypassing)
 			__scx_add_event(sch, SCX_EV_BYPASS_DISPATCH, 1);
 		return cpu;
 	}
@@ -2833,7 +2835,7 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 	 * While disabling, always resched and refresh core-sched timestamp as
 	 * we can't trust the slice management or ops.core_sched_before().
 	 */
-	if (scx_rq_bypassing(rq)) {
+	if (scx_bypassing(sch, cpu_of(rq))) {
 		curr->scx.slice = 0;
 		touch_core_sched(rq, curr);
 	} else if (SCX_HAS_OP(sch, tick)) {
@@ -3217,13 +3219,14 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 bool scx_can_stop_tick(struct rq *rq)
 {
 	struct task_struct *p = rq->curr;
-
-	if (scx_rq_bypassing(rq))
-		return false;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	if (p->sched_class != &ext_sched_class)
 		return true;
 
+	if (scx_bypassing(sch, cpu_of(rq)))
+		return false;
+
 	/*
 	 * @rq can dispatch from different DSQs, so we can't tell whether it
 	 * needs the tick or not by looking at nr_running. Allow stopping ticks
@@ -3942,40 +3945,37 @@ static void scx_clear_softlockup(void)
  *
  * - scx_prio_less() reverts to the default core_sched_at order.
  */
-static void scx_bypass(bool bypass)
+static void scx_bypass(struct scx_sched *sch, bool bypass)
 {
 	static DEFINE_RAW_SPINLOCK(bypass_lock);
 	static unsigned long bypass_timestamp;
-	struct scx_sched *sch;
 	unsigned long flags;
 	int cpu;
 
 	raw_spin_lock_irqsave(&bypass_lock, flags);
-	sch = rcu_dereference_bh(scx_root);
 
 	if (bypass) {
-		scx_bypass_depth++;
-		WARN_ON_ONCE(scx_bypass_depth <= 0);
-		if (scx_bypass_depth != 1)
+		sch->bypass_depth++;
+		WARN_ON_ONCE(sch->bypass_depth <= 0);
+		if (sch->bypass_depth != 1)
 			goto unlock;
 		bypass_timestamp = ktime_get_ns();
-		if (sch)
-			scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
+		scx_add_event(sch, SCX_EV_BYPASS_ACTIVATE, 1);
 	} else {
-		scx_bypass_depth--;
-		WARN_ON_ONCE(scx_bypass_depth < 0);
-		if (scx_bypass_depth != 0)
+		sch->bypass_depth--;
+		WARN_ON_ONCE(sch->bypass_depth < 0);
+		if (sch->bypass_depth != 0)
 			goto unlock;
-		if (sch)
-			scx_add_event(sch, SCX_EV_BYPASS_DURATION,
-				      ktime_get_ns() - bypass_timestamp);
+		scx_add_event(sch, SCX_EV_BYPASS_DURATION,
+			      ktime_get_ns() - bypass_timestamp);
 	}
 
-	atomic_inc(&scx_breather_depth);
+	if (!scx_parent(sch))
+		atomic_inc(&scx_breather_depth);
 
 	/*
 	 * No task property is changing. We just need to make sure all currently
-	 * queued tasks are re-queued according to the new scx_rq_bypassing()
+	 * queued tasks are re-queued according to the new scx_bypassing()
 	 * state. As an optimization, walk each rq's runnable_list instead of
 	 * the scx_tasks list.
 	 *
@@ -3984,22 +3984,23 @@ static void scx_bypass(bool bypass)
 	 */
 	for_each_possible_cpu(cpu) {
 		struct rq *rq = cpu_rq(cpu);
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
 		struct task_struct *p, *n;
 
 		raw_spin_rq_lock(rq);
 
 		if (bypass) {
-			WARN_ON_ONCE(rq->scx.flags & SCX_RQ_BYPASSING);
-			rq->scx.flags |= SCX_RQ_BYPASSING;
+			WARN_ON_ONCE(pcpu->flags & SCX_SCHED_PCPU_BYPASSING);
+			pcpu->flags |= SCX_SCHED_PCPU_BYPASSING;
 		} else {
-			WARN_ON_ONCE(!(rq->scx.flags & SCX_RQ_BYPASSING));
-			rq->scx.flags &= ~SCX_RQ_BYPASSING;
+			WARN_ON_ONCE(!(pcpu->flags & SCX_SCHED_PCPU_BYPASSING));
+			pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
 		}
 
 		/*
 		 * We need to guarantee that no tasks are on the BPF scheduler
 		 * while bypassing. Either we see enabled or the enable path
-		 * sees scx_rq_bypassing() before moving tasks to SCX.
+		 * sees scx_bypassing() before moving tasks to SCX.
 		 */
 		if (!scx_enabled()) {
 			raw_spin_rq_unlock(rq);
@@ -4029,7 +4030,8 @@ static void scx_bypass(bool bypass)
 		raw_spin_rq_unlock(rq);
 	}
 
-	atomic_dec(&scx_breather_depth);
+	if (!scx_parent(sch))
+		atomic_dec(&scx_breather_depth);
 unlock:
 	raw_spin_unlock_irqrestore(&bypass_lock, flags);
 	scx_clear_softlockup();
@@ -4192,7 +4194,7 @@ static void scx_root_disable(struct scx_sched *sch)
 	int cpu;
 
 	/* guarantee forward progress and disable all descendants */
-	scx_bypass(true);
+	scx_bypass(sch, true);
 	scx_propagate_disable_and_flush(sch);
 
 	switch (scx_set_enable_state(SCX_DISABLING)) {
@@ -4324,7 +4326,7 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	WARN_ON_ONCE(scx_set_enable_state(SCX_DISABLED) != SCX_DISABLING);
 done:
-	scx_bypass(false);
+	scx_bypass(sch, false);
 }
 
 static void scx_disable_workfn(struct kthread_work *work)
@@ -4985,7 +4987,7 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * scheduling) may not function correctly before all tasks are switched.
 	 * Init in bypass mode to guarantee forward progress.
 	 */
-	scx_bypass(true);
+	scx_bypass(sch, true);
 
 	for (i = SCX_OPI_NORMAL_BEGIN; i < SCX_OPI_NORMAL_END; i++)
 		if (((void (**)(void))ops)[i])
@@ -5096,7 +5098,7 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	scx_task_iter_stop(&sti);
 	percpu_up_write(&scx_fork_rwsem);
 
-	scx_bypass(false);
+	scx_bypass(sch, false);
 
 	if (!scx_tryset_enable_state(SCX_ENABLED, SCX_ENABLING)) {
 		WARN_ON_ONCE(atomic_read(&sch->exit_kind) == SCX_EXIT_NONE);
@@ -5800,6 +5802,14 @@ void print_scx_info(const char *log_lvl, struct task_struct *p)
 
 static int scx_pm_handler(struct notifier_block *nb, unsigned long event, void *ptr)
 {
+	struct scx_sched *sch;
+
+	guard(rcu)();
+
+	sch = rcu_dereference(scx_root);
+	if (!sch)
+		return NOTIFY_OK;
+
 	/*
 	 * SCX schedulers often have userspace components which are sometimes
 	 * involved in critial scheduling paths. PM operations involve freezing
@@ -5810,12 +5820,12 @@ static int scx_pm_handler(struct notifier_block *nb, unsigned long event, void *
 	case PM_HIBERNATION_PREPARE:
 	case PM_SUSPEND_PREPARE:
 	case PM_RESTORE_PREPARE:
-		scx_bypass(true);
+		scx_bypass(sch, true);
 		break;
 	case PM_POST_HIBERNATION:
 	case PM_POST_SUSPEND:
 	case PM_POST_RESTORE:
-		scx_bypass(false);
+		scx_bypass(sch, false);
 		break;
 	}
 
@@ -6508,7 +6518,7 @@ static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags)
 	 * lead to irq_work_queue() malfunction such as infinite busy wait for
 	 * IRQ status update. Suppress kicking.
 	 */
-	if (scx_rq_bypassing(this_rq))
+	if (scx_bypassing(sch, cpu_of(this_rq)))
 		goto out;
 
 	/*
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index ce9c2f345ec5..39732e58ceb6 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -768,7 +768,8 @@ void __scx_update_idle(struct rq *rq, bool idle, bool do_notify)
 	 * either enqueue() sees the idle bit or update_idle() sees the task
 	 * that enqueue() queued.
 	 */
-	if (SCX_HAS_OP(sch, update_idle) && do_notify && !scx_rq_bypassing(rq))
+	if (SCX_HAS_OP(sch, update_idle) && do_notify &&
+	    !scx_bypassing(sch, cpu_of(rq)))
 		SCX_CALL_OP(sch, SCX_KF_REST, update_idle, rq, cpu_of(rq), idle);
 }
 
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 154993921c38..083ca14f03e2 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -909,7 +909,13 @@ struct scx_event_stats {
 	s64		SCX_EV_INSERT_NOT_OWNED;
 };
 
+enum scx_sched_pcpu_flags {
+	SCX_SCHED_PCPU_BYPASSING	= 1LLU << 0,
+};
+
 struct scx_sched_pcpu {
+	u64			flags;	/* protected by rq lock */
+
 	/*
 	 * The event counters are in a per-CPU variable to minimize the
 	 * accounting overhead. A system-wide view on the event counter is
@@ -934,6 +940,7 @@ struct scx_sched {
 	struct scx_dispatch_q	**global_dsqs;
 	struct scx_sched_pcpu __percpu *pcpu;
 
+	s32			bypass_depth;
 	s32			level;
 	bool			warned_zero_slice:1;
 	bool			warned_deprecated_rq:1;
@@ -1138,9 +1145,10 @@ static inline bool scx_kf_allowed_if_unlocked(void)
 	return !current->scx.kf_mask;
 }
 
-static inline bool scx_rq_bypassing(struct rq *rq)
+static inline bool scx_bypassing(struct scx_sched *sch, s32 cpu)
 {
-	return unlikely(rq->scx.flags & SCX_RQ_BYPASSING);
+	return unlikely(per_cpu_ptr(sch->pcpu, cpu)->flags &
+			SCX_SCHED_PCPU_BYPASSING);
 }
 
 #ifdef CONFIG_EXT_SUB_SCHED
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index be9745d104f7..add7c0c218d4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -755,7 +755,6 @@ enum scx_rq_flags {
 	SCX_RQ_CAN_STOP_TICK	= 1 << 1,
 	SCX_RQ_BAL_PENDING	= 1 << 2, /* balance hasn't run yet */
 	SCX_RQ_BAL_KEEP		= 1 << 3, /* balance decided to keep current */
-	SCX_RQ_BYPASSING	= 1 << 4,
 	SCX_RQ_CLK_VALID	= 1 << 5, /* RQ clock is fresh and valid */
 
 	SCX_RQ_IN_WAKEUP	= 1 << 16,
-- 
2.51.0


