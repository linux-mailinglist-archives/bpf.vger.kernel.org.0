Return-Path: <bpf+bounces-73314-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24D2C2A49A
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 08:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2923B36E8
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 07:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29A2C08D9;
	Mon,  3 Nov 2025 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyON2RgD"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F27E2BEC52;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154354; cv=none; b=NAsBn9BPqykX87y693EzfuY7EiZE4APJ+hTg0o3G1ADQR0vCzjR+FdDvaPbCYvCwn89Gutx7I1m6WkGDb9qYt/ZHZp5/WdxudX0gDUDhlccYxrN2YShHkopapKclBCRv4N2bubFHF8+NKT5TkQvVIp+VSuSIKBs+MAslar9IEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154354; c=relaxed/simple;
	bh=X81aag6MYd/nlvSGFwmCKxFSmtiyq0AdPbX8FeBgQYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tc4pUg9Z4vR/qYTGL9ujzfd2eFccCs7SJAvMtGz/18ns3X4Au8Ry6IIiK+EJA0wuxtUmmY6raRPpLjNdvp3iDxW8wGF9ZYcxNr73FyQM1ZMZry83vA5pqWL3eRds53IMvC1FYzf3F9TOVNnvZPd1KIxMnlX4VKBMFtAnwfbrgb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyON2RgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBCDC2BC87;
	Mon,  3 Nov 2025 07:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154354;
	bh=X81aag6MYd/nlvSGFwmCKxFSmtiyq0AdPbX8FeBgQYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gyON2RgDUAeLHHJGCP9w5A4/pn02h9YjgRQ52o7cTdCFP6lFH/dDq+uSIW/RZdWPg
	 VN0ia+zZiojkgojyNS22fthHwjG7/yPvLA5ujV2LvNovdxBfq1GdxOTlBEI4AgftUj
	 6Zhnx9Bj5AfrnjwYWCXRyXXEAZzfwMIhzWNFj1S/FIQVd4oO4lQht+8frZc39xbwm3
	 qNBYslFN7PmCZR2Fdj6McUEfIgZmrhfz6bp4sGzE+J8qMyCjtmyx54heHnpH7572Ey
	 zHAlhAZUf5zbBe275dpYhcCZtP/fMHMWTJJLkZqOV+MJPRmdlHqc8UM3eVeXRIS+ML
	 bHaP6N2EOPKVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BA5FFCE173A; Sun,  2 Nov 2025 15:07:01 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	bpf@vger.kernel.org
Subject: [PATCH 3/9] rcu: Clean up after the SRCU-fastification of RCU Tasks Trace
Date: Sun,  2 Nov 2025 15:06:53 -0800
Message-Id: <20251102230659.3906740-3-paulmck@kernel.org>
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

Now that RCU Tasks Trace has been re-implemented in terms of SRCU-fast,
the ->trc_ipi_to_cpu, ->trc_blkd_cpu, ->trc_blkd_node, ->trc_holdout_list,
and ->trc_reader_special task_struct fields are no longer used.

In addition, the rcu_tasks_trace_qs(), rcu_tasks_trace_qs_blkd(),
exit_tasks_rcu_finish_trace(), and rcu_spawn_tasks_trace_kthread(),
show_rcu_tasks_trace_gp_kthread(), rcu_tasks_trace_get_gp_data(),
rcu_tasks_trace_torture_stats_print(), and get_rcu_tasks_trace_gp_kthread()
functions and all the other functions that they invoke are no longer used.

Also, the TRC_NEED_QS and TRC_NEED_QS_CHECKED CPP macros are no longer used.
Neither are the rcu_tasks_trace_lazy_ms and rcu_task_ipi_delay rcupdate
module parameters and the TASKS_TRACE_RCU_READ_MB Kconfig option.

This commit therefore removes all of them.

[ paulmck: Apply Alexei Starovoitov feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: <bpf@vger.kernel.org>
---
 .../admin-guide/kernel-parameters.txt         | 15 ----
 include/linux/rcupdate.h                      | 31 +-------
 include/linux/rcupdate_trace.h                |  2 -
 include/linux/sched.h                         |  5 --
 init/init_task.c                              |  3 -
 kernel/fork.c                                 |  3 -
 kernel/rcu/Kconfig                            | 18 -----
 kernel/rcu/rcu.h                              |  9 ---
 kernel/rcu/rcuscale.c                         |  7 --
 kernel/rcu/rcutorture.c                       |  2 -
 kernel/rcu/tasks.h                            | 79 +------------------
 .../selftests/rcutorture/configs/rcu/TRACE01  |  1 -
 .../selftests/rcutorture/configs/rcu/TRACE02  |  1 -
 13 files changed, 2 insertions(+), 174 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..40fc198bed4d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6078,13 +6078,6 @@
 			dynamically) adjusted.	This parameter is intended
 			for use in testing.
 
