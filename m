Return-Path: <bpf+bounces-41166-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB643993BC1
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 02:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB241C246DE
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 00:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900A11C695;
	Tue,  8 Oct 2024 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NNDZv7Rg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121526AA1;
	Tue,  8 Oct 2024 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728347166; cv=none; b=ZauMfpr9lEqDdJcHRjfwoanjpSWeLEKC/THylSK+Nhbwn7VpRPbUop3hZnSUZ3QR7Rg45AmwT/fM/WwW59zpAeC+cIUe/5EOlYC/75/FPgsoylLIMBMbsn250FfA57BV33NCXZ58erpdQX2mFw0nhNE56TSf5BvvW1sMIwqpVy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728347166; c=relaxed/simple;
	bh=XupCaNJafhrIFwQbdJmxocAYFSXoWHij/OIANfTcTPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZMscz8CE6ouYC9KIpp92WqrmgiJenRSO//GLNtxqWpMNkUInWdxn0C7n77FkQ0t8v2ePbwtiNICGaFV0iMoHQMmjln4wex0j9U3e7fGf22GrdEeZnVbpmFaJ2x7kc54GMzOLMOXxk22cJzxItXOc1jhxueponBfKz+MmYiogUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NNDZv7Rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B84FC4CECD;
	Tue,  8 Oct 2024 00:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728347165;
	bh=XupCaNJafhrIFwQbdJmxocAYFSXoWHij/OIANfTcTPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNDZv7RgARXTD+wbgDz64GsDfrPkqBshCGho59YngAaaFXjleUF76LyI8abLN61nP
	 t0HSzXeyOstOnA28bFGcrn2YYyQaakDZCJ1EAaMV+2gcCbwiGu3ROE19pX6MgQHyvN
	 GHzRYOrX/FBT9j6pRXjmMFSm0zQ8Ul2fv/BVt4PaFel5vkCWr30gtZ0kS6MKQUdnTh
	 sXNGF1hshK9z3sx1VYAHyzyPQ78V6IMs4GnoBjcLwYAn2RQ9EcFWID+ThOL36xjHB3
	 A8jIH5qKejA+1vj0/281zaap6lRKs93gpIe+0vPxI/X1exOOMj7cNZXrR/d4Gl84ea
	 mFLeu69XM757Q==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe lifetime (with timeout)
Date: Mon,  7 Oct 2024 17:25:56 -0700
Message-ID: <20241008002556.2332835-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008002556.2332835-1-andrii@kernel.org>
References: <20241008002556.2332835-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid taking refcount on uprobe in prepare_uretprobe(), instead take
uretprobe-specific SRCU lock and keep it active as kernel transfers
control back to user space.

Given we can't rely on user space returning from traced function within
reasonable time period, we need to make sure not to keep SRCU lock
active for too long, though. To that effect, we employ a timer callback
which is meant to terminate SRCU lock region after predefined timeout
(currently set to 100ms), and instead transfer underlying struct
uprobe's lifetime protection to refcounting.

This fallback to less scalable refcounting after 100ms is a fine
tradeoff from uretprobe's scalability and performance perspective,
because uretprobing *long running* user functions inherently doesn't run
into scalability issues (there is just not enough frequency to cause
noticeable issues with either performance or scalability).

The overall trick is in ensuring synchronization between current thread
and timer's callback fired on some other thread. To cope with that with
minimal logic complications, we add hprobe wrapper which is used to
contain all the synchronization related issues behind a small number of
basic helpers: hprobe_expire() for "downgrading" uprobe from SRCU-protected
state to refcounted state, and a hprobe_consume() and hprobe_finalize()
pair of single-use consuming helpers. Other than that, whatever current
thread's logic is there stays the same, as timer thread cannot modify
return_instance state (or add new/remove old return_instances). It only
takes care of SRCU unlock and uprobe refcounting, which is hidden from
the higher-level uretprobe handling logic.

We use atomic xchg() in hprobe_consume(), which is called from
performance critical handle_uretprobe_chain() function run in the
current context. When uncontended, this xchg() doesn't seem to hurt
performance as there are no other competing CPUs fighting for the same
cache line. We also mark struct return_instance as ____cacheline_aligned
to ensure no false sharing can happen.

Another technical moment. We need to make sure that the list of return
instances can be safely traversed under RCU from timer callback, so we
delay return_instance freeing with kfree_rcu() and make sure that list
modifications use RCU-aware operations.

