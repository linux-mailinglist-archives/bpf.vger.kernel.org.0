Return-Path: <bpf+bounces-30792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6DE8D27FF
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 00:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B9C28CFA1
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 22:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF0F13DDD1;
	Tue, 28 May 2024 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeDYFx5Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1627C8FF
	for <bpf@vger.kernel.org>; Tue, 28 May 2024 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716935131; cv=none; b=tX6OTYvsnoZMKVPlwYbIIf3MOGZffRIOSqwmqFOw14DfwIUaxKsyVONb8UFHfavZDxOgh9Xf8C2wVnyDh3PQykgHhjJSbYa0SmT1hDPGW54G3IyX1fhPJte0w8eR3vReajXQMvfUO4KNRxL7p3Zs4i35tY9nChvXou6603kgkuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716935131; c=relaxed/simple;
	bh=3Fi7aX2zuCTpdYBNImmjMIIyMQlWqNGxxOf8bxzBaTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jr90N4ZkzothGvF/drMPVsVkZDjn/pF7z+EGiVUharDvgQ+YJIa+biG3IzVO/41UdobtBK7ur8WMvnMxRtsMhkHZpEzuf7u60MDhR5oqJs9oe6LyGmNEagF0kpjj36W4e4eoxky/N76QCf5H/Ml0LJe0aNceXG8bsT50fZfYVjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeDYFx5Q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso232030b3a.1
        for <bpf@vger.kernel.org>; Tue, 28 May 2024 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716935129; x=1717539929; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0eLF70gnnJC3BJwLreI2kKKwp9w2n93DGPvOsRHjsMg=;
        b=PeDYFx5QHKQ4WW1cJuAuRsL5ByV3PScwVBdrXg+wOinanOeOshslg8MitXi5OdGHIK
         YBmEjs6fp7ZZ+ZO7hRJiybOVKK43Bwk7JclzxL02SeH3VyBApR+Jl/6GKeDsoUzKMEST
         ipaBYFLnu5ag7VfqP0QU92hL5lerxOEDd6sEzn7UN64sjNAWE3b3nutQOn7bISblGNR5
         wDX5DF2JSuBvlSTv8TqwMoKlXVQ+hZzpx1OArRBrZiHNLZQqTQlxpV+R/SzgEstCUSyZ
         uN6gLA64Xs5s/MRRXDWtXJpiCOhmrBiudxS6KWA9RgdHJ34rBEC8ZXqlf8z89ZbGVPOc
         uZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716935129; x=1717539929;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0eLF70gnnJC3BJwLreI2kKKwp9w2n93DGPvOsRHjsMg=;
        b=aM5d9nxb1eUDDjYDhcePnkCAW6AVpgw0LB+tWPwBqUXnfpJ6fXS6cEf7heAEAqfHbC
         /jdnJhND7pEtC/WXV7rV+UXPDT5m8lzRD64zLla5hSqbZTcu6BmJl3I7zzTXjWyD8E9F
         NUp5UvO7cxINqwmurl/nQrM8ky9DAMeCk/j9IEBNsEgcz4R6MX38gwk6GUr9744EUurG
         hfJB99iXT06PDcIpjheYXjDM2t68w+4qeFQsKWx/mcay7dL4Jj6Xm0vwm/sbTdYy5RjE
         zaTU7ftUaTHMbx3lKzBKXHg719xIMLBP1hBb4+hZvDQMPuH748OVRZ5uJht1oCeQ2JVU
         /sMQ==
X-Gm-Message-State: AOJu0YwLZcCM6NDPmkaWgc6CL2Pcn/cePS46N0nM0nkQTMKf0+Ms/LKV
	n32OWu1/n1VKDHg1Np9vNz+mplbg7HDzjuIYYNjLAimG70Aq3SeenkLRJA==
X-Google-Smtp-Source: AGHT+IEvYz5cykCp1dCp5we89XijGjHHgVP2nJzZHzWo5gHO8fbi5tlazy0ovyw81zV8DZhdT6s/HA==
X-Received: by 2002:a05:6a00:4ac4:b0:6ed:2f0d:8d73 with SMTP id d2e1a72fcca58-702029d588cmr649075b3a.3.1716935128750;
        Tue, 28 May 2024 15:25:28 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6fbf67459a8sm5834481b3a.180.2024.05.28.15.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 15:25:27 -0700 (PDT)
