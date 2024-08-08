Return-Path: <bpf+bounces-36731-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158DE94C72D
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C03252859F1
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 23:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769D15F318;
	Thu,  8 Aug 2024 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Mup5G055"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62D156257
	for <bpf@vger.kernel.org>; Thu,  8 Aug 2024 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158227; cv=none; b=cvkok/p//XLZ3gFvyLCgEoWSXy1eg5a08EcTFLjAxR8S7dNSv0eWFxm1kdAGzOIWD/CgaTz2WB33thI1K7IHWcgqsFOppW8sz6BdQVtxQnExwj5j8x889q9fh3h0lmwILrKKtdyFwwYrDez/86qPYsrmqhvyoO78riLx7G0gSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158227; c=relaxed/simple;
	bh=iBP+u9JbzgsDg0aj7FR+sU65Rp+zUgwKYa05Yl+inK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zln8PnxBJJ3NQo9ZcJJPTvO0596UKfDYsX1TNbBw9NVy+SEsCnLLUY+Bu10/A1tyiL5b5MCaqezMMufEV/1OjjmsukoNdvON+BxAvPzvQVpORFlYW18s66v6cq/LZDhyB5mCKbsNH4Qm0WjGVjBkSTnsTuLF8Lt0oivi7dC+tgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Mup5G055; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cfd1b25aaaso1238405a91.0
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723158225; x=1723763025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Skx3GBh0EZ38qc6WcYlol/aA6cFrTOAY50sC1FrBmBA=;
        b=Mup5G055qdG4QMWaN2QRWg5wUoqlkAZF/SqCBomj00qpaDac3ZT6FJUJouiLlVsnXq
         yhI1IaGXiij2QVM9KGUSLfwVN5e+ETP7/uOCIchzxMsiF9TFfOubx/s6xq8zbVSXi9qv
         Xfd6OuhGB4jeFT5Em+MoBXUhrMkg15oaKnKns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723158225; x=1723763025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Skx3GBh0EZ38qc6WcYlol/aA6cFrTOAY50sC1FrBmBA=;
        b=r4cwG1QeiE4Uow/2HUYeFfDup+uEkdWdVttph2bLh0Rm2nfo1o8KQCtPQWRgkawIDy
         S1sqgFZb8kZNP9ZsDLFHGAhHTkSisEcT93D9UEhf3QoCQHp6wiAp+dTJiPgx7PKZnzie
         N9SfRjVOPxE5Vq5M1YxPD4ZhcpwAJaXpI59nyEGWgC6me1/9k8wgSrJFmoXaURE1FK45
         DLwQ/SnlKeyN8sSWHb9t2fetN6HWPD2FBiA7owDLgUZjp2N520uztrLJeQPswZRYqtSZ
         iDVloocNx8HIJgsgRQWFHzgEXXz+tComqq7ecXr5GLIXi6vdrfkwhiPtiJ3cGXV7CeD7
         L4qg==
X-Forwarded-Encrypted: i=1; AJvYcCUTdovI1kIjQkxpUwsyJhwmicUz/wNkedEFQJ6YTEC7Zlg1zrFlNfaYJn8W2O5C7oCKRbTDHoObHScA/2ETidvJvlh/
X-Gm-Message-State: AOJu0YyRrMOhWrNErbG5w7YEe37nresoDGOJE2XL1tquu+5tUJlNN8Qz
	CIkLdBG6r6zunF9bOLqsC/yoRTXFRBhMNVgZX/uVeltXh0mOhbO64ZnMukooYvVwAlC9/YHQcak
	9Wn84FfHZsVUX6iwxfAc2ghOGxJhzSvuabzSo
X-Google-Smtp-Source: AGHT+IEurs1ZraK16gLlx2+6o+2jGNgwZ+6lAL2/OitH1L7OF2fZ4tavR/6IquvNnXpvFpwc04B358Poa1eJ6aD7fXk=
X-Received: by 2002:a17:90a:9c11:b0:2cf:c2df:67de with SMTP id
 98e67ed59e1d1-2d1c33741bdmr3917540a91.9.1723158225194; Thu, 08 Aug 2024
 16:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <oul3ymxlfwlqc3wikwyfix5e2c7hozwfsdwswkdtayxd2zzphz@mld3uobyw5pv>
 <CAMdnO-JKfi0hqaR5zrzzv6j-c6OhH-LTZT5WWBCFDOG_+ZxTeQ@mail.gmail.com> <2vvet4ai3uihb2skzyfiym2qh6g26knb7ymjp73eejoiywqnkm@2rxxv6zqvi33>
