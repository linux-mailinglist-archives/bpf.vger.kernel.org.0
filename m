Return-Path: <bpf+bounces-71922-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E5C019A0
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 16:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 973AA56578A
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 13:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB3B3321DD;
	Thu, 23 Oct 2025 13:53:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079CD3314CD
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 13:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227627; cv=none; b=SU99C/E+KbVEfgwGskoGhq8wIRRaFvDsKEWcuAsbHln7EoAicYrAOmKejLFM50CDq5fkcI5Hyb8lDUzAJUzmzaG+cFyDoL5gY2Kuw91GgnwmGkUdnY2qmZqfVPmvXg/emNZhFF6SxGenvU3CnLUc9zLaCY4tT0hrmui8NRMSB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227627; c=relaxed/simple;
	bh=Tx3alZCX/iWjxCho3p1HiJERNNhEkf5M0K5IdItTQjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNa2VXK3Soe1kJYYmWVYBv6l4T7gzMlbXAcaMj9Q1DuVCJ17+QqbxaiRmictZNBdoJmz4l/PQFDW9FfUZy4bozrDYc33frsR8X59SHmxJkUcU4IvzH6DBUv2lqLj+xbqVvd2qWMsoSEDnWNRNeaJgphZbGDYW6WzmO+vJ8yAtMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AFC0F1F7CE;
	Thu, 23 Oct 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF88613B0F;
	Thu, 23 Oct 2025 13:52:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oPB8LjYz+mjvQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 23 Oct 2025 13:52:54 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 23 Oct 2025 15:52:39 +0200
Subject: [PATCH RFC 17/19] slab: refill sheaves from all nodes
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sheaves-for-all-v1-17-6ffa2c9941c0@suse.cz>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: AFC0F1F7CE
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

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 28 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index d55afa9b277f..4e003493ba60 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2505,8 +2505,8 @@ static void free_empty_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf)
 }
 
 static unsigned int
-__refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
-		 unsigned int max);
+refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
+	       unsigned int max);
 
 static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
 			 gfp_t gfp)
@@ -2517,8 +2517,8 @@ static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
 	if (!to_fill)
 		return 0;
 
-	filled = __refill_objects(s, &sheaf->objects[sheaf->size], gfp,
-			to_fill, to_fill);
+	filled = refill_objects(s, &sheaf->objects[sheaf->size], gfp, to_fill,
+				to_fill);
 
 	sheaf->size += filled;
 
@@ -6423,25 +6423,21 @@ void kmem_cache_free_bulk(struct kmem_cache *s, size_t size, void **p)
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
-	/* TODO: consider also other nodes? */
-	if (!get_partial_node_bulk(s, get_node(s, node), &pc))
-		goto new_slab;
+	if (!get_partial_node_bulk(s, n, &pc))
+		return 0;
 
 	list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
 
@@ -6480,8 +6476,6 @@ __refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
 	}
 
 	if (unlikely(!list_empty(&pc.slabs))) {
-		struct kmem_cache_node *n = get_node(s, node);
-
 		spin_lock_irqsave(&n->list_lock, flags);
 
 		list_for_each_entry_safe(slab, slab2, &pc.slabs, slab_list) {
@@ -6503,13 +6497,91 @@ __refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
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
+	unsigned long flags;
+	struct slab *slab;
+	void *object;
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
 
@@ -6541,8 +6613,8 @@ __refill_objects(struct kmem_cache *s, void **p, gfp_t gfp, unsigned int min,
 
 	if (refilled < min)
 		goto new_slab;
-out:
 
+out:
 	return refilled;
 }
 
@@ -6552,18 +6624,20 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
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

-- 
2.51.1


