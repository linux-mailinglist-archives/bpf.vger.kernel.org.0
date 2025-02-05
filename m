Return-Path: <bpf+bounces-50567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D88A29BDA
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 22:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6B03A27FC
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303F5214A9B;
	Wed,  5 Feb 2025 21:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA5/txvt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C9623CE;
	Wed,  5 Feb 2025 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738790760; cv=none; b=mFgJ+0ozAgAKxPEsnPBcn5V50lXshdhwhkX0udr92nCwftIUiT6TYBA9hFXKFIFurGcR9wzThM1HX/JKk/8y+yCI7E90pDzVQcj4T3W2RZbxAkGQOR+6DKGTG3KVqvzWiHr7Eyz/rQtkNlq8wvISq90edOY266J7a93HUll61/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738790760; c=relaxed/simple;
	bh=T11tjeEY7jYrQ/vFe799MmT/eCdQkOfyydxYpl67hFY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oyzDQ8eJZ08QM1Jjses/GL3qSfxyodA4UaBD0k9xOVCkKqHevR7znxRsL0GR+GCnuStNw0FlSBRm4M2ImaIXq1q/IwL0AkPVrSvvk4yDlBqyW5VFgnpqE2qTPrM5jVPKw4LZM0PXyv1keJf5GNcEiAEQyDJLx2fBJ2W2Fut1r20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA5/txvt; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51eb1a6ca1bso57992e0c.1;
        Wed, 05 Feb 2025 13:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738790758; x=1739395558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzI85NHvWbuwFmYXawnHRXS4QHSJnJYXNeO7PRXXniA=;
        b=KA5/txvtbBNk4bKq9E5CfOB8DT7leio97GfoxAwU2dvF9i+z1sw86J8eWr0+lXQYng
         JGv4wMLIm6zgwT35LPC/nlEVGO96eKiuyvQhK+h2v/c/myTvpPFqPL7qRrAyDYiGeirn
         iaRtl9N5eITNMhkVU5Nx4DpXo05xDkt2Vi4oh/r4vii4Qkc0q/YNgQ/Yd5hWMERh9mk2
         AXoExXR6DCM+yX5mrKhnWT3JDDKpgrXisMo6BLw+w7tRsQts22a9o95XpHRHKnDsQ4N4
         RddBdbBNYmK06MKm8i3IbIztsxTp+/1Bdlg+LlGjOVvjts1qFvF6BJWHG/bhgcmZ1lKO
         uVog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738790758; x=1739395558;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lzI85NHvWbuwFmYXawnHRXS4QHSJnJYXNeO7PRXXniA=;
        b=KS/CzZyvNmpfgYnulpKGnn7d1JUalxEV5IdibHOKTh1BS0P60ZMh/X0MOMe+/0ixbe
         hGDWPlX82v4lgWc6gkfJ2o6gndHLHchNFMpiEW+oRNDaJJzn0q0dzq/w93ZeDFkoKTtY
         Tg0ViXIkd5f5co1EC3zKpBuMwd2ifE+lwWS1zvbSP/bK/e842KbaHxtpem5E32vBkCMD
         3jhYRB8/NHrw2vrcDQEHYn95HcSdsPCv7yS1+YXhDKh+qCYZtXiUiykWM9o65pH5nD21
         edmT7Tu5Sp9VBbASt2snyD6XTbHs7mEwYeNPf8L1QqPKTp/XhP7wiQgwCkmwFuQg3W1H
         B6pw==
X-Forwarded-Encrypted: i=1; AJvYcCUlcIPjKDTVBFuyOJI3YQv5iUfeGk9xLesL/UOMCzc69NI8iyN+A2Y2ADvpRIVbpRPgcNo=@vger.kernel.org, AJvYcCWzTs0Pi5u0f5XH7xFlLpjMx4oa5Rhtt+jbkr9CiKTQ+IMhcHqh8X0vWFFe/D6tZYk9BiUo4aZO@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/ZZyp+YNBw0zIK8h6a+2F8Lcj8rgHtwZ/uUoiA+6STQrpQH6
	Q6c+Lc2KPbMGL93BuLMGVov9MOP22GZaHhrrL5iuGD2GzT6zGwS3
X-Gm-Gg: ASbGncsZ7jOHBKcKZymnf0UTXEELiDnZAqNLJSDb8RRH74iDo3LOoF1AF+58kVd6Cnn
	VdvVSOe7Z3tIYspH4MggcKXbneur5AMnWrrng7dAGR6WIu7TcA+rphLxrwP6P4Q9GWyCm2LAq3A
	3MFROCZa9K70kNZScc8AXz6MkLEAxDLA9fda9ykPPlYOs//6GuZPxmg+hQ5xBMeRU6VMhuAFpeo
	9y6M99oMdU04+CZGh96xk8atZ5jabFB++xyAupMfFgpwy/UQBSRpEAhE5GM02Uikad+TBJKT5Cq
	4GDL+SVn7mUsC0H2/1Qo/LLZG9IK1jNm84gM1hOBQDDDzg7v9Hq+llRoaReMQQ0=
