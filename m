Return-Path: <bpf+bounces-51823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26086A399D9
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 12:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB92C188D493
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 11:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A9239594;
	Tue, 18 Feb 2025 11:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lPLC6ZiT"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD446BF;
	Tue, 18 Feb 2025 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739876631; cv=none; b=cQahMOy+9CqMAAU/LPSpY+4xdzZnwK0LRhBvh9flLq4bl/jaaoaTmG/c9qK7PnvAdgOHFio1dbMl0uZWFbXq4luWqW45/1+BA4+p/Q+yF05MCgwkvVFGeWH8jalsyXRhpOTrgUzlEy0DwFb/a8wFPUlLZwZ2jlahC6ozPAgCzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739876631; c=relaxed/simple;
	bh=pwfeX5V0UUPiGS7GGSPvNc0dZBYwJ361CAW+mUWmGq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bEDJ6Fuvly9wwX0wjTHztd3tA+b7K3ANEuoG4nLyllTKHVsRsUvQ2R+MIa+GxkE1wCQHspQ3fAujCg4UbmdZcIKCXvIe6F7tOMf/G2CZQt559/Z09HtBym+TOcomUcVinyD/l632VIK6Vr8gouPKS3JgO8CMytNWP+GMxQQEXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lPLC6ZiT; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51IB31mk1531611
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 05:03:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1739876581;
	bh=qyTcTEUnGKyQngTlUV0MXoDMby/SMbNx+2RpMmu1C/I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=lPLC6ZiTwe+OgnYDES+63neYzF9ysENH3S25p3HuZaZEk2KHeDBeZ+3T3yIiaivLk
	 RSA7wh5a9KkXnAxe5uDsi2+KDdeC5mjhMflRY68yHfvOcYZlTTd6mciUMscRt81PSc
	 X36qjGVZH2y9Uz/m9YhEsDSroHDQE3JUEdDnk1QU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51IB31s9007881
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Feb 2025 05:03:01 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 05:03:00 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 05:03:00 -0600
Received: from [172.24.20.199] (lt9560gk3.dhcp.ti.com [172.24.20.199])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51IB2qkZ015071;
	Tue, 18 Feb 2025 05:02:53 -0600
Message-ID: <17b2b44d-0228-47f9-aef9-d7eccdc5d7e5@ti.com>
Date: Tue, 18 Feb 2025 16:32:51 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: ti: icssg-prueth: introduce and use
 prueth_swdata struct for SWDATA
To: Roger Quadros <rogerq@kernel.org>, <danishanwar@ti.com>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <u.kleine-koenig@baylibre.com>, <krzysztof.kozlowski@linaro.org>,
        <dan.carpenter@linaro.org>, <schnelle@linux.ibm.com>,
        <glaroque@baylibre.com>, <rdunlap@infradead.org>,
        <diogo.ivo@siemens.com>, <jan.kiszka@siemens.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20250210103352.541052-1-m-malladi@ti.com>
 <20250210103352.541052-3-m-malladi@ti.com>
 <b807f2ae-b92b-433f-af4c-f0fd9a83bc1f@kernel.org>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <b807f2ae-b92b-433f-af4c-f0fd9a83bc1f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/12/2025 7:42 PM, Roger Quadros wrote:
