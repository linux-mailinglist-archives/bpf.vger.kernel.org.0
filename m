Return-Path: <bpf+bounces-50295-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7350CA24D04
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 08:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 434707A3834
	for <lists+bpf@lfdr.de>; Sun,  2 Feb 2025 07:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A844A1DB52D;
	Sun,  2 Feb 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="HBhwp7Ux"
X-Original-To: bpf@vger.kernel.org
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FDD1DB13A
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738482652; cv=none; b=YKzeOUJ3RfewEGIksIYjy5YRO5HdMyv7l9oBGR6oODGsudrTtPcSZKlFG13CLqaH8r2U93VdSOJcNMRQYjah6Rb6/lwvUchfGeZu/LRiw9aaXUaxLzTM8NgdW0d0E7k6IN1U7RGFA6qJaVlkpkYaUe4WjOcCMQ3y/baqVm7360Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738482652; c=relaxed/simple;
	bh=PWitFxZ54++n20Fvewoixq0kH4672fSEUmcyPAdSpzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNtXH91mexrUjcZzsPO+pdhyOtrmBIVmTxr9yiI/832jXl6E7RI23sTMx0g0CluCuIjt1mRW7pTKaTxKWUBb/k/xtQYpnPrAFt3HesotWxp+jROuhsUUTQWAieLdzdsup3Di1p+QTfHbVCUCRnD9uvpVFu/2/OavsxiE8VZT5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=HBhwp7Ux; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 39F581C19E1
	for <bpf@vger.kernel.org>; Sun,  2 Feb 2025 10:50:48 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:to:from:from; s=
	dkim; t=1738482647; x=1739346648; bh=PWitFxZ54++n20Fvewoixq0kH46
	72fSEUmcyPAdSpzo=; b=HBhwp7UxeuCv81xOjZEE7M+c2imGUAQ9Hac2B6U+Pm3
	rVR2VC2EGFLWpolcF0lvuFdQoRLlnaWJDXMDfWC3mA+oQ9b4AiAYMTZYfb1a0BP5
	O7vbUfQaja9pDiMN7ceiVKJg1nRR2yt9a4yRWB6knpCgleIKuA1vDOGlePUydZzw
	=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wTxirT9t-ogN for <bpf@vger.kernel.org>;
	Sun,  2 Feb 2025 10:50:47 +0300 (MSK)
Received: from localhost.localdomain (unknown [87.249.24.51])
	by mail.nppct.ru (Postfix) with ESMTPSA id DBBCE1C242E;
	Sun,  2 Feb 2025 10:50:23 +0300 (MSK)
From: Alexey Nepomnyashih <sdl@nppct.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1 13/16] rcu: Make call_rcu() lazy to save power
Date: Sun,  2 Feb 2025 07:46:50 +0000
Message-ID: <20250202074709.932174-14-sdl@nppct.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250202074709.932174-1-sdl@nppct.ru>
References: <20250202074709.932174-1-sdl@nppct.ru>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

commit 3cb278e73be58bfb780ecd55129296d2f74c1fb7 upstream.

Implement timer-based RCU callback batching (also known as lazy
callbacks). With this we save about 5-10% of power consumed due
to RCU requests that happen when system is lightly loaded or idle.

By default, all async callbacks (queued via call_rcu) are marked
lazy. An alternate API call_rcu_hurry() is provided for the few users,
for example synchronize_rcu(), that need the old behavior.

The batch is flushed whenever a certain amount of time has passed, or
the batch on a particular CPU grows too big. Also memory pressure will
flush it in a future patch.

To handle several corner cases automagically (such as rcu_barrier() and
hotplug), we re-use bypass lists which were originally introduced to
address lock contention, to handle lazy CBs as well. The bypass list
length has the lazy CB length included in it. A separate lazy CB length
counter is also introduced to keep track of the number of lazy CBs.

[ paulmck: Fix formatting of inline call_rcu_lazy() definition. ]
[ paulmck: Apply Zqiang feedback. ]
[ paulmck: Apply s/call_rcu_flush/call_rcu_hurry/ feedback from Tejun Heo. ]

