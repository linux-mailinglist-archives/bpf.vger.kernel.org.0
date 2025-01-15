Return-Path: <bpf+bounces-48904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D1A11781
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 03:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26A151888A45
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 02:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661BF22DFB2;
	Wed, 15 Jan 2025 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib2ec0kB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499732D600;
	Wed, 15 Jan 2025 02:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736909689; cv=none; b=B7P9ngKnm4W2kHINBhPb6ii8D0iMNbgY/L8601LgydZAgvlhhLc8oL8ndtIdqQbJlcscah64ILgEbDQ9G90QXUYV/W7UA2c//RibtHTnmgHvagPZnFVfusvunPilNrsxaCqTpiwtP60GCbd0LZquNu5P7rYG55P96yP4XTt9g5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736909689; c=relaxed/simple;
	bh=3f9tsdQ/i7+iNdDMX5xcn0SYdzeYm83JtIMSwH2Bojw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgXxbIxtmGMuVXI8+/wwsTO/WN4ZtNjm6pj2a9768sHhVxzNvN35Z8+doeIb3U70dQl9+zBS1ZRjRBjKaPRyyjG48XPnWgdFjDuEBs2t0Vu5ovkkPYkr10VrGnAjc6vHlMIhrkDq3r7lKR1nzmgQ/uChFcKz5x+hj9SujQPVAZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ib2ec0kB; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3ce464e52bdso17932905ab.1;
        Tue, 14 Jan 2025 18:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736909686; x=1737514486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6Mrpt3pffGblA1/hx81FkYe/i4XNvH59HTT9/eYD9g=;
        b=Ib2ec0kBJxDVpz4gT5cUwHHXKfh8wP0Nzg+SkeLwr9bNiSYfBP1gzqEuXshZ8au3Bb
         g3xgqREayUOyn8Qg31wiwxTgKgWoeDUPdx3JFWZBK5R5o1oNdndf4B+ShhYnzLDCNWRD
         AZtuAcyfuTvDR1ap0p8/dduyi42yhYwkzySYK5NdL30y+HwIcCrQC7sUAHK4YGzjpoQs
         Z0L6bdaSYZEbB9//wfFuQ91XOToNT62PEVJRhmRrCmmENdF/5gwtAxPmiBoTegTo0jTJ
         BW0ElmlpsyS+A+NOM+QFGOMYz1YG3F7bOXIXQbfz3yJWpKxnfedpes0PQmSOmlVce8F2
         rQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736909686; x=1737514486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6Mrpt3pffGblA1/hx81FkYe/i4XNvH59HTT9/eYD9g=;
        b=KasAHhlgJAEBMgDZ2H9D5Y3bu/KdPnxH0eGsEQioKJIGk+FO5KtVKY3/tw8YQAXiu5
         knPt4G2zBSANr7z+ApIYUQwVB5xz6zp65wjJsW416Pzw+VX0stjWmSaiPnXpMi4GvriC
         wd7KfqtPJDKU1IwC715ji/iY+BpLZFw6d6NzX6kGPBgEgKq7JWCfYOFMUmNkremd99vy
         gXL9qPalUHLUVUydBcTPbIFcu95gd68d+gx7VUC3px4rRTksu7eyHY2aIfBTr9oPBjqW
         tfhZlkWY2aVDSBRh1iX2H7dhmhQx0Mci0YXefbmNI7ln0CviM+iibuITMVVC3SI6b7Me
         RSrw==
X-Forwarded-Encrypted: i=1; AJvYcCV9/1QxAgrKZG3dskvk/3cUf++s9JVo9aZaGUgCPc+BFYvYJHFdjq/JvOEbW4woaBYm92E=@vger.kernel.org, AJvYcCWkUYpcU1r1xwscHERNZQodAPgcteYzTAfdWFNUPFLRSoYRx3GmmJKGf8SFPAlAJG/SbHHQ34OI@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ12Z6ngOPIN1pep8rZ4YW+fNvRw0xO00wGO6Zw0LMew/f0oRM
	19jkgItQWDygcF54/rcLh1zUjr+XPX3otMKtyBsnx21xwwsuyaFGHzNwzehRO3o8+hV4WpAF9HK
	c+MF4ukXoPhhZIJ2DUsVDulJ9W8c=
X-Gm-Gg: ASbGncsnRB8xyzka0HlmsFpXUbaVwB3Lyr9ThpjgXT4AHyRwXvaPJ8mElmpEyvHCE/R
	bx7xX8UcLoZEAW7YFncmfD60RTTqiIXGmMYs0Ng==
