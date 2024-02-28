Return-Path: <bpf+bounces-22903-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778086B6F5
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D2A2821BC
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9454084E;
	Wed, 28 Feb 2024 18:15:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB1440847
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144158; cv=none; b=k/0oNXR2cZrPp/T6NsPU5ReD6aqUl2v6ROdm5b9GIa06zDR0EOoNtiP21Tkycl25PGnde0bJqlpwccemQU0uB3v8L5omkAg954K3i3TmUjLyLJRWF6sBFUrAIFuCREkRoVonQMyt/gZ+I7aBrZX9DVUHI5numwrIh0Zf3aS33Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144158; c=relaxed/simple;
	bh=JB52IKxLYE54TYE1I/T7OqSKBdOuTCoL8uq7aOG3TNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vf2QEuJN0MeOJFVLWXlD0zRHyX2RaROObSda2rKuv5GWjFlQHN+yAypv0iFx86Ow8/It3yN9RDYxv/70wigMphYu3rcD3Z5mekVeiP6ii2LrzJ0gsqtEfu2F5tgVPuV2SWlGcXunQlrtz/mBeFKCCdi66Ys+7atMQxdeFkMCu7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7810827e54eso2431785a.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 10:15:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144155; x=1709748955;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lYfUPidUSROJc7hlPtc58bHtg+JzC+AM2xhlFfLQzY=;
        b=NMn7ooYC6qtgSIPOHlPMEql1Ova855azmZlrXSDEy+RJGpIicEVPnLGiKG+qZF4IP9
         UFPZbY4bPrHpWpesW1gK0y4U8gZk1/bb5tEZqNvmT6Ixaz2+uMGp/Hk6PonNfqNPTQt4
         LJ2iBlrbZMkEy8VZli1DZeAC43GUlV9TMjKo06+HlxuqKzzuYGI1tevmBsNum07ogbLP
         ons5VXxIWuo9WIOhmxtFmE3I1nqUtX+tQ/nC/JZu4eZVmBH/DEyBy5RisKmsNJid1YCr
         sv5piAJzoqoeaTST0LZCeultdWhwdDjOY8sOyYlLbPoPiWR0TDk1YXmVeBki2QrYnaJW
         gt9A==
X-Gm-Message-State: AOJu0YwaiRuzOWozFqbIh63YJBM+ut8ilgwRGcp1wVhmAyWMmx+686lb
	qcrf2isqWgr5UxNbJQ4HnFFXG6E0+RBbtPVWlhRLdGFhhUvM8G4f
X-Google-Smtp-Source: AGHT+IH5fmpIKIELheP4X7RbT4A4OwkpSYPbQ4XRXhDrvXgSItgTDgasLcGO5nYfp3HPY6s0pHCVWw==
X-Received: by 2002:ad4:5caa:0:b0:68f:e9dc:a6ed with SMTP id q10-20020ad45caa000000b0068fe9dca6edmr7921648qvh.47.1709144154789;
        Wed, 28 Feb 2024 10:15:54 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id kf6-20020a056214524600b0068fa815b517sm25325qvb.6.2024.02.28.10.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:15:54 -0800 (PST)
