Return-Path: <bpf+bounces-69431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D38B963EA
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 16:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75F957A6660
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EDF24EF8C;
	Tue, 23 Sep 2025 14:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY/2XjLy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B124BBE4;
	Tue, 23 Sep 2025 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637323; cv=none; b=WJUM6OfGb+o6PVNHc8mU2SSPocUIizKGu+J9GlmZ0ARd+Mzwl64xavdKu0v6Y9zYtaGWpkAKDbtPbnofvll8J8ji89csd7uw2Z5jdkJDWQojhSsQGGurVOOz0oio9kkHcdbYg0r0HAe1RkEUEs+FpyOFAu1Tt6UbXscg1yurLg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637323; c=relaxed/simple;
	bh=V5+JDdN+fLIW0rZe8ms8PxR0P3GOXR+NvoTDuCl4DmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efb2Vmf0Nb/fzxdphY1Tw5i8muQbXqW+aqmv6fmJ3v+VINEN3ME5Md4ruLnrONjAH0r+oJcOM0pfPjREpLtfka+3huK5JgBvTudYjbfOfgCrxVRbect4CsFgd5Y5+MN74q0icZcQ6To0mpR3ADLuJT5S3lnAwsi/ohTYIsRUBTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY/2XjLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBCBC113D0;
	Tue, 23 Sep 2025 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637323;
	bh=V5+JDdN+fLIW0rZe8ms8PxR0P3GOXR+NvoTDuCl4DmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NY/2XjLyjP8v898z/RuaoHTMLwqR4jOkB1FblDIzwNiyQlYmD1fS/6r5GF1fqodn5
	 74tTiF3nYt/EFfnDSrpeH7NiTtJHt+pOciWMfhF8MbuFpMKIRLsLP0mcO5INDRrfcB
	 sYUqH3wqC+Ie3MUV1q4BD3gFjGUg9MMlqN0tLr78Qg+5EmWMyaPKJBoVHoFN1qyI4x
	 spX/1W3zVaFSnk1xdvAG7blYB2imYeYvF+6VUVJ4dSWuoVXNca5WfAVHINg9G4K6k6
	 VDcskmA+zGBWV/orPn9bHTKIZsqrCAhumemDpAhtFWRj63NbxzdO8r2cGBlA8Jr1jd
	 6l0dgHduAu90Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B5696CE0E5A; Tue, 23 Sep 2025 07:20:37 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	kernel test robot <oliver.sang@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 01/34] rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast
Date: Tue, 23 Sep 2025 07:20:03 -0700
Message-Id: <20250923142036.112290-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit saves more than 500 lines of RCU code by re-implementing
RCU Tasks Trace in terms of SRCU-fast.  Follow-up work will remove
more code that does not cause problems by its presence, but that is no
longer required.

This variant places smp_mb() in rcu_read_{,un}lock_trace(), which will
be removed on common-case architectures in a later commit.

