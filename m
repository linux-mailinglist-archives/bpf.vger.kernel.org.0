Return-Path: <bpf+bounces-22024-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBA98551BC
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 19:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A39621F23FC0
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 18:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992612A168;
	Wed, 14 Feb 2024 18:09:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E3812A156;
	Wed, 14 Feb 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934154; cv=none; b=Ga9exVhHHxPqrPeh+3ai6BdP/gBwgQQmLSGoRBCYJmsiezdSkkFiXqiK1cxiUG9i1r+Kbcc7dzEjRPgWBwpWoaee/VfaEt69tXUOy8cvTOmnkqApq2XpgY1kN5If0DlKLd9c+Y4gZ/F3VrwzW7ESXyfX0driN983gYD9+OMnls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934154; c=relaxed/simple;
	bh=xJfgsHzx/81y0EEpfzs/vdStj/XBLTzhMIkOKysBaGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJQk82nmTFWvG93VIZ76eNLnAf71crmFvqiYqytTpx9XKpRw4vVXXwa+s+sD2S1D2MvuJ972OiAUEqGJLtgreOfXw2Gr+JF3iBgLKnPnBzizafy+e3bcTruTl1EAtkRSLBZjObhcHWh2hE9NjMJ1NHkLJfJ+WGx+gDNQHxpZSBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CBAE1FB;
	Wed, 14 Feb 2024 10:09:53 -0800 (PST)
Received: from [10.57.47.86] (unknown [10.57.47.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A7453F7B4;
	Wed, 14 Feb 2024 10:09:09 -0800 (PST)
Message-ID: <fba9018d-3783-4d3c-8948-409d7d5258d5@arm.com>
Date: Wed, 14 Feb 2024 18:09:08 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/7] dma: compile-out DMA sync op calls when
 not used
Content-Language: en-GB
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
 <20240214162201.4168778-2-aleksander.lobakin@intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20240214162201.4168778-2-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-14 4:21 pm, Alexander Lobakin wrote:
[...]
> +static inline bool dma_skip_sync(const struct device *dev)
> +{
> +	return !IS_ENABLED(CONFIG_DMA_NEED_SYNC);
> +}

One more thing, could we please also make this conditional on 
!CONFIG_DMA_API_DEBUG so that that doesn't lose coverage for validating 
syncs?

Thanks,
Robin.

