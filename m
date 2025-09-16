Return-Path: <bpf+bounces-68540-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 579B2B5A04E
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 20:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECF3320923
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 18:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980822BD58A;
	Tue, 16 Sep 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NfGGKyvs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="W6PBt8Kw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FOA+ybL8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZTjyur5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FD2D2383
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 18:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046359; cv=none; b=bNiJv8k4D5Qxe/YNpkkUkzRMDgAl5XkHuosXODpDry+zgzoUPcE3LDi+JmLpVD94dkMi97Wq/xtV5UWDj/Lhdlv5wIwRi5aAzkhn5csUCJS74pCiWIDmzgSUio1CzmOqBVKpNU+Ft4/5EEWbLQZla6mUzCeGwOA1ltYyri6XSbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046359; c=relaxed/simple;
	bh=AukZFA9U35C+KhmaAhLeA78th0G1aXA8LSZiiq8PqMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cRScrmAGPqyWhYBpYoEwpju5lLuujXXcVDhkC+oa//6PZEHu4nvhd0ongI4GAPtpTX3QMVi8WcK2GMboJ8atz1kZzVTQPgeMaOANQcxoacbWx3peFl6yuc3GtQYSB07i+kx81dLEu1BY9bKzDvJ15IHZwJ8NqnqJSevSsVle62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NfGGKyvs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=W6PBt8Kw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FOA+ybL8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZTjyur5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D93DD21DF1;
	Tue, 16 Sep 2025 18:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758046355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1HlN82lSb+QuNxCfB33fFErUCYTRryWcL+zpFAMs5M=;
	b=NfGGKyvsDlFS9Xj6Q8vyILiveg5TJcSHEPT8mDsMbfjH5VlMF/6yq7BnsKKFj41kJ8Yquy
	e20jBmVtMSUIoSV6mqJ9S3m9mCQrBwdofk0eWsQDuLy0VSxsXZvLa+9vJVxb7CEp7AuuAw
	5h8e0Rgw+tNjgIw23Hki9LmfiAEfA3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758046355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1HlN82lSb+QuNxCfB33fFErUCYTRryWcL+zpFAMs5M=;
	b=W6PBt8Kwvgc4yO7aNIVjPZxaCmtEWDPcgIqAxG0NHINE5v3BzxjobiHs0sqRFXJZ+vc7nb
	ux11RagMncknySBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FOA+ybL8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sZTjyur5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758046354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1HlN82lSb+QuNxCfB33fFErUCYTRryWcL+zpFAMs5M=;
	b=FOA+ybL8BZlX2K2mo2b9BF+IQ83X9jkrpYOHZ5eBIFkJgShcuKjWnxaTjaR4fj2hnq0fWs
	kvsuB7y20lg08PRJFmCN3Gl9XAXx/hKzleJ25w8qc8oZLX5b8LNqoVYBUVZk7FEGAR5/kT
	CvhTr9pHH4XLNWLo54pOvS70M0kTCXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758046354;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1HlN82lSb+QuNxCfB33fFErUCYTRryWcL+zpFAMs5M=;
	b=sZTjyur5ov0dcmw9AbnI9w4fWOWcwdZlkFeM4LCRyoXQt0Xg5ba/YknYQrsd+fijwBYgsl
	VnmxFPvGCGmDa7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B94BA13A63;
	Tue, 16 Sep 2025 18:12:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pvdsLJKoyWhbGAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 16 Sep 2025 18:12:34 +0000
Message-ID: <0beac436-1905-4542-aebe-92074aaea54f@suse.cz>
Date: Tue, 16 Sep 2025 20:12:34 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH slab] slab: Disallow kprobes in ___slab_alloc()
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Harry Yoo <harry.yoo@oracle.com>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Sebastian Sewior <bigeasy@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Johannes Weiner <hannes@cmpxchg.org>
References: <20250916022140.60269-1-alexei.starovoitov@gmail.com>
 <47aca3ca-a65b-4c0b-aaff-3a7bb6e484fe@suse.cz> <aMlZ8Au2MBikJgta@hyeyoo>
 <e7d1c20c-7164-4319-ac7e-9df0072a12ad@suse.cz>
 <CAADnVQLNm+0ZwX2MN_JK3ookGxpOGxEdwaaroQk+rGB401E8Jg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQLNm+0ZwX2MN_JK3ookGxpOGxEdwaaroQk+rGB401E8Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: D93DD21DF1
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
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
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -3.01

