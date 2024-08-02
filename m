Return-Path: <bpf+bounces-36320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2390946534
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 23:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FF61C212B7
	for <lists+bpf@lfdr.de>; Fri,  2 Aug 2024 21:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3A7136982;
	Fri,  2 Aug 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ei67T59A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB455132111
	for <bpf@vger.kernel.org>; Fri,  2 Aug 2024 21:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634998; cv=none; b=WmNvb++jx2qkgvYSWwhPYCUwBZomqg+wJxcgEn/5qcjgHY6fwlhVG3OviPz84ngoSOmOMRofZDrgDzOx/QsUXYmWYkNAOg82bm/0TxuYvkvWok8XVvQeHA8cplWjYPTf+vyXXlzg3BuCVQfEIiym49PnkW3M6uRixQjeYtOxmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634998; c=relaxed/simple;
	bh=SfOTiz9UY3pucISMWMj/A6XFiE2X8f0Ut6NVQ49nh+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FnTvPdIL+w70/Xx8jSYoCMEUhykiNd3o8jz4Tg3bWEV4NEQVJKEiCQXM+Mm55tBpc/ZKHubAJcLt2+qtHPWuk3pPReuPAf/RQhEvhJ805Xnky8B591ChZM1b0Qm++nmr9804FLXa0GIZaGRUkalHydnbTB2/sBJAYbqaiv40mD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ei67T59A; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cfdc4deeecso2637298a91.3
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 14:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722634996; x=1723239796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vMHdVSrXJF8XYak0iSBlyxgzNiJzotPPn7gmZpMrkY=;
        b=ei67T59AhJNLsNB92VV0LsJzKYSMuFYpei/IuoB009+2g/+3vb+mfhr2qJHLCrjxrQ
         Euiy7W0129Ai+Hj0CoB9i7iX2Nn+X/NUy3+XuB1j8Ga8OUfHjlSrpRh4vwTQuQwRQ/4t
         euh1Lv6gBx2QI+lWvmXZDfYjRHtMjpkJY016Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634996; x=1723239796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vMHdVSrXJF8XYak0iSBlyxgzNiJzotPPn7gmZpMrkY=;
        b=OmJSTjveVanXvvMGPXoAuZVRqZE//ATFUpMxabjFTYOHajD7k7yMr3CB7U72fNaolI
         la9mxzIdVggcXrT/LXko1w97MoBaJ0HEsIb1NygsFNlg68/5mSh/ETsn2BRT8AF8jQQh
         rxTa/t6FkxrzZe2/KeOo138tTKvTUFyb3MNsalUenSMvadFWdpLJXGbm9zvMW1cCNRYm
         HC73kEB2OIOsa9obDACqVnO6tN06fI+2e57G82bZFfAYzClLzevKX+Lj2VNb1tLSzYxB
         3ODVr2NQboA2Pi5854u+M4qiirh76RvUDrinx9+bPmVZOsWzlfxUd5a6kewPK6uFl1J7
         PQcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh7CARvuU4tjkQqVW5SxEo+Vs/HnQRQwk6Ys0QzZQn9yDI/7kAcJyD6mN9L4qMFpJSLNUrwc3g7XolFeHfgvFZYysN
X-Gm-Message-State: AOJu0Yw3ro7M4XB/YynYq6HGptm99N77Y8k3oUYBU8uhWiijeUuBcumZ
	KpF7kKK56YCbwINPz2TLIrjqiT9AsaUUP2aO5YUfOo5K9rjMsDOuMG1IYoRLYPAxg01dpFQvbcO
	aIJ2W0mPf6LOvadTgv/MPoa3JNc81OKvqWa2M
X-Google-Smtp-Source: AGHT+IEtvLrcXhCLETX+9N9XQkX7L9HzPL+GHPynwB9luwQ69BeemNXYJLs+adSVkzdD9GLwGnf0wExUCNvvTJfPf+s=
X-Received: by 2002:a17:90a:f02:b0:2cd:ba3e:38a5 with SMTP id
 98e67ed59e1d1-2cff9469006mr5802105a91.21.1722634996112; Fri, 02 Aug 2024
 14:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802031822.1862030-1-jitendra.vegiraju@broadcom.com>
 <20240802031822.1862030-2-jitendra.vegiraju@broadcom.com> <ZqyXE0XJkn+Of6rR@shell.armlinux.org.uk>
In-Reply-To: <ZqyXE0XJkn+Of6rR@shell.armlinux.org.uk>
From: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
Date: Fri, 2 Aug 2024 14:43:05 -0700
Message-ID: <CAMdnO-+_w=XTE7TPv-b6RtAbjK1CC9jgf1kukmg9W-_0Dj8O2A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] net: stmmac: Add basic dwxgmac4 support
 to stmmac core
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com, 
	richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, andrew@lunn.ch, 
	horms@kernel.org, florian.fainelli@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for reposting, resending the reply since I missed reply to all.

On Fri, Aug 2, 2024 at 1:21=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 01, 2024 at 08:18:20PM -0700, jitendra.vegiraju@broadcom.com =
wrote:
> > +static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
> > +{
> > +     u32 reg_val =3D 0;
> > +     u32 val =3D 0;
>
> val is unnecessary.
True, I will fix it.
>
> > +
> > +     reg_val |=3D mode << XGMAC4_MSEL_SHIFT & XGMAC4_MODE_SELECT;
>
> Consider using:
>
>         reg_val |=3D FIELD_PREP(XGMAC4_MODE_SELECT, mode);
>
Thanks, I will make the changes.

> and similarly everywhere else you use a shift and mask. With this, you
> can remove _all_ _SHIFT definitions in your header file.
>
> > +     reg_val |=3D channel << XGMAC4_AOFF_SHIFT & XGMAC4_ADDR_OFFSET;
> > +     reg_val |=3D XGMAC4_CMD_TYPE | XGMAC4_OB;
> > +     writel(reg_val, ioaddr + XGMAC4_DMA_CH_IND_CONTROL);
> > +     val =3D readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);
> > +     return val;
>
>         return readl(ioaddr + XGMAC4_DMA_CH_IND_DATA);
>
> ...
>
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
>
> What if dma_cfg doesn't have these bits set? Is it possible they will be
> set in the register?
The reset default for these bits is zero.
>
> Thanks.
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

