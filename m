Return-Path: <bpf+bounces-41069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6F992020
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 19:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37A871C20CC0
	for <lists+bpf@lfdr.de>; Sun,  6 Oct 2024 17:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E588318A6BF;
	Sun,  6 Oct 2024 17:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLv8i7Hz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C7189F5A
	for <bpf@vger.kernel.org>; Sun,  6 Oct 2024 17:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728237058; cv=none; b=QCWwEDK0LP7jvzs1wsOVZdE7ZKM/k0JWQKq6V2clNC+5bzd27sQguhH3ZP4ly3UAT1/4Mj/JgsT9htV/IVbQAUsw7DDJ0vbnua+Njj6POJzRgrX3d4NTXbsLhMSK9t9lMDao8kMP4OKLvPks2k1H2aRlsWRGyH3I6UJpzyiL88I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728237058; c=relaxed/simple;
	bh=QX5bVPMoC5X/ATRCLwmjQ5j4TdyRP1gHWz1UGgRYGGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPyiaQDHtvFbbAQIAfEc4xXgfuX6TjMn5Q40Fpr5AbrYlSGj9jrD5vB96/bS5XqupUIIF9qw8lGRe/SfJV8qO4Lsf6Z9z+yLmFNhK36FLJOarxlykx4G+iGd+5ythCRgCiY570UOaSU4zOh8VEexZxwHVMHzPgUYm6KgqaZwoHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aLv8i7Hz; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20b833f9b35so31041185ad.2
        for <bpf@vger.kernel.org>; Sun, 06 Oct 2024 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728237056; x=1728841856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9/jpL3YcDbT5s9GUNC8ARxSJoU3MJ9r3elvS/k1XvaU=;
        b=aLv8i7HzZSa0vR0bO2X5FeLzK14QXcj9tjcYn8OBCjSn8ou6w+LKXFI94noBkpRwHs
         BHPqbAJu8fr4ie+V/1pCDkMSN+ZoZ0LzStIEAO674fuugmCgT2TOzPx9ZSUUziHlMU3g
         tKMIS81LsiTUniydVaa9UV3ucb95eeqDj3L0hn4vchortrwKorwzYGsiVGYFyPlvhlG4
         t7JRBNZNBegrem1xWBYxBUNnhis4r4V+SCf8hU761ZKA+6j7YJ/hdvy0GCih2WObFa+A
         j48ve7fBDfOTaQrbr/ZwLvK8nSqh1/Iiqm13cRklPrFCJygXukPvwgBGkbyc/alfMu9r
         G8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728237056; x=1728841856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/jpL3YcDbT5s9GUNC8ARxSJoU3MJ9r3elvS/k1XvaU=;
        b=wOOGqpPHateGe25kDitvgQB4puL9xB0k5ffG+YnyUu6HLAjAQNsfzXAY2X6QiQKBr0
         Is4JKaphwNqb3bJI63ndk7XoiKtBZhcpan8bEl2lzKVjGJK88HKBAH6hhjeuXLjzMGJm
         mGVJha0k26OtW0HqbssYmC3vWekFtARxYEtTn545zIkgIylbGoYo2bcYSAP6o9PWgkiB
         KyCNelRCSPZPHqIcfarh9Hzj6NvKgoVCPI6JfsDtLcTe/HnJ/r6KmhGkFSnFcdk6ZrYj
         eGS31lz8JPKCQvn5sRqQ+9RkUcVYFEbH4qr8zeWy8S/K0QqCdsCLmfvSEVw5DxPAE8Cf
         dgEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtEzyQf2LjgrPzHb6vPx0a8I2Li7OPKYuItGErKCmD7IeU1aGR+MGMHPK0SnPbEhVJNdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoP404+puo+utNvcOqc+6HRB37OSGzwFBCpybHcWxvPmtms5Hp
	u9rQ8TAhOBRI1j4S0JiC7nZHBbsLac4U87MUpZLaHFCU5yUur/3Jv2FCezSiaA==
X-Google-Smtp-Source: AGHT+IGZMh0K9p8XUknILzUzT5SqwVvVg47E7lfixteAimw7+8QYQTtqQ9t9Zn+e4BhqYnC9cpugcw==
X-Received: by 2002:a17:902:f551:b0:20b:9680:d5c4 with SMTP id d9443c01a7336-20bfde57d03mr139672265ad.4.1728237055829;
        Sun, 06 Oct 2024 10:50:55 -0700 (PDT)