Also, given SRCU lock survives transition from kernel to user space and
back we need to use lower-level __srcu_read_lock() and
__srcu_read_unlock() to avoid lockdep complaining.

Just to give an impression of a kind of performance improvements this
change brings, below are benchmarking results with and without these
SRCU changes, assuming other uprobe optimizations (mainly RCU Tasks
Trace for entry uprobes, lockless RB-tree lookup, and lockless VMA to
uprobe lookup) are left intact:

WITHOUT SRCU for uretprobes
===========================
uretprobe-nop         ( 1 cpus):    2.197 ± 0.002M/s  (  2.197M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.325 ± 0.001M/s  (  1.662M/s/cpu)
uretprobe-nop         ( 3 cpus):    4.129 ± 0.002M/s  (  1.376M/s/cpu)
uretprobe-nop         ( 4 cpus):    6.180 ± 0.003M/s  (  1.545M/s/cpu)
uretprobe-nop         ( 8 cpus):    7.323 ± 0.005M/s  (  0.915M/s/cpu)
uretprobe-nop         (16 cpus):    6.943 ± 0.005M/s  (  0.434M/s/cpu)
uretprobe-nop         (32 cpus):    5.931 ± 0.014M/s  (  0.185M/s/cpu)
uretprobe-nop         (64 cpus):    5.145 ± 0.003M/s  (  0.080M/s/cpu)
uretprobe-nop         (80 cpus):    4.925 ± 0.005M/s  (  0.062M/s/cpu)

WITH SRCU for uretprobes
========================
uretprobe-nop         ( 1 cpus):    1.968 ± 0.001M/s  (  1.968M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.739 ± 0.003M/s  (  1.869M/s/cpu)
uretprobe-nop         ( 3 cpus):    5.616 ± 0.003M/s  (  1.872M/s/cpu)
uretprobe-nop         ( 4 cpus):    7.286 ± 0.002M/s  (  1.822M/s/cpu)
uretprobe-nop         ( 8 cpus):   13.657 ± 0.007M/s  (  1.707M/s/cpu)
uretprobe-nop         (32 cpus):   45.305 ± 0.066M/s  (  1.416M/s/cpu)
uretprobe-nop         (64 cpus):   42.390 ± 0.922M/s  (  0.662M/s/cpu)
uretprobe-nop         (80 cpus):   47.554 ± 2.411M/s  (  0.594M/s/cpu)

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h |  54 +++++++-
 kernel/events/uprobes.c | 292 ++++++++++++++++++++++++++++++++++------
 2 files changed, 305 insertions(+), 41 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2b294bf1881f..05c95abea252 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -15,6 +15,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/timer.h>
 
 struct uprobe;
 struct vm_area_struct;
@@ -56,6 +57,53 @@ enum uprobe_task_state {
 	UTASK_SSTEP_TRAPPED,
 };
 
+/* The state of hybrid-lifetime uprobe inside struct return_instance */
+enum hprobe_state {
+	HPROBE_LEASED,		/* uretprobes_srcu-protected uprobe */
+	HPROBE_STABLE,		/* refcounted uprobe */
+	HPROBE_GONE,		/* NULL uprobe, SRCU expired, refcount failed */
+	HPROBE_CONSUMED,	/* uprobe "consumed" by uretprobe handler */
+};
+
+/*
+ * Hybrid lifetime uprobe. Represents a uprobe instance that could be either
+ * SRCU protected (with SRCU protection eventually potentially timing out),
+ * refcounted using uprobe->ref, or there could be no valid uprobe (NULL).
+ *
+ * hprobe's internal state is setup such that background timer thread can
+ * atomically "downgrade" temporarily RCU-protected uprobe into refcounted one
+ * (or no uprobe, if refcounting failed).
+ *
+ * *stable* pointer always point to the uprobe (or could be NULL if there is
+ * was no valid underlying uprobe to begin with).
+ *
+ * *leased* pointer is the key to achieving race-free atomic lifetime state
+ * transition and can have three possible states:
+ *   - either the same non-NULL value as *stable*, in which case uprobe is
+ *     SRCU-protected;
+ *   - NULL, in which case uprobe (if there is any) is refcounted;
+ *   - special __UPROBE_DEAD value, which represents an uprobe that was SRCU
+ *     protected initially, but SRCU period timed out and we attempted to
+ *     convert it to refcounted, but refcount_inc_not_zero() failed, because
+ *     uprobe effectively went away (the last consumer unsubscribed). In this
+ *     case it's important to know that *stable* pointer (which still has
+ *     non-NULL uprobe pointer) shouldn't be used, because lifetime of
+ *     underlying uprobe is not guaranteed anymore. __UPROBE_DEAD is just an
+ *     internal marker and is handled transparently by hprobe_fetch() helper.
+ *
+ * When uprobe is SRCU-protected, we also record srcu_idx value, necessary for
+ * SRCU unlocking.
+ *
+ * See hprobe_expire() and hprobe_fetch() for details of race-free uprobe
+ * state transitioning details. It all hinges on atomic xchg() over *leaded*
+ * pointer. *stable* pointer, once initially set, is not modified concurrently.
+ */
+struct hprobe {
+	enum hprobe_state state;
+	int srcu_idx;
+	struct uprobe *uprobe;
+};
+
 /*
  * uprobe_task: Metadata of a task while it singlesteps.
  */
@@ -75,6 +123,7 @@ struct uprobe_task {
 	};
 
 	struct uprobe			*active_uprobe;
+	struct timer_list		ri_timer;
 	unsigned long			xol_vaddr;
 
 	struct arch_uprobe              *auprobe;
@@ -84,14 +133,15 @@ struct uprobe_task {
 };
 
 struct return_instance {
-	struct uprobe		*uprobe;
+	struct hprobe		hprobe;
 	unsigned long		func;
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
 
 	struct return_instance	*next;		/* keep as stack */
-};
+	struct rcu_head		rcu;
+} ____cacheline_aligned;
 
 enum rp_check {
 	RP_CHECK_CALL,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 9d3ab472200d..18b5ab949804 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -28,6 +28,7 @@
 #include <linux/khugepaged.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/workqueue.h>
+#include <linux/srcu.h>
 
 #include <linux/uprobes.h>
 
@@ -51,6 +52,9 @@ static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
 
 DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 
+/* Covers return_instance's uprobe lifetime. */
+DEFINE_STATIC_SRCU(uretprobes_srcu);
+
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
@@ -599,13 +603,6 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
 			*(uprobe_opcode_t *)&auprobe->insn);
 }
 
