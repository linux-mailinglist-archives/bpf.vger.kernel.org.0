Return-Path: <bpf+bounces-40113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C061897D0F1
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 07:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B97B2277E
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 05:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2213BBDE;
	Fri, 20 Sep 2024 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jubUAuzW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5D937171
	for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726810196; cv=none; b=jaGVeSIVnTl5H5CMRGTRVbtmCr+gYY+pZctQxXAcyG1u3WWml32oIxQTRg/Q/r9MEZFmWM2/3hCHjP21ZhP7PpBzydnFBwuUIbsl6r1152Q+HUY2dn/YQGUTg4NqGKZZwZSH2dia5X+HyQ9KeObGHHOb6KAqjb4A/OZwekd7aBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726810196; c=relaxed/simple;
	bh=GAE3MyN42Bi7seJDKASBKLuxuLfOYuGLe4r2lWvcD7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLXql9JFbWaD45ZZ+Chb+EzPr2DewUfj1+oECtSZJrgQpOshRi7PP2WV9N09v9nwmmccAsRpYtRgzr3SWg8qVQseiWX7WDrQ5XoQppgzN1nvZoggCvhvM3DgvdflyUQnuM+v5FnLl8PTTLkhYtn0XfVAHIX52oVV020d/+ONkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jubUAuzW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20551eeba95so16305225ad.2
        for <bpf@vger.kernel.org>; Thu, 19 Sep 2024 22:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726810194; x=1727414994; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KlbRqa7nDF2on3envLfRNKR76Ma17jJTd9UlvPEe+/8=;
        b=jubUAuzWuhuOI9ilTYQ6M6+Q9/DZ5XVhBC+oFJJpBTFaGXRGJfnMDjABw4kljiDbiw
         34ANtRO6u9nKLH5empEE8NaCVNdNzxWMtGFvi2qWmWq9Go7yLSfbhUaANiCXI13y5sfZ
         /jzSRg2Qr+5n2h6aAbW8CguXpwcVx79cZ8AJZkAhJSr757W0nxaFaHiCFsaEa7U+InIv
         h0vQRH3yMfprdMfReVRZ6M4JnUlt9G4f6aY7aGqstPNQUDtUg6AqmC6xeSof78mnX6p1
         mokovqlfkAqc+daW5PPeBhzE5PQBlHW5o60GvHr6qvCd71UkThBQpXNB6M/hJx9djYLK
         CQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726810194; x=1727414994;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KlbRqa7nDF2on3envLfRNKR76Ma17jJTd9UlvPEe+/8=;
        b=HuWzPonSrsl1XrOKX4Ho9tux+YCj75U5MRnV7Rl1AAIQHTJ+CE/AfiU01bZZClT+Cq
         NB2C63qjThwI2J6qyT1TCZDt5yw4cs4DhB/ClGeW3HOkxmEeFze1RTYs1ir6Y/ghnntw
         0GWKUY3RdgON1cmQSov0h0w69BnOS9uKz4UDO7sQd/ga7zRgRE7E19TqKIpeL+p6hYFT
         3BP2snzFDm446dJw+OB+KfL5S2Axmqam6362rzjWv0XuSNj/ZkxJKUQWCbEPZGGu0oPi
         q7W5nzMVujr3qBkk7jLq/JQ9en/cgM9dcoY197SibvMCWBmnH8BOm5oXeX1CTopISetE
         knTA==
X-Forwarded-Encrypted: i=1; AJvYcCUuzdTV75MHPkBFlk6zjjkoTLXz3608kfS8qkhGPwM4KZ0PvKHyJpc5vg+cKsYre6cUFEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXePnFxNWMbkIOV6IG33arHt+vDUFbi8cfyzW8a2tYa35fEmN7
	5pRjtYwubCG6ZqQ8sVhg5PkPfCGhrMRTacARdS/qxDfbyl+nvmkmdVcKqtqcHjhobcWtoPE5f2L
	BaitOyVcugsxAsblDOQmbE1pGEWnLa2/3csuAVQ==
