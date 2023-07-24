Return-Path: <bpf+bounces-5772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDEE760355
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 01:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867AA280EC6
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 23:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042B3134CE;
	Mon, 24 Jul 2023 23:52:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ABF134AD;
	Mon, 24 Jul 2023 23:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87873C433C7;
	Mon, 24 Jul 2023 23:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690242719;
	bh=OMraFAIU6GX2b7xer6c5z+lNJyNLTIbcVU50mdmeTFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qhKrfI3Or14X3j2O9LZ7JNuqCMKQX9vzAsQOp6XbX6FSExFA6FBlLzKRqyZcjzeeU
	 ZsY/pFTrPjdBJoMHxWsKwAyhaf9jX49ClhvDOeMJzr6RVcJ4dFQ6oCjA1ipDN1pXrD
	 FxDEeGByaHk45a05vNFCklfBYjFpA+jmiasHrmnkDIZkoORbvYCi6N9pJTZN96Knms
	 AvaverxxPIocxTGCQxsC6sDCdoZTFF3yM2wNqvnWL8mAEubkOeQ3hLH60pex8j2kz/
	 cTKGZY+WY86bpzDjrdgP3Cnx1yH9KxoO1cJU1x7e1mZVsNYJd3/yot3R3frcD8DYyN
	 V61kfRc4FFi2A==
Date: Mon, 24 Jul 2023 16:51:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 netdev@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH V2 net-next] net: fec: add XDP_TX feature support
Message-ID: <20230724165157.7094468a@kernel.org>
In-Reply-To: <20230721062153.2769871-1-wei.fang@nxp.com>
References: <20230721062153.2769871-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 14:21:53 +0800 Wei Fang wrote:
> +			/* Tx processing cannot call any XDP (or page pool) APIs if
> +			 * the "budget" is 0. Because NAPI is called with budget of
> +			 * 0 (such as netpoll) indicates we may be in an IRQ context,
> +			 * however, we can't use the page pool from IRQ context.
> +			 */
> +			if (unlikely(!budget))
> +				break;
> +
>  			xdpf = txq->tx_buf[index].xdp;
> -			if (bdp->cbd_bufaddr)
> +			if (bdp->cbd_bufaddr &&
> +			    txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
>  				dma_unmap_single(&fep->pdev->dev,
>  						 fec32_to_cpu(bdp->cbd_bufaddr),
>  						 fec16_to_cpu(bdp->cbd_datlen),
> @@ -1474,7 +1486,10 @@ fec_enet_tx_queue(struct net_device *ndev, u16 queue_id)
>  			/* Free the sk buffer associated with this last transmit */
>  			dev_kfree_skb_any(skb);
>  		} else {
> -			xdp_return_frame(xdpf);
> +			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
> +				xdp_return_frame(xdpf);
> +			else
> +				xdp_return_frame_rx_napi(xdpf);

I think that you need to also break if (!budget) here,
xdp_return_frame() may call page pool APIs to return the frame 
to a page pool owned by another driver. And that needs to be fixed
in net/main already?
-- 
pw-bot: cr

