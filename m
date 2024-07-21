Return-Path: <bpf+bounces-35179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9FFD9383C9
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 09:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43601C20A55
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 07:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1F08F5B;
	Sun, 21 Jul 2024 07:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vTepMrN1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DCF1B86E6
	for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721547597; cv=none; b=hmkxaa13fLvHQB5UbadUiJsy65nPFSQEnuNF92Sv+LTyAfymHqnZ0zKmHX3++/hgOjzKJ1y8MPHNXtcu1wTdETX50Yfabp/2W2lb8uS6DhxNcfwL7DsPyQPqIO5QIVz22H44vMm1aAF4+MvHf5VLyAriT53H6qk7ygMIlI5VQLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721547597; c=relaxed/simple;
	bh=FKPYtsFtam4QQMK01ANM2dJ9eQL9oofZqTRrOT3jXts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iipTVxzmD9dR3l6TWgXcbQHQ3YXe6D1Xo6vd8OKejx9Muz6E+HDrrM5DPnooNbm69IbIPtNQ8G99NCZRXx817QVxo/xrVn3lE0LIPoGM9Mk08UkVCz8dCHf/QdNGyYUnOiU5J5kY3NLF6RZcUzO/OchBID+hZJ75hIiRAkGf+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vTepMrN1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-65f9708c50dso32240597b3.2
        for <bpf@vger.kernel.org>; Sun, 21 Jul 2024 00:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721547594; x=1722152394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N02rs0beU0+PCjKU6W+pNs3gEfWqOvtg3yl3XFcbS8U=;
        b=vTepMrN1lhDS8EyTZ8/9FJS4kOinxkHYvL32d7599ZLJL9fFXWRRNNIvGwR5a6KMxa
         nATLaRuFjtR38d/X0+QB8kciLZTRTO4sUqpcCsBgoOb8mQDwJk6PINVPcsS+mD6rGgRg
         HeuKTcavw48rMwjYmdNlf5oNuq4z5Qe8W6/oIgdGnxUcLYQhWZZ+/t4qtSAOcE9hsIjA
         XpJaC6x9cf1dVxrn+etHIOjQkQ16Hj0ijOtLZJHj7LQvCIc57gn/5mmmqNKLy8JngcgQ
         x25yQnH5VhwqeHenZ/v9/DigVZQjvLBphuLJz5sCWyPIFSBS8AbXGLTD2FzqQBzzivUc
         DDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721547594; x=1722152394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N02rs0beU0+PCjKU6W+pNs3gEfWqOvtg3yl3XFcbS8U=;
        b=Ser5BqXMelh+yJIb9jXoQJFo7bcx8eoR9gmABmGrGSdfZxg6Jd0liY4sGXaovQsreE
         OphG8EnGYCkWdFA0rQ7MrNlsYyO9bOWWcs10SZbMbA4Lw5vrqNj6isthh4A8zC2Kq/L2
         I7a4gzBL+/hJvldTWdBaJaNcV1ONPzBM4hhs7Xss/nAlBXj2r2aKwTNYfc0dXYmT3p9Y
         qPHsshwpQFMODggm5jyHyxaMToTBdExA+UEBgNjiH/wCqIaCDHKu7tY0wAXhdI6Z+jTJ
         vbv1/ku7fXMfd3EyOAkbIdkVyY3gp61RMlUDQW4Ms5Fh3D2fSGIS2EoztdaONoyuGUxU
         Qv5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/qfoCCgfi1+V4+Kbogt6NNtBf7yVmNYGnL2lo25LI5Kzb6tV2hdgiEbetvhuDwJxIQNxxuzAawUTQsxsyxXq/rNqV
X-Gm-Message-State: AOJu0Yx+nr3S6LUAmpxEnBbbfkSc5bHWtvQbVJI8tnmhTvGq3HvJtM4P
	Kd8KAD08Y9uVbuatz+AMiyOO5CniBNWa1pOv+QJW/XTZCk04Kh4jrHSM7AVftw==
X-Google-Smtp-Source: AGHT+IFQYY74iAGQY5pOOJPCWv5JUZVONiqWh0swcBRClZ6YAaFDgYxDWJLm9Z5K35Wb0bbXsmVAGg==
X-Received: by 2002:a05:690c:4441:b0:665:7184:fcd0 with SMTP id 00721157ae682-66ad8dc0d02mr32319017b3.23.1721547594246;
        Sun, 21 Jul 2024 00:39:54 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d2243d137sm439633b3a.31.2024.07.21.00.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 00:39:53 -0700 (PDT)
Date: Sun, 21 Jul 2024 13:09:46 +0530
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
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v7 02/10] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Message-ID: <20240721073946.GB1908@thinkpad>
References: <20240708-pci2_upstream-v7-0-ac00b8174f89@nxp.com>
 <20240708-pci2_upstream-v7-2-ac00b8174f89@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240708-pci2_upstream-v7-2-ac00b8174f89@nxp.com>

On Mon, Jul 08, 2024 at 01:08:06PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Correct occasional MSI triggering failures in i.MX8MP PCIe EP by applying
> the correct hardware outbound alignment requirement.
> 
> The i.MX platform has a restriction about outbound address translation. The
> pci-epc-mem uses page_size to manage it. Set the correct page_size for i.MX
> platform to meet the hardware requirement, which is the same as inbound
> address alignment. Align it with epc_features::align.
> 
> Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 9a71b8aa09b3c..ca9a000c9a96d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
>  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>  
> +	ep->page_size = imx6_pcie->drvdata->epc_features->align;
> +
>  	ret = dw_pcie_ep_init(ep);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize endpoint\n");
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

