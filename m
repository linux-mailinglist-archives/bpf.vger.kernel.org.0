Return-Path: <bpf+bounces-49591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64865A1A8ED
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 18:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2D93A1D4B
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5C814831D;
	Thu, 23 Jan 2025 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UNo25tJw"
X-Original-To: bpf@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6278C1D555;
	Thu, 23 Jan 2025 17:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653145; cv=none; b=VNtWtsxXOYS9wHrTs7peB66MkZ77hh/KImUc+RJZQF6+ZZPWcc3yxCuav0qQBTJEmDdbZb5tk20kMKS7V+9Ya4cjAsRwV8GG4CKKXN8wnzd4hmonNvpiY55JM9dvK6DK3TXUdTWR6xjuaRmmwkIHUgv74GvFkWsggwVleFgRgdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653145; c=relaxed/simple;
	bh=4TCn3pPodSEmvCejH8ik+Z49uUg/I9ALcovorza8JCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o0yhLwrMPwxgZ8NbFN7vCC7XWWfkepAE3d969THi+phHkZuBPHWEyB1qLKbDNgQESWJcDhAFSJznlITJgdD68B7PHVyjFp88Ga3+e4DFcdsp7AESwUWoQ5x3E/hSB0aJaeLT+4uNzCot7wya7Y6IqP5xh5UJXaCAeKgTdYTYtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UNo25tJw; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DA42E1140201;
	Thu, 23 Jan 2025 12:25:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 23 Jan 2025 12:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737653140; x=1737739540; bh=k8m9xRoXO8qO8XqSfSEsQnhK07zXdgSA6Ni
	BY4fDmK4=; b=UNo25tJwNvq55hoKi4JZyWAOukNp8MvMH+iorVe5L5BUtzJpbWH
	WOgPg2idCOTbkZcaXMF2izFUNYgiUA226zegEY7nETeejoKK+GH4cPAHHv4+gaA2
	No75GzYsuQyJacbZ/eYKXTwsUp5TYVoBOqXy8fhIJRXV5XVcH0Pal2S4UxsEDI2y
	PiK4Z9B92Tr+O3VgNSW0x8IFzZwQqCDZSY/GmAMWjjp5lTbe8jfaOnEgLf29kSyi
	Zmn2Hsh1zynROQ0y+Xlq/WdjgYnxETOKDfFXFn47SlRtalgbMBFHUm6OAn4jc8gv
	6Y2A2ye8gvT1v9retfkZ+EYsHMj6Fa9pqsA==
X-ME-Sender: <xms:lHuSZ6Q3Y5mhqk8SqvLGEFZoc7L4C4Vq4ocMRY2ZtCGtclnoY4C5SA>
    <xme:lHuSZ_wkYj6yUvP4QaNCshFicFLEFVSJ38U4fHhzWFl_c5Y8FXlT2RCouTYHUppcV
    3sfLnqHFNasTZI>
X-ME-Received: <xmr:lHuSZ31_tFSo7XicJ0ebl7IM7PwV516qOGVdK7wpFbTNrS10D7tTqtr_-VRZ4XWdqF-L8PSDJvqpJ3GxWhzKC7OevWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhdqmhgrlhhlrgguih
    esthhirdgtohhmpdhrtghpthhtoheprhhoghgvrhhqsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghnihhshhgrnhifrghrsehtihdrtghomhdprhgtphhtthhopehprggsvg
    hnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfido
    nhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepsghpfhesvhhgvghrrdhkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:lHuSZ2AChG0X3LVUB2gLV-R46xtnlu9S7wKocCq7aBn071w8mSkmwg>
    <xmx:lHuSZzgHG-hOKyO9omZOfwtUNN30N8LBhwuTr08mKQZLsVHT4pvW4w>
    <xmx:lHuSZyr_hNQ478wEmCyozRK9lNuBXL9sCYjy_DkCidWjo73QJKas7w>
    <xmx:lHuSZ2jyNRP5R1jMWTP1nA7sQvc3TNA1p8s5fyyd7DwYXnIEhNNREw>
    <xmx:lHuSZyTkibneaWB543QSYzPQcrGBqLywyZCYoS_k1Xe33pUkaDUTZJac>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 12:25:39 -0500 (EST)
Date: Thu, 23 Jan 2025 19:25:36 +0200
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
Subject: Re: [PATCH net 3/3] net: ti: icssg-prueth: Add AF_XDP support
Message-ID: <Z5J7kGFU_ZgneFAF@shredder>
References: <20250122124951.3072410-1-m-malladi@ti.com>
 <20250122124951.3072410-4-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122124951.3072410-4-m-malladi@ti.com>

s/AF_XDP/XDP/ ?

On Wed, Jan 22, 2025 at 06:19:51PM +0530, Meghana Malladi wrote:
> From: Roger Quadros <rogerq@kernel.org>
> 
> Add native XDP support. We do not support zero copy yet.

There are various XDP features (e.g., NETDEV_XDP_ACT_BASIC) to tell the
stack what the driver supports. I don't see any of them being set here.

> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>

[...]

> +static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, int *xdp_state)
>  {
>  	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
>  	u32 buf_dma_len, pkt_len, port_id = 0;
> @@ -560,10 +732,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>  	struct page *page, *new_page;
>  	struct page_pool *pool;
>  	struct sk_buff *skb;
> +	struct xdp_buff xdp;
>  	u32 *psdata;
>  	void *pa;
>  	int ret;
>  
> +	*xdp_state = 0;
>  	pool = rx_chn->pg_pool;
>  	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
>  	if (ret) {
> @@ -602,8 +776,17 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>  		goto requeue;
>  	}
>  
> -	/* prepare skb and send to n/w stack */
>  	pa = page_address(page);
> +	if (emac->xdp_prog) {
> +		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
> +		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
> +
> +		*xdp_state = emac_run_xdp(emac, &xdp, page);
> +		if (*xdp_state != ICSSG_XDP_PASS)
> +			goto requeue;
> +	}
> +
> +	/* prepare skb and send to n/w stack */
>  	skb = build_skb(pa, prueth_rxbuf_total_len(pkt_len));
>  	if (!skb) {
>  		ndev->stats.rx_dropped++;

XDP program could have changed the packet length, but driver seems to be
building the skb using original length read from the descriptor.
Consider using xdp_build_skb_from_buff()

