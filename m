Return-Path: <bpf+bounces-33429-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAAAA91CCED
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 15:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50881B220C5
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 13:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F480026;
	Sat, 29 Jun 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fvx13+dx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE129CFB
	for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719666336; cv=none; b=D9BzPUHWrYNzSC2Snr4wQeOBvlTDXY8XNgfSUIKDw+6EnX5A9hwXNxJVcvFWQQ3AslwvJ0J3LboyunY5AH7+sLEIfOATqn2HU41iK8ndSxGEghqDRi82w6RvLDE+3MGjLwGwQqIFClueHdGOB2I3LiexQ/mddzApPWx2XjUOdQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719666336; c=relaxed/simple;
	bh=+GloaJVSprqCGpULiUI/O36iec3Yuequ8ZLM2WLDhNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ajl3SaVzP/Y0b3ewtBvezJiEa/056+qftN/+bT7PYwyrR8W0ALq1nc1TR/3dmcGO7Nk3k80vNZjWRlcygH1m8rQ5JYVqSroMPkDuOADMIzHNAiKQqAkrgJ8SwSZLGl/D6PK9bIP1tHZeCYX4/lGR0A3hmw7El7AXWdQCnchCd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fvx13+dx; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f9cd92b146so9533675ad.3
        for <bpf@vger.kernel.org>; Sat, 29 Jun 2024 06:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719666333; x=1720271133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hr41jn7CS+JV7JYEOXmHYOhJrr4EACp9o9fXqaxlvEQ=;
        b=Fvx13+dxBbvCO9u8msJoUvEAv1quxljn6PMdinzrtSpow4qFafKr1PgzG9K3+VrK8V
         hx2F1y4oMyaOD/vGaJ/y+uzBBt2w9adBd1UyDtCnvVS4eJEqkqcgrllFGXXTckZj59Ot
         kAM023AAI+GyaE2Ve701KoAEZKJZHJgPi2IOOEhrByPd9MNwZSGjyMNqO6KvKWk/I+sY
         OoAAQ6d+KhFi7pBONQ/5OZ02OZjQA0/aVA7IoFXWA2OpbJIRVvRswRLiNGdZfzCDmBpg
         69oum7A7SHU62W8wWgt0zOlUGPJd1PUq1SufyMQwnZf+ysbOcgRERDd/Q8165ePRjzgG
         RdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719666333; x=1720271133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hr41jn7CS+JV7JYEOXmHYOhJrr4EACp9o9fXqaxlvEQ=;
        b=Q9WLnpudNYPZtHFAVPSVCdflUxAlwHR9agCQfzZShrN0TTluuTAeA5N1SzETUtQyWB
         ylyAuYjAU+nHVa8wrZ2/LUNPgAPpDAbIHwf2PobP7nSkT+8Z96svqYRGwBA+J/Lm1a4/
         uk0F2KYm7/IBgWfKBXlQoiBYuE4LTtge1Gk1dD9IavhorRhq36updkGjUt85N7+mcV88
         dFG328+hVk5F7bMDorYhszlHjvGSGkjjiuaqEbjTXo9aIjsZbXKRrj5B/yz8/UZJ16T5
         7xXsXsKs2BhsmuMpZJLLlL0wI10JxfLZ4Eiepp5CNRnigk5hjHpPsioW0iRaStzdjqTt
         muhg==
X-Forwarded-Encrypted: i=1; AJvYcCWATvMdpDTc/6t1ngK+95kWvz6nWdY4bMaGRjCeit1AAETBgDckMzhCa+p0rSVbdDeMpI0OCCsl3Oi9Jw7FPmcsObL7
X-Gm-Message-State: AOJu0Yz5nTHL5wIPe/YLZhz6nQMi1nJV37kf3FS9FBy83hrPzUKXd8MQ
	kYE11UxSEwg+UQveNe6x7Y0jKJN2kjN8AjAzcIp9OB59mp7ycgWLAhBMp3sWVw==
X-Google-Smtp-Source: AGHT+IE5aU4sW0gZNOnsBZmQhd5QPQlm2dJswEqAC+AISCYfDs6s10N0soFFT4U1SUdqSjSMRwrfaA==
X-Received: by 2002:a17:903:2349:b0:1f7:23ee:d496 with SMTP id d9443c01a7336-1fadbcb2064mr6324365ad.30.1719666333190;
        Sat, 29 Jun 2024 06:05:33 -0700 (PDT)
Received: from thinkpad ([220.158.156.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598576sm31531345ad.278.2024.06.29.06.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 06:05:32 -0700 (PDT)
Date: Sat, 29 Jun 2024 18:35:25 +0530
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
Subject: Re: [PATCH v6 02/10] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Message-ID: <20240629130525.GC5608@thinkpad>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-2-e0821238f997@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240617-pci2_upstream-v6-2-e0821238f997@nxp.com>

On Mon, Jun 17, 2024 at 04:16:38PM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Correct occasional MSI triggering failures in i.MX8MP PCIe EP by apply 64KB
> hardware alignment requirement.
> 
> MSI triggering fail if the outbound MSI memory region (ep->msi_mem) is not
> aligned to 64KB.
> 
> In dw_pcie_ep_init():
> 
> ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> 				     epc->mem->window.page_size);
> 

So this is an alignment restriction w.r.t iATU. In that case, we should be
passing 'pci_epc_features::align' instead?

- Mani

> Set ep->page_size to match drvdata::epc_features::align since different
> SOCs have different alignment requirements.
> 
> Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
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

