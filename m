Return-Path: <bpf+bounces-72365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA01C1104B
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 20:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D59CC546D96
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 19:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF7832ABCC;
	Mon, 27 Oct 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ircv7Jf+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3EF31D754;
	Mon, 27 Oct 2025 19:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592965; cv=none; b=oo6kDQ7RK4BVq3YpYUuapX87iZgwskfbmUC8tLUwTFRxYvO11QbV5sZsSdSfcCg+CHrfWmzGS5lxfkXaVyo9XslgdARXnCPw4HRck3VT44IYwWRj2hOXrLjaLsFRXZ12hPsXpVyIt/d5yEuJbBmAz4qcieOGUTp8vqG2mkENr/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592965; c=relaxed/simple;
	bh=hQQbdJvuhD/8foS4ARQ8GcU03ZoRHtan+ZrMHcsAB6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBMRcOOzJFfz/6yVjRzkVTIqQprjv183Xk4Jcezi20EvItmdHpPDftTRjXFrW2jW1YkwZnJtAMDlJjhBqtcbRjsssjs56gsc1g5s5555kCwCOdAw3FuZYGKXLa8A52aqtk9daLZRe5LGvttVoGnrt/5aU878VYBSUSqanaywTjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ircv7Jf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E64AC4CEF1;
	Mon, 27 Oct 2025 19:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761592965;
	bh=hQQbdJvuhD/8foS4ARQ8GcU03ZoRHtan+ZrMHcsAB6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ircv7Jf+nwA1kGvNQxD48lL3DEzeAoD74+yPKt9WZUkleONGceoE5KBzNGNiEXHP+
	 /UAqMEpxIC6e1lJlmjjA2jZuJD291iDh5B0jCetjbjMc7JHH/dF3yCqHJcXjaWYeZz
	 KJOHHDpKNjnZeyM87z2XUENY0NBq/WAza3QqMY61GDzUv0par8V62xKlsW5YdYbTUg
	 GvrgrPkaNRcNVFfJ3ppD6S9CY5c1anIvY45/rSLYwDgRo3fTeL91OuquuxQuEkP64n
	 2ApurkZymp6E0XnVomY0u4dL275FK5/zZfWBhXhhsE+LpFUvS95CZEUdgwlvZUcqwF
	 wBkJNbKdek6Hw==
Message-ID: <8275f7c6-1f2f-4734-8d2a-28bd67e11f6d@kernel.org>
Date: Mon, 27 Oct 2025 20:22:40 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net V1 3/3] veth: more robust handing of race to avoid txq
 getting stuck
To: netdev@vger.kernel.org
Cc: Eric Dumazet <eric.dumazet@gmail.com>, makita.toshiaki@lab.ntt.co.jp,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, ihor.solodrai@linux.dev,
 toshiaki.makita1@gmail.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
References: <176123150256.2281302.7000617032469740443.stgit@firesoul>
 <176123158453.2281302.11061466460805684097.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <176123158453.2281302.11061466460805684097.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 23/10/2025 16.59, Jesper Dangaard Brouer wrote:
[...]
> ---
>   drivers/net/veth.c |   42 +++++++++++++++++++++---------------------
>   1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 3976ddda5fb8..1d70377481eb 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -392,14 +392,12 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, struct net_device *dev)
>   		}
>   		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
>   		__skb_push(skb, ETH_HLEN);
> -		/* Depend on prior success packets started NAPI consumer via
> -		 * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
> -		 * paired with empty check in veth_poll().
> -		 */
>   		netif_tx_stop_queue(txq);
> -		smp_mb__after_atomic();
> -		if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
> -			netif_tx_wake_queue(txq);
> +		/* Handle race: Makes sure NAPI peer consumer runs. Consumer is
> +		 * responsible for starting txq again, until then ndo_start_xmit
> +		 * (this function) will not be invoked by the netstack again.
> +		 */
> +		__veth_xdp_flush(rq);
>   		break;
>   	case NET_RX_DROP: /* same as NET_XMIT_DROP */
>   drop:
[...]
> @@ -986,7 +979,8 @@ static int veth_poll(struct napi_struct *napi, int budget)
>   	if (done < budget && napi_complete_done(napi, done)) {
>   		/* Write rx_notify_masked before reading ptr_ring */
>   		smp_store_mb(rq->rx_notify_masked, false);
> -		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring))) {
> +		if (unlikely(!__ptr_ring_empty(&rq->xdp_ring) ||
> +			     (peer_txq && netif_tx_queue_stopped(peer_txq)))) {
>   			if (napi_schedule_prep(&rq->xdp_napi)) {
>   				WRITE_ONCE(rq->rx_notify_masked, true);
>   				__napi_schedule(&rq->xdp_napi);
> @@ -998,6 +992,12 @@ static int veth_poll(struct napi_struct *napi, int budget)
>   		veth_xdp_flush(rq, &bq);
>   	xdp_clear_return_frame_no_direct();
>   
> +	/* Release backpressure per NAPI poll */
> +	if (peer_txq && netif_tx_queue_stopped(peer_txq)) {
                         ^^^^^^^^^^^^^^^^^^^^^^
The check netif_tx_queue_stopped() use a non-atomic test_bit().
Thus, I'm considering adding a smp_rmb() before the if statement, to be
paired with the netif_tx_stop_queue() in veth_xmit().


> +		txq_trans_cond_update(peer_txq);
> +		netif_tx_wake_queue(peer_txq);
> +	}
> +
>   	return done;
>   }

--Jesper

