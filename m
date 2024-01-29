Return-Path: <bpf+bounces-20544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CD583FDFC
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 07:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456961F22CF9
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 06:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56227481B9;
	Mon, 29 Jan 2024 06:09:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32FA4C60B;
	Mon, 29 Jan 2024 06:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508593; cv=none; b=tv9uOq5Ofed8Mdqc4wszcO2MR+QL7lAiied1jbBXjlOmht7WsGGqOHMocu02zt+PlwOG9lf2Pv7IJTsQOJWWCcJe6FyTbbJaa6gebZXgfRj+9+PwrDuWsaRgmCrbq0s7z6JcEx2od5zN9Kox1O3goWVY9hZc8x6yWZPvebydfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508593; c=relaxed/simple;
	bh=fHF9zvpHCMx5CBMtV4x2qjE8Os/bWEdv7JcnskjEfj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peUa4pQWVYAQXXKW2d4nKE+GAufNFKrAwKSdLCbzJ6IxIFgfltjC0MrBQq8m3OXZu0J1kwIv3F56rRvTVCRwWFlgenUQ/MMcD8RM9aDmAJRCjSOSM4V0ff9BXSJrPDJ7mKrvEwixKoFTGms6Fp3vuTY+9xM2faINa3ETeYmWqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C292668B05; Mon, 29 Jan 2024 07:09:47 +0100 (CET)
Date: Mon, 29 Jan 2024 07:09:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/7] dma: avoid expensive redundant calls for
 sync operations
Message-ID: <20240129060947.GC19258@lst.de>
References: <20240126135456.704351-1-aleksander.lobakin@intel.com> <20240126135456.704351-3-aleksander.lobakin@intel.com> <0f6f550c-3eee-46dc-8c42-baceaa237610@arm.com> <7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com> <0cf72c00-21d9-4f1a-be14-80336da5dff4@arm.com> <20240126194819.147cb4e2@meshulam.tesarici.cz> <1c62d388-a600-40d8-b386-15841cb1af95@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c62d388-a600-40d8-b386-15841cb1af95@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 26, 2024 at 07:13:05PM +0000, Robin Murphy wrote:
>> Can we have a comment that states this assumption along with the flag?
>> Because when it breaks, it will keep someone cursing for days why DMA
>> sometimes fails on their device before they find out it's not synced.
>> And then wondering why the code makes such silly assumptions...
>
> Indeed, apologies if it wasn't totally clear, but I really was implying a 
> literal "may skip sync if coherent and not using SWIOTLB (which matches 
> dma-direct)" flag, documented as such, and not trying to dress it up as 
> anything more generic. I just can't suggest a suitably concise name for 
> that of the top of my head... :)

Yes, that seems like the right way to go.


