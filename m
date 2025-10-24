Return-Path: <bpf+bounces-72148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC6C07D17
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8157D1C20C0B
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0387B34BA54;
	Fri, 24 Oct 2025 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEDQw34p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0868734BA2B
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331768; cv=none; b=kNV1d0l5mrUPmEm1H52OFexQGMw8i9sSPtJ+Gnwr4pdH7f+pp/Bcg3Jo0mzsuUU6tlJbqUuWnRLqD0eIAlFRSb8/F5NWsvjZmwaYQyxd4iXAObsGxyBcvV3w2bTryzCkxPAKtrRnfFr4H2wA2oIFJx5R+hWmTvleZp9ntUyhY5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331768; c=relaxed/simple;
	bh=9OAJrpwPzl4HGRkU45vDY66wUHd7GQ/097gNeGpkgSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwG/2o1b4lDi/f8zD59wwfzlszDnbxx5jG2vpWYLIJN+k4MBleC2qYzyQNTpiwiYZtwaiHRvN5PIyt51rWi4uczRmEphQ1wMZctI7ZJhcNMY8YFkx1RhgKyPXZ64+/jSD4WYBKs0KSE7X5snufLhVu41Qhq20JFXaVIDgHJXMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEDQw34p; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f5d497692so2940625b3a.1
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 11:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761331766; x=1761936566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8uwBvkrN4z1ERe0y1FsgiwQIgdWY2Fm+gyvMoJUcSg=;
        b=GEDQw34pYpm3E/7cIgSR/hAuBqslpvUe2PMcG2vrSAk/srXwiMqmNcbDursuJe3c0X
         mjo+cgbME+P0zDhAhNZLJ+4DY/+0C8suac/TFa/d7tNcmE62j8Y61e2IKvdur5VZcj2h
         fDduqLhgAgfy6BsRNL6wSZh14Z66DZjPbYISzfiICnpgY/iOJQnJQ7TBMJJPbhW56+/q
         lzsiirRSg3DI5NM5mnixb+kdkCDpiGnn9/xAQHrR9kNf5+Q+w7SwM9kBdV0D89w7Fwt2
         LTkVvubj6jXpCLFrxo3PJDpccUgcrvMgPY8HG6pKNiw/vvoy5p5I8mwImFGMQ0CBfu0k
         rU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761331766; x=1761936566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8uwBvkrN4z1ERe0y1FsgiwQIgdWY2Fm+gyvMoJUcSg=;
        b=FrhzZXJvOoknebY6PBB2vIGEM7rlJx4t1Hsk6m8yLgAoR7OiHI9jEXCRg8jvWcSVvD
         sQ3OYjHTyKPHomUeOlFYSRT4O52kuXH0nfpRzWASQ1TbXAOr+MkwvC6vKLQsVjP2xTyn
         pRNfLBuvIhvHGbrp0cURA2VWPXi0lFVXrKyD30+lg91OhvhCaFiF9wU1PNTp+zoxn5bf
         kOwnV387zpuqw0yx39IV1kgkpkNH0MM0nxQThjqOESJJvPbZjO9V6DXeY/6+dyke07dN
         H6eXbEX8dTGwbk+qASqaO4G6phhUFPzrqBDv0444seqAleeW3mOU3bkeUjJeX/9Zat+C
         9t1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzvxMznsM+sxjL931yEVrBtwM0Jkj9TbY7CkQfA+2YtF3L2hqkdByu8E+6Hcur85LHXFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeiwNy3cPENUQ8/FBDNom4FlzApe84eilMEekNuLCDYVM/cEUU
	2ky8SXbiJDhL5g2cGXxEog2si1IcYBEXXDh+6iEA88Bp6IJddfLmMAo=
