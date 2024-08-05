Return-Path: <bpf+bounces-36434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0794857F
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 00:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE14B1F23973
	for <lists+bpf@lfdr.de>; Mon,  5 Aug 2024 22:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4756E16EB63;
	Mon,  5 Aug 2024 22:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9i0F4w4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF91616190C;
	Mon,  5 Aug 2024 22:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722897805; cv=none; b=CJk9KIfxlmhl9TlCj19XjC/nATSREAx/X8EDjbQk6BifqlUR5N6jjmpR8lPFueWnnaTWdBdzyocFqF9pzdiSYW/Qq34ZOM4+6qHkoW8XJHesdB9u8amJ1wTLtZHBCrEyg+EK383W02A0hmKVazq2GV8Aa4PpQqEl9gRxIcnybTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722897805; c=relaxed/simple;
	bh=CTacQSgz2BZQcjS9cT2e3qDUo4p3wVKSVRZKSS/fYwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2upXgILtDnpA53357GoOKmoygbyNBEY7V2ExF4qt+Dzjk3G29Vz+45ZlBtIb8CXYeNs+hs0X+eHps+K2PG5f7EnVepdVJaAxEy665VNcyKPnHKVAp7t8ObyyN9k6DkGCa+hU0wYZeknV6aYaIHN0lgGKdMY5/w2BUqEygcRB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9i0F4w4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efd8807aaso222614e87.3;
        Mon, 05 Aug 2024 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722897802; x=1723502602; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w4DXLAbfFZO5p0YlUY22EJFz1TqByZq2m/ZNg/4mIzc=;
        b=a9i0F4w4tUdO2Ys8VDWNdpmf3TSeLrekRkbeQdbmuD41ado6bvULLfQ7fSQQjrsdTq
         Iq3FU4DHBjEuVttPIIGP3CXd3IHUoHAU7ksVjzj5COJ50PSOYq+7at23w6vW0+8a9bnY
         r++QLiI4e0mZdaTgRJaq1H16OmZhvWEdMJlaraZR8jokSfTbcaQXrMvQqaqYkXahGfYy
         UMZUPzATlp1JxItWdy9Csn+c0k6VxzPcdEQi6nICyWilq017B9NbMa402VVXrx2/ccM0
         dOUon2jJNllaGKGrdE0mat+2TCdBnkzNablXTjRtlWv5XWmSIvMot7THR9uZAbyXxjs4
         +Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722897802; x=1723502602;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w4DXLAbfFZO5p0YlUY22EJFz1TqByZq2m/ZNg/4mIzc=;
        b=wlTAsGyt1zI7iLt0rLr/cCeVxGLPw6T6bveJqfnqSn9FZDxRJbCmb27x+EgN/OgvM8
         wrTBlUktdeElLpNfpICnCHFP28TRshp24gK7zHHTMpmZTdUgwXRzKJPhaLzrhUF4iXYW
         nO7E2jeORMaMsYv9rdJgrc7hP1lxGnM+irgsz9ds1xraDRJn7NNEk1eQulJ+cmgredGY
         Z9KT5GKYI4Vrwn3ZhR/awtP0alLqCBGrEfJuq48UluiDvPjKJhInDuKvt/jWEAEKFD1h
         Lj14rKPJqE7FjJbTCaocZcGg6b1ukJmyZ0UwgXM2rx5CAYThVmXG5DRICDUn6HGikQCP
         V0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkkSstrelD/6kbrE4kQmz5skkmSPfsa8qjdguDTHTdvmwxs2v2DoIY1mbs6O/V1ADVqGk=@vger.kernel.org, AJvYcCXGEN0LHCke1F+42jjnb1Jmx2fVlexhiJCmN9OvypB/sVAy+BaQOPaAjcnpYYP5XmcyA4+hUEiiU8tDbdrM@vger.kernel.org
X-Gm-Message-State: AOJu0YzSrp/81eGyPqvnSyerqnZZE8pLqbjY0NMPvNeRDU2yDyTFrTVU
	jV9y6PNShjn4m2lfvV+fCOIIHQ6O4vuvCnkA9sLlk9JUO0vSsnEA
