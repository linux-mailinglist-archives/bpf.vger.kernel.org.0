Return-Path: <bpf+bounces-63883-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D561EB0BE69
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 10:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5751761C1
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 08:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AB8285C9C;
	Mon, 21 Jul 2025 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5YW/cJ3"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18521283FD4
	for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753085135; cv=none; b=PPrjhXFYHC/8v4kPQ2umrrtN9lFjIdZLpeW5UclEDLvYT05AadDAv8F3ZBYz248ub4CBpFJ3SXGekJWPCKYkpeExuhzW3FYC32J31FCjKF0hhDrYHv/dD3GLmg7sxx8KeKTVddsodJGIUyQ9/4/BQgfmcxg5OnjxQ08PpP0T43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753085135; c=relaxed/simple;
	bh=OmacDHOgisi4/R/uJWi3N1yuxQnUS7GhOJDuFiXyVLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5P8HPbKnF8JtLndMaMwPqIumZSuqcQSHiVjLlAuzM5AAO+/pj2qfdZ/dd/35lnAq5oT4DFxF0rFTsf1Y6PuDANaGTaHwBPIkkPhbu2v8TRg149va9d9Ss1rqzQSVPlLNx4uNlnIxYMWxV6rLdYkpd6PAGwa7npBaCi8rLlQGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R5YW/cJ3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753085132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YZwimYc/XbFaUcGJkln+p9HtaqBU8QoZiA7E2Ky46WU=;
	b=R5YW/cJ3a/PSn8GXIFL8YY9QyV74ji0ruqvf+zxSW2YwlNvuC6kD34j2n/aVk8bZjjKckA
	oW4PQpA11YvZLNMvGLWePsMtRLkqVDgtTrTPx33DGlUnGQsMFYcY9SBwPCoinwIu1e3lyJ
	4ojZDc82YLbgOE/TiwDnAL8dJT+9IDk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-DBJNldoYORWD2rX6kX-Fpg-1; Mon, 21 Jul 2025 04:05:30 -0400
X-MC-Unique: DBJNldoYORWD2rX6kX-Fpg-1
X-Mimecast-MFC-AGG-ID: DBJNldoYORWD2rX6kX-Fpg_1753085129
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561c67daebso14280725e9.1
        for <bpf@vger.kernel.org>; Mon, 21 Jul 2025 01:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753085129; x=1753689929;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YZwimYc/XbFaUcGJkln+p9HtaqBU8QoZiA7E2Ky46WU=;
        b=ECStgd8IOCAZ5Lef//UdIF4wTSsBeqE3rf+CvH7fshZsmLfWs7OON53w8f4CxL1DsO
         btPAR/NoeFXTkVObbH3LTsbDeBUJ22pjzBZp0zcboyQene8l2L5Pyu+/W4keu62vbFWq
         gzZm4bRHm0i6+em6H8E4PeBDy/OEa3a39IsHceNWZJ9H7r4Yfl7PdzP2tx+tcifm+Apa
         5+Q0aXJlfpd+t04tcV8uL3D/g4Zx8yNkJnb2Cjpx6rFk9Cgm1heTeG+cL088SMI+lsbX
         xRCcDreTXE61MNIkeQoH8ndc/Jx3/1bxEG/COALHhmvPXk7OuEs8rBL/R0owbXA5ml4a
         pmTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE/okmwXkOjiPkjFbUUWXXlnpdL5a2EwgHKf/wVJUUG3JZLqwUvcxeuQFA1AVpxkQw1VU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9PugnJljyrGX/XB0IojqHgkuhMXgm/Q23mDGjzTD9HmdzjEZI
	oKJh76/xE1IMPngG0Fwfv9HpxfnILn7lSVbl/Tq1VAoMsv0QNKCsbhrupAxM8YgB+sU3psf5BhU
	AmQFoaTcLPvci/WJAsuy9ObsAXs8fyRCpKmi6j6dgcY4pvh3mjLORqw==
