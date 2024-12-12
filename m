Return-Path: <bpf+bounces-46690-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95799EE1FB
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 09:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57C8284037
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC00820E02C;
	Thu, 12 Dec 2024 08:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aE9JzDgn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="efzOIyRj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JOrYy3C5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AbPyUWxb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6E20E011
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993665; cv=none; b=eGzL31XlnUfxp46KbxBJeqKRSmIffRH/PBPwNuY6Se4KLfhOPq84dDaAKGjr33R7HC00Vo7qfrTtoFeH5bSsvt9fLwiFTprdqw9Ijv5vU+1nxgmlKWnhbTcrU2AYLpDxOjMmjgM6yKgLJE/3H9eJknIE/FoFKGu/O5pnl7mVYc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993665; c=relaxed/simple;
	bh=Nf03Jv4xS67KCTEg30kM0eX00zD0pCKuYYKu755NEXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K5qW3RqCwx1cEHjjlEbmee8aS6H2qfUFdrYsUVfJhn+QvFXcPFKunb7b01Den3ZH0hlz3w8ugr/BRkHLjxLG1CeI+XTrR44vbgLiN7GfmvTOlos3qIwL71pZ0mpY/7UBMCstzU3TWOga+1KQjszHlvx+LtDuhWfNh//Yx6nJw68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aE9JzDgn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=efzOIyRj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JOrYy3C5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AbPyUWxb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 347242115A;
	Thu, 12 Dec 2024 08:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733993661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gjPNJSRzK/Ratzm0ZHNDEIOEws4z2LJnQIizC2zS7Y4=;
	b=aE9JzDgnNgf4j9J9ad8Va7nEduNDzHOg6ouCzeZPc6/Qv6BxSNvNbdfmzaFafm3e+FRpaS
	SnflCDnOOnVMR90qPOzSzDmyVeSO07HhANxjnh59rn2p7wE2pJdQMx4qBwwG40I7yRbfVt
	tDJe/Dy9pTttK5nL5C+10f0o0+xZBTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733993661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gjPNJSRzK/Ratzm0ZHNDEIOEws4z2LJnQIizC2zS7Y4=;
	b=efzOIyRji+r/INgyzxdBfbsVTNTrWcOUav8HeHIsWYdab+7h2rlALJFPoididfpUioyzqY
	6cs9+IpOIZd1laCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JOrYy3C5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AbPyUWxb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733993660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gjPNJSRzK/Ratzm0ZHNDEIOEws4z2LJnQIizC2zS7Y4=;
	b=JOrYy3C5tZDFGuftTbvKZci0+rDeU7RmNChKgVg1S/mdnX52UmgjJqH2toTc3qJXaGOR1O
	+Ra+h7T/UH0zugKhH29gHl2sRyZlcPNTajeuInyMrYUPSmgjvbgfyHu47E7jfmFpmBaCRa
	s4tYkrT4LGfal3r2GIr7/27Rz49uWxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733993660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gjPNJSRzK/Ratzm0ZHNDEIOEws4z2LJnQIizC2zS7Y4=;
	b=AbPyUWxb15yCzQKEoSzKAR+u8LDhXJBKvGlx2OAVDhppPgl6XfmiMRMVWf6yIaTFOWQe4o
	vP0htlbNhHMsmdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10E7A13508;
	Thu, 12 Dec 2024 08:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x4TPA7ykWmcKBAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 12 Dec 2024 08:54:20 +0000
Message-ID: <95dab49e-52fa-4aa7-a668-5fb95c69d0a1@suse.cz>
Date: Thu, 12 Dec 2024 09:54:19 +0100
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
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 shakeel.butt@linux.dev, Michal Hocko <mhocko@suse.com>,
 Matthew Wilcox <willy@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Kernel Team <kernel-team@fb.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com>
 <20241210090136.DGfYLmeo@linutronix.de>
 <CAADnVQK_oFD9+HbcEgqy0+JMygje8fB9qdhkJ5uoofQntZoywg@mail.gmail.com>
 <a06c6e51-d242-477b-9f77-d7bad24c299b@suse.cz>
 <CAADnVQKUJcv-YKBnwa_bW-GxoBWGZaZVVy5m1mVHehWN83E6kA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAADnVQKUJcv-YKBnwa_bW-GxoBWGZaZVVy5m1mVHehWN83E6kA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 347242115A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,vger.kernel.org,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 12/12/24 03:14, Alexei Starovoitov wrote:
