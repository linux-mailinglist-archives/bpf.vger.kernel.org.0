Return-Path: <bpf+bounces-79201-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF0D2D42A
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 08:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B747303B7E1
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB412DE6F8;
	Fri, 16 Jan 2026 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hL/jJS0K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VbiDfBAZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pWRLH+sp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yYaTRxrR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF7239594
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768548725; cv=none; b=fI+T0kPjbXPXZBj+NLGhSturNYvgcKwCHBPq1GyrqZj4yFsOLfIagZdW+fpxHrPePem9Sf/z5xd/+FTKmAOXBD1ePiQI/y6Uxt0g9n4l0Ge5vNRSrRvsk5RhKGS3z+s4xlqjkUlOUnU+RXOt3JHtlCbACIpb1zw+0LdcmwSECIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768548725; c=relaxed/simple;
	bh=ZtQxJ8ueBoqXAK3o1iU2HX2eU/98FbTJWjS5Tjp61Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqgPtMvt5FdFdV1u++q3A2lz0FUMhqr9z4RY5+47QMjmj4sFI+8YwZDNyVNNtLR+OXQ1kFWySZfcdM9z6wTdaFziab9dIz4xCci5HD31NknEaiabsyF7ckrtDUsBz6UeTaMAmB/I1J9MDbO3GE5rN3wRTc52byp5pc2U9wiyYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hL/jJS0K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VbiDfBAZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pWRLH+sp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yYaTRxrR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F9D23368D;
	Fri, 16 Jan 2026 07:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768548722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J2wMFYYHoLIThQowW1m8IBwEmgJ9j6LTflF8fZXK/As=;
	b=hL/jJS0KTC2jbJHdoBF//DpqTjKeB8QXjauyPkmUBdYycD18rietaH1qXesIeuj0pOGXpU
	3gKFjCDN7+209wweEh2lwBfZXosK/72g3eqaEP1GJqgoazLFlcEBia4sy6I0NL5u41ivbT
	BiLlFGi6KE8iLmswGYdSNA3244LghV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768548722;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J2wMFYYHoLIThQowW1m8IBwEmgJ9j6LTflF8fZXK/As=;
	b=VbiDfBAZit/VibmjpApls2s/VKBpsq4qZV66Pe5cjvQpfFea9IK2vi9Gu2HOey/KyHHWIE
	pNfzjyCdzdgyL/Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768548720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J2wMFYYHoLIThQowW1m8IBwEmgJ9j6LTflF8fZXK/As=;
	b=pWRLH+spXqtExwaW6Va5t+kWsGQFZancyDdB1ooHaZyGXsTmq1f4ToFA6/rHxyehQnfpKd
	oHQV71Pwj/mfetNBS5krPZqeC1pjwWFTkpO8qJGnXxhmcToDJQ929heAup+YslyoLQ6/eS
	hKKmeAZgzxaSZ/yMIefQ7/+kCW9Iz+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768548720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=J2wMFYYHoLIThQowW1m8IBwEmgJ9j6LTflF8fZXK/As=;
	b=yYaTRxrR3IzxX6QikSaiombwVAayWwW/4zyaAQLMXXw0jSwZPZXKWx7Tk36yzCJ98pl+gF
	7h1SE9+poq0AfCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 788233EA63;
	Fri, 16 Jan 2026 07:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jQHIG3DpaWlfTAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 16 Jan 2026 07:32:00 +0000
Message-ID: <bb58c778-be6b-445e-a331-ddaf04f97f0e@suse.cz>
Date: Fri, 16 Jan 2026 08:32:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 08/20] slab: add optimized sheaf refill from
 partial list
