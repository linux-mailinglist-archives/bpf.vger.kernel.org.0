Return-Path: <bpf+bounces-33454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4DA91D2D0
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 18:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55CA281530
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631C153836;
	Sun, 30 Jun 2024 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GE3se321"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B815445B
	for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719766275; cv=none; b=ndeNq6BsSIv0AN2cM2yNICa43yZSvymhOHYyBr4BSKUOEVKko4Ec4oFQZs2w9eEvLTlU5d1x+1QQASgr7qYPM0CpFQdtVQAWXr22HFDuHXgt29h+xRkRrdgGCBm8+WdpxYtZR/OPo+tFFjhj6yEcenmln49KpVtv1PSbsEI+MYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719766275; c=relaxed/simple;
	bh=KW95Xs+2SEQNSdUC2pQc9P714W11EYxOYboCC1ErVcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUdwmaVaLSGzWCJdJIw7Dk70b0MfVQP3wzWX4TaikM9rldvQLvoi6ewpMucQimD3BixdlL2jaeUrSPiGHPhEpoDWfpA3SlEaqGQhXR171ferVZ4HAlGWDoE+SQ0cyoDIUb0psqXEJFtQMcm1HYS6kgerf9VV6Yu0k9unqQzmJzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GE3se321; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fa2ea1c443so17106325ad.0
        for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719766273; x=1720371073; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZmmRRw0rUqlBzxiX2pzqJcIUiD2NcUThL2qZCGcblbE=;
        b=GE3se321fHG/ZK0Bj+dnnW9jYDfozlkg8+oNzxDOS6CV7C6FIF7rBYHbI8aRKJuonH
         4GpGG9q0WSgfbgnGJV89h6ZB1kURJnnoNh3BHdidBQB0pNn9e7wdRt5sIthOLiKRQeZs
         RETxtYpqRzzFnMs2dvVG2NeRFwfI8Y2H3Eb2KKUK5CLXBxAz+kjDoIMQ2DFQhTKM4FXi
         beLDe3Y88VgvRXAe3spFeUSb4M0lixytlCW0rhy9VrrS8BFoiciq3kHJ3H/SCmBlh+tt
         grFmOhOg8EPyPut8M+x3Ies+q68bNjU1tIW2HOpfttCUPALr8zHqazrdlLDCSCeQCKxD
         TJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719766273; x=1720371073;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmmRRw0rUqlBzxiX2pzqJcIUiD2NcUThL2qZCGcblbE=;
        b=wZyyiTvVNGRI/LZ8bxSoTnGIlbQdHTHCRTUzzNRfaIfat085PPBFvjOWH1R/AoFEzN
         4W1XQ+MJlVeDasPXL1vhAyQynhKDDD/CkrDXGW4IYagkuGlRnbwDAvz28WOXHUOAfLs2
         I/zDw0k5CZeuKFY957ZBplWVc/yvusU4dsBlXwYOj5AyytIAAompZi/qTKcCGiccCJfl
         SZeb+8wWgJGgat/iv3XJzsvi8rH/QxcGrJv2S7f6W/JQOAUpA93HarSsFllmQ0ZInaui
         0r4dga6R9+mITTV5c0QYIlfXwjtxczYcCHki7ssWexqG6/Y8BK5IC4P/7pjpOWoR8E++
         Iddg==
X-Forwarded-Encrypted: i=1; AJvYcCUc3UOutPnsT/O9RsIcHCJzWPSwHOUE5T6Rrx0pbA4pMwOwy1bNZnnOmVmbCOTYjrVT9I76Mcl9JMOTAjF2V5olJWZc
X-Gm-Message-State: AOJu0Yy+JQMUSxh6BDzGNyXE9B2+30/8ArkzYLIqrkMpGkYJaKiWHkKc
	dxLWxkEL42noG8/0sZxgJSw1yEyoFjrycUVMoZR2qcEKnU//ZfFG0D5xD+Cv1g==
X-Google-Smtp-Source: AGHT+IFb9xngZdlMkF4/QJVf4vOFYOhYP0MvzKGLF16d5uCq0aKbtbmw7vV/puD8i55ELqdRaIJQGA==
X-Received: by 2002:a17:903:22d1:b0:1f9:d111:8a19 with SMTP id d9443c01a7336-1fadbd01fbcmr30336695ad.64.1719766273266;
        Sun, 30 Jun 2024 09:51:13 -0700 (PDT)
Received: from thinkpad ([220.158.156.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1a82sm48223075ad.59.2024.06.30.09.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 09:51:12 -0700 (PDT)
Date: Sun, 30 Jun 2024 22:21:03 +0530
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
Subject: Re: [PATCH v6 10/10] PCI: imx6: Add i.MX8Q PCIe root complex (RC)
 support
Message-ID: <20240630165103.GE5264@thinkpad>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-10-e0821238f997@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-pci2_upstream-v6-10-e0821238f997@nxp.com>

On Mon, Jun 17, 2024 at 04:16:46PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Implement i.MX8Q (i.MX8QM, i.MX8QXP, and i.MX8DXL) PCIe RC support. While
> the controller resembles that of iMX8MP, the PHY differs significantly.
> Notably, there's a distinction between PCI bus addresses and CPU addresses.

Do we know the reason?

> 
> Introduce IMX_PCIE_FLAG_CPU_ADDR_FIXUP in drvdata::flags to indicate driver
> need the cpu_addr_fixup() callback to facilitate CPU address to PCI bus
> address conversion according to "range" property.

'ranges'

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 18c133f5a56fc..d2533d889d120 100644
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
> @@ -1012,6 +1014,22 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
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
> @@ -1020,6 +1038,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.start_link = imx_pcie_start_link,
>  	.stop_link = imx_pcie_stop_link,
> +	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
>  };
>  
>  static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
> @@ -1449,6 +1468,13 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  		if (ret < 0)
>  			return ret;
>  
> +		if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_CPU_ADDR_FIXUP)) {
> +			if (!resource_list_first_type(&pci->pp.bridge->windows, IORESOURCE_MEM)) {
> +				dw_pcie_host_deinit(&pci->pp);
> +				return dev_err_probe(dev, -EINVAL, "DTS Miss PCI memory range");

-ENODEV

- Mani

-- 
மணிவண்ணன் சதாசிவம்

