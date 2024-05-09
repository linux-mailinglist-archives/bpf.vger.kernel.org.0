Return-Path: <bpf+bounces-29198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A018C11F8
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 17:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16701F21FF0
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 15:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269EB16F296;
	Thu,  9 May 2024 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b8QfaBGy"
X-Original-To: bpf@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99016F281
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715268457; cv=none; b=gsj6VAwgi5GurV7P+2LxJlFTkFcMCY3HLnjRPMhOs5k3i8Hfo/gbIhYjKNPP717iQwjHB68KPv3mOeK85tftMZunRSlLSRkCvXmSM5Leuls0Uytf8eedtKOXjGVRaLfK9DkYD+KLH3LM1S+/fRUhc8GmM6ooowAMe7V12N6sfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715268457; c=relaxed/simple;
	bh=D+gVTItRtfglcVRMVjWLYiTUP3h7feBGYvgzlXWh3Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Ces4SxDhfseDqZs17dfnkZ3wOjxFhdkadLgbPO3xfgSaP78ydwk2Q5TA4CW29bhazjb4Qv8OvIrKaebKK2ADNFPzxw3jZA5hCTWwN5oRmQreq7TRX3L0KeQu1PqTwlJyybEdpUCBgW2/4nJDJD1k1Eo8gzJE80Ee1draCO1WX3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=b8QfaBGy; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240509152733euoutp02a70a30c9855b706432c5d1a89a014bb5~N25IIQPeU1290212902euoutp02b
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 15:27:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240509152733euoutp02a70a30c9855b706432c5d1a89a014bb5~N25IIQPeU1290212902euoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715268453;
	bh=iKzan+AtH1MLoCj0BGLCQVFuAFEDByvOY6m2IAn5u1E=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=b8QfaBGyodS0ZrDbPtPVb6Z8aQXNK8nRVGyTx8DYfWp1V6XDjVV6NOnZ50bq51ZLB
	 Tvj25fhF/bEO+63/SAL6bTNTwpk8gKXJie9D5t0F1qH4DM9bgwXbIYUNEbwHnTawOy
	 poKtORPufvrAK7wcExjJBJ0RRzVAsM6P6/H2ZYao=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240509152733eucas1p21b928a4d596f3cc47a1ffbb0d0b0a66a~N25H6UKAt0901309013eucas1p2K;
	Thu,  9 May 2024 15:27:33 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 15.C9.09620.46BEC366; Thu,  9
	May 2024 16:27:32 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240509152732eucas1p1b71b1a26a0ad22e4b312fc67d31ce565~N25HdLGmP1519015190eucas1p11;
	Thu,  9 May 2024 15:27:32 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240509152732eusmtrp21f58eaa0be099ccb174a9941fecd3be0~N25HchPCn3217432174eusmtrp2p;
	Thu,  9 May 2024 15:27:32 +0000 (GMT)
X-AuditID: cbfec7f5-d31ff70000002594-4b-663ceb64d8ec
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id F5.9E.09010.46BEC366; Thu,  9
	May 2024 16:27:32 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240509152731eusmtip1743dcfe9fff0115332f0217b51336b15~N25GgQt502500825008eusmtip1x;
	Thu,  9 May 2024 15:27:31 +0000 (GMT)
