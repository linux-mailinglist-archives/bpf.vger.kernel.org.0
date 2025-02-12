Return-Path: <bpf+bounces-51257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 826C3A32824
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 15:12:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AFB188408C
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8A20F084;
	Wed, 12 Feb 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esuZAgZd"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27DC20E329;
	Wed, 12 Feb 2025 14:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369532; cv=none; b=XVfXkOKGseAy/z9kiwwLWcxdTGM3u0uk1COUgbp79DAQLA/aOXO2/hLSqq+iBrjUsncmvACcYAcCXRJZJs3xihrFy/NM9lgKjnUpCMVaudxEH/Otz9f+PTyH5RwpMgfzn0y+LY5WdFWOf82EF3DAMT/Kd5JdL7bF0pQIN55meZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369532; c=relaxed/simple;
	bh=JLM4qBRwSKvd/BUAUKnUFh6BdMIQHqqA45JvJjEBQio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DPnrk9fvZloKbNF+/2p7Yk7kk0xk6zPeoJm+aCTO3SP0AZGhjTMYOa6J+WsS6TIt/ofxxVOMjy8RpgVHwYMIiVt/ZsXlvDWkKsDyZ0QZMwH1aHGfwCpFHjytazXVyPpjniq2mNGrhkO5H2V63CFoeQTgW0SXHKfYJdyxLTQDT9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esuZAgZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB7EC4CEDF;
	Wed, 12 Feb 2025 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739369532;
	bh=JLM4qBRwSKvd/BUAUKnUFh6BdMIQHqqA45JvJjEBQio=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=esuZAgZd3GiaHENSDZtVrJtKKknfaDVJyGkkqUfnO655pThLgtCRm2vXaZ+oraTgs
	 SZvEGA1/1buIkSK8chDi1Zsy58qHwDYeUzaIksw93D8Wk9N7ETiR3B1x/rkOxX8jCT
	 vAhDlR9RLTxOtVHCefNZGIwhuzrmXXR5T6fnRJ4jn7MGAohI6tFCCTYS0Wv7+RWthL
	 73SUUhK5GMIgdmlBvRlzx6/8TfUxhKYybmk9j4D/jpcQxbIAY1Gww+aBsM8Iq2xpRJ
	 frzQVI82xJxyMDZGwpsMbOjQyYYICtG60iaHOiE8FuoDeeoUXnid2bbAs1YJSbQQ8T
	 1cN1lNmND8SMg==
Message-ID: <b807f2ae-b92b-433f-af4c-f0fd9a83bc1f@kernel.org>
Date: Wed, 12 Feb 2025 16:12:04 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] net: ti: icssg-prueth: introduce and use
 prueth_swdata struct for SWDATA
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
 <20250210103352.541052-3-m-malladi@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20250210103352.541052-3-m-malladi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Meghana,