X-Gm-Gg: ASbGnctmm49N3JxA+a0h0xiZ/7IZFdTuN4w2xpba7F9Y80jSfnt4fdBXvSo2n01VVsD
	Jr5uGXqtW0sABywJQbr2Yrc/7eo6HTgLmwhwX7i/Np/RzI3rG3XeyP0kPPWZVxl85Z4BVjjGMlJ
	iC0hrgdutWr5iADyx4mmD/IjBVg1IQGgvxRYGSTgzhPTz1caRShcGU8WFgIR7vD2jDU65tRumiO
	sNuJGTG5bZ7Q7KpS57Cnrsk1xzENQErWCeyTsuZ+6q2/hLc5ZG3b7pWxvRc9YkVtVxhu+iTE4bZ
	KJ1N+KGyvCcoWUFGJvFZUx0M4FDKNPCd8iaW8QgWvyo1jfBn7J0OUoZ0HJ6g6mzGqbIj0RF1ftV
	5L4iVqteXwkuFfWG1Z+z71EgSLaV7BveRbAr2z5Bj5OjX+2/1a7hGEeCzmTkp+kOtmhpKwrwqjR
	iBLx+8VkSHVNbwg/RMpSQ5IabZ8bQMXbM+gNq4RPgWUsntjZFsPHuaHzPfjOsMDxXRX0sL9uViX
	xFRW1nWlIpyfQVRpBjjTi102b0M/vXj3+VRsq0rsTP4sSN64YpBB3IYP5pIaA+Fzt0=
X-Google-Smtp-Source: AGHT+IGsn+zJ+Chhg2sIUKUpGqm+Ej5PJ1ZPkvdgc+szauI7og7ciysiYZDs26a0/miBsx7EFB995g==
X-Received: by 2002:a05:6a20:1585:b0:334:847c:dd3d with SMTP id adf61e73a8af0-334a864febdmr41446224637.54.1761331766075;
        Fri, 24 Oct 2025 11:49:26 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7a274b8a0edsm6645874b3a.35.2025.10.24.11.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:49:25 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:49:24 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
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
Message-ID: <aPvKNAZP8kKolwIm@mini-arch>
References: <20251021131209.41491-1-kerneljasonxing@gmail.com>
 <20251021131209.41491-4-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021131209.41491-4-kerneljasonxing@gmail.com>

On 10/21, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Support allocating and building skbs in batch.
> 
> This patch uses kmem_cache_alloc_bulk() to complete the batch allocation
> which relies on the global common cache 'net_hotdata.skbuff_cache'. Use
> a xsk standalone skb cache (namely, xs->skb_cache) to store allocated
> skbs instead of resorting to napi_alloc_cache that was designed for
> softirq condition.
> 
> After allocating memory for each of skbs, in a 'for' loop, the patch
> borrows part of __allocate_skb() to initialize skb and then calls
> xsk_build_skb() to complete the rest of initialization process, like
> copying data and stuff.
> 
> Add batch.send_queue and use the skb->list to make skbs into one chain
> so that they can be easily sent which is shown in the subsequent patches.
> 
> In terms of freeing skbs process, napi_consume_skb() in the tx completion
> would put the skb into global cache 'net_hotdata.skbuff_cache' that
> implements the deferred freeing skb feature to avoid freeing skb one
> by one to improve the performance.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  include/net/xdp_sock.h |   3 ++
>  net/core/skbuff.c      | 101 +++++++++++++++++++++++++++++++++++++++++
>  net/xdp/xsk.c          |   1 +
>  3 files changed, 105 insertions(+)
> 
> diff --git a/include/net/xdp_sock.h b/include/net/xdp_sock.h
> index 8944f4782eb6..cb5aa8a314fe 100644
> --- a/include/net/xdp_sock.h
> +++ b/include/net/xdp_sock.h
> @@ -47,8 +47,10 @@ struct xsk_map {
>  
>  struct xsk_batch {
>  	u32 generic_xmit_batch;
> +	unsigned int skb_count;
>  	struct sk_buff **skb_cache;
>  	struct xdp_desc *desc_cache;
> +	struct sk_buff_head send_queue;
>  };
>  
>  struct xdp_sock {
> @@ -130,6 +132,7 @@ struct xsk_tx_metadata_ops {
>  struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  			      struct sk_buff *allocated_skb,
>  			      struct xdp_desc *desc);
> +int xsk_alloc_batch_skb(struct xdp_sock *xs, u32 nb_pkts, u32 nb_descs, int *err);
>  #ifdef CONFIG_XDP_SOCKETS
>  
>  int xsk_generic_rcv(struct xdp_sock *xs, struct xdp_buff *xdp);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index bc12790017b0..5b6d3b4fa895 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -81,6 +81,8 @@
>  #include <net/page_pool/helpers.h>
>  #include <net/psp/types.h>
>  #include <net/dropreason.h>
> +#include <net/xdp_sock.h>
> +#include <net/xsk_buff_pool.h>
>  
>  #include <linux/uaccess.h>
>  #include <trace/events/skb.h>
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

What is the point of setting i to 1 here? You always start the loop from
i=0.

