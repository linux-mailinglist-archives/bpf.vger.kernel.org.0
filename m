Return-Path: <bpf+bounces-37386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D54E6955104
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 20:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35AF9B218B0
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1301D1C37BF;
	Fri, 16 Aug 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mel8xu9a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D1E4174C;
	Fri, 16 Aug 2024 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833975; cv=none; b=m0H49tRWsiFr9ANxXVReSMKu9a7yEGu45/uAWvudbog7qA+5E2qmIQTp+HytJtZYGGcUtSauilweWg5X3pfx4+RJ3RaXncW5OgTJ7xZL3JyGGheiFpPPNV3DOk0ScR4avnXNyNONmahV41ZFPQt6Mh2GK0Bk/Abr6mizaJzKsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833975; c=relaxed/simple;
	bh=Fio/CJS4C99XjUj8Ec+0YexuwKVI/7sHNgTQy6j+uNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZNDgtTdDLYWbQrLt090ljHyEmP+SsabKO0XFwFaV9EasGO+jwvAwj/9nrisC/e5oDEESvolkOrjD3jYyuXek0Dwa0KK2j+roRgqHdhwPJn4Yo/xkQyVdfhYN3j5TCmEsF0u113cIzDo0NJ2H+QdEJIMu70Ql+szG4lrUV4OlK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mel8xu9a; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eeb1ba040aso32318841fa.1;
        Fri, 16 Aug 2024 11:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723833972; x=1724438772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GR4ikPPWol9ep3eUe0jkCvtintspPHLufmBMOxuSaZA=;
        b=mel8xu9al95OlwFw65/eHHYK62SrL9AskPj85TXsMPcKpJ6SpN2ORrBphBhXDxeo2I
         661cSvZovR3FqWLQR5xGBypChbEVxjYWG6IRW6NTdcBURtv9yUmKN62eQRxEwdxu5oHj
         fZ1DQ2/xUPRSzBwodj9TzkYO7jlvDG9lhpAU6ac3NjeulyDNgG3b3BnxwSBxV5rM6tfT
         O6F/wX5ayoq3JrjCztEinYdBHAuecdF5b4bq6qUF9wryn3pXrOzrZ6FXqaZPtRXce64a
         Rv49ai9CETX7YLlI5cHwskF4IEkaIyWRWtfqFMTBKekSWDpfNJHJBCgsDMDMYs9UUcS4
         hZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723833972; x=1724438772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GR4ikPPWol9ep3eUe0jkCvtintspPHLufmBMOxuSaZA=;
        b=q64S9AvHXkdxf0ioIhJ3TWdSWjcIePibwlDxF8oy5SJ0kljMloZcWMgHDC7R7u2ODO
         UkBxxBPAaS+/0W3JJN8UKj1YzJqEWXYsEnsNrUwYm/2k320VOkITtcxsXpCgB5Gs5/XX
         qWTe4Y8MmNdUyRUTqRa7G5EGOKnezO3fnNzcDRpaNv/dGhJzieRZPU6bZK/bq+MMX1A0
         AbSbkdh9oELO6Fq9hOLnHBLwDqjldBl7C05JCriKhmLlu7C63EJ42N9CoIe3KzzYKl+c
         bx08D76yWMmuaS3OscBPKooCDyl+ofTyR7mXPx9QwKGCSkdX/5b22KrbjORwSpmb+qdP
         UThQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbSlXDGZcu0oREyiJnJ1iEBPYM7VooHLxxoazHLQF3XbGV+OaGOlJF4AvzDAMex2QECiSCbgUNxvQ6PbbocQUKgpOKFjB/LQqTWoy8U2uExd3ePvPs0LbGYBg02Lkz/vC5
X-Gm-Message-State: AOJu0YzVtLW1WSxNZiDbMlS57TA0ke3h9AcGTes4TyEJ3LAkb8sVVYqP
	Bqgw93z/tYz3NY+LXAakp+KE3C8+/gJ1tBmthjuoj8DlPRV9WjDy
X-Google-Smtp-Source: AGHT+IH5KhGUQnH9Joun4vIZh1odDxIkkjfXbFhlAGMBPBeYBvb0XZeIIU7MeMHFMyTdtaiRFqTk8A==
X-Received: by 2002:a2e:be1c:0:b0:2ef:2c91:502a with SMTP id 38308e7fff4ca-2f3be575bf6mr35545871fa.3.1723833971285;
        Fri, 16 Aug 2024 11:46:11 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b746cd25sm6429871fa.9.2024.08.16.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 11:46:10 -0700 (PDT)
Date: Fri, 16 Aug 2024 21:46:07 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, 
	xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	leong.ching.swee@intel.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	andrew@lunn.ch, linux@armlinux.org.uk, horms@kernel.org, 
	florian.fainelli@broadcom.com