Received: from thinkpad ([220.158.156.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138b104csm27352325ad.45.2024.10.06.10.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 10:50:55 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:20:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, alyssa@rosenzweig.io, bpf@vger.kernel.org,
	broonie@kernel.org, jgg@ziepe.ca, joro@8bytes.org,
	lgirdwood@gmail.com, maz@kernel.org, p.zabel@pengutronix.de,
	robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCH v2 0/2] PCI: add enabe(disable)_device() hook for bridge
Message-ID: <20241006175047.xgy2zyaiebvyxfsi@thinkpad>
References: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
 <20241003051528.qrp2z7kvzgvymgjb@thinkpad>
 <Zv7t9HnRsfTxb2Xs@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zv7t9HnRsfTxb2Xs@lizhi-Precision-Tower-5810>

On Thu, Oct 03, 2024 at 03:18:12PM -0400, Frank Li wrote:
> On Thu, Oct 03, 2024 at 10:45:28AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Sep 30, 2024 at 03:42:20PM -0400, Frank Li wrote:
> > > Some system's IOMMU stream(master) ID bits(such as 6bits) less than
> > > pci_device_id (16bit). It needs add hardware configuration to enable
> > > pci_device_id to stream ID convert.
> > >
> > > https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
> > > This ways use pcie bus notifier (like apple pci controller), when new PCIe
> > > device added, bus notifier will call register specific callback to handle
> > > look up table (LUT) configuration.
> > >
> > > https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
> > > which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
> > > table (qcom use this way). This way is rejected by DT maintainer Rob.
> > >
> >
> > What is the issue in doing this during the probe() stage? It looks like you are
> > working with the static info in the devicetree, which is already available
> > during the controller probe().
> 
> There are problems.
> One: It is not good to manually parser this property in pci host bridge
> drivers.
> 

Why? I see the comment from Rob saying that the host bridge driver should not
parse iommu* properties, but this series is essentially doing the same just in a
different place.

> Two: of_map default is bypass map. For example: if in dts only 2 sid, 0xA
> and 0xB. If try to enable 3rd function RID(103), there are no error report.
> of_map will return RID 103 as stream ID.  DMA will write to wrong
> possition possibly.
> 

Well, you can use iommu-map-mask to allow all devices under a bus to share the
same SID. It will allow you to work with the LUT limitation. But the downside is
that, there would be no isolation between devices under the same bus.

> https://elixir.bootlin.com/linux/v6.12-rc1/source/drivers/of/base.c#L2070
> 
> Three: LUT resource is limited, if DT provide 16 entry, but LUT have only 8
> items, if more device enable, not LUT avaible and can't return error. of
> course, it may fix dts, but It'd better that driver can handle error
> properly when meet wrong dtb file.
> 

Drivers can trust the DT, unless there are evidence of broken DT available in
upstream or got fixed.

If you really want to validate DT, use dt-bindings.

- Mani

> >
> > > Above ways can resolve LUT take or stream id out of usage the problem. If
> > > there are not enough stream id resource, not error return, EP hardware
> > > still issue DMA to do transfer, which may transfer to wrong possition.
> > >
> > > Add enable(disable)_device() hook for bridge can return error when not
> > > enough resource, and PCI device can't enabled.
> > >
> >
> > {enable/disable}_device() doesn't convey the fact you are mapping BDF to SID in
> > the hardware. Maybe something like, {map/unmap}_bdf2sid() or similar would make
> > sense.
> 
> It is called in PCI common code do_pci_enable_device(), hook functin name
> should be similar with caller. {map/unmap}_bdf2sid() is just implementation
> in dwc.
> 
> stream id is only ARM platform concept.
> 
> May other host bridge do difference thing at enable/disable_device().
> 
> So I am still perfer use {enable/disable}_device().
> 
> 
> Frank
> 
> >
> > - Mani
> >
> > > Basicallly this version can match Bjorn's requirement:
> > > 1: simple, because it is rare that there are no LUT resource.
> > > 2: EP driver probe failure when no LUT, but lspci can see such device.
> > >
> > > [    2.164415] nvme nvme0: pci function 0000:01:00.0
> > > [    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
> > > [    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12
> > >
> > > > lspci
> > > 0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
> > > 0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)
> > >
> > > To: Bjorn Helgaas <bhelgaas@google.com>
> > > To: Richard Zhu <hongxing.zhu@nxp.com>
> > > To: Lucas Stach <l.stach@pengutronix.de>
> > > To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > > To: Krzysztof Wilczyński <kw@linux.com>
> > > To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > To: Rob Herring <robh@kernel.org>
> > > To: Shawn Guo <shawnguo@kernel.org>
> > > To: Sascha Hauer <s.hauer@pengutronix.de>
> > > To: Pengutronix Kernel Team <kernel@pengutronix.de>
> > > To: Fabio Estevam <festevam@gmail.com>
> > > Cc: linux-pci@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: imx@lists.linux.dev
> > > Cc: Frank.li@nxp.com \
> > > Cc: alyssa@rosenzweig.io \
> > > Cc: bpf@vger.kernel.org \
> > > Cc: broonie@kernel.org \
> > > Cc: jgg@ziepe.ca \
> > > Cc: joro@8bytes.org \
> > > Cc: l.stach@pengutronix.de \
> > > Cc: lgirdwood@gmail.com \
> > > Cc: maz@kernel.org \
> > > Cc: p.zabel@pengutronix.de \
> > > Cc: robin.murphy@arm.com \
> > > Cc: will@kernel.org \
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > > Changes in v2:
> > > - see each patch
> > > - Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com
> > >
> > > ---
> > > Frank Li (2):
> > >       PCI: Add enable_device() and disable_device() callbacks for bridges
> > >       PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
> > >
> > >  drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
> > >  drivers/pci/pci.c                     |  14 ++++
> > >  include/linux/pci.h                   |   2 +
> > >  3 files changed, 148 insertions(+), 1 deletion(-)
> > > ---
> > > base-commit: 2849622e7b01d5aea1b060ba3955054798c1e0bb
> > > change-id: 20240926-imx95_lut-1c68222e0944
> > >
> > > Best regards,
> > > ---
> > > Frank Li <Frank.Li@nxp.com>
> > >
> > >
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

