Return-Path: <bpf+bounces-43608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA559B700B
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 23:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC90B20E96
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 22:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80596217446;
	Wed, 30 Oct 2024 22:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqZfDu9w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460C1D1E63;
	Wed, 30 Oct 2024 22:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730328760; cv=none; b=daz5k9t3Fo5ikqWJA5Uo59tkslNcTiI/yDDDcxh9FKCj0JBQ3APedrk21aHc0lme5CpUvPLJdt+Wer1DdWFbpCYGkGg3tsSZlFPlStABKDDwYFBhD8LfV0lUc36oHBX4txXa/I6nfhIl560Dwy5ERoif0ys4pgCbyRo+luOqR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730328760; c=relaxed/simple;
	bh=kRvpUUQsUNbKlF22cVVpTTMIUw41ERN0aD89vmSwARc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeSTHftgGc+wqBJZIxjfPPZ4wHoChl3LQng/l/0nc+3ijdrl+VTEI9h7C1UR4/UsxYhn0qGwbyz4ZW+WtcEIqhU8Yc3xYoEk9YbSBKtUieLj/VIFQaTrJJ3HT+dbmxmBWFB6QWMceUytQEbBORaUm3v+sq6vXmljwsdeiEmY4ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqZfDu9w; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-460c0f9c13eso3460571cf.0;
        Wed, 30 Oct 2024 15:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730328756; x=1730933556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClJTtWkeJwKitQ6pdAX1pMbydYPeJlKHZM3I5rlDbso=;
        b=hqZfDu9wPrDU3oCB6378MbHDHqwnhiREXguqchkEYeV9zm0AeU9n7wuOP2WKAdmg8k
         3Tdv5aFiILm1bB9zMDZh1JA+nKcVsqEr6z5L/jC31pjcGyUhUtffe2N1MBz1f/fBR2i5
         COmOidMdYeEGgG2CY989GVTgZk7Z4ZqjbX1F+xHCjc5G42EoUfALkJ32XJhMeD9FkuHc
         ztNYc6oBvVNPGlE33HOLPehg8AMffERyQMxkMlDLnVs0QFqOVkrSeHT97JseY6Qdvc1f
         +WU2nI84IY7sKzRTBHj/t2ojJID8G8n5X1t0Irs/ovpMqagmhy1eLpScCRf5M4p6lGe3
         d3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730328756; x=1730933556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClJTtWkeJwKitQ6pdAX1pMbydYPeJlKHZM3I5rlDbso=;
        b=ooCqOHNoZ1nu1CTsv9O/pDc7KeQ3TnVNpWxHYqIHrJu4mDf/cAPgo07PEh9vOS18Yk
         xps9ck8g2G2vOA3UXNmK1SM1L+Q4A2K2CYFW02t0YEgRzFkAwcAkrVE8bGVU1BSN8uJt
         kE6MYYMpl3nxuU7Am1/QI9Afu5ZW77ehTFzs1jGNF/KsPE48Pav1GlEF2UMF1gEudBvG
         mTVD7ie9x/jxH48Ejokj4c6e2b8k/2c61uREegWwe/i18PNPdWXQ7TpPDT/1n/CCTMvQ
         3fALZuoAO0Ha8q3zOd304wf57Au1ZN5JmsRZOeNOg65iOjf0Wsf2PNIrZe/yPsOLaI7x
         Dl3A==
X-Forwarded-Encrypted: i=1; AJvYcCUX3X3w7dC76Ja2zA8A37nq6JcT4zNw4nObwfRGtu+XLvsw/GkothXkxV1SP8og8W8oNw3RllGw@vger.kernel.org, AJvYcCUZ7+/cOBG63TTHu8uVbc8dGH4fy1fplUfXY8PE3jdXpxhQ32M0YHB/YHvlW//ctAu9rZ3NulEJGZw9GcGN@vger.kernel.org, AJvYcCVvhdBVPo7kZ5AjXpfmSMeoRma6thNDEpqCZ6+BCGCJXHs/WlDZaHur0sdMKPbAn1BtVYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JmK9sAohcNmSiYvW79aNV8BUprTiSSTFfh6vIS+2DyCw/GiP
	A4TNHwWjoZvbx/6sGll8iJBJqcOF839Gb/mBb0943rq+4cTEwLWa4Gj9pbvrGTxTHfKDSmQ31vj
	64pgYGoiPQaK6Pk1bcHsEYRNMKhw=
