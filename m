Return-Path: <bpf+bounces-72919-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FE3C1D975
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 23:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAC3D1888F14
	for <lists+bpf@lfdr.de>; Wed, 29 Oct 2025 22:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0C1D5147;
	Wed, 29 Oct 2025 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z3Ch5U8f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9EvsHW0P";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z3Ch5U8f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9EvsHW0P"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359F288A2
	for <bpf@vger.kernel.org>; Wed, 29 Oct 2025 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761777094; cv=none; b=ISFB2fAXK8LKANroHN/PuTTDE4bWbC7KIhKpsnzCtC/LDWMlhRiNZJKVMBC9ph7+JsP/bOV+poUieENaODyKa5IZ1ZQXdx4sjVS3TgWdfHnKTbvFta7R9Qafpphp6ZYmWwqeChGQJJJTnbjpnLtdckZ2y+po4Dn+f9nV21HKII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761777094; c=relaxed/simple;
	bh=oj/w8wQkt1UwF10EvLBb+trXn3Vz/AxZu5KQCBe6w7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHjOusz3geTA3AEtR5gMpwTUrZLuTSqtDjYHFao99IhCFXHKtIda63XRvqauIqXit/8mMd8ewGsLSDcJL8MwCfb1+OWJW0GefGExcSjA5ZHjp/P38OpVwf7u9YDN20Pwj27bIeChmbLnn+KwsuMH54dxKOqZsSlkdnwDv6aLfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z3Ch5U8f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9EvsHW0P; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z3Ch5U8f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9EvsHW0P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8EDBB5CB0F;
	Wed, 29 Oct 2025 22:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761777090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dh8+yU8fmyt+6MD4ipOXHynaGNBJYzYXvAUebA2Mox0=;
	b=z3Ch5U8fPmN90eBEJ2w+yjBdJEK6r5CXo7K3SpBXvOMynjVUjuEDfDORPVez0hsrXt04uZ
	8oRPfCDQghzdvHof3qUFE4VCLD8RRr1ET2ucb4/cHqFUI6Bk7DrX+l2SU9u8fwYySX8AM/
	wBMU9bC4H/bmsID1qVF38PdpQkaynus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761777090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dh8+yU8fmyt+6MD4ipOXHynaGNBJYzYXvAUebA2Mox0=;
	b=9EvsHW0PpZFX3GjwUziMQJFfTwUcvegUJ6rn0nKLe9sVgEvkK5VQaoWbD3NqMBVRvheI14
	CHp/XTgKyL+6CHDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761777090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dh8+yU8fmyt+6MD4ipOXHynaGNBJYzYXvAUebA2Mox0=;
	b=z3Ch5U8fPmN90eBEJ2w+yjBdJEK6r5CXo7K3SpBXvOMynjVUjuEDfDORPVez0hsrXt04uZ
	8oRPfCDQghzdvHof3qUFE4VCLD8RRr1ET2ucb4/cHqFUI6Bk7DrX+l2SU9u8fwYySX8AM/
	wBMU9bC4H/bmsID1qVF38PdpQkaynus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761777090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dh8+yU8fmyt+6MD4ipOXHynaGNBJYzYXvAUebA2Mox0=;
	b=9EvsHW0PpZFX3GjwUziMQJFfTwUcvegUJ6rn0nKLe9sVgEvkK5VQaoWbD3NqMBVRvheI14
	CHp/XTgKyL+6CHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D7111349D;
	Wed, 29 Oct 2025 22:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yRNXGsKVAmluCAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 29 Oct 2025 22:31:30 +0000
Message-ID: <df8b155e-388d-4c62-8643-289052f2fc5e@suse.cz>
Date: Wed, 29 Oct 2025 23:31:30 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/19] slab: remove SLUB_CPU_PARTIAL
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <20251023-sheaves-for-all-v1-11-6ffa2c9941c0@suse.cz>
 <CAADnVQKBPF8g3JgbCrcGFx35Bujmta2vnJGM9pgpcLq1-wqLHg@mail.gmail.com>
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
In-Reply-To: <CAADnVQKBPF8g3JgbCrcGFx35Bujmta2vnJGM9pgpcLq1-wqLHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,gentwo.org,google.com,linux.dev,oracle.com,gmail.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

On 10/24/25 22:43, Alexei Starovoitov wrote:
> On Thu, Oct 23, 2025 at 6:53 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>>  static bool has_pcs_used(int cpu, struct kmem_cache *s)
>> @@ -5599,21 +5429,18 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>>                 new.inuse -= cnt;
>>                 if ((!new.inuse || !prior) && !was_frozen) {

This line says "if slab is either becoming completely free (1), or becoming
partially free from being full (2)", and at the same time is not frozen (=
exclusively used as a c->slab by a cpu), we might need to take it off the
partial list (1) or add it there (2).

>>                         /* Needs to be taken off a list */
>> -                       if (!kmem_cache_has_cpu_partial(s) || prior) {

This line is best explained as a negation. If we have cpu partial lists, and
the slab was full and becoming partially free (case (2)) we will put it on
the cpu partial list, so we will avoid the node partial list and thus don't
need the list_lock. But that's the negation, so if the opposite is true, we
do need it.

And since we're removing the cpu partial lists, we can't put it there even
in case (2) so there's no point in testing for it.
> I'm struggling to convince myself that it's correct.

It should be per above.

> Losing '|| prior' means that we will be grabbing
> this "speculative" spin_lock much more often.
> While before the change we need spin_lock only when
> slab was partially empty
> (assuming cpu_partial was on for caches where performance matters).

That's true. But still, it should happen rarely that slab transitions from
full to partial, it's only on the first free after it became full. Sheaves
should make this rare and prevent degenerate corner case scenarios (slab
oscillating between partial and full with every free/alloc). AFAIK the main
benefit of partial slabs was the batching of taking slabs out from node
partial list under single list_lock and that principle remains with "slab:
add optimized sheaf refill from partial list". This avoidance of list_lock
in slab transitions from full to partial was a nice secondary benefit, but
not crucial.

But yeah, the TODOs about meaningful stats gathering and benchmarking should
answer that concern.

> Also what about later check:
> if (prior && !on_node_partial) {
>        spin_unlock_irqrestore(&n->list_lock, flags);
>        return;
> }

That's unaffected. It's actually for case (1), but we found it wasn't on the
list so we are not removing it. But we had to take the list_lock to
determine on_node_partial safely.

> and
> if (unlikely(!prior)) {
>                 add_partial(n, slab, DEACTIVATE_TO_TAIL);

This is for case (2) and we re adding it.

> Say, new.inuse == 0 then 'n' will be set,

That's case (1) so it was already on the partial list. We might just leave
it there with n->nr_partial < s->min_partial otherwise we goto slab_empty,
where it's removed and discarded.

> do we lose the slab?
> Because before the change it would be added to put_cpu_partial() ?

No, see above. Also the code already handled !kmem_cache_has_cpu_partial(s)
before. This patch simply assumes !kmem_cache_has_cpu_partial(s) is now
always true. You can see in __slab_free() it in fact only removes code that
became dead due to kmem_cache_has_cpu_partial(s) being now compile-time
constant false.

> but... since AI didn't find any bugs here, I must be wrong :)
It's tricky. I think we could add a "bool was_partial == (prior != NULL)" or
something to make it more obvious, that one is rather cryptic.

