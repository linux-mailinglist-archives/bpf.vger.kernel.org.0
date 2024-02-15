Return-Path: <bpf+bounces-22063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DAC855A05
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 06:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B3D1F2A9B0
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 05:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F89476;
	Thu, 15 Feb 2024 05:09:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3579DD;
	Thu, 15 Feb 2024 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707973744; cv=none; b=UwIdp+YtDpTDnEku/LDnfP71lYlre1Cur+k5YSdKkqwhHCChdCn4PKSIDaT1MMTynOvCUUgcyyvJvYRPLVAmUPok04ribA9pfl9QXQtVPqwEXjioLXALJkeowkbuSe7iqcG0CmMuWoyauSQuNS2TyYURzLZIMzGYveJFiEt/mQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707973744; c=relaxed/simple;
	bh=cNwF0UBoZgTorJtcVmtOzDAYbe9MG8JuAeNdYwPv0w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pkoqr+mJ9kh0xIuq8XaRQ5mf5eQN1zj2uWpcUqynLg+uDryya95D+2LCd9P1//H0dR1GaqKNIJaOq25RdtTMYZHsGqs8BtMf4t9ztM8A5CsOhkGcpy18RFnJCepN2INW5SlbDDoDwphJ6QCS/iidysxCBorFYdzr2WhTwPWXskw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D1E0D67373; Thu, 15 Feb 2024 06:08:57 +0100 (CET)
Date: Thu, 15 Feb 2024 06:08:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/7] dma: avoid redundant calls for sync
 operations
Message-ID: <20240215050857.GC4861@lst.de>
References: <20240214162201.4168778-1-aleksander.lobakin@intel.com> <20240214162201.4168778-3-aleksander.lobakin@intel.com> <3a9dd580-1977-418f-a3f3-73003dd37710@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9dd580-1977-418f-a3f3-73003dd37710@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Feb 14, 2024 at 05:55:23PM +0000, Robin Murphy wrote:
>>   #define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
>> +#define DMA_F_CAN_SKIP_SYNC		BIT(1)
>
> Yuck, please be consistent - either match the style of the existing code, 
> or change that to BIT(0) as well.

Just don't use BIT() ever.  It doesn't save any typing and creates a
totally pointless mental indirection.

> I guess this was the existing condition from dma_need_sync(), but now it's 
> on a one-off slow path it might be nice to check the sync_sg_* ops as well 
> for completeness, or at least comment that nobody should be implementing 
> those without also implementing the sync_single_* ops.

Implementing only one and not the other doesn't make any sense.  Maybe
a debug check for that is ok, but thing will break badly if they aren't
in sync anyway.

