Return-Path: <bpf+bounces-43815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1532F9BA016
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 13:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC0F2823BE
	for <lists+bpf@lfdr.de>; Sat,  2 Nov 2024 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109D18A6C4;
	Sat,  2 Nov 2024 12:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5NeChck"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971BE1DFEF
	for <bpf@vger.kernel.org>; Sat,  2 Nov 2024 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730551750; cv=none; b=GgW2UnsFq4+qWYNhFQBcwW+z1K/Bm/8VtyHipV3R/N9V6GHL77qGWPBiiuv6mJzTh4BDD/TjmKUBsc2ABRGHfHCQx3gludisGF82j7ffNjhLQaB1kcaz17XLAzLA/NKNVgV3EOFKcXtQl8ch1BUfBmOmR56ewVtUF+7zil6vQu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730551750; c=relaxed/simple;
	bh=752tm1zHFUoUxLVT8d/Kyt3IfN/+0+C8drqEuOo4KZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0A/oltlp+0KhWwumnY0ffim65Imex3zqcHVTc6lz6JXJQXoDkststkRlZ+OEfYw8AY7Ow4ECexYATU274yAfXNzsYYxJcEBCvrUNGCE2+hvkG3+abo5NwsOuGJRTGqFdYPIG1h1amtGSdt6rIv8rUwhF6ZNg4zlU1iqC9MQiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y5NeChck; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ce65c8e13so31382145ad.1
        for <bpf@vger.kernel.org>; Sat, 02 Nov 2024 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730551747; x=1731156547; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R62GHxpMLcqbWJtHlNo45biE4A5QHRMLQkq3r0GrtUU=;
        b=Y5NeChckYx1rSoENI7oXBknN4QOEn7ZpXJuA38fFIfnYrTKE9/7g3xl+XXq88o/kBX
         RPJgCR6x7a/u/o766LB3L35zx3ZJPb+d1VEJOQgav/VlLJ4G45bJcBiQTjfsHLzwmUID
         BKQwNo3qNP6K/hsRs9o4gd0HSVWIf3bgEkiGZ9J5aQbtXwxbyFnUSC4FLME+f72ATvMe
         nyosaB4/M57KXyXtL4aQ34PGNvIi3gmnY5Z0TTzBYXDMO/QcbgalTpBV/u2AlOEp1Kkl
         jnG7V2n42qHEoMrTysLjMMEJqlaTMtOxVvW8bZQDmbbq3YERFTt4DQwR/9S1i3Flac//
         Ar5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730551747; x=1731156547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R62GHxpMLcqbWJtHlNo45biE4A5QHRMLQkq3r0GrtUU=;
        b=u9obHhQKdGR3XN6cj7f9oDaAAJyuibqqsCr3f5GU8M7wseq8chQt8yDeQBan5AFsJC
         aPou2toFf3T2iJpPoge3U4a934OQs2rqk49k5DlpyWcJQhW6GuEeeHEOK2U2qGc25fYt
         CMlvFJlQIbktflXG8qRf5QxxjjnR/28K3/4uHcutoRCWO+cFtRjaaJ++CGsDeKxj5jpx
         gF8+npzoPnP1j3gbA63zxWse7zisz7ko3JiwsCR5WmI8bl6mdtA1Y4GdOVd5ZWADTVGl
         RyxyviYy2Z6l9Y4vE1qrGDVk8YfJl+tMr8YJMPjHogb2Tj5anh+OCGQzELwU/cPnNXNv
         hsUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx9vYMLOVX2V7l4GE5j1RA+OWayOmsY/E5SbuFRXynvzATGmXy2bfzYzKZeUXinPHntbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBGTHa4tM75gb13WZOdnqWE1s+AwQ4eqIsGWe+gU7N4GTEHbYH
	QaV6+/cVk0ZTJTojTJlkgIO63jTag/zXD3B383saJnfMPOeIiwwBt76P01WOqQ==
X-Google-Smtp-Source: AGHT+IHJ+NvyJqJsm2sd6i7P9lBOMCDJCLw5mFMqxRjQKzc9Q0COhGnO26H8RAbp736bWj9OzK8dVA==
X-Received: by 2002:a17:902:d487:b0:20c:5c6b:2eac with SMTP id d9443c01a7336-21103c8c51fmr134891675ad.49.1730551746899;
        Sat, 02 Nov 2024 05:49:06 -0700 (PDT)
