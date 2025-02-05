Return-Path: <bpf+bounces-50527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E26A295AA
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFFF3167FE9
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D9E194094;
	Wed,  5 Feb 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hlep+vtH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01333154C1D;
	Wed,  5 Feb 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771446; cv=none; b=m1nR7gTreuay704VOCK+NJja96Vai5cbmQlFfongZO6tmgzNcPtcIfsPushw+m6/hRpSdLhsuUhdrOPVVbWMF0i9VGFWwBxrAUrFvjIqDoWdqor4YKe6dPAepCLm4LldgiSbWhFYBvpoI0BjUhUqZ4zG/FUovPsfqXL9EVAiaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771446; c=relaxed/simple;
	bh=jCMsc26EHjkKT1Yf7CHEflS4/sV+fTmx0X2C7c36aOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3A9MJAIj4KT2WrIxzOXVFvolhrK7DK0ZZctdq7uXjnP/97K1y9TYO6P9dnIGUhvy9PBnCcvz7Z0tBMu+wDWrd1j/fsaOnEoTmkQgapMQVj52yUk7THkRSj7Mtyez3m3hVkvHEJnWvFBjNb5jteIbL43jHxEiHuBYmjUdgpTB+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hlep+vtH; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ce7c4115e8so3280065ab.1;
        Wed, 05 Feb 2025 08:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738771444; x=1739376244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRvcHeoTr8CvX1P/q28laoAaIqd0ip8jzarxkdM/9ys=;
        b=Hlep+vtHVemCtLrqrRYL3d53NfR9C0x6fbXy1GEHDIuEHKHF6EtlG2Ky9jT3ST4/2q
         eofZqUajeSi4QD7RqYuKWx56apNwPMeb2JLguVdoy73WIA7YLcatmXDHAbz90ury8YPu
         /ufNUrBdw28cZ0GgTzHxZeISwPvthFjSuXMTtVUTmSoIRIm87W8rXMATuLj7A0+Zg7ed
         nmtAMnCRV3qm4NY/YR1v3bfq5rhW1FqdqpMOIGq50PCPrXcmFdUBRxk8xORS+UGqFvp8
         uRPrdONqjmD/qd8S6M8JVpCCVA/xkiSI8FP3omLVnpJ0Bxz97BWYYEKKdNaP/DysmpnY
         LoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738771444; x=1739376244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRvcHeoTr8CvX1P/q28laoAaIqd0ip8jzarxkdM/9ys=;
        b=bUFuohQ13Lmdj5z2sh25SS0zy4yx0mu/Y9xMwvvxjaZcVRXCHK8JQdNZUqv+IwqVXL
         nZ9OIBDjUcdmDB+bDK4yI4rzSMDHwpK5W86ju4borrOQpV4r29S6gVZwN8HhMsHt+juP
         6lVtnRnP530h6ZbbFG9D8YCIT1vDoD4c7sHGa7K1OJzpHfvGPS/CUFdxxc8qImaBp8Ix
         X4UIMdy+eSzO9FEm/YoirG8MJ5f56P2t19ukb0qGax9ghiuQmi8sfKh00u1OAfX+Crnt
         SnbDSAfcCt5iGz0kozlfvFzrAgvMEkLKQJn5UhHvNDuVpWac07Q2Y7wd5McKwbN6tsO7
         ZgHw==
X-Forwarded-Encrypted: i=1; AJvYcCU/CJ4v1DeZbTDW0bfCpYC861LcMfCs9oCImkjQPVKNS2rFxiHcLR+9MmlmNT5ZmUoMLKzLd5mA@vger.kernel.org, AJvYcCUHa9MsbUGjfJ1xkm87AMXdW5F2LOYihiuRcQ0FWbHXIQ62MOxHvUCTBXu2mCr+BPB4k4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDb4NvxLIl9IglzUwNqIs9s2aQFLRs1f1zPPU9TWUftIK3QUFr
	jznzVAVguWi6BRc5NotypRtEz6H3n0y+yP55dQMxiooFnD4+PWntjwu2wZUZs8natIn7/IMmqzW
	SLk4c22Fzo6zpSKzmZHpl9v+7P+fbY6qZRxeePQ==
