Return-Path: <bpf+bounces-78577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD3D139AF
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9AA673017F83
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0B62F5498;
	Mon, 12 Jan 2026 15:17:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60362F49F8
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231049; cv=none; b=Mgwbb664h+yFQdzJM1pNUMnZRK7vWGv4knu7jv2S3ObmMIGWxDLxBsNVHvgCsdeoiKRRIhBzXITeKTRl9GAqwwQiNvNyQPtK5F03HXET56IlaKS04g2EzSsnr/pDKcvQHmAQQfx9pisxy1lsqphc9GX+gjr6KaZ17yTvzItfvXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231049; c=relaxed/simple;
	bh=i4/7NRPayUanL5GohwOB/aLdmuPYgk37sX2VBwCzpLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANxtmDABe+E7dKMyMG5nGOEaQ7N/f+5rvDzVKfb/6MNrhChlzCj9urTxk426293FKpTtan+JGX7VhA/JvUb/QZIPDZmPdDzqC8YQBwYI39y6zSbi8yc8UqMqWgBoMPnrtIgaEi2dT23BTY9mWaEN33DCz1wB96pKrXO+yJdD+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B1DD5BCD1;
	Mon, 12 Jan 2026 15:16:58 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E6673EA63;
	Mon, 12 Jan 2026 15:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CA3YEmoQZWn7FgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Jan 2026 15:16:58 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 12 Jan 2026 16:17:03 +0100
Subject: [PATCH RFC v2 09/20] slab: remove cpu (partial) slabs usage from
 allocation paths
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-sheaves-for-all-v2-9-98225cfb50cf@suse.cz>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
In-Reply-To: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
To: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hao Li <hao.li@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6B1DD5BCD1
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

We now rely on sheaves as the percpu caching layer and can refill them
directly from partial or newly allocated slabs. Start removing the cpu
(partial) slabs code, first from allocation paths.

This means that any allocation not satisfied from percpu sheaves will
end up in ___slab_alloc(), where we remove the usage of cpu (partial)
slabs, so it will only perform get_partial() or new_slab().

In get_partial_node() we used to return a slab for freezing as the cpu
slab and to refill the partial slab. Now we only want to return a single
object and leave the slab on the list (unless it became full). We can't
simply reuse alloc_single_from_partial() as that assumes freeing uses
free_to_partial_list(). Instead we need to use __slab_update_freelist()
to work properly against a racing __slab_free().

The rest of the changes is removing functions that no longer have any
callers.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 611 ++++++++------------------------------------------------------
 1 file changed, 78 insertions(+), 533 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index b568801edec2..7173f6716382 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -245,7 +245,6 @@ static DEFINE_STATIC_KEY_FALSE(strict_numa);
 struct partial_context {
 	gfp_t flags;
 	unsigned int orig_size;
-	void *object;
 	unsigned int min_objects;
 	unsigned int max_objects;
 	struct list_head slabs;
@@ -599,36 +598,6 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
 	return freelist_ptr_decode(s, p, ptr_addr);
 }
 
-static void prefetch_freepointer(const struct kmem_cache *s, void *object)
-{
-	prefetchw(object + s->offset);
-}
-
-/*
- * When running under KMSAN, get_freepointer_safe() may return an uninitialized
- * pointer value in the case the current thread loses the race for the next
- * memory chunk in the freelist. In that case this_cpu_cmpxchg_double() in
- * slab_alloc_node() will fail, so the uninitialized value won't be used, but
- * KMSAN will still check all arguments of cmpxchg because of imperfect
- * handling of inline assembly.
- * To work around this problem, we apply __no_kmsan_checks to ensure that
- * get_freepointer_safe() returns initialized memory.
- */
-__no_kmsan_checks
-static inline void *get_freepointer_safe(struct kmem_cache *s, void *object)
-{
-	unsigned long freepointer_addr;
-	freeptr_t p;
-
-	if (!debug_pagealloc_enabled_static())
-		return get_freepointer(s, object);
-
-	object = kasan_reset_tag(object);
-	freepointer_addr = (unsigned long)object + s->offset;
-	copy_from_kernel_nofault(&p, (freeptr_t *)freepointer_addr, sizeof(p));
-	return freelist_ptr_decode(s, p, freepointer_addr);
-}
-
 static inline void set_freepointer(struct kmem_cache *s, void *object, void *fp)
 {
 	unsigned long freeptr_addr = (unsigned long)object + s->offset;
@@ -708,23 +677,11 @@ static void slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
 	nr_slabs = DIV_ROUND_UP(nr_objects * 2, oo_objects(s->oo));
 	s->cpu_partial_slabs = nr_slabs;
 }
