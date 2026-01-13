Return-Path: <bpf+bounces-78712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6B6D19078
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 14:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D48730090FA
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77F38FF13;
	Tue, 13 Jan 2026 13:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="he4nxkmu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9INIt8ZC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L3MVY4Fs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CU/L/Y80"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFE338FEFE
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768309779; cv=none; b=cNwW8zrRWbQ6f0rt3g52wYOTmviXrBvd5zyRzQooOHWqw3Zycf5I7VsQlS+y+mm+UR5tg9aBm/l1fuVsxdX2EWEy7yHpLkANgiPqAlKhwELSgZnyrJQu/WUiDuUU0av8ubImuaiEp/OuewqpoVrdonnQVBl7PDrQK4zHUxkz50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768309779; c=relaxed/simple;
	bh=94B8HF31RDRqM7tsDLCR4LF97xjNHTyMaCD+pdLqxaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=okL2qhiu4tTZMNkK7RkrZiLBZ4rK/KfQaFnhNC7sddUlK395qXQd+vgcxz9ykoW9PaA/D4OKOT5vlPkmqChZ10JN/GJRdn4I6FqDvsaCYA81dy5R1szS19M1cSca9nGBi8SylU/KZ5RlPY6wyxVpEt5jN+KTLSFq0aIg7z6xXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=he4nxkmu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9INIt8ZC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L3MVY4Fs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CU/L/Y80; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 996545BCCA;
	Tue, 13 Jan 2026 13:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768309775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIiny1vZ64O9oq3h+HMX+5IRUmdaD2DDrx5wZTHdXc0=;
	b=he4nxkmuWzN3/gfcDTtA+t3171gX7bx0foMZ8v6sFWmZixWVb542bQR/KZBnnLuyWBAIoj
	jE4vl7WFHp68g/VnDLVE/nacid69kbxFE1zb3V8RiA0RLSEA5y+FFojh23GAJhLX3kScl3
	/91qUVCiRqP4PNXe4yNjPmID429nq+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768309775;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIiny1vZ64O9oq3h+HMX+5IRUmdaD2DDrx5wZTHdXc0=;
	b=9INIt8ZC3kSlnuKdcRwKXXOeBbxYJ7TiVqdo7RD4yLmvmHdrEJQy2+StaVxMJ8SzHrXnxn
	fTf3kY8poQ6VGRAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=L3MVY4Fs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="CU/L/Y80"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768309774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIiny1vZ64O9oq3h+HMX+5IRUmdaD2DDrx5wZTHdXc0=;
	b=L3MVY4FsJrsDayEdRdXo/FC3Sc4zfufICzKTedm6Iml0u2C7jyuY9oQ0WfMwrIRJgl834+
	dhdgMrwskzQlNc5CneYWf34trey6UZqhgALCwvZPV7n9I/leLQH19yNz/55UwdVJXoDB5R
	eYkkzQId5poZaDgPvzJi7UTer5SEJQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768309774;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIiny1vZ64O9oq3h+HMX+5IRUmdaD2DDrx5wZTHdXc0=;
	b=CU/L/Y80jO8HWUI1QyzcAd6MMuC7un332e7lvk8MquLzhV5MRFzu4l0yah7Yv8c15MbIw0
	lYwGyulI8XablpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 854E33EA63;
	Tue, 13 Jan 2026 13:09:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5ldRIA5EZmklfQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Jan 2026 13:09:34 +0000
