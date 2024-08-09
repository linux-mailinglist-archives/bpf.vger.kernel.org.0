Return-Path: <bpf+bounces-36750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7F094C7F4
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 03:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DAF1C21D2C
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 01:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40412947A;
	Fri,  9 Aug 2024 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B+q5sEgz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96279DC
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166281; cv=none; b=X/zRNJusNAyjL3ulIRXZxQq5IZrcXfMoh1cmep0AvPxCUmUWD3vNDGSqB5IMSToDlfZSD6djvAbLVU3/PKSl6RfFp1OQaElIN1o/KrjK1ds6fhWsByKKXbMbSDNB4dOxvWo0e512RXmRduYF//53Kb95gWsKiXa5xPWYOU80wJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166281; c=relaxed/simple;
	bh=fFC+qYwoV2Q72npaQGdXSkqHHWNAjvlZJl/XYpdPq08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZkaha1X2SfwAKR/qBxs+oq9VDhtaZN7vpYMVNOMQxZ2xQR1bvwbLW08Pyw5P86rXuDnFBASZlGq3S/132Z9jwDzoiThLaojNy4i7cpz2pSGImWJFJymMo0UWTQQTXO7FDAco9JXfW4s7x5AInaGWVIW1Nxvs+a6alvtIooQ8Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=B+q5sEgz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2caff99b1c9so1343018a91.3
        for <bpf@vger.kernel.org>; Thu, 08 Aug 2024 18:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723166278; x=1723771078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYjZjdBTBIdPAqpSrjlxhCk8adkJQbZPHoFFyYw0PrE=;
        b=B+q5sEgzUqkrFX3PC5naZwNMR5+LfMcEgycGqNuBA6VW3awhLBw0MrW5auUbfi9E61
         cLblYZub+r38TvzIz7Uz+Futsy1sEbFZ3FtfyhXqxb+xWxYvI+KXjpu+on6RNVDlNgau
         If2W9lMUiTTC2A6Tv2Gu7acrWAviS2x3XfG/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723166278; x=1723771078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYjZjdBTBIdPAqpSrjlxhCk8adkJQbZPHoFFyYw0PrE=;
        b=Mim6JaZDYT2icg47e/AYgimo204nMUFNoeDjrcZo7TvZBEiVMOE1tDdYS/r6eg2XuU
         ZvzzfohQEcQcGBYB+vKnLJzgKKAIuaDRY99NX8ozcRN5b4CWefnZm7pVPnl41OrBDPds
         b41RCXNj6AjdUZvM/i5Eiz7d8ZUrNWZsERDiXt8HWxRG/2T1O9axaSbXEUNHPHl9vdUz
         gfjDQ1IWRUv0A7bd35Nm7AdYG2zrM422NqpmhmyE3FUS2TmlVoUhFYmdM0cvT4Zb2tfS
         pMs72/TdVuZMfMzlKvaDAbNKVvQ+iA1p1LaKDnm28Pt/urpwM/YA584Rl2/iav9d0lAy
         MkWA==
X-Forwarded-Encrypted: i=1; AJvYcCXQBXeKxcHy84mrSctNbEKW7vGqck/y/Wanioc1EMwVVOdgDEf6akctjZ28RCCS4GPBUkLG1DgQYKpFQDBiIRDbNqVi
X-Gm-Message-State: AOJu0YxnfhdgmJJ/ILXGRZFixet5wnqmqpjOaH9jhQ6PMNJYw2zLbCBe
	K5r00UuyTE/5rjhSnFiGBJEAdDKnSraCCVC6dNf1tXrJXRc5UjBb+qtOtq+nGolewfpQibIVk8P
	/61F0iOZbrQLtvia5jZdy/fsmnjdSTmPjlzQV
X-Google-Smtp-Source: AGHT+IGNeU+mZ526KJrVKkT/3A9XbhnFswO1iznJt7mrN23m/4oIDjcjgcAyOQgmchZLh8UGBltbebeLSCY6/iXwh8A=
X-Received: by 2002:a17:90a:2c01:b0:2c9:9c25:757b with SMTP id
 98e67ed59e1d1-2d1c34707a0mr4459915a91.39.1723166278248; Thu, 08 Aug 2024
 18:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-3-jitendra.vegiraju@broadcom.com> <o4dgczjefqjek3iqw2y3ca7pwolj5e6otjyuinpuvkwcli5xei@dzehe7xde44x>
In-Reply-To: <o4dgczjefqjek3iqw2y3ca7pwolj5e6otjyuinpuvkwcli5xei@dzehe7xde44x>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Thu, 8 Aug 2024 18:17:47 -0700
Message-ID: <CAMdnO-JUkMvoB8yiJqDFLnmCvchsTdBvf0G+Rtcov6YTdh_BVQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: stmmac: Integrate dwxgmac4 into
 stmmac hwif handling
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

