Return-Path: <bpf+bounces-30983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0588D5608
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 01:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E77EB26C03
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 23:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E2018411B;
	Thu, 30 May 2024 23:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrO4qU00"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD7974042;
	Thu, 30 May 2024 23:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717110515; cv=none; b=Hgv5w11puaOUUew6nvKWu2OffuNCVU1xtVhCtpwvDHU8D4mlaLR2Bh35uRhb9guui4ZVApdF8Tc9Nm0b5OPgDOqGci9oxeDY0yATSZKedjswqSk5jDkCTfx7VanFQr0y50mDi7xPtbI4qcM6mGg+lNFVLsNNRXP2fD9VQjGD2GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717110515; c=relaxed/simple;
	bh=xv63xkQ/N35UIXFUqB556y/E/zx8WT/ylXiP/7xc2yc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=J7APB/n2Az/hExRbMIt85VuplMlmWBmraMFLRHZq94nZdlVX4ieU/fueZFdEsBK5MtojEfK8s1RSW2YFOeAThT5WMddn+1sJaX86M3tLjy7diLaO3EFCGQd+gPvhWH/vZP4ftzTFW03nfFT5udSMlh/yyfKclhCJJrk1Pz1lsAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrO4qU00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AF6C2BBFC;
	Thu, 30 May 2024 23:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717110514;
	bh=xv63xkQ/N35UIXFUqB556y/E/zx8WT/ylXiP/7xc2yc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IrO4qU00oIEISHIrYH786TC5X6IV4zMrAW/cMDr1eqJdXlJddTBcHViUN9MZieXzR
	 5/vmP+ezlB3Q7O8OiIqOVyd6cTb/wzMGvFwGtGeJJGJz2zxhAYqsX9KbSSkTPBt9Ks
	 0xt7rFWxo14YpEcBpQYnprHgL2g8f5tQKXzbwRTUgifFi6MsFFENqJcQtxk9X3Y/0t
	 bX+nfPeUCKG1KkQn2slT/3+CMIXUVGXkxGHYUsU5UJ6mrf5KQXP5HU4Jb/LylKWh5o
	 LQBUsfsXrTsnk2S2QA47hreLv+Mr0xIb8XfbMDf5Sxk1UhXjj2eFRQvr2Xo1HzSVYE
	 nZ78FGY4lh+1g==
Date: Thu, 30 May 2024 18:08:32 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
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
Message-ID: <20240530230832.GA474962@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528-pci2_upstream-v5-8-750aa7edb8e2@nxp.com>

[+cc IOMMU and pcie-apple.c folks for comment]

On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> This involves examining the msi-map and smmu-map to ensure consistent
> mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> registers are configured. In the absence of an msi-map, the built-in MSI
> controller is utilized as a fallback.
> 
> Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> controller. This function configures the correct LUT based on Device Tree
> Settings (DTS).

This scheme is pretty similar to apple_pcie_bus_notifier().  If we
have to do this, I wish it were *more* similar, i.e., copy the
function names, bitmap tracking, code structure, etc.

I don't really know how stream IDs work, but I assume they are used on
most or all arm64 platforms, so I'm a little surprised that of all the
PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
this notifier.  

There's this path, which is pretty generic and does at least the
of_map_id() part of what you're doing in imx_pcie_add_device():

    __driver_probe_device
      really_probe
        pci_dma_configure                       # pci_bus_type.dma_configure
          of_dma_configure
            of_dma_configure_id
              of_iommu_configure
                of_pci_iommu_init
                  of_iommu_configure_dev_id
                    of_map_id
                    of_iommu_xlate
                      ops = iommu_ops_from_fwnode
                      iommu_fwspec_init
                      ops->of_xlate(dev, iommu_spec)

Maybe this needs to be extended somehow with a hook to do the
device-specific work like updating the LUT?  Just speculating here,
the IOMMU folks will know how this is expected to work.

Some typos and minor comments below.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 175 +++++++++++++++++++++++++++++++++-
>  1 file changed, 174 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 29309ad0e352b..8ecc00049e20b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -54,6 +54,22 @@
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
> @@ -79,6 +95,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> +#define IMX_PCIE_FLAG_MONITOR_DEV		BIT(8)
>  
>  #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
>  
> @@ -132,6 +149,8 @@ struct imx_pcie {
>  	struct device		*pd_pcie_phy;
>  	struct phy		*phy;
>  	const struct imx_pcie_drvdata *drvdata;
> +
> +	struct mutex		lock;
>  };
>  
>  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> @@ -215,6 +234,66 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  	return 0;
>  }
>  
> +static int imx_pcie_config_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
> +{
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct device *dev = pci->dev;
> +	u32 data1, data2;
> +	int i;
> +
> +	if (sid >= 64) {
> +		dev_err(dev, "Invalid SID for index %d\n", sid);
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&imx_pcie->lock);
> +
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> +
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> +		if (data1 & IMX95_PE0_LUT_VLD)
> +			continue;
> +
> +		data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> +		data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> +		data1 |= IMX95_PE0_LUT_VLD;
> +
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> +
> +		data2 = 0xffff;
> +		data2 |= FIELD_PREP(IMX95_PE0_LUT_REQID, reqid);
> +
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, data2);
> +
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> +
> +		return 0;
> +	}
> +
> +	dev_err(dev, "All lut already used\n");
> +	return -EINVAL;
> +}
> +
> +static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 reqid)
> +{
> +	u32 data2 = 0;
> +	int i;
> +
> +	guard(mutex)(&imx_pcie->lock);
> +
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> +
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> +		if (FIELD_GET(IMX95_PE0_LUT_REQID, data2) == reqid) {
> +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, 0);
> +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, 0);
> +			regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
> +		}
> +	}
> +}
> +
>  static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
>  {
>  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> @@ -1232,6 +1311,85 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  	return 0;
>  }
>  
> +static bool imx_pcie_match_device(struct pci_bus *bus);

