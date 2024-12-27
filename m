Return-Path: <bpf+bounces-47655-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8BA9FD2E7
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 11:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25711188029C
	for <lists+bpf@lfdr.de>; Fri, 27 Dec 2024 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C5D198E76;
	Fri, 27 Dec 2024 09:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia2oX5vh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC1158853;
	Fri, 27 Dec 2024 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735293504; cv=none; b=i/+oykNirJtPUTahFqemZIwJ9vbGlvxpIh8H76GrF2hw2TCNHmI0Hc4sGBoCwiqmXYngq8n+ufLaFYXRSw9IsVgI+L2WWSiua/b9U9D0KCsY8J6tbf4Y9ehpxd8WovipOW5cqKmvWWm+AIwOp+4mksxvfpsetVvTrmFZKl2zsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735293504; c=relaxed/simple;
	bh=ZVmriFc0XH8plJi+hYMOKP3vwmebzeJP8fVsrXKydSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgKDR5rVDqjZpoFa3OdWdJ5aQk6OO2Imh25lR8Pw77Ag9LXJwUVxlUPoTlnQSLWei4lzC6RW2L+EO2Kthl/lFov/H66IblN049D4Tdx87LR3youxij30mqtjq3/QMfA57F1evBBlZNDNrywnNI1Tr0Dh/JSZm6fyECPNS4N65Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia2oX5vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27EDC4CED0;
	Fri, 27 Dec 2024 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735293504;
	bh=ZVmriFc0XH8plJi+hYMOKP3vwmebzeJP8fVsrXKydSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ia2oX5vhH9xnoYZFCBcJPyyWOyOerSgWktBrvllCNkRMLfc9xow0moCafOLrn01yJ
	 6kFQdDaqa9yysEQ2mmEe3XtjLqE24Q1TJw4cSY9qDQZQIgwMxWj8SniQFIDHmKtmUp
	 tYhNgN2au2JAFFhVQ+/Q4kHZIXr2sWfH56O9u0IDhaRZQ3EzlN4Hx6mUbn7YLcWFKM
	 eAU88glX1Kk3faaL5bolHsAt9RvB9HBQ3iOCJzhexsqfddpHzVhvx/5ynuAn6wFE9n
	 g4vReSPXngynS1Kc4xIskATnCH/g9znuPu2hB6OqnurXTumSKETRWgh0AGggexFHbT
	 Xz2SFs7F/39Gg==