> On Wed, Dec 11, 2024 at 12:39 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 12/10/24 22:53, Alexei Starovoitov wrote:
>> > On Tue, Dec 10, 2024 at 1:01 AM Sebastian Andrzej Siewior
>> > <bigeasy@linutronix.de> wrote:
>> >>
>> >> On 2024-12-09 18:39:31 [-0800], Alexei Starovoitov wrote:
>> >> > From: Alexei Starovoitov <ast@kernel.org>
>> >> >
>> >> > Tracing BPF programs execute from tracepoints and kprobes where running
>> >> > context is unknown, but they need to request additional memory.
>> >> > The prior workarounds were using pre-allocated memory and BPF specific
>> >> > freelists to satisfy such allocation requests. Instead, introduce
>> >> > __GFP_TRYLOCK flag that makes page allocator accessible from any context.
>> >> > It relies on percpu free list of pages that rmqueue_pcplist() should be
>> >> > able to pop the page from. If it fails (due to IRQ re-entrancy or list
>> >> > being empty) then try_alloc_pages() attempts to spin_trylock zone->lock
>> >> > and refill percpu freelist as normal.
>> >> > BPF program may execute with IRQs disabled and zone->lock is sleeping in RT,
>> >> > so trylock is the only option.
>> >>
>> >> The __GFP_TRYLOCK flag looks reasonable given the challenges for BPF
>> >> where it is not known how much memory will be needed and what the
>> >> calling context is.
>> >
>> > Exactly.
>> >
>> >> I hope it does not spread across the kernel where
>> >> people do ATOMIC in preempt/ IRQ-off on PREEMPT_RT and then once they
>> >> learn that this does not work, add this flag to the mix to make it work
>> >> without spending some time on reworking it.
>> >
>> > We can call it __GFP_BPF to discourage any other usage,
>> > but that seems like an odd "solution" to code review problem.
>>
>> Could we perhaps not expose the flag to public headers at all, and keep it
>> only as an internal detail of try_alloc_pages_noprof()?
> 
> public headers?

I mean it could be (with some work) defined only in e.g. mm/internal.h,
which the flag printing code would then need to include.

> To pass additional bit via gfp flags into alloc_pages
> gfp_types.h has to be touched.

Ah right, try_alloc_pages_noprof() would need to move to page_alloc.c
instead of being static inline in the header.

> If you mean moving try_alloc_pages() into mm/page_alloc.c and
> adding another argument to __alloc_pages_noprof then it's not pretty.
> It has 'gfp_t gfp' argument. It should to be used to pass the intent.

__GFP_TRYLOCK could be visible in page_alloc.c to do this, but not ouside mm
code.

> We don't have to add GFP_TRYLOCK at all if we go with
> memalloc_nolock_save() approach.

I have doubts about that idea. We recently rejected PF_MEMALLOC_NORECLAIM
because it could lead to allocations nested in that scope failing and they
might not expect it. Scoped trylock would have even higher chance of failing.

I think here we need to pass the flag as part of gfp flags only within
nested allocations (for metadata or debugging) within the slab/page
allocator itself, which we already mostly do. The harder problem is not
missing any place where it should affect taking a lock, and a PF_ flag won't
help with that (as we can't want all locking functions to look at it).
Maybe it could help with lockdep helping us find locks that we missed, but
I'm sure lockdep could be made to track the trylock scope even without a PF
flag?

> So I started looking at it,
> but immediately hit trouble with bits.
> There are 5 bits left in PF_ and 3 already used for mm needs.
> That doesn't look sustainable long term.
> How about we alias nolock concept with PF_MEMALLOC_PIN ?
> 
> As far as I could trace PF_MEMALLOC_PIN clears GFP_MOVABLE and nothing else.
> 
> The same bit plus lack of __GFP_KSWAPD_RECLAIM in gfp flags
> would mean nolock mode in alloc_pages,
> while PF_MEMALLOC_PIN alone would mean nolock in free_pages
> and deeper inside memcg paths and such.
> 
> thoughts? too hacky?


