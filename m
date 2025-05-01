Return-Path: <bpf+bounces-57112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38608AA59F8
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 05:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A5A81C02525
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 03:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF87922D7B7;
	Thu,  1 May 2025 03:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvoDrtQc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227851E51F5
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746070075; cv=none; b=ianpX5+C+s1AGpEdF+H0I5dtSl6WiGiIW+Esvc1pi8AV34gq3uslUKih8hvI82TOzeym0sxOKRijksbMsAr/TudOgboHp6cdzLxFFNwm8T7a8IDyh/IytsnhFkZrHxLvZqaH5IUm2/xdH6hRw/s40f8a1CjRdsIXN4kvT0g8TQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746070075; c=relaxed/simple;
	bh=ndR71eVY7ox3yeLUaM6G61HWamK93yq4ADbJK8V/Ytc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E34OMPjGfYiEiSldF7k6mA+pI90mPfYRp4Lg32kQIvzb1l80hzmDepTjbw6K3u3jU4MIXB0MACCZB4GZTRd01jTjew2cBpnQfX9tSM041JTCORaa5JdA/h2gyWPSrrOliYEVQ1u6P2Nqud/XFIKso9hm6DYDlLwr9VggSFNaqK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvoDrtQc; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so525469b3a.1
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 20:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746070072; x=1746674872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvf7ccrWUKax9eDCUL/ontbr6XRY/PsNLGGELX+vxA4=;
        b=JvoDrtQct3fHZ3/HnnUSyLeXCcumjURP0T+QgSXHpl+xL9Bes43xQN/eFhmfmHlB7p
         /MMStKbAwD9L6VNZXLBIxWHNFx/ULlXmLF9+BO+KVgWGjsYJa+K9UkcG4Tz71OUpB5FT
         tC5z5r4P8tPEJSI0XBCS2z5NPWJQBzZrb/RMFCPiHsqE0mr+ScseQCM6i4K2rkKyn1Ba
         qZUk9ASPZTb3A1ycQEScGwcq0ZTBOPXfS1a5NRfJfzONC1hwxa1/bjqL/e9Y7NBxbp5W
         Q9e/4/pgMGr6yx1DI4tGq+SwtDx0V5Gq3WtibCNXKoNWR0dB/Z3dhnc7CzBHze7Vq4d8
         9zCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746070072; x=1746674872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvf7ccrWUKax9eDCUL/ontbr6XRY/PsNLGGELX+vxA4=;
        b=ddk1htHNbsGt3ZI2C0A3OnvGgcSNUTKygvBN6kzYgDUq8qjQf+4OKjpAiTttPgYWV2
         TnbCM6PvU2+22IRKqPRhlOPf1zgiy1DpP+NRZKVkwwXndchFVPuT35kuzq9EzgGoK25a
         w+ByBRUB6VeiGlYJ0i8w7CxcSt8prLnIbcD3fGmSSkG5Pe4tObm6HNKspRZ+wNkJGjr/
         Dn8dpAYpN+4c3n0Zbo8IFEXYB4Afkd4eOrX4jaKv5MV2ck6cQJdM1fsjcyuYpsSK8nZX
         Lx+uCPv8eGVgapelhS/ScbQWk3WoJdOxpTuEM1EWG+WQy/mEMjnfk1+FAZBiiLXKgCqw
         w2dw==
X-Gm-Message-State: AOJu0YwU/exw6otQ+Mada6esOeiZ2r57LJcup3yCtbHMr6ZekjWbrrqr
	Od90bwwaUiNaxgdyVmdDq6doYKqmaV3cZXGDnkoU1hesvtX/QtdWxMB7iw==
