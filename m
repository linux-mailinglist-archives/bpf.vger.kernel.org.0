Return-Path: <bpf+bounces-71908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A018C01930
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F6F3B055B
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91618315D4F;
	Thu, 23 Oct 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JNhOt4Mr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h8AklegF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0D9306B0F
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227581; cv=none; b=FXjR3/0h93bwAwvQlXkrFsSXcUPSk+nhPMsyckf7SHzZCRaIVef+AorRtSX9CNr1mVaBn1fhKY0XvEf6ScFscqx+G7KmpeFDq0yS1lAWIcJ8HHESVgvnCRLKxSIagmHUpQe2EONApY/bUOBqTw57huqFbrCmXX+J4zrTz/XVRxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227581; c=relaxed/simple;
	bh=9Tn+1mXRg2I2ExUElS6ibjq/SLwa0MrC4jQWEkqJCsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Eal8MOInc+ISvDunUH+Q0bknykxSjSFdesfpuIX0PvzkggUdmrSv1npWLh/zaD4lg6LWx+lruEnhGd1dZUhWquHvteN4CzZXtw4FsR17cLMkOv6+NHaTIh+js0DhPmvpZ6BeVG5n6X4Xqg53MLSTiJnHtLX+sFyxMLCZ02UrMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JNhOt4Mr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h8AklegF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67B0B1F7E5;
	Thu, 23 Oct 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761227573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwO+ywC/2qNyrdzTEnXXbwTudyXSN4BHY9D8LplJsaM=;
	b=JNhOt4MrW/r4AHKbxbNBxMY252YT69WdoS5qlcZ98vDein1GymZZC/OkvC1cX3BhqI9wET
	jmLrHWTVps8FR4oQTgiGCkeh5OS4yzsyuRzCjlOI8ZXP6yqz899skfZ/NkFH+3yOuO+Fts
	zt4BvG/cbhtZF1g/gdwWsEdS5lDNUuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761227573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QwO+ywC/2qNyrdzTEnXXbwTudyXSN4BHY9D8LplJsaM=;
	b=h8AklegFTOmVDSiZshRItoNehLZvS5hrrsunxLyHas1HC89CFJt15BLTFIoFjiRJwdBSfE
	Bb7kDe2fvyKpeYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A26513AAC;
	Thu, 23 Oct 2025 13:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gMrQETUz+mjvQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Oct 2025 13:52:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Oct 2025 15:52:25 +0200
Subject: [PATCH RFC 03/19] slub: remove CONFIG_SLUB_TINY specific code
 paths
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sheaves-for-all-v1-3-6ffa2c9941c0@suse.cz>
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
X-Rspamd-Queue-Id: 67B0B1F7E5
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

CONFIG_SLUB_TINY minimizes the SLUB's memory overhead in multiple ways,
mainly by avoiding percpu caching of slabs and objects. It also reduces
code size by replacing some code paths with simplified ones through
ifdefs, but the benefits of that are smaller and would complicate the
upcoming changes.

