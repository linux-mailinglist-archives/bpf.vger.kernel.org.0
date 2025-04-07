Return-Path: <bpf+bounces-55410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7048A7E2B3
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 16:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6789C44352D
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8881E0E05;
	Mon,  7 Apr 2025 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpufQ4SM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC401A5BAE;
	Mon,  7 Apr 2025 14:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744037037; cv=none; b=CkmUc2Mk8pK/xcFqBholE1Uljmu+MhzcaYD2sISOyfaJbup75EnGPYPSTOrPuxY8sSAyOLgO4Z0IDgPWkM/7LtbBbTp0oMwJ9U5DfqvjQ6ZEt9SrXVXdk2HQIi19pK1tzIQqtQQtfrlyib6XwjwGchSOlzNHPa/sMKmc38JAaqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744037037; c=relaxed/simple;
	bh=qNa5SnpYvPxSF+sauTUnQwpMRyj/0mKfqIpcvOwWmbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SzNTKqDYLDYHyO9KKLSlN8g7cVf1pPIH82aJLK4lzcxzokhMk9RZ7UB0lZ8ahVRpQaTXqXdtBUzpjhj3uWxnpCpmXuMzLLmc5add+LVnp/OFQ0OEUY2X0wPE1D8Eah2QRNa6wg+tP6l+iHwUoy0BMv4Wx5x4tp7sPdFSwyHjAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpufQ4SM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC694C4CEE7;
	Mon,  7 Apr 2025 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744037037;
	bh=qNa5SnpYvPxSF+sauTUnQwpMRyj/0mKfqIpcvOwWmbw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LpufQ4SMtmAw34AH1lg4HaJpmi5uB/ITZaRXFjPtqQ5Jplj8LEJjg+voE3cdUfG+S
	 Aff6Q90IfGj5NjihzGJi/2j6vzVQWb9amgjl3th/e4b/1QRRgnT0ynXRmsTVPLHLBV
	 Fc66kZZ6DNvwLPaLfw0gzaiqid4TaVavtDVxSS/LJm+Fva+m8nzggXgUXT4xLU18Yo
	 WkoTUnJXITYzzQOMzRxNtcMyR6O3kRsa+s0KyueBzgKtHRGJcKCj92N/XX/X84bLQz
	 uDsO/MHk8D+kEiQ2o2Sr6pD8B6aINN8DBRIfBq/ik5khBvl2w4ylI6AOJjb6CJidsg
	 tqK4TWZbxsZOw==
Message-ID: <4d35bda2-d032-49db-bb6e-b1d70f10d436@kernel.org>
Date: Mon, 7 Apr 2025 16:43:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
To: Zi Yan <ziy@nvidia.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
 <willy@infradead.org>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 kernel-team <kernel-team@cloudflare.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com> <87cydoxsgs.fsf@toke.dk>
 <DF12251B-E50F-4724-A2FA-FE5AAF3E63DF@nvidia.com> <87v7rgw1us.fsf@toke.dk>
 <E9D0B5C7-B387-46A9-82CC-8F29623BFF6C@nvidia.com>
 <893B4BFD-1FDA-46DE-82D5-9E5CBDD90068@nvidia.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <893B4BFD-1FDA-46DE-82D5-9E5CBDD90068@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/04/2025 16.15, Zi Yan wrote:
> On 7 Apr 2025, at 9:36, Zi Yan wrote:
> 
>> On 7 Apr 2025, at 9:14, Toke Høiland-Jørgensen wrote:
>>
>>> Zi Yan<ziy@nvidia.com>  writes:
>>>
>>>> Resend to fix my signature.
>>>>
>>>> On 7 Apr 2025, at 4:53, Toke Høiland-Jørgensen wrote:
>>>>
>>>>> "Zi Yan"<ziy@nvidia.com>  writes:
>>>>>
>>>>>> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke Høiland-Jørgensen wrote:
>>>>>>> Since we are about to stash some more information into the pp_magic
>>>>>>> field, let's move the magic signature checks into a pair of helper
>>>>>>> functions so it can be changed in one place.
>>>>>>>
>>>>>>> Reviewed-by: Mina Almasry<almasrymina@google.com>
>>>>>>> Tested-by: Yonglong Liu<liuyonglong@huawei.com>
>>>>>>> Acked-by: Jesper Dangaard Brouer<hawk@kernel.org>
>>>>>>> Reviewed-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
>>>>>>> Signed-off-by: Toke Høiland-Jørgensen<toke@redhat.com>
>>>>>>> ---
>>>>>>>   drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>>>>>>   include/net/page_pool/types.h                    | 18 ++++++++++++++++++
>>>>>>>   mm/page_alloc.c                                  |  9 +++------
>>>>>>>   net/core/netmem_priv.h                           |  5 +++++
>>>>>>>   net/core/skbuff.c                                | 16 ++--------------
>>>>>>>   net/core/xdp.c                                   |  4 ++--
>>>>>>>   6 files changed, 32 insertions(+), 24 deletions(-)
>>>>>>>
>>>>>> <snip>
[...]

