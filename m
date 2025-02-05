Return-Path: <bpf+bounces-50528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F78CA295B3
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D733161C8B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00821D86C6;
	Wed,  5 Feb 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOcmOB+Y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18E318A6B8;
	Wed,  5 Feb 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738771622; cv=none; b=kKOYPWk1NiCBFQ7t20eHHReF6ZQ8AbVRhM+ZM4xuZxtxHuBsktNXV56PzcfQr0nFgUq4MpV5zKV1c8z2M0RTHkw0GbNW7qarJRO/ANZbzqjyaGy9Aj1i34b9nC6nXhsuAtnudbUqb+oTnRcXeZwZis+Qdleq1YD0LAbPpRFz5x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738771622; c=relaxed/simple;
	bh=yXfstirOlJvvZMKCqMtrnD0kdH4lPnIc43wCsudwCoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WitiYfCgMiJoZ/ZJHyLpMvqEiQLsOTTdqSF+NiWWAwGXadhWXhY5hPRKRGCmtmwqq/zCr767CQX5HXduHo1/IUPnwB7SL1XTzHeNEfW3GwDn2s32FgOuiowmDPEcmmdlY2D6g3OVujhvC5jgXCN/KtS/7TTQsW27ppjvsXRj+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOcmOB+Y; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d03d2bd7d2so18177635ab.0;
        Wed, 05 Feb 2025 08:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738771620; x=1739376420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RN1/qPlAtPbGpVXyvsLFKOS/HzZCjMR0JX6LcD6SbYU=;
        b=DOcmOB+YPCJ21uPwucbaT6O/DaOMnZPRc/ADurQ1hxNB87DHEHnM6iydbgEOzVLsqt
         646C+Rhxym80OyeEP61503P1LO+yHzzU/oXNBPFA+rWpOIfmusAgLO5lnRYDLX3d7hMb
         isW45Rp6DT+LPN5DXOP5zGUSlw5DwTwy8RDmEUkuokwSMSUaiPvQ1sPRK8Z6C1epaS+Q
         xwlCg/ypimo8wNdv0R4C4ZGr/lUzAi/CgEBtMa5pxluhdvSmo9ULqp3GllSoqnhVYWTf
         g6JvVLMjj6+vODqwrd1zvk4y9c2Vewyn3nCHgQbO32Ku8U3Tnw2GOOffpIIxCvXjj93R
         eAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738771620; x=1739376420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RN1/qPlAtPbGpVXyvsLFKOS/HzZCjMR0JX6LcD6SbYU=;
        b=fHBC+Pwk1eUVH6vNwPzg0fbvhbEAFNh6kU1CDRp9t5x0X1i5gwQciU05BIXKubPIFA
         aS0iRpUBj5x787zudDvf7H/oy1HwOKkEIPmR3dU/QlDwgV2Gpe7COFHlkRFMjlZ20Qlf
         I+xaLp7epFHr9aWjX7ccNsmm+uNB/3CZB6w6lOIDPX09Za6oVmlQTmGh3v+NRnRdZOhs
         v2xxG1YPuouYeJUGWM8lmU/Oy2etRj7nKoElBTzF4sQKAPYVxPObS6mtM4mr7MGRp06+
         Csef7aO7zYBjNucikNoWxCjRR9RKO74m14r9ZuTbG+wqGtDxxGwo67du9vrxJKAArlse
         OXxg==
X-Forwarded-Encrypted: i=1; AJvYcCU5YkihjlE5Dy+slOx03kBKyveVS1wLwsjgtlLCRTdAiRO4zOVqU4pyAKxQzK/mjZMnzWRPLrRJ@vger.kernel.org, AJvYcCXjz4cvhkXu7Vwz2XZIOejnWIV4POR6ob5FTZzS9wVICLGG/nq0tJQx0c8ZjkvNkwmvaMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHwODePXafpq37KgJp/l3zXwtVcw5pltcEbHPTE2BU2QU/czAe
	VjGWvNen9WTWJDQd1gOFjXdV2Mget6kWp2HqQOBCdvSFbQOpgyqE2Knpu+HcxldMlo7qLbLS+CG
	IjwLfzyvHnqXapS+k3m+DV+FtJ0a+xBip6juo8w==
X-Gm-Gg: ASbGncuujMbR9mThaXGfHU3gG+shcDCpquRV5BKUjqEgr9EFKuvf9Ern9kCLch1JnWx
	STcv2nacWLiwvqgvM+VWjPwxmOKBohweV/WSx1pe8Y+ANq2b2W14Z5yVdYZjpgq3x378FLTU=
X-Google-Smtp-Source: AGHT+IGJbIPuLQUzoPKoERUZtkWVXYwRuFmgMiRlS0T9AJ0uLDYuwApO35j/kvJAV1mx/eayuZ8CUhNwPry57PrC8fI=
X-Received: by 2002:a05:6e02:2188:b0:3cf:c9ad:46a1 with SMTP id
 e9e14a558f8ab-3d04f7fa411mr26772435ab.13.1738771618716; Wed, 05 Feb 2025
 08:06:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-10-kerneljasonxing@gmail.com> <67a3881cd3846_14e083294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <67a3881cd3846_14e083294bb@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 6 Feb 2025 00:06:21 +0800
X-Gm-Features: AWEUYZlARbcFEKYOneD33Whb2d0hg6NKHwtkzkYBYOek-0JOSHsY1nY6DPvcfj8
Message-ID: <CAL+tcoD+Op+xX+MVy_dBd4GHRdQ+1RTKj6nyR_nK-HSTcHU7vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 09/12] bpf: support SCM_TSTAMP_ACK of SO_TIMESTAMPING
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

