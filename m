Return-Path: <bpf+bounces-62735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6ACAFDD20
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000334A5484
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F30E194A44;
	Wed,  9 Jul 2025 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6LLK4MK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8077153BD9
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026006; cv=none; b=BK1P8iqA7hvWmpsGaoJ2TM+sF01oqQgR8Jxcr5Y1XABL3OMAwB811ap6Wu73uEx3Bsn4GBtckuRL75YYVk50BBp+s4qgtyq+Yc1PzlY45gP0ZK8M2N08wiVpeWWlvjZU0rGnLqyxcLu6E6frkkH6xjVKTPs1eaJlck3aJlCLnno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026006; c=relaxed/simple;
	bh=GF49qqqq433suecMGfQw3ZrJa1zAXxtPdJL7rVWr6oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O0G1jgO5/q9z7zk/glMyhyYHxSqHeeH2q6MqebpHHp7jHZbak2XJEsjnBnmBvemVh8wqDoBzsWwfE2XifsGVgowW3d2s522ESwmN02ydcDBUaNanSAqDqEDoiy5eiwvFpsvW++n0MbNSwD8LKJWULKTO0JxxsYo8lG3H4fviP8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6LLK4MK; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23636167b30so51120035ad.1
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752026003; x=1752630803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YnkHCpSnaIpZ2t6dm9MQaWh6UiPbKBICxKQZhmc7Mw=;
        b=C6LLK4MKyWHnkRfmw3xJLP+8wIwRVOOIojF3B4QG1YZ2b9CCrG113uGKM0m0abjOsP
         HLeyaohI19b4WD5bjSMuKjHmYWtFLm/gP7JpESuVfkaNdj/3jJp1YIy3JfFW+5CmGR1B
         XH/e0lq2WkgeHY+BGA6f36XfnhHeUCHfFcVFnd59oL7k049vxd1+TFyw7YJLU9nQF4YF
         v0/w/D9RCEFn8+me0VywEs0xnbfSNJOBSbFSIMwNa5EGmZwpVX0FXhgm9zf9U87Djvp6
         LIeQMLqG1v6DmuevNdcpUoiQxjXTXuU/G9kZsixuhfe47huanQ3AU80qH8m64meBBNaH
         qmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752026003; x=1752630803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YnkHCpSnaIpZ2t6dm9MQaWh6UiPbKBICxKQZhmc7Mw=;
        b=Er8dJi3ZnuSGG8T2Qt+InbC8YRQI7Xumz1BUu7SbAJ7cHt6rnmDl4Ph6i0xm1uuQkK
         NBKwajesW9cuWntpSh0u/vBgsf7s/hPpMM0QIrNGItusWICrYaq8mlxqzPCbKc860OPx
         +dRuUVmQ8cu00poQe3XdOIKtd7jtS07vc1OVUm+aLTT0HSnGkdWPjrO7Cwq2KOwh4DYW
         AXSRpC0sjaZYw/fBmX6e40wUvj+iCSOkKHx3Es4pAtyL0ErBcI+5/jGEasmRB1f0N47p
         vAVfMtuVsSo85lZbkD9sJVzUVnbztKW8enUPiLnnfplVSJIdSaSxIY0iQxd89iKMvhAI
         NEYQ==
X-Gm-Message-State: AOJu0Yw4mbWTIGME7Ub1DFXJ/j1OH+cv65KNfqwVyuOrmYchxtCp5ObN
	8eVOK4o7hXNdV6M4370hNJ/1HQUuhuRlWHn9eNW83r0eHOiI7GZM+X2Oo7xoYw==
