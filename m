Return-Path: <bpf+bounces-79275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 805B9D32D41
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F6D130C7C60
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767E3399028;
	Fri, 16 Jan 2026 14:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eBUInVZl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AcF4CfXc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eBUInVZl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AcF4CfXc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75C397ABF
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574476; cv=none; b=rSs4fecGRfQ5X6V8R+nEedOxhcGv2dSvq5oXEMtVZ/jhOee39fzJSNoLogNVBtMs4lhvSQJXOLCHJJrhUxkG8FhMUpN6WaqpQNr1vYMYPyvVMU/7dU1iLKkM7dj4BpdsCblBhq2GjB2QUIsyi9/PvAfwf+nfbYlR+G787dYbF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574476; c=relaxed/simple;
	bh=LqQYNqivwwLHtNDgUflGkN82pSucfwQtwJtz3MJtZE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e4NFgIb5CmzfRkAPOGou8h8Ul5fBQfWWUaP6a8luTwRO706Sao72PrRaWHyFZZIfCXgEsnwT8YfEfo4c1ByYcg57yuHYOwb/Oo5qO/SIfwBQWLuGOPkFaTdovo0LwM39wFy5PC3mr6a80WapCjuICs9liaeuctX0D3ikdXXjSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eBUInVZl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AcF4CfXc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eBUInVZl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AcF4CfXc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 608FB5BE8E;
	Fri, 16 Jan 2026 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yl3tYq1zkCSfFGXX17TFoPzKLhUlXL9wcLcMPsj5qcU=;
	b=eBUInVZlsfM62xCRi9PSa9SInSqzDim8TMFErvNwdWwrb7uIzrIzbRZN7GRRRH5acoDITK
	++BIwcbj3SNh7gdhEAwL9l1AsB7OMB4wmdslYgxzt6lNjnhDXRbzQT5AVAVmAGl+Mvujzu
	HXey/nl7IBmN+4eNAwjRSD7guXQgAsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yl3tYq1zkCSfFGXX17TFoPzKLhUlXL9wcLcMPsj5qcU=;
	b=AcF4CfXcDC9UBWca5o7wS/UAZmw26++7J4KQXT9ZIpgfthYaEyHTFzNEHh0ZU8qHMVJ9PG
	UNz3IvoKmg/DFoDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yl3tYq1zkCSfFGXX17TFoPzKLhUlXL9wcLcMPsj5qcU=;
	b=eBUInVZlsfM62xCRi9PSa9SInSqzDim8TMFErvNwdWwrb7uIzrIzbRZN7GRRRH5acoDITK
	++BIwcbj3SNh7gdhEAwL9l1AsB7OMB4wmdslYgxzt6lNjnhDXRbzQT5AVAVmAGl+Mvujzu
	HXey/nl7IBmN+4eNAwjRSD7guXQgAsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574437;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yl3tYq1zkCSfFGXX17TFoPzKLhUlXL9wcLcMPsj5qcU=;
	b=AcF4CfXcDC9UBWca5o7wS/UAZmw26++7J4KQXT9ZIpgfthYaEyHTFzNEHh0ZU8qHMVJ9PG
	UNz3IvoKmg/DFoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44C6A3EA63;
	Fri, 16 Jan 2026 14:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBFwEOVNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:37 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:27 +0100
Subject: [PATCH v3 07/21] slab: make percpu sheaves compatible with
 kmalloc_nolock()/kfree_nolock()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-7-5595cb000772@suse.cz>
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
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)]
X-Spam-Level: 
X-Spam-Flag: NO

Before we enable percpu sheaves for kmalloc caches, we need to make sure
kmalloc_nolock() and kfree_nolock() will continue working properly and
not spin when not allowed to.

Percpu sheaves themselves use local_trylock() so they are already
compatible. We just need to be careful with the barn->lock spin_lock.
Pass a new allow_spin parameter where necessary to use
spin_trylock_irqsave().

In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
for now it will always fail until we enable sheaves for kmalloc caches
next. Similarly in kfree_nolock() we can attempt free_to_pcs().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 79 ++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 56 insertions(+), 23 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 706cb6398f05..b385247c219f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2893,7 +2893,8 @@ static void pcs_destroy(struct kmem_cache *s)
 	s->cpu_sheaves = NULL;
 }
 
