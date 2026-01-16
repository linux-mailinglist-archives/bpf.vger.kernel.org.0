Return-Path: <bpf+bounces-79281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDADD32F36
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B71F31A5FAA
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3711F3A0E86;
	Fri, 16 Jan 2026 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wlDHTb4I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuUiQAh/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wlDHTb4I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WuUiQAh/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8EB3A0B29
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574503; cv=none; b=AkWaa+Shbv8Mm1T7QBgfa/7nJjYrRnbBUaH7wvwmS7uhnCtNOTfECdLk6C3caDZrcksPq025bNuTMEPQ3qMxN93qJyJpT6XMPZq3vXyZXkFooMqElCbr2Wo4pa2rkPQzzaogMPdlsGMjNeKTBRsqM+me2u0LJKd+S0/fjk1+u/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574503; c=relaxed/simple;
	bh=93ZmKnHm5wNIsky3m4hiQ4ky5h6V4xap2UG05FbClFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJHcMsZAaRGjCJ+KNTtctOKnjFi+E+SUGPmuWFw5NYcxH7DPMwSRBqrHWzMTwUQzOG1wkhkWFMMedQjFUKJLlkGtFqR3bU1Rh2v74YdJyDmZcmx4V+Yp0w2AlfMa8RkThx87OuuxayiwUb+p/16SrWDwhOO/HDXuHJ/3PhMCwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wlDHTb4I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuUiQAh/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wlDHTb4I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WuUiQAh/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50B495BE94;
	Fri, 16 Jan 2026 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlmRMlA71C/tKf49jhF6FlOyuOpzrs+mYjdHh/yliVg=;
	b=wlDHTb4IowX3UuYiQgptK9/I5/BthhEzVQVuwibep72TbQSOp2WY8dynw6RvNlGRNbBK/k
	v+b4qllkJolK52TAyiwe4IiFMAdqseZXZL+1H5SL9fJC3fJhTqXIYU2udiwqCd1Ds8s7PM
	6A/VtuuG0UzVLXDzTB0X8Fh6vzkgbC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlmRMlA71C/tKf49jhF6FlOyuOpzrs+mYjdHh/yliVg=;
	b=WuUiQAh/KkKdJUE364jU0iiD70kplO1ypmAvuoFh5P07E3cgLJSRkyrI+vT0o+z7vEsUCG
	tWtUELa7/X99vyBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wlDHTb4I;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="WuUiQAh/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlmRMlA71C/tKf49jhF6FlOyuOpzrs+mYjdHh/yliVg=;
	b=wlDHTb4IowX3UuYiQgptK9/I5/BthhEzVQVuwibep72TbQSOp2WY8dynw6RvNlGRNbBK/k
	v+b4qllkJolK52TAyiwe4IiFMAdqseZXZL+1H5SL9fJC3fJhTqXIYU2udiwqCd1Ds8s7PM
	6A/VtuuG0UzVLXDzTB0X8Fh6vzkgbC8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlmRMlA71C/tKf49jhF6FlOyuOpzrs+mYjdHh/yliVg=;
	b=WuUiQAh/KkKdJUE364jU0iiD70kplO1ypmAvuoFh5P07E3cgLJSRkyrI+vT0o+z7vEsUCG
	tWtUELa7/X99vyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31EFB3EA66;
	Fri, 16 Jan 2026 14:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4AjoC+ZNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:35 +0100
Subject: [PATCH v3 15/21] slab: remove struct kmem_cache_cpu
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-15-5595cb000772@suse.cz>
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
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 50B495BE94
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

The cpu slab is not used anymore for allocation or freeing, the
remaining code is for flushing, but it's effectively dead.  Remove the
whole struct kmem_cache_cpu, the flushing code and other orphaned
functions.

