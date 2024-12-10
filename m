Return-Path: <bpf+bounces-46470-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 545209EA540
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 03:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F171885CD7
	for <lists+bpf@lfdr.de>; Tue, 10 Dec 2024 02:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE19C19E838;
	Tue, 10 Dec 2024 02:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKIIOrVA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE77070816
	for <bpf@vger.kernel.org>; Tue, 10 Dec 2024 02:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798388; cv=none; b=gbLZHQusdszrRrq/xufPVaa7zM6aUyUp00y+CljCOWDi8u6QhTLJoF8YsOvejczm8QU13uzPJEZN9NtURFiT28NE+/Ob8yguS9NLcwB8Zrw9jzfk3rQbpAM/3FhPI/xdCuw5+m8Q61y11ANZnCxmE5wnnsFlRsjz1sykcKQrK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798388; c=relaxed/simple;
	bh=2ahhnq6krYaIwI87BpkWONxMpUh4JoYZwltPnleHSbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rqyHgOZFJq1WZyUu3uhoqPUJNxXDXAJ9j4O8mx3UHFWkinjvM7+SuSvyKrzHcOnkpfC+QeEqpnxcEWGN5MydxVLS74Xc+3T/6wXZm7hd0X8kPnx8KuVNHw4Ar6zM09fKyx1hFWOUuiVcY0/DCoh9opw56gYWIY2NQVxRhgU8ftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKIIOrVA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7feffe7cdb7so335294a12.1
        for <bpf@vger.kernel.org>; Mon, 09 Dec 2024 18:39:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733798385; x=1734403185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8e35BB82VxfWbGWqr1nA/p1/ofzs8olLXSCBkO0zstU=;
        b=eKIIOrVAhn22n0Y/ZLJVtI2ucrpDg2hDuipv3JsCzdJ4d1NDtDmloOoRD2UPiVZ4RO
         YtuPynYYY/z/Q/wQ/xO3uhDRN3Mfu/lThVaKhpRnsvoEZmKYDzwF89b13adsG00ymmao
         yhLyH0qDcn6rscDvwAp1+4ByZn6XU+P/NXWjOkkkUR69hMzYXJghQ1gE2huunLU48Vro
         Zv7jvXYRasqghTlhOtdSh3+v8Y31OOsXrGpL2K6imE92+aHQt5fvHqPEDwswa2yf/jgQ
         b8Bk2oK52sitYa64jAP5Ct2kAXGMEfSzk8Y+XQkNtBxTu6zMEOnaSwmTLQizk9dW7UQ5
         d0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798385; x=1734403185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8e35BB82VxfWbGWqr1nA/p1/ofzs8olLXSCBkO0zstU=;
        b=Jl3Ak8HcwhgY4iaryV5XMC+CK2OYQJGZnGorAQEsbr/ne4DlSlxstvTEak5bp4qje+
         tL6IFy3gH2h6FYNiNZcyYOvbHpFfYr6k/1V130INJHFTeDvrKbnWR0yaktw2PaIimwzM
         UL6OpRS9aPZn/jqHIlvsS7AWCLM/3tgWXW5tEZM8yFm/bPbMTsic967YNKSnDxARjMbq
         9ED3sNdzxRWQGcuedO+22vX3JwKy0jc99Xca/75y49V/H0aQwgftqz8cRH6oAW+92GGa
         H3Qi49WBuXeY9U2R5i0OHDLA9xwBbtxW1f+WsDCZWFITO3uikyp8+3UKdvVDnd1PHlDa
         BV1g==
X-Gm-Message-State: AOJu0YymyPCSkqn35UzEU5nwxAxxP3CQwCPP0kXa37ZtqFzfUjWPU6qk
	4ltXZLP4eemEue4n5rnJhICYQX1jGh2X53kvV9yspbmN8vJyVNBE8q70rg==
X-Gm-Gg: ASbGncuNqfbwafHvKo7lGNiMeVqWaFrugVaosFZ+rAmrGFOM/86ly5MLf5qjtlCyIWn
	05vH/ADtEHiIm5X8OdLlS34Q7SMCN4jKbGp1esh+xAjTsURCEuPk0g3Zx3KBhkUT3C7cELemVJt
	1L7U+uLe10T2rWa/sHtnchYqnzZE2Zx4z7c2jn5Gx4xsT0dYTuPkfn9mzX2tYfBffJIvfaIvLi+
	9HeXAlGEVQjeNSvaa98Z5yCmyqlca4E6J96RBVfGh0CLH8C6DOP1xrw8Bx9hIxD+dEnxIx34lyL
	8UsBEA==
X-Google-Smtp-Source: AGHT+IETlDQVakNHy9XhiE9Y3JSlfzGxx7wfgdM3m/HG+ucSQQHFTGfnOzVwILgjB0Zho8MlhPqG4w==
X-Received: by 2002:a17:90b:2e43:b0:2ee:acb4:fecd with SMTP id 98e67ed59e1d1-2ef69e16bd4mr21878450a91.9.1733798385246;
        Mon, 09 Dec 2024 18:39:45 -0800 (PST)