>>>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>>>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced85e0d198947be7c503526 100644
>>>>>>> --- a/mm/page_alloc.c
>>>>>>> +++ b/mm/page_alloc.c
>>>>>>> @@ -55,6 +55,7 @@
>>>>>>>   #include <linux/delayacct.h>
>>>>>>>   #include <linux/cacheinfo.h>
>>>>>>>   #include <linux/pgalloc_tag.h>
>>>>>>> +#include <net/page_pool/types.h>
>>>>>>>   #include <asm/div64.h>
>>>>>>>   #include "internal.h"
>>>>>>>   #include "shuffle.h"
>>>>>>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct page *page,
>>>>>>>   #ifdef CONFIG_MEMCG
>>>>>>>   			page->memcg_data |
>>>>>>>   #endif
>>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>>> -			((page->pp_magic & ~0x3UL) == PP_SIGNATURE) |
>>>>>>> -#endif
>>>>>>> +			page_pool_page_is_pp(page) |
>>>>>>>   			(page->flags & check_flags)))
>>>>>>>   		return false;
>>>>>>>
>>>>>>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page *page, unsigned long flags)
>>>>>>>   	if (unlikely(page->memcg_data))
>>>>>>>   		bad_reason = "page still charged to cgroup";
>>>>>>>   #endif
>>>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>>>> -	if (unlikely((page->pp_magic & ~0x3UL) == PP_SIGNATURE))
>>>>>>> +	if (unlikely(page_pool_page_is_pp(page)))
>>>>>>>   		bad_reason = "page_pool leak";
>>>>>>> -#endif
>>>>>>>   	return bad_reason;
>>>>>>>   }
>>>>>>>
>>>>>> I wonder if it is OK to make page allocation depend on page_pool from
>>>>>> net/page_pool.
>>>>> Why? It's not really a dependency, just a header include with a static
>>>>> inline function...
>>>> The function is checking, not even modifying, an core mm data structure,
>>>> struct page, which is also used by almost all subsystems. I do not get
>>>> why the function is in net subsystem.
>>> Well, because it's using details of the PP definitions, so keeping it
>>> there nicely encapsulates things. I mean, that's the whole point of
>>> defining a wrapper function - encapsulating the logic 🙂
>>>
>>>>>> Would linux/mm.h be a better place for page_pool_page_is_pp()?
>>>>> That would require moving all the definitions introduced in patch 2,
>>>>> which I don't think is appropriate.
>>>> Why? I do not see page_pool_page_is_pp() or PP_SIGNATURE is used anywhere
>>>> in patch 2.
>>> Look again. Patch 2 redefines PP_MAGIC_MASK in terms of all the other
>>> definitions.
>> OK. Just checked. Yes, the function depends on PP_MAGIC_MASK.
>>
>> But net/types.h has a lot of unrelated page_pool functions and data structures
>> mm/page_alloc.c does not care about. Is there a way of moving page_pool_page_is_pp()
>> and its dependency to a separate header and including that in mm/page_alloc.c?
>>
>> Looking at the use of page_pool_page_is_pp() in mm/page_alloc.c, it seems to be
>> just error checking. Why can't page_pool do the error checking?
 >
> Or just remove page_pool_page_is_pp() in mm/page_alloc.c. Has it really been used?

We have actually used this at Cloudflare to catch some page_pool bugs.
And this have been backported to our 6.1 and 6.6 kernels and we have
enabled needed config CONFIG_DEBUG_VM (which we measured have low enough
overhead to enable in production).  AFAIK this is also enabled for our
6.12 kernels.

--Jesper