X-Gm-Gg: ASbGncuT/AKAU5sbXhdUZCB+r5dStDBipzUJcwW03sZzVPkdxKdFaNHkXtJx6vNvoVQ
	RxtnAYU7XPYg8d8K2R7NCGMdu/+8dkEw9JsleSEs78qi3+yUrk+6Xulx+Fbsc1WMa90KuITyArb
	rMMM+4+vISEiHbzfEhvhRJug/kq44feaMtLL4KhQS4qF9ubygZzn2nFX8JG3SZCBbkA+4irf4Zj
	FkYTV4y+ecfN7bhBlnfzCgbAaY8kPzFnls82JnTPBzyPK57oj6rUWtgJ7uS2pdvceZ2VLRCzT/v
	7tMFZV0KU2zFjYlx1kodNzy2ku8hwiEFfIftMfsHIPNFf6/r5b7g0tm/OmOBor/qOE7zpW2Df2E
	rrpnHKrqvwXYdfXpCQofDWJM6QbLiUhVd5x0FcA==
X-Google-Smtp-Source: AGHT+IFiJdGM4iMT0UeyI9b06UPXBG1AvN2zTdWiRIYOAx9BZ6g/30rL7wDzzDviTGO8VfmlD3e9Ew==
X-Received: by 2002:a17:903:3b8b:b0:237:f7f8:7453 with SMTP id d9443c01a7336-23ddb32cec2mr9150995ad.51.1752026002515;
        Tue, 08 Jul 2025 18:53:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c845998a6sm132951135ad.213.2025.07.08.18.53.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 08 Jul 2025 18:53:22 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	linux-mm@kvack.org
Cc: vbabka@suse.cz,
	harry.yoo@oracle.com,
	shakeel.butt@linux.dev,
	mhocko@suse.com,
	bigeasy@linutronix.de,
	andrii@kernel.org,
	memxor@gmail.com,
	akpm@linux-foundation.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	hannes@cmpxchg.org
Subject: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
Date: Tue,  8 Jul 2025 18:53:03 -0700
Message-Id: <20250709015303.8107-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

kmalloc_nolock() relies on ability of local_lock to detect the situation
when it's locked.
In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
In that case retry the operation in a different kmalloc bucket.
The second attempt will likely succeed, since this cpu locked
different kmem_cache_cpu.

Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
per-cpu rt_spin_lock is locked by current task. In this case re-entrance
into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
a different bucket that is most likely is not locked by the current
task. Though it may be locked by a different task it's safe to
rt_spin_lock() on it.

Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
immediately if called from hard irq or NMI in PREEMPT_RT.

kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
and in_nmi() or in PREEMPT_RT.

SLUB_TINY config doesn't use local_lock_is_locked() and relies on
spin_trylock_irqsave(&n->list_lock) to allocate while kfree_nolock()
always defers to irq_work.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/kasan.h |  13 +-
 include/linux/slab.h  |   4 +
 mm/kasan/common.c     |   5 +-
 mm/slub.c             | 330 ++++++++++++++++++++++++++++++++++++++----
 4 files changed, 319 insertions(+), 33 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 890011071f2b..acdc8cb0152e 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -200,7 +200,7 @@ static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
 }
 
 bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init,
-		       bool still_accessible);
+		       bool still_accessible, bool no_quarantine);
 /**
  * kasan_slab_free - Poison, initialize, and quarantine a slab object.
  * @object: Object to be freed.
@@ -226,11 +226,13 @@ bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init,
  * @Return true if KASAN took ownership of the object; false otherwise.
  */
 static __always_inline bool kasan_slab_free(struct kmem_cache *s,
-						void *object, bool init,
-						bool still_accessible)
+					    void *object, bool init,
+					    bool still_accessible,
+					    bool no_quarantine)
 {
 	if (kasan_enabled())
-		return __kasan_slab_free(s, object, init, still_accessible);
+		return __kasan_slab_free(s, object, init, still_accessible,
+					 no_quarantine);
 	return false;
 }
 
@@ -427,7 +429,8 @@ static inline bool kasan_slab_pre_free(struct kmem_cache *s, void *object)
 }
 
 static inline bool kasan_slab_free(struct kmem_cache *s, void *object,
-				   bool init, bool still_accessible)
+				   bool init, bool still_accessible,
+				   bool no_quarantine)
 {
 	return false;
 }
