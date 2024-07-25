Return-Path: <bpf+bounces-35603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DBE93BAFF
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 04:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A80051F23C2A
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CEB12E55;
	Thu, 25 Jul 2024 02:55:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B2101D4;
	Thu, 25 Jul 2024 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721876105; cv=none; b=q8BTOsLMOg1Vu8lx75BB8itc11wA7f4D6M6Sq5UyReTMZlQDQNYenbN6vdf4/HusvWvFvlA5wR9VdbUcwnIFAOPwh4T9FYYSbGAvXsmdC+W8bWFmwqy6b86D4cgx3UujOP2fsrLwy4PofX/v+E2JqXwSzWjcl07Xs26nCsOmnfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721876105; c=relaxed/simple;
	bh=1NQodLNWD3NjTjCm1TVqlid0cgHeuRyqIWuVvxl7jcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2yoJVuntWAkiILNkEZaF21vAkkpQDWm8feUcDXjXj+NNtFJURFNfGqoMB8d1uiXBKsKcy4DasXO97vKEdM2fCH4y4+qsODrrCLu1740L8Zyqcgr+7oESwqRIBBYT11uzqLKLDYIYt6oqVkizXKIeOGPTobqlkXAgrCFfNBvzn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-37636c3872bso398835ab.3;
        Wed, 24 Jul 2024 19:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721876103; x=1722480903;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5pfctrshYAwcZwWSZMTsI7CAp4Mv87tSKn8lNd6pjUo=;
        b=OyU5HGrHAnypKjnOxxe1tEnyf3pnk2N6d8TXqru5moVhTmqxICSC3DpXgx1ZYJMEiH
         zpSP5MyAm9OVZxyp0qcckujhCPp6tIzc2shSiJ//od7KKingQY/whhpjATeEdcwWRrra
         Cqd0swcDwYTvBTocnspDzFP2TBsjd12LBuVXHmA3uzYOMlSl+3treyfo8R7IWQ8/WyLF
         Yg/FALmbKcBHdoS0lcjXsjOrWWegkPsHlk84CTVWCtCrEdstJCSIVMiaJIgxmhGEEoGH
         M/aW50WbWIekL/MHNHLCuGg+nDeXGc4o5xBJB9P/hg3q/jsqokT5yROeV7dIVyJKZQch
         HDhA==
X-Forwarded-Encrypted: i=1; AJvYcCV3um5mJCF4BZLyv0ZIQ+SIxtf5u+ZSynlGtOc0Cn1XzVBVqeoO/MOkenu184a1qM3y+8GaGTw3/ktuEwZ5PV+GRHLnXhB0h1ZJFt55
X-Gm-Message-State: AOJu0YzMI7qRyrcd/SJ2ZTDV1cxc+CPnzd47IDXTVF8vPTYouZGEprmu
	5n1WAvquqqHE46kNkcrZm0aOTD4K+8eZ5mOZZh3vC7Fh0SvE+u+L
X-Google-Smtp-Source: AGHT+IEzlOT6sHCvwIoZKHayYpZpspIyMId+bqLrv5daIty5nG/UHU14N1kY5tldGM4A6A7aaNZpDQ==
X-Received: by 2002:a05:6e02:1a67:b0:375:9d6d:130e with SMTP id e9e14a558f8ab-39a23d155aemr9322465ab.0.1721876102637;
        Wed, 24 Jul 2024 19:55:02 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22ea60e6sm2577075ab.50.2024.07.24.19.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 19:55:01 -0700 (PDT)
Date: Wed, 24 Jul 2024 21:54:59 -0500
From: David Vernet <void@manifault.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, tj@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add test for resizing data
 map with struct_ops
Message-ID: <20240725025459.GA26226@maniforge>
References: <20240724171459.281234-1-void@manifault.com>
 <20240724171459.281234-2-void@manifault.com>
 <CAEf4BzY6cc5L7_Yj3XvyCSZGxL=-Vb0g3drFRcsxDd9UB0QC9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G/0izEnY7QMqCgVn"
Content-Disposition: inline
In-Reply-To: <CAEf4BzY6cc5L7_Yj3XvyCSZGxL=-Vb0g3drFRcsxDd9UB0QC9Q@mail.gmail.com>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--G/0izEnY7QMqCgVn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 05:12:00PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 24, 2024 at 10:15=E2=80=AFAM David Vernet <void@manifault.com=
> wrote:
> >
> > Tests that if you resize a map after opening a skel, that it doesn't
> > cause a UAF which causes a struct_ops map to fail to be able to load.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> >  .../bpf/prog_tests/struct_ops_resize.c        | 30 +++++++++++++++++++
> >  .../selftests/bpf/progs/struct_ops_resize.c   | 24 +++++++++++++++
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_r=
esize.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_resize=
=2Ec
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c=
 b/tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c
> > new file mode 100644
> > index 000000000000..7584f91c2bd1
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/struct_ops_resize.c
> > @@ -0,0 +1,30 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "struct_ops_resize.skel.h"
> > +
> > +static void resize_datasec(void)
> > +{
> > +       struct struct_ops_resize *skel;
> > +       int err;
> > +
> > +       skel =3D struct_ops_resize__open();
> > +       if (!ASSERT_OK_PTR(skel, "struct_ops_resize__open"))
> > +               return;
> > +
> > +       err  =3D bpf_map__set_value_size(skel->maps.data_resizable, 1 <=
< 15);
> > +       if (!ASSERT_OK(err, "bpf_map__set_value_size"))
> > +               goto cleanup;
> > +
> > +       err =3D struct_ops_resize__load(skel);
> > +       ASSERT_OK(err, "struct_ops_resize__load");
> > +
> > +cleanup:
> > +       struct_ops_resize__destroy(skel);
> > +}
> > +
> > +void test_struct_ops_resize(void)
> > +{
> > +       if (test__start_subtest("resize_datasec"))
> > +               resize_datasec();
>=20
> It seems a bit unnecessary to add an entire new test with a subtest
> just for this. Would you mind adding this testing logic into the
> already existing prog_tests/global_map_resize.c set of cases?

Sure thing, I'll send a subsequent patch that adds the testcase to
prog_tests/global_map_resize.c.

> I've applied patch #1, as it's obviously correct, so I didn't want to
> delay the fix. Thanks!

Thanks!

--G/0izEnY7QMqCgVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZqG+gwAKCRBZ5LhpZcTz
ZAwPAQDDc5jdnPV+gPcLTHEs25fumz30ElEn9H17sdVWu+OJ1AD9FO/W9rpV6WcU
HdvnUj9PbjObL/IRw42EQZ+YY1VZrQA=
=i8YN
-----END PGP SIGNATURE-----

--G/0izEnY7QMqCgVn--

