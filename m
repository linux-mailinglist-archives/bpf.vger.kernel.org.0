Return-Path: <bpf+bounces-36267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 340F7945BBB
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 12:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8A72824F1
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 10:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153AC1DAC43;
	Fri,  2 Aug 2024 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdDm6r4u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1875136995;
	Fri,  2 Aug 2024 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722592978; cv=none; b=MFupIwECtIDgyp81lqNBDxyx3WqsHNJpxsts2rc8YztRE2JmhoI9Fzb9I4Dc/gy7/RrsZkhedh1ulYqwMVdGXiUOeAwrjkrCx74yNnsRMAW1Cnjo+bdLVwZW0N874S5fihUN1E8yfgOu3ZKactjuVsn4jNnSNmF+D9uZiu/vG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722592978; c=relaxed/simple;
	bh=z9XwdJUQ9pMjbcF87NP4M00mVziyVUvEaICwAGH09hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4bweNu2qrwgQlwSOkCXCr5Pk4ImFrmV/zkzVK6yhSB/v8yUe9B+10OQDw6ZfyeF1YdnmzX8xAxmsliVKs5SPebxwbAqzmWZDsv61sJEiTmnzlCGi0umvTwC78vCKOnm9KL0wYLYhBK5pGBeT9kwVt0hQCYX3TUx/B5slBqijZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IdDm6r4u; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efa16aad9so11341088e87.0;
        Fri, 02 Aug 2024 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722592975; x=1723197775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wZVHSXBYePrNzDvUHr9E39NsWzR6Its68DUoWo8U4b0=;
        b=IdDm6r4uoUHY7IpW+GMQVEFq0HeWhN3eFSsMqA85PtrfwPMgrl3D7OPI9QvGSPUhfS
         OuU0D7gzhtYMQJf5M6rUCxGz6iHPNNWxmsiIwJ05/qgC+RZgwAnqce9jHCAFKTpPFx9L
         3LOjwmk4MqRpL/+iWMGMzwjDtRDHznKcoZK+iWZRhThVqq32TFSVCSGFCQm8qy9w77Uo
         WP8Pv7B+YwEQZ9GPjEmjzygMf6JUOYeLvPCUrk9Tp8DlBIvOuYZqQVnDWojNUvtoIjmk
         yCoc+a32aQx2c07Ub3FyJVKErYjowujuPIslNBd9wwdf0/dHkSXUG+ohVUUqczqnf6ob
         5/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722592975; x=1723197775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZVHSXBYePrNzDvUHr9E39NsWzR6Its68DUoWo8U4b0=;
        b=PKjgMj7kgoDnIioP85KaAu6UkTWY8a1tqaQLgH+kvYqIkqw1wnKZXoKHXfErMgHK2J
         llV1/R7vY5L9qiYrt3y8O+dPSlWznucgJausdSio6Njp/qjFO1SWsC6jbhLQkQhwlUwl
         Fe4VL6dp/VNuDfmstglqEUP7SfESsXeVgFE43t8r6n3Hv3HKp9x6aADrPyY7ylIc2W7b
         urMp371x+TeIB+cUm4veFfCP5ihXUyObkRNLCTzYHiNzMASjzzVjLhxHYryJqO8pQgGJ
         JtH4KflzK8czo6fToDNycG5KdlYtImYBofoWiHhyhW0jIbBi+jnoKwNIPddYc3DTGwhS
         dzog==
X-Forwarded-Encrypted: i=1; AJvYcCWC2xagXfuQw5eHN/Hx5jV2f1kC55cya1flNEeZyPn894QhOuHd1pFVYDvVWRkvD1wFaQ9XXg++0lRBrl+MEbWAlvD9i98UxOogUxzMEbvhjkdYng5CNql62cbG5KVq8ZfF
X-Gm-Message-State: AOJu0YwP3zydXc47C7NsIDPL2vsXM4FngfrONOK6YD61adKT3VshdAmi
	IJKOaRJj71Kz8Z4PzAxGs9QMejGqszY9jBVVIVty0dVWTzGitHJEYR3G+xbm
X-Google-Smtp-Source: AGHT+IF1UmlHhGYQVK/9XpRdhD/Aw56X/aI72duc6eMy8HIVqxE9ZpT4HSD4Bwp8nUlVnomP0I4Aog==
X-Received: by 2002:ac2:4e14:0:b0:52f:cd03:a847 with SMTP id 2adb3069b0e04-530bb3a4f47mr1435029e87.61.1722592974390;
        Fri, 02 Aug 2024 03:02:54 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba2a10asm189014e87.133.2024.08.02.03.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:02:53 -0700 (PDT)
Date: Fri, 2 Aug 2024 13:02:50 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: jitendra.vegiraju@broadcom.com
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
Message-ID: <oul3ymxlfwlqc3wikwyfix5e2c7hozwfsdwswkdtayxd2zzphz@mld3uobyw5pv>
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>

Hi Jitendra

On Thu, Aug 01, 2024 at 08:18:19PM -0700, jitendra.vegiraju@broadcom.com wrote:
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
> driver uses common dwxgmac2 code where applicable.

Thanks for submitting the series.

I am curious how come Broadcom got to use an IP-core which hasn't
been even announced by Synopsys. AFAICS the most modern DW XGMAC
IP-core is of v3.xxa version:

https://www.synopsys.com/dw/ipdir.php?ds=dwc_ether_xgmac

Are you sure that your device isn't equipped with some another DW MAC
IP-core, like DW 25G Ethernet MAC? (which BTW is equipped with a new
Hyper DMA engine with a capability to have up to 128/256 channels with
likely indirect addressing.) Do I miss something?

* I'll join the patch set review after the weekend, sometime on the
next week.

-Serge(y)

> Driver functionality specific to this MAC is implemented in dwxgmac4.c.
> Management of integrated ethernet switch on this SoC is not handled by
> the PCIe interface.
> This SoC device has PCIe ethernet MAC directly attached to an integrated
> ethernet switch using XGMII interface.
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
> Jitendra Vegiraju (3):
>   Add basic dwxgmac4 support to stmmac core
>   Integrate dwxgmac4 into stmmac hwif handling
>   Add PCI driver support for BCM8958x
> 
>  MAINTAINERS                                   |   8 +
>  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
>  .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 517 ++++++++++++++++++
>  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++
>  .../net/ethernet/stmicro/stmmac/dwxgmac4.c    | 142 +++++
>  .../net/ethernet/stmicro/stmmac/dwxgmac4.h    |  84 +++
>  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  26 +-
>  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
>  10 files changed, 825 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h
> 
> -- 
> 2.34.1
> 
> 

