Return-Path: <bpf+bounces-78578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 928F6D13B66
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 16:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC12231D97EF
	for <lists+bpf@lfdr.de>; Mon, 12 Jan 2026 15:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9162FCBE1;
	Mon, 12 Jan 2026 15:17:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F9D2F619D
	for <bpf@vger.kernel.org>; Mon, 12 Jan 2026 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231052; cv=none; b=JwoMRJ8U//spw1QLblHM5kGuOwEGIoeFS+obDeATxlUdsQYVoA5jhM2+fSaHREv1Phkv0zzWYBOyELflbpMGSB53RnMRk1nwS7JX791SIyuC97hH826B74+IQlhg59tQzLcN7lUygY7lEW4dIXBDus9Y239atOaBeVbL+ksPg8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231052; c=relaxed/simple;
	bh=SAkz6rsP7IOZaEMf5+oYCSGddg1cjBfkutOZo2oxsPw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U71QhWW748t05TjIq308/ShWSHJmufrV+/3DQtmNNZXLMj5C3SQ05VvZJAJW8z3/fdSQxZrmgj09/kjc1GpuCCCLdnGjYlqcNfza3ufmW5oomH8xgmrbivvHpBNv6b6ph9QHLk/dDPcvhH+YPAOTMGXisgsKhy5Rtsg02Dud5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C4DF633695;
	Mon, 12 Jan 2026 15:16:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A80C93EA65;
	Mon, 12 Jan 2026 15:16:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oNG6KGoQZWn7FgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 12 Jan 2026 15:16:58 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Mon, 12 Jan 2026 16:17:06 +0100
Subject: [PATCH RFC v2 12/20] slab: remove defer_deactivate_slab()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-sheaves-for-all-v2-12-98225cfb50cf@suse.cz>
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
X-Rspamd-Queue-Id: C4DF633695
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO

There are no more cpu slabs so we don't need their deferred
deactivation. The function is now only used from places where we
allocate a new slab but then can't spin on node list_lock to put it on
the partial list. Instead of the deferred action we can free it directly
via __free_slab(), we just need to tell it to use _nolock() freeing of
the underlying pages and take care of the accounting.

Since free_frozen_pages_nolock() variant does not yet exist for code
outside of the page allocator, create it as a trivial wrapper for
__free_frozen_pages(..., FPI_TRYLOCK).

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/internal.h   |  1 +
 mm/page_alloc.c |  5 +++++
 mm/slab.h       |  8 +-------
 mm/slub.c       | 51 ++++++++++++++++-----------------------------------
 4 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index e430da900430..1f44ccb4badf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -846,6 +846,7 @@ static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned int ord
 struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order);
 #define alloc_frozen_pages_nolock(...) \
 	alloc_hooks(alloc_frozen_pages_nolock_noprof(__VA_ARGS__))
+void free_frozen_pages_nolock(struct page *page, unsigned int order);
 
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 822e05f1a964..8a288ecfdd93 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2981,6 +2981,11 @@ void free_frozen_pages(struct page *page, unsigned int order)
 	__free_frozen_pages(page, order, FPI_NONE);
 }
 
+void free_frozen_pages_nolock(struct page *page, unsigned int order)
+{
+	__free_frozen_pages(page, order, FPI_TRYLOCK);
+}
+
 /*
  * Free a batch of folios
  */
diff --git a/mm/slab.h b/mm/slab.h
index e77260720994..4efec41b6445 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -71,13 +71,7 @@ struct slab {
 	struct kmem_cache *slab_cache;
 	union {
 		struct {
-			union {
-				struct list_head slab_list;
-				struct { /* For deferred deactivate_slab() */
-					struct llist_node llnode;
-					void *flush_freelist;
-				};
-			};
+			struct list_head slab_list;
 			/* Double-word boundary */
 			struct freelist_counters;
 		};
diff --git a/mm/slub.c b/mm/slub.c
index 522a7e671a26..0effeb3b9552 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3248,7 +3248,7 @@ static struct slab *new_slab(struct kmem_cache *s, gfp_t flags, int node)
 		flags & (GFP_RECLAIM_MASK | GFP_CONSTRAINT_MASK), node);
 }
 
-static void __free_slab(struct kmem_cache *s, struct slab *slab)
+static void __free_slab(struct kmem_cache *s, struct slab *slab, bool allow_spin)
 {
 	struct page *page = slab_page(slab);
 	int order = compound_order(page);
@@ -3262,11 +3262,20 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	free_frozen_pages(page, order);
 }
 