Date: Fri, 27 Dec 2024 10:58:15 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.li@nxp.com>, Rob Herring <robh@kernel.org>,
	robin.murphy@arm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
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
Subject: Re: [PATCH v8 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <Z256NxZF/+jO2bkR@lpieralisi>
References: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
 <20241210-imx95_lut-v8-2-2e730b2e5fde@nxp.com>
 <Z1sTUaoA5yk9RcIc@lpieralisi>
 <Z1sdbH7N1Ly9eXc0@lizhi-Precision-Tower-5810>
 <Z1v/LCHsGOgnasuf@lpieralisi>
 <Z1xs6GkcdTg2c73F@lizhi-Precision-Tower-5810>
 <Z2FDp1zQ7JzxQKJT@lpieralisi>
 <Z2GdvpzT6MOygG4W@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2GdvpzT6MOygG4W@lizhi-Precision-Tower-5810>

On Tue, Dec 17, 2024 at 10:50:22AM -0500, Frank Li wrote:

[...]

> > > > Right. Question: what happens if DT shows that there are SMMU and/or
> > > > ITS bindings/mappings but the SMMU driver and ITS driver are either not
> > > > enabled or have not probed ?
> > >
> > > It is little bit complex.
> > > iommu:
> > > Case 1:
> > > 	iommu{
> > > 		status = "disabled"
> > > 	};
> > >
> > > 	PCI driver normal probed. if RID is in range of iommu-map, not
> > > any functional impact and harmless.
> > > 	If RID is out of range of iommu-map, "false alarm" will return.
> > > enable PCI EP device failure, but actually it can work without IOMMU.
> >
> > What does "false alarm" mean in practice ? PCI device enable fails
> > but actually it should not ?
> 
> Yes, you are right. It should work without iommu. but return failure for
> this case.

Rob, Robin, are you OK with this patch DT bindings usage (and the
related dependencies described in Frank's reply) ?

I am referring to "iommu-map" and "msi-map" usage, everything else
is platform specific code.

It looks like things can break in multiple ways but I don't want
to hold up this series forever.

Thanks,
Lorenzo

> > That does not look like a false alarm to me.
> 
> My means:  return failure but it should work without iommu. Ideally
> of_map_id() should return failure when iommu is disabled. It needs more
> work for that. I think we can improve it later.
> 
> >
> > >
> > > Case 2:
> > > 	iommu {
> > > 		status = "Okay"
> > > 	}
> > > 	but iommu driver have not probed yet.  PCI Host bridge driver
> > > should defer till iommu probed.
> > >
> > > Worst case is "false alarm". But this happen is very rare if DTS is
> > > correct.
> >
> > Explain what this means.
> 
> It return failure, but it should return success if "iommu disabled" and
> "RID is out of iommu-map range".
> 
> >
> > > MSI:
> > > case 1:
> > > 	msi-controller {
> > > 		status = "disabled";
> > > 	}
> > > 	Whole all dwc drivers will be broken.
> >
> > What MSI controller. Please make an effort to be precise and explain.
> 
> For example: ARM its, I use general term here because some other platform
> such as RISC V have not use ARM ITS.
> 
> pcie {
> 	...
> 	msi-map= <...>
> 	...
> }
> 
> DWC common driver will check property "msi-map". if it exist, built-in
> MSI controller will skip init by history reason. That is also the another
> reason why Rob don't want us to check these standard property.
> 
> Without MSI, system will failure back to INTx mode, same to no-msi=yes.
> But some EP devices require MSI support.
> 
> Frank
> 
> >
> > Thanks,
> > Lorenzo
> >
> > > case 2:
> > > 	msi-controller {
> > > 		status = "Okay"
> > > 	}
> > > 	if msi driver have not probed yet, PCI Host bridge driver will
> > > defer.
> > >
> > > Frank
> > >
> > > >
> > > > I assume the LUT programming makes no difference (it is useless yes but
> > > > should be harmless too) in this case but wanted to check with you`.
> > > >
> > > > Thanks,
> > > > Lorenzo
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Register a PCI bus callback function to handle enable_device() and
> > > > > > > disable_device() operations, setting up the LUT whenever a new PCI device
> > > > > > > is enabled.
> > > > > > >
> > > > > > > Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > >
> > > > > [...]
> > > > >
> > > > > > > +	int err_i, err_m;
> > > > > > > +	u32 sid;
> > > > > > > +
> > > > > > > +	dev = imx_pcie->pci->dev;
> > > > > > > +
> > > > > > > +	target = NULL;
> > > > > > > +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> > > > > > > +	if (target) {
> > > > > > > +		of_node_put(target);
> > > > > > > +	} else {
> > > > > > > +		/*
> > > > > > > +		 * "target == NULL && err_i == 0" means use 1:1 map RID to
> > > > > >
> > > > > > Is it what it means ? Or does it mean that the iommu-map property was found
> > > > > > and RID is out of range ?
> > > > >
> > > > > yes, if this happen, sid_i will be equal to RID.
> > > > >
> > > > > >
> > > > > > Could you point me at a sample dts for this host bridge please ?
> > > > >
> > > > > https://github.com/nxp-imx/linux-imx/blob/lf-6.6.y/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > > >
> > > > > /* 0x10~0x17 stream id for pci0 */
> > > > >    iommu-map = <0x000 &smmu 0x10 0x1>,
> > > > >                <0x100 &smmu 0x11 0x7>;
> > > > >
> > > > > /* msi part */
> > > > >    msi-map = <0x000 &its 0x10 0x1>,
> > > > >              <0x100 &its 0x11 0x7>;
> > > > >
> > > > > >
> > > > > > > +		 * stream ID. Hardware can't support this because stream ID
> > > > > > > +		 * only 5bits
> > > > > >
> > > > > > It is 5 or 6 bits ? From GENMASK(5, 0) above it should be 6.
> > > > >
> > > > > Sorry for typo. it is 6bits.
> > > > >
> > > > > >
> > > > > > > +		 */
> > > > > > > +		err_i = -EINVAL;
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	target = NULL;
> > > > > > > +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 *   err_m      target
> > > > > > > +	 *	0	NULL		Use 1:1 map RID to stream ID,
> > > > > >
> > > > > > Again, is that what it really means ?
> > > > > >
> > > > > > > +	 *				Current hardware can't support it,
> > > > > > > +	 *				So return -EINVAL.
> > > > > > > +	 *      != 0    NULL		msi-map not exist, use built-in MSI.
> > > > > >
> > > > > > does not exist.
> > > > > >
> > > > > > > +	 *	0	!= NULL		Get correct streamID from RID.
> > > > > > > +	 *	!= 0	!= NULL		Unexisted case, never happen.
> > > > > >
> > > > > > "Invalid combination"
> > > > > >
> > > > > > > +	 */
> > > > > > > +	if (!err_m && !target)
> > > > > > > +		return -EINVAL;
> > > > > > > +	else if (target)
> > > > > > > +		of_node_put(target); /* Find stream ID map entry for RID in msi-map */
> > > > > > > +
> > > > > > > +	/*
> > > > > > > +	 * msi-map        iommu-map
> > > > > > > +	 *   N                N            DWC MSI Ctrl
> > > > > > > +	 *   Y                Y            ITS + SMMU, require the same sid
> > > > > > > +	 *   Y                N            ITS
> > > > > > > +	 *   N                Y            DWC MSI Ctrl + SMMU
> > > > > > > +	 */
> > > > > > > +	if (err_i && err_m)
> > > > > > > +		return 0;
> > > > > > > +
> > > > > > > +	if (!err_i && !err_m) {
> > > > > > > +		/*
> > > > > > > +		 * MSI glue layer auto add 2 bits controller ID ahead of stream
> > > > > >
> > > > > > What's "MSI glue layer" ?
> > > > >
> > > > > It is common term for IC desgin, which connect IP's signal to platform with
> > > > > some simple logic. Inside chip, when connect LUT output 6bit streamIDs
> > > > > to MSI controller, there are 2bits hardcode controller ID information
> > > > > append to 6 bits streamID.
> > > > >
> > > > >            Glue Layer
> > > > >           <==========>
> > > > > ┌─────┐                  ┌──────────┐
> > > > > │ LUT │ 6bit stream ID   │          │
> > > > > │     ┼─────────────────►│  MSI     │
> > > > > └─────┘    2bit ctrl ID  │          │
> > > > >             ┌───────────►│          │
> > > > >             │            │          │
> > > > >  00 PCIe0   │            │          │
> > > > >  01 ENETC   │            │          │
> > > > >  10 PCIe1   │            │          │
> > > > >             │            └──────────┘
> > > > >
> > > > > >
> > > > > > > +		 * ID, so mask this 2bits to get stream ID.
> > > > > > > +		 * But IOMMU glue layer doesn't do that.
> > > > > >
> > > > > > and "IOMMU glue layer" ?
> > > > >
> > > > > See above.
> > > > >
> > > > > Frank
> > > > >
> > > > > >
> > > > > > > +		 */
> > > > > > > +		if (sid_i != (sid_m & IMX95_SID_MASK)) {
> > > > > > > +			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
> > > > > > > +			return -EINVAL;
> > > > > > > +		}
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	sid = sid_i;
> > > > > >
> > > > > > err_i could be != 0 here, I understand that the end result is
> > > > > > fine given how the code is written but it is misleading.
> > > > > >
> > > > > > 	if (!err_i)
> > > > > > 	else if (!err_m)
> > > > >
> > > > > Okay
> > > > >
> > > > > >
> > > > > > > +	if (!err_m)
> > > > > > > +		sid = sid_m & IMX95_SID_MASK;
> > > > > > > +
> > > > > > > +	return imx_pcie_add_lut(imx_pcie, rid, sid);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> > > > > > > +{
> > > > > > > +	struct imx_pcie *imx_pcie;
> > > > > > > +
> > > > > > > +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> > > > > > > +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > > >  {
> > > > > > >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > > > > @@ -946,6 +1122,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> > > > > > >  		}
> > > > > > >  	}
> > > > > > >
> > > > > > > +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> > > > > > > +		pp->bridge->enable_device = imx_pcie_enable_device;
> > > > > > > +		pp->bridge->disable_device = imx_pcie_disable_device;
> > > > > > > +	}
> > > > > > > +
> > > > > > >  	imx_pcie_assert_core_reset(imx_pcie);
> > > > > > >
> > > > > > >  	if (imx_pcie->drvdata->init_phy)
> > > > > > > @@ -1330,6 +1511,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
> > > > > > >  	imx_pcie->pci = pci;
> > > > > > >  	imx_pcie->drvdata = of_device_get_match_data(dev);
> > > > > > >
> > > > > > > +	mutex_init(&imx_pcie->lock);
> > > > > > > +
> > > > > > >  	/* Find the PHY if one is defined, only imx7d uses it */
> > > > > > >  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
> > > > > > >  	if (np) {
> > > > > > > @@ -1627,7 +1810,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
> > > > > > >  	},
> > > > > > >  	[IMX95] = {
> > > > > > >  		.variant = IMX95,
> > > > > > > -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> > > > > > > +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> > > > > > > +			 IMX_PCIE_FLAG_HAS_LUT,
> > > > > > >  		.clk_names = imx8mq_clks,
> > > > > > >  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
> > > > > > >  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> > > > > > >
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >

