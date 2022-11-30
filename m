Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249DF63D089
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 09:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235088AbiK3I0q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Nov 2022 03:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiK3IZa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Nov 2022 03:25:30 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3985CD19;
        Wed, 30 Nov 2022 00:24:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so1216036pjh.2;
        Wed, 30 Nov 2022 00:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHTDzRdz5DA6IrrQUBWLTf9dsKz4vZyh/RaT4ZRnGbs=;
        b=NswQGLw+Yjzh7aN9TicpM7rOiVvvLDWt+r98Mv2sRM2eh7iBFGBVhtsiSgeqLX2qwf
         BIV5hpYwnKM9fBH5R0b04rVUFEjwLrEi0iF4qZkaX3aK8UmqZOeHsxdHI+PgQoJPPe4X
         95ZtdDssB33Z/qck6fk95BKgpd8SHGmKkJZUq8qwJ9fJH5TGsseFFmHrJqkVf7R8i6Ia
         7RCnyqMSF1zYLNLCgjtucM7Guq2+Spl4KJMn8NfT0nww9oxnNnGMhSTc6ZiGmSiLG3CU
         mQQbCFUBtyoBa2lQLBDUUf6T70CxggfjvKbbtNJY2r591N3FJ34/9eMSeRs65wG4LUR7
         JTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHTDzRdz5DA6IrrQUBWLTf9dsKz4vZyh/RaT4ZRnGbs=;
        b=63K/HowMS8r51C4sFlH4irNbnJ/y4TNQLCPBlXguGBBFvrryNuTq8PBDQpiQp0WsvV
         QQNxeQvegq4xwSZ845wWQwAKF+OQUkQ3YZUFcdnnzVm2v1AJRzZZGtBmW379Lnj3afZQ
         G60bNkCeZxKBOfjZJ3KEenpG45lpGWV4b8kMZfGq0XzB6kx34QgzhtnN0s8Zd+I75vF/
         UVBZPyfSx3hME1v9E/58t5SKjlv7pR4oJzYj+UVDllmCmRV7LwCRCOe1Kd9M1e1MeaT1
         W9Oh+9ybdVf5tQl+roklo4RUeZ59g//sTS8F8jP1o/5mGygs2zyL0GV8bw/eKMwzDsj8
         Pccg==
X-Gm-Message-State: ANoB5pn/5bTAmZgoyNfCd2969XX76UpJEAzwHUfkiwu7vUFBWIY5pm7y
        CBNCrUKwYZftk6Zg8o5XNVg=
X-Google-Smtp-Source: AA0mqf7pccS0FtBSkVA8kSq6vgg+b67wsbp3cCRBG6xVFu1aihf6EDapVgQxsOKLbvQyxZ4GWwTl5Q==
X-Received: by 2002:a17:902:7006:b0:181:b55a:f987 with SMTP id y6-20020a170902700600b00181b55af987mr41609614plk.67.1669796666302;
        Wed, 30 Nov 2022 00:24:26 -0800 (PST)
Received: from localhost ([2600:380:4a00:1415:d028:b547:7d35:7b0b])
        by smtp.gmail.com with ESMTPSA id o13-20020a170902d4cd00b0017f7c4e260fsm765905plg.150.2022.11.30.00.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:24:25 -0800 (PST)
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
Subject: [PATCH 23/31] sched_ext: Implement tickless support
Date:   Tue, 29 Nov 2022 22:23:05 -1000
Message-Id: <20221130082313.3241517-24-tj@kernel.org>
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

Allow BPF schedulers to indicate tickless operation by setting p->scx.slice
to SCX_SLICE_INF. A CPU whose current task has infinte slice goes into
tickless operation.

scx_example_central is updated to use tickless operations for all tasks and
instead use a BPF timer to expire slices. This also uses the SCX_ENQ_PREEMPT
and task state tracking added by the previous patches.

Currently, there is no way to pin the timer on the central CPU, so it may
end up on one of the worker CPUs; however, outside of that, the worker CPUs
can go tickless both while running sched_ext tasks and idling.

With schbench running, scx_example_central shows:

  root@test ~# grep ^LOC /proc/interrupts; sleep 10; grep ^LOC /proc/interrupts
  LOC:     142024        656        664        449   Local timer interrupts
  LOC:     161663        663        665        449   Local timer interrupts

Without it:

  root@test ~ [SIGINT]# grep ^LOC /proc/interrupts; sleep 10; grep ^LOC /proc/interrupts
  LOC:     188778       3142       3793       3993   Local timer interrupts
  LOC:     198993       5314       6323       6438   Local timer interrupts