Thus remove these code paths and associated ifdefs and simplify the code
base.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h |   2 --
 mm/slub.c | 107 +++-----------------------------------------------------------
 2 files changed, 4 insertions(+), 105 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 078daecc7cf5..f7b8df56727d 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -236,10 +236,8 @@ struct kmem_cache_order_objects {
  * Slab cache management.
  */
 struct kmem_cache {
-#ifndef CONFIG_SLUB_TINY
 	struct kmem_cache_cpu __percpu *cpu_slab;
 	struct lock_class_key lock_key;
-#endif
 	struct slub_percpu_sheaves __percpu *cpu_sheaves;
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
diff --git a/mm/slub.c b/mm/slub.c
index ab03f29dc3bf..68867cd52c4f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -410,7 +410,6 @@ enum stat_item {
 	NR_SLUB_STAT_ITEMS
 };
 
-#ifndef CONFIG_SLUB_TINY
 /*
  * When changing the layout, make sure freelist and tid are still compatible
  * with this_cpu_cmpxchg_double() alignment requirements.
@@ -432,7 +431,6 @@ struct kmem_cache_cpu {
 	unsigned int stat[NR_SLUB_STAT_ITEMS];
 #endif
 };
-#endif /* CONFIG_SLUB_TINY */
 
 static inline void stat(const struct kmem_cache *s, enum stat_item si)
 {
@@ -597,12 +595,10 @@ static inline void *get_freepointer(struct kmem_cache *s, void *object)
 	return freelist_ptr_decode(s, p, ptr_addr);
 }
 
-#ifndef CONFIG_SLUB_TINY
 static void prefetch_freepointer(const struct kmem_cache *s, void *object)
 {
 	prefetchw(object + s->offset);
 }
-#endif
 
 /*
  * When running under KMSAN, get_freepointer_safe() may return an uninitialized
@@ -714,10 +710,12 @@ static inline unsigned int slub_get_cpu_partial(struct kmem_cache *s)
 	return s->cpu_partial_slabs;
 }
 #else
+#ifdef SLAB_SUPPORTS_SYSFS
 static inline void
 slub_set_cpu_partial(struct kmem_cache *s, unsigned int nr_objects)
 {
 }
+#endif
 
 static inline unsigned int slub_get_cpu_partial(struct kmem_cache *s)
 {
@@ -2026,13 +2024,11 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
-#ifndef CONFIG_SLUB_TINY
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 			       void **freelist, void *nextfree)
 {
 	return false;
 }
-#endif
 #endif /* CONFIG_SLUB_DEBUG */
 
 #ifdef CONFIG_SLAB_OBJ_EXT
@@ -3617,8 +3613,6 @@ static struct slab *get_partial(struct kmem_cache *s, int node,
 	return get_any_partial(s, pc);
 }
 
-#ifndef CONFIG_SLUB_TINY
-
 #ifdef CONFIG_PREEMPTION
 /*
  * Calculate the next globally unique transaction for disambiguation
@@ -4018,12 +4012,6 @@ static bool has_cpu_slab(int cpu, struct kmem_cache *s)
 	return c->slab || slub_percpu_partial(c);
 }
 
-#else /* CONFIG_SLUB_TINY */
-static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu) { }
-static inline bool has_cpu_slab(int cpu, struct kmem_cache *s) { return false; }
-static inline void flush_this_cpu_slab(struct kmem_cache *s) { }
-#endif /* CONFIG_SLUB_TINY */
-
 static bool has_pcs_used(int cpu, struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
@@ -4364,7 +4352,6 @@ static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags)
 	return true;
 }
 
