Return-Path: <bpf+bounces-73602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CC6C34B1B
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BE75619B4
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AAD52FB0B2;
	Wed,  5 Nov 2025 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dRvvKLgY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1NzQGu59";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dRvvKLgY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1NzQGu59"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529022F3C21
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333541; cv=none; b=UY5reYCFeBVWrjDmuTqdA71xpqr93JO0GhViRfaiKG98g6R5tJumU5UFNn/i92mmsJywV3AoZ3XX9DoBtkCiLL+Z/EfPZMyHQuCnPQ5HUQgCqn7yJqX3+h8HzdrkpxVYhZvi4XpVhN/iiHJ4ZPY/EYTqpPxjqqfaKU21XjnA1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333541; c=relaxed/simple;
	bh=kLqKLZtQ+wTu89cgU2I4LR5imgTeJGR72tz/Wbb7urM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=o3qRsqXMczkHWds5J9jzmZjyEHyO9P9dQnmPiRVMsn+CBOnZWUZBWNa63xXWnfmdpKknkD9B2Beq1PJUVT3vlm7TRrwRwLGl3mYLbrptYTwODfID3SnXP03s1MuWfKQ62o/DiqvjjsPB7jp8oNkZM46vyFbwbMMJXmui1FlLfNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dRvvKLgY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1NzQGu59; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dRvvKLgY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1NzQGu59; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCF9B21193;
	Wed,  5 Nov 2025 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762333530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVqdfrjinTijcg8TfrfGQECaxpdrWMMyTcELwLOOflY=;
	b=dRvvKLgYGTfd/n3M1dFj6+GxTd+NScV+vYHpylekGIYZcBLNjg/XfoL8xaa3nbx3hYxrqO
	SkhthjfMSKpKkGZkyS0vjzTLoRYcAXpSjc9FtNWtyXM2w+dYdL3G0Q65uJfJ8erXDaz/8N
	RlAB3GlKVXoufpmp5E2og5oBgyIDq/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762333530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVqdfrjinTijcg8TfrfGQECaxpdrWMMyTcELwLOOflY=;
	b=1NzQGu59u/7ZxRzwVyaZG9DTNHQteJfJjumnVC7Yd0iBtAHohH+7ncrCCJghTB2JqSsAch
	zWnZcE5Od9QwF7CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762333530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVqdfrjinTijcg8TfrfGQECaxpdrWMMyTcELwLOOflY=;
	b=dRvvKLgYGTfd/n3M1dFj6+GxTd+NScV+vYHpylekGIYZcBLNjg/XfoL8xaa3nbx3hYxrqO
	SkhthjfMSKpKkGZkyS0vjzTLoRYcAXpSjc9FtNWtyXM2w+dYdL3G0Q65uJfJ8erXDaz/8N
	RlAB3GlKVXoufpmp5E2og5oBgyIDq/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762333530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVqdfrjinTijcg8TfrfGQECaxpdrWMMyTcELwLOOflY=;
	b=1NzQGu59u/7ZxRzwVyaZG9DTNHQteJfJjumnVC7Yd0iBtAHohH+7ncrCCJghTB2JqSsAch
	zWnZcE5Od9QwF7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B303613ADD;
	Wed,  5 Nov 2025 09:05:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iKJyK1oTC2lSBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Nov 2025 09:05:30 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 05 Nov 2025 10:05:31 +0100
Subject: [PATCH 3/5] slab: handle pfmemalloc slabs properly with sheaves
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-sheaves-cleanups-v1-3-b8218e1ac7ef@suse.cz>
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
In-Reply-To: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 kasan-dev@googlegroups.com, Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.14.3
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

When a pfmemalloc allocation actually dips into reserves, the slab is
marked accordingly and non-pfmemalloc allocations should not be allowed
to allocate from it. The sheaves percpu caching currently doesn't follow
this rule, so implement it before we expand sheaves usage to all caches.

Make sure objects from pfmemalloc slabs don't end up in percpu sheaves.
When freeing, skip sheaves when freeing an object from pfmemalloc slab.
When refilling sheaves, use __GFP_NOMEMALLOC to override any pfmemalloc
context - the allocation will fallback to regular slab allocations when
sheaves are depleted and can't be refilled because of the override.

For kfree_rcu(), detect pfmemalloc slabs after processing the rcu_sheaf
after the grace period in __rcu_free_sheaf_prepare() and simply flush
it if any object is from pfmemalloc slabs.

For prefilled sheaves, try to refill them first with __GFP_NOMEMALLOC
and if it fails, retry without __GFP_NOMEMALLOC but then mark the sheaf
pfmemalloc, which makes it flushed back to slabs when returned.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0237a329d4e5..bb744e8044f0 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -469,7 +469,10 @@ struct slab_sheaf {
 		struct rcu_head rcu_head;
 		struct list_head barn_list;
 		/* only used for prefilled sheafs */
-		unsigned int capacity;
+		struct {
+			unsigned int capacity;
+			bool pfmemalloc;
+		};
 	};
 	struct kmem_cache *cache;
 	unsigned int size;
@@ -2651,7 +2654,7 @@ static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 	if (!sheaf)
 		return NULL;
 
-	if (refill_sheaf(s, sheaf, gfp)) {
+	if (refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC)) {
 		free_empty_sheaf(s, sheaf);
 		return NULL;
 	}
@@ -2729,12 +2732,13 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
 	sheaf->size = 0;
 }
 
