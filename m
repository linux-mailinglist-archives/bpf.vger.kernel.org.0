Return-Path: <bpf+bounces-20568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCD78404C4
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 13:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7442E1F2387B
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 12:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C95604D3;
	Mon, 29 Jan 2024 12:15:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D4F604AA;
	Mon, 29 Jan 2024 12:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706530514; cv=none; b=J3+TrflixdwayOLQQV81P2iEqIXTIZVQAFoeFv0URYieRtUEfrSIq5vH/5ino5GuM91/S+2yc6eltviaxj1yilstCd4x1QET1bRl8nykYFKrXlW74tgGQBhjuMQLngcKSOPINrYFSIYzGKYengoBP5zm+1EfnvwemRNBk13r0Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706530514; c=relaxed/simple;
	bh=CI2SITbEyDMK/SnfUcFawfQgI/5HdPELOd7hdQeM9Fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uRD69cEOQSMzB7OMSXmKXP/6aOB+tyGHxs/g+1kBa7qPWsLBScS+Gm7mCz7NoJ/Cpz957Zalcmq/vwKBQ+pB+1w5BPsSA6VW+pRrAfOmv+TiPRRk67AMYsQsOuv9UOg47vGFxwB9gG1Bt2H5s3LpaqHvoeqOi7Iuv14vHI+PBOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 296821FB;
	Mon, 29 Jan 2024 04:15:56 -0800 (PST)
Received: from [10.57.77.253] (unknown [10.57.77.253])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8F643F5A1;
	Mon, 29 Jan 2024 04:15:09 -0800 (PST)
Message-ID: <df8f1bf4-819a-4b2a-927d-e97fe196cdf6@arm.com>
Date: Mon, 29 Jan 2024 12:15:07 +0000
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
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
 <20240126135456.704351-2-aleksander.lobakin@intel.com>
 <20240129061136.GD19258@lst.de>
 <4e23d103-ea1c-4fd3-852e-f7e2ec9170ad@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4e23d103-ea1c-4fd3-852e-f7e2ec9170ad@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-29 11:07 am, Alexander Lobakin wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 29 Jan 2024 07:11:36 +0100
> 
>> On Fri, Jan 26, 2024 at 02:54:50PM +0100, Alexander Lobakin wrote:
>>> Some platforms do have DMA, but DMA there is always direct and coherent.
>>> Currently, even on such platforms DMA sync operations are compiled and
>>> called.
>>> Add a new hidden Kconfig symbol, DMA_NEED_SYNC, and set it only when
>>> either sync operations are needed or there is DMA ops or swiotlb
>>> enabled. Set dma_need_sync() and dma_skip_sync() (stub for now)
>>> depending on this symbol state and don't call sync ops when
>>> dma_skip_sync() is true.
>>> The change allows for future optimizations of DMA sync calls depending
>>> on compile-time or runtime conditions.
>>
>> So the idea of compiling out the calls sounds fine to me.  But what
>> is the point of the extra indirection through the __-prefixed calls?
> 
> Because dma_sync_* ops are external functions, not inlines, and in the
> next patch I'm adding a check there.
> 
>>
>> And if we need that (please document it in the commit log), please
>> make the wrappers proper inline functions and not macros.

In fact those wrappers could perhaps subsume the existing stub 
definitions, by starting with a refactor along these lines:

static inline dma_sync_x(...)
{
	if (IS_ENABLED(CONFIG_NEED_DMA_SYNC))
		__dma_sync_x(...);
}

Cheers,
Robin.

