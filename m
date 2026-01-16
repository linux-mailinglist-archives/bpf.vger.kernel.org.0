Return-Path: <bpf+bounces-79284-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BC4D32DA4
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 15:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAC0131B5A0E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 14:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBD33A1E64;
	Fri, 16 Jan 2026 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YIg7LUNR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHSg3RXI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YIg7LUNR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XHSg3RXI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D335B3A1D0B
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768574511; cv=none; b=LGj402V6fNyRyLJhpop/rkyoRGbq8geSCdwPkWSXqIWRTwDjks8s/cGod0YDB42g8Wu1sFrYxe8Oq8YjJ7cPh6BmilwlQXLNKntxsE3RnHd8UhX2Mfm6EeXGxw6s0VJysRTA1l4e8z8nQmjCkBBxJFMNXqTG7w9yxIcx++TGcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768574511; c=relaxed/simple;
	bh=rxyQhpiDT6Vfrw+/AwwQTUB8rNtMo9E4PTB1SCRLWvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqLUnLDKSXxkC3zAXL1z9e/lVbwOBhkb0N+PzkQIGqiQMcMipjSfS5ia6/l3U3JyZ5jugZZXY+VWr0dLODK4k6Nrg0m09FFZ+rFBeAM6eRggK3+84xaXJ0E/hE2N+oEahtAXVVL16/JVqZksu3ViNOdz0DJDICG+ZFGAybaUChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YIg7LUNR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XHSg3RXI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YIg7LUNR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XHSg3RXI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34C6C337CD;
	Fri, 16 Jan 2026 14:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lW8Ood/bwUVgrzq8dslY//7lpLYcu/ZEOKOtqQvI2s=;
	b=YIg7LUNRkDHtoX03L9UVgGmG4iwJ4yZCzcerQmIQhyO9lRGh/i5HutJbaVXIMYn7dvbcDI
	HNegctP8xYh8uDisNhcHoXlPLiKCzITawoyK/JIKfEKDaJGtY+asraHZTKVh0jv9Yi2KKD
	vUxq4ztWQy2NS2vaGGww7GNSQToFGjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lW8Ood/bwUVgrzq8dslY//7lpLYcu/ZEOKOtqQvI2s=;
	b=XHSg3RXIpj1ZmrTF+dnVIlvUn+uJq1uN/ZrcQSYhgFOMvcx3pCQN/kWUJRjBDVSQ4li67g
	D0Pms52i3TwTSRDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YIg7LUNR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XHSg3RXI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768574438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lW8Ood/bwUVgrzq8dslY//7lpLYcu/ZEOKOtqQvI2s=;
	b=YIg7LUNRkDHtoX03L9UVgGmG4iwJ4yZCzcerQmIQhyO9lRGh/i5HutJbaVXIMYn7dvbcDI
	HNegctP8xYh8uDisNhcHoXlPLiKCzITawoyK/JIKfEKDaJGtY+asraHZTKVh0jv9Yi2KKD
	vUxq4ztWQy2NS2vaGGww7GNSQToFGjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768574438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7lW8Ood/bwUVgrzq8dslY//7lpLYcu/ZEOKOtqQvI2s=;
	b=XHSg3RXIpj1ZmrTF+dnVIlvUn+uJq1uN/ZrcQSYhgFOMvcx3pCQN/kWUJRjBDVSQ4li67g
	D0Pms52i3TwTSRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16EB53EA65;
	Fri, 16 Jan 2026 14:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wChTBeZNamnydgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 14:40:38 +0000
