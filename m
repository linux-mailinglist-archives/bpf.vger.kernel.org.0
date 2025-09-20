Return-Path: <bpf+bounces-69049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEB0B8BBCA
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 363BE1C219C3
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7202A265629;
	Sat, 20 Sep 2025 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+X/sJw/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E219E264F96;
	Sat, 20 Sep 2025 00:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329990; cv=none; b=L8Z6xKsczFTcIUtZ0oPO3saZL3WPlYYkqKXA2aFiGx6HJ7ysR1w6eTfmFEBH54eWkrqQs63OFonsIcOxSbeYP0CMbY/dbgErEzIlDMHF/VXACvV7tkIRoSlMq0S0TWx0U6kocdpU8d86mV9Cq71IJI2LleALgHgWmbm7kNUaJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329990; c=relaxed/simple;
	bh=bBerLODwZe/5/M+G4P1dLF8pLaspUup+2kegtusMO3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQfN9DYG0MXljMgVttPCzuOweXQL3v2PcHolVg7D/3IjqQa7SI1zbMx/aXjeKgTzf0Ck1b3XeaeFCV/qmhrWImXJ1txr0LIHLPtnfJwpWAPAy6NIHLNL3ruTkh578BiuChdc+GSu+E/2K+KXsYQHizF9NJWD3vB+QXl/9zbIEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+X/sJw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D4C4CEF0;
	Sat, 20 Sep 2025 00:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329989;
	bh=bBerLODwZe/5/M+G4P1dLF8pLaspUup+2kegtusMO3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G+X/sJw/ZccufdUjS8lv7med6kaTb1zsy7+2pvo5hooaTIgQyNJe1haqn2cn4EtRq
	 L1OncUzuGSn7hsd9C6Q2vvTYd8x7Zb2rWUdLEQOjmwjG3zEKommYZGbG/6hU8CNWaF
	 /nMYTQ9LPjswQMgge4tBK7FBGbxBfmNXi2lKxxApXb1hkx+vdEQ+TEjfUi8PSWlOFL
	 l646kM+8XnAaCK4VT/PXpvBSSz3x14oiDaJIdIBFjH8FwjuDZtwu4cSganaa2PO+57
	 jwQ+dB7w8uLJYZ6qf4qmy8Bf7q7B2tmLGKBsyWD1dypnk/FaWZQCkrra5UHeHskUXU
	 1ASZfXhrBNN0A==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 15/46] sched_ext: Keep dying tasks on a separate list
Date: Fri, 19 Sep 2025 14:58:38 -1000
Message-ID: <20250920005931.2753828-16-tj@kernel.org>
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

sched_ext needs to be able to iterate all tasks until the task finishes its
final scheduling event which can be after it is dropped out of pid hash. The
scx_tasks list keeps track of all tasks between fork and free for this
purpose.

The planned cgroup sub-scheduler support requires selectively iterating
tasks belonging to cgroup subtrees. While the live tasks can be iterated
using css_task_iter, there is a similar gap after removal from css. As there
won't be too many tasks between release and free at any moment, this can be
reasonably addressed by scanning dying tasks looking for tasks which are
inside the cgroup subtree.

In preparation, split out scx_tasks lists into two - scx_live_tasks and
scx_dying_tasks. scx_task_iter is updated to first iterate scx_live_tasks
and then scx_dying_tasks. As tasks can only move from the former to the
latter, tasks can't escape iteration; however, it's possible for newly dying
tasks to appear twice during iteration. The users of scx_task_iter are
updated to handle duplicate iterations.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h |  2 ++
 kernel/exit.c             |  1 +
 kernel/sched/ext.c        | 70 +++++++++++++++++++++++++++++----------
 3 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d82b7a9b0658..7290c4354ad6 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -207,6 +207,7 @@ struct sched_ext_entity {
 	struct list_head	tasks_node;
 };
 
