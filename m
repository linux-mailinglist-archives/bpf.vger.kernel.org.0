Return-Path: <bpf+bounces-48866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DEA9A11426
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 23:33:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9AF7A24A9
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 22:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC0D2135C4;
	Tue, 14 Jan 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2XS6atB"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6431D5142;
	Tue, 14 Jan 2025 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736894023; cv=none; b=r0qmkaJnWxYqQynVmQZrFeC4wVTm4LfPBGrAsPtoQojNSkcfJYba26uGuzGstViy5AQ7WOOaKccbuGya2Tkwys33ICiHOLG/awK51RpUla5zZXWCI8QjdX9k6gNyOE06MaKYjOz4ENBPxaBtQD4UwQITP/zYsf00TWnfd5g83e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736894023; c=relaxed/simple;
	bh=H6CKNDmx6xA1psmtXt5bj2TfFAV1nP2dHPlIqFZRk7c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=O5pfEaKICx0+3JHeBZytID9E+sBV6bu8Lyaok+99k7sV2jtnlnx6OtshAvKxL5H1LtHD2e64EMXDrl0xInY6bp6QB/w93Z7vBRpYnNWlWUrUpHY7PRSOtMzmDmuD1omNjqX198bNMCHBAi0DgiDX9byjxFIUbfbCC2MgfnY/b04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2XS6atB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49F5C4CEDD;
	Tue, 14 Jan 2025 22:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736894023;
	bh=H6CKNDmx6xA1psmtXt5bj2TfFAV1nP2dHPlIqFZRk7c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=G2XS6atBxbT+/Luwusho35E9ExirRGSfm/EC604udBMp9EZPiuKzKq32BQxgcrLh4
	 UsC3fWCHgbEVg/t1TnH+Uv792bGbgUDG2iZdGXVkR5l4kRppG+WuZSRDobyjQ0vanz
	 Ne/RZMerEpMv75aeleCk2EmHpkNhKW1iIm1ur7g59xJm5pPsCX6icx7C9F0iSsxmul
	 xR5kEClDzI5LVeBPlRF9Fra8xsfEWPIad2+AQ6B0ojKMHSZu3NEjffjTxbcP1g5rKw
	 Oog8zIWMc8aqnNf9Jd4nyIQP86CcG23PunRxHJI/CfyyW1Q3JCM/d/TT5dJ1XSFHfI
	 yY8kHiNyfFF2A==
Date: Tue, 14 Jan 2025 16:33:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
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
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v9 0/2] PCI: add enabe(disable)_device() hook for bridge
Message-ID: <20250114223341.GA495433@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114-imx95_lut-v9-0-39f58dbed03a@nxp.com>

On Tue, Jan 14, 2025 at 03:37:07PM -0500, Frank Li wrote:
> Some system's IOMMU stream(master) ID bits(such as 6bits) less than
> pci_device_id (16bit). It needs add hardware configuration to enable
> pci_device_id to stream ID convert.
> 
> https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
> This ways use pcie bus notifier (like apple pci controller), when new PCIe
> device added, bus notifier will call register specific callback to handle
> look up table (LUT) configuration.
> 
> https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
> which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
> table (qcom use this way). This way is rejected by DT maintainer Rob.
> 
> Above ways can resolve LUT take or stream id out of usage the problem. If
> there are not enough stream id resource, not error return, EP hardware
> still issue DMA to do transfer, which may transfer to wrong possition.
> 
> Add enable(disable)_device() hook for bridge can return error when not
> enough resource, and PCI device can't enabled.
> 
> Basicallly this version can match Bjorn's requirement:
> 1: simple, because it is rare that there are no LUT resource.
> 2: EP driver probe failure when no LUT, but lspci can see such device.
> 
> [    2.164415] nvme nvme0: pci function 0000:01:00.0
> [    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
> [    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12
> 
> > lspci
> 0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
> 0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Richard Zhu <hongxing.zhu@nxp.com>
> To: Lucas Stach <l.stach@pengutronix.de>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kw@linux.com>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Rob Herring <robh@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: imx@lists.linux.dev
> Cc: Frank.li@nxp.com \
> Cc: alyssa@rosenzweig.io \
> Cc: bpf@vger.kernel.org \
> Cc: broonie@kernel.org \
> Cc: jgg@ziepe.ca \
> Cc: joro@8bytes.org \
> Cc: l.stach@pengutronix.de \
> Cc: lgirdwood@gmail.com \
> Cc: maz@kernel.org \
> Cc: p.zabel@pengutronix.de \
> Cc: robin.murphy@arm.com \
> Cc: will@kernel.org \
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied to pci/controller/imx6 for v6.14, thanks!  And thanks for your
patience.

> ---
> Changes in v9:
> - update commit message and comments
> - Rob agree use API to parse iommu-map and msi-map.
> https://lore.kernel.org/imx/20250113225905.GA3325507-robh@kernel.org/
> - Link to v8: https://lore.kernel.org/r/20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com
> 
> Changes in v8:
> - update comment message according to Lorenzo Pieralisi's suggestion.
> - rework err target table
> - improve err==0 && target ==NULL description, use 1:1 map RID to
> stream ID.
> - invalidate case -> unexisted case, never happen
> - sid_i will not do mask, add comments said only MSI glue layer add
> controller id.
> - rework iommu map and msi map return value check logic according to
> Lorenzo Pieralisi's suggestion
> - Link to v7: https://lore.kernel.org/r/20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com
> 
> Changes in v7:
> - Rebase v6.13-rc1
> - Update patch 2 according to mani's feedback
> - Link to v6: https://lore.kernel.org/r/20241118-imx95_lut-v6-0-a2951ba13347@nxp.com
> 
> Changes in v6:
> - Bjorn give review tags at v4, but v5 have big change, drop Bjorn's review
> tag.
> - Add back Marc Zyngier't review and test tags
> - Add mani's ack at first patch
> - Mini change for patch 2 according to mani's feedback
> - Link to v5: https://lore.kernel.org/r/20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com
> 
> Changes in v5:
> - Add help function of pci_bridge_enable(disable)_device
> - Because big change, removed Bjorn's review tags and have not
> added
> Marc Zyngier't review and test tags
> - Fix pci-imx6.c according to Mani's feedback
> - Link to v4: https://lore.kernel.org/r/20241101-imx95_lut-v4-0-0fdf9a2fe754@nxp.com
> 
> Changes in v4:
> - Add Bjorn Helgaas review tag for patch1
> - check 'target' value for patch2
> - detail see each patches
> - Link to v3: https://lore.kernel.org/r/20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com
> 
> Changes in v3:
> - disable_device when error happen
> - use target for of_map_id
> - Check if rid already in lut table when enable deviced
> - Link to v2: https://lore.kernel.org/r/20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com
> 
> Changes in v2:
> - see each patch
> - Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com
> 
> ---
> Frank Li (2):
>       PCI: Add enable_device() and disable_device() callbacks for bridges
>       PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 199 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.c                     |  36 +++++-
>  include/linux/pci.h                   |   2 +
>  3 files changed, 235 insertions(+), 2 deletions(-)
> ---
> base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
> change-id: 20240926-imx95_lut-1c68222e0944
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 

