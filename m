Return-Path: <bpf+bounces-69074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B18B9B8BC6F
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7DC3BB6CB
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF37518DB02;
	Sat, 20 Sep 2025 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YODe3xnG"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B242E6CB5;
	Sat, 20 Sep 2025 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758330017; cv=none; b=URZqHFDqYfT04Sg2jeCLA+Y3tLr7OmnshWi+Y741abUiEeHF249JqL7MNH+UXrNP9mUULt9bke+glnmLvj2hRkHM3TOioNGQ+HbKEX3nJEEBnSHEKq1nDzpWCBokTZdXqE/8PLO5mAcYBPsInR7A69cCDTsPumMIkHLSnk85zmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758330017; c=relaxed/simple;
	bh=GV4m+pDemBePBFTLYYzQlVEQC8J37avehTmLiPOom58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvEFSu8GIVkRTnYVAaZMU0lNOVaQD3AVZOfs0Faqgv75m6aU9YyfTLQtoMDIzb84DpelzcJgtQvkwu02JVMcsOerKs8ZlcqrtUEyJ4zw6Xqp3gJC7sJU4l5Inr/6PR1CzKdjuAyKPumI2wwVPbj/X8cRffhaEsWY9N3gZCdKbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YODe3xnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC17AC4CEF9;
	Sat, 20 Sep 2025 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758330017;
	bh=GV4m+pDemBePBFTLYYzQlVEQC8J37avehTmLiPOom58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YODe3xnGOffTwi22gTTEgQeWFIzAPf6GxMiqNZ1YCu5oz3xvqiaQjTGF+AUl+l1nX
	 5GF6Jz34xuEUAEFgear5zarjPlYnmCAupbzMpqWa3rT6A0LPQxs/2QHs9Ap6VGqopi
	 wVlVNhFoR9NiWyj+KcVToeJuREBoGf8uFL/kgvwlkvnfmmj1BI3oPC/0zGFWF5ZRLA
	 xWwGt8wDmalhBKDNpuXWL5nkITQEZ8xGCzxNO/PEKj4DX06kb4TPtRM1mwZV1/8xzg
	 2zVR4kWXbDBogNPT2G8hWPWjXeyfN2KSmumm2orfXNuNx94ca9U14DuMXCc5+fM8OA
	 4kTowfJVPY8UQ==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 40/46] sched_ext: Implement cgroup sub-sched enabling and disabling
Date: Fri, 19 Sep 2025 14:59:03 -1000
Message-ID: <20250920005931.2753828-41-tj@kernel.org>
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

The preceding changes implemented the framework to support cgroup
sub-scheds and updated scheduling paths and kfuncs so that they have
minimal but working support for sub-scheds. However, actual sub-sched
enabling/disabling hasn't been implemented yet and all tasks stayed on
scx_root.

Implement cgroup sub-sched enabling and disabling to actually activate
sub-scheds:

- Both enable and disable operations bypass only the tasks in the subtree
  of the child being enabled or disabled to limit disruptions.

- When enabling, all candidate tasks are first initialized for the child
  sched. Once that succeeds, the tasks are exited for the parent and then
  switched over to the child. This adds a bit of complication but
  guarantees that child scheduler failures are always contained.

- Disabling works the same way in the other direction. However, when the
  parent may fail to initialize a task, disabling is propagated up to the
  parent. While this means that a parent sched fail due to a child sched
  event, the failure can only originate from the parent itself (its
  ops.init_task()). The only effect a malfunctioning child can have on the
  parent is attempting to move the tasks back to the parent.

