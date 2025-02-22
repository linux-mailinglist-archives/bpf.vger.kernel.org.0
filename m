Return-Path: <bpf+bounces-52236-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A9DA40521
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D394219E0E6F
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3241FECC0;
	Sat, 22 Feb 2025 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgQ8ietc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A761FBEB3
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740192288; cv=none; b=rb0UoYpJgLVfRZoBsAlqnyG3ghoMdUXX9i6W/75YKD7qQTZsjDePA9yxN1Brd+CsOEjbRV0LuMFJddqp2TwAaeo40Y2PjYtjFezBCUaq7u+ZyZ20GOtZAL8rQCwvwP1WHIcPZLOgv7n4KGCD1e9y4ElmuxlwWzKQnKAoe654W28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740192288; c=relaxed/simple;
	bh=gwRQ71lEugoIVTP5Evm/r7Gna/77psqYrIxADXT07VA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptO6XuBjfXuC/TUb1TRtAAFjLpTM7WOFQ0f7xGfwvEYB3zvMQTwd/5E8/K+6/gUftNj7IzZHHEe++2SkBW/0HljQhiGW9Bf9NjCmMfwq93Q2FmKE6XzEpgpOE6APSUwlPV6ANaZ7WnjZVKi4ow4Zr/Iu3LdouST7MTGBnpyCtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgQ8ietc; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2211cd4463cso55986555ad.2
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 18:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740192286; x=1740797086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7gSAyaMDg2aK78kqVgF49+jZKrcrw3bhnHUdoMZI7o=;
        b=ZgQ8ietcSmaOabGztSgUq73jxfxkm4qMTfKeZfYtLHtWLALBrv0oL0rnP1vQjgl30I
         85fB8uiT++sQlxxkRFhoW1+OjsC7cwaUQGtwJbQm6fNvi8nnRx13S7CsQFvGeF5tkLUy
         eekESMUgrl5qvx/hXD2oVgvbngAEbX1NumQiP2iwzb5pd/QHMQnppqMrUe2yLB7e8np+
         4242BlJYLzjU0H77NkUSUQXxygMCSjhmr56jd8Eoxeq3XXoBt2piJWQjql4GeHmnZyQT
         TrCOtAx9RGSDp/WMyTopj5o1QmY/2BdByzgLWm2i5eROrUrRp/xoYWHAqMPt5bHXslXV
         DS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740192286; x=1740797086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7gSAyaMDg2aK78kqVgF49+jZKrcrw3bhnHUdoMZI7o=;
        b=BXt4Xv0Qhn0Av16WNfVVGFCmL5y8VngTMJxbJqvrXIYgWwAMIbQfBZ2O/31Wlomc/e
         yGKPpdRoRd2fTcdy+bgaTHFXDUYj7G5c2YJzLUDAujlhvsCU5l5x6ODMrwh3f0tdN5Fl
         EYgsfawP/fojEDtrJTzdKA1e8oIqc7X8vBkOSh5nZHC2uaIH43RSOwK3iqOEJSyU+pqO
         J13odTxQJbbfvqRmofRXHZc5igo2sUy/DZadMaV0tP9nbTnS4zmWht6rpdJjADiH5Rt2
         z1DZ0BBtlUR2+BCyxUfGDzFT5ghtQMVSzz2PJmydEfUhiHEJQrl4eR1P7ny7hEImO5Co
         vWvQ==
X-Gm-Message-State: AOJu0YwBKwyL2JpG0M1P8sU6Ulu6fkUdUWYzE4koe3x18v+Tm/RLneHe
	vcDgHvZnuSwuUSDQVDo3Bdw3bUKcqUvlYtIj47KAd8VDXalRUQ7Z1BlS3Q==
X-Gm-Gg: ASbGnctLVM3EitcemWMOpnsIABJGHAT3Vqut5+f81DYeI4fJTR183I1YPbneXsE/nGV
	rzhVavsrnUW4cGVUWJxbbub3ThHM8ELf7/OtP+r1kMSlPFodkoueSeaVhGm8Gp9snEra6wcLXgB
	pZc1JCMi0uSurMZGXnBykozFD6omkNQOnblLOpSOu1qXGzzA3exx5XaDTvKY7ISsluPF5jWmxJp
	lqcCzE96YB+HczfNLvx3UFJIz3rS4knYuSNhs6zMYKVakNq9/4r5K4VJhvlJzAkAmbq7ihtM4S0
	y6fsdIWpq+K2BNd+639LqWYxEL9fNZ7Ovram4gsbMPQQvK/5hJ7Wrg==
