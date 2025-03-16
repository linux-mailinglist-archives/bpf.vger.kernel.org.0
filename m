Return-Path: <bpf+bounces-54142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DA4A635EB
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 14:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF7416FCAF
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326561AAE08;
	Sun, 16 Mar 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRHUBcbX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240419E7FA;
	Sun, 16 Mar 2025 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133396; cv=none; b=OdC/5v/KcmOpGjdI9ieJZEI0xXvJnkXwCR1vnvlVl1nwU7HtCeWJfoCMScRisjzK/QNkhTnQgmJcFlzrHODjsHTIwVBo3pHrT2FKonpRIPI52CQCzRZ1FlaGSUTdoouDncFr8lKVZH2G1AgvlAZqNio6fE7u8HCvh9DqlkcOKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133396; c=relaxed/simple;
	bh=/lGpgGo8Z+WG9+wFZwQUDcapNedzqeLEvT6E58LJ2TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUcVV39hJTIMBFsZWz7gbjEOH4hS/bPvFLZn+v+bXIfecGODAvu+HMw95GdNWNfJnIhjc6wqLuV0+lGnQ8iKrZ+CQCuE9Y8ZQPhOuT1OkHzMh/CjdqIVaTyOWEE/xkFTZ9QHV/SZQ9V4fSaeE3CxCFWWcc15XZEX09awCFx+Qds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRHUBcbX; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff37565232so27574247b3.3;
        Sun, 16 Mar 2025 06:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742133394; x=1742738194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kchZ9rsgLEYdP4HGLCj7ua1euIaz8+Xk2/kromwai50=;
        b=cRHUBcbXWVH7tlCIwBw2Dh7Ua8zYcOFjDmsavv5SC/flfGxUALgEB46ld6srdDlxTs
         Z/miOGE6matra59jBsRtG4QBv4v+eci8oaRP29fSjLjuKaAchPny9qRfGHm2cZBNAi6/
         xjwjbjeCSSuOiXzADknO4Tb+WaqgbD9YR1An5jrNXMcmBbtJFjYsg5dyY8srrlOx/7wy
         ApD3NlXU9u4yy6AcuKHhZL/WkMsaCpI+pZ5WY9iwVfdHcN2uJh1A/6TJpFxDAb1AV8wW
         SH6q6uvBChdd4+vGkML5Ub/9FOO9MVcIZODB0RU3+YjV+U7+VX8yMEGWiUFH0YSsXOYS
         rChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742133394; x=1742738194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kchZ9rsgLEYdP4HGLCj7ua1euIaz8+Xk2/kromwai50=;
        b=j+5PJ95H0CFiLuURq9HfN7Z1/h/yWhqkJgoXfz94YVq3BN1A5nel1DiiuwdzAiO1jT
         j+KwC+kCjvsgcvWMpjfWaMf3d1EaajqGG6D1aDPKJrjZI24Jx2AK0E2TjIcERYvWVa1+
         qN19CO1v6hEwdZ6fEw24Aq1Z/qLaQW09La16p/ZYYZHnhm3K/80jsnPWc7/kzxUxNT+d
         lnYS5fWTxz6dUEXRLKrKIGu+tcqYRx2SZavRCKvzJVcoFTxuoA3ixS2t/fnvUV6nSVEG
         o1wKrnCz2tYnphK857qdsH9OUTyDtm5iwzsga2HMNb+ssZ9mEP/dTlXuWahVe2nMOfpv
         1j7g==
X-Forwarded-Encrypted: i=1; AJvYcCXI6phZbJvz6DnwHBt1P4+q7BXtIVupGqwS/a193XS+S4D4YfLYrjbFx6zrXJtuPEh2I/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaUyg4SCrAToNE6UQDcGvcL0MCUOc4Xyxa1k8CPlvJUYVo9jb
	V1qc8UOmnbcZQtzRHFlMGsn2XWAwKTtnGpxbHIgJtaqbPUxnYiWDuv4RR1kMV0C5Au/f3v77ijb
	yXmTAqW84ADkS2KYaz6Qc8RaMPFQ=
X-Gm-Gg: ASbGncvTZfF5LJpIniHk3BVy7lBF0pTZ1kbk24ixv3oLC8Pd1hhB8aexi3g+dVLp7h9
	i3HJXtTP/4oYDsaGLbEQoKic8Jfv7gThgSXMgl+6AUIU0fKLh4Imu5iTYSvJM4TOmKayxG17HE7
	wOdvwSotcPZAvJYJOsXGbWaPR+qg==
X-Google-Smtp-Source: AGHT+IGOKmvfI+PIr0gYbk8ytJNZWHi+UTRo4SUDBVBphAuRu6c9gmeU9e/Pnbuyeyw/NZGtpHQGDZRHjPHO49suYt0=
X-Received: by 2002:a05:690c:6007:b0:6f7:ac3f:d589 with SMTP id
 00721157ae682-6ff4605668bmr117309927b3.36.1742133393987; Sun, 16 Mar 2025
 06:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313190309.2545711-1-ameryhung@gmail.com> <20250313190309.2545711-8-ameryhung@gmail.com>
 <CAADnVQKBe89WSjwsMaaGGmHAtGSSvCVQ+f7HstjQBzx8pu2gUQ@mail.gmail.com>
