Return-Path: <bpf+bounces-10706-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5567AC6AA
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 07:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 09E681C20866
	for <lists+bpf@lfdr.de>; Sun, 24 Sep 2023 05:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC914817;
	Sun, 24 Sep 2023 05:22:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A61653;
	Sun, 24 Sep 2023 05:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA15C433C7;
	Sun, 24 Sep 2023 05:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1695532975;
	bh=o+1OTq6SjGHqCQXXi5yLfC1e7305nlk4Jy43+92MXXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKgJmeZi8WPDSCzXV8Vw+lQVhZRF4RoczeoBDKx6F1VvOmgkyYgRF3lIvXu9cl6DE
	 /0xtzNnRgAjz6a/G/2nyaKtmYVrS2EK0zC1OwTMl/XnBYyNa7JG8n1ibHOqMruj1Zo
	 NmE/agu8GoZjWT+i3Xa1GGG5vEkEeDkWDQf1pKxA=
Date: Sun, 24 Sep 2023 07:22:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
	olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
	wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
	ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
	ast@kernel.org, sharmaajay@microsoft.com, hawk@kernel.org,
	tglx@linutronix.de, shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net, 3/3] net: mana: Fix oversized sge0 for GSO packets
Message-ID: <2023092439-crescent-sloppy-c212@gregkh>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-4-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695519107-24139-4-git-send-email-haiyangz@microsoft.com>

