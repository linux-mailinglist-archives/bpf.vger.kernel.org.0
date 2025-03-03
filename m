Return-Path: <bpf+bounces-53050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2B2A4BEE4
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 12:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1591188226B
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 11:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A4E1FF7A0;
	Mon,  3 Mar 2025 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v7/e5EMC"
X-Original-To: bpf@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533D1FF5FE;
	Mon,  3 Mar 2025 11:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001858; cv=none; b=VoGrom0LhmgnEu+/NMvfp7emRa+qt/b1ThBjP4VtiYxR9nbbW22yYMZK8eCIz41acZwGW+CNLm4oV6O40mJGZO3n2oVtHmxTJXP89BBs1Y4m43uvZTmJ7uP8GckK68N6aOtXLlVNkVWQVmhBNThi3YqEgp169mG31m/up/JjXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001858; c=relaxed/simple;
	bh=Q5BdiIVI2W83Mnf4pwETQwnHYIpchq9U/ZtwBJ63jaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jQD+eklAUrgPMTiYi89NjaKxM2xbSxXTFgtz168llZ8NoA+JJtf0sbuulgKGAHEGRp16PECRuCjMhAMgXbMxWzFoK70Jp60mU2rDhLAgGfikUvr0Why8vQCVvy90Vy3z4ZPEoo76egqSbhyexYs9NaeFl4rcF/FTphioVnccHvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=v7/e5EMC; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 523BatwM2747332
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 05:36:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741001815;
	bh=89N1ZJohVbwL5OkHHW7QzL8dMgKQ/ETvbhKKBN0tPdE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=v7/e5EMCxQl1G1mS40j7XRn+xy7BuEgQNABo1ymtD9G0obUcVAEkfKb8/mLB6uvPH
	 wvpj4PdvTVPXd1e2nGD9aeub7Yzvr1WZbgzjAVL02iRP/9KeKOQ9TOAD0lwUBd8p7m
	 IBZK5MEHU2s2HJaPjgHgDqDjv722SgnOal+QZpc4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 523BatOO031919
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 05:36:55 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 05:36:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 05:36:55 -0600
Received: from [172.24.21.156] (lt9560gk3.dhcp.ti.com [172.24.21.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523BamMS017833;
	Mon, 3 Mar 2025 05:36:49 -0600
Message-ID: <12576ce1-9db0-4136-9f84-3c6a72a07127@ti.com>
Date: Mon, 3 Mar 2025 17:06:48 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] net: ti: icssg-prueth: Add XDP support
To: Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <u.kleine-koenig@baylibre.com>, <matthias.schiffer@ew.tq-group.com>,
        <dan.carpenter@linaro.org>, <schnelle@linux.ibm.com>,
        <diogo.ivo@siemens.com>, <glaroque@baylibre.com>, <macro@orcam.me.uk>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-4-m-malladi@ti.com>
 <8f93a9a0-5d0c-47d6-9db6-af93acebf008@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <8f93a9a0-5d0c-47d6-9db6-af93acebf008@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/27/2025 9:07 PM, Roger Quadros wrote:
> 
> 
> On 24/02/2025 13:01, Meghana Malladi wrote:
>> From: Roger Quadros <rogerq@kernel.org>
>>
>> Add native XDP support. We do not support zero copy yet.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>> Changes since v2 (v3-v2):
>> - Use page_pool contained in the page instead of using passing page_pool
>> (rx_chn) as part of swdata
>> - dev_sw_netstats_tx_add() instead of incrementing the stats directly
>> - Add missing ndev->stats.tx_dropped++ wherever applicable
>> - Move k3_cppi_desc_pool_alloc() before the DMA mapping for easier cleanup
>> on failure
>> - Replace rxp->napi_id with emac->napi_rx.napi_id in prueth_create_xdp_rxqs()
>>
>> All the above changes have been suggested by Roger Quadros <rogerq@kernel.org>
>>
>>   drivers/net/ethernet/ti/icssg/icssg_common.c | 219 +++++++++++++++++--
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.c | 125 ++++++++++-
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h |  17 ++
>>   3 files changed, 346 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> index 01eeabe83eff..4716e24ea05d 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> @@ -98,11 +98,19 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>>   {
>>   	struct cppi5_host_desc_t *first_desc, *next_desc;
>>   	dma_addr_t buf_dma, next_desc_dma;
>> +	struct prueth_swdata *swdata;
>>   	u32 buf_dma_len;
>>   
>>   	first_desc = desc;
>>   	next_desc = first_desc;
>>   
>> +	swdata = cppi5_hdesc_get_swdata(desc);
>> +	if (swdata->type == PRUETH_SWDATA_PAGE) {
>> +		page_pool_recycle_direct(swdata->data.page->pp,
>> +					 swdata->data.page);
>> +		goto free_desc;
>> +	}
>> +
>>   	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
>>   	k3_udma_glue_tx_cppi5_to_dma_addr(tx_chn->tx_chn, &buf_dma);
>>   
>> @@ -126,6 +134,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>>   		k3_cppi_desc_pool_free(tx_chn->desc_pool, next_desc);
>>   	}
>>   
>> +free_desc:
>>   	k3_cppi_desc_pool_free(tx_chn->desc_pool, first_desc);
>>   }
>>   EXPORT_SYMBOL_GPL(prueth_xmit_free);
>> @@ -139,6 +148,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>   	struct prueth_swdata *swdata;
>>   	struct prueth_tx_chn *tx_chn;
>>   	unsigned int total_bytes = 0;
>> +	struct xdp_frame *xdpf;
>>   	struct sk_buff *skb;
>>   	dma_addr_t desc_dma;
>>   	int res, num_tx = 0;
>> @@ -168,21 +178,28 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>   			continue;
>>   		}
>>   
>> -		if (swdata->type != PRUETH_SWDATA_SKB) {
>> +		switch (swdata->type) {
>> +		case PRUETH_SWDATA_SKB:
>> +			skb = swdata->data.skb;
>> +			dev_sw_netstats_tx_add(skb->dev, 1, skb->len);
>> +			total_bytes += skb->len;
>> +			napi_consume_skb(skb, budget);
>> +			break;
>> +		case PRUETH_SWDATA_XDPF:
>> +			xdpf = swdata->data.xdpf;
>> +			dev_sw_netstats_tx_add(ndev, 1, xdpf->len);
>> +			total_bytes += xdpf->len;
>> +			xdp_return_frame(xdpf);
>> +			break;
>> +		default:
>>   			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
>>   			prueth_xmit_free(tx_chn, desc_tx);
>> +			ndev->stats.tx_dropped++;
>>   			budget++;
>>   			continue;
>>   		}
>>   
>> -		skb = swdata->data.skb;
>>   		prueth_xmit_free(tx_chn, desc_tx);
>> -
>> -		ndev = skb->dev;
>> -		ndev->stats.tx_packets++;
>> -		ndev->stats.tx_bytes += skb->len;
>> -		total_bytes += skb->len;
>> -		napi_consume_skb(skb, budget);
>>   		num_tx++;
>>   	}
>>   
>> @@ -541,7 +558,153 @@ void emac_rx_timestamp(struct prueth_emac *emac,
>>   	ssh->hwtstamp = ns_to_ktime(ns);
>>   }
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
> drop new line and arrange below declarations in reverse xmas tree order.
> 

