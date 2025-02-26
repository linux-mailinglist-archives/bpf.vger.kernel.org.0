Return-Path: <bpf+bounces-52631-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09506A45C1F
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 11:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49090188E7C3
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 10:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D6C24E00E;
	Wed, 26 Feb 2025 10:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zzg+ML9+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28EB85931
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 10:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740566974; cv=none; b=o6QQd7ezmqytKrx06Jrhdhf+L3ZF63iBLjpNBo45VVdC1XnStf07FBtAYvG4mwI2PYUb1LJ1GmLu+zOWtNSgJFP9RrpBYehAEdcIbZ1QgQzaR6a6XX5mwclYO03m5TtBDVtrGDPVhxhPFD6a8pqtboqtBw3muqwmy8pk6vzwX+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740566974; c=relaxed/simple;
	bh=z9xcqV/UosO5ZJWe2c4vL/xb2rxKmkUhna/cQN331Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQQxMjgAX28FpNYYUIAIjR5H0Sk/9h4DAv/hUhb6z7Q1BIOy461bo+TXGXenvDPui9n1c8/EnmcW6LkmBjW56FHPey6KQ17rmY8g3V7rBHJj2k7WPlRsojDMvUhtbfItpm0ol4MwAjZPKnuhIXwcUT0+wOgGXWab+xULFLG7H/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zzg+ML9+; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so9710693a12.1
        for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 02:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740566970; x=1741171770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pi6WJ28vvEWFjLtni81xp9MLpaIOuEpXCoL6YJHYkA4=;
        b=zzg+ML9+snEOEw0qfvsAIJ6tzY8QGmFpLxDYMqs1jqsE2JbVD/fZVJOZOPplzkJikY
         HLw3WkqLtQdo7BusCoB3etrYi0AwF+PD+kH49MFlI6u/V0P9uTSSJ/nkJyIufozkm8iv
         I5b+/Wep6hE8t3+np58wOBrEOaK6tMfCqExnZ4+CUGMrkz8CC8GRdLkWxnDFcXGaeQ7g
         qn5DYk1pbJwuJIwlJTAdCD75oyY8xhfWrN8LgZNxR/WJtgUPJIyRIyK7Qf9K31DleKuZ
         9aNYv8WFIES2xU13VFiN/D0HAZ2aJ9XRaNPE73VJRXJ17y8gf78z+edoAnmgpIBrwyu9
         mCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740566970; x=1741171770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pi6WJ28vvEWFjLtni81xp9MLpaIOuEpXCoL6YJHYkA4=;
        b=gNd3XLEkHLLZHvEm6+LMil9h3KcRcLWeFPwwBCzv7s8inLYqO06tg0laqcn9Kemx3p
         N/5IL42eotOva5cDPFOwmCv/enZpdXjtjrkSWZFFTrHXg4l77yX24ow6CyMokMznQjjR
         5MJaneZ+Xrrpjn/Az/WHFa1KCPM+E8aB0N8jVyzGRsIG1wpmKAvaZxOySjtWNs7Snlaa
         ojR5YNdhTX1mEKVqu37hwFHQER7Cxh5C0HrqO6zno3+C6/LuOvJ+x/AJzJj3/zzGH7RZ
         jz3zbKkMBKU4TMGkVwpe3VVF9MyA1XXFmE/8Ybk2RGOKgmei9Zurwta61wWYka/X1Sgw
         LiDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcJD+MVSaLW3rTBXFHT6LxTma9cCZyCsdso1OchYnI7yofFIm6P5+RylWqAsY9gN/52iI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTwhEgo1wZ26lb4AAUQ36LWLnpiS0J80JWHXAXqDiHJQs+xTe
	Ohs5kusoTYMB3s3PzUihj7a7sFNUA2h/qla7UuRWB6QL3rG1cL+O/J39EwfXowY=
X-Gm-Gg: ASbGncsbG96YkyUAdVUpbAKLWjhfZYqnR3Vj54AG0widsjCL1eicJosY0kTp1PSF6ls
	+Qv1ztx85wG1i5213xtDS+YcNV1qQ7ryxeGdklT6oYCDbCpHGM9DB/38+ksuB5O5/C+IQIZc3ns
	vSg9IHvKtPPIBGsWwh3rb070xHRGoOGEmLzt45jWC7SFfORB09cFg7IpYK2qZvv9oIKtc4wNMsv
	q789z3vu/p5KCYG2HYRrWRJSTiSFgHlauBAAENxD45zS/G1zwIwUUdWJFo0qZFz5FzQlPNAYXC9
	VMTAAFGdnMFpqr3gcLd+wh6mBg8+/cE=