While scx_example_central itself is too barebone to be useful as a
production scheduler, a more featureful central scheduler can be built using
the same approach. Google's experience shows that such an approach can have
significant benefits for certain applications such as VM hosting.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h                 |   1 +
 kernel/sched/core.c                       |   9 +-
 kernel/sched/ext.c                        |  43 +++++-
 kernel/sched/ext.h                        |   2 +
 kernel/sched/sched.h                      |   6 +
 tools/sched_ext/scx_example_central.bpf.c | 160 +++++++++++++++++++++-
 tools/sched_ext/scx_example_central.c     |   3 +-
 7 files changed, 212 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 4f8898556b28..b1c95fb11c8d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -19,6 +19,7 @@ enum scx_consts {
 	SCX_EXIT_MSG_LEN	= 1024,
 
 	SCX_SLICE_DFL		= 20 * NSEC_PER_MSEC,
+	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
 };
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20536957840d..89d2421809da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1200,13 +1200,16 @@ bool sched_can_stop_tick(struct rq *rq)
 		return true;
 
 	/*
-	 * If there are no DL,RR/FIFO tasks, there must only be CFS tasks left;
-	 * if there's more than one we need the tick for involuntary
-	 * preemption.
+	 * If there are no DL,RR/FIFO tasks, there must only be CFS or SCX tasks
+	 * left. For CFS, if there's more than one we need the tick for
+	 * involuntary preemption. For SCX, ask.
 	 */
 	if (!scx_switched_all() && rq->nr_running > 1)
 		return false;
 
+	if (scx_enabled() && !scx_can_stop_tick(rq))
+		return false;
+
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2eb382ed0e2f..cf6493f684f3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -383,7 +383,8 @@ static void update_curr_scx(struct rq *rq)
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
 
-	curr->scx.slice -= min(curr->scx.slice, delta_exec);
+	if (curr->scx.slice != SCX_SLICE_INF)
+		curr->scx.slice -= min(curr->scx.slice, delta_exec);
 }
 
 static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
@@ -1251,6 +1252,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 		scx_ops.running(p);
 
 	watchdog_unwatch_task(p, true);
+
+	/*
+	 * @p is getting newly scheduled or got kicked after someone updated its
+	 * slice. Refresh whether tick can be stopped. See can_stop_tick_scx().
+	 */
+	if ((p->scx.slice == SCX_SLICE_INF) !=
+	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
+		if (p->scx.slice == SCX_SLICE_INF)
+			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
+		else
+			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
+
+		sched_update_tick_dependency(rq);
+	}
 }
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
@@ -1742,6 +1757,26 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 	return 0;
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+bool scx_can_stop_tick(struct rq *rq)
+{
+	struct task_struct *p = rq->curr;
+
+	if (scx_ops_disabling())
+		return false;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	/*
+	 * @rq can consume from different dsq's, so we can't tell whether it
+	 * needs the tick or not by looking at nr_running. Allow stopping ticks
+	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 */
+	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
+}
+#endif
+
 /*
  * Omitted operations:
  *
@@ -1923,7 +1958,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	struct scx_task_iter sti;
 	struct task_struct *p;
 	const char *reason;
-	int i, type;
+	int i, cpu, type;
 
 	type = atomic_read(&scx_exit_type);
 	while (true) {
@@ -2021,6 +2056,10 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	scx_task_iter_exit(&sti);
 	spin_unlock_irq(&scx_tasks_lock);
 
+	/* kick all CPUs to restore ticks */
+	for_each_possible_cpu(cpu)
+		resched_cpu(cpu);
+
 forward_progress_guaranteed:
 	/*
 	 * Here, every runnable task is guaranteed to make forward progress and
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 3597b7b5829e..e9ec267f13d5 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -94,6 +94,7 @@ void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
 int balance_scx(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
 int scx_check_setscheduler(struct task_struct *p, int policy);
+bool scx_can_stop_tick(struct rq *rq);
 void init_sched_ext_class(void);
 
 __printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
@@ -156,6 +157,7 @@ static inline int balance_scx(struct rq *rq, struct task_struct *prev,
 			      struct rq_flags *rf) { return 0; }
 static inline int scx_check_setscheduler(struct task_struct *p,
 					 int policy) { return 0; }
+static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void init_sched_ext_class(void) {}
 static inline void scx_notify_sched_tick(void) {}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0d8b52c52e2b..a95aae3bc69a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -690,11 +690,17 @@ struct cfs_rq {
 };
 
 #ifdef CONFIG_SCHED_CLASS_EXT
+/* scx_rq->flags, protected by the rq lock */
+enum scx_rq_flags {
+	SCX_RQ_CAN_STOP_TICK	= 1 << 0,
+};
+
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
 	struct list_head	watchdog_list;
 	u64			ops_qseq;
 	u32			nr_running;
