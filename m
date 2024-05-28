Return-Path: <bpf+bounces-30796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2A48D2824
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C811F26A27
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB4413E043;
	Tue, 28 May 2024 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1bUHY5I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EC413DDD2
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935964; cv=none; b=G0oRw5z1sjPaJlMlnhhPV5X7pLJzF/CULMMpluENMuaNAmluwPNPuwprrZHxIas+1T4s1frNPtukec66WWGTQQvA0FmUPTtFeCUKjhiYB0R1C9/djOfez3rAli7b40vQ3aH783IHUE0sZwIiIUH2fZ3ReIwzDWQeylgOXaNEg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935964; c=relaxed/simple;
	bh=4GzOTbHrCQi69IvLm2nVVPEyhM7kupTrelgta05As8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+JjrfxksyVyaqXfcsFwg5t/7C2TUECcHZ2LxNLlBMZWtJZyIiVlnW+ypcs2G3czGNz0wb3/oBEMrcDeri6JHH/rogMMOEo63V7STGuFe1em+v7+sxAjcZh20qo0KJVFilaN9XSkg4R561x9/hVVVGUA1YJO9t4p0IiBH3OhKeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1bUHY5I; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2bfb6668ad5so1152080a91.0
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 15:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716935962; x=1717540762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVFUrgfY2uDSAQUWMq2NZt1dOYmfoptSFnT0P9K81Ek=;
        b=U1bUHY5IYfmuTl2ImHty6ufNRuKLQE2HJgGBm/FZHABdj0/P/+QLzGTWR74BnSSBkG
         Q2GgITFdpXY5eOfJthGQOJ64AMXYnNbfdoZlWqW4JnyurZxl4RrP4l/zUvdN7j+WmoYX
         uyNY4zWD942L/k7HCa0MaEJl9xSeHtF5RGvleV70B21ckqBrSGAx4aKrQOkWwvzIJbbx
         NVE7iwomV0TfmEyiyhVVISriAMSBPAP1cD7D3aO6eRITtYcLyKg5aptziT9O4Kb90h2j
         Vji/Dt3Xm2wV/7TIo4unw244E/libYlKk10JRPhg5tDKhLA93I5XgnHamaMGgcxB4l6/
         EYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716935962; x=1717540762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVFUrgfY2uDSAQUWMq2NZt1dOYmfoptSFnT0P9K81Ek=;
        b=aWNY7uU4ht9usGhhdrKIAL/TtayLqZZ6WzmcYdrw2Q6jn+wKAGafU27zr/WdhtFXgP
         S9Zs8qWnzLoAMihzjiWJpA8V36AR1C+ik8OLFWBr+W6yLhEuhbLef7sHTjv7UA7AMhA9
         nCRGvFp6SDJkxrVz0A0Kq+7NTgwNGR9Xe4esGDhtmCDVZxRt8hdL2NT19de24jBFce5s
         FyE4JWz2t1AUB2DqbvcdN3vKElQR7eesXQsgUgTuKSsJN9z03FZMiONZA3qBkO1hvGB5
         gNqV04WSGh7pDfB3tFgObR5UJi09uMhpu6dwSiXjLG6QpdzdyADip1aCLGdkZ0ndK4Dj
         a9zA==
X-Gm-Message-State: AOJu0Yyxs96L8mlhw5djXyYT2SeBExPCaStn3/ExBDRZF1URAm4l6XeN
	Fpbe12JlUF3tNTk3SSb/23+Yca5h8gCfAaunTScul4vBr/HDIkTOuiroSDMALRYT3hbs0N6ANcK
	uUNRan6vVCwwU103nRFacke19Hos=
X-Google-Smtp-Source: AGHT+IEui4gnALyjregDjrXVh7xsiIlV2jkQmfqKjsnBjplJedyB4LHr13fZsGrhWo0BYHHvUD+SdkiTq5z+j4rEsMA=
X-Received: by 2002:a17:90a:c383:b0:2ae:6e16:da91 with SMTP id
 98e67ed59e1d1-2bf5f109bd6mr12245868a91.29.1716935962288; Tue, 28 May 2024
 15:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517190555.4032078-1-eddyz87@gmail.com> <20240517190555.4032078-2-eddyz87@gmail.com>
 <CAEf4BzbZVteBuTMGUowBjQqF2iR8FqQBxZ3_oBtLB4+nhAGYSw@mail.gmail.com> <9574c1e856c20eb98085ceb0071033169ec360ec.camel@gmail.com>
