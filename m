Return-Path: <bpf+bounces-36998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B394FCBB
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 06:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8021C22396
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 04:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD280224F6;
	Tue, 13 Aug 2024 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbYEML4Z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD0745E4;
	Tue, 13 Aug 2024 04:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723523410; cv=none; b=T5Coq2+3UfED/cz7fE4S0S+pNHSAbV1CXcANvsh1tj3PqtVETkDpOHqRQ9j3KzZBrXqP7Q4Qqo/A4l7VUu2E/GGgMuDblVRvx8SI5J8Vxor/txSUNB27ly8t/cEVxzvtY/ojTQKOQWkj6fT8JNXOMlCKDXT1tE78KrmwqQ20eF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723523410; c=relaxed/simple;
	bh=B5wil2uWMxial/sRKGYqY7C+zyKYK4VtXNZrEosPpfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjJkmk6AMYvWzwCEj32PbKn8PqiJpokRWJXEVwCLY7FuYbi1aMTJgQnDLV0ayFXLPLjnROd2vp3DyNpY955/0yyYjgOKdjalCWqMaonmEPXBK5G+n3QsRZWDH2oYs588lltuPrveBMWYvU2fFMatydtGesJ/8pv1MkoBeRHonWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbYEML4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB88C4AF0E;
	Tue, 13 Aug 2024 04:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723523410;
	bh=B5wil2uWMxial/sRKGYqY7C+zyKYK4VtXNZrEosPpfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VbYEML4ZoVQTOrFFgEAXPJ1mBYBgtGu7Rkg6MuStkgGx7zozJ9MKqM8MTe7nxj2om
	 4OW5ZHn9n9vk5eU9zBgPIVfxfr1cn1IoqeAr8dXjcxM4PO7/VVN+IQbuSc9jR05abc
	 xAoLSWSlND37zljNrA/f4hWV5EfX1VFrNJWH3F61i6IC8JaFR17qov+tYbNrq8qg4V
	 UwqKedNLg0J8pFlH6C0jgFkSkWRUE17OjpNlEoo+/ChwJYAQxkBcF/oTWzCxke9+RW
	 Y3UChPF+Ipl4cJIUrzpz4hbC8kLTIe4Hx+uKcczUUjLpALIj3J1wDCk9SwYFxtlXHT
	 i78kflm3AtvGA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org,
	oleg@redhat.com
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jolsa@kernel.org,
	paulmck@kernel.org,
	willy@infradead.org,
	surenb@google.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH RFC v3 09/13] uprobes: SRCU-protect uretprobe lifetime (with timeout)
Date: Mon, 12 Aug 2024 21:29:13 -0700
Message-ID: <20240813042917.506057-10-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813042917.506057-1-andrii@kernel.org>
References: <20240813042917.506057-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
because uretprobing long running user functions inherently doesn't run
into scalability issues (there is just not enough frequency to cause
noticeable issues with either performance or scalability).

The overall trick is in ensuring synchronization between current thread
and timer's callback fired on some other thread. To cope with that with
minimal logic complications, we add hprobe wrapper which is used to
contain all the racy and synchronization related issues behind a small
number of basic helpers: hprobe_expire() and a matching pair of
hprobe_consume() and hprobe_finalize(). Other than that whatever current
thread's logic is there stays the same, as timer thread cannot modify
return_instance state (or add new/remove old return_instances). It only
takes care of SRCU unlock and uprobe refcounting, which is hidden from
the higher-level uretprobe handling logic.

We use atomic xchg() in hprobe_consume(), which is called from
performance critical handle_uretprobe_chain() function run in the
current context. When uncontended, this xchg() doesn't seem to hurt
performance as there are no other competing CPUs fighting for the same
cache line.  We also mark struct return_instance as
____cacheline_aligned to ensure no false sharing can happen.

Another technical moment, we need to make sure that the list of return
instances can be safely traversed under RCU from timer callback, so we
delay return_instance freeing with kfree_rcu() and make sure that list
modifications use RCU-aware operations.

