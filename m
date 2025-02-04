Return-Path: <bpf+bounces-50433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F545A2791C
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 18:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6EF165E17
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927C12165F7;
	Tue,  4 Feb 2025 17:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wsvH9an6"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60D9211A20;
	Tue,  4 Feb 2025 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691775; cv=none; b=WN/9D6Ab3Zhj2B/JgU8LRcOGtptpnYy/ej3kpQ+MNRuj4EXWG4fc+0u0zqiV2dqHM6TMMdCV3ZEzUBjGnpuVedejrDgqpbXTII7cekq1NMcbWjlS7mITfiTQOsfheaHCWEczHP9mW/UcGOslo6k4FoxxlGelYn0lHQeSNSnJpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691775; c=relaxed/simple;
	bh=Rg1ZH1DsOa9gZYkjZoChS2QmlV2fnTRhNHsppz41gOo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=FPxURpv4tyIEwSDqy8ekhh76qqJR+TnB7xlTKe6hsjEzCVhTepH2gK/F98oSWV/8vzL9ndh5zjJKfyXJ9Oti7AzIPjIdrqQ4nfeyTUYBtmAKKC9Ai+XQv6+bt9wqVy2v9F0HNnH5rvBh0r3VLH6ESCs2rPM5wvjA4eNJJFV5Zg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wsvH9an6; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 514HtBJO3196570
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 11:55:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738691711;
	bh=FGnxnCCPJCYXpJcYE+0W+BUSr54oKbw5Roi0jlmMGro=;
	h=Date:From:Subject:To:CC:References:In-Reply-To;
	b=wsvH9an6rR4ULHVwevHFV2VH2ymqXqhPq7YgLq3CpugnZZx3VeuhMU1S4L9R7jEDu
	 +mf6Q/xBAbpP91fpUdZBclzqJEVUqEi3erhbRJvNoyZmPbBtuKmjAW4zzGPQMB56Iq
	 kXb1VqCbBqWKtn8DG63EvdyQpG/+JUXVY0TddnNM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 514HtAla091558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 4 Feb 2025 11:55:10 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Feb 2025 11:55:10 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Feb 2025 11:55:10 -0600
