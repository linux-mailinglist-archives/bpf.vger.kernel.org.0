Return-Path: <bpf+bounces-45003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D771E9CFC4A
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 02:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6791F24FBA
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 01:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827D52AF1D;
	Sat, 16 Nov 2024 01:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMemd0+D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC92913
	for <bpf@vger.kernel.org>; Sat, 16 Nov 2024 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731721741; cv=none; b=ToPoU34SJYK/pevWNaz6vA+jjAaBPUXmF0RpS1/eQ7EACR0iCsT9H0MfE6pSyhFVjQsW11xcgC2mITdlifs/QaEl5sdC966aq/2qcdSGp6+VvHSdy+YMfQIZg3Pw0Hg6nyuSLZ4NrQkmreyAVdUjbrsN/pbp/YiJ3iMRfdAX3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731721741; c=relaxed/simple;
	bh=fPdrLeSpy8v9E+ocFsNkhKj6ZIsGtiCZnPnFdfXibHE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mlelCzGIhtQeVoZb1wK4X+ZUf/aMvSYFW4Z+Dj4wr5IfCG57r1ciOvQQX5/Ufc//SV+G6K/QTHMU7tJaw3ksLDtdVvXu2Gk3xYKGYqEfrCIYUnK93CCmoMb5hEk4lR44dlUcMGh5VDw/d62PoziB6XCzX1KstKQgIZH/VCJ+a0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMemd0+D; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so162931b3a.0
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 17:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731721738; x=1732326538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+79Kfaw5fe7Fc2LoAbnH3ncEOsPPAzqv/6GDpIAw8Gs=;
        b=QMemd0+DyeUYvknATTZO4VrFCCuN0FZjVWPRywgdEBeEyEEDTScfcP6W6dUHVNQPhw
         ULXuSD92SvTI2XK0y5tS142W8QRir9UkOn67slOeEekPC2g/VVwxeLkhoHojb9xC6qBw
         60ZZXyA8ZPAa5TqXmbkBsilXIwbmDXnQzlU3Kh9MxmKt0ZXTqIR6DOW6QFem5/X/x2dL
         PclatPRccmq27ddAC+C/cQa601Xx/YZupHYh7C2A4l/6RbnANOAMOZjxR5VnyKwuHMv9
         4CFk93Irat4/+Bd7OghduiHTKarzcIzNSoQpfjdtd2r+bhAMyAOIuBLzb8lzB5I2Wpit
         NSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731721738; x=1732326538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+79Kfaw5fe7Fc2LoAbnH3ncEOsPPAzqv/6GDpIAw8Gs=;
        b=NfJEnQEdS6KyeR29gXKJ4hMxHPsH9PhW8K1cTFxghml7kHZeiuIkAgYdCCoLXiuf8F
         Pqb7r5RG3KasOSgSWjU/kBJLa4rokJR2/ZUbRtSEGWnxOw4yMiUJZGHvH2pOvwTBqDjJ
         6GaU7RN/SHhZtidDu25iFRNFtHQBUCIgMAq4atGE2KH8KrMowYNoauhD09vMfzKOvvXd
         3gj5aUtHcILga0cFuGjPP7ZBC7q9t2q4WdZwmHfmeymLEJR82kp4I/q+pC+T0Z4gxDds
         ybvfCugTuuVbyI7r2p14TiPMeHaTna1anKhNS4ZsACa9ReEdjQpgjjauhb062kxLeheH
         EECQ==
X-Gm-Message-State: AOJu0YxAeg7IUPt1b3EHl+Z64g1ojAP3C60tZFMa0QmnDxAU6p+4fITN
	5IHpp8vwMC+5dy4iXurcCNRSCbQwCLDMYSOmsNPj1vDeByZmvefpnZX4jg==
X-Google-Smtp-Source: AGHT+IGOpIEDJrOXhIngnIgv7phc33Efc94Kd3O31wdErbdCJAFeh7ZHECk8Etg5vaSZXZlPndCtDA==
X-Received: by 2002:a05:6a00:10ce:b0:71e:3b8f:92e with SMTP id d2e1a72fcca58-72476b72b2bmr6538531b3a.3.1731721737747;
        Fri, 15 Nov 2024 17:48:57 -0800 (PST)
