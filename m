Return-Path: <bpf+bounces-29171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320D8C0F1E
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCD4282DE1
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 12:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B03514B097;
	Thu,  9 May 2024 12:02:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0F726ACD;
	Thu,  9 May 2024 12:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256125; cv=none; b=AWrIq+pWWkJ7B+OyxgfExpfgaZTYRlhVzUyp3OVBne3YoGzzsnHQdKYuullM/y1NFLo7Arg9Vn8qIdmHjyEz6syvbMHZ+yW0pvnXso3HSgZGmH7mMzvy+CN3myK8OW6o+o/Kubuag7CKESTNw7dKtm5cW+AqrHMEUln1jOte8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256125; c=relaxed/simple;
	bh=QXydRQK2hd97r4QfdIZV5NUri6+XgrjmwdtEZTDxDT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S5W9+npXlxrIo+6QyYB7K5GCSik5exWmsVfG05Tc8KG4/nXLK4kfhIoUxMqw83LMlrvh2TrdCjFgrdJ6HgYisuO8aQYioSTOSBhn0PxoYn+pD0G0YEqJU2hp+uYpR8qtMF6Cvh5FKaHwJRgoJAQ6+1wx4woMRgTZWGnw1ag1RPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 53745227A87; Thu,  9 May 2024 14:01:50 +0200 (CEST)
Date: Thu, 9 May 2024 14:01:49 +0200
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
Message-ID: <20240509120149.GA11327@lst.de>
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com> <CGME20240507112115eucas1p117bc01652d4cdbe810de841830227f47@eucas1p1.samsung.com> <20240507112026.1803778-3-aleksander.lobakin@intel.com> <46160534-5003-4809-a408-6b3a3f4921e9@samsung.com> <b4632761-3ec6-4070-a60e-b74c1bfdd579@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4632761-3ec6-4070-a60e-b74c1bfdd579@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 09, 2024 at 01:44:37PM +0200, Alexander Lobakin wrote:
> If I remember correctly, *all* device drivers which use DMA *must* call
> dma_set_*mask() on probe. That's why we added it there and didn't care.
> Alternatively, if it really breaks a lot of drivers, we can set
> dma_need_sync = true by default before the driver probing. I thought of
> this, but the correct approach would be to call dma_set_*mask() from the
> respective drivers.

No, we default to 32-bit DMA for a lot of busses for historical reasons,
especially platform devices.


