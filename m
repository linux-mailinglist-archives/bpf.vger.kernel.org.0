Return-Path: <bpf+bounces-69051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592FAB8BBDB
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 03:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 083611C218ED
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B2926E714;
	Sat, 20 Sep 2025 00:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsHOe/Q4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB826B0A9;
	Sat, 20 Sep 2025 00:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758329992; cv=none; b=bXY0tW826d2En0J2IICHFJZrV6HFe/6frDMGlXhy7cbAHXEkydWS93V3CDsQyzoL+IOk8Z8i5PDqriYUW2SYJBfUjD5u+dsdLzSOoZdkE5c4yghbrpAurIACJIoXyoJCWUWHAN43lk2oovPXTfZHoFuAPwyCgUsOmi17/pwbLHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758329992; c=relaxed/simple;
	bh=miuMhAm8zQeRCBw5TWdnxgLR9H27xth1DY0riLLgPHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1V6f8/d9KRIhABCgC9k3cXIkhxJTcf1ZUgIYJU9pRCPE+yHGO36HNnpLM89l2xINuhKXZCzw4hdHohpr8/hBycJJTRm5qw+fIio8uGUy+ar58hrJj0wCEHzgesjAqOpV7YQn9PdHvvr8/ft9UWEyyw86A6Cv25z0eJVXRkk/jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsHOe/Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09D6C4CEF5;
	Sat, 20 Sep 2025 00:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758329990;
	bh=miuMhAm8zQeRCBw5TWdnxgLR9H27xth1DY0riLLgPHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LsHOe/Q4qWdTLV09TwfbrFk6guVGWsOQwgX1tm6+TLG8BEWgScl/NDVTd0Gj6Z8RO
	 vMsIZcncU1dUwzL+/Ugu7hTcFYoLGIHX8UW8bGzw4t1+9cFbpfjz6JQjJ7FazKMEiF
	 NWmgIo0F04kfhgDV0R526EGiU1G3LdOjeEbEGELxzADD63sCdVqT8CUU57R6IwYXud
	 Bve8CArWHyU9hU6oeFIK/Doe/0WL4AugpC/QYkPi+PNC4eV+wrma3ZA4UVn3bSRksT
	 rDPFGuHFoiLkoj6SakQFm1261wZDp8RW3kimbbsvbbMoFb70ndJZdZ8Nv01lKBXaJ1
	 wC9vs6Xa2tsVw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	arighi@nvidia.com,
	multics69@gmail.com
Cc: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 16/46] sched_ext: Implement cgroup subtree iteration for scx_task_iter
Date: Fri, 19 Sep 2025 14:58:39 -1000
Message-ID: <20250920005931.2753828-17-tj@kernel.org>
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

For the planned cgroup sub-scheduler support, enable/disable operations are
going to be subtree specific and iterating all tasks in the system for those
operations can be unnecessarily expensive and disruptive.

cgroup already has mechanisms to perform subtree task iterations. Implement
cgroup subtree iteration for scx_task_iter:

- Add optional @cgrp to scx_task_iter_start() which enables cgroup subtree
  iteration.

- Make scx_task_iter use combination of css_next_descendant_pre() and
  css_task_iter to iterate all live tasks for cgroup iterations.

- After live task iteration is finished, scan scx_dying_tasks and only visit
  tasks that are in the cgroup subtree. As scx_dying_tasks is most likely
  really short, this should be pretty cheap.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 76 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6ae9ee5b9a50..ca8221378924 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -451,11 +451,17 @@ struct scx_task_iter {
 	struct rq_flags			rf;
 	u32				cnt;
 	bool				list_locked;
+#ifdef CONFIG_CGROUPS
+	struct cgroup			*cgrp;
+	struct cgroup_subsys_state	*css_pos;
+	struct css_task_iter		css_iter;
+#endif
 };
 
 /**
  * scx_task_iter_start - Lock scx_tasks_lock and start a task iteration
  * @iter: iterator to init
+ * @cgrp: Optional root of cgroup subhierarchy to iterate
  *
  * Initialize @iter and return with scx_tasks_lock held. Once initialized, @iter
  * must eventually be stopped with scx_task_iter_stop().
@@ -469,8 +475,14 @@ struct scx_task_iter {
  * All tasks which existed when the iteration started are guaranteed to be
  * visited as long as they still exist. Tasks which exit while iteration is in
  * progress may be visited twice. The caller must be able to handle such cases.
+ *
+ * @if @cgrp is NULL, scx_live_tasks are walked followed by scx_dying_tasks. If
+ * @cgrp is not NULL, @cgrp's tasks are walked using css_task_iter followed by
+ * scx_dying_tasks. To guarantee that all tasks are visited at least once, the
+ * caller must be holding scx_fork_rwsem. In the cgroup case, the caller must
+ * also be holding scx_cgroup_rwsem to prevent cgroup task migrations.
  */
