Return-Path: <bpf+bounces-14854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 701F77E88AA
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 03:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2577B2812F5
	for <lists+bpf@lfdr.de>; Sat, 11 Nov 2023 02:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5CC5399;
	Sat, 11 Nov 2023 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao9OEZg0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ACD568A
	for <bpf@vger.kernel.org>; Sat, 11 Nov 2023 02:51:56 +0000 (UTC)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAD55247;
	Fri, 10 Nov 2023 18:49:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b2018a11efso2772987b3a.0;
        Fri, 10 Nov 2023 18:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670979; x=1700275779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te+kPxI9lh4mFJWJTpGGrtacyjc+m0G6xtIkyqXkvq4=;
        b=Ao9OEZg0YhkjdIXVarz6jrhwx/qEsddDEPrJSQojshWX2Q6Ma0GItbTL1loxoEGIJN
         ZDQjBjlvK/eWgND0HVPsMuMdnINpOC+BCmednEUEN9PuLgnE6N8f+IxjPgI/dUIiqV8s
         SgG+VnFujhZUmfmDQ86//80epNK6+5+vGxyvNq6kzpQLnNBwwSsWJPej+dLkzy8Y5SnK
         6a41a7hXLwYDQJGP5R77TOEIfhmjtKn1q8fenihocmBMSW5pt529f3VbzdsUWJkobj8w
         vJRmmJ8ut+8x1PnCR4qm0P+AX7nRIOHzU/wiA+wuLEme0nHEs0juTi/1i1FsvV0a3jIO
         wkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670979; x=1700275779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=te+kPxI9lh4mFJWJTpGGrtacyjc+m0G6xtIkyqXkvq4=;
        b=B10jHzoVwvUQ9LOw6igaYPZdae3fOKJ/al9SX4QR7dTg/pqZtDcRfW6Wv58rng/0H3
         eK345r1+fdTvTP80vFALt/9gc21kQJwA7Y1/jgMMa8Zfeb1dpQS/O6YYv/VdTzlJ1DD4
         VqIFF2vcSPi15hkd7jTK787Ng4nhSHfFrDMJ3xu2IqfgccY+B/Ols7hRVTnz8YJJn0E5
         sCxceNZSyoevjQYBi+BvWkaU5gExQigM1vNWnneVgX1gz0b53/n4K0iSfIuWYch1C2vX
         n4YeSLQDvRoRXEDjuUPI3uhyK5/W/5ABGMlweqh2KB9oAXSRGDJz5K2kBvpPw0ZEzq/m
         ADow==
X-Gm-Message-State: AOJu0YxtZGTkTgqiS+nIcCqpiGbBUncA7cl31+UUL/6MPY2Xv5SkAOfd
	lYGjl/tfIf2FDpfdIUGgc9c=
X-Google-Smtp-Source: AGHT+IHmoNFMLbWFFJJafchWZTBbqN7AHi0zHY4bViJp6rCs+R4MNpwNNfTFS2D8ghXcFBDmqKBqLQ==
X-Received: by 2002:a05:6a00:348d:b0:6c0:4006:4195 with SMTP id cp13-20020a056a00348d00b006c040064195mr1208905pfb.0.1699670979393;
        Fri, 10 Nov 2023 18:49:39 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id w12-20020aa7858c000000b006b76cb6523dsm396602pfn.165.2023.11.10.18.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:39 -0800 (PST)
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
Subject: [PATCH 23/36] sched_ext: Implement tickless support
Date: Fri, 10 Nov 2023 16:47:49 -1000
Message-ID: <20231111024835.2164816-24-tj@kernel.org>
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

Allow BPF schedulers to indicate tickless operation by setting p->scx.slice
to SCX_SLICE_INF. A CPU whose current task has infinte slice goes into
tickless operation.

scx_central is updated to use tickless operations for all tasks and
instead use a BPF timer to expire slices. This also uses the SCX_ENQ_PREEMPT
and task state tracking added by the previous patches.

