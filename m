Return-Path: <bpf+bounces-71911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7E9C01B05
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2BAF3BBB9B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 14:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2BA31A7FE;
	Thu, 23 Oct 2025 13:53:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB557320A32
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227592; cv=none; b=mtr5WrqUPvshvqbcNSXIc4/yfhBN2zxL5xqz3IYlG7Kwalzc1iKycbPG9aQ2c1gba5Lt8btZ7e5nZCYTk2dHBxhuYJtBZIJdTR9sbhufSMlui6RhHgfv6i+k2xeusGAtyltiCq9jaUrNABHy6NxZiWDXqMdFNUAHtlUpgiTydxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227592; c=relaxed/simple;
	bh=vDYq67K+iD9SldjFCe1s28vyl/Br7rDOrV9TTPXIMnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CgVgFLSXAU4Hen4cu0yE5Z4OhX0lUXK7x8w6IHOc8++BAV24BptX6eP1zpDmmpCk9HnQp6flPjksTE/i6YqP7YELoZFcVrSDliaSaL2aI6UIaKxsQMZfHiK/rTxZgrSW6xsKmJtgVAoq3AsPhAL4nbc9n16DCtxKXc9moD0mBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99D1621233;
	Thu, 23 Oct 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18A3913B09;
	Thu, 23 Oct 2025 13:52:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iEq+BTYz+mjvQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Oct 2025 13:52:54 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Oct 2025 15:52:33 +0200
Subject: [PATCH RFC 11/19] slab: remove SLUB_CPU_PARTIAL
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
In-Reply-To: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
 Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 99D1621233
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

We have removed the partial slab usage from allocation paths. Now remove
the whole config option and associated code.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/Kconfig |  11 ---
 mm/slab.h  |  29 ------
 mm/slub.c  | 309 ++++---------------------------------------------------------
 3 files changed, 19 insertions(+), 330 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 0e26f4fc8717..c83085e34243 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -247,17 +247,6 @@ config SLUB_STATS
 	  out which slabs are relevant to a particular load.
 	  Try running: slabinfo -DA
 
-config SLUB_CPU_PARTIAL
-	default y
-	depends on SMP && !SLUB_TINY
-	bool "Enable per cpu partial caches"
-	help
-	  Per cpu partial caches accelerate objects allocation and freeing
-	  that is local to a processor at the price of more indeterminism
-	  in the latency of the free. On overflow these caches will be cleared
-	  which requires the taking of locks that may cause latency spikes.
-	  Typically one would choose no for a realtime system.
-
 config RANDOM_KMALLOC_CACHES
 	default n
 	depends on !SLUB_TINY
diff --git a/mm/slab.h b/mm/slab.h
index f7b8df56727d..a103da44ab9d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -61,12 +61,6 @@ struct slab {
 					struct llist_node llnode;
 					void *flush_freelist;
 				};
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-				struct {
-					struct slab *next;
-					int slabs;	/* Nr of slabs left */
-				};
-#endif
 			};
 			/* Double-word boundary */
 			union {
@@ -206,23 +200,6 @@ static inline size_t slab_size(const struct slab *slab)
 	return PAGE_SIZE << slab_order(slab);
 }
 
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-#define slub_percpu_partial(c)			((c)->partial)
-
-#define slub_set_percpu_partial(c, p)		\
-({						\
-	slub_percpu_partial(c) = (p)->next;	\
-})
-
-#define slub_percpu_partial_read_once(c)	READ_ONCE(slub_percpu_partial(c))
-#else
-#define slub_percpu_partial(c)			NULL
-
-#define slub_set_percpu_partial(c, p)
-
-#define slub_percpu_partial_read_once(c)	NULL
-#endif // CONFIG_SLUB_CPU_PARTIAL
-
 /*
  * Word size structure that can be atomically updated or read and that
  * contains both the order and the number of objects that a slab of the
@@ -246,12 +223,6 @@ struct kmem_cache {
 	unsigned int object_size;	/* Object size without metadata */
 	struct reciprocal_value reciprocal_size;
 	unsigned int offset;		/* Free pointer offset */
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	/* Number of per cpu partial objects to keep around */
-	unsigned int cpu_partial;
-	/* Number of per cpu partial slabs to keep around */
-	unsigned int cpu_partial_slabs;
-#endif
 	unsigned int sheaf_capacity;
 	struct kmem_cache_order_objects oo;
 
