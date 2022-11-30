Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBD863D080
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiK3I0N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiK3IZX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:25:23 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321B560345;
        Wed, 30 Nov 2022 00:24:18 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b13-20020a17090a5a0d00b0021906102d05so1216428pjd.5;
        Wed, 30 Nov 2022 00:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTnDarJAIOFnrZMrKBccMkgLgr3KISG6ySOAHjPJ4NA=;
        b=FWbg7tlCr9ZJApIPO88BjZAq6OfnOoVGuC+ZwhLyEbwVGTiL2AK4DRp747BxJDuDmm
         +68hzIcrCM6R8vEWkbO7bojekE/ax59SSKgd1CQeE2HR5m5wTqa5uclc/i+gDaV4Hp3T
         RM+MySwyueXj1iY4R/VBRUV6P66SOrH68R4PMhrUGjSFzBAayikxThWIoG2P5Wa7KpfD
         RRhP8tdQUtd4EYoD6cLC9mQKVr5N6Nh/JUI19ScwjPPuUW92UaMOZ7yuZX0+kJ/D0/cx
         ri18tKVAj86M4I21yPAgyN+J8LY3156Eg0cj6Jvlh3K3Dlr+MaM5W/ZWEQMPS9wJahep
         lQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTnDarJAIOFnrZMrKBccMkgLgr3KISG6ySOAHjPJ4NA=;
        b=kfDUQSaGVHVKbYBMA+hpg35q+0lJ2OaD38VgU7NPpHIn7VrGjxiJmUpP+XPHYk7igg
         F98+9KUJ01ckp4O0I99QZ+7xUMwZsjQNcpXnO78sAW7GGd1GYrjzjw8Sy8/hET2FhYq8
         sCZv+qzPJTugAb4SKWeIvYeKDffbfVpeVyOOvklhJmf5fSGnXnqsyZACe/hCqTxInQkY
         b5p8O4ItzXHMgFBHGGWzBKLAZ86T5Al2Ud0SCwz6yZFdKoonfSbum5tTfnnN2NTVJSYr
         M0iNuX2AIAmSy2g6A4uCD6ySUn3hpMq+jyPUzktCZTfVmEcQvR0yU8pJj5jcoJ6AkD6r
         4grw==
X-Gm-Message-State: ANoB5plyzpOruYTybBdndgmsPLCBFpXkGeQOMHfNaJsTRe7FUHNYtKZC
        KlLmkApvkhRpsYtJSwWSwFQ=
X-Google-Smtp-Source: AA0mqf6afQ4RhFhqFPrc81ZCpFELGPUbLtWalZxPzPLAh1B7J2KYeUvXb0uavuTz6gcwIarlmdgE1w==
X-Received: by 2002:a17:90b:3941:b0:215:db2e:bb17 with SMTP id oe1-20020a17090b394100b00215db2ebb17mr63972053pjb.166.1669796656148;
        Wed, 30 Nov 2022 00:24:16 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b001894198d0ebsm762648plb.24.2022.11.30.00.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:15 -0800 (PST)
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
Subject: [PATCH 18/31] sched_ext: Implement runnable task stall watchdog
Date:   Tue, 29 Nov 2022 22:23:00 -1000
Message-Id: <20221130082313.3241517-19-tj@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221130082313.3241517-1-tj@kernel.org>
References: <20221130082313.3241517-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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
scx_example_qmap is updated so that it can be told to stall user and/or
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

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h              |  14 +++
 init/init_task.c                       |   2 +
 kernel/sched/core.c                    |   3 +
 kernel/sched/ext.c                     | 133 +++++++++++++++++++++++--
 kernel/sched/ext.h                     |  26 +++++
 kernel/sched/sched.h                   |   1 +
 tools/sched_ext/scx_example_qmap.bpf.c |  12 +++
 tools/sched_ext/scx_example_qmap.c     |  14 ++-
 8 files changed, 193 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 1ec8be53057f..1a57945abea0 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -59,6 +59,7 @@ enum scx_exit_type {
 
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
+	SCX_EXIT_ERROR_STALL,	/* watchdog detected stalled runnable tasks */
 };
 
 /*
@@ -323,6 +324,15 @@ struct sched_ext_ops {
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
@@ -357,6 +367,8 @@ enum scx_ent_flags {
 	SCX_TASK_OPS_PREPPED	= 1 << 3, /* prepared for BPF scheduler enable */
 	SCX_TASK_OPS_ENABLED	= 1 << 4, /* task has BPF scheduler enabled */
 