Received: from [10.249.140.156] ([10.249.140.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 514Ht2XK062901;
	Tue, 4 Feb 2025 11:55:03 -0600
Message-ID: <9287a623-5663-4705-b61a-3ab5f5cb2424@ti.com>
Date: Tue, 4 Feb 2025 23:25:02 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Malladi, Meghana" <m-malladi@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH net 1/3] net: ti: icssg-prueth: Use
 page_pool API for RX buffer allocation
To: Ido Schimmel <idosch@idosch.org>
CC: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <robh@kernel.org>,
        <matthias.schiffer@ew.tq-group.com>, <dan.carpenter@linaro.org>,
        <rdunlap@infradead.org>, <diogo.ivo@siemens.com>,
        <schnelle@linux.ibm.com>, <glaroque@baylibre.com>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra
	<vigneshr@ti.com>
References: <20250122124951.3072410-1-m-malladi@ti.com>
 <20250122124951.3072410-2-m-malladi@ti.com> <Z5J4jjJ4_arvfF9E@shredder>
Content-Language: en-US
In-Reply-To: <Z5J4jjJ4_arvfF9E@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Thank for reviewing this patch series.

On 1/23/2025 10:42 PM, Ido Schimmel wrote:
> On Wed, Jan 22, 2025 at 06: 19: 49PM +0530, Meghana Malladi wrote: > 
> From: Roger Quadros <rogerq@ kernel. org> > > This is to prepare for 
> native XDP support. > > The page pool API is more faster in allocating 
> pages than >
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> v9dnXbjP_SZUaouOFJtJEp11QLjwx1v0fjJpnJ8CktxnLhoq3emLChPo8_sdyEkE_w$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Wed, Jan 22, 2025 at 06:19:49PM +0530, Meghana Malladi wrote:
>> From: Roger Quadros <rogerq@kernel.org>
>> 
>> This is to prepare for native XDP support.
>> 
>> The page pool API is more faster in allocating pages than
>> __alloc_skb(). Drawback is that it works at PAGE_SIZE granularity
>> so we are not efficient in memory usage.
>> i.e. we are using PAGE_SIZE (4KB) memory for 1.5KB max packet size.
>> 
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> 
> Patch is missing your SoB
> 

Yes I have missed it, will add it for v2.

>> ---
>>  drivers/net/ethernet/ti/Kconfig               |   1 +
>>  drivers/net/ethernet/ti/icssg/icssg_common.c  | 180 ++++++++++++------
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  14 +-
>>  .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  21 +-
>>  4 files changed, 146 insertions(+), 70 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
>> index 0d5a862cd78a..b461281d31b6 100644
>> --- a/drivers/net/ethernet/ti/Kconfig
>> +++ b/drivers/net/ethernet/ti/Kconfig
>> @@ -204,6 +204,7 @@ config TI_ICSSG_PRUETH_SR1
>>  	select PHYLIB
>>  	select TI_ICSS_IEP
>>  	select TI_K3_CPPI_DESC_POOL
>> +	select PAGE_POOL
>>  	depends on PRU_REMOTEPROC
>>  	depends on NET_SWITCHDEV
>>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> index 74f0f200a89d..313667ce24c3 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> @@ -45,6 +45,11 @@ void prueth_cleanup_rx_chns(struct prueth_emac *emac,
>>  			    struct prueth_rx_chn *rx_chn,
>>  			    int max_rflows)
>>  {
>> +	if (rx_chn->pg_pool) {
>> +		page_pool_destroy(rx_chn->pg_pool);
>> +		rx_chn->pg_pool = NULL;
>> +	}
>> +
>>  	if (rx_chn->desc_pool)
>>  		k3_cppi_desc_pool_destroy(rx_chn->desc_pool);
>>  
>> @@ -461,17 +466,17 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>>  }
>>  EXPORT_SYMBOL_GPL(prueth_init_rx_chns);
>>  
>> -int prueth_dma_rx_push(struct prueth_emac *emac,
>> -		       struct sk_buff *skb,
>> -		       struct prueth_rx_chn *rx_chn)
>> +int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
>> +			      struct prueth_rx_chn *rx_chn,
>> +			      struct page *page, u32 buf_len)
>>  {
>>  	struct net_device *ndev = emac->ndev;
>>  	struct cppi5_host_desc_t *desc_rx;
>> -	u32 pkt_len = skb_tailroom(skb);
>>  	dma_addr_t desc_dma;
>>  	dma_addr_t buf_dma;
>>  	void **swdata;
>>  
>> +	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;
>>  	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
>>  	if (!desc_rx) {
>>  		netdev_err(ndev, "rx push: failed to allocate descriptor\n");
>> @@ -479,25 +484,18 @@ int prueth_dma_rx_push(struct prueth_emac *emac,
>>  	}
>>  	desc_dma = k3_cppi_desc_pool_virt2dma(rx_chn->desc_pool, desc_rx);
>>  
>> -	buf_dma = dma_map_single(rx_chn->dma_dev, skb->data, pkt_len, DMA_FROM_DEVICE);
>> -	if (unlikely(dma_mapping_error(rx_chn->dma_dev, buf_dma))) {
>> -		k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>> -		netdev_err(ndev, "rx push: failed to map rx pkt buffer\n");
>> -		return -EINVAL;
>> -	}
>> -
>>  	cppi5_hdesc_init(desc_rx, CPPI5_INFO0_HDESC_EPIB_PRESENT,
>>  			 PRUETH_NAV_PS_DATA_SIZE);
>>  	k3_udma_glue_rx_dma_to_cppi5_addr(rx_chn->rx_chn, &buf_dma);
>> -	cppi5_hdesc_attach_buf(desc_rx, buf_dma, skb_tailroom(skb), buf_dma, skb_tailroom(skb));
>> +	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
>>  
>>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
>> -	*swdata = skb;
>> +	*swdata = page;
>>  
>> -	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, 0,
>> +	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
>>  					desc_rx, desc_dma);
>>  }
>> -EXPORT_SYMBOL_GPL(prueth_dma_rx_push);
>> +EXPORT_SYMBOL_GPL(prueth_dma_rx_push_mapped);
>>  
>>  u64 icssg_ts_to_ns(u32 hi_sw, u32 hi, u32 lo, u32 cycle_time_ns)
>>  {
>> @@ -535,18 +533,31 @@ void emac_rx_timestamp(struct prueth_emac *emac,
>>  	ssh->hwtstamp = ns_to_ktime(ns);
>>  }
>>  
>> +unsigned int prueth_rxbuf_total_len(unsigned int len)
>> +{
>> +	len += PRUETH_HEADROOM;
>> +	len += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> +
>> +	return SKB_DATA_ALIGN(len);
>> +}
>> +EXPORT_SYMBOL_GPL(prueth_rxbuf_total_len);
>> +
>>  static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>  {
>>  	struct prueth_rx_chn *rx_chn = &emac->rx_chns;
>>  	u32 buf_dma_len, pkt_len, port_id = 0;
>>  	struct net_device *ndev = emac->ndev;
>>  	struct cppi5_host_desc_t *desc_rx;
>> -	struct sk_buff *skb, *new_skb;
>>  	dma_addr_t desc_dma, buf_dma;
>> +	struct page *page, *new_page;
>> +	struct page_pool *pool;
>> +	struct sk_buff *skb;
>>  	void **swdata;
>>  	u32 *psdata;
>> +	void *pa;
>>  	int ret;
>>  
>> +	pool = rx_chn->pg_pool;
>>  	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
>>  	if (ret) {
>>  		if (ret != -ENODATA)
>> @@ -558,14 +569,8 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>  		return 0;
>>  
>>  	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
>> -
>>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
>> -	skb = *swdata;
>> -
>> -	psdata = cppi5_hdesc_get_psdata(desc_rx);
>> -	/* RX HW timestamp */
>> -	if (emac->rx_ts_enabled)
>> -		emac_rx_timestamp(emac, skb, psdata);
>> +	page = *swdata;
>>  
>>  	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
>>  	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
>> @@ -574,32 +579,50 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>>  	pkt_len -= 4;
>>  	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
>>  
>> -	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
>>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>>  
>> -	skb->dev = ndev;
>> -	new_skb = netdev_alloc_skb_ip_align(ndev, PRUETH_MAX_PKT_SIZE);
>>  	/* if allocation fails we drop the packet but push the
>> -	 * descriptor back to the ring with old skb to prevent a stall
>> +	 * descriptor back to the ring with old page to prevent a stall
>>  	 */
>> -	if (!new_skb) {
>> +	new_page = page_pool_dev_alloc_pages(pool);
> 
> I don't see where the reference is released via a put call
> 

Seems like none of the pages which have been allocated aren't getting 
recycled in the rx path after being used unless its some error case. 
Will try to fix this.

Also I have noticed, in prueth_prepare_rx_chan() pages are allocated per 
number of descriptors for a channel, but they are not being used when a 
packet is being recieved (in emac_rx_packet()) and rather new page is 
allocated for the next upcoming packet. Is this a valid design, what are 
your thoughts on this ?
)
>> +	if (unlikely(!new_page)) {
>> +		new_page = page;
>>  		ndev->stats.rx_dropped++;
>> -		new_skb = skb;
>> -	} else {
>> -		/* send the filled skb up the n/w stack */
>> -		skb_put(skb, pkt_len);
>> -		if (emac->prueth->is_switch_mode)
>> -			skb->offload_fwd_mark = emac->offload_fwd_mark;
>> -		skb->protocol = eth_type_trans(skb, ndev);
>> -		napi_gro_receive(&emac->napi_rx, skb);
>> -		ndev->stats.rx_bytes += pkt_len;
>> -		ndev->stats.rx_packets++;
>> +		goto requeue;
>>  	}
>>  
>> +	/* prepare skb and send to n/w stack */
>> +	pa = page_address(page);
>> +	skb = build_skb(pa, prueth_rxbuf_total_len(pkt_len));
> 
> napi_build_skb()? See commit 53ee91427177 ("net/mlx5e: Switch to using
> napi_build_skb()")
> 

Ok, I will update it

> Also, I believe the frag size is incorrect. It is used to initialize
> skb->truesize which should signal the size of the buffer that was
> allocated for the packet (PAGE_SIZE in this case).
> 

Yes you are correct, I will replace it with PAGE_SIZE.

>> +	if (!skb) {
>> +		ndev->stats.rx_dropped++;
>> +		page_pool_recycle_direct(pool, page);
>> +		goto requeue;
>> +	}
>> +
>> +	skb_reserve(skb, PRUETH_HEADROOM);
>> +	skb_put(skb, pkt_len);
>> +	skb->dev = ndev;
>> +
>> +	psdata = cppi5_hdesc_get_psdata(desc_rx);
>> +	/* RX HW timestamp */
>> +	if (emac->rx_ts_enabled)
>> +		emac_rx_timestamp(emac, skb, psdata);
>> +
>> +	if (emac->prueth->is_switch_mode)
>> +		skb->offload_fwd_mark = emac->offload_fwd_mark;
>> +	skb->protocol = eth_type_trans(skb, ndev);
> 
> skb_mark_for_recycle() ?
> 
>> +
>> +	netif_receive_skb(skb);
> 
> The code was previously using napi_gro_receive(), why give up on GRO
> support?
> 

will update with napi_gro_receive() and skb_mark_for_recycle() changes 
for v2.

>> +	ndev->stats.rx_bytes += pkt_len;
>> +	ndev->stats.rx_packets++;
>> +
>> +requeue:
>>  	/* queue another RX DMA */
>> -	ret = prueth_dma_rx_push(emac, new_skb, &emac->rx_chns);
>> +	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
>> +					PRUETH_MAX_PKT_SIZE);
>>  	if (WARN_ON(ret < 0)) {
>> -		dev_kfree_skb_any(new_skb);
>> +		page_pool_recycle_direct(pool, new_page);
>>  		ndev->stats.rx_errors++;
>>  		ndev->stats.rx_dropped++;
>>  	}
>> @@ -611,22 +634,17 @@ static void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
>>  {
>>  	struct prueth_rx_chn *rx_chn = data;
>>  	struct cppi5_host_desc_t *desc_rx;
>> -	struct sk_buff *skb;
>> -	dma_addr_t buf_dma;
>> -	u32 buf_dma_len;
>> +	struct page_pool *pool;
>> +	struct page *page;
>>  	void **swdata;
>>  
>> +	pool = rx_chn->pg_pool;
>> +
>>  	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
>>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
>> -	skb = *swdata;
>> -	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
>> -	k3_udma_glue_rx_cppi5_to_dma_addr(rx_chn->rx_chn, &buf_dma);
>> -
>> -	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len,
>> -			 DMA_FROM_DEVICE);
>> +	page = *swdata;
>> +	page_pool_recycle_direct(pool, page);
>>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>> -
>> -	dev_kfree_skb_any(skb);
>>  }
>>  
>>  static int prueth_tx_ts_cookie_get(struct prueth_emac *emac)
>> @@ -907,29 +925,70 @@ int icssg_napi_rx_poll(struct napi_struct *napi_rx, int budget)
>>  }
>>  EXPORT_SYMBOL_GPL(icssg_napi_rx_poll);
>>  
>> +static struct page_pool *prueth_create_page_pool(struct prueth_emac *emac,
>> +						 struct device *dma_dev,
>> +						 int size)
>> +{
>> +	struct page_pool_params pp_params = { 0 };
>> +	struct page_pool *pool;
>> +
>> +	pp_params.order = 0;
>> +	pp_params.flags = PP_FLAG_DMA_MAP;
> 
> What about PP_FLAG_DMA_SYNC_DEV ? I don't see a sync for device call. I
> also don't see a sync for CPU...
> 

Yes I will add PP_FLAG_DMA_SYNC_DEV as well.
I believe page_pool_dma_sync_for_cpu() needs to be called sync Rx page 
for CPU, am I right ? If so can you tell me, in what all cases should I 
call this function.

https://lkml.iu.edu/hypermail/linux/kernel/2312.1/06353.html
In the above link it is quoted - "Note that this version performs DMA 
sync unconditionally, even if the associated PP doesn't perform 
sync-for-device" for the page_pool_dma_sync_for_cpu() function. So does 
that mean if I am using this function I don't need explicily sync for 
device call?

And if thats not the case, can you point me to some reference on how I 
can acheive sync for device.

>> +	pp_params.pool_size = size;
>> +	pp_params.nid = dev_to_node(emac->prueth->dev);
>> +	pp_params.dma_dir = DMA_BIDIRECTIONAL;
>> +	pp_params.dev = dma_dev;
>> +	pp_params.napi = &emac->napi_rx;
>> +
>> +	pool = page_pool_create(&pp_params);
>> +	if (IS_ERR(pool))
>> +		netdev_err(emac->ndev, "cannot create rx page pool\n");
>> +
>> +	return pool;
>> +}
>> +
>>  int prueth_prepare_rx_chan(struct prueth_emac *emac,
>>  			   struct prueth_rx_chn *chn,
>>  			   int buf_size)
>>  {
>> -	struct sk_buff *skb;
>> +	struct page_pool *pool;
>> +	struct page *page;
>>  	int i, ret;
>>  
>> +	pool = prueth_create_page_pool(emac, chn->dma_dev, chn->descs_num);
>> +	if (IS_ERR(pool))
>> +		return PTR_ERR(pool);
>> +
>> +	chn->pg_pool = pool;
>> +
>>  	for (i = 0; i < chn->descs_num; i++) {
>> -		skb = __netdev_alloc_skb_ip_align(NULL, buf_size, GFP_KERNEL);
>> -		if (!skb)
>> -			return -ENOMEM;
>> +		/* NOTE: we're not using memory efficiently here.
>> +		 * 1 full page (4KB?) used here instead of
>> +		 * PRUETH_MAX_PKT_SIZE (~1.5KB?)
>> +		 */
> 
> What about using page_pool_alloc_frag()? Never used it, but the
> documentation says:
> 
> 2. page_pool_alloc_frag(): allocate memory with page splitting when
> driver knows that the memory it need is always smaller than or equal to
> half of the page allocated from page pool. Page splitting enables memory
> saving and thus avoids TLB/cache miss for data access, but there also is
> some cost to implement page splitting, mainly some cache line
> dirtying/bouncing for ‘struct page’ and atomic operation for
> page->pp_ref_count.
> 

I believe the reason for not using it is similar to the explanation in 
the patch here: 
https://lore.kernel.org/all/20240424203559.3420468-4-anthony.l.nguyen@intel.com/
In a nutshell, to keep it simple and compact.

> https://urldefense.com/v3/__https://docs.kernel.org/networking/ 
> page_pool.html__;!!G3vK!WHMkn8KHknjjz91hGnt0Ywf5z4VLXzXTK5Bu2T6CV2n- 
> zHUE1iqgRJsrKQYQwFswRSFrHOYym_qb$ <https://urldefense.com/v3/__https://docs.kernel.org/networking/page_pool.html__;!!G3vK!WHMkn8KHknjjz91hGnt0Ywf5z4VLXzXTK5Bu2T6CV2n-zHUE1iqgRJsrKQYQwFswRSFrHOYym_qb$>
> 
>> +		page = page_pool_dev_alloc_pages(pool);
>> +		if (!page) {
>> +			netdev_err(emac->ndev, "couldn't allocate rx page\n");
>> +			ret = -ENOMEM;
>> +			goto recycle_alloc_pg;
>> +		}
>>  
>> -		ret = prueth_dma_rx_push(emac, skb, chn);
>> +		ret = prueth_dma_rx_push_mapped(emac, chn, page, buf_size);
>>  		if (ret < 0) {
>>  			netdev_err(emac->ndev,
>> -				   "cannot submit skb for rx chan %s ret %d\n",
>> +				   "cannot submit page for rx chan %s ret %d\n",
>>  				   chn->name, ret);
>> -			kfree_skb(skb);
>> -			return ret;
>> +			page_pool_recycle_direct(pool, page);
>> +			goto recycle_alloc_pg;
>>  		}
>>  	}
>>  
>>  	return 0;
>> +
>> +recycle_alloc_pg:
>> +	prueth_reset_rx_chan(&emac->rx_chns, PRUETH_MAX_RX_FLOWS, false);
>> +
>> +	return ret;
>>  }
>>  EXPORT_SYMBOL_GPL(prueth_prepare_rx_chan);
>>  
>> @@ -958,6 +1017,9 @@ void prueth_reset_rx_chan(struct prueth_rx_chn *chn,
>>  					  prueth_rx_cleanup, !!i);
>>  	if (disable)
>>  		k3_udma_glue_disable_rx_chn(chn->rx_chn);
>> +
>> +	page_pool_destroy(chn->pg_pool);
>> +	chn->pg_pool = NULL;
>>  }
>>  EXPORT_SYMBOL_GPL(prueth_reset_rx_chan);
>>  
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> index 5473315ea204..62f3d04af222 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
>> @@ -33,6 +33,8 @@
>>  #include <linux/dma/k3-udma-glue.h>
>>  
>>  #include <net/devlink.h>
>> +#include <net/xdp.h>
>> +#include <net/page_pool/helpers.h>
>>  
>>  #include "icssg_config.h"
>>  #include "icss_iep.h"
>> @@ -125,6 +127,7 @@ struct prueth_rx_chn {
>>  	u32 descs_num;
>>  	unsigned int irq[ICSSG_MAX_RFLOWS];	/* separate irq per flow */
>>  	char name[32];
>> +	struct page_pool *pg_pool;
>>  };
>>  
>>  /* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
>> @@ -202,6 +205,10 @@ struct prueth_emac {
>>  	unsigned long rx_pace_timeout_ns;
>>  };
>>  
>> +/* The buf includes headroom compatible with both skb and xdpf */
>> +#define PRUETH_HEADROOM_NA (max(XDP_PACKET_HEADROOM, NET_SKB_PAD) + NET_IP_ALIGN)
>> +#define PRUETH_HEADROOM  ALIGN(PRUETH_HEADROOM_NA, sizeof(long))
>> +
>>  /**
>>   * struct prueth_pdata - PRUeth platform data
>>   * @fdqring_mode: Free desc queue mode
>> @@ -402,9 +409,10 @@ int prueth_init_rx_chns(struct prueth_emac *emac,
>>  			struct prueth_rx_chn *rx_chn,
>>  			char *name, u32 max_rflows,
>>  			u32 max_desc_num);
>> -int prueth_dma_rx_push(struct prueth_emac *emac,
>> -		       struct sk_buff *skb,
>> -		       struct prueth_rx_chn *rx_chn);
>> +int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
>> +			      struct prueth_rx_chn *rx_chn,
>> +			      struct page *page, u32 buf_len);
>> +unsigned int prueth_rxbuf_total_len(unsigned int len);
>>  void emac_rx_timestamp(struct prueth_emac *emac,
>>  		       struct sk_buff *skb, u32 *psdata);
>>  enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev);
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
>> index 3dc86397c367..c2bc7169355a 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
>> @@ -274,10 +274,12 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
>>  	struct prueth_rx_chn *rx_chn = &emac->rx_mgm_chn;
>>  	struct net_device *ndev = emac->ndev;
>>  	struct cppi5_host_desc_t *desc_rx;
>> -	struct sk_buff *skb, *new_skb;
>> +	struct page *page, *new_page;
>>  	dma_addr_t desc_dma, buf_dma;
>>  	u32 buf_dma_len, pkt_len;
>> +	struct sk_buff *skb;
>>  	void **swdata;
>> +	void *pa;
>>  	int ret;
>>  
>>  	ret = k3_udma_glue_pop_rx_chn(rx_chn->rx_chn, flow_id, &desc_dma);
>> @@ -299,32 +301,35 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
>>  	}
>>  
>>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
>> -	skb = *swdata;
>> +	page = *swdata;
>>  	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
>>  	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
>>  
>>  	dma_unmap_single(rx_chn->dma_dev, buf_dma, buf_dma_len, DMA_FROM_DEVICE);
>>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>>  
>> -	new_skb = netdev_alloc_skb_ip_align(ndev, PRUETH_MAX_PKT_SIZE);
>> +	new_page = page_pool_dev_alloc_pages(rx_chn->pg_pool);
>>  	/* if allocation fails we drop the packet but push the
>>  	 * descriptor back to the ring with old skb to prevent a stall
>>  	 */
>> -	if (!new_skb) {
>> +	if (!new_page) {
>>  		netdev_err(ndev,
>> -			   "skb alloc failed, dropped mgm pkt from flow %d\n",
>> +			   "page alloc failed, dropped mgm pkt from flow %d\n",
>>  			   flow_id);
>> -		new_skb = skb;
>> +		new_page = page;
>>  		skb = NULL;	/* return NULL */
>>  	} else {
>>  		/* return the filled skb */
>> +		pa = page_address(page);
>> +		skb = build_skb(pa, prueth_rxbuf_total_len(pkt_len));
>>  		skb_put(skb, pkt_len);
>>  	}
>>  
>>  	/* queue another DMA */
>> -	ret = prueth_dma_rx_push(emac, new_skb, &emac->rx_mgm_chn);
>> +	ret = prueth_dma_rx_push_mapped(emac, &emac->rx_chns, new_page,
>> +					PRUETH_MAX_PKT_SIZE);
>>  	if (WARN_ON(ret < 0))
>> -		dev_kfree_skb_any(new_skb);
>> +		page_pool_recycle_direct(rx_chn->pg_pool, new_page);
>>  
>>  	return skb;
>>  }
>> -- 
>> 2.25.1
>> 
>> 
> 


