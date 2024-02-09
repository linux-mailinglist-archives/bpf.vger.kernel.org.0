Return-Path: <bpf+bounces-21641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A932284FBA9
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 19:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB2B1C22EF2
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 18:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C5F7F490;
	Fri,  9 Feb 2024 18:11:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFED37F48F
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 18:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502302; cv=none; b=vCYrvx3HwUPGUJtTBvEp2EztIsRzmhglnuxCPLIHUG7QaZuTvnQbrfmIjU7RWyI0r7XT3EJZ3POYJwiIsimo61JIkK8Ey4EquJ697jT+wzYufmso18kd9kkSG9u1QQ7sybTJ/9Z2XJYz1tUblSCAINMNFq+oaoqZsaYN05ww4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502302; c=relaxed/simple;
	bh=WnuXNe3o875iRw5hVH0h/LYbTQQAARXKO/Q1mc90QyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AxFfX4pM42R0/haUO6e6hn+rvtMqPC8mx8qvGHSUGBnOiiH1iXU6Ai8GeqDNB4Hk4XWFSuT0A989kD/OVZlwzfN9ud9teR8EJfHiItJ1XlOf5w/YlgEPkVvbuwauxjxMebdtqaPj6LwPbDXIStiQELj582IbLbrMdac6t5+nNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68c8d3c445fso6006296d6.1
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 10:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707502300; x=1708107100;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujf1now2MFzpY/1fz97ZcaW/TJT9oGqy/4/GaeaHiHk=;
        b=hRq/h880sdh2fYOSK7awbKHBcY4Wr2JMPHb6r7+HMKGOOAsYuH2cpoLqJPeuCHgOPm
         CBDLr44kub3nHZtS4cEJLgIG3MDwpqxhyJ7lN2+3ArCFows61WWUd+/cW/fJTykrMqi/
         KGWVGX9twnLC76t+Ec5fLJ+QDGcfZ+calc0NgNHszZnNFY6B+YJw0e49XtR9i5R75Kq1
         ebWhoEVUCgf4skPIAfDwrwyARhGOBU7eDkLtorKf57DgClYSvQjsdwlpBpDZifpoBqsv
         f8m+i+zhBbyiBAgIOVV+dghxxeQvX7/2JY4Eq3qurKXcUkU3q6NKM6+xJDMh0V3BMRrS
         /XAg==
X-Gm-Message-State: AOJu0YxsYsVPZNpc4U/I7Uje2ZrbsIoWXyRjGZuP6Akr59ZRZ1XADr1O
	NpEykuQq832Y5b42myEP8EOFyome3gPhsuTVp22Q68GekVK7weR1
X-Google-Smtp-Source: AGHT+IHOHD9AHcpdzJoBLNm/zSEbLSHecV2HlJYgAVRKKL8UC4rOxQjIWVMLD/Zljm9zTT789A8EsQ==
X-Received: by 2002:a0c:f391:0:b0:68c:a9bd:d048 with SMTP id i17-20020a0cf391000000b0068ca9bdd048mr2442534qvk.28.1707502299691;
        Fri, 09 Feb 2024 10:11:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyrn7uiR1XBlfUDJWyM0bspvY50QCnkrsUDJTcv46ZvW0omUANVAPn0UhnjQFO/xeyX5zMML7l0dQJxyCV5BfR1Kk+jfnZLVqy6/dmmqHPQJTiLQuLao0yjWE6AZyma4Ymp7+fziQWwI8Sqc87eprCmeR45W8FF4i3sc8Z9LeG/Ji38KG+x+1f9oj59TmojXKqpRU9tUfFscPybrAl8gh4RomiqbOy5rPq2zPl5ldvV/NOZ+V4Gwig1EYa9biLChMeW6qK1n4hWb1Qc+MhHCDuHOg6C5+4ZcPrkMaVGj04NRQiEZHGLQG8JHzw6HSnOQ==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id nz10-20020a0562143a8a00b0068cbacf7327sm1029932qvb.107.2024.02.09.10.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 10:11:39 -0800 (PST)
Date: Fri, 9 Feb 2024 12:11:36 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	tj@kernel.org, brho@google.com, hannes@cmpxchg.org,
	linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 02/16] bpf: Recognize '__map' suffix in kfunc
 arguments
