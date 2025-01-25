Return-Path: <bpf+bounces-49737-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942D2A1C023
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 817E53A41B7
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5427F1E98F8;
	Sat, 25 Jan 2025 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ug/bHnON"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6311DFDB9;
	Sat, 25 Jan 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737767938; cv=none; b=MLc1yOxdjsJJDCDLpCTHRrbDTcBgkSR5yV8VR7BN6O/4Ue9HFyCUq/lUf+aAqRymtYisANjhe0+wB6lINj5cjDLlcvP9r5rDnA3NYiBICagUZH3aHyoNYuhg4Vgh7WHBMtbHSDVTguUyCbehUvWNGL/4wK5uxjFUJ/ndVutj3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737767938; c=relaxed/simple;
	bh=/x024vN76ksjQrHMpHcFsiYKMg1AwC2mr+dcZhbKYvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOpbMWS6aCwPj8Me2aq5QXKkOai7SXqivqpbBlSabtD1RFu62iSbTNY/zylK71OReejg1zcj3bTVRgZv96am2x6DVQDQfqv4OCP6OhF5aJyG6ONHxq5/4P5tgZeznE1Y08euQrlrwNvu7SdV4iVlOLb9PrrQBOheezZbH1U0zNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ug/bHnON; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9628d20f0so19301085ab.2;
        Fri, 24 Jan 2025 17:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737767936; x=1738372736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4DD6T8YxBeT79WK+CeZ+nL/AZNlIbQp3ELdPbwFuYs=;
        b=Ug/bHnONWzvudIbMLtgd4FTGRlmiJ4f/bwcA0Q+bCpF0UpRvN2Egb2BL6THmZ0Sgzl
         FQucaffvavDMFduYjIv7J2As1Ks4iRdwWfYBDyfc1qWOGpe4oaGwjMUUGS8RIzi+d1ZX
         AO9Q3cGPW577aoTT0DVTpZQJ871HTKaHoD25pmpX3PJfJ0yFSonOUm6qAGcZ8wC6DUqY
         4OTabNWJ/VJ9LBZ+CUi2zgxihai8nJYKl35dMsfCLH2YCeza89up4VNwIhKuxfpHQMbQ
         eC1JCurV3F1fJjWJ+2rPnWrZGm+6dXy9mOGnlODJs/CxeV/2uZr9gufB4S4h0UK06dcL
         xr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737767936; x=1738372736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4DD6T8YxBeT79WK+CeZ+nL/AZNlIbQp3ELdPbwFuYs=;
        b=ROdoNp/rWNcxkoBDG/YmbDu2WZ/7RLk3F3T/AWFloFyqbA+Vrc9xKy0wGYWA0yxdAM
         GjXk5EAIhOQCMWugnTq8AbjQysJQQ/OtqhuD6Q39Tp2LCa/VWTb7vx4hQjNZgZQgUcXk
         zbbGa4+4rT3Wjd7uM3hW+dqtZsjeHtxp0rnqcmCNt9Z/he+ecE0GkZMH0lNgqD9q2FSL
         00acbIFIwWmido8te/gJrF9I+LzTXMREi2+ZeuCxkEsmDEHFA8+I+wuOu0N4wq3V0rTL
         2gOHtjU9LK+0G1rXYcZ66qzhOSzvHaLLBOEWLybsClNfenk/5/V6S88tAnv9cwZ25lX7
         o6CQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0uL43JA8eFlXvKSoFGO1WMzp4ulmS6wVbjAksqyAfcse0bQdjFyEXW64ZJPmomoijIlM=@vger.kernel.org, AJvYcCWL5+/aHYjAo0bQOl+2aWuTKemWc8zaqRZT3G1gz2G571Xdft3uUcDahCxzwnWi8uLPYCFcmN6T@vger.kernel.org
X-Gm-Message-State: AOJu0YwycMtrX0sGI7RD8Y+/uN+fMurWave5L3UTy23XmqvD4kdIU0YH
	0fG+a9Y8E1oecKg8yrBXtMR30vTBuiM1caajCV8ljHRkku71/PZsKiOq34VjcEQCpn6KEDm6aXF
	1nhl4MyTO6Geg0T7WPqSffSQmBNI=
X-Gm-Gg: ASbGncscwJ99GcbOZmGYbzAONxGouozJuZ/ptJ1+5n3XbSMTszhfen5+OhHUO1SVr/0
	1OYww/QllY5/tq03adHyg+6gVcNwUcUcBDW/pmbJNQEbijslfPvjadz5q2vhDZw==
