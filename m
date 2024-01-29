Return-Path: <bpf+bounces-20610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFDA840B15
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 17:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758B928DF16
	for <lists+bpf@lfdr.de>; Mon, 29 Jan 2024 16:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2994D155A55;
	Mon, 29 Jan 2024 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="dsleu72F"
X-Original-To: bpf@vger.kernel.org
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5F155319;
	Mon, 29 Jan 2024 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544936; cv=none; b=Pngrw7KrJdrp78WWff13oERzFq9ISFZN6NqgUb2q3pwiYnptBTwlPLf8iEiFg81+8B8szkz61YcB4gQ4X1ZkZg5lCLrB7fvNHoFmQpev9vWCZhmCBiXcnqh+nI49OAsPj/VxK8o6K/4X210WC3l50CiPKuG5SeTCb3jWO7CKeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544936; c=relaxed/simple;
	bh=XAncuxs4rWD0OgmCqhjg24NGRyoTVI4B/LGYumcx7eU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WP08A5KD6b8vun3bEBQxV0k9gYJZ1sz60SjCS9qJaCMDrevcTxsCGeKuEUV8TuabNxru0GPYSRPMjFKvFAi98FyokaqH1EYzUN9kWlNPT/pgAVLt21YQAPp//xVdap8LayxPa2SNY9kJd4jpz3twKk2uYjXQ4vkn0RR92dhqeW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=dsleu72F; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 99EDE19B10F;
	Mon, 29 Jan 2024 17:15:30 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706544931; bh=XAncuxs4rWD0OgmCqhjg24NGRyoTVI4B/LGYumcx7eU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dsleu72FyCpv2CVdZyOQ4qDP2dZxSOW2DxhiwEuIAxvWK2xXzcttGrNMuyn8VEXrj
	 vF+F3MH82nP2XXx3t99+8r32fIBfyWy4gJjX6z+MGy1Aa1qV9PmnC1nuUNyQi6r6Ip
	 EBkj3x+443gUm2azpuoNmXFwcDSHesZf6ETCscfiUi9cUSnrj2wpHRfMoA/ATMfSGs
	 6QYnTA43RJlBVMt4i5+iY+BX9qMYMK5yhvH0Cxqs1P936iNBTE3RMslIm4Cgng+l9U
	 syNNzLeprlQ30L+LIWVhFi5ZhSIEAMFx9bv0UaopqEx6iWtXj9NwG/07Oy94+WX7iY
	 vSgKH1payk+Bw==
Date: Mon, 29 Jan 2024 17:15:29 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Robin Murphy <robin.murphy@arm.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Christoph Hellwig
 <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Alexander Duyck <alexanderduyck@fb.com>,
 <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/7] dma: avoid expensive redundant calls for
 sync operations
Message-ID: <20240129171529.09cf6b65@meshulam.tesarici.cz>
In-Reply-To: <6059bf0c-cfe6-41dd-8672-584c9c13b902@intel.com>
References: <20240126135456.704351-1-aleksander.lobakin@intel.com>
	<20240126135456.704351-3-aleksander.lobakin@intel.com>
	<0f6f550c-3eee-46dc-8c42-baceaa237610@arm.com>
	<7ff3cf5d-b3ff-4b52-9031-30a1cb71c0c9@intel.com>
	<0cf72c00-21d9-4f1a-be14-80336da5dff4@arm.com>
	<20240126194819.147cb4e2@meshulam.tesarici.cz>
	<6059bf0c-cfe6-41dd-8672-584c9c13b902@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jan 2024 15:36:35 +0100
Alexander Lobakin <aleksander.lobakin@intel.com> wrote:

> From: Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz>
> Date: Fri, 26 Jan 2024 19:48:19 +0100
>=20
> > On Fri, 26 Jan 2024 17:21:24 +0000
> > Robin Murphy <robin.murphy@arm.com> wrote:
> >  =20
> >> On 26/01/2024 4:45 pm, Alexander Lobakin wrote: =20
> >>> From: Robin Murphy <robin.murphy@arm.com>
> >>> Date: Fri, 26 Jan 2024 15:48:54 +0000
> >>>    =20
> >>>> On 26/01/2024 1:54 pm, Alexander Lobakin wrote:   =20
> >>>>> From: Eric Dumazet <edumazet@google.com>
> >>>>>
> >>>>> Quite often, NIC devices do not need dma_sync operations on x86_64
> >>>>> at least.
> >>>>> Indeed, when dev_is_dma_coherent(dev) is true and
> >>>>> dev_use_swiotlb(dev) is false, iommu_dma_sync_single_for_cpu()
> >>>>> and friends do nothing.
> >>>>>
> >>>>> However, indirectly calling them when CONFIG_RETPOLINE=3Dy consumes=
 about
> >>>>> 10% of cycles on a cpu receiving packets from softirq at ~100Gbit r=
ate.
> >>>>> Even if/when CONFIG_RETPOLINE is not set, there is a cost of about =
3%.
> >>>>>
> >>>>> Add dev->skip_dma_sync boolean which is set during the device
> >>>>> initialization depending on the setup: dev_is_dma_coherent() for di=
rect
> >>>>> DMA, !(sync_single_for_device || sync_single_for_cpu) or positive r=
esult
> >>>>> from the new callback, dma_map_ops::can_skip_sync for non-NULL DMA =
ops.
> >>>>> Then later, if/when swiotlb is used for the first time, the flag
> >>>>> is turned off, from swiotlb_tbl_map_single().   =20
> >>>>
> >>>> I think you could probably just promote the dma_uses_io_tlb flag from
> >>>> SWIOTLB_DYNAMIC to a general SWIOTLB thing to serve this purpose now=
.   =20
> >>>
> >>> Nice catch!
> >>>    =20
> >>>>
> >>>> Similarly I don't think a new op is necessary now that we have
> >>>> dma_map_ops.flags. A simple static flag to indicate that sync may be=
> skipped under the same conditions as implied for dma-direct - i.e.
> >>>> dev_is_dma_coherent(dev) && !dev->dma_use_io_tlb - seems like it oug=
ht
> >>>> to suffice.   =20
> >>>
> >>> In my initial implementation, I used a new dma_map_ops flag, but then=
 I
> >>> realized different DMA ops may require or not require syncing under
> >>> different conditions, not only dev_is_dma_coherent().
> >>> Or am I wrong and they would always be the same?   =20
> >>
> >> I think it's safe to assume that, as with P2P support, this will only=
=20
> >> matter for dma-direct and iommu-dma for the foreseeable future, and=20
> >> those do currently share the same conditions as above. Thus we may as=
=20
> >> well keep things simple for now, and if anything ever does have cause =
to=20
> >> change, it can be the future's problem to keep this mechanism working =
as=20
> >> intended. =20
> >=20
> > Can we have a comment that states this assumption along with the flag?
> > Because when it breaks, it will keep someone cursing for days why DMA
> > sometimes fails on their device before they find out it's not synced. =
=20
>=20
> BTW, dma_skip_sync is set right before driver->probe(), so that if any
> problematic device appears, it could easily be fixed by adding one line
> to its probe callback.

Ah, perfect!

Petr T

