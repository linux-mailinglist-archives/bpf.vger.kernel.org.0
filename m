Return-Path: <bpf+bounces-49643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1DCA1AF34
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DC8168F5D
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807A31D7999;
	Fri, 24 Jan 2025 03:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVM/IjmB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2BC1D5CD7
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691028; cv=none; b=MV3BxOA1rDhGfK2ljWcxWYxLO4NwIbwWo2Bl9w/n47WaRYDDjqwfJ6mtL/jLwYpBgeICBQiP2DrW2uVKIa5vV58AE6INgMN2sW13R81ev3ziscIoSW1cJ1Gi0CQuxmPy0ShX1uK8tXXwvW0BbJQyNXxibpm8Wlb3dUSOWsHHLIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691028; c=relaxed/simple;
	bh=ycjmyv+0eFg+yrY+J9OUW+woZ90LXfMcS86TmoA5qD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHNMn5JV10eErOtdlOyUm5MuLNZ5332ckeCOaKwbR7ePfiEcGKTSqmW+8OuSO0Yqn5UnJ1wWwOVnx5cJDpPUjv4lxqgPR6yvvTz+2p3P5aE9nfzw4wyh7xxG8779uicnHzUK070pBLE/tGgvkap+t1DEUMAC7Z6vjh85H4alH54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVM/IjmB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21619108a6bso27395185ad.3
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737691025; x=1738295825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fz2IAlBDxhiT58/U161LSQMwkAoY7PfGXhcEsriHk/0=;
        b=YVM/IjmBQ0iIbB0stoMZTdT7oAc3hhQon/l1qg0K+Yqwo6HH27KrH+edkLlOMLJTQY
         tp+KlxW810tyUaxuftsIsVwumsHP88IxW/i9hWcmXTErabjfsaxw8ES2horihETlw39C
         oaOMrjjxc/XT9b4uqaqokyNQm4E5SgXNe0Rvn4SiNm47NVYr1rkPBi+lSimwMr0xH+i8
         fGbnYnsiNxQJgkwsEMSx8b1GRE01j6pNRwp/gDR/pX7BlAUY5Hqdw9yZXDhaoXMRsr7v
         b4uL+Q7g98fMB/ZIlrxMBWzyCYWmX0iFCrGzERH3bFc0UqARmj52TdJqapnyS7xdMuLv
         JVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691025; x=1738295825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fz2IAlBDxhiT58/U161LSQMwkAoY7PfGXhcEsriHk/0=;
        b=qMAfBhLAMdD8LCk7NQ7bFc9eoB8FHIH/uflUTYHyDWqucKPofd4kLWQlLlaIcjNqNZ
         aXzGcVP3T9m1aT6opjUOVhZsUhiaC9H5TASul2sgVL11X1wakCfoDqs3B/j1TxX78GsI
         M4G8p9NKuE3aJnLIGr5YhFtvSdjRi+bcCpWvFuhR+Yii8h1sbvYiUYmGz4QB/orPKxbi
         vmamDTPx270xEsqjiOHm+AjTXl5meCD9IR8HRnyG9wZ6CalErlE3RqlEIm9B9g9i3pgt
         eymB+pnNEmAQufNBGwMEwAQlSobRwW4Bbk/XuoRCRfu7/gPGEee+alpGxu1fNX1lLJBl
         YVLg==
X-Gm-Message-State: AOJu0Yzho+UiXMlN9wuXjmebbU4XxE4/a5ZiWfgmd0irLI2cAxYKiAF6
	0+o09OQebTg5w9VJNqT4zNxDmLlQZ13wgQQAJsu3QeRcDXCZfRW5RNEuUg==
X-Gm-Gg: ASbGncu20afofyX1bQkF5hV9GYgrJ06PT6ld7RTqw5bzal8vbeU6HPzPUG7bAxow/ge
	PBBY+fqOPFNNfOBQj4AQc4XTarhlEVyUHXbc580Dqfyu5/xQVjPGjlRu33Cs9HrmAInBII47tEQ
	Zx9lQaSRK+Ka6LMd5SyBFOFyyBdUTf5frdxS/yRFZWGNTlM+50Zs71Dqh1pRmXmDUC6kT18h4aI
	YZtASO6kl63uYsMV7EvsdcxFbkxqWljUKtHlHx3mhFry+ZpBC3d5BA6cUXtNhk1dRnZuAoZfXwu
	w88hHz9jV5edqoMGZkhvc3/kPBdDZhRBB1Rh80k=