As suggested by Dan, will drop these variabled and directly use them.

>> +	void *data = xdpf->data;
>> +	u32 pkt_len = xdpf->len;
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
> 
> you could avoid initialization of result. see below.
> 
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
> instead of break how about?
> 		return ICSSG_XDP_PASS;
> 

I looked into CPSW XDP implementation and its same as what you suggested 
here. Will update this functon with your suggestions.

>> +	case XDP_TX:
>> +		/* Send packet to TX ring for immediate transmission */
>> +		xdpf = xdp_convert_buff_to_frame(xdp);
>> +		if (unlikely(!xdpf))
> 
> TX is dropped so here you need to
> 			ndev->stats.tx_dropped++;

Yes added it.

>> +			goto drop;
>> +
>> +		q_idx = smp_processor_id() % emac->tx_ch_num;
>> +		result = emac_xmit_xdp_frame(emac, xdpf, page, q_idx);
>> +		if (result == ICSSG_XDP_CONSUMED)
>> +			goto drop;
> 
> need to increment rx stats as we received the packet successfully?
> 

Yes I will do that.

>> +		break;
> instead,
> 		return ICSSG_XDP_TX;
> 

returning result here as it depends on what emac_xmit_xdp_frame() returns

>> +	case XDP_REDIRECT:
>> +		err = xdp_do_redirect(emac->ndev, xdp, xdp_prog);
>> +		if (err)
>> +			goto drop;
>> +		result = ICSSG_XDP_REDIR;
>> +		break;
> 
> replace above 2 by
> 		return ICSSG_XDP_REDIR;

