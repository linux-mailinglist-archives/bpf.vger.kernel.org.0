Return-Path: <bpf+bounces-43361-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23DB9B3FCD
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 02:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59AA1C21FDF
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 01:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FF078C6D;
	Tue, 29 Oct 2024 01:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBGRdr/w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64D817548;
	Tue, 29 Oct 2024 01:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165589; cv=none; b=OxG8Gmt5MF1IYIqDZ8buFAPIpFWoV1q8qr8vFJLaIse9Xa7gT1DHIysp4B73pStogfiZbW/TbMS9kPKXdrb+OI2lCTUOP1NCuGnbsAL2jj3ELnWZgawBLlG3qWAW7eXpHPmgQ6tu+uFz4bPB5XaZXyn+HLusAq3iWXWX4QtFIyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165589; c=relaxed/simple;
	bh=MnofMo3vD6iP8fD6oc1nHSMZwq3lS/jzwXyx0tsu29o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=FejA0w0W+ef/Kv9CHjKqc/8RyaOKZ8Ss12muNL4dnnhQNfL5bw/UuxylV4XW4K/rZ/mkhpCPFEhKAefKUbcKNubOjAUBBGu9WnJV2WSlWArrUDSaT/LwlyIKedysgc5LvYFPMiezHFrpWfWDsd6i74jZijG7hzetCNiU64xBiVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBGRdr/w; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b155cca097so416707685a.1;
        Mon, 28 Oct 2024 18:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730165586; x=1730770386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rJwdsXx5pxSabi+jerd/IILA/F0wzo/6+eGa5Tme/8=;
        b=bBGRdr/wg3sr3VJZv5GFzEFBZRJzmHW0wXun+5mgvRrtecOK2IW88pGi66ReqrDtEU
         7/4/VzP89XCwRDlSIDZvbRpQKuzLmIoChe86mcHt+Htcsw6th3PH/XGyNp+omCyuBZyH
         D2Ftztg0V8sS8kRp95DcvLC+ptIKoqJG4snT8hwDw7lCmDIgoHR08eEL5GMCcIIGAIE6
         uRB3A1mTfGsnvCa3v7RlHrMjGNiUshKwN+e5T5GeUrWekXaioRpVunujM+12Mw4bcisu
         /WFyBKnKnsurNDk+7NoAyPvEHgAhxbdhvrqM+6hZ4Mra57tPFEX+GXcvNd80equOP/ij
         K2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730165586; x=1730770386;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1rJwdsXx5pxSabi+jerd/IILA/F0wzo/6+eGa5Tme/8=;
        b=fpLYGRfjm4P+9wYOUr5A/JEpd6406vOy3jklqj80+EBaMHY88/c+zH4zAp7Q8AxNi0
         XlHOsmdEA2yW2vw2Oglg3xkltKuoVmpNDNpnX5QN8VTfT2zfjQouCAh5FVQARKJUR01w
         2zRrBR6qCyV9MxPF8m3vYauW5nDm+H7OyAo4BwT4hzsxG0dnCQV699Fn4LJZZY/3i+Cq
         P3tigdISE+RvDLc931mKd8hM8bTzihDNeibGYQ1i0Xv4OG4Q9VtMZ4ztUuwg/0GOKCPv
         g3mSqpww9dgx4n1BFpXYKQ8cJNWi08w7vEx1gy8mQ+HSmGFw7ZXmwrRB+t1jeTg0raaW
         WGlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHdy5BPA+0WMyI1p/AqByaoaj643uKYBW9LjzCHDf+qiHiSf1NsQHx8HBMOEp3INPbh3qhNCgT@vger.kernel.org, AJvYcCW3zjxkjrChuxPXMz4H7hrGVANP5OOq7e/jiFrLS90jnm+rQG1nkbi4sBEgqarXmqOnt+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOYriHBoxFdlUo23x8nGkoA6gbWru0y0FJ8VnWphSPKiI0Rc3
	/9w717o+N/J/UAMBs1XhGxSwsg7Ewgz5EXVev9zW1yk6R1bOOHTe
X-Google-Smtp-Source: AGHT+IHvNamj/o68AlNnuenyCY0lyL3PuBQmFx/ohTsCqfwa3cka87pU/8R3jScGDIltj+gkUmkjbg==
X-Received: by 2002:a05:620a:4155:b0:7a8:554:c368 with SMTP id af79cd13be357-7b1a9b7480dmr85146385a.6.1730165585819;
        Mon, 28 Oct 2024 18:33:05 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461357007d4sm38073291cf.88.2024.10.28.18.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 18:33:05 -0700 (PDT)
