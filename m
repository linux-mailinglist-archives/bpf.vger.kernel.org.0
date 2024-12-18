Return-Path: <bpf+bounces-47175-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D3F9F5D3B
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 04:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39E91888D77
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA5913C807;
	Wed, 18 Dec 2024 03:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6+Ywhc7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70C7082E
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491253; cv=none; b=TSCoUJyGYabj6AdNKh5S4hO3e7g7CGgXbYZ8kaBRjYi+t4f3DIFflzsqDObcrdv+u1x40oi1yrOVIxv/PSACNRQeyaUt4slkjm/qPbQLGodfJI4Tao2BtPJzd2vuFvd7+YaalgML4QGFrOKe+zLvXO/h6cy2nCXCuq3A6jYFfus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491253; c=relaxed/simple;
	bh=yOXNtMlw7xJqRPDHrzCdGHPavK39hoNe5hsDOx4/73A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dl6t4xGD/i1FEsqj7N3cRJzfbcJIDI5KKChIQB6Z1rhxDL0s254oteoa2ySs2kFk5OllvmsPOlykgXVxkLOKdkMNtipiJwSTMWt+GHVtuiMJbyQ+a1Qne6HcWjk+WeeYr1aatTfvaJXbpQ4KEsKJZNHytkeoQCQeuTEcihRX+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6+Ywhc7; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71e1d7130a5so2899380a34.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 19:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734491250; x=1735096050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGzoMP4pz94E3iZ2ZVAY+FjoyH+9uJ8+ltaU5mTC/cc=;
        b=X6+Ywhc78m4p+kT6qqIPjgvJ3Zx3Z0hS0CHB5DYmQBZ7PR6nSC5XtL0k1eAqgW+T2A
         arIOEvoTh0PawnNADBx4cfzjPh+LMZt4/6YT2a0xQZNNGMbu+JUTvn4QDS7u6qB/XFpb
         m8SRCFLPOi6t1ZxmB0VFSq0Y8QpwVUx+xwFgRzx9oCuW7jpJM4RCtv65LngavoRIi/nu
         Fpjyo8GiSpAwjgnqm+y+Jaz7nhMibEDnke6jnbNvfyItlFLAyMzxlwgb8wPxGPHe7TJv
         LuU75L9/cnAwCuDFPuzb72wG2hRaX5KXpU3jfvw/fOd6ZlgGQfBTkoT3me94H4hRNG2u
         Z0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734491250; x=1735096050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGzoMP4pz94E3iZ2ZVAY+FjoyH+9uJ8+ltaU5mTC/cc=;
        b=f/O3gXP8+A7MhMddNvduBXR8NnIuKTjXwQgtCI7GXxhOAEEItRJVbqsMcXu/05B2E4
         bTBEoqA1UutODjz00nUrw2YdLI3EdYgvIfPrPuNKELWjF7iceV4jy6xkTpXLgWdK/13h
         c//o7ZIlv5e91xRhU+qbykARtbn68THfxJTqz0YF9Cvf2DPrA2sfedhqgjC0SQkO7zO6
         4ewzYm4fP6ovC6WwZYlnZaOfDTpUFPk3Mu/oiVeW2h46kCzZ4gUWdSmj0I0VuILYHhFO
         tBzWDbsc+o7Vt+P3m/qG/gERTosXGz4WwxrYQTeFHSxV5i88xcf4Fm9fBO01QVIzjAAC
         kVpg==
X-Gm-Message-State: AOJu0YxcTymRyQj3+nz9wTa3oVfMkNmQg0LZm/jZH9aYhVoGBpXwM4HL
	Zy2f3tgKvYvN1fDyA4dqx0skR4S33YFH3N4R1Rdd4T+j4MDsq21mBHDGwg==
X-Gm-Gg: ASbGncvX/FgOkIeFBgpFDJ0yOfbIJD/BE2LhF8X2euzh+ATydjihmQ4pWxV8Bl2mQFu
	JqJYHW1lCpJxh/7BhK1cYNmPQai4yaZb9WOcVIrG1wHHogN3ROFJ3QV64NeiZl2Rc5v0e01bkmy
	1zA7dGjl2fF2DYRv62mWsEperusNL/LwUX8fwiPl8J+EbDDYk6uLZ+l2TmogzzwTJ/pzZ+jfrbI
	ed9Czh7aKM4HCUrG8J+f6pSDVTu609E85p2nHFKn1wf3zAL8yQnN1ThsRUUlw==
X-Google-Smtp-Source: AGHT+IHS1I5BEwtWaQWxY8nR9/3Gb5s3FBDzligOvFHMM+1wBgrv8C56AV9pKBLPsNZs5Vq+R7EbDg==
X-Received: by 2002:a05:6830:4391:b0:71d:eee3:fd26 with SMTP id 46e09a7af769-71fb75611a4mr755835a34.4.1734491249808;
        Tue, 17 Dec 2024 19:07:29 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:4::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71e48307e07sm2482972a34.1.2024.12.17.19.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 19:07:28 -0800 (PST)
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
Subject: [PATCH bpf-next v3 1/6] mm, bpf: Introduce try_alloc_pages() for opportunistic page allocation
Date: Tue, 17 Dec 2024 19:07:14 -0800
Message-ID: <20241218030720.1602449-2-alexei.starovoitov@gmail.com>
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