X-Google-Smtp-Source: AGHT+IEzXK90rUwP3AUOpOnalcgbNpSfYTT5v2vVqd7XAKMRUcOhfxqz0phKjW1LLzZwuE+EwH4wWw==
X-Received: by 2002:a05:6512:3f0d:b0:52f:334:ce05 with SMTP id 2adb3069b0e04-530bb396c7dmr8658889e87.25.1722897801382;
        Mon, 05 Aug 2024 15:43:21 -0700 (PDT)
Received: from mobilestation ([95.79.190.99])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba3548csm1276628e87.211.2024.08.05.15.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 15:43:20 -0700 (PDT)
Date: Tue, 6 Aug 2024 01:43:15 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew@lunn.ch, linux@armlinux.org.uk, horms@kernel.org, 
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <2vvet4ai3uihb2skzyfiym2qh6g26knb7ymjp73eejoiywqnkm@2rxxv6zqvi33>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <oul3ymxlfwlqc3wikwyfix5e2c7hozwfsdwswkdtayxd2zzphz@mld3uobyw5pv>
 <CAMdnO-JKfi0hqaR5zrzzv6j-c6OhH-LTZT5WWBCFDOG_+ZxTeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdnO-JKfi0hqaR5zrzzv6j-c6OhH-LTZT5WWBCFDOG_+ZxTeQ@mail.gmail.com>

On Fri, Aug 02, 2024 at 03:06:05PM -0700, Jitendra Vegiraju wrote:
> On Fri, Aug 2, 2024 at 3:02 AM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hi Jitendra
> >
> > On Thu, Aug 01, 2024 at 08:18:19PM -0700, jitendra.vegiraju@broadcom.com wrote:
> > > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > >
> > > This patchset adds basic PCI ethernet device driver support for Broadcom
> > > BCM8958x Automotive Ethernet switch SoC devices.
> > >
> > > This SoC device has PCIe ethernet MAC attached to an integrated ethernet
> > > switch using XGMII interface. The PCIe ethernet controller is presented to
> > > the Linux host as PCI network device.
> > >
> > > The following block diagram gives an overview of the application.
> > >              +=================================+
> > >              |       Host CPU/Linux            |
> > >              +=================================+
> > >                         || PCIe
> > >                         ||
> > >         +==========================================+
> > >         |           +--------------+               |
> > >         |           | PCIE Endpoint|               |
> > >         |           | Ethernet     |               |
> > >         |           | Controller   |               |
> > >         |           |   DMA        |               |
> > >         |           +--------------+               |
> > >         |           |   MAC        |   BCM8958X    |
> > >         |           +--------------+   SoC         |
> > >         |               || XGMII                   |
> > >         |               ||                         |
> > >         |           +--------------+               |
> > >         |           | Ethernet     |               |
> > >         |           | switch       |               |
> > >         |           +--------------+               |
> > >         |             || || || ||                  |
> > >         +==========================================+
> > >                       || || || || More external interfaces
> > >
> > > The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
> > > driver uses common dwxgmac2 code where applicable.
> >
> > Thanks for submitting the series.
> >
> > I am curious how come Broadcom got to use an IP-core which hasn't
> > been even announced by Synopsys. AFAICS the most modern DW XGMAC
> > IP-core is of v3.xxa version:
> >
> > https://www.synopsys.com/dw/ipdir.php?ds=dwc_ether_xgmac
> >

> I am not sure why the 4.00a IP-code is not announced for general
> availability yet.
> The Synopsis documentation for this IP mentions 3.xx IP as reference
> for this design and lists
> new features for 4.00a.
> 
> > Are you sure that your device isn't equipped with some another DW MAC
> > IP-core, like DW 25G Ethernet MAC? (which BTW is equipped with a new
> > Hyper DMA engine with a capability to have up to 128/256 channels with
> > likely indirect addressing.) Do I miss something?
> >
> Yes, I briefly mentioned the new DMA architecture in the commit log
> for patch 1/3.
> You are correct, the name for the new DMA engine is Hyper DMA. It
> probably started with some 3.xx IP-Core.
> This DW-MAC is capable of 25G, but this SOC is not using 25G support.

