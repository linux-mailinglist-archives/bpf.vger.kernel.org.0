Return-Path: <bpf+bounces-69303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C524B93C83
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 03:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7BE2E18CD
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 01:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82E01DF72C;
	Tue, 23 Sep 2025 01:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HUgiQ5Yc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B4514C5B0
	for <bpf@vger.kernel.org>; Tue, 23 Sep 2025 01:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589420; cv=none; b=EMhLzYh8JxY2GBtffSoypVdXavDocgyoo3VYkGcIxLJ0w5XhwwFayJ9TgI6ujWjS+9Avk58ztb8ZGtPj71Oih/Uy6z6rU1BONZSsRDpHDUSVeh8e7l4gbYEVoJeovdiazjXwGKXkO5vijLuIhc4Lbj9iheRSvxDbTZyF///hDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589420; c=relaxed/simple;
	bh=i6Of2jAUL+zQjJ8mC94XwylCjFmErxMFeVoMP3a6500=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DQUVSYcM7gQ+Tk2rR0pZr6Kq8EggmYJILoz0sKdYA1Mp1i6+VAeC3SIrku+I6rzuGdAGb0gDkxXOC8KcueM9p0IVR9fFcMCF0tXA7MoRBGCQ60u1lD0WP6PS07Yv48DBoSgLgcUhHiWmorxsLLsHkaE246J35NLU5vOXbL5NrYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUgiQ5Yc; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b5518177251so2317904a12.0
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 18:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758589418; x=1759194218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x33yQCiS8yD4t00RGUcUdYXvxGF8NkkkcCi7P/JHd/M=;
        b=HUgiQ5YcWjQFquCPubpxmHoqDYVyL8Pl9u40e4LEBO1Hz4pTehTPy/LrzenufVT+1n
         HNtF67XfHYdXCIsiALwkPMC4x7wiNo06LakgR2uDEToKI9mi6zjJOAx2c9GK6OfZ5qMy
         HXAEBLTFi+EPoqAO932P8UvVWU9rIe/VM2qmRQC0jjvqe3eT8Svd0iTlzXoxWlvRLa9G
         KAmOY6LELFQBNuWWLcVbFJiiqgFDWtsgCNBgD4R1A5WXqRvP1aeZFO+Dh4yEd1yLvD96
         EsmVDZvHXLgA1VerIWja67jAv/jsoggADxLHjdHCWEXgIEsKlidPgiL3GvI7teVVbpYH
         0x9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758589418; x=1759194218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x33yQCiS8yD4t00RGUcUdYXvxGF8NkkkcCi7P/JHd/M=;
        b=uwKrfYW2PeP+Hl44t93J2K1YaqEG+Kz80ACng2BkrG2j/OwuuC3jM9NgGCtJY/s/ki
         dJStAqAgbqbDgbbLtcX897cZ7KpPp60ABKaXseFRPaPiKI6xEfWwOmPtDvr6IqAJxIOo
         MNMojc7ec597SlVkX9saM/h2EXTPnmbq0b8cXC2OkSFuGI7+kDCeaoVe+wktVsxlc1Dr
         kvVuROkaBV+ADBKQ2O85JxVV3pTpOZ+ksCzkHMLewOTh/O0uPqYVrUEsw146SCYbsQkd
         e44QCItyjDIoOGNvPmkoVHKgxmJmFPXt2JCNg/GTnahvz6g0/12x79QoYKENLNQJYRJe
         +5eg==
X-Forwarded-Encrypted: i=1; AJvYcCVub7JpU86NVBr8p7FCnTW11WHMO+rZzIVZzzV47ZoSL8y+wM9Uu90AyPin1VBYbym3TJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YydEWwqF0WqghlyjHbl8FvnjxicOUeanIWkJBg1MjuONioOij24
	JZgH908N3JnYi4+CjJ0ofqM5AFcQlXH+8Ke6qoW+umKB2j/CJaeo0fXyN/GigA1nauwCR39otdn
	HaKn2+ovusyai+Q5QEjOOP1lN9uYZWzsfUNlyLE1z
X-Gm-Gg: ASbGncsZij68UfMuoS2yYXw9rLk5mEKCGhh7IcR/M/bS9aP+xH3/slJ7LeYlfUbAQP4
	+YsKOU+4s2S/mVx0Z3p2ZKZ+3+BuzJtgoHHTVvx6pKOQYvRZdMuMbDL4xtCJ5jg3+k4EDEVPsOu
	RVIKyc2AH7ni/VrAut4FnpKt/NKHbeb8rRvriZsv4iJkxZTIYxNfY9UyRlTjXphB9HqSko/bJST
	dLTlVg=
X-Google-Smtp-Source: AGHT+IF4V7vLCAX99zE2i1WgDrb/NvJZo/98rUrRoBuo4S05a+IOKORc6ElcP1wyehzVZqK2h4N0L8kJZulAJ8PxgQE=
X-Received: by 2002:a17:90b:2d8b:b0:32e:a54a:be5d with SMTP id
 98e67ed59e1d1-332a91baa9fmr956929a91.2.1758589417994; Mon, 22 Sep 2025
 18:03:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920000751.2091731-1-kuniyu@google.com> <20250920000751.2091731-4-kuniyu@google.com>
 <pmti7ebtl7zfom5ndqcvpdwjxlkrvmly2ol64llabcwfk7bdg2@mc3pigkg2ppq>
In-Reply-To: <pmti7ebtl7zfom5ndqcvpdwjxlkrvmly2ol64llabcwfk7bdg2@mc3pigkg2ppq>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 22 Sep 2025 18:03:25 -0700
X-Gm-Features: AS18NWA4Ta5V2LkgBMhN9GY-RVQdhXUu2iIiDrc6jXD7aYqae5HSof66nqd6WU4
Message-ID: <CAAVpQUBZSK6ptrRgruj0BGXBqDUOu3MKYKfD9FkWFn55OduwOw@mail.gmail.com>
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

On Mon, Sep 22, 2025 at 5:54=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Sat, Sep 20, 2025 at 12:07:17AM +0000, Kuniyuki Iwashima wrote:
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index 814966309b0e..348e599c3fbc 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -2519,6 +2519,7 @@ struct sock *sk_clone_lock(const struct sock *sk,=
 const gfp_t priority)
> >  #ifdef CONFIG_MEMCG
> >       /* sk->sk_memcg will be populated at accept() time */
> >       newsk->sk_memcg =3D NULL;
> > +     mem_cgroup_sk_set_flags(newsk, mem_cgroup_sk_get_flags(sk));
>
> Why do you need to set the flag here? Will doing in __inet_accept only
> be too late i.e. protocol accounting would have happened?

Currently, we only allow bpf_setsockopt() during socket(2) not
to make things complicated as explained in patch 4.

So, this is to preserve the listener's flag set by bpf_setsockopt()
since network applications basically assume setsockopt() for a
listener socket is inherited to its child sockets.

