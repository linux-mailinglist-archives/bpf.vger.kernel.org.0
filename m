Return-Path: <bpf+bounces-40394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB27988136
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 11:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15D01F249E9
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 09:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D9B1BAECE;
	Fri, 27 Sep 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8WplHry"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D05C433D9
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 09:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428932; cv=none; b=c5Y/SDM13fsCIM6HBiJzS6eVupXXgsA+W4AQ2qKfBrcjeSPOC5CE9CXwxpzh1oMSuG91iukUr11wF6lv/Ulf4K2B4s3KpeyEp5mbrr880BPOOf4yhVgN8vU87WKXsXI9Civ8g+Z3DTezL6wazrnYZXUDQ1Jk9hg+ljBJ5ACNo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428932; c=relaxed/simple;
	bh=12b5Ewn3cylugkvg1EbdzJzESK9RcP19B7oJlHII/b8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mQoaxkT9BwuYBWkvWKUgRaarrtuSr7scGYIJ8HRlNZOC780hu2OMu85v06TG8YHhcR/DpTyd0sQUwhp0IS/h7vEGgOpTO1g/Ky9RBMZaeunFji2N5q3EZmtq3NVqpckkVyvuKBuqj0WsXiEfVcT6vBBP7miEyPPK8kgywcBQa0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a8WplHry; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e06fade5eeso1556013a91.2
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727428930; x=1728033730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u12Tug5k2bdyzIU9WiqUE2EObFB7IXUcT3bKNNPZCB0=;
        b=a8WplHry6u3iuaQkoq0+ZuW5zEccqDNVuuHcnAtXMA1SRyBTH7GW2PWKCLY01aJ6lL
         dD22V5tm/66zyJZ+iCvICdOSB/lK9TZFCPr1tniZWNJ3v8WHRKoGwOgrsmCZjty3S5gt
         0uSTHMamrhjA1ZZpzQN/Rwvl20Yy6SoXAAYpyx6becyxwT18gcBzmprVsjE076+Zk3Ik
         +tosuclWvttUNiUGzSPIe6YG0y4c2IQFiRSVRZ1BbxffwUxbmY5aJz3kZgSIWYv9QCRP
         CGrldaVUavywa5YcmblPv3J1jq8UNYHg7oD6znm6iJhNsOMaSvnST3WO+RLcrv08wJRF
         BiPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727428930; x=1728033730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u12Tug5k2bdyzIU9WiqUE2EObFB7IXUcT3bKNNPZCB0=;
        b=j5+RbHJ2abmpEGKlhm1KWnsILAItg25kOBIyq2cw5SW2674eMDjJ7e7tpXn5l2fbSJ
         qqldSx46hBwW4VJfdUn9nHFNHwQREb2MNlcyxPvSRhKyney+KidfbBM0fOWkuHPeij4v
         hAeYWwTcv/RSIoTljHJrg5VrfbNlNOhd6Nh1U/+inB3C3SyL1mDuV90/wZXVmE7TToZ8
         pSt0JUlgr45bb8GP/oh/bLft2X19TJnWxdDyGwPHrgF5qlNjKDA+LDcvwatdEi/sEDUL
         pqmpFQXRNS42AhjT6GX9aXscD7zZ6597prma4v1pv0XMoV2vdHUQ+YA1XjxPva6Y3cqR
         O8kg==
X-Forwarded-Encrypted: i=1; AJvYcCUJ/tM3lPnO/XcnCHm8Eg+fUIRl4kZaV5aLcV40ZjKoFYikZrHbn0htps/kcIVU5aR3lQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjdyArW092cTz8llnCvGiK0C+9ZxuZWYhUXn1LEVPSq2Q2KfU
	at2hum2IrGYzNPfoyfeM+k1jD62R1WaqcAC3pF/z2DHYjY/e+S1tpiD5xgfCdifHxAr6n47JiOG
	nikecmArAm52S0nMasK+IDPx56ECorZ3wU2Jl1A==
X-Google-Smtp-Source: AGHT+IGhQGOutUtxLVOzhj1pZESUxIJEMnWirkI07rvkOdCYDPIQ+9U4QYWB0UPwoiObJJWrhA4Koam3DQfasHbzz4I=
X-Received: by 2002:a17:90a:4b07:b0:2e0:9147:7db5 with SMTP id
 98e67ed59e1d1-2e0b8ed4cebmr2795273a91.38.1727428930437; Fri, 27 Sep 2024
 02:22:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com>
In-Reply-To: <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 12:21:33 +0300
Message-ID: <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: Mina Almasry <almasrymina@google.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Yunsheng

