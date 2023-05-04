Return-Path: <bpf+bounces-50-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CC06F7965
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 00:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFAA280F3F
	for <lists+bpf@lfdr.de>; Thu,  4 May 2023 22:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37B2C15A;
	Thu,  4 May 2023 22:51:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A15156FB
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 22:51:40 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373CDA5CC
	for <bpf@vger.kernel.org>; Thu,  4 May 2023 15:51:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-965d2749e2eso52990866b.1
        for <bpf@vger.kernel.org>; Thu, 04 May 2023 15:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683240697; x=1685832697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3Ii7UKWa7qbvByPjnxibBA09YgczpLO45TX5ggsKhg=;
        b=BDcmOk05FONy+GSMcr0PB7NFJE3FtKQ/Qm+b0raipDaAcR7bUAveRTAa/dKxJmyFvw
         MEiOTup9s5p0NFBA1cbN+ksijOwj0ivxpv309e1onKnYyvDvQAHnNoVYH4HdvYzOZiu0
         M5V0fXIDmysSCFGdidt7TuNxwwDl+chCth9L6VttbRv5k4NeJdYHlC2OSzq6K/wQSc62
         I3hc6FMFbgKtAklzjCBKrq348gAeU5w7Jz1+eGlzE+75G5j+ofeCTP5uY7qAWxm8jwMS
         pcxHVrHDubteP++pianwUddrR7DuDQwAIGzGlruRF5/KniKRpXOdLdV6FohdRlySzxUA
         4fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683240697; x=1685832697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3Ii7UKWa7qbvByPjnxibBA09YgczpLO45TX5ggsKhg=;
        b=OKUpO+lY2uODQTKErsAFwBaLVOV0rk7/KQ7bnMOZA2WVqNgMPaJ+832kXAnN4faUrA
         8orYQAJe6SZER0aobOoDVew8q2Zf6EBUhNH98UX7huLVaJX+qLxTRk03xPH+v+hrWBwz
         whmh1/QDv+G+MZbn7s0O48UBunvwld9iZvtBO9tfEQjy8e7s4i+ARnLl6Zrr4ekC0lQD
         8trVglJG3conKQnXAM41a3q0iOCi6WnH1Op9G1ubIRYEJVJ4lI+JAYxWUsLLscIbNGxB
         FgdHzonI7WTlcaqdOiHaElTLfuKHdsVcBeq6GxKs1CuO2Wfzsli1xgL6TfthE5Rz3ogI
         0raw==
X-Gm-Message-State: AC+VfDxlsQS+4/IHfYYgTbAbpyMgYvmraSUbUrVw+OUklMbT08+w8tjz
	gRjYkLmnWPTQ34yK4ZQu++saALxsBaqbC8DP6nEz8xRx
X-Google-Smtp-Source: ACHHUZ5dZwsmk0etAF/QyAxPvLg5hm4FYFrJBm3TssBdP+fAxDWoUYD6cLPmIyIcTxA6MkT0EAv341YkI7j/+irRHX4=
X-Received: by 2002:a17:907:948a:b0:92b:6f92:7705 with SMTP id
 dm10-20020a170907948a00b0092b6f927705mr317301ejc.40.1683240697461; Thu, 04
 May 2023 15:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230502230619.2592406-1-andrii@kernel.org> <20230502230619.2592406-7-andrii@kernel.org>
 <20230504201258.co6nej2iraprngrq@MacBook-Pro-6.local>
In-Reply-To: <20230504201258.co6nej2iraprngrq@MacBook-Pro-6.local>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 May 2023 15:51:25 -0700
Message-ID: <CAEf4BzaHg=cWLukSs5Y_iA6ExkBMFeaUGELjDuALMF=cNg5JOg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/10] bpf: keep BPF_PROG_LOAD permission checks
 clear of validations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 4, 2023 at 1:13=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, May 02, 2023 at 04:06:15PM -0700, Andrii Nakryiko wrote:
