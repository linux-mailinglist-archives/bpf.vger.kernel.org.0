Return-Path: <bpf+bounces-22744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDCC868491
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 00:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8A61F22962
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 23:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CD3135A5F;
	Mon, 26 Feb 2024 23:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="u2VJUnCp"
X-Original-To: bpf@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A488133285;
	Mon, 26 Feb 2024 23:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708989524; cv=none; b=Jr9xNlIJWrKU2UQ1ZDpKDACgVq2wrkzh9kV8HizRYa/PSLopwhfBve82DUkMXjTvm7XIgJ7gcpACCJx29HLpJLuWHzT2u9dGuKpqQ8qZtuJYlDnhY2xaIyUojb6J/BI6JTAEoC229DCVORA1NBRvMxXXUzRhm+X5jgNrVhrNUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708989524; c=relaxed/simple;
	bh=RyR0GnuJRe7THA/MhNcC5QF7CUPey8a/ORFM9KGNV4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWdvJmgh+Q5HX7afBn+hpPPZ3KD7C/fWRVSwoxRz4ugZK3OUx31kmwzF6gniS4bZ8g+aOUxjnm6HUSicf7Z1n1PX82c72sbzR10JbvyJwpTeuV0xbheNhGCmRIDvmQ/9t9KDqMwpQRacjTMfkFmpDYyJZKoxoBNXL5p1pSS4Ouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=u2VJUnCp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g2q7Y6j0wCGTV4GevQ+ES5smo37GThY91C78pWGmQpw=; b=u2VJUnCpWA24Cmf1fN0w3E962R
	QE/KINpYUHDTH1tnNo5Sb7+K7nSN43PB3mvL29YKQNOqOgSOVN0Vik49pUcyV0oGOPMDDPT8uYNJd
	eznc6DyK3pVvqndBP+0ptOD+lr/RzNqIHuy+azL7oUNwuRCT9svn11R4h8ZrYKdS9c4Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rekFA-008lsR-HI; Tue, 27 Feb 2024 00:18:44 +0100
Date: Tue, 27 Feb 2024 00:18:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
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
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: Add minimal XDP support
Message-ID: <e382df16-c78a-448d-b6d5-39a627b30652@lunn.ch>
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

> +static struct sk_buff *am65_cpsw_alloc_skb(struct net_device *ndev, unsigned int len)
> +{
> +	struct page *page;
> +	struct sk_buff *skb;
> +
> +	page = dev_alloc_pages(0);

You are likely to get better performance if you use the page_pool.

When FEC added XDP support, the first set of changes was to make use
of page_pool. That improved the drivers performance. Then XDP was
added on top. Maybe you can follow that pattern.

      Andrew