Tracing BPF programs execute from tracepoints and kprobes where
running context is unknown, but they need to request additional
memory. The prior workarounds were using pre-allocated memory and
BPF specific freelists to satisfy such allocation requests.
Instead, introduce internal __GFP_TRYLOCK flag that makes page
allocator accessible from any context. It relies on percpu free
list of pages that rmqueue_pcplist() should be able to pop the
page from. If it fails (due to IRQ re-entrancy or list being
empty) then try_alloc_pages() attempts to spin_trylock zone->lock
and refill percpu freelist as normal.
BPF program may execute with IRQs disabled and zone->lock is
sleeping in RT, so trylock is the only option. In theory we can
introduce percpu reentrance counter and increment it every time
spin_lock_irqsave(&zone->lock, flags) is used, but we cannot rely
on it. Even if this cpu is not in page_alloc path the
spin_lock_irqsave() is not safe, since BPF prog might be called
from tracepoint where preemption is disabled. So trylock only.

Note, free_page and memcg are not taught about __GFP_TRYLOCK yet.
The support comes in the next patches.

This is a first step towards supporting BPF requirements in SLUB
and getting rid of bpf_mem_alloc.
That goal was discussed at LSFMM: https://lwn.net/Articles/974138/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h       |  3 ++
 include/linux/gfp_types.h |  1 +
 mm/internal.h             |  2 ++
 mm/page_alloc.c           | 69 ++++++++++++++++++++++++++++++++++++---
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b0fe9f62d15b..65b8df1db26a 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -347,6 +347,9 @@ static inline struct page *alloc_page_vma_noprof(gfp_t gfp,
 }
 #define alloc_page_vma(...)			alloc_hooks(alloc_page_vma_noprof(__VA_ARGS__))
 
+struct page *try_alloc_pages_noprof(int nid, unsigned int order);
+#define try_alloc_pages(...)			alloc_hooks(try_alloc_pages_noprof(__VA_ARGS__))
+
 extern unsigned long get_free_pages_noprof(gfp_t gfp_mask, unsigned int order);
 #define __get_free_pages(...)			alloc_hooks(get_free_pages_noprof(__VA_ARGS__))
 
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..65b148ec86eb 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -48,6 +48,7 @@ enum {
 	___GFP_THISNODE_BIT,
 	___GFP_ACCOUNT_BIT,
 	___GFP_ZEROTAGS_BIT,
+	___GFP_TRYLOCK_BIT,
 #ifdef CONFIG_KASAN_HW_TAGS
 	___GFP_SKIP_ZERO_BIT,
 	___GFP_SKIP_KASAN_BIT,
diff --git a/mm/internal.h b/mm/internal.h
index cb8d8e8e3ffa..122fce7e1a9e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1175,6 +1175,8 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+#define __GFP_TRYLOCK		((__force gfp_t)BIT(___GFP_TRYLOCK_BIT))
+#define ALLOC_TRYLOCK		0x1000000 /* Only use spin_trylock in allocation path */
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1cb4b8c8886d..d23545057b6e 100644
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
@@ -4001,6 +4009,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	 */
 	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_MIN_RESERVE);
 	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);
+	BUILD_BUG_ON(__GFP_TRYLOCK != (__force gfp_t) ALLOC_TRYLOCK);
 
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
@@ -4009,7 +4018,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
 	 */
 	alloc_flags |= (__force int)
-		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
+		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TRYLOCK));
 
 	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
 		/*
@@ -4509,7 +4518,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	might_alloc(gfp_mask);
 
-	if (should_fail_alloc_page(gfp_mask, order))
+	if (!(*alloc_flags & ALLOC_TRYLOCK) &&
+	    should_fail_alloc_page(gfp_mask, order))
 		return false;
 
 	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
@@ -7023,3 +7033,54 @@ static bool __free_unaccepted(struct page *page)
 }
 
 #endif /* CONFIG_UNACCEPTED_MEMORY */
+
+struct page *try_alloc_pages_noprof(int nid, unsigned int order)
+{
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO |
+			  __GFP_NOMEMALLOC | __GFP_TRYLOCK;
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
+	if (has_unaccepted_memory() && !list_empty(&zone->unaccepted_pages))
+		return NULL;
+#endif
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
+	 * Do not specify __GFP_KSWAPD_RECLAIM to avoid wakeup_kswapd
+	 * that may need to grab a lock.
+	 * Do not specify __GFP_ACCOUNT to avoid local_lock.
+	 * Do not warn either.
+	 */
+	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+
+	/* Unlike regular alloc_pages() there is no __alloc_pages_slowpath(). */
+
+	trace_mm_page_alloc(page, order, alloc_gfp & ~__GFP_TRYLOCK, ac.migratetype);
+	kmsan_alloc_page(page, order, alloc_gfp);
+	return page;
+}
-- 
2.43.5


