Return-Path: <bpf+bounces-43388-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5C29B4CDE
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 16:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15F51F24691
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C306192B90;
	Tue, 29 Oct 2024 15:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GE5hQpEf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D53621;
	Tue, 29 Oct 2024 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214276; cv=none; b=jTeM2Y7NteH791S+0aAt/+bmw4R1DTlnXkCQWczq23nxxM+vAOQ7B+ti29RtX2VVYCiAZkUn9J8eLpDaDa7ea1ioSc+sz/1SlwZ7cq7gN9XzQwWYB2c66fE2I9dxSFWVYqA59WBG1ZCvLeEKxAiFSH9Dlqq5XK4TmiTmxdEgDFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214276; c=relaxed/simple;
	bh=hjJenpIPUSFn7L+6+4Y6w/rSI8vp5N7yjfn5QUQ8SRE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=YwaqHKqsWNpY9Nt5XPuqkG7ZCgNbHWUVDEtjIfrR6ov1fj1IjbawuTXCom0enMSDX3FUVBUR7/ojTegQbTpAYmOyqH8fjimBeNYaVp/hURcrKlAGt1ra63x6DkiJLafuFRluXMEhJZlR9etcLyMmWujFzv4vDCFeJdqFghytCcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GE5hQpEf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46089a6849bso35175151cf.3;
        Tue, 29 Oct 2024 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730214272; x=1730819072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7K+MLjhnrFpA7A8HHEObndbKRGXPxq13AnZJEQ0tCGo=;
        b=GE5hQpEfM0/CexDilFsKvnrpBOmJzqBZ7dSTC+DsRn/osiXKRcP2qs1fEv+pz8FUs0
         Nta2Sem86/wnz3JJb0q4bYwAGRpmmayfcvjD7knwfxVUOKLHSi/zYYhzugVuJZsz/r2K
         7eQfClRixsI+jJXBmapBkjuHVGxYiNR9kMa+uvviSKmKbWlQFfVIX1JEZ1ILMtxEJj+g
         m+DVfXtr1RLZSb4Dwl8LwOiAxe3OJ6DerRD9kIoj/hBinrAhdrtUuZilyJLVkiz+lQOt
         ExVJST4IQsjoTB9IOQCJ20k1XZYNAMLSzw+Sn7L1XQbcB7VA0xTd7Gh8S73PHI/iOJtV
         iLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730214272; x=1730819072;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7K+MLjhnrFpA7A8HHEObndbKRGXPxq13AnZJEQ0tCGo=;
        b=vWaJRx/nG8amgXoUFuseD9CZnJrkh41m8ebcVTpq3I1dymIyn6G/AcuZTZ6hpZmSh8
         qbpRG1Wj3jBzYy5Uy6R9rQ9wz0sLLc/Dw2jqjwhyrR7sYQGEnHgJJxCG44I4zkr2ZVBQ
         wfAi6FEPfpTBsUy7RAsuAshX6Eq7REHgLDKq6SfU868vBectJoazihjD83V8FPJWpKAi
         vgVwX+oeDxvOoLPYcIpKRn5UHfBh5ShgY8VFyZBg+dGWhoHIQ8gmlYuVbGh2We40Um39
         /lbdrmp6ha91uWMbSgnqrqxuPTZrPGw7YqOO0GzEzk4ZuJBOHhh+zSGoHP1ebpBNsGEt
         A7Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVdqhdKnhXGHr1211WJmH7QrvEyb+KZFDaM7nzolthgldDzSZDIxAq2qym4bqm3GwLiCr8A+o1r@vger.kernel.org, AJvYcCW3DKH9iDkCQIND+M6OefsC3d+RvuV9T0HZ0YmfXinc5feuo0mq0A/d6gGH6YGp0uFBWnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyatWKz2jAAs0bHaj/GY+yRbhPmujsO4wUKDgGphiZFrGRAMTmE
	wZ0aRbS+j/uvkw81lhiFRYRDMdq1Pr/J4+f05H37TCthozTwmw1j
X-Google-Smtp-Source: AGHT+IGTO2ZTxWcP4fRYjY5fF1lhp5YQUqVcCfSMMGP9dUWoPY/IbQGFI/9rI/gzf1zcHsYYfpX2BA==
X-Received: by 2002:ac8:5887:0:b0:461:17e6:27b4 with SMTP id d75a77b69052e-4613c00ed20mr209826811cf.17.1730214272270;
        Tue, 29 Oct 2024 08:04:32 -0700 (PDT)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a5660asm42441696d6.140.2024.10.29.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 08:04:31 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:04:31 -0400
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
Message-ID: <6720f97f43603_2bcd7f294fb@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoAid3eSbnu-h8PR9o-_pr4bOdsKAxsT=WT-d_GD91pVuQ@mail.gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
 <20241028110535.82999-8-kerneljasonxing@gmail.com>
 <6720356328c26_24dce6294ce@willemb.c.googlers.com.notmuch>
 <CAL+tcoCBxTUU9mPUTC=9LmGLsrUrjVDVk-982M-TjewSW-hjzQ@mail.gmail.com>
 <67203b50af9ba_25812829436@willemb.c.googlers.com.notmuch>
 <CAL+tcoAid3eSbnu-h8PR9o-_pr4bOdsKAxsT=WT-d_GD91pVuQ@mail.gmail.com>
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
> On Tue, Oct 29, 2024 at 9:33=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Tue, Oct 29, 2024 at 9:07=E2=80=AFAM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > This patch behaves like how cmsg feature works, that is to say,=