Message-ID: <34f29631-af45-462a-a168-e9f4bb4451cf@samsung.com>
Date: Thu, 9 May 2024 17:27:31 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: fix DMA sync for drivers not calling
 dma_set_mask*()
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Christoph Hellwig
	<hch@lst.de>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240509144616.938519-1-aleksander.lobakin@intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPKsWRmVeSWpSXmKPExsWy7djPc7opr23SDB5vtbG4+Hkhq8XnI8fZ
	LJ4ee8RusXL1USaLX18sLDpnb2C3uLCtj9Xi8q45bBYrDp1gtzi2QMxixu2lzBZzv0xltjj4
	4QmrReOR92wWLXdMHfg9nhycx+SxZt4aRo8Fm0o9Fu95yeSxaVUnm8eLzTMZPXbfbGDz+LxJ
	LoAjissmJTUnsyy1SN8ugStj1fbrzAXrdCpWbXjM2sB4VbmLkZNDQsBE4sbX8yxdjFwcQgIr
	GCUez5rDBuF8YZTYsncrK0iVkMBnRol1fR4wHSemn4XqWM4osWLvHlYI5yOjxO4JN9m7GDk4
	eAXsJL7vAmtgEVCR2LXjCyOIzSsgKHFy5hMWEFtUQF7i/q0Z7CC2sECAxORf98CWiQiESTw6
	2gNWzyywn1ni/XMtCFtc4taT+UwgNpuAoUTX2y42EJtTwFliTutKJogaeYntb+cwQxy6nlNi
	+m8WCNtFYtKz3UwQtrDEq+Nb2CFsGYn/O0FmcgHZ7YwSC37fh3ImMEo0PL/FCFFlLXHn3C82
	kMeYBTQl1u/Shwg7Svy4dIMJJCwhwCdx460gxA18EpO2TWeGCPNKdLQJQVSrScw6vg5u7cEL
	l5gnMCrNQgqVWUi+nIXkm1kIexcwsqxiFE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITHOn
	/x3/uoNxxauPeocYmTgYDzFKcDArifBW1VinCfGmJFZWpRblxxeV5qQWH2KU5mBREudVTZFP
	FRJITyxJzU5NLUgtgskycXBKNTDpzjL8s9wzN3ZtaHJTui+Pqcfsc/Gd8/Zvf3RPMpZDu+Fx
	waKLi4w/x8pmieYuXJV85aU5n4Of8BnFO590VbnFUtUu1TkFaAucPHbgoLKsi8yR08VCHTt9
	N13SbVXezBERVB2eXdZ1sVxS5r+Kf+fq+wnyXpMKHMtPXmk0cGmNM2t1f/CqZdV1o0/771hl
	xT5+wBPJtmXx5SMBv77PVZ30JfDOSXPDr9daDh2TylXtmrt108ufbBdO9om2bAwuTtu2IY59
	+wbdFY/Zp7SXbdX723xNXkrG3UWV3+uEDLvImsv7Xd+J6XWtMzaQ/vo94E7XsZmp+4WmXmVp
	r/I1L70nN+XSZuH3rBfFM6MqPyuxFGckGmoxFxUnAgBs8uMZ4gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7opr23SDD5OVrS4+Hkhq8XnI8fZ
	LJ4ee8RusXL1USaLX18sLDpnb2C3uLCtj9Xi8q45bBYrDp1gtzi2QMxixu2lzBZzv0xltjj4
	4QmrReOR92wWLXdMHfg9nhycx+SxZt4aRo8Fm0o9Fu95yeSxaVUnm8eLzTMZPXbfbGDz+LxJ
	LoAjSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j
	1fbrzAXrdCpWbXjM2sB4VbmLkZNDQsBE4sT0syxdjFwcQgJLGSWuretih0jISJyc1sAKYQtL
	/LnWxQZR9J5Ron/rRaYuRg4OXgE7ie+7PEBqWARUJHbt+MIIYvMKCEqcnPmEBcQWFZCXuH9r
	BthMYQE/iWVzLzKD2CICYRINPStYQWYyCxxklri+azPUFdMYJQ4veM4GUsUsIC5x68l8JhCb
	TcBQouttF1icU8BZYk7rSiaIGjOJrq1djBC2vMT2t3OYJzAKzUJyyCwko2YhaZmFpGUBI8sq
	RpHU0uLc9NxiI73ixNzi0rx0veT83E2MwOjeduznlh2MK1991DvEyMTBeIhRgoNZSYS3qsY6
	TYg3JbGyKrUoP76oNCe1+BCjKTA0JjJLiSbnA9NLXkm8oZmBqaGJmaWBqaWZsZI4r2dBR6KQ
	QHpiSWp2ampBahFMHxMHp1QDk+WpyLf3Eg+unjIl7m1ApUYBz4LzN79PMe+4cZr55w0986Z7
	9jOKEvtE9PmWSl5tvjjhjxvXm6DX11gyLcOsZjzaNGeOK/O7ot3PFogonDkgtI5ZcDk33zaL
	S2tvNJd12143bWnSk/vmIdTLVlGmc6s28LNr9urtK476tk6Re1KlVLXH7mZM+yWLV2rfd7Sx
	uHEe1l/yXj1jlp/x+S8Tj2WF+RZuWWxYaMK8ukqWZZmit/wN5fr53Fe/GLU5rv35xL/Hovuk
	TUrB84j0Yq57ZbJRnUli77dv3vNn7qrmkJTNEg7/5t37GB/+5t3t1cwfOu34P/1Kr3l3+PWG
	pHvZ6l8W5oR+De9ondytx+Q9W4mlOCPRUIu5qDgRACyAurJ3AwAA
X-CMS-MailID: 20240509152732eucas1p1b71b1a26a0ad22e4b312fc67d31ce565
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240509144704eucas1p2fe6bfb07a9b39f548e7db0f24e47eb0a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240509144704eucas1p2fe6bfb07a9b39f548e7db0f24e47eb0a
References: <CGME20240509144704eucas1p2fe6bfb07a9b39f548e7db0f24e47eb0a@eucas1p2.samsung.com>
	<20240509144616.938519-1-aleksander.lobakin@intel.com>

