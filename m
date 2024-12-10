Return-Path: <bpf+bounces-46471-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E5F9EA53E
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 03:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3392285142
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D3319E993;
	Tue, 10 Dec 2024 02:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Md5FQ4H0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFFA27456
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798393; cv=none; b=EOyTRKiTLEqLsvYOBH6ctSFpj7PjV5YJ8ZeQznbeE39XM6JMO2J/POGNbwkUM1TCVlJcXq4Iqz3seeQSRt86oFLzRgvrITHqKIu5TuacpIhXUhPNqFPuE2m9J1seUUVLrDxQmhG6W3gcAl35lMFebPRETD8uU5M1oVF8aru9It8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798393; c=relaxed/simple;
	bh=9h5GtWWC1L/C/cYZyIAto5Swc6ITBZJ7lAo/dVkICu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/Hf55jTUhSiAkPu8gIhLVrn8Ni3UxWqZXtIYk0w0SAYZ2Qu2V2bVSbuz4SAY5SpVFwK/we6g5rc2FYcpGCOWDUelS7dw+lK8pF+BoYpOEttKXDSYNeE3HQSJWPqYMZDGfQ+eLSjp8ySvMM2t1f7iV7kyEL83S8KyF9U72Hq8Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Md5FQ4H0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2164b662090so15925575ad.1
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 18:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733798390; x=1734403190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSOnooig0JqcXQ1Y/KpafF9RbsF0QDm5Q4FOwHWSe4I=;
        b=Md5FQ4H0CrVeTkiiGw/H2GDxw+lfBENIr+0jpuWCk93gPia3Z+WsLEvnUdghX42owg
         Iprb4bO0Hr5rJ7nXr/F1FtYH+qrWEDLrkwL6Ur5Y3/qZH1ZabWBpOrtGtYapD4GG9cFC
         xLJi7eGR99CQjcM8LDwuIKgxeXl2WlsHkVdZ1CuclOUdLwc0NWrLps2mOESTJKxpR4Ux
         ydT0XZttx2epLarmj5o/uzistzjSGfBSvP7SqguQQQtCrS24N9uu/dXfav8PK+yd3oH8
         Qmndp+8aCcJDE/+IYCjD/GNCFsV9xEn9wHgHFJdtoRWysBFIF3lm50F34megX7HPnPIS
         IowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798390; x=1734403190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSOnooig0JqcXQ1Y/KpafF9RbsF0QDm5Q4FOwHWSe4I=;
        b=ZVCGcJ7XIf1q7uEAtQoc6Yy7Ri+i78jGays/XCb5znGJb58MUdwxgmnfdmGKInLv+9
         cdiL/U84j5GngGfmANYKjvV2FGpQZmPEFS7L4g6ibZ00Vr+Obrn9hWQYIdFtgR4A80ov
         f+gbn0jcvKCR0d0dyY+mGH6v5bfC91v8tdCezjxiVtI3cKmjZKgHL5/LldZRQBq/U/Xz
         /aJTstjJKxFR+9hK9QPLpcrOFN4Z8R5blAQVtVw+E2Tgs1ypwzeJUBzepmr6wW1TOMHG
         mJeQybRlRP/GgAnsDuE3cK4KbMb9OFHcR7RuNHGTMc1dpVlwcMVTWXoMuCWFTQFtLnir
         8MbQ==
X-Gm-Message-State: AOJu0YxSiVlE1zOnaOOwxH1lQBAM/gYRdWU0yHiJkjomYIYxvLtON+xe
	ZiXFy2cCirH3qFRfk7IXieAoKTSvz9efVbP1c3Z4zp2kp0ixTfdrilqqug==
X-Gm-Gg: ASbGncs9fSBJ9xTpf5NkJFEXSA6kI4M8PtkROAGjC5y9LvvE6n1xSU9N4JbhhmRGUVq
	WsWTXp3gTYcIRipMe1Uh4kGSKwaawJR2c0f8LUxesuOfeOdLIxMclpYrHPeCUalG4IYFI7DSl8C
	LkQzH6ahVM66gX5D/QW7LhM2k6a644uRrYL5JwkXdAK/wtCisfeoP+dJ1HFUJftfWqgXKXikEwK
	fAx7DACmMbRgH/ke6IbHmxM/PIpb8vj2Kuiwtnh9DTo4R+GIlBrwv2vvplfOKsqCk65NarDaOT/
	yLkmCA==
