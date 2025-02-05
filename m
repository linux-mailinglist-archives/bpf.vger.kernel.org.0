Return-Path: <bpf+bounces-50526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BD7A2957A
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED441888580
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101B91DDC0D;
	Wed,  5 Feb 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMi4Gvjc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A10191F60;
	Wed,  5 Feb 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738770964; cv=none; b=HULDzloveB9g7DT+d7z7uofZt8NUJE1TVFCJkEecqH5vCVfRGE9iLYF82eC/RIOuM2dR5SI/yGNoRqagL78UXQ43MSwaPuwRNj8NoF2+adpdU7BZkMWRETj9d57YlXOWzJAIob3u4dfVnVv7O6BNWjuM+wKX/WHkKOTTSttkrfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738770964; c=relaxed/simple;
	bh=qXo3vbZ2fNZhU6CXW2UnVOAzScds2ZAULsglRDmyByc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuNxtANGo9mmeqcDzApbKhGN3qwA9/jU8DLM8UezzfbYWcyLek9FRBSVQw3oxNkOPRL4uKGrNmNAjBaK0HkKsmf6jzZRTjKYZFEkpB0kmagyx9nsqLXLL1gSxUBIMxS3+8Itw/MOfN17iQ2yQDKwriATSwViHr21w/gHGVtgVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMi4Gvjc; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d04fc1ea14so9440135ab.2;
        Wed, 05 Feb 2025 07:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738770962; x=1739375762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsnZ94XprLkCeD//Mje7O/0uNLaKk3ocm4LFrRzaIu4=;
        b=gMi4Gvjc2o59bgqoUbTMhTPbLyawZltyiF4P+0+rlgOEODBa6DmzbgOq+QCj9HZDXS
         vKNsDjMRkmKlPIvnVyIaSZOVcnNamyzH6jTVx+Ns1yX0N76Gc6//cozI1dOt+UanMviz
         9gqvcczhsm/pO1DTZew5Adzixsrb1oEPwdlXDRnc2zyjApWElBGEYuKDfxbrZbEUM93b
         qMa43W+vUIaOLuv+qGD+IVQ4YOZlbloRuVGR++s4DsjqhO1U9WgxM4O2WXM8ETclTKlV
         SR2ZYTnW9p5XFLpfWOb6i56iw7tKjPPYLZGrDRvGtoJbiMOTdh9vzKBbdtr1Xkzmf7Q9
         AHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738770962; x=1739375762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dsnZ94XprLkCeD//Mje7O/0uNLaKk3ocm4LFrRzaIu4=;
        b=Yfmiv1Owx9g0k6LA2KGIC2O4mlRcDGW9o8X6LSsuOxQm/+d4jCipCbPVMspswpBr7d
         xNlqkmXASkKRfjQEjTyHkgSNgYZeUmNjp/PTwTIyWSZNFHQ3PG6Zy/S8l7b3l1qZBRRK
         5SuMOV6zeE2GI+ZkDqw3IVeGhsQUGb6qMB4uBJ/Er85i7r9FCDUP6Sf7KWmbv+dAKvMz
         jlEGqSfpX8gWsrkV7OtIY9afkjiJC4ORKbfJuNda7Vrbk/edSkdoh/asc4ehYjWpu2yd
         EBoJlyOYc8hIyoQkiTm+mM/oijnFsaa/YYUA6djWrUEBaV6Hvdxqd3Ywo+Ja2ItclE1+
         YdUw==
X-Forwarded-Encrypted: i=1; AJvYcCVzL8meJXkTfAqE8oC4pPexqApwmih1Dy8Rl+bZUcRFwkTsNH8yvPtGz5w+5StoIw3JYUY=@vger.kernel.org, AJvYcCWK9nHldlFXKqXAGUZHbPCd+Zy5f+5OnUomMc2DoNE3JnampPjq2srglZp3q9Eo43ZAWC5i2eKl@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJ6J9WP8fW7/cGl2A8eFOI1kcMsX4Porj/Xua0UbTgQ4GL6jU
	/9DYOtpFOVmK2FtpiHQhjCCM1bdsT5Iq0SNEBojjJw4/oUV2dfPzf2nXQv80irMgZHJm/0CPmzJ
	ZkI1d669TVe5JnULYNovEj/p6OPo=
X-Gm-Gg: ASbGnctXtkLHmUNTOHPi4LxD03f1zkp5/4vkV7jZbld2eXRUbpITuOjX7FpHkb92xAk
	or1S/UYmD5iS2cK+hhb1LHp/Rkh7K0vlBXdRfM5CGQn4k+thyJnUsQAwMgIdxOaCXk4L+los=
X-Google-Smtp-Source: AGHT+IHZHcZr9kT+J7MUR4EVpLO3HdTT2L+Le2iECgwSuaHgf12X3xPYwlgFXKH9X6tCZ6Tqorz81B6SHIfWJpK+c60=
X-Received: by 2002:a05:6e02:2163:b0:3d0:4b06:def3 with SMTP id
 e9e14a558f8ab-3d04f4429femr29203675ab.10.1738770961962; Wed, 05 Feb 2025
 07:56:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-7-kerneljasonxing@gmail.com> <67a385716d03f_14e08329459@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a385716d03f_14e08329459@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Feb 2025 23:55:25 +0800
