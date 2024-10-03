Return-Path: <bpf+bounces-40822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DA298ECFE
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 12:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC961C2149B
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B391F14D2A6;
	Thu,  3 Oct 2024 10:31:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16B78289;
	Thu,  3 Oct 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727951471; cv=none; b=g2RUo0ypY9VcW8d/dRHOYzkId5POQEIeqO8tT2zy2P3+Y1B1ko1YvYCwRkPEaws8v5gGuFL/F88f7YsobvdEkuC1hYMWgyTza+Qu8QT1aYYBJ02swUpThpBqEj4G8VJlO4luqtpbbTi6TTL5sByoAeiDM+0NC3dhXysJ6oG127c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727951471; c=relaxed/simple;
	bh=syiU2xxnWa7hq7jVo9NrqEqzZ+mdHNHoKDzLtmQtYI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvCP7V9PUvHY7BFzYlt5Rq6MbR1N6yktAHifg0BJuoVn9rkbfz2LrfG+TqtmCH/GA/aDQnSja/ZVWiQYs0sG6Fy1Dk5cz+Z6828TPZ19OzQtpALo3MQqJJrGHJ5tqB/4CoJhnHzFzf82FiJ4fcDykCKm6rFteeTvVrQx6pD/iSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5006339;
	Thu,  3 Oct 2024 03:31:38 -0700 (PDT)
Received: from [10.57.85.26] (unknown [10.57.85.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C2393F64C;
	Thu,  3 Oct 2024 03:31:03 -0700 (PDT)
Message-ID: <a96794e0-76f6-4091-b4d4-d88d084ed2c2@arm.com>
Date: Thu, 3 Oct 2024 11:30:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
To: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 alyssa@rosenzweig.io, bpf@vger.kernel.org, broonie@kernel.org, jgg@ziepe.ca,
 joro@8bytes.org, lgirdwood@gmail.com, maz@kernel.org,
 p.zabel@pengutronix.de, will@kernel.org
References: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
 <20240930-imx95_lut-v2-1-3b6467ba539a@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240930-imx95_lut-v2-1-3b6467ba539a@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-30 8:42 pm, Frank Li wrote:
> Some PCIe bridges require special handling when enabling or disabling
> PCIe devices. For example, on the i.MX95 platform, a lookup table must be
> configured to inform the hardware how to convert pci_device_id to stream
> (bus master) ID, which is used by the IOMMU and MSI controller to identify
> bus master device.
> 
> Enablement will be failure when there is not enough lookup table resource.
> Avoid DMA write to wrong position. That is the reason why pci_fixup_enable
> can't work since not return value for fixup function.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - move enable(disable)device ops to pci_host_bridge
> ---
>   drivers/pci/pci.c   | 14 ++++++++++++++
>   include/linux/pci.h |  2 ++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7d85c04fbba2a..fcdeb12622568 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
>   static int do_pci_enable_device(struct pci_dev *dev, int bars)
>   {
>   	int err;
> +	struct pci_host_bridge *host_bridge;
>   	struct pci_dev *bridge;
>   	u16 cmd;
>   	u8 pin;
> @@ -2068,6 +2069,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>   	if (bridge)
>   		pcie_aspm_powersave_config_link(bridge);
>   
> +	host_bridge = pci_find_host_bridge(dev->bus);
> +	if (host_bridge && host_bridge->enable_device) {
> +		err = host_bridge->enable_device(host_bridge, dev);

If the intent is that this call may allocate host bridge resources, what 
about the existing error returns below? Should those now have a cleanup 
path to avoid a potential resource leak from here?

Thanks,
Robin.

> +		if (err)
> +			return err;
> +	}
> +
>   	err = pcibios_enable_device(dev, bars);
>   	if (err < 0)
>   		return err;
> @@ -2262,12 +2270,18 @@ void pci_disable_enabled_device(struct pci_dev *dev)
>    */
>   void pci_disable_device(struct pci_dev *dev)
>   {
> +	struct pci_host_bridge *host_bridge;
> +
>   	dev_WARN_ONCE(&dev->dev, atomic_read(&dev->enable_cnt) <= 0,
>   		      "disabling already-disabled device");
>   
>   	if (atomic_dec_return(&dev->enable_cnt) != 0)
>   		return;
>   
> +	host_bridge = pci_find_host_bridge(dev->bus);
> +	if (host_bridge && host_bridge->disable_device)
> +		host_bridge->disable_device(host_bridge, dev);
> +
>   	do_pci_disable_device(dev);
>   
>   	dev->is_busmaster = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 573b4c4c2be61..ac15b02e14ddd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -578,6 +578,8 @@ struct pci_host_bridge {
>   	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
>   	int (*map_irq)(const struct pci_dev *, u8, u8);
>   	void (*release_fn)(struct pci_host_bridge *);
> +	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
> +	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
>   	void		*release_data;
>   	unsigned int	ignore_reset_delay:1;	/* For entire hierarchy */
>   	unsigned int	no_ext_tags:1;		/* No Extended Tags */
> 


