Return-Path: <bpf+bounces-79273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E02D32D02
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61A4F30A4322
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3449397AA2;
	Fri, 16 Jan 2026 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eZQyPLN9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JS727WAF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eZQyPLN9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JS727WAF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754543939D3
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574467; cv=none; b=XyF40V0hnGlN756tCrzGzqSFjjdFFMDAI3MoWnfrF4heIDSGQpajmdV8/lr/k/BISzBGWCdUHQXNUf8p8PPdlft1OseKFFAQ0XEGiolJEa7inANmUUPaeS/JbmbA/ituSGxnZZ1Z/cvDtv9Imq++zj8Rq5n01u68+3kybx1BFkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574467; c=relaxed/simple;
	bh=qG9Aqmhvr3DyVSjSazwM5pz/4y6SlAQOfjzm7YSFeP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vDOgzT5cv70OqjmmGGMBRFMB4oXkTkGo2rIUF4x17UgeR1eaWM3xo5Bv7walP2tmlpYc7bN+kpWUEjaWm3y0PTXD6hdtpWTlm8Tf4F5hChdk72lse0GeYISd+fVtCOqtye1uyfgUf8ieBLsFaeQXVUzM7DXq4OgUyvAUD4VqoDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eZQyPLN9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JS727WAF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eZQyPLN9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JS727WAF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 460AA5BE85;
	Fri, 16 Jan 2026 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/upRfJ3PHSpDAJJ/Lor3pwgQGBiD4JB0EJmftl/mO6A=;
	b=eZQyPLN9DJMcCaE2uxOwagAotWKBSVJboVVCUKS+aR2tp2qaGnF2WMG8/r0qjet7ZkZyHu
	rRKltn6v/KzG9DoYnXOOg8MPNciFeEEtseWtH+97WkVmIIOB+v0ViasUWqZyG2GEZRCiDe
	dD+JxE02TSMHvJIOBWQSQHoHMOIBqUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/upRfJ3PHSpDAJJ/Lor3pwgQGBiD4JB0EJmftl/mO6A=;
	b=JS727WAFeDyGguz7UNeWsDT9YbFz4mhTxOowAOC5XhsXk3Lm/9DWnjramaz1fYa8uIjKc4
	cNVSE1CiWnsvTwDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eZQyPLN9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JS727WAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/upRfJ3PHSpDAJJ/Lor3pwgQGBiD4JB0EJmftl/mO6A=;
	b=eZQyPLN9DJMcCaE2uxOwagAotWKBSVJboVVCUKS+aR2tp2qaGnF2WMG8/r0qjet7ZkZyHu
	rRKltn6v/KzG9DoYnXOOg8MPNciFeEEtseWtH+97WkVmIIOB+v0ViasUWqZyG2GEZRCiDe
	dD+JxE02TSMHvJIOBWQSQHoHMOIBqUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/upRfJ3PHSpDAJJ/Lor3pwgQGBiD4JB0EJmftl/mO6A=;
	b=JS727WAFeDyGguz7UNeWsDT9YbFz4mhTxOowAOC5XhsXk3Lm/9DWnjramaz1fYa8uIjKc4
	cNVSE1CiWnsvTwDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27AF03EA66;
	Fri, 16 Jan 2026 14:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cDlrCeVNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:37 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:26 +0100
Subject: [PATCH v3 06/21] slab: introduce percpu sheaves bootstrap
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-6-5595cb000772@suse.cz>
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 460AA5BE85
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
sheaves enabled. Since we want to enable them for almost all caches,
it's suboptimal to test the pointer in the fast paths, so instead
allocate it for all caches in do_kmem_cache_create(). Instead of testing
the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
kmem_cache->sheaf_capacity for being 0, where needed, using a new
cache_has_sheaves() helper.

However, for the fast paths sake we also assume that the main sheaf
always exists (pcs->main is !NULL), and during bootstrap we cannot
allocate sheaves yet.

