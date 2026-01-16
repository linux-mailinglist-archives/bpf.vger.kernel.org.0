Return-Path: <bpf+bounces-79280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0989CD32D98
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0C4230F6E19
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF7E3A0B27;
	Fri, 16 Jan 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuCIu3ap";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GRQGqbgi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuCIu3ap";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GRQGqbgi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6A93A0B0D
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574498; cv=none; b=lr0jwk2hR0C+m0TAiISE3u5UYQWwToM50kIWlc8wsDkRqOYn7i4s8p75zOD839J9jDneGVQNjKdFhxXpb/6bSVjpmGa7mwD86CySesXzprhgGnGi4vxXyIt6CCXYwinQQQhVA8gcvIYPf/Y4X4g555n+E2+lierTkG+Ki44cHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574498; c=relaxed/simple;
	bh=OZt7mFajIWiHXtdCvtybQpuB06VYcCjCacipyNlTOuU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YHcnv4yN7Ia4Z8bxG5CERExahXuY6IuVLjBm+Jv2hNTNUemZ6jKHasciupUAbnGesY5pJ4T1R+50DdP1gO2nF1/hcQ0GDiVs6ksHBW7kzumRlMtNJsMBBOtKJe0heOR7KKylbdKhr6VFspZ0IZJauyZnjwrAinDtu9XzSmUh8IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuCIu3ap; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GRQGqbgi; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuCIu3ap; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GRQGqbgi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D2084337F9;
	Fri, 16 Jan 2026 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+NEFIplY8DiruHyzDBaJMFyS25WmDkj2WChHn+qGs4=;
	b=WuCIu3apgSVntSTEEf8koMFIhlGUfXgJEmxgOlvxmkgN4ACRinhGxEGxht1l/F712YlnXU
	BdJX2f7bdn9VjD61mjH/yZaQZ8b+j/sRXgRz7wntEu2JF2hYTquSEqRa70H14fPvCbxlTY
	Ah8Kz3SWPA1e6Dt4xNEisREgAvWn+CI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+NEFIplY8DiruHyzDBaJMFyS25WmDkj2WChHn+qGs4=;
	b=GRQGqbgibHpEFDy7NmeUyKUqCwm6wHmZB6tx4jz8ux2Lm768+wPosB29A1x9L6Az84e8WC
	K4NGtiAdzrqGxqBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WuCIu3ap;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GRQGqbgi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+NEFIplY8DiruHyzDBaJMFyS25WmDkj2WChHn+qGs4=;
	b=WuCIu3apgSVntSTEEf8koMFIhlGUfXgJEmxgOlvxmkgN4ACRinhGxEGxht1l/F712YlnXU
	BdJX2f7bdn9VjD61mjH/yZaQZ8b+j/sRXgRz7wntEu2JF2hYTquSEqRa70H14fPvCbxlTY
	Ah8Kz3SWPA1e6Dt4xNEisREgAvWn+CI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s+NEFIplY8DiruHyzDBaJMFyS25WmDkj2WChHn+qGs4=;
	b=GRQGqbgibHpEFDy7NmeUyKUqCwm6wHmZB6tx4jz8ux2Lm768+wPosB29A1x9L6Az84e8WC
	K4NGtiAdzrqGxqBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4ADB3EA65;
	Fri, 16 Jan 2026 14:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wB3TK+VNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:37 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:31 +0100
Subject: [PATCH v3 11/21] slab: remove SLUB_CPU_PARTIAL
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-11-5595cb000772@suse.cz>
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
In-Reply-To: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
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
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D2084337F9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