diff --git a/include/linux/slab.h b/include/linux/slab.h
index d5a8ab98035c..743f6d196d57 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -470,6 +470,7 @@ void * __must_check krealloc_noprof(const void *objp, size_t new_size,
 #define krealloc(...)				alloc_hooks(krealloc_noprof(__VA_ARGS__))
 
 void kfree(const void *objp);
+void kfree_nolock(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
@@ -910,6 +911,9 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 }
 #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
+void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
+#define kmalloc_nolock(...)			alloc_hooks(kmalloc_nolock_noprof(__VA_ARGS__))
+
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
 
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ed4873e18c75..67042e07baee 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -256,13 +256,16 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 }
 
 bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
-		       bool still_accessible)
+		       bool still_accessible, bool no_quarantine)
 {
 	if (!kasan_arch_is_ready() || is_kfence_address(object))
 		return false;
 
 	poison_slab_object(cache, object, init, still_accessible);
 
+	if (no_quarantine)
+		return false;
+
 	/*
 	 * If the object is put into quarantine, do not let slab put the object
 	 * onto the freelist for now. The object's metadata is kept until the
diff --git a/mm/slub.c b/mm/slub.c
index c4b64821e680..f0844b44ee09 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -44,6 +44,7 @@
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/sort.h>
+#include <linux/irq_work.h>
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
@@ -393,7 +394,7 @@ struct kmem_cache_cpu {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct slab *partial;	/* Partially allocated slabs */
 #endif
-	local_lock_t lock;	/* Protects the fields above */
+	local_trylock_t lock;	/* Protects the fields above */
 #ifdef CONFIG_SLUB_STATS
 	unsigned int stat[NR_SLUB_STAT_ITEMS];
 #endif
@@ -1982,6 +1983,7 @@ static inline void init_slab_obj_exts(struct slab *slab)
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		        gfp_t gfp, bool new_slab)
 {
+	bool allow_spin = gfpflags_allow_spinning(gfp);
 	unsigned int objects = objs_per_slab(s, slab);
 	unsigned long new_exts;
 	unsigned long old_exts;
@@ -1990,8 +1992,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	gfp &= ~OBJCGS_CLEAR_MASK;
 	/* Prevent recursive extension vector allocation */
 	gfp |= __GFP_NO_OBJ_EXT;
-	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
-			   slab_nid(slab));
+	if (unlikely(!allow_spin)) {
+		size_t sz = objects * sizeof(struct slabobj_ext);
+
+		vec = kmalloc_nolock(sz, __GFP_ZERO, slab_nid(slab));
+	} else {
+		vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
+				   slab_nid(slab));
+	}
 	if (!vec) {
 		/* Mark vectors which failed to allocate */
 		if (new_slab)
@@ -2021,7 +2029,10 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		 * objcg vector should be reused.
 		 */
 		mark_objexts_empty(vec);
-		kfree(vec);
+		if (unlikely(!allow_spin))
+			kfree_nolock(vec);
+		else
+			kfree(vec);
 		return 0;
 	}
 
@@ -2379,7 +2390,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
 
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
-	return !kasan_slab_free(s, x, init, still_accessible);
+	return !kasan_slab_free(s, x, init, still_accessible, false);
 }
 
 static __fastpath_inline
