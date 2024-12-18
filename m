Return-Path: <bpf+bounces-47176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4E29F5D3A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B963164ED3
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3777213D638;
	Wed, 18 Dec 2024 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0HEmzvy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3A7082E
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491257; cv=none; b=LoBnealD8ek/8EmYvgaRMTeH9OCUUN9f2EvHzy4HGlMhgCJ2Mapt2yDtGcL89YInhq14SOJdC4v07WNTBAz9jjFhyY2vevWLyHJI7rKa2pvZ7M+3/Gzzp1Eq1iLBXkOKvJhFob25qiYedoVME1chRZ1NVxftcBlyiY53b/KWhh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491257; c=relaxed/simple;
	bh=7U4RQR257f4iYZJPPw0P6oyJlt1ll7MxTT5kfFwF/HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icCpcCUnzdRr22MOSA2ph72czc44umaKg0ijYIHbL0rHceh7HIIwRmt1VRfbCsB2VZGlNuZxYTyVpFFBO6RzbsnAQql/zSbyeGbZ1KsdHUKe/UXH8Z6IcZtlke1Jdca+ezZNmPIdPEjbYuXkw6haAfkz9KgT9wubrQt+8FaMwcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0HEmzvy; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f2d8f62290so2953787eaf.2
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 19:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734491255; x=1735096055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgdU2JbWztEEEhB3TtDMib8w6jV6+vZNMAAIDtQqMFA=;
        b=I0HEmzvykuDrn/kERZb+B0YKDCAl6VsvvazmaMNEbWrsmLoxB4D5F8EX+mwEwnN5Rt
         cH0f27Bo6HmwubCW2V1aWHfQoanxhwI8fYlfahv9PAzTWUCeUNusQTS2avxpIj4WL3UF
         yUYz6Ad1N+mvdojU9inEqqKD/Z8qaaVyJ2aDxJB76gHA0FLmStjsTRGDDWDPPHSvj8t6
         zOe5YUXfdElvlWA++c8K1Q9DqG1twEfStO+AH2SsCvZyMS5iOCvEtka9BFKqD0zeIEOw
         9eXXB4pBZ3Mpq5Rg6w70l4HRIicCSq0mkMkgNHIICSaeP+l2qQseDwjg4XZNL/VvNpUm
         OnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491255; x=1735096055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgdU2JbWztEEEhB3TtDMib8w6jV6+vZNMAAIDtQqMFA=;
        b=nT/QeosJiEVznTH4ZeBMXTVxt/y3ylPpE1ZEPh5+pVISaHlfEiECNpefk5ohntkQSm
         k15EG4uLMKyQu0cvZEoADnflWGZnTX3qNiIbXAiECmWgyVVLvyL/XWzqX6tkgkNZVRM8
         +kzj+YUqxcR9fRjapyQH0kjqq3z2WhIxR1T9CNa4rAGTCy10PvvIuUF6fLZ6NNBCO6Cr
         ooPyJsr/u1NQ+htPx5q2Bj0nAiwysefs/Oe46GsyoFp9H7rJ3g4i16nv2m5lgcjuzoJc
         TB8rsEWzLQrun3tiP5el5QStaTB/6AdwT2YPIk+4OvpXdkHI0G5cfIzUmZPskqfuf7So
         ERMw==
X-Gm-Message-State: AOJu0YwtzC8hpDFnF5DxNNKjemOBO+ts1lJ3wj+KZ7RHKXGHAN8Beo9P
	qgMlzlWsZ/3TqWJ3WuUUnsed5QK7Ck2SF7Podg6x1dHEm50BL41FSho9cw==
X-Gm-Gg: ASbGncvfzKKK4W3HdUACCEq+IyPqCEzx0kVSk6bb5bgn423KpXb8Hvhr9KvatVtcOf9
	km6SdFr6nEIVDDyczuWBbFJ7U/8O6yhAchlkUv9puSawovSs6C019o6claJUbJpXjMPMX5nrLtU
	/80Z93kY3fFmLqjQHT51K6vL/A5oafeR/X6jbr5bqPFZ1vAL90dCwE8c9LIhqNTZIrgC2OQ4gI6
	KOaptOtsQdd/3R+nxGhR1aW52BQ1vsPDQlmo3FJmUMOs/wGUnT+9Rcp1ndC1Q4=
X-Google-Smtp-Source: AGHT+IFncZAcAnWxKKV09ycgYCqm0lYNyvdm4XJIXodyQo0lsEwlel1FnkF3rC4Igm8LoVETXeQkKQ==
X-Received: by 2002:a05:6871:650:b0:288:2906:6882 with SMTP id 586e51a60fabf-2a7b32cc1b1mr802178fac.29.1734491254754;
        Tue, 17 Dec 2024 19:07:34 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:72::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d25473acsm3311761fac.13.2024.12.17.19.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:07:33 -0800 (PST)
From: alexei.starovoitov@gmail.com
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
Subject: [PATCH bpf-next v3 2/6] mm, bpf: Introduce free_pages_nolock()
Date: Tue, 17 Dec 2024 19:07:15 -0800
Message-ID: <20241218030720.1602449-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
References: <20241218030720.1602449-1-alexei.starovoitov@gmail.com>
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

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h      |  1 +
 include/linux/mm_types.h |  4 ++
 include/linux/mmzone.h   |  3 ++
 mm/page_alloc.c          | 79 ++++++++++++++++++++++++++++++++++++----
 4 files changed, 79 insertions(+), 8 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 65b8df1db26a..ff9060af6295 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -372,6 +372,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
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
index d23545057b6e..10918bfc6734 100644
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
@@ -4854,6 +4906,17 @@ void __free_pages(struct page *page, unsigned int order)
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


