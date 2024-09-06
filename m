Return-Path: <bpf+bounces-39180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B14396FE0D
	for <lists+bpf@lfdr.de>; Sat,  7 Sep 2024 00:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CE8282C55
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 22:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AD615AD83;
	Fri,  6 Sep 2024 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fX8pxdik"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC7A158D8D
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725662194; cv=none; b=O5SnA/4E5m81dhnc13YUV27FSkiNskqHAUAJ4VyvSqKPkRba9NVYL/DDTNkyGpaT5K7b1eqSBYp4JLK8WjFNtUvZ2RS5ZDoualyYEtMZd8RiE39ITVE30dNITrCECvKqLsmJP3eT83YCBUqT0fb6AgccU0OhwHAPO9z3EpxB2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725662194; c=relaxed/simple;
	bh=2mK94rX0kSrSdf1/fL58D5LFLEaCsnTLyXJXSvRUqdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yd05V++vgoHgrao1s+WWGos1jQfLQlG0yDaaUZ+1gBPe7Q1ya71A1R+b7WQ0XBLCs5C1Gw8tCDPOuX5kYmsLxaWlVLNQBw/PgP4X3BlMm7GOFO0ZV6OIZFPJ1nvD7p9FTxOEaV88J/7Gf4qS5zCzdjmPbWSQcIUXFsjqpzfcOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fX8pxdik; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cae102702so906145e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 15:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725662190; x=1726266990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUWUbkwpmi+eo3fBSK1L4otkZpJzTtxNJsQUhhidpCU=;
        b=fX8pxdikk8Sbf1Rf3R7jUporze1WfREW+YMsyu1YvwzPIyqeQj6fOPM4iozOAqsop1
         c6TiXMABmooNzjkykBpYL1QOorT1koanGt3JwEnPMc4/eqdPISdIcNITiSmZpbbQIOno
         gaY+juXkQwYVmKwvEOhnO1Xy1r1IszeRUJq/UscKd6g7xVg3U9K6jSZtrUYHhO/CNkQL
         FraxzM0EkJjJzlyu8RoTKPjTYDQlxG6ny/VaxTT2YLOukWhNsdjgVWE/MgwFFjdEOxgQ
         oMD7+DitFzY5Wg+GH8u3sdH/G2qfW8qpnt/0EhYIBAL3K+GlcvfFkj3+DPy91seHrsMI
         tDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725662190; x=1726266990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUWUbkwpmi+eo3fBSK1L4otkZpJzTtxNJsQUhhidpCU=;
        b=eY2Z4IrtAHOFnrdPuM5VFPsRd3/yydt0qUCuA3C3cXoe4L6U4iTA+O33CavKom93BJ
         eIDMp+XpdT0lArF4V3m8wJpTI1mmdifC3L1u4tufzB+qqRDx0chQKnrECZIxu06zLZyA
         /FCpulONSdzlAwZ0UqFu9MkZjekHkI9ISImtXbF1kt5ZWCZMl6l2O49a72LwlH7tnfaq
         XxSHrLUSTWO1pz5Il3Q2qSnh2q8z43G6jWZiO+8bDt67jfsG4kOAWKGJXBK4zbPTOCHF
         pMpYgiHpJ6cNpWn1FCT09XDPWTxdBnY+p1n2np+JZcCBMCXeIgGwot58bigh3/96RFRx
         2n6g==
X-Forwarded-Encrypted: i=1; AJvYcCUjHGFW07loJebDVrA8rffh+SAk3O1EYBPlieCWb4fqRNyTW673xADtuTn2tImfrGe+o1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YysFvwB/lBaqG7azy/F9thbmpPSbK+XTIg5aLtJ6NHEJcCjN0Dw
	98zWNLbgBeEspH7sq+CexYxRdsxX9nNHYPPCYn6t0VaaKZbP7ghydA/ouX5FDMGDsBoglIbL1W/
	ii9yTW7B+YY3dVAW78ukMXshxIcoE1g==
