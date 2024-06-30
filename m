Return-Path: <bpf+bounces-33451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846191D29A
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 18:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AACE1F21C87
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F79154448;
	Sun, 30 Jun 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obVOonYY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A45D15350B
	for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719763837; cv=none; b=M0XIMiPp94TJcvZ47O1gPZa2fVoHtANgAllZSw9nHops8ZHJxIJvLDgb0Lx1V26Rf9FseG8OopmLQZDEDemg/T7cZ/YvpzF3++5O7c3WUMdMOuyAc7OdpAA1olAMP5HQ+0RClGWk/MO3aSGo0lceDAVyvoB87UHWBPQxbruZxrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719763837; c=relaxed/simple;
	bh=5LzWP3O/dnDF2PY01UY6rF4H2MAzHarDD9tAA3WeG8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBevvdjGV1of6sKTkg48GMD+05giWJjmba+yGoBiWC0n1RlNJLlVtdvYWsYC3hfUtTgju8AHS5EHBcl133dqg8jYpUTSx3javZ7YDFBJMQKSqzoDtowO0rd28LxaMuNqP4dsV8xtRIqlsQXuV326ZAvf5PV+Gclbjfi3YbkMIGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obVOonYY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70698bcd19eso1282872b3a.0
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719763835; x=1720368635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IszfV8T4b9z12YmSOdHo4qEq5YZATMox6eGaVhw+N9Y=;
        b=obVOonYY+vSJ0RIU1r24YSD/Cr2Q9L3eQdaLuCSAEgkmYrOe4gH1sZqpqa1bVfSQg1
         qqdpjiemcB+IdRLj8N4vcQXmitXTDLeLv1M9SgxWKYMmOC3p5mxL51EwKVqayv9Bwh3V
         ygm7Oh9wT9b7IFR7LfH74/ifKRoaKGXcB+Xd3xmyBJsUDgD28TG+UcuubuHaVtgyMV5d
         TviE7yKFs5Fuu3mF3hfQYy9smSdmZ5OFNKkQWalE6lXNsqeqvuk+RHMvPa3fsbgCio0r
         6EJ6I3KZY38OM4xboO3a6U4HJIQGqnzDQ70m10oL92nFwOZS1h+dhgjD2DeROCWN6WRg
         4B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719763835; x=1720368635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IszfV8T4b9z12YmSOdHo4qEq5YZATMox6eGaVhw+N9Y=;
        b=gFuY7Ux5Px4+tatl+XQaR85dllpDvPAKM00ruEXZgrO3JhiPmuBl/mO9kdVYIIDdXi
         IH/RcxYiqoLPJETztSAegbh2XBP1JKJlsq/GHd2jxtc7mxcUkibWtUKH/geyVQZJ4459
         jSqSM2L7BeXqzKmMnNLW/UCDQSc03rR4fCP9Ogjt5rNXfelLgNb4MWZ6Qz8eeg0mTR81
         WMcpSJs8ts9/t08225nDWH2mvlA4mpXZKULubuIIP9gCEO/b2lcdB5tZUd6a/ymuZMx4
         TdUj6VAPo5NobqP7DidiKoZaN7RGA0XjNdoG2kGaPbQhsjM7r9aRabHdH1qjIdPKIVof
         y4yg==
X-Forwarded-Encrypted: i=1; AJvYcCVZ95+v2/52s+NtMgwK7RPZ9sXiPjixzWY+J7NAJLsvIPtvGNDVfTyWjcuamfxsUvxd3utMrP8pj3l4y6BMSBh/kWQk
X-Gm-Message-State: AOJu0Yz5MBv9nLR/9U+Oy8S9THI+NzUurWwgGDCcF1gok5gtp1LKO4AI
	nq8RNS3jetnubh+qvKptFnCRL2AM445cCjwFEDd5hgK/gYLZQXOEGZrAfnrvyg==
X-Google-Smtp-Source: AGHT+IEOaTTCA8LuEGruX/jibPIx1BjotjXmxzwtWRUj2Jf71MrMEA1a/SOWBV+dVrHr2t3qRyLbaQ==
X-Received: by 2002:a05:6a00:2381:b0:707:ffb3:5933 with SMTP id d2e1a72fcca58-70aaad480f2mr2041308b3a.11.1719763834662;
        Sun, 30 Jun 2024 09:10:34 -0700 (PDT)
Received: from thinkpad ([220.158.156.215])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53f83sm4846872b3a.26.2024.06.30.09.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 09:10:34 -0700 (PDT)
Date: Sun, 30 Jun 2024 21:40:26 +0530
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
Subject: Re: [PATCH v6 05/10] PCI: imx6: Simplify switch-case logic by
 involve core_reset callback
Message-ID: <20240630161026.GB5264@thinkpad>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-5-e0821238f997@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-pci2_upstream-v6-5-e0821238f997@nxp.com>

