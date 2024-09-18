Return-Path: <bpf+bounces-40050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049497B696
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 03:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78919B29C4D
	for <lists+bpf@lfdr.de>; Wed, 18 Sep 2024 01:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0DB4B658;
	Wed, 18 Sep 2024 01:38:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565723B0;
	Wed, 18 Sep 2024 01:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726623496; cv=none; b=r/NEiPVnO7W72Z68WGRpW29C3yhg0aBt3XxsCtbLmKaqyXU1yxlhYmgfxj3uBgWb01iXDg67IHM7rFWIaB7hcDjCRwBlUlB5GccH5X4QS0C7I9v5bFWefKVUzQniaYLfBPehWqMtVfIpEW6kwqvXUw8o8rOL76AkZWyK0SNtL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726623496; c=relaxed/simple;
	bh=6h/5sh8g6PzXThSEboHpnwPsFdNAKItWhvM2XS4n8Xo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RPW2E+ce3IKqsSI2A/uraCSTMBVsW5BnPQk9w7am/H3eq6GehTIitI4iHmefhVQBmRmFeQRcPEKs5vO0UC6k7B8UbEGb2zglkEFXEMBpu6Rwdoz/tQDkGaWh9wgecex27Tj0KVbnIYCJ0XEceeEczHIfBPByvoqYEV2AR4Yis0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X7h9W0CFlzFqn6;
	Wed, 18 Sep 2024 09:37:51 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 726961800A0;
	Wed, 18 Sep 2024 09:38:04 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 18 Sep
 2024 09:38:01 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <mhiramat@kernel.org>, <oleg@redhat.com>, <andrii@kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: [PATCH] uprobes: Improve the usage of xol slots for better scalability
Date: Wed, 18 Sep 2024 01:27:52 +0000
Message-ID: <20240918012752.2045713-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)

The kprobe handler allocates xol slot from xol_area and quickly release
it in the single-step handler. The atomic operations on the xol bitmap
and slot_count lead to expensive cache line bouncing between multiple
CPUs. Given the xol slot is on the hot path for kprobe and kretprobe
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

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 include/linux/uprobes.h |   4 +
 kernel/events/uprobes.c | 173 ++++++++++++++++++++++++++++++----------
 2 files changed, 135 insertions(+), 42 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index e6f4e73125ff..87fa24c74eb8 100644
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
index 86fcb2386ea2..5ba1bd3ad27f 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -111,6 +111,12 @@ struct xol_area {
 	 * the vma go away, and we must handle that reasonably gracefully.
 	 */
 	unsigned long 			vaddr;		/* Page(s) of instruction slots */
+	struct list_head		gc_list;	/* The list for the
+							   garbage slots */
+	spinlock_t			list_lock;	/* Hold for
+							   list_add_rcu() and
+							   list_del_rcu() on
+							   gc_list */
 };
 
 static void uprobe_warn(struct task_struct *t, const char *msg)
@@ -1557,6 +1563,8 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	area->vaddr = vaddr;
 	init_waitqueue_head(&area->wq);
+	INIT_LIST_HEAD(&area->gc_list);
+	spin_lock_init(&area->list_lock);
 	/* Reserve the 1st slot for get_trampoline_vaddr() */
 	set_bit(0, area->bitmap);
 	atomic_set(&area->slot_count, 1);
@@ -1613,37 +1621,91 @@ void uprobe_dup_mmap(struct mm_struct *oldmm, struct mm_struct *newmm)
 	}
 }
 
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
+void get_task_slot(struct uprobe_task *utask)
+{
+	refcount_inc(&utask->slot_ref);
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
+	rcu_read_lock();
+	list_for_each_entry_rcu(utask, &area->gc_list, gc) {
+		/*
+		 * The utask associated slot is in-use or recycling when
+		 * utask associated slot_ref is not one.
+		 */
+		if (test_and_put_task_slot(utask)) {
+			slot = utask->insn_slot;
+			utask->insn_slot = UINSNS_PER_PAGE;
+			clear_bit(slot, area->bitmap);
+			atomic_dec(&area->slot_count);
+			get_task_slot(utask);
+			break;
+		}
+	}
+	rcu_read_unlock();
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
+		if (slot_nr == UINSNS_PER_PAGE)
+			slot_nr = xol_recycle_insn_slot(area);
+
+		if (slot_nr == UINSNS_PER_PAGE)
+			wait_event(area->wq,
+				   (atomic_read(&area->slot_count) <
+				    UINSNS_PER_PAGE));
+		else if (!test_and_set_bit(slot_nr, area->bitmap))
+			break;
 
-			slot_nr = UINSNS_PER_PAGE;
-			continue;
-		}
-		wait_event(area->wq, (atomic_read(&area->slot_count) < UINSNS_PER_PAGE));
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
@@ -1652,16 +1714,45 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 	if (!area)
 		return 0;
 
