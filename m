Return-Path: <bpf+bounces-49586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAFAA1A8C3
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8DE3AEA02
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F5213E71;
	Thu, 23 Jan 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eh6EBk3c"
X-Original-To: bpf@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B62D2135B9;
	Thu, 23 Jan 2025 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652376; cv=none; b=UdPm6fogCX3Ua63pebovEBFN/EJS19XUvnazgCnrXAZ4LySqRFDPfOvx8Xdlpdy/P9gVv26pXbleER9vbBwNmT1FjUJeF7rGeQZuFrOqmf7ZDLUWPDv0zKMh8tWLN9tb2AtiC8jNfCAFSlxCyNYcgImcD5paHG/15Yxdj+NPXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652376; c=relaxed/simple;
	bh=og5eZREnEIAgmEYL5YlBPxmy4pIcBaioyDtAqR/vUGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jN/BJOkaxqQltFA5ueQ3fqCpS1luWMK3YK0Jwdu/Z8oPMpgp5qUUTZWW3WTRsUdNN2Wvr0vMGy5qcZJPCFMXnw5YfnLRvUVIVSV3pt97VK2r3jWXbA06jiDNx5z5hDZdo8/Kpq0Z7GfOKFqtMTOl0aPncGbAZUB7x7Tu6KrgQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eh6EBk3c; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5492025401E0;
	Thu, 23 Jan 2025 12:12:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 23 Jan 2025 12:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737652372; x=
	1737738772; bh=IEdwzZuISYQ6gFd6Y29BLt5d39XZq4ploTAqqzTMaRA=; b=e
	h6EBk3c1w/NQUm2mYjcVbaY6u+1E8R4d014BEcdhXMd6Af56VlaS4Ncb5tvo+IWp
	Nq/+egPOnVNakhVSinsrk5awwcZdGtTHecBrJksIEPhJGmKBNNPepIFSjhCAzkug
	8nmKwG7yrYMPcePFrWoQGgGtU3OgetLncJ0dReuqO4150alM8bCuC2QAw4NLd9mq
	qdTv/G765xKkJ2+Caq3H7wrNvM8x9kIm1V4lwvIwn/RQIc2OENlSn9A8Co7sIAN3
	zkPzYx7lzEnEwEC2vIUGteU0McEvovx4n0n7lb2CrIspElG0jD5jz5EQ8dkHv1fn
	daGsF2Zc7C+JhuRsY40tA==
X-ME-Sender: <xms:kniSZ-TOY8B_0nge4ou-q-egMugh0vWcVkRM5tCkEew1H4hL7pKEag>
    <xme:kniSZzwLhlDLWqQq-L_wRFrK8uLsDxuZwtKgog_Qg9QLr4eAjKzKBp7gJnA_FSArw
    Bly7mxUHF93USI>
X-ME-Received: <xmr:kniSZ70I2xHaCgGKAQdCprcGimyEvG0pW0prYd1HVEwFEugA2bwsxPSjAA5x72eUAzNIoJJnsOveH4HDbIjwQWlxgjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepudelvdejjeehgfdvteehfeehteejjeefteej
    veeijefgueejffelffegkeffueeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgt
    hhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedvhedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepmhdqmhgrlhhlrgguihesthhirdgtohhmpdhrtghpthhtohep
    rhhoghgvrhhqsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihhshhgrnhifrg
    hrsehtihdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgrii
    gvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhf
    thdrnhgvthdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpd
    hrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kniSZ6DyO532XvOQ8-0hB5ZFlgpqhOP98c4akHlA-9bIAju9LkQw-A>
    <xmx:kniSZ3jSRXaRukRyKzoAmOdLnlagt5M2L3ZCtaAMZDWALfRsIOYF1g>
    <xmx:kniSZ2oJWa70WL3a3eWNl_Q8Kos-Iof5J52jFydJfs0gge19AbpPwg>
    <xmx:kniSZ6jPs0bXmET6mtpsn80XUyMneue42RzMRHMTN7S98bymJJglLg>
    <xmx:lHiSZ2QN7pwGCcQbU3twW_jw7WpV3qw2jueFCpmbch9ZCt17_SIwQ7ys>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 12:12:49 -0500 (EST)
Date: Thu, 23 Jan 2025 19:12:46 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, robh@kernel.org,
	matthias.schiffer@ew.tq-group.com, dan.carpenter@linaro.org,
	rdunlap@infradead.org, diogo.ivo@siemens.com,
	schnelle@linux.ibm.com, glaroque@baylibre.com,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net 1/3] net: ti: icssg-prueth: Use page_pool API for RX
 buffer allocation
