Return-Path: <bpf+bounces-42604-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D42C9A6609
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 13:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C06FB25388
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 11:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE141E47AC;
	Mon, 21 Oct 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMj2kvrN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041DE1E32B1;
	Mon, 21 Oct 2024 11:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508730; cv=none; b=jHn7llAeR39p8kEjoAnY2e9g9/E+Euj9Uhc4uin6D4C5kux1HdEDpCO8Cqsble6rv6QWsH9Be+JZK9f2+LDeIicqGM55cVGEv9s6yFH6BYbZk9gl8S15BkGiyzGloUJRCNrwwSahLfY7SrYreLcSFcLOWmYvn+Eb/otHHv47ETE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508730; c=relaxed/simple;
	bh=ZRTKoqaHXBOxiKN8AEbhr4Fx3bC/DN2G3is5OfKXU6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gq0/CNpoORcn2Y/hU/GYrPule9jCa9IAKLLfGEsfR0OcNR+qA544t1UCCEIxJT16Oi9dHxlVQtuzjT7yae8YWvgCM7sMA7BVN0dFGP2XRgQpJ553/Eq5xf+UxU2b1pW96jqEICUQ8zj1GntPAOJpBVibcyoX60iwAiyL1W3guTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMj2kvrN; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fabb837ddbso58271801fa.1;
        Mon, 21 Oct 2024 04:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729508726; x=1730113526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqNFHSWuutv20ehvXxI1hUrs4pZWsBCSOoD06uhzKuM=;
        b=FMj2kvrNAyiorz+akmCjTu8ko+zgscjhFDf5F8gY2NauPecHOY+PjeUNo16B9t9q/A
         +keaUtxU3v1uXlmVfX6Z2RP7wbyL52VmGoZiVW2Ijlg5xodt96rJsJZlyQmJjbvYvS+M
         TmFwXn3UHE8pdgc5KvomRZHiDoRuT7QeUNZ5Kc7nXNm4y0nehm39B0z7/63IuPopm3Tu
         8kUu+bYl0AZil6j5RCwUOolAmv67abQjC7QUCu4ZHL+7YgbwOQkLwxm0x1eZdPyZGDU5
         /VbrprXa7GIsEcZHRq7LsW7p2KMNFHnfM91Cz8Ma1Wp9ZjIMFS57JuRs0YMlwnDcSALZ
         l4yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729508726; x=1730113526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqNFHSWuutv20ehvXxI1hUrs4pZWsBCSOoD06uhzKuM=;
        b=txrxFQ1CNUX/1v+FdU8I8q/KONPAKJ2+38SvWgtVj284xYBLXq3VQFU1736TCD/S28
         so5b1lYwWRZ1CpNvpU8hNEWZ1LRtce+HuEYF+tOKJ/gUmy2efO2qi3XUVYqB4WjQ8ehr
         ESlYI8usPS7YQfRRe7OYz7y0Ffv6Dqeqwfz9X9numq55FIR2dfYHoRy3DnPoK79EXZuU
         q/kAFRtxfNV4HpalNGWgwgh5fg5YkkHAk2Lry0VWlUsp4OWEGAZXRyez5iM9a8oGuo5P
         Z+0xuXD6svrDpUXLJpderzGEz18vJV3s7sXo0eJ3X67KR2JY1543XUuYdpulgNebfaCW
         +8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUNH0My9IpONXlhCYuFXT67fyh7jQBXtwp6ApDb2SzlYTxiRVD6KHYw/Yi/xgsF5hkHphJ5t7rWnDQ1bmGY@vger.kernel.org, AJvYcCVeIafqDwtI/wkPetHuoY3HOPuxrYWMsXgonRlaZEzQB4rWzorOG/n6jdOWceBPVazxmGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8HUWmStmkR6AlJUK25UJaRnuIht6rcfmRBlra8Gfp4GP8VDDQ
	tmHQSCWq1pnOwObPBEWDYS+mOtZnVL5+uSlAT8u5T3ZAK1B1nyB7
X-Google-Smtp-Source: AGHT+IFOG1PkyobwVZ39rIiirf4rBQ3iEqCXuA8Jmy8EQXggUTer46/r7rXVJ6UNucPZayPd0vjXNg==
X-Received: by 2002:a05:6512:3f12:b0:533:71f:3a3d with SMTP id 2adb3069b0e04-53a1545d85fmr8891958e87.24.1729508725650;
        Mon, 21 Oct 2024 04:05:25 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a2242024csm453364e87.121.2024.10.21.04.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 04:05:25 -0700 (PDT)
