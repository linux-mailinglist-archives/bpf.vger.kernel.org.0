Return-Path: <bpf+bounces-43811-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC449B9F89
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 12:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3F65B21311
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 11:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2C418870C;
	Sat,  2 Nov 2024 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6Dhm9zv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F6A16DED2
	for <bpf@vger.kernel.org>; Sat,  2 Nov 2024 11:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548187; cv=none; b=pHuiPdI1nWlN8h0urhQa2US6L0BaR1ns2IBhkh5+TUVsrS5qyvUIcN1VIr0zSAO4X/ppnFOu25H1PJw+piS3ZkYbifs5cOZkDEUrfdS8giFXOomSNLrkZnSRBpZGdtNZUUycMqOabow8Gor8W3/61faa5Y91FV+EEPQeS+sPVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548187; c=relaxed/simple;
	bh=OEFbD9NsXWHiRsEucmWd8xJpU5QSkti7zNWZQI/rsmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDJBA37gJJ2B1nx3IqCFG6n2PzPjIeZKaOSo2ODvSnYOtoEPemR+qQeKUuaGcOLt+qx9JRqrV7mZL0C9qerr0ctibEfZiX62z15ieLFIyUHWC7KKhty4plFkSG3p1XOOVPUK9sNx0KZkwr8eIWiu96G0lDkZen5oLeKvKwrfvLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s6Dhm9zv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e681bc315so1965937b3a.0
        for <bpf@vger.kernel.org>; Sat, 02 Nov 2024 04:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730548185; x=1731152985; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xoMIovZwANYIwsr+ozwQc2rn2svzEdghbHBSFmyjB5A=;
        b=s6Dhm9zvrO857WHxRIx3DkuLvVyiR9c/gkni+Gxt9OnZkmj4dYMFxQh+tDhJhJKxfX
         gp7UoYdNirtrFcvfLpP7ZNPoJ0sr/aw9pSooDGm+zRhmFFilNOZW2kq9Vgpz7ygIPEZR
         BuioPtygYpd54D13wmtXRoJiKK4jPoMLOcdjHKQIgQt1qjVfBXs3aWE4HHcq5jQd24oB
         /2ubAvTOOTqZN7xKU5ZVZ99I3NFunN6oBil9hz4XIbxdIYC41q62biAYtcfV2umv4lgX
         sUDgQlwUS3uIzfkw9kUHotMHKZ6IqQMrZrcgL4dFr0tzDjAMvWehHxyTGhcvvFVhle8n
         EIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548185; x=1731152985;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoMIovZwANYIwsr+ozwQc2rn2svzEdghbHBSFmyjB5A=;
        b=oz6EKl44ogbw/tcIXhfz6Jhpu6xj6YUtKggrvVJSg6dXRiqO3CJ9681L1UwfxzcYnT
         gISF85ideoJJwuDnN6QnSnsr8kz4ISS5/IpRtULWLEwOzdzeVY/dZupCszn8OkxyovR+
         aClw/VOVKZRmMt8dGnvc7s+kxD2aPLBN1zB18XMA63IOYkNKua3sYoner1OHQhjDFhkp
         xkKIacnQ3zpJmCyGPUMf1ZpQEp/9H3IRTspWRwINYcWbWKfXyXGiyFY63je9PMqfzQAi
         cPqwOsu8JDeaUbTQoHuIPEV8tRX4xAxm/D1MNxSZ8poEr1UoArUuQQ+6qJ1kJeu2kTSe
         i8Zg==
X-Forwarded-Encrypted: i=1; AJvYcCW+jSQ42T+fRGaCAcy0gkPiedImdvZRy3XiFJiarHeoBr1VZAYymZf1+TUx5iqk35Llnmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMF7qpn26WFim7/QE+ydQ8eVkBN4oBwHU0GJ4Dv0Iqi4gssoa
	AfIjoXMIVl7R8gxDaexLQNutDVu0LUQRoUIKjdrSKXdNvRPHPJ9ePWROEiXSrQ==