[ paulmck: Apply kernel test robot, Boqun Feng, and Zqiang feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate_trace.h | 107 ++++--
 include/linux/sched.h          |   1 +
 kernel/rcu/srcutiny.c          |  13 +-
 kernel/rcu/tasks.h             | 617 +--------------------------------
 4 files changed, 104 insertions(+), 634 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index e6c44eb428ab63..3f46cbe6700038 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -12,28 +12,28 @@
 #include <linux/rcupdate.h>
 #include <linux/cleanup.h>
 
-extern struct lockdep_map rcu_trace_lock_map;
+#ifdef CONFIG_TASKS_TRACE_RCU
+extern struct srcu_struct rcu_tasks_trace_srcu_struct;
+#endif // #ifdef CONFIG_TASKS_TRACE_RCU
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#if defined(CONFIG_DEBUG_LOCK_ALLOC) && defined(CONFIG_TASKS_TRACE_RCU)
 
 static inline int rcu_read_lock_trace_held(void)
 {
-	return lock_is_held(&rcu_trace_lock_map);
+	return srcu_read_lock_held(&rcu_tasks_trace_srcu_struct);
 }
 
-#else /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+#else // #if defined(CONFIG_DEBUG_LOCK_ALLOC) && defined(CONFIG_TASKS_TRACE_RCU)
 
 static inline int rcu_read_lock_trace_held(void)
 {
 	return 1;
 }
 
-#endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+#endif // #else // #if defined(CONFIG_DEBUG_LOCK_ALLOC) && defined(CONFIG_TASKS_TRACE_RCU)
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
-void rcu_read_unlock_trace_special(struct task_struct *t);
-
 /**
  * rcu_read_lock_trace - mark beginning of RCU-trace read-side critical section
  *
@@ -50,12 +50,14 @@ static inline void rcu_read_lock_trace(void)
 {
 	struct task_struct *t = current;
 
-	WRITE_ONCE(t->trc_reader_nesting, READ_ONCE(t->trc_reader_nesting) + 1);
-	barrier();
-	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
-	    t->trc_reader_special.b.need_mb)
-		smp_mb(); // Pairs with update-side barriers
-	rcu_lock_acquire(&rcu_trace_lock_map);
+	if (t->trc_reader_nesting++) {
+		// In case we interrupted a Tasks Trace RCU reader.
+		rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
+		return;
+	}
+	barrier();  // nesting before scp to protect against interrupt handler.
+	t->trc_reader_scp = srcu_read_lock_fast(&rcu_tasks_trace_srcu_struct);
+	smp_mb(); // Placeholder for more selective ordering
 }
 
 /**
@@ -69,26 +71,75 @@ static inline void rcu_read_lock_trace(void)
  */
 static inline void rcu_read_unlock_trace(void)
 {
-	int nesting;
+	struct srcu_ctr __percpu *scp;
 	struct task_struct *t = current;
 
-	rcu_lock_release(&rcu_trace_lock_map);
-	nesting = READ_ONCE(t->trc_reader_nesting) - 1;
-	barrier(); // Critical section before disabling.
-	// Disable IPI-based setting of .need_qs.
-	WRITE_ONCE(t->trc_reader_nesting, INT_MIN + nesting);
-	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
-		WRITE_ONCE(t->trc_reader_nesting, nesting);
-		return;  // We assume shallow reader nesting.
-	}
-	WARN_ON_ONCE(nesting != 0);
-	rcu_read_unlock_trace_special(t);
+	smp_mb(); // Placeholder for more selective ordering
+	scp = t->trc_reader_scp;
+	barrier();  // scp before nesting to protect against interrupt handler.
+	if (!--t->trc_reader_nesting)
+		srcu_read_unlock_fast(&rcu_tasks_trace_srcu_struct, scp);
+	else
+		srcu_lock_release(&rcu_tasks_trace_srcu_struct.dep_map);
+}
+
+/**
+ * call_rcu_tasks_trace() - Queue a callback trace task-based grace period
+ * @rhp: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a trace rcu-tasks
+ * grace period elapses, in other words after all currently executing
+ * trace rcu-tasks read-side critical sections have completed. These
+ * read-side critical sections are delimited by calls to rcu_read_lock_trace()
+ * and rcu_read_unlock_trace().
+ *
+ * See the description of call_rcu() for more detailed information on
+ * memory ordering guarantees.
+ */
+static inline void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func)
+{
+	call_srcu(&rcu_tasks_trace_srcu_struct, rhp, func);
+}
+
+/**
+ * synchronize_rcu_tasks_trace - wait for a trace rcu-tasks grace period
+ *
+ * Control will return to the caller some time after a trace rcu-tasks
+ * grace period has elapsed, in other words after all currently executing
+ * trace rcu-tasks read-side critical sections have elapsed. These read-side
+ * critical sections are delimited by calls to rcu_read_lock_trace()
+ * and rcu_read_unlock_trace().
+ *
+ * This is a very specialized primitive, intended only for a few uses in
+ * tracing and other situations requiring manipulation of function preambles
+ * and profiling hooks.  The synchronize_rcu_tasks_trace() function is not
+ * (yet) intended for heavy use from multiple CPUs.
+ *
+ * See the description of synchronize_rcu() for more detailed information
+ * on memory ordering guarantees.
+ */
+static inline void synchronize_rcu_tasks_trace(void)
+{
+	synchronize_srcu(&rcu_tasks_trace_srcu_struct);
 }
 
-void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
-void synchronize_rcu_tasks_trace(void);
-void rcu_barrier_tasks_trace(void);
+/**
+ * rcu_barrier_tasks_trace - Wait for in-flight call_rcu_tasks_trace() callbacks.
+ *
+ * Note that rcu_barrier_tasks_trace() is not obligated to actually wait,
+ * for example, if there are no pending callbacks.
+ */
+static inline void rcu_barrier_tasks_trace(void)
+{
+	srcu_barrier(&rcu_tasks_trace_srcu_struct);
+}
+
+// Placeholders to enable stepwise transition.
+void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
+void __init rcu_tasks_trace_suppress_unused(void);
 struct task_struct *get_rcu_tasks_trace_gp_kthread(void);
