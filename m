Return-Path: <bpf+bounces-22921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE986B8DB
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 21:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8171F28583
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 20:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364F15E09F;
	Wed, 28 Feb 2024 20:11:25 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3727F40843
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151084; cv=none; b=kz09LjpXHt3mFg/DjLONKw8j2zrM9Vq2dg6C4bNMLie4NSfU8DjUOEAaqqGklXWUg4RXLFuBhpvnZEcOyZJb0T8yq69P4PIgAPzalUxCKFcdTeNCIXHrhfq0v13lNUSoWl/BfDRiRLD5MuwYfZ46nYJQdVJmuXZS3Qaeg8Vn2nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151084; c=relaxed/simple;
	bh=W7CgiHzFr5mdkFyc7T0cUYaWqESi+wnjA7CcncivXKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdQcdnpr3lRtPIgemR0w9wOJ+pKjbWhffo/SiuxBCcljccqQmWe3XRnLg/Fy1FBx17eo5BTg94ZkLHz1orCTYdX2p77WxbQMAI1Cn+Wi5BerDroRtlSpyNqKlavL0xLXorLEXyrkFrw0r0QTVEVRNHCbRrPhrSfEQh5UozWU17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6095dfcb461so1373727b3.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 12:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709151082; x=1709755882;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfPuWNxlqTNFmCenfj7FwGgla8U8dW67zm7C3r+wrmA=;
        b=F3lrBsfJDikhg+ZBr11u5SJ5Iv7aCEWY2xfgJxIgGPsXIFTw8JT6SNF+uSS0TNWlup
         si1v0PIO04SiGbJVtYn7ODU4MlTYSy5Ff1Bc1Th0tz3/QbOhU7cIO7qcP2FWrwpcP5Fw
         fsH7CpDzjEJhc9Wb5OIlu0CNJ4Iuq4mssSoBorvEcIy8J/iseOu5/uMQRRF8qBeH7iIq
         VL+jOJdStCAYvbMdwb8nr7DZTALY/y4tZVXtHDw0u9czSIPup//i9Vgs33nF7/8yPFJN
         SLfH7fRUpv9R68/6zrZ3ePwrl6Lrit1SoxJ2ZGfU6F59XM+9urqAiheir/o99xREnYmq
         WMbw==
X-Gm-Message-State: AOJu0YxhCx/xSgdOVguWAmFcgrBi8oEbR+jX7n0gYB1wgaUJXj6McmuC
	frS8XuXjJLWIaoTDOvUWnRSJ1TOxNjlrgkL+EtHT3qDvhEoIGawV
X-Google-Smtp-Source: AGHT+IE+uJ5O4VnkqQRFUlMu2axVQMK0MitfXTo/gbVAxQw/92YlMf+3uihB8KaMX8p2kJleUju7eg==
X-Received: by 2002:a05:690c:f8a:b0:5ff:7cca:a434 with SMTP id df10-20020a05690c0f8a00b005ff7ccaa434mr103193ywb.51.1709151080904;
        Wed, 28 Feb 2024 12:11:20 -0800 (PST)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id i126-20020a0ddf84000000b00608d9358ccbsm31072ywe.132.2024.02.28.12.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:11:20 -0800 (PST)
Date: Wed, 28 Feb 2024 14:11:18 -0600
From: David Vernet <void@manifault.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: bad_struct_ops test
Message-ID: <20240228201118.GA164963@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
 <20240227204556.17524-6-eddyz87@gmail.com>
 <20240228181552.GG148327@maniforge>
 <8771665b7c0d607896b533e8c973785b28b5af0f.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zDxuOnLv1cOrz+zf"
Content-Disposition: inline
In-Reply-To: <8771665b7c0d607896b533e8c973785b28b5af0f.camel@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--zDxuOnLv1cOrz+zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:06:21PM +0200, Eduard Zingerman wrote:
> On Wed, 2024-02-28 at 12:15 -0600, David Vernet wrote:
> [...]
>=20
> > > +static libbpf_print_fn_t old_print_cb;
> > > +static bool msg_found;
> > > +
> > > +static int print_cb(enum libbpf_print_level level, const char *fmt, =
va_list args)
> > > +{
> > > +	old_print_cb(level, fmt, args);
> > > +	if (level =3D=3D LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, strlen(E=
XPECTED_MSG)) =3D=3D 0)
> > > +		msg_found =3D true;
> > > +
> > > +	return 0;
> > > +}
> >=20
> > Not necessary at all for this patch set / just an observation, but it w=
ould be
> > nice to have this be something offered by the core prog_tests framework
> > (meaning, the ability to assert libbpf output for a testcase).
>=20
> This might be useful, I will add a utility function for it (probably two).
>=20
> [...]
>=20
> > > diff --git a/tools/testing/selftests/bpf/progs/bad_struct_ops.c b/too=
ls/testing/selftests/bpf/progs/bad_struct_ops.c
> > > new file mode 100644
> > > index 000000000000..9c103afbfdb1
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/bad_struct_ops.c
> > > @@ -0,0 +1,17 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <vmlinux.h>
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +#include "../bpf_testmod/bpf_testmod.h"
> > > +
> > > +char _license[] SEC("license") =3D "GPL";
> > > +
> > > +SEC("struct_ops/test_1")
> > > +int BPF_PROG(test_1) { return 0; }
> > > +
> > > +SEC(".struct_ops.link")
> > > +struct bpf_testmod_ops testmod_1 =3D { .test_1 =3D (void *)test_1 };
> >=20
> > Just to make be 100% sure that we're isolating the issue under test, sh=
ould we
> > also add a .test_2 prog and add it to the struct bpf_testmod_ops map?
>=20
> You are concerned that error might be confused with libbpf insisting
> that '.test_2' should be present, right?
> libbpf allows NULL members but I can add '.test_2' here, no problem.

Correct, and yes that's true. Feel free to ignore if you think it's cleaner
without, totally up to you.

--zDxuOnLv1cOrz+zf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZd+TZgAKCRBZ5LhpZcTz
ZO0xAP9GEBvU8f2v+hd6JcPw71FjMKEejRY6c7rt9S2fhH9IWwEA0JXnBejvREBO
oWQngxEkJlOKOXBSVx5KLAoWemvRYQs=
=xptE
-----END PGP SIGNATURE-----

--zDxuOnLv1cOrz+zf--

