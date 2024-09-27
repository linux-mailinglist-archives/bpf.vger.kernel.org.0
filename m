Return-Path: <bpf+bounces-40396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C85A988201
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 11:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E251C22B52
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E71BB6A9;
	Fri, 27 Sep 2024 09:56:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8617115F3FB;
	Fri, 27 Sep 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430983; cv=none; b=CMtvB8LrN3KFomZ7eBPxiVYg6Z/plabp679GHoiRS7xmyFkfxg2eX0WGuXaK22XyHzMMpCPThDjpIeUz4OHOFYxxIZegaMRSZ9fu8ZkMOxtDPJmNCrvoyQIXK3xZeDpBtiLrD2lzdPEMtTq1t4Uygf/43Axd5+vbpnCbe7RW5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430983; c=relaxed/simple;
	bh=fecCblTVlXRytdY3RhI+s3PtueayGXXXGTySOz04tRg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=unPwmarCl0VB2c9KYUFuunVSRmsVWWKrREhqRGf3KThEEG/t8usejvCxfExLg950TzVpP5WgdVg5x5zcx0ZOLfOPXxPs7tN5aAQKJPsDksUbXBXsK02gg4goCA311O2J8bJ2tOpiVk8W/tn8mO/sX8r58OlddzlxZ0gB8RAD4c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XFQnw4kgzzFqwk;
	Fri, 27 Sep 2024 17:55:48 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F912140158;
	Fri, 27 Sep 2024 17:56:12 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 27 Sep
 2024 17:56:11 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <ak@linux.intel.com>, <mhiramat@kernel.org>, <oleg@redhat.com>,
	<andrii@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH v2] uprobes: Improve the usage of xol slots for better scalability
Date: Fri, 27 Sep 2024 09:45:49 +0000
Message-ID: <20240927094549.3382916-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)

The uprobe handler allocates xol slot from xol_area and quickly release
it in the single-step handler. The atomic operations on the xol bitmap
and slot_count lead to expensive cache line bouncing between multiple
CPUs. Given the xol slot is on the hot path for uprobe and kretprobe
handling, the profiling results on some Arm64 machine show that nearly
80% of cycles are spent on this. So optimizing xol slot usage will
become important to scalability after the Andrii's series land.

This patch address this scalability issues from two perspectives:

- Allocated xol slot is now saved in the thread associated utask data.
  It allows to reuse it throughout the therad's lifetime. This avoid
  the frequent atomic operation on the slot bitmap and slot_count of
  xol_area data, which is the major negative impact on scalability.

- A garbage collection routine xol_recycle_insn_slot() is introduced to
  reclaim unused xol slots. utask instances that own xol slot but
  haven't reclaimed them are linked in a linked list. When xol_area runs
  out of slots, the garbage collection routine travel the list to free
  one slot. Allocated xol slots is marked as unused in single-step
  handler. While the marking relies on the refcount of utask instance,
  due to thread can't run on multiple CPUs at same time, therefore, it
  is unlikely CPUs take the refcount of same utask, minimizing cache
  line bouncing.

  Upon thread exit, the utask is deleted from the linked-list, and the
  associated xol slot will be free.

v2->v1:
-------
As suggested by Andi Kleen [1], the updates to the garbage collection
list of xol slots is not a common case. This revision replaces the
complex lockless RCU scheme with a simple raw spinlock.

Here's an explanation of the locking and refcount update scheme in the
patch:

- area->gc_lock protects the write operations on the area->gc_list. This
  includes inserting slot into area->gc_list in xol_get_insn_slot() and
  removing slot from area->gc_list in xol_recycle_insn_slot().

- utask->slot_ref is used to track the status of uprobe_task instance
  associated insn_slot. It has three values, the value of 1 means the
  slot is free to use or recycle. The value of 2 means the slot is in
  use. The value of 0 means the slot is being recycled. This design
  ensure that slots in use aren't recycled from GC list and that slots
  being recycled aren't available for uprobe use. For example,
  refcount_inc_not_zero() turns the value from 1 to 2 in uprobe BRK
  handling, Using refcount_dec() to turn it from 2 to 1 during uprobe
  single-step handling. Using refcount_dec_if_one() to turn the value
  from 1 to 0 when recycling slot from GC list.

