Return-Path: <bpf+bounces-72837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B8C1CA91
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 19:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50C8586F06
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DD9354ACB;
	Wed, 29 Oct 2025 17:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0vqg8o/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TIYQS9PU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KxFlbH0u";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PVXWs+Ih"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32B2F744F
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759973; cv=none; b=qVgF9Zf2Dw3B22oP43tIyxA3LZK+v4OXPdy1dsw9c60PXezEn0+ZpHm0y9MlSFuutv67AEEPnPo0L+pFPbS2NW8U6TUq6mtA+lX1A0aodiC2CfjGesC6y/KA702rBQcXUxZUi0rl0uouTvIva23kAMzjlkxJEoLrGLIAtK3FWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759973; c=relaxed/simple;
	bh=jFzl3DrjLTruolPlveTiNUFKzj7ppmMOkQtANtXbt+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qIQF2YXJrwHT3FHo+DwmJqSE3qi3+3im5YRNEDGfcCMwium7yL4nzOD/N3prUHKX341R0fEt69LBt9H5zLnWVJ21BXmsKiL6/35ys4MV9wpm/uJ5taFK9wNs3Sk8ZLtqJ2Xzed6vxUQV7WCddoUjXsNtRvlNCnMee9PvMR4Ja/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0vqg8o/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TIYQS9PU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KxFlbH0u; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PVXWs+Ih; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E93E85C054;
	Wed, 29 Oct 2025 17:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761759969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F0sZF9w7yuT5ed92au3G/YD+ry/VcKsoeWBjNEV7kJ8=;
	b=Y0vqg8o/+/JbOnAy7svA98jCfAtDVcIrVWZGFjaXE8C4I+ZvMjDT7ao6pUJwf9KavZ6Cb3
	mTeY37WqnScNB/L0wHpY9X94kxAg1diT43U2uMqUOHp6BayROLRQkQ1+kcchJUMR8DjWoh
	NZW8S7ze1m4IRguBVr2+xmC8QnEPntA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761759969;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F0sZF9w7yuT5ed92au3G/YD+ry/VcKsoeWBjNEV7kJ8=;
	b=TIYQS9PUIs1pZ7o1xAwcHj1o6+c8sDTqcE6W5rRJKR3na5DMmv+8e3CbSDsSDrG1NVgc+0
	d/LL5SWPJt3P11Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KxFlbH0u;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PVXWs+Ih
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761759968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F0sZF9w7yuT5ed92au3G/YD+ry/VcKsoeWBjNEV7kJ8=;
	b=KxFlbH0uPFeacv9q3oLovNmzHznYMCZOPW1+LmEWFYVDf0X0f3EYn8DM6GB06jVj1YUsBS
	Y8SzKaSOGQtXlXdUBLA/Z/1jxVcbAU+ubbwGsC1VtE9ad1GmaRQH27JL/89Sxhg/PfMT4a
	l5z1AirgWqvhEZfVINX1UDLwSSN2hGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761759968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F0sZF9w7yuT5ed92au3G/YD+ry/VcKsoeWBjNEV7kJ8=;
	b=PVXWs+IhvehSNLG3C6mqLJFVOi0uWoPLEMmeFLIIr/HvNWban7eV+VWnNlMqp2VPVTz/ro
	LsRw6EJxaCP6oeAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA1A61349D;
	Wed, 29 Oct 2025 17:46:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RUQaLeBSAmkkdwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 29 Oct 2025 17:46:08 +0000
Message-ID: <8a8271f1-a695-4eeb-9a98-3d6268ed0d45@suse.cz>
Date: Wed, 29 Oct 2025 18:46:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/19] slab: make percpu sheaves compatible with
 kmalloc_nolock()/kfree_nolock()
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
 bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-7-6ffa2c9941c0@suse.cz>
 <CAADnVQLAFkYLLJbMjEyzEu=Q7aJSs19Ddb1qXqEWNnxm6=CDFg@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQLAFkYLLJbMjEyzEu=Q7aJSs19Ddb1qXqEWNnxm6=CDFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E93E85C054
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[gmail.com,meta.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,gentwo.org,google.com,linux.dev,oracle.com,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

On 10/24/25 21:43, Alexei Starovoitov wrote:
> On Thu, Oct 23, 2025 at 6:53 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> Before we enable percpu sheaves for kmalloc caches, we need to make sure
>> kmalloc_nolock() and kfree_nolock() will continue working properly and
>> not spin when not allowed to.
>>
>> Percpu sheaves themselves use local_trylock() so they are already
>> compatible. We just need to be careful with the barn->lock spin_lock.
>> Pass a new allow_spin parameter where necessary to use
>> spin_trylock_irqsave().
>>
>> In kmalloc_nolock_noprof() we can now attempt alloc_from_pcs() safely,
>> for now it will always fail until we enable sheaves for kmalloc caches
>> next. Similarly in kfree_nolock() we can attempt free_to_pcs().
>>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
...>> @@ -5720,6 +5735,13 @@ void *kmalloc_nolock_noprof(size_t size, gfp_t
gfp_flags, int node)
>>                  */
>>                 return NULL;
>>
>> +       ret = alloc_from_pcs(s, alloc_gfp, node);
>> +
> 
> I would remove the empty line here.

Ack.

>> @@ -6093,6 +6117,11 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>>                 return pcs;
>>         }
>>
>> +       if (!allow_spin) {
>> +               local_unlock(&s->cpu_sheaves->lock);
>> +               return NULL;
>> +       }
> 
> and would add a comment here to elaborate that the next
> steps like sheaf_flush_unused() and alloc_empty_sheaf()
> cannot handle !allow_spin.

