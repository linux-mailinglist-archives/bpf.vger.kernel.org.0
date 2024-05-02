Return-Path: <bpf+bounces-28424-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D2B8B9471
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 07:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0973283D44
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 05:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BDC210E4;
	Thu,  2 May 2024 05:59:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F9208A5;
	Thu,  2 May 2024 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629544; cv=none; b=cOuvfXhTeVFPZarFD8BmLnVz8GZhdQP7tbwYPxz1ac0MM1lNQb1K57YkTlOXNfFSqUFeccIj80jViuV5GbZlQyPvFtGcUfAurOIto+iCrq++4HMpdl8W6YbEtGmBPK1kZoR6pQdxCbCyPfT4Kb2boDsQ74noZrIxO3/hA5DgDME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629544; c=relaxed/simple;
	bh=uO81lYAhJsX1xz8NuGgOK/Z1HciAOq/uegd6DHWh3UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leU8o9xwBpC1L3zHbcxqLeNjmm64yuKDMntKaU98P5wC4GYJSbrjaNOnJdtaMdK65DR+jph75f8Jox3okgCvivUIv78IFbu6lg5gRmRDTAxEoxA+DzPO3ly8G07TFelj9qqYnQUViYBSZgsdf6/1RcsPMfcICilpMRtpIibDPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83154227A87; Thu,  2 May 2024 07:58:55 +0200 (CEST)
Date: Thu, 2 May 2024 07:58:55 +0200
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
Message-ID: <20240502055855.GA28572@lst.de>
References: <20240423135832.2271696-1-aleksander.lobakin@intel.com> <20240423135832.2271696-7-aleksander.lobakin@intel.com> <81df4e0f-07f3-40f6-8d71-ffad791ab611@intel.com> <20240426050229.GA4548@lst.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426050229.GA4548@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi Alexander,

do you have time to resend the series?  I'd love to merge it for
6.10 if I can get the updated version ASAP.


