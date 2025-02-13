Return-Path: <bpf+bounces-51343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96869A335FB
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 04:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436A1166C7F
	for <lists+bpf@lfdr.de>; Thu, 13 Feb 2025 03:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D28204C27;
	Thu, 13 Feb 2025 03:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKKzWGgE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B9C38F83;
	Thu, 13 Feb 2025 03:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739416524; cv=none; b=Ep6cwzWSGTYLf/JxiQRFnwgEQzQoKAoKTip/RO5/TirbwOPg5lqFq5gDzzl6F89CLI4im+C6Q/M4bKGOLoC8hh5Wm1zw1ZmOKColMo7NWVxjLddI/SZ+SCudrLxKnf55W4cDQJkcNRBOAxFMtiG53/kiSyWnzZBJY8aB/+CSNYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739416524; c=relaxed/simple;
	bh=29qMRQN1MA426/zGCgS2bSS8TuL+QzLv8CgXd09oYg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWPHto51iiB2r9DewCpfb+73xwkhxlVIWcK76Fger8H+tfHF5O85uj6nyqwiEvnukW7Hd0+xM1iMYpG17UhNfutdm4o6SlYFkwelFLptq/bT9n85tfKiN7Gyf3+NtSY453xeU/Q58vBJ4kr/7uTiWVcqpZLPIvtrfY5IgmNNARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKKzWGgE; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3cf880d90bdso1184215ab.3;
        Wed, 12 Feb 2025 19:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739416522; x=1740021322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3meNdx9mzPMuDDowoj6tZvUq/9zyqr9CaT+/L4OE29U=;
        b=GKKzWGgEkOPGuYsfaf9cTMJu9F2CAsVIz40+U3/jOXcQUR4R4PfLPvVd7t5kYtlTmH
         1TUACsNH/M/CXHGNZNk3wkUt5lVjxbjJpBm8hA8+geewPETRpRAaC29OjIBnWH/phX4P
         L6Yym26Bg3FnJJjvCivr+GFPjytVnKqClIje7bdOgqGDpGjxfGyWgRe26IW0POcFKB9b
         i/P+9YrIvLyIOh+7aprTzSHqiRDXs3bm43aWdgRaJ7rZKFvUPKKNKfnFp85lgEYp6mOk
         LbkoHUiCkKjqFwzp0Nbm63GRx3/WWvufOqy/3NEWBnfKL4n7zvfgsJmPw6ksN+OEZJIb
         jDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739416522; x=1740021322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3meNdx9mzPMuDDowoj6tZvUq/9zyqr9CaT+/L4OE29U=;
        b=clRRGYxBMycKW2nBiHkuGE+4OMOUeK1hBDB6xw7hd7oNCsNT97ov1CpyQfKrXeZscG
         seGOo53y3vOw675oENHMQjPikxvyYrOSIYcVi21c7/5zMRIlh0bCdXXxhuBCkDoZR4U3
         jM196yKUKTr4JbXiQWxag3iDD1fSEy9/XT811wNYHCgHsVUPY4IrHAJHHMqgNXS4l0HU
         Vc5KzJF02MmLGYTcaJt1PKXoEJHOp2cFPWfVoaYWIzI2skD+gk4+9omCrzsAnt4ijOGI
         4kgxnP67eDSeK3k7fj/ltajKU9hG9EuzvLQWcqaHs1GeKuR4npdYARYFXxqs6vKiiI8q
         fUSA==
X-Forwarded-Encrypted: i=1; AJvYcCW+6Bs3sSkrhgKtgcp5+TzbR+AEefl09wQjmxDmziEHAS/bF9XzntqY6WzhQdK5WuG5ges=@vger.kernel.org, AJvYcCX+FotlsLO9VxAEKFHOpLtUVt5MSMMQoBPYs7mBb3qjBj9KRfHcMuLeSfakmnEyOFablJEwvDv/@vger.kernel.org
X-Gm-Message-State: AOJu0YyrbXfqAsl2i91jXdAkRoYcJ7/VHj+Hb+Umzy3QC9bTDi/IOx7E
	BN0k+Q+Z492XNM3GKgNuI7wRZZozldfxj3E7//ZVHSG6gH2nJ9F7BOoEQU0odpN0wE3LSZMLK0E
	zzVk16xpmBwoahbBRcyBZ2l6NmFM=
