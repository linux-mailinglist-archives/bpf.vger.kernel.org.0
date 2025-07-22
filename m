Return-Path: <bpf+bounces-64028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B9B0D808
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3931891559
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 11:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959312E1C4E;
	Tue, 22 Jul 2025 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0XOO0+r"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CDB7080C;
	Tue, 22 Jul 2025 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753183177; cv=none; b=t4JmlLa+8qOxa54BGHRiNhsh98Us1CXMLwrRBdjxvRgMXGZ+OJIpxDvvmHXyu7tv2FWuuxaufRBhUP0Hj5XlCZccXoLxtLbxos6UvJ1L7WMao+cmq7/AlITCPGvoF2LEjNrlz9CyELzBeQoeR6D3dnPYR+zv77BQ1NXkcne9LUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753183177; c=relaxed/simple;
	bh=2miBTodTuvA5czJ/0Egx0TFlpE3uye94c6AudsbNSUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6Kbp1wkkEBT/2skZ75PQ64BUD7MiFwk61y/IICfiaoa6Edi32N2pzGRsXKQbi9GE1L2stagofWJBnBE+oa8Y2CdGd47vvXnNKsYWdnd170nx05UFyO2BihBHJeuK3XqIpn+yqe/HIKhoJ+E1RkD4Z795xMIgTq5fb0la/tr7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0XOO0+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB809C4CEEB;
	Tue, 22 Jul 2025 11:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753183176;
	bh=2miBTodTuvA5czJ/0Egx0TFlpE3uye94c6AudsbNSUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d0XOO0+rGGEGiV1JHMYVEKkhnGwyy+40jnkGGVqu+hvsU2Rn6TDKHuul1lkaCgzf2
	 FFmbSaroynvwk+OmXO7zYNNUaqyxVcaZp2ydO+SWJK+gnCPMilwGAg8C01f0zTckY3
	 6+F9JAbllIPsNZausRN2zZgxXjA2xDwTFHp5vzDrmTSjsARi9StRmLnA+o6x9zuZ52
	 JohdYqwMD3IM5oyrzmYfMT8PiQo2vwzSSOSFO1yB4DU5Yl2iGIi4vhqTnxFXU82NdI
	 bwpL+Ca4sYfzROXXqDY19eA918P3vIQvTZBxGO9ph1lAnXSYyJ5umkLy1s9Q9pJWH4
	 mNWZsNdKDb2xg==
Date: Tue, 22 Jul 2025 12:19:29 +0100
From: Simon Horman <horms@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kuba@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	sdf@fomichev.me, lorenzo@kernel.org, michal.kubiak@intel.com,
	ernis@linux.microsoft.com, shradhagupta@linux.microsoft.com,
	shirazsaleem@microsoft.com, rosenp@gmail.com,
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	ssengar@linux.microsoft.com
Subject: Re: [PATCH] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency and throughput.
Message-ID: <20250722111929.GE2459@horms.kernel.org>
References: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Jul 21, 2025 at 03:14:17AM -0700, Dipayaan Roy wrote:
> This patch enhances RX buffer handling in the mana driver by allocating
> pages from a page pool and slicing them into MTU-sized fragments, rather
> than dedicating a full page per packet. This approach is especially
> beneficial on systems with 64KB page sizes.
> 
> Key improvements:
> 
> - Proper integration of page pool for RX buffer allocations.
> - MTU-sized buffer slicing to improve memory utilization.
> - Reduce overall per Rx queue memory footprint.
> - Automatic fallback to full-page buffers when:
>    * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
>    * The XDP path is active, to avoid complexities with fragment reuse.
> - Removal of redundant pre-allocated RX buffers used in scenarios like MTU
>   changes, ensuring consistency in RX buffer allocation.
> 
> Testing on VMs with 64KB pages shows around 200% throughput improvement.
> Memory efficiency is significantly improved due to reduced wastage in page
> allocations. Example: We are now able to fit 35 Rx buffers in a single 64KB
> page for MTU size of 1500, instead of 1 Rx buffer per page previously.
> 
> Tested:
> 
> - iperf3, iperf2, and nttcp benchmarks.
> - Jumbo frames with MTU 9000.
> - Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
>   testing the driver’s XDP path.
> - Page leak detection (kmemleak).
> - Driver load/unload, reboot, and stress scenarios.
> 
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>

Hi,

Some minor feedback from my side.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c

...

