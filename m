Return-Path: <bpf+bounces-71916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCD7C0198A
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 15:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A56A3B0B7D
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6138E32C955;
	Thu, 23 Oct 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wqZuf521";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CnYeHNMj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cByGnC2S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YD2XioWV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CC232BF4C
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227608; cv=none; b=Ln26OCi7hhgdRjx/V7QCA9Z+fVVvxfLzBm0O37dqnV18fliA3vLYPHzltp8UFU3f7yuPOQRLnlRQd7cNaMLRxr8HiVnqMbE6oZaT8/7TCuWWoyBlyVhf9Y7SkHc1bAIfyIs3XHVUFpV+tBY8XwzuDLDhULfDv3lG1IvFTUa/cr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227608; c=relaxed/simple;
	bh=J+mNa8aMmKgcu5wNPXLxWNSAcuTapQyzGPwQdplEi7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3r+goF2x6qO/NASZ0TWbG+li/w6/9S4HIFJ2J+pE2hlsKifrt+ImNoXFup0RygAI7+fumEr/OmGWiR7B4w7dtb0nNAAItERsncpjCAbhiRwbLG55eORXBAz1mKJPAtCa8WW5wxKhQYW3GM3mTRbWFUCF1NtVyG24U1/re6jOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wqZuf521; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CnYeHNMj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cByGnC2S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YD2XioWV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A2011F7E2;
	Thu, 23 Oct 2025 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761227577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdXDD3/ZApJgGZ00uKWLh+CAcEIa/UY+x34vKoVNPc8=;
	b=wqZuf521dhBUSe+PUBx5cFjW0EwNwJ09LrbM/jktq5YHqpOLnp+mhM6lSq/rq2o5FOJ2MW
	sorgz8blp0znWqoZfvlkKYcB2kjPyDLm0LjWK1x4w15RN+JEReXLwUjAedi4TFv1kfO4AS
	w6kNaPq61VzY0A6++uSdhetdNNLJtnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761227577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdXDD3/ZApJgGZ00uKWLh+CAcEIa/UY+x34vKoVNPc8=;
	b=CnYeHNMjlFQL7+/DQKpWMg0TtyCTAOWISIgwHjfphP18Y0wo43Rh/50FTu2drTTDthhQQ/
	PlUpuLQ2A7PqPwAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761227573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdXDD3/ZApJgGZ00uKWLh+CAcEIa/UY+x34vKoVNPc8=;
	b=cByGnC2SYolBTRDYP8LS+IpQD1Eji+sWPYqwG9A7uyT2WYWd6uF4ocy1PBoEU2twgSQF3F
	po19jPfCxukL6MloV/Hb7HvbDv3zwlHggPvg+lsQjKntGDG3IooxXV8xRzqBWw0DfRZY0o
	ZdMcKD+AS5LAdkwznTDzrjwN+w9yVO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761227573;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fdXDD3/ZApJgGZ00uKWLh+CAcEIa/UY+x34vKoVNPc8=;
	b=YD2XioWV/+tzIWCxj8BZXcvzFXDMaQOhyZIP1OrCHhNrqg2jVi0Z5PnAZ1jSf3E020PTTA
	OlHX/cLWXNnc99Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3099A13AAB;
	Thu, 23 Oct 2025 13:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yIGWCzUz+mjvQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Oct 2025 13:52:53 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Oct 2025 15:52:24 +0200
Subject: [PATCH RFC 02/19] slab: handle pfmemalloc slabs properly with
 sheaves
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sheaves-for-all-v1-2-6ffa2c9941c0@suse.cz>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -8.30

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
 mm/slub.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 4731b9e461c2..ab03f29dc3bf 100644
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
@@ -2645,7 +2648,7 @@ static struct slab_sheaf *alloc_full_sheaf(struct kmem_cache *s, gfp_t gfp)
 	if (!sheaf)
 		return NULL;
 
-	if (refill_sheaf(s, sheaf, gfp)) {
+	if (refill_sheaf(s, sheaf, gfp | __GFP_NOMEMALLOC)) {
 		free_empty_sheaf(s, sheaf);
 		return NULL;
 	}
@@ -2723,12 +2726,13 @@ static void sheaf_flush_unused(struct kmem_cache *s, struct slab_sheaf *sheaf)
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
@@ -2741,8 +2745,13 @@ static void __rcu_free_sheaf_prepare(struct kmem_cache *s,
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
@@ -5031,7 +5040,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 
 	if (empty) {
-		if (!refill_sheaf(s, empty, gfp)) {
+		if (!refill_sheaf(s, empty, gfp | __GFP_NOMEMALLOC)) {
 			full = empty;
 		} else {
 			/*
@@ -5331,6 +5340,26 @@ void *kmem_cache_alloc_node_noprof(struct kmem_cache *s, gfp_t gfpflags, int nod
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
@@ -5401,17 +5430,18 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
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
 
@@ -5431,7 +5461,8 @@ void kmem_cache_return_sheaf(struct kmem_cache *s, gfp_t gfp,
 	struct slub_percpu_sheaves *pcs;
 	struct node_barn *barn;
 
-	if (unlikely(sheaf->capacity != s->sheaf_capacity)) {
+	if (unlikely((sheaf->capacity != s->sheaf_capacity)
+		     || sheaf->pfmemalloc)) {
 		sheaf_flush_unused(s, sheaf);
 		kfree(sheaf);
 		return;
@@ -5497,7 +5528,7 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
 
 	if (likely(sheaf->capacity >= size)) {
 		if (likely(sheaf->capacity == s->sheaf_capacity))
-			return refill_sheaf(s, sheaf, gfp);
+			return __prefill_sheaf_pfmemalloc(s, sheaf, gfp);
 
 		if (!__kmem_cache_alloc_bulk(s, gfp, sheaf->capacity - sheaf->size,
 					     &sheaf->objects[sheaf->size])) {
@@ -6177,8 +6208,12 @@ static void rcu_free_sheaf(struct rcu_head *head)
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
@@ -6333,7 +6368,8 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 			continue;
 		}
 
-		if (unlikely(IS_ENABLED(CONFIG_NUMA) && slab_nid(slab) != node)) {
+		if (unlikely((IS_ENABLED(CONFIG_NUMA) && slab_nid(slab) != node)
+			     || slab_test_pfmemalloc(slab))) {
 			remote_objects[remote_nr] = p[i];
 			p[i] = p[--size];
 			if (++remote_nr >= PCS_BATCH_MAX)
@@ -6631,7 +6667,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
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


