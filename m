Return-Path: <bpf+bounces-43603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7BB9B6E4A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 22:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48403B22302
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0BB2141B7;
	Wed, 30 Oct 2024 21:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFfJy+OM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E51D0E0D;
	Wed, 30 Oct 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730322045; cv=none; b=WOEX7XmSV5/1aH8rVajBI6/swHHKNKPAULAoovyPRHtEdkVz5TKI6WLyODe2mqpu5l1FaCpGdakLJw3vY2HGL/Og/ZQszMkXgqozW+vUOsVQgxKG3iCrc9vmHmiunjeP4CytcPTCHVpm1jUiMU3SKWGpzCazG0HN1kh16G/tRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730322045; c=relaxed/simple;
	bh=FHc9+KsxE68/8fdivXFFQsEHjN13LEf/vY7D0utn2FA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Q2V3IvHGf3HUrGgqSwSwVCgXZTfOlMzEnnqBgpQMXzkIvKF52rVzmlrJTtYvxkdBpGxcGwiyfYKVyS6wfcCZcTewP84oxidL3CSV0eDDOBGDoaRDwkWfgxsQmBRQrBKKUyEcJaTjL9GEudGNG15gj/HsFPXILrKcEWa2SLD7Ntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFfJy+OM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F75BC4CECE;
	Wed, 30 Oct 2024 21:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730322045;
	bh=FHc9+KsxE68/8fdivXFFQsEHjN13LEf/vY7D0utn2FA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qFfJy+OMGQrOb+k6n1c1u5MbGgkiFxUSjKubuKO6WLqUbu2qO7nLbKTyGoAL/i7Qt
	 mwUhPYhfw292eCbD1ittEJQpHQiV/zAQplZ442uK0Lyk9y7t2zrytbRz8Gycvezm5B
	 70X0FkVCsGYSF+wF4S1bkpqi2Ta81VNWDcz5DAxFhkHMforHIoKPFhsu3zejZNACgO
	 OQUdcVvBTyEZnMt4nbclw/nUH+iZ8eD4FAJrvh7xaGhjy4SGjPV7OyrEVTivyy7CuA
	 SYncyaOl28ufAKn78+j2q/cAitYQk3BbgswI+OcOKJdC5xKwHPKwj90J/YAhUg0Tvy
	 TqE372wKyueFg==
Date: Wed, 30 Oct 2024 16:00:43 -0500
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
Subject: Re: [PATCH v3 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241030210043.GA1219525@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>

On Thu, Oct 24, 2024 at 06:34:44PM -0400, Frank Li wrote:
> Some PCIe host bridges require special handling when enabling or disabling
> PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> to identify the source of DMA accesses.
> 
> Without this mapping, DMA accesses may target unintended memory, which
> would corrupt memory or read the wrong data.
> 
> Add a host bridge .enable_device() hook the imx6 driver can use to
> configure the Requester ID to StreamID mapping. The hardware table isn't
> big enough to map all possible Requester IDs, so this hook may fail if no
> table space is available. In that case, return failure from
> pci_enable_device().
> 
> It might make more sense to make pci_set_master() decline to enable bus
> mastering and return failure, but it currently doesn't have a way to return
> failure.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Merge along with the imx6 change.

> ---
> Change from v2 to v3
> - use Bjorn suggest's commit message.
> - call disable_device() when error happen.
> 
> Change from v1 to v2
> - move enable(disable)device ops to pci_host_bridge
> ---
>  drivers/pci/pci.c   | 23 ++++++++++++++++++++++-
>  include/linux/pci.h |  2 ++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2a..5e0cb9b6f4d4f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
>  static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  {
>  	int err;
> +	struct pci_host_bridge *host_bridge;
>  	struct pci_dev *bridge;
>  	u16 cmd;
>  	u8 pin;
> @@ -2068,9 +2069,16 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	if (bridge)
>  		pcie_aspm_powersave_config_link(bridge);
>  
> +	host_bridge = pci_find_host_bridge(dev->bus);
> +	if (host_bridge && host_bridge->enable_device) {
> +		err = host_bridge->enable_device(host_bridge, dev);
> +		if (err)
> +			return err;
> +	}
> +
>  	err = pcibios_enable_device(dev, bars);
>  	if (err < 0)
> -		return err;
> +		goto err_enable;
>  	pci_fixup_device(pci_fixup_enable, dev);
>  
>  	if (dev->msi_enabled || dev->msix_enabled)
> @@ -2085,6 +2093,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	}
>  
>  	return 0;
> +
> +err_enable:
> +	if (host_bridge && host_bridge->disable_device)
> +		 host_bridge->disable_device(host_bridge, dev);
> +
> +	return err;
> +
>  }
>  
>  /**
> @@ -2262,12 +2277,18 @@ void pci_disable_enabled_device(struct pci_dev *dev)
>   */
>  void pci_disable_device(struct pci_dev *dev)
>  {
> +	struct pci_host_bridge *host_bridge;
> +
>  	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
>  		      "disabling already-disabled device");
>  
>  	if (atomic_dec_return(&dev->enable_cnt) != 0)
>  		return;
>  
> +	host_bridge = pci_find_host_bridge(dev->bus);
> +	if (host_bridge && host_bridge->disable_device)
> +		host_bridge->disable_device(host_bridge, dev);
> +
>  	do_pci_disable_device(dev);
>  
>  	dev->is_busmaster = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be61..ac15b02e14ddd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -578,6 +578,8 @@ struct pci_host_bridge {
>  	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>  	int (*map_irq)(const struct pci_dev *, u8, u8);
>  	void (*release_fn)(struct pci_host_bridge *);
> +	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>  	void		*release_data;
>  	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>  	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> 
> -- 
> 2.34.1
> 

