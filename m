Return-Path: <bpf+bounces-78588-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CC30ED13B30
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DD923008C5D
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2833F3033F0;
	Mon, 12 Jan 2026 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Ha3gYTY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ijhgWGba";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Ha3gYTY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ijhgWGba"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FB2F069E
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231085; cv=none; b=djl8S6LLPLV42LZo3co0M3zbiHUERcqogthNenL7T9Njiu89EfCdRXoInxzv9KGy1vTaz5lLvVm/xS/ixJcJt/MQ9yP93+aFwYbbmQyMunDQujJEnDSp2sgEOtKrphyeNWea5Pq2iSWnyf9emOsOBQZMJZBm/i2Z1OSR6EeADng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231085; c=relaxed/simple;
	bh=aMvDJAIhNCxfcxQjV5Aj+F9I5nfwxELqW4WbTmkX2l4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckA86Uv2Bq8XB4qjRn0rvy4l0jAGeJFpHTqsDXRDTfcsKLGx2gJoVkwk0cM4QJp/1s2nlqkTvIDbo/tJvMDR7eaZk6S8hZ7ZvKppmDsVlOkhFnZRf3WeOwpV1rbDS6T9VO/Yy0IwWa4Jic36E/rzUnP1cG+CAEsBYNJCQIPvVU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Ha3gYTY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ijhgWGba; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Ha3gYTY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ijhgWGba; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A5813369E;
	Mon, 12 Jan 2026 15:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768231019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcLFQc/ui+avkUrpYqgT4MBi/dIYNzGpd9WjmG235Uw=;
	b=3Ha3gYTYMkAp0k2csUWBRgFMxZauK9hIstRMymCLWHmxQ9pbAphx03QfwprRLXDRTa0Tk4
	fLvkpgjOI9fxV1Zr87CSt7g3A1s5yunn5SJTQhZAOHn7lfSBelAjFMlmRBz4LDxPQQWOjW
	3RnQoYgG7QLlfNkp5diL8AbSs/CYn3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768231019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcLFQc/ui+avkUrpYqgT4MBi/dIYNzGpd9WjmG235Uw=;
	b=ijhgWGbaqGYDleqnHf6BsKhdCVAZkof16po9Trw4b9uUvSKEmJMiWyjv0/02kvop+Xjqnj
	v+ev4PX53iVe0WCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768231019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcLFQc/ui+avkUrpYqgT4MBi/dIYNzGpd9WjmG235Uw=;
	b=3Ha3gYTYMkAp0k2csUWBRgFMxZauK9hIstRMymCLWHmxQ9pbAphx03QfwprRLXDRTa0Tk4
	fLvkpgjOI9fxV1Zr87CSt7g3A1s5yunn5SJTQhZAOHn7lfSBelAjFMlmRBz4LDxPQQWOjW
	3RnQoYgG7QLlfNkp5diL8AbSs/CYn3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768231019;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bcLFQc/ui+avkUrpYqgT4MBi/dIYNzGpd9WjmG235Uw=;
	b=ijhgWGbaqGYDleqnHf6BsKhdCVAZkof16po9Trw4b9uUvSKEmJMiWyjv0/02kvop+Xjqnj
	v+ev4PX53iVe0WCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E0473EA63;
	Mon, 12 Jan 2026 15:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CHOXGmsQZWn7FgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Jan 2026 15:16:59 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 12 Jan 2026 16:17:13 +0100
Subject: [PATCH RFC v2 19/20] mm/slub: remove DEACTIVATE_TO_* stat items
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-sheaves-for-all-v2-19-98225cfb50cf@suse.cz>
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
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLwn5r54y1cp81no5tmbbew5oc)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,gmail.com,oracle.com,google.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.cz];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 

The cpu slabs and their deactivations were removed, so remove the unused
stat items. Weirdly enough the values were also used to control
__add_partial() adding to head or tail of the list, so replace that with
a new enum add_mode, which is cleaner.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5b2d7c387646..a473fa29a905 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -324,6 +324,11 @@ static void debugfs_slab_add(struct kmem_cache *);
 static inline void debugfs_slab_add(struct kmem_cache *s) { }
 #endif
 