> Hi Meghana,
> 
> On 10/02/2025 12:33, Meghana Malladi wrote:
>> From: Roger Quadros <rogerq@kernel.org>
>>
>> We have different cases for SWDATA (skb, page, cmd, etc)
>> so it is better to have a dedicated data structure for that.
>> We can embed the type field inside the struct and use it
>> to interpret the data in completion handlers.
>>
>> Increase SWDATA size to 48 so we have some room to add
>> more data if required.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>> v1: https://lore.kernel.org/all/20250122124951.3072410-1-m-malladi@ti.com/
>>
>> Changes since v1 (v2-v1): None
>>
>>   drivers/net/ethernet/ti/icssg/icssg_common.c  | 47 ++++++++++++-------
>>   drivers/net/ethernet/ti/icssg/icssg_config.h  |  2 +-
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 +++
>>   drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 18 +++++++
>>   .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  4 +-
>>   5 files changed, 58 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> index c3c1e2bf461e..a124c5773551 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> @@ -136,12 +136,12 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>   	struct net_device *ndev = emac->ndev;
>>   	struct cppi5_host_desc_t *desc_tx;
>>   	struct netdev_queue *netif_txq;
>> +	struct prueth_swdata *swdata;
>>   	struct prueth_tx_chn *tx_chn;
>>   	unsigned int total_bytes = 0;
>>   	struct sk_buff *skb;
>>   	dma_addr_t desc_dma;
>>   	int res, num_tx = 0;
>> -	void **swdata;
>>   
>>   	tx_chn = &emac->tx_chns[chn];
>>   
>> @@ -163,12 +163,18 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>   		swdata = cppi5_hdesc_get_swdata(desc_tx);
>>   
>>   		/* was this command's TX complete? */
>> -		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
>> +		if (emac->is_sr1 && (void *)(swdata) == emac->cmd_data) {
>>   			prueth_xmit_free(tx_chn, desc_tx);
>>   			continue;
>>   		}
>>   
>> -		skb = *(swdata);
>> +		if (swdata->type != PRUETH_SWDATA_SKB) {
>> +			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
>> +			budget++;
>> +			continue;
> 
> We are leaking the tx descriptor here. need to call prueth_xmit_free(tx_chn, desc_tx)?
> 

Yes agreed, I will add prueth_xmit_free() here.

>> +		}
>> +
>> +		skb = swdata->data.skb;
>>   		prueth_xmit_free(tx_chn, desc_tx);
>>   
>>   		ndev = skb->dev;
>> @@ -472,9 +478,9 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
>>   {
>>   	struct net_device *ndev = emac->ndev;
>>   	struct cppi5_host_desc_t *desc_rx;
>> +	struct prueth_swdata *swdata;
>>   	dma_addr_t desc_dma;
>>   	dma_addr_t buf_dma;
>> -	void **swdata;
>>   
>>   	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;
>>   	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
>> @@ -490,7 +496,8 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
>>   	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
>>   
>>   	swdata = cppi5_hdesc_get_swdata(desc_rx);
>> -	*swdata = page;
>> +	swdata->type = PRUETH_SWDATA_PAGE;
>> +	swdata->data.page = page;
>>   
>>   	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
>>   					desc_rx, desc_dma);
>> @@ -539,11 +546,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>   	u32 buf_dma_len, pkt_len, port_id = 0;
>>   	struct net_device *ndev = emac->ndev;
>>   	struct cppi5_host_desc_t *desc_rx;
>> +	struct prueth_swdata *swdata;
>>   	dma_addr_t desc_dma, buf_dma;
>>   	struct page *page, *new_page;
>>   	struct page_pool *pool;
>>   	struct sk_buff *skb;
>> -	void **swdata;
>>   	u32 *psdata;
>>   	void *pa;
>>   	int ret;
>> @@ -561,7 +568,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>   
>>   	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
>>   	swdata = cppi5_hdesc_get_swdata(desc_rx);
>> -	page = *swdata;
>> +	if (swdata->type != PRUETH_SWDATA_PAGE) {
>> +		netdev_err(ndev, "rx_pkt: invalid swdata->type %d\n", swdata->type);
> 
> what about freeing the rx descriptor?
> 

Yes, will do that.

>> +		return 0;
>> +	}
> 
> need new line.
> 
>> +	page = swdata->data.page;
>>   
> drop new line.
> 
>>   	page_pool_dma_sync_for_cpu(pool, page, 0, PAGE_SIZE);
>>   	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
>> @@ -627,16 +638,18 @@ static void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
>>   {
>>   	struct prueth_rx_chn *rx_chn = data;
>>   	struct cppi5_host_desc_t *desc_rx;
>> +	struct prueth_swdata *swdata;
>>   	struct page_pool *pool;
>>   	struct page *page;
>> -	void **swdata;
>>   
>>   	pool = rx_chn->pg_pool;
>>   
>>   	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
>>   	swdata = cppi5_hdesc_get_swdata(desc_rx);
>> -	page = *swdata;
>> -	page_pool_recycle_direct(pool, page);
>> +	if (swdata->type == PRUETH_SWDATA_PAGE) {
>> +		page = swdata->data.page;
>> +		page_pool_recycle_direct(pool, page);
>> +	}
> 
> need new line.
> 
>>   	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>>   }
>>   
>> @@ -673,13 +686,13 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>>   	struct prueth_emac *emac = netdev_priv(ndev);
>>   	struct prueth *prueth = emac->prueth;
>>   	struct netdev_queue *netif_txq;
>> +	struct prueth_swdata *swdata;
>>   	struct prueth_tx_chn *tx_chn;
>>   	dma_addr_t desc_dma, buf_dma;
>>   	u32 pkt_len, dst_tag_id;
>>   	int i, ret = 0, q_idx;
>>   	bool in_tx_ts = 0;
>>   	int tx_ts_cookie;
>> -	void **swdata;
>>   	u32 *epib;
>>   
>>   	pkt_len = skb_headlen(skb);
>> @@ -741,7 +754,8 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>>   	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>>   	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
>>   	swdata = cppi5_hdesc_get_swdata(first_desc);
>> -	*swdata = skb;
>> +	swdata->type = PRUETH_SWDATA_SKB;
>> +	swdata->data.skb = skb;
>>   
>>   	/* Handle the case where skb is fragmented in pages */
>>   	cur_desc = first_desc;
>> @@ -844,15 +858,16 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
>>   {
>>   	struct prueth_tx_chn *tx_chn = data;
>>   	struct cppi5_host_desc_t *desc_tx;
>> +	struct prueth_swdata *swdata;
>>   	struct sk_buff *skb;
>> -	void **swdata;
>>   
>>   	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
>>   	swdata = cppi5_hdesc_get_swdata(desc_tx);
>> -	skb = *(swdata);
>> +	if (swdata->type == PRUETH_SWDATA_SKB) {
>> +		skb = swdata->data.skb;
>> +		dev_kfree_skb_any(skb);
>> +	}
> 
> need new line.
> 
>>   	prueth_xmit_free(tx_chn, desc_tx);
>> -
>> -	dev_kfree_skb_any(skb);
>>   }
>>   
>>   irqreturn_t prueth_rx_irq(int irq, void *dev_id)
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
>> index c884e9fa099e..eab84e11d80e 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
>> @@ -20,7 +20,7 @@ struct icssg_flow_cfg {
>>   
>>   #define PRUETH_PKT_TYPE_CMD	0x10
>>   #define PRUETH_NAV_PS_DATA_SIZE	16	/* Protocol specific data size */
>> -#define PRUETH_NAV_SW_DATA_SIZE	16	/* SW related data size */
>> +#define PRUETH_NAV_SW_DATA_SIZE	48	/* SW related data size */
> 
> Why do you need 48? I think it should fit in 16.
> 

Yes, I overlooked the fact that swdata will be a union, will update 
this. But if we are adding rx_chn in prueth_swdata for the next patch, 
we will need to increase this to 24.

>>   #define PRUETH_MAX_TX_DESC	512
>>   #define PRUETH_MAX_RX_DESC	512
>>   #define PRUETH_MAX_RX_FLOWS	1	/* excluding default flow */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> index 00ed97860547..e5e4efe485f6 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
>> @@ -1522,6 +1522,12 @@ static int prueth_probe(struct platform_device *pdev)
>>   
>>   	np = dev->of_node;
>>   
>> +	if (sizeof(struct prueth_swdata) > PRUETH_NAV_SW_DATA_SIZE) {
>> +		dev_err(dev, "insufficient SW_DATA size: %d vs %ld\n",
>> +			PRUETH_NAV_SW_DATA_SIZE, sizeof(struct prueth_swdata));
>> +		return -ENOMEM;
>> +	}
>> +
> 
> Can this be made a build time check instead of runtime?
> 

Sure, I beleive BUILD_BUG_ON_MSG macro can be used as a build time 
check. Will use that.

>>   	prueth = devm_kzalloc(dev, sizeof(*prueth), GFP_KERNEL);
>>   	if (!prueth)
>>   		return -ENOMEM;
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index c7b906de18af..2c8585255b7c 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -136,6 +136,24 @@ struct prueth_rx_chn {
>>   	struct page_pool *pg_pool;
>>   };
>>   
>> +enum prueth_swdata_type {
>> +	PRUETH_SWDATA_INVALID = 0,
>> +	PRUETH_SWDATA_SKB,
>> +	PRUETH_SWDATA_PAGE,
>> +	PRUETH_SWDATA_CMD,
>> +};
>> +
>> +union prueth_data {
>> +	struct sk_buff *skb;
>> +	struct page *page;
>> +	u32 cmd;
>> +};
>> +
>> +struct prueth_swdata {
>> +	union prueth_data data;
>> +	enum prueth_swdata_type type;
>> +};
> 
> Can we re-write this like so with type first and union embedded inside?
> 
> struct prueth_swdata {
> 	enum prueth_swdata_type type;
> 	union prueth_data {
> 		struct sk_buff *skb;
> 		struct page *page;
> 		u32 cmd;
> 	};
> };
> 

Yeah ok, I will make the changes for this.

> 
>> +
>>   /* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
>>    * and lower three are lower priority channels or threads.
>>    */
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
>> index aeeb8a50376b..7bbe0808b3ec 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
>> @@ -275,10 +275,10 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
>>   	struct net_device *ndev = emac->ndev;
>>   	struct cppi5_host_desc_t *desc_rx;
>>   	struct page *page, *new_page;
>> +	struct prueth_swdata *swdata;
>>   	dma_addr_t desc_dma, buf_dma;
>>   	u32 buf_dma_len, pkt_len;
>>   	struct sk_buff *skb;
>> -	void **swdata;
>>   	void *pa;
>>   	int ret;
>>   
>> @@ -301,7 +301,7 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
>>   	}
>>   
>>   	swdata = cppi5_hdesc_get_swdata(desc_rx);
>> -	page = *swdata;
>> +	page = swdata->data.page;
>>   	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
>>   	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
>>   
> 


