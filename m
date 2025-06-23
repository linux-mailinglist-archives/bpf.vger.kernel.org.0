Return-Path: <bpf+bounces-61272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FADAE39B0
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 11:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEE9170B85
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 09:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E29B231A55;
	Mon, 23 Jun 2025 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf3Nkj6B"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658DF1DDA0C
	for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670211; cv=none; b=aSn41r1t2iCoVKA08n28g9/dzWfhEdch7ue/641iM/m/3C0j8sksUl3USnUOVZMGXABuhpXfkTPWPtJhDYbmplGzMbxaRb/IIM88wgH60NwppNq/LA3UCfQ0reoHM/aoyoE2f0Z0jlFti3704rNivayFCaJ+YSWvdIJ/jeL6kpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670211; c=relaxed/simple;
	bh=WXi6ciQl/ySvtGGnf6utBqod7v8My4gfOiJugdbgvWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VVsIwKLlOoP/PT/8KPmeJFDqSTD/D7Tb7xVc9jkTcCVVRHsLgk9KKrF61bcoSqHbsaI9iInfXhbCDT30A3gIMhnShNtQVN5/jjeTZUvo0bvLcKE8Puiq0FvvX0/V4nreFOlIj0KRyjiVQcdYnLn5T+05NwAKoy5GDlkUdAKnyPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hf3Nkj6B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750670208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6+CEh7DV/eygJzLS3mmbXc5krbfV2IS8Kf/dZNnKGmA=;
	b=Hf3Nkj6BlGJi5C19A772jcpvXQ2JnGKtmvcU1RsPh84/k8r/KWPLIX62n0p0IeWBs9Iu8U
	1tD8KI2XlHFpYG4PKECvZV5Yzl19Wt/NSub3usR7jS9mqyAGqv3irlcag5uFvzrcQzE9cZ
	IHef3bAvEFhcsdzwcqrBgo58KfYMDZc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-MzqtQzHPOPqbQhbtlOdoPA-1; Mon, 23 Jun 2025 05:16:46 -0400
X-MC-Unique: MzqtQzHPOPqbQhbtlOdoPA-1
X-Mimecast-MFC-AGG-ID: MzqtQzHPOPqbQhbtlOdoPA_1750670206
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45359bfe631so21406755e9.0
        for <bpf@vger.kernel.org>; Mon, 23 Jun 2025 02:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750670206; x=1751275006;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6+CEh7DV/eygJzLS3mmbXc5krbfV2IS8Kf/dZNnKGmA=;
        b=NTA3k7owhi1MY5qe74gzyyvr+kW2HdB5alJMmKbkhyFMdjbU2ri5S6cm+Tz04kOK0j
         ldseCNLmh1DWKFPWq2lBwgK7Zg6gV8RHbll3pzp5pyoY0oFd+f/qo+HGeMYdANtVQ8Oe
         fsUEZp/MR4ukSIa27LKSN10hiY8JtezZ0zu6dwgD4cWVM3QcL6LHwMWxhpcydZzFhjtb
         QMGR4ZS1PMmL3opzvBWPZDwnR5Tplm/O1vhslcs38tZIJzJgGS5M1BsuzD9s6ljCO3M4
         jyDaAs7scZKF6nPkJE3bm3PknwbE7IP3hIpOhXCogBfVB1cwVpB5iR/3/E3X+8KyYuUw
         +z3g==
X-Forwarded-Encrypted: i=1; AJvYcCXUFqy/O5S+JyaCYvNHUiePcRrh7U1l8l+jJXuhPbtXceUL2QKfMVsXR0tfNRPSInYhicE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8SE/jeDIKr/oBlepuATg9x2+3wZsrtm95yOAG26BdLAAZSwFr
	EXziHRCAH8fjbx6agJ1YPfVbIInn9zixgVEceqbcyGLhT2HVMB0eeYWUGAd21Oo17JfpyBaDOI5
	nVbnixzi9WSFxpBokn0Pm9OWkFgVr9bGtXJrDTX32/Pe9bsFeZ4Zy4g==
