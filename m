Return-Path: <bpf+bounces-69057-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE5B8BC05
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB37FB618E5
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905B02D375A;
	Sat, 20 Sep 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yd/UE5q0"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A772D23B8;
	Sat, 20 Sep 2025 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329998; cv=none; b=YMV5xPRSEXquf9fV8rAabuUjigFifFOr8LaESfxGAl45QM9cllGQGu6f1yH73dp3l+FeusJzewCurDLx2Yliuy1uV8T9Cd087d94aYQpiAdXWIfJprbnIC+l91hzMUYNQgpuImDn+oL2eXLildVjTsgybol6snefThNcigNFuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329998; c=relaxed/simple;
	bh=ZB9OTv7XleEDOThzXn1COu+dVrqDop2N3x4wG0oQDvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJE256akkTl9nZVeEElcglsj94ohIeCRpFrzjA1EP/V87swAy+lkBWVIONJgHqtH9Qoalsomvou1/ucGXOnlKrwdWI2fyKK319A2SjDnZZThpfB2/LCrNXJzBJ4momq9oPmU639p7jOQy9hw0dutB+5YHIlhsSyJpRlrKsBAB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yd/UE5q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0466C4CEF0;
	Sat, 20 Sep 2025 00:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329997;
	bh=ZB9OTv7XleEDOThzXn1COu+dVrqDop2N3x4wG0oQDvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yd/UE5q0asVrR8DvJ8I0tJaiZPAnRW0UrcTVKfR4BlruyTqt2HJ9OSJqVucdWM7hx
	 D3UILXjUg7bc5JYyY35QvGLNNOI4f6GbSdlUCsrKTmqQAMCSnc5AWFIjb+MgpruaoS
	 93HO+CXrFXar6KiXRrL9PM6WMlzmsSfOd8zMhG4Aum7y1SSubzMe3hTrbExaMOkSah
	 f7pPgxHw8GmQVFbf/y9MimmbZc6jOVjA6xSddo8SvRbkaXxGaTJfgCsW80g1jQ6HLq
	 B2G9cbrFSaoSUkbfZ5pF+rd+qYifgf1faoNRQG5Or5DIlT1djeTvExnZnvPNcMhlW+
	 ti7URmKqiVrsQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 23/46] sched_ext: Introduce cgroup sub-sched support
Date: Fri, 19 Sep 2025 14:58:46 -1000
Message-ID: <20250920005931.2753828-24-tj@kernel.org>
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

A system often runs multiple workloads especially in multi-tenant server
environments where a system is split into partitions servicing separate
more-or-less independent workloads each requiring an application-specific
scheduler. To support such and other use cases, sched_ext is in the process
of growing multiple scheduler support.

When partitioning a system in terms of CPUs for such use cases, an
oft-taken approach is hard partitioning the system using cpuset. While it
would be possible to tie sched_ext multiple scheduler support to cpuset
partitions, such an approach would have fundamental limitations stemming
from the lack of dynamism and flexibility.

Users often don't care which specific CPUs are assigned to which workload
and want to take advantage of optimizations which are enabled by running
workloads on a larger machine - e.g. opportunistic over-commit, improving
latency critical workload characteristics while maintaining bandwidth
fairness, employing control mechanisms based on different criteria than
on-CPU time for e.g. flexible memory bandwidth isolation, packing similar
parts from different workloads on same L3s to improve cache efficiency,
and so on.

As this sort of dynamic behaviors are impossible or difficult to implement
with hard partitioning, sched_ext is implementing cgroup sub-sched support
where schedulers can be attached to the cgroup hierarchy and a parent
scheduler is responsible for controlling the CPUs that each child can use
at any given moment. This makes CPU distribution dynamically controlled by
BPF allowing high flexibility.

This patch adds the skeletal sched_ext cgroup sub-sched support:

- sched_ext_ops.sub_cgroup_id and .sub_attach/detach() are added. Non-zero
  sub_cgroup_id indicates that the scheduler is to be attached to the
  identified cgroup. A sub-sched is attached to the cgroup iff the nearest
  ancestor scheduler implements .sub_attach() and grants the attachment. Max
  nesting depth is limited by SCX_SUB_MAX_DEPTH.

- When a scheduler exits, all its descendant schedulers are exited
  together. Also, cgroup.scx_sched added which points to the effective
  scheduler instance for the cgroup. This is updated on scheduler
  init/exit and inherited on cgroup online. When a cgroup is offlined, the
  attached scheduler is automatically exited.

- Sub-sched support is gated on CONFIG_EXT_SUB_SCHED which is
  automatically enabled if both SCX and cgroups are enabled. Sub-sched
  support is not tied to the CPU controller but rather the cgroup
  hierarchy itself. This is intentional as the support for cpu.weight and
  cpu.max based resource control is orthogonal to sub-sched support. Note
  that CONFIG_CGROUPS around cgroup subtree iteration support for
  scx_task_iter is replaced with CONFIG_EXT_SUB_SCHED for consistency.

- This allows loading sub-scheds and most framework operations such as
  propagating disable down the hierarchy work. However, sub-scheds are not
  operational yet and all tasks stay with the root sched. This will serve
  as the basis for building up full sub-sched support.

- DSQs point to the scx_sched they belong to.

