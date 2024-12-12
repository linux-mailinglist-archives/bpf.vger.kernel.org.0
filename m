Return-Path: <bpf+bounces-46691-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC059EE270
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 10:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDDD167CA9
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 09:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EF5204C36;
	Thu, 12 Dec 2024 09:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SP/h1UKN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oteZM1W7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ldSXcSXS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4rW/o5t9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C012594BA
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994937; cv=none; b=p9iU/6/r+2R5h8mxu0LRVspp+bPRbHjAnAxzH2UCGqfY9zHPd3jnEYL073ttKre0KmbB9U7Tzbr/spuMoC64RasI+ZUhjfr3yxHoXuy/8lYyLOOAOjWmENoFCMIAF/maR/daJcOdFCpLR60nV7Tinlwsp/M4hUjg2L7p4Y3prQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994937; c=relaxed/simple;
	bh=HYZFo58gZ3OM1cYEN0tfoZAufHcJEaU6XcrvLY60QCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkJT+Hz8BdzXU1qllX3JkqxYdWfzjxkUbxC+UewgeLaFk3KfAduTSN9pnZwp8j/V+dkmOWECplwy2mM0JTxTdF5YBrEs3pWLuD+vaFm+McCnBetsuisgWhxCuAfRJajYLddLRjRJ+dufhMeaie90RwEY47ixqiGEQ/WGkrvx0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SP/h1UKN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oteZM1W7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ldSXcSXS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4rW/o5t9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC7F021119;
	Thu, 12 Dec 2024 09:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733994933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R7fVrjcp/UTDDfv/utL2sG0J56iJc0yfUCHiiOAS7hk=;
	b=SP/h1UKNFO2G3e4CYg3KAYpe5TJtbOiW0vw3ugVHdCo6fYSdVTJ4jp7maHKASeR8LJ3onH
	rI6T++ih/XBiZGO+6kFnv/7qHvMD4n7DgskCBBKQP+bxpnin8XTlS38usphefLPaiB7IBm
	kigJQKVojktiWAthi6E3SDths4zqXTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733994933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R7fVrjcp/UTDDfv/utL2sG0J56iJc0yfUCHiiOAS7hk=;
	b=oteZM1W7LjoMROSvuKU6eFxZuOuKt317SaphnOOcifWXP3wJjZ40FCJUoyd/1JX+nQvZ0M
	741tXn0k+fnM7vDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ldSXcSXS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="4rW/o5t9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733994932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R7fVrjcp/UTDDfv/utL2sG0J56iJc0yfUCHiiOAS7hk=;
	b=ldSXcSXSCIA7tIh9TDFBv6CTB7UgTuIq9X1tD2XR8I/wmQTNYH40KKuEl8+yiXjxO1U56E
	lAlTMPCOqju0od3oiNUwhAgeXIPIO0dIsd4Cp1gKkDrZbBzAepC1XL/qWx5Mj9uATYFggH
	qkOUWWw0BMaZMJtwdB6NOVEfVch22tA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733994932;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=R7fVrjcp/UTDDfv/utL2sG0J56iJc0yfUCHiiOAS7hk=;
	b=4rW/o5t9tXlxIDQ7tYXA3j8TEkC7zk8hwOsaWxf1r675RmumoDhpBsuYLNPI7nUxt+rXuG
	xn47DLy4nbw/K5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86DF013508;
	Thu, 12 Dec 2024 09:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7yihILSpWmfQCwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 12 Dec 2024 09:15:32 +0000