In-Reply-To: <9574c1e856c20eb98085ceb0071033169ec360ec.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 May 2024 15:39:10 -0700
Message-ID: <CAEf4BzZYauwNDch47x2aUsTL1MK-_Y6fqdazk1rttHyU2E2psg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: put forward declarations to btf_dump->emit_queue
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 3:25=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Tue, 2024-05-28 at 15:05 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -93,7 +85,10 @@ struct btf_dump {
> > >         size_t cached_names_cap;
> > >
> > >         /* topo-sorted list of dependent type definitions */
> > > -       __u32 *emit_queue;
> > > +       struct {
> > > +               __u32 id:31;
> > > +               __u32 fwd:1;
> > > +       } *emit_queue;
> >
> > let's define the named type right in this patch, no need to use
> > typeof() hack just to remove it later.
> >
> > Also, let's maybe have
> >
> > struct <whatever> {
> >     __u32 id;
> >     __u32 flags;
> > };
> >
> > and define
> >
> > enum btf_dump_emit_flags {
> >     BTF_DUMP_FWD_DECL =3D 0x1,
> > };
> >
> > Or something along those lines? Having a few more flags available will
> > make it less like that we'll need to add a new set of APIs just to
> > accommodate one extra flag. (Though, if we add another field, we'll
> > end up adding another API anyways, but I really hope we will never
> > have to do this).
>
> Ok, will do
>
> [...]
>
> > > -static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
> > > +static int __btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id=
, bool fwd)
> >
> > I don't like those underscored functions in libbpf code base, please
> > don't add them. But I'm also not sure we need to have it, there are
> > only a few calles of the original btf_dump_add_emit_queue_id(), so we
> > can just update them to pass true/false as appropriate.
>
> Will do
>
> [...]
>
> > > +static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 =
id, bool dry_run);
> > > +
> > > +static bool btf_dump_is_blacklisted(struct btf_dump *d, __u32 id)
> > > +{
> > > +       const struct btf_type *t =3D btf__type_by_id(d->btf, id);
> > > +
> > > +       /* __builtin_va_list is a compiler built-in, which causes com=
pilation
> > > +        * errors, when compiling w/ different compiler, then used to=
 compile
> > > +        * original code (e.g., GCC to compile kernel, Clang to use g=
enerated
> > > +        * C header from BTF). As it is built-in, it should be alread=
y defined
> > > +        * properly internally in compiler.
> > > +        */
> > > +       if (t->name_off =3D=3D 0)
> > > +               return false;
> > > +       return strcmp(btf_name_of(d, t->name_off), "__builtin_va_list=
") =3D=3D 0;
> > > +}
> > > +
> >
> > why moving btf_dump_is_blacklisted() but forward declaring
> > btf_dump_emit_missing_aliases()? Let's do the same to both, whichever
> > it is (forward declaring probably is least distracting here)
>
> Sure, will add forward declarations for both.
>
> [...]
>
> > >         case BTF_KIND_UNION: {
> > >                 const struct btf_member *m =3D btf_members(t);
> > > +               __u32 new_cont_id;
> > > +
> > >                 /*
> > >                  * struct/union is part of strong link, only if it's =
embedded
> > >                  * (so no ptr in a path) or it's anonymous (so has to=
 be
> > >                  * defined inline, even if declared through ptr)
> > >                  */
> > > -               if (through_ptr && t->name_off !=3D 0)
> > > -                       return 0;
> > > +               if (through_ptr && t->name_off !=3D 0) {
> > > +                       if (id !=3D cont_id)
> > > +                               return btf_dump_add_emit_queue_fwd(d,=
 id);
> > > +                       else
> > > +                               return 0;
> >
> > very subjective nit, but this "else return 0;" just doesn't feel right
> > here. Let's do:
> >
> > if (id =3D=3D cont_id)
> >     return 0;
> > return btf_dump_add_emit_queue_fwd();
> >
> > It feels a bit more natural as "if it's a special nice case, we are
> > done (return 0); otherwise we need to emit extra fwd decl."
>
> Will do
>
> >
> > > +               }
> > >
> > >                 tstate->order_state =3D ORDERING;
> > >
> > > +               new_cont_id =3D t->name_off =3D=3D 0 ? cont_id : id;
> > >                 vlen =3D btf_vlen(t);
> > >                 for (i =3D 0; i < vlen; i++, m++) {
> > > -                       err =3D btf_dump_order_type(d, m->type, false=
);
> > > +                       err =3D btf_dump_order_type(d, m->type, new_c=
ont_id, false);
> >
> > just inline `t->name_off ? id : cont_id` here? It's short and
> > straightforward enough, I suppose (named type defines new containing
> > "scope", anonymous type continues existing scope)
>
> Will do
>
> [...]
>
> > > +               err =3D btf_dump_add_emit_queue_fwd(d, id);
> > > +               if (err)
> > > +                       return err;
> > > +               return 0;
> >
> > return btf_dump_add_emit_queue_fwd(...); ? this is the last step, so
> > seems appropriate
>
> Will do
>
> > >         case BTF_KIND_VOLATILE:
> > >         case BTF_KIND_CONST:
> > >         case BTF_KIND_RESTRICT:
> > >         case BTF_KIND_TYPE_TAG:
> > > -               return btf_dump_order_type(d, t->type, through_ptr);
> > > +               return btf_dump_order_type(d, t->type, cont_id, throu=
gh_ptr);
> > >
> > >         case BTF_KIND_FUNC_PROTO: {
> > >                 const struct btf_param *p =3D btf_params(t);
> > > -               bool is_strong;
> > >
> > > -               err =3D btf_dump_order_type(d, t->type, through_ptr);
> > > +               err =3D btf_dump_order_type(d, t->type, cont_id, thro=
ugh_ptr);
> > >                 if (err < 0)
> > >                         return err;
> > > -               is_strong =3D err > 0;
> > >
> > >                 vlen =3D btf_vlen(t);
> > >                 for (i =3D 0; i < vlen; i++, p++) {
> > > -                       err =3D btf_dump_order_type(d, p->type, throu=
gh_ptr);
> > > +                       err =3D btf_dump_order_type(d, p->type, cont_=
id, through_ptr);
> > >                         if (err < 0)
> > >                                 return err;
> > > -                       if (err > 0)
> > > -                               is_strong =3D true;
> > >                 }
> > > -               return is_strong;
> > > +               return err;
> >
> > this should always be zero, right? Just return zero explicit, don't
> > make reader to guess
>
> Ok
>
> [...]
>
> > > @@ -1037,19 +1006,21 @@ static const char *missing_base_types[][2] =
=3D {
> > >         { "__Poly128_t",        "unsigned __int128" },
> > >  };
> > >
> > > -static void btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 =
id,
> > > -                                         const struct btf_type *t)
> > > +static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 =
id, bool dry_run)
> >
> > this dry_run approach look like a sloppy hack, tbh. Maybe just return
> > `const char *` of aliased name, and let caller handle whatever is
> > necessary (either making decision about the need for alias or actually
> > emitting `typedef %s %s`?
>
> I had a version w/o dry run but it seemed to heavy-handed for the purpose=
:
>
> static int btf_dump_missing_alias_idx(struct btf_dump *d, __u32 id)
> {
>         const char *name =3D btf_dump_type_name(d, id);
>         int i;
>
>         for (i =3D 0; i < ARRAY_SIZE(missing_base_types); i++) {
>                 if (strcmp(name, missing_base_types[i][0]) =3D=3D 0)
>                         return i;
>         }
>
>         return -1;
> }
>
> static bool btf_dump_is_missing_alias(struct btf_dump *d, __u32 id)
> {
>         return btf_dump_missing_alias_idx(d, id) >=3D 0;
> }
>
> static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id)
> {
>         const char *name =3D btf_dump_type_name(d, id);
>         int i;
>
>         i =3D btf_dump_missing_alias_idx(d, id);
>         if (i < 0)
>                 return false;
>
>         btf_dump_printf(d, "typedef %s %s;\n\n",
>                         missing_base_types[i][1], name);
>         return true;
> }
>
> I can use the above if you think it is better.

I meant something less heavy-handed:

static const char *btf_dump_missing_alias(struct btf_dump *d, __u32 id)
{
        const char *name =3D btf_dump_type_name(d, id);
        int i;

        for (i =3D 0; i < ARRAY_SIZE(missing_base_types); i++) {
                if (strcmp(name, missing_base_types[i][0]) =3D=3D 0)
                        return missing_base_types[i][1];
        }
        return NULL;
}

And we actually don't need to use btf_dump_type_name(), btf_name_of()
should be more than adequate for this.

Then if you get NULL from this function, there is no aliasing
required. If you got non-NULL, you have the name you should alias to
(btf_name_of() will give you original name).

