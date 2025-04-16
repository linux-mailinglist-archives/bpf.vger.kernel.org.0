Return-Path: <bpf+bounces-56041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64344A905A8
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189AB19E6E59
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 14:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015CE156F20;
	Wed, 16 Apr 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T5/rW1hJ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54A1F8EEC
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811820; cv=none; b=FhnOGFKdD6VdPEJm0vM8IwpNPtpaesWhgBrdNGQFfI986RvS6WqoqJH1EmmQrJ7UGR60+tX5hNQmkPzxZLhCp5Bb0G9AX+Qjx+yvMmq9AwJmQUF5oYg+fdtmXSNSTh5JaH2qCjEc3bVHObYilaD64sbbpiroqJvVSxrErmMdhsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811820; c=relaxed/simple;
	bh=9IXqGz7/97dAlu3CPAMjzoFLk15SVIkoVOTKZbEIcpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F/Nw+zfGCDsTT53U8iKzJi/AHyS62ZNPRCoudVk9ZRu1O/Jwvh6ANWlsu8omI1XGIKsH9UxG2WcOJTAdUKUL7DroPvrKhUzk3+Wpn1AAvAhtwuZEhssLZXnD7kfQGId+HZ0LAjpswM6Bp7xHAY/9RV8OGGobiSsDj4jXjoacKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T5/rW1hJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744811815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2zb2lt6s4GxmFeaXQ2LR2QpbEMVI0Udd83Rv96tkVQo=;
	b=T5/rW1hJ3PB+0p0087Q0edzmhkYLBhOdT5HAZl98JVhBTNEUGX3uhBKE0JXnFrmFdTE1qA
	PC8M8tTolSDsOmGOFBOVCGBnLEz7O2hIY4iE9WhZb6OvDiNT/H6OWUxUZisSqTxqVv/yyL
	8IIXS8WRD+6IrMNIAMsSgM323Jhp638=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-Bk8D7quvMwKnhzCgqG8ejQ-1; Wed, 16 Apr 2025 09:56:51 -0400
X-MC-Unique: Bk8D7quvMwKnhzCgqG8ejQ-1
X-Mimecast-MFC-AGG-ID: Bk8D7quvMwKnhzCgqG8ejQ_1744811810
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-30bf67adf33so4192331fa.0
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 06:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744811809; x=1745416609;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2zb2lt6s4GxmFeaXQ2LR2QpbEMVI0Udd83Rv96tkVQo=;
        b=Zsy2nLsZyn2YEvzkfaQ1GTYFlobjM9k3zwBYLT4sofPW/yLObu2NSGi3OVXoqAkym8
         vik+x6SfxrGpPkvy0MB8JDLDQ4Fl+Z85916sR43oCRvPG9J4q/ygxQhpXaZZn7c/mXwL
         6DLIQwHrTOCy13HMT4feJD3jEGPYVcm7+8Q+ZIcUUx8hsbIK3SB2DKv8AhaUUYSZPoB/
         DJ1R7LSY7hFXQMhaigVvdkolSfbICE7jRtLYJ1WUPHXxziKXKUFFcPJcApTJSFFItWXA
         O+6VvL0YRaNH0b+3/sxZuvRIDALb76CDXJT4j1OYNQrceyH1WXVxYSwhXqSoPvC6oAEr
         Zn8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7aFcMgoGn3E71UBZswOwF6DBvmfW6smwHYt8vPMAw4GSrznaGmwjd46fl4LDwi2zW+0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7lOEsFpw8iYTSE2PXuqngVRrUhBDSj3Ir94iBJtTf5/yAyOA
	+9ciwCMQLS2gP9GCkMBejGI9ObX2CoxOec2i21o9bvpoIk7yA170UvnrWSiQ1rmbai/v5GBzu0M
	384aOuEdteOLxIB4ga10MqKrBg5YwLGRC8Z1YX4yfKJUzAsmUKA==
