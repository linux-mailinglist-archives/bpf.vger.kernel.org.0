Return-Path: <bpf+bounces-44778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8999C79B8
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 18:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66037284460
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9656201032;
	Wed, 13 Nov 2024 17:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MH9uZI/t"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72CA13049E
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 17:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731518125; cv=none; b=sCo5P5B2VMntuk0vB8Pz2aNJxHJUtOeYLJDlfaYUeO4H3GjLRr2wJ54DLi9K4nLmeY0cUr4RLE+OYf15NAm/wJDLA/LocP4tsrObv/SGhc9l2Dscdo+OXEB7zUts2sohkpzDlfZ9FY1QUe/LnYO5Yt2A3x6LhDMDUea/hY/3BWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731518125; c=relaxed/simple;
	bh=WERDNI0LGwVY3RbweBxSs7T16pb32PWza3c0CSA8vS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwGwJfIyUo/IWsbIBOl4w8i97N5SQvgjKAqDZu1D5kTe2vETtWAPwvilgJoZrkrP9cmWVTfe8GCbIM1xuUm15RQhoCA01Z+zpAKxZkaIgrahsdTRg9VvXXY3pX12zJYSsNCrjreYJrmlJLOVZerwokPhbaCRXdBmotjII1TY1iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MH9uZI/t; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c805a0753so71685945ad.0
        for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 09:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731518123; x=1732122923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TmnyoVBogdAY8x4kmLAsg1HFi2F5M2VCC5E3t36HwWM=;
        b=MH9uZI/tahjLauBLF+d2t8/dNLtsBKbR3fDLESbPtmjWNvqJYKb8m7kdNFTQ7lG4zB
         XJb9N8ZnDtUltO9N8UOx/pTsFIB/kI8MOnOZ/vktrnu4yGgVUn+R4SMf4b6yZm6c9q2/
         AK4qxGbHoQ/lx2hM6jF0TTighBs9CJYnb4i5CjLc3/tg3SJp+r2QqvnYQ3X/6yb0wE0G
         lLeKD2VQzc6gbwcWRmOoPBtaZwudQy4HZVkVd7eJ4ShbZFIs9HbiFlbhJwrF11s1j6nP
         /1TugoTFnjTQX4rf5Mpci7hrcI18ykOjmgLxVUQVaHyC3wHhPZwUMrnuFT/Rpr0kc/3c
         NnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731518123; x=1732122923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmnyoVBogdAY8x4kmLAsg1HFi2F5M2VCC5E3t36HwWM=;
        b=Hd+RS+Kbkn84T5mGnRdwtUl96zEl8RjsVwMetmj9GDGm2qnZlfsCIbLgPje3Fp8YCR
         CF/0EcHvi+mh6ZAh+7etAoQlbR90KlMplPuoNIQuO3Rqjkr3qMvJ7+iWBPWZZLIDP5p9
         E/joYUCRdU37o4+JGBiTanAhxmektD/Z0E+yR3O9FFbi0JU+wkN7eSe1szQjuugx8lBB
         k5UQfUaIxkbgpJwRmgR1CXkTZMaWygOJ62b+jZQpRM1ZC08Fuk9CEcEsJV2aQH8BnuYq
         +y1shXd3oc6hWIHWmWdRf8I7cOyRcGzzwtMKI1oZ/ESXasDLDTLW0rmeZAHf6Ox3PLis
         wT+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbGxiKwlrQHSq54MfUim/EMVJTl5S8FGqGz2UopV5EyswLnrn3xlaRVfm8CU959RVksyo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Q18C6KG9BEQ+biOjg9Td49tN+j8er/RbDO61rHEpCP2rrnyX
	WXjEyxB8ItftmBsKTERxUyucc3jpUK9qppGeXYfbmK845JhrWV4rbLrqsZQO6A==
X-Google-Smtp-Source: AGHT+IHzuQZcyCrKEu2zhDf6vGWpfQpSsivZTFz9ERjtI5rVRvb2nqfyzm+YGxn9leeh1yDA8kfSug==
X-Received: by 2002:a17:903:41ca:b0:20b:9f8c:e9de with SMTP id d9443c01a7336-21183cff8a2mr257327955ad.13.1731518123010;
        Wed, 13 Nov 2024 09:15:23 -0800 (PST)
Received: from thinkpad ([117.213.102.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc8f25sm112819815ad.22.2024.11.13.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:15:22 -0800 (PST)
Date: Wed, 13 Nov 2024 22:45:11 +0530
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
Subject: Re: [PATCH v5 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241113171511.6d4gh3x27nej55qw@thinkpad>
References: <20241104-imx95_lut-v5-0-feb972f3f13b@nxp.com>
 <20241104-imx95_lut-v5-1-feb972f3f13b@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241104-imx95_lut-v5-1-feb972f3f13b@nxp.com>

On Mon, Nov 04, 2024 at 02:22:59PM -0500, Frank Li wrote:
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

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Change from v4 to v5
> - Add two static help functions
> int pci_host_bridge_enable_device(dev);
> void pci_host_bridge_disable_device(dev);
> - remove tags because big change
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Tested-by: Marc Zyngier <maz@kernel.org>
> 
> Change from v3 to v4
> - Add Bjorn's ack tag
> 
> Change from v2 to v3
> - use Bjorn suggest's commit message.
> - call disable_device() when error happen.
> 
> Change from v1 to v2
> - move enable(disable)device ops to pci_host_bridge
> ---
>  drivers/pci/pci.c   | 36 +++++++++++++++++++++++++++++++++++-
>  include/linux/pci.h |  2 ++
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 67013df89a694..4735bc665ab3b 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2055,6 +2055,28 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
>  	return pci_enable_resources(dev, bars);
>  }
>  
> +static int pci_host_bridge_enable_device(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
> +	int err;
> +
> +	if (host_bridge && host_bridge->enable_device) {
> +		err = host_bridge->enable_device(host_bridge, dev);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +static void pci_host_bridge_disable_device(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
> +
> +	if (host_bridge && host_bridge->disable_device)
> +		host_bridge->disable_device(host_bridge, dev);
> +}
> +
>  static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  {
>  	int err;
> @@ -2070,9 +2092,13 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	if (bridge)
>  		pcie_aspm_powersave_config_link(bridge);
>  
> +	err = pci_host_bridge_enable_device(dev);
> +	if (err)
> +		return err;
> +
>  	err = pcibios_enable_device(dev, bars);
>  	if (err < 0)
> -		return err;
> +		goto err_enable;
>  	pci_fixup_device(pci_fixup_enable, dev);
>  
>  	if (dev->msi_enabled || dev->msix_enabled)
> @@ -2087,6 +2113,12 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
>  	}
>  
>  	return 0;
> +
> +err_enable:
> +	pci_host_bridge_disable_device(dev);
> +
> +	return err;
> +
>  }
>  
>  /**
> @@ -2270,6 +2302,8 @@ void pci_disable_device(struct pci_dev *dev)
>  	if (atomic_dec_return(&dev->enable_cnt) != 0)
>  		return;
>  
> +	pci_host_bridge_disable_device(dev);
> +
>  	do_pci_disable_device(dev);
>  
>  	dev->is_busmaster = 0;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a17edc6c28fda..5f75c30f263be 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -596,6 +596,8 @@ struct pci_host_bridge {
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

-- 
மணிவண்ணன் சதாசிவம்