@@ -2442,13 +2453,17 @@ static void *setup_object(struct kmem_cache *s, void *object)
  * Slab allocation and freeing
  */
 static inline struct slab *alloc_slab_page(gfp_t flags, int node,
-		struct kmem_cache_order_objects oo)
+					   struct kmem_cache_order_objects oo,
+					   bool allow_spin)
 {
 	struct folio *folio;
 	struct slab *slab;
 	unsigned int order = oo_order(oo);
 
-	if (node == NUMA_NO_NODE)
+	if (unlikely(!allow_spin)) {
+		folio = (struct folio *)alloc_frozen_pages_nolock(0/* __GFP_COMP is implied */,
+								  node, order);
+	} else if (node == NUMA_NO_NODE)
 		folio = (struct folio *)alloc_frozen_pages(flags, order);
 	else
 		folio = (struct folio *)__alloc_frozen_pages(flags, order, node, NULL);
@@ -2598,6 +2613,7 @@ static __always_inline void unaccount_slab(struct slab *slab, int order,
 
 static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
+	bool allow_spin = gfpflags_allow_spinning(flags);
 	struct slab *slab;
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
@@ -2617,7 +2633,11 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	if ((alloc_gfp & __GFP_DIRECT_RECLAIM) && oo_order(oo) > oo_order(s->min))
 		alloc_gfp = (alloc_gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
 
-	slab = alloc_slab_page(alloc_gfp, node, oo);
+	/*
+	 * __GFP_RECLAIM could be cleared on the first allocation attempt,
+	 * so pass allow_spin flag directly.
+	 */
+	slab = alloc_slab_page(alloc_gfp, node, oo, allow_spin);
 	if (unlikely(!slab)) {
 		oo = s->min;
 		alloc_gfp = flags;
@@ -2625,7 +2645,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Allocation may have failed due to fragmentation.
 		 * Try a lower order alloc if possible
 		 */
-		slab = alloc_slab_page(alloc_gfp, node, oo);
+		slab = alloc_slab_page(alloc_gfp, node, oo, allow_spin);
 		if (unlikely(!slab))
 			return NULL;
 		stat(s, ORDER_FALLBACK);
@@ -2803,8 +2823,8 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
  * allocated slab. Allocate a single object instead of whole freelist
  * and put the slab to the partial (or full) list.
  */
-static void *alloc_single_from_new_slab(struct kmem_cache *s,
-					struct slab *slab, int orig_size)
+static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
+					int orig_size, gfp_t gfpflags)
 {
 	int nid = slab_nid(slab);
 	struct kmem_cache_node *n = get_node(s, nid);
@@ -2824,7 +2844,10 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
 		 */
 		return NULL;
 
-	spin_lock_irqsave(&n->list_lock, flags);
+	if (gfpflags_allow_spinning(gfpflags))
+		spin_lock_irqsave(&n->list_lock, flags);
+	else if (!spin_trylock_irqsave(&n->list_lock, flags))
+		return NULL;
 
 	if (slab->inuse == slab->objects)
 		add_full(s, n, slab);
@@ -2865,7 +2888,10 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 	if (!n || !n->nr_partial)
 		return NULL;
 
-	spin_lock_irqsave(&n->list_lock, flags);
+	if (gfpflags_allow_spinning(pc->flags))
+		spin_lock_irqsave(&n->list_lock, flags);
+	else if (!spin_trylock_irqsave(&n->list_lock, flags))
+		return NULL;
 	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
 		if (!pfmemalloc_match(slab, pc->flags))
 			continue;
@@ -3056,7 +3082,7 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 
 	for_each_possible_cpu(cpu) {
 		c = per_cpu_ptr(s->cpu_slab, cpu);
-		local_lock_init(&c->lock);
+		local_trylock_init(&c->lock);
 		c->tid = init_tid(cpu);
 	}
 }
@@ -3690,6 +3716,7 @@ static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
+	bool allow_spin = gfpflags_allow_spinning(gfpflags);
 	void *freelist;
 	struct slab *slab;
 	unsigned long flags;
@@ -3717,7 +3744,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		 * same as above but node_match() being false already
 		 * implies node != NUMA_NO_NODE
 		 */
-		if (!node_isset(node, slab_nodes)) {
+		if (!node_isset(node, slab_nodes) ||
+		    !allow_spin) {
+			/*
+			 * Reentrant slub cannot take locks necessary
+			 * to deactivate_slab, hence downgrade to any node
+			 */
 			node = NUMA_NO_NODE;
 		} else {
 			stat(s, ALLOC_NODE_MISMATCH);
@@ -3730,7 +3762,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * PFMEMALLOC but right now, we are losing the pfmemalloc
 	 * information when the page leaves the per-cpu allocator
 	 */
-	if (unlikely(!pfmemalloc_match(slab, gfpflags)))
+	if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin))
 		goto deactivate_slab;
 
 	/* must check again c->slab in case we got preempted and it changed */
@@ -3803,7 +3835,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		slub_set_percpu_partial(c, slab);
 
 		if (likely(node_match(slab, node) &&
-			   pfmemalloc_match(slab, gfpflags))) {
+			   pfmemalloc_match(slab, gfpflags)) ||
+		    /*
+		     * Reentrant slub cannot take locks necessary
+		     * for __put_partials(), hence downgrade to any node
+		     */
+		    !allow_spin) {
 			c->slab = slab;
 			freelist = get_freelist(s, slab);
 			VM_BUG_ON(!freelist);
@@ -3833,8 +3870,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 *    allocating new page from other nodes
 	 */
 	if (unlikely(node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE)
-		     && try_thisnode))
-		pc.flags = GFP_NOWAIT | __GFP_THISNODE;
+		     && try_thisnode)) {
+		if (unlikely(!allow_spin))
+			/* Do not upgrade gfp to NOWAIT from more restrictive mode */
+			pc.flags = gfpflags | __GFP_THISNODE;
+		else
+			pc.flags = GFP_NOWAIT | __GFP_THISNODE;
+	}
 
 	pc.orig_size = orig_size;
 	slab = get_partial(s, node, &pc);
