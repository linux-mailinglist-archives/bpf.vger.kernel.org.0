Return-Path: <bpf+bounces-43369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94EA9B40D5
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 04:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D959B21CEC
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 03:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC296200CBA;
	Tue, 29 Oct 2024 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZPJ3Unt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFAD16F84F;
	Tue, 29 Oct 2024 03:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730171573; cv=none; b=Yd28WQQEvtXmtDLzvPtp4FqlT0Ts42hlDt5uL93z+Uh2EzL7QHUBPbrbPO8iI4jQMul9kMXKDYMUoPgHRTYqT5PiMCgHMt8Ms9ohulaPKqdVfzk6EFB3xFtTJQNRqEQH3aabXhBBLLXo/CxQeNKa/BAJy8AJwrUk6SjnYcoe9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730171573; c=relaxed/simple;
	bh=+tizYLqfF2nfDtNcrk8+S2roahLCgfUWqWvqUIx7EWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xgpt/omo1ZgKyCSj++/xzgUoHD65VxI66J0CvEekss2remchO6NoB2ENkLCgLdIkl4Oc+WXJSCR6vsRNpIsl4mBCp42iqnaPebEAf1LmpflAyTcN7EJs+llxs0y7nf7VmR1StmW4PS8RtMtLqYDuZllIxw9ThtxlKTSJ4fHCGgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZPJ3Unt; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a3a5cd2a3bso20744985ab.3;
        Mon, 28 Oct 2024 20:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730171570; x=1730776370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaFN4WEJ6gZrRDJp3GcB1zGJcpOzZxcbK9tiJRr7lm4=;
        b=HZPJ3UntkyJcQEFbIZnZMnZdNAaF4FU6ZjYsUdQ9CzU6Ue5jBsLw5J5ZX74XCA9HA/
         kmGZQBtyEeTnnr6ztf1MijZvNyh56eOhNB5t2W+pCch43z1P/4uSXRptXwyxV3aDRtSJ
         YKzJ3YJCflF+uJLZCVDLOmq6TKuHf4mQsCNtyjt0kji818AWO4byqf1ghu3gbgVc0XxY
         fHMeyUXmrIW7eavZZcK2yrO4FqMzojnU0ZCKXhhZXodyXxrw2mcyhc7WpnSmEGFFrYYQ
         Rjj7WcZIqKe0qqKV4KoxMKg+3+jFz/dHI8mVuhhOjXZyAzohYa2ji69JKjX3xE+g8j8m
         Nj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730171570; x=1730776370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaFN4WEJ6gZrRDJp3GcB1zGJcpOzZxcbK9tiJRr7lm4=;
        b=CPssO+zaE/otjlLsInwxM9FrVRx2plfSuJhh0qrqXimux/XBx9HTcySE+WZXCfS6wU
         fISevEtFxIhF3vae4YxYLVnUYocjk7I0Is0W1n0Jt0YJslqcXI6gQUOF3ypVcF3s0ur1
         DRG/g6CtK+nixLTm6hruOB9iA9d6M3lwX8yx2Eqi7wdv9qXYg3HkcC3rEwHuA6g6aw25
         XduzKgMknP3v/9zMd59N/2fCr5X4Vslf92FlAl5MnreT70fxEdymd3Px4dVF7x2rWaRO
         cqBQfBpE9L3yn6ZoxHPe79FxHh/zfKPggXzBa+uEr3IgfAwffb1vjTkiHILa8urOejv+
         EvCg==
X-Forwarded-Encrypted: i=1; AJvYcCVvMhcV/8SM/nDDaNTyY3muk6O4TNqhzyUbo/rJAgbznUnq+qQjhUC3WZqIBqtsV3Xuvbw=@vger.kernel.org, AJvYcCWhwzBYRhqxzN5vMHDiHaQX/HH+uzTpVTyVUVrqOVKr+SRuPMAeRei3raiPQx0iD+OvkxY21BoB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1gXi5VHNOSuCDkZYUY5UIdJpmsn2nWpupEB+ilVkUpxXVxpqP
	g85dgmgPbfMe9YYXEYTK7gGe2zkxEPep6WIwcWNHUgY8OVf9moCyBDQ2ovfLfacxPvimsEY2rvQ
	aT6hZXcpvjcBvPqsW3ZhMjlgMgfmihkVR
X-Google-Smtp-Source: AGHT+IFBRM64OmNN+G+1mHdot4s2zN2JUdlsaxtTP3zVmRDIQi5LKrbI06OyTpXdThXObz6x1JeaHLL/OrNdyjP/d7k=
X-Received: by 2002:a05:6e02:1548:b0:3a2:6ce9:19c6 with SMTP id
 e9e14a558f8ab-3a4ed30fe20mr89443395ab.25.1730171570152; Mon, 28 Oct 2024
 20:12:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-8-kerneljasonxing@gmail.com> <6720356328c26_24dce6294ce@willemb.c.googlers.com.notmuch>
 <CAL+tcoCBxTUU9mPUTC=9LmGLsrUrjVDVk-982M-TjewSW-hjzQ@mail.gmail.com> <67203b50af9ba_25812829436@willemb.c.googlers.com.notmuch>
