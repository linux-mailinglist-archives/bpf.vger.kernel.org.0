Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A4F435472
	for <lists+bpf@lfdr.de>; Wed, 20 Oct 2021 22:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhJTUTt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Oct 2021 16:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhJTUTm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Oct 2021 16:19:42 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63614C06161C;
        Wed, 20 Oct 2021 13:17:26 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id m14so3901657pfc.9;
        Wed, 20 Oct 2021 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cgXZ387Wbvoo1J6NaJ0vqqYAv4vWovdxiYADyFmLcpY=;
        b=Tm2S6yYcLcGDER63RQsr/TxSVMQR8rttKkczk1SL9dkolZNicLZ1xKtV4MJlz9e8dO
         GkunQlzSvY0mi32rFG4+WFBjfUwLQ/1mkXVl/debXeetKGS5l7jC+6JgdhCDN2oDPIKR
         wg/8r2PJZ+mpDK5s2l+Iwzv7b9jeV5HjYpEahxJWQKF7xA2fGWO/MIP02kGntC1Pbq2s
         OTMWZ5jfZnTNb+ukaj27OZbL1pohROvyY4giAFGGqPONaaMSrK9qyh7HIG+ew4PtEhl5
         7fG+T/G3Of7S01+rtBI4z80xkZw9fNCpECOjU/yjpLrwNpD7orAEL+kKnAOwWBVX94Cq
         +uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cgXZ387Wbvoo1J6NaJ0vqqYAv4vWovdxiYADyFmLcpY=;
        b=O09YsOwzoXIalXDlzsXuRzZSKLQ5nGDVZ+Ir+JqsLc69NJee3FSsQjlZHvUHJd2i4q
         yZTA15QDFX+WywSCaqNtkCMMw/TksixZKqY23K08bt093GXla2XrhC4yVpeyZ3vmtF7Q
         kBVXeKdAVT/eBAyFiLUfoA88r8jQfqq6Bdvj9rPhVWM6sBHbIEQ4opHkgvcu7WeKm90P
         pnqsFZNa543TgvkSqaRm3bJjj16uGEWp5mqyBxNcS0Hl00P8UByWxcgDCjcUujtkmgTm
         RO+sunov0ktHsm0KrxOX3MXnjB/8dRDG3qw+jp+wcKbgWFy6hoyuNycbDRyfiAlKkndx
         mndQ==
X-Gm-Message-State: AOAM530nTK1yZfF99LOfrkesUNsIEn22hgZFHsg9nGyAsYaOZE9f49NZ
        5wX2X5W/1zak/+cEHiLPOQA=
X-Google-Smtp-Source: ABdhPJzJFRREhdrn7/P540+Q0D/HNEepcxDqTSZDHrTGehYn6GQ0llSbkMgCa+JEnL9vLUzZ6jgKAA==
X-Received: by 2002:a63:3d4c:: with SMTP id k73mr1102578pga.44.1634761045580;
        Wed, 20 Oct 2021 13:17:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id on17sm7125612pjb.47.2021.10.20.13.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 13:17:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 20 Oct 2021 10:17:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     bpf@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cgroup: Drop cgroup_ prefix from
 cgroup_threadgroup_rwsem and friends
Message-ID: <YXB5U4BndRqemhLn@slm.duckdns.org>
References: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXB5Mec4ahxXRx8K@slm.duckdns.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From e9bad0a8967987edae58ad498b7ba5ba91923e1e Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Tue, 19 Oct 2021 09:50:17 -1000

