Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B6211D05
	for <lists+bpf@lfdr.de>; Thu,  2 Jul 2020 09:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgGBHbK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jul 2020 03:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgGBHbJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jul 2020 03:31:09 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE834C08C5DD
        for <bpf@vger.kernel.org>; Thu,  2 Jul 2020 00:31:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so26847819wrs.11
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2020 00:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TeNO9fvZBv4kp0oe/KUun/TtlQ2KC3o5EXDHauIoTOY=;
        b=x+EHr3Cg3DlzD0LJJmEIY4F3k9HhgNMafAXT5KX39PMsPJmnc14UFZ9bgosN9aoky5
         qBYQUXGbSh64n6AguwEpujbGGTRK9o0T2LTllFDViR6MG7X83v3SjRx/WxJHgtJzl4C/
         ViXhV7Kt8f23Q6XIzrnPwJgQCCYSYaeBjoT8Ck+iVROygtkFTsOvfMwG4/PjIHkS3mae
         RA/C4XMW5EnrCPbZWiyh2lYxPlilJi1ZbJGxS7T0I+uKunDfaShj9zWfJG6osVDs/+up
         e7pb5a8IDd9+ySOq4+zjhVqVwpmgcO9ENh2tR16Qx7Lv2XlI4CrzniyuM/EF+nAwVtCs
         OKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TeNO9fvZBv4kp0oe/KUun/TtlQ2KC3o5EXDHauIoTOY=;
        b=ChA01rRKzTAPb2Ec4Mf40cr7jKie4BhdaFUOoDZvIU6rx9tR3y1uF3ZoFrpbCsm8+n
         dA6x/gCbfJpG1h48eHxMfmmJB92AMaFUwezBiLasDcYBvN7Lm+VdHaIs7lG6hGAgkE4d
         XdoHs6NtU8Y8OUmc3JlD5zrC4zEdoci4PxFKnK13Px3P39yHhgk9UMX4Aef1TG3B0f/8
         A7jETVhurEL79IJT9lQRimbHnU9vq9w2hXOJV5gdUzaV+rN/mtuU/oivGPhmd2zqbOZ5
         OVIHSRmPmCtlWOENPWQ6BsR4aa4eA2Mjgg/pzLjiGqCu4HjG3qoOVZsbu8ofAmJ7jE7j
         VlrQ==
X-Gm-Message-State: AOAM533Rfsk/TWopY7A7k0CyIv/DO5FeycZgfwqjo8qlNzmadvQr+4KL
        HdfSqoblSeKJqcL0WiMSI/zPAg==
X-Google-Smtp-Source: ABdhPJwbGVQD75dvLJX42ivcJBkDhhpTJYy3DStS2YXIVX1ehCFXTgp374qjs/I2K1Vju+loXr9fog==
X-Received: by 2002:adf:9148:: with SMTP id j66mr27968405wrj.311.1593675067451;
        Thu, 02 Jul 2020 00:31:07 -0700 (PDT)
Received: from apalos.home (athedsl-4423884.home.otenet.gr. [79.130.240.188])
        by smtp.gmail.com with ESMTPSA id n14sm10252956wro.81.2020.07.02.00.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 00:31:06 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:31:04 +0300
From:   ilias.apalodimas@linaro.org
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Sven Auhagen <sven.auhagen@voleatech.de>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>, maxime.chevallier@bootlin.com,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 2/4] mvpp2: use page_pool allocator
Message-ID: <20200702073104.GA496703@apalos.home>
References: <20200630180930.87506-1-mcroce@linux.microsoft.com>
 <20200630180930.87506-3-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630180930.87506-3-mcroce@linux.microsoft.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Matteo, 

Thanks for working on this!

