Return-Path: <bpf+bounces-7463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF6B7779FE
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 15:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25B822818D2
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAB71FB26;
	Thu, 10 Aug 2023 13:58:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DA11E1CA;
	Thu, 10 Aug 2023 13:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FA6C433C8;
	Thu, 10 Aug 2023 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691675919;
	bh=upCoyvr5r3WWebLPEphf3foEcZ+pNHIJw594hTv6YZg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sGMDl4uS3zzFIhZ2bCXkScJePDDLBIPL9V0ou0e4Q/1J/KrA19Dns8Q9KBV4cgq1e
	 u1efI7xququG6DnvOlKSk1w6RR8BzrhAvgRTpYDfyv0Xp1LXDzT8GfPodXT+vPLk2Y
	 qyflKmvxT3S8sxqdTn4ugarm6DRaz7AzI12n/E8dISKfe0cKyXxnSn5d5KIzBHDGTp
	 jp5i03qnesyjVdp323M4443z3fkF28nuxxU6D/zQBz9PNWyMoMBnj10IWVHv8BMWnh
	 eJLBXe1fI+Elij5VJ68L1BODB7+kx8uGXxRJyf+DnnxQnNqmZF1tQkWp7McruhVuGL
	 vXv3NWJU1ltkA==
Message-ID: <a7ede79c-8d5f-0036-7b8d-67c736cea058@kernel.org>
Date: Thu, 10 Aug 2023 15:58:33 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: linux-imx@nxp.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH V5 net-next 1/2] net: fec: add XDP_TX feature support
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, larysa.zaremba@intel.com,
 aleksander.lobakin@intel.com, jbrouer@redhat.com, netdev@vger.kernel.org
References: <20230810064514.104470-1-wei.fang@nxp.com>
 <20230810064514.104470-2-wei.fang@nxp.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230810064514.104470-2-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/08/2023 08.45, Wei Fang wrote:
> The XDP_TX feature is not supported before, and all the frames
> which are deemed to do XDP_TX action actually do the XDP_DROP
> action. So this patch adds the XDP_TX support to FEC driver.
> 
> I tested the performance of XDP_TX in XDP_DRV mode and XDP_SKB
> mode respectively on i.MX8MP-EVK platform, and as suggested by
> Jesper, I also tested the performance of XDP_REDIRECT on the
> same platform. And the test steps and results are as follows.
> 
> XDP_TX test:
> Step 1: One board is used as generator and connects to switch,and
> the FEC port of DUT also connects to the switch. Both boards with
> flow control off. Then the generator runs the
> pktgen_sample03_burst_single_flow.sh script to generate and send
> burst traffic to DUT. Note that the size of packet was set to 64
> bytes and the procotol of packet was UDP in my test scenario. In
> addtion, the SMAC of the packet need to be different from the MAC
> of the generator, because the xdp2 program will swap the DMAC and
> SMAC of the packet and send it back to the generator. If the SMAC
> of the generated packet is the MAC of the generator, the generator
> will receive the returned traffic which increase the CPU loading
> and significantly degrade the transmit speed of the generator, and
> finally it affects the test of XDP_TX performance.
> 

Great that you included this description.

> Step 2: The DUT runs the xdp2 program to transmit received UDP
> packets back out on the same port where they were received.
> 
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     353918 pkt/s
> proto 17:     352923 pkt/s
> proto 17:     353900 pkt/s
> proto 17:     352672 pkt/s
> proto 17:     353912 pkt/s
> proto 17:     354219 pkt/s
> 

Nice performance results! :-)

