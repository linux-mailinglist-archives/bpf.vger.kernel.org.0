Return-Path: <bpf+bounces-40395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E5D9881D2
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 11:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6FC285A25
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A031BB680;
	Fri, 27 Sep 2024 09:49:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC27186E58;
	Fri, 27 Sep 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430592; cv=none; b=naRQxzwDgm7grhk+rUTCYnnFssQ4nKJU1K+AuWbUuxQm6VVF9hoECEq5a+C9J/GhzksiaWDTa6vON/jfCPuvVdhxm0va5E0WwSEUKXvU1Wd2ZsFwVaoObXCgoedFEu2FjxfgoM31KPlAETiTo7A/P6vcFkYDf7s9UGCa//NkMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430592; c=relaxed/simple;
	bh=NC7KgdCdhPtOVGJUsIpjLuEb6Y2Xbx97UfH4DLBwsg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yc9bd2d9+jgx+C4RTyhSfCdMxIdyVPEe+Z/cNK0XAMX+rYrr5sy4MQNCcj3OGddw1PdeXTgGp+65gNg0VlmtMyXFDaWCQaPLhdbwVOM+D3kqMOA/v9Ii9LiCbn7jOc2hXub94jqOzxcgEx7zI17xjeb8ItF38UlMO7QEcwFAesE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XFQZN2v7qz1HKJ6;
	Fri, 27 Sep 2024 17:45:48 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AC2018002B;
	Fri, 27 Sep 2024 17:49:41 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 27 Sep 2024 17:49:40 +0800
Message-ID: <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com>
Date: Fri, 27 Sep 2024 17:49:40 +0800
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
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/27 17:21, Ilias Apalodimas wrote:
> Hi Yunsheng
> 
> On Fri, 27 Sept 2024 at 06:58, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/9/27 2:15, Mina Almasry wrote:
>>>
>>>> In order not to do the dma unmmapping after driver has already
>>>> unbound and stall the unloading of the networking driver, add
>>>> the pool->items array to record all the pages including the ones
>>>> which are handed over to network stack, so the page_pool can
>>>> do the dma unmmapping for those pages when page_pool_destroy()
>>>> is called.
>>>
>>> One thing I could not understand from looking at the code: if the
>>> items array is in the struct page_pool, why do you need to modify the
>>> page_pool entry in the struct page and in the struct net_iov? I think
>>> the code could be made much simpler if you can remove these changes,
>>> and you wouldn't need to modify the public api of the page_pool.
>>
>> As mentioned in [1]:
>> "There is no space in 'struct page' to track the inflight pages, so
>> 'pp' in 'struct page' is renamed to 'pp_item' to enable the tracking
>> of inflight page"
> 
> I have the same feeling as Mina here. First of all, we do have an
> unsigned long in struct page we use for padding IIRC. More

I am assuming you are referring to '_pp_mapping_pad' in 'struct page',
unfortunately the field might be used when a page is mmap'ed to user
space as my understanding.

https://elixir.bootlin.com/linux/v6.7-rc8/source/include/linux/mm_types.h#L126

> importantly, though, why does struct page need to know about this?
> Can't we have the same information in page pool?
> When the driver allocates pages it does via page_pool_dev_alloc_XXXXX
> or something similar. Cant we do what you suggest here ? IOW when we
> allocate a page we put it in a list, and when that page returns to
> page_pool (and it's mapped) we remove it.

Yes, that is the basic idea, but the important part is how to do that
with less performance impact.

