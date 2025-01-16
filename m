Return-Path: <bpf+bounces-49012-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F93A1301F
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 01:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE95E18889B5
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C92FFC0E;
	Thu, 16 Jan 2025 00:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8NRY04I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559061804A;
	Thu, 16 Jan 2025 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736988151; cv=none; b=dwVn00sHVueTuwXQhSf9+sI83zigAb2fN2NBjNhrAc2pvh/sA0WR05kt7qMx6kaennuUF/ZwAHow6hJk/Cskupa38eO9Zd66SUs3AEFPO3sOu8qiMaHbZcoTd+4rfCbSkN+O9Fb0Y6URu1Eopi7/SEU+5Dsi+2QgOYj6CQfGOs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736988151; c=relaxed/simple;
	bh=sGoXNsATZRbpPns3fc3I/WXrWIn83dzJQJhCvGZEJ/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CkAtO1AyCvivUl3b8+kX8rq1c3NTuHeHN/FUfQTkth8UieutAzlh24EtT0DtVExGbOw73lgaebPaxQG4AYV9aApm55e2YzpRdHr24qsVzFrdFpXPmfdr0sEWJJV3sHAEU36YAR6T5GvEsJbchDUJ/RIdPgF9ONco/kUrWKcPVbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8NRY04I; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a8160382d4so1292295ab.0;
        Wed, 15 Jan 2025 16:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736988148; x=1737592948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fSihI+5SOx2wLNDb4qnQ5XbSuepADQS2s72hMI9dyY=;
        b=V8NRY04IcWYkr09YJTwYj4gAoVR9OKT9+CfpSmjDacPu2H0ubDsA3SMPCQs6taGXDf
         TPfPWOZQoBvUFwE0pI4ABVVRW6CrYVh7wt2hFYZfOlqDXb0+o9swjsQQZzFL8JRV5sFX
         a48SclU3C2I4q6SnmUjYnGsgpGj0XZpL1i+tZkLEnqer48hIesQPGmYh6zgmZmeVFQa6
         0xpU6vQJyKRqDQCRLBKQpn9xi9rQ5seKG/8YZGzmIIOSqb8Y9Ze5P20Z9wIiFlc6E2y4
         j/nwborrKBIZ1IFcWY1dB4lANDEhZzDPpV0vkpcdzWgKWLzJzQtyh7kXobmO4FhhIVNX
         eK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736988148; x=1737592948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fSihI+5SOx2wLNDb4qnQ5XbSuepADQS2s72hMI9dyY=;
        b=mXkFi2yH4FFHZT7DqJS+xLLVRJtjMR4u/voSlFNxshH9ZUUZulQbKk69Qi+TZJbFeh
         K5GAFtsNJZJFn5A08qlp7LiduON0EzRcV9dHf/t4CYriuT3xaTYeDuMsQ0RX06UFDa+S
         txubV1cxkLEqATFvzKUZPLGo4pjzVMTasiJNCKHHu1yd/dfd8Q3FDX3f0VUGSB5Jk+Vp
         3j/IDqMzbF8psGvpp2EjQYfw49BhcAJt4sXbtATCG0HuFTR48POP3psBrJXiXq1/zMom
         oDdFhpDr7KtjkK2I1uG7Fh4LBhPhxgGmJIFv8GCCMuvzFYpcrT/LJUI3oE+SImLT/J8S
         jc9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUH7fPfmv8qO+BM9M8/F/yXgUDrNht7Y1VWobkw8A0NgnAACRAyQBLkLZPLuZ+sWHpR6d4k9sFu@vger.kernel.org, AJvYcCUTJrjha0JcJNTcgAwrbmaWV1c6ZEaBTBs8/UjbAufhE4jTI8wCzOxDwuTykOhkcTHip+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd4NKjiBjNX82yp3rEztaTHApuGm5MEj3BQFiewqwmlnHusIg/
	+2DGVyd1qIEtltfzjFg0bHnDM9kKyYgASU4aQ2cxg0jL4/R9QfodPQ3ZZ/4LJugvKdy+kLEg0xC
	ZaRtdGCiDOPHOsFVeFrl0ZMxMLlg=
