Return-Path: <bpf+bounces-79287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5392DD32DB3
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A70B831C20F8
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1930A396B70;
	Fri, 16 Jan 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Umj/qy2M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MJUYj2s8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Umj/qy2M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MJUYj2s8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E3395259
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574523; cv=none; b=Amuf/nRMqYC6a/ApyDq08sPk12rYFj/3w0bKkqVAYhCOkKfhAc1+MwQEf5iEaETYTYQ11ZYmRWtuJGtw7qmduNAnLzaIJCg54v5CxTNl0iADd6Bp8eW7OeSiKLZgENOTJpnbG/BI4jJQabEsVCSox7Tv9TAPnn+QvRyXRWE6Xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574523; c=relaxed/simple;
	bh=a1QhVjbOBG5jUXk7HglhgmP6vjB9FjgTZzqM6C4dU10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V9RSQ/1AaBurJVE870nUYZPlg/Xd71MFIJsoisXLwq7yFl6jskN2cnpaJGcFQ5MCkBoRvUiuPuUx4ZH/WYl9ILgLjanZAiFpNhzVgKRdZ3jm7k6X4ylbJhaRHpfYE57B3/bf7SLQkvmsXvBynqLCvlse6zpptuMDU8VEQntTQmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Umj/qy2M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MJUYj2s8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Umj/qy2M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MJUYj2s8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 822D6337D7;
	Fri, 16 Jan 2026 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYPFN/yW/JKvudjCCeDF8Mzn+JOB4FaaxcACY1SSQAU=;
	b=Umj/qy2MtjJqJS5BFPaleWC/Vag7s20UXJBVp0xP2nbaR/cJXU1fhw8cG7NpztaSObd3nd
	vLa9WafVlZNBmG+XKu/iPnlRY94mxK/J89LQvzV7juxZrE7pbZ8dn0StDtfjiGeljo0I2V
	1g6rFa2I2P5bWxyYFssckucwK6dnJj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYPFN/yW/JKvudjCCeDF8Mzn+JOB4FaaxcACY1SSQAU=;
	b=MJUYj2s82y1Z/ZXm7D/b+gwMsPyZV2aZmisTd7uY3TLeP/VOPRqk2S3fJG92/Fl6I7CtIb
	5PpeMWqHPVlaScDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Umj/qy2M";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MJUYj2s8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYPFN/yW/JKvudjCCeDF8Mzn+JOB4FaaxcACY1SSQAU=;
	b=Umj/qy2MtjJqJS5BFPaleWC/Vag7s20UXJBVp0xP2nbaR/cJXU1fhw8cG7NpztaSObd3nd
	vLa9WafVlZNBmG+XKu/iPnlRY94mxK/J89LQvzV7juxZrE7pbZ8dn0StDtfjiGeljo0I2V
	1g6rFa2I2P5bWxyYFssckucwK6dnJj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QYPFN/yW/JKvudjCCeDF8Mzn+JOB4FaaxcACY1SSQAU=;
	b=MJUYj2s82y1Z/ZXm7D/b+gwMsPyZV2aZmisTd7uY3TLeP/VOPRqk2S3fJG92/Fl6I7CtIb
	5PpeMWqHPVlaScDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66D243EA65;
	Fri, 16 Jan 2026 14:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WHXYGOZNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:37 +0100
Subject: [PATCH v3 17/21] slab: refill sheaves from all nodes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-17-5595cb000772@suse.cz>
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
	R_RATELIMIT(0.00)[to(RL941jgdop1fyjkq8h4),to_ip_from(RLfsjnp7neds983g95ihcnuzgq)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 822D6337D7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

__refill_objects() currently only attempts to get partial slabs from the
local node and then allocates new slab(s). Expand it to trying also
other nodes while observing the remote node defrag ratio, similarly to
get_any_partial().

This will prevent allocating new slabs on a node while other nodes have
many free slabs. It does mean sheaves will contain non-local objects in
that case. Allocations that care about specific node will still be
served appropriately, but might get a slowpath allocation.

Like get_any_partial() we do observe cpuset_zone_allowed(), although we
might be refilling a sheaf that will be then used from a different
allocation context.

We can also use the resulting refill_objects() in
__kmem_cache_alloc_bulk() for non-debug caches. This means
kmem_cache_alloc_bulk() will get better performance when sheaves are
exhausted. kmem_cache_alloc_bulk() cannot indicate a preferred node so
it's compatible with sheaves refill in preferring the local node.
Its users also have gfp flags that allow spinning, so document that
as a requirement.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 106 insertions(+), 31 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d52de6e3c2d5..2c522d2bf547 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2518,8 +2518,8 @@ static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
 }
 
 static unsigned int
-__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
-		 unsigned int max);
+refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
+	       unsigned int max);
 
 static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
 			 gfp_t gfp)
@@ -2530,8 +2530,8 @@ static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
 	if (!to_fill)
 		return 0;
 
-	filled = __refill_objects(s, &sheaf->objects[sheaf->size], gfp,
-			to_fill, to_fill);
+	filled = refill_objects(s, &sheaf->objects[sheaf->size], gfp, to_fill,
+				to_fill);
 
 	sheaf->size += filled;
 
@@ -6522,29 +6522,22 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
 EXPORT_SYMBOL(kmem_cache_free_bulk);
 
 static unsigned int
