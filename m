Return-Path: <bpf+bounces-16908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F44B80775E
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 19:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7A81C20CF6
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639226E5A2;
	Wed,  6 Dec 2023 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeR9OxSR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5DAD4B
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 10:16:07 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-a1d93da3eb7so4532366b.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 10:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701886565; x=1702491365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaDokhwANjwXHmyhh8zlipN/14CqK0CCIeJH5UsXR90=;
        b=OeR9OxSRsdOI3ZDPrIrR1jgotM1jLfZTP2v1Ew+RqPG1k7jQkXsPq/raa+08EJuVpZ
         xPgNOWCy1yfouBTwMSUarniuqTpw4ThSy/+tdLXAdQ+y26Hz5I0rkKONpvFQzLEpZSe5
         Z93+pwTEOp5+FqX9nwajzcGtafMl+Mi8/BK6YNPzkl1rx5ZCKq7iuIlXvJBmg7HHG3tz
         kEQ7NkmtEK7qEssXv2EVcYFshaPQhHJXC9jUyd9IJ2B8mS52gRKAYaXGKU9wZG1XI2zx
         K7BZHbUPOq2Wkk3tDn2BD324Nb6eB08e49VzURaQtpKeDI7AILt399c577NgRubwpJvj
         Dmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701886565; x=1702491365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaDokhwANjwXHmyhh8zlipN/14CqK0CCIeJH5UsXR90=;
        b=XqovIpWUTQLFQ5WKusiO7OEREXFlH0bxHIl0FsIkdfCdIcXIME0Fdv0OE1Eby36LR4
         dmsykHcvLZEYU1mH6oXYugcun1fG+4OiF5CGo9uVKP+TjFK6TF4r26kEhjyisPfBZjxT
         Z1VueGzfevqnj3w1zHIoF6xcIBskC4KF3y/GaYAi3+2hsL2PfQkDITDW3QFiVWvJBqEo
         5zQ0z4xHbaLkXgxwIam/Dp+TXE1uJiosGeJO/N9s6ca3RBE47dhKZmyrKLrLG+HaR+8z
         mmJRP+HorsB7v2io0wDiJSJmal9dUYEGdILaGAMfACqsB8IkQJj511g8cZCfPlKnOGYr
         2wCQ==
X-Gm-Message-State: AOJu0Yxk/qM2urhpbHbD+IDkkyvtU0xAaqZNegO4UmvXSnodrs7cWJCh
	IyS6sWgyhsnMlFsAnPcZf3+q7Nhb2YSKLDMdYys=
X-Google-Smtp-Source: AGHT+IHbpSiNOCWxTEKBTOPVHhWVjwipQyKv1UgV0CUy7zbDXmffOa0isZX/m4eyRW7iW6im9cMaGNMx3xGFdQcUNqg=
X-Received: by 2002:a17:906:34cd:b0:a19:a1ba:8cd1 with SMTP id
 h13-20020a17090634cd00b00a19a1ba8cd1mr804140ejb.111.1701886565458; Wed, 06
 Dec 2023 10:16:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204233931.49758-1-andrii@kernel.org> <20231204233931.49758-11-andrii@kernel.org>
 <fc790a1fd70a4159c6d73b953088ec2beb97f48b.camel@gmail.com>
In-Reply-To: <fc790a1fd70a4159c6d73b953088ec2beb97f48b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 10:15:52 -0800
Message-ID: <CAEf4BzaVqN726rWmuC+-ZzSmWg+9yxTZR=JgWMPWfgD=cKzv+Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/13] bpf: support 'arg:xxx' btf_decl_tag-based
 hints for global subprog args
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 3:22=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:
> [...]
>
> > @@ -6845,7 +6845,47 @@ int btf_prepare_func_args(struct bpf_verifier_en=
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
>
> Nit: this does a linear scan over all BTF type ids for each
>      function parameter, which is kind of ugly.

I know, so it's a good thing I added caching, right? :) I'm just
reusing existing code, though. It also errors out on having two
matching tags with the same prefix, which for now is good enough, but
we'll probably have to lift this restriction.

As for linear search. This might be fine, BPF program's BTF is
generally much smaller than vmlinux's BTF, and it's not clear if
building hashmap-based lookup for tags is worthwhile. For now it works
well enough, so there is little motivation to get this improved.

>
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
>
> Nit: this would be annoying if someone would add/remove 'static' a few
>      times while developing BPF program. Are there safety reasons to
>      forbid this?

I'm just trying to not introduce unintended interactions between arg
tags and static functions, which basically can freely ignore BTF at
verification time, as they don't need BTF info for correctness. If in
the future we add tags support for static functions, I'd like to have
a clean slate instead of worrying for backwards compat.

>
> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5787b7fd16ba..61e778dbde10 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9268,9 +9268,30 @@ static int btf_check_func_arg_match(struct bpf_v=
erifier_env *env, int subprog,
> >                       ret =3D check_func_arg_reg_off(env, reg, regno, A=
RG_DONTCARE);
> >                       if (ret < 0)
> >                               return ret;
> > -
> >                       if (check_mem_reg(env, reg, regno, arg->mem_size)=
)
> >                               return -EINVAL;
> > +                     if (!(arg->arg_type & PTR_MAYBE_NULL) && (reg->ty=
pe & PTR_MAYBE_NULL)) {
> > +                             bpf_log(log, "arg#%d is expected to be no=
n-NULL\n", i);
> > +                             return -EINVAL;
> > +                     }
> > +             } else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_META) {
> > +                     if (reg->type !=3D PTR_TO_PACKET_META) {
> > +                             bpf_log(log, "arg#%d expected pkt_meta, b=
ut got %s\n",
> > +                                     i, reg_type_str(env, reg->type));
> > +                             return -EINVAL;
> > +                     }
> > +             } else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_DATA) {
> > +                     if (reg->type !=3D PTR_TO_PACKET) {
>
> I think it is necessary to check that 'reg->umax_value =3D=3D 0'.
> check_packet_access() uses reg->umax_value to bump
> env->prog->aux->max_pkt_offset. When body of a global function is
> verified it starts with 'umax_value =3D=3D 0'.
> Might be annoying from usability POV, however.

I'm not even sure what we are using this max_pkt_offset for? I see
that verifier is maintaining it, but I don't see it being checked...
Seems like when we have tail calls we even set it to MAX_PACKET_OFF
unconditionally...

This PKT_xxx business is a very unfamiliar territory for me, so I hope
Martin and/or Alexei can chime in and suggest how to make global funcs
safe to work with packet pointers without hurting usability.

>
> > +                             bpf_log(log, "arg#%d expected pkt, but go=
t %s\n",
> > +                                     i, reg_type_str(env, reg->type));
> > +                             return -EINVAL;
> > +                     }
> > +             } else if (arg->arg_type =3D=3D ARG_PTR_TO_PACKET_END) {
> > +                     if (reg->type !=3D PTR_TO_PACKET_END) {
> > +                             bpf_log(log, "arg#%d expected pkt_end, bu=
t got %s\n",
> > +                                     i, reg_type_str(env, reg->type));
> > +                             return -EINVAL;
> > +                     }
> >               } else {
> >                       bpf_log(log, "verifier bug: unrecognized arg#%d t=
ype %d\n",
> >                               i, arg->arg_type);
>
> [...]
>
>

