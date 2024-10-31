Return-Path: <bpf+bounces-43669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F97A9B84DF
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 22:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D554B25A6B
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23FB1CCEF8;
	Thu, 31 Oct 2024 21:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLidn0Bp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7038B1C9DF3;
	Thu, 31 Oct 2024 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730408621; cv=none; b=BqWgxgxMo9c79CV0IKFXKCINIQxlBjOz96aeeePCdxRHXQAekDgei9m/GZQ6PSMOeUWNUlcQVN52gtE7FwULjPj1ktxv7GT8qaBZe9wxdWn0/grZWwMhR7Kkxjz8xohxeEXOUAG8ENBTWc1z4ln4uFu8481Xa4z+cQ7aq2hOG9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730408621; c=relaxed/simple;
	bh=oguIzsXbO0GU/KjTNvE+xCY3Mo9rAxoVPL11fv1xcCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XvvVqEVJ+S0fLKW8+3P6vgG/o+qNMg5u5UWxtxoVgHphuOMkoyX43ejMdWnCBIH36Vx/aDFTgD5aZHGo7iQ2yaKxfPcMQwUNZ415mTOTYyfph+3PHscRYMs9jjrcRuw5VU9Bb7ubt/0q8Nnq11jhLhccFkz73drFI1BJvbowm4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLidn0Bp; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e2e340218daso1530263276.0;
        Thu, 31 Oct 2024 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730408613; x=1731013413; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzQXq7XhxpTP+PwRlgBStzXT4waoPXFXg/qtJ44GAfA=;
        b=hLidn0Bpz9JLAPirstBwoMMhACFooJgmKs5YIRPi0tUbdPyL2TqED0vNQRhX+x1fsE
         uVw17nrtf3UQpLS/uDpm20IL/sEa2/Q/JXb5LHC7haxLs0aEu30U2HaM/0pt02vByIcj
         q2J7cuL0Wx/Pgt5xj3rE37A7J8rGfx7ikAXGPrdlmR7THV8wTNIXt25N0a9N2q4FralN
         U6IGsDxnPWzdyVoX5agaKTowc7sTi93gG//4c4Bklm8rERMIKV1UIJ7Q1xuFgm+UndKB
         FVFwkn8Py2kPVggjlfB1DSqnDiILT3QVI5an7OibXO0jlNbP3DK3buAUZeaqbW1ykCx5
         0yEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730408613; x=1731013413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzQXq7XhxpTP+PwRlgBStzXT4waoPXFXg/qtJ44GAfA=;
        b=AkAfOmrFj7tzvJLRCfUgODO73TgNMBZnnKmTjLMuHm9mDC+79OpZTBedFuFYSkRx5D
         LVqa1Nfa4Kj5xbXr8s/ApQdeqvysv7d8e+xuxHamos8taYyz19JC7fr/cE0K2ypL5LWv
         SaT8Fvvj5LRipZh+x0xnMW36VpjZLMmwyaCAnqAJdamx3OL8+Z5xi6aBpDAwI6mFTkDz
         t/Nqp1nIzzB1Y+fL4mg+KoQTdRivjDqDO8uqZ1DQe8/hcpD8NtgBUrnFUaoyzlqm/GKr
         DO7k2OjAgFLHLa8mHvI29LhAun/8c4ZoXHQPGN9XHbL31Q+sXUla+PYqKiYdfumVgeDC
         AlbA==
X-Forwarded-Encrypted: i=1; AJvYcCUN+O/zzItWHOiVzBY6PLEujQWtXdhRFpd6JJsUVc6dgx8aEFqkmlGn3+9RX3a9az8po2He6E3YveOI+COx@vger.kernel.org, AJvYcCVqg5xd5fpr3kd727WUgNdrrKi+6uls8M6FkRVcwxvrtbipEsKqsNr4omr29AgHa/RMtWY=@vger.kernel.org, AJvYcCXTN8vgeTHsB/CUJCnna+KyE+X3xvvHcwerlALisrn2Tf3/B3fg0jE++z89I9qcdYRY4OgswQxV@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUF/vMYetftc5yyL2IBzzwRDrxdCHFkwd2vvViUJbFp21C+OJ
	DTQZ+rRjs2yjFLqFi+X93Ce7qu3xYyFybAm9UGBh22EcABI3/nX7ndXy++aJJIN4GfGHCBBtnBV
	wjn6g83J3J/wJ+n6LIaXi3H5aPvk=