[1] https://lore.kernel.org/all/ZuwoUmqXrztp-Mzh@tassilo/

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 include/linux/uprobes.h |   4 +
 kernel/events/uprobes.c | 177 ++++++++++++++++++++++++++++++----------
 2 files changed, 139 insertions(+), 42 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index 2b294bf1881f..7a29fbe2a09f 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -77,6 +77,10 @@ struct uprobe_task {
 	struct uprobe			*active_uprobe;
 	unsigned long			xol_vaddr;
 
+	struct list_head		gc;
+	refcount_t			slot_ref;
+	int				insn_slot;
+
 	struct arch_uprobe              *auprobe;
 
 	struct return_instance		*return_instances;
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ec796e2f055..2d2ef2117a89 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -110,6 +110,9 @@ struct xol_area {
 	 * the vma go away, and we must handle that reasonably gracefully.
 	 */
 	unsigned long 			vaddr;		/* Page(s) of instruction slots */
+	struct list_head		gc_list;	/* The list for the
+							   garbage slots */
+	raw_spinlock_t			gc_lock;	/* Hold for gc_list */
 };
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
@@ -1551,6 +1554,8 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	area->vaddr = vaddr;
 	init_waitqueue_head(&area->wq);
+	INIT_LIST_HEAD(&area->gc_list);
+	raw_spin_lock_init(&area->gc_lock);
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
 	atomic_set(&area->slot_count, 1);
@@ -1626,37 +1631,107 @@ void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
 	}
 }
 
+/*
+ * Use the slot_ref to track the status of utask and avoid racing on
+ * the insn_slot field of utask instances linked on area->gc_list.
+ *  - 1->2, insn_slot is in use.
+ *  - 1->0, insn_slot is being recycled.
+ *  - 2->1, insn_slot is free to use or recycle.
+ */
+static __always_inline
+struct uprobe_task *test_and_get_task_slot(struct uprobe_task *utask)
+{
+	return refcount_inc_not_zero(&utask->slot_ref) ? utask : NULL;
+}
+
+static __always_inline
+struct uprobe_task *test_and_put_task_slot(struct uprobe_task *utask)
+{
+	return refcount_dec_if_one(&utask->slot_ref) ? utask : NULL;
+}
+
+static __always_inline
+void put_task_slot(struct uprobe_task *utask)
+{
+	refcount_dec(&utask->slot_ref);
+}
+
+static __always_inline
+int recycle_utask_slot(struct uprobe_task *utask, struct xol_area *area)
+{
+	int slot = UINSNS_PER_PAGE;
+
+	/*
+	 * Ensure that the slot is not in use on other CPU. However, this
+	 * check is unnecessary when called in the context of an exiting
+	 * thread. See xol_free_insn_slot() called from uprobe_free_utask()
+	 * for more details.
+	 */
+	if (test_and_put_task_slot(utask)) {
+		list_del(&utask->gc);
+		clear_bit(utask->insn_slot, area->bitmap);
+		atomic_dec(&area->slot_count);
+		utask->insn_slot = UINSNS_PER_PAGE;
+		refcount_set(&utask->slot_ref, 1);
+	}
+
+	return slot;
+}
+
+/*
+ * xol_recycle_insn_slot - recycle a slot from the garbage collection list.
+ */
+static int xol_recycle_insn_slot(struct xol_area *area)
+{
+	struct uprobe_task *utask;
+	int slot = UINSNS_PER_PAGE;
+
+	raw_spin_lock(&area->gc_lock);
+	list_for_each_entry(utask, &area->gc_list, gc) {
+		slot = recycle_utask_slot(utask, area);
+		if (slot != UINSNS_PER_PAGE)
+			break;
+	}
+	raw_spin_unlock(&area->gc_lock);
+
+	return slot;
+}
+
 /*
  *  - search for a free slot.
  */
