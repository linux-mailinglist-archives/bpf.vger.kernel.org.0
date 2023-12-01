Return-Path: <bpf+bounces-16440-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3137E801349
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6174E1C20EF1
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C34C3BD;
	Fri,  1 Dec 2023 19:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmRnW3r0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F564AD
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 11:04:51 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a00ac0101d9so363594266b.0
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 11:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701457489; x=1702062289; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvkxiKep/jPm+cTL2hD2L5fB/7iRa0Ka2Km87fdGydo=;
        b=UmRnW3r0VxLhTQ/4zw86GHY4ZPmUjbTBnKGQKzQJhvM5IbusDqQuZJoMhLZfhBz7VL
         c+3g/EZzmgZM94G1yx2UZmynGhGTmVB9HI0vgXM6hEJjH94pxBol8yxRUguEpxvbWKjt
         xRXfrv/EAmMFj5TidhfpnEeBKBmSowHKY1FdhLFW4jryJElYfommQ2M2bh/f82w+R9jS
         TEIhZPKz6p3Bz6iBWaMgs8T7GSaRHZBFXejpP0c7ShT+88E0WKz5L6e7UGOTQ0/dQB21
         GDjKRmXJUqzw72w9JCtBveaRNlV2271F1ocGzhbamZXL9Ga3fBeA46+Q5OeXD3DG9DV/
         Glxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457489; x=1702062289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvkxiKep/jPm+cTL2hD2L5fB/7iRa0Ka2Km87fdGydo=;
        b=CJRKjnIcF7OyDZR/hgUehM0Mi3rOZVrDVHZbzx/ZS3nSxcof/oVNjoNAahaHq+Q0bW
         eYkW/x9uhxCW05InSJ7pp9xn/LELSNV/aPx50KDVjyUjmPIXvBhF4GKwBdxTJg+wELcd
         pK53nteDAtVZF8MTBmpIx84LI8n39A5/0TXKaZKIp2sG+m6AEehPdpTEES6jaUwx1wZr
         FEU9k8onSD4Oj8jC0YBVh4sTPp8Z/S27jI10eyZYTxLoFrlYhU+Y1JICJRwQ2xkiB0+K
         PdK6Ij/UB0d8L7qAhztVfGOg50Vhb+sIjAehyCsYJU0Ahq3h8RTFbQhC0QQ4o41q8uYp
         qt4Q==
X-Gm-Message-State: AOJu0Yx66ndCCfCyPwh9CFDR15puBXbMNO5RsozFBKrnSbpjoUqRXmNG
	XOP/NHBxVBUZEaB/u6N57OwxWExBQbuVJhnW21s=
X-Google-Smtp-Source: AGHT+IFEsynVtpqZFOpNHxPSLhKia3O3tfot+ygkJznzbWzQXSaAa6W5zXgnMgizQZp2UF3c1BnA+G6qyPw3of+74FY=
X-Received: by 2002:a17:906:658a:b0:a01:811c:ce9 with SMTP id
 x10-20020a170906658a00b00a01811c0ce9mr1253546ejn.0.1701457489343; Fri, 01 Dec
 2023 11:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201170609.1187520-1-andrii@kernel.org> <2254d57e-843d-c3e3-0ebf-779e44c5d61a@oracle.com>
