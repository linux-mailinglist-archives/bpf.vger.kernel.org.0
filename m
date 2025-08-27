Return-Path: <bpf+bounces-66740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CB6B38EB8
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 00:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B693B975B
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 22:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEEC730FC3F;
	Wed, 27 Aug 2025 22:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iytvK6AK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E780830FC01
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 22:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334985; cv=none; b=sJ0EaH8ry0Fa6V8zV/sVu2qxCFqnX9dDlw0O0tMWBlvSXJBK1YwmglaDnpgj7nIbvcsUYuASUJFXMgNTJL1rIGJkW4ZCQ0C3JJyO9ystMsXLvvpqKECMd6E0volirmdlIBG11S+VVvpjM1PRA43QLVT+c/LMs2327Rzaj68fyKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334985; c=relaxed/simple;
	bh=QVc/J5WHQyzN1+X0tRM9t5olzSDJgl8rUhFvK6vUYTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0oT+te1c4upPREbZHRapI9FZ+M4dXHVl4rAah7OuKJ+TB/bZq47pZFK8+Q2H5+/N+I6bHJ+Pe037lHltmCGNIPIRTLVfzF9eJZOEJdJaqSj5+GTPmnWVC6+1jWJh3Zs53X4sdievDNG6F1psCvIcwBzv5bmubvSu0Bk2eAwX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iytvK6AK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-323267872f3so341388a91.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 15:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756334983; x=1756939783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7tJKydEs+jBSYANdXBRrBzUHYm1sa5F5ZoiiMWvX0g=;
        b=iytvK6AKI40In9EM+Sdp469R14HqrmSPsgm8hWGf6yRPj3Dx/ebbkz4rqExy8F+Mf5
         P7DRttD2AFNq+3/9m+TEpKTQjKdP8FDqdWXJQxuyCbX1r9BU7jkd9MCkb8y0el5C8HkQ
         6+kK6QDEPGr7tRld1ywaiNPuG32dYxTbOq08b1t8nk28YndNh3OfCLE8tEI8TlaS9Fch
         GqlO7EWS7JNczSGRexden4GNQkuSKMZj9XjL3aRWREBe5RKaYos8n281Ac6agV1H3a5i
         J/DyTNtrD4CRmFR9RUrlYePbpVraDUwGaN2M9zsM1xfG8YBmSSlpjB+Rb/kbqbwHGnM6
         WpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756334983; x=1756939783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7tJKydEs+jBSYANdXBRrBzUHYm1sa5F5ZoiiMWvX0g=;
        b=TSO51nGH3Ws+jQIYCl9m62Fz7dup6r1SHSC+iokLv6c7tKrPJ/WddbcevT7P/Xnury
         WDnKeYkPUCIcjv5wStrEj/U7DFVlRI9ukJ2JOAwBKfdGUtJMdZIuNrflTm019eGuyLtl
         nl1IKRUduEFA0XmtWt7hO4mXdIMvyf4foWQtEDJpXFMUoYfAx2EgY0C15d0GRoNsoYn4
         hO8ssRpTf41bAiBjQy8LUW9WlUMW0FKfs96Jw9eH1jEd30tS0V5fg/Wwudzpv2oeFUiK
         LrqpQYlpFrs2djcrlv+M+TysdyD4jn1HEUgnv+hhD8KAdNvKiH5cWXgY7HCdYgfzruyx
         PdrA==
X-Forwarded-Encrypted: i=1; AJvYcCV3WGGhpL2MtcYIp8TiJ57eOafq5NefFiEm75N78X8FwHKd3LgGfU2BDp4T16rMPOwLJvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztvnDEpsnkmpXTp0ZGfANtKlbccK1D9wJrdNyKkgm78qpKQD3i
	hWskgkKwDfbq7JuL9N3Am0LQ9OwsShW1g5Yhn/KLBtASdh3kfG9OxrZOqdAaohwMp9VNMflkz/V
	jXUDyAccXlb/XRE7LAdstGA8fXFotKKT+Hnnc5vyT
X-Gm-Gg: ASbGncu2X30JUeqMQ/OR1XMyz7ny6a4luxCcmry0hGgMtn/f7qxyd5zmQ+KxmONiCRT
	4K7On4tMg6OKCcaijRZ68Jtrd1mQICEq/nbKVixYSr1m+aIScUe8WQ2QZO6HPA+vSgRWJLjtIcN
	4r0KI7cy3m8qLaX2nih+Fj0nMyWtaowJ8OgnMiZdtcDwIp2OS/QJFn7AAeaD23tYhtu/qNmmea/
	s/TKjXKRtnDhuHIbZfV2sxTp998+KGs8wNm2KY/sl8oLR3Wpak81QuT+vynnD4CWxO760W9SBZE
	s2c=
