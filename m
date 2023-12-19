Return-Path: <bpf+bounces-18258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F9817FF7
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 03:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4927E285BEB
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 02:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E001842;
	Tue, 19 Dec 2023 02:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6WU3MDQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E64409
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a22deb95d21so468698966b.3
        for <bpf@vger.kernel.org>; Mon, 18 Dec 2023 18:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702954492; x=1703559292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDE/qsx0FCLuGZKDhgjn6yONIfanZgWHSlqjLkYk88w=;
        b=E6WU3MDQgp6hWIHbmQecG9zUXIql6iSIU9Gn+8o38q286YMkLjn6mWJOOrZLqionho
         jyXwup9Xs9I0t1L1aNBi08T1aVPP+poxrNeQ4o/JAw11TEn7TILsYtYfKv44+FG+yBoN
         9nSPxhomRrUPfB5RjtGfNsxWiWRL+7su5UU4iUsGnGUZum6Ce5ENKehhomoFLNtWKFdO
         xZXhKFC19RrfAm1zx8GloXLdTS0iiHMucGvyDCOjYyqrecBYwgfiXty+EG+wIMLUv/U8
         PZ3nTpNfTA96JWZscnaJuly5hxyyhRZ7aRS27FR0Er45c4ZtSTQwiUx9cQbcJQQ5Mhge
         vxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702954492; x=1703559292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDE/qsx0FCLuGZKDhgjn6yONIfanZgWHSlqjLkYk88w=;
        b=iYPUIEiX72BqL0JBB4xc3YcAuYgpnh0G31TfnKLQ5XbVKKG9WbwS6JbqWOMDPDQcIq
         /YqAEg7XIaC6NK9JKcVcPUHp1u5QQ822YW+hPyQBeOTTfBfXWIm2ZR1fdKd2Mh8QDB+f
         yvxweDOWZ0eFQcvIwAQD27/S3tNPmJJOzOmm4qBVWbi3CnKJ/v1ANB79YHUD+55vdyQB
         Ku0w6z4QIeDzrkIdBBMPHpGBw8F1UT9Pt/NHU9Bjoy7Icj/PsX/XCB7G6SuR/8fuRKVg
         jhHLoZG5ELpZTROPzALJhRjkk1MTMgROrvq4dulxKPo4JTD7d3TZNOwXc3ZBlUMLur5B
         qvqQ==
X-Gm-Message-State: AOJu0Yxtp4KIhwnsQthEHRGC2s2fb6Q90Jo/Sx4FGI/fYcsjmgrbZP9j
	nJUEJGCxUeFkWn17Y+QabXJdM+LAKc4wDWfOOLvf56280qsFlg==
X-Google-Smtp-Source: AGHT+IHG/ws8pw3eQfEox3au9Jx5MA1SLpL29SDtHftoR81cG1pJQOE1KayagqJ+r8q+83xK+uyruPp5HOk/d5+ohE0=
X-Received: by 2002:a17:906:518d:b0:a23:7625:4cd3 with SMTP id
 y13-20020a170906518d00b00a2376254cd3mr114622ejk.142.1702954491828; Mon, 18
 Dec 2023 18:54:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217010649.577814-1-andreimatei1@gmail.com>
 <20231217010649.577814-2-andreimatei1@gmail.com> <658b22003f90e066ba7d6585aa444c3e401ff0ac.camel@gmail.com>