Then what you have is likely the DW 25GMAC since just DW XGMAC hasn't
been announced to have neither 25G speed nor the Hyper-DMA with the
virtualization channels capabilities. Meanwhile the former IP-core
does have these features:
https://www.synopsys.com/dw/ipdir.php?ds=dwc_25g_ethernet_mac_ip

Alas I don't have the DW 25GMAC IP-core databook to say for sure, but
that's the only explanation of why you have the 0x40 Synopsys ID and
the IP-core version of v4.00a, and the 25G capability of the MAC.

Seeing Synopsys tends to re-use the CSRs mapping even across the major
IP-core releases it isn't that surprising that the DW XGMAC 3.xx
IP-core was referenced in the doc. (See the driver, DW XLGMAC is
almost fully compatible with the DW XGMAC CSRs mapping.)

Moreover the most DMA-capable device currently supported by the
STMMAC-driver is DW XGMAC/XLGMAC and it can't have more than 16
DMA-channels. That allows to directly map all the channels CSRs to the
system memory. But your case is different. The DW 25GMAC IP-core is
announced to support virtualization up to 128/256 channels, for which
the direct CSRs mapping could require 16-times more memory. That's
likely why the indirect addressing was implemented to access the
settings of all the possible channels. That's also implicitly proofs
that you have the DW 25GMAC IP-core.

-Serge(y)

> 
> > * I'll join the patch set review after the weekend, sometime on the
> > next week.
> >
> > -Serge(y)
> >
> > > Driver functionality specific to this MAC is implemented in dwxgmac4.c.
> > > Management of integrated ethernet switch on this SoC is not handled by
> > > the PCIe interface.
> > > This SoC device has PCIe ethernet MAC directly attached to an integrated
> > > ethernet switch using XGMII interface.
> > >
> > > v2->v3:
> > >    Addressed v2 comments from Andrew, Jakub, Russel and Simon.
> > >    Based on suggestion by Russel and Andrew, added software node to create
> > >    phylink in fixed-link mode.
> > >    Moved dwxgmac4 specific functions to new files dwxgmac4.c and dwxgmac4.h
> > >    in stmmac core module.
> > >    Reorganized the code to use the existing glue logic support for xgmac in
> > >    hwif.c and override ops functions for dwxgmac4 specific functions.
> > >    The patch is split into three parts.
> > >      Patch#1 Adds dma_ops for dwxgmac4 in stmmac core
> > >      Patch#2 Hooks in the hardware interface handling for dwxgmac4
> > >      Patch#3 Adds PCI driver for BCM8958x device
> > >
> > > v1->v2:
> > >    Minor fixes to address coding style issues.
> > >    Sent v2 too soon by mistake, without waiting for review comments.
> > >    Received feedback on this version.
> > >    https://lore.kernel.org/netdev/20240511015924.41457-1-jitendra.vegiraju@broadcom.com/
> > >
> > > v1:
> > >    https://lore.kernel.org/netdev/20240510000331.154486-1-jitendra.vegiraju@broadcom.com/
> > >
> > > Jitendra Vegiraju (3):
> > >   Add basic dwxgmac4 support to stmmac core
> > >   Integrate dwxgmac4 into stmmac hwif handling
> > >   Add PCI driver support for BCM8958x
> > >
> > >  MAINTAINERS                                   |   8 +
> > >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
> > >  drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
> > >  .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 517 ++++++++++++++++++
> > >  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++
> > >  .../net/ethernet/stmicro/stmmac/dwxgmac4.c    | 142 +++++
> > >  .../net/ethernet/stmicro/stmmac/dwxgmac4.h    |  84 +++
> > >  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  26 +-
> > >  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
> > >  10 files changed, 825 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
> > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
> > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h
> > >
> > > --
> > > 2.34.1
> > >
> > >

