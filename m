Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1F26BF43D
	for <lists+bpf@lfdr.de>; Fri, 17 Mar 2023 22:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCQVfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Mar 2023 17:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjCQVfv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Mar 2023 17:35:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546454DBDE;
        Fri, 17 Mar 2023 14:35:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id i5so6690214pla.2;
        Fri, 17 Mar 2023 14:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UdU5h92XMmuwS06YSRGGn+N+QBjdB8GT5V/VP2XGkLs=;
        b=UWthX6UAZSUAsa36RUITbDqHz/qm8WevYIuvzRuncCV4UysQcATnylHOGwUMu9wmiB
         wd7Aa7S9PM5D2NodoO9Nm3DTNR1i7fY5YI4nOmQRN4U7owqd0qqqp38k6hDh+ODAC/Jl
         n5x8WD5eDgJtuZJs0EbAQXUpkjfHwJkVthYDlgSkpt7jCxodE8bX3EaNIucOnkMx+dM1
         vZqspNl9qVDRLpaBZ6KdlOry2AdKmw67It92qnhSmmm3YXvcls712s9+fE1U2tdotJ2u
         iUOsBfIU91jMExuhiR1SKZ4sR+vCv+zgUTx2U7XQiMw6c5e92scBs2G5+jJeru0/4bH4
         4+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UdU5h92XMmuwS06YSRGGn+N+QBjdB8GT5V/VP2XGkLs=;
        b=3YqXWDrqQZ30SVyUXNrPEz9z8CFXLhNvOH+N+zc1yn+IMK596JMaRLNOecDpYIoabj
         0VCWXRmMDjl/ayiUK9lkM97nustJURD3GOiA02K6K2silH/rKB2YkrDLQbwSZHTQyfR+
         mKgF5W+Ejs3H7k85JS+fLx91o/jjHAz+sX4S1Q3OH6KaQXUkj3/QmNkjGH6PSKD9X+kl
         SKxFgXU82vb/IqrIX9Vs6dW0lauJ83XD1wZwdT8JuA/Sl+hxKHVELXY+tk3Cur1FJMCv
         uPIZVQ5V4UXKKe06E1WtNvQY/J83PoKOkXZkQqnxKG/rZx2MU+XxRESRpPAWmSZFAPWG
         BYCw==
X-Gm-Message-State: AO0yUKWZm6LcV/uaFVhv8AuQR/kPg+bWXElnp207mh1FyL9fEOThPqLh
        bfqLTPgeZuncVrqsdIJZZjI=
X-Google-Smtp-Source: AK7set97xwiyOVZ2rYv7tGUR05dXGfSOIev1fZtwalUwxnvC2eH7ghyMx3oJl2VAXPnNZlpqJg/RKg==
X-Received: by 2002:a17:903:247:b0:19e:6516:127a with SMTP id j7-20020a170903024700b0019e6516127amr8879377plh.39.1679088826913;
        Fri, 17 Mar 2023 14:33:46 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709028ec500b001a04d37a4acsm1998879plo.9.2023.03.17.14.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:33:46 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 02/32] sched: Encapsulate task attribute change sequence into a helper macro
Date:   Fri, 17 Mar 2023 11:33:03 -1000
Message-Id: <20230317213333.2174969-3-tj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230317213333.2174969-1-tj@kernel.org>
References: <20230317213333.2174969-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A task needs to be dequeued and put before an attribute change and then
restored afterwards. This is currently open-coded in multiple places. This
patch encapsulates the preparation and restoration sequences into
SCHED_CHANGE_BLOCK which allows the actual attribute changes to be put
inside its nested block. While the conversions are generally
straightforward, there are some subtleties:

* If a variable is specified for the flags argument, it can be modified from
  inside the block body to allow using a different flags value for
  re-enqueueing. This is used by rt_mutex_setprio() and
  __sched_setscheduler().

