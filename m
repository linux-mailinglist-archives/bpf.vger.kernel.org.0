Return-Path: <bpf+bounces-53052-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D54A4BFEC
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325153B0431
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC6820E6E5;
	Mon,  3 Mar 2025 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="w3Xdi3zI"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A3920E313;
	Mon,  3 Mar 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003650; cv=none; b=uK1oQV1tv8UlvNQZiBAtVxrvOsJYB0Qx0AubUHEySQh7MLK/2TmaRAHPvheflwNoPcYKszYGdvZyr8XGfn5NCnfefkEiv/C2DHKHlbNNvNL9rJd1Ijh6XwueKwW0H6j9YXBOmQQBFpAoQOnpmLopSv+EbjB3BGYXXZSv55vJGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003650; c=relaxed/simple;
	bh=UyoKUj+VH4K8nWeOT9n9dJaI3v2+Js4FUWMxJLi8eFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P9/oW1c9qf4+JgEAQqdnR12bt2VHfTOFyyS8G93q/kRCIt1+H1YHxeXoucMQFmCdFslYLSyrxy0nQt9XciFiLCn32D66BYTf+0S01e2vc7iJ26jZD/Xv5lf6wwLC53KDu8kNLM5D2DYZxTpgDdoyE6zfLRm5WD2pZnRPStLTahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=w3Xdi3zI; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 523C6n9E3264168
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 06:06:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741003609;
	bh=s9FBSWCs4WAMxfZdOCBhk74gKexxCHisaEtZE/UwxC4=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=w3Xdi3zIVxMDVUvZ170MGhZYYYyGRLDorNz54ud0aHM5EyNYPiOn7UCyT/53bVY0D
	 Nychc7edaG/8grFz2GVMZmU5wJxD270bvbF4TWKeW7NSI9WGF/l4QfiOUpLtfgcI/a
	 hyD/nqgVbasqHAxo7I6HGMiDycM5UiUriFbNQ7lM=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 523C6ns0074714
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 06:06:49 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 06:06:48 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 06:06:48 -0600
Received: from [172.24.21.156] (lt9560gk3.dhcp.ti.com [172.24.21.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523C6fWD049432;
	Mon, 3 Mar 2025 06:06:42 -0600
Message-ID: <21f21dfb-264b-4e01-9cb3-8d0133b5b31b@ti.com>
Date: Mon, 3 Mar 2025 17:36:41 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add
 XDP support
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <u.kleine-koenig@baylibre.com>,
        <matthias.schiffer@ew.tq-group.com>, <schnelle@linux.ibm.com>,
        <diogo.ivo@siemens.com>, <glaroque@baylibre.com>, <macro@orcam.me.uk>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-4-m-malladi@ti.com>
 <d362a527-88cf-4cd5-a22f-7eeb938d4469@stanley.mountain>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <d362a527-88cf-4cd5-a22f-7eeb938d4469@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/26/2025 4:19 PM, Dan Carpenter wrote:
> On Mon, Feb 24, 2025 at 04: 31: 02PM +0530, Meghana Malladi wrote: > @@ 
> -541,7 +558,153 @@ void emac_rx_timestamp(struct prueth_emac *emac, > 
> ssh->hwtstamp = ns_to_ktime(ns); > } > > -static int 
> emac_rx_packet(struct prueth_emac
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uldgnXdPPE27auXFPdnpH8jx2nnu2fsVXLMVOyEVUH9IX54g6v7RJRENIKzAm7XCuLfioMeFBSH4bAdUdQTaEArV63odoRERqTN_5Pk$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Mon, Feb 24, 2025 at 04:31:02PM +0530, Meghana Malladi wrote:
>> @@ -541,7 +558,153 @@ void emac_rx_timestamp(struct prueth_emac *emac,
>>  	ssh->hwtstamp = ns_to_ktime(ns);
>>  }
>>  
>> -static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>> +/**
>> + * emac_xmit_xdp_frame - transmits an XDP frame
>> + * @emac: emac device
>> + * @xdpf: data to transmit
>> + * @page: page from page pool if already DMA mapped
>> + * @q_idx: queue id
>> + *
>> + * Return: XDP state
>> + */
>> +int emac_xmit_xdp_frame(struct prueth_emac *emac,
>> +			struct xdp_frame *xdpf,
>> +			struct page *page,
>> +			unsigned int q_idx)
>> +{
>> +	struct cppi5_host_desc_t *first_desc;
>> +	struct net_device *ndev = emac->ndev;
>> +	struct prueth_tx_chn *tx_chn;
>> +	dma_addr_t desc_dma, buf_dma;
>> +	struct prueth_swdata *swdata;
>> +	u32 *epib;
>> +	int ret;
>> +
>> +	void *data = xdpf->data;
>> +	u32 pkt_len = xdpf->len;
> 
> Get rid of these variables?
> 

Yeah ok

>> +
>> +	if (q_idx >= PRUETH_MAX_TX_QUEUES) {
>> +		netdev_err(ndev, "xdp tx: invalid q_id %d\n", q_idx);
>> +		return ICSSG_XDP_CONSUMED;	/* drop */
>> +	}
>> +
>> +	tx_chn = &emac->tx_chns[q_idx];
>> +
>> +	first_desc = k3_cppi_desc_pool_alloc(tx_chn->desc_pool);
>> +	if (!first_desc) {
>> +		netdev_dbg(ndev, "xdp tx: failed to allocate descriptor\n");
>> +		goto drop_free_descs;	/* drop */
>> +	}
>> +
>> +	if (page) { /* already DMA mapped by page_pool */
>> +		buf_dma = page_pool_get_dma_addr(page);
>> +		buf_dma += xdpf->headroom + sizeof(struct xdp_frame);
>> +	} else { /* Map the linear buffer */
>> +		buf_dma = dma_map_single(tx_chn->dma_dev, data, pkt_len, DMA_TO_DEVICE);
>> +		if (dma_mapping_error(tx_chn->dma_dev, buf_dma)) {
>> +			netdev_err(ndev, "xdp tx: failed to map data buffer\n");
>> +			goto drop_free_descs;	/* drop */
>> +		}
>> +	}
>> +
>> +	cppi5_hdesc_init(first_desc, CPPI5_INFO0_HDESC_EPIB_PRESENT,
>> +			 PRUETH_NAV_PS_DATA_SIZE);
>> +	cppi5_hdesc_set_pkttype(first_desc, 0);
>> +	epib = first_desc->epib;
>> +	epib[0] = 0;
>> +	epib[1] = 0;
>> +
>> +	/* set dst tag to indicate internal qid at the firmware which is at
>> +	 * bit8..bit15. bit0..bit7 indicates port num for directed
>> +	 * packets in case of switch mode operation
>> +	 */
>> +	cppi5_desc_set_tags_ids(&first_desc->hdr, 0, (emac->port_id | (q_idx << 8)));
>> +	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>> +	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
>> +	swdata = cppi5_hdesc_get_swdata(first_desc);
>> +	if (page) {
>> +		swdata->type = PRUETH_SWDATA_PAGE;
>> +		swdata->data.page = page;
>> +	} else {
>> +		swdata->type = PRUETH_SWDATA_XDPF;
>> +		swdata->data.xdpf = xdpf;
>> +	}
>> +
>> +	cppi5_hdesc_set_pktlen(first_desc, pkt_len);
>> +	desc_dma = k3_cppi_desc_pool_virt2dma(tx_chn->desc_pool, first_desc);
>> +
>> +	ret = k3_udma_glue_push_tx_chn(tx_chn->tx_chn, first_desc, desc_dma);
>> +	if (ret) {
>> +		netdev_err(ndev, "xdp tx: push failed: %d\n", ret);
>> +		goto drop_free_descs;
>> +	}
>> +
>> +	return ICSSG_XDP_TX;
>> +
>> +drop_free_descs:
>> +	prueth_xmit_free(tx_chn, first_desc);
>> +	return ICSSG_XDP_CONSUMED;
>> +}
>> +EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
>> +
>> +/**
>> + * emac_run_xdp - run an XDP program
>> + * @emac: emac device
>> + * @xdp: XDP buffer containing the frame
>> + * @page: page with RX data if already DMA mapped
>> + *
>> + * Return: XDP state
>> + */
>> +static int emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp,
>> +			struct page *page)
>> +{
>> +	struct net_device *ndev = emac->ndev;
>> +	int err, result = ICSSG_XDP_PASS;
>> +	struct bpf_prog *xdp_prog;
>> +	struct xdp_frame *xdpf;
>> +	int q_idx;
>> +	u32 act;
>> +
>> +	xdp_prog = READ_ONCE(emac->xdp_prog);
>> +	act = bpf_prog_run_xdp(xdp_prog, xdp);
>> +	switch (act) {
>> +	case XDP_PASS:
>> +		break;
>> +	case XDP_TX:
>> +		/* Send packet to TX ring for immediate transmission */
>> +		xdpf = xdp_convert_buff_to_frame(xdp);
>> +		if (unlikely(!xdpf))
> 
> This is the second unlikely() macro which is added in this patchset.
> The rule with likely/unlikely() is that it should only be added if it
> likely makes a difference in benchmarking.  Quite often the compiler
> is able to predict that valid pointers are more likely than NULL
> pointers so often these types of annotations don't make any difference
> at all to the compiled code.  But it depends on the compiler and the -O2
> options.
> 

Do correct me if I am wrong, but from my understanding, XDP feature 
depends alot of performance and benchmarking and having unlikely does 
make a difference. Atleast in all the other drivers I see this being 
used for XDP.

>> +			goto drop;
>> +
>> +		q_idx = smp_processor_id() % emac->tx_ch_num;
>> +		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
>> +		if (result == ICSSG_XDP_CONSUMED)
>> +			goto drop;
>> +		break;
>> +	case XDP_REDIRECT:
>> +		err = xdp_do_redirect(emac->ndev, xdp, xdp_prog);
>> +		if (err)
>> +			goto drop;
>> +		result = ICSSG_XDP_REDIR;
>> +		break;
>> +	default:
>> +		bpf_warn_invalid_xdp_action(emac->ndev, xdp_prog, act);
>> +		fallthrough;
>> +	case XDP_ABORTED:
>> +drop:
>> +		trace_xdp_exception(emac->ndev, xdp_prog, act);
>> +		fallthrough; /* handle aborts by dropping packet */
>> +	case XDP_DROP:
>> +		ndev->stats.tx_dropped++;
>> +		result = ICSSG_XDP_CONSUMED;
>> +		page_pool_recycle_direct(emac->rx_chns.pg_pool, page);
>> +		break;
>> +	}
>> +
>> +	return result;
>> +}
>> +
>> +static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, int *xdp_state)
> 
> 
> xdp_state should be a u32 because it's a bitfield.  Bitfields are never
> signed.

Ok I will update it.

> 
>>  {
>>  	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
>>  	u32 buf_dma_len, pkt_len, port_id = 0;
>> @@ -552,10 +715,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>  	struct page *page, *new_page;
>>  	struct page_pool *pool;
>>  	struct sk_buff *skb;
>> +	struct xdp_buff xdp;
>>  	u32 *psdata;
>>  	void *pa;
>>  	int ret;
>>  
>> +	*xdp_state = 0;
>>  	pool = rx_chn->pg_pool;
>>  	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
>>  	if (ret) {
>> @@ -596,9 +761,21 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>  		goto requeue;
>>  	}
>>  
>> -	/* prepare skb and send to n/w stack */
>>  	pa = page_address(page);
>> -	skb = napi_build_skb(pa, PAGE_SIZE);
>> +	if (emac->xdp_prog) {
>> +		xdp_init_buff(&xdp, PAGE_SIZE, &rx_chn->xdp_rxq);
>> +		xdp_prepare_buff(&xdp, pa, PRUETH_HEADROOM, pkt_len, false);
>> +
>> +		*xdp_state = emac_run_xdp(emac, &xdp, page);
>> +		if (*xdp_state == ICSSG_XDP_PASS)
>> +			skb = xdp_build_skb_from_buff(&xdp);
>> +		else
>> +			goto requeue;
>> +	} else {
>> +		/* prepare skb and send to n/w stack */
>> +		skb = napi_build_skb(pa, PAGE_SIZE);
>> +	}
>> +
>>  	if (!skb) {
>>  		ndev->stats.rx_dropped++;
>>  		page_pool_recycle_direct(pool, page);
>> @@ -861,13 +1038,23 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
>>  	struct prueth_tx_chn *tx_chn = data;
>>  	struct cppi5_host_desc_t *desc_tx;
>>  	struct prueth_swdata *swdata;
>> +	struct xdp_frame *xdpf;
>>  	struct sk_buff *skb;
>>  
>>  	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
>>  	swdata = cppi5_hdesc_get_swdata(desc_tx);
>> -	if (swdata->type == PRUETH_SWDATA_SKB) {
>> +
>> +	switch (swdata->type) {
>> +	case PRUETH_SWDATA_SKB:
>>  		skb = swdata->data.skb;
>>  		dev_kfree_skb_any(skb);
>> +		break;
>> +	case PRUETH_SWDATA_XDPF:
>> +		xdpf = swdata->data.xdpf;
>> +		xdp_return_frame(xdpf);
>> +		break;
>> +	default:
>> +		break;
>>  	}
>>  
>>  	prueth_xmit_free(tx_chn, desc_tx);
>> @@ -904,15 +1091,18 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>>  		PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
>>  	int flow = emac->is_sr1 ?
>>  		PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
>> +	int xdp_state_or = 0;
>>  	int num_rx = 0;
>>  	int cur_budget;
>> +	int xdp_state;
> 
> Both xdp_state_or and xdp_state should be u32 because they are bitfields.
> 

Ok I will update it.

> regards,
> dan carpenter
> 
>>  	int ret;
>>  
>>  	while (flow--) {
>>  		cur_budget = budget - num_rx;
>>  
>>  		while (cur_budget--) {
>> -			ret = emac_rx_packet(emac, flow);
>> +			ret = emac_rx_packet(emac, flow, &xdp_state);
>> +			xdp_state_or |= xdp_state;
>>  			if (ret)
>>  				break;
>>  			num_rx++;
> 


