Return-Path: <bpf+bounces-4686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B18274E352
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 03:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A11C20D3B
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 01:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C233D6E;
	Tue, 11 Jul 2023 01:16:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA53C3E
	for <bpf@vger.kernel.org>; Tue, 11 Jul 2023 01:16:01 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B9A171C;
	Mon, 10 Jul 2023 18:15:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b9e93a538dso5654915ad.3;
        Mon, 10 Jul 2023 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038102; x=1691630102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIDTHYeGPSrPSftuFR9PfhtkvgZjbT9VEcfOVL5nUs4=;
        b=E6I1DwSE46IyvV+6i0fET3HZ9Muwtf/62Skjls1gg7zI+M50O7aP5MdsZHVNsOevJo
         SI+O82g3w9qhb1nJ0DBOImb0DuqTQquOZndmq9MLZ/UZP72BLnvORpWdi30PKi3gvBf8
         t1lSr4OI54EcHxehwXCxyIvTtysB0RpZJBFWE5RIT7Tf6rp8S9swopqNi6510fXpKmFP
         0IxrUdEYWXoRMGX+OmYWi49MCYwINrHjUE3+htvuqFgyh9nte64QobMawDGAhGrIrfm0
         zaS8Ae9mnLNxoor3fgJJqwhoegVmhBsHuLdx86FszvPK+oZrm0BVN8u8NcPnMvp9++G1
         aVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038102; x=1691630102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uIDTHYeGPSrPSftuFR9PfhtkvgZjbT9VEcfOVL5nUs4=;
        b=GWBpye8dWRPq0+mv8Embim2+n9Wq1u10kX9oiGEPQfoD8dzCC/Qeu3I3fJzPRBZvFo
         QzboxYB8loNHxvDAXBDGAdF4/EbALNbe7G+UJ2+Ua0RMI2V31Ant4/ZwaITo2nYZNpS4
         16UV/SpuERsYSYc4H0cEXqSuM5xmTWJKg71XjGw5uIdQ+dAgGpkoeIMF1tuUbauy+ZOW
         iyHkpf1lcMipamtcmzFMqKDo7HoV8DhmzNbf8ns97jwpGNyy2jjowVTC+8svxaoLTnot
         8LrrRTNXB+Ramk8sEG82mySVGLnTN2obeEK8xFXYJ9xyTAV7Pgru6TSDDoADhlk1M201
         NwDg==
X-Gm-Message-State: ABy/qLajLUr/2sFlPTAM/8rnsn6Ja2hrlnPtIoBgzQknFGoOlw23zkvd
	ygI/qU4zjZLoUSNKhPBf4hs=
X-Google-Smtp-Source: APBJJlHA/yWPjDCvc9+4Zwga36zAqHNzSa0adspB2E+373R7fr1aAQN7rRHC1pnLcDcz9fLJO92fcw==
X-Received: by 2002:a17:902:f54a:b0:1af:d225:9002 with SMTP id h10-20020a170902f54a00b001afd2259002mr12217587plf.14.1689038102255;
        Mon, 10 Jul 2023 18:15:02 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id jw5-20020a170903278500b001b8b07bc600sm500954plb.186.2023.07.10.18.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:15:01 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	joshdon@google.com,
	brho@google.com,
	pjt@google.com,
	derkling@google.com,
	haoluo@google.com,
	dvernet@meta.com,
	dschatzberg@meta.com,
	dskarlat@cs.cmu.edu,
	riel@surriel.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 23/34] sched_ext: Track tasks that are subjects of the in-flight SCX operation
Date: Mon, 10 Jul 2023 15:13:41 -1000
Message-ID: <20230711011412.100319-24-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When some SCX operations are in flight, it is known that the subject task's
rq lock is held throughout which makes it safe to access certain fields of
the task - e.g. its current task_group. We want to add SCX kfunc helpers
that can make use of this guarantee - e.g. to help determining the currently
associated CPU cgroup from the task's current task_group.

As it'd be dangerous call such a helper on a task which isn't rq lock
protected, the helper should be able to verify the input task and reject
accordingly. This patch adds sched_ext_entity.kf_tasks[] that track the
tasks which are currently being operated on by a terminal SCX operation. The
new SCX_CALL_OP_[2]TASK[_RET]() can be used when invoking SCX operations
which take tasks as arguments and the scx_kf_allowed_on_arg_tasks() can be
used by kfunc helpers to verify the input task status.