Subject: Re: [net-next v4 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <pajh2btfch2a5nmjuup4djtv4l3ofref5tjx7ocs7ofwnjfej6@n3gf36v37liz>
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>

Hi Jitendra

On Wed, Aug 14, 2024 at 03:18:13PM -0700, jitendra.vegiraju@broadcom.com wrote:
> From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> 
> This patchset adds basic PCI ethernet device driver support for Broadcom
> BCM8958x Automotive Ethernet switch SoC devices.
> 
> This SoC device has PCIe ethernet MAC attached to an integrated ethernet
> switch using XGMII interface. The PCIe ethernet controller is presented to
> the Linux host as PCI network device.
> 
> The following block diagram gives an overview of the application.
>              +=================================+
>              |       Host CPU/Linux            |
>              +=================================+
>                         || PCIe
>                         ||
>         +==========================================+
>         |           +--------------+               |
>         |           | PCIE Endpoint|               |
>         |           | Ethernet     |               |
>         |           | Controller   |               |
>         |           |   DMA        |               |
>         |           +--------------+               |
>         |           |   MAC        |   BCM8958X    |
>         |           +--------------+   SoC         |
>         |               || XGMII                   |
>         |               ||                         |
>         |           +--------------+               |
>         |           | Ethernet     |               |
>         |           | switch       |               |
>         |           +--------------+               |
>         |             || || || ||                  |
>         +==========================================+
>                       || || || || More external interfaces
> 
> The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. This
> MAC IP introduces new DMA architecture called Hyper-DMA for virtualization
> scalability.
> 
> Driver functionality specific to new MAC (DW25GMAC) is implemented in
> new file dw25gmac.c.
> 
> Management of integrated ethernet switch on this SoC is not handled by
> the PCIe interface.
> This SoC device has PCIe ethernet MAC directly attached to an integrated
> ethernet switch using XGMII interface.
> 
> v3->v4:
>    Based on Serge's questions, received a confirmation from Synopsis that
>    the MAC IP is indeed the new 25GMAC design.
>    Renamed all references of XGMAC4 to 25GMAC.
>    The patch series is rearranged slightly as follows.
>    Patch1 (new): Define HDMA mapping data structure in kernel's stmmac.h
>    Patch2 (v3 Patch1): Adds dma_ops for dw25gmac in stmmac core
>        Renamed new files dwxgmac4.* to dw25gmac.* - Serge Semin
>        Defined new Synopsis version and device id macros for DW25GMAC.
>        Coverted bit operations to FIELD_PREP macros - Russell King
>        Moved hwif.h to this patch, Sparse flagged warning - Simon Horman
>        Defined macros for hardcoded values TDPS etc - Serge Semin
>        Read number of PDMAs/VDMAs from hardware - Serge Semin
>    Patch3 (v3 Patch2): Hooks in hardware interface handling for dw25gmac
>        Resolved user_version quirks questions - Serge, Russell, Andrew
>        Added new stmmac_hw entry for DW25GMAC. - Serge
>        Added logic to override synopsis_dev_id by glue driver.
>    Patch4 (v3 Patch3): Adds PCI driver for BCM8958x device
>        Define bitmmap macros for hardcoded values - Andrew Lunn
>        Added per device software node - Andrew Lunn
>    Patch5(new/split): Adds BCM8958x driver to build system

Thanks for the series update and I'm sorry for abandoning the
v3 discussion. I had to work on another urgent task. I'll get back to
reviewing your patch set on the next week.

-Serge(y)

>    
> v2->v3:
>    Addressed v2 comments from Andrew, Jakub, Russel and Simon.
>    Based on suggestion by Russel and Andrew, added software node to create
>    phylink in fixed-link mode.
>    Moved dwxgmac4 specific functions to new files dwxgmac4.c and dwxgmac4.h
>    in stmmac core module.
>    Reorganized the code to use the existing glue logic support for xgmac in
>    hwif.c and override ops functions for dwxgmac4 specific functions.
>    The patch is split into three parts.
>      Patch#1 Adds dma_ops for dwxgmac4 in stmmac core
>      Patch#2 Hooks in the hardware interface handling for dwxgmac4
>      Patch#3 Adds PCI driver for BCM8958x device
>    https://lore.kernel.org/netdev/20240802031822.1862030-1-jitendra.vegiraju@broadcom.com/
> 
> v1->v2:
>    Minor fixes to address coding style issues.
>    Sent v2 too soon by mistake, without waiting for review comments.
>    Received feedback on this version.
>    https://lore.kernel.org/netdev/20240511015924.41457-1-jitendra.vegiraju@broadcom.com/
> 
> v1:  
>    https://lore.kernel.org/netdev/20240510000331.154486-1-jitendra.vegiraju@broadcom.com/
> 
> Jitendra Vegiraju (5):
>   Add HDMA mapping for dw25gmac support
>   Add basic dw25gmac support to stmmac core
>   Integrate dw25gmac into stmmac hwif handling
>   Add PCI driver support for BCM8958x
>   Add BCM8958x driver to build system
> 
>  MAINTAINERS                                   |   8 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   2 +
>  .../net/ethernet/stmicro/stmmac/dw25gmac.c    | 173 ++++++
>  .../net/ethernet/stmicro/stmmac/dw25gmac.h    |  90 +++
>  .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 530 ++++++++++++++++++
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 +
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  25 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h  |   1 +
>  include/linux/stmmac.h                        |  50 ++
>  12 files changed, 922 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
> 
> -- 
> 2.34.1
> 

