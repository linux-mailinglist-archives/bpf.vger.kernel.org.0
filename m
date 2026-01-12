Return-Path: <bpf+bounces-78587-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28575D13A39
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 166D03045643
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA52634C811;
	Mon, 12 Jan 2026 15:18:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FF13203A1
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231080; cv=none; b=bpuTqlYFFyN1MSek4qucjTkAu64I9cKu/RLEw69PNAj6OSTnhF3pEkjcaM91ziAT9YLG4BQGeughd+tnREvwR7cXnF7p3We1zjRsPONmvpT3hy1xbTeo0XWCi1mwh98lnb6YoJdeyqJDnMVUcE/Sc2ILIgH/A8jajOw6tr+ij2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231080; c=relaxed/simple;
	bh=gSBPHThvoSXlEcBJ/ksK/g6ywiDKjBe488jCQjKJP4k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a72NTjztUHbbEsxI3LIYBSQr/1D+ZP3xZGzCFpFWBLVdBxB+bxo/ftKYiqaLlHl8XfrOGMaH7QVMEhWXrg8/af9U2EPFkd5r1+w7Ix1oDdppc5BxWbn/HKlyFc+S3p1el/z4a4NdGfc/sAIOc//HYn+oGAJRTy+T6V4lSpEVxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A4A0C5BCD8;
	Mon, 12 Jan 2026 15:16:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 886A23EA65;
	Mon, 12 Jan 2026 15:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EB0MIWsQZWn7FgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Jan 2026 15:16:59 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 12 Jan 2026 16:17:14 +0100
Subject: [PATCH RFC v2 20/20] mm/slub: cleanup and repurpose some stat
 items
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-sheaves-for-all-v2-20-98225cfb50cf@suse.cz>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A4A0C5BCD8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO

A number of stat items related to cpu slabs became unused, remove them.

Two of those were ALLOC_FASTPATH and FREE_FASTPATH. But instead of
removing those, use them instead of ALLOC_PCS and FREE_PCS, since
sheaves are the new (and only) fastpaths, Remove the recently added
_PCS variants instead.

Change where FREE_SLOWPATH is counted so that it only counts freeing of
objects by slab users that (for whatever reason) do not go to a percpu
sheaf, and not all (including internal) callers of __slab_free(). Thus
flushing sheaves (counted by SHEAF_FLUSH) no longer also increments
FREE_SLOWPATH. This matches how ALLOC_SLOWPATH doesn't count sheaf
refills (counted by SHEAF_REFILL).

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 77 +++++++++++++++++----------------------------------------------
 1 file changed, 21 insertions(+), 56 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index a473fa29a905..70314c72773e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -330,33 +330,19 @@ enum add_mode {
 };
 
 enum stat_item {
-	ALLOC_PCS,		/* Allocation from percpu sheaf */
-	ALLOC_FASTPATH,		/* Allocation from cpu slab */
-	ALLOC_SLOWPATH,		/* Allocation by getting a new cpu slab */
-	FREE_PCS,		/* Free to percpu sheaf */
+	ALLOC_FASTPATH,		/* Allocation from percpu sheaves */
+	ALLOC_SLOWPATH,		/* Allocation from partial or new slab */
 	FREE_RCU_SHEAF,		/* Free to rcu_free sheaf */
 	FREE_RCU_SHEAF_FAIL,	/* Failed to free to a rcu_free sheaf */
-	FREE_FASTPATH,		/* Free to cpu slab */
-	FREE_SLOWPATH,		/* Freeing not to cpu slab */
+	FREE_FASTPATH,		/* Free to percpu sheaves */
+	FREE_SLOWPATH,		/* Free to a slab */
 	FREE_ADD_PARTIAL,	/* Freeing moves slab to partial list */
 	FREE_REMOVE_PARTIAL,	/* Freeing removes last object */
-	ALLOC_FROM_PARTIAL,	/* Cpu slab acquired from node partial list */
-	ALLOC_SLAB,		/* Cpu slab acquired from page allocator */
-	ALLOC_REFILL,		/* Refill cpu slab from slab freelist */
-	ALLOC_NODE_MISMATCH,	/* Switching cpu slab */
+	ALLOC_SLAB,		/* New slab acquired from page allocator */
+	ALLOC_NODE_MISMATCH,	/* Requested node different from cpu sheaf */
 	FREE_SLAB,		/* Slab freed to the page allocator */
-	CPUSLAB_FLUSH,		/* Abandoning of the cpu slab */
-	DEACTIVATE_FULL,	/* Cpu slab was full when deactivated */
-	DEACTIVATE_EMPTY,	/* Cpu slab was empty when deactivated */
-	DEACTIVATE_REMOTE_FREES,/* Slab contained remotely freed objects */
-	DEACTIVATE_BYPASS,	/* Implicit deactivation */
 	ORDER_FALLBACK,		/* Number of times fallback was necessary */
-	CMPXCHG_DOUBLE_CPU_FAIL,/* Failures of this_cpu_cmpxchg_double */
 	CMPXCHG_DOUBLE_FAIL,	/* Failures of slab freelist update */
-	CPU_PARTIAL_ALLOC,	/* Used cpu partial on alloc */
-	CPU_PARTIAL_FREE,	/* Refill cpu partial on free */
-	CPU_PARTIAL_NODE,	/* Refill cpu partial from node partial */
-	CPU_PARTIAL_DRAIN,	/* Drain cpu partial to node partial */
 	SHEAF_FLUSH,		/* Objects flushed from a sheaf */
 	SHEAF_REFILL,		/* Objects refilled to a sheaf */
 	SHEAF_ALLOC,		/* Allocation of an empty sheaf */
@@ -4330,8 +4316,10 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
 	 * We assume the percpu sheaves contain only local objects although it's
 	 * not completely guaranteed, so we verify later.
 	 */
-	if (unlikely(node_requested && node != numa_mem_id()))
+	if (unlikely(node_requested && node != numa_mem_id())) {
+		stat(s, ALLOC_NODE_MISMATCH);
 		return NULL;
+	}
 
 	if (!local_trylock(&s->cpu_sheaves->lock))
 		return NULL;
@@ -4354,6 +4342,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
 		 */
 		if (page_to_nid(virt_to_page(object)) != node) {
 			local_unlock(&s->cpu_sheaves->lock);
+			stat(s, ALLOC_NODE_MISMATCH);
 			return NULL;
 		}
 	}
