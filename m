Return-Path: <bpf+bounces-18806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CBA822274
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 21:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E000CB2256A
	for <lists+bpf@lfdr.de>; Tue,  2 Jan 2024 20:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F0D16401;
	Tue,  2 Jan 2024 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7CFiyt1"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351A616406
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 20:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD91FC433CC
	for <bpf@vger.kernel.org>; Tue,  2 Jan 2024 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704226681;
	bh=oHVKCtuIqVzlv29pXOmtVJoGckqGCgbtT/NFGrjaaQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b7CFiyt1H/614M9RVEfkfb/KC7+TQxo6uSIxwC6ceP5UTmeP8gZMk7eqF+lwvrTIv
	 Toyd5DfqFnNM6uWZ4vT5KMg5U5OvlfClCuK8lYCOWzYapApkqdv4To9+ZCP71m+qso
	 CPtP7gCEaV8dLDDXt4J8O6ddvTNm6FU1cZRpAF116sauMkkk2LCsUhBjKFJZ60gBkc
	 zNTDEkx7g2Qm5+W2CfNYHoszNWlLZvQk7YVYQLfXTeOZLIo9vLL85qdDPar22xrnsy
	 oOV6dxqF5/BhbSuMw61/R0+qqgSCV279N2+pGEs89usNywFLuxmTjmxRjFo8GO6Vi/
	 QFdiMsLGKXoaw==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cd04078ebeso14918461fa.1
        for <bpf@vger.kernel.org>; Tue, 02 Jan 2024 12:18:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yzp7pvQIQqFW3xH3d8Tugto7PS9f8z3GkHGHBUxnvBReQtkMd+s
	sRVP7+qIK1rI48SQ1u4yyrNga5l4pKd0c+9xAwc=
X-Google-Smtp-Source: AGHT+IFus4GE0gUl8B9+yNDP4beWHKYzGbDdkoMYpWglE/wMfN47rD4Wa8DRoBrURg9B+yILWGWS5xXfoP9F+GhKPOM=
X-Received: by 2002:a19:f807:0:b0:50e:7703:bc30 with SMTP id
 a7-20020a19f807000000b0050e7703bc30mr8175224lff.29.1704226679847; Tue, 02 Jan
 2024 12:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222151153.31291-1-9erthalion6@gmail.com> <20231222151153.31291-3-9erthalion6@gmail.com>
In-Reply-To: <20231222151153.31291-3-9erthalion6@gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 2 Jan 2024 12:17:48 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4Kh1oLZX4gUOKc-SJqma2Ougjw7TPaEnS0t=UKi-Lx4Q@mail.gmail.com>
Message-ID: <CAPhsuW4Kh1oLZX4gUOKc-SJqma2Ougjw7TPaEnS0t=UKi-Lx4Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 2/4] selftests/bpf: Add test for recursive
 attachment of tracing progs
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	dan.carpenter@linaro.org, olsajiri@gmail.com, asavkov@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 7:12=E2=80=AFAM Dmitrii Dolgov <9erthalion6@gmail.c=
om> wrote:
>
> Verify the fact that only one fentry prog could be attached to another
> fentry, building up an attachment chain of limited size. Use existing
> bpf_testmod as a start of the chain.
>
> Acked-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

Acked-by: Song Liu <song@kernel.org>

With a few nits below.

