Return-Path: <bpf+bounces-43189-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552379B0FB1
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 22:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1751428600F
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 20:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CEE20F3F5;
	Fri, 25 Oct 2024 20:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXOv6ozT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5924620C319;
	Fri, 25 Oct 2024 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887609; cv=none; b=FHtTta951jIy9C7RrrWrUohno2I6UFqNZBUUwt6YqP7evSUJTLVHPKMAMiO3VCLEAuRMVvvSFnVh2TATACOHozWfknsFM2CdyZKgTwTAhTz61VBYNBjy2+DevPHvSlpP6Az24pKf+I+FSGefTDKrDUqVykOF6+q9Fnunfb2uEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887609; c=relaxed/simple;
	bh=naweq0+G9RQVr6kbHD6RZtaMs1brq8HVOycmjlxV7oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uUbMwxvh0JPKaZqAT9ADMglvO50fJGQD777RUQRrM9u5QlNK4Wl0PFyc99n+0AqbI4pS7kvihAi/5nE9ZZ+SWK6NSmunN7U+cTAvr1SKbO+H+h2m9/DzhQnnB51/WzTmSbHvL9+eRXuDzZqQLy4gL/Go3Z8eMFlQb/VmB9fMOrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXOv6ozT; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e38fc62b9fso23145797b3.2;
        Fri, 25 Oct 2024 13:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729887606; x=1730492406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXyMgVJ8SMoPT6DVm8ucQxYlv2RUv92E4LD4kUVHd0k=;
        b=BXOv6ozTUfjJCtwkoSrNoK8wiv6OpInoRQSoiyYJmrLivf/3yiHovIRG6ZyOhoI+Cj
         guYAcTZ7NPRCE9jB3HyTURO+F93262rtdSscU5ifbgUBPK5hIcsTh+HeOChr5kqTxuhF
         j0SDmcD6oVM56+Lb4Ey0zPmhQdwxR7Bza7ybSuds2Kd2eEdRBGiWphxOsQ3TefClFI1/
         AQbivxmFymStZ6bcyF2+UEsAdB2lXpcAI6U7t7CV6QW2yEw2HGgMEqzutNwKmbyFJzQm
         hJTdvav5glOEzHFz233vSwX9DFs3+PRpFSKI4liP+rgjaaE9fPlzm2HyylpFPAz3l1vv
         ICug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729887606; x=1730492406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXyMgVJ8SMoPT6DVm8ucQxYlv2RUv92E4LD4kUVHd0k=;
        b=i0SyFege4oKLmWpKe/dj3M21GbWXsIlQRot4UYMiBqI+XVJkgkRKufXfG/Tlwmy61o
         GVukL7fGQRmjYHJx45514uyVwVtGDGmFgBGIkoNqSZcs3JbImXxj8kcx4gs6Ip8yvEc6
         16Y2QcQJ0KnSL+M8E5tR8uk2Xpv3wcfa0dcJ35T5JexKZdrzv/zcy72XTGqZDn/oq1BJ
         yk8/J6LONdnp4TCIgLQKSoDI54QQL95zru+UTiQhBXRuLTSK2rqq1lhF7g44w+erKeDO
         Jb59QT0rRtWf4l3kNkJWLfplyrnkauuIIFmk4xekIs5MSKEpBOkx4iLhL9RkTmrPuRd0
         FxKg==
X-Forwarded-Encrypted: i=1; AJvYcCW9y6JkrVyTOegShZ2iK9LrqO26bM0FF7pyjvB4v6RH6GkQ35+/OIcdZJ+7AQ3FFEIhReM=@vger.kernel.org, AJvYcCWVHo39V93pdWX6OpXwn2yi1Coe1YmFtTq786UZEngaAWsb4qXMYQfNhjBGxiteLG5jCwds/h7vPRTsbQrs@vger.kernel.org, AJvYcCWYr5HwgFUT/8iQPQp11EvTHB7MRC9WoH52e4qNYT6IEvaanF82Z07uND3b34cxT6FAUrL5899e@vger.kernel.org
X-Gm-Message-State: AOJu0Yyse57qXfIfeDAz6xeAJWK/wQEvDcx6/j3+rlTeIXiYvotMrQXR
	T3n0+izWhQvrWDXT48Vvv+03ZhuzFTepvNK4+4msm/YUCc7e/PkOAn4Nkn4q0/YZ/U7H1zbxrNS
	IQdK7tPnC58ErIzuiwkfMmv26Wp0=
