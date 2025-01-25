Return-Path: <bpf+bounces-49734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97EA1C014
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26E5168D85
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213D61EEA54;
	Sat, 25 Jan 2025 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbNkFdA9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465A1DE4E1;
	Sat, 25 Jan 2025 01:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737767773; cv=none; b=TDoeeZwOtLEN7I+o5dQ8hO8xGd9ft8W80Tn57gbYhPfdCqgieXr2ZRst/aht7PpwJiSwl0llVpV1MWgGZzmwLUSqvoi96uGN7KDcvpI9whR5C7yZmxuRqZxxporIrGBr0alJXCNhKeCBPoRZvjJoyucBZq/aoL9KZy8S6DwSRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737767773; c=relaxed/simple;
	bh=9PxVYJ30twNUpzn9fP26geQXbMVedpWzOyJ01KVd2aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/FeVii1Fm+sF8+KC2Qg89zRVCIzr0nsIw+1Tja16APYCJszFtumzi36b2nlllrlixo3jILxKA0ExdNG7pXZ5iMIhjY6h50VTN+sPRGake3qco84h6dVGz9qqKPg9TSHHaQHu/2JimZO1r4Fqg7ppVbmNIk7jGqIy45MPEYxxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbNkFdA9; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3cf8e017abcso8716505ab.1;
        Fri, 24 Jan 2025 17:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737767771; x=1738372571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOhO6M0TbmI7L/EpoUIms+VJjp1fN68FRkuEBVDdAoE=;
        b=FbNkFdA9rm1huR/iijtTt3YPsUUbnQSMt+i0s0a/NB4f/9paNeA2eNsCxnMXPEGpM+
         TVHRKspDPzz6qSdMv9/48P4NkGH6go8bE9Qjhw834PdvHTkDyZYXn6yEx4uQZc/n19fa
         kNK9z7892G7b8Ps+1mRu4pL73rsE4b2VUwY8/NoanPEsnBCCy89UuHxvQS6Hjpo1g2iF
         /zpFwkqJbGre0fdKhnbOXrZ0N+cro33Gr+B4IDoWhcOGDGycA0MikueXxVLhEVpkn8Gi
         ZAaTmtdS7LYxpi7QTM4grGntQNMcViCn3ZvEiDNull+0KF6CJYNe5YmgTEhAFgOhV6Wk
         d9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737767771; x=1738372571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UOhO6M0TbmI7L/EpoUIms+VJjp1fN68FRkuEBVDdAoE=;
        b=wvkgsxKRsVTNVRxgSvNLAw/jF1vhHBkBPYj4lPveCVZDbZ/WxyVEKAQ34/MCKCXwIm
         r1TXpJh1cw1aqO2cMJSOFTpoBL5HngBxKynUtoozgCO07DKO8n+7Vw8z2s59aq4dWfok
         bEEdtrpFEeM60nMyAN1i+yTAxp0LnacmDH+Fpy1+h0LbWkftGX278h9jMYmZlCXGkqko
         kA1v4foM7pbxIH5YoQEsZ50D13Z/ldNpTCV7ixr/vJ3WZGRPKWDRnVaEYAuP6HT46AEh
         E+9AQ6IPjswt7+7xfTGuBGlnFzAorE2dyBYU6lBgv/DPBJjClGilnyvl8Pgu9NWkQxhJ
         gyJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9PxCu9dD6JYNPNUPzX/pGWJEphAiG07kZhifOTB1pVVeSLhTz8ZlcYjmSt5HaoLR8URc=@vger.kernel.org, AJvYcCXRW6FeqBO0qobuRQKpalqNcE2ohM2IAl8vAsKJYoGCCVzeU3+9K0dQh+I8TKUY4cEk5v0pzpV2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9yg+/9uOluI0vhdYLpSvLfN0PNlVxdngxhZh7k64Q9ORXNjpz
	7WHgxAq0BDAmZ5JEYcMz6jIztPjZKr7gEHZAGFU7cIXzeFlceuXLyLE9jpqGAvAnJNq5XoEz9Go
	F9WdnL9421YgLVGFVvY9KxlCDB4Q=