Hi Serge
On Tue, Aug 6, 2024 at 3:14=E2=80=AFPM Serge Semin <fancer.lancer@gmail.com=
> wrote:
>
> On Thu, Aug 01, 2024 at 08:18:21PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> >
> > Integrate dwxgmac4 support into stmmac hardware interface handling.
> > A dwxgmac4 is an xgmac device and hence it inherits properties from
> > existing stmmac_hw table entry.
> > The quirks handling facility is used to update dma_ops field to
> > point to dwxgmac400_dma_ops when the user version field matches.
> >
> > Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/common.h |  4 +++
> >  drivers/net/ethernet/stmicro/stmmac/hwif.c   | 26 +++++++++++++++++++-
> >  drivers/net/ethernet/stmicro/stmmac/hwif.h   |  1 +
> >  3 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net=
/ethernet/stmicro/stmmac/common.h
> > index cd36ff4da68c..9bf278e11704 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> > @@ -37,11 +37,15 @@
> >  #define DWXGMAC_CORE_2_10    0x21
> >  #define DWXGMAC_CORE_2_20    0x22
> >  #define DWXLGMAC_CORE_2_00   0x20
>
> > +#define DWXGMAC_CORE_4_00    0x40
>
> DW25GMAC_CORE_4_00?
Will do.
>
> >
> >  /* Device ID */
> >  #define DWXGMAC_ID           0x76
>
> What is the device ID in your case? Does it match to DWXGMAC_ID?
The early adopter 25MAC IP core used on this has 0x76.
But, synopsis confirmed the 25GMAC is assigned with value 0x55.
Will define DW25MAC_ID 0x55 and use it for 25GMAC hw_if entry.
However, we would like to get a suggestion for dealing with this early
adopter device_id number.
Can we add override mechanism by defining device_id in stmmac_priv
structure and let the hardware specific setup function in the glue
driver update the device_id to 0x55 function?

>
> >  #define DWXLGMAC_ID          0x27
> >
> > +/* User Version */
> > +#define DWXGMAC_USER_VER_X22 0x22
> > +
> >  #define STMMAC_CHAN0 0       /* Always supported and default for all c=
hips */
> >
> >  /* TX and RX Descriptor Length, these need to be power of two.
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.c b/drivers/net/e=
thernet/stmicro/stmmac/hwif.c
> > index 29367105df54..713cb5aa2c3e 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.c
> > @@ -36,6 +36,18 @@ static u32 stmmac_get_dev_id(struct stmmac_priv *pri=
v, u32 id_reg)
> >       return (reg & GENMASK(15, 8)) >> 8;
> >  }
> >
>
> > +static u32 stmmac_get_user_version(struct stmmac_priv *priv, u32 id_re=
g)
> > +{
> > +     u32 reg =3D readl(priv->ioaddr + id_reg);
> > +
> > +     if (!reg) {
> > +             dev_info(priv->device, "User Version not available\n");
> > +             return 0x0;
> > +     }
> > +
> > +     return (reg & GENMASK(23, 16)) >> 16;
> > +}
> > +
>
> The User Version is purely a vendor-specific stuff defined on the
> IP-core synthesis stage. Moreover I don't see you'll need it anyway.
>
Yes, we don't need this function with the 25GMAC entry.
> >  static void stmmac_dwmac_mode_quirk(struct stmmac_priv *priv)
> >  {
> >       struct mac_device_info *mac =3D priv->hw;
> > @@ -82,6 +94,18 @@ static int stmmac_dwmac4_quirks(struct stmmac_priv *=
priv)
> >       return 0;
> >  }
> >
>
> > +static int stmmac_dwxgmac_quirks(struct stmmac_priv *priv)
> > +{
> > +     struct mac_device_info *mac =3D priv->hw;
> > +     u32 user_ver;
> > +
> > +     user_ver =3D stmmac_get_user_version(priv, GMAC4_VERSION);
> > +     if (priv->synopsys_id =3D=3D DWXGMAC_CORE_4_00 &&
> > +         user_ver =3D=3D DWXGMAC_USER_VER_X22)
> > +             mac->dma =3D &dwxgmac400_dma_ops;
> > +     return 0;
> > +}
> > +
Will remove this function.
> >  static int stmmac_dwxlgmac_quirks(struct stmmac_priv *priv)
> >  {
> >       priv->hw->xlgmac =3D true;
> > @@ -256,7 +280,7 @@ static const struct stmmac_hwif_entry {
> >               .mmc =3D &dwxgmac_mmc_ops,
> >               .est =3D &dwmac510_est_ops,
> >               .setup =3D dwxgmac2_setup,
> > -             .quirks =3D NULL,
> > +             .quirks =3D stmmac_dwxgmac_quirks,
>
> Why? You can just introduce a new stmmac_hw[] entry with the DW
> 25GMAC-specific stmmac_dma_ops instance specified.
>
Will do.
> -Serge(y)
>
> >       }, {
> >               .gmac =3D false,
> >               .gmac4 =3D false,
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/e=
thernet/stmicro/stmmac/hwif.h
> > index e53c32362774..6213c496385c 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> > @@ -683,6 +683,7 @@ extern const struct stmmac_desc_ops dwxgmac210_desc=
_ops;
> >  extern const struct stmmac_mmc_ops dwmac_mmc_ops;
> >  extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
> >  extern const struct stmmac_est_ops dwmac510_est_ops;
> > +extern const struct stmmac_dma_ops dwxgmac400_dma_ops;
> >
> >  #define GMAC_VERSION         0x00000020      /* GMAC CORE Version */
> >  #define GMAC4_VERSION                0x00000110      /* GMAC4+ CORE Ve=
rsion */
> > --
> > 2.34.1
> >
> >

