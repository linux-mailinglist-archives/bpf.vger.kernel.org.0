Return-Path: <bpf+bounces-55413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B87A7E5E9
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633C3421559
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B55620CCF0;
	Mon,  7 Apr 2025 16:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWZI8CpI"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7530209F4D
	for <bpf@vger.kernel.org>; Mon,  7 Apr 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744041932; cv=none; b=ly75dRbtliGKUXWopVdUXiRa+AknKIx2fbd3GMAtny7ClzX0Y80PjNNsbWPyTKoIOVxYRWrX/um7UC15z5kVf4FQaYgKCAzyhuLFyFhI0/oYmOIAmr42FqSOldCN3qkmbcdo54qt/frlkdcvJ9zz+V+ozdmzBPnFRQVbCRfV2ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744041932; c=relaxed/simple;
	bh=5VOZEMTu1wJkqkG6d7PWaW6ZZgWFBjSFVZSVHzRHhzA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i7fQnjBYKplq9yNRq7ifemr9FJp51hmHNcQ5wJcMHWNcgRanJSROUki+dqW5Gnz+q1nj1OgPCJBz8ygd8qGXHpoxqcn8HQFLBxir17GgVYbOLi4rn4FMtlCkXdlRIqSHRdSsVa7hS/twalvSLXrbV38ntS6UjchLDHGQyeGFmxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWZI8CpI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744041929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CsKVmSSOEhSPW5M16uS9aq81qKIIkPndLncn38XuUug=;
	b=dWZI8CpIBuE16os/qvU9VlkJbc/Stq0pliDleRpQqgoZEM5+cTM+2d5/G8GeYLa9QlqWUt
	3r0mqlL2sHvoKM4pwEPNeNLAme+2A34Z9JLy9JHWXmAVpdFOjdO9A1dmHm9TUmXpypJZCa
	xARbV07nGope5y2zHo3kRDotMQmtqec=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-x_Qm9e9fN1-w7RMA_BMFcg-1; Mon, 07 Apr 2025 12:05:28 -0400
X-MC-Unique: x_Qm9e9fN1-w7RMA_BMFcg-1
X-Mimecast-MFC-AGG-ID: x_Qm9e9fN1-w7RMA_BMFcg_1744041927
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac287f28514so395652266b.0
        for <bpf@vger.kernel.org>; Mon, 07 Apr 2025 09:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744041927; x=1744646727;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CsKVmSSOEhSPW5M16uS9aq81qKIIkPndLncn38XuUug=;
        b=BXQstLwtDb020OkSRZXfv4ymy3qgfFtwV/Qm14KQ7wj9dMuvDggmFHmUlmAgY4kAlo
         G1m53UIvJ3VeepK4v05+8QKnR2EPS/eK4LqRnB0Kf1ekQ28YLO8UdmJ2jB6HNfV5dKJK
         oAqZiWzH5BA4vVH8p9QU1NE7i3UuiZeEA91B1rcDghXU94x547hQJX+7EPssRa9sGgKt
         e4xK1vZt0TOfShT4Imuv30ixT0F+XxMaJNBrscPk27LZPFYrpYQFpz/rXzWaMnZNFB8o
         NN54kM00TjUsPX9ac4M7Wv8M+at7sDK6U9EFi3Gz2HnZTvqE0/9TWR1fON39hDr0eCYb
         26/A==
X-Forwarded-Encrypted: i=1; AJvYcCXUjWxlvXu5mmZa+3YLMU/hq/o1Q31JASEporcjA19YCtNOIN3GTzL+6/F8ChMx/bIiw1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+zWNVk+KvJt9we7SK1WUpFeTIdS8merjDnT1rblqwoTPmT9ne
	saZQWaoHoZbSu/HXU2qQdeDjfRKvOCyNQUKpKEaWydz7wt444WAyUnkS9Axu8XmPafLRDvBKnIJ
	Od6peeEvKUOVRIiFG4RHb0HXH2bQH1zcXxSwHTIJsN1OgMCdHTw==
X-Gm-Gg: ASbGncumJ0mrbFjAWGDCig6X3JqmGHlIE8hHKGzABSwoYQxsCwh4FgAKGnrqC8uiNj8
	Hg1bDTU/g9wl0GkhYqUMimvLIitC2eGU88s8LFYCHb8Bpyd3F/kNTz5vneVU1JEojfcfMQoyv1a
	gQdZJZRmnSqGw2IMherxNGZ2xHbE908GOiqrhPPQfuHABmQJ6L616+IdwkiV0370eoPB+/MLaqz
	DCYos5y7wOHnhI6EHYTOAR8Pt0rGUWvqd2WeL8+ohvvMzJWlKXuH3Dkjk6gQgp/M/smfkbgkirs
	BP91kwc44lBlbaPK0F0FpJOAIYOxZjB8VvKCA9sh
X-Received: by 2002:a17:907:7291:b0:ac2:a4ec:46c2 with SMTP id a640c23a62f3a-ac7d1b9c1demr1174829566b.49.1744041925341;
        Mon, 07 Apr 2025 09:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfWaVdDYJ0191r28pa3c0I5QAq2TX4YfoyI6/S6plMu4jTexyNQOGbQSCGtYlVpcULGOS5sw==
X-Received: by 2002:a17:907:7291:b0:ac2:a4ec:46c2 with SMTP id a640c23a62f3a-ac7d1b9c1demr1174821366b.49.1744041924666;
        Mon, 07 Apr 2025 09:05:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe5d407sm755045066b.25.2025.04.07.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 09:05:24 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1E85D19918CB; Mon, 07 Apr 2025 18:05:23 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Zi Yan <ziy@nvidia.com>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Matthew Wilcox <willy@infradead.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
