Return-Path: <bpf+bounces-37657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D389590EC
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 01:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6F8285317
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F356A1C8FBE;
	Tue, 20 Aug 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LQCWaqjW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5617107A0
	for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195454; cv=none; b=fkAqVXy5iCSauTRPGEyE+pmAkcWTXhWOnJ6EcC83goCy4/TO/rD4L8TDdwF45AjATIe9EnNFywt8QBJkrHEyPfLjTfRu4YYun+m9UAX5+JtI2jIPcfHGdRhq8KNKgYqH5oOOHRdyvyCcgUil1sfzwHL1kY3TaPHJDmNSAIRyBnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195454; c=relaxed/simple;
	bh=XtIk+kD00iSoE4z1imrAKe0aG7GWpS0xE5lCIpWyzeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guYVLPPd9deeE8/7fdncVszmptwBNvmBJCSpK1g7VAdqY4J3KwAfzd7zEA6vIeEx0K6Do/J1fLQFfx6lG9nfeRcfsIeeqAB1yXCIhm8f1n4Pau/v87DgiuEaGv9lRQnP2zRqLQdcf26l8Nmdqzc4g0tOimpqylhTwNXHMnjuJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LQCWaqjW; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d46f2816c0so1372695a91.2
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2024 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724195452; x=1724800252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5f2w4LZM4TRAbHrkXGO8wWfBGvh6M9E2Z4iDQZHMiQ=;
        b=LQCWaqjW3jMllS3ufVvAiGnmAc6diNGBEd+xGKCw7FLeDOd9d7V1IPEZVr6deKV2Me
         BnLOnEYsAKh/B3zxoTAi7xYkjmQicJN3VV2xGpXP10lk8fhhPorg6rRfni2MDHcMJVBT
         YL7u/gyIigf4kdvqDFbUpieptzTsgP6vLrwqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724195452; x=1724800252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z5f2w4LZM4TRAbHrkXGO8wWfBGvh6M9E2Z4iDQZHMiQ=;
        b=Uonmocna0wqFHFJhgZcfunucd7l9tniLlaXA4jdM/K5yaZjiar0E9KgA23ta5d/tX4
         qbZTpAoZiz6R2G8aFSwoR7GDHOf0SL48eQL0W1GHo2jaF4/Aa4V7WGgzQjpCcht2TT0N
         8MEvQZY7janyOeJKk1Ml9v+PSoYW9oNEjxqHOONEEkv+OkoPvHr79I51eqJ0Je6q86Rs
         2bEtsNaWC3xNRnitVwfwxiQu283e5C4hcogNsmcb3/GnwhMttvO5UmRUbRbM0E+o1+GI
         df3s+I7ndIHbPMnxv8TYtMTvoQZ03tPKln1EGHqFFYiOWmAFAQrylyGvzlrw0AnOxiLB
         SURw==
X-Forwarded-Encrypted: i=1; AJvYcCXmJhgHeoeanw7Cx1G5jP97XJ3Q0As9FYI2iN6wDZwbjJvygFUG7RQABKEH81CL+DLqhI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPaN3VcPNGsxt4wriodqN4L4wAqf3z2squ+4IjkXt0/L1Eq+Tw
	STuihGcfU9gmrpFMeKh2F2EKwDr0ZqN6tAJSEOUXfGC6a03Qaf/utdEXKO9aNAkdnT2IFxyvrBF
	BijfAUF42k2UuoWcZMND5cWL34WXudat+pSUn
X-Google-Smtp-Source: AGHT+IFGNMXXmYcdXaQzr5Tz8USVmNU5xbNdMKeKaadN4lTbxlZnVc1egcdct5/lyGa8CAVi5X81ldwsfwop3kkiM1o=
X-Received: by 2002:a17:90b:23d3:b0:2c9:321:1bf1 with SMTP id
 98e67ed59e1d1-2d5e9ed08f1mr498981a91.39.1724195452084; Tue, 20 Aug 2024
 16:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-2-jitendra.vegiraju@broadcom.com> <2ad03012-8a10-49fc-9e80-3b91762b9cc3@quicinc.com>