-/* uprobe should have guaranteed positive refcount */
-static struct uprobe *get_uprobe(struct uprobe *uprobe)
-{
-	refcount_inc(&uprobe->ref);
-	return uprobe;
-}
-
 /*
  * uprobe should have guaranteed lifetime, which can be either of:
  *   - caller already has refcount taken (and wants an extra one);
@@ -624,13 +621,20 @@ static inline bool uprobe_is_active(struct uprobe *uprobe)
 	return !RB_EMPTY_NODE(&uprobe->rb_node);
 }
 
-static void uprobe_free_rcu(struct rcu_head *rcu)
+static void uprobe_free_rcu_tasks_trace(struct rcu_head *rcu)
 {
 	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
 
 	kfree(uprobe);
 }
 
+static void uprobe_free_srcu(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe = container_of(rcu, struct uprobe, rcu);
+
+	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu_tasks_trace);
+}
+
 static void uprobe_free_deferred(struct work_struct *work)
 {
 	struct uprobe *uprobe = container_of(work, struct uprobe, work);
@@ -654,7 +658,8 @@ static void uprobe_free_deferred(struct work_struct *work)
 	delayed_uprobe_remove(uprobe, NULL);
 	mutex_unlock(&delayed_uprobe_lock);
 
-	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
+	/* start srcu -> rcu_tasks_trace -> kfree chain */
+	call_srcu(&uretprobes_srcu, &uprobe->rcu, uprobe_free_srcu);
 }
 
 static void put_uprobe(struct uprobe *uprobe)
@@ -666,6 +671,150 @@ static void put_uprobe(struct uprobe *uprobe)
 	schedule_work(&uprobe->work);
 }
 
