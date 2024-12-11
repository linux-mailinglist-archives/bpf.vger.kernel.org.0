Return-Path: <bpf+bounces-46601-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3B69EC7A7
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 09:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1725188875D
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A5F1E9B02;
	Wed, 11 Dec 2024 08:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uFw6dxAw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+nDOf/Yv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uFw6dxAw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+nDOf/Yv"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB76E1C68BE
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733906917; cv=none; b=ZtBv5lPQZqS0z+IPH0C7QStaeWUG7UtTi6ZSR6wryFoZIh3Lss+I/yN3T5zfKTvtU4OFJ9ykpC1drKqKaG1aD1pjyDzEE5YTekWKaR+ILyHLX3qIMgAC7Pbzwg/F+u12i/k5JhpIMDM4yzeAQvpNpc5xLp1XtWEhWtOWJfjq1tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733906917; c=relaxed/simple;
	bh=RRHTPMvY3reXTABoKKAUGFK2gyTn3CdBzjO+HZsVzwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZfVj41qC9I8VZ8IlP72jua32eTR33nrVQQN6fUybiGMUERSreuhnarD7yULspDtyV5clN7voeGKcSW2sTcXuGj7qMENEfcXEY/W7W0s3W5CkQqIWWVXv984XN+zHyeP42J4l1OwHr/PXD1sWTBvxmZ+6RaDeGqJACVxNGWD6SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uFw6dxAw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+nDOf/Yv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uFw6dxAw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+nDOf/Yv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F22B21F38F;
	Wed, 11 Dec 2024 08:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733906914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WmwO8372NEjoF9AYeZ7LQ4p5KZ1MGCXRkHdnZ590kQI=;
	b=uFw6dxAwSRLbjnrRgvwV+lv4vEc7lqDKFzOYEL7IHzTa/aVKExc21Bc2P/7GPiiF6v0kTZ
	xABZib2Y5GolAnkBcP0dI/XuJJf12azphBbeRRyvAv62J2Kgd0dY7Zi0Sgbmy01n9X0QhM
	EskvbqdGBGfBC0FH1B1xCwmgF8Oh1xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733906914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WmwO8372NEjoF9AYeZ7LQ4p5KZ1MGCXRkHdnZ590kQI=;
	b=+nDOf/Yvg6XU0SApiJPanf0sn0+RIY2KV0DZg7h3avpBUMH+qFvnggcTVxDVBfozzCMF/x
	WoCgzmSjEMGGjPCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733906914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WmwO8372NEjoF9AYeZ7LQ4p5KZ1MGCXRkHdnZ590kQI=;
	b=uFw6dxAwSRLbjnrRgvwV+lv4vEc7lqDKFzOYEL7IHzTa/aVKExc21Bc2P/7GPiiF6v0kTZ
	xABZib2Y5GolAnkBcP0dI/XuJJf12azphBbeRRyvAv62J2Kgd0dY7Zi0Sgbmy01n9X0QhM
	EskvbqdGBGfBC0FH1B1xCwmgF8Oh1xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733906914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WmwO8372NEjoF9AYeZ7LQ4p5KZ1MGCXRkHdnZ590kQI=;
	b=+nDOf/Yvg6XU0SApiJPanf0sn0+RIY2KV0DZg7h3avpBUMH+qFvnggcTVxDVBfozzCMF/x
	WoCgzmSjEMGGjPCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC8EE1344A;
	Wed, 11 Dec 2024 08:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w3FpL+FRWWdcPQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 11 Dec 2024 08:48:33 +0000
Message-ID: <7e16528b-466f-43f3-88e2-38fc3648a693@suse.cz>
Date: Wed, 11 Dec 2024 09:48:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <c5e2138c-f1a8-4091-bd60-ac7f704c6d13@suse.cz>
 <CAADnVQJ4814Bq3bZXdgqSQ9kuJ7EohxaBBdfs+YxsYUqmCQsBg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAADnVQJ4814Bq3bZXdgqSQ9kuJ7EohxaBBdfs+YxsYUqmCQsBg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,kvack.org,fb.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 12/10/24 23:42, Alexei Starovoitov wrote:
