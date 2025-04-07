Return-Path: <bpf+bounces-55420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77010A7E7CA
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 19:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE64316DD1E
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 17:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB752153CB;
	Mon,  7 Apr 2025 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYCCNIw4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960A21423F;
	Mon,  7 Apr 2025 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045380; cv=none; b=A+27v1FvWQvNYGU3lFbmm3HYdLyUMKpoFGeEQGQCszHqnOro/xGyjP/AgPnDYZLlKD3xfZoUiY/5Au5oSuh1WIIuRrPVu8NS4bK0E0fbMMTNnhmTR3JUUSmUws8YTcJBQ9FODgrcWUJfXR0cKAMJYpeR22xUak3FUlnhYIop9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045380; c=relaxed/simple;
	bh=tOoFBq0Xg3P/EbtBcJjGTjV/+e0av2Z7PPOiyKY4mC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYpG/dPjRNTtgEyoN5AHNkn3gmj0Plb1wK6Pw1kzc3GwJpRVkemwl7dm1dxknlolPxU3JTDFe/LyoC6LqnwfQSXz1FqGeptyGoSABYS9cYlVsRfnEH4qF2CBQu6hVvf89p8jgISGHuXHuS7pfbTzWZHTzcXSVCc0CgKLKiuYlhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYCCNIw4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50927C4CEDD;
	Mon,  7 Apr 2025 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744045380;
	bh=tOoFBq0Xg3P/EbtBcJjGTjV/+e0av2Z7PPOiyKY4mC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RYCCNIw4QMfg5qY6FnXE8bNmEHcbDOV2Pl07mV6LEJr/Hv1gAyEbb06UQca3cLINH
	 gi+E/Amwg9jrrgHnaPbgWF0ZxoNCAtul28Xly8jXYAZbaRMmastQvkIKWFim7CfxU7
	 EOoH/KSk/ejJXsWaaDH2BMo0Da/lPcBxf+sxZF7UeFKB/6f7jm6HjCoXd1/rjdZlbV
	 qz8SQcuHBCK4JSjpx13e63ex3VK+jPxSX2KF8Yq/ULYs4PyEEsL0f0C21LvJ04EmJf
	 ai6OvlZwGWisfF/ct0gkJlWQF8juj903QTZh6AgGOD+x18/Q8pH32vdzm2NdjbyGQS
	 BSJuP2tLJy/2g==
Date: Mon, 7 Apr 2025 18:02:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	bpf@vger.kernel.org, tom@herbertland.com,
	Eric Dumazet <eric.dumazet@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	kernel-team@cloudflare.com
Subject: Re: [RFC PATCH net-next] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
Message-ID: <20250407170256.GU395307@horms.kernel.org>
References: <174377814192.3376479.16481605648460889310.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174377814192.3376479.16481605648460889310.stgit@firesoul>

On Fri, Apr 04, 2025 at 04:49:01PM +0200, Jesper Dangaard Brouer wrote:
> In production, we're seeing TX drops on veth devices when the ptr_ring
> fills up. This can occur when NAPI mode is enabled, though it's
> relatively rare. However, with threaded NAPI - which we use in
> production - the drops become significantly more frequent.
> 
> The underlying issue is that with threaded NAPI, the consumer often runs
> on a different CPU than the producer. This increases the likelihood of
> the ring filling up before the consumer gets scheduled, especially under
> load, leading to drops in veth_xmit() (ndo_start_xmit()).
> 
> This patch introduces backpressure by returning NETDEV_TX_BUSY when the
> ring is full, signaling the qdisc layer to requeue the packet. The txq
> (netdev queue) is stopped in this condition and restarted once
> veth_poll() drains entries from the ring, ensuring coordination between
> NAPI and qdisc.
> 
> Backpressure is only enabled when a qdisc is attached. Without a qdisc,
> the driver retains its original behavior - dropping packets immediately
> when the ring is full. This avoids unexpected behavior changes in setups
> without a configured qdisc.
> 
> With a qdisc in place (e.g. fq, sfq) this allows Active Queue Management
> (AQM) to fairly schedule packets across flows and reduce collateral
> damage from elephant flows.
> 
> A known limitation of this approach is that the full ring sits in front
> of the qdisc layer, effectively forming a FIFO buffer that introduces
> base latency. While AQM still improves fairness and mitigates flow
> dominance, the latency impact is measurable.
> 
> In hardware drivers, this issue is typically addressed using BQL (Byte
> Queue Limits), which tracks in-flight bytes needed based on physical link
> rate. However, for virtual drivers like veth, there is no fixed bandwidth
> constraint - the bottleneck is CPU availability and the scheduler's ability
> to run the NAPI thread. It is unclear how effective BQL would be in this
> context.
> 
> This patch serves as a first step toward addressing TX drops. Future work
> may explore adapting a BQL-like mechanism to better suit virtual devices
> like veth.
> 
> Reported-by: Yan Zhai <yan@cloudflare.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  drivers/net/veth.c |   58 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c

...

> @@ -373,17 +383,39 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>  	}
>  
>  	skb_tx_timestamp(skb);
> -	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
> +
> +	ret = veth_forward_skb(rcv, skb, rq, use_napi);
> +	switch(ret) {
> +	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
>  		if (!use_napi)
>  			dev_sw_netstats_tx_add(dev, 1, length);
>  		else
>  			__veth_xdp_flush(rq);
> -	} else {
> +		break;
> +	case NETDEV_TX_BUSY:
> +		/* If a qdisc is attached to our virtual device, returning
> +		 * NETDEV_TX_BUSY is allowed.
> +		 */
> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, rxq);

Hi Toke,

FYI, clang 20.1.1 W=1 build says:

drivers/net/veth.c:399:3: warning: label followed by a declaration is a C23 extension [-Wc23-extensions]
  399 |                 struct netdev_queue *txq = netdev_get_tx_queue(dev, rxq);

> +
> +		if (!txq_has_qdisc(txq)) {
> +			dev_kfree_skb_any(skb);
> +			goto drop;
> +		}
> +		netif_tx_stop_queue(txq); /* Unconditional netif_txq_try_stop */
> +		if (use_napi)
> +			__veth_xdp_flush(rq);
> +
> +		break;
> +	case NET_RX_DROP: /* same as NET_XMIT_DROP */
>  drop:
>  		atomic64_inc(&priv->dropped);
>  		ret = NET_XMIT_DROP;
> +		break;
> +	default:
> +		net_crit_ratelimited("veth_xmit(%s): Invalid return code(%d)",
> +				     dev->name, ret);
>  	}
> -
>  	rcu_read_unlock();
>  
>  	return ret;

...

