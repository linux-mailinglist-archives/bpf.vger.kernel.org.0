Return-Path: <bpf+bounces-57649-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D81AADCB5
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 12:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70C09A4066
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 10:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD26215062;
	Wed,  7 May 2025 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jriVKSFM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wD+lLREZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jriVKSFM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wD+lLREZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9892A4414
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 10:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746614642; cv=none; b=gkYhmiTxHoRb/JVksZlxXRUbAD1TyLWE6rfBHvvUYuIUNdYCVMympcJC9l+sINjD42xyk7XNaH9m7wjoNeKKJ/F9lascBwgWmbkUlZwUohise00l0fiCeqQ0JxZsnZF0nUzfVEFhMZJBieSs3VRumzCYfqDYB2HPfmc+PuQN7zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746614642; c=relaxed/simple;
	bh=n1jOv9mejaHfB3WCqSXaWjfRv6gD+H5NnnF++BTyy0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5PYB5lGq706Vf4Ha6wyMQ/q2quSCPtegxeqqpW1YIUVupTpFUqcyKtUeyHQpGi4qZKK1Bguto7pgQdfX0NC6CSMPCtJwP8fMR3LBmo4sf+U8QQx/nhYMMlDLw9M7+8+AYe0b8TL829aZmwh169++a30Z/5FH/MCTxQXFj4aSoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jriVKSFM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wD+lLREZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jriVKSFM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wD+lLREZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1491A1F394;
	Wed,  7 May 2025 10:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746614632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX1wthXScZPfty4tSrb4aP4ON71P4G5AoJJQZT5lRSk=;
	b=jriVKSFM0KRBsG9g5R0chIx6T7G4FS0XRZN994vHaSXtNFNv+HIF5B1VB2artqUFZyMyMa
	pbAsohoKtFlfx4lxuDkDQCffUe0sM2nb8tU55ww9b2tOh5naVkVcMKt0b0S6OH3PxWgMSK
	cpamfSn18/5ym1WoGQv8oeGVfYVX9KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746614632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX1wthXScZPfty4tSrb4aP4ON71P4G5AoJJQZT5lRSk=;
	b=wD+lLREZBvT+VU9GDuro74F5psFI25KYvPxTUPc0TFV5Z2D/T6oVjc6jpEUAAbM+LBRbm5
	enCO3vrvV40IKdBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jriVKSFM;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wD+lLREZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746614632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX1wthXScZPfty4tSrb4aP4ON71P4G5AoJJQZT5lRSk=;
	b=jriVKSFM0KRBsG9g5R0chIx6T7G4FS0XRZN994vHaSXtNFNv+HIF5B1VB2artqUFZyMyMa
	pbAsohoKtFlfx4lxuDkDQCffUe0sM2nb8tU55ww9b2tOh5naVkVcMKt0b0S6OH3PxWgMSK
	cpamfSn18/5ym1WoGQv8oeGVfYVX9KQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746614632;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cX1wthXScZPfty4tSrb4aP4ON71P4G5AoJJQZT5lRSk=;
	b=wD+lLREZBvT+VU9GDuro74F5psFI25KYvPxTUPc0TFV5Z2D/T6oVjc6jpEUAAbM+LBRbm5
	enCO3vrvV40IKdBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0D0A139D9;
	Wed,  7 May 2025 10:43:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /6mEOmc5G2iREgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 May 2025 10:43:51 +0000
Message-ID: <b6f69981-f851-4c6f-a19d-5f8d13994087@suse.cz>
Date: Wed, 7 May 2025 12:44:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com>
 <4d3e5d4b-502b-459b-9779-c0bf55ef2a03@suse.cz>
 <CAADnVQLO9YX2_0wEZshHbwXoJY2-wv3OgVGvN-hgf6mK0_ipxw@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <CAADnVQLO9YX2_0wEZshHbwXoJY2-wv3OgVGvN-hgf6mK0_ipxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1491A1F394
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.01