Suggested-by: Paul McKenney <paulmck@kernel.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
---
 include/linux/rcupdate.h |   9 +++
 kernel/rcu/Kconfig       |   8 ++
 kernel/rcu/rcu.h         |   8 ++
 kernel/rcu/tiny.c        |   2 +-
 kernel/rcu/tree.c        | 129 ++++++++++++++++++++-----------
 kernel/rcu/tree.h        |  11 ++-
 kernel/rcu/tree_exp.h    |   2 +-
 kernel/rcu/tree_nocb.h   | 162 +++++++++++++++++++++++++++++++--------
 8 files changed, 248 insertions(+), 83 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 6858cae98da9..96af37b312e9 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -109,6 +109,15 @@ static inline int rcu_preempt_depth(void)
 
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
+#ifdef CONFIG_RCU_LAZY
+void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func);
+#else
+static inline void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
+{
+	call_rcu(head, func);
+}
+#endif
+
 /* Internal to kernel */
 void rcu_init(void);
 extern int rcu_scheduler_active;
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index d471d22a5e21..d78f6181c8aa 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -311,4 +311,12 @@ config TASKS_TRACE_RCU_READ_MB
 	  Say N here if you hate read-side memory barriers.
 	  Take the default if you are unsure.
 
+config RCU_LAZY
+	bool "RCU callback lazy invocation functionality"
+	depends on RCU_NOCB_CPU
+	default n
+	help
+	  To save power, batch RCU callbacks and flush after delay, memory
+	  pressure, or callback list growing too big.
+
 endmenu # "RCU Subsystem"
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 49ff955ed203..af6a06b86298 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -481,6 +481,14 @@ enum rcutorture_type {
 	INVALID_RCU_FLAVOR
 };
 
+#if defined(CONFIG_RCU_LAZY)
+unsigned long rcu_lazy_get_jiffies_till_flush(void);
+void rcu_lazy_set_jiffies_till_flush(unsigned long j);
+#else
+static inline unsigned long rcu_lazy_get_jiffies_till_flush(void) { return 0; }
+static inline void rcu_lazy_set_jiffies_till_flush(unsigned long j) { }
+#endif
+
 #if defined(CONFIG_TREE_RCU)
 void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 			    unsigned long *gp_seq);
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 21c040cba4bd..a767c78fdba9 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -44,7 +44,7 @@ static struct rcu_ctrlblk rcu_ctrlblk = {
 
 void rcu_barrier(void)
 {
-	wait_rcu_gp(call_rcu);
+	wait_rcu_gp(call_rcu_hurry);
 }
 EXPORT_SYMBOL(rcu_barrier);
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 664ebd2da252..b135bfac923d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2777,47 +2777,8 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
-/**
- * call_rcu() - Queue an RCU callback for invocation after a grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * The callback function will be invoked some time after a full grace
- * period elapses, in other words after all pre-existing RCU read-side
- * critical sections have completed.  However, the callback function
- * might well execute concurrently with RCU read-side critical sections
- * that started after call_rcu() was invoked.
- *
- * RCU read-side critical sections are delimited by rcu_read_lock()
- * and rcu_read_unlock(), and may be nested.  In addition, but only in
- * v5.0 and later, regions of code across which interrupts, preemption,
- * or softirqs have been disabled also serve as RCU read-side critical
- * sections.  This includes hardware interrupt handlers, softirq handlers,
- * and NMI handlers.
- *
- * Note that all CPUs must agree that the grace period extended beyond
- * all pre-existing RCU read-side critical section.  On systems with more
- * than one CPU, this means that when "func()" is invoked, each CPU is
- * guaranteed to have executed a full memory barrier since the end of its
- * last RCU read-side critical section whose beginning preceded the call
- * to call_rcu().  It also means that each CPU executing an RCU read-side
- * critical section that continues beyond the start of "func()" must have
- * executed a memory barrier after the call_rcu() but before the beginning
- * of that RCU read-side critical section.  Note that these guarantees
- * include CPUs that are offline, idle, or executing in user mode, as
- * well as CPUs that are executing in the kernel.
- *
- * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
- * resulting RCU callback function "func()", then both CPU A and CPU B are
- * guaranteed to execute a full memory barrier during the time interval
- * between the call to call_rcu() and the invocation of "func()" -- even
- * if CPU A and CPU B are the same CPU (but again only if the system has
- * more than one CPU).
- *
- * Implementation of these memory-ordering guarantees is described here:
- * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
- */
-void call_rcu(struct rcu_head *head, rcu_callback_t func)
+static void
+__call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy)
 {
 	static atomic_t doublefrees;
 	unsigned long flags;
@@ -2858,7 +2819,7 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
+	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
@@ -2880,8 +2841,84 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 		local_irq_restore(flags);
 	}
 }
