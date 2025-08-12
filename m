Return-Path: <bpf+bounces-65431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4C4B22AC1
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 16:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 566A817C431
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 14:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D96A2EA743;
	Tue, 12 Aug 2025 14:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE65g0G1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018132AE99;
	Tue, 12 Aug 2025 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009011; cv=none; b=ahZz/3dwyZhasJLyIG81EXLRMjjTz0fVsqq9czAggQA1ULBzYMxzER12muPYXznqrwEuwcCsfXRu6tJGg8awoP8NmeVUd6MNTWxpcyw4plkOGGymlG+9U87vlKQEr+OKW2vWvO3pkBuaQbXTf9DAgP4NkRShgu3Ab7k4CI0V1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009011; c=relaxed/simple;
	bh=jSyNlbSqb9c0dGJSJ86AGwyyjiCHp5I0JeTzYxn+p5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lsv4vYNdHR9hid3edRb7Y7gSCNmX/B9RiAKC2mUmPBdJi+hvM2biYbwYJigPN60MprhBGjuqxpUUR+mnfH+3nq2fa2YfM9jcOJ4I3yFbXvEYNJ+c//kvd+l+YTzws0ytxmyZoaoy0qyNshYAh5KylFXn+65cr4f3WlxmRcr5Cew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE65g0G1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AB4C4CEF0;
	Tue, 12 Aug 2025 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755009010;
	bh=jSyNlbSqb9c0dGJSJ86AGwyyjiCHp5I0JeTzYxn+p5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OE65g0G1gXtpCNAf4WOs+I1Q5TfgIZ6lhEs4AvhgNa5TMhoVxO16ev44P8g2NVEXb
	 HtKq/zWCbtQdERqs2EFIYgS7k3y+K++h3NXl9kXQgr9CRwEuAY0wPRL2hoYDUuaTse
	 GlYuLt+KBptKWCxdXE/1eS2zgOu/rsDUT4WCZqZCo3PojeXI0xJlopoNymd3VFGiAO
	 cE2S2Ndvy4Ejk5yvl9JKam5TLrxGMoVLV4lw0JMJFqK4XRWOIIHhg8MrLwmHkgN5KP
	 K/J+5HfHINu3kCtOdHCQhV3I1rjYnzA7U1dHKkpfOdxzybQbJIsvuaWNKUhIlDCMen
	 UXisLrrlmu0+g==
Message-ID: <b07b8930-e644-45a2-bef8-06f4494e7a39@kernel.org>
Date: Tue, 12 Aug 2025 16:30:03 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] xsk: support generic batch xmit in copy mode
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, horms@kernel.org,
 andrew+netdev@lunn.ch
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20250811131236.56206-1-kerneljasonxing@gmail.com>
 <20250811131236.56206-3-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250811131236.56206-3-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2025 15.12, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Zerocopy mode has a good feature named multi buffer while copy mode has
> to transmit skb one by one like normal flows. The latter might lose the
> bypass power to some extent because of grabbing/releasing the same tx
> queue lock and disabling/enabling bh and stuff on a packet basis.
> Contending the same queue lock will bring a worse result.
> 

I actually think that it is worth optimizing the non-zerocopy mode for
AF_XDP.  My use-case was virtual net_devices like veth.


> This patch supports batch feature by permitting owning the queue lock to
> send the generic_xmit_batch number of packets at one time. To further
> achieve a better result, some codes[1] are removed on purpose from
> xsk_direct_xmit_batch() as referred to __dev_direct_xmit().
> 
> [1]
> 1. advance the device check to granularity of sendto syscall.
> 2. remove validating packets because of its uselessness.
> 3. remove operation of softnet_data.xmit.recursion because it's not
>     necessary.
> 4. remove BQL flow control. We don't need to do BQL control because it
>     probably limit the speed. An ideal scenario is to use a standalone and
>     clean tx queue to send packets only for xsk. Less competition shows
>     better performance results.
> 
> Experiments:
> 1) Tested on virtio_net:

