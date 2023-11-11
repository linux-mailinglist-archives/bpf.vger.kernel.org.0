Return-Path: <bpf+bounces-14851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C87E88A4
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9566C281016
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CDB539C;
	Sat, 11 Nov 2023 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyjcWJRk"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE88184F
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:51:44 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC3646B1;
	Fri, 10 Nov 2023 18:49:25 -0800 (PST)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1f060e059a3so1531619fac.1;
        Fri, 10 Nov 2023 18:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670964; x=1700275764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WPUVrhFzd//6jf8A6UOf9EK3aAvgdU7Dw5qKwW5AGA=;
        b=hyjcWJRkKUSprDtzNv7uCx3SHKXh0j23H/SIiVO5tT9dZUQi4h5F1MtkE4aQ48jvmv
         zkXZwVZFtsrXK8W5sh3orBBBCO67q5PFmKUm/aRoGcz5JhzASJJsYERnF466ctY/ga50
         0ALw/2RwGB4GxDQnlINVeY4YhAmF5Y2el0s9py/FhH9Oxv2kLe7O0uVAHZH3ePL6a/sY
         jFBIe72oCcKMLpFfF7wd1psC+b3VoBHI+rMwH7OJyOXstBYk2CHkhOml8WxCQIIZTeUW
         ogpfmmwUwIb5KcCrrLryVnKgNiI+yi36L6kwFa/HMeN1VWx82wMNJBNuKGHv5GaGcQ2F
         kLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670964; x=1700275764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0WPUVrhFzd//6jf8A6UOf9EK3aAvgdU7Dw5qKwW5AGA=;
        b=RxAb2yx6ZLrGKhF4TKZmJJ2p52Xjq0/LnQYfuwnidYKT019TaTL+FlEZmQYffObzRK
         otMLZcXsdilxlfU5Zvl7u9tjhf3rr/GIc21rEQz3tVoO41pkrqo/UDbGfPvbL2iJz7dX
         iXtVHJ4pSyUwcQhDr3eI09Kzf9YVU3cGNpDap1u2zERAICQGHFqLQjHbhrRNbNyDDVMz
         YenafnqCVei2XMsSN+pM4j9Kbxz7L8CMksUF3zmCjBkR0lZPOIiVSxHgKujaHUyON3q8
         /p7kPy8Kk1FradZZ4K1p4qKhI2z9suowOH+rRta4RHLTcC+dutv1sjCNRtjnMYuHigzs
         5BTA==
X-Gm-Message-State: AOJu0Yz4b7Yx/5eNIFwJitA5UhncsNk9zJjbCwd0662FQO7GvuI2M6+R
	6iPBzdryDpGZkewakFShxQQ=
X-Google-Smtp-Source: AGHT+IHjZHn9Rz01KpF+Uut+qLJq9yLkNHKpJecghdYyhJ5nYDDQ4wR+0l3bP1Jiiw5rp06zqBdJEQ==
X-Received: by 2002:a05:6870:bf14:b0:1e9:68b5:d418 with SMTP id qh20-20020a056870bf1400b001e968b5d418mr1016600oab.34.1699670964180;
        Fri, 10 Nov 2023 18:49:24 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id v4-20020a62a504000000b0068be348e35fsm394721pfm.166.2023.11.10.18.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:23 -0800 (PST)
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
	Tejun Heo <tj@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH 15/36] sched_ext: Implement runnable task stall watchdog
Date: Fri, 10 Nov 2023 16:47:41 -1000
Message-ID: <20231111024835.2164816-16-tj@kernel.org>
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

From: David Vernet <dvernet@meta.com>

The most common and critical way that a BPF scheduler can misbehave is by
failing to run runnable tasks for too long. This patch implements a
watchdog.

* All tasks record when they become runnable.

* A watchdog work periodically scans all runnable tasks. If any task has
  stayed runnable for too long, the BPF scheduler is aborted.

* scheduler_tick() monitors whether the watchdog itself is stuck. If so, the
  BPF scheduler is aborted.

Because the watchdog only scans the tasks which are currently runnable and
usually very infrequently, the overhead should be negligible.
scx_qmap is updated so that it can be told to stall user and/or
kernel tasks.

A detected task stall looks like the following:

 sched_ext: BPF scheduler "qmap" errored, disabling
 sched_ext: runnable task stall (dbus-daemon[953] failed to run for 6.478s)
    scx_check_timeout_workfn+0x10e/0x1b0
    process_one_work+0x287/0x560
    worker_thread+0x234/0x420
    kthread+0xe9/0x100
    ret_from_fork+0x1f/0x30

