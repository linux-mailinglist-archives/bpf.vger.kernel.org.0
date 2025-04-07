Return-Path: <bpf+bounces-55386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75164A7D8B2
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 10:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0085916E62A
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 08:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4B722A4D1;
	Mon,  7 Apr 2025 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N9bvnAfw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6307D229B38
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016043; cv=none; b=ow5VOoDdJUXDJk6UfwhH8tICpiRPuy+0+NJ8zYTEDfrX9v0d2tCHOg7Rk84BqLA7VYu9syWUL+yLlvZfQbPsMuzTGx7xxauG0doKbR3dQMVxA7N+NN4uoHfgZ9OwEgLl8OrJiW4jU9Wzvk3u/QamVof3g4oHusLo+xnuExh0UMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016043; c=relaxed/simple;
	bh=pOXia/AC4waKdD2HU2F4EacxLHFYKsgGieOUXINuaVM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eJAsOpEC+FbCYj3MfJJ6vwVVx6IRiy2BXDcLyaBzz4BqXBa/5BKhFq2UQIfi9mfVVLa1h3r61h9ynHDME1sqr+g4XXedz3oZvuFM/syiHRzWF0c+4OGk/YNi8qAbD4OpovPEgwQDqiMZ3qF3Xwu4+thkHy2fNcDFzRel+EohoJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N9bvnAfw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744016040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WX08fMyjATa1UCoVjYCNjOKyQjVIMz6mY8L2vI8owLs=;
	b=N9bvnAfwF4roAx/9xsMbsk3Eai8HIiUHzQF11t0ZtnID9lOhfh/dq+uZhhI2i5dNIXjVmL
	5qGRiq6dJmk6HWQmAozuwn6JEkB5dsh1cYsQWsQwm+nhnXwa59kQPVVfGgRPeljmiYi30y
	40GqQQ6+EIyK+9tiKf+8W+MB7MBVA0c=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-5ea-UW5JMF6AiHeb4IxtCQ-1; Mon, 07 Apr 2025 04:53:58 -0400
X-MC-Unique: 5ea-UW5JMF6AiHeb4IxtCQ-1
X-Mimecast-MFC-AGG-ID: 5ea-UW5JMF6AiHeb4IxtCQ_1744016038
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac297c7a0c2so320723366b.3
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 01:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744016037; x=1744620837;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WX08fMyjATa1UCoVjYCNjOKyQjVIMz6mY8L2vI8owLs=;
        b=FiWAX2Gl7zOPCG7b0TaWKgYM20LXfjaUx4oDwBjB1+scV98V8sLEeZOaFcaMxgScBw
         1fJbxu2xhMHYZpM5SUQ9Ggax6uwUkcCAWK6kfk2UEVk6Z9qxvLj6vzPpnmx7SM3gT5Oc
         vxoULsC7OFuS/a60iXtxaC+Kw8xc6knuEOi72sh9XihHzmakV/K42KgD6jNpMaQQFbdA
         C2HQCZQErjRSH40aNqAcafzKglqC1ENwjtqwuMNH4qg6oYwN+R7HEvHI+kLymDYelYRi
         KifioODMvbBwMlZwUDK3aI/zHthEKpeg6NhZeveIM1ZDWh5M5VbAesklMwPEMYRRZ7js
         7xyg==
X-Forwarded-Encrypted: i=1; AJvYcCUkeGdhVKACYiDvo+Nqu/HoGohhWeJbB2kO2pGZrnoAJjPR9o9M2kamR8oXBFeSRxAUuWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TRtStUw76Q2mxN1UjFuDdN6TbPGqJ7Pp8e1AnNkEXZmXY+Nw
	FSpmZBHH8XI4IG6Rm955Qtr0zAx5J6FByWnTl8JmaW8OdEo5pWwYJtGOIOlZ+PH0kYpol6vr+5s
	fNAiabLZME7XDo9oeCMfzrH3AOcYzQ2PVg4Pu1VBQBA2FKK7wpw==
X-Gm-Gg: ASbGnctWU9rBgnP89h05nF0BFrsoLBNVHv8gZ+oTriKFdcgpjmgOFNBKHiSEfE+IUM1
	LchSNiiwF0B/Bq97qzmoAvrJMBstNHvF8EhpAZDtrtYCiM4EsquKsSUmBgkXWan2GCgxjO9DaHP
	hkXAbAWZ1wujEJ5rtaEpIgjn16/mIt8JF+9wpsw45nrQHaJb9s85FD0iVJDW+oIwz696lzY+Fdw
	FkG4loVKEuywDzBnSfx3o9sgk9chcvDYMZ/KlfT7B5lVU2BIEj7xKUMfwPhyjaPE4EBlH8LQRuh
	5EXOkl4TIGbcueZiu7HW9MiBVq4Dp0MAG5UWCoez
