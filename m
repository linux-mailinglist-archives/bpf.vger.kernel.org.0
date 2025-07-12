Return-Path: <bpf+bounces-63111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84484B028DB
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 03:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28A25A37A7
	for <lists+bpf@lfdr.de>; Sat, 12 Jul 2025 01:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0F1581F8;
	Sat, 12 Jul 2025 01:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpXG34S4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A016D7DA6C
	for <bpf@vger.kernel.org>; Sat, 12 Jul 2025 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752285352; cv=none; b=Icb+brNiNKAaaT060gE7U5PTSFzYcBrGuc+3q1imDM7rNbwkAkKOKRr3ynvNwihYC8pL5RjOYim4NjwmCXGA9R4BPWcuJxuPaP4ccrJygcoKufOQIkwHUbkAgCSOttsO2AgJh4Ew3Yh4sphin2NhnGNAvta05Svo02y4uEBif9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752285352; c=relaxed/simple;
	bh=4VaA2+45x8IKII5WwnbVRAj56en65LZb+S6Cq98Z11M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjlM0Ee+yqLDKnRhOQ/LBewtJ41ZzfPItiAm9ok8XdgybaRT+7UHH7ufKmeWAiMWxrHTvwEqwFRohI1jsATaLDAZwFvDv7csd/KdD5+Q9xN9hDTm0zAoIUTslNlu7qcZVUc55lvkHWvVufk33e/kqDM8QhtOTZUeTn+fCMYlOR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpXG34S4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-312e747d2d8so3231996a91.0
        for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 18:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752285350; x=1752890150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rg+r9L8StXhbjYVCsH0jzU9YcZJUfRA3GM3f05TYwMw=;
        b=MpXG34S4kB9TiYc74sjBIwGJUHcGvm2vhHqOlgWAnFuiSHk9eohZAvq0GkcgujrquX
         EvwuA+I37O8EjSvN5tOMKmDn3yM93p9+9E5Uj47jwGxKobkV+54bcR9BKYQQTpF/n06a
         JwFRFhQZthhwkYSZrsJUoRjQS73jDVl8rg7J859wvx+k6FgjJI4E3VKkxhZQf6aSPHTH
         dqAQ/cklJJtFDHnGxYzux7srfDOfLucK/0nID6K1uyZSlNPXu7b0W+bpNHq2ZaJVJA2u
         kMJXvOvlO6g51Ex7EkUe/ucF+QF9pORQ97A9dyGDuaMDpJbhAGs/ZYeOSfEt/c0/iRnn
         oTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752285350; x=1752890150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rg+r9L8StXhbjYVCsH0jzU9YcZJUfRA3GM3f05TYwMw=;
        b=CY/vKFoSTR96t3VfOUHSC6dWshtPaLlDxcdylDMz8nFAvoL3Ex8PrWsulzqptUZDnN
         5Awl90QoFQ2dEt8jPDVNd0+Hvp66Y6r9uIiEeKtlJn2MZimoolU+tALwFk4iLvLNf6GT
         ZiaoDsXOC6Zg3kfQh7F+/iwtFUIhQPbZUsAGKD6gkAkzogz/V8x+gd8zSsZWlW/ThsHZ
         HvflmkvEscIh2/NuSd18rpo9Hsi1CerxYVZEB2kxTzI1St/rfvRNrM+Ia0lai/SFWBY0
         j8Sjzz98x4KREXAho5cOqSroWbt1em3/CkHTTOH7dw083iknHR+4yAdQWUne6LHGQ/1Q
         FBNg==
X-Forwarded-Encrypted: i=1; AJvYcCUrEZm+QGvhIOUKL7XRiBNFy2hmFCUFQ7a3vG4gRkJe9xHOobBRmqpfIVd10GaFFDNkjd4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/2CAESY/NGKrx5gMbR1iLlQf64LsoHgW1lLhdmR57d1CxZuoE
	aLkF5ppFjTv1GcQ0hEwOJYXTy4AnG+sbR8NMAeaoEM3ZzCAF3LFbQvM1
X-Gm-Gg: ASbGncs38aqNv8gL77aHZo53EmqfZ5iEGjNoeGqmED1rOVr7yQMn3siq+RdpvC55Ww7
	KOyttpJKvdc2K+4qN4H3jDmzQHfEvklEpVmxLgnaWpatw4BU4+NxQ7EXPE7lN7WNRHTPv+h4Yl2
	H2wvOoSLgdMhVkZhiaTbpXnOZZqUOuVP6Y9sF8SM+GZ1vKsMgW6nsVCWbi1yFQ1p6rwpfyIVcFx
	/TmRbmfDVK6qdBZpt91zDz8g9f32RmCMMolvGsRzoM66bJKj+TV+LUGOHV8Tr59IrwUoMq7RJkw
	1p7GPI/JjDbv8G+/h5aPea5OvCOKpI5w/z0fB/sBvTNXdrEvoyf6w6QNrmngPTU9In3YI+u+cLv
	z7kaNboVpB9WhSVxHH2uqwY2BPJSHYAwRIkVGmfwWup1vn6R9w3I0sWYXUxesAg==
