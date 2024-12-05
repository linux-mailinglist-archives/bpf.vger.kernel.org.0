Return-Path: <bpf+bounces-46144-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D17F89E5225
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 11:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583E21881792
	for <lists+bpf@lfdr.de>; Thu,  5 Dec 2024 10:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2698E1D63C7;
	Thu,  5 Dec 2024 10:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvqVQHE9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFF726AFF;
	Thu,  5 Dec 2024 10:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394316; cv=none; b=gE3dvKfpjSqWE8rox0pDUgsZeBcnSuwn+33bD+2S1y7LsTcz2TO0R86pcGDs0nYc+uESSzyc5pwOR3YN6EMDWAJ8WLIoHbQLNxe/8lg2WbBdI3cb80feMoZRKLPh2K+2N8lW7c+ye7hfyk9wYvTvR+LAC+zmG/LERpSSqRQQdkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394316; c=relaxed/simple;
	bh=ZJ4S4rNEnh/7WF34+Cs6LWN0Zkt6lyhksJC0cFFlqIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PloV12F2ZUDR9nui4kvfUOB2I9Rbb8pc0os5KpKhgOHjdQxNz0+1JyXEsHxvoe0uChwhdI2KlbURaZj0Rx5pBEYuGef7Fdd2VDKkNGs+B5rkWUQSjLStDxbNkQI8yTT9YppcXabqrf3UoxK0soctPDRs3iLSiYJIqWRxTm8uijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvqVQHE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B3DC4CED1;
	Thu,  5 Dec 2024 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733394316;
	bh=ZJ4S4rNEnh/7WF34+Cs6LWN0Zkt6lyhksJC0cFFlqIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dvqVQHE9jp7pk+jU9f+CQgDHRpTrZltyTe2qQIEqiJYJUNF3Q0dWjog+pjeeyAiy/
	 8s47hPCgmt9rI4fgwqYPw4048P7C3ISV80w/Q3OjWwqYDs4uKHlJC5X8/3t8Ymb3EK
	 jrEnvQVaX7VrB9Szmz1sqnKvXd55AI8piYeLZCIUtEjPAqKX88bSH7m3hwXXsfK+yN
	 k7Jzx2psRCGDbKKvDAJe+Ob+xIqwAKDpgCXQKXqXROtAHYP6WaPTv83fr/9l5rofe+
	 vwNskYI+POPWTT0o6UVBJLlMWb4rWmeXoUFDWiDl3jdYmIdzJ8VTA4KKZGvX6zjqzs
	 21fCnttBFHqBA==