In-Reply-To: <2vvet4ai3uihb2skzyfiym2qh6g26knb7ymjp73eejoiywqnkm@2rxxv6zqvi33>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Thu, 8 Aug 2024 16:03:34 -0700
Message-ID: <CAMdnO-+PHMBsarskvzcTSHFeSdf9t2iN3EMcBYUGKdQJ28ctTg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] net: stmmac: Add PCI driver support for BCM8958x
To: Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 3:43=E2=80=AFPM Serge Semin <fancer.lancer@gmail.com=
> wrote:
>
> On Fri, Aug 02, 2024 at 03:06:05PM -0700, Jitendra Vegiraju wrote:
> > On Fri, Aug 2, 2024 at 3:02=E2=80=AFAM Serge Semin <fancer.lancer@gmail=
.com> wrote:
> > >
> > > Hi Jitendra
> > >
> > > On Thu, Aug 01, 2024 at 08:18:19PM -0700, jitendra.vegiraju@broadcom.=
com wrote:
> > > > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > > >
> > > > This patchset adds basic PCI ethernet device driver support for Bro=
adcom
> > > > BCM8958x Automotive Ethernet switch SoC devices.
> > > >
> > > > This SoC device has PCIe ethernet MAC attached to an integrated eth=
ernet
> > > > switch using XGMII interface. The PCIe ethernet controller is prese=
nted to
> > > > the Linux host as PCI network device.
> > > >
> > > > The following block diagram gives an overview of the application.
> > > >              +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > > >              |       Host CPU/Linux            |
> > > >              +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > > >                         || PCIe
> > > >                         ||
> > > >         +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > > >         |           +--------------+               |
> > > >         |           | PCIE Endpoint|               |
> > > >         |           | Ethernet     |               |
> > > >         |           | Controller   |               |
> > > >         |           |   DMA        |               |
> > > >         |           +--------------+               |
> > > >         |           |   MAC        |   BCM8958X    |
> > > >         |           +--------------+   SoC         |
> > > >         |               || XGMII                   |
> > > >         |               ||                         |
> > > >         |           +--------------+               |
> > > >         |           | Ethernet     |               |
> > > >         |           | switch       |               |
> > > >         |           +--------------+               |
> > > >         |             || || || ||                  |
> > > >         +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> > > >                       || || || || More external interfaces
> > > >
> > > > The MAC block on BCM8958x is based on Synopsis XGMAC 4.00a core. Th=
is
> > > > driver uses common dwxgmac2 code where applicable.
> > >
> > > Thanks for submitting the series.
> > >
> > > I am curious how come Broadcom got to use an IP-core which hasn't
> > > been even announced by Synopsys. AFAICS the most modern DW XGMAC
> > > IP-core is of v3.xxa version:
> > >
> > > https://www.synopsys.com/dw/ipdir.php?ds=3Ddwc_ether_xgmac
> > >
>
> > I am not sure why the 4.00a IP-code is not announced for general
> > availability yet.
> > The Synopsis documentation for this IP mentions 3.xx IP as reference
> > for this design and lists
> > new features for 4.00a.
> >
> > > Are you sure that your device isn't equipped with some another DW MAC
> > > IP-core, like DW 25G Ethernet MAC? (which BTW is equipped with a new
> > > Hyper DMA engine with a capability to have up to 128/256 channels wit=
h
> > > likely indirect addressing.) Do I miss something?
> > >
> > Yes, I briefly mentioned the new DMA architecture in the commit log
> > for patch 1/3.
> > You are correct, the name for the new DMA engine is Hyper DMA. It
> > probably started with some 3.xx IP-Core.
> > This DW-MAC is capable of 25G, but this SOC is not using 25G support.
>
> Then what you have is likely the DW 25GMAC since just DW XGMAC hasn't
> been announced to have neither 25G speed nor the Hyper-DMA with the
> virtualization channels capabilities. Meanwhile the former IP-core
> does have these features:
> https://www.synopsys.com/dw/ipdir.php?ds=3Ddwc_25g_ethernet_mac_ip
>
> Alas I don't have the DW 25GMAC IP-core databook to say for sure, but
> that's the only explanation of why you have the 0x40 Synopsys ID and
> the IP-core version of v4.00a, and the 25G capability of the MAC.
>
> Seeing Synopsys tends to re-use the CSRs mapping even across the major
> IP-core releases it isn't that surprising that the DW XGMAC 3.xx
> IP-core was referenced in the doc. (See the driver, DW XLGMAC is
> almost fully compatible with the DW XGMAC CSRs mapping.)
>
> Moreover the most DMA-capable device currently supported by the
> STMMAC-driver is DW XGMAC/XLGMAC and it can't have more than 16
> DMA-channels. That allows to directly map all the channels CSRs to the
> system memory. But your case is different. The DW 25GMAC IP-core is
> announced to support virtualization up to 128/256 channels, for which
> the direct CSRs mapping could require 16-times more memory. That's
> likely why the indirect addressing was implemented to access the
> settings of all the possible channels. That's also implicitly proofs
> that you have the DW 25GMAC IP-core.
Hi Serge(y)

