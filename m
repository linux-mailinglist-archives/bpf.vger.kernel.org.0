Return-Path: <bpf+bounces-20847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E6D8445C2
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 18:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F39081F21087
	for <lists+bpf@lfdr.de>; Wed, 31 Jan 2024 17:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474AE12CD9B;
	Wed, 31 Jan 2024 17:14:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79EC12C534;
	Wed, 31 Jan 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721253; cv=none; b=bgte0ZFolrohiWt6ePRI8c5/a+RKV9DMFQMhxwc6YroPaIMfTz6MYJ0IM+0m6JuKk35dQlbGkugrnk3pcRZzM5VZ4BLNiiO1jx8vA4GV1XOYTTOk/WV/lTdLyBPLPonJM9u24k7fBY9zk1UaiWsirTRYXl4UrGLHqpX5dSv0tcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721253; c=relaxed/simple;
	bh=jPob66oqqRD+u/Ws6WgtJDB/RPp0fCgA3pNTgEg6TEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbEzwDZUzZRYTrZQDZuEJa96dVAxQtmz01tQu0OASlMSISl/xh7sJnIIcL98wRugWRjyKT5/l8bVdYj4FlP8c/Gx8Xknwr/UD4KcbZkhyrzWlOagGZrJ9w9+0ZGoE9ONipVmP3rnG/gRYnzeIuMNpfm2+2Gyk4M/9XcZIEhuSmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D936DA7;
	Wed, 31 Jan 2024 09:14:53 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02F6F3F762;
	Wed, 31 Jan 2024 09:14:07 -0800 (PST)
Message-ID: <abdb46cc-b49e-4bc7-b703-678b079b120f@arm.com>
Date: Wed, 31 Jan 2024 17:14:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/7] dma: compile-out DMA sync op calls when not
 used
Content-Language: en-GB
To: Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-2-aleksander.lobakin@intel.com>
 <20240131165258.GA401365@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240131165258.GA401365@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 31/01/2024 4:52 pm, Simon Horman wrote:
> On Fri, Jan 26, 2024 at 02:54:50PM +0100, Alexander Lobakin wrote:
>> Some platforms do have DMA, but DMA there is always direct and coherent.
>> Currently, even on such platforms DMA sync operations are compiled and
>> called.
>> Add a new hidden Kconfig symbol, DMA_NEED_SYNC, and set it only when
>> either sync operations are needed or there is DMA ops or swiotlb
>> enabled. Set dma_need_sync() and dma_skip_sync() (stub for now)
>> depending on this symbol state and don't call sync ops when
>> dma_skip_sync() is true.
>> The change allows for future optimizations of DMA sync calls depending
>> on compile-time or runtime conditions.
>>
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Hi Alexander,
> 
> This seems to cause x86_64 allmodconfig builds to fail:

Oh yeah, the sync_single_range definitions shouldn't need touching at 
all, since they're unconditional wrappers around regular sync_single 
invocations (which already may or may not do anything).

Thanks,
Robin.

> 
>   ../drivers/media/platform/ti/omap3isp/ispstat.c:82:35: error: ‘dma_sync_single_range_for_device’ undeclared (first use in this function); did you mean ‘dma_sync_sgtable_for_device’?
>      82 |                                   dma_sync_single_range_for_device);
>         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                                   dma_sync_sgtable_for_device
>   ../drivers/media/platform/ti/omap3isp/ispstat.c:82:35: note: each undeclared identifier is reported only once for each function it appears in
>   ../drivers/media/platform/ti/omap3isp/ispstat.c: In function ‘isp_stat_buf_sync_magic_for_cpu’:
>   ../drivers/media/platform/ti/omap3isp/ispstat.c:94:35: error: ‘dma_sync_single_range_for_cpu’ undeclared (first use in this function); did you mean ‘dma_sync_sgtable_for_cpu’?
>      94 |                                   dma_sync_single_range_for_cpu);
>         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>         |                                   dma_sync_sgtable_for_cpu