On 10/02/2025 12:33, Meghana Malladi wrote:
> From: Roger Quadros <rogerq@kernel.org>
> 
> We have different cases for SWDATA (skb, page, cmd, etc)
> so it is better to have a dedicated data structure for that.
> We can embed the type field inside the struct and use it
> to interpret the data in completion handlers.
> 
> Increase SWDATA size to 48 so we have some room to add
> more data if required.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
> ---
> v1: https://lore.kernel.org/all/20250122124951.3072410-1-m-malladi@ti.com/
> 
> Changes since v1 (v2-v1): None
> 
>  drivers/net/ethernet/ti/icssg/icssg_common.c  | 47 ++++++++++++-------
>  drivers/net/ethernet/ti/icssg/icssg_config.h  |  2 +-
>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  6 +++
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 18 +++++++
>  .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  4 +-
>  5 files changed, 58 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index c3c1e2bf461e..a124c5773551 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -136,12 +136,12 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  	struct net_device *ndev = emac->ndev;
>  	struct cppi5_host_desc_t *desc_tx;
>  	struct netdev_queue *netif_txq;
> +	struct prueth_swdata *swdata;
>  	struct prueth_tx_chn *tx_chn;
>  	unsigned int total_bytes = 0;
>  	struct sk_buff *skb;
>  	dma_addr_t desc_dma;
>  	int res, num_tx = 0;
> -	void **swdata;
>  
>  	tx_chn = &emac->tx_chns[chn];
>  
> @@ -163,12 +163,18 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>  		swdata = cppi5_hdesc_get_swdata(desc_tx);
>  
>  		/* was this command's TX complete? */
> -		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
> +		if (emac->is_sr1 && (void *)(swdata) == emac->cmd_data) {
>  			prueth_xmit_free(tx_chn, desc_tx);
>  			continue;
>  		}
>  
> -		skb = *(swdata);
> +		if (swdata->type != PRUETH_SWDATA_SKB) {
> +			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
> +			budget++;
> +			continue;

We are leaking the tx descriptor here. need to call prueth_xmit_free(tx_chn, desc_tx)?

> +		}
> +
> +		skb = swdata->data.skb;
>  		prueth_xmit_free(tx_chn, desc_tx);
>  
>  		ndev = skb->dev;
> @@ -472,9 +478,9 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
>  {
>  	struct net_device *ndev = emac->ndev;
>  	struct cppi5_host_desc_t *desc_rx;
> +	struct prueth_swdata *swdata;
>  	dma_addr_t desc_dma;
>  	dma_addr_t buf_dma;
> -	void **swdata;
>  
>  	buf_dma = page_pool_get_dma_addr(page) + PRUETH_HEADROOM;
>  	desc_rx = k3_cppi_desc_pool_alloc(rx_chn->desc_pool);
> @@ -490,7 +496,8 @@ int prueth_dma_rx_push_mapped(struct prueth_emac *emac,
>  	cppi5_hdesc_attach_buf(desc_rx, buf_dma, buf_len, buf_dma, buf_len);
>  
>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
> -	*swdata = page;
> +	swdata->type = PRUETH_SWDATA_PAGE;
> +	swdata->data.page = page;
>  
>  	return k3_udma_glue_push_rx_chn(rx_chn->rx_chn, PRUETH_RX_FLOW_DATA,
>  					desc_rx, desc_dma);
> @@ -539,11 +546,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>  	u32 buf_dma_len, pkt_len, port_id = 0;
>  	struct net_device *ndev = emac->ndev;
>  	struct cppi5_host_desc_t *desc_rx;
> +	struct prueth_swdata *swdata;
>  	dma_addr_t desc_dma, buf_dma;
>  	struct page *page, *new_page;
>  	struct page_pool *pool;
>  	struct sk_buff *skb;
> -	void **swdata;
>  	u32 *psdata;
>  	void *pa;
>  	int ret;
> @@ -561,7 +568,11 @@ static int emac_rx_packet(struct prueth_emac *emac, u32 flow_id)
>  
>  	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
> -	page = *swdata;
> +	if (swdata->type != PRUETH_SWDATA_PAGE) {
> +		netdev_err(ndev, "rx_pkt: invalid swdata->type %d\n", swdata->type);

what about freeing the rx descriptor?

> +		return 0;
> +	}

need new line.

> +	page = swdata->data.page;
>  
drop new line.

>  	page_pool_dma_sync_for_cpu(pool, page, 0, PAGE_SIZE);
>  	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
> @@ -627,16 +638,18 @@ static void prueth_rx_cleanup(void *data, dma_addr_t desc_dma)
>  {
>  	struct prueth_rx_chn *rx_chn = data;
>  	struct cppi5_host_desc_t *desc_rx;
> +	struct prueth_swdata *swdata;
>  	struct page_pool *pool;
>  	struct page *page;
> -	void **swdata;
>  
>  	pool = rx_chn->pg_pool;
>  
>  	desc_rx = k3_cppi_desc_pool_dma2virt(rx_chn->desc_pool, desc_dma);
>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
> -	page = *swdata;
> -	page_pool_recycle_direct(pool, page);
> +	if (swdata->type == PRUETH_SWDATA_PAGE) {
> +		page = swdata->data.page;
> +		page_pool_recycle_direct(pool, page);
> +	}

need new line.

>  	k3_cppi_desc_pool_free(rx_chn->desc_pool, desc_rx);
>  }
>  
> @@ -673,13 +686,13 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>  	struct prueth_emac *emac = netdev_priv(ndev);
>  	struct prueth *prueth = emac->prueth;
>  	struct netdev_queue *netif_txq;
> +	struct prueth_swdata *swdata;
>  	struct prueth_tx_chn *tx_chn;
>  	dma_addr_t desc_dma, buf_dma;
>  	u32 pkt_len, dst_tag_id;
>  	int i, ret = 0, q_idx;
>  	bool in_tx_ts = 0;
>  	int tx_ts_cookie;
> -	void **swdata;
>  	u32 *epib;
>  
>  	pkt_len = skb_headlen(skb);
> @@ -741,7 +754,8 @@ enum netdev_tx icssg_ndo_start_xmit(struct sk_buff *skb, struct net_device *ndev
>  	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>  	cppi5_hdesc_attach_buf(first_desc, buf_dma, pkt_len, buf_dma, pkt_len);
>  	swdata = cppi5_hdesc_get_swdata(first_desc);
> -	*swdata = skb;
> +	swdata->type = PRUETH_SWDATA_SKB;
> +	swdata->data.skb = skb;
>  
>  	/* Handle the case where skb is fragmented in pages */
>  	cur_desc = first_desc;
> @@ -844,15 +858,16 @@ static void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
>  {
>  	struct prueth_tx_chn *tx_chn = data;
>  	struct cppi5_host_desc_t *desc_tx;
> +	struct prueth_swdata *swdata;
>  	struct sk_buff *skb;
> -	void **swdata;
>  
>  	desc_tx = k3_cppi_desc_pool_dma2virt(tx_chn->desc_pool, desc_dma);
>  	swdata = cppi5_hdesc_get_swdata(desc_tx);
> -	skb = *(swdata);
> +	if (swdata->type == PRUETH_SWDATA_SKB) {
> +		skb = swdata->data.skb;
> +		dev_kfree_skb_any(skb);
> +	}

need new line.

>  	prueth_xmit_free(tx_chn, desc_tx);
> -
> -	dev_kfree_skb_any(skb);
>  }
>  
>  irqreturn_t prueth_rx_irq(int irq, void *dev_id)
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_config.h b/drivers/net/ethernet/ti/icssg/icssg_config.h
> index c884e9fa099e..eab84e11d80e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_config.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_config.h
> @@ -20,7 +20,7 @@ struct icssg_flow_cfg {
>  
>  #define PRUETH_PKT_TYPE_CMD	0x10
>  #define PRUETH_NAV_PS_DATA_SIZE	16	/* Protocol specific data size */
> -#define PRUETH_NAV_SW_DATA_SIZE	16	/* SW related data size */
> +#define PRUETH_NAV_SW_DATA_SIZE	48	/* SW related data size */

Why do you need 48? I think it should fit in 16.

>  #define PRUETH_MAX_TX_DESC	512
>  #define PRUETH_MAX_RX_DESC	512
>  #define PRUETH_MAX_RX_FLOWS	1	/* excluding default flow */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 00ed97860547..e5e4efe485f6 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -1522,6 +1522,12 @@ static int prueth_probe(struct platform_device *pdev)
>  
>  	np = dev->of_node;
>  
> +	if (sizeof(struct prueth_swdata) > PRUETH_NAV_SW_DATA_SIZE) {
> +		dev_err(dev, "insufficient SW_DATA size: %d vs %ld\n",
> +			PRUETH_NAV_SW_DATA_SIZE, sizeof(struct prueth_swdata));
> +		return -ENOMEM;
> +	}
> +

Can this be made a build time check instead of runtime?

>  	prueth = devm_kzalloc(dev, sizeof(*prueth), GFP_KERNEL);
>  	if (!prueth)
>  		return -ENOMEM;
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index c7b906de18af..2c8585255b7c 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -136,6 +136,24 @@ struct prueth_rx_chn {
>  	struct page_pool *pg_pool;
>  };
>  
> +enum prueth_swdata_type {
> +	PRUETH_SWDATA_INVALID = 0,
> +	PRUETH_SWDATA_SKB,
> +	PRUETH_SWDATA_PAGE,
> +	PRUETH_SWDATA_CMD,
> +};
> +
> +union prueth_data {
> +	struct sk_buff *skb;
> +	struct page *page;
> +	u32 cmd;
> +};
> +
> +struct prueth_swdata {
> +	union prueth_data data;
> +	enum prueth_swdata_type type;
> +};

Can we re-write this like so with type first and union embedded inside?

struct prueth_swdata {
	enum prueth_swdata_type type;
	union prueth_data {
		struct sk_buff *skb;
		struct page *page;
		u32 cmd;
	};
};


> +
>  /* There are 4 Tx DMA channels, but the highest priority is CH3 (thread 3)
>   * and lower three are lower priority channels or threads.
>   */
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> index aeeb8a50376b..7bbe0808b3ec 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c
> @@ -275,10 +275,10 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
>  	struct net_device *ndev = emac->ndev;
>  	struct cppi5_host_desc_t *desc_rx;
>  	struct page *page, *new_page;
> +	struct prueth_swdata *swdata;
>  	dma_addr_t desc_dma, buf_dma;
>  	u32 buf_dma_len, pkt_len;
>  	struct sk_buff *skb;
> -	void **swdata;
>  	void *pa;
>  	int ret;
>  
> @@ -301,7 +301,7 @@ static struct sk_buff *prueth_process_rx_mgm(struct prueth_emac *emac,
>  	}
>  
>  	swdata = cppi5_hdesc_get_swdata(desc_rx);
> -	page = *swdata;
> +	page = swdata->data.page;
>  	cppi5_hdesc_get_obuf(desc_rx, &buf_dma, &buf_dma_len);
>  	pkt_len = cppi5_hdesc_get_pktlen(desc_rx);
>  

-- 
cheers,
-roger