+	SCX_TASK_WATCHDOG_RESET = 1 << 5, /* task watchdog counter should be reset */
+
 	SCX_TASK_CURSOR		= 1 << 6, /* iteration cursor, not a task */
 };
 
@@ -367,11 +379,13 @@ enum scx_ent_flags {
 struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
 	struct list_head	dsq_node;
+	struct list_head	watchdog_node;
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	atomic64_t		ops_state;
+	unsigned long		runnable_at;
 
 	/* BPF scheduler modifiable fields */
 
diff --git a/init/init_task.c b/init/init_task.c
index bdbc663107bf..913194aab623 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -106,9 +106,11 @@ struct task_struct init_task
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
index dc499f18573a..39d9ccb64f40 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4366,11 +4366,13 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SCHED_CLASS_EXT
 	p->scx.dsq		= NULL;
 	INIT_LIST_HEAD(&p->scx.dsq_node);
+	INIT_LIST_HEAD(&p->scx.watchdog_node);
 	p->scx.flags		= 0;
 	p->scx.weight		= 0;
 	p->scx.sticky_cpu	= -1;
 	p->scx.holding_cpu	= -1;
 	atomic64_set(&p->scx.ops_state, 0);
+	p->scx.runnable_at	= INITIAL_JIFFIES;
 	p->scx.slice		= SCX_SLICE_DFL;
 #endif
 
@@ -5514,6 +5516,7 @@ void scheduler_tick(void)
 	if (sched_feat(LATENCY_WARN) && resched_latency)
 		resched_latency_warn(cpu, resched_latency);
 
+	scx_notify_sched_tick();
 	perf_event_task_tick();
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index a0057a8447cb..030175f2b1d6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9,6 +9,7 @@
 enum scx_internal_consts {
 	SCX_NR_ONLINE_OPS	 = SCX_OP_IDX(init),
 	SCX_DSP_DFL_MAX_BATCH	 = 32,
+	SCX_MAX_RUNNABLE_TIMEOUT = 30 * MSEC_PER_SEC,
 };
 
 enum scx_ops_enable_state {
@@ -87,6 +88,23 @@ static struct scx_exit_info scx_exit_info;
 
 static atomic64_t scx_nr_rejected = ATOMIC64_INIT(0);
 
+/*
+ * The maximum amount of time that a task may be runnable without being
+ * scheduled on a CPU. If this timeout is exceeded, it will trigger
+ * scx_ops_error().
+ */
+unsigned long task_runnable_timeout_ms;
+
+/*
+ * The last time the delayed work was run. This delayed work relies on
+ * ksoftirqd being able to run to service timer interrupts, so it's possible
+ * that this work itself could get wedged. To account for this, we check that
+ * it's not stalled in the timer tick, and trigger an error if it is.
+ */
+unsigned long last_timeout_check = INITIAL_JIFFIES;
+
+static struct delayed_work check_timeout_work;
+
 /* idle tracking */
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
@@ -148,10 +166,6 @@ static DEFINE_PER_CPU(struct consume_ctx, consume_ctx);
 
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
 		      u64 enq_flags);
-__printf(2, 3) static void scx_ops_error_type(enum scx_exit_type type,
-					      const char *fmt, ...);
-#define scx_ops_error(fmt, args...)						\
-	scx_ops_error_type(SCX_EXIT_ERROR, fmt, ##args)
 
 struct scx_task_iter {
 	struct sched_ext_entity		cursor;
@@ -597,6 +611,27 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
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
@@ -613,9 +648,12 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
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
@@ -628,8 +666,12 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 	struct scx_rq *scx_rq = &rq->scx;
 	u64 opss;
 
-	if (!(p->scx.flags & SCX_TASK_QUEUED))
+	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
+		WARN_ON_ONCE(watchdog_task_watched(p));
 		return;
+	}
+
+	watchdog_unwatch_task(p, false);
 
 	/* acquire ensures that we see the preceding updates on QUEUED */
 	opss = atomic64_read_acquire(&p->scx.ops_state);
@@ -1168,6 +1210,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
+
+	watchdog_unwatch_task(p, true);
 }
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
@@ -1180,11 +1224,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
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
@@ -1405,6 +1452,48 @@ static void reset_idle_masks(void) {}
 
 #endif /* CONFIG_SMP */
 
+static bool check_rq_for_timeouts(struct rq *rq)
+{
+	struct task_struct *p;
+	unsigned long flags;
+	bool timed_out = false;
+	unsigned long timeout = msecs_to_jiffies(task_runnable_timeout_ms);
+
+	raw_spin_rq_lock_irqsave(rq, flags);
+	list_for_each_entry(p, &rq->scx.watchdog_list, scx.watchdog_node) {
+		unsigned long last_runnable = p->scx.runnable_at;
+
+		if (unlikely(time_after(jiffies, last_runnable + timeout))) {
+			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
+
+			scx_ops_error_type(SCX_EXIT_ERROR_STALL,
+					   "%s[%d] failed to run for %u.%03us",
+					   p->comm, p->pid,
+					   dur_ms / 1000, dur_ms % 1000);
+			timed_out = true;
+			break;
+		}
+	}
+	raw_spin_rq_unlock_irqrestore(rq, flags);
+
+	return timed_out;
+}
+
+static void scx_check_timeout_workfn(struct work_struct *work)
+{
+	int cpu;
+
+	last_timeout_check = jiffies;
+	for_each_online_cpu(cpu) {
+		if (unlikely(check_rq_for_timeouts(cpu_rq(cpu))))
+			break;
+
+		cond_resched();
+	}
+	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+			   task_runnable_timeout_ms / 2);
+}
+
 static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 {
 	update_curr_scx(rq);
@@ -1430,7 +1519,7 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 		}
 	}
 