-#ifndef CONFIG_SLUB_TINY
 static inline bool
 __update_cpu_freelist_fast(struct kmem_cache *s,
 			   void *freelist_old, void *freelist_new,
@@ -4628,7 +4615,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	pc.orig_size = orig_size;
 	slab = get_partial(s, node, &pc);
 	if (slab) {
-		if (kmem_cache_debug(s)) {
+		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
 			freelist = pc.object;
 			/*
 			 * For debug caches here we had to go through
@@ -4666,7 +4653,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	stat(s, ALLOC_SLAB);
 
-	if (kmem_cache_debug(s)) {
+	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
 		freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
 
 		if (unlikely(!freelist))
@@ -4874,32 +4861,6 @@ static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
 
 	return object;
 }
-#else /* CONFIG_SLUB_TINY */
-static void *__slab_alloc_node(struct kmem_cache *s,
-		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
-{
-	struct partial_context pc;
-	struct slab *slab;
-	void *object;
-
-	pc.flags = gfpflags;
-	pc.orig_size = orig_size;
-	slab = get_partial(s, node, &pc);
-
-	if (slab)
-		return pc.object;
-
-	slab = new_slab(s, gfpflags, node);
-	if (unlikely(!slab)) {
-		slab_out_of_memory(s, gfpflags, node);
-		return NULL;
-	}
-
-	object = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
-
-	return object;
-}
-#endif /* CONFIG_SLUB_TINY */
 
 /*
  * If the object has been wiped upon free, make sure it's fully initialized by
@@ -5746,9 +5707,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 	 * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
 	 * In this case fast path with __update_cpu_freelist_fast() is not safe.
 	 */
-#ifndef CONFIG_SLUB_TINY
 	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
-#endif
 		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
 
 	if (PTR_ERR(ret) == -EBUSY) {
@@ -6511,14 +6470,10 @@ static void free_deferred_objects(struct irq_work *work)
 	llist_for_each_safe(pos, t, llnode) {
 		struct slab *slab = container_of(pos, struct slab, llnode);
 
-#ifdef CONFIG_SLUB_TINY
-		free_slab(slab->slab_cache, slab);
-#else
 		if (slab->frozen)
 			deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
 		else
 			free_slab(slab->slab_cache, slab);
-#endif
 	}
 }
 
@@ -6554,7 +6509,6 @@ void defer_free_barrier(void)
 		irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
 }
 
-#ifndef CONFIG_SLUB_TINY
 /*
  * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
  * can perform fastpath freeing without additional function calls.
@@ -6647,14 +6601,6 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	}
 	stat_add(s, FREE_FASTPATH, cnt);
 }
-#else /* CONFIG_SLUB_TINY */
-static void do_slab_free(struct kmem_cache *s,
-				struct slab *slab, void *head, void *tail,
-				int cnt, unsigned long addr)
-{
-	__slab_free(s, slab, head, tail, cnt, addr);
-}
-#endif /* CONFIG_SLUB_TINY */
 
 static __fastpath_inline
 void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
@@ -6932,11 +6878,7 @@ void kfree_nolock(const void *object)
 	 * since kasan quarantine takes locks and not supported from NMI.
 	 */
 	kasan_slab_free(s, x, false, false, /* skip quarantine */true);
-#ifndef CONFIG_SLUB_TINY
 	do_slab_free(s, slab, x, x, 0, _RET_IP_);
-#else
-	defer_free(s, x);
-#endif
 }
 EXPORT_SYMBOL_GPL(kfree_nolock);
 
@@ -7386,7 +7328,6 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 }
 EXPORT_SYMBOL(kmem_cache_free_bulk);
 
-#ifndef CONFIG_SLUB_TINY
 static inline
 int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 			    void **p)
@@ -7451,35 +7392,6 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 	return 0;
 
 }
-#else /* CONFIG_SLUB_TINY */
-static int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags,
-				   size_t size, void **p)
-{
-	int i;
-
-	for (i = 0; i < size; i++) {
-		void *object = kfence_alloc(s, s->object_size, flags);
-
-		if (unlikely(object)) {
-			p[i] = object;
-			continue;
-		}
-
-		p[i] = __slab_alloc_node(s, flags, NUMA_NO_NODE,
-					 _RET_IP_, s->object_size);
-		if (unlikely(!p[i]))
-			goto error;
-
-		maybe_wipe_obj_freeptr(s, p[i]);
-	}
-
-	return i;
-
-error:
-	__kmem_cache_free_bulk(s, i, p);
-	return 0;
-}
-#endif /* CONFIG_SLUB_TINY */
 
 /* Note that interrupts must be enabled when calling this function. */
 int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
@@ -7698,7 +7610,6 @@ init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
 		barn_init(barn);
 }
 
-#ifndef CONFIG_SLUB_TINY
 static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
 {
 	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
@@ -7719,12 +7630,6 @@ static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
 
 	return 1;
 }
-#else
-static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
-{
-	return 1;
-}
-#endif /* CONFIG_SLUB_TINY */
 
 static int init_percpu_sheaves(struct kmem_cache *s)
 {
@@ -7814,13 +7719,11 @@ void __kmem_cache_release(struct kmem_cache *s)
 	cache_random_seq_destroy(s);
 	if (s->cpu_sheaves)
 		pcs_destroy(s);
-#ifndef CONFIG_SLUB_TINY
 #ifdef CONFIG_PREEMPT_RT
 	if (s->cpu_slab)
 		lockdep_unregister_key(&s->lock_key);
 #endif
 	free_percpu(s->cpu_slab);
-#endif
 	free_kmem_cache_nodes(s);
 }
 
@@ -8563,10 +8466,8 @@ void __init kmem_cache_init(void)
 
 void __init kmem_cache_init_late(void)
 {
-#ifndef CONFIG_SLUB_TINY
 	flushwq = alloc_workqueue("slub_flushwq", WQ_MEM_RECLAIM, 0);
 	WARN_ON(!flushwq);
-#endif
 }
 
 struct kmem_cache *

-- 
2.51.1


