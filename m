Return-Path: <bpf+bounces-64203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8686BB0FA55
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 20:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74BA47B72EB
	for <lists+bpf@lfdr.de>; Wed, 23 Jul 2025 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01E021D001;
	Wed, 23 Jul 2025 18:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GW8cRDYj"
X-Original-To: bpf@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44D272608;
	Wed, 23 Jul 2025 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295719; cv=none; b=onjnI27u+bXJOKQeuz0fp4iLarlRhWFO7vxDZvyVFKLNdxcWy9EKzWq0yCR9o14trJTglol+oovQYYnrjx9UG6kcebm/02lfFS1C/1gSfwFD0/1xFYRf52O9Sk07M9+gecpKb2+fObdwFLCawgljaGRn4kkjSSfj/oKWc7Uvkfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295719; c=relaxed/simple;
	bh=vZV9NnQUdsk7nQrZr0WqwtDxRB8Q9q8blnfuuXLHmgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFaxHF47XVpnsr/oE4Ono7EiBxJ4y8azDRQFTCYCH6HjcciVLANggyZLvv1ulwDU1tAKrCuABsJrG/78WLral4OeKFB8fByQzrt5wtZna6VbVROARVq0weq8RjBp6nqpF/SSOvNrRTUm48HZYgXc1ASSyshVFYHoohc+KQEfazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GW8cRDYj; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 2CC61201656A; Wed, 23 Jul 2025 11:35:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2CC61201656A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1753295717;
	bh=mxx6C4a5tB+QBM3eq0v55PRLt+bJxX+8iqOebyvxPjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GW8cRDYjLirLbD5VzxIykuO7pmlBInPDZwgZfNGNXwd77W3C+A0qHHVgyL4r0Y3w1
	 GwhC00RYHuavJjkdvHBDsN6uVkf7yigW5j2ld2usVi64tw5IPpSzmbIQKwbBOxO2/c
	 x7AmS8Xvs8nNcBAq3CZ4DG1ELjL+0YIEbEJXvQas=
Date: Wed, 23 Jul 2025 11:35:17 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
Cc: kuba@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, sdf@fomichev.me, lorenzo@kernel.org,
	michal.kubiak@intel.com, ernis@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
	rosenp@gmail.com, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
	bpf@vger.kernel.org, dipayanroy@linux.microsoft.com,
	ssengar@linux.microsoft.com
Subject: Re: [PATCH] net: mana: Use page pool fragments for RX buffers
 instead of full pages to improve memory efficiency and throughput.
Message-ID: <20250723183517.GB25631@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250721101417.GA18873@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250722111929.GE2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722111929.GE2459@horms.kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

Hi Simon,

Thank you for the review, I am sending
out v2 to address these comments.


Regards
Dipayaan Roy