Note that as sched_ext_entity.kf_tasks[] can't handle nesting, the tracking
is currently only limited to terminal SCX operations. If needed in the
future, this restriction can be removed by moving the tracking to the task
side with a couple per-task counters.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
---
 include/linux/sched/ext.h |  2 +
 kernel/sched/ext.c        | 91 +++++++++++++++++++++++++++++++--------
 2 files changed, 76 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 676259b09ac4..d2146cbbd9c2 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -448,6 +448,7 @@ enum scx_kf_mask {
 	SCX_KF_REST		= 1 << 5, /* other rq-locked operations */
 
 	__SCX_KF_RQ_LOCKED	= SCX_KF_DISPATCH | SCX_KF_ENQUEUE | SCX_KF_REST,
+	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_REST,
 };
 
 /*
@@ -463,6 +464,7 @@ struct sched_ext_entity {
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	u32			kf_mask;	/* see scx_kf_mask above */
+	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic64_t		ops_state;
 	unsigned long		runnable_at;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7632bb7a016d..490df7a43b70 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -238,6 +238,47 @@ do {										\
 	__ret;									\
 })
 
+/*
+ * Some kfuncs are allowed only on the tasks that are subjects of the
+ * in-progress scx_ops operation for, e.g., locking guarantees. To enforce such
+ * restrictions, the following SCX_CALL_OP_*() variants should be used when
+ * invoking scx_ops operations that take task arguments. These can only be used
+ * for non-nesting operations due to the way the tasks are tracked.
+ *
+ * kfuncs which can only operate on such tasks can in turn use
+ * scx_kf_allowed_on_arg_tasks() to test whether the invocation is allowed on
+ * the specific task.
+ */
+#define SCX_CALL_OP_TASK(mask, op, task, args...)				\
+do {										\
+	BUILD_BUG_ON(mask & ~__SCX_KF_TERMINAL);				\
+	current->scx.kf_tasks[0] = task;					\
+	SCX_CALL_OP(mask, op, task, ##args);					\
+	current->scx.kf_tasks[0] = NULL;					\
+} while (0)
+
+#define SCX_CALL_OP_TASK_RET(mask, op, task, args...)				\
+({										\
+	__typeof__(scx_ops.op(task, ##args)) __ret;				\
+	BUILD_BUG_ON(mask & ~__SCX_KF_TERMINAL);				\
+	current->scx.kf_tasks[0] = task;					\
+	__ret = SCX_CALL_OP_RET(mask, op, task, ##args);			\
+	current->scx.kf_tasks[0] = NULL;					\
+	__ret;									\
+})
+
+#define SCX_CALL_OP_2TASKS_RET(mask, op, task0, task1, args...)			\
+({										\
+	__typeof__(scx_ops.op(task0, task1, ##args)) __ret;			\
+	BUILD_BUG_ON(mask & ~__SCX_KF_TERMINAL);				\
+	current->scx.kf_tasks[0] = task0;					\
+	current->scx.kf_tasks[1] = task1;					\
+	__ret = SCX_CALL_OP_RET(mask, op, task0, task1, ##args);		\
+	current->scx.kf_tasks[0] = NULL;					\
+	current->scx.kf_tasks[1] = NULL;					\
+	__ret;									\
+})
+
 /* @mask is constant, always inline to cull unnecessary branches */
 static __always_inline bool scx_kf_allowed(u32 mask)
 {
@@ -268,6 +309,22 @@ static __always_inline bool scx_kf_allowed(u32 mask)
 	return true;
 }
 
+/* see SCX_CALL_OP_TASK() */
+static __always_inline bool scx_kf_allowed_on_arg_tasks(u32 mask,
+							struct task_struct *p)
+{
+	if (!scx_kf_allowed(__SCX_KF_RQ_LOCKED))
+		return false;
+
+	if (unlikely((p != current->scx.kf_tasks[0] &&
+		      p != current->scx.kf_tasks[1]))) {
+		scx_ops_error("called on a task not being operated on");
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * scx_task_iter_init - Initialize a task iterator
  * @iter: iterator to init
@@ -705,7 +762,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
 
-	SCX_CALL_OP(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
+	SCX_CALL_OP_TASK(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
 
 	/*
 	 * If not directly dispatched, QUEUEING isn't clear yet and dispatch or
@@ -777,7 +834,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	add_nr_running(rq, 1);
 
 	if (SCX_HAS_OP(runnable))
-		SCX_CALL_OP(SCX_KF_REST, runnable, p, enq_flags);
+		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
 
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
@@ -802,7 +859,7 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 		BUG();
 	case SCX_OPSS_QUEUED:
 		if (SCX_HAS_OP(dequeue))
-			SCX_CALL_OP(SCX_KF_REST, dequeue, p, deq_flags);
+			SCX_CALL_OP_TASK(SCX_KF_REST, dequeue, p, deq_flags);
 
 		if (atomic64_try_cmpxchg(&p->scx.ops_state, &opss,
 					 SCX_OPSS_NONE))
@@ -853,11 +910,11 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	 */
 	if (SCX_HAS_OP(stopping) && task_current(rq, p)) {
 		update_curr_scx(rq);
-		SCX_CALL_OP(SCX_KF_REST, stopping, p, false);
+		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, false);
 	}
 
 	if (SCX_HAS_OP(quiescent))
-		SCX_CALL_OP(SCX_KF_REST, quiescent, p, deq_flags);
+		SCX_CALL_OP_TASK(SCX_KF_REST, quiescent, p, deq_flags);
 
 	if (deq_flags & SCX_DEQ_SLEEP)
 		p->scx.flags |= SCX_TASK_DEQD_FOR_SLEEP;
@@ -876,7 +933,7 @@ static void yield_task_scx(struct rq *rq)
 	struct task_struct *p = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		SCX_CALL_OP_RET(SCX_KF_REST, yield, p, NULL);
+		SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, p, NULL);
 	else
 		p->scx.slice = 0;
 }
@@ -886,7 +943,7 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 	struct task_struct *from = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		return SCX_CALL_OP_RET(SCX_KF_REST, yield, from, to);
+		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, from, to);
 	else
 		return false;
 }
@@ -1397,7 +1454,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP(SCX_KF_REST, running, p);
+		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
 
 	watchdog_unwatch_task(p, true);
 
@@ -1453,7 +1510,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP(SCX_KF_REST, stopping, p, true);
+		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
 
 	/*
 	 * If we're being called from put_prev_task_balance(), balance_scx() may
@@ -1644,8 +1701,8 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	if (SCX_HAS_OP(select_cpu)) {
 		s32 cpu;
 
-		cpu = SCX_CALL_OP_RET(SCX_KF_REST, select_cpu, p, prev_cpu,
-				      wake_flags);
+		cpu = SCX_CALL_OP_TASK_RET(SCX_KF_REST, select_cpu, p, prev_cpu,
+					   wake_flags);
 		if (ops_cpu_valid(cpu)) {
 			return cpu;
 		} else {
@@ -1671,8 +1728,8 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP(SCX_KF_REST, set_cpumask, p,
-			    (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
+				 (struct cpumask *)p->cpus_ptr);
 }
 
 static void reset_idle_masks(void)
@@ -1834,7 +1891,7 @@ static void scx_ops_enable_task(struct task_struct *p)
 
 	if (SCX_HAS_OP(enable)) {
 		struct scx_enable_args args = { };
-		SCX_CALL_OP(SCX_KF_REST, enable, p, &args);
+		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p, &args);
 	}
 	p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
 	p->scx.flags |= SCX_TASK_OPS_ENABLED;
@@ -1879,7 +1936,7 @@ static void refresh_scx_weight(struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	set_task_scx_weight(p);
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
 }
 
 void scx_pre_fork(struct task_struct *p)
@@ -1977,8 +2034,8 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 * different scheduler class. Keep the BPF scheduler up-to-date.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP(SCX_KF_REST, set_cpumask, p,
-			    (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
+				 (struct cpumask *)p->cpus_ptr);
 }
 
 static void check_preempt_curr_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
-- 
2.41.0


