Return-Path: <bpf+bounces-40812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F9D98E94C
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 07:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E122834B6
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 05:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D364049638;
	Thu,  3 Oct 2024 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P71OwC4h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F43AC2B
	for <bpf@vger.kernel.org>; Thu,  3 Oct 2024 05:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727932538; cv=none; b=nfr3ssQ1zPR57UfHFD2DsBgof3Se7mjAUYbifa8jBmtbmV9nsb7QGi+iSG4uEijaF3PocvZ9G3LziYWczQdp9QL1lsppW6ENG+pB9VQhHIbfLqKj025Vkohc0bxDrh7qS3+/TECuUzlfKGsTz6tAvUs+1RUzHHAmkzlzfoBc1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727932538; c=relaxed/simple;
	bh=OHiaQB6DuBhomWeQAXyZs+hA1EcEH547SHdB4xPJezs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiWm3mW3U5IZLphyH8T/uz748Te92u48aMLGD2TX4KmkmbX3SxgGjvcmhJBtEJfs3CYYTX8Lf1CcegHONJgVzhnDzPhelzCoNpoLq1e/FVnwz/sngPf2qjTYCcvcglm0pXqppAnvgmB6jcwMHX03cPDD+ebJuyK34OaM9n6qQG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P71OwC4h; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso399983a91.3
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2024 22:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727932536; x=1728537336; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zDZEd+knXkuxXPgXs2kDCTgo3adMpe62SuSlOEQu0K8=;
        b=P71OwC4h+hwSGsTSrJ4V2TQ0bta34eAe5JEPK7wlyYCrNImKkj63ENFie6/MuBwolL
         xJEE/G9/Y3qWw5khkoI9+R9vUCkgUIIcEAM5QHYzIak7H+V56nwN7kwywIHl0TEf0cml
         Pe8mRT3hwiefIkiL3o5DPLWAdc2LBhhli4M2/mAZZQz2R6iLsY7tEacjtZrdPdML4OKv
         dDMo5D/RJz9AI6ZsjuWWZJOLkKSresQa9+00U252JbmjJNiDE0zBtCXSxw7PzcPr1Z2c
         Fy/TD6Dwlmg5eewGosdW62lX012n/RRaAtaKz5XvtfunS1ynbPpOuGc6Ll6s+bkzjF7o
         VFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727932536; x=1728537336;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDZEd+knXkuxXPgXs2kDCTgo3adMpe62SuSlOEQu0K8=;
        b=qB5XwXioxz++g2ALrL0I1ezxTZYAxg0PX2AlwQgjwg3tyV99JX63axLfcM0GS1muHh
         A0r8UfudZMURt3ahFObmTs8Pjcj5aTkL9I5nBS6/4H+LavkuydiJeoxroJ4WJru+vwyj
         mWnQ53L/BhV226zcpGnmSZlxZ0Ajf+cZxXQ4poStjfjn5pz8tMof/OImkdhlTuxIbEN7
         H9gdbdov/9meA2ZLWbpvA6KjC0QFcZA6I1/HstGvjjrd3HdrqWVpcs9NVLQy/bECFPdM
         QNBVNlsrkIyWbhjSCnIUzWgsIyEoX6TTVmCfVGvan/yKXBaM8+TXbf/06qGSy9HhpI0T
         B+xw==
X-Forwarded-Encrypted: i=1; AJvYcCUIvf9YODxVHBx4hNlTyK+Vz5iISRhoAqS+zpGUgwjmkq2xemEBxWcCyT5NjqdQ3iC66+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3HssCw780J7fOlzDGfX90bxVYV9AN3vQjFNHnJ2JFHXlznPmn
	8VTvQCa6FywDInuKIklkwU908kaeZBGpKunQFB77pkoMUgBuqvz+Nm0mlCuveQ==
X-Google-Smtp-Source: AGHT+IGFzmJSdO8rd6CXNlY0TTZNLylyV1+W0nXK1rdwwYtV/CN8tyL4ABdeXZlNSjBhb2YD1GkaTA==
X-Received: by 2002:a17:90a:a00f:b0:2e0:77aa:fecf with SMTP id 98e67ed59e1d1-2e1849cbe38mr5987618a91.41.1727932535975;
        Wed, 02 Oct 2024 22:15:35 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f773a21sm2669570a91.20.2024.10.02.22.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:15:35 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:45:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
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
Message-ID: <20241003051528.qrp2z7kvzgvymgjb@thinkpad>
References: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930-imx95_lut-v2-0-3b6467ba539a@nxp.com>

