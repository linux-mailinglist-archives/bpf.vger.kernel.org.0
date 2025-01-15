Return-Path: <bpf+bounces-48896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48685A11727
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD6A3A5082
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4184A5B;
	Wed, 15 Jan 2025 02:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+RmwAUE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28135229B21
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 02:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907485; cv=none; b=CaaPi9ee542yLKww7NEfDqY+4R3SpSJHGnSvsLdT+OOwQMk232SLISMUaIb9WZHMZRBHobu4yKiRpA/x6aLVos0Mc4YORkV2JEoGhU/mZbH5whDRxPzcMIBO9+rBAfrfnhfk6nzzgXPZj0Ch1B1nSOU9KlDfYSBJOFDhJ4f1Alc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907485; c=relaxed/simple;
	bh=ejEuhpoEGvyNxUp4USVtn/ell+1cuwTpjPk8SMpbUaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XnOYiqD5VUr3IyzpcXvBc0hjhWT/+NrhvC8Jl6DU+VhWGGxhy6TdnVpLXe3zHPoUmhbxQTUL375G89C30T2TeEufHBTYz0L4ZlfMi1/xZIN/nKLRL74lOd5ccTdRWpeBYgnxhkRSaO/sTlAWgC1zM7YGcpXqw7LfL/8R2+Dtcbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+RmwAUE; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21a7ed0155cso106947485ad.3
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736907483; x=1737512283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S/4MiM3RUKHfwlZ4XiouzlgmWU/NeE4CfHyc1IF4D50=;
        b=C+RmwAUEaJvANdVB8aRvdM+LkR5Z6iN8tzwRHa7gv4qRavU2InkvI1AkapyOLssNxQ
         dj8o0LSAuqZlLk0fYAcDi6ZeLGbfVNE4paxUAVZY1rR4Dl0baoCZOUJ5l7QeVLILYBkr
         fJ4iXBRMdJmFgEe8tyHJxyITg9ZXajW+aA8qEAnj9BTcpAxiwWP/6z5J7Mfr67CQ5rOg
         HYrxoqcmkSxA15oIzUVn2E5j67M5xwI94yZBHlDuDMfI4qVP/bR8RSoqW1JpSbv5/846
         4gR1QSnJlnLYV5V0mHUs2pqxZsDNNkfy4pEJigjMQMEB/IfM8lWEci2omxGzyxNm0tVK
         2kWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907483; x=1737512283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S/4MiM3RUKHfwlZ4XiouzlgmWU/NeE4CfHyc1IF4D50=;
        b=gBZz7iBnw2oLWLvAepiBNS27z2xDdVlE/++RPlqwyUmOH/PkvyBbMxnLAfG+mqCP5Q
         LajlYO7vGuwBF9jbN9eRjyLi17JlOfyryIYr/XP6VdejwDZn2chHeKD0LysZYCV42hMO
         9fQZaqKm7vMWr3pDo4DpHwuVWyNG3zLRtcnFGCHcL7owupVYPdldy+KaNdFxsmf5ONhM
         8H38vntne2+yi8G2L+zBxdw8vFzfFUpv3dzrZdkB+EZFtheCgIbYUCfeO7TgaJV24NX7
         V8H7Gv00If5hAyfaeHP3Gh709cXnIVYvDuM7GlezjrjWxayIyVSjob5vo/W/TrJ8rWxi
         pSUw==
X-Gm-Message-State: AOJu0YwWfNoYgUDrd208zZ9YHcTuYa5XAbdT/Ifd8H5jqr5fqJQgWjgW
	vVZ1OIxu9b1gNAkitymXnK2xEznldQZV4O0Tteu3oA1ustJfwFt3ErtAOg==
