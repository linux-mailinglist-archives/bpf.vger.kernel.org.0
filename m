Return-Path: <bpf+bounces-44788-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B69C7A3F
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 18:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA3C284055
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916E5202F8B;
	Wed, 13 Nov 2024 17:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jr+Vm1qq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C32022E1
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520135; cv=none; b=Bn9bOTbOv0qldG79o0tljRUiOLcZjH5gax2C6P2CNEjShU+9cniGA1ugmIxuL+qKwN0zwfy2zPWLiM5qnvcrSb0nxYV4/4vSaGFsdcrJsBDGbR2Exjx9lPXwQPt6HIIlzSxsQPLopoiMCyWQYemJTjPgea1ZAQvYYQenlQ75uRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520135; c=relaxed/simple;
	bh=9qu0frD8NGZvMd+t0ojWG9jdk3Z4iUPQQmG4GYjaUSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dp1T0y47SiRYLJTTlZ8Qfmw4XTmyWXTT8+iqflA+8CKd75AssGLTK3ft8TTAleNbRKxSpDeCOwWGGrFVt5EZRvH57tW8E1UdH4jETBKlhgNIy3X5JCRTFznKTIoS+LX52OrcLdsJUV8rD0Dsq9rwfmJD7MqR5oIdk6MSlNGKffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Jr+Vm1qq; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cf6eea3c0so69473735ad.0
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 09:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731520132; x=1732124932; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y9rKfjR1HZdkhSoVFUPTH5q4XPsaUToI4Fa76nl271U=;
        b=Jr+Vm1qqwXnYfZ1d/z3vZc4WujrYZyjxDs+G0OkcsjA9WWg46Hr7e4B0RwfrbvHWKe
         5oLDIETHz9l8gqHHzhceUF7yW/rNeUKPraaKKacCREevYCt1Ccj3wp76LRm0ufNFI7F+
         AmmFWgW7WnYYKhM4v20FpypvX3Qg/Ta3yGg7qPvKWpfFGeA1pFV9k37RyEX0h6rQ+19S
         9JlAhx2on5RwZuUb/NV4rn5OAr3kSTYh1gS4+zBq05PsFV94cRU3/46cQry7Pr7sBqO5
         Mh9dnlm8eVttooLzRHz05BgzOfTSKuvtN9vRfCLh86J6dY5d6mphIxSCELu0HzBQgAbp
         4c1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731520132; x=1732124932;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9rKfjR1HZdkhSoVFUPTH5q4XPsaUToI4Fa76nl271U=;
        b=hwkWWHBv+gIYWt7h/PJlLW9GJjmF/XE3BQ9L7RviFuoHdkqWI9crPPlEFq/FAHJXj5
         1WQG86l7WRFIimDtOx5xZyp0vBTkw1hEH0KTq9brFjbFcAswVgAAnQiSlfUc6MaOglAh
         /kotIT8eNOMcWlFsa/wPYQ2/UAZMStt1Zdex3N1G1LBivcfn3D3HkMbKpanp6mKDPjNz
         8d8jGiacvp3uBaIlzyzNTdMYu3G+KzsAwCXylR0La1qNUsxGBTvKpIUv2R9bt0F3dUtK
         QvZCJ47kfhe/xTb/Q2vCYPnVQG71HP3g86TwMevse5LrmjVCHUWHtPyJVbGVAizXqwvn
         8+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXebdQ3da0+eCJwyM7p9rsUzAKlMlXtxdwSVTf7ktpRGGLNt0YCWMIEGWzqSf25JOsF88k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb86olkzRO5bFMGnvZUunE+9hcvfTABaLv5tVlGq3bzvWZ6sNU
	OiSCEMnxzARMy5IovRQ248WEa8jn8KGKdrgqdoTbKad4fp7o4VpNBKjVJBgvIA==