In-Reply-To: <2ad03012-8a10-49fc-9e80-3b91762b9cc3@quicinc.com>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Tue, 20 Aug 2024 16:10:40 -0700
Message-ID: <CAMdnO-LH0xNeMO_Y+WhSmbyNrK33zb=AtVd9ZRTObQ-n8BWR6w@mail.gmail.com>
Subject: Re: [net-next v4 1/5] net: stmmac: Add HDMA mapping for dw25gmac support
To: "Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com, 
	rmk+kernel@armlinux.org.uk, ahalaney@redhat.com, xiaolei.wang@windriver.com, 
	rohan.g.thomas@intel.com, Jianheng.Zhang@synopsys.com, 
	leong.ching.swee@intel.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com, 
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:30=E2=80=AFPM Abhishek Chauhan (ABC)
<quic_abchauha@quicinc.com> wrote:
>
>
>
> On 8/14/2024 3:18 PM, jitendra.vegiraju@broadcom.com wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > Add hdma configuration support in include/linux/stmmac.h file.
> > The hdma configuration includes mapping of virtual DMAs to physical DMA=
s.
> > Define a new data structure stmmac_hdma_cfg to provide the mapping.
> >
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > ---
> >  include/linux/stmmac.h | 50 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 338991c08f00..1775bd2b7c14 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -89,6 +89,55 @@ struct stmmac_mdio_bus_data {
> >       bool needs_reset;
> >  };
> >
> > +/* DW25GMAC Hyper-DMA Overview
> > + * Hyper-DMA allows support for large number of Virtual DMA(VDMA)
> > + * channels using a smaller set of physical DMA channels(PDMA).
> > + * This is supported by the  mapping of VDMAs to Traffic Class (TC)
> > + * and PDMA to TC in each traffic direction as shown below.
> > + *
> > + *        VDMAs            Traffic Class      PDMA
> > + *       +--------+          +------+         +-----------+
> > + *       |VDMA0   |--------->| TC0  |-------->|PDMA0/TXQ0 |
> > + *TX     +--------+   |----->+------+         +-----------+
> > + *Host=3D> +--------+   |      +------+         +-----------+ =3D> MAC
> > + *SW     |VDMA1   |---+      | TC1  |    +--->|PDMA1/TXQ1 |
> > + *       +--------+          +------+    |    +-----------+
> > + *       +--------+          +------+----+    +-----------+
> > + *       |VDMA2   |--------->| TC2  |-------->|PDMA2/TXQ1 |
> > + *       +--------+          +------+         +-----------+
> > + *            .                 .                 .
> > + *       +--------+          +------+         +-----------+
> > + *       |VDMAn-1 |--------->| TCx-1|-------->|PDMAm/TXQm |
> > + *       +--------+          +------+         +-----------+
> > + *
> > + *       +------+          +------+         +------+
> > + *       |PDMA0 |--------->| TC0  |-------->|VDMA0 |
> > + *       +------+   |----->+------+         +------+
> > + *MAC =3D> +------+   |      +------+         +------+
> > + *RXQs   |PDMA1 |---+      | TC1  |    +--->|VDMA1 |  =3D> Host
> > + *       +------+          +------+    |    +------+
> > + *            .                 .                 .
> > + */
> > +
> > +#define STMMAC_DW25GMAC_MAX_NUM_TX_VDMA              128
> > +#define STMMAC_DW25GMAC_MAX_NUM_RX_VDMA              128
> > +
> > +#define STMMAC_DW25GMAC_MAX_NUM_TX_PDMA              8
> > +#define STMMAC_DW25GMAC_MAX_NUM_RX_PDMA              10
> > +
> I have a query here.
>
> Why do we need to hardcode the number of TX PDMA and RX PDMA to 8 an 10. =
On some platforms the number of supported TXPDMA and RXPDMA are 11 and 11 r=
espectively ?
>
> how do we overcome this problem, do we increase the value in such case?
>
Hi Abhishek,
Agreed, we can make the mapping tables more generic.
We will replace static arrays with dynamically allocated memory by
reading the TXPDMA and RXPDMA counts from hardware.
Thanks
> > +#define STMMAC_DW25GMAC_MAX_TC                       8
> > +
> > +/* Hyper-DMA mapping configuration
> > + * Traffic Class associated with each VDMA/PDMA mapping
> > + * is stored in corresponding array entry.
> > + */
> > +struct stmmac_hdma_cfg {
> > +     u8 tvdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_VDMA];
> > +     u8 rvdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_VDMA];
> > +     u8 tpdma_tc[STMMAC_DW25GMAC_MAX_NUM_TX_PDMA];
> > +     u8 rpdma_tc[STMMAC_DW25GMAC_MAX_NUM_RX_PDMA];
> > +};
> > +
> >  struct stmmac_dma_cfg {
> >       int pbl;
> >       int txpbl;
> > @@ -101,6 +150,7 @@ struct stmmac_dma_cfg {
> >       bool multi_msi_en;
> >       bool dche;
> >       bool atds;
> > +     struct stmmac_hdma_cfg *hdma_cfg;
> >  };
> >
> >  #define AXI_BLEN     7