X-Google-Smtp-Source: AGHT+IGd8Z6XAydQiI+Q0vmwmjGofqvvEcwhW0KNu9sN6/Uq7QvX8xL7kWBn817fYQ+aKh/4bJ/9nicJLNXcRiJvd9U=
X-Received: by 2002:a05:6e02:1c88:b0:3a7:1bfc:97c6 with SMTP id
 e9e14a558f8ab-3cf744953f7mr244143305ab.16.1737767936321; Fri, 24 Jan 2025
 17:18:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-9-kerneljasonxing@gmail.com> <40e2a7d8-dcba-4dfe-8c4d-14d8cf4954cf@linux.dev>
In-Reply-To: <40e2a7d8-dcba-4dfe-8c4d-14d8cf4954cf@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 09:18:20 +0800
X-Gm-Features: AWEUYZmS_scsmtO2OSlvwsnwoI3ZU8oC942e30NIM-GvlHw4gE9Q9e9IHOEyd4M
Message-ID: <CAL+tcoCzH2t0Zcn++j_w7s2C1AncczR1oe9RwqzTqBMd4zMNmg@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 08/13] net-timestamp: support hw
 SCM_TSTAMP_SND for bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 25, 2025 at 8:47=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/20/25 5:28 PM, Jason Xing wrote:
> > In this patch, we finish the hardware part. Then bpf program can
> > fetch the hwstamp from skb directly.
> >
> > To avoid changing so many callers using SKBTX_HW_TSTAMP from drivers,
> > use this simple modification like this patch does to support printing
> > hardware timestamp.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/linux/skbuff.h         |  4 +++-
> >   include/uapi/linux/bpf.h       |  5 +++++
> >   net/core/skbuff.c              | 11 ++++++-----
> >   net/dsa/user.c                 |  2 +-
> >   net/socket.c                   |  2 +-
> >   tools/include/uapi/linux/bpf.h |  5 +++++
> >   6 files changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index de8d3bd311f5..df2d790ae36b 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -471,7 +471,7 @@ struct skb_shared_hwtstamps {
> >   /* Definitions for tx_flags in struct skb_shared_info */
> >   enum {
> >       /* generate hardware time stamp */
> > -     SKBTX_HW_TSTAMP =3D 1 << 0,
> > +     __SKBTX_HW_TSTAMP =3D 1 << 0,
> >
> >       /* generate software time stamp when queueing packet to NIC */
> >       SKBTX_SW_TSTAMP =3D 1 << 1,
> > @@ -495,6 +495,8 @@ enum {
> >       SKBTX_BPF =3D 1 << 7,
> >   };
> >
> > +#define SKBTX_HW_TSTAMP              (__SKBTX_HW_TSTAMP | SKBTX_BPF)
> > +
> >   #define SKBTX_ANY_SW_TSTAMP (SKBTX_SW_TSTAMP    | \
> >                                SKBTX_SCHED_TSTAMP | \
> >                                SKBTX_BPF)
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a6d761f07f67..8936e1061e71 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7032,6 +7032,11 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_HW_OPT_CB,      /* Called in hardware phase when
> > +                                      * SO_TIMESTAMPING feature is on.
>
> Same comment on the "SO_TIMESTAMPING".
>
> It will be useful to elaborate more on "hardware phase", like exactly whe=
n it
> will be called,

Got it.

>
> > +                                      * It indicates the recorded
> > +                                      * timestamp.
>
> and the hwtstamps will be in the skb.

Right.

>
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 288eb9869827..c769feae5162 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5548,7 +5548,7 @@ static bool skb_enable_app_tstamp(struct sk_buff =
*skb, int tstype, bool sw)
> >               flag =3D SKBTX_SCHED_TSTAMP;
> >               break;
> >       case SCM_TSTAMP_SND:
> > -             flag =3D sw ? SKBTX_SW_TSTAMP : SKBTX_HW_TSTAMP;
> > +             flag =3D sw ? SKBTX_SW_TSTAMP : __SKBTX_HW_TSTAMP;
> >               break;
> >       case SCM_TSTAMP_ACK:
> >               if (TCP_SKB_CB(skb)->txstamp_ack)
> > @@ -5565,7 +5565,8 @@ static bool skb_enable_app_tstamp(struct sk_buff =
*skb, int tstype, bool sw)
> >   }
> >
> >   static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
> > -                           int tstype, bool sw)
> > +                           int tstype, bool sw,
> > +                           struct skb_shared_hwtstamps *hwtstamps)
> >   {
> >       int op;
> >
> > @@ -5577,9 +5578,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb=
, struct sock *sk,
> >               op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >               break;
> >       case SCM_TSTAMP_SND:
> > +             op =3D sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_H=
W_OPT_CB;
> >               if (!sw)
> > -                     return;
> > -             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> > +                     *skb_hwtstamps(skb) =3D *hwtstamps;
>
> hwtstamps may still be NULL, no?

Right, it can be zero if something wrong happens.

Thanks,
Jason