X-Gm-Gg: ASbGncu453R3zChhDmZzrHfcMqsSZJBG4Uh6RbHIg0c9XgrbWsb5EttWp2bCLPHFE4m
	BkHXIbrItYaxd1QSVkQdQVF+7rp5Ch678NUOItPm3uaVFo2EWaVyognoZXdMSbw==
X-Google-Smtp-Source: AGHT+IF0fIRl5JAauW8AaxXVfdBrAh1Zc8bWTiAU1KuP0oMQh5a6o89bdPwrUdM8H6CuyLKb4mxbBr6puPO0p7dj3cA=
X-Received: by 2002:a05:6e02:b24:b0:3ce:7ae7:a8bb with SMTP id
 e9e14a558f8ab-3cf743e9870mr236819795ab.6.1737767770843; Fri, 24 Jan 2025
 17:16:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250121012901.87763-1-kerneljasonxing@gmail.com>
 <20250121012901.87763-5-kerneljasonxing@gmail.com> <1c2f4735-bddb-4ce7-bd0a-5dbb31cb0c45@linux.dev>
In-Reply-To: <1c2f4735-bddb-4ce7-bd0a-5dbb31cb0c45@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 25 Jan 2025 09:15:34 +0800
X-Gm-Features: AWEUYZnNoHjzkO8G9sbJI1OV9WBf4n93TcmC3w7OLnS_AxUb2uN3cxfK10fwFE4
Message-ID: <CAL+tcoAXgeSNb3PNdqLxd1amryQ7FNT=8OQampZFL9LzdPmBrA@mail.gmail.com>
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

On Sat, Jan 25, 2025 at 8:28=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/20/25 5:28 PM, Jason Xing wrote:
> > In the next round, we will support the UDP proto for SO_TIMESTAMPING
> > bpf extension, so we need to ensure there is no safety problem, which
> > is ususally caused by UDP socket trying to access TCP fields.
> >
> > These approaches can be categorized into two groups:
> > 1. add TCP protocol check
> > 2. add sock op check
>
> Same as patch 3. The commit message needs adjustment. I would combine pat=
ch 3
> and patch 4 because ...

I wonder if you refer to "squashing" patch 4 into patch 3?

>
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   net/core/filter.c | 19 +++++++++++++++++--
> >   1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index fdd305b4cfbb..934431886876 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5523,6 +5523,11 @@ static int __bpf_setsockopt(struct sock *sk, int=
 level, int optname,
> >       return -EINVAL;
> >   }
> >
> > +static bool is_locked_tcp_sock_ops(struct bpf_sock_ops_kern *bpf_sock)
> > +{
> > +     return bpf_sock->op <=3D BPF_SOCK_OPS_WRITE_HDR_OPT_CB;
>
> More bike shedding...
>
> After sleeping on it again, I think it can just test the
> bpf_sock->allow_tcp_access instead.

Sorry, I don't think it can work for all the cases because:
1) please see BPF_SOCK_OPS_WRITE_HDR_OPT_CB/BPF_SOCK_OPS_HDR_OPT_LEN_CB,
if req exists, there is no allow_tcp_access initialization. Then
calling some function like bpf_sock_ops_setsockopt will be rejected
because allow_tcp_access is zero.
2) tcp_call_bpf() only set allow_tcp_access only when the socket is
fullsock. As far as I know, all the callers have the full stock for
now, but in the future it might not.

If we should use allow_tcp_access to test, then the following patch
should be folded into patch 3, right?
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 0e5b9a654254..9cd7d4446617 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -525,6 +525,7 @@ static void bpf_skops_hdr_opt_len(struct sock *sk,
struct sk_buff *skb,
                sock_ops.sk =3D sk;
        }

+       sock_ops.allow_tcp_access =3D 1;
        sock_ops.args[0] =3D bpf_skops_write_hdr_opt_arg0(skb, synack_type)=
;
        sock_ops.remaining_opt_len =3D *remaining;
        /* tcp_current_mss() does not pass a skb */