Content-Language: en-US
To: Hao Li <hao.li@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>, Petr Tesarik <ptesarik@suse.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 bpf@vger.kernel.org, kasan-dev@googlegroups.com
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-8-98225cfb50cf@suse.cz>
 <38de0039-e0ea-41c4-a293-400798390ea1@suse.cz>
 <kp7fvhxxjyyzk47n67m4xwzgm7gxoqmgglqdvzpkcxqb26sjc4@bu4lil75nc3c>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <kp7fvhxxjyyzk47n67m4xwzgm7gxoqmgglqdvzpkcxqb26sjc4@bu4lil75nc3c>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 1/16/26 07:27, Hao Li wrote:
> On Thu, Jan 15, 2026 at 03:25:59PM +0100, Vlastimil Babka wrote:
>> On 1/12/26 16:17, Vlastimil Babka wrote:
>> > At this point we have sheaves enabled for all caches, but their refill
>> > is done via __kmem_cache_alloc_bulk() which relies on cpu (partial)
>> > slabs - now a redundant caching layer that we are about to remove.
>> > 
>> > The refill will thus be done from slabs on the node partial list.
>> > Introduce new functions that can do that in an optimized way as it's
>> > easier than modifying the __kmem_cache_alloc_bulk() call chain.
>> > 
>> > Extend struct partial_context so it can return a list of slabs from the
>> > partial list with the sum of free objects in them within the requested
>> > min and max.
>> > 
>> > Introduce get_partial_node_bulk() that removes the slabs from freelist
>> > and returns them in the list.
>> > 
>> > Introduce get_freelist_nofreeze() which grabs the freelist without
>> > freezing the slab.
>> > 
>> > Introduce alloc_from_new_slab() which can allocate multiple objects from
>> > a newly allocated slab where we don't need to synchronize with freeing.
>> > In some aspects it's similar to alloc_single_from_new_slab() but assumes
>> > the cache is a non-debug one so it can avoid some actions.
>> > 
>> > Introduce __refill_objects() that uses the functions above to fill an
>> > array of objects. It has to handle the possibility that the slabs will
>> > contain more objects that were requested, due to concurrent freeing of
>> > objects to those slabs. When no more slabs on partial lists are
>> > available, it will allocate new slabs. It is intended to be only used
>> > in context where spinning is allowed, so add a WARN_ON_ONCE check there.
>> > 
>> > Finally, switch refill_sheaf() to use __refill_objects(). Sheaves are
>> > only refilled from contexts that allow spinning, or even blocking.
>> > 
>> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> ...
>> 
>> > +static unsigned int alloc_from_new_slab(struct kmem_cache *s, struct slab *slab,
>> > +		void **p, unsigned int count, bool allow_spin)
>> > +{
>> > +	unsigned int allocated = 0;
>> > +	struct kmem_cache_node *n;
>> > +	unsigned long flags;
>> > +	void *object;
>> > +
>> > +	if (!allow_spin && (slab->objects - slab->inuse) > count) {
>> > +
>> > +		n = get_node(s, slab_nid(slab));
>> > +
>> > +		if (!spin_trylock_irqsave(&n->list_lock, flags)) {
>> > +			/* Unlucky, discard newly allocated slab */
>> > +			defer_deactivate_slab(slab, NULL);
>> 
>> This actually does dec_slabs_node() only with slab->frozen which we don't set.
> 
> Hi, I think I follow the intent, but I got a little tripped up here: patch 08
> (current patch) seems to assume "slab->frozen = 1" is already gone. That's true
> after the whole series, but the removal only happens in patch 09.
> 
> Would it make sense to avoid relying on that assumption when looking at patch 08
> in isolation?

Hm I did think it's fine. alloc_from_new_slab() introduced here is only used
from __refill_objects() and that one doesn't set slab->frozen = 1 on the new
slab?

Then patch 09 switches ___slab_alloc() to alloc_from_new_slab() and at the
same time also stops setting slab->frozen = 1 so it should be also fine.

And then 12/20 slab: remove defer_deactivate_slab() removes the frozen = 1
treatment as nobody uses it anymore.

If there's some mistake in the above, please tell!

Thanks.

