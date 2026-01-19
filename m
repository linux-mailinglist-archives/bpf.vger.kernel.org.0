Return-Path: <bpf+bounces-79444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF4D3A5EB
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 11:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 045143008F2F
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0E1357A28;
	Mon, 19 Jan 2026 10:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+G/wKzO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mTUWSoZ8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i+G/wKzO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mTUWSoZ8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D0D280018
	for <bpf@vger.kernel.org>; Mon, 19 Jan 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768820063; cv=none; b=LG3IyVbDwZEOzqHrU2DgZN70mlSa0feXpRKwR8extAZlnqaZ7mYo9jNZO5bJwv0rkJCRXv8V/vopPmsqeFEhVsH6CvldlBJnU9jdwADQ83V614sc7Oz5ekE8srkZfVrnQ/kFqREvHI2ALGAH5dTRFd12G8pgwsKxNltiDrrurXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768820063; c=relaxed/simple;
	bh=8maX4MGR9fpdgnwDZUkuWWOQILdnkJ2tv2DcmjSf7eI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HINpEcWrRulHYPvl1T/VHGVWEz4jJ4IUblOq0OYOTcqyWpuRFgZF0WPO2ZiqqV5As2SGhq2b0dXgmhJLhEXPCu4JvTuc9XKvJB/qB5Hs+Y6dJACno6fWkS8zd7JckzCo/qc4tpNiz0jFW3Jj4WY4Vg1LXWpJVJ+jbUMbFRGTxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+G/wKzO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mTUWSoZ8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i+G/wKzO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mTUWSoZ8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 136C55BD6E;
	Mon, 19 Jan 2026 10:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768820059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ey0pNkWH40RKae/z7UghicYKnJcQmjtLJWpIQMJLIMw=;
	b=i+G/wKzOdqJTLtu23kB8UjAeRrBrBGBXCydzkMm2uMsF93aqNNgJYL9q7zsf8sURdk3bYp
	ryZ52RYS7CUiS81Q1qTzXMQyMOe+V8S6oJVJXesnDYBvSDu091/KkHnw/xM3eRnZk52Phe
	dquwy3it9zHbuRMMTKH5H6vdEF3J4NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768820059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ey0pNkWH40RKae/z7UghicYKnJcQmjtLJWpIQMJLIMw=;
	b=mTUWSoZ82Wh5tC2EkSwCa4mX8N+MeAezhTHKT2OKP4C1aCVapf2nz8rdQhkddrr/AsAA0Y
	V9HrkDZ52NmewWDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768820059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ey0pNkWH40RKae/z7UghicYKnJcQmjtLJWpIQMJLIMw=;
	b=i+G/wKzOdqJTLtu23kB8UjAeRrBrBGBXCydzkMm2uMsF93aqNNgJYL9q7zsf8sURdk3bYp
	ryZ52RYS7CUiS81Q1qTzXMQyMOe+V8S6oJVJXesnDYBvSDu091/KkHnw/xM3eRnZk52Phe
	dquwy3it9zHbuRMMTKH5H6vdEF3J4NY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768820059;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ey0pNkWH40RKae/z7UghicYKnJcQmjtLJWpIQMJLIMw=;
	b=mTUWSoZ82Wh5tC2EkSwCa4mX8N+MeAezhTHKT2OKP4C1aCVapf2nz8rdQhkddrr/AsAA0Y
	V9HrkDZ52NmewWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB6473EA63;
	Mon, 19 Jan 2026 10:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ZyyM1oNbmkGKQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 19 Jan 2026 10:54:18 +0000
