Return-Path: <bpf+bounces-55143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF488A78D4D
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 13:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E28F3B20F2
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF3D238172;
	Wed,  2 Apr 2025 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT3Gl7E2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E620236451;
	Wed,  2 Apr 2025 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743593953; cv=none; b=KHNt36HkuwC0ydNqrn1Zv97aFza50GNuJ3N37bdYrA6W49uaUj9vIiIKAv28RtgbiePtspuK7RryKBt9i+UnzAWEYawYawUQuDnDZD1htbyrj/2vE2b9GCkUK9gacg34Ho2NEtYhCvbbS8wr7PAel5mWlIcEKIe0WtqHE9yy2eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743593953; c=relaxed/simple;
	bh=8XKoDvfo8v/zPSCYrrN1wH1gLYamNkwyEienHdHA5hY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bt/4OG8EBIgBNmA8N9/A44AskQWFhM/opCFQ0DMDnrNqZNE8WLYDlGHb+XW/bizCO7+bySdThdPaOXJvO0uHOPdEiYflD5BagkM6+y4453btc/s3rYkit6pMpYJWyvkr7TYjderMcctIEW+Pi7Y2FUmLkLBc1k65Ifq2GMURPw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT3Gl7E2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac3eb3fdd2eso1200476766b.0;
        Wed, 02 Apr 2025 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743593949; x=1744198749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s0qzc5GVXuSt6bU4NYxI3jol0L+9rn5+w5SAhFRWk6w=;
        b=PT3Gl7E2NJYHpwqXU43iesEEzk8uaxhS7B7YgSOPSkFHR9n1FldjZ/HPWCOHRH+yjj
         elVRk9Ghg2DusTBcfXzX6dY5IlS4cjHQyAuBlzXfNZMjN0mdYNPeOWosbeB+0rsEP3FZ
         3cfIBbW21F/f4L2VB+u5LNqZAoIgGaT7x/+KQ1ZqSur5XgMriuE4ZEoCrLuVOLnaNChm
         tjS5UCiXDwgZjd81rJqyfLc4/a2iLWyl0hQGtUJvu7JTBrVpecgA1kDodrPjAqe12nzT
         MRTSiopRIVdGq26UvE3FnJqqIJMPyEPRx77tCp24gnHoKRNoMIJoNcBXPpc+PbSrLEz7
         GP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743593949; x=1744198749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s0qzc5GVXuSt6bU4NYxI3jol0L+9rn5+w5SAhFRWk6w=;
        b=otp/7ljakRJad2iy4lrnKjK3zBH91/CUgSeVi1g+oFTevP1DGH3L2xWozNWiBPtd0p
         o4zSQe2k0Dvg1vF6Asqwk3h3tYB645ZoFsrUbbhaXnWIM6LTNDSMlKPlGiVTlTrnBsev
         v+95P96Q6Szn8BPEh+vY55UEI5HAkiVMmkMtim8HRCTCemNT87MOz1m7XmQ2nuuUH2Nb
         ilnkjgW+oQ1XG8qqiwikU1IN26R9fk1fr4rzNPfB75Rzd/szpU2Wxnsyh4L9xO00HcLc
         uajGDNM8hZIMVTs/z+oGf8e6v1g7p/LjayT4dJ0Bx5NlgPpacbID0pPt5NIWWDvEWLAm
         UExQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN5qD82x3alYcx4MSZZNGtnbrgDIGFiXCj4ioVIs25qY+PXpaJR6RCvFaYKOKogkBRups=@vger.kernel.org, AJvYcCX9nxw8c46CIs59rAjSefjuh+bAlrGQc2Fs6fqlStdxKvMzLNB9dXpRszKU3WCTE+KxsyGdg7GIV9dgog==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzx+ubara+uyssZKGjZn8q1Dxh4+Pw3dFakTBpYmIkJ5sjUj3N
	ClnuAh+MiepXNsU6KVs9+tde3sYX2zhvtM+GPvIgzRTXGgJ4GrDq
X-Gm-Gg: ASbGnctqCxu8OhN0mK8JladEGka1d65ucAKzm49mfchvN2R8MJfcQ/QWXSMuo9Sj33o
	hz6f9TytdcMXpPVoZfcNvP9gka93uFxFhDyHN2uW990l8UicY33io+hV5L9JpLnAySCPqXSm4KS
	QUJtJWEGBmXcw5HxE2Sjdg6dEyPvMa/Jh1QiKzhk10tHuLtNzIATl5oxyuXY6pc54ppmkH5Cy8G
	Qi4m6QLIw8D53fiUDM6esPZxQLCHX5nUzgi/DHD4nbg1He9JAVyJWLMypwkjge7auF6M8aQxnQs
	gLEPi53uyjWuNJfwrxezUXOBzNXXulOwXNM5Ghgo6Rbd3gsaRE3L39Y=
X-Google-Smtp-Source: AGHT+IH98micgWE/G7YD/wxn1wqCl92PnyTlyppPlmkUIG29k9jKNXnGuQCcoeX2OOyYg+ci5URgfw==
X-Received: by 2002:a17:907:9629:b0:ac3:cc0e:90e5 with SMTP id a640c23a62f3a-ac782be4287mr524643266b.30.1743593949111;
        Wed, 02 Apr 2025 04:39:09 -0700 (PDT)
Received: from [192.168.8.100] ([148.252.140.143])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922bb92sm914833466b.12.2025.04.02.04.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 04:39:02 -0700 (PDT)
Message-ID: <2c5821c8-0ba5-42a3-bcdd-330d8ef736d0@gmail.com>
Date: Wed, 2 Apr 2025 12:40:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-mm@kvack.org, Qiuling Ren <qren@redhat.com>,
 Yuying Ma <yuma@redhat.com>
