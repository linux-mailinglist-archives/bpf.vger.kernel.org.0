Return-Path: <bpf+bounces-49642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9089AA1AF33
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 04:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436AA16A34F
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 03:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A6C1D79A6;
	Fri, 24 Jan 2025 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4GwAezg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5D1D5CD7
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 03:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737691024; cv=none; b=AATIZ1MkIUwvchalzXtqIrpZXT4bka1TF4mufAW4f/avc4NEGwWqIDg0bS7L0C9XDXjOLDt4/0DMwCwsjSeY+ht3aiPhdShiTW3Fi4u+HOHHK/pZvV1tR+ti3lcllK4cjCuhV7tcTyeHkByscGB2rc4VNAa9yYgPCOtKTSvfB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737691024; c=relaxed/simple;
	bh=glP/o009xF95ZbKehzr+bPHtJrR4LnHnNUp7ZPZxW3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b4jS+BTMbAi8GGtTIkWQxcLKh6ohoCnLotKFFVp/XKvL5nz4d6BQPtsTGezDuYcP8cUMTeHjgmuYSJqfGCFfan86Mqj+1GVa/DCywgHIqw9ZY03H48MBhSfXy4v0SGoO84wE43swJeGIkPO4NNxhpqur1kJuGAZWnUttR+dLu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4GwAezg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2165cb60719so28482965ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2025 19:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737691021; x=1738295821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G89tmHrRovh0M5Rk+1LopEs8NOXI2BpuMblkeiiZfDc=;
        b=U4GwAezgXP3hSTZc3T7Nor9W5aiGcPYrMs4Y8dVF4OULSaWG31up8rwuI8oPDXqTdf
         DVt9QUMbcOpagETJlOTAWL4U6FO+wVTsKH40/u0rj/AFbCza1efENnNkSrXytNh81XTj
         qoFYwv/qIsMNEq+/5I+EV+mH+VMAEcKiUBWnml/EJ44l2sfEstE1qbbLBYMcMaT7CnvS
         rIx2DlL23iK5XCaIOGjYm0ujYoiKD/Rx7E2u6HfYArUldi7AgU7Mv4jAY3ySkfybWkR2
         m33gBm2CE6cO8qraG88+onatuCPlhaYWIgnTFbUUc3bkbnCHiwQIVqR/LK0xfkxPHJzy
         GCXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737691021; x=1738295821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G89tmHrRovh0M5Rk+1LopEs8NOXI2BpuMblkeiiZfDc=;
        b=UTSQbKtXnHxJGwZ9fPyy6RNROeoaNZ1Wcx4p/WZ2sN9BkEEel51EW6QgDd9fgheJm8
         6FOFjJ+6G92aNZ5UeQ+llCcS9lG69RG0ozGDsiU3JW7GDq4wNnOHeQXp7Pb65GW1xO8j
         OIOpHosHYBnVdJyb1BCAJs0yBO6ysvfuTJCgrGeiwHnM26GHCh16L6V0hpK1Ea4VIvWs
         5cV6uil1/mwC7OoTSXq/tPWpJmjIyKLOrEFB2GyXTgWZ/mIfbZQQkqOXrk9upbJB+xFs
         0dsOedn1Kb/1PPG74g34vpltwmauiqM3Oei1gDALPvPyXygIZhqXbc/mipENLx2W3VLv
         q/oQ==
X-Gm-Message-State: AOJu0YzsCThTJTxEHlDOkJh0PqFXK6wpQxk34qBKH6UteZG0UrSoi2ix
	rx3T3OZyPwyCdbvYiargBkFS0CccUD23gpzgLhk5TamVO0vsIhDwpzNnZg==
X-Gm-Gg: ASbGncs7ETGvzUUQw/Xu0vPFS+1cyXcelAGCqgPAKdMIJErVQWmerUIumxEobih87od
	yv8NrL1E/4JEf3Dnjmod/ntXlu9tYPmDNYq8xqIIql6FxSSkk7NWf9bI2FXfoY31IbZl4e0YSGA
	njcrvV7gtJKki4oKuG+sIl6JKhLuWYT2Tg+zXv/Plp7PqtXGZ52TMNxBJnstuFbpSNWLvpPDMnt
	x9VJ9UQpANneLtbPU/tj1ZiyqBNofUXVmDWn4G/Kv1VBYs+UH2KPQqtqtJ9jywAClbY+ycD+fWp
	JSgCIlxpNaKm/gf7McMV+buTAcyOFf8IpSS7cs4=
X-Google-Smtp-Source: AGHT+IEvNDPkJRiZfkwwi/aPaSWxbkYozYuQgk6SDROUjP76ZWWgmUKEf41JFPWQtip/8VwELQfVqQ==
X-Received: by 2002:a17:902:ce8a:b0:216:6855:15f with SMTP id d9443c01a7336-21c3562198emr408647685ad.51.1737691021406;
        Thu, 23 Jan 2025 19:57:01 -0800 (PST)