-	rcupdate.rcu_task_ipi_delay= [KNL]
-			Set time in jiffies during which RCU tasks will
-			avoid sending IPIs, starting with the beginning
-			of a given grace period.  Setting a large
-			number avoids disturbing real-time workloads,
-			but lengthens grace periods.
-
 	rcupdate.rcu_task_lazy_lim= [KNL]
 			Number of callbacks on a given CPU that will
 			cancel laziness on that CPU.  Use -1 to disable
@@ -6128,14 +6121,6 @@
 			of zero will disable batching.	Batching is
 			always disabled for synchronize_rcu_tasks().
 
-	rcupdate.rcu_tasks_trace_lazy_ms= [KNL]
-			Set timeout in milliseconds RCU Tasks
-			Trace asynchronous callback batching for
-			call_rcu_tasks_trace().  A negative value
-			will take the default.	A value of zero will
-			disable batching.  Batching is always disabled
-			for synchronize_rcu_tasks_trace().
-
 	rcupdate.rcu_self_test= [KNL]
 			Run the RCU early boot self tests
 
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 120536f4c6eb..2237c56d3241 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -175,36 +175,7 @@ void rcu_tasks_torture_stats_print(char *tt, char *tf);
 # define synchronize_rcu_tasks synchronize_rcu
 # endif
 
-# ifdef CONFIG_TASKS_TRACE_RCU
-// Bits for ->trc_reader_special.b.need_qs field.
-#define TRC_NEED_QS		0x1  // Task needs a quiescent state.
-#define TRC_NEED_QS_CHECKED	0x2  // Task has been checked for needing quiescent state.
-
-u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new);
-void rcu_tasks_trace_qs_blkd(struct task_struct *t);
-
-# define rcu_tasks_trace_qs(t)							\
-	do {									\
-		int ___rttq_nesting = READ_ONCE((t)->trc_reader_nesting);	\
-										\
-		if (unlikely(READ_ONCE((t)->trc_reader_special.b.need_qs) == TRC_NEED_QS) &&	\
-		    likely(!___rttq_nesting)) {					\
-			rcu_trc_cmpxchg_need_qs((t), TRC_NEED_QS, TRC_NEED_QS_CHECKED);	\
-		} else if (___rttq_nesting && ___rttq_nesting != INT_MIN &&	\
-			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
-			rcu_tasks_trace_qs_blkd(t);				\
-		}								\
-	} while (0)
-void rcu_tasks_trace_torture_stats_print(char *tt, char *tf);
-# else
-# define rcu_tasks_trace_qs(t) do { } while (0)
-# endif
-
-#define rcu_tasks_qs(t, preempt)					\
-do {									\
-	rcu_tasks_classic_qs((t), (preempt));				\
-	rcu_tasks_trace_qs(t);						\
-} while (0)
+#define rcu_tasks_qs(t, preempt) rcu_tasks_classic_qs((t), (preempt))
 
 # ifdef CONFIG_TASKS_RUDE_RCU
 void synchronize_rcu_tasks_rude(void);
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 3f46cbe67000..0bd47f12ecd1 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -136,9 +136,7 @@ static inline void rcu_barrier_tasks_trace(void)
 }
 
 // Placeholders to enable stepwise transition.
-void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
 void __init rcu_tasks_trace_suppress_unused(void);