A detected watchdog stall:

 sched_ext: BPF scheduler "qmap" errored, disabling
 sched_ext: runnable task stall (watchdog failed to check in for 5.001s)
    scheduler_tick+0x2eb/0x340
    update_process_times+0x7a/0x90
    tick_sched_timer+0xd8/0x130
    __hrtimer_run_queues+0x178/0x3b0
    hrtimer_interrupt+0xfc/0x390
    __sysvec_apic_timer_interrupt+0xb7/0x2b0
    sysvec_apic_timer_interrupt+0x90/0xb0
    asm_sysvec_apic_timer_interrupt+0x1b/0x20
    default_idle+0x14/0x20
    arch_cpu_idle+0xf/0x20
    default_idle_call+0x50/0x90
    do_idle+0xe8/0x240
    cpu_startup_entry+0x1d/0x20
    kernel_init+0x0/0x190
    start_kernel+0x0/0x392
    start_kernel+0x324/0x392
    x86_64_start_reservations+0x2a/0x2c
    x86_64_start_kernel+0x104/0x109
    secondary_startup_64_no_verify+0xce/0xdb

Note that this patch exposes scx_ops_error[_type]() in kernel/sched/ext.h to
inline scx_notify_sched_tick().

v2: Julia Lawall noticed that the watchdog code was mixing msecs and
    jiffies. Fix by using jiffies for everything.

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
 include/linux/sched/ext.h      |  13 ++++
 init/init_task.c               |   2 +
 kernel/sched/core.c            |   3 +
 kernel/sched/ext.c             | 128 ++++++++++++++++++++++++++++++---
 kernel/sched/ext.h             |  25 +++++++
 kernel/sched/sched.h           |   1 +
 tools/sched_ext/scx_qmap.bpf.c |  12 ++++
 tools/sched_ext/scx_qmap.c     |  12 +++-
 8 files changed, 185 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index cad8ab4d782a..ec85415431d9 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -59,6 +59,7 @@ enum scx_exit_kind {
 
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
+	SCX_EXIT_ERROR_STALL,	/* watchdog detected stalled runnable tasks */
 };
 
 /*
@@ -315,6 +316,15 @@ struct sched_ext_ops {
 	 */
 	u64 flags;
 
+	/**
+	 * timeout_ms - The maximum amount of time, in milliseconds, that a
+	 * runnable task should be able to wait before being scheduled. The
+	 * maximum timeout may not exceed the default timeout of 30 seconds.
+	 *
+	 * Defaults to the maximum allowed timeout value of 30 seconds.
+	 */
+	u32 timeout_ms;
+
 	/**
 	 * name - BPF scheduler's name
 	 *
@@ -348,6 +358,7 @@ enum scx_ent_flags {
 	SCX_TASK_OPS_PREPPED	= 1 << 8, /* prepared for BPF scheduler enable */
 	SCX_TASK_OPS_ENABLED	= 1 << 9, /* task has BPF scheduler enabled */
 
+	SCX_TASK_WATCHDOG_RESET = 1 << 16, /* task watchdog counter should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 17, /* last dequeue was for SLEEP */
 
 	SCX_TASK_CURSOR		= 1 << 31, /* iteration cursor, not a task */
