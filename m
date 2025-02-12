Return-Path: <bpf+bounces-51273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D315A32B13
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 17:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5D3163172
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 16:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F054211719;
	Wed, 12 Feb 2025 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNAkOXdw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33D1D89E4;
	Wed, 12 Feb 2025 16:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376231; cv=none; b=j8GjbfMkoOLbbIMtajwAmBfkYhPcP9QKH2/5rz1P7xaUAal6q1aGiSKIo6blcVbBN0u67VwuB12zN/gMfVQnDX7ISU6Eiyu45DBWFiy66TWFF5VAi3fHxGS6uCCzs3XbiPbtBqwqlXs/dIXaeQl08MXM215csNvz7NMtEJb94T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376231; c=relaxed/simple;
	bh=2JKdaQTpWO1Q3gTWst66vYJLHfh8N2qQrRkclzb0nR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MGTNo//O/ZiNLp2Srdlv4E3wwV8TytLto6XFtPPTxhhsFJonR6eiRu3SyKYOYra98qObuxeistldpDbBxP0JxGmIyWMbCZCOGfeksVC6RbTtOhUEXJ3E/dfwcLwCSgiiOxjfxep+yiZREItErn2zR5ZkOTj32krzCdubcZhJMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNAkOXdw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABA6C4CEDF;
	Wed, 12 Feb 2025 16:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739376231;
	bh=2JKdaQTpWO1Q3gTWst66vYJLHfh8N2qQrRkclzb0nR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vNAkOXdwDnMgG6kKP0fyQhHC+hJcvkde0NpgpYjoC7OWF68N0l+T1dVgysHxa9CEW
	 Xw2U7m8TdQuEI2o56CC7IO6qCPFhMLQKMMQri9r/UFN4xETp0otKt2WZQ3xFVAvszS
	 4xWeRWz+bNwIwMUjzTFi+zz1XzAQfMhx7zV5slaomDMn2utIpoeqjCJJEcIO6havxJ
	 EB+y8srOlQjhVOybEZMHKwMHzK+mw6QaGOHFeEY08E3T5P0Axb3+NqBW+3mWcxuUcs
	 CXrBU5teTYEw6EKb3HhtPK0FpF0yEsp91NsRelc1GdYSPQI5xBigqU4sBvsxKS4ueP
	 /hbuJaKeIIdDQ==
Message-ID: <85bb807f-7ad6-4245-95cd-ccecbc1817de@kernel.org>
Date: Wed, 12 Feb 2025 18:03:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/3] net: ti: icssg-prueth: Add XDP support
To: Meghana Malladi <m-malladi@ti.com>, danishanwar@ti.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 u.kleine-koenig@baylibre.com, krzysztof.kozlowski@linaro.org,
 dan.carpenter@linaro.org, schnelle@linux.ibm.com, glaroque@baylibre.com,
 rdunlap@infradead.org, diogo.ivo@siemens.com, jan.kiszka@siemens.com,
 john.fastabend@gmail.com, hawk@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, srk@ti.com, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250210103352.541052-1-m-malladi@ti.com>
 <20250210103352.541052-4-m-malladi@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250210103352.541052-4-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/02/2025 12:33, Meghana Malladi wrote:
> From: Roger Quadros <rogerq@kernel.org>
> 
> Add native XDP support. We do not support zero copy yet.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> v1: https://lore.kernel.org/all/20250122124951.3072410-1-m-malladi@ti.com/
> 
> Changes since v1 (v2-v1):
> - Fix XDP typo in the commit message
> - Add XDP feature flags using xdp_set_features_flag()
> - Use xdp_build_skb_from_buff() when XDP ran
> 
> All the above changes have been suggested by Ido Schimmel <idosch@idosch.org>
> 
>  drivers/net/ethernet/ti/icssg/icssg_common.c | 226 +++++++++++++++++--
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c | 123 +++++++++-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h |  18 ++
>  3 files changed, 353 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index a124c5773551..b01750a2d57e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -98,11 +98,19 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>  {
>  	struct cppi5_host_desc_t *first_desc, *next_desc;
>  	dma_addr_t buf_dma, next_desc_dma;
> +	struct prueth_swdata *swdata;
>  	u32 buf_dma_len;
>  
>  	first_desc = desc;
>  	next_desc = first_desc;
>  
> +	swdata = cppi5_hdesc_get_swdata(desc);
> +	if (swdata->type == PRUETH_SWDATA_PAGE) {
> +		page_pool_recycle_direct(swdata->rx_chn->pg_pool,
> +					 swdata->data.page);

if swdata->data.page.pp already contains the page_pool then you can avoid
passing around rx_chn via swdata altogether.

> +		goto free_desc;
> +	}
> +
>  	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
>  	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
>  
> @@ -126,6 +134,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>  		k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
>  	}
>  
> +free_desc:
>  	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
>  }
>  EXPORT_SYMBOL_GPL(prueth_xmit_free);
> @@ -139,6 +148,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  	struct prueth_swdata *swdata;
>  	struct prueth_tx_chn *tx_chn;
>  	unsigned int total_bytes = 0;
> +	struct xdp_frame *xdpf;
>  	struct sk_buff *skb;
>  	dma_addr_t desc_dma;
>  	int res, num_tx = 0;
> @@ -168,20 +178,29 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  			continue;
>  		}
>  
> -		if (swdata->type != PRUETH_SWDATA_SKB) {
> +		switch (swdata->type) {
> +		case PRUETH_SWDATA_SKB:
> +			skb = swdata->data.skb;
> +			ndev->stats.tx_bytes += skb->len;
> +			ndev->stats.tx_packets++;

dev_sw_netstats_tx_add() instead?

> +			total_bytes += skb->len;
> +			napi_consume_skb(skb, budget);
> +			break;
> +		case PRUETH_SWDATA_XDPF:
> +			xdpf = swdata->data.xdpf;
> +			ndev->stats.tx_bytes += xdpf->len;
> +			ndev->stats.tx_packets++;
here too

> +			total_bytes += xdpf->len;
> +			xdp_return_frame(xdpf);
> +			break;
> +		default:
>  			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);

ndev->stats.tx_dropped++

> +			prueth_xmit_free(tx_chn, desc_tx);
>  			budget++;
>  			continue;
>  		}
>  
> -		skb = swdata->data.skb;
>  		prueth_xmit_free(tx_chn, desc_tx);
> -
> -		ndev = skb->dev;
> -		ndev->stats.tx_packets++;
> -		ndev->stats.tx_bytes += skb->len;
> -		total_bytes += skb->len;
> -		napi_consume_skb(skb, budget);
>  		num_tx++;
>  	}
>  
> @@ -498,6 +517,7 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
>  	swdata->type = PRUETH_SWDATA_PAGE;
>  	swdata->data.page = page;
> +	swdata->rx_chn = rx_chn;
>  
>  	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
>  					desc_rx, desc_dma);
> @@ -540,7 +560,156 @@ void emac_rx_timestamp(struct prueth_emac *emac,
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
> +
> +	if (q_idx >= PRUETH_MAX_TX_QUEUES) {
> +		netdev_err(ndev, "xdp tx: invalid q_id %d\n", q_idx);

ndev->stats.tx_dropped++;

> +		return ICSSG_XDP_CONSUMED;	/* drop */
> +	}
> +
> +	tx_chn = &emac->tx_chns[q_idx];
> +
> +	if (page) { /* already DMA mapped by page_pool */
> +		buf_dma = page_pool_get_dma_addr(page);
> +		buf_dma += xdpf->headroom + sizeof(struct xdp_frame);
> +	} else { /* Map the linear buffer */
> +		buf_dma = dma_map_single(tx_chn->dma_dev, data, pkt_len, DMA_TO_DEVICE);
> +		if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
> +			netdev_err(ndev, "xdp tx: failed to map data buffer\n");

ndev->stats.tx_dropped++;

> +			return ICSSG_XDP_CONSUMED;	/* drop */
> +		}
> +	}
> +
> +	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
> +	if (!first_desc) {
> +		netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
> +		if (!page)
> +			dma_unmap_single(tx_chn->dma_dev, buf_dma, pkt_len, DMA_TO_DEVICE);

Better to do the k3_cppi_desc_pool_alloc() before the DMA mapping
so it is easier to clean up on failure.

> +		goto drop_free_descs;	/* drop */
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
> +		/* we assume page came from RX channel page pool */
> +		swdata->rx_chn = &emac->rx_chns;
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

ndev->stats.tx_dropped++;

> +	prueth_xmit_free(tx_chn, first_desc);

this will also unmap the dma_buffer for all cases. So maybe you need
to add a flag to prueth_xmit_free() to skip unmap for certain cases.

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
> +	int err, result = ICSSG_XDP_PASS;
> +	struct bpf_prog *xdp_prog;
> +	struct xdp_frame *xdpf;
> +	int q_idx;
> +	u32 act;
> +
> +	xdp_prog = READ_ONCE(emac->xdp_prog);
> +
unnecessary new line.

> +	act = bpf_prog_run_xdp(xdp_prog, xdp);
> +	switch (act) {
> +	case XDP_PASS:

return ICSSG_XDP_PASS;

> +		break;
> +	case XDP_TX:
> +		/* Send packet to TX ring for immediate transmission */
> +		xdpf = xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf))
ndev->stats.tx_dropped++;

