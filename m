Return-Path: <bpf+bounces-52235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404B3A40520
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 03:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE7E7057B4
	for <lists+bpf@lfdr.de>; Sat, 22 Feb 2025 02:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19DB1FECCF;
	Sat, 22 Feb 2025 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEuIb7VD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BB91FC7E6
	for <bpf@vger.kernel.org>; Sat, 22 Feb 2025 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740192284; cv=none; b=NO8xQmNX0gaPCeYuGHYFp1iN97eKPknni/Si2gpstjdelIjkOr+DUyo5tBUaDVfiUtHHGqPSzyVZ++VQFga6V8y4iP/XF8ndbxVQLGgqzICRoaDYR6Xg1qy02Flem4VxMi2SBjYZ7YkGdDPJk01leC2NBfILEjdQ2BdjabxVa68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740192284; c=relaxed/simple;
	bh=8huareBgqZnv1YE/dweCJUp5CiJFrofwZ43IiNfQYhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oY2kpmnf9oILr/jUI2VkORNL76m/l0Q5qnL9nyzh6wBuTNgPS31DFk8kYP2OgTVeag+U6d0LxtoJrJE9K0YWvs1ouMbr7Tb40buW+EknUUfkNvnY5ZGcPbIhVP09/D3MWfr1B2Urty10gfKnvhUy80jegWumaKuOjut37MPxfq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hEuIb7VD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fbfa8c73a6so5525846a91.2
        for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 18:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740192281; x=1740797081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJx8bfHvcsPdmDmREOhTX7J+3gMm5tOq1v0fsOdzZbU=;
        b=hEuIb7VD4wqJEiEv8RxnhmytzmO7yfOYGJm9fYUFsW1ss2svIWbt9uzbaE/kngLuBW
         91Ai+3uJ8enK2tA05nhy2BEkMPE+Mk1xW9v/XWSj/jvB3Bn8zLsskR7osMAjEM3ts3v+
         kG0d+ko9LCIhtW/o+hnnrqQcT4goEAjkuSP2qyqfh6KQkkEfUCrh/VizcocN0Kkg+9Fa
         T2pOh23xwADBMQpX2viqjJfxbqw3SCxaTp0XpzqkxOngs4FKkI5AWYjE14quavnwjzGO
         IU5zDsAXeS5W8DOO4/lV0RRdBSA23t2+c54n1ZjrtnSxjuhgBHzRcZy9Vm8ZCk51iR0U
         mw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740192281; x=1740797081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oJx8bfHvcsPdmDmREOhTX7J+3gMm5tOq1v0fsOdzZbU=;
        b=nRnqLwUvk5Yh7FP20O5eyj3Kh48JgbTMHTLvGs1B00v57g6fW/cjGgELMasRMREoc9
         m1jhLYs4v9mGFTgSUAIvGlJCd4Ke0YUbpK0V+u0bHwj3OKs7LyeOI5wA5d/WekFidHC8
         eZx0Ug9DjBEmmBRla4F3i+06Bxh65QbOauGdDKcrnzxxrnCXvnnlJkhnAPygb76IaAoW
         pWz99QFbeghZSn/v1at9vg+cd+fRE5iEvbr7QzFp8E71sfrlCEUT5vZq5kK7R8rUG3OO
         5Ku/MiWw0T9rlipKJmO76JalqliOiddzvwRtSJZ0+fuV+Xfirr+LHKBe0Hc5aAc/Cc07
         bhPg==
X-Gm-Message-State: AOJu0Ywx8Ii49L7BeQ2FnupFKQuUcopCBjMwuh69PmqG6HFOIjjLMmBr
	Eq6GCLhSAN0yVeW6KOGybF8IijTxnTOzFMyDrDy0m3BQf+khrikKjsSgYg==
X-Gm-Gg: ASbGncvEKDVVeTh9hNGnqN5D3vQ9kNLepwQ1rvthqAKqDJeghsmFslIFiQzEJ4ythpj
	sswc4ex9Lzwe8LfmejouhF0tCLZ/WGyBCebYYi2Q+ersP7X3aQaXOZRphJU/kq4aFr1W7HV3VeC
	RIJ6dGCM19yQTMZOYbp78SsZsWitFP3gn/lpvstDsQy6nC9+e0DYz4hOUdfnq26EzYwZKN5guLZ
	W2DI0H+MoR9xjH/DY1FxOK0YB5oyxPdaokhyWl0nncrAqUo9Vs/tidAfe3RzG0tH+lMAFH2sFcj
	jM9pzfw8WfM6kSjx+9XwiEaxc37Q90phS0Nc53/6jQ0fwV9g741bpQ==
X-Google-Smtp-Source: AGHT+IFCLpvNiUlzSLAmScZOHfvBMu91BobDCkKJ+lN7CcdzTuYNWTOHAeEoc/CAjS1q1J3gFUhfzQ==
X-Received: by 2002:a05:6a00:98f:b0:732:1eb2:7bf3 with SMTP id d2e1a72fcca58-73426d9f1abmr9857341b3a.21.1740192280978;
        Fri, 21 Feb 2025 18:44:40 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:fd1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73275615173sm11027845b3a.168.2025.02.21.18.44.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 18:44:40 -0800 (PST)
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
Subject: [PATCH bpf-next v9 2/6] mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
Date: Fri, 21 Feb 2025 18:44:23 -0800
Message-Id: <20250222024427.30294-3-alexei.starovoitov@gmail.com>
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
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h |  22 ++++++++++
 lib/stackdepot.c    |   5 ++-
 mm/internal.h       |   1 +
 mm/page_alloc.c     | 104 ++++++++++++++++++++++++++++++++++++++++++--
 4 files changed, 127 insertions(+), 5 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 6bb1a5a7a4ae..5d9ee78c74e4 100644
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
@@ -335,6 +354,9 @@ static inline struct page *alloc_page_vma_noprof(gfp_t gfp,
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
index 109ef30fee11..10a8b4b3b86e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1187,6 +1187,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
+#define ALLOC_TRYLOCK		0x400 /* Only use spin_trylock in allocation path */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 /* Flags that allow allocations below the min watermark. */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 579789600a3c..1f2a4e1c70ae 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2307,7 +2307,11 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
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
@@ -2907,7 +2911,11 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
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
@@ -7071,3 +7084,88 @@ static bool __free_unaccepted(struct page *page)
 }
 
 #endif /* CONFIG_UNACCEPTED_MEMORY */
+
+/**
+ * try_alloc_pages - opportunistic reentrant allocation from any context
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