Currently, there is no way to pin the timer on the central CPU, so it may
end up on one of the worker CPUs; however, outside of that, the worker CPUs
can go tickless both while running sched_ext tasks and idling.

With schbench running, scx_central shows:

  root@test ~# grep ^LOC /proc/interrupts; sleep 10; grep ^LOC /proc/interrupts
  LOC:     142024        656        664        449   Local timer interrupts
  LOC:     161663        663        665        449   Local timer interrupts

Without it:

  root@test ~ [SIGINT]# grep ^LOC /proc/interrupts; sleep 10; grep ^LOC /proc/interrupts
  LOC:     188778       3142       3793       3993   Local timer interrupts
  LOC:     198993       5314       6323       6438   Local timer interrupts

While scx_central itself is too barebone to be useful as a
production scheduler, a more featureful central scheduler can be built using
the same approach. Google's experience shows that such an approach can have
significant benefits for certain applications such as VM hosting.

v3: * Pin the central scheduler's timer on the central_cpu using
      BPF_F_TIMER_CPU_PIN.

v2: * Convert to BPF inline iterators.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h         |   1 +
 kernel/sched/core.c               |   9 +-
 kernel/sched/ext.c                |  43 ++++++++-
 kernel/sched/ext.h                |   2 +
 kernel/sched/sched.h              |   6 ++
 tools/sched_ext/scx_central.bpf.c | 142 ++++++++++++++++++++++++++++--
 tools/sched_ext/scx_central.c     |  25 +++++-
 7 files changed, 216 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 6d8bcd1490af..771553bfd72a 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -19,6 +19,7 @@ enum scx_consts {
 	SCX_EXIT_MSG_LEN	= 1024,
 
 	SCX_SLICE_DFL		= 20 * NSEC_PER_MSEC,
+	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
 };
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 957ae28a6e3f..a89706a9fdaa 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1232,13 +1232,16 @@ bool sched_can_stop_tick(struct rq *rq)
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
 	/*
 	 * If there is one task and it has CFS runtime bandwidth constraints
 	 * and it's on the cpu now we don't want to stop the tick.
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 6cf088dd9d09..b5adb46731c8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -488,7 +488,8 @@ static void update_curr_scx(struct rq *rq)
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
 
-	curr->scx.slice -= min(curr->scx.slice, delta_exec);
+	if (curr->scx.slice != SCX_SLICE_INF)
+		curr->scx.slice -= min(curr->scx.slice, delta_exec);
 }
 
 static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
@@ -1411,6 +1412,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 		SCX_CALL_OP(SCX_KF_REST, running, p);
 
 	watchdog_unwatch_task(p, true);
+
+	/*
+	 * @p is getting newly scheduled or got kicked after someone updated its
+	 * slice. Refresh whether tick can be stopped. See scx_can_stop_tick().
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
@@ -1993,6 +2008,26 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
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
+	 * @rq can dispatch from different DSQs, so we can't tell whether it
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
@@ -2152,7 +2187,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	struct rhashtable_iter rht_iter;
 	struct scx_dispatch_q *dsq;
 	const char *reason;
-	int i, kind;
+	int i, cpu, kind;
 
 	kind = atomic_read(&scx_exit_kind);
 	while (true) {
@@ -2250,6 +2285,10 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
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
index d246e5c2d3c7..ec253c8ad2be 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -102,6 +102,7 @@ int scx_fork(struct task_struct *p);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
 int scx_check_setscheduler(struct task_struct *p, int policy);
+bool scx_can_stop_tick(struct rq *rq);
 void init_sched_ext_class(void);
 
 __printf(2, 3) void scx_ops_error_kind(enum scx_exit_kind kind,
@@ -162,6 +163,7 @@ static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
 static inline int scx_check_setscheduler(struct task_struct *p,
 					 int policy) { return 0; }
+static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void init_sched_ext_class(void) {}
 static inline void scx_notify_sched_tick(void) {}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fc8e23f94e0a..e3fb35b4b7ad 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -673,12 +673,18 @@ struct cfs_rq {
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
 	unsigned long		ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
+	u32			flags;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
 	struct irq_work		kick_cpus_irq_work;
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index e3f7a7afa5cb..de0577961987 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -13,7 +13,26 @@
  *    through per-CPU BPF queues. The current design is chosen to maximally
  *    utilize and verify various SCX mechanisms such as LOCAL_ON dispatching.
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
@@ -32,6 +51,8 @@ char _license[] SEC("license") = "GPL";
 
 enum {
 	FALLBACK_DSQ_ID		= 0,
+	MS_TO_NS		= 1000LLU * 1000,
+	TIMER_INTERVAL_NS	= 1 * MS_TO_NS,
 };
 
 const volatile bool switch_partial;
@@ -40,7 +61,7 @@ const volatile u32 nr_cpu_ids = 1;	/* !0 for veristat, set during init */
 const volatile u64 slice_ns = SCX_SLICE_DFL;
 
 u64 nr_total, nr_locals, nr_queued, nr_lost_pids;
