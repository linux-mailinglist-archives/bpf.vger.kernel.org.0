Return-Path: <bpf+bounces-31026-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A65788D639C
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 15:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB68B2A703
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42395176ACA;
	Fri, 31 May 2024 13:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgOObifV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FB16F282;
	Fri, 31 May 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717163573; cv=none; b=KhIkOwVp09XOBTHgwsBuH2QFGYc8Bz533yxu8g8fb+xb/LsH4cFLHGk8tFVZwvlmt1zn8+jKPe3oZdXdSsIyb3kZ0/FlwIKvXFdocyyAls4NHNhSlT8zMCYu/vI6inE2ilAPLOGIUW/92yL6NGCvEXYd/N1jiLBVho3/h4fwerQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717163573; c=relaxed/simple;
	bh=uKE5W2MwLeT6Liv0HtH7JnSOYllTclfPZHEkgcGCaJg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppj+tDKsS0j8b4cmyrvHRXpce0TwOQwReb/EWAs833FhA/uyCg9cfqkJbuT3geWx8q4Q4m0LNaKDSSs+zaGlEa6VbFiPvN79GUJ1mXhqCWGcsrBe9zmTkg15foAjVd2PasSNo4VKiJOz2J2MVYIOMPwStE+nhv5Kfj+qN7ddzLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PgOObifV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8147C4AF07;
	Fri, 31 May 2024 13:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717163573;
	bh=uKE5W2MwLeT6Liv0HtH7JnSOYllTclfPZHEkgcGCaJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PgOObifVO9KMfMs2CvshtwxFti9gexco3zoFmc77HOD5/t7cvg9BgKeLlQop8ktyH
	 vNceWIvTw46xKCfD2NoWl5WN5sXd/maNsRz5FW+vFAaTGCrP6YiOAXyYZjZFYE5kv3
	 QaU96P7JQh7UxqdJJok8B06yTxwzgfPHt1O6gTABBHFLO4LxG4K0R9R4gT+Kx4n0lg
	 p5JNRoFWyOs35ZWr6koZ2Q6XXRA4v7xcCwZ7fkKn959ufd/SXTdW4tNDtA4oUyeJKP
	 HVHjxFHc35dyNbzs1lhRqhZJVtFaaCfU568G00CdT4BOvCAozkJ+gR4wher6Niwb0P
	 vuMvovnsr+51A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sD2gc-00HBtu-LR;
	Fri, 31 May 2024 14:52:50 +0100
Date: Fri, 31 May 2024 14:52:50 +0100
Message-ID: <86sexyks0d.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,	Richard Zhu <hongxing.zhu@nxp.com>,	Lucas
 Stach <l.stach@pengutronix.de>,	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,	Rob Herring
 <robh@kernel.org>,	Bjorn Helgaas <bhelgaas@google.com>,	Shawn Guo
 <shawnguo@kernel.org>,	Sascha Hauer <s.hauer@pengutronix.de>,	Pengutronix
 Kernel Team <kernel@pengutronix.de>,	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,	Mark Brown <broonie@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,	Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,	Conor Dooley
 <conor+dt@kernel.org>,	linux-pci@vger.kernel.org,	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,	devicetree@vger.kernel.org,	Will Deacon
 <will@kernel.org>,	Robin Murphy <robin.murphy@arm.com>,	Joerg Roedel
 <joro@8bytes.org>,	Jason Gunthorpe <jgg@ziepe.ca>,	Alyssa Rosenzweig
 <alyssa@rosenzweig.io>
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support MSI ITS and IOMMU for i.MX95
In-Reply-To: <20240530230832.GA474962@bhelgaas>
References: <20240528-pci2_upstream-v5-8-750aa7edb8e2@nxp.com>
	<20240530230832.GA474962@bhelgaas>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.2
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: helgaas@kernel.org, Frank.Li@nxp.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de, lgirdwood@gmail.com, broonie@kernel.org, manivannan.sadhasivam@linaro.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, devicetree@vger.kernel.org, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca, alyssa@rosenzweig.io
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 31 May 2024 00:08:32 +0100,
Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> [+cc IOMMU and pcie-apple.c folks for comment]
> 
> On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
> > For the i.MX95, configuration of a LUT is necessary to convert Bus Device
> > Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
> > This involves examining the msi-map and smmu-map to ensure consistent
> > mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
> > registers are configured. In the absence of an msi-map, the built-in MSI
> > controller is utilized as a fallback.
> > 
> > Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
> > upon the appearance of a new PCI device and when the bus is an iMX6 PCI
> > controller. This function configures the correct LUT based on Device Tree
> > Settings (DTS).
> 
> This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> have to do this, I wish it were *more* similar, i.e., copy the
> function names, bitmap tracking, code structure, etc.
> 
> I don't really know how stream IDs work, but I assume they are used on
> most or all arm64 platforms, so I'm a little surprised that of all the
> PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> this notifier.

That's because on sane platforms, PCI's RID and the IOMMU's SID are
the same thing, and there is no need to do anything bizarre. In the
worse case, there is a static transformation that can be applied (IORT
for ACPI, or iommu-map for DT).

Some "creative" systems such as the Apple stuff require some extra
side-band configuration because they don't know what a RID is at all
(the RID isn't conveyed to the IOMMU), nor is there a static (baked in
HW) transformation between RID and SID.

So there is a widget on the side that performs the conversion, and
this widget needs to be programmed. The way it works is that the
driver parses the iommu-map to find the expected and arbitrary) SID
on the IOMMU side for a given RID, and programs the association in the
RID-to-SID mapper. It does so at device probe time in order to make
sure the widget is alive (it seems to be part of the port power
domain).

Yes, this is a terrible hack, and I wish we didn't have to deal with
this sort of crap.

>
> There's this path, which is pretty generic and does at least the
> of_map_id() part of what you're doing in imx_pcie_add_device():
> 
>     __driver_probe_device
>       really_probe
>         pci_dma_configure                       # pci_bus_type.dma_configure
>           of_dma_configure
>             of_dma_configure_id
>               of_iommu_configure
>                 of_pci_iommu_init
>                   of_iommu_configure_dev_id
>                     of_map_id
>                     of_iommu_xlate
>                       ops = iommu_ops_from_fwnode
>                       iommu_fwspec_init
>                       ops->of_xlate(dev, iommu_spec)
> 
> Maybe this needs to be extended somehow with a hook to do the
> device-specific work like updating the LUT?  Just speculating here,
> the IOMMU folks will know how this is expected to work.

That'd be a possibility. But this would be adding extra complexity to
the IOMMU core, and I'm not sure it is worth it given that these
systems are thankfully "rare".

It is also something that is conceptually part of the PCIe root port,
and not really the IOMMU, so I'm a bit reluctant to shove things
there. In any case, it would still require callbacks into the PCIe
host driver, and I have the feeling that we'd be reinventing the bus
notifier wheel, only with pointier angles...

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.

