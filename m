Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F6C13DDE7
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2020 15:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgAPOqD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jan 2020 09:46:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:36646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgAPOqD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jan 2020 09:46:03 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B010B20684;
        Thu, 16 Jan 2020 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579185961;
        bh=WZUGiEJ/e6urkguiLJzQqlix3oe6FHXiP6/1t/uZDcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NajVxD9BjkTh37lS3Eer/hM2jcnRRJqK+01tzBHRpXwp2+QpQuprM47xpjwEh4h5E
         1cvJFlgen0JuVnPlsu2Elhy6AKSwm/axkGzJXUROliAhruHYMreB6FJqmN/Cy2QrSc
         +Y1Vgk94vNlle2Zj87s9Kr3m8V3GwwLpb2vmcct8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Brendan Gregg <brendan.d.gregg@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     mhiramat@kernel.org, Ingo Molnar <mingo@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "David S . Miller" <davem@davemloft.net>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Subject: [RFT PATCH 10/13] kprobes: Make free_*insn_slot() mutex-less
Date:   Thu, 16 Jan 2020 23:45:56 +0900
Message-Id: <157918595628.29301.5657205433519510960.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157918584866.29301.6941815715391411338.stgit@devnote2>
References: <157918584866.29301.6941815715391411338.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Rewrite kprobe_insn_cache implementation so that free_*insn_slot()
do not acquire kprobe_insn_cache->mutex. This allows us to call it
from call_rcu() callback function.

For this purpose, this introduces flip-flop dirty generation in
kprobe_insn_cache. When __free_insn_slot() is called, if a slot
is dirty (this means it can be in use even after RCU grace period),
it marks as "current-generation" dirty. The garbage collector
(kprobe_insn_cache_gc()) flips the generation bit, waits enough
safe period by synchronize_rcu_tasks(), and collect "previous-
generation" dirty slots. In the results, it collects the dirty
slots which was returned by __free_insn_slot() before the GC
starts waiting the period (and the dirty slots which is returned
while the safe period, will be marked as new-generation dirty.)
Since the GC is not concurrently running, we do not need more
than 2 generations. So it flips the generation bit instead of
counting it up.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/powerpc/kernel/optprobes.c |    1 
 include/linux/kprobes.h         |    2 
 kernel/kprobes.c                |  172 ++++++++++++++++++++++-----------------
 3 files changed, 96 insertions(+), 79 deletions(-)

diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 024f7aad1952..8304f3814515 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -53,7 +53,6 @@ struct kprobe_insn_cache kprobe_ppc_optinsn_slots = {
 	/* insn_size initialized later */
 	.alloc = __ppc_alloc_insn_page,
 	.free = __ppc_free_insn_page,
-	.nr_garbage = 0,
 };
 
 /*
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0f832817fca3..1cd53b7b8409 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -244,7 +244,7 @@ struct kprobe_insn_cache {
 	void (*free)(void *);	/* free insn page */
 	struct list_head pages; /* list of kprobe_insn_page */
 	size_t insn_size;	/* size of instruction slot */
-	int nr_garbage;
+	int generation;		/* dirty generation */
 	struct work_struct work;
 };
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 60ffc9d54d87..5c12eb7fa8e1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -90,8 +90,7 @@ struct kprobe_insn_page {
 	struct rcu_head rcu;
 	kprobe_opcode_t *insns;		/* Page of instruction slots */
 	struct kprobe_insn_cache *cache;
-	int nused;
-	int ngarbage;
+	atomic_t nused;
 	char slot_used[];
 };
 
@@ -106,8 +105,9 @@ static int slots_per_page(struct kprobe_insn_cache *c)
 
 enum kprobe_slot_state {
 	SLOT_CLEAN = 0,
-	SLOT_DIRTY = 1,
-	SLOT_USED = 2,
+	SLOT_USED = 1,
+	SLOT_DIRTY0 = 2,
+	SLOT_DIRTY1 = 3,
 };
 
 void __weak *alloc_insn_page(void)
@@ -126,7 +126,6 @@ struct kprobe_insn_cache kprobe_insn_slots = {
 	.free = free_insn_page,
 	.pages = LIST_HEAD_INIT(kprobe_insn_slots.pages),
 	.insn_size = MAX_INSN_SIZE,
-	.nr_garbage = 0,
 	.work = __WORK_INITIALIZER(kprobe_insn_slots.work,
 				   kprobe_insn_cache_gc),
 };
@@ -137,6 +136,22 @@ static void kick_kprobe_insn_cache_gc(struct kprobe_insn_cache *c)
 		schedule_work(&c->work);
 }
 
