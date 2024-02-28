Return-Path: <bpf+bounces-22961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D167386BC46
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6082E1F2833B
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FF670044;
	Wed, 28 Feb 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhZ2xzSy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25D13D2E3
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709163638; cv=none; b=k8FUUhxNeH1FNw7FOtgEjjgCMuwtzkUVyKTXbmGrNbAQxczJcYYDrSe1ltgVaWFzVuGpoFG6eYSLbP9yZeT7eN/IF3rxuIAYdfvQ2JwJEnUFdvotW2pWAKAvyy5B4aExPtq5CZ0bLtUBUdhq4mxd2GNf2Mg0avwH3B0Q0pfGjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709163638; c=relaxed/simple;
	bh=/RvQVI97Y94AuqFQkDCBbmNFMWV7jkrFwVqbZyiMy8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rt4gm9pfpzoGhXQ4/PmiVaB+Ad6yWKicf/IOz7B5oGZ1DY6V6RAUjer1G7vXrFrTbA9Kp+YFtylnCSNK9Qxx0v9YofV786YHFnplBLSIpFatC2PPS1wivZxcCA63+jpa7eM1t1YrDAHIuHLWtptpcqSwoUznfhgdgbJb2LtBBHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhZ2xzSy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso272494a12.0
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709163636; x=1709768436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By+fUJI5GDc0JUI0UkOV8pSTD9GH0AlOQQYm8Kt5veg=;
        b=VhZ2xzSyh9byhkHg7kpBg5F36Z71ao7BJXcJYpEzgzpcHPXpZlLQfkpQsYs95hvHnS
         tc/q9Z/3My+7cUjgKIj5/ElrKK47tWCyrSKTdy4nl/ZKdJR37n1U04P1GQ4VHmDe+0RH
         02qOvGJXAS9sMQRaoZUkgUGWX2BdsNMsgmOS45C/e+Ock3FCVPCr0WtGttYYCFsOuB4r
         g1ekPOkIq5EpQDtn1BA1rrdf0oZQgYo8/4cp5V7b5GrvKjzPYXp+Fr7ycjAhEEu/v+0t
         M4BP23tyXJbF0aaDLZL5Si7KAlgouqnGkVSX193j+1RQeCVAxBa1huJ/nhAiXedRiJoU
         x7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709163636; x=1709768436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=By+fUJI5GDc0JUI0UkOV8pSTD9GH0AlOQQYm8Kt5veg=;
        b=THGh35x2wMVPJencYy5n8qRvV57nPDOLnI0ZrW+XAj6b4B0yKUNRrrk4C0OEEb5guq
         BcWuNMFsJrt0GXcLaztMk2u97R44MQVJpTcAEV5yWUBsuauIYvyhpeWdP2rrfi3Q/ajC
         lFFswS5KtQ8Y/WvbonNQLNQDcW3ibgFLy6CbD9O81T1ht865GUDTfQmJm/6V1HERkQze
         G1C/ZnEWhK1DQ34iwReg/7MrD0+q6fOtMWAiHPk/7q0UQCIpeYoKLmPBI4sEaMK9+D6O
         RPl5eOU5LxRYM2nm24sLB+cC9UNDyFFu71PG49LBSz3Oe9kA6MhbsIUdJarJvBTD+N/t
         GXGQ==
X-Gm-Message-State: AOJu0Yz2Jtn3wdU1mXpU0tozf/a4qNy6aWoX/13ZE0ZCjxehL+Z93KV0
	SQbbob9Tdp1vkBpm7Eap7xlUKOgVRvRNsblklGakn0ENdrf9xP0/L3gq3f2zTPt9sPxTUfEu0WC
	ewWFVO+F2ybI+A6I5Qj1jCynRxf8=
X-Google-Smtp-Source: AGHT+IH64pnqRtyRO6E70DqJ2ntPzKVtIo+aYUY3/fZob8btJXskz8b5YQnDQagp44mgPL6OCWqKkRzgZklQ04VEpnY=
X-Received: by 2002:a17:90b:2352:b0:29a:f920:41c5 with SMTP id
 ms18-20020a17090b235200b0029af92041c5mr676452pjb.4.1709163636405; Wed, 28 Feb
 2024 15:40:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-6-eddyz87@gmail.com>
