Return-Path: <bpf+bounces-33453-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E6B91D2A7
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 18:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BA228170B
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 16:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A77152170;
	Sun, 30 Jun 2024 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nzbDSMnN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34B1527BB
	for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719764627; cv=none; b=VcBYp1RxuC5OPOazlUwUSK2f6rp4PL2ursQ8r/MAsHRbH0+Q53t9G73TRg8mnqd7MVridhunI9FEfX1nta4jIkkmAT/lAsHWfvqPsZ6o+WH9x96MDa3TlTfQfuPUD4Sy0+j4I9Ze2VwAQmtZA4PEMmuzx5x/eLVUo6hkdSFfkyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719764627; c=relaxed/simple;
	bh=9htU6WoutJrpUNff3Wz+szGkhLvVmq0dajsxQsJ361g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdhPMY/i+dN0KoO9a1O5ZWTO3V6xuxMSF9NHWkISGT4lP9JU50nt1cf3gr1aclBxH3UCQnjFtEHgVyVYtFqqdJjgukC/9uqSvaRJgFpreyZJtWGLZfdQJFA8kMdC6Wxcp+/7ln0dpwhv7WW31w9FGHWW8cWTpbcnY0qJUw3Iuhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nzbDSMnN; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-70df213542bso1054893a12.3
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 09:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719764626; x=1720369426; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=meRrKUBJYAi063Ybn9ckzWyMWuNq5WiRKh+4W6KHvUo=;
        b=nzbDSMnNik+uzqK89xn66O8/kqtzU+cs+lQtp3QU7gZX0dPPJyZsSIMimxqSna0txX
         5Cv74H+m2cQfbEC2mNCRABSLgMklRx2Mag2y381EXQ+00UF2eSGZLdgW+Gj/sjH4cKx5
         QISzNeXL8GBTX6XSB7bS6j8rsMxLmj2nZ3gRi1WHZ4kPwk3FADDMPs5rSA3MbsYuwJPa
         bgEUf3zpn6zPAdb7zfPOLvnW9mUHAUlz02XvzFK/tax+kW4jceMDZB3OwkKgazQrQE6S
         ulGD7Df2xWj2YWa3MH5KYN5Ij2z4fgjMzutJ9vuZssUo+Q5SPQXjq4LeSR8vVTGnVnRi
         ovzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719764626; x=1720369426;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meRrKUBJYAi063Ybn9ckzWyMWuNq5WiRKh+4W6KHvUo=;
        b=P5H60BrTnlq6EJmcRv+URXrVIkDwC11H09yVOC9PcG2L7GOKKOXEqRP4MnEDyXDEBJ
         vE5dBNu3ojJPwq0lrdy3AbEbd3ELcfmur3YjAXHTGoJPG/Y4p+/rrm1BGNFGsJTIvaM6
         6vacvVDXU0iAktqOs2wxqECVFV523yQ1nbitG53EOcpDF3SdChl/cRMNvSMa8/CRbull
         YlAHrsLx6MgJQl3+U36ddyGbXS4tqrT3j9NaJ/l5FcRKSAVcbFZs71b02rISqU1Gq34O
         EmRyjKHXpm0AwgSVvXgOsDO59+EXeAozYaGCDwsLPe6bA+wQSDlMwU8d2Fxp9Fa77QBt
         ZPAw==
X-Forwarded-Encrypted: i=1; AJvYcCV1t+DwPEdl+rom7e+OrEFf/GLm7bdL6l2FZlmTV9IX6GMRkD/NPRDrj6MxcjiRsWrX5GsgsaAYYjTtaw8c7L5QBdmn
X-Gm-Message-State: AOJu0YzqwKGbkKFGfmGj33OfxOvCBwlxm4JIBoG2+SwpI6LCGyT4tueD
	YRnTu/+UVjQ5hozPrRlmV6rVXGAJhLd8rRCiMoECJQw61fVtBNKZGfE3AOp2AA==
X-Google-Smtp-Source: AGHT+IFB5GWSyOiS5lFM4xMyeymwyJX3RWJBnJqEHBblq0QLaA5/nACE76UedKAKXnyWt2Xoaj7jKg==
X-Received: by 2002:a05:6a20:b22a:b0:1bd:22fe:fcaa with SMTP id adf61e73a8af0-1bef6275a83mr1942482637.51.1719764625453;
        Sun, 30 Jun 2024 09:23:45 -0700 (PDT)
Received: from thinkpad ([220.158.156.215])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce73e34sm5028683a91.30.2024.06.30.09.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 09:23:45 -0700 (PDT)
Date: Sun, 30 Jun 2024 21:53:37 +0530
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
Subject: Re: [PATCH v6 09/10] PCI: imx6: Call: Common PHY API to set mode,
 speed, and submode
Message-ID: <20240630162337.GD5264@thinkpad>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-9-e0821238f997@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-pci2_upstream-v6-9-e0821238f997@nxp.com>

On Mon, Jun 17, 2024 at 04:16:45PM -0400, Frank Li wrote:

You don't need the colon after 'Call' in subject.

> Invoke the common PHY API to configure mode, speed, and submode. While
> these functions are optional in the PHY interface, they are necessary for
> certain PHY drivers. Lack of support for these functions in a PHY driver
> does not cause harm.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index ab0ed7ab3007a..18c133f5a56fc 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -30,6 +30,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/reset.h>
>  #include <linux/phy/phy.h>
> +#include <linux/phy/pcie.h>

This should be moved one entry above.

>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  
> @@ -229,6 +230,10 @@ static void imx_pcie_configure_type(struct imx_pcie *imx_pcie)
>  
>  	id = imx_pcie->controller_id;
>  
> +	/* If mode_mask[0] is 0, means use phy driver to set mode */

/* If mode_mask is 0, then generic PHY driver is used to set the mode */

> +	if (!drvdata->mode_mask[0])
> +		return;
> +
>  	/* If mode_mask[id] is zero, means each controller have its individual gpr */
>  	if (!drvdata->mode_mask[id])
>  		id = 0;
> @@ -808,6 +813,7 @@ static void imx_pcie_ltssm_enable(struct device *dev)
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
>  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
>  
> +	phy_set_speed(imx_pcie->phy, PCI_EXP_LNKCAP_SLS_2_5GB);

Is this setting really universal? This looks like applicable only to specific
platforms supporting this link speed.

>  	if (drvdata->ltssm_mask)
>  		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
>  				   drvdata->ltssm_mask);
> @@ -820,6 +826,7 @@ static void imx_pcie_ltssm_disable(struct device *dev)
>  	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
>  	const struct imx_pcie_drvdata *drvdata = imx_pcie->drvdata;
>  
> +	phy_set_speed(imx_pcie->phy, 0);
>  	if (drvdata->ltssm_mask)
>  		regmap_update_bits(imx_pcie->iomuxc_gpr, drvdata->ltssm_off,
>  				   drvdata->ltssm_mask, 0);
> @@ -955,6 +962,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_clk_disable;
>  		}
>  
> +		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> +		if (ret) {
> +			dev_err(dev, "unable to set pcie PHY mode\n");

s/pcie/PCIe

- Mani

-- 
மணிவண்ணன் சதாசிவம்