> root@imx8mpevk:~# ./xdp2 -S eth0
> proto 17:     160604 pkt/s
> proto 17:     160708 pkt/s
> proto 17:     160564 pkt/s
> proto 17:     160684 pkt/s
> proto 17:     160640 pkt/s
> proto 17:     160720 pkt/s
> 
> The above results show that the XDP_TX performance of XDP_DRV mode
> is much better than XDP_SKB mode, more than twice that of XDP_SKB
> mode, which is in line with our expectation.
> 
> XDP_REDIRECT test:
> Step1: Both the generator and the FEC port of the DUT connet to the
> switch port. All the ports with flow control off, then the generator
> runs the pktgen script to generate and send burst traffic to DUT.
> Note that the size of packet was set to 64 bytes and the procotol of
> packet was UDP in my test scenario.
> 
> Step2: The DUT runs the xdp_redirect program to redirect the traffic
> from the FEC port to the FEC port itself.
> 
> root@imx8mpevk:~# ./xdp_redirect eth0 eth0
> Redirecting from eth0 (ifindex 2; driver fec) to eth0
> (ifindex 2; driver fec)
> Summary        232,302 rx/s        0 err,drop/s      232,344 xmit/s
> Summary        234,579 rx/s        0 err,drop/s      234,577 xmit/s
> Summary        235,548 rx/s        0 err,drop/s      235,549 xmit/s
> Summary        234,704 rx/s        0 err,drop/s      234,703 xmit/s
> Summary        235,504 rx/s        0 err,drop/s      235,504 xmit/s
> Summary        235,223 rx/s        0 err,drop/s      235,224 xmit/s
> Summary        234,509 rx/s        0 err,drop/s      234,507 xmit/s
> Summary        235,481 rx/s        0 err,drop/s      235,482 xmit/s
> Summary        234,684 rx/s        0 err,drop/s      234,683 xmit/s
> Summary        235,520 rx/s        0 err,drop/s      235,520 xmit/s
> Summary        235,461 rx/s        0 err,drop/s      235,461 xmit/s
> Summary        234,627 rx/s        0 err,drop/s      234,627 xmit/s
> Summary        235,611 rx/s        0 err,drop/s      235,611 xmit/s
>    Packets received    : 3,053,753
>    Average packets/s   : 234,904
>    Packets transmitted : 3,053,792
>    Average transmit/s  : 234,907
> 
> Compared the performance of XDP_TX with XDP_REDIRECT, XDP_TX is also
> much better than XDP_REDIRECT. It's also in line with our expectation.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Suggested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---

If you add below code comment you can add my ACK in V6:

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>


