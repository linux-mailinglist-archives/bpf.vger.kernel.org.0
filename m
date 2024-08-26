Return-Path: <bpf+bounces-38096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C5295F93D
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 20:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD08F1F2222D
	for <lists+bpf@lfdr.de>; Mon, 26 Aug 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF401990BD;
	Mon, 26 Aug 2024 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TDIuSUNO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B498002A
	for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724698408; cv=none; b=oz+7kc+itcJ8akanqWb68zCGqAfOlXvrw+jQKkwQgJTPIYPX3+1P1K6wVESQPu58ok2vwIG2bx891+3bHFM00x78Rnv06Kto2hDOBG3RIRzrVByg3JsbDNUiwEkq0v9nxTne1iuowSb5aIzB+rQNbpvS6iu9oxPgNX43kkAaXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724698408; c=relaxed/simple;
	bh=t5/zB9BSuAxB1nO7r8cDk3j0lFCwrqEuE/UDhsWupEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxnUnRor0oRKEO6HnFerWIAumbXFzh3+v2+h1H8LY0OznvxEwy12PVRrZnvuPl7K8S0l8uEewQ4ratZhHnvTmfIKlVsZMbL/47Z4kBBjwEb/deOwBCdfXhxkAtZLUUcVHknFFhYqdaA6K1rk+fvSa9llJqROIy6C6DHDu6knl0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TDIuSUNO; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d60f48a2ccso3840650a91.3
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724698405; x=1725303205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vPKu5kyckfAGlfhdEVa0KBQG1dFiWf+7mfGcbWhMwU=;
        b=TDIuSUNOfyOit8WB54kDWtsUGgQ/c5QN6dJlmL33s+nJf+RCtsq3AZF8L5H10jmmAs
         vANrP2xEVKuScRe8s+yzMKO5uLTa0x2ALyYRkci4+h9693zO+ynQ5xxUlDSjemntqkEN
         HISsOl/gRqgT4cffY7aee5ZzKezTlP1yS+Kfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724698405; x=1725303205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vPKu5kyckfAGlfhdEVa0KBQG1dFiWf+7mfGcbWhMwU=;
        b=pNA4ZcJVT2P1Q6yq4vggWikEYqeHtNnQfrdUjq5GcKYCOWyW0m6QdxhvtpSC4aYCA6
         IDOLq3kVIRM20a3pO9GFGCOXqkUUyIHUAMlnp2+tV7Uwd2LJvcHqfyyfZtcMVt9GOpGs
         AlP2atSCWqNr4XdXC67d+sJbpIu0osPcJG+Y9QZJVH9z5k84aljej/ckNUhXeBXWuY1T
         GhrKGo8MJnPnEBAsD+Rt8JGjH90a4ej8PHUFgOhYF38t4k6DcwaHWbY4aaanCLxOBdUC
         CHfzoaZNjcFQ0fCELjEUGCZRwVcJfGYOsEikzI93PECQcSdmAnfQJ4YOJP1xRYifIOqq
         bGDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI7l1q4/AYolKT6/4OQfKC4V7eVk6BMU2gcjpMO8xxSqKMMvhxnWt6ljw8Vy8lzfO0l3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysj5qoSuIo0AN8sNuOOQngYaIityXq/y/6GKME3wtEfHWgeZ4c
	0IYpyY0O/1JCxW5IcadbeDG1T0F4hy4CNbJ2uo8kAo2yxPaAQOOXHvj57LEdZn8tqCHFW7iMpv+
	pUwf8piZabV/Q8qC/iW1wsrVP+UmZ/7FKWyM0
X-Google-Smtp-Source: AGHT+IELe1qaUfmRGw8MR4uzHkXLikT+gDWeyOsCy/CEzW9EyaONPESoDrYYg0teDP/A3SCH2C2SXGzEd9PBAnpho8g=
X-Received: by 2002:a17:90a:8983:b0:2cb:4f14:2a70 with SMTP id
 98e67ed59e1d1-2d646d2483amr11893442a91.30.1724698405175; Mon, 26 Aug 2024
 11:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-4-jitendra.vegiraju@broadcom.com> <vxpwwstbvbruaafcatq5zyi257hf25x5levct3y7s7ympcsqvh@b6wmfkd4cxfy>
