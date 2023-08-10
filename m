Return-Path: <bpf+bounces-7464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D66777A32
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 16:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D08C1C21680
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFE71FB47;
	Thu, 10 Aug 2023 14:11:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C020D1E1C4;
	Thu, 10 Aug 2023 14:11:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67BBC433C8;
	Thu, 10 Aug 2023 14:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691676706;
	bh=HUCI77XEP/ZejO9fCuPmVe89GUolOa/dD4cccMIUgWI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=H8SqIptR340Pnua6h/WiAcjmrFZHU3Fe2izBiwtddWpXgaeDn9AVDnycR6LVOrVaG
	 K5L/TJdBvwCuYgUlWquj/l2zotI9xQ8iN6sXeM4nbI2A/MMo4B+JagOD/MsLj+7DDZ
	 2YwWe9kcXiCZrK6Z0616NbqWMPTU91+IMty/pS5hRl9hmcEBulaknWG276frp9N1ej
	 XXCEy3bPFdHIPHmgjNHzI4Fy8NUdET6LlaQJlBVC5cp2AdXBpPhs7jgV9mjo+hltPf
	 7sr9n3xng1wR/smWxwVA1fJhMeDXMRbu7HUlgK7jiWqkPmY75MhRc7oU8mKs0Wfc6T
	 ecCu79nvJ8FJA==
Message-ID: <831968f6-3abb-6427-bb1a-e6fd40beb633@kernel.org>
Date: Thu, 10 Aug 2023 16:11:41 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: linux-imx@nxp.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V5 net-next 2/2] net: fec: improve XDP_TX performance
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, larysa.zaremba@intel.com,
 aleksander.lobakin@intel.com, jbrouer@redhat.com, netdev@vger.kernel.org
References: <20230810064514.104470-1-wei.fang@nxp.com>
 <20230810064514.104470-3-wei.fang@nxp.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230810064514.104470-3-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/08/2023 08.45, Wei Fang wrote:
> As suggested by Jesper and Alexander, we can avoid converting xdp_buff
> to xdp_frame in case of XDP_TX to save a bunch of CPU cycles, so that
> we can further improve the XDP_TX performance.
> 
> Before this patch on i.MX8MP-EVK board, the performance shows as follows.
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     353918 pkt/s
> proto 17:     352923 pkt/s
> proto 17:     353900 pkt/s
> proto 17:     352672 pkt/s
> proto 17:     353912 pkt/s
> proto 17:     354219 pkt/s
> 
> After applying this patch, the performance is improved.
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     369261 pkt/s
> proto 17:     369267 pkt/s
> proto 17:     369206 pkt/s
> proto 17:     369214 pkt/s
> proto 17:     369126 pkt/s
> proto 17:     369272 pkt/s
> 

So approx 4.3% improvement.

> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> V5 changes:
> New patch. Separated from the first patch, to keep track of the changes
> and improvements (suggested by Jesper).

Thanks