> On Tue, Dec 10, 2024 at 10:39 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 12/10/24 03:39, Alexei Starovoitov wrote:
>> > From: Alexei Starovoitov <ast@kernel.org>
>> >
>> > Tracing BPF programs execute from tracepoints and kprobes where running
>> > context is unknown, but they need to request additional memory.
>> > The prior workarounds were using pre-allocated memory and BPF specific
>> > freelists to satisfy such allocation requests. Instead, introduce
>> > __GFP_TRYLOCK flag that makes page allocator accessible from any context.
>> > It relies on percpu free list of pages that rmqueue_pcplist() should be
>> > able to pop the page from. If it fails (due to IRQ re-entrancy or list
>> > being empty) then try_alloc_pages() attempts to spin_trylock zone->lock
>> > and refill percpu freelist as normal.
>> > BPF program may execute with IRQs disabled and zone->lock is sleeping in RT,
>> > so trylock is the only option.
>> > In theory we can introduce percpu reentrance counter and increment it
>> > every time spin_lock_irqsave(&zone->lock, flags) is used,
>> > but we cannot rely on it. Even if this cpu is not in page_alloc path
>> > the spin_lock_irqsave() is not safe, since BPF prog might be called
>> > from tracepoint where preemption is disabled. So trylock only.
>> >
>> > Note, free_page and memcg are not taught about __GFP_TRYLOCK yet.
>> > The support comes in the next patches.
>> >
>> > This is a first step towards supporting BPF requirements in SLUB
>> > and getting rid of bpf_mem_alloc.
>> > That goal was discussed at LSFMM: https://lwn.net/Articles/974138/
>> >
>> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>
>> I think there might be more non-try spin_locks reachable from page allocations:
>>
>> - in reserve_highatomic_pageblock() which I think is reachable unless this
>> is limited to order-0
> 
> Good point. I missed this bit:
>    if (order > 0)
>      alloc_flags |= ALLOC_HIGHATOMIC;
> 
> In bpf use case it will be called with order == 0 only,
> but it's better to fool proof it.
> I will switch to:
> __GFP_NOMEMALLOC | __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO | __GFP_ACCOUNT

Should work, yeah.

>> - try_to_accept_memory_one()
> 
> when I studied the code it looked to me that there should be no
> unaccepted_pages.
> I think you're saying that there could be unaccepted memory
> from the previous allocation and trylock attempt just got unlucky
> to reach that path?

The unaccepted memory can exist after boot in confidential computing guests
to speed up their boot, and then is accepted (encrypted for the guest) on
demand.

> What do you think of the following:
> -               cond_accept_memory(zone, order);
> +               cond_accept_memory(zone, order, alloc_flags);
> 
>                 /*
>                  * Detect whether the number of free pages is below high
> @@ -7024,7 +7024,8 @@ static inline bool has_unaccepted_memory(void)
>         return static_branch_unlikely(&zones_with_unaccepted_pages);
>  }
> 
> -static bool cond_accept_memory(struct zone *zone, unsigned int order)
> +static bool cond_accept_memory(struct zone *zone, unsigned int order,
> +                              unsigned int alloc_flags)
>  {
>         long to_accept;
>         bool ret = false;
> @@ -7032,6 +7033,9 @@ static bool cond_accept_memory(struct zone
> *zone, unsigned int order)
>         if (!has_unaccepted_memory())
>                 return false;
> 
> +       if (unlikely(alloc_flags & ALLOC_TRYLOCK))
> +               return false;
> +

Yeah that should be the straightforward fix.

>>
>> hope I didn't miss anything else especially in those other debugging hooks
>> (KASAN etc)
> 
> I looked through them and could be missing something, of course.
> kasan usage in alloc_page path seems fine.
> But for slab I found kasan_quarantine logic which needs a special treatment.
> Other slab debugging bits pose issues too.
> The rough idea is to do kmalloc_nolock() / kfree_nolock() that
> don't call into any pre/post hooks (including slab_free_hook,
> slab_pre_alloc_hook).
> kmalloc_nolock() will pretty much call __slab_alloc_node() directly
> and do basic kasan poison stuff that needs no locks.

You'll probably want the memcg handling though? Alloc tagging would be good
too. Both IIRC propagate the gfp flags when trying to allocate their
metadata and can deal with failure so maybe it will work in a straightfoward
way. Slab debugging will have to likely be limited, but it's also not
handled in the pre/post hooks but deeper.

> I will be going over all the paths again, of course.
> 
> Thanks for the reviews so far!


