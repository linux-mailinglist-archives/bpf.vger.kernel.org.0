Return-Path: <bpf+bounces-22731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC50867A9F
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 16:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CFAE1C2A3AE
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4527D12BF1C;
	Mon, 26 Feb 2024 15:46:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2A91BDDC;
	Mon, 26 Feb 2024 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962360; cv=none; b=IIn3AjoxMCg3OtF/Z9srvktuNZML46un1KAhUqJS+4Ef5A+RBE0NAfJgN1Vre2suHkC+9+OvokIaUk+EzRAlY+C3bUy3UtlTkghAljI12WRrjCUBPFbMJfppDSlQp9rPHdwWnK6uKcxDzWVIRSIhCouWSeX+OmeBJzfgmf8pLnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962360; c=relaxed/simple;
	bh=bdJTfIlFy3ED3bBg1k1z8Me8BEsVndqCk6aPs/qgrVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a39wgW1+Hw+1btwCFEIrzoZ2gLafKFiu2dDNuek5MouahrSXUqZcBQpSOzMF+W3Vi1fug3Gjf0fWuUI6hMWna+jmWpaWbrLAbHbr5kS+gzmqlgS4M3UhirDw1Nl3Fx329H3ms2n6jB+xZCN37om1ml+jbp1zoGV9YHxyOfxN93Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4E93DA7;
	Mon, 26 Feb 2024 07:46:36 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10D503F762;
	Mon, 26 Feb 2024 07:45:55 -0800 (PST)
Message-ID: <7e3c779e-09ae-4c87-855e-f0e6ae945169@arm.com>
Date: Mon, 26 Feb 2024 15:45:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/7] dma: avoid redundant calls for sync
 operations
To: Alexander Lobakin <aleksander.lobakin@intel.com>
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
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com>
 <20240214162201.4168778-3-aleksander.lobakin@intel.com>
 <3a9dd580-1977-418f-a3f3-73003dd37710@arm.com>
 <4d2678be-e36c-4726-83a5-ae9a3a0def55@intel.com>
Content-Language: en-GB
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4d2678be-e36c-4726-83a5-ae9a3a0def55@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/02/2024 12:49 pm, Alexander Lobakin wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> Date: Wed, 14 Feb 2024 17:55:23 +0000
> 
>> On 2024-02-14 4:21 pm, Alexander Lobakin wrote:
> 
> [...]
> 
>>> +        /*
>>> +         * Synchronization is not possible when none of DMA sync ops
>>> +         * is set. This check precedes the below one as it disables
>>> +         * the synchronization unconditionally.
>>> +         */
>>> +        dev->dma_skip_sync = true;
>>> +    else if (ops->flags & DMA_F_CAN_SKIP_SYNC)
>>
>> Personally I'd combine this into the dma-direct condition.
> 
> Please read the code comment a couple lines above :D

And my point is that that logic is not actually useful, since it would 
be nonsensical for ops to set DMA_F_CAN_SKIP_SYNC if they don't even 
implement sync ops anyway.

If the intent of DMA_F_CAN_SKIP_SYNC is to mean "behaves like 
dma-direct", then "if (dma_map_direct(...) || ops->flags & 
DMA_F_CAN_SKIP_SYNC)" is an entirely logical and expected condition.

Thanks,
Robin.

