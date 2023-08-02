Return-Path: <bpf+bounces-6692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D1C76C976
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 11:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2429D1C2119D
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 09:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4AF569D;
	Wed,  2 Aug 2023 09:27:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707B568A
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 09:27:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0F21FC3
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 02:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690968424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCD/wbqNT6iBlcLGAqvvx86SGRTFevUmX9c0eZH2vTU=;
	b=LfSJsp9LriNqEkdkt4sFgf5xwvoXT4d4RJ9x2z7Ga+iEg7V6ia8GCYZIBtYdRTpyHhnebT
	dtr5ApPgYQJSFfvp4uaWXpfwCrrGOg5JSm/hsBSjcR/ZajYUE++gV8TZOdP1P4V+qCdtX+
	47+64X2f+sRIgdD1x6j89ubat8lj2eY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-lMA7dAqxP9uoIo1yLhXH-Q-1; Wed, 02 Aug 2023 05:27:02 -0400
X-MC-Unique: lMA7dAqxP9uoIo1yLhXH-Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51da39aa6dcso5028555a12.2
        for <bpf@vger.kernel.org>; Wed, 02 Aug 2023 02:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690968421; x=1691573221;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DCD/wbqNT6iBlcLGAqvvx86SGRTFevUmX9c0eZH2vTU=;
        b=ZSCkiR4037yjZS/+OIj76crOf60YIk/UWdwUZm+QuJkPOg6t0ZaCRG9w7WH6a9Yb8K
         48VYy+zHCZB6wuSQWhLg2yeaMxt8Pe2LSefgV8Xi+BQrUEu9u6LNx47iiwTp0fK3fLZS
         2bBq5tg639gwNAXYrn1Jom4vYKExqqNkn3Cg4HywkSOXnFanM+JGuPGzx0OuP3XJ37tp
         YHli5x0y0eFpLafXkI6Qyo+qgo8DYuA4BLahbcUMaU3/6j2mMN6VrLYyQdNV0NPgQREh
         +FjpOEUxSHe5KubuPARwVmhOlBFAsTv4zLkRfnWJy7Hq4bOoDQuLSl77jayIxg5u+XvP
         mE0w==
X-Gm-Message-State: ABy/qLb9uQsVp+orgVetjC9hLVlrVTPDTjchIgeeIO26Wu/MvMkJTzoJ
	2sQvJvJi6vnSobK72sJzLPhUCYHRZgNHTFrCiulaNQ7eVOLILqNn5TI/iBtNPzFZLQeTOmJGt1r
	oFskI4iOdlNQx
X-Received: by 2002:aa7:d5ca:0:b0:522:2019:2020 with SMTP id d10-20020aa7d5ca000000b0052220192020mr4133117eds.17.1690968421689;
        Wed, 02 Aug 2023 02:27:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEMUlAexT5aq1Ralm3oRm8CFZE9NJi4oAWH3IEHbx5D5vsLGXffbImAOSMR8JUVEYftgKBSNw==
X-Received: by 2002:aa7:d5ca:0:b0:522:2019:2020 with SMTP id d10-20020aa7d5ca000000b0052220192020mr4133091eds.17.1690968421266;
        Wed, 02 Aug 2023 02:27:01 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id j9-20020aa7ca49000000b0051873c201a0sm8140530edt.26.2023.08.02.02.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 02:27:00 -0700 (PDT)
From: Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <3d0a8536-6a22-22e5-41c0-98c13dd7b802@redhat.com>
Date: Wed, 2 Aug 2023 11:26:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc: brouer@redhat.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Content-Language: en-US
To: Wei Fang <wei.fang@nxp.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org
References: <20230731060025.3117343-1-wei.fang@nxp.com>
In-Reply-To: <20230731060025.3117343-1-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 31/07/2023 08.00, Wei Fang wrote:
> The XDP_TX feature is not supported before, and all the frames
> which are deemed to do XDP_TX action actually do the XDP_DROP
> action. So this patch adds the XDP_TX support to FEC driver.
> 
> I tested the performance of XDP_TX feature in XDP_DRV and XDP_SKB
> modes on i.MX8MM-EVK and i.MX8MP-EVK platforms respectively, and
> the test steps and results are as follows.
> 
> Step 1: Board A connects to the FEC port of the DUT and runs the
> pktgen_sample03_burst_single_flow.sh script to generate and send
> burst traffic to DUT. Note that the length of packet was set to
> 64 bytes and the procotol of packet was UDP in my test scenario.
> 
> Step 2: The DUT runs the xdp2 program to transmit received UDP
> packets back out on the same port where they were received.
> 

