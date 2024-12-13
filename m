Return-Path: <bpf+bounces-46854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2169F0ECE
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 15:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC3D16531E
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 14:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0221E22E8;
	Fri, 13 Dec 2024 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8n+xpG2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9443E1E04BA;
	Fri, 13 Dec 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734099203; cv=none; b=ge2FvfSiuVRmrghdS9FPT89arv/bpRmhlGsHmjAVIDLXulgr/U+PFzqiSLPwkqiEe9tte0oH48+AVKo1Nx2WF8m1Vdr0iQnRpMdfN4+x0vLbH47jiyoXwmpWivrODntLv+xgWTlT8K24M4EbjiFj2+P9QCVka3/KQimfwttfpjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734099203; c=relaxed/simple;
	bh=zWn2IZLTbvL+8YKZbzgareUkxM2q6bV7ucJj0MTfLaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVlBCFohU5LHvnvb+bcjH3E9ipP14Snt5fI46TWDm9QHcyBcAjP267UZKuCEo8SFNwFemOgatqbCyHWGyudnL1XxQPgmKV6mkkxBx4qXSuZcxScDx/mUJKrrsXQpfBwEx+uv8P82exoY+/CBu6bmirzNj/YuiU4CFvuOxFwNt0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8n+xpG2; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a7d7c1b190so6192435ab.3;
        Fri, 13 Dec 2024 06:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734099201; x=1734704001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1lwWXj0GpqnduKP+wpddkSnCxIqeOeyd8ONBWEKbeo=;
        b=k8n+xpG22d1CDrvrDkqJNP8ZgBaK8XrEZz9xURu83ijQSqJfWWJg7oABb+BXRJOA+H
         k7pyYm6LFxQ3QJWvNdijYt2Q1cRXnhg1ES78bheLlwW3Cx8hiOk03Bgp/bRRpDYy13f4
         epUPUHsvlrd6C3ZyEmeiUO/h4RTEYuh59GD++oRv+4NYf+2snfOeitFgaABAuI6Kizw2
         hYsFmk7wDipsRJSXoQz9KOodYiWDrsvTmee/ao5nnibj1n3ZwfttOGPcH/WWGbQ+ADYg
         Zzup1Z0hsEwf7GmbLkVk6BbnspG3emALHczWNwa53E9pM2DHDvhXQTt69+Mjidhq0N7y
         el/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734099201; x=1734704001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1lwWXj0GpqnduKP+wpddkSnCxIqeOeyd8ONBWEKbeo=;
        b=QbsZW2vPyVCwxnEHUf5Ss8FUrmnHyVaUbxPfnVr7ZR/23zZmqyW5wJ1fCdKiQSPcwc
         VaBFXhxVe3kUf0i55XFzDnx5MUk38cI9D1jD5ATq/bMQL2d5IvBaWlxsBbpo6SH9Izia
         V5x1S1/WgY51fjdPS9/zzhUB1JZyOM40R1xDyMXJxuKveSqSqyQLGCZ+shkG7qM2lhbE
         /CMuwpBeXtuiiahp77k/klh6VwsMALC06cpFyiQZWe/2JDh5y6holDc+5g/kC0Hudzjw
         FzccYv3NMqUPAzmC+CwGpw7DKx3E9hnf1AvPmUl9x3/+QgL+V6jcFN+jrBOobclBj8Es
         M9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXD2kCxOWhEGkk142uHUEbnw8VOwUMd5lGaS77SJnx1KouG9G1zEZmX47N3mXPb3NqscmvWnh7U@vger.kernel.org, AJvYcCXYY4EupWpHbHY3PAloOzELVv3ySbTp4YzyVqOrcmtg3GAK86lJCJoPCiKTdxB5yz2Q14A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI38nwEfVrAjGc8ydTkxKKNirnKwoN1jHwVIIm9yGnn1Y6CuBl
	bRT+EJrCTR1G6jvM7fJxNSlxCYPl1zKTSeVuZKJwharjdyXtez5dxJZof/fqK47c7z3SXAW4BsI
	2Gce04S0DGrMDJ4M5LNDWpJZaptg=
