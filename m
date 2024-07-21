Return-Path: <bpf+bounces-35184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9819383DB
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 09:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A6C1C20A36
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 07:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D818C13;
	Sun, 21 Jul 2024 07:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbPKmEWQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C988F40
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 07:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721548605; cv=none; b=sxAblyxPKlOv9VvF2AcmXjj0tECqm9Us96CKkhQRCdlQrHXL7G1f21ZcO4QbY2Ci3OMnLabcoDOUtcjHwX1uBul6GMbg+8ShCB7G5mEyM1lMDwykQRpZKcjgABd/hM+9C4+WIdhebYSRscKKS3QAPvCcj5Up/X3NCbh1XhX/F+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721548605; c=relaxed/simple;
	bh=XO5md9ConEoIIW06jXtI+hVZbOSSpaCoASh7waxuqWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8TQMXjURkHjOBKdPbNpECe1z4lwyZPS8vpjpNKr81Wrr6Oi3TrI4OEJwuCHeyIDQFsAZuHqaLHQbGrlBRMr0lYJWrw+AcLqaL/GIVjj3jl9X3U1R5UfUKf7mEpWE1+yS+xHUn8ycZDwSzkpX3TDUDXQZ265nvisc9WPC4KiPmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RbPKmEWQ; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7f97e794f34so137646539f.3
        for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 00:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721548602; x=1722153402; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=k6gGU+fz2lIRBCY4VE5FcZg84uYYhlbx5aEGBL3Pm8E=;
        b=RbPKmEWQjrpj5Wd1+vhgCGCMAk2MQiUKHCCOr1vrw/Ji5yVI3RIw5aVqu188VivO+T
         t/WpHFrJE0GGDfP0DZcCjUX6zlaIx23XyDdQCdAzejOuZ3lwk4tsIXWGHcK7BMcxuvqK
         y1FnU/lLfZajsDGC2QLKBJ432X49u47R/HBLMPn3Kr1AoceRe4mNNFin00Gfa6vuyEvb
         fUrMRs7MFEESRnNsG10eOezgVkGgdpj0qNucwweZ6JismZY1JZqU8uqmaivE2Mx7MuI0
         ADHTv1zgtgwfPEJlSnEStHhjLzr+iGqeykSOoF9rOluYwK22WLqm/nXuKw+aDrL5QCfD
         J+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721548602; x=1722153402;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k6gGU+fz2lIRBCY4VE5FcZg84uYYhlbx5aEGBL3Pm8E=;
        b=qBVVYdKA6Pz/aOGcwG9mQppoSyy20S/eybdoRZ6/Ao0lkSWxR5BxIW9knaIHCHDnea
         xpruvN0+hKdd1RX9OW428FrNrf7WTrP9GTHw/PzDcN/24m9fuZn6zRetDVKl6tL3lVlr
         1ku9lRg9esvkeRdH058zNhV0FTorzi4yCXTaaVCPO7UHe/1CQj50sddiBoqOo31MMzz2
         czqN9bcutZB7a3AMsCgl6OkfrQaeX+0ivGLTa5Tzmx6/LYOgT5JC8KYL/YUFk8MZ1CCP
         Sl+CuS47kxOABsyiSb5hDXsNvWWOIWjJk8TVaQiktncdgkbsHF7zGxeoVORX/ctadiTH
         0UWg==
X-Forwarded-Encrypted: i=1; AJvYcCVmMTvRDFwOEf6fACGGgK2arhv1UsfXKps3qDB5/0ww7xx0YiNCaK3Lio1F118VjGt2xi2MADoAbhl1PLFdDxJaa0ON
X-Gm-Message-State: AOJu0Yz7jtOY1k/ak+D8KICaOpCceplZXLcye6GnSnwku94kayZevfBS
	ejloN0Vt9BZRmNxZjmFSC2oghWcVpgIGKGqFlOMDv1BOs6y6TgE0yzQBE3bekw==
X-Google-Smtp-Source: AGHT+IF1uwclQelxCTCZt/SjCt51SdmajX/rFjbGweVu8AjNgTxJ4Qes8huNEaPThMJJ+JpjrtTQjw==
X-Received: by 2002:a05:6602:1503:b0:7eb:4b89:b706 with SMTP id ca18e2360f4ac-81b341c7843mr467636839f.8.1721548602387;
        Sun, 21 Jul 2024 00:56:42 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f25a841sm32550265ad.32.2024.07.21.00.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 00:56:41 -0700 (PDT)
