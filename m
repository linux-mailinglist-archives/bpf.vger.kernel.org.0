Return-Path: <bpf+bounces-51846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2B8A3A4DA
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 19:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D947A404B
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A4270EC3;
	Tue, 18 Feb 2025 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kgs45BdP"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52D22E401;
	Tue, 18 Feb 2025 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901686; cv=none; b=BdFG/Y7T9PfUKRw1Om4+Mwy/WR447nkWWLX1+KRpBNs8b2wVArJo6LMnYzw10clyVB93n7zZyUZ3p9us9Yvq2fprwLzLlGu7FrRlUI/BKwH2qr3QaIyfDr3YiJ11jhKn6FfohqZTTTJdVagWKy4I984lrjqFEr3cob3cs7pX2iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901686; c=relaxed/simple;
	bh=Bnq3fL80Xbs1mEN0tqq7aCS+2kwWkMlF4aMDYCfT4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qa+SKZEqtJWYwjfjeSo+8KcAEDlbvQWV37L0Z6fX4x2MZtVoVfFLxJPBBKIRn4jGBDLxrPVkWi95J8jKXKqsaO09kPH9F6RQvAKm77mU37HlG77AUJjXRjOJd+Bc0/b+mW9nQVBbAxLVNFiAkkwfqh5dN/o+pB6rz0K0qK8sZX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kgs45BdP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C787CC4CEE4;
	Tue, 18 Feb 2025 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739901685;
	bh=Bnq3fL80Xbs1mEN0tqq7aCS+2kwWkMlF4aMDYCfT4qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kgs45BdPtWlapAqhfVHCd/RksJaQiMQ9vYZpgc9S46LF+RbHUKM6njGogTdMnzG3N
	 +BQS68NgNAO8NPss79qyarPctp6lRA75fxsYY6floW+mxb2BmXI0NLEhdDxAmJIW+4
	 SPgRbkyTZ5BynGzoiZxT1BVwP6QWGuosA3EzIxs2LW9cy0kfeqrgSsCuuXbNi3nGzl
	 Mzy4z64LP9pk5Nc90f+epj+Jabghb/ucADOHUDYUYbSXeFpyrKH/lgGsUvWvfgwrhw
	 kXdgj+a7SrRdrUN4uLmsc7L57nfsA9fZArAISRdom2Awxb0a0ohfXblhLeUBU5yRON
	 s6XA3OcCJsydg==
Date: Tue, 18 Feb 2025 18:01:20 +0000
From: Simon Horman <horms@kernel.org>
To: Roger Quadros <rogerq@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Md Danish Anwar <danishanwar@ti.com>, srk@ti.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 1/5] net: ethernet: ti: am65-cpsw: remove
 am65_cpsw_nuss_tx_compl_packets_2g()
Message-ID: <20250218180120.GC1615191@kernel.org>
References: <20250217-am65-cpsw-zc-prep-v1-0-ce450a62d64f@kernel.org>
 <20250217-am65-cpsw-zc-prep-v1-1-ce450a62d64f@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217-am65-cpsw-zc-prep-v1-1-ce450a62d64f@kernel.org>

On Mon, Feb 17, 2025 at 09:31:46AM +0200, Roger Quadros wrote:
> The only difference between am65_cpsw_nuss_tx_compl_packets_2g() and
> am65_cpsw_nuss_tx_compl_packets() is the usage of spin_lock() and
> netdev_tx_completed_queue() + am65_cpsw_nuss_tx_wake at every packet
> in the latter.
> 
> Insted of having 2 separate functions for TX completion, merge them

nit, in case there is a v2 for some other reason: Instead

> into one. This will reduce code duplication and make maintenance easier.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

...

> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c

...

> @@ -1533,23 +1538,35 @@ static int am65_cpsw_nuss_tx_compl_packets(struct am65_cpsw_common *common,
>  		if (buf_type == AM65_CPSW_TX_BUF_TYPE_SKB) {
>  			skb = am65_cpsw_nuss_tx_compl_packet_skb(tx_chn, desc_dma);
>  			ndev = skb->dev;
> -			total_bytes = skb->len;
> +			pkt_len = skb->len;
>  			napi_consume_skb(skb, budget);
>  		} else {
>  			xdpf = am65_cpsw_nuss_tx_compl_packet_xdp(common, tx_chn,
>  								  desc_dma, &ndev);
> -			total_bytes = xdpf->len;
> +			pkt_len = xdpf->len;
>  			if (buf_type == AM65_CPSW_TX_BUF_TYPE_XDP_TX)
>  				xdp_return_frame_rx_napi(xdpf);
>  			else
>  				xdp_return_frame(xdpf);
>  		}
> +
> +		total_bytes += pkt_len;
>  		num_tx++;
>  
> -		netif_txq = netdev_get_tx_queue(ndev, chn);
> +		if (!single_port) {
> +			/* as packets from multi ports can be interleaved
> +			 * on the same channel, we have to figure out the
> +			 * port/queue at every packet and report it/wake queue.
> +			 */
> +			netif_txq = netdev_get_tx_queue(ndev, chn);
> +			netdev_tx_completed_queue(netif_txq, 1, pkt_len);
> +			am65_cpsw_nuss_tx_wake(tx_chn, ndev, netif_txq);
> +		}
> +	}
>  
> +	if (single_port) {
> +		netif_txq = netdev_get_tx_queue(ndev, chn);
>  		netdev_tx_completed_queue(netif_txq, num_tx, total_bytes);
> -
>  		am65_cpsw_nuss_tx_wake(tx_chn, ndev, netif_txq);
>  	}

Maybe it's not worth it, but it seems that a helper could
avoid duplication of the netif_txq handling immediately above (twice).

Regardless, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

