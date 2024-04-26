Return-Path: <bpf+bounces-27890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC9D8B2FA3
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 07:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD7B1F23122
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 05:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4755513A265;
	Fri, 26 Apr 2024 05:02:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7442F36;
	Fri, 26 Apr 2024 05:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107760; cv=none; b=t6PB7I4/7TnaiU42VltRPMxnRPGt9Avu9O01ZpBlzoBJwPvgmINeoRIXEnlhk3qKuSr1MK/ZDmutGqLJycCKemlQl4sCdsPOokKnOOnwzfHEkSav2QhMKq3XjVbHSyPhSC3B6FuqmHBTRtUwlSZ7RpnCKLTqbqMSdhMc0dLrO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107760; c=relaxed/simple;
	bh=M63h01ngfO3MyMvYCVDmxUFcqBJ/vp/JP5oOD/9VEh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDOx4t04ddfk+J423+8GFLjSn6enHRCGVvyR7QcZu5z2u9v304ZRHBkYbxOmxEk5xBkOlhJOTocTlrjHydSb/W7QwkycYwThHO4bk9mTxJGPAnpsX4KoJl7uNAYTNWmb1gpE3Lex+fJfcktzPhAPisCP9BqPrWpvswVOoHg3tM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02490227AA8; Fri, 26 Apr 2024 07:02:29 +0200 (CEST)
Date: Fri, 26 Apr 2024 07:02:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 6/7] page_pool: check for DMA sync shortcut
 earlier
Message-ID: <20240426050229.GA4548@lst.de>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com> <20240423135832.2271696-7-aleksander.lobakin@intel.com> <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Apr 24, 2024 at 10:52:49AM +0200, Alexander Lobakin wrote:
> Breh, this breaks builds on !DMA_NEED_SYNC systems, as this function
> isn't defined there, and my CI didn't catch it in time... I'll ifdef
> this in the next spin after some reviews for this one.

I looked over the dma-mapping parts of the series and it looks fine
to me.  So please resend as the fixed up version as soon as you fine
time for it.


