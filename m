Return-Path: <bpf+bounces-73041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C9C20FB2
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5D81A62A4B
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A38F6F;
	Thu, 30 Oct 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rOatV9nf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="obGKZULd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rOatV9nf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="obGKZULd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92612359F86
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761838556; cv=none; b=UKXhcuP+ntTuMnrCBxGQv2kxjaZWjsLOqeA6LWxyktW9eKGKjwCZwOg4GyHg9vUG3Beygcxi1KVZb4jcZ3yI60ZY2tBq/IynGJr6GrpRmxQOQhvwE9KHDYiVHlcA7jATp84YqehGkeNT7B/JvDl69J34IgJQeS1dubrUGHLqvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761838556; c=relaxed/simple;
	bh=AUqApvHZq4K4INSRdUqm+NUmDDtD2RAZXj//JZQ6gT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/sinuGdSG1qxKG/3zalKu4zraeWR3BD5rNG21ZrzrfMUWA7qs7RNizlTH0bPZJiMBL9wdrzrrx1T3vjtV0nf4uN6HVdxEbVfGyMRT/8/+o+igmcqglW9qEohCbvR9rruHqt6rqs/asghrp+Pv3riE7xphLwzkqYLB4ZrHYHuiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rOatV9nf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=obGKZULd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rOatV9nf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=obGKZULd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A1F371FB3E;
	Thu, 30 Oct 2025 15:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761838552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2ZC7sKtccy7Dxtp0h0EbRBUPlnYDttAcegCDflOn07Q=;
	b=rOatV9nfOZQSA5IRCufIJN1wpSAvq2vgza5Cm+5hfuEbo4Be4MEOYpbRoemqqL8ezSThUX
	Y9Ocl0IO5Dq9S/OEGRJzZhtKB0TEA/5xo4A5Ex17TP9a/Ss4VmnBY909cQQfzgOrkeFaN8
	ZD4KDzvkMPF5V4bOdJ+KmDW+dycNKds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761838552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2ZC7sKtccy7Dxtp0h0EbRBUPlnYDttAcegCDflOn07Q=;
	b=obGKZULdFaEWL5nV2PhgzMCw8NuMFbTPrAZ5d4OlErKEObyjj8b19pe169SOCKWX4R/MF+
	22hAZCSCk7om11CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761838552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2ZC7sKtccy7Dxtp0h0EbRBUPlnYDttAcegCDflOn07Q=;
	b=rOatV9nfOZQSA5IRCufIJN1wpSAvq2vgza5Cm+5hfuEbo4Be4MEOYpbRoemqqL8ezSThUX
	Y9Ocl0IO5Dq9S/OEGRJzZhtKB0TEA/5xo4A5Ex17TP9a/Ss4VmnBY909cQQfzgOrkeFaN8
	ZD4KDzvkMPF5V4bOdJ+KmDW+dycNKds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761838552;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2ZC7sKtccy7Dxtp0h0EbRBUPlnYDttAcegCDflOn07Q=;
	b=obGKZULdFaEWL5nV2PhgzMCw8NuMFbTPrAZ5d4OlErKEObyjj8b19pe169SOCKWX4R/MF+
	22hAZCSCk7om11CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73D221396A;
	Thu, 30 Oct 2025 15:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +AqSG9iFA2n+YwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 30 Oct 2025 15:35:52 +0000
Message-ID: <5e8e6e92-ba8f-4fee-bd01-39aacdd30dbe@suse.cz>
Date: Thu, 30 Oct 2025 16:35:52 +0100
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
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Harry Yoo <harry.yoo@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexei Starovoitov <ast@kernel.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
 bpf <bpf@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
References: <20251023-sheaves-for-all-v1-0-6ffa2c9941c0@suse.cz>
 <20251023-sheaves-for-all-v1-10-6ffa2c9941c0@suse.cz>
 <aQLqZjjq1SPD3Fml@hyeyoo> <06241684-e056-40bd-88cc-0eb2d9d062bd@suse.cz>
 <CAADnVQ+K-gWm6KKzKZ0vVwfT2H1UXSoaD=eA1aRUHpA5MCLAvA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <CAADnVQ+K-gWm6KKzKZ0vVwfT2H1UXSoaD=eA1aRUHpA5MCLAvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,gentwo.org,google.com,linux.dev,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On 10/30/25 16:27, Alexei Starovoitov wrote:
