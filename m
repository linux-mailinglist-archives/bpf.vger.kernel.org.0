Return-Path: <bpf+bounces-22962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BE386BC4D
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1671AB24417
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A672931;
	Wed, 28 Feb 2024 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDcqsIYR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BF072909
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163806; cv=none; b=H9/mlUDX/jMC8xZaeCOjQ8NaOEpF3j5tOJb6JtRyzDeAlvx9tQT2iXiaWiQPAnLWb6Jx8CGbwGHFuboGWWOjDKfEYtLFuLDDRx4B9hGoCDUVfyDm5lFheL9VjJGrASwb7o18SnpDP6dwpGhd/bZ2CbRX0EC5BlzPysevdn2FWGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163806; c=relaxed/simple;
	bh=zzcYNIqPM8/uJJHJTix/ZQXAfRyaG1PjSXUVeou3idU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sq8E/MyVpmwO2VY65zcuGApq18EX5mY2GtAynF3kiy578pYCRvoX0hw86SJTVC24hZGx9842qn0c4DzQ1pn8gM6L4SRTKh53lykEtO2/Wh2ikR/SNTbEMhZOKO7/V3ZEUQV00bW1DBKyCGZKCKvVqY4vDT5q5AL3o1gCSf3utgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDcqsIYR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so237232a12.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709163803; x=1709768603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R835MjylIOwIJwDIzpFghwTjYVOhFMEFcmoqVVcj1I0=;
        b=DDcqsIYRe1h2Y43f1PTSXmgxhThRtKU0NpMsL384yUoSCiuaQRZxn6jsOZllUGMcze
         Y+ENNSI6ptnZKD8ZhKVx7LNdGP/FLMDtL9hVPzUQlVj1gDu3jL++OZBXUXOzzbGhokcu
         e0h9S+NwEP31QTQcLUexBNVvDbHFHcw/0/m8Rf2uAtF93B1lh0Eom30uska0aXSnk4NV
         MNnqq87B5tQseZi3Gourib9SnZykodAyEcNhG2MZBMaPPnUwqtIgCZ36GLANEHXLiXEd
         wOXlVenpkiV4d91lbYxyreYpuTSo+Fq9yA0dMIRWDAx5G4jOn/kYnVO51DuqgDlRoLd3
         fFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709163803; x=1709768603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R835MjylIOwIJwDIzpFghwTjYVOhFMEFcmoqVVcj1I0=;
        b=jkZHmiI+D/y53VlAKf40Fy54LyL+Bavu5BCl1v1VaUPQW9Ok2BlJC/1A1sPm+f1yZq
         Bma6LXsoqYYLRLQMqvK0rUfhzn33rdj6uKNoq+HeRmPnUx+f2C04F5kHgy1qiAhGXE+t
         Z44zMVsFIeTzGQudHH1bEDNCmN7v1a6z8Q6njA0vucUWKv9touc/SmcrEg6q1ovUw8fB
         4CTs4sxzXnetT+4el1gOksdDCsv7l1yhyc1z51g87bQIqw7QvBLp/mvtqdzMEyhpNDnn
         4IbO28M62jW2J4pFRnOaQE0x6nLU9ISmAdoD7N8WNGfRCcbbsnofbM3oEm8fH91aF2uE
         zf1w==
X-Gm-Message-State: AOJu0YyLUVQYKdgv8HFnjyIGOL8hd7Z6J9jl4C2ohCjatFCUQCIiM8+4
	AKdiT10cgKqTDlNANqxQg1A2jG+JIkGA/stofO6fmfy3ZK83Geyh62JF+bpsMLYQaqseS1z9Jjc
	zOALTracefw20xhJ7iWvxXT/twTc=
X-Google-Smtp-Source: AGHT+IH2rhvHqww9eVce+kLBRqz+7dkiei+Vn24zplgIBAn+ph+LZFcnnHAeB3WSj+ygNjoeQxATo9/x8D3ZOvs1j34=
X-Received: by 2002:a17:90a:7145:b0:299:9999:6bae with SMTP id
 g5-20020a17090a714500b0029999996baemr642990pjs.16.1709163803045; Wed, 28 Feb
 2024 15:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-7-eddyz87@gmail.com>
