Return-Path: <bpf+bounces-26348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4332089E73F
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3544F281AEE
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B61388;
	Wed, 10 Apr 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8L5XQ7U"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBC391;
	Wed, 10 Apr 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712710170; cv=none; b=Xuv8OF5z86YiYux7zIhE6Nh5CCgiGPtNuKvjfFdET9jMz3TGNgVJkksiQB2+zad5vh5/fJErxEBpeFIK4W0vRo83DS6M2D26P85CD+09XwOeFROrw2GfI0cD0qSIrCl7tcFxg3iJOtoSuhiSHHd6X7Uu+dndr1hiGW3w4QIsT7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712710170; c=relaxed/simple;
	bh=4dQCSPVGdX7rBPcNynyhRW6/uaF2WhuiAp6auxw113o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/BzGEnSVKRgcyhmn8saSGjQBxkCc+7IO1bN5wr5nfqZCHZrYFdIaMP6o6LxCk3XkA4U6NWqx5RErWtL6zFPsS0O9I1DzEv6blmUSrA3STL4vWe7sWdDlTx8o5JRryd3HrGCObjR5WuHcqClg46+Y6PiZLyoi3vGNv9q0+qPZEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8L5XQ7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246CAC433F1;
	Wed, 10 Apr 2024 00:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712710170;
	bh=4dQCSPVGdX7rBPcNynyhRW6/uaF2WhuiAp6auxw113o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N8L5XQ7Uyt1p7D86PM0X9FaE6vHZHDfNfuH9YFuO+/Jv+9nv0C8w2nqJoGRT5rWu8
	 j9BBJDcdPfGXM1lFTqzgL/VqFo1kuEcQFTHzbOJhPlyXc+ZiRpTQDK7XOFDQynMD7Y
	 cIH3sJPdfzwxouZTNEZN85j5odVTZPHNHqnG4NJHQCrYf4v86s+FxIe0Z2htkcO80N
	 hlOGZqLDF6eCcf0jGutD0n3JVP4DVNhd/gwuzZlV2h5qr7I809K7D9AGFj8ASa6uFL
	 Reh8saRGPvMjhqmzqhPTLpvcqEf2S2pVFao+QbNSfqtRvHU5lD4/2xyVvI2ci1kier
	 OwSq0tEYCqMUw==
Date: Tue, 9 Apr 2024 17:49:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Julien Panis <jpanis@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell King
 <linux@armlinux.org.uk>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Ratheesh Kannoth <rkannoth@marvell.com>, Naveen
 Mamindlapalli <naveenm@marvell.com>, danishanwar@ti.com,
 yuehaibing@huawei.com, rogerq@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH net-next v8 3/3] net: ethernet: ti: am65-cpsw: Add
 minimal XDP support
Message-ID: <20240409174928.58a7c3f0@kernel.org>
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v8-3-f3421b58da09@baylibre.com>
References: <20240223-am65-cpsw-xdp-basic-v8-0-f3421b58da09@baylibre.com>
	<20240223-am65-cpsw-xdp-basic-v8-3-f3421b58da09@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 08 Apr 2024 11:38:04 +0200 Julien Panis wrote:
> +static struct sk_buff *am65_cpsw_alloc_skb(struct am65_cpsw_rx_chn *rx_chn,
> +					   struct net_device *ndev,
> +					   unsigned int len,
> +					   int desc_idx,
> +					   bool allow_direct)
> +{
> +	struct sk_buff *skb;
> +	struct page *page;
> +
> +	page = page_pool_dev_alloc_pages(rx_chn->page_pool);
> +	if (unlikely(!page))
> +		return NULL;
> +
> +	len += AM65_CPSW_HEADROOM;
> +
> +	skb = build_skb(page_address(page), len);

You shouldn't build the skb upfront any more. Give the page to the HW,
once HW sends you a completion - build the skbs. If build fails
(allocation failure) just give the page back to HW. If it succeeds,
however, you'll get a skb which is far more likely to be cache hot.

> +	if (unlikely(!skb)) {
> +		page_pool_put_full_page(rx_chn->page_pool, page, allow_direct);
> +		rx_chn->pages[desc_idx] = NULL;
> +		return NULL;
> +	}