Date: Mon, 28 Oct 2024 21:33:04 -0400
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
 shuah@kernel.org, 
 ykolal@fb.com, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <67203b50af9ba_25812829436@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoCBxTUU9mPUTC=9LmGLsrUrjVDVk-982M-TjewSW-hjzQ@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-8-kerneljasonxing@gmail.com>
 <6720356328c26_24dce6294ce@willemb.c.googlers.com.notmuch>
 <CAL+tcoCBxTUU9mPUTC=9LmGLsrUrjVDVk-982M-TjewSW-hjzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/14] net-timestamp: add a new triggered
 point to set sk_tsflags_bpf in UDP layer
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
> On Tue, Oct 29, 2024 at 9:07=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > This patch behaves like how cmsg feature works, that is to say,
> > > check and set on each call of udp_sendmsg before passing sk_tsflags=
_bpf
> > > to cork tsflags.
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > >  include/net/sock.h             | 1 +
> > >  include/uapi/linux/bpf.h       | 3 +++
> > >  net/core/skbuff.c              | 2 +-
> > >  net/ipv4/udp.c                 | 1 +
> > >  tools/include/uapi/linux/bpf.h | 3 +++
> > >  5 files changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index 062f405c744e..cf7fea456455 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -2828,6 +2828,7 @@ static inline bool sk_listener_or_tw(const st=
ruct sock *sk)
> > >  }
> > >
> > >  void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);=

> > > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *a=
rgs);
> > >  int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int le=
n, int level,
> > >                      int type);
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 6fc3bd12b650..055ffa7c965c 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -7028,6 +7028,9 @@ enum {
> > >                                        * feature is on. It indicate=
s the
> > >                                        * recorded timestamp.
> > >                                        */
> > > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_send=
msg
> > > +                                      * syscall is triggered
> > > +                                      */
> > >  };
> > >
> > >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to=
 detect
> > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > index 8b2a79c0fe1c..0b571306f7ea 100644
> > > --- a/net/core/skbuff.c
> > > +++ b/net/core/skbuff.c
> > > @@ -5622,7 +5622,7 @@ static void skb_tstamp_tx_output(struct sk_bu=
ff *orig_skb,
> > >       __skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
> > >  }
> > >
> > > -static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs,=
 u32 *args)
> > > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *a=
rgs)
> > >  {
> > >       struct bpf_sock_ops_kern sock_ops;
> > >
> > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > index 9a20af41e272..e768421abc37 100644
> > > --- a/net/ipv4/udp.c
> > > +++ b/net/ipv4/udp.c
> > > @@ -1264,6 +1264,7 @@ int udp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
> > >       if (!corkreq) {
> > >               struct inet_cork cork;
> > >
> > > +             timestamp_call_bpf(sk, BPF_SOCK_OPS_TS_UDP_SND_CB, 0,=
 NULL);
> > >               skb =3D ip_make_skb(sk, fl4, getfrag, msg, ulen,
> > >                                 sizeof(struct udphdr), &ipc, &rt,
> > >                                 &cork, msg->msg_flags);
> > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/li=
nux/bpf.h
> > > index 6fc3bd12b650..055ffa7c965c 100644
> > > --- a/tools/include/uapi/linux/bpf.h
> > > +++ b/tools/include/uapi/linux/bpf.h
> > > @@ -7028,6 +7028,9 @@ enum {
> > >                                        * feature is on. It indicate=
s the
> > >                                        * recorded timestamp.
> > >                                        */
> > > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_send=
msg
> > > +                                      * syscall is triggered
> > > +                                      */
> >
> > If adding a timestamp as close to syscall entry as possible, give it =
a
> > generic name, not specific to UDP.
> =

> Good suggestion, then it will also solve the remaining issue for TCP ty=
pe:
> __when__ we should record the user timestamp which exists in the
> application SO_TIMESTAMPING feature.
> =

> >
> > And please explain in the commit message the reason for a new
> > timestamp recording point: with existing timestamping the application=

> > can call clock_gettime before (and optionally after) the send call.
> > An admin using BPF does not have this option, so needs this as part o=
f
> > the BPF timestamping API.
> =

> Will revise this part. Thanks for your description!

Actually, I may have misunderstood the intention of this new hook.

I thought it was to record an additional timestamp.

But it is (also?) to program skb_shared_info.tx_flags based on
instructions parsed from cmsg in __sock_cmsg_send.