Received: from macbookpro.lan ([2603:3023:16e:5000:8af:ecd2:44cd:8027])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da424c145sm6717335ad.240.2025.01.23.19.57.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 23 Jan 2025 19:57:01 -0800 (PST)
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
Subject: [PATCH bpf-next v6 1/6] mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
Date: Thu, 23 Jan 2025 19:56:50 -0800
Message-Id: <20250124035655.78899-2-alexei.starovoitov@gmail.com>
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

Tracing BPF programs execute from tracepoints and kprobes where
running context is unknown, but they need to request additional
memory. The prior workarounds were using pre-allocated memory and
BPF specific freelists to satisfy such allocation requests.
Instead, introduce gfpflags_allow_spinning() condition that signals
to the allocator that running context is unknown.
Then rely on percpu free list of pages to allocate a page.
try_alloc_pages() -> get_page_from_freelist() -> rmqueue() ->
rmqueue_pcplist() will spin_trylock to grab the page from percpu
free list. If it fails (due to re-entrancy or list being empty)
then rmqueue_bulk()/rmqueue_buddy() will attempt to
spin_trylock zone->lock and grab the page from there.
spin_trylock() is not safe in PREEMPT_RT when in NMI or in hard IRQ.
Bailout early in such case.

The support for gfpflags_allow_spinning() mode for free_page and memcg
comes in the next patches.

This is a first step towards supporting BPF requirements in SLUB
and getting rid of bpf_mem_alloc.
That goal was discussed at LSFMM: https://lwn.net/Articles/974138/

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h |  22 ++++++++++
 lib/stackdepot.c    |   5 ++-
 mm/internal.h       |   1 +
 mm/page_alloc.c     | 104 ++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b0fe9f62d15b..82bfb65b8d15 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -39,6 +39,25 @@ static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
 }
 
+static inline bool gfpflags_allow_spinning(const gfp_t gfp_flags)
+{
+	/*
+	 * !__GFP_DIRECT_RECLAIM -> direct claim is not allowed.
+	 * !__GFP_KSWAPD_RECLAIM -> it's not safe to wake up kswapd.
+	 * All GFP_* flags including GFP_NOWAIT use one or both flags.
+	 * try_alloc_pages() is the only API that doesn't specify either flag.
+	 *
+	 * This is stronger than GFP_NOWAIT or GFP_ATOMIC because
+	 * those are guaranteed to never block on a sleeping lock.
+	 * Here we are enforcing that the allocation doesn't ever spin
+	 * on any locks (i.e. only trylocks). There is no high level
+	 * GFP_$FOO flag for this use in try_alloc_pages() as the
+	 * regular page allocator doesn't fully support this
+	 * allocation mode.
+	 */
+	return !(gfp_flags & __GFP_RECLAIM);
+}
+
 #ifdef CONFIG_HIGHMEM
 #define OPT_ZONE_HIGHMEM ZONE_HIGHMEM
 #else
@@ -347,6 +366,9 @@ static inline struct page *alloc_page_vma_noprof(gfp_t gfp,
 }
 #define alloc_page_vma(...)			alloc_hooks(alloc_page_vma_noprof(__VA_ARGS__))
 
+struct page *try_alloc_pages_noprof(int nid, unsigned int order);
+#define try_alloc_pages(...)			alloc_hooks(try_alloc_pages_noprof(__VA_ARGS__))
+
 extern unsigned long get_free_pages_noprof(gfp_t gfp_mask, unsigned int order);
 #define __get_free_pages(...)			alloc_hooks(get_free_pages_noprof(__VA_ARGS__))
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 245d5b416699..377194969e61 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -591,7 +591,8 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	depot_stack_handle_t handle = 0;
 	struct page *page = NULL;
 	void *prealloc = NULL;
-	bool can_alloc = depot_flags & STACK_DEPOT_FLAG_CAN_ALLOC;
+	bool allow_spin = gfpflags_allow_spinning(alloc_flags);
+	bool can_alloc = (depot_flags & STACK_DEPOT_FLAG_CAN_ALLOC) && allow_spin;
 	unsigned long flags;
 	u32 hash;
 
@@ -630,7 +631,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 			prealloc = page_address(page);
 	}
 