-static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
+static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn,
+					       bool allow_spin)
 {
 	struct slab_sheaf *empty = NULL;
 	unsigned long flags;
@@ -2901,7 +2902,10 @@ static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
 	if (!data_race(barn->nr_empty))
 		return NULL;
 
-	spin_lock_irqsave(&barn->lock, flags);
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
 
 	if (likely(barn->nr_empty)) {
 		empty = list_first_entry(&barn->sheaves_empty,
@@ -2978,7 +2982,8 @@ static struct slab_sheaf *barn_get_full_or_empty_sheaf(struct node_barn *barn)
  * change.
  */
 static struct slab_sheaf *
-barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
+barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty,
+			 bool allow_spin)
 {
 	struct slab_sheaf *full = NULL;
 	unsigned long flags;
@@ -2986,7 +2991,10 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
 	if (!data_race(barn->nr_full))
 		return NULL;
 
-	spin_lock_irqsave(&barn->lock, flags);
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return NULL;
 
 	if (likely(barn->nr_full)) {
 		full = list_first_entry(&barn->sheaves_full, struct slab_sheaf,
@@ -3007,7 +3015,8 @@ barn_replace_empty_sheaf(struct node_barn *barn, struct slab_sheaf *empty)
  * barn. But if there are too many full sheaves, reject this with -E2BIG.
  */
 static struct slab_sheaf *
-barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
+barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full,
+			bool allow_spin)
 {
 	struct slab_sheaf *empty;
 	unsigned long flags;
@@ -3018,7 +3027,10 @@ barn_replace_full_sheaf(struct node_barn *barn, struct slab_sheaf *full)
 	if (!data_race(barn->nr_empty))
 		return ERR_PTR(-ENOMEM);
 
-	spin_lock_irqsave(&barn->lock, flags);
+	if (likely(allow_spin))
+		spin_lock_irqsave(&barn->lock, flags);
+	else if (!spin_trylock_irqsave(&barn->lock, flags))
+		return ERR_PTR(-EBUSY);
 
 	if (likely(barn->nr_empty)) {
 		empty = list_first_entry(&barn->sheaves_empty, struct slab_sheaf,
@@ -5012,7 +5024,8 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 		return NULL;
 	}
 
-	full = barn_replace_empty_sheaf(barn, pcs->main);
+	full = barn_replace_empty_sheaf(barn, pcs->main,
+					gfpflags_allow_spinning(gfp));
 
 	if (full) {
 		stat(s, BARN_GET);
@@ -5029,7 +5042,7 @@ __pcs_replace_empty_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
 			empty = pcs->spare;
 			pcs->spare = NULL;
 		} else {
-			empty = barn_get_empty_sheaf(barn);
+			empty = barn_get_empty_sheaf(barn, true);
 		}
 	}
 
@@ -5169,7 +5182,8 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
 }
 
 static __fastpath_inline
-unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
+unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
+				 void **p)
 {
 	struct slub_percpu_sheaves *pcs;
 	struct slab_sheaf *main;
@@ -5203,7 +5217,8 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 			return allocated;
 		}
 
-		full = barn_replace_empty_sheaf(barn, pcs->main);
+		full = barn_replace_empty_sheaf(barn, pcs->main,
+						gfpflags_allow_spinning(gfp));
 
 		if (full) {
 			stat(s, BARN_GET);
@@ -5701,7 +5716,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
 	struct kmem_cache *s;
 	bool can_retry = true;
-	void *ret = ERR_PTR(-EBUSY);
+	void *ret;
 
 	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO |
 				      __GFP_NO_OBJ_EXT));
@@ -5732,6 +5747,12 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 		 */
 		return NULL;
 
+	ret = alloc_from_pcs(s, alloc_gfp, node);
+	if (ret)
+		goto success;
+
+	ret = ERR_PTR(-EBUSY);
+
 	/*
 	 * Do not call slab_alloc_node(), since trylock mode isn't
 	 * compatible with slab_pre_alloc_hook/should_failslab and
@@ -5768,6 +5789,7 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 		ret = NULL;
 	}
 
+success:
 	maybe_wipe_obj_freeptr(s, ret);
 	slab_post_alloc_hook(s, NULL, alloc_gfp, 1, &ret,
 			     slab_want_init_on_alloc(alloc_gfp, s), size);
@@ -6088,7 +6110,8 @@ static void __pcs_install_empty_sheaf(struct kmem_cache *s,
  * unlocked.
  */
 static struct slub_percpu_sheaves *
-__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
+__pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs,
+			bool allow_spin)
 {
 	struct slab_sheaf *empty;
 	struct node_barn *barn;
@@ -6112,7 +6135,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 	put_fail = false;
 
 	if (!pcs->spare) {
-		empty = barn_get_empty_sheaf(barn);
+		empty = barn_get_empty_sheaf(barn, allow_spin);
 		if (empty) {
 			pcs->spare = pcs->main;
 			pcs->main = empty;
@@ -6126,7 +6149,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 		return pcs;
 	}
 
-	empty = barn_replace_full_sheaf(barn, pcs->main);
+	empty = barn_replace_full_sheaf(barn, pcs->main, allow_spin);
 
 	if (!IS_ERR(empty)) {
 		stat(s, BARN_PUT);
@@ -6134,7 +6157,8 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 		return pcs;
 	}
 
-	if (PTR_ERR(empty) == -E2BIG) {
+	/* sheaf_flush_unused() doesn't support !allow_spin */
+	if (PTR_ERR(empty) == -E2BIG && allow_spin) {
 		/* Since we got here, spare exists and is full */
 		struct slab_sheaf *to_flush = pcs->spare;
 
@@ -6159,6 +6183,14 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
 alloc_empty:
 	local_unlock(&s->cpu_sheaves->lock);
 
+	/*
+	 * alloc_empty_sheaf() doesn't support !allow_spin and it's
+	 * easier to fall back to freeing directly without sheaves
+	 * than add the support (and to sheaf_flush_unused() above)
+	 */
+	if (!allow_spin)
+		return NULL;
+
 	empty = alloc_empty_sheaf(s, GFP_NOWAIT);
 	if (empty)
 		goto got_empty;
@@ -6201,7 +6233,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
  * The object is expected to have passed slab_free_hook() already.
  */
 static __fastpath_inline
-bool free_to_pcs(struct kmem_cache *s, void *object)
+bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
 {
 	struct slub_percpu_sheaves *pcs;
 
@@ -6212,7 +6244,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
 
 	if (unlikely(pcs->main->size == s->sheaf_capacity)) {
 
-		pcs = __pcs_replace_full_main(s, pcs);
+		pcs = __pcs_replace_full_main(s, pcs, allow_spin);
 		if (unlikely(!pcs))
 			return false;
 	}
@@ -6319,7 +6351,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 			goto fail;
 		}
 
-		empty = barn_get_empty_sheaf(barn);
+		empty = barn_get_empty_sheaf(barn, true);
 
 		if (empty) {
 			pcs->rcu_free = empty;
@@ -6437,7 +6469,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		goto no_empty;
 
 	if (!pcs->spare) {
-		empty = barn_get_empty_sheaf(barn);
+		empty = barn_get_empty_sheaf(barn, true);
 		if (!empty)
 			goto no_empty;
 
@@ -6451,7 +6483,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 		goto do_free;
 	}
 
-	empty = barn_replace_full_sheaf(barn, pcs->main);
+	empty = barn_replace_full_sheaf(barn, pcs->main, true);
 	if (IS_ERR(empty)) {
 		stat(s, BARN_PUT_FAIL);
 		goto no_empty;
@@ -6703,7 +6735,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 
 	if (likely(!IS_ENABLED(CONFIG_NUMA) || slab_nid(slab) == numa_mem_id())
 	    && likely(!slab_test_pfmemalloc(slab))) {
-		if (likely(free_to_pcs(s, object)))
+		if (likely(free_to_pcs(s, object, true)))
 			return;
 	}
 
@@ -6964,7 +6996,8 @@ void kfree_nolock(const void *object)
 	 * since kasan quarantine takes locks and not supported from NMI.
 	 */
 	kasan_slab_free(s, x, false, false, /* skip quarantine */true);
-	do_slab_free(s, slab, x, x, 0, _RET_IP_);
+	if (!free_to_pcs(s, x, false))
+		do_slab_free(s, slab, x, x, 0, _RET_IP_);
 }
 EXPORT_SYMBOL_GPL(kfree_nolock);
 
@@ -7516,7 +7549,7 @@ int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 		size--;
 	}
 
-	i = alloc_from_pcs_bulk(s, size, p);
+	i = alloc_from_pcs_bulk(s, flags, size, p);
 
 	if (i < size) {
 		/*

-- 
2.52.0