X-Gm-Gg: ASbGnctUZkm0U8Are4IfQpL50PUPl3hjRlABAsLvngXRbJX3Ee9r2LRG6WC32SzzT75
	qTvTpYEFpw4lBxBUiUBQTvfC0k2Q5gNn7fFxnirTNRraFShwKm1TNAp9iq2ThuQcAquudlLA1gn
	sJ3OXWbRMB+Y3QcQPXSN3mSQzTdmSnjkSQIu7/N2vq4IBJWPs6Rs1fWWMQmhJPdsGVzMcb0lkBB
	+qYvRNNW3Lp2YTNrDxzQehsizmRKZP4r219fg+KyWHQTwkIb+9bl+buUSLo56Id+Ikwij+LsnZ8
	pbiUWpSd
X-Received: by 2002:a05:6512:31c1:b0:549:8f14:a839 with SMTP id 2adb3069b0e04-54d64b95247mr621853e87.11.1744811809436;
        Wed, 16 Apr 2025 06:56:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVX3/8kuJFFd4NzAMo25LJ0Ly9/TC9S+jk7mqofEjD6pbIQtjg+MzGZEF3d3S6W+UYAmTFcg==
X-Received: by 2002:a05:6512:31c1:b0:549:8f14:a839 with SMTP id 2adb3069b0e04-54d64b95247mr621837e87.11.1744811808984;
        Wed, 16 Apr 2025 06:56:48 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d50260csm1733952e87.132.2025.04.16.06.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:56:47 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 64492199293D; Wed, 16 Apr 2025 15:56:46 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 tom@herbertland.com, Eric Dumazet <eric.dumazet@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
Subject: Re: [PATCH net-next V4 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
In-Reply-To: <174472470529.274639.17026526070544068280.stgit@firesoul>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472470529.274639.17026526070544068280.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 16 Apr 2025 15:56:46 +0200
Message-ID: <87tt6oi50h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jesper Dangaard Brouer <hawk@kernel.org> writes:

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
>  drivers/net/veth.c |   49 +++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 41 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 7bb53961c0ea..a419d5e198d8 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -308,11 +308,10 @@ static void __veth_xdp_flush(struct veth_rq *rq)
>  static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
>  {
>  	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb))) {
> -		dev_kfree_skb_any(skb);
> -		return NET_RX_DROP;
> +		return NETDEV_TX_BUSY; /* signal qdisc layer */
>  	}
>  
> -	return NET_RX_SUCCESS;
> +	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
>  }
>  
>  static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
> @@ -346,11 +345,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
>  	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>  	struct veth_rq *rq = NULL;
> -	int ret = NETDEV_TX_OK;
> +	struct netdev_queue *txq;
>  	struct net_device *rcv;
>  	int length = skb->len;
>  	bool use_napi = false;
> -	int rxq;
> +	int ret, rxq;
>  
>  	rcu_read_lock();
>  	rcv = rcu_dereference(priv->peer);
> @@ -373,17 +372,41 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
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
> +		txq = netdev_get_tx_queue(dev, rxq);
> +
> +		if (qdisc_txq_has_no_queue(txq)) {
> +			dev_kfree_skb_any(skb);
> +			goto drop;
> +		}
> +		netif_tx_stop_queue(txq);
> +		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
> +		__skb_push(skb, ETH_HLEN);
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
> @@ -874,9 +897,16 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  			struct veth_xdp_tx_bq *bq,
>  			struct veth_stats *stats)
>  {
> +	struct veth_priv *priv = netdev_priv(rq->dev);
> +	int queue_idx = rq->xdp_rxq.queue_index;
> +	struct netdev_queue *peer_txq;
> +	struct net_device *peer_dev;
>  	int i, done = 0, n_xdpf = 0;
>  	void *xdpf[VETH_XDP_BATCH];
>  
> +	peer_dev = rcu_dereference(priv->peer);
> +	peer_txq = netdev_get_tx_queue(peer_dev, queue_idx);
> +
>  	for (i = 0; i < budget; i++) {
>  		void *ptr = __ptr_ring_consume(&rq->xdp_ring);
>  
> @@ -925,6 +955,9 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
>  	rq->stats.vs.xdp_packets += done;
>  	u64_stats_update_end(&rq->stats.syncp);
>  
> +	if (unlikely(netif_tx_queue_stopped(peer_txq)))
> +		netif_tx_wake_queue(peer_txq);
> +

netif_tx_wake_queue() does a test_and_clear_bit() and does nothing if
the bit is not set; so does this optimisation really make any
difference? :)

-Toke


