Return-Path: <bpf+bounces-78680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A98A2D17BE3
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 10:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7D1130DCF86
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 09:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22B32E6BE;
	Tue, 13 Jan 2026 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dtSqIOQ1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GQDk8z3I";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dtSqIOQ1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GQDk8z3I"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4576C32ABC2
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296759; cv=none; b=T76cLcY/0JX9CrGFEiqzjdGIdrlS1DSG/u2EXENc+emj8ppnZM5npOUD2q+XNYRl/YWfgmaSdubTFqvF/5mnQM18Y0X0a+IBNs0jWjCC8bhA+6lnkqdzyhz9j/hB16Qn4wWnNzk3IO4U+lZ+zfqnXAPRuorfBwP38pwzQsfYwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296759; c=relaxed/simple;
	bh=wGnKQNo7Kd1KJYajajOdOMbpeDZoEUeNqQHYV983hdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gmqraR4Xr/+obuuCzbr3g+pfEE1vTYF1f3qc6i5t9aFjSat93P0nnL/fer98w/ktm2VfrG9euQcLWcF7snGvIr+rVjHqrdbkmkR5vLPDR+4TJkuH2Gm0jnKtX9wbd706TOFU3iBTLy4Pg3B33pjtmHBxFBjs9PcUKslDhbiK0cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dtSqIOQ1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GQDk8z3I; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dtSqIOQ1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GQDk8z3I; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6731E33681;
	Tue, 13 Jan 2026 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768296754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni5ivzvbOKwDsRa7XDDenum4lALdFzhgJFrmTN2UCmk=;
	b=dtSqIOQ12BXFfKLtxgnjE/IaYiF4HHlDVb+m/teg9el5HNuos1q1kN2uceNn4zyG+ZM9zH
	jVfITQTPzpixoGFHmI6PsmzrJG8c8eLzLkT5qkK7dsZxILJfyaCpSxs/JVgfoyamK38VQp
	CzEiIi9YoYsf2S/mzQyR9zRqEabUzL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768296754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni5ivzvbOKwDsRa7XDDenum4lALdFzhgJFrmTN2UCmk=;
	b=GQDk8z3IRzKEh01tOAKI4OZ8y3unBKOZ7Nul5hsedpFDFPgTb0fro1bEnhvJjhe4nC+2At
	+/x5zsDoxHIiuMDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768296754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni5ivzvbOKwDsRa7XDDenum4lALdFzhgJFrmTN2UCmk=;
	b=dtSqIOQ12BXFfKLtxgnjE/IaYiF4HHlDVb+m/teg9el5HNuos1q1kN2uceNn4zyG+ZM9zH
	jVfITQTPzpixoGFHmI6PsmzrJG8c8eLzLkT5qkK7dsZxILJfyaCpSxs/JVgfoyamK38VQp
	CzEiIi9YoYsf2S/mzQyR9zRqEabUzL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768296754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ni5ivzvbOKwDsRa7XDDenum4lALdFzhgJFrmTN2UCmk=;
	b=GQDk8z3IRzKEh01tOAKI4OZ8y3unBKOZ7Nul5hsedpFDFPgTb0fro1bEnhvJjhe4nC+2At
	+/x5zsDoxHIiuMDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E3843EA63;
	Tue, 13 Jan 2026 09:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Eh3mEjIRZmnYNgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 13 Jan 2026 09:32:34 +0000
Message-ID: <6e1f4acd-23f3-4a92-9212-65e11c9a7d1a@suse.cz>
Date: Tue, 13 Jan 2026 10:32:33 +0100
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
 <aWWpE-7R1eBF458i@hyeyoo>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <aWWpE-7R1eBF458i@hyeyoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,gentwo.org,google.com,linux.dev,linux-foundation.org,gmail.com,oracle.com,linutronix.de,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,googlegroups.com,intel.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO

On 1/13/26 3:08 AM, Harry Yoo wrote:
> On Mon, Jan 12, 2026 at 04:16:55PM +0100, Vlastimil Babka wrote:
>> After we submit the rcu_free sheaves to call_rcu() we need to make sure
>> the rcu callbacks complete. kvfree_rcu_barrier() does that via
>> flush_all_rcu_sheaves() but kvfree_rcu_barrier_on_cache() doesn't. Fix
>> that.
> 
> Oops, my bad.
> 
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202601121442.c530bed3-lkp@intel.com
>> Fixes: 0f35040de593 ("mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
> 
> The fix looks good to me, but I wonder why
> `if (s->sheaf_capacity) rcu_barrier();` in __kmem_cache_shutdown()
> didn't prevent the bug from happening?

Hmm good point, didn't notice it's there.

I think it doesn't help because it happens only after
flush_all_cpus_locked(). And the callback from rcu_free_sheaf_nobarn()
will do sheaf_flush_unused() and end up installing the cpu slab again.

Because the bot flagged commit "slab: add sheaves to most caches" where
cpu slabs still exist. It's thus possible that with the full series, the
bug is gone. But we should prevent it upfront anyway. The rcu_barrier()
in __kmem_cache_shutdown() however is probably unnecessary then and we
can remove it, right?

>>  mm/slab_common.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index eed7ea556cb1..ee994ec7f251 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -2133,8 +2133,11 @@ EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
>>   */
>>  void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
>>  {
>> -	if (s->cpu_sheaves)
>> +	if (s->cpu_sheaves) {
>>  		flush_rcu_sheaves_on_cache(s);
>> +		rcu_barrier();
>> +	}
>> +
>>  	/*
>>  	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
>>  	 * on a specific slab cache.
>>
>> -- 
>> 2.52.0
>>
> 


