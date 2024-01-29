Return-Path: <bpf+bounces-20545-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ACB83FE04
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 07:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40376B21CFE
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 06:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D624C3BB;
	Mon, 29 Jan 2024 06:11:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6BF45BE8;
	Mon, 29 Jan 2024 06:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706508702; cv=none; b=soDO5bk7r5Qb/pbQSuedH5quWexZbsdxWSw1TUhzckux3xUwYZY4miIaYH9Gea8oUiYkTACPnG520KFXNnyGHj0KbhY9iJcTV/pXEXgt5YhZ6Nms3JCM9qSP+t0Szp+JXtMMdTNHp+6D8uZEdmUM88GFrtPuzhwZaBn3dAXxJtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706508702; c=relaxed/simple;
	bh=LcxMe8nXcndnUrfBfP/5djB7IjR0n6rkBIDeoH73Ly4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mel6zIdeumNQxWqigMQOEmw4Fw/SMJhKdWHVosMC35qbNUOXPr3Eg3qkGGbpRfRAXuMMcNjvW27L4Hy7Tsr02kGT1aOdB8x39Ye7KTIvQTObmUZZ9xeLsMwuQ1VgG0b0pih7q8ymEsJTjgC2kWpB00hxiqKWqZDElpy9h1QgWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8165668B05; Mon, 29 Jan 2024 07:11:36 +0100 (CET)
Date: Mon, 29 Jan 2024 07:11:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/7] dma: compile-out DMA sync op calls when
 not used
Message-ID: <20240129061136.GD19258@lst.de>
References: <20240126135456.704351-1-aleksander.lobakin@intel.com> <20240126135456.704351-2-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126135456.704351-2-aleksander.lobakin@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 26, 2024 at 02:54:50PM +0100, Alexander Lobakin wrote:
> Some platforms do have DMA, but DMA there is always direct and coherent.
> Currently, even on such platforms DMA sync operations are compiled and
> called.
> Add a new hidden Kconfig symbol, DMA_NEED_SYNC, and set it only when
> either sync operations are needed or there is DMA ops or swiotlb
> enabled. Set dma_need_sync() and dma_skip_sync() (stub for now)
> depending on this symbol state and don't call sync ops when
> dma_skip_sync() is true.
> The change allows for future optimizations of DMA sync calls depending
> on compile-time or runtime conditions.

So the idea of compiling out the calls sounds fine to me.  But what
is the point of the extra indirection through the __-prefixed calls?

And if we need that (please document it in the commit log), please
make the wrappers proper inline functions and not macros.


