Return-Path: <bpf+bounces-79555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA2BD3BF59
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 07:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C646A387ED4
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 06:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381A736CDE5;
	Tue, 20 Jan 2026 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HgCjMk+E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/RqIpGWo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ScNhbrR+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CwkFapkR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24CF25E469
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 06:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768890831; cv=none; b=Kurki3cYY9x25vPqWcEmibuSlUXH9x2P6A4m45jkZF7AJZN3e+3QEVCb7eMs+KbBQHFndbOwJqmePMdvJVRo9P+/7r6dOm/enYJJXulrK1hY8JmAqm3lC/353Ax7IoB0LhZ3KExkVjoB4RnlVkak5p3B5B82Dpl+qT8zSCS4UpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768890831; c=relaxed/simple;
	bh=KXeRJUZVaD7odE8+ZrzEevkPbI7J9h1CXhPnrEp+Dug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2gVdb9Ls0yzkwpHcv26ZbVy/qBjlen3hWlHTsSf3Uhb8iKX19OIgJUvRyT7nGZiYAA5Jhktfby/d3xru47iSxzZub1ytBw0S5T6LH2v0fJ6YYX4kMo/TJYkUBdA1K/mlYOr4w7p0Yls66jsRPIR/rnJ/oPNxq9OHl7+13JGtPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HgCjMk+E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/RqIpGWo; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ScNhbrR+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CwkFapkR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DDF775BCC9;
	Tue, 20 Jan 2026 06:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768890828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VK5LAWZJGesYmfMe3akrFE9Qr+u5i9eRqUPU6M9O84A=;
	b=HgCjMk+Eeeek0ViYMGJZHfXPrpt91EQyv/WZhxIssU7+VTqcZMCHLR9PaARjSrRv+9y81C
	Ca4VPpdPw9/s9SAMX8K74Bow/H7G4J1T66yl6jr018FUgpRii1fIc4hf/o+xR/mhO9Y7yx
	TqTse/uDn4KB4O3xziG1Dy8tjTdNjMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768890828;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VK5LAWZJGesYmfMe3akrFE9Qr+u5i9eRqUPU6M9O84A=;
	b=/RqIpGWoYhLlSBZI1+coiVcbhpn4cXVVNMgcAF05LnsnR+0A8Cb3jXGIV577L/BBhgS35b
	yInvfJ1pkLwYXGAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768890827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VK5LAWZJGesYmfMe3akrFE9Qr+u5i9eRqUPU6M9O84A=;
	b=ScNhbrR+3/oaBrjT9QPc7vNyJBqtT/kLM6kXRBYM6ATBcu66I99UJZwUcVJP4hGjGwtNzm
	CFrLQ7Cr6zNqv7hOSVpSPfR2rq6cczVcyLcsAg5tLP/WScyx7vlsqVcI12gWSY4vTHEi6U
	toEujIvHQrKUOT8TeyqvXJLX7KqZcHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768890827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VK5LAWZJGesYmfMe3akrFE9Qr+u5i9eRqUPU6M9O84A=;
	b=CwkFapkRy8eNu4Yhm45k1te576OuxQByC7CIkaBzdUH+y1blptJ2vChjRTZae9SXOw6Mdo
	H9pm0J2cedcycyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC09A3EA63;
	Tue, 20 Jan 2026 06:33:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c0s8KMshb2lLAgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 20 Jan 2026 06:33:47 +0000
Message-ID: <2232564a-b3f7-4591-abe2-8f1711590e6e@suse.cz>
Date: Tue, 20 Jan 2026 07:33:47 +0100
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
 <aW7pSzVPvLLbQGxn@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aW7pSzVPvLLbQGxn@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,oracle.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 1/20/26 03:32, Harry Yoo wrote:
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
>> @@ -246,6 +246,9 @@ struct partial_context {
>>  	gfp_t flags;
>>  	unsigned int orig_size;
>>  	void *object;
>> +	unsigned int min_objects;
>> +	unsigned int max_objects;
>> +	struct list_head slabs;
>>  };
>>  
>>  static inline bool kmem_cache_debug(struct kmem_cache *s)
>> @@ -2663,8 +2666,8 @@ static int refill_sheaf(struct kmem_cache *s, struct slab_sheaf *sheaf,
>>  	if (!to_fill)
>>  		return 0;
>>  
>> -	filled = __kmem_cache_alloc_bulk(s, gfp, to_fill,
>> -					 &sheaf->objects[sheaf->size]);
>> +	filled = __refill_objects(s, &sheaf->objects[sheaf->size], gfp,
>> +			to_fill, to_fill);
> 
> nit: perhaps handling min and max separately is unnecessary
> if it's always min == max? we could have simply one 'count' or 'size'?

Right, so the plan was to set min to some fraction of max when refilling
sheaves, with the goal of maximizing the chance that once we grab a slab
from the partial list, we almost certainly fully use it and don't have to
return it back. But I didn't get to there yet. It seems worthwile to try
though so we can leave the implementation prepared for it?

> Otherwise LGTM!
> 