+static void *try_to_get_clean_slot(struct kprobe_insn_page *kip)
+{
+	struct kprobe_insn_cache *c = kip->cache;
+	int i;
+
+	for (i = 0; i < slots_per_page(c); i++) {
+		if (kip->slot_used[i] == SLOT_CLEAN) {
+			kip->slot_used[i] = SLOT_USED;
+			atomic_inc(&kip->nused);
+			return kip->insns + (i * c->insn_size);
+		}
+	}
+
+	return NULL;
+}
+
 /**
  * __get_insn_slot() - Find a slot on an executable page for an instruction.
  * We allocate an executable page if there's no room on existing ones.
@@ -145,25 +160,20 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 {
 	struct kprobe_insn_page *kip;
 	kprobe_opcode_t *slot = NULL;
+	bool reclaimable = false;
 
 	/* Since the slot array is not protected by rcu, we need a mutex */
 	mutex_lock(&c->mutex);
 	list_for_each_entry(kip, &c->pages, list) {
-		if (kip->nused < slots_per_page(c)) {
-			int i;
-			for (i = 0; i < slots_per_page(c); i++) {
-				if (kip->slot_used[i] == SLOT_CLEAN) {
-					kip->slot_used[i] = SLOT_USED;
-					kip->nused++;
-					slot = kip->insns + (i * c->insn_size);
-					goto out;
-				}
-			}
-			/* kip->nused is broken. Fix it. */
-			kip->nused = slots_per_page(c);
-			WARN_ON(1);
+		if (atomic_read(&kip->nused) < slots_per_page(c)) {
+			slot = try_to_get_clean_slot(kip);
+			if (slot)
+				goto out;
+			reclaimable = true;
 		}
 	}
+	if (reclaimable)
+		kick_kprobe_insn_cache_gc(c);
 
 	/* All out of space. Need to allocate a new page. */
 	kip = kmalloc(KPROBE_INSN_PAGE_SIZE(slots_per_page(c)), GFP_KERNEL);
@@ -183,8 +193,7 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	INIT_LIST_HEAD(&kip->list);
 	memset(kip->slot_used, SLOT_CLEAN, slots_per_page(c));
 	kip->slot_used[0] = SLOT_USED;
-	kip->nused = 1;
-	kip->ngarbage = 0;
+	atomic_set(&kip->nused, 1);
 	kip->cache = c;
 	list_add_rcu(&kip->list, &c->pages);
 	slot = kip->insns;
@@ -193,90 +202,106 @@ kprobe_opcode_t *__get_insn_slot(struct kprobe_insn_cache *c)
 	return slot;
 }
 
-static void free_kprobe_insn_page(struct rcu_head *head)
+static void free_kprobe_insn_page_cb(struct rcu_head *head)
 {
 	struct kprobe_insn_page *kip = container_of(head, typeof(*kip), rcu);
 
 	kfree(kip);
 }
 