-EXPORT_SYMBOL_GPL(call_rcu);
 
+#ifdef CONFIG_RCU_LAZY
+/**
+ * call_rcu_hurry() - Queue RCU callback for invocation after grace period, and
+ * flush all lazy callbacks (including the new one) to the main ->cblist while
+ * doing so.
+ *
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all pre-existing RCU read-side
+ * critical sections have completed.
+ *
+ * Use this API instead of call_rcu() if you don't want the callback to be
+ * invoked after very long periods of time, which can happen on systems without
+ * memory pressure and on systems which are lightly loaded or mostly idle.
+ * This function will cause callbacks to be invoked sooner than later at the
+ * expense of extra power. Other than that, this function is identical to, and
+ * reuses call_rcu()'s logic. Refer to call_rcu() for more details about memory
+ * ordering and other functionality.
+ */
+void call_rcu_hurry(struct rcu_head *head, rcu_callback_t func)
+{
+	return __call_rcu_common(head, func, false);
+}
+EXPORT_SYMBOL_GPL(call_rcu_hurry);
+#endif
+
+/**
+ * call_rcu() - Queue an RCU callback for invocation after a grace period.
+ * By default the callbacks are 'lazy' and are kept hidden from the main
+ * ->cblist to prevent starting of grace periods too soon.
+ * If you desire grace periods to start very soon, use call_rcu_hurry().
+ *
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual callback function to be invoked after the grace period
+ *
+ * The callback function will be invoked some time after a full grace
+ * period elapses, in other words after all pre-existing RCU read-side
+ * critical sections have completed.  However, the callback function
+ * might well execute concurrently with RCU read-side critical sections
+ * that started after call_rcu() was invoked.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock()
+ * and rcu_read_unlock(), and may be nested.  In addition, but only in
+ * v5.0 and later, regions of code across which interrupts, preemption,
+ * or softirqs have been disabled also serve as RCU read-side critical
+ * sections.  This includes hardware interrupt handlers, softirq handlers,
+ * and NMI handlers.
+ *
+ * Note that all CPUs must agree that the grace period extended beyond
+ * all pre-existing RCU read-side critical section.  On systems with more
+ * than one CPU, this means that when "func()" is invoked, each CPU is
+ * guaranteed to have executed a full memory barrier since the end of its
+ * last RCU read-side critical section whose beginning preceded the call
+ * to call_rcu().  It also means that each CPU executing an RCU read-side
+ * critical section that continues beyond the start of "func()" must have
+ * executed a memory barrier after the call_rcu() but before the beginning
+ * of that RCU read-side critical section.  Note that these guarantees
+ * include CPUs that are offline, idle, or executing in user mode, as
+ * well as CPUs that are executing in the kernel.
+ *
+ * Furthermore, if CPU A invoked call_rcu() and CPU B invoked the
+ * resulting RCU callback function "func()", then both CPU A and CPU B are
+ * guaranteed to execute a full memory barrier during the time interval
+ * between the call to call_rcu() and the invocation of "func()" -- even
+ * if CPU A and CPU B are the same CPU (but again only if the system has
+ * more than one CPU).
+ *
+ * Implementation of these memory-ordering guarantees is described here:
+ * Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst.
+ */
+void call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	return __call_rcu_common(head, func, IS_ENABLED(CONFIG_RCU_LAZY));
+}
+EXPORT_SYMBOL_GPL(call_rcu);
 
 /* Maximum number of jiffies to wait before draining a batch. */
 #define KFREE_DRAIN_JIFFIES (5 * HZ)
@@ -3575,7 +3612,7 @@ void synchronize_rcu(void)
 		if (rcu_gp_is_expedited())
 			synchronize_rcu_expedited();
 		else
-			wait_rcu_gp(call_rcu);
+			wait_rcu_gp(call_rcu_hurry);
 		return;
 	}
 