diff --git a/mm/slub.c b/mm/slub.c
index bd67336e7c1f..d8891d852a8f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -263,15 +263,6 @@ void *fixup_red_left(struct kmem_cache *s, void *p)
 	return p;
 }
 
-static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
-{
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	return !kmem_cache_debug(s);
-#else
-	return false;
-#endif
-}
-
 /*
  * Issues still to be resolved:
  *
@@ -425,9 +416,6 @@ struct kmem_cache_cpu {
 		freelist_aba_t freelist_tid;
 	};
 	struct slab *slab;	/* The slab from which we are allocating */
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	struct slab *partial;	/* Partially allocated slabs */
-#endif
 	local_trylock_t lock;	/* Protects the fields above */
 #ifdef CONFIG_SLUB_STATS
 	unsigned int stat[NR_SLUB_STAT_ITEMS];
@@ -660,29 +648,6 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
 	return x.x & OO_MASK;
 }
 
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
-{
-	unsigned int nr_slabs;
-
-	s->cpu_partial = nr_objects;
-
-	/*
-	 * We take the number of objects but actually limit the number of
-	 * slabs on the per cpu partial list, in order to limit excessive
-	 * growth of the list. For simplicity we assume that the slabs will
-	 * be half-full.
-	 */
-	nr_slabs = DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
-	s->cpu_partial_slabs = nr_slabs;
-}
-#elif defined(SLAB_SUPPORTS_SYSFS)
-static inline void
-slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
-{
-}
-#endif /* CONFIG_SLUB_CPU_PARTIAL */
-
 /*
  * If network-based swap is enabled, slub must keep track of whether memory
  * were allocated from pfmemalloc reserves.
@@ -3460,12 +3425,6 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
 	return object;
 }
 
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain);
-#else
-static inline void put_cpu_partial(struct kmem_cache *s, struct slab *slab,
-				   int drain) { }
-#endif
 static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
 
 static bool get_partial_node_bulk(struct kmem_cache *s,
@@ -3891,131 +3850,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 #define local_unlock_cpu_slab(s, flags)	\
 	local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
 
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-static void __put_partials(struct kmem_cache *s, struct slab *partial_slab)
-{
-	struct kmem_cache_node *n = NULL, *n2 = NULL;
-	struct slab *slab, *slab_to_discard = NULL;
-	unsigned long flags = 0;
-
-	while (partial_slab) {
-		slab = partial_slab;
-		partial_slab = slab->next;
-
-		n2 = get_node(s, slab_nid(slab));
-		if (n != n2) {
-			if (n)
-				spin_unlock_irqrestore(&n->list_lock, flags);
-
-			n = n2;
-			spin_lock_irqsave(&n->list_lock, flags);
-		}
-
-		if (unlikely(!slab->inuse && n->nr_partial >= s->min_partial)) {
-			slab->next = slab_to_discard;
-			slab_to_discard = slab;
-		} else {
-			add_partial(n, slab, DEACTIVATE_TO_TAIL);
-			stat(s, FREE_ADD_PARTIAL);
-		}
-	}
-
-	if (n)
-		spin_unlock_irqrestore(&n->list_lock, flags);
-
-	while (slab_to_discard) {
-		slab = slab_to_discard;
-		slab_to_discard = slab_to_discard->next;
-
-		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, slab);
-		stat(s, FREE_SLAB);
-	}
-}
-
-/*
- * Put all the cpu partial slabs to the node partial list.
- */
-static void put_partials(struct kmem_cache *s)
-{
-	struct slab *partial_slab;
-	unsigned long flags;
-
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
-	partial_slab = this_cpu_read(s->cpu_slab->partial);
-	this_cpu_write(s->cpu_slab->partial, NULL);
-	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-
-	if (partial_slab)
-		__put_partials(s, partial_slab);
-}
-
-static void put_partials_cpu(struct kmem_cache *s,
-			     struct kmem_cache_cpu *c)
-{
-	struct slab *partial_slab;
-
-	partial_slab = slub_percpu_partial(c);
-	c->partial = NULL;
-
-	if (partial_slab)
-		__put_partials(s, partial_slab);
-}
-
-/*
- * Put a slab into a partial slab slot if available.
- *
- * If we did not find a slot then simply move all the partials to the
- * per node partial list.
- */
-static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
-{
-	struct slab *oldslab;
-	struct slab *slab_to_put = NULL;
-	unsigned long flags;
-	int slabs = 0;
-
-	local_lock_cpu_slab(s, flags);
-
-	oldslab = this_cpu_read(s->cpu_slab->partial);
-
-	if (oldslab) {
-		if (drain && oldslab->slabs >= s->cpu_partial_slabs) {
-			/*
-			 * Partial array is full. Move the existing set to the
-			 * per node partial list. Postpone the actual unfreezing
-			 * outside of the critical section.
-			 */
-			slab_to_put = oldslab;
-			oldslab = NULL;
-		} else {
-			slabs = oldslab->slabs;
-		}
-	}
-
-	slabs++;
-
-	slab->slabs = slabs;
-	slab->next = oldslab;
-
-	this_cpu_write(s->cpu_slab->partial, slab);
-
-	local_unlock_cpu_slab(s, flags);
-
-	if (slab_to_put) {
-		__put_partials(s, slab_to_put);
-		stat(s, CPU_PARTIAL_DRAIN);
-	}
-}
-
-#else	/* CONFIG_SLUB_CPU_PARTIAL */
-
-static inline void put_partials(struct kmem_cache *s) { }
-static inline void put_partials_cpu(struct kmem_cache *s,
-				    struct kmem_cache_cpu *c) { }
-
-#endif	/* CONFIG_SLUB_CPU_PARTIAL */
-
 static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 {
 	unsigned long flags;
@@ -4053,8 +3887,6 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 		deactivate_slab(s, slab, freelist);
 		stat(s, CPUSLAB_FLUSH);
 	}
