Return-Path: <bpf+bounces-28104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88EA8B5C46
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A360A282A5C
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2890381745;
	Mon, 29 Apr 2024 15:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThehQ2wk"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E4C8063B;
	Mon, 29 Apr 2024 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402983; cv=none; b=F15MRTaEj6h/dX1bohpqIcwtD3hgf7mXNy7wNFi9VJ6x4bAdMI7kgs6hf2LbqoZUXlvfvOm4KJlEpJZjOHGASy/v/ZmT97FsF+QhhgJnqwJ1bk6Lh4wgD7036raCXds0cECYXAqx4v3do2TxvvLJBv8Go2GdAgZ0u+ehqCxwKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402983; c=relaxed/simple;
	bh=RX4cYniemFuG3lk+7WLNx3ir0tv4DUv5L3+eCy8TEno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On9RZ9D6MLMnxFElfdZkr4hAoJ6nZKT9IgkYgxaIjd7JPGAus5j675eOcllKyOToDtzvNmpvuf1mf0wDgLH44FO/9hh3xoSnbN6mJynE9z/l1LPzvliPuYNMzC4b14YxnAT9LWMYBz2dt+1orI6YzwsRCKLf0eNVcycKjbdHo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThehQ2wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9F6C113CD;
	Mon, 29 Apr 2024 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714402983;
	bh=RX4cYniemFuG3lk+7WLNx3ir0tv4DUv5L3+eCy8TEno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ThehQ2wk13ohVnLVAQSFwtrc4fALjeYyegCUYWZ52eVarW0UbpSLbMQFGKxV3w1J9
	 65mnWig7FbvqD2uNSN+znpXVRvMZIO5sJKnYCUXieuGz0+Q8xLsUKAgTgA+XnOKif2
	 x3jJUZgAmgCGIYgHu0kJylt1Y/vLauTMCbGzB49HXWx8FVM6tKJoDkrEDPuMmrJxKw
	 XY8DS3P2WpSHv06xGqrkTHC4Q+f2UtCoduyHttHzybY/PlWb02+hEIjnctUb3kTnk4
	 icF0okz7r6qO2tq1EhNehtfjEhKum+jZoTt9V6e5vozl1+R2nZHktInpJziS7BN54J
	 uoNj72l2pFb/Q==
Date: Mon, 29 Apr 2024 10:03:00 -0500
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH v3 05/11] MAINTAINERS: pci: imx: update imx6* to imx*
 since rename driver file
Message-ID: <20240429150300.GA1709920-robh@kernel.org>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-5-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-pci2_upstream-v3-5-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:41AM -0400, Frank Li wrote:
> Add me to imx pcie driver maintainer.
> Add mail list imx@lists.linux.dev.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8d1052fa6a692..59a409dd604d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16736,14 +16736,16 @@ F:	drivers/pci/controller/pci-host-generic.c
>  
>  PCI DRIVER FOR IMX6

Don't you want to rename this too?

>  M:	Richard Zhu <hongxing.zhu@nxp.com>
> +M:	Frank Li <Frank.Li@nxp.com>
>  M:	Lucas Stach <l.stach@pengutronix.de>
>  L:	linux-pci@vger.kernel.org
> +L:	imx@lists.linux.dev
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
>  F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> -F:	drivers/pci/controller/dwc/*imx6*
> +F:	drivers/pci/controller/dwc/*imx*
>  
>  PCI DRIVER FOR INTEL IXP4XX
>  M:	Linus Walleij <linus.walleij@linaro.org>
> 
> -- 
> 2.34.1
> 