If you also want to test on veth, then an optimization is to increase
dev->needed_headroom to XDP_PACKET_HEADROOM (256), as this avoids non-zc
AF_XDP packets getting reallocated by veth driver. I never completed
upstreaming this[1] before I left Red Hat.  (virtio_net might also benefit)

  [1] 
https://github.com/xdp-project/xdp-project/blob/main/areas/core/veth_benchmark04.org 


(more below...)

> With this patch series applied, the performance number of xdpsock[2] goes
> up by 33%. Before, it was 767743 pps; while after it was 1021486 pps.
> If we test with another thread competing the same queue, a 28% increase
> (from 405466 pps to 521076 pps) can be observed.
> 2) Tested on ixgbe:
> The results of zerocopy and copy mode are respectively 1303277 pps and
> 1187347 pps. After this socket option took effect, copy mode reaches
> 1472367 which was higher than zerocopy mode impressively.
> 
> [2]: ./xdpsock -i eth1 -t  -S -s 64
> 
> It's worth mentioning batch process might bring high latency in certain
> cases. The recommended value is 32.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   include/linux/netdevice.h |   2 +
>   net/core/dev.c            |  18 +++++++
>   net/xdp/xsk.c             | 103 ++++++++++++++++++++++++++++++++++++--
>   3 files changed, 120 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 5e5de4b0a433..27738894daa7 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3352,6 +3352,8 @@ u16 dev_pick_tx_zero(struct net_device *dev, struct sk_buff *skb,
>   
>   int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev);
>   int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id);
> +int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *dev,
> +			  struct netdev_queue *txq, u32 max_batch, u32 *cur);
>   
>   static inline int dev_queue_xmit(struct sk_buff *skb)
>   {
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 68dc47d7e700..7a512bd38806 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4742,6 +4742,24 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
>   }
>   EXPORT_SYMBOL(__dev_queue_xmit);
>   
> +int xsk_direct_xmit_batch(struct sk_buff **skb, struct net_device *dev,
> +			  struct netdev_queue *txq, u32 max_batch, u32 *cur)
> +{
> +	int ret = NETDEV_TX_BUSY;
> +
> +	local_bh_disable();
> +	HARD_TX_LOCK(dev, txq, smp_processor_id());
> +	for (; *cur < max_batch; (*cur)++) {
> +		ret = netdev_start_xmit(skb[*cur], dev, txq, false);

The last argument ('false') to netdev_start_xmit() indicate if there are
'more' packets to be sent. This allows the NIC driver to postpone
writing the tail-pointer/doorbell. For physical hardware this is a large
performance gain.

If index have not reached 'max_batch' then we know 'more' packets are true.

   bool more = !!(*cur != max_batch);

Can I ask you to do a test with netdev_start_xmit() using the 'more' 
boolian ?


> +		if (ret != NETDEV_TX_OK)
> +			break;
> +	}
> +	HARD_TX_UNLOCK(dev, txq);
> +	local_bh_enable();
> +
> +	return ret;
> +}
> +
>   int __dev_direct_xmit(struct sk_buff *skb, u16 queue_id)
>   {
>   	struct net_device *dev = skb->dev;
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 7a149f4ac273..92ad82472776 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -780,9 +780,102 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>   	return ERR_PTR(err);
>   }
>   
> -static int __xsk_generic_xmit(struct sock *sk)
> +static int __xsk_generic_xmit_batch(struct xdp_sock *xs)
> +{
> +	u32 max_batch = READ_ONCE(xs->generic_xmit_batch);
> +	struct sk_buff **skb = xs->skb_batch;
> +	struct net_device *dev = xs->dev;
> +	struct netdev_queue *txq;
> +	bool sent_frame = false;
> +	struct xdp_desc desc;
> +	u32 i = 0, j = 0;
> +	u32 max_budget;
> +	int err = 0;
> +
> +	mutex_lock(&xs->mutex);
> +
> +	/* Since we dropped the RCU read lock, the socket state might have changed. */
> +	if (unlikely(!xsk_is_bound(xs))) {
> +		err = -ENXIO;
> +		goto out;
> +	}
> +
> +	if (xs->queue_id >= dev->real_num_tx_queues)
> +		goto out;
> +
> +	if (unlikely(!netif_running(dev) ||
> +		     !netif_carrier_ok(dev)))
> +		goto out;
> +
> +	max_budget = READ_ONCE(xs->max_tx_budget);
> +	txq = netdev_get_tx_queue(dev, xs->queue_id);
> +	do {
> +		for (; i < max_batch && xskq_cons_peek_desc(xs->tx, &desc, xs->pool); i++) {
> +			if (max_budget-- == 0) {
> +				err = -EAGAIN;
> +				break;
> +			}
> +			/* This is the backpressure mechanism for the Tx path.
> +			 * Reserve space in the completion queue and only proceed
> +			 * if there is space in it. This avoids having to implement
> +			 * any buffering in the Tx path.
> +			 */
> +			err = xsk_cq_reserve_addr_locked(xs->pool, desc.addr);
> +			if (err) {
> +				err = -EAGAIN;
> +				break;
> +			}
> +
> +			skb[i] = xsk_build_skb(xs, &desc);

There is a missed opportunity for bulk allocating the SKBs here
(via kmem_cache_alloc_bulk).

But this also requires changing the SKB alloc function used by
xsk_build_skb(). As a seperate patch, I recommend that you change the
sock_alloc_send_skb() to instead use build_skb (or build_skb_around).
I expect this will be a large performance improvement on it's own.
Can I ask you to benchmark this change before the batch xmit change?

Opinions needed from other maintainers please (I might be wrong!):
I don't think the socket level accounting done in sock_alloc_send_skb()
is correct/relevant for AF_XDP/XSK, because the "backpressure mechanism"
code comment above.

--Jesper

> +			if (IS_ERR(skb[i])) {
> +				err = PTR_ERR(skb[i]);
> +				break;
> +			}
> +
> +			xskq_cons_release(xs->tx);
> +
> +			if (xp_mb_desc(&desc))
> +				xs->skb = skb[i];
> +		}
> +
> +		if (i) {
> +			err = xsk_direct_xmit_batch(skb, dev, txq, i, &j);
> +			if  (err == NETDEV_TX_BUSY) {
> +				err = -EAGAIN;
> +			} else if (err == NET_XMIT_DROP) {
> +				j++;
> +				err = -EBUSY;
> +			}
> +
> +			sent_frame = true;
> +			xs->skb = NULL;
> +		}
> +
> +		if (err)
> +			goto out;
> +		i = j = 0;
> +	} while (xskq_cons_peek_desc(xs->tx, &desc, xs->pool));
> +
> +	if (xskq_has_descs(xs->tx)) {
> +		if (xs->skb)
> +			xsk_drop_skb(xs->skb);
> +		xskq_cons_release(xs->tx);
> +	}
> +
> +out:
> +	for (; j < i; j++) {
> +		xskq_cons_cancel_n(xs->tx, xsk_get_num_desc(skb[j]));
> +		xsk_consume_skb(skb[j]);
> +	}
> +	if (sent_frame)
> +		__xsk_tx_release(xs);
> +
> +	mutex_unlock(&xs->mutex);
> +	return err;
> +}
> +
> +static int __xsk_generic_xmit(struct xdp_sock *xs)
>   {
> -	struct xdp_sock *xs = xdp_sk(sk);
>   	bool sent_frame = false;
>   	struct xdp_desc desc;
>   	struct sk_buff *skb;
> @@ -871,11 +964,15 @@ static int __xsk_generic_xmit(struct sock *sk)
>   
>   static int xsk_generic_xmit(struct sock *sk)
>   {
> +	struct xdp_sock *xs = xdp_sk(sk);
>   	int ret;
>   
>   	/* Drop the RCU lock since the SKB path might sleep. */
>   	rcu_read_unlock();
> -	ret = __xsk_generic_xmit(sk);
> +	if (READ_ONCE(xs->generic_xmit_batch))
> +		ret = __xsk_generic_xmit_batch(xs);
> +	else
> +		ret = __xsk_generic_xmit(xs);
>   	/* Reaquire RCU lock before going into common code. */
>   	rcu_read_lock();
>   