In-Reply-To: <vxpwwstbvbruaafcatq5zyi257hf25x5levct3y7s7ympcsqvh@b6wmfkd4cxfy>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Mon, 26 Aug 2024 11:53:13 -0700
Message-ID: <CAMdnO-LDw0OZRfBWmh_4AEYuwbq6dmnh=W3PZwRe1766Ys2huA@mail.gmail.com>
Subject: Re: [net-next v4 3/5] net: stmmac: Integrate dw25gmac into stmmac
 hwif handling
To: Serge Semin <fancer.lancer@gmail.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk, 
	ahalaney@redhat.com, xiaolei.wang@windriver.com, rohan.g.thomas@intel.com, 
	Jianheng.Zhang@synopsys.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	linux@armlinux.org.uk, horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Serge(y)
Thank you for reviewing the patch.

On Fri, Aug 23, 2024 at 6:49=E2=80=AFAM Serge Semin <fancer.lancer@gmail.co=
m> wrote:
>
> Hi Jitendra
>
> On Wed, Aug 14, 2024 at 03:18:16PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > Integrate dw25gmac support into stmmac hardware interface handling.
> > Added a new entry to the stmmac_hw table in hwif.c.
> > Define new macros DW25GMAC_CORE_4_00 and DW25GMAC_ID to identify 25GMAC
> > device.
> > Since BCM8958x is an early adaptor device, the synopsis_id reported in =
HW
> > is 0x32 and device_id is DWXGMAC_ID. Provide override support by defini=
ng
> > synopsys_dev_id member in struct stmmac_priv so that driver specific se=
tup
> > functions can override the hardware reported values.
> >
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/common.h |  2 ++
> >  drivers/net/ethernet/stmicro/stmmac/hwif.c   | 25 ++++++++++++++++++--
> >  drivers/net/ethernet/stmicro/stmmac/stmmac.h |  1 +
> >  3 files changed, 26 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net=
/ethernet/stmicro/stmmac/common.h
> > index 684489156dce..46edbe73a124 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> > @@ -38,9 +38,11 @@
> >  #define DWXGMAC_CORE_2_10    0x21
> >  #define DWXGMAC_CORE_2_20    0x22
> >  #define DWXLGMAC_CORE_2_00   0x20
> > +#define DW25GMAC_CORE_4_00   0x40
> >
> >  /* Device ID */
> >  #define DWXGMAC_ID           0x76
> > +#define DW25GMAC_ID          0x55
> >  #define DWXLGMAC_ID          0x27
> >
> >  #define STMMAC_CHAN0 0       /* Always supported and default for all c=
hips */
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/e=
thernet/stmicro/stmmac/hwif.c
> > index 29367105df54..97e5594ddcda 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > @@ -278,6 +278,27 @@ static const struct stmmac_hwif_entry {
> >               .est =3D &dwmac510_est_ops,
> >               .setup =3D dwxlgmac2_setup,
> >               .quirks =3D stmmac_dwxlgmac_quirks,
>
> > +     }, {
> > +             .gmac =3D false,
> > +             .gmac4 =3D false,
> > +             .xgmac =3D true,
> > +             .min_id =3D DW25GMAC_CORE_4_00,
> > +             .dev_id =3D DW25GMAC_ID,
> > +             .regs =3D {
> > +                     .ptp_off =3D PTP_XGMAC_OFFSET,
> > +                     .mmc_off =3D MMC_XGMAC_OFFSET,
> > +                     .est_off =3D EST_XGMAC_OFFSET,
> > +             },
> > +             .desc =3D &dwxgmac210_desc_ops,
> > +             .dma =3D &dw25gmac400_dma_ops,
> > +             .mac =3D &dwxgmac210_ops,
> > +             .hwtimestamp =3D &stmmac_ptp,
> > +             .mode =3D NULL,
> > +             .tc =3D &dwmac510_tc_ops,
> > +             .mmc =3D &dwxgmac_mmc_ops,
> > +             .est =3D &dwmac510_est_ops,
> > +             .setup =3D dwxgmac2_setup,
> > +             .quirks =3D NULL,
> >       },
>
> This can be replaced with just:
>
> +       }, {
> +               .gmac =3D false,
> +               .gmac4 =3D false,
> +               .xgmac =3D true,
> +               .min_id =3D DW25GMAC_CORE_4_00,
> +               .dev_id =3D DWXGMAC_ID, /* Early DW 25GMAC IP-core had XG=
MAC ID */
> +               .regs =3D {
> +                       .ptp_off =3D PTP_XGMAC_OFFSET,
> +                       .mmc_off =3D MMC_XGMAC_OFFSET,
> +                       .est_off =3D EST_XGMAC_OFFSET,
> +               },
> +               .desc =3D &dwxgmac210_desc_ops,
> +               .dma =3D &dw25gmac400_dma_ops,
> +               .mac =3D &dwxgmac210_ops,
> +               .hwtimestamp =3D &stmmac_ptp,
> +               .mode =3D NULL,
> +               .tc =3D &dwmac510_tc_ops,
> +               .mmc =3D &dwxgmac_mmc_ops,
> +               .est =3D &dwmac510_est_ops,
> +               .setup =3D dw25gmac_setup,
> +               .quirks =3D NULL,
>         }
>
> and you won't need to pre-define the setup() method in the
> glue driver. Instead you can define a new dw25xgmac_setup() method in
> the dwxgmac2_core.c as it's done for the DW XGMAC/LXGMAC IP-cores.
>
> Note if your device is capable to work with up to 10Gbps speed, then
> just set the plat_stmmacenet_data::max_speed field to SPEED_10000.
> Alternatively if you really need to specify the exact MAC
> capabilities, then you can implement what Russell suggested here
> sometime ago:
> https://lore.kernel.org/netdev/Zf3ifH%2FCjyHtmXE3@shell.armlinux.org.uk/
>
I like your suggestion to add one stmmac_hw[] array entry (entry_a) for thi=
s
"early release" DW25GMAC IP and another entry (entry_b) for final DW25MAC
IP, in the process eliminate the need for a new member variable in struct
stmmac_priv.

