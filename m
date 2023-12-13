Return-Path: <bpf+bounces-17717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B21811EAF
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 20:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04567B21302
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183B367B71;
	Wed, 13 Dec 2023 19:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d9gN500I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E9FE3
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:18:33 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54c67b0da54so9365821a12.0
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 11:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702495112; x=1703099912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c907SHeGzX0MsfR7OmnH375FWS40vxU7pWbGCUtY+I0=;
        b=d9gN500IMK/d2MRi7WUpPPp2hdTDQqNnnCLMu2L+P97yySATDAFnKM3ElyBcBXO+NT
         ckg7/Q95nyvVaBIafI9hNfsgZZejSRr9DIeVg33WAVlVSlIbaJ1+XgSMsGTfKUDDjXXv
         sA2KTBIRzQWLj8o0Yg1sz6MLy0GJ/aUGmZagYKDt8oAKTA1Z2Qfb0n0aEDSvzIJto+qY
         yEAKQSNe5L2KEwmD1VBQ9xSvxoT3wMP4lqDe8MnBiXaABWoJ9e75+eGkJ23GsUsqyJ1I
         LjeuUfFZedTTurqLpJdeTo2TbMc0l+EnT4RxaV/ohB36ShJuTf/NTYfJ7uP8hFmDNrnK
         mXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702495112; x=1703099912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c907SHeGzX0MsfR7OmnH375FWS40vxU7pWbGCUtY+I0=;
        b=W5gb5faZup/H4MUNQCV49+cGEW7IlIZEY1HLDLYkRp7Qg24cMqQA70XvkQeW2NUZrH
         TGKcwLFWoYI4ZJSS07sfiM845BVrScRnoq5/Eehev9o4q3OxRbs09Gg64z7cTf3kHNdk
         ljcDsMQX7C3CIjppJz10zcAf1Tyno8X6Qp3nzOkyu0tk0MOCpY1D8b6QZTIG4cnKlQ8a
         MaQTslRulh7M100SgsWS0odtWCRExObehVnR/H3W+7NySl2VGCZQHaepqEYRNWYX8bqL
         Bl3ulsykHDyQn2QyktIRNrGqH8uQBrFVipq6kW79tSn2tsTOEAZQiIc9Bx+BD9CSyaA/
         2niw==
X-Gm-Message-State: AOJu0YwX9qpNZm9WthH0f0lINY0KL/YkUx/idfzVwEX1xPAW4Sw12jrP
	i/oqa5BaaOc/xCATWXbLvlojI4Af2udjSkeFxEk=
X-Google-Smtp-Source: AGHT+IE1eqPuaFPnj3NlcHOkdGaXvHRfhFz1qaP4URZeqly1zVzZtLCOdLOf4n0rVMWrgt7UGOV47kzXIbyzxSIbVy4=
X-Received: by 2002:a17:907:1ca0:b0:a0c:fe2f:c445 with SMTP id
 nb32-20020a1709071ca000b00a0cfe2fc445mr4580398ejc.69.1702495111941; Wed, 13
 Dec 2023 11:18:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212232535.1875938-1-andrii@kernel.org> <20231212232535.1875938-7-andrii@kernel.org>
 <bb0885d8a86c2b03be918ef506466e6a2f90f294.camel@gmail.com>