The remaining used field of kmem_cache_cpu is the stat array with
CONFIG_SLUB_STATS. Put it instead in a new struct kmem_cache_stats.
In struct kmem_cache, the field is cpu_stats and placed near the
end of the struct.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h |   7 +-
 mm/slub.c | 298 +++++---------------------------------------------------------
 2 files changed, 24 insertions(+), 281 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index e9a0738133ed..87faeb6143f2 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -21,14 +21,12 @@
 # define system_has_freelist_aba()	system_has_cmpxchg128()
 # define try_cmpxchg_freelist		try_cmpxchg128
 # endif
-#define this_cpu_try_cmpxchg_freelist	this_cpu_try_cmpxchg128
 typedef u128 freelist_full_t;
 #else /* CONFIG_64BIT */
 # ifdef system_has_cmpxchg64
 # define system_has_freelist_aba()	system_has_cmpxchg64()
 # define try_cmpxchg_freelist		try_cmpxchg64
 # endif
-#define this_cpu_try_cmpxchg_freelist	this_cpu_try_cmpxchg64
 typedef u64 freelist_full_t;
 #endif /* CONFIG_64BIT */
 
@@ -189,7 +187,6 @@ struct kmem_cache_order_objects {
  * Slab cache management.
  */
 struct kmem_cache {
-	struct kmem_cache_cpu __percpu *cpu_slab;
 	struct slub_percpu_sheaves __percpu *cpu_sheaves;
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
@@ -238,6 +235,10 @@ struct kmem_cache {
 	unsigned int usersize;		/* Usercopy region size */
 #endif
 
+#ifdef CONFIG_SLUB_STATS
+	struct kmem_cache_stats __percpu *cpu_stats;
+#endif
+
 	struct kmem_cache_node *node[MAX_NUMNODES];
 };
 
diff --git a/mm/slub.c b/mm/slub.c
index 8746d9d3f3a3..bb72cfa2d7ec 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -400,28 +400,11 @@ enum stat_item {
 	NR_SLUB_STAT_ITEMS
 };
 
-struct freelist_tid {
-	union {
-		struct {
-			void *freelist;		/* Pointer to next available object */
-			unsigned long tid;	/* Globally unique transaction id */
-		};
-		freelist_full_t freelist_tid;
-	};
-};
-
-/*
- * When changing the layout, make sure freelist and tid are still compatible
- * with this_cpu_cmpxchg_double() alignment requirements.
- */
-struct kmem_cache_cpu {
-	struct freelist_tid;
-	struct slab *slab;	/* The slab from which we are allocating */
-	local_trylock_t lock;	/* Protects the fields above */
 #ifdef CONFIG_SLUB_STATS
+struct kmem_cache_stats {
 	unsigned int stat[NR_SLUB_STAT_ITEMS];
-#endif
 };
+#endif
 
 static inline void stat(const struct kmem_cache *s, enum stat_item si)
 {
@@ -430,7 +413,7 @@ static inline void stat(const struct kmem_cache *s, enum stat_item si)
 	 * The rmw is racy on a preemptible kernel but this is acceptable, so
 	 * avoid this_cpu_add()'s irq-disable overhead.
 	 */
-	raw_cpu_inc(s->cpu_slab->stat[si]);
+	raw_cpu_inc(s->cpu_stats->stat[si]);
 #endif
 }
 
@@ -438,7 +421,7 @@ static inline
 void stat_add(const struct kmem_cache *s, enum stat_item si, int v)
 {
 #ifdef CONFIG_SLUB_STATS
-	raw_cpu_add(s->cpu_slab->stat[si], v);
+	raw_cpu_add(s->cpu_stats->stat[si], v);
 #endif
 }
 
@@ -1160,20 +1143,6 @@ static void object_err(struct kmem_cache *s, struct slab *slab,
 	WARN_ON(1);
 }
 
-static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
-			       void **freelist, void *nextfree)
-{
-	if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
-	    !check_valid_pointer(s, slab, nextfree) && freelist) {
-		object_err(s, slab, *freelist, "Freechain corrupt");
-		*freelist = NULL;
-		slab_fix(s, "Isolate corrupted freechain");
-		return true;
-	}
-
-	return false;
-}
-
 static void __slab_err(struct slab *slab)
 {
 	if (slab_in_kunit_test())
@@ -1955,11 +1924,6 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
-static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
-			       void **freelist, void *nextfree)
-{
-	return false;
-}
 #endif /* CONFIG_SLUB_DEBUG */
 
 /*
@@ -3655,191 +3619,6 @@ static void *get_partial(struct kmem_cache *s, int node,
 	return get_any_partial(s, pc);
 }
 
-#ifdef CONFIG_PREEMPTION
-/*
- * Calculate the next globally unique transaction for disambiguation
- * during cmpxchg. The transactions start with the cpu number and are then
- * incremented by CONFIG_NR_CPUS.
- */
-#define TID_STEP  roundup_pow_of_two(CONFIG_NR_CPUS)
-#else
-/*
- * No preemption supported therefore also no need to check for
- * different cpus.
- */
-#define TID_STEP 1
-#endif /* CONFIG_PREEMPTION */
-
-static inline unsigned long next_tid(unsigned long tid)
-{
-	return tid + TID_STEP;
-}
-
-#ifdef SLUB_DEBUG_CMPXCHG
-static inline unsigned int tid_to_cpu(unsigned long tid)
-{
-	return tid % TID_STEP;
-}
-
-static inline unsigned long tid_to_event(unsigned long tid)
-{
-	return tid / TID_STEP;
-}
-#endif
-
-static inline unsigned int init_tid(int cpu)
-{
-	return cpu;
-}
-
-static void init_kmem_cache_cpus(struct kmem_cache *s)
-{
-	int cpu;
-	struct kmem_cache_cpu *c;
-
-	for_each_possible_cpu(cpu) {
-		c = per_cpu_ptr(s->cpu_slab, cpu);
-		local_trylock_init(&c->lock);
-		c->tid = init_tid(cpu);
-	}
-}
-
-/*
- * Finishes removing the cpu slab. Merges cpu's freelist with slab's freelist,
- * unfreezes the slabs and puts it on the proper list.
- * Assumes the slab has been already safely taken away from kmem_cache_cpu
- * by the caller.
- */
-static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
-			    void *freelist)
-{
-	struct kmem_cache_node *n = get_node(s, slab_nid(slab));
-	int free_delta = 0;
-	void *nextfree, *freelist_iter, *freelist_tail;
-	int tail = DEACTIVATE_TO_HEAD;
-	unsigned long flags = 0;
-	struct freelist_counters old, new;
-
-	if (READ_ONCE(slab->freelist)) {
-		stat(s, DEACTIVATE_REMOTE_FREES);
-		tail = DEACTIVATE_TO_TAIL;
-	}
-
-	/*
-	 * Stage one: Count the objects on cpu's freelist as free_delta and
-	 * remember the last object in freelist_tail for later splicing.
-	 */
-	freelist_tail = NULL;
-	freelist_iter = freelist;
-	while (freelist_iter) {
-		nextfree = get_freepointer(s, freelist_iter);
-
-		/*
-		 * If 'nextfree' is invalid, it is possible that the object at
-		 * 'freelist_iter' is already corrupted.  So isolate all objects
-		 * starting at 'freelist_iter' by skipping them.
-		 */
-		if (freelist_corrupted(s, slab, &freelist_iter, nextfree))
-			break;
-
-		freelist_tail = freelist_iter;
-		free_delta++;
-
-		freelist_iter = nextfree;
-	}
-
-	/*
-	 * Stage two: Unfreeze the slab while splicing the per-cpu
-	 * freelist to the head of slab's freelist.
-	 */
-	do {
-		old.freelist = READ_ONCE(slab->freelist);
-		old.counters = READ_ONCE(slab->counters);
-		VM_BUG_ON(!old.frozen);
-
-		/* Determine target state of the slab */
-		new.counters = old.counters;
-		new.frozen = 0;
-		if (freelist_tail) {
-			new.inuse -= free_delta;
-			set_freepointer(s, freelist_tail, old.freelist);
-			new.freelist = freelist;
-		} else {
-			new.freelist = old.freelist;
-		}
-	} while (!slab_update_freelist(s, slab, &old, &new, "unfreezing slab"));
-
-	/*
-	 * Stage three: Manipulate the slab list based on the updated state.
-	 */
-	if (!new.inuse && n->nr_partial >= s->min_partial) {
-		stat(s, DEACTIVATE_EMPTY);
-		discard_slab(s, slab);
-		stat(s, FREE_SLAB);
-	} else if (new.freelist) {
-		spin_lock_irqsave(&n->list_lock, flags);
-		add_partial(n, slab, tail);
-		spin_unlock_irqrestore(&n->list_lock, flags);
-		stat(s, tail);
-	} else {
-		stat(s, DEACTIVATE_FULL);
-	}
-}
-
-static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
-{
-	unsigned long flags;
-	struct slab *slab;
-	void *freelist;
-
-	local_lock_irqsave(&s->cpu_slab->lock, flags);
-
-	slab = c->slab;
-	freelist = c->freelist;
-
-	c->slab = NULL;
-	c->freelist = NULL;
-	c->tid = next_tid(c->tid);
-
-	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-
-	if (slab) {
-		deactivate_slab(s, slab, freelist);
-		stat(s, CPUSLAB_FLUSH);
-	}
-}
-
-static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
-{
-	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
-	void *freelist = c->freelist;
-	struct slab *slab = c->slab;
-
-	c->slab = NULL;
-	c->freelist = NULL;
-	c->tid = next_tid(c->tid);
-
-	if (slab) {
-		deactivate_slab(s, slab, freelist);
-		stat(s, CPUSLAB_FLUSH);
-	}
-}
-
-static inline void flush_this_cpu_slab(struct kmem_cache *s)
-{
-	struct kmem_cache_cpu *c = this_cpu_ptr(s->cpu_slab);
-
-	if (c->slab)
-		flush_slab(s, c);
-}
-
-static bool has_cpu_slab(int cpu, struct kmem_cache *s)
-{
-	struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab, cpu);
-
-	return c->slab;
-}
-
 static bool has_pcs_used(int cpu, struct kmem_cache *s)
 {
 	struct slub_percpu_sheaves *pcs;
@@ -3853,7 +3632,7 @@ static bool has_pcs_used(int cpu, struct kmem_cache *s)
 }
 
 /*
- * Flush cpu slab.
+ * Flush percpu sheaves
  *
  * Called from CPU work handler with migration disabled.
  */