X-Received: by 2002:a17:907:60d1:b0:ac2:66ff:878 with SMTP id a640c23a62f3a-ac7e77b48afmr787962666b.50.1744016037485;
        Mon, 07 Apr 2025 01:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVb33+8wF4lK6cnuu9f4nRUChR41f7hK0+8LtHxpAhi3vaXbXMmuVF5DNGsf7Ha6IvN6oWCg==
X-Received: by 2002:a17:907:60d1:b0:ac2:66ff:878 with SMTP id a640c23a62f3a-ac7e77b48afmr787959466b.50.1744016037067;
        Mon, 07 Apr 2025 01:53:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013f71asm706325866b.112.2025.04.07.01.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 01:53:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 521BF1991859; Mon, 07 Apr 2025 10:53:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Zi Yan <ziy@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Simon Horman <horms@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mina Almasry
 <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>, Yunsheng
 Lin <linyunsheng@huawei.com>, Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
In-Reply-To: <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 07 Apr 2025 10:53:55 +0200
Message-ID: <87cydoxsgs.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Zi Yan" <ziy@nvidia.com> writes:

> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Since we are about to stash some more information into the pp_magic
>> field, let's move the magic signature checks into a pair of helper
>> functions so it can be changed in one place.
>>
>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>  include/net/page_pool/types.h                    | 18 ++++++++++++++++++
>>  mm/page_alloc.c                                  |  9 +++------
>>  net/core/netmem_priv.h                           |  5 +++++
>>  net/core/skbuff.c                                | 16 ++--------------
>>  net/core/xdp.c                                   |  4 ++--
>>  6 files changed, 32 insertions(+), 24 deletions(-)
>>
>
> <snip>
>
>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types=
.h
>> index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224feb26=
173135ff37951ef8 100644
>> --- a/include/net/page_pool/types.h
>> +++ b/include/net/page_pool/types.h
>> @@ -54,6 +54,14 @@ struct pp_alloc_cache {
>>  	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>>  };
>>=20=20
>> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp_mag=
ic is
>> + * OR'ed with PP_SIGNATURE after the allocation in order to preserve bi=
t 0 for
>> + * the head page of compound page and bit 1 for pfmemalloc page.
>> + * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoid r=
ecycling
>> + * the pfmemalloc page.
>> + */
>> +#define PP_MAGIC_MASK ~0x3UL
>> +
>>  /**
>>   * struct page_pool_params - page pool parameters
>>   * @fast:	params accessed frequently on hotpath
>> @@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
>>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(v=
oid *),
>>  			   const struct xdp_mem_info *mem);
>>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
>> +
>> +static inline bool page_pool_page_is_pp(struct page *page)
>> +{
>> +	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>> +}
>>  #else
>>  static inline void page_pool_destroy(struct page_pool *pool)
>>  {
>> @@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct pag=
e_pool *pool,
>>  static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 coun=
t)
>>  {
>>  }
>> +
>> +static inline bool page_pool_page_is_pp(struct page *page)
>> +{
>> +	return false;
>> +}
>>  #endif
>>=20=20
>>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref ne=
tmem,
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced85e0d=
198947be7c503526 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -55,6 +55,7 @@
>>  #include <linux/delayacct.h>
>>  #include <linux/cacheinfo.h>
>>  #include <linux/pgalloc_tag.h>
>> +#include <net/page_pool/types.h>
>>  #include <asm/div64.h>
>>  #include "internal.h"
>>  #include "shuffle.h"
>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct page *=
page,
>>  #ifdef CONFIG_MEMCG
>>  			page->memcg_data |
>>  #endif
>> -#ifdef CONFIG_PAGE_POOL
>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>> -#endif
>> +			page_pool_page_is_pp(page) |
>>  			(page->flags & check_flags)))
>>  		return false;
>>=20=20
>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page *pag=
e, unsigned long flags)
>>  	if (unlikely(page->memcg_data))
>>  		bad_reason =3D "page still charged to cgroup";
>>  #endif
>> -#ifdef CONFIG_PAGE_POOL
>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>> +	if (unlikely(page_pool_page_is_pp(page)))
>>  		bad_reason =3D "page_pool leak";
>> -#endif
>>  	return bad_reason;
>>  }
>>=20=20
>
> I wonder if it is OK to make page allocation depend on page_pool from
> net/page_pool.

Why? It's not really a dependency, just a header include with a static
inline function...

> Would linux/mm.h be a better place for page_pool_page_is_pp()?

That would require moving all the definitions introduced in patch 2,
which I don't think is appropriate.

-Toke