+/* Initialize hprobe as SRCU-protected "leased" uprobe */
+static void hprobe_init_leased(struct hprobe *hprobe, struct uprobe *uprobe, int srcu_idx)
+{
+	hprobe->state = HPROBE_LEASED;
+	hprobe->uprobe = uprobe;
+	hprobe->srcu_idx = srcu_idx;
+}
+
+/* Initialize hprobe as refcounted ("stable") uprobe (uprobe can be NULL). */
+static void hprobe_init_stable(struct hprobe *hprobe, struct uprobe *uprobe)
+{
+	hprobe->state = HPROBE_STABLE;
+	hprobe->uprobe = uprobe;
+	hprobe->srcu_idx = -1;
+}
+
+/*
+ * hprobe_consume() fetches hprobe's underlying uprobe and detects whether
+ * uprobe is SRCU protected or is refcounted. hprobe_consume() can be
+ * used only once for a given hprobe.
+ *
+ * Caller has to call hprobe_finalize() and pass previous hprobe_state, so
+ * that hprobe_finalize() can perform SRCU unlock or put uprobe, whichever
+ * is appropriate.
+ */
+static inline struct uprobe *hprobe_consume(struct hprobe *hprobe, enum hprobe_state *hstate)
+{
+	enum hprobe_state state;
+
+	*hstate = xchg(&hprobe->state, HPROBE_CONSUMED);
+	switch (*hstate) {
+	case HPROBE_LEASED:
+	case HPROBE_STABLE:
+		return hprobe->uprobe;
+	case HPROBE_GONE:
+		return NULL; /* couldn't refcnt uprobe, it's effectively NULL */
+	case HPROBE_CONSUMED:
+		return NULL; /* uprobe was finalized already, do nothing */
+	default:
+		WARN(1, "hprobe invalid state %d", state);
+		return NULL;
+	}
+}
+
+/*
+ * Reset hprobe state and, if hprobe was LEASED, release SRCU lock.
+ * hprobe_finalize() can only be used from current context after
+ * hprobe_consume() call (which determines uprobe and hstate value).
+ */
+static void hprobe_finalize(struct hprobe *hprobe, enum hprobe_state hstate)
+{
+	switch (hstate) {
+	case HPROBE_LEASED:
+		__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
+		break;
+	case HPROBE_STABLE:
+		if (hprobe->uprobe)
+			put_uprobe(hprobe->uprobe);
+		break;
+	case HPROBE_GONE:
+	case HPROBE_CONSUMED:
+		break;
+	default:
+		WARN(1, "hprobe invalid state %d", hstate);
+		break;
+	}
+}
+
+/*
+ * Attempt to switch (atomically) uprobe from being SRCU protected (LEASED)
+ * to refcounted (STABLE) state. Competes with hprobe_consume(); only one of
+ * them can win the race to perform SRCU unlocking. Whoever wins must perform
+ * SRCU unlock.
+ *
+ * Returns underlying valid uprobe or NULL, if there was no underlying uprobe
+ * to begin with or we failed to bump its refcount and it's going away.
+ *
+ * Returned non-NULL uprobe can be still safely used within an ongoing SRCU
+ * locked region. It's not guaranteed that returned uprobe has a positive
+ * refcount, so caller has to attempt try_get_uprobe(), if it needs to
+ * preserve uprobe beyond current SRCU lock region. See dup_utask().
+ */
+static struct uprobe* hprobe_expire(struct hprobe *hprobe)
+{
+	enum hprobe_state hstate;
+
+	/*
+	 * return_instance's hprobe is protected by RCU.
+	 * Underlying uprobe is itself protected from reuse by SRCU.
+	 */
+	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
+
+	hstate = data_race(READ_ONCE(hprobe->state));
+	switch (hstate) {
+	case HPROBE_STABLE:
+		/* uprobe is properly refcounted, return it */
+		return hprobe->uprobe;
+	case HPROBE_GONE:
+		/*
+		 * SRCU was unlocked earlier and we didn't manage to take
+		 * uprobe refcnt, so it's effectively NULL
+		 */
+		return NULL;
+	case HPROBE_CONSUMED:
+		/*
+		 * uprobe was consumed, so it's effectively NULL as far as
+		 * uretprobe processing logic is concerned
+		 */
+		return NULL;
+	case HPROBE_LEASED: {
+		struct uprobe *uprobe = try_get_uprobe(hprobe->uprobe);
+		/*
+		 * Try to switch hprobe state, guarding against
+		 * hprobe_consume() or another hprobe_expire() racing with us.
+		 * Note, if we failed to get uprobe refcount, we use special
+		 * HPROBE_GONE state to signal that hprobe->uprobe shouldn't
+		 * be used as it will be freed after SRCU is unlocked.
+		 */
+		if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
+			/* We won the race, we are the ones to unlock SRCU */
+			__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
+			return uprobe;
+		}
+
+		/* We lost the race, undo refcount bump (if it ever happened) */
+		if (uprobe)
+			put_uprobe(uprobe);
+		/*
+		 * Even if hprobe_consume() or another hprobe_expire() wins
+		 * the state update race and unlocks SRCU from under us, we
+		 * still have a guarantee that underyling uprobe won't be
+		 * freed due to ongoing caller's SRCU lock region, so we can
+		 * return it regardless. The caller then can attempt its own
+		 * try_get_uprobe() to preserve the instance, if necessary.
+		 * This is used in dup_utask().
+		 */
+		return uprobe;
+	}
+	default:
+		WARN(1, "unknown hprobe state %d", hstate);
+		return NULL;
+	}
+}
+
 static __always_inline
 int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
 	       const struct uprobe *r)