@@ -3873,7 +3915,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_SLAB);
 
 	if (kmem_cache_debug(s)) {
-		freelist = alloc_single_from_new_slab(s, slab, orig_size);
+		freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
 
 		if (unlikely(!freelist))
 			goto new_objects;
@@ -3895,7 +3937,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	inc_slabs_node(s, slab_nid(slab), slab->objects);
 
-	if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
+	if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
 		/*
 		 * For !pfmemalloc_match() case we don't load freelist so that
 		 * we don't make further mismatched allocations easier.
@@ -3911,6 +3953,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		void *flush_freelist = c->freelist;
 		struct slab *flush_slab = c->slab;
 
+		if (unlikely(!allow_spin))
+			/*
+			 * Reentrant slub cannot take locks
+			 * necessary for deactivate_slab()
+			 */
+			return NULL;
 		c->slab = NULL;
 		c->freelist = NULL;
 		c->tid = next_tid(c->tid);
@@ -3946,8 +3994,23 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 */
 	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
-
-	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
+	if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
+		if (local_lock_is_locked(&s->cpu_slab->lock)) {
+			/*
+			 * EBUSY is an internal signal to kmalloc_nolock() to
+			 * retry a different bucket. It's not propagated
+			 * to the caller.
+			 */
+			p = ERR_PTR(-EBUSY);
+			goto out;
+		}
+		local_lock_lockdep_start(&s->cpu_slab->lock);
+		p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
+		local_lock_lockdep_end(&s->cpu_slab->lock);
+	} else {
+		p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
+	}
+out:
 #ifdef CONFIG_PREEMPT_COUNT
 	slub_put_cpu_ptr(s->cpu_slab);
 #endif
@@ -4071,7 +4134,7 @@ static void *__slab_alloc_node(struct kmem_cache *s,
 		return NULL;
 	}
 
-	object = alloc_single_from_new_slab(s, slab, orig_size);
+	object = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
 
 	return object;
 }
@@ -4150,8 +4213,9 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 		if (p[i] && init && (!kasan_init ||
 				     !kasan_has_integrated_init()))
 			memset(p[i], 0, zero_size);
-		kmemleak_alloc_recursive(p[i], s->object_size, 1,
-					 s->flags, init_flags);
+		if (gfpflags_allow_spinning(flags))
+			kmemleak_alloc_recursive(p[i], s->object_size, 1,
+						 s->flags, init_flags);
 		kmsan_slab_alloc(s, p[i], init_flags);
 		alloc_tagging_slab_alloc_hook(s, p[i], flags);
 	}
@@ -4342,6 +4406,94 @@ void *__kmalloc_noprof(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc_noprof);
 
