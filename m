Return-Path: <bpf+bounces-40362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD39878FC
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 20:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F97F1F23580
	for <lists+bpf@lfdr.de>; Thu, 26 Sep 2024 18:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2124E16630E;
	Thu, 26 Sep 2024 18:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgTZPr0M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191591474B5
	for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 18:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374534; cv=none; b=UW80aQVixUE9VeOweh7VgjS4WUF5cwOmGghTawgRlzx0vNhtw7SeCYWSTqx+CkRvo5zw9/tb/ZCG0UtskxQtY8dN9eCU2A+YwjtV9hhPWNn6Ud01tB/4jZlMoekhHom+xXkxte9lkXRtRsvQGm+MqtAPTM3BnCzBkvOOTQbkqII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374534; c=relaxed/simple;
	bh=0iaW9ayASK4sYOEg7AV+wgw2JHuSB/rDBFbxxHYK+kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOS76qr544W86YC97+DIiy3QxxicKJcZQiTpxHzMmQRwXiUMk5w1f/agz8Yqwsx1LF3r0arnL7OPffoShjjNgK8F93QGxFPnaBW0m6S/9qL5HQ3TbV6Ok+isL+6I7Hq+f+0AYaH47H/XoOBjxNogYdQaKsciyPJ6Jl48JJULkoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CgTZPr0M; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4581cec6079so37351cf.0
        for <bpf@vger.kernel.org>; Thu, 26 Sep 2024 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727374532; x=1727979332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghI5wl9Rodk/qOTN/GXzEVkvMG0ZFbywRGFDuKaTQGk=;
        b=CgTZPr0MikyVbQY57XDnogDR/NKIDNiItW+63Y2Lu1QT7M3RieLLvc12enuYOhTtqf
         kb9ZwoCUTiL+DBvNgOuABJD735GzbDMesX8ONorz05oiheyP1uX8wxTA7+5RsF87UKZa
         Q5Ooy5ggpT+bTS1iqm1+mBTwvrzxOT+98CtrHSWU01ibKXm7Y9COKJk2o2Q5NfVNTQE+
         UQT5tgF+f4UZnfeeDgd9mi2hIWumnZlpsPvotzvKLbeLm7hViEWuqGMgpalp6e5CVJfw
         3IY6m8l2nYE6QxbKARUa9BSrtKIh9ny7/amYDLdRQvmSX0SOR2z8r8DHPrymVfdkiU5H
         BO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727374532; x=1727979332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ghI5wl9Rodk/qOTN/GXzEVkvMG0ZFbywRGFDuKaTQGk=;
        b=oAwh8Z7iD6kBGlR5p4kqdynUyGFt4KPcLtRKGBMzz8IrwbCzMXJRe8wx10HSNv5a/E
         Yh9kZ0zNdBIKU731ic9IZJA1ubkJ1mekUV6So8rj03Hz7ZLR8yOMSyo2C2QwwDObJ1y+
         +v4HRL0OHvt3zTwjvq6sllMXipOtN470UCCuCGfeXyaR2JPanSVexyto5+7sAvcU8m2u
         8dXoBcYe6AagwP1Qm8aIvP8vmdk8mfirHu/Cgli1VtGWehKPStaM3uIxuXdG2fm+EWjo
         ElNhlgwooM+H/3XQ2dMDH0+WVAFUjidQXkXkAwyiDaSJI+STUnX7JFLkQoySYMtss/Aa
         nrlg==
X-Forwarded-Encrypted: i=1; AJvYcCUTZVuA/wGPyMo1O7X6uyQDlS8nFfJATakcaiqWCzw5Evhz1aGJ+5kEh/fQlf7prn2gXhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu/3K8VRRdTolFIh1d0Cff3hbJN6oTZuf+onqgbKLH/E0Q5ojJ
	1YiXBFAdZAGJ2xv0cG6CiIoMgg9HAvBJFhnPX+2KbGPM+7fM4Kgq0BGqcImd7VprJej5P4zE7kV
	56xy3j7bJ7Qb2f89qOZb6OUIJZz+kF2PxHF7f
