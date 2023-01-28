Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD60567F2DA
	for <lists+bpf@lfdr.de>; Sat, 28 Jan 2023 01:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjA1ARA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 19:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjA1AQ6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 19:16:58 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0686B7B7AB;
        Fri, 27 Jan 2023 16:16:57 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id jl3so6559138plb.8;
        Fri, 27 Jan 2023 16:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HZHa2gfgb8Zdv7r+/ewKzMZze1+sOuN4ROxBuKn10I=;
        b=oRm5jPJmF1orSuU6GpR3idM02s3W6ElgPvwDSf2lltreMkjLb/3Sgr50VP7R/jdPRN
         PvN3JBXyxwmGjKaxW/CeVDP3nUcreH6E8YoF4IB3J4G5CcAnIYQE0E3G0vRAwcc3wDFP
         9YAQwYy44mVrtJUwrVoeEWkjDqSgr6gE/dFAUhd6ZrstS9AjdpMq0eNxXbORByeOupBV
         GC1BxvTR0+SJN81Bfdej575HL+ogpDqYdq4b614q0+JxQLOgoGdlLqRs1yGv4CnOAzLN
         gbZ+SA4W2OIW0IWXedtw0nqcsfc11ViQO5x+2VDVQO6zOUvBRDvTXa/2lJg7ly7DylqF
         LFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5HZHa2gfgb8Zdv7r+/ewKzMZze1+sOuN4ROxBuKn10I=;
        b=QItGYIASmyYqW0vgpwmHXgzFN5EMyqjJ2BdZRjEQVrWRUlA757Y7/hscanqwfk7QyJ
         AyYpgUYuSPrbEhrsbXmgM8d4DcDRR9JJK1BtaLuuRxcI7xDcZ8LxK8Lp6zKYin6cnpoX
         1iGFqAMfeKe1JB3rM7FHaqsbCcTVZZH4kAOFW467C0A0WY01sgfZmLuxylch7UAoktg0
         RTA2+LSO/n/bFusUWDAnaWpYGg2m2fXOP6+vnfa0SjCeFc1gS67gWBEIWYnTIpfVcPTV
         KzEqxDy4x6lTY6WJNziDBxlKQag5d3o18g2RnfwvcEM3xcxNZ7ghmE7wWLrCfvq3WaVM
         +GxQ==
X-Gm-Message-State: AFqh2kqb0epwLLvXUJV/njleIl0JmZHOZuc9LzwSpw5ty4IlJ9GM5cM/
        aEgyFSp/LU7H8jFxwLQjVis=
X-Google-Smtp-Source: AMrXdXuyiQZEq7CqpXBJcagQRn6iM9Ne999pZx2vj4xpBgm0SxZ8p9N4d6qwVOG5yeUPbl0KSD9PPg==
X-Received: by 2002:a17:90b:4a0c:b0:22a:3c8:9d1 with SMTP id kk12-20020a17090b4a0c00b0022a03c809d1mr31829210pjb.32.1674865016153;
        Fri, 27 Jan 2023 16:16:56 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id gn17-20020a17090ac79100b0022bfc79c71bsm3247317pjb.50.2023.01.27.16.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:16:55 -0800 (PST)
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
Subject: [PATCH 02/30] sched: Encapsulate task attribute change sequence into a helper macro
Date:   Fri, 27 Jan 2023 14:16:11 -1000
Message-Id: <20230128001639.3510083-3-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
index 25b582b6ee5f..bfc3312f305a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2094,6 +2094,76 @@ void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
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
@@ -2552,7 +2622,6 @@ static void
 __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
 	struct rq *rq = task_rq(p);
-	bool queued, running;
 
 	/*
 	 * This here violates the locking rules for affinity, since we're only
@@ -2571,26 +2640,9 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
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
@@ -6922,7 +6974,7 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
  */
 void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
-	int prio, oldprio, queued, running, queue_flag =
+	int prio, oldprio, queue_flag =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	const struct sched_class *prev_class;
 	struct rq_flags rf;
@@ -6982,49 +7034,39 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
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
@@ -7046,7 +7088,6 @@ static inline int rt_effective_prio(struct task_struct *p, int prio)
 
 void set_user_nice(struct task_struct *p, long nice)
 {
-	bool queued, running;
 	int old_prio;
 	struct rq_flags rf;
 	struct rq *rq;
@@ -7070,22 +7111,13 @@ void set_user_nice(struct task_struct *p, long nice)
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
@@ -7469,7 +7501,7 @@ static int __sched_setscheduler(struct task_struct *p,
 				bool user, bool pi)
 {
 	int oldpolicy = -1, policy = attr->sched_policy;
-	int retval, oldprio, newprio, queued, running;
+	int retval, oldprio, newprio;
 	const struct sched_class *prev_class;
 	struct balance_callback *head;
 	struct rq_flags rf;
@@ -7634,33 +7666,22 @@ static int __sched_setscheduler(struct task_struct *p,
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
 
@@ -9177,25 +9198,15 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
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
@@ -10287,35 +10298,24 @@ static void sched_change_group(struct task_struct *tsk)
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
2.39.1