@@ -3868,8 +3647,6 @@ static void flush_cpu_slab(struct work_struct *w)
 
 	if (cache_has_sheaves(s))
 		pcs_flush_all(s);
-
-	flush_this_cpu_slab(s);
 }
 
 static void flush_all_cpus_locked(struct kmem_cache *s)
@@ -3882,7 +3659,7 @@ static void flush_all_cpus_locked(struct kmem_cache *s)
 
 	for_each_online_cpu(cpu) {
 		sfw = &per_cpu(slub_flush, cpu);
-		if (!has_cpu_slab(cpu, s) && !has_pcs_used(cpu, s)) {
+		if (!has_pcs_used(cpu, s)) {
 			sfw->skip = true;
 			continue;
 		}
@@ -3992,7 +3769,6 @@ static int slub_cpu_dead(unsigned int cpu)
 
 	mutex_lock(&slab_mutex);
 	list_for_each_entry(s, &slab_caches, list) {
-		__flush_cpu_slab(s, cpu);
 		if (cache_has_sheaves(s))
 			__pcs_flush_all_cpu(s, cpu);
 	}
@@ -7121,26 +6897,21 @@ init_kmem_cache_node(struct kmem_cache_node *n, struct node_barn *barn)
 		barn_init(barn);
 }
 
-static inline int alloc_kmem_cache_cpus(struct kmem_cache *s)
+#ifdef CONFIG_SLUB_STATS
+static inline int alloc_kmem_cache_stats(struct kmem_cache *s)
 {
 	BUILD_BUG_ON(PERCPU_DYNAMIC_EARLY_SIZE <
 			NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH *
-			sizeof(struct kmem_cache_cpu));
+			sizeof(struct kmem_cache_stats));
 
-	/*
-	 * Must align to double word boundary for the double cmpxchg
-	 * instructions to work; see __pcpu_double_call_return_bool().
-	 */
-	s->cpu_slab = __alloc_percpu(sizeof(struct kmem_cache_cpu),
-				     2 * sizeof(void *));
+	s->cpu_stats = alloc_percpu(struct kmem_cache_stats);
 
-	if (!s->cpu_slab)
+	if (!s->cpu_stats)
 		return 0;
 
-	init_kmem_cache_cpus(s);
-
 	return 1;
 }