In-Reply-To: <658b22003f90e066ba7d6585aa444c3e401ff0ac.camel@gmail.com>
From: Andrei Matei <andreimatei1@gmail.com>
Date: Mon, 18 Dec 2023 21:54:40 -0500
Message-ID: <CABWLseu+uALXXwaSGJ=zJhoZuWH3Lajby-ip8oKAmTOLxci7Vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf: Simplify checking size of helper accesses
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, andrii.nakryiko@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:04=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Sat, 2023-12-16 at 20:06 -0500, Andrei Matei wrote:
> [...]
>
> > (*) Besides standing to reason that the checks for a bigger size access
> > are a super-set of the checks for a smaller size access, I have also
> > mechanically verified this by reading the code for all types of
> > pointers. I could convince myself that it's true for all but
> > PTR_TO_BTF_ID (check_ptr_to_btf_access). There, simply looking
> > line-by-line does not immediately prove what we want. If anyone has any
> > qualms, let me know.
>
> check_help_mem_access() is a bit obfuscated :)
> After staring at it for a bit I have a question regarding
> check_ptr_to_btf_access():
> - it can call btf_struct_access(),
>   which in can call btf_struct_walk(),
>   which has the following check:
>
>                 if (btf_type_is_ptr(mtype)) {
>                         const struct btf_type *stype, *t;
>                         enum bpf_type_flag tmp_flag =3D 0;
>                         u32 id;
>
>                         if (msize !=3D size || off !=3D moff) {
>                                 bpf_log(log,
>                                         "cannot access ptr member %s with=
 moff %u in struct %s with off %u size %u\n",
>                                         mname, moff, tname, off, size);
>                                 return -EACCES;
>                         }
>
> - previously this code was executed twice, for size 0 and for size
>   umax_value of the size register;
> - now this code is executed only for umax_value of the size register;
> - is it possible that with size 0 this code could have reported error
>   -EACCESS error, which would be missed now?

I don't have a good answer. I too have looked at check_ptr_to_btf_access() =
and
ended up confused -- but then again, I don't know what's supposed to be all=
owed
and what's supposed to not be allowed. I will say, though, that I don't thi=
nk
the code as it stands make sense, and I don't think any interaction between=
 the
zero-size check and btf access is intentional. Around [1] we've looked a bi=
t at
the history of this zero-size check, and it's been there forever, predating
most of the code around it. What convinces me personally that the zero-size
check was not load-bearing is the fact that we were only performing
the check iff
umin =3D=3D 0 -- we were not consistently performing a check for the umin v=
alue.
Also, obviously, we were not performing a check for every possible value in
between umin and umax. So I can't really imagine positive benefits of the
inconsistent check we were doing. But then again, I cannot actually speak w=
ith
confidence about it.

As a btw, I'll say that we don't allow variable-offset accesses to btf ptr =
[2].
I don't know if this should influence how we treat the access size... but
maybe? Like, should we disallow variable-sized accesses on the same argumen=
t as
disallowing variable-offset ones (whatever that argument may be)? I don't k=
now
what I'm talking about (generally BTF is foreign to me), but I imagine this=
 all
means that currently the verifier allows one to read from an array field by
starting at a compile-time constant offset, and extending to a variable siz=
e.
However, you cannot start from an arbitrary offset, though. Does this
combination of being strict about the offset but permissive about the size =
make
sense?

I'll take guidance. If people prefer we don't touch this code at all, that'=
s
fine. Although it doesn't feel good to be driven simply by fear.


[1] https://lore.kernel.org/bpf/CAP01T77M=3DSyNviMYCO-koxizvD6eGm=3D5KQ1Wv=
=3DahbRU5XQB4bA@mail.gmail.com/
[2] https://github.com/torvalds/linux/blob/ee5cc0363ea0d587f62349ff3b3e2dfa=
751832e4/kernel/bpf/verifier.c#L3318-L3326

>
> Except for the question above I don't see any issues,
> but check_help_mem_access() has many sub-cases,
> so I might have missed something.
>
> Also a few nits below.
>
> [...]
>
> > @@ -7256,6 +7256,65 @@ static int check_helper_mem_access(struct bpf_ve=
rifier_env *env, int regno,
> >       }
> >  }
> >
> > +/* Helper function for logging an error about an invalid attempt to pe=
rform a
> > + * (possibly) zero-sized memory access. The pointer being dereferenced=
 is in
> > + * register @ptr_regno, and the size of the access is in register @siz=
e_regno.
> > + * The size register is assumed to either be a constant zero or have a=
 zero lower
> > + * bound.
> > + *
> > + * Logs a message like:
> > + * invalid zero-size read. Size comes from R2=3D0. Attempting to deref=
erence *map_value R1: off=3D[0,4] value_size=3D48
> > + */
> > +static void log_zero_size_access_err(struct bpf_verifier_env *env,
> > +                           int ptr_regno,
> > +                           int size_regno)
> > +{
> > +     struct bpf_reg_state *ptr_reg =3D &cur_regs(env)[ptr_regno];
> > +     struct bpf_reg_state *size_reg =3D &cur_regs(env)[size_regno];
> > +     const bool size_is_const =3D tnum_is_const(size_reg->var_off);
> > +     const char *ptr_type_str =3D reg_type_str(env, ptr_reg->type);
> > +     /* allocate a few buffers to be used as parts of the error messag=
e */
> > +     char size_range_buf[64] =3D {0}, max_size_buf[64] =3D {0}, off_bu=
f[64] =3D {0};
> > +     s64 min_off, max_off;
>
> Nit: empty is needed here
>
> [...]
>
> >  /* verify arguments to helpers or kfuncs consisting of a pointer and a=
n access
> >   * size.
> >   *
> > @@ -7268,6 +7327,7 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
> >                             struct bpf_call_arg_meta *meta)
> >  {
> >       int err;
> > +     const bool size_is_const =3D tnum_is_const(reg->var_off);
>
> Nit: please swap definitions to get the "reverse Christmas tree":
>
>     const bool size_is_const =3D tnum_is_const(reg->var_off);
>     int err;
>
> >
> >       /* This is used to refine r0 return value bounds for helpers
> >        * that enforce this value as an upper bound on return values.
> > @@ -7282,7 +7342,7 @@ static int check_mem_size_reg(struct bpf_verifier=
_env *env,
> >       /* The register is SCALAR_VALUE; the access check
> >        * happens using its boundaries.
> >        */
> > -     if (!tnum_is_const(reg->var_off))
> > +     if (!size_is_const)
> >               /* For unprivileged variable accesses, disable raw
> >                * mode so that the program is required to
> >                * initialize all the memory that the helper could
> > @@ -7296,12 +7356,9 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >               return -EACCES;
> >       }
> >
> > -     if (reg->umin_value =3D=3D 0) {
> > -             err =3D check_helper_mem_access(env, regno - 1, 0,
> > -                                           zero_size_allowed,
> > -                                           meta);
> > -             if (err)
> > -                     return err;
> > +     if (reg->umin_value =3D=3D 0 && !zero_size_allowed) {
> > +             log_zero_size_access_err(env, regno-1, regno);
> > +             return -EACCES;
> >       }
> >
> >       if (reg->umax_value >=3D BPF_MAX_VAR_SIZ) {
> > @@ -7309,9 +7366,21 @@ static int check_mem_size_reg(struct bpf_verifie=
r_env *env,
> >                       regno);
> >               return -EACCES;
> >       }
> > +     /* If !zero_size_allowed, we already checked that umin_value > 0,=
 so
> > +      * umax_value should also be > 0.
> > +      */
> > +     if (reg->umax_value =3D=3D 0 && !zero_size_allowed) {
> > +             verbose(env, "verifier bug: !zero_size_allowed should hav=
e been handled already\n");
> > +             return -EFAULT;
> > +     }
> >       err =3D check_helper_mem_access(env, regno - 1,
> >                                     reg->umax_value,
> > -                                   zero_size_allowed, meta);
> > +                                   /* zero_size_allowed: we asserted a=
bove that umax_value is
> > +                                    * not zero if !zero_size_allowed, =
so we don't need any
> > +                                    * further checks.
> > +                                    */
> > +                                   true ,
>                           ^
> Nit: extra space ---------'
>
> > +                                   meta);
> >       if (!err)
> >               err =3D mark_chain_precision(env, regno);
> >       return err;
>
> [...]

