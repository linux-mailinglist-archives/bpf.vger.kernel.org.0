Return-Path: <bpf+bounces-67826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A25B49E6F
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 03:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C21524E0399
	for <lists+bpf@lfdr.de>; Tue,  9 Sep 2025 01:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4D8222565;
	Tue,  9 Sep 2025 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVQVlq+x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27801EEA49
	for <bpf@vger.kernel.org>; Tue,  9 Sep 2025 01:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379635; cv=none; b=DLrfd2dl9He1S/zPYJxhCSW//TezJsVUg3wmIhK53U4MWYiL7anEJYXYDCwy3r/xvHQHQFbbVYyemR5BWK4vuNQ3lkL2pIq/2n8Nr5Fvj3za3VhjiqlW5X/B382fOFFRR2MWLEltI3sn9zTPIcHrybJBhNXf47Ky9OlCqqMmL9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379635; c=relaxed/simple;
	bh=Rt8Epf1fcSCFKGt/tJ7w+NXLjSBYIODsq120sRqSbk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WTqVKotsHkRBTMrkb4wxJ83FyRBplokQyKyWw73YdI22d20M8+vs4rblG0EZtmr+qNJfxkbBrE3K8d7QFudl91RgC/5IUDT0P5URZdJdfc1Qj+E3Y3Yvw+UEgSlf9OYr1t417O2AO05No3VxCSmylA7qKcAGeNE+CGvIpENhyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jVQVlq+x; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77238a3101fso3614553b3a.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 18:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757379631; x=1757984431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CNlk9amXWPvY0T0zqCSS4/OdXdPxLWZ1cQPer3MliSw=;
        b=jVQVlq+xYU3K4lc/zGWS5KV3oKIK3lu8cNkXFEQdovPty0QgKl/er3v03ehPOTEJr9
         qJtYp0u1uhNilcz4uu1s62gjLZvTRzXGDNCPFOsFKBs7Zwe9SsTBSVe1mNq+Wbd8soYF
         UKLZzc/tnCsvjrAJcagfoyyceGHSL+rNw/cPdBb8+S1I5TSXbV07kJR4RyTX8ZbLqZtH
         PumPwMxX2P0pQ32IiXn52Cw7Kl7oJZrlOfWetj8kd+TpUNoBAKcyrCJlVTyyDeD19+dH
         eOrXkM0VV8h4cIbi4gQ76VKZuEWao8v6I/yO0+yU2t0yVadmpfKMYZyt2kgSePEgd1DQ
         bpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757379631; x=1757984431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CNlk9amXWPvY0T0zqCSS4/OdXdPxLWZ1cQPer3MliSw=;
        b=lwTyXEJBPSH96MMb57DlSYf9GpMoa1oCh0GTvjDhPWHRomOImGr3xAfLCBR+ea2QAQ
         dfDBH6Me+Aq/+Doaw4hbmN0iEEAVvoC8lPQQ/Wx76iW4RioMMoiV6zv9a0M2YRm12zuz
         /SbetmlCMYAPYcn73DD7a1nGq2/qvqiw7rIfbcuTDgmjk0tE95lwcwlWw64jUegWlG8E
         N9rnvwPyrHnuO5okM/XsQDj6M6AqAR4m82pCa4FFm/lZNuNLaMn4H91QqGtj94Kj7uab
         jnktM2096QRkvxGE2nn4JyMZ4XK+TAkY8ubAKlG1y8UhvqB+P2gVniCLPp6NQvGTkWk+
         z1ZQ==
X-Gm-Message-State: AOJu0YySmHl69iytDauRk+6LPxdWDL2JMe1q1WBFjY8VlrmRZXX5CPhH
	lpqEwi2qGOitsKJGEYPte5gZF2ykW5C/oKDHN7sk3Mcu9bHgmbKSNgnyDusL/A==
X-Gm-Gg: ASbGncvvY9hxE9m2O2TUtmJ+czWoKzoM9bbmq/3mxHZKAFcNTmEXetMS+Sc74acJeMA
	iflWSi+3qUYB0hqEkFyZpZi02UHszE8V4qQzBGladQYVMmVHaANHkwftV3k++FT+6mz7gargKSe
	Vux3I2fyZc9J6s23+unZCOVSmDPKbIgDtXoJl9cpvHLyUCRD2DsuF+zQ4iV+lNTfgVYQEA6DHvj
	0Do+3eolcg9Bu/H0D3dwTElUiNmmNUNtPCl4xeMyIVw5mCWgy0dKr74LjW54IWDvs3PeIaEPy71
	5i2FNNLiuHucdCQR7W+1B/0GumUtBMbPuP3t675voz754XMqHryLilvNxr6M2nfvNAhhM47jTck
	4akfG3krJ5aYkxCPfMji8GDU3L/fTlsAmyRu4b650AuFndPAp5MlvJPnlBaTnwWW7mFoWXiHhsQ
	==
