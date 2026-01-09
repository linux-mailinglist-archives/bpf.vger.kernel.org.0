Return-Path: <bpf+bounces-78279-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78710D07C01
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 09:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 043533010E4D
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435CF2ECD32;
	Fri,  9 Jan 2026 08:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FkPvOdy0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VpF9TpUl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FkPvOdy0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VpF9TpUl"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582221C3BFC
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767946601; cv=none; b=XI5O46Gq+vQ2O1l48q7FMLzC0ivMH8qSf1DG4BCm2VCkgtRbszpfApw+TYQz5yURtKC0y16ZQ/pcyH0Y0+Yj7mqdN9hU8S/Z18A+t1ymc4ux8hBYil/5DQ/QmXEUcGmReqJdSxYMNTBgrxU7tEP+JyAeZk5tkVJGDNf6Ok2WNMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767946601; c=relaxed/simple;
	bh=ubzx7ZpkZu6IGVzLW79IOQoSSBML1f/jn7dmqnt0JlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcMuRysFuNuS9uEnuhvBCxTFsMsMNl7cX2MhmwRABJFKLL3UuD8I2PQ7nrmgYPesIQ1suodGSvvx5m47wduxGbDZIn4JCXETWxzCx6Cs8fO8VWeDE872fDSN1TRG2mG/q8W1xL2kzpmmm0u+ZWgjblEVTKz1TZvhSLgwH6DqaVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FkPvOdy0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VpF9TpUl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FkPvOdy0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VpF9TpUl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C7B55D26F;
	Fri,  9 Jan 2026 08:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767946598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G1ZOpYG1RRBOh0980GoYceIDOSrHq5NcrrJc5uKkl0U=;
	b=FkPvOdy0sQddOf6QKdCSucqMynteBedhjGe6uj9PAiZ+ZmNNI0oCkifZLBtrU7HstPOTJJ
	l7YWlb/769veZh12glwpf5g9xHUMT0KzR7UmJj3Kl0icR9BRH/QXS6yfXyeMuVb8PKnf86
	++LEsCh4NhnkwqPQE3llKVxPbJJMnUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767946598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G1ZOpYG1RRBOh0980GoYceIDOSrHq5NcrrJc5uKkl0U=;
	b=VpF9TpUlE4adfKB6l/UFaCwK2gdFSlC9NRGvz2X73c3sPaXQ4QRI3AarSUs0Ww5IX7FoDu
	GwM6mM4bmajdHVAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767946598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G1ZOpYG1RRBOh0980GoYceIDOSrHq5NcrrJc5uKkl0U=;
	b=FkPvOdy0sQddOf6QKdCSucqMynteBedhjGe6uj9PAiZ+ZmNNI0oCkifZLBtrU7HstPOTJJ
	l7YWlb/769veZh12glwpf5g9xHUMT0KzR7UmJj3Kl0icR9BRH/QXS6yfXyeMuVb8PKnf86
	++LEsCh4NhnkwqPQE3llKVxPbJJMnUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767946598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=G1ZOpYG1RRBOh0980GoYceIDOSrHq5NcrrJc5uKkl0U=;
	b=VpF9TpUlE4adfKB6l/UFaCwK2gdFSlC9NRGvz2X73c3sPaXQ4QRI3AarSUs0Ww5IX7FoDu
	GwM6mM4bmajdHVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D9E33EA63;
	Fri,  9 Jan 2026 08:16:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rTO2Dma5YGnkOwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 09 Jan 2026 08:16:38 +0000
Message-ID: <28e6827e-f689-45d9-b2b5-804a8aafad2e@suse.cz>
Date: Fri, 9 Jan 2026 09:16:37 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/19] slab: remove cpu (partial) slabs usage from
 allocation paths
Content-Language: en-US
To: Chris Mason <clm@meta.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com,
 Petr Tesarik <ptesarik@suse.com>, "Paul E . McKenney" <paulmck@kernel.org>