-	if (in_nmi()) {
+	if (in_nmi() || !allow_spin) {
 		/* We can never allocate in NMI context. */
 		WARN_ON_ONCE(can_alloc);
 		/* Best effort; bail if we fail to take the lock. */
diff --git a/mm/internal.h b/mm/internal.h
index 9826f7dce607..6c3c664aa346 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1174,6 +1174,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
+#define ALLOC_TRYLOCK		0x400 /* Only use spin_trylock in allocation path */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 /* Flags that allow allocations below the min watermark. */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 01eab25edf89..a82bc67abbdb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2306,7 +2306,11 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&zone->lock, flags);
+	if (!spin_trylock_irqsave(&zone->lock, flags)) {
+		if (unlikely(alloc_flags & ALLOC_TRYLOCK))
+			return 0;
+		spin_lock_irqsave(&zone->lock, flags);
+	}
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
 								alloc_flags);
@@ -2906,7 +2910,11 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
-		spin_lock_irqsave(&zone->lock, flags);
+		if (!spin_trylock_irqsave(&zone->lock, flags)) {
+			if (unlikely(alloc_flags & ALLOC_TRYLOCK))
+				return NULL;
+			spin_lock_irqsave(&zone->lock, flags);
+		}
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
@@ -4511,7 +4519,12 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	might_alloc(gfp_mask);
 
-	if (should_fail_alloc_page(gfp_mask, order))
+	/*
+	 * Don't invoke should_fail logic, since it may call
+	 * get_random_u32() and printk() which need to spin_lock.
+	 */
+	if (!(*alloc_flags & ALLOC_TRYLOCK) &&
+	    should_fail_alloc_page(gfp_mask, order))
 		return false;
 
 	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
@@ -7028,3 +7041,88 @@ static bool __free_unaccepted(struct page *page)
 }
 
 #endif /* CONFIG_UNACCEPTED_MEMORY */
+
+/**
+ * try_alloc_pages_noprof - opportunistic reentrant allocation from any context
+ * @nid - node to allocate from
+ * @order - allocation order size
+ *
+ * Allocates pages of a given order from the given node. This is safe to
+ * call from any context (from atomic, NMI, and also reentrant
+ * allocator -> tracepoint -> try_alloc_pages_noprof).
+ * Allocation is best effort and to be expected to fail easily so nobody should
+ * rely on the success. Failures are not reported via warn_alloc().
+ * See always fail conditions below.
+ *
+ * Return: allocated page or NULL on failure.
+ */
+struct page *try_alloc_pages_noprof(int nid, unsigned int order)
+{
+	/*
+	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
+	 * Do not specify __GFP_KSWAPD_RECLAIM either, since wake up of kswapd
+	 * is not safe in arbitrary context.
+	 *
+	 * These two are the conditions for gfpflags_allow_spinning() being true.
+	 *
+	 * Specify __GFP_NOWARN since failing try_alloc_pages() is not a reason
+	 * to warn. Also warn would trigger printk() which is unsafe from
+	 * various contexts. We cannot use printk_deferred_enter() to mitigate,
+	 * since the running context is unknown.
+	 *
+	 * Specify __GFP_ZERO to make sure that call to kmsan_alloc_page() below
+	 * is safe in any context. Also zeroing the page is mandatory for
+	 * BPF use cases.
+	 *
+	 * Though __GFP_NOMEMALLOC is not checked in the code path below,
+	 * specify it here to highlight that try_alloc_pages()
+	 * doesn't want to deplete reserves.
+	 */
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC;
+	unsigned int alloc_flags = ALLOC_TRYLOCK;
+	struct alloc_context ac = { };
+	struct page *page;
+
+	/*
+	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
+	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
+	 * task may be waiting for one rt_spin_lock, but rt_spin_trylock() will
+	 * mark the task as the owner of another rt_spin_lock which will
+	 * confuse PI logic, so return immediately if called form hard IRQ or
+	 * NMI.
+	 *
+	 * Note, irqs_disabled() case is ok. This function can be called
+	 * from raw_spin_lock_irqsave region.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
+		return NULL;
+	if (!pcp_allowed_order(order))
+		return NULL;
+
+#ifdef CONFIG_UNACCEPTED_MEMORY
+	/* Bailout, since try_to_accept_memory_one() needs to take a lock */
+	if (has_unaccepted_memory())
+		return NULL;
+#endif
+	/* Bailout, since _deferred_grow_zone() needs to take a lock */
+	if (deferred_pages_enabled())
+		return NULL;
+
+	if (nid == NUMA_NO_NODE)
+		nid = numa_node_id();
+
+	prepare_alloc_pages(alloc_gfp, order, nid, NULL, &ac,
+			    &alloc_gfp, &alloc_flags);
+
+	/*
+	 * Best effort allocation from percpu free list.
+	 * If it's empty attempt to spin_trylock zone->lock.
+	 */
+	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+
+	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
+
+	trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
+	kmsan_alloc_page(page, order, alloc_gfp);
+	return page;
+}
-- 
2.43.5