X-Gm-Gg: ASbGncv0tZ5dNIfEjKUuJ8aJxhGNs94Y8QMa14aUOMokJlo9bSVIv25bpikKBtmspOS
	mSO6zvvwLhvgo1Q9L8+2KWz7rkABBoateeSqAnEVWaOFk1PY6IWNjkchRXAOfqtQjgL9luw+uMX
	/NR5pKH7dfUnpU+mHdpTBDyI6Z3QwVcDwAZEFs7RQFgY6CxSkhfHUHPqljJ0PmgOAfj6rWSEHPM
	Q2gWXbDfyOA2mx7TgDHepYO47VFHy3EBigZNTss2iPDJ+cjYV+Eo2AUs2HiyKsqPXZ8kBYQp1xM
	3qTN0e4avQRYobdE9s1GIFDM2nflIbIC/u+TaYPQlQd/+O/LGBaYFlGDhGWzuCASedvwHq2HG8J
	BBbD5xlteNv9tLLelsrK+929B+taE35MWvxRQ44w6zQeCcIEq6Rb+eX3oXKVOTQDi
X-Received: by 2002:a05:600c:6610:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45637bc1e8fmr147848425e9.11.1753085128899;
        Mon, 21 Jul 2025 01:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaqPaRa97Ws7y+SPufWF2ofN23cpKrkKJ1mE+QB0PaxxEWaWruM697N59u6maQfQXxXtGBSA==
X-Received: by 2002:a05:600c:6610:b0:456:942:b162 with SMTP id 5b1f17b1804b1-45637bc1e8fmr147847785e9.11.1753085128261;
        Mon, 21 Jul 2025 01:05:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f? (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45635fe6a92sm84696565e9.2.2025.07.21.01.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 01:05:27 -0700 (PDT)
Message-ID: <e897e784-4403-467c-b3e4-4ac4dc7b2e25@redhat.com>
Date: Mon, 21 Jul 2025 10:05:25 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, page_pool: introduce a new page type for page pool in
 page type
To: Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel_team@skhynix.com,
 harry.yoo@oracle.com, ast@kernel.org, daniel@iogearbox.net,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, pabeni@redhat.com,
 akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, horms@kernel.org, jackmanb@google.com, hannes@cmpxchg.org,
 ziy@nvidia.com, ilias.apalodimas@linaro.org, willy@infradead.org,
 brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20250721054903.39833-1-byungchul@sk.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250721054903.39833-1-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.07.25 07:49, Byungchul Park wrote:
> Hi,
> 
> I focused on converting the existing APIs accessing ->pp_magic field to
> page type APIs.  However, yes.  Additional works would better be
> considered on top like:
> 
>     1. Adjust how to store and retrieve dma index.  Maybe network guys
>        can work better on top.
> 
>     2. Move the sanity check for page pool in mm/page_alloc.c to on free.
> 
>     Byungchul
> 
> ---8<---
>  From 7d207a1b3e9f4ff2a72f5b54b09e3ed0c4aaaca3 Mon Sep 17 00:00:00 2001
> From: Byungchul Park <byungchul@sk.com>
> Date: Mon, 21 Jul 2025 14:05:20 +0900
> Subject: [PATCH] mm, page_pool: introduce a new page type for page pool in page type
> 
> ->pp_magic field in struct page is current used to identify if a page
> belongs to a page pool.  However, page type e.i. PGTY_netpp can be used
> for that purpose.
> 
> Use the page type APIs e.g. PageNetpp(), __SetPageNetpp(), and
> __ClearPageNetpp() instead, and remove the existing APIs accessing
> ->pp_magic e.g. page_pool_page_is_pp(), netmem_or_pp_magic(), and
> netmem_clear_pp_magic() since they are totally replaced.
> 
> This work was inspired by the following link by Pavel:
> 
> [1] https://lore.kernel.org/all/582f41c0-2742-4400-9c81-0d46bf4e8314@gmail.com/

I'm, sure you saw my comment (including my earlier suggestion for using 
a page type), in particular around ...

