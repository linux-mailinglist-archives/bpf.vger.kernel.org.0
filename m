Return-Path: <bpf+bounces-48895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC954A11726
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD9A167A58
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4B8481D1;
	Wed, 15 Jan 2025 02:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRrlxRKk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA9A381A3
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 02:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736907481; cv=none; b=W2FZTZlj7FDYN44Bvokj6JiV0u8GeorTIgzHuxAa/6d04+V3Z8DWlHqe+fTpSzhaZ7p0VgWEzAZ4oSilCg15A0D9oTPyCtlyslpOZsvWoSyXqhq1tyCJuFrN/HKt9xGfdBbfPt2OC8Rs0M1VuFtme0IOp2/XeTbea+qLwR9brxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736907481; c=relaxed/simple;
	bh=AoB2KJqMaJOrCmJSuEoY+S5uhKBzMdWya5CfFTxDpsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GLiQstqFYSwEvZBl+wkscfRCyhuDwI6dGp+ut2eGu6dcQzu40bfBTJgbdA1cVeyLBwkjL/JqAjOt9tiKC1PFIOQey5qdxlUWzgdy5VEBnofQdKtsUORMOoJgx2UAXQhzJqNmP7UH59w/3K93NwfjjUz+p9SKZ/VIzXqLipjR5e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRrlxRKk; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165448243fso134655585ad.1
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 18:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736907478; x=1737512278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRfQnK0Xbq5jILYR704HtD9aPWYF0UoBSTHx/j1KDDk=;
        b=MRrlxRKkGNTxEwkNuW99GxeFwKfnTCQCAQfCj9rx6+tVJM8KhDQS5PBwYW904GLVtu
         7uKh/ZYfSGTB4Pf4Ndek78+QKjGkC/7e2q1oQgpSHrLdxbGDaquKA31EUIlRRvPBHhD0
         rXXBex7iZrRNOcWNIo+0HazExcOpdl5zsjadvFXk7h+ZNowybsyJ6OROqxtA/Cj3+X9g
         /bX/RzDntSksZcjyEupQ6kr0hV2XSwCFqk8lGqyKJDf7FvQf9UttyHp5ej0HVz2fdSnY
         IGFypa5e78RktDDecQodHSELE3MPtDg8fUeZKPN2RQpgQ3ChpYlr36jDXt9b9Ufa89mD
         LCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736907478; x=1737512278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RRfQnK0Xbq5jILYR704HtD9aPWYF0UoBSTHx/j1KDDk=;
        b=dS1bayjn+Jq3XHIgkBMBlr0H98vhzm2cB9ON7SEUiDjbb/rGQogxMLQKFGpg2nBEvU
         H9qi05Lhi8/3OtMUwB/QPlPkV9jf3RXdMszhVF53JGnBn/hhkcdU4Bw1tcWqtT3cx/e4
         9e7hqTdE8BsXS6BSeBmIJPpYcUiodpTQxZMGJ0BqRdN8+BA6D338tTK1KUkGTGIuSUal
         s6ta4QmmfHn9GK076k4ZDxcDSl0M+mZBK3EKp2pkQFC8Bo/QA43sHXASCbqFlqiVcOwn
         hVfUBvp1ybsKzgB04tNlgDe1b47sr7VF5Nys3DMMVJssz5jQwp17L6TM7nX4+yoa9oVl
         gY9A==
X-Gm-Message-State: AOJu0YyprrHEs5iuWZl9I9HcCx1wYYLAUxkbV3Xvtyw0U1XU/M3BWdX1
	6k2xGelYPOietgyNoQhc2ISsFkX2aBqHoyj4BVqRIkls45r/3GFOJ88H+w==
X-Gm-Gg: ASbGnctnqBqx4hNlhbvK6tiow1BFEe+wQYxH56lja6sR32fwjqDULqlI6iOu8gPmAUN
	oTvqBNN1DvQQsrCVFtONe0xvXKRVJADWg21Di14NbTw2ATChMBnjlE2BZ6ktNm61xnRDucg9sDI
	5+FRU3pesr3s/8yzF6WcxFRNeIblUTyGrvzYIrEbbpu8fxaJ+G3DZXMZp/+q9Vd6Ao9kz2D3M0c
	zspoZXbrVj0cS4AI21o8WKb4NRsJquKlNtD2P0bisI65wmzVWfBdpxXTeqpk2TanxN7/rh7rhz3
	dzsxIbSv
X-Google-Smtp-Source: AGHT+IG6Y9Bj4+sss4AkgBmGlysFV+cBK96Pvs8KQSHpwbaMp6szpurOB66PeQKEY7FIq53RepZsSQ==
X-Received: by 2002:a05:6a00:35ce:b0:729:1c0f:b94a with SMTP id d2e1a72fcca58-72d220077aamr40543484b3a.23.1736907477661;
        Tue, 14 Jan 2025 18:17:57 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40658dd7sm8357578b3a.102.2025.01.14.18.17.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:17:57 -0800 (PST)
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
Subject: [PATCH bpf-next v5 1/7] mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
Date: Tue, 14 Jan 2025 18:17:40 -0800
Message-Id: <20250115021746.34691-2-alexei.starovoitov@gmail.com>
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
spin_trylock() is not safe in RT when in NMI or in hard IRQ.
Bailout early in such case.

The support for gfpflags_allow_spinning() mode for free_page and memcg
comes in the next patches.

This is a first step towards supporting BPF requirements in SLUB
and getting rid of bpf_mem_alloc.
That goal was discussed at LSFMM: https://lwn.net/Articles/974138/

Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h | 22 ++++++++++
 mm/internal.h       |  1 +
 mm/page_alloc.c     | 98 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b0fe9f62d15b..b41bb6e01781 100644
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
+	 * Here we are enforcing that the allaaction doesn't ever spin
+	 * on any locks (i.e. only trylocks). There is no highlevel
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
 
diff --git a/mm/internal.h b/mm/internal.h
index cb8d8e8e3ffa..5454fa610aac 100644
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
index 1cb4b8c8886d..74c2a7af1a77 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2304,7 +2304,11 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
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
@@ -2904,7 +2908,11 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
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
@@ -4509,7 +4517,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	might_alloc(gfp_mask);
 
-	if (should_fail_alloc_page(gfp_mask, order))
+	if (!(*alloc_flags & ALLOC_TRYLOCK) &&
+	    should_fail_alloc_page(gfp_mask, order))
 		return false;
 
 	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
@@ -7023,3 +7032,86 @@ static bool __free_unaccepted(struct page *page)
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
+	 * In RT spin_trylock() may call raw_spin_lock() which is unsafe in NMI.
+	 * If spin_trylock() is called from hard IRQ the current task may be
+	 * waiting for one rt_spin_lock, but rt_spin_trylock() will mark the
+	 * task as the owner of another rt_spin_lock which will confuse PI
+	 * logic, so return immediately if called form hard IRQ or NMI.
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