- scx_qmap is updated to allow attachment of sub-scheds and also serving
  as sub-scheds.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup-defs.h    |   4 +
 include/linux/sched/ext.h      |   3 +
 init/Kconfig                   |   4 +
 kernel/sched/ext.c             | 503 +++++++++++++++++++++++++++++++--
 kernel/sched/ext_internal.h    |  65 ++++-
 tools/sched_ext/scx_qmap.bpf.c |   9 +-
 tools/sched_ext/scx_qmap.c     |  13 +-
 7 files changed, 567 insertions(+), 34 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b93a64115fe..56ea297981f5 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -17,6 +17,7 @@
 #include <linux/refcount.h>
 #include <linux/percpu-refcount.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/sched.h>
 #include <linux/u64_stats_sync.h>
 #include <linux/workqueue.h>
 #include <linux/bpf-cgroup-defs.h>
@@ -590,6 +591,9 @@ struct cgroup {
 #ifdef CONFIG_BPF_SYSCALL
 	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
 #endif
+#ifdef CONFIG_EXT_SUB_SCHED
+	struct scx_sched __rcu *scx_sched;
+#endif
 
 	/* All ancestors including self */
 	struct cgroup *ancestors[];
diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 7290c4354ad6..992c8b43db75 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -65,6 +65,7 @@ struct scx_dispatch_q {
 	u64			id;
 	struct rhash_head	hash_node;
 	struct llist_node	free_node;
+	struct scx_sched	*sched;
 	struct rcu_head		rcu;
 };
 
@@ -136,6 +137,8 @@ struct scx_dsq_list_node {
 	u32			priv;		/* can be used by iter cursor */
 };
 
+struct scx_sched;
+
 /*
  * The following is embedded in task_struct and contains all fields necessary
  * for a task to be scheduled by SCX.
diff --git a/init/Kconfig b/init/Kconfig
index 836320251219..4ca8c048dfee 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1137,6 +1137,10 @@ config EXT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config EXT_SUB_SCHED
+        def_bool y
+        depends on SCHED_CLASS_EXT
+
 config SCHED_MM_CID
 	def_bool y
 	depends on SMP && RSEQ
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b608c2c04730..5eb1d6919595 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9,6 +9,8 @@
 #include <linux/btf_ids.h>
 #include "ext_idle.h"
 
+static DEFINE_RAW_SPINLOCK(scx_sched_lock);
+
 /*
  * NOTE: sched_ext is in the process of growing multiple scheduler support and
  * scx_root usage is in a transitional state. Naked dereferences are safe if the
@@ -19,6 +21,12 @@
  */
 static struct scx_sched __rcu *scx_root;
 
+/*
+ * All scheds, writers must hold both scx_enable_mutex and scx_sched_lock.
+ * Readers can hold either or rcu_read_lock().
+ */
+static LIST_HEAD(scx_sched_all);
+
 /*
  * - We want to visit and perform sleepable operations on every task.
  *
@@ -144,6 +152,7 @@ static struct kset *scx_kset;
 #include <trace/events/sched_ext.h>
 
 static void process_ddsp_deferred_locals(struct rq *rq);
+static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
 		      s64 exit_code, const char *fmt, va_list args);
@@ -189,6 +198,82 @@ static bool u32_before(u32 a, u32 b)
 	return (s32)(a - b) < 0;
 }
 
+/**
+ * scx_parent - Find the parent sched
+ * @sch: sched to find the parent of
+ *
+ * Returns the parent scheduler or %NULL if @sch is root.
+ */
+static struct scx_sched *scx_parent(struct scx_sched *sch)
+{
+	if (sch->level)
+		return sch->ancestors[sch->level - 1];
+	else
+		return NULL;
+}
+
+#ifdef CONFIG_EXT_SUB_SCHED
+static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos,
+						 struct scx_sched *root)
+{
+	struct scx_sched *next;
+
+	lockdep_assert(lockdep_is_held(&scx_enable_mutex) ||
+		       lockdep_is_held(&scx_sched_lock));
+
+	/* if first iteration, visit @root */
+	if (!pos)
+		return root;
+
+	/* visit the first child if exists */
+	next = list_first_entry_or_null(&pos->children, struct scx_sched, sibling);
+	if (next)
+		return next;
+
+	/* no child, visit my or the closest ancestor's next sibling */
+	while (pos != root) {
+		if (!list_is_last(&pos->sibling, &scx_parent(pos)->children))
+			return list_next_entry(pos, sibling);
+		pos = scx_parent(pos);
+	}
+
+	return NULL;
+}
+#else	/* CONFIG_EXT_SUB_SCHED */
+static struct scx_sched *scx_next_descendant_pre(struct scx_sched *pos,
+						 struct scx_sched *root)
+{
+	return pos ? NULL : root;
+}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
+/**
+ * scx_is_descendant - Test whether sched is a descendant
+ * @sch: sched to test
+ * @ancestor: ancestor sched to test against
+ *
+ * Test whether @sch is a descendant of @ancestor.
+ */
+static bool scx_is_descendant(struct scx_sched *sch, struct scx_sched *ancestor)
+{
+	if (sch->level < ancestor->level)
+		return false;
+	return sch->ancestors[ancestor->level] == ancestor;
+}
+
+/**
+ * scx_for_each_descendant_pre - pre-order walk of a sched's descendants
+ * @pos: iteration cursor
+ * @root: sched to walk the descendants of
+ *
+ * Walk @root's descendants. @root is included in the iteration and the first
+ * node to be visited. Must be called with either scx_enable_mutex or
+ * scx_sched_lock held.
+ */
+#define scx_for_each_descendant_pre(pos, root)					\
+	for ((pos) = scx_next_descendant_pre(NULL, (root)); (pos);		\
+	     (pos) = scx_next_descendant_pre((pos), (root)))
+
 static struct scx_dispatch_q *find_global_dsq(struct scx_sched *sch,
 					      struct task_struct *p)
 {
@@ -451,7 +536,7 @@ struct scx_task_iter {
 	struct rq_flags			rf;
 	u32				cnt;
 	bool				list_locked;
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_EXT_SUB_SCHED
 	struct cgroup			*cgrp;
 	struct cgroup_subsys_state	*css_pos;
 	struct css_task_iter		css_iter;
@@ -490,7 +575,7 @@ static void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp)
 	spin_lock_irq(&scx_tasks_lock);
 
 	iter->head = &scx_live_tasks;
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_EXT_SUB_SCHED
 	if (cgrp) {
 		iter->cgrp = cgrp;
 		iter->css_pos = css_next_descendant_pre(NULL, &iter->cgrp->self);
@@ -584,7 +669,7 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 	}
 retry:
 
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_EXT_SUB_SCHED
 	/*
 	 * For cgroup iterations, use css_task_iter for live tasks. iter->head
 	 * is already set to scx_dying_tasks.
@@ -611,7 +696,7 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 			break;
 		if (pos->flags & SCX_TASK_CURSOR)
 			continue;
-#ifdef CONFIG_CGROUPS
+#ifdef CONFIG_EXT_SUB_SCHED
 		/*
 		 * For cgroup iterations, this loop is only used for iterating
 		 * dying tasks. Filter out tasks which aren't in the target
@@ -2825,7 +2910,10 @@ static int scx_init_task(struct task_struct *p, struct task_group *tg, bool fork
 	scx_set_task_state(p, SCX_TASK_INIT);
 
 	if (p->scx.disallow) {
-		if (unlikely(fork)) {
+		if (unlikely(scx_parent(sch))) {
+			scx_error(sch, "non-root ops.init_task() set task->scx.disallow for %s[%d]",
+				  p->comm, p->pid);
+		} else if (unlikely(fork)) {
 			scx_error(sch, "ops.init_task() set task->scx.disallow for %s[%d] during fork",
 				  p->comm, p->pid);
 		} else {
@@ -3284,25 +3372,39 @@ void scx_group_set_bandwidth(struct task_group *tg,
 
 	percpu_up_read(&scx_cgroup_ops_rwsem);
 }
+#endif	/* CONFIG_EXT_GROUP_SCHED */
 
+#if defined(CONFIG_EXT_GROUP_SCHED) || defined(CONFIG_EXT_SUB_SCHED)
 static void scx_cgroup_lock(void)
 {
+#ifdef CONFIG_EXT_GROUP_SCHED
 	percpu_down_write(&scx_cgroup_ops_rwsem);
+#endif
 	cgroup_lock();
 }
 
 static void scx_cgroup_unlock(void)
 {
 	cgroup_unlock();
+#ifdef CONFIG_EXT_GROUP_SCHED
 	percpu_up_write(&scx_cgroup_ops_rwsem);
+#endif
 }
 
-#else	/* CONFIG_EXT_GROUP_SCHED */
+/* for each descendant of @cgrp including self, set ->scx_sched to @sch */
+static void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch)
+{
+	struct cgroup *pos;
+	struct cgroup_subsys_state *css;
 
+	cgroup_for_each_live_descendant_pre(pos, css, cgrp)
+		rcu_assign_pointer(pos->scx_sched, sch);
+}
+#else	/* CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED */
 static void scx_cgroup_lock(void) {}
 static void scx_cgroup_unlock(void) {}
