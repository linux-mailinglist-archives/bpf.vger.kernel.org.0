Return-Path: <bpf+bounces-29108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CD48C03C6
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 19:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FCE0B22DFC
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E7512BEA7;
	Wed,  8 May 2024 17:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApoqKHzX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E088C12A142;
	Wed,  8 May 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190741; cv=none; b=m1d+tFG6xooayRlmC3IudsxcLT6uYhfcI94qotj7Or4zvNv/v5xC8IsJO/nraLu+fBpre0t3sSIWJDdfbx0hktIbFidsNN8Zw+sxdsJUwbpBrMgoIoaVzjYLmJrVsq7xFDZSl+pZEMwHRZXP1ClV4Y6bOCFxSj2lagsPkEN/jU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190741; c=relaxed/simple;
	bh=V08OoDeE/BUJIoy/ja+w/Rt8MrlxvnCD+7x3hx9Uva0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gNgM78kqt/WBGUrUbLJNyr0C34hnauJIShECfOVtDuJEaOOzi6+iQXLp/dzTtujbJujYW8B5dW9u3xX4H6zEP6lpsvaUz4IQ9fehS2K9dEQzm7O2f99RkumVtLfHdaUV1HkAuccLhUHQvAdv9XiyOBtuUNm9HuE8iT+UZVDzUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApoqKHzX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34118C113CC;
	Wed,  8 May 2024 17:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715190740;
	bh=V08OoDeE/BUJIoy/ja+w/Rt8MrlxvnCD+7x3hx9Uva0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApoqKHzX3z/2AoF31SX/TFqjty+rFAyu6nZmkQicKqhTFFUWZc5SOg/isoInxQnEL
	 tleEKtY19DWrfGBkUbdSs6Jlx+eim2DBrMwRQz6X/MNH1OT/Iqw0P2StAFeMQMbyHP
	 woEDpPaiopbpsQCYlzriwsjO6fBlGh7vRFUgbtkzitw9r1W7LIN8qTDQYmbfnc+DqB
	 LEhJdeaZln0oeeogQulM8UR9vHzch9mKiqulz3qyyvoaT7jMt2yDcv3PZGW/aAQ22w
	 uPM2Qo94Of5SndAMkD4TUAqIgcc4xSc9koRfQzyrM8jBr2jpBMYZNU3H7GZPm8EXfA
	 iZSBTutGzIMdw==
Date: Wed, 8 May 2024 12:52:18 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, bpf@vger.kernel.org
Subject: Re: [PATCH v4 10/12] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Message-ID: <171519073564.2270132.12798685611534581552.robh@kernel.org>
References: <20240507-pci2_upstream-v4-0-e8c80d874057@nxp.com>
 <20240507-pci2_upstream-v4-10-e8c80d874057@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507-pci2_upstream-v4-10-e8c80d874057@nxp.com>


On Tue, 07 May 2024 14:45:48 -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings. clock-names align dwc
> common naming convension.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