Date: Thu, 5 Dec 2024 11:25:07 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
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
Subject: Re: [PATCH v7 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <Z1F/g/clUxAIGFZ1@lpieralisi>
References: <20241203-imx95_lut-v7-0-d0cd6293225e@nxp.com>
 <20241203-imx95_lut-v7-2-d0cd6293225e@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203-imx95_lut-v7-2-d0cd6293225e@nxp.com>

On Tue, Dec 03, 2024 at 06:27:16PM -0500, Frank Li wrote:
> For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> This involves examining the msi-map and smmu-map to ensure consistent

This involves checking msi-map and iommu-map device tree properties
to...

> mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> registers are configured. In the absence of an msi-map, the built-in MSI
> controller is utilized as a fallback.
> 
> Register a PCI bus callback function to handle enable_device() and
> disable_device() operations, setting up the LUT whenever a new PCI device
> is enabled.
> 
> Acked-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v5 to v6
> - change comment rid to RID
> - some mini change according to mani's feedback
> 
> Change from v4 to v5
> - rework commt message
> - add comment for mutex
> - s/reqid/rid/
> - keep only one loop when enable lut
> - add warning when try to add duplicate rid
> - Replace hardcode 0xffff with IMX95_PE0_LUT_MASK
> - Fix some error message
> 
> Change from v3 to v4
> - Check target value at of_map_id().
> - of_node_put() for target.
> - add case for msi-map exist, but rid entry is not exist.
> 
> Change from v2 to v3
> - Use the "target" argument of of_map_id()
> - Check if rid already in lut table when enable device
> 
> change from v1 to v2
> - set callback to pci_host_bridge instead pci->ops.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 183 +++++++++++++++++++++++++++++++++-
>  1 file changed, 182 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c8d5c90aa4d45..ac5caa7b05075 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -55,6 +55,22 @@
>  #define IMX95_PE0_GEN_CTRL_3			0x1058
>  #define IMX95_PCIE_LTSSM_EN			BIT(0)
>  
> +#define IMX95_PE0_LUT_ACSCTRL			0x1008
> +#define IMX95_PEO_LUT_RWA			BIT(16)
> +#define IMX95_PE0_LUT_ENLOC			GENMASK(4, 0)
> +
> +#define IMX95_PE0_LUT_DATA1			0x100c
> +#define IMX95_PE0_LUT_VLD			BIT(31)
> +#define IMX95_PE0_LUT_DAC_ID			GENMASK(10, 8)
> +#define IMX95_PE0_LUT_STREAM_ID			GENMASK(5, 0)
> +
> +#define IMX95_PE0_LUT_DATA2			0x1010
> +#define IMX95_PE0_LUT_REQID			GENMASK(31, 16)
> +#define IMX95_PE0_LUT_MASK			GENMASK(15, 0)
> +
> +#define IMX95_SID_MASK				GENMASK(5, 0)
> +#define IMX95_MAX_LUT				32
> +
>  #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
>  
>  enum imx_pcie_variants {
> @@ -87,6 +103,7 @@ enum imx_pcie_variants {
>   * workaround suspend resume on some devices which are affected by this errata.
>   */
>  #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
> +#define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -139,6 +156,9 @@ struct imx_pcie {
>  	struct device		*pd_pcie_phy;
>  	struct phy		*phy;
>  	const struct imx_pcie_drvdata *drvdata;
> +
> +	/* Ensure that only one device's LUT is configured at any given time */
> +	struct mutex		lock;
>  };
>  
>  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> @@ -930,6 +950,159 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
>  	imx_pcie_ltssm_disable(dev);
>  }
>  
> +static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 rid, u8 sid)
> +{
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct device *dev = pci->dev;
> +	u32 data1, data2;
> +	int free = -1;
> +	int i;
> +
> +	if (sid >= 64) {
> +		dev_err(dev, "Invalid SID for index %d\n", sid);
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&imx_pcie->lock);
> +
> +	/*
> +	 * Iterate through all LUT entries to check for duplicate RID and
> +	 * identify the first available entry. Configure this available entry
> +	 * immediately after verification to avoid rescanning it.
> +	 */
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> +
> +		if (!(data1 & IMX95_PE0_LUT_VLD)) {
> +			if (free < 0)
> +				free = i;
> +			continue;
> +		}
> +
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> +
> +		/* Do not add duplicate RID */
> +		if (rid == FIELD_GET(IMX95_PE0_LUT_REQID, data2)) {
> +			dev_warn(dev, "Existing LUT entry available for RID (%d)", rid);
> +			return 0;
> +		}
> +	}
> +
> +	if (free < 0) {
> +		dev_err(dev, "LUT entry is not available\n");
> +		return -ENOSPC;
> +	}
> +
> +	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> +	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> +	data1 |= IMX95_PE0_LUT_VLD;
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> +
> +	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of RID */
> +	data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, rid);
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> +
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, free);
> +
> +	return 0;
> +}
> +
> +static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 rid)
> +{
> +	u32 data2;
> +	int i;
> +
> +	guard(mutex)(&imx_pcie->lock);
> +
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> +		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == rid) {
> +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
> +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
> +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> +
> +			break;
> +		}
> +	}
> +}
> +
> +static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> +{
> +	struct imx_pcie *imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> +	u32 sid_i, sid_m, rid = pci_dev_id(pdev);
> +	struct device_node *target;
> +	struct device *dev;
> +	int err_i, err_m;
> +
> +	dev = imx_pcie->pci->dev;
> +
> +	target = NULL;
> +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> +	if (target)
> +		of_node_put(target);
> +	else
> +		err_i = -EINVAL;

Why ? If target == NULL err_i is already set to a negative value ?

> +
> +	target = NULL;
> +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> +
> +	/*
> +	 * Return failure if msi-map exist and no entry for RID because dwc common
> +	 * driver will skip setting up built-in MSI controller if msi-map existed.

This is not ideal - to depend on the DWC common driver behaviour.

> +	 *
> +	 *   err_m      target
> +	 *	0	NULL		Return failure, function not work.
> +	 *      !0      NULL		msi-map not exist, use built-in MSI.
					^^^^
"function not work" does not mean anything, sorry. What is it meant to
say ?

!=0

> +	 *	0	!NULL		Find one entry.
> +	 *	!0	!NULL		Invalidate case.

"Find one entry", "Invalidate case", I don't understand what they mean.

!=0 !=NULL

> +	 */
> +	if (!err_m && !target)
> +		return -EINVAL;
> +	else if (target)
> +		of_node_put(target); /* Find entry for RID in msi-map */
> +
> +	/*
> +	 * msi-map        iommu-map
> +	 *   Y                Y            ITS + SMMU, require the same sid
> +	 *   Y                N            ITS
> +	 *   N                Y            DWC MSI Ctrl + SMMU
> +	 *   N                N            DWC MSI Ctrl
> +	 */
> +	if (!err_i && !err_m)
> +		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {

Here you mask sid_i

> +			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
> +			return -EINVAL;
> +		}
> +
> +	/*
> +	 * Both iommu-map and msi-map not exist, use dwc built-in MSI
> +	 * controller, do nothing here.
> +	 */
> +	if (err_i && err_m)
> +		return 0;
> +
> +	if (!err_i)
> +		return imx_pcie_add_lut(imx_pcie, rid, sid_i);

Here you don't ?

Moreover - this would also cater for the case where (!err_i && !err_m) is
true ?

Probably cleaner to do:
	u32 sid;

	if (err_i && err_m)
		return 0;

	if (!err_i && !err_m) {
		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
			dev_err(dev, "iommu-map and msi-map entries mismatch!\n");
			return -EINVAL;
		}
	}

	if (!err_i)
		sid = sid_i & IMX95_SID_MASK;
	else if (!err_m)
		sid = sid_m & IMX95_SID_MASK;

	return imx_pcie_add_lut(imx_pcie, rid, sid);