+
 #else
 /*
  * The BPF JIT forms these addresses even when it doesn't call these
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2b272382673d62..89d3646155525f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -939,6 +939,7 @@ struct task_struct {
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 	int				trc_reader_nesting;
+	struct srcu_ctr __percpu	*trc_reader_scp;
 	int				trc_ipi_to_cpu;
 	union rcu_special		trc_reader_special;
 	struct list_head		trc_holdout_list;
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index e3b64a5e0ec7e1..3450c3751ef7ad 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -106,15 +106,15 @@ void __srcu_read_unlock(struct srcu_struct *ssp, int idx)
 	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) - 1;
 	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
 	preempt_enable();
-	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task())
+	if (!newval && READ_ONCE(ssp->srcu_gp_waiting) && in_task() && !irqs_disabled())
 		swake_up_one(&ssp->srcu_wq);
 }
 EXPORT_SYMBOL_GPL(__srcu_read_unlock);
 
 /*
  * Workqueue handler to drive one grace period and invoke any callbacks
- * that become ready as a result.  Single-CPU and !PREEMPTION operation
- * means that we get away with murder on synchronization.  ;-)
+ * that become ready as a result.  Single-CPU operation and preemption
+ * disabling mean that we get away with murder on synchronization.  ;-)
  */
 void srcu_drive_gp(struct work_struct *wp)
 {
@@ -141,7 +141,12 @@ void srcu_drive_gp(struct work_struct *wp)
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 	WRITE_ONCE(ssp->srcu_gp_waiting, true);  /* srcu_read_unlock() wakes! */
 	preempt_enable();
-	swait_event_exclusive(ssp->srcu_wq, !READ_ONCE(ssp->srcu_lock_nesting[idx]));
+	do {
+		// Deadlock issues prevent __srcu_read_unlock() from
+		// doing an unconditional wakeup, so polling is required.
+		swait_event_timeout_exclusive(ssp->srcu_wq,
+					      !READ_ONCE(ssp->srcu_lock_nesting[idx]), HZ / 10);
+	} while (READ_ONCE(ssp->srcu_lock_nesting[idx]));
 	preempt_disable();  // Needed for PREEMPT_LAZY
 	WRITE_ONCE(ssp->srcu_gp_waiting, false); /* srcu_read_unlock() cheap. */
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2dc044fd126eb0..418fa242cf0288 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -718,7 +718,6 @@ static void __init rcu_tasks_bootup_oddness(void)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
-
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
@@ -803,7 +802,7 @@ static void rcu_tasks_torture_stats_print_generic(struct rcu_tasks *rtp, char *t
 
 static void exit_tasks_rcu_finish_trace(struct task_struct *t);
 
-#if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU)
+#if defined(CONFIG_TASKS_RCU)
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -898,7 +897,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	rtp->postgp_func(rtp);
 }
 
-#endif /* #if defined(CONFIG_TASKS_RCU) || defined(CONFIG_TASKS_TRACE_RCU) */
+#endif /* #if defined(CONFIG_TASKS_RCU) */
 
 #ifdef CONFIG_TASKS_RCU
 
@@ -1453,94 +1452,23 @@ EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
 //
 // Tracing variant of Tasks RCU.  This variant is designed to be used
 // to protect tracing hooks, including those of BPF.  This variant
-// therefore:
-//
-// 1.	Has explicit read-side markers to allow finite grace periods
-//	in the face of in-kernel loops for PREEMPT=n builds.
-//
-// 2.	Protects code in the idle loop, exception entry/exit, and
-//	CPU-hotplug code paths, similar to the capabilities of SRCU.
-//
-// 3.	Avoids expensive read-side instructions, having overhead similar
-//	to that of Preemptible RCU.
-//
-// There are of course downsides.  For example, the grace-period code
-// can send IPIs to CPUs, even when those CPUs are in the idle loop or
-// in nohz_full userspace.  If needed, these downsides can be at least
-// partially remedied.
-//
-// Perhaps most important, this variant of RCU does not affect the vanilla
-// flavors, rcu_preempt and rcu_sched.  The fact that RCU Tasks Trace
-// readers can operate from idle, offline, and exception entry/exit in no
-// way allows rcu_preempt and rcu_sched readers to also do so.
-//
-// The implementation uses rcu_tasks_wait_gp(), which relies on function
-// pointers in the rcu_tasks structure.  The rcu_spawn_tasks_trace_kthread()
-// function sets these function pointers up so that rcu_tasks_wait_gp()
-// invokes these functions in this order:
-//
-// rcu_tasks_trace_pregp_step():
-//	Disables CPU hotplug, adds all currently executing tasks to the
-//	holdout list, then checks the state of all tasks that blocked
-//	or were preempted within their current RCU Tasks Trace read-side
-//	critical section, adding them to the holdout list if appropriate.
-//	Finally, this function re-enables CPU hotplug.
-// The ->pertask_func() pointer is NULL, so there is no per-task processing.
-// rcu_tasks_trace_postscan():
-//	Invokes synchronize_rcu() to wait for late-stage exiting tasks
-//	to finish exiting.
-// check_all_holdout_tasks_trace(), repeatedly until holdout list is empty:
-//	Scans the holdout list, attempting to identify a quiescent state
-//	for each task on the list.  If there is a quiescent state, the
-//	corresponding task is removed from the holdout list.  Once this
-//	list is empty, the grace period has completed.
-// rcu_tasks_trace_postgp():
-//	Provides the needed full memory barrier and does debug checks.
-//
-// The exit_tasks_rcu_finish_trace() synchronizes with exiting tasks.
-//
-// Pre-grace-period update-side code is ordered before the grace period
-// via the ->cbs_lock and barriers in rcu_tasks_kthread().  Pre-grace-period
-// read-side code is ordered before the grace period by atomic operations
-// on .b.need_qs flag of each task involved in this process, or by scheduler
-// context-switch ordering (for locked-down non-running readers).
-
-// The lockdep state must be outside of #ifdef to be useful.
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-static struct lock_class_key rcu_lock_trace_key;
-struct lockdep_map rcu_trace_lock_map =
-	STATIC_LOCKDEP_MAP_INIT("rcu_read_lock_trace", &rcu_lock_trace_key);
-EXPORT_SYMBOL_GPL(rcu_trace_lock_map);
-#endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
+// is implemented via a straightforward mapping onto SRCU-fast.
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
-// Record outstanding IPIs to each CPU.  No point in sending two...
-static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
-
-// The number of detections of task quiescent state relying on
-// heavyweight readers executing explicit memory barriers.
-static unsigned long n_heavy_reader_attempts;
-static unsigned long n_heavy_reader_updates;
-static unsigned long n_heavy_reader_ofl_updates;
-static unsigned long n_trc_holdouts;
+DEFINE_SRCU(rcu_tasks_trace_srcu_struct);
+EXPORT_SYMBOL_GPL(rcu_tasks_trace_srcu_struct);
 
-void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
-		 "RCU Tasks Trace");
-
-/* Load from ->trc_reader_special.b.need_qs with proper ordering. */
-static u8 rcu_ld_need_qs(struct task_struct *t)
+// Placeholder to suppress build errors through transition period.
+void __init rcu_tasks_trace_suppress_unused(void)
 {
-	smp_mb(); // Enforce full grace-period ordering.
-	return smp_load_acquire(&t->trc_reader_special.b.need_qs);
-}
-
-/* Store to ->trc_reader_special.b.need_qs with proper ordering. */
-static void rcu_st_need_qs(struct task_struct *t, u8 v)
-{
-	smp_store_release(&t->trc_reader_special.b.need_qs, v);
-	smp_mb(); // Enforce full grace-period ordering.
+	show_rcu_tasks_generic_gp_kthread(NULL, NULL);
+	rcu_spawn_tasks_kthread_generic(NULL);
+	synchronize_rcu_tasks_generic(NULL);
+	call_rcu_tasks_generic(NULL, NULL, NULL);
+	call_rcu_tasks_iw_wakeup(NULL);
+	cblist_init_generic(NULL);
+	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
 }
 
 /*
@@ -1555,321 +1483,12 @@ u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
 }
 EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
 
-/*
- * If we are the last reader, signal the grace-period kthread.
- * Also remove from the per-CPU list of blocked tasks.
- */
-void rcu_read_unlock_trace_special(struct task_struct *t)
-{
-	unsigned long flags;
-	struct rcu_tasks_percpu *rtpcp;
-	union rcu_special trs;
-
-	// Open-coded full-word version of rcu_ld_need_qs().
-	smp_mb(); // Enforce full grace-period ordering.
-	trs = smp_load_acquire(&t->trc_reader_special);
-
-	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) && t->trc_reader_special.b.need_mb)
-		smp_mb(); // Pairs with update-side barriers.
-	// Update .need_qs before ->trc_reader_nesting for irq/NMI handlers.
-	if (trs.b.need_qs == (TRC_NEED_QS_CHECKED | TRC_NEED_QS)) {
-		u8 result = rcu_trc_cmpxchg_need_qs(t, TRC_NEED_QS_CHECKED | TRC_NEED_QS,
-						       TRC_NEED_QS_CHECKED);
-
-		WARN_ONCE(result != trs.b.need_qs, "%s: result = %d", __func__, result);
-	}
-	if (trs.b.blocked) {
-		rtpcp = per_cpu_ptr(rcu_tasks_trace.rtpcpu, t->trc_blkd_cpu);
-		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-		list_del_init(&t->trc_blkd_node);
-		WRITE_ONCE(t->trc_reader_special.b.blocked, false);
-		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-	}
-	WRITE_ONCE(t->trc_reader_nesting, 0);
-}
-EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
-
 /* Add a newly blocked reader task to its CPU's list. */
 void rcu_tasks_trace_qs_blkd(struct task_struct *t)
 {
-	unsigned long flags;
-	struct rcu_tasks_percpu *rtpcp;
-
-	local_irq_save(flags);
-	rtpcp = this_cpu_ptr(rcu_tasks_trace.rtpcpu);
-	raw_spin_lock_rcu_node(rtpcp); // irqs already disabled
-	t->trc_blkd_cpu = smp_processor_id();
-	if (!rtpcp->rtp_blkd_tasks.next)
-		INIT_LIST_HEAD(&rtpcp->rtp_blkd_tasks);
-	list_add(&t->trc_blkd_node, &rtpcp->rtp_blkd_tasks);
-	WRITE_ONCE(t->trc_reader_special.b.blocked, true);
-	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 }
 EXPORT_SYMBOL_GPL(rcu_tasks_trace_qs_blkd);
 