Date: Wed, 28 Feb 2024 12:15:52 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: bad_struct_ops test
Message-ID: <20240228181552.GG148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-6-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aLVqNIKvnubjwbUt"
Content-Disposition: inline
In-Reply-To: <20240227204556.17524-6-eddyz87@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--aLVqNIKvnubjwbUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 10:45:53PM +0200, Eduard Zingerman wrote:
> When loading struct_ops programs kernel requires BTF id of the
> struct_ops type and member index for attachment point inside that
> type. This makes it not possible to have same BPF program used in
> struct_ops maps that have different struct_ops type.
> Check if libbpf rejects such BPF objects files.
>=20
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 ++
>  .../selftests/bpf/prog_tests/bad_struct_ops.c | 42 +++++++++++++++++++
>  .../selftests/bpf/progs/bad_struct_ops.c      | 17 ++++++++
>  4 files changed, 87 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops=
=2Ec
>  create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
>=20
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 0d8437e05f64..69f5eb9ad546 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -601,6 +601,29 @@ struct bpf_struct_ops bpf_bpf_testmod_ops =3D {
>  	.owner =3D THIS_MODULE,
>  };
> =20
> +static int bpf_dummy_reg2(void *kdata)
> +{
> +	struct bpf_testmod_ops2 *ops =3D kdata;
> +
> +	ops->test_1();
> +	return 0;
> +}
> +
> +static struct bpf_testmod_ops2 __bpf_testmod_ops2 =3D {
> +	.test_1 =3D bpf_testmod_test_1,
> +};
> +
> +struct bpf_struct_ops bpf_testmod_ops2 =3D {
> +	.verifier_ops =3D &bpf_testmod_verifier_ops,
> +	.init =3D bpf_testmod_ops_init,
> +	.init_member =3D bpf_testmod_ops_init_member,
> +	.reg =3D bpf_dummy_reg2,
> +	.unreg =3D bpf_dummy_unreg,
> +	.cfi_stubs =3D &__bpf_testmod_ops2,
> +	.name =3D "bpf_testmod_ops2",
> +	.owner =3D THIS_MODULE,
> +};
> +
>  extern int bpf_fentry_test1(int a);
> =20
>  static int bpf_testmod_init(void)
> @@ -612,6 +635,7 @@ static int bpf_testmod_init(void)
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_te=
stmod_kfunc_set);
>  	ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_te=
stmod_kfunc_set);
>  	ret =3D ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmo=
d_ops);
> +	ret =3D ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_o=
ps2);
>  	if (ret < 0)
>  		return ret;
>  	if (bpf_fentry_test1(0) < 0)
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> index c3b0cf788f9f..3183fff7f246 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> @@ -37,4 +37,8 @@ struct bpf_testmod_ops {
>  	int (*test_maybe_null)(int dummy, struct task_struct *task);
>  };
> =20
> +struct bpf_testmod_ops2 {
> +	int (*test_1)(void);
> +};
> +
>  #endif /* _BPF_TESTMOD_H */
> diff --git a/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c b/to=
ols/testing/selftests/bpf/prog_tests/bad_struct_ops.c
> new file mode 100644
> index 000000000000..9c689db4b05b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bad_struct_ops.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "bad_struct_ops.skel.h"
> +
> +#define EXPECTED_MSG "libbpf: struct_ops reloc"
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

Not necessary at all for this patch set / just an observation, but it would=
 be
nice to have this be something offered by the core prog_tests framework
(meaning, the ability to assert libbpf output for a testcase).

> +
> +static void test_bad_struct_ops(void)
> +{
> +	struct bad_struct_ops *skel;
> +	int err;
> +
> +	old_print_cb =3D libbpf_set_print(print_cb);
> +	skel =3D bad_struct_ops__open_and_load();
> +	err =3D errno;
> +	libbpf_set_print(old_print_cb);
> +	if (!ASSERT_NULL(skel, "bad_struct_ops__open_and_load"))
> +		return;
> +
> +	ASSERT_EQ(err, EINVAL, "errno should be EINVAL");
> +	ASSERT_TRUE(msg_found, "expected message");
> +
> +	bad_struct_ops__destroy(skel);
> +}
> +
> +void serial_test_bad_struct_ops(void)
> +{
> +	if (test__start_subtest("test_bad_struct_ops"))
> +		test_bad_struct_ops();
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops.c b/tools/t=
esting/selftests/bpf/progs/bad_struct_ops.c
> new file mode 100644
> index 000000000000..9c103afbfdb1
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "../bpf_testmod/bpf_testmod.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("struct_ops/test_1")
> +int BPF_PROG(test_1) { return 0; }
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops testmod_1 =3D { .test_1 =3D (void *)test_1 };

Just to make be 100% sure that we're isolating the issue under test, should=
 we
also add a .test_2 prog and add it to the struct bpf_testmod_ops map?

> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops2 testmod_2 =3D { .test_1 =3D (void *)test_1 };
> --=20
> 2.43.0
>=20

--aLVqNIKvnubjwbUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd94WAAKCRBZ5LhpZcTz
ZJ3eAP9yxbAYWFxwXW4t7F8/56dlyjSO3RTO3dey+vwnTLCmfwEAsHMpkD0dzegK
ZCGGm07srz68U8rO9VqHyFWExyqpLQM=
=PfR6
-----END PGP SIGNATURE-----

--aLVqNIKvnubjwbUt--

