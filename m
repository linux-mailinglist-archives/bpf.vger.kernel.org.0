Return-Path: <bpf+bounces-40115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D1897D12F
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 08:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C5E284712
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 06:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BA41CF8B;
	Fri, 20 Sep 2024 06:30:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8A91C683;
	Fri, 20 Sep 2024 06:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726813854; cv=none; b=cnAZ3rRZtfA8jSChjAm2tAFDU2nhxeqN4oWGL2jYxElUJtsQsEotmZU5O50/g94iMA4TitPWL0IeaQEYFLYN7xIetbqTXLDDVC3Rj70S9x1eJGhd9h8AO03dJMgAgyyKxqQDBQ4dHeBsbbNRuczwgtDlHAAWEPzeSdsYO02cT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726813854; c=relaxed/simple;
	bh=pUsj6zi6XSx6GhIlGdt1Hl9sG+23RLjq3jnloPOfGSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rxDIsaTHi3kWq43/mRml/2YUdB9q/6XVJyZcbfYOnOEMi1uTbtpezOSHa3YNGc6CcCZyVewtNvSv5//QyWFnKLfJDN3h10xzcg5k4JcqMR5i+r+6fvsULmxIW4EO156J0uVbl2awpoEm+AurSY7y6NuNUYqBNzrEVDMBFLfNbtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X92BV2t0Fz2DcJj;
	Fri, 20 Sep 2024 14:13:22 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 140801401DC;
	Fri, 20 Sep 2024 14:14:03 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 20 Sep 2024 14:14:02 +0800
Message-ID: <2c5ccfff-6ab4-4aea-bff6-3679ff72cc9a@huawei.com>
Date: Fri, 20 Sep 2024 14:14:02 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<liuyonglong@huawei.com>, <fanghaiqing@huawei.com>, <zhangkun09@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck
	<alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau
	<nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee
	<ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, Sean Wang
	<sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Andrew Morton
	<akpm@linux-foundation.org>, <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<bpf@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-mm@kvack.org>
References: <20240918111826.863596-1-linyunsheng@huawei.com>
 <20240918111826.863596-3-linyunsheng@huawei.com>
 <CAC_iWjK=G7Oo5=pN2QunhasgDC6NyC1L+96jigX7u9ad+PbYng@mail.gmail.com>
 <894a3c2c-22f9-45b9-a82b-de7320066b42@kernel.org>
 <cdfecd37-31d7-42d2-a8d8-92008285b42e@huawei.com>
 <0e8c7a7a-0e2a-42ec-adbc-b29f6a514517@kernel.org>
 <CAC_iWj+3JvPY2oqVOdu0T1Wt6-ukoy=dLc72u1f55yY23uOTbA@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAC_iWj+3JvPY2oqVOdu0T1Wt6-ukoy=dLc72u1f55yY23uOTbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/9/20 13:29, Ilias Apalodimas wrote:
> Hi Jesper,
> 
> On Fri, 20 Sept 2024 at 00:04, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>>
>>
>> On 19/09/2024 13.15, Yunsheng Lin wrote:
>>> On 2024/9/19 17:42, Jesper Dangaard Brouer wrote:
>>>>
>>>> On 18/09/2024 19.06, Ilias Apalodimas wrote:
>>>>>> In order not to do the dma unmmapping after driver has already
>>>>>> unbound and stall the unloading of the networking driver, add
>>>>>> the pool->items array to record all the pages including the ones
>>>>>> which are handed over to network stack, so the page_pool can
>>>>>> do the dma unmmapping for those pages when page_pool_destroy()
>>>>>> is called.
>>>>>
>>>>> So, I was thinking of a very similar idea. But what do you mean by
>>>>> "all"? The pages that are still in caches (slow or fast) of the pool
>>>>> will be unmapped during page_pool_destroy().
>>>>
>>>> I really dislike this idea of having to keep track of all outstanding pages.
>>>>
>>>> I liked Jakub's idea of keeping the netdev around for longer.
>>>>
>>>> This is all related to destroying the struct device that have points to
>>>> the DMA engine, right?
>>>
>>> Yes, the problem seems to be that when device_del() is called, there is
>>> no guarantee hw behind the 'struct device ' will be usable even if we
>>> call get_device() on it.
>>>
>>>>
>>>> Why don't we add an API that allow netdev to "give" struct device to
>>>> page_pool.  And then the page_poll will take over when we can safely
>>>> free the stuct device?
>>>
>>> By 'allow netdev to "give" struct device to page_pool', does it mean
>>> page_pool become the driver for the device?
>>> If yes, it seems that is similar to jakub's idea, as both seems to stall
>>> the calling of device_del() by not returning when the driver unloading.
>>
>> Yes, this is what I mean. (That is why I mentioned Jakub's idea).

I am not sure what dose the API that allows netdev to "give" struct device
to page_pool look like or how to implement the API yet, but the obvious way
to stall the calling of device_del() is to wait for the inflight page to
come back in page_pool_destroy(), which seems the same as the jakub's
way from the viewpoint of user, and jakub's way seems more elegant than
waiting in page_pool_destroy().

> 
> Keeping track of inflight packets that need to be unmapped is
> certainly more complex. Delaying the netdevice destruction certainly
> solves the problem but there's a huge cost IMHO. Those devices might
> stay there forever and we have zero guarantees that the network stack
> will eventually release (and unmap) those packets. What happens in
> that case? The user basically has to reboot the entire machine, just
> because he tries to bring an interface down and up again.

Yes.
The problem seems to be how long page_pool is allowed to stall the driver
unloading? Does the driver unload stalling affect some feature like device
hotplug?
As the problem in [1], the stall might be forever due to caching in the
network stack as discussed in [2], and there might be some other caching
we don't know yet.

The stalling log in [1] is caused by the caching in skb_attempt_defer_free(),
we may argue that a timeout is needed for those kind of caching, but Eric
seemed to think otherwise in commit log of [3]:
"As Eric pointed out/predicted there's no guarantee that
applications will read / close their sockets so a page pool page
may be stuck in a socket (but not leaked) forever."

1. https://lore.kernel.org/netdev/20240814075603.05f8b0f5@kernel.org/T/#me2f2c89fbeb7f92a27d54a85aab5527efedfe260
2. https://lore.kernel.org/netdev/20240814075603.05f8b0f5@kernel.org/T/#m2687f25537395401cd6a810ac14e0e0d9addf97e
3. https://lore.kernel.org/netdev/ZWfuyc13oEkp583C@makrotopia.org/T/

> 
> Thanks
> /Ilias
>>
>>
>>> If no, it seems that the problem is still existed when the driver for
>>> the device has unbound after device_del() is called.

