Return-Path: <bpf+bounces-73312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E41C2A4A9
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CCFD4EEF1D
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55542C027D;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5JGQkpL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9EF2BDC16;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154353; cv=none; b=FVQ1CFMQ17tCKAN4XU5dvOZhiuNuuXVHIv1azamW54ukk/+0NK5S6OmTG36XUniD7+VMhIxeE9pYSf0lbcwUSkKoem9kumcHd6vQOw3wzu5pmWT4bcVduRZKTQR+wWkdE0zyDK9sqLExS2eaHllPRQp+jTMN8OTodeT+2fzI9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154353; c=relaxed/simple;
	bh=XzwpBmCbaZN4OAds1CmOcQd+7kvjhlmclTD1kFgOPt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qzof/MAbWpnt8/gbFoUT6LYAj93hwEuZxMleqzuWAjkxaeeoU2qoay4aSGzSxXEd0/rQlGkGxlCWlJfFBMaNJpw76llw/t3t8EDWjqVI4kwvoCcJFQ8SMUUiOUxo2f4MPFlosb/HrNCQFFIIETVhOT/kJe/JJ9dWa54pl19t0JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5JGQkpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F69C16AAE;
	Mon,  3 Nov 2025 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154353;
	bh=XzwpBmCbaZN4OAds1CmOcQd+7kvjhlmclTD1kFgOPt4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q5JGQkpLs3x/u6jGiPmTtlJBQEnpBqh72Hvs9PiuaBvl8/Y0/KYQp03F/fBKekyXc
	 RZMcl/udDfI3LQjuuu5AbyGZpVhwX04rYXke76Yw66xGk/hXfXHUtIAorRCnN8uUDY
	 zVjQlKYpIw3vTaLBD6tlHarJtBqbriIeFXfxaZAoNKICLk0iMCwsaC/vdYpk958Jo/
	 XIlwrJsJCbgeIvXpw7soxu7mRObdSGv3y+piPjK6hqvYBDw4Fh3caxg/uZKsAw4kq5
	 fQu0ye6bgQV9HDUHK7PBjRM0vW7mxPXlXC+Amqr00vs7G8t7h3Ee9w11YbPDo20S0k
	 J05wJ5CWtvX+g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B31FFCE16DB; Sun,  2 Nov 2025 15:07:01 -0800 (PST)
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
Subject: [PATCH 1/9] rcu: Re-implement RCU Tasks Trace in terms of SRCU-fast
Date: Sun,  2 Nov 2025 15:06:51 -0800
Message-Id: <20251102230659.3906740-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
References: <a1e505e4-931b-45cf-8ca7-337442aa598e@paulmck-laptop>
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

This variant places smp_mb() in rcu_read_{,un}lock_trace(), and in the
same place that srcu_read_{,un}lock() would put them. These smp_mb()
calls will be removed on common-case architectures in a later commit.
In the meantime, it serves to enforce ordering between the underlying
srcu_read_{,un}lock_fast() markers and the intervening critical section,
even on architectures that permit attaching tracepoints on regions of
code not watched by RCU.  Such architectures defeat SRCU-fast's use of
implicit single-instruction, interrupts-disabled, and atomic-operation
RCU read-side critical sections, which have no effect when RCU is not
watching.  The aforementioned later commit will insert these smp_mb()
calls only on architectures that have not used noinstr to prevent
attaching tracepoints to code where RCU is not watching.

[ paulmck: Apply kernel test robot, Boqun Feng, and Zqiang feedback. ]
[ paulmck: Split out Tiny SRCU fixes per Andrii Nakryiko feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: kernel test robot <oliver.sang@intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 include/linux/rcupdate_trace.h | 107 ++++--
 include/linux/sched.h          |   1 +
 kernel/rcu/tasks.h             | 621 +--------------------------------
 3 files changed, 99 insertions(+), 630 deletions(-)

diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index e6c44eb428ab..3f46cbe67000 100644
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
index 2b272382673d..89d364615552 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -939,6 +939,7 @@ struct task_struct {
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 	int				trc_reader_nesting;
+	struct srcu_ctr __percpu	*trc_reader_scp;
 	int				trc_ipi_to_cpu;
 	union rcu_special		trc_reader_special;
 	struct list_head		trc_holdout_list;
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2dc044fd126e..1fe789c99f36 100644
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
 
@@ -1453,94 +1452,27 @@ EXPORT_SYMBOL_GPL(rcu_tasks_rude_get_gp_data);
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
+DEFINE_SRCU_FAST(rcu_tasks_trace_srcu_struct);
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
+#ifndef CONFIG_TINY_RCU
+	show_rcu_tasks_generic_gp_kthread(NULL, NULL);
+#endif // #ifndef CONFIG_TINY_RCU
+	rcu_spawn_tasks_kthread_generic(NULL);
+	synchronize_rcu_tasks_generic(NULL);
+	call_rcu_tasks_generic(NULL, NULL, NULL);
+	call_rcu_tasks_iw_wakeup(NULL);
+	cblist_init_generic(NULL);
+#ifndef CONFIG_TINY_RCU
+	rcu_tasks_torture_stats_print_generic(NULL, NULL, NULL, NULL);
+#endif // #ifndef CONFIG_TINY_RCU
 }
 
 /*
@@ -1555,321 +1487,12 @@ u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
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
@@ -1877,241 +1500,39 @@ struct trc_stall_chk_rdr {
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
 }
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
-}
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
 
@@ -2251,10 +1672,6 @@ void __init tasks_cblist_init_generic(void)
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


