Return-Path: <bpf+bounces-48947-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD2CA1282A
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394E0162E27
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 16:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96D5158D6A;
	Wed, 15 Jan 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FkhRtmfD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ElpQlc1q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FkhRtmfD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ElpQlc1q"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C0137930
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 16:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736957232; cv=none; b=uCL05A4HOsPz0uTeg7C5182c2gubJqB9L1QdaA5/SlhvncffPIGFFhdAF5rxDzYOFVq79QblxFTWnC/Hu6J9aWF+HIar0nnIjlqDbGp7aMQCxWjdpUrkutVr7Z1y4r1u1VyQd0oCb4pS/Lr+rAQ6GbIWiCYgIsYq/fO5jS6GTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736957232; c=relaxed/simple;
	bh=sPEbg1SVgphitNBLlMpBjNvdSoAD4msExZ9OsMyrL4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlNt6IpmILuTFYgCXUrYBrcQkYJNhBE0qyxCuTp7M30c92hAOvwiMN01Fsi0mOad4vxEkTlMBkHNCU6Xw5YpBP6OKmGA6VWMUFTJ0Cf7uQAmvk3ITv0rcOkAAMGErK7bootD9UCEpyReP+uPAubA25hVREAhmHOFowUmCFNJFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FkhRtmfD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ElpQlc1q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FkhRtmfD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ElpQlc1q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 123FD1F37E;
	Wed, 15 Jan 2025 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736957228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hmU+95/9z4T3UaikbntFDllWaA4dWGGxS520IW14Ps8=;
	b=FkhRtmfDAcTdrzYN3J4wGkKgpWvNAcBBNZpW2V7ZrQEHnXrfHPhZAc0gJL7cCJiG6MiT1e
	GQQGF2LU4uHXLwHuYpsK4EFSmbKLpr5H6QTv15BUZy8qpoNbQc7+PXAnWhgX9cZJKI3Ed9
	X0zrm7MdL+aHbnKOCo9jkQlPgYV3JSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736957228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hmU+95/9z4T3UaikbntFDllWaA4dWGGxS520IW14Ps8=;
	b=ElpQlc1qsJj9l1LZ9CO4WUZzEji9wJjosgVhikDvzRDb56zrLGnOChLg6wToVw62mymB9o
	VQneoseNEgVR+4DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FkhRtmfD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ElpQlc1q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736957228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hmU+95/9z4T3UaikbntFDllWaA4dWGGxS520IW14Ps8=;
	b=FkhRtmfDAcTdrzYN3J4wGkKgpWvNAcBBNZpW2V7ZrQEHnXrfHPhZAc0gJL7cCJiG6MiT1e
	GQQGF2LU4uHXLwHuYpsK4EFSmbKLpr5H6QTv15BUZy8qpoNbQc7+PXAnWhgX9cZJKI3Ed9
	X0zrm7MdL+aHbnKOCo9jkQlPgYV3JSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736957228;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hmU+95/9z4T3UaikbntFDllWaA4dWGGxS520IW14Ps8=;
	b=ElpQlc1qsJj9l1LZ9CO4WUZzEji9wJjosgVhikDvzRDb56zrLGnOChLg6wToVw62mymB9o
	VQneoseNEgVR+4DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB8C1139CB;
	Wed, 15 Jan 2025 16:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zpKyNCvdh2fPFQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Jan 2025 16:07:07 +0000
Message-ID: <0676a504-43dc-42a4-a215-040470539cb0@suse.cz>
Date: Wed, 15 Jan 2025 17:07:07 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 4/7] memcg: Use trylock to access memcg
 stock_lock.
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, jannh@google.com,
 tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-5-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250115021746.34691-5-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 123FD1F37E
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 1/15/25 03:17, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Teach memcg to operate under trylock conditions when spinning locks
> cannot be used.
> 
> local_trylock might fail and this would lead to charge cache bypass if
> the calling context doesn't allow spinning (gfpflags_allow_spinning).
> In those cases charge the memcg counter directly and fail early if
> that is not possible. This might cause a pre-mature charge failing
> but it will allow an opportunistic charging that is safe from
> try_alloc_pages path.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memcontrol.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 7b3503d12aaf..e4c7049465e0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1756,7 +1756,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>   *
>   * returns true if successful, false otherwise.
>   */
> -static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> +static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> +			  gfp_t gfp_mask)
>  {
>  	struct memcg_stock_pcp *stock;
>  	unsigned int stock_pages;
> @@ -1766,7 +1767,11 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	if (nr_pages > MEMCG_CHARGE_BATCH)
>  		return ret;
>  
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +		if (!gfpflags_allow_spinning(gfp_mask))
> +			return ret;
> +		local_lock_irqsave(&memcg_stock.stock_lock, flags);

The last line can practially only happen on RT, right? On non-RT irqsave
means we could only fail the trylock from a nmi and then we should have
gfp_flags that don't allow spinning.

So suppose we used local_trylock(), local_lock() and local_unlock()  (no
_irqsave) instead, as I mentioned in reply to 3/7. The RT implementation
would be AFAICS the same. On !RT the trylock could now fail from a IRQ
context in addition to NMI context, but that should also have a gfp_mask
that does not allow spinning, so it should work fine.

It would however mean converting all users of the lock, i.e. also
consume_obj_stock() etc., but AFAIU that will be necessary anyway to have
opportunistic slab allocations?

> +	}
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	stock_pages = READ_ONCE(stock->nr_pages);
> @@ -1851,7 +1856,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	unsigned long flags;
>  
> -	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> +		/*
> +		 * In case of unlikely failure to lock percpu stock_lock
> +		 * uncharge memcg directly.
> +		 */
> +		mem_cgroup_cancel_charge(memcg, nr_pages);
> +		return;
> +	}
>  	__refill_stock(memcg, nr_pages);
>  	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>  }
> @@ -2196,9 +2208,13 @@ int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	unsigned long pflags;
>  
>  retry:
> -	if (consume_stock(memcg, nr_pages))
> +	if (consume_stock(memcg, nr_pages, gfp_mask))
>  		return 0;
>  
> +	if (!gfpflags_allow_spinning(gfp_mask))
> +		/* Avoid the refill and flush of the older stock */
> +		batch = nr_pages;
> +
>  	if (!do_memsw_account() ||
>  	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
>  		if (page_counter_try_charge(&memcg->memory, batch, &counter))