X-Google-Smtp-Source: AGHT+IHZeimjkRMY4H4j9FWOv2afkQfL53TrxMWXGw2hDPca6jWcxwmgWQSstHxk/bosCoPa9wzktQ==
X-Received: by 2002:a17:902:e84c:b0:216:6769:9eca with SMTP id d9443c01a7336-21c355b9442mr374872965ad.37.1737691024611;
        Thu, 23 Jan 2025 19:57:04 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm6640485ad.121.2025.01.23.19.57.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 19:57:04 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	bigeasy@linutronix.de,
	rostedt@goodmis.org,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	willy@infradead.org,
	tglx@linutronix.de,
	jannh@google.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 2/6] mm, bpf: Introduce free_pages_nolock()
Date: Thu, 23 Jan 2025 19:56:51 -0800
Message-Id: <20250124035655.78899-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce free_pages_nolock() that can free pages without taking locks.
It relies on trylock and can be called from any context.
Since spin_trylock() cannot be used in PREEMPT_RT from hard IRQ or NMI
it uses lockless link list to stash the pages which will be freed
by subsequent free_pages() from good context.

Do not use llist unconditionally. BPF maps continuously
allocate/free, so we cannot unconditionally delay the freeing to
llist. When the memory becomes free make it available to the
kernel and BPF users right away if possible, and fallback to
llist as the last resort.

Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h      |  1 +
 include/linux/mm_types.h |  4 ++
 include/linux/mmzone.h   |  3 ++
 lib/stackdepot.c         |  5 ++-
 mm/page_alloc.c          | 90 +++++++++++++++++++++++++++++++++++-----
 mm/page_owner.c          |  8 +++-
 6 files changed, 98 insertions(+), 13 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 82bfb65b8d15..a8233d09acfa 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -391,6 +391,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
 	__get_free_pages((gfp_mask) | GFP_DMA, (order))
 
 extern void __free_pages(struct page *page, unsigned int order);
+extern void free_pages_nolock(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
 
 #define __free_page(page) __free_pages((page), 0)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 825c04b56403..583bf59e2627 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -99,6 +99,10 @@ struct page {
 				/* Or, free page */
 				struct list_head buddy_list;
 				struct list_head pcp_list;
+				struct {
+					struct llist_node pcp_llist;
+					unsigned int order;
+				};
 			};
 			/* See page-flags.h for PAGE_MAPPING_FLAGS */
 			struct address_space *mapping;
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b36124145a16..1a854e0a9e3b 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -953,6 +953,9 @@ struct zone {
 	/* Primarily protects free_area */
 	spinlock_t		lock;
 
+	/* Pages to be freed when next trylock succeeds */
+	struct llist_head	trylock_free_pages;
+
 	/* Write-intensive fields used by compaction and vmstats. */
 	CACHELINE_PADDING(_pad2_);
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 377194969e61..73d7b50924ef 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -672,7 +672,10 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 exit:
 	if (prealloc) {
 		/* Stack depot didn't use this memory, free it. */
-		free_pages((unsigned long)prealloc, DEPOT_POOL_ORDER);
+		if (!allow_spin)
+			free_pages_nolock(virt_to_page(prealloc), DEPOT_POOL_ORDER);
+		else
+			free_pages((unsigned long)prealloc, DEPOT_POOL_ORDER);
 	}
 	if (found)
 		handle = found->handle.handle;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a82bc67abbdb..fa750c46e0fc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -88,6 +88,9 @@ typedef int __bitwise fpi_t;
  */
 #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
 
+/* Free the page without taking locks. Rely on trylock only. */
+#define FPI_TRYLOCK		((__force fpi_t)BIT(2))
+
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
 static DEFINE_MUTEX(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_HIGH_FRACTION (8)
@@ -1249,13 +1252,44 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	} while (1);
 }
 
+static void add_page_to_zone_llist(struct zone *zone, struct page *page,
+				   unsigned int order)
+{
+	/* Remember the order */
+	page->order = order;
+	/* Add the page to the free list */
+	llist_add(&page->pcp_llist, &zone->trylock_free_pages);
+}
+
 static void free_one_page(struct zone *zone, struct page *page,
 			  unsigned long pfn, unsigned int order,
 			  fpi_t fpi_flags)
 {
+	struct llist_head *llhead;
 	unsigned long flags;
 
-	spin_lock_irqsave(&zone->lock, flags);
+	if (!spin_trylock_irqsave(&zone->lock, flags)) {
+		if (unlikely(fpi_flags & FPI_TRYLOCK)) {
+			add_page_to_zone_llist(zone, page, order);
+			return;
+		}
+		spin_lock_irqsave(&zone->lock, flags);
+	}
+
+	/* The lock succeeded. Process deferred pages. */
+	llhead = &zone->trylock_free_pages;
+	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_TRYLOCK))) {
+		struct llist_node *llnode;
+		struct page *p, *tmp;
+
+		llnode = llist_del_all(llhead);
+		llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
+			unsigned int p_order = p->order;
+
+			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
+			__count_vm_events(PGFREE, 1 << p_order);
+		}
+	}
 	split_large_buddy(zone, page, pfn, order, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
@@ -2598,7 +2632,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 				   struct page *page, int migratetype,
-				   unsigned int order)
+				   unsigned int order, fpi_t fpi_flags)
 {
 	int high, batch;
 	int pindex;
@@ -2633,6 +2667,14 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 	}
 	if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
 		pcp->free_count += (1 << order);