X-Gm-Gg: ASbGncsGBdWTSQT4C/5m1jOgC09/eM4bHeA9VcrdjgkFiwuQXbTcUsA8iVLB2NmLY0N
	tcJbCrNSj5pjq5i9byjnamEjn5EePJRqe9Z46pEAJphrnj8sT/pzkHtMW6ulcYX7jBW8l/2uHWA
	WvmLfBcX/36xOGNB4serGYuljxWONP/J1HKgr6jzzZB9q9+r2XtHCAhF+Gt32CVyW3mvCXgvKHC
	kLEkUolvJ8LYo8s20fwYCq3OiQR9fwNQ/Tzmn5XqFSnddq7pWXOPVuSOJytJk5eifB0afREHQJK
	tbupeYzh
X-Google-Smtp-Source: AGHT+IE2HSgtTwGa6fxDzYYIuEsJKl/KfTDggfWr6X8IZDgbB2AylvSlI27CX51K5j5TCNfNyEO1Hw==
X-Received: by 2002:a17:902:fb8e:b0:215:6426:30a5 with SMTP id d9443c01a7336-21a83fc150dmr338535215ad.40.1736907482518;
        Tue, 14 Jan 2025 18:18:02 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f25a583sm74065695ad.244.2025.01.14.18.18.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:18:02 -0800 (PST)
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
Subject: [PATCH bpf-next v5 2/7] mm, bpf: Introduce free_pages_nolock()
Date: Tue, 14 Jan 2025 18:17:41 -0800
Message-Id: <20250115021746.34691-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
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
Since spin_trylock() cannot be used in RT from hard IRQ or NMI
it uses lockless link list to stash the pages which will be freed
by subsequent free_pages() from good context.

Do not use llist unconditionally. BPF maps continuously
allocate/free, so we cannot unconditionally delay the freeing to
llist. When the memory becomes free make it available to the
kernel and BPF users right away if possible, and fallback to
llist as the last resort.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h      |  1 +
 include/linux/mm_types.h |  4 ++
 include/linux/mmzone.h   |  3 ++
 mm/page_alloc.c          | 79 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b41bb6e01781..6eba2d80feb8 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -391,6 +391,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
 	__get_free_pages((gfp_mask) | GFP_DMA, (order))
 
 extern void __free_pages(struct page *page, unsigned int order);
+extern void free_pages_nolock(struct page *page, unsigned int order);
 extern void free_pages(unsigned long addr, unsigned int order);
 
 #define __free_page(page) __free_pages((page), 0)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 7361a8f3ab68..52547b3e5fd8 100644
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
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 74c2a7af1a77..a9c639e3db91 100644
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
@@ -1247,13 +1250,44 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	}
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
 
@@ -2596,7 +2630,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 				   struct page *page, int migratetype,
-				   unsigned int order)
+				   unsigned int order, fpi_t fpi_flags)
 {
 	int high, batch;
 	int pindex;
@@ -2631,6 +2665,14 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
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
@@ -2645,7 +2687,8 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 /*
  * Free a pcp page
  */
-void free_unref_page(struct page *page, unsigned int order)
+static void __free_unref_page(struct page *page, unsigned int order,
+			      fpi_t fpi_flags)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
@@ -2654,7 +2697,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	int migratetype;
 
 	if (!pcp_allowed_order(order)) {
-		__free_pages_ok(page, order, FPI_NONE);
+		__free_pages_ok(page, order, fpi_flags);
 		return;
 	}
 
@@ -2671,24 +2714,33 @@ void free_unref_page(struct page *page, unsigned int order)
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
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq())) {
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
@@ -2777,7 +2829,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype,
-				order);
+				       order, FPI_NONE);
 	}
 
 	if (pcp) {
@@ -4853,6 +4905,17 @@ void __free_pages(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL(__free_pages);
 
+/*
+ * Can be called while holding raw_spin_lock or from IRQ and NMI,
+ * but only for pages that came from try_alloc_pages():
+ * order <= 3, !folio, etc
+ */
+void free_pages_nolock(struct page *page, unsigned int order)
+{
+	if (put_page_testzero(page))
+		__free_unref_page(page, order, FPI_TRYLOCK);
+}
+
 void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0) {
-- 
2.43.5