@@ -3978,7 +4015,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	 * if it's fully lazy.
 	 */
 	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
 	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
@@ -4417,7 +4454,7 @@ void rcutree_migrate_callbacks(int cpu)
 	my_rdp = this_cpu_ptr(&rcu_data);
 	my_rnp = my_rdp->mynode;
 	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false));
 	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
 	/* Leverage recent GPs and set GP for new callbacks. */
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 43babe7b1fbf..6f63d2239946 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -262,14 +262,16 @@ struct rcu_data {
 	unsigned long last_fqs_resched;	/* Time of last rcu_resched(). */
 	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
 
+	long lazy_len;			/* Length of buffered lazy callbacks. */
 	int cpu;
 };
 
 /* Values for nocb_defer_wakeup field in struct rcu_data. */
 #define RCU_NOCB_WAKE_NOT	0
 #define RCU_NOCB_WAKE_BYPASS	1
-#define RCU_NOCB_WAKE		2
-#define RCU_NOCB_WAKE_FORCE	3
+#define RCU_NOCB_WAKE_LAZY	2
+#define RCU_NOCB_WAKE		3
+#define RCU_NOCB_WAKE_FORCE	4
 
 #define RCU_JIFFIES_TILL_FORCE_QS (1 + (HZ > 250) + (HZ > 500))
 					/* For jiffies_till_first_fqs and */
@@ -444,9 +446,10 @@ static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j);
+				  unsigned long j, bool lazy);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags);
+				bool *was_alldone, unsigned long flags,
+				bool lazy);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 75e8d9652f7b..6f69b4cc21ea 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -953,7 +953,7 @@ void synchronize_rcu_expedited(void)
 
 	/* If expedited grace periods are prohibited, fall back to normal. */
 	if (rcu_gp_is_normal()) {
-		wait_rcu_gp(call_rcu);
+		wait_rcu_gp(call_rcu_hurry);
 		return;
 	}
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index e8027f4d441c..64cddf559dd2 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -241,6 +241,31 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
 }
 
+/*
+ * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
+ * can elapse before lazy callbacks are flushed. Lazy callbacks
+ * could be flushed much earlier for a number of other reasons
+ * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
+ * left unsubmitted to RCU after those many jiffies.
+ */
+#define LAZY_FLUSH_JIFFIES (10 * HZ)
+static unsigned long jiffies_till_flush = LAZY_FLUSH_JIFFIES;
+
+#ifdef CONFIG_RCU_LAZY
+// To be called only from test code.
+void rcu_lazy_set_jiffies_till_flush(unsigned long jif)
+{
+	jiffies_till_flush = jif;
+}
+EXPORT_SYMBOL(rcu_lazy_set_jiffies_till_flush);
+
+unsigned long rcu_lazy_get_jiffies_till_flush(void)
+{
+	return jiffies_till_flush;
+}
+EXPORT_SYMBOL(rcu_lazy_get_jiffies_till_flush);
+#endif
+
 /*
  * Arrange to wake the GP kthread for this NOCB group at some future
  * time when it is safe to do so.
@@ -254,10 +279,14 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 
 	/*
-	 * Bypass wakeup overrides previous deferments. In case
-	 * of callback storm, no need to wake up too early.
+	 * Bypass wakeup overrides previous deferments. In case of
+	 * callback storms, no need to wake up too early.
 	 */