Message-ID: <9574c1e856c20eb98085ceb0071033169ec360ec.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: put forward declarations to
 btf_dump->emit_queue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  jose.marchesi@oracle.com, alan.maguire@oracle.com
Date: Tue, 28 May 2024 15:25:26 -0700
In-Reply-To: <CAEf4BzbZVteBuTMGUowBjQqF2iR8FqQBxZ3_oBtLB4+nhAGYSw@mail.gmail.com>
References: <20240517190555.4032078-1-eddyz87@gmail.com>
	 <20240517190555.4032078-2-eddyz87@gmail.com>
	 <CAEf4BzbZVteBuTMGUowBjQqF2iR8FqQBxZ3_oBtLB4+nhAGYSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-28 at 15:05 -0700, Andrii Nakryiko wrote:

[...]

> > @@ -93,7 +85,10 @@ struct btf_dump {
> >         size_t cached_names_cap;
> >=20
> >         /* topo-sorted list of dependent type definitions */
> > -       __u32 *emit_queue;
> > +       struct {
> > +               __u32 id:31;
> > +               __u32 fwd:1;
> > +       } *emit_queue;
>=20
> let's define the named type right in this patch, no need to use
> typeof() hack just to remove it later.
>=20
> Also, let's maybe have
>=20
> struct <whatever> {
>     __u32 id;
>     __u32 flags;
> };
>=20
> and define
>=20
> enum btf_dump_emit_flags {
>     BTF_DUMP_FWD_DECL =3D 0x1,
> };
>=20
> Or something along those lines? Having a few more flags available will
> make it less like that we'll need to add a new set of APIs just to
> accommodate one extra flag. (Though, if we add another field, we'll
> end up adding another API anyways, but I really hope we will never
> have to do this).

Ok, will do

[...]

> > -static int btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id)
> > +static int __btf_dump_add_emit_queue_id(struct btf_dump *d, __u32 id, =
bool fwd)
>=20
> I don't like those underscored functions in libbpf code base, please
> don't add them. But I'm also not sure we need to have it, there are
> only a few calles of the original btf_dump_add_emit_queue_id(), so we
> can just update them to pass true/false as appropriate.

Will do

[...]

> > +static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id=
, bool dry_run);
> > +
> > +static bool btf_dump_is_blacklisted(struct btf_dump *d, __u32 id)
> > +{
> > +       const struct btf_type *t =3D btf__type_by_id(d->btf, id);
> > +
> > +       /* __builtin_va_list is a compiler built-in, which causes compi=
lation
> > +        * errors, when compiling w/ different compiler, then used to c=
ompile
> > +        * original code (e.g., GCC to compile kernel, Clang to use gen=
erated
> > +        * C header from BTF). As it is built-in, it should be already =
defined
> > +        * properly internally in compiler.
> > +        */
> > +       if (t->name_off =3D=3D 0)
> > +               return false;
> > +       return strcmp(btf_name_of(d, t->name_off), "__builtin_va_list")=
 =3D=3D 0;
> > +}
> > +
>=20
> why moving btf_dump_is_blacklisted() but forward declaring
> btf_dump_emit_missing_aliases()? Let's do the same to both, whichever
> it is (forward declaring probably is least distracting here)

Sure, will add forward declarations for both.

[...]

