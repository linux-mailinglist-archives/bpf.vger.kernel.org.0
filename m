Return-Path: <bpf+bounces-63051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C89B02057
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 17:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28811885C98
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA0F82D46C2;
	Fri, 11 Jul 2025 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="umuWXaK/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gilzgUNE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="umuWXaK/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gilzgUNE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8305C1552E0
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752247436; cv=none; b=SOw9TtRzWzNDb/QFm+wbTIXvI8Gt6XxHFuVVfS1l3cZ9MfLj6kyYLZebm+q5sBRAzRgiujlgejFzWp6Ob/I8Soj0msYA35ChEJmX/eej9RBMIGrkJbBqwimjqUbxUecDBRfQdqWVu8/D8HWZH+Fmgnftm0uSzNE2w8d4qb701O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752247436; c=relaxed/simple;
	bh=qsZisP7lCGtB1PMJo4cFw90vsSPdSyI2wddzFKxsCZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f/7ghPw/r8OfO3ETiv4GRdIv3nbufC7VLKdGbgaq22iVhr4o+aigGoos8X6ak8IfU7vypfS4P80Jy8XaXy8RVdGExxdYlTUpf6Qn+Rij+eGdHCg2acV3TnPDLq5kWFBqFHdsBISE4F9+ytboinyO/SPK0AYK/2KWdLy0YlsTF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=umuWXaK/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gilzgUNE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=umuWXaK/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gilzgUNE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 40F62211E3;
	Fri, 11 Jul 2025 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752247432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aL+7ZHIh65z7hr+E+sA+rYJjzi0QwKUmZV3M1YEco5E=;
	b=umuWXaK/3MhisdBRyGEXN3/1nhhZT1mQsgH/MOjMTGG00AITA4zrTSp/2qhkueOlRGjWRu
	gsUtp/C/GE18U/S3D3XqkFRGLVEtkNhvyEhIACC5p52mHhFLNT1j6oaSpL1BNf8qlbKFqX
	uCLX5ifMq0nCFEaJUwZ4cDyzLRqVvac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752247432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aL+7ZHIh65z7hr+E+sA+rYJjzi0QwKUmZV3M1YEco5E=;
	b=gilzgUNEpihw+Hu7F1kCqx/yZPjkqbTCYMpeF4VB+M+lXszXJkI3AQmjnSY0pzHvfMNcPx
	0D0o83IbwHAawYBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="umuWXaK/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gilzgUNE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752247432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aL+7ZHIh65z7hr+E+sA+rYJjzi0QwKUmZV3M1YEco5E=;
	b=umuWXaK/3MhisdBRyGEXN3/1nhhZT1mQsgH/MOjMTGG00AITA4zrTSp/2qhkueOlRGjWRu
	gsUtp/C/GE18U/S3D3XqkFRGLVEtkNhvyEhIACC5p52mHhFLNT1j6oaSpL1BNf8qlbKFqX
	uCLX5ifMq0nCFEaJUwZ4cDyzLRqVvac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752247432;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aL+7ZHIh65z7hr+E+sA+rYJjzi0QwKUmZV3M1YEco5E=;
	b=gilzgUNEpihw+Hu7F1kCqx/yZPjkqbTCYMpeF4VB+M+lXszXJkI3AQmjnSY0pzHvfMNcPx
	0D0o83IbwHAawYBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 257EC138A5;
	Fri, 11 Jul 2025 15:23:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9ueLCIgscWjUZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 11 Jul 2025 15:23:52 +0000
Message-ID: <c31bee2f-dee5-4dd5-8cf4-edc90d3c595b@suse.cz>
Date: Fri, 11 Jul 2025 17:23:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] locking/local_lock: Introduce
 local_lock_lockdep_start/end()
