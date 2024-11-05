Return-Path: <bpf+bounces-44082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FE19BD99F
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 00:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F0B284836
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 23:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BD0216A12;
	Tue,  5 Nov 2024 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsKYUDr0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795E1D4352;
	Tue,  5 Nov 2024 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730848815; cv=none; b=d+FT4fiZVD1IG4HBuTNrrOV73pBRM81CXrT312LLluDRj1CCiVz4RHXEUF6XpxL+o41gwxp1GwAHXoq5I6Yldu6N9GOhcrTGwVC5uinZxFGjzeI7zNswbZ5xsqYIaxmhA9ry82lMcnO2ytP9MLM8HAJhmbbaieEwN9IngQXvuFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730848815; c=relaxed/simple;
	bh=gc+7bKSGuZL4dbF/8+f9O6CVkc9fGtxgWLPSyyp9UCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hpP9ycpvx+1CN7jj5Zo7IoiYS0GPDymJlukjoyxKTVVTplgVAhrJXClB3I64G2SVpY4rYH/I58d+oxPLL2zW12a/OlrIcZC+VODbxTdgSBESOl4k3OwIFlncSMahd8W9hvl8LOkthJiu0X9k9R3+KO/kLSrfI+okGsSHFmhgMgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsKYUDr0; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e2e340218daso6201861276.0;
        Tue, 05 Nov 2024 15:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730848812; x=1731453612; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XF1nNeiWnNAE/VjWIMTRcnPTyyWOgDy//NMHwf3EK7o=;
        b=GsKYUDr0P7PF7MDoYs4R/EVjP9UsGLfgpNVr4MPjEEfMoq0T51xmuqoNkKBMSEKGY+
         ybNSKGSqzqDAjXF3QWawP1pohrNYFdZ9goJicKKbsga29Ck+l3Xii8iSfOWUjJT4F4nY
         LsTrjtT0DG7xmO8n7xVZn+K2Rm4D2HM+OBN/qMqvaWUPqH1Kss1jxeV6aaqyeDRgIqXp
         uan8ERBSgIA25vRvSM6Yly2NXjDpQM6WMFLabcugujQKEf3wtaQoKFs+eIhSQm/aGphr
         lW9oPszESs976bjrRjlRT9XCbq6hfKeKyU/j1kAgnN4qFIyIC7EfYM39L6Aur1SrgXt9
         vhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730848812; x=1731453612;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XF1nNeiWnNAE/VjWIMTRcnPTyyWOgDy//NMHwf3EK7o=;
        b=O5qvgdpeY2l+0IxkRiJ6SPS2jRgRZlksCouetPLr7DqHLfmktxQ1QHdH+L/ricxn3c
         bELkBSqnfBNQoekNiqI2vtRgCaE6VTwlojwBTS7Bb26K1HGEEQvzRHRCsWrkRZrye12d
         mehZ9Vjwnn85N9Kz1wmfqZBe9LHuaddNfwRwRMnIsNOSfDNIitVj3iiUlZLA2P0AcA21
         djzgt6y1PZbmiimEmKfb9jakw7ZVGp8a+/MM2KFYX4iJ0y2Rjjszst1TQEin3LtRbB7C
         3UfynnDABNsxY34b9rvV4KN2wBWHRgSIcmERIPDsBX7ukQ8ixN3xeoAYr231qlHG6qh0
         GyVg==
X-Forwarded-Encrypted: i=1; AJvYcCU57+ksSv4dmi1T9sL1CpWaX3/414SLMMubJfpXQO8oGkG6aEX95wIhkdBbXfvykarikXGkEAx6@vger.kernel.org, AJvYcCUbmtaLWt6cOiynyvcHHNiWSrZriT3o6N+Re0h2NoYVkSmlMdwYjNO6xPlQgjM8TRpF2iAwIyi0M2f/lZAN@vger.kernel.org, AJvYcCVZA05oDeagFZT4UnsvCrCg5XISpn48bBR/YfXuc/2zX1jzaLEFXaBfCiVxjvKonViaQxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGJf5nwuzSXtkJ+CMfABtTSlraGUJRgj22j2yO782taK4s6fTx
	Aasp0J9K4hvYvY/YLB7W5KDvMuHMRhqCCQt82bvJwIzKc2LbldeM96PBPj83OfGVWxlkQqArybw
	zNb421JC+H/hJKwTL9VZSeQbKEZ0=