-static unsigned long xol_take_insn_slot(struct xol_area *area)
+static int xol_take_insn_slot(struct xol_area *area)
 {
-	unsigned long slot_addr;
 	int slot_nr;
 
 	do {
 		slot_nr = find_first_zero_bit(area->bitmap, UINSNS_PER_PAGE);
-		if (slot_nr < UINSNS_PER_PAGE) {
-			if (!test_and_set_bit(slot_nr, area->bitmap))
-				break;
-
-			slot_nr = UINSNS_PER_PAGE;
-			continue;
+		if (slot_nr == UINSNS_PER_PAGE) {
+			/* It recycles slot from GC list upon area runs out */
+			slot_nr = xol_recycle_insn_slot(area);
 		}
-		wait_event(area->wq, (atomic_read(&area->slot_count) < UINSNS_PER_PAGE));
+
+		if (slot_nr == UINSNS_PER_PAGE)
+			wait_event(area->wq,
+				   (atomic_read(&area->slot_count) <
+				    UINSNS_PER_PAGE));
+		else if (!test_and_set_bit(slot_nr, area->bitmap))
+			break;
+
+		slot_nr = UINSNS_PER_PAGE;
 	} while (slot_nr >= UINSNS_PER_PAGE);
 
-	slot_addr = area->vaddr + (slot_nr * UPROBE_XOL_SLOT_BYTES);
 	atomic_inc(&area->slot_count);
 
-	return slot_addr;
+	return slot_nr;
 }
 
 /*
  * xol_get_insn_slot - allocate a slot for xol.
  * Returns the allocated slot address or 0.
  */
-static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
+static unsigned long xol_get_insn_slot(struct uprobe_task *utask,
+				       struct uprobe *uprobe)
 {
 	struct xol_area *area;
 	unsigned long xol_vaddr;
@@ -1665,16 +1740,46 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 	if (!area)
 		return 0;
 
-	xol_vaddr = xol_take_insn_slot(area);
-	if (unlikely(!xol_vaddr))
+	/*
+	 * The racing on the utask associated slot_ref can occur unless the
+	 * area runs out of slots. This isn't a common case. Even if it does
+	 * happen, the scalability bottleneck will shift to another point.
+	 */
+	if (!test_and_get_task_slot(utask))
 		return 0;
 
+	if (utask->insn_slot == UINSNS_PER_PAGE) {
+		utask->insn_slot = xol_take_insn_slot(area);
+		raw_spin_lock(&area->gc_lock);
+		list_add(&utask->gc, &area->gc_list);
+		raw_spin_unlock(&area->gc_lock);
+	}
+
+	xol_vaddr = area->vaddr + (utask->insn_slot * UPROBE_XOL_SLOT_BYTES);
+
 	arch_uprobe_copy_ixol(area->page, xol_vaddr,
 			      &uprobe->arch.ixol, sizeof(uprobe->arch.ixol));
 
 	return xol_vaddr;
 }
 
+/*
+ * xol_delay_free_insn_slot - Make the slot available for garbage collection
+ */
+static void xol_delay_free_insn_slot(void)
+{
+	struct xol_area *area = current->mm->uprobes_state.xol_area;
+
+	/*
+	 * This refcount would't cause expensive cache line bouncing
+	 * between CPUs, as it is unlikely that multiple CPUs take the
+	 * slot_ref of same utask.
+	 */
+	put_task_slot(current->utask);
+	if (waitqueue_active(&area->wq))
+		wake_up(&area->wq);
+}
+
 /*
  * xol_free_insn_slot - If slot was earlier allocated by
  * @xol_get_insn_slot(), make the slot available for
@@ -1683,35 +1788,21 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
 	struct xol_area *area;
-	unsigned long vma_end;
-	unsigned long slot_addr;
 
 	if (!tsk->mm || !tsk->mm->uprobes_state.xol_area || !tsk->utask)
 		return;
 
-	slot_addr = tsk->utask->xol_vaddr;
-	if (unlikely(!slot_addr))
-		return;
-
 	area = tsk->mm->uprobes_state.xol_area;
-	vma_end = area->vaddr + PAGE_SIZE;
-	if (area->vaddr <= slot_addr && slot_addr < vma_end) {
-		unsigned long offset;
-		int slot_nr;
-
-		offset = slot_addr - area->vaddr;
-		slot_nr = offset / UPROBE_XOL_SLOT_BYTES;
-		if (slot_nr >= UINSNS_PER_PAGE)
-			return;
 
-		clear_bit(slot_nr, area->bitmap);
-		atomic_dec(&area->slot_count);
-		smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
-		if (waitqueue_active(&area->wq))
-			wake_up(&area->wq);
+	raw_spin_lock(&area->gc_lock);
+	recycle_utask_slot(tsk->utask, area);
+	raw_spin_unlock(&area->gc_lock);
 
-		tsk->utask->xol_vaddr = 0;
-	}
+	smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
+	if (waitqueue_active(&area->wq))
+		wake_up(&area->wq);
+
+	tsk->utask->xol_vaddr = 0;
 }
 
 void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
@@ -1792,8 +1883,12 @@ void uprobe_free_utask(struct task_struct *t)
  */
 static struct uprobe_task *get_utask(void)
 {
-	if (!current->utask)
+	if (!current->utask) {
 		current->utask = kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+		current->utask->insn_slot = UINSNS_PER_PAGE;
+		INIT_LIST_HEAD(&current->utask->gc);
+		refcount_set(&current->utask->slot_ref, 1);
+	}
 	return current->utask;
 }
 
@@ -1991,7 +2086,7 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	if (!try_get_uprobe(uprobe))
 		return -EINVAL;
 
-	xol_vaddr = xol_get_insn_slot(uprobe);
+	xol_vaddr = xol_get_insn_slot(utask, uprobe);
 	if (!xol_vaddr) {
 		err = -ENOMEM;
 		goto err_out;
@@ -2001,10 +2096,8 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	utask->vaddr = bp_vaddr;
 
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
-	if (unlikely(err)) {
-		xol_free_insn_slot(current);
+	if (unlikely(err))
 		goto err_out;
-	}
 
 	utask->active_uprobe = uprobe;
 	utask->state = UTASK_SSTEP;
@@ -2353,7 +2446,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 	put_uprobe(uprobe);
 	utask->active_uprobe = NULL;
 	utask->state = UTASK_RUNNING;
-	xol_free_insn_slot(current);
+	xol_delay_free_insn_slot();
 
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending(); /* see uprobe_deny_signal() */
-- 
2.34.1


