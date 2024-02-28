Return-Path: <bpf+bounces-22908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E131786B731
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B501C2299C
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4061840877;
	Wed, 28 Feb 2024 18:29:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DDE71EBC
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144995; cv=none; b=GxLXko1E5pn5pZVOhfF4q8G96IH5QJf70hiTrQ18bzdq9MsDFFV8YR4lOBcK1/rb1HmVLmwPLqHi2eX4HaKK61kIhBpQ87LPkGH7D3VEe91b/0kGxQXWOdZjJj3SOa282zYGKM88sZfFys/qOfjE8gFT2LTQPal2cv8RHBck9rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144995; c=relaxed/simple;
	bh=6R69y1pbIlS5CgvRsH4nrltuNXWNMliqJJZqeGR5DUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqOiD9E2Z44aFfm4GsKurEWWbU7hmEotmEOZVgIqsPuEv2405bj5y8fo2QivcOOuclE2nIptDZxHJ/tI87KIIZ5uzFUE4yCl3OeSv43wdWdod5Va1vuemv+3D99N+/3zfF2qmiP6xplJo9fXsR/dL48V9wly3y7AOuq2WJ8u4DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-471e18cd6e3so11518137.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 10:29:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144992; x=1709749792;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wjSRSTkNHyS4ND1QB26v88D27uCZjvzcmXQpVpeB/w=;
        b=n3Eg+LSWdBbgp0wI0Vv1MIAOQsd3iY5XBaX3Nt2yAF582D43/0GpKA/zP49i/ITYyX
         LKjsT1SD7ggIymN7ZO+7qslj9t5L5YQ3Fyn8tmmXnJmRVCyOFnJQZ6xflR9ib8+JOWvA
         K3dusy3NUOrKCVutw4MevgpbCr5h076CWDTxrZ/wLX9sTuzCX7o6lknfagl1gl21Fp0R
         RljK1S/iYAcpSVTMK7iZaG247ImgkUqPoMcz8xjpbxSBO7C+WOK5Rj+uvmgAgJXThhzk
         UMWdRkrIxmQ9+qsqTQBcYtabxDhqz0/JxB8dB2qtTlRlSeTHwo0dwal77mgfcIf1mAY6
         pY3g==
X-Gm-Message-State: AOJu0YycF3zTp77osw1gXp3YseVNTcpd/1E1O9cwJsbCZ0UXhQc4rcHv
	9kGTTtv5uvr3FnPa2bl+HoE0j0rvZ2GUU3cbVOmVuS2i/CUY9RJS
X-Google-Smtp-Source: AGHT+IH4id1WVsZcvtRwJuAKjxZU9rMvdNblS5msQNZiiqABJVfmBDUz8/e98cFa77XxCbhRi/8hPQ==
X-Received: by 2002:a05:6102:134d:b0:472:73b2:a527 with SMTP id j13-20020a056102134d00b0047273b2a527mr383267vsl.8.1709144991889;
        Wed, 28 Feb 2024 10:29:51 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id c16-20020ac81110000000b0042c792f3255sm9626qtj.15.2024.02.28.10.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:29:51 -0800 (PST)
