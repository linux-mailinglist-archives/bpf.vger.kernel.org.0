Return-Path: <bpf+bounces-56037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7155DA8B980
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 14:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4157E1687E6
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 12:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E06E13E41A;
	Wed, 16 Apr 2025 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZfPJQ2I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E695184E;
	Wed, 16 Apr 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744807468; cv=none; b=jMvfGO7/NPsi5Y/8Vk6nfF3IPInx0ykXF/toz+dJFemNYMuUU4PCeUgTsZEY67Kh9QWHG4U4XL+R92Xl23yfH5cJpUhR5u/XAPEexcc96toLL3VM45xY39UE/RWRcNHw6zzWz/tVBSLxmND9/N723jXujjqAw4TWIpA/xGe+d2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744807468; c=relaxed/simple;
	bh=SSTWVJO1diKyw283aHhQsiiOBS1vy6cZgHsNBPeeeTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwuw0wGbI/pTUnGPjOROpiy6vQcy46SRSMK/jM2GwsLYL8ONBCIiEboAmR0RpqzDhudcwIUcfvPM5BycWgZXKKK1PziiF/Cqb1XBFbxUbQBakGxhb4vm+7Yq+VHiB9QmmqssKxMQmczcCGQhYbZopEJledI3MSJhFt746e9iHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZfPJQ2I; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22622ddcc35so90281075ad.2;
        Wed, 16 Apr 2025 05:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744807466; x=1745412266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXHhPokJ8w8TN0m/4XLAGztzycoy86YpMW+tnYZDWRM=;
        b=DZfPJQ2I6/CggkrpBBozUd4huwffigCZBi64ijbEO+kFn833FmwYzp0ancR/fOVbni
         Ixa2MDQpRmoeS0quZ8/+jnGDZH2wFvHLddI7FLQr2M6FauC0fv0sJFVleUJE5I6YynYT
         Ay12zXr4AOEnLZp8KIpGq91dBlGoS3GpLyl5OkEVL+NwepfrnIUhj5EOlMsRVGmitOWB
         QHMc4SwrUfTEq96jkf7sIBFdvveMt1ACYgX/U2bIUGpWZaiKGc1l6LH5mnpkE312N5m4
         MMBXbHrgcSD2V8TQYgqNUMtzVqBw2Oal2GoM+yjWprTwOHOyIeOdy6AXVrlro0twoB94
         4LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744807466; x=1745412266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NXHhPokJ8w8TN0m/4XLAGztzycoy86YpMW+tnYZDWRM=;
        b=o4K6bMnRgXmT8ojQU1Rb/P+josVecpkGmj1uzu5FBv1NAXF83bO+pXMrVsoqER0LsX
         jiFQGGIXxImoLKjqGyDtvlkznWEieMLfhi13Odqt+GfBwavPHOhkz//IA8EgPcv+cNJa
         RH3mtmPeXDOQm2W6nUvDaoDu9jYFYAB6llN++Ga698a2UVzjQwhKB7cy6CLUQ7DebIxh
         7eih9almZmYNTE0gVyL9/ITxkuq+VRIpVa1GM3TESVaoQvR6obBwdH5+YVVDN3BVj/jN
         OIMV6hHuxJepAjNUBh2yIsr8AFB9rh9Qun6hP+auQRumrSlNFDGqaCnhutaIXury692L
         D9aA==
X-Forwarded-Encrypted: i=1; AJvYcCW7cMdybl8y4HL8qwg8ZDvdaiAaqtpszVyZ/EFjh5qQ4VNOkwfly2hkSkuiDvpJND7hbReA6lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YySxVjCNAZl+sEkVsNQ8hv94d++woOfZTPz4n36RzFZXXpgRNwo
	YfAZXBhnL9K+HMWkl9zBx098N+OnsqCGGXg1I56GGj0JYlD6B1FB