X-Google-Smtp-Source: AGHT+IEbv78b2yimnG8bZhK81qAUMPmaYeMwqnG34hK/n4ZCF7sg8xtDmFEjl3WSTj0xQjqAlptJclv9DgTeGSuR+EQ=
X-Received: by 2002:ac8:4295:0:b0:462:ad94:3552 with SMTP id
 d75a77b69052e-462ad94361emr4787111cf.9.1730328755813; Wed, 30 Oct 2024
 15:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025201713.286074-1-rosenp@gmail.com> <ca89f03e-6dc1-44fa-bfd1-aac95ede0cbe@intel.com>
In-Reply-To: <ca89f03e-6dc1-44fa-bfd1-aac95ede0cbe@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 30 Oct 2024 15:52:24 -0700
Message-ID: <CAKxU2N9hhwfdZN28kTDf3qUT8GXuxLDPFsA04jBaJSWqPRaHqQ@mail.gmail.com>
Subject: Re: [PATCHv2 net-next iwl-next] net: intel: use ethtool string helpers
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 3:13=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 10/25/24 22:17, Rosen Penev wrote:
> > The latter is the preferred way to copy ethtool strings.
> >
> > Avoids manually incrementing the pointer. Cleans up the code quite well=
.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   v2: add iwl-next tag. use inline int in for loops.
> >   .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
> >   drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++----
> >   .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 10 ++---
> >   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 +--
> >   drivers/net/ethernet/intel/ice/ice_ethtool.c  | 37 +++++++++++-------=
-
> >   drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++++--------
> >   drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
> >   drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 +++++++++---------
> >   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 ++++++++--------
>
> for ice, igb, igc, and ixgbe the current code already uses ethtool
> string helpers, and in many places you are just changing variable name,
> "p" to "data", I would rather avoid that.
well, since I'm cleaning some of this code up, might as well get rid
of variables. That was suggested to me with other similar patches.
>
> sorry for not spotting that earlier, and apologies that we have so many
> drivers to fix up in the first place
>
> > diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net=
/ethernet/intel/ice/ice_ethtool.c
> > index 2924ac61300d..62a152be8180 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> > @@ -83,7 +83,7 @@ static const char ice_gstrings_test[][ETH_GSTRING_LEN=
] =3D {
> >       "Link test   (on/offline)",
> >   };
> >
> > -#define ICE_TEST_LEN (sizeof(ice_gstrings_test) / ETH_GSTRING_LEN)
> > +#define ICE_TEST_LEN ARRAY_SIZE(ice_gstrings_test)
> >
> >   /* These PF_STATs might look like duplicates of some NETDEV_STATs,
> >    * but they aren't. This device is capable of supporting multiple
> > @@ -1481,48 +1481,53 @@ static void
> >   __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *data,
> >                 struct ice_vsi *vsi)
> >   {
> > +     const char *str;
> >       unsigned int i;
> > -     u8 *p =3D data;
> >
> >       switch (stringset) {
> >       case ETH_SS_STATS:
> > -             for (i =3D 0; i < ICE_VSI_STATS_LEN; i++)
> > -                     ethtool_puts(&p, ice_gstrings_vsi_stats[i].stat_s=
tring);
> > +             for (i =3D 0; i < ICE_VSI_STATS_LEN; i++) {
> > +                     str =3D ice_gstrings_vsi_stats[i].stat_string;
> > +                     ethtool_puts(&data, str);
> > +             }
> >
> >               if (ice_is_port_repr_netdev(netdev))
> >                       return;
> >
> >               ice_for_each_alloc_txq(vsi, i) {
> > -                     ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> > -                     ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_packets", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
> >               }
> >
> >               ice_for_each_alloc_rxq(vsi, i) {
> > -                     ethtool_sprintf(&p, "rx_queue_%u_packets", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_packets", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
> >               }
> >
> >               if (vsi->type !=3D ICE_VSI_PF)
> >                       return;
> >
> > -             for (i =3D 0; i < ICE_PF_STATS_LEN; i++)
> > -                     ethtool_puts(&p, ice_gstrings_pf_stats[i].stat_st=
ring);
> > +             for (i =3D 0; i < ICE_PF_STATS_LEN; i++) {
> > +                     str =3D ice_gstrings_pf_stats[i].stat_string;
> > +                     ethtool_puts(&data, str);
> > +             }
> >
> >               for (i =3D 0; i < ICE_MAX_USER_PRIORITY; i++) {
> > -                     ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i);
> > -                     ethtool_sprintf(&p, "tx_priority_%u_xoff.nic", i)=
;
> > +                     ethtool_sprintf(&data, "tx_priority_%u_xon.nic", =
i);
> > +                     ethtool_sprintf(&data, "tx_priority_%u_xoff.nic",=
 i);
> >               }
> >               for (i =3D 0; i < ICE_MAX_USER_PRIORITY; i++) {
> > -                     ethtool_sprintf(&p, "rx_priority_%u_xon.nic", i);
> > -                     ethtool_sprintf(&p, "rx_priority_%u_xoff.nic", i)=
;
> > +                     ethtool_sprintf(&data, "rx_priority_%u_xon.nic", =
i);
> > +                     ethtool_sprintf(&data, "rx_priority_%u_xoff.nic",=
 i);
> >               }
> >               break;
> >       case ETH_SS_TEST:
> > -             memcpy(data, ice_gstrings_test, ICE_TEST_LEN * ETH_GSTRIN=
G_LEN);
> > +             for (i =3D 0; i < ICE_TEST_LEN; i++)
> > +                     ethtool_puts(&data, ice_gstrings_test[i]);
> >               break;
> >       case ETH_SS_PRIV_FLAGS:
> >               for (i =3D 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
> > -                     ethtool_puts(&p, ice_gstrings_priv_flags[i].name)=
;
> > +                     ethtool_puts(&data, ice_gstrings_priv_flags[i].na=
me);
> >               break;
> >       default:
> >               break;
>
> really no need to git-blame touch most of the code here>

Actually the function should be taking a double pointer here I think
in case something gets called after it in the main function.

> > diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net=
/ethernet/intel/igb/igb_ethtool.c
> > index ca6ccbc13954..c4a8712389af 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
> > @@ -123,7 +123,7 @@ static const char igb_gstrings_test[][ETH_GSTRING_L=
EN] =3D {
> >       [TEST_LOOP] =3D "Loopback test  (offline)",
> >       [TEST_LINK] =3D "Link test   (on/offline)"
> >   };
> > -#define IGB_TEST_LEN (sizeof(igb_gstrings_test) / ETH_GSTRING_LEN)
> > +#define IGB_TEST_LEN ARRAY_SIZE(igb_gstrings_test)
> >
> >   static const char igb_priv_flags_strings[][ETH_GSTRING_LEN] =3D {
> >   #define IGB_PRIV_FLAGS_LEGACY_RX    BIT(0)
> > @@ -2347,35 +2347,38 @@ static void igb_get_ethtool_stats(struct net_de=
vice *netdev,
> >   static void igb_get_strings(struct net_device *netdev, u32 stringset,=
 u8 *data)
> >   {
> >       struct igb_adapter *adapter =3D netdev_priv(netdev);
> > -     u8 *p =3D data;
> > +     const char *str;
> >       int i;
> >
> >       switch (stringset) {
> >       case ETH_SS_TEST:
> > -             memcpy(data, igb_gstrings_test, sizeof(igb_gstrings_test)=
);
> > +             for (i =3D 0; i < IGB_TEST_LEN; i++)
> > +                     ethtool_puts(&data, igb_gstrings_test[i]);
> >               break;
> >       case ETH_SS_STATS:
> >               for (i =3D 0; i < IGB_GLOBAL_STATS_LEN; i++)
> > -                     ethtool_puts(&p, igb_gstrings_stats[i].stat_strin=
g);
> > -             for (i =3D 0; i < IGB_NETDEV_STATS_LEN; i++)
> > -                     ethtool_puts(&p, igb_gstrings_net_stats[i].stat_s=
tring);
> > +                     ethtool_puts(&data, igb_gstrings_stats[i].stat_st=
ring);
> > +             for (i =3D 0; i < IGB_NETDEV_STATS_LEN; i++) {
> > +                     str =3D igb_gstrings_net_stats[i].stat_string;
> > +                     ethtool_puts(&data, str);
> > +             }
> >               for (i =3D 0; i < adapter->num_tx_queues; i++) {
> > -                     ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> > -                     ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> > -                     ethtool_sprintf(&p, "tx_queue_%u_restart", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_packets", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_restart", i);
> >               }
> >               for (i =3D 0; i < adapter->num_rx_queues; i++) {
> > -                     ethtool_sprintf(&p, "rx_queue_%u_packets", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_drops", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_csum_err", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_alloc_failed", i=
);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_packets", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_drops", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_csum_err", i)=
;
> > +                     ethtool_sprintf(&data, "rx_queue_%u_alloc_failed"=
, i);
> >               }
> >               /* BUG_ON(p - data !=3D IGB_STATS_LEN * ETH_GSTRING_LEN);=
 */
