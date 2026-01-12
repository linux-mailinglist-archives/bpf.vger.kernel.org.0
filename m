Return-Path: <bpf+bounces-78575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89BBD139A0
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 463DA302EA71
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42DA2F3C37;
	Mon, 12 Jan 2026 15:17:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2B02EB5BA
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 15:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231042; cv=none; b=IVOc2TLOr1w/RmeLzTySVAQE3Q+8cXBROi5YzDoMehtx91P203PztYdKtCQs+y23VDf6FlbJ4HEfUttHxw2rZ6Pl1bl2NZEWEIiyZdwkQcaUODFMsDRIjcn+H82FvWh8UPMxONgLKfhBBd54gG0+ryX08u2Y7UXkoH/qu8eLCrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231042; c=relaxed/simple;
	bh=Gr/X6H7/qqFsqt23tDAA5XuWxSqPoMQnBcKBsDQmpkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hyyn8RHf2onRM3M5jkRjy3PYZU9+dsVAPx9SZQZs7FNJc6G3NhkmalSQioChbVi+jvZBqCkgaRBSLMbrVie4JoMXdD/+Wa+YNGtrzGf5I7J0fvPYLVMcx73uMJNBeDNPcyOjaKYKibRxTN1YHl7fKoPz0FQqMeH1/e93mFdpgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F33715BCD0;
	Mon, 12 Jan 2026 15:16:57 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5D803EA63;
	Mon, 12 Jan 2026 15:16:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Em3M2kQZWn7FgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Jan 2026 15:16:57 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 12 Jan 2026 16:16:59 +0100
Subject: [PATCH RFC v2 05/20] slab: introduce percpu sheaves bootstrap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-sheaves-for-all-v2-5-98225cfb50cf@suse.cz>
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
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F33715BCD0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO

Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
sheaves enabled. Since we want to enable them for almost all caches,
it's suboptimal to test the pointer in the fast paths, so instead
allocate it for all caches in do_kmem_cache_create(). Instead of testing
the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
kmem_cache->sheaf_capacity for being 0, where needed.

However, for the fast paths sake we also assume that the main sheaf
always exists (pcs->main is !NULL), and during bootstrap we cannot
allocate sheaves yet.

Solve this by introducing a single static bootstrap_sheaf that's
assigned as pcs->main during bootstrap. It has a size of 0, so during
allocations, the fast path will find it's empty. Since the size of 0
matches sheaf_capacity of 0, the freeing fast paths will find it's
"full". In the slow path handlers, we check sheaf_capacity to recognize
that the cache doesn't (yet) have real sheaves, and fall back. Thus
sharing the single bootstrap sheaf like this for multiple caches and
cpus is safe.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 24 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 6e05e3cc5c49..06d5cf794403 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2855,6 +2855,10 @@ static void pcs_destroy(struct kmem_cache *s)
 		if (!pcs->main)
 			continue;
 