>
>
> > +}
> > +
> >   static int _bpf_setsockopt(struct sock *sk, int level, int optname,
> >                          char *optval, int optlen)
> >   {
> > @@ -5673,7 +5678,12 @@ static const struct bpf_func_proto bpf_sock_addr=
_getsockopt_proto =3D {
> >   BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_s=
ock,
> >          int, level, int, optname, char *, optval, int, optlen)
> >   {
> > -     return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optl=
en);
> > +     struct sock *sk =3D bpf_sock->sk;
> > +
> > +     if (is_locked_tcp_sock_ops(bpf_sock) && sk_fullsock(sk))
>
> afaict, the new timestamping callbacks still can do setsockopt and it is
> incorrect. It should be:
>
>         if (!bpf_sock->allow_tcp_access)
>                 return -EOPNOTSUPP;
>
> I recalled I have asked in v5 but it may be buried in the long thread, so=
 asking
> here again. Please add test(s) to check that the new timestamping callbac=
ks
> cannot call setsockopt and read/write to some of the tcp_sock fields thro=
ugh the
> bpf_sock_ops.
>
> > +             sock_owned_by_me(sk);
>
> Not needed and instead...

Sorry I don't get you here. What I was doing was letting non
timestamping callbacks be checked by the sock_owned_by_me() function.

If the callback belongs to timestamping, we will skip the check.

>
> > +
> > +     return __bpf_setsockopt(sk, level, optname, optval, optlen);
>
> keep the original _bpf_setsockopt().

Oh, I remembered we've already assumed/agreed the timestamping socket
must be full sock. I will use it.

>
> >   }
> >
> >   static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto =3D =
{
> > @@ -5759,6 +5769,7 @@ BPF_CALL_5(bpf_sock_ops_getsockopt, struct bpf_so=
ck_ops_kern *, bpf_sock,
> >          int, level, int, optname, char *, optval, int, optlen)
> >   {
> >       if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_TCP &&
> > +         bpf_sock->sk->sk_protocol =3D=3D IPPROTO_TCP &&
> >           optname >=3D TCP_BPF_SYN && optname <=3D TCP_BPF_SYN_MAC) {
>
> No need to allow getsockopt regardless what SOL_* it is asking. To keep i=
t
> simple, I would just disable both getsockopt and setsockopt for all SOL_*=
 for

Really? I'm shocked because the selftests in this series call
bpf_sock_ops_getsockopt() and bpf_sock_ops_setsockopt() in patch
[13/13]:
...
if (bpf_setsockopt(ctx, level, opt, &new, sizeof(new)))
...

> the new timestamping callbacks. Nothing is lost, the bpf prog can directl=
y read
> the sk.
>
> >               int ret, copy_len =3D 0;
> >               const u8 *start;
> > @@ -5800,7 +5811,8 @@ BPF_CALL_2(bpf_sock_ops_cb_flags_set, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       struct sock *sk =3D bpf_sock->sk;
> >       int val =3D argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
> >
> > -     if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk))
> > +     if (!IS_ENABLED(CONFIG_INET) || !sk_fullsock(sk) ||
> > +         sk->sk_protocol !=3D IPPROTO_TCP)
>
> Same here. It should disallow this "set" helper for the timestamping call=
backs
> which do not hold the lock.
>
> >               return -EINVAL;
> >
> >       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D val;
> > @@ -7609,6 +7621,9 @@ BPF_CALL_4(bpf_sock_ops_load_hdr_opt, struct bpf_=
sock_ops_kern *, bpf_sock,
> >       u8 search_kind, search_len, copy_len, magic_len;
> >       int ret;
> >
> > +     if (!is_locked_tcp_sock_ops(bpf_sock))
> > +             return -EOPNOTSUPP;
>
> This is correct, just change it to "!bpf_sock->allow_tcp_access".
>
> All the above changed helpers should use the same test and the same retur=
n handling.
>
> > +
> >       /* 2 byte is the minimal option len except TCPOPT_NOP and
> >        * TCPOPT_EOL which are useless for the bpf prog to learn
> >        * and this helper disallow loading them also.
>