In-Reply-To: <CAADnVQKBe89WSjwsMaaGGmHAtGSSvCVQ+f7HstjQBzx8pu2gUQ@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Sun, 16 Mar 2025 21:56:22 +0800
X-Gm-Features: AQ5f1Jqd8J8t5MWQDg4l8FLrppQPFJYtOK9dB4_r_wBc_j4yAos_mT3gPaXsTxQ
Message-ID: <CAMB2axM-601dn0_vvprHp5qdVPb2-204ZHR8zh2pwo6GHo6UCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 07/13] bpf: net_sched: Support updating qstats
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Kui-Feng Lee <sinquersw@gmail.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Jiri Pirko <jiri@resnulli.us>, Stanislav Fomichev <stfomichev@gmail.com>, 
	ekarani.silvestre@ccc.ufcg.edu.br, yangpeihao@sjtu.edu.cn, 
	Peilin Ye <yepeilin.cs@gmail.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 4:24=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Mar 13, 2025 at 12:03=E2=80=AFPM Amery Hung <ameryhung@gmail.com>=
 wrote:
> >
> > From: Amery Hung <amery.hung@bytedance.com>
> >
> > Allow bpf qdisc programs to update Qdisc qstats directly with btf struc=
t
> > access.
> >
> > Signed-off-by: Amery Hung <amery.hung@bytedance.com>
> > ---
> >  net/sched/bpf_qdisc.c | 53 ++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 45 insertions(+), 8 deletions(-)
> >
> > diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> > index edf01f3f1c2a..6ad3050275a4 100644
> > --- a/net/sched/bpf_qdisc.c
> > +++ b/net/sched/bpf_qdisc.c
> > @@ -36,6 +36,7 @@ bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
> >         }
> >  }
> >
> > +BTF_ID_LIST_SINGLE(bpf_qdisc_ids, struct, Qdisc)
> >  BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
> >  BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
> >
> > @@ -60,20 +61,37 @@ static bool bpf_qdisc_is_valid_access(int off, int =
size,
> >         return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> >  }
> >
> > -static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
> > -                                       const struct bpf_reg_state *reg=
,
> > -                                       int off, int size)
> > +static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
> > +                                 const struct bpf_reg_state *reg,
> > +                                 int off, int size)
>
> Introducing this func in patch 3 and refactoring in patch 7 ?
> pls avoid the churn.
> squash it ?
>
> if (off + size > end) check wouldn't need to be duplicated.
> Can get the name of struct from btf for bpf_log() purpose.
>

I will squash this patch to patch 3 and share the check in
bpf_qdisc_btf_struct_access() to avoid duplication.

Thanks,
Amery

> >  {
> > -       const struct btf_type *t, *skbt;
> >         size_t end;
> >
> > -       skbt =3D btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
> > -       t =3D btf_type_by_id(reg->btf, reg->btf_id);
> > -       if (t !=3D skbt) {
> > -               bpf_log(log, "only read is supported\n");
> > +       switch (off) {
> > +       case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdis=
c, qstats) - 1:
> > +               end =3D offsetofend(struct Qdisc, qstats);
> > +               break;
> > +       default:
> > +               bpf_log(log, "no write support to Qdisc at off %d\n", o=
ff);
> > +               return -EACCES;
> > +       }
> > +
> > +       if (off + size > end) {
> > +               bpf_log(log,
> > +                       "write access at off %d with size %d beyond the=
 member of Qdisc ended at %zu\n",
> > +                       off, size, end);
> >                 return -EACCES;
> >         }
> >
> > +       return 0;
> > +}
> > +
> > +static int bpf_qdisc_sk_buff_access(struct bpf_verifier_log *log,
> > +                                   const struct bpf_reg_state *reg,
> > +                                   int off, int size)
> > +{
> > +       size_t end;
> > +
> >         switch (off) {
> >         case offsetof(struct sk_buff, tstamp):
> >                 end =3D offsetofend(struct sk_buff, tstamp);
> > @@ -115,6 +133,25 @@ static int bpf_qdisc_btf_struct_access(struct bpf_=
verifier_log *log,
> >         return 0;
> >  }
> >
> > +static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
> > +                                      const struct bpf_reg_state *reg,
> > +                                      int off, int size)
> > +{
> > +       const struct btf_type *t, *skbt, *qdisct;
> > +
> > +       skbt =3D btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
> > +       qdisct =3D btf_type_by_id(reg->btf, bpf_qdisc_ids[0]);
> > +       t =3D btf_type_by_id(reg->btf, reg->btf_id);
> > +
> > +       if (t =3D=3D skbt)
> > +               return bpf_qdisc_sk_buff_access(log, reg, off, size);
> > +       else if (t =3D=3D qdisct)
> > +               return bpf_qdisc_qdisc_access(log, reg, off, size);
> > +
> > +       bpf_log(log, "only read is supported\n");
> > +       return -EACCES;
> > +}
> > +
> >  BTF_ID_LIST(bpf_qdisc_init_prologue_ids)
> >  BTF_ID(func, bpf_qdisc_init_prologue)
> >
> > --
> > 2.47.1
> >