Thanks for reviewing the patch series.
Sorry for the delay in my response. We waited for a clarification on
the IP version.
Its confirmed that we got an early adapter version of 25GMAC IP-Core.
Added more details in the context of other questions in Patch 1,2.
>
> -Serge(y)
>
> >
> > > * I'll join the patch set review after the weekend, sometime on the
> > > next week.
> > >
> > > -Serge(y)
> > >
> > > > Driver functionality specific to this MAC is implemented in dwxgmac=
4.c.
> > > > Management of integrated ethernet switch on this SoC is not handled=
 by
> > > > the PCIe interface.
> > > > This SoC device has PCIe ethernet MAC directly attached to an integ=
rated
> > > > ethernet switch using XGMII interface.
> > > >
> > > > v2->v3:
> > > >    Addressed v2 comments from Andrew, Jakub, Russel and Simon.
> > > >    Based on suggestion by Russel and Andrew, added software node to=
 create
> > > >    phylink in fixed-link mode.
> > > >    Moved dwxgmac4 specific functions to new files dwxgmac4.c and dw=
xgmac4.h
> > > >    in stmmac core module.
> > > >    Reorganized the code to use the existing glue logic support for =
xgmac in
> > > >    hwif.c and override ops functions for dwxgmac4 specific function=
s.
> > > >    The patch is split into three parts.
> > > >      Patch#1 Adds dma_ops for dwxgmac4 in stmmac core
> > > >      Patch#2 Hooks in the hardware interface handling for dwxgmac4
> > > >      Patch#3 Adds PCI driver for BCM8958x device
> > > >
> > > > v1->v2:
> > > >    Minor fixes to address coding style issues.
> > > >    Sent v2 too soon by mistake, without waiting for review comments=
.
> > > >    Received feedback on this version.
> > > >    https://lore.kernel.org/netdev/20240511015924.41457-1-jitendra.v=
egiraju@broadcom.com/
> > > >
> > > > v1:
> > > >    https://lore.kernel.org/netdev/20240510000331.154486-1-jitendra.=
vegiraju@broadcom.com/
> > > >
> > > > Jitendra Vegiraju (3):
> > > >   Add basic dwxgmac4 support to stmmac core
> > > >   Integrate dwxgmac4 into stmmac hwif handling
> > > >   Add PCI driver support for BCM8958x
> > > >
> > > >  MAINTAINERS                                   |   8 +
> > > >  drivers/net/ethernet/stmicro/stmmac/Kconfig   |  11 +
> > > >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   3 +-
> > > >  drivers/net/ethernet/stmicro/stmmac/common.h  |   4 +
> > > >  .../net/ethernet/stmicro/stmmac/dwmac-brcm.c  | 517 ++++++++++++++=
++++
> > > >  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++
> > > >  .../net/ethernet/stmicro/stmmac/dwxgmac4.c    | 142 +++++
> > > >  .../net/ethernet/stmicro/stmmac/dwxgmac4.h    |  84 +++
> > > >  drivers/net/ethernet/stmicro/stmmac/hwif.c    |  26 +-
> > > >  drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
> > > >  10 files changed, 825 insertions(+), 2 deletions(-)
> > > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwmac-brcm.=
c
> > > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
> > > >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > > >

