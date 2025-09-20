Return-Path: <bpf+bounces-69059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99973B8BC02
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470221C2227E
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26C2D5C6A;
	Sat, 20 Sep 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhT1jkwW"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6E2D5933;
	Sat, 20 Sep 2025 01:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330000; cv=none; b=lVRi6PZ/U7rf+QtCc9o/Ly+qu2Ffp7wGYBqodS8qgl6Z0c4wk9lOn9Zkssljqg43NiLNfYfDMOm1H7+9id1KOJrnwRQBcfayocwCD5g5wX8H0Egw6TJBjBeoXo4+g4OgJvWDzeUvQfOABbDql8G6k9yVDXgyEkrFu37aa5XWvm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330000; c=relaxed/simple;
	bh=Ak5f83Yv+LCm1SdphR/+puVnIvCKo+dq1ZeRLiVV6I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QwZ1XI+QQg8fyodCjfy9q0NdMquAScs+m8zfTWMlS9GSNb5PWpoLFhalE5ut9P1j77qkV8Pxaiebz3VPZiPXnNU25kW/Eods+50nVPVVvEasSmSGCv5S38A2DRrDC4EJP5bGz+7UTUAJk2egSGHKWIp5V1Jmkn/RHn0nbAALItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhT1jkwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6031C4CEF9;
	Sat, 20 Sep 2025 00:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329999;
	bh=Ak5f83Yv+LCm1SdphR/+puVnIvCKo+dq1ZeRLiVV6I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhT1jkwW/Y7dJR1iHiJ/aLAaYDS+yck/WCGA9SVunuT/Tsye7zEzKNxmgnql/I+Sc
	 E6LtRANnZMzC0MrwmQxPGaHWvnIRwhGajXLonnS86kA+8bnXzXpODt1NRk6L9NpoHo
	 +JbMdZ3IanANWXzMkTmFYU6lJ2ZeRksYbmrGkY5amN09rHBcMOqI8IZonqXRJPcvkI
	 zJr2nvdi0Qy1R7XxNPqjqKp5cw5nExKB4MOBO15S2kSO9asLbgR5Laa1s+IRgxl3Om
	 8wmr48oYkokhwQhlvadJJ16LcPT465PI6VJzObnY5OLx8lEkeOQUoVLvZPXkqBoS7y
	 iAnxKWgSRS/tg==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 25/46] sched_ext: Introduce scx_task_sched[_rcu]()
Date: Fri, 19 Sep 2025 14:58:48 -1000
Message-ID: <20250920005931.2753828-26-tj@kernel.org>
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

In preparation of multiple scheduler support, add p->scx.sched which points
to the scx_sched instance that the task is scheduled by, which is currently
always scx_root. Add scx_task_sched[_rcu]() accessors which return the
assocaited scx_sched of the specified task and replace the raw scx_root
dereferences with it where applicable.

As scx_root is still the only scheduler, this shouldn't introduce
user-visible behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h   |  7 ++++
 kernel/sched/ext.c          | 68 +++++++++++++++++++++++--------------
 kernel/sched/ext_internal.h | 42 +++++++++++++++++++++++
 3 files changed, 92 insertions(+), 25 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 992c8b43db75..73f9df0759e2 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -144,6 +144,13 @@ struct scx_sched;
  * for a task to be scheduled by SCX.
  */
 struct sched_ext_entity {
+#ifdef CONFIG_CGROUPS
+	/*
+	 * Associated scx_sched. Updated either during fork or while holding
+	 * both p->pi_lock and rq lock.
+	 */
+	struct scx_sched __rcu	*sched;
+#endif
 	struct scx_dispatch_q	*dsq;
 	struct scx_dsq_list_node dsq_list;	/* dispatch order */
 	struct rb_node		dsq_priq;	/* p->scx.dsq_vtime order */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a0251442b8ac..e041c2f0cdc3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -19,7 +19,7 @@ static DEFINE_RAW_SPINLOCK(scx_sched_lock);
  * are used as temporary markers to indicate that the dereferences need to be
  * updated to point to the associated scheduler instances rather than scx_root.
  */
-static struct scx_sched __rcu *scx_root;
+struct scx_sched __rcu *scx_root;
 
 /*
  * All scheds, writers must hold both scx_enable_mutex and scx_sched_lock.
@@ -213,6 +213,11 @@ static struct scx_sched *scx_parent(struct scx_sched *sch)
 }
 
 #ifdef CONFIG_EXT_SUB_SCHED
+static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
+{
+	rcu_assign_pointer(p->scx.sched, sch);
+}
+
 static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos,
 						 struct scx_sched *root)
 {
@@ -240,6 +245,10 @@ static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos,
 	return NULL;
 }
 #else	/* CONFIG_EXT_SUB_SCHED */
+static void scx_set_task_sched(struct task_struct *p, struct scx_sched *sch)
+{
+}
+
 static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos,
 						 struct scx_sched *root)
 {
@@ -1355,7 +1364,7 @@ static bool scx_rq_online(struct rq *rq)
 static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 			    int sticky_cpu)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	struct task_struct **ddsp_taskp;
 	unsigned long qseq;
 