X-Gm-Gg: ASbGncsNFkpZ6WlIa0cxgmMUdoc7j6fR28bpNMZpacIpFfblXrWmdQnyWS50GDENNqe
	lkXcgZp0YWqE2tuvmejX8ae/Nf5Wnmddxfu+j4U9mirT63HQwakmd1RUcLXCOLhIfiTrjFSZIQU
	gAl7PTKkedd5Bn8rIKVi/RCaiJ9HJNTGHQT16/mMKV/zKVtzHmhcfbm4QJ9pw/A5rbVGOltTnnu
	KV+2V25SuYydbJe6thiunCTOzUEvrQkVJA5GT4FBM6Vys4BTzE7q7V+CZfXQw4gBqAjk6ZBc25X
	w84KIGhu6CFLJwnE5h/hNSnltwEVIgyTYN0yC2KoURiqwFGXGYTGn8co9qLeZxaUhCAKbohxs0h
	DsubTKOFZe/Qr7CIAkxRrC+JvdUCBoQRx8Uyfdz/DNNwMFHSO3A==
X-Received: by 2002:a05:600c:c4ac:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-453659be428mr99470505e9.5.1750670205658;
        Mon, 23 Jun 2025 02:16:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSdTrkum0uGk/zLo1y8F4EbYhm1nsGHbNNP/oVrjmhH2urGZHFTnIjPrsPub1P941JC31blw==
X-Received: by 2002:a05:600c:c4ac:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-453659be428mr99469955e9.5.1750670205140;
        Mon, 23 Jun 2025 02:16:45 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646fd816sm104134785e9.24.2025.06.23.02.16.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 02:16:44 -0700 (PDT)
Message-ID: <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
Date: Mon, 23 Jun 2025 11:16:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250620041224.46646-10-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20.06.25 06:12, Byungchul Park wrote:
> To simplify struct page, the effort to separate its own descriptor from
> struct page is required and the work for page pool is on going.
> 
> To achieve that, all the code should avoid directly accessing page pool
> members of struct page.
> 
> Access ->pp_magic through struct netmem_desc instead of directly
> accessing it through struct page in page_pool_page_is_pp().  Plus, move
> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_desc
> without header dependency issue.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>   include/linux/mm.h   | 12 ------------
>   include/net/netmem.h | 14 ++++++++++++++
>   mm/page_alloc.c      |  1 +
>   3 files changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0ef2ba0c667a..0b7f7f998085 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long status);
>    */
>   #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>   
> -#ifdef CONFIG_PAGE_POOL
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -	return (page->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> -}
> -#else
> -static inline bool page_pool_page_is_pp(struct page *page)
> -{
> -	return false;
> -}
> -#endif
> -
>   #endif /* _LINUX_MM_H */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index d49ed49d250b..3d1b1dfc9ba5 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>    */
>   static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
>   
> +#ifdef CONFIG_PAGE_POOL
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +	struct netmem_desc *desc = (struct netmem_desc *)page;
> +
> +	return (desc->pp_magic & PP_MAGIC_MASK) == PP_SIGNATURE;
> +}
> +#else
> +static inline bool page_pool_page_is_pp(struct page *page)
> +{
> +	return false;
> +}
> +#endif

I wonder how helpful this cleanup is long-term.

page_pool_page_is_pp() is only called from mm/page_alloc.c, right? 
There, we want to make sure that no pagepool page is ever returned to 
the buddy.

How reasonable is this sanity check to have long-term? Wouldn't we be 
able to check that on some higher-level freeing path?

The reason I am commenting is that once we decouple "struct page" from 
"struct netmem_desc", we'd have to lookup here the corresponding "struct 
netmem_desc".

... but at that point here (when we free the actual pages), the "struct 
netmem_desc" would likely already have been freed separately (remember: 
it will be dynamically allocated).

With that in mind:

1) Is there a higher level "struct netmem_desc" freeing path where we 
could check that instead, so we don't have to cast from pages to 
netmem_desc at all.

2) How valuable are these sanity checks deep in the buddy?

-- 
Cheers,

David / dhildenb


