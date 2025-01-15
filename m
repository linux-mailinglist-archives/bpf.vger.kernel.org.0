Return-Path: <bpf+bounces-48999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751C7A12F3C
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 00:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B1B8164CD0
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA4A1DDA18;
	Wed, 15 Jan 2025 23:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHWzKf6T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1071A1D89F1;
	Wed, 15 Jan 2025 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983635; cv=none; b=UkI3IkycLm7ur3I/44e98bU4vBhz1vHQstXDDVbGgBUT8amwIDLBreasc+hI48sjvC4tuLRJl1wwgfYDQudrdjShhaRqMEXAKIJuznI/cocqOWffrPEZYyNu/imbhHCgvyHp3kHJ+pUSC61E3gJyqwmYg0FmZa+XsZneM98TX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983635; c=relaxed/simple;
	bh=BlWi5FLNGDxjA5f19jRqU2mVmFkmhJpmGWkJhhLSdgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bQRiyceo4oGZTI/mVrc8zVqpte6TpwCUqop4cp7yYORcb7Me0jhLSt0sQ3DVQPQB6NMBUn70v3Zku3lfxhDNlrxubcD9viR6Q+J7qPyjDN3eka2XE08C1SrmyZD6sjDpjnWNXnsP268aluNDqlwRB176pEhp6QviOV5v5v3w0G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHWzKf6T; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-84cdb6fba9bso27269139f.2;
        Wed, 15 Jan 2025 15:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736983633; x=1737588433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtDrgUIV95SNBzLRkAPXxXIPkF5yNqah3IU5TVyFHU0=;
        b=IHWzKf6T5w94M1DN2jcK395QWNTK9jqShFlTZR/ZR3+SeCso8eB5B2JYxIWrQ0XKBd
         0mAgka9Q4No1pSckA866YINWJ+FGgj1piY+5b1dvEdEq+4wfLSsq+tx/TYsD1EIS2rma
         rFG3iCPe69x5sFF5UlIF1k7Mqg/aBzva+s7hpQYbmbW1YWaftO4Rva21WNB8HyGBTz5S
         2q3SqgtdOvD/K4VJ9Hn5J2cPG9YxYpq1l9FhGY81L+Ty9OFvPSx2hOOXD+8tXWGYurcB
         h5Josk0Yn1H7cptrb5Pk28ut1cdI6IMD1E8LFkgJuPIIzTFpvBMl2JXP+hRXPD6OoDt1
         zd0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736983633; x=1737588433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtDrgUIV95SNBzLRkAPXxXIPkF5yNqah3IU5TVyFHU0=;
        b=piSCOuH9mcniaXYWcu2Dcmf7qJhQ9GGjoBHsiIOE+EHZtRFcqjrK22dhm8ZdM49GTB
         TtDyJ8bf9hE1LYq/I1/Uz4Sjc2oVwU1P7DFEGLOEtdyuy8z1KSeFIjiMkma99Gmag4T0
         1xmdfiQe1H76d1mkMkdzPmvIumNmUDAf6umwR3taSyLVaOpZ00zYPH9O4n2op5uznhVb
         xwbnzlzIviTXl0L5Ov6yK9iD31aZdpmb0GyY8Y2jGgj5lQOiT606q7uBLdkU2OJJPWmQ
         Q5pBGX+fkMkpRSGEF4vpLQb0wIKg2YgS9tpoAcaFti3jVq5w4QzN7YJBDQhNJEXea4to
         dsOw==
X-Forwarded-Encrypted: i=1; AJvYcCW3yXVgTLsBmqGm5LZFLdhzBdClT4q07aUGJ6dfJP6KheXttggHWRhgbbbWeEs1sTRzC+ZyA4yQ@vger.kernel.org, AJvYcCXQTyL+cJLKIVhO+QXbPKxK11Eqm06mcn7TqDe79hO1KnKlktDlXFYtVLTv2oL29YE5Qz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkQHgN1SxmHFk4kMYrcwu8Qw4JQ6xlv02ua9SE/8q33zEFLBZ
	6stkPdJS+Ezvt3OLNqW6g/VH+JwUixBGhxN7tVaMbymntPF1F6JLZI0XBkz3OEtfEAgOVcr9HMb
	DewJpMpE/Q2l9UU3a+hHjKLyy7MM=
X-Gm-Gg: ASbGncseprfSw8RykSEiDjH9V99F0GXc8MvIssc03h9qN1Lbmv40wLa5hqq/GNsXIFJ
	aXgMWNxIHs0sB1Ac7eqLdZ9QKZQg3Lxott+RD