-
-#endif	/* CONFIG_EXT_GROUP_SCHED */
+static void set_cgroup_sched(struct cgroup *cgrp, struct scx_sched *sch) {}
+#endif	/* CONFIG_EXT_GROUP_SCHED || CONFIG_EXT_SUB_SCHED */
 
 /*
  * Omitted operations:
@@ -3352,13 +3454,15 @@ DEFINE_SCHED_CLASS(ext) = {
 #endif
 };
 
-static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id)
+static void init_dsq(struct scx_dispatch_q *dsq, u64 dsq_id,
+		     struct scx_sched *sch)
 {
 	memset(dsq, 0, sizeof(*dsq));
 
 	raw_spin_lock_init(&dsq->lock);
 	INIT_LIST_HEAD(&dsq->list);
 	dsq->id = dsq_id;
+	dsq->sched = sch;
 }
 
 static void free_dsq_irq_workfn(struct irq_work *irq_work)
@@ -3554,6 +3658,11 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	struct scx_dispatch_q *dsq;
 	int node;
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	kfree(sch->cgrp_path);
+	if (sch->cgrp)
+		cgroup_put(sch->cgrp);
+#endif	/* CONFIG_EXT_SUB_SCHED */
 	kthread_stop(sch->helper->task);
 	free_percpu(sch->pcpu);
 
@@ -3922,6 +4031,8 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 		return "unregistered from the main kernel";
 	case SCX_EXIT_SYSRQ:
 		return "disabled by sysrq-S";
+	case SCX_EXIT_PARENT:
+		return "parent exiting";
 	case SCX_EXIT_ERROR:
 		return "runtime error";
 	case SCX_EXIT_ERROR_BPF:
@@ -3933,6 +4044,85 @@ static const char *scx_exit_reason(enum scx_exit_kind kind)
 	}
 }
 
