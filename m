Return-Path: <bpf+bounces-48728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB177A0FE9E
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 03:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF911169FBE
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 02:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55597230276;
	Tue, 14 Jan 2025 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlaZnX56"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488B4AD27
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821178; cv=none; b=uZ/3DGi8su12Ha+hXXo0YtfIS4grLlF94icaXpPrDiqcdAnf9KNYvvYnXuLqKeOp0FMleTV96+AbUE4Mqufn4YGaazUxIQQk/VMqBnMn6XffP85lO7VelgbAKFCm33EhBxLk0gU7gEAmtzeEFaKb27csReNH1plVkfMijP4CdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821178; c=relaxed/simple;
	bh=LE5i/b+J3cBV84XRbfzo1Bz/cVOQ7Ljn4yobyTGWImA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pi2Le6WXMumbE5wFt2p2nuefP1qAs9J3QoORKV+UFt4qH2Gh9EsrBokuZfUrHAxDJKs9JdAIAj5XjbYWM92Zqhz5qVQQPTbnQdyofup3IXzad8k97i6bTdgz4e+3zCjtGnFuYB34MXGbpqDcvj/JFr78FZG0zH8niFij/VtpdNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlaZnX56; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so8341086a91.1
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2025 18:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736821176; x=1737425976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akgdVcj5xEeNq6DmKIL978uvRiSwDxIZz8GY/zQxfoo=;
        b=BlaZnX56AuEJ6p4GsSGUfWoUjiNM/rWEP4w/Ar55IMMxjHkfqh4yVHER+UcGCHiWSk
         OOxxiRyXlZ3IQEdD9eSQSCrtqFZnQNilWsdcUkeWluffM9rkZzggUOaX0efql668qK50
         6IKCQZ0CcvoxeNJjAQ39t+vHU5EhmxYu8b/GmHl9uDTAZwTV01n//n1yv2xgZYCkh5bz
         Xd+DTmNrD3ZNfOimHerOOu/yT14Je8fYJaOiA4/wF1sozTzFOBDVLS2yruKaFIKqVNaN
         gXJsYHgdUVek1TPEi/hAfBBefTRN9v/9gUwVzyU5Z5aas0Noqv4FLdPX1LTiOK+dMNgB
         qnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821176; x=1737425976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=akgdVcj5xEeNq6DmKIL978uvRiSwDxIZz8GY/zQxfoo=;
        b=mKDRP9JxRUGOoA+41906jicgLtsFw+9K4gGP+A2PJ6YmRu25kQ6jsHYRK3hKKGJ1w6
         qYvo+jfpGPUzuBfnRDD4Wbz+xBtK8k4l1JZszxeZOYm2YQzA4kH0pkvelrTKLcnD3Gmc
         W45mMO1xNsD68MRxdcSC0DmgQ13ICE/UL8x5bbs7CV8AWRobo0uLLELHRLMWTjUkEps5
         EiUhOmj8mtPPOmYyHSqN73pSk7bGg8HhfKLXm2XL7D/TamTbeEW4AkhEb9S7i+8BAzXV
         nOHim3nF7xdMfA6OiBd2C0yD5Xhif8hvRz1nh20c0ACKNY2sMF113CCaUlpGacQPsdU6
         10GA==
X-Gm-Message-State: AOJu0Yzh/hcltYcXGHGLlHJPGNhnhPDLpCpgvVjtTsbOFpZw/4jbEtrW
	ADCf/oF0huW70p8Dx+x2wgmIYViXV1Z6SpZ2mYFaV8f4eEkbZh5fgl/giw==
X-Gm-Gg: ASbGnctN0x82RT6C8AwfZ7HvFrWKd4aqcVK5DIyottlsA6yOF6ggk8TegMc+vOgt1mW
	b4XcN069ybx5cS9d56wedX2RhDIUQawK5z5PPzZHZioxW8pNW7dQZoU9CawV+DSyPnVl/FppCqA
	zAPvrQ3KSDUCkp9zVR1vkcvaB8gDCEa3U1wnxeB+m0IN5TAygZbMtY7PYTldSD23lBAGmfdCwj5
	eAjWf9OgqaLjGxdwOP4hSXXkS3oMtHPzCcmRW/l3de3eAqoYJwhLKUIeDEX7leck+u1MgoyUdhl
	wU7AHbbM
X-Google-Smtp-Source: AGHT+IHnBshZ4mFPAZZGQFlNI39VdZrv1X1j+B7cThKNElaLFNGw9ViuDJNNiPM+Xr5/Kv9IgpitWg==
X-Received: by 2002:a17:90b:2712:b0:2ee:48bf:7dc9 with SMTP id 98e67ed59e1d1-2f548eb3a99mr35445590a91.15.1736821176273;
        Mon, 13 Jan 2025 18:19:36 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:4043])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f55942eed5sm8658076a91.27.2025.01.13.18.19.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jan 2025 18:19:35 -0800 (PST)
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
Subject: [PATCH bpf-next v4 1/6] mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
Date: Mon, 13 Jan 2025 18:19:17 -0800
Message-Id: <20250114021922.92609-2-alexei.starovoitov@gmail.com>
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

Tracing BPF programs execute from tracepoints and kprobes where
running context is unknown, but they need to request additional
memory. The prior workarounds were using pre-allocated memory and
BPF specific freelists to satisfy such allocation requests.
Instead, introduce gfpflags_allow_spinning() condition that signals
to the allocator that running context is unknown.
Then rely on percpu free list of pages to allocate a page.
The rmqueue_pcplist() should be able to pop the page from.
If it fails (due to IRQ re-entrancy or list being empty) then
try_alloc_pages() attempts to spin_trylock zone->lock
and refill percpu freelist as normal.
BPF program may execute with IRQs disabled and zone->lock is
sleeping in RT, so trylock is the only option. In theory we can
introduce percpu reentrance counter and increment it every time
spin_lock_irqsave(&zone->lock, flags) is used, but we cannot rely
on it. Even if this cpu is not in page_alloc path the
spin_lock_irqsave() is not safe, since BPF prog might be called
from tracepoint where preemption is disabled. So trylock only.

Note, free_page and memcg are not taught about gfpflags_allow_spinning()
condition. The support comes in the next patches.

This is a first step towards supporting BPF requirements in SLUB
and getting rid of bpf_mem_alloc.
That goal was discussed at LSFMM: https://lwn.net/Articles/974138/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h | 22 ++++++++++++
 mm/internal.h       |  1 +
 mm/page_alloc.c     | 85 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 105 insertions(+), 3 deletions(-)

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
index 1cb4b8c8886d..0f4be88ff131 100644
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
@@ -7023,3 +7032,73 @@ static bool __free_unaccepted(struct page *page)
 }
 
 #endif /* CONFIG_UNACCEPTED_MEMORY */
+
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