X-Google-Smtp-Source: AGHT+IGUx5vMux/zJWfHt+c3yDFnfCUQDJa3eB9NypPr2jzRRcay61/UDEWpDrYoWje8hXMYDmT3ow==
X-Received: by 2002:a17:903:230b:b0:20b:9062:7b16 with SMTP id d9443c01a7336-211834e6c2amr288743745ad.9.1731520132170;
        Wed, 13 Nov 2024 09:48:52 -0800 (PST)
Received: from thinkpad ([117.213.102.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e8752asm110135085ad.282.2024.11.13.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:48:51 -0800 (PST)
Date: Wed, 13 Nov 2024 23:18:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v5 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <20241113174841.olnyu5l6rbmr3tqh@thinkpad>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
 <20241104-imx95_lut-v5-2-feb972f3f13b@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104-imx95_lut-v5-2-feb972f3f13b@nxp.com>

On Mon, Nov 04, 2024 at 02:23:00PM -0500, Frank Li wrote:
> For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> This involves examining the msi-map and smmu-map to ensure consistent
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

Some minor comments below. It'd be good to get Robin's Ack for this patch.

> ---
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
>  drivers/pci/controller/dwc/pci-imx6.c | 176 +++++++++++++++++++++++++++++++++-
>  1 file changed, 175 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 94f3411352bf0..e75dc361e284e 100644
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
> @@ -82,6 +98,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> +#define IMX_PCIE_FLAG_HAS_LUT			BIT(8)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -134,6 +151,9 @@ struct imx_pcie {
>  	struct device		*pd_pcie_phy;
>  	struct phy		*phy;
>  	const struct imx_pcie_drvdata *drvdata;
> +
> +	/* Ensure that only one device's LUT is configured at any given time */
> +	struct mutex		lock;
>  };
>  
>  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> @@ -925,6 +945,152 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
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
> +	for (i = 0; i < IMX95_MAX_LUT; i++) {
> +		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, IMX95_PEO_LUT_RWA | i);
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> +
> +		if (!(data1 & IMX95_PE0_LUT_VLD)) {
> +			if (free < 0)
> +				free = i;

So you don't increment 'free' once it becomes >=0? Why can't you use the loop
iterator 'i' itself instead of 'free'?

> +			continue;
> +		}
> +
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> +
> +		/* Needn't add duplicated Request ID */

"Do not add duplicate RID"

> +		if (rid == FIELD_GET(IMX95_PE0_LUT_REQID, data2)) {
> +			dev_warn(dev, "Try to enable rid(%d) twice without disable it\n", rid);

"Existing LUT entry available for RID (%d)\n"

> +			return 0;
> +		}
> +	}
> +
> +	if (free < 0) {
> +		dev_err(dev, "LUT entry is not available\n");
> +		return -EINVAL;

ENOSPC?

> +	}
> +
> +	data1 = FIELD_PREP(IMX95_PE0_LUT_DAC_ID, 0);
> +	data1 |= FIELD_PREP(IMX95_PE0_LUT_STREAM_ID, sid);
> +	data1 |= IMX95_PE0_LUT_VLD;
> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, data1);
> +
> +	data2 = IMX95_PE0_LUT_MASK; /* Match all bits of rid */

Please use 'RID' in comments everywhere.

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
> +

Remove newline.

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
> +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);

No need to initialize sid_{i/m}.

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
> +
> +	target = NULL;
> +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> +
> +	/*
> +	 * Return failure if msi-map exist and no entry for rid because dwc common
> +	 * driver will skip setting up built-in MSI controller if msi-map existed.
> +	 *
> +	 *   err_m      target
> +	 *	0	NULL		Return failure, function not work.
> +	 *      !0      NULL		msi-map not exist, use built-in MSI.
> +	 *	0	!NULL		Find one entry.
> +	 *	!0	!NULL		Invalidate case.
> +	 */
> +	if (!err_m && !target)
> +		return -EINVAL;
> +	else if (target)
> +		of_node_put(target); /* Find entry for rid in msi-map */
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
> +	else if (!err_m)
> +		/* Hardware auto add 2 bit controller id ahead of stream ID */

What is this comment for? I don't find it relevant here.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

