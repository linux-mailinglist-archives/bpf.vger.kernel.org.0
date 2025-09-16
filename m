Return-Path: <bpf+bounces-68487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D60B592C6
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 11:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 120427B0E78
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 09:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D582BDC25;
	Tue, 16 Sep 2025 09:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1XFXVOIL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nIP6wj4Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YaW+78fD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/Z/C1UNi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB829B229
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016530; cv=none; b=kgDK3UrxeGWc4+ULKjhuUvUaEpUMOqovw2Ta520UUNSncox838LOGb0ciLYmmKkxeZFY8jNi+P7T96FFqKWLkfd9zgKAQXTLs94CvJqG+Lk3+Tw0D0gwLFyk5GJ4ATwS2ItuvFKSLfDP2a4NHCeMytDre0joFbvWdej/ifx71KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016530; c=relaxed/simple;
	bh=vTvTUgfLDe7PNYKaVkZCCozwqDYc2tuSqmm8Rw+xm9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YptUFHKr7gdacI4oE3rwRw3QQIXE2cijNgVU6SHzfUUK2mOy9FGx9mpbFqkunwhbmf9l8w1tf3ojVXWV0QIVPurXAMerixVGZYf39z5MNXRKrfpX6x8QDD7BjnnDCfmIVCErkGrQf9ONNUiWdCSfrQ2GvWB4nY8MtqOdf/5FdGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1XFXVOIL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nIP6wj4Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YaW+78fD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/Z/C1UNi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D0BE41F8A6;
	Tue, 16 Sep 2025 09:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758016525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aEBJvYw8cZ03rwlviK+kd9RPYiv0iQqHcg/5M1QVNls=;
	b=1XFXVOIL12H3Jbz7H5wiPXW4j9FiML8NwFo42F/3pzmHYMCOSsqg4pVOlE5v/BWE4aCPcf
	KXRgTI8yxN6ApQg+FMNagp2iwwzPIr0ar/Uh9KCNljbccqYR/y10fksCMTqC0H+SyXUnVu
	AylCHyAA82B3t9/Ni4ft1ACZONZbtcY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758016525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aEBJvYw8cZ03rwlviK+kd9RPYiv0iQqHcg/5M1QVNls=;
	b=nIP6wj4ZcdfuQsjG9Rsmq6/mhtu4LWRvSVzXsAZ1zDiHoMKLePKzwDumCbdL5Qy350TASd
	fOEnMRQHSdxPvGDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758016524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aEBJvYw8cZ03rwlviK+kd9RPYiv0iQqHcg/5M1QVNls=;
	b=YaW+78fDUn64M24Ax6E2NtCLHY01mgdtVZdPMRX4Qq+LH0MrwVryRuy4z7PUrhfNKoB9fr
	NjkcupTmmqGZXv0NhdtcYhTICKKsI7lzbi8TcqbzTrhhz55m6AT1jLGrvEKAhqzldLePOu
	cVNDmhKUzlC56F7Ih/dfNlVKTT2s1YM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758016524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aEBJvYw8cZ03rwlviK+kd9RPYiv0iQqHcg/5M1QVNls=;
	b=/Z/C1UNik5uDDJcInYTlBjlggPl++kwqwhM4X4aTDWPJ8rMr5AFF8m1CGn7iOxHJWamAUt
	TrEcgyjtqCCnc/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6A7113A63;
	Tue, 16 Sep 2025 09:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nBNKLAw0yWiXQgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 16 Sep 2025 09:55:24 +0000