On 09.05.2024 16:46, Alexander Lobakin wrote:
> There are several reports that the DMA sync shortcut broke non-coherent
> devices.
> dev->dma_need_sync is false after the &device allocation and if a driver
> didn't call dma_set_mask*(), it will still be false even if the device
> is not DMA-coherent and thus needs synchronizing. Due to historical
> reasons, there's still a lot of drivers not calling it.
> Invert the boolean, so that the sync will be performed by default and
> the shortcut will be enabled only when calling dma_set_mask*().
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/lkml/46160534-5003-4809-a408-6b3a3f4921e9@samsung.com
> Reported-by: Steven Price <steven.price@arm.com>
> Closes: https://lore.kernel.org/lkml/010686f5-3049-46a1-8230-7752a1b433ff@arm.com
> Fixes: 32ba8b823252 ("dma: avoid redundant calls for sync operations")
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   include/linux/device.h      |  4 ++--
>   include/linux/dma-map-ops.h |  4 ++--
>   include/linux/dma-mapping.h |  2 +-
>   kernel/dma/mapping.c        | 10 +++++-----
>   kernel/dma/swiotlb.c        |  2 +-
>   5 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ed95b829f05b..d4b50accff26 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -691,7 +691,7 @@ struct device_physical_location {
>    *		and optionall (if the coherent mask is large enough) also
>    *		for dma allocations.  This flag is managed by the dma ops
>    *		instance from ->dma_supported.
> - * @dma_need_sync: The device needs performing DMA sync operations.
> + * @dma_skip_sync: DMA sync operations can be skipped for coherent buffers.
>    *
>    * At the lowest level, every device in a Linux system is represented by an
>    * instance of struct device. The device structure contains the information
> @@ -805,7 +805,7 @@ struct device {
>   	bool			dma_ops_bypass : 1;
>   #endif
>   #ifdef CONFIG_DMA_NEED_SYNC
> -	bool			dma_need_sync:1;
> +	bool			dma_skip_sync:1;
>   #endif
>   };
>   
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 4893cb89cb52..5217b922d29f 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -280,8 +280,8 @@ static inline void dma_reset_need_sync(struct device *dev)
>   {
>   #ifdef CONFIG_DMA_NEED_SYNC
>   	/* Reset it only once so that the function can be called on hotpath */
> -	if (unlikely(!dev->dma_need_sync))
> -		dev->dma_need_sync = true;
> +	if (unlikely(dev->dma_skip_sync))
> +		dev->dma_skip_sync = false;
>   #endif
>   }
>   
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index eb4e15893b6c..f693aafe221f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -295,7 +295,7 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr);
>   static inline bool dma_dev_need_sync(const struct device *dev)
>   {
>   	/* Always call DMA sync operations when debugging is enabled */
> -	return dev->dma_need_sync || IS_ENABLED(CONFIG_DMA_API_DEBUG);
> +	return !dev->dma_skip_sync || IS_ENABLED(CONFIG_DMA_API_DEBUG);
>   }
>   
>   static inline void dma_sync_single_for_cpu(struct device *dev, dma_addr_t addr,
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 3524bc92c37f..3f77c3f8d16d 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -392,7 +392,7 @@ bool __dma_need_sync(struct device *dev, dma_addr_t dma_addr)
>   
>   	if (dma_map_direct(dev, ops))
>   		/*
> -		 * dma_need_sync could've been reset on first SWIOTLB buffer
> +		 * dma_skip_sync could've been reset on first SWIOTLB buffer
>   		 * mapping, but @dma_addr is not necessary an SWIOTLB buffer.
>   		 * In this case, fall back to more granular check.
>   		 */
> @@ -407,20 +407,20 @@ static void dma_setup_need_sync(struct device *dev)
>   
>   	if (dma_map_direct(dev, ops) || (ops->flags & DMA_F_CAN_SKIP_SYNC))
>   		/*
> -		 * dma_need_sync will be reset to %true on first SWIOTLB buffer
> +		 * dma_skip_sync will be reset to %false on first SWIOTLB buffer
>   		 * mapping, if any. During the device initialization, it's
>   		 * enough to check only for the DMA coherence.
>   		 */
> -		dev->dma_need_sync = !dev_is_dma_coherent(dev);
> +		dev->dma_skip_sync = dev_is_dma_coherent(dev);
>   	else if (!ops->sync_single_for_device && !ops->sync_single_for_cpu &&
>   		 !ops->sync_sg_for_device && !ops->sync_sg_for_cpu)
>   		/*
>   		 * Synchronization is not possible when none of DMA sync ops
>   		 * is set.
>   		 */
> -		dev->dma_need_sync = false;
> +		dev->dma_skip_sync = true;
>   	else
> -		dev->dma_need_sync = true;
> +		dev->dma_skip_sync = false;
>   }
>   #else /* !CONFIG_DMA_NEED_SYNC */
>   static inline void dma_setup_need_sync(struct device *dev) { }
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index ae3e593eaadb..068134697cf1 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -1409,7 +1409,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>   	}
>   
>   	/*
> -	 * If dma_need_sync wasn't set, reset it on first SWIOTLB buffer
> +	 * If dma_skip_sync was set, reset it on first SWIOTLB buffer
>   	 * mapping to always sync SWIOTLB buffers.
>   	 */
>   	dma_reset_need_sync(dev);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