On Tue, Jun 30, 2020 at 08:09:28PM +0200, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Use the page_pool API for memory management. This is a prerequisite for
> native XDP support.
> 
> Tested-by: Sven Auhagen <sven.auhagen@voleatech.de>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  drivers/net/ethernet/marvell/Kconfig          |   1 +
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |   8 +
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 155 +++++++++++++++---
>  3 files changed, 139 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/Kconfig b/drivers/net/ethernet/marvell/Kconfig
> index cd8ddd1ef6f2..ef4f35ba077d 100644
> --- a/drivers/net/ethernet/marvell/Kconfig
> +++ b/drivers/net/ethernet/marvell/Kconfig
> @@ -87,6 +87,7 @@ config MVPP2
>  	depends on ARCH_MVEBU || COMPILE_TEST
>  	select MVMDIO
>  	select PHYLINK
> +	select PAGE_POOL
>  	help
>  	  This driver supports the network interface units in the
>  	  Marvell ARMADA 375, 7K and 8K SoCs.
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> index 543a310ec102..4c16c9e9c1e5 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -15,6 +15,7 @@
>  #include <linux/phy.h>
>  #include <linux/phylink.h>
>  #include <net/flow_offload.h>
> +#include <net/page_pool.h>
>  
>  /* Fifo Registers */
>  #define MVPP2_RX_DATA_FIFO_SIZE_REG(port)	(0x00 + 4 * (port))
> @@ -820,6 +821,9 @@ struct mvpp2 {
>  
>  	/* RSS Indirection tables */
>  	struct mvpp2_rss_table *rss_tables[MVPP22_N_RSS_TABLES];
> +
> +	/* page_pool allocator */
> +	struct page_pool *page_pool[MVPP2_PORT_MAX_RXQ];
>  };
>  
>  struct mvpp2_pcpu_stats {
> @@ -1161,6 +1165,10 @@ struct mvpp2_rx_queue {
>  
>  	/* Port's logic RXQ number to which physical RXQ is mapped */
>  	int logic_rxq;
> +
> +	/* XDP memory accounting */
> +	struct xdp_rxq_info xdp_rxq_short;
> +	struct xdp_rxq_info xdp_rxq_long;
>  };
>  
>  struct mvpp2_bm_pool {
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 027de7291f92..9e2e8fb0a0b8 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -95,6 +95,22 @@ static inline u32 mvpp2_cpu_to_thread(struct mvpp2 *priv, int cpu)
>  	return cpu % priv->nthreads;
>  }
>  
> +static struct page_pool *
> +mvpp2_create_page_pool(struct device *dev, int num, int len)
> +{
> +	struct page_pool_params pp_params = {
> +		/* internal DMA mapping in page_pool */
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.pool_size = num,
> +		.nid = NUMA_NO_NODE,
> +		.dev = dev,
> +		.dma_dir = DMA_FROM_DEVICE,
> +		.max_len = len,
> +	};
> +
> +	return page_pool_create(&pp_params);
> +}
> +
>  /* These accessors should be used to access:
>   *
>   * - per-thread registers, where each thread has its own copy of the
> @@ -327,17 +343,26 @@ static inline int mvpp2_txq_phys(int port, int txq)
>  	return (MVPP2_MAX_TCONT + port) * MVPP2_MAX_TXQ + txq;
>  }
>  
> -static void *mvpp2_frag_alloc(const struct mvpp2_bm_pool *pool)
> +/* Returns a struct page if page_pool is set, otherwise a buffer */
> +static void *mvpp2_frag_alloc(const struct mvpp2_bm_pool *pool,
> +			      struct page_pool *page_pool)
>  {
> +	if (page_pool)
> +		return page_pool_alloc_pages(page_pool,
> +					     GFP_ATOMIC | __GFP_NOWARN);

page_pool_dev_alloc_pages() can set these flags for you, instead of explicitly
calling them

> +
>  	if (likely(pool->frag_size <= PAGE_SIZE))
>  		return netdev_alloc_frag(pool->frag_size);
> -	else
> -		return kmalloc(pool->frag_size, GFP_ATOMIC);
> +
> +	return kmalloc(pool->frag_size, GFP_ATOMIC);
>  }
>  
> -static void mvpp2_frag_free(const struct mvpp2_bm_pool *pool, void *data)
> +static void mvpp2_frag_free(const struct mvpp2_bm_pool *pool,
> +			    struct page_pool *page_pool, void *data)
>  {
> -	if (likely(pool->frag_size <= PAGE_SIZE))
> +	if (page_pool)
> +		page_pool_put_full_page(page_pool, virt_to_head_page(data), false);
> +	else if (likely(pool->frag_size <= PAGE_SIZE))
>  		skb_free_frag(data);
>  	else
>  		kfree(data);
> @@ -442,6 +467,7 @@ static void mvpp2_bm_bufs_get_addrs(struct device *dev, struct mvpp2 *priv,
>  static void mvpp2_bm_bufs_free(struct device *dev, struct mvpp2 *priv,
>  			       struct mvpp2_bm_pool *bm_pool, int buf_num)
>  {
> +	struct page_pool *pp = NULL;
>  	int i;
>  
>  	if (buf_num > bm_pool->buf_num) {
> @@ -450,6 +476,9 @@ static void mvpp2_bm_bufs_free(struct device *dev, struct mvpp2 *priv,
>  		buf_num = bm_pool->buf_num;
>  	}
>  
> +	if (priv->percpu_pools)
> +		pp = priv->page_pool[bm_pool->id];
> +
>  	for (i = 0; i < buf_num; i++) {
>  		dma_addr_t buf_dma_addr;
>  		phys_addr_t buf_phys_addr;
> @@ -458,14 +487,15 @@ static void mvpp2_bm_bufs_free(struct device *dev, struct mvpp2 *priv,
>  		mvpp2_bm_bufs_get_addrs(dev, priv, bm_pool,
>  					&buf_dma_addr, &buf_phys_addr);
>  
> -		dma_unmap_single(dev, buf_dma_addr,
> -				 bm_pool->buf_size, DMA_FROM_DEVICE);
> +		if (!pp)
> +			dma_unmap_single(dev, buf_dma_addr,
> +					 bm_pool->buf_size, DMA_FROM_DEVICE);
>  
>  		data = (void *)phys_to_virt(buf_phys_addr);
>  		if (!data)
>  			break;
>  
> -		mvpp2_frag_free(bm_pool, data);
> +		mvpp2_frag_free(bm_pool, pp, data);
>  	}
>  
>  	/* Update BM driver with number of buffers removed from pool */
> @@ -496,6 +526,9 @@ static int mvpp2_bm_pool_destroy(struct device *dev, struct mvpp2 *priv,
>  	int buf_num;
>  	u32 val;
>  
> +	if (priv->percpu_pools)
> +		page_pool_destroy(priv->page_pool[bm_pool->id]);
> +
>  	buf_num = mvpp2_check_hw_buf_num(priv, bm_pool);
>  	mvpp2_bm_bufs_free(dev, priv, bm_pool, buf_num);
>  
> @@ -548,8 +581,20 @@ static int mvpp2_bm_init(struct device *dev, struct mvpp2 *priv)
>  {
>  	int i, err, poolnum = MVPP2_BM_POOLS_NUM;
>  
> -	if (priv->percpu_pools)
> +	if (priv->percpu_pools) {
>  		poolnum = mvpp2_get_nrxqs(priv) * 2;
> +		for (i = 0; i < poolnum; i++) {
> +			/* the pool in use */
> +			int pn = i / (poolnum / 2);
> +
> +			priv->page_pool[i] =
> +				mvpp2_create_page_pool(dev,
> +						       mvpp2_pools[pn].buf_num,
> +						       mvpp2_pools[pn].pkt_size);
> +			if (IS_ERR(priv->page_pool[i]))
> +				return PTR_ERR(priv->page_pool[i]);
> +		}
> +	}
>  
>  	dev_info(dev, "using %d %s buffers\n", poolnum,
>  		 priv->percpu_pools ? "per-cpu" : "shared");
> @@ -632,23 +677,31 @@ static void mvpp2_rxq_short_pool_set(struct mvpp2_port *port,
>  
>  static void *mvpp2_buf_alloc(struct mvpp2_port *port,
>  			     struct mvpp2_bm_pool *bm_pool,
> +			     struct page_pool *page_pool,
>  			     dma_addr_t *buf_dma_addr,
>  			     phys_addr_t *buf_phys_addr,
>  			     gfp_t gfp_mask)
>  {
>  	dma_addr_t dma_addr;
> +	struct page *page;
>  	void *data;
>  
> -	data = mvpp2_frag_alloc(bm_pool);
> +	data = mvpp2_frag_alloc(bm_pool, page_pool);
>  	if (!data)
>  		return NULL;
>  
> -	dma_addr = dma_map_single(port->dev->dev.parent, data,
> -				  MVPP2_RX_BUF_SIZE(bm_pool->pkt_size),
> -				  DMA_FROM_DEVICE);
> -	if (unlikely(dma_mapping_error(port->dev->dev.parent, dma_addr))) {
> -		mvpp2_frag_free(bm_pool, data);
> -		return NULL;
> +	if (page_pool) {
> +		page = (struct page *)data;
> +		dma_addr = page_pool_get_dma_addr(page);
> +		data = page_to_virt(page);
> +	} else {
> +		dma_addr = dma_map_single(port->dev->dev.parent, data,
> +					  MVPP2_RX_BUF_SIZE(bm_pool->pkt_size),
> +					  DMA_FROM_DEVICE);
> +		if (unlikely(dma_mapping_error(port->dev->dev.parent, dma_addr))) {
> +			mvpp2_frag_free(bm_pool, NULL, data);
> +			return NULL;
> +		}
>  	}
>  	*buf_dma_addr = dma_addr;
>  	*buf_phys_addr = virt_to_phys(data);
> @@ -706,6 +759,7 @@ static int mvpp2_bm_bufs_add(struct mvpp2_port *port,
>  	int i, buf_size, total_size;
>  	dma_addr_t dma_addr;
>  	phys_addr_t phys_addr;
> +	struct page_pool *pp = NULL;
>  	void *buf;
>  
>  	if (port->priv->percpu_pools &&
> @@ -726,8 +780,10 @@ static int mvpp2_bm_bufs_add(struct mvpp2_port *port,
>  		return 0;
>  	}
>  
> +	if (port->priv->percpu_pools)
> +		pp = port->priv->page_pool[bm_pool->id];
>  	for (i = 0; i < buf_num; i++) {
> -		buf = mvpp2_buf_alloc(port, bm_pool, &dma_addr,
> +		buf = mvpp2_buf_alloc(port, bm_pool, pp, &dma_addr,
>  				      &phys_addr, GFP_KERNEL);
>  		if (!buf)
>  			break;
> @@ -2374,10 +2430,11 @@ static int mvpp2_aggr_txq_init(struct platform_device *pdev,
>  /* Create a specified Rx queue */
>  static int mvpp2_rxq_init(struct mvpp2_port *port,
>  			  struct mvpp2_rx_queue *rxq)
> -
>  {
> +	struct mvpp2 *priv = port->priv;
>  	unsigned int thread;
>  	u32 rxq_dma;
> +	int err;
>  
>  	rxq->size = port->rx_ring_size;
>  
> @@ -2415,7 +2472,41 @@ static int mvpp2_rxq_init(struct mvpp2_port *port,
>  	/* Add number of descriptors ready for receiving packets */
>  	mvpp2_rxq_status_update(port, rxq->id, 0, rxq->size);
>  
> +	if (priv->percpu_pools) {
> +		err = xdp_rxq_info_reg(&rxq->xdp_rxq_short, port->dev, rxq->id);
> +		if (err < 0)
> +			goto err_free_dma;
> +
> +		err = xdp_rxq_info_reg(&rxq->xdp_rxq_long, port->dev, rxq->id);
> +		if (err < 0)
> +			goto err_unregister_rxq_short;
> +
> +		/* Every RXQ has a pool for short and another for long packets */
> +		err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq_short,
> +						 MEM_TYPE_PAGE_POOL,
> +						 priv->page_pool[rxq->logic_rxq]);
> +		if (err < 0)
> +			goto err_unregister_rxq_short;
> +
> +		err = xdp_rxq_info_reg_mem_model(&rxq->xdp_rxq_long,
> +						 MEM_TYPE_PAGE_POOL,
> +						 priv->page_pool[rxq->logic_rxq +
> +								 port->nrxqs]);
> +		if (err < 0)
> +			goto err_unregister_rxq_long;

Since mvpp2_rxq_init() will return an error shouldn't we unregister the short 
memory pool as well?

> +	}
> +
>  	return 0;
> +
> +err_unregister_rxq_long:
> +	xdp_rxq_info_unreg(&rxq->xdp_rxq_long);
> +err_unregister_rxq_short:
> +	xdp_rxq_info_unreg(&rxq->xdp_rxq_short);
> +err_free_dma:
> +	dma_free_coherent(port->dev->dev.parent,
> +			  rxq->size * MVPP2_DESC_ALIGNED_SIZE,
> +			  rxq->descs, rxq->descs_dma);
> +	return err;
>  }
>  
>  /* Push packets received by the RXQ to BM pool */
> @@ -2449,6 +2540,12 @@ static void mvpp2_rxq_deinit(struct mvpp2_port *port,
>  {
>  	unsigned int thread;
>  
> +	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq_short))
> +		xdp_rxq_info_unreg(&rxq->xdp_rxq_short);
> +
> +	if (xdp_rxq_info_is_reg(&rxq->xdp_rxq_long))
> +		xdp_rxq_info_unreg(&rxq->xdp_rxq_long);
> +
>  	mvpp2_rxq_drop_pkts(port, rxq);
>  
>  	if (rxq->descs)
> @@ -2890,14 +2987,15 @@ static void mvpp2_rx_csum(struct mvpp2_port *port, u32 status,
>  
>  /* Allocate a new skb and add it to BM pool */
>  static int mvpp2_rx_refill(struct mvpp2_port *port,
> -			   struct mvpp2_bm_pool *bm_pool, int pool)
> +			   struct mvpp2_bm_pool *bm_pool,
> +			   struct page_pool *page_pool, int pool)
>  {
>  	dma_addr_t dma_addr;
>  	phys_addr_t phys_addr;
>  	void *buf;
>  
> -	buf = mvpp2_buf_alloc(port, bm_pool, &dma_addr, &phys_addr,
> -			      GFP_ATOMIC);
> +	buf = mvpp2_buf_alloc(port, bm_pool, page_pool,
> +			      &dma_addr, &phys_addr, GFP_ATOMIC);
>  	if (!buf)
>  		return -ENOMEM;
>  
> @@ -2956,6 +3054,7 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
>  	while (rx_done < rx_todo) {
>  		struct mvpp2_rx_desc *rx_desc = mvpp2_rxq_next_desc_get(rxq);
>  		struct mvpp2_bm_pool *bm_pool;
> +		struct page_pool *pp = NULL;
>  		struct sk_buff *skb;
>  		unsigned int frag_size;
>  		dma_addr_t dma_addr;
> @@ -2989,6 +3088,9 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
>  					DMA_FROM_DEVICE);
>  		prefetch(data);
>  
> +		if (port->priv->percpu_pools)
> +			pp = port->priv->page_pool[pool];
> +
>  		if (bm_pool->frag_size > PAGE_SIZE)
>  			frag_size = 0;
>  		else
> @@ -3000,15 +3102,18 @@ static int mvpp2_rx(struct mvpp2_port *port, struct napi_struct *napi,
>  			goto err_drop_frame;
>  		}
>  
> -		err = mvpp2_rx_refill(port, bm_pool, pool);
> +		err = mvpp2_rx_refill(port, bm_pool, pp, pool);
>  		if (err) {
>  			netdev_err(port->dev, "failed to refill BM pools\n");
>  			goto err_drop_frame;
>  		}
>  
> -		dma_unmap_single_attrs(dev->dev.parent, dma_addr,
> -				       bm_pool->buf_size, DMA_FROM_DEVICE,
> -				       DMA_ATTR_SKIP_CPU_SYNC);
> +		if (pp)
> +			page_pool_release_page(pp, virt_to_page(data));
> +		else
> +			dma_unmap_single_attrs(dev->dev.parent, dma_addr,
> +					       bm_pool->buf_size, DMA_FROM_DEVICE,
> +					       DMA_ATTR_SKIP_CPU_SYNC);
>  
>  		rcvd_pkts++;
>  		rcvd_bytes += rx_bytes;
> -- 
> 2.26.2
> 