On Tue, Jul 22, 2025 at 12:19:29PM +0100, Simon Horman wrote:
> On Mon, Jul 21, 2025 at 03:14:17AM -0700, Dipayaan Roy wrote:
> > This patch enhances RX buffer handling in the mana driver by allocating
> > pages from a page pool and slicing them into MTU-sized fragments, rather
> > than dedicating a full page per packet. This approach is especially
> > beneficial on systems with 64KB page sizes.
> > 
> > Key improvements:
> > 
> > - Proper integration of page pool for RX buffer allocations.
> > - MTU-sized buffer slicing to improve memory utilization.
> > - Reduce overall per Rx queue memory footprint.
> > - Automatic fallback to full-page buffers when:
> >    * Jumbo frames are enabled (MTU > PAGE_SIZE / 2).
> >    * The XDP path is active, to avoid complexities with fragment reuse.
> > - Removal of redundant pre-allocated RX buffers used in scenarios like MTU
> >   changes, ensuring consistency in RX buffer allocation.
> > 
> > Testing on VMs with 64KB pages shows around 200% throughput improvement.
> > Memory efficiency is significantly improved due to reduced wastage in page
> > allocations. Example: We are now able to fit 35 Rx buffers in a single 64KB
> > page for MTU size of 1500, instead of 1 Rx buffer per page previously.
> > 
> > Tested:
> > 
> > - iperf3, iperf2, and nttcp benchmarks.
> > - Jumbo frames with MTU 9000.
> > - Native XDP programs (XDP_PASS, XDP_DROP, XDP_TX, XDP_REDIRECT) for
> >   testing the driver???s XDP path.
> > - Page leak detection (kmemleak).
> > - Driver load/unload, reboot, and stress scenarios.
> > 
> > Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> 
> Hi,
> 
> Some minor feedback from my side.
> 
> > diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> 
> ...
> 
> > -int mana_pre_alloc_rxbufs(struct mana_port_context *mpc, int new_mtu, int num_queues)
> > -{
> > -	struct device *dev;
> > -	struct page *page;
> > -	dma_addr_t da;
> > -	int num_rxb;
> > -	void *va;
> > -	int i;
> > -
> > -	mana_get_rxbuf_cfg(new_mtu, &mpc->rxbpre_datasize,
> > -			   &mpc->rxbpre_alloc_size, &mpc->rxbpre_headroom);
> > -
> > -	dev = mpc->ac->gdma_dev->gdma_context->dev;
> > -
> > -	num_rxb = num_queues * mpc->rx_queue_size;
> > -
> > -	WARN(mpc->rxbufs_pre, "mana rxbufs_pre exists\n");
> > -	mpc->rxbufs_pre = kmalloc_array(num_rxb, sizeof(void *), GFP_KERNEL);
> > -	if (!mpc->rxbufs_pre)
> > -		goto error;
> >  
> > -	mpc->das_pre = kmalloc_array(num_rxb, sizeof(dma_addr_t), GFP_KERNEL);
> > -	if (!mpc->das_pre)
> > -		goto error;
> > -
> > -	mpc->rxbpre_total = 0;
> > -
> > -	for (i = 0; i < num_rxb; i++) {
> > -		page = dev_alloc_pages(get_order(mpc->rxbpre_alloc_size));
> > -		if (!page)
> > -			goto error;
> > -
> > -		va = page_to_virt(page);
> > -
> > -		da = dma_map_single(dev, va + mpc->rxbpre_headroom,
> > -				    mpc->rxbpre_datasize, DMA_FROM_DEVICE);
> > -		if (dma_mapping_error(dev, da)) {
> > -			put_page(page);
> > -			goto error;
> > +	/* For xdp and jumbo frames make sure only one packet fits per page */
> > +	if (((mtu + MANA_RXBUF_PAD) > PAGE_SIZE / 2) || rcu_access_pointer(apc->bpf_prog)) {
> 
> The line above seems to have unnecessary parentheses.
> And should be line wrapped to be 80 columns wide or less,
> as is still preferred by Networking code.
> The latter condition is flagged by checkpatch.pl --max-line-length=80
> 
> 	if (mtu + MANA_RXBUF_PAD > PAGE_SIZE / 2 ||
> 	    rcu_access_pointer(apc->bpf_prog)) {
> 
> (The above is completely untested)
> 
> Also, I am a little confused by the use of rcu_access_pointer()
> above and below, as bpf_prog does not seem to be managed by RCU.
> 
> Flagged by Sparse.
> 
> > +		if (rcu_access_pointer(apc->bpf_prog)) {
> > +			*headroom = XDP_PACKET_HEADROOM;
> > +			*alloc_size = PAGE_SIZE;
> > +		} else {
> > +			*headroom = 0; /* no support for XDP */
> > +			*alloc_size = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
> >  		}
> >  
> > -		mpc->rxbufs_pre[i] = va;
> > -		mpc->das_pre[i] = da;
> > -		mpc->rxbpre_total = i + 1;
> > +		*frag_count = 1;
> > +		return;
> >  	}
> >  
> > -	return 0;
> > +	/* Standard MTU case - optimize for multiple packets per page */
> > +	*headroom = 0;
> >  
> > -error:
> > -	netdev_err(mpc->ndev, "Failed to pre-allocate RX buffers for %d queues\n", num_queues);
> > -	mana_pre_dealloc_rxbufs(mpc);
> > -	return -ENOMEM;
> > +	/* Calculate base buffer size needed */
> > +	u32 len = SKB_DATA_ALIGN(mtu + MANA_RXBUF_PAD + *headroom);
> > +	u32 buf_size = ALIGN(len, MANA_RX_FRAG_ALIGNMENT);
> > +
> > +	/* Calculate how many packets can fit in a page */
> > +	*frag_count = PAGE_SIZE / buf_size;
> > +	*alloc_size = buf_size;
> >  }
> 
> ...
> 
> > -static void *mana_get_rxfrag(struct mana_rxq *rxq, struct device *dev,
> > -			     dma_addr_t *da, bool *from_pool)
> > +static void *mana_get_rxfrag(struct mana_rxq *rxq,
> > +			     struct device *dev, dma_addr_t *da, bool *from_pool)
> >  {
> >  	struct page *page;
> > +	u32 offset;
> >  	void *va;
> > -
> >  	*from_pool = false;
> >  
> > -	/* Reuse XDP dropped page if available */
> > -	if (rxq->xdp_save_va) {
> > -		va = rxq->xdp_save_va;
> > -		rxq->xdp_save_va = NULL;
> > -	} else {
> > -		page = page_pool_dev_alloc_pages(rxq->page_pool);
> > -		if (!page)
> > +	/* Don't use fragments for jumbo frames or XDP (i.e when fragment = 1 per page) */
> > +	if (rxq->frag_count == 1) {
> > +		/* Reuse XDP dropped page if available */
> > +		if (rxq->xdp_save_va) {
> > +			va = rxq->xdp_save_va;
> > +			rxq->xdp_save_va = NULL;
> > +		} else {
> > +			page = page_pool_dev_alloc_pages(rxq->page_pool);
> > +			if (!page)
> > +				return NULL;
> > +
> > +			*from_pool = true;
> > +			va = page_to_virt(page);
> > +		}
> > +
> > +		*da = dma_map_single(dev, va + rxq->headroom, rxq->datasize,
> > +				     DMA_FROM_DEVICE);
> > +		if (dma_mapping_error(dev, *da)) {
> > +			if (*from_pool)
> > +				page_pool_put_full_page(rxq->page_pool, page, false);
> > +			else
> > +				put_page(virt_to_head_page(va));
> 
> The put logic above seems to appear in this patch
> more than once. IMHO a helper would be nice.
> 
> > +
> >  			return NULL;
> > +		}
> >  
> > -		*from_pool = true;
> > -		va = page_to_virt(page);
> > +		return va;
> >  	}
> 
> ...
> 
> -- 
> pw-bot: changes-requested

