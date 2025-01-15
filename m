Return-Path: <bpf+bounces-48931-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6982A125E8
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 15:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C373A3098
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 14:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B6E70821;
	Wed, 15 Jan 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODCJv2x4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Ohl2p5L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ODCJv2x4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4Ohl2p5L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA624A7EC
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950939; cv=none; b=YtEXzrdMeB+SzpWBsN8gmCLZSw/GmSHAUWWov4S7cc8EiGCJrP+waylGi+aPJb3g6J10Z7ARsYkcu+cnHG3kGQeXwxrkjqA1Wpj073epPeyw8RyYqZZEGF6VYtaDQV81qqrB0D2ol0v9fVef01weLLkW+c3a7JfN2H/VUrn1BxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950939; c=relaxed/simple;
	bh=SLtR3OAYpyU2/mcYBuhMSE6ROIfcRI8j4rFVg/wL4Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vFyZxHTjNMxjD104nzyUYUVi8bKD86aoik7+TSrSvY8qk397j82UMdC9QpJ63x/DHeZDz1Oq9V0oM+6filtcW0bwO55LT8bLPXUngFHpTkZc/bphCTE7V2oFhIytwG9+c9YU4mj+UpV617+5zNzmpzy6s+NRlBPoQU3vtc3fejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODCJv2x4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Ohl2p5L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ODCJv2x4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4Ohl2p5L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5D7121F37E;
	Wed, 15 Jan 2025 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736950935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NsHJOpWmvRd2t3FIwrM6x7Due5B/7oSdn3BWralR+Pc=;
	b=ODCJv2x4xaEGen/jOophwBQBmCOxN1rCiKvTaiVK0T3zKKCItbnHIsG8tfgE4fUAx3b500
	zhk249OHpcBl7EJ+9e9aHbJ3pFoCesuU4JchXi+FA8RN7WlAv1gxbtHWJVT88jTD9ARZMu
	iVRdk2tCaeBoXBmgdQOoCi8vUp0NDK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736950935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NsHJOpWmvRd2t3FIwrM6x7Due5B/7oSdn3BWralR+Pc=;
	b=4Ohl2p5LHLQZXsVgJ6AMuldW0auWQ09paFzHhNXuG7t64a6k9+IN2iheYWeF8zKCGhBUIs
	KY1MfLEsQLtdxJAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ODCJv2x4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4Ohl2p5L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736950935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NsHJOpWmvRd2t3FIwrM6x7Due5B/7oSdn3BWralR+Pc=;
	b=ODCJv2x4xaEGen/jOophwBQBmCOxN1rCiKvTaiVK0T3zKKCItbnHIsG8tfgE4fUAx3b500
	zhk249OHpcBl7EJ+9e9aHbJ3pFoCesuU4JchXi+FA8RN7WlAv1gxbtHWJVT88jTD9ARZMu
	iVRdk2tCaeBoXBmgdQOoCi8vUp0NDK4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736950935;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=NsHJOpWmvRd2t3FIwrM6x7Due5B/7oSdn3BWralR+Pc=;
	b=4Ohl2p5LHLQZXsVgJ6AMuldW0auWQ09paFzHhNXuG7t64a6k9+IN2iheYWeF8zKCGhBUIs
	KY1MfLEsQLtdxJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 330BC139CB;
	Wed, 15 Jan 2025 14:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nS/iC5fEh2dlcgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Jan 2025 14:22:15 +0000
Message-ID: <e6685465-9e72-4822-95a1-990f0893f206@suse.cz>
Date: Wed, 15 Jan 2025 15:22:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 3/7] locking/local_lock: Introduce
 local_trylock_irqsave()
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, jannh@google.com,
 tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-4-alexei.starovoitov@gmail.com>
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
In-Reply-To: <20250115021746.34691-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5D7121F37E
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 1/15/25 03:17, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Similar to local_lock_irqsave() introduce local_trylock_irqsave().
> This is inspired by 'struct local_tryirq_lock' in:
> https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-5-ddc0bdc27e05@suse.cz/

Let's see what locking maintainers say about adding the flag to every
local_lock even if it doesn't use the trylock operation.

