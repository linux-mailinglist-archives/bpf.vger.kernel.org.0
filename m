Return-Path: <bpf+bounces-35186-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AC99383E4
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42AAB20EF9
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43979BA50;
	Sun, 21 Jul 2024 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7SqcxH4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8278C13
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721548692; cv=none; b=rNU972bO0/QNpk0yg6LX9rwTaw9X2G7zetRIooFtUcSoNqORfHd22qwh5/pSoBM9/uCPnv/VDoWG1vhXhqPb1pIgJnBReNnYGYks+4pPGwxtYTPJawWX9ryQkj/jus6RrlSTvKC3WgUIPZC8Fz+UjmHre02u/HTZmdMZFxqTHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721548692; c=relaxed/simple;
	bh=NI687GCHjldfGpK107QeC6EjKSPt5ohNW/uOojsOCXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMi7gBZ3zXhUCR7pmEwDCyesBh5SyrP8Q/8UEZE/I0IiQhIlAQ6L+e2F2JtlMEq0/4TGVapHw/wJ8dDwn60PROkJO8VBhGerzUrw/zPhSM+GRKfkIruBaJ1KgXv417TX87cwT3scWJlVHOX8qrcDcPsRfVdfQeUdqk5djIayaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c7SqcxH4; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7a0b2924e52so202711a12.2
        for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 00:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721548690; x=1722153490; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=raatYppCAGhkFlzNXfUu8dG+wXWP3mZb3MIn5RqUSNg=;
        b=c7SqcxH4bLs3hd6OdtSajn/btADfaQBjKkV5E2CLPA6wuik8egJQhg0qL/g7RAdxWT
         adMwDIc1VvhQouFQ5WHpMvb9mLD+xQpCfd98zfjWHCRfrDSXIIVqm/Ff+ATHEfqZ7lCD
         OCRf6ElQ5pI/qH8hJdrafV9rlgBiedogfPL8d0ZNGibvQ3sFiEWuZYxjCgtp7i0lqtZh
         rdOP11wGIfrfBT+PKY0Eosr5roIguPCW7ylo8BMwUf1CH7DTEVnLWZzJcnmlP4WNrTxz
         TYNEwVAI+BkgLEDZzzeM5u1Wnxmf7NJNl4nd1lAlVCR2cs+o0PC2LmD1pXSC9MGabhZY
         TutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721548690; x=1722153490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raatYppCAGhkFlzNXfUu8dG+wXWP3mZb3MIn5RqUSNg=;
        b=Z2900BTWPBn8VZcRhymJvH1rMsKCc6+rz81EDS8f3EGvojcUUXswzXUrTaWafjQbq0
         XyD5R6fSp3eUQHvLicA/HVrFiW8xle+ZLwiz06YIfR4s2mGrbqVUgMHteB+piO+u67S5
         bAMuku0mPjAHGCmIjTq+hld9Xgw0gqg9ehv2hfhI2qXeNMtBHVqko5cVic7wTiYf05H+
         LYbwm5tVQDYyx7FqEcCkkECFsyrW9VdS3+0fI/xqfBy2IXPrUqtBOlC2kXTXY3HAH/QL
         YosgaasiGAlGKedItul+F7+lBDcP9YjIcc+ojaNuTWaKrDxyhDyAwtjdqAsuJEewEjdQ
         FLkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcV0IiadpiXS2F+nQZt+gpXkMf11lJaEN/TnRjoJnMdz42XnBRSRLEWOKej06oOdR9VqQHyxD2a1cock7kKhsY0w3D
X-Gm-Message-State: AOJu0YxRnv8ZwOv15rvuu1QXKrCSO9tKVJntBj2+yE4iUyBd+E8y37Cn
	XNQBHchxgzFguIpJpiqyqRkQXY1WpvR8tXEX46TdRH4hmj+FY+6RRELB4W4qeA==
X-Google-Smtp-Source: AGHT+IHp7aazJddbvZ+iXp2BV1KA3JLT7zvAEeg/7m94Sx/VEbulyCyvjIAeg6d2fD9sAuwdN0elyQ==
X-Received: by 2002:a05:6a21:3282:b0:1c2:94ad:1c6a with SMTP id adf61e73a8af0-1c428643b72mr2081732637.37.1721548690016;
        Sun, 21 Jul 2024 00:58:10 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb773029d7sm5789297a91.15.2024.07.21.00.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 00:58:09 -0700 (PDT)
Date: Sun, 21 Jul 2024 13:28:02 +0530
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
	devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 08/10] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Message-ID: <20240721075802.GE1908@thinkpad>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
 <20240708-pci2_upstream-v7-8-ac00b8174f89@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-pci2_upstream-v7-8-ac00b8174f89@nxp.com>

On Mon, Jul 08, 2024 at 01:08:12PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings. clock-names align dwc
> common naming convension.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> index 8b8d77b1154b5..1e05c560d7975 100644
> --- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
> @@ -30,6 +30,7 @@ properties:
>        - fsl,imx8mm-pcie
>        - fsl,imx8mp-pcie
>        - fsl,imx95-pcie
> +      - fsl,imx8q-pcie
>  
>    clocks:
>      minItems: 3
> @@ -184,6 +185,21 @@ allOf:
>              - const: pcie_bus
>              - const: pcie_aux
>  
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - fsl,imx8q-pcie
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: dbi
> +            - const: mstr
> +            - const: slv
> +
>  unevaluatedProperties: false
>  
>  examples:
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