Message-ID: <20240209181136.GD975217@maniforge.lan>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-3-alexei.starovoitov@gmail.com>
 <20240209165745.GB975217@maniforge.lan>
 <jxfd2zufwee3rom5zt3pger5wkytwiuy3lepw5vacvg6lwuv7g@cxnjdxb3tr2d>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N8uZMuqoGFctCgn7"
Content-Disposition: inline
In-Reply-To: <jxfd2zufwee3rom5zt3pger5wkytwiuy3lepw5vacvg6lwuv7g@cxnjdxb3tr2d>
User-Agent: Mutt/2.2.12 (2023-09-09)


--N8uZMuqoGFctCgn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 09:46:57AM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 09, 2024 at 10:57:45AM -0600, David Vernet wrote:
> > On Tue, Feb 06, 2024 at 02:04:27PM -0800, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >=20
> > > Recognize 'void *p__map' kfunc argument as 'struct bpf_map *p__map'.
> > > It allows kfunc to have 'void *' argument for maps, since bpf progs
> > > will call them as:
> > > struct {
> > >         __uint(type, BPF_MAP_TYPE_ARENA);
> > > 	...
> > > } arena SEC(".maps");
> > >=20
> > > bpf_kfunc_with_map(... &arena ...);
> > >=20
> > > Underneath libbpf will load CONST_PTR_TO_MAP into the register via ld=
_imm64 insn.
> > > If kfunc was defined with 'struct bpf_map *' it would pass
> > > the verifier, but bpf prog would need to use '(void *)&arena'.
> > > Which is not clean.
> > >=20
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  kernel/bpf/verifier.c | 14 +++++++++++++-
> > >  1 file changed, 13 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index d9c2dbb3939f..db569ce89fb1 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -10741,6 +10741,11 @@ static bool is_kfunc_arg_ignore(const struct=
 btf *btf, const struct btf_param *a
> > >  	return __kfunc_param_match_suffix(btf, arg, "__ign");
> > >  }
> > > =20
> > > +static bool is_kfunc_arg_map(const struct btf *btf, const struct btf=
_param *arg)
> > > +{
> > > +	return __kfunc_param_match_suffix(btf, arg, "__map");
> > > +}
> > > +
> > >  static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const stru=
ct btf_param *arg)
> > >  {
> > >  	return __kfunc_param_match_suffix(btf, arg, "__alloc");
> > > @@ -11064,7 +11069,7 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_en=
v *env,
> > >  		return KF_ARG_PTR_TO_CONST_STR;
> > > =20
> > >  	if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[base_=
type(reg->type)])) {
> > > -		if (!btf_type_is_struct(ref_t)) {
> > > +		if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref_t)) {
> > >  			verbose(env, "kernel function %s args#%d pointer type %s %s is no=
t supported\n",
> > >  				meta->func_name, argno, btf_type_str(ref_t), ref_tname);
> > >  			return -EINVAL;
> > > @@ -11660,6 +11665,13 @@ static int check_kfunc_args(struct bpf_verif=
ier_env *env, struct bpf_kfunc_call_
> > >  		if (kf_arg_type < 0)
> > >  			return kf_arg_type;
> > > =20
> > > +		if (is_kfunc_arg_map(btf, &args[i])) {
> > > +			/* If argument has '__map' suffix expect 'struct bpf_map *' */
> > > +			ref_id =3D *reg2btf_ids[CONST_PTR_TO_MAP];
> > > +			ref_t =3D btf_type_by_id(btf_vmlinux, ref_id);
> > > +			ref_tname =3D btf_name_by_offset(btf, ref_t->name_off);
> > > +		}
> >=20
> > This is fine, but given that this should only apply to KF_ARG_PTR_TO_BT=
F_ID,
> > this seems a bit cleaner, wdyt?
> >=20
> > index ddaf09db1175..998da8b302ac 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -10741,6 +10741,11 @@ static bool is_kfunc_arg_ignore(const struct b=
tf *btf, const struct btf_param *a
> >         return __kfunc_param_match_suffix(btf, arg, "__ign");
> >  }
> >=20
> > +static bool is_kfunc_arg_map(const struct btf *btf, const struct btf_p=
aram *arg)
> > +{
> > +       return __kfunc_param_match_suffix(btf, arg, "__map");
> > +}
> > +
> >  static bool is_kfunc_arg_alloc_obj(const struct btf *btf, const struct=
 btf_param *arg)
> >  {
> >         return __kfunc_param_match_suffix(btf, arg, "__alloc");
> > @@ -10910,6 +10915,7 @@ enum kfunc_ptr_arg_type {
> >         KF_ARG_PTR_TO_RB_NODE,
> >         KF_ARG_PTR_TO_NULL,
> >         KF_ARG_PTR_TO_CONST_STR,
> > +       KF_ARG_PTR_TO_MAP,      /* pointer to a struct bpf_map */
> >  };
> >=20
> >  enum special_kfunc_type {
> > @@ -11064,12 +11070,12 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_en=
v *env,
> >                 return KF_ARG_PTR_TO_CONST_STR;
> >=20
> >         if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[b=
ase_type(reg->type)])) {
> > -               if (!btf_type_is_struct(ref_t)) {
> > +               if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref=
_t)) {
> >                         verbose(env, "kernel function %s args#%d pointe=
r type %s %s is not supported\n",
> >                                 meta->func_name, argno, btf_type_str(re=
f_t), ref_tname);
> >                         return -EINVAL;
> >                 }
> > -               return KF_ARG_PTR_TO_BTF_ID;
> > +               return is_kfunc_arg_map(meta->btf, &args[argno]) ? KF_A=
RG_PTR_TO_MAP : KF_ARG_PTR_TO_BTF_ID;
>=20
> Makes sense, but then should I add the following on top:
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e970d9fd7f32..b524dc168023 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11088,13 +11088,16 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env =
*env,
>         if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
>                 return KF_ARG_PTR_TO_CONST_STR;
>=20
> +       if (is_kfunc_arg_map(meta->btf, &args[argno]))
> +               return KF_ARG_PTR_TO_MAP;
> +

Yeah, it's probably cleaner to pull it out of that block, which is
already a bit of a mess.

Only thing is that it doesn't make sense to invoke is_kfunc_arg_map() on
something that doesn't have base_type(reg->type) =3D=3D CONST_PTR_TO_MAP
right? We sort of had that covered in the below block beacuse of the
reg2btf_ids[base_type(reg->type)] check, but even then it was kind of
sketchy because we could have base_type(reg->type) =3D=3D PTR_TO_BTF_ID or
some other base_type with a nonzero btf ID and still treat it as a
KF_ARG_PTR_TO_MAP depending on how the kfunc was named. So maybe
something like this would be yet another improvement on top of both
proposals that would avoid any weird edge cases or confusion on the part
of the kfunc author?

+ if (is_kfunc_arg_map(meta->btf, &args[argno])) {
+         if (base_type(reg->type) !=3D CONST_PTR_TO_MAP) {
+                 verbose(env, "kernel function %s map arg#%d %s reg was no=
t type %s\n",
+                         meta->func_name, argno, ref_name, reg_type_str(en=
v, CONST_PTR_TO_MAP));
+                 return -EINVAL;
+         }
+         return KF_ARG_PTR_TO_MAP;
+ }
+

>         if ((base_type(reg->type) =3D=3D PTR_TO_BTF_ID || reg2btf_ids[bas=
e_type(reg->type)])) {
> -               if (!btf_type_is_struct(ref_t) && !btf_type_is_void(ref_t=
)) {
> +               if (!btf_type_is_struct(ref_t)) {
>                         verbose(env, "kernel function %s args#%d pointer =
type %s %s is not supported\n",
>                                 meta->func_name, argno, btf_type_str(ref_=
t), ref_tname);
>                         return -EINVAL;
>                 }
> -               return is_kfunc_arg_map(meta->btf, &args[argno]) ? KF_ARG=
_PTR_TO_MAP : KF_ARG_PTR_TO_BTF_ID;
> +               return KF_ARG_PTR_TO_BTF_ID;
>         }
>=20
> ?
>=20

--N8uZMuqoGFctCgn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcZq2AAKCRBZ5LhpZcTz
ZKUOAQDRRc7irh9+fJhc4DTqsgWwRwTuvsgt26G3PUb13rdO7wEAshz5Sa+s20HU
XAG9ejn6wbxerx5gVejyVaq3IY874ww=
=FtWy
-----END PGP SIGNATURE-----

--N8uZMuqoGFctCgn7--

