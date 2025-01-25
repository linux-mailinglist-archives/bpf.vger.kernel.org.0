Return-Path: <bpf+bounces-49742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43878A1C048
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E887A43BC
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DE81EEA5E;
	Sat, 25 Jan 2025 01:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hz8M4pnl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE95225D6;
	Sat, 25 Jan 2025 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768771; cv=none; b=nPY3Z5Qy9x3O1Swpv1HclqCEaOIDoN0whVHyJnszBwSKagsX38kNX93vAPF1bTM9lrPm/tIDMs9skpVsQjUYanPFbA4IoianO79GwgtkHTrCYBpzBiflur89nX2jIVaOMiRCDlw+EFHUjBKa2g/e+vLjtqo+I13imV7oHcBsr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768771; c=relaxed/simple;
	bh=Rb+Av15DwJBIwwfg9rz5/95evZW/MzNUIMS5zTz4sHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rEh/aLWIBfqFr620B/43Ve3n1DY9J3q2WQPPLpdJnMZ5A5BCzE0qBM/5R6uENTId3u+P6uuoZje3Jb8iWdlRr39QQBFRC1u+M2c+FuqsIfqXwarWIT4GL6JqJ8MUkM++Yu+qxiq1FmhNV3WFuf6XJXoWo6CktYlgqReVhLc6Hlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hz8M4pnl; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce886a2d5bso19509825ab.1;
        Fri, 24 Jan 2025 17:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737768768; x=1738373568; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAf+TXvx0bqpauwF2qSLwkkZi2PRbCcp/SC5hZhAeAY=;
        b=hz8M4pnlkdpyugjcgAdCnbfwF2+Hd51Qf45Ee2K53+1eP6Xe4OAkrFjWOKtYnWo/kU
         IxYTMxq1oU/WO/AGlvTp4F3JLQ6HtF1I5OUmD+ewgE+CiS1tDhiHG4Yb+iFlrGQzfdTO
         qNCKc1g8MV4RVUwrJsJ4Vd5phgoZbVFFZ64THwHJfaVmw1JOb0x/O2JJxKcTcH6+9bBl
         lorx+5I5c05/lQkWAoEQCx6hSP7f1Iolum27MQfU4qn57rNZW0LxP5SZiOrxibH2KReb
         BSfepRi2aQILlkZFB73ARQTeZzIWjcLZ/aU18Rmg0crfVbNd6TQ30Ynq2XdRCU2C/87O
         CUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737768768; x=1738373568;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAf+TXvx0bqpauwF2qSLwkkZi2PRbCcp/SC5hZhAeAY=;
        b=kgANEyk9faQiRjFhrHlWXKPCM0pqEx1NyIlr+QMmXng6HAflm0SuICtD2x6RnjTL7g
         B1cvACQP/Y87515OUCZiU6v7k5Mp7Z5qXrxutLXljuYUTHP1EeuR1qgKE54QPym3VPmM
         Tc9ahnxGp2GAumd6OwRMwJq88KzjqLguGQe4VoN6m+mupcW4Z0fhEnTBH9PYBI3QBgNv
         0aXomnPACvXN+0vQKKXx9lcwaMuYkHnBnKMF6ENemOxmm/PCrgUA92alVNES/MhTGR1p
         edqoIazRStTyrOAyGKiSgxmKrpEf0J260vcSJa8YfIknBJXLXhCgd0EcTuoBw7ZDB40I
         R2yg==
X-Forwarded-Encrypted: i=1; AJvYcCVOUD8LpGTMY6m+xQgNQ+i+KUbfl2dNZhtPAg6vpcRkJFez63me5wALsn0omL5CBHZETJ+vvNZv@vger.kernel.org, AJvYcCXeK5wGDOVfGkm+pIr/DtWsNugzfYHeON9Biq2nhtBHa/ndNGRYwEkjgCJfxtSfNVTHUBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgXqnR8TbnVY6Ee9nFKDru9pNdjOnTfIlqNmnMtkf4oIz9YwBw
	VqSWl009/1EA4KHz852BWAE2ZhFZNOf2BAlr3Lw5A6tqzhiTly5ecApb87BODU3HusFgbGk+91N
	E6yURx+6nTEj03bck8HNviIMmabo=
