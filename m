Return-Path: <bpf+bounces-36737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945C594C7B4
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 02:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C37F4B21BEE
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 00:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4C46FDC;
	Fri,  9 Aug 2024 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S2VbC1vL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F722907
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 00:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164112; cv=none; b=BP0M6iPZ3suQ/GL6gWs6zrgripx4J02QlECnGGLqOB9To13g8k1DGEjvvGDEKhkv/f7UubJ3trljwn2TFHJOXQPRQWysFHSS40FnJ2ZVc4y4FCwVcuy/yQK2E4E6vn2ViW0BLT64Ty19SnLZ76+yb4D5MRFycmLRjXbHkn0o8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164112; c=relaxed/simple;
	bh=GQDtyFxbcT5opJFl/Tjm0pOLa5VZsa9X10OeilH5Aoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ro9cuLkXmIPbKYunwz5vL4lZAFr4+gp0O+X8TT+/5lAae3mZCwPe/gcOxJIt4jO/8PfFheUalhXtMnw1LxdCyc4XcuzGuw06C60gh6nJTDQlP3FcQnLXOo7RY8R6guKzlrPmNwtODzxj3uDa6XR3UEz6Ooc03112ExDxFCqhZe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S2VbC1vL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2cf98ba0559so1226526a91.2
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 17:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723164109; x=1723768909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMa+HgXfbcLv1j8ZNDvKHW/MCvB4vKbczTkeRynl0Iw=;
        b=S2VbC1vLpqf3SAlwQGBbR2eknQ7MNVZTqPo4GC1eMHgNC6JYBVtm661UkX8JsFh44v
         2pXarkv8VUIXn/scj+tjLnZwiZVuoX/l3x/I1OBVxkAhc4kbV8JtfqZ+0OrpwbWGXCjO
         7pqLKarIvLj95qHitGxRDOU3KwIfvenehfU5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723164109; x=1723768909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMa+HgXfbcLv1j8ZNDvKHW/MCvB4vKbczTkeRynl0Iw=;
        b=Ql33yAnIvy2ClBoB89cqBeLgiueTSZ9kqPxheN2/gbH8tcADbbFMYqW9qnT7Zdv0kv
         YbZ9vctpJPCrwb2w0h3KW0Wr44zbvy0xc5D6isQBmZ0eXw15lwZFp+f6E0hP86J03NXD
         R6QkVwjWvScxK/LMjdWlTroGFYjOBs1atYR4ZYo520kSTuMfEyoykBS0lhH0kZ8md5At
         ndvUZ9ZS6NFzB0E4GxYKpq0Cd6Vg5N9zL3EQ2EheuykjRGc+LHUJUyFJLv0pvFu2nhHn
         n5PYxULh0zXG32/TYhrX/i1Ru0GKjS5KiKdHqnxsFBczwFc0YhOr1FdYfeerXsFo883h
         mS1A==
X-Forwarded-Encrypted: i=1; AJvYcCWM3JPqDXFx1KezKDYuJrtVJGmMeF8NR+oXlmDmGeG+DBRf/2iD/N6L+hgab/sPhCbbwlUfduZuBM7/rIxdQ/sY5RAp
X-Gm-Message-State: AOJu0YwyibmUjoWAngm8dvVddgzjGq7mgA9NyhKtfDoa1UExNnOoqOkB
	xvD83P4+yTUdOoelilhz2QdwMft7TIjbb7NANFjXAR8rRR5lYxBAWC0pRlb5jJqDHz6FZ4YhJf8
	KLLeg5yL/J/rldJNwMWOz/yWMjbrDTYB9hjDA
X-Google-Smtp-Source: AGHT+IHDbG9x+0Jp/p0afFemnFW+1v8MKmJHtRMu3N3tUN9zsm9NiSnsrUxrY0wlQIsl6oDLzBJaona3owLelsjrLwI=
X-Received: by 2002:a17:90b:1a89:b0:2c9:9f50:3f9d with SMTP id
 98e67ed59e1d1-2d1c3372906mr4030172a91.5.1723164109132; Thu, 08 Aug 2024
 17:41:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com> <zlbtbzch6reo656d72it5h2s7p5bnwhexire36v3w63mazidta@cqyiza4k562t>