@@ -4362,7 +4351,7 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
 
 	local_unlock(&s->cpu_sheaves->lock);
 
-	stat(s, ALLOC_PCS);
+	stat(s, ALLOC_FASTPATH);
 
 	return object;
 }
@@ -4434,7 +4423,7 @@ unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, gfp_t gfp, size_t size,
 
 	local_unlock(&s->cpu_sheaves->lock);
 
-	stat_add(s, ALLOC_PCS, batch);
+	stat_add(s, ALLOC_FASTPATH, batch);
 
 	allocated += batch;
 
@@ -5101,8 +5090,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	unsigned long flags;
 	bool on_node_partial;
 
-	stat(s, FREE_SLOWPATH);
-
 	if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
 		free_to_partial_list(s, slab, head, tail, cnt, addr);
 		return;
@@ -5408,7 +5395,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
 
 	local_unlock(&s->cpu_sheaves->lock);
 
-	stat(s, FREE_PCS);
+	stat(s, FREE_FASTPATH);
 
 	return true;
 }
@@ -5659,7 +5646,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 
 	local_unlock(&s->cpu_sheaves->lock);
 
-	stat_add(s, FREE_PCS, batch);
+	stat_add(s, FREE_FASTPATH, batch);
 
 	if (batch < size) {
 		p += batch;
@@ -5681,10 +5668,12 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 	 */
 fallback:
 	__kmem_cache_free_bulk(s, size, p);
+	stat_add(s, FREE_SLOWPATH, size);
 
 flush_remote:
 	if (remote_nr) {
 		__kmem_cache_free_bulk(s, remote_nr, &remote_objects[0]);
+		stat_add(s, FREE_SLOWPATH, remote_nr);
 		if (i < size) {
 			remote_nr = 0;
 			goto next_remote_batch;
@@ -5777,6 +5766,7 @@ void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
 	}
 
 	__slab_free(s, slab, object, object, 1, addr);
+	stat(s, FREE_SLOWPATH);
 }
 
 #ifdef CONFIG_MEMCG
@@ -5799,8 +5789,10 @@ void slab_free_bulk(struct kmem_cache *s, struct slab *slab, void *head,
 	 * With KASAN enabled slab_free_freelist_hook modifies the freelist
 	 * to remove objects, whose reuse must be delayed.
 	 */
-	if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt)))
+	if (likely(slab_free_freelist_hook(s, &head, &tail, &cnt))) {
 		__slab_free(s, slab, head, tail, cnt, addr);
+		stat_add(s, FREE_SLOWPATH, cnt);
+	}
 }
 
 #ifdef CONFIG_SLUB_RCU_DEBUG
@@ -6699,6 +6691,7 @@ int __kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
 		i = refill_objects(s, p, flags, size, size);
 		if (i < size)
 			goto error;