-/* Add a task to the holdout list, if it is not already on the list. */
-static void trc_add_holdout(struct task_struct *t, struct list_head *bhp)
-{
-	if (list_empty(&t->trc_holdout_list)) {
-		get_task_struct(t);
-		list_add(&t->trc_holdout_list, bhp);
-		n_trc_holdouts++;
-	}
-}
-
-/* Remove a task from the holdout list, if it is in fact present. */
-static void trc_del_holdout(struct task_struct *t)
-{
-	if (!list_empty(&t->trc_holdout_list)) {
-		list_del_init(&t->trc_holdout_list);
-		put_task_struct(t);
-		n_trc_holdouts--;
-	}
-}
-
-/* IPI handler to check task state. */
-static void trc_read_check_handler(void *t_in)
-{
-	int nesting;
-	struct task_struct *t = current;
-	struct task_struct *texp = t_in;
-
-	// If the task is no longer running on this CPU, leave.
-	if (unlikely(texp != t))
-		goto reset_ipi; // Already on holdout list, so will check later.
-
-	// If the task is not in a read-side critical section, and
-	// if this is the last reader, awaken the grace-period kthread.
-	nesting = READ_ONCE(t->trc_reader_nesting);
-	if (likely(!nesting)) {
-		rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
-		goto reset_ipi;
-	}
-	// If we are racing with an rcu_read_unlock_trace(), try again later.
-	if (unlikely(nesting < 0))
-		goto reset_ipi;
-
-	// Get here if the task is in a read-side critical section.
-	// Set its state so that it will update state for the grace-period
-	// kthread upon exit from that critical section.
-	rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED);
-
-reset_ipi:
-	// Allow future IPIs to be sent on CPU and for task.
-	// Also order this IPI handler against any later manipulations of
-	// the intended task.
-	smp_store_release(per_cpu_ptr(&trc_ipi_to_cpu, smp_processor_id()), false); // ^^^
-	smp_store_release(&texp->trc_ipi_to_cpu, -1); // ^^^
-}
-
-/* Callback function for scheduler to check locked-down task.  */
-static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
-{
-	struct list_head *bhp = bhp_in;
-	int cpu = task_cpu(t);
-	int nesting;
-	bool ofl = cpu_is_offline(cpu);
-
-	if (task_curr(t) && !ofl) {
-		// If no chance of heavyweight readers, do it the hard way.
-		if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB))
-			return -EINVAL;
-
-		// If heavyweight readers are enabled on the remote task,
-		// we can inspect its state despite its currently running.
-		// However, we cannot safely change its state.
-		n_heavy_reader_attempts++;
-		// Check for "running" idle tasks on offline CPUs.
-		if (!rcu_watching_zero_in_eqs(cpu, &t->trc_reader_nesting))
-			return -EINVAL; // No quiescent state, do it the hard way.
-		n_heavy_reader_updates++;
-		nesting = 0;
-	} else {
-		// The task is not running, so C-language access is safe.
-		nesting = t->trc_reader_nesting;
-		WARN_ON_ONCE(ofl && task_curr(t) && (t != idle_task(task_cpu(t))));
-		if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) && ofl)
-			n_heavy_reader_ofl_updates++;
-	}
-
-	// If not exiting a read-side critical section, mark as checked
-	// so that the grace-period kthread will remove it from the
-	// holdout list.
-	if (!nesting) {
-		rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
-		return 0;  // In QS, so done.
-	}
-	if (nesting < 0)
-		return -EINVAL; // Reader transitioning, try again later.
-
-	// The task is in a read-side critical section, so set up its
-	// state so that it will update state upon exit from that critical
-	// section.
-	if (!rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED))
-		trc_add_holdout(t, bhp);
-	return 0;
-}
-
-/* Attempt to extract the state for the specified task. */
-static void trc_wait_for_one_reader(struct task_struct *t,
-				    struct list_head *bhp)
-{
-	int cpu;
-
-	// If a previous IPI is still in flight, let it complete.
-	if (smp_load_acquire(&t->trc_ipi_to_cpu) != -1) // Order IPI
-		return;
-
-	// The current task had better be in a quiescent state.
-	if (t == current) {
-		rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
-		WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
-		return;
-	}
-
-	// Attempt to nail down the task for inspection.
-	get_task_struct(t);
-	if (!task_call_func(t, trc_inspect_reader, bhp)) {
-		put_task_struct(t);
-		return;
-	}
-	put_task_struct(t);
-
-	// If this task is not yet on the holdout list, then we are in
-	// an RCU read-side critical section.  Otherwise, the invocation of
-	// trc_add_holdout() that added it to the list did the necessary
-	// get_task_struct().  Either way, the task cannot be freed out
-	// from under this code.
-
-	// If currently running, send an IPI, either way, add to list.
-	trc_add_holdout(t, bhp);
-	if (task_curr(t) &&
-	    time_after(jiffies + 1, rcu_tasks_trace.gp_start + rcu_task_ipi_delay)) {
-		// The task is currently running, so try IPIing it.
-		cpu = task_cpu(t);
-
-		// If there is already an IPI outstanding, let it happen.
-		if (per_cpu(trc_ipi_to_cpu, cpu) || t->trc_ipi_to_cpu >= 0)
-			return;
-
-		per_cpu(trc_ipi_to_cpu, cpu) = true;
-		t->trc_ipi_to_cpu = cpu;
-		rcu_tasks_trace.n_ipis++;
-		if (smp_call_function_single(cpu, trc_read_check_handler, t, 0)) {
-			// Just in case there is some other reason for
-			// failure than the target CPU being offline.
-			WARN_ONCE(1, "%s():  smp_call_function_single() failed for CPU: %d\n",
-				  __func__, cpu);
-			rcu_tasks_trace.n_ipis_fails++;
-			per_cpu(trc_ipi_to_cpu, cpu) = false;
-			t->trc_ipi_to_cpu = -1;
-		}
-	}
-}
-
-/*
- * Initialize for first-round processing for the specified task.
- * Return false if task is NULL or already taken care of, true otherwise.
- */
-static bool rcu_tasks_trace_pertask_prep(struct task_struct *t, bool notself)
-{
-	// During early boot when there is only the one boot CPU, there
-	// is no idle task for the other CPUs.	Also, the grace-period
-	// kthread is always in a quiescent state.  In addition, just return
-	// if this task is already on the list.
-	if (unlikely(t == NULL) || (t == current && notself) || !list_empty(&t->trc_holdout_list))
-		return false;
-
-	rcu_st_need_qs(t, 0);
-	t->trc_ipi_to_cpu = -1;
-	return true;
-}
-
-/* Do first-round processing for the specified task. */
-static void rcu_tasks_trace_pertask(struct task_struct *t, struct list_head *hop)
-{
-	if (rcu_tasks_trace_pertask_prep(t, true))
-		trc_wait_for_one_reader(t, hop);
-}
-
-/* Initialize for a new RCU-tasks-trace grace period. */
-static void rcu_tasks_trace_pregp_step(struct list_head *hop)
-{
-	LIST_HEAD(blkd_tasks);
-	int cpu;
-	unsigned long flags;
-	struct rcu_tasks_percpu *rtpcp;
-	struct task_struct *t;
-
-	// There shouldn't be any old IPIs, but...
-	for_each_possible_cpu(cpu)
-		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
-
-	// Disable CPU hotplug across the CPU scan for the benefit of
-	// any IPIs that might be needed.  This also waits for all readers
-	// in CPU-hotplug code paths.
-	cpus_read_lock();
-
-	// These rcu_tasks_trace_pertask_prep() calls are serialized to
-	// allow safe access to the hop list.
-	for_each_online_cpu(cpu) {
-		rcu_read_lock();
-		// Note that cpu_curr_snapshot() picks up the target
-		// CPU's current task while its runqueue is locked with
-		// an smp_mb__after_spinlock().  This ensures that either
-		// the grace-period kthread will see that task's read-side
-		// critical section or the task will see the updater's pre-GP
-		// accesses.  The trailing smp_mb() in cpu_curr_snapshot()
-		// does not currently play a role other than simplify
-		// that function's ordering semantics.  If these simplified
-		// ordering semantics continue to be redundant, that smp_mb()
-		// might be removed.
-		t = cpu_curr_snapshot(cpu);
-		if (rcu_tasks_trace_pertask_prep(t, true))
-			trc_add_holdout(t, hop);
-		rcu_read_unlock();
-		cond_resched_tasks_rcu_qs();
-	}
-
-	// Only after all running tasks have been accounted for is it
-	// safe to take care of the tasks that have blocked within their
-	// current RCU tasks trace read-side critical section.
-	for_each_possible_cpu(cpu) {
-		rtpcp = per_cpu_ptr(rcu_tasks_trace.rtpcpu, cpu);
-		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-		list_splice_init(&rtpcp->rtp_blkd_tasks, &blkd_tasks);
-		while (!list_empty(&blkd_tasks)) {
-			rcu_read_lock();
-			t = list_first_entry(&blkd_tasks, struct task_struct, trc_blkd_node);
-			list_del_init(&t->trc_blkd_node);
-			list_add(&t->trc_blkd_node, &rtpcp->rtp_blkd_tasks);
-			raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-			rcu_tasks_trace_pertask(t, hop);
-			rcu_read_unlock();
-			raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
-		}
-		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-		cond_resched_tasks_rcu_qs();
-	}
-
-	// Re-enable CPU hotplug now that the holdout list is populated.
-	cpus_read_unlock();
-}
-
-/*
- * Do intermediate processing between task and holdout scans.
- */
-static void rcu_tasks_trace_postscan(struct list_head *hop)
-{
-	// Wait for late-stage exiting tasks to finish exiting.
-	// These might have passed the call to exit_tasks_rcu_finish().
-
-	// If you remove the following line, update rcu_trace_implies_rcu_gp()!!!
-	synchronize_rcu();
-	// Any tasks that exit after this point will set
-	// TRC_NEED_QS_CHECKED in ->trc_reader_special.b.need_qs.
-}
-
 /* Communicate task state back to the RCU tasks trace stall warning request. */
 struct trc_stall_chk_rdr {
 	int nesting;
@@ -1877,241 +1496,39 @@ struct trc_stall_chk_rdr {
 	u8 needqs;
 };
 
-static int trc_check_slow_task(struct task_struct *t, void *arg)
-{
-	struct trc_stall_chk_rdr *trc_rdrp = arg;
-
-	if (task_curr(t) && cpu_online(task_cpu(t)))
-		return false; // It is running, so decline to inspect it.
-	trc_rdrp->nesting = READ_ONCE(t->trc_reader_nesting);
-	trc_rdrp->ipi_to_cpu = READ_ONCE(t->trc_ipi_to_cpu);
-	trc_rdrp->needqs = rcu_ld_need_qs(t);
-	return true;
-}
-
-/* Show the state of a task stalling the current RCU tasks trace GP. */
-static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
-{
-	int cpu;
-	struct trc_stall_chk_rdr trc_rdr;
-	bool is_idle_tsk = is_idle_task(t);
-
-	if (*firstreport) {
-		pr_err("INFO: rcu_tasks_trace detected stalls on tasks:\n");
-		*firstreport = false;
-	}
-	cpu = task_cpu(t);
-	if (!task_call_func(t, trc_check_slow_task, &trc_rdr))
-		pr_alert("P%d: %c%c\n",
-			 t->pid,
-			 ".I"[t->trc_ipi_to_cpu >= 0],
-			 ".i"[is_idle_tsk]);
-	else
-		pr_alert("P%d: %c%c%c%c nesting: %d%c%c cpu: %d%s\n",
-			 t->pid,
-			 ".I"[trc_rdr.ipi_to_cpu >= 0],
-			 ".i"[is_idle_tsk],
-			 ".N"[cpu >= 0 && tick_nohz_full_cpu(cpu)],
-			 ".B"[!!data_race(t->trc_reader_special.b.blocked)],
-			 trc_rdr.nesting,
-			 " !CN"[trc_rdr.needqs & 0x3],
-			 " ?"[trc_rdr.needqs > 0x3],
-			 cpu, cpu_online(cpu) ? "" : "(offline)");
-	sched_show_task(t);
-}
-
-/* List stalled IPIs for RCU tasks trace. */
-static void show_stalled_ipi_trace(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu)
-		if (per_cpu(trc_ipi_to_cpu, cpu))
-			pr_alert("\tIPI outstanding to CPU %d\n", cpu);
-}
-
-/* Do one scan of the holdout list. */
-static void check_all_holdout_tasks_trace(struct list_head *hop,
-					  bool needreport, bool *firstreport)
-{
-	struct task_struct *g, *t;
-
-	// Disable CPU hotplug across the holdout list scan for IPIs.
-	cpus_read_lock();
-
-	list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
-		// If safe and needed, try to check the current task.
-		if (READ_ONCE(t->trc_ipi_to_cpu) == -1 &&
-		    !(rcu_ld_need_qs(t) & TRC_NEED_QS_CHECKED))
-			trc_wait_for_one_reader(t, hop);
-
-		// If check succeeded, remove this task from the list.
-		if (smp_load_acquire(&t->trc_ipi_to_cpu) == -1 &&
-		    rcu_ld_need_qs(t) == TRC_NEED_QS_CHECKED)
-			trc_del_holdout(t);
-		else if (needreport)
-			show_stalled_task_trace(t, firstreport);
-		cond_resched_tasks_rcu_qs();
-	}
-
-	// Re-enable CPU hotplug now that the holdout list scan has completed.
-	cpus_read_unlock();
-
-	if (needreport) {
-		if (*firstreport)
-			pr_err("INFO: rcu_tasks_trace detected stalls? (Late IPI?)\n");
-		show_stalled_ipi_trace();
-	}
-}
-
-static void rcu_tasks_trace_empty_fn(void *unused)
-{
-}
-
-/* Wait for grace period to complete and provide ordering. */
-static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
-{
-	int cpu;
-
-	// Wait for any lingering IPI handlers to complete.  Note that
-	// if a CPU has gone offline or transitioned to userspace in the
-	// meantime, all IPI handlers should have been drained beforehand.
-	// Yes, this assumes that CPUs process IPIs in order.  If that ever
-	// changes, there will need to be a recheck and/or timed wait.
-	for_each_online_cpu(cpu)
-		if (WARN_ON_ONCE(smp_load_acquire(per_cpu_ptr(&trc_ipi_to_cpu, cpu))))
-			smp_call_function_single(cpu, rcu_tasks_trace_empty_fn, NULL, 1);
-
-	smp_mb(); // Caller's code must be ordered after wakeup.
-		  // Pairs with pretty much every ordering primitive.
-}
-
 /* Report any needed quiescent state for this exiting task. */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 {
-	union rcu_special trs = READ_ONCE(t->trc_reader_special);
-
-	rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
-	WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
-	if (WARN_ON_ONCE(rcu_ld_need_qs(t) & TRC_NEED_QS || trs.b.blocked))
-		rcu_read_unlock_trace_special(t);
-	else
-		WRITE_ONCE(t->trc_reader_nesting, 0);
-}
-
-/**
- * call_rcu_tasks_trace() - Queue a callback trace task-based grace period
- * @rhp: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * The callback function will be invoked some time after a trace rcu-tasks
- * grace period elapses, in other words after all currently executing
- * trace rcu-tasks read-side critical sections have completed. These
- * read-side critical sections are delimited by calls to rcu_read_lock_trace()
- * and rcu_read_unlock_trace().
- *
- * See the description of call_rcu() for more detailed information on
- * memory ordering guarantees.
- */
-void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func)
-{
-	call_rcu_tasks_generic(rhp, func, &rcu_tasks_trace);
-}
-EXPORT_SYMBOL_GPL(call_rcu_tasks_trace);
-
-/**
- * synchronize_rcu_tasks_trace - wait for a trace rcu-tasks grace period
- *
- * Control will return to the caller some time after a trace rcu-tasks
- * grace period has elapsed, in other words after all currently executing
- * trace rcu-tasks read-side critical sections have elapsed. These read-side
- * critical sections are delimited by calls to rcu_read_lock_trace()
- * and rcu_read_unlock_trace().
- *
- * This is a very specialized primitive, intended only for a few uses in
- * tracing and other situations requiring manipulation of function preambles
- * and profiling hooks.  The synchronize_rcu_tasks_trace() function is not
- * (yet) intended for heavy use from multiple CPUs.
- *
- * See the description of synchronize_rcu() for more detailed information
- * on memory ordering guarantees.
- */
-void synchronize_rcu_tasks_trace(void)
-{
-	RCU_LOCKDEP_WARN(lock_is_held(&rcu_trace_lock_map), "Illegal synchronize_rcu_tasks_trace() in RCU Tasks Trace read-side critical section");
-	synchronize_rcu_tasks_generic(&rcu_tasks_trace);
 }
-EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_trace);
-
-/**
- * rcu_barrier_tasks_trace - Wait for in-flight call_rcu_tasks_trace() callbacks.
- *
- * Although the current implementation is guaranteed to wait, it is not
- * obligated to, for example, if there are no pending callbacks.
- */
-void rcu_barrier_tasks_trace(void)
-{
-	rcu_barrier_tasks_generic(&rcu_tasks_trace);
-}
-EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
 
 int rcu_tasks_trace_lazy_ms = -1;
 module_param(rcu_tasks_trace_lazy_ms, int, 0444);
 
 static int __init rcu_spawn_tasks_trace_kthread(void)
 {
-	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
-		rcu_tasks_trace.gp_sleep = HZ / 10;
-		rcu_tasks_trace.init_fract = HZ / 10;
-	} else {
-		rcu_tasks_trace.gp_sleep = HZ / 200;
-		if (rcu_tasks_trace.gp_sleep <= 0)
-			rcu_tasks_trace.gp_sleep = 1;
-		rcu_tasks_trace.init_fract = HZ / 200;
-		if (rcu_tasks_trace.init_fract <= 0)
-			rcu_tasks_trace.init_fract = 1;
-	}
-	if (rcu_tasks_trace_lazy_ms >= 0)
-		rcu_tasks_trace.lazy_jiffies = msecs_to_jiffies(rcu_tasks_trace_lazy_ms);
-	rcu_tasks_trace.pregp_func = rcu_tasks_trace_pregp_step;
-	rcu_tasks_trace.postscan_func = rcu_tasks_trace_postscan;
-	rcu_tasks_trace.holdouts_func = check_all_holdout_tasks_trace;
-	rcu_tasks_trace.postgp_func = rcu_tasks_trace_postgp;
-	rcu_spawn_tasks_kthread_generic(&rcu_tasks_trace);
 	return 0;
 }
 
 #if !defined(CONFIG_TINY_RCU)
 void show_rcu_tasks_trace_gp_kthread(void)
 {
-	char buf[64];
-
-	snprintf(buf, sizeof(buf), "N%lu h:%lu/%lu/%lu",
-		data_race(n_trc_holdouts),
-		data_race(n_heavy_reader_ofl_updates),
-		data_race(n_heavy_reader_updates),
-		data_race(n_heavy_reader_attempts));
-	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
 EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
 
 void rcu_tasks_trace_torture_stats_print(char *tt, char *tf)
 {
-	rcu_tasks_torture_stats_print_generic(&rcu_tasks_trace, tt, tf, "");
 }
 EXPORT_SYMBOL_GPL(rcu_tasks_trace_torture_stats_print);
 #endif // !defined(CONFIG_TINY_RCU)
 
 struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
 {
-	return rcu_tasks_trace.kthread_ptr;
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
 
 void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
 {
-	*flags = 0;
-	*gp_seq = rcu_seq_current(&rcu_tasks_trace.tasks_gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
 
@@ -2251,10 +1668,6 @@ void __init tasks_cblist_init_generic(void)
 #ifdef CONFIG_TASKS_RUDE_RCU
 	cblist_init_generic(&rcu_tasks_rude);
 #endif
-
-#ifdef CONFIG_TASKS_TRACE_RCU
-	cblist_init_generic(&rcu_tasks_trace);
-#endif
 }
 
 static int __init rcu_init_tasks_generic(void)
-- 
2.40.1


