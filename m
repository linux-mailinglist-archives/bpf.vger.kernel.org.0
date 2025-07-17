Return-Path: <bpf+bounces-63581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F316B0891D
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 11:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42CAB561997
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6C528851F;
	Thu, 17 Jul 2025 09:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fMxT+ZOG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NKv9CbUm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fMxT+ZOG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NKv9CbUm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505C1DDC3F
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 09:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752743938; cv=none; b=S0OhK7olaIQ/jihU0CmnUU+F10NT9O6U2UeJFx3h373kYVI4IDw1+zbf4EXrmIHTuY8t7xkyhSr/a1yjihm7W9sPZOpdK8CiiXpEH3To8WBEBlU6vCYWmUhMUuGQKQ6KreJpKEhA4TzV6nybe950nB0mK9m6cGkNHkl2/YV6daY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752743938; c=relaxed/simple;
	bh=Ye5VKCoU8YgvYr2NELQc/dDRw7SYmPi8Ph+WlTwbSpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YP60cGzrG1sT2t4UdjCLa5pf/FRLGZqBSUQZGCWSbe8ipJSXSWZE7bHCkniGIx/6ZTbLyTJXyuuyscq/EUHkXYKX9yKNQ3y8TTPw0CG46aJxFkFxmKryuAw2GyV+T1bSpWM5KhLrfBvgCmw4UYkxqPKwnCx0QzkxRDUFLMGAia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fMxT+ZOG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NKv9CbUm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fMxT+ZOG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NKv9CbUm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5087821289;
	Thu, 17 Jul 2025 09:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752743929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yrg+sZctyCtPcIJKC9tTs7f7bxFGqu2V+8NiZPle5qQ=;
	b=fMxT+ZOGw09IzYg3LkHIZfkRNFW4AWWDuey3LugC+O7dYs0qVGfYP1Q5bkhpgorvL5HaKB
	n5KDbtzr36QDMsRkcFqKaJHVdhe1/hYTOW7IVDH1J4Lagn0/54A0UA1ayI64y2Orad0bak
	fL5wLq+UjvqUiqlsfnNgAdaRQJxOCJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752743929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yrg+sZctyCtPcIJKC9tTs7f7bxFGqu2V+8NiZPle5qQ=;
	b=NKv9CbUma/Wg9TZZp7Aj0Eh+pLQfw6TvlfHHqvNaOSxgSOrhUjMB4R7TesYyzyZKp6KvF3
	U1Z/nbxj5RCVj+DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752743929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yrg+sZctyCtPcIJKC9tTs7f7bxFGqu2V+8NiZPle5qQ=;
	b=fMxT+ZOGw09IzYg3LkHIZfkRNFW4AWWDuey3LugC+O7dYs0qVGfYP1Q5bkhpgorvL5HaKB
	n5KDbtzr36QDMsRkcFqKaJHVdhe1/hYTOW7IVDH1J4Lagn0/54A0UA1ayI64y2Orad0bak
	fL5wLq+UjvqUiqlsfnNgAdaRQJxOCJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752743929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Yrg+sZctyCtPcIJKC9tTs7f7bxFGqu2V+8NiZPle5qQ=;
	b=NKv9CbUma/Wg9TZZp7Aj0Eh+pLQfw6TvlfHHqvNaOSxgSOrhUjMB4R7TesYyzyZKp6KvF3
	U1Z/nbxj5RCVj+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 342B31392A;
	Thu, 17 Jul 2025 09:18:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EEtpDPm/eGiUVAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 17 Jul 2025 09:18:49 +0000
Message-ID: <e1095887-7a20-411c-9efe-5687e6a5ef74@suse.cz>
Date: Thu, 17 Jul 2025 11:18:49 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 Harry Yoo <harry.yoo@oracle.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250716022950.69330-1-alexei.starovoitov@gmail.com>
 <20250716022950.69330-6-alexei.starovoitov@gmail.com>
 <a28390e4-23cf-4615-93e3-611b046e1973@suse.cz>
 <CAADnVQJBGWdWkGOGSMSN2quSXfaKYdnFpAqfAYYEbpJgchyNbg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQJBGWdWkGOGSMSN2quSXfaKYdnFpAqfAYYEbpJgchyNbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 7/17/25 04:50, Alexei Starovoitov wrote:
> On Wed, Jul 16, 2025 at 3:58 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>> > In that case retry the operation in a different kmalloc bucket.
>> > The second attempt will likely succeed, since this cpu locked
>> > different kmem_cache_cpu.
>> >
>> > Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
>> > per-cpu rt_spin_lock is locked by current task. In this case re-entrance
>> > into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
>> > a different bucket that is most likely is not locked by the current
>> > task. Though it may be locked by a different task it's safe to
>> > rt_spin_lock() on it.
>> >
>> > Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
>> > immediately if called from hard irq or NMI in PREEMPT_RT.
>> >
>> > kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
>> > and in_nmi() or in PREEMPT_RT.
>> >
>> > SLUB_TINY config doesn't use local_lock_is_locked() and relies on
>> > spin_trylock_irqsave(&n->list_lock) to allocate while kfree_nolock()
>> > always defers to irq_work.
>> >
>> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>
>> Haven't seen an obvious bug now but will ponder it some more. Meanwhile some
>> nits and maybe one bit more serious concern.
>>
>> > +static inline void local_lock_cpu_slab(struct kmem_cache *s, unsigned long *flags)
>> > +{
>> > +     /*
>> > +      * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
>> > +      * can be acquired without a deadlock before invoking the function.
>> > +      *
>> > +      * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
>> > +      * disabled context. The lock will always be acquired and if needed it
>> > +      * block and sleep until the lock is available.
>> > +      *
>> > +      * On !PREEMPT_RT allocations from any context but NMI are safe. The lock
>> > +      * is always acquired with disabled interrupts meaning it is always
>> > +      * possible to it.
>> > +      * In NMI context it is needed to check if the lock is acquired. If it is not,
>>
>> This also could mention the bpf instrumentation context?
> 
> Ok.
> 
>> > +      * it is safe to acquire it. The trylock semantic is used to tell lockdep
>> > +      * that we don't spin. The BUG_ON() will not trigger if it is safe to acquire
>> > +      * the lock.
>> > +      *
>> > +      */
>> > +     if (!IS_ENABLED(CONFIG_PREEMPT_RT))
>> > +             BUG_ON(!local_trylock_irqsave(&s->cpu_slab->lock, *flags));
>>
>> Linus might still spot the BUG_ON() and complain, lockdep_assert() would be
>> safer maybe :)
>> Or just use local_lock_irqsave() with !CONFIG_LOCKDEP as well.
> 
> Fair enough. Let's save one branch in the critical path.
> 
>> Nit: maybe could be a #define to avoid the unusual need for "&flags" instead
>> of "flags" when calling.
> 
> When "bool allow_spin" was there in Sebastian's version it definitely
> looked cleaner as a proper function,
> but now, if (!IS_ENABLED(CONFIG_PREEMPT_RT)) can be
> #ifdef CONFIG_PREEMPT_RT
> and the comment will look normal (without ugly backslashes)
> So yeah. I'll convert it to macro.

To clarify, the ideal I think would be e.g.

#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)

local_lock_irqsave();

#else

lockdep_assert(local_trylock_irqsave());

#endif

This should mean that without lockdep we just trust the code to be correct
(kmalloc_nolock() using local_lock_held() properly before calling here, and
kmalloc() callers not being in an unsupported context, as before this
series) with no checking on both RT and !RT.

With lockdep, on RT lockdep does its checking in local_lock_irqsave()
normally. On !RT we need to use trylock to avoid false positives in nmi, but
lockdep_assert() will catch a bug still in case of a true positive.

At least I hope I got it right...