X-Google-Smtp-Source: AGHT+IFlzghaUYw9iGyCaI1vnDGeqzLT0EedupGzF5d75x1fdkIOXce7gLW+rMbxMw5WQXZJm5O4q5gPC8UXM2HBMP8=
X-Received: by 2002:a05:690c:6108:b0:6e3:116c:ebf3 with SMTP id
 00721157ae682-6ea5251fd6amr231053647b3.28.1730848812375; Tue, 05 Nov 2024
 15:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104202705.120939-1-rosenp@gmail.com> <20241105094855.GE595392@gmail.com>
In-Reply-To: <20241105094855.GE595392@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 5 Nov 2024 15:20:01 -0800
Message-ID: <CAKxU2N8eX2QXL=niL=DCodkm8ghEVLGTBCG8hoddth-BTDEnjQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: sfc: use ethtool string helpers
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org, 
	Edward Cree <ecree.xilinx@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, 
	"open list:SFC NETWORK DRIVER" <linux-net-drivers@amd.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 1:48=E2=80=AFAM Martin Habets <habetsm.xilinx@gmail.=
com> wrote:
>
> On Mon, Nov 04, 2024 at 12:27:05PM -0800, Rosen Penev wrote:
> >
> > The latter is the preferred way to copy ethtool strings.
> >
> > Avoids manually incrementing the pointer. Cleans up the code quite well=
.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/ethernet/sfc/ethtool_common.c     | 34 +++++++------------
> >  drivers/net/ethernet/sfc/falcon/ethtool.c     | 24 +++++--------
> >  drivers/net/ethernet/sfc/falcon/nic.c         |  7 ++--
> >  drivers/net/ethernet/sfc/nic.c                |  7 ++--
> >  .../net/ethernet/sfc/siena/ethtool_common.c   | 34 +++++++------------
> >  drivers/net/ethernet/sfc/siena/nic.c          |  7 ++--
> >  6 files changed, 40 insertions(+), 73 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/sfc/ethtool_common.c b/drivers/net/et=
hernet/sfc/ethtool_common.c
> > index ae32e08540fa..d46972f45ec1 100644
> > --- a/drivers/net/ethernet/sfc/ethtool_common.c
> > +++ b/drivers/net/ethernet/sfc/ethtool_common.c
> > @@ -403,24 +403,19 @@ static size_t efx_describe_per_queue_stats(struct=
 efx_nic *efx, u8 *strings)
