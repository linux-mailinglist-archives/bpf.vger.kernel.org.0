Return-Path: <bpf+bounces-48903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A335AA11747
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245D03A6192
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C371F22DF9B;
	Wed, 15 Jan 2025 02:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUi6JR2E"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A744622DFAA;
	Wed, 15 Jan 2025 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908157; cv=none; b=cLu7ip+j5VrDAAtm8cadKmxENNsLmmNCp8IKBdDVp+hNB2krG6c4RvQrqC36kzj/QJGRsC0SHYGbQdwCPWHY7zQUmEbGmJy1Zh/UzaDy0xjrQIYFYALIDOFr9mY7Zw7YAI0qcAT7s4JbAk20+fHREuSD568okcVZG0DvJnxR1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908157; c=relaxed/simple;
	bh=NmyiW9AftvMVPLoKjHvXrOE46WrlYJCZiVpFxsLhN2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGyFZKLn2zgLuppu3DOks5PTRmdU/u9yrHcnbO/pXobfdwYdCZIjzPnMgf6D6WajIzu+pmKGqPHHPVjp1DgrZM8+VpaGuW0JC/6OwmzGfllLf6vtZNntbomBk/qNUg6NjX/wphE5o15orI/HTuvnXBs0vVrtwaLukbB+TSniFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PUi6JR2E; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ce85e37887so2384015ab.2;
        Tue, 14 Jan 2025 18:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736908155; x=1737512955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irn6DQdHf8knpDHQisshc6XL3aZa3AbkiUTVDG0u2Nk=;
        b=PUi6JR2EcrwLW7+pqCLyrMN0Lpo/VNLz4YJ2A4kcT2vh+JUfvQ5HJf017V57/DTWSr
         8zvXph/55UM+MgQG20zoI0JfBCFFnlsuYuev6s6IyCNc8Z+dYwN0NEamOMcB8OvfaPmX
         aESAWXX6j8Dqq0pNiwFJphZLhzDnzGY2VAgUA/2BhJcNMrmbYB87U3z79gxskdSc6uJE
         sRL+6ZsmN966tl4j+APYrU37jniJ4PEosfF37EJvpLlXxvTc60g0sSff5URU4TY/gsfV
         fQPJsOjgbuQokWNeozH7BFGj1SXMinh94MA/kL6MBsnUWB4CbJvXMrkyn4PI4LPKhma+
         DyvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736908155; x=1737512955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irn6DQdHf8knpDHQisshc6XL3aZa3AbkiUTVDG0u2Nk=;
        b=BrSJvyVC/bLOQn4IrvDVCfNwIsay6zy9Pij2D+x6R6qqXX0L+meAVtgJj1Bhijg8x9
         lZU2z4X+RXPrpFXNdric0tVwMaXENTPLxCvcTsp3t6LsTApQsKlHQEjMMNbBSFngWc1K
         whIpVqhgcAsY3S6Z9LRY5H9us+56j1fvWIykisbXAwV8RBLKgbo2ntyZsBbSsgcssan7
         5O9jx/dtv+8MqUPqvzJDJx0Sgon6zU6nIuRWyPK9CqtR2D5gnhza+P4AhMQdc1WLbQQ0
         Y2eN+vq0eeNaYje/Q9fsHtGkYIt76fTrLM2apOkQuBgXSwCC1+33I4j+xdSv0Iv+bxmw
         SSdw==
X-Forwarded-Encrypted: i=1; AJvYcCV0hiJT8orJxiYeaa2azc04pHFQALozxMQMWvxoQRFzbPPLpr429Qbl8T341yx0e47S8g+BosxH@vger.kernel.org, AJvYcCXCfzFeiobHyOpWPocLO7aUpqTz4fJASR0Z9iCwjXCZrL4jF/KHPwgnEmBk5xN04GaWbH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypArVQMj3fIy2PE1GjiSqer1fLgs+j/KWMBuNRP83jx+Zz3GUn
	/XrEvBj8TmFV2+PfX5XqrVkyniVLJHDfoXx5/MTpvpZlUBHFbtqFWMoD+yZjZ7kDFeXJYyT+/oY
	1epKZtaexerC5kV9VwCIcdO3gKdc=
X-Gm-Gg: ASbGnctTpm3ZCSEePehqkAGc5Lv55N0vjuGIbfRGy6BQhg/zMy0cYwyz6kqWjg41jyd
	QdQflxr8rTpiaMndoukX6+Txoh4Fv2uCTaIOakQ==
X-Google-Smtp-Source: AGHT+IFm0xFQyriIaU7Z12LdgXHn1Bvb1AOQxGQp6Yd8B+cIK8+Vmf7lAv5em1NpozYowsVoTaw7rvJBQx93xNXsdvM=
X-Received: by 2002:a05:6e02:1905:b0:3ce:7cf3:27c1 with SMTP id
 e9e14a558f8ab-3ce7cf33107mr33857075ab.1.1736908154797; Tue, 14 Jan 2025
 18:29:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-4-kerneljasonxing@gmail.com> <02031003-872e-49bf-a658-c22bc7e1a954@linux.dev>
In-Reply-To: <02031003-872e-49bf-a658-c22bc7e1a954@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Jan 2025 10:28:38 +0800
X-Gm-Features: AbW1kvbs-ny2l4aBJNYL7hgOAmNfImXnXgZrss_6PRiFGy_lrvaq1d-lRfiv5OM
Message-ID: <CAL+tcoD6MqBfbpM+ESkiNoRwsQqWsxMwMb4b0qvO=Cf8s52JyA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 03/15] bpf: introduce timestamp_used to allow
 UDP socket fetched in bpf prog
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

