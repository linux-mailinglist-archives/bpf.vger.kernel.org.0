Return-Path: <bpf+bounces-40798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2116198E63D
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 00:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A956B219D7
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2024 22:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBB319AD5C;
	Wed,  2 Oct 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFN24kRI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE9DDD2;
	Wed,  2 Oct 2024 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909213; cv=none; b=VGBR6z7aH+F1GuzFLnseEL7YT8K44BIsgUJ4Ylzvil5dwrMKqTsCZY3OIyprpW5PlN658oMwTSG6JukbHO4Uqez3iweKGBK3a285IeCv4JGwLR/HPtm+TtJDp6MUY2+RVCdSesP1p70QZ39BFHvGSVN/lF4EtahsqQfvyqW44fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909213; c=relaxed/simple;
	bh=BngeXkbt/WG24essn3TrThJOgh2ow30+BK+6VpFJwtc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Myzbkeqfi1t713ZKrSXexubEyEe0rWH8g3XnwUteaezZBX9Inlc0PZzRcyjKZm4XLn7YX1MDzPmTVld8l+h0q2zU2lpb55EkMNTSvmg+zZVfbcIR0ldkz3K4TGRMhAWlpUrh3FdE/6KzMt8+sfhIKPoQJgQdd5Mp++0hVXgezK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFN24kRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDC0C4CEC2;
	Wed,  2 Oct 2024 22:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727909213;
	bh=BngeXkbt/WG24essn3TrThJOgh2ow30+BK+6VpFJwtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CFN24kRIIeakf8Wns6NqUqGPIlTmK9/Zwt8AQzjd9i/5x34uq+/o5tZ59X/geQ7v8
	 N0AxvLTAkyabrrA2Js1f/tUzOzyRZUVBphfxtg6kb0qwqFjgjDVZyvrBn/e/WaiTNV
	 4u8F847iD2eCo9cI8RkX7/c+1bMHU8jWYdj/dACPk9p5E+WyRhb59LyBOXBxeTxoPa
	 U0W44HxOt4iGpMXe//2b3wVfimkn8dpRItdZTToukyF68eVl5EWqrkBp8X4/MpLj5p
	 cumqEYj2EtT8OrzzGrTzlKPS9rcFLkMY5vzWnAf5gIat/KQ99Cj44pqFI0VjPDsKfQ
	 uucQNd4BslFpA==
Date: Wed, 2 Oct 2024 17:46:51 -0500
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
Subject: Re: [PATCH v2 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241002224651.GA282373@bhelgaas>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930-imx95_lut-v2-1-3b6467ba539a@nxp.com>

On Mon, Sep 30, 2024 at 03:42:21PM -0400, Frank Li wrote:
> Some PCIe bridges require special handling when enabling or disabling
> PCIe devices. For example, on the i.MX95 platform, a lookup table must be
> configured to inform the hardware how to convert pci_device_id to stream
> (bus master) ID, which is used by the IOMMU and MSI controller to identify
> bus master device.

It's important that this say "PCI *host bridge*" specifically to avoid
confusion with PCI-to-PCI bridges.

On the PCIe side, it would be better to use "Requester ID" than
"pci_device_id" because I think that's the actual key for the lookup
table.

Possible commit log text, fix my misconceptions as needed:

  Some PCIe host bridges require special handling when enabling or
  disabling PCIe Endpoints. For example, the i.MX95 platform has a
  lookup table to map Requester IDs to StreamIDs, which are used by
  the SMMU and MSI controller to identify the source of DMA accesses.

  Without this mapping, DMA accesses may target unintended memory,
  which would corrupt memory or read the wrong data.

  Add a host bridge .enable_device() hook the imx6 driver can use to
  configure the Requester ID to StreamID mapping.  The hardware table
  isn't big enough to map all possible Requester IDs, so this hook may
  fail if no table space is available.  In that case, return failure
  from pci_enable_device().

  It might make more sense to make pci_set_master() decline to enable
  bus mastering and return failure, but it currently doesn't have a
  way to return failure.

> Enablement will be failure when there is not enough lookup table resource.
> Avoid DMA write to wrong position. That is the reason why pci_fixup_enable
> can't work since not return value for fixup function.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - move enable(disable)device ops to pci_host_bridge
> ---
>  drivers/pci/pci.c   | 14 ++++++++++++++
>  include/linux/pci.h |  2 ++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2a..fcdeb12622568 100644
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
> @@ -2068,6 +2069,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
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
>  		return err;
> @@ -2262,12 +2270,18 @@ void pci_disable_enabled_device(struct pci_dev *dev)
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