On Sat, Sep 23, 2023 at 06:31:47PM -0700, Haiyang Zhang wrote:
> Handle the case when GSO SKB linear length is too large.
> 
> MANA NIC requires GSO packets to put only the header part to SGE0,
> otherwise the TX queue may stop at the HW level.
> 
> So, use 2 SGEs for the skb linear part which contains more than the
> packet header.
> 
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 186 ++++++++++++------
>  include/net/mana/mana.h                       |   5 +-
>  2 files changed, 134 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 86e724c3eb89..0a3879163b56 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -91,63 +91,136 @@ static unsigned int mana_checksum_info(struct sk_buff *skb)
>  	return 0;
>  }
>  
> +static inline void mana_add_sge(struct mana_tx_package *tp,
> +				struct mana_skb_head *ash, int sg_i,
> +				dma_addr_t da, int sge_len, u32 gpa_mkey)
> +{
> +	ash->dma_handle[sg_i] = da;
> +	ash->size[sg_i] = sge_len;
> +
> +	tp->wqe_req.sgl[sg_i].address = da;
> +	tp->wqe_req.sgl[sg_i].mem_key = gpa_mkey;
> +	tp->wqe_req.sgl[sg_i].size = sge_len;
> +}
> +
>  static int mana_map_skb(struct sk_buff *skb, struct mana_port_context *apc,
> -			struct mana_tx_package *tp)
> +			struct mana_tx_package *tp, int gso_hs)
>  {
>  	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
> +	int hsg = 1; /* num of SGEs of linear part */
>  	struct gdma_dev *gd = apc->ac->gdma_dev;
> +	int skb_hlen = skb_headlen(skb);
> +	int sge0_len, sge1_len = 0;
>  	struct gdma_context *gc;
>  	struct device *dev;
>  	skb_frag_t *frag;
>  	dma_addr_t da;
> +	int sg_i;
>  	int i;
>  
>  	gc = gd->gdma_context;
>  	dev = gc->dev;
> -	da = dma_map_single(dev, skb->data, skb_headlen(skb), DMA_TO_DEVICE);
>  
> +	if (gso_hs && gso_hs < skb_hlen) {
> +		sge0_len = gso_hs;
> +		sge1_len = skb_hlen - gso_hs;
> +	} else {
> +		sge0_len = skb_hlen;
> +	}
> +
> +	da = dma_map_single(dev, skb->data, sge0_len, DMA_TO_DEVICE);
>  	if (dma_mapping_error(dev, da))
>  		return -ENOMEM;
>  
> -	ash->dma_handle[0] = da;
> -	ash->size[0] = skb_headlen(skb);
> +	mana_add_sge(tp, ash, 0, da, sge0_len, gd->gpa_mkey);
>  
> -	tp->wqe_req.sgl[0].address = ash->dma_handle[0];
> -	tp->wqe_req.sgl[0].mem_key = gd->gpa_mkey;
> -	tp->wqe_req.sgl[0].size = ash->size[0];
> +	if (sge1_len) {
> +		sg_i = 1;
> +		da = dma_map_single(dev, skb->data + sge0_len, sge1_len,
> +				    DMA_TO_DEVICE);
> +		if (dma_mapping_error(dev, da))
> +			goto frag_err;
> +
> +		mana_add_sge(tp, ash, sg_i, da, sge1_len, gd->gpa_mkey);
> +		hsg = 2;
> +	}
>  
>  	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +		sg_i = hsg + i;
> +
>  		frag = &skb_shinfo(skb)->frags[i];
>  		da = skb_frag_dma_map(dev, frag, 0, skb_frag_size(frag),
>  				      DMA_TO_DEVICE);
> -
>  		if (dma_mapping_error(dev, da))
>  			goto frag_err;
>  
> -		ash->dma_handle[i + 1] = da;
> -		ash->size[i + 1] = skb_frag_size(frag);
> -
> -		tp->wqe_req.sgl[i + 1].address = ash->dma_handle[i + 1];
> -		tp->wqe_req.sgl[i + 1].mem_key = gd->gpa_mkey;
> -		tp->wqe_req.sgl[i + 1].size = ash->size[i + 1];
> +		mana_add_sge(tp, ash, sg_i, da, skb_frag_size(frag),
> +			     gd->gpa_mkey);
>  	}
>  
>  	return 0;
>  
>  frag_err:
> -	for (i = i - 1; i >= 0; i--)
> -		dma_unmap_page(dev, ash->dma_handle[i + 1], ash->size[i + 1],
> +	for (i = sg_i - 1; i >= hsg; i--)
> +		dma_unmap_page(dev, ash->dma_handle[i], ash->size[i],
>  			       DMA_TO_DEVICE);
>  
> -	dma_unmap_single(dev, ash->dma_handle[0], ash->size[0], DMA_TO_DEVICE);
> +	for (i = hsg - 1; i >= 0; i--)
> +		dma_unmap_single(dev, ash->dma_handle[i], ash->size[i],
> +				 DMA_TO_DEVICE);
>  
>  	return -ENOMEM;
>  }
>  
> +/* Handle the case when GSO SKB linear length is too large.
> + * MANA NIC requires GSO packets to put only the packet header to SGE0.
> + * So, we need 2 SGEs for the skb linear part which contains more than the
> + * header.
> + */
> +static inline int mana_fix_skb_head(struct net_device *ndev,
> +				    struct sk_buff *skb, int gso_hs,
> +				    u32 *num_sge)
> +{
> +	int skb_hlen = skb_headlen(skb);
> +
> +	if (gso_hs < skb_hlen) {
> +		*num_sge = 2 + skb_shinfo(skb)->nr_frags;
> +	} else if (gso_hs > skb_hlen) {
> +		if (net_ratelimit())
> +			netdev_err(ndev,
> +				   "TX nonlinear head: hs:%d, skb_hlen:%d\n",
> +				   gso_hs, skb_hlen);
> +
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Get the GSO packet's header size */
> +static inline int mana_get_gso_hs(struct sk_buff *skb)
> +{
> +	int gso_hs;
> +
> +	if (skb->encapsulation) {
> +		gso_hs = skb_inner_tcp_all_headers(skb);
> +	} else {
> +		if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> +			gso_hs = skb_transport_offset(skb) +
> +				 sizeof(struct udphdr);
> +		} else {
> +			gso_hs = skb_tcp_all_headers(skb);
> +		}
> +	}
> +
> +	return gso_hs;
> +}
> +
>  netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	enum mana_tx_pkt_format pkt_fmt = MANA_SHORT_PKT_FMT;
>  	struct mana_port_context *apc = netdev_priv(ndev);
> +	int gso_hs = 0; /* zero for non-GSO pkts */
>  	u16 txq_idx = skb_get_queue_mapping(skb);
>  	struct gdma_dev *gd = apc->ac->gdma_dev;
>  	bool ipv4 = false, ipv6 = false;
> @@ -159,7 +232,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	struct mana_txq *txq;
>  	struct mana_cq *cq;
>  	int err, len;
> -	u16 ihs;
>  
>  	if (unlikely(!apc->port_is_up))
>  		goto tx_drop;
> @@ -209,19 +281,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	pkg.wqe_req.client_data_unit = 0;
>  
>  	pkg.wqe_req.num_sge = 1 + skb_shinfo(skb)->nr_frags;
> -	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
> -
> -	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
> -		pkg.wqe_req.sgl = pkg.sgl_array;
> -	} else {
> -		pkg.sgl_ptr = kmalloc_array(pkg.wqe_req.num_sge,
> -					    sizeof(struct gdma_sge),
> -					    GFP_ATOMIC);
> -		if (!pkg.sgl_ptr)
> -			goto tx_drop_count;
> -
> -		pkg.wqe_req.sgl = pkg.sgl_ptr;
> -	}
>  
>  	if (skb->protocol == htons(ETH_P_IP))
>  		ipv4 = true;
> @@ -229,6 +288,23 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  		ipv6 = true;
>  
>  	if (skb_is_gso(skb)) {
> +		gso_hs = mana_get_gso_hs(skb);
> +
> +		if (mana_fix_skb_head(ndev, skb, gso_hs, &pkg.wqe_req.num_sge))
> +			goto tx_drop_count;
> +
> +		if (skb->encapsulation) {
> +			u64_stats_update_begin(&tx_stats->syncp);
> +			tx_stats->tso_inner_packets++;
> +			tx_stats->tso_inner_bytes += skb->len - gso_hs;
> +			u64_stats_update_end(&tx_stats->syncp);
> +		} else {
> +			u64_stats_update_begin(&tx_stats->syncp);
> +			tx_stats->tso_packets++;
> +			tx_stats->tso_bytes += skb->len - gso_hs;
> +			u64_stats_update_end(&tx_stats->syncp);
> +		}
> +
>  		pkg.tx_oob.s_oob.is_outer_ipv4 = ipv4;
>  		pkg.tx_oob.s_oob.is_outer_ipv6 = ipv6;
>  
> @@ -252,26 +328,6 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  						 &ipv6_hdr(skb)->daddr, 0,
>  						 IPPROTO_TCP, 0);
>  		}
> -
> -		if (skb->encapsulation) {
> -			ihs = skb_inner_tcp_all_headers(skb);
> -			u64_stats_update_begin(&tx_stats->syncp);
> -			tx_stats->tso_inner_packets++;
> -			tx_stats->tso_inner_bytes += skb->len - ihs;
> -			u64_stats_update_end(&tx_stats->syncp);
> -		} else {
> -			if (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) {
> -				ihs = skb_transport_offset(skb) + sizeof(struct udphdr);
> -			} else {
> -				ihs = skb_tcp_all_headers(skb);
> -			}
> -
> -			u64_stats_update_begin(&tx_stats->syncp);
> -			tx_stats->tso_packets++;
> -			tx_stats->tso_bytes += skb->len - ihs;
> -			u64_stats_update_end(&tx_stats->syncp);
> -		}
> -
>  	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
>  		csum_type = mana_checksum_info(skb);
>  
> @@ -294,11 +350,25 @@ netdev_tx_t mana_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  		} else {
>  			/* Can't do offload of this type of checksum */
>  			if (skb_checksum_help(skb))
> -				goto free_sgl_ptr;
> +				goto tx_drop_count;
>  		}
>  	}
>  
> -	if (mana_map_skb(skb, apc, &pkg)) {
> +	WARN_ON_ONCE(pkg.wqe_req.num_sge > MAX_TX_WQE_SGL_ENTRIES);
> +
> +	if (pkg.wqe_req.num_sge <= ARRAY_SIZE(pkg.sgl_array)) {
> +		pkg.wqe_req.sgl = pkg.sgl_array;
> +	} else {
> +		pkg.sgl_ptr = kmalloc_array(pkg.wqe_req.num_sge,
> +					    sizeof(struct gdma_sge),
> +					    GFP_ATOMIC);
> +		if (!pkg.sgl_ptr)
> +			goto tx_drop_count;
> +
> +		pkg.wqe_req.sgl = pkg.sgl_ptr;
> +	}
> +
> +	if (mana_map_skb(skb, apc, &pkg, gso_hs)) {
>  		u64_stats_update_begin(&tx_stats->syncp);
>  		tx_stats->mana_map_err++;
>  		u64_stats_update_end(&tx_stats->syncp);
> @@ -1255,12 +1325,18 @@ static void mana_unmap_skb(struct sk_buff *skb, struct mana_port_context *apc)
>  {
>  	struct mana_skb_head *ash = (struct mana_skb_head *)skb->head;
>  	struct gdma_context *gc = apc->ac->gdma_dev->gdma_context;
> +	int hsg = 1; /* num of SGEs of linear part */
>  	struct device *dev = gc->dev;
>  	int i;
>  
> -	dma_unmap_single(dev, ash->dma_handle[0], ash->size[0], DMA_TO_DEVICE);
> +	if (skb_is_gso(skb) && skb_headlen(skb) > ash->size[0])
> +		hsg = 2;
> +
> +	for (i = 0; i < hsg; i++)
> +		dma_unmap_single(dev, ash->dma_handle[i], ash->size[i],
> +				 DMA_TO_DEVICE);
>  
> -	for (i = 1; i < skb_shinfo(skb)->nr_frags + 1; i++)
> +	for (i = hsg; i < skb_shinfo(skb)->nr_frags + hsg; i++)
>  		dma_unmap_page(dev, ash->dma_handle[i], ash->size[i],
>  			       DMA_TO_DEVICE);
>  }
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index 9f70b4332238..4d43adf18606 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -103,9 +103,10 @@ struct mana_txq {
>  
>  /* skb data and frags dma mappings */
>  struct mana_skb_head {
> -	dma_addr_t dma_handle[MAX_SKB_FRAGS + 1];
> +	/* GSO pkts may have 2 SGEs for the linear part*/
> +	dma_addr_t dma_handle[MAX_SKB_FRAGS + 2];
>  
> -	u32 size[MAX_SKB_FRAGS + 1];
> +	u32 size[MAX_SKB_FRAGS + 2];
>  };
>  
>  #define MANA_HEADROOM sizeof(struct mana_skb_head)
> -- 
> 2.25.1
> 
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- You have marked a patch with a "Fixes:" tag for a commit that is in an
  older released kernel, yet you do not have a cc: stable line in the
  signed-off-by area at all, which means that the patch will not be
  applied to any older kernel releases.  To properly fix this, please
  follow the documented rules in the
  Documetnation/process/stable-kernel-rules.rst file for how to resolve
  this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

