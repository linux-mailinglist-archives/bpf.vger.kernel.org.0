Return-Path: <bpf+bounces-32800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8F09131E5
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 06:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4013E1C20F0E
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2024 04:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7CCBE7F;
	Sat, 22 Jun 2024 04:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwfNf3NA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896478F66
	for <bpf@vger.kernel.org>; Sat, 22 Jun 2024 04:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719029492; cv=none; b=gT1OQUzlmjyXfdJSKVoxqhnj+TSCHVkhBWEQcmW63JbRdFgygjJdq5V9CzCeQtqaxyVPiUbqHAPKGNHt3HOB6gUsgsodf+sdeqEhXz4wzblJGb78uNyz566bIEwqh0JPzCQy/fn3a3dZmOdyuzrW+MpS3+UK8wjFrNMjeHijwTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719029492; c=relaxed/simple;
	bh=BycR4VjN1P2/crFqGM7x9mmrtddl8EKh2KJCyfpv2P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHXCrhvnHm6hQH5JFmXjfJBbKL31L1W62+RArzdRXEDrgqqNdu+cVXWdJvfbdqS3z+qw9mUmOv15yFzoWn/wXB+F55hOnI0LfmnNARLuYzePQhL7EhZbHAVF7Atkuf5U6+6OoSbYSWFkvN1QGsl0PIqbWh3uYhhvpjX+iopBuHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VwfNf3NA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7023b6d810bso2029151b3a.3
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2024 21:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719029489; x=1719634289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TfjJ/7PxukviDUtbYW71wrZoAgJ4L/WBbr7ZDew9h2I=;
        b=VwfNf3NAXjCBt9CA9bWJToo7wOBaNTlz/Nj4Z8NVLV3YB5wGL9U1jamnDIIwFiVJoU
         XYCegsJw7oxPfaXWeS5EStppr9H+4awx71MXEHencEuGbiJS95OaVDUrQ5qWzx7mw3Pu
         kWXnd/ruPjfrQ0uTy6+hocrGLpkz8jrFk45J+Z19y/1qxbKvNNyVv1+tl3ZBcoJ0ME+B
         XsOXax+SHM5FSJ5hn4SsY7IHTo5GG3kGLGn7V98+lHVWelqXGQ5YR7xT3Z95SfaB4CBW
         V+o8DY2cVny9ae/pnvaUHO/9uHxzjPYuyy3/iDx1hCeM70IuPppGUMqGsFWak0KzwtKY
         e6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719029489; x=1719634289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfjJ/7PxukviDUtbYW71wrZoAgJ4L/WBbr7ZDew9h2I=;
        b=B13c4DgckbajR3FSPlsg+rEd5O0EvS0LqnBlwWqVY+tYXT/jpml5J1CVmIaXDgT8hc
         d2PrK1VLHlZYMN71lJhKX7n5CpVH78eE9fWnVyXbjTyl56Gq5kAzutAK2s8OBUjeh1bS
         shnjH9M3zSjWpLjh03+WDlNBe1kAFCf2YiPIvm3pL5L5zcpORwaG39l3HZG4mOjSQKqa
         7OVlAMSOsuWHnTHHteCvDFOGhb2GWlLVvTXHCK9/9Fi0fp8KrBlgUFyQc9Dsb4aHe1hZ
         cvJwS/1ez0+nGNJjNlQNdmIRRYQRF71EN+YSwPUI2qb0WALOz+SrwDvYtyGFAXMU0bTe
         E42w==
X-Forwarded-Encrypted: i=1; AJvYcCVyk5vLrYRK4apFlIkhsWAeX+OJgZYmFr/VU6PJIQedGivzOhkAtLgsnHhHenDYATt82/s/fFK9LShHxmKlmX6pnDRp
X-Gm-Message-State: AOJu0YzHpnXg2r+cLdB+dRSuzNeDOplhsTiBIr2TCAY5fesuodKaalLg
	T+Gtc2o2Ts7aWEAYy7XrAbtexqX9nqHJpRJDmREQs7ONqm81HOji6oEphLSVzA==
X-Google-Smtp-Source: AGHT+IH+yBsETEqfxy9vYW6jfMV4VUEuUCczzbiF/DAMNYGj7eoKv9nvHXCHsH1eneeaZG8RXNzxKQ==
X-Received: by 2002:a05:6a00:1d0d:b0:704:3a0f:1d88 with SMTP id d2e1a72fcca58-70629ccff3bmr11045925b3a.21.1719029488608;
        Fri, 21 Jun 2024 21:11:28 -0700 (PDT)
Received: from thinkpad ([120.60.57.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716b4a74010sm1558983a12.49.2024.06.21.21.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 21:11:28 -0700 (PDT)
Date: Sat, 22 Jun 2024 09:41:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
Message-ID: <20240622041115.GB2922@thinkpad>
References: <20240528-pci2_upstream-v5-0-750aa7edb8e2@nxp.com>
 <20240528-pci2_upstream-v5-8-750aa7edb8e2@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240528-pci2_upstream-v5-8-750aa7edb8e2@nxp.com>

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
> 

Sorry for jumping the ship very late... But why can't you configure the LUT
during probe() itself? Anyway, you are going to use the 'iommu-map' and
'msi-map' which are static info provided in DT. I don't see a necessity to do it
during device addition time.

Qcom RC driver also uses a similar configuration in
qcom_pcie_config_sid_1_9_0().

- Mani

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
> +
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
>  
>  	return platform_driver_register(&imx_pcie_driver);
>  }
> +
> +static void __exit imx_pcie_exit(void)
> +{
> +	bus_unregister_notifier(&pci_bus_type, &imx_pcie_nb);
> +}
> +
>  device_initcall(imx_pcie_init);
> +__exitcall(imx_pcie_exit);
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

