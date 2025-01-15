Return-Path: <bpf+bounces-48963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A4A12A50
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7169F3A1B53
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55521D54E3;
	Wed, 15 Jan 2025 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LFxQk8/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mfBd7l74";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LFxQk8/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mfBd7l74"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BFA1C4A1C
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736963831; cv=none; b=c/RYBD/7Pz3zOlT4Db/zIN5pFXXbrvXM8IMO/51nRIzPstv3jPLEpl1jJcHeD0d6J4s/JgfcKe1xu+2l/vvdvvXTGSN0rYFzdliAfWEYuawnPXzQxImKJi0ZRiuya3bkgTk/Ie/yuABBZSX08c/L0pgOaBJEjde0PlKv1plje3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736963831; c=relaxed/simple;
	bh=jGJDy/gqkmjVG+xVK6zF5tQa3uIElMyy5p/cLFKWtrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n94JocrB4DdBbnDTQElJuQDP99dKRYxFKlyD8wbJGdTz+nfm+igRFH7HXvetInuvMA5OJptIOjY8PnRHkMuRD/htkuBT8gJ/GcSCY8cXjDrCZNEWpj8sJlThJoNBQy2+YrOECmHkaqoKf5pecQtpsPIsoOF0ZrcflYiixtcLw7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LFxQk8/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mfBd7l74; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LFxQk8/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mfBd7l74; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 626E72126E;
	Wed, 15 Jan 2025 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736963827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mc6uxk6pPNlAf41llYQZ/AzLyIVmhipT0WpZnq8OtNo=;
	b=LFxQk8/yhA774VrYp+IGu8H/1SGRrvyQX6Vv3PCiAH30Nhdw93TBWxevhJTKn4KXSgyLa9
	q1i9FkDIfUIptR16KJqStoob1Ni2IHjCLeLwN6xTT13HakQQz/PnEQRX1dpj60JAA7rqab
	ukUF6D8mx7Dp32TL9GUPlOWKAIJoJn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736963827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mc6uxk6pPNlAf41llYQZ/AzLyIVmhipT0WpZnq8OtNo=;
	b=mfBd7l743ocj8YxndrUc3hisFx+6vXjSvoLjmsf4HdrwhyaGnHFTdFxUGYsQGy/xbVzQ0m
	aBe16kEItuFBRmDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="LFxQk8/y";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mfBd7l74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736963827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mc6uxk6pPNlAf41llYQZ/AzLyIVmhipT0WpZnq8OtNo=;
	b=LFxQk8/yhA774VrYp+IGu8H/1SGRrvyQX6Vv3PCiAH30Nhdw93TBWxevhJTKn4KXSgyLa9
	q1i9FkDIfUIptR16KJqStoob1Ni2IHjCLeLwN6xTT13HakQQz/PnEQRX1dpj60JAA7rqab
	ukUF6D8mx7Dp32TL9GUPlOWKAIJoJn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736963827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mc6uxk6pPNlAf41llYQZ/AzLyIVmhipT0WpZnq8OtNo=;
	b=mfBd7l743ocj8YxndrUc3hisFx+6vXjSvoLjmsf4HdrwhyaGnHFTdFxUGYsQGy/xbVzQ0m
	aBe16kEItuFBRmDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E795139CB;
	Wed, 15 Jan 2025 17:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yvH7CvP2h2cqNwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 15 Jan 2025 17:57:07 +0000
Message-ID: <422f3667-5048-4274-8aa5-e9ff19b6221e@suse.cz>
Date: Wed, 15 Jan 2025 18:57:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 6/7] mm: Make failslab, kfence, kmemleak aware
 of trylock mode
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, jannh@google.com,
 tj@kernel.org, linux-mm@kvack.org, kernel-team@fb.com
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-7-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20250115021746.34691-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 626E72126E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,google.com,kvack.org,fb.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 1/15/25 03:17, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> When gfpflags_allow_spinning() == false spin_locks cannot be taken.
> Make failslab, kfence, kmemleak compliant.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

All these are related to slab, so this would rather belong to a followup
series that expands the support from page allocator to slab, no?

> ---
>  mm/failslab.c    | 3 +++
>  mm/kfence/core.c | 4 ++++
>  mm/kmemleak.c    | 3 +++
>  3 files changed, 10 insertions(+)
> 
> diff --git a/mm/failslab.c b/mm/failslab.c
> index c3901b136498..86c7304ef25a 100644
> --- a/mm/failslab.c
> +++ b/mm/failslab.c
> @@ -27,6 +27,9 @@ int should_failslab(struct kmem_cache *s, gfp_t gfpflags)
>  	if (gfpflags & __GFP_NOFAIL)
>  		return 0;
>  
> +	if (!gfpflags_allow_spinning(gfpflags))
> +		return 0;
> +
>  	if (failslab.ignore_gfp_reclaim &&
>  			(gfpflags & __GFP_DIRECT_RECLAIM))
>  		return 0;
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 67fc321db79b..e5f2d63f3220 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -1096,6 +1096,10 @@ void *__kfence_alloc(struct kmem_cache *s, size_t size, gfp_t flags)
>  	if (s->flags & SLAB_SKIP_KFENCE)
>  		return NULL;
>  
> +	/* Bailout, since kfence_guarded_alloc() needs to take a lock */
> +	if (!gfpflags_allow_spinning(flags))
> +		return NULL;
> +
>  	allocation_gate = atomic_inc_return(&kfence_allocation_gate);
>  	if (allocation_gate > 1)
>  		return NULL;
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 2a945c07ae99..64cb44948e9e 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -648,6 +648,9 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
>  {
>  	struct kmemleak_object *object;
>  
> +	if (!gfpflags_allow_spinning(gfp))
> +		return NULL;
> +
>  	object = mem_pool_alloc(gfp);
>  	if (!object) {
>  		pr_warn("Cannot allocate a kmemleak_object structure\n");


