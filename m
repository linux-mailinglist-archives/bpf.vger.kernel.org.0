Return-Path: <bpf+bounces-28778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4938BDFF2
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 12:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6981F25765
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 10:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1361514F9C3;
	Tue,  7 May 2024 10:41:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165BF14EC4D;
	Tue,  7 May 2024 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715078482; cv=none; b=k1nbd0JYXgkZW2y66eiCahQI5EqZ0bEOi3xTzC2CdQEMBhgz0WNBxAXd3Se+kX2380s4ckX72ckP3zf8s6Uzv9SB99hq7kJFJ5N3HuS4jM0Zqz48UCC4i4CEZ4XkAJLENDjYMNblXIwo36JXfwskB7FoZPvbZP3cbqbs2BojPJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715078482; c=relaxed/simple;
	bh=k19UIoVzfb6WaHcLncGqEWmOOqziApTj+I8zVsWYhdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aSxu23Yg7wXCQ0tuVia5PJTeHzt8TO/tp/gtVxQTZY8GEcTFGnIwH0S677FQVDY6Sr/1MRw2/fT4FnmbDkEQhXrY3ST5UOelPmbiHxPNm8RazjPambddnZdNgagUosFybVLUkxiqN+KqcwOl9bWp2QJxLO4hwVzK7Xd/AEARtOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06418227A87; Tue,  7 May 2024 12:41:16 +0200 (CEST)
Date: Tue, 7 May 2024 12:41:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 6/7] page_pool: check for DMA sync shortcut
 earlier
Message-ID: <20240507104115.GA21875@lst.de>
References: <20240506094855.12944-1-aleksander.lobakin@intel.com> <20240506094855.12944-7-aleksander.lobakin@intel.com> <20240506115043.GA28172@lst.de> <e9a8d649-40b0-4595-a702-9fd8164e5326@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9a8d649-40b0-4595-a702-9fd8164e5326@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 07, 2024 at 11:51:46AM +0200, Alexander Lobakin wrote:
> My CI fails now fails to compile this patch when !HAS_DMA. Let me fix
> this, rebase on top of your tree and resend?

Ok.