-
-	put_partials_cpu(s, c);
 }
 
 static inline void flush_this_cpu_slab(struct kmem_cache *s)
@@ -4063,15 +3895,13 @@ static inline void flush_this_cpu_slab(struct kmem_cache *s)
 
 	if (c->slab)
 		flush_slab(s, c);
-
-	put_partials(s);
 }
 
 static bool has_cpu_slab(int cpu, struct kmem_cache *s)
 {
 	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
 
-	return c->slab || slub_percpu_partial(c);
+	return c->slab;
 }
 
 static bool has_pcs_used(int cpu, struct kmem_cache *s)
@@ -5599,21 +5429,18 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		new.inuse -= cnt;
 		if ((!new.inuse || !prior) && !was_frozen) {
 			/* Needs to be taken off a list */
-			if (!kmem_cache_has_cpu_partial(s) || prior) {
-
-				n = get_node(s, slab_nid(slab));
-				/*
-				 * Speculatively acquire the list_lock.
-				 * If the cmpxchg does not succeed then we may
-				 * drop the list_lock without any processing.
-				 *
-				 * Otherwise the list_lock will synchronize with
-				 * other processors updating the list of slabs.
-				 */
-				spin_lock_irqsave(&n->list_lock, flags);
-
-				on_node_partial = slab_test_node_partial(slab);
-			}
+			n = get_node(s, slab_nid(slab));
+			/*
+			 * Speculatively acquire the list_lock.
+			 * If the cmpxchg does not succeed then we may
+			 * drop the list_lock without any processing.
+			 *
+			 * Otherwise the list_lock will synchronize with
+			 * other processors updating the list of slabs.
+			 */
+			spin_lock_irqsave(&n->list_lock, flags);
+
+			on_node_partial = slab_test_node_partial(slab);
 		}
 
 	} while (!slab_update_freelist(s, slab,
@@ -5629,13 +5456,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			 * activity can be necessary.
 			 */
 			stat(s, FREE_FROZEN);
-		} else if (kmem_cache_has_cpu_partial(s) && !prior) {
-			/*
-			 * If we started with a full slab then put it onto the
-			 * per cpu partial list.
-			 */
-			put_cpu_partial(s, slab, 1);
-			stat(s, CPU_PARTIAL_FREE);
 		}
 
 		return;
@@ -5657,7 +5477,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	 * Objects left in the slab. If it was not on the partial list before
 	 * then add it.
 	 */
-	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
+	if (unlikely(!prior)) {
 		add_partial(n, slab, DEACTIVATE_TO_TAIL);
 		stat(s, FREE_ADD_PARTIAL);
 	}
@@ -6298,8 +6118,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 		if (unlikely(!allow_spin)) {
 			/*
 			 * __slab_free() can locklessly cmpxchg16 into a slab,
-			 * but then it might need to take spin_lock or local_lock
-			 * in put_cpu_partial() for further processing.
+			 * but then it might need to take spin_lock
+			 * for further processing.
 			 * Avoid the complexity and simply add to a deferred list.
 			 */
 			defer_free(s, head);
@@ -7615,39 +7435,6 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 	return 1;
 }
 
-static void set_cpu_partial(struct kmem_cache *s)
-{
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	unsigned int nr_objects;
-
-	/*
-	 * cpu_partial determined the maximum number of objects kept in the
-	 * per cpu partial lists of a processor.
-	 *
-	 * Per cpu partial lists mainly contain slabs that just have one
-	 * object freed. If they are used for allocation then they can be
-	 * filled up again with minimal effort. The slab will never hit the
-	 * per node partial lists and therefore no locking will be required.
-	 *
-	 * For backwards compatibility reasons, this is determined as number
-	 * of objects, even though we now limit maximum number of pages, see
-	 * slub_set_cpu_partial()
-	 */
-	if (!kmem_cache_has_cpu_partial(s))
-		nr_objects = 0;
-	else if (s->size >= PAGE_SIZE)
-		nr_objects = 6;
-	else if (s->size >= 1024)
-		nr_objects = 24;
-	else if (s->size >= 256)
-		nr_objects = 52;
-	else
-		nr_objects = 120;
-
-	slub_set_cpu_partial(s, nr_objects);
-#endif
-}
-
 static unsigned int calculate_sheaf_capacity(struct kmem_cache *s,
 					     struct kmem_cache_args *args)
 
@@ -8517,8 +8304,6 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
 	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
 
-	set_cpu_partial(s);
-
 	s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
 	if (!s->cpu_sheaves) {
 		err = -ENOMEM;
@@ -8882,20 +8667,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 			total += x;
 			nodes[node] += x;
 
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-			slab = slub_percpu_partial_read_once(c);
-			if (slab) {
-				node = slab_nid(slab);
-				if (flags & SO_TOTAL)
-					WARN_ON_ONCE(1);
-				else if (flags & SO_OBJECTS)
-					WARN_ON_ONCE(1);
-				else
-					x = data_race(slab->slabs);
-				total += x;
-				nodes[node] += x;
-			}
-#endif
 		}
 	}
 
