Return-Path: <bpf+bounces-39125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5469F96F417
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 14:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12215288779
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 12:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362991CCB50;
	Fri,  6 Sep 2024 12:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYb8Y0YQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0EA1C9DF7;
	Fri,  6 Sep 2024 12:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624868; cv=none; b=OfZTBbY4n+u6pfULV8RO/NCmqrOXXax/EoOACxU5eDM44gY55LWWs4aiyGD3w9Ey2p5Q9tbro7/jnoHNp/6KLcAt2xdP57AejtcHpmsaFKpR8DC1I/kOMFwkdrWsjJAk9aJX1e2j4Psj0NavEgVt5oS2ljtSttDcXM7IugkTFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624868; c=relaxed/simple;
	bh=unqf3m8/8Vw+S0KGQnHjn/CBMYzdjVAZTYNm4ilTBgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etgu6J1yHrMTpJGVIMg6V0HqFrWqbyIwp0reGQDQYgb1M3cN8wPQN0ebd8nsrqDG2x/GGx336h7fz/pe3tPR4v9E5LWRg1/mHpQXI2oV7Y7XZfqrJInpIDN/IZBcqTvmakLMp0tD2VRh8MyYXy36CnkPep91FxQCXmB2hjYKqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYb8Y0YQ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-536584f6c84so980081e87.0;
        Fri, 06 Sep 2024 05:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725624864; x=1726229664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7MCTJ64Ap0FWa8Yerpoe9k6SUGm0Hd0erFmU70Kt+Uk=;
        b=iYb8Y0YQMxzP3q+vng53jx0B0qjwdGH+pRcqEAG2Kaup5P6iY5ASRr38LGSMpJYt9N
         THBPTj2mzzB2azppiYf173WHyAVfFSzc/IqSAxlnozt7zdelfEN1jjWKKnKfehRspr97
         viIJ6ygLgfFg0DybPHAeaolYlhxz/OiXcimhStOZwK1I78850ktygpqHGb44fO9P3F2V
         6rw8ATw73pEkr+wc7yKnKnnAFSZtP3lfCbxOCLp9ypl3LeP1htzoEuyuP3K1yXEpJ8pi
         8IdDYPjsF3Mx/yD49UoOq965HJcdD6cMXSEVYalvN/WY+x9n/E8/ccSTPEIhAe4uVnze
         GHoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725624864; x=1726229664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7MCTJ64Ap0FWa8Yerpoe9k6SUGm0Hd0erFmU70Kt+Uk=;
        b=LspxHbshV+JuMAESG42OLrP1lBkkBrgc3mZTSCZJtOiDPTTI/3iYn7k3LU9K27poGl
         kRYWk5uTUdt+xZr4R4udIGot1fdYEZsMjGteLlKwkEWb1t6hyfS8F+VzYbrkEMpWLgwh
         OVdqryHPOeKa3nJx1XH6g3p/+rafADoesAEb5uHZNPx3io3Tp69HU5bCvMGRyqG3OD2n
         ugq2NO33Qe/fME7Okh9VzPkKXu8A9p0TYxhQ995gHKXOL3g+WsWgLr/QmuZqVtuK3pKy
         9e/Ah9ial/50XITzYksLhLsy3Vtw6Bd5fw6SPk3l7/+bdYYlbvA1p6mv1+wB/ZQRy/t3
         n5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdicHYdIZSg8RbunTQzXlPwNMy1Yo/Yl2HRBcz6nXQ6CmCN+RzWK6dfFatJQYpXrwmFChNZr/SFkJxfWV+@vger.kernel.org, AJvYcCUvvlMPFXmUKfwAIlVaBj7EsJ/tD/9QB3EC4cUzfnYtDO7YoUdkhKemF3Jj83GA/5CB56U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTM0XzRTeGd3kmokK4CmYn7efhd+Mfn/OOtqJiugqqO8VJueAn
	oL6P9oKD0qDyV1ideNKv6324WQaOg1mubRF3Ru7QcjtZw4kYoncA
X-Google-Smtp-Source: AGHT+IGydFRd1uISwcLNQ7/uLhpGxcjZgeGYt7HNPMfkdE+mw4ggyg3ydgWLV8t9ZR41n0MYx7mGoA==
X-Received: by 2002:a05:6512:398d:b0:532:ef22:eb4e with SMTP id 2adb3069b0e04-5365880a275mr1109279e87.54.1725624863153;
        Fri, 06 Sep 2024 05:14:23 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5356d3782e0sm464090e87.299.2024.09.06.05.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 05:14:22 -0700 (PDT)
Date: Fri, 6 Sep 2024 15:14:20 +0300
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
	horms@kernel.org, florian.fainelli@broadcom.com
Subject: Re: [net-next v5 0/5] net: stmmac: Add PCI driver support for
 BCM8958x
Message-ID: <h74bn2huz3oul27lu7b7upy6mtpbr4w4mbtquxqlvzccackoiy@74tc67lafadf>
References: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904054815.1341712-1-jitendra.vegiraju@broadcom.com>

Hi Jitendra

On Tue, Sep 03, 2024 at 10:48:10PM -0700, jitendra.vegiraju@broadcom.com wrote:
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

Thanks for the update. I'll have a closer look at the series early
next week.

-Serge(y)

> [...]

