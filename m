Return-Path: <bpf+bounces-73603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C88BDC34B27
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACA78562C54
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 09:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB0A2FB987;
	Wed,  5 Nov 2025 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g3fD4LL3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzVO54J1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g3fD4LL3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzVO54J1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE72FB619
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333547; cv=none; b=JEjCx9Lg50gQDZ69iE1Fng+Yyiq9FnvgjKRJPbcKgLXJ1mYsu3AjolPihZlBUHa5ncgq8k2AK7f4kMPRQer04ChmPlxEN155XhCfvNU+ovzWIkSdRcvoHWnaGauInQ43p3XyjXXg08+U2eqS8yD0CUM79/9KwuoC1rtVHRXbKIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333547; c=relaxed/simple;
	bh=JVMrOhZxUrybEyFs9el6qiogb1C0tU5myesUpvYuEVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=GAqyY76Xqgpolo6cbk6+H1jbgwjFnKczZ5M98uzoyGCoR9JNU7evbrfYHgLPa0+Gz2+Xp5jSH6eHm7+VDDQdUiaRWABm3YnN7+G7kW/NxSi+oEDJeMaKWA4cszZ43SeiW+WZorTBnatv/UqOwvG/Q6ZFZStskaGegj6JD1ksylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g3fD4LL3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzVO54J1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g3fD4LL3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GzVO54J1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A05C21F452;
	Wed,  5 Nov 2025 09:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762333530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3xWBfAUG4JHWgNOrNA/S+tg/3AdmFzQs0YfUSio0A4=;
	b=g3fD4LL33ECWdz21ko4qzOiUHJYqrVoCocAlITeBCKRkeodmkYBy+qk2Cxoso1KqhqT6f0
	cqM/y4VAjl5bylqAaXXU+3gb6DxvIcBMqGAUdAnTFYIFroyBGDJDPn8l1VRTZKqKQy+Yxb
	tP7YIt8FRkr3OCjamXg4CaREc7KrJvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762333530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3xWBfAUG4JHWgNOrNA/S+tg/3AdmFzQs0YfUSio0A4=;
	b=GzVO54J16sRzISTwXLTNgiTawsg7vs94G7phWvyfnZ9EjrcwOqV98XFAb50pHfRSM9GUJa
	srNKAqDOmfudL8DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g3fD4LL3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GzVO54J1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762333530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3xWBfAUG4JHWgNOrNA/S+tg/3AdmFzQs0YfUSio0A4=;
	b=g3fD4LL33ECWdz21ko4qzOiUHJYqrVoCocAlITeBCKRkeodmkYBy+qk2Cxoso1KqhqT6f0
	cqM/y4VAjl5bylqAaXXU+3gb6DxvIcBMqGAUdAnTFYIFroyBGDJDPn8l1VRTZKqKQy+Yxb
	tP7YIt8FRkr3OCjamXg4CaREc7KrJvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762333530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3xWBfAUG4JHWgNOrNA/S+tg/3AdmFzQs0YfUSio0A4=;
	b=GzVO54J16sRzISTwXLTNgiTawsg7vs94G7phWvyfnZ9EjrcwOqV98XFAb50pHfRSM9GUJa
	srNKAqDOmfudL8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8699513A88;
	Wed,  5 Nov 2025 09:05:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CAyZIFoTC2lSBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Nov 2025 09:05:30 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Wed, 05 Nov 2025 10:05:29 +0100
Subject: [PATCH 1/5] slab: make __slab_free() more clear
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-sheaves-cleanups-v1-1-b8218e1ac7ef@suse.cz>
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
X-Rspamd-Queue-Id: A05C21F452
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

The function is tricky and many of its tests are hard to understand. Try
to improve that by using more descriptively named variables and added
comments.

- rename 'prior' to 'old_head' to match the head and tail parameters
- introduce a 'bool was_full' to make it more obvious what we are
  testing instead of the !prior and prior tests
- add or improve comments in various places to explain what we're doing