From: Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 16 Jan 2026 15:40:34 +0100
Subject: [PATCH v3 14/21] slab: simplify kmalloc_nolock()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-sheaves-for-all-v3-14-5595cb000772@suse.cz>
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
	R_RATELIMIT(0.00)[to_ip_from(RLfsjnp7neds983g95ihcnuzgq),to(RL941jgdop1fyjkq8h4)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 34C6C337CD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

The kmalloc_nolock() implementation has several complications and
restrictions due to SLUB's cpu slab locking, lockless fastpath and
PREEMPT_RT differences. With cpu slab usage removed, we can simplify
things:

- relax the PREEMPT_RT context checks as they were before commit
  a4ae75d1b6a2 ("slab: fix kmalloc_nolock() context check for
  PREEMPT_RT") and also reference the explanation comment in the page
  allocator

- the local_lock_cpu_slab() macros became unused, remove them

- we no longer need to set up lockdep classes on PREEMPT_RT

- we no longer need to annotate ___slab_alloc as NOKPROBE_SYMBOL
  since there's no lockless cpu freelist manipulation anymore

- __slab_alloc_node() can be called from kmalloc_nolock_noprof()
  unconditionally. It can also no longer return EBUSY. But trylock
  failures can still happen so retry with the larger bucket if the
  allocation fails for any reason.

Note that we still need __CMPXCHG_DOUBLE, because while it was removed
we don't use cmpxchg16b on cpu freelist anymore, we still use it on
slab freelist, and the alternative is slab_lock() which can be
interrupted by a nmi. Clarify the comment to mention it specifically.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.h |   1 -
 mm/slub.c | 144 +++++++++++++-------------------------------------------------
 2 files changed, 29 insertions(+), 116 deletions(-)

diff --git a/mm/slab.h b/mm/slab.h
index 4efec41b6445..e9a0738133ed 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -190,7 +190,6 @@ struct kmem_cache_order_objects {
  */
 struct kmem_cache {
 	struct kmem_cache_cpu __percpu *cpu_slab;
-	struct lock_class_key lock_key;
 	struct slub_percpu_sheaves __percpu *cpu_sheaves;
 	/* Used for retrieving partial slabs, etc. */
 	slab_flags_t flags;
diff --git a/mm/slub.c b/mm/slub.c
index 33f218c0e8d6..8746d9d3f3a3 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3694,29 +3694,12 @@ static inline unsigned int init_tid(int cpu)
 
 static void init_kmem_cache_cpus(struct kmem_cache *s)
 {
-#ifdef CONFIG_PREEMPT_RT
-	/*
-	 * Register lockdep key for non-boot kmem caches to avoid
-	 * WARN_ON_ONCE(static_obj(key))) in lockdep_register_key()
-	 */
-	bool finegrain_lockdep = !init_section_contains(s, 1);
-#else
-	/*
-	 * Don't bother with different lockdep classes for each
-	 * kmem_cache, since we only use local_trylock_irqsave().
-	 */
-	bool finegrain_lockdep = false;
-#endif
 	int cpu;
 	struct kmem_cache_cpu *c;
 
-	if (finegrain_lockdep)
-		lockdep_register_key(&s->lock_key);
 	for_each_possible_cpu(cpu) {
 		c = per_cpu_ptr(s->cpu_slab, cpu);
 		local_trylock_init(&c->lock);
-		if (finegrain_lockdep)
-			lockdep_set_class(&c->lock, &s->lock_key);
 		c->tid = init_tid(cpu);
 	}
 }
@@ -3803,47 +3786,6 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 	}
 }
 
-/*
- * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
- * can be acquired without a deadlock before invoking the function.
- *
- * Without LOCKDEP we trust the code to be correct. kmalloc_nolock() is
- * using local_lock_is_locked() properly before calling local_lock_cpu_slab(),
- * and kmalloc() is not used in an unsupported context.
- *
- * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_lock_irqsave().
- * On !PREEMPT_RT we use trylock to avoid false positives in NMI, but
- * lockdep_assert() will catch a bug in case:
- * #1
- * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_nolock()
- * or
- * #2
- * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf -> kmalloc_nolock()
- *
- * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
- * disabled context. The lock will always be acquired and if needed it
- * block and sleep until the lock is available.
- * #1 is possible in !PREEMPT_RT only.
- * #2 is possible in both with a twist that irqsave is replaced with rt_spinlock:
- * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
- *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kmem_cache_B)
- *
- * local_lock_is_locked() prevents the case kmem_cache_A == kmem_cache_B
- */
-#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
-#define local_lock_cpu_slab(s, flags)	\
-	local_lock_irqsave(&(s)->cpu_slab->lock, flags)
-#else
-#define local_lock_cpu_slab(s, flags)					       \
-	do {								       \
-		bool __l = local_trylock_irqsave(&(s)->cpu_slab->lock, flags); \
-		lockdep_assert(__l);					       \
-	} while (0)
-#endif
-
-#define local_unlock_cpu_slab(s, flags)	\
-	local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
-
 static inline void flush_slab(struct kmem_cache *s, struct kmem_cache_cpu *c)
 {
 	unsigned long flags;
@@ -4402,20 +4344,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	return freelist;
 }
 
-/*
- * We disallow kprobes in ___slab_alloc() to prevent reentrance
- *
- * kmalloc() -> ___slab_alloc() -> local_lock_cpu_slab() protected part of
- * ___slab_alloc() manipulating c->freelist -> kprobe -> bpf ->
- * kmalloc_nolock() or kfree_nolock() -> __update_cpu_freelist_fast()
- * manipulating c->freelist without lock.
- *
- * This does not prevent kprobe in functions called from ___slab_alloc() such as
- * local_lock_irqsave() itself, and that is fine, we only need to protect the
- * c->freelist manipulation in ___slab_alloc() itself.
- */
-NOKPROBE_SYMBOL(___slab_alloc);
-
 static __always_inline void *__slab_alloc_node(struct kmem_cache *s,
 		gfp_t gfpflags, int node, unsigned long addr, size_t orig_size)
 {
@@ -5253,13 +5181,13 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
 
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
-		/*
-		 * kmalloc_nolock() in PREEMPT_RT is not supported from
-		 * non-preemptible context because local_lock becomes a
-		 * sleeping lock on RT.
-		 */
+	/*
+	 * See the comment for the same check in
+	 * alloc_frozen_pages_nolock_noprof()
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
 		return NULL;
+
 retry:
 	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
 		return NULL;
@@ -5268,10 +5196,11 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 	if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
 		/*
 		 * kmalloc_nolock() is not supported on architectures that
-		 * don't implement cmpxchg16b, but debug caches don't use
-		 * per-cpu slab and per-cpu partial slabs. They rely on
-		 * kmem_cache_node->list_lock, so kmalloc_nolock() can
-		 * attempt to allocate from debug caches by
+		 * don't implement cmpxchg16b and thus need slab_lock()
+		 * which could be preempted by a nmi.
+		 * But debug caches don't use that and only rely on
+		 * kmem_cache_node->list_lock, so kmalloc_nolock() can attempt
+		 * to allocate from debug caches by
 		 * spin_trylock_irqsave(&n->list_lock, ...)
 		 */
 		return NULL;
@@ -5280,42 +5209,31 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
 	if (ret)
 		goto success;
 
-	ret = ERR_PTR(-EBUSY);
-
 	/*
 	 * Do not call slab_alloc_node(), since trylock mode isn't
 	 * compatible with slab_pre_alloc_hook/should_failslab and
 	 * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
 	 * and slab_post_alloc_hook() directly.
-	 *
-	 * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
-	 * in irq saved region. It assumes that the same cpu will not
-	 * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
-	 * Therefore use in_nmi() to check whether particular bucket is in
-	 * irq protected section.
-	 *
-	 * If in_nmi() && local_lock_is_locked(s->cpu_slab) then it means that
-	 * this cpu was interrupted somewhere inside ___slab_alloc() after
-	 * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
-	 * In this case fast path with __update_cpu_freelist_fast() is not safe.
 	 */
-	if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
-		ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
+	ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
 
-	if (PTR_ERR(ret) == -EBUSY) {
-		if (can_retry) {
-			/* pick the next kmalloc bucket */
-			size = s->object_size + 1;
-			/*
-			 * Another alternative is to
-			 * if (memcg) alloc_gfp &= ~__GFP_ACCOUNT;
-			 * else if (!memcg) alloc_gfp |= __GFP_ACCOUNT;
-			 * to retry from bucket of the same size.
-			 */
-			can_retry = false;
-			goto retry;
-		}
-		ret = NULL;
+	/*
+	 * It's possible we failed due to trylock as we preempted someone with
+	 * the sheaves locked, and the list_lock is also held by another cpu.
+	 * But it should be rare that multiple kmalloc buckets would have
+	 * sheaves locked, so try a larger one.
+	 */
+	if (!ret && can_retry) {
+		/* pick the next kmalloc bucket */
+		size = s->object_size + 1;
+		/*
+		 * Another alternative is to
+		 * if (memcg) alloc_gfp &= ~__GFP_ACCOUNT;
+		 * else if (!memcg) alloc_gfp |= __GFP_ACCOUNT;
+		 * to retry from bucket of the same size.
+		 */
+		can_retry = false;
+		goto retry;
 	}
 
 success:
@@ -7334,10 +7252,6 @@ void __kmem_cache_release(struct kmem_cache *s)
 	cache_random_seq_destroy(s);
 	if (s->cpu_sheaves)
 		pcs_destroy(s);
-#ifdef CONFIG_PREEMPT_RT
-	if (s->cpu_slab)
-		lockdep_unregister_key(&s->lock_key);
-#endif
 	free_percpu(s->cpu_slab);
 	free_kmem_cache_nodes(s);
 }

-- 
2.52.0