X-Gm-Gg: ASbGncs/gbmc8jfqy4cz6ehtb/I/L1UbvdC7IJTsgnaBGlUzlpV5qdV0bx1pG34kYMZ
	cOI0SDRj1F2V5CXukudgVp8P8j1DQdcPQm3r1i9/vrkpSBWsq7xl31r2q4pIHvW5ARpwY84wz
X-Google-Smtp-Source: AGHT+IHeNXbj+21QyxNvJah3zZO+sdDUmynRSaSGeRpVaA26DK0D/T21UBXeGAVBN59zXZw8uMI0LN/4AgjQ1KuqF2I=
X-Received: by 2002:a05:6e02:1ca4:b0:3cf:bc71:94ee with SMTP id
 e9e14a558f8ab-3d17bfe4532mr43466535ab.14.1739416521995; Wed, 12 Feb 2025
 19:15:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213022501.76123-1-kuniyu@amazon.com> <20250213023214.76562-1-kuniyu@amazon.com>
In-Reply-To: <20250213023214.76562-1-kuniyu@amazon.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 11:14:45 +0800
X-Gm-Features: AWEUYZkiO_7hY5YZDq-TBbPyxt_0ed3JKmu8S8CBliyMl4VF2Y5LFu0aVrNtxCw
Message-ID: <CAL+tcoDKxNbhLTtL7i4WNGzEJxB1h1rAvYvmSvapnZjmdO=QuQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] bpf: add TCP_BPF_RTO_MAX for bpf_setsockopt
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org, 
	eddyz87@gmail.com, edumazet@google.com, haoluo@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	kuba@kernel.org, martin.lau@linux.dev, ncardwell@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, sdf@fomichev.me, song@kernel.org, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 10:32=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Kuniyuki Iwashima <kuniyu@amazon.com>
> Date: Thu, 13 Feb 2025 11:25:01 +0900
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 2ec162dd83c4..a21a147e0a86 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -5303,6 +5303,12 @@ static int bpf_sol_tcp_setsockopt(struct sock =
*sk, int optname,
> > >                     return -EINVAL;
> > >             tp->bpf_sock_ops_cb_flags =3D val;
> > >             break;
> > > +   case TCP_BPF_RTO_MAX:
> > > +           if (val > TCP_RTO_MAX_SEC * MSEC_PER_SEC ||
> > > +               val < TCP_RTO_MAX_MIN_SEC * MSEC_PER_SEC)
> > > +                   return -EINVAL;
> > > +           inet_csk(sk)->icsk_rto_max =3D msecs_to_jiffies(val);
> > > +           break;
> > >     default:
> > >             return -EINVAL;
> > >     }
> >
> > You need not define TCP_BPF_RTO_MAX because TCP_RTO_MAX is not a
> > BPF specific option, and you can just reuse do_tcp_setsockopt(),
> > then bpf_getsockopt() also works.
> >
> > ---8<---
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 2ec162dd83c4..77732f10097c 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5382,6 +5382,7 @@ static int sol_tcp_sockopt(struct sock *sk, int o=
ptname,
> >       case TCP_USER_TIMEOUT:
> >       case TCP_NOTSENT_LOWAT:
> >       case TCP_SAVE_SYN:
> > +     case TCP_RTO_MAX:
>
> s/TCP_RTO_MAX/TCP_RTO_MAX_MS/ :)

Thanks for spotting this simpler approach. It works.

Thanks,
Jason

>
>
> >               if (*optlen !=3D sizeof(int))
> >                       return -EINVAL;
> >               break;
> > ---8<---