Received: from macbook-pro-49.lan ([2603:3023:16e:5000:1863:9460:a110:750b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e1953sm2049389b3a.136.2024.11.15.17.48.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 15 Nov 2024 17:48:57 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	vbabka@suse.cz,
	houtao1@huawei.com,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	tj@kernel.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next 1/2] mm, bpf: Introduce __GFP_TRYLOCK for opportunistic page allocation
Date: Fri, 15 Nov 2024 17:48:53 -0800
Message-Id: <20241116014854.55141-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Tracing BPF programs execute from tracepoints and kprobes where running
context is unknown, but they need to request additional memory.
The prior workarounds were using pre-allocated memory and BPF specific
freelists to satisfy such allocation requests. Instead, introduce
__GFP_TRYLOCK flag that makes page allocator accessible from any context.
It relies on percpu free list of pages that rmqueue_pcplist() should be
able to pop the page from. If it fails (due to IRQ re-entrancy or list
being empty) then try_alloc_page() attempts to spin_trylock zone->lock
and refill percpu freelist as normal.
BPF program may execute with IRQs disabled and zone->lock is sleeping in RT,
so trylock is the only option.
In theory we can introduce percpu reentrance counter and increment it
every time spin_lock_irqsave(&zone->lock, flags) is used,
but we cannot rely on it. Even if this cpu is not in page_alloc path
the spin_lock_irqsave() is not safe, since BPF prog might be called
from tracepoint where preemption is disabled. So trylock only.

There is no attempt to make free_page() to be accessible from any
context (yet). BPF infrastructure will asynchronously free pages from
such contexts.
memcg is also not charged in try_alloc_page() path. It has to be
done asynchronously to avoid sleeping on
local_lock_irqsave(&memcg_stock.stock_lock, flags).

This is a first step towards supporting BPF requirements in SLUB
and getting rid of bpf_mem_alloc.
That goal was discussed at LSFMM: https://lwn.net/Articles/974138/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h            | 17 +++++++++++++++++
 include/linux/gfp_types.h      |  3 +++
 include/trace/events/mmflags.h |  1 +
 mm/internal.h                  |  1 +
 mm/page_alloc.c                | 19 ++++++++++++++++---
 tools/perf/builtin-kmem.c      |  1 +
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index a951de920e20..319d8906ef3f 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -347,6 +347,23 @@ static inline struct page *alloc_page_vma_noprof(gfp_t gfp,
 }
 #define alloc_page_vma(...)			alloc_hooks(alloc_page_vma_noprof(__VA_ARGS__))
 
+static inline struct page *try_alloc_page_noprof(int nid)
+{
+	/* If spin_locks are not held and interrupts are enabled, use normal path. */
+	if (preemptible())
+		return alloc_pages_node_noprof(nid, GFP_NOWAIT | __GFP_ZERO, 0);
+	/*
+	 * Best effort allocation from percpu free list.
+	 * If it's empty attempt to spin_trylock zone->lock.
+	 * Do not specify __GFP_KSWAPD_RECLAIM to avoid wakeup_kswapd
+	 * that may need to grab a lock.
+	 * Do not specify __GFP_ACCOUNT to avoid local_lock.
+	 * Do not warn either.
+	 */
+	return alloc_pages_node_noprof(nid, __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO, 0);
+}
+#define try_alloc_page(nid)			alloc_hooks(try_alloc_page_noprof(nid))
+
 extern unsigned long get_free_pages_noprof(gfp_t gfp_mask, unsigned int order);
 #define __get_free_pages(...)			alloc_hooks(get_free_pages_noprof(__VA_ARGS__))
 
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..72b385a7888d 100644
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
@@ -86,6 +87,7 @@ enum {
 #define ___GFP_THISNODE		BIT(___GFP_THISNODE_BIT)
 #define ___GFP_ACCOUNT		BIT(___GFP_ACCOUNT_BIT)
 #define ___GFP_ZEROTAGS		BIT(___GFP_ZEROTAGS_BIT)
+#define ___GFP_TRYLOCK		BIT(___GFP_TRYLOCK_BIT)
 #ifdef CONFIG_KASAN_HW_TAGS
 #define ___GFP_SKIP_ZERO	BIT(___GFP_SKIP_ZERO_BIT)
 #define ___GFP_SKIP_KASAN	BIT(___GFP_SKIP_KASAN_BIT)
@@ -293,6 +295,7 @@ enum {
 #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
 #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
 #define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
+#define __GFP_TRYLOCK	((__force gfp_t)___GFP_TRYLOCK)
 #define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
 #define __GFP_SKIP_KASAN ((__force gfp_t)___GFP_SKIP_KASAN)
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index bb8a59c6caa2..592c93ee5f35 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -50,6 +50,7 @@
 	gfpflag_string(__GFP_RECLAIM),		\
 	gfpflag_string(__GFP_DIRECT_RECLAIM),	\
 	gfpflag_string(__GFP_KSWAPD_RECLAIM),	\
+	gfpflag_string(__GFP_TRYLOCK),		\
 	gfpflag_string(__GFP_ZEROTAGS)
 
 #ifdef CONFIG_KASAN_HW_TAGS
diff --git a/mm/internal.h b/mm/internal.h
index 64c2eb0b160e..c1b08e95a63b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1173,6 +1173,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+#define ALLOC_TRYLOCK		0x1000000 /* Only use spin_trylock in allocation path */
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 216fbbfbedcf..71fed4f5bd0c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2304,7 +2304,12 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(&zone->lock, flags);
+	if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
+		if (!spin_trylock_irqsave(&zone->lock, flags))
+			return 0;
+	} else {
+		spin_lock_irqsave(&zone->lock, flags);
+	}
 	for (i = 0; i < count; ++i) {
 		struct page *page = __rmqueue(zone, order, migratetype,
 								alloc_flags);
@@ -2904,7 +2909,12 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
-		spin_lock_irqsave(&zone->lock, flags);
+		if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
+			if (!spin_trylock_irqsave(&zone->lock, flags))
+				return 0;
+		} else {
+			spin_lock_irqsave(&zone->lock, flags);
+		}
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
@@ -4001,6 +4011,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	 */
 	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_MIN_RESERVE);
 	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);
+	BUILD_BUG_ON(__GFP_TRYLOCK != (__force gfp_t) ALLOC_TRYLOCK);
 
 	/*
 	 * The caller may dip into page reserves a bit more if the caller
@@ -4009,7 +4020,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
 	 */
 	alloc_flags |= (__force int)
-		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
+		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM | __GFP_TRYLOCK));
 
 	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
 		/*
@@ -4509,6 +4520,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	might_alloc(gfp_mask);
 
+	*alloc_flags |= (__force int) (gfp_mask & __GFP_TRYLOCK);
+
 	if (should_fail_alloc_page(gfp_mask, order))
 		return false;
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index a756147e2eec..d245ff60d2a6 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -682,6 +682,7 @@ static const struct {
 	{ "__GFP_RECLAIM",		"R" },
 	{ "__GFP_DIRECT_RECLAIM",	"DR" },
 	{ "__GFP_KSWAPD_RECLAIM",	"KR" },
+	{ "__GFP_TRYLOCK",		"TL" },
 };
 
 static size_t max_gfp_len;
-- 
2.43.5