+#ifdef CONFIG_EXT_SUB_SCHED
+static DECLARE_WAIT_QUEUE_HEAD(scx_unlink_waitq);
+
+/* propagate disable to all proper descendants and wait for them to unlink */
+static void scx_propagate_disable_and_flush(struct scx_sched *sch)
+{
+	struct scx_sched *child;
+
+	/*
+	 * Trigger them in parallel. Each has a dedicated helper kthread and can
+	 * run in parallel. While most of disabling is serialized, running them
+	 * in separate threads allows excluding ops.exit(), which can take
+	 * arbitrarily long, from the critical path and thus avoids staying in
+	 * the bypass mode for prolonged time.
+	 */
+	raw_spin_lock_irq(&scx_sched_lock);
+	list_for_each_entry(child, &sch->children, sibling)
+		scx_disable(child, SCX_EXIT_PARENT);
+	raw_spin_unlock_irq(&scx_sched_lock);
+
+	/*
+	 * Child scheds that finished the critical part of disabling will take
+	 * themselves off @sch->children. Wait for it to drian. As propagation
+	 * is recursive, empty @sch->children means that all proper descendant
+	 * scheds reached unlinking stage.
+	 */
+	wait_event(scx_unlink_waitq, list_empty(&sch->children));
+}
+
+static void scx_sub_disable(struct scx_sched *sch)
+{
+	struct scx_sched *parent = scx_parent(sch);
+
+	scx_propagate_disable_and_flush(sch);
+
+	mutex_lock(&scx_enable_mutex);
+	percpu_down_write(&scx_fork_rwsem);
+	scx_cgroup_lock();
+
+	set_cgroup_sched(sch->cgrp, parent);
+
+	/* TODO - perform actual disabling here */
+
+	scx_cgroup_unlock();
+	percpu_up_write(&scx_fork_rwsem);
+
+	raw_spin_lock_irq(&scx_sched_lock);
+	list_del_init(&sch->sibling);
+	list_del_rcu(&sch->all);
+	raw_spin_unlock_irq(&scx_sched_lock);
+
+	mutex_unlock(&scx_enable_mutex);
+
+	/*
+	 * @sch is now unlinked from the parent's children list. Notify and call
+	 * ops.sub_detach/exit(). Note that ops.sub_detach/exit() must be called
+	 * after unlinking and releasing all locks. See
+	 * scx_propagate_disable_and_flush().
+	 */
+	wake_up_all(&scx_unlink_waitq);
+
+	if (sch->ops.sub_detach && sch->sub_attached) {
+		struct scx_sub_detach_args sub_detach_args = {
+			.ops = &sch->ops,
+			.cgroup_path = sch->cgrp_path,
+		};
+		SCX_CALL_OP(parent, SCX_KF_UNLOCKED, sub_detach, NULL,
+			    &sub_detach_args);
+	}
+
+	if (sch->ops.exit)
+		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, exit, NULL, sch->exit_info);
+	kobject_del(&sch->kobj);
+}
+#else	/* CONFIG_EXT_SUB_SCHED */
+static void scx_propgate_disable(struct scx_sched *sch) { }
+static void scx_sub_disable(struct scx_sched *sch) { }
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 static void scx_root_disable(struct scx_sched *sch)
 {
 	struct scx_exit_info *ei = sch->exit_info;
@@ -3940,8 +4130,9 @@ static void scx_root_disable(struct scx_sched *sch)
 	struct task_struct *p;
 	int cpu;
 
-	/* guarantee forward progress by bypassing scx_ops */
+	/* guarantee forward progress and disable all descendants */
 	scx_bypass(true);
+	scx_propagate_disable_and_flush(sch);
 
 	switch (scx_set_enable_state(SCX_DISABLING)) {
 	case SCX_DISABLING:
@@ -4004,6 +4195,11 @@ static void scx_root_disable(struct scx_sched *sch)
 		scx_exit_task(p);
 	}
 	scx_task_iter_stop(&sti);
+
+	scx_cgroup_lock();
+	set_cgroup_sched(sch->cgrp, NULL);
+	scx_cgroup_unlock();
+
 	percpu_up_write(&scx_fork_rwsem);
 
 	/*
@@ -4040,6 +4236,10 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	cancel_delayed_work_sync(&scx_watchdog_work);
 
+	raw_spin_lock_irq(&scx_sched_lock);
+	list_del_rcu(&sch->all);
+	raw_spin_unlock_irq(&scx_sched_lock);
+
 	/*
 	 * scx_root clearing must be inside cpus_read_lock(). See
 	 * handle_hotplug().
@@ -4083,7 +4283,10 @@ static void scx_disable_workfn(struct kthread_work *work)
 	ei->kind = kind;
 	ei->reason = scx_exit_reason(ei->kind);
 
-	scx_root_disable(sch);
+	if (scx_parent(sch))
+		scx_sub_disable(sch);
+	else
+		scx_root_disable(sch);
 }
 
 static bool scx_claim_exit(struct scx_sched *sch, enum scx_exit_kind kind)
@@ -4438,12 +4641,15 @@ static void scx_vexit(struct scx_sched *sch,
 	irq_work_queue(&sch->error_irq_work);
 }
 
-static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
+static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
+						 struct cgroup *cgrp,
+						 struct scx_sched *parent)
 {
 	struct scx_sched *sch;
-	int node, ret;
+	s32 level = parent ? parent->level + 1 : 0;
+	s32 node, ret;
 
-	sch = kzalloc(sizeof(*sch), GFP_KERNEL);
+	sch = kzalloc(struct_size(sch, ancestors, level), GFP_KERNEL);
 	if (!sch)
 		return ERR_PTR(-ENOMEM);
 
@@ -4473,7 +4679,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 			goto err_free_gdsqs;
 		}
 
-		init_dsq(dsq, SCX_DSQ_GLOBAL);
+		init_dsq(dsq, SCX_DSQ_GLOBAL, sch);
 		sch->global_dsqs[node] = dsq;
 	}
 
@@ -4486,6 +4692,12 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 		goto err_free_pcpu;
 	sched_set_fifo(sch->helper->task);
 
+	if (parent)
+		memcpy(sch->ancestors, parent->ancestors,
+		       level * sizeof(parent->ancestors[0]));
+	sch->ancestors[level] = sch;
+	sch->level = level;
+
 	atomic_set(&sch->exit_kind, SCX_EXIT_NONE);
 	init_irq_work(&sch->error_irq_work, scx_error_irq_workfn);
 	kthread_init_work(&sch->disable_work, scx_disable_workfn);
@@ -4493,10 +4705,46 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops)
 	ops->priv = sch;
 
 	sch->kobj.kset = scx_kset;
+
+#ifdef CONFIG_EXT_SUB_SCHED
+	char *buf = kzalloc(PATH_MAX, GFP_KERNEL);
+	if (!buf)
+		goto err_stop_helper;
+	cgroup_path(cgrp, buf, PATH_MAX);
+	sch->cgrp_path = kstrdup(buf, GFP_KERNEL);
+	kfree(buf);
+	if (!sch->cgrp_path)
+		goto err_stop_helper;
+
+	sch->cgrp = cgrp;
+	INIT_LIST_HEAD(&sch->children);
+	INIT_LIST_HEAD(&sch->sibling);
+
+	if (parent)
+		ret = kobject_init_and_add(&sch->kobj, &scx_ktype,
+					   &parent->sub_kset->kobj,
+					   "sub-%llu", cgroup_id(cgrp));
+	else
+		ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
+
+	if (ret < 0) {
+		kfree(sch->cgrp_path);
+		goto err_stop_helper;
+	}
+
+	if (ops->sub_attach) {
+		sch->sub_kset = kset_create_and_add("sub", NULL, &sch->kobj);
+		if (!sch->sub_kset) {
+			kobject_put(&sch->kobj);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+#else	/* CONFIG_EXT_SUB_SCHED */
 	ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
 	if (ret < 0)
 		goto err_stop_helper;
-
+#endif	/* CONFIG_EXT_SUB_SCHED */
 	return sch;
 
 err_stop_helper:
@@ -4585,7 +4833,7 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		goto err_unlock;
 	}
 
