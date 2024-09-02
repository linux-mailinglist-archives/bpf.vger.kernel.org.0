Return-Path: <bpf+bounces-38740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24687968EFE
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 22:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1CC1F232D3
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C291A3A9E;
	Mon,  2 Sep 2024 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTSOvv0g"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2F69959;
	Mon,  2 Sep 2024 20:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725310777; cv=none; b=s1SbLbeU2rBQoYlllj977a6uagz476pKOR8csfeoncrwv2UHFma+OU4JFg/rob9qNtlhr6NKvvjIGOfboEX0e+OvvAoyEIQO+z0iOjziwSsOgZdVRTDu7NYN+XicjeIWtvIlX5YAnEMzlc+8dOvNcfgytM4pzXgXWcUpLhxqykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725310777; c=relaxed/simple;
	bh=r9qaTh+53ujld32cT6POMGMmnH20RcpZ6t2TTllW2Hw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=nuQ3sh5T3dQpmA64lT/FLJJYwFeeWIcMQIdi4es375S2DvkNhFc+beYwEydfPhzd7cB80kaZYB+kOhSA7M7EAL7XYiCNfR03b/Zy1XMKQMJgb2Cm4uxWSAqktbnTDLgASbf3VpXEhuGI6CQP3jH9EniahJmQdmtjZgPO+9jnBHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTSOvv0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5D6C4CEC2;
	Mon,  2 Sep 2024 20:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725310776;
	bh=r9qaTh+53ujld32cT6POMGMmnH20RcpZ6t2TTllW2Hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aTSOvv0ge41O8LerqN8uWFZtaSDOgysBtJ8534F0opdMVWDxru2yIsGdNOPi+y3WA
	 xaQV0Y5QVUT5+1Ly2uwOzRixSARVkaY8NAN8qnMmS5w8CbAlbljTcbbmoVsa3ZIhKO
	 yGcFLWdKFXpSKfNy0e/iRQpcckh2yu+daDnuYY8nMfbQ2WNnwTskGAc2cBIxH1OcXn
	 Q9ULidDmdbnWSOz7O1ZSjoAc2QAlRnAT1dpbErxU9JPQ29KpkbbNw9sJ1vBcG87HVA
	 k85R53LYg1DT2JxnXckQVeS2DKsovSZp6tbYltmvYi/1H2ZYK/bQFBEJDcj+NPCoaq
	 IPNg4fOyUEh8w==
Date: Mon, 2 Sep 2024 15:59:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v8 01/11] PCI: imx6: Fix establish link failure in EP
 mode for iMX8MM and iMX8MP
Message-ID: <20240902205934.GA227711@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729-pci2_upstream-v8-1-b68ee5ef2b4d@nxp.com>

On Mon, Jul 29, 2024 at 04:18:08PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add IMX6_PCIE_FLAG_HAS_APP_RESET flag to IMX8MM_EP and IMX8MP_EP drvdata.
> This flag was overlooked during code restructuring. It is crucial to
> release the app-reset from the System Reset Controller before initiating
> LTSSM to rectify the issue

What exactly is the issue?  What does it look like to a user?  The
endpoint doesn't establish a link correctly?

> Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Does this need a -stable tag?

0c9651c21f2a appeared in v6.9, but this could arguably be v6.11
material if it fixes a serious issue.

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 964d67756eb2b..42fd17fbadfa5 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1562,7 +1562,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MM_EP] = {
>  		.variant = IMX8MM_EP,
> -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mm-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
> @@ -1573,7 +1574,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
>  	},
>  	[IMX8MP_EP] = {
>  		.variant = IMX8MP_EP,
> -		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
> +		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
> +			 IMX6_PCIE_FLAG_HAS_PHYDRV,
>  		.mode = DW_PCIE_EP_TYPE,
>  		.gpr = "fsl,imx8mp-iomuxc-gpr",
>  		.clk_names = imx8mm_clks,
> 
> -- 
> 2.34.1
> 

