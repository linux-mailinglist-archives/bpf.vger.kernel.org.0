Return-Path: <bpf+bounces-40454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 705D8988D18
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 02:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8C421C2123C
	for <lists+bpf@lfdr.de>; Sat, 28 Sep 2024 00:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D4D5695;
	Sat, 28 Sep 2024 00:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCIJibGN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA523AB;
	Sat, 28 Sep 2024 00:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727482074; cv=none; b=XmcE4m3LtbjpoikpOAfFjH1xvRuucu60T5Pob2OaaK3mEu1OGdWNV8AGz7dBUpV6tMIy+875VO65e0yyJR7ATsrhGG2klI1K/8/hY4u1f7phmdvP2TT2blxvyZVw9GUNswM6qpgEUXLArbvm48KP5CbxY1xcryVMW67qWLpBVWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727482074; c=relaxed/simple;
	bh=8kgpRAnyuvL767vg5X6HGRKePibuTGJqlt0etUFXi18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=igdUOs+ejTfhHWNzh/zykzDI7qiqudyFuSCCI7TImiOR2duGG7jAgT1jyHh0sV8TTtQ+SOts0BfWCL5AFfJW/90vA/FGv0bjzVlSTVnEfA8AwUuEpVV4nqlbeNgphvRwg47q28nFAo3o/R7uav7pkRHtL+Mm2FxINBjyTMoXUJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCIJibGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86AC5C4CEC4;
	Sat, 28 Sep 2024 00:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727482073;
	bh=8kgpRAnyuvL767vg5X6HGRKePibuTGJqlt0etUFXi18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eCIJibGNojkstz62stalir/kMXNicMt/VFQmt//hAZ9q/WEyHQApOEtUiL305EaMQ
	 YjRqk7dhAecURr5JLz1UHFdXMFLv9q6cV5Kglo5OTTgP2/v9ECzq2q5RQVuihHVPMC
	 pfn+zjNLsGU2uHbKfC6xHCmOSCGd+rd8rN8yCxNNnFTbtteD4GrbouZwrP2aoPlNJG
	 h59y7fBIcIP8jQa0TxjxMiAZUyCnZ7UP9J4Y2u2Dn7uhtcydTVT44v0i/lHeem+a+S
	 Nq0gEbhLCIcqrrvddYKQ6UVlxaRE5sLxh4p2XBaSC2/XH286Zg2mnkV04IjFQvai2q
	 HIegvrWIDXvOw==
Date: Fri, 27 Sep 2024 19:07:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20240928000752.GA99095@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926-imx95_lut-v1-1-d0c62087dbab@nxp.com>

On Thu, Sep 26, 2024 at 06:07:47PM -0400, Frank Li wrote:
> Some PCIe bridges require special handling when enabling or disabling
> PCIe devices. For example, on the i.MX95 platform, a lookup table must be
> configured to inform the hardware how to convert pci_device_id to stream
> (bus master) ID, which is used by the IOMMU and MSI controller to identify
> bus master device.

I don't think you're talking about PCI-to-PCI bridges (including PCIe
Root Ports and Switch Ports).  Those are all standardized and don't do
anything with Requester IDs or Stream IDs.

A PCI host bridge, e.g., a PCIe Root Complex, might have to deal with
Stream IDs, and I think that's what you're enabling here.  If so, I
think the hooks should be in struct pci_host_bridge instead of
pci_ops.

> Enablement will be failure when there is not enough lookup table resource.
> Avoid DMA write to wrong position. That is the reason why pci_fixup_enable
> can't work since not return value for fixup function.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/pci.c   | 19 +++++++++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2a..e0f83ed53d964 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2057,6 +2057,7 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  {
>  	int err;
>  	struct pci_dev *bridge;
> +	struct pci_bus *bus;
>  	u16 cmd;
>  	u8 pin;
>  
> @@ -2068,6 +2069,15 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	if (bridge)
>  		pcie_aspm_powersave_config_link(bridge);
>  
> +	bus = dev->bus;
> +	while (bus) {
> +		if (bus->ops->enable_device)
> +			err = bus->ops->enable_device(bus, dev);
> +		if (err)
> +			return err;
> +		bus = bus->parent;
> +	}
> +
>  	err = pcibios_enable_device(dev, bars);
>  	if (err < 0)
>  		return err;
> @@ -2262,12 +2272,21 @@ void pci_disable_enabled_device(struct pci_dev *dev)
>   */
>  void pci_disable_device(struct pci_dev *dev)
>  {
> +	struct pci_bus *bus;
> +
>  	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
>  		      "disabling already-disabled device");
>  
>  	if (atomic_dec_return(&dev->enable_cnt) != 0)
>  		return;
>  
> +	bus = dev->bus;
> +	while (bus) {
> +		if (bus->ops->disable_device)
> +			bus->ops->disable_device(bus, dev);
> +		bus = bus->parent;
> +	}
> +
>  	do_pci_disable_device(dev);
>  
>  	dev->is_busmaster = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be61..42c25b8efd538 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -803,6 +803,8 @@ static inline int pcibios_err_to_errno(int err)
>  struct pci_ops {
>  	int (*add_bus)(struct pci_bus *bus);
>  	void (*remove_bus)(struct pci_bus *bus);
> +	int (*enable_device)(struct pci_bus *bus, struct pci_dev *dev);
> +	void (*disable_device)(struct pci_bus *bus, struct pci_dev *dev);
>  	void __iomem *(*map_bus)(struct pci_bus *bus, unsigned int devfn, int where);
>  	int (*read)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 *val);
>  	int (*write)(struct pci_bus *bus, unsigned int devfn, int where, int size, u32 val);
> 
> -- 
> 2.34.1
> 

