Return-Path: <bpf+bounces-31216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F218D87B4
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 19:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF081F2350E
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA33136E39;
	Mon,  3 Jun 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IskPVtkR"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C056012EBCA;
	Mon,  3 Jun 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434711; cv=none; b=e22L1we2FdgaX3mbFu+8h8B5vdY22O4szrtOfjtSSPAeNvTlY/0tZBVlzBgSegS9nnDL3jsaBLqCTEADfjAgOK9NL5YpUgVMzOS0UmJcjXGJCO0dlSboH5P2fJxtVDLpMm2nV4WeceLabAmNpujsYi/sD+qn9vOdAHNeohAvIz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434711; c=relaxed/simple;
	bh=i4qNqKBBW9MS/3cabi3B6YUjPjcvwTN3tabqpknsbok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GmcfXsDjsC5unGgWfPDC/O18Ld91yPErlrTvH2nBVsRfe8P/HliT9JKanHUIp4T+T+CwLGr6H9gOId6JAKpBcJJ9RfnYIN7ag31UJDE+V02d9d+qxS1ozbz+Ep+Yz66CJtd7kCRtH2obdEo2tB2QRHzwK0itkkhoH6SmV92jd/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IskPVtkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09183C2BD10;
	Mon,  3 Jun 2024 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717434711;
	bh=i4qNqKBBW9MS/3cabi3B6YUjPjcvwTN3tabqpknsbok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IskPVtkRLcXqswqt5Z9Yt26xtJugDU7NoYLA91Xz03aHeSf/68YOcGpeyet22K/uN
	 CGJKU4Ax6gmVP+obsNuJYi7dLS8e9l6ikQQ90IkHuNMKf5SoHLo9nE+NfggMAjev9k
	 U/byZZkYySDjwi0TZ3xGln2UbTSnd5sfIZMNIHEm1GRs4/LSVHe5Opn7S+l9+0cJK+
	 mu+RXG9X3oFm5sXPwDXDSO7oeIVGdYZuNtdGN8PCh3PaFXdZdk/c/pFAyZL7vdowqb
	 +kmhi3NJoYyTFwyIQFYsz8d2bophoijGhIb0k4JqhWe7qCwFI7ZEmhzsRxx1OVoR8l
	 yfQkIEXIb7H5Q==
Date: Mon, 3 Jun 2024 12:11:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
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
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <20240603171149.GA685507@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zln3WkiHC3AUPocL@lizhi-Precision-Tower-5810>

On Fri, May 31, 2024 at 12:14:18PM -0400, Frank Li wrote:
> On Thu, May 30, 2024 at 06:08:32PM -0500, Bjorn Helgaas wrote:
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
> 
> Actually, I refer apple_pcie_bus_notifier(). I can't direct use apple's
> implement because in imx95 have difference PCI host controller, another one
> is PCI ECAM netc controller. At lease function name should be similar with
> apple. 

I know it's different hardware, so obviously it can't be exactly the
same.  These are the differences that looked possibly unnecessary:

  - registering from initcall instead of .probe():

      apple_pcie_probe                  # .probe() method
        bus_register_notifier(&pci_bus_type, &apple_pcie_nb)

      imx_pcie_init                     # device_initcall()
        bus_register_notifier(&pci_bus_type, &imx_pcie_nb)

  - naming BUS_NOTIFY_DEL_DEVICE function:

      apple_pcie_release_device()
      imx_pcie_del_device()

  - tracking entries in use via bitmap vs scanning hardware for
    invalid entries:

      bitmap_find_free_region           # apple

      imx_pcie_config_lut               # imx
        for (i = 0; i < IMX95_MAX_LUT; i++)
          regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1)
          if (data1 & IMX95_PE0_LUT_VLD)
            continue

When we fix a bug in one driver, it's easier to check whether other
drivers also need the fix if they use the same structure and names.

Bjorn