In-Reply-To: <zlbtbzch6reo656d72it5h2s7p5bnwhexire36v3w63mazidta@cqyiza4k562t>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Thu, 8 Aug 2024 17:41:37 -0700
Message-ID: <CAMdnO-K49gp3GtM5EjBsBzcLNJJn60jXo-Kxn-zKn25MjVeZaQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: Add basic dwxgmac4 support
 to stmmac core
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

Resending the message since my earlier email turned-in to HTML because of a=
n
attempt to draw asciiart.
On Tue, Aug 6, 2024 at 2:56=E2=80=AFPM Serge Semin <fancer.lancer@gmail.com=
> wrote:
>
> On Thu, Aug 01, 2024 at 08:18:20PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > Adds support for DWC_xgmac version 4.00a in stmmac core module.
> > This version adds enhancements to DMA architecture for virtualization
> > scalability. This is realized by decoupling physical DMA channels (PDMA=
)
> > from Virtual DMA channels (VDMA). The  VDMAs are software abastractions
> > that map to PDMAs for frame transmission and reception.
> >
> > The virtualization enhancements are currently not being used and hence
> > a fixed mapping of VDMA to PDMA is configured in the init functions.
> > Because of the new init functions, a new instance of struct stmmac_dma_=
ops
> > dwxgmac400_dma_ops is added.
> > Most of the other dma operation functions in existing dwxgamc2_dma.c fi=
le
> > can be reused.
>
> As we figured out (didn't we?) that it's actually the DW 25GMAC, then
> it should be taken into account across the entire series.
>
Yes, indeed its 25GMAC IP.
We got confirmation that we used an early adopter version of the 25GMAC IP.
The 25GMAC always come with HDMA DMA engine.
The synopsis revision id is 4.xx and device id is 0x55.
> >
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
> >  .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++++
> >  .../net/ethernet/stmicro/stmmac/dwxgmac4.c    | 142 ++++++++++++++++++
> >  .../net/ethernet/stmicro/stmmac/dwxgmac4.h    |  84 +++++++++++
> >  4 files changed, 258 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
> >  create mode 100644 drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net=
/ethernet/stmicro/stmmac/Makefile
> > index c2f0e91f6bf8..2f637612513d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> > @@ -6,7 +6,7 @@ stmmac-objs:=3D stmmac_main.o stmmac_ethtool.o stmmac_m=
dio.o ring_mode.o        \
> >             mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o  \
> >             dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
> >             stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o=
 \
> > -           stmmac_xdp.o stmmac_est.o \
>
> > +           stmmac_xdp.o stmmac_est.o dwxgmac4.o \
>
> dw25gmac.o?
We will rename all applicable reference to 25mac as you suggest for
the entire patch series.

>
> >             $(stmmac-y)
> >
> >  stmmac-$(CONFIG_STMMAC_SELFTESTS) +=3D stmmac_selftests.o
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drive=
rs/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > index dd2ab6185c40..c15f5247aaa8 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/iopoll.h>
> >  #include "stmmac.h"
> >  #include "dwxgmac2.h"
>
> > +#include "dwxgmac4.h"
>
> "dw25gmac.h"?
>
> >
> >  static int dwxgmac2_dma_reset(void __iomem *ioaddr)
> >  {
> > @@ -641,3 +642,33 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops =3D=
 {
> >       .enable_sph =3D dwxgmac2_enable_sph,
> >       .enable_tbs =3D dwxgmac2_enable_tbs,
> >  };
> > +
>
> > +const struct stmmac_dma_ops dwxgmac400_dma_ops =3D {
>
> dw25gmac_dma_ops?
>
> > +     .reset =3D dwxgmac2_dma_reset,
>
> > +     .init =3D dwxgmac4_dma_init,
> > +     .init_chan =3D dwxgmac2_dma_init_chan,
> > +     .init_rx_chan =3D dwxgmac4_dma_init_rx_chan,
> > +     .init_tx_chan =3D dwxgmac4_dma_init_tx_chan,
>
> dw25gmac_dma_init, dw25gmac_dma_init_rx_chan, dw25gmac_dma_init_tx_chan?
>
> > +     .axi =3D dwxgmac2_dma_axi,
> > +     .dump_regs =3D dwxgmac2_dma_dump_regs,
> > +     .dma_rx_mode =3D dwxgmac2_dma_rx_mode,
> > +     .dma_tx_mode =3D dwxgmac2_dma_tx_mode,
> > +     .enable_dma_irq =3D dwxgmac2_enable_dma_irq,
> > +     .disable_dma_irq =3D dwxgmac2_disable_dma_irq,
> > +     .start_tx =3D dwxgmac2_dma_start_tx,
> > +     .stop_tx =3D dwxgmac2_dma_stop_tx,
> > +     .start_rx =3D dwxgmac2_dma_start_rx,
> > +     .stop_rx =3D dwxgmac2_dma_stop_rx,
> > +     .dma_interrupt =3D dwxgmac2_dma_interrupt,
> > +     .get_hw_feature =3D dwxgmac2_get_hw_feature,
> > +     .rx_watchdog =3D dwxgmac2_rx_watchdog,
> > +     .set_rx_ring_len =3D dwxgmac2_set_rx_ring_len,
> > +     .set_tx_ring_len =3D dwxgmac2_set_tx_ring_len,
> > +     .set_rx_tail_ptr =3D dwxgmac2_set_rx_tail_ptr,
> > +     .set_tx_tail_ptr =3D dwxgmac2_set_tx_tail_ptr,
> > +     .enable_tso =3D dwxgmac2_enable_tso,
> > +     .qmode =3D dwxgmac2_qmode,
> > +     .set_bfsize =3D dwxgmac2_set_bfsize,
> > +     .enable_sph =3D dwxgmac2_enable_sph,
> > +     .enable_tbs =3D dwxgmac2_enable_tbs,
> > +};
>
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c b/drivers/n=
et/ethernet/stmicro/stmmac/dwxgmac4.c
> > new file mode 100644
> > index 000000000000..9c8748122dc6
> > --- /dev/null
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.c
>
> dw25gmac.c?
>
> > @@ -0,0 +1,142 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024 Broadcom Corporation
> > + */
> > +#include "dwxgmac2.h"
>
> > +#include "dwxgmac4.h"
>
> dw25gmac.h?
>
> > +
> > +static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
> > +{
> > +     u32 reg_val =3D 0;
> > +     u32 val =3D 0;
> > +
> > +     reg_val |=3D mode << XGMAC4_MSEL_SHIFT & XGMAC4_MODE_SELECT;
> > +     reg_val |=3D channel << XGMAC4_AOFF_SHIFT & XGMAC4_ADDR_OFFSET;
> > +     reg_val |=3D XGMAC4_CMD_TYPE | XGMAC4_OB;
> > +     writel(reg_val, ioaddr + XGMAC4_DMA_CH_IND_CONTROL);
> > +     val =3D readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);
> > +     return val;
> > +}
> > +
> > +static void wr_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel, =
u32 val)
> > +{
> > +     u32 reg_val =3D 0;
> > +
> > +     writel(val, ioaddr + XGMAC4_DMA_CH_IND_DATA);
> > +     reg_val |=3D mode << XGMAC4_MSEL_SHIFT & XGMAC4_MODE_SELECT;
> > +     reg_val |=3D channel << XGMAC4_AOFF_SHIFT & XGMAC4_ADDR_OFFSET;
> > +     reg_val |=3D XGMAC_OB;
> > +     writel(reg_val, ioaddr + XGMAC4_DMA_CH_IND_CONTROL);
> > +}
> > +
>
> > +static void xgmac4_tp2tc_map(void __iomem *ioaddr, u8 pdma_ch, u32 tc_=
num)
> > +{
> > +     u32 val =3D 0;
> > +
> > +     val =3D rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, pdma_ch);
> > +     val &=3D ~XGMAC4_TP2TCMP;
> > +     val |=3D tc_num << XGMAC4_TP2TCMP_SHIFT & XGMAC4_TP2TCMP;
> > +     wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, pdma_ch, val);
> > +}
> > +
> > +static void xgmac4_rp2tc_map(void __iomem *ioaddr, u8 pdma_ch, u32 tc_=
num)
> > +{
> > +     u32 val =3D 0;
> > +
> > +     val =3D rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, pdma_ch);
> > +     val &=3D ~XGMAC4_RP2TCMP;
> > +     val |=3D tc_num << XGMAC4_RP2TCMP_SHIFT & XGMAC4_RP2TCMP;
> > +     wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, pdma_ch, val);
> > +}
>
> What does "tc" stand for? Traffic control? If it's a kind of queue
> then what about implementing the stmmac_ops::map_mtl_to_dma interface
> method?
>
TC stands for "traffic class".
The VDMA to PDMA mapping within HDMA has traffic classification block betwe=
en
the two blocks to allow control over DMA resource utilization.
VDMA -- TC --- PDMA
Tx VDMAs and RX VDMAs are mapped onto a TC based on TD2TCMP and RD2TCMP.
Multiple VDMAs can be mapped to the same TC.
TCs are further mapped onto PDMAs based on TP2TCMP and RP2TCMP fields
> > +
> > +void dwxgmac4_dma_init(void __iomem *ioaddr,
> > +                    struct stmmac_dma_cfg *dma_cfg, int atds)
> > +{
> > +     u32 value;
> > +     u32 i;
> > +
> > +     value =3D readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > +
> > +     if (dma_cfg->aal)
> > +             value |=3D XGMAC_AAL;
> > +
> > +     if (dma_cfg->eame)
> > +             value |=3D XGMAC_EAME;
> > +
> > +     writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> > +
> > +     for (i =3D 0; i < VDMA_TOTAL_CH_COUNT; i++) {
>
> > +             value =3D rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i);
> > +             value &=3D ~XGMAC4_TXDCSZ;
> > +             value |=3D 0x3;
> > +             value &=3D ~XGMAC4_TDPS;
> > +             value |=3D (3 << XGMAC4_TDPS_SHIFT) & XGMAC4_TDPS;
> > +             wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i, value);
> > +
> > +             value =3D rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i);
> > +             value &=3D ~XGMAC4_RXDCSZ;
> > +             value |=3D 0x3;
> > +             value &=3D ~XGMAC4_RDPS;
> > +             value |=3D (3 << XGMAC4_RDPS_SHIFT) & XGMAC4_RDPS;
> > +             wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i, value);
>
> I know that the TDPS/RDPS means Tx/Rx Descriptor Pre-fetch threshold
> Size. What does the TXDCSZ/RXDCSZ config mean?
>
> Most importantly why are these parameters hardcoded to 3? It
> doesn't seem right.
>
TXDCSZ/RXDCSZ are descriptor cache sizes.
I missed defining macros for valid values, for example 3 indicates 256 byte=
s.
Will fix it in the next update.

