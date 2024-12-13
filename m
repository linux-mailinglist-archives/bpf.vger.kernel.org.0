Return-Path: <bpf+bounces-46856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B4B9F0F84
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405D228351A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02A1E25F7;
	Fri, 13 Dec 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6VvuRo0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329931E105B;
	Fri, 13 Dec 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101416; cv=none; b=WV5F/wB6YBmfLvFT+pd0nxZWjwYJ6HUfzcwWIe2ryRn5P0skfs1Yin4ulKG6RxiMzws0W8npsVy382EQ6D7Rb2e2zQOhIzObcjlhoCJmJAdgdS7Cai6pspip8tWYufrov/A0xHUWT/8tq8u5kQBLuSYsA1s48COG5t1PJYk+dX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101416; c=relaxed/simple;
	bh=xw2qwDPU03pE3skGrfstCy9lqdnfMzXHLdzFcKKwqsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWMr3WMAfzwZbhbt4upzXIXmjgJOA2ll7uxGpxeU6c5ilFul/OxR+eAH93P5t8JaNiuunSELFobcRJfyCCcoVnunQ1juT3pH1w08uFBsNfjpmueMFKc45cdfzsPohZkuah4q8tEaL6Wo0dS4iZ3J05yKo+y8ccl1DQN/biQVPWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6VvuRo0; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a8c7b02d68so14648205ab.3;
        Fri, 13 Dec 2024 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734101414; x=1734706214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HO1hiKxaNhQPtZZ3RLZDJ5A2jzz1tPrRbupJAy1aZ8=;
        b=O6VvuRo0SkmvwhpPZVxV4+ZwrbVpR+IsNPSVPdQy7qb5gvw5IbnavncrjEynrwL3s+
         FsOHoZnL/aZcRN0ttTNqqw9O30x+EZwEOGmoUOclPdoiiq55Xf0oIFXw97r3aGXJotvV
         JQ9lpOCWx1iEhYTCezRK+aU7S6a0PHSjBcsQxC67+uXcEzLcY5tN/vYYxk8hjl/kah4t
         l4jQEn4wK+S16cXILbubKisMNQ8RslW9CSZl0F388p72SzAH8q93bD0slnDhR6McINi5
         WBf9eLgTxJTTqIaE94ZPiJV6Wmn7DEmukns2/n6pHo5Rd/KuR+l9xqbC9I3E6YD2ZhR5
         M5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101414; x=1734706214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HO1hiKxaNhQPtZZ3RLZDJ5A2jzz1tPrRbupJAy1aZ8=;
        b=BPUFBEzkpWyeI1sPayRk0Gvr7NTf1dxR3qrSMM6b7XW3Iws036KkZf3NOK32q039iV
         AJJ+luFvH3vVxkpyFmwlsQ8S+yIxXFD/GfvjqSlpvx20h1B9pNltZp2sCLpJl5n5qOfs
         wJs1BDDUrkF25viXd+LI/qFK3BU5bojCYKApco033g2KI6hp1Sll98tpXMXXCJtHQcdj
         jB1h780hoT2hNZaHweJ4LuTDrKWHFp5jz3byLj8ou6F+I0mmW5+KuFTgI3FDonNewiYo
         52E+Xghn5ZYgFL5uJqeYH0msXXY+dCdFE2fWEG9LL9MqsmY8NMU3ExzN4w3k//wZN38u
         LmmA==
X-Forwarded-Encrypted: i=1; AJvYcCWLjbnVXzSTdaiXj2jzy6rBcVNa6n2sGfv/EzprKlMNxHkjDGH3+gVXOr9EmYjd7yVUanEeJoK9@vger.kernel.org, AJvYcCXHhHj3qrgtDxTrCKHiUmHuGm0f3Zlw9jrJpdA6ECAHEtuXAxd8L7bnLahyoAxKsTppqrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrtRQXpo/u4ooLSpPwly/6AT65w2HMVykAlHf/PNmgknCWsFYo
	QkClYNWM8LV1/i/A6MuV49YfnK2IPCMO7DnP5MKg1tM0dUxbYlh67VGodMTOpT9enCbb/QuOZPR
	l0pBtMFZENFkLYaTB6grCd/ZLDeQ=
X-Gm-Gg: ASbGncuLmDKHoQRSHjEHa7hzqFhGgjuZeAD8rrmVXlbgQbVThO6sXM8P38xJ+NUFc9z
	8vfzq/57VdvOgz0pVdmvoa85QMWLHO6eZ8NtgPA==
