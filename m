Return-Path: <bpf+bounces-22062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAF18559F5
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 06:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11E11C22AD9
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 05:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 346D19475;
	Thu, 15 Feb 2024 05:07:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DB9D527;
	Thu, 15 Feb 2024 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707973622; cv=none; b=hOij3cjqf6le6zFxN0o2PaqRzRjilytI7duyerKwVRXPbyX1aMde5rdrcjydStDrZtjLrV/QndCodWoMIR+1XZE09KnJYGtH34IGqW5pZEhAgNj2XMOBFe/BrJ4k8HWtpXN8oTHiaTQsKmqKRntpcmLk1oY+HnL4me7SJ565I/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707973622; c=relaxed/simple;
	bh=5re37oOePDTxHjW5+SSD0nC43vuOZ1VTWg1epuIetnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zv2YcGim448uE3+MYek+CCh20BuoaEz0/x7rH4ogK+ZbilYVkSwZ2QsQB/o6jZHBizYw33P2u53BRDOEHfzDn7PXDjJLEP4l2+Jxayaz3xxVpiju5sBHcb+xbqIzMb3B7o3Uww8xewSq2OgD9KuwftNVvGc7H5DpsdLuOcgFxAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 952B567373; Thu, 15 Feb 2024 06:06:57 +0100 (CET)
Date: Thu, 15 Feb 2024 06:06:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
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
Subject: Re: [PATCH net-next v3 1/7] dma: compile-out DMA sync op calls
 when not used
Message-ID: <20240215050657.GB4861@lst.de>
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com> <20240214162201.4168778-2-aleksander.lobakin@intel.com> <fba9018d-3783-4d3c-8948-409d7d5258d5@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fba9018d-3783-4d3c-8948-409d7d5258d5@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 14, 2024 at 06:09:08PM +0000, Robin Murphy wrote:
> On 2024-02-14 4:21 pm, Alexander Lobakin wrote:
> [...]
>> +static inline bool dma_skip_sync(const struct device *dev)
>> +{
>> +	return !IS_ENABLED(CONFIG_DMA_NEED_SYNC);
>> +}
>
> One more thing, could we please also make this conditional on 
> !CONFIG_DMA_API_DEBUG so that that doesn't lose coverage for validating 
> syncs?

Agreed.