References: <20251024142927.780367-1-clm@meta.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20251024142927.780367-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gentwo.org,google.com,oracle.com,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,suse.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 10/24/25 16:29, Chris Mason wrote:
> On Thu, 23 Oct 2025 15:52:32 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> 
>> We now rely on sheaves as the percpu caching layer and can refill them
>> directly from partial or newly allocated slabs. Start removing the cpu
>> (partial) slabs code, first from allocation paths.
>> 
>> This means that any allocation not satisfied from percpu sheaves will
>> end up in ___slab_alloc(), where we remove the usage of cpu (partial)
>> slabs, so it will only perform get_partial() or new_slab().
>> 
>> In get_partial_node() we used to return a slab for freezing as the cpu
>> slab and to refill the partial slab. Now we only want to return a single
>> object and leave the slab on the list (unless it became full). We can't
>> simply reuse alloc_single_from_partial() as that assumes freeing uses
>> free_to_partial_list(). Instead we need to use __slab_update_freelist()
>> to work properly against a racing __slab_free().
>> 
>> The rest of the changes is removing functions that no longer have any
>> callers.
>>
> 
> Hi Vlastimil,
> 
> We're trying out the AI patch review automation on the BPF commits and it had
> some questions about a few of these.  Since the goal is to actually test the
> automation, I'm putting them in unedited, but I did try and make sure they
> were valid before sending.
> 
> This one seems pretty unlikely but still worth fixing:
> 
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index e2b052657d11..bd67336e7c1f 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
> 
> [ ... ]
> 
>> @@ -3575,15 +3532,15 @@ static bool get_partial_node_bulk(struct kmem_cache *s,
>>  }
>>
>>  /*
>> - * Try to allocate a partial slab from a specific node.
>> + * Try to allocate object from a partial slab on a specific node.
>>   */
>> -static struct slab *get_partial_node(struct kmem_cache *s,
>> -				     struct kmem_cache_node *n,
>> -				     struct partial_context *pc)
>> +static void *get_partial_node(struct kmem_cache *s,
>> +			      struct kmem_cache_node *n,
>> +			      struct partial_context *pc)
>>  {
>> -	struct slab *slab, *slab2, *partial = NULL;
>> +	struct slab *slab, *slab2;
>>  	unsigned long flags;
>> -	unsigned int partial_slabs = 0;
>> +	void *object;
>>
>>  	/*
>>  	 * Racy check. If we mistakenly see no partial slabs then we
>> @@ -3599,54 +3556,54 @@ static struct slab *get_partial_node(struct kmem_cache *s,
>>  	else if (!spin_trylock_irqsave(&n->list_lock, flags))
>>  		return NULL;
>>  	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
>> +
>> +		unsigned long counters;
>> +		struct slab new;
>> +
>>  		if (!pfmemalloc_match(slab, pc->flags))
>>  			continue;
> 
> Can get_partial_node() return an uninitialized pointer? The variable
> 'object' is declared but never initialized. If all slabs in the partial
> list fail the pfmemalloc_match() check, the loop completes without
> setting 'object', then returns it at the end of the function.
> 
> In the previous version, the equivalent 'partial' variable was explicitly
> initialized to NULL. When all slabs were skipped, NULL was returned.

By the way, there was another bug in this patch, causing a severe memory
leak, which the AI unfortunately didn't flag. Petr reported it during
performance testing and it took me more than a day to find it. Oh well :)

Wonder if things got better since then perhaps, and your or Roman's tools
would find it today? :)

>>
>>  		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>> -			void *object = alloc_single_from_partial(s, n, slab,
>> +			object = alloc_single_from_partial(s, n, slab,
>>  							pc->orig_size);
>> -			if (object) {
>> -				partial = slab;
>> -				pc->object = object;
>> +			if (object)
>>  				break;
>> -			}
>>  			continue;
>>  		}
>>
>> -		remove_partial(n, slab);
>> -
>> -		if (!partial) {
>> -			partial = slab;
>> -			stat(s, ALLOC_FROM_PARTIAL);
>> -
>> -			if ((slub_get_cpu_partial(s) == 0)) {
>> -				break;
>> -			}
>> -		} else {
>> -			put_cpu_partial(s, slab, 0);
>> -			stat(s, CPU_PARTIAL_NODE);
>> -
>> -			if (++partial_slabs > slub_get_cpu_partial(s) / 2) {
>> -				break;
>> -			}
>> -		}
>> +		/*
>> +		 * get a single object from the slab. This might race against
>> +		 * __slab_free(), which however has to take the list_lock if
>> +		 * it's about to make the slab fully free.
>> +		 */
>> +		do {
>> +			object = slab->freelist;
>> +			counters = slab->counters;
>> +			new.freelist = get_freepointer(s, object);
>> +			new.counters = counters;
>> +			new.inuse++;
>> +		} while (!__slab_update_freelist(s, slab,
>> +			object, counters,
>> +			new.freelist, new.counters,
>> +			"get_partial_node"));
>> +
>> +		if (!new.freelist)
>> +			remove_partial(n, slab);
>>  	}
>>  	spin_unlock_irqrestore(&n->list_lock, flags);
>> -	return partial;
>> +	return object;
>>  }
> 
> [ ... ]
> 
> 
> 


