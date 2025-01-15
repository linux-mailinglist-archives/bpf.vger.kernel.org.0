Return-Path: <bpf+bounces-48980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4356A12D11
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A5518896E1
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 21:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186FC1DB14C;
	Wed, 15 Jan 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLrz2I58"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4511DA60F;
	Wed, 15 Jan 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974812; cv=none; b=OKO7qgN43UjfACEybSiylAXNpkXzMliTJzvZCrIRMHMxOazQCqNh4vliSJzlfDZ9VqZkgvWHxndtgrkzGPG6elfyeHAcOyTqMjAxNBoW2DtufNrXg12Ax5LH0vw4/1HGC5k1UW8CHv3Vv1SrN1PT+cC4X+KvYKgfyXJjkVFBlQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974812; c=relaxed/simple;
	bh=RlPD0kUWIPW5R0PKSVU27JaRoL2dMi9vvo/1Qhhlx7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MCUbaDarjwH5dmHKNN+ciLjZ7+83Bw1jm8n+TM/OCKldju5m8fihkwUL5m1XekXpa/RdZWnHKt+zA3u+/QqDfCbhPUVdQPIvdAB17erujKj82N/6aw4ICBr4soO8j/7aIIMkBrOSTshVX2/0upKcimjLQnuA43FU/eIohwmaAyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLrz2I58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDFEC4CED1;
	Wed, 15 Jan 2025 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736974811;
	bh=RlPD0kUWIPW5R0PKSVU27JaRoL2dMi9vvo/1Qhhlx7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JLrz2I58zheY19rQK47qVvp+t77dq2WMCZsCyasfRIy09JD1KERUCk98ZXRnBnnvG
	 o7i50NxFKCdsWe97sGCjZhlF6XwW1zEDJRH0wrr0gFCuGRAWnkC65twQLcDXMPuFCP
	 dUsqKh2CRhaPyNAWNMp+Nqi/XqvCIcJ8FWTpAKMeCg5a3W6E+pLdwuwFwOi77PL86R
	 hqoA1YQBuH6l7LcEbZ5tawJpXZ4cBt72pebRmdZ1982K6PkrkOMgDLAOnQg+B40PJC
	 6aj1IEJuKx5Ry8+YO4jwPUQZk+LO8utjRG6HdPnM2cq+Y53kNwPOAoch6Mlx9YCGqg
	 uQwV5KiA3sbsQ==
Date: Wed, 15 Jan 2025 15:00:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, p.zabel@pengutronix.de, robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [PATCH v9 0/2] PCI: add enabe(disable)_device() hook for bridge
Message-ID: <20250115210010.GA551375@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86bjw8wj05.wl-maz@kernel.org>

On Wed, Jan 15, 2025 at 08:58:50AM +0000, Marc Zyngier wrote:
> On Tue, 14 Jan 2025 22:33:41 +0000,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > On Tue, Jan 14, 2025 at 03:37:07PM -0500, Frank Li wrote:
> > > Some system's IOMMU stream(master) ID bits(such as 6bits) less than
> > > pci_device_id (16bit). It needs add hardware configuration to enable
> > > pci_device_id to stream ID convert.
> > > 
> > > https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
> > > This ways use pcie bus notifier (like apple pci controller), when new PCIe
> > > device added, bus notifier will call register specific callback to handle
> > > look up table (LUT) configuration.
> > > 
> > > https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
> > > which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
> > > table (qcom use this way). This way is rejected by DT maintainer Rob.
> > > 
> > > Above ways can resolve LUT take or stream id out of usage the problem. If
> > > there are not enough stream id resource, not error return, EP hardware
> > > still issue DMA to do transfer, which may transfer to wrong possition.
> > > 
> > > Add enable(disable)_device() hook for bridge can return error when not
> > > enough resource, and PCI device can't enabled.
> > > 
> > > Basicallly this version can match Bjorn's requirement:
> > > 1: simple, because it is rare that there are no LUT resource.
> > > 2: EP driver probe failure when no LUT, but lspci can see such device.
> > > 
> > > [    2.164415] nvme nvme0: pci function 0000:01:00.0
> > > [    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
> > > [    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12
> > > 
> > > > lspci
> > > 0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
> > > 0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)
> > > 
> > > To: Bjorn Helgaas <bhelgaas@google.com>
> > > To: Richard Zhu <hongxing.zhu@nxp.com>
> > > To: Lucas Stach <l.stach@pengutronix.de>
> > > To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > To: Krzysztof Wilczyński <kw@linux.com>
> > > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > To: Rob Herring <robh@kernel.org>
> > > To: Shawn Guo <shawnguo@kernel.org>
> > > To: Sascha Hauer <s.hauer@pengutronix.de>
> > > To: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > To: Fabio Estevam <festevam@gmail.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: imx@lists.linux.dev
> > > Cc: Frank.li@nxp.com \
> > > Cc: alyssa@rosenzweig.io \
> > > Cc: bpf@vger.kernel.org \
> > > Cc: broonie@kernel.org \
> > > Cc: jgg@ziepe.ca \
> > > Cc: joro@8bytes.org \
> > > Cc: l.stach@pengutronix.de \
> > > Cc: lgirdwood@gmail.com \
> > > Cc: maz@kernel.org \
> > > Cc: p.zabel@pengutronix.de \
> > > Cc: robin.murphy@arm.com \
> > > Cc: will@kernel.org \
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > 
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > Applied to pci/controller/imx6 for v6.14, thanks!  And thanks for your
> > patience.
> 
> While you're at it, could you please consider [1], which builds on top
> of the same infrastructure to remove the Apple PCIe IOMMU hack?
> 
> [1] https://lore.kernel.org/linux-pci/20241204150145.800408-1-maz@kernel.org/

Done, thanks for the reminder!

