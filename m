Return-Path: <bpf+bounces-73791-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C572C39630
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 08:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4EEA34F2FA
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30E2DE71B;
	Thu,  6 Nov 2025 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ru3bnl6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BsryQK1I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hkkosBGu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B0kfOKCP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748C2DCF70
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762413830; cv=none; b=UW3Gtv27TGoTdSIge9WdXveOD7U3CS4dZ6WdfrXbbIONkE8oOAldhWILmeED7R8cBCIhz/EQsYFqhGH62n8iV+pyKlkcmpCEF8JfhES9qYbyi9wp+eRxgZve2amV53nnGwuIokigANbuA/GTqSqRvjrC4yO9pYnWclIoo1Ds6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762413830; c=relaxed/simple;
	bh=PpCYZiESS+NYFao5qNfGpf2j/tTFJn3MrA5HeQxrUNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jkl/scQJzWHsItgCgycXYMZeSMx93X+XnLHJ3VcwmdThBLrxQe/BOOS7ZXpdIPTq8sadc97BV6MXmbVCFZMPOUyzTS7hVyJAlEBUWXIsWFkJ4SrfYj8hdHf874ey3G9c2xHP3aOFJXAd/MvIi+QmKUJe7bz33IHWtwgVY36UCZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ru3bnl6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BsryQK1I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hkkosBGu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B0kfOKCP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D7F59211C4;
	Thu,  6 Nov 2025 07:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762413826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7KuTnD+Lrz4fdyLGJ4uF39ab38gWiaLaVToVQMrbw5E=;
	b=1ru3bnl6zTaJQ22XU2gMsGWTpkp+gmHjZZ2t57pZnLSE0QjP0E4B1zcCm8TnUwYyfhG/ep
	OpbTc6WwNFKkMjtP4c8sXl6Ym+xAaFBERP40zXBQU74CT247gS/19DU9MnjP+otQHreMVI
	vs/S4A7gDgq3TAGLaO4pVQsRsSPNGmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762413826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7KuTnD+Lrz4fdyLGJ4uF39ab38gWiaLaVToVQMrbw5E=;
	b=BsryQK1I2wVpamBuHrtZ31BKHFAtMHf9K/Tl5yuw8v+MxsMLHcCbufG/28Lw2pHrIHXDzD
	PfSNFhbLG5sCPrAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hkkosBGu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=B0kfOKCP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762413825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7KuTnD+Lrz4fdyLGJ4uF39ab38gWiaLaVToVQMrbw5E=;
	b=hkkosBGuczAqLSXJr+/wi6QitrxxQFm0+AGDbamyv1Hy6AxZBklElEY7Ezgt4Bnt4z7fyQ
	qfBeJRVDWzYhbvr4amFFMTne3KNKcgx/e35xjXNT7ApSqUpDfqFPGM7/uSklQc27gFJD6Y
	yfvk/tclGtIKrrMi5bXpX6Z0o90D4hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762413825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7KuTnD+Lrz4fdyLGJ4uF39ab38gWiaLaVToVQMrbw5E=;
	b=B0kfOKCPU7tEewGxnfh3t5a/1LSwMFkJ2xB7BBlodeWGgw+J1Dj5HeNkwMa/qS9L6oRqlV
	QFQkN5b/C9x5+NDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B68C9139A9;
	Thu,  6 Nov 2025 07:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AZ9yKwFNDGk8GAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 06 Nov 2025 07:23:45 +0000
Message-ID: <2d4356a4-a0c1-423a-bd40-af1f8a28fd84@suse.cz>
Date: Thu, 6 Nov 2025 08:23:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] slab: move kfence_alloc() out of internal bulk alloc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Alexei Starovoitov <ast@kernel.org>,
 linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
 bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
 <20251105-sheaves-cleanups-v1-2-b8218e1ac7ef@suse.cz>
 <CAADnVQJY_iZ5a1_GbZ7HUot7tMwpxFyABEdrRU3tcMWPnVyGjg@mail.gmail.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQJY_iZ5a1_GbZ7HUot7tMwpxFyABEdrRU3tcMWPnVyGjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7F59211C4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

On 11/6/25 03:39, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 1:05 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> SLUB's internal bulk allocation __kmem_cache_alloc_bulk() can currently
>> allocate some objects from KFENCE, i.e. when refilling a sheaf. It works
>> but it's conceptually the wrong layer, as KFENCE allocations should only
>> happen when objects are actually handed out from slab to its users.
>>
>> Currently for sheaf-enabled caches, slab_alloc_node() can return KFENCE
>> object via kfence_alloc(), but also via alloc_from_pcs() when a sheaf
>> was refilled with KFENCE objects. Continuing like this would also
>> complicate the upcoming sheaf refill changes.
>>
>> Thus remove KFENCE allocation from __kmem_cache_alloc_bulk() and move it
>> to the places that return slab objects to users. slab_alloc_node() is
>> already covered (see above). Add kfence_alloc() to
>> kmem_cache_alloc_from_sheaf() to handle KFENCE allocations from
>> prefilled sheafs, with a comment that the caller should not expect the
>> sheaf size to decrease after every allocation because of this
>> possibility.
>>
>> For kmem_cache_alloc_bulk() implement a different strategy to handle
>> KFENCE upfront and rely on internal batched operations afterwards.
>> Assume there will be at most once KFENCE allocation per bulk allocation
>> and then assign its index in the array of objects randomly.
>>
>> Cc: Alexander Potapenko <glider@google.com>
>> Cc: Marco Elver <elver@google.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/slub.c | 44 ++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 36 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 074abe8e79f8..0237a329d4e5 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5540,6 +5540,9 @@ int kmem_cache_refill_sheaf(struct kmem_cache *s, gfp_t gfp,
>>   *
>>   * The gfp parameter is meant only to specify __GFP_ZERO or __GFP_ACCOUNT
>>   * memcg charging is forced over limit if necessary, to avoid failure.
>> + *
>> + * It is possible that the allocation comes from kfence and then the sheaf
>> + * size is not decreased.
>>   */
>>  void *
>>  kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>> @@ -5551,7 +5554,10 @@ kmem_cache_alloc_from_sheaf_noprof(struct kmem_cache *s, gfp_t gfp,
>>         if (sheaf->size == 0)
>>                 goto out;
>>
>> -       ret = sheaf->objects[--sheaf->size];
>> +       ret = kfence_alloc(s, s->object_size, gfp);
>> +
>> +       if (likely(!ret))
>> +               ret = sheaf->objects[--sheaf->size];
> 
> Judging by this direction you plan to add it to kmalloc/alloc_from_pcs too?

No, kmem_cache_alloc_from_sheaf() is a new API for use cases like maple
tree, it's different from the internal alloc_from_pcs() caching.

> If so it will break sheaves+kmalloc_nolock approach in
> your prior patch set, since kfence_alloc() is not trylock-ed.
> Or this will stay kmem_cache specific?

I rechecked the result of the full RFC and kfence_alloc() didn't appear in
kmalloc_nolock() path. I would say this patch moved it rather in the
opposite direction, away from internal layers that could end up in
kmalloc_nolock() path when kmalloc caches have sheaves.