On Mon, Jun 17, 2024 at 04:16:41PM -0400, Frank Li wrote:
> Instead of using the switch case statement to assert/dassert the core reset
> handled by this driver itself, let's introduce a new callback core_reset()
> and define it for platforms that require it. This simplifies the code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 134 ++++++++++++++++++----------------
>  1 file changed, 71 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index ff9d0098294fa..6f68bee111029 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -104,6 +104,7 @@ struct imx_pcie_drvdata {
>  	const struct pci_epc_features *epc_features;
>  	int (*init_phy)(struct imx_pcie *pcie);
>  	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
> +	int (*core_reset)(struct imx_pcie *pcie, bool assert);
>  };
>  
>  struct imx_pcie {
> @@ -672,35 +673,75 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
>  	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
>  }
>  
> +static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	if (assert)
> +		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> +				IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> +
> +	/* Force PCIe PHY reset */
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5, IMX6SX_GPR5_PCIE_BTNRST_RESET,
> +			   assert ? IMX6SX_GPR5_PCIE_BTNRST_RESET : 0);
> +	return 0;
> +}
> +
> +static int imx6qp_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_SW_RST,
> +			   assert ? IMX6Q_GPR1_PCIE_SW_RST : 0);
> +	if (!assert)
> +		usleep_range(200, 500);
> +
> +	return 0;
> +}
> +
> +static int imx6q_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	if (!assert)
> +		return 0;
> +
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD);
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +
> +	return 0;
> +}
> +
> +static int imx7d_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	struct dw_pcie *pci = imx_pcie->pci;
> +	struct device *dev = pci->dev;
> +
> +	if (assert)
> +		return 0;
> +
> +	/*
> +	 * Workaround for ERR010728, failure of PCI-e PLL VCO to
> +	 * oscillate, especially when cold. This turns off "Duty-cycle
> +	 * Corrector" and other mysterious undocumented things.
> +	 */
> +
> +	if (likely(imx_pcie->phy_base)) {
> +		/* De-assert DCC_FB_EN */
> +		writel(PCIE_PHY_CMN_REG4_DCC_FB_EN, imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
> +		/* Assert RX_EQS and RX_EQS_SEL */
> +		writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL | PCIE_PHY_CMN_REG24_RX_EQ,
> +		       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
> +		/* Assert ATT_MODE */
> +		writel(PCIE_PHY_CMN_REG26_ATT_MODE, imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
> +	} else {
> +		dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
> +	}
> +	imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
> +	return 0;
> +}
> +
>  static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  {
>  	reset_control_assert(imx_pcie->pciephy_reset);
>  	reset_control_assert(imx_pcie->apps_reset);
>  
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
> -		/* Force PCIe PHY reset */
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
> -				   IMX6SX_GPR5_PCIE_BTNRST_RESET,
> -				   IMX6SX_GPR5_PCIE_BTNRST_RESET);
> -		break;
> -	case IMX6QP:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_SW_RST,
> -				   IMX6Q_GPR1_PCIE_SW_RST);
> -		break;
> -	case IMX6Q:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_TEST_PD, 1 << 18);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
> -		break;
> -	default:
> -		break;
> -	}
> +	if (imx_pcie->drvdata->core_reset)
> +		imx_pcie->drvdata->core_reset(imx_pcie, true);
>  
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx_pcie->reset_gpio))
> @@ -710,47 +751,10 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
>  
>  static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
>  {
> -	struct dw_pcie *pci = imx_pcie->pci;
> -	struct device *dev = pci->dev;
> -
>  	reset_control_deassert(imx_pcie->pciephy_reset);
>  
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX7D:
> -		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
> -		 * oscillate, especially when cold.  This turns off "Duty-cycle
> -		 * Corrector" and other mysterious undocumented things.
> -		 */
> -		if (likely(imx_pcie->phy_base)) {
> -			/* De-assert DCC_FB_EN */
> -			writel(PCIE_PHY_CMN_REG4_DCC_FB_EN,
> -			       imx_pcie->phy_base + PCIE_PHY_CMN_REG4);
> -			/* Assert RX_EQS and RX_EQS_SEL */
> -			writel(PCIE_PHY_CMN_REG24_RX_EQ_SEL
> -				| PCIE_PHY_CMN_REG24_RX_EQ,
> -			       imx_pcie->phy_base + PCIE_PHY_CMN_REG24);
> -			/* Assert ATT_MODE */
> -			writel(PCIE_PHY_CMN_REG26_ATT_MODE,
> -			       imx_pcie->phy_base + PCIE_PHY_CMN_REG26);
> -		} else {
> -			dev_warn(dev, "Unable to apply ERR010728 workaround. DT missing fsl,imx7d-pcie-phy phandle ?\n");
> -		}
> -
> -		imx7d_pcie_wait_for_phy_pll_lock(imx_pcie);
> -		break;
> -	case IMX6SX:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR5,
> -				   IMX6SX_GPR5_PCIE_BTNRST_RESET, 0);
> -		break;
> -	case IMX6QP:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_SW_RST, 0);
> -
> -		usleep_range(200, 500);
> -		break;
> -	default:
> -		break;
> -	}
> +	if (imx_pcie->drvdata->core_reset)
> +		imx_pcie->drvdata->core_reset(imx_pcie, false);
>  
>  	/* Some boards don't have PCIe reset GPIO. */
>  	if (gpio_is_valid(imx_pcie->reset_gpio)) {
> @@ -1458,6 +1462,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx_pcie_init_phy,
>  		.set_ref_clk = imx6q_pcie_set_ref_clk,
> +		.core_reset = imx6q_pcie_core_reset,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1473,6 +1478,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx6sx_pcie_init_phy,
>  		.set_ref_clk = imx6sx_pcie_set_ref_clk,
> +		.core_reset = imx6sx_pcie_core_reset,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1489,6 +1495,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx_pcie_init_phy,
>  		.set_ref_clk = imx6q_pcie_set_ref_clk,
> +		.core_reset = imx6qp_pcie_core_reset,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> @@ -1502,6 +1509,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx7d_pcie_init_phy,
>  		.set_ref_clk = imx7d_pcie_set_ref_clk,
> +		.core_reset = imx7d_pcie_core_reset,
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

