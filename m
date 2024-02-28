Return-Path: <bpf+bounces-22910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C9A86B73B
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 19:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7401F26F3E
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B82F41A85;
	Wed, 28 Feb 2024 18:34:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8867279B7A
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145252; cv=none; b=cHokWNM1UTt1EQZ0cFHzmydSCxfNTJ+pbt6CMzNxCnphrrFRAoOq8UACfEIIGLDsFdyFyjrU81EYS28WLjGCS06K7iNVaEd/6jIu/PNo3AKos23ThbdYpgLgOMmfeS1GtztFp7TVA/chIKRNNPbwvvNluUaVCPcFJS+ezY6ehNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145252; c=relaxed/simple;
	bh=1n2dtS/UCWO3YZHWcl9z1ZaqBrZSnGrOPXPgPNNtkQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmqKcjWYm8grXASgH2rV3GabAglA/30e4g3bl6ZmLRBboPNgvGh8qfbR6XKQ5FyMHUONftCHr6SZppmDhFeVvgVA60XhnJYE2n3gw+70vUMpuvbTqeLtcJmLNahQCp0ApvBOoGxHJ2xXlLrkJOE3xZ462utoxvXp5n71enqllLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21ec3ca9ab9so2549125fac.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 10:34:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709145248; x=1709750048;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tIncm4s4KEDj39Btu+KUfIdXeJwsUmtneUE/X3RBVE4=;
        b=gQLnVApGd4BL3drDqwtYw9ZASC3eZfVkTBvvp/X/9Z6CQJbM24CQkUnbqMB1KWHrLx
         3bz4m6xnDRv5Ee2XQKtCIJtZ770+qVN+KGNF1Utm5OovMj0lD7isk4vniBRtLZ6AkJEH
         /qqiF1a1a/Q88xF3iPMwttKqTGY15Zw8/dLXRqhDeLQvu7GdpDCySKNDLm0A52dFhH2K
         LvWwDoWijWp8FKqTGXmihRJps9LqhJXIAjMoqcQTKTfQqhvoBAAaOGdUo2ATmqPNk1ri
         by/uD3/hVsbwPD+Jo4xgoKM4xBuUTb+W+UyFFc5k7h70a4ZO/vdwgswx34xnZbk46k4L
         6RAg==
X-Gm-Message-State: AOJu0YzLmXdFufxrGD2zH0k18BBl1YNa/l5f+ADa8ddurOuYPcPrAcYj
	wMqmIrcEehc17RVKwpvG887gwupSK7j+15oBP0R38ATbEn0n7jtd
X-Google-Smtp-Source: AGHT+IGeTXuivreZLQZKTd2rgTD/1P993kagx/ZeOLL7w687XJ1cRNwJGklxBIfly8jsjF22M7bvng==
X-Received: by 2002:a05:6871:2583:b0:21e:a6fb:28eb with SMTP id yy3-20020a056871258300b0021ea6fb28ebmr435308oab.35.1709145248433;
        Wed, 28 Feb 2024 10:34:08 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id a1-20020a05620a066100b00787289fa901sm43820qkh.36.2024.02.28.10.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:34:07 -0800 (PST)
Date: Wed, 28 Feb 2024 12:34:05 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
Message-ID: <20240228183405.GI148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-7-eddyz87@gmail.com>
 <20240228182949.GH148327@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lP1+9OvmqShTIrPu"
Content-Disposition: inline
In-Reply-To: <20240228182949.GH148327@maniforge>
User-Agent: Mutt/2.2.12 (2023-09-09)


--lP1+9OvmqShTIrPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:29:49PM -0600, David Vernet wrote:
> On Tue, Feb 27, 2024 at 10:45:54PM +0200, Eduard Zingerman wrote:
> > Check that bpf_map__set_autocreate() can be used to disable automatic
> > creation for struct_ops maps.
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  .../bpf/prog_tests/struct_ops_autocreate.c    | 79 +++++++++++++++++++
> >  .../bpf/progs/struct_ops_autocreate.c         | 42 ++++++++++
> >  2 files changed, 121 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_a=
utocreate.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocr=
eate.c
> >=20
> > diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocrea=
te.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> > new file mode 100644
> > index 000000000000..b21b10f94fc2
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
> > @@ -0,0 +1,79 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "struct_ops_autocreate.skel.h"
> > +
> > +#define EXPECTED_MSG "libbpf: struct_ops init_kern"
> > +
> > +static libbpf_print_fn_t old_print_cb;
> > +static bool msg_found;
> > +
> > +static int print_cb(enum libbpf_print_level level, const char *fmt, va=
_list args)
> > +{
> > +	old_print_cb(level, fmt, args);
> > +	if (level =3D=3D LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, strlen(EXP=
ECTED_MSG)) =3D=3D 0)
> > +		msg_found =3D true;
> > +
> > +	return 0;
> > +}
> > +
> > +static void cant_load_full_object(void)
> > +{
> > +	struct struct_ops_autocreate *skel;
> > +	int err;
> > +
> > +	old_print_cb =3D libbpf_set_print(print_cb);
> > +	skel =3D struct_ops_autocreate__open_and_load();
>=20
> Optional suggestion: It might be useful to add a comment here explaining
> exactly why we expect this to fail? Something like:
>=20
> 	/* The testmod_2 map BTF type (struct bpf_testmod_ops___v2) doesn't
> 	 * match the BTF of the actual struct bpf_testmod_ops defined in the
> 	 * kernel, so we should fail to load it if we don't disable autocreate
> 	 * for the map.
> 	 */
>=20
> Feel free to ignore -- I recognize that some might just consider that
> unnecessary noise.
>=20
> > +	err =3D errno;
> > +	libbpf_set_print(old_print_cb);
> > +	if (!ASSERT_NULL(skel, "struct_ops_autocreate__open_and_load"))
> > +		return;
> > +
> > +	ASSERT_EQ(err, ENOTSUP, "errno should be ENOTSUP");
> > +	ASSERT_TRUE(msg_found, "expected message");
> > +
> > +	struct_ops_autocreate__destroy(skel);
> > +}
> > +
> > +static void can_load_partial_object(void)
> > +{
> > +	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);
> > +	struct struct_ops_autocreate *skel;
> > +	struct bpf_link *link =3D NULL;
> > +	int err;
> > +
> > +	skel =3D struct_ops_autocreate__open_opts(&opts);
> > +	if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
> > +		return;
> > +
> > +	err =3D bpf_program__set_autoload(skel->progs.test_2, false);
> > +	if (!ASSERT_OK(err, "bpf_program__set_autoload"))
> > +		goto cleanup;
>=20
> It feels a bit awkward to have to specify that a struct_ops prog isn't
> autoloaded if it's not associated with an autoloaded / autocreated struct=
_ops
> map. Would it be possible to teach libbpf to not autoload such progs by
> default?

I see you already added that in the next patch. Nice!!

--lP1+9OvmqShTIrPu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd98nQAKCRBZ5LhpZcTz
ZPfFAQDFF7L0w9AO03rqek9RVgIfHc4vfEylGXa8V2hnL8nCsQEAsmgNK83HLNyo
P9t3zfC81ZQ+0YuutPwPD9JlSXMluQo=
=CTbK
-----END PGP SIGNATURE-----

--lP1+9OvmqShTIrPu--