X-Google-Smtp-Source: AGHT+IEEo6BFX+luI5DIYlSwc3O8TMQUhFi6Dbh2PhT8cAot+i9YFYznGxHbEpSrsfNW9gGHbO2RJQ==
X-Received: by 2002:a05:6a00:2289:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-7742dc9ed6cmr9428899b3a.5.1757379625987;
        Mon, 08 Sep 2025 18:00:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:558:600a:7:44e6:767e:cc5a:a060])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662c9252sm198611b3a.83.2025.09.08.18.00.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 08 Sep 2025 18:00:25 -0700 (PDT)
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
Subject: [PATCH slab v5 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
Date: Mon,  8 Sep 2025 18:00:07 -0700
Message-Id: <20250909010007.1660-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

kmalloc_nolock() relies on ability of local_trylock_t to detect
the situation when per-cpu kmem_cache is locked.

In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
disables IRQs and marks s->cpu_slab->lock as acquired.
local_lock_is_locked(&s->cpu_slab->lock) returns true when
slab is in the middle of manipulating per-cpu cache
of that specific kmem_cache.

kmalloc_nolock() can be called from any context and can re-enter
into ___slab_alloc():
  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
    kmalloc_nolock() -> ___slab_alloc(cache_B)
or
  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -> bpf ->
    kmalloc_nolock() -> ___slab_alloc(cache_B)

Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
can be acquired without a deadlock before invoking the function.
If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
retries in a different kmalloc bucket. The second attempt will
likely succeed, since this cpu locked different kmem_cache.

Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
per-cpu rt_spin_lock is locked by current _task_. In this case
re-entrance into the same kmalloc bucket is unsafe, and
kmalloc_nolock() tries a different bucket that is most likely is
not locked by the current task. Though it may be locked by a
different task it's safe to rt_spin_lock() and sleep on it.

Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
immediately if called from hard irq or NMI in PREEMPT_RT.

kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
and (in_nmi() or in PREEMPT_RT).

SLUB_TINY config doesn't use local_lock_is_locked() and relies on
spin_trylock_irqsave(&n->list_lock) to allocate,
while kfree_nolock() always defers to irq_work.

Note, kfree_nolock() must be called _only_ for objects allocated
with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
were skipped on allocation, hence obj = kmalloc(); kfree_nolock(obj);
will miss kmemleak/kfence book keeping and will cause false positives.
large_kmalloc is not supported by either kmalloc_nolock()
or kfree_nolock().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/kasan.h      |  13 +-
 include/linux/memcontrol.h |   2 +
 include/linux/slab.h       |   4 +
 mm/Kconfig                 |   1 +
 mm/kasan/common.c          |   5 +-
 mm/slab.h                  |   6 +
 mm/slab_common.c           |   3 +
 mm/slub.c                  | 473 +++++++++++++++++++++++++++++++++----
 8 files changed, 453 insertions(+), 54 deletions(-)

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
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d254c0b96d0d..82563236f35c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -358,6 +358,8 @@ enum objext_flags {
 	 * MEMCG_DATA_OBJEXTS.
 	 */
 	OBJEXTS_ALLOC_FAIL = __OBJEXTS_ALLOC_FAIL,
+	/* slabobj_ext vector allocated with kmalloc_nolock() */
+	OBJEXTS_NOSPIN_ALLOC = __FIRST_OBJEXT_FLAG,
 	/* the next bit after the last actual flag */
 	__NR_OBJEXTS_FLAGS  = (__FIRST_OBJEXT_FLAG << 1),
 };
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 680193356ac7..561597dd2164 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -501,6 +501,7 @@ void * __must_check krealloc_noprof(const void *objp, size_t new_size,
 #define krealloc(...)				alloc_hooks(krealloc_noprof(__VA_ARGS__))
 
 void kfree(const void *objp);
+void kfree_nolock(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
@@ -957,6 +958,9 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 }
 #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
+void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node);
+#define kmalloc_nolock(...)			alloc_hooks(kmalloc_nolock_noprof(__VA_ARGS__))
+
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
 
diff --git a/mm/Kconfig b/mm/Kconfig
index e443fe8cd6cf..202e044f2b4d 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -194,6 +194,7 @@ menu "Slab allocator options"
 
 config SLUB
 	def_bool y
+	select IRQ_WORK
 
 config KVFREE_RCU_BATCHED
 	def_bool y
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 9142964ab9c9..3264900b942f 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -252,7 +252,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
 }
 
 bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