Message-ID: <Z5J4jjJ4_arvfF9E@shredder>
References: <20250122124951.3072410-1-m-malladi@ti.com>
 <20250122124951.3072410-2-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250122124951.3072410-2-m-malladi@ti.com>

On Wed, Jan 22, 2025 at 06:19:49PM +0530, Meghana Malladi wrote:
> From: Roger Quadros <rogerq@kernel.org>
> 
> This is to prepare for native XDP support.
> 
> The page pool API is more faster in allocating pages than
> __alloc_skb(). Drawback is that it works at PAGE_SIZE granularity
> so we are not efficient in memory usage.
> i.e. we are using PAGE_SIZE (4KB) memory for 1.5KB max packet size.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

Patch is missing your SoB

> ---
>  drivers/net/ethernet/ti/Kconfig               |   1 +
>  drivers/net/ethernet/ti/icssg/icssg_common.c  | 180 ++++++++++++------
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  14 +-
>  .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  21 +-
>  4 files changed, 146 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 0d5a862cd78a..b461281d31b6 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -204,6 +204,7 @@ config TI_ICSSG_PRUETH_SR1
>  	select PHYLIB
>  	select TI_ICSS_IEP
>  	select TI_K3_CPPI_DESC_POOL
> +	select PAGE_POOL
>  	depends on PRU_REMOTEPROC
>  	depends on NET_SWITCHDEV
>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 74f0f200a89d..313667ce24c3 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -45,6 +45,11 @@ void prueth_cleanup_rx_chns(struct prueth_emac *emac,
>  			    struct prueth_rx_chn *rx_chn,
>  			    int max_rflows)
>  {
> +	if (rx_chn->pg_pool) {
> +		page_pool_destroy(rx_chn->pg_pool);
> +		rx_chn->pg_pool = NULL;
> +	}
> +
>  	if (rx_chn->desc_pool)
>  		k3_cppi_desc_pool_destroy(rx_chn->desc_pool);
>  
> @@ -461,17 +466,17 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  }
>  EXPORT_SYMBOL_GPL(prueth_init_rx_chns);
>  
> -int prueth_dma_rx_push(struct prueth_emac *emac,
> -		       struct sk_buff *skb,
> -		       struct prueth_rx_chn *rx_chn)
> +int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
> +			      struct prueth_rx_chn *rx_chn,
> +			      struct page *page, u32 buf_len)
>  {
>  	struct net_device *ndev = emac->ndev;
>  	struct cppi5_host_desc_t *desc_rx;
> -	u32 pkt_len = skb_tailroom(skb);
>  	dma_addr_t desc_dma;
>  	dma_addr_t buf_dma;
>  	void **swdata;
>  
> +	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;
>  	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
>  	if (!desc_rx) {
>  		netdev_err(ndev, "rx push: failed to allocate descriptor\n");
> @@ -479,25 +484,18 @@ int prueth_dma_rx_push(struct prueth_emac *emac,
>  	}
>  	desc_dma = k3_cppi_desc_pool_virt2dma(rx_chn->desc_pool, desc_rx);
>  
> -	buf_dma = dma_map_single(rx_chn->dma_dev, skb->data, pkt_len, DMA_FROM_DEVICE);
> -	if (unlikely(dma_mapping_error(rx_chn->dma_dev, buf_dma))) {
> -		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
> -		netdev_err(ndev, "rx push: failed to map rx pkt buffer\n");
> -		return -EINVAL;
> -	}
> -
>  	cppi5_hdesc_init(desc_rx, CPPI5_INFO0_HDESC_EPIB_PRESENT,
>  			 PRUETH_NAV_PS_DATA_SIZE);
>  	k3_udma_glue_rx_dma_to_cppi5_addr(rx_chn->rx_chn, &buf_dma);
> -	cppi5_hdesc_attach_buf(desc_rx, buf_dma, skb_tailroom(skb), buf_dma, skb_tailroom(skb));
> +	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
>  
>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
> -	*swdata = skb;
> +	*swdata = page;
>  
> -	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, 0,
> +	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
>  					desc_rx, desc_dma);
>  }
> -EXPORT_SYMBOL_GPL(prueth_dma_rx_push);
> +EXPORT_SYMBOL_GPL(prueth_dma_rx_push_mapped);
>  
>  u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns)
>  {
> @@ -535,18 +533,31 @@ void emac_rx_timestamp(struct prueth_emac *emac,
>  	ssh->hwtstamp = ns_to_ktime(ns);
>  }
>  
> +unsigned int prueth_rxbuf_total_len(unsigned int len)
> +{
> +	len += PRUETH_HEADROOM;
> +	len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	return SKB_DATA_ALIGN(len);
> +}
> +EXPORT_SYMBOL_GPL(prueth_rxbuf_total_len);
> +
>  static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>  {
>  	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
>  	u32 buf_dma_len, pkt_len, port_id = 0;
>  	struct net_device *ndev = emac->ndev;
>  	struct cppi5_host_desc_t *desc_rx;
> -	struct sk_buff *skb, *new_skb;
>  	dma_addr_t desc_dma, buf_dma;
> +	struct page *page, *new_page;
> +	struct page_pool *pool;
> +	struct sk_buff *skb;
>  	void **swdata;
>  	u32 *psdata;
> +	void *pa;
>  	int ret;
>  
> +	pool = rx_chn->pg_pool;
>  	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
>  	if (ret) {
>  		if (ret != -ENODATA)
> @@ -558,14 +569,8 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>  		return 0;
>  
>  	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
> -
>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
> -	skb = *swdata;
> -
> -	psdata = cppi5_hdesc_get_psdata(desc_rx);
> -	/* RX HW timestamp */
> -	if (emac->rx_ts_enabled)
> -		emac_rx_timestamp(emac, skb, psdata);
> +	page = *swdata;
>  
>  	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
>  	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
> @@ -574,32 +579,50 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>  	pkt_len -= 4;
>  	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
>  
> -	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>  
> -	skb->dev = ndev;
> -	new_skb = netdev_alloc_skb_ip_align(ndev, PRUETH_MAX_PKT_SIZE);
>  	/* if allocation fails we drop the packet but push the
> -	 * descriptor back to the ring with old skb to prevent a stall
> +	 * descriptor back to the ring with old page to prevent a stall
>  	 */
> -	if (!new_skb) {
> +	new_page = page_pool_dev_alloc_pages(pool);

I don't see where the reference is released via a put call

> +	if (unlikely(!new_page)) {
> +		new_page = page;
>  		ndev->stats.rx_dropped++;
> -		new_skb = skb;
> -	} else {
> -		/* send the filled skb up the n/w stack */
> -		skb_put(skb, pkt_len);
> -		if (emac->prueth->is_switch_mode)
> -			skb->offload_fwd_mark = emac->offload_fwd_mark;
> -		skb->protocol = eth_type_trans(skb, ndev);
> -		napi_gro_receive(&emac->napi_rx, skb);
> -		ndev->stats.rx_bytes += pkt_len;
> -		ndev->stats.rx_packets++;
> +		goto requeue;
>  	}
>  
> +	/* prepare skb and send to n/w stack */
> +	pa = page_address(page);
> +	skb = build_skb(pa, prueth_rxbuf_total_len(pkt_len));

napi_build_skb()? See commit 53ee91427177 ("net/mlx5e: Switch to using
napi_build_skb()")

Also, I believe the frag size is incorrect. It is used to initialize
skb->truesize which should signal the size of the buffer that was
allocated for the packet (PAGE_SIZE in this case).

> +	if (!skb) {
> +		ndev->stats.rx_dropped++;
> +		page_pool_recycle_direct(pool, page);
> +		goto requeue;
> +	}
> +
> +	skb_reserve(skb, PRUETH_HEADROOM);
> +	skb_put(skb, pkt_len);
> +	skb->dev = ndev;
> +
> +	psdata = cppi5_hdesc_get_psdata(desc_rx);
> +	/* RX HW timestamp */
> +	if (emac->rx_ts_enabled)
> +		emac_rx_timestamp(emac, skb, psdata);
> +
> +	if (emac->prueth->is_switch_mode)
> +		skb->offload_fwd_mark = emac->offload_fwd_mark;
> +	skb->protocol = eth_type_trans(skb, ndev);

skb_mark_for_recycle() ?

> +
> +	netif_receive_skb(skb);

The code was previously using napi_gro_receive(), why give up on GRO
support?

> +	ndev->stats.rx_bytes += pkt_len;
> +	ndev->stats.rx_packets++;
> +
> +requeue:
>  	/* queue another RX DMA */
> -	ret = prueth_dma_rx_push(emac, new_skb, &emac->rx_chns);
> +	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
> +					PRUETH_MAX_PKT_SIZE);
>  	if (WARN_ON(ret < 0)) {
> -		dev_kfree_skb_any(new_skb);
> +		page_pool_recycle_direct(pool, new_page);
>  		ndev->stats.rx_errors++;
>  		ndev->stats.rx_dropped++;
>  	}
> @@ -611,22 +634,17 @@ static void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
>  {
>  	struct prueth_rx_chn *rx_chn = data;
>  	struct cppi5_host_desc_t *desc_rx;
> -	struct sk_buff *skb;
> -	dma_addr_t buf_dma;
> -	u32 buf_dma_len;
> +	struct page_pool *pool;
> +	struct page *page;
>  	void **swdata;
>  
> +	pool = rx_chn->pg_pool;
> +
>  	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
> -	skb = *swdata;
> -	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
> -	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
> -
> -	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len,
> -			 DMA_FROM_DEVICE);
> +	page = *swdata;
> +	page_pool_recycle_direct(pool, page);
>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
> -
> -	dev_kfree_skb_any(skb);
>  }
>  
>  static int prueth_tx_ts_cookie_get(struct prueth_emac *emac)
> @@ -907,29 +925,70 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>  }
>  EXPORT_SYMBOL_GPL(icssg_napi_rx_poll);
>  
> +static struct page_pool *prueth_create_page_pool(struct prueth_emac *emac,
> +						 struct device *dma_dev,
> +						 int size)
> +{
> +	struct page_pool_params pp_params = { 0 };
> +	struct page_pool *pool;
> +
> +	pp_params.order = 0;
> +	pp_params.flags = PP_FLAG_DMA_MAP;

What about PP_FLAG_DMA_SYNC_DEV ? I don't see a sync for device call. I
also don't see a sync for CPU...

> +	pp_params.pool_size = size;
> +	pp_params.nid = dev_to_node(emac->prueth->dev);
> +	pp_params.dma_dir = DMA_BIDIRECTIONAL;
> +	pp_params.dev = dma_dev;
> +	pp_params.napi = &emac->napi_rx;
> +
> +	pool = page_pool_create(&pp_params);
> +	if (IS_ERR(pool))
> +		netdev_err(emac->ndev, "cannot create rx page pool\n");
> +
> +	return pool;
> +}
> +
>  int prueth_prepare_rx_chan(struct prueth_emac *emac,
>  			   struct prueth_rx_chn *chn,
>  			   int buf_size)
>  {
> -	struct sk_buff *skb;
> +	struct page_pool *pool;
> +	struct page *page;
>  	int i, ret;
>  
> +	pool = prueth_create_page_pool(emac, chn->dma_dev, chn->descs_num);
> +	if (IS_ERR(pool))
> +		return PTR_ERR(pool);
> +
> +	chn->pg_pool = pool;
> +
>  	for (i = 0; i < chn->descs_num; i++) {
> -		skb = __netdev_alloc_skb_ip_align(NULL, buf_size, GFP_KERNEL);
> -		if (!skb)
> -			return -ENOMEM;
> +		/* NOTE: we're not using memory efficiently here.
> +		 * 1 full page (4KB?) used here instead of
> +		 * PRUETH_MAX_PKT_SIZE (~1.5KB?)
> +		 */

What about using page_pool_alloc_frag()? Never used it, but the
documentation says:

2. page_pool_alloc_frag(): allocate memory with page splitting when
driver knows that the memory it need is always smaller than or equal to
half of the page allocated from page pool. Page splitting enables memory
saving and thus avoids TLB/cache miss for data access, but there also is
some cost to implement page splitting, mainly some cache line
dirtying/bouncing for ‘struct page’ and atomic operation for
page->pp_ref_count.

https://docs.kernel.org/networking/page_pool.html

> +		page = page_pool_dev_alloc_pages(pool);
> +		if (!page) {
> +			netdev_err(emac->ndev, "couldn't allocate rx page\n");
> +			ret = -ENOMEM;
> +			goto recycle_alloc_pg;
> +		}
>  
> -		ret = prueth_dma_rx_push(emac, skb, chn);
> +		ret = prueth_dma_rx_push_mapped(emac, chn, page, buf_size);
>  		if (ret < 0) {
>  			netdev_err(emac->ndev,
> -				   "cannot submit skb for rx chan %s ret %d\n",
> +				   "cannot submit page for rx chan %s ret %d\n",
>  				   chn->name, ret);
> -			kfree_skb(skb);
> -			return ret;
> +			page_pool_recycle_direct(pool, page);
> +			goto recycle_alloc_pg;
>  		}
>  	}
>  
>  	return 0;
> +
> +recycle_alloc_pg:
> +	prueth_reset_rx_chan(&emac->rx_chns, PRUETH_MAX_RX_FLOWS, false);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(prueth_prepare_rx_chan);
>  
> @@ -958,6 +1017,9 @@ void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
>  					  prueth_rx_cleanup, !!i);
>  	if (disable)
>  		k3_udma_glue_disable_rx_chn(chn->rx_chn);
> +
> +	page_pool_destroy(chn->pg_pool);
> +	chn->pg_pool = NULL;
>  }
>  EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
>  
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 5473315ea204..62f3d04af222 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -33,6 +33,8 @@
>  #include <linux/dma/k3-udma-glue.h>
>  
>  #include <net/devlink.h>
> +#include <net/xdp.h>
> +#include <net/page_pool/helpers.h>
>  
>  #include "icssg_config.h"
>  #include "icss_iep.h"
> @@ -125,6 +127,7 @@ struct prueth_rx_chn {
>  	u32 descs_num;
>  	unsigned int irq[ICSSG_MAX_RFLOWS];	/* separate irq per flow */
>  	char name[32];
> +	struct page_pool *pg_pool;
>  };
>  
>  /* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
> @@ -202,6 +205,10 @@ struct prueth_emac {
>  	unsigned long rx_pace_timeout_ns;
>  };
>  
> +/* The buf includes headroom compatible with both skb and xdpf */
> +#define PRUETH_HEADROOM_NA (max(XDP_PACKET_HEADROOM, NET_SKB_PAD) + NET_IP_ALIGN)
> +#define PRUETH_HEADROOM  ALIGN(PRUETH_HEADROOM_NA, sizeof(long))
> +
>  /**
>   * struct prueth_pdata - PRUeth platform data
>   * @fdqring_mode: Free desc queue mode
> @@ -402,9 +409,10 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>  			struct prueth_rx_chn *rx_chn,
>  			char *name, u32 max_rflows,
>  			u32 max_desc_num);
> -int prueth_dma_rx_push(struct prueth_emac *emac,
> -		       struct sk_buff *skb,
> -		       struct prueth_rx_chn *rx_chn);
> +int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
> +			      struct prueth_rx_chn *rx_chn,
> +			      struct page *page, u32 buf_len);
> +unsigned int prueth_rxbuf_total_len(unsigned int len);
>  void emac_rx_timestamp(struct prueth_emac *emac,
>  		       struct sk_buff *skb, u32 *psdata);
>  enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev);
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index 3dc86397c367..c2bc7169355a 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -274,10 +274,12 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
>  	struct prueth_rx_chn *rx_chn = &emac->rx_mgm_chn;
>  	struct net_device *ndev = emac->ndev;
>  	struct cppi5_host_desc_t *desc_rx;
> -	struct sk_buff *skb, *new_skb;
> +	struct page *page, *new_page;
>  	dma_addr_t desc_dma, buf_dma;
>  	u32 buf_dma_len, pkt_len;
> +	struct sk_buff *skb;
>  	void **swdata;
> +	void *pa;
>  	int ret;
>  
>  	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
> @@ -299,32 +301,35 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
>  	}
>  
>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
> -	skb = *swdata;
> +	page = *swdata;
>  	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
>  	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
>  
>  	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>  
> -	new_skb = netdev_alloc_skb_ip_align(ndev, PRUETH_MAX_PKT_SIZE);
> +	new_page = page_pool_dev_alloc_pages(rx_chn->pg_pool);
>  	/* if allocation fails we drop the packet but push the
>  	 * descriptor back to the ring with old skb to prevent a stall
>  	 */
> -	if (!new_skb) {
> +	if (!new_page) {
>  		netdev_err(ndev,
> -			   "skb alloc failed, dropped mgm pkt from flow %d\n",
> +			   "page alloc failed, dropped mgm pkt from flow %d\n",
>  			   flow_id);
> -		new_skb = skb;
> +		new_page = page;
>  		skb = NULL;	/* return NULL */
>  	} else {
>  		/* return the filled skb */
> +		pa = page_address(page);
> +		skb = build_skb(pa, prueth_rxbuf_total_len(pkt_len));
>  		skb_put(skb, pkt_len);
>  	}
>  
>  	/* queue another DMA */
> -	ret = prueth_dma_rx_push(emac, new_skb, &emac->rx_mgm_chn);
> +	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
> +					PRUETH_MAX_PKT_SIZE);
>  	if (WARN_ON(ret < 0))
> -		dev_kfree_skb_any(new_skb);
> +		page_pool_recycle_direct(rx_chn->pg_pool, new_page);
>  
>  	return skb;
>  }
> -- 
> 2.25.1
> 
> 