+#endif
 
 static int init_percpu_sheaves(struct kmem_cache *s)
 {
@@ -7252,7 +7023,9 @@ void __kmem_cache_release(struct kmem_cache *s)
 	cache_random_seq_destroy(s);
 	if (s->cpu_sheaves)
 		pcs_destroy(s);
-	free_percpu(s->cpu_slab);
+#ifdef CONFIG_SLUB_STATS
+	free_percpu(s->cpu_stats);
+#endif
 	free_kmem_cache_nodes(s);
 }
 
@@ -7944,12 +7717,6 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 
 	memcpy(s, static_cache, kmem_cache->object_size);
 
-	/*
-	 * This runs very early, and only the boot processor is supposed to be
-	 * up.  Even if it weren't true, IRQs are not up so we couldn't fire
-	 * IPIs around.
-	 */
-	__flush_cpu_slab(s, smp_processor_id());
 	for_each_kmem_cache_node(s, node, n) {
 		struct slab *p;
 
@@ -8164,8 +7931,10 @@ int do_kmem_cache_create(struct kmem_cache *s, const char *name,
 	if (!init_kmem_cache_nodes(s))
 		goto out;
 
-	if (!alloc_kmem_cache_cpus(s))
+#ifdef CONFIG_SLUB_STATS
+	if (!alloc_kmem_cache_stats(s))
 		goto out;
+#endif
 
 	err = init_percpu_sheaves(s);
 	if (err)
@@ -8484,33 +8253,6 @@ static ssize_t show_slab_objects(struct kmem_cache *s,
 	if (!nodes)
 		return -ENOMEM;
 
-	if (flags & SO_CPU) {
-		int cpu;
-
-		for_each_possible_cpu(cpu) {
-			struct kmem_cache_cpu *c = per_cpu_ptr(s->cpu_slab,
-							       cpu);
-			int node;
-			struct slab *slab;
-
-			slab = READ_ONCE(c->slab);
-			if (!slab)
-				continue;
-
-			node = slab_nid(slab);
-			if (flags & SO_TOTAL)
-				x = slab->objects;
-			else if (flags & SO_OBJECTS)
-				x = slab->inuse;
-			else
-				x = 1;
-
-			total += x;
-			nodes[node] += x;
-
-		}
-	}
-
 	/*
 	 * It is impossible to take "mem_hotplug_lock" here with "kernfs_mutex"
 	 * already held which will conflict with an existing lock order:
@@ -8881,7 +8623,7 @@ static int show_stat(struct kmem_cache *s, char *buf, enum stat_item si)
 		return -ENOMEM;
 
 	for_each_online_cpu(cpu) {
-		unsigned x = per_cpu_ptr(s->cpu_slab, cpu)->stat[si];
+		unsigned int x = per_cpu_ptr(s->cpu_stats, cpu)->stat[si];
 
 		data[cpu] = x;
 		sum += x;
@@ -8907,7 +8649,7 @@ static void clear_stat(struct kmem_cache *s, enum stat_item si)
 	int cpu;
 
 	for_each_online_cpu(cpu)
-		per_cpu_ptr(s->cpu_slab, cpu)->stat[si] = 0;
+		per_cpu_ptr(s->cpu_stats, cpu)->stat[si] = 0;
 }
 
 #define STAT_ATTR(si, text) 					\

-- 
2.52.0