-	if (waketype == RCU_NOCB_WAKE_BYPASS) {
+	if (waketype == RCU_NOCB_WAKE_LAZY &&
+	    rdp->nocb_defer_wakeup == RCU_NOCB_WAKE_NOT) {
+		mod_timer(&rdp_gp->nocb_timer, jiffies + jiffies_till_flush);
+		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
+	} else if (waketype == RCU_NOCB_WAKE_BYPASS) {
 		mod_timer(&rdp_gp->nocb_timer, jiffies + 2);
 		WRITE_ONCE(rdp_gp->nocb_defer_wakeup, waketype);
 	} else {
@@ -278,10 +307,13 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
  * proves to be initially empty, just return false because the no-CB GP
  * kthread may need to be awakened in this case.
  *
+ * Return true if there was something to be flushed and it succeeded, otherwise
+ * false.
+ *
  * Note that this function always returns true if rhp is NULL.
  */
 static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				     unsigned long j)
+				     unsigned long j, bool lazy)
 {
 	struct rcu_cblist rcl;
 
@@ -295,7 +327,20 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	/* Note: ->cblist.len already accounts for ->nocb_bypass contents. */
 	if (rhp)
 		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
-	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+
+	/*
+	 * If the new CB requested was a lazy one, queue it onto the main
+	 * ->cblist so we can take advantage of a sooner grade period.
+	 */
+	if (lazy && rhp) {
+		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, NULL);
+		rcu_cblist_enqueue(&rcl, rhp);
+		WRITE_ONCE(rdp->lazy_len, 0);
+	} else {
+		rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
+		WRITE_ONCE(rdp->lazy_len, 0);
+	}
+
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
 	rcu_nocb_bypass_unlock(rdp);
@@ -311,13 +356,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
  * Note that this function always returns true if rhp is NULL.
  */
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j)
+				  unsigned long j, bool lazy)
 {
 	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
-	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
+	return rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy);
 }
 
 /*
@@ -330,7 +375,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 	if (!rcu_rdp_is_offloaded(rdp) ||
 	    !rcu_nocb_bypass_trylock(rdp))
 		return;
-	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
+	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
 }
 
 /*
@@ -352,12 +397,14 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
  * there is only one CPU in operation.
  */
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags)
+				bool *was_alldone, unsigned long flags,
+				bool lazy)
 {
 	unsigned long c;
 	unsigned long cur_gp_seq;
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+	bool bypass_is_lazy = (ncbs == READ_ONCE(rdp->lazy_len));
 
 	lockdep_assert_irqs_disabled();
 
@@ -402,24 +449,29 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// If there hasn't yet been all that many ->cblist enqueues
 	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
 	// ->nocb_bypass first.
-	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy) {
+	// Lazy CBs throttle this back and do immediate bypass queuing.
+	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) {
 		rcu_nocb_lock(rdp);
 		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
 		if (*was_alldone)
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstQ"));
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
+
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 		return false; // Caller must enqueue the callback.
 	}
 
 	// If ->nocb_bypass has been used too long or is too full,
 	// flush ->nocb_bypass to ->cblist.
-	if ((ncbs && j != READ_ONCE(rdp->nocb_bypass_first)) ||
+	if ((ncbs && !bypass_is_lazy && j != READ_ONCE(rdp->nocb_bypass_first)) ||
+	    (ncbs &&  bypass_is_lazy &&
+	     (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush))) ||
 	    ncbs >= qhimark) {
 		rcu_nocb_lock(rdp);
-		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
-			*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+
+		if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy)) {
 			if (*was_alldone)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("FirstQ"));
@@ -441,13 +493,24 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
 	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
+
+	if (lazy)
+		WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
+
 	if (!ncbs) {
 		WRITE_ONCE(rdp->nocb_bypass_first, j);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
 	}
 	rcu_nocb_bypass_unlock(rdp);
 	smp_mb(); /* Order enqueue before wake. */
