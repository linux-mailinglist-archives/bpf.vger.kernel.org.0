Return-Path: <bpf+bounces-57499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A926AABDED
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 10:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 257EB1C23D06
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05048256C7D;
	Tue,  6 May 2025 08:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tsF4BzGy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0U7ROxq4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tsF4BzGy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0U7ROxq4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599321C84C5
	for <bpf@vger.kernel.org>; Tue,  6 May 2025 08:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521713; cv=none; b=bQYj8dmwm0QLKS87CCMAi6vWnbJ34WIY271QY7gPkxYfbOOkApUeWB1JUMGkS1gtPJzDKNQYubNfStCDYYpm2QqppzCP3M+t6Ga2wf6bsg7/wmEP7+2PxpRL0yrHhSLZrrQ/q3GqryciDK9wAaz4z00/OeLwKHMNhImag0kG1V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521713; c=relaxed/simple;
	bh=bzoW0BwYYYobrXnFKATrMYfeYhiRKzfk07vIg000hJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDFvDCWLOC4XmBgeMM4qyoSeko7AWIPSbNNM0moeBsJLgajA8pu+pDuFY+xsEwgvGNIWi1qmJy8WRkt1doG2V6NpEuRger8bER3JC+82IWjyMwjZmjU9SJy+ED9NVjKypuJcyiYZoF2EEcWDRXbEbNDl6Qj7YGMZEVYsP2lFsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tsF4BzGy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0U7ROxq4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tsF4BzGy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0U7ROxq4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6AD58211B1;
	Tue,  6 May 2025 08:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746521709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wZvaPqkQnpjjL6fqYURYkwEqQidRYfahw5sAAeWSuc=;
	b=tsF4BzGyVmbKZNp6Ck0nNGKOd9uCZxLSb5wpGk/M2Xc2bN091EEBMsosmE+9yhWMp7ebEb
	E4rMJyTaub5cTd/bryhu36Sxj+nMAepyzJf8UMb9W6h/xsTSt8SCWlVZzSS+xUwxoKnPqb
	FOWIzX2GS2kOBKIcOa9Skck0kXL1yA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746521709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wZvaPqkQnpjjL6fqYURYkwEqQidRYfahw5sAAeWSuc=;
	b=0U7ROxq4p3d3NkSk2v4YywrQgNIDfvjZypalqUZwWCdxDGUvbDftvWhs8PVBvVqTyqdV6x
	SkFmUSRY0BFgMGDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746521709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wZvaPqkQnpjjL6fqYURYkwEqQidRYfahw5sAAeWSuc=;
	b=tsF4BzGyVmbKZNp6Ck0nNGKOd9uCZxLSb5wpGk/M2Xc2bN091EEBMsosmE+9yhWMp7ebEb
	E4rMJyTaub5cTd/bryhu36Sxj+nMAepyzJf8UMb9W6h/xsTSt8SCWlVZzSS+xUwxoKnPqb
	FOWIzX2GS2kOBKIcOa9Skck0kXL1yA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746521709;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wZvaPqkQnpjjL6fqYURYkwEqQidRYfahw5sAAeWSuc=;
	b=0U7ROxq4p3d3NkSk2v4YywrQgNIDfvjZypalqUZwWCdxDGUvbDftvWhs8PVBvVqTyqdV6x
	SkFmUSRY0BFgMGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F59713687;
	Tue,  6 May 2025 08:55:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yHdNEW3OGWhOYwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 06 May 2025 08:55:09 +0000
Message-ID: <f70740d9-5b37-48f1-bf60-653332085696@suse.cz>
Date: Tue, 6 May 2025 10:55:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] mm: Allow GFP_ACCOUNT and GFP_COMP to be used in
 alloc_pages_nolock().
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 linux-mm@kvack.org
Cc: harry.yoo@oracle.com, shakeel.butt@linux.dev, mhocko@suse.com,
 bigeasy@linutronix.de, andrii@kernel.org, memxor@gmail.com,
 akpm@linux-foundation.org, peterz@infradead.org, rostedt@goodmis.org,
 hannes@cmpxchg.org, willy@infradead.org