Message-ID: <fbadc3e8-7086-4423-9e45-07a46d6510b8@suse.cz>
Date: Tue, 16 Sep 2025 11:55:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab v5 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250909010007.1660-1-alexei.starovoitov@gmail.com>
 <20250909010007.1660-7-alexei.starovoitov@gmail.com>
 <aMgMIQVYnAq2weuE@hyeyoo> <451c6823-40fa-4ef1-91d7-effb1ca43c90@suse.cz>
 <CAADnVQKC=BA73ifNnyiE2c8ExtzS4LjR00--m5Xe8pqPLSGJfA@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQKC=BA73ifNnyiE2c8ExtzS4LjR00--m5Xe8pqPLSGJfA@mail.gmail.com>
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
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,kvack.org,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 9/16/25 02:56, Alexei Starovoitov wrote:
> On Mon, Sep 15, 2025 at 7:39 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 9/15/25 14:52, Harry Yoo wrote:
>> > On Mon, Sep 08, 2025 at 06:00:07PM -0700, Alexei Starovoitov wrote:
>> >> From: Alexei Starovoitov <ast@kernel.org>
>> >>
>> >> kmalloc_nolock() relies on ability of local_trylock_t to detect
>> >> the situation when per-cpu kmem_cache is locked.
>> >>
>> >> In !PREEMPT_RT local_(try)lock_irqsave(&s->cpu_slab->lock, flags)
>> >> disables IRQs and marks s->cpu_slab->lock as acquired.
>> >> local_lock_is_locked(&s->cpu_slab->lock) returns true when
>> >> slab is in the middle of manipulating per-cpu cache
>> >> of that specific kmem_cache.
>> >>
>> >> kmalloc_nolock() can be called from any context and can re-enter
>> >> into ___slab_alloc():
>> >>   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
>> >>     kmalloc_nolock() -> ___slab_alloc(cache_B)
>> >> or
>> >>   kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -> bpf ->
>> >>     kmalloc_nolock() -> ___slab_alloc(cache_B)
>> >>
>> >> Hence the caller of ___slab_alloc() checks if &s->cpu_slab->lock
>> >> can be acquired without a deadlock before invoking the function.
>> >> If that specific per-cpu kmem_cache is busy the kmalloc_nolock()
>> >> retries in a different kmalloc bucket. The second attempt will
>> >> likely succeed, since this cpu locked different kmem_cache.
>> >>
>> >> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
>> >> per-cpu rt_spin_lock is locked by current _task_. In this case
>> >> re-entrance into the same kmalloc bucket is unsafe, and
>> >> kmalloc_nolock() tries a different bucket that is most likely is
>> >> not locked by the current task. Though it may be locked by a
>> >> different task it's safe to rt_spin_lock() and sleep on it.
>> >>
>> >> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
>> >> immediately if called from hard irq or NMI in PREEMPT_RT.
>> >>
>> >> kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
>> >> and (in_nmi() or in PREEMPT_RT).
>> >>
>> >> SLUB_TINY config doesn't use local_lock_is_locked() and relies on
>> >> spin_trylock_irqsave(&n->list_lock) to allocate,
>> >> while kfree_nolock() always defers to irq_work.
>> >>
>> >> Note, kfree_nolock() must be called _only_ for objects allocated
>> >> with kmalloc_nolock(). Debug checks (like kmemleak and kfence)
>> >> were skipped on allocation, hence obj = kmalloc(); kfree_nolock(obj);
>> >> will miss kmemleak/kfence book keeping and will cause false positives.
>> >> large_kmalloc is not supported by either kmalloc_nolock()
>> >> or kfree_nolock().
>> >>
>> >> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> >> ---
>> >>  include/linux/kasan.h      |  13 +-
>> >>  include/linux/memcontrol.h |   2 +
>> >>  include/linux/slab.h       |   4 +
>> >>  mm/Kconfig                 |   1 +
>> >>  mm/kasan/common.c          |   5 +-
>> >>  mm/slab.h                  |   6 +
>> >>  mm/slab_common.c           |   3 +
>> >>  mm/slub.c                  | 473 +++++++++++++++++++++++++++++++++----
>> >>  8 files changed, 453 insertions(+), 54 deletions(-)
>> >> @@ -3704,6 +3746,44 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
>> >>      }
>> >>  }
>> >>
>> >> +/*
>> >> + * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
>> >> + * can be acquired without a deadlock before invoking the function.
>> >> + *
>> >> + * Without LOCKDEP we trust the code to be correct. kmalloc_nolock() is
>> >> + * using local_lock_is_locked() properly before calling local_lock_cpu_slab(),
>> >> + * and kmalloc() is not used in an unsupported context.
>> >> + *
>> >> + * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_lock_irqsave().
>> >> + * On !PREEMPT_RT we use trylock to avoid false positives in NMI, but
>> >> + * lockdep_assert() will catch a bug in case:
>> >> + * #1
>> >> + * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_nolock()
>> >> + * or
>> >> + * #2
>> >> + * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf -> kmalloc_nolock()
>> >> + *
>> >> + * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
>> >> + * disabled context. The lock will always be acquired and if needed it
>> >> + * block and sleep until the lock is available.
>> >> + * #1 is possible in !PREEMPT_RT only.
>> >> + * #2 is possible in both with a twist that irqsave is replaced with rt_spinlock:
>> >> + * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
>> >> + *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kmem_cache_B)
>> >> + *
>> >> + * local_lock_is_locked() prevents the case kmem_cache_A == kmem_cache_B
>> >> + */
>> >> +#if defined(CONFIG_PREEMPT_RT) || !defined(CONFIG_LOCKDEP)
>> >> +#define local_lock_cpu_slab(s, flags)       \
>> >> +    local_lock_irqsave(&(s)->cpu_slab->lock, flags)
>> >> +#else
>> >> +#define local_lock_cpu_slab(s, flags)       \
>> >> +    lockdep_assert(local_trylock_irqsave(&(s)->cpu_slab->lock, flags))
>> >> +#endif
>> >> +
>> >> +#define local_unlock_cpu_slab(s, flags)     \
>> >> +    local_unlock_irqrestore(&(s)->cpu_slab->lock, flags)
>> >
>> > nit: Do we still need this trick with patch "slab: Make slub local_(try)lock
>> > more precise for LOCKDEP"?
>>
>> I think we only make it more precise on PREEMPT_RT because on !PREEMPT_RT we
>> can avoid it using this trick. It's probably better for lockdep's overhead
>> to avoid the class-per-cache when we can.
> 
> yes.
> 
>> Perhaps we can even improve by having a special class only for kmalloc
>> caches? With kmalloc_nolock we shouldn't ever recurse from one non-kmalloc
>> cache to another non-kmalloc cache?
> 
> Probably correct.
> The current algorithm of kmalloc_nolock() (pick a different bucket)
> works only for kmalloc caches, so other caches won't see _nolock()
> version any time soon...
> but caches are mergeable, so other kmem_cache_create()-d cache
> might get merged with kmalloc ? Still shouldn't be an issue.