X-Google-Smtp-Source: AGHT+IGgR/8bHBigEeafIJv5ZoJhW1DM8ZNkZhywFLYyjBW5XM1wmuecLLUcy9kd5BHpoAmpii7udpxfGyubPhjoKzs=
X-Received: by 2002:a05:6e02:1f05:b0:3ce:31f4:91c2 with SMTP id
 e9e14a558f8ab-3ce3a9c6c4emr190866095ab.11.1736909686266; Tue, 14 Jan 2025
 18:54:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-4-kerneljasonxing@gmail.com> <02031003-872e-49bf-a658-c22bc7e1a954@linux.dev>
 <CAL+tcoD6MqBfbpM+ESkiNoRwsQqWsxMwMb4b0qvO=Cf8s52JyA@mail.gmail.com>
In-Reply-To: <CAL+tcoD6MqBfbpM+ESkiNoRwsQqWsxMwMb4b0qvO=Cf8s52JyA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 15 Jan 2025 10:54:09 +0800
X-Gm-Features: AbW1kvaxeiGonOsnuwBiu1WNHrFZlKffDKySQmOSQXGJgZkag8mv1Kbh9ufOH8E
Message-ID: <CAL+tcoDS6H4SMDRs9r+cOM_2bdbNRFRQpuYmpVFyxoMcQJDXLQ@mail.gmail.com>
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

On Wed, Jan 15, 2025 at 10:28=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Wed, Jan 15, 2025 at 9:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 1/12/25 3:37 AM, Jason Xing wrote:
> > > timestamp_used consists of two parts, one is is_fullsock, the other
> > > one is for UDP socket which will be support in the next round.
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >   include/linux/filter.h | 1 +
> > >   net/core/filter.c      | 4 ++--
> > >   net/core/sock.c        | 1 +
> > >   net/ipv4/tcp_input.c   | 2 ++
> > >   net/ipv4/tcp_output.c  | 2 ++
> > >   5 files changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index a3ea46281595..daca3fe48b8f 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -1508,6 +1508,7 @@ struct bpf_sock_ops_kern {
> > >       void    *skb_data_end;
> > >       u8      op;
> > >       u8      is_fullsock;
> > > +     u8      timestamp_used;
> > >       u8      remaining_opt_len;
> > >       u64     temp;                   /* temp and everything after is=
 not
> > >                                        * initialized to 0 before call=
ing
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index c6dd2d2e44c8..1ac996ec5e0f 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -10424,10 +10424,10 @@ static u32 sock_ops_convert_ctx_access(enum=
 bpf_access_type type,
> > >               }                                                      =
       \
> > >               *insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(              =
         \
> > >                                               struct bpf_sock_ops_ker=
n,     \
> > > -                                             is_fullsock),          =
       \
> > > +                                             timestamp_used),       =
       \
> > >                                     fullsock_reg, si->src_reg,       =
       \
> > >                                     offsetof(struct bpf_sock_ops_kern=
,      \
> > > -                                            is_fullsock));          =
       \
> > > +                                            timestamp_used));       =
       \
> >
> > hmm... I don't think it is the right change. This change may disallow t=
he bpf
> > prog from reading skops->sk. It is fine to allow bpf prog (includes the=
 new
> > timestamp callback) getting the skops->sk as long as skops->sk is a ful=
lsock.
>
> Well, I missed some places to be changed. My original intention is
> similar to yours: if it's a tcp socket && full socket, then it will be
> allowed to access.
>
> >
> > The actual thing that needs to address is writing to sk, like:
> >
> >         case offsetof(struct bpf_sock_ops, sk_txhash):
> >                 SOCK_OPS_GET_OR_SET_FIELD(sk_txhash, sk_txhash,
> >                                            struct sock, type);
> >
>
> Oh, I missed this one. I will take care of it carefully, at least
> stopping writing the socket in the timestamping callback.
>
> >
> > and also all the SOCK_OPS_GET_TCP_SOCK_FIELD() to prepare for the udp s=
ock
> > support. After this patch 3, I think I start to understand the udp/full=
sock
> > discussion in patch 2. is_fullsock here does not mean it is tcp, althou=
gh it is
> > always a tcp_sock now. It literally means it is a full "struct sock". T=
he
> > verifier will treat the skops->sk as "struct sock" instead of "struct t=
cp_sock".
>
> Right, I was trying to limit is_fullsock to only tcp type.
>
> >
> > >               *insn++ =3D BPF_JMP_IMM(BPF_JEQ, fullsock_reg, 0, jmp);=
         \
> > >               if (si->dst_reg =3D=3D si->src_reg)                    =
           \
> > >                       *insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_re=
g,       \
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index e06bcafb1b2d..dbb9326ae9d1 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -958,6 +958,7 @@ void bpf_skops_tx_timestamping(struct sock *sk, s=
truct sk_buff *skb, int op)
> > >       if (sk_is_tcp(sk) && sk_fullsock(sk))
> > >               sock_ops.is_fullsock =3D 1;
> > >       sock_ops.sk =3D sk;
> > > +     sock_ops.timestamp_used =3D 1;
> > >       __cgroup_bpf_run_filter_sock_ops(sk, &sock_ops, CGROUP_SOCK_OPS=
);
> > >   }
> > >   #endif
> > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > index 4811727b8a02..cad41ad34bd5 100644
> > > --- a/net/ipv4/tcp_input.c
> > > +++ b/net/ipv4/tcp_input.c
> > > @@ -169,6 +169,7 @@ static void bpf_skops_parse_hdr(struct sock *sk, =
struct sk_buff *skb)
> > >       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > >       sock_ops.op =3D BPF_SOCK_OPS_PARSE_HDR_OPT_CB;
> > >       sock_ops.is_fullsock =3D 1;
> > > +     sock_ops.timestamp_used =3D 1;
> > >       sock_ops.sk =3D sk;
> > >       bpf_skops_init_skb(&sock_ops, skb, tcp_hdrlen(skb));
> > >
> > > @@ -185,6 +186,7 @@ static void bpf_skops_established(struct sock *sk=
, int bpf_op,
> > >       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
> > >       sock_ops.op =3D bpf_op;
> > >       sock_ops.is_fullsock =3D 1;
> > > +     sock_ops.timestamp_used =3D 1;
> > >       sock_ops.sk =3D sk;
> > >       /* sk with TCP_REPAIR_ON does not have skb in tcp_finish_connec=
t */
> > >       if (skb)
> > > diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> > > index 0e5b9a654254..7b4d1dfd57d4 100644
> > > --- a/net/ipv4/tcp_output.c
> > > +++ b/net/ipv4/tcp_output.c
> > > @@ -522,6 +522,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk=
, struct sk_buff *skb,
> > >               sock_owned_by_me(sk);
> > >
> > >               sock_ops.is_fullsock =3D 1;
> > > +             sock_ops.timestamp_used =3D 1;
> > >               sock_ops.sk =3D sk;
> > >       }
> > >
> > > @@ -567,6 +568,7 @@ static void bpf_skops_write_hdr_opt(struct sock *=
sk, struct sk_buff *skb,
> > >               sock_owned_by_me(sk);
> > >
> > >               sock_ops.is_fullsock =3D 1;
> > > +             sock_ops.timestamp_used =3D 1;
> >
> > The "timestamp_used =3D 1;' assignment has missed some places. At least=
 in the
> > tcp_call_bpf().
>
> Thanks for double checking. I will count it too.
>
> >
> > Also, the name "timestamp_used" is confusing. Like setting timestamp_us=
ed in the
> > bpf_skops_*_hdr_opt() callback here when it is not a timestamp callback=
.
> >
> > Altogether, need to rethink what to add to sock_ops instead of timestam=
p_used
> > and it should be checked in "some" of the SOCK_OPS_*_FIELD(). A quick t=
hought
> > (not 100% sure) is to add "u8 allow_direct_access" which is only set fo=
r the
> > existing sockops callbacks.
>
> Sounds good. I will use this one :)