X-Google-Smtp-Source: AGHT+IH21mr57VC26OTPfaSlSbo/9B6lZeQIfI31TFaxfhjBWjCtyIwbhx9A5VtfOfNAoOWI2FAXPA==
X-Received: by 2002:a05:6a20:2444:b0:1ee:d06c:cddc with SMTP id adf61e73a8af0-1eef3da4cf2mr11663031637.30.1740192285626;
        Fri, 21 Feb 2025 18:44:45 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fd1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73242568b03sm16979202b3a.54.2025.02.21.18.44.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 18:44:45 -0800 (PST)
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
Subject: [PATCH bpf-next v9 3/6] mm, bpf: Introduce free_pages_nolock()
Date: Fri, 21 Feb 2025 18:44:24 -0800
Message-Id: <20250222024427.30294-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
References: <20250222024427.30294-1-alexei.starovoitov@gmail.com>
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
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
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
index 5d9ee78c74e4..ceb226c2e25c 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -379,6 +379,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
 	__get_free_pages((gfp_mask) | GFP_DMA, (order))
 
 extern void __free_pages(struct page *page, unsigned int order);
+extern void free_pages_nolock(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
 
 #define __free_page(page) __free_pages((page), 0)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6b27db7f9496..483aa90242cd 100644
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
index 9540b41894da..e16939553930 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -972,6 +972,9 @@ struct zone {
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
index 1f2a4e1c70ae..79b39ad4bb1b 100644
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
 
@@ -2599,7 +2633,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 
 static void free_frozen_page_commit(struct zone *zone,
 		struct per_cpu_pages *pcp, struct page *page, int migratetype,
-		unsigned int order)
+		unsigned int order, fpi_t fpi_flags)
 {
 	int high, batch;
 	int pindex;
@@ -2634,6 +2668,14 @@ static void free_frozen_page_commit(struct zone *zone,
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
@@ -2648,7 +2690,8 @@ static void free_frozen_page_commit(struct zone *zone,
 /*
  * Free a pcp page
  */
-void free_frozen_pages(struct page *page, unsigned int order)
+static void __free_frozen_pages(struct page *page, unsigned int order,
+				fpi_t fpi_flags)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
@@ -2657,7 +2700,7 @@ void free_frozen_pages(struct page *page, unsigned int order)
 	int migratetype;
 
 	if (!pcp_allowed_order(order)) {
-		__free_pages_ok(page, order, FPI_NONE);
+		__free_pages_ok(page, order, fpi_flags);
 		return;
 	}
 
@@ -2675,23 +2718,33 @@ void free_frozen_pages(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(zone, page, pfn, order, FPI_NONE);
+			free_one_page(zone, page, pfn, order, fpi_flags);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
 	}
 
+	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
+		     && (in_nmi() || in_hardirq()))) {
+		add_page_to_zone_llist(zone, page, order);
+		return;
+	}
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_frozen_page_commit(zone, pcp, page, migratetype, order);
+		free_frozen_page_commit(zone, pcp, page, migratetype, order, fpi_flags);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, FPI_NONE);
+		free_one_page(zone, page, pfn, order, fpi_flags);
 	}
 	pcp_trylock_finish(UP_flags);
 }
 
+void free_frozen_pages(struct page *page, unsigned int order)
+{
+	__free_frozen_pages(page, order, FPI_NONE);
+}
+
 /*
  * Free a batch of folios
  */
@@ -2780,7 +2833,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_frozen_page_commit(zone, pcp, &folio->page, migratetype,
-				order);
+					order, FPI_NONE);
 	}
 
 	if (pcp) {
@@ -4841,22 +4894,37 @@ EXPORT_SYMBOL(get_zeroed_page_noprof);
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
-		free_frozen_pages(page, order);
+		__free_frozen_pages(page, order, fpi_flags);
 	else if (!head) {
 		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
 		while (order-- > 0)
-			free_frozen_pages(page + (1 << order), order);
+			__free_frozen_pages(page + (1 << order), order,
+					    fpi_flags);
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