X-Google-Smtp-Source: AGHT+IERWo2p/ZO5/TKXEfjpVUC08IFnWvFBn48ZcAA+LDOoAHf0PtOLeaNlKNokaVkyfQp+1ilL5Q==
X-Received: by 2002:a17:90a:d886:b0:312:dbcd:b93d with SMTP id 98e67ed59e1d1-31c3d0c2bc7mr14503874a91.14.1752285349504;
        Fri, 11 Jul 2025 18:55:49 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2001:558:600a:7:a83d:600f:32cc:235a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e95815bsm6030865a91.3.2025.07.11.18.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 18:55:48 -0700 (PDT)
Date: Fri, 11 Jul 2025 18:55:47 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Harry Yoo <harry.yoo@oracle.com>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <vbmtgolrluopr2py33faosl43dhh5k6poq4qei5cvjo6mvriyt@ebvc6z2r42j3>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com>
 <683189c3-934e-4398-b970-34584ac70a69@suse.cz>
 <aG-UMkt-AQpu8mKq@hyeyoo>
 <e9bab147-5b36-4f9a-85b0-64740b84e826@suse.cz>
 <CAADnVQ+G340va8h2B7nNO00mWxbP_chx3oHW2PYrKt2AfOZS8w@mail.gmail.com>
 <59c621bf-17cd-40ac-af99-3c7cb6ecafc3@suse.cz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59c621bf-17cd-40ac-af99-3c7cb6ecafc3@suse.cz>

On Fri, Jul 11, 2025 at 12:30:19PM +0200, Vlastimil Babka wrote:
> > and
> > static DEFINE_PER_CPU(struct llist_head, defer_deactivate_slabs);
> 
> Should work. Also deactivate_slab() should be the correct operation for both
> a slab from partial list and a newly allocated one.
> But oops, where do we store all the parameters for deactivate_slab() We can
> probably reuse the union with "struct list_head slab_list" for queueing.
> kmem_cache pointer can be simply taken from struct slab, it's already tehre.
> But the separate flush_freelist pointer? Maybe take advantage of list_head
> being two pointers and struct llist_node just one pointer, so what we need
> will still fit?
> 
> Otherwise we could do the first two phases of deactivate_slab() immediately
> and only defer the third phase where the freelists are already merged and
> there's no freelist pointer to handle anymore. But if it's not necessary,
> let's not complicate.
> 
> Also should kmem_cache_destroy() path now get a barrier to flush all pending
> irq_work? Does it exist?

Thanks a lot everyone for great feedback.

Here is what I have so far that addresses the comments.
The only thing I struggle with is how to properly test
"if (unlikely(c->slab))"
condition in retry_load_slab.
I couldn't trigger it no matter what I tried.
So I manually unit-tested defer_deactivate_slab() bits with hacks.

Will fold and respin next week.

--
From 7efd089831b1e1968f12c7c4e058375bd126f9f6 Mon Sep 17 00:00:00 2001
From: Alexei Starovoitov <ast@kernel.org>
Date: Fri, 11 Jul 2025 16:56:12 -0700
Subject: [PATCH slab] slab: fixes

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 mm/Kconfig       |   1 +
 mm/slab.h        |   6 +++
 mm/slab_common.c |   3 ++
 mm/slub.c        | 112 ++++++++++++++++++++++++++++++-----------------
 4 files changed, 83 insertions(+), 39 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 0287e8d94aea..331a14d678b3 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -206,6 +206,7 @@ menu "Slab allocator options"
 
 config SLUB
 	def_bool y
+	select IRQ_WORK
 
 config KVFREE_RCU_BATCHED
 	def_bool y