+
+	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
+		/*
+		 * Do not attempt to take a zone lock. Let pcp->count get
+		 * over high mark temporarily.
+		 */
+		return;
+	}
 	high = nr_pcp_high(pcp, zone, batch, free_high);
 	if (pcp->count >= high) {
 		free_pcppages_bulk(zone, nr_pcp_free(pcp, batch, high, free_high),
@@ -2647,7 +2689,8 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 /*
  * Free a pcp page
  */
-void free_unref_page(struct page *page, unsigned int order)
+static void __free_unref_page(struct page *page, unsigned int order,
+			      fpi_t fpi_flags)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
@@ -2656,7 +2699,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	int migratetype;
 
 	if (!pcp_allowed_order(order)) {
-		__free_pages_ok(page, order, FPI_NONE);
+		__free_pages_ok(page, order, fpi_flags);
 		return;
 	}
 
@@ -2673,24 +2716,34 @@ void free_unref_page(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(page_zone(page), page, pfn, order, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, order, fpi_flags);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
 	}
 
 	zone = page_zone(page);
+	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
+		     && (in_nmi() || in_hardirq()))) {
+		add_page_to_zone_llist(zone, page, order);
+		return;
+	}
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, migratetype, order);
+		free_unref_page_commit(zone, pcp, page, migratetype, order, fpi_flags);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, FPI_NONE);
+		free_one_page(zone, page, pfn, order, fpi_flags);
 	}
 	pcp_trylock_finish(UP_flags);
 }
 
+void free_unref_page(struct page *page, unsigned int order)
+{
+	__free_unref_page(page, order, FPI_NONE);
+}
+
 /*
  * Free a batch of folios
  */
@@ -2779,7 +2832,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype,
-				order);
+				       order, FPI_NONE);
 	}
 
 	if (pcp) {
@@ -4843,22 +4896,37 @@ EXPORT_SYMBOL(get_zeroed_page_noprof);
  * Context: May be called in interrupt context or while holding a normal
  * spinlock, but not in NMI context or while holding a raw spinlock.
  */
-void __free_pages(struct page *page, unsigned int order)
+static void ___free_pages(struct page *page, unsigned int order,
+			  fpi_t fpi_flags)
 {
 	/* get PageHead before we drop reference */
 	int head = PageHead(page);
 	struct alloc_tag *tag = pgalloc_tag_get(page);
 
 	if (put_page_testzero(page))
-		free_unref_page(page, order);
+		__free_unref_page(page, order, fpi_flags);
 	else if (!head) {
 		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
 		while (order-- > 0)
-			free_unref_page(page + (1 << order), order);
+			__free_unref_page(page + (1 << order), order,
+					  fpi_flags);
 	}
 }
+void __free_pages(struct page *page, unsigned int order)
+{
+	___free_pages(page, order, FPI_NONE);
+}
 EXPORT_SYMBOL(__free_pages);
 
+/*
+ * Can be called while holding raw_spin_lock or from IRQ and NMI for any
+ * page type (not only those that came from try_alloc_pages)
+ */
+void free_pages_nolock(struct page *page, unsigned int order)
+{
+	___free_pages(page, order, FPI_TRYLOCK);
+}
+
 void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0) {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 2d6360eaccbb..90e31d0e3ed7 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -294,7 +294,13 @@ void __reset_page_owner(struct page *page, unsigned short order)
 	page_owner = get_page_owner(page_ext);
 	alloc_handle = page_owner->handle;
 
-	handle = save_stack(GFP_NOWAIT | __GFP_NOWARN);
+	/*
+	 * Do not specify GFP_NOWAIT to make gfpflags_allow_spinning() == false
+	 * to prevent issues in stack_depot_save().
+	 * This is similar to try_alloc_pages() gfp flags, but only used
+	 * to signal stack_depot to avoid spin_locks.
+	 */
+	handle = save_stack(__GFP_NOWARN);
 	__update_page_owner_free_handle(page_ext, handle, order, current->pid,
 					current->tgid, free_ts_nsec);
 	page_ext_put(page_ext);
-- 
2.43.5