+void sched_ext_exit(struct task_struct *p);
 void sched_ext_free(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
@@ -214,6 +215,7 @@ bool scx_rcu_cpu_stall(void);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
+static inline void sched_ext_exit(struct task_struct *p) {}
 static inline void sched_ext_free(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
diff --git a/kernel/exit.c b/kernel/exit.c
index 343eb97543d5..0bdbaa85ef43 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -962,6 +962,7 @@ void __noreturn do_exit(long code)
 	exit_thread(tsk);
 
 	sched_autogroup_exit_task(tsk);
+	sched_ext_exit(tsk);
 	cgroup_exit(tsk);
 
 	/*
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 32306203fba5..6ae9ee5b9a50 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -20,13 +20,21 @@
 static struct scx_sched __rcu *scx_root;
 
 /*
- * During exit, a task may schedule after losing its PIDs. When disabling the
- * BPF scheduler, we need to be able to iterate tasks in every state to
- * guarantee system safety. Maintain a dedicated task list which contains every
- * task between its fork and eventual free.
+ * - We want to visit and perform sleepable operations on every task.
+ *
+ * - During exit, a task may schedule after losing its PIDs. When disabling the
+ *   BPF scheduler, we need to be able to iterate tasks in every state to
+ *   guarantee system safety.
+ *
+ * Maintain a dedicated task list which contains every task between its fork and
+ * eventual free. Live and exiting tasks are kept on separate lists so that the
+ * dying task iteration can be combined with cgroup task iteration. This leads
+ * to occasional double visiting of existing tasks but those aren't difficult
+ * to handle from users.
  */
 static DEFINE_SPINLOCK(scx_tasks_lock);
-static LIST_HEAD(scx_tasks);
+static LIST_HEAD(scx_live_tasks);
+static LIST_HEAD(scx_dying_tasks);
 
 /* ops enable/disable */
 static DEFINE_MUTEX(scx_enable_mutex);
@@ -436,6 +444,7 @@ struct bpf_iter_scx_dsq {
  * SCX task iterator.
  */
 struct scx_task_iter {
+	struct list_head		*head;
 	struct sched_ext_entity		cursor;
 	struct task_struct		*locked_task;
 	struct rq			*rq;
@@ -458,7 +467,8 @@ struct scx_task_iter {
  * RCU read lock or obtaining a reference count.
  *
  * All tasks which existed when the iteration started are guaranteed to be
- * visited as long as they still exist.
+ * visited as long as they still exist. Tasks which exit while iteration is in
+ * progress may be visited twice. The caller must be able to handle such cases.
  */
 static void scx_task_iter_start(struct scx_task_iter *iter)
 {
@@ -467,8 +477,9 @@ static void scx_task_iter_start(struct scx_task_iter *iter)
 
 	spin_lock_irq(&scx_tasks_lock);
 
+	iter->head = &scx_live_tasks;
 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
-	list_add(&iter->cursor.tasks_node, &scx_tasks);
+	list_add(&iter->cursor.tasks_node, &scx_live_tasks);
 	iter->locked_task = NULL;
 	iter->cnt = 0;
 	iter->list_locked = true;
@@ -527,9 +538,11 @@ static void scx_task_iter_stop(struct scx_task_iter *iter)
  * scx_task_iter_next - Next task
  * @iter: iterator to walk
  *
- * Visit the next task. See scx_task_iter_start() for details. Locks are dropped
- * and re-acquired every %SCX_TASK_ITER_BATCH iterations to avoid causing stalls
- * by holding scx_tasks_lock for too long.
+ * Visit the next task. Existing tasks may be visited twice. See
+ * scx_task_iter_start() for details.
+ *
+ * Locks are dropped and re-acquired every %SCX_TASK_ITER_BATCH iterations to
+ * avoid causing stalls by holding scx_tasks_lock for too long.
  */
 static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 {
@@ -543,18 +556,23 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 		cond_resched();
 		__scx_task_iter_maybe_relock(iter);
 	}
-
+retry:
 	list_for_each_entry(pos, cursor, tasks_node) {
-		if (&pos->tasks_node == &scx_tasks)
-			return NULL;
+		if (&pos->tasks_node == iter->head)
+			break;
 		if (!(pos->flags & SCX_TASK_CURSOR)) {
 			list_move(cursor, &pos->tasks_node);
 			return container_of(pos, struct task_struct, scx);
 		}
 	}
 
-	/* can't happen, should always terminate at scx_tasks above */
-	BUG();
+	if (iter->head == &scx_live_tasks) {
+		iter->head = &scx_dying_tasks;
+		list_move(cursor, iter->head);
+		goto retry;
+	}
+
+	return NULL;
 }
 
 /**
@@ -562,8 +580,8 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
  * @iter: iterator to walk
  *
  * Visit the non-idle task with its rq lock held. Allows callers to specify
- * whether they would like to filter out dead tasks. See scx_task_iter_start()
- * for details.
+ * whether they would like to filter out dead tasks. Exiting tasks may be
+ * visited twice. See scx_task_iter_start() for details.
  */
 static struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter)
 {
@@ -2905,7 +2923,7 @@ void scx_post_fork(struct task_struct *p)
 	}
 
 	spin_lock_irq(&scx_tasks_lock);
-	list_add_tail(&p->scx.tasks_node, &scx_tasks);
+	list_add_tail(&p->scx.tasks_node, &scx_live_tasks);
 	spin_unlock_irq(&scx_tasks_lock);
 
 	percpu_up_read(&scx_fork_rwsem);
@@ -2926,6 +2944,13 @@ void scx_cancel_fork(struct task_struct *p)
 	percpu_up_read(&scx_fork_rwsem);
 }
 
+void sched_ext_exit(struct task_struct *p)
+{
+	spin_lock_irq(&scx_tasks_lock);
+	list_move_tail(&p->scx.tasks_node, &scx_dying_tasks);
+	spin_unlock_irq(&scx_tasks_lock);
+}
+
 void sched_ext_free(struct task_struct *p)
 {
 	unsigned long flags;
@@ -3913,6 +3938,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
+		/* @p may be being visited twice, doesn't matter */
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
@@ -4615,6 +4641,13 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
+		/*
+		 * Task iteration may visit the same task twice when racing
+		 * against exiting. Skip if @p is already initialized.
+		 */
+		if (scx_get_task_state(p) == SCX_TASK_READY)
+			continue;
+
 		/*
 		 * @p may already be dead, have lost all its usages counts and
 		 * be waiting for RCU grace period before being freed. @p can't
@@ -4657,6 +4690,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	percpu_down_write(&scx_fork_rwsem);
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
+		/* @p may be being visited twice, doesn't matter */
 		const struct sched_class *old_class = p->sched_class;
 		const struct sched_class *new_class =
 			__setscheduler_class(p->policy, p->prio);
-- 
2.51.0