On 5/7/25 4:20 AM, Alexei Starovoitov wrote:
> On Tue, May 6, 2025 at 5:01 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 5/1/25 05:27, Alexei Starovoitov wrote:
>>> From: Alexei Starovoitov <ast@kernel.org>
>>>
>>> kmalloc_nolock() relies on ability of local_lock to detect the situation
>>> when it's locked.
>>> In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
>>> irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
>>> In that case retry the operation in a different kmalloc bucket.
>>> The second attempt will likely succeed, since this cpu locked
>>> different kmem_cache_cpu.
>>> When lock_local_is_locked() sees locked memcg_stock.stock_lock
>>> fallback to atomic operations.
>>>
>>> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
>>> per-cpu rt_spin_lock is locked by current task. In this case re-entrance
>>> into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
>>> a different bucket that is most likely is not locked by current
>>> task. Though it may be locked by a different task it's safe to
>>> rt_spin_lock() on it.
>>>
>>> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
>>> immediately if called from hard irq or NMI in PREEMPT_RT.
>>>
>>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>
>> In general I'd prefer if we could avoid local_lock_is_locked() usage outside
>> of debugging code. It just feels hacky given we have local_trylock()
>> operations. But I can see how this makes things simpler so it's probably
>> acceptable.
> 
> local_lock_is_locked() is not for debugging.
> It's gating further calls into slub internals.
> If a particular bucket is locked the logic will use a different one.
> There is no local_trylock() at all here.

It could be, but I can see how it would complicate things. Not worth it,
especially in case we manage to replace the current percpu scheme with
sheaves later.

> In that sense it's very different from alloc_pages_nolock().
> There we trylock first and if not successful go for plan B.
> For kmalloc_nolock() we first check whether local_lock_is_locked(),
> if not then proceed and do
> local_lock_irqsave_check() instead of local_lock_irqsave().
> Both are unconditional and exactly the same without
> CONFIG_DEBUG_LOCK_ALLOC.

Right.

> Extra checks are there in _check() version for debugging,
> since local_lock_is_locked() is called much earlier in the call chain
> and far from local_lock_irqsave. So not trivial to see by just
> code reading.

Right, we rely on the implication that once we find
local_lock_is_locked() is false, it cannot become suddenly locked later
even if we re-enable preemption in the meanwhile.

> If local_lock_is_locked() says that it's locked
> we go for a different bucket which is pretty much guaranteed to
> be unlocked.

OK.

>>> +             folio = (struct folio *)p;
>>> +     } else if (node == NUMA_NO_NODE)
>>>               folio = (struct folio *)alloc_frozen_pages(flags, order);
>>>       else
>>>               folio = (struct folio *)__alloc_frozen_pages(flags, order, node, NULL);
>>
>> <snip>
>>
>>> @@ -3958,8 +3989,28 @@ static void *__slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>>        */
>>>       c = slub_get_cpu_ptr(s->cpu_slab);
>>>  #endif
>>> +     if (unlikely(!gfpflags_allow_spinning(gfpflags))) {
>>> +             struct slab *slab;
>>> +
>>> +             slab = c->slab;
>>> +             if (slab && !node_match(slab, node))
>>> +                     /* In trylock mode numa node is a hint */
>>> +                     node = NUMA_NO_NODE;
>>> +
>>> +             if (!local_lock_is_locked(&s->cpu_slab->lock)) {
>>> +                     lockdep_assert_not_held(this_cpu_ptr(&s->cpu_slab->lock));
>>> +             } else {
>>> +                     /*
>>> +                      * EBUSY is an internal signal to kmalloc_nolock() to
>>> +                      * retry a different bucket. It's not propagated further.
>>> +                      */
>>> +                     p = ERR_PTR(-EBUSY);
>>> +                     goto out;
>>
>> Am I right in my reasoning as follows?
>>
>> - If we're on RT and "in_nmi() || in_hardirq()" is true then
>> kmalloc_nolock_noprof() would return NULL immediately and we never reach
>> this code
> 
> correct.
> 
>> - local_lock_is_locked() on RT tests if the current process is the lock
>> owner. This means (in absence of double locking bugs) that we locked it as
>> task (or hardirq) and now we're either in_hardirq() (doesn't change current
>> AFAIK?) preempting task, or in_nmi() preempting task or hardirq.
> 
> not quite.
> There could be re-entrance due to kprobe/fentry/tracepoint.
> Like trace_contention_begin().
> The code is still preemptable.

Hm right. Glad that I asked then and thanks for making me realize.

>> - so local_lock_is_locked() will never be true here on RT
> 
> hehe :)
> 
> To have good coverage I fuzz test this patch set with:
> 
> +extern void (*debug_callback)(void);
> +#define local_unlock_irqrestore(lock, flags) \
> + do { \
> + if (debug_callback) debug_callback(); \
> + __local_unlock_irqrestore(lock, flags); \
> + } while (0)
> 
> and randomly re-enter everywhere from debug_callback().