I think we mostly don't merge them, maybe in some configs it's still
possible. We should probably just do it unconditionally as they are special
enough. But it still shouldn't be an issue for this case, as we wouldn't
ever merge such caches that would need a different lockdep class, AFAICS.

> I guess we can fine tune "bool finegrain_lockdep" in that patch
> to make it false for non-kmalloc caches, but I don't know how to do it.
> Some flag struct kmem_cache ? I can do a follow up.

Yeah there's now SLAB_KMALLOC and is_kmalloc_cache(). We can do followup, it
shouldn't be urgent.

>>
>> Hmm... seems a good point, unless I'm missing something.
> 
> Good point indeed.
> tracepoints are not an issue, since there are no tracepoints
> in the middle of freelist operations,
> but kprobe in the middle of ___slab_alloc() is indeed problematic.
> 
>>
>> > Maybe check if interrupts are disabled instead of in_nmi()?
> 
> but calling if (irqs_disabled()) isn't fast (list time I benchmarked it)
> and unnecessarily restrictive.
> 
> I think it's better to add 'notrace' to ___slab_alloc
> or I can denylist that function on bpf side to disallow attaching.
> 
>>
>> Why not just check for local_lock_is_locked(&s->cpu_slab->lock) then and
>> just remove the "!in_nmi() ||" part? There shouldn't be false positives?
> 
> That wouldn't be correct. Remember you asked why
> access &s->cpu_slab->lock is stable? in_nmi() guarantees that
> the task won't migrate.

Ah right.

> Adding slub_put_cpu_ptr() wrap around local_lock_is_locked() _and_
> subsequent call to __slab_alloc_node() will fix it,
> but it's ugly.
> Potentially can do
> if (!allow_sping && local_lock_is_locked())
> right before calling __update_cpu_freelist_fast()
> but it's even uglier, since it will affect the fast path for everyone.

Agreed.

> So I prefer to leave this bit as-is.
> I'll add filtering of ___slab_alloc() on bpf side.
> We already have a precedent: btf_id_deny set.
> That would be one line patch that I can do in bpf tree.
> Good to disallow poking into ___slab_alloc() anyway.

Yeah it sounds like the easiest fix and won't limit anything.