@@ -9030,12 +8801,7 @@ SLAB_ATTR(min_partial);
 
 static ssize_t cpu_partial_show(struct kmem_cache *s, char *buf)
 {
-	unsigned int nr_partial = 0;
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	nr_partial = s->cpu_partial;
-#endif
-
-	return sysfs_emit(buf, "%u\n", nr_partial);
+	return sysfs_emit(buf, "0\n");
 }
 
 static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
@@ -9047,11 +8813,9 @@ static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
 	err = kstrtouint(buf, 10, &objects);
 	if (err)
 		return err;
-	if (objects && !kmem_cache_has_cpu_partial(s))
+	if (objects)
 		return -EINVAL;
 
-	slub_set_cpu_partial(s, objects);
-	flush_all(s);
 	return length;
 }
 SLAB_ATTR(cpu_partial);
@@ -9090,42 +8854,7 @@ SLAB_ATTR_RO(objects_partial);
 
 static ssize_t slabs_cpu_partial_show(struct kmem_cache *s, char *buf)
 {
-	int objects = 0;
-	int slabs = 0;
-	int cpu __maybe_unused;
-	int len = 0;
-
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	for_each_online_cpu(cpu) {
-		struct slab *slab;
-
-		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
-
-		if (slab)
-			slabs += data_race(slab->slabs);
-	}
-#endif
-
-	/* Approximate half-full slabs, see slub_set_cpu_partial() */
-	objects = (slabs * oo_objects(s->oo)) / 2;
-	len += sysfs_emit_at(buf, len, "%d(%d)", objects, slabs);
-
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	for_each_online_cpu(cpu) {
-		struct slab *slab;
-
-		slab = slub_percpu_partial(per_cpu_ptr(s->cpu_slab, cpu));
-		if (slab) {
-			slabs = data_race(slab->slabs);
-			objects = (slabs * oo_objects(s->oo)) / 2;
-			len += sysfs_emit_at(buf, len, " C%d=%d(%d)",
-					     cpu, objects, slabs);
-		}
-	}
-#endif
-	len += sysfs_emit_at(buf, len, "\n");
-
-	return len;
+	return sysfs_emit(buf, "0(0)\n");
 }
 SLAB_ATTR_RO(slabs_cpu_partial);
 

-- 
2.51.1