I construct my thoughts here according to our previous discussion:
1. not limiting the use of is_fullsock, so in patch 2, I will use the
follow codes:
+void bpf_skops_tx_timestamping(struct sock *sk, struct sk_buff *skb, int o=
p)
+{
+       struct bpf_sock_ops_kern sock_ops;
+
+       memset(&sock_ops, 0, offsetof(struct bpf_sock_ops_kern, temp));
+       sock_ops.op =3D op;
+       sock_ops.is_fullsock =3D 1;
+       sock_ops.sk =3D sk;
+       BPF_CGROUP_RUN_PROG_SOCK_OPS(sk, &sock_ops, CGROUP_SOCK_OPS);
+}

2. introduce the allow_direct_access flag which is used to test if the
socket is allowed to access tcp socket or not.
On the basis of the above bpf_skops_tx_timestamping() function, I
would add one check there:
+ if (sk_is_tcp(sk))
+       sock_ops. allow_direct_access =3D 1;

Also, I need to set allow_direct_access to one as long as there is
"sock_ops.is_fullsock =3D 1;" in the existing callbacks.

3. I will replace is_fullsock with allow_direct_access in
SOCK_OPS_GET/SET_FIELD() instead of SOCK_OPS_GET_SK().

Then the udp socket can freely access the socket with the helper
SOCK_OPS_GET_SK() because it is a fullsock. And udp socket cannot
access struct tcp_sock because in the timestamping callback, there is
no place where setting allow_direct_access for udp use.

Thanks,
Jason