In-Reply-To: <2254d57e-843d-c3e3-0ebf-779e44c5d61a@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 1 Dec 2023 11:04:36 -0800
Message-ID: <CAEf4BzYdyMqvpR6FWBehvn2oE=zCkbwnEv3sZVKd1SM1o-taTg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: validate eliminated global
 subprog is not freplaceable
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 9:47=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 01/12/2023 17:06, Andrii Nakryiko wrote:
> > Add selftest that establishes dead code-eliminated valid global subprog
> > (global_dead) and makes sure that it's not possible to freplace it, as
> > it's effectively not there. This test will fail with unexpected success
> > before 2afae08c9dcb ("bpf: Validate global subprogs lazily").
> >
> > v1->v2:
> >   - don't rely on assembly output in verifier log, which changes betwee=
n
> >     compiler versions (CI).
> >
> > Suggested-by: Alexei Starovoitov <ast@kernel.org>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
> one minor thing below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>
> > ---
> >  .../bpf/prog_tests/global_func_dead_code.c    | 60 +++++++++++++++++++
> >  .../bpf/progs/freplace_dead_global_func.c     | 11 ++++
> >  .../bpf/progs/verifier_global_subprogs.c      | 33 ++++++----
> >  3 files changed, 92 insertions(+), 12 deletions(-)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_=
dead_code.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/freplace_dead_glo=
bal_func.c
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_dead_co=
de.c b/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
> > new file mode 100644
> > index 000000000000..d873eb20dd7c
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
> > @@ -0,0 +1,60 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2023 Meta Platforms, Inc. and affiliates. */
> > +
> > +#include <test_progs.h>
> > +#include "verifier_global_subprogs.skel.h"
> > +#include "freplace_dead_global_func.skel.h"
> > +
> > +void test_global_func_dead_code(void)
> > +{
> > +     struct verifier_global_subprogs *tgt_skel =3D NULL;
> > +     struct freplace_dead_global_func *skel =3D NULL;
> > +     char log_buf[4096];
> > +     int err, tgt_fd;
> > +
> > +     /* first, try to load target with good global subprog */
> > +     tgt_skel =3D verifier_global_subprogs__open();
> > +     if (!ASSERT_OK_PTR(tgt_skel, "tgt_skel_good_open"))
> > +             return;
> > +
> > +     bpf_program__set_autoload(tgt_skel->progs.chained_global_func_cal=
ls_success, true);
> > +
> > +     err =3D verifier_global_subprogs__load(tgt_skel);
> > +     if (!ASSERT_OK(err, "tgt_skel_good_load"))
> > +             goto out;
> > +
> > +     tgt_fd =3D bpf_program__fd(tgt_skel->progs.chained_global_func_ca=
lls_success);
> > +
> > +     /* Attach to good non-eliminated subprog */
> > +     skel =3D freplace_dead_global_func__open();
> > +     if (!ASSERT_OK_PTR(skel, "skel_good_open"))
> > +             goto out;
> > +
> > +     bpf_program__set_attach_target(skel->progs.freplace_prog, tgt_fd,=
 "global_good");
>
> missing "err =3D " assignment here?


yep, thanks for spotting, will fix

>
> > +     ASSERT_OK(err, "attach_target_good");
> > +
> > +     err =3D freplace_dead_global_func__load(skel);
> > +     if (!ASSERT_OK(err, "skel_good_load"))
> > +             goto out;
> > +
> > +     freplace_dead_global_func__destroy(skel);
> > +
> > +     /* Try attaching to dead code-eliminated subprog */
> > +     skel =3D freplace_dead_global_func__open();
> > +     if (!ASSERT_OK_PTR(skel, "skel_dead_open"))
> > +             goto out;
> > +
> > +     bpf_program__set_log_buf(skel->progs.freplace_prog, log_buf, size=
of(log_buf));
> > +     err =3D bpf_program__set_attach_target(skel->progs.freplace_prog,=
 tgt_fd, "global_dead");
> > +     ASSERT_OK(err, "attach_target_dead");
> > +
> > +     err =3D freplace_dead_global_func__load(skel);
> > +     if (!ASSERT_ERR(err, "skel_dead_load"))
> > +             goto out;
> > +
> > +     ASSERT_HAS_SUBSTR(log_buf, "Subprog global_dead doesn't exist", "=
dead_subprog_missing_msg");
> > +
> > +out:
> > +     verifier_global_subprogs__destroy(tgt_skel);
> > +     freplace_dead_global_func__destroy(skel);
> > +}

[...]