> >               break;
> >       case ETH_SS_PRIV_FLAGS:
> > -             memcpy(data, igb_priv_flags_strings,
> > -                    IGB_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
> > +             for (i =3D 0; i < IGB_PRIV_FLAGS_STR_LEN; i++)
> > +                     ethtool_puts(&data, igb_priv_flags_strings[i]);
> >               break;
> >       }
> >   }
>
> ditto
>
> > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net=
/ethernet/intel/igc/igc_ethtool.c
> > index 5b0c6f433767..7b118fb7097b 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > @@ -104,7 +104,7 @@ static const char igc_gstrings_test[][ETH_GSTRING_L=
EN] =3D {
> >       [TEST_LINK] =3D "Link test   (on/offline)"
> >   };
> >
> > -#define IGC_TEST_LEN (sizeof(igc_gstrings_test) / ETH_GSTRING_LEN)
> > +#define IGC_TEST_LEN ARRAY_SIZE(igc_gstrings_test)
> >
> >   #define IGC_GLOBAL_STATS_LEN        \
> >       (sizeof(igc_gstrings_stats) / sizeof(struct igc_stats))
> > @@ -763,36 +763,38 @@ static void igc_ethtool_get_strings(struct net_de=
vice *netdev, u32 stringset,
> >                                   u8 *data)
> >   {
> >       struct igc_adapter *adapter =3D netdev_priv(netdev);
> > -     u8 *p =3D data;
> > +     const char *str;
> >       int i;
> >
> >       switch (stringset) {
> >       case ETH_SS_TEST:
> > -             memcpy(data, *igc_gstrings_test,
> > -                    IGC_TEST_LEN * ETH_GSTRING_LEN);
> > +             for (i =3D 0; i < IGC_TEST_LEN; i++)
> > +                     ethtool_puts(&data, igc_gstrings_test[i]);
> >               break;
> >       case ETH_SS_STATS:
> >               for (i =3D 0; i < IGC_GLOBAL_STATS_LEN; i++)
> > -                     ethtool_puts(&p, igc_gstrings_stats[i].stat_strin=
g);
> > -             for (i =3D 0; i < IGC_NETDEV_STATS_LEN; i++)
> > -                     ethtool_puts(&p, igc_gstrings_net_stats[i].stat_s=
tring);
> > +                     ethtool_puts(&data, igc_gstrings_stats[i].stat_st=
ring);
> > +             for (i =3D 0; i < IGC_NETDEV_STATS_LEN; i++) {
> > +                     str =3D igc_gstrings_net_stats[i].stat_string;
> > +                     ethtool_puts(&data, str);
> > +             }
> >               for (i =3D 0; i < adapter->num_tx_queues; i++) {
> > -                     ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> > -                     ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> > -                     ethtool_sprintf(&p, "tx_queue_%u_restart", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_packets", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_restart", i);
> >               }
> >               for (i =3D 0; i < adapter->num_rx_queues; i++) {
> > -                     ethtool_sprintf(&p, "rx_queue_%u_packets", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_drops", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_csum_err", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_alloc_failed", i=
);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_packets", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_drops", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_csum_err", i)=
;
> > +                     ethtool_sprintf(&data, "rx_queue_%u_alloc_failed"=
, i);
> >               }
> >               /* BUG_ON(p - data !=3D IGC_STATS_LEN * ETH_GSTRING_LEN);=
 */
> >               break;
> >       case ETH_SS_PRIV_FLAGS:
> > -             memcpy(data, igc_priv_flags_strings,
> > -                    IGC_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
> > +             for (i =3D 0; i < IGC_PRIV_FLAGS_STR_LEN; i++)
> > +                     ethtool_puts(&data, igc_priv_flags_strings[i]);
> >               break;
> >       }
> >   }
>
> ditto
>
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers=
/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> > index 9482e0cca8b7..b3b2e38c2ae6 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> > @@ -129,7 +129,7 @@ static const char ixgbe_gstrings_test[][ETH_GSTRING=
_LEN] =3D {
> >       "Interrupt test (offline)", "Loopback test  (offline)",
> >       "Link test   (on/offline)"
> >   };
> > -#define IXGBE_TEST_LEN sizeof(ixgbe_gstrings_test) / ETH_GSTRING_LEN
> > +#define IXGBE_TEST_LEN ARRAY_SIZE(ixgbe_gstrings_test)
> >
> >   static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] =3D {
> >   #define IXGBE_PRIV_FLAGS_LEGACY_RX  BIT(0)
> > @@ -1409,38 +1409,40 @@ static void ixgbe_get_ethtool_stats(struct net_=
device *netdev,
> >   static void ixgbe_get_strings(struct net_device *netdev, u32 stringse=
t,
> >                             u8 *data)
> >   {
> > +     const char *str;
> >       unsigned int i;
> > -     u8 *p =3D data;
> >
> >       switch (stringset) {
> >       case ETH_SS_TEST:
> >               for (i =3D 0; i < IXGBE_TEST_LEN; i++)
> > -                     ethtool_puts(&p, ixgbe_gstrings_test[i]);
> > +                     ethtool_puts(&data, ixgbe_gstrings_test[i]);
> >               break;
> >       case ETH_SS_STATS:
> > -             for (i =3D 0; i < IXGBE_GLOBAL_STATS_LEN; i++)
> > -                     ethtool_puts(&p, ixgbe_gstrings_stats[i].stat_str=
ing);
> > +             for (i =3D 0; i < IXGBE_GLOBAL_STATS_LEN; i++) {
> > +                     str =3D ixgbe_gstrings_stats[i].stat_string;
> > +                     ethtool_puts(&data, str);
> > +             }
> >               for (i =3D 0; i < netdev->num_tx_queues; i++) {
> > -                     ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> > -                     ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_packets", i);
> > +                     ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
> >               }
> >               for (i =3D 0; i < IXGBE_NUM_RX_QUEUES; i++) {
> > -                     ethtool_sprintf(&p, "rx_queue_%u_packets", i);
> > -                     ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_packets", i);
> > +                     ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
> >               }
> >               for (i =3D 0; i < IXGBE_MAX_PACKET_BUFFERS; i++) {
> > -                     ethtool_sprintf(&p, "tx_pb_%u_pxon", i);
> > -                     ethtool_sprintf(&p, "tx_pb_%u_pxoff", i);
> > +                     ethtool_sprintf(&data, "tx_pb_%u_pxon", i);
> > +                     ethtool_sprintf(&data, "tx_pb_%u_pxoff", i);
> >               }
> >               for (i =3D 0; i < IXGBE_MAX_PACKET_BUFFERS; i++) {
> > -                     ethtool_sprintf(&p, "rx_pb_%u_pxon", i);
> > -                     ethtool_sprintf(&p, "rx_pb_%u_pxoff", i);
> > +                     ethtool_sprintf(&data, "rx_pb_%u_pxon", i);
> > +                     ethtool_sprintf(&data, "rx_pb_%u_pxoff", i);
> >               }
> >               /* BUG_ON(p - data !=3D IXGBE_STATS_LEN * ETH_GSTRING_LEN=
); */
> >               break;
> >       case ETH_SS_PRIV_FLAGS:
> > -             memcpy(data, ixgbe_priv_flags_strings,
> > -                    IXGBE_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
> > +             for (i =3D 0; i < IXGBE_PRIV_FLAGS_STR_LEN; i++)
> > +                     ethtool_puts(&data, ixgbe_priv_flags_strings[i]);
> >       }
> >   }
> >
>
> ditto here

