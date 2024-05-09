Return-Path: <bpf+bounces-29168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 606EE8C0EF5
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 13:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8435F1C20FC9
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38A814A4EE;
	Thu,  9 May 2024 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LUsluixc"
X-Original-To: bpf@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197A61E868
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254891; cv=none; b=kz2I1l7JcUSlliTqjatuRDAezc2kiX5KbGmcuRABNDRFAH0UdjxLipeIRq/up29TfJ3a8ICBwEjQRu83/KZGPohVxlmb+sGfPMgCLYKJ+j1qo/UqWKI4JSboLOBmifqtlfCoO/Ub/9uEKbSqPns4awlqxfufhcm4GNmfV9DL34I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254891; c=relaxed/simple;
	bh=1jdDjfryC/Txk3Ehog5XJe8lFu+V6W6ew2Ru5wmFwlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=tU0fHo/tzLn3cJQoRnXzm5NnGVJGcAssqcbpfsvNTF7KERzxgi9XHUNjZsLYSA2kksC/Q4bl6BrK90dy5JlTCl29GXRVYjlOllKknZDCcuRcyR0hiGPDsp3ZC3I1HWQeJ1DcZ+UQjRliwhcLZNWb1UaWXyL2mA3Pb611QFVzt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LUsluixc; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240509114120euoutp027426ce9fe169e9523c2e551dbefeb9af~NzznHLB7W0198301983euoutp02m
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 11:41:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240509114120euoutp027426ce9fe169e9523c2e551dbefeb9af~NzznHLB7W0198301983euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715254880;
	bh=sFuV/tFX3qlWPW5/hEAfuW4Mb0Qblw1Ko/UBLqs3gjE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LUsluixcUNWf9hRnJ/2qvWhFlr35sBCrH2g1GJ1Rxaa276Rw1LDURgZ5IJwkb+ywL
	 XMhJgaAVYKz/dCGoc7nqEVfoIsqm/hfiN62oL+WHJ86PVCt1qwmy45ZrW+NBLZEO82
	 GfWpTPga8Li3tYceMBah/WO8CftrSSJC6P25dQQY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240509114119eucas1p2587f7335c4115d3633d2237e25638521~Nzzm3f-NM2502625026eucas1p2r;
	Thu,  9 May 2024 11:41:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 10.7C.09624.F56BC366; Thu,  9
	May 2024 12:41:19 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20240509114119eucas1p232697f21d70fde9a42d6d6488aa5d31a~NzzmfrTEZ2502625026eucas1p2q;
	Thu,  9 May 2024 11:41:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240509114119eusmtrp238e878d6f387c6d0e266316b035d27a9~Nzzme36xc0201902019eusmtrp2P;
	Thu,  9 May 2024 11:41:19 +0000 (GMT)
X-AuditID: cbfec7f2-bfbff70000002598-02-663cb65f2399
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 45.9A.08810.F56BC366; Thu,  9
	May 2024 12:41:19 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240509114118eusmtip1f4321fd1d43f2b0bab0d3c1116a1d9e6~NzzlViG3C1979819798eusmtip1r;
	Thu,  9 May 2024 11:41:18 +0000 (GMT)
Message-ID: <46160534-5003-4809-a408-6b3a3f4921e9@samsung.com>
Date: Thu, 9 May 2024 13:41:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] dma: avoid redundant calls for sync operations
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Christoph Hellwig
	<hch@lst.de>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will
	Deacon <will@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Magnus
	Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240507112026.1803778-3-aleksander.lobakin@intel.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djP87rx22zSDC7sMrS4+Hkhq8XnI8fZ
	LJ4ee8RusXL1USaLX18sLDpnb2C3uLCtj9Xi8q45bBYrDp1gtzi2QMxixu2lzBZzv0xltjj4
	4QmrRcsdUwc+jycH5zF5rJm3htFjwaZSj8V7XjJ5bFrVyebxYvNMRo/dNxvYPD5vkgvgiOKy
	SUnNySxLLdK3S+DKuH5/DXvBK5GK1wcnsjQwtgt2MXJySAiYSPw79pipi5GLQ0hgBaPEkgvT
	2CGcL4wSj7q3MYNUCQl8ZpS4ssgapuPR/H5WiKLljBJ3L29lhHA+MkqsmHeNEaSKV8BOYuLj
	1UwgNouAikTrorfMEHFBiZMzn7CA2KIC8hL3b81gB7GFBbwkDr/rBbNFBMIkHh3tARvKLDCL
	WeLUzedgzcwC4hK3nswHG8omYCjR9baLDcTmFHCRONuznhWiRl5i+9s5zCDNEgKzOSU+tF5n
	gbjbReLS3X+sELawxKvjW9ghbBmJ/zvnM0E0tDNKLPh9H8qZwCjR8PwWI0SVtcSdc7+A1nEA
	rdCUWL9LHyLsKLFgxz6wsIQAn8SNt4IQR/BJTNo2nRkizCvR0SYEUa0mMev4Ori1By9cYp7A
	qDQLKVxmIXlzFpJ3ZiHsXcDIsopRPLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwxZ3+d/zT
	Dsa5rz7qHWJk4mA8xCjBwawkwltVY50mxJuSWFmVWpQfX1Sak1p8iFGag0VJnFc1RT5VSCA9
	sSQ1OzW1ILUIJsvEwSnVwKQ3xcvs58aNlSkeooJHPncGvmGeVBG3x6t42Qa3olftkpNybFeE
	3vudPMfxZlh4rkO3qm7CF4srmzQq7VwK86JfvPc+nbNfuFLrziH5Pv732zg6PnKdD8pgsWna
	eZN57kRR7XJz3SzjdnFL2YlL3fryBK8kd+Sv26K55v2XxSVimf1ZeWGil3J2mK5mfq1jY3f5
	OVvVM8PbKdvm8j/h4XLRu/32rd89f46F+bZz0h4I/tq8c0Gh3rTNPa/uG2X6Smcql5bnSDqZ
	OTw9eo/tpOaUdatD3NpNXx96ZLFWb7eZ6ZV4/lDlo56HLBsdNrZc2L10TfrGPN20/y9TJp/z
	+e52pueqdeLRSzGXrj4LUWIpzkg01GIuKk4EAJlRwO/gAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xu7rx22zSDGZeEre4+Hkhq8XnI8fZ
	LJ4ee8RusXL1USaLX18sLDpnb2C3uLCtj9Xi8q45bBYrDp1gtzi2QMxixu2lzBZzv0xltjj4
	4QmrRcsdUwc+jycH5zF5rJm3htFjwaZSj8V7XjJ5bFrVyebxYvNMRo/dNxvYPD5vkgvgiNKz
	KcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuH5/DXvB
	K5GK1wcnsjQwtgt2MXJySAiYSDya38/axcjFISSwlFHi99YbzBAJGYmT0xpYIWxhiT/Xutgg
	it4zShzpXA5WxCtgJzHx8WomEJtFQEWiddFbqLigxMmZT1hAbFEBeYn7t2awg9jCAl4Sh9/1
	gtkiAmESDT0rwBYwC8xiluibGwex4CKjxKmHS5ggEuISt57MB7PZBAwlut6CXMHJwSngInG2
	Zz1Us5lE19YuRghbXmL72znMExiFZiG5YxaSUbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5x
	aV66XnJ+7iZGYExvO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMJbVWOdJsSbklhZlVqUH19UmpNa
	fIjRFBgYE5mlRJPzgUklryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mD
	U6qBKTOUdfV9FoboSxrV2wW9LP9ts1fqOFH4JVDgm99uwQeVc3ScU9I+81sJy50Le72iMPqM
	9KT7ZRGsv/imvZy4+M6Ne/7eK17JFD/dx3ku1trz1O3MB3fDP73ZeD6wbrdI0lKni0WSBiFH
	jhk+Xrtg3bl7K3ZMq9JN0uY+vLd3cp5q3RUu97Ue6f2lm06nfeuZyj+JfY7fkRBnmW990zdH
	tHE7vzft2C1021t1xUvVnZO45msVv/i3VuKJboybm/ka/uluF9a5+douv/9N4rTGll5L5cWf
	fl3ZeK3Pqt77vpvSMQ63xfP1NY9NaC6eZNkdJ5clz1TEt+S+eO8942Kt3gfPM+yEH176VfbZ
	h3/RSiWW4oxEQy3mouJEAJGPshlyAwAA
X-CMS-MailID: 20240509114119eucas1p232697f21d70fde9a42d6d6488aa5d31a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240507112115eucas1p117bc01652d4cdbe810de841830227f47
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240507112115eucas1p117bc01652d4cdbe810de841830227f47
References: <20240507112026.1803778-1-aleksander.lobakin@intel.com>
	<CGME20240507112115eucas1p117bc01652d4cdbe810de841830227f47@eucas1p1.samsung.com>
	<20240507112026.1803778-3-aleksander.lobakin@intel.com>

Dear All,

On 07.05.2024 13:20, Alexander Lobakin wrote:
> Quite often, devices do not need dma_sync operations on x86_64 at least.
> Indeed, when dev_is_dma_coherent(dev) is true and
> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
> and friends do nothing.
>
> However, indirectly calling them when CONFIG_RETPOLINE=y consumes about
> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit rate.
> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about 3%.
>
> Add dev->need_dma_sync boolean and turn it off during the device
> initialization (dma_set_mask()) depending on the setup:
> dev_is_dma_coherent() for the direct DMA, !(sync_single_for_device ||
> sync_single_for_cpu) or the new dma_map_ops flag, %DMA_F_CAN_SKIP_SYNC,
> advertised for non-NULL DMA ops.
> Then later, if/when swiotlb is used for the first time, the flag
> is reset back to on, from swiotlb_tbl_map_single().
>
> On iavf, the UDP trafficgen with XDP_DROP in skb mode test shows
> +3-5% increase for direct DMA.
>
> Suggested-by: Christoph Hellwig <hch@lst.de> # direct DMA shortcut
> Co-developed-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   include/linux/device.h      |  4 +++
>   include/linux/dma-map-ops.h | 12 ++++++++
>   include/linux/dma-mapping.h | 53 +++++++++++++++++++++++++++++++----
>   kernel/dma/mapping.c        | 55 +++++++++++++++++++++++++++++--------
>   kernel/dma/swiotlb.c        |  6 ++++
>   5 files changed, 113 insertions(+), 17 deletions(-)


This patch landed in today's linux-next as commit f406c8e4b770 ("dma: 
avoid redundant calls for sync operations"). Unfortunately I found that 
it breaks some of the ARM 32bit boards by forcing skipping DMA sync 
operations on non-coherent systems. This happens because this patch 
hooks dma_need_sync=true initialization into set_dma_mask(), but 
set_dma_mask() is not called from all device drivers, especially from 
those which operates properly with the default 32bit dma mask (like most 
of the platform devices created by the OF layer).

Frankly speaking I have no idea how this should be fixed. I expect that 
there are lots of broken devices after this change, because I don't 
remember that calling set_dma_mask() is mandatory for device drivers.

After adding dma_set_mask(dev, DMA_BIT_MASK(32)) to the drivers relevant 
for my boards the issues are gone, but I'm not sure this is the right 
approach...


> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