X-Google-Smtp-Source: AGHT+IFAZvvqPqfrR6KD3ufdIPcBIQIJ02cjOEk09Qxuto0fFw11UoKyY+vKorg9VaD5CI4LhSN2NA==
X-Received: by 2002:a05:6a00:2383:b0:71e:735f:692a with SMTP id d2e1a72fcca58-720bd1a046amr13892444b3a.14.1730548185366;
        Sat, 02 Nov 2024 04:49:45 -0700 (PDT)
Received: from thinkpad ([220.158.156.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1e5839sm4022440b3a.68.2024.11.02.04.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:49:44 -0700 (PDT)
Date: Sat, 2 Nov 2024 17:19:37 +0530
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
Subject: Re: [PATCH v3 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <20241102114937.w7jt7n7zr3ext5jo@thinkpad>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
 <20241024-imx95_lut-v3-2-7509c9bbab86@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241024-imx95_lut-v3-2-7509c9bbab86@nxp.com>

On Thu, Oct 24, 2024 at 06:34:45PM -0400, Frank Li wrote:
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

Callbacks are not *addition*, but it is how you are implementing the LUT
configuration. Please reword it so.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v2 to v3
> - Use the "target" argument of of_map_id()
> - Check if rid already in lut table when enable device
> 
> change from v1 to v2
> - set callback to pci_host_bridge instead pci->ops.
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 159 +++++++++++++++++++++++++++++++++-
>  1 file changed, 158 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 94f3411352bf0..95f06bfb9fc5e 100644
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
> @@ -134,6 +151,7 @@ struct imx_pcie {
>  	struct device		*pd_pcie_phy;
>  	struct phy		*phy;
>  	const struct imx_pcie_drvdata *drvdata;
> +	struct mutex		lock;

Please add a comment on what the lock is guarding. 

>  };
>  
>  /* Parameters for the waiting for PCIe PHY PLL to lock on i.MX7 */
> @@ -925,6 +943,137 @@ static void imx_pcie_stop_link(struct dw_pcie *pci)
>  	imx_pcie_ltssm_disable(dev);
>  }
>  
> +static int imx_pcie_add_lut(struct imx_pcie *imx_pcie, u16 reqid, u8 sid)

s/reqid/rid

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
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
> +
> +		if (!(data1 & IMX95_PE0_LUT_VLD))
> +			continue;
> +
> +		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
> +
> +		/* Needn't add duplicated Request ID */
> +		if (reqid == FIELD_GET(IMX95_PE0_LUT_REQID, data2))

So this means LUT entry is already present for the given RID (a buggy DT maybe).
Don't you need to emit a warning here?

> +			return 0;
> +	}
> +

You need to bail out here if no free LUT entry is available. But I'd recommend
to combine two loops to avoid having duplicated IMX95_PE0_LUT_VLD checks and
program LUT only if there is any free entry available.

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

data2 = IMX95_PE0_LUT_MASK;

Also add a comment on why the mask is added along with the RID.

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

"LUT entry is not available"

> +	return -EINVAL;
> +}
> +
> +static void imx_pcie_remove_lut(struct imx_pcie *imx_pcie, u16 reqid)

s/reqid/rid

> +{
> +	u32 data2 = 0;

No need to initialize.

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
> +
> +			break;
> +		}
> +	}
> +}
> +
> +static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> +{
> +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
> +	struct device_node *target;
> +	struct imx_pcie *imx_pcie;
> +	struct device *dev;
> +	int err_i, err_m;
> +
> +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> +	dev = imx_pcie->pci->dev;

You can assign these at initialization time.

> +
> +	target = NULL;
> +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);
> +	target = NULL;

What is the point in passing 'target' here?

> +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);
> +
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
> +			dev_err(dev, "its and iommu stream id miss match, please check dts file\n");

"iommu-map and msi-map entries mismatch!"

- Mani

-- 
மணிவண்ணன் சதாசிவம்