We have removed the partial slab usage from allocation paths. Now remove
the whole config option and associated code.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/Kconfig |  11 ---
 mm/slab.h  |  29 ------
 mm/slub.c  | 321 ++++---------------------------------------------------------
 3 files changed, 19 insertions(+), 342 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index bd0ea5454af8..08593674cd20 100644
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
index cb48ce5014ba..e77260720994 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -77,12 +77,6 @@ struct slab {
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
 			struct freelist_counters;
@@ -188,23 +182,6 @@ static inline size_t slab_size(const struct slab *slab)
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
@@ -228,12 +205,6 @@ struct kmem_cache {
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
index 698c0d940f06..6b1280f7900a 100644
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
@@ -426,9 +417,6 @@ struct freelist_tid {
 struct kmem_cache_cpu {
 	struct freelist_tid;
 	struct slab *slab;	/* The slab from which we are allocating */
-#ifdef CONFIG_SLUB_CPU_PARTIAL
-	struct slab *partial;	/* Partially allocated slabs */
-#endif
 	local_trylock_t lock;	/* Protects the fields above */
 #ifdef CONFIG_SLUB_STATS
 	unsigned int stat[NR_SLUB_STAT_ITEMS];
@@ -673,29 +661,6 @@ static inline unsigned int oo_objects(struct kmem_cache_order_objects x)
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
@@ -3474,12 +3439,6 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
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
@@ -3898,131 +3857,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
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
@@ -4060,8 +3894,6 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 		deactivate_slab(s, slab, freelist);
 		stat(s, CPUSLAB_FLUSH);
 	}
-
-	put_partials_cpu(s, c);
 }
 
 static inline void flush_this_cpu_slab(struct kmem_cache *s)
@@ -4070,15 +3902,13 @@ static inline void flush_this_cpu_slab(struct kmem_cache *s)
 
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
@@ -5646,13 +5476,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		return;
 	}
 
-	/*
-	 * It is enough to test IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) below
-	 * instead of kmem_cache_has_cpu_partial(s), because kmem_cache_debug(s)
-	 * is the only other reason it can be false, and it is already handled
-	 * above.
-	 */
-
 	do {
 		if (unlikely(n)) {
 			spin_unlock_irqrestore(&n->list_lock, flags);
@@ -5677,26 +5500,19 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		 * Unless it's frozen.
 		 */
 		if ((!new.inuse || was_full) && !was_frozen) {
+
+			n = get_node(s, slab_nid(slab));
 			/*
-			 * If slab becomes non-full and we have cpu partial
-			 * lists, we put it there unconditionally to avoid
-			 * taking the list_lock. Otherwise we need it.
+			 * Speculatively acquire the list_lock.
+			 * If the cmpxchg does not succeed then we may
+			 * drop the list_lock without any processing.
+			 *
+			 * Otherwise the list_lock will synchronize with
+			 * other processors updating the list of slabs.
 			 */
-			if (!(IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full)) {
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
+			spin_lock_irqsave(&n->list_lock, flags);
+
+			on_node_partial = slab_test_node_partial(slab);
 		}
 
 	} while (!slab_update_freelist(s, slab, &old, &new, "__slab_free"));
@@ -5709,13 +5525,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			 * activity can be necessary.
 			 */
 			stat(s, FREE_FROZEN);
-		} else if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full) {
-			/*
-			 * If we started with a full slab then put it onto the
-			 * per cpu partial list.
-			 */
-			put_cpu_partial(s, slab, 1);
-			stat(s, CPU_PARTIAL_FREE);
 		}
 
 		/*
@@ -5744,10 +5553,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 
 	/*
 	 * Objects left in the slab. If it was not on the partial list before
-	 * then add it. This can only happen when cache has no per cpu partial
-	 * list otherwise we would have put it there.
+	 * then add it.
 	 */
-	if (!IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && unlikely(was_full)) {
+	if (unlikely(was_full)) {
 		add_partial(n, slab, DEACTIVATE_TO_TAIL);
 		stat(s, FREE_ADD_PARTIAL);
 	}
@@ -6396,8 +6204,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
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
@@ -7707,39 +7515,6 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
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
 
@@ -8595,8 +8370,6 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 	s->min_partial = min_t(unsigned long, MAX_PARTIAL, ilog2(s->size) / 2);
 	s->min_partial = max_t(unsigned long, MIN_PARTIAL, s->min_partial);
 
-	set_cpu_partial(s);
-
 	s->cpu_sheaves = alloc_percpu(struct slub_percpu_sheaves);
 	if (!s->cpu_sheaves) {
 		err = -ENOMEM;
@@ -8960,20 +8733,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
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
 
@@ -9108,12 +8867,7 @@ SLAB_ATTR(min_partial);
 
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
@@ -9125,11 +8879,9 @@ static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
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
@@ -9168,42 +8920,7 @@ SLAB_ATTR_RO(objects_partial);
 
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
2.52.0


