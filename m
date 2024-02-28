Return-Path: <bpf+bounces-22900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 233E086B665
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C414928B012
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A77D15DBBB;
	Wed, 28 Feb 2024 17:50:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843493FBB5
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142637; cv=none; b=g4NLikw2n89pvk6+7PN+qbMd1NTdeXn0Er86hMrXWiMPPBCrr0g3Kz1TMjzp32VCQ+KRAEkO8QvC3aDLX6W3lcnUrFAf5AnmX17yxi9I/vgPH0s3ITflpKMwbAAI3lZXVH6kiPcReKuEIOBSVq4BtNdec4mm+n5NwvLG6dAlbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142637; c=relaxed/simple;
	bh=lW+xnJSu+zUHqhVm/CHwqyav43Mix12/0OxBlAW7mMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3VdKVLyXBZdfU5iuL4F5vnP1HyF5AweDhY5Uuyn2IlLRXDGVR/C0+05n4aR0YALVajjmv1gbNpT1Cz+ZxnvveRqP6LhXrbph7tVIaYDth9Z7/92lpn26i7X2aC745Fns0dtv2Vpju5RnUPoiexG7hSoLk+8UbT9JU+AtBTHBA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a089f333bdso1971013eaf.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142634; x=1709747434;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lowdhJEAHbqy0dqwIjI+Ro3q8Z9pmoFE5MiFqAGxxEQ=;
        b=U7H7n6g9WiWRnQ3WitWHiW8hLCvlPwI8xiPc0aOEAwlc37WD9CdctLf0acepJwd3N4
         wEJ8J+lze0UXtQQ4JqD4C5f5upbU1pAt235T9Up3Ymn0w78HT63oWHozK6jvmlwN7Zct
         W6BUIjCZhXlu3xZnSIow/+pV6H6ku+F9b6qgrjcwHxj42K+2Gg3m56HXYnDjSvoy94oX
         7Zrz0nQYWGfuDk9FAIu2rbWwUOOy/m4hs208T1VZ/v52yvSkXvqs9Dj506Mabofu86HG
         9uiW4GrUrXptEXs3W7WgzJTBkk1wsgppSdXV+ALfyQSUlBxTyl+a8W3Pyfxtp9vEV9lb
         ba5A==
X-Gm-Message-State: AOJu0YyzgCjNC1i56FclKqLZyp2bT9nhgKwQdIsGGOuQL3mY/zUJqv4L
	ZHEr3ekngjYyM+JJu/fREJq0YFtSTkcoajct6BPUABQfYQ3/h0WK
X-Google-Smtp-Source: AGHT+IF4MoyzKCdvASolSRaoOLlYwHnQ0VejTz+/4ECbtVWHD4C3zT7K5ZHDbBRaLmiTy87aA2tjMg==
X-Received: by 2002:a05:6358:428e:b0:17b:71cc:8f5a with SMTP id s14-20020a056358428e00b0017b71cc8f5amr243186rwc.27.1709142634326;
        Wed, 28 Feb 2024 09:50:34 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id pi18-20020a05620a379200b00787af8b5c02sm6897qkn.39.2024.02.28.09.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:50:33 -0800 (PST)
Date: Wed, 28 Feb 2024 11:50:31 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 2/8] libbpf: tie struct_ops programs to
 kernel BTF ids, not to local ids
Message-ID: <20240228175031.GE148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-3-eddyz87@gmail.com>
 <20240228172313.GB148327@maniforge>
 <024a6e047b4c593db26b7d3d59a82cc723db5829.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YY2Ut7ap3aQiS1yh"