-		       bool still_accessible)
+		       bool still_accessible, bool no_quarantine)
 {
 	if (!kasan_arch_is_ready() || is_kfence_address(object))
 		return false;
@@ -274,6 +274,9 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
 
 	poison_slab_object(cache, object, init);
 
+	if (no_quarantine)
+		return false;
+
 	/*
 	 * If the object is put into quarantine, do not let slab put the object
 	 * onto the freelist for now. The object's metadata is kept until the
diff --git a/mm/slab.h b/mm/slab.h
index 5a6f824a282d..19bc15db6a72 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -57,6 +57,10 @@ struct slab {
 		struct {
 			union {
 				struct list_head slab_list;
+				struct { /* For deferred deactivate_slab() */
+					struct llist_node llnode;
+					void *flush_freelist;
+				};
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 				struct {
 					struct slab *next;
@@ -661,6 +665,8 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 void __check_heap_object(const void *ptr, unsigned long n,
 			 const struct slab *slab, bool to_user);
 
+void defer_free_barrier(void);
+
 static inline bool slub_debug_orig_size(struct kmem_cache *s)
 {
 	return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 08f5baee1309..77eefe660027 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -510,6 +510,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
 		rcu_barrier();
 	}
 
+	/* Wait for deferred work from kmalloc/kfree_nolock() */
+	defer_free_barrier();
+
 	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
diff --git a/mm/slub.c b/mm/slub.c
index 61841ba72120..9fdf74955227 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -44,6 +44,7 @@
 #include <kunit/test.h>
 #include <kunit/test-bug.h>
 #include <linux/sort.h>
+#include <linux/irq_work.h>
 
 #include <linux/debugfs.h>
 #include <trace/events/kmem.h>
@@ -426,7 +427,7 @@ struct kmem_cache_cpu {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct slab *partial;	/* Partially allocated slabs */
 #endif
-	local_lock_t lock;	/* Protects the fields above */
+	local_trylock_t lock;	/* Protects the fields above */
 #ifdef CONFIG_SLUB_STATS
 	unsigned int stat[NR_SLUB_STAT_ITEMS];
 #endif
@@ -2084,6 +2085,7 @@ static inline void init_slab_obj_exts(struct slab *slab)
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		        gfp_t gfp, bool new_slab)
 {
+	bool allow_spin = gfpflags_allow_spinning(gfp);
 	unsigned int objects = objs_per_slab(s, slab);
 	unsigned long new_exts;
 	unsigned long old_exts;
@@ -2092,8 +2094,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
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
@@ -2103,6 +2111,8 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 	}
 
 	new_exts = (unsigned long)vec;
+	if (unlikely(!allow_spin))
+		new_exts |= OBJEXTS_NOSPIN_ALLOC;
 #ifdef CONFIG_MEMCG
 	new_exts |= MEMCG_DATA_OBJEXTS;
 #endif
@@ -2123,7 +2133,10 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
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
 
@@ -2147,7 +2160,10 @@ static inline void free_slab_obj_exts(struct slab *slab)
 	 * the extension for obj_exts is expected to be NULL.
 	 */
 	mark_objexts_empty(obj_exts);
-	kfree(obj_exts);
+	if (unlikely(READ_ONCE(slab->obj_exts) & OBJEXTS_NOSPIN_ALLOC))
+		kfree_nolock(obj_exts);
+	else
+		kfree(obj_exts);
 	slab->obj_exts = 0;
 }
 
@@ -2481,7 +2497,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
 
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
-	return !kasan_slab_free(s, x, init, still_accessible);
+	return !kasan_slab_free(s, x, init, still_accessible, false);
 }
 
 static __fastpath_inline
