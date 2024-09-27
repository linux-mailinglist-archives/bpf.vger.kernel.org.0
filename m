Return-Path: <bpf+bounces-40406-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 636BD988356
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 13:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED67281EE0
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E9218A6CF;
	Fri, 27 Sep 2024 11:29:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661A5189F30;
	Fri, 27 Sep 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436569; cv=none; b=FytpElvM2GLVLzkFeUt1Bdj1J9rJ0U4D0x76RRx06e5+K4IL5jX+tSIJEnFIS8p9770YCSnoiFQXqj0JSk0yk3k5NsSKKohowVP6fRvQ5Gm8rxrkNMsunU65qjecfgKUXN5EGr2kqA6POEsBubViGIsXJiVy1HFJibRX3Pfaecc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436569; c=relaxed/simple;
	bh=twZds9HQiXC8rqIENp9Zeg9QsE2L5YC73SAywwLcVws=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WE5n6KGW9tGrzI3neFRk5mclPWLi3fNSnMfy1zooTpj/bKxdJRMLTwnUqldLlkpWHHvnbnfvwghdW/S9VaycUSwqY65XhetPhgbe460dJV5TpMCJJMyDzrQ+uv99kzP/nSc5oxlz3GDKVuZ836v3uxY11pPmntjF1dVtUbRxGlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XFSrx2nMcz2QTtc;
	Fri, 27 Sep 2024 19:28:33 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2ACA31A016C;
	Fri, 27 Sep 2024 19:29:23 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Sep 2024 19:29:22 +0800
Message-ID: <934d601f-be43-4e04-b126-dc86890a4bfa@huawei.com>
Date: Fri, 27 Sep 2024 19:29:22 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: Mina Almasry <almasrymina@google.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <liuyonglong@huawei.com>,
	<fanghaiqing@huawei.com>, <zhangkun09@huawei.com>, Robin Murphy
	<robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, IOMMU
	<iommu@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet
	<edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, Kalle Valo
	<kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Andrew
 Morton <akpm@linux-foundation.org>, <imx@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <bpf@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-mm@kvack.org>
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com>
 <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com>
 <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
 <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com>
 <CAC_iWjKeajwn3otjdEekE6VDLHGEvqmnQRwpN5R3yHj8UpEiDw@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAC_iWjKeajwn3otjdEekE6VDLHGEvqmnQRwpN5R3yHj8UpEiDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/27 17:58, Ilias Apalodimas wrote:

...

>>
>>> importantly, though, why does struct page need to know about this?
>>> Can't we have the same information in page pool?
>>> When the driver allocates pages it does via page_pool_dev_alloc_XXXXX
>>> or something similar. Cant we do what you suggest here ? IOW when we
>>> allocate a page we put it in a list, and when that page returns to
>>> page_pool (and it's mapped) we remove it.
>>
>> Yes, that is the basic idea, but the important part is how to do that
>> with less performance impact.
> 
> Yes, but do you think that keeping that list of allocated pages in
> struct page_pool will end up being more costly somehow compared to
> struct page?

I am not sure if I understand your above question here.
I am supposing the question is about what's the cost between using
single/doubly linked list for the inflight pages or using a array
for the inflight pages like this patch does using pool->items?
If I understand question correctly, the single/doubly linked list
is more costly than array as the page_pool case as my understanding.

For single linked list, it doesn't allow deleting a specific entry but
only support deleting the first entry and all the entries. It does support
lockless operation using llist, but have limitation as below:
https://elixir.bootlin.com/linux/v6.7-rc8/source/include/linux/llist.h#L13

For doubly linked list, it needs two pointer to support deleting a specific
entry and it does not support lockless operation.

For pool->items, as the alloc side is protected by NAPI context, and the
free side use item->pp_idx to ensure there is only one producer for each
item, which means for each item in pool->items, there is only one consumer
and one producer, which seems much like the case when the page is not
recyclable in __page_pool_put_page, we don't need a lock protection when
calling page_pool_return_page(), the 'struct page' is also one consumer
and one producer as the pool->items[item->pp_idx] does:
https://elixir.bootlin.com/linux/v6.7-rc8/source/net/core/page_pool.c#L645

We only need a lock protection when page_pool_destroy() is called to
check if there is inflight page to be unmapped as a consumer, and the
__page_pool_put_page() may also called to unmapped the inflight page as
another consumer, there is why the 'destroy_lock' is added for protection
when pool->destroy_cnt > 0.

> 
> Thanks
> /Ilias

