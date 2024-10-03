Return-Path: <bpf+bounces-40823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F8598EDF2
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 13:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A44002842BD
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 11:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0CC126BEF;
	Thu,  3 Oct 2024 11:16:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F7152166;
	Thu,  3 Oct 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727954209; cv=none; b=mh+uT11YTlod1t+RLPq8rt/g8C+iRseNS6Th71StQDzuaaZmNDhTimLmtoLSYuo4cTO0aCKGjsDNDc4WRJH/YxOcrol5zzpiu9kRb/7nob0G4KenJSKpCzHRcDMPk8oLJ1Y+NEr3E1tzsGn5Q9J588lF413lNKEVHDoeew4szYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727954209; c=relaxed/simple;
	bh=4w+Vm+rULuVxUlEgpd05uQxotCLVM5aGM7Pb34l6xzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKGxqZid7KY0TQkm5huSpIjYdSSh9xIqfKoMul2XC2+yFTtCdjtm6CLakFIlcHGn5x3qnozE4MTo6x0YG/a3jwZKuGlp6YK1HSO3M9h4Bl0ga9zyNLQVLOeyX7TELqjmJPnLpNJNKtzrR/S4CGmiiEFKNRQx7p4V22VlC9yPb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ADEB339;
	Thu,  3 Oct 2024 04:17:16 -0700 (PDT)
Received: from [10.57.85.26] (unknown [10.57.85.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831413F640;
	Thu,  3 Oct 2024 04:16:42 -0700 (PDT)
Message-ID: <b479cad6-e0c5-48fb-bb8f-a70f7582cfd5@arm.com>
Date: Thu, 3 Oct 2024 12:16:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
To: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca,
 joro@8bytes.org, lgirdwood@gmail.com, maz@kernel.org,
 p.zabel@pengutronix.de, will@kernel.org
References: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
 <20240930-imx95_lut-v2-2-3b6467ba539a@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240930-imx95_lut-v2-2-3b6467ba539a@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-30 8:42 pm, Frank Li wrote:
> For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> This involves examining the msi-map and smmu-map to ensure consistent
> mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> registers are configured. In the absence of an msi-map, the built-in MSI
> controller is utilized as a fallback.
> 
> Additionally, register a PCI bus callback function enable_device() and
> disable_device() to config LUT when enable a new PCI device.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v1 to v2
> - set callback to pci_host_bridge instead pci->ops.
> ---
>   drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
>   1 file changed, 132 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 94f3411352bf0..29186058ba256 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -55,6 +55,22 @@
>   #define IMX95_PE0_GEN_CTRL_3			0x1058
>   #define IMX95_PCIE_LTSSM_EN			BIT(0)
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
>   #define to_imx_pcie(x)	dev_get_drvdata((x)->dev)
>   
>   enum imx_pcie_variants {
> @@ -82,6 +98,7 @@ enum imx_pcie_variants {
>   #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
>   #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>   #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> +#define IMX_PCIE_FLAG_HAS_LUT			BIT(8)
>   
>   #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>   
> @@ -134,6 +151,7 @@ struct imx_pcie {
>   	struct device		*pd_pcie_phy;
>   	struct phy		*phy;
>   	const struct imx_pcie_drvdata *drvdata;
> +	struct mutex		lock;
>   };
>   
>   /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> @@ -925,6 +943,111 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
>   	imx_pcie_ltssm_disable(dev);
>   }
>   
> +static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)
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

Maybe check if an existing entry already exists for the given RID?

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

...plus then you could safely return early here.

> +		}
> +	}
> +}
> +
> +static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> +{
> +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
> +	struct imx_pcie *imx_pcie;
> +	struct device *dev;
> +	int err;
> +
> +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> +	dev = imx_pcie->pci->dev;
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

Perhaps it is reasonable to assume that i.MX95 will never have SMMU/ITS 
mappings for low-numbered devices on bus 0, but in general this isn't 
very robust, and either way it's certainly not all that clear at first 
glance what assmuption is actually being made here. If it's significant 
whether a mapping actually exists or not for the given ID then you 
should really use the "target" argument of of_map_id() to determine that.

> +		if ((sid_i & IMX95_SID_MASK) != (sid_m & IMX95_SID_MASK)) {
> +			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");
> +			return -EINVAL;
> +		}
> +
> +	/* if iommu-map is not existed then use msi-map's stream id*/
> +	if (sid_i == rid)
> +		sid_i = sid_m;
> +
> +	sid_i &= IMX95_SID_MASK;

AFAICS this means that:
a) the check in imx_pcie_add_lut() is useless, since if a mapping had an 
output ID larger than 63, then we've now just silently truncated the LUT 
entry to not match what the SMMU/ITS will still expect.
b) if no mapping existed, then we're going to needlessly allocate a LUT 
entry anyway since the truncated RID now won't match the original.

> +
> +	if (sid_i != rid)
> +		return imx_pcie_add_lut(imx_pcie, rid, sid_i);
> +
> +	/* Use dwc built-in MSI controller */

This comment seems out of place - how does returning 0 from here vs. 
returning 0 from imx_pcie_add_lut() achieve that? I don't see any 
obvious way for the LUT programming to influence the IRQ subsystem here :/

Thanks,
Robin.

> +	return 0;
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
>   static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -941,6 +1064,11 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>   		}
>   	}
>   
> +	if (pp->bridge && imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT)) {
> +		pp->bridge->enable_device = imx_pcie_enable_device;
> +		pp->bridge->disable_device = imx_pcie_disable_device;
> +	}
> +
>   	imx_pcie_assert_core_reset(imx_pcie);
>   
>   	if (imx_pcie->drvdata->init_phy)
> @@ -1292,6 +1420,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
>   	imx_pcie->pci = pci;
>   	imx_pcie->drvdata = of_device_get_match_data(dev);
>   
> +	mutex_init(&imx_pcie->lock);
> +
>   	/* Find the PHY if one is defined, only imx7d uses it */
>   	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
>   	if (np) {
> @@ -1587,7 +1717,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>   	},
>   	[IMX95] = {
>   		.variant = IMX95,
> -		.flags = IMX_PCIE_FLAG_HAS_SERDES,
> +		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> +			 IMX_PCIE_FLAG_HAS_LUT,
>   		.clk_names = imx8mq_clks,
>   		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
>   		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
> 


