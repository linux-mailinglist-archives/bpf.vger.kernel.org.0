Return-Path: <bpf+bounces-55070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F17FA77A5D
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 14:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EAF168572
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 12:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82463202C53;
	Tue,  1 Apr 2025 12:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvk6MeDm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D8A1FE45A;
	Tue,  1 Apr 2025 12:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743509193; cv=none; b=pvQ9iy7OzV4yfWHyBQDyeWMn/fBnZGcen1MUlgG075bJbgbT5y7jqEObTOl+W9RiOjoxNnqoqz5uktJseO9RsTuVwl71RSDtFSs9UUqw7TIjJIhsWhfAavu8MSjz+vvjshlpJP67KX9ZwnRDgRLuHkr6fiy5D9CoBs5F5msaUfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743509193; c=relaxed/simple;
	bh=CRnBBfKiBkAb3cUjNA/B/iRx981Mv9LKsxYmj/RNlLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K51audv3LbEXo6dkavC60eynzpug2o+vbmRhT2vWvA4rUrQs0ZUnHM8Nd/YxBuR0tKf0D5Byu9tXt0bc/mr1I+TTkLDTEvGsrL+Hp4yP4WHHllZe5DPzm4keb0+/GjC9cfHNfzgV51r9X6Dy7TcEMNOHhVjPdRXv+qV3sShACdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvk6MeDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873B7C4CEE8;
	Tue,  1 Apr 2025 12:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743509192;
	bh=CRnBBfKiBkAb3cUjNA/B/iRx981Mv9LKsxYmj/RNlLg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Rvk6MeDmK63GVH1XIKwWav2P0xogDfvBhfKwxzdVK6jV9c6lqX65/5gq4thADkGQQ
	 Y5/1iOtGYYAKIUR2fPrWt8ROBvqIaCe3jParFA3J9dN+BHHUNxuYUdHm/nGss3Kuyb
	 Trp6v852VqT+CHxtuD7Ft55WHV9zOex4j1gsLqkGLBQ2dEFUI0ezOe6v7vD0+5ORin
	 ZZwUKAoYDDtmjeazbjJRchVKFzzCLHM8abTtPJ1H2Wdwu50YdkT0Z9Lq1uzblisMdi
	 kwRxpRC/Bk9YTdUFM3y2vit21MPUCuUWwDxbNpVg+OVgGKjW2rSKJhJ+FRk42i5rZ4
	 3NJvnlwr84GAw==
Message-ID: <dcecccee-f780-4114-a957-275757f4235d@kernel.org>
Date: Tue, 1 Apr 2025 14:06:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Pavel Begunkov <asml.silence@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
 Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
 <7488e6cf-e68b-4404-aaa9-f4892b2ff94b@redhat.com>
 <6d1e3c98-e28e-4d30-bff5-1dada745f722@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <6d1e3c98-e28e-4d30-bff5-1dada745f722@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 01/04/2025 11.51, Pavel Begunkov wrote:
> On 4/1/25 09:56, Paolo Abeni wrote:
>> On 3/31/25 6:35 PM, Alexander Lobakin wrote:
>>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>> Date: Fri, 28 Mar 2025 13:19:09 +0100
>>>
>>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>>> they are released from the pool, to avoid the overhead of re-mapping 
>>>> the
>>>> pages every time they are used. This causes resource leaks and/or
>>>> crashes when there are pages still outstanding while the device is torn
>>>> down, because page_pool will attempt an unmap through a non-existent 
>>>> DMA
>>>> device on the subsequent page return.
>>>
>>> [...]
>>>
>>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>>       int cpuid;
>>>>       u32 pages_state_hold_cnt;
>>>> -    bool has_init_callback:1;    /* slow::init_callback is set */
>>>> +    bool dma_sync;            /* Perform DMA sync for device */
>>>
>>> Have you seen my comment under v3 (sorry but I missed that there was v4
>>> already)? Can't we just test the bit atomically?
>>
>> My understanding is that to make such operation really atomic, we will
>> need to access all the other bits within the same bitfield with atomic
>> bit ops, leading to a significant code churn (and possibly some 
>> overhead).
>>
>> I think that using a full bool field is a better option.
> 
> I agree, it's better not to overcomplicate a fix, and we can always
> return to it later.

I also agree. No need to do atomic bit operations.
Let's not complicate the code because we can.
I prefer keeping code readable.

--Jesper

