Return-Path: <bpf+bounces-40085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE1397C73B
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0BD1F29C57
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 09:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3D119D084;
	Thu, 19 Sep 2024 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNvFUZlI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76019CC18;
	Thu, 19 Sep 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738970; cv=none; b=hqfYgqMYD9ebtPO4yEurFsuNykFLFRz8qFqONYx5ULlNN1rqWrcugiV517Xp6CPN37KH7DOeVtxgJ57xnDkuXvRy4+v6uxRt5Crv7m7OpcCNSULjMnq/i5gtH/ODkwL8QHzN/6m7q6tU5PlO2Dm/8XdKVg/bHDFFzn6+/H1H1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738970; c=relaxed/simple;
	bh=4mBPJ1/8ZHYMdSjeFFRdSDpez+20eaW5Qpk0ZxpyplE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kNuGi9S+av7C4E8wr7aXz7xR3RtpcW46GtTtpNlrEltq/Gut2mu/LJn7Z54KS+bkpJZ10m0KKYfeAGG0kdJlgjGjgG7Gs2E1g/0X0B3iOD1az2JV656+RPUg73A0jF+sw8t/zOjoxRw0QVAM6YRg/Ey4TE9TmFx99PAgnGfEDoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNvFUZlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC7FC4CEC4;
	Thu, 19 Sep 2024 09:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726738970;
	bh=4mBPJ1/8ZHYMdSjeFFRdSDpez+20eaW5Qpk0ZxpyplE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WNvFUZlIeZCdtFKQ6JJfXg22qRTupBYLgnu8Znpgj7u9GzB9cb+oCuqkGaUUFXqZg
	 u3FLl6T6Dc6z14wmNEhM9sxXlKK/hnTLT7l41VAHBzniRkxJuoPGhWwQEozIgpKcqn
	 e0kS1YGW5Ob7pUpRgtI7MbGmwk2xVRYMaz+rj6ubfII71lcBL9BipnzLBPVQDxC0s+
	 6tii01Hw8+gMcMOU9sr4JhVfid9pQ8djWVDTMMnYh2tWVR7phPjsbZwqdPYB+N9hdB
	 cnocJ45KkOqJzUN/IKhO7vvYPYCr6HhVzm91jSPJ6/m++FZ0VQT1lV4F/UgLqGCLlU
	 /zO3c8TS5wTbA==
Message-ID: <894a3c2c-22f9-45b9-a82b-de7320066b42@kernel.org>
Date: Thu, 19 Sep 2024 11:42:40 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Yunsheng Lin <linyunsheng@huawei.com>
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
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAC_iWjK=G7Oo5=pN2QunhasgDC6NyC1L+96jigX7u9ad+PbYng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 18/09/2024 19.06, Ilias Apalodimas wrote:
>> In order not to do the dma unmmapping after driver has already
>> unbound and stall the unloading of the networking driver, add
>> the pool->items array to record all the pages including the ones
>> which are handed over to network stack, so the page_pool can
>> do the dma unmmapping for those pages when page_pool_destroy()
>> is called.
>
> So, I was thinking of a very similar idea. But what do you mean by
> "all"? The pages that are still in caches (slow or fast) of the pool
> will be unmapped during page_pool_destroy().

I really dislike this idea of having to keep track of all outstanding pages.

I liked Jakub's idea of keeping the netdev around for longer.

This is all related to destroying the struct device that have points to
the DMA engine, right?

Why don't we add an API that allow netdev to "give" struct device to
page_pool.  And then the page_poll will take over when we can safely
free the stuct device?

--Jesper