* __sched_setscheduler() used to only set ENQUEUE_HEAD if the task is
  queued. After the conversion, it sets the flag whether the task is queued
  or not. This doesn't cause any behavioral differences and is simpler than
  accessing the internal state of the helper.

* In a similar vein, sched_move_task() tests task_current() again after the
  change block instead of carrying over the test result from inside the
  change block.

This patch is adopted from Peter Zijlstra's draft patch linked below. The
changes are:

* Call fini explicitly from for() instead of using the __cleanup__
  attribute.

* Allow the queue flag variable to be modified directly so that the user
  doesn't have to poke into sched_change_guard struct. Also, in the original
  patch, rt_mutex_setprio() was incorrectly updating its queue_flag instead
  of cg.flags.

* Some cosmetic changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Original-patch-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/all/20220330162228.GH14330@worktop.programming.kicks-ass.net/T/#u
Reviewed-by: David Vernet <dvernet@meta.com>
---
 kernel/sched/core.c | 260 ++++++++++++++++++++++----------------------
 1 file changed, 130 insertions(+), 130 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index af017e038b48..fb080ca54d80 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2096,6 +2096,76 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 	dequeue_task(rq, p, flags);
 }
 
+struct sched_change_guard {
+	struct task_struct	*p;
+	struct rq		*rq;
+	bool			queued;
+	bool			running;
+	bool			done;
+};
+
+static struct sched_change_guard
+sched_change_guard_init(struct rq *rq, struct task_struct *p, int flags)
+{
+	struct sched_change_guard cg = {
+		.rq = rq,
+		.p = p,
+		.queued = task_on_rq_queued(p),
+		.running = task_current(rq, p),
+	};
+
+	if (cg.queued) {
+		/*
+		 * __kthread_bind() may call this on blocked tasks without
+		 * holding rq->lock through __do_set_cpus_allowed(). Assert @rq
+		 * locked iff @p is queued.
+		 */
+		lockdep_assert_rq_held(rq);
+		dequeue_task(rq, p, flags);
+	}
+	if (cg.running)
+		put_prev_task(rq, p);
+
+	return cg;
+}
+
+static void sched_change_guard_fini(struct sched_change_guard *cg, int flags)
+{
+	if (cg->queued)
+		enqueue_task(cg->rq, cg->p, flags | ENQUEUE_NOCLOCK);
+	if (cg->running)
+		set_next_task(cg->rq, cg->p);
+	cg->done = true;
+}
+
+/**
+ * SCHED_CHANGE_BLOCK - Nested block for task attribute updates
+ * @__rq: Runqueue the target task belongs to
+ * @__p: Target task
+ * @__flags: DEQUEUE/ENQUEUE_* flags
+ *
+ * A task may need to be dequeued and put_prev_task'd for attribute updates and
+ * set_next_task'd and re-enqueued afterwards. This helper defines a nested
+ * block which automatically handles these preparation and cleanup operations.
+ *
+ *  SCHED_CHANGE_BLOCK(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+ *	  update_attribute(p);
+ *        ...
+ *  }
+ *
+ * If @__flags is a variable, the variable may be updated in the block body and
+ * the updated value will be used when re-enqueueing @p.
+ *
+ * If %DEQUEUE_NOCLOCK is specified, the caller is responsible for calling
+ * update_rq_clock() beforehand. Otherwise, the rq clock is automatically
+ * updated iff the task needs to be dequeued and re-enqueued. Only the former
+ * case guarantees that the rq clock is up-to-date inside and after the block.
+ */
+#define SCHED_CHANGE_BLOCK(__rq, __p, __flags)					\
+	for (struct sched_change_guard __cg =					\
+			sched_change_guard_init(__rq, __p, __flags);		\
+	     !__cg.done; sched_change_guard_fini(&__cg, __flags))
+
 static inline int __normal_prio(int policy, int rt_prio, int nice)
 {
 	int prio;
@@ -2554,7 +2624,6 @@ static void
 __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
 	struct rq *rq = task_rq(p);
-	bool queued, running;
 
 	/*
 	 * This here violates the locking rules for affinity, since we're only
@@ -2573,26 +2642,9 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 	else
 		lockdep_assert_held(&p->pi_lock);
 
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-
-	if (queued) {
-		/*
-		 * Because __kthread_bind() calls this on blocked tasks without
-		 * holding rq->lock.
-		 */
-		lockdep_assert_rq_held(rq);
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
+	SCHED_CHANGE_BLOCK(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+		p->sched_class->set_cpus_allowed(p, ctx);
 	}
-	if (running)
-		put_prev_task(rq, p);
-
-	p->sched_class->set_cpus_allowed(p, ctx);
-
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
 }
 
 /*
@@ -6989,7 +7041,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
  */
 void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