X-Google-Smtp-Source: AGHT+IFHChF/Z4eumRf7dcLNR3yT9T1V5M+AwTtQOljsYMx3cTlIrD3l+pjRP1l/H6FwzzL7yBvPGjYfLWGIpG1NTpQ=
X-Received: by 2002:a17:90b:2f87:b0:31e:fac5:5d3f with SMTP id
 98e67ed59e1d1-32515e37453mr32078746a91.16.1756334982875; Wed, 27 Aug 2025
 15:49:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826183940.3310118-1-kuniyu@google.com> <20250826183940.3310118-3-kuniyu@google.com>
 <aaf5eeb5-2336-4a20-9b8f-0cdd3c274ff0@linux.dev>
In-Reply-To: <aaf5eeb5-2336-4a20-9b8f-0cdd3c274ff0@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 27 Aug 2025 15:49:31 -0700
X-Gm-Features: Ac12FXxyFUKfXk4e6gDWfVcO2YtUAFIUl5jV7W_QtTmDvgwlt5pV4h7Mf-JUJVU
Message-ID: <CAAVpQUCpoN4mA52g_DushJT--Fpi5b8GaB0EVgt1Eu3O+6GUrw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next/net 2/5] bpf: Support bpf_setsockopt() for BPF_CGROUP_INET_SOCK_CREATE.
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

On Wed, Aug 27, 2025 at 3:23=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 8/26/25 11:38 AM, Kuniyuki Iwashima wrote:
> > We will store a flag in sk->sk_memcg by bpf_setsockopt() during
> > socket() or before sk->sk_memcg is set in accept().
> >
> > BPF_CGROUP_INET_SOCK_CREATE is invoked by __cgroup_bpf_run_filter_sk()
> > that passes a pointer to struct sock to the bpf prog as void *ctx.
> >
> > But there are no bpf_func_proto for bpf_setsockopt() that receives
> > the ctx as a pointer to struct sock.
> >
> > Let's add a new bpf_setsockopt() variant for BPF_CGROUP_INET_SOCK_CREAT=
E.
> >
> > Note that inet_create() is not under lock_sock().
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v3: Remove bpf_func_proto for accept()
> > v2: Make 2 new bpf_func_proto static
> > ---
> >   net/core/filter.c | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 63f3baee2daf..443d12b7d3b2 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -5743,6 +5743,23 @@ static const struct bpf_func_proto bpf_sock_ops_=
setsockopt_proto =3D {
> >       .arg5_type      =3D ARG_CONST_SIZE,
> >   };
> >
> > +BPF_CALL_5(bpf_unlocked_sock_setsockopt, struct sock *, sk, int, level=
,
> > +        int, optname, char *, optval, int, optlen)
> > +{
> > +     return _bpf_setsockopt(sk, level, optname, optval, optlen);
>
> The sock_owned_by_me() will warn.
>
>  From CI:
> WARNING: CPU: 0 PID: 102 at include/net/sock.h:1756 bpf_unlocked_sock_set=
sockopt+0xc7/0x110

Oh sorry, I copied from a wrong place.. will fix it.

BTW, I'm thinking I should inherit flags from the listener
in sk_clone_lock() and disallow other bpf hooks.

Given the listener's flag and bpf hooks come from the
same cgroup, there is no point having other hooks.


>
> > +}
> > +
> > +static const struct bpf_func_proto bpf_unlocked_sock_setsockopt_proto =
=3D {
> > +     .func           =3D bpf_unlocked_sock_setsockopt,
> > +     .gpl_only       =3D false,
> > +     .ret_type       =3D RET_INTEGER,
> > +     .arg1_type      =3D ARG_PTR_TO_CTX,
> > +     .arg2_type      =3D ARG_ANYTHING,
> > +     .arg3_type      =3D ARG_ANYTHING,
> > +     .arg4_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> > +     .arg5_type      =3D ARG_CONST_SIZE,
> > +};
> > +
> >   static int bpf_sock_ops_get_syn(struct bpf_sock_ops_kern *bpf_sock,
> >                               int optname, const u8 **start)
> >   {
> > @@ -8051,6 +8068,13 @@ sock_filter_func_proto(enum bpf_func_id func_id,=
 const struct bpf_prog *prog)
> >               return &bpf_sk_storage_get_cg_sock_proto;
> >       case BPF_FUNC_ktime_get_coarse_ns:
> >               return &bpf_ktime_get_coarse_ns_proto;
> > +     case BPF_FUNC_setsockopt:
> > +             switch (prog->expected_attach_type) {
> > +             case BPF_CGROUP_INET_SOCK_CREATE:
> > +                     return &bpf_unlocked_sock_setsockopt_proto;
> > +             default:
> > +                     return NULL;
> > +             }
> >       default:
> >               return bpf_base_func_proto(func_id, prog);
> >       }
>