-
-static inline unsigned int slub_get_cpu_partial(struct kmem_cache *s)
-{
-	return s->cpu_partial_slabs;
-}
-#else
-#ifdef SLAB_SUPPORTS_SYSFS
+#elif defined(SLAB_SUPPORTS_SYSFS)
 static inline void
 slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
 {
 }
-#endif
-
-static inline unsigned int slub_get_cpu_partial(struct kmem_cache *s)
-{
-	return 0;
-}
 #endif /* CONFIG_SLUB_CPU_PARTIAL */
 
 /*
@@ -1065,7 +1022,7 @@ static void set_track_update(struct kmem_cache *s, void *object,
 	p->handle = handle;
 #endif
 	p->addr = addr;
-	p->cpu = smp_processor_id();
+	p->cpu = raw_smp_processor_id();
 	p->pid = current->pid;
 	p->when = jiffies;
 }
@@ -3571,15 +3528,15 @@ static bool get_partial_node_bulk(struct kmem_cache *s,
 }
 
 /*
- * Try to allocate a partial slab from a specific node.
+ * Try to allocate object from a partial slab on a specific node.
  */
-static struct slab *get_partial_node(struct kmem_cache *s,
-				     struct kmem_cache_node *n,
-				     struct partial_context *pc)
+static void *get_partial_node(struct kmem_cache *s,
+			      struct kmem_cache_node *n,
+			      struct partial_context *pc)
 {
-	struct slab *slab, *slab2, *partial = NULL;
+	struct slab *slab, *slab2;
 	unsigned long flags;
-	unsigned int partial_slabs = 0;
+	void *object = NULL;
 
 	/*
 	 * Racy check. If we mistakenly see no partial slabs then we
@@ -3595,54 +3552,55 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 	else if (!spin_trylock_irqsave(&n->list_lock, flags))
 		return NULL;
 	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
+
+		struct freelist_counters old, new;
+
 		if (!pfmemalloc_match(slab, pc->flags))
 			continue;
 
 		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
-			void *object = alloc_single_from_partial(s, n, slab,
+			object = alloc_single_from_partial(s, n, slab,
 							pc->orig_size);
-			if (object) {
-				partial = slab;
-				pc->object = object;
+			if (object)
 				break;
-			}
 			continue;
 		}
 
-		remove_partial(n, slab);
+		/*
+		 * get a single object from the slab. This might race against
+		 * __slab_free(), which however has to take the list_lock if
+		 * it's about to make the slab fully free.
+		 */
+		do {
+			old.freelist = slab->freelist;
+			old.counters = slab->counters;
 
-		if (!partial) {
-			partial = slab;
-			stat(s, ALLOC_FROM_PARTIAL);
+			new.freelist = get_freepointer(s, old.freelist);
+			new.counters = old.counters;
+			new.inuse++;
 
-			if ((slub_get_cpu_partial(s) == 0)) {
-				break;
-			}
-		} else {
-			put_cpu_partial(s, slab, 0);
-			stat(s, CPU_PARTIAL_NODE);
+		} while (!__slab_update_freelist(s, slab, &old, &new, "get_partial_node"));
 
-			if (++partial_slabs > slub_get_cpu_partial(s) / 2) {
-				break;
-			}
-		}
+		object = old.freelist;
+		if (!new.freelist)
+			remove_partial(n, slab);
+
+		break;
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
-	return partial;
+	return object;
 }
 
 /*
- * Get a slab from somewhere. Search in increasing NUMA distances.
+ * Get an object from somewhere. Search in increasing NUMA distances.
  */
