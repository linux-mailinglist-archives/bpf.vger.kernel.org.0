Return-Path: <bpf+bounces-35187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 360039383E8
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 10:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 983B7B20B32
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36B9479;
	Sun, 21 Jul 2024 08:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gGjzwYWr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD48C1F
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721549266; cv=none; b=f+9ukKpfSukC2cJfmQQv0gLYwP2kvL/0TxmFOMbbiZRyEqNHH+C0IjRTS714o6htpnkimAp4Wq/0/0pPB0eTi7aY8z9AF5apbmdlwSsnWwxHSU017f28kPg9qjRQQZzVkrKgvQdrPGrx+TwvcH2kyNpFEK+kilXz5KGH11e/2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721549266; c=relaxed/simple;
	bh=lvYg1B116y+J52Wu/+s3qX1Xsley4X+yElsEnfJOxo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lj8B/wvXCPzp+UvyyZMXo2f+JxphhKEVJ/LKP3jzTCItFs6V05PxuWY6/j9WrJzQfRcllOzxsCOEGifm4rBxks9kqNgetsECIHxM95v0BBcFPgYD+48CGuBHEVkhLrPOxThuQm6UfS8LqlD2e0X4fi1SngHZQDnAFgz8G2L6ork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gGjzwYWr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc65329979so22690685ad.0
        for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 01:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721549264; x=1722154064; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FY4DAi3VK4i6xb+rcQzINZyn3e567giP+EgpACj5DS0=;
        b=gGjzwYWrDfhfwfNIq7BSSvJliJPn6apfDfrIbfkRyZSuvp90iRfQDGjzhiNxND2sk5
         RnEHEXuIeJgi643kZ8Gqde8ZZ38LayTA6hOeuEBQMN3Tue3DEx15RrkpepESTdfXJBMg
         +EvQ6SOpR1kEloQTp+2+uPqa6v84Eb9dDpwdKWwfZgFrdJyLz22s5nz3jaTFq7Ac16Uc
         yw8KlCNQP+zRNcNCeMSr6O6/arAMKfvqPRoXgiwCvNIgFesr3rAuzV7jdRL8kLxAb/oZ
         e1LYC9vH/8xVlmf7k9YHpZXg3xB0eFZzMtXl5b550GBALXsqhwooXu9iPrZcWdatHMQk
         wAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721549264; x=1722154064;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FY4DAi3VK4i6xb+rcQzINZyn3e567giP+EgpACj5DS0=;
        b=qOvF1Ml15fS9qZjbi2G7EZ3MD6hOIMQiofLNFee//Ii/ylf+iplx5fM9+CD4oym78a
         JdD9Gr9OdAiug3x8EQe0vS5gJNHMR9fGKcZWyMcBRYLUm0ANkqu5xoi/SZlQ7rRvq1eq
         boyVvncswsp6fRMilEtHN8b3lFsZ5M4/s8uCdPmptCZBxyYLAR2nkrzAzJ1jvk4nf2h5
         be5jsirdmDaT5unKdqmO2skx7A0L8dFn2uq65dDKOgfd24l6jCH55ZxPWiFHey0Y7KUD
         aZkwfr4KfDB36/O8PfSE6o0PWwe4u2bAsOpPTI30nGVlPrEYYfXotHjZVs3lnkCiuUWH
         WylA==
X-Forwarded-Encrypted: i=1; AJvYcCVjYA1MHOAXgPJz+nk/iXTfgdYSjoL0RNNJ/hpE3E9HaOPBATefo3h3Vj5SrIG3l+tHAb5WwEBKTZZFSNLD6UtIuuer
X-Gm-Message-State: AOJu0YwoUsrkQq+0mLqbOPDK1ntU31sahSYrOZDWKNPPBSoXuGO/W8OO
	+koz70LeZQh4xXfpec9O8gaX+T0dnz1CbAaKTLkSxXsec8g4UDa/iOFrp8PRnQ==
X-Google-Smtp-Source: AGHT+IHLS+82V8WDv+DxOBruh31E1ZQpXfA1aKcSS2KRnMcW++Iewr3PJOotonJexwj4BwLKmdHEvA==
X-Received: by 2002:a17:902:d48f:b0:1f7:3a4:f66f with SMTP id d9443c01a7336-1fd7462125cmr50457945ad.43.1721549263981;
        Sun, 21 Jul 2024 01:07:43 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f42c879sm32576175ad.188.2024.07.21.01.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 01:07:43 -0700 (PDT)
Date: Sun, 21 Jul 2024 13:37:35 +0530
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
Subject: Re: [PATCH v7 09/10] PCI: imx6: Call common PHY API to set mode,
 speed, and submode
Message-ID: <20240721080735.GF1908@thinkpad>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
 <20240708-pci2_upstream-v7-9-ac00b8174f89@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-pci2_upstream-v7-9-ac00b8174f89@nxp.com>

On Mon, Jul 08, 2024 at 01:08:13PM -0400, Frank Li wrote:
> Invoke the common PHY API to configure mode, speed, and submode. While
> these functions are optional in the PHY interface, they are necessary for
> certain PHY drivers. Lack of support for these functions in a PHY driver
> does not cause harm.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

I've mentioned an issue below which is unrelated to this patch, but please do
fix it (in a separate patch).

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 57814a0cfab8c..c72c7a0b0e02d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -29,6 +29,7 @@
>  #include <linux/types.h>
>  #include <linux/interrupt.h>
>  #include <linux/reset.h>
> +#include <linux/phy/pcie.h>
>  #include <linux/phy/phy.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -229,6 +230,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
>  
>  	id = imx_pcie->controller_id;
>  
> +	/* If mode_mask is 0, then generic PHY driver is used to set the mode */
> +	if (!drvdata->mode_mask[0])
> +		return;
> +
>  	/* If mode_mask[id] is zero, means each controller have its individual gpr */
>  	if (!drvdata->mode_mask[id])
>  		id = 0;
> @@ -807,7 +812,11 @@ static void imx_pcie_ltssm_enable(struct device *dev)
>  {
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
>  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
> +	u8 offset = dw_pcie_find_capability(imx_pcie->pci, PCI_CAP_ID_EXP);
> +	u32 tmp;
>  
> +	tmp = dw_pcie_readl_dbi(imx_pcie->pci, offset + PCI_EXP_LNKCAP);
> +	phy_set_speed(imx_pcie->phy, FIELD_GET(PCI_EXP_LNKCAP_SLS, tmp));
>  	if (drvdata->ltssm_mask)
>  		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
>  				   drvdata->ltssm_mask);
> @@ -820,6 +829,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
>  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
>  
> +	phy_set_speed(imx_pcie->phy, 0);
>  	if (drvdata->ltssm_mask)
>  		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
>  				   drvdata->ltssm_mask, 0);
> @@ -955,6 +965,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_clk_disable;
>  		}
>  
> +		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> +		if (ret) {
> +			dev_err(dev, "unable to set PCIe PHY mode\n");
> +			goto err_phy_off;

'err_phy_off' should power off the PHY, right? But this label is used to do
phy_exit() which is wrong. Please rename this label to err_phy_exit and also
use _this_ label to power off the PHY after the failures of phy_power_on().
Right now, PHY is never turned off in error path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