X-Gm-Gg: ASbGncuqNUWwtLjErSrW84sf5cqbiZHyj2Wuw63gFPN++Qk1X4ayJvpBYDrCOlSvLZ6
	u+kN96qFYwZ1DYT0PEiWCvsoh5hIzOrGpkF+oYA==
X-Google-Smtp-Source: AGHT+IEw/fbnUZH+Gy+WnWvqFXZ1yJ+ThzxHi1BD+IJFQy2xOnxzkyF+aqfPk4+jrHHZTASt/Li9+Cloqh8rJg9iycA=
X-Received: by 2002:a05:6e02:1948:b0:3a7:9533:c3ac with SMTP id
 e9e14a558f8ab-3aff461aa6dmr24048955ab.4.1734099200688; Fri, 13 Dec 2024
 06:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207173803.90744-1-kerneljasonxing@gmail.com>
 <20241207173803.90744-2-kerneljasonxing@gmail.com> <8a464155-3115-468b-88f3-5ee81d9e3b84@linux.dev>
In-Reply-To: <8a464155-3115-468b-88f3-5ee81d9e3b84@linux.dev>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 13 Dec 2024 22:12:44 +0800
Message-ID: <CAL+tcoA1omzkK=odvcjtt-LtstRB9Dx3MVLC+yezqOp+M1sqsA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/11] net-timestamp: add support for bpf_setsockopt()
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com, 
	willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 3:35=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 12/7/24 9:37 AM, Jason Xing wrote:
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 6625b3f563a4..f7e9f88e09b1 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5214,6 +5214,24 @@ static const struct bpf_func_proto bpf_get_socke=
t_uid_proto =3D {
> >       .arg1_type      =3D ARG_PTR_TO_CTX,
> >   };
> >
> > +static int sk_bpf_set_cb_flags(struct sock *sk, sockptr_t optval, bool=
 getopt)
>
> It is confusing to take a sockptr_t argument. It is called by the kernel =
bpf
> prog only. It must be from the kernel memory. Directly pass the "int
> sk_bpf_cb_flags" as the argument.

Thanks. I will fix this.

>
> > +{
> > +     int sk_bpf_cb_flags;
> > +
> > +     if (getopt)
> > +             return -EINVAL;
> > +
> > +     if (copy_from_sockptr(&sk_bpf_cb_flags, optval, sizeof(sk_bpf_cb_=
flags)))
>
> It is an unnecessary copy. Directly use the "int sk_bpf_cb_flags" arg ins=
tead.
>
> > +             return -EFAULT;
>
> This should never happen.
>
> > +
> > +     if (sk_bpf_cb_flags & ~SK_BPF_CB_MASK)
> > +             return -EINVAL;
> > +
> > +     sk->sk_bpf_cb_flags =3D sk_bpf_cb_flags;
> > +
> > +     return 0;
> > +}
> > +
> >   static int sol_socket_sockopt(struct sock *sk, int optname,
> >                             char *optval, int *optlen,
> >                             bool getopt)
> > @@ -5230,6 +5248,7 @@ static int sol_socket_sockopt(struct sock *sk, in=
t optname,
> >       case SO_MAX_PACING_RATE:
> >       case SO_BINDTOIFINDEX:
> >       case SO_TXREHASH:
> > +     case SK_BPF_CB_FLAGS:
> >               if (*optlen !=3D sizeof(int))
> >                       return -EINVAL;
> >               break;
> > @@ -5239,6 +5258,9 @@ static int sol_socket_sockopt(struct sock *sk, in=
t optname,
> >               return -EINVAL;
> >       }
> >
> > +     if (optname =3D=3D SK_BPF_CB_FLAGS)
> > +             return sk_bpf_set_cb_flags(sk, KERNEL_SOCKPTR(optval), ge=
topt);
> > +
> >       if (getopt) {
> >               if (optname =3D=3D SO_BINDTODEVICE)
> >                       return -EINVAL;