@@ -381,12 +392,14 @@ enum scx_kf_mask {
 struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
 	struct list_head	dsq_node;
+	struct list_head	watchdog_node;
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	u32			kf_mask;	/* see scx_kf_mask above */
 	atomic_long_t		ops_state;
+	unsigned long		runnable_at;
 
 	/* BPF scheduler modifiable fields */
 
diff --git a/init/init_task.c b/init/init_task.c
index 7eaf8b429f82..aedce50b363d 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -107,9 +107,11 @@ struct task_struct init_task
 #ifdef CONFIG_SCHED_CLASS_EXT
 	.scx		= {
 		.dsq_node	= LIST_HEAD_INIT(init_task.scx.dsq_node),
+		.watchdog_node	= LIST_HEAD_INIT(init_task.scx.watchdog_node),
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
 		.ops_state	= ATOMIC_INIT(0),
+		.runnable_at	= INITIAL_JIFFIES,
 		.slice		= SCX_SLICE_DFL,
 	},
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 21307eb284c2..c2ce0e8ac407 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4543,12 +4543,14 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SCHED_CLASS_EXT
 	p->scx.dsq		= NULL;
 	INIT_LIST_HEAD(&p->scx.dsq_node);
+	INIT_LIST_HEAD(&p->scx.watchdog_node);
 	p->scx.flags		= 0;
 	p->scx.weight		= 0;
 	p->scx.sticky_cpu	= -1;
 	p->scx.holding_cpu	= -1;
 	p->scx.kf_mask		= 0;
 	atomic64_set(&p->scx.ops_state, 0);
+	p->scx.runnable_at	= INITIAL_JIFFIES;
 	p->scx.slice		= SCX_SLICE_DFL;
 #endif
 
@@ -5714,6 +5716,7 @@ void scheduler_tick(void)
 	if (sched_feat(LATENCY_WARN) && resched_latency)
 		resched_latency_warn(cpu, resched_latency);
 
+	scx_notify_sched_tick();
 	perf_event_task_tick();
 
 	if (curr->flags & PF_WQ_WORKER)
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2d9996a96d3a..37a0f9c148d9 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9,6 +9,7 @@
 enum scx_internal_consts {
 	SCX_NR_ONLINE_OPS	= SCX_OP_IDX(init),
 	SCX_DSP_DFL_MAX_BATCH	= 32,
+	SCX_WATCHDOG_MAX_TIMEOUT = 30 * HZ,
 };
 
 enum scx_ops_enable_state {
@@ -92,6 +93,23 @@ struct static_key_false scx_has_op[SCX_NR_ONLINE_OPS] =
 static atomic_t scx_exit_kind = ATOMIC_INIT(SCX_EXIT_DONE);
 static struct scx_exit_info scx_exit_info;
 
+/*
+ * The maximum amount of time in jiffies that a task may be runnable without
+ * being scheduled on a CPU. If this timeout is exceeded, it will trigger
+ * scx_ops_error().
+ */
+unsigned long scx_watchdog_timeout;
+
+/*
+ * The last time the delayed work was run. This delayed work relies on
+ * ksoftirqd being able to run to service timer interrupts, so it's possible
+ * that this work itself could get wedged. To account for this, we check that
+ * it's not stalled in the timer tick, and trigger an error if it is.
+ */
+unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
+
+static struct delayed_work scx_watchdog_work;
+
 /* idle tracking */
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
@@ -150,10 +168,6 @@ static DEFINE_PER_CPU(struct scx_dsp_ctx, scx_dsp_ctx);
 
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
 		      u64 enq_flags);
-__printf(2, 3) static void scx_ops_error_kind(enum scx_exit_kind kind,
-					      const char *fmt, ...);
-#define scx_ops_error(fmt, args...)						\
-	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
 
 struct scx_task_iter {
 	struct sched_ext_entity		cursor;
@@ -707,6 +721,27 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dispatch_enqueue(&scx_dsq_global, p, enq_flags);
 }
 
+static bool watchdog_task_watched(const struct task_struct *p)
+{
+	return !list_empty(&p->scx.watchdog_node);
+}
+
+static void watchdog_watch_task(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+	if (p->scx.flags & SCX_TASK_WATCHDOG_RESET)
+		p->scx.runnable_at = jiffies;
+	p->scx.flags &= ~SCX_TASK_WATCHDOG_RESET;
+	list_add_tail(&p->scx.watchdog_node, &rq->scx.watchdog_list);
+}
+
+static void watchdog_unwatch_task(struct task_struct *p, bool reset_timeout)
+{
+	list_del_init(&p->scx.watchdog_node);
+	if (reset_timeout)
+		p->scx.flags |= SCX_TASK_WATCHDOG_RESET;
+}
+
 static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
 {
 	int sticky_cpu = p->scx.sticky_cpu;
@@ -725,9 +760,12 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p))
 		sticky_cpu = cpu_of(rq);
 
-	if (p->scx.flags & SCX_TASK_QUEUED)
+	if (p->scx.flags & SCX_TASK_QUEUED) {
+		WARN_ON_ONCE(!watchdog_task_watched(p));
 		return;
+	}
 