On Wed, Jan 15, 2025 at 9:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> > timestamp_used consists of two parts, one is is_fullsock, the other
> > one is for UDP socket which will be support in the next round.
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   include/linux/filter.h | 1 +
> >   net/core/filter.c      | 4 ++--
> >   net/core/sock.c        | 1 +
> >   net/ipv4/tcp_input.c   | 2 ++
> >   net/ipv4/tcp_output.c  | 2 ++
> >   5 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index a3ea46281595..daca3fe48b8f 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1508,6 +1508,7 @@ struct bpf_sock_ops_kern {
> >       void    *skb_data_end;
> >       u8      op;
> >       u8      is_fullsock;
> > +     u8      timestamp_used;
> >       u8      remaining_opt_len;
> >       u64     temp;                   /* temp and everything after is n=
ot
> >                                        * initialized to 0 before callin=
g
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index c6dd2d2e44c8..1ac996ec5e0f 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -10424,10 +10424,10 @@ static u32 sock_ops_convert_ctx_access(enum b=
pf_access_type type,
> >               }                                                        =
     \
> >               *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(                =
       \
> >                                               struct bpf_sock_ops_kern,=
     \
> > -                                             is_fullsock),            =
     \
> > +                                             timestamp_used),         =
     \
> >                                     fullsock_reg, si->src_reg,         =
     \
> >                                     offsetof(struct bpf_sock_ops_kern, =
     \
> > -                                            is_fullsock));            =
     \
> > +                                            timestamp_used));         =
     \
>
> hmm... I don't think it is the right change. This change may disallow the=
 bpf
> prog from reading skops->sk. It is fine to allow bpf prog (includes the n=
ew
> timestamp callback) getting the skops->sk as long as skops->sk is a fulls=
ock.

Well, I missed some places to be changed. My original intention is
similar to yours: if it's a tcp socket && full socket, then it will be
allowed to access.

>
> The actual thing that needs to address is writing to sk, like:
>
>         case offsetof(struct bpf_sock_ops, sk_txhash):
>                 SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
>                                            struct sock, type);
>

Oh, I missed this one. I will take care of it carefully, at least
stopping writing the socket in the timestamping callback.

>
> and also all the SOCK_OPS_GET_TCP_SOCK_FIELD() to prepare for the udp soc=
k
> support. After this patch 3, I think I start to understand the udp/fullso=
ck
> discussion in patch 2. is_fullsock here does not mean it is tcp, although=
 it is
> always a tcp_sock now. It literally means it is a full "struct sock". The
> verifier will treat the skops->sk as "struct sock" instead of "struct tcp=
_sock".

Right, I was trying to limit is_fullsock to only tcp type.

>
> >               *insn++ =3D BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);  =
       \
> >               if (si->dst_reg =3D=3D si->src_reg)                      =
         \
> >                       *insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,=
       \
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index e06bcafb1b2d..dbb9326ae9d1 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -958,6 +958,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, str=
uct sk_buff *skb, int op)
> >       if (sk_is_tcp(sk) && sk_fullsock(sk))
> >               sock_ops.is_fullsock =3D 1;
> >       sock_ops.sk =3D sk;
> > +     sock_ops.timestamp_used =3D 1;
> >       __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS);
> >   }
> >   #endif
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index 4811727b8a02..cad41ad34bd5 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -169,6 +169,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, st=
ruct sk_buff *skb)
> >       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> >       sock_ops.op =3D BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
> >       sock_ops.is_fullsock =3D 1;
> > +     sock_ops.timestamp_used =3D 1;
> >       sock_ops.sk =3D sk;
> >       bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
> >
> > @@ -185,6 +186,7 @@ static void bpf_skops_established(struct sock *sk, =
int bpf_op,
> >       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> >       sock_ops.op =3D bpf_op;
> >       sock_ops.is_fullsock =3D 1;
> > +     sock_ops.timestamp_used =3D 1;
> >       sock_ops.sk =3D sk;
> >       /* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connect =
*/
> >       if (skb)
> > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > index 0e5b9a654254..7b4d1dfd57d4 100644
> > --- a/net/ipv4/tcp_output.c
> > +++ b/net/ipv4/tcp_output.c
> > @@ -522,6 +522,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk, =
struct sk_buff *skb,
> >               sock_owned_by_me(sk);
> >
> >               sock_ops.is_fullsock =3D 1;
> > +             sock_ops.timestamp_used =3D 1;
> >               sock_ops.sk =3D sk;
> >       }
> >
> > @@ -567,6 +568,7 @@ static void bpf_skops_write_hdr_opt(struct sock *sk=
, struct sk_buff *skb,
> >               sock_owned_by_me(sk);
> >
> >               sock_ops.is_fullsock =3D 1;
> > +             sock_ops.timestamp_used =3D 1;
>
> The "timestamp_used =3D 1;' assignment has missed some places. At least i=
n the
> tcp_call_bpf().

Thanks for double checking. I will count it too.

>
> Also, the name "timestamp_used" is confusing. Like setting timestamp_used=
 in the
> bpf_skops_*_hdr_opt() callback here when it is not a timestamp callback.
>
> Altogether, need to rethink what to add to sock_ops instead of timestamp_=
used
> and it should be checked in "some" of the SOCK_OPS_*_FIELD(). A quick tho=
ught
> (not 100% sure) is to add "u8 allow_direct_access" which is only set for =
the
> existing sockops callbacks.

Sounds good. I will use this one :)

>
> [ I will continue the rest later. ]

Thanks for your help!

Thanks,
Jason