>
> diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/=
tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> new file mode 100644
> index 000000000000..e9e576de6723
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2023 Red Hat, Inc. */
> +#include <test_progs.h>
> +#include "fentry_recursive.skel.h"
> +#include "fentry_recursive_target.skel.h"
> +#include <bpf/btf.h>
> +#include "bpf/libbpf_internal.h"
> +
> +/*
> + * Test recursive attachment of tracing progs with more than one nesting=
 level
> + * is not possible. Create a chain of attachment, verify that the last p=
rog
> + * will fail. Depending on the arguments, following cases are tested:
> + *
> + * - Recursive loading of tracing progs, without attaching (attach =3D f=
alse,
> + *   detach =3D false). The chain looks like this:
> + *       load target
> + *       load fentry1 -> target
> + *       load fentry2 -> fentry1 (fail)
> + *
> + * - Recursive attach of tracing progs (attach =3D true, detach =3D fals=
e). The
> + *   chain looks like this:
> + *       load target
> + *       load fentry1 -> target
> + *       attach fentry1 -> target
> + *       load fentry2 -> fentry1 (fail)
> + *
> + * - Recursive attach and detach of tracing progs (attach =3D true, deta=
ch =3D
> + *   true). This validates that attach_tracing_prog flag will be set thr=
oughout
> + *   the whole lifecycle of an fentry prog, independently from whether i=
t's
> + *   detached. The chain looks like this:
> + *       load target
> + *       load fentry1 -> target
> + *       attach fentry1 -> target
> + *       detach fentry1
> + *       load fentry2 -> fentry1 (fail)
> + */
> +static void test_recursive_fentry_chain(bool attach, bool detach)
> +{
> +       struct fentry_recursive_target *target_skel =3D NULL;
> +       struct fentry_recursive *tracing_chain[2] =3D {};
> +       struct bpf_program *prog;
> +       int prev_fd, err;
> +
> +       target_skel =3D fentry_recursive_target__open_and_load();
> +       if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_an=
d_load"))
> +               goto close_prog;

nit: This is not wrong, but we can just return here.

> +
> +       /* Create an attachment chain with two fentry progs */
> +       for (int i =3D 0; i < 2; i++) {
> +               tracing_chain[i] =3D fentry_recursive__open();
> +               if (!ASSERT_OK_PTR(tracing_chain[i], "fentry_recursive__o=
pen"))
> +                       goto close_prog;
> +
> +               /*
> +                * The first prog in the chain is going to be attached to=
 the target
> +                * fentry program, the second one to the previous in the =
chain.
> +                */
> +               prog =3D tracing_chain[i]->progs.recursive_attach;
> +               if (i =3D=3D 0) {
> +                       prev_fd =3D bpf_program__fd(target_skel->progs.te=
st1);
> +                       err =3D bpf_program__set_attach_target(prog, prev=
_fd, "test1");
> +               } else {
> +                       prev_fd =3D bpf_program__fd(tracing_chain[i-1]->p=
rogs.recursive_attach);
> +                       err =3D bpf_program__set_attach_target(prog, prev=
_fd, "recursive_attach");
> +               }

nit: I don't really like these "if (i =3D=3D 0)" cases. But it is not too b=
ad.

> +
> +               if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
> +                       goto close_prog;
> +
> +               err =3D fentry_recursive__load(tracing_chain[i]);
> +               /* The first attach should succeed, the second fail */
> +               if (i =3D=3D 0) {
> +                       if (!ASSERT_OK(err, "fentry_recursive__load"))
> +                               goto close_prog;
> +
> +                       if (attach) {
> +                               err =3D fentry_recursive__attach(tracing_=
chain[i]);
> +                               if (!ASSERT_OK(err, "fentry_recursive__at=
tach"))
> +                                       goto close_prog;
> +                       }
> +
> +                       if (detach) {
> +                               /*
> +                                * Flag attach_tracing_prog should still =
be set, preventing
> +                                * attachment of the following prog.
> +                                */
> +                               fentry_recursive__detach(tracing_chain[i]=
);
> +                       }
> +               } else {
> +                       if (!ASSERT_ERR(err, "fentry_recursive__load"))
> +                               goto close_prog;
> +               }
> +       }
> +
> +close_prog:
> +       fentry_recursive_target__destroy(target_skel);
> +       for (int i =3D 0; i < 2; i++) {
> +               if (tracing_chain[i])

nit: This NULL check is not necessary.

> +                       fentry_recursive__destroy(tracing_chain[i]);
> +       }
> +}
> +
> +void test_recursive_fentry(void)
> +{
> +       if (test__start_subtest("attach"))
> +               test_recursive_fentry_chain(true, false);
> +       if (test__start_subtest("load"))
> +               test_recursive_fentry_chain(false, false);
> +       if (test__start_subtest("detach"))
> +               test_recursive_fentry_chain(true, true);
> +}
[...]