X-Google-Smtp-Source: AGHT+IFs9AQy6lVySBTzfSVqJTRJXQoQU6RtOKdvZs51As+Ukwzy42oozyaRiTjoeSpSVQBsyUhvdA==
X-Received: by 2002:a17:903:110f:b0:212:996:3536 with SMTP id d9443c01a7336-21614d2e719mr238769345ad.10.1733798389764;
        Mon, 09 Dec 2024 18:39:49 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:83b0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd45b78c7fsm2837312a12.15.2024.12.09.18.39.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 18:39:49 -0800 (PST)
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
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 2/6] mm, bpf: Introduce free_pages_nolock()
Date: Mon,  9 Dec 2024 18:39:32 -0800
Message-Id: <20241210023936.46871-3-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Introduce free_pages_nolock() that can free a page without taking locks.
It relies on trylock only and can be called from any context.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h      |  1 +
 include/linux/mm_types.h |  4 +++
 include/linux/mmzone.h   |  3 ++
 mm/page_alloc.c          | 72 +++++++++++++++++++++++++++++++++++-----
 4 files changed, 72 insertions(+), 8 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index f68daa9c997b..dcae733ed006 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -394,6 +394,7 @@ __meminit void *alloc_pages_exact_nid_noprof(int nid, size_t size, gfp_t gfp_mas
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
index d511e68903c6..a969a62ec0c3 100644
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
@@ -1251,9 +1254,33 @@ static void free_one_page(struct zone *zone, struct page *page,
 			  unsigned long pfn, unsigned int order,
 			  fpi_t fpi_flags)
 {
+	struct llist_head *llhead;
 	unsigned long flags;
 
-	spin_lock_irqsave(&zone->lock, flags);
+	if (!spin_trylock_irqsave(&zone->lock, flags)) {
+		if (unlikely(fpi_flags & FPI_TRYLOCK)) {
+			/* Remember the order */
+			page->order = order;
+			/* Add the page to the free list */
+			llist_add(&page->pcp_llist, &zone->trylock_free_pages);
+			return;
+		}
+		spin_lock_irqsave(&zone->lock, flags);
+	}
+
+	/* The lock succeeded. Process deferred pages. */
+	llhead = &zone->trylock_free_pages;
+	if (unlikely(!llist_empty(llhead))) {
+		struct llist_node *llnode;
+		struct page *p, *tmp;
+
+		llnode = llist_del_all(llhead);
+		llist_for_each_entry_safe(p, tmp, llnode, pcp_llist) {
+			unsigned int p_order = p->order;
+			split_large_buddy(zone, p, page_to_pfn(p), p_order, fpi_flags);
+			__count_vm_events(PGFREE, 1 << p_order);
+		}
+	}
 	split_large_buddy(zone, page, pfn, order, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
@@ -2596,7 +2623,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone,
 
 static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 				   struct page *page, int migratetype,
-				   unsigned int order)
+				   unsigned int order, fpi_t fpi_flags)
 {
 	int high, batch;
 	int pindex;
@@ -2631,6 +2658,14 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
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
@@ -2645,7 +2680,8 @@ static void free_unref_page_commit(struct zone *zone, struct per_cpu_pages *pcp,
 /*
  * Free a pcp page
  */
-void free_unref_page(struct page *page, unsigned int order)
+static void __free_unref_page(struct page *page, unsigned int order,
+			      fpi_t fpi_flags)
 {
 	unsigned long __maybe_unused UP_flags;
 	struct per_cpu_pages *pcp;
@@ -2654,7 +2690,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	int migratetype;
 
 	if (!pcp_allowed_order(order)) {
-		__free_pages_ok(page, order, FPI_NONE);
+		__free_pages_ok(page, order, fpi_flags);
 		return;
 	}
 
@@ -2671,7 +2707,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(page_zone(page), page, pfn, order, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, order, fpi_flags);
 			return;
 		}
 		migratetype = MIGRATE_MOVABLE;
@@ -2681,14 +2717,19 @@ void free_unref_page(struct page *page, unsigned int order)
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
@@ -2777,7 +2818,7 @@ void free_unref_folios(struct folio_batch *folios)
 
 		trace_mm_page_free_batched(&folio->page);
 		free_unref_page_commit(zone, pcp, &folio->page, migratetype,
-				order);
+				       order, FPI_NONE);
 	}
 
 	if (pcp) {
@@ -4855,6 +4896,21 @@ void __free_pages(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL(__free_pages);
 
+/* Can be called while holding raw_spin_lock or from IRQ. RCU must be watching. */
+void free_pages_nolock(struct page *page, unsigned int order)
+{
+	int head = PageHead(page);
+	struct alloc_tag *tag = pgalloc_tag_get(page);
+
+	if (put_page_testzero(page)) {
+		__free_unref_page(page, order, FPI_TRYLOCK);
+	} else if (!head) {
+		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
+		while (order-- > 0)
+			__free_unref_page(page + (1 << order), order, FPI_TRYLOCK);
+	}
+}
+
 void free_pages(unsigned long addr, unsigned int order)
 {
 	if (addr != 0) {
-- 
2.43.5