-	if (ncbs) {
+	// A wake up of the grace period kthread or timer adjustment
+	// needs to be done only if:
+	// 1. Bypass list was fully empty before (this is the first
+	//    bypass list entry), or:
+	// 2. Both of these conditions are met:
+	//    a. The bypass list previously had only lazy CBs, and:
+	//    b. The new CB is non-lazy.
+	if (ncbs && (!bypass_is_lazy || lazy)) {
 		local_irq_restore(flags);
 	} else {
 		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
@@ -475,8 +538,10 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 				 unsigned long flags)
 				 __releases(rdp->nocb_lock)
 {
+	long bypass_len;
 	unsigned long cur_gp_seq;
 	unsigned long j;
+	long lazy_len;
 	long len;
 	struct task_struct *t;
 
@@ -490,9 +555,16 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	}
 	// Need to actually to a wakeup.
 	len = rcu_segcblist_n_cbs(&rdp->cblist);
+	bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (was_alldone) {
 		rdp->qlen_last_fqs_check = len;
-		if (!irqs_disabled_flags(flags)) {
+		// Only lazy CBs in bypass list
+		if (lazy_len && bypass_len == lazy_len) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
+					   TPS("WakeLazy"));
+		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			wake_nocb_gp(rdp, false);
@@ -583,12 +655,12 @@ static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
 static void nocb_gp_wait(struct rcu_data *my_rdp)
 {
 	bool bypass = false;
-	long bypass_ncbs;
 	int __maybe_unused cpu = my_rdp->cpu;
 	unsigned long cur_gp_seq;
 	unsigned long flags;
 	bool gotcbs = false;
 	unsigned long j = jiffies;
+	bool lazy = false;
 	bool needwait_gp = false; // This prevents actual uninitialized use.
 	bool needwake;
 	bool needwake_gp;
@@ -618,24 +690,43 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * won't be ignored for long.
 	 */
 	list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
+		long bypass_ncbs;
+		bool flush_bypass = false;
+		long lazy_ncbs;
+
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
 		lockdep_assert_held(&rdp->nocb_lock);
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-		if (bypass_ncbs &&
+		lazy_ncbs = READ_ONCE(rdp->lazy_len);
+
+		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
+		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_till_flush) ||
+		     bypass_ncbs > 2 * qhimark)) {
+			flush_bypass = true;
+		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
 		     bypass_ncbs > 2 * qhimark)) {
-			// Bypass full or old, so flush it.
-			(void)rcu_nocb_try_flush_bypass(rdp, j);
-			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+			flush_bypass = true;
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue; /* No callbacks here, try next. */
 		}
+
+		if (flush_bypass) {
+			// Bypass full or old, so flush it.
+			(void)rcu_nocb_try_flush_bypass(rdp, j);
+			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
+			lazy_ncbs = READ_ONCE(rdp->lazy_len);
+		}
+
 		if (bypass_ncbs) {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
-					    TPS("Bypass"));
-			bypass = true;
+					    bypass_ncbs == lazy_ncbs ? TPS("Lazy") : TPS("Bypass"));
+			if (bypass_ncbs == lazy_ncbs)
+				lazy = true;
+			else
+				bypass = true;
 		}
 		rnp = rdp->mynode;
 
@@ -683,12 +774,20 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	my_rdp->nocb_gp_gp = needwait_gp;
 	my_rdp->nocb_gp_seq = needwait_gp ? wait_gp_seq : 0;
 
-	if (bypass && !rcu_nocb_poll) {
-		// At least one child with non-empty ->nocb_bypass, so set
-		// timer in order to avoid stranding its callbacks.
-		wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
-				   TPS("WakeBypassIsDeferred"));
+	// At least one child with non-empty ->nocb_bypass, so set
+	// timer in order to avoid stranding its callbacks.
+	if (!rcu_nocb_poll) {
+		// If bypass list only has lazy CBs. Add a deferred lazy wake up.
+		if (lazy && !bypass) {
+			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_LAZY,
+					TPS("WakeLazyIsDeferred"));
+		// Otherwise add a deferred bypass wake up.
+		} else if (bypass) {
+			wake_nocb_gp_defer(my_rdp, RCU_NOCB_WAKE_BYPASS,
+					TPS("WakeBypassIsDeferred"));
+		}
 	}
+
 	if (rcu_nocb_poll) {
 		/* Polling, so trace if first poll in the series. */
 		if (gotcbs)
@@ -1014,7 +1113,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 * return false, which means that future calls to rcu_nocb_try_bypass()
 	 * will refuse to put anything into the bypass.
 	 */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
 	/*
 	 * Start with invoking rcu_core() early. This way if the current thread
 	 * happens to preempt an ongoing call to rcu_core() in the middle,
@@ -1268,6 +1367,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 	raw_spin_lock_init(&rdp->nocb_gp_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
 	rcu_cblist_init(&rdp->nocb_bypass);
+	WRITE_ONCE(rdp->lazy_len, 0);
 	mutex_init(&rdp->nocb_gp_kthread_mutex);
 }
 
@@ -1553,13 +1653,13 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 }
 
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j)
+				  unsigned long j, bool lazy)
 {
 	return true;
 }
 
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags)
+				bool *was_alldone, unsigned long flags, bool lazy)
 {
 	return false;
 }
-- 
2.43.0