@@ -1473,7 +1482,7 @@ static void clr_task_runnable(struct task_struct *p, bool reset_runnable_at)
 
 static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	int sticky_cpu = p->scx.sticky_cpu;
 
 	if (enq_flags & ENQUEUE_WAKEUP)
@@ -1520,7 +1529,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 
 static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	unsigned long opss;
 
 	/* dequeue is always temporary, don't reset runnable_at */
@@ -1569,7 +1578,7 @@ static void ops_dequeue(struct rq *rq, struct task_struct *p, u64 deq_flags)
 
 static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
 		WARN_ON_ONCE(task_runnable(p));
@@ -1613,8 +1622,8 @@ static bool dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 
 static void yield_task_scx(struct rq *rq)
 {
-	struct scx_sched *sch = scx_root;
 	struct task_struct *p = rq->curr;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	if (SCX_HAS_OP(sch, yield))
 		SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq, p, NULL);
@@ -1624,10 +1633,10 @@ static void yield_task_scx(struct rq *rq)
 
 static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 {
-	struct scx_sched *sch = scx_root;
 	struct task_struct *from = rq->curr;
+	struct scx_sched *sch = scx_task_sched(from);
 
-	if (SCX_HAS_OP(sch, yield))
+	if (SCX_HAS_OP(sch, yield) && sch == scx_task_sched(to))
 		return SCX_CALL_OP_2TASKS_RET(sch, SCX_KF_REST, yield, rq,
 					      from, to);
 	else
@@ -2329,7 +2338,7 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 	 */
 	while ((p = list_first_entry_or_null(&rq->scx.ddsp_deferred_locals,
 				struct task_struct, scx.dsq_list.node))) {
-		struct scx_sched *sch = scx_root;
+		struct scx_sched *sch = scx_task_sched(p);
 		struct scx_dispatch_q *dsq;
 
 		list_del_init(&p->scx.dsq_list.node);
@@ -2343,7 +2352,7 @@ static void process_ddsp_deferred_locals(struct rq *rq)
 
 static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
 		/*
@@ -2446,7 +2455,7 @@ static void switch_class(struct rq *rq, struct task_struct *next)
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			      struct task_struct *next)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	update_curr_scx(rq);
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
@@ -2540,7 +2549,7 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 	if (keep_prev) {
 		p = prev;
 		if (!p->scx.slice)
-			refill_task_slice_dfl(rcu_dereference_sched(scx_root), p);
+			refill_task_slice_dfl(scx_task_sched(p), p);
 	} else {
 		p = first_local_task(rq);
 		if (!p) {
@@ -2551,7 +2560,7 @@ static struct task_struct *pick_task_scx(struct rq *rq)
 		}
 
 		if (unlikely(!p->scx.slice)) {
-			struct scx_sched *sch = rcu_dereference_sched(scx_root);
+			struct scx_sched *sch = scx_task_sched(p);
 
 			if (!scx_rq_bypassing(rq) && !sch->warned_zero_slice) {
 				printk_deferred(KERN_WARNING "sched_ext: %s[%d] has zero slice in %s()\n",
@@ -2607,7 +2616,7 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 
 static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flags)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	bool rq_bypass;
 
 	/*
@@ -2668,7 +2677,7 @@ static void task_woken_scx(struct rq *rq, struct task_struct *p)
 static void set_cpus_allowed_scx(struct task_struct *p,
 				 struct affinity_context *ac)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	set_cpus_allowed_common(p, ac);
 
@@ -2809,7 +2818,7 @@ void scx_tick(struct rq *rq)
 
 static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(curr);
 
 	update_curr_scx(rq);
 
@@ -2985,11 +2994,12 @@ static void scx_disable_task(struct task_struct *p)
 
 static void scx_exit_task(struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 	struct scx_exit_task_args args = {
 		.cancelled = false,
 	};
 
+	lockdep_assert_held(&p->pi_lock);
 	lockdep_assert_rq_held(task_rq(p));
 
 	switch (scx_get_task_state(p)) {
@@ -3011,6 +3021,7 @@ static void scx_exit_task(struct task_struct *p)
 	if (SCX_HAS_OP(sch, exit_task))
 		SCX_CALL_OP_TASK(sch, SCX_KF_REST, exit_task, task_rq(p),
 				 p, &args);
+	scx_set_task_sched(p, NULL);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
 
@@ -3040,12 +3051,18 @@ void scx_pre_fork(struct task_struct *p)
 
 int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 {
+	int ret;
+
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
-	if (scx_init_task_enabled)
-		return scx_init_task(p, task_group(p), true);
-	else
-		return 0;
+	if (scx_init_task_enabled) {
+		ret = scx_init_task(p, task_group(p), true);
+		if (!ret)
+			scx_set_task_sched(p, scx_root);
+		return ret;
+	}
+
+	return 0;
 }
 
 void scx_post_fork(struct task_struct *p)
@@ -3122,7 +3139,7 @@ void sched_ext_free(struct task_struct *p)
 static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 			      const struct load_weight *lw)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	lockdep_assert_rq_held(task_rq(p));
 
@@ -3138,7 +3155,7 @@ static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
 
 static void switching_to_scx(struct rq *rq, struct task_struct *p)
 {
-	struct scx_sched *sch = scx_root;
+	struct scx_sched *sch = scx_task_sched(p);
 
 	scx_enable_task(p);
 
@@ -3768,11 +3785,11 @@ bool scx_allow_ttwu_queue(const struct task_struct *p)
 	if (!scx_enabled())
 		return true;
 
-	sch = rcu_dereference_sched(scx_root);
+	sch = scx_task_sched(p);
 	if (unlikely(!sch))
 		return true;
 
-	if (scx_root->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP)
+	if (sch->ops.flags & SCX_OPS_ALLOW_QUEUED_WAKEUP)
 		return true;
 
 	if (unlikely(p->sched_class != &ext_sched_class))
@@ -5006,6 +5023,7 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			goto err_disable_unlock_all;
 		}
 
+		scx_set_task_sched(p, sch);
 		scx_set_task_state(p, SCX_TASK_READY);
 
 		put_task_struct(p);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 2e3aa3888ce0..aaf606e5d0de 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -1109,6 +1109,7 @@ enum scx_ops_state {
 #define SCX_OPSS_STATE_MASK	((1LU << SCX_OPSS_QSEQ_SHIFT) - 1)
 #define SCX_OPSS_QSEQ_MASK	(~SCX_OPSS_STATE_MASK)
 
+extern struct scx_sched __rcu *scx_root;
 DECLARE_PER_CPU(struct rq *, scx_locked_rq_state);
 
 /*
@@ -1129,3 +1130,44 @@ static inline bool scx_rq_bypassing(struct rq *rq)
 {
 	return unlikely(rq->scx.flags & SCX_RQ_BYPASSING);
 }
+
+#ifdef CONFIG_EXT_SUB_SCHED
+/**
+ * scx_task_sched - Find scx_sched scheduling a task
+ * @p: task of interest
+ *
+ * Return @p's scheduler instance. Must be called with @p's rq locked.
+ */
+static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
+{
+	return rcu_dereference_protected(p->scx.sched,
+					 lockdep_is_held(&p->pi_lock) ||
+					 lockdep_is_held(__rq_lockp(task_rq(p))));
+}
+
+/**
+ * scx_task_sched_rcu - Find scx_sched scheduling a task
+ * @p: task of interest
+ *
+ * Return @p's scheduler instance. The returned scx_sched is RCU protected.
+ */
+static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
+{
+	return rcu_dereference_check(p->scx.sched,
+				     rcu_read_lock_bh_held() ||
+				     rcu_read_lock_sched_held());
+}
+#else	/* CONFIG_EXT_SUB_SCHED */
+static inline struct scx_sched *scx_task_sched(const struct task_struct *p)
+{
+	return rcu_dereference_protected(scx_root,
+					 lockdep_is_held(__rq_lockp(task_rq(p))));
+}
+
+static inline struct scx_sched *scx_task_sched_rcu(const struct task_struct *p)
+{
+	return rcu_dereference_check(scx_root,
+				     rcu_read_lock_bh_held() ||
+				     rcu_read_lock_sched_held());
+}
+#endif	/* CONFIG_EXT_SUB_SCHED */
-- 
2.51.0


