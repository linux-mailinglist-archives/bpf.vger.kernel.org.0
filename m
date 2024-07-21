Return-Path: <bpf+bounces-35188-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DA7938401
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C150281603
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A05C2C6;
	Sun, 21 Jul 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="um8VK0R8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8AE944D
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721550228; cv=none; b=MtibTyLaJF/5KQnXullV6EBdXQAc2nu/jPfMtQb2/oJOvyO8nTJf6Inn4I27/xJKxA7VoxCCv9VcMT8tKF2kvL8RmU60KY1lZl+DmyboFB3A/6MD7R5oajathpBiH4ZQwKUmowrXkilpJkwLyrmDjtWkTT3gbBYLQXevc7qyBKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721550228; c=relaxed/simple;
	bh=o+DJ6waEVY3RvqLvdv4FT/TEOumYoApMdITMhfQ0u5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsZuLCLhxb/JKLv8MfIELgyjYhlKWO1moBU92FReUSVpW0QCzJdRwU4O+2k4bHbTCIySIcyNl6t7VS/MQdnm0nmYAl1QYSCU75CABjK2ba0XY90IRkBw9pKTr5Zq604IjqNiCaE481wO08uj4WVG3cQPPK2unP/QieDGLtBgtpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=um8VK0R8; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7039e4a4a03so1881501a34.3
        for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 01:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721550225; x=1722155025; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CZWtiPJtZ43++/gnJNwx4X2rQpR8wl/UQidt0ugSAnI=;
        b=um8VK0R8vjmCNBmwtybO8WfJrd2ZuqGgbJGSh8JtDHGVFvRve8TVSGvQw9DorT/Fkk
         KqZltPp4HNH/L0VspSy5CsjCmUp+i+9sF9DsB/GdMFy69U6kfJnHWWgpmbFyIBJ6JE5/
         HOr03oRZZ0HS3Dk9U6nHhyEZmTtSuswHMkey5ttDY9TbNO3ek0Ss0jAyaklwSttnR7GU
         AYdIfjTUVvbPk6VFY1Uf/XNJS+fwmbq/qENyz6BGaxljvZEsdrcayGx+M9L6kbBe8OBq
         rA2MoalDRKXOSa7BwWHfHMvMHUL5zE0qHjL5My5dVT/r3w81sKQRoRW7NZcGW8U0FZl1
         LwuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721550225; x=1722155025;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZWtiPJtZ43++/gnJNwx4X2rQpR8wl/UQidt0ugSAnI=;
        b=qX2tnTrPuQArHYN0Gg8ke8wQqfff3R3rG/IRtwlkcO2O6/1HJ6IWoG6+22TbH5cekM
         i1bWLRn7twltnvz8mc5we6lzmTTjqYTR5leckpsV1U3jACvOTy6ck4H3AnFDkYtRw2FS
         m4gpWN/GXi86YQClIxJEuDMUrx8DTWyXhBErROrDQsGBKNcN3fL84xvp5hO1/STxjph6
         6VdQiQ+FBCS01gm1XXFdSNvmsJBI8A6nQ1yW86sNMPhk7SdJozEgNiBX6YXoBG7LXPoW
         ETei+ixiRRhRCkAjJu14Hlu4QSKXVvg44z+dZCoMokDTUwk8hs237cIjXjOZjZMH71aG
         oLQA==
X-Forwarded-Encrypted: i=1; AJvYcCXPf0RZ3wwQFlA3IokBc+qj2LWnSb5s0eAf5yhM+YHQAHUz4Rs4DrhuIEuXHKfSkFW0G4LurCNj1hOA00J+fpbWeAFK
X-Gm-Message-State: AOJu0YxYG0YhpCxElcDVP5ORDLCdfkZzV2DKdcHzuB0F5NZWAsAEEFp5
	9pGuDOxT4f43m8uVoPg+vzsYooHcLcXbWjuzA2cZfPEN3IgTSJXPaPgAfVkjOQ==
X-Google-Smtp-Source: AGHT+IFfjJ8Cc595RCoBIrmV7WXBKOr6HnF25bvKEhlw/SDpWj45/smT1TJlSOniO5oPcyQREg2Jnw==
X-Received: by 2002:a05:6830:3986:b0:704:4808:1d7a with SMTP id 46e09a7af769-708fdb22d04mr6996262a34.13.1721550225266;
        Sun, 21 Jul 2024 01:23:45 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70cff59e188sm3520618b3a.157.2024.07.21.01.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 01:23:44 -0700 (PDT)
Date: Sun, 21 Jul 2024 13:53:36 +0530
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
Subject: Re: [PATCH v7 10/10] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Message-ID: <20240721082336.GG1908@thinkpad>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
 <20240708-pci2_upstream-v7-10-ac00b8174f89@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-pci2_upstream-v7-10-ac00b8174f89@nxp.com>

On Mon, Jul 08, 2024 at 01:08:14PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> the controller resembles that of iMX8MP, the PHY differs significantly.
> Notably, there's a distinction between PCI bus addresses and CPU addresses.
> 
> Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
> need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
> address conversion according to "ranges" property.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One comment below.

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index c72c7a0b0e02d..4e029d1c284e8 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -66,6 +66,7 @@ enum imx_pcie_variants {
>  	IMX8MQ,
>  	IMX8MM,
>  	IMX8MP,
> +	IMX8Q,
>  	IMX95,
>  	IMX8MQ_EP,
>  	IMX8MM_EP,
> @@ -81,6 +82,7 @@ enum imx_pcie_variants {
>  #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
>  #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
>  #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
> +#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
>  
>  #define imx_check_flag(pci, val)     (pci->drvdata->flags & val)
>  
> @@ -1015,6 +1017,22 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>  
> +static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
> +{
> +	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> +	struct dw_pcie_rp *pp = &pcie->pp;
> +	struct resource_entry *entry;
> +	unsigned int offset;
> +
> +	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
> +		return cpu_addr;
> +
> +	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
> +	offset = entry->offset;
> +
> +	return (cpu_addr - offset);
> +}
> +
>  static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> @@ -1023,6 +1041,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = imx_pcie_start_link,
>  	.stop_link = imx_pcie_stop_link,
> +	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
>  };
>  
>  static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
> @@ -1452,6 +1471,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			return ret;
>  
> +		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CPU_ADDR_FIXUP)) {
> +			if (!resource_list_first_type(&pci->pp.bridge->windows, IORESOURCE_MEM)) {
> +				dw_pcie_host_deinit(&pci->pp);
> +				return dev_err_probe(dev, -ENODEV, "DTS Miss PCI memory range");
> +			}

Is this check really necessary? Can the driver work if there is no MEM region
defined in DT (irrespective of the flag)?

I can understand your intentions, but this check seems pointless to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

