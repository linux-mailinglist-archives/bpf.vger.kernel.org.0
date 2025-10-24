Return-Path: <bpf+bounces-72097-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CB0C0687E
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86D4B3A4D21
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B115431D397;
	Fri, 24 Oct 2025 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyqxt5ym"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFAC2DEA8E;
	Fri, 24 Oct 2025 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312828; cv=none; b=t5AlfhM4+tv7PJdr5GjvNZOkdSVLbizx6ui1wUX0/EtmXjWQYb1SEyitqlcaN5+733kO07I/xHdGgbXSwGW9bPa3AiMkFj0dCufi2PIqWsTH0TFQ/1BHbUXJ+3QE82pw9sXKeKOenQOPy45m09MFmSHLk0V3SDkLhckBSzUuXRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312828; c=relaxed/simple;
	bh=36Hmp3K068qUi4nYbEAo+khHScvPypuK4G3dx21o9qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/1bSG885urxPSfrHzFu0gjZgyEDONe97pRUZ5oEj2ic+DwMa1B95EL4vqByT6N0x8q4/TqT6IpgDzF2ZhDkxz9SY8alrJZQxuvC2J4az0D7aACQU/Karcj3AeNZHRtH9i6OzpnDw6p7maU1qC1oCmB4EPt3uDTjhYFW58QeFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyqxt5ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BC5C4CEF1;
	Fri, 24 Oct 2025 13:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761312827;
	bh=36Hmp3K068qUi4nYbEAo+khHScvPypuK4G3dx21o9qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jyqxt5ymPgIl6I3JMq8CK4O4oGGvcZBnBbt608ENkCYtrgLOdK0KlEfN0KcuHyE5s
	 Pl8u7Gz1nVAQfC05Y33XgIPe5aE7B/ySIH55vQfeX0uH/0GpJpwd8hL9Std0KAlX26
	 DEvA5ffXTd4w6d5XwPpSzcZD4Fhy7RmghxSTRaD8zkVQKYwdXze7/bfHcIgqZXRxG8
	 gfEpjpGEeqZ4Zi71FxRfm90cf8zXi6YrTmkTSN/oIKQo3QGoCpA68po3SvHLKX03nV
	 GdMoJBTuB1UcttY0T2fTc7/HROcfopqyrIYReLh+48tsU34P+Ia5Yfry2WEtrn5V/W
	 fu1vaOAZduamQ==
Date: Fri, 24 Oct 2025 14:33:42 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	sdf@fomichev.me, ast@kernel.org, daniel@iogearbox.net,
	hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to,
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v3 3/9] xsk: add xsk_alloc_batch_skb() to build
 skbs in batch
Message-ID: <aPuANsZ6_xj8YY3D@horms.kernel.org>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021131209.41491-4-kerneljasonxing@gmail.com>

On Tue, Oct 21, 2025 at 09:12:03PM +0800, Jason Xing wrote:

...

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c

...

> @@ -615,6 +617,105 @@ static void *kmalloc_reserve(unsigned int *size, gfp_t flags, int node,
>  	return obj;
>  }
>  
> +int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err)
> +{
> +	struct xsk_batch *batch = &xs->batch;
> +	struct xdp_desc *descs = batch->desc_cache;
> +	struct sk_buff **skbs = batch->skb_cache;
> +	gfp_t gfp_mask = xs->sk.sk_allocation;
> +	struct net_device *dev = xs->dev;
> +	int node = NUMA_NO_NODE;
> +	struct sk_buff *skb;
> +	u32 i = 0, j = 0;
> +	bool pfmemalloc;
> +	u32 base_len;
> +	u8 *data;
> +
> +	base_len = max(NET_SKB_PAD, L1_CACHE_ALIGN(dev->needed_headroom));
> +	if (!(dev->priv_flags & IFF_TX_SKB_NO_LINEAR))
> +		base_len += dev->needed_tailroom;
> +
> +	if (batch->skb_count >= nb_pkts)
> +		goto build;
> +
> +	if (xs->skb) {
> +		i = 1;
> +		batch->skb_count++;
> +	}
> +
> +	batch->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> +						  gfp_mask, nb_pkts - batch->skb_count,
> +						  (void **)&skbs[batch->skb_count]);
> +	if (batch->skb_count < nb_pkts)
> +		nb_pkts = batch->skb_count;
> +
> +build:
> +	for (i = 0, j = 0; j < nb_descs; j++) {
> +		if (!xs->skb) {
> +			u32 size = base_len + descs[j].len;
> +
> +			/* In case we don't have enough allocated skbs */
> +			if (i >= nb_pkts) {
> +				*err = -EAGAIN;
> +				break;
> +			}
> +
> +			if (sk_wmem_alloc_get(&xs->sk) > READ_ONCE(xs->sk.sk_sndbuf)) {
> +				*err = -EAGAIN;
> +				break;
> +			}
> +
> +			skb = skbs[batch->skb_count - 1 - i];
> +
> +			prefetchw(skb);
> +			/* We do our best to align skb_shared_info on a separate cache
> +			 * line. It usually works because kmalloc(X > SMP_CACHE_BYTES) gives
> +			 * aligned memory blocks, unless SLUB/SLAB debug is enabled.
> +			 * Both skb->head and skb_shared_info are cache line aligned.
> +			 */
> +			data = kmalloc_reserve(&size, gfp_mask, node, &pfmemalloc);
> +			if (unlikely(!data)) {
> +				*err = -ENOBUFS;
> +				break;
> +			}
> +			/* kmalloc_size_roundup() might give us more room than requested.
> +			 * Put skb_shared_info exactly at the end of allocated zone,
> +			 * to allow max possible filling before reallocation.
> +			 */
> +			prefetchw(data + SKB_WITH_OVERHEAD(size));
> +
> +			memset(skb, 0, offsetof(struct sk_buff, tail));
> +			__build_skb_around(skb, data, size);
> +			skb->pfmemalloc = pfmemalloc;
> +			skb_set_owner_w(skb, &xs->sk);
> +		} else if (unlikely(i == 0)) {
> +			/* We have a skb in cache that is left last time */
> +			kmem_cache_free(net_hotdata.skbuff_cache,
> +					skbs[batch->skb_count - 1]);
> +			skbs[batch->skb_count - 1] = xs->skb;
> +		}
> +
> +		skb = xsk_build_skb(xs, skb, &descs[j]);

Hi Jason,

Perhaps it cannot occur, but if we reach this line
without the if (!xs->skb) condition having been met for
any iteration of there loop this code sits inside,
then skb will be uninitialised here.

Also, assuming the above doesn't occur, and perhaps this
next case is intentional, but if the same condition is
not met for any iteration of the loop, then skb will have
its value from a prior iteration.

Flagged by Smatch.

> +		if (IS_ERR(skb)) {
> +			*err = PTR_ERR(skb);
> +			break;
> +		}
> +
> +		if (xp_mb_desc(&descs[j])) {
> +			xs->skb = skb;
> +			continue;
> +		}
> +
> +		xs->skb = NULL;
> +		i++;
> +		__skb_queue_tail(&batch->send_queue, skb);
> +	}
> +
> +	batch->skb_count -= i;
> +
> +	return j;
> +}

