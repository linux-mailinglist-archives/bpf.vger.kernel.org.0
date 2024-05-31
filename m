Return-Path: <bpf+bounces-31037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589398D650D
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 16:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531E81C2508D
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 14:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0621074068;
	Fri, 31 May 2024 14:59:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF466F2EB;
	Fri, 31 May 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167539; cv=none; b=Ls45+0T4OchJM9U3l5UUcYpV6WHdg0KOEizmpnNXO3BACEpBhy5bB3kICNpQoluajGQFyrlimx+uGFo6sersfmc9W4gRsKPUfTlWgrUnidxBIgujkmGcUiSpKuwlbwDyQ2Sd9aLu6pJN5FEWL9fl0+Hg5INJFizpHw//zM3nbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167539; c=relaxed/simple;
	bh=G/b7RyaoGodqjPBF0FsWhLwSns9WaG79sqo1CfgHyUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5k1zqrQxl4O/40wlCUqyxMu44QfW7iwCZVqjbOYtHwUjAlZP8C7/zxzyRBKSAJrcetMSoRlw7efCKByHXpqiyGqXb6B7WoNQ0P55Fs1hXGrHUK59tYs6TywGighL0QXehqs2lW6OJNWn70UFyQsRrSkeoI86kl9XhVUOYAEUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6911F1424;
	Fri, 31 May 2024 07:59:21 -0700 (PDT)
Received: from [10.57.69.119] (unknown [10.57.69.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D57253F641;
	Fri, 31 May 2024 07:58:51 -0700 (PDT)
Message-ID: <974f1d23-aba8-432e-85b5-0e4b1c2005e7@arm.com>
Date: Fri, 31 May 2024 15:58:49 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
To: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Marc Zyngier <maz@kernel.org>
References: <20240530230832.GA474962@bhelgaas>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240530230832.GA474962@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
> [+cc IOMMU and pcie-apple.c folks for comment]
> 
> On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
>> For the i.MX95, configuration of a LUT is necessary to convert Bus Device
>> Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
>> This involves examining the msi-map and smmu-map to ensure consistent
>> mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
>> registers are configured. In the absence of an msi-map, the built-in MSI
>> controller is utilized as a fallback.
>>
>> Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
>> upon the appearance of a new PCI device and when the bus is an iMX6 PCI
>> controller. This function configures the correct LUT based on Device Tree
>> Settings (DTS).
> 
> This scheme is pretty similar to apple_pcie_bus_notifier().  If we
> have to do this, I wish it were *more* similar, i.e., copy the
> function names, bitmap tracking, code structure, etc.
> 
> I don't really know how stream IDs work, but I assume they are used on
> most or all arm64 platforms, so I'm a little surprised that of all the
> PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
> this notifier.

This is one of those things that's mostly at the mercy of the PCIe root 
complex implementation. Typically the SMMU StreamID and/or GIC ITS 
DeviceID is derived directly from the PCI RID, sometimes with additional 
high-order bits hard-wired to disambiguate PCI segments. I believe this 
RID-translation LUT is a particular feature of the the Synopsys IP - I 
know there's also one on the NXP Layerscape platforms, but on those it's 
programmed by the bootloader, which also generates the appropriate 
"msi-map" and "iommu-map" properties to match. Ideally that's what i.MX 
should do as well, but hey.

> There's this path, which is pretty generic and does at least the
> of_map_id() part of what you're doing in imx_pcie_add_device():
> 
>      __driver_probe_device
>        really_probe
>          pci_dma_configure                       # pci_bus_type.dma_configure
>            of_dma_configure
>              of_dma_configure_id
>                of_iommu_configure
>                  of_pci_iommu_init
>                    of_iommu_configure_dev_id
>                      of_map_id
>                      of_iommu_xlate
>                        ops = iommu_ops_from_fwnode
>                        iommu_fwspec_init
>                        ops->of_xlate(dev, iommu_spec)
> 
> Maybe this needs to be extended somehow with a hook to do the
> device-specific work like updating the LUT?  Just speculating here,
> the IOMMU folks will know how this is expected to work.

Note that that particular code path has fundamental issues and much of 
it needs to go away (I'm working on it, but it's a rich ~8-year-old pile 
of technical debt...). IOMMU configuration needs to be happening at 
device_add() time via the IOMMU layer's own bus notifier.

If it's really necessary to do this programming from Linux, then there's 
still no point in it being dynamic - the mappings cannot ever change, 
since the rest of the kernel believes that what the DT said at boot time 
was already a property of the hardware. It would be a lot more logical, 
and likely simpler, for the driver to just read the relevant map 
property and program the entire LUT to match, all in one go at 
controller probe time. Rather like what's already commonly done with the 
parsing of "dma-ranges" to program address-translation LUTs for inbound 
windows.

Plus that would also give a chance of safely dealing with bad DTs 
specifying invalid ID mappings (by refusing to probe at all). As it is, 
returning an error from a child's BUS_NOTIFY_ADD_DEVICE does nothing 
except prevent any further notifiers from running at that point - the 
device will still be added, allowed to bind a driver, and able to start 
sending DMA/MSI traffic without the controller being correctly 
programmed, which at best won't work and at worst may break the whole 
system.

Thanks,
Robin.