> V2 changes:
> According to Jakub's comments, the V2 patch adds two changes.
> 1. Call txq_trans_cond_update() in fec_enet_xdp_tx_xmit() to avoid
> tx timeout as XDP shares the queues with kernel stack.
> 2. Tx processing shouldn't call any XDP (or page pool) APIs if the
> "budget" is 0.
> 
> V3 changes:
> 1. Remove the second change in V2, because this change has been
> separated into another patch and it has been submmitted to the
> upstream [1].
> [1] https://lore.kernel.org/r/20230725074148.2936402-1-wei.fang@nxp.com
> 
> V4 changes:
> 1. Based on Jakub's comments, add trace_xdp_exception() for the
> error path of XDP_TX.
> 
> V5: changes:
> 1. Implement Jesper's "sync_dma_len" suggestion and simultaneously
> use page_pool_put_page(pool, page, 0, true) for XDP_TX to avoid
> the DMA sync on page recycle, which is suggested by Jakub.
> 2. Based on Jesper's suggestion, add a benchmark comparison between
> XDP_TX and XDP_REDIRECT. So the commit message is also modified
> synchronously.
> ---
>   drivers/net/ethernet/freescale/fec.h      |   1 +
>   drivers/net/ethernet/freescale/fec_main.c | 104 +++++++++++++++++-----
>   2 files changed, 84 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 5ca9906d7c6a..7bb02a9da2a6 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -548,6 +548,7 @@ enum {
>   enum fec_txbuf_type {
>   	FEC_TXBUF_T_SKB,
>   	FEC_TXBUF_T_XDP_NDO,
> +	FEC_TXBUF_T_XDP_TX,
>   };
>   
>   struct fec_tx_buffer {
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 43f14cec91e9..30b01985be7c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -68,6 +68,7 @@
>   #include <soc/imx/cpuidle.h>
>   #include <linux/filter.h>
>   #include <linux/bpf.h>
> +#include <linux/bpf_trace.h>
>   
>   #include <asm/cacheflush.h>
>   
> @@ -75,6 +76,9 @@
>   
>   static void set_multicast_list(struct net_device *ndev);
>   static void fec_enet_itr_coal_set(struct net_device *ndev);
> +static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
> +				int cpu, struct xdp_buff *xdp,
> +				u32 dma_sync_len);
>   
>   #define DRIVER_NAME	"fec"
>   
> @@ -960,7 +964,8 @@ static void fec_enet_bd_init(struct net_device *dev)
>   					txq->tx_buf[i].skb = NULL;
>   				}
>   			} else {
> -				if (bdp->cbd_bufaddr)
> +				if (bdp->cbd_bufaddr &&
> +				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
>   					dma_unmap_single(&fep->pdev->dev,
>   							 fec32_to_cpu(bdp->cbd_bufaddr),
>   							 fec16_to_cpu(bdp->cbd_datlen),
> @@ -1423,13 +1428,14 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>   				break;
>   
>   			xdpf = txq->tx_buf[index].xdp;
> -			if (bdp->cbd_bufaddr)
> +			if (bdp->cbd_bufaddr &&
> +			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
>   				dma_unmap_single(&fep->pdev->dev,
>   						 fec32_to_cpu(bdp->cbd_bufaddr),
>   						 fec16_to_cpu(bdp->cbd_datlen),
>   						 DMA_TO_DEVICE);
>   			bdp->cbd_bufaddr = cpu_to_fec32(0);
> -			if (!xdpf) {
> +			if (unlikely(!xdpf)) {
>   				txq->tx_buf[index].type = FEC_TXBUF_T_SKB;
>   				goto tx_buf_done;
>   			}
> @@ -1482,7 +1488,13 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>   			/* Free the sk buffer associated with this last transmit */
>   			dev_kfree_skb_any(skb);
>   		} else {
> -			xdp_return_frame(xdpf);
> +			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO) {
> +				xdp_return_frame_rx_napi(xdpf);
> +			} else {
> +				struct page *page = virt_to_head_page(xdpf->data);
> +

I think this usage of page_pool_put_page() with dma_sync_size=0 requires
a comment, else we will forget why this okay...
I suggest:

/* PP dma_sync_size=0 as xmit already synced DMA for_device */

> +				page_pool_put_page(page->pp, page, 0, true);
> +			}
>   
>   			txq->tx_buf[index].xdp = NULL;
>   			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> @@ -1541,7 +1553,7 @@ static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
>   
>   static u32
>   fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
> -		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int index)
> +		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
>   {
>   	unsigned int sync, len = xdp->data_end - xdp->data;
>   	u32 ret = FEC_ENET_XDP_PASS;
> @@ -1551,8 +1563,10 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
>   
>   	act = bpf_prog_run_xdp(prog, xdp);
>   
> -	/* Due xdp_adjust_tail: DMA sync for_device cover max len CPU touch */
> -	sync = xdp->data_end - xdp->data_hard_start - FEC_ENET_XDP_HEADROOM;
> +	/* Due xdp_adjust_tail and xdp_adjust_head: DMA sync for_device cover
> +	 * max len CPU touch
> +	 */
> +	sync = xdp->data_end - xdp->data;
>   	sync = max(sync, len);
>   
>   	switch (act) {
> @@ -1573,11 +1587,19 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
>   		}
>   		break;
>   
> -	default:
> -		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
> -		fallthrough;
> -
>   	case XDP_TX:
> +		err = fec_enet_xdp_tx_xmit(fep, cpu, xdp, sync);
> +		if (unlikely(err)) {
> +			ret = FEC_ENET_XDP_CONSUMED;
> +			page = virt_to_head_page(xdp->data);
> +			page_pool_put_page(rxq->page_pool, page, sync, true);
> +			trace_xdp_exception(fep->netdev, prog, act);
> +		} else {
> +			ret = FEC_ENET_XDP_TX;
> +		}
> +		break;
> +
> +	default:
>   		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
>   		fallthrough;
>   
> @@ -1619,6 +1641,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
>   	struct bpf_prog *xdp_prog = READ_ONCE(fep->xdp_prog);
>   	u32 ret, xdp_result = FEC_ENET_XDP_PASS;
>   	u32 data_start = FEC_ENET_XDP_HEADROOM;
> +	int cpu = smp_processor_id();
>   	struct xdp_buff xdp;
>   	struct page *page;
>   	u32 sub_len = 4;
> @@ -1697,7 +1720,7 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
>   			/* subtract 16bit shift and FCS */
>   			xdp_prepare_buff(&xdp, page_address(page),
>   					 data_start, pkt_len - sub_len, false);
> -			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, index);
> +			ret = fec_enet_run_xdp(fep, xdp_prog, &xdp, rxq, cpu);
>   			xdp_result |= ret;
>   			if (ret != FEC_ENET_XDP_PASS)
>   				goto rx_processing_done;
> @@ -3766,7 +3789,8 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
>   
>   static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   				   struct fec_enet_priv_tx_q *txq,
> -				   struct xdp_frame *frame)
> +				   struct xdp_frame *frame,
> +				   u32 dma_sync_len, bool ndo_xmit)
>   {
>   	unsigned int index, status, estatus;
>   	struct bufdesc *bdp;
> @@ -3786,10 +3810,24 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   
>   	index = fec_enet_get_bd_index(bdp, &txq->bd);
>   
> -	dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
> -				  frame->len, DMA_TO_DEVICE);
> -	if (dma_mapping_error(&fep->pdev->dev, dma_addr))
> -		return -ENOMEM;
> +	if (ndo_xmit) {
> +		dma_addr = dma_map_single(&fep->pdev->dev, frame->data,
> +					  frame->len, DMA_TO_DEVICE);
> +		if (dma_mapping_error(&fep->pdev->dev, dma_addr))
> +			return -ENOMEM;
> +
> +		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
> +	} else {
> +		struct page *page = virt_to_page(frame->data);
> +
> +		dma_addr = page_pool_get_dma_addr(page) + sizeof(*frame) +
> +			   frame->headroom;
> +		dma_sync_single_for_device(&fep->pdev->dev, dma_addr,
> +					   dma_sync_len, DMA_BIDIRECTIONAL);

DMA sync for_device is here, that allows recycling PP with dma_sync_size=0.

> +		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_TX;
> +	}
> +
> +	txq->tx_buf[index].xdp = frame;
>   
>   	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
>   	if (fep->bufdesc_ex)
> @@ -3808,9 +3846,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   		ebdp->cbd_esc = cpu_to_fec32(estatus);
>   	}
>   
> -	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
> -	txq->tx_buf[index].xdp = frame;
> -
>   	/* Make sure the updates to rest of the descriptor are performed before
>   	 * transferring ownership.
>   	 */
> @@ -3836,6 +3871,33 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   	return 0;
>   }
>   
> +static int fec_enet_xdp_tx_xmit(struct fec_enet_private *fep,
> +				int cpu, struct xdp_buff *xdp,
> +				u32 dma_sync_len)
> +{
> +	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
> +	struct fec_enet_priv_tx_q *txq;
> +	struct netdev_queue *nq;
> +	int queue, ret;
> +
> +	if (unlikely(!xdpf))
> +		return -EFAULT;
> +
> +	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
> +	txq = fep->tx_queue[queue];
> +	nq = netdev_get_tx_queue(fep->netdev, queue);
> +
> +	__netif_tx_lock(nq, cpu);
> +
> +	/* Avoid tx timeout as XDP shares the queue with kernel stack */
> +	txq_trans_cond_update(nq);
> +	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, dma_sync_len, false);
> +
> +	__netif_tx_unlock(nq);
> +
> +	return ret;
> +}
> +
>   static int fec_enet_xdp_xmit(struct net_device *dev,
>   			     int num_frames,
>   			     struct xdp_frame **frames,
> @@ -3858,7 +3920,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
>   	/* Avoid tx timeout as XDP shares the queue with kernel stack */
>   	txq_trans_cond_update(nq);
>   	for (i = 0; i < num_frames; i++) {
> -		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
> +		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], 0, true) < 0)
>   			break;
>   		sent_frames++;
>   	}