In-Reply-To: <67203b50af9ba_25812829436@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 11:12:13 +0800
Message-ID: <CAL+tcoAid3eSbnu-h8PR9o-_pr4bOdsKAxsT=WT-d_GD91pVuQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 07/14] net-timestamp: add a new triggered
 point to set sk_tsflags_bpf in UDP layer
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, ykolal@fb.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 9:33=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Oct 29, 2024 at 9:07=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > This patch behaves like how cmsg feature works, that is to say,
> > > > check and set on each call of udp_sendmsg before passing sk_tsflags=
_bpf
> > > > to cork tsflags.
> > > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  include/net/sock.h             | 1 +
> > > >  include/uapi/linux/bpf.h       | 3 +++
> > > >  net/core/skbuff.c              | 2 +-
> > > >  net/ipv4/udp.c                 | 1 +
> > > >  tools/include/uapi/linux/bpf.h | 3 +++
> > > >  5 files changed, 9 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > index 062f405c744e..cf7fea456455 100644
> > > > --- a/include/net/sock.h
> > > > +++ b/include/net/sock.h
> > > > @@ -2828,6 +2828,7 @@ static inline bool sk_listener_or_tw(const st=
ruct sock *sk)
> > > >  }
> > > >
> > > >  void sock_enable_timestamp(struct sock *sk, enum sock_flags flag);
> > > > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *a=
rgs);
> > > >  int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, int le=
n, int level,
> > > >                      int type);
> > > >
> > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > index 6fc3bd12b650..055ffa7c965c 100644
> > > > --- a/include/uapi/linux/bpf.h
> > > > +++ b/include/uapi/linux/bpf.h
> > > > @@ -7028,6 +7028,9 @@ enum {
> > > >                                        * feature is on. It indicate=
s the
> > > >                                        * recorded timestamp.
> > > >                                        */
> > > > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_send=
msg
> > > > +                                      * syscall is triggered
> > > > +                                      */
> > > >  };
> > > >
> > > >  /* List of TCP states. There is a build check in net/ipv4/tcp.c to=
 detect
> > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > index 8b2a79c0fe1c..0b571306f7ea 100644
> > > > --- a/net/core/skbuff.c
> > > > +++ b/net/core/skbuff.c
> > > > @@ -5622,7 +5622,7 @@ static void skb_tstamp_tx_output(struct sk_bu=
ff *orig_skb,
> > > >       __skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
> > > >  }
> > > >
> > > > -static void timestamp_call_bpf(struct sock *sk, int op, u32 nargs,=
 u32 *args)
> > > > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *a=
rgs)
> > > >  {
> > > >       struct bpf_sock_ops_kern sock_ops;
> > > >
> > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > index 9a20af41e272..e768421abc37 100644
> > > > --- a/net/ipv4/udp.c
> > > > +++ b/net/ipv4/udp.c
> > > > @@ -1264,6 +1264,7 @@ int udp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
> > > >       if (!corkreq) {
> > > >               struct inet_cork cork;
> > > >
> > > > +             timestamp_call_bpf(sk, BPF_SOCK_OPS_TS_UDP_SND_CB, 0,=
 NULL);
> > > >               skb =3D ip_make_skb(sk, fl4, getfrag, msg, ulen,
> > > >                                 sizeof(struct udphdr), &ipc, &rt,
> > > >                                 &cork, msg->msg_flags);
> > > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/li=
nux/bpf.h
> > > > index 6fc3bd12b650..055ffa7c965c 100644
> > > > --- a/tools/include/uapi/linux/bpf.h
> > > > +++ b/tools/include/uapi/linux/bpf.h
> > > > @@ -7028,6 +7028,9 @@ enum {
> > > >                                        * feature is on. It indicate=
s the
> > > >                                        * recorded timestamp.
> > > >                                        */
> > > > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_send=
msg
> > > > +                                      * syscall is triggered
> > > > +                                      */
> > >
> > > If adding a timestamp as close to syscall entry as possible, give it =
a
> > > generic name, not specific to UDP.
> >
> > Good suggestion, then it will also solve the remaining issue for TCP ty=
pe:
> > __when__ we should record the user timestamp which exists in the
> > application SO_TIMESTAMPING feature.
> >
> > >
> > > And please explain in the commit message the reason for a new
> > > timestamp recording point: with existing timestamping the application
> > > can call clock_gettime before (and optionally after) the send call.
> > > An admin using BPF does not have this option, so needs this as part o=
f
> > > the BPF timestamping API.
> >
> > Will revise this part. Thanks for your description!
>
> Actually, I may have misunderstood the intention of this new hook.
>
> I thought it was to record an additional timestamp.

I planned to do it after this series. For now, without the new hook,
it will not work for UDP type.

>
> But it is (also?) to program skb_shared_info.tx_flags based on
> instructions parsed from cmsg in __sock_cmsg_send.

I'm not sure if I grasp the key point you said.

For UDP, skb_shared_info.tx_flags will finally be initialized in
__ip_append_data() based on cork->tx_flags.

cork->tx_flags is computed by sock_tx_timestamp() based on
ipc->sockc.tsflags if cmsg feature is turned on.

__sock_tx_timestamp() uses "flags |=3D xxx" to initialize the
cork->tx_flags, so that the cork->tx_flags will not be completely
overridden by either the cmsg method or bpf program, that is to say,
the cork->tx_flags can combine both of them.

Then another key point is that we do the check to see which one
actually works in sk_tstamp_tx_flags() by testing sk->sk_tsflags or
sk->sk_tsflags_bpf in patch [2/14]. It guarantees that.

Thanks,
Jason

