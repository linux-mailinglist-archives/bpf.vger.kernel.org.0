Return-Path: <bpf+bounces-14838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA6B7E8888
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0CEB20E98
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD52E15B8;
	Sat, 11 Nov 2023 02:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/9lT8Be"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709453B1
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:50:11 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D4524F;
	Fri, 10 Nov 2023 18:49:41 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ccbb7f79cdso22323335ad.3;
        Fri, 10 Nov 2023 18:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670981; x=1700275781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3N0V/NH1JPn4mB2Bd027ery+3zSq4CC5PK+AtTxLHIk=;
        b=k/9lT8BeHtpibZGfleLlU5NWGMXn8LFYWtoXm9iEBYCqN7JSpP4htvlwVxC5s4NOgP
         53Jd23U+ryZWAaWZ/2oekYgSOw41OCmejaF1Hb604TyCkxrzjVHwfV7ruishsa+2bvja
         aHVJg9UMqOjMeKs6fOYv+oP3CPDtmA89vd9EaXpKoOxfusILGf79Am1vWorBlLTby1QG
         FmOfJ/3Gz0IiJKpRVvUQcJUr5xwSjsLgXI2CjI/cEqK7AoCXvdYU+Q1rN7pgIfAgsI/x
         +1km1SC+OFgvMjab1d+rhB8r6P2lkVzp2TPOOYGv4EpmiKRroX4v6apsnHAXXPBeOJ98
         QNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670981; x=1700275781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3N0V/NH1JPn4mB2Bd027ery+3zSq4CC5PK+AtTxLHIk=;
        b=n3Kbh+BvBnxEgROb+PhCzO81hn/biv4hgBTe5yAdvK/srGmp3TVJkECXbfauxV5GpK
         6YLvO/VXGXh5nEZqaX3Y5dE8ThVUm2LGC1GcBenBsDVkPJgLqv2Mm6lKsw1wJM0gzWfO
         Zi4Zou8yC9qrXaORNhCt9dTTDEGlKPUFBKcyHHLQrQJt5nIuEdZ6LZs78nGE6+vqcJJt
         6b3a+5pkAbajCofU3OCXoo1mg0o+Pgtp5XWU9azcjEh/RqkOEnhn3RToQ1bsQuxUHGaq
         E8prI+TFtLbI0Nue0UFM+UwFOub+NcVkdaiiTIBnenbkZRwHQWaFM8QypkSxHWPtQQ9h
         03DQ==
X-Gm-Message-State: AOJu0YwceiCq2K2lzfDkvg/b2fRZ9ekQdmniFk5u1XCa6QtDdjY6O9Kb
	EXKotu6KdfHQFLKg91ZB1eY=
X-Google-Smtp-Source: AGHT+IE9AkC1Vorq2A3N6mzYlWQwWtzAJj63VJUJCDgA/dDLYVDa9cy3WNhbN2V/SVcmAfbpYCVs3Q==
X-Received: by 2002:a17:902:dacb:b0:1c5:befa:d81d with SMTP id q11-20020a170902dacb00b001c5befad81dmr1290019plx.10.1699670981180;
        Fri, 10 Nov 2023 18:49:41 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id bb4-20020a170902bc8400b001c755810f89sm348257plb.181.2023.11.10.18.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:40 -0800 (PST)
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
	riel@surriel.com,
	changwoo@igalia.com,
	himadrics@inria.fr,
	memxor@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 24/36] sched_ext: Track tasks that are subjects of the in-flight SCX operation