-u64 nr_dispatches, nr_mismatches, nr_retries;
+u64 nr_timers, nr_dispatches, nr_mismatches, nr_retries;
 u64 nr_overflows;
 
 struct user_exit_info uei;
@@ -53,6 +74,23 @@ struct {
 
 /* can't use percpu map due to bad lookups */
 bool RESIZABLE_ARRAY(data, cpu_gimme_task);
+u64 RESIZABLE_ARRAY(data, cpu_started_at);
+
+struct central_timer {
+	struct bpf_timer timer;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, u32);
+	__type(value, struct central_timer);
+} central_timer SEC(".maps");
+
+static bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
 
 s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
@@ -72,9 +110,22 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
 
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
 
@@ -107,13 +158,13 @@ static bool dispatch_to_cpu(s32 cpu)
 		 */
 		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
 			__sync_fetch_and_add(&nr_mismatches, 1);
-			scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, 0);
+			scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
 			bpf_task_release(p);
 			continue;
 		}
 
 		/* dispatch to local and mark that @cpu doesn't need more */
-		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_INF, 0);
 
 		if (cpu != central_cpu)
 			scx_bpf_kick_cpu(cpu, 0);
@@ -181,12 +232,89 @@ void BPF_STRUCT_OPS(central_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+void BPF_STRUCT_OPS(central_running, struct task_struct *p)
+{
+	s32 cpu = scx_bpf_task_cpu(p);
+	u64 *started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
+	if (started_at)
+		*started_at = bpf_ktime_get_ns() ?: 1;	/* 0 indicates idle */
+}
+
+void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
+{
+	s32 cpu = scx_bpf_task_cpu(p);
+	u64 *started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
+	if (started_at)
+		*started_at = 0;
+}
+
+static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
+{
+	u64 now = bpf_ktime_get_ns();
+	u64 nr_to_kick = nr_queued;
+	s32 i, curr_cpu;
+
+	curr_cpu = bpf_get_smp_processor_id();
+	if (curr_cpu != central_cpu) {
+		scx_bpf_error("Central timer ran on CPU %d, not central CPU %d",
+			      curr_cpu, central_cpu);
+		return 0;
+	}
+
+	bpf_for(i, 0, nr_cpu_ids) {
+		s32 cpu = (nr_timers + i) % nr_cpu_ids;
+		u64 *started_at;
+
+		if (cpu == central_cpu)
+			continue;
+
+		/* kick iff the current one exhausted its slice */
+		started_at = ARRAY_ELEM_PTR(cpu_started_at, cpu, nr_cpu_ids);
+		if (started_at && *started_at &&
+		    vtime_before(now, *started_at + slice_ns))
+			continue;
+
+		/* and there's something pending */
+		if (scx_bpf_dsq_nr_queued(FALLBACK_DSQ_ID) ||
+		    scx_bpf_dsq_nr_queued(SCX_DSQ_LOCAL_ON | cpu))
+			;
+		else if (nr_to_kick)
+			nr_to_kick--;
+		else
+			continue;
+
+		scx_bpf_kick_cpu(cpu, SCX_KICK_PREEMPT);
+	}
+
+	bpf_timer_start(timer, TIMER_INTERVAL_NS, BPF_F_TIMER_CPU_PIN);
+	__sync_fetch_and_add(&nr_timers, 1);
+	return 0;
+}
+
 int BPF_STRUCT_OPS_SLEEPABLE(central_init)
 {
+	u32 key = 0;
+	struct bpf_timer *timer;
+	int ret;
+
 	if (!switch_partial)
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
+	if (bpf_get_smp_processor_id() != central_cpu)
+		return -EINVAL;
+
+	bpf_timer_init(timer, &central_timer, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, central_timerfn);
+	ret = bpf_timer_start(timer, TIMER_INTERVAL_NS, BPF_F_TIMER_CPU_PIN);
+	return ret;
 }
 
 void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
@@ -206,6 +334,8 @@ struct sched_ext_ops central_ops = {
 	.select_cpu		= (void *)central_select_cpu,
 	.enqueue		= (void *)central_enqueue,
 	.dispatch		= (void *)central_dispatch,
+	.running		= (void *)central_running,
+	.stopping		= (void *)central_stopping,
 	.init			= (void *)central_init,
 	.exit			= (void *)central_exit,
 	.name			= "central",
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index d832d55b756e..1e298590091f 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -39,6 +39,7 @@ int main(int argc, char **argv)
 	struct bpf_link *link;
 	__u64 seq = 0;
 	__s32 opt;
+	cpu_set_t *cpuset;
 
 	signal(SIGINT, sigint_handler);
 	signal(SIGTERM, sigint_handler);
@@ -70,9 +71,30 @@ int main(int argc, char **argv)
 
 	/* Resize arrays so their element count is equal to cpu count. */
 	RESIZE_ARRAY(data, cpu_gimme_task, skel->rodata->nr_cpu_ids);
+	RESIZE_ARRAY(data, cpu_started_at, skel->rodata->nr_cpu_ids);
 
 	SCX_BUG_ON(scx_central__load(skel), "Failed to load skel");
 
+	/*
+	 * Affinitize the loading thread to the central CPU, as:
+	 * - That's where the BPF timer is first invoked in the BPF program.
+	 * - We probably don't want this user space component to take up a core
+	 *   from a task that would benefit from avoiding preemption on one of
+	 *   the tickless cores.
+	 *
+	 * Until BPF supports pinning the timer, it's not guaranteed that it
+	 * will always be invoked on the central CPU. In practice, this
+	 * suffices the majority of the time.
+	 */
+	cpuset = CPU_ALLOC(skel->rodata->nr_cpu_ids);
+	SCX_BUG_ON(!cpuset, "Failed to allocate cpuset");
+	CPU_ZERO(cpuset);
+	CPU_SET(skel->rodata->central_cpu, cpuset);
+	SCX_BUG_ON(sched_setaffinity(0, sizeof(cpuset), cpuset),
+		   "Failed to affinitize to central CPU %d (max %d)",
+		   skel->rodata->central_cpu, skel->rodata->nr_cpu_ids - 1);
+	CPU_FREE(cpuset);
+
 	link = bpf_map__attach_struct_ops(skel->maps.central_ops);
 	SCX_BUG_ON(!link, "Failed to attach struct_ops");
 
@@ -83,7 +105,8 @@ int main(int argc, char **argv)
 		       skel->bss->nr_locals,
 		       skel->bss->nr_queued,
 		       skel->bss->nr_lost_pids);
-		printf("                    dispatch:%10lu mismatch:%10lu retry:%10lu\n",
+		printf("timer   :%10lu dispatch:%10lu mismatch:%10lu retry:%10lu\n",
+		       skel->bss->nr_timers,
 		       skel->bss->nr_dispatches,
 		       skel->bss->nr_mismatches,
 		       skel->bss->nr_retries);
-- 
2.42.0