X-Gm-Features: AWEUYZnb7w58SWqtQN0i_aVEcMZdJHYQuzublkFxe7PzJdJEaAOcgdfPOoG-qSY
Message-ID: <CAL+tcoD03rTjTBQyjCqTtoM+bL2Wdbxx5PAtnsFXzkuy7E_QmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 06/12] bpf: support SCM_TSTAMP_SCHED of SO_TIMESTAMPING
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

On Wed, Feb 5, 2025 at 11:36=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Introducing SKBTX_BPF is used as an indicator telling us whether
> > the skb should be traced by the bpf prog.
>
> Should this say support the SCM_TSTAMP_SCHED case?

Will do it.

>
> Also: imperative mood: Introduce instead of Introducing.

Oh, sorry, I have to take an English lesson :S Apparently I didn't
know the difference :( Will adjust accordingly.

>
>
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/linux/skbuff.h         |  6 +++++-
> >  include/uapi/linux/bpf.h       |  4 ++++
> >  net/core/dev.c                 |  3 ++-
> >  net/core/skbuff.c              | 20 ++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  4 ++++
> >  5 files changed, 35 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index dfc419281cc9..35c2e864dd4b 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -490,10 +490,14 @@ enum {
> >
> >       /* generate software time stamp when entering packet scheduling *=
/
> >       SKBTX_SCHED_TSTAMP =3D 1 << 6,
> > +
> > +     /* used for bpf extension when a bpf program is loaded */
> > +     SKBTX_BPF =3D 1 << 7,
> >  };
> >
> >  #define SKBTX_ANY_SW_TSTAMP  (SKBTX_SW_TSTAMP    | \
> > -                              SKBTX_SCHED_TSTAMP)
> > +                              SKBTX_SCHED_TSTAMP | \
> > +                              SKBTX_BPF)
> >  #define SKBTX_ANY_TSTAMP     (SKBTX_HW_TSTAMP | \
> >                                SKBTX_HW_TSTAMP_USE_CYCLES | \
> >                                SKBTX_ANY_SW_TSTAMP)
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 6116eb3d1515..30d2c078966b 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7032,6 +7032,10 @@ enum {
> >                                        * by the kernel or the
> >                                        * earlier bpf-progs.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SCHED_OPT_CB,   /* Called when skb is passing thr=
ough
> > +                                      * dev layer when SK_BPF_CB_TX_TI=
MESTAMPING
> > +                                      * feature is on.
> > +                                      */
> >  };
> >
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to det=
ect
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index d77b8389753e..4f291459d6b1 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4500,7 +4500,8 @@ int __dev_queue_xmit(struct sk_buff *skb, struct =
net_device *sb_dev)
> >       skb_reset_mac_header(skb);
> >       skb_assert_len(skb);
> >
> > -     if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP))
> > +     if (unlikely(skb_shinfo(skb)->tx_flags &
> > +                  (SKBTX_SCHED_TSTAMP | SKBTX_BPF)))
> >               __skb_tstamp_tx(skb, NULL, NULL, skb->sk, true, SCM_TSTAM=
P_SCHED);
> >
> >       /* Disable soft irqs for various locks below. Also
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 6042961dfc02..b7261e886529 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5564,6 +5564,21 @@ static bool skb_enable_app_tstamp(struct sk_buff=
 *skb, int tstype, bool sw)
> >       return false;
> >  }
> >
> > +static void skb_tstamp_tx_bpf(struct sk_buff *skb, struct sock *sk, in=
t tstype)
> > +{
> > +     int op;
> > +
> > +     switch (tstype) {
> > +     case SCM_TSTAMP_SCHED:
> > +             op =3D BPF_SOCK_OPS_TS_SCHED_OPT_CB;
> > +             break;
> > +     default:
> > +             return;
> > +     }
> > +
> > +     bpf_skops_tx_timestamping(sk, skb, op);
> > +}
> > +
> >  void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >                    const struct sk_buff *ack_skb,
> >                    struct skb_shared_hwtstamps *hwtstamps,
> > @@ -5576,6 +5591,11 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
> >       if (!sk)
> >               return;
> >
> > +     /* bpf extension feature entry */
> > +     if (skb_shinfo(orig_skb)->tx_flags & SKBTX_BPF)
> > +             skb_tstamp_tx_bpf(orig_skb, sk, tstype);
> > +
> > +     /* application feature entry */
> >       if (!skb_enable_app_tstamp(orig_skb, tstype, sw))
> >               return;
> >
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 70366f74ef4e..eed91b7296b7 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -7025,6 +7025,10 @@ enum {
> >                                        * by the kernel or the
> >                                        * earlier bpf-progs.
> >                                        */
> > +     BPF_SOCK_OPS_TS_SCHED_OPT_CB,   /* Called when skb is passing thr=
ough
> > +                                      * dev layer when SK_BPF_CB_TX_TI=
MESTAMPING
> > +                                      * feature is on.
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

