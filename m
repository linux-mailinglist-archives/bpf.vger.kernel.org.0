Return-Path: <bpf+bounces-22911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B2E86B741
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CA31F23417
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7677C79B79;
	Wed, 28 Feb 2024 18:37:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAE40875
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145425; cv=none; b=iGqN1lRfioejbSW9lcKcF+LbgCrHJDC0vaitZhYuX8Vrocbau8gEOxQHy8UoRwV7D3zjQYjSWLAh77bdioayNCX81bA6j6WYf48NScFEfwo/YVkh/x1nlVGxedc9SHm5femHgoEW+KT939PzOLPUA1mfzY4ER6MdC7S05msu3Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145425; c=relaxed/simple;
	bh=JiHQfeP8bDKBI+PKsbgDcawpxvodyo8Ketm0HYCkfGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKi6e7/ieh0z/EnJmsqMpKmluNW5TVd8lEBmdopXLeBzqUWJoUJ6ONLNfgL3+IoVdqTtTgG4VucXmpeFPrxvS5V99ILh5MFQW+Apsw5fEePnRakT6seiVsZZT7/4+ksi9H8jsEk9m6e00YUwS11UqIMIvnBaS+vipTV0T2JIbLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-787df45e513so4045285a.1
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 10:37:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709145422; x=1709750222;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KHp4cWZddyywyIuTLIc+RBjNv9T2j3+WX9YDINhl6M=;
        b=k1g9IrSy+1bksxRLR+q0cflh5ZTm7J0oASiGpEbpGOX6o4MDQ2J5Jpi+DQic3zU0bs
         wuzBM7S8JdPRnVpqso9JAShWrq2fLDx1frCISzZIW+Z3RNsGoKYl2d7+WbcaONqYqBhV
         mnl58EuOx2LL6fSKvUkoyC6y0z+Q2Fvkdke251+4Kw9f9+t+vAd0fPlHVl50hg9XZxQD
         bxWU7IUtFXHuQNp8z5AyAWxCNV30INMo48hHJP5oc62GLiZeAlKPnwbk5rUc5Omt/faU
         /5TrNa0bo63b3D7bKdSXV7UeoZ/ZTzlc4DTQstYXEIfgaKPwsD2c8++Ezp/cA+4ocpLF
         zgaA==
X-Gm-Message-State: AOJu0YwRhbfJazcGKDlnkEKKtWFcGoyD2fFUOQzHl/s+c71Zjn28ccPI
	1xNmUuIVlkl7GjoQ0Zvu0LMtEwEmp+2ZqlDLdYxnU7jpASniEY5FdUH46M78
X-Google-Smtp-Source: AGHT+IF2qruaBK1jP3sPSRXDYNbIjSGPTYQzEHyKnPbSyTJCDlvMRDrfrgbscIppxzWgCMNZrmtmiw==
X-Received: by 2002:a05:620a:3703:b0:787:284b:3044 with SMTP id de3-20020a05620a370300b00787284b3044mr7599423qkb.77.1709145422254;
        Wed, 28 Feb 2024 10:37:02 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b00785d893a692sm46164qkp.27.2024.02.28.10.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:37:01 -0800 (PST)
Date: Wed, 28 Feb 2024 12:36:58 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 8/8] selftests/bpf: tests for struct_ops
 autoload/autocreate toggling
Message-ID: <20240228183658.GJ148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-9-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zFIXGLLoGHVUtYA4"
Content-Disposition: inline
In-Reply-To: <20240227204556.17524-9-eddyz87@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--zFIXGLLoGHVUtYA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:45:56PM +0200, Eduard Zingerman wrote:
> Verify automatic interaction between struct_ops map autocreate flag
> and struct_ops programs autoload flags.
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../bpf/prog_tests/struct_ops_autocreate.c    | 65 +++++++++++++++++--
>  1 file changed, 61 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate=
=2Ec b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> index b21b10f94fc2..ace296aae8c4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> @@ -46,10 +46,6 @@ static void can_load_partial_object(void)
>  	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
>  		return;
> =20
> -	err =3D bpf_program__set_autoload(skel->progs.test_2, false);
> -	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
> -		goto cleanup;
> -
>  	err =3D bpf_map__set_autocreate(skel->maps.testmod_2, false);
>  	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
>  		goto cleanup;
> @@ -70,8 +66,69 @@ static void can_load_partial_object(void)
>  	struct_ops_autocreate__destroy(skel);
>  }
> =20
> +static void autoload_toggles(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	struct bpf_map *testmod_1, *testmod_2;
> +	struct bpf_program *test_1, *test_2;
> +	struct struct_ops_autocreate *skel;
> +
> +	skel =3D struct_ops_autocreate__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
> +		return;
> +
> +	testmod_1 =3D skel->maps.testmod_1;
> +	testmod_2 =3D skel->maps.testmod_2;
> +	test_1 =3D skel->progs.test_1;
> +	test_2 =3D skel->progs.test_2;
> +
> +	/* testmod_1 on, testmod_2 on */
> +	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #1");
> +	ASSERT_TRUE(bpf_program__autoload(test_2), "autoload(test_2) #1");
> +
> +	/* testmod_1 off, testmod_2 on */
> +	bpf_map__set_autocreate(testmod_1, false);
> +	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #2");
> +	ASSERT_TRUE(bpf_program__autoload(test_2), "autoload(test_2) #2");
> +
> +	/* testmod_1 off, testmod_2 off,
> +	 * setting same state several times should not confuse internal state.
> +	 */
> +	bpf_map__set_autocreate(testmod_2, false);
> +	bpf_map__set_autocreate(testmod_2, false);

Duplicate line

> +	ASSERT_FALSE(bpf_program__autoload(test_1), "autoload(test_1) #3");
> +	ASSERT_FALSE(bpf_program__autoload(test_2), "autoload(test_2) #3");
> +
> +	/* testmod_1 on, testmod_2 off */
> +	bpf_map__set_autocreate(testmod_1, true);
> +	bpf_map__set_autocreate(testmod_1, true);

Here as well

> +	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #4");
> +	ASSERT_FALSE(bpf_program__autoload(test_2), "autoload(test_2) #4");
> +
> +	/* testmod_1 on, testmod_2 on */
> +	bpf_map__set_autocreate(testmod_2, true);
> +	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #5");
> +	ASSERT_TRUE(bpf_program__autoload(test_2), "autoload(test_2) #5");
> +
> +	/* testmod_1 on, testmod_2 off */
> +	bpf_map__set_autocreate(testmod_2, false);
> +	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #6");
> +	ASSERT_FALSE(bpf_program__autoload(test_2), "autoload(test_2) #6");
> +
> +	/* setting autoload manually overrides automatic toggling */
> +	bpf_program__set_autoload(test_2, false);
> +	/* testmod_1 on, testmod_2 off */
> +	bpf_map__set_autocreate(testmod_2, true);
> +	ASSERT_TRUE(bpf_program__autoload(test_1), "autoload(test_1) #7");
> +	ASSERT_FALSE(bpf_program__autoload(test_2), "autoload(test_2) #7");
> +
> +	struct_ops_autocreate__destroy(skel);
> +}
> +
>  void serial_test_struct_ops_autocreate(void)
>  {
> +	if (test__start_subtest("autoload_toggles"))
> +		autoload_toggles();
>  	if (test__start_subtest("cant_load_full_object"))
>  		cant_load_full_object();
>  	if (test__start_subtest("can_load_partial_object"))
> --=20
> 2.43.0
>=20

--zFIXGLLoGHVUtYA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd99SgAKCRBZ5LhpZcTz
ZIvhAQDOyTjSKuR3Yx1JBwLUMo+qMeXhz0oXz8D8kACERclt2AEAj2/hQdFSQ26L
ItcEaSwNfLphCT5gsVUprPi9zxtzHgE=
=1Ndv
-----END PGP SIGNATURE-----

--zFIXGLLoGHVUtYA4--

