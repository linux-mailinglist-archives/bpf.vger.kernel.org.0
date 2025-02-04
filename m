Return-Path: <bpf+bounces-50349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAF9A2693F
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 02:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE8FC3A43BD
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2025 01:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7055478F51;
	Tue,  4 Feb 2025 01:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6pTfhd3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E56586330;
	Tue,  4 Feb 2025 01:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738631666; cv=none; b=AHU0GGWsTRz/oBDCtSik8Q1It9whF4LFhMZfXsn76EOZMSanHbQeOIHldROIHl3LxhpFNlcotY2oRFIurKfLzmufq8QIT9qcpIfPZ571Rsu7IwEDd33TkN8J+SrnOFh6zQA4kxjTiMuPXap4hQzI9zbv9eAlKVkycKoPaPrvNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738631666; c=relaxed/simple;
	bh=i2WJMbSyOy/XuYTeLhREJLm2nPU/JUDV3siy9/vW0jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mh/ndMja5uoEqhVFt4rhxWqP95uYVNBK4fNOqVviZxlmOYYd0kGh/bKFTg63qvYBrzMdw/apalOeaLxSyeThvu3EP+oP5WHVd6bK4MvA8tiBNkKKnYtwcCe2OBzYRxfQZO5SVqYGlI1ciRN39aUhU5eMd+868GkVoTNgpkLnLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6pTfhd3; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844e06e5d11so135247039f.0;
        Mon, 03 Feb 2025 17:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738631663; x=1739236463; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uU2sc4niz9zc4FabXg2b3mLsphy1POkn5heO96mQGI=;
        b=F6pTfhd31xNcYY4wREbyf4N4v6FP6bqoUR5Y+IkFkh2TdZj8XW+I77Sk1cjermU+vz
         ECTLwQIX7J73U0//LCAFPGnZLsIoRL3xE3vt67T0IFtlUxksE6XVczDmNNAez+BbNHK/
         vR3xyBYT8J1agZG1rL5PFj+mDupC4XrJ3U0gitFquxwtDDhjbJZm7UduP5b19XOJWXSW
         Hho/BrJ7WUIm8NDSPWYvAigsBIcsd0evDknm3vwH4T1pJoycEVkGJ3qSSmycKx2b5yqL
         dsb5+apEYJQRctJKUPwjIBMibQrneglDCkmNpRJyIvdedNFttgQhFb3eRyneuYcjM2lQ
         WEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738631663; x=1739236463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uU2sc4niz9zc4FabXg2b3mLsphy1POkn5heO96mQGI=;
        b=m/oQQXQWgRayUnf5vQmobuet7Kl0O9MSAxJWYV/nwJgO15eEPuuvfDR2Zu+HN52GVc
         XRBnL2MMtqjQf5y502iPFN3q426534LTugSap2C+60EAVfSnPvWsE+N+VZh0p6tuBDXv
         UDOx3CUtaalkxFND1ix3u6MWcJx4YjkFJAOiNNt7Lq8v6qwFxG76xkWS5LAiCi+qeaJY
         pXg7096KdRmWw9+/4DCL7N/Sa8zlhawQEpU+W1aBWO3pezyiWHgzi+WDZU/tiaRUxNMM
         r2Jm3gtPE4+KK4MLlTxwk1RtygosZmyxaCD0sALBcUyLDgD4Qj+INPfsyOfU1y6mX5CS
         MrQg==
X-Forwarded-Encrypted: i=1; AJvYcCXDLKEeYmcfh3IPoqtjG+cWLCyji9rxIr+q4jsGdZJ8cmd1c70UfjSxTcRTDTwXzG74OyLwUrz/@vger.kernel.org, AJvYcCXOmR1wrmqdcOyZEi76xbecc+rCjXrblLyCeDMbf8b8mOdg1lbzV0wL9cpCwH3RKUMg4zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpz8qU7MaE6TYLIHo0bxybgm4LwyaGBY1X74CKH/PhXt3hitq
	r3t4bzZzMpJTAiORYK0IlC6VZ4IBpyBOv5+uEaId+Vrev1nZPGacbyuvlwQXwm+1qG5Mn0EwXke
	emv78FLuiODpIkG2dDZK+KPIgVtc=
X-Gm-Gg: ASbGncsGaKEZTK5SzLtXrbFclEE278iKIp1VO86haeccZXR4VBoIa2f1zUTA+ksizYG
	5+bao+e8Jup5/E1ANQRTofu85e8j+sHwoLHQVSbHT3K1kND0ROPLCxQoGOwIyQMdscpmuTQM=
X-Google-Smtp-Source: AGHT+IGrJLSCWNDGrOBWEuaFcAKCKWn0ba8GITs8wDBFL2Nn0cTuASxghcgpMZmwwdPZcvQ2+gIXM6jx0G2lvlz2dBc=
X-Received: by 2002:a92:cda7:0:b0:3ce:4b12:fa17 with SMTP id
 e9e14a558f8ab-3cffe4453e0mr199568675ab.19.1738631663254; Mon, 03 Feb 2025
 17:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
 <20250128084620.57547-9-kerneljasonxing@gmail.com> <5be0c7cd-cf89-4ab9-a7c4-381ca2e2903f@linux.dev>
In-Reply-To: <5be0c7cd-cf89-4ab9-a7c4-381ca2e2903f@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 4 Feb 2025 09:13:47 +0800
X-Gm-Features: AWEUYZk2vfDjaLyw2u4iu-3V7gQYHpwzxqeTwRH7m657Atw22lAK5g-jKCXKEKE
Message-ID: <CAL+tcoA5tSRNGOqP2tpNM_M4rRBQb2WSBcjEcVS5=JJSPPjRKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 08/13] net-timestamp: support hw
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

On Tue, Feb 4, 2025 at 8:56=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 1/28/25 12:46 AM, Jason Xing wrote:
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
> >   include/uapi/linux/bpf.h       |  7 +++++++
> >   net/core/skbuff.c              | 11 ++++++-----
> >   net/dsa/user.c                 |  2 +-
> >   net/socket.c                   |  2 +-
> >   tools/include/uapi/linux/bpf.h |  7 +++++++
> >   6 files changed, 25 insertions(+), 8 deletions(-)
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
>
> Patch 5 mentioned hwtstamps could be NULL, so this should be "if (hwtstam=
ps)" here.
>
> > -                     return;
> > -             op =3D BPF_SOCK_OPS_TS_SW_OPT_CB;
> > +                     *skb_hwtstamps(skb) =3D *hwtstamps;
>
> Otherwise, this will crash.

Sorry, I tested it in the wrong way... Will fix it soon!

>
> pw-bot: cr
>
>
> >               break;
> >       default:
> >               return;