> ---
>   drivers/net/ethernet/freescale/fec.h      |   5 +-
>   drivers/net/ethernet/freescale/fec_main.c | 134 ++++++++++++----------
>   2 files changed, 73 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 7bb02a9da2a6..a8fbcada6b01 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -552,10 +552,7 @@ enum fec_txbuf_type {
>   };
>   
>   struct fec_tx_buffer {
> -	union {
> -		struct sk_buff *skb;
> -		struct xdp_frame *xdp;
> -	};
> +	void *buf_p;

I want to hear Olek's (Alexander) oppinion on this void pointer circus.

The rest of the patch looks correct to me so:

Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>

--Jesper

>   	enum fec_txbuf_type type;
>   };
>   
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 30b01985be7c..ae6e41ad71b8 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -399,7 +399,7 @@ static void fec_dump(struct net_device *ndev)
>   			fec16_to_cpu(bdp->cbd_sc),
>   			fec32_to_cpu(bdp->cbd_bufaddr),
>   			fec16_to_cpu(bdp->cbd_datlen),
> -			txq->tx_buf[index].skb);
> +			txq->tx_buf[index].buf_p);
>   		bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
>   		index++;
>   	} while (bdp != txq->bd.base);
> @@ -656,7 +656,7 @@ static int fec_enet_txq_submit_skb(struct fec_enet_priv_tx_q *txq,
>   
>   	index = fec_enet_get_bd_index(last_bdp, &txq->bd);
>   	/* Save skb pointer */
> -	txq->tx_buf[index].skb = skb;
> +	txq->tx_buf[index].buf_p = skb;
>   
>   	/* Make sure the updates to rest of the descriptor are performed before
>   	 * transferring ownership.
> @@ -862,7 +862,7 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
>   	}
>   
>   	/* Save skb pointer */
> -	txq->tx_buf[index].skb = skb;
> +	txq->tx_buf[index].buf_p = skb;
>   
>   	skb_tx_timestamp(skb);
>   	txq->bd.cur = bdp;
> @@ -959,27 +959,27 @@ static void fec_enet_bd_init(struct net_device *dev)
>   							 fec32_to_cpu(bdp->cbd_bufaddr),
>   							 fec16_to_cpu(bdp->cbd_datlen),
>   							 DMA_TO_DEVICE);
> -				if (txq->tx_buf[i].skb) {
> -					dev_kfree_skb_any(txq->tx_buf[i].skb);
> -					txq->tx_buf[i].skb = NULL;
> -				}
> -			} else {
> -				if (bdp->cbd_bufaddr &&
> -				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
> +				if (txq->tx_buf[i].buf_p)
> +					dev_kfree_skb_any(txq->tx_buf[i].buf_p);
> +			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
> +				if (bdp->cbd_bufaddr)
>   					dma_unmap_single(&fep->pdev->dev,
>   							 fec32_to_cpu(bdp->cbd_bufaddr),
>   							 fec16_to_cpu(bdp->cbd_datlen),
>   							 DMA_TO_DEVICE);
>   
> -				if (txq->tx_buf[i].xdp) {
> -					xdp_return_frame(txq->tx_buf[i].xdp);
> -					txq->tx_buf[i].xdp = NULL;
> -				}
> +				if (txq->tx_buf[i].buf_p)
> +					xdp_return_frame(txq->tx_buf[i].buf_p);
> +			} else {
> +				struct page *page = txq->tx_buf[i].buf_p;
>   
> -				/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> -				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
> +				if (page)
> +					page_pool_put_page(page->pp, page, 0, false);
>   			}
>   
> +			txq->tx_buf[i].buf_p = NULL;
> +			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> +			txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
>   			bdp->cbd_bufaddr = cpu_to_fec32(0);
>   			bdp = fec_enet_get_nextdesc(bdp, &txq->bd);
>   		}
> @@ -1386,6 +1386,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>   	struct netdev_queue *nq;
>   	int	index = 0;
>   	int	entries_free;
> +	struct page *page;
> +	int frame_len;
>   
>   	fep = netdev_priv(ndev);
>   
> @@ -1407,8 +1409,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>   		index = fec_enet_get_bd_index(bdp, &txq->bd);
>   
>   		if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB) {
> -			skb = txq->tx_buf[index].skb;
> -			txq->tx_buf[index].skb = NULL;
> +			skb = txq->tx_buf[index].buf_p;
>   			if (bdp->cbd_bufaddr &&
>   			    !IS_TSO_HEADER(txq, fec32_to_cpu(bdp->cbd_bufaddr)))
>   				dma_unmap_single(&fep->pdev->dev,
> @@ -1427,18 +1428,24 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>   			if (unlikely(!budget))
>   				break;
>   
> -			xdpf = txq->tx_buf[index].xdp;
> -			if (bdp->cbd_bufaddr &&
> -			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
> -				dma_unmap_single(&fep->pdev->dev,
> -						 fec32_to_cpu(bdp->cbd_bufaddr),
> -						 fec16_to_cpu(bdp->cbd_datlen),
> -						 DMA_TO_DEVICE);
> +			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
> +				xdpf = txq->tx_buf[index].buf_p;
> +				if (bdp->cbd_bufaddr)
> +					dma_unmap_single(&fep->pdev->dev,
> +							 fec32_to_cpu(bdp->cbd_bufaddr),
> +							 fec16_to_cpu(bdp->cbd_datlen),
> +							 DMA_TO_DEVICE);
> +			} else {
> +				page = txq->tx_buf[index].buf_p;
> +			}
> +
>   			bdp->cbd_bufaddr = cpu_to_fec32(0);
> -			if (unlikely(!xdpf)) {
> +			if (unlikely(!txq->tx_buf[index].buf_p)) {
>   				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
>   				goto tx_buf_done;
>   			}
> +
> +			frame_len = fec16_to_cpu(bdp->cbd_datlen);
>   		}
>   
>   		/* Check for errors. */
> @@ -1462,7 +1469,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>   			if (txq->tx_buf[index].type == FEC_TXBUF_T_SKB)
>   				ndev->stats.tx_bytes += skb->len;
>   			else
> -				ndev->stats.tx_bytes += xdpf->len;
> +				ndev->stats.tx_bytes += frame_len;
>   		}
>   
>   		/* Deferred means some collisions occurred during transmit,
> @@ -1487,20 +1494,16 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>   
>   			/* Free the sk buffer associated with this last transmit */
>   			dev_kfree_skb_any(skb);
> +		} else if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
> +			xdp_return_frame_rx_napi(xdpf);
>   		} else {
> -			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
> -				xdp_return_frame_rx_napi(xdpf);
> -			} else {
> -				struct page *page = virt_to_head_page(xdpf->data);
> -
> -				page_pool_put_page(page->pp, page, 0, true);
> -			}
> -
> -			txq->tx_buf[index].xdp = NULL;
> -			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> -			txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
> +			page_pool_put_page(page->pp, page, 0, true);
>   		}
>   
> +		txq->tx_buf[index].buf_p = NULL;
> +		/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> +		txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
> +
>   tx_buf_done:
>   		/* Make sure the update to bdp and tx_buf are performed
>   		 * before dirty_tx
> @@ -3230,7 +3233,6 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>   {
>   	struct fec_enet_private *fep = netdev_priv(ndev);
>   	unsigned int i;
> -	struct sk_buff *skb;
>   	struct fec_enet_priv_tx_q *txq;
>   	struct fec_enet_priv_rx_q *rxq;
>   	unsigned int q;
> @@ -3255,18 +3257,23 @@ static void fec_enet_free_buffers(struct net_device *ndev)
>   			kfree(txq->tx_bounce[i]);
>   			txq->tx_bounce[i] = NULL;
>   
> +			if (!txq->tx_buf[i].buf_p) {
> +				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
> +				continue;
> +			}
> +
>   			if (txq->tx_buf[i].type == FEC_TXBUF_T_SKB) {
> -				skb = txq->tx_buf[i].skb;
> -				txq->tx_buf[i].skb = NULL;
> -				dev_kfree_skb(skb);
> +				dev_kfree_skb(txq->tx_buf[i].buf_p);
> +			} else if (txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO) {
> +				xdp_return_frame(txq->tx_buf[i].buf_p);
>   			} else {
> -				if (txq->tx_buf[i].xdp) {
> -					xdp_return_frame(txq->tx_buf[i].xdp);
> -					txq->tx_buf[i].xdp = NULL;
> -				}
> +				struct page *page = txq->tx_buf[i].buf_p;
>   
> -				txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
> +				page_pool_put_page(page->pp, page, 0, false);
>   			}
> +
> +			txq->tx_buf[i].buf_p = NULL;
> +			txq->tx_buf[i].type = FEC_TXBUF_T_SKB;
>   		}
>   	}
>   }
> @@ -3789,13 +3796,14 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
>   
>   static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   				   struct fec_enet_priv_tx_q *txq,
> -				   struct xdp_frame *frame,
> -				   u32 dma_sync_len, bool ndo_xmit)
> +				   void *frame, u32 dma_sync_len,
> +				   bool ndo_xmit)
>   {
>   	unsigned int index, status, estatus;
>   	struct bufdesc *bdp;
>   	dma_addr_t dma_addr;
>   	int entries_free;
> +	u16 frame_len;
>   
>   	entries_free = fec_enet_get_free_txdesc_num(txq);
>   	if (entries_free < MAX_SKB_FRAGS + 1) {
> @@ -3811,30 +3819,36 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   	index = fec_enet_get_bd_index(bdp, &txq->bd);
>   
>   	if (ndo_xmit) {
> -		dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
> -					  frame->len, DMA_TO_DEVICE);
> +		struct xdp_frame *xdpf = frame;
> +
> +		dma_addr = dma_map_single(&fep->pdev->dev, xdpf->data,
> +					  xdpf->len, DMA_TO_DEVICE);
>   		if (dma_mapping_error(&fep->pdev->dev, dma_addr))
>   			return -ENOMEM;
>   
> +		frame_len = xdpf->len;
> +		txq->tx_buf[index].buf_p = xdpf;
>   		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
>   	} else {
> -		struct page *page = virt_to_page(frame->data);
> +		struct xdp_buff *xdpb = frame;
> +		struct page *page;
>   
> -		dma_addr = page_pool_get_dma_addr(page) + sizeof(*frame) +
> -			   frame->headroom;
> +		page = virt_to_page(xdpb->data);
> +		dma_addr = page_pool_get_dma_addr(page) +
> +			   (xdpb->data - xdpb->data_hard_start);
>   		dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
>   					   dma_sync_len, DMA_BIDIRECTIONAL);
> +		frame_len = xdpb->data_end - xdpb->data;
> +		txq->tx_buf[index].buf_p = page;
>   		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_TX;
>   	}
>   
> -	txq->tx_buf[index].xdp = frame;
> -
>   	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
>   	if (fep->bufdesc_ex)
>   		estatus = BD_ENET_TX_INT;
>   
>   	bdp->cbd_bufaddr = cpu_to_fec32(dma_addr);
> -	bdp->cbd_datlen = cpu_to_fec16(frame->len);
> +	bdp->cbd_datlen = cpu_to_fec16(frame_len);
>   
>   	if (fep->bufdesc_ex) {
>   		struct bufdesc_ex *ebdp = (struct bufdesc_ex *)bdp;
> @@ -3875,14 +3889,10 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
>   				int cpu, struct xdp_buff *xdp,
>   				u32 dma_sync_len)
>   {
> -	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
>   	struct fec_enet_priv_tx_q *txq;
>   	struct netdev_queue *nq;
>   	int queue, ret;
>   
> -	if (unlikely(!xdpf))
> -		return -EFAULT;
> -
>   	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
>   	txq = fep->tx_queue[queue];
>   	nq = netdev_get_tx_queue(fep->netdev, queue);
> @@ -3891,7 +3901,7 @@ static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
>   
>   	/* Avoid tx timeout as XDP shares the queue with kernel stack */
>   	txq_trans_cond_update(nq);
> -	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, dma_sync_len, false);
> +	ret = fec_enet_txq_xmit_frame(fep, txq, xdp, dma_sync_len, false);
>   
>   	__netif_tx_unlock(nq);
>   