Date: Sun, 21 Jul 2024 13:26:34 +0530
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
Subject: Re: [PATCH v7 04/10] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Message-ID: <20240721075634.GC1908@thinkpad>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
 <20240708-pci2_upstream-v7-4-ac00b8174f89@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-pci2_upstream-v7-4-ac00b8174f89@nxp.com>

On Mon, Jul 08, 2024 at 01:08:08PM -0400, Frank Li wrote:
> Instead of using the switch case statement to enable/disable the reference
> clock handled by this driver itself, let's introduce a new callback
> enable_ref_clk() and define it for platforms that require it. This
> simplifies the code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 111 ++++++++++++++++------------------
>  1 file changed, 51 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 47134e2dfecf2..dbcb70186036e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
>  	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
>  	const struct pci_epc_features *epc_features;
>  	int (*init_phy)(struct imx_pcie *pcie);
> +	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  };
>  
>  struct imx_pcie {
> @@ -585,21 +586,20 @@ static int imx_pcie_attach_pd(struct device *dev)
>  	return 0;
>  }
>  
> -static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
> +static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	unsigned int offset;
> -	int ret = 0;
> +	if (enable)
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);

Since all SoCs except IMX6Q/6QP doesn't have both enable/disable controls (which
is very weird btw), you can have separate enable/disable callbacks and just
populate the ones that require.

This way it becomes clear which SoC is supporting what. If you have a common
helper and just toggle based on a bool, then it becomes hard to follow.

- Mani

>  
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> -		break;
> -	case IMX6QP:
> -	case IMX6Q:
> +	return 0;
> +}
> +
> +static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	if (enable) {
>  		/* power up core phy and enable ref clock */
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
>  		/*
>  		 * the async reset input need ref clock to sync internally,
>  		 * when the ref clock comes after reset, internal synced
> @@ -607,55 +607,33 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
>  		 * add one ~10us delay here.
>  		 */
>  		usleep_range(10, 100);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> -		break;
> -	case IMX7D:
> -	case IMX95:
> -	case IMX95_EP:
> -		break;
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		offset = imx_pcie_grp_offset(imx_pcie);
> -		/*
> -		 * Set the over ride low and enabled
> -		 * make sure that REF_CLK is turned on.
> -		 */
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> -				   0);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> -		break;
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	} else {
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
> -static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
> +static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX6QP:
> -	case IMX6Q:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_TEST_PD,
> -				IMX6Q_GPR1_PCIE_TEST_PD);
> -		break;
> -	case IMX7D:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> -		break;
> -	default:
> -		break;
> +	int offset = imx_pcie_grp_offset(imx_pcie);
> +
> +	if (enable) {
> +		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
>  	}
> +
> +	return 0;
> +}
> +
> +static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	if (!enable)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +	return 0;
>  }
>  
>  static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
> @@ -668,10 +646,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
>  	if (ret)
>  		return ret;
>  
> -	ret = imx_pcie_enable_ref_clk(imx_pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie ref clock\n");
> -		goto err_ref_clk;
> +	if (imx_pcie->drvdata->enable_ref_clk) {
> +		ret = imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable PCIe REFCLK\n");
> +			goto err_ref_clk;
> +		}
>  	}
>  
>  	/* allow the clocks to stabilize */
> @@ -686,7 +666,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
>  
>  static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
>  {
> -	imx_pcie_disable_ref_clk(imx_pcie);
> +	if (imx_pcie->drvdata->enable_ref_clk)
> +		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
>  	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
>  }
>  
> @@ -1475,6 +1456,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx_pcie_init_phy,
> +		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1489,6 +1471,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx6sx_pcie_init_phy,
> +		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1504,6 +1487,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx_pcie_init_phy,
> +		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> @@ -1516,6 +1500,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx7d_pcie_init_phy,
> +		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> @@ -1529,6 +1514,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[1] = IOMUXC_GPR12,
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.init_phy = imx8mq_pcie_init_phy,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> @@ -1540,6 +1526,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> @@ -1551,6 +1538,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX95] = {
>  		.variant = IMX95,
> @@ -1577,6 +1565,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.epc_features = &imx8m_pcie_epc_features,
>  		.init_phy = imx8mq_pcie_init_phy,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> @@ -1589,6 +1578,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.epc_features = &imx8m_pcie_epc_features,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> @@ -1601,6 +1591,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.epc_features = &imx8m_pcie_epc_features,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX95_EP] = {
>  		.variant = IMX95_EP,
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

