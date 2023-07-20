Return-Path: <bpf+bounces-5414-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 311F575A4DA
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 05:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3F3281BF5
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 03:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829EB17F7;
	Thu, 20 Jul 2023 03:45:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC77137D;
	Thu, 20 Jul 2023 03:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A2EC433C8;
	Thu, 20 Jul 2023 03:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689824754;
	bh=z0i62JjuZ7ZlCOWbWdYwj78VlFeYhWN9ot1ReDkacAw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ky2dINi/AGQI0jKAECg1n2BYUJ8uk4hUBYBW4SzCHcMKYROrxiFVxazf9OL2VMrNP
	 Tgc1Wv94Y+mKhMa8Mwm/EPHSlvJ4ktx4xD99UCujutg8jaK8i0KUR3DbzCJltUsDvz
	 WTbJnDmH7pgx4tbBa7profEpRE1O+6PEhwbKLmclwpQAGtsfLsA+mN7PWhzAmlEBPl
	 8d+WVRLU7ACijBa5G66YVkol8cYX7H5As5Cl0/FqzsK0zm3QC3SjOx4/sCLG1BZlAF
	 7O0m/tFTMYdG3YqwJkBleaOSRAg7/8B/EYGy/sliPQmRa7QPfzr+ox02xnUxybv4J4
	 JefDu/63+IWRw==
Date: Wed, 19 Jul 2023 20:45:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
 netdev@vger.kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: fec: add XDP_TX feature support
Message-ID: <20230719204553.46856b29@kernel.org>
In-Reply-To: <20230717103709.2629372-1-wei.fang@nxp.com>
References: <20230717103709.2629372-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jul 2023 18:37:09 +0800 Wei Fang wrote:
> -			xdp_return_frame(xdpf);
> +			if (txq->tx_buf[index].type == FEC_TXBUF_T_XDP_NDO)
> +				xdp_return_frame(xdpf);
> +			else
> +				xdp_return_frame_rx_napi(xdpf);

Are you taking budget into account? When NAPI is called with budget 
of 0 we are *not* in napi / softirq context. You can't be processing
any XDP tx under such conditions (it may be a netpoll call from IRQ
context).

> +static int fec_enet_xdp_tx_xmit(struct net_device *ndev,
> +				struct xdp_buff *xdp)
> +{
> +	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
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
> +
> +	ret = fec_enet_txq_xmit_frame(fep, txq, xdpf, false);
> +
> +	__netif_tx_unlock(nq);

If you're reusing the same queues as the stack you need to call
txq_trans_cond_update() at some point, otherwise the stack may
print a splat complaining the queue got stuck.
-- 
pw-bot: cr