> > Move out flags validation and license checks out of the permission
> > checks. They were intermingled, which makes subsequent changes harder.
> > Clean this up: perform straightforward flag validation upfront, and
> > fetch and check license later, right where we use it. Also consolidate
> > capabilities check in one block, right after basic attribute sanity
> > checks.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 44 +++++++++++++++++++++-----------------------
> >  1 file changed, 21 insertions(+), 23 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 2e5ca52c45c4..d960eb476754 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2573,18 +2573,6 @@ static int bpf_prog_load(union bpf_attr *attr, b=
pfptr_t uattr, u32 uattr_size)
> >       struct btf *attach_btf =3D NULL;
> >       int err;
> >       char license[128];
> > -     bool is_gpl;
> > -
> > -     /* Intent here is for unprivileged_bpf_disabled to block key obje=
ct
> > -      * creation commands for unprivileged users; other actions depend
> > -      * of fd availability and access to bpffs, so are dependent on
> > -      * object creation success.  Capabilities are later verified for
> > -      * operations such as load and map create, so even with unprivile=
ged
> > -      * BPF disabled, capability checks are still carried out for thes=
e
> > -      * and other operations.
> > -      */
> > -     if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> > -             return -EPERM;
> >
> >       if (CHECK_ATTR(BPF_PROG_LOAD))
> >               return -EINVAL;
> > @@ -2598,21 +2586,22 @@ static int bpf_prog_load(union bpf_attr *attr, =
bpfptr_t uattr, u32 uattr_size)
> >                                BPF_F_XDP_DEV_BOUND_ONLY))
> >               return -EINVAL;
> >
> > +     /* Intent here is for unprivileged_bpf_disabled to block key obje=
ct
> > +      * creation commands for unprivileged users; other actions depend
> > +      * of fd availability and access to bpffs, so are dependent on
> > +      * object creation success.  Capabilities are later verified for
> > +      * operations such as load and map create, so even with unprivile=
ged
> > +      * BPF disabled, capability checks are still carried out for thes=
e
> > +      * and other operations.
> > +      */
> > +     if (sysctl_unprivileged_bpf_disabled && !bpf_capable())
> > +             return -EPERM;
> > +
>
> Since that part was done in patch 1. Move it into right spot in patch 1 r=
ight away?

fair enough, will do it right away in patch 1

>
> >       if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS) &&
> >           (attr->prog_flags & BPF_F_ANY_ALIGNMENT) &&
> >           !bpf_capable())
> >               return -EPERM;
> >
> > -     /* copy eBPF program license from user space */
> > -     if (strncpy_from_bpfptr(license,
> > -                             make_bpfptr(attr->license, uattr.is_kerne=
l),
> > -                             sizeof(license) - 1) < 0)
> > -             return -EFAULT;
> > -     license[sizeof(license) - 1] =3D 0;
> > -
> > -     /* eBPF programs must be GPL compatible to use GPL-ed functions *=
/
> > -     is_gpl =3D license_is_gpl_compatible(license);
> > -
> >       if (attr->insn_cnt =3D=3D 0 ||
> >           attr->insn_cnt > (bpf_capable() ? BPF_COMPLEXITY_LIMIT_INSNS =
: BPF_MAXINSNS))
> >               return -E2BIG;
> > @@ -2700,7 +2689,16 @@ static int bpf_prog_load(union bpf_attr *attr, b=
pfptr_t uattr, u32 uattr_size)
> >       prog->jited =3D 0;
> >
> >       atomic64_set(&prog->aux->refcnt, 1);
> > -     prog->gpl_compatible =3D is_gpl ? 1 : 0;
> > +
> > +     /* copy eBPF program license from user space */
> > +     if (strncpy_from_bpfptr(license,
> > +                             make_bpfptr(attr->license, uattr.is_kerne=
l),
> > +                             sizeof(license) - 1) < 0)
> > +             return -EFAULT;
>
> This 'return' is incorrect. It misses lots of cleanup.
> Should probably be 'goto free_prog_sec', but pls double check.
> We don't have tests to check error handling. Just lucky code review.
>

yep, lucky indeed. My bad, I should have adjusted it to `goto free_prog_sec=
;`.


> > +     license[sizeof(license) - 1] =3D 0;
> > +
> > +     /* eBPF programs must be GPL compatible to use GPL-ed functions *=
/
> > +     prog->gpl_compatible =3D license_is_gpl_compatible(license) ? 1 :=
 0;
> >
> >       if (bpf_prog_is_dev_bound(prog->aux)) {
> >               err =3D bpf_prog_dev_bound_init(prog, attr);
> > --
> > 2.34.1
> >