Also, given SRCU lock survives transition from kernel to user space and
back we need to use lower-level __srcu_read_lock() and
__srcu_read_unlock() to avoid lockdep complaining.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/linux/uprobes.h |  49 ++++++-
 kernel/events/uprobes.c | 294 ++++++++++++++++++++++++++++++++++------
 2 files changed, 301 insertions(+), 42 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index e41cdae5597b..9a0aa0b2a5fe 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -15,6 +15,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/timer.h>
 
 struct uprobe;
 struct vm_area_struct;
@@ -48,6 +49,45 @@ enum uprobe_task_state {
 	UTASK_SSTEP_TRAPPED,
 };
 
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
+	struct uprobe *stable;
+	struct uprobe *leased;
+	int srcu_idx;
+};
+
 /*
  * uprobe_task: Metadata of a task while it singlesteps.
  */
@@ -68,6 +108,7 @@ struct uprobe_task {
 	};
 
 	struct uprobe			*active_uprobe;
+	struct timer_list		ri_timer;
 	unsigned long			xol_vaddr;
 
 	struct arch_uprobe              *auprobe;
@@ -77,14 +118,18 @@ struct uprobe_task {
 };
 
 struct return_instance {
-	struct uprobe		*uprobe;
 	unsigned long		func;
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
 	bool			chained;	/* true, if instance is nested */
 
 	struct return_instance	*next;		/* keep as stack */
-};
+
+	union {
+		struct hprobe		hprobe;
+		struct rcu_head		rcu;
+	};
+} ____cacheline_aligned;
 
 enum rp_check {
 	RP_CHECK_CALL,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 0480ad841942..26acd06871e6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -26,6 +26,7 @@
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
+#include <linux/srcu.h>
 
 #include <linux/uprobes.h>
 
@@ -49,6 +50,9 @@ static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
 
 DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
 
+/* Covers return_instance's uprobe lifetime. */
+DEFINE_STATIC_SRCU(uretprobes_srcu);
+
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
 
@@ -594,13 +598,6 @@ set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long v
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
@@ -619,13 +616,20 @@ static inline bool uprobe_is_active(struct uprobe *uprobe)
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
 static void put_uprobe(struct uprobe *uprobe)
 {
 	if (!refcount_dec_and_test(&uprobe->ref))
@@ -650,7 +654,146 @@ static void put_uprobe(struct uprobe *uprobe)
 	delayed_uprobe_remove(uprobe, NULL);
 	mutex_unlock(&delayed_uprobe_lock);
 
-	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
+	/* start srcu -> rcu_tasks_trace -> kfree chain */
+	call_srcu(&uretprobes_srcu, &uprobe->rcu, uprobe_free_srcu);
+}
+
+/*
+ * Special marker pointer for when ri_timer() expired, unlocking RCU, but
+ * failed to acquire refcount on uprobe (because it doesn't have any
+ * associated consumer anymore, for example). In such case it's important for
+ * hprobe_consume() to return NULL uprobe, instead of "stable" uprobe pointer,
+ * as that one isn't protected by either refcount nor RCU region now.
+ */
+#define __UPROBE_DEAD ((struct uprobe *)(-0xdead))
+
+#define RI_TIMER_PERIOD (HZ/10) /* 100 ms */
+
+/* Initialize hprobe as SRCU-protected "leased" uprobe */
+static void hprobe_init_leased(struct hprobe *hprobe, struct uprobe *uprobe, int srcu_idx)
+{
+	hprobe->srcu_idx = srcu_idx;
+	hprobe->stable = uprobe;
+	hprobe->leased = uprobe;
+}
+
+/* Initialize hprobe as refcounted ("stable") uprobe (uprobe can be NULL). */
+static void hprobe_init_stable(struct hprobe *hprobe, struct uprobe *uprobe)
+{
+	hprobe->srcu_idx = -1;
+	hprobe->stable = uprobe;
+	hprobe->leased = NULL;
+}
+
+/*
+ * hprobe_consume() fetches hprobe's underlying uprobe and detects whether
+ * uprobe is still SRCU protected, or is refcounted. hprobe_consume() can be
+ * used only once for a given hprobe.
+ *
+ * Caller has to perform SRCU unlock if under_rcu is set to true;
+ * otherwise, either properly refcounted uprobe is returned or NULL.
+ */
+static inline struct uprobe *hprobe_consume(struct hprobe *hprobe, bool *under_rcu)
+{
+	struct uprobe *uprobe;
+
+	uprobe = xchg(&hprobe->leased, NULL);
+	if (uprobe) {
+		if (unlikely(uprobe == __UPROBE_DEAD)) {
+			*under_rcu = false;
+			return NULL;
+		}
+
+		*under_rcu = true;
+		return uprobe;
+	}
+
+	*under_rcu = false;
+	return hprobe->stable;
+}
+
+/*
+ * Reset hprobe state and, if under_rcu is true, release SRCU lock.
+ * hprobe_finalize() can only be used from current context after
+ * hprobe_consume() call (which determines uprobe and under_rcu value).
+ */
+static void hprobe_finalize(struct hprobe *hprobe, struct uprobe *uprobe, bool under_rcu)
+{
+	if (under_rcu)
+		__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
+	else if (uprobe)
+		put_uprobe(uprobe);
+	/* prevent free_ret_instance() from double-putting uprobe */
+	hprobe->stable = NULL;
+}
+
+/*
+ * Attempt to switch (atomically) uprobe from being RCU protected ("leased")
+ * to refcounted ("stable") state. Competes with hprobe_consume(), only one of
+ * them can win the race to perform SRCU unlocking. Whoever wins must perform
+ * SRCU unlock.
+ *
+ * Returns underlying valid uprobe or NULL, if there was no underlying uprobe
+ * to begin with or we failed to bump its refcount and it's going away.
+ *
+ * Returned non-NULL uprobe can be still safely used within an ongoing SRCU
+ * locked region. It's not guaranteed that returned uprobe has a positive
+ * refcount, so caller has to attempt try_get_uprobe(), if it needs to use
+ * returned uprobe instance beyond ongoing SRCU lock region. See dup_utask().
+ */
+static struct uprobe* hprobe_expire(struct hprobe *hprobe)
+{
+	struct uprobe *uprobe;
+
+	/*
+	 * return_instance's hprobe is protected by RCU.
+	 * Underlying uprobe is itself protected from reuse by SRCU.
+	 */
+	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
+
+	/*
+	 * Leased pointer can only be NULL, __UPROBE_DEAD, or some valid uprobe
+	 * pointer. This pointer can only be updated to NULL or __UPROBE_DEAD,
+	 * not any other valid uprobe pointer. So it's safe to fetch it with
+	 * READ_ONCE() and try to refcount it, if it's not NULL or __UPROBE_DEAD.
+	 */
+	uprobe = data_race(READ_ONCE(hprobe->leased));
+	if (!uprobe || uprobe == __UPROBE_DEAD)
+		return NULL;
+
+	if (!try_get_uprobe(uprobe)) {
+		/*
+		 * hprobe_consume() might have xchg()'ed to NULL already,
+		 * in which case we shouldn't set __UPROBE_DEAD.
+		 */
+		cmpxchg(&hprobe->leased, uprobe, __UPROBE_DEAD);
+		return NULL;
+	}
+
+	/*
+	 * Even if hprobe_consume() won and unlocked SRCU, we still have
+	 * a guarantee that uprobe won't be freed (and thus won't be reused)
+	 * because out caller maintains its own SRCU locked region.
+	 * So cmpxchg() below is well-formed.
+	 */
+	if (cmpxchg(&hprobe->leased, uprobe, NULL)) {
+		/*
+		 * At this point uprobe is properly refcounted, so it's safe
+		 * to end its original SRCU locked region.
+		 */
+		__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
+		return uprobe;
+	}
+
+	/* We lost the race, undo our refcount bump. It can drop to zero. */
+	put_uprobe(uprobe);
+
+	/*
+	 * We return underlying uprobe nevertheless because it's still valid
+	 * until the end of current SRCU locked region, and can be used to
+	 * try_get_uprobe(). This is used in dup_utask().
+	 */
+	return uprobe;
 }
 
 static __always_inline
@@ -1727,11 +1870,18 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *regs)
 	return instruction_pointer(regs);
 }
 
