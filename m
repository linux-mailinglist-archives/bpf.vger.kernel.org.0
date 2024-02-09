Return-Path: <bpf+bounces-21646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 854B484FCB6
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 20:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DE72894E9
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 19:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB1D84A46;
	Fri,  9 Feb 2024 19:19:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4EF24A18
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707506339; cv=none; b=HXnL6tgLidjARdt4ReJTXJuXpJN8Ed2ztgwZLZeTWkMFDilJLlRIB0cFUr8bwKKw+TgmmQ+OnO8VmG2Hv/lbql1ezmLh75N5c20yuemHia5rwVvE8cnP9Mu/Bp1B+kCfW2GaJrb1UWTFSdRkNYifh8scHOMuxRItC8UuRBkEo/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707506339; c=relaxed/simple;
	bh=n5yUpDTtbzu5mCtttXxGhDbSAXAyB5BkclhM7JD8ivE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3soE+aVxsyh5+Ene68xjVVfj7wB/nyBBNCh9e2Y0O+GuV8qcGffpDqV84KNUWvqUxb9ThozuEmSRaPnIqiQKfbLwNmjddz15Zu/f9muhJpvP8JUPgfnRy4B2uobgwnQKGLfXdQfDaaLvSohJgMexMtCUrfN5UExuejFpa7Gco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bba50cd318so915191b6e.0
        for <bpf@vger.kernel.org>; Fri, 09 Feb 2024 11:18:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707506337; x=1708111137;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H0Lg4hIuTbmJf42UCxxjgfdNcSyEDGORuuL/wrZRi90=;
        b=b+oTgl5z5MWn4emTZ99QiGbNXv3HsJVJuKESI6Glv2WN2Ssm2YQG6JpubJmki9cMwr
         0aHmttPKt2tuAAdbmrV22lZjJMQC01lhsEn0EvV5q0QCDpNKQL3ffpM/ONj8XsFZhyqn
         aTYh6JP3XRLlSrJrj7aEhor156cU8Tyj9tqWkr4Fk5rnQXu61EX8B7F30OQSouXZJR9T
         HGOn88FdW5EbCetO0cE2NXeapJ/CHtOMf+7PSjB2TVgNUXr+j+97CHkteV9nOtoNry/L
         TmMWMb+/HtPILJbHwupWmTN3n7io8uZc7lAN/JGJ7uQD/URWYX1fsb3CDzvVayICp+UG
         Lv6Q==
X-Gm-Message-State: AOJu0YzvyEY2TP5UCC39zOdxp1mTzIFZkTak15YWljbA9ccE0DXqpasQ
	8b61cCOQ1TgT6oYKNmkUcVNDLNfzNLOhDadidB8L3Gkoiy4ywng8
X-Google-Smtp-Source: AGHT+IEITslpViHruqeNFCWQCUrkMqR+s6Bmg1OedYVQ72X0oRii+P2hXKgcLoSQ8gwz/ZkSGDCd/Q==
X-Received: by 2002:a05:6808:38c8:b0:3bf:e035:db58 with SMTP id el8-20020a05680838c800b003bfe035db58mr4046482oib.21.1707506337170;
        Fri, 09 Feb 2024 11:18:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8YJGRZEXq9zYQEVoQ0BhRgUoiA2r1YDspJcz0L8OxSBqJgr9UfjXeEj+t4uILppIQPBbSOx/c+PMiG2Tkrqg3a7SPhnsKQCUHNSKifX77zgh7M3+0iLXcJquFuq8xVs8c9Gx65rh4E7w5ewa94Ief+LcXFJFa8mCyrGYveUxw0vojUYrq9jjGhwyta2ghthjBGXzxoZYUSDiIlhvMIJt3wly9aJ0sjL4DCdpplarhjPfS7V2T/feweHDonsqSiJpCaZ+wvHmS1pD1+FS7RRgK2nv9xR4uyYMqYbRWDnfrwtjXrjRMbj5KB2/Qk6rXAA==