+	watchdog_watch_task(rq, p);
 	p->scx.flags |= SCX_TASK_QUEUED;
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
@@ -739,6 +777,8 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 {
 	unsigned long opss;
 
+	watchdog_unwatch_task(p, false);
+
 	/* acquire ensures that we see the preceding updates on QUEUED */
 	opss = atomic_long_read_acquire(&p->scx.ops_state);
 
@@ -783,8 +823,10 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 {
 	struct scx_rq *scx_rq = &rq->scx;
 
-	if (!(p->scx.flags & SCX_TASK_QUEUED))
+	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
+		WARN_ON_ONCE(watchdog_task_watched(p));
 		return;
+	}
 
 	ops_dequeue(p, deq_flags);
 
@@ -1309,6 +1351,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
+
+	watchdog_unwatch_task(p, true);
 }
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
@@ -1352,11 +1396,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 	 */
 	if (p->scx.flags & SCX_TASK_BAL_KEEP) {
 		p->scx.flags &= ~SCX_TASK_BAL_KEEP;
+		watchdog_watch_task(rq, p);
 		dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
 		return;
 	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
+		watchdog_watch_task(rq, p);
+
 		/*
 		 * If @p has slice left and balance_scx() didn't tag it for
 		 * keeping, @p is getting preempted by a higher priority
@@ -1614,6 +1661,49 @@ static void reset_idle_masks(void) {}
 
 #endif /* CONFIG_SMP */
 
+static bool check_rq_for_timeouts(struct rq *rq)
+{
+	struct task_struct *p;
+	struct rq_flags rf;
+	bool timed_out = false;
+
+	rq_lock_irqsave(rq, &rf);
+	list_for_each_entry(p, &rq->scx.watchdog_list, scx.watchdog_node) {
+		unsigned long last_runnable = p->scx.runnable_at;
+
+		if (unlikely(time_after(jiffies,
+					last_runnable + scx_watchdog_timeout))) {
+			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
+
+			scx_ops_error_kind(SCX_EXIT_ERROR_STALL,
+					   "%s[%d] failed to run for %u.%03us",
+					   p->comm, p->pid,
+					   dur_ms / 1000, dur_ms % 1000);
+			timed_out = true;
+			break;
+		}
+	}
+	rq_unlock_irqrestore(rq, &rf);
+
+	return timed_out;
+}
+
+static void scx_watchdog_workfn(struct work_struct *work)
+{
+	int cpu;
+
+	scx_watchdog_timestamp = jiffies;
+
+	for_each_online_cpu(cpu) {
+		if (unlikely(check_rq_for_timeouts(cpu_rq(cpu))))
+			break;
+
+		cond_resched();
+	}
+	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+			   scx_watchdog_timeout / 2);
+}
+
 static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 {
 	update_curr_scx(rq);
@@ -1645,7 +1735,7 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 		}
 	}
 
-	p->scx.flags |= SCX_TASK_OPS_PREPPED;
+	p->scx.flags |= (SCX_TASK_OPS_PREPPED | SCX_TASK_WATCHDOG_RESET);
 	return 0;
 }
 
@@ -1977,6 +2067,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 			break;
 	}
 
+	cancel_delayed_work_sync(&scx_watchdog_work);
+
 	switch (kind) {
 	case SCX_EXIT_UNREG:
 		reason = "BPF scheduler unregistered";
@@ -1990,6 +2082,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	case SCX_EXIT_ERROR_BPF:
 		reason = "scx_bpf_error";
 		break;
+	case SCX_EXIT_ERROR_STALL:
+		reason = "runnable task stall";
+		break;
 	default:
 		reason = "<UNKNOWN>";
 	}
@@ -2174,8 +2269,8 @@ static void scx_ops_error_irq_workfn(struct irq_work *irq_work)
 
 static DEFINE_IRQ_WORK(scx_ops_error_irq_work, scx_ops_error_irq_workfn);
 
-__printf(2, 3) static void scx_ops_error_kind(enum scx_exit_kind kind,
-					      const char *fmt, ...)
+__printf(2, 3) void scx_ops_error_kind(enum scx_exit_kind kind,
+				       const char *fmt, ...)
 {
 	struct scx_exit_info *ei = &scx_exit_info;
 	int none = SCX_EXIT_NONE;
@@ -2272,6 +2367,14 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		goto err_disable;
 	}
 