On 9/16/25 18:18, Alexei Starovoitov wrote:
> On Tue, Sep 16, 2025 at 6:13 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 9/16/25 14:58, Harry Yoo wrote:
>> > On Tue, Sep 16, 2025 at 12:40:12PM +0200, Vlastimil Babka wrote:
>> >> On 9/16/25 04:21, Alexei Starovoitov wrote:
>> >> > From: Alexei Starovoitov <ast@kernel.org>
>> >> >
>> >> > Disallow kprobes in ___slab_alloc() to prevent reentrance:
>> >> > kmalloc() -> ___slab_alloc() -> local_lock_irqsave() ->
>> >> > kprobe -> bpf -> kmalloc_nolock().
>> >> >
>> >> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> >>
>> >> I wanted to fold this in "slab: Introduce kmalloc_nolock() and kfree_nolock()."
>> >> and update comments to explain the NOKPROBE_SYMBOL(___slab_alloc);
>> >>
>> >> But now I'm not sure if we still need to invent the lockdep classes for PREEMPT_RT anymore:
>> >>
>> >> > /*
>> >> >  * ___slab_alloc()'s caller is supposed to check if kmem_cache::kmem_cache_cpu::lock
>> >> >  * can be acquired without a deadlock before invoking the function.
>> >> >  *
>> >> >  * Without LOCKDEP we trust the code to be correct. kmalloc_nolock() is
>> >> >  * using local_lock_is_locked() properly before calling local_lock_cpu_slab(),
>> >> >  * and kmalloc() is not used in an unsupported context.
>> >> >  *
>> >> >  * With LOCKDEP, on PREEMPT_RT lockdep does its checking in local_lock_irqsave().
>> >> >  * On !PREEMPT_RT we use trylock to avoid false positives in NMI, but
>> >> >  * lockdep_assert() will catch a bug in case:
>> >> >  * #1
>> >> >  * kmalloc() -> ___slab_alloc() -> irqsave -> NMI -> bpf -> kmalloc_nolock()
>> >> >  * or
>> >> >  * #2
>> >> >  * kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf -> kmalloc_nolock()
>> >>
>> >> AFAICS see we now eliminated this possibility.
>> >
>> > Right.
>> >
>> >> >  * On PREEMPT_RT an invocation is not possible from IRQ-off or preempt
>> >> >  * disabled context. The lock will always be acquired and if needed it
>> >> >  * block and sleep until the lock is available.
>> >> >  * #1 is possible in !PREEMPT_RT only.
>> >>
>> >> Yes because this in kmalloc_nolock_noprof()
>> >>
>> >>         if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
>> >>                 /* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
>> >>                 return NULL;
>> >>
>> >>
>> >> >  * #2 is possible in both with a twist that irqsave is replaced with rt_spinlock:
>> >> >  * kmalloc() -> ___slab_alloc() -> rt_spin_lock(kmem_cache_A) ->
>> >> >  *    tracepoint/kprobe -> bpf -> kmalloc_nolock() -> rt_spin_lock(kmem_cache_B)
>> >> And this is no longer possible, so can we just remove these comments and drop
>> >> "slab: Make slub local_(try)lock more precise for LOCKDEP" now?
>> >
>> > Makes sense and sounds good to me.
>> >
>> > Also in the commit mesage should be adjusted too:
>> >> kmalloc_nolock() can be called from any context and can re-enter
>> >> into ___slab_alloc():
>> >>  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> NMI -> bpf ->
>> >>     kmalloc_nolock() -> ___slab_alloc(cache_B)
>> >> or
>> >>  kmalloc() -> ___slab_alloc(cache_A) -> irqsave -> tracepoint/kprobe -> bpf ->
>> >>    kmalloc_nolock() -> ___slab_alloc(cache_B)
>> >
>> > The lattter path is not possible anymore,
>> >
>> >> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when per-cpu
>> >> rt_spin_lock is locked by current _task_. In this case re-entrance into
>> >> the same kmalloc bucket is unsafe, and kmalloc_nolock() tries a different
>> >> bucket that is most likely is not locked by the current task.
>> >> Though it may be locked by a different task it's safe to rt_spin_lock() and
>> >> sleep on it.
>> >
>> > and this paragraph is no longer valid either?
>>
>> Thanks for confirming! Let's see if Alexei agrees or we both missed
>> something.
> 
> Not quite.
> This patch prevents
> kmalloc() -> ___slab_alloc() -> local_lock_irqsave() ->
>     kprobe -> bpf
> 
> to make sure kprobe cannot be inserted in the _middle_ of
> freelist operations.
> kprobe/tracepoint outside of freelist is not a concern,
> and
> malloc() -> ___slab_alloc() -> local_lock_irqsave() ->
>    tracepoint -> bpf
> 
> is still possible. Especially on RT.

Hm I see. I wrongly reasoned as if NOKPROBE_SYMBOL(___slab_alloc) covers the
whole scope of ___slab_alloc() but that's not the case. Thanks for clearin
that up.

> I thought about whether do_slab_free() should be marked as NOKPROBE,
> but that's not necessary. There is freelist manipulation
> there under local_lock_cpu_slab(), but it's RT only,
> and there is no fast path there.

There's __update_cpu_freelist_fast() called from do_slab_free() for !RT?

>>
>> >> >  * local_lock_is_locked() prevents the case kmem_cache_A == kmem_cache_B
>> >> >  */
>> >>
>> >> However, what about the freeing path?
>> >> Shouldn't we do the same with __slab_free() to prevent fast path messing up
>> >> an interrupted slow path?
>> >
>> > Hmm right, but we have:
>> >
>> > (in_nmi() || !USE_LOCKLESS_FAST_PATH()) && local_lock_is_locked()
>>
>> Yes, but like in the alloc case, this doesn't trigger in the
>> !in_nmi() && !PREEMPT_RT case, i.e. a kprobe handler on !PREEMPT_RT, right?
>>
>> But now I think I see another solution here. Since we're already under
>> "if (!allow_spin)" we could stick a very ugly goto there to skip the
>> fastpath if we don't defer_free()?
>> (apparently declaration under a goto label is a C23 extension)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 6e858a6e397c..212c0e3e5007 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -6450,6 +6450,7 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>>  {
>>         /* cnt == 0 signals that it's called from kfree_nolock() */
>>         bool allow_spin = cnt;
>> +       __maybe_unused unsigned long flags;
>>         struct kmem_cache_cpu *c;
>>         unsigned long tid;
>>         void **freelist;
>> @@ -6489,6 +6490,9 @@ static __always_inline void do_slab_free(struct kmem_cache *s,
>>                         return;
>>                 }
>>                 cnt = 1; /* restore cnt. kfree_nolock() frees one object at a time */
>> +
>> +               /* prevent a fastpath interrupting a slowpath */
>> +               goto no_lockless;
> 
> I'm missing why this is needed.
> 
> do_slab_free() does:
>                 if ((in_nmi() || !USE_LOCKLESS_FAST_PATH()) &&
>                     local_lock_is_locked(&s->cpu_slab->lock)) {
>                         defer_free(s, head); return;
> 
> It's the same check as in kmalloc_nolock() to avoid invalid:
> freelist ops -> nmi -> bpf -> __update_cpu_freelist_fast.
> 
> The big comment in kmalloc_nolock() applies here too.

But with nmi that's variant of #1 of that comment.

Like for ___slab_alloc() we need to prevent #2 with no nmi?
example on !RT:

kmalloc() -> ___slab_alloc() -> irqsave -> tracepoint/kprobe -> bpf ->
kfree_nolock() -> do_slab_free()

in_nmi() || !USE_LOCKLESS_FAST_PATH()
false || false, we proceed, no checking of local_lock_is_locked()

if (USE_LOCKLESS_FAST_PATH()) { - true (!RT)
-> __update_cpu_freelist_fast()

Am I missing something?

> I didn't copy paste it.
> Maybe worth adding a reference like:
> /* See comment in kmalloc_nolock() why fast path should be skipped
> in_nmi() && lock_is_locked() */
> 
> So this patch with NOKPROBE_SYMBOL(___slab_alloc)
> is enough, afaict.
> Maybe expand a comment with the above details while folding?