Received: from thinkpad ([220.158.156.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a5ff1sm33417305ad.123.2024.11.02.05.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 05:49:06 -0700 (PDT)
Date: Sat, 2 Nov 2024 18:18:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
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
	lgirdwood@gmail.com, p.zabel@pengutronix.de, robin.murphy@arm.com,
	will@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add enable_device() and disable_device()
 callbacks for bridges
Message-ID: <20241102124857.dx4hxdjy2jxjmara@thinkpad>
References: <20241024-imx95_lut-v3-0-7509c9bbab86@nxp.com>
 <20241024-imx95_lut-v3-1-7509c9bbab86@nxp.com>
 <20241102111012.23zwz4et2qkafyca@thinkpad>
 <86jzdl27my.wl-maz@kernel.org>
 <20241102115435.s7oycrh2pjkfhpsu@thinkpad>
 <86ikt52585.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <86ikt52585.wl-maz@kernel.org>

On Sat, Nov 02, 2024 at 12:24:42PM +0000, Marc Zyngier wrote:
> On Sat, 02 Nov 2024 11:54:35 +0000,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > 
> > On Sat, Nov 02, 2024 at 11:32:37AM +0000, Marc Zyngier wrote:
> > > On Sat, 02 Nov 2024 11:10:12 +0000,
> > > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > > 
> > > > On Thu, Oct 24, 2024 at 06:34:44PM -0400, Frank Li wrote:
> > > > > Some PCIe host bridges require special handling when enabling or disabling
> > > > > PCIe Endpoints. For example, the i.MX95 platform has a lookup table to map
> > > > > Requester IDs to StreamIDs, which are used by the SMMU and MSI controller
> > > > > to identify the source of DMA accesses.
> > > > > 
> > > > > Without this mapping, DMA accesses may target unintended memory, which
> > > > > would corrupt memory or read the wrong data.
> > > > > 
> > > > > Add a host bridge .enable_device() hook the imx6 driver can use to
> > > > > configure the Requester ID to StreamID mapping. The hardware table isn't
> > > > > big enough to map all possible Requester IDs, so this hook may fail if no
> > > > > table space is available. In that case, return failure from
> > > > > pci_enable_device().
> > > > > 
> > > > > It might make more sense to make pci_set_master() decline to enable bus
> > > > > mastering and return failure, but it currently doesn't have a way to return
> > > > > failure.
> > > > > 
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > > Change from v2 to v3
> > > > > - use Bjorn suggest's commit message.
> > > > > - call disable_device() when error happen.
> > > > > 
> > > > > Change from v1 to v2
> > > > > - move enable(disable)device ops to pci_host_bridge
> > > > > ---
> > > > >  drivers/pci/pci.c   | 23 ++++++++++++++++++++++-
> > > > >  include/linux/pci.h |  2 ++
> > > > >  2 files changed, 24 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index 7d85c04fbba2a..5e0cb9b6f4d4f 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -2056,6 +2056,7 @@ int __weak pcibios_enable_device(struct pci_dev *dev, int bars)
> > > > >  static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > > > >  {
> > > > >  	int err;
> > > > > +	struct pci_host_bridge *host_bridge;
> > > > >  	struct pci_dev *bridge;
> > > > >  	u16 cmd;
> > > > >  	u8 pin;
> > > > > @@ -2068,9 +2069,16 @@ static int do_pci_enable_device(struct pci_dev *dev, int bars)
> > > > >  	if (bridge)
> > > > >  		pcie_aspm_powersave_config_link(bridge);
> > > > >  
> > > > > +	host_bridge = pci_find_host_bridge(dev->bus);
> > > > > +	if (host_bridge && host_bridge->enable_device) {
> > > > > +		err = host_bridge->enable_device(host_bridge, dev);
> > > > > +		if (err)
> > > > > +			return err;
> > > > > +	}
> > > > 
> > > > How about wrapping the enable/disable part in a helper?
> > > > 
> > > > 	int pci_host_bridge_enable_device(dev);
> > > > 	void pci_host_bridge_disable_device(dev);
> > > > 
> > > > The definition could be placed in drivers/pci/pci.h as an inline
> > > > function.
> > > 
> > > What does it bring? I would see the point if there was another user.
> > > But this is very much core infrastructure which doesn't lend itself to
> > > duplication.
> > > 
> > > Unless you have something in mind?
> > > 
> > 
> > IMO, it adds a nice encapsulation to help readers understand what this piece of
> > code is all about and also keeps the callers short. Plus the disable helper is
> > reused in both error and pci_disable_device() (if that matters).
> 
> Having an *internal* helper for disable definitely has its use.
> 
> But moving these helpers outside of pci.c opens the door to all sort
> of abuse by making it look like an internal API drivers can use, which
> is absolutely isn't.
> 

Hmm, agree with this part, thanks!

Frank, please keep the helpers in pci.c.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