X-Google-Smtp-Source: AGHT+IGnNgamkfZNs9F/m//pjRWczuyni5KeSU7GTILINta2cKYjkrR8+Bm27d7cP7xdyfhOPhuQkUaFSC6FKZ0oe4k=
X-Received: by 2002:a05:6e02:d54:b0:3ce:67ae:48f2 with SMTP id
 e9e14a558f8ab-3ce67ae4b01mr125954945ab.15.1736983633163; Wed, 15 Jan 2025
 15:27:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250112113748.73504-1-kerneljasonxing@gmail.com>
 <20250112113748.73504-5-kerneljasonxing@gmail.com> <80309f62-0900-4946-bb2c-d73a2b724739@linux.dev>
In-Reply-To: <80309f62-0900-4946-bb2c-d73a2b724739@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jan 2025 07:26:37 +0800
X-Gm-Features: AbW1kvZb-bIIF_qxaO1VEW8lo7xwRRdVhNwa5yJQLuJAXUytEbJ8oXh6cJE1OQ4
Message-ID: <CAL+tcoCd_RXno2uKi1bZoz5m1D3fGXKxPX0NC4tbpExwW49R3A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 04/15] net-timestamp: support SK_BPF_CB_FLAGS
 only in bpf_sock_ops_setsockopt
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

On Thu, Jan 16, 2025 at 5:22=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 1/12/25 3:37 AM, Jason Xing wrote:
> > We will allow both TCP and UDP sockets to use this helper to
> > enable this feature. So let SK_BPF_CB_FLAGS pass the check:
> > 1. skip is_fullsock check
> > 2. skip owned by me check
> >
> > Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
> > ---
> >   net/core/filter.c | 27 +++++++++++++++++++++------
> >   1 file changed, 21 insertions(+), 6 deletions(-)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 1ac996ec5e0f..0e915268db5f 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5507,12 +5507,9 @@ static int sol_ipv6_sockopt(struct sock *sk, int=
 optname,
> >                                             KERNEL_SOCKPTR(optval), *op=
tlen);
> >   }
> >
> > -static int __bpf_setsockopt(struct sock *sk, int level, int optname,
> > -                         char *optval, int optlen)
> > +static int ___bpf_setsockopt(struct sock *sk, int level, int optname,
> > +                          char *optval, int optlen)
> >   {
> > -     if (!sk_fullsock(sk))
> > -             return -EINVAL;
> > -
> >       if (level =3D=3D SOL_SOCKET)
> >               return sol_socket_sockopt(sk, optname, optval, &optlen, f=
alse);
> >       else if (IS_ENABLED(CONFIG_INET) && level =3D=3D SOL_IP)
> > @@ -5525,6 +5522,15 @@ static int __bpf_setsockopt(struct sock *sk, int=
 level, int optname,
> >       return -EINVAL;
> >   }
> >
> > +static int __bpf_setsockopt(struct sock *sk, int level, int optname,
> > +                         char *optval, int optlen)
> > +{
> > +     if (!sk_fullsock(sk))
> > +             return -EINVAL;
> > +
> > +     return ___bpf_setsockopt(sk, level, optname, optval, optlen);
> > +}
> > +
> >   static int _bpf_setsockopt(struct sock *sk, int level, int optname,
> >                          char *optval, int optlen)
> >   {
> > @@ -5675,7 +5681,16 @@ static const struct bpf_func_proto bpf_sock_addr=
_getsockopt_proto =3D {
> >   BPF_CALL_5(bpf_sock_ops_setsockopt, struct bpf_sock_ops_kern *, bpf_s=
ock,
> >          int, level, int, optname, char *, optval, int, optlen)
> >   {
> > -     return _bpf_setsockopt(bpf_sock->sk, level, optname, optval, optl=
en);
> > +     struct sock *sk =3D bpf_sock->sk;
> > +
> > +     if (optname !=3D SK_BPF_CB_FLAGS) {
> > +             if (sk_fullsock(sk))
> > +                     sock_owned_by_me(sk);
> > +             else if (optname !=3D SK_BPF_CB_FLAGS)
>
> This is redundant considering the outer "if" has the same check.
>
> Regardless, "optname !=3D SK_BPF_CB_FLAGS" is not the right check. The ne=
w
> callback (e.g. BPF_SOCK_OPS_TS_SCHED_OPT_CB) can still call
> bpf_setsockopt(TCP_*) which will be broken without a lock.
>
> It needs to check for bpf_sock->op. I saw patch 5 has the bpf_sock->op ch=
eck but
> that check is also incorrect. I will comment in there together.

Thanks. Will correct them soon.

>
> > +                     return -EINVAL;
> > +     }
> > +
> > +     return ___bpf_setsockopt(sk, level, optname, optval, optlen);
> >   }
> >
> >   static const struct bpf_func_proto bpf_sock_ops_setsockopt_proto =3D =
{
>

