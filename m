Return-Path: <bpf+bounces-36535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33783949DD0
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 04:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5644A1C22135
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 02:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD53018FDDC;
	Wed,  7 Aug 2024 02:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lkiLuaSH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5F415B113
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722998224; cv=none; b=Q9RDQ24S+VBw9WidICGshwD9iBsmotg6AhU5UWDxYwCuRi2GvvB56lKTjbrEilQir1fj5ZlvyJc0hGqpv3A8vlPv/Mo9Tikx+QjgNN+OQnpag8XTiBmyXzyPGXGE96NUUFQGKW4VJbIqS3Q21mPpWjExSEZvekAjiV6P20z8Nes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722998224; c=relaxed/simple;
	bh=uuDYVrBcHuJYm5yNU4n2eqe4vt3oerM46cQj8ax/3oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmT1t+wLBYPIrTKNUAD0slEG+vedTQP7hyYHWW1yytMsVZx7RbdwOyPge5spAYddBsABhUhKnpN8+lwcx1Z7kzToERH7aUIvL1VUX6Jyqb8MG6dHw9vUnIyqKo+Hfm5MM9LQDO/zvKZJ++mttOBHh0CRJGbFOEuw1nacPRyNFg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lkiLuaSH; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3db1956643bso842301b6e.3
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 19:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722998221; x=1723603021; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZvmmLFhC09oq0o2xBVohmEoFMpltsYFPcH3KrPOyLgA=;
        b=lkiLuaSH9V58d6p5pYi/zCaWGz2HQIWBjqTnUolY0N86uLfF3InOV4JvRvE/jr5313
         BnjQS7XULlrHqtUGL9J5cAdvso6EM5nN0ppv89VWUmYr1LEDTSOyg+2j9i0nuzFTbI0c
         ZpUI+u1mje89UW4KNhqMUKF4mgziYdLbdjA2bLJDesjMxlydq53BnfZmxkhkB5rbz51x
         mk/UzcunEUafOl8Xq3I7WD7xUwlJxz6fILu0SETtpT6HQz5tmnw/AlXsQMyi7Wr5Pcfn
         rZhgtD+gr9kJg58nfcqf3ZkkovX9vkjy2VlmQ2b4lAyWZNoiMl6atWNX0ox+sh3CJf13
         rRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722998221; x=1723603021;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvmmLFhC09oq0o2xBVohmEoFMpltsYFPcH3KrPOyLgA=;
        b=PDDttTBnotmeCzKcUYvsHiKtn5at1ixY77y2lKzGYv2bkbSAI5suD/l1H0i0dRWcLt
         4256HGtb2Pa9T3Fmjxbt7hrc8jL1bs2vFCXk6LOMqY7wzfPlpmHLi7OvYbPnkf5n+bYx
         zhC3ALjAGKDUiy0Q+/+xS79io3smgL83dVjHHpOHuDxBrCrVPfjeUNtPyar0KtW5ixOm
         DobpCM3o0nZJ5cQ6UfwToBUWyvm/tQxxviM+IOccxcLobEM/b4WwhulTLIkSH/G2dEL5
         SDdBoXIL7nyDtq6vk1e7XZ7JW176EAHonec+Y8yyvOQlbrGO3dfwHFWjwrcs3dlxdn82
         vXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0YUVrA9mkh6Gzgh30+/EuxsFH7MkEWkJqohwLlH9wDM4c9FUag9SNHap38F2PYR1WOybx1k/yjON1rANdrOktNgZz
X-Gm-Message-State: AOJu0Yw0tPZDqEIZwnXrbLfEsZw4xE+M5eZlo7RKThrYCrMnjzRd7zi2
	t81oi3lNnAwS33aw94FEGc9TKPYPfzD//c1qPvFpY8+zQLOsOl70klGxFoEuCA==
X-Google-Smtp-Source: AGHT+IF5ERNcpKWlnzVJ2lsDzG0HuLkv3XdnM0McCYVBapTBM+caDvyJHzS1b1ifM5q1m5rGdoV1LA==
X-Received: by 2002:a05:6870:d109:b0:261:1deb:f0ee with SMTP id 586e51a60fabf-26891b0ef9amr22023790fac.13.1722998221595;
        Tue, 06 Aug 2024 19:37:01 -0700 (PDT)
Received: from thinkpad ([120.60.72.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfc335sm7536474b3a.152.2024.08.06.19.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 19:37:01 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:06:42 +0530
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
Subject: Re: [PATCH v8 05/11] PCI: imx6: Introduce SoC specific callbacks for
 controlling REFCLK
Message-ID: <20240807023642.GC3412@thinkpad>
References: <20240729-pci2_upstream-v8-0-b68ee5ef2b4d@nxp.com>
 <20240729-pci2_upstream-v8-5-b68ee5ef2b4d@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240729-pci2_upstream-v8-5-b68ee5ef2b4d@nxp.com>

On Mon, Jul 29, 2024 at 04:18:12PM -0400, Frank Li wrote:
> Instead of using the switch case statement to enable/disable the reference
> clock handled by this driver itself, let's introduce a new callback
> enable_ref_clk() and define it for platforms that require it. This
> simplifies the code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 111 ++++++++++++++++------------------
>  1 file changed, 51 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 443c7c75f2842..b68a817ccc86b 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -102,6 +102,7 @@ struct imx_pcie_drvdata {
>  	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
>  	const struct pci_epc_features *epc_features;
>  	int (*init_phy)(struct imx_pcie *pcie);
> +	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  };
>  
>  struct imx_pcie {
> @@ -583,21 +584,20 @@ static int imx_pcie_attach_pd(struct device *dev)
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
> @@ -605,55 +605,33 @@ static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
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
> @@ -666,10 +644,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
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
> @@ -684,7 +664,8 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
>  
>  static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
>  {
> -	imx_pcie_disable_ref_clk(imx_pcie);
> +	if (imx_pcie->drvdata->enable_ref_clk)
> +		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
>  	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
>  }
>  
> @@ -1460,6 +1441,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx_pcie_init_phy,
> +		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
>  	},
>  	[IMX6SX] = {
>  		.variant = IMX6SX,
> @@ -1474,6 +1456,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx6sx_pcie_init_phy,
> +		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
>  	},
>  	[IMX6QP] = {
>  		.variant = IMX6QP,
> @@ -1489,6 +1472,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx_pcie_init_phy,
> +		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
>  	},
>  	[IMX7D] = {
>  		.variant = IMX7D,
> @@ -1501,6 +1485,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.init_phy = imx7d_pcie_init_phy,
> +		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
>  	},
>  	[IMX8MQ] = {
>  		.variant = IMX8MQ,
> @@ -1514,6 +1499,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[1] = IOMUXC_GPR12,
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.init_phy = imx8mq_pcie_init_phy,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX8MM] = {
>  		.variant = IMX8MM,
> @@ -1525,6 +1511,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX8MP] = {
>  		.variant = IMX8MP,
> @@ -1536,6 +1523,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX95] = {
>  		.variant = IMX95,
> @@ -1562,6 +1550,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
>  		.epc_features = &imx8m_pcie_epc_features,
>  		.init_phy = imx8mq_pcie_init_phy,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> @@ -1574,6 +1563,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_off[0] = IOMUXC_GPR12,
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.epc_features = &imx8m_pcie_epc_features,
> +		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> @@ -1586,6 +1576,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
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