+/**
+ * kmalloc_nolock - Allocate an object of given size from any context.
+ * @size: size to allocate
+ * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO allowed.
+ * @node: node number of the target node.
+ *
+ * Return: pointer to the new object or NULL in case of error.
+ * NULL does not mean EBUSY or EAGAIN. It means ENOMEM.
+ * There is no reason to call it again and expect !NULL.
+ */
+void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
+{
+	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
+	struct kmem_cache *s;
+	bool can_retry = true;
+	void *ret = ERR_PTR(-EBUSY);
+
+	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
+
+	if (unlikely(!size))
+		return ZERO_SIZE_PTR;
+
+	if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))
+		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
+		return NULL;
+retry:
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return NULL;
+	s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
+
+	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
+		/*
+		 * kmalloc_nolock() is not supported on architectures that
+		 * don't implement cmpxchg16b, but debug caches don't use
+		 * per-cpu slab and per-cpu partial slabs. They rely on
+		 * kmem_cache_node->list_lock, so kmalloc_nolock() can
+		 * attempt to allocate from debug caches by
+		 * spin_trylock_irqsave(&n->list_lock, ...)
+		 */
+		return NULL;
+
+	/*
+	 * Do not call slab_alloc_node(), since trylock mode isn't
+	 * compatible with slab_pre_alloc_hook/should_failslab and
+	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
+	 * and slab_post_alloc_hook() directly.
+	 *
+	 * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
+	 * in irq saved region. It assumes that the same cpu will not
+	 * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
+	 * Therefore use in_nmi() to check whether particular bucket is in
+	 * irq protected section.
+	 *
+	 * If in_nmi() && local_lock_is_locked(s->cpu_slab) then it means that
+	 * this cpu was interrupted somewhere inside ___slab_alloc() after
+	 * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
+	 * In this case fast path with __update_cpu_freelist_fast() is not safe.
+	 */
+#ifndef CONFIG_SLUB_TINY
+	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
+#endif
+		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
+
+	if (PTR_ERR(ret) == -EBUSY) {
+		if (can_retry) {
+			/* pick the next kmalloc bucket */
+			size = s->object_size + 1;
+			/*
+			 * Another alternative is to
+			 * if (memcg) alloc_gfp &= ~__GFP_ACCOUNT;
+			 * else if (!memcg) alloc_gfp |= __GFP_ACCOUNT;
+			 * to retry from bucket of the same size.
+			 */
+			can_retry = false;
+			goto retry;
+		}
+		ret = NULL;
+	}
+
+	maybe_wipe_obj_freeptr(s, ret);
+	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
+			     slab_want_init_on_alloc(alloc_gfp, s), size);
+
+	ret = kasan_kmalloc(s, ret, size, alloc_gfp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kmalloc_nolock_noprof);
+
 void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags,
 					 int node, unsigned long caller)
 {
@@ -4555,6 +4707,53 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	discard_slab(s, slab);
 }
 
