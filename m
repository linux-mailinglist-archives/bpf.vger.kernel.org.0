Return-Path: <bpf+bounces-51294-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDEBA32EF0
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 19:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4979D1888DE2
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D58F260A4E;
	Wed, 12 Feb 2025 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RQsJzdIo"
X-Original-To: bpf@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F0D25D558;
	Wed, 12 Feb 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386427; cv=none; b=lceoWFLwHKmyyu6UA/Izs2K62msy/d4wEhzPjASGXsUhIg5LuH0C1JLWHmzWLa5qkX5UAGvkY4aeGTp9ETmcfwUeAgq1dsHKsapLo+49ix9b7n1YFXTTwqtKDkznEjPwf91cZ+RJn8x5KtB3JXNZ80JqxeyQVHFMRR0cfM3RM0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386427; c=relaxed/simple;
	bh=5tJWQW682yVJHOELemxqrvB3V23kM6i2rx1d75/VJ70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryngTr32FwviBEiGkWtW4PkILev51JlYQVx6NkFta+MFD6MZLr5bgie1jk5/sQ+4Rysbg2tVC+z2OPrurT7xPCzQYMxEvQBTit2RmtnmQHidsxUULTlcF5lYbQ56qg9A/9ltvxQPxCNJpJsEr4CERARq/zZq7jSYRnRk2RMzfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RQsJzdIo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oUOokMrKASXdzZOA3VRoZ7fdfSIasrczhgZC+ARdsyE=; b=RQsJzdIo4sjdvkb3W0fwkdFRaa
	O57YRtnEq+Dfi18rN1QQwUuBy8dYpnMr5IQlIOiChqEyQR5T5MXOqbangz7v/EBYWW/HkX+P8uxVd
	idVVcsVuC1PGXaAK7beZ2GFCmN9Y3Y8pSbs17s98gPhCfsWxM/EmI7xjeGTmmG7zZ3FYar1vcZ1GW
	h55laSfKYbPWaVvzr2P1udrViDnu1von3OwcqpmZgx3g3jQPH5tdQFFtQN3ZwqwAF5L+Oug9GX7y+
	ZjNB66u0s3SGCr440I3G2m1FDfd3d+xBpNUtfFXpL6XIDVSPSq0qiSv8tjXfWua6lN4yAYuGQBmSo
	eK0Oz+Zw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tiHrZ-00000005dDY-05Hq;
	Wed, 12 Feb 2025 18:53:33 +0000
Date: Wed, 12 Feb 2025 18:53:32 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	zhangkun09@huawei.com, liuyonglong@huawei.com,
	fanghaiqing@huawei.com,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Alexander Duyck <alexander.duyck@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	IOMMU <iommu@lists.linux.dev>, MM <linux-mm@kvack.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next v9 0/4] fix the DMA API misuse problem for
 page_pool
Message-ID: <Z6zuLJU7o_gRsQRu@casper.infradead.org>
References: <20250212092552.1779679-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212092552.1779679-1-linyunsheng@huawei.com>

On Wed, Feb 12, 2025 at 05:25:47PM +0800, Yunsheng Lin wrote:
> This patchset fix the dma API misuse problem as mentioned in [1].
> 
> 1. https://lore.kernel.org/lkml/8067f204-1380-4d37-8ffd-007fc6f26738@kernel.org/T/

That's a very long and complicated thread.  I gave up.  You need to
provide a proper description of the problem.

