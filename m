Return-Path: <bpf+bounces-7071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C923770F38
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 12:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0392C282569
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 10:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AD9945F;
	Sat,  5 Aug 2023 10:12:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B2A23A2
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 10:12:32 +0000 (UTC)
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Aug 2023 03:12:30 PDT
Received: from out-106.mta1.migadu.com (out-106.mta1.migadu.com [IPv6:2001:41d0:203:375::6a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634A4469C
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 03:12:30 -0700 (PDT)
Message-ID: <d5cca789-c25e-86ad-2579-0dba00e079b3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691229774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLCKmyGOo8gZrfWaZEK9b18wjmNeUaOACyQ4AEz9Plw=;
	b=QXzIVj/+3YrCJyMLRgszobIAsjbOaGZQzDEevmbCYJ2J2nCSB2qKqBF2MU/zcCxZpMd1R7
	09KYPyRLOsosCSJDRAD1kuGGhT+JVeByfBoqH1UvNyVDH0epPm1sFgrbNt6R/dKB07bZhe
	Fiw/HCXb4M5JoLbkD/yg31oeGMlAnMc=
Date: Sat, 5 Aug 2023 18:02:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V6,net-next] net: mana: Add page pool for RX buffers
To: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
 olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
 wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 leon@kernel.org, longli@microsoft.com, ssengar@linux.microsoft.com,
 linux-rdma@vger.kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, ast@kernel.org, sharmaajay@microsoft.com,
 hawk@kernel.org, tglx@linutronix.de, shradhagupta@linux.microsoft.com,
 linux-kernel@vger.kernel.org
References: <1691181233-25286-1-git-send-email-haiyangz@microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1691181233-25286-1-git-send-email-haiyangz@microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

在 2023/8/5 4:33, Haiyang Zhang 写道:
> Add page pool for RX buffers for faster buffer cycle and reduce CPU
> usage.
> 
> The standard page pool API is used.
> 
> With iperf and 128 threads test, this patch improved the throughput
> by 12-15%, and decreased the IRQ associated CPU's usage from 99-100% to
> 10-50%.

https://www.spinics.net/lists/netdev/msg584734.html

The performance of throughput and cpu utility is very good. I have a 
similar patch series with this in the above link.
And David Miller had the following comments:
"
The system is supposed to hold onto enough atomic memory to absorb all
reasonable situations like this.

If anything a solution to this problem belongs generically somewhere,
not in a driver.  And furthermore looping over an allocation attempt
with a delay is strongly discouraged.
"

Hope your commit can be merged into upstream (pray).

Zhu Yanjun

> 
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> V6:
> Added perf info as suggested by Jesper Dangaard Brouer
> V5:
> In err path, set page_pool_put_full_page(..., false) as suggested by
> Jakub Kicinski
> V4:
> Add nid setting, remove page_pool_nid_changed(), as suggested by
> Jesper Dangaard Brouer
> V3:
> Update xdp mem model, pool param, alloc as suggested by Jakub Kicinski
> V2:
> Use the standard page pool API as suggested by Jesper Dangaard Brouer
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 90 +++++++++++++++----
>   include/net/mana/mana.h                       |  3 +
>   2 files changed, 77 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index ac2acc9aca9d..1a4ac1c8736e 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1414,8 +1414,8 @@ static struct sk_buff *mana_build_skb(struct mana_rxq *rxq, void *buf_va,
>   	return skb;
>   }
>   
> -static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
> -			struct mana_rxq *rxq)
> +static void mana_rx_skb(void *buf_va, bool from_pool,
> +			struct mana_rxcomp_oob *cqe, struct mana_rxq *rxq)
>   {
>   	struct mana_stats_rx *rx_stats = &rxq->stats;
>   	struct net_device *ndev = rxq->ndev;
> @@ -1448,6 +1448,9 @@ static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
>   	if (!skb)
>   		goto drop;
>   
> +	if (from_pool)
> +		skb_mark_for_recycle(skb);
> +
>   	skb->dev = napi->dev;
>   
>   	skb->protocol = eth_type_trans(skb, ndev);
> @@ -1498,9 +1501,14 @@ static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
>   	u64_stats_update_end(&rx_stats->syncp);
>   
>   drop:
> -	WARN_ON_ONCE(rxq->xdp_save_va);
> -	/* Save for reuse */
> -	rxq->xdp_save_va = buf_va;
> +	if (from_pool) {
> +		page_pool_recycle_direct(rxq->page_pool,
> +					 virt_to_head_page(buf_va));
> +	} else {
> +		WARN_ON_ONCE(rxq->xdp_save_va);
> +		/* Save for reuse */
> +		rxq->xdp_save_va = buf_va;
> +	}
>   
>   	++ndev->stats.rx_dropped;
>   
> @@ -1508,11 +1516,13 @@ static void mana_rx_skb(void *buf_va, struct mana_rxcomp_oob *cqe,
>   }
>   
>   static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
> -			     dma_addr_t *da, bool is_napi)
> +			     dma_addr_t *da, bool *from_pool, bool is_napi)
>   {
>   	struct page *page;
>   	void *va;
>   
> +	*from_pool = false;
> +
>   	/* Reuse XDP dropped page if available */
>   	if (rxq->xdp_save_va) {
>   		va = rxq->xdp_save_va;
> @@ -1533,17 +1543,22 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
>   			return NULL;
>   		}
>   	} else {
> -		page = dev_alloc_page();
> +		page = page_pool_dev_alloc_pages(rxq->page_pool);
>   		if (!page)
>   			return NULL;
>   
> +		*from_pool = true;
>   		va = page_to_virt(page);
>   	}
>   
>   	*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
>   			     DMA_FROM_DEVICE);
>   	if (dma_mapping_error(dev, *da)) {
> -		put_page(virt_to_head_page(va));
> +		if (*from_pool)
> +			page_pool_put_full_page(rxq->page_pool, page, false);
> +		else
> +			put_page(virt_to_head_page(va));
> +
>   		return NULL;
>   	}
>   
> @@ -1552,21 +1567,25 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
>   
>   /* Allocate frag for rx buffer, and save the old buf */
>   static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
> -			       struct mana_recv_buf_oob *rxoob, void **old_buf)
> +			       struct mana_recv_buf_oob *rxoob, void **old_buf,
> +			       bool *old_fp)
>   {
> +	bool from_pool;
>   	dma_addr_t da;
>   	void *va;
>   
> -	va = mana_get_rxfrag(rxq, dev, &da, true);
> +	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, true);
>   	if (!va)
>   		return;
>   
>   	dma_unmap_single(dev, rxoob->sgl[0].address, rxq->datasize,
>   			 DMA_FROM_DEVICE);
>   	*old_buf = rxoob->buf_va;
> +	*old_fp = rxoob->from_pool;
>   
>   	rxoob->buf_va = va;
>   	rxoob->sgl[0].address = da;
> +	rxoob->from_pool = from_pool;
>   }
>   
>   static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
> @@ -1580,6 +1599,7 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
>   	struct device *dev = gc->dev;
>   	void *old_buf = NULL;
>   	u32 curr, pktlen;
> +	bool old_fp;
>   
>   	apc = netdev_priv(ndev);
>   
> @@ -1622,12 +1642,12 @@ static void mana_process_rx_cqe(struct mana_rxq *rxq, struct mana_cq *cq,
>   	rxbuf_oob = &rxq->rx_oobs[curr];
>   	WARN_ON_ONCE(rxbuf_oob->wqe_inf.wqe_size_in_bu != 1);
>   
> -	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf);
> +	mana_refill_rx_oob(dev, rxq, rxbuf_oob, &old_buf, &old_fp);
>   
>   	/* Unsuccessful refill will have old_buf == NULL.
>   	 * In this case, mana_rx_skb() will drop the packet.
>   	 */
> -	mana_rx_skb(old_buf, oob, rxq);
> +	mana_rx_skb(old_buf, old_fp, oob, rxq);
>   
>   drop:
>   	mana_move_wq_tail(rxq->gdma_rq, rxbuf_oob->wqe_inf.wqe_size_in_bu);
> @@ -1887,6 +1907,7 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
>   	struct mana_recv_buf_oob *rx_oob;
>   	struct device *dev = gc->dev;
>   	struct napi_struct *napi;
> +	struct page *page;
>   	int i;
>   
>   	if (!rxq)
> @@ -1919,10 +1940,18 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
>   		dma_unmap_single(dev, rx_oob->sgl[0].address,
>   				 rx_oob->sgl[0].size, DMA_FROM_DEVICE);
>   
> -		put_page(virt_to_head_page(rx_oob->buf_va));
> +		page = virt_to_head_page(rx_oob->buf_va);
> +
> +		if (rx_oob->from_pool)
> +			page_pool_put_full_page(rxq->page_pool, page, false);
> +		else
> +			put_page(page);
> +
>   		rx_oob->buf_va = NULL;
>   	}
>   
> +	page_pool_destroy(rxq->page_pool);
> +
>   	if (rxq->gdma_rq)
>   		mana_gd_destroy_queue(gc, rxq->gdma_rq);
>   
> @@ -1933,18 +1962,20 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
>   			    struct mana_rxq *rxq, struct device *dev)
>   {
>   	struct mana_port_context *mpc = netdev_priv(rxq->ndev);
> +	bool from_pool = false;
>   	dma_addr_t da;
>   	void *va;
>   
>   	if (mpc->rxbufs_pre)
>   		va = mana_get_rxbuf_pre(rxq, &da);
>   	else
> -		va = mana_get_rxfrag(rxq, dev, &da, false);
> +		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, false);
>   
>   	if (!va)
>   		return -ENOMEM;
>   
>   	rx_oob->buf_va = va;
> +	rx_oob->from_pool = from_pool;
>   
>   	rx_oob->sgl[0].address = da;
>   	rx_oob->sgl[0].size = rxq->datasize;
> @@ -2014,6 +2045,26 @@ static int mana_push_wqe(struct mana_rxq *rxq)
>   	return 0;
>   }
>   
> +static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
> +{
> +	struct page_pool_params pprm = {};
> +	int ret;
> +
> +	pprm.pool_size = RX_BUFFERS_PER_QUEUE;
> +	pprm.nid = gc->numa_node;
> +	pprm.napi = &rxq->rx_cq.napi;
> +
> +	rxq->page_pool = page_pool_create(&pprm);
> +
> +	if (IS_ERR(rxq->page_pool)) {
> +		ret = PTR_ERR(rxq->page_pool);
> +		rxq->page_pool = NULL;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
>   					u32 rxq_idx, struct mana_eq *eq,
>   					struct net_device *ndev)
> @@ -2043,6 +2094,13 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
>   	mana_get_rxbuf_cfg(ndev->mtu, &rxq->datasize, &rxq->alloc_size,
>   			   &rxq->headroom);
>   
> +	/* Create page pool for RX queue */
> +	err = mana_create_page_pool(rxq, gc);
> +	if (err) {
> +		netdev_err(ndev, "Create page pool err:%d\n", err);
> +		goto out;
> +	}
> +
>   	err = mana_alloc_rx_wqe(apc, rxq, &rq_size, &cq_size);
>   	if (err)
>   		goto out;
> @@ -2114,8 +2172,8 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
>   
>   	WARN_ON(xdp_rxq_info_reg(&rxq->xdp_rxq, ndev, rxq_idx,
>   				 cq->napi.napi_id));
> -	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq,
> -					   MEM_TYPE_PAGE_SHARED, NULL));
> +	WARN_ON(xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq, MEM_TYPE_PAGE_POOL,
> +					   rxq->page_pool));
>   
>   	napi_enable(&cq->napi);
>   
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 024ad8ddb27e..b12859511839 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -280,6 +280,7 @@ struct mana_recv_buf_oob {
>   	struct gdma_wqe_request wqe_req;
>   
>   	void *buf_va;
> +	bool from_pool; /* allocated from a page pool */
>   
>   	/* SGL of the buffer going to be sent has part of the work request. */
>   	u32 num_sge;
> @@ -330,6 +331,8 @@ struct mana_rxq {
>   	bool xdp_flush;
>   	int xdp_rc; /* XDP redirect return code */
>   
> +	struct page_pool *page_pool;
> +
>   	/* MUST BE THE LAST MEMBER:
>   	 * Each receive buffer has an associated mana_recv_buf_oob.
>   	 */