-static struct slab *get_any_partial(struct kmem_cache *s,
-				    struct partial_context *pc)
+static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
 	struct zoneref *z;
 	struct zone *zone;
 	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
-	struct slab *slab;
 	unsigned int cpuset_mems_cookie;
 
 	/*
@@ -3677,8 +3635,8 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 
 			if (n && cpuset_zone_allowed(zone, pc->flags) &&
 					n->nr_partial > s->min_partial) {
-				slab = get_partial_node(s, n, pc);
-				if (slab) {
+				void *object = get_partial_node(s, n, pc);
+				if (object) {
 					/*
 					 * Don't check read_mems_allowed_retry()
 					 * here - if mems_allowed was updated in
@@ -3686,7 +3644,7 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 					 * between allocation and the cpuset
 					 * update
 					 */
-					return slab;
+					return object;
 				}
 			}
 		}
@@ -3696,20 +3654,20 @@ static struct slab *get_any_partial(struct kmem_cache *s,
 }
 
 /*
- * Get a partial slab, lock it and return it.
+ * Get an object from a partial slab
  */
-static struct slab *get_partial(struct kmem_cache *s, int node,
-				struct partial_context *pc)
+static void *get_partial(struct kmem_cache *s, int node,
+			 struct partial_context *pc)
 {
-	struct slab *slab;
 	int searchnode = node;
+	void *object;
 
 	if (node == NUMA_NO_NODE)
 		searchnode = numa_mem_id();
 
-	slab = get_partial_node(s, get_node(s, searchnode), pc);
-	if (slab || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
-		return slab;
+	object = get_partial_node(s, get_node(s, searchnode), pc);
+	if (object || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
+		return object;
 
 	return get_any_partial(s, pc);
 }
@@ -4269,19 +4227,6 @@ static int slub_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Check if the objects in a per cpu structure fit numa
- * locality expectations.
- */
-static inline int node_match(struct slab *slab, int node)
-{
-#ifdef CONFIG_NUMA
-	if (node != NUMA_NO_NODE && slab_nid(slab) != node)
-		return 0;
-#endif
-	return 1;
-}
-
 #ifdef CONFIG_SLUB_DEBUG
 static int count_free(struct slab *slab)
 {
@@ -4466,36 +4411,6 @@ __update_cpu_freelist_fast(struct kmem_cache *s,
 					     &old.freelist_tid, new.freelist_tid);
 }
 
-/*
- * Check the slab->freelist and either transfer the freelist to the
- * per cpu freelist or deactivate the slab.
- *
- * The slab is still frozen if the return value is not NULL.
- *
- * If this function returns NULL then the slab has been unfrozen.
- */
-static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
-{
-	struct freelist_counters old, new;
-
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
-
-	do {
-		old.freelist = slab->freelist;
-		old.counters = slab->counters;
-
-		new.freelist = NULL;
-		new.counters = old.counters;
-
-		new.inuse = old.objects;
-		new.frozen = old.freelist != NULL;
-
-
-	} while (!__slab_update_freelist(s, slab, &old, &new, "get_freelist"));
-
-	return old.freelist;
-}
-
 /*
  * Get the slab's freelist and do not freeze it.
  *
@@ -4523,29 +4438,6 @@ static inline void *get_freelist_nofreeze(struct kmem_cache *s, struct slab *sla
 	return old.freelist;
 }
 
-/*
- * Freeze the partial slab and return the pointer to the freelist.
- */
-static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
-{
-	struct freelist_counters old, new;
-
-	do {
-		old.freelist = slab->freelist;
-		old.counters = slab->counters;
-
-		new.freelist = NULL;
-		new.counters = old.counters;
-		VM_BUG_ON(new.frozen);
-
-		new.inuse = old.objects;
-		new.frozen = 1;
-
-	} while (!slab_update_freelist(s, slab, &old, &new, "freeze_slab"));
-
-	return old.freelist;
-}
-
 /*
  * If the object has been wiped upon free, make sure it's fully initialized by
  * zeroing out freelist pointer.
@@ -4603,172 +4495,24 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
 
 	return allocated;
 }
-
 /*
- * Slow path. The lockless freelist is empty or we need to perform
- * debugging duties.
- *
- * Processing is still very fast if new objects have been freed to the
- * regular freelist. In that case we simply take over the regular freelist
- * as the lockless freelist and zap the regular freelist.
- *
- * If that is not working then we fall back to the partial lists. We take the
- * first element of the freelist as the object to allocate now and move the
- * rest of the freelist to the lockless freelist.
- *
- * And if we were unable to get a new slab from the partial slab lists then
- * we need to allocate a new slab. This is the slowest path since it involves
- * a call to the page allocator and the setup of a new slab.
+ * Slow path. We failed to allocate via percpu sheaves or they are not available
+ * due to bootstrap or debugging enabled or SLUB_TINY.
  *
- * Version of __slab_alloc to use when we know that preemption is
- * already disabled (which is the case for bulk allocation).
+ * We try to allocate from partial slab lists and fall back to allocating a new
+ * slab.
  */
 static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
+			   unsigned long addr, unsigned int orig_size)
 {
 	bool allow_spin = gfpflags_allow_spinning(gfpflags);
 	void *freelist;
 	struct slab *slab;
-	unsigned long flags;
 	struct partial_context pc;
 	bool try_thisnode = true;
 
 	stat(s, ALLOC_SLOWPATH);
 
-reread_slab:
-
-	slab = READ_ONCE(c->slab);
-	if (!slab) {
-		/*
-		 * if the node is not online or has no normal memory, just
-		 * ignore the node constraint
-		 */
-		if (unlikely(node != NUMA_NO_NODE &&
-			     !node_isset(node, slab_nodes)))
-			node = NUMA_NO_NODE;
-		goto new_slab;
-	}
-
-	if (unlikely(!node_match(slab, node))) {
-		/*
-		 * same as above but node_match() being false already
-		 * implies node != NUMA_NO_NODE.
-		 *
-		 * We don't strictly honor pfmemalloc and NUMA preferences
-		 * when !allow_spin because:
-		 *
-		 * 1. Most kmalloc() users allocate objects on the local node,
-		 *    so kmalloc_nolock() tries not to interfere with them by
-		 *    deactivating the cpu slab.
-		 *
-		 * 2. Deactivating due to NUMA or pfmemalloc mismatch may cause
-		 *    unnecessary slab allocations even when n->partial list
-		 *    is not empty.
-		 */
-		if (!node_isset(node, slab_nodes) ||
-		    !allow_spin) {
-			node = NUMA_NO_NODE;
-		} else {
-			stat(s, ALLOC_NODE_MISMATCH);
-			goto deactivate_slab;
-		}
-	}
-
-	/*
-	 * By rights, we should be searching for a slab page that was
-	 * PFMEMALLOC but right now, we are losing the pfmemalloc
-	 * information when the page leaves the per-cpu allocator
-	 */
-	if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin))
-		goto deactivate_slab;
-
-	/* must check again c->slab in case we got preempted and it changed */
-	local_lock_cpu_slab(s, flags);
-
-	if (unlikely(slab != c->slab)) {
-		local_unlock_cpu_slab(s, flags);
-		goto reread_slab;
-	}
-	freelist = c->freelist;
-	if (freelist)
-		goto load_freelist;
-
-	freelist = get_freelist(s, slab);
-
-	if (!freelist) {
-		c->slab = NULL;
-		c->tid = next_tid(c->tid);
-		local_unlock_cpu_slab(s, flags);
-		stat(s, DEACTIVATE_BYPASS);
-		goto new_slab;
-	}
-
-	stat(s, ALLOC_REFILL);
-
-load_freelist:
-
-	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
-
-	/*
-	 * freelist is pointing to the list of objects to be used.
-	 * slab is pointing to the slab from which the objects are obtained.
-	 * That slab must be frozen for per cpu allocations to work.
-	 */
-	VM_BUG_ON(!c->slab->frozen);
-	c->freelist = get_freepointer(s, freelist);
-	c->tid = next_tid(c->tid);
-	local_unlock_cpu_slab(s, flags);
-	return freelist;
-
-deactivate_slab:
-
-	local_lock_cpu_slab(s, flags);
-	if (slab != c->slab) {
-		local_unlock_cpu_slab(s, flags);
-		goto reread_slab;
-	}
-	freelist = c->freelist;
-	c->slab = NULL;
-	c->freelist = NULL;
-	c->tid = next_tid(c->tid);
-	local_unlock_cpu_slab(s, flags);
-	deactivate_slab(s, slab, freelist);
-
-new_slab:
-
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	while (slub_percpu_partial(c)) {
-		local_lock_cpu_slab(s, flags);
-		if (unlikely(c->slab)) {
-			local_unlock_cpu_slab(s, flags);
-			goto reread_slab;
-		}
-		if (unlikely(!slub_percpu_partial(c))) {
-			local_unlock_cpu_slab(s, flags);
-			/* we were preempted and partial list got empty */
-			goto new_objects;
-		}
-
-		slab = slub_percpu_partial(c);
-		slub_set_percpu_partial(c, slab);
-
-		if (likely(node_match(slab, node) &&
-			   pfmemalloc_match(slab, gfpflags)) ||
-		    !allow_spin) {
-			c->slab = slab;
-			freelist = get_freelist(s, slab);
-			VM_BUG_ON(!freelist);
-			stat(s, CPU_PARTIAL_ALLOC);
-			goto load_freelist;
-		}
-
-		local_unlock_cpu_slab(s, flags);
-
-		slab->next = NULL;
-		__put_partials(s, slab);
-	}
-#endif
-
 new_objects:
 
 	pc.flags = gfpflags;