@@ -1168,6 +1317,7 @@ void uprobe_unregister_sync(void)
 	 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
 	 */
 	synchronize_rcu_tasks_trace();
+	synchronize_srcu(&uretprobes_srcu);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
 
@@ -1748,11 +1898,18 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
-static struct return_instance *free_ret_instance(struct return_instance *ri)
+static struct return_instance *free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
 {
 	struct return_instance *next = ri->next;
-	put_uprobe(ri->uprobe);
-	kfree(ri);
+
+	if (cleanup_hprobe) {
+		enum hprobe_state hstate;
+
+		(void)hprobe_consume(&ri->hprobe, &hstate);
+		hprobe_finalize(&ri->hprobe, hstate);
+	}
+
+	kfree_rcu(ri, rcu);
 	return next;
 }
 
@@ -1768,18 +1925,53 @@ void uprobe_free_utask(struct task_struct *t)
 	if (!utask)
 		return;
 
+	timer_delete_sync(&utask->ri_timer);
+
 	if (utask->active_uprobe)
 		put_uprobe(utask->active_uprobe);
 
 	ri = utask->return_instances;
 	while (ri)
-		ri = free_ret_instance(ri);
+		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
 
 	xol_free_insn_slot(t);
 	kfree(utask);
 	t->utask = NULL;
 }
 
+#define RI_TIMER_PERIOD (HZ / 10) /* 100 ms */
+
+#define for_each_ret_instance_rcu(pos, head) \
+	for (pos = rcu_dereference_raw(head); pos; pos = rcu_dereference_raw(pos->next))
+
+static void ri_timer(struct timer_list *timer)
+{
+	struct uprobe_task *utask = container_of(timer, struct uprobe_task, ri_timer);
+	struct return_instance *ri;
+
+	/* SRCU protects uprobe from reuse for the cmpxchg() inside hprobe_expire(). */
+	guard(srcu)(&uretprobes_srcu);
+	/* RCU protects return_instance from freeing. */
+	guard(rcu)();
+
+	for_each_ret_instance_rcu(ri, utask->return_instances) {
+		hprobe_expire(&ri->hprobe);
+	}
+}
+
+static struct uprobe_task *alloc_utask(void)
+{
+	struct uprobe_task *utask;
+
+	utask = kzalloc(sizeof(*utask), GFP_KERNEL);
+	if (!utask)
+		return NULL;
+
+	timer_setup(&utask->ri_timer, ri_timer, 0);
+
+	return utask;
+}
+
 /*
  * Allocate a uprobe_task object for the task if necessary.
  * Called when the thread hits a breakpoint.
@@ -1791,7 +1983,7 @@ void uprobe_free_utask(struct task_struct *t)
 static struct uprobe_task *get_utask(void)
 {
 	if (!current->utask)
-		current->utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+		current->utask = alloc_utask();
 	return current->utask;
 }
 
@@ -1799,12 +1991,16 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 {
 	struct uprobe_task *n_utask;
 	struct return_instance **p, *o, *n;
+	struct uprobe *uprobe;
 
-	n_utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+	n_utask = alloc_utask();
 	if (!n_utask)
 		return -ENOMEM;
 	t->utask = n_utask;
 
+	/* protect uprobes from freeing, we'll need try_get_uprobe() them */
+	guard(srcu)(&uretprobes_srcu);
+
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
 		n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
@@ -1812,17 +2008,24 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 			return -ENOMEM;
 
 		*n = *o;