Date: Fri, 10 Nov 2023 16:47:50 -1000
Message-ID: <20231111024835.2164816-25-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 771553bfd72a..604d89226260 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -449,6 +449,7 @@ enum scx_kf_mask {
 	SCX_KF_REST		= 1 << 5, /* other rq-locked operations */
 
 	__SCX_KF_RQ_LOCKED	= SCX_KF_DISPATCH | SCX_KF_ENQUEUE | SCX_KF_REST,
+	__SCX_KF_TERMINAL	= SCX_KF_ENQUEUE | SCX_KF_REST,
 };
 
 /*
@@ -464,6 +465,7 @@ struct sched_ext_entity {
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	u32			kf_mask;	/* see scx_kf_mask above */
+	struct task_struct	*kf_tasks[2];	/* see SCX_CALL_OP_TASK() */
 	atomic_long_t		ops_state;
 	unsigned long		runnable_at;
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b5adb46731c8..aa7569004511 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -245,6 +245,47 @@ do {										\
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
@@ -275,6 +316,22 @@ static __always_inline bool scx_kf_allowed(u32 mask)
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
@@ -716,7 +773,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	WARN_ON_ONCE(*ddsp_taskp);
 	*ddsp_taskp = p;
 
-	SCX_CALL_OP(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
+	SCX_CALL_OP_TASK(SCX_KF_ENQUEUE, enqueue, p, enq_flags);
 
 	/*
 	 * If not directly dispatched, QUEUEING isn't clear yet and dispatch or
@@ -788,7 +845,7 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	add_nr_running(rq, 1);
 
 	if (SCX_HAS_OP(runnable))
-		SCX_CALL_OP(SCX_KF_REST, runnable, p, enq_flags);
+		SCX_CALL_OP_TASK(SCX_KF_REST, runnable, p, enq_flags);
 
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 }
@@ -813,7 +870,7 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 		BUG();
 	case SCX_OPSS_QUEUED:
 		if (SCX_HAS_OP(dequeue))
-			SCX_CALL_OP(SCX_KF_REST, dequeue, p, deq_flags);
+			SCX_CALL_OP_TASK(SCX_KF_REST, dequeue, p, deq_flags);
 
 		if (atomic_long_try_cmpxchg(&p->scx.ops_state, &opss,
 					    SCX_OPSS_NONE))
@@ -864,11 +921,11 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
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
@@ -887,7 +944,7 @@ static void yield_task_scx(struct rq *rq)
 	struct task_struct *p = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		SCX_CALL_OP_RET(SCX_KF_REST, yield, p, NULL);
+		SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, p, NULL);
 	else
 		p->scx.slice = 0;
 }
@@ -897,7 +954,7 @@ static bool yield_to_task_scx(struct rq *rq, struct task_struct *to)
 	struct task_struct *from = rq->curr;
 
 	if (SCX_HAS_OP(yield))
-		return SCX_CALL_OP_RET(SCX_KF_REST, yield, from, to);
+		return SCX_CALL_OP_2TASKS_RET(SCX_KF_REST, yield, from, to);
 	else
 		return false;
 }
@@ -1409,7 +1466,7 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP(SCX_KF_REST, running, p);
+		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
 
 	watchdog_unwatch_task(p, true);
 
@@ -1465,7 +1522,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 
 	/* see dequeue_task_scx() on why we skip when !QUEUED */
 	if (SCX_HAS_OP(stopping) && (p->scx.flags & SCX_TASK_QUEUED))
-		SCX_CALL_OP(SCX_KF_REST, stopping, p, true);
+		SCX_CALL_OP_TASK(SCX_KF_REST, stopping, p, true);
 
 	/*
 	 * If we're being called from put_prev_task_balance(), balance_scx() may
@@ -1656,8 +1713,8 @@ static int select_task_rq_scx(struct task_struct *p, int prev_cpu, int wake_flag
 	if (SCX_HAS_OP(select_cpu)) {
 		s32 cpu;
 
-		cpu = SCX_CALL_OP_RET(SCX_KF_REST, select_cpu, p, prev_cpu,
-				      wake_flags);
+		cpu = SCX_CALL_OP_TASK_RET(SCX_KF_REST, select_cpu, p, prev_cpu,
+					   wake_flags);
 		if (ops_cpu_valid(cpu)) {
 			return cpu;
 		} else {
@@ -1683,8 +1740,8 @@ static void set_cpus_allowed_scx(struct task_struct *p,
 	 * designation pointless. Cast it away when calling the operation.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP(SCX_KF_REST, set_cpumask, p,
-			    (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
+				 (struct cpumask *)p->cpus_ptr);
 }
 
 static void reset_idle_masks(void)
@@ -1846,7 +1903,7 @@ static void scx_ops_enable_task(struct task_struct *p)
 
 	if (SCX_HAS_OP(enable)) {
 		struct scx_enable_args args = { };
-		SCX_CALL_OP(SCX_KF_REST, enable, p, &args);
+		SCX_CALL_OP_TASK(SCX_KF_REST, enable, p, &args);
 	}
 	p->scx.flags &= ~SCX_TASK_OPS_PREPPED;
 	p->scx.flags |= SCX_TASK_OPS_ENABLED;
@@ -1891,7 +1948,7 @@ static void refresh_scx_weight(struct task_struct *p)
 	lockdep_assert_rq_held(task_rq(p));
 	set_task_scx_weight(p);
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
 }
 
 void scx_pre_fork(struct task_struct *p)
@@ -1989,8 +2046,8 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
 	 * different scheduler class. Keep the BPF scheduler up-to-date.
 	 */
 	if (SCX_HAS_OP(set_cpumask))
-		SCX_CALL_OP(SCX_KF_REST, set_cpumask, p,
-			    (struct cpumask *)p->cpus_ptr);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_cpumask, p,
+				 (struct cpumask *)p->cpus_ptr);
 }
 
 static void wakeup_preempt_scx(struct rq *rq, struct task_struct *p,int wake_flags) {}
-- 
2.42.0