X-Google-Smtp-Source: AGHT+IGgiZYXtL3ricAvXQWhc+ZCKVLRQRJgfz0rnJTfYaOfNAHNm7L+BtWFsi1GYEBC7DJW0AhKJQ1P3kF/zVyi/Eo=
X-Received: by 2002:a05:690c:2c01:b0:6e2:7dd:af61 with SMTP id
 00721157ae682-6e9d89768c1mr9213617b3.17.1729887606276; Fri, 25 Oct 2024
 13:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024195647.176614-1-rosenp@gmail.com> <1c9afb23-fcf8-4401-af06-4a0b2dcbb135@intel.com>
In-Reply-To: <1c9afb23-fcf8-4401-af06-4a0b2dcbb135@intel.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 25 Oct 2024 13:19:55 -0700
Message-ID: <CAKxU2N9XKEsr+c-Kwi+T08DqN8jt8Gdf0tH8Fy2M0Nb4fCjddA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: intel: use ethtool string helpers
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

On Thu, Oct 24, 2024 at 9:06=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 10/24/24 21:56, Rosen Penev wrote:
> > The latter is the preferred way to copy ethtool strings.
> >
> > Avoids manually incrementing the pointer. Cleans up the code quite well=
.
>
> Indeed, thanks a lot!
>
> Could you please tag next version as [iwl-next], so it will be easier to
> via Tony's tree first?
message awaits moderator approval.
>
> Codewise it's good, just one nitpick from me.
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >   .../net/ethernet/intel/e1000/e1000_ethtool.c  | 10 ++---
> >   drivers/net/ethernet/intel/e1000e/ethtool.c   | 14 +++----
> >   .../net/ethernet/intel/fm10k/fm10k_ethtool.c  | 12 +++---
> >   .../net/ethernet/intel/i40e/i40e_ethtool.c    |  8 ++--
> >   drivers/net/ethernet/intel/ice/ice_ethtool.c  | 37 +++++++++++-------=
-
> >   drivers/net/ethernet/intel/igb/igb_ethtool.c  | 35 ++++++++++--------
> >   drivers/net/ethernet/intel/igbvf/ethtool.c    | 10 ++---
> >   drivers/net/ethernet/intel/igc/igc_ethtool.c  | 36 +++++++++---------
> >   .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 32 ++++++++--------
> >   drivers/net/ethernet/intel/ixgbevf/ethtool.c  | 36 +++++++-----------
> >   10 files changed, 119 insertions(+), 111 deletions(-)
> >
>
> [..]
>
> > --- a/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> > +++ b/drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c
> > @@ -122,7 +122,7 @@ static const char fm10k_gstrings_test[][ETH_GSTRING=
_LEN] =3D {
> >       "Mailbox test (on/offline)"
> >   };
> >
> > -#define FM10K_TEST_LEN (sizeof(fm10k_gstrings_test) / ETH_GSTRING_LEN)
> > +#define FM10K_TEST_LEN ARRAY_SIZE(fm10k_gstrings_test)
>
> this line is not strictly related to the stated goal of the commit,
> fine anyway for me
I use grep ETH_GSTRING_LEN to find opportunities for these changes,
hence why I changed.
>
> >
> >   enum fm10k_self_test_types {
> >       FM10K_TEST_MBX,
> > @@ -180,17 +180,19 @@ static void fm10k_get_stat_strings(struct net_dev=
ice *dev, u8 *data)
> >   static void fm10k_get_strings(struct net_device *dev,
> >                             u32 stringset, u8 *data)
> >   {
> > +     int i;
> > +
> >       switch (stringset) {
> >       case ETH_SS_TEST:
> > -             memcpy(data, fm10k_gstrings_test,
> > -                    FM10K_TEST_LEN * ETH_GSTRING_LEN);
> > +             for (i =3D 0; i < FM10K_TEST_LEN; i++)
>
> for new code we put the iterator declaration into the loop, do:
>                 for (int i =3D 0; ...
>
> ditto other places/drivers
I changed the places where I had + int i;

I kept every other place as is.
>
> > +                     ethtool_puts(&data, fm10k_gstrings_test[i]);
> >               break;
> >       case ETH_SS_STATS:
> >               fm10k_get_stat_strings(dev, data);
> >               break;
> >       case ETH_SS_PRIV_FLAGS:
> > -             memcpy(data, fm10k_prv_flags,
> > -                    FM10K_PRV_FLAG_LEN * ETH_GSTRING_LEN);
> > +             for (i =3D 0; i < FM10K_PRV_FLAG_LEN; i++)
> > +                     ethtool_puts(&data, fm10k_prv_flags[i]);
> >               break;
> >       }
> >   }
>