+static void free_new_slab_nolock(struct kmem_cache *s, struct slab *slab)
+{
+	/*
+	 * Since it was just allocated, we can skip the actions in
+	 * discard_slab() and free_slab().
+	 */
+	__free_slab(s, slab, false);
+}
+
 static void rcu_free_slab(struct rcu_head *h)
 {
 	struct slab *slab = container_of(h, struct slab, rcu_head);
 
-	__free_slab(slab->slab_cache, slab);
+	__free_slab(slab->slab_cache, slab, true);
 }
 
 static void free_slab(struct kmem_cache *s, struct slab *slab)
@@ -3282,7 +3291,7 @@ static void free_slab(struct kmem_cache *s, struct slab *slab)
 	if (unlikely(s->flags & SLAB_TYPESAFE_BY_RCU))
 		call_rcu(&slab->rcu_head, rcu_free_slab);
 	else
-		__free_slab(s, slab);
+		__free_slab(s, slab, true);
 }
 
 static void discard_slab(struct kmem_cache *s, struct slab *slab)
@@ -3375,8 +3384,6 @@ static void *alloc_single_from_partial(struct kmem_cache *s,
 	return object;
 }
 
-static void defer_deactivate_slab(struct slab *slab, void *flush_freelist);
-
 /*
  * Called only for kmem_cache_debug() caches to allocate from a freshly
  * allocated slab. Allocate a single object instead of whole freelist
@@ -3392,8 +3399,8 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s, struct slab *slab,
 	void *object;
 
 	if (!allow_spin && !spin_trylock_irqsave(&n->list_lock, flags)) {
-		/* Unlucky, discard newly allocated slab */
-		defer_deactivate_slab(slab, NULL);
+		/* Unlucky, discard newly allocated slab. */
+		free_new_slab_nolock(s, slab);
 		return NULL;
 	}
 
@@ -4262,7 +4269,7 @@ static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
 
 		if (!spin_trylock_irqsave(&n->list_lock, flags)) {
 			/* Unlucky, discard newly allocated slab */
-			defer_deactivate_slab(slab, NULL);
+			free_new_slab_nolock(s, slab);
 			return 0;
 		}
 	}
@@ -6031,7 +6038,6 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
 
 struct defer_free {
 	struct llist_head objects;
-	struct llist_head slabs;
 	struct irq_work work;
 };
 
@@ -6039,7 +6045,6 @@ static void free_deferred_objects(struct irq_work *work);
 
 static DEFINE_PER_CPU(struct defer_free, defer_free_objects) = {
 	.objects = LLIST_HEAD_INIT(objects),
-	.slabs = LLIST_HEAD_INIT(slabs),
 	.work = IRQ_WORK_INIT(free_deferred_objects),
 };
 
@@ -6052,10 +6057,9 @@ static void free_deferred_objects(struct irq_work *work)
 {
 	struct defer_free *df = container_of(work, struct defer_free, work);
 	struct llist_head *objs = &df->objects;
-	struct llist_head *slabs = &df->slabs;
 	struct llist_node *llnode, *pos, *t;
 
-	if (llist_empty(objs) && llist_empty(slabs))
+	if (llist_empty(objs))
 		return;
 
 	llnode = llist_del_all(objs);
@@ -6079,16 +6083,6 @@ static void free_deferred_objects(struct irq_work *work)
 
 		__slab_free(s, slab, x, x, 1, _THIS_IP_);
 	}
-
-	llnode = llist_del_all(slabs);
-	llist_for_each_safe(pos, t, llnode) {
-		struct slab *slab = container_of(pos, struct slab, llnode);
-
-		if (slab->frozen)
-			deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
-		else
-			free_slab(slab->slab_cache, slab);
-	}
 }
 
 static void defer_free(struct kmem_cache *s, void *head)
@@ -6102,19 +6096,6 @@ static void defer_free(struct kmem_cache *s, void *head)
 		irq_work_queue(&df->work);
 }
 
-static void defer_deactivate_slab(struct slab *slab, void *flush_freelist)
-{
-	struct defer_free *df;
-
-	slab->flush_freelist = flush_freelist;
-
-	guard(preempt)();
-
-	df = this_cpu_ptr(&defer_free_objects);
-	if (llist_add(&slab->llnode, &df->slabs))
-		irq_work_queue(&df->work);
-}
-
 void defer_free_barrier(void)
 {
 	int cpu;

-- 
2.52.0