After this change, although not all the necessary mechanisms are in place
yet, sub-scheds can take control of their tasks and schedule them.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |   1 +
 kernel/sched/ext.c        | 281 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 276 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 73f9df0759e2..df1111d245bc 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -74,6 +74,7 @@ enum scx_ent_flags {
 	SCX_TASK_QUEUED		= 1 << 0, /* on ext runqueue */
 	SCX_TASK_RESET_RUNNABLE_AT = 1 << 2, /* runnable_at should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 3, /* last dequeue was for SLEEP */
+	SCX_TASK_SUB_INIT	= 1 << 4, /* task being initialized for a sub sched */
 
 	SCX_TASK_STATE_SHIFT	= 8,	  /* bit 8 and 9 are used to carry scx_task_state */
 	SCX_TASK_STATE_BITS	= 2,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 1a48510e6f98..eff5f6894f14 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -58,6 +58,15 @@ DEFINE_STATIC_KEY_FALSE(__scx_switched_all);
 static atomic_long_t scx_nr_rejected = ATOMIC_LONG_INIT(0);
 static atomic_long_t scx_hotplug_seq = ATOMIC_LONG_INIT(0);
 
+#ifdef CONFIG_EXT_SUB_SCHED
+/*
+ * The sub sched being enabled. Used by scx_disable_and_exit_task() to exit
+ * tasks for the sub-sched being enabled. Use a global variable instead of a
+ * per-task field as all enables are serialized.
+ */
+static struct scx_sched *scx_enabling_sub_sched = NULL;
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 /*
  * A monotically increasing sequence number that is incremented every time a
  * scheduler is enabled. This can be used by to check if any custom sched_ext
@@ -3047,6 +3056,17 @@ static void scx_disable_and_exit_task(struct scx_sched *sch,
 {
 	__scx_disable_and_exit_task(sch, p);
 
+	/*
+	 * If set, @p exited between __scx_init_task() and scx_enable_task() in
+	 * scx_sub_enable() and is initialized for both the associated sched and
+	 * its parent. Disable and exit for the child too.
+	 */
+	if ((p->scx.flags & SCX_TASK_SUB_INIT) &&
+	    !WARN_ON_ONCE(!scx_enabling_sub_sched)) {
+		__scx_disable_and_exit_task(scx_enabling_sub_sched, p);
+		p->scx.flags &= ~SCX_TASK_SUB_INIT;
+	}
+
 	scx_set_task_sched(p, NULL);
 	scx_set_task_state(p, SCX_TASK_NONE);
 }
@@ -3082,9 +3102,11 @@ int scx_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	percpu_rwsem_assert_held(&scx_fork_rwsem);
 
 	if (scx_init_task_enabled) {
-		ret = scx_init_task(scx_root, p, true);
+		struct scx_sched *sch = kargs->cset->dfl_cgrp->scx_sched;
+
+		ret = scx_init_task(sch, p, true);
 		if (!ret)
-			scx_set_task_sched(p, scx_root);
+			scx_set_task_sched(p, sch);
 		return ret;
 	}
 
@@ -4004,9 +4026,9 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 		struct rq *rq = cpu_rq(cpu);
 		struct task_struct *p, *n;
 
+		raw_spin_lock(&scx_sched_lock);	/* nests outside rq_lock */
 		raw_spin_rq_lock(rq);
 
-		raw_spin_lock(&scx_sched_lock);
 		scx_for_each_descendant_pre(pos, sch) {
 			struct scx_sched_pcpu *pcpu = per_cpu_ptr(pos->pcpu, cpu);
 
@@ -4015,6 +4037,7 @@ static void scx_bypass(struct scx_sched *sch, bool bypass)
 			else
 				pcpu->flags &= ~SCX_SCHED_PCPU_BYPASSING;
 		}