-static void scx_task_iter_start(struct scx_task_iter *iter)
+static void scx_task_iter_start(struct scx_task_iter *iter, struct cgroup *cgrp)
 {
 	BUILD_BUG_ON(__SCX_DSQ_ITER_ALL_FLAGS &
 		     ((1U << __SCX_DSQ_LNODE_PRIV_SHIFT) - 1));
@@ -478,8 +490,20 @@ static void scx_task_iter_start(struct scx_task_iter *iter)
 	spin_lock_irq(&scx_tasks_lock);
 
 	iter->head = &scx_live_tasks;
+#ifdef CONFIG_CGROUPS
+	if (cgrp) {
+		iter->cgrp = cgrp;
+		iter->css_pos = css_next_descendant_pre(NULL, &iter->cgrp->self);
+		css_task_iter_start(iter->css_pos, 0, &iter->css_iter);
+		/* walking cgroup tasks instead, skip scx_live_tasks */
+		iter->head = &scx_dying_tasks;
+	} else {
+		iter->cgrp = NULL;
+		iter->css_pos = NULL;
+	}
+#endif
 	iter->cursor = (struct sched_ext_entity){ .flags = SCX_TASK_CURSOR };
-	list_add(&iter->cursor.tasks_node, &scx_live_tasks);
+	list_add(&iter->cursor.tasks_node, iter->head);
 	iter->locked_task = NULL;
 	iter->cnt = 0;
 	iter->list_locked = true;
@@ -530,6 +554,8 @@ static void __scx_task_iter_maybe_relock(struct scx_task_iter *iter)
 static void scx_task_iter_stop(struct scx_task_iter *iter)
 {
 	__scx_task_iter_maybe_relock(iter);
+	if (iter->css_pos)
+		css_task_iter_end(&iter->css_iter);
 	list_del_init(&iter->cursor.tasks_node);
 	scx_task_iter_unlock(iter);
 }
@@ -557,13 +583,45 @@ static struct task_struct *scx_task_iter_next(struct scx_task_iter *iter)
 		__scx_task_iter_maybe_relock(iter);
 	}
 retry:
+
+#ifdef CONFIG_CGROUPS
+	/*
+	 * For cgroup iterations, use css_task_iter for live tasks. iter->head
+	 * is already set to scx_dying_tasks.
+	 */
+	while (iter->css_pos) {
+		struct task_struct *p;
+
+		p = css_task_iter_next(&iter->css_iter);
+		if (p)
+			return p;
+
+		css_task_iter_end(&iter->css_iter);
+		iter->css_pos = css_next_descendant_pre(iter->css_pos,
+							&iter->cgrp->self);
+		if (iter->css_pos)
+			css_task_iter_start(iter->css_pos, 0, &iter->css_iter);
+	}
+#endif
+
 	list_for_each_entry(pos, cursor, tasks_node) {
+		struct task_struct *p = container_of(pos, struct task_struct, scx);
+
 		if (&pos->tasks_node == iter->head)
 			break;
-		if (!(pos->flags & SCX_TASK_CURSOR)) {
-			list_move(cursor, &pos->tasks_node);
-			return container_of(pos, struct task_struct, scx);
-		}
+		if (pos->flags & SCX_TASK_CURSOR)
+			continue;
+#ifdef CONFIG_CGROUPS
+		/*
+		 * For cgroup iterations, this loop is only used for iterating
+		 * dying tasks. Filter out tasks which aren't in the target
+		 * subtree.
+		 */
+		if (iter->cgrp && !task_under_cgroup_hierarchy(p, iter->cgrp))
+			continue;
+#endif
+		list_move(cursor, &pos->tasks_node);
+		return p;
 	}
 
 	if (iter->head == &scx_live_tasks) {
@@ -3936,7 +3994,7 @@ static void scx_disable_workfn(struct kthread_work *work)
 
 	scx_init_task_enabled = false;
 
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		/* @p may be being visited twice, doesn't matter */
 		const struct sched_class *old_class = p->sched_class;
@@ -4639,7 +4697,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable_unlock_all;
 
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		/*
 		 * Task iteration may visit the same task twice when racing
@@ -4688,7 +4746,7 @@ static int scx_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 * scx_tasks_lock.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
-	scx_task_iter_start(&sti);
+	scx_task_iter_start(&sti, NULL);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		/* @p may be being visited twice, doesn't matter */
 		const struct sched_class *old_class = p->sched_class;
-- 
2.51.0


