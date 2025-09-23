Return-Path: <bpf+bounces-69308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869A5B93D5A
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C9C442183
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E7F234963;
	Tue, 23 Sep 2025 01:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhIkwzcx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106052153C1
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758590808; cv=none; b=oGS8Ao235P6nr1ek+07M2doM4YCG7DeQHayH59Om3aDv/AF0ZOfQIDKKIxyilO7+RHmNW6/hBmlV0xaZfdbgh/e3uP/iyhhiowJe7dv4DHpX6jSjdDkIt1ZYJpBKSU7TR2LnO9LgNzngwAZyAvXC7BDpHIYLLkYu5EHiFy8wIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758590808; c=relaxed/simple;
	bh=dCD2y8Kss29LTF1G7u8h8qxVQPiTY1vvsH2bIj6Npa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J42m0aX8GCryKFa81OU5rwsRbQss5an28A5VcbNQKJ64xv7nxvleiCDc0zmHwgylM5qw4vfFlE6qDgNjCKOBrWiezey6t6ZMuZzuANER3mZ6DbKP/RzAQGadt4RcyyW62WDv8zlTuXewkeh41Zgrsb1N6Nw376h7FBBad8Nj5Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhIkwzcx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b556284db11so153592a12.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758590805; x=1759195605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISpOOB0/l1DAWofm5fktjmzhE+vFFaPgdP7ZYeFC00Y=;
        b=rhIkwzcxj0VQlp5CpKFdQo3AIRUs08eahvgKWXvCMcHOjUyk6LPQNBJ6lEAtWvXBfA
         BKmk6YWTzUkaLe+FlUmrew3dpkx/SdLnEqI42qL4vs8TGOih3jdLl3j8ceDq994DFNqP
         7rBMRlragsnC4vxTUaUjr9UEjrYPVGBu5yj+d4uUoTfCLGOXFnwmVPoY+FllG6Sr1zZM
         ZUBDygy+hMVzGjIoyQMPScsgqy3vADkdOyjNSp3JKvdCnp4s02mbSDCQppuDHO06XuOx
         goDONIYPKY+WENkc9urBNzno+7li6SEomsBiXKpE5qtm3TR6XQ1gQJym2tyAcKMiVrin
         b+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758590805; x=1759195605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISpOOB0/l1DAWofm5fktjmzhE+vFFaPgdP7ZYeFC00Y=;
        b=TX6jeEvCXksIbUIrEIDaAgQIxOdSpQYGXlXxXbWJQQBGtAszq/5GLlEITIQ5Y6CjnV
         4BjicnyDm4td4PNTq1p0Hqd4Q/8F6DeI+Y1/2dztXLa6fTgvfnnhK3SLnktFJU+hj+Mr
         MvffAP3Gt4tuOhjgwEqL4JG5V5Wof2DvyLziPmHs+cb42T6HjQx5KQ7vHikx4sCujlGz
         XXSYu4cXdJzHM6xgLRaijIqBvRnJZf3DVKOtTLhfEQalGQtThmIzxI3RL1k/3ItkwgDW
         y0uNMyiqVJt/FKE3PRZFAEF3l5HHcbtY4gxW539SYeuG/78u/6EeCTT2TNM8pMXXFL/h
         e1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEV80nmLxCU31ZlAbKO/uWWDTW758a1EZBMhdL5aEl2ZxDsIoXyJ06svEO0rJSIvQOZbc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ii4Zy2n93L/PbhF/+sVs1vLCdCecGfx6+mv1bLvpH2dpUSHS
	HMKGCyLlvRZraEgQZrUxTN0tPJYwQTmdmOjAx86mXICdyeVfaVpc5zGBg00naAqFF4rRA2YUSDU
	mhvnHIfTN/l92kAhhKxhP0XuX2r/ENyPP3LC1n//H
X-Gm-Gg: ASbGnctLb01y+yVXyxe+iD/Wb5jQqYAMNPiZ1UWVmQDbEo2OF7OaWogTQY5psb/nIyE
	JhcQpdDcer5bdTjszoh/z2GYTQuLLkxX25/HCuyH+/G8Xmqr06riB2SXgcnG7w5wD0DXHoJ99TZ
	gzAOjO2BWobopWLIHv0kz7GbW2F86tDRGrvYbmm3O+zBb1OWng01oqTL3cL5uK86M3IEW6mLnmC
	iT4QzNBhAq9G3fREGNdOOjWg2uAVrWk6UZOMuH+5HJuGfAhvSg=
X-Google-Smtp-Source: AGHT+IH8We4aa6A1R60oPOHiyTQjJ6+7Np229xRD678dB0KwKZjs/Y+tueOLGbVz/vFv5eM0cJOwwMwsk6STQprEpqA=
X-Received: by 2002:a17:902:da84:b0:26c:2e56:ec27 with SMTP id
 d9443c01a7336-27cc20ffc29mr9429885ad.19.1758590805122; Mon, 22 Sep 2025
 18:26:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com> <20250920000751.2091731-4-kuniyu@google.com>
 <pmti7ebtl7zfom5ndqcvpdwjxlkrvmly2ol64llabcwfk7bdg2@mc3pigkg2ppq> <CAAVpQUBZSK6ptrRgruj0BGXBqDUOu3MKYKfD9FkWFn55OduwOw@mail.gmail.com>
In-Reply-To: <CAAVpQUBZSK6ptrRgruj0BGXBqDUOu3MKYKfD9FkWFn55OduwOw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 18:26:33 -0700
X-Gm-Features: AS18NWBPGjKPjLNlAh9my6zm9bVl-xQHVzTgkDrB6wJ1tjl_Scrt3a9mHUnweWI
Message-ID: <CAAVpQUA+6BQhCt01AgEnST3=K46jbeRpPvYMrk_Fu8OhtHrP7A@mail.gmail.com>
Subject: Re: [PATCH v10 bpf-next/net 3/6] net-memcg: Introduce
 net.core.memcg_exclusive sysctl.
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:03=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Mon, Sep 22, 2025 at 5:54=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.=
dev> wrote:
> >
> > On Sat, Sep 20, 2025 at 12:07:17AM +0000, Kuniyuki Iwashima wrote:
> > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > index 814966309b0e..348e599c3fbc 100644
> > > --- a/net/core/sock.c
> > > +++ b/net/core/sock.c
> > > @@ -2519,6 +2519,7 @@ struct sock *sk_clone_lock(const struct sock *s=
k, const gfp_t priority)
> > >  #ifdef CONFIG_MEMCG
> > >       /* sk->sk_memcg will be populated at accept() time */
> > >       newsk->sk_memcg =3D NULL;
> > > +     mem_cgroup_sk_set_flags(newsk, mem_cgroup_sk_get_flags(sk));
> >
> > Why do you need to set the flag here? Will doing in __inet_accept only
> > be too late i.e. protocol accounting would have happened?

Oh no, this is because I used newsk in __inet_accept(), and
we can use sock->sk in __inet_accept() and remove the inheritance
in sk_clone_lock() like this,

flags =3D mem_cgroup_sk_get_flags(sock->sk);

but I think using newsk reduces one cache miss.  Also, we touch the
parent sk_memcg during sock_copy() in sk_clone_lock().