Content-Language: en-US
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org, harry.yoo@oracle.com, shakeel.butt@linux.dev,
 mhocko@suse.com, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-4-alexei.starovoitov@gmail.com>
 <20250711075001.fnlMZfk6@linutronix.de>
 <1adbee35-6131-49de-835b-2c93aacfdd1e@suse.cz>
 <20250711151730.rz_TY1Qq@linutronix.de>
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
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJnyBr8BQka0IFQAAoJECJPp+fMgqZkqmMQ
 AIbGN95ptUMUvo6aAdhxaOCHXp1DfIBuIOK/zpx8ylY4pOwu3GRe4dQ8u4XS9gaZ96Gj4bC+
 jwWcSmn+TjtKW3rH1dRKopvC07tSJIGGVyw7ieV/5cbFffA8NL0ILowzVg8w1ipnz1VTkWDr
 2zcfslxJsJ6vhXw5/npcY0ldeC1E8f6UUoa4eyoskd70vO0wOAoGd02ZkJoox3F5ODM0kjHu
 Y97VLOa3GG66lh+ZEelVZEujHfKceCw9G3PMvEzyLFbXvSOigZQMdKzQ8D/OChwqig8wFBmV
 QCPS4yDdmZP3oeDHRjJ9jvMUKoYODiNKsl2F+xXwyRM2qoKRqFlhCn4usVd1+wmv9iLV8nPs
 2Db1ZIa49fJet3Sk3PN4bV1rAPuWvtbuTBN39Q/6MgkLTYHb84HyFKw14Rqe5YorrBLbF3rl
 M51Dpf6Egu1yTJDHCTEwePWug4XI11FT8lK0LNnHNpbhTCYRjX73iWOnFraJNcURld1jL1nV
 r/LRD+/e2gNtSTPK0Qkon6HcOBZnxRoqtazTU6YQRmGlT0v+rukj/cn5sToYibWLn+RoV1CE
 Qj6tApOiHBkpEsCzHGu+iDQ1WT0Idtdynst738f/uCeCMkdRu4WMZjteQaqvARFwCy3P/jpK
 uvzMtves5HvZw33ZwOtMCgbpce00DaET4y/UzsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZ8gcVAUJFhTonwAKCRAiT6fnzIKmZLY8D/9uo3Ut9yi2YCuASWxr7QQZ
 lJCViArjymbxYB5NdOeC50/0gnhK4pgdHlE2MdwF6o34x7TPFGpjNFvycZqccSQPJ/gibwNA
 zx3q9vJT4Vw+YbiyS53iSBLXMweeVV1Jd9IjAoL+EqB0cbxoFXvnjkvP1foiiF5r73jCd4PR
 rD+GoX5BZ7AZmFYmuJYBm28STM2NA6LhT0X+2su16f/HtummENKcMwom0hNu3MBNPUOrujtW
 khQrWcJNAAsy4yMoJ2Lw51T/5X5Hc7jQ9da9fyqu+phqlVtn70qpPvgWy4HRhr25fCAEXZDp
 xG4RNmTm+pqorHOqhBkI7wA7P/nyPo7ZEc3L+ZkQ37u0nlOyrjbNUniPGxPxv1imVq8IyycG
 AN5FaFxtiELK22gvudghLJaDiRBhn8/AhXc642/Z/yIpizE2xG4KU4AXzb6C+o7LX/WmmsWP
 Ly6jamSg6tvrdo4/e87lUedEqCtrp2o1xpn5zongf6cQkaLZKQcBQnPmgHO5OG8+50u88D9I
 rywqgzTUhHFKKF6/9L/lYtrNcHU8Z6Y4Ju/MLUiNYkmtrGIMnkjKCiRqlRrZE/v5YFHbayRD
 dJKXobXTtCBYpLJM4ZYRpGZXne/FAtWNe4KbNJJqxMvrTOrnIatPj8NhBVI0RSJRsbilh6TE
 m6M14QORSWTLRg==
In-Reply-To: <20250711151730.rz_TY1Qq@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 40F62211E3
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
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,oracle.com,linux.dev,suse.com,kernel.org,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -3.01

On 7/11/25 17:17, Sebastian Andrzej Siewior wrote:
> On 2025-07-11 11:55:22 [+0200], Vlastimil Babka wrote:
>> On 7/11/25 09:50, Sebastian Andrzej Siewior wrote:
>> > On 2025-07-08 18:53:00 [-0700], Alexei Starovoitov wrote:
>> >> From: Alexei Starovoitov <ast@kernel.org>
>> >> 
>> >> Introduce local_lock_lockdep_start/end() pair to teach lockdep
>> >> about a region of execution where per-cpu local_lock is not taken
>> >> and lockdep should consider such local_lock() as "trylock" to
>> >> avoid multiple false-positives:
>> >> - lockdep doesn't like when the same lock is taken in normal and
>> >>   in NMI context
>> >> - lockdep cannot recognize that local_locks that protect kmalloc
>> >>   buckets are different local_locks and not taken together
>> >> 
>> >> This pair of lockdep aid is used by slab in the following way:
>> >> 
>> >> if (local_lock_is_locked(&s->cpu_slab->lock))
>> >> 	goto out;
>> >> local_lock_lockdep_start(&s->cpu_slab->lock);
>> >> p = ___slab_alloc(s, gfpflags, node, addr, c, orig_size);
>> >> local_lock_lockdep_end(&s->cpu_slab->lock);
>> >> 
>> >> Where ___slab_alloc() is calling
>> >> local_lock_irqsave(&s->cpu_slab->lock, ...) many times,
>> >> and all of them will not deadlock since this lock is not taken.
>> > 
>> > So you prefer this instead of using a trylock variant in ___slab_alloc()
>> > which would simply return in case the trylock fails?
>> 
>> The code isn't always in a position to "simply return". On !RT I think we
>> can at least assume that if we succeeded once, it means we're not a irq/nmi
>> interrupting a locked context so we'll succeed the following attempts too.
>> On RT IIUC the lock might be taken by someone else, so a trylock might fail
>> (even if it should also mean we're in a context that can do a non-try lock).
> 
> There is this parent check. If the parent check "allows" the allocation
> then on !RT the trylock should always succeed. So the return "empty
> handed" would be there but should not happen kind of thing.
> 
> On RT this is different so local_lock_is_locked() will return false but
> the trylock might fail if the lock is acquired by another task.
> 
> But then with this change we do trylock from lockdep's point of view
> while in reality we do the full locking including possible context
> switch.
> 
> That is why I don't like the part where we trick lockdep.
> 
> If we the parent check we could trylock for !RT and normal lock for RT
> what we actual do.
> If there is no parent check then we could do "normal lock" on both
> sides.

So you mean the approach of v1 with local_lock_irqsave_check()?

https://lore.kernel.org/bpf/20250501032718.65476-5-alexei.starovoitov@gmail.com/#t

> Sebastian


