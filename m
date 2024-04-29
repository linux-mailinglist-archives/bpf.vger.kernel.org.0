Return-Path: <bpf+bounces-28110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B8D8B5E0B
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 17:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037B1282AE2
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9224C83CC1;
	Mon, 29 Apr 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITNnj7tb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B05B83A15;
	Mon, 29 Apr 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405707; cv=none; b=kEj7FF4nZ2V2VKtfiPhBihufPBomnr85q75+HjVWpwhhm4Vuwls1QgM5DV7CAHN2Z+LQvixIZPqB6hFQpgFnPVS4zvlSaSGBbmM2vyMS4TVDjkxx3N0Hj+GYxAShF1ZyZSmBSrcCuAF7P+klRJtXXHHzagx+EacToFarMnk8rMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405707; c=relaxed/simple;
	bh=cyhUbzfUoN1KUr5rX6PXJv0rnxb5FXq2sfNUH2u8A/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QGEqWOR/NI2/rMDr1sWH8nufxONEq5kg7A2zqS24//VdcEGxk9R5cEU3AamHppR7BKZKW6LQFlJImlH4+8O7Yav7NuoV8Y2FkxxBxAz2mTfBhEROlVe/EseMFzqVb372/dkUZAyjQzbXSrIsBHz3MRPdGFv7c0+3PA3qWVCgmAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITNnj7tb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A9FC4AF14;
	Mon, 29 Apr 2024 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714405706;
	bh=cyhUbzfUoN1KUr5rX6PXJv0rnxb5FXq2sfNUH2u8A/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITNnj7tb3iF2CMw5njk9bYQuJ8Ls3TaFXNfDioGLZghCik30KMKJS0c5QTmB9jF4z
	 QTWgdlnBGzjFXglEjF/QhIZQL9whbqQ+eRVlqhlLpZ62eXQwm8YLh7/XuCR8t/Lb7Y
	 Yq1feJyJv1U4cjAM6Aqu9kqGlugTwtBpfCp3dp0wPZ6ODDAa7YVhBRYb1pEzZRVgR6
	 pIpuXiKmdSGzwSurBOahCUrJqfqVuczUfeYDpL05vD4Hiv/qjYIHm2WcG9B7ddVCu/
	 WtCeiKEt+ZeJR1zSD6GkZUeIiTy863YIH9uzzllfckFZn4Qrj/Fr8//iPOtpC5sGst
	 CuF+erd4g0Gqw==
Date: Mon, 29 Apr 2024 10:48:23 -0500
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
Subject: Re: [PATCH v3 10/11] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Message-ID: <20240429154823.GD1709920-robh@kernel.org>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-10-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402-pci2_upstream-v3-10-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:46AM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings.
> 
> Add "fsl,local-address" property for i.MX8Q platforms. fsl,local-address
> is address of PCIe module in high speed io (HSIO)subsystem bus fabric. HSIO
> bus fabric convert the incoming address base to this local-address. Two
> instances of PCI have difference local address.

This is just some intermediate bus address? We really should be able to 
describe this with standard ranges properties.

> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |  5 +++++
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)