X-Google-Smtp-Source: AGHT+IHboJc5jNRiF6+HVnUsvC83uOT9sWDzDzjF2aDgj8PSLcgjjjzDUmuVpcXr+wjn2QMqiog8WA==
X-Received: by 2002:a17:907:971e:b0:abb:9d27:290e with SMTP id a640c23a62f3a-abeeef35497mr334786166b.41.1740566969952;
        Wed, 26 Feb 2025 02:49:29 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abed1cdc46bsm304605266b.20.2025.02.26.02.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 02:49:29 -0800 (PST)
Date: Wed, 26 Feb 2025 13:49:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meghana Malladi <m-malladi@ti.com>
Cc: rogerq@kernel.org, danishanwar@ti.com, pabeni@redhat.com,
	kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
	andrew+netdev@lunn.ch, bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, u.kleine-koenig@baylibre.com,
	matthias.schiffer@ew.tq-group.com, schnelle@linux.ibm.com,
	diogo.ivo@siemens.com, glaroque@baylibre.com, macro@orcam.me.uk,
	john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
	ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add XDP support
Message-ID: <d362a527-88cf-4cd5-a22f-7eeb938d4469@stanley.mountain>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-4-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224110102.1528552-4-m-malladi@ti.com>

On Mon, Feb 24, 2025 at 04:31:02PM +0530, Meghana Malladi wrote:
> @@ -541,7 +558,153 @@ void emac_rx_timestamp(struct prueth_emac *emac,
>  	ssh->hwtstamp = ns_to_ktime(ns);
>  }
>  
> -static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
> +/**
> + * emac_xmit_xdp_frame - transmits an XDP frame
> + * @emac: emac device
> + * @xdpf: data to transmit
> + * @page: page from page pool if already DMA mapped
> + * @q_idx: queue id
> + *
> + * Return: XDP state
> + */
> +int emac_xmit_xdp_frame(struct prueth_emac *emac,
> +			struct xdp_frame *xdpf,
> +			struct page *page,
> +			unsigned int q_idx)
> +{
> +	struct cppi5_host_desc_t *first_desc;
> +	struct net_device *ndev = emac->ndev;
> +	struct prueth_tx_chn *tx_chn;
> +	dma_addr_t desc_dma, buf_dma;
> +	struct prueth_swdata *swdata;
> +	u32 *epib;
> +	int ret;
> +
> +	void *data = xdpf->data;
> +	u32 pkt_len = xdpf->len;

Get rid of these variables?

> +
> +	if (q_idx >= PRUETH_MAX_TX_QUEUES) {
> +		netdev_err(ndev, "xdp tx: invalid q_id %d\n", q_idx);
> +		return ICSSG_XDP_CONSUMED;	/* drop */
> +	}
> +
> +	tx_chn = &emac->tx_chns[q_idx];
> +
> +	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
> +	if (!first_desc) {
> +		netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
> +		goto drop_free_descs;	/* drop */
> +	}
> +
> +	if (page) { /* already DMA mapped by page_pool */
> +		buf_dma = page_pool_get_dma_addr(page);
> +		buf_dma += xdpf->headroom + sizeof(struct xdp_frame);
> +	} else { /* Map the linear buffer */
> +		buf_dma = dma_map_single(tx_chn->dma_dev, data, pkt_len, DMA_TO_DEVICE);
> +		if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
> +			netdev_err(ndev, "xdp tx: failed to map data buffer\n");
> +			goto drop_free_descs;	/* drop */
> +		}
> +	}
> +
> +	cppi5_hdesc_init(first_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
> +			 PRUETH_NAV_PS_DATA_SIZE);
> +	cppi5_hdesc_set_pkttype(first_desc, 0);
> +	epib = first_desc->epib;
> +	epib[0] = 0;
> +	epib[1] = 0;
> +
> +	/* set dst tag to indicate internal qid at the firmware which is at
> +	 * bit8..bit15. bit0..bit7 indicates port num for directed
> +	 * packets in case of switch mode operation
> +	 */
> +	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
> +	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
> +	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
> +	swdata = cppi5_hdesc_get_swdata(first_desc);
> +	if (page) {
> +		swdata->type = PRUETH_SWDATA_PAGE;
> +		swdata->data.page = page;
> +	} else {
> +		swdata->type = PRUETH_SWDATA_XDPF;
> +		swdata->data.xdpf = xdpf;
> +	}
> +
> +	cppi5_hdesc_set_pktlen(first_desc, pkt_len);
> +	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
> +
> +	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
> +	if (ret) {
> +		netdev_err(ndev, "xdp tx: push failed: %d\n", ret);
> +		goto drop_free_descs;
> +	}
> +
> +	return ICSSG_XDP_TX;
> +
> +drop_free_descs:
> +	prueth_xmit_free(tx_chn, first_desc);
> +	return ICSSG_XDP_CONSUMED;
> +}
> +EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
> +
> +/**
> + * emac_run_xdp - run an XDP program
> + * @emac: emac device
> + * @xdp: XDP buffer containing the frame
> + * @page: page with RX data if already DMA mapped
> + *
> + * Return: XDP state
> + */
> +static int emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
> +			struct page *page)
> +{
> +	struct net_device *ndev = emac->ndev;
> +	int err, result = ICSSG_XDP_PASS;
> +	struct bpf_prog *xdp_prog;
> +	struct xdp_frame *xdpf;
> +	int q_idx;
> +	u32 act;
> +
> +	xdp_prog = READ_ONCE(emac->xdp_prog);
> +	act = bpf_prog_run_xdp(xdp_prog, xdp);
> +	switch (act) {
> +	case XDP_PASS:
> +		break;
> +	case XDP_TX:
> +		/* Send packet to TX ring for immediate transmission */
> +		xdpf = xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf))

