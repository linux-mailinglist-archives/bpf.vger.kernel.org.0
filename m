Return-Path: <bpf+bounces-43392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D209B4E5C
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 16:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167D01C23444
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DE9194AEB;
	Tue, 29 Oct 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+Sjnigd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D39B802;
	Tue, 29 Oct 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730216730; cv=none; b=h5jxsRd77fPvp3JMIU8SSFTBtS746LDiU3pwR68IVzYz6XcJVJWlu5FjOM75ZTa4ymheUFI8xXZ2OwLXhq516mShG2XpK1x2rjGz3AlMhGDHQnUIL/3kTjJBCXlkn15tspL/f7B9CJDcGAYpTZEwurWQoZ2rlLdrJsSZui8lXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730216730; c=relaxed/simple;
	bh=/i4dWK4F6hJbqpi2maBmqWq0OsrRFCA6YHam80TbJs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7BaeyxptPAogKtOyHulrtc4+GMEibCBcanyjp7vVYJhUGNGJkJbzvjaj2+YR2d4Q5GGNm09H+6LocK1Ex1niG3aYdZI+m5RSnwWiGo48xynM+NhqqHMM103SfC1z2Fhm8bMlNruvd8YcD1l+PUE5g7AxWu/fdnLsmVeAnygbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+Sjnigd; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a3b6b281d4so22686745ab.0;
        Tue, 29 Oct 2024 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730216727; x=1730821527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+WNbS8D2cwcZw0GFjyFt+6WwJRj0UVyPushyS97O0E=;
        b=g+SjnigdJ78H0EthOf6xGNbRuPg8tQ1b92fShBPvjGUy9ry4Qdufgc9aW4yn7zKDON
         vIHr/ICpc0HUpzeZdA5ZELYZMO+I1645nMf89pBSruukT1bTXrE1FMo78T1fZw/g/Buf
         XVRPPI9PGe0QYVn0IIqCs97LF70MMpJ2+F9xm5OpaNXbM+LE7ptmaSbWzjy5KvR8s8xT
         kXbnuslrbVkYGGAUzx//5bgayr2MaPObxvOBVJRBNZiIhB7YCjTLijTuSx/FF1QzHCgw
         BUul2f20F4jcjXzaq3syIMjTIWCIkkJ+iZJrx0ixONnIpuQaCDKdButQmSk378NUZ+UC
         bNuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730216727; x=1730821527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R+WNbS8D2cwcZw0GFjyFt+6WwJRj0UVyPushyS97O0E=;
        b=GtTYT/Sw99fQDDed56lWVZZSa8FVEO8GcTaOhtatmOpMEas0vsCc9HF6pt4U9TRyBq
         qAiZgwPC4yYr0JS5zqvTyQ6L2/iFU6GfXAP2TL4f+6AJAujzExJLF0mJDSFS4uMLtpbq
         tpObFksSweQVL4wCxAobyWwQK3cnR7RhC5l1WQ/aN8/F/boDtORvl+tZrzwcwJWwZUE0
         JwiwDT5qYz68nyN38bsKK9CoFk39AOUOaQakYd1LQooXT2cpkpREol25Oiq3q7UOtAHe
         WOmYzK/nVWg8CUaS8C9Xv5wl8O6JAFXRXmacVpM5XFGOcUuKQnswMoN+0XVHUje3H00q
         Iacg==
X-Forwarded-Encrypted: i=1; AJvYcCU/UHz21hCyRh737zE8etVlonhf0j+M4INl6+bHvBqpwlEN7NZ5O8NqINS2oyImFLpJrxibLZSu@vger.kernel.org, AJvYcCUD8JVe5pMFM52mz3/4fZRLFNUuST6N9GMsOyzGgNjTFPGEisR/BwVIMRDZenGIJDMl/DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTElOejYDgujbrMYvgyFJ4ZOmwxykFm8m82uBSj+jxlbo8G7Ip
	Hjio8nswRcyEzXJqQghD+mhKRF/n6Qvsb7MlXya5t/8yPy0mEo7EFFHHbvK29OGlVcBAck3hzcq
	U2CXGrmnl5FeYrZmK91lcJkkxkKM=