On Wed, Feb 5, 2025 at 11:47=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > Handle the ACK timestamp case. Actually testing SKBTX_BPF flag
> > can work, but Introducing a new txstamp_ack_bpf to avoid cache
>
> repeat comment: s/Introducing/introduce
>
> > line misses in tcp_ack_tstamp() is needed. To be more specific,
> > in most cases, normal flows would not access skb_shinfo as
> > txstamp_ack is zero, so that this function won't appear in the
> > hot spot lists. Introducing a new member txstamp_ack_bpf works
> > similarly.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >  include/net/tcp.h              | 3 ++-
> >  include/uapi/linux/bpf.h       | 5 +++++
> >  net/core/skbuff.c              | 3 +++
> >  net/ipv4/tcp_input.c           | 3 ++-
> >  net/ipv4/tcp_output.c          | 5 +++++
> >  tools/include/uapi/linux/bpf.h | 5 +++++
> >  6 files changed, 22 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index 293047694710..88429e422301 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -959,9 +959,10 @@ struct tcp_skb_cb {
> >       __u8            sacked;         /* State flags for SACK.        *=
/
> >       __u8            ip_dsfield;     /* IPv4 tos or IPv6 dsfield     *=
/
> >       __u8            txstamp_ack:1,  /* Record TX timestamp for ack? *=
/
> > +                     txstamp_ack_bpf:1,      /* ack timestamp for bpf =
use */
> >                       eor:1,          /* Is skb MSG_EOR marked? */
> >                       has_rxtstamp:1, /* SKB has a RX timestamp       *=
/
> > -                     unused:5;
> > +                     unused:4;
> >       __u32           ack_seq;        /* Sequence number ACK'd        *=
/
> >       union {
> >               struct {
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 4c3566f623c2..800122a8abe5 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7047,6 +7047,11 @@ enum {
> >                                        * timestamp that hardware just
> >                                        * generates.
> >                                        */
> > +     BPF_SOCK_OPS_TS_ACK_OPT_CB,     /* Called when all the skbs in th=
e
> > +                                      * same sendmsg call are acked
> > +                                      * when SK_BPF_CB_TX_TIMESTAMPING
> > +                                      * feature is on.
> > +                                      */
> >  };
> >
> >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to det=
ect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 264435f989ad..a8463fef574a 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5579,6 +5579,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff *skb=
, struct sock *sk,
> >               if (!sw && hwtstamps)
> >                       *skb_hwtstamps(skb) =3D *hwtstamps;
> >               break;
> > +     case SCM_TSTAMP_ACK:
> > +             op =3D BPF_SOCK_OPS_TS_ACK_OPT_CB;
> > +             break;
> >       default:
> >               return;
> >       }
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 62252702929d..c8945f5be31b 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3323,7 +3323,8 @@ static void tcp_ack_tstamp(struct sock *sk, struc=
t sk_buff *skb,
> >       const struct skb_shared_info *shinfo;
> >
> >       /* Avoid cache line misses to get skb_shinfo() and shinfo->tx_fla=
gs */
> > -     if (likely(!TCP_SKB_CB(skb)->txstamp_ack))
> > +     if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
> > +                !TCP_SKB_CB(skb)->txstamp_ack_bpf))
>
> Here and elsewhere: instead of requiring multiple tests, how about
> extending txstamp_ack to a two-bit field, so that a single branch
> suffices.

It should work. Let me assume 1 stands for so_timestamping, 2 bpf extension=
?

>
> >               return;
> >
> >       shinfo =3D skb_shinfo(skb);
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 695749807c09..fc84ca669b76 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -1556,6 +1556,7 @@ static void tcp_adjust_pcount(struct sock *sk, co=
nst struct sk_buff *skb, int de
> >  static bool tcp_has_tx_tstamp(const struct sk_buff *skb)
> >  {
> >       return TCP_SKB_CB(skb)->txstamp_ack ||
> > +            TCP_SKB_CB(skb)->txstamp_ack_bpf ||
> >               (skb_shinfo(skb)->tx_flags & SKBTX_ANY_TSTAMP);
> >  }
> >
> > @@ -1572,7 +1573,9 @@ static void tcp_fragment_tstamp(struct sk_buff *s=
kb, struct sk_buff *skb2)
> >               shinfo2->tx_flags |=3D tsflags;
> >               swap(shinfo->tskey, shinfo2->tskey);
> >               TCP_SKB_CB(skb2)->txstamp_ack =3D TCP_SKB_CB(skb)->txstam=
p_ack;
> > +             TCP_SKB_CB(skb2)->txstamp_ack_bpf =3D TCP_SKB_CB(skb)->tx=
stamp_ack_bpf;
> >               TCP_SKB_CB(skb)->txstamp_ack =3D 0;
> > +             TCP_SKB_CB(skb)->txstamp_ack_bpf =3D 0;
> >       }
> >  }
> >
> > @@ -3213,6 +3216,8 @@ void tcp_skb_collapse_tstamp(struct sk_buff *skb,
> >               shinfo->tskey =3D next_shinfo->tskey;
> >               TCP_SKB_CB(skb)->txstamp_ack |=3D
> >                       TCP_SKB_CB(next_skb)->txstamp_ack;
> > +             TCP_SKB_CB(skb)->txstamp_ack_bpf |=3D
> > +                     TCP_SKB_CB(next_skb)->txstamp_ack_bpf;
> >       }
> >  }
> >
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 974b7f61d11f..06e68d772989 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -7040,6 +7040,11 @@ enum {
> >                                        * timestamp that hardware just
> >                                        * generates.
> >                                        */
> > +     BPF_SOCK_OPS_TS_ACK_OPT_CB,     /* Called when all the skbs in th=
e
> > +                                      * same sendmsg call are acked
> > +                                      * when SK_BPF_CB_TX_TIMESTAMPING
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