X-Google-Smtp-Source: AGHT+IHy8DQ1HGI9zkUS8yokJKso/acy/GTv8smDz5u00ITmraTSJlnFkEub2JffNHXzVENVysSrQhtA0eFO1024aTA=
X-Received: by 2002:a05:690c:4513:b0:6ea:3075:1fb5 with SMTP id
 00721157ae682-6ea525205e0mr57010167b3.33.1730408613135; Thu, 31 Oct 2024
 14:03:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025201713.286074-1-rosenp@gmail.com> <ca89f03e-6dc1-44fa-bfd1-aac95ede0cbe@intel.com>
 <CAKxU2N9hhwfdZN28kTDf3qUT8GXuxLDPFsA04jBaJSWqPRaHqQ@mail.gmail.com> <59f4a6e6-23ad-4f99-b168-047f1d0d801a@intel.com>
In-Reply-To: <59f4a6e6-23ad-4f99-b168-047f1d0d801a@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 31 Oct 2024 14:03:22 -0700
Message-ID: <CAKxU2N9gE_OZgfmTimMUcN=-P-SMSyFfCkHCd9xLqXKGabNtyw@mail.gmail.com>
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

On Thu, Oct 31, 2024 at 12:46=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 10/30/24 23:52, Rosen Penev wrote:
> > On Mon, Oct 28, 2024 at 3:13=E2=80=AFAM Przemek Kitszel
> > <przemyslaw.kitszel@intel.com> wrote:
> >>
> >> On 10/25/24 22:17, Rosen Penev wrote:
> >>> The latter is the preferred way to copy ethtool strings.
> >>>
> >>> Avoids manually incrementing the pointer. Cleans up the code quite we=
ll.
> >>>
> >>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >>> ---
> >>>    v2: add iwl-next tag. use inline int in for loops.
> >>>    .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
> >>>    drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++----
> >>>    .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 10 ++---
> >>>    .../net/ethernet/intel/i40e/i40e_ethtool.c    |  6 +--
> >>>    drivers/net/ethernet/intel/ice/ice_ethtool.c  | 37 +++++++++++----=
----
> >>>    drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++++-----=
---
> >>>    drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
> >>>    drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 +++++++++------=
---
> >>>    .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 ++++++++-------=
-
> >>
> >> for ice, igb, igc, and ixgbe the current code already uses ethtool
> >> string helpers, and in many places you are just changing variable name=
,
> >> "p" to "data", I would rather avoid that.
> > well, since I'm cleaning some of this code up, might as well get rid
> > of variables. That was suggested to me with other similar patches.
> >>
> >> sorry for not spotting that earlier, and apologies that we have so man=
y
> >> drivers to fix up in the first place
> >>
> >>> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/n=
et/ethernet/intel/ice/ice_ethtool.c
> >>> index 2924ac61300d..62a152be8180 100644
> >>> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> >>> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> >>> @@ -83,7 +83,7 @@ static const char ice_gstrings_test[][ETH_GSTRING_L=
EN] =3D {
> >>>        "Link test   (on/offline)",
> >>>    };
> >>>
> >>> -#define ICE_TEST_LEN (sizeof(ice_gstrings_test) / ETH_GSTRING_LEN)
> >>> +#define ICE_TEST_LEN ARRAY_SIZE(ice_gstrings_test)
> >>>
> >>>    /* These PF_STATs might look like duplicates of some NETDEV_STATs,
> >>>     * but they aren't. This device is capable of supporting multiple
> >>> @@ -1481,48 +1481,53 @@ static void
> >>>    __ice_get_strings(struct net_device *netdev, u32 stringset, u8 *da=
ta,
> >>>                  struct ice_vsi *vsi)
> >>>    {
> >>> +     const char *str;
> >>>        unsigned int i;
> >>> -     u8 *p =3D data;
> >>>
> >>>        switch (stringset) {
> >>>        case ETH_SS_STATS:
> >>> -             for (i =3D 0; i < ICE_VSI_STATS_LEN; i++)
> >>> -                     ethtool_puts(&p, ice_gstrings_vsi_stats[i].stat=
_string);
> >>> +             for (i =3D 0; i < ICE_VSI_STATS_LEN; i++) {
> >>> +                     str =3D ice_gstrings_vsi_stats[i].stat_string;
> >>> +                     ethtool_puts(&data, str);
> >>> +             }
> >>>
> >>>                if (ice_is_port_repr_netdev(netdev))
> >>>                        return;
> >>>
> >>>                ice_for_each_alloc_txq(vsi, i) {
> >>> -                     ethtool_sprintf(&p, "tx_queue_%u_packets", i);
> >>> -                     ethtool_sprintf(&p, "tx_queue_%u_bytes", i);
> >>> +                     ethtool_sprintf(&data, "tx_queue_%u_packets", i=
);
> >>> +                     ethtool_sprintf(&data, "tx_queue_%u_bytes", i);
> >>>                }
> >>>
> >>>                ice_for_each_alloc_rxq(vsi, i) {
> >>> -                     ethtool_sprintf(&p, "rx_queue_%u_packets", i);
> >>> -                     ethtool_sprintf(&p, "rx_queue_%u_bytes", i);
> >>> +                     ethtool_sprintf(&data, "rx_queue_%u_packets", i=
);
> >>> +                     ethtool_sprintf(&data, "rx_queue_%u_bytes", i);
> >>>                }
> >>>
> >>>                if (vsi->type !=3D ICE_VSI_PF)
> >>>                        return;
> >>>
> >>> -             for (i =3D 0; i < ICE_PF_STATS_LEN; i++)
> >>> -                     ethtool_puts(&p, ice_gstrings_pf_stats[i].stat_=
string);
> >>> +             for (i =3D 0; i < ICE_PF_STATS_LEN; i++) {
> >>> +                     str =3D ice_gstrings_pf_stats[i].stat_string;
> >>> +                     ethtool_puts(&data, str);
> >>> +             }
> >>>
> >>>                for (i =3D 0; i < ICE_MAX_USER_PRIORITY; i++) {
> >>> -                     ethtool_sprintf(&p, "tx_priority_%u_xon.nic", i=
);
> >>> -                     ethtool_sprintf(&p, "tx_priority_%u_xoff.nic", =
i);
> >>> +                     ethtool_sprintf(&data, "tx_priority_%u_xon.nic"=
, i);
> >>> +                     ethtool_sprintf(&data, "tx_priority_%u_xoff.nic=
", i);
> >>>                }
> >>>                for (i =3D 0; i < ICE_MAX_USER_PRIORITY; i++) {
> >>> -                     ethtool_sprintf(&p, "rx_priority_%u_xon.nic", i=
);
> >>> -                     ethtool_sprintf(&p, "rx_priority_%u_xoff.nic", =
i);
> >>> +                     ethtool_sprintf(&data, "rx_priority_%u_xon.nic"=
, i);
> >>> +                     ethtool_sprintf(&data, "rx_priority_%u_xoff.nic=
", i);
> >>>                }
> >>>                break;
> >>>        case ETH_SS_TEST:
> >>> -             memcpy(data, ice_gstrings_test, ICE_TEST_LEN * ETH_GSTR=
ING_LEN);
> >>> +             for (i =3D 0; i < ICE_TEST_LEN; i++)
> >>> +                     ethtool_puts(&data, ice_gstrings_test[i]);
> >>>                break;
> >>>        case ETH_SS_PRIV_FLAGS:
> >>>                for (i =3D 0; i < ICE_PRIV_FLAG_ARRAY_SIZE; i++)
> >>> -                     ethtool_puts(&p, ice_gstrings_priv_flags[i].nam=
e);
> >>> +                     ethtool_puts(&data, ice_gstrings_priv_flags[i].=
name);
> >>>                break;
> >>>        default:
> >>>                break;
> >>
> >> really no need to git-blame touch most of the code here>
> >
> > Actually the function should be taking a double pointer here I think
> > in case something gets called after it in the main function.
> I mean that both @p and @data are (u8 *).
> I'm fine getting rid of tmp var, and updating the originally passed
> argument is fine. But you could achieve it by just changing param name.
>
> BTW I guess it was @p to fit into 80 chars more easily ;)
Yeah I think so too.

