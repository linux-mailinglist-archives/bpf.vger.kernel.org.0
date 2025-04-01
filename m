Return-Path: <bpf+bounces-55099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9226FA7831A
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9021891159
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A892046B7;
	Tue,  1 Apr 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBKxsxSa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D2C1C6FFE
	for <bpf@vger.kernel.org>; Tue,  1 Apr 2025 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743537985; cv=none; b=lALQkm4WYd9UIFYZcTcixtJz9QsEfNmSoQs+mB81Sg1BihuIUtU6YELK++wkvGyxJKPLpPEz+zDNpMqLyU1NFOL+6XVIiCJuNfWURRvVoHJOxytJyFP0W7nWXfnSLnEO9XFtHTjN36SuZtgs7KPgov+kc6/n0+O9vh8tJmiHgs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743537985; c=relaxed/simple;
	bh=HgjgxgElPFP5Qb/lsgiHpNSyr6wsDreWOgZ5aB0OIQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZmsWkQGwRSEQMk4Jrth01sLbJWKm7hEq9qkmRy+KbymcWBwtBL4AKuBI8IBuQxxoYPZQgaypN+eLp/VSR9bzWaV8JRyZtjCW2PXtX024rKs2so5Jp02M+2wVJA6Ssov8bpo95zQhJH42APjDkL3FliMQDul+uWUhOrxpH6dndQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBKxsxSa; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224019ad9edso36693065ad.1
        for <bpf@vger.kernel.org>; Tue, 01 Apr 2025 13:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743537982; x=1744142782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybOtG3VAxLAs6srHFBYiNH/ZxqdGyvM9iMYANl9hoCE=;
        b=hBKxsxSaUiKOUbb3grWSd4sh8Irwaza4wGPXBaXq04PxKCLEfu8z+ryKJNyUwr+i4G
         QNu0gGmXFfNJSpn+Ofr8KLi0uhvjJrCz+s4tASzIy4hSBIGnz/AAJiIBrST/Spidc+AJ
         YfQEXGXhGeIwKUa+SQvMBgsbEz8t471WEIo/8WRkFQaQgqnrVHBYxP09G4VOsFg6RRLX
         w+3sWvXaLS6V1CeO35qMpoFKkXKjqiC9aEquwMdFwtCAVeyIeYximT6H+x2oSSa1ZByQ
         NF77n1bQjAxqdIUbmdlmYvQTd9hLfSE6yjlR5+GEZqu5dEMVIeTyGDSCUlDN+1XmdeoQ
         wsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743537982; x=1744142782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ybOtG3VAxLAs6srHFBYiNH/ZxqdGyvM9iMYANl9hoCE=;
        b=CTS/2Epwost2E7ZVQFjTtCronr6CT786TwYmhhzBtZitQGbuvlk+X7FYrYOL4Udq/w
         dV7qOInQRj5q2EDVE297Qzg9SDEwTBQvdlAjNBNKTTdRUgOUZgMxA+KcE0JHvuby9N52
         EX8IWiGjPrCk9c5OBfMrl/Njscgd5spTp0wamyGfcSL5OpVRXmN1/HOxwJHYBfGeGYnK
         HHuNpymG16lPx0j+usZVhmTLOEnLCPHYHXcpVIXE2MD7RkQj8zJNtSdmgbRxtXJ/JVMi
         1aNlCWkvpd/PyWD029mif+G19T+GRo/8PzzVoDJdJW1Wekka3yoYhdaKxjb1LH2+c1I9
         XE+g==
X-Gm-Message-State: AOJu0YwEOypRgkSs60e8FvUzWUjHwxMxEsyZiDjLe9p1GTjlbZuflqUO
	wNXyaNGGwSqd9+8CHcKcX+N9D8c6T45tt5H0vpQDdylGPG7MeEjZsTA55R0pH8dZprkeGJznSr8
	nXNGbIOi49K6HFC2Jwu0OO5isJtoJnWiU
