Return-Path: <bpf+bounces-67222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889AEB40E65
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 22:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D9BF1B26ADE
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 20:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0709352099;
	Tue,  2 Sep 2025 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="awkemBfs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251C234F491
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844024; cv=none; b=VOBpXEs0uUEFnwq9YX0RN1drNP0NzfXI0sP9xH4T9uACJ8bNFXYSydiTyZogIYWc8PQJDLQ+KsQ/8KM/dS2ZeMIamtVN2igPZ2a81m7fuEGQTIgOif0OpwQSz8TVYWyhEE9q3KuSdk268RMwkUiwCVUJ/w7xmZPk5v5j/KEUya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844024; c=relaxed/simple;
	bh=JFMvSJKmvouio1S2V97JFSH+oyA42x64UOXLlbXqEEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iEnihBRqbuctNdMDk83EEyPdBMrgwOxA8oJvEE6e+etyZPWpJQQEi0A+pXPzzxqpyWF0YUSqC1DUvfKCSACPff4FKkDlm7LnYOo42lw03aLe5+vo54Fvum7z9Z0OnWmurDs071/OFBx232J/G/zbsdqbRMSoj8oeIexQWQ0Nduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=awkemBfs; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2445806df50so44731445ad.1
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756844022; x=1757448822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50VELORRmga2bsXVhAB0RUkFgMEc1EdgXr2M5pQzE2g=;
        b=awkemBfsfN0VFbiLtFC+o/J8zasnNGTzshHEw6q4JseloTHCSJ1dhvHTwMlXJzjpEa
         t5BiBEip1GFFImF8C5FAEgED82t8k/zKuje0TU39gnCEAFnQBz6raLMkwRExjCdoc+2Q
         VUtGtNnWYqtdhQG2CReU6KixRjBd3sfriqZ0ZNzifXMj4/puSqmP0B1IhTpwkVXVUFWD
         aHvqmik500vHG3U6Y7UUFE1AOJwnuqkdqHmmP6G1XFmHDvDDklZuqFLwSaV+PS13SENr
         99Yq7r1hqJjRxejE2TqbMMgWpv1HMAFnFLZVDZXBsTrqYFaxsapZJsrcHeECF+bkRctV
         F40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756844022; x=1757448822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50VELORRmga2bsXVhAB0RUkFgMEc1EdgXr2M5pQzE2g=;
        b=R1f630RgKvO++noAv2k8Ad8yDRKpo3/GkHt8hy1VRxCIsYUMbH8uEpUHJbvgWsVZHa
         Thkj9WFBR1+KUp/W6IH8aqgaJ2TED11CSrhEDdL7LGV041CBPytH8yZPuxmI0VmboOfS
         A2Pn4TlMzMKonrhu5s5//VC3QKs45uZxdYs6XArWPofo5k1rf37mH89yHNd8PX2mtHhP
         39v+t96lj7pdHdutgDevV3yi2AbsalWLvreieBBHd9kY2MMU5fS49g/Oc2sxIXg8Dcwb
         /wn82QUve5ieJBTtyweXOlgquCViyLP6nqmFh42/XN7wK30i2QbxSdf3+HjRdGvOaMan
         fYPg==
X-Forwarded-Encrypted: i=1; AJvYcCVa3FNVpaWTXigzkikEWHpNkg9apjCLAlC8BnFqJytrHX4egO0CxoImH8TnrsLAhWUqzXk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwyte8V631HHzvz7Su2tP+nhi5bzumvviPSfV7I5kc0vZmvcna
	JHrgmYfOJzUimded1y3BD+0o2C7rnUQaEGAUldvAoEiKZpeGjEkqHWMRVqJWfxGC7UWHr84XEJm
	SurOxOj/L2c1hnOqx05h8MavZ2KZqgPSkNSvCdhvo
X-Gm-Gg: ASbGnctbr3a5yYhabSrH5zZxnXNk5OhliCugLhWidLTTKsL3c7fsn7GmY9cSAA/Lzgr
	p4vELf4ytJ2LOvJRcv/97shGLl7+Ngwlt6yixgR0xJMBEqOJYjdii9hp1HiL9cZGakLfRj395VE
	+gclSO9PZ2QoOumFliO1WqjtOK6nwwCwf329zlU6ZGSTMz8lNys98cLfUCAQv6qnskgLdNsFahM
	vHYsCXjn+s5qJcnTdonLI+yNpyFhOsy/1V8ej1ms5WOEgJPN0NUMFCh6znKlsgi3uRhyA4RnCVx
	ng==
X-Google-Smtp-Source: AGHT+IF6Y+YbRwdDNXA1bFyeAXeEuQC7HJrV+I2THNQbBrLvAc/L/26mNWWGOWWKIr9NUWSQRYEgoem3+7Hig+8uuAY=
X-Received: by 2002:a17:903:388c:b0:249:33db:34b with SMTP id
 d9443c01a7336-24944b3fa5amr148255155ad.42.1756844022235; Tue, 02 Sep 2025
 13:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010026.347440-1-kuniyu@google.com> <20250829010026.347440-4-kuniyu@google.com>
 <e4d9f89b-03cb-47ee-bc71-acea080a84e2@linux.dev>
In-Reply-To: <e4d9f89b-03cb-47ee-bc71-acea080a84e2@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 2 Sep 2025 13:13:29 -0700
X-Gm-Features: Ac12FXxtUQxxFtFmkPSCPQp4CvvTcDOidnP1dpNPOA3b9fp5cg1RUDv7hT43kkM
Message-ID: <CAAVpQUDsBUcn+0ZB2Da4ymNGhvWU2=HoVumPQvsw97AhREWsRg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next/net 3/5] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Mina Almasry <almasrymina@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 1:02=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.d=
ev> wrote:
>
> On 8/28/25 6:00 PM, Kuniyuki Iwashima wrote:
> >   static int sol_socket_sockopt(struct sock *sk, int optname,
> >                             char *optval, int *optlen,
> >                             bool getopt)
> > @@ -5284,6 +5313,7 @@ static int sol_socket_sockopt(struct sock *sk, in=
t optname,
> >       case SO_BINDTOIFINDEX:
> >       case SO_TXREHASH:
> >       case SK_BPF_CB_FLAGS:
> > +     case SK_BPF_MEMCG_FLAGS:
> >               if (*optlen !=3D sizeof(int))
> >                       return -EINVAL;
> >               break;
> > @@ -5293,8 +5323,15 @@ static int sol_socket_sockopt(struct sock *sk, i=
nt optname,
> >               return -EINVAL;
> >       }
> >
> > -     if (optname =3D=3D SK_BPF_CB_FLAGS)
> > +     switch (optname) {
> > +     case SK_BPF_CB_FLAGS:
> >               return sk_bpf_set_get_cb_flags(sk, optval, getopt);
> > +     case SK_BPF_MEMCG_FLAGS:
>
> I would remove the getsockopt only support from the other hooks that cann=
ot do
> the setsockopt. There are other ways for them to read sk->sk_memcg if it =
is
> really needed.

Ah, I forgot bpf_core_cast().

>
> > +             if (!IS_ENABLED(CONFIG_MEMCG) || !getopt)
> > +                     return -EOPNOTSUPP;
> > +
> > +             return sk_bpf_get_memcg_flags(sk, optval);
>
> Instead, do this only in bpf_sock_create_getsockopt.

Will do.

Thanks!