Oh cool :)

>>
>> <snip>
>>
>>>  /*
>>>   * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
>>>   * can perform fastpath freeing without additional function calls.
>>> @@ -4605,10 +4762,36 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>>>       barrier();
>>>
>>>       if (unlikely(slab != c->slab)) {
>>
>> Note this unlikely() is actually a lie. It's actually unlikely that the free
>> will happen on the same cpu and with the same slab still being c->slab,
>> unless it's a free following shortly a temporary object allocation.
> 
> I didn't change it, since you would have called it
> an unrelated change in the patch :)

Right I'm not suggesting to change it here and now, just that it might
be misleading in that this is a slowpath and we're fine doing expensive
things here - I'm arguing we should be careful.

> I can prepare a separate single line patch to remove unlikely() here,
> but it's a micro optimization unrelated to this set.
> 
>>> -             __slab_free(s, slab, head, tail, cnt, addr);
>>> +             /* cnt == 0 signals that it's called from kfree_nolock() */
>>> +             if (unlikely(!cnt)) {
>>> +                     /*
>>> +                      * Use llist in cache_node ?
>>> +                      * struct kmem_cache_node *n = get_node(s, slab_nid(slab));
>>> +                      */
>>> +                     /*
>>> +                      * __slab_free() can locklessly cmpxchg16 into a slab,
>>> +                      * but then it might need to take spin_lock or local_lock
>>> +                      * in put_cpu_partial() for further processing.
>>> +                      * Avoid the complexity and simply add to a deferred list.
>>> +                      */
>>> +                     llist_add(head, &s->defer_free_objects);
>>> +             } else {
>>> +                     free_deferred_objects(&s->defer_free_objects, addr);
>>
>> So I'm a bit vary that this is actually rather a fast path that might
>> contend on the defer_free_objects from all cpus.
> 
> Well, in my current stress test I could only get this list
> to contain a single digit number of objects.

My worry isn't the list would get long, but that we'd be checking it on
almost any kfree() (that's not lucky enough to be slab == c->slab) from
all cpus. And every kfree_nolock() will have to make the cache line of
s->defer_free_objects exclusive to that cpu in the llist_add(), and then
all other cpus doing kfree() will have to refetch it while making it
shared again...

>> I'm wondering if we could make the list part of kmem_cache_cpu to distribute
>> it,
> 
> doable, but kmem_cache_cpu *c = raw_cpu_ptr(s->cpu_slab);
> is preemptable, so there is a risk that
> llist_add(.. , &c->defer_free_objects);
> will be accessing per-cpu memory of another cpu.
> llist_add() will work correctly, but cache line bounce is possible.

The cache line bounce due to occasional preemption should be much more
rare than on the single s->defer_free_objects cache line as described above.

> In kmem_cache I placed defer_free_objects after cpu_partial and oo,
> so it should be cache hot.

OTOH it would make the bouncing worse?

>> and hook the flushing e.g. to places where we do deactivate_slab() which
>> should be much slower path,
> 
> I don't follow the idea.
> If we don't process kmem_cache_cpu *c right here in do_slab_free()
> this llist will get large.

I'd hope deativate_slab() should be frequent enough, it means mainly the
local cpu's slab was exhausted. If there are many frees there are
probably many allocations too.

But ok, maybe having the llist local to the cpu would be sufficient to
make it feasible to check it every kfree() cheaply enough.