+	u32			flags;
 #ifdef CONFIG_SMP
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
diff --git a/tools/sched_ext/scx_example_central.bpf.c b/tools/sched_ext/scx_example_central.bpf.c
index f53ed4baf92d..ce994e9ecc92 100644
--- a/tools/sched_ext/scx_example_central.bpf.c
+++ b/tools/sched_ext/scx_example_central.bpf.c
@@ -14,7 +14,26 @@
  *    utilize and verify various scx mechanisms such as LOCAL_ON dispatching and
  *    consume_final().
  *
- * b. Preemption
+ * b. Tickless operation
+ *
+ *    All tasks are dispatched with the infinite slice which allows stopping the
+ *    ticks on CONFIG_NO_HZ_FULL kernels running with the proper nohz_full
+ *    parameter. The tickless operation can be observed through
+ *    /proc/interrupts.
+ *
+ *    Periodic switching is enforced by a periodic timer checking all CPUs and
+ *    preempting them as necessary. Unfortunately, BPF timer currently doesn't
+ *    have a way to pin to a specific CPU, so the periodic timer isn't pinned to
+ *    the central CPU.
+ *
+ * c. Preemption
+ *
+ *    Kthreads are unconditionally queued to the head of a matching local dsq
+ *    and dispatched with SCX_DSQ_PREEMPT. This ensures that a kthread is always
+ *    prioritized over user threads, which is required for ensuring forward
+ *    progress as e.g. the periodic timer may run on a ksoftirqd and if the
+ *    ksoftirqd gets starved by a user thread, there may not be anything else to
+ *    vacate that user thread.
  *
  *    SCX_KICK_PREEMPT is used to trigger scheduling and CPUs to move to the
  *    next tasks.
@@ -38,8 +57,18 @@ const volatile bool switch_all;
 const volatile s32 central_cpu;
 const volatile u32 nr_cpu_ids;
 
+/*
+ * XXX - kernel should be able to shut down the associated timers. For now,
+ * implement it manually. They should be bool but the verifier gets confused
+ * about the value range of bool variables when verifying the return value of
+ * the loopfns. Also, they can't be static because verification fails with BTF
+ * error message for some reason.
+ */
+int timer_running;
+int timer_kill;
+
 u64 nr_total, nr_locals, nr_queued, nr_lost_pids;
-u64 nr_dispatches, nr_mismatches, nr_overflows;
+u64 nr_timers, nr_dispatches, nr_mismatches, nr_overflows;
 
 struct user_exit_info uei;
 
@@ -51,6 +80,7 @@ struct {
 
 /* can't use percpu map due to bad lookups */
 static bool cpu_gimme_task[MAX_CPUS];
+static u64 cpu_started_at[MAX_CPUS];
 
 struct central_timer {
 	struct bpf_timer timer;
@@ -86,9 +116,22 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
 
 	__sync_fetch_and_add(&nr_total, 1);
 
+	/*
+	 * Push per-cpu kthreads at the head of local dsq's and preempt the
+	 * corresponding CPU. This ensures that e.g. ksoftirqd isn't blocked
+	 * behind other threads which is necessary for forward progress
+	 * guarantee as we depend on the BPF timer which may run from ksoftirqd.
+	 */
+	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+		__sync_fetch_and_add(&nr_locals, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_INF,
+				 enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
 	if (bpf_map_push_elem(&central_q, &pid, 0)) {
 		__sync_fetch_and_add(&nr_overflows, 1);
-		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, enq_flags);
+		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, enq_flags);
 		return;
 	}
 
@@ -122,12 +165,12 @@ static int dispatch_a_task_loopfn(u32 idx, void *data)
 	 */
 	if (!scx_bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
 		__sync_fetch_and_add(&nr_mismatches, 1);
-		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, 0);
+		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
 		return 0;
 	}
 
 	/* dispatch to the local and mark that @cpu doesn't need more tasks */
-	scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+	scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_INF, 0);
 
 	if (cpu != central_cpu)
 		scx_bpf_kick_cpu(cpu, 0);
@@ -196,16 +239,119 @@ void BPF_STRUCT_OPS(central_consume_final, s32 cpu)
 		scx_bpf_consume(FALLBACK_DSQ_ID);
 }
 