> >         case BTF_KIND_UNION: {
> >                 const struct btf_member *m =3D btf_members(t);
> > +               __u32 new_cont_id;
> > +
> >                 /*
> >                  * struct/union is part of strong link, only if it's em=
bedded
> >                  * (so no ptr in a path) or it's anonymous (so has to b=
e
> >                  * defined inline, even if declared through ptr)
> >                  */
> > -               if (through_ptr && t->name_off !=3D 0)
> > -                       return 0;
> > +               if (through_ptr && t->name_off !=3D 0) {
> > +                       if (id !=3D cont_id)
> > +                               return btf_dump_add_emit_queue_fwd(d, i=
d);
> > +                       else
> > +                               return 0;
>=20
> very subjective nit, but this "else return 0;" just doesn't feel right
> here. Let's do:
>=20
> if (id =3D=3D cont_id)
>     return 0;
> return btf_dump_add_emit_queue_fwd();
>=20
> It feels a bit more natural as "if it's a special nice case, we are
> done (return 0); otherwise we need to emit extra fwd decl."

Will do

>=20
> > +               }
> >=20
> >                 tstate->order_state =3D ORDERING;
> >=20
> > +               new_cont_id =3D t->name_off =3D=3D 0 ? cont_id : id;
> >                 vlen =3D btf_vlen(t);
> >                 for (i =3D 0; i < vlen; i++, m++) {
> > -                       err =3D btf_dump_order_type(d, m->type, false);
> > +                       err =3D btf_dump_order_type(d, m->type, new_con=
t_id, false);
>=20
> just inline `t->name_off ? id : cont_id` here? It's short and
> straightforward enough, I suppose (named type defines new containing
> "scope", anonymous type continues existing scope)

Will do

[...]

> > +               err =3D btf_dump_add_emit_queue_fwd(d, id);
> > +               if (err)
> > +                       return err;
> > +               return 0;
>=20
> return btf_dump_add_emit_queue_fwd(...); ? this is the last step, so
> seems appropriate

Will do

> >         case BTF_KIND_VOLATILE:
> >         case BTF_KIND_CONST:
> >         case BTF_KIND_RESTRICT:
> >         case BTF_KIND_TYPE_TAG:
> > -               return btf_dump_order_type(d, t->type, through_ptr);
> > +               return btf_dump_order_type(d, t->type, cont_id, through=
_ptr);
> >=20
> >         case BTF_KIND_FUNC_PROTO: {
> >                 const struct btf_param *p =3D btf_params(t);
> > -               bool is_strong;
> >=20
> > -               err =3D btf_dump_order_type(d, t->type, through_ptr);
> > +               err =3D btf_dump_order_type(d, t->type, cont_id, throug=
h_ptr);
> >                 if (err < 0)
> >                         return err;
> > -               is_strong =3D err > 0;
> >=20
> >                 vlen =3D btf_vlen(t);
> >                 for (i =3D 0; i < vlen; i++, p++) {
> > -                       err =3D btf_dump_order_type(d, p->type, through=
_ptr);
> > +                       err =3D btf_dump_order_type(d, p->type, cont_id=
, through_ptr);
> >                         if (err < 0)
> >                                 return err;
> > -                       if (err > 0)
> > -                               is_strong =3D true;
> >                 }
> > -               return is_strong;
> > +               return err;
>=20
> this should always be zero, right? Just return zero explicit, don't
> make reader to guess

Ok

[...]

> > @@ -1037,19 +1006,21 @@ static const char *missing_base_types[][2] =3D =
{
> >         { "__Poly128_t",        "unsigned __int128" },
> >  };
> >=20
> > -static void btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id=
,
> > -                                         const struct btf_type *t)
> > +static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id=
, bool dry_run)
>=20
> this dry_run approach look like a sloppy hack, tbh. Maybe just return
> `const char *` of aliased name, and let caller handle whatever is
> necessary (either making decision about the need for alias or actually
> emitting `typedef %s %s`?

I had a version w/o dry run but it seemed to heavy-handed for the purpose:

static int btf_dump_missing_alias_idx(struct btf_dump *d, __u32 id)
{
	const char *name =3D btf_dump_type_name(d, id);
	int i;

	for (i =3D 0; i < ARRAY_SIZE(missing_base_types); i++) {
		if (strcmp(name, missing_base_types[i][0]) =3D=3D 0)
			return i;
	}

        return -1;
}

static bool btf_dump_is_missing_alias(struct btf_dump *d, __u32 id)
{
	return btf_dump_missing_alias_idx(d, id) >=3D 0;
}

static bool btf_dump_emit_missing_aliases(struct btf_dump *d, __u32 id)
{
	const char *name =3D btf_dump_type_name(d, id);
	int i;

	i =3D btf_dump_missing_alias_idx(d, id);
	if (i < 0)
		return false;

	btf_dump_printf(d, "typedef %s %s;\n\n",
			missing_base_types[i][1], name);
	return true;
}

I can use the above if you think it is better.

