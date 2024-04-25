Return-Path: <bpf+bounces-27802-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941D8B2000
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 13:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF3E1C21B22
	for <lists+bpf@lfdr.de>; Thu, 25 Apr 2024 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8441E84E1E;
	Thu, 25 Apr 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W7En29Jx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C584DE9
	for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714043597; cv=none; b=IFjcn5MV/lxL5NkaOZbz8V+GFx14DuJrhgubVcmrNJCMWDP4qxuP28vJly9ZaoUeTnMJjmU1EjhGus+gfUxNtcknjd3mHJSGTKaXIabk/oYHGC0/qHEbtgxyoNBa9dUFazvYVZ1hJI7C0CLtlKx9Gq7oDIIG94eIqpl9pB0/T2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714043597; c=relaxed/simple;
	bh=9KoaB6+HPDJeQljM4fsDBGLmE1iGfG/0qRUTsarWPHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pioWWx70KPsTrUj6pp+z/CVjjeCWx3efDUeAkty5ZVZo46+zHhZTlms0JiJveSJ+/ZWFNGsjYo39bzEz1kNKW0a94HsQRUEyTBwr0cdrpDlxhVToy1sThXRj65seeYvGm0WQKGOjRGZGlP+ox0CX3ePRedyih/ypEKNWLzgH/Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W7En29Jx; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ebc92079b5so502752a34.0
        for <bpf@vger.kernel.org>; Thu, 25 Apr 2024 04:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714043594; x=1714648394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QsbB44EeMQGDiOFPnRm6gwdDqQTA+5PLqDVHUcWTTkw=;
        b=W7En29Jx6Z9EtHmbC3mwB/CW+MVtkMDuAgIlrfmDF0mNGAbb+vSfK/4Xbr8SXFsHHA
         9e8iyLlNkxni11DD0zn3bWVOJRnEMVm2EUsBJ1EK8qeAc0IWlEf+eY3ZVVsPeTiMOhmS
         nyy5G33nPu6hJmLNpyQdAa6v1Hd+PVK4edVfJ/rNOOC4KKnp8ee82pqEl+6OizWzzX18
         FS7alwGHkS5K7BjyZvWyv1NIUz49e7HKAdDXfTFn7XsGGXhnbIrbT2Mb5e4FafJw6AtM
         G/ozHhOdt73pVZiZpaIC0Fles+JR2k9uEQU3LNGxV9iu1mcfCi5+RKgDuexcADg5MMdR
         zgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714043594; x=1714648394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QsbB44EeMQGDiOFPnRm6gwdDqQTA+5PLqDVHUcWTTkw=;
        b=sin/bkMvuRXOx9TnGCW2ptTzDvrnSwa2OPkdNQ7JyAqxi2Liv9MC+pFMOOvKso08vL
         /rIk9y9I9f4lIBzdkN8mnCBtmwnpdK3rsrPKADdxBR++vNw5NidgGwaB8AFBF0CljCgR
         /co5QAojxyjbL6HB1f58G0KlZy0M+kASIU4s5mlTRHCH2M0dX2xkFiDbHHZarM/wht8J
         ICKlo7Qkio5j6PmOETh9hzrt9b5vAqNpNSj+7wEDgeju6F7lU3Mcym9KMuVeZpxFNtzE
         pxN92ImLkbrWF7wACk9yMPYnlR90jRmEYmC6SDaxsYBX/EBMP84DAA4ePPquz5X+gQqo
         bMjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhJsogCw+jF2XtjH8TzmcXA9IsCQ4fa0Crq6x1zx0xmh/6I16lVwGpqfsMUbJz26bIyFk0J8MDO8qYhg3o4BcLkii6
X-Gm-Message-State: AOJu0Yyfdz70tRyYa5Rxbu77QfIkKC18Vg66P/4W6X6oY17HsteDx2uI
	ckhsg9gn5JTTUx4T9Lr6EmL6vrlCulFaFMEddR24LW8Zq0lMzPLwif7tt9Do1w==
X-Google-Smtp-Source: AGHT+IFHNH/NdwDnqsViBBSK6fogRbB2GKz5I1kvzLPqZs/OJ7Et5KDr4OWgWersvg/dQNYVNr96aA==
X-Received: by 2002:a05:6870:a119:b0:22e:d324:b888 with SMTP id m25-20020a056870a11900b0022ed324b888mr5826865oae.56.1714043593756;
        Thu, 25 Apr 2024 04:13:13 -0700 (PDT)
Received: from thinkpad ([120.60.75.221])
        by smtp.gmail.com with ESMTPSA id fu16-20020a056a00611000b006ecca2f2a32sm12930125pfb.168.2024.04.25.04.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 04:13:13 -0700 (PDT)