> On Thu, Oct 30, 2025 at 6:09 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 10/30/25 05:32, Harry Yoo wrote:
>> > On Thu, Oct 23, 2025 at 03:52:32PM +0200, Vlastimil Babka wrote:
>> >> diff --git a/mm/slub.c b/mm/slub.c
>> >> index e2b052657d11..bd67336e7c1f 100644
>> >> --- a/mm/slub.c
>> >> +++ b/mm/slub.c
>> >> @@ -4790,66 +4509,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>> >>
>> >>      stat(s, ALLOC_SLAB);
>> >>
>> >> -    if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>> >> -            freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
>> >> -
>> >> -            if (unlikely(!freelist))
>> >> -                    goto new_objects;
>> >> -
>> >> -            if (s->flags & SLAB_STORE_USER)
>> >> -                    set_track(s, freelist, TRACK_ALLOC, addr,
>> >> -                              gfpflags & ~(__GFP_DIRECT_RECLAIM));
>> >> -
>> >> -            return freelist;
>> >> -    }
>> >> -
>> >> -    /*
>> >> -     * No other reference to the slab yet so we can
>> >> -     * muck around with it freely without cmpxchg
>> >> -     */
>> >> -    freelist = slab->freelist;
>> >> -    slab->freelist = NULL;
>> >> -    slab->inuse = slab->objects;
>> >> -    slab->frozen = 1;
>> >> -
>> >> -    inc_slabs_node(s, slab_nid(slab), slab->objects);
>> >> +    freelist = alloc_single_from_new_slab(s, slab, orig_size, gfpflags);
>> >>
>> >> -    if (unlikely(!pfmemalloc_match(slab, gfpflags) && allow_spin)) {
>> >> -            /*
>> >> -             * For !pfmemalloc_match() case we don't load freelist so that
>> >> -             * we don't make further mismatched allocations easier.
>> >> -             */
>> >> -            deactivate_slab(s, slab, get_freepointer(s, freelist));
>> >> -            return freelist;
>> >> -    }
>> >> +    if (unlikely(!freelist))
>> >> +            goto new_objects;
>> >
>> > We may end up in an endless loop in !allow_spin case?
>> > (e.g., kmalloc_nolock() is called in NMI context and n->list_lock is
>> > held in the process context on the same CPU)
>> >
>> > Allocate a new slab, but somebody is holding n->list_lock, so trylock fails,
>> > free the slab, goto new_objects, and repeat.
>>
>> Ugh, yeah. However, AFAICS this possibility already exists prior to this
>> patch, only it's limited to SLUB_TINY/kmem_cache_debug(s). But we should fix
>> it in 6.18 then.
>> How? Grab the single object and defer deactivation of the slab minus one
>> object? Would work except for kmem_cache_debug(s) we open again a race for
>> inconsistency check failure, and we have to undo the simple slab freeing fix
>>  and handle the accounting issue differently again.
>> Fail the allocation for the debug case to avoid the consistency check
>> issues? Would it be acceptable for kmalloc_nolock() users?
> 
> You mean something like:
> diff --git a/mm/slub.c b/mm/slub.c
> index a8fcc7e6f25a..e9a8b75f31d7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4658,8 +4658,11 @@ static void *___slab_alloc(struct kmem_cache
> *s, gfp_t gfpflags, int node,
>         if (kmem_cache_debug(s)) {
>                 freelist = alloc_single_from_new_slab(s, slab,
> orig_size, gfpflags);
> 
> -               if (unlikely(!freelist))
> +               if (unlikely(!freelist)) {
> +                       if (!allow_spin)
> +                               return NULL;
>                         goto new_objects;
> +               }
> 
> or I misunderstood the issue?

Yeah that would be the easiest solution, if you can accept the occasional
allocation failures.