Also replace kmem_cache_has_cpu_partial() tests with
IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) which are compile-time constants.
We can do that because the kmem_cache_debug(s) case is handled upfront
via free_to_partial_list().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 62 +++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f1a5373eee7b..074abe8e79f8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5859,8 +5859,8 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			unsigned long addr)
 
 {
-	void *prior;
-	int was_frozen;
+	void *old_head;
+	bool was_frozen, was_full;
 	struct slab new;
 	unsigned long counters;
 	struct kmem_cache_node *n = NULL;
@@ -5874,20 +5874,37 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		return;
 	}
 
+	/*
+	 * It is enough to test IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) below
+	 * instead of kmem_cache_has_cpu_partial(s), because kmem_cache_debug(s)
+	 * is the only other reason it can be false, and it is already handled
+	 * above.
+	 */
+
 	do {
 		if (unlikely(n)) {
 			spin_unlock_irqrestore(&n->list_lock, flags);
 			n = NULL;
 		}
-		prior = slab->freelist;
+		old_head = slab->freelist;
 		counters = slab->counters;
-		set_freepointer(s, tail, prior);
+		set_freepointer(s, tail, old_head);
 		new.counters = counters;
-		was_frozen = new.frozen;
+		was_frozen = !!new.frozen;
+		was_full = (old_head == NULL);
 		new.inuse -= cnt;
-		if ((!new.inuse || !prior) && !was_frozen) {
-			/* Needs to be taken off a list */
-			if (!kmem_cache_has_cpu_partial(s) || prior) {
+		/*
+		 * Might need to be taken off (due to becoming empty) or added
+		 * to (due to not being full anymore) the partial list.
+		 * Unless it's frozen.
+		 */
+		if ((!new.inuse || was_full) && !was_frozen) {
+			/*
+			 * If slab becomes non-full and we have cpu partial
+			 * lists, we put it there unconditionally to avoid
+			 * taking the list_lock. Otherwise we need it.
+			 */
+			if (!(IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full)) {
 
 				n = get_node(s, slab_nid(slab));
 				/*
@@ -5905,7 +5922,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		}
 
 	} while (!slab_update_freelist(s, slab,
-		prior, counters,
+		old_head, counters,
 		head, new.counters,
 		"__slab_free"));
 
@@ -5917,7 +5934,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			 * activity can be necessary.
 			 */
 			stat(s, FREE_FROZEN);
-		} else if (kmem_cache_has_cpu_partial(s) && !prior) {
+		} else if (IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && was_full) {
 			/*
 			 * If we started with a full slab then put it onto the
 			 * per cpu partial list.
@@ -5926,6 +5943,11 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			stat(s, CPU_PARTIAL_FREE);
 		}
 
+		/*
+		 * In other cases we didn't take the list_lock because the slab
+		 * was already on the partial list and will remain there.
+		 */
+
 		return;
 	}
 
@@ -5933,19 +5955,24 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	 * This slab was partially empty but not on the per-node partial list,
 	 * in which case we shouldn't manipulate its list, just return.
 	 */
-	if (prior && !on_node_partial) {
+	if (!was_full && !on_node_partial) {
 		spin_unlock_irqrestore(&n->list_lock, flags);
 		return;
 	}
 
+	/*
+	 * If slab became empty, should we add/keep it on the partial list or we
+	 * have enough?
+	 */
 	if (unlikely(!new.inuse && n->nr_partial >= s->min_partial))
 		goto slab_empty;
 
 	/*
 	 * Objects left in the slab. If it was not on the partial list before
-	 * then add it.
+	 * then add it. This can only happen when cache has no per cpu partial
+	 * list otherwise we would have put it there.
 	 */
-	if (!kmem_cache_has_cpu_partial(s) && unlikely(!prior)) {
+	if (!IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) && unlikely(was_full)) {
 		add_partial(n, slab, DEACTIVATE_TO_TAIL);
 		stat(s, FREE_ADD_PARTIAL);
 	}
@@ -5953,10 +5980,11 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	return;
 
 slab_empty:
-	if (prior) {
-		/*
-		 * Slab on the partial list.
-		 */
+	/*
+	 * The slab could have a single object and thus go from full to empty in
+	 * a single free, but more likely it was on the partial list. Remove it.
+	 */
+	if (likely(!was_full)) {
 		remove_partial(n, slab);
 		stat(s, FREE_REMOVE_PARTIAL);
 	}

-- 
2.51.1