Below test result runs should have some more explaination, please.
(more inline code comments below)

> root@imx8mmevk:~# ./xdp2 eth0
> proto 17:     150326 pkt/s
> proto 17:     141920 pkt/s
> proto 17:     147338 pkt/s
> proto 17:     140783 pkt/s
> proto 17:     150400 pkt/s
> proto 17:     134651 pkt/s
> proto 17:     134676 pkt/s
> proto 17:     134959 pkt/s
> proto 17:     148152 pkt/s
> proto 17:     149885 pkt/s
> 
> root@imx8mmevk:~# ./xdp2 -S eth0
> proto 17:     131094 pkt/s
> proto 17:     134691 pkt/s
> proto 17:     138930 pkt/s
> proto 17:     129347 pkt/s
> proto 17:     133050 pkt/s
> proto 17:     132932 pkt/s
> proto 17:     136628 pkt/s
> proto 17:     132964 pkt/s
> proto 17:     131265 pkt/s
> proto 17:     135794 pkt/s
> 
> root@imx8mpevk:~# ./xdp2 eth0
> proto 17:     135817 pkt/s
> proto 17:     142776 pkt/s
> proto 17:     142237 pkt/s
> proto 17:     135673 pkt/s
> proto 17:     139508 pkt/s
> proto 17:     147340 pkt/s
> proto 17:     133329 pkt/s
> proto 17:     141171 pkt/s
> proto 17:     146917 pkt/s
> proto 17:     135488 pkt/s
> 
> root@imx8mpevk:~# ./xdp2 -S eth0
> proto 17:     133150 pkt/s
> proto 17:     133127 pkt/s
> proto 17:     133538 pkt/s
> proto 17:     133094 pkt/s
> proto 17:     133690 pkt/s
> proto 17:     133199 pkt/s
> proto 17:     133905 pkt/s
> proto 17:     132908 pkt/s
> proto 17:     133292 pkt/s
> proto 17:     133511 pkt/s
> 

For this driver, I would like to see a benchmark comparison between
XDP_TX and XDP_REDIRECT.

As below code does could create a situation where XDP_REDIRECT is just
as fast as XDP_TX.  (Note, that I expect XDP_TX to be faster than
XDP_REDIRECT.)

> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
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
> ---
>   drivers/net/ethernet/freescale/fec.h      |  1 +
>   drivers/net/ethernet/freescale/fec_main.c | 80 ++++++++++++++++++-----
>   2 files changed, 65 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
> index 8f1edcca96c4..f35445bddc7a 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -547,6 +547,7 @@ enum {
>   enum fec_txbuf_type {
>   	FEC_TXBUF_T_SKB,
>   	FEC_TXBUF_T_XDP_NDO,
> +	FEC_TXBUF_T_XDP_TX,
>   };
>   
>   struct fec_tx_buffer {
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index 14d0dc7ba3c9..2068fe95504e 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -75,6 +75,8 @@
>   
>   static void set_multicast_list(struct net_device *ndev);
>   static void fec_enet_itr_coal_set(struct net_device *ndev);
> +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> +				struct xdp_buff *xdp);
>   
>   #define DRIVER_NAME	"fec"
>   
> @@ -960,7 +962,8 @@ static void fec_enet_bd_init(struct net_device *dev)
>   					txq->tx_buf[i].skb = NULL;
>   				}
>   			} else {
> -				if (bdp->cbd_bufaddr)
> +				if (bdp->cbd_bufaddr &&
> +				    txq->tx_buf[i].type == FEC_TXBUF_T_XDP_NDO)
>   					dma_unmap_single(&fep->pdev->dev,
>   							 fec32_to_cpu(bdp->cbd_bufaddr),
>   							 fec16_to_cpu(bdp->cbd_datlen),
> @@ -1423,7 +1426,8 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>   				break;
>   
>   			xdpf = txq->tx_buf[index].xdp;
> -			if (bdp->cbd_bufaddr)
> +			if (bdp->cbd_bufaddr &&
> +			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
>   				dma_unmap_single(&fep->pdev->dev,
>   						 fec32_to_cpu(bdp->cbd_bufaddr),
>   						 fec16_to_cpu(bdp->cbd_datlen),
> @@ -1482,7 +1486,7 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id, int budget)
>   			/* Free the sk buffer associated with this last transmit */
>   			dev_kfree_skb_any(skb);
>   		} else {
> -			xdp_return_frame(xdpf);
> +			xdp_return_frame_rx_napi(xdpf);
>   
>   			txq->tx_buf[index].xdp = NULL;
>   			/* restore default tx buffer type: FEC_TXBUF_T_SKB */
> @@ -1573,11 +1577,18 @@ fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
>   		}
>   		break;
>   
> -	default:
> -		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
> -		fallthrough;
> -
>   	case XDP_TX:
> +		err = fec_enet_xdp_tx_xmit(fep->netdev, xdp);

You should pass along the "sync" length value to fec_enet_xdp_tx_xmit().
Because we know DMA comes from same device (it is already DMA mapped
to), then we can do a DMA sync "to_device" with only the sync length.

> +		if (err) {

Add an unlikely(err) or do like above case XDP_REDIRECT, where it takes
the likely case "if (!err)" first.

> +			ret = FEC_ENET_XDP_CONSUMED;
> +			page = virt_to_head_page(xdp->data);
> +			page_pool_put_page(rxq->page_pool, page, sync, true);
> +		} else {
> +			ret = FEC_ENET_XDP_TX;
> +		}
> +		break;
> +
> +	default:
>   		bpf_warn_invalid_xdp_action(fep->netdev, prog, act);
>   		fallthrough;
>   
> @@ -3793,7 +3804,8 @@ fec_enet_xdp_get_tx_queue(struct fec_enet_private *fep, int index)
>   
>   static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   				   struct fec_enet_priv_tx_q *txq,
> -				   struct xdp_frame *frame)
> +				   struct xdp_frame *frame,
> +				   bool ndo_xmit)