@@ -2986,13 +3002,17 @@ static void barn_shrink(struct kmem_cache *s, struct node_barn *barn)
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
+	if (unlikely(!allow_spin))
+		folio = (struct folio *)alloc_frozen_pages_nolock(0/* __GFP_COMP is implied */,
+								  node, order);
+	else if (node == NUMA_NO_NODE)
 		folio = (struct folio *)alloc_frozen_pages(flags, order);
 	else
 		folio = (struct folio *)__alloc_frozen_pages(flags, order, node, NULL);
@@ -3142,6 +3162,7 @@ static __always_inline void unaccount_slab(struct slab *slab, int order,
 
 static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
+	bool allow_spin = gfpflags_allow_spinning(flags);
 	struct slab *slab;
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
@@ -3161,7 +3182,11 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
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
@@ -3169,7 +3194,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Allocation may have failed due to fragmentation.
 		 * Try a lower order alloc if possible
 		 */
-		slab = alloc_slab_page(alloc_gfp, node, oo);
+		slab = alloc_slab_page(alloc_gfp, node, oo, allow_spin);
 		if (unlikely(!slab))
 			return NULL;
 		stat(s, ORDER_FALLBACK);
@@ -3338,33 +3363,47 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 	return object;
 }
 
+static void defer_deactivate_slab(struct slab *slab, void *flush_freelist);
+
 /*
  * Called only for kmem_cache_debug() caches to allocate from a freshly
  * allocated slab. Allocate a single object instead of whole freelist
  * and put the slab to the partial (or full) list.
  */
-static void *alloc_single_from_new_slab(struct kmem_cache *s,
-					struct slab *slab, int orig_size)
+static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
+					int orig_size, gfp_t gfpflags)
 {
+	bool allow_spin = gfpflags_allow_spinning(gfpflags);
 	int nid = slab_nid(slab);
 	struct kmem_cache_node *n = get_node(s, nid);
 	unsigned long flags;
 	void *object;
 
+	if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags)) {
+		/* Unlucky, discard newly allocated slab */
+		slab->frozen = 1;
+		defer_deactivate_slab(slab, NULL);
+		return NULL;
+	}
 
 	object = slab->freelist;
 	slab->freelist = get_freepointer(s, object);
 	slab->inuse = 1;
 
-	if (!alloc_debug_processing(s, slab, object, orig_size))
+	if (!alloc_debug_processing(s, slab, object, orig_size)) {
 		/*
 		 * It's not really expected that this would fail on a
 		 * freshly allocated slab, but a concurrent memory
 		 * corruption in theory could cause that.
+		 * Leak memory of allocated slab.
 		 */
+		if (!allow_spin)
+			spin_unlock_irqrestore(&n->list_lock, flags);
 		return NULL;
+	}
 
-	spin_lock_irqsave(&n->list_lock, flags);
+	if (allow_spin)
+		spin_lock_irqsave(&n->list_lock, flags);
 
 	if (slab->inuse == slab->objects)
 		add_full(s, n, slab);
@@ -3405,7 +3444,10 @@ static struct slab *get_partial_node(struct kmem_cache *s,
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
@@ -3611,7 +3653,7 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 		lockdep_register_key(&s->lock_key);
 	for_each_possible_cpu(cpu) {
 		c = per_cpu_ptr(s->cpu_slab, cpu);
-		local_lock_init(&c->lock);
+		local_trylock_init(&c->lock);
 		if (finegrain_lockdep)
 			lockdep_set_class(&c->lock, &s->lock_key);
 		c->tid = init_tid(cpu);
@@ -3704,6 +3746,44 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 	}
 }
 