-	sch = scx_alloc_and_add_sched(ops);
+	sch = scx_alloc_and_add_sched(ops, &cgrp_dfl_root.cgrp, NULL);
 	if (IS_ERR(sch)) {
 		ret = PTR_ERR(sch);
 		goto err_unlock;
@@ -4600,8 +4848,12 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	atomic_long_set(&scx_nr_rejected, 0);
 
-	for_each_possible_cpu(cpu)
-		cpu_rq(cpu)->scx.cpuperf_target = SCX_CPUPERF_ONE;
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+
+		rq->scx.local_dsq.sched = sch;
+		rq->scx.cpuperf_target = SCX_CPUPERF_ONE;
+	}
 
 	/*
 	 * Keep CPUs stable during enable so that the BPF scheduler can track
@@ -4615,6 +4867,10 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	rcu_assign_pointer(scx_root, sch);
 
+	raw_spin_lock_irq(&scx_sched_lock);
+	list_add_tail_rcu(&sch->all, &scx_sched_all);
+	raw_spin_unlock_irq(&scx_sched_lock);
+
 	scx_idle_enable(ops);
 
 	if (sch->ops.init) {
@@ -4699,6 +4955,7 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * never sees uninitialized tasks.
 	 */
 	scx_cgroup_lock();
+	set_cgroup_sched(sch->cgrp, sch);
 	ret = scx_cgroup_init(sch);
 	if (ret)
 		goto err_disable_unlock_all;
@@ -4819,6 +5076,181 @@ static int scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	return 0;
 }
 