X-Google-Smtp-Source: AGHT+IGAVmqHmEnKLZDb4LwWUqdAOQG5NLf0cJHhD+4epyXMitN/2Uz58fc3REOqX2kaxZ7rXZ4NXdm7cweFMejPc1A=
X-Received: by 2002:a05:600c:c8b:b0:42c:a7cc:cb6d with SMTP id
 5b1f17b1804b1-42cae70a2a8mr932635e9.1.1725662190096; Fri, 06 Sep 2024
 15:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906135608.26477-1-daniel@iogearbox.net> <20240906135608.26477-3-daniel@iogearbox.net>
 <CAEf4Bzag4+pNTuYjqLRN9x+bNe_6o=hv+PSkxwh2VKUhMqzpAQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzag4+pNTuYjqLRN9x+bNe_6o=hv+PSkxwh2VKUhMqzpAQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Sep 2024 15:36:19 -0700
Message-ID: <CAADnVQ+P6f67hJq+12sp1L6_+-XaduaWRVTPRFyz+tnpE7D4Pg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] bpf: Fix helper writes to read-only maps
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, kongln9170@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 2:03=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 6, 2024 at 6:56=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
> >
> > Lonial found an issue that despite user- and BPF-side frozen BPF map
> > (like in case of .rodata), it was still possible to write into it from
> > a BPF program side through specific helpers having ARG_PTR_TO_{LONG,INT=
}
> > as arguments.
> >
> > In check_func_arg() when the argument is as mentioned, the meta->raw_mo=
de
> > is never set. Later, check_helper_mem_access(), under the case of
> > PTR_TO_MAP_VALUE as register base type, it assumes BPF_READ for the
> > subsequent call to check_map_access_type() and given the BPF map is
> > read-only it succeeds.
> >
> > The helpers really need to be annotated as ARG_PTR_TO_{LONG,INT} | MEM_=
UNINIT
> > when results are written into them as opposed to read out of them. The
> > latter indicates that it's okay to pass a pointer to uninitialized memo=
ry
> > as the memory is written to anyway.
> >
> > However, ARG_PTR_TO_{LONG,INT} is a special case of ARG_PTR_TO_FIXED_SI=
ZE_MEM
> > just with additional alignment requirement. So it is better to just get
> > rid of the ARG_PTR_TO_{LONG,INT} special cases altogether and reuse the
> > fixed size memory types. For this, add MEM_ALIGNED to additionally ensu=
re
> > alignment given these helpers write directly into the args via *<ptr> =
=3D val.
> > The .arg*_size has been initialized reflecting the actual sizeof(*<ptr>=
).
> >
> > MEM_ALIGNED can only be used in combination with MEM_FIXED_SIZE annotat=
ed
> > argument types, since in !MEM_FIXED_SIZE cases the verifier does not kn=
ow
> > the buffer size a priori and therefore cannot blindly write *<ptr> =3D =
val.
> >
> > Fixes: 57c3bb725a3d ("bpf: Introduce ARG_PTR_TO_{INT,LONG} arg types")
> > Reported-by: Lonial Con <kongln9170@gmail.com>
> > Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> > ---
> >  v1 -> v2:
> >  - switch to MEM_FIXED_SIZE
> >  v3 -> v4:
> >  - fixed 64bit in strto{u,}l (Alexei)
> >
> >  include/linux/bpf.h      |  7 +++++--
> >  kernel/bpf/helpers.c     |  8 ++++++--
> >  kernel/bpf/syscall.c     |  4 +++-
> >  kernel/bpf/verifier.c    | 38 +++++---------------------------------
> >  kernel/trace/bpf_trace.c |  8 ++++++--
> >  net/core/filter.c        |  8 ++++++--
> >  6 files changed, 31 insertions(+), 42 deletions(-)
> >
>
> Very neat. I only have stylistic nits, but LGTM anyways
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>
> [...]
>
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 5404bb964d83..0587d0c2375a 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -537,7 +537,9 @@ const struct bpf_func_proto bpf_strtol_proto =3D {
> >         .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> >         .arg2_type      =3D ARG_CONST_SIZE,
> >         .arg3_type      =3D ARG_ANYTHING,
> > -       .arg4_type      =3D ARG_PTR_TO_LONG,
> > +       .arg4_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
> > +                         MEM_UNINIT | MEM_ALIGNED,
>
> nit: I wouldn't wrap the line here and everywhere else
>
> > +       .arg4_size      =3D sizeof(s64),
> >  };
> >
> >  BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags=
,
> > @@ -563,7 +565,9 @@ const struct bpf_func_proto bpf_strtoul_proto =3D {
> >         .arg1_type      =3D ARG_PTR_TO_MEM | MEM_RDONLY,
> >         .arg2_type      =3D ARG_CONST_SIZE,
> >         .arg3_type      =3D ARG_ANYTHING,
> > -       .arg4_type      =3D ARG_PTR_TO_LONG,
> > +       .arg4_type      =3D ARG_PTR_TO_FIXED_SIZE_MEM |
> > +                         MEM_UNINIT | MEM_ALIGNED,
> > +       .arg4_size      =3D sizeof(u64),
> >  };
> >
>
> [...]
>
> >  static const struct bpf_reg_types spin_lock_types =3D {
> >         .types =3D {
> >                 PTR_TO_MAP_VALUE,
> > @@ -8453,8 +8433,6 @@ static const struct bpf_reg_types *compatible_reg=
_types[__BPF_ARG_TYPE_MAX] =3D {
> >         [ARG_PTR_TO_SPIN_LOCK]          =3D &spin_lock_types,
> >         [ARG_PTR_TO_MEM]                =3D &mem_types,
> >         [ARG_PTR_TO_RINGBUF_MEM]        =3D &ringbuf_mem_types,
> > -       [ARG_PTR_TO_INT]                =3D &int_ptr_types,
> > -       [ARG_PTR_TO_LONG]               =3D &int_ptr_types,
> >         [ARG_PTR_TO_PERCPU_BTF_ID]      =3D &percpu_btf_ptr_types,
> >         [ARG_PTR_TO_FUNC]               =3D &func_ptr_types,
> >         [ARG_PTR_TO_STACK]              =3D &stack_ptr_types,
> > @@ -9020,6 +8998,11 @@ static int check_func_arg(struct bpf_verifier_en=
v *env, u32 arg,
> >                         err =3D check_helper_mem_access(env, regno,
> >                                                       fn->arg_size[arg]=
, false,
> >                                                       meta);
> > +                       if (err)
> > +                               return err;
> > +                       if (arg_type & MEM_ALIGNED)
> > +                               err =3D check_ptr_alignment(env, reg, 0=
,
> > +                                                         fn->arg_size[=
arg], true);
>
> nit: we should take advantage of 100 character lines and make this stream=
lined:
>
> @@ -9016,11 +9016,10 @@ static int check_func_arg(struct
> bpf_verifier_env *env, u32 arg,
>                  * next is_mem_size argument below.
>                  */
>                 meta->raw_mode =3D arg_type & MEM_UNINIT;
> -               if (arg_type & MEM_FIXED_SIZE) {
> -                       err =3D check_helper_mem_access(env, regno,
> -                                                     fn->arg_size[arg], =
false,
> -                                                     meta);
> -               }
> +               if (arg_type & MEM_FIXED_SIZE)
> +                       err =3D check_helper_mem_access(env, regno,
> fn->arg_size[arg], false, meta);
> +               if (arg_type & MEM_ALIGNED)
> +                       err =3D err ?: check_ptr_alignment(env, reg, 0,
> fn->arg_size[arg], true);
>                 break;

Agree that it's a bit cleaner this way.