+
 		raw_spin_unlock(&scx_sched_lock);
 
 		/*
@@ -4161,23 +4184,141 @@ static void scx_propagate_disable_and_flush(struct scx_sched *sch)
 	wait_event(scx_unlink_waitq, list_empty(&sch->children));
 }
 
+static void scx_fail_parent(struct scx_sched *sch,
+			    struct task_struct *failed, int fail_code)
+{
+	struct scx_sched *parent = scx_parent(sch);
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	struct sched_enq_and_set_ctx ctx;
+
+	scx_error(parent, "ops.init_task() failed (%d) for %s[%d] while disabling a sub-scheduler",
+		  fail_code, failed->comm, failed->pid);
+
+	/*
+	 * Once $parent is bypassed, it's safe to put SCX_TASK_NONE tasks into
+	 * it. This may cause downstream failures on the BPF side but $parent is
+	 * dying anyway.
+	 */
+	scx_bypass(parent, true);
+
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		if (scx_task_sched(p) == parent)
+			continue;
+
+		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+		scx_disable_and_exit_task(sch, p);
+		rcu_assign_pointer(p->scx.sched, parent);
+		sched_enq_and_set_task(&ctx);
+	}
+	scx_task_iter_stop(&sti);
+}
+
 static void scx_sub_disable(struct scx_sched *sch)
 {
 	struct scx_sched *parent = scx_parent(sch);
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	int ret;
 
+	/*
+	 * Guarantee forward progress and disable all descendants. To limit
+	 * disruptions, $parent is not bypassed. Tasks are fully prepped and
+	 * then inserted back into $parent.
+	 */
+	scx_bypass(sch, true);
 	scx_propagate_disable_and_flush(sch);
 
+	/*
+	 * Here, every runnable task is guaranteed to make forward progress and
+	 * we can safely use blocking synchronization constructs. Actually
+	 * disable ops.
+	 */
 	mutex_lock(&scx_enable_mutex);
 	percpu_down_write(&scx_fork_rwsem);
 	scx_cgroup_lock();
 
 	set_cgroup_sched(sch->cgrp, parent);
 
-	/* TODO - perform actual disabling here */
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		struct rq *rq;
+		struct rq_flags rf;
+		struct sched_enq_and_set_ctx ctx;
+
+		/* filter out duplicate visits */
+		if (scx_task_sched(p) == parent)
+			continue;
+
+		/*
+		 * By the time control reaches here, all descendant schedulers
+		 * should already have been disabled.
+		 */
+		WARN_ON_ONCE(scx_task_sched(p) != sch);
+
+		/*
+		 * If $p is about to be freed, nothing prevents $sch from
+		 * unloading before $p reaches sched_ext_free(). Disable and
+		 * exit $p right away.
+		 */
+		if (!tryget_task_struct(p)) {
+			scx_disable_and_exit_task(sch, p);
+			continue;
+		}
+
+		scx_task_iter_unlock(&sti);
+
+		/*
+		 * $p is READY or ENABLED on @sch. Initialize for $parent,
+		 * disable and exit from @sch, and then switch over to $parent.
+		 *
+		 * If a task fails to initialize for $parent, the only available
+		 * action is disabling $parent too. While this allows disabling
+		 * of a child sched to cause the parent scheduler to fail, the
+		 * failure can only originate from ops.init_task() of the
+		 * parent. A child can't directly affect the parent through its
+		 * own failures.
+		 */
+		ret = __scx_init_task(parent, p, false);
+		if (ret) {
+			scx_fail_parent(parent, p, ret);
+			put_task_struct(p);
+			break;
+		}
+
+		rq = task_rq_lock(p, &rf);
+		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+
+		/*
+		 * $p is initialized for $parent and still attached to @sch.
+		 * Disable and exit for @sch, switch over to $parent, override
+		 * the state to READY to account for $p having already been
+		 * initialized, and then enable.
+		 */
+		scx_disable_and_exit_task(sch, p);
+		scx_set_task_state(p, SCX_TASK_INIT);
+		rcu_assign_pointer(p->scx.sched, parent);
+		scx_set_task_state(p, SCX_TASK_READY);
+		scx_enable_task(parent, p);
+
+		sched_enq_and_set_task(&ctx);
+		task_rq_unlock(rq, p, &rf);
+
+		put_task_struct(p);
+	}
+	scx_task_iter_stop(&sti);
 
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
+	/*
+	 * All tasks are moved off of @sch but there may still be on-going
+	 * operations (e.g. ops.select_cpu()). Drain them by flushing RCU. Use
+	 * the expedited version as ancestors may be waiting in bypass mode.
+	 */
+	synchronize_rcu_expedited();
+
 	raw_spin_lock_irq(&scx_sched_lock);
 	list_del_init(&sch->sibling);
 	list_del_rcu(&sch->all);
@@ -5222,11 +5363,29 @@ static struct scx_sched *find_parent_sched(struct cgroup *cgrp)
 	return parent;
 }
 
+static bool assert_task_ready_or_enabled(struct task_struct *p)
+{
+	enum scx_task_state state = scx_get_task_state(p);
+
+	switch (state) {
+	case SCX_TASK_READY:
+	case SCX_TASK_ENABLED:
+		return true;
+	default:
+		WARN_ONCE(true, "sched_ext: Invalid task state %d for %s[%d] during enabling sub sched",
+			  state, p->comm, p->pid);
+		return false;
+	}
+}
+
 static int scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 {
 	struct cgroup *cgrp;
 	struct scx_sched *parent, *sch;
-	int ret;
+	struct scx_task_iter sti;
+	struct task_struct *p;
+	struct sched_enq_and_set_ctx ctx;
+	int i, ret;
 
 	mutex_lock(&scx_enable_mutex);
 
@@ -5316,6 +5475,12 @@ static int scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	}
 	sch->sub_attached = true;
 