+void BPF_STRUCT_OPS(central_running, struct task_struct *p)
+{
+	s32 cpu = scx_bpf_task_cpu(p);
+	u64 *started_at = MEMBER_VPTR(cpu_started_at, [cpu]);
+	if (started_at)
+		*started_at = bpf_ktime_get_ns() ?: 1;	/* 0 indicates idle */
+}
+
+void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
+{
+	s32 cpu = scx_bpf_task_cpu(p);
+	u64 *started_at = MEMBER_VPTR(cpu_started_at, [cpu]);
+	if (started_at)
+		*started_at = 0;
+}
+
+static int kick_cpus_loopfn(u32 idx, void *data)
+{
+	s32 cpu = (nr_timers + idx) % nr_cpu_ids;
+	u64 *nr_to_kick = data;
+	u64 now = bpf_ktime_get_ns();
+	u64 *started_at;
+	s32 pid;
+
+	if (cpu == central_cpu)
+		goto kick;
+
+	/* kick iff there's something pending */
+	if (scx_bpf_dsq_nr_queued(FALLBACK_DSQ_ID) ||
+	    scx_bpf_dsq_nr_queued(SCX_DSQ_LOCAL_ON | cpu))
+		;
+	else if (*nr_to_kick)
+		(*nr_to_kick)--;
+	else
+		return 0;
+
+	/* and the current one exhausted its slice */
+	started_at = MEMBER_VPTR(cpu_started_at, [cpu]);
+	if (started_at && *started_at &&
+	    vtime_before(now, *started_at + SCX_SLICE_DFL))
+		return 0;
+kick:
+	scx_bpf_kick_cpu(cpu, SCX_KICK_PREEMPT);
+	return 0;
+}
+
+static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
+{
+	u64 nr_to_kick = nr_queued;
+
+	if (timer_kill) {
+		timer_running = 0;
+		return 0;
+	}
+
+	bpf_loop(nr_cpu_ids, kick_cpus_loopfn, &nr_to_kick, 0);
+	bpf_timer_start(timer, TIMER_INTERVAL_NS, 0);
+	__sync_fetch_and_add(&nr_timers, 1);
+	return 0;
+}
+
 int BPF_STRUCT_OPS(central_init)
 {
+	u32 key = 0;
+	struct bpf_timer *timer;
+	int ret;
+
 	if (switch_all)
 		scx_bpf_switch_all();
 
-	return scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+	ret = scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+	if (ret)
+		return ret;
+
+	timer = bpf_map_lookup_elem(&central_timer, &key);
+	if (!timer)
+		return -ESRCH;
+
+	bpf_timer_init(timer, &central_timer, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, central_timerfn);
+	ret = bpf_timer_start(timer, TIMER_INTERVAL_NS, 0);
+	timer_running = !ret;
+	return ret;
+}
+
+static int exit_wait_timer_nested_loopfn(u32 idx, void *data)
+{
+	u64 expiration = *(u64 *)data;
+
+	return !timer_running || vtime_before(expiration, bpf_ktime_get_ns());
+}
+
+static int exit_wait_timer_loopfn(u32 idx, void *data)
+{
+	u64 expiration = *(u64 *)data;
+
+	bpf_loop(1 << 23, exit_wait_timer_nested_loopfn, data, 0);
+	return !timer_running || vtime_before(expiration, bpf_ktime_get_ns());
 }
 
 void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
 {
+	u64 expiration = bpf_ktime_get_ns() + 1000 * MS_TO_NS;
+
+	/*
+	 * XXX - We just need to make sure that the timer body isn't running on
+	 * exit. If we catch the timer while waiting, great. If not, it's still
+	 * highly likely that the timer body won't run in the future. Once bpf
+	 * can shut down associated timers, this hackery should go away.
+	 */
+	timer_kill = 1;
+	bpf_loop(1 << 23, exit_wait_timer_loopfn, &expiration, 0);
+
 	uei_record(&uei, ei);
 }
 
@@ -223,6 +369,8 @@ struct sched_ext_ops central_ops = {
 	.dispatch		= (void *)central_dispatch,
 	.consume		= (void *)central_consume,
 	.consume_final		= (void *)central_consume_final,
+	.running		= (void *)central_running,
+	.stopping		= (void *)central_stopping,
 	.init			= (void *)central_init,
 	.exit			= (void *)central_exit,
 	.name			= "central",
diff --git a/tools/sched_ext/scx_example_central.c b/tools/sched_ext/scx_example_central.c
index c85e84459c58..83cbd1932958 100644
--- a/tools/sched_ext/scx_example_central.c
+++ b/tools/sched_ext/scx_example_central.c
@@ -76,7 +76,8 @@ int main(int argc, char **argv)
 		       skel->bss->nr_locals,
 		       skel->bss->nr_queued,
 		       skel->bss->nr_lost_pids);
-		printf("                 dispatch:%10lu mismatch:%10lu overflow:%10lu\n",
+		printf("timer:%10lu dispatch:%10lu mismatch:%10lu overflow:%10lu\n",
+		       skel->bss->nr_timers,
 		       skel->bss->nr_dispatches,
 		       skel->bss->nr_mismatches,
 		       skel->bss->nr_overflows);
-- 
2.38.1