+#ifdef CONFIG_EXT_SUB_SCHED
+/* verify that a scheduler can be attached to @cgrp and return the parent */
+static struct scx_sched *find_parent_sched(struct cgroup *cgrp)
+{
+	struct scx_sched *parent = cgrp->scx_sched;
+	struct scx_sched *pos;
+
+	lockdep_assert_held(&scx_sched_lock);
+
+	/* can't attach twice to the same cgroup */
+	if (parent->cgrp == cgrp)
+		return ERR_PTR(-EBUSY);
+
+	/* does $parent allow sub-scheds? */
+	if (!parent->ops.sub_attach)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	/* can't insert between $parent and its exiting children */
+	list_for_each_entry(pos, &parent->children, sibling)
+		if (cgroup_is_descendant(pos->cgrp, cgrp))
+			return ERR_PTR(-EBUSY);
+
+	return parent;
+}
+
+static int scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
+{
+	struct cgroup *cgrp;
+	struct scx_sched *parent, *sch;
+	int ret;
+
+	mutex_lock(&scx_enable_mutex);
+
+	if (!scx_enabled()) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
+	cgrp = cgroup_get_from_id(ops->sub_cgroup_id);
+	if (IS_ERR(cgrp)) {
+		ret = PTR_ERR(cgrp);
+		goto out_unlock;
+	}
+
+	raw_spin_lock_irq(&scx_sched_lock);
+	parent = find_parent_sched(cgrp);
+	if (IS_ERR(parent)) {
+		raw_spin_unlock_irq(&scx_sched_lock);
+		ret = PTR_ERR(parent);
+		goto out_put_cgrp;
+	}
+	kobject_get(&parent->kobj);
+	raw_spin_unlock_irq(&scx_sched_lock);
+
+	sch = scx_alloc_and_add_sched(ops, cgrp, parent);
+	kobject_put(&parent->kobj);
+	if (IS_ERR(sch)) {
+		ret = PTR_ERR(sch);
+		goto out_put_cgrp;
+	}
+
+	raw_spin_lock_irq(&scx_sched_lock);
+	list_add_tail(&sch->sibling, &parent->children);
+	list_add_tail_rcu(&sch->all, &scx_sched_all);
+	raw_spin_unlock_irq(&scx_sched_lock);
+
+	if (sch->level >= SCX_SUB_MAX_DEPTH) {
+		scx_error(sch, "max nesting depth %d violated",
+			  SCX_SUB_MAX_DEPTH);
+		goto err_disable;
+	}
+
+	if (sch->ops.init) {
+		ret = SCX_CALL_OP_RET(sch, SCX_KF_UNLOCKED, init, NULL);
+		if (ret) {
+			ret = ops_sanitize_err(sch, "init", ret);
+			scx_error(sch, "ops.init() failed (%d)", ret);
+			goto err_disable;
+		}
+		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
+	}
+
+	if (validate_ops(sch, ops))
+		goto err_disable;
+
+	struct scx_sub_attach_args sub_attach_args = {
+		.ops = &sch->ops,
+		.cgroup_path = sch->cgrp_path,
+	};
+
+	ret = SCX_CALL_OP_RET(parent, SCX_KF_UNLOCKED, sub_attach, NULL,
+			      &sub_attach_args);
+	if (ret) {
+		ret = ops_sanitize_err(sch, "sub_attach", ret);
+		scx_error(sch, "parent rejected (%d)", ret);
+		goto err_disable;
+	}
+	sch->sub_attached = true;
+
+	percpu_down_write(&scx_fork_rwsem);
+	scx_cgroup_lock();
+
+	/*
+	 * Set cgroup->scx_sched's and check CSS_ONLINE. Either we see
+	 * !CSS_ONLINE or scx_cgroup_lifetime_notify() sees and shoots us down.
+	 */
+	set_cgroup_sched(sch->cgrp, sch);
+	if (!(cgrp->self.flags & CSS_ONLINE)) {
+		scx_error(sch, "cgroup is not online");
+		goto err_unlock_and_disable;
+	}
+
+	/* TODO - perform actual enabling here */
+
+	scx_cgroup_unlock();
+	percpu_up_write(&scx_fork_rwsem);
+
+	pr_info("sched_ext: BPF sub-scheduler \"%s\" enabled\n", sch->ops.name);
+	kobject_uevent(&sch->kobj, KOBJ_ADD);
+	ret = 0;
+	goto out_unlock;
+
+out_put_cgrp:
+	cgroup_put(cgrp);
+out_unlock:
+	mutex_unlock(&scx_enable_mutex);
+	return ret;
+
+err_unlock_and_disable:
+	scx_cgroup_unlock();
+	percpu_up_write(&scx_fork_rwsem);
+err_disable:
+	mutex_unlock(&scx_enable_mutex);
+	kthread_flush_work(&sch->disable_work);
+	return 0;
+}
+
+static int scx_cgroup_lifetime_notify(struct notifier_block *nb,
+				      unsigned long action, void *data)
+{
+	struct cgroup *cgrp = data;
+	struct cgroup *parent = cgroup_parent(cgrp);
+
+	if (!cgroup_on_dfl(cgrp))
+		return NOTIFY_OK;
+
+	switch (action) {
+	case CGROUP_LIFETIME_ONLINE:
+		/* inherit ->scx_sched from $parent */
+		if (parent)
+			rcu_assign_pointer(cgrp->scx_sched, parent->scx_sched);
+		break;
+	case CGROUP_LIFETIME_OFFLINE:
+		/* if there is a sched attached, shoot it down */
+		if (cgrp->scx_sched && cgrp->scx_sched->cgrp == cgrp)
+			scx_exit(cgrp->scx_sched, SCX_EXIT_UNREG_KERN,
+				 SCX_ECODE_RSN_CGROUP_OFFLINE,
+				 "cgroup %llu going offline", cgroup_id(cgrp));
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block scx_cgroup_lifetime_nb = {
+	.notifier_call = scx_cgroup_lifetime_notify,
+};
+
+static int __init scx_cgroup_lifetime_notifier_init(void)
+{
+	return blocking_notifier_chain_register(&cgroup_lifetime_notifier,
+						&scx_cgroup_lifetime_nb);
+}
+core_initcall(scx_cgroup_lifetime_notifier_init);
+#endif	/* CONFIG_EXT_SUB_SCHED */
 
 /********************************************************************************
  * bpf_struct_ops plumbing.
@@ -4913,6 +5345,11 @@ static int bpf_scx_init_member(const struct btf_type *t,
 	case offsetof(struct sched_ext_ops, hotplug_seq):
 		ops->hotplug_seq = *(u64 *)(udata + moff);
 		return 1;
+#ifdef CONFIG_EXT_SUB_SCHED
+	case offsetof(struct sched_ext_ops, sub_cgroup_id):
+		ops->sub_cgroup_id = *(u64 *)(udata + moff);
+		return 1;
+#endif	/* CONFIG_EXT_SUB_SCHED */
 	}
 
 	return 0;
@@ -4935,6 +5372,8 @@ static int bpf_scx_check_member(const struct btf_type *t,
 	case offsetof(struct sched_ext_ops, cpu_offline):
 	case offsetof(struct sched_ext_ops, init):
 	case offsetof(struct sched_ext_ops, exit):
+	case offsetof(struct sched_ext_ops, sub_attach):
+	case offsetof(struct sched_ext_ops, sub_detach):
 		break;
 	default:
 		if (prog->sleepable)
@@ -4946,7 +5385,13 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 static int bpf_scx_reg(void *kdata, struct bpf_link *link)
 {
-	return scx_root_enable(kdata, link);
+	struct sched_ext_ops *ops = kdata;
+
+#ifdef CONFIG_EXT_SUB_SCHED
+	if (ops->sub_cgroup_id > 1)
+		return scx_sub_enable(ops, link);
+#endif	/* CONFIG_EXT_SUB_SCHED */
+	return scx_root_enable(ops, link);
 }
 
 static void bpf_scx_unreg(void *kdata, struct bpf_link *link)
@@ -5011,7 +5456,9 @@ static void sched_ext_ops__cgroup_move(struct task_struct *p, struct cgroup *fro
 static void sched_ext_ops__cgroup_cancel_move(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
 static void sched_ext_ops__cgroup_set_weight(struct cgroup *cgrp, u32 weight) {}
 static void sched_ext_ops__cgroup_set_bandwidth(struct cgroup *cgrp, u64 period_us, u64 quota_us, u64 burst_us) {}
-#endif
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+static s32 sched_ext_ops__sub_attach(struct scx_sub_attach_args *args) { return -EINVAL; }
+static void sched_ext_ops__sub_detach(struct scx_sub_detach_args *args) {}
 static void sched_ext_ops__cpu_online(s32 cpu) {}
 static void sched_ext_ops__cpu_offline(s32 cpu) {}
 static s32 sched_ext_ops__init(void) { return -EINVAL; }
@@ -5050,6 +5497,8 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.cgroup_set_weight	= sched_ext_ops__cgroup_set_weight,
 	.cgroup_set_bandwidth	= sched_ext_ops__cgroup_set_bandwidth,
 #endif
+	.sub_attach		= sched_ext_ops__sub_attach,
+	.sub_detach		= sched_ext_ops__sub_detach,
 	.cpu_online		= sched_ext_ops__cpu_online,
 	.cpu_offline		= sched_ext_ops__cpu_offline,
 	.init			= sched_ext_ops__init,
@@ -5319,7 +5768,9 @@ void __init init_sched_ext_class(void)
 		struct rq *rq = cpu_rq(cpu);
 		int  n = cpu_to_node(cpu);
 
-		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
+		/* local_dsq's local_dsqs will be set during scx_root_enable() */
+		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL);
+
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
 
@@ -5905,16 +6356,16 @@ __bpf_kfunc s32 scx_bpf_create_dsq(u64 dsq_id, s32 node)
 	if (!dsq)
 		return -ENOMEM;
 
-	init_dsq(dsq, dsq_id);
-
 	rcu_read_lock();
 
 	sch = rcu_dereference(scx_root);
-	if (sch)
+	if (sch) {
+		init_dsq(dsq, dsq_id, sch);
 		ret = rhashtable_lookup_insert_fast(&sch->dsq_hash, &dsq->hash_node,
 						    dsq_hash_params);
-	else
+	} else {
 		ret = -ENODEV;
+	}
 
 	rcu_read_unlock();
 	if (ret)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index b3617abed510..2e3aa3888ce0 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -23,6 +23,8 @@ enum scx_consts {
 	 * scx_tasks_lock to avoid causing e.g. CSD and RCU stalls.
 	 */
 	SCX_TASK_ITER_BATCH		= 32,
+
+	SCX_SUB_MAX_DEPTH		= 4,
 };
 
 enum scx_exit_kind {
@@ -33,6 +35,7 @@ enum scx_exit_kind {
 	SCX_EXIT_UNREG_BPF,	/* BPF-initiated unregistration */
 	SCX_EXIT_UNREG_KERN,	/* kernel-initiated unregistration */
 	SCX_EXIT_SYSRQ,		/* requested by 'S' sysrq */
+	SCX_EXIT_PARENT,	/* parent exiting */
 
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
@@ -57,6 +60,7 @@ enum scx_exit_kind {
 enum scx_exit_code {
 	/* Reasons */
 	SCX_ECODE_RSN_HOTPLUG	= 1LLU << 32,
+	SCX_ECODE_RSN_CGROUP_OFFLINE = 2LLU << 32,
 
 	/* Actions */
 	SCX_ECODE_ACT_RESTART	= 1LLU << 48,
@@ -208,7 +212,7 @@ struct scx_exit_task_args {
 	bool cancelled;
 };
 
-/* argument container for ops->cgroup_init() */
+/* argument container for ops.cgroup_init() */
 struct scx_cgroup_init_args {
 	/* the weight of the cgroup [1..10000] */
 	u32			weight;
@@ -231,12 +235,12 @@ enum scx_cpu_preempt_reason {
 };
 
 /*
- * Argument container for ops->cpu_acquire(). Currently empty, but may be
+ * Argument container for ops.cpu_acquire(). Currently empty, but may be
  * expanded in the future.
  */
 struct scx_cpu_acquire_args {};
 
-/* argument container for ops->cpu_release() */
+/* argument container for ops.cpu_release() */
 struct scx_cpu_release_args {
 	/* the reason the CPU was preempted */
 	enum scx_cpu_preempt_reason reason;
@@ -245,9 +249,7 @@ struct scx_cpu_release_args {
 	struct task_struct	*task;
 };
 
-/*
- * Informational context provided to dump operations.
- */
+/* informational context provided to dump operations */
 struct scx_dump_ctx {
 	enum scx_exit_kind	kind;
 	s64			exit_code;
@@ -256,6 +258,18 @@ struct scx_dump_ctx {
 	u64			at_jiffies;
 };
 
+/* argument container for ops.sub_attach() */
+struct scx_sub_attach_args {
+	struct sched_ext_ops	*ops;
+	char			*cgroup_path;
+};
+
+/* argument container for ops.sub_detach() */
+struct scx_sub_detach_args {
+	struct sched_ext_ops	*ops;
+	char			*cgroup_path;
+};
+
 /**
  * struct sched_ext_ops - Operation table for BPF scheduler implementation
  *
@@ -705,6 +719,20 @@ struct sched_ext_ops {
 
 #endif	/* CONFIG_EXT_GROUP_SCHED */
 
+	/**
+	 * @sub_attach: Attach a sub-scheduler
+	 * @args: argument container, see the struct definition
+	 *
+	 * Return 0 to accept the sub-scheduler. -errno to reject.
+	 */
+	s32 (*sub_attach)(struct scx_sub_attach_args *args);
+
+	/**
+	 * @sub_detach: Detach a sub-scheduler
+	 * @args: argument container, see the struct definition
+	 */
+	void (*sub_detach)(struct scx_sub_detach_args *args);
+
 	/*
 	 * All online ops must come before ops.cpu_online().
 	 */
@@ -746,6 +774,10 @@ struct sched_ext_ops {
 	 */
 	void (*exit)(struct scx_exit_info *info);
 
+	/*
+	 * Data fields must comes after all ops fields.
+	 */
+
 	/**
 	 * @dispatch_max_batch: Max nr of tasks that dispatch() can dispatch
 	 */
@@ -780,6 +812,12 @@ struct sched_ext_ops {
 	 */
 	u64 hotplug_seq;
 
+	/**
+	 * @cgroup_id: When >1, attach the scheduler as a sub-scheduler on the
+	 * specified cgroup.
+	 */
+	u64 sub_cgroup_id;
+
 	/**
 	 * @name: BPF scheduler's name
 	 *
@@ -884,8 +922,20 @@ struct scx_sched {
 	struct scx_dispatch_q	**global_dsqs;
 	struct scx_sched_pcpu __percpu *pcpu;
 
+	s32			level;
 	bool			warned_zero_slice:1;
 	bool			warned_deprecated_rq:1;
+	bool			sub_attached:1;
+
+	struct list_head	all;
+
+#ifdef CONFIG_EXT_SUB_SCHED
+	struct list_head	children;
+	struct list_head	sibling;
+	struct cgroup		*cgrp;
+	char			*cgrp_path;
+	struct kset		*sub_kset;
+#endif	/* CONFIG_EXT_SUB_SCHED */
 
 	atomic_t		exit_kind;
 	struct scx_exit_info	*exit_info;
@@ -896,6 +946,9 @@ struct scx_sched {
 	struct irq_work		error_irq_work;
 	struct kthread_work	disable_work;
 	struct rcu_work		rcu_work;
+
+	/* all ancestors including self */
+	struct scx_sched	*ancestors[];
 };
 
 enum scx_wake_flags {
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 3072b593f898..9631e4d04d88 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -41,6 +41,7 @@ const volatile u32 dsp_batch;
 const volatile bool highpri_boosting;
 const volatile bool print_dsqs_and_events;
 const volatile bool print_msgs;
+const volatile u64 sub_cgroup_id;
 const volatile s32 disallow_tgid;
 const volatile bool suppress_dump;
 
@@ -848,7 +849,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	struct bpf_timer *timer;
 	s32 ret;
 
-	if (print_msgs)
+	if (print_msgs && !sub_cgroup_id)
 		print_cpus();
 
 	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
@@ -874,6 +875,11 @@ void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
 	UEI_RECORD(uei, ei);
 }
 
+s32 BPF_STRUCT_OPS(qmap_sub_attach, struct scx_sub_attach_args *args)
+{
+	return 0;
+}
+
 SCX_OPS_DEFINE(qmap_ops,
 	       .select_cpu		= (void *)qmap_select_cpu,
 	       .enqueue			= (void *)qmap_enqueue,
@@ -889,6 +895,7 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .cgroup_init		= (void *)qmap_cgroup_init,
 	       .cgroup_set_weight	= (void *)qmap_cgroup_set_weight,
 	       .cgroup_set_bandwidth	= (void *)qmap_cgroup_set_bandwidth,
+	       .sub_attach		= (void *)qmap_sub_attach,
 	       .cpu_online		= (void *)qmap_cpu_online,
 	       .cpu_offline		= (void *)qmap_cpu_offline,
 	       .init			= (void *)qmap_init,
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index ef701d45ba43..5d762d10f4db 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -10,6 +10,7 @@
 #include <inttypes.h>
 #include <signal.h>
 #include <libgen.h>
+#include <sys/stat.h>
 #include <bpf/bpf.h>
 #include <scx/common.h>
 #include "scx_qmap.bpf.skel.h"
@@ -67,7 +68,7 @@ int main(int argc, char **argv)
 
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
-	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PMHd:D:Spvh")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:l:b:PMHc:d:D:Spvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -96,6 +97,16 @@ int main(int argc, char **argv)
 		case 'H':
 			skel->rodata->highpri_boosting = true;
 			break;
+		case 'c': {
+			struct stat st;
+			if (stat(optarg, &st) < 0) {
+				perror("stat");
+				return 1;
+			}
+			skel->struct_ops.qmap_ops->sub_cgroup_id = st.st_ino;
+			skel->rodata->sub_cgroup_id = st.st_ino;
+			break;
+		}
 		case 'd':
 			skel->rodata->disallow_tgid = strtol(optarg, NULL, 0);
 			if (skel->rodata->disallow_tgid < 0)
-- 
2.51.0