X-Gm-Gg: ASbGncu/ZjE/gQ4CLMtedYo+9oP1hq4uABx921+xY5zFml+FtGnUPLvDy354ie5jJho
	R3KxgBfwIqiOQUFL0SkRARupmhBlSTjskFDMTdX2AUWapEaemTa4tL1NqZR2mIA==
X-Google-Smtp-Source: AGHT+IHsMjRQKH2ER91t8cYEiuL21FfkuOPfmq5IqgMUHeLIqgwGUfYMmewPiJA4Rme2L5X+4KuXBnk2nfW8mJhcBF0=
X-Received: by 2002:a05:6e02:98a:b0:3cf:c06d:86c2 with SMTP id
 e9e14a558f8ab-3cfc06d8703mr52133245ab.16.1737768768415; Fri, 24 Jan 2025
 17:32:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-5-kerneljasonxing@gmail.com> <1c2f4735-bddb-4ce7-bd0a-5dbb31cb0c45@linux.dev>
 <CAL+tcoAXgeSNb3PNdqLxd1amryQ7FNT=8OQampZFL9LzdPmBrA@mail.gmail.com>
In-Reply-To: <CAL+tcoAXgeSNb3PNdqLxd1amryQ7FNT=8OQampZFL9LzdPmBrA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 09:32:12 +0800
X-Gm-Features: AWEUYZkQUFgmHh44niaDolL9us-UZiDE_VwSD5WU3HhsC07mGuj6bxLxTO3EMV4
Message-ID: <CAL+tcoAmtW=bGWXpNQBtNtzFA62CN4jEZNswxui-wd7wPQqnHQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 04/13] bpf: stop UDP sock accessing TCP
 fields in sock_op BPF CALLs
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

On Sat, Jan 25, 2025 at 9:15=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Sat, Jan 25, 2025 at 8:28=E2=80=AFAM Martin KaFai Lau <martin.lau@linu=
x.dev> wrote:
> >
> > On 1/20/25 5:28 PM, Jason Xing wrote:
> > > In the next round, we will support the UDP proto for SO_TIMESTAMPING
> > > bpf extension, so we need to ensure there is no safety problem, which
> > > is ususally caused by UDP socket trying to access TCP fields.
> > >
> > > These approaches can be categorized into two groups:
> > > 1. add TCP protocol check
> > > 2. add sock op check
> >
> > Same as patch 3. The commit message needs adjustment. I would combine p=
atch 3
> > and patch 4 because ...
>
> I wonder if you refer to "squashing" patch 4 into patch 3?
>
> >
> > >
> > > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > > ---
> > >   net/core/filter.c | 19 +++++++++++++++++--
> > >   1 file changed, 17 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index fdd305b4cfbb..934431886876 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -5523,6 +5523,11 @@ static int __bpf_setsockopt(struct sock *sk, i=
nt level, int optname,
> > >       return -EINVAL;
> > >   }
> > >
> > > +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_soc=
k)
> > > +{
> > > +     return bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
> >
> > More bike shedding...
> >
> > After sleeping on it again, I think it can just test the
> > bpf_sock->allow_tcp_access instead.
>
> Sorry, I don't think it can work for all the cases because:
> 1) please see BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_CB,
> if req exists, there is no allow_tcp_access initialization. Then
> calling some function like bpf_sock_ops_setsockopt will be rejected
> because allow_tcp_access is zero.
> 2) tcp_call_bpf() only set allow_tcp_access only when the socket is
> fullsock. As far as I know, all the callers have the full stock for
> now, but in the future it might not.
>
> If we should use allow_tcp_access to test, then the following patch
> should be folded into patch 3, right?
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 0e5b9a654254..9cd7d4446617 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -525,6 +525,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk,
> struct sk_buff *skb,
>                 sock_ops.sk =3D sk;
>         }
>
> +       sock_ops.allow_tcp_access =3D 1;
>         sock_ops.args[0] =3D bpf_skops_write_hdr_opt_arg0(skb, synack_typ=
e);
>         sock_ops.remaining_opt_len =3D *remaining;
>         /* tcp_current_mss() does not pass a skb */
>
>
> >
> >
> > > +}
> > > +
> > >   static int _bpf_setsockopt(struct sock *sk, int level, int optname,
> > >                          char *optval, int optlen)
> > >   {
> > > @@ -5673,7 +5678,12 @@ static const struct bpf_func_proto bpf_sock_ad=
dr_getsockopt_proto =3D {
> > >   BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf=
_sock,
> > >          int, level, int, optname, char *, optval, int, optlen)
> > >   {
> > > -     return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, op=
tlen);
> > > +     struct sock *sk =3D bpf_sock->sk;
> > > +
> > > +     if (is_locked_tcp_sock_ops(bpf_sock) && sk_fullsock(sk))
> >
> > afaict, the new timestamping callbacks still can do setsockopt and it i=
s
> > incorrect. It should be:
> >
> >         if (!bpf_sock->allow_tcp_access)
> >                 return -EOPNOTSUPP;
> >
> > I recalled I have asked in v5 but it may be buried in the long thread, =
so asking
> > here again. Please add test(s) to check that the new timestamping callb=
acks
> > cannot call setsockopt and read/write to some of the tcp_sock fields th=
rough the
> > bpf_sock_ops.
> >
> > > +             sock_owned_by_me(sk);
> >
> > Not needed and instead...
>
> Sorry I don't get you here. What I was doing was letting non
> timestamping callbacks be checked by the sock_owned_by_me() function.
>
> If the callback belongs to timestamping, we will skip the check.
>
> >
> > > +
> > > +     return __bpf_setsockopt(sk, level, optname, optval, optlen);
> >
> > keep the original _bpf_setsockopt().
>
> Oh, I remembered we've already assumed/agreed the timestamping socket
> must be full sock. I will use it.

Oh, no. We cannot use it because it will WARN us if the socket is not held:
static int _bpf_setsockopt(struct sock *sk, int level, int optname,
                           char *optval, int optlen)
{
        if (sk_fullsock(sk))
                sock_owned_by_me(sk);
        return __bpf_setsockopt(sk, level, optname, optval, optlen);
}

Let me rephrase what I know about the TCP and UDP cases:
1) the sockets are full socket.
2) the sockets are under the protection of socket lock, but in the
future they might not.

