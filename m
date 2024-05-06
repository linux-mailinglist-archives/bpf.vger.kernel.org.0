Return-Path: <bpf+bounces-28668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454468BCD30
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 13:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022D6282FE6
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E9014387A;
	Mon,  6 May 2024 11:50:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05D143861;
	Mon,  6 May 2024 11:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996251; cv=none; b=hwPaG0RmqgbBkzNx6pSyDx53UQwmR4EElWuAZWWneksr9dEkflGSHBaXDWzNyHKZoB5cCe1e7yAGNUKIV5hK33pB82ppK93yvADyZQTy3WW1b+EMinzQUYoc2DGlIMITQLzXW3Dj2HMxAx3+94SUmL0Yod65sJYihHtB3Ly33W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996251; c=relaxed/simple;
	bh=UhB4HZ+P2YfvxSVM/QJ2ErvXSXngpikLOwkSKt9OKj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wv8LwRyhpw/xe0cNMxfRHB1ks77R/KyDKjThwTsUq9+uiEF/blMjWJYDyxB6UfBLsfmRTKC4NbfZ2f5RgiudE7kS+cyP0p74p6JLXHfAe+ho2KVNlZkkjReOlNFZtGRLFNMpckyvJG6296OCovWVThfakwBSTBsFWdfQjlIlMFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 172A768AFE; Mon,  6 May 2024 13:50:44 +0200 (CEST)
Date: Mon, 6 May 2024 13:50:43 +0200
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
Subject: Re: [PATCH net-next v5 6/7] page_pool: check for DMA sync shortcut
 earlier
Message-ID: <20240506115043.GA28172@lst.de>
References: <20240506094855.12944-1-aleksander.lobakin@intel.com> <20240506094855.12944-7-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240506094855.12944-7-aleksander.lobakin@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The first hunk here fails when trying to apply it to the 6.9-rc6
based dma-mapping for-next tree.

Should I go ahead and just apply the first three patches?  Or do
we need a shared branch with something?