-static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
+static bool __rcu_free_sheaf_prepare(struct kmem_cache *s,
 				     struct slab_sheaf *sheaf)
 {
 	bool init = slab_want_init_on_free(s);
 	void **p = &sheaf->objects[0];
 	unsigned int i = 0;
+	bool pfmemalloc = false;
 
 	while (i < sheaf->size) {
 		struct slab *slab = virt_to_slab(p[i]);
@@ -2747,8 +2751,13 @@ static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
 			continue;
 		}
 
+		if (slab_test_pfmemalloc(slab))
+			pfmemalloc = true;
+
 		i++;
 	}
+
+	return pfmemalloc;
 }
 
 static void rcu_free_sheaf_nobarn(struct rcu_head *head)
@@ -5041,7 +5050,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 
 	if (empty) {
-		if (!refill_sheaf(s, empty, gfp)) {
+		if (!refill_sheaf(s, empty, gfp | __GFP_NOMEMALLOC)) {
 			full = empty;
 		} else {
 			/*
@@ -5341,6 +5350,26 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int nod
 }
 EXPORT_SYMBOL(kmem_cache_alloc_node_noprof);
 
+static int __prefill_sheaf_pfmemalloc(struct kmem_cache *s,
+				      struct slab_sheaf *sheaf, gfp_t gfp)
+{
+	int ret = 0;
+
+	ret = refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC);
+
+	if (likely(!ret || !gfp_pfmemalloc_allowed(gfp)))
+		return ret;
+
+	/*
+	 * if we are allowed to, refill sheaf with pfmemalloc but then remember
+	 * it for when it's returned
+	 */
+	ret = refill_sheaf(s, sheaf, gfp);
+	sheaf->pfmemalloc = true;
+
+	return ret;
+}
+
 /*
  * returns a sheaf that has at least the requested size
  * when prefilling is needed, do so with given gfp flags
@@ -5375,6 +5404,10 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 		sheaf->cache = s;
 		sheaf->capacity = size;
 
+		/*
+		 * we do not need to care about pfmemalloc here because oversize
+		 * sheaves area always flushed and freed when returned
+		 */
 		if (!__kmem_cache_alloc_bulk(s, gfp, size,
 					     &sheaf->objects[0])) {
 			kfree(sheaf);
@@ -5411,17 +5444,18 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 	if (!sheaf)
 		sheaf = alloc_empty_sheaf(s, gfp);
 
-	if (sheaf && sheaf->size < size) {
-		if (refill_sheaf(s, sheaf, gfp)) {
+	if (sheaf) {
+		sheaf->capacity = s->sheaf_capacity;
+		sheaf->pfmemalloc = false;
+
+		if (sheaf->size < size &&
+		    __prefill_sheaf_pfmemalloc(s, sheaf, gfp)) {
 			sheaf_flush_unused(s, sheaf);
 			free_empty_sheaf(s, sheaf);
 			sheaf = NULL;
 		}
 	}
 
-	if (sheaf)
-		sheaf->capacity = s->sheaf_capacity;
-
 	return sheaf;
 }
 
@@ -5441,7 +5475,8 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
 	struct slub_percpu_sheaves *pcs;
 	struct node_barn *barn;
 
-	if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
+	if (unlikely((sheaf->capacity != s->sheaf_capacity)
+		     || sheaf->pfmemalloc)) {
 		sheaf_flush_unused(s, sheaf);
 		kfree(sheaf);
 		return;
@@ -5507,7 +5542,7 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
 
 	if (likely(sheaf->capacity >= size)) {
 		if (likely(sheaf->capacity == s->sheaf_capacity))
-			return refill_sheaf(s, sheaf, gfp);
+			return __prefill_sheaf_pfmemalloc(s, sheaf, gfp);
 
 		if (!__kmem_cache_alloc_bulk(s, gfp, sheaf->capacity - sheaf->size,
 					     &sheaf->objects[sheaf->size])) {
@@ -6215,8 +6250,12 @@ static void rcu_free_sheaf(struct rcu_head *head)
 	 * handles it fine. The only downside is that sheaf will serve fewer
 	 * allocations when reused. It only happens due to debugging, which is a
 	 * performance hit anyway.
+	 *
+	 * If it returns true, there was at least one object from pfmemalloc
+	 * slab so simply flush everything.
 	 */
-	__rcu_free_sheaf_prepare(s, sheaf);
+	if (__rcu_free_sheaf_prepare(s, sheaf))
+		goto flush;
 
 	n = get_node(s, sheaf->node);
 	if (!n)
@@ -6371,7 +6410,8 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 			continue;
 		}
 
-		if (unlikely(IS_ENABLED(CONFIG_NUMA) && slab_nid(slab) != node)) {
+		if (unlikely((IS_ENABLED(CONFIG_NUMA) && slab_nid(slab) != node)
+			     || slab_test_pfmemalloc(slab))) {
 			remote_objects[remote_nr] = p[i];
 			p[i] = p[--size];
 			if (++remote_nr >= PCS_BATCH_MAX)
@@ -6669,7 +6709,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 		return;
 
 	if (s->cpu_sheaves && likely(!IS_ENABLED(CONFIG_NUMA) ||
-				     slab_nid(slab) == numa_mem_id())) {
+				     slab_nid(slab) == numa_mem_id())
+			   && likely(!slab_test_pfmemalloc(slab))) {
 		if (likely(free_to_pcs(s, object)))
 			return;
 	}

-- 
2.51.1