However, I would like to bring to your attention that this device requires
special handling for both synopsys_id and dev_id.
This device is reporting 0x32 for synopsys_id and 0x76(XGMAC) for dev_id.
The final 25GMAC spec will have 0x40 for synopsys_id and 0x55(25GMAC) for
dev_id.

So, in order to avoid falsely qualifying other XGMAC devices with
synopsis_id >=3D0x32 as DW25GMAC, I am thinking we will have to overwrite t=
he
synopsys_id to 0x40 (DW25GMAC_CORE_4_00) in glue driver using existing
glue driver override mechanism.

We can implement dw25gmac_setup() in dwxgmac2_core.c for generic 25GMAC
case. But, this glue driver will have to rely on its own setup function
to override the synopsys_id as DW25GMAC_CORE_4_00.

Do you think it looks reasonable?
If yes, do you want me to add the generic 25GMAC stmmac_hw[] entry
("entry_b") now or when
such a device becomes available for testing?

> If you also have a DW 25GMAC-based device with 0x55 device ID, then
> just add another stmmac_hw[] array entry.
>

> >  };
> >
> >       int hw_cap_support;
> >       int synopsys_id;
>
> > +     int synopsys_dev_id;
>
> With the suggestion above implemented you won't need this.

Got it. Thanks.

>
> -Serge(y)
>
> >       u32 msg_enable;
> >       int wolopts;
> >       int wol_irq;
> > --
> > 2.34.1
> >