In-Reply-To: <20240227204556.17524-6-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 15:40:24 -0800
Message-ID: <CAEf4BzaDwpTVwc_wTT74EthE5g11URiysNeuu6V+HDKrWXEnfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] selftests/bpf: bad_struct_ops test
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, void@manifault.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 12:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> When loading struct_ops programs kernel requires BTF id of the
> struct_ops type and member index for attachment point inside that
> type. This makes it not possible to have same BPF program used in
> struct_ops maps that have different struct_ops type.
> Check if libbpf rejects such BPF objects files.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 24 +++++++++++
>  .../selftests/bpf/bpf_testmod/bpf_testmod.h   |  4 ++
>  .../selftests/bpf/prog_tests/bad_struct_ops.c | 42 +++++++++++++++++++
>  .../selftests/bpf/progs/bad_struct_ops.c      | 17 ++++++++
>  4 files changed, 87 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bad_struct_ops=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bad_struct_ops.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 0d8437e05f64..69f5eb9ad546 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -601,6 +601,29 @@ struct bpf_struct_ops bpf_bpf_testmod_ops =3D {
>         .owner =3D THIS_MODULE,
>  };
>
> +static int bpf_dummy_reg2(void *kdata)
> +{
> +       struct bpf_testmod_ops2 *ops =3D kdata;
> +
> +       ops->test_1();
> +       return 0;
> +}
> +
> +static struct bpf_testmod_ops2 __bpf_testmod_ops2 =3D {
> +       .test_1 =3D bpf_testmod_test_1,
> +};
> +
> +struct bpf_struct_ops bpf_testmod_ops2 =3D {
> +       .verifier_ops =3D &bpf_testmod_verifier_ops,
> +       .init =3D bpf_testmod_ops_init,
> +       .init_member =3D bpf_testmod_ops_init_member,
> +       .reg =3D bpf_dummy_reg2,
> +       .unreg =3D bpf_dummy_unreg,
> +       .cfi_stubs =3D &__bpf_testmod_ops2,
> +       .name =3D "bpf_testmod_ops2",
> +       .owner =3D THIS_MODULE,
> +};
> +
>  extern int bpf_fentry_test1(int a);
>
>  static int bpf_testmod_init(void)
> @@ -612,6 +635,7 @@ static int bpf_testmod_init(void)
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &=
bpf_testmod_kfunc_set);
>         ret =3D ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &=
bpf_testmod_kfunc_set);
>         ret =3D ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_=
testmod_ops);
> +       ret =3D ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_tes=
tmod_ops2);
>         if (ret < 0)
>                 return ret;
>         if (bpf_fentry_test1(0) < 0)
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h b/tool=
s/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> index c3b0cf788f9f..3183fff7f246 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.h
> @@ -37,4 +37,8 @@ struct bpf_testmod_ops {
>         int (*test_maybe_null)(int dummy, struct task_struct *task);
>  };
>
> +struct bpf_testmod_ops2 {
> +       int (*test_1)(void);
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
> +       old_print_cb(level, fmt, args);
> +       if (level =3D=3D LIBBPF_WARN && strncmp(fmt, EXPECTED_MSG, strlen=
(EXPECTED_MSG)) =3D=3D 0)
> +               msg_found =3D true;
> +
> +       return 0;
> +}
> +
> +static void test_bad_struct_ops(void)
> +{
> +       struct bad_struct_ops *skel;
> +       int err;
> +
> +       old_print_cb =3D libbpf_set_print(print_cb);
> +       skel =3D bad_struct_ops__open_and_load();

we want to check that the load step failed specifically, right? So
please split open from load, make sure that open succeeds, but load
fails

> +       err =3D errno;
> +       libbpf_set_print(old_print_cb);
> +       if (!ASSERT_NULL(skel, "bad_struct_ops__open_and_load"))
> +               return;
> +
> +       ASSERT_EQ(err, EINVAL, "errno should be EINVAL");
> +       ASSERT_TRUE(msg_found, "expected message");
> +
> +       bad_struct_ops__destroy(skel);
> +}
> +
> +void serial_test_bad_struct_ops(void)

why does it have to be a serial test?

> +{
> +       if (test__start_subtest("test_bad_struct_ops"))
> +               test_bad_struct_ops();
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
> +
> +SEC(".struct_ops.link")
> +struct bpf_testmod_ops2 testmod_2 =3D { .test_1 =3D (void *)test_1 };
> --
> 2.43.0
>

