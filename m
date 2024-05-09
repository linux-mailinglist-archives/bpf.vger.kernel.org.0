Return-Path: <bpf+bounces-29172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6448C0F23
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 14:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0F07282CBF
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 12:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DDD14A62A;
	Thu,  9 May 2024 12:02:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE97414A90;
	Thu,  9 May 2024 12:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256146; cv=none; b=HQUppc4PLoZockH1QNYfBmgSOkAewyEnCDSy7zpVXAZv80l9elN2nhGc3TKpQzaaN6EnV4FNVVvOmRHLxQRO4z5BqrfLFW/er8LybqXJZly0JZv7fVZH4+OO+a7iuQLEEdWpwcWiINAKvqsjOYHS/s0Y05jAS3eL/e98q464bWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256146; c=relaxed/simple;
	bh=X2WOAQIVZvh19O6igpf5MGMHAkbbgGN0l/hQaACG2IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyVqTEKEm75PBfr7j7B9+iwC98DxFf105U0FeAPOKd7V7YSN6sSk9biXqXGRLymWUC7EfUTM+mHGwcB13vEr8WYuHWMGkDR7miO+5+53meZtwr2R+eXzqR3WF8rtL/M0GyRn29TnPoa1SXJTDvkNNAnoHOqf7r3c/amFqG4agik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4AED8227A87; Thu,  9 May 2024 14:02:21 +0200 (CEST)
Date: Thu, 9 May 2024 14:02:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] dma: avoid redundant calls for sync operations
Message-ID: <20240509120220.GB11327@lst.de>
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com> <CGME20240507112115eucas1p117bc01652d4cdbe810de841830227f47@eucas1p1.samsung.com> <20240507112026.1803778-3-aleksander.lobakin@intel.com> <46160534-5003-4809-a408-6b3a3f4921e9@samsung.com> <b4632761-3ec6-4070-a60e-b74c1bfdd579@intel.com> <3dce41a3-e5a9-43e7-b918-ecb8d688ea1c@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dce41a3-e5a9-43e7-b918-ecb8d688ea1c@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 09, 2024 at 01:59:41PM +0200, Alexander Lobakin wrote:
> Or invert the flag, so that false would mean "it needs sync" and it
> would be the default if dma_*mask*() wasn't called.

That is probably the safest option.


