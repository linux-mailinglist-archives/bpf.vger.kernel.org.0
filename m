Return-Path: <bpf+bounces-51347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA385A3361E
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C682167DE4
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025712046A0;
	Thu, 13 Feb 2025 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhBnrfD3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067F9476
	for <bpf@vger.kernel.org>; Thu, 13 Feb 2025 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739417769; cv=none; b=e55ufMJXY0pJ9UDUxKPuwLamG71R5GfLVDvulZPoJTGjjNSVuPrj7WLR9LRHbz6wLfiPRIvndEV0YMwT+bSg5nFN8Tj8BKoIQjkN9/hBDHS7RD7GMgJw7pvUQZkiaq+t0kcqZfn6HI/nayL1QYR/SMQq+gy1DnddKqCvjP19W1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739417769; c=relaxed/simple;
	bh=OMlqbXvLNTOITMc0brgNOKHtyzI37JuMHtdWinMtXKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YMDaD1J9dYGhblDuaugSGs2ctDygD+CsL6eICDfxzI/pEPomC/EMPEpqnrG7SEkz42K9WIGlWbnsKV+hjfB8dtvv0DZv04VtFU0eY0hKi72NstJ0MRb6p6m2zOV8Ga5WVDOqvF1ozFE1hkFTGr6F2VswcjZX0S+jPLYSOS+bb3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhBnrfD3; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f44353649aso713236a91.0
        for <bpf@vger.kernel.org>; Wed, 12 Feb 2025 19:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739417766; x=1740022566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzTu73HDNMqdVTVLzxRBLMiERoGgzud+lLSX9AZjyIs=;
        b=UhBnrfD3Ijqkkt15uQVVpq2P8qF3kwkapDDgw+Im+RplWhUvUOb5/Zgfv3eqv1JAA5
         Jh7c5GRB5+9zRqPefvasSTwl0Du5z/xIG/JfZd8KtwODoJllB54b2FTPMFoNR1kWTR6W
         yBhUzz+K+VbVqGdFLZNRB8Z4KoLBuebenj2etF3wcHQ/xoeZBkhNTG0KBJ10ysvvfWsV
         AW78qOPjITzyOj8Ji93WHfiXBxFNxTveQTMPvE2CC1FuJt7VK/Q66+ElYVa31nw2oqXk
         vaDsdGWjnbgQehejVJgueT8DbCjjQ/+RbQOMklR9RIhsLEZrNetPXzjNh4zOOFCtfIi1
         LxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739417766; x=1740022566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzTu73HDNMqdVTVLzxRBLMiERoGgzud+lLSX9AZjyIs=;
        b=ctIUpmwIcdiPUloBLNHSBzHTmWnGTwnvRi0wlMbTFbK5SzU32WZjdNkQPObuBR2Ybe
         RZC6LbhR+V6J5FuXS0EamWXZpWoIETqNoGbzEkt2xsvFcJV3MSanAn7ag/VrTg0bAaNO
         r+bbsftt+XKXhfNibwOcNIUEwKtGaw0Qa/MASrQ0YH65/Ko5S6Hgnz/5xCuxpXYBjRuR
         TG183Y8w5GVXbWls0nwZcd95f4Mcgd9Zmrc570G3r7wHZPwwfsClvSzPSaqyPVQ3xuQ/
         LBQqwopu9aTfpaTrploH5aiVfEtWIW93OucdbE6Dheb725mql+aJPuPaMy5yNZwSsTvM
         Fsyg==
X-Gm-Message-State: AOJu0YzTysiXzzgxBsI8nPzFpelAFntxfouObBBZJTDBZJL2P8JEM8hN
	5TtqRm3PIXiyWrVdyfEnG6dlvshk+rOgVunH9NCO6D+t90p/lV3hyuKYrA==
X-Gm-Gg: ASbGnctQTDu3SLPA5QzuFp5/awYr4fBI2MH+DD7McqtzAwpyd7MidrTaiT7boONmrty
	jEebCaT6j4N6IQzuJdcB4oYgDXyJaEza4pKJ9OnbmIn3WLq4Wcve4iOlkG5z3Vj2Iea1c0LNa5O
	+oyuDXMCqudY57T0DPNkcUs08kz8Nfy5PqctVz+S5emzO4h4PDEBkK1pM0djGpiO82VWU8U3JZ0
	cSNJxqKBDty8S9zLw3AqPrNauYDYyFTGVRbyG6fEmLrQY2TzpN1tIfzFL1qBxDi73jgi7EeOb9M
	L+O5jk8nMGRQodIdWdaOJQ/8JjimXCBMVbv0xBCD3kSbHl7MUA==
X-Google-Smtp-Source: AGHT+IHwW0mWciqg0xYIxqI4O6t3z/9NXB3Y7q2juLoIWFRHSivyRpyZDeMZECumFXMCEhZFV6jUHg==
X-Received: by 2002:a17:90a:d404:b0:2ea:3f34:f190 with SMTP id 98e67ed59e1d1-2fbf91067abmr7466225a91.25.1739417766159;
        Wed, 12 Feb 2025 19:36:06 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9ab0233sm2256043a91.44.2025.02.12.19.36.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 12 Feb 2025 19:36:05 -0800 (PST)
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
Subject: [PATCH bpf-next v8 2/6] mm, bpf: Introduce free_pages_nolock()
Date: Wed, 12 Feb 2025 19:35:52 -0800
Message-Id: <20250213033556.9534-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
References: <20250213033556.9534-1-alexei.starovoitov@gmail.com>
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
index 0404c4c0dfc7..3fbcbeb7de8e 100644
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