+/*
+ * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
+ * can be acquired without a deadlock before invoking the function.
+ *
+ * Without LOCKDEP we trust the code to be correct. kmalloc_nolock() is
+ * using local_lock_is_locked() properly before calling local_lock_cpu_slab(),
+ * and kmalloc() is not used in an unsupported context.
+ *
+ * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_lock_irqsave().
+ * On !PREEMPT_RT we use trylock to avoid false positives in NMI, but
+ * lockdep_assert() will catch a bug in case:
+ * #1
+ * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_nolock()
+ * or
+ * #2
+ * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf -> kmalloc_nolock()
+ *
+ * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
+ * disabled context. The lock will always be acquired and if needed it
+ * block and sleep until the lock is available.
+ * #1 is possible in !PREEMPT_RT only.
+ * #2 is possible in both with a twist that irqsave is replaced with rt_spinlock:
+ * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
+ *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kmem_cache_B)
+ *
+ * local_lock_is_locked() prevents the case kmem_cache_A == kmem_cache_B
+ */
+#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
+#define local_lock_cpu_slab(s, flags)	\
+	local_lock_irqsave(&(s)->cpu_slab->lock, flags)
+#else
+#define local_lock_cpu_slab(s, flags)	\
+	lockdep_assert(local_trylock_irqsave(&(s)->cpu_slab->lock, flags))
+#endif
+
+#define local_unlock_cpu_slab(s, flags)	\
+	local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
+
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 static void __put_partials(struct kmem_cache *s, struct slab *partial_slab)
 {
@@ -3788,7 +3868,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 	unsigned long flags;
 	int slabs = 0;
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_cpu_slab(s, flags);
 
 	oldslab = this_cpu_read(s->cpu_slab->partial);
 
@@ -3813,7 +3893,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 
 	this_cpu_write(s->cpu_slab->partial, slab);
 
-	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+	local_unlock_cpu_slab(s, flags);
 
 	if (slab_to_put) {
 		__put_partials(s, slab_to_put);
@@ -4262,6 +4342,7 @@ static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
 {
+	bool allow_spin = gfpflags_allow_spinning(gfpflags);
 	void *freelist;
 	struct slab *slab;
 	unsigned long flags;
@@ -4287,9 +4368,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (unlikely(!node_match(slab, node))) {
 		/*
 		 * same as above but node_match() being false already
-		 * implies node != NUMA_NO_NODE
+		 * implies node != NUMA_NO_NODE.
+		 * Reentrant slub cannot take locks necessary to
+		 * deactivate_slab, hence ignore node preference.
+		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
 		 */
-		if (!node_isset(node, slab_nodes)) {
+		if (!node_isset(node, slab_nodes) ||
+		    !allow_spin) {
 			node = NUMA_NO_NODE;
 		} else {
 			stat(s, ALLOC_NODE_MISMATCH);
@@ -4302,13 +4387,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 * PFMEMALLOC but right now, we are losing the pfmemalloc
 	 * information when the page leaves the per-cpu allocator
 	 */
-	if (unlikely(!pfmemalloc_match(slab, gfpflags)))
+	if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin))
 		goto deactivate_slab;
 
 	/* must check again c->slab in case we got preempted and it changed */
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_cpu_slab(s, flags);
+
 	if (unlikely(slab != c->slab)) {
-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+		local_unlock_cpu_slab(s, flags);
 		goto reread_slab;
 	}
 	freelist = c->freelist;
@@ -4320,7 +4406,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (!freelist) {
 		c->slab = NULL;
 		c->tid = next_tid(c->tid);
-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+		local_unlock_cpu_slab(s, flags);
 		stat(s, DEACTIVATE_BYPASS);
 		goto new_slab;
 	}
@@ -4339,34 +4425,34 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	VM_BUG_ON(!c->slab->frozen);
 	c->freelist = get_freepointer(s, freelist);
 	c->tid = next_tid(c->tid);
-	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+	local_unlock_cpu_slab(s, flags);
 	return freelist;
 
 deactivate_slab:
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_cpu_slab(s, flags);
 	if (slab != c->slab) {
-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+		local_unlock_cpu_slab(s, flags);
 		goto reread_slab;
 	}
 	freelist = c->freelist;
 	c->slab = NULL;
 	c->freelist = NULL;
 	c->tid = next_tid(c->tid);
-	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+	local_unlock_cpu_slab(s, flags);
 	deactivate_slab(s, slab, freelist);
 
 new_slab:
 
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	while (slub_percpu_partial(c)) {
-		local_lock_irqsave(&s->cpu_slab->lock, flags);
+		local_lock_cpu_slab(s, flags);
 		if (unlikely(c->slab)) {
-			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+			local_unlock_cpu_slab(s, flags);
 			goto reread_slab;
 		}
 		if (unlikely(!slub_percpu_partial(c))) {
-			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+			local_unlock_cpu_slab(s, flags);
 			/* we were preempted and partial list got empty */
 			goto new_objects;
 		}
@@ -4374,8 +4460,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		slab = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, slab);
 
+		/*
+		 * Reentrant slub cannot take locks necessary for
+		 * __put_partials(), hence ignore node preference.
+		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
+		 */
 		if (likely(node_match(slab, node) &&
-			   pfmemalloc_match(slab, gfpflags))) {
+			   pfmemalloc_match(slab, gfpflags)) ||
+		    !allow_spin) {
 			c->slab = slab;
 			freelist = get_freelist(s, slab);
 			VM_BUG_ON(!freelist);
@@ -4383,7 +4475,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto load_freelist;
 		}
 
-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+		local_unlock_cpu_slab(s, flags);
 
 		slab->next = NULL;
 		__put_partials(s, slab);
@@ -4405,8 +4497,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -4445,7 +4542,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	stat(s, ALLOC_SLAB);
 
 	if (kmem_cache_debug(s)) {
-		freelist = alloc_single_from_new_slab(s, slab, orig_size);
+		freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
 
 		if (unlikely(!freelist))
 			goto new_objects;
@@ -4467,7 +4564,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	inc_slabs_node(s, slab_nid(slab), slab->objects);
 
-	if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
+	if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
 		/*
 		 * For !pfmemalloc_match() case we don't load freelist so that
 		 * we don't make further mismatched allocations easier.
@@ -4478,7 +4575,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 retry_load_slab:
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_cpu_slab(s, flags);
 	if (unlikely(c->slab)) {
 		void *flush_freelist = c->freelist;
 		struct slab *flush_slab = c->slab;
@@ -4487,9 +4584,14 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		c->freelist = NULL;
 		c->tid = next_tid(c->tid);
 
-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+		local_unlock_cpu_slab(s, flags);
 
-		deactivate_slab(s, flush_slab, flush_freelist);
+		if (unlikely(!allow_spin)) {
+			/* Reentrant slub cannot take locks, defer */
+			defer_deactivate_slab(flush_slab, flush_freelist);
+		} else {
+			deactivate_slab(s, flush_slab, flush_freelist);
+		}
 
 		stat(s, CPUSLAB_FLUSH);
 
@@ -4518,8 +4620,19 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 */
 	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
-
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
+	}
 	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
+out:
 #ifdef CONFIG_PREEMPT_COUNT
 	slub_put_cpu_ptr(s->cpu_slab);
 #endif
@@ -4643,7 +4756,7 @@ static void *__slab_alloc_node(struct kmem_cache *s,
 		return NULL;
 	}
 
-	object = alloc_single_from_new_slab(s, slab, orig_size);
+	object = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
 
 	return object;
 }
@@ -4722,8 +4835,9 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
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
@@ -5390,6 +5504,94 @@ void *__kmalloc_noprof(size_t size, gfp_t flags)
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
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
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
@@ -6039,6 +6241,93 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	}
 }
 