So we need to check if it's a fullsock but we don't expect to get any
warnings because the socket is not locked.

Am I right about those two?

Thanks,
Jason

>
> >
> > >   }
> > >
> > >   static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto =
=3D {
> > > @@ -5759,6 +5769,7 @@ BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_=
sock_ops_kern *, bpf_sock,
> > >          int, level, int, optname, char *, optval, int, optlen)
> > >   {
> > >       if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&
> > > +         bpf_sock->sk->sk_protocol =3D=3D IPPROTO_TCP &&
> > >           optname >=3D TCP_BPF_SYN && optname <=3D TCP_BPF_SYN_MAC) {
> >
> > No need to allow getsockopt regardless what SOL_* it is asking. To keep=
 it
> > simple, I would just disable both getsockopt and setsockopt for all SOL=
_* for
>
> Really? I'm shocked because the selftests in this series call
> bpf_sock_ops_getsockopt() and bpf_sock_ops_setsockopt() in patch
> [13/13]:
> ...
> if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
> ...
>
> > the new timestamping callbacks. Nothing is lost, the bpf prog can direc=
tly read
> > the sk.
> >
> > >               int ret, copy_len =3D 0;
> > >               const u8 *start;
> > > @@ -5800,7 +5811,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bp=
f_sock_ops_kern *, bpf_sock,
> > >       struct sock *sk =3D bpf_sock->sk;
> > >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> > >
> > > -     if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> > > +     if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk) ||
> > > +         sk->sk_protocol !=3D IPPROTO_TCP)
> >
> > Same here. It should disallow this "set" helper for the timestamping ca=
llbacks
> > which do not hold the lock.
> >
> > >               return -EINVAL;
> > >
> > >       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > > @@ -7609,6 +7621,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bp=
f_sock_ops_kern *, bpf_sock,
> > >       u8 search_kind, search_len, copy_len, magic_len;
> > >       int ret;
> > >
> > > +     if (!is_locked_tcp_sock_ops(bpf_sock))
> > > +             return -EOPNOTSUPP;
> >
> > This is correct, just change it to "!bpf_sock->allow_tcp_access".
> >
> > All the above changed helpers should use the same test and the same ret=
urn handling.
> >
> > > +
> > >       /* 2 byte is the minimal option len except TCPOPT_NOP and
> > >        * TCPOPT_EOL which are useless for the bpf prog to learn
> > >        * and this helper disallow loading them also.
> >

