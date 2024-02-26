Return-Path: <bpf+bounces-22734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A272D867E65
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 18:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A511F2D2EC
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1712F38F;
	Mon, 26 Feb 2024 17:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFtUa+Tr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFE12F366;
	Mon, 26 Feb 2024 17:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968339; cv=none; b=ea7plVrNyYlLo4RCLX0pEFLMKD082szz5oQr0m2I1n2csaI+CGoFIXvz0zw83W6EwTdcTXPLGiikc2lM9T3UdJskrhco4hk+Q7Be9Q+o08emZiACUWG1msRzY7M//15uNar0ARCu3IIb/r7r/0PvXyaMiqehWqzY9dtJ7+FlyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968339; c=relaxed/simple;
	bh=hG1hhNEZQpoCC0ZUVla+4Zhhfd/60PsfYtOoSxY9E4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwsqBSqcDG7sXoiTUiFA5arYtK7AMAHjOEfXrjlf5nUw39aRjFW14kTpHOTKl8htRKlG3d1UPAmTjMY3sqDbqB76EeZ1gH94eZebyMcPwb7sJIa9lrc5tX0qSotQbpwQO/pGzdc6dATfyBzR6tOy6z25I19SPxyQoWgBUVpT5AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFtUa+Tr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C981C433C7;
	Mon, 26 Feb 2024 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708968338;
	bh=hG1hhNEZQpoCC0ZUVla+4Zhhfd/60PsfYtOoSxY9E4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFtUa+TrJXH8XiYxqXIqG52N70tW+5ZYRHjsIo0O5vnhGk7FNNY2Xh+WZ2f0hL4xs
	 QdwMS/ecbQ6bvKNeIYbyFjGh+3dyiREZ+UMz/D7hvP7rHIaUAvnikfo2OIZQcfx9k6
	 lEtyTeiPFnDqvdcOMnJnNbrc67Q+XKUsnTANcEoPffEBnkokAdn8jDqb4ma6ddlywD
	 3SSqb4YDjw3e/TwxNZ2F664qx/UR8Gzumtr6W42Wxivjcgi2taZx9U9KKiTqeEsPUt
	 E5XH5er16+1ce2mFMVTiSPNOPA9+kmphEI/lgKYo9mUAXgxMjTxv5t+gNfwMt7Nq2f
	 CidUS099rTBvA==
Date: Mon, 26 Feb 2024 17:25:33 +0000
From: Simon Horman <horms@kernel.org>
To: Julien Panis <jpanis@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: Add minimal XDP support
Message-ID: <20240226172533.GG13129@kernel.org>
References: <20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com>

On Fri, Feb 23, 2024 at 12:01:37PM +0100, Julien Panis wrote:
> This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
> Ethernet driver. The following features are implemented:
> - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
> - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
> - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

...

> @@ -440,6 +476,27 @@ static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
>  	dev_kfree_skb_any(skb);
>  }
>  
> +static struct sk_buff *am65_cpsw_alloc_skb(struct net_device *ndev, unsigned int len)
> +{
> +	struct page *page;
> +	struct sk_buff *skb;

nit: please arrange local variables in reverse xmas tree order,
     from longest line to shortest in new code.

     This tool can be useful: https://github.com/ecree-solarflare/xmastree

> +
> +	page = dev_alloc_pages(0);

nit: Maybe dev_alloc_page() is appropriate here?

> +	if (unlikely(!page))
> +		return NULL;
> +
> +	len += AM65_CPSW_HEADROOM;
> +
> +	skb = build_skb(page_address(page), len);
> +	if (unlikely(!skb))

Does page need to be freed here?

> +		return NULL;
> +
> +	skb_reserve(skb, AM65_CPSW_HEADROOM + NET_IP_ALIGN);
> +	skb->dev = ndev;
> +
> +	return skb;
> +}

...