@@ -4793,33 +4537,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 
 	pc.orig_size = orig_size;
-	slab = get_partial(s, node, &pc);
-	if (slab) {
-		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
-			freelist = pc.object;
-			/*
-			 * For debug caches here we had to go through
-			 * alloc_single_from_partial() so just store the
-			 * tracking info and return the object.
-			 *
-			 * Due to disabled preemption we need to disallow
-			 * blocking. The flags are further adjusted by
-			 * gfp_nested_mask() in stack_depot itself.
-			 */
-			if (s->flags & SLAB_STORE_USER)
-				set_track(s, freelist, TRACK_ALLOC, addr,
-					  gfpflags & ~(__GFP_DIRECT_RECLAIM));
-
-			return freelist;
-		}
-
-		freelist = freeze_slab(s, slab);
-		goto retry_load_slab;
-	}
+	freelist = get_partial(s, node, &pc);
+	if (freelist)
+		goto success;
 
-	slub_put_cpu_ptr(s->cpu_slab);
 	slab = new_slab(s, pc.flags, node);
-	c = slub_get_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!slab)) {
 		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE)
@@ -4836,68 +4558,31 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
 		freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
 
-		if (unlikely(!freelist)) {
-			/* This could cause an endless loop. Fail instead. */
-			if (!allow_spin)
-				return NULL;
-			goto new_objects;
+		if (likely(freelist)) {
+			goto success;
 		}
+	} else {
+		alloc_from_new_slab(s, slab, &freelist, 1, allow_spin);
 
-		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr,
-				  gfpflags & ~(__GFP_DIRECT_RECLAIM));
-
-		return freelist;
-	}
-
-	/*
-	 * No other reference to the slab yet so we can
-	 * muck around with it freely without cmpxchg
-	 */
-	freelist = slab->freelist;
-	slab->freelist = NULL;
-	slab->inuse = slab->objects;
-	slab->frozen = 1;
-
-	inc_slabs_node(s, slab_nid(slab), slab->objects);
-
-	if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
-		/*
-		 * For !pfmemalloc_match() case we don't load freelist so that
-		 * we don't make further mismatched allocations easier.
-		 */
-		deactivate_slab(s, slab, get_freepointer(s, freelist));
-		return freelist;
+		/* we don't need to check SLAB_STORE_USER here */
+		if (likely(freelist)) {
+			return freelist;
+		}
 	}
 