+struct defer_free {
+	struct llist_head objects;
+	struct llist_head slabs;
+	struct irq_work work;
+};
+
+static void free_deferred_objects(struct irq_work *work);
+
+static DEFINE_PER_CPU(struct defer_free, defer_free_objects) = {
+	.objects = LLIST_HEAD_INIT(objects),
+	.slabs = LLIST_HEAD_INIT(slabs),
+	.work = IRQ_WORK_INIT(free_deferred_objects),
+};
+
+/*
+ * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
+ * to take sleeping spin_locks from __slab_free() and deactivate_slab().
+ * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
+ */
+static void free_deferred_objects(struct irq_work *work)
+{
+	struct defer_free *df = container_of(work, struct defer_free, work);
+	struct llist_head *objs = &df->objects;
+	struct llist_head *slabs = &df->slabs;
+	struct llist_node *llnode, *pos, *t;
+
+	if (llist_empty(objs) && llist_empty(slabs))
+		return;
+
+	llnode = llist_del_all(objs);
+	llist_for_each_safe(pos, t, llnode) {
+		struct kmem_cache *s;
+		struct slab *slab;
+		void *x = pos;
+
+		slab = virt_to_slab(x);
+		s = slab->slab_cache;
+
+		/*
+		 * We used freepointer in 'x' to link 'x' into df->objects.
+		 * Clear it to NULL to avoid false positive detection
+		 * of "Freepointer corruption".
+		 */
+		*(void **)x = NULL;
+
+		/* Point 'x' back to the beginning of allocated object */
+		x -= s->offset;
+		__slab_free(s, slab, x, x, 1, _THIS_IP_);
+	}
+
+	llnode = llist_del_all(slabs);
+	llist_for_each_safe(pos, t, llnode) {
+		struct slab *slab = container_of(pos, struct slab, llnode);
+
+#ifdef CONFIG_SLUB_TINY
+		discard_slab(slab->slab_cache, slab);
+#else
+		deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
+#endif
+	}
+}
+
+static void defer_free(struct kmem_cache *s, void *head)
+{
+	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
+
+	if (llist_add(head + s->offset, &df->objects))
+		irq_work_queue(&df->work);
+}
+
+static void defer_deactivate_slab(struct slab *slab, void *flush_freelist)
+{
+	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
+
+	slab->flush_freelist = flush_freelist;
+	if (llist_add(&slab->llnode, &df->slabs))
+		irq_work_queue(&df->work);
+}
+
+void defer_free_barrier(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
+}
+
 #ifndef CONFIG_SLUB_TINY
 /*
  * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
@@ -6059,6 +6348,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 				struct slab *slab, void *head, void *tail,
 				int cnt, unsigned long addr)
 {
+	/* cnt == 0 signals that it's called from kfree_nolock() */
+	bool allow_spin = cnt;
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
 	void **freelist;