> > +     }
> > +
>
> > +     for (i =3D 0; i < PDMA_TX_CH_COUNT; i++) {
> > +             value =3D rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
> > +             value &=3D ~(XGMAC4_TXPBL | XGMAC4_TPBLX8_MODE);
> > +             if (dma_cfg->pblx8)
> > +                     value |=3D XGMAC4_TPBLX8_MODE;
> > +             value |=3D (dma_cfg->pbl << XGMAC4_TXPBL_SHIFT) & XGMAC4_=
TXPBL;
> > +             wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
> > +             xgmac4_tp2tc_map(ioaddr, i, i);
> > +     }
> > +
> > +     for (i =3D 0; i < PDMA_RX_CH_COUNT; i++) {
> > +             value =3D rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
> > +             value &=3D ~(XGMAC4_RXPBL | XGMAC4_RPBLX8_MODE);
> > +             if (dma_cfg->pblx8)
> > +                     value |=3D XGMAC4_RPBLX8_MODE;
> > +             value |=3D (dma_cfg->pbl << XGMAC4_RXPBL_SHIFT) & XGMAC4_=
RXPBL;
> > +             wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
> > +             if (i < PDMA_MAX_TC_COUNT)
> > +                     xgmac4_rp2tc_map(ioaddr, i, i);
> > +             else
> > +                     xgmac4_rp2tc_map(ioaddr, i, PDMA_MAX_TC_COUNT - 1=
);
> > +     }
>
> Shouldn't these initialization be done on the per-channel basis only
> for only activated queues
> plat_stmmacenet_data::{rx_queues_to_use,tx_queues_to_use} (the STMMAC
> driver one-on-one maps queues and DMA-channels if no custom mapping
> was specified)?
>
These are VDMA to PDMA mappings internal HDMA.
Even though it provides flexibility, a default any to any configuration is =
used.

