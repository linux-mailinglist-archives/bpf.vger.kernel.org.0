Return-Path: <bpf+bounces-43810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5969B9F4B
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 12:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088CC1C20FB9
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFEE176240;
	Sat,  2 Nov 2024 11:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqCrLfF9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E282595;
	Sat,  2 Nov 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547161; cv=none; b=cwAWEw+0Y1Vgkdg88WKAa2+laSHIYtTP0WsBH5a9C/LCma9HxM60cKD4S7yr6d4ZopAKvcfmyNvwwiBQFvczQWstvqUPinNgOFr1o/K0RW0JhPl/SwB/pjpUoxgX2/7vvQ8IZqXQcFj3zZbWRARUApXKoOSZLE+F6WK6/G7XbTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547161; c=relaxed/simple;
	bh=adVR7Ni9kXC6EEF8ItL/jXSktedT4tVJaYlcGnkDeaM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GJT7k4tWN4XqiFxGJ01E6Ri97eVTOJCwzkUS7EW+xPboKCcq5hsPUF7MbRSytHMR/xIej6xZegE4riNODRh3MUZiMwQzGph0vYZ4HhaOCZIv3tWjXWKZ/0Hq4BW55rfabTbAA6wiAqJ4QT1sBLenecfTSA1ADp/9nyIJwjHvDsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqCrLfF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EBCC4CEC3;
	Sat,  2 Nov 2024 11:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730547160;
	bh=adVR7Ni9kXC6EEF8ItL/jXSktedT4tVJaYlcGnkDeaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cqCrLfF9gEmxZ1p3fZ0IGE7QevkZZOkKem6Jw0mC07QCVQ4LyZaU9UpT0TUWNDA92
	 fFpkt3RoQukrYcWgRl9+VvC7keIWNwBm2Qs1WqWgNog7TsZ1TSsOSYJhy6NugbUK3+
	 55ozivmYc4mu4SvKCLI7ihomXbnP55HHW80QzR6h8i+iPWMyeJ7TMoszyizZqpoLBU
	 GpwliptA/a45ceFjmCN3auZiBYVgoI/MHWzOgc3RmpRJxtX0DCzogra4hZF0AJf7WZ
	 ntveKIsKVHAitApHP6GycS0JnuksRH+t5/YG1P/bZhThDQZ+vqQLqj7pyRWgyVyiDT
	 SdcVS4K+xRl3A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1t7CMv-0095nJ-UL;
	Sat, 02 Nov 2024 11:32:38 +0000
Date: Sat, 02 Nov 2024 11:32:37 +0000
Message-ID: <86jzdl27my.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>,	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,	Krzysztof =?UTF-8?B?V2lsY3p5?=
 =?UTF-8?B?xYRza2k=?= <kw@linux.com>,	Rob Herring <robh@kernel.org>,	Shawn
 Guo <shawnguo@kernel.org>,	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,	Fabio Estevam
 <festevam@gmail.com>,	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,	alyssa@rosenzweig.io,	bpf@vger.kernel.org,
	broonie@kernel.org,	jgg@ziepe.ca,	joro@8bytes.org,	lgirdwood@gmail.com,
	p.zabel@pengutronix.de,	robin.murphy@arm.com,	will@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add enable_device() and disable_device() callbacks for bridges
In-Reply-To: <20241102111012.23zwz4et2qkafyca@thinkpad>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
	<20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>
	<20241102111012.23zwz4et2qkafyca@thinkpad>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: manivannan.sadhasivam@linaro.org, Frank.Li@nxp.com, bhelgaas@google.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org, lgirdwood@gmail.com, p.zabel@pengutronix.de, robin.murphy@arm.com, will@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Sat, 02 Nov 2024 11:10:12 +0000,
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> 
> On Thu, Oct 24, 2024 at 06:34:44PM -0400, Frank Li wrote:
> > Some PCIe host bridges require special handling when enabling or disabling
> > PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> > Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> > to identify the source of DMA accesses.
> > 
> > Without this mapping, DMA accesses may target unintended memory, which
> > would corrupt memory or read the wrong data.
> > 
> > Add a host bridge .enable_device() hook the imx6 driver can use to
> > configure the Requester ID to StreamID mapping. The hardware table isn't
> > big enough to map all possible Requester IDs, so this hook may fail if no
> > table space is available. In that case, return failure from
> > pci_enable_device().
> > 
> > It might make more sense to make pci_set_master() decline to enable bus
> > mastering and return failure, but it currently doesn't have a way to return
> > failure.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v2 to v3
> > - use Bjorn suggest's commit message.
> > - call disable_device() when error happen.
> > 
> > Change from v1 to v2
> > - move enable(disable)device ops to pci_host_bridge
> > ---
> >  drivers/pci/pci.c   | 23 ++++++++++++++++++++++-
> >  include/linux/pci.h |  2 ++
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 7d85c04fbba2a..5e0cb9b6f4d4f 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
> >  static int do_pci_enable_device(struct pci_dev *dev, int bars)
> >  {
> >  	int err;
> > +	struct pci_host_bridge *host_bridge;
> >  	struct pci_dev *bridge;
> >  	u16 cmd;
> >  	u8 pin;
> > @@ -2068,9 +2069,16 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
> >  	if (bridge)
> >  		pcie_aspm_powersave_config_link(bridge);
> >  
> > +	host_bridge = pci_find_host_bridge(dev->bus);
> > +	if (host_bridge && host_bridge->enable_device) {
> > +		err = host_bridge->enable_device(host_bridge, dev);
> > +		if (err)
> > +			return err;
> > +	}
> 
> How about wrapping the enable/disable part in a helper?
> 
> 	int pci_host_bridge_enable_device(dev);
> 	void pci_host_bridge_disable_device(dev);
> 
> The definition could be placed in drivers/pci/pci.h as an inline
> function.

What does it bring? I would see the point if there was another user.
But this is very much core infrastructure which doesn't lend itself to
duplication.

Unless you have something in mind?

	M.

-- 
Without deviation from the norm, progress is not possible.

