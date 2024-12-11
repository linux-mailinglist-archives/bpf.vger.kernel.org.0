Return-Path: <bpf+bounces-46618-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5F89ECBBA
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 13:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D961188B5AB
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E52163A7;
	Wed, 11 Dec 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQ4zWF/1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9lQHC3Cq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQ4zWF/1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9lQHC3Cq"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5B1FF1C3
	for <bpf@vger.kernel.org>; Wed, 11 Dec 2024 12:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733918729; cv=none; b=SzGw61jbaY6OVNpuIIETgzwam+pDe45qaFNyN966iNeyr3ja+2X4od0Z9ankqTGO21lBTXC7IyrHMAnAgdWVd6jYmRweFVHnSKzbUzshK32Dltk3rUAsmtmnKX98DGPcBta8hcOCGT6vFBzRxQEuu/jz4BLz3JNCdgkJpUmUwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733918729; c=relaxed/simple;
	bh=9iPvePqLt8FeU6my8TF23UfRsm0s9xf1Wbt7m+eab84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GFucM2lbxm1MOVnXky7a/1/kEReeu0+ZFFU7Sd+Kv4L1WtYfegS9NKueiLFKI0+ymVz5pufQHcnFlQIvLJ9v9TzmfTwKPyBvkzNXDtzaXGvSJ4ed5XMNzKOiJqLCBgUDlPFf+osHnHZM3d62Hv1FanFpPLHW7pJ0UdvibVvWlxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQ4zWF/1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9lQHC3Cq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQ4zWF/1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9lQHC3Cq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3881E1F445;
	Wed, 11 Dec 2024 12:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733918725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kG1ERPnzqUd9KaqnteZfO/dcI+0vAt/Asz3D2zxDOtk=;
	b=BQ4zWF/1M4/Omm0sLHoYFpAG65juUZ9uLi+WD+ozFbu4uxTOAwYqKZso5XoU4qSEX1PsmZ
	my+5RD9Y05dgtR1+n/zEBmBZYAYJvIJc49xokmBatFPp+4p6424OwvVdZwawaNWVO+WulA
	tKK+0U+gcmanr+0m5Ofd+cNMa1ZhIF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733918725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kG1ERPnzqUd9KaqnteZfO/dcI+0vAt/Asz3D2zxDOtk=;
	b=9lQHC3CqdYdWad9kg/Ijeela9dPwc1vAMl2Nr9S6N1vzoxnfAF2nns7JU+JeopMhfDkhwa
	kWWNG9tE2vAjQEBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733918725; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kG1ERPnzqUd9KaqnteZfO/dcI+0vAt/Asz3D2zxDOtk=;
	b=BQ4zWF/1M4/Omm0sLHoYFpAG65juUZ9uLi+WD+ozFbu4uxTOAwYqKZso5XoU4qSEX1PsmZ
	my+5RD9Y05dgtR1+n/zEBmBZYAYJvIJc49xokmBatFPp+4p6424OwvVdZwawaNWVO+WulA
	tKK+0U+gcmanr+0m5Ofd+cNMa1ZhIF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733918725;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kG1ERPnzqUd9KaqnteZfO/dcI+0vAt/Asz3D2zxDOtk=;
	b=9lQHC3CqdYdWad9kg/Ijeela9dPwc1vAMl2Nr9S6N1vzoxnfAF2nns7JU+JeopMhfDkhwa
	kWWNG9tE2vAjQEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1044C13983;
	Wed, 11 Dec 2024 12:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2vuhK/9/WWcFfQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 11 Dec 2024 12:05:19 +0000
Message-ID: <4233d087-4610-475e-bc79-14feaf2f7cfd@suse.cz>
Date: Wed, 11 Dec 2024 13:05:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 5/6] mm, bpf: Use __GFP_ACCOUNT in
 try_alloc_pages().
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
 peterz@infradead.org, bigeasy@linutronix.de, rostedt@goodmis.org,
 houtao1@huawei.com, hannes@cmpxchg.org, shakeel.butt@linux.dev,
 mhocko@suse.com, willy@infradead.org, tglx@linutronix.de, tj@kernel.org,
 linux-mm@kvack.org, kernel-team@fb.com
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-6-alexei.starovoitov@gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20241210023936.46871-6-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,infradead.org,linutronix.de,goodmis.org,huawei.com,cmpxchg.org,linux.dev,suse.com,kvack.org,fb.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 12/10/24 03:39, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Unconditionally use __GFP_ACCOUNT in try_alloc_pages().
> The caller is responsible to setup memcg correctly.
> All BPF memory accounting is memcg based.

Hm I guess if there was later another user besides bpf that didn't want
memcg for some reason, a variant of the function (or a bool param, to avoid
passing full gfp param which would be thrown away besides __GFP_ACCOUNT)
could be easily created.

> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/gfp.h | 5 ++---
>  mm/page_alloc.c     | 5 ++++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index dcae733ed006..820c4938c9cd 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -356,18 +356,17 @@ static inline struct page *try_alloc_pages_noprof(int nid, unsigned int order)
>  	 */
>  	if (preemptible() && !rcu_preempt_depth())
>  		return alloc_pages_node_noprof(nid,
> -					       GFP_NOWAIT | __GFP_ZERO,
> +					       GFP_NOWAIT | __GFP_ZERO | __GFP_ACCOUNT,
>  					       order);
>  	/*
>  	 * Best effort allocation from percpu free list.
>  	 * If it's empty attempt to spin_trylock zone->lock.
>  	 * Do not specify __GFP_KSWAPD_RECLAIM to avoid wakeup_kswapd
>  	 * that may need to grab a lock.
> -	 * Do not specify __GFP_ACCOUNT to avoid local_lock.
>  	 * Do not warn either.
>  	 */
>  	return alloc_pages_node_noprof(nid,
> -				       __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO,
> +				       __GFP_TRYLOCK | __GFP_NOWARN | __GFP_ZERO | __GFP_ACCOUNT,
>  				       order);
>  }
>  #define try_alloc_pages(...)			alloc_hooks(try_alloc_pages_noprof(__VA_ARGS__))
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a969a62ec0c3..1fada16b8a14 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4818,7 +4818,10 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
>  out:
>  	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
>  	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
> -		__free_pages(page, order);
> +		if (unlikely(gfp & __GFP_TRYLOCK))
> +			free_pages_nolock(page, order);
> +		else
> +			__free_pages(page, order);
>  		page = NULL;
>  	}
>  