-	xol_vaddr = xol_take_insn_slot(area);
-	if (unlikely(!xol_vaddr))
+	/*
+	 * The utask associated slot is recycling when utask associated
+	 * slot_ref is zero.
+	 */
+	if (!test_and_get_task_slot(utask))
 		return 0;
 
+	if (utask->insn_slot == UINSNS_PER_PAGE) {
+		utask->insn_slot = xol_take_insn_slot(area);
+		spin_lock(&area->list_lock);
+		list_add_rcu(&utask->gc, &area->gc_list);
+		spin_unlock(&area->list_lock);
+	}
+
+	xol_vaddr = area->vaddr + (utask->insn_slot * UPROBE_XOL_SLOT_BYTES);
+
 	arch_uprobe_copy_ixol(area->pages[0], xol_vaddr,
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
@@ -1670,35 +1761,31 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
 static void xol_free_insn_slot(struct task_struct *tsk)
 {
 	struct xol_area *area;
-	unsigned long vma_end;
-	unsigned long slot_addr;
+	unsigned long flags;
+	int slot_nr;
 
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
+	spin_lock_irqsave(&area->list_lock, flags);
+	list_del_rcu(&tsk->utask->gc);
+	spin_unlock_irqrestore(&area->list_lock, flags);
+	synchronize_rcu();
 
-		tsk->utask->xol_vaddr = 0;
-	}
+	slot_nr = tsk->utask->insn_slot;
+	if (unlikely(slot_nr == UINSNS_PER_PAGE))
+		return;
+
+	tsk->utask->insn_slot = UINSNS_PER_PAGE;
+	clear_bit(slot_nr, area->bitmap);
+	atomic_dec(&area->slot_count);
+	smp_mb__after_atomic(); /* pairs with prepare_to_wait() */
+	if (waitqueue_active(&area->wq))
+		wake_up(&area->wq);
+
+	tsk->utask->xol_vaddr = 0;
 }
 
 void __weak arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
@@ -1779,8 +1866,12 @@ void uprobe_free_utask(struct task_struct *t)
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
 
@@ -1978,7 +2069,7 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	if (!try_get_uprobe(uprobe))
 		return -EINVAL;
 
-	xol_vaddr = xol_get_insn_slot(uprobe);
+	xol_vaddr = xol_get_insn_slot(utask, uprobe);
 	if (!xol_vaddr) {
 		err = -ENOMEM;
 		goto err_out;
@@ -1988,10 +2079,8 @@ pre_ssout(struct uprobe *uprobe, struct pt_regs *regs, unsigned long bp_vaddr)
 	utask->vaddr = bp_vaddr;
 
 	err = arch_uprobe_pre_xol(&uprobe->arch, regs);
-	if (unlikely(err)) {
-		xol_free_insn_slot(current);
+	if (unlikely(err))
 		goto err_out;
-	}
 
 	utask->active_uprobe = uprobe;
 	utask->state = UTASK_SSTEP;
@@ -2340,7 +2429,7 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
 	put_uprobe(uprobe);
 	utask->active_uprobe = NULL;
 	utask->state = UTASK_RUNNING;
-	xol_free_insn_slot(current);
+	xol_delay_free_insn_slot();
 
 	spin_lock_irq(&current->sighand->siglock);
 	recalc_sigpending(); /* see uprobe_deny_signal() */
-- 
2.34.1