-struct task_struct *get_rcu_tasks_trace_gp_kthread(void);
 
 #else
 /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 89d364615552..577fafd22a0e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -940,11 +940,6 @@ struct task_struct {
 #ifdef CONFIG_TASKS_TRACE_RCU
 	int				trc_reader_nesting;
 	struct srcu_ctr __percpu	*trc_reader_scp;
-	int				trc_ipi_to_cpu;
-	union rcu_special		trc_reader_special;
-	struct list_head		trc_holdout_list;
-	struct list_head		trc_blkd_node;
-	int				trc_blkd_cpu;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
 	struct sched_info		sched_info;
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..0c075f3cc8fc 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -165,9 +165,6 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #endif
 #ifdef CONFIG_TASKS_TRACE_RCU
 	.trc_reader_nesting = 0,
-	.trc_reader_special.s = 0,
-	.trc_holdout_list = LIST_HEAD_INIT(init_task.trc_holdout_list),
-	.trc_blkd_node = LIST_HEAD_INIT(init_task.trc_blkd_node),
 #endif
 #ifdef CONFIG_CPUSETS
 	.mems_allowed_seq = SEQCNT_SPINLOCK_ZERO(init_task.mems_allowed_seq,
diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499d..5686d50b62cf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1780,9 +1780,6 @@ static inline void rcu_copy_process(struct task_struct *p)
 #endif /* #ifdef CONFIG_TASKS_RCU */
 #ifdef CONFIG_TASKS_TRACE_RCU
 	p->trc_reader_nesting = 0;
-	p->trc_reader_special.s = 0;
-	INIT_LIST_HEAD(&p->trc_holdout_list);
-	INIT_LIST_HEAD(&p->trc_blkd_node);
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index ceaf6594f634..54b4c4aa553a 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -313,24 +313,6 @@ config RCU_NOCB_CPU_CB_BOOST
 	  Say Y here if you want to set RT priority for offloading kthreads.
 	  Say N here if you are building a !PREEMPT_RT kernel and are unsure.
 
-config TASKS_TRACE_RCU_READ_MB
-	bool "Tasks Trace RCU readers use memory barriers in user and idle"
-	depends on RCU_EXPERT && TASKS_TRACE_RCU
-	default PREEMPT_RT || NR_CPUS < 8
-	help
-	  Use this option to further reduce the number of IPIs sent
-	  to CPUs executing in userspace or idle during tasks trace
-	  RCU grace periods.  Given that a reasonable setting of
-	  the rcupdate.rcu_task_ipi_delay kernel boot parameter
-	  eliminates such IPIs for many workloads, proper setting
-	  of this Kconfig option is important mostly for aggressive
-	  real-time installations and for battery-powered devices,
-	  hence the default chosen above.
-
-	  Say Y here if you hate IPIs.
-	  Say N here if you hate read-side memory barriers.
-	  Take the default if you are unsure.
-
 config RCU_LAZY
 	bool "RCU callback lazy invocation functionality"
 	depends on RCU_NOCB_CPU
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 9cf01832a6c3..dc5d614b372c 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -544,10 +544,6 @@ struct task_struct *get_rcu_tasks_rude_gp_kthread(void);
 void rcu_tasks_rude_get_gp_data(int *flags, unsigned long *gp_seq);
 #endif // # ifdef CONFIG_TASKS_RUDE_RCU
 
-#ifdef CONFIG_TASKS_TRACE_RCU
-void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq);
-#endif
-
 #ifdef CONFIG_TASKS_RCU_GENERIC
 void tasks_cblist_init_generic(void);
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
@@ -673,11 +669,6 @@ void show_rcu_tasks_rude_gp_kthread(void);
 #else
 static inline void show_rcu_tasks_rude_gp_kthread(void) {}
 #endif
-#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_TRACE_RCU)
-void show_rcu_tasks_trace_gp_kthread(void);
-#else
-static inline void show_rcu_tasks_trace_gp_kthread(void) {}
-#endif
 
 #ifdef CONFIG_TINY_RCU
 static inline bool rcu_cpu_beenfullyonline(int cpu) { return true; }
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index b521d0455992..17d038e26b65 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -400,11 +400,6 @@ static void tasks_trace_scale_read_unlock(int idx)
 	rcu_read_unlock_trace();
 }
 
-static void rcu_tasks_trace_scale_stats(void)
-{
-	rcu_tasks_trace_torture_stats_print(scale_type, SCALE_FLAG);
-}
-
 static struct rcu_scale_ops tasks_tracing_ops = {
 	.ptype		= RCU_TASKS_FLAVOR,
 	.init		= rcu_sync_scale_init,
@@ -416,8 +411,6 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 	.gp_barrier	= rcu_barrier_tasks_trace,
 	.sync		= synchronize_rcu_tasks_trace,
 	.exp_sync	= synchronize_rcu_tasks_trace,
-	.rso_gp_kthread	= get_rcu_tasks_trace_gp_kthread,
-	.stats		= IS_ENABLED(CONFIG_TINY_RCU) ? NULL : rcu_tasks_trace_scale_stats,
 	.name		= "tasks-tracing"
 };
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 423c4bddd17c..647af81e0b21 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1182,8 +1182,6 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.exp_sync	= synchronize_rcu_tasks_trace,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
-	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
-	.get_gp_data    = rcu_tasks_trace_get_gp_data,
 	.cbflood_max	= 50000,
 	.irq_capable	= 1,
 	.slow_gps	= 1,
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1fe789c99f36..1249b47f0a8d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -161,11 +161,6 @@ static void tasks_rcu_exit_srcu_stall(struct timer_list *unused);
 static DEFINE_TIMER(tasks_rcu_exit_srcu_stall_timer, tasks_rcu_exit_srcu_stall);
 #endif
 
-/* Avoid IPIing CPUs early in the grace period. */
-#define RCU_TASK_IPI_DELAY (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) ? HZ / 2 : 0)
-static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
-module_param(rcu_task_ipi_delay, int, 0644);
-
 /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
 #define RCU_TASK_BOOT_STALL_TIMEOUT (HZ * 30)
 #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