Message-ID: <e106a4d5-32f7-4314-b8c1-19ebc6da6d7a@suse.cz>
Date: Mon, 19 Jan 2026 11:54:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/21] slab: add optimized sheaf refill from partial
 list
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260116-sheaves-for-all-v3-0-5595cb000772@suse.cz>
 <20260116-sheaves-for-all-v3-9-5595cb000772@suse.cz>
 <aW3SJBR1BcDor-ya@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aW3SJBR1BcDor-ya@hyeyoo>
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
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,oracle.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/19/26 07:41, Harry Yoo wrote:
> On Fri, Jan 16, 2026 at 03:40:29PM +0100, Vlastimil Babka wrote:
>> At this point we have sheaves enabled for all caches, but their refill
>> is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
>> slabs - now a redundant caching layer that we are about to remove.
>> 
>> The refill will thus be done from slabs on the node partial list.
>> Introduce new functions that can do that in an optimized way as it's
>> easier than modifying the __kmem_cache_alloc_bulk() call chain.
>> 
>> Extend struct partial_context so it can return a list of slabs from the
>> partial list with the sum of free objects in them within the requested
>> min and max.
>> 
>> Introduce get_partial_node_bulk() that removes the slabs from freelist
>> and returns them in the list.
>> 
>> Introduce get_freelist_nofreeze() which grabs the freelist without
>> freezing the slab.
>> 
>> Introduce alloc_from_new_slab() which can allocate multiple objects from
>> a newly allocated slab where we don't need to synchronize with freeing.
>> In some aspects it's similar to alloc_single_from_new_slab() but assumes
>> the cache is a non-debug one so it can avoid some actions.
>> 
>> Introduce __refill_objects() that uses the functions above to fill an
>> array of objects. It has to handle the possibility that the slabs will
>> contain more objects that were requested, due to concurrent freeing of
>> objects to those slabs. When no more slabs on partial lists are
>> available, it will allocate new slabs. It is intended to be only used
>> in context where spinning is allowed, so add a WARN_ON_ONCE check there.
>> 
>> Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
>> only refilled from contexts that allow spinning, or even blocking.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 284 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
>>  1 file changed, 264 insertions(+), 20 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 9bea8a65e510..dce80463f92c 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -3522,6 +3525,63 @@ static inline void put_cpu_partial(struct kmem_cache *s, struct slab *slab,
>>  #endif
>>  static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
>>  
>> +static bool get_partial_node_bulk(struct kmem_cache *s,
>> +				  struct kmem_cache_node *n,
>> +				  struct partial_context *pc)
>> +{
>> +	struct slab *slab, *slab2;
>> +	unsigned int total_free = 0;
>> +	unsigned long flags;
>> +
>> +	/* Racy check to avoid taking the lock unnecessarily. */
>> +	if (!n || data_race(!n->nr_partial))
>> +		return false;
>> +
>> +	INIT_LIST_HEAD(&pc->slabs);
>> +
>> +	spin_lock_irqsave(&n->list_lock, flags);
>> +
>> +	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
>> +		struct freelist_counters flc;
>> +		unsigned int slab_free;
>> +
>> +		if (!pfmemalloc_match(slab, pc->flags))
>> +			continue;
>> +		/*
>> +		 * determine the number of free objects in the slab racily
>> +		 *
>> +		 * due to atomic updates done by a racing free we should not
>> +		 * read an inconsistent value here, but do a sanity check anyway
>> +		 *
>> +		 * slab_free is a lower bound due to subsequent concurrent
>> +		 * freeing, the caller might get more objects than requested and
>> +		 * must deal with it
>> +		 */
>> +		flc.counters = data_race(READ_ONCE(slab->counters));
>> +		slab_free = flc.objects - flc.inuse;
>> +
>> +		if (unlikely(slab_free > oo_objects(s->oo)))
>> +			continue;
> 
> When is this condition supposed to be true?
> 
> I guess it's when __update_freelist_slow() doesn't update
> slab->counters atomically?

Yeah. Probably could be solvable with WRITE_ONCE() there, as this is only
about hypothetical read/write tearing, not seeing stale values. Or not? Just
wanted to be careful.

>> +
>> +		/* we have already min and this would get us over the max */
>> +		if (total_free >= pc->min_objects
>> +		    && total_free + slab_free > pc->max_objects)
>> +			break;
>> +
>> +		remove_partial(n, slab);
>> +
>> +		list_add(&slab->slab_list, &pc->slabs);
>> +
>> +		total_free += slab_free;
>> +		if (total_free >= pc->max_objects)
>> +			break;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&n->list_lock, flags);
>> +	return total_free > 0;
>> +}
>> +
>>  /*
>>   * Try to allocate a partial slab from a specific node.
>>   */
>> +static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
>> +		void **p, unsigned int count, bool allow_spin)
>> +{
>> +	unsigned int allocated = 0;
>> +	struct kmem_cache_node *n;
>> +	unsigned long flags;
>> +	void *object;
>> +
>> +	if (!allow_spin && (slab->objects - slab->inuse) > count) {
>> +
>> +		n = get_node(s, slab_nid(slab));
>> +
>> +		if (!spin_trylock_irqsave(&n->list_lock, flags)) {
>> +			/* Unlucky, discard newly allocated slab */
>> +			defer_deactivate_slab(slab, NULL);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	object = slab->freelist;
>> +	while (object && allocated < count) {
>> +		p[allocated] = object;
>> +		object = get_freepointer(s, object);
>> +		maybe_wipe_obj_freeptr(s, p[allocated]);
>> +
>> +		slab->inuse++;
>> +		allocated++;
>> +	}
>> +	slab->freelist = object;
>> +
>> +	if (slab->freelist) {
>> +
>> +		if (allow_spin) {
>> +			n = get_node(s, slab_nid(slab));
>> +			spin_lock_irqsave(&n->list_lock, flags);
>> +		}
>> +		add_partial(n, slab, DEACTIVATE_TO_HEAD);
>> +		spin_unlock_irqrestore(&n->list_lock, flags);
>> +	}
>> +
>> +	inc_slabs_node(s, slab_nid(slab), slab->objects);
> 
> Maybe add a comment explaining why inc_slabs_node() doesn't need to be
> called under n->list_lock?

Hm, we might not even be holding it. The old code also did the inc with no
comment. If anything could use one, it would be in
alloc_single_from_new_slab()? But that's outside the scope here.

>> +	return allocated;
>> +}
>> +
>>  /*
>>   * Slow path. The lockless freelist is empty or we need to perform
>>   * debugging duties.

>> +new_slab:
>> +
>> +	slab = new_slab(s, pc.flags, node);
>> +	if (!slab)
>> +		goto out;
>> +
>> +	stat(s, ALLOC_SLAB);
>> +
>> +	/*
>> +	 * TODO: possible optimization - if we know we will consume the whole
>> +	 * slab we might skip creating the freelist?
>> +	 */
>> +	refilled += alloc_from_new_slab(s, slab, p + refilled, max - refilled,
>> +					/* allow_spin = */ true);
>> +
>> +	if (refilled < min)
>> +		goto new_slab;
> 
> It should jump to out: label when alloc_from_new_slab() returns zero
> (trylock failed).
> 
> ...Oh wait, no. I was confused.
> 
> Why does alloc_from_new_slab() handle !allow_spin case when it cannot be
> called if allow_spin is false?

The next patch will use it so it seemed easier to add it already. I'll note
in the commit log.

>> +out:
>> +
>> +	return refilled;
>> +}
> 