-/* Return 1 if all garbages are collected, otherwise 0. */
-static int collect_one_slot(struct kprobe_insn_page *kip, int idx)
+static void free_kprobe_insn_page(struct kprobe_insn_page *kip)
 {
-	kip->slot_used[idx] = SLOT_CLEAN;
-	kip->nused--;
-	if (kip->nused == 0) {
-		/*
-		 * Page is no longer in use.  Free it unless
-		 * it's the last one.  We keep the last one
-		 * so as not to have to set it up again the
-		 * next time somebody inserts a probe.
-		 */
-		if (!list_is_singular(&kip->list)) {
-			list_del_rcu(&kip->list);
-			kip->cache->free(kip->insns);
-			call_rcu(&kip->rcu, free_kprobe_insn_page);
-		}
-		return 1;
+	if (WARN_ON_ONCE(atomic_read(&kip->nused) != 0))
+		return;
+	/*
+	 * Page is no longer in use.  Free it unless
+	 * it's the last one.  We keep the last one
+	 * so as not to have to set it up again the
+	 * next time somebody inserts a probe.
+	 */
+	if (!list_is_singular(&kip->list)) {
+		list_del_rcu(&kip->list);
+		kip->cache->free(kip->insns);
+		call_rcu(&kip->rcu, free_kprobe_insn_page_cb);
 	}
-	return 0;
 }
 
 void kprobe_insn_cache_gc(struct work_struct *work)
 {
 	struct kprobe_insn_cache *c = container_of(work, typeof(*c), work);
 	struct kprobe_insn_page *kip, *next;
+	int dirtygen = c->generation ? SLOT_DIRTY1 : SLOT_DIRTY0;
+	int i, nr;
 
 	mutex_lock(&c->mutex);
+
+	c->generation ^= 1;	/* flip generation (0->1, 1->0) */
+
+	/* Make sure the generation update is shown in __free_insn_slot() */
+	smp_wmb();
+
 	/* Ensure no-one is running on the garbages. */
 	synchronize_rcu_tasks();
 
 	list_for_each_entry_safe(kip, next, &c->pages, list) {
-		int i;
-		if (kip->ngarbage == 0)
-			continue;
-		kip->ngarbage = 0;	/* we will collect all garbages */
+		nr = 0;
+		/* Reclaim previous generation dirty slots */
 		for (i = 0; i < slots_per_page(c); i++) {
-			if (kip->slot_used[i] == SLOT_DIRTY &&
-			    collect_one_slot(kip, i))
-				break;
+			if (kip->slot_used[i] == dirtygen)
+				kip->slot_used[i] = SLOT_CLEAN;
+			else if (kip->slot_used[i] != SLOT_CLEAN)
+				nr++;
 		}
+		if (!nr)
+			free_kprobe_insn_page(kip);
 	}
-	c->nr_garbage = 0;
 	mutex_unlock(&c->mutex);
 }
 
+static struct kprobe_insn_page *
+find_kprobe_insn_page(struct kprobe_insn_cache *c, unsigned long addr)
+{
+	struct kprobe_insn_page *kip;
+
+	list_for_each_entry_rcu(kip, &c->pages, list) {
+		if (addr >= (unsigned long)kip->insns &&
+		    addr < (unsigned long)kip->insns + PAGE_SIZE)
+			return kip;
+	}
+	return NULL;
+}
+
 void __free_insn_slot(struct kprobe_insn_cache *c,
 		      kprobe_opcode_t *slot, int dirty)
 {
 	struct kprobe_insn_page *kip;
+	int dirtygen;
 	long idx;
 
-	mutex_lock(&c->mutex);
-	list_for_each_entry(kip, &c->pages, list) {
+	rcu_read_lock();
+	kip = find_kprobe_insn_page(c, (unsigned long)slot);
+	if (kip) {
 		idx = ((long)slot - (long)kip->insns) /
 			(c->insn_size * sizeof(kprobe_opcode_t));
-		if (idx >= 0 && idx < slots_per_page(c))
+		/* Check double free */
+		if (WARN_ON(kip->slot_used[idx] != SLOT_USED))
 			goto out;
-	}
-	/* Could not find this slot. */
-	WARN_ON(1);
-	kip = NULL;
+
+		/* Make sure to use new generation */
+		smp_rmb();
+
+		dirtygen = c->generation ? SLOT_DIRTY1 : SLOT_DIRTY0;
+		if (dirty)
+			kip->slot_used[idx] = dirtygen;
+		else
+			kip->slot_used[idx] = SLOT_CLEAN;
+
+		if (!atomic_dec_return(&kip->nused))
+			kick_kprobe_insn_cache_gc(c);
+	} else
+		WARN_ON(1);	/* Not found: what happen? */
 out:
-	/* Mark and sweep: this may sleep */
-	if (kip) {
-		/* Check double free */
-		WARN_ON(kip->slot_used[idx] != SLOT_USED);
-		if (dirty) {
-			kip->slot_used[idx] = SLOT_DIRTY;
-			kip->ngarbage++;
-			if (++c->nr_garbage > slots_per_page(c))
-				kick_kprobe_insn_cache_gc(c);
-		} else {
-			collect_one_slot(kip, idx);
-		}
-	}
-	mutex_unlock(&c->mutex);
+	rcu_read_unlock();
 }
 
 /*
@@ -286,17 +311,11 @@ void __free_insn_slot(struct kprobe_insn_cache *c,
  */
 bool __is_insn_slot_addr(struct kprobe_insn_cache *c, unsigned long addr)
 {
-	struct kprobe_insn_page *kip;
 	bool ret = false;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(kip, &c->pages, list) {
-		if (addr >= (unsigned long)kip->insns &&
-		    addr < (unsigned long)kip->insns + PAGE_SIZE) {
-			ret = true;
-			break;
-		}
-	}
+	if (find_kprobe_insn_page(c, addr))
+		ret = true;
 	rcu_read_unlock();
 
 	return ret;
@@ -310,7 +329,6 @@ struct kprobe_insn_cache kprobe_optinsn_slots = {
 	.free = free_insn_page,
 	.pages = LIST_HEAD_INIT(kprobe_optinsn_slots.pages),
 	/* .insn_size is initialized later */
-	.nr_garbage = 0,
 	.work = __WORK_INITIALIZER(kprobe_optinsn_slots.work,
 				   kprobe_insn_cache_gc),
 };