Message-ID: <60fadf5a-4c96-43b3-8cc2-baf71eb93e3f@suse.cz>
Date: Thu, 12 Dec 2024 10:15:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/6] locking/local_lock: Introduce
 local_trylock_irqsave()
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
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>,
 Jann Horn <jannh@google.com>
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-4-alexei.starovoitov@gmail.com>
 <1c760bf1-14a4-42e4-a55b-438a29987aef@suse.cz>
 <9e5bdef1-a692-47d5-82b9-96a4f2c68463@suse.cz>
 <CAADnVQJtkb3YVM9La_Zo=t_s+DNNrrVhX1gt5KsQUPZTdw_7Eg@mail.gmail.com>
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
In-Reply-To: <CAADnVQJtkb3YVM9La_Zo=t_s+DNNrrVhX1gt5KsQUPZTdw_7Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC7F021119
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,kvack.org,fb.com,google.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 12/12/24 03:49, Alexei Starovoitov wrote:
> On Wed, Dec 11, 2024 at 3:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 12/11/24 11:53, Vlastimil Babka wrote:
>> > On 12/10/24 03:39, Alexei Starovoitov wrote:
>> >> From: Alexei Starovoitov <ast@kernel.org>
>> >>
>> >> Similar to local_lock_irqsave() introduce local_trylock_irqsave().
>> >> It uses spin_trylock in PREEMPT_RT and always succeeds when !RT.
>> >
>> > Hmm but is that correct to always succeed? If we're in an nmi, we might be
>> > preempting an existing local_(try)lock_irqsave() critical section because
>> > disabling irqs doesn't stop NMI's, right?
>>
>> So unless I'm missing something, it would need to be a new kind of local
>> lock to support this trylock operation on !RT?
> 
> Ohh. Correct. Forgot about nmi interrupting local_lock_irqsave region in !RT.
> 
>> Perhaps based on the same
>> principle of a simple active/locked flag that I tried in my sheaves RFC? [1]
>> There could be also the advantage that if all (potentially) irq contexts
>> (not just nmi) used trylock, it would be sufficient to disable preeemption
>> and not interrupts, which is cheaper.
> 
> I don't think it's the case.
> pushf was slow on old x86.
> According to https://www.agner.org/optimize/instruction_tables.pdf
> it's 3 uops on skylake.
> That could be faster than preempt_disable (incl %gs:addr)
> which is 3-4 uops assuming cache hit.

I think the costly ones are not pushf, but cli and popf. I did some
microbenchmark in the kernel (Ryzen 2700, not really latest thing but
anyway) and IIRC it was twice slower to do the irqsave/restore than preempt
only.

>> The RT variant could work as you proposed here, that was wrong in my RFC as
>> you already pointed out when we discussed v1 of this series.
>>
>> [1]
>> https://lore.kernel.org/all/20241112-slub-percpu-caches-v1-5-ddc0bdc27e05@suse.cz/
> 
> I like your
> +struct local_tryirq_lock
> approach, but let's put it in local_lock.h ?

Sure, that was a proof of concept so kept it local.

> and it probably needs local_inc_return() instead of READ/WRITE_ONCE.
> With irq and nmis it's racy.

Hm guess you are right, thanks!

> In the meantime I think I will fix below:
> 
>> >> +#define __local_trylock_irqsave(lock, flags)                        \
>> >> +    ({                                                      \
>> >> +            local_irq_save(flags);                          \
>> >> +            local_trylock_acquire(this_cpu_ptr(lock));      \
>> >> +            1;                                              \
>> >> +    })
> 
> as
> #define __local_trylock_irqsave(lock, flags)                    \
>         ({                                                      \
>                 local_irq_save(flags);                          \
>                 local_trylock_acquire(this_cpu_ptr(lock));      \
>                 !in_nmi();                                      \
>         })
> 
> I think that's good enough for memcg patch 4 and
> doesn't grow local_lock_t on !RT.

But that means you'll never succeed in nmi, doesn't that limit the bpf use case?

> We can introduce
> 
> typedef struct {
>         int count;
> #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         struct lockdep_map      dep_map;
>         struct task_struct      *owner;
> #endif
> } local_trylock_t;
> 
> and the whole set of local_trylock_lock, local_trylock_unlock,...
> But that's quite a bit of code. Feels a bit overkill for memcg patch 4.

SLUB also uses local_locks so it would be needed there later too.

> At this point it feels that adding 'int count' to existing local_lock_t
> is cleaner.

We have Peter and Thomas in Cc let's see what they think :)