-static struct return_instance *free_ret_instance(struct return_instance *ri)
+static struct return_instance *free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
 {
 	struct return_instance *next = ri->next;
-	put_uprobe(ri->uprobe);
-	kfree(ri);
+	struct uprobe *uprobe;
+	bool under_rcu;
+
+	if (cleanup_hprobe) {
+		uprobe = hprobe_consume(&ri->hprobe, &under_rcu);
+		hprobe_finalize(&ri->hprobe, uprobe, under_rcu);
+	}
+
+	kfree_rcu(ri, rcu);
 	return next;
 }
 
@@ -1747,18 +1897,51 @@ void uprobe_free_utask(struct task_struct *t)
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
@@ -1770,7 +1953,7 @@ void uprobe_free_utask(struct task_struct *t)
 static struct uprobe_task *get_utask(void)
 {
 	if (!current->utask)
-		current->utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+		current->utask = alloc_utask();
 	return current->utask;
 }
 
@@ -1778,12 +1961,16 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
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
@@ -1791,17 +1978,24 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
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
+		 * New utask will have stable properly refcounted uprobe or NULL.
+		 * Even if we failed to get refcounted uprobe, we still need
+		 * to preserve full set of return_instances for proper
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
 
@@ -1877,10 +2071,10 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
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
@@ -1889,6 +2083,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 	struct uprobe_task *utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
 	bool chained;
