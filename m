Return-Path: <bpf+bounces-39433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 739BB973687
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 13:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F821C24889
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 11:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60BE418FC74;
	Tue, 10 Sep 2024 11:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boeysJr6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178AA18C003;
	Tue, 10 Sep 2024 11:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725969359; cv=none; b=ugngp9S+E+LDvzOzbVo5A4AmXHASAKrXhqda4HlHYzYEJ6xSuZwn7DI9lgqUPdp7YZrTVM9PR9A7fsfY0eJfTQt0fFG5D18/2jyn78FtB869ao4tRn5CGyyskiqDLOazz3mnVznv4zst3ypW2wXNXIIe6ismLrkVxccITKDXWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725969359; c=relaxed/simple;
	bh=2zfT1IDor+33cVbNh16LYHatwPrz2WSCTCVdO4KX4F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QrnwmWVlj8ExLO4TB2oK0y9EMwvCtQAqOx/CoUO0GaXHnwcd+czG7MuuC+EBdZyfFIdBB0gASYoaXOq2Fo/bXZTIf4ipPJmJbcVMQRcMS5Rec3d4Pifrdkx8BFLSpF3nXd0epzjJTw+wjrlfi8ZnATvKo4MwkvPunKJi1kbTOA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boeysJr6; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so33255411fa.0;
        Tue, 10 Sep 2024 04:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725969356; x=1726574156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8hfri4dXyAKITBGdpULlHOZ/Wp/1oYlpuTWiNxs1aXQ=;
        b=boeysJr6C0RlCrg3p1l6fIdwFbWNSMkGAbKlmdVh6YTJaCSb/c2wpXarYcEXLTZLgy
         gJurjro+PPDiUoFAw7BOZllcuRNMCYp2JbJsr3+3+dni94M3mVMVj3Bf62W0TQ0y3hOO
         Rsk2KlLpzarYaanZG8f/Veehua9svg+An2nB7ZYoEclFDXChz3SFr84CSlbsXVDSxIu6
         0vlPsMkLsjXUpK4E/jurYh3ncDyT700M2anK5HjE/RQp7+PAL6Nb7gmmcxtap3+UHhLu
         sdMpwPXjSzmu5+A9zXi6/q0H2n0pvRwu7i/VQI+GWwXXavctyy1krMuODOIAHEYqHSks
         fjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725969356; x=1726574156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hfri4dXyAKITBGdpULlHOZ/Wp/1oYlpuTWiNxs1aXQ=;
        b=pOUoCNF+oaEwGYRF16OT9dBNWZsWn2Ettdh/mjWgJUoGrNqPq/KXy1Oew/1J7zwZCV
         49PcT6Ksk/zhQf1AloIzg/8GuAdq+fVOwJk31cd8fZt11Pgj81z8RzWCTDNeem1nQuEH
         mIJxB0Vr9Clf7YhDoi0S4zC2KaV7AafoZM2lyFT6clztZ4pW0dDCV5pLlx8GLgsilC5m
         OJlzCDxjpnlZRlj4r88Z5mkVLlP2nEfaLqudHgbAaGPQ+gSh5jRgaCmTJWgXga2h95ga
         7SZqvKM2rNDyVsvAdvVjolOyLhwL5pAu+zWFQMrWSqs/OCPrKAqPRCJopY+57piVPFBw
         YeDA==
X-Forwarded-Encrypted: i=1; AJvYcCU2BIm9AAF5Xo5/8fLIrHwNCatcz+yLS5UhGgox0XHSuIEu0zuzEV3EV4JlJcCeSaVgatwwg4Fv9RbOkvIx@vger.kernel.org, AJvYcCUgzKSQ9PTfA/o73OFzak5211fyUZSCttI4icr8opwRQYRfSgf7gqEXcI0Jp9qJTYoC7eM=@vger.kernel.org, AJvYcCXsRkvc87qGYTGDdS9DWIVT92Ws3udKybNUYsdv+uNzrloTxfPYqCPOdOlIsv4ex6ZV6Hoe3vr9@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWCCJXFDb6yj1tpvzgCBkltgezPfYwPuOd7mksVffJkK8V7zI
	mohip2Pvt8PtNiEDfLrzYPoYy78bliV6BC0RElUh8GX2AQped97u