+enum add_mode {
+	ADD_TO_HEAD,
+	ADD_TO_TAIL,
+};
+
 enum stat_item {
 	ALLOC_PCS,		/* Allocation from percpu sheaf */
 	ALLOC_FASTPATH,		/* Allocation from cpu slab */
@@ -343,8 +348,6 @@ enum stat_item {
 	CPUSLAB_FLUSH,		/* Abandoning of the cpu slab */
 	DEACTIVATE_FULL,	/* Cpu slab was full when deactivated */
 	DEACTIVATE_EMPTY,	/* Cpu slab was empty when deactivated */
-	DEACTIVATE_TO_HEAD,	/* Cpu slab was moved to the head of partials */
-	DEACTIVATE_TO_TAIL,	/* Cpu slab was moved to the tail of partials */
 	DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects */
 	DEACTIVATE_BYPASS,	/* Implicit deactivation */
 	ORDER_FALLBACK,		/* Number of times fallback was necessary */
@@ -3253,10 +3256,10 @@ static inline void slab_clear_node_partial(struct slab *slab)
  * Management of partially allocated slabs.
  */
 static inline void
-__add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
+__add_partial(struct kmem_cache_node *n, struct slab *slab, enum add_mode mode)
 {
 	n->nr_partial++;
-	if (tail == DEACTIVATE_TO_TAIL)
+	if (mode == ADD_TO_TAIL)
 		list_add_tail(&slab->slab_list, &n->partial);
 	else
 		list_add(&slab->slab_list, &n->partial);
@@ -3264,10 +3267,10 @@ __add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
 }
 
 static inline void add_partial(struct kmem_cache_node *n,
-				struct slab *slab, int tail)
+				struct slab *slab, enum add_mode mode)
 {
 	lockdep_assert_held(&n->list_lock);
-	__add_partial(n, slab, tail);
+	__add_partial(n, slab, mode);
 }
 
 static inline void remove_partial(struct kmem_cache_node *n,
@@ -3360,7 +3363,7 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
 	if (slab->inuse == slab->objects)
 		add_full(s, n, slab);
 	else
-		add_partial(n, slab, DEACTIVATE_TO_HEAD);
+		add_partial(n, slab, ADD_TO_HEAD);
 
 	inc_slabs_node(s, nid, slab->objects);
 	spin_unlock_irqrestore(&n->list_lock, flags);
@@ -3979,7 +3982,7 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
 			n = get_node(s, slab_nid(slab));
 			spin_lock_irqsave(&n->list_lock, flags);
 		}
-		add_partial(n, slab, DEACTIVATE_TO_HEAD);
+		add_partial(n, slab, ADD_TO_HEAD);
 		spin_unlock_irqrestore(&n->list_lock, flags);
 	}
 
@@ -5054,7 +5057,7 @@ static noinline void free_to_partial_list(
 			/* was on full list */
 			remove_full(s, n, slab);
 			if (!slab_free) {
-				add_partial(n, slab, DEACTIVATE_TO_TAIL);
+				add_partial(n, slab, ADD_TO_TAIL);
 				stat(s, FREE_ADD_PARTIAL);
 			}
 		} else if (slab_free) {
@@ -5174,7 +5177,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	 * then add it.
 	 */
 	if (unlikely(was_full)) {
-		add_partial(n, slab, DEACTIVATE_TO_TAIL);
+		add_partial(n, slab, ADD_TO_TAIL);
 		stat(s, FREE_ADD_PARTIAL);
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
@@ -6557,7 +6560,7 @@ __refill_objects_node(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int mi
 				continue;
 
 			list_del(&slab->slab_list);
-			add_partial(n, slab, DEACTIVATE_TO_HEAD);
+			add_partial(n, slab, ADD_TO_HEAD);
 		}
 
 		spin_unlock_irqrestore(&n->list_lock, flags);
@@ -7025,7 +7028,7 @@ static void early_kmem_cache_node_alloc(int node)
 	 * No locks need to be taken here as it has just been
 	 * initialized and there is no concurrent access.
 	 */
-	__add_partial(n, slab, DEACTIVATE_TO_HEAD);
+	__add_partial(n, slab, ADD_TO_HEAD);
 }
 
 static void free_kmem_cache_nodes(struct kmem_cache *s)
@@ -8713,8 +8716,6 @@ STAT_ATTR(FREE_SLAB, free_slab);
 STAT_ATTR(CPUSLAB_FLUSH, cpuslab_flush);
 STAT_ATTR(DEACTIVATE_FULL, deactivate_full);
 STAT_ATTR(DEACTIVATE_EMPTY, deactivate_empty);
-STAT_ATTR(DEACTIVATE_TO_HEAD, deactivate_to_head);
-STAT_ATTR(DEACTIVATE_TO_TAIL, deactivate_to_tail);
 STAT_ATTR(DEACTIVATE_REMOTE_FREES, deactivate_remote_frees);
 STAT_ATTR(DEACTIVATE_BYPASS, deactivate_bypass);
 STAT_ATTR(ORDER_FALLBACK, order_fallback);
@@ -8817,8 +8818,6 @@ static struct attribute *slab_attrs[] = {
 	&cpuslab_flush_attr.attr,
 	&deactivate_full_attr.attr,
 	&deactivate_empty_attr.attr,
-	&deactivate_to_head_attr.attr,
-	&deactivate_to_tail_attr.attr,
 	&deactivate_remote_frees_attr.attr,
 	&deactivate_bypass_attr.attr,
 	&order_fallback_attr.attr,

-- 
2.52.0