Content-Disposition: inline
In-Reply-To: <024a6e047b4c593db26b7d3d59a82cc723db5829.camel@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--YY2Ut7ap3aQiS1yh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 07:40:33PM +0200, Eduard Zingerman wrote:
> On Wed, 2024-02-28 at 11:23 -0600, David Vernet wrote:
> > On Tue, Feb 27, 2024 at 10:45:50PM +0200, Eduard Zingerman wrote:
> > > Enforce the following existing limitation on struct_ops programs based
> > > on kernel BTF id instead of program-local BTF id:
> > >=20
> > >     struct_ops BPF prog can be re-used between multiple .struct_ops &
> > >     .struct_ops.link as long as it's the same struct_ops struct
> > >     definition and the same function pointer field
> >=20
> > Am I correct in understanding the code that the prog also has to be at =
the same
> > offset in the new type?
>=20
> Yes, but after this patch it would be offset in current kernel BTF type,
> not local BTF type.

Yes, indeed. I didn't mean to imply that your patch was changing that. I was
asking more generally -- sorry for the confusion.

> > So if we have for example:
> >=20
> > SEC("struct_ops/test")
> > int BPF_PROG(foo) { ... }
> >=20
> > struct some_ops___v1 {
> > 	int (*test)(void);
> > };
> >=20
> > struct some_ops___v2 {
> > 	int (*init)(void);
> > 	int (*test)(void);
> > };
>=20
> From pov of kernel BTF there is only one 'struct some_ops'.

Ack

> > Then this wouldn't work? If so, would it be possible for libbpf to do s=
omething
> > like invisibly duplicate the prog and create a separate one for each st=
ruct_ops
> > map where it's encountered? It feels like a rather awkward restriction =
to
> > impose given that the idea behind the feature is to enable loading one =
of
> > multiple possible definitions of a struct_ops type.=20
>=20
> In combination with the next patch, the idea is to not assign offset
> in struct_ops maps which have autocreate =3D=3D false.
>=20
> If object corresponding to program above would be opened and
> autocreate would be disabled either for some_ops___v1 or some_ops___v2
> before load, the program 'test' would get it's offset entry only from
> one map. Thus no program duplication would be necessary.
>=20
> For example, see test case in patch #6:
>=20
>     struct bpf_testmod_ops___v1 {
>     	int (*test_1)(void);
>     };
>=20
>     struct bpf_testmod_ops___v2 {
>     	int (*test_1)(void);
>     	int (*does_not_exist)(void);
>     };
>=20
>     SEC(".struct_ops.link")
>     struct bpf_testmod_ops___v1 testmod_1 =3D {
>     	.test_1 =3D (void *)test_1
>     };
>=20
>     SEC(".struct_ops.link")
>     struct bpf_testmod_ops___v2 testmod_2 =3D {
>     	.test_1 =3D (void *)test_1,
>     	.does_not_exist =3D (void *)test_2
>     };
>=20
>=20
> static void can_load_partial_object(void)
> {
> 	...
> 	skel =3D struct_ops_autocreate__open_opts(&opts);
> 	bpf_program__set_autoload(skel->progs.test_2, false);
> 	bpf_map__set_autocreate(skel->maps.testmod_2, false);
> 	struct_ops_autocreate__load(skel);
>         ...
> }
>=20
> This should handle your example as well.
> Do you find this sufficient or would you still like to have implicit
> program duplication logic?

It's definitely fine for now, but IMO it's something to keep in mind for the
future as a usability improvement. Ideally libbpf could internally handle j=
ust
creating and loading the type that's actually present on the system, and ha=
ndle
applying the prog to the correct map, etc on the caller's behalf. Given that
there's only ever a single instance of a struct_ops type on the system, this
seems like a reasonable feature for the library to provide.

Note that this doesn't necessarily require duplicating the prog either, if
libbpf can instead _deduplicate_ the struct_ops maps to only create and load
the one that matches the type on the system.

Not a blocker by any means, but possibly a nice to have down the road.

--YY2Ut7ap3aQiS1yh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd9yZwAKCRBZ5LhpZcTz
ZNffAP9QhlAjJwx9qvOKrVj6ee3Q+r5np0/2nC5jxbNaZGGBrgEAr9EVJYsk9a45
Sl5KH9BXx0kSrpJTcy65yJxa5opOswo=
=465h
-----END PGP SIGNATURE-----

--YY2Ut7ap3aQiS1yh--