> ---
>   .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
>   include/linux/mm.h                            | 28 ++-----------------
>   include/linux/page-flags.h                    |  6 ++++
>   include/net/netmem.h                          |  2 +-
>   mm/page_alloc.c                               |  4 +--
>   net/core/netmem_priv.h                        | 16 ++---------
>   net/core/page_pool.c                          | 10 +++++--
>   7 files changed, 24 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> index 5d51600935a6..def274f5c1ca 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
> @@ -707,7 +707,7 @@ static void mlx5e_free_xdpsq_desc(struct mlx5e_xdpsq *sq,
>   				xdpi = mlx5e_xdpi_fifo_pop(xdpi_fifo);
>   				page = xdpi.page.page;
>   
> -				/* No need to check page_pool_page_is_pp() as we
> +				/* No need to check PageNetpp() as we
>   				 * know this is a page_pool page.
>   				 */
>   				page_pool_recycle_direct(pp_page_to_nmdesc(page)->pp,
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ae50c1641bed..736061749535 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4135,10 +4135,9 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>    * DMA mapping IDs for page_pool
>    *
>    * When DMA-mapping a page, page_pool allocates an ID (from an xarray) and
> - * stashes it in the upper bits of page->pp_magic. We always want to be able to
> - * unambiguously identify page pool pages (using page_pool_page_is_pp()). Non-PP
> - * pages can have arbitrary kernel pointers stored in the same field as pp_magic
> - * (since it overlaps with page->lru.next), so we must ensure that we cannot
> + * stashes it in the upper bits of page->pp_magic. Non-PP pages can have
> + * arbitrary kernel pointers stored in the same field as pp_magic (since
> + * it overlaps with page->lru.next), so we must ensure that we cannot
>    * mistake a valid kernel pointer with any of the values we write into this
>    * field.
>    *
> @@ -4168,25 +4167,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>   
>   #define PP_DMA_INDEX_MASK GENMASK(PP_DMA_INDEX_BITS + PP_DMA_INDEX_SHIFT - 1, \
>   				  PP_DMA_INDEX_SHIFT)
> -
> -/* Mask used for checking in page_pool_page_is_pp() below. page->pp_magic is
> - * OR'ed with PP_SIGNATURE after the allocation in order to preserve bit 0 for
> - * the head page of compound page and bit 1 for pfmemalloc page, as well as the
> - * bits used for the DMA index. page_is_pfmemalloc() is checked in
> - * __page_pool_put_page() to avoid recycling the pfmemalloc page.
> - */
> -#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> -
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(const struct page *page)
> -{
> -	return false;
> -}
> -#endif
> -
>   #endif /* _LINUX_MM_H */
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4fe5ee67535b..906ba7c9e372 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -957,6 +957,7 @@ enum pagetype {
>   	PGTY_zsmalloc		= 0xf6,
>   	PGTY_unaccepted		= 0xf7,
>   	PGTY_large_kmalloc	= 0xf8,
> +	PGTY_netpp		= 0xf9,
>   
>   	PGTY_mapcount_underflow = 0xff
>   };
> @@ -1101,6 +1102,11 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
>   PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
>   FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
>   
> +/*
> + * Marks page_pool allocated pages.
> + */
> +PAGE_TYPE_OPS(Netpp, netpp, netpp)
> +
>   /**
>    * PageHuge - Determine if the page belongs to hugetlbfs
>    * @page: The page to test.
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index f7dacc9e75fd..3667334e16e7 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -298,7 +298,7 @@ static inline struct net_iov *__netmem_clear_lsb(netmem_ref netmem)
>    */
>   #define pp_page_to_nmdesc(p)						\
>   ({									\
> -	DEBUG_NET_WARN_ON_ONCE(!page_pool_page_is_pp(p));		\
> +	DEBUG_NET_WARN_ON_ONCE(!PageNetpp(p));				\
>   	__pp_page_to_nmdesc(p);						\
>   })
>   
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2ef3c07266b3..71c7666e48a9 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -898,7 +898,7 @@ static inline bool page_expected_state(struct page *page,
>   #ifdef CONFIG_MEMCG
>   			page->memcg_data |
>   #endif
> -			page_pool_page_is_pp(page) |
> +			PageNetpp(page) |
>   			(page->flags & check_flags)))
>   		return false;
>   
> @@ -925,7 +925,7 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>   	if (unlikely(page->memcg_data))
>   		bad_reason = "page still charged to cgroup";
>   #endif
> -	if (unlikely(page_pool_page_is_pp(page)))
> +	if (unlikely(PageNetpp(page)))
>   		bad_reason = "page_pool leak";
>   	return bad_reason;
>   }

^ this

This will not work they way you want it once you rebase on top of 
linux-next, where we have (from mm/mm-stable)


commit 2dfcd1608f3a96364f10de7fcfe28727c0292e5d
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Jul 4 12:24:58 2025 +0200

     mm/page_alloc: let page freeing clear any set page type


I commented what to do already.

-- 
Cheers,

David / dhildenb