Message-ID: <342a2a8f-43ee-4eff-a062-6d325faa8899@suse.cz>
Date: Tue, 13 Jan 2026 14:09:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/20] mm/slab: add rcu_barrier() to
 kvfree_rcu_barrier_on_cache()
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
 bpf@vger.kernel.org, kasan-dev@googlegroups.com,
 kernel test robot <oliver.sang@intel.com>, stable@vger.kernel.org
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-1-98225cfb50cf@suse.cz>
 <aWWpE-7R1eBF458i@hyeyoo> <6e1f4acd-23f3-4a92-9212-65e11c9a7d1a@suse.cz>
 <aWY7K0SmNsW1O3mv@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <aWY7K0SmNsW1O3mv@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,oracle.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 996545BCCA
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On 1/13/26 1:31 PM, Harry Yoo wrote:
> On Tue, Jan 13, 2026 at 10:32:33AM +0100, Vlastimil Babka wrote:
>> On 1/13/26 3:08 AM, Harry Yoo wrote:
>>> On Mon, Jan 12, 2026 at 04:16:55PM +0100, Vlastimil Babka wrote:
>>>> After we submit the rcu_free sheaves to call_rcu() we need to make sure
>>>> the rcu callbacks complete. kvfree_rcu_barrier() does that via
>>>> flush_all_rcu_sheaves() but kvfree_rcu_barrier_on_cache() doesn't. Fix
>>>> that.
>>>
>>> Oops, my bad.
>>>
>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>> Closes: https://lore.kernel.org/oe-lkp/202601121442.c530bed3-lkp@intel.com
>>>> Fixes: 0f35040de593 ("mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>>> ---
>>>
>>> The fix looks good to me, but I wonder why
>>> `if (s->sheaf_capacity) rcu_barrier();` in __kmem_cache_shutdown()
>>> didn't prevent the bug from happening?
>>
>> Hmm good point, didn't notice it's there.
>>
>> I think it doesn't help because it happens only after
>> flush_all_cpus_locked(). And the callback from rcu_free_sheaf_nobarn()
>> will do sheaf_flush_unused() and end up installing the cpu slab again.
> 
> I thought about it a little bit more...
> 
> It's not because a cpu slab was installed again (for list_slab_objects()
> to be called on a slab, it must be on n->partial list), but because

Hmm that's true.

> flush_slab() cannot handle concurrent frees to the cpu slab.
> 
> CPU X                                CPU Y
> 
> - flush_slab() reads
>   c->freelist
>                                      rcu_free_sheaf_nobarn()
> 				     ->sheaf_flush_unused()
> 				     ->__kmem_cache_free_bulk()
> 				     ->do_slab_free()
> 				       -> sees slab == c->slab
> 				       -> frees to c->freelist
> - c->slab = NULL,
>   c->freelist = NULL
> - call deactivate_slab()
>   ^ the object freed by sheaf_flush_unused() is leaked,
>     thus slab->inuse != 0

But for this to be the same "c" it has to be the same cpu, not different
X and Y, no?
And that case is protected I think, the action by X with
local_lock_irqsave() prevents an irq handler to execute Y. Action Y is
using __update_cpu_freelist_fast to find out it was interrupted by X
messing with c-> fields.


> That said, flush_slab() works fine only when it is guaranteed that
> there will be no concurrent frees to the cpu slab (acquiring local_lock
> in flush_slab() doesn't help because free fastpath doesn't take it)
> 
> calling rcu_barrier() before flush_all_cpus_locked() ensures
> there will be no concurrent frees.
> 
> A side question; I'm not sure how __kmem_cache_shrink(),
> validate_slab_cache(), cpu_partial_store() are supposed to work
> correctly? They call flush_all() without guaranteeing there will be
> no concurrent frees to the cpu slab.
> 
> ...probably doesn't matter after sheaves-for-all :)
> 
>> Because the bot flagged commit "slab: add sheaves to most caches" where
>> cpu slabs still exist. It's thus possible that with the full series, the
>> bug is gone. But we should prevent it upfront anyway.
> 
>> The rcu_barrier() in __kmem_cache_shutdown() however is probably
>> unnecessary then and we can remove it, right?
> 
> Agreed. As it's called (after flushing rcu sheaves) in
> kvfree_rcu_barrier_on_cache(), it's not necessary in
> __kmem_cache_shutdown().
> 
>>>>  mm/slab_common.c | 5 ++++-
>>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>>>> index eed7ea556cb1..ee994ec7f251 100644
>>>> --- a/mm/slab_common.c
>>>> +++ b/mm/slab_common.c
>>>> @@ -2133,8 +2133,11 @@ EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>>>>   */
>>>>  void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>>>>  {
>>>> -	if (s->cpu_sheaves)
>>>> +	if (s->cpu_sheaves) {
>>>>  		flush_rcu_sheaves_on_cache(s);
>>>> +		rcu_barrier();
>>>> +	}
>>>> +
>>>>  	/*
>>>>  	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
>>>>  	 * on a specific slab cache.
> 


