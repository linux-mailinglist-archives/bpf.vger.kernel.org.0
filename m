Return-Path: <bpf+bounces-40397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C87988217
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 11:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE34628827C
	for <lists+bpf@lfdr.de>; Fri, 27 Sep 2024 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDB71BBBD3;
	Fri, 27 Sep 2024 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yf7rDCDK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822371BB6BD
	for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727431174; cv=none; b=Q/+Wscwt5VObkqDFB12zEqs7SYBFYUP7pBUYiEMGf295w2td74lX6wZCWSGYPssOIJ9Z1Q1z4PlXKoV3cH9bKTNb87Y0sa1egObEzKI0ZpPXneeobcYYYajjpeIJWLiNFpx+cZ3rumjpAGgZwE7xzg+Cb0iVpt8DAcv89haZZpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727431174; c=relaxed/simple;
	bh=/wFHvQrnJe6+I0Hk404NsRdbI8eFHq8tb62kLJdsI/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZmSAIYoU72Z9GqVdMHDqT/IFm6rdNivvKCjOVYFWZvxW2cH8UG3cLFmMWaoMr8EK3hA+jGaDWtTbHkrgGleaXUy6cdiYM75X5VZwC41lb1uGl9AEIPyBVZZYHqwHhYEJjMBYP3eIs9ScLOghNWgSni8XHNYaUZPLmQa+pQdyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yf7rDCDK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db637d1e4eso1550257a12.2
        for <bpf@vger.kernel.org>; Fri, 27 Sep 2024 02:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727431172; x=1728035972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wFHvQrnJe6+I0Hk404NsRdbI8eFHq8tb62kLJdsI/o=;
        b=yf7rDCDKkef/ZmyjQ5fE/iIG8XGaSNtqpivi4oLPR8OmeUcNvceksxMvn/JqgBWjku
         07QMX+A1BPUYrSEDdYetiw28hsxTf1+8LSzQ42Q2f6b1M5TwqV551ASk2Qma6qnupGty
         o00+WNOZxNl7qMYDC/xV2EZMfMSJEGSK8BdX2hAHbmRCqJmZUOrsexyHEs80Pz4S+ltM
         yjkuYoQ0HhDxQkGb9iBzkOJ0VnSB2J4lwzHmgbPmWZ9vPAU6G648bW4kkHWCCFUGLej3
         E92hwCJURVmMzGh+epzRcciNN8A4oNiHF558O29J/Tkhqv8qFZINud6Q78rNZeGbbRQ/
         TxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727431172; x=1728035972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wFHvQrnJe6+I0Hk404NsRdbI8eFHq8tb62kLJdsI/o=;
        b=CMGWKSeeBD1gsMDSWmaksdTfnjh1CeJHBRhtP4Y8/kLZ9mNC/tYPT0L0LpKR6B1o2B
         VgW9C3SHGeC6114q0Gbyr+WrfLeMbgN70OeXO/a5sJ6qjVesJGEtaVZjnXoep7KClyaP
         VAd2/axy+fZ55JRfmPd722ugkAgUCYSt+B/W5xbaLSoqf6LQhhCu8/4qXiq3pykIybLh
         O6ztfGKtY/FLwNs+AUrKz2+DZGOW9ppauXiEDQj9wh7G2T11mO7NQXRBzLEU/Owk5/4p
         ZcAybNn8RrKVnOecnn9bqz+1CnyMIidl2tF107LZ1YWrO2VXXffs/feMabnJBaDdGioa
         6j7g==
X-Forwarded-Encrypted: i=1; AJvYcCVtCkzmljWNclpj01yr9dP1mgPAqZNSlNblFTDx3uGEe4neHWEtGxAnhU3PG/myHtCIprU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxs3a0fFWfYlI+8VGnPOK4N8V99cVfrotKzwIUCgV80ibI92Rc
	1RRgZ6yhlQSGmCFRNlIpt/BD3WqdfM2Ip6Fz0kDPD6rgekLHOwDZfUprCXfFcW8bo6xX1OYPhln
	HpMXxqWz292W+RtvhGMCHzRXrM6yWNxkwO2qJ/w==