X-Gm-Gg: ASbGncvjeMpY1IdCDZEH6k3H8Hk/IE0lAmx6UoWk453UDQVzdbEvfec9bfbzcXDVImI
	LuTVHFZgvoRAAqW8TQhvZSzJ0as/msMmlDiQ8JDU0niIez9L+79cQw4T3t5w2fabepbdKYrbX4h
	BQtPjEmAYPNGJ7FV4I7eh7fAWKOY23fFUfjHIMy++zZw==
X-Google-Smtp-Source: AGHT+IHDHcTyUpqXgHraHvAnQDNRRTmcI8gvfGLI5Lntijm8qb/mgjHad2SKTHKBlQfjtgt//5n1m0KoIH68M2CjpN4=
X-Received: by 2002:a05:6a00:2292:b0:736:bfc4:ef2c with SMTP id
 d2e1a72fcca58-739c7529d87mr79995b3a.0.1743537982179; Tue, 01 Apr 2025
 13:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401165417.170632-1-mykyta.yatsenko5@gmail.com> <20250401165417.170632-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250401165417.170632-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Apr 2025 13:06:09 -0700
X-Gm-Features: AQ5f1JqQkV5Thh68e8FJRT3IcCpcsbcl-BGJv2F3ls7I2UNTJeT6YLH7n7WjYuo
Message-ID: <CAEf4Bzbo59+mQs2YVpi0K4gKfbJzGhK3=yaBqHNXQkXBttGi4A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add .BTF.ext line/func
 info getter tests
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 9:54=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Add selftests checking that line and func info retrieved by newly added
> libbpf APIs are the same as returned by kernel via bpf_prog_get_info_by_f=
d.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  .../selftests/bpf/prog_tests/test_btf_ext.c   | 111 ++++++++++++++++++
>  .../selftests/bpf/progs/test_btf_ext.c        |  21 ++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_btf_ext.c
>

Seems like s390x isn't happy about this test, please check what's
going on there. See some nits below as well.

API-wise everything looks good, though.

pw-bot: cr

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c b/tool=
s/testing/selftests/bpf/prog_tests/test_btf_ext.c
> new file mode 100644
> index 000000000000..00aeebc8f863
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_btf_ext.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2020 Facebook */

outdated copy/paste