> +	else if (!err_m)
> +		/*
> +		 * Hardware auto add 2 bits controller id ahead of stream ID,
> +		 * so mask this 2bits to get stream ID.
> +		 */
> +		return imx_pcie_add_lut(imx_pcie, rid, sid_m & IMX95_SID_MASK);
> +
> +	return 0;

return 0; is dead code AFAICS.

> +}
> +
> +static void imx_pcie_disable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> +{
> +	struct imx_pcie *imx_pcie;
> +
> +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> +}
> +
>  static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -946,6 +1119,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		}
>  	}
>  
> +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> +		pp->bridge->enable_device = imx_pcie_enable_device;
> +		pp->bridge->disable_device = imx_pcie_disable_device;
> +	}
> +
>  	imx_pcie_assert_core_reset(imx_pcie);
>  
>  	if (imx_pcie->drvdata->init_phy)
> @@ -1330,6 +1508,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	imx_pcie->pci = pci;
>  	imx_pcie->drvdata = of_device_get_match_data(dev);
>  
> +	mutex_init(&imx_pcie->lock);
> +
>  	/* Find the PHY if one is defined, only imx7d uses it */
>  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
>  	if (np) {
> @@ -1627,7 +1807,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX95] = {
>  		.variant = IMX95,
> -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> +			 IMX_PCIE_FLAG_HAS_LUT,
>  		.clk_names = imx8mq_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> 
> -- 
> 2.34.1
> 

