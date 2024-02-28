Return-Path: <bpf+bounces-22902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3053186B6A8
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540FA1C22627
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFAD79B73;
	Wed, 28 Feb 2024 18:03:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F440846
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143439; cv=none; b=D1RIvS3s8cXKYid3ey0tOdCFq/r06tWtscrhs4ITU6IFgji8M5w9j4p/w8CZTmYyr+jpGqsq6TQOrhJe68CJuMEfyG/E8uAcJqnR50E6s8Bui9Baf72U8T1bCB4XgMmWWZ08AuMtQkoYIGwOnG6Y3mzDBe/ovvBjN8E44iax0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143439; c=relaxed/simple;
	bh=bcA8/mWGtYf7xrk5EjBRYHqju7qfq2ZQ66gBvqM4NPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqTIw48z3BR7s+uFJMUPG6uOw+RxhKJascxF2Z/lBmUBeoaiNorZ2KROe7JhuCixCSfEICH1+cx2tDtgKVpwhaZJU9BLd+6cheNfts36xi8uGt+SCAb/YLCa/EDXbun17YsC56n4Sb/fVmf6KzQXmwjxiN+chOwamzfXmTCJ2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c1af1e8b7eso1023392b6e.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 10:03:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709143437; x=1709748237;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cNoKSD9wpIFro2KO33wWiTgQN/gFybDk9Kf/2Ks0kY=;
        b=Vqi7cHo8kr7spKLxKe26O2S9xJ48DzRX+gRI0SP1TTy4r1e31z+f4r+ImbWwZu/S7M
         BsSnNUHqJJgTvjeJix5s3FyQy/PntZO1kXTmRey1PPhPaEFcqgCsiA1NT+SsWGhM8+Ni
         FEPgMkxbhEKD2pEoa+hc3Tun0KmhCdjhfDvQ9xFabz141kC6rg3X2UpofuH6H+s6wUiE
         87HsQbqZS/SQ3x10FC3SMZXrlsXTmgk5XQ90o8+sopUPhzSJF5sfKf5PFKLlb7emhP8O
         j0EQOC72YLblWIusToLAyASb9cjCe8awFg9qO4Z3sR2KfYnBupXlOkE9pRRuGTHwyckn
         bnrw==
X-Gm-Message-State: AOJu0YzctviwvbI+wvyZbkaBg3xfVtkukRPKAFUYeapIhvDgYOwr9eet
	K1YnRAMheJli3LpzrGJMhPK2M+h2WRTWGAtxDyTjSmtImpZLXvIe
X-Google-Smtp-Source: AGHT+IGt7fceY8lwd0pL2cuu6c46eLzkROWN9Uen1dKz1AEr2EpS2GLMR3J9vDIINME6K1MccN8LAg==
X-Received: by 2002:a05:6358:701:b0:17b:b6f8:edd3 with SMTP id e1-20020a056358070100b0017bb6f8edd3mr219549rwj.17.1709143436693;
        Wed, 28 Feb 2024 10:03:56 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id l11-20020ac84ccb000000b0042e224098eesm4756218qtv.27.2024.02.28.10.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:03:54 -0800 (PST)
Date: Wed, 28 Feb 2024 12:03:52 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 4/8] selftests/bpf: test struct_ops map
 definition with type suffix
Message-ID: <20240228180352.GF148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-5-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/TGDGFiLgeu1ewCD"
Content-Disposition: inline
In-Reply-To: <20240227204556.17524-5-eddyz87@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--/TGDGFiLgeu1ewCD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:45:52PM +0200, Eduard Zingerman wrote:
> Extend struct_ops_module test case to check if it is possible to use
> '___' suffixes for struct_ops type specification.
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Acked-by: David Vernet <void@manifault.com>

> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  1 +
>  .../bpf/prog_tests/test_struct_ops_module.c   | 32 +++++++++++++------
>  .../selftests/bpf/progs/struct_ops_module.c   | 21 +++++++++++-
>  3 files changed, 44 insertions(+), 10 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 66787e99ba1b..0d8437e05f64 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -555,6 +555,7 @@ static int bpf_dummy_reg(void *kdata)
>  {
>  	struct bpf_testmod_ops *ops =3D kdata;
> =20
> +	ops->test_1();
>  	/* Some test cases (ex. struct_ops_maybe_null) may not have test_2
>  	 * initialized, so we need to check for NULL.
>  	 */
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_modul=
e.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> index 8d833f0c7580..7bc80d2755f1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_module.c
> @@ -30,12 +30,30 @@ static void check_map_info(struct bpf_map_info *info)
>  	close(fd);
>  }
> =20
> +static int attach_ops_and_check(struct struct_ops_module *skel,
> +				struct bpf_map *map,
> +				int expected_test_2_result)
> +{
> +	struct bpf_link *link;
> +
> +	link =3D bpf_map__attach_struct_ops(map);
> +	ASSERT_OK_PTR(link, "attach_test_mod_1");
> +	if (!link)
> +		return -1;
> +
> +	/* test_{1,2}() would be called from bpf_dummy_reg() in bpf_testmod.c */
> +	ASSERT_EQ(skel->bss->test_1_result, 0xdeadbeef, "test_1_result");
> +	ASSERT_EQ(skel->bss->test_2_result, expected_test_2_result, "test_2_res=
ult");
> +
> +	bpf_link__destroy(link);
> +	return 0;
> +}
> +
>  static void test_struct_ops_load(void)
>  {
>  	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
>  	struct struct_ops_module *skel;
>  	struct bpf_map_info info =3D {};
> -	struct bpf_link *link;
>  	int err;
>  	u32 len;
> =20
> @@ -53,15 +71,11 @@ static void test_struct_ops_load(void)
>  	if (!ASSERT_OK(err, "bpf_map_get_info_by_fd"))
>  		goto cleanup;
> =20
> -	link =3D bpf_map__attach_struct_ops(skel->maps.testmod_1);
> -	ASSERT_OK_PTR(link, "attach_test_mod_1");
> -
> -	/* test_2() will be called from bpf_dummy_reg() in bpf_testmod.c */
> -	ASSERT_EQ(skel->bss->test_2_result, 7, "test_2_result");
> -
> -	bpf_link__destroy(link);
> -
>  	check_map_info(&info);
> +	if (!attach_ops_and_check(skel, skel->maps.testmod_1, 7))
> +		goto cleanup;
> +	if (!attach_ops_and_check(skel, skel->maps.testmod_2, 12))
> +		goto cleanup;
> =20
>  cleanup:
>  	struct_ops_module__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_module.c b/tool=
s/testing/selftests/bpf/progs/struct_ops_module.c
> index b78746b3cef3..e91426dc51af 100644
> --- a/tools/testing/selftests/bpf/progs/struct_ops_module.c
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_module.c
> @@ -7,12 +7,14 @@
> =20
>  char _license[] SEC("license") =3D "GPL";
> =20
> +int test_1_result =3D 0;
>  int test_2_result =3D 0;
> =20
>  SEC("struct_ops/test_1")
>  int BPF_PROG(test_1)
>  {
> -	return 0xdeadbeef;
> +	test_1_result =3D 0xdeadbeef;
> +	return 0;
>  }
> =20
>  SEC("struct_ops/test_2")
> @@ -27,3 +29,20 @@ struct bpf_testmod_ops testmod_1 =3D {
>  	.test_2 =3D (void *)test_2,
>  };
> =20
> +SEC("struct_ops/test_2")
> +void BPF_PROG(test_2_v2, int a, int b)
> +{
> +	test_2_result =3D a * b;
> +}
> +
> +struct bpf_testmod_ops___v2 {
> +	int (*test_1)(void);
> +	void (*test_2)(int a, int b);
> +	int (*test_maybe_null)(int dummy, struct task_struct *task);
> +};
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops___v2 testmod_2 =3D {
> +	.test_1 =3D (void *)test_1,
> +	.test_2 =3D (void *)test_2_v2,
> +};
> --=20
> 2.43.0
>=20

--/TGDGFiLgeu1ewCD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd91iAAKCRBZ5LhpZcTz
ZIQYAPwN4Zfz/xEAQ/GSjCe4beDWkubSI1XpcOuTFQGqvRje2gEAnW4SbVmK92MQ
930NGoR/cC55S48+yfeef6ymU9Jtqg0=
=kmkG
-----END PGP SIGNATURE-----

--/TGDGFiLgeu1ewCD--