On Mon, Sep 30, 2024 at 03:42:20PM -0400, Frank Li wrote:
> Some system's IOMMU stream(master) ID bits(such as 6bits) less than
> pci_device_id (16bit). It needs add hardware configuration to enable
> pci_device_id to stream ID convert.
> 
> https://lore.kernel.org/imx/20240622173849.GA1432357@bhelgaas/
> This ways use pcie bus notifier (like apple pci controller), when new PCIe
> device added, bus notifier will call register specific callback to handle
> look up table (LUT) configuration.
> 
> https://lore.kernel.org/imx/20240429150842.GC1709920-robh@kernel.org/
> which parse dt's 'msi-map' and 'iommu-map' property to static config LUT
> table (qcom use this way). This way is rejected by DT maintainer Rob.
> 

What is the issue in doing this during the probe() stage? It looks like you are
working with the static info in the devicetree, which is already available
during the controller probe().

> Above ways can resolve LUT take or stream id out of usage the problem. If
> there are not enough stream id resource, not error return, EP hardware
> still issue DMA to do transfer, which may transfer to wrong possition.
> 
> Add enable(disable)_device() hook for bridge can return error when not
> enough resource, and PCI device can't enabled.
> 

{enable/disable}_device() doesn't convey the fact you are mapping BDF to SID in
the hardware. Maybe something like, {map/unmap}_bdf2sid() or similar would make
sense.

- Mani

> Basicallly this version can match Bjorn's requirement:
> 1: simple, because it is rare that there are no LUT resource.
> 2: EP driver probe failure when no LUT, but lspci can see such device.
> 
> [    2.164415] nvme nvme0: pci function 0000:01:00.0
> [    2.169142] pci 0000:00:00.0: Error enabling bridge (-1), continuing
> [    2.175654] nvme 0000:01:00.0: probe with driver nvme failed with error -12
> 
> > lspci
> 0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
> 0000:01:00.0 Non-Volatile memory controller: Micron Technology Inc 2100AI NVMe SSD [Nitro] (rev 03)
> 
> To: Bjorn Helgaas <bhelgaas@google.com>
> To: Richard Zhu <hongxing.zhu@nxp.com>
> To: Lucas Stach <l.stach@pengutronix.de>
> To: Lorenzo Pieralisi <lpieralisi@kernel.org>
> To: Krzysztof Wilczyński <kw@linux.com>
> To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> To: Rob Herring <robh@kernel.org>
> To: Shawn Guo <shawnguo@kernel.org>
> To: Sascha Hauer <s.hauer@pengutronix.de>
> To: Pengutronix Kernel Team <kernel@pengutronix.de>
> To: Fabio Estevam <festevam@gmail.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: imx@lists.linux.dev
> Cc: Frank.li@nxp.com \
> Cc: alyssa@rosenzweig.io \
> Cc: bpf@vger.kernel.org \
> Cc: broonie@kernel.org \
> Cc: jgg@ziepe.ca \
> Cc: joro@8bytes.org \
> Cc: l.stach@pengutronix.de \
> Cc: lgirdwood@gmail.com \
> Cc: maz@kernel.org \
> Cc: p.zabel@pengutronix.de \
> Cc: robin.murphy@arm.com \
> Cc: will@kernel.org \
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Changes in v2:
> - see each patch
> - Link to v1: https://lore.kernel.org/r/20240926-imx95_lut-v1-0-d0c62087dbab@nxp.com
> 
> ---
> Frank Li (2):
>       PCI: Add enable_device() and disable_device() callbacks for bridges
>       PCI: imx6: Add IOMMU and ITS MSI support for i.MX95
> 
>  drivers/pci/controller/dwc/pci-imx6.c | 133 +++++++++++++++++++++++++++++++++-
>  drivers/pci/pci.c                     |  14 ++++
>  include/linux/pci.h                   |   2 +
>  3 files changed, 148 insertions(+), 1 deletion(-)
> ---
> base-commit: 2849622e7b01d5aea1b060ba3955054798c1e0bb
> change-id: 20240926-imx95_lut-1c68222e0944
> 
> Best regards,
> ---
> Frank Li <Frank.Li@nxp.com>
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