Can you add the imx_pcie_match_device() earlier in the file so we
don't need this forward declaration?

> +static int imx_pcie_add_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
> +{
> +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
> +	struct device *dev = imx_pcie->pci->dev;
> +	int err;
> +
> +	err = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", NULL, &sid_i);
> +	if (err)
> +		return err;
> +
> +	err = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", NULL, &sid_m);
> +	if (err)
> +		return err;
> +
> +	if (sid_i != rid && sid_m != rid)
> +		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
> +			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
> +			return -EINVAL;
> +		}
> +
> +	/* if iommu-map is not existed then use msi-map's stream id*/

Capitalize consistently, e.g., the most comments in this file start
with a capital letter.

s/is not existed/does not exist/

Add space before closing */

> +	if (sid_i == rid)
> +		sid_i = sid_m;
> +
> +	sid_i &= IMX95_SID_MASK;
> +
> +	if (sid_i != rid)
> +		return imx_pcie_config_lut(imx_pcie, rid, sid_i);
> +
> +	/* Use dwc built-in MSI controller */
> +	return 0;
> +}
> +
> +static void imx_pcie_del_device(struct imx_pcie *imx_pcie, struct pci_dev *pdev)
> +{
> +	imx_pcie_remove_lut(imx_pcie, pci_dev_id(pdev));
> +}
> +
> +
> +static int imx_pcie_bus_notifier(struct notifier_block *nb, unsigned long action, void *data)
> +{
> +	struct pci_host_bridge *host;
> +	struct imx_pcie *imx_pcie;
> +	struct pci_dev *pdev;
> +	int err;
> +
> +	pdev = to_pci_dev(data);
> +	host = pci_find_host_bridge(pdev->bus);
> +
> +	if (!imx_pcie_match_device(host->bus))
> +		return NOTIFY_OK;
> +
> +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(host->sysdata));
> +
> +	if (!imx_check_flag(imx_pcie, IMX_PCIE_FLAG_MONITOR_DEV))
> +		return NOTIFY_OK;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		err = imx_pcie_add_device(imx_pcie, pdev);
> +		if (err)
> +			return notifier_from_errno(err);
> +		break;
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		imx_pcie_del_device(imx_pcie, pdev);
> +		break;
> +	default:
> +		return NOTIFY_DONE;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block imx_pcie_nb = {
> +	.notifier_call = imx_pcie_bus_notifier,
> +};
> +
>  static const struct dev_pm_ops imx_pcie_pm_ops = {
>  	NOIRQ_SYSTEM_SLEEP_PM_OPS(imx_pcie_suspend_noirq,
>  				  imx_pcie_resume_noirq)
> @@ -1264,6 +1422,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	imx_pcie->pci = pci;
>  	imx_pcie->drvdata = of_device_get_match_data(dev);
>  
> +	mutex_init(&imx_pcie->lock);
> +
>  	/* Find the PHY if one is defined, only imx7d uses it */
>  	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
>  	if (np) {
> @@ -1551,7 +1711,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX95] = {
>  		.variant = IMX95,
> -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> +			 IMX_PCIE_FLAG_MONITOR_DEV,
>  		.clk_names = imx8mq_clks,
>  		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> @@ -1687,6 +1848,8 @@ DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd,
>  
>  static int __init imx_pcie_init(void)
>  {
> +	int ret;
> +
>  #ifdef CONFIG_ARM
>  	struct device_node *np;
>  
> @@ -1705,7 +1868,17 @@ static int __init imx_pcie_init(void)
>  	hook_fault_code(8, imx6q_pcie_abort_handler, SIGBUS, 0,
>  			"external abort on non-linefetch");
>  #endif
> +	ret = bus_register_notifier(&pci_bus_type, &imx_pcie_nb);
> +	if (ret)
> +		return ret;

I think this should go in imx6_pcie_probe().

>  	return platform_driver_register(&imx_pcie_driver);
>  }
> +
> +static void __exit imx_pcie_exit(void)
> +{
> +	bus_unregister_notifier(&pci_bus_type, &imx_pcie_nb);

It looks like this driver is removable?

What happens when an external abort occurs after the
imx6q_pcie_abort_handler() text is removed?

> +}
> +
>  device_initcall(imx_pcie_init);
> +__exitcall(imx_pcie_exit);
> 
> -- 
> 2.34.1
> 

