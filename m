Return-Path: <bpf+bounces-31217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 515B28D87CA
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5FB2846BC
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84E913698B;
	Mon,  3 Jun 2024 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhwFWKSS"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483F31366;
	Mon,  3 Jun 2024 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717435165; cv=none; b=d3YA+eOQuDCQ2a3Kg4EjCZeV0DGMF2QFJRLtdmFEumhS4Wdys8xXPE0ppTym/WfiNZjubL/K1yHm80JfsEl+FZ8Ol0nE0jSf1ojSVFWTrQnNwPc3QUhO/0xu1YfgM5GU4btl5VMWOYta0x4tjdJbuOoysnw6S8WnxACzbk+p9Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717435165; c=relaxed/simple;
	bh=o+oMkH1I/WbYDZBa3qcXo8pOhVZODTPPaT5jeLn7qIU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=XfUIR+Wknw80lfl4SkipQrYQBEgaDUMnMwTNzPJBmFhG42xr5s92WImA9/5Z3q/ILqc02uGEAJhudIUEkhi0dL+IYTH4fYb5nw2XjbeXTc2CzCgqN2wHglQrtOrXnsB7B+bSu5ghmlIeyaUaSoK/wyAB6O3vmUjlSXppShj4xco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhwFWKSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6583AC2BD10;
	Mon,  3 Jun 2024 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717435163;
	bh=o+oMkH1I/WbYDZBa3qcXo8pOhVZODTPPaT5jeLn7qIU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hhwFWKSSd4vV2hTYoNib68G4aE53A9hjm/qJTppKcaTVXqZ3K4F8FnfKdI32g6R3a
	 luQD8Z1RYHtLwXs/M4NQm1fJAZTRopSgdO0Qd1pfmpGSIjWtjcPMnzrzxaKgxM9H33
	 CxTXWuL1hlBkHGtPKRVAcKxUyGElF8oR2vHTLhHFWTJ20+qfZJwH52g8tNJs1qQkOX
	 d56VBM/qpQ/5gtIL6YY7XK+4+BS34uQx8Rw3B2QRMGeObdl9V/+S8TC/qp9mJY6MtV
	 CdUAFpYDItJ8i6wpM/BKPyNsSLCDzPpJ38jiex4vFTOBdxidxBBuNCg4W4RS3deaJt
	 NFjppavpkC5Jg==
Date: Mon, 3 Jun 2024 12:19:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Frank Li <Frank.Li@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <20240603171921.GA685838@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <974f1d23-aba8-432e-85b5-0e4b1c2005e7@arm.com>

On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
> On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> > [+cc IOMMU and pcie-apple.c folks for comment]
> > 
> > On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > > This involves examining the msi-map and smmu-map to ensure consistent
> > > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > > registers are configured. In the absence of an msi-map, the built-in MSI
> > > controller is utilized as a fallback.
> > > 
> > > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > > controller. This function configures the correct LUT based on Device Tree
> > > Settings (DTS).
> > 
> > This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> > have to do this, I wish it were *more* similar, i.e., copy the
> > function names, bitmap tracking, code structure, etc.
> > 
> > I don't really know how stream IDs work, but I assume they are used on
> > most or all arm64 platforms, so I'm a little surprised that of all the
> > PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> > this notifier.
> 
> This is one of those things that's mostly at the mercy of the PCIe root
> complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
> is derived directly from the PCI RID, sometimes with additional high-order
> bits hard-wired to disambiguate PCI segments. I believe this RID-translation
> LUT is a particular feature of the the Synopsys IP - I know there's also one
> on the NXP Layerscape platforms, but on those it's programmed by the
> bootloader, which also generates the appropriate "msi-map" and "iommu-map"
> properties to match. Ideally that's what i.MX should do as well, but hey.

Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
see that the LUT CSR accesses use IMX95_* definitions.

> If it's really necessary to do this programming from Linux, then there's
> still no point in it being dynamic - the mappings cannot ever change, since
> the rest of the kernel believes that what the DT said at boot time was
> already a property of the hardware. It would be a lot more logical, and
> likely simpler, for the driver to just read the relevant map property and
> program the entire LUT to match, all in one go at controller probe time.
> Rather like what's already commonly done with the parsing of "dma-ranges" to
> program address-translation LUTs for inbound windows.
> 
> Plus that would also give a chance of safely dealing with bad DTs specifying
> invalid ID mappings (by refusing to probe at all). As it is, returning an
> error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
> further notifiers from running at that point - the device will still be
> added, allowed to bind a driver, and able to start sending DMA/MSI traffic
> without the controller being correctly programmed, which at best won't work
> and at worst may break the whole system.

Frank, could the imx LUT be programmed once at boot-time instead of at
device-add time?  I'm guessing maybe not because apparently there is a
risk of running out of LUT entries?

It sounds like the consequences of running out of LUT entries are
catastrophic, e.g., memory corruption from mis-directed DMA?  If
that's possible, I think we need to figure out how to prevent the
device from being used, not just dev_warn() about it.

Bjorn

