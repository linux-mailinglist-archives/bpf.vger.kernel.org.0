Return-Path: <bpf+bounces-55394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 946E0A7DC39
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 13:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB8517958E
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 11:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED1723BD11;
	Mon,  7 Apr 2025 11:26:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166A834CF5;
	Mon,  7 Apr 2025 11:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025201; cv=none; b=PGB+pIP3AX7P9vRHpHtptc6NWI/K8xPCH5yD0rccdauZysk+V6/6Yus/s7icbWhsBSj4euuj4y9I8XlewCiDMv1Q4RCjyy5s51Kc1L55OL41PeysrTon/ofo2yAl6vpvMX/ARRdbG2oxSLDUE45T9Y1KPOUfaM3cVgvlemTWlec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025201; c=relaxed/simple;
	bh=krCg3q+Rdne0AukVsfCjmNkRRGzLMURY60aNhEFb0/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gAN3AXEMyAJuTHmee1B49sppJr8NmUbbN+vtfvPGTT9H+ONja2Ja8GuFvuva2PqhjQK+tsF/E8G4SZ5no60ndU9EUbSNosbiT/6wi4Q0wiBeGQaBdI+k3R3NIU54DZSwyYdusjR2cPZlaL8kxn6gfQWeZfyhnxhFOfRBEq4JuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZWRcM21ZGz1k1BJ;
	Mon,  7 Apr 2025 19:21:39 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D5CFB1400DA;
	Mon,  7 Apr 2025 19:26:33 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 7 Apr 2025 19:26:33 +0800
Message-ID: <f8bbfe7e-9935-4f4d-a9e8-b3547ed58112@huawei.com>
Date: Mon, 7 Apr 2025 19:26:33 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Simon
 Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mina
 Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>, Matthew Wilcox
	<willy@infradead.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>, Qiuling Ren
	<qren@redhat.com>, Yuying Ma <yuma@redhat.com>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-2-ad34f069bc18@redhat.com>
 <3b933890-7ff2-4aaf-aea5-06e5889ca087@intel.com>
 <d7780007-6df7-45f0-9a08-2e6acf589a6f@intel.com> <87jz7yhix3.fsf@toke.dk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <87jz7yhix3.fsf@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/4/5 20:50, Toke Høiland-Jørgensen wrote:
> Alexander Lobakin <aleksander.lobakin@intel.com> writes:
> 
>> From: Alexander Lobakin <aleksander.lobakin@intel.com>
>> Date: Fri, 4 Apr 2025 17:55:43 +0200
>>
>>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>>> Date: Fri, 04 Apr 2025 12:18:36 +0200
>>>
>>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>>> they are released from the pool, to avoid the overhead of re-mapping the
>>>> pages every time they are used. This causes resource leaks and/or
>>>> crashes when there are pages still outstanding while the device is torn
>>>> down, because page_pool will attempt an unmap through a non-existent DMA
>>>> device on the subsequent page return.
>>>
>>> [...]
>>>
>>>> -#define PP_MAGIC_MASK ~0x3UL
>>>> +#define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>  
>>>>  /**
>>>>   * struct page_pool_params - page pool parameters
>>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>>  	int cpuid;
>>>>  	u32 pages_state_hold_cnt;
>>>>  
>>>> -	bool has_init_callback:1;	/* slow::init_callback is set */
>>>> +	bool dma_sync;			/* Perform DMA sync for device */
>>>
>>> Yunsheng said this change to a full bool is redundant in the v6 thread
>>> ¯\_(ツ)_/¯
> 
> AFAIU, the comment was that the second READ_ONCE() when reading the
> field was redundant, because of the rcu_read_lock(). Which may be the
> case, but I think keeping it makes the intent of the code clearer. And
> in any case, it has nothing to do with changing the type of the field...

For changing the type of the field part, there are only two outcomes here
when using bit field here:
1. The reading returns a correct value.
2. The reading returns a incorrect value.

So the question seems to be what would possibly go wrong when the reading
return an incorrect value when there is an additional reading under the rcu
read lock and there is a rcu sync after clearing pool->dma_sync? Considering
we only need to ensure there is no dma sync API called after rcu sync.

And it seems data_race() can be used to mark the above reading so that KCSAN
will not complain.

IOW, changing the type of the field part isn't that necessary as my understanding.