X-Google-Smtp-Source: AGHT+IFPw7TdHI7xAVBejSYDuXRNyLLxKTG1ESrzw48y3A/pOuf25zX23NWOfeE/8MxH7DAW+JoIMvACw7ATICsO3w0=
X-Received: by 2002:a05:6a20:6f03:b0:1cf:23cb:b927 with SMTP id
 adf61e73a8af0-1d4fa7a6f8emr3754825637.34.1727431171797; Fri, 27 Sep 2024
 02:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925075707.3970187-1-linyunsheng@huawei.com>
 <20240925075707.3970187-3-linyunsheng@huawei.com> <CAHS8izOxugzWJDTc-4CWqaKABTj=J4OHs=Lcb=SE9r8gX0J+yg@mail.gmail.com>
 <842c8cc6-f716-437a-bc98-70bc26d6fd38@huawei.com> <CAC_iWjLgNOtsbhqrhvvEz2C3S668qB8KatL_W+tPHMSkDrNS=w@mail.gmail.com>
 <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com>
In-Reply-To: <0ef315df-e8e9-41e8-9ba8-dcb69492c616@huawei.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Sep 2024 12:58:55 +0300
Message-ID: <CAC_iWjKeajwn3otjdEekE6VDLHGEvqmnQRwpN5R3yHj8UpEiDw@mail.gmail.com>
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

On Fri, 27 Sept 2024 at 12:50, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>
> On 2024/9/27 17:21, Ilias Apalodimas wrote:
> > Hi Yunsheng
> >
> > On Fri, 27 Sept 2024 at 06:58, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> >>
> >> On 2024/9/27 2:15, Mina Almasry wrote:
> >>>
> >>>> In order not to do the dma unmmapping after driver has already
> >>>> unbound and stall the unloading of the networking driver, add
> >>>> the pool->items array to record all the pages including the ones
> >>>> which are handed over to network stack, so the page_pool can
> >>>> do the dma unmmapping for those pages when page_pool_destroy()
> >>>> is called.
> >>>
> >>> One thing I could not understand from looking at the code: if the
> >>> items array is in the struct page_pool, why do you need to modify the
> >>> page_pool entry in the struct page and in the struct net_iov? I think
> >>> the code could be made much simpler if you can remove these changes,
> >>> and you wouldn't need to modify the public api of the page_pool.
> >>
> >> As mentioned in [1]:
> >> "There is no space in 'struct page' to track the inflight pages, so
> >> 'pp' in 'struct page' is renamed to 'pp_item' to enable the tracking
> >> of inflight page"
> >
> > I have the same feeling as Mina here. First of all, we do have an
> > unsigned long in struct page we use for padding IIRC. More
>
> I am assuming you are referring to '_pp_mapping_pad' in 'struct page',
> unfortunately the field might be used when a page is mmap'ed to user
> space as my understanding.
>

Ah good point, I just grepped for it and didn't look at the surrounding unions.

> https://elixir.bootlin.com/linux/v6.7-rc8/source/include/linux/mm_types.h#L126
>
> > importantly, though, why does struct page need to know about this?
> > Can't we have the same information in page pool?
> > When the driver allocates pages it does via page_pool_dev_alloc_XXXXX
> > or something similar. Cant we do what you suggest here ? IOW when we
> > allocate a page we put it in a list, and when that page returns to
> > page_pool (and it's mapped) we remove it.
>
> Yes, that is the basic idea, but the important part is how to do that
> with less performance impact.

Yes, but do you think that keeping that list of allocated pages in
struct page_pool will end up being more costly somehow compared to
struct page?

Thanks
/Ilias