In-Reply-To: <20240227204556.17524-7-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 15:43:11 -0800
Message-ID: <CAEf4BzbXzsDUx-dvUQQEMcCVUeUjnBnbF6V4fmc36C0YzVF73A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: test autocreate behavior
 for struct_ops maps
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Check that bpf_map__set_autocreate() can be used to disable automatic
> creation for struct_ops maps.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../bpf/prog_tests/struct_ops_autocreate.c    | 79 +++++++++++++++++++
>  .../bpf/progs/struct_ops_autocreate.c         | 42 ++++++++++
>  2 files changed, 121 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/struct_ops_aut=
ocreate.c
>  create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_autocrea=
te.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate=
.c b/tools/testing/selftests/bpf/prog_tests/struct_ops_autocreate.c
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
> +       old_print_cb(level, fmt, args);
> +       if (level =3D=3D LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, strlen=
(EXPECTED_MSG)) =3D=3D 0)
> +               msg_found =3D true;
> +
> +       return 0;
> +}
> +
> +static void cant_load_full_object(void)
> +{
> +       struct struct_ops_autocreate *skel;
> +       int err;
> +
> +       old_print_cb =3D libbpf_set_print(print_cb);
> +       skel =3D struct_ops_autocreate__open_and_load();
> +       err =3D errno;
> +       libbpf_set_print(old_print_cb);
> +       if (!ASSERT_NULL(skel, "struct_ops_autocreate__open_and_load"))
> +               return;
> +
> +       ASSERT_EQ(err, ENOTSUP, "errno should be ENOTSUP");
> +       ASSERT_TRUE(msg_found, "expected message");
> +
> +       struct_ops_autocreate__destroy(skel);
> +}
> +
> +static void can_load_partial_object(void)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts);

nit: prefer LIBBPF_OPTS() over DECLARE_LIBBPF_OPTS()

> +       struct struct_ops_autocreate *skel;
> +       struct bpf_link *link =3D NULL;
> +       int err;
> +
> +       skel =3D struct_ops_autocreate__open_opts(&opts);
> +       if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
> +               return;
> +
> +       err =3D bpf_program__set_autoload(skel->progs.test_2, false);
> +       if (!ASSERT_OK(err, "bpf_program__set_autoload"))
> +               goto cleanup;
> +
> +       err =3D bpf_map__set_autocreate(skel->maps.testmod_2, false);
> +       if (!ASSERT_OK(err, "bpf_map__set_autocreate"))
> +               goto cleanup;
> +
> +       err =3D struct_ops_autocreate__load(skel);
> +       if (ASSERT_OK(err, "struct_ops_autocreate__load"))
> +               goto cleanup;
> +
> +       link =3D bpf_map__attach_struct_ops(skel->maps.testmod_1);
> +       if (!ASSERT_OK_PTR(link, "bpf_map__attach_struct_ops"))
> +               goto cleanup;
> +
> +       /* test_1() would be called from bpf_dummy_reg2() in bpf_testmod.=
c */
> +       ASSERT_EQ(skel->bss->test_1_result, 42, "test_1_result");
> +
> +cleanup:
> +       bpf_link__destroy(link);
> +       struct_ops_autocreate__destroy(skel);
> +}
> +
> +void serial_test_struct_ops_autocreate(void)

same as in the previous patch, why serial?

> +{
> +       if (test__start_subtest("cant_load_full_object"))
> +               cant_load_full_object();
> +       if (test__start_subtest("can_load_partial_object"))
> +               can_load_partial_object();
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
> +       test_1_result =3D 42;
> +       return 0;
> +}
> +
> +SEC("struct_ops/test_1")
> +int BPF_PROG(test_2)
> +{
> +       return 0;
> +}
> +
> +struct bpf_testmod_ops___v1 {
> +       int (*test_1)(void);
> +};
> +
> +struct bpf_testmod_ops___v2 {
> +       int (*test_1)(void);
> +       int (*does_not_exist)(void);
> +};
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops___v1 testmod_1 =3D {
> +       .test_1 =3D (void *)test_1
> +};
> +
> +SEC(".struct_ops.link")

can you please also have a test where we use SEC("?.struct_ops.link")
which set autoload to false by default?

> +struct bpf_testmod_ops___v2 testmod_2 =3D {
> +       .test_1 =3D (void *)test_1,
> +       .does_not_exist =3D (void *)test_2
> +};
> --
> 2.43.0
>