X-Google-Smtp-Source: AGHT+IFk6yxPexolgRkFLo5lTRr6FRWpSXk0gg6CH38CoabrQNKOrdodzyIrl9HZGICy7/aqXtukGvHwyMTOCEfpSaI=
X-Received: by 2002:a05:6e02:1fc6:b0:3a7:6e34:9219 with SMTP id
 e9e14a558f8ab-3aff630e9bdmr28797235ab.14.1734101414148; Fri, 13 Dec 2024
 06:50:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-7-kerneljasonxing@gmail.com> <6ccdc72c-f21c-4b02-aba3-b70363e58982@linux.dev>
In-Reply-To: <6ccdc72c-f21c-4b02-aba3-b70363e58982@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 13 Dec 2024 22:49:38 +0800
Message-ID: <CAL+tcoD+hf+o8SFpnxLRQPKiuqopbHMbU5taap=Va+0hMjJP5A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 06/11] net-timestamp: support SCM_TSTAMP_ACK
 for bpf extension
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 6:36=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/7/24 9:37 AM, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Handle the ACK timestamp case. Actually testing SKBTX_BPF flag
> > can work, but we need to Introduce a new txstamp_ack_bpf to avoid
> > cache line misses in tcp_ack_tstamp().
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >   include/net/tcp.h              | 3 ++-
> >   include/uapi/linux/bpf.h       | 5 +++++
> >   net/core/skbuff.c              | 9 ++++++---
> >   net/ipv4/tcp_input.c           | 3 ++-
> >   net/ipv4/tcp_output.c          | 5 +++++
> >   tools/include/uapi/linux/bpf.h | 5 +++++
> >   6 files changed, 25 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index e9b37b76e894..8e5103d3c6b9 100644
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
>
> After quickly peeking at patch 8, I realize that the new txstamp_ack_bpf =
bit is
> not needed. SKBTX_BPF bit (in skb_shinfo(skb)->tx_flags) and the txstamp_=
ack_bpf
> are always set together. Then only use the SKBTX_BPF bit should be as goo=
d.

Please see the comments below :)

>
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
> > index a6d761f07f67..a0aff1b4eb61 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7032,6 +7032,11 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_ACK_OPT_CB,     /* Called when all the skbs are
> > +                                      * acknowledged when SO_TIMESTAMP=
ING
> > +                                      * feature is on. It indicates th=
e
> > +                                      * recorded timestamp.
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index 73b15d6277f7..48b0c71e9522 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -5553,6 +5553,9 @@ static void __skb_tstamp_tx_bpf(struct sock *sk, =
struct sk_buff *skb, int tstype
> >       case SCM_TSTAMP_SND:
> >               op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> >               break;
> > +     case SCM_TSTAMP_ACK:
> > +             op =3D BPF_SOCK_OPS_TS_ACK_OPT_CB;
> > +             break;
> >       default:
> >               return;
> >       }
> > @@ -5632,9 +5635,9 @@ static bool skb_tstamp_is_set(const struct sk_buf=
f *skb, int tstype, bool bpf_mo
> >                       return true;
> >               return false;
> >       case SCM_TSTAMP_ACK:
> > -             if (TCP_SKB_CB(skb)->txstamp_ack)
> > -                     return true;
> > -             return false;
> > +             flag =3D bpf_mode ? TCP_SKB_CB(skb)->txstamp_ack_bpf :
> > +                               TCP_SKB_CB(skb)->txstamp_ack;
> > +             return !!flag;
> >       }
> >
> >       return false;
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 5bdf13ac26ef..82bb26f5b214 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -3321,7 +3321,8 @@ static void tcp_ack_tstamp(struct sock *sk, struc=
t sk_buff *skb,
> >       const struct skb_shared_info *shinfo;
> >
> >       /* Avoid cache line misses to get skb_shinfo() and shinfo->tx_fla=
gs */

Please take a look at the above comment.

> > -     if (likely(!TCP_SKB_CB(skb)->txstamp_ack))
> > +     if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
> > +                !TCP_SKB_CB(skb)->txstamp_ack_bpf))
>
> Change the test here to:
>         if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
>                    !(skb_shinfo(skb)->tx_flags & SKBTX_BPF)))
>
> Does it make sense?

It surely works. Talking about the result only, introducing SKBTX_BPF
can work for all the cases. However, in the ACK case, the above code
snippet will access the shinfo->tx_flags, which triggers cache line
misses. I also mentioned this on purpose in the patch [06/11].