X-Google-Smtp-Source: AGHT+IFfZFV30LtFls4l1TAnpp8Tvb3dzELXh33kFdwbmCqyz/4f3BUu6LwGO8SXCVRNE90NNVobQg==
X-Received: by 2002:a05:6122:ecc:b0:518:97c2:f21a with SMTP id 71dfb90a1353d-51f0c4f3d75mr3108819e0c.6.1738790758045;
        Wed, 05 Feb 2025 13:25:58 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1c3ca03sm1993509e0c.24.2025.02.05.13.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:25:57 -0800 (PST)
Date: Wed, 05 Feb 2025 16:25:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Message-ID: <67a3d764ee25d_170d39294dc@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoD+Op+xX+MVy_dBd4GHRdQ+1RTKj6nyR_nK-HSTcHU7vQ@mail.gmail.com>
References: <20250204183024.87508-1-kerneljasonxing@gmail.com>
 <20250204183024.87508-10-kerneljasonxing@gmail.com>
 <67a3881cd3846_14e083294bb@willemb.c.googlers.com.notmuch>
 <CAL+tcoD+Op+xX+MVy_dBd4GHRdQ+1RTKj6nyR_nK-HSTcHU7vQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 09/12] bpf: support SCM_TSTAMP_ACK of
 SO_TIMESTAMPING
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Wed, Feb 5, 2025 at 11:47=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > Handle the ACK timestamp case. Actually testing SKBTX_BPF flag
> > > can work, but Introducing a new txstamp_ack_bpf to avoid cache
> >
> > repeat comment: s/Introducing/introduce
> >
> > > line misses in tcp_ack_tstamp() is needed. To be more specific,
> > > in most cases, normal flows would not access skb_shinfo as
> > > txstamp_ack is zero, so that this function won't appear in the
> > > hot spot lists. Introducing a new member txstamp_ack_bpf works
> > > similarly.
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >  include/net/tcp.h              | 3 ++-
> > >  include/uapi/linux/bpf.h       | 5 +++++
> > >  net/core/skbuff.c              | 3 +++
> > >  net/ipv4/tcp_input.c           | 3 ++-
> > >  net/ipv4/tcp_output.c          | 5 +++++
> > >  tools/include/uapi/linux/bpf.h | 5 +++++
> > >  6 files changed, 22 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > index 293047694710..88429e422301 100644
> > > --- a/include/net/tcp.h
> > > +++ b/include/net/tcp.h
> > > @@ -959,9 +959,10 @@ struct tcp_skb_cb {
> > >       __u8            sacked;         /* State flags for SACK.     =
   */
> > >       __u8            ip_dsfield;     /* IPv4 tos or IPv6 dsfield  =
   */
> > >       __u8            txstamp_ack:1,  /* Record TX timestamp for ac=
k? */
> > > +                     txstamp_ack_bpf:1,      /* ack timestamp for =
bpf use */
> > >                       eor:1,          /* Is skb MSG_EOR marked? */
> > >                       has_rxtstamp:1, /* SKB has a RX timestamp    =
   */
> > > -                     unused:5;
> > > +                     unused:4;
> > >       __u32           ack_seq;        /* Sequence number ACK'd     =
   */
> > >       union {
> > >               struct {
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 4c3566f623c2..800122a8abe5 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -7047,6 +7047,11 @@ enum {
> > >                                        * timestamp that hardware ju=
st
> > >                                        * generates.
> > >                                        */
> > > +     BPF_SOCK_OPS_TS_ACK_OPT_CB,     /* Called when all the skbs i=
n the
> > > +                                      * same sendmsg call are acke=
d
> > > +                                      * when SK_BPF_CB_TX_TIMESTAM=
PING
> > > +                                      * feature is on.
> > > +                                      */
> > >  };
> > >
> > >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to=
 detect
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 264435f989ad..a8463fef574a 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -5579,6 +5579,9 @@ static void skb_tstamp_tx_bpf(struct sk_buff =
*skb, struct sock *sk,
> > >               if (!sw && hwtstamps)
> > >                       *skb_hwtstamps(skb) =3D *hwtstamps;
> > >               break;
> > > +     case SCM_TSTAMP_ACK:
> > > +             op =3D BPF_SOCK_OPS_TS_ACK_OPT_CB;
> > > +             break;
> > >       default:
> > >               return;
> > >       }
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 62252702929d..c8945f5be31b 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -3323,7 +3323,8 @@ static void tcp_ack_tstamp(struct sock *sk, s=
truct sk_buff *skb,
> > >       const struct skb_shared_info *shinfo;
> > >
> > >       /* Avoid cache line misses to get skb_shinfo() and shinfo->tx=
_flags */
> > > -     if (likely(!TCP_SKB_CB(skb)->txstamp_ack))
> > > +     if (likely(!TCP_SKB_CB(skb)->txstamp_ack &&
> > > +                !TCP_SKB_CB(skb)->txstamp_ack_bpf))
> >
> > Here and elsewhere: instead of requiring multiple tests, how about
> > extending txstamp_ack to a two-bit field, so that a single branch
> > suffices.
> =

> It should work. Let me assume 1 stands for so_timestamping, 2 bpf exten=
sion?

Sounds good=