On Fri, 27 Sept 2024 at 06:58, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/9/27 2:15, Mina Almasry wrote:
> >
> >> In order not to do the dma unmmapping after driver has already
> >> unbound and stall the unloading of the networking driver, add
> >> the pool->items array to record all the pages including the ones
> >> which are handed over to network stack, so the page_pool can
> >> do the dma unmmapping for those pages when page_pool_destroy()
> >> is called.
> >
> > One thing I could not understand from looking at the code: if the
> > items array is in the struct page_pool, why do you need to modify the
> > page_pool entry in the struct page and in the struct net_iov? I think
> > the code could be made much simpler if you can remove these changes,
> > and you wouldn't need to modify the public api of the page_pool.
>
> As mentioned in [1]:
> "There is no space in 'struct page' to track the inflight pages, so
> 'pp' in 'struct page' is renamed to 'pp_item' to enable the tracking
> of inflight page"

I have the same feeling as Mina here. First of all, we do have an
unsigned long in struct page we use for padding IIRC. More
importantly, though, why does struct page need to know about this?
Can't we have the same information in page pool?
When the driver allocates pages it does via page_pool_dev_alloc_XXXXX
or something similar. Cant we do what you suggest here ? IOW when we
allocate a page we put it in a list, and when that page returns to
page_pool (and it's mapped) we remove it.

Thanks
/Ilias
>
> As we still need pp for "struct page_pool" for page_pool_put_page()
> related API, the container_of() trick is used to get the pp from the
> pp_item.
>
> As you had changed 'struct net_iov' to be mirroring the 'struct page',
> so change 'struct net_iov' part accordingly.
>
> 1. https://lore.kernel.org/all/50a463d5-a5a1-422f-a4f7-d3587b12c265@huawei.com/
>
> >
> >> As the pool->items need to be large enough to avoid
> >> performance degradation, add a 'item_full' stat to indicate the
> >> allocation failure due to unavailability of pool->items.
> >>
> >
> > I'm not sure there is any way to size the pool->items array correctly.
>
> Currently the size of pool->items is calculated in page_pool_create_percpu()
> as below, to make sure the size of pool->items is somewhat twice of the
> size of pool->ring so that the number of page sitting in the driver's rx
> ring waiting for the new packet is the similar to the number of page that is
> still being handled in the network stack as most drivers seems to set the
> pool->pool_size according to their rx ring size:
>
> +#define PAGE_POOL_MIN_INFLIGHT_ITEMS           512
> +       unsigned int item_cnt = (params->pool_size ? : 1024) +
> +                               PP_ALLOC_CACHE_SIZE + PAGE_POOL_MIN_INFLIGHT_ITEMS;
> +       item_cnt = roundup_pow_of_two(item_cnt);
>
> > Can you use a data structure here that can grow? Linked list or
> > xarray?
> >
> > AFAIU what we want is when the page pool allocates a netmem it will
> > add the netmem to the items array, and when the pp releases a netmem
> > it will remove it from the array. Both of these operations are slow
> > paths, right? So the performance of a data structure more complicated
> > than an array may be ok. bench_page_pool_simple will tell for sure.
>
> The question would be why do we need the pool->items to grow with the
> additional overhead and complication by dynamic allocation of item, using
> complicated data structure and concurrent handling?
>
> As mentioned in [2], it was the existing semantics, but it does not means
> we need to keep it. The changing of semantics seems like an advantage
> to me, as we are able to limit how many pages is allowed to be used by
> a page_pool instance.
>
> 2. https://lore.kernel.org/all/2fb8d278-62e0-4a81-a537-8f601f61e81d@huawei.com/
>
> >
> >> Note, the devmem patchset seems to make the bug harder to fix,
> >> and may make backporting harder too. As there is no actual user
> >> for the devmem and the fixing for devmem is unclear for now,
> >> this patch does not consider fixing the case for devmem yet.
> >>
> >
> > net_iovs don't hit this bug, dma_unmap_page_attrs() is never called on
> > them, so no special handling is needed really. However for code
>
> I am really doubtful about your above claim. As at least the below
> implementaion of dma_buf_unmap_attachment_unlocked() called in
> __net_devmem_dmabuf_binding_free() seems be using the DMA API directly:
>
> https://elixir.bootlin.com/linux/v6.7-rc8/source/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c#L215
>
> Or am I missing something obvious here?
>
> > quality reasons lets try to minimize the number of devmem or memory
> > provider checks in the code, if possible.
> >

