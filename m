Return-Path: <bpf+bounces-49040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE158A13555
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 09:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B8F1887F54
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 08:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA4019D8A0;
	Thu, 16 Jan 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zm+px1Dd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="44I1nZjO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dTzaCeBO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vryb11Dz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D0986323
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016282; cv=none; b=EfGDhgr7M25/5TKgEkdIO1sfZhKqf5PO47K73tbmMlRkY2L19DEUByZDpca8+1vpqY5z4tstfQ0X6nYM1VXVOkSzkX9Qodnuzn3vje0X4etyXp4dNObz/VpG5Ec9E/L19tC0XdN9Eh30f//XMLKp7UWt58sqBkZuC3BjEgV+ssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016282; c=relaxed/simple;
	bh=t+KV7vhSuulUEzV4D/QoGtsL8XX6YTAX4ZJ0xgnAFEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqMy+5Cll81E7CNhd6TISEieoqL7RJ6PV7D4nOHtjPRduPIsgW27RuXguModb/467lujKgZ2tWDyIvUOJEdvJkS4odDfG2GDO3lqWee/mAge4X06KDRiKvbINJZZwxAerD03tAWmNywh5TOtzAhPOuq1W+1FhlJAMP08E3s/2+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zm+px1Dd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=44I1nZjO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dTzaCeBO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vryb11Dz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E00EC1F796;
	Thu, 16 Jan 2025 08:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737016272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uv/0zTWpo+aZf7SARNYqQNiiSyerxmzjiEEih+ARvJw=;
	b=zm+px1DdJ/LvdxDcOJ6qqrkoP93MXifVnh9mzjLR6wwwXkrBt4zm42prup6THFMKaROrhv
	0/aacj7tHZT1kk4xiCQgz6P793FJMsfk9l+r8lJG9+72fQ58tbWyzF8/HFC835fpq2oGXw
	+1rFbShJtqbV9bClAC7zvauhyEXrNzA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737016272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uv/0zTWpo+aZf7SARNYqQNiiSyerxmzjiEEih+ARvJw=;
	b=44I1nZjOo8oqBGIFHhk0vn5DrAtNrsSxN2MxHj4rCdUjBcYpecAC6qD06m8x7WWfAZ+U2h
	aQQ8tRMTlPNfafDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dTzaCeBO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Vryb11Dz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737016271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uv/0zTWpo+aZf7SARNYqQNiiSyerxmzjiEEih+ARvJw=;
	b=dTzaCeBOHF7R3iLOEusYM0uEHG+Sh3gdhjFI9Zi4xZlX/YoSWX4FWacttm+H6syHtSY9U7
	O0vM3e1SRXKS+Yy0Lv61DnbTYEs0iO8prIG3VdB+YPszot3mAJaQN3jD8mIDkzFmSgmeGf
	ZOtVIBD08qZ0SXdgixSCg9tvC5jJNJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737016271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uv/0zTWpo+aZf7SARNYqQNiiSyerxmzjiEEih+ARvJw=;
	b=Vryb11Dzq5t/qNrKTibG30nqdUtWy3/ZEhk+9C+90gVl9mFrjEZWEX13dobx82+No38j50
	Bl3YE4Dptm4SwEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B055113A57;
	Thu, 16 Jan 2025 08:31:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XhzwKM/DiGcmHgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 16 Jan 2025 08:31:11 +0000
Message-ID: <478b027a-ef5b-4ed7-9fe3-ad2b627111ef@suse.cz>
Date: Thu, 16 Jan 2025 09:31:10 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 2/7] mm, bpf: Introduce free_pages_nolock()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Sewior <bigeasy@linutronix.de>,
 Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
 Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>,
 Kernel Team <kernel-team@fb.com>
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-3-alexei.starovoitov@gmail.com>
 <d273c11b-19c0-4d25-b449-6d84f58c5836@suse.cz>
 <CAADnVQLU5JDUq70nE4+1wGf9Uh27oPahaVXxKHPKLAm5=ptiYQ@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <CAADnVQLU5JDUq70nE4+1wGf9Uh27oPahaVXxKHPKLAm5=ptiYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E00EC1F796
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
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 1/16/25 00:15, Alexei Starovoitov wrote:
> On Wed, Jan 15, 2025 at 3:47 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 1/15/25 03:17, Alexei Starovoitov wrote:
>> > From: Alexei Starovoitov <ast@kernel.org>
>> >
>> > Introduce free_pages_nolock() that can free pages without taking locks.
>> > It relies on trylock and can be called from any context.
>> > Since spin_trylock() cannot be used in RT from hard IRQ or NMI
>> > it uses lockless link list to stash the pages which will be freed
>> > by subsequent free_pages() from good context.
>> >
>> > Do not use llist unconditionally. BPF maps continuously
>> > allocate/free, so we cannot unconditionally delay the freeing to
>> > llist. When the memory becomes free make it available to the
>> > kernel and BPF users right away if possible, and fallback to
>> > llist as the last resort.
>> >
>> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>>
>> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>>
>> With:
>>
>> > @@ -4853,6 +4905,17 @@ void __free_pages(struct page *page, unsigned int order)
>> >  }
>> >  EXPORT_SYMBOL(__free_pages);
>> >
>> > +/*
>> > + * Can be called while holding raw_spin_lock or from IRQ and NMI,
>> > + * but only for pages that came from try_alloc_pages():
>> > + * order <= 3, !folio, etc
>>
>> I think order > 3 is fine, as !pcp_allowed_order() case is handled too?
> 
> try_alloc_page() has:
>         if (!pcp_allowed_order(order))
>                 return NULL;

Ah ok I missed that the comment describes what pages try_alloc_pages()
produces, not what's accepted here.

> to make sure it tries pcp first.
> bpf has no use for order > 1. Even 3 is overkill,
> but it's kinda free to support order <= 3, so why not.
> 
>> And
>> what does "!folio" mean?
> 
> That's what we discussed last year.
> __free_pages() has all the extra stuff if (!head) and
> support for dropping ref on the middle page.
> !folio captures this more broadly.

Aha! But in that case I realize we're actually wrong. It needs to be a folio
(compound page) if it's order > 0 in order to drop that tricky
!head freeing code. It's order > 0 pages that are not compound, that are
problematic and should be eventually removed from the kernel.

The solution is to add __GFP_COMP in try_alloc_pages_noprof(). This will
have no effect on order-0 pages that BPF uses.

Instead of "!folio" the comment could then say "compound".


