Return-Path: <bpf+bounces-40108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3D297CEB1
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 23:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8131C2234D
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 21:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1FF14D280;
	Thu, 19 Sep 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMIiZugO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87C8143880;
	Thu, 19 Sep 2024 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726779894; cv=none; b=ECFxxjIR2M4/5jUKYcuyDaX6fdnJ/Mr0vIhA9ZD9dnUq87baPtRX3uv0gqeWtYanIMSgu0uLO2P/Yl2NDJflQHy2QB5CWZjPZmuAOaTnZaKVdIE+tXZhBlxwTbM/S3WZGcqBvCncfdCjZPbR1G/nR8/LKc4sDCayr39MDOo68uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726779894; c=relaxed/simple;
	bh=8rmdkhy7mle9GnzKV59Fez0ZiYJ5ItopN5knD5heul0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtyYZc7s5Uxt8DM+T0cTTfhOMr3D9EHvO0SYMpgQDF1Ti6hwlyk9stQSEMjdC/zRdsllEovRTM3voQPeGjyGBad3gvWTWx8FkiKMRdJFC7vkefK+ql02oMk+vLEat5mHD3XD+lGVh8oA7aObgHbxWy+AhZK8kZ+td5+EUPcEagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMIiZugO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DAEC4CEC4;
	Thu, 19 Sep 2024 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726779893;
	bh=8rmdkhy7mle9GnzKV59Fez0ZiYJ5ItopN5knD5heul0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tMIiZugOhjzqgyUpW7HkIMb94kB3G/IoEOWJvEfIibHaCL2W6lxj/6dAy50ww3Upd
	 5BuV7yd7+xf0LnJlLA6shnOsl4ybtmmnw4qRRAcxcVdTlQQO8CjzRoHuaAPl0cnLci
	 KyO838TcaL8c8mfnqC3Fcz2LQ0BjvUfx2U9ux0XAeez0raNOeRSjsGu9186hqHSozD
	 ekcF76hWo/vt3sl8iQ7tBHFkSTET2nmVrmZCljeeCkxJkkq5cSQY3mp+XWQ6e0oYMf
	 Qo62AxytxEW4fp+yzCDxcmUUB+Wme/iNSXIqef4vFQ/XRD6jqsRg+/Yl4tOtEC8q6k
	 c8Ol4+tfmgDUA==
Message-ID: <0e8c7a7a-0e2a-42ec-adbc-b29f6a514517@kernel.org>
Date: Thu, 19 Sep 2024 23:04:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com,
 Robin Murphy <robin.murphy@arm.com>,
 Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
 Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-mm@kvack.org
References: <20240918111826.863596-1-linyunsheng@huawei.com>
 <20240918111826.863596-3-linyunsheng@huawei.com>
 <CAC_iWjK=G7Oo5=pN2QunhasgDC6NyC1L+96jigX7u9ad+PbYng@mail.gmail.com>
 <894a3c2c-22f9-45b9-a82b-de7320066b42@kernel.org>
 <cdfecd37-31d7-42d2-a8d8-92008285b42e@huawei.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <cdfecd37-31d7-42d2-a8d8-92008285b42e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/09/2024 13.15, Yunsheng Lin wrote:
> On 2024/9/19 17:42, Jesper Dangaard Brouer wrote:
>>
>> On 18/09/2024 19.06, Ilias Apalodimas wrote:
>>>> In order not to do the dma unmmapping after driver has already
>>>> unbound and stall the unloading of the networking driver, add
>>>> the pool->items array to record all the pages including the ones
>>>> which are handed over to network stack, so the page_pool can
>>>> do the dma unmmapping for those pages when page_pool_destroy()
>>>> is called.
>>>
>>> So, I was thinking of a very similar idea. But what do you mean by
>>> "all"? The pages that are still in caches (slow or fast) of the pool
>>> will be unmapped during page_pool_destroy().
>>
>> I really dislike this idea of having to keep track of all outstanding pages.
>>
>> I liked Jakub's idea of keeping the netdev around for longer.
>>
>> This is all related to destroying the struct device that have points to
>> the DMA engine, right?
> 
> Yes, the problem seems to be that when device_del() is called, there is
> no guarantee hw behind the 'struct device ' will be usable even if we
> call get_device() on it.
> 
>>
>> Why don't we add an API that allow netdev to "give" struct device to
>> page_pool.  And then the page_poll will take over when we can safely
>> free the stuct device?
> 
> By 'allow netdev to "give" struct device to page_pool', does it mean
> page_pool become the driver for the device?
> If yes, it seems that is similar to jakub's idea, as both seems to stall
> the calling of device_del() by not returning when the driver unloading.

Yes, this is what I mean. (That is why I mentioned Jakub's idea).


> If no, it seems that the problem is still existed when the driver for
> the device has unbound after device_del() is called.

