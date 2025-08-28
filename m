Return-Path: <bpf+bounces-66753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB7B38FB0
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 02:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005FB7C24DD
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA789153BE8;
	Thu, 28 Aug 2025 00:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kyCv4Mvg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA549CA6B
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756340254; cv=none; b=d/TOlJTxwS33qJjgiG+sIKCAnz/xuKk5Tf6tDgUVOqLDfNjel2nvGhVpZdgcRDtPGv4emQrMoDTeQzICL8xZm75f5z3K8SHk6V/DQkkIaCShj8VdLFqW6+bRXcpkPgSsUueho1OonIEkLM6qNpYEWjQqxnVi+sTMlS3qO1s1poM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756340254; c=relaxed/simple;
	bh=BydufAr9TRihBjCNwji+Qjq7DWn7B5SiHIlkTJpyP4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUZ6sW97dosDdY9+qhoDzug0dWuu7fr1yKXVc4zPY7Hy414E8cZFBkyBVN4hbxZNdXH8P7PrBiRcjOXUFVzcfE2iReSO40B4dupSxhNdjNuP6UjEUektUcj5t1tsplDkRGpvGlf/e/P9a4zrjdMhkHtD91yoT4tOzpL9Cgrz2Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kyCv4Mvg; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-246ef40cf93so4239195ad.0
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 17:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756340252; x=1756945052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W23XGRanXXtnZg8pgF6wPf5lx31c85O1mg0Y/LrT18w=;
        b=kyCv4Mvg6NszQLixO1RX2zFfzoG10Ol98288tcJZvyG1pLkGpAMpHsrLwgyzWHhOhs
         VfRCHGdFsuv+CYKhzjADURMNmNJKNBeX1S8L+zPWb0MB/489c8yEn2+4uHZO3dk1iksF
         w6ycQpQXTdvziARgzPgSuSf6svIUEHG0GNv9A78jcsc5bcreUQQPqzBE/FgNnLGf9u2E
         9dLd/nFj5Pl9aWVMTOMpHjdmUbD0AK54WQ5dj0TyTkOTfNrSSLuJGwuvU2rTdfULa3qx
         /TWQrwDte+lndMzNI7Y+MBqc1bEYdTqXEpFJO7uJuSOEMNMUiGHsT+wCTOFni97kQAXF
         aweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756340252; x=1756945052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W23XGRanXXtnZg8pgF6wPf5lx31c85O1mg0Y/LrT18w=;
        b=nEDOh4xNniTRu8IdgEasF9I8GzSOTgL83O9A1VizoulpwJZtss2NIYhUEJBd7XJxoo
         WaX+SzAnQnqB18tDOGSN8W7t7rqz0qe59cs1ljjMKl7BJEte2YtsedObKBbujgm7w0jx
         lq5Pholkj9imRnnL9I4YhyZYCdHkGHmTdBOBOvaUgmklYXM3dwzjPXEAPC95b+zIZGoB
         I71ds/woTkiC414ex+ZxRpHq4meRlm59Vv18x0CE9M85ErKr0wgvy09lKdlU/NhrRElX
         g5cWY/Cb20hcx11qmJtMfcj6N85JqlfqLh1mTCUB6uFuD7oQg0gAMpARqzXrHIr3MWKe
         AQAw==
X-Forwarded-Encrypted: i=1; AJvYcCWwIaNC+rs+HCwk6Pf2WMt2of+ck2+/XmPRcifopHbzImUOyYaTFAHne4zUem/7e/vRPLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAl+aTTxi1O2nI/DDCvWCsOBxOaJHBy3Ub3DwMGApqDxoPixh
	fqkosXjdT8DqWYBlWvKWhCAa6esQCSzeB9GK/t30/20UfCrfCaSET8MJ497fsRQ0JZVeZRHJdMt
	KHvtLuUEWb3a18JawM9exQqv5Jm/fquipT4ZAuOMv
X-Gm-Gg: ASbGnct5M7AyxoYG5UARJqfgechUnZ+aAqF1Kq+VZpV/x7wFZiptU/opRmCXX/aIkMm
	Qf8rKhmqQMd1CMqe2jkTlpE5jpuHXnJ3huUCViE4LKkci4K5m6Wblw6/xlRmtncFPhQs0zgLJCl
	ugKsxVx0M34dONvXcIvi2I9T9faGj9vGmWN5bnoj+Env9vIbkaaTUUpKVGTb5l88iOSXEC5NSUD
	ttON/sfdKdZ+21o1w/zrBNhfAUXRuLvipCpA+c00tEdUCDNtbq6zkk+jRp4MRDNWbMkMHnothha
	Y/y45PnVij+daQ==
X-Google-Smtp-Source: AGHT+IFzRst4+V3uKc71q+xDhx2rcX+OOs/1EVS74qiu29Mbw02RhemNFzT0qQGc3wO7puzZSQKrwbpxU/b0ctb1HDo=
X-Received: by 2002:a17:903:19e5:b0:246:e1b6:cb19 with SMTP id
 d9443c01a7336-246e1b6cd69mr151013265ad.35.1756340251958; Wed, 27 Aug 2025
 17:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com> <20250826183940.3310118-4-kuniyu@google.com>
 <9919daa2-b6e0-4d5c-b349-39b055eaaed2@linux.dev>