Received: from localhost.localdomain ([2620:10d:c090:400::5:83b0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef4600d2c4sm9544043a91.47.2024.12.09.18.39.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 18:39:44 -0800 (PST)
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
Subject: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for opportunistic page allocation
Date: Mon,  9 Dec 2024 18:39:31 -0800
Message-Id: <20241210023936.46871-2-alexei.starovoitov@gmail.com>
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

Tracing BPF programs execute from tracepoints and kprobes where running
context is unknown, but they need to request additional memory.
The prior workarounds were using pre-allocated memory and BPF specific
freelists to satisfy such allocation requests. Instead, introduce
__GFP_TRYLOCK flag that makes page allocator accessible from any context.
It relies on percpu free list of pages that rmqueue_pcplist() should be
able to pop the page from. If it fails (due to IRQ re-entrancy or list
being empty) then try_alloc_pages() attempts to spin_trylock zone->lock
and refill percpu freelist as normal.
BPF program may execute with IRQs disabled and zone->lock is sleeping in RT,
so trylock is the only option.
In theory we can introduce percpu reentrance counter and increment it
every time spin_lock_irqsave(&zone->lock, flags) is used,
but we cannot rely on it. Even if this cpu is not in page_alloc path
the spin_lock_irqsave() is not safe, since BPF prog might be called
from tracepoint where preemption is disabled. So trylock only.

Note, free_page and memcg are not taught about __GFP_TRYLOCK yet.
The support comes in the next patches.

This is a first step towards supporting BPF requirements in SLUB
and getting rid of bpf_mem_alloc.
That goal was discussed at LSFMM: https://lwn.net/Articles/974138/

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/gfp.h            | 25 +++++++++++++++++++++++++
 include/linux/gfp_types.h      |  3 +++
 include/trace/events/mmflags.h |  1 +
 mm/fail_page_alloc.c           |  6 ++++++
 mm/internal.h                  |  1 +
 mm/page_alloc.c                | 17 ++++++++++++++---
 tools/perf/builtin-kmem.c      |  1 +
 7 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index b0fe9f62d15b..f68daa9c997b 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -347,6 +347,31 @@ static inline struct page *alloc_page_vma_noprof(gfp_t gfp,
 }
 #define alloc_page_vma(...)			alloc_hooks(alloc_page_vma_noprof(__VA_ARGS__))
 
+static inline struct page *try_alloc_pages_noprof(int nid, unsigned int order)
+{
+	/*
+	 * If spin_locks are not held and interrupts are enabled, use normal
+	 * path. BPF progs run under rcu_read_lock(), so in PREEMPT_RT
+	 * rcu_preempt_depth() will be >= 1 and will use trylock path.
+	 */
+	if (preemptible() && !rcu_preempt_depth())
+		return alloc_pages_node_noprof(nid,
+					       GFP_NOWAIT | __GFP_ZERO,
+					       order);
+	/*
+	 * Best effort allocation from percpu free list.
+	 * If it's empty attempt to spin_trylock zone->lock.
+	 * Do not specify __GFP_KSWAPD_RECLAIM to avoid wakeup_kswapd
+	 * that may need to grab a lock.
+	 * Do not specify __GFP_ACCOUNT to avoid local_lock.
+	 * Do not warn either.
+	 */
+	return alloc_pages_node_noprof(nid,
+				       __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO,
+				       order);
+}
+#define try_alloc_pages(...)			alloc_hooks(try_alloc_pages_noprof(__VA_ARGS__))
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
diff --git a/mm/fail_page_alloc.c b/mm/fail_page_alloc.c
index 7647096170e9..b3b297d67909 100644
--- a/mm/fail_page_alloc.c
+++ b/mm/fail_page_alloc.c
@@ -31,6 +31,12 @@ bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 		return false;
 	if (gfp_mask & __GFP_NOFAIL)
 		return false;
+	if (gfp_mask & __GFP_TRYLOCK)
+		/*
+		 * Internals of should_fail_ex() are not compatible
+		 * with trylock concept.
+		 */
+		return false;
 	if (fail_page_alloc.ignore_gfp_highmem && (gfp_mask & __GFP_HIGHMEM))
 		return false;
 	if (fail_page_alloc.ignore_gfp_reclaim &&
diff --git a/mm/internal.h b/mm/internal.h
index cb8d8e8e3ffa..c082b8fa1d71 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1175,6 +1175,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+#define ALLOC_TRYLOCK		0x1000000 /* Only use spin_trylock in allocation path */
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1cb4b8c8886d..d511e68903c6 100644
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
+		if (!spin_trylock_irqsave(&zone->lock, flags)){
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
@@ -4509,6 +4518,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 
 	might_alloc(gfp_mask);
 
+	*alloc_flags |= (__force int) (gfp_mask & __GFP_TRYLOCK);
+
 	if (should_fail_alloc_page(gfp_mask, order))
 		return false;
 
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 4d8d94146f8d..1f7f4269fa10 100644
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