X-Gm-Gg: ASbGnctEtgxmPT0TzoObh8KaKMCgtCPzJWn6hlLgd8+2PBf0bTXQMxtgl4kmYcwO0sw
	MSaAxHwQlyOh/1JqlkhF+kdiIB/KuNK3LHSm4
X-Google-Smtp-Source: AGHT+IFujPEWaCRsI2MhBEBASNMf4WPYfMjXyxOBchdrdlQRe8vvDJ5S7yh7be1g1wI9VEmLjPFEdYnqLkYpoYQVOeA=
X-Received: by 2002:a05:6e02:1c8d:b0:3a7:be5e:e22d with SMTP id
 e9e14a558f8ab-3ce3a9a50a5mr246303755ab.2.1736988148180; Wed, 15 Jan 2025
 16:42:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-14-kerneljasonxing@gmail.com> <5d9ba064-3288-4926-b9dc-3119bb3404c1@linux.dev>
In-Reply-To: <5d9ba064-3288-4926-b9dc-3119bb3404c1@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 08:41:52 +0800
X-Gm-Features: AbW1kvY_qpfhxvYPpnoLq_2ZKvLKJoJu9hOheOrjNdWFXE3_Eb0U1wHsv-jPoss
Message-ID: <CAL+tcoCe-Ee92r5B7LwV8GCxEBWDzq3X_g_oOWWzo7-u4wYZzw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 13/15] net-timestamp: support tcp_sendmsg for
 bpf extension
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

On Thu, Jan 16, 2025 at 8:04=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> > Introduce tskey_bpf to correlate tcp_sendmsg timestamp with other
> > three points (SND/SW/ACK). More details can be found in the
> > selftest.
> >
> > For TCP, tskey_bpf is used to store the initial write_seq value
> > the moment tcp_sendmsg is called, so that the last skb of this
> > call will have the same tskey_bpf with tcp_sendmsg bpf callback.
> >
> > UDP works similarly because tskey_bpf can increase by one everytime
> > udp_sendmsg gets called. It will be implemented soon.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/linux/skbuff.h         |  2 ++
> >   include/uapi/linux/bpf.h       |  3 +++
> >   net/core/sock.c                |  3 ++-
> >   net/ipv4/tcp.c                 | 10 ++++++++--
> >   tools/include/uapi/linux/bpf.h |  3 +++
> >   5 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index d3ef8db94a94..3b7b470d5d89 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -609,6 +609,8 @@ struct skb_shared_info {
> >       };
> >       unsigned int    gso_type;
> >       u32             tskey;
> > +     /* For TCP, it records the initial write_seq when sendmsg is call=
ed */
> > +     u32             tskey_bpf;
>
> I would suggest to remove this tskey_bpf addition to skb_shared_info. My
> understanding is the intention is to get the delay spent in the
> tcp_sendmsg_locked(). I think this can be done in bpf_sk_storage. More be=
low.
>
> >
> >       /*
> >        * Warning : all fields before dataref are cleared in __alloc_skb=
()
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index a0aff1b4eb61..87420c0f2235 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -7037,6 +7037,9 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_TCP_SND_CB,     /* Called when every tcp_sendmsg
> > +                                      * syscall is triggered
> > +                                      */
>
> UDP will need this also?

Yep.

>
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 2f54e60a50d4..e74ab0e2979d 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -958,7 +958,8 @@ void bpf_skops_tx_timestamping(struct sock *sk, str=
uct sk_buff *skb, int op)
> >       if (sk_is_tcp(sk) && sk_fullsock(sk))
> >               sock_ops.is_fullsock =3D 1;
> >       sock_ops.sk =3D sk;
> > -     bpf_skops_init_skb(&sock_ops, skb, 0);
> > +     if (skb)
> > +             bpf_skops_init_skb(&sock_ops, skb, 0);
> >       sock_ops.timestamp_used =3D 1;
> >       __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
> >   }
> > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > index 0a41006b10d1..b6e0db5e4ead 100644
> > --- a/net/ipv4/tcp.c
> > +++ b/net/ipv4/tcp.c
> > @@ -477,7 +477,7 @@ void tcp_init_sock(struct sock *sk)
> >   }
> >   EXPORT_SYMBOL(tcp_init_sock);
> >
> > -static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *so=
ckc)
> > +static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *so=
ckc, u32 first_write_seq)
> >   {
> >       struct sk_buff *skb =3D tcp_write_queue_tail(sk);
> >       u32 tsflags =3D sockc->tsflags;
> > @@ -500,6 +500,7 @@ static void tcp_tx_timestamp(struct sock *sk, struc=
t sockcm_cookie *sockc)
> >               tcb->txstamp_ack_bpf =3D 1;
> >               shinfo->tx_flags |=3D SKBTX_BPF;
> >               shinfo->tskey =3D TCP_SKB_CB(skb)->seq + skb->len - 1;
>
> Add the bpf prog callout here instead:
>
>                 bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TS_TCP_SN=
D_CB);