-retry_load_slab:
-
-	local_lock_cpu_slab(s, flags);
-	if (unlikely(c->slab)) {
-		void *flush_freelist = c->freelist;
-		struct slab *flush_slab = c->slab;
-
-		c->slab = NULL;
-		c->freelist = NULL;
-		c->tid = next_tid(c->tid);
-
-		local_unlock_cpu_slab(s, flags);
-
-		if (unlikely(!allow_spin)) {
-			/* Reentrant slub cannot take locks, defer */
-			defer_deactivate_slab(flush_slab, flush_freelist);
-		} else {
-			deactivate_slab(s, flush_slab, flush_freelist);
-		}
+	if (allow_spin)
+		goto new_objects;
 
-		stat(s, CPUSLAB_FLUSH);
+	/* This could cause an endless loop. Fail instead. */
+	return NULL;
 
-		goto retry_load_slab;
-	}
-	c->slab = slab;
+success:
+	if (kmem_cache_debug_flags(s, SLAB_STORE_USER))
+		set_track(s, freelist, TRACK_ALLOC, addr, gfpflags);
 
-	goto load_freelist;
+	return freelist;
 }
+
 /*
  * We disallow kprobes in ___slab_alloc() to prevent reentrance
  *
@@ -4912,87 +4597,11 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
  */
 NOKPROBE_SYMBOL(___slab_alloc);
 