Date: Wed, 28 Feb 2024 12:29:49 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
Message-ID: <20240228182949.GH148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-7-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+q6U5APMp+H78V0F"
Content-Disposition: inline
In-Reply-To: <20240227204556.17524-7-eddyz87@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--+q6U5APMp+H78V0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:45:54PM +0200, Eduard Zingerman wrote:
> Check that bpf_map__set_autocreate() can be used to disable automatic
> creation for struct_ops maps.
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../bpf/prog_tests/struct_ops_autocreate.c    | 79 +++++++++++++++++++
>  .../bpf/progs/struct_ops_autocreate.c         | 42 ++++++++++
>  2 files changed, 121 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_aut=
ocreate.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocrea=
te.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate=
=2Ec b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> new file mode 100644
> index 000000000000..b21b10f94fc2
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "struct_ops_autocreate.skel.h"
> +
> +#define EXPECTED_MSG "libbpf: struct_ops init_kern"
> +
> +static libbpf_print_fn_t old_print_cb;
> +static bool msg_found;
> +
> +static int print_cb(enum libbpf_print_level level, const char *fmt, va_l=
ist args)
> +{
> +	old_print_cb(level, fmt, args);
> +	if (level =3D=3D LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, strlen(EXPEC=
TED_MSG)) =3D=3D 0)
> +		msg_found =3D true;
> +
> +	return 0;
> +}
> +
> +static void cant_load_full_object(void)
> +{
> +	struct struct_ops_autocreate *skel;
> +	int err;
> +
> +	old_print_cb =3D libbpf_set_print(print_cb);
> +	skel =3D struct_ops_autocreate__open_and_load();

Optional suggestion: It might be useful to add a comment here explaining
exactly why we expect this to fail? Something like:

	/* The testmod_2 map BTF type (struct bpf_testmod_ops___v2) doesn't
	 * match the BTF of the actual struct bpf_testmod_ops defined in the
	 * kernel, so we should fail to load it if we don't disable autocreate
	 * for the map.
	 */

Feel free to ignore -- I recognize that some might just consider that
unnecessary noise.

> +	err =3D errno;
> +	libbpf_set_print(old_print_cb);
> +	if (!ASSERT_NULL(skel, "struct_ops_autocreate__open_and_load"))
> +		return;
> +
> +	ASSERT_EQ(err, ENOTSUP, "errno should be ENOTSUP");
> +	ASSERT_TRUE(msg_found, "expected message");
> +
> +	struct_ops_autocreate__destroy(skel);
> +}
> +
> +static void can_load_partial_object(void)
> +{
> +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> +	struct struct_ops_autocreate *skel;
> +	struct bpf_link *link =3D NULL;
> +	int err;
> +
> +	skel =3D struct_ops_autocreate__open_opts(&opts);
> +	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
> +		return;
> +
> +	err =3D bpf_program__set_autoload(skel->progs.test_2, false);
> +	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
> +		goto cleanup;

It feels a bit awkward to have to specify that a struct_ops prog isn't
autoloaded if it's not associated with an autoloaded / autocreated struct_o=
ps
map. Would it be possible to teach libbpf to not autoload such progs by
default?

> +	err =3D bpf_map__set_autocreate(skel->maps.testmod_2, false);
> +	if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
> +		goto cleanup;
> +
> +	err =3D struct_ops_autocreate__load(skel);
> +	if (ASSERT_OK(err, "struct_ops_autocreate__load"))
> +		goto cleanup;
> +
> +	link =3D bpf_map__attach_struct_ops(skel->maps.testmod_1);
> +	if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
> +		goto cleanup;
> +
> +	/* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.c */
> +	ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
> +
> +cleanup:
> +	bpf_link__destroy(link);
> +	struct_ops_autocreate__destroy(skel);
> +}
> +
> +void serial_test_struct_ops_autocreate(void)
> +{
> +	if (test__start_subtest("cant_load_full_object"))
> +		cant_load_full_object();
> +	if (test__start_subtest("can_load_partial_object"))
> +		can_load_partial_object();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c b/=
tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
> new file mode 100644
> index 000000000000..294d48bb8e3c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_autocreate.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +int test_1_result =3D 0;
> +
> +SEC("struct_ops/test_1")
> +int BPF_PROG(test_1)
> +{
> +	test_1_result =3D 42;
> +	return 0;
> +}
> +
> +SEC("struct_ops/test_1")
> +int BPF_PROG(test_2)
> +{
> +	return 0;
> +}
> +
> +struct bpf_testmod_ops___v1 {
> +	int (*test_1)(void);
> +};
> +
> +struct bpf_testmod_ops___v2 {
> +	int (*test_1)(void);
> +	int (*does_not_exist)(void);
> +};
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops___v1 testmod_1 =3D {
> +	.test_1 =3D (void *)test_1
> +};
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops___v2 testmod_2 =3D {
> +	.test_1 =3D (void *)test_1,
> +	.does_not_exist =3D (void *)test_2
> +};
> --=20
> 2.43.0
>=20

--+q6U5APMp+H78V0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd97nQAKCRBZ5LhpZcTz
ZC7rAQDvlp6FMOd5v0dfSYLwKvmJdavIpG2LrdJS49PF8WTO4gD9H6+VmfKkycre
dg1sZ1e4x4R+Cp/EfYpNuM/MxWO7jA8=
=xiQW
-----END PGP SIGNATURE-----

--+q6U5APMp+H78V0F--