This is the second unlikely() macro which is added in this patchset.
The rule with likely/unlikely() is that it should only be added if it
likely makes a difference in benchmarking.  Quite often the compiler
is able to predict that valid pointers are more likely than NULL
pointers so often these types of annotations don't make any difference
at all to the compiled code.  But it depends on the compiler and the -O2
options.

> +			goto drop;
> +
> +		q_idx = smp_processor_id() % emac->tx_ch_num;
> +		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
> +		if (result == ICSSG_XDP_CONSUMED)
> +			goto drop;
> +		break;
> +	case XDP_REDIRECT:
> +		err = xdp_do_redirect(emac->ndev, xdp, xdp_prog);
> +		if (err)
> +			goto drop;
> +		result = ICSSG_XDP_REDIR;
> +		break;
> +	default:
> +		bpf_warn_invalid_xdp_action(emac->ndev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +drop:
> +		trace_xdp_exception(emac->ndev, xdp_prog, act);
> +		fallthrough; /* handle aborts by dropping packet */
> +	case XDP_DROP:
> +		ndev->stats.tx_dropped++;
> +		result = ICSSG_XDP_CONSUMED;
> +		page_pool_recycle_direct(emac->rx_chns.pg_pool, page);
> +		break;
> +	}
> +
> +	return result;
> +}
> +
> +static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, int *xdp_state)


xdp_state should be a u32 because it's a bitfield.  Bitfields are never
signed.

>  {
>  	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
>  	u32 buf_dma_len, pkt_len, port_id = 0;
> @@ -552,10 +715,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
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
> @@ -596,9 +761,21 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>  		goto requeue;
>  	}
>  
> -	/* prepare skb and send to n/w stack */
>  	pa = page_address(page);
> -	skb = napi_build_skb(pa, PAGE_SIZE);
> +	if (emac->xdp_prog) {
> +		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
> +		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
> +
> +		*xdp_state = emac_run_xdp(emac, &xdp, page);
> +		if (*xdp_state == ICSSG_XDP_PASS)
> +			skb = xdp_build_skb_from_buff(&xdp);
> +		else
> +			goto requeue;
> +	} else {
> +		/* prepare skb and send to n/w stack */
> +		skb = napi_build_skb(pa, PAGE_SIZE);
> +	}
> +
>  	if (!skb) {
>  		ndev->stats.rx_dropped++;
>  		page_pool_recycle_direct(pool, page);
> @@ -861,13 +1038,23 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
>  	struct prueth_tx_chn *tx_chn = data;
>  	struct cppi5_host_desc_t *desc_tx;
>  	struct prueth_swdata *swdata;
> +	struct xdp_frame *xdpf;
>  	struct sk_buff *skb;
>  
>  	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
>  	swdata = cppi5_hdesc_get_swdata(desc_tx);
> -	if (swdata->type == PRUETH_SWDATA_SKB) {
> +
> +	switch (swdata->type) {
> +	case PRUETH_SWDATA_SKB:
>  		skb = swdata->data.skb;
>  		dev_kfree_skb_any(skb);
> +		break;
> +	case PRUETH_SWDATA_XDPF:
> +		xdpf = swdata->data.xdpf;
> +		xdp_return_frame(xdpf);
> +		break;
> +	default:
> +		break;
>  	}
>  
>  	prueth_xmit_free(tx_chn, desc_tx);
> @@ -904,15 +1091,18 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>  		PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
>  	int flow = emac->is_sr1 ?
>  		PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
> +	int xdp_state_or = 0;
>  	int num_rx = 0;
>  	int cur_budget;
> +	int xdp_state;

Both xdp_state_or and xdp_state should be u32 because they are bitfields.

regards,
dan carpenter

>  	int ret;
>  
>  	while (flow--) {
>  		cur_budget = budget - num_rx;
>  
>  		while (cur_budget--) {
> -			ret = emac_rx_packet(emac, flow);
> +			ret = emac_rx_packet(emac, flow, &xdp_state);
> +			xdp_state_or |= xdp_state;
>  			if (ret)
>  				break;
>  			num_rx++;