> +			goto drop;
> +
> +		q_idx = smp_processor_id() % emac->tx_ch_num;
> +		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
> +		if (result == ICSSG_XDP_CONSUMED)
> +			goto drop;

increment tx stats?

return ICSSG_XDP_TX;

> +		break;
> +	case XDP_REDIRECT:
> +		err = xdp_do_redirect(emac->ndev, xdp, xdp_prog);
> +		if (err)
> +			goto drop;
> +		result = ICSSG_XDP_REDIR;

return ICSSG_XDP_REDIR
> +		break;
> +	default:
> +		bpf_warn_invalid_xdp_action(emac->ndev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +drop:
> +		trace_xdp_exception(emac->ndev, xdp_prog, act);
> +		fallthrough; /* handle aborts by dropping packet */
> +	case XDP_DROP:

ndev->stats.rx_dropped++;

> +		result = ICSSG_XDP_CONSUMED;
> +		page_pool_recycle_direct(emac->rx_chns.pg_pool, page);
> +		break;
> +	}
> +
> +	return result;
> +}
> +
> +static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, int *xdp_state)
>  {
>  	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
>  	u32 buf_dma_len, pkt_len, port_id = 0;
> @@ -551,10 +720,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
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
> @@ -594,9 +765,21 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
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
> @@ -859,14 +1042,25 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
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

what about PRUETH_SWDATA_PAGE?

> +	default:
> +		break;
>  	}
> +
>  	prueth_xmit_free(tx_chn, desc_tx);
>  }
>  
> @@ -901,15 +1095,18 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>  		PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
>  	int flow = emac->is_sr1 ?
>  		PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
> +	int xdp_state_or = 0;
>  	int num_rx = 0;
>  	int cur_budget;
> +	int xdp_state;
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
> @@ -919,6 +1116,9 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>  			break;
>  	}
>  
> +	if (xdp_state_or & ICSSG_XDP_REDIR)
> +		xdp_do_flush();
> +
>  	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
>  		if (unlikely(emac->rx_pace_timeout_ns)) {
>  			hrtimer_start(&emac->rx_hrtimer,
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index e5e4efe485f6..a360a1d6f8d7 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -559,6 +559,33 @@ const struct icss_iep_clockops prueth_iep_clockops = {
>  	.perout_enable = prueth_perout_enable,
>  };
>  
> +static int prueth_create_xdp_rxqs(struct prueth_emac *emac)
> +{
> +	struct xdp_rxq_info *rxq = &emac->rx_chns.xdp_rxq;
> +	struct page_pool *pool = emac->rx_chns.pg_pool;
> +	int ret;
> +
> +	ret = xdp_rxq_info_reg(rxq, emac->ndev, 0, rxq->napi_id);

but who sets rxq->napi_id?

I think you need to use emac->napi_rx.napi_id

> +	if (ret)
> +		return ret;
> +
> +	ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_PAGE_POOL, pool);
> +	if (ret)
> +		xdp_rxq_info_unreg(rxq);
> +
> +	return ret;
> +}
> +
> +static void prueth_destroy_xdp_rxqs(struct prueth_emac *emac)
> +{
> +	struct xdp_rxq_info *rxq = &emac->rx_chns.xdp_rxq;
> +
> +	if (!xdp_rxq_info_is_reg(rxq))
> +		return;
> +
> +	xdp_rxq_info_unreg(rxq);
> +}
> +
>  static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
>  {
>  	struct net_device *real_dev;
> @@ -780,10 +807,14 @@ static int emac_ndo_open(struct net_device *ndev)
>  	if (ret)
>  		goto free_tx_ts_irq;
>  
> -	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
> +	ret = prueth_create_xdp_rxqs(emac);
>  	if (ret)
>  		goto reset_rx_chn;
>  
> +	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
> +	if (ret)
> +		goto destroy_xdp_rxqs;
> +
>  	for (i = 0; i < emac->tx_ch_num; i++) {
>  		ret = k3_udma_glue_enable_tx_chn(emac->tx_chns[i].tx_chn);
>  		if (ret)
> @@ -809,6 +840,8 @@ static int emac_ndo_open(struct net_device *ndev)
>  	 * any SKB for completion. So set false to free_skb
>  	 */
>  	prueth_reset_tx_chan(emac, i, false);
> +destroy_xdp_rxqs:
> +	prueth_destroy_xdp_rxqs(emac);
>  reset_rx_chn:
>  	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, false);
>  free_tx_ts_irq:
> @@ -880,6 +913,8 @@ static int emac_ndo_stop(struct net_device *ndev)
>  
>  	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, true);
>  
Please drop new line.

> +	prueth_destroy_xdp_rxqs(emac);
> +
here too.

>  	napi_disable(&emac->napi_rx);
>  	hrtimer_cancel(&emac->rx_hrtimer);
>  
> @@ -1024,6 +1059,90 @@ static int emac_ndo_vlan_rx_del_vid(struct net_device *ndev,
>  	return 0;
>  }
>  
> +/**
> + * emac_xdp_xmit - Implements ndo_xdp_xmit
> + * @dev: netdev
> + * @n: number of frames
> + * @frames: array of XDP buffer pointers
> + * @flags: XDP extra info
> + *
> + * Return: number of frames successfully sent. Failed frames
> + * will be free'ed by XDP core.
> + *
> + * For error cases, a negative errno code is returned and no-frames
> + * are transmitted (caller must handle freeing frames).
> + **/
> +static int emac_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
> +			 u32 flags)
> +{
> +	struct prueth_emac *emac = netdev_priv(dev);
> +	unsigned int q_idx;
> +	int nxmit = 0;
> +	int i;
> +
> +	q_idx = smp_processor_id() % emac->tx_ch_num;
> +
> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
> +		return -EINVAL;
> +
> +	for (i = 0; i < n; i++) {
> +		struct xdp_frame *xdpf = frames[i];
> +		int err;
> +
> +		err = emac_xmit_xdp_frame(emac, xdpf, NULL, q_idx);
> +		if (err != ICSSG_XDP_TX)
> +			break;
> +		nxmit++;
> +	}
> +
> +	return nxmit;
> +}
> +
> +/**
> + * emac_xdp_setup - add/remove an XDP program
> + * @emac: emac device
> + * @bpf: XDP program
> + *
> + * Return: Always 0 (Success)
> + **/
> +static int emac_xdp_setup(struct prueth_emac *emac, struct netdev_bpf *bpf)
> +{
> +	struct bpf_prog *prog = bpf->prog;
> +	xdp_features_t val;
> +
> +	val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +	      NETDEV_XDP_ACT_NDO_XMIT;
> +	xdp_set_features_flag(emac->ndev, val);
> +
> +	if (!emac->xdpi.prog && !prog)
> +		return 0;
> +
> +	WRITE_ONCE(emac->xdp_prog, prog);
> +
> +	xdp_attachment_setup(&emac->xdpi, bpf);
> +
> +	return 0;
> +}
> +
> +/**
> + * emac_ndo_bpf - implements ndo_bpf for icssg_prueth
> + * @ndev: network adapter device
> + * @bpf: XDP program
> + *
> + * Return: 0 on success, error code on failure.
> + **/
> +static int emac_ndo_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
> +{
> +	struct prueth_emac *emac = netdev_priv(ndev);
> +
> +	switch (bpf->command) {
> +	case XDP_SETUP_PROG:
> +		return emac_xdp_setup(emac, bpf);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_open = emac_ndo_open,
>  	.ndo_stop = emac_ndo_stop,
> @@ -1038,6 +1157,8 @@ static const struct net_device_ops emac_netdev_ops = {
>  	.ndo_fix_features = emac_ndo_fix_features,
>  	.ndo_vlan_rx_add_vid = emac_ndo_vlan_rx_add_vid,
>  	.ndo_vlan_rx_kill_vid = emac_ndo_vlan_rx_del_vid,
> +	.ndo_bpf = emac_ndo_bpf,
> +	.ndo_xdp_xmit = emac_xdp_xmit,
>  };
>  
>  static int prueth_netdev_init(struct prueth *prueth,
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index 2c8585255b7c..fb8dc8e12c19 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -8,6 +8,8 @@
>  #ifndef __NET_TI_ICSSG_PRUETH_H
>  #define __NET_TI_ICSSG_PRUETH_H
>  
> +#include <linux/bpf.h>
> +#include <linux/bpf_trace.h>
>  #include <linux/etherdevice.h>
>  #include <linux/genalloc.h>
>  #include <linux/if_vlan.h>
> @@ -134,6 +136,7 @@ struct prueth_rx_chn {
>  	unsigned int irq[ICSSG_MAX_RFLOWS];	/* separate irq per flow */
>  	char name[32];
>  	struct page_pool *pg_pool;
> +	struct xdp_rxq_info xdp_rxq;
>  };
>  
>  enum prueth_swdata_type {
> @@ -141,16 +144,19 @@ enum prueth_swdata_type {
>  	PRUETH_SWDATA_SKB,
>  	PRUETH_SWDATA_PAGE,
>  	PRUETH_SWDATA_CMD,
> +	PRUETH_SWDATA_XDPF,
>  };
>  
>  union prueth_data {
>  	struct sk_buff *skb;
>  	struct page *page;
>  	u32 cmd;
> +	struct xdp_frame *xdpf;
>  };
>  
>  struct prueth_swdata {
>  	union prueth_data data;
> +	struct prueth_rx_chn *rx_chn;
>  	enum prueth_swdata_type type;
>  };
>  
> @@ -161,6 +167,12 @@ struct prueth_swdata {
>  
>  #define PRUETH_MAX_TX_TS_REQUESTS	50 /* Max simultaneous TX_TS requests */
>  
> +/* XDP BPF state */
> +#define ICSSG_XDP_PASS           0
> +#define ICSSG_XDP_CONSUMED       BIT(0)
> +#define ICSSG_XDP_TX             BIT(1)
> +#define ICSSG_XDP_REDIR          BIT(2)
> +
>  /* Minimum coalesce time in usecs for both Tx and Rx */
>  #define ICSSG_MIN_COALESCE_USECS 20
>  
> @@ -229,6 +241,8 @@ struct prueth_emac {
>  	unsigned long rx_pace_timeout_ns;
>  
>  	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
> +	struct bpf_prog *xdp_prog;
> +	struct xdp_attachment_info xdpi;
>  };
>  
>  /* The buf includes headroom compatible with both skb and xdpf */
> @@ -467,5 +481,9 @@ void prueth_put_cores(struct prueth *prueth, int slice);
>  
>  /* Revision specific helper */
>  u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns);
> +int emac_xmit_xdp_frame(struct prueth_emac *emac,
> +			struct xdp_frame *xdpf,
> +			struct page *page,
> +			unsigned int q_idx);
>  
>  #endif /* __NET_TI_ICSSG_PRUETH_H */

-- 
cheers,
-roger


