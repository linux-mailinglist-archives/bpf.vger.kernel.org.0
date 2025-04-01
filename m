Return-Path: <bpf+bounces-55065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9638A77872
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 12:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C816B5FB
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440201F03EB;
	Tue,  1 Apr 2025 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg1FpGOo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EE386353;
	Tue,  1 Apr 2025 10:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743502085; cv=none; b=i1tzD8+LTAdrgHXT/N+WYgWmiBs6zuWHqBB5LUZLIB5iZ6AQNs6qnjaOQiOqU7492/C3dxyj3qgVUxZGgQ9j+UyNZNmL/DD7fGsd3usNr7VWDvRSnGoc8A2p/X+di3Bw4womE7AZlnChswaCo0Jivo0Ecfrdhc2Fs1aqaSvxfjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743502085; c=relaxed/simple;
	bh=CELKhvkFEiUrmJynhhVfj+XrYDMu8ssFMEF7wYKF7AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egTl9+/4r8rXyUmD2R3U7bWtfnDPz7mAbCFzP0MYPzOpWXqhFuOHAqhWE7Z/NhxvyPxHKlu6LJ7spGSPIDkPHa3r4/ktWTbgdLKYN4I7RtrUdTfBc0Jz9T/KPb0VTuKXu4U8DxOyWBr4V1sgRb6DqDmSRTBEQjwWjGng9HWOtd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg1FpGOo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abbd96bef64so875075866b.3;
        Tue, 01 Apr 2025 03:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743502082; x=1744106882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fYH+2FNA8rvv9alcK9f9QT7dB4gXsn+f8xBysj3Cjuc=;
        b=kg1FpGOok1CHMTJ6w5ZSH2xIkV02IxGcU+By8iRJ4EFIXd0+f5IQmPxHbhdvWnm86Q
         hU/Eov99FEZntwhgiW4yB9psL13jPr6p2j2PHH9rYGo8NUMRXLoBhGjAXYdqaiezhfwd
         c8SrAClbMSrMgyA9LmrTDhL/8snAtzf7aAvqOSWG9GhnYt8pZJkudVMVokQsE5iQPBQd
         NRt6+IB/e8S4RTuUBovuwgVZqKPK11S1lulLibP0p+HB6pL43DsNTEvTm/5X/1I3aTXL
         NtLGDnpVsK/srKz+Z1OGqm4geqHJCd+8ZSY1o9Z1j8feQFdDWE0i/E7dlGW9P5dURoCH
         jg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743502082; x=1744106882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYH+2FNA8rvv9alcK9f9QT7dB4gXsn+f8xBysj3Cjuc=;
        b=QH7h2uQx7fbSN/p8KZorV1tRr8/RsLUSW8wfonYVGICYShwrR63lNrNEm0rHwwjcMn
         +ooW+OI0YVtv04zYP+k9qEgwTNMjGfyacz25pexQTUkdqjgmZ7tp5zdYDAF/rHot+VJu
         oKoBmttrQh6nkC/pK5GgNOyakETk76hKmtFvSZOCPJn0UUh4lLqZoNZ4ZSuRfpjCOy8a
         PZ15F/K/imc1fZQsdUyb9nZidBSQ94mhM6cZ31BR2b8tnNmWrb/fX8j4Ykw0RGXrqxCy
         TuClyS/UDb8/WsgUFbKsW1l8ATT1TbEChZuAFdEMSzdSqMWl4p2x9TPId0ukasRhhJpo
         7BUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLXgU0kgGoRipw+BBU3BYuoAsXx1LKjpGbJTkIcP7hOlYbvfHlNcgIEjYHKGCqDGc1XnGxkoFY7GbDAQ==@vger.kernel.org, AJvYcCVqgVlYsStvg1iCYC2xpKd2d2iwLX/qzuhj/H7dR7gxJ7ldfYByazbCgZNtYQ/CF3SfCzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvatSc9wGMg/bkO9qgBThlRNA2dctxBxr44st7Y4F6YJmhWwWC
	S1eI07WpYTwphOw1nJzG4qLm62MMILa7hnHlhSMvDq1pajj7jk8d
X-Gm-Gg: ASbGncvC/QJ1DpItn9+ADZC0ATpe3DGlUBTTfju8R9Uptbs9eHSUDVw/0Ud6JFnHPGY
	uWTTusuEJheJAa18wla0Cgqb0clJs4XJU/jHjGB5ZPqpfKHAuvTXYn5EHzuDUkgzQ2oSDt6aiQz
	UiNzNCmuAwqBd3uufyva4Nqm9Tfp78C8k23i/qb6/2EHOg/JkH8VFva2+KcncIWxhAX4g/CTBNb
	Ch+3S6vPz/3aU9J4ECPaNc67S1cNsGOujQNeM5B7dldf4iGka4N9coGC3ale6TCMuUJWC/cZiyH
	gnK+V9WfihkZdEm8UpfFkVtK7ijIs9+h7RMDQj9hz5XMtkK6C+69a+g3v6JijxxLa1Q=
