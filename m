Return-Path: <bpf+bounces-29197-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9788C11DA
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CED17B214D7
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C6E16EC01;
	Thu,  9 May 2024 15:19:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B916E893;
	Thu,  9 May 2024 15:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267949; cv=none; b=cOaPYjNxy+eMZ6ub95HLUxkANbTHL+Aw25YX2wfHI7h92MxYTHLODTrF0If1QHli3vHsrW0Q736vqlYd4mh7NCWXSQAjWr2EJweh76p1wRTjQETXtWKaGoFTJhK8L4nvwuM55Dh4Mck9m0ciCTPvhlo1uA8p6kl0Q2P805ZsyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267949; c=relaxed/simple;
	bh=5aL9wZ+3v1zrCPnnvPdqxIqX0SQD7VGQLpZb5iRs/9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwPjyGSGFxp6/ig0oEQHjh+g6dAbeCTO5Ku0p7P5Z9HaMRsLjd7FC4bRFD9LpilMVr8qPtT9CBxXVVU6gkV64k+UufUwMSDFfbaYJ5GuNOe+EGRmuswAA22TRv8IUomhee0L1B2p3xNl1IxTttzSurrWMbfBSfdyNjUfQ9NJ8Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B907268BFE; Thu,  9 May 2024 17:19:01 +0200 (CEST)
Date: Thu, 9 May 2024 17:19:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Steven Price <steven.price@arm.com>, Christoph Hellwig <hch@lst.de>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: fix DMA sync for drivers not calling
 dma_set_mask*()
Message-ID: <20240509151901.GA15306@lst.de>
References: <20240509144616.938519-1-aleksander.lobakin@intel.com> <ce83b3b8-2246-4006-a111-f2da0740bd8e@arm.com> <6ce428e6-3585-4ef5-af08-debef0a7c308@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ce428e6-3585-4ef5-af08-debef0a7c308@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 09, 2024 at 05:16:13PM +0200, Alexander Lobakin wrote:
> Oh crap, it really should be f406. Wrong tree again >_<

I've fixed this up and added the Tested-by in my local tree.  I'll push
it out after a bit of testing.  More reviews or tested-bys are still
welcome.


