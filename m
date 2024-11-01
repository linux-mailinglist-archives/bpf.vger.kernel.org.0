Return-Path: <bpf+bounces-43747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64359B967C
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 18:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13EC91C214BD
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 17:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2801CB526;
	Fri,  1 Nov 2024 17:23:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B40B1BD9DC;
	Fri,  1 Nov 2024 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730481795; cv=none; b=ClpiAUAClksb4d3OCfEmgdFpKGzWtizbgpw3ehS/V6nLqz+dpspochP+/PmgeeGvo8Ft0UdLwceZtMsb/rxp/8qUq2giYS3+mbhfUtzJxBXvLS3Ygl8a0a9GWl3/FEIIUYe54bOs0tnQvbfgrqfqnGJibD9PopVoBW3PBhgtIUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730481795; c=relaxed/simple;
	bh=NgHVWkttpS/ISI9mum1tEhy2qh08go7Fk4KarMHQT1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhMbVacUF37HTiVaayZHo41DvT9R4jVWOVTh4jupfKSAp1JMviflD9HxdyC1G9EbX2PGsTCdJ0ba3EaKCPG5LH5qY9sLzfZHo8BRoA8VZue9nuCy5uxYmcRglktifNAucf2Ex3GXOfCMiJj4yKXJolpq4pPDX8qfm4b6Zr6eyBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7DD51007;
	Fri,  1 Nov 2024 10:23:41 -0700 (PDT)
Received: from [10.57.90.209] (unknown [10.57.90.209])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 680953F528;
	Fri,  1 Nov 2024 10:23:08 -0700 (PDT)
Message-ID: <391c735a-7daf-4256-8998-952652799dda@arm.com>
Date: Fri, 1 Nov 2024 17:23:06 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
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
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
 <20241024-imx95_lut-v3-2-7509c9bbab86@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241024-imx95_lut-v3-2-7509c9bbab86@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-10-24 11:34 pm, Frank Li wrote:
[...]
> +static int imx_pcie_enable_device(struct pci_host_bridge *bridge, struct pci_dev *pdev)
> +{
> +	u32 sid_i = 0, sid_m = 0, rid = pci_dev_id(pdev);
> +	struct device_node *target;
> +	struct imx_pcie *imx_pcie;
> +	struct device *dev;
> +	int err_i, err_m;
> +
> +	imx_pcie = to_imx_pcie(to_dw_pcie_from_pp(bridge->sysdata));
> +	dev = imx_pcie->pci->dev;
> +
> +	target = NULL;
> +	err_i = of_map_id(dev->of_node, rid, "iommu-map", "iommu-map-mask", &target, &sid_i);

No, you still need to actually check "target" at this point - if it is 
now set, a mapping was found and "sid_i" is valid, otherwise if it still 
NULL, no mapping exists even if "err_i" is 0 (i.e. an "iommu-map" 
property was found, but did not contain any entries matching "rid" as 
input). Note that the target node is returned with a reference held, so 
needs an of_node_put() as well.

Thanks,
Robin.

> +	target = NULL;
> +	err_m = of_map_id(dev->of_node, rid, "msi-map", "msi-map-mask", &target, &sid_m);