+		/* bootstrap or debug caches, it's the bootstrap_sheaf */
+		if (!pcs->main->cache)
+			continue;
+
 		/*
 		 * We have already passed __kmem_cache_shutdown() so everything
 		 * was flushed and there should be no objects allocated from
@@ -4052,7 +4056,7 @@ static void flush_cpu_slab(struct work_struct *w)
 
 	s = sfw->s;
 
-	if (s->cpu_sheaves)
+	if (s->sheaf_capacity)
 		pcs_flush_all(s);
 
 	flush_this_cpu_slab(s);
@@ -4179,7 +4183,7 @@ static int slub_cpu_dead(unsigned int cpu)
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
 		__flush_cpu_slab(s, cpu);
-		if (s->cpu_sheaves)
+		if (s->sheaf_capacity)
 			__pcs_flush_all_cpu(s, cpu);
 	}
 	mutex_unlock(&slab_mutex);
@@ -4979,6 +4983,12 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
+	/* Bootstrap or debug cache, back off */
+	if (unlikely(!s->sheaf_capacity)) {
+		local_unlock(&s->cpu_sheaves->lock);
+		return NULL;
+	}
+
 	if (pcs->spare && pcs->spare->size > 0) {
 		swap(pcs->main, pcs->spare);
 		return pcs;
@@ -5165,6 +5175,11 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		struct slab_sheaf *full;
 		struct node_barn *barn;
 
+		if (unlikely(!s->sheaf_capacity)) {
+			local_unlock(&s->cpu_sheaves->lock);
+			return allocated;
+		}
+
 		if (pcs->spare && pcs->spare->size > 0) {
 			swap(pcs->main, pcs->spare);
 			goto do_alloc;
@@ -5244,8 +5259,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	if (unlikely(object))
 		goto out;
 
-	if (s->cpu_sheaves)
-		object = alloc_from_pcs(s, gfpflags, node);
+	object = alloc_from_pcs(s, gfpflags, node);
 
 	if (!object)
 		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
@@ -6078,6 +6092,12 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 restart:
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
+	/* Bootstrap or debug cache, back off */
+	if (unlikely(!s->sheaf_capacity)) {
+		local_unlock(&s->cpu_sheaves->lock);
+		return NULL;
+	}
+
 	barn = get_barn(s);
 	if (!barn) {
 		local_unlock(&s->cpu_sheaves->lock);
@@ -6276,6 +6296,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 		struct slab_sheaf *empty;
 		struct node_barn *barn;
 
+		/* Bootstrap or debug cache, fall back */
+		if (!unlikely(s->sheaf_capacity)) {
+			local_unlock(&s->cpu_sheaves->lock);
+			goto fail;
+		}
+
 		if (pcs->spare && pcs->spare->size == 0) {
 			pcs->rcu_free = pcs->spare;
 			pcs->spare = NULL;
@@ -6401,6 +6427,9 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	if (likely(pcs->main->size < s->sheaf_capacity))
 		goto do_free;
 
+	if (unlikely(!s->sheaf_capacity))
+		goto no_empty;
+
 	barn = get_barn(s);
 	if (!barn)
 		goto no_empty;
@@ -6668,9 +6697,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	if (unlikely(!slab_free_hook(s, object, slab_want_init_on_free(s), false)))
 		return;
 
-	if (s->cpu_sheaves && likely(!IS_ENABLED(CONFIG_NUMA) ||
-				     slab_nid(slab) == numa_mem_id())
-			   && likely(!slab_test_pfmemalloc(slab))) {
+	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
+	    && likely(!slab_test_pfmemalloc(slab))) {
 		if (likely(free_to_pcs(s, object)))
 			return;
 	}
@@ -7484,8 +7512,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 		size--;
 	}
 
-	if (s->cpu_sheaves)
-		i = alloc_from_pcs_bulk(s, size, p);
+	i = alloc_from_pcs_bulk(s, size, p);
 
 	if (i < size) {
 		/*
@@ -7696,6 +7723,7 @@ static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
 
 static int init_percpu_sheaves(struct kmem_cache *s)
 {
+	static struct slab_sheaf bootstrap_sheaf = {};
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
@@ -7705,7 +7733,28 @@ static int init_percpu_sheaves(struct kmem_cache *s)
 
 		local_trylock_init(&pcs->lock);
 
-		pcs->main = alloc_empty_sheaf(s, GFP_KERNEL);
+		/*
+		 * Bootstrap sheaf has zero size so fast-path allocation fails.
+		 * It has also size == s->sheaf_capacity, so fast-path free
+		 * fails. In the slow paths we recognize the situation by
+		 * checking s->sheaf_capacity. This allows fast paths to assume
+		 * s->pcs_sheaves and pcs->main always exists and is valid.
+		 * It's also safe to share the single static bootstrap_sheaf
+		 * with zero-sized objects array as it's never modified.
+		 *
+		 * bootstrap_sheaf also has NULL pointer to kmem_cache so we
+		 * recognize it and not attempt to free it when destroying the
+		 * cache
+		 *
+		 * We keep bootstrap_sheaf for kmem_cache and kmem_cache_node,
+		 * caches with debug enabled, and all caches with SLUB_TINY.
+		 * For kmalloc caches it's used temporarily during the initial
+		 * bootstrap.
+		 */
+		if (!s->sheaf_capacity)
+			pcs->main = &bootstrap_sheaf;
+		else
+			pcs->main = alloc_empty_sheaf(s, GFP_KERNEL);
 
 		if (!pcs->main)
 			return -ENOMEM;
@@ -7803,7 +7852,7 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 			continue;
 		}
 
-		if (s->cpu_sheaves) {
+		if (s->sheaf_capacity) {
 			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
 
 			if (!barn)
@@ -8121,7 +8170,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	flush_all_cpus_locked(s);
 
 	/* we might have rcu sheaves in flight */
-	if (s->cpu_sheaves)
+	if (s->sheaf_capacity)
 		rcu_barrier();
 
 	/* Attempt to free all objects */
@@ -8433,7 +8482,7 @@ static int slab_mem_going_online_callback(int nid)
 		if (get_node(s, nid))
 			continue;
 
-		if (s->cpu_sheaves) {
+		if (s->sheaf_capacity) {
 			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, nid);
 
 			if (!barn) {
@@ -8641,12 +8690,10 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 
 	set_cpu_partial(s);
 
-	if (s->sheaf_capacity) {
-		s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
-		if (!s->cpu_sheaves) {
-			err = -ENOMEM;
-			goto out;
-		}
+	s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
+	if (!s->cpu_sheaves) {
+		err = -ENOMEM;
+		goto out;
 	}
 
 #ifdef CONFIG_NUMA
@@ -8665,11 +8712,9 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 	if (!alloc_kmem_cache_cpus(s))
 		goto out;
 
-	if (s->cpu_sheaves) {
-		err = init_percpu_sheaves(s);
-		if (err)
-			goto out;
-	}
+	err = init_percpu_sheaves(s);
+	if (err)
+		goto out;
 
 	err = 0;
 

-- 
2.52.0