-/*
- * A wrapper for ___slab_alloc() for contexts where preemption is not yet
- * disabled. Compensates for possible cpu changes by refetching the per cpu area
- * pointer.
- */
-static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
-			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
-{
-	void *p;
-
-#ifdef CONFIG_PREEMPT_COUNT
-	/*
-	 * We may have been preempted and rescheduled on a different
-	 * cpu before disabling preemption. Need to reload cpu area
-	 * pointer.
-	 */
-	c = slub_get_cpu_ptr(s->cpu_slab);
-#endif
-	if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
-		if (local_lock_is_locked(&s->cpu_slab->lock)) {
-			/*
-			 * EBUSY is an internal signal to kmalloc_nolock() to
-			 * retry a different bucket. It's not propagated
-			 * to the caller.
-			 */
-			p = ERR_PTR(-EBUSY);
-			goto out;
-		}
-	}
-	p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
-out:
-#ifdef CONFIG_PREEMPT_COUNT
-	slub_put_cpu_ptr(s->cpu_slab);
-#endif
-	return p;
-}
-
 static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
-	struct kmem_cache_cpu *c;
-	struct slab *slab;
-	unsigned long tid;
 	void *object;
 
-redo:
-	/*
-	 * Must read kmem_cache cpu data via this cpu ptr. Preemption is
-	 * enabled. We may switch back and forth between cpus while
-	 * reading from one cpu area. That does not matter as long
-	 * as we end up on the original cpu again when doing the cmpxchg.
-	 *
-	 * We must guarantee that tid and kmem_cache_cpu are retrieved on the
-	 * same cpu. We read first the kmem_cache_cpu pointer and use it to read
-	 * the tid. If we are preempted and switched to another cpu between the
-	 * two reads, it's OK as the two are still associated with the same cpu
-	 * and cmpxchg later will validate the cpu.
-	 */
-	c = raw_cpu_ptr(s->cpu_slab);
-	tid = READ_ONCE(c->tid);
-
-	/*
-	 * Irqless object alloc/free algorithm used here depends on sequence
-	 * of fetching cpu_slab's data. tid should be fetched before anything
-	 * on c to guarantee that object and slab associated with previous tid
-	 * won't be used with current tid. If we fetch tid first, object and
-	 * slab could be one associated with next tid and our alloc/free
-	 * request will be failed. In this case, we will retry. So, no problem.
-	 */
-	barrier();
-
-	/*
-	 * The transaction ids are globally unique per cpu and per operation on
-	 * a per cpu queue. Thus they can be guarantee that the cmpxchg_double
-	 * occurs on the right processor and that there was no operation on the
-	 * linked list in between.
-	 */
-
-	object = c->freelist;
-	slab = c->slab;
-
 #ifdef CONFIG_NUMA
 	if (static_branch_unlikely(&strict_numa) &&
 			node == NUMA_NO_NODE) {
@@ -5001,47 +4610,20 @@ static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
 
 		if (mpol) {
 			/*
-			 * Special BIND rule support. If existing slab
+			 * Special BIND rule support. If the local node
 			 * is in permitted set then do not redirect
 			 * to a particular node.
 			 * Otherwise we apply the memory policy to get
 			 * the node we need to allocate on.
 			 */
-			if (mpol->mode != MPOL_BIND || !slab ||
-					!node_isset(slab_nid(slab), mpol->nodes))
-
+			if (mpol->mode != MPOL_BIND ||
+					!node_isset(numa_mem_id(), mpol->nodes))
 				node = mempolicy_slab_node();
 		}
 	}
 #endif
 