In-Reply-To: <4185FF99-160F-46A9-A5A4-4CA48CC086D1@nvidia.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com> <87cydoxsgs.fsf@toke.dk>
 <DF12251B-E50F-4724-A2FA-FE5AAF3E63DF@nvidia.com> <87v7rgw1us.fsf@toke.dk>
 <E9D0B5C7-B387-46A9-82CC-8F29623BFF6C@nvidia.com>
 <893B4BFD-1FDA-46DE-82D5-9E5CBDD90068@nvidia.com>
 <4d35bda2-d032-49db-bb6e-b1d70f10d436@kernel.org>
 <4185FF99-160F-46A9-A5A4-4CA48CC086D1@nvidia.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 07 Apr 2025 18:05:23 +0200
Message-ID: <87plhovtx8.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zi Yan <ziy@nvidia.com> writes:

> On 7 Apr 2025, at 10:43, Jesper Dangaard Brouer wrote:
>
>> On 07/04/2025 16.15, Zi Yan wrote:
>>> On 7 Apr 2025, at 9:36, Zi Yan wrote:
>>>
>>>> On 7 Apr 2025, at 9:14, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>
>>>>> Zi Yan<ziy@nvidia.com>  writes:
>>>>>
>>>>>> Resend to fix my signature.
>>>>>>
>>>>>> On 7 Apr 2025, at 4:53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>>
>>>>>>> "Zi Yan"<ziy@nvidia.com>  writes:
>>>>>>>
>>>>>>>> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>>>>>>>>> Since we are about to stash some more information into the pp_mag=
ic
>>>>>>>>> field, let's move the magic signature checks into a pair of helper
>>>>>>>>> functions so it can be changed in one place.
>>>>>>>>>
>>>>>>>>> Reviewed-by: Mina Almasry<almasrymina@google.com>
>>>>>>>>> Tested-by: Yonglong Liu<liuyonglong@huawei.com>
>>>>>>>>> Acked-by: Jesper Dangaard Brouer<hawk@kernel.org>
>>>>>>>>> Reviewed-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
>>>>>>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen<toke@redhat.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>>>>>>>>   include/net/page_pool/types.h                    | 18 +++++++++=
+++++++++
>>>>>>>>>   mm/page_alloc.c                                  |  9 +++------
>>>>>>>>>   net/core/netmem_priv.h                           |  5 +++++
>>>>>>>>>   net/core/skbuff.c                                | 16 ++-------=
-------
>>>>>>>>>   net/core/xdp.c                                   |  4 ++--
>>>>>>>>>   6 files changed, 32 insertions(+), 24 deletions(-)
>>>>>>>>>
>>>>>>>> <snip>
>> [...]
>>
>>>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>>>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9c=
ed85e0d198947be7c503526 100644
>>>>>>>>> --- a/mm/page_alloc.c
>>>>>>>>> +++ b/mm/page_alloc.c
>>>>>>>>> @@ -55,6 +55,7 @@
>>>>>>>>>   #include <linux/delayacct.h>
>>>>>>>>>   #include <linux/cacheinfo.h>
>>>>>>>>>   #include <linux/pgalloc_tag.h>
>>>>>>>>> +#include <net/page_pool/types.h>
>>>>>>>>>   #include <asm/div64.h>
>>>>>>>>>   #include "internal.h"
>>>>>>>>>   #include "shuffle.h"
>>>>>>>>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct=
 page *page,
>>>>>>>>>   #ifdef CONFIG_MEMCG
>>>>>>>>>   			page->memcg_data |
>>>>>>>>>   #endif
>>>>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>>>>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>>>>>>>>> -#endif
>>>>>>>>> +			page_pool_page_is_pp(page) |
>>>>>>>>>   			(page->flags & check_flags)))
>>>>>>>>>   		return false;
>>>>>>>>>
>>>>>>>>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct pa=
ge *page, unsigned long flags)
>>>>>>>>>   	if (unlikely(page->memcg_data))
>>>>>>>>>   		bad_reason =3D "page still charged to cgroup";
>>>>>>>>>   #endif
>>>>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>>>>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>>>>>>>>> +	if (unlikely(page_pool_page_is_pp(page)))
>>>>>>>>>   		bad_reason =3D "page_pool leak";
>>>>>>>>> -#endif
>>>>>>>>>   	return bad_reason;
>>>>>>>>>   }
>>>>>>>>>
>>>>>>>> I wonder if it is OK to make page allocation depend on page_pool f=
rom
>>>>>>>> net/page_pool.
>>>>>>> Why? It's not really a dependency, just a header include with a sta=
tic
>>>>>>> inline function...
>>>>>> The function is checking, not even modifying, an core mm data struct=
ure,
>>>>>> struct page, which is also used by almost all subsystems. I do not g=
et
>>>>>> why the function is in net subsystem.
>>>>> Well, because it's using details of the PP definitions, so keeping it
>>>>> there nicely encapsulates things. I mean, that's the whole point of
>>>>> defining a wrapper function - encapsulating the logic =F0=9F=99=82
>>>>>
>>>>>>>> Would linux/mm.h be a better place for page_pool_page_is_pp()?
>>>>>>> That would require moving all the definitions introduced in patch 2,
>>>>>>> which I don't think is appropriate.
>
> The patch at the bottom moves page_pool_page_is_pp() to mm.h and compiles.
> The macros and the function use mm=E2=80=99s page->pp_magic, so I am not =
sure
> why it is appropriate, especially the user of the macros, net/core/page_p=
ool.c,
> has already included mm.h.

Well, I kinda considered those details page_pool-internal. But okay, I
can move them if you prefer to have them in mm.h.

-Toke