@@ -800,8 +795,6 @@ static void rcu_tasks_torture_stats_print_generic(struct rcu_tasks *rtp, char *t
 
 #endif // #ifndef CONFIG_TINY_RCU
 
-static void exit_tasks_rcu_finish_trace(struct task_struct *t);
-
 #if defined(CONFIG_TASKS_RCU)
 
 ////////////////////////////////////////////////////////////////////////
@@ -1321,13 +1314,11 @@ void exit_tasks_rcu_finish(void)
 	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 	list_del_init(&t->rcu_tasks_exit_list);
 	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
-
-	exit_tasks_rcu_finish_trace(t);
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
 void exit_tasks_rcu_start(void) { }
-void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
+void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
 
 #ifdef CONFIG_TASKS_RUDE_RCU
@@ -1475,69 +1466,6 @@ void __init rcu_tasks_trace_suppress_unused(void)
 #endif // #ifndef CONFIG_TINY_RCU
 }
 
-/*
- * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
- * the four-byte operand-size restriction of some platforms.
- *
- * Returns the old value, which is often ignored.
- */
-u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
-{
-	return cmpxchg(&t->trc_reader_special.b.need_qs, old, new);
-}
-EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
-
-/* Add a newly blocked reader task to its CPU's list. */
-void rcu_tasks_trace_qs_blkd(struct task_struct *t)
-{
-}
-EXPORT_SYMBOL_GPL(rcu_tasks_trace_qs_blkd);
-
-/* Communicate task state back to the RCU tasks trace stall warning request. */
-struct trc_stall_chk_rdr {
-	int nesting;
-	int ipi_to_cpu;
-	u8 needqs;
-};
-
-/* Report any needed quiescent state for this exiting task. */
-static void exit_tasks_rcu_finish_trace(struct task_struct *t)
-{
-}
-
-int rcu_tasks_trace_lazy_ms = -1;
-module_param(rcu_tasks_trace_lazy_ms, int, 0444);
-
-static int __init rcu_spawn_tasks_trace_kthread(void)
-{
-	return 0;
-}
-
-#if !defined(CONFIG_TINY_RCU)
-void show_rcu_tasks_trace_gp_kthread(void)
-{
-}
-EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
-
-void rcu_tasks_trace_torture_stats_print(char *tt, char *tf)
-{
-}
-EXPORT_SYMBOL_GPL(rcu_tasks_trace_torture_stats_print);
-#endif // !defined(CONFIG_TINY_RCU)
-
-struct task_struct *get_rcu_tasks_trace_gp_kthread(void)
-{
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(get_rcu_tasks_trace_gp_kthread);
-
-void rcu_tasks_trace_get_gp_data(int *flags, unsigned long *gp_seq)
-{
-}
-EXPORT_SYMBOL_GPL(rcu_tasks_trace_get_gp_data);
-
-#else /* #ifdef CONFIG_TASKS_TRACE_RCU */
-static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
 #ifndef CONFIG_TINY_RCU
@@ -1545,7 +1473,6 @@ void show_rcu_tasks_gp_kthreads(void)
 {
 	show_rcu_tasks_classic_gp_kthread();
 	show_rcu_tasks_rude_gp_kthread();
-	show_rcu_tasks_trace_gp_kthread();
 }
 #endif /* #ifndef CONFIG_TINY_RCU */
 
@@ -1684,10 +1611,6 @@ static int __init rcu_init_tasks_generic(void)
 	rcu_spawn_tasks_rude_kthread();
 #endif
 
-#ifdef CONFIG_TASKS_TRACE_RCU
-	rcu_spawn_tasks_trace_kthread();
-#endif
-
 	// Run the self-tests.
 	rcu_tasks_initiate_self_tests();
 
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 85b407467454..18efab346381 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -10,5 +10,4 @@ CONFIG_PROVE_LOCKING=n
 #CHECK#CONFIG_PROVE_RCU=n
 CONFIG_FORCE_TASKS_TRACE_RCU=y
 #CHECK#CONFIG_TASKS_TRACE_RCU=y
-CONFIG_TASKS_TRACE_RCU_READ_MB=y
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
index 9003c56cd764..8da390e82829 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
@@ -9,6 +9,5 @@ CONFIG_PROVE_LOCKING=y
 #CHECK#CONFIG_PROVE_RCU=y
 CONFIG_FORCE_TASKS_TRACE_RCU=y
 #CHECK#CONFIG_TASKS_TRACE_RCU=y
-CONFIG_TASKS_TRACE_RCU_READ_MB=n
 CONFIG_RCU_EXPERT=y
 CONFIG_DEBUG_OBJECTS=y
-- 
2.40.1