@@ -6077,10 +6368,29 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	barrier();
 
 	if (unlikely(slab != c->slab)) {
-		__slab_free(s, slab, head, tail, cnt, addr);
+		if (unlikely(!allow_spin)) {
+			/*
+			 * __slab_free() can locklessly cmpxchg16 into a slab,
+			 * but then it might need to take spin_lock or local_lock
+			 * in put_cpu_partial() for further processing.
+			 * Avoid the complexity and simply add to a deferred list.
+			 */
+			defer_free(s, head);
+		} else {
+			__slab_free(s, slab, head, tail, cnt, addr);
+		}
 		return;
 	}
 
+	if (unlikely(!allow_spin)) {
+		if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
+		    local_lock_is_locked(&s->cpu_slab->lock)) {
+			defer_free(s, head);
+			return;
+		}
+		cnt = 1; /* restore cnt. kfree_nolock() frees one object at a time */
+	}
+
 	if (USE_LOCKLESS_FAST_PATH()) {
 		freelist = READ_ONCE(c->freelist);
 
@@ -6091,11 +6401,13 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 			goto redo;
 		}
 	} else {
+		__maybe_unused unsigned long flags = 0;
+
 		/* Update the free list under the local lock */
-		local_lock(&s->cpu_slab->lock);
+		local_lock_cpu_slab(s, flags);
 		c = this_cpu_ptr(s->cpu_slab);
 		if (unlikely(slab != c->slab)) {
-			local_unlock(&s->cpu_slab->lock);
+			local_unlock_cpu_slab(s, flags);
 			goto redo;
 		}
 		tid = c->tid;
@@ -6105,7 +6417,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 		c->freelist = head;
 		c->tid = next_tid(tid);
 
-		local_unlock(&s->cpu_slab->lock);
+		local_unlock_cpu_slab(s, flags);
 	}
 	stat_add(s, FREE_FASTPATH, cnt);
 }
@@ -6337,6 +6649,71 @@ void kfree(const void *object)
 }
 EXPORT_SYMBOL(kfree);
 
+/*
+ * Can be called while holding raw_spinlock_t or from IRQ and NMI,
+ * but ONLY for objects allocated by kmalloc_nolock().
+ * Debug checks (like kmemleak and kfence) were skipped on allocation,
+ * hence
+ * obj = kmalloc(); kfree_nolock(obj);
+ * will miss kmemleak/kfence book keeping and will cause false positives.
+ * large_kmalloc is not supported either.
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
+		WARN_ONCE(1, "large_kmalloc is not supported by kfree_nolock()");
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
+	 * since they take spinlocks or not safe from any context.
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
+	/*
+	 * memcg, kasan_slab_pre_free are done for 'x'.
+	 * The only thing left is kasan_poison without quarantine,
+	 * since kasan quarantine takes locks and not supported from NMI.
+	 */
+	kasan_slab_free(s, x, false, false, /* skip quarantine */true);
+#ifndef CONFIG_SLUB_TINY
+	do_slab_free(s, slab, x, x, 0, _RET_IP_);
+#else
+	defer_free(s, x);
+#endif
+}
+EXPORT_SYMBOL_GPL(kfree_nolock);
+
 static __always_inline __realloc_size(2) void *
 __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 {
-- 
2.47.3