Date: Thu, 25 Apr 2024 16:42:59 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
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
Subject: Re: [PATCH v3 00/11] PCI: imx6: Fix\rename\clean up and add lut
 information for imx95
Message-ID: <20240425111259.GB3449@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <Zh6GHcARSmlV/QdS@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zh6GHcARSmlV/QdS@lizhi-Precision-Tower-5810>

On Tue, Apr 16, 2024 at 10:07:25AM -0400, Frank Li wrote:
> On Tue, Apr 02, 2024 at 10:33:36AM -0400, Frank Li wrote:
> > Fixed 8mp EP mode problem.
> > 
> > imx6 actaully for all imx chips (imx6*, imx7*, imx8*, imx9*). To avoid     
> > confuse, rename all imx6_* to imx_*, IMX6_* to IMX_*. pci-imx6.c to        
> > pci-imx.c to avoid confuse.                                                
> 
> 
> Mani and lorenzo:
> 
> Do you have chance to look these patches?
> 

Sorry for the delay. Since this is a non-dwc driver, it got into my low priority
queue. Will take a look this week.

- Mani

> Frank
> 
> > 
> > Using callback to reduce switch case for core reset and refclk.            
> > 
> > Add imx95 iommux and its stream id information.                            
> > 
> > Base on linux-pci/controller/imx
> > 
> > To: Richard Zhu <hongxing.zhu@nxp.com>
> > To: Lucas Stach <l.stach@pengutronix.de>
> > To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > To: Krzysztof Wilczyński <kw@linux.com>
> > To: Rob Herring <robh@kernel.org>
> > To: Bjorn Helgaas <bhelgaas@google.com>
> > To: Shawn Guo <shawnguo@kernel.org>
> > To: Sascha Hauer <s.hauer@pengutronix.de>
> > To: Pengutronix Kernel Team <kernel@pengutronix.de>
> > To: Fabio Estevam <festevam@gmail.com>
> > To: NXP Linux Team <linux-imx@nxp.com>
> > To: Philipp Zabel <p.zabel@pengutronix.de>
> > To: Liam Girdwood <lgirdwood@gmail.com>
> > To: Mark Brown <broonie@kernel.org>
> > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > To: Conor Dooley <conor+dt@kernel.org>
> > Cc: linux-pci@vger.kernel.org
> > Cc: imx@lists.linux.dev
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: bpf@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > Changes in v3:
> > - Add an EP fixed patch
> >   PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
> >   PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
> > - Add 8qxp rc support
> > dt-bing yaml pass binding check
> > make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx6q-pcie.yaml
> >   LINT    Documentation/devicetree/bindings
> >   DTEX    Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dts
> >   CHKDT   Documentation/devicetree/bindings/processed-schema.json
> >   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> >   DTC_CHK Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.example.dtb
> > 
> > - Link to v2: https://lore.kernel.org/r/20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com
> > 
> > Changes in v2:
> > - remove file to 'pcie-imx.c'
> > - keep CONFIG unchange.
> > - Link to v1: https://lore.kernel.org/r/20240227-pci2_upstream-v1-0-b952f8333606@nxp.com
> > 
> > ---
> > Frank Li (7):
> >       PCI: imx6: Rename imx6_* with imx_*
> >       PCI: imx6: Rename pci-imx6.c to pcie-imx.c
> >       MAINTAINERS: pci: imx: update imx6* to imx* since rename driver file
> >       PCI: imx: Simplify switch-case logic by involve set_ref_clk callback
> >       PCI: imx: Simplify switch-case logic by involve core_reset callback
> >       PCI: imx: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
> >       PCI: imx: Consolidate redundant if-checks
> > 
> > Richard Zhu (4):
> >       PCI: imx6: Fix PCIe link down when i.MX8MM and i.MX8MP PCIe is EP mode
> >       PCI: imx6: Fix i.MX8MP PCIe EP can not trigger MSI
> >       dt-bindings: imx6q-pcie: Add i.MX8Q pcie compatible string
> >       PCI: imx6: Add i.MX8Q PCIe support
> > 
> >  .../bindings/pci/fsl,imx6q-pcie-common.yaml        |    5 +
> >  .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    |   18 +
> >  MAINTAINERS                                        |    4 +-
> >  drivers/pci/controller/dwc/Makefile                |    2 +-
> >  .../pci/controller/dwc/{pci-imx6.c => pcie-imx.c}  | 1173 ++++++++++++--------
> >  5 files changed, 727 insertions(+), 475 deletions(-)
> > ---
> > base-commit: 2e45e73eebd43365cb585c49b3a671dcfae6b5b5
> > change-id: 20240227-pci2_upstream-0cdd19a15163
> > 
> > Best regards,
> > ---
> > Frank Li <Frank.Li@nxp.com>
> > 

-- 
மணிவண்ணன் சதாசிவம்