-	p->scx.flags |= SCX_TASK_OPS_PREPPED;
+	p->scx.flags |= (SCX_TASK_OPS_PREPPED | SCX_TASK_WATCHDOG_RESET);
 	return 0;
 }
 
@@ -1767,6 +1856,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 			break;
 	}
 
+	cancel_delayed_work_sync(&check_timeout_work);
+
 	switch (type) {
 	case SCX_EXIT_UNREG:
 		reason = "BPF scheduler unregistered";
@@ -1780,6 +1871,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	case SCX_EXIT_ERROR_BPF:
 		reason = "scx_bpf_error";
 		break;
+	case SCX_EXIT_ERROR_STALL:
+		reason = "runnable task stall";
+		break;
 	default:
 		reason = "<UNKNOWN>";
 	}
@@ -1954,8 +2048,8 @@ static void scx_ops_error_irq_workfn(struct irq_work *irq_work)
 
 static DEFINE_IRQ_WORK(scx_ops_error_irq_work, scx_ops_error_irq_workfn);
 
-__printf(2, 3) static void scx_ops_error_type(enum scx_exit_type type,
-					      const char *fmt, ...)
+__printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
+				       const char *fmt, ...)
 {
 	struct scx_exit_info *ei = &scx_exit_info;
 	int none = SCX_EXIT_NONE;
@@ -2059,6 +2153,20 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		goto err_disable;
 	}
 