E.g add parameter dma_sync_len.

>   {
>   	unsigned int index, status, estatus;
>   	struct bufdesc *bdp;
> @@ -3813,10 +3825,24 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
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
> +					   frame->len, DMA_BIDIRECTIONAL);

Optimization: use dma_sync_len here instead of frame->len.

> +		txq->tx_buf[index].type = FEC_TXBUF_T_XDP_TX;
> +	}
> +
> +	txq->tx_buf[index].xdp = frame;
>   
>   	status |= (BD_ENET_TX_INTR | BD_ENET_TX_LAST);
>   	if (fep->bufdesc_ex)
> @@ -3835,9 +3861,6 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   		ebdp->cbd_esc = cpu_to_fec32(estatus);
>   	}
>   
> -	txq->tx_buf[index].type = FEC_TXBUF_T_XDP_NDO;
> -	txq->tx_buf[index].xdp = frame;
> -
>   	/* Make sure the updates to rest of the descriptor are performed before
>   	 * transferring ownership.
>   	 */
> @@ -3863,6 +3886,31 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
>   	return 0;
>   }
>   
> +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> +				struct xdp_buff *xdp)
> +{

E.g add parameter dma_sync_len.

> +	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);

XDP_TX can avoid this conversion to xdp_frame.
It would requires some refactor of fec_enet_txq_xmit_frame().

> +	struct fec_enet_private *fep = netdev_priv(ndev);
> +	struct fec_enet_priv_tx_q *txq;
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +	int queue, ret;
> +
> +	queue = fec_enet_xdp_get_tx_queue(fep, cpu);
> +	txq = fep->tx_queue[queue];
> +	nq = netdev_get_tx_queue(fep->netdev, queue);
> +
> +	__netif_tx_lock(nq, cpu);

It is sad that XDP_TX takes a lock for each frame.

> +
> +	/* Avoid tx timeout as XDP shares the queue with kernel stack */
> +	txq_trans_cond_update(nq);
> +	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, false);

Add/pass parameter dma_sync_len to fec_enet_txq_xmit_frame().


> +
> +	__netif_tx_unlock(nq);
> +
> +	return ret;
> +}
> +
>   static int fec_enet_xdp_xmit(struct net_device *dev,
>   			     int num_frames,
>   			     struct xdp_frame **frames,
> @@ -3885,7 +3933,7 @@ static int fec_enet_xdp_xmit(struct net_device *dev,
>   	/* Avoid tx timeout as XDP shares the queue with kernel stack */
>   	txq_trans_cond_update(nq);
>   	for (i = 0; i < num_frames; i++) {
> -		if (fec_enet_txq_xmit_frame(fep, txq, frames[i]) < 0)
> +		if (fec_enet_txq_xmit_frame(fep, txq, frames[i], true) < 0)
>   			break;
>   		sent_frames++;
>   	}