X-Gm-Gg: ASbGncsUT7KDHwqNhsjG/GxIgCZCn1aXWHYFRANy4G6qvjBcMMEDyW/f2xjODZH/X4/
	nzFhN/mxOpW3PaVAyBAHvAQc1YQU9uKMhj8YclBfziZzLsvoM+wYUmVGd8pRUyWXfUK1T8MMuLB
	PpzrWC5+XTHvUtfdzum1QpjAW6L8FtMtgghKyqNsQFMrCf6Aab6dhsyxgqxxsAK9vTaEtAI4bYa
	2lxuDu0TjyyEj11KnS1tsm78ptkyavMSGBO0ff5dM8zkv6ij3xbhG+fb98tQnAqXIH0XsVzU0nR
	moTZ1LDeH5Frzdcw+zkeyxNeG1SN5njfj54Wlo6LFjSmURFwkMW9zN2eDoDdOnwjeFzQ0YS6589
	qaVdDdCOe+4LGivnNjGikH+GwGMcGmQ==
X-Google-Smtp-Source: AGHT+IG8zL8CiDKFza8w9sF89ygztuFcR3zMJ+NXsgQAxAPR4hPHVacBcqGKD+HXmawsUnJCABPc7w==
X-Received: by 2002:a17:903:986:b0:223:f408:c3dc with SMTP id d9443c01a7336-22c358c4f74mr27384825ad.9.1744807466273;
        Wed, 16 Apr 2025 05:44:26 -0700 (PDT)
Received: from [192.168.99.14] (i60-34-11-52.s41.a013.ap.plala.or.jp. [60.34.11.52])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-22c33fc4b89sm12710615ad.169.2025.04.16.05.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 05:44:25 -0700 (PDT)
Message-ID: <882f14f9-99e7-44ac-a325-ad809bf0ccff@gmail.com>
Date: Wed, 16 Apr 2025 21:44:18 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V4 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <174472463778.274639.12670590457453196991.stgit@firesoul>
 <174472470529.274639.17026526070544068280.stgit@firesoul>
Content-Language: en-US
From: Toshiaki Makita <toshiaki.makita1@gmail.com>
In-Reply-To: <174472470529.274639.17026526070544068280.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/04/15 22:45, Jesper Dangaard Brouer wrote:
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

Thank you for the patch.

> Reported-by: Yan Zhai <yan@cloudflare.com>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>   drivers/net/veth.c |   49 +++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 7bb53961c0ea..a419d5e198d8 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -308,11 +308,10 @@ static void __veth_xdp_flush(struct veth_rq *rq)
>   static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
>   {
>   	if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb))) {
> -		dev_kfree_skb_any(skb);
> -		return NET_RX_DROP;
> +		return NETDEV_TX_BUSY; /* signal qdisc layer */
>   	}

You don't need this braces any more?

if (...)
     return ...;

>   
> -	return NET_RX_SUCCESS;
> +	return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
>   }
>   
>   static int veth_forward_skb(struct net_device *dev, struct sk_buff *skb,
> @@ -346,11 +345,11 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	struct veth_priv *rcv_priv, *priv = netdev_priv(dev);
>   	struct veth_rq *rq = NULL;
> -	int ret = NETDEV_TX_OK;
> +	struct netdev_queue *txq;
>   	struct net_device *rcv;
>   	int length = skb->len;
>   	bool use_napi = false;
> -	int rxq;
> +	int ret, rxq;
>   
>   	rcu_read_lock();
>   	rcv = rcu_dereference(priv->peer);
> @@ -373,17 +372,41 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>   	}
>   
>   	skb_tx_timestamp(skb);
> -	if (likely(veth_forward_skb(rcv, skb, rq, use_napi) == NET_RX_SUCCESS)) {
> +
> +	ret = veth_forward_skb(rcv, skb, rq, use_napi);
> +	switch(ret) {
> +	case NET_RX_SUCCESS: /* same as NETDEV_TX_OK */
>   		if (!use_napi)
>   			dev_sw_netstats_tx_add(dev, 1, length);
>   		else
>   			__veth_xdp_flush(rq);
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

You did not add a packet to the ring.
No need for flush here?

Toshiaki Makita