diff --git a/mm/slab.h b/mm/slab.h
index 05a21dc796e0..65f4616b41de 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -57,6 +57,10 @@ struct slab {
 		struct {
 			union {
 				struct list_head slab_list;
+				struct { /* For deferred deactivate_slab() */
+					struct llist_node llnode;
+					void *flush_freelist;
+				};
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 				struct {
 					struct slab *next;
@@ -680,6 +684,8 @@ void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 void __check_heap_object(const void *ptr, unsigned long n,
 			 const struct slab *slab, bool to_user);
 
+void defer_free_barrier(void);
+
 static inline bool slub_debug_orig_size(struct kmem_cache *s)
 {
 	return (kmem_cache_debug_flags(s, SLAB_STORE_USER) &&
diff --git a/mm/slab_common.c b/mm/slab_common.c
index bfe7c40eeee1..937af8ab2501 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -507,6 +507,9 @@ void kmem_cache_destroy(struct kmem_cache *s)
 		rcu_barrier();
 	}
 
+	/* Wait for deferred work from kmalloc/kfree_nolock() */
+	defer_free_barrier();
+
 	cpus_read_lock();
 	mutex_lock(&slab_mutex);
 
diff --git a/mm/slub.c b/mm/slub.c
index dbecfd412e41..dc889cc59809 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2460,10 +2460,10 @@ static inline struct slab *alloc_slab_page(gfp_t flags, int node,
 	struct slab *slab;
 	unsigned int order = oo_order(oo);
 
-	if (unlikely(!allow_spin)) {
+	if (unlikely(!allow_spin))
 		folio = (struct folio *)alloc_frozen_pages_nolock(0/* __GFP_COMP is implied */,
 								  node, order);
-	} else if (node == NUMA_NO_NODE)
+	else if (node == NUMA_NO_NODE)
 		folio = (struct folio *)alloc_frozen_pages(flags, order);
 	else
 		folio = (struct folio *)__alloc_frozen_pages(flags, order, node, NULL);
@@ -3694,6 +3694,8 @@ static inline void *freeze_slab(struct kmem_cache *s, struct slab *slab)
 	return freelist;
 }
 
+static void defer_deactivate_slab(struct slab *slab);
+
 /*
  * Slow path. The lockless freelist is empty or we need to perform
  * debugging duties.
@@ -3742,14 +3744,13 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (unlikely(!node_match(slab, node))) {
 		/*
 		 * same as above but node_match() being false already
-		 * implies node != NUMA_NO_NODE
+		 * implies node != NUMA_NO_NODE.
+		 * Reentrant slub cannot take locks necessary to
+		 * deactivate_slab, hence ignore node preference.
+		 * kmalloc_nolock() doesn't allow __GFP_THISNODE.
 		 */
 		if (!node_isset(node, slab_nodes) ||
 		    !allow_spin) {
-			/*
-			 * Reentrant slub cannot take locks necessary
-			 * to deactivate_slab, hence downgrade to any node
-			 */
 			node = NUMA_NO_NODE;
 		} else {
 			stat(s, ALLOC_NODE_MISMATCH);
@@ -3953,19 +3954,19 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		void *flush_freelist = c->freelist;
 		struct slab *flush_slab = c->slab;
 
-		if (unlikely(!allow_spin))
-			/*
-			 * Reentrant slub cannot take locks
-			 * necessary for deactivate_slab()
-			 */
-			return NULL;
 		c->slab = NULL;
 		c->freelist = NULL;
 		c->tid = next_tid(c->tid);
 
 		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 
-		deactivate_slab(s, flush_slab, flush_freelist);
+		if (unlikely(!allow_spin)) {
+			/* Reentrant slub cannot take locks, defer */
+			flush_slab->flush_freelist = flush_freelist;
+			defer_deactivate_slab(flush_slab);
+		} else {
+			deactivate_slab(s, flush_slab, flush_freelist);
+		}
 
 		stat(s, CPUSLAB_FLUSH);
 
@@ -4707,18 +4708,36 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 	discard_slab(s, slab);
 }
 
-static DEFINE_PER_CPU(struct llist_head, defer_free_objects);
-static DEFINE_PER_CPU(struct irq_work, defer_free_work);
+struct defer_free {
+	struct llist_head objects;
+	struct llist_head slabs;
+	struct irq_work work;
+};
+
+static void free_deferred_objects(struct irq_work *work);
 
+static DEFINE_PER_CPU(struct defer_free, defer_free_objects) = {
+	.objects = LLIST_HEAD_INIT(objects),
+	.slabs = LLIST_HEAD_INIT(slabs),
+	.work = IRQ_WORK_INIT(free_deferred_objects),
+};
+
+/*
+ * In PREEMPT_RT irq_work runs in per-cpu kthread, so it's safe
+ * to take sleeping spin_locks from __slab_free() and deactivate_slab().
+ * In !PREEMPT_RT irq_work will run after local_unlock_irqrestore().
+ */
 static void free_deferred_objects(struct irq_work *work)
 {
-	struct llist_head *llhead = this_cpu_ptr(&defer_free_objects);
+	struct defer_free *df = container_of(work, struct defer_free, work);
+	struct llist_head *objs = &df->objects;
+	struct llist_head *slabs = &df->slabs;
 	struct llist_node *llnode, *pos, *t;
 
-	if (llist_empty(llhead))
+	if (llist_empty(objs) && llist_empty(slabs))
 		return;
 
-	llnode = llist_del_all(llhead);
+	llnode = llist_del_all(objs);
 	llist_for_each_safe(pos, t, llnode) {
 		struct kmem_cache *s;
 		struct slab *slab;
@@ -4727,6 +4746,7 @@ static void free_deferred_objects(struct irq_work *work)
 		slab = virt_to_slab(x);
 		s = slab->slab_cache;
 
+		x -= s->offset;
 		/*
 		 * memcg, kasan_slab_pre are already done for 'x'.
 		 * The only thing left is kasan_poison.
@@ -4734,26 +4754,39 @@ static void free_deferred_objects(struct irq_work *work)
 		kasan_slab_free(s, x, false, false, true);
 		__slab_free(s, slab, x, x, 1, _THIS_IP_);
 	}
+
+	llnode = llist_del_all(slabs);
+	llist_for_each_safe(pos, t, llnode) {
+		struct slab *slab = container_of(pos, struct slab, llnode);
+
+		deactivate_slab(slab->slab_cache, slab, slab->flush_freelist);
+	}
 }
 
-static int __init init_defer_work(void)
+static void defer_free(struct kmem_cache *s, void *head)
 {
-	int cpu;
+	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
 
-	for_each_possible_cpu(cpu) {
-		init_llist_head(per_cpu_ptr(&defer_free_objects, cpu));
-		init_irq_work(per_cpu_ptr(&defer_free_work, cpu),
-			      free_deferred_objects);
-	}
-	return 0;
+	if (llist_add(head + s->offset, &df->objects))
+		irq_work_queue(&df->work);
 }
-late_initcall(init_defer_work);
 
-static void defer_free(void *head)
+static void defer_deactivate_slab(struct slab *slab)
 {
-	if (llist_add(head, this_cpu_ptr(&defer_free_objects)))
-		irq_work_queue(this_cpu_ptr(&defer_free_work));
+	struct defer_free *df = this_cpu_ptr(&defer_free_objects);
+
+	if (llist_add(&slab->llnode, &df->slabs))
+		irq_work_queue(&df->work);
+}
+
+void defer_free_barrier(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
 }
+
 #ifndef CONFIG_SLUB_TINY
 /*
  * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
@@ -4774,6 +4807,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 				struct slab *slab, void *head, void *tail,
 				int cnt, unsigned long addr)
 {
+	/* cnt == 0 signals that it's called from kfree_nolock() */
+	bool allow_spin = cnt;
 	struct kmem_cache_cpu *c;
 	unsigned long tid;
 	void **freelist;
@@ -4792,28 +4827,27 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
 	barrier();
 
 	if (unlikely(slab != c->slab)) {
-		/* cnt == 0 signals that it's called from kfree_nolock() */
-		if (unlikely(!cnt)) {
+		if (unlikely(!allow_spin)) {
 			/*
 			 * __slab_free() can locklessly cmpxchg16 into a slab,
 			 * but then it might need to take spin_lock or local_lock
 			 * in put_cpu_partial() for further processing.
 			 * Avoid the complexity and simply add to a deferred list.
 			 */
-			defer_free(head);
+			defer_free(s, head);
 		} else {
 			__slab_free(s, slab, head, tail, cnt, addr);
 		}
 		return;
 	}
 
-	if (unlikely(!cnt)) {
+	if (unlikely(!allow_spin)) {
 		if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
 		    local_lock_is_locked(&s->cpu_slab->lock)) {
-			defer_free(head);
+			defer_free(s, head);
 			return;
 		}
-		cnt = 1;
+		cnt = 1; /* restore cnt. kfree_nolock() frees one object at a time */
 		kasan_slab_free(s, head, false, false, /* skip quarantine */true);
 	}
 
@@ -5065,7 +5099,7 @@ void kfree(const void *object)
 EXPORT_SYMBOL(kfree);
 
 /*
- * Can be called while holding raw_spin_lock or from IRQ and NMI,
+ * Can be called while holding raw_spinlock_t or from IRQ and NMI,
  * but only for objects allocated by kmalloc_nolock(),
  * since some debug checks (like kmemleak and kfence) were
  * skipped on allocation. large_kmalloc is not supported either.
@@ -5115,7 +5149,7 @@ void kfree_nolock(const void *object)
 #ifndef CONFIG_SLUB_TINY
 	do_slab_free(s, slab, x, x, 0, _RET_IP_);
 #else
-	defer_free(x);
+	defer_free(s, x);
 #endif
 }
 EXPORT_SYMBOL_GPL(kfree_nolock);
-- 
2.47.1