X-Google-Smtp-Source: AGHT+IESmABC/JGjw8+J2iYKtAy7FAr+qsgBYKgilqZukCBJGhpkkaPjbLmHJ2QPX4ajpLltD2eClg==
X-Received: by 2002:a2e:b88a:0:b0:2f3:fd7f:d048 with SMTP id 38308e7fff4ca-2f75b94234amr69763251fa.39.1725969355087;
        Tue, 10 Sep 2024 04:55:55 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75bfe830csm11861191fa.2.2024.09.10.04.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 04:55:54 -0700 (PDT)
Date: Tue, 10 Sep 2024 14:55:51 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, mcoquelin.stm32@gmail.com, 
	bcm-kernel-feedback-list@broadcom.com, richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, 
	ahalaney@redhat.com, xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, 
	Jianheng.Zhang@synopsys.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew@lunn.ch, linux@armlinux.org.uk, horms@kernel.org, 
	florian.fainelli@broadcom.com, jitendra.vegiraju@broadcom.com, netdev@vger.kernel.org
Subject: Re: [net-next v5 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <auqco7g64aej7mauw6etpqhauynowktlbise6qo6k7rczz4oao@46miqzgcp7ky>
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
 <56c4fccd-787f-4936-9f4b-a1b9ebae6d03@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c4fccd-787f-4936-9f4b-a1b9ebae6d03@redhat.com>

Hi Paolo

On Tue, Sep 10, 2024 at 01:29:34PM +0200, Paolo Abeni wrote:
> On 9/4/24 07:48, jitendra.vegiraju@broadcom.com wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > 
> > This patchset adds basic PCI ethernet device driver support for Broadcom
> > BCM8958x Automotive Ethernet switch SoC devices.
> > 
> > This SoC device has PCIe ethernet MAC attached to an integrated ethernet
> > switch using XGMII interface. The PCIe ethernet controller is presented to
> > the Linux host as PCI network device.
> > 
> > The following block diagram gives an overview of the application.
> >               +=================================+
> >               |       Host CPU/Linux            |
> >               +=================================+
> >                          || PCIe
> >                          ||
> >          +==========================================+
> >          |           +--------------+               |
> >          |           | PCIE Endpoint|               |
> >          |           | Ethernet     |               |
> >          |           | Controller   |               |
> >          |           |   DMA        |               |
> >          |           +--------------+               |
> >          |           |   MAC        |   BCM8958X    |
> >          |           +--------------+   SoC         |
> >          |               || XGMII                   |
> >          |               ||                         |
> >          |           +--------------+               |
> >          |           | Ethernet     |               |
> >          |           | switch       |               |
> >          |           +--------------+               |
> >          |             || || || ||                  |
> >          +==========================================+
> >                        || || || || More external interfaces
> > 
> > The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
> > MAC IP introduces new DMA architecture called Hyper-DMA for virtualization
> > scalability.
> > 
> > Driver functionality specific to new MAC (DW25GMAC) is implemented in
> > new file dw25gmac.c.
> > 
> > Management of integrated ethernet switch on this SoC is not handled by
> > the PCIe interface.
> > This SoC device has PCIe ethernet MAC directly attached to an integrated
> > ethernet switch using XGMII interface.
> > 
> > v4->v5:
> >     Summary of changes in this patch series:
> >     As suggested by Serge Semin, defined common setup function for dw25gmac.
> >     To accommodate early adopter DW25GMAC used in BCM8958x device, provide
> >     a mechanism to override snps_id and snps_dev_id used for driver entry
> >     matching in hwif.c
> > 
> >     Patch1:
> >       Added plat_stmmacenet_data::snps_id,snps_dev_id fields - Serge Semin
> >     Patch2:
> >       Define common setup function for dw25gmac_setup() - Serge Semin
> >       Support DW25GMAC IPs with varying VDMA/PDMA count - Abhishek Chauhan
> >       Allocate and initialize hdma mapping configuration data dynamically
> >       based on device's VDMA/PDMA feature capabilities in dw25gmac_setup().
> >       Spelling errors in commit log, lower case 0x for hex -Amit Singh Tomar
> >     Patch3:
> >       Glue support in hwif.c for DW25GMAC in hwif.c - Serge Semin
> >       Provide an option to override snps_id and snps_dev_id when the device
> >       reports version info not conformant with driver's expectations as is
> >       the case with BCM8958x device. - Serge Semin
> >     Patch4:
> >       Remove setup function in the glue driver - Serge Semin
> >       Remove unnecessary calls pci_enable_device() and pci_set_master()
> >       in dwxgmac_brcm_pci_resume() - Jakub Kicinski
> >       Merge variable definitions to single line - Amit Singh Tomar
> > 
> > v3->v4:
> >     Based on Serge's questions, received a confirmation from Synopsys that
> >     the MAC IP is indeed the new 25GMAC design.
> >     Renamed all references of XGMAC4 to 25GMAC.
> >     The patch series is rearranged slightly as follows.
> >     Patch1 (new): Define HDMA mapping data structure in kernel's stmmac.h
> >     Patch2 (v3 Patch1): Adds dma_ops for dw25gmac in stmmac core
> >         Renamed new files dwxgmac4.* to dw25gmac.* - Serge Semin
> >         Defined new Synopsis version and device id macros for DW25GMAC.
> >         Converted bit operations to FIELD_PREP macros - Russell King
> >         Moved hwif.h to this patch, Sparse flagged warning - Simon Horman
> >         Defined macros for hardcoded values TDPS etc - Serge Semin
> >         Read number of PDMAs/VDMAs from hardware - Serge Semin
> >     Patch3 (v3 Patch2): Hooks in hardware interface handling for dw25gmac
> >         Resolved user_version quirks questions - Serge, Russell, Andrew
> >         Added new stmmac_hw entry for DW25GMAC. - Serge
> >         Added logic to override synopsis_dev_id by glue driver.
> >     Patch4 (v3 Patch3): Adds PCI driver for BCM8958x device
> >         Define bitmmap macros for hardcoded values - Andrew Lunn
> >         Added per device software node - Andrew Lunn
> >     Patch5(new/split): Adds BCM8958x driver to build system
> >     https://lore.kernel.org/netdev/20240814221818.2612484-1-jitendra.vegiraju@broadcom.com/
> > 
> > v2->v3:
> >     Addressed v2 comments from Andrew, Jakub, Russel and Simon.
> >     Based on suggestion by Russel and Andrew, added software node to create
> >     phylink in fixed-link mode.
> >     Moved dwxgmac4 specific functions to new files dwxgmac4.c and dwxgmac4.h
> >     in stmmac core module.
> >     Reorganized the code to use the existing glue logic support for xgmac in
> >     hwif.c and override ops functions for dwxgmac4 specific functions.
> >     The patch is split into three parts.
> >       Patch#1 Adds dma_ops for dwxgmac4 in stmmac core
> >       Patch#2 Hooks in the hardware interface handling for dwxgmac4
> >       Patch#3 Adds PCI driver for BCM8958x device
> >     https://lore.kernel.org/netdev/20240802031822.1862030-1-jitendra.vegiraju@broadcom.com/
> > 
> > v1->v2:
> >     Minor fixes to address coding style issues.
> >     Sent v2 too soon by mistake, without waiting for review comments.
> >     Received feedback on this version.
> >     https://lore.kernel.org/netdev/20240511015924.41457-1-jitendra.vegiraju@broadcom.com/
> > 
> > v1:
> >     https://lore.kernel.org/netdev/20240510000331.154486-1-jitendra.vegiraju@broadcom.com/
> > 
> > Jitendra Vegiraju (5):
> >    Add HDMA mapping for dw25gmac support
> >    Add basic dw25gmac support in stmmac core
> >    Integrate dw25gmac into stmmac hwif handling
> >    Add PCI driver support for BCM8958x
> >    Add BCM8958x driver to build system
> > 
> >   MAINTAINERS                                   |   8 +
> >   drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> >   drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
> >   drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
> >   .../net/ethernet/stmicro/stmmac/dw25gmac.c    | 224 ++++++++
> >   .../net/ethernet/stmicro/stmmac/dw25gmac.h    |  92 ++++
> >   .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 507 ++++++++++++++++++
> >   .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   1 +
> >   .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  43 ++
> >   .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++
> >   drivers/net/ethernet/stmicro/stmmac/hwif.c    |  26 +-
> >   drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
> >   include/linux/stmmac.h                        |  48 ++
> >   13 files changed, 997 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
> >   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
> >   create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
> 

> Hi Serge, to you think you will have time to review this series soon?
> 
> We are sort in a rush to flush the net-next material before the upcoming
> merge window.

I'll get back to reviewing the series today. Sorry for the
inconvenience.

-Serge(y)

> 
> Thanks,
> 
> Paolo
> 