X-Gm-Gg: ASbGncsaF1ustbJz8rcPPIuWxYIALxZu17bK38tbusJkSk48h+FaNynkn1k4wdsNa8d
	ZuS9cQGb4+ZrP2LadGBZ0bC9ijRuuZUfEr5L6VHGrUIvK0jwTNaTClOfN9IFc6ViPXHe2pO8=
X-Google-Smtp-Source: AGHT+IFqVP7ITB8zV4TPzhIBaOEiz8XqjYcK0xnperSDAVHZNXLPoq7WGkXZNbCl4rsi6F15QEJqyQZOwvgJa24Mjt8=
X-Received: by 2002:a92:c5a9:0:b0:3d0:194:b1fd with SMTP id
 e9e14a558f8ab-3d03f545c02mr55086005ab.11.1738771443960; Wed, 05 Feb 2025
 08:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-9-kerneljasonxing@gmail.com> <67a3878eaefdf_14e08329415@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a3878eaefdf_14e08329415@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 00:03:27 +0800
X-Gm-Features: AWEUYZmaTfBZHHgvm1R_p3Er4ZC6_LfstNyGUYWABNlgBCXDOkbCc8KkagKqps4
Message-ID: <CAL+tcoAH6OYNOvUg8LDYw_b+ar3bo2AXqq0=oHgb-ogEYAeHZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 08/12] bpf: support hw SCM_TSTAMP_SND of SO_TIMESTAMPING
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 11:45=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Patch finishes the hardware part.
>
> For consistency with previous patches, and to make sense of this
> commit message on its own, when stumbling on it, e.g., through
> git blame, replace the above with
>
> Support hw SCM_TSTAMP_SND case.
>
> > Then bpf program can fetch the
> > hwstamp from skb directly.
> >
> > To avoid changing so many callers using SKBTX_HW_TSTAMP from drivers,
> > use this simple modification like this patch does to support printing
> > hardware timestamp.
>
> Which simple modification? Please state explicitly.
>
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/linux/skbuff.h         |  4 +++-
> >  include/uapi/linux/bpf.h       |  7 +++++++
> >  net/core/skbuff.c              | 13 +++++++------
> >  net/dsa/user.c                 |  2 +-
> >  net/socket.c                   |  2 +-
> >  tools/include/uapi/linux/bpf.h |  7 +++++++
> >  6 files changed, 26 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index de8d3bd311f5..df2d790ae36b 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -471,7 +471,7 @@ struct skb_shared_hwtstamps {
> >  /* Definitions for tx_flags in struct skb_shared_info */
> >  enum {
> >       /* generate hardware time stamp */
> > -     SKBTX_HW_TSTAMP =3D 1 << 0,
> > +     __SKBTX_HW_TSTAMP =3D 1 << 0,
>
> Perhaps we can have a more descriptive name. SKBTX_HW_TSTAMP_NOBPF?

Good suggestion.

>
> >
> >       /* generate software time stamp when queueing packet to NIC */
> >       SKBTX_SW_TSTAMP =3D 1 << 1,
> > @@ -495,6 +495,8 @@ enum {
> >       SKBTX_BPF =3D 1 << 7,
> >  };
> >
> > +#define SKBTX_HW_TSTAMP              (__SKBTX_HW_TSTAMP | SKBTX_BPF)
> > +
> >  #define SKBTX_ANY_SW_TSTAMP  (SKBTX_SW_TSTAMP    | \
> >                                SKBTX_SCHED_TSTAMP | \
> >                                SKBTX_BPF)
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 6a1083bcf779..4c3566f623c2 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7040,6 +7040,13 @@ enum {
> >                                        * to the nic when SK_BPF_CB_TX_T=
IMESTAMPING
> >                                        * feature is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_HW_OPT_CB,      /* Called in hardware phase when
> > +                                      * SK_BPF_CB_TX_TIMESTAMPING feat=
ure
> > +                                      * is on. At the same time, hwtst=
amps
> > +                                      * of skb is initialized as the
> > +                                      * timestamp that hardware just
> > +                                      * generates.
>
> "hwtstamp of skb is initialized" is this something new? Or are you
> just conveying that when this callback is called, skb_hwtstamps(skb)
> is non-zero? If the latter, drop, because the wording is confusing.

I will update it.

>
> > +                                      */
> >  };
> >
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to det=
ect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index b22d079e7143..264435f989ad 100644
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
> >  }
> >
> >  static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk,
> > -                           int tstype, bool sw)
> > +                           int tstype, bool sw,
> > +                           struct skb_shared_hwtstamps *hwtstamps)
> >  {
> >       int op;
> >
> > @@ -5574,9 +5575,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb=
, struct sock *sk,
> >               op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> >               break;
> >       case SCM_TSTAMP_SND:
> > -             if (!sw)
> > -                     return;
> > -             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> > +             op =3D sw ? BPF_SOCK_OPS_TS_SW_OPT_CB : BPF_SOCK_OPS_TS_H=
W_OPT_CB;
> > +             if (!sw && hwtstamps)
> > +                     *skb_hwtstamps(skb) =3D *hwtstamps;
>
> Isn't this called by drivers that have actually set skb_hwtstamps?

Oops, somehow my mind has gone blank :( Will remove it. Thanks for
correcting me!

> >               break;
> >       default:
> >               return;
> > @@ -5599,7 +5600,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >
> >       /* bpf extension feature entry */
> >       if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> > -             skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw);
> > +             skb_tstamp_tx_bpf(orig_skb, sk, tstype, sw, hwtstamps);
> >
> >       /* application feature entry */
> >       if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
> > diff --git a/net/dsa/user.c b/net/dsa/user.c
> > index 291ab1b4acc4..ae715bf0ae75 100644
> > --- a/net/dsa/user.c
> > +++ b/net/dsa/user.c
> > @@ -897,7 +897,7 @@ static void dsa_skb_tx_timestamp(struct dsa_user_pr=
iv *p,
> >  {
> >       struct dsa_switch *ds =3D p->dp->ds;
> >
> > -     if (!(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
> > +     if (!(skb_shinfo(skb)->tx_flags & __SKBTX_HW_TSTAMP))
> >               return;
> >
> >       if (!ds->ops->port_txtstamp)
> > diff --git a/net/socket.c b/net/socket.c
> > index 262a28b59c7f..70eabb510ce6 100644
> > --- a/net/socket.c
> > +++ b/net/socket.c
> > @@ -676,7 +676,7 @@ void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_fl=
ags)
> >       u8 flags =3D *tx_flags;
> >
> >       if (tsflags & SOF_TIMESTAMPING_TX_HARDWARE) {
> > -             flags |=3D SKBTX_HW_TSTAMP;
> > +             flags |=3D __SKBTX_HW_TSTAMP;
> >
> >               /* PTP hardware clocks can provide a free running cycle c=
ounter
> >                * as a time base for virtual clocks. Tell driver to use =
the
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 9bd1c7c77b17..974b7f61d11f 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -7033,6 +7033,13 @@ enum {
> >                                        * to the nic when SK_BPF_CB_TX_T=
IMESTAMPING
> >                                        * feature is on.
> >                                        */
> > +     BPF_SOCK_OPS_TS_HW_OPT_CB,      /* Called in hardware phase when
> > +                                      * SK_BPF_CB_TX_TIMESTAMPING feat=
ure
> > +                                      * is on. At the same time, hwtst=
amps
> > +                                      * of skb is initialized as the
> > +                                      * timestamp that hardware just
> > +                                      * generates.
> > +                                      */
> >  };
> >
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to det=
ect
> > --
> > 2.43.5
> >
>
>