> > > > > check and set on each call of udp_sendmsg before passing sk_tsf=
lags_bpf
> > > > > to cork tsflags.
> > > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  include/net/sock.h             | 1 +
> > > > >  include/uapi/linux/bpf.h       | 3 +++
> > > > >  net/core/skbuff.c              | 2 +-
> > > > >  net/ipv4/udp.c                 | 1 +
> > > > >  tools/include/uapi/linux/bpf.h | 3 +++
> > > > >  5 files changed, 9 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > > index 062f405c744e..cf7fea456455 100644
> > > > > --- a/include/net/sock.h
> > > > > +++ b/include/net/sock.h
> > > > > @@ -2828,6 +2828,7 @@ static inline bool sk_listener_or_tw(cons=
t struct sock *sk)
> > > > >  }
> > > > >
> > > > >  void sock_enable_timestamp(struct sock *sk, enum sock_flags fl=
ag);
> > > > > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u3=
2 *args);
> > > > >  int sock_recv_errqueue(struct sock *sk, struct msghdr *msg, in=
t len, int level,
> > > > >                      int type);
> > > > >
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.=
h
> > > > > index 6fc3bd12b650..055ffa7c965c 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -7028,6 +7028,9 @@ enum {
> > > > >                                        * feature is on. It indi=
cates the
> > > > >                                        * recorded timestamp.
> > > > >                                        */
> > > > > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_=
sendmsg
> > > > > +                                      * syscall is triggered
> > > > > +                                      */
> > > > >  };
> > > > >
> > > > >  /* List of TCP states. There is a build check in net/ipv4/tcp.=
c to detect
> > > > > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > > > > index 8b2a79c0fe1c..0b571306f7ea 100644
> > > > > --- a/net/core/skbuff.c
> > > > > +++ b/net/core/skbuff.c
> > > > > @@ -5622,7 +5622,7 @@ static void skb_tstamp_tx_output(struct s=
k_buff *orig_skb,
> > > > >       __skb_complete_tx_timestamp(skb, sk, tstype, opt_stats);
> > > > >  }
> > > > >
> > > > > -static void timestamp_call_bpf(struct sock *sk, int op, u32 na=
rgs, u32 *args)
> > > > > +void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u3=
2 *args)
> > > > >  {
> > > > >       struct bpf_sock_ops_kern sock_ops;
> > > > >
> > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > index 9a20af41e272..e768421abc37 100644
> > > > > --- a/net/ipv4/udp.c
> > > > > +++ b/net/ipv4/udp.c
> > > > > @@ -1264,6 +1264,7 @@ int udp_sendmsg(struct sock *sk, struct m=
sghdr *msg, size_t len)
> > > > >       if (!corkreq) {
> > > > >               struct inet_cork cork;
> > > > >
> > > > > +             timestamp_call_bpf(sk, BPF_SOCK_OPS_TS_UDP_SND_CB=
, 0, NULL);
> > > > >               skb =3D ip_make_skb(sk, fl4, getfrag, msg, ulen,
> > > > >                                 sizeof(struct udphdr), &ipc, &r=
t,
> > > > >                                 &cork, msg->msg_flags);
> > > > > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uap=
i/linux/bpf.h
> > > > > index 6fc3bd12b650..055ffa7c965c 100644
> > > > > --- a/tools/include/uapi/linux/bpf.h
> > > > > +++ b/tools/include/uapi/linux/bpf.h
> > > > > @@ -7028,6 +7028,9 @@ enum {
> > > > >                                        * feature is on. It indi=
cates the
> > > > >                                        * recorded timestamp.
> > > > >                                        */
> > > > > +     BPF_SOCK_OPS_TS_UDP_SND_CB,     /* Called when every udp_=
sendmsg
> > > > > +                                      * syscall is triggered
> > > > > +                                      */
> > > >
> > > > If adding a timestamp as close to syscall entry as possible, give=
 it a
> > > > generic name, not specific to UDP.
> > >
> > > Good suggestion, then it will also solve the remaining issue for TC=
P type:
> > > __when__ we should record the user timestamp which exists in the
> > > application SO_TIMESTAMPING feature.
> > >
> > > >
> > > > And please explain in the commit message the reason for a new
> > > > timestamp recording point: with existing timestamping the applica=
tion
> > > > can call clock_gettime before (and optionally after) the send cal=
l.
> > > > An admin using BPF does not have this option, so needs this as pa=
rt of
> > > > the BPF timestamping API.
> > >
> > > Will revise this part. Thanks for your description!
> >
> > Actually, I may have misunderstood the intention of this new hook.
> >
> > I thought it was to record an additional timestamp.
> =

> I planned to do it after this series. For now, without the new hook,
> it will not work for UDP type.

Why not? This is something specific to the SK BPF hooks, I suppose?

As soon as bpf_setsockopt is called, the timestamp callbacks should
start getting called?

> >
> > But it is (also?) to program skb_shared_info.tx_flags based on
> > instructions parsed from cmsg in __sock_cmsg_send.
> =

> I'm not sure if I grasp the key point you said.
> =

> For UDP, skb_shared_info.tx_flags will finally be initialized in
> __ip_append_data() based on cork->tx_flags.
> =

> cork->tx_flags is computed by sock_tx_timestamp() based on
> ipc->sockc.tsflags if cmsg feature is turned on.
> =

> __sock_tx_timestamp() uses "flags |=3D xxx" to initialize the
> cork->tx_flags, so that the cork->tx_flags will not be completely
> overridden by either the cmsg method or bpf program, that is to say,
> the cork->tx_flags can combine both of them.
> =

> Then another key point is that we do the check to see which one
> actually works in sk_tstamp_tx_flags() by testing sk->sk_tsflags or
> sk->sk_tsflags_bpf in patch [2/14]. It guarantees that.

Ack, thanks. So I was mistaken the second time around.=