> Use spin_trylock in PREEMPT_RT when not in hard IRQ and not in NMI
> and fail instantly otherwise, since spin_trylock is not safe from IRQ
> due to PI issues.
> 
> In !PREEMPT_RT use simple active flag to prevent IRQs or NMIs
> reentering locked region.
> 
> Note there is no need to use local_inc for active flag.
> If IRQ handler grabs the same local_lock after READ_ONCE(lock->active)

IRQ handler AFAICS can't do that since __local_trylock_irqsave() is the only
trylock operation and it still does local_irq_save(). Could you have added a
__local_trylock() operation instead? Guess not for your use case because I
see in Patch 4 you want to use the local_unlock_irqrestore() universally for
sections that are earlier locked either by local_trylock_irqsave() or
local_lock_irqsave(). But I wonder if those can be changed (will reply on
that patch).

The motivation in my case was to avoid the overhead of irqsave/restore on
!PREEMPT_RT. If there was a separate "flavor" of local_lock that would
support the trylock operation, I think it would not need the _irq and
_irqsave variants at all, and it would also avoid adding the "active" flag
on !PREEMPT_RT. Meanwhile on PREEMPT_RT, a single implementation could
likely handle both flavors with no downsides?

> already completed it has to unlock it before returning.
> Similar with NMI handler. So there is a strict nesting of scopes.
> It's a per cpu lock. Multiple cpus do not access it in parallel.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/local_lock.h          |  9 ++++
>  include/linux/local_lock_internal.h | 76 ++++++++++++++++++++++++++---
>  2 files changed, 78 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
> index 091dc0b6bdfb..84ee560c4f51 100644
> --- a/include/linux/local_lock.h
> +++ b/include/linux/local_lock.h
> @@ -30,6 +30,15 @@
>  #define local_lock_irqsave(lock, flags)				\
>  	__local_lock_irqsave(lock, flags)
>  
> +/**
> + * local_trylock_irqsave - Try to acquire a per CPU local lock, save and disable
> + *			   interrupts. Always fails in RT when in_hardirq or NMI.
> + * @lock:	The lock variable
> + * @flags:	Storage for interrupt flags
> + */
> +#define local_trylock_irqsave(lock, flags)			\
> +	__local_trylock_irqsave(lock, flags)
> +
>  /**
>   * local_unlock - Release a per CPU local lock
>   * @lock:	The lock variable
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
> index 8dd71fbbb6d2..93672127c73d 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -9,6 +9,7 @@
>  #ifndef CONFIG_PREEMPT_RT
>  
>  typedef struct {
> +	int active;
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>  	struct lockdep_map	dep_map;
>  	struct task_struct	*owner;
> @@ -22,7 +23,7 @@ typedef struct {
>  		.wait_type_inner = LD_WAIT_CONFIG,	\
>  		.lock_type = LD_LOCK_PERCPU,		\
>  	},						\
> -	.owner = NULL,
> +	.owner = NULL, .active = 0
>  
>  static inline void local_lock_acquire(local_lock_t *l)
>  {
> @@ -31,6 +32,13 @@ static inline void local_lock_acquire(local_lock_t *l)
>  	l->owner = current;
>  }
>  
> +static inline void local_trylock_acquire(local_lock_t *l)
> +{
> +	lock_map_acquire_try(&l->dep_map);
> +	DEBUG_LOCKS_WARN_ON(l->owner);
> +	l->owner = current;
> +}
> +
>  static inline void local_lock_release(local_lock_t *l)
>  {
>  	DEBUG_LOCKS_WARN_ON(l->owner != current);
> @@ -45,6 +53,7 @@ static inline void local_lock_debug_init(local_lock_t *l)
>  #else /* CONFIG_DEBUG_LOCK_ALLOC */
>  # define LOCAL_LOCK_DEBUG_INIT(lockname)
>  static inline void local_lock_acquire(local_lock_t *l) { }
> +static inline void local_trylock_acquire(local_lock_t *l) { }
>  static inline void local_lock_release(local_lock_t *l) { }
>  static inline void local_lock_debug_init(local_lock_t *l) { }
>  #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
> @@ -60,6 +69,7 @@ do {								\
>  			      0, LD_WAIT_CONFIG, LD_WAIT_INV,	\
>  			      LD_LOCK_PERCPU);			\
>  	local_lock_debug_init(lock);				\
> +	(lock)->active = 0;					\
>  } while (0)
>  
>  #define __spinlock_nested_bh_init(lock)				\
> @@ -75,37 +85,73 @@ do {								\
>  
>  #define __local_lock(lock)					\
>  	do {							\
> +		local_lock_t *l;				\
>  		preempt_disable();				\
> -		local_lock_acquire(this_cpu_ptr(lock));		\
> +		l = this_cpu_ptr(lock);				\
> +		lockdep_assert(l->active == 0);			\
> +		WRITE_ONCE(l->active, 1);			\
> +		local_lock_acquire(l);				\
>  	} while (0)
>  
>  #define __local_lock_irq(lock)					\
>  	do {							\
> +		local_lock_t *l;				\
>  		local_irq_disable();				\
> -		local_lock_acquire(this_cpu_ptr(lock));		\
> +		l = this_cpu_ptr(lock);				\
> +		lockdep_assert(l->active == 0);			\
> +		WRITE_ONCE(l->active, 1);			\
> +		local_lock_acquire(l);				\
>  	} while (0)
>  
>  #define __local_lock_irqsave(lock, flags)			\
>  	do {							\
> +		local_lock_t *l;				\
>  		local_irq_save(flags);				\
> -		local_lock_acquire(this_cpu_ptr(lock));		\
> +		l = this_cpu_ptr(lock);				\
> +		lockdep_assert(l->active == 0);			\
> +		WRITE_ONCE(l->active, 1);			\
> +		local_lock_acquire(l);				\
>  	} while (0)
>  
> +#define __local_trylock_irqsave(lock, flags)			\
> +	({							\
> +		local_lock_t *l;				\
> +		local_irq_save(flags);				\
> +		l = this_cpu_ptr(lock);				\
> +		if (READ_ONCE(l->active) == 1) {		\
> +			local_irq_restore(flags);		\
> +			l = NULL;				\
> +		} else {					\
> +			WRITE_ONCE(l->active, 1);		\
> +			local_trylock_acquire(l);		\
> +		}						\
> +		!!l;						\
> +	})
> +
>  #define __local_unlock(lock)					\
>  	do {							\
> -		local_lock_release(this_cpu_ptr(lock));		\
> +		local_lock_t *l = this_cpu_ptr(lock);		\
> +		lockdep_assert(l->active == 1);			\
> +		WRITE_ONCE(l->active, 0);			\
> +		local_lock_release(l);				\
>  		preempt_enable();				\
>  	} while (0)
>  
>  #define __local_unlock_irq(lock)				\
>  	do {							\
> -		local_lock_release(this_cpu_ptr(lock));		\
> +		local_lock_t *l = this_cpu_ptr(lock);		\
> +		lockdep_assert(l->active == 1);			\
> +		WRITE_ONCE(l->active, 0);			\
> +		local_lock_release(l);				\
>  		local_irq_enable();				\
>  	} while (0)
>  
>  #define __local_unlock_irqrestore(lock, flags)			\
>  	do {							\
> -		local_lock_release(this_cpu_ptr(lock));		\
> +		local_lock_t *l = this_cpu_ptr(lock);		\
> +		lockdep_assert(l->active == 1);			\
> +		WRITE_ONCE(l->active, 0);			\
> +		local_lock_release(l);				\
>  		local_irq_restore(flags);			\
>  	} while (0)
>  
> @@ -148,6 +194,22 @@ typedef spinlock_t local_lock_t;
>  		__local_lock(lock);				\
>  	} while (0)
>  
> +#define __local_trylock_irqsave(lock, flags)			\
> +	({							\
> +		__label__ out;					\
> +		int ret = 0;					\
> +		typecheck(unsigned long, flags);		\
> +		flags = 0;					\
> +		if (in_nmi() || in_hardirq())			\
> +			goto out;				\
> +		migrate_disable();				\
> +		ret = spin_trylock(this_cpu_ptr((lock)));	\
> +		if (!ret)					\
> +			migrate_enable();			\
> +	out:							\
> +		ret;						\
> +	})
> +
>  #define __local_unlock(__lock)					\
>  	do {							\
>  		spin_unlock(this_cpu_ptr((__lock)));		\