>> > +             /* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
>> > +             return NULL;
>> > +retry:
>> > +     if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
>> > +             return NULL;
>> > +     s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
>> > +
>> > +     if (!(s->flags & __CMPXCHG_DOUBLE) && !kmem_cache_debug(s))
>> > +             /*
>> > +              * kmalloc_nolock() is not supported on architectures that
>> > +              * don't implement cmpxchg16b, but debug caches don't use
>> > +              * per-cpu slab and per-cpu partial slabs. They rely on
>> > +              * kmem_cache_node->list_lock, so kmalloc_nolock() can
>> > +              * attempt to allocate from debug caches by
>> > +              * spin_trylock_irqsave(&n->list_lock, ...)
>> > +              */
>> > +             return NULL;
>> > +
>> > +     /*
>> > +      * Do not call slab_alloc_node(), since trylock mode isn't
>> > +      * compatible with slab_pre_alloc_hook/should_failslab and
>> > +      * kfence_alloc. Hence call __slab_alloc_node() (at most twice)
>> > +      * and slab_post_alloc_hook() directly.
>> > +      *
>> > +      * In !PREEMPT_RT ___slab_alloc() manipulates (freelist,tid) pair
>> > +      * in irq saved region. It assumes that the same cpu will not
>> > +      * __update_cpu_freelist_fast() into the same (freelist,tid) pair.
>> > +      * Therefore use in_nmi() to check whether particular bucket is in
>> > +      * irq protected section.
>> > +      *
>> > +      * If in_nmi() && local_lock_is_locked(s->cpu_slab) then it means that
>> > +      * this cpu was interrupted somewhere inside ___slab_alloc() after
>> > +      * it did local_lock_irqsave(&s->cpu_slab->lock, flags).
>> > +      * In this case fast path with __update_cpu_freelist_fast() is not safe.
>> > +      */
>> > +#ifndef CONFIG_SLUB_TINY
>> > +     if (!in_nmi() || !local_lock_is_locked(&s->cpu_slab->lock))
>> > +#endif
>> > +             ret = __slab_alloc_node(s, alloc_gfp, node, _RET_IP_, size);
>>
>> Nit: use IS_DEFINED(CONFIG_SLUB_TINY) to make this look better?
> 
> ok.
> 
>> > +static void defer_deactivate_slab(struct slab *slab)
>> > +{
>>
>> Nit: for more consistency this could thake the freelist argument and assign
>> it here, and not in the caller.
> 
> ok.
> 
>> > +     struct defer_free *df = this_cpu_ptr(&defer_free_objects);
>> > +
>> > +     if (llist_add(&slab->llnode, &df->slabs))
>> > +             irq_work_queue(&df->work);
>> > +}
>> > +
>> > +void defer_free_barrier(void)
>> > +{
>> > +     int cpu;
>> > +
>> > +     for_each_possible_cpu(cpu)
>> > +             irq_work_sync(&per_cpu_ptr(&defer_free_objects, cpu)->work);
>> > +}
>> > +
>> >  #ifndef CONFIG_SLUB_TINY
>> >  /*
>> >   * Fastpath with forced inlining to produce a kfree and kmem_cache_free that
>> > @@ -4575,6 +4857,8 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>> >                               struct slab *slab, void *head, void *tail,
>> >                               int cnt, unsigned long addr)
>> >  {
>> > +     /* cnt == 0 signals that it's called from kfree_nolock() */
>> > +     bool allow_spin = cnt;
>> >       struct kmem_cache_cpu *c;
>> >       unsigned long tid;
>> >       void **freelist;
>> > @@ -4593,10 +4877,30 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>> >       barrier();
>> >
>> >       if (unlikely(slab != c->slab)) {
>> > -             __slab_free(s, slab, head, tail, cnt, addr);
>> > +             if (unlikely(!allow_spin)) {
>> > +                     /*
>> > +                      * __slab_free() can locklessly cmpxchg16 into a slab,
>> > +                      * but then it might need to take spin_lock or local_lock
>> > +                      * in put_cpu_partial() for further processing.
>> > +                      * Avoid the complexity and simply add to a deferred list.
>> > +                      */
>> > +                     defer_free(s, head);
>> > +             } else {
>> > +                     __slab_free(s, slab, head, tail, cnt, addr);
>> > +             }
>> >               return;
>> >       }
>> >
>> > +     if (unlikely(!allow_spin)) {
>> > +             if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
>>
>> Same nit about USE_LOCKLESS_FAST_PATH
> 
> Here, I have to disagree unless we fix the couple lines below as well.

Ah you're right, we can leave it.

>> So here's the bigger concern. What if someone allocates with regular
>> kmalloc() so that the debugging stuff is performed as usual, and then tries
>> to use kfree_nolock() whre we skip it? You might not be planning such usage,
>> but later someone can realize that only their freeing context is limited,
>> finds out kfree_nolock() exists and tries to use it?
>>
>> Can we document this strongly enough? Or even enforce it somehow? Or when
>> any of these kinds of debugs above are enabled, we play it safe and use
>> defer_free()?
> 
> Let's break it one by one.
> 1.
> kmemleak_free_recursive() will miss an object that was recorded
> during normal kmalloc() and that's indeed problematic.
> 
> 2.
> debug_check_no_locks_freed() and
> debug_check_no_obj_freed()
> are somewhat harmless.
> We miss checks, but it's not breaking the corresponding features.
> 
> 3.
> __kcsan_check_access() doesn't take locks, but its stack is
> so deep and looks to be recursive that I doubt it's safe from
> any context.

But it's also the case of "miss check but not break anything" right?

> 4.
> kfence_free() looks like an existing quirk.
> I'm not sure why it's there in the slab free path :)
> kfence comment says:
>  * KFENCE objects live in a separate page range and are not to be intermixed
>  * with regular heap objects (e.g. KFENCE objects must never be added to the
>  * allocator freelists). Failing to do so may and will result in heap
>  * corruptions, therefore is_kfence_address() must be used to check whether
>  * an object requires specific handling.
> 
> so it should always be a nop for slab.

Well the point of kfence is that it can inject its objects into slab
allocations (so that they are with some probability checked for buffer
overflows, UAF etc), so the slab freeing must then recognize and handle
them. It also wants to be low overhead for production use, so the freeing
isn't doing "if (is_kfence_address())" upfront but deeper.

So we could detect them and defer.

> I removed the call for peace of mind.
> 
> So imo only 1 is dodgy. We can add:
> if (!(flags & SLAB_NOLEAKTRACE) && kmemleak_free_enabled)
>   defer_free(..);
> 
> but it's ugly too.

Hm yeah looks like kmemleak isn't one of those debugging functionalities
that can be built-in but no overhead unless enabled on boot, using static keys.

> My preference is to add a comment saying that only objects
> allocated by kmalloc_nolock() should be freed by kfree_nolock().

We could go with that until someone has a case for changing this, and then
handle kmemleak and kfence with defer_free()...