-	if (!USE_LOCKLESS_FAST_PATH() ||
-	    unlikely(!object || !slab || !node_match(slab, node))) {
-		object = __slab_alloc(s, gfpflags, node, addr, c, orig_size);
-	} else {
-		void *next_object = get_freepointer_safe(s, object);
-
-		/*
-		 * The cmpxchg will only match if there was no additional
-		 * operation and if we are on the right processor.
-		 *
-		 * The cmpxchg does the following atomically (without lock
-		 * semantics!)
-		 * 1. Relocate first pointer to the current per cpu area.
-		 * 2. Verify that tid and freelist have not been changed
-		 * 3. If they were not changed replace tid and freelist
-		 *
-		 * Since this is without lock semantics the protection is only
-		 * against code executing on this cpu *not* from access by
-		 * other cpus.
-		 */
-		if (unlikely(!__update_cpu_freelist_fast(s, object, next_object, tid))) {
-			note_cmpxchg_failure("slab_alloc", s, tid);
-			goto redo;
-		}
-		prefetch_freepointer(s, next_object);
-		stat(s, ALLOC_FASTPATH);
-	}
+	object = ___slab_alloc(s, gfpflags, node, addr, orig_size);
 
 	return object;
 }
@@ -7709,62 +7291,25 @@ static inline
 int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			    void **p)
 {
-	struct kmem_cache_cpu *c;
-	unsigned long irqflags;
 	int i;
 
 	/*
-	 * Drain objects in the per cpu slab, while disabling local
-	 * IRQs, which protects against PREEMPT and interrupts
-	 * handlers invoking normal fastpath.
+	 * TODO: this might be more efficient (if necessary) by reusing
+	 * __refill_objects()
 	 */
-	c = slub_get_cpu_ptr(s->cpu_slab);
-	local_lock_irqsave(&s->cpu_slab->lock, irqflags);
-
 	for (i = 0; i < size; i++) {
-		void *object = c->freelist;
 
-		if (unlikely(!object)) {
-			/*
-			 * We may have removed an object from c->freelist using
-			 * the fastpath in the previous iteration; in that case,
-			 * c->tid has not been bumped yet.
-			 * Since ___slab_alloc() may reenable interrupts while
-			 * allocating memory, we should bump c->tid now.
-			 */
-			c->tid = next_tid(c->tid);
+		p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE, _RET_IP_,
+				     s->object_size);
+		if (unlikely(!p[i]))
+			goto error;
 
-			local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
-
-			/*
-			 * Invoking slow path likely have side-effect
-			 * of re-populating per CPU c->freelist
-			 */
-			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE,
-					    _RET_IP_, c, s->object_size);
-			if (unlikely(!p[i]))
-				goto error;
-
-			c = this_cpu_ptr(s->cpu_slab);
-			maybe_wipe_obj_freeptr(s, p[i]);
-
-			local_lock_irqsave(&s->cpu_slab->lock, irqflags);
-
-			continue; /* goto for-loop */
-		}
-		c->freelist = get_freepointer(s, object);
-		p[i] = object;
 		maybe_wipe_obj_freeptr(s, p[i]);
-		stat(s, ALLOC_FASTPATH);
 	}
-	c->tid = next_tid(c->tid);
-	local_unlock_irqrestore(&s->cpu_slab->lock, irqflags);
-	slub_put_cpu_ptr(s->cpu_slab);
 
 	return i;
 
 error:
-	slub_put_cpu_ptr(s->cpu_slab);
 	__kmem_cache_free_bulk(s, i, p);
 	return 0;
 

-- 
2.52.0