+	scx_watchdog_timeout = SCX_WATCHDOG_MAX_TIMEOUT;
+	if (ops->timeout_ms)
+		scx_watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
+
+	scx_watchdog_timestamp = jiffies;
+	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
+			   scx_watchdog_timeout / 2);
+
 	/*
 	 * Lock out forks before opening the floodgate so that they don't wander
 	 * into the operations prematurely.
@@ -2523,6 +2626,11 @@ static int bpf_scx_init_member(const struct btf_type *t,
 		if (ret == 0)
 			return -EINVAL;
 		return 1;
+	case offsetof(struct sched_ext_ops, timeout_ms):
+		if (*(u32 *)(udata + moff) > SCX_WATCHDOG_MAX_TIMEOUT)
+			return -E2BIG;
+		ops->timeout_ms = *(u32 *)(udata + moff);
+		return 1;
 	}
 
 	return 0;
@@ -2639,9 +2747,11 @@ void __init init_sched_ext_class(void)
 		struct rq *rq = cpu_rq(cpu);
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
+		INIT_LIST_HEAD(&rq->scx.watchdog_list);
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
+	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
 }
 
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 753860e985ae..c4da4e2838fd 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -71,6 +71,8 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
 extern const struct sched_class ext_sched_class;
 extern const struct bpf_verifier_ops bpf_sched_ext_verifier_ops;
 extern const struct file_operations sched_ext_fops;
+extern unsigned long scx_watchdog_timeout;
+extern unsigned long scx_watchdog_timestamp;
 
 DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
@@ -87,6 +89,28 @@ void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
 void init_sched_ext_class(void);
 
+__printf(2, 3) void scx_ops_error_kind(enum scx_exit_kind kind,
+				       const char *fmt, ...);
+#define scx_ops_error(fmt, args...)						\
+	scx_ops_error_kind(SCX_EXIT_ERROR, fmt, ##args)
+
+static inline void scx_notify_sched_tick(void)
+{
+	unsigned long last_check;
+
+	if (!scx_enabled())
+		return;
+
+	last_check = scx_watchdog_timestamp;
+	if (unlikely(time_after(jiffies, last_check + scx_watchdog_timeout))) {
+		u32 dur_ms = jiffies_to_msecs(jiffies - last_check);
+
+		scx_ops_error_kind(SCX_EXIT_ERROR_STALL,
+				   "watchdog failed to check in for %u.%03us",
+				   dur_ms / 1000, dur_ms % 1000);
+	}
+}
+
 static inline const struct sched_class *next_active_class(const struct sched_class *class)
 {
 	class++;
@@ -119,6 +143,7 @@ static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
 static inline void init_sched_ext_class(void) {}
+static inline void scx_notify_sched_tick(void) {}
 
 #define for_each_active_class		for_each_class
 #define for_balance_class_range		for_class_range
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e27545e5df0b..aec09e99cdb0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -675,6 +675,7 @@ struct cfs_rq {
 #ifdef CONFIG_SCHED_CLASS_EXT
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
+	struct list_head	watchdog_list;
 	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index 686681e2008a..a1bdb5774a63 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -25,6 +25,8 @@
 char _license[] SEC("license") = "GPL";
 
 const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile u32 stall_user_nth;
+const volatile u32 stall_kernel_nth;
 
 u32 test_error_cnt;
 
@@ -120,11 +122,20 @@ static int weight_to_idx(u32 weight)
 
 void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 {
+	static u32 user_cnt, kernel_cnt;
 	struct task_ctx *tctx;
 	u32 pid = p->pid;
 	int idx = weight_to_idx(p->scx.weight);
 	void *ring;
 
+	if (p->flags & PF_KTHREAD) {
+		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
+			return;
+	} else {
+		if (stall_user_nth && !(++user_cnt % stall_user_nth))
+			return;
+	}
+
 	if (test_error_cnt && !--test_error_cnt)
 		scx_bpf_error("test triggering error");
 
@@ -237,5 +248,6 @@ struct sched_ext_ops qmap_ops = {
 	.dispatch		= (void *)qmap_dispatch,
 	.prep_enable		= (void *)qmap_prep_enable,
 	.exit			= (void *)qmap_exit,
+	.timeout_ms		= 5000U,
 	.name			= "qmap",
 };
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index b250cbb851cc..711827b38578 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -18,10 +18,12 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
+"  -t COUNT      Stall every COUNT'th user thread\n"
+"  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -h            Display this help and exit\n";
 
 static volatile int exit_req;
@@ -45,7 +47,7 @@ int main(int argc, char **argv)
 	skel = scx_qmap__open();
 	SCX_BUG_ON(!skel, "Failed to open skel");
 
-	while ((opt = getopt(argc, argv, "s:e:tTd:h")) != -1) {
+	while ((opt = getopt(argc, argv, "s:e:t:T:d:h")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
@@ -53,6 +55,12 @@ int main(int argc, char **argv)
 		case 'e':
 			skel->bss->test_error_cnt = strtoul(optarg, NULL, 0);
 			break;
+		case 't':
+			skel->rodata->stall_user_nth = strtoul(optarg, NULL, 0);
+			break;
+		case 'T':
+			skel->rodata->stall_kernel_nth = strtoul(optarg, NULL, 0);
+			break;
 		default:
 			fprintf(stderr, help_fmt, basename(argv[0]));
 			return opt != 'h';
-- 
2.42.0