References: <20250501032718.65476-1-alexei.starovoitov@gmail.com>
 <20250501032718.65476-6-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20250501032718.65476-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
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
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,kvack.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux.dev,suse.com,linutronix.de,kernel.org,gmail.com,linux-foundation.org,infradead.org,goodmis.org,cmpxchg.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 5/1/25 05:27, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Allow __GFP_ACCOUNT and __GFP_COMP flags to be specified when calling
> alloc_pages_nolock(), since upcoming reentrant alloc_slab_page() needs
> to allocate __GFP_COMP pages while BPF infra needs __GFP_ACCOUNT.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

I would rather see __GFP_COMP implied as we don't need any new users of
high-order allocations that are not compound, and alloc_pages_nolock() is a
new API.

IIRC it would be more important in some early version where
free_pages_nolock() was different, now it just calls to ___free_pages()
which has the tricky code for freeing those non-compound allocations.

But still, I'd really recommend that approach. Note __GFP_COMP is simply
ignored for order-0 so no need to filter it out.

> ---
>  include/linux/gfp.h  | 2 +-
>  kernel/bpf/syscall.c | 2 +-
>  mm/page_alloc.c      | 8 +++++---
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index be160e8d8bcb..9afbe5b3aef6 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -354,7 +354,7 @@ static inline struct page *alloc_page_vma_noprof(gfp_t gfp,
>  }
>  #define alloc_page_vma(...)			alloc_hooks(alloc_page_vma_noprof(__VA_ARGS__))
>  
> -struct page *alloc_pages_nolock_noprof(int nid, unsigned int order);
> +struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order);
>  #define alloc_pages_nolock(...)			alloc_hooks(alloc_pages_nolock_noprof(__VA_ARGS__))
>  
>  extern unsigned long get_free_pages_noprof(gfp_t gfp_mask, unsigned int order);
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index d0ddba2a952b..83af8fa9db3f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -578,7 +578,7 @@ static bool can_alloc_pages(void)
>  static struct page *__bpf_alloc_page(int nid)
>  {
>  	if (!can_alloc_pages())
> -		return alloc_pages_nolock(nid, 0);
> +		return alloc_pages_nolock(__GFP_ACCOUNT, nid, 0);
>  
>  	return alloc_pages_node(nid,
>  				GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1d77a07b0659..303df205ca7d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7379,6 +7379,7 @@ static bool __free_unaccepted(struct page *page)
>  
>  /**
>   * alloc_pages_nolock - opportunistic reentrant allocation from any context
> + * @gfp_flags: GFP flags. Only __GFP_ACCOUNT, __GFP_COMP allowed.
>   * @nid: node to allocate from
>   * @order: allocation order size
>   *
> @@ -7392,7 +7393,7 @@ static bool __free_unaccepted(struct page *page)
>   * Return: allocated page or NULL on failure. NULL does not mean EBUSY or EAGAIN.
>   * It means ENOMEM. There is no reason to call it again and expect !NULL.
>   */
> -struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
> +struct page *alloc_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order)
>  {
>  	/*
>  	 * Do not specify __GFP_DIRECT_RECLAIM, since direct claim is not allowed.
> @@ -7415,11 +7416,12 @@ struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
>  	 * doesn't want to deplete reserves.
>  	 */
>  	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC
> -			| __GFP_ACCOUNT;
> +			| gfp_flags;
>  	unsigned int alloc_flags = ALLOC_TRYLOCK;
>  	struct alloc_context ac = { };
>  	struct page *page;
>  
> +	VM_WARN_ON_ONCE(gfp_flags & ~(__GFP_ACCOUNT | __GFP_COMP));
>  	/*
>  	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
>  	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
> @@ -7462,7 +7464,7 @@ struct page *alloc_pages_nolock_noprof(int nid, unsigned int order)
>  	if (page)
>  		set_page_refcounted(page);
>  
> -	if (memcg_kmem_online() && page &&
> +	if (memcg_kmem_online() && page && (gfp_flags & __GFP_ACCOUNT) &&
>  	    unlikely(__memcg_kmem_charge_page(page, alloc_gfp, order) != 0)) {
>  		free_pages_nolock(page, order);
>  		page = NULL;