> -int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_queues)
> -{
> -	struct device *dev;
> -	struct page *page;
> -	dma_addr_t da;
> -	int num_rxb;
> -	void *va;
> -	int i;
> -
> -	mana_get_rxbuf_cfg(new_mtu, &mpc->rxbpre_datasize,
> -			   &mpc->rxbpre_alloc_size, &mpc->rxbpre_headroom);
> -
> -	dev = mpc->ac->gdma_dev->gdma_context->dev;
> -
> -	num_rxb = num_queues * mpc->rx_queue_size;
> -
> -	WARN(mpc->rxbufs_pre, "mana rxbufs_pre exists\n");
> -	mpc->rxbufs_pre = kmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
> -	if (!mpc->rxbufs_pre)
> -		goto error;
>  
> -	mpc->das_pre = kmalloc_array(num_rxb, sizeof(dma_addr_t), GFP_KERNEL);
> -	if (!mpc->das_pre)
> -		goto error;
> -
> -	mpc->rxbpre_total = 0;
> -
> -	for (i = 0; i < num_rxb; i++) {
> -		page = dev_alloc_pages(get_order(mpc->rxbpre_alloc_size));
> -		if (!page)
> -			goto error;
> -
> -		va = page_to_virt(page);
> -
> -		da = dma_map_single(dev, va + mpc->rxbpre_headroom,
> -				    mpc->rxbpre_datasize, DMA_FROM_DEVICE);
> -		if (dma_mapping_error(dev, da)) {
> -			put_page(page);
> -			goto error;
> +	/* For xdp and jumbo frames make sure only one packet fits per page */
> +	if (((mtu + MANA_RXBUF_PAD) > PAGE_SIZE / 2) || rcu_access_pointer(apc->bpf_prog)) {

The line above seems to have unnecessary parentheses.
And should be line wrapped to be 80 columns wide or less,
as is still preferred by Networking code.
The latter condition is flagged by checkpatch.pl --max-line-length=80

	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 ||
	    rcu_access_pointer(apc->bpf_prog)) {

(The above is completely untested)

Also, I am a little confused by the use of rcu_access_pointer()
above and below, as bpf_prog does not seem to be managed by RCU.

Flagged by Sparse.

> +		if (rcu_access_pointer(apc->bpf_prog)) {
> +			*headroom = XDP_PACKET_HEADROOM;
> +			*alloc_size = PAGE_SIZE;
> +		} else {
> +			*headroom = 0; /* no support for XDP */
> +			*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
>  		}
>  
> -		mpc->rxbufs_pre[i] = va;
> -		mpc->das_pre[i] = da;
> -		mpc->rxbpre_total = i + 1;
> +		*frag_count = 1;
> +		return;
>  	}
>  
> -	return 0;
> +	/* Standard MTU case - optimize for multiple packets per page */
> +	*headroom = 0;
>  
> -error:
> -	netdev_err(mpc->ndev, "Failed to pre-allocate RX buffers for %d queues\n", num_queues);
> -	mana_pre_dealloc_rxbufs(mpc);
> -	return -ENOMEM;
> +	/* Calculate base buffer size needed */
> +	u32 len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
> +	u32 buf_size = ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
> +
> +	/* Calculate how many packets can fit in a page */
> +	*frag_count = PAGE_SIZE / buf_size;
> +	*alloc_size = buf_size;
>  }

...

> -static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
> -			     dma_addr_t *da, bool *from_pool)
> +static void *mana_get_rxfrag(struct mana_rxq *rxq,
> +			     struct device *dev, dma_addr_t *da, bool *from_pool)
>  {
>  	struct page *page;
> +	u32 offset;
>  	void *va;
> -
>  	*from_pool = false;
>  
> -	/* Reuse XDP dropped page if available */
> -	if (rxq->xdp_save_va) {
> -		va = rxq->xdp_save_va;
> -		rxq->xdp_save_va = NULL;
> -	} else {
> -		page = page_pool_dev_alloc_pages(rxq->page_pool);
> -		if (!page)
> +	/* Don't use fragments for jumbo frames or XDP (i.e when fragment = 1 per page) */
> +	if (rxq->frag_count == 1) {
> +		/* Reuse XDP dropped page if available */
> +		if (rxq->xdp_save_va) {
> +			va = rxq->xdp_save_va;
> +			rxq->xdp_save_va = NULL;
> +		} else {
> +			page = page_pool_dev_alloc_pages(rxq->page_pool);
> +			if (!page)
> +				return NULL;
> +
> +			*from_pool = true;
> +			va = page_to_virt(page);
> +		}
> +
> +		*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
> +				     DMA_FROM_DEVICE);
> +		if (dma_mapping_error(dev, *da)) {
> +			if (*from_pool)
> +				page_pool_put_full_page(rxq->page_pool, page, false);
> +			else
> +				put_page(virt_to_head_page(va));

The put logic above seems to appear in this patch
more than once. IMHO a helper would be nice.

> +
>  			return NULL;
> +		}
>  
> -		*from_pool = true;
> -		va = page_to_virt(page);
> +		return va;
>  	}

...

-- 
pw-bot: changes-requested