-	int prio, oldprio, queued, running, queue_flag =
+	int prio, oldprio, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	const struct sched_class *prev_class;
 	struct rq_flags rf;
@@ -7049,49 +7101,39 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		queue_flag &= ~DEQUEUE_MOVE;
 
 	prev_class = p->sched_class;
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flag);
-	if (running)
-		put_prev_task(rq, p);
-
-	/*
-	 * Boosting condition are:
-	 * 1. -rt task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A
-	 *
-	 * 2. -dl task is running and holds mutex A
-	 *      --> -dl task blocks on mutex A and could preempt the
-	 *          running task
-	 */
-	if (dl_prio(prio)) {
-		if (!dl_prio(p->normal_prio) ||
-		    (pi_task && dl_prio(pi_task->prio) &&
-		     dl_entity_preempt(&pi_task->dl, &p->dl))) {
-			p->dl.pi_se = pi_task->dl.pi_se;
-			queue_flag |= ENQUEUE_REPLENISH;
+	SCHED_CHANGE_BLOCK(rq, p, queue_flag) {
+		/*
+		 * Boosting condition are:
+		 * 1. -rt task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A
+		 *
+		 * 2. -dl task is running and holds mutex A
+		 *      --> -dl task blocks on mutex A and could preempt the
+		 *          running task
+		 */
+		if (dl_prio(prio)) {
+			if (!dl_prio(p->normal_prio) ||
+			    (pi_task && dl_prio(pi_task->prio) &&
+			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
+				p->dl.pi_se = pi_task->dl.pi_se;
+				queue_flag |= ENQUEUE_REPLENISH;
+			} else {
+				p->dl.pi_se = &p->dl;
+			}
+		} else if (rt_prio(prio)) {
+			if (dl_prio(oldprio))
+				p->dl.pi_se = &p->dl;
+			if (oldprio < prio)
+				queue_flag |= ENQUEUE_HEAD;
 		} else {
-			p->dl.pi_se = &p->dl;
+			if (dl_prio(oldprio))
+				p->dl.pi_se = &p->dl;
+			if (rt_prio(oldprio))
+				p->rt.timeout = 0;
 		}
-	} else if (rt_prio(prio)) {
-		if (dl_prio(oldprio))
-			p->dl.pi_se = &p->dl;
-		if (oldprio < prio)
-			queue_flag |= ENQUEUE_HEAD;
-	} else {
-		if (dl_prio(oldprio))
-			p->dl.pi_se = &p->dl;
-		if (rt_prio(oldprio))
-			p->rt.timeout = 0;
-	}
-
-	__setscheduler_prio(p, prio);
 
-	if (queued)
-		enqueue_task(rq, p, queue_flag);
-	if (running)
-		set_next_task(rq, p);
+		__setscheduler_prio(p, prio);
+	}
 
 	check_class_changed(rq, p, prev_class, oldprio);
 out_unlock:
@@ -7113,7 +7155,6 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 
 void set_user_nice(struct task_struct *p, long nice)
 {
-	bool queued, running;
 	int old_prio;
 	struct rq_flags rf;
 	struct rq *rq;
@@ -7137,22 +7178,13 @@ void set_user_nice(struct task_struct *p, long nice)
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
 	}
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->static_prio = NICE_TO_PRIO(nice);
-	set_load_weight(p, true);
-	old_prio = p->prio;
-	p->prio = effective_prio(p);
 
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+	SCHED_CHANGE_BLOCK(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+		p->static_prio = NICE_TO_PRIO(nice);
+		set_load_weight(p, true);
+		old_prio = p->prio;
+		p->prio = effective_prio(p);
+	}
 
 	/*
 	 * If the task increased its priority or is running and
@@ -7536,7 +7568,7 @@ static int __sched_setscheduler(struct task_struct *p,
 				bool user, bool pi)
 {
 	int oldpolicy = -1, policy = attr->sched_policy;
-	int retval, oldprio, newprio, queued, running;
+	int retval, oldprio, newprio;
 	const struct sched_class *prev_class;
 	struct balance_callback *head;
 	struct rq_flags rf;
@@ -7701,33 +7733,22 @@ static int __sched_setscheduler(struct task_struct *p,
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, queue_flags);
-	if (running)
-		put_prev_task(rq, p);
-
-	prev_class = p->sched_class;
+	SCHED_CHANGE_BLOCK(rq, p, queue_flags) {
+		prev_class = p->sched_class;
 
-	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
-		__setscheduler_params(p, attr);
-		__setscheduler_prio(p, newprio);
-	}
-	__setscheduler_uclamp(p, attr);
+		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
+			__setscheduler_params(p, attr);
+			__setscheduler_prio(p, newprio);
+		}
+		__setscheduler_uclamp(p, attr);
 
-	if (queued) {
 		/*
 		 * We enqueue to tail when the priority of a task is
 		 * increased (user space view).
 		 */
 		if (oldprio < p->prio)
 			queue_flags |= ENQUEUE_HEAD;
-
-		enqueue_task(rq, p, queue_flags);
 	}
-	if (running)
-		set_next_task(rq, p);
 
 	check_class_changed(rq, p, prev_class, oldprio);
 
@@ -9250,25 +9271,15 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
  */
 void sched_setnuma(struct task_struct *p, int nid)
 {
-	bool queued, running;
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(p, &rf);
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
 
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE);
-	if (running)
-		put_prev_task(rq, p);
-
-	p->numa_preferred_nid = nid;
+	SCHED_CHANGE_BLOCK(rq, p, DEQUEUE_SAVE) {
+		p->numa_preferred_nid = nid;
+	}
 
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
 	task_rq_unlock(rq, p, &rf);
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -10360,35 +10371,24 @@ static void sched_change_group(struct task_struct *tsk)
  */
 void sched_move_task(struct task_struct *tsk)
 {
-	int queued, running, queue_flags =
-		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct rq_flags rf;
 	struct rq *rq;
 
 	rq = task_rq_lock(tsk, &rf);
 	update_rq_clock(rq);
 
-	running = task_current(rq, tsk);
-	queued = task_on_rq_queued(tsk);
-
-	if (queued)
-		dequeue_task(rq, tsk, queue_flags);
-	if (running)
-		put_prev_task(rq, tsk);
-
-	sched_change_group(tsk);
+	SCHED_CHANGE_BLOCK(rq, tsk,
+			   DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
+		sched_change_group(tsk);
+	}
 
-	if (queued)
-		enqueue_task(rq, tsk, queue_flags);
-	if (running) {
-		set_next_task(rq, tsk);
-		/*
-		 * After changing group, the running task may have joined a
-		 * throttled one but it's still the running task. Trigger a
-		 * resched to make sure that task can still run.
-		 */
+	/*
+	 * After changing group, the running task may have joined a throttled
+	 * one but it's still the running task. Trigger a resched to make sure
+	 * that task can still run.
+	 */
+	if (task_current(rq, tsk))
 		resched_curr(rq);
-	}
 
 	task_rq_unlock(rq, tsk, &rf);
 }
-- 
2.39.2