+
+		/* see hprobe_expire() comments */
+		uprobe = hprobe_expire(&o->hprobe);
+		if (uprobe) /* refcount bump for new utask */
+			uprobe = try_get_uprobe(uprobe);
+
 		/*
-		 * uprobe's refcnt has to be positive at this point, kept by
-		 * utask->return_instances items; return_instances can't be
-		 * removed right now, as task is blocked due to duping; so
-		 * get_uprobe() is safe to use here.
+		 * New utask will have stable properly refcounted uprobe or
+		 * NULL. Even if we failed to get refcounted uprobe, we still
+		 * need to preserve full set of return_instances for proper
+		 * uretprobe handling and nesting in forked task.
 		 */
-		get_uprobe(n->uprobe);
-		n->next = NULL;
+		hprobe_init_stable(&n->hprobe, uprobe);
 
-		*p = n;
+		n->next = NULL;
+		rcu_assign_pointer(*p, n);
 		p = &n->next;
+
 		n_utask->depth++;
 	}
 
@@ -1898,10 +2101,10 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
 	enum rp_check ctx = chained ? RP_CHECK_CHAIN_CALL : RP_CHECK_CALL;
 
 	while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
-		ri = free_ret_instance(ri);
+		ri = free_ret_instance(ri, true /* cleanup_hprobe */);
 		utask->depth--;
 	}
-	utask->return_instances = ri;
+	rcu_assign_pointer(utask->return_instances, ri);
 }
 
 static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
@@ -1910,6 +2113,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	struct uprobe_task *utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
 	bool chained;
+	int srcu_idx;
 
 	if (!get_xol_area())
 		return;
@@ -1925,10 +2129,6 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		return;
 	}
 
-	/* we need to bump refcount to store uprobe in utask */
-	if (!try_get_uprobe(uprobe))
-		return;
-
 	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
 	if (!ri)
 		goto fail;
@@ -1958,20 +2158,26 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		}
 		orig_ret_vaddr = utask->return_instances->orig_ret_vaddr;
 	}
-	ri->uprobe = uprobe;
+
+	/* __srcu_read_lock() because SRCU lock survives switch to user space */
+	srcu_idx = __srcu_read_lock(&uretprobes_srcu);
+
 	ri->func = instruction_pointer(regs);
 	ri->stack = user_stack_pointer(regs);
 	ri->orig_ret_vaddr = orig_ret_vaddr;
 	ri->chained = chained;
 
 	utask->depth++;
+
+	hprobe_init_leased(&ri->hprobe, uprobe, srcu_idx);
 	ri->next = utask->return_instances;
-	utask->return_instances = ri;
+	rcu_assign_pointer(utask->return_instances, ri);
+
+	mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
 
 	return;
 fail:
 	kfree(ri);
-	put_uprobe(uprobe);
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -2166,11 +2372,14 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
 }
 
 static void
-handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
+handle_uretprobe_chain(struct return_instance *ri, struct uprobe *uprobe, struct pt_regs *regs)
 {
-	struct uprobe *uprobe = ri->uprobe;
 	struct uprobe_consumer *uc;
 
+	/* all consumers unsubscribed meanwhile */
+	if (unlikely(!uprobe))
+		return;
+
 	rcu_read_lock_trace();
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_trace_held()) {
 		if (uc->ret_handler)
@@ -2195,6 +2404,8 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
 	struct return_instance *ri, *next;
+	struct uprobe *uprobe;
+	enum hprobe_state hstate;
 	bool valid;
 
 	utask = current->utask;
@@ -2225,21 +2436,24 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 			 * trampoline addresses on the stack are replaced with correct
 			 * original return addresses
 			 */
-			utask->return_instances = ri->next;
+			rcu_assign_pointer(utask->return_instances, ri->next);
+
+			uprobe = hprobe_consume(&ri->hprobe, &hstate);
 			if (valid)
-				handle_uretprobe_chain(ri, regs);
-			ri = free_ret_instance(ri);
+				handle_uretprobe_chain(ri, uprobe, regs);
+			hprobe_finalize(&ri->hprobe, hstate);
+
+			/* We already took care of hprobe, no need to waste more time on that. */
+			ri = free_ret_instance(ri, false /* !cleanup_hprobe */);
 			utask->depth--;
 		} while (ri != next);
 	} while (!valid);
 
-	utask->return_instances = ri;
 	return;
 
- sigill:
+sigill:
 	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
 	force_sig(SIGILL);
-
 }
 
 bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs)
-- 
2.43.5