In-Reply-To: <9919daa2-b6e0-4d5c-b349-39b055eaaed2@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 Aug 2025 17:17:20 -0700
X-Gm-Features: Ac12FXymSI4XzHCT4oSRAssqmTcZKeTl8F7P37tiFI-IZW8ivZjlv5OePQhbdy0
Message-ID: <CAAVpQUAVrsPxPj9zArvFcD76KYjY_X1gWvd7LnyBcQQQgYZ0cw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next/net 3/5] bpf: Introduce SK_BPF_MEMCG_FLAGS and SK_BPF_MEMCG_SOCK_ISOLATED.
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

On Wed, Aug 27, 2025 at 4:48=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/26/25 11:38 AM, Kuniyuki Iwashima wrote:
> > The main targets are BPF_CGROUP_INET_SOCK_CREATE and
> > BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB as demonstrated in the selftest.
> >
> > Note that we do not support modifying the flag once sk->sk_memcg is set
> > especially because UDP charges memory under sk->sk_receive_queue.lock
> > instead of lock_sock().
> >
>
> [ ... ]
>
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index 63a6a48afb48..d41a2f8f8b30 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -2596,10 +2596,39 @@ static inline gfp_t gfp_memcg_charge(void)
> >       return in_softirq() ? GFP_ATOMIC : GFP_KERNEL;
> >   }
> >
> > +#define SK_BPF_MEMCG_FLAG_MASK       (SK_BPF_MEMCG_FLAG_MAX - 1)
> > +#define SK_BPF_MEMCG_PTR_MASK        ~SK_BPF_MEMCG_FLAG_MASK
> > +
> >   #ifdef CONFIG_MEMCG
> > +static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned s=
hort flags)
> > +{
> > +     unsigned long val =3D (unsigned long)sk->sk_memcg;
> > +
> > +     val |=3D flags;
> > +     sk->sk_memcg =3D (struct mem_cgroup *)val;
> > +}
> > +
>
> [ ... ]
>
> > +static int sk_bpf_set_get_memcg_flags(struct sock *sk, int *optval, bo=
ol getopt)
> > +{
> > +     if (!sk_has_account(sk))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (getopt) {
> > +             *optval =3D mem_cgroup_sk_get_flags(sk);
> > +             return 0;
> > +     }
> > +
> > +     if (sock_owned_by_user_nocheck(sk) && mem_cgroup_from_sk(sk))
>
> I still don't see how this can stop some of the bh bpf prog to set/clear =
the bit
> after mem_cgroup_sk_alloc() is done. For example, in BPF_SOCK_OPS_RETRANS=
_CB,
> bh_lock_sock() is held but not owned by user, so the bpf prog can continu=
e to
> change the SK_BPF_MEMCG_FLAGS. What am I missing?

You are totally right.  I think I was just confused.

>
> Passing some more args to __bpf_setsockopt() for caller context purpose i=
s quite
> ugly which I think you also mentioned/tried earlier.

Another option I was thinking (but didn't try) was extending void *ctx
from struct sock * to like below and silently cast ctx back to the original
one in the dedicated setsockopt proto.

struct {
    struct sock * sk;
    /* caller info here */
}

>  May be it can check "if
> (in_softirq() && mem_cgroup_from_sk(sk)) return -EBUSY" but looks quite t=
ricky
> together with the sock_owned_by_user_nocheck().
>
> It seems this sk_memcg bit change is only needed for sock_ops hook and cr=
eate
> hook? sock_ops already has its only func_proto bpf_sock_ops_setsockopt().
> bpf_sock_ops_setsockopt can directly call sk_bpf_set_get_memcg_flags() bu=
t limit
> it to the BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB. Is it also safe to allow i=
t for
> BPF_SOCK_OPS_TCP_LISTEN_CB? For the create hook, create a new func proto =
which
> can directly call sk_bpf_set_get_memcg_flags(). wdyt?

I prefer the new proto instead of a hacky/complicated approach.


>
> > +             return -EBUSY;
> > +
> > +     if (*optval <=3D 0 || *optval >=3D SK_BPF_MEMCG_FLAG_MAX)
>
> It seems the bit cannot be cleared (the *optval <=3D 0 check). There coul=
d be
> multiple bpf progs running in a cgroup which want to clear this bit. e.g.=
 the
> parent cgroup's prog may want to ensure this bit is not set.

I didn't think about the situation, so the set helper will need to
reset all flags (in case there could be multiple bit flags in the future)

static inline void mem_cgroup_sk_set_flags(struct sock *sk, unsigned short =
flags
{
    unsigned long val =3D (unsigned long)sk->sk_memcg;

    val &=3D SK_BPF_MEMCG_PTR_MASK;
    val |=3D flags;

    sk->sk_memcg =3D (struct mem_cgroup *)val;
}