> +#include <test_progs.h>
> +#include "test_btf_ext.skel.h"
> +#include "btf_helpers.h"
> +
> +static void subtest_line_info(void)
> +{
> +       struct test_btf_ext *skel;
> +       struct bpf_prog_info info;
> +       struct bpf_line_info line_info[1024], *libbpf_line_info;
> +       __u32 info_len =3D sizeof(info), libbbpf_line_info_cnt;
> +       int err, fd, i;
> +
> +       skel =3D test_btf_ext__open();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       bpf_program__set_autoload(skel->progs.global_func, true);

no need to set this explicitly, it will be auto-loaded anyways

> +
> +       err =3D test_btf_ext__load(skel);
> +       if (!ASSERT_OK(err, "skel_load"))
> +               goto out;

you can actually shorten these two steps to test_btf_ext__open_and_load()

> +
> +       fd =3D bpf_program__fd(skel->progs.global_func);
> +
> +       memset(&info, 0, sizeof(info));
> +       info.line_info =3D ptr_to_u64(&line_info);
> +       info.nr_line_info =3D sizeof(line_info);
> +       info.line_info_rec_size =3D sizeof(*line_info);
> +       err =3D bpf_prog_get_info_by_fd(fd, &info, &info_len);
> +       if (!ASSERT_OK(err, "prog_info"))
> +               goto out;
> +
> +       libbpf_line_info =3D bpf_program__line_info(skel->progs.global_fu=
nc);
> +       libbbpf_line_info_cnt =3D bpf_program__line_info_cnt(skel->progs.=
global_func);
> +
> +       if (!ASSERT_OK_PTR(libbpf_line_info, "bpf_program__line_info"))
> +               goto out;
> +       if (!ASSERT_GT(libbbpf_line_info_cnt, 0, "line_info_cnt>0"))
> +               goto out;
> +       if (!ASSERT_EQ(libbbpf_line_info_cnt, info.nr_line_info, "line_in=
fo_cnt"))
> +               goto out;

hm.., why _GT and _EQ?... Shouldn't just ASSERT_EQ be enough?

> +
> +       for (i =3D 0; i < libbbpf_line_info_cnt; ++i) {
> +               int eq =3D memcmp(libbpf_line_info + i, line_info + i, si=
zeof(*line_info));
> +
> +               if (!ASSERT_EQ(eq, 0, "line_info"))
> +                       goto out;
> +       }

seems like we have ASSERT_MEMEQ(), let's use that? I'd probably get
rid of the loop to not spam test output too much. Just one big
ASSERT_MEMEQ() should be good enough (though admittedly would be
harder to debug, if something breaks... but we don't expect that, so
it's probably fine a tradeoff)

> +
> +out:
> +       test_btf_ext__destroy(skel);
> +}
> +
> +static void subtest_func_info(void)
> +{
> +       struct test_btf_ext *skel;
> +       struct bpf_prog_info info;
> +       struct bpf_func_info func_info[1024], *libbpf_func_info;
> +       __u32 info_len =3D sizeof(info), libbbpf_func_info_cnt;
> +       int err, fd, i;
> +
> +       skel =3D test_btf_ext__open();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       bpf_program__set_autoload(skel->progs.global_func, true);
> +
> +       err =3D test_btf_ext__load(skel);
> +       if (!ASSERT_OK(err, "skel_load"))
> +               goto out;
> +
> +       fd =3D bpf_program__fd(skel->progs.global_func);
> +
> +       memset(&info, 0, sizeof(info));
> +       info.func_info =3D ptr_to_u64(&func_info);
> +       info.nr_func_info =3D sizeof(func_info);
> +       info.func_info_rec_size =3D sizeof(*func_info);
> +       err =3D bpf_prog_get_info_by_fd(fd, &info, &info_len);
> +       if (!ASSERT_OK(err, "prog_info"))
> +               goto out;
> +
> +       libbpf_func_info =3D bpf_program__func_info(skel->progs.global_fu=
nc);
> +       libbbpf_func_info_cnt =3D bpf_program__func_info_cnt(skel->progs.=
global_func);
> +
> +       if (!ASSERT_OK_PTR(libbpf_func_info, "bpf_program__func_info"))
> +               goto out;
> +       if (!ASSERT_GT(libbbpf_func_info_cnt, 0, "func_info_cnt>0"))
> +               goto out;
> +       if (!ASSERT_EQ(libbbpf_func_info_cnt, info.nr_func_info, "func_in=
fo_cnt"))
> +               goto out;
> +
> +       for (i =3D 0; i < libbbpf_func_info_cnt; ++i) {
> +               int eq =3D memcmp(libbpf_func_info + i, func_info + i, si=
zeof(*func_info));
> +
> +               if (!ASSERT_EQ(eq, 0, "func_info"))
> +                       goto out;
> +       }
> +
> +out:
> +       test_btf_ext__destroy(skel);
> +}
> +
> +void test_btf_ext(void)
> +{
> +       if (test__start_subtest("func_info"))
> +               subtest_func_info();
> +       if (test__start_subtest("line_info"))
> +               subtest_line_info();

nit: I'd combine those two subtests into one test, same program, same
logic to get data, two ASSERT_MEMEQ(), not sure subtest is buying us
anything

> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_btf_ext.c b/tools/tes=
ting/selftests/bpf/progs/test_btf_ext.c
> new file mode 100644
> index 000000000000..be92e445a988
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_btf_ext.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Meta Platforms Inc. */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +const volatile int val =3D 3;
> +
> +static __attribute__ ((noinline))

use __noinline, it's defined in bpf_helpers.h

> +int f0(int var)
> +{
> +       int retval =3D var + val;
> +
> +       return retval;
> +}
> +
> +SEC("tc")
> +int global_func(struct __sk_buff *skb)
> +{
> +       return f0(skb->len);
> +}
> --
> 2.49.0
>