X-Google-Smtp-Source: AGHT+IEqB8GrvJMCkNUHYeILnq8Ks2VaUDMaDt+xGTdtGjtwOsJPBLul5EJ2rYERtfWxTzrOk5MOp6NtnvgpjxxJkOw=
X-Received: by 2002:a05:6e02:2183:b0:3a3:4391:24e9 with SMTP id
 e9e14a558f8ab-3a4ed2dfafdmr122935655ab.20.1730216727323; Tue, 29 Oct 2024
 08:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-8-kerneljasonxing@gmail.com> <6720356328c26_24dce6294ce@willemb.c.googlers.com.notmuch>
 <CAL+tcoCBxTUU9mPUTC=9LmGLsrUrjVDVk-982M-TjewSW-hjzQ@mail.gmail.com>
 <67203b50af9ba_25812829436@willemb.c.googlers.com.notmuch>
 <CAL+tcoAid3eSbnu-h8PR9o-_pr4bOdsKAxsT=WT-d_GD91pVuQ@mail.gmail.com> <6720f97f43603_2bcd7f294fb@willemb.c.googlers.com.notmuch>
In-Reply-To: <6720f97f43603_2bcd7f294fb@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 29 Oct 2024 23:44:51 +0800
Message-ID: <CAL+tcoDeMgugDs66+qsoh025+KL34qyya_xT5+=oWL3FDq_wOA@mail.gmail.com>
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

On Tue, Oct 29, 2024 at 11:04=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Oct 29, 2024 at 9:33=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Tue, Oct 29, 2024 at 9:07=E2=80=AFAM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > This patch behaves like how cmsg feature works, that is to say,
> > > > > > check and set on each call of udp_sendmsg before passing sk_tsf=
lags_bpf
> > > > > > to cork tsflags.
> > > > > >
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  include/net/sock.h             | 1 +
> > > > > >  include/uapi/linux/bpf.h       | 3 +++
> > > > > >  net/core/skbuff.c              | 2 +-
> > > > > >  net/ipv4/udp.c                 | 1 +
> > > > > >  tools/include/uapi/linux/bpf.h | 3 +++
> > > > > >  5 files changed, 9 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > > > index 062f405c744e..cf7fea456455 100644
> > > > > > --- a/include/net/sock.h
> > > > > > +++ b/include/net/sock.h
> > > > > > @@ -2828,6 +2828,7 @@ static inline bool sk_listener_or_tw(cons=
t struct sock *sk)
> > > > > >  }
> > > > > >
> > > > > >  void sock_enable_timestamp(struct sock *sk, enum sock_flags fl=
ag);
> > > > > > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u3=
2 *args);
> > > > > >  int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, in=
t len, int level,
> > > > > >                      int type);
> > > > > >
> > > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.=
h
> > > > > > index 6fc3bd12b650..055ffa7c965c 100644
> > > > > > --- a/include/uapi/linux/bpf.h
> > > > > > +++ b/include/uapi/linux/bpf.h
> > > > > > @@ -7028,6 +7028,9 @@ enum {
> > > > > >                                        * feature is on. It indi=
cates the
> > > > > >                                        * recorded timestamp.
> > > > > >                                        */
> > > > > > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_=
sendmsg
> > > > > > +                                      * syscall is triggered
> > > > > > +                                      */
> > > > > >  };
> > > > > >
> > > > > >  /* List of TCP states. There is a build check in net/ipv4/tcp.=
c to detect
> > > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > > index 8b2a79c0fe1c..0b571306f7ea 100644
> > > > > > --- a/net/core/skbuff.c
> > > > > > +++ b/net/core/skbuff.c
> > > > > > @@ -5622,7 +5622,7 @@ static void skb_tstamp_tx_output(struct s=
k_buff *orig_skb,
> > > > > >       __skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
> > > > > >  }
> > > > > >
> > > > > > -static void timestamp_call_bpf(struct sock *sk, int op, u32 na=
rgs, u32 *args)
> > > > > > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u3=
2 *args)
> > > > > >  {
> > > > > >       struct bpf_sock_ops_kern sock_ops;
> > > > > >
> > > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > > index 9a20af41e272..e768421abc37 100644
> > > > > > --- a/net/ipv4/udp.c
> > > > > > +++ b/net/ipv4/udp.c
> > > > > > @@ -1264,6 +1264,7 @@ int udp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t len)
> > > > > >       if (!corkreq) {
> > > > > >               struct inet_cork cork;
> > > > > >
> > > > > > +             timestamp_call_bpf(sk, BPF_SOCK_OPS_TS_UDP_SND_CB=
, 0, NULL);
> > > > > >               skb =3D ip_make_skb(sk, fl4, getfrag, msg, ulen,
> > > > > >                                 sizeof(struct udphdr), &ipc, &r=
t,
> > > > > >                                 &cork, msg->msg_flags);
> > > > > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uap=
i/linux/bpf.h
> > > > > > index 6fc3bd12b650..055ffa7c965c 100644
> > > > > > --- a/tools/include/uapi/linux/bpf.h
> > > > > > +++ b/tools/include/uapi/linux/bpf.h
> > > > > > @@ -7028,6 +7028,9 @@ enum {
> > > > > >                                        * feature is on. It indi=
cates the
> > > > > >                                        * recorded timestamp.
> > > > > >                                        */
> > > > > > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_=
sendmsg
> > > > > > +                                      * syscall is triggered
> > > > > > +                                      */
> > > > >
> > > > > If adding a timestamp as close to syscall entry as possible, give=
 it a