References: <20250401-page-pool-track-dma-v6-0-8b83474870d4@redhat.com>
 <20250401-page-pool-track-dma-v6-2-8b83474870d4@redhat.com>
 <3e0eb1fa-b501-4573-be9f-3d8e52593f75@gmail.com> <87jz82n7j3.fsf@toke.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <87jz82n7j3.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/2/25 12:10, Toke Høiland-Jørgensen wrote:
> Pavel Begunkov <asml.silence@gmail.com> writes:
> 
>> On 4/1/25 10:27, Toke Høiland-Jørgensen wrote:
>> ...
>>> Reported-by: Yonglong Liu <liuyonglong@huawei.com>
>>> Closes: https://lore.kernel.org/r/8743264a-9700-4227-a556-5f931c720211@huawei.com
>>> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
>>> Suggested-by: Mina Almasry <almasrymina@google.com>
>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Tested-by: Qiuling Ren <qren@redhat.com>
>>> Tested-by: Yuying Ma <yuma@redhat.com>
>>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>
>> I haven't looked into the bit carving, but the rest looks
>> good to me. A few nits below,
>>
>> ...
>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>> index 7745ad924ae2d801580a6760eba9393e1cf67b01..52b5ddab7ecb405066fd55b8d61abfd4186b9dcf 100644
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -227,6 +227,8 @@ static int page_pool_init(struct page_pool *pool,
>>>    			return -EINVAL;
>>>    
>>>    		pool->dma_map = true;
>>> +
>>> +		xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);
>>
>> nit: might be better to init/destroy unconditionally, it doesn't
>> allocate any memory.
> 
> Hmm, yeah, suppose both could work; I do think this makes it clearer
> that it's tied to DMA mapping, but I won't insist. Not sure it's worth
> respinning just for this, though (see below).

That's a somewhat safer way, but yes, I agree, it's not worth of
a respin.

> 
>>>    	}
>>>    
>>>    	if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
>>> @@ -276,9 +278,6 @@ static int page_pool_init(struct page_pool *pool,
>>>    	/* Driver calling page_pool_create() also call page_pool_destroy() */
>>>    	refcount_set(&pool->user_cnt, 1);
>>>    
>>> -	if (pool->dma_map)
>>> -		get_device(pool->p.dev);
>>> -
>>>    	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
>>>    		netdev_assert_locked(pool->slow.netdev);
>>>    		rxq = __netif_get_rx_queue(pool->slow.netdev,
>>> @@ -322,7 +321,7 @@ static void page_pool_uninit(struct page_pool *pool)
>>>    	ptr_ring_cleanup(&pool->ring, NULL);
>>>    
>>>    	if (pool->dma_map)
>>> -		put_device(pool->p.dev);
>>> +		xa_destroy(&pool->dma_mapped);
>>>    
>>>    #ifdef CONFIG_PAGE_POOL_STATS
>>>    	if (!pool->system)
>>> @@ -463,13 +462,21 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
>>>    			      netmem_ref netmem,
>>>    			      u32 dma_sync_size)
>>>    {
>>> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
>>> -		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
>>> +	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev)) {
>>> +		rcu_read_lock();
>>> +		/* re-check under rcu_read_lock() to sync with page_pool_scrub() */
>>> +		if (READ_ONCE(pool->dma_sync))
>>> +			__page_pool_dma_sync_for_device(pool, netmem,
>>> +							dma_sync_size);
>>> +		rcu_read_unlock();
>>> +	}
>>>    }
>>>    
>>> -static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
>>> +static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
>>>    {
>>>    	dma_addr_t dma;
>>> +	int err;
>>> +	u32 id;
>>>    
>>>    	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
>>>    	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
>>> @@ -483,15 +490,28 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
>>>    	if (dma_mapping_error(pool->p.dev, dma))
>>>    		return false;
>>>    
>>> -	if (page_pool_set_dma_addr_netmem(netmem, dma))
>>> +	if (in_softirq())
>>> +		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
>>> +			       PP_DMA_INDEX_LIMIT, gfp);
>>> +	else
>>> +		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
>>> +				  PP_DMA_INDEX_LIMIT, gfp);
>>
>> Is it an optimisation? bh disable should be reentrable and could
>> just be xa_alloc_bh().
> 
> Yeah, it's an optimisation. We do the same thing in
> page_pool_recycle_in_ring(), so I just kept the same pattern.

Got it

> 
>> KERN_{NOTICE,INFO} Maybe?
> 
> Erm? Was this supposed to be part of the comment below?

Oops, yes, that's for the warning below

>>> +	if (err) {
>>> +		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");
>>
>> That can happen with enough memory pressure, I don't think
>> it should be a warning. Maybe some pr_info?
> 
> So my reasoning here was that this code is only called in the alloc
> path, so if we're under memory pressure, the page allocation itself
> should fail before the xarray alloc does. And if it doesn't (i.e., if
> the use of xarray itself causes allocation failures), we really want to
> know about it so we can change things. Hence the loud warning.

There is a gap between allocations, one doesn't guarantee
another. I'd say the mental test here is whether we can reasonably
cause it from user space (including by abusive users), because crash
on warning setups exist, and it'll let you know about itself too
loudly, when it could've been tolerated just fine. Not going to
insist though.

> @maintainers, given the comments above I'm not going to respin for this
> unless you tell me to, but let me know! :)
> 
> -Toke
> 

-- 
Pavel Begunkov


