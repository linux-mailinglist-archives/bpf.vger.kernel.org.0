Return-Path: <bpf+bounces-56610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 215C0A9B22A
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7974A2586
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCA1D9A50;
	Thu, 24 Apr 2025 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="reNKNlsx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBB8178372;
	Thu, 24 Apr 2025 15:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508297; cv=none; b=s6Cy5PMjcsSRauIh4rkx9Ev8Qa4dlVPRIfKm3F9n42ctJ3JoD474UmSMyYJirDpG9mX8tjPs3XMCe7oYtmJc4Y8h5cCMDP5whSgR6L7mSle5trLqeZJrbolxnHKoZAIvFTmFaC0GMqwQHdkSCKB6tPyXHjRElVDboIHVwuY6P0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508297; c=relaxed/simple;
	bh=URvaLzPn0UgorosBEO+hlH9J1rvnPsi51D0Q0sZ8bxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0M7zoI1TZNTPDQFnX0ETX15IRPUUo3F7hlPxmvbxD58BkInhy+MQp6l43YgEYupH56mIuPz7FwI8XSOR29wixue3xQ0cMi82dDyeJSiGfs4/QvAYSckyMcpCnKgFyWpXC/OKf4GO78gkIbE1kFJAPkIuRaPduKiGLBKM/nFHHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=reNKNlsx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2635C4CEE3;
	Thu, 24 Apr 2025 15:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745508297;
	bh=URvaLzPn0UgorosBEO+hlH9J1rvnPsi51D0Q0sZ8bxE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=reNKNlsx5n4C3hJ+F2hsK6Q+GtSRH/072Nazxy8SH+9cDwTNnQQkVwlMcQUNCAZGO
	 7Wv1dJvighsyodjzC4wOwWvQwmTZupEo5AkvLIx5p1RQFH53dRWairyP8xFGiak2bD
	 K8t+aER0axClWjuJtq7qOZSayVySxM4kdBeWq6P+14GKEYqAQXvxOCFoThxSsxj8I7
	 DQe77i+6N1xnRFrBDkIHvm9kmXz1t/yjCl5NVl8rANurWFypkPP7GWZFWMhIpOAA4e
	 LdehEm2AnUdoR4K2+CybqHfBpzblEB3G6zqkhLQPMOPQ6meXceVw+WpD/HPN8U4b3e
	 FRXTdpUGJRHyg==
Message-ID: <c6abaa9f-cd3e-4259-bed6-5e795ff58ecd@kernel.org>
Date: Thu, 24 Apr 2025 17:24:51 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V6 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, tom@herbertland.com,
 Eric Dumazet <eric.dumazet@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
 dsahern@kernel.org, makita.toshiaki@lab.ntt.co.jp,
 kernel-team@cloudflare.com, phil@nwl.cc
References: <174549933665.608169.392044991754158047.stgit@firesoul>
 <174549940981.608169.4363875844729313831.stgit@firesoul>
 <20250424072352.18aa0df1@kernel.org>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20250424072352.18aa0df1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/04/2025 16.23, Jakub Kicinski wrote:
> On Thu, 24 Apr 2025 14:56:49 +0200 Jesper Dangaard Brouer wrote:
>> +	case NETDEV_TX_BUSY:
>> +		/* If a qdisc is attached to our virtual device, returning
>> +		 * NETDEV_TX_BUSY is allowed.
>> +		 */
>> +		txq = netdev_get_tx_queue(dev, rxq);
>> +
>> +		if (qdisc_txq_has_no_queue(txq)) {
>> +			dev_kfree_skb_any(skb);
>> +			goto drop;
>> +		}
>> +		netif_tx_stop_queue(txq);
>> +		/* Restore Eth hdr pulled by dev_forward_skb/eth_type_trans */
>> +		__skb_push(skb, ETH_HLEN);
>> +		/* Depend on prior success packets started NAPI consumer via
>> +		 * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
>> +		 * paired with empty check in veth_poll().
>> +		 */
>> +		if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
>> +			netif_tx_wake_queue(txq);
> 
> Looks like I wrote a reply to v5 but didn't hit send. But I may have
> set v5 to Changes Requested because of it :S Here is my comment:
> 
>   I think this is missing a memory barrier. When drivers do this dance
>   there's usually a barrier between stop and recheck, to make sure the
>   stop is visible before we check. And vice versa veth_xdp_rcv() needs
>   to make sure other side sees the "empty" indication before it checks
>   if the queue is stopped.

The call netif_tx_stop_queue(txq); already contains a memory barrier
smp_mb__before_atomic() plus an atomic set_bit operation.  That should
be sufficient.

And the other side veth_poll(), have a smp_store_mb() before reading
ptr_ring.

--Jesper

p.s.
I actually had an alternative implementation of this, that only calls
stop when it is needed.  See below, it kind of looks prettier, but it
adds an extra memory barrier in the likely path. (And I'm not sure if 
read memory barrier is strong enough).


diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 6ef24e261574..5ab352ccee38 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -390,15 +390,16 @@ static netdev_tx_t veth_xmit(struct sk_buff *skb, 
struct net_device *dev)
                         dev_kfree_skb_any(skb);
                         goto drop;
                 }
-               netif_tx_stop_queue(txq);
                 /* Restore Eth hdr pulled by 
dev_forward_skb/eth_type_trans */
                 __skb_push(skb, ETH_HLEN);
                 /* Depend on prior success packets started NAPI 
consumer via
-                * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
-                * paired with empty check in veth_poll().
+                * __veth_xdp_flush().  Make sure consumer is still 
running and
+                * didn't completely queue, before stopping TXQ. Paired with
+                * queue check in veth_poll().
                  */
-               if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
-                       netif_tx_wake_queue(txq);
+               smp_rmb();
+               if (likely(!__ptr_ring_empty(&rq->xdp_ring)))
+                       netif_tx_stop_queue(txq);
                 break;
         case NET_RX_DROP: /* same as NET_XMIT_DROP */


