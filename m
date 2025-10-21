Return-Path: <bpf+bounces-71590-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAB3BF7A4C
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 18:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45135462FB1
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 16:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3263491DF;
	Tue, 21 Oct 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQ2+uzR8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103B3491D5;
	Tue, 21 Oct 2025 16:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063916; cv=none; b=BlljcJy7QH0oBWf8rz+RqKRfOI2dMhcV/e6bjhDO0+E7LCewTOxpgvSZwhoaiUQw0ItDuCm6i3ii/Awn9vEX9rz6c/DLpHalAMI5ggtPgw+J4QH9Mad4ABTwD7QLHoPRk1sY+YZIG+9p0Dm4g97cEfLsB6U/YZkVI+pn2GXRJro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063916; c=relaxed/simple;
	bh=q0fhm0UR6QPcn3oQ7i939P5mKJ7p0W/EmSLFSGX90zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cYAJ07N0vYWw8BbYc5zsY4pESfCNUyQLdVSPsI5VP5Gnhqx6Pn240lnFZsmehLzWWGStQcSku+yn73ZRG0bFuAPg0PVczaTNe6skgTd2coE3ahukP9Y3hhupE7ikhaqSe+esqI6d0x2dqH0cmarPTZX7pQiQdCxw1v64av5OJws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQ2+uzR8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D857C4CEF1;
	Tue, 21 Oct 2025 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761063916;
	bh=q0fhm0UR6QPcn3oQ7i939P5mKJ7p0W/EmSLFSGX90zY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQ2+uzR8mOu5SxDT16hElWK+RiqF3yuyLHZv/xfK/ipAsd2qBEoP6JOjbfVvowHuy
	 lvovRXCN1Kvszu51kiaycpQzrVamdTCBu3zUDT43YRJPG0tcg4Q+Z7SRG8mu0LbFCd
	 xwc5K98e8BRKvcwt7P8AUSa4oM6LQrxo+bQFqb1KwgQDvBBK/ceRFWve1PPNBZvjpN
	 vUlx0DGWRMVwrIhk4IwmCCMyJOM39/pu/HruIE6V0xWsC+7rBCzCZaMDckfHHTIPHJ
	 E8+ZxkOrRYFyKPJkjEh+1O1jTX48WjnyH+ceMNmf8suBJMOTZNrL2oxxhUwz+KpLGB
	 Ev7x2dM7vueRw==
Date: Tue, 21 Oct 2025 17:25:12 +0100
From: Simon Horman <horms@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, csmate@nop.hu, kerneljasonxing@gmail.com,
	maciej.fijalkowski@intel.com, bjorn@kernel.org, sdf@fomichev.me,
	jonathan.lemon@gmail.com, bpf@vger.kernel.org
Subject: Re: [PATCH net] xsk: avoid data corruption on cq descriptor number
Message-ID: <aPez6DYh13kmY9NF@horms.kernel.org>
References: <20251021150656.6704-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021150656.6704-1-fmancera@suse.de>

On Tue, Oct 21, 2025 at 05:06:56PM +0200, Fernando Fernandez Mancera wrote:

...

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c

...

> @@ -774,6 +777,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  {
>  	struct net_device *dev = xs->dev;
>  	struct sk_buff *skb = xs->skb;
> +	struct page *page;
>  	int err;
>  
>  	if (dev->priv_flags & IFF_TX_SKB_NO_LINEAR) {
> @@ -791,6 +795,8 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  		len = desc->len;
>  
>  		if (!skb) {
> +			struct xsk_addr_node *head_addr;
> +
>  			hr = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
>  			tr = dev->needed_tailroom;
>  			skb = sock_alloc_send_skb(&xs->sk, hr + len + tr, 1, &err);
> @@ -804,7 +810,13 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			if (unlikely(err))
>  				goto free_err;
>  
> -			xsk_skb_init_misc(skb, xs, desc->addr);
> +			head_addr = kmem_cache_zalloc(xsk_tx_generic_cache, GFP_KERNEL);
> +			if (!head_addr) {
> +				__free_page(page);

Hi Fernando,

Perhaps the page changes to xsk_build_skb() aren't needed
because page seems to be uninitialised here.

Flagged by W=1 builds with Clang 21.1.1, and Smatch.

> +				err = -ENOMEM;
> +				goto free_err;
> +			}
> +			xsk_skb_init_misc(skb, xs, head_addr, desc->addr);
>  			if (desc->options & XDP_TX_METADATA) {
>  				err = xsk_skb_metadata(skb, buffer, desc,
>  						       xs->pool, hr);
> @@ -814,7 +826,6 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  		} else {
>  			int nr_frags = skb_shinfo(skb)->nr_frags;
>  			struct xsk_addr_node *xsk_addr;
> -			struct page *page;
>  			u8 *vaddr;
>  
>  			if (unlikely(nr_frags == (MAX_SKB_FRAGS - 1) && xp_mb_desc(desc))) {
> @@ -843,7 +854,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			refcount_add(PAGE_SIZE, &xs->sk.sk_wmem_alloc);
>  
>  			xsk_addr->addr = desc->addr;
> -			list_add_tail(&xsk_addr->addr_node, &XSKCB(skb)->addrs_list);
> +			list_add_tail(&xsk_addr->addr_node, &XSK_TX_HEAD(skb)->addr_node);
>  		}
>  	}
>  
> -- 
> 2.51.0
> 
> 