-__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
-		 unsigned int max)
+__refill_objects_node(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
+		      unsigned int max, struct kmem_cache_node *n)
 {
 	struct slab *slab, *slab2;
 	struct partial_context pc;
 	unsigned int refilled = 0;
 	unsigned long flags;
 	void *object;
-	int node;
 
 	pc.flags = gfp;
 	pc.min_objects = min;
 	pc.max_objects = max;
 
-	node = numa_mem_id();
-
-	if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
+	if (!get_partial_node_bulk(s, n, &pc))
 		return 0;
 
-	/* TODO: consider also other nodes? */
-	if (!get_partial_node_bulk(s, get_node(s, node), &pc))
-		goto new_slab;
-
 	list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
 
 		list_del(&slab->slab_list);
@@ -6582,8 +6575,6 @@ __refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
 	}
 
 	if (unlikely(!list_empty(&pc.slabs))) {
-		struct kmem_cache_node *n = get_node(s, node);
-
 		spin_lock_irqsave(&n->list_lock, flags);
 
 		list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
@@ -6605,13 +6596,92 @@ __refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
 		}
 	}
 
+	return refilled;
+}
 
-	if (likely(refilled >= min))
-		goto out;
+#ifdef CONFIG_NUMA
+static unsigned int
+__refill_objects_any(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
+		     unsigned int max, int local_node)
+{
+	struct zonelist *zonelist;
+	struct zoneref *z;
+	struct zone *zone;
+	enum zone_type highest_zoneidx = gfp_zone(gfp);
+	unsigned int cpuset_mems_cookie;
+	unsigned int refilled = 0;
+
+	/* see get_any_partial() for the defrag ratio description */
+	if (!s->remote_node_defrag_ratio ||
+			get_cycles() % 1024 > s->remote_node_defrag_ratio)
+		return 0;
+
+	do {
+		cpuset_mems_cookie = read_mems_allowed_begin();
+		zonelist = node_zonelist(mempolicy_slab_node(), gfp);
+		for_each_zone_zonelist(zone, z, zonelist, highest_zoneidx) {
+			struct kmem_cache_node *n;
+			unsigned int r;
+
+			n = get_node(s, zone_to_nid(zone));
+
+			if (!n || !cpuset_zone_allowed(zone, gfp) ||
+					n->nr_partial <= s->min_partial)
+				continue;
+
+			r = __refill_objects_node(s, p, gfp, min, max, n);
+			refilled += r;
+
+			if (r >= min) {
+				/*
+				 * Don't check read_mems_allowed_retry() here -
+				 * if mems_allowed was updated in parallel, that
+				 * was a harmless race between allocation and
+				 * the cpuset update
+				 */
+				return refilled;
+			}
+			p += r;
+			min -= r;
+			max -= r;
+		}
+	} while (read_mems_allowed_retry(cpuset_mems_cookie));
+
+	return refilled;
+}
+#else
+static inline unsigned int
+__refill_objects_any(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
+		     unsigned int max, int local_node)
+{
+	return 0;
+}
+#endif
+
+static unsigned int
+refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
+	       unsigned int max)
+{
+	int local_node = numa_mem_id();
+	unsigned int refilled;
+	struct slab *slab;
+
+	if (WARN_ON_ONCE(!gfpflags_allow_spinning(gfp)))
+		return 0;
+
+	refilled = __refill_objects_node(s, p, gfp, min, max,
+					 get_node(s, local_node));
+	if (refilled >= min)
+		return refilled;
+
+	refilled += __refill_objects_any(s, p + refilled, gfp, min - refilled,
+					 max - refilled, local_node);
+	if (refilled >= min)
+		return refilled;
 
 new_slab:
 
-	slab = new_slab(s, pc.flags, node);
+	slab = new_slab(s, gfp, local_node);
 	if (!slab)
 		goto out;
 
@@ -6626,8 +6696,8 @@ __refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
 
 	if (refilled < min)
 		goto new_slab;
-out:
 
+out:
 	return refilled;
 }
 
@@ -6637,18 +6707,20 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 {
 	int i;
 
-	/*
-	 * TODO: this might be more efficient (if necessary) by reusing
-	 * __refill_objects()
-	 */
-	for (i = 0; i < size; i++) {
+	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
+		for (i = 0; i < size; i++) {
 
-		p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE, _RET_IP_,
-				     s->object_size);
-		if (unlikely(!p[i]))
-			goto error;
+			p[i] = ___slab_alloc(s, flags, NUMA_NO_NODE, _RET_IP_,
+					     s->object_size);
+			if (unlikely(!p[i]))
+				goto error;
 
-		maybe_wipe_obj_freeptr(s, p[i]);
+			maybe_wipe_obj_freeptr(s, p[i]);
+		}
+	} else {
+		i = refill_objects(s, p, flags, size, size);
+		if (i < size)
+			goto error;
 	}
 
 	return i;
@@ -6659,7 +6731,10 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 
 }
 
-/* Note that interrupts must be enabled when calling this function. */
+/*
+ * Note that interrupts must be enabled when calling this function and gfp
+ * flags must allow spinning.
+ */
 int kmem_cache_alloc_bulk_noprof(struct kmem_cache *s, gfp_t flags, size_t size,
 				 void **p)
 {

-- 
2.52.0