Received: from maniforge.lan (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id v16-20020a05620a091000b007859800f8e3sm27504qkv.2.2024.02.09.11.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 11:18:56 -0800 (PST)
Date: Fri, 9 Feb 2024 13:18:54 -0600
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>,
	Barret Rhoden <brho@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>,
	Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 02/16] bpf: Recognize '__map' suffix in kfunc
 arguments
Message-ID: <20240209191854.GB3645892@maniforge.lan>
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-3-alexei.starovoitov@gmail.com>
 <20240209165745.GB975217@maniforge.lan>
 <jxfd2zufwee3rom5zt3pger5wkytwiuy3lepw5vacvg6lwuv7g@cxnjdxb3tr2d>
 <20240209181136.GD975217@maniforge.lan>
 <CAADnVQ+9pKPVRvF-No60-9-brhSR+AYHotcPp36=6AqP9dEJLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OTPhCgEK1xrWltHI"
Content-Disposition: inline
In-Reply-To: <CAADnVQ+9pKPVRvF-No60-9-brhSR+AYHotcPp36=6AqP9dEJLw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--OTPhCgEK1xrWltHI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 10:59:57AM -0800, Alexei Starovoitov wrote:
> On Fri, Feb 9, 2024 at 10:11=E2=80=AFAM David Vernet <void@manifault.com>=
 wrote:
> > >
> > > Makes sense, but then should I add the following on top:
> > >
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index e970d9fd7f32..b524dc168023 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -11088,13 +11088,16 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_=
env *env,
> > >         if (is_kfunc_arg_const_str(meta->btf, &args[argno]))
> > >                 return KF_ARG_PTR_TO_CONST_STR;
> > >
> > > +       if (is_kfunc_arg_map(meta->btf, &args[argno]))
> > > +               return KF_ARG_PTR_TO_MAP;
> > > +
> >
> > Yeah, it's probably cleaner to pull it out of that block, which is
> > already a bit of a mess.
> >
> > Only thing is that it doesn't make sense to invoke is_kfunc_arg_map() on
> > something that doesn't have base_type(reg->type) =3D=3D CONST_PTR_TO_MAP
> > right? We sort of had that covered in the below block beacuse of the
> > reg2btf_ids[base_type(reg->type)] check, but even then it was kind of
> > sketchy because we could have base_type(reg->type) =3D=3D PTR_TO_BTF_ID=
 or
> > some other base_type with a nonzero btf ID and still treat it as a
> > KF_ARG_PTR_TO_MAP depending on how the kfunc was named. So maybe
> > something like this would be yet another improvement on top of both
> > proposals that would avoid any weird edge cases or confusion on the part
> > of the kfunc author?
> >
> > + if (is_kfunc_arg_map(meta->btf, &args[argno])) {
> > +         if (base_type(reg->type) !=3D CONST_PTR_TO_MAP) {
> > +                 verbose(env, "kernel function %s map arg#%d %s reg wa=
s not type %s\n",
> > +                         meta->func_name, argno, ref_name, reg_type_st=
r(env, CONST_PTR_TO_MAP));
> > +                 return -EINVAL;
> > +         }
>=20
> This would be an unnecessary restriction.
> We should allow this to work:
>=20
> +SEC("iter.s/bpf_map")
> +__success __log_level(2)
> +int iter_maps(struct bpf_iter__bpf_map *ctx)
> +{
> +       struct bpf_map *map =3D ctx->map;
> +
> +       if (!map)
> +               return 0;
> +       bpf_arena_alloc_pages(map, NULL, map->max_entries, NUMA_NO_NODE, =
0);
> +       return 0;
> +}

Ah, I see, so this would be a PTR_TO_BTF_ID then. Fair enough, we can
leave that restriction off and rely on the check in
process_kf_arg_ptr_to_btf_id().

--OTPhCgEK1xrWltHI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZcZ6ngAKCRBZ5LhpZcTz
ZN9GAQCje7ooc97DoJ9MvM12JQDUMudgn6GSD6WCIoqHuRxIlgEApjgHVtPsRx71
xs8hqMfqGUYgQHwU1yjbVBZ6Icf8pw4=
=HtPM
-----END PGP SIGNATURE-----

--OTPhCgEK1xrWltHI--