In-Reply-To: <bb0885d8a86c2b03be918ef506466e6a2f90f294.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Dec 2023 11:18:19 -0800
Message-ID: <CAEf4BzYMkTouSBADH8x6Xx8DRYRtkFUOxG6cmGEa4rpi2xUZAg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/10] bpf: support 'arg:xxx'
 btf_decl_tag-based hints for global subprog args
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 9:43=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2023-12-12 at 15:25 -0800, Andrii Nakryiko wrote:
> > Add support for annotating global BPF subprog arguments to provide more
> > information about expected semantics of the argument. Currently,
> > verifier relies purely on argument's BTF type information, and supports
> > three general use cases: scalar, pointer-to-context, and
> > pointer-to-fixed-size-memory.
> >
> > Scalar and pointer-to-fixed-mem work well in practice and are quite
> > natural to use. But pointer-to-context is a bit problematic, as typical
> > BPF users don't realize that they need to use a special type name to
> > signal to verifier that argument is not just some pointer, but actually
> > a PTR_TO_CTX. Further, even if users do know which type to use, it is
> > limiting in situations where the same BPF program logic is used across
> > few different program types. Common case is kprobes, tracepoints, and
> > perf_event programs having a helper to send some data over BPF perf
> > buffer. bpf_perf_event_output() requires `ctx` argument, and so it's
> > quite cumbersome to share such global subprog across few BPF programs o=
f
> > different types, necessitating extra static subprog that is context
> > type-agnostic.
> >
> > Long story short, there is a need to go beyond types and allow users to
> > add hints to global subprog arguments to define expectations.
> >
> > This patch adds such support for two initial special tags:
> >   - pointer to context;
> >   - non-null qualifier for generic pointer arguments.
> >
> > All of the above came up in practice already and seem generally useful
> > additions. Non-null qualifier is an often requested feature, which
> > currently has to be worked around by having unnecessary NULL checks
> > inside subprogs even if we know that arguments are never NULL. Pointer
> > to context was discussed earlier.
> >
> > As for implementation, we utilize btf_decl_tag attribute and set up an
> > "arg:xxx" convention to specify argument hint. As such:
> >   - btf_decl_tag("arg:ctx") is a PTR_TO_CTX hint;
> >   - btf_decl_tag("arg:nonnull") marks pointer argument as not allowed t=
o
> >     be NULL, making NULL check inside global subprog unnecessary.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
>
> > @@ -6846,7 +6846,35 @@ int btf_prepare_func_args(struct bpf_verifier_en=
v *env, int subprog)
> >        * Only PTR_TO_CTX and SCALAR are supported atm.
> >        */
> >       for (i =3D 0; i < nargs; i++) {
> > +             bool is_nonnull =3D false;
> > +             const char *tag;
> > +
> >               t =3D btf_type_by_id(btf, args[i].type);
> > +
> > +             tag =3D btf_find_decl_tag_value(btf, fn_t, i, "arg:");
> > +             if (IS_ERR(tag) && PTR_ERR(tag) =3D=3D -ENOENT) {
> > +                     tag =3D NULL;
> > +             } else if (IS_ERR(tag)) {
> > +                     bpf_log(log, "arg#%d type's tag fetching failure:=
 %ld\n", i, PTR_ERR(tag));
> > +                     return PTR_ERR(tag);
> > +             }
> > +             /* 'arg:<tag>' decl_tag takes precedence over derivation =
of
> > +              * register type from BTF type itself
> > +              */
> > +             if (tag) {
> > +                     /* disallow arg tags in static subprogs */
> > +                     if (!is_global) {
> > +                             bpf_log(log, "arg#%d type tag is not supp=
orted in static functions\n", i);
> > +                             return -EOPNOTSUPP;
> > +                     }
> > +                     if (strcmp(tag, "ctx") =3D=3D 0) {
> > +                             sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
> > +                             continue;
>
> Nit: personally, I'd keep tags parsing and processing logically separate:
>      - at this point set a flag 'is_ctx'
>      - and modify the check below as follows:
>
>                 if (is_ctx || (btf_type_is_ptr(t) && btf_get_prog_ctx_typ=
e(log, btf, t, prog_type, i))) {
>                         sub->args[i].arg_type =3D ARG_PTR_TO_CTX;
>                         continue;
>                 }
>
>      So that there is only one place where ARG_PTR_TO_CTX is assigned.
>      Feel free to ignore.

I think it's actually more convoluted and error-prone with the is_ctx
flag. Tag is overriding whatever BTF type information we have. But if
we delay ARG_PTR_TO_CTX setting to later, we need to make sure that
post-tag BTF processing is aware of is_ctx (and potentially other)
flags and doesn't freak out. We might add more BTF processing before
ARG_PTR_TO_CTX, etc. Having to worry about not overriding tag-based
decisions seems very error-prone.

Also, btf_prepare_func_args() really simplifies the "definition" of an
argument to one enum (and in some cases maybe an extra argument like
memory size). It should be fine to just set this enum in two places
separately, doesn't seem like a hindrance for maintainability.

>
> [...]
>
>