X-Gm-Gg: ASbGncu2lmLPY6mda9JytslCqr6XFHLN8XE3h2q+DeKR3nB5RGni3LAz09+VxYSCXmx
	shD6tsRKUeeD1ClToBwzbj3MferaiOGIJiTGlGtMtY9f/ha5cZoTPHJlDNWRv0F9D6henlnlwd7
	6r6uTLrXohLDuMnfWDmjwQ0VNiNd3BCyzyKxqu94iilptSdfY7679F0OKvBfre/d5bKd+1GuV4e
	PBvz0XLOE9+uSj+A8XzEiPcu/z7fi84DHNbOFQ93BjIP1uSwlPujTbm+FhFzTLQKLT8zow8I+Sp
	stxQclJo+nGFbjv1x18sM5UlMvi8dWFxqXzKbGnFdEUKa+d+c0Szl7UydTRHrdVxIUgO
X-Google-Smtp-Source: AGHT+IF60cWlvCZGJQCZ241jSv/j03VshEG13SyIy4Ko8oMyhWZiZbzdgUUySdWZVW77exNFOblGDw==
X-Received: by 2002:a05:6a20:9f0b:b0:1f5:93b1:6a58 with SMTP id adf61e73a8af0-20bd6556e0bmr1233492637.8.1746070071463;
        Wed, 30 Apr 2025 20:27:51 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:13f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7403991fccdsm2599384b3a.50.2025.04.30.20.27.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Apr 2025 20:27:51 -0700 (PDT)
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
	hannes@cmpxchg.org,
	willy@infradead.org
Subject: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
Date: Wed, 30 Apr 2025 20:27:18 -0700
Message-Id: <20250501032718.65476-7-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
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
When lock_local_is_locked() sees locked memcg_stock.stock_lock
fallback to atomic operations.

Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
per-cpu rt_spin_lock is locked by current task. In this case re-entrance
into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
a different bucket that is most likely is not locked by current
task. Though it may be locked by a different task it's safe to
rt_spin_lock() on it.

Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
immediately if called from hard irq or NMI in PREEMPT_RT.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/kasan.h |  13 +-
 include/linux/slab.h  |   4 +
 mm/kasan/common.c     |   5 +-
 mm/memcontrol.c       |  60 ++++++++-
 mm/slab.h             |   1 +
 mm/slub.c             | 280 ++++++++++++++++++++++++++++++++++++++----
 6 files changed, 330 insertions(+), 33 deletions(-)

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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b877287aeb11..1fe23b2fe03d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -595,7 +595,13 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	if (!val)
 		return;
 
-	cgroup_rstat_updated(memcg->css.cgroup, cpu);
+	/*
+	 * If called from NMI via kmalloc_nolock -> memcg_slab_post_alloc_hook
+	 * -> obj_cgroup_charge -> mod_memcg_state,
+	 * then delay the update.
+	 */
+	if (!in_nmi())
+		cgroup_rstat_updated(memcg->css.cgroup, cpu);
 	statc = this_cpu_ptr(memcg->vmstats_percpu);
 	for (; statc; statc = statc->parent) {
 		/*
@@ -2895,7 +2901,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave_check(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2995,7 +3001,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave_check(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -3088,6 +3094,27 @@ static inline size_t obj_full_size(struct kmem_cache *s)
 	return s->size + sizeof(struct obj_cgroup *);
 }
 
+/*
+ * Try subtract from nr_charged_bytes without making it negative
+ */
+static bool obj_cgroup_charge_atomic(struct obj_cgroup *objcg, gfp_t flags, size_t sz)
+{
+	size_t old = atomic_read(&objcg->nr_charged_bytes);
+	u32 nr_pages = sz >> PAGE_SHIFT;
+	u32 nr_bytes = sz & (PAGE_SIZE - 1);
+
+	if ((ssize_t)(old - sz) >= 0 &&
+	    atomic_cmpxchg(&objcg->nr_charged_bytes, old, old - sz) == old)
+		return true;
+
+	nr_pages++;
+	if (obj_cgroup_charge_pages(objcg, flags, nr_pages))
+		return false;
+
+	atomic_add(PAGE_SIZE - nr_bytes, &objcg->nr_charged_bytes);
+	return true;
+}
+
 bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 				  gfp_t flags, size_t size, void **p)
 {
@@ -3128,6 +3155,21 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 			return false;
 	}
 
