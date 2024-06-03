Return-Path: <bpf+bounces-31255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 613128D8AD6
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 22:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEDC9283D2B
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 20:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366D613B590;
	Mon,  3 Jun 2024 20:20:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4CA136E17;
	Mon,  3 Jun 2024 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446011; cv=none; b=QEqFy1V7fNhaObjvhVeG3DZo6g8AY7+wKpFAJwyg61AqATDz2py8bBV1+kJJrPdybkX5vvVVyPu5jFhZ4Tis3ANf2JuNsH0aWx/1fYaHCn9PldsFY73YPFSztpRtbS7FLWOWUWDyk8W30RnnJeoh2fCfXJgpes5PO3WNtqQ1Tfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446011; c=relaxed/simple;
	bh=D2aVJoazwYvNwijy23VBiIfNUOdprfvCGR7+xleba5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C77wdQjByaV28B3H8rnxTFFVyeIfZMWI9V5ZelSeg8xF3GABXLf7UNhL5kic8fh0EzEr1fI4GMKMkJUa2NAbeEZYC4k8D/Hu2ka7A1cxnCI5y9RB9OQl4SHIje+jyFDuibPFVGxyW08NUBXWAMa891nJrrOGxGXYflGLRjMGuhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29BE41042;
	Mon,  3 Jun 2024 13:20:33 -0700 (PDT)
Received: from [10.57.71.49] (unknown [10.57.71.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 736993F792;
	Mon,  3 Jun 2024 13:20:04 -0700 (PDT)
Message-ID: <3d24fecf-1fdb-4804-9a51-d6c34a9d65c6@arm.com>
Date: Mon, 3 Jun 2024 21:20:03 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] PCI: imx6: Config look up table(LUT) to support
 MSI ITS and IOMMU for i.MX95
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>,
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
References: <20240603171921.GA685838@bhelgaas>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240603171921.GA685838@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-03 6:19 pm, Bjorn Helgaas wrote:
> On Fri, May 31, 2024 at 03:58:49PM +0100, Robin Murphy wrote:
>> On 2024-05-31 12:08 am, Bjorn Helgaas wrote:
>>> [+cc IOMMU and pcie-apple.c folks for comment]
>>>
>>> On Tue, May 28, 2024 at 03:39:21PM -0400, Frank Li wrote:
>>>> For the i.MX95, configuration of a LUT is necessary to convert Bus Device
>>>> Function (BDF) to stream IDs, which are utilized by both IOMMU and ITS.
>>>> This involves examining the msi-map and smmu-map to ensure consistent
>>>> mapping of PCI BDF to the same stream IDs. Subsequently, LUT-related
>>>> registers are configured. In the absence of an msi-map, the built-in MSI
>>>> controller is utilized as a fallback.
>>>>
>>>> Additionally, register a PCI bus notifier to trigger imx_pcie_add_device()
>>>> upon the appearance of a new PCI device and when the bus is an iMX6 PCI
>>>> controller. This function configures the correct LUT based on Device Tree
>>>> Settings (DTS).
>>>
>>> This scheme is pretty similar to apple_pcie_bus_notifier().  If we
>>> have to do this, I wish it were *more* similar, i.e., copy the
>>> function names, bitmap tracking, code structure, etc.
>>>
>>> I don't really know how stream IDs work, but I assume they are used on
>>> most or all arm64 platforms, so I'm a little surprised that of all the
>>> PCI host drivers used on arm64, only pcie-apple.c and pci-imx6.c need
>>> this notifier.
>>
>> This is one of those things that's mostly at the mercy of the PCIe root
>> complex implementation. Typically the SMMU StreamID and/or GIC ITS DeviceID
>> is derived directly from the PCI RID, sometimes with additional high-order
>> bits hard-wired to disambiguate PCI segments. I believe this RID-translation
>> LUT is a particular feature of the the Synopsys IP - I know there's also one
>> on the NXP Layerscape platforms, but on those it's programmed by the
>> bootloader, which also generates the appropriate "msi-map" and "iommu-map"
>> properties to match. Ideally that's what i.MX should do as well, but hey.
> 
> Maybe this RID-translation is a feature of i.MX, not of Synopsys?  I
> see that the LUT CSR accesses use IMX95_* definitions.

Well, it's not unreasonable to call things "IMX95" in this context if 
they are only relevant to the configuration used by i.MX95, and not to 
the other i.MX SoCs which this driver also supports. However the data 
register fields certainly look suspiciously similar to those used on 
Layerscape[1], although I guess that still doesn't rule out it being 
NXP's own widget either. Anyway, the exact details aren't really 
significant, the point was really just to say don't expect this to 
generalise much beyond what you've seen already, and that there's 
precedent for bootloaders doing this for us.

>> If it's really necessary to do this programming from Linux, then there's
>> still no point in it being dynamic - the mappings cannot ever change, since
>> the rest of the kernel believes that what the DT said at boot time was
>> already a property of the hardware. It would be a lot more logical, and
>> likely simpler, for the driver to just read the relevant map property and
>> program the entire LUT to match, all in one go at controller probe time.
>> Rather like what's already commonly done with the parsing of "dma-ranges" to
>> program address-translation LUTs for inbound windows.
>>
>> Plus that would also give a chance of safely dealing with bad DTs specifying
>> invalid ID mappings (by refusing to probe at all). As it is, returning an
>> error from a child's BUS_NOTIFY_ADD_DEVICE does nothing except prevent any
>> further notifiers from running at that point - the device will still be
>> added, allowed to bind a driver, and able to start sending DMA/MSI traffic
>> without the controller being correctly programmed, which at best won't work
>> and at worst may break the whole system.
> 
> Frank, could the imx LUT be programmed once at boot-time instead of at
> device-add time?  I'm guessing maybe not because apparently there is a
> risk of running out of LUT entries?

The risk still exists just as much either way - if we have a bogus DT 
and/or just more PCI RIDs present than we can handle, we're going to 
have a bad time. There's no advantage to only finding that out once we 
try to add the 33rd device and it's too late to even do anything about it.

In fact if anything, this notifier approach exacerbates that risk the 
most by consuming one LUT entry per PCI RID regardless of whether an 
"iommu-map-mask" is involved. Assuming the IMX95_PE0_LUT_MASK field is 
the same as its Layerscape counterpart, we could support >32 RIDs if the 
map and mask are constructed to squash multiple RIDs onto each StreamID 
(the SMMU driver supports this), and we have the up-front information to 
easily configure hardware masking in the LUT itself. It's not 
necessarily possible to reconstruct such mappings from only seeing 
individual input and output values one-by-one.

Thanks,
Robin.

[1] 
https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pci/pcie_layerscape_fixup.c?ref_type=heads#L83

> It sounds like the consequences of running out of LUT entries are
> catastrophic, e.g., memory corruption from mis-directed DMA?  If
> that's possible, I think we need to figure out how to prevent the
> device from being used, not just dev_warn() about it.
> 
> Bjorn

