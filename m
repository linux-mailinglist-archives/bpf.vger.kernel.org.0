Return-Path: <bpf+bounces-55056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF91DA777A1
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 11:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0216789C
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 09:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B391EE7AB;
	Tue,  1 Apr 2025 09:24:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB4E1E8329;
	Tue,  1 Apr 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743499490; cv=none; b=tz8rMnQsIgGwwcnp3yh0r7t+MEfhxLNu00A8oYnUzVuLY1idJ3hBkNru3KfJHVHuucYK8qhGvHmvqEjsG6xBCG3Ge5YUG7MjDP0LxW8Hc2qjfKUX1QTIkiUIjoIqY6eDvOQnLXVe7d78bUSI2mrCjXFjNUcQ6M0exOxtP9msz1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743499490; c=relaxed/simple;
	bh=YJe+5k/IbiLgySfuYIrcy0ukBJS+OJdrxR9fS3/iHlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QZLPN/UhIKVUiHRTggUnTuSeJ+Ti2dQBt3T2JLuPe35SubSrT6cb3xZl0rVUR9No+hY0SMfS/E+6rdplML8dC+5J1xW+zBgawpIFByEeLarv9IXsejO5QMySSHKxoXhQEUFdRJszHfs0PsOR/zZpE0EMjYrjo/n6xvlqXWOWclo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZRjBj1T7pz1k1BR;
	Tue,  1 Apr 2025 17:19:57 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D5CC1400F4;
	Tue,  1 Apr 2025 17:24:44 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 1 Apr 2025 17:24:43 +0800
Message-ID: <b87a14f4-181b-4a82-9d71-2750699601d6@huawei.com>
Date: Tue, 1 Apr 2025 17:24:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/2] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
To: Zhu Yanjun <yanjun.zhu@linux.dev>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
	<toke@redhat.com>
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
References: <20250328-page-pool-track-dma-v5-0-55002af683ad@redhat.com>
 <20250328-page-pool-track-dma-v5-2-55002af683ad@redhat.com>
 <aaf31c50-9b57-40b7-bbd7-e19171370563@intel.com>
 <b75c5329-0049-4c9c-ba79-a1132d848d5d@linux.dev>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <b75c5329-0049-4c9c-ba79-a1132d848d5d@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/4/1 1:27, Zhu Yanjun wrote:
> 在 2025/3/31 18:35, Alexander Lobakin 写道:
>> From: Toke Høiland-Jørgensen <toke@redhat.com>
>> Date: Fri, 28 Mar 2025 13:19:09 +0100
>>
>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>> they are released from the pool, to avoid the overhead of re-mapping the
>>> pages every time they are used. This causes resource leaks and/or
>>> crashes when there are pages still outstanding while the device is torn
>>> down, because page_pool will attempt an unmap through a non-existent DMA
>>> device on the subsequent page return.
>>
>> [...]
>>
>>> @@ -173,10 +212,10 @@ struct page_pool {
>>>       int cpuid;
>>>       u32 pages_state_hold_cnt;
>>>   -    bool has_init_callback:1;    /* slow::init_callback is set */
>>> +    bool dma_sync;            /* Perform DMA sync for device */
>>
>> Have you seen my comment under v3 (sorry but I missed that there was v4
>> already)? Can't we just test the bit atomically?
> 
> Perhaps test_bit series functions can test the bit atomically. Maybe there are more good options about this testing the bit atomically. But test_bit should implement the task that tests the bit atomically.

There are two reading of dma_sync in this patch, the first reading is not
under rcu read lock and doing the reading without READ_ONCE(), the second
reading is under rcu read lock and do the reading with READ_ONCE().

The first one seems an optimization to avoid taking the rcu read lock,
why might need READ_ONCE() to make KCSAN happy if we do care about making
KCSAN happy.

The second one does not seems to need the atomicity by using the READ_ONCE()
as it is always under RCU read lock(implicit or explicit one), and there is
a rcu sync after the clearing of that bit.

