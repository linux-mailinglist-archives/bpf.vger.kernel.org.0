Return-Path: <bpf+bounces-16905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A4780772F
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 18:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77D411C20AA4
	for <lists+bpf@lfdr.de>; Wed,  6 Dec 2023 17:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C261C6DD1D;
	Wed,  6 Dec 2023 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibYzif7z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9360D139
	for <bpf@vger.kernel.org>; Wed,  6 Dec 2023 09:59:50 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a1ca24776c3so229153966b.0
        for <bpf@vger.kernel.org>; Wed, 06 Dec 2023 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701885589; x=1702490389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k558YC7JeJmsjtY4IaxnWs9BllVSFtbJOS4dbBqMzu4=;
        b=ibYzif7zAMIrLP4G8nZS40gg64Sx6hdHtjOLz+GPbTIo8MZc4JkgKhm2MyyjX/yKsG
         OoX+mLGIXJE31hZhCfqIb2ww+NNnjSicJiIVhljJ5KqZeuPWDOp18HfeJIULHKxhOC6u
         FzjS+j3dKyO0oe+zMX2fwW6FRO3RDY0NC/61VTVhilcRXU8Er1EBwCJV3J4ycuB3VZ9j
         PyZBY+gtiymZE9jy0RGFdvNeUif+ABw8kEio0FRHk4CIN5b2WSLbO5CGh+qSh2RAd7+s
         018UtCj5dppcZawqS2LuOxnTSYY5sCGgUtSMzPwPfuq6jsvPl0sc42eDlKSsFDYUu6uU
         1a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701885589; x=1702490389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k558YC7JeJmsjtY4IaxnWs9BllVSFtbJOS4dbBqMzu4=;
        b=bNw9cdxbIG0LAg/Sp+wsWNJb2CK/e7pY81eozRV7t5nHdDbGKtfoUW4899y+FuS2eL
         twj2R7dUmVx7CawPPM1BQUxhECmro9UMbVldNWgbeMSBxUJ1c2sFA9/sMxpCoCUChKIW
         L07Shtqhjw3Wmxdz1WUm6tJWUKYoGAWPKTr2LxkWbgjlCaZ/geXmDeTKhghVxBUIk/7N
         x3eKI596bIGn1FECTYom7KJ6KWGJsCM0XyvPjccoc1YYBAJBFRQEUoiplmW2pG0eJzaT
         Oibw7NpLMKH5gMbELqaG/wFSAZNjki62gn4u37SehZAnIOxRYe7yV5Zq+rWGqAkS4iMP
         kbtg==
X-Gm-Message-State: AOJu0YwICsV/6ZtnyogVsrZDsQRVcddMhPFnzel1610O4vxok4JmQ5+b
	67pXQK4ucsaLQrpgsYMQXCL+XJyRHVU/U9hBeXs=
X-Google-Smtp-Source: AGHT+IGOx12Q+aI22D2ah1rFLn/4653FxPDcfZGKQ7U6zCjua2U/yBm0DaVgEolZryEnE8esvfbGS41eE51PJ6X4Mvs=
X-Received: by 2002:a17:906:1083:b0:a1d:b9d2:2af0 with SMTP id
 u3-20020a170906108300b00a1db9d22af0mr1182434eju.1.1701885588838; Wed, 06 Dec
 2023 09:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204233931.49758-1-andrii@kernel.org> <20231204233931.49758-6-andrii@kernel.org>
 <cfea7e70b26e7b11c989d162c2217f5fb3e13b0b.camel@gmail.com>
In-Reply-To: <cfea7e70b26e7b11c989d162c2217f5fb3e13b0b.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 6 Dec 2023 09:59:36 -0800
Message-ID: <CAEf4BzbjTz3mFJLCfsnfwBd2RmZssopMLjGpAUC7NW_gQmMKVA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/13] bpf: abstract away global subprog arg
 preparation logic from reg state setup
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 3:21=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2023-12-04 at 15:39 -0800, Andrii Nakryiko wrote:
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>
> [...]
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 379ac0a28405..c3a5d0fe3cdf 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -704,6 +704,7 @@ enum bpf_arg_type {
> >
> >       ARG_PTR_TO_CTX,         /* pointer to context */
> >       ARG_ANYTHING,           /* any (initialized) argument is ok */
> > +     ARG_SCALAR =3D ARG_ANYTHING, /* scalar value */
>
> Nit: I agree that use of ARG_ANYTHING to denote scalars is confusing,
>      but having two names for the same thing seems even more confusing.
>

fair enough, I was undecided on this, I'll revert and use ARG_ANYTHING for =
now

> [...]
>
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index d56433bf8aba..33a62df9c5a8 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6955,9 +6955,9 @@ int btf_check_subprog_call(struct bpf_verifier_en=
v *env, int subprog,
> >   * 0 - Successfully converted BTF into bpf_reg_state
> >   * (either PTR_TO_CTX or SCALAR_VALUE).
> >   */
> > -int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog,
> > -                       struct bpf_reg_state *regs, u32 *arg_cnt)
> > +int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
>
> Could you please also update the comment above this function?
> It currently says: "Convert BTF of a function into bpf_reg_state if possi=
ble".
>

absolutely, will do

> [...]
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index ee707736ce6b..16d5550eda4d 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> [...]
> > @@ -19860,33 +19855,44 @@ static int do_check_common(struct bpf_verifie=
r_env *env, int subprog)
> [...]
> >               for (i =3D BPF_REG_1; i <=3D BPF_REG_5; i++) {
> > -                     if (regs[i].type =3D=3D PTR_TO_CTX)
> > +                     arg =3D &sub->args[i - BPF_REG_1];
> > +                     reg =3D &regs[i];
> > +
> > +                     if (arg->arg_type =3D=3D ARG_PTR_TO_CTX) {
> > +                             reg->type =3D PTR_TO_CTX;
> >                               mark_reg_known_zero(env, regs, i);
> > -                     else if (regs[i].type =3D=3D SCALAR_VALUE)
> > +                     } else if (arg->arg_type =3D=3D ARG_SCALAR) {
> > +                             reg->type =3D SCALAR_VALUE;
> >                               mark_reg_unknown(env, regs, i);
> > -                     else if (base_type(regs[i].type) =3D=3D PTR_TO_ME=
M) {
> > -                             const u32 mem_size =3D regs[i].mem_size;
> > -
> > +                     } else if (base_type(arg->arg_type) =3D=3D ARG_PT=
R_TO_MEM) {
> > +                             reg->type =3D PTR_TO_MEM;
> > +                             if (arg->arg_type & PTR_MAYBE_NULL)
> > +                                     reg->type |=3D PTR_MAYBE_NULL;
> >                               mark_reg_known_zero(env, regs, i);
> > -                             regs[i].mem_size =3D mem_size;
> > -                             regs[i].id =3D ++env->id_gen;
> > +                             reg->mem_size =3D arg->mem_size;
> > +                             reg->id =3D ++env->id_gen;
> >                       }
>
> Nit: maybe add an else branch here and report an error if unexpected
>      argument type is returned by btf_prepare_func_args()?

true, not sure why I didn't do it here, adding...

>
>