+		stat_add(s, ALLOC_SLOWPATH, i);
 	}
 
 	return i;
@@ -8698,33 +8691,19 @@ static ssize_t text##_store(struct kmem_cache *s,		\
 }								\
 SLAB_ATTR(text);						\
 
-STAT_ATTR(ALLOC_PCS, alloc_cpu_sheaf);
 STAT_ATTR(ALLOC_FASTPATH, alloc_fastpath);
 STAT_ATTR(ALLOC_SLOWPATH, alloc_slowpath);
-STAT_ATTR(FREE_PCS, free_cpu_sheaf);
 STAT_ATTR(FREE_RCU_SHEAF, free_rcu_sheaf);
 STAT_ATTR(FREE_RCU_SHEAF_FAIL, free_rcu_sheaf_fail);
 STAT_ATTR(FREE_FASTPATH, free_fastpath);
 STAT_ATTR(FREE_SLOWPATH, free_slowpath);
 STAT_ATTR(FREE_ADD_PARTIAL, free_add_partial);
 STAT_ATTR(FREE_REMOVE_PARTIAL, free_remove_partial);
-STAT_ATTR(ALLOC_FROM_PARTIAL, alloc_from_partial);
 STAT_ATTR(ALLOC_SLAB, alloc_slab);
-STAT_ATTR(ALLOC_REFILL, alloc_refill);
 STAT_ATTR(ALLOC_NODE_MISMATCH, alloc_node_mismatch);
 STAT_ATTR(FREE_SLAB, free_slab);
-STAT_ATTR(CPUSLAB_FLUSH, cpuslab_flush);
-STAT_ATTR(DEACTIVATE_FULL, deactivate_full);
-STAT_ATTR(DEACTIVATE_EMPTY, deactivate_empty);
-STAT_ATTR(DEACTIVATE_REMOTE_FREES, deactivate_remote_frees);
-STAT_ATTR(DEACTIVATE_BYPASS, deactivate_bypass);
 STAT_ATTR(ORDER_FALLBACK, order_fallback);
-STAT_ATTR(CMPXCHG_DOUBLE_CPU_FAIL, cmpxchg_double_cpu_fail);
 STAT_ATTR(CMPXCHG_DOUBLE_FAIL, cmpxchg_double_fail);
-STAT_ATTR(CPU_PARTIAL_ALLOC, cpu_partial_alloc);
-STAT_ATTR(CPU_PARTIAL_FREE, cpu_partial_free);
-STAT_ATTR(CPU_PARTIAL_NODE, cpu_partial_node);
-STAT_ATTR(CPU_PARTIAL_DRAIN, cpu_partial_drain);
 STAT_ATTR(SHEAF_FLUSH, sheaf_flush);
 STAT_ATTR(SHEAF_REFILL, sheaf_refill);
 STAT_ATTR(SHEAF_ALLOC, sheaf_alloc);
@@ -8800,33 +8779,19 @@ static struct attribute *slab_attrs[] = {
 	&remote_node_defrag_ratio_attr.attr,
 #endif
 #ifdef CONFIG_SLUB_STATS
-	&alloc_cpu_sheaf_attr.attr,
 	&alloc_fastpath_attr.attr,
 	&alloc_slowpath_attr.attr,
-	&free_cpu_sheaf_attr.attr,
 	&free_rcu_sheaf_attr.attr,
 	&free_rcu_sheaf_fail_attr.attr,
 	&free_fastpath_attr.attr,
 	&free_slowpath_attr.attr,
 	&free_add_partial_attr.attr,
 	&free_remove_partial_attr.attr,
-	&alloc_from_partial_attr.attr,
 	&alloc_slab_attr.attr,
-	&alloc_refill_attr.attr,
 	&alloc_node_mismatch_attr.attr,
 	&free_slab_attr.attr,
-	&cpuslab_flush_attr.attr,
-	&deactivate_full_attr.attr,
-	&deactivate_empty_attr.attr,
-	&deactivate_remote_frees_attr.attr,
-	&deactivate_bypass_attr.attr,
 	&order_fallback_attr.attr,
 	&cmpxchg_double_fail_attr.attr,
-	&cmpxchg_double_cpu_fail_attr.attr,
-	&cpu_partial_alloc_attr.attr,
-	&cpu_partial_free_attr.attr,
-	&cpu_partial_node_attr.attr,
-	&cpu_partial_drain_attr.attr,
 	&sheaf_flush_attr.attr,
 	&sheaf_refill_attr.attr,
 	&sheaf_alloc_attr.attr,

-- 
2.52.0