Will do.
>> +
>>         if (PTR_ERR(empty) == -E2BIG) {
>>                 /* Since we got here, spare exists and is full */
>>                 struct slab_sheaf *to_flush = pcs->spare;
>> @@ -6160,7 +6189,7 @@ __pcs_replace_full_main(struct kmem_cache *s, struct slub_percpu_sheaves *pcs)
>>   * The object is expected to have passed slab_free_hook() already.
>>   */
>>  static __fastpath_inline
>> -bool free_to_pcs(struct kmem_cache *s, void *object)
>> +bool free_to_pcs(struct kmem_cache *s, void *object, bool allow_spin)
>>  {
>>         struct slub_percpu_sheaves *pcs;
>>
>> @@ -6171,7 +6200,7 @@ bool free_to_pcs(struct kmem_cache *s, void *object)
>>
>>         if (unlikely(pcs->main->size == s->sheaf_capacity)) {
>>
>> -               pcs = __pcs_replace_full_main(s, pcs);
>> +               pcs = __pcs_replace_full_main(s, pcs, allow_spin);
>>                 if (unlikely(!pcs))
>>                         return false;
>>         }
>> @@ -6278,7 +6307,7 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
>>                         goto fail;
>>                 }
>>
>> -               empty = barn_get_empty_sheaf(barn);
>> +               empty = barn_get_empty_sheaf(barn, true);
>>
>>                 if (empty) {
>>                         pcs->rcu_free = empty;
>> @@ -6398,7 +6427,7 @@ static void free_to_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>>                 goto no_empty;
>>
>>         if (!pcs->spare) {
>> -               empty = barn_get_empty_sheaf(barn);
>> +               empty = barn_get_empty_sheaf(barn, true);
> 
> I'm allergic to booleans in arguments. They make callsites
> hard to read. Especially if there are multiple bools.
> We have horrendous lines in the verifier that we still need
> to clean up due to bools:
> check_load_mem(env, insn, true, false, false, "atomic_load");
> 
> barn_get_empty_sheaf(barn, true); looks benign,
> but I would still use enum { DONT_SPIN, ALLOW_SPIN }
> and use that in all functions instead of 'bool allow_spin'.

I'll put it on the TODO list. But I think it's just following the pattern of
what you did in all the work leading to kmalloc_nolock() :)
And it's a single bool and for internal function with limited exposure, so
might be an overkill. Will see.

> Aside from that I got worried that sheaves fast path
> may be not optimized well by the compiler:
> if (unlikely(pcs->main->size == 0)) ...
> object = pcs->main->objects[pcs->main->size - 1];
> // object is accessed here

only by virt_to_folio() which takes a const void *x and is probably inlined
anyway...

> pcs->main->size--;
> 
> since object may alias into pcs->main and the compiler
> may be tempted to reload 'main'.

Interesting, it wouldn't have thought about the possibility.

> Looks like it's fine, since object point is not actually read or written.

Wonder if it figures that out or just assumes it would be an undefined
behavior (or would we need strict aliasing to allow the assumption?). But
good to know it looks ok, thanks!

> gcc15 asm looks good:
>         movq    8(%rbx), %rdx   # _68->main, _69
>         movl    24(%rdx), %eax  # _69->size, _70
> # ../mm/slub.c:5129:    if (unlikely(pcs->main->size == 0)) {
>         testl   %eax, %eax      # _70
>         je      .L2076  #,
> .L1953:
> # ../mm/slub.c:5135:    object = pcs->main->objects[pcs->main->size - 1];
>         leal    -1(%rax), %esi  #,
> # ../mm/slub.c:5135:    object = pcs->main->objects[pcs->main->size - 1];
>         movq    32(%rdx,%rsi,8), %rdi   # prephitmp_309->objects[_81], object
> # ../mm/slub.c:5135:    object = pcs->main->objects[pcs->main->size - 1];
>         movq    %rsi, %rax      #,
> # ../mm/slub.c:5137:    if (unlikely(node_requested)) {
>         testb   %r15b, %r15b    # node_requested
>         jne     .L2077  #,
> .L1954:
> # ../mm/slub.c:5149:    pcs->main->size--;
>         movl    %eax, 24(%rdx)  # _81, prephitmp_30->size