X-Google-Smtp-Source: AGHT+IEKskNfWv42/OYoUzFnd0ZbE37pwmmbLc0UUgMIXvnGdU5BvAly31C36TplRHtvwCbfAj6CwKAwWZwa5Zx659M=
X-Received: by 2002:a05:622a:24a:b0:453:62ee:3fe with SMTP id
 d75a77b69052e-45ca03e60f6mr134981cf.17.1727374531410; Thu, 26 Sep 2024
 11:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com> <20240925075707.3970187-3-linyunsheng@huawei.com>
In-Reply-To: <20240925075707.3970187-3-linyunsheng@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 26 Sep 2024 11:15:15 -0700
Message-ID: <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	liuyonglong@huawei.com, fanghaiqing@huawei.com, zhangkun09@huawei.com, 
	Robin Murphy <robin.murphy@arm.com>, Alexander Duyck <alexander.duyck@gmail.com>, 
	IOMMU <iommu@lists.linux.dev>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Felix Fietkau <nbd@nbd.name>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, bpf@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 1:03=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> Networking driver with page_pool support may hand over page
> still with dma mapping to network stack and try to reuse that
> page after network stack is done with it and passes it back
> to page_pool to avoid the penalty of dma mapping/unmapping.
> With all the caching in the network stack, some pages may be
> held in the network stack without returning to the page_pool
> soon enough, and with VF disable causing the driver unbound,
> the page_pool does not stop the driver from doing it's
> unbounding work, instead page_pool uses workqueue to check
> if there is some pages coming back from the network stack
> periodically, if there is any, it will do the dma unmmapping
> related cleanup work.
>
> As mentioned in [1], attempting DMA unmaps after the driver
> has already unbound may leak resources or at worst corrupt
> memory. Fundamentally, the page pool code cannot allow DMA
> mappings to outlive the driver they belong to.
>
> Currently it seems there are at least two cases that the page
> is not released fast enough causing dma unmmapping done after
> driver has already unbound:
> 1. ipv4 packet defragmentation timeout: this seems to cause
>    delay up to 30 secs.
> 2. skb_defer_free_flush(): this may cause infinite delay if
>    there is no triggering for net_rx_action().
>

I think additionally this is dependent on user behavior, right? AFAIU,
frags allocated by the page_pool will remain in the socket receive
queue until the user calls recvmsg(), and AFAIU they are stuck there
arbitrarily long.

> In order not to do the dma unmmapping after driver has already
> unbound and stall the unloading of the networking driver, add
> the pool->items array to record all the pages including the ones
> which are handed over to network stack, so the page_pool can
> do the dma unmmapping for those pages when page_pool_destroy()
> is called.

One thing I could not understand from looking at the code: if the
items array is in the struct page_pool, why do you need to modify the
page_pool entry in the struct page and in the struct net_iov? I think
the code could be made much simpler if you can remove these changes,
and you wouldn't need to modify the public api of the page_pool.

> As the pool->items need to be large enough to avoid
> performance degradation, add a 'item_full' stat to indicate the
> allocation failure due to unavailability of pool->items.
>

I'm not sure there is any way to size the pool->items array correctly.
Can you use a data structure here that can grow? Linked list or
xarray?

AFAIU what we want is when the page pool allocates a netmem it will
add the netmem to the items array, and when the pp releases a netmem
it will remove it from the array. Both of these operations are slow
paths, right? So the performance of a data structure more complicated
than an array may be ok. bench_page_pool_simple will tell for sure.

> Note, the devmem patchset seems to make the bug harder to fix,
> and may make backporting harder too. As there is no actual user
> for the devmem and the fixing for devmem is unclear for now,
> this patch does not consider fixing the case for devmem yet.
>

net_iovs don't hit this bug, dma_unmap_page_attrs() is never called on
them, so no special handling is needed really. However for code
quality reasons lets try to minimize the number of devmem or memory
provider checks in the code, if possible.

--=20
Thanks,
Mina