X-Google-Smtp-Source: AGHT+IFXWjjSwUV/swiBcaoOWRQSWx9kHyL3ewiTd5ev59pob+f5VLbFm74ieex5x8O25zo1tfmYvjNJafp2P2Ogezc=
X-Received: by 2002:a17:903:32c7:b0:206:ba7c:9f2e with SMTP id
 d9443c01a7336-208d83b69f0mr25703685ad.25.1726810194586; Thu, 19 Sep 2024
 22:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240918111826.863596-1-linyunsheng@huawei.com>
 <20240918111826.863596-3-linyunsheng@huawei.com> <CAC_iWjK=G7Oo5=pN2QunhasgDC6NyC1L+96jigX7u9ad+PbYng@mail.gmail.com>
 <894a3c2c-22f9-45b9-a82b-de7320066b42@kernel.org> <cdfecd37-31d7-42d2-a8d8-92008285b42e@huawei.com>
 <0e8c7a7a-0e2a-42ec-adbc-b29f6a514517@kernel.org>
In-Reply-To: <0e8c7a7a-0e2a-42ec-adbc-b29f6a514517@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Sep 2024 08:29:18 +0300
Message-ID: <CAC_iWj+3JvPY2oqVOdu0T1Wt6-ukoy=dLc72u1f55yY23uOTbA@mail.gmail.com>
Subject: Re: [PATCH net 2/2] page_pool: fix IOMMU crash when driver has
 already unbound
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, liuyonglong@huawei.com, fanghaiqing@huawei.com, 
	zhangkun09@huawei.com, Robin Murphy <robin.murphy@arm.com>, 
	Alexander Duyck <alexander.duyck@gmail.com>, IOMMU <iommu@lists.linux.dev>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, Eric Dumazet <edumazet@google.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Andrew Morton <akpm@linux-foundation.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Hi Jesper,

On Fri, 20 Sept 2024 at 00:04, Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>
>
>
> On 19/09/2024 13.15, Yunsheng Lin wrote:
> > On 2024/9/19 17:42, Jesper Dangaard Brouer wrote:
> >>
> >> On 18/09/2024 19.06, Ilias Apalodimas wrote:
> >>>> In order not to do the dma unmmapping after driver has already
> >>>> unbound and stall the unloading of the networking driver, add
> >>>> the pool->items array to record all the pages including the ones
> >>>> which are handed over to network stack, so the page_pool can
> >>>> do the dma unmmapping for those pages when page_pool_destroy()
> >>>> is called.
> >>>
> >>> So, I was thinking of a very similar idea. But what do you mean by
> >>> "all"? The pages that are still in caches (slow or fast) of the pool
> >>> will be unmapped during page_pool_destroy().
> >>
> >> I really dislike this idea of having to keep track of all outstanding pages.
> >>
> >> I liked Jakub's idea of keeping the netdev around for longer.
> >>
> >> This is all related to destroying the struct device that have points to
> >> the DMA engine, right?
> >
> > Yes, the problem seems to be that when device_del() is called, there is
> > no guarantee hw behind the 'struct device ' will be usable even if we
> > call get_device() on it.
> >
> >>
> >> Why don't we add an API that allow netdev to "give" struct device to
> >> page_pool.  And then the page_poll will take over when we can safely
> >> free the stuct device?
> >
> > By 'allow netdev to "give" struct device to page_pool', does it mean
> > page_pool become the driver for the device?
> > If yes, it seems that is similar to jakub's idea, as both seems to stall
> > the calling of device_del() by not returning when the driver unloading.
>
> Yes, this is what I mean. (That is why I mentioned Jakub's idea).

Keeping track of inflight packets that need to be unmapped is
certainly more complex. Delaying the netdevice destruction certainly
solves the problem but there's a huge cost IMHO. Those devices might
stay there forever and we have zero guarantees that the network stack
will eventually release (and unmap) those packets. What happens in
that case? The user basically has to reboot the entire machine, just
because he tries to bring an interface down and up again.

Thanks
/Ilias
>
>
> > If no, it seems that the problem is still existed when the driver for
> > the device has unbound after device_del() is called.

