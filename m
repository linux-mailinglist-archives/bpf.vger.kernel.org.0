Return-Path: <bpf+bounces-56607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0846A9B0DD
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 16:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B8474A508A
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 14:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8718E27CCD3;
	Thu, 24 Apr 2025 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML+zf286"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5D41B4248;
	Thu, 24 Apr 2025 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745504635; cv=none; b=MoUeymJ780HnaWndGwCkb9VfnWzIUxvRId6CkxC8Ib+D4Zt4KbNiJfUuLNXB4yAc4KnpxHahurXx3Z8YerkPVeUglVBHWMoTcHsg2kM8RQKx2Vd50wxZKd7BiQYV47oNdk5fw0VWJfzVuREg3/hceBJel1p6VK49XmdMmFKxsVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745504635; c=relaxed/simple;
	bh=/VhUo42gnBZ25sYuPllLt17/9RBLjW6u+T/K4IZR0hw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O0NZBEt0pYvYmg/CqP80DiHnPigITYcGq3l3I8xJyGOZrhTNJtLK8JZDg05kAD0Jc1JLGJHvTNFEivt5iT4BjbU0d7RJHU8wql643zuFbkDSiVnm1RzxoQO6finRwISZk+MxU5jObkKT0B8dMWv83iKX9275G5cZ42s2HKctLMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML+zf286; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3D3C4CEE3;
	Thu, 24 Apr 2025 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745504634;
	bh=/VhUo42gnBZ25sYuPllLt17/9RBLjW6u+T/K4IZR0hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ML+zf286/DaEHVgCXjhaP2vpTTURYvyX9EfSn3scYmNQN67IPAGDDbKVzY/KQARYM
	 AlO+zh4Oq4R1UqQSoahOOaZeAMKuoQGeLp45Vc+gdM08MVllJiK4sJ4Scpl23FUXql
	 DUjsW2EzawZTIDNF7WnWV3W8r7b3mpy3sIHVR0+KRg4F40tGSCzJBj40MSoi3LXclH
	 y8zdP5Z9vsil8Y96FmmGVBpxVTIF5Diiz2kB8Ogw92Z1ZwoI5QseAxZ0v9yFbm2TYs
	 ryJP79l0cR5RDttUySz0zcX244MDdsqFFpTmfWEro5yj7RnUYnWDph7Is0mUBg56NZ
	 5EBCf9aOY9zxg==
Date: Thu, 24 Apr 2025 07:23:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, tom@herbertland.com, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNl?=
 =?UTF-8?B?bg==?= <toke@toke.dk>, dsahern@kernel.org,
 makita.toshiaki@lab.ntt.co.jp, kernel-team@cloudflare.com, phil@nwl.cc
Subject: Re: [PATCH net-next V6 2/2] veth: apply qdisc backpressure on full
 ptr_ring to reduce TX drops
Message-ID: <20250424072352.18aa0df1@kernel.org>
In-Reply-To: <174549940981.608169.4363875844729313831.stgit@firesoul>
References: <174549933665.608169.392044991754158047.stgit@firesoul>
	<174549940981.608169.4363875844729313831.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 14:56:49 +0200 Jesper Dangaard Brouer wrote:
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
> +		/* Depend on prior success packets started NAPI consumer via
> +		 * __veth_xdp_flush(). Cancel TXQ stop if consumer stopped,
> +		 * paired with empty check in veth_poll().
> +		 */
> +		if (unlikely(__ptr_ring_empty(&rq->xdp_ring)))
> +			netif_tx_wake_queue(txq);

Looks like I wrote a reply to v5 but didn't hit send. But I may have
set v5 to Changes Requested because of it :S Here is my comment:

 I think this is missing a memory barrier. When drivers do this dance
 there's usually a barrier between stop and recheck, to make sure the
 stop is visible before we check. And vice versa veth_xdp_rcv() needs
 to make sure other side sees the "empty" indication before it checks 
 if the queue is stopped.