> >       efx_for_each_channel(channel, efx) {
> >               if (efx_channel_has_tx_queues(channel)) {
> >                       n_stats++;
> > -                     if (strings !=3D NULL) {
> > -                             snprintf(strings, ETH_GSTRING_LEN,
> > -                                      "tx-%u.tx_packets",
> > -                                      channel->tx_queue[0].queue /
> > -                                      EFX_MAX_TXQ_PER_CHANNEL);
> > -
> > -                             strings +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (strings)
> > +                             ethtool_sprintf(
> > +                                     &strings, "tx-%u.tx_packets",
>
> This still fits after the opening parentheses above within 80 characters.
> I would prefer that style.
clang-format did this as there's too much indentation. I sent a v2
where I reduced it by adding continue;
>
> Martin
>
> > +                                     channel->tx_queue[0].queue /
> > +                                             EFX_MAX_TXQ_PER_CHANNEL);
> >               }
> >       }
> >       efx_for_each_channel(channel, efx) {
> >               if (efx_channel_has_rx_queue(channel)) {
> >                       n_stats++;
> > -                     if (strings !=3D NULL) {
> > -                             snprintf(strings, ETH_GSTRING_LEN,
> > -                                      "rx-%d.rx_packets", channel->cha=
nnel);
> > -                             strings +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (strings)
> > +                             ethtool_sprintf(&strings, "rx-%d.rx_packe=
ts",
> > +                                             channel->channel);
> >               }
> >       }
> >       if (efx->xdp_tx_queue_count && efx->xdp_tx_queues) {
> > @@ -428,11 +423,10 @@ static size_t efx_describe_per_queue_stats(struct=
 efx_nic *efx, u8 *strings)
> >
> >               for (xdp =3D 0; xdp < efx->xdp_tx_queue_count; xdp++) {
> >                       n_stats++;
> > -                     if (strings) {
> > -                             snprintf(strings, ETH_GSTRING_LEN,
> > -                                      "tx-xdp-cpu-%hu.tx_packets", xdp=
);
> > -                             strings +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (strings)
> > +                             ethtool_sprintf(&strings,
> > +                                             "tx-xdp-cpu-%hu.tx_packet=
s",
> > +                                             xdp);
> >               }
> >       }
> >
> > @@ -467,9 +461,7 @@ void efx_ethtool_get_strings(struct net_device *net=
_dev,
> >               strings +=3D (efx->type->describe_stats(efx, strings) *
> >                           ETH_GSTRING_LEN);
> >               for (i =3D 0; i < EFX_ETHTOOL_SW_STAT_COUNT; i++)
> > -                     strscpy(strings + i * ETH_GSTRING_LEN,
> > -                             efx_sw_stat_desc[i].name, ETH_GSTRING_LEN=
);
> > -             strings +=3D EFX_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
> > +                     ethtool_puts(&strings, efx_sw_stat_desc[i].name);
> >               strings +=3D (efx_describe_per_queue_stats(efx, strings) =
*
> >                           ETH_GSTRING_LEN);
> >               efx_ptp_describe_stats(efx, strings);
> > diff --git a/drivers/net/ethernet/sfc/falcon/ethtool.c b/drivers/net/et=
hernet/sfc/falcon/ethtool.c
> > index f4db683b80f7..41bd63d0c40c 100644
> > --- a/drivers/net/ethernet/sfc/falcon/ethtool.c
> > +++ b/drivers/net/ethernet/sfc/falcon/ethtool.c
> > @@ -361,24 +361,18 @@ static size_t ef4_describe_per_queue_stats(struct=
 ef4_nic *efx, u8 *strings)
> >       ef4_for_each_channel(channel, efx) {
> >               if (ef4_channel_has_tx_queues(channel)) {
> >                       n_stats++;
> > -                     if (strings !=3D NULL) {
> > -                             snprintf(strings, ETH_GSTRING_LEN,
> > -                                      "tx-%u.tx_packets",
> > -                                      channel->tx_queue[0].queue /
> > -                                      EF4_TXQ_TYPES);
> > -
> > -                             strings +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (strings)
> > +                             ethtool_sprintf(&strings, "tx-%u.tx_packe=
ts",
> > +                                             channel->tx_queue[0].queu=
e /
> > +                                                     EF4_TXQ_TYPES);
> >               }
> >       }
> >       ef4_for_each_channel(channel, efx) {
> >               if (ef4_channel_has_rx_queue(channel)) {
> >                       n_stats++;
> > -                     if (strings !=3D NULL) {
> > -                             snprintf(strings, ETH_GSTRING_LEN,
> > -                                      "rx-%d.rx_packets", channel->cha=
nnel);
> > -                             strings +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (strings)
> > +                             ethtool_sprintf(&strings, "rx-%d.rx_packe=
ts",
> > +                                             channel->channel);
> >               }
> >       }
> >       return n_stats;
> > @@ -412,9 +406,7 @@ static void ef4_ethtool_get_strings(struct net_devi=
ce *net_dev,
> >               strings +=3D (efx->type->describe_stats(efx, strings) *
> >                           ETH_GSTRING_LEN);
> >               for (i =3D 0; i < EF4_ETHTOOL_SW_STAT_COUNT; i++)
> > -                     strscpy(strings + i * ETH_GSTRING_LEN,
> > -                             ef4_sw_stat_desc[i].name, ETH_GSTRING_LEN=
);
> > -             strings +=3D EF4_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
> > +                     ethtool_puts(&strings, ef4_sw_stat_desc[i].name);
> >               strings +=3D (ef4_describe_per_queue_stats(efx, strings) =
*
> >                           ETH_GSTRING_LEN);
> >               break;
> > diff --git a/drivers/net/ethernet/sfc/falcon/nic.c b/drivers/net/ethern=
et/sfc/falcon/nic.c
> > index 78c851b5a56f..a7f0caa8710f 100644
> > --- a/drivers/net/ethernet/sfc/falcon/nic.c
> > +++ b/drivers/net/ethernet/sfc/falcon/nic.c
> > @@ -451,11 +451,8 @@ size_t ef4_nic_describe_stats(const struct ef4_hw_=
stat_desc *desc, size_t count,
> >
> >       for_each_set_bit(index, mask, count) {
> >               if (desc[index].name) {
> > -                     if (names) {
> > -                             strscpy(names, desc[index].name,
> > -                                     ETH_GSTRING_LEN);
> > -                             names +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (names)
> > +                             ethtool_puts(&names, desc[index].name);
> >                       ++visible;
> >               }
> >       }
> > diff --git a/drivers/net/ethernet/sfc/nic.c b/drivers/net/ethernet/sfc/=
nic.c
> > index a33ed473cc8a..51c975cff4fe 100644
> > --- a/drivers/net/ethernet/sfc/nic.c
> > +++ b/drivers/net/ethernet/sfc/nic.c
> > @@ -306,11 +306,8 @@ size_t efx_nic_describe_stats(const struct efx_hw_=
stat_desc *desc, size_t count,
> >
> >       for_each_set_bit(index, mask, count) {
> >               if (desc[index].name) {
> > -                     if (names) {
> > -                             strscpy(names, desc[index].name,
> > -                                     ETH_GSTRING_LEN);
> > -                             names +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (names)
> > +                             ethtool_puts(&names, desc[index].name);
> >                       ++visible;
> >               }
> >       }
> > diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/=
net/ethernet/sfc/siena/ethtool_common.c
> > index 075fef64de68..53b1cdf872d8 100644
> > --- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
> > +++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
> > @@ -403,24 +403,19 @@ static size_t efx_describe_per_queue_stats(struct=
 efx_nic *efx, u8 *strings)
> >       efx_for_each_channel(channel, efx) {
> >               if (efx_channel_has_tx_queues(channel)) {
> >                       n_stats++;
> > -                     if (strings !=3D NULL) {
> > -                             snprintf(strings, ETH_GSTRING_LEN,
> > -                                      "tx-%u.tx_packets",
> > -                                      channel->tx_queue[0].queue /
> > -                                      EFX_MAX_TXQ_PER_CHANNEL);
> > -
> > -                             strings +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (strings)
> > +                             ethtool_sprintf(
> > +                                     &strings, "tx-%u.tx_packets",
> > +                                     channel->tx_queue[0].queue /
> > +                                             EFX_MAX_TXQ_PER_CHANNEL);
> >               }
> >       }
> >       efx_for_each_channel(channel, efx) {
> >               if (efx_channel_has_rx_queue(channel)) {
> >                       n_stats++;
> > -                     if (strings !=3D NULL) {
> > -                             snprintf(strings, ETH_GSTRING_LEN,
> > -                                      "rx-%d.rx_packets", channel->cha=
nnel);
> > -                             strings +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (strings)
> > +                             ethtool_sprintf(&strings, "rx-%d.rx_packe=
ts",
> > +                                             channel->channel);
> >               }
> >       }
> >       if (efx->xdp_tx_queue_count && efx->xdp_tx_queues) {
> > @@ -428,11 +423,10 @@ static size_t efx_describe_per_queue_stats(struct=
 efx_nic *efx, u8 *strings)
> >
> >               for (xdp =3D 0; xdp < efx->xdp_tx_queue_count; xdp++) {
> >                       n_stats++;
> > -                     if (strings) {
> > -                             snprintf(strings, ETH_GSTRING_LEN,
> > -                                      "tx-xdp-cpu-%hu.tx_packets", xdp=
);
> > -                             strings +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (strings)
> > +                             ethtool_sprintf(&strings,
> > +                                             "tx-xdp-cpu-%hu.tx_packet=
s",
> > +                                             xdp);
> >               }
> >       }
> >
> > @@ -467,9 +461,7 @@ void efx_siena_ethtool_get_strings(struct net_devic=
e *net_dev,
> >               strings +=3D (efx->type->describe_stats(efx, strings) *
> >                           ETH_GSTRING_LEN);
> >               for (i =3D 0; i < EFX_ETHTOOL_SW_STAT_COUNT; i++)
> > -                     strscpy(strings + i * ETH_GSTRING_LEN,
> > -                             efx_sw_stat_desc[i].name, ETH_GSTRING_LEN=
);
> > -             strings +=3D EFX_ETHTOOL_SW_STAT_COUNT * ETH_GSTRING_LEN;
> > +                     ethtool_puts(&strings, efx_sw_stat_desc[i].name);
> >               strings +=3D (efx_describe_per_queue_stats(efx, strings) =
*
> >                           ETH_GSTRING_LEN);
> >               efx_siena_ptp_describe_stats(efx, strings);
> > diff --git a/drivers/net/ethernet/sfc/siena/nic.c b/drivers/net/etherne=
t/sfc/siena/nic.c
> > index 0ea0433a6230..06b97218b490 100644
> > --- a/drivers/net/ethernet/sfc/siena/nic.c
> > +++ b/drivers/net/ethernet/sfc/siena/nic.c
> > @@ -457,11 +457,8 @@ size_t efx_siena_describe_stats(const struct efx_h=
w_stat_desc *desc, size_t coun
> >
> >       for_each_set_bit(index, mask, count) {
> >               if (desc[index].name) {
> > -                     if (names) {
> > -                             strscpy(names, desc[index].name,
> > -                                     ETH_GSTRING_LEN);
> > -                             names +=3D ETH_GSTRING_LEN;
> > -                     }
> > +                     if (names)
> > +                             ethtool_puts(&names, desc[index].name);
> >                       ++visible;
> >               }
> >       }
> > --
> > 2.47.0
> >

