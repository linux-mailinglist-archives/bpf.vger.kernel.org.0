Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A600E3174B4
	for <lists+bpf@lfdr.de>; Thu, 11 Feb 2021 00:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbhBJXuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 18:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhBJXuE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 18:50:04 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1272CC061786
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 15:49:24 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id p186so3850002ybg.2
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 15:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4OlxZpnpkUyRvAL357r/Z/95uNeK3Na89678Gk7NPZ0=;
        b=V/q36nd8KfwLKzWqWJXdQ3cLt+AgqglN9digQGwY134f5nT9+ac58sok7fgypjQ7EL
         Es20g2T1AsfXXGLhD9h8tUNeor5oOewBf3eK9CK+20/6vIDA8x/bbj9F66okyUo0Scui
         oXvqi5t+vU4dOzmfkhbmF5Hzry9IUqn0qchEbsiWQcytiqcm3Ck7Hy2bW56/1gHosrqV
         xgXyjE/WwoxTpdDt3BnUmkhXh+po1WGCz4AbaK8AljQd/xaa/MLTvNfdNr/gFIxRnDzh
         F2tyKEqgkf7XZWFXgjn6HF/1twJ+T+z+aYf4xtBgZku6U0yPlqj11eu21tDorEVVC1Is
         unpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4OlxZpnpkUyRvAL357r/Z/95uNeK3Na89678Gk7NPZ0=;
        b=ZuQR9O1T0DntqDli/nsYdKxbiRTXNsPM6G9N3pmrTkFAuVMgB8qU74xbhFzCvs1DhZ
         ABBsUWKD0fR7ytrymEFOCLZ+2rmybPRdpA/LR4WoDkLyl7GqlzRmwvNQ3BjuBUDe5+FJ
         7r0uclwRpK2FT3JpMDKRtd9BDQKk+1qtl2sMTPImPQxcxclGPl8VXesZ7OugYtEBEAIg
         C2IdIz6JwK0XdKoSjwzaXj/BztRPVHbrUJyTjJKUIF3q/pV/E/2fpNUoGVYVxtLRQcpX
         UGa43HTRmPpUgPNUHxOPfnzEr8PXCGJa0MPgf8XXVcYz5vT6t+aR75bYYNIgUYxznzsk
         CBvw==
X-Gm-Message-State: AOAM532sSmZ6lPlGFmj1lai0ZNrN98Vw4jf95dDIokBI6XnEwl7AVGAS
        42IYFCIBUTO8nFSTB68hZuNmgPooWCg5/9D+zAM=
X-Google-Smtp-Source: ABdhPJzb3+lq+7ZdkyMzbr38X4q7ybakyaxiv/BnVOR1Ugi99TBvoK4Y0S55A45qra2LhAiMmJ02w5o6VLO7LCe1N+A=
X-Received: by 2002:a25:3805:: with SMTP id f5mr7556955yba.27.1613000963404;
 Wed, 10 Feb 2021 15:49:23 -0800 (PST)
MIME-Version: 1.0
References: <20210209064421.15222-1-me@ubique.spb.ru> <20210209064421.15222-5-me@ubique.spb.ru>
In-Reply-To: <20210209064421.15222-5-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Feb 2021 15:49:12 -0800
Message-ID: <CAEf4BzYJ0mSOavUVmRMq3XpLfVxfY6sxtahKT8kNL0nrjLZhTA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/4] selftests/bpf: Add unit tests for
 pointers in global functions
To:     Dmitrii Banshchikov <me@ubique.spb.ru>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Andrey Ignatov <rdna@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 8, 2021 at 10:44 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
>
> test_global_func9  - check valid pointer's scenarios
> test_global_func10 - check that a smaller type cannot be passed as a
>                      larger one
> test_global_func11 - check that CTX pointer cannot be passed
> test_global_func12 - check access to a null pointer
> test_global_func13 - check access to an arbitrary pointer value
> test_global_func14 - check that an opaque pointer cannot be passed
> test_global_func15 - check that a variable has an unknown value after
>                      it was passed to a global function by pointer
> test_global_func16 - check access to uninitialized stack memory
>
> test_global_func_args - check read and write operations through a pointer
>
> Signed-off-by: Dmitrii Banshchikov <me@ubique.spb.ru>
> ---
> v1 -> v2:
>  - Test pointer to a global variable, array, enum, int
>  - Test reading / writing values by pointers in global functions
>

Some minor needs, but overall it looks great!

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../bpf/prog_tests/global_func_args.c         |  56 ++++++++
>  .../bpf/prog_tests/test_global_funcs.c        |   8 ++
>  .../selftests/bpf/progs/test_global_func10.c  |  29 ++++
>  .../selftests/bpf/progs/test_global_func11.c  |  19 +++
>  .../selftests/bpf/progs/test_global_func12.c  |  21 +++
>  .../selftests/bpf/progs/test_global_func13.c  |  24 ++++
>  .../selftests/bpf/progs/test_global_func14.c  |  21 +++
>  .../selftests/bpf/progs/test_global_func15.c  |  22 +++
>  .../selftests/bpf/progs/test_global_func16.c  |  22 +++
>  .../selftests/bpf/progs/test_global_func9.c   | 132 ++++++++++++++++++
>  .../bpf/progs/test_global_func_args.c         |  79 +++++++++++
>  11 files changed, 433 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/global_func_args.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func10.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func11.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func12.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func13.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func14.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func15.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func16.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func9.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_func_args.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_args.c b/tools/testing/selftests/bpf/prog_tests/global_func_args.c
> new file mode 100644
> index 000000000000..643355e3358f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/global_func_args.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "test_progs.h"
> +#include "network_helpers.h"
> +
> +static void test_global_func_args0(struct bpf_object *obj, __u32 duration)

I'd just add a single `static int duration;` at the top of the file
and forget about it.

> +{
> +       int err, i, map_fd, actual_value;
> +
> +       map_fd = bpf_find_map(__func__, obj, "values");
> +       if (CHECK_FAIL(map_fd < 0))

no CHECK_FAIL, please use CHECK or ASSERT_XXX variations. CHECK_FAIL
leaves no trace when debugging, making life unnecessarily hard.

> +               return;
> +
> +       struct {
> +               const char *descr;
> +               int expected_value;
> +       } tests[] = {
> +               {"passing NULL pointer", 0},
> +               {"returning value", 1},
> +               {"reading local variable", 100 },
> +               {"writing local variable", 101 },
> +               {"reading global variable", 42 },
> +               {"writing global variable", 43 },
> +               {"writing to pointer-to-pointer", 1 },
> +       };
> +
> +       for (i = 0; i < ARRAY_SIZE(tests); ++i) {
> +               const int expected_value = tests[i].expected_value;
> +
> +               err = bpf_map_lookup_elem(map_fd, &i, &actual_value);
> +
> +               CHECK(err || actual_value != expected_value, tests[i].descr,
> +                        "err %d result %d expected %d\n", err, actual_value, expected_value);
> +       }
> +}
> +

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_global_func_args.c b/tools/testing/selftests/bpf/progs/test_global_func_args.c
> new file mode 100644
> index 000000000000..c8e47e120bf6
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func_args.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +
> +#include <bpf/bpf_helpers.h>
> +
> +struct S {
> +       int v;
> +};
> +
> +static struct S global_variable;

this can get optimized away. Just drop `static` to make it global, or
otherwise you'd need `static volatile`


> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 7);
> +       __type(key, __u32);
> +       __type(value, int);
> +} values SEC(".maps");
> +
