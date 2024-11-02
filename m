Return-Path: <bpf+bounces-43808-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B630B9B9F36
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 12:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E7D28240F
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5E173328;
	Sat,  2 Nov 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HicdufcC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE6156C5E
	for <bpf@vger.kernel.org>; Sat,  2 Nov 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730545824; cv=none; b=gC29X+W3sbY8uoXlkVGuywjvNWd3hEYjh3PmQO4xL+lK981ZS4xdSnfi5HTYk8bWb3N1g5rDlB0pAZv/g9iEn4nsknKG0tW0fIjm9Q8GsAqdvwfCXs5AdlVn1/oD0NFFTZOwDjTYDio2oXwrZkhBlHFb80OBK9/u3CGhYFn3Ny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730545824; c=relaxed/simple;
	bh=QEAiKRBMfn7T9b+p0OODMxOHepiSst1T6MSvaThvpf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEP0M7NdvyWjfb2c5fv6mhFERrIiwL85HVAqNoUg+iyY8hRpHt3fvhqdQDFQjyKyzFPGI9lF0SswhkfLA9dcvY9qWTEi+D/nF0YXXxtFC/DR6yPD/b8NLhp56baJQhytDLz6DN3gk7LLFImDGkQvIbYYwfaEo4mlryuQiAmRvME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HicdufcC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-72061bfec2dso2496842b3a.2
        for <bpf@vger.kernel.org>; Sat, 02 Nov 2024 04:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730545821; x=1731150621; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I4eYqgILgGSnZ5FLX7em889/Olts11sj6lSUSFxZMLE=;
        b=HicdufcCl6+TlyoWCBxRnzf3HuuZD+7d6jcGFY/GvZpM2X5hDCOzsGhH/sGx9ErMtD
         jqXn/dARnZadFUGaRM0/vfS+Z13Qqgluy21nguPCVRFb+3QgRVWgtbGIdE7Dl8h/nNt0
         uZrvrEfG6eVeMP3v2oSrbYj9ZGINfS6YpcTspv/3feOmqvTIzfwg90limkJRXHUN4DVn
         0kkYujS4b1aLChy+awJKJrvvCNy5dWBqBbtYwt0nZMfaEwFlVXufCE4dC9VIzWShXlUN
         HdyBQBPXHWn6140nbP9npWkL88eNbbsgDVpBBf7tCZgdDYzhA1puYU6+jvwL1CAfiOBN
         2blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730545821; x=1731150621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4eYqgILgGSnZ5FLX7em889/Olts11sj6lSUSFxZMLE=;
        b=EcQr/s2ZSmAuCbZo4Q/BeuXMbSDhO52ofwnFhiPSotydA0ee24ZVuEFtxFW3Qk+SLC
         1u/mDr2F79QUdhT0Xw7Yoc6S/3o5OVFj1Avgp2QHJHPz0Uu25X6G4DfeMUiM2AHwruW7
         MmPNK67eW1lgkpGjlgc9rhv4WDlGKdaHRWH/FhL5kw4EssLCWH83OMhqDiNc7kJYU2au
         CkQX0F8GsO4OzIcDDFE9h8RN8tNzK5PdXtYnZzBguqgOZcK7RrBe1ILhNMvoZ/mf8rZn
         RWX1Wk1l6eQwZQtloAfhtNKszpnOZ4TfG6QPiIwpcr+KJfrT+3m4idDeLTrvrqd9SLHx
         a+zw==
X-Forwarded-Encrypted: i=1; AJvYcCXP5CaCtK777R+VF1hpPBvtdGC1KSgE+I9/uuFek/BKvsbUbQApUwpoalLy0TFgTM/aEP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1ZmaZ7U91b/cLFv3f8EIQKN81drWVjAj3XZuPTbIxD/VPboA
	dEH9NbLf8+SzEXH9iNRPFi21QUHZgILoJgmd3WxHkWWOzdOPppbE6t7NMBuh2A==
X-Google-Smtp-Source: AGHT+IGvVFzOTXxhTUFUGXA3i4FKFopxjY5r8HjaLCxA6VY9mqL2l28HzoYyqMuyQIGfn5uqAD5pRQ==
X-Received: by 2002:a05:6a00:a29:b0:71e:c0c:5996 with SMTP id d2e1a72fcca58-720c98ca200mr8339080b3a.7.1730545821219;
        Sat, 02 Nov 2024 04:10:21 -0700 (PDT)
Received: from thinkpad ([220.158.156.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2f17fasm3968608b3a.180.2024.11.02.04.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:10:20 -0700 (PDT)
Date: Sat, 2 Nov 2024 16:40:12 +0530
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
Subject: Re: [PATCH v3 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241102111012.23zwz4et2qkafyca@thinkpad>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
 <20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

How about wrapping the enable/disable part in a helper?

	int pci_host_bridge_enable_device(dev);
	void pci_host_bridge_disable_device(dev);

The definition could be placed in drivers/pci/pci.h as an inline function.

- Mani

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

-- 
மணிவண்ணன் சதாசிவம்