+	if (!gfpflags_allow_spinning(flags)) {
+		if (local_lock_is_locked(&memcg_stock.stock_lock)) {
+			/*
+			 * Cannot use
+			 * lockdep_assert_held(this_cpu_ptr(&memcg_stock.stock_lock));
+			 * since lockdep might not have been informed yet
+			 * of lock acquisition.
+			 */
+			return obj_cgroup_charge_atomic(objcg, flags,
+							size * obj_full_size(s));
+		} else {
+			lockdep_assert_not_held(this_cpu_ptr(&memcg_stock.stock_lock));
+		}
+	}
+
 	for (i = 0; i < size; i++) {
 		slab = virt_to_slab(p[i]);
 
@@ -3162,8 +3204,12 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			    void **p, int objects, struct slabobj_ext *obj_exts)
 {
+	bool lock_held = local_lock_is_locked(&memcg_stock.stock_lock);
 	size_t obj_size = obj_full_size(s);
 
+	if (likely(!lock_held))
+		lockdep_assert_not_held(this_cpu_ptr(&memcg_stock.stock_lock));
+
 	for (int i = 0; i < objects; i++) {
 		struct obj_cgroup *objcg;
 		unsigned int off;
@@ -3174,8 +3220,12 @@ void __memcg_slab_free_hook(struct kmem_cache *s, struct slab *slab,
 			continue;
 
 		obj_exts[off].objcg = NULL;
-		refill_obj_stock(objcg, obj_size, true, -obj_size,
-				 slab_pgdat(slab), cache_vmstat_idx(s));
+		if (unlikely(lock_held)) {
+			atomic_add(obj_size, &objcg->nr_charged_bytes);
+		} else {
+			refill_obj_stock(objcg, obj_size, true, -obj_size,
+					 slab_pgdat(slab), cache_vmstat_idx(s));
+		}
 		obj_cgroup_put(objcg);
 	}
 }
diff --git a/mm/slab.h b/mm/slab.h
index 05a21dc796e0..1688749d2995 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -273,6 +273,7 @@ struct kmem_cache {
 	unsigned int cpu_partial_slabs;
 #endif
 	struct kmem_cache_order_objects oo;
+	struct llist_head defer_free_objects;
 
 	/* Allocation and freeing of slabs */
 	struct kmem_cache_order_objects min;
diff --git a/mm/slub.c b/mm/slub.c
index dc9e729e1d26..307ea0135b92 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -392,7 +392,7 @@ struct kmem_cache_cpu {
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	struct slab *partial;	/* Partially allocated slabs */
 #endif
-	local_lock_t lock;	/* Protects the fields above */
+	local_trylock_t lock;	/* Protects the fields above */
 #ifdef CONFIG_SLUB_STATS
 	unsigned int stat[NR_SLUB_STAT_ITEMS];
 #endif
@@ -1981,6 +1981,7 @@ static inline void init_slab_obj_exts(struct slab *slab)
 int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
 		        gfp_t gfp, bool new_slab)
 {
+	bool allow_spin = gfpflags_allow_spinning(gfp);
 	unsigned int objects = objs_per_slab(s, slab);
 	unsigned long new_exts;
 	unsigned long old_exts;
@@ -1989,8 +1990,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
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
@@ -2020,7 +2027,10 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
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
 
@@ -2395,7 +2405,7 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init,
 
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
-	return !kasan_slab_free(s, x, init, still_accessible);
+	return !kasan_slab_free(s, x, init, still_accessible, false);
 }
 
 static __fastpath_inline
@@ -2458,13 +2468,21 @@ static void *setup_object(struct kmem_cache *s, void *object)
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
+		struct page *p = alloc_pages_nolock(__GFP_COMP, node, order);
+
+		if (p)
+			/* Make the page frozen. Drop refcnt to zero. */
+			put_page_testzero(p);
+		folio = (struct folio *)p;
+	} else if (node == NUMA_NO_NODE)
 		folio = (struct folio *)alloc_frozen_pages(flags, order);
 	else
 		folio = (struct folio *)__alloc_frozen_pages(flags, order, node, NULL);
@@ -2610,6 +2628,7 @@ static __always_inline void unaccount_slab(struct slab *slab, int order,
 
 static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
+	bool allow_spin = gfpflags_allow_spinning(flags);
 	struct slab *slab;
 	struct kmem_cache_order_objects oo = s->oo;
 	gfp_t alloc_gfp;
@@ -2629,7 +2648,11 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
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
@@ -2637,7 +2660,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 		 * Allocation may have failed due to fragmentation.
 		 * Try a lower order alloc if possible
 		 */
-		slab = alloc_slab_page(alloc_gfp, node, oo);
+		slab = alloc_slab_page(alloc_gfp, node, oo, allow_spin);
 		if (unlikely(!slab))
 			return NULL;
 		stat(s, ORDER_FALLBACK);
@@ -2877,7 +2900,10 @@ static struct slab *get_partial_node(struct kmem_cache *s,
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
@@ -3068,7 +3094,7 @@ static void init_kmem_cache_cpus(struct kmem_cache *s)
 
 	for_each_possible_cpu(cpu) {
 		c = per_cpu_ptr(s->cpu_slab, cpu);
-		local_lock_init(&c->lock);
+		local_trylock_init(&c->lock);
 		c->tid = init_tid(cpu);
 	}
 }
@@ -3243,7 +3269,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 	unsigned long flags;
 	int slabs = 0;
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_irqsave_check(&s->cpu_slab->lock, flags);
 
 	oldslab = this_cpu_read(s->cpu_slab->partial);
 
@@ -3746,7 +3772,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto deactivate_slab;
 
 	/* must check again c->slab in case we got preempted and it changed */
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_irqsave_check(&s->cpu_slab->lock, flags);
 	if (unlikely(slab != c->slab)) {
 		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		goto reread_slab;
@@ -3784,7 +3810,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 deactivate_slab:
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_irqsave_check(&s->cpu_slab->lock, flags);
 	if (slab != c->slab) {
 		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		goto reread_slab;
@@ -3800,7 +3826,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 	while (slub_percpu_partial(c)) {
-		local_lock_irqsave(&s->cpu_slab->lock, flags);
+		local_lock_irqsave_check(&s->cpu_slab->lock, flags);
 		if (unlikely(c->slab)) {
 			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 			goto reread_slab;
@@ -3845,8 +3871,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 *    allocating new page from other nodes
 	 */
 	if (unlikely(node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE)
-		     && try_thisnode))
-		pc.flags = GFP_NOWAIT | __GFP_THISNODE;
+		     && try_thisnode)) {
+		if (unlikely(!gfpflags_allow_spinning(gfpflags)))
+			/* Do not upgrade gfp to NOWAIT from more restrictive mode */
+			pc.flags = gfpflags | __GFP_THISNODE;
+		else
+			pc.flags = GFP_NOWAIT | __GFP_THISNODE;
+	}
 
 	pc.orig_size = orig_size;
 	slab = get_partial(s, node, &pc);
@@ -3918,7 +3949,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 retry_load_slab:
 
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
+	local_lock_irqsave_check(&s->cpu_slab->lock, flags);
 	if (unlikely(c->slab)) {
 		void *flush_freelist = c->freelist;
 		struct slab *flush_slab = c->slab;
@@ -3958,8 +3989,28 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	 */
 	c = slub_get_cpu_ptr(s->cpu_slab);
 #endif
+	if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
+		struct slab *slab;
+
+		slab = c->slab;
+		if (slab && !node_match(slab, node))
+			/* In trylock mode numa node is a hint */
+			node = NUMA_NO_NODE;
+
+		if (!local_lock_is_locked(&s->cpu_slab->lock)) {
+			lockdep_assert_not_held(this_cpu_ptr(&s->cpu_slab->lock));
+		} else {
+			/*
+			 * EBUSY is an internal signal to kmalloc_nolock() to
+			 * retry a different bucket. It's not propagated further.
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
@@ -4162,8 +4213,9 @@ bool slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
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
@@ -4354,6 +4406,88 @@ void *__kmalloc_noprof(size_t size, gfp_t flags)
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
+	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
+		return NULL;
+	if (unlikely(!size))
+		return ZERO_SIZE_PTR;
+
+	if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))
+		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
+		return NULL;
+retry:
+	s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
+
+	if (!(s->flags & __CMPXCHG_DOUBLE))
+		/*
+		 * kmalloc_nolock() is not supported on architectures that
+		 * don't implement cmpxchg16b.
+		 */
+		return NULL;
+
+	/*
+	 * Do not call slab_alloc_node(), since trylock mode isn't
+	 * compatible with slab_pre_alloc_hook/should_failslab and
+	 * kfence_alloc.
+	 *
+	 * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
+	 * in irq saved region. It assumes that the same cpu will not
+	 * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
+	 * Therefore use in_nmi() to check whether particular bucket is in
+	 * irq protected section.
+	 */
+	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
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
+	/*
+	 * Make sure memcg_stock.stock_lock doesn't change cpu
+	 * when memcg layers access it.
+	 */
+	slub_get_cpu_ptr(s->cpu_slab);
+	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
+			     slab_want_init_on_alloc(alloc_gfp, s), size);
+	slub_put_cpu_ptr(s->cpu_slab);
+
+	ret = kasan_kmalloc(s, ret, size, alloc_gfp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kmalloc_nolock_noprof);
+
 void *__kmalloc_node_track_caller_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags,
 					 int node, unsigned long caller)
 {
@@ -4511,7 +4645,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		"__slab_free"));
 
 	if (likely(!n)) {
-
 		if (likely(was_frozen)) {
 			/*
 			 * The list lock was not taken therefore no list
@@ -4568,6 +4701,30 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 }
 
 #ifndef CONFIG_SLUB_TINY
+static void free_deferred_objects(struct llist_head *llhead, unsigned long addr)
+{
+	struct llist_node *llnode, *pos, *t;
+
+	if (likely(llist_empty(llhead)))
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
+		__slab_free(s, slab, x, x, 1, addr);
+	}
+}
 /*
  * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
  * can perform fastpath freeing without additional function calls.
@@ -4605,10 +4762,36 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	barrier();
 
 	if (unlikely(slab != c->slab)) {
-		__slab_free(s, slab, head, tail, cnt, addr);
+		/* cnt == 0 signals that it's called from kfree_nolock() */
+		if (unlikely(!cnt)) {
+			/*
+			 * Use llist in cache_node ?
+			 * struct kmem_cache_node *n = get_node(s, slab_nid(slab));
+			 */
+			/*
+			 * __slab_free() can locklessly cmpxchg16 into a slab,
+			 * but then it might need to take spin_lock or local_lock
+			 * in put_cpu_partial() for further processing.
+			 * Avoid the complexity and simply add to a deferred list.
+			 */
+			llist_add(head, &s->defer_free_objects);
+		} else {
+			free_deferred_objects(&s->defer_free_objects, addr);
+			__slab_free(s, slab, head, tail, cnt, addr);
+		}
 		return;
 	}
 
+	if (unlikely(!cnt)) {
+		if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
+		    local_lock_is_locked(&s->cpu_slab->lock)) {
+			llist_add(head, &s->defer_free_objects);
+			return;
+		}
+		cnt = 1;
+		kasan_slab_free(s, head, false, false, true);
+	}
+
 	if (USE_LOCKLESS_FAST_PATH()) {
 		freelist = READ_ONCE(c->freelist);
 
@@ -4856,6 +5039,58 @@ void kfree(const void *object)
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
+	do_slab_free(s, slab, x, x, 0, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(kfree_nolock);
+
 static __always_inline __realloc_size(2) void *
 __do_krealloc(const void *p, size_t new_size, gfp_t flags)
 {
@@ -6423,6 +6658,7 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 	s->useroffset = args->useroffset;
 	s->usersize = args->usersize;
 #endif
+	init_llist_head(&s->defer_free_objects);
 
 	if (!calculate_sizes(args, s))
 		goto out;
-- 
2.47.1


