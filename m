Return-Path: <bpf+bounces-34009-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4DE9294EE
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 19:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF162828E1
	for <lists+bpf@lfdr.de>; Sat,  6 Jul 2024 17:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A0413C69E;
	Sat,  6 Jul 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XLEGXMu9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EA7347E
	for <bpf@vger.kernel.org>; Sat,  6 Jul 2024 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720287605; cv=none; b=c+lQDGlA/wuzrReJmzcSL9pezuQk3FUuLM02ZocOVXlm5gnHaDU8mqiM9KQOEfqO1xBbxQMPM79RubSfmkXJudXrLHOQxMwYw2TJU9YqdjaknqQ2iEKcAqMLv2M90wHU7n73Bw6wWRVKIdHJ398w+XUhcJUJUfZLA0zjjCVeVpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720287605; c=relaxed/simple;
	bh=K7/5S3Zqv2W8qdrNqOS6SWkrmCLz+5aP6vwqLcb5BLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upn7Wf1u4v7ctHsBNHIrAG6J95mUhxh0pYuEYPWmWa6RuFRjdLIUkWhqcejnuvgw6Q/mUsQFYSkjifo7nQrr7UenfgmNQOfAo8dgm4to6UjLPJHZIuVFqNB/935+Yvm1bzuUtNC1UxY77w7Vq8P2/pInrePdP0IPoODP9csqHSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XLEGXMu9; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb457b53c8so13992645ad.0
        for <bpf@vger.kernel.org>; Sat, 06 Jul 2024 10:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720287603; x=1720892403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+w1HhCtOPF6+jQjVe2f79xd5RcxOFhfFM5UmLnkLxcg=;
        b=XLEGXMu9mAzJRha7s0vx6wQnX8lZhbRxYW2lXioss/ZRJOLUUiY0DDl1jiTBL62W/V
         Ycjb+VxiaU5KISo7qWfzQ5LH2OwrN6HFIZZW65r5DJ7mh7I6ttQyr5bjy2I3UzLw8GC5
         MR4jTt4KrRsof0NmHWQ5pGPvr/utEKgDaH57LTvjD6tArjE71efkDRe4WfrnTT3xq/SU
         voWgmOCb19R08LZa14xyWMNhqveCZFT4hXGVjoYREB/DTmHlvk9okgXIDiqVbzywyFI6
         vrNm6CeK2XRO/9PeAegILo4Ib4PwMJXqSkrbgzESNtz69QfoqhdEcTebRoQsHyZh1n+E
         UVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720287603; x=1720892403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+w1HhCtOPF6+jQjVe2f79xd5RcxOFhfFM5UmLnkLxcg=;
        b=H1fZ2uIZS/cwTxzklLw9ye7Ht9tGvzbuFLOJBwxjzPFVwA0P2CkpqCUCnTQH9r61os
         bdM989pH/bwe3OEcL6yBpr+LRCvvCuJ1o9HJzZOaYcrzXIO+8Oqk/jCwYyhjykSljoN5
         pVg0UDFPAxBx4P8sOAdbDk4nQE5FLsHy+1bMKxXqpxU0lfrtwkGR5kXi5ptBKbcZiIf0
         yebf0Wh+wPkU+HFlpDZtyyKr9GDtM5MZD/rOs5nuEGJa6NGRmvmN4j9BbLgfSd+5cKVV
         STRmz5uPQoR5BNoMVF5Kul7tB+96htMpmudSLn1AXW9Xt/G1032ZVAvR8vFJnXGUFNuk
         rxpw==
X-Forwarded-Encrypted: i=1; AJvYcCWpa0Fk+5c5qkLz6y395DH0VHVzrt5LDTX4IxchbhbaGf5VF/6AF4eW678TMOCXiI7N86uM0h5fnuZ6mEzlN4mgouep
X-Gm-Message-State: AOJu0YyxBZCJReiAvPIcOy9pDD6LPoZMoRhXc4fqkGcrR8qVopz+ZU1Z
	AS+wgm5mXKoA8Jmi7472b3EfijduS8E6Mtpo7zjXcqBoi3vU37GUzqgV4SHf2A==
X-Google-Smtp-Source: AGHT+IFfAmOh1vpybFa6ASP3tIwymsHJN+q/v+qmk1RVhTTsF5OCIrWZZWApJcwuyin0gArdkk3Wrw==
X-Received: by 2002:a17:902:d4cd:b0:1f6:e20f:86b4 with SMTP id d9443c01a7336-1fb33f36fc1mr68382145ad.61.1720287603063;
        Sat, 06 Jul 2024 10:40:03 -0700 (PDT)
Received: from thinkpad ([220.158.156.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb14faa241sm70616845ad.110.2024.07.06.10.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 10:40:02 -0700 (PDT)
Date: Sat, 6 Jul 2024 23:09:54 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v6 02/10] PCI: imx6: Fix i.MX8MP PCIe EP's occasional
 failure to trigger MSI
Message-ID: <20240706173954.GB3980@thinkpad>
References: <20240617-pci2_upstream-v6-0-e0821238f997@nxp.com>
 <20240617-pci2_upstream-v6-2-e0821238f997@nxp.com>
 <20240629130525.GC5608@thinkpad>
 <ZoL2W1Blrhzf19oM@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoL2W1Blrhzf19oM@lizhi-Precision-Tower-5810>

On Mon, Jul 01, 2024 at 02:32:59PM -0400, Frank Li wrote:
> On Sat, Jun 29, 2024 at 06:35:25PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Jun 17, 2024 at 04:16:38PM -0400, Frank Li wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > > 
> > > Correct occasional MSI triggering failures in i.MX8MP PCIe EP by apply 64KB
> > > hardware alignment requirement.
> > > 
> > > MSI triggering fail if the outbound MSI memory region (ep->msi_mem) is not
> > > aligned to 64KB.
> > > 
> > > In dw_pcie_ep_init():
> > > 
> > > ep->msi_mem = pci_epc_mem_alloc_addr(epc, &ep->msi_mem_phys,
> > > 				     epc->mem->window.page_size);
> > > 
> > 
> > So this is an alignment restriction w.r.t iATU. In that case, we should be
> > passing 'pci_epc_features::align' instead?
> 
> pci_epc_features::align already set.
> 
> pci_epc_mem_alloc_addr(
> 	...
> 	align_size = ALIGN(size, mem->window.page_size);
> 	order = pci_epc_mem_get_order(mem, align_size);
> 	...
> }
> 
> but pci_epc_mem_alloc_addr() align to page_size, instead of
> pci_epc_features::align.
> 

'window.page_size' is set to what is passed as 'page_size' argument to
pci_epc_mem_init(). In this case, 'ep->page_size' is passed which corresponds to
size of pages that can be allocated within the memory window.

Default value of 'ep->page_size' is PAGE_SIZE which is most likely 4K. So if
your hardware cannot allocate 4K pages within the memory window, then it
doesn't support splitting this OB region into 4K pages.

But this has nothing to do with alignment AFAIU since epc_features::align is
used for IB memory. This 'page_size' argument was introduced for some TI SoC
that doesn't handle PAGE_SIZE splitting of OB memory window. Reference:

52c9285d4745 ("PCI: endpoint: Add support for configurable page size")

Can you check if your SoC also suffers from the same limitation? If so, then you
should modify the commit message to make it clear.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