X-Google-Smtp-Source: AGHT+IHeaB4+CbuAMNTM2JJK6YjWQ8XZ2QNM7iV6Hl/13rCtW5kfhBjuwqGhAcx528XHoq9o7CWlDQ==
X-Received: by 2002:a17:906:d553:b0:abf:6264:a624 with SMTP id a640c23a62f3a-ac738a8ea3amr1048949466b.32.1743502081894;
        Tue, 01 Apr 2025 03:08:01 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::83? ([2620:10d:c092:600::1:2418])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196e954csm750929066b.171.2025.04.01.03.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 03:08:01 -0700 (PDT)
Message-ID: <3e0eb1fa-b501-4573-be9f-3d8e52593f75@gmail.com>
Date: Tue, 1 Apr 2025 11:09:20 +0100
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
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20250401-page-pool-track-dma-v6-2-8b83474870d4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/1/25 10:27, Toke Høiland-Jørgensen wrote:
...
> Reported-by: Yonglong Liu <liuyonglong@huawei.com>
> Closes: https://lore.kernel.org/r/8743264a-9700-4227-a556-5f931c720211@huawei.com
> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Tested-by: Qiuling Ren <qren@redhat.com>
> Tested-by: Yuying Ma <yuma@redhat.com>
> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>

I haven't looked into the bit carving, but the rest looks
good to me. A few nits below,

...
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index 7745ad924ae2d801580a6760eba9393e1cf67b01..52b5ddab7ecb405066fd55b8d61abfd4186b9dcf 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -227,6 +227,8 @@ static int page_pool_init(struct page_pool *pool,
>   			return -EINVAL;
>   
>   		pool->dma_map = true;
> +
> +		xa_init_flags(&pool->dma_mapped, XA_FLAGS_ALLOC1);

nit: might be better to init/destroy unconditionally, it doesn't
allocate any memory.

>   	}
>   
>   	if (pool->slow.flags & PP_FLAG_DMA_SYNC_DEV) {
> @@ -276,9 +278,6 @@ static int page_pool_init(struct page_pool *pool,
>   	/* Driver calling page_pool_create() also call page_pool_destroy() */
>   	refcount_set(&pool->user_cnt, 1);
>   
> -	if (pool->dma_map)
> -		get_device(pool->p.dev);
> -
>   	if (pool->slow.flags & PP_FLAG_ALLOW_UNREADABLE_NETMEM) {
>   		netdev_assert_locked(pool->slow.netdev);
>   		rxq = __netif_get_rx_queue(pool->slow.netdev,
> @@ -322,7 +321,7 @@ static void page_pool_uninit(struct page_pool *pool)
>   	ptr_ring_cleanup(&pool->ring, NULL);
>   
>   	if (pool->dma_map)
> -		put_device(pool->p.dev);
> +		xa_destroy(&pool->dma_mapped);
>   
>   #ifdef CONFIG_PAGE_POOL_STATS
>   	if (!pool->system)
> @@ -463,13 +462,21 @@ page_pool_dma_sync_for_device(const struct page_pool *pool,
>   			      netmem_ref netmem,
>   			      u32 dma_sync_size)
>   {
> -	if (pool->dma_sync && dma_dev_need_sync(pool->p.dev))
> -		__page_pool_dma_sync_for_device(pool, netmem, dma_sync_size);
> +	if (READ_ONCE(pool->dma_sync) && dma_dev_need_sync(pool->p.dev)) {
> +		rcu_read_lock();
> +		/* re-check under rcu_read_lock() to sync with page_pool_scrub() */
> +		if (READ_ONCE(pool->dma_sync))
> +			__page_pool_dma_sync_for_device(pool, netmem,
> +							dma_sync_size);
> +		rcu_read_unlock();
> +	}
>   }
>   
> -static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
> +static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem, gfp_t gfp)
>   {
>   	dma_addr_t dma;
> +	int err;
> +	u32 id;
>   
>   	/* Setup DMA mapping: use 'struct page' area for storing DMA-addr
>   	 * since dma_addr_t can be either 32 or 64 bits and does not always fit
> @@ -483,15 +490,28 @@ static bool page_pool_dma_map(struct page_pool *pool, netmem_ref netmem)
>   	if (dma_mapping_error(pool->p.dev, dma))
>   		return false;
>   
> -	if (page_pool_set_dma_addr_netmem(netmem, dma))
> +	if (in_softirq())
> +		err = xa_alloc(&pool->dma_mapped, &id, netmem_to_page(netmem),
> +			       PP_DMA_INDEX_LIMIT, gfp);
> +	else
> +		err = xa_alloc_bh(&pool->dma_mapped, &id, netmem_to_page(netmem),
> +				  PP_DMA_INDEX_LIMIT, gfp);

Is it an optimisation? bh disable should be reentrable and could
just be xa_alloc_bh(). KERN_{NOTICE,INFO} Maybe?


> +	if (err) {
> +		WARN_ONCE(1, "couldn't track DMA mapping, please report to netdev@");

That can happen with enough memory pressure, I don't think
it should be a warning. Maybe some pr_info?

>   		goto unmap_failed;
> +	}
>   
> +	if (page_pool_set_dma_addr_netmem(netmem, dma)) {
> +		WARN_ONCE(1, "unexpected DMA address, please report to netdev@");
> +		goto unmap_failed;
> +	}
> +
> +	netmem_set_dma_index(netmem, id);
>   	page_pool_dma_sync_for_device(pool, netmem, pool->p.max_len);
>   
>   	return true;


-- 
Pavel Begunkov


