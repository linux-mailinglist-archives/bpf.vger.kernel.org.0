Return-Path: <bpf+bounces-57642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9741FAADA4A
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 10:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DE11BA4EBC
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 08:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424CC1EDA0F;
	Wed,  7 May 2025 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O/eVGq/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D7zx5VAq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="O/eVGq/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D7zx5VAq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D599156F5E
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 08:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746607075; cv=none; b=bCf9zM3h55EieHNr2Ljs33/jZmIU3/jsDbdNDADXlZ7mi5lJjU1SeXX3P4kdyIteWcwhWDWXpwmtTD5Qdlzf1tgC4jDyBRS1YKgHZEin8uQuOxbG2e7bJ+RXUq8dXfEERKw8R6fJTBNkp/z5gNjkRRZV6gnZR4Vrgan+Vo09OSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746607075; c=relaxed/simple;
	bh=NQW8xXjeXVGY0TbusvBb+qOiUuoEjq5va79KqgDxiik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAG5rt+1dT6rV3E2W9xSpIevmJw3AiePMo76cuJxtiINq+cB2nGVDKmCxNd29II1NgW22qes1TQ4i0ovueaickXsMeNUQ6ak452EwYt0xSG6jEl5i7OmNiNLxvs1vtEZCmvUuryVn9Y6TjmrrYl0HYjwj3hvi0WsNWJa+JyFyxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O/eVGq/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D7zx5VAq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=O/eVGq/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D7zx5VAq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 40CAE1F393;
	Wed,  7 May 2025 08:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746607072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuGw+2A0zcG7uwRSEGpF5ulFuwZ13pZ5cWcQ1DSYJ/E=;
	b=O/eVGq/yvklZAjOPNKajLzcWqj4XMTBZWjc97mZ8/9/pLJff0syLcuiNjlrXui7u6mdyWJ
	JYLNu+9iQqvcu5GbTaOyTAagc07Km7qwwQA7MR9jUbLIc9Q+ce9EAkfomLM7tiIrPjR/wJ
	s2SsJKqUBURDz2eUaxTBBn9XEQqFN0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746607072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuGw+2A0zcG7uwRSEGpF5ulFuwZ13pZ5cWcQ1DSYJ/E=;
	b=D7zx5VAqh+WSeOx8thMAMkMQmlRI8wWuFYkdmgC82S04hqSdLPRVCWe1ek3YrzDzezpegS
	zDEl/m4oJ4F842Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746607072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuGw+2A0zcG7uwRSEGpF5ulFuwZ13pZ5cWcQ1DSYJ/E=;
	b=O/eVGq/yvklZAjOPNKajLzcWqj4XMTBZWjc97mZ8/9/pLJff0syLcuiNjlrXui7u6mdyWJ
	JYLNu+9iQqvcu5GbTaOyTAagc07Km7qwwQA7MR9jUbLIc9Q+ce9EAkfomLM7tiIrPjR/wJ
	s2SsJKqUBURDz2eUaxTBBn9XEQqFN0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746607072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuGw+2A0zcG7uwRSEGpF5ulFuwZ13pZ5cWcQ1DSYJ/E=;
	b=D7zx5VAqh+WSeOx8thMAMkMQmlRI8wWuFYkdmgC82S04hqSdLPRVCWe1ek3YrzDzezpegS
	zDEl/m4oJ4F842Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27C8C139D9;
	Wed,  7 May 2025 08:37:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LBVxCeAbG2h4awAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 07 May 2025 08:37:52 +0000
Message-ID: <361d189b-16b5-41af-b6f3-6e6fcd5c1805@suse.cz>
Date: Wed, 7 May 2025 10:38:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] slab: Introduce kmalloc_nolock() and kfree_nolock().
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org, willy@infradead.org
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-7-alexei.starovoitov@gmail.com>
 <4d3e5d4b-502b-459b-9779-c0bf55ef2a03@suse.cz> <aBqp1ScxaTznSf36@harry>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <aBqp1ScxaTznSf36@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,linux.dev,suse.com,linutronix.de,kernel.org,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 5/7/25 2:31 AM, Harry Yoo wrote:
> On Tue, May 06, 2025 at 02:01:48PM +0200, Vlastimil Babka wrote:
>>> @@ -4354,6 +4406,88 @@ void *__kmalloc_noprof(size_t size, gfp_t flags)
>>>  }
>>>  EXPORT_SYMBOL(__kmalloc_noprof);
>>>  
>>> +/**
>>> + * kmalloc_nolock - Allocate an object of given size from any context.
>>> + * @size: size to allocate
>>> + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_ZERO allowed.
>>> + * @node: node number of the target node.
>>> + *
>>> + * Return: pointer to the new object or NULL in case of error.
>>> + * NULL does not mean EBUSY or EAGAIN. It means ENOMEM.
>>> + * There is no reason to call it again and expect !NULL.
>>> + */
>>> +void *kmalloc_nolock_noprof(size_t size, gfp_t gfp_flags, int node)
>>> +{
>>> +	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_NOMEMALLOC | gfp_flags;
>>> +	struct kmem_cache *s;
>>> +	bool can_retry = true;
>>> +	void *ret = ERR_PTR(-EBUSY);
>>> +
>>> +	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_ZERO));
>>> +
>>> +	if (unlikely(size > KMALLOC_MAX_CACHE_SIZE))
>>> +		return NULL;
>>> +	if (unlikely(!size))
>>> +		return ZERO_SIZE_PTR;
>>> +
>>> +	if (!USE_LOCKLESS_FAST_PATH() && (in_nmi() || in_hardirq()))
>>> +		/* kmalloc_nolock() in PREEMPT_RT is not supported from irq */
>>> +		return NULL;
>>> +retry:
>>> +	s = kmalloc_slab(size, NULL, alloc_gfp, _RET_IP_);
>>
>> The idea of retrying on different bucket is based on wrong assumptions and
>> thus won't work as you expect. kmalloc_slab() doesn't select buckets truly
>> randomly, but deterministically via hashing from a random per-boot seed and
>> the _RET_IP_, as the security hardening goal is to make different kmalloc()
>> callsites get different caches with high probability.
> 
> It's not retrying with the same size, so I don't think it's relying on any
> assumption about random kmalloc caches. (yeah, it wastes some memory if
> allocated from the next size bucket)

Yeah sorry about that, a big oversight on my side. I saw the word bucket
and made the wrong conclusion without checking the code more closely.
It's because I wasn't used to seeing it until Kees introduced the
kmem_buckets typedef. But I realize that's a set of differently sized
buckets, and bucket is just one cache of the set. Yeah retrying with a
larger size is a smart trick.

> 	if (PTR_ERR(ret) == -EBUSY) {
> 		if (can_retry) {
> 			/* pick the next kmalloc bucket */
> 			size = s->object_size + 1;
> 			/*
> 			 * Another alternative is to
> 			 * if (memcg) alloc_gfp &= ~__GFP_ACCOUNT;
> 			 * else if (!memcg) alloc_gfp |= __GFP_ACCOUNT;
> 			 * to retry from bucket of the same size.
> 			 */
> 			can_retry = false;
> 			goto retry;
> 		}
> 		ret = NULL;
> 	}
> 
> By the way, it doesn't check if a kmalloc cache that can serve
> (s->object_size + 1) allocations actually exists, which is not true for
> the largest kmalloc cache?
> 


