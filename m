Return-Path: <bpf+bounces-48717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F65AA0C4FA
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 23:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F02CF7A110D
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2025 22:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3891F9EBA;
	Mon, 13 Jan 2025 22:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxAXjVFF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F71F9A8E;
	Mon, 13 Jan 2025 22:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736809147; cv=none; b=jKAPX04P/G1T8k60IBF5HZCS36OUYGYeS7/Z32OWoz42rPmKMDZKl5v+aa2q3w2ZoWxSiIiPtX6P0lrQ1IAFJ2agC/Busju9ATWuLCZVw1N0gFELndF9AQuXrwNHJRH39Ybk15o7vIcqzOjsCkRLqrmTCbtSE7juYyyf5QzZkCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736809147; c=relaxed/simple;
	bh=n1oeyvHgtjf48GNwmyAUR0RM/+tJ12mmaPeKvDNvC7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QuPxB3DwMj9z/HcaCi6dvRmNbPceBD1J/YblREgV2G5E45I/eGzb+OxLw/HyVSmLWr96H9fjFcCaU+wbVW0OCbfYmOU3911gWo2wgKVzE/2BcUmChHO1WC67rM4U1igY+OQ6YWu4nAo3wqKjIdbm5XteS/b+ql2bX6xBabStZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxAXjVFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9E6C4CED6;
	Mon, 13 Jan 2025 22:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736809146;
	bh=n1oeyvHgtjf48GNwmyAUR0RM/+tJ12mmaPeKvDNvC7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BxAXjVFFtgapVMyWqFQYJtaM4MjM0tbw6wKmn+XgfwlbqQ6jPsB+X/SMPGVa2ko9j
	 CklKrIu3MjvLQNtceyTQpyiRkJv73BirjTlPmeuBc0dUXqe5EyoLn8IuztY8Irka68
	 EiLU31oGONV2tbJERUANVagQ1i/owH2gYY7OJPDFG8PsYBl+BKzxrg2IaA7lYPIcJF
	 e9ITlaxl8E8pdUYxv2Y7knrMKNAllvHOHaYgV+9MqvbSACPYlVNvrmrt1hStGZfFhH
	 7bajJw04rwyhQ6ewVi5wU9Dwo0XR54KcyfNyRzbnkhLew3N25h1oN/0ENEd61VGpMt
	 F0Hi06lcQsHoA==
Date: Mon, 13 Jan 2025 16:59:05 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, robin.murphy@arm.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	will@kernel.org
Subject: Re: [PATCH v8 2/2] PCI: imx6: Add IOMMU and ITS MSI support for
 i.MX95
Message-ID: <20250113225905.GA3325507-robh@kernel.org>
References: <20241210-imx95_lut-v8-0-2e730b2e5fde@nxp.com>
 <20241210-imx95_lut-v8-2-2e730b2e5fde@nxp.com>
 <Z1sTUaoA5yk9RcIc@lpieralisi>
 <Z1sdbH7N1Ly9eXc0@lizhi-Precision-Tower-5810>
 <Z1v/LCHsGOgnasuf@lpieralisi>
 <Z1xs6GkcdTg2c73F@lizhi-Precision-Tower-5810>
 <Z2FDp1zQ7JzxQKJT@lpieralisi>
 <Z2GdvpzT6MOygG4W@lizhi-Precision-Tower-5810>
 <Z256NxZF/+jO2bkR@lpieralisi>
 <Z31eaxD1h3Om3bHS@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z31eaxD1h3Om3bHS@lizhi-Precision-Tower-5810>

On Tue, Jan 07, 2025 at 12:03:39PM -0500, Frank Li wrote:
> On Fri, Dec 27, 2024 at 10:58:15AM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Dec 17, 2024 at 10:50:22AM -0500, Frank Li wrote:
> >
> > [...]
> >
> > > > > > Right. Question: what happens if DT shows that there are SMMU and/or
> > > > > > ITS bindings/mappings but the SMMU driver and ITS driver are either not
> > > > > > enabled or have not probed ?
> > > > >
> > > > > It is little bit complex.
> > > > > iommu:
> > > > > Case 1:
> > > > > 	iommu{
> > > > > 		status = "disabled"
> > > > > 	};
> > > > >
> > > > > 	PCI driver normal probed. if RID is in range of iommu-map, not
> > > > > any functional impact and harmless.
> > > > > 	If RID is out of range of iommu-map, "false alarm" will return.
> > > > > enable PCI EP device failure, but actually it can work without IOMMU.
> > > >
> > > > What does "false alarm" mean in practice ? PCI device enable fails
> > > > but actually it should not ?
> > >
> > > Yes, you are right. It should work without iommu. but return failure for
> > > this case.
> >
> > Rob, Robin, are you OK with this patch DT bindings usage (and the
> > related dependencies described in Frank's reply) ?
> >
> > I am referring to "iommu-map" and "msi-map" usage, everything else
> > is platform specific code.
> >
> > It looks like things can break in multiple ways but I don't want
> > to hold up this series forever.
> 
> Rob and Robin:
> 
> 	Let me simple summary situation. PCIe controler driver need config
> "stream id" for each PCI endpoint devices for IOMMU and MSI.
> 
> 	So add callback for host bridge enable/disable an endpoint devices.
> In callback function, call of_map_id("iommu-map" | "msi-map") to get
> devices's "stream id" from pci's rid.  Then config hardware.
> 
> 	The limiation is, if smmu/its controller's "status" is disabled
> and rid is out of the range of "iommu-map" and "msi-map". Enable device
> will be fail although it should be success because "stream id" will not be
> used at all at this case. The out of range of "iommu-map" and "msi-map" is
> rare.
> 
> 	dwc common pci driver simple check "msi-map", which should be
> another limition and not related this patch.
> 
> 	In many dwc platform (like qcom) need config "stream id" also. But
> that direct parse "iommu-map" and "msi-map" by their drivers, which is not
> prefered by Rob now when I try to upstream at v3
> https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
> 
> 	Rob: can you help check if this is correct direction?

My objection was only parsing the property yourself rather than using 
existing functions. So it looks fine to me now. Though you might 
consider if there is something to be shared with QCom driver.

Rob