+static DEFINE_PER_CPU(struct llist_head, defer_free_objects);
+static DEFINE_PER_CPU(struct irq_work, defer_free_work);
+
+static void free_deferred_objects(struct irq_work *work)
+{
+	struct llist_head *llhead = this_cpu_ptr(&defer_free_objects);
+	struct llist_node *llnode, *pos, *t;
+
+	if (llist_empty(llhead))
+		return;
+
+	llnode = llist_del_all(llhead);
+	llist_for_each_safe(pos, t, llnode) {
+		struct kmem_cache *s;
+		struct slab *slab;
+		void *x = pos;
+
+		slab = virt_to_slab(x);
+		s = slab->slab_cache;
+
+		/*
+		 * memcg, kasan_slab_pre are already done for 'x'.
+		 * The only thing left is kasan_poison.
+		 */
+		kasan_slab_free(s, x, false, false, true);
+		__slab_free(s, slab, x, x, 1, _THIS_IP_);
+	}
+}
+
+static int __init init_defer_work(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		init_llist_head(per_cpu_ptr(&defer_free_objects, cpu));
+		init_irq_work(per_cpu_ptr(&defer_free_work, cpu),
+			      free_deferred_objects);
+	}
+	return 0;
+}
+late_initcall(init_defer_work);
+
+static void defer_free(void *head)
+{
+	if (llist_add(head, this_cpu_ptr(&defer_free_objects)))
+		irq_work_queue(this_cpu_ptr(&defer_free_work));
+}
 #ifndef CONFIG_SLUB_TINY
 /*
  * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
@@ -4593,10 +4792,31 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	barrier();
 
 	if (unlikely(slab != c->slab)) {
-		__slab_free(s, slab, head, tail, cnt, addr);
+		/* cnt == 0 signals that it's called from kfree_nolock() */
+		if (unlikely(!cnt)) {
+			/*
+			 * __slab_free() can locklessly cmpxchg16 into a slab,
+			 * but then it might need to take spin_lock or local_lock
+			 * in put_cpu_partial() for further processing.
+			 * Avoid the complexity and simply add to a deferred list.
+			 */
+			defer_free(head);
+		} else {
+			__slab_free(s, slab, head, tail, cnt, addr);
+		}
 		return;
 	}
 
+	if (unlikely(!cnt)) {
+		if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
+		    local_lock_is_locked(&s->cpu_slab->lock)) {
+			defer_free(head);
+			return;
+		}
+		cnt = 1;
+		kasan_slab_free(s, head, false, false, /* skip quarantine */true);
+	}
+
 	if (USE_LOCKLESS_FAST_PATH()) {
 		freelist = READ_ONCE(c->freelist);
 
@@ -4844,6 +5064,62 @@ void kfree(const void *object)
 }
 EXPORT_SYMBOL(kfree);
 
+/*
+ * Can be called while holding raw_spin_lock or from IRQ and NMI,
+ * but only for objects allocated by kmalloc_nolock(),
+ * since some debug checks (like kmemleak and kfence) were
+ * skipped on allocation. large_kmalloc is not supported either.
+ */
+void kfree_nolock(const void *object)
+{
+	struct folio *folio;
+	struct slab *slab;
+	struct kmem_cache *s;
+	void *x = (void *)object;
+
+	if (unlikely(ZERO_OR_NULL_PTR(object)))
+		return;
+
+	folio = virt_to_folio(object);
+	if (unlikely(!folio_test_slab(folio))) {
+		WARN(1, "Buggy usage of kfree_nolock");
+		return;
+	}
+
+	slab = folio_slab(folio);
+	s = slab->slab_cache;
+
+	memcg_slab_free_hook(s, slab, &x, 1);
+	alloc_tagging_slab_free_hook(s, slab, &x, 1);
+	/*
+	 * Unlike slab_free() do NOT call the following:
+	 * kmemleak_free_recursive(x, s->flags);
+	 * debug_check_no_locks_freed(x, s->object_size);
+	 * debug_check_no_obj_freed(x, s->object_size);
+	 * __kcsan_check_access(x, s->object_size, ..);
+	 * kfence_free(x);
+	 * since they take spinlocks.
+	 */
+	kmsan_slab_free(s, x);
+	/*
+	 * If KASAN finds a kernel bug it will do kasan_report_invalid_free()
+	 * which will call raw_spin_lock_irqsave() which is technically
+	 * unsafe from NMI, but take chance and report kernel bug.
+	 * The sequence of
+	 * kasan_report_invalid_free() -> raw_spin_lock_irqsave() -> NMI
+	 *  -> kfree_nolock() -> kasan_report_invalid_free() on the same CPU
+	 * is double buggy and deserves to deadlock.
+	 */
+	if (kasan_slab_pre_free(s, x))
+		return;
+#ifndef CONFIG_SLUB_TINY
+	do_slab_free(s, slab, x, x, 0, _RET_IP_);
+#else
+	defer_free(x);
+#endif
+}
+EXPORT_SYMBOL_GPL(kfree_nolock);
+
 static __always_inline __realloc_size(2) void *
 __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 {
-- 
2.47.1