> > +}
> > +
> > +void dwxgmac4_dma_init_tx_chan(struct stmmac_priv *priv,
> > +                            void __iomem *ioaddr,
> > +                            struct stmmac_dma_cfg *dma_cfg,
> > +                            dma_addr_t dma_addr, u32 chan)
> > +{
> > +     u32 value;
> > +
> > +     value =3D readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> > +     value &=3D ~XGMAC4_TVDMA2TCMP;
> > +     value |=3D (chan << XGMAC4_TVDMA2TCMP_SHIFT) & XGMAC4_TVDMA2TCMP;
> > +     writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> > +
> > +     writel(upper_32_bits(dma_addr),
> > +            ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
> > +     writel(lower_32_bits(dma_addr),
> > +            ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
> > +}
> > +
> > +void dwxgmac4_dma_init_rx_chan(struct stmmac_priv *priv,
> > +                            void __iomem *ioaddr,
> > +                            struct stmmac_dma_cfg *dma_cfg,
> > +                            dma_addr_t dma_addr, u32 chan)
> > +{
> > +     u32 value;
> > +
> > +     value =3D readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> > +     value &=3D ~XGMAC4_RVDMA2TCMP;
> > +     value |=3D (chan << XGMAC4_RVDMA2TCMP_SHIFT) & XGMAC4_RVDMA2TCMP;
> > +     writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> > +
> > +     writel(upper_32_bits(dma_addr),
> > +            ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
> > +     writel(lower_32_bits(dma_addr),
> > +            ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
> > +}
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h b/drivers/n=
et/ethernet/stmicro/stmmac/dwxgmac4.h
> > new file mode 100644
> > index 000000000000..0ce1856b0b34
> > --- /dev/null
>
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac4.h
>
> dw25gmac.h?
Will rename all applicable references to 25gmac.
>
> > @@ -0,0 +1,84 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/* Copyright (c) 2024 Broadcom Corporation
> > + * XGMAC4 definitions.
> > + */
> > +#ifndef __STMMAC_DWXGMAC4_H__
> > +#define __STMMAC_DWXGMAC4_H__
> > +
> > +/* DMA Indirect Registers*/
>
> > +#define XGMAC4_DMA_CH_IND_CONTROL    0X00003080
>
> XXVGMAC_*?
>
Thanks, Will use this prefix.

> > +#define XGMAC4_MODE_SELECT           GENMASK(27, 24)
> > +#define XGMAC4_MSEL_SHIFT            24
> > +enum dma_ch_ind_modes {
> > +     MODE_TXEXTCFG    =3D 0x0,   /* Tx Extended Config */
> > +     MODE_RXEXTCFG    =3D 0x1,   /* Rx Extended Config */
> > +     MODE_TXDBGSTS    =3D 0x2,   /* Tx Debug Status */
> > +     MODE_RXDBGSTS    =3D 0x3,   /* Rx Debug Status */
> > +     MODE_TXDESCCTRL  =3D 0x4,   /* Tx Descriptor control */
> > +     MODE_RXDESCCTRL  =3D 0x5,   /* Rx Descriptor control */
> > +};
> > +
> > +#define XGMAC4_ADDR_OFFSET           GENMASK(14, 8)
> > +#define XGMAC4_AOFF_SHIFT            8
> > +#define XGMAC4_AUTO_INCR             GENMASK(5, 4)
> > +#define XGMAC4_AUTO_SHIFT            4
> > +#define XGMAC4_CMD_TYPE                      BIT(1)
> > +#define XGMAC4_OB                    BIT(0)
> > +#define XGMAC4_DMA_CH_IND_DATA               0X00003084
> > +
> > +/* TX Config definitions */
> > +#define XGMAC4_TXPBL                 GENMASK(29, 24)
> > +#define XGMAC4_TXPBL_SHIFT           24
> > +#define XGMAC4_TPBLX8_MODE           BIT(19)
> > +#define XGMAC4_TP2TCMP                       GENMASK(18, 16)
> > +#define XGMAC4_TP2TCMP_SHIFT         16
> > +#define XGMAC4_ORRQ                  GENMASK(13, 8)
> > +/* RX Config definitions */
> > +#define XGMAC4_RXPBL                 GENMASK(29, 24)
> > +#define XGMAC4_RXPBL_SHIFT           24
> > +#define XGMAC4_RPBLX8_MODE           BIT(19)
> > +#define XGMAC4_RP2TCMP                       GENMASK(18, 16)
> > +#define XGMAC4_RP2TCMP_SHIFT         16
> > +#define XGMAC4_OWRQ                  GENMASK(13, 8)
> > +/* Tx Descriptor control */
> > +#define XGMAC4_TXDCSZ                        GENMASK(2, 0)
> > +#define XGMAC4_TDPS                  GENMASK(5, 3)
> > +#define XGMAC4_TDPS_SHIFT            3
> > +/* Rx Descriptor control */
> > +#define XGMAC4_RXDCSZ                        GENMASK(2, 0)
> > +#define XGMAC4_RDPS                  GENMASK(5, 3)
> > +#define XGMAC4_RDPS_SHIFT            3
> > +
> > +/* DWCXG_DMA_CH(#i) Registers*/
> > +#define XGMAC4_DSL                   GENMASK(20, 18)
> > +#define XGMAC4_MSS                   GENMASK(13, 0)
> > +#define XGMAC4_TFSEL                 GENMASK(30, 29)
> > +#define XGMAC4_TQOS                  GENMASK(27, 24)
> > +#define XGMAC4_IPBL                  BIT(15)
> > +#define XGMAC4_TVDMA2TCMP            GENMASK(6, 4)
> > +#define XGMAC4_TVDMA2TCMP_SHIFT              4
> > +#define XGMAC4_RPF                   BIT(31)
> > +#define XGMAC4_RVDMA2TCMP            GENMASK(30, 28)
> > +#define XGMAC4_RVDMA2TCMP_SHIFT              28
> > +#define XGMAC4_RQOS                  GENMASK(27, 24)
> > +
>
> > +/* PDMA Channel count */
> > +#define PDMA_TX_CH_COUNT             8
> > +#define PDMA_RX_CH_COUNT             10
> > +#define PDMA_MAX_TC_COUNT            8
> > +
> > +/* VDMA channel count */
> > +#define VDMA_TOTAL_CH_COUNT          32
>
> These seems like the vendor-specific constant. What are the actual DW
> 25GMAC constraints?
>
These are the limits for this device.
We can read these limits from hardware, I will fix it in the next patch.

> -Serge(y)
>
> > +
> > +void dwxgmac4_dma_init(void __iomem *ioaddr,
> > +                    struct stmmac_dma_cfg *dma_cfg, int atds);
> > +
> > +void dwxgmac4_dma_init_tx_chan(struct stmmac_priv *priv,
> > +                            void __iomem *ioaddr,
> > +                            struct stmmac_dma_cfg *dma_cfg,
> > +                            dma_addr_t dma_addr, u32 chan);
> > +void dwxgmac4_dma_init_rx_chan(struct stmmac_priv *priv,
> > +                            void __iomem *ioaddr,
> > +                            struct stmmac_dma_cfg *dma_cfg,
> > +                            dma_addr_t dma_addr, u32 chan);
> > +#endif /* __STMMAC_DWXGMAC4_H__ */
> > --
> > 2.34.1
> >
> >

