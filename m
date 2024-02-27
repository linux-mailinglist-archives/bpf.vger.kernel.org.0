Return-Path: <bpf+bounces-22779-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8DF869DBC
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 18:34:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3199E285486
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 17:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B414AD0C;
	Tue, 27 Feb 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgA1Rji+"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D74EB4C;
	Tue, 27 Feb 2024 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709055023; cv=none; b=kHLhfSPvuUdyEi6SP3spmWY+xWmYrk9SFp+trNKdYVX5cVWl/NUQIQ5eYDYVXzSdvjgl0mxHlTLIHEMNPofP7RtfunNTz2ZS925PEUbb3j4mqcMR1i//BNnowVTQpQcUuHOVfXJjvRDmYIAkQ4Ooc8pYDg3UYF/GB3a6kWG4Q0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709055023; c=relaxed/simple;
	bh=opNj8uJCr/Tb4WxfMRjJhwMAcf5/pACNL+Q4Mev7Cw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsFxDuLllu+/aBY5sIa/73PZ7w3dzY6eF/ljqS2+ZDqtDPnOF/Ehbexbws/H0+504vgwZVQPGRomzYl89cXpsKCGIDP3RVh2kCHxPhkTVgbXzuDJBGQ6e+YKTB5BXXxP4N17R1dTx4/CknsyW3uBBXD89RLSxKp5YEs2x7DYcO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgA1Rji+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D64EC433C7;
	Tue, 27 Feb 2024 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709055022;
	bh=opNj8uJCr/Tb4WxfMRjJhwMAcf5/pACNL+Q4Mev7Cw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EgA1Rji+D/Ablygt+Cx1BbkVpIY+lWKtIEv2AkQ361p4wdE2Ltup8alEiIw64KmTx
	 pN6PCQGch5OnoffDGFZiboNsBO5d+4TvRpWGJZOFZBR6sDOIG28sp81oSi0APHJ1hD
	 9mwv3GOSEC92ESXEqrqW30B9a6MsLkZAFniGS1rhPYjrBXptt+qTaCBkpEl5w04a7r
	 CPOqG1VN+NaO+gU6z9uRdr6AOWGovY76tchybnTufl9oVme2FgdRpMXlT/tEbHXkAL
	 N+qCEp705Klqkoyue2yBhOeiQaUvGn66EnrR94i/oKwVLC1AO0DogNJ34wpcz8DZWt
	 HNAbFXpVVz5bw==
Date: Tue, 27 Feb 2024 17:30:17 +0000
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
Message-ID: <20240227173017.GG277116@kernel.org>
References: <20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com>
 <20240226172533.GG13129@kernel.org>
 <1c2fe59a-daf6-4486-84ca-5880222d24bd@baylibre.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c2fe59a-daf6-4486-84ca-5880222d24bd@baylibre.com>

On Mon, Feb 26, 2024 at 06:48:25PM +0100, Julien Panis wrote:
> Hello Simon,
> 
> Thank you for the review.
> 
> On 2/26/24 18:25, Simon Horman wrote:
> > On Fri, Feb 23, 2024 at 12:01:37PM +0100, Julien Panis wrote:
> > > This patch adds XDP (eXpress Data Path) support to TI AM65 CPSW
> > > Ethernet driver. The following features are implemented:
> > > - NETDEV_XDP_ACT_BASIC (XDP_PASS, XDP_TX, XDP_DROP, XDP_ABORTED)
> > > - NETDEV_XDP_ACT_REDIRECT (XDP_REDIRECT)
> > > - NETDEV_XDP_ACT_NDO_XMIT (ndo_xdp_xmit callback)
> > > 
> > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > ...
> > 
> > > @@ -440,6 +476,27 @@ static void am65_cpsw_nuss_tx_cleanup(void *data, dma_addr_t desc_dma)
> > >   	dev_kfree_skb_any(skb);
> > >   }
> > > +static struct sk_buff *am65_cpsw_alloc_skb(struct net_device *ndev, unsigned int len)
> > > +{
> > > +	struct page *page;
> > > +	struct sk_buff *skb;
> > nit: please arrange local variables in reverse xmas tree order,
> >       from longest line to shortest in new code.
> > 
> >       This tool can be useful: https://github.com/ecree-solarflare/xmastree
> 
> You mean, for the new functions introduced in this patch only ?

It's a bit loose. But generally the idea would be to move towards this
practice. So for new functions: yes. And when modifying old ones old ones:
if possible.

> > > +
> > > +	page = dev_alloc_pages(0);
> > nit: Maybe dev_alloc_page() is appropriate here?
> 
> Absolutely.
> 
> > 
> > > +	if (unlikely(!page))
> > > +		return NULL;
> > > +
> > > +	len += AM65_CPSW_HEADROOM;
> > > +
> > > +	skb = build_skb(page_address(page), len);
> > > +	if (unlikely(!skb))
> > Does page need to be freed here?
> 
> Of course it does ! This will be fixed in the next version.

Thanks!

> 
> > 
> > > +		return NULL;
> > > +
> > > +	skb_reserve(skb, AM65_CPSW_HEADROOM + NET_IP_ALIGN);
> > > +	skb->dev = ndev;
> > > +
> > > +	return skb;
> > > +}
> > ...
> 

