Return-Path: <bpf+bounces-28022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2198B4582
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 12:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD47282806
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C025F481DF;
	Sat, 27 Apr 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bVobT105"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452047F7C
	for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714213206; cv=none; b=gOSSigMYO31J/FV8Xqm74IKvJh/AaUgZyaxrXhpYEI9FkkFqlt6HGKKjRFI6HYdC4AK7+bZv4HvZgtb8IjmbeeIm0JUKWEaFAwX9uTcxYWuY7iTZ6r6LbY61Qh4DhmsUHi0HhmYKYZFu1Mm6w1lCplD7u9eYH+du/WjcUlyKifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714213206; c=relaxed/simple;
	bh=JWA6+ZKwW4Es+WCjLsw/Bewv+NoSaEScYh68o7FE5Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXbqxmEFJVMLq7X7v3zqYLJ3XrKT2m1Z2RBQFtU8+D+fyYG1dPQsA66T5YHs4bu4dcuAumuPMdaMaPHXLKemW9Nvjw8wJY/pkF0durdNxc0BZE2AG0yPDXHn3s4MNHijdEjD+ixglokqLMfIKyDQvczDUigLegdUDaV/9VsQnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bVobT105; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a2da57ab3aso2582326a91.3
        for <bpf@vger.kernel.org>; Sat, 27 Apr 2024 03:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714213203; x=1714818003; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f7+iFYpps1zeYEBYcKhOBHRNG0fMT263PpJq0n4u0EE=;
        b=bVobT105MOR23WJztzNbcBOJDermDa88yZnDdtNPRDpG+U/1JMuCGw1MCA7AbW3EaH
         QfwqM/nnbZKfDajiMyEyapSr9t92gRXXVfdlxw+2sgJs5cAAixLXBX2o6ogiW5js0v1b
         BOjE4aytDnCXSddi2t8ySYbs1HOw9qJfEwzOqLadYhpT2KPZdyqiKb4bxpynVeDxK0xD
         smt+v2JQ+vtefSknFfK608FWXCPvKyO6quQ+uXmNHDnqevBxugvkdivFvwsMixC+Y/XA
         8fVSG0z9NhxejwFWzvQAL8hUiPNlbTJUBN1sG1zSyYw8yHQ/BAAWmbHkKL/kZkMmjjMi
         FS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714213203; x=1714818003;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f7+iFYpps1zeYEBYcKhOBHRNG0fMT263PpJq0n4u0EE=;
        b=o2Y7fkhUgbh9Q3Y7bu28JuRB5sExH633vmlS03M0oVAO610eNMDjsqCMZxlHncyJN2
         n6SFKL6sEtpD+gHleLoIYlms4RXa6xUxlLjqZeyEec7kGfTd50Jh9DnqWwZgchTjyqGT
         CE8P9RF0818cYQN/UJXj3eE0zbU3B0x7zcXR84LN3hmF6zoN41Nc3Yg/46j+NN5xb5iC
         qWpDFFQBqErPzvMwgsUr/AR08FH2epcFL7JpsNpzZ9DEQhb849N1RAAUWOdWUHSXBjyE
         E8RsE3KSaBaG6AiBW757nOq/mrXgmRloER8ivmzn3pWGHpvEbydf7TMCTD+q6YUInEyk
         8hqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv+4OHA1lJmxZ4D01qNoi64+0zW9snK5uKMBQs4rkML/WrmRdYUUTu9StstLRzBfHDJXZ+T6LF8+91I6zKhiLvjkox
X-Gm-Message-State: AOJu0Yw2bo14CP9TJW48PtZQPrwY0an/VEMQ9QTj+Fuetiysz7+iulyi
	4/9Lz0NROWp4RQAa2SldA9Ql7GAGcMn2hMK3M5FI656t8dx51ox0prUUT2tfvg==
X-Google-Smtp-Source: AGHT+IEYOZapJrU/m4SmvbbkI2Rqw/VHSc6hVCsBseOgu88lyFU9KKkSvde7eKI7fVNOcnbI0UpRCA==
X-Received: by 2002:a17:90b:1d89:b0:2af:53c6:5fb0 with SMTP id pf9-20020a17090b1d8900b002af53c65fb0mr4651141pjb.28.1714213202995;
        Sat, 27 Apr 2024 03:20:02 -0700 (PDT)
Received: from thinkpad ([117.213.97.210])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a7c4700b002ad6b1e5b6fsm11013594pjl.56.2024.04.27.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 03:20:02 -0700 (PDT)
Date: Sat, 27 Apr 2024 15:49:50 +0530
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
Subject: Re: [PATCH v3 07/11] PCI: imx: Simplify switch-case logic by involve
 core_reset callback
Message-ID: <20240427101950.GL1981@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-7-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-7-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:43AM -0400, Frank Li wrote:
> Instead of using the switch case statement to assert/dassert the core reset
> handled by this driver itself, let's introduce a new callback core_reset()
> and define it for platforms that require it. This simplifies the code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-imx.c | 131 ++++++++++++++++++----------------
>  1 file changed, 68 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
> index 77dae5c3f7057..af0f960f28757 100644
> --- a/drivers/pci/controller/dwc/pcie-imx.c
> +++ b/drivers/pci/controller/dwc/pcie-imx.c
> @@ -104,6 +104,7 @@ struct imx_pcie_drvdata {
>  	const struct pci_epc_features *epc_features;
>  	int (*init_phy)(struct imx_pcie *pcie);
>  	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
> +	int (*core_reset)(struct imx_pcie *pcie, bool assert);
>  };
>  
>  struct imx_pcie {
> @@ -671,35 +672,72 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
>  	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
>  }
>  
> +static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> +			   assert ? IMX6SX_GPR12_PCIE_TEST_POWERDOWN : 0);

Earlier, this register was not cleared during deassert. Is if fine?

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
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD,
> +			   assert ? IMX6Q_GPR1_PCIE_TEST_PD : 0);
> +
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_REF_CLK_EN,
> +			   assert ? 0 : IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +

Same comment as above.

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
> +	 * Workaround for ERR010728, failure of PCI-e PLL VCO to oscillate, especially when cold.

What does 'especially when cold' means? I know it is an old comment, but still
it is not very clear.

> +	 * This turns off "Duty-cycle Corrector" and other mysterious undocumented things.

Same comment as previous patch.

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

Why does this workaround a part of core_reset handling? This function doesn't
look like performing reset at all.

- Mani

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
> @@ -709,47 +747,10 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
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
> @@ -1447,6 +1448,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx_pcie_init_phy,
>  		.set_ref_clk = imx6q_pcie_set_ref_clk,
> +		.core_reset = imx6q_pcie_core_reset,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1462,6 +1464,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx6sx_pcie_init_phy,
>  		.set_ref_clk = imx6sx_pcie_set_ref_clk,
> +		.core_reset = imx6sx_pcie_core_reset,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1478,6 +1481,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx_pcie_init_phy,
>  		.set_ref_clk = imx6q_pcie_set_ref_clk,
> +		.core_reset = imx6qp_pcie_core_reset,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> @@ -1491,6 +1495,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
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

