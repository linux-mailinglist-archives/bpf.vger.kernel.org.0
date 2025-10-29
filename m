Return-Path: <bpf+bounces-72830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 907ECC1BCDF
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 16:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB391A220E8
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 15:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8F34DB59;
	Wed, 29 Oct 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Uxy6L1d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rVQuBd41";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Uxy6L1d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rVQuBd41"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E634D4CE
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753066; cv=none; b=SkDOXHvsmdqgPJydhudzfZOReMvItTylUCrgGIr9ZhGIxz2qUaaXLOSmSgD9FOxlRAGfJklY1QEmW/TYVzIWnf9Yg7u7zaGXU9twZXuKgNJcFEIldgPRShceemYn3HPTN3O2k5M3wlfzIkjh5X/Oqi/XTHCUQMOWGQLMImElXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753066; c=relaxed/simple;
	bh=nyo3l7oOIUDQCvkzUYIht3lxymM8rOleydeJwvL7IIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8A45ft6J7IhwT4sJbgfCr0Aj5NouT0fvym7NX4kZWLH5zkBUIJUAJlT/o2Z96oHWRho/ug98Gj/iXZfCf/tKNsVnUE2Qmi8JijTFLvv+Ex2/LqsQ59zTKowzKZ8bDkQcJhEahyM1cVgieSogY01nNumzmfLUtuUan7JMg+V4dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Uxy6L1d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rVQuBd41; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Uxy6L1d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rVQuBd41; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 00D5D33E4C;
	Wed, 29 Oct 2025 15:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761753063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=38XVem9V9R+8KoeP3WL2xrsbd2vq05h7o4o1fLwBkic=;
	b=1Uxy6L1d7Um7O6aes80HVn1FkXOOB7KchA42iMzhSLJCMHr6WnfT2l8g5tm092KJkHfq2T
	OHvV6rA+Hxis57GReUprFeYcF0PJHufgCFBszl2vYzMuvJKGJ+8zSSx9vcuXevhoQBMBDz
	/LNHbLfYkiwsnHFNHzmE/6TdbDAABlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761753063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=38XVem9V9R+8KoeP3WL2xrsbd2vq05h7o4o1fLwBkic=;
	b=rVQuBd41DVOdI0CCV7dfWawL/cFnURsv7gYJbgrGTN6p4XIUfOK9lXn2TYlLOlFQ9uh80F
	Wj4NkDG0OLK9E/Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761753063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=38XVem9V9R+8KoeP3WL2xrsbd2vq05h7o4o1fLwBkic=;
	b=1Uxy6L1d7Um7O6aes80HVn1FkXOOB7KchA42iMzhSLJCMHr6WnfT2l8g5tm092KJkHfq2T
	OHvV6rA+Hxis57GReUprFeYcF0PJHufgCFBszl2vYzMuvJKGJ+8zSSx9vcuXevhoQBMBDz
	/LNHbLfYkiwsnHFNHzmE/6TdbDAABlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761753063;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=38XVem9V9R+8KoeP3WL2xrsbd2vq05h7o4o1fLwBkic=;
	b=rVQuBd41DVOdI0CCV7dfWawL/cFnURsv7gYJbgrGTN6p4XIUfOK9lXn2TYlLOlFQ9uh80F
	Wj4NkDG0OLK9E/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D34461349D;
	Wed, 29 Oct 2025 15:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hcnzMuY3AmkcBwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 29 Oct 2025 15:51:02 +0000
Message-ID: <48e0bc5b-ccee-4fce-8a89-a32f79228bb6@suse.cz>
Date: Wed, 29 Oct 2025 16:51:02 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/19] slab: introduce percpu sheaves bootstrap
Content-Language: en-US
To: Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20251024152913.1115220-1-clm@meta.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251024152913.1115220-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gentwo.org,google.com,linux.dev,oracle.com,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 10/24/25 17:29, Chris Mason wrote:
> On Thu, 23 Oct 2025 15:52:28 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> Until now, kmem_cache->cpu_sheaves was !NULL only for caches with
>> sheaves enabled. Since we want to enable them for almost all caches,
>> it's suboptimal to test the pointer in the fast paths, so instead
>> allocate it for all caches in do_kmem_cache_create(). Instead of testing
>> the cpu_sheaves pointer to recognize caches (yet) without sheaves, test
>> kmem_cache->sheaf_capacity for being 0, where needed.
>> 
>> However, for the fast paths sake we also assume that the main sheaf
>> always exists (pcs->main is !NULL), and during bootstrap we cannot
>> allocate sheaves yet.
>> 
>> Solve this by introducing a single static bootstrap_sheaf that's
>> assigned as pcs->main during bootstrap. It has a size of 0, so during
>> allocations, the fast path will find it's empty. Since the size of 0
>> matches sheaf_capacity of 0, the freeing fast paths will find it's
>> "full". In the slow path handlers, we check sheaf_capacity to recognize
>> that the cache doesn't (yet) have real sheaves, and fall back. Thus
>> sharing the single bootstrap sheaf like this for multiple caches and
>> cpus is safe.
>>
> 
> Hi Vlastimil,
> 
> We're trying out the AI patch review automation on the BPF commits and it had
> some questions about a few of these.  Since the goal is to actually test the
> automation, I'm putting them in unedited, but I did try and make sure they
> were valid before sending.
> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index a6e58d3708f4..ecb10ed5acfe 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
> 
> [ ... ]
> 
>> @@ -7733,8 +7782,7 @@ static void free_kmem_cache_nodes(struct kmem_cache *s)
>>  void __kmem_cache_release(struct kmem_cache *s)
>>  {
>>  	cache_random_seq_destroy(s);
>> -	if (s->cpu_sheaves)
>> -		pcs_destroy(s);
>> +	pcs_destroy(s);
> 
> Can pcs_destroy() handle a NULL cpu_sheaves pointer? Looking at the
> error path in do_kmem_cache_create():

Good catch! I will leave the condition in __kmem_cache_release().
Thanks!


