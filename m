Return-Path: <bpf+bounces-35239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1477A939269
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 18:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DB251C216D1
	for <lists+bpf@lfdr.de>; Mon, 22 Jul 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423AE16EB66;
	Mon, 22 Jul 2024 16:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Hq5VLwpm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040054657
	for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721665057; cv=none; b=c2YkLTiPYC6MIhAmJfV439tQ1uaui6bG0NLs2/pa7UocCY9xxv6fo1K+2EZvAn09rj13DM+6klFV4AtS2ILafsWOng7aDICetlpIhtFG94MCbr/zTWH/zNniQGOoXivFT5YHKVlIvSvha5bKrDu2Ds4obEsBMgsPmDK5Vy9KpqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721665057; c=relaxed/simple;
	bh=r+a3M5u9pOMv/hVClE5hBqlyEDdBMEAW8unLWpcUwR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm4iGxnHgxTwhC4DzoGA7JkzdBSa+fvevE4GoK+uQcq3sQIE3+qBAkQBYOCACU5qCD2ToTSrETK9WUI58flqAx19HdYvE322xM10LZkSzwAnWlF6t2Zvdw9L9SRByyJ1SIANH2RD6Kg2gpTY5MnOuJl+/IcpSes4RF+v2CMDo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Hq5VLwpm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fd65aaac27so18012075ad.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1721665055; x=1722269855; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac4TBOhO4Lvkf/O2AokVMuwcwMPMmOE7Ro7pJm1rvQk=;
        b=Hq5VLwpmREuwnMRPZQ+yCIBn2K2nMg/eykIi9J4qjoyMqf2IgM2qb7gSTVeI7aedH8
         EEgMn7vBvRZMllGUGzkqfKMIr5tnt2h1HYgLNcd9yz7KaihmfKdoyjIBOuQf2QejlRqM
         FkcIssgy/2ca0lpYScwZIUPghAoTQX7SRnMh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721665055; x=1722269855;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ac4TBOhO4Lvkf/O2AokVMuwcwMPMmOE7Ro7pJm1rvQk=;
        b=W9X3+e06RA3KXzYvRIw4zrQpnagwVgNIgIovhnZUcq2Ng+CA1FuMcptjxoN3AqsXCV
         s/G4T/YNluxpfxlKbPf8oLaYRqglv7El2l1eAcpQBUQ1D5NI1yco1L9sVia6PPlZ31AB
         I9dvfGoroBwaj3a8GY4wD2DRz2xbHQ8BEvYfZhbDwgcpksD/pLl3GjB/GnoYHZJ6T2BE
         DhkXlhiBDmMViZgVuzsdXyJ0cuQOIRZDtKvFYj+70/o0sybMRCgYyxi/BL96Ra/OZOIa
         zWbBKzXQbzZ6ZteVOklpcirbrj2xrzznKbTVOePc1mwLx+34wYzPycw7vq4mvZe7TW2z
         t1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCX1vRGa63mXyhaA1otCXKVF0QKOLz9ohSwXVYXy1oXHJCw3jGeWB6cJNJq+5q9xeKEBFqLk19bqJawjPnXg0kgNhdTZ
X-Gm-Message-State: AOJu0YwKvacPsokFXKXuOBeSgputspxG2UhFYjA50tJHfUDjaZXJKNj+
	pXZH0toMmwuPmobup7mAfYCjrEoZzyc0FFNqxH9C8FzNdnFmvfD3hmJbkneSggI=
X-Google-Smtp-Source: AGHT+IFB2y7zOFl4+Y01VeT43wEsBkhPo0FQ49eT3GIcwc/I7mB7L8n/Y/dKG9HTsZ7eJjeY9OWniQ==
X-Received: by 2002:a17:902:cec4:b0:1fd:b5fe:ee91 with SMTP id d9443c01a7336-1fdb5fef138mr3886125ad.25.1721665054849;
        Mon, 22 Jul 2024 09:17:34 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1dbfe395sm2640504b3a.218.2024.07.22.09.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 09:17:34 -0700 (PDT)
Date: Mon, 22 Jul 2024 09:17:31 -0700
From: Joe Damato <jdamato@fastly.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: daniel@makrotopia.org, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next RFC] net: ethernet: mtk_eth_soc: use prefetch
 methods
Message-ID: <Zp6GGzaJXhBcnGkC@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Elad Yifee <eladwf@gmail.com>, daniel@makrotopia.org,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
References: <20240720164621.1983-1-eladwf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240720164621.1983-1-eladwf@gmail.com>

On Sat, Jul 20, 2024 at 07:46:18PM +0300, Elad Yifee wrote:
> Utilize kernel prefetch methods for faster cache line access.
> This change boosts driver performance,
> allowing the CPU to handle about 5% more packets/sec.

Nit: It'd be great to see before/after numbers and/or an explanation of
how you measured this in the commit message.

> Signed-off-by: Elad Yifee <eladwf@gmail.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index 0cc2dd85652f..1a0704166103 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1963,6 +1963,7 @@ static u32 mtk_xdp_run(struct mtk_eth *eth, struct mtk_rx_ring *ring,
>  	if (!prog)
>  		goto out;
>  
> +	prefetchw(xdp->data_hard_start);

Is there any reason to mix net_prefetch (as you have below) with
prefetch and prefetchw ?

IMHO: you should consider using net_prefetch and net_prefetchw
everywhere instead of using both in your code.

>  	act = bpf_prog_run_xdp(prog, xdp);
>  	switch (act) {
>  	case XDP_PASS:
> @@ -2039,7 +2040,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  		idx = NEXT_DESP_IDX(ring->calc_idx, ring->dma_size);
>  		rxd = ring->dma + idx * eth->soc->rx.desc_size;
>  		data = ring->data[idx];
> -
> +		prefetch(rxd);

Maybe net_prefetch instead, as mentioned above?

>  		if (!mtk_rx_get_desc(eth, &trxd, rxd))
>  			break;
>  
> @@ -2105,6 +2106,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  			if (ret != XDP_PASS)
>  				goto skip_rx;
>  
> +			net_prefetch(xdp.data_meta);
>  			skb = build_skb(data, PAGE_SIZE);
>  			if (unlikely(!skb)) {
>  				page_pool_put_full_page(ring->page_pool,
> @@ -2113,6 +2115,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  				goto skip_rx;
>  			}
>  
> +			prefetchw(skb->data);

Maybe net_prefetchw instead, as mentioned above?

>  			skb_reserve(skb, xdp.data - xdp.data_hard_start);
>  			skb_put(skb, xdp.data_end - xdp.data);
>  			skb_mark_for_recycle(skb);
> @@ -2143,6 +2146,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  			dma_unmap_single(eth->dma_dev, ((u64)trxd.rxd1 | addr64),
>  					 ring->buf_size, DMA_FROM_DEVICE);
>  
> +			net_prefetch(data);
>  			skb = build_skb(data, ring->frag_size);
>  			if (unlikely(!skb)) {
>  				netdev->stats.rx_dropped++;
> @@ -2150,6 +2154,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
>  				goto skip_rx;
>  			}
>  
> +			prefetchw(skb->data);

Maybe net_prefetchw instead, as mentioned above?

