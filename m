Return-Path: <bpf+bounces-29181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3148C8C10A7
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DE91F21E85
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 13:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A423215B543;
	Thu,  9 May 2024 13:49:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3A158D6D;
	Thu,  9 May 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262573; cv=none; b=cUlVqsum4ut3DDlkFeZ9I4MQHXcLo9f4r87XLY8Lvb3/Y/SQyr0Q7pJNA+74IpxLLHspFLqg3173p7pwohU0tOmctpQrWrCKz/QCJv2nvLx6UcJbzRVZUPrkpVLhJmuEwXK1/WvglBBlG6KmOIn53dwsKpxIaL+6peHsiyDBloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262573; c=relaxed/simple;
	bh=sxUDcgV07M/cGG0C97HjP7lXVYLr1LRz4Tn9UlCqtIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/rUEUHWWvbqp8lmxoumgwcvSCX+S+F2/2Xsxke7yqVszJEIHsxGAZDOYgsDxWmNl1w71VltxtVgxP5Nbe3VwUTtMKcVObHRPZJiPauU+v5dc1x1wGJqlXnpINILYIbu1uMEAVKSUN2b+cYx0K5kbHt7WNYRXaOUUQmKALJiny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 69F6068BFE; Thu,  9 May 2024 15:49:25 +0200 (CEST)
Date: Thu, 9 May 2024 15:49:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Steven Price <steven.price@arm.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] dma: avoid redundant calls for sync operations
Message-ID: <20240509134924.GA13607@lst.de>
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com> <20240507112026.1803778-3-aleksander.lobakin@intel.com> <010686f5-3049-46a1-8230-7752a1b433ff@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010686f5-3049-46a1-8230-7752a1b433ff@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 09, 2024 at 02:43:52PM +0100, Steven Price wrote:
> The specific drivers are "rockchip-drm" and "rk_gmac-dwmac". Is it a
> requirement that all drivers engaging in DMA should call dma_set_mask()
> - and therefore this has uncovered a bug in those drivers. Or is the
> assumption that all drivers call dma_set_mask() faulty?

That was the assumption behind the code, but the assumption is wrong.
Alex is working on a fix.