I suppose you meant "replace above to by?" I have updated it.

>> +	default:
>> +		bpf_warn_invalid_xdp_action(emac->ndev, xdp_prog, act);
>> +		fallthrough;
>> +	case XDP_ABORTED:
>> +drop:
>> +		trace_xdp_exception(emac->ndev, xdp_prog, act);
>> +		fallthrough; /* handle aborts by dropping packet */
>> +	case XDP_DROP:
>> +		ndev->stats.tx_dropped++;
> 
> shouldn't this be
> 		ndev->stats.rx_dropped++;
> 

Yes correct. Thanks for finding this. Fixed it.

>> +		result = ICSSG_XDP_CONSUMED;
> 
> not required if we directly return this value below.
> 
>> +		page_pool_recycle_direct(emac->rx_chns.pg_pool, page);
>> +		break;
> 		return ICSSG_XDP_CONSUMED;
>> +	}
>> +
>> +	return result;
> 
> drop this

Done.
> 
>> +}
>> +
>> +static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id, int *xdp_state)
>>   {
>>   	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
>>   	u32 buf_dma_len, pkt_len, port_id = 0;
>> @@ -552,10 +715,12 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>   	struct page *page, *new_page;
>>   	struct page_pool *pool;
>>   	struct sk_buff *skb;
>> +	struct xdp_buff xdp;
>>   	u32 *psdata;
>>   	void *pa;
>>   	int ret;
>>   
>> +	*xdp_state = 0;
>>   	pool = rx_chn->pg_pool;
>>   	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
>>   	if (ret) {
>> @@ -596,9 +761,21 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>   		goto requeue;
>>   	}
>>   
>> -	/* prepare skb and send to n/w stack */
>>   	pa = page_address(page);
>> -	skb = napi_build_skb(pa, PAGE_SIZE);
> 
> We are running the xdp program after allocating the new page.
> How about running the xdp program first? if the packet has to be dropped
> then it is pointless to allocate a new page. We could just reuse the old page
> and save CPU cycles.
> 

What if the packet need not be dropped (it has been processed by XDP) 
Then we go to requeue, where new page is needed to map it to the next 
upcoming packet descriptor. Hence running XDP needs new_page.

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
>>   	if (!skb) {
>>   		ndev->stats.rx_dropped++;
>>   		page_pool_recycle_direct(pool, page);
> 
> instead of recycling the old page just reuse it
> 		new_page = page;
> 

With the above explanation I think allocating new_page is inevitable.

>> 		goto requeue;
>> 	}
> 
> here you can allocate the new page cause now we're sure old page
> has to be sent to user space.
> 

likewise to the above comment.

>> @@ -861,13 +1038,23 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
>>   	struct prueth_tx_chn *tx_chn = data;
>>   	struct cppi5_host_desc_t *desc_tx;
>>   	struct prueth_swdata *swdata;
>> +	struct xdp_frame *xdpf;
>>   	struct sk_buff *skb;
>>   
>>   	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
>>   	swdata = cppi5_hdesc_get_swdata(desc_tx);
>> -	if (swdata->type == PRUETH_SWDATA_SKB) {
>> +
>> +	switch (swdata->type) {
>> +	case PRUETH_SWDATA_SKB:
>>   		skb = swdata->data.skb;
>>   		dev_kfree_skb_any(skb);
>> +		break;
>> +	case PRUETH_SWDATA_XDPF:
>> +		xdpf = swdata->data.xdpf;
>> +		xdp_return_frame(xdpf);
>> +		break;
>> +	default:
>> +		break;
>>   	}
>>   
>>   	prueth_xmit_free(tx_chn, desc_tx);
>> @@ -904,15 +1091,18 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>>   		PRUETH_RX_FLOW_DATA_SR1 : PRUETH_RX_FLOW_DATA;
>>   	int flow = emac->is_sr1 ?
>>   		PRUETH_MAX_RX_FLOWS_SR1 : PRUETH_MAX_RX_FLOWS;
>> +	int xdp_state_or = 0;
>>   	int num_rx = 0;
>>   	int cur_budget;
>> +	int xdp_state;
>>   	int ret;
>>   
>>   	while (flow--) {
>>   		cur_budget = budget - num_rx;
>>   
>>   		while (cur_budget--) {
>> -			ret = emac_rx_packet(emac, flow);
>> +			ret = emac_rx_packet(emac, flow, &xdp_state);
>> +			xdp_state_or |= xdp_state;
>>   			if (ret)
>>   				break;
>>   			num_rx++;
>> @@ -922,6 +1112,9 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>>   			break;
>>   	}
>>   
>> +	if (xdp_state_or & ICSSG_XDP_REDIR)
>> +		xdp_do_flush();
>> +
>>   	if (num_rx < budget && napi_complete_done(napi_rx, num_rx)) {
>>   		if (unlikely(emac->rx_pace_timeout_ns)) {
>>   			hrtimer_start(&emac->rx_hrtimer,
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 3ff8c322f9d9..1acbf9e1bade 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -559,6 +559,33 @@ const struct icss_iep_clockops prueth_iep_clockops = {
>>   	.perout_enable = prueth_perout_enable,
>>   };
>>   
>> +static int prueth_create_xdp_rxqs(struct prueth_emac *emac)
>> +{
>> +	struct xdp_rxq_info *rxq = &emac->rx_chns.xdp_rxq;
>> +	struct page_pool *pool = emac->rx_chns.pg_pool;
>> +	int ret;
>> +
>> +	ret = xdp_rxq_info_reg(rxq, emac->ndev, 0, emac->napi_rx.napi_id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = xdp_rxq_info_reg_mem_model(rxq, MEM_TYPE_PAGE_POOL, pool);
>> +	if (ret)
>> +		xdp_rxq_info_unreg(rxq);
>> +
>> +	return ret;
>> +}
>> +
>> +static void prueth_destroy_xdp_rxqs(struct prueth_emac *emac)
>> +{
>> +	struct xdp_rxq_info *rxq = &emac->rx_chns.xdp_rxq;
>> +
>> +	if (!xdp_rxq_info_is_reg(rxq))
>> +		return;
>> +
>> +	xdp_rxq_info_unreg(rxq);
>> +}
>> +
>>   static int icssg_prueth_add_mcast(struct net_device *ndev, const u8 *addr)
>>   {
>>   	struct net_device *real_dev;
>> @@ -780,10 +807,14 @@ static int emac_ndo_open(struct net_device *ndev)
>>   	if (ret)
>>   		goto free_tx_ts_irq;
>>   
>> -	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
>> +	ret = prueth_create_xdp_rxqs(emac);
>>   	if (ret)
>>   		goto reset_rx_chn;
>>   
>> +	ret = k3_udma_glue_enable_rx_chn(emac->rx_chns.rx_chn);
>> +	if (ret)
>> +		goto destroy_xdp_rxqs;
>> +
>>   	for (i = 0; i < emac->tx_ch_num; i++) {
>>   		ret = k3_udma_glue_enable_tx_chn(emac->tx_chns[i].tx_chn);
>>   		if (ret)
>> @@ -809,6 +840,8 @@ static int emac_ndo_open(struct net_device *ndev)
>>   	 * any SKB for completion. So set false to free_skb
>>   	 */
>>   	prueth_reset_tx_chan(emac, i, false);
>> +destroy_xdp_rxqs:
>> +	prueth_destroy_xdp_rxqs(emac);
>>   reset_rx_chn:
>>   	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, false);
>>   free_tx_ts_irq:
>> @@ -879,7 +912,7 @@ static int emac_ndo_stop(struct net_device *ndev)
>>   	k3_udma_glue_tdown_rx_chn(emac->rx_chns.rx_chn, true);
>>   
>>   	prueth_reset_rx_chan(&emac->rx_chns, max_rx_flows, true);
>> -
>> +	prueth_destroy_xdp_rxqs(emac);
>>   	napi_disable(&emac->napi_rx);
>>   	hrtimer_cancel(&emac->rx_hrtimer);
>>   
>> @@ -1024,6 +1057,90 @@ static int emac_ndo_vlan_rx_del_vid(struct net_device *ndev,
>>   	return 0;
>>   }
>>   
>> +/**
>> + * emac_xdp_xmit - Implements ndo_xdp_xmit
>> + * @dev: netdev
>> + * @n: number of frames
>> + * @frames: array of XDP buffer pointers
>> + * @flags: XDP extra info
>> + *
>> + * Return: number of frames successfully sent. Failed frames
>> + * will be free'ed by XDP core.
>> + *
>> + * For error cases, a negative errno code is returned and no-frames
>> + * are transmitted (caller must handle freeing frames).
>> + **/
>> +static int emac_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
>> +			 u32 flags)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(dev);
>> +	unsigned int q_idx;
>> +	int nxmit = 0;
>> +	int i;
>> +
>> +	q_idx = smp_processor_id() % emac->tx_ch_num;
>> +
>> +	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < n; i++) {
>> +		struct xdp_frame *xdpf = frames[i];
>> +		int err;
>> +
>> +		err = emac_xmit_xdp_frame(emac, xdpf, NULL, q_idx);
>> +		if (err != ICSSG_XDP_TX)
>> +			break;
>> +		nxmit++;
>> +	}
>> +
>> +	return nxmit;
>> +}
>> +
>> +/**
>> + * emac_xdp_setup - add/remove an XDP program
>> + * @emac: emac device
>> + * @bpf: XDP program
>> + *
>> + * Return: Always 0 (Success)
>> + **/
>> +static int emac_xdp_setup(struct prueth_emac *emac, struct netdev_bpf *bpf)
>> +{
>> +	struct bpf_prog *prog = bpf->prog;
>> +	xdp_features_t val;
>> +
>> +	val = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
>> +	      NETDEV_XDP_ACT_NDO_XMIT;
>> +	xdp_set_features_flag(emac->ndev, val);
>> +
>> +	if (!emac->xdpi.prog && !prog)
>> +		return 0;
>> +
>> +	WRITE_ONCE(emac->xdp_prog, prog);
>> +
>> +	xdp_attachment_setup(&emac->xdpi, bpf);
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * emac_ndo_bpf - implements ndo_bpf for icssg_prueth
>> + * @ndev: network adapter device
>> + * @bpf: XDP program
>> + *
>> + * Return: 0 on success, error code on failure.
>> + **/
>> +static int emac_ndo_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
>> +{
>> +	struct prueth_emac *emac = netdev_priv(ndev);
>> +
>> +	switch (bpf->command) {
>> +	case XDP_SETUP_PROG:
>> +		return emac_xdp_setup(emac, bpf);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>>   static const struct net_device_ops emac_netdev_ops = {
>>   	.ndo_open = emac_ndo_open,
>>   	.ndo_stop = emac_ndo_stop,
>> @@ -1038,6 +1155,8 @@ static const struct net_device_ops emac_netdev_ops = {
>>   	.ndo_fix_features = emac_ndo_fix_features,
>>   	.ndo_vlan_rx_add_vid = emac_ndo_vlan_rx_add_vid,
>>   	.ndo_vlan_rx_kill_vid = emac_ndo_vlan_rx_del_vid,
>> +	.ndo_bpf = emac_ndo_bpf,
>> +	.ndo_xdp_xmit = emac_xdp_xmit,
>>   };
>>   
>>   static int prueth_netdev_init(struct prueth *prueth,
>> @@ -1066,6 +1185,8 @@ static int prueth_netdev_init(struct prueth *prueth,
>>   	emac->prueth = prueth;
>>   	emac->ndev = ndev;
>>   	emac->port_id = port;
>> +	emac->xdp_prog = NULL;
>> +	emac->ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
>>   	emac->cmd_wq = create_singlethread_workqueue("icssg_cmd_wq");
>>   	if (!emac->cmd_wq) {
>>   		ret = -ENOMEM;
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index 3bbabd007129..0675919beb94 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -8,6 +8,8 @@
>>   #ifndef __NET_TI_ICSSG_PRUETH_H
>>   #define __NET_TI_ICSSG_PRUETH_H
>>   
>> +#include <linux/bpf.h>
>> +#include <linux/bpf_trace.h>
>>   #include <linux/etherdevice.h>
>>   #include <linux/genalloc.h>
>>   #include <linux/if_vlan.h>
>> @@ -134,6 +136,7 @@ struct prueth_rx_chn {
>>   	unsigned int irq[ICSSG_MAX_RFLOWS];	/* separate irq per flow */
>>   	char name[32];
>>   	struct page_pool *pg_pool;
>> +	struct xdp_rxq_info xdp_rxq;
>>   };
>>   
>>   enum prueth_swdata_type {
>> @@ -141,6 +144,7 @@ enum prueth_swdata_type {
>>   	PRUETH_SWDATA_SKB,
>>   	PRUETH_SWDATA_PAGE,
>>   	PRUETH_SWDATA_CMD,
>> +	PRUETH_SWDATA_XDPF,
>>   };
>>   
>>   struct prueth_swdata {
>> @@ -149,6 +153,7 @@ struct prueth_swdata {
>>   		struct sk_buff *skb;
>>   		struct page *page;
>>   		u32 cmd;
>> +		struct xdp_frame *xdpf;
>>   	} data;
>>   };
>>   
>> @@ -159,6 +164,12 @@ struct prueth_swdata {
>>   
>>   #define PRUETH_MAX_TX_TS_REQUESTS	50 /* Max simultaneous TX_TS requests */
>>   
>> +/* XDP BPF state */
>> +#define ICSSG_XDP_PASS           0
>> +#define ICSSG_XDP_CONSUMED       BIT(0)
>> +#define ICSSG_XDP_TX             BIT(1)
>> +#define ICSSG_XDP_REDIR          BIT(2)
>> +
>>   /* Minimum coalesce time in usecs for both Tx and Rx */
>>   #define ICSSG_MIN_COALESCE_USECS 20
>>   
>> @@ -227,6 +238,8 @@ struct prueth_emac {
>>   	unsigned long rx_pace_timeout_ns;
>>   
>>   	struct netdev_hw_addr_list vlan_mcast_list[MAX_VLAN_ID];
>> +	struct bpf_prog *xdp_prog;
>> +	struct xdp_attachment_info xdpi;
>>   };
>>   
>>   /* The buf includes headroom compatible with both skb and xdpf */
>> @@ -465,5 +478,9 @@ void prueth_put_cores(struct prueth *prueth, int slice);
>>   
>>   /* Revision specific helper */
>>   u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns);
>> +int emac_xmit_xdp_frame(struct prueth_emac *emac,
>> +			struct xdp_frame *xdpf,
>> +			struct page *page,
>> +			unsigned int q_idx);
>>   
>>   #endif /* __NET_TI_ICSSG_PRUETH_H */
> 