+	task_runnable_timeout_ms = SCX_MAX_RUNNABLE_TIMEOUT;
+	if (ops->timeout_ms) {
+		/*
+		 * Excessively large timeouts should have been rejected in
+		 * bpf_scx_init_member().
+		 */
+		WARN_ON_ONCE(ops->timeout_ms > SCX_MAX_RUNNABLE_TIMEOUT);
+		task_runnable_timeout_ms = ops->timeout_ms;
+	}
+
+	last_timeout_check = jiffies;
+	queue_delayed_work(system_unbound_wq, &check_timeout_work,
+			   task_runnable_timeout_ms / 2);
+
 	/*
 	 * Lock out forks before opening the floodgate so that they don't wander
 	 * into the operations prematurely.
@@ -2316,6 +2424,11 @@ static int bpf_scx_init_member(const struct btf_type *t,
 		if (ret == 0)
 			return -EINVAL;
 		return 1;
+	case offsetof(struct sched_ext_ops, timeout_ms):
+		if (*(u32 *)(udata + moff) > SCX_MAX_RUNNABLE_TIMEOUT)
+			return -E2BIG;
+		ops->timeout_ms = *(u32 *)(udata + moff);
+		return 1;
 	}
 
 	return 0;
@@ -2416,10 +2529,12 @@ void __init init_sched_ext_class(void)
 		struct rq *rq = cpu_rq(cpu);
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
+		INIT_LIST_HEAD(&rq->scx.watchdog_list);
 		rq->scx.nr_running = 0;
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
+	INIT_DELAYED_WORK(&check_timeout_work, scx_check_timeout_workfn);
 }
 
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 6d5669481274..bda1d9c11486 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -67,6 +67,8 @@ void sched_enq_and_set_task(struct sched_enq_and_set_ctx *ctx);
 extern const struct sched_class ext_sched_class;
 extern const struct bpf_verifier_ops bpf_sched_ext_verifier_ops;
 extern const struct file_operations sched_ext_fops;
+extern unsigned long task_runnable_timeout_ms;
+extern unsigned long last_timeout_check;
 
 DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
@@ -79,6 +81,29 @@ void scx_cancel_fork(struct task_struct *p);
 int balance_scx(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 void init_sched_ext_class(void);
 
+__printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
+				       const char *fmt, ...);
+#define scx_ops_error(fmt, args...)						\
+	scx_ops_error_type(SCX_EXIT_ERROR, fmt, ##args)
+
+static inline void scx_notify_sched_tick(void)
+{
+	unsigned long last_check, timeout;
+
+	if (!scx_enabled())
+		return;
+
+	last_check = last_timeout_check;
+	timeout = msecs_to_jiffies(task_runnable_timeout_ms);
+	if (unlikely(time_after(jiffies, last_check + timeout))) {
+		u32 dur_ms = jiffies_to_msecs(jiffies - last_check);
+
+		scx_ops_error_type(SCX_EXIT_ERROR_STALL,
+				   "watchdog failed to check in for %u.%03us",
+				   dur_ms / 1000, dur_ms % 1000);
+	}
+}
+
 static inline const struct sched_class *next_active_class(const struct sched_class *class)
 {
 	class++;
@@ -112,6 +137,7 @@ static inline void scx_cancel_fork(struct task_struct *p) {}
 static inline int balance_scx(struct rq *rq, struct task_struct *prev,
 			      struct rq_flags *rf) { return 0; }
 static inline void init_sched_ext_class(void) {}
+static inline void scx_notify_sched_tick(void) {}
 
 #define for_each_active_class		for_each_class
 #define for_balance_class_range		for_class_range
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 18a80d5b542b..40692fa7cb3c 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -692,6 +692,7 @@ struct cfs_rq {
 #ifdef CONFIG_SCHED_CLASS_EXT
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
+	struct list_head	watchdog_list;
 	u64			ops_qseq;
 	u32			nr_running;
 #ifdef CONFIG_SMP
diff --git a/tools/sched_ext/scx_example_qmap.bpf.c b/tools/sched_ext/scx_example_qmap.bpf.c
index 742c866d2a8e..9e0b6519c8a4 100644
--- a/tools/sched_ext/scx_example_qmap.bpf.c
+++ b/tools/sched_ext/scx_example_qmap.bpf.c
@@ -22,6 +22,8 @@
 char _license[] SEC("license") = "GPL";
 
 const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile u32 stall_user_nth;
+const volatile u32 stall_kernel_nth;
 
 u32 test_error_cnt;
 
@@ -106,6 +108,15 @@ void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 	u32 pid = p->pid;
 	int idx;
 	void *ring;
+	static u32 user_cnt, kernel_cnt;
+
+	if (p->flags & PF_KTHREAD) {
+		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
+			return;
+	} else {
+		if (stall_user_nth && !(++user_cnt % stall_user_nth))
+			return;
+	}
 
 	if (test_error_cnt && !--test_error_cnt)
 		scx_bpf_error("test triggering error");
@@ -224,5 +235,6 @@ struct sched_ext_ops qmap_ops = {
 	.dispatch		= (void *)qmap_dispatch,
 	.prep_enable		= (void *)qmap_prep_enable,
 	.exit			= (void *)qmap_exit,
+	.timeout_ms		= 5000U,
 	.name			= "qmap",
 };
diff --git a/tools/sched_ext/scx_example_qmap.c b/tools/sched_ext/scx_example_qmap.c
index c5a208533404..34c764c38e19 100644
--- a/tools/sched_ext/scx_example_qmap.c
+++ b/tools/sched_ext/scx_example_qmap.c
@@ -20,10 +20,12 @@ const char help_fmt[] =
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
@@ -47,13 +49,19 @@ int main(int argc, char **argv)
 	skel = scx_example_qmap__open();
 	assert(skel);
 
-	while ((opt = getopt(argc, argv, "hs:e:tTd:")) != -1) {
+	while ((opt = getopt(argc, argv, "hs:e:t:T:d:")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
 			break;
 		case 'e':
-			skel->bss->test_error_cnt = strtoull(optarg, NULL, 0);
+			skel->bss->test_error_cnt = strtoul(optarg, NULL, 0);
+			break;
+		case 't':
+			skel->rodata->stall_user_nth = strtoul(optarg, NULL, 0);
+			break;
+		case 'T':
+			skel->rodata->stall_kernel_nth = strtoul(optarg, NULL, 0);
 			break;
 		default:
 			fprintf(stderr, help_fmt, basename(argv[0]));
-- 
2.38.1