> > > > > generic name, not specific to UDP.
> > > >
> > > > Good suggestion, then it will also solve the remaining issue for TC=
P type:
> > > > __when__ we should record the user timestamp which exists in the
> > > > application SO_TIMESTAMPING feature.
> > > >
> > > > >
> > > > > And please explain in the commit message the reason for a new
> > > > > timestamp recording point: with existing timestamping the applica=
tion
> > > > > can call clock_gettime before (and optionally after) the send cal=
l.
> > > > > An admin using BPF does not have this option, so needs this as pa=
rt of
> > > > > the BPF timestamping API.
> > > >
> > > > Will revise this part. Thanks for your description!
> > >
> > > Actually, I may have misunderstood the intention of this new hook.
> > >
> > > I thought it was to record an additional timestamp.
> >
> > I planned to do it after this series. For now, without the new hook,
> > it will not work for UDP type.
>
> Why not? This is something specific to the SK BPF hooks, I suppose?

I mean both hooks (one for UDP, one for USR time) are significant.

>
> As soon as bpf_setsockopt is called, the timestamp callbacks should
> start getting called?

Right, but the question is when we trigger the call of
bpf_setsockopt() for the UDP proto? The current patch is trying to
deal with it.

>
> > >
> > > But it is (also?) to program skb_shared_info.tx_flags based on
> > > instructions parsed from cmsg in __sock_cmsg_send.
> >
> > I'm not sure if I grasp the key point you said.
> >
> > For UDP, skb_shared_info.tx_flags will finally be initialized in
> > __ip_append_data() based on cork->tx_flags.
> >
> > cork->tx_flags is computed by sock_tx_timestamp() based on
> > ipc->sockc.tsflags if cmsg feature is turned on.
> >
> > __sock_tx_timestamp() uses "flags |=3D xxx" to initialize the
> > cork->tx_flags, so that the cork->tx_flags will not be completely
> > overridden by either the cmsg method or bpf program, that is to say,
> > the cork->tx_flags can combine both of them.
> >
> > Then another key point is that we do the check to see which one
> > actually works in sk_tstamp_tx_flags() by testing sk->sk_tsflags or
> > sk->sk_tsflags_bpf in patch [2/14]. It guarantees that.
>
> Ack, thanks. So I was mistaken the second time around.

Thanks for your review :)

Thanks,
Jason

