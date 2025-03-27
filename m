Return-Path: <bpf+bounces-54781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1409A729C1
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 06:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47551740E8
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 05:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548B31BEF97;
	Thu, 27 Mar 2025 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KfJ4C1Vu"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5432618EB0;
	Thu, 27 Mar 2025 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743051703; cv=none; b=Fg6ibIlH+Q4maCym2xlHYwDpW0cGT9nTPsmHvw0UiV8EKKCF6bdprHDEaS/mxI++YYTsTABVqpKAe5Ce8V0Lr1sb0jvBqN8TesMaO0LpcEhyIM+dcsBLpS2hxiBpkUMc4Vc+7f/bIfK9n7hq83QjXvXsu20U5/QFr/fNMMHBNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743051703; c=relaxed/simple;
	bh=xYu6biCgRAvV54XDPXKBT2zX4ig7grodlwKFQMpKzuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvSsM3neFg1MDuU0ffby5biQm6XoivaOXE9oR5WZ30iiIn7CAJa+c2I9LkKPPI5BpJTsVaOn0hUY9aHzPK8a5DkElsP5s2jaYdaJU+41o+vzbBUv8KfRzTdE8QDIWbw/gnhUD3WJ6TMjJdgzD2pKrPOCIqRdKvw6KFeTC9OJBgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KfJ4C1Vu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id B3A5C211143F; Wed, 26 Mar 2025 22:01:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3A5C211143F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743051700;
	bh=TRzzvHz66Y/kUUMQcpHVIbr9k8vTxUvWBzzSkkTuLw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfJ4C1Vum9CP9IxbsicYpgcJT+JGr4ohXDEECm+2Lfiu2kJmGX9YXI/FBKq3JAVAp
	 SBeY9fq7GC+OML/ZFYT1Yun5DEK1yZyZsZpD6RkHs/+xaPNHwzk9glQdFMLKLE3BRG
	 cHyCaCLoKhemP//Z9NZpwGOVoLj82nyInV84LJHA=
Date: Wed, 26 Mar 2025 22:01:40 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, stephen@networkplumber.org, kys@microsoft.com,
	paulros@microsoft.com, olaf@aepfle.de, vkuznets@redhat.com,
	davem@davemloft.net, wei.liu@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, ssengar@linux.microsoft.com,
	linux-rdma@vger.kernel.org, daniel@iogearbox.net,
	john.fastabend@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
	hawk@kernel.org, tglx@linutronix.de, jesse.brandeburg@intel.com,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net,v2] net: mana: Switch to page pool for jumbo frames
Message-ID: <20250327050140.GA13258@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1742920357-27263-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1742920357-27263-1-git-send-email-haiyangz@microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Mar 25, 2025 at 09:32:37AM -0700, Haiyang Zhang wrote:
> Frag allocators, such as netdev_alloc_frag(), were not designed to
> work for fragsz > PAGE_SIZE.
> 
> So, switch to page pool for jumbo frames instead of using page frag
> allocators. This driver is using page pool for smaller MTUs already.
> 
> Cc: stable@vger.kernel.org
> Fixes: 80f6215b450e ("net: mana: Add support for jumbo frame")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
> v2: updated the commit msg as suggested by Jakub Kicinski.
> 
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 46 ++++---------------
>  1 file changed, 9 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 9a8171f099b6..4d41f4cca3d8 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -661,30 +661,16 @@ int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_qu
>  	mpc->rxbpre_total = 0;
>  
>  	for (i = 0; i < num_rxb; i++) {
> -		if (mpc->rxbpre_alloc_size > PAGE_SIZE) {
> -			va = netdev_alloc_frag(mpc->rxbpre_alloc_size);
> -			if (!va)
> -				goto error;
> -
> -			page = virt_to_head_page(va);
> -			/* Check if the frag falls back to single page */
> -			if (compound_order(page) <
> -			    get_order(mpc->rxbpre_alloc_size)) {
> -				put_page(page);
> -				goto error;
> -			}
> -		} else {
> -			page = dev_alloc_page();
> -			if (!page)
> -				goto error;
> +		page = dev_alloc_pages(get_order(mpc->rxbpre_alloc_size));
> +		if (!page)
> +			goto error;
>  
> -			va = page_to_virt(page);
> -		}
> +		va = page_to_virt(page);
>  
>  		da = dma_map_single(dev, va + mpc->rxbpre_headroom,
>  				    mpc->rxbpre_datasize, DMA_FROM_DEVICE);
>  		if (dma_mapping_error(dev, da)) {
> -			put_page(virt_to_head_page(va));
> +			put_page(page);
>  			goto error;
>  		}
>  
> @@ -1672,7 +1658,7 @@ static void mana_rx_skb(void *buf_va, bool from_pool,
>  }
>  
>  static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
> -			     dma_addr_t *da, bool *from_pool, bool is_napi)
> +			     dma_addr_t *da, bool *from_pool)
>  {
>  	struct page *page;
>  	void *va;
> @@ -1683,21 +1669,6 @@ static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
>  	if (rxq->xdp_save_va) {
>  		va = rxq->xdp_save_va;
>  		rxq->xdp_save_va = NULL;
> -	} else if (rxq->alloc_size > PAGE_SIZE) {
> -		if (is_napi)
> -			va = napi_alloc_frag(rxq->alloc_size);
> -		else
> -			va = netdev_alloc_frag(rxq->alloc_size);
> -
> -		if (!va)
> -			return NULL;
> -
> -		page = virt_to_head_page(va);
> -		/* Check if the frag falls back to single page */
> -		if (compound_order(page) < get_order(rxq->alloc_size)) {
> -			put_page(page);
> -			return NULL;
> -		}
>  	} else {
>  		page = page_pool_dev_alloc_pages(rxq->page_pool);
>  		if (!page)
> @@ -1730,7 +1701,7 @@ static void mana_refill_rx_oob(struct device *dev, struct mana_rxq *rxq,
>  	dma_addr_t da;
>  	void *va;
>  
> -	va = mana_get_rxfrag(rxq, dev, &da, &from_pool, true);
> +	va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
>  	if (!va)
>  		return;
>  
> @@ -2172,7 +2143,7 @@ static int mana_fill_rx_oob(struct mana_recv_buf_oob *rx_oob, u32 mem_key,
>  	if (mpc->rxbufs_pre)
>  		va = mana_get_rxbuf_pre(rxq, &da);
>  	else
> -		va = mana_get_rxfrag(rxq, dev, &da, &from_pool, false);
> +		va = mana_get_rxfrag(rxq, dev, &da, &from_pool);
>  
>  	if (!va)
>  		return -ENOMEM;
> @@ -2258,6 +2229,7 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
>  	pprm.nid = gc->numa_node;
>  	pprm.napi = &rxq->rx_cq.napi;
>  	pprm.netdev = rxq->ndev;
> +	pprm.order = get_order(rxq->alloc_size);
>  
>  	rxq->page_pool = page_pool_create(&pprm);
>  
> -- 
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> 2.34.1