If we trigger the first time callback here by using
BPF_SOCK_OPS_TS_TCP_SND_CB, it's a little bit late. Do you mean that
we can use the same new callback at the beginning of
tcp_sendmsg_locked() and tcp_tx_timestamp()?

>
> If the bpf prog wants to figure out the delay from the very beginning of =
the
> tcp_sendmsg_locked(), a bpf prog (either by tracing the tcp_sendmsg_locke=
d or by
> adding a new callout at the beginning of tcp_sendmsg_locked like this pat=
ch) can
> store a bpf_ktime_get_ns() in the bpf_sk_storage. The bpf prog running he=
re (at

Thanks for a new lesson about the usage of bpf_sk_storage here. I'll
dig into it.

> tcp_tx_timestamp) can get that timestamp from the bpf_sk_storage since it=
 has a
> hold on the same sk pointer. There is no need to add a new shinfo->tskey_=
bpf to
> measure this part of the delay.
>
> > +             shinfo->tskey_bpf =3D first_write_seq;
> >       }
> >   }
> >
> > @@ -1067,10 +1068,15 @@ int tcp_sendmsg_locked(struct sock *sk, struct =
msghdr *msg, size_t size)
> >       int flags, err, copied =3D 0;
> >       int mss_now =3D 0, size_goal, copied_syn =3D 0;
> >       int process_backlog =3D 0;
> > +     u32 first_write_seq =3D 0;
> >       int zc =3D 0;
> >       long timeo;
> >
> >       flags =3D msg->msg_flags;
> > +     if (SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TX_TIMESTAMPING)) {
> > +             first_write_seq =3D tp->write_seq;
> > +             bpf_skops_tx_timestamping(sk, NULL, BPF_SOCK_OPS_TS_TCP_S=
ND_CB);
>
> My preference is to skip this bpf callout for now and depends on a bpf tr=
ace
> program if it is really needed.

I have no idea if the bpf program wants to record the timestamp here
without the above three lines? Please enlighten me more. Thanks in
advance.

I guess there is one way which I don't know yet to monitor at the
beginning of tcp_sendmsg_locked(). Then let the bpf program call
BPF_SOCK_OPS_TS_TCP_SND_CB in the tcp_tx_timestamp() like your
previous  comment with the help of bpf storage feature to correlate
them. Am I understanding right?

Thanks,
Jason

>
> > +     }
> >
> >       if ((flags & MSG_ZEROCOPY) && size) {
> >               if (msg->msg_ubuf) {
> > @@ -1331,7 +1337,7 @@ int tcp_sendmsg_locked(struct sock *sk, struct ms=
ghdr *msg, size_t size)
> >
> >   out:
> >       if (copied) {
> > -             tcp_tx_timestamp(sk, &sockc);
> > +             tcp_tx_timestamp(sk, &sockc, first_write_seq);
> >               tcp_push(sk, flags, mss_now, tp->nonagle, size_goal);
> >       }
> >   out_nopush:
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/=
bpf.h
> > index 0fe7d663a244..3769e38e052d 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -7030,6 +7030,9 @@ enum {
> >                                        * feature is on. It indicates th=
e
> >                                        * recorded timestamp.
> >                                        */
> > +     BPF_SOCK_OPS_TS_TCP_SND_CB,     /* Called when every tcp_sendmsg
> > +                                      * syscall is triggered
> > +                                      */
> >   };
> >
> >   /* List of TCP states. There is a build check in net/ipv4/tcp.c to de=
tect
>