threadgroup stabilization is being generalized so that it can be used
outside cgroup. Let's drop the cgroup_ prefix in preparation. No functional
changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/exec.c                       |  6 ++---
 include/linux/cgroup-defs.h     | 20 +++++++-------
 kernel/cgroup/cgroup-internal.h |  4 +--
 kernel/cgroup/cgroup-v1.c       |  8 +++---
 kernel/cgroup/cgroup.c          | 48 ++++++++++++++++-----------------
 kernel/cgroup/pids.c            |  2 +-
 kernel/signal.c                 |  6 ++---
 7 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..caedd06a6d47 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1080,7 +1080,7 @@ static int de_thread(struct task_struct *tsk)
 		struct task_struct *leader = tsk->group_leader;
 
 		for (;;) {
-			cgroup_threadgroup_change_begin(tsk);
+			threadgroup_change_begin(tsk);
 			write_lock_irq(&tasklist_lock);
 			/*
 			 * Do this under tasklist_lock to ensure that
@@ -1091,7 +1091,7 @@ static int de_thread(struct task_struct *tsk)
 				break;
 			__set_current_state(TASK_KILLABLE);
 			write_unlock_irq(&tasklist_lock);
-			cgroup_threadgroup_change_end(tsk);
+			threadgroup_change_end(tsk);
 			schedule();
 			if (__fatal_signal_pending(tsk))
 				goto killed;
@@ -1146,7 +1146,7 @@ static int de_thread(struct task_struct *tsk)
 		if (unlikely(leader->ptrace))
 			__wake_up_parent(leader, leader->parent);
 		write_unlock_irq(&tasklist_lock);
-		cgroup_threadgroup_change_end(tsk);
+		threadgroup_change_end(tsk);
 
 		release_task(leader);
 	}
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index db2e147e069f..1a77731e3309 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -708,41 +708,41 @@ struct cgroup_subsys {
 	unsigned int depends_on;
 };
 
-extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
+extern struct percpu_rw_semaphore threadgroup_rwsem;
 
 /**
- * cgroup_threadgroup_change_begin - threadgroup exclusion for cgroups
+ * threadgroup_change_begin - threadgroup exclusion for cgroups
  * @tsk: target task
  *
  * Allows cgroup operations to synchronize against threadgroup changes
  * using a percpu_rw_semaphore.
  */
-static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
+static inline void threadgroup_change_begin(struct task_struct *tsk)
 {
-	percpu_down_read(&cgroup_threadgroup_rwsem);
+	percpu_down_read(&threadgroup_rwsem);
 }
 
 /**
- * cgroup_threadgroup_change_end - threadgroup exclusion for cgroups
+ * threadgroup_change_end - threadgroup exclusion for cgroups
  * @tsk: target task
  *
- * Counterpart of cgroup_threadcgroup_change_begin().
+ * Counterpart of threadgroup_change_begin().
  */
-static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
+static inline void threadgroup_change_end(struct task_struct *tsk)
 {
-	percpu_up_read(&cgroup_threadgroup_rwsem);
+	percpu_up_read(&threadgroup_rwsem);
 }
 
 #else	/* CONFIG_CGROUPS */
 
 #define CGROUP_SUBSYS_COUNT 0
 
-static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
+static inline void threadgroup_change_begin(struct task_struct *tsk)
 {
 	might_sleep();
 }
 
-static inline void cgroup_threadgroup_change_end(struct task_struct *tsk) {}
+static inline void threadgroup_change_end(struct task_struct *tsk) {}
 
 #endif	/* CONFIG_CGROUPS */
 
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index bfbeabc17a9d..9f76fc5aec8d 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -233,9 +233,9 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup);
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 					     bool *locked)
-	__acquires(&cgroup_threadgroup_rwsem);
+	__acquires(&threadgroup_rwsem);
 void cgroup_procs_write_finish(struct task_struct *task, bool locked)
-	__releases(&cgroup_threadgroup_rwsem);
+	__releases(&threadgroup_rwsem);
 
 void cgroup_lock_and_drain_offline(struct cgroup *cgrp);
 
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 35b920328344..03808e7deb2e 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -59,7 +59,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	int retval = 0;
 
 	mutex_lock(&cgroup_mutex);
-	percpu_down_write(&cgroup_threadgroup_rwsem);
+	percpu_down_write(&threadgroup_rwsem);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
@@ -74,7 +74,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 		if (retval)
 			break;
 	}
-	percpu_up_write(&cgroup_threadgroup_rwsem);
+	percpu_up_write(&threadgroup_rwsem);
 	mutex_unlock(&cgroup_mutex);
 
 	return retval;
@@ -111,7 +111,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 	mutex_lock(&cgroup_mutex);
 
-	percpu_down_write(&cgroup_threadgroup_rwsem);
+	percpu_down_write(&threadgroup_rwsem);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -147,7 +147,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	percpu_up_write(&cgroup_threadgroup_rwsem);
+	percpu_up_write(&threadgroup_rwsem);
 	mutex_unlock(&cgroup_mutex);
 	return ret;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 570b0c97392a..2fd01c901b1a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -109,7 +109,7 @@ static DEFINE_SPINLOCK(cgroup_idr_lock);
  */
 static DEFINE_SPINLOCK(cgroup_file_kn_lock);
 
-DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
+DEFINE_PERCPU_RWSEM(threadgroup_rwsem);
 
 #define cgroup_assert_mutex_or_rcu_locked()				\
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held() &&			\
@@ -918,9 +918,9 @@ static void css_set_move_task(struct task_struct *task,
 
 	if (to_cset) {
 		/*
-		 * We are synchronized through cgroup_threadgroup_rwsem
-		 * against PF_EXITING setting such that we can't race
-		 * against cgroup_exit()/cgroup_free() dropping the css_set.
+		 * We are synchronized through threadgroup_rwsem against
+		 * PF_EXITING setting such that we can't race against
+		 * cgroup_exit()/cgroup_free() dropping the css_set.
 		 */
 		WARN_ON_ONCE(task->flags & PF_EXITING);
 
@@ -2338,7 +2338,7 @@ static void cgroup_migrate_add_task(struct task_struct *task,
 	if (task->flags & PF_EXITING)
 		return;
 
-	/* cgroup_threadgroup_rwsem protects racing against forks */
+	/* threadgroup_rwsem protects racing against forks */
 	WARN_ON_ONCE(list_empty(&task->cg_list));
 
 	cset = task_css_set(task);
@@ -2602,7 +2602,7 @@ void cgroup_migrate_finish(struct cgroup_mgctx *mgctx)
  * @src_cset and add it to @mgctx->src_csets, which should later be cleaned
  * up by cgroup_migrate_finish().
  *
- * This function may be called without holding cgroup_threadgroup_rwsem
+ * This function may be called without holding threadgroup_rwsem
  * even if the target is a process.  Threads may be created and destroyed
  * but as long as cgroup_mutex is not dropped, no new css_set can be put
  * into play and the preloaded css_sets are guaranteed to cover all
@@ -2711,7 +2711,7 @@ int cgroup_migrate_prepare_dst(struct cgroup_mgctx *mgctx)
  * @mgctx: migration context
  *
  * Migrate a process or task denoted by @leader.  If migrating a process,
- * the caller must be holding cgroup_threadgroup_rwsem.  The caller is also
+ * the caller must be holding threadgroup_rwsem.  The caller is also
  * responsible for invoking cgroup_migrate_add_src() and
  * cgroup_migrate_prepare_dst() on the targets before invoking this
  * function and following up with cgroup_migrate_finish().
@@ -2752,7 +2752,7 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
  * @leader: the task or the leader of the threadgroup to be attached
  * @threadgroup: attach the whole threadgroup?
  *
- * Call holding cgroup_mutex and cgroup_threadgroup_rwsem.
+ * Call holding cgroup_mutex and threadgroup_rwsem.
  */
 int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup)
@@ -2788,7 +2788,7 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 					     bool *locked)
-	__acquires(&cgroup_threadgroup_rwsem)
+	__acquires(&threadgroup_rwsem)
 {
 	struct task_struct *tsk;
 	pid_t pid;
@@ -2806,7 +2806,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	 */
 	lockdep_assert_held(&cgroup_mutex);
 	if (pid || threadgroup) {
-		percpu_down_write(&cgroup_threadgroup_rwsem);
+		percpu_down_write(&threadgroup_rwsem);
 		*locked = true;
 	} else {
 		*locked = false;
@@ -2842,7 +2842,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 
 out_unlock_threadgroup:
 	if (*locked) {
-		percpu_up_write(&cgroup_threadgroup_rwsem);
+		percpu_up_write(&threadgroup_rwsem);
 		*locked = false;
 	}
 out_unlock_rcu:
@@ -2851,7 +2851,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 }
 
 void cgroup_procs_write_finish(struct task_struct *task, bool locked)
-	__releases(&cgroup_threadgroup_rwsem)
+	__releases(&threadgroup_rwsem)
 {
 	struct cgroup_subsys *ss;
 	int ssid;
@@ -2860,7 +2860,7 @@ void cgroup_procs_write_finish(struct task_struct *task, bool locked)
 	put_task_struct(task);
 
 	if (locked)
-		percpu_up_write(&cgroup_threadgroup_rwsem);
+		percpu_up_write(&threadgroup_rwsem);
 	for_each_subsys(ss, ssid)
 		if (ss->post_attach)
 			ss->post_attach();
@@ -2919,7 +2919,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 
 	lockdep_assert_held(&cgroup_mutex);
 
-	percpu_down_write(&cgroup_threadgroup_rwsem);
+	percpu_down_write(&threadgroup_rwsem);
 
 	/* look up all csses currently attached to @cgrp's subtree */
 	spin_lock_irq(&css_set_lock);
@@ -2949,7 +2949,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
 	cgroup_migrate_finish(&mgctx);
-	percpu_up_write(&cgroup_threadgroup_rwsem);
+	percpu_up_write(&threadgroup_rwsem);
 	return ret;
 }
 
@@ -5784,7 +5784,7 @@ int __init cgroup_init(void)
 	 * The latency of the synchronize_rcu() is too high for cgroups,
 	 * avoid it at the cost of forcing all readers into the slow path.
 	 */
-	rcu_sync_enter_start(&cgroup_threadgroup_rwsem.rss);
+	rcu_sync_enter_start(&threadgroup_rwsem.rss);
 
 	get_user_ns(init_cgroup_ns.user_ns);
 
@@ -6044,13 +6044,13 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
  * If CLONE_INTO_CGROUP is specified this function will try to find an
  * existing css_set which includes the requested cgroup and if not create
  * a new css_set that the child will be attached to later. If this function
- * succeeds it will hold cgroup_threadgroup_rwsem on return. If
+ * succeeds it will hold threadgroup_rwsem on return. If
  * CLONE_INTO_CGROUP is requested this function will grab cgroup mutex
- * before grabbing cgroup_threadgroup_rwsem and will hold a reference
+ * before grabbing threadgroup_rwsem and will hold a reference
  * to the target cgroup.
  */
 static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
-	__acquires(&cgroup_mutex) __acquires(&cgroup_threadgroup_rwsem)
+	__acquires(&cgroup_mutex) __acquires(&threadgroup_rwsem)
 {
 	int ret;
 	struct cgroup *dst_cgrp = NULL;
@@ -6061,7 +6061,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	if (kargs->flags & CLONE_INTO_CGROUP)
 		mutex_lock(&cgroup_mutex);
 
-	cgroup_threadgroup_change_begin(current);
+	threadgroup_change_begin(current);
 
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
@@ -6118,7 +6118,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	return ret;
 
 err:
-	cgroup_threadgroup_change_end(current);
+	threadgroup_change_end(current);
 	mutex_unlock(&cgroup_mutex);
 	if (f)
 		fput(f);
@@ -6138,9 +6138,9 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
  * CLONE_INTO_CGROUP was requested.
  */
 static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
-	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
+	__releases(&threadgroup_rwsem) __releases(&cgroup_mutex)
 {
-	cgroup_threadgroup_change_end(current);
+	threadgroup_change_end(current);
 
 	if (kargs->flags & CLONE_INTO_CGROUP) {
 		struct cgroup *cgrp = kargs->cgrp;
@@ -6231,7 +6231,7 @@ void cgroup_cancel_fork(struct task_struct *child,
  */
 void cgroup_post_fork(struct task_struct *child,
 		      struct kernel_clone_args *kargs)
-	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
+	__releases(&threadgroup_rwsem) __releases(&cgroup_mutex)
 {
 	unsigned long cgrp_flags = 0;
 	bool kill = false;
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 511af87f685e..368bc3ea4dbb 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -213,7 +213,7 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
 
 /*
  * task_css_check(true) in pids_can_fork() and pids_cancel_fork() relies
- * on cgroup_threadgroup_change_begin() held by the copy_process().
+ * on threadgroup_change_begin() held by the copy_process().
  */
 static int pids_can_fork(struct task_struct *task, struct css_set *cset)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f6d0f9..f01b249369ce 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2956,11 +2956,11 @@ void exit_signals(struct task_struct *tsk)
 	 * @tsk is about to have PF_EXITING set - lock out users which
 	 * expect stable threadgroup.
 	 */
-	cgroup_threadgroup_change_begin(tsk);
+	threadgroup_change_begin(tsk);
 
 	if (thread_group_empty(tsk) || signal_group_exit(tsk->signal)) {
 		tsk->flags |= PF_EXITING;
-		cgroup_threadgroup_change_end(tsk);
+		threadgroup_change_end(tsk);
 		return;
 	}
 
@@ -2971,7 +2971,7 @@ void exit_signals(struct task_struct *tsk)
 	 */
 	tsk->flags |= PF_EXITING;
 
-	cgroup_threadgroup_change_end(tsk);
+	threadgroup_change_end(tsk);
 
 	if (!task_sigpending(tsk))
 		goto out;
-- 
2.33.1