+	scx_bypass(sch, true);
+
+	for (i = SCX_OPI_BEGIN; i < SCX_OPI_END; i++)
+		if (((void (**)(void))ops)[i])
+			set_bit(i, sch->has_op);
+
 	percpu_down_write(&scx_fork_rwsem);
 	scx_cgroup_lock();
 
@@ -5329,16 +5494,119 @@ static int scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		goto err_unlock_and_disable;
 	}
 
-	/* TODO - perform actual enabling here */
+	/*
+	 * Initialize tasks for the new child $sch without exiting them for
+	 * $parent so that the tasks can always be reverted back to $parent
+	 * sched on child init failure.
+	 */
+	WARN_ON_ONCE(scx_enabling_sub_sched);
+	scx_enabling_sub_sched = sch;
+
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		struct rq *rq;
+		struct rq_flags rf;
+
+		/*
+		 * Task iteration may visit the same task twice when racing
+		 * against exiting. Use %SCX_TASK_SUB_INIT to mark tasks which
+		 * finished __scx_init_task() and skip if set.
+		 *
+		 * A task may exit and get freed between __scx_init_task()
+		 * completion and scx_enable_task(). In such cases,
+		 * scx_disable_and_exit_task() must exit the task for both the
+		 * parent and child scheds.
+		 */
+		if (p->scx.flags & SCX_TASK_SUB_INIT)
+			continue;
+
+		/* see scx_root_enable() */
+		if (!tryget_task_struct(p))
+			continue;
+
+		if (!assert_task_ready_or_enabled(p)) {
+			scx_task_iter_stop(&sti);
+			goto exit_tasks;
+		}
+
+		scx_task_iter_unlock(&sti);
+
+		/*
+		 * As $p is still on $parent, it can't be transitioned to INIT.
+		 * Let's worry about task state later. Use __scx_init_task().
+		 */
+		ret = __scx_init_task(sch, p, false);
+		if (ret) {
+			put_task_struct(p);
+			scx_task_iter_stop(&sti);
+			goto exit_tasks;
+		}
+
+		rq = task_rq_lock(p, &rf);
+		p->scx.flags |= SCX_TASK_SUB_INIT;
+		task_rq_unlock(rq, p, &rf);
+
+		put_task_struct(p);
+	}
+	scx_task_iter_stop(&sti);
+
+	/*
+	 * All tasks are prepped. Disable/exit tasks for $parent and enable for
+	 * the new @sch.
+	 */
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		/*
+		 * Use clearing of %SCX_TASK_SUB_INIT to detect and skip
+		 * duplicate iterations.
+		 */
+		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
+			continue;
+
+		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
+
+		/*
+		 * $p must be either READY or ENABLED. If ENABLED,
+		 * __scx_disabled_and_exit_task() first disables and makes it
+		 * READY. However, after exiting $p, it will leave $p as READY.
+		 */
+		assert_task_ready_or_enabled(p);
+		__scx_disable_and_exit_task(parent, p);
+
+		/*
+		 * $p is now only initialized for @sch and READY, which is what
+		 * we want. Assign it to @sch and enable.
+		 */
+		rcu_assign_pointer(p->scx.sched, sch);
+		scx_enable_task(sch, p);
+
+		p->scx.flags &= ~SCX_TASK_SUB_INIT;
+
+		sched_enq_and_set_task(&ctx);
+	}
+	scx_task_iter_stop(&sti);
+
+	scx_enabling_sub_sched = NULL;
 
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
+	scx_bypass(sch, false);
+
 	pr_info("sched_ext: BPF sub-scheduler \"%s\" enabled\n", sch->ops.name);
 	kobject_uevent(&sch->kobj, KOBJ_ADD);
 	ret = 0;
 	goto out_unlock;
 
+exit_tasks:
+	scx_task_iter_start(&sti, sch->cgrp);
+	while ((p = scx_task_iter_next_locked(&sti))) {
+		if (p->scx.flags & SCX_TASK_SUB_INIT) {
+			__scx_disable_and_exit_task(sch, p);
+			p->scx.flags &= ~SCX_TASK_SUB_INIT;
+		}
+	}
+	scx_task_iter_stop(&sti);
 out_put_cgrp:
 	cgroup_put(cgrp);
 out_unlock:
@@ -5346,6 +5614,7 @@ static int scx_sub_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	return ret;
 
 err_unlock_and_disable:
+	/* we'll soon enter disable path, keep bypass on */
 	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 err_disable:
-- 
2.51.0


