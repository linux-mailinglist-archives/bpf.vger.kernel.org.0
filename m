Return-Path: <bpf+bounces-48729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFABFA0FE9F
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 03:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C4CC3A2992
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 02:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A59B22FE1D;
	Tue, 14 Jan 2025 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLJdIbX1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E672224B0D
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821184; cv=none; b=oAM3gKf/ZP57p0ik9OJFTtI0yp1RoX4KhT55F9wr8XsSRzS0o10tLK50tDv/Z1ecx7C/2Zm32bswPkXYjqXA2m3Ein1XDUmIzCNTDR4m02dUS4kTl/nB02sWw4dsf4tce8H/FBQWPnFAZxUnA4jsUiipATRVlt8hZLgUhvPv5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821184; c=relaxed/simple;
	bh=v4yd47iyDk7L2ClxBfWHEiNosog5ZJz+TrgymKpSoSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VIs4GfJAQnGcIWb6pHuWPr9zuRC5VY+x7LHfSIfV3sHlImyXPLqfi7ax9TfVRBsRYagCi6NxFfaaT6y/TlsAhg6OWMP7KHUI3mUwSBEY1kWEDWxBaVQ+xjLBzhrp4kp1ZReOnTaa2DtM/ITIGWasurWwoyJhdvwK3fXD51deJo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLJdIbX1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2165448243fso105613265ad.1
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 18:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821181; x=1737425981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQPsX2DHIButJsUpdhJcEvvwgfeMxBo/GFMw0XDovgw=;
        b=QLJdIbX1b7bBNIQkmzvEw3EylpX9GreDXkGIan2wG4iK1RVucflWwiA5ErBRWtvok7
         kHsfenrxG8k/TyIc1iWRVWwwHWI6VZIppAZYAXJBYceB5SYvy8dMNR86SEnqxSkJSDSn
         CO3cfVyeymVd/WjNpc84uJV2Z5yKVw0YVrlqtuboGZbPh6RrNkso1h5zioKbz0i0UPRV
         CMJc15FF9aR7yQDwldYe9PXLBDTfrcnQsxrEBxFG9jd4bkwkcmdnXQk0Ua30eu+Rt7tv
         emmP+XS57MyG9f3pAUg5EryAFsxyAhteVKhZD+J+hYNeqKrUJPShXM3dU9/PpcLwSehH
         eWnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821181; x=1737425981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQPsX2DHIButJsUpdhJcEvvwgfeMxBo/GFMw0XDovgw=;
        b=thtkrREtijwywKpsNp475yDS2r5U7gQcdYvXeGbgX7VMRx5Tm8sGVT7t06rHENpb10
         jKaIKFIBAHBVq1h1Obcct0w9x/3r944YP+bdutV+tRFd2yc/uxbcgC5RrJfRCVLy0Kp5
         hWS7RLJnn/bvSzQC0nKYpk+B8ctHzAjEblFSWv49lghHZIcelmyG/a4g3iYoNRSH9oNz
         FWwYsLg5ucdYRww4NHkAjaKbFVlkyuiE/aVGvrV+bmo8CBu2ou6dUulierqMNGMZE3qt
         NSepTvsl7oAaQ9uEiLZA9Wv97WFL3dz3IW5fuaL6wfVcDtRwvyxIO7KwDpI9qnPCZ9jp
         CTWA==
X-Gm-Message-State: AOJu0Yz7lUi9QqLBryjEavM+7UWkvb3QFjT5Mg5iN+RDmqp8P+cJSTMq
	zHv5R89zHobXc2eDO6FsGcnOif2xyR5zmS/DCOtNhZi2O/b+r42f7ISYqw==
X-Gm-Gg: ASbGnctsG9dRCFbPupxtEL7eVFhsW3KBlyqM7oaLBRMt/y2V+PJhaKNDE0hHUSLWeeG
	bT9oBIitPa9ZS/eZ/3JY8V/BtorcQGItThnflCGVawo2c2zMfyQ48VWgmjx7tJOnBoIuhvY0FV/
	3ecSwyhuE+yR6oRcVgj1xmF17S7o/CgmFnRAJSm5+yqjg3XLGHrUwiAlKNfTTcfLSVVw8pATKqA
	GYKz/51CcOPqvLSRzVhLG99+x/71OiZrY/W+gJpk+RxGmHrmx5KKKIDZ0nnmRms4eoRRgk2T0L9
	1OzOBkv4
X-Google-Smtp-Source: AGHT+IH4C8oQxYrxEc0hMPntr3TFj0/HQ3tRiTFBDtPEqYrgkCC5XatENgLtg7g5dRzWvlp6uSkr4w==
X-Received: by 2002:a17:903:1245:b0:216:48f4:4f20 with SMTP id d9443c01a7336-21a83f56f58mr324043955ad.16.1736821180973;
        Mon, 13 Jan 2025 18:19:40 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e011sm59713495ad.3.2025.01.13.18.19.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:19:40 -0800 (PST)
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
Subject: [PATCH bpf-next v4 2/6] mm, bpf: Introduce free_pages_nolock()
Date: Mon, 13 Jan 2025 18:19:18 -0800
Message-Id: <20250114021922.92609-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
References: <20250114021922.92609-1-alexei.starovoitov@gmail.com>
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
index 0f4be88ff131..f967725898be 100644
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