Date: Mon, 21 Oct 2024 14:05:21 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: jitendra.vegiraju@broadcom.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, 
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, 
	xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, linux@armlinux.org.uk, 
	horms@kernel.org, florian.fainelli@broadcom.com, quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v6 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <nvc3cop5dn5yjmt4n3q64j76ulsowfw4l577pe47qmba3pvz4z@owm4jwjuhawr>
References: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018205332.525595-1-jitendra.vegiraju@broadcom.com>

Hi Jitendra

On Fri, Oct 18, 2024 at 01:53:27PM GMT, jitendra.vegiraju@broadcom.com wrote:
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
> v5->v6:
>    Change summary to address comments/suggestions by Serge Semin.
>    Patch1:
>      Removed the comlexity of hdma mapping in previous patch series and
>      use static DMA mapping.
>      Renamed plat_stmmacenet_data::snps_dev_id as dev_id and moved to
>      the beginning of the struct.
>    Patch2:
>      Added dw25gmac_get_hw_feature() for dw25gmac.
>      Use static one-to-one VDMA-TC-PDMA mapping.
>    Patch4:
>      Remove usage of plat_stmmacenet_data::msi_*_vec variables for
>      interrupt vector initialization.
>      Change phy_interface type to XGMII.
>      Cleanup unused macros.

Sorry for abandoning the v5 discussion for too long. I've finally
finished another urgent task, so I'll be more interactive in the next
few weeks. I'll get back to reviewing this series today or early
tomorrow.

-Serge(y)

>      
> v4->v5:
>    Summary of changes in this patch series:
>    As suggested by Serge Semin, defined common setup function for dw25gmac.
>    To accommodate early adopter DW25GMAC used in BCM8958x device, provide
>    a mechanism to override snps_id and snps_dev_id used for driver entry
>    matching in hwif.c
> 
>    Patch1:
>      Added plat_stmmacenet_data::snps_id,snps_dev_id fields - Serge Semin
>    Patch2:
>      Define common setup function for dw25gmac_setup() - Serge Semin
>      Support DW25GMAC IPs with varying VDMA/PDMA count - Abhishek Chauhan
>      Allocate and initialize hdma mapping configuration data dynamically
>      based on device's VDMA/PDMA feature capabilities in dw25gmac_setup().
>      Spelling errors in commit log, lower case 0x for hex -Amit Singh Tomar
>    Patch3:
>      Glue support in hwif.c for DW25GMAC in hwif.c - Serge Semin
>      Provide an option to override snps_id and snps_dev_id when the device
>      reports version info not conformant with driver's expectations as is
>      the case with BCM8958x device. - Serge Semin
>    Patch4:
>      Remove setup function in the glue driver - Serge Semin
>      Remove unnecessary calls pci_enable_device() and pci_set_master()
>      in dwxgmac_brcm_pci_resume() - Jakub Kicinski
>      Merge variable definitions to single line - Amit Singh Tomar
>     https://lore.kernel.org/netdev/20240904054815.1341712-1-jitendra.vegiraju@broadcom.com/
>    
> v3->v4:
>    Based on Serge's questions, received a confirmation from Synopsys that
>    the MAC IP is indeed the new 25GMAC design.
>    Renamed all references of XGMAC4 to 25GMAC.
>    The patch series is rearranged slightly as follows.
>    Patch1 (new): Define HDMA mapping data structure in kernel's stmmac.h
>    Patch2 (v3 Patch1): Adds dma_ops for dw25gmac in stmmac core
>        Renamed new files dwxgmac4.* to dw25gmac.* - Serge Semin
>        Defined new Synopsis version and device id macros for DW25GMAC.
>        Converted bit operations to FIELD_PREP macros - Russell King
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
>    https://lore.kernel.org/netdev/20240814221818.2612484-1-jitendra.vegiraju@broadcom.com/
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
>   Add snps_id, dev_id to struct plat_stmmacenet_data
>   Add basic dw25gmac support in stmmac core
>   Integrate dw25gmac into stmmac hwif handling
>   Add PCI driver support for BCM8958x
>   Add BCM8958x driver to build system
> 
>  MAINTAINERS                                   |   8 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
>  .../net/ethernet/stmicro/stmmac/dw25gmac.c    | 161 ++++++
>  .../net/ethernet/stmicro/stmmac/dw25gmac.h    |  92 ++++
>  .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 478 ++++++++++++++++++
>  .../net/ethernet/stmicro/stmmac/dwxgmac2.h    |   1 +
>  .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  42 ++
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  52 ++
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  26 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_main.c |  26 +
>  include/linux/stmmac.h                        |   2 +
>  14 files changed, 905 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
> 
> -- 
> 2.34.1
> 

