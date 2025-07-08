Return-Path: <bpf+bounces-62580-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D4AFBF62
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 02:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29DC14271DC
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 00:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BFE21B199;
	Tue,  8 Jul 2025 00:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPAZdu6T"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C4218EA1;
	Tue,  8 Jul 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751935427; cv=none; b=RRXeyyfNpNvrjuy4TeCLb9a8Z9dxA7o7vD06ry1jxS30Gm7MpO2uD0NgKIml5HkUm2mpcYFvOoCY0IXo2tuPNWNtTBD32lW6Lra+niXO/DUCxkDEjnZQZ9BTT2jR5Sf6YNiyYeNIwwfK+vLGgmkzTV9JfAT2NXV7tZuiK+matZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751935427; c=relaxed/simple;
	bh=OsxdDXKXe0QU2a4EA/UCYuWDTxhCuFMDmvt3V9Kv+BM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GXIsO/Km+v7aESwqpOkCWEdDUjlet+nbe28RTpa6NmZnvwj+ER8bGupzXLR3VTn6ycKROczlqAcS4L1GRbwC8VWJMhJQvMU2k6usxA5i5iX8nEDJYoqEMrapI8u0jigrTAJBpya29/BsgrBhfdw737xaYJvBa1FksPpU29vD5MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPAZdu6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4ECC4CEE3;
	Tue,  8 Jul 2025 00:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751935427;
	bh=OsxdDXKXe0QU2a4EA/UCYuWDTxhCuFMDmvt3V9Kv+BM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tPAZdu6TM33rYJ3PCvQbBIkRonbpfZONC5pyTLd9LsWQGVFJCf5XU4/WXDQDPujLC
	 NLw1OS+GnQgwJp9EVUOoNavfeqxtX8djAQQT8bQl0zD/rZaJi2Zvd3T/BZhTlbao7c
	 RCK5GVyIhF2mXWrT3LjxNwMMefTf+cegBwkieE0Eh/OKs+deFlBbk7f/i+l2QSE0Gt
	 Ltf5X3GdwH+56HTypfzZGJUBbnS5DLlraYXhhx/YoqRZX/yWrO4gB6sv1Q+8B4mHBj
	 HwQEhG26D9ArycFxI5zaATGK+ZqZTChF8F+Yp5jGPGoBscq5+rIwsuGYZlRXuxBMQ0
	 Vk6EH5o2O6XIg==
Date: Mon, 7 Jul 2025 17:43:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, Eric Dumazet
 <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, kernel-team@cloudflare.com, mfleming@cloudflare.com
Subject: Re: [PATCH net-next V4] net: track pfmemalloc drops via
 SKB_DROP_REASON_PFMEMALLOC
Message-ID: <20250707174346.2211c46a@kernel.org>
In-Reply-To: <175146472829.1363787.9293177520571232738.stgit@firesoul>
References: <175146472829.1363787.9293177520571232738.stgit@firesoul>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 02 Jul 2025 15:59:19 +0200 Jesper Dangaard Brouer wrote:
> Add a new SKB drop reason (SKB_DROP_REASON_PFMEMALLOC) to track packets
> dropped due to memory pressure. In production environments, we've observed
> memory exhaustion reported by memory layer stack traces, but these drops
> were not properly tracked in the SKB drop reason infrastructure.
> 
> While most network code paths now properly report pfmemalloc drops, some
> protocol-specific socket implementations still use sk_filter() without
> drop reason tracking:
> - Bluetooth L2CAP sockets
> - CAIF sockets
> - IUCV sockets
> - Netlink sockets
> - SCTP sockets
> - Unix domain sockets

> @@ -1030,10 +1030,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
>  	}
>  
>  	if (tfile->socket.sk->sk_filter &&
> -	    sk_filter(tfile->socket.sk, skb)) {
> -		drop_reason = SKB_DROP_REASON_SOCKET_FILTER;
> +	    (sk_filter_reason(tfile->socket.sk, skb, &drop_reason)))

why the outside brackets?

> @@ -591,6 +592,10 @@ enum skb_drop_reason {
>  	 * non conform CAN-XL frame (or device is unable to receive CAN frames)
>  	 */
>  	SKB_DROP_REASON_CANXL_RX_INVALID_FRAME,
> +	/**
> +	 * @SKB_DROP_REASON_PFMEMALLOC: dropped when under memory pressure

I guess kinda, but in practice not very precise?

How about: packet allocated from memory reserve reached a path or
socket not eligible for use of memory reserves.

I could be misremembering the meaning of "memory reserve" TBH.

> +	 */
> +	SKB_DROP_REASON_PFMEMALLOC,
>  	/**
>  	 * @SKB_DROP_REASON_MAX: the maximum of core drop reasons, which
>  	 * shouldn't be used as a real 'reason' - only for tracing code gen

> -	if (unlikely(sk_add_backlog(sk, skb, limit))) {
> +	if (unlikely((err = sk_add_backlog(sk, skb, limit)))) {

I understand the else if () case but here you can simply:

	err = sk_add_backlog(sk, skb, limit);
	if (unlikely(err))

no need to make checkpatch upset.

> @@ -162,7 +163,7 @@ static int rose_state3_machine(struct sock *sk, struct sk_buff *skb, int framety
>  		rose_frames_acked(sk, nr);
>  		if (ns == rose->vr) {
>  			rose_start_idletimer(sk);
> -			if (sk_filter_trim_cap(sk, skb, ROSE_MIN_LEN) == 0 &&
> +			if (sk_filter_trim_cap(sk, skb, ROSE_MIN_LEN, &dr) == 0 &&

let's switch to negation rather than comparing to 0 while at it?
otherwise we run over 80 chars

>  			    __sock_queue_rcv_skb(sk, skb) == 0) {
>  				rose->vr = (rose->vr + 1) % ROSE_MODULUS;
>  				queued = 1;
-- 
pw-bot: cr