+	int srcu_idx;
 
 	if (!get_xol_area())
 		return;
@@ -1904,10 +2099,6 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
 		return;
 	}
 
-	/* we need to bump refcount to store uprobe in utask */
-	if (!try_get_uprobe(uprobe))
-		return;
-
 	ri = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
 	if (!ri)
 		goto fail;
@@ -1937,20 +2128,36 @@ static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
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
+	/*
+	 * Don't reschedule if timer is already active. This way we have
+	 * a guaranteed cap on maximum timer period (SRCU expiration duration)
+	 * regardless of how long and well-timed uretprobe chain user space
+	 * might cause. At worst we'll just have a few extra inconsequential
+	 * refcount bumps even if we could, technically, get away with just an
+	 * SRCU lock. On the other hand, we get timer expiration logic
+	 * triggered and tested regularly even for very short-running uretprobes.
+	 */
+	if (!timer_pending(&utask->ri_timer))
+		mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
 
 	return;
 fail:
 	kfree(ri);
-	put_uprobe(uprobe);
 }
 
 /* Prepare to single-step probed instruction out of line. */
@@ -2144,11 +2351,14 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
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
@@ -2173,7 +2383,8 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
 	struct return_instance *ri, *next;
-	bool valid;
+	struct uprobe *uprobe;
+	bool valid, under_rcu;
 
 	utask = current->utask;
 	if (!utask)
@@ -2203,21 +2414,24 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 			 * trampoline addresses on the stack are replaced with correct
 			 * original return addresses
 			 */
-			utask->return_instances = ri->next;
+			rcu_assign_pointer(utask->return_instances, ri->next);
+
+			uprobe = hprobe_consume(&ri->hprobe, &under_rcu);
 			if (valid)
-				handle_uretprobe_chain(ri, regs);
-			ri = free_ret_instance(ri);
+				handle_uretprobe_chain(ri, uprobe, regs);
+			hprobe_finalize(&ri->hprobe, uprobe, under_rcu);
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