Solve this by introducing a single static bootstrap_sheaf that's
assigned as pcs->main during bootstrap. It has a size of 0, so during
allocations, the fast path will find it's empty. Since the size of 0
matches sheaf_capacity of 0, the freeing fast paths will find it's
"full". In the slow path handlers, we use cache_has_sheaves() to
recognize that the cache doesn't (yet) have real sheaves, and fall back.
Thus sharing the single bootstrap sheaf like this for multiple caches
and cpus is safe.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 119 ++++++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 38 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index edf341c87e20..706cb6398f05 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -501,6 +501,18 @@ struct kmem_cache_node {
 	struct node_barn *barn;
 };
 
+/*
+ * Every cache has !NULL s->cpu_sheaves but they may point to the
+ * bootstrap_sheaf temporarily during init, or permanently for the boot caches
+ * and caches with debugging enabled, or all caches with CONFIG_SLUB_TINY. This
+ * helper distinguishes whether cache has real non-bootstrap sheaves.
+ */
+static inline bool cache_has_sheaves(struct kmem_cache *s)
+{
+	/* Test CONFIG_SLUB_TINY for code elimination purposes */
+	return !IS_ENABLED(CONFIG_SLUB_TINY) && s->sheaf_capacity;
+}
+
 static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
 {
 	return s->node[node];
@@ -2855,6 +2867,10 @@ static void pcs_destroy(struct kmem_cache *s)
 		if (!pcs->main)
 			continue;
 
+		/* bootstrap or debug caches, it's the bootstrap_sheaf */
+		if (!pcs->main->cache)
+			continue;
+
 		/*
 		 * We have already passed __kmem_cache_shutdown() so everything
 		 * was flushed and there should be no objects allocated from
@@ -4030,7 +4046,7 @@ static bool has_pcs_used(int cpu, struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
 
-	if (!s->cpu_sheaves)
+	if (!cache_has_sheaves(s))
 		return false;
 
 	pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
@@ -4052,7 +4068,7 @@ static void flush_cpu_slab(struct work_struct *w)
 
 	s = sfw->s;
 
-	if (s->cpu_sheaves)
+	if (cache_has_sheaves(s))
 		pcs_flush_all(s);
 
 	flush_this_cpu_slab(s);
@@ -4157,7 +4173,7 @@ void flush_all_rcu_sheaves(void)
 	mutex_lock(&slab_mutex);
 
 	list_for_each_entry(s, &slab_caches, list) {
-		if (!s->cpu_sheaves)
+		if (!cache_has_sheaves(s))
 			continue;
 		flush_rcu_sheaves_on_cache(s);
 	}
@@ -4179,7 +4195,7 @@ static int slub_cpu_dead(unsigned int cpu)
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
 		__flush_cpu_slab(s, cpu);
-		if (s->cpu_sheaves)
+		if (cache_has_sheaves(s))
 			__pcs_flush_all_cpu(s, cpu);
 	}
 	mutex_unlock(&slab_mutex);
@@ -4979,6 +4995,12 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
+	/* Bootstrap or debug cache, back off */
+	if (unlikely(!cache_has_sheaves(s))) {
+		local_unlock(&s->cpu_sheaves->lock);
+		return NULL;
+	}
+
 	if (pcs->spare && pcs->spare->size > 0) {
 		swap(pcs->main, pcs->spare);
 		return pcs;
@@ -5165,6 +5187,11 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		struct slab_sheaf *full;
 		struct node_barn *barn;
 
+		if (unlikely(!cache_has_sheaves(s))) {
+			local_unlock(&s->cpu_sheaves->lock);
+			return allocated;
+		}
+
 		if (pcs->spare && pcs->spare->size > 0) {
 			swap(pcs->main, pcs->spare);
 			goto do_alloc;
@@ -5244,8 +5271,7 @@ static __fastpath_inline void *slab_alloc_node(struct kmem_cache *s, struct list
 	if (unlikely(object))
 		goto out;
 
-	if (s->cpu_sheaves)
-		object = alloc_from_pcs(s, gfpflags, node);
+	object = alloc_from_pcs(s, gfpflags, node);
 
 	if (!object)
 		object = __slab_alloc_node(s, gfpflags, node, addr, orig_size);
@@ -5355,17 +5381,6 @@ kmem_cache_prefill_sheaf(struct kmem_cache *s, gfp_t gfp, unsigned int size)
 
 	if (unlikely(size > s->sheaf_capacity)) {
 
-		/*
-		 * slab_debug disables cpu sheaves intentionally so all
-		 * prefilled sheaves become "oversize" and we give up on
-		 * performance for the debugging. Same with SLUB_TINY.
-		 * Creating a cache without sheaves and then requesting a
-		 * prefilled sheaf is however not expected, so warn.
-		 */
-		WARN_ON_ONCE(s->sheaf_capacity == 0 &&
-			     !IS_ENABLED(CONFIG_SLUB_TINY) &&
-			     !(s->flags & SLAB_DEBUG_FLAGS));
-
 		sheaf = kzalloc(struct_size(sheaf, objects, size), gfp);
 		if (!sheaf)
 			return NULL;
@@ -6082,6 +6097,12 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 restart:
 	lockdep_assert_held(this_cpu_ptr(&s->cpu_sheaves->lock));
 
+	/* Bootstrap or debug cache, back off */
+	if (unlikely(!cache_has_sheaves(s))) {
+		local_unlock(&s->cpu_sheaves->lock);
+		return NULL;
+	}
+
 	barn = get_barn(s);
 	if (!barn) {
 		local_unlock(&s->cpu_sheaves->lock);
@@ -6280,6 +6301,12 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 		struct slab_sheaf *empty;
 		struct node_barn *barn;
 
+		/* Bootstrap or debug cache, fall back */
+		if (unlikely(!cache_has_sheaves(s))) {
+			local_unlock(&s->cpu_sheaves->lock);
+			goto fail;
+		}
+
 		if (pcs->spare && pcs->spare->size == 0) {
 			pcs->rcu_free = pcs->spare;
 			pcs->spare = NULL;
@@ -6674,9 +6701,8 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
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
@@ -7379,7 +7405,7 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 	 * freeing to sheaves is so incompatible with the detached freelist so
 	 * once we go that way, we have to do everything differently
 	 */
-	if (s && s->cpu_sheaves) {
+	if (s && cache_has_sheaves(s)) {
 		free_to_pcs_bulk(s, size, p);
 		return;
 	}
@@ -7490,8 +7516,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 		size--;
 	}
 
-	if (s->cpu_sheaves)
-		i = alloc_from_pcs_bulk(s, size, p);
+	i = alloc_from_pcs_bulk(s, size, p);
 
 	if (i < size) {
 		/*
@@ -7702,6 +7727,7 @@ static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
 
 static int init_percpu_sheaves(struct kmem_cache *s)
 {
+	static struct slab_sheaf bootstrap_sheaf = {};
 	int cpu;
 
 	for_each_possible_cpu(cpu) {
@@ -7711,7 +7737,28 @@ static int init_percpu_sheaves(struct kmem_cache *s)
 
 		local_trylock_init(&pcs->lock);
 
-		pcs->main = alloc_empty_sheaf(s, GFP_KERNEL);
+		/*
+		 * Bootstrap sheaf has zero size so fast-path allocation fails.
+		 * It has also size == s->sheaf_capacity, so fast-path free
+		 * fails. In the slow paths we recognize the situation by
+		 * checking s->sheaf_capacity. This allows fast paths to assume
+		 * s->cpu_sheaves and pcs->main always exists and is valid.
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
@@ -7809,7 +7856,7 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
 			continue;
 		}
 
-		if (s->cpu_sheaves) {
+		if (cache_has_sheaves(s)) {
 			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, node);
 
 			if (!barn)
@@ -8127,7 +8174,7 @@ int __kmem_cache_shutdown(struct kmem_cache *s)
 	flush_all_cpus_locked(s);
 
 	/* we might have rcu sheaves in flight */
-	if (s->cpu_sheaves)
+	if (cache_has_sheaves(s))
 		rcu_barrier();
 
 	/* Attempt to free all objects */
@@ -8439,7 +8486,7 @@ static int slab_mem_going_online_callback(int nid)
 		if (get_node(s, nid))
 			continue;
 
-		if (s->cpu_sheaves) {
+		if (cache_has_sheaves(s)) {
 			barn = kmalloc_node(sizeof(*barn), GFP_KERNEL, nid);
 
 			if (!barn) {
@@ -8647,12 +8694,10 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 
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
@@ -8671,11 +8716,9 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
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


