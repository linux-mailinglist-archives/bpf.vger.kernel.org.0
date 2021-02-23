Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B12322606
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 07:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhBWGoE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 01:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhBWGoC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Feb 2021 01:44:02 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C750C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 22:43:20 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id n195so15420825ybg.9
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 22:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnpZiyC58CsJWxTXrdVwyihoYIiL1wilxLzR6lBZgYU=;
        b=lMlEKGZMhUSp7TKtKWpfKuKNiVlMhszwJeCMB8+jAOA89klbzHnaggAClCmp14XSCA
         l3aLijtIVB84gpKLdQdRHjgV51+5ndoXywMF6Uu6gBQgRV2N4uw4axpx7rzEu6sQtKXB
         n4NERzzKLqN2cUpkO6ZAgs0Z/uRQTGOgIjLK2z1fv9xqfqyyZGN4oKq5EH2L5m1Hhino
         UYVNB3C9tp8oyP1X5ZBvshIdaKB3lZ3IMkRUAZh/3i8CQglOXAdETbbsPuZl8sLcXVIc
         rHsSGZPHBGke3UdU7+W8YvlP83usn0pJmRvdKD47IaA55RSNSkwg7wHSqcqv2mE9/y5f
         WaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnpZiyC58CsJWxTXrdVwyihoYIiL1wilxLzR6lBZgYU=;
        b=NPgxEBGpiLInoyfeBnC327KmZ4DgTtQeTWWJ9VQuIUGurXQedNteqkz4JaM8T+3pF8
         G/TU/+/+7/i+RwQpF7sUE2bk8coETLFCg6AqoxjWTM6bwY5zj6BlUCIxKq0nz+TkLPVC
         n2MkqoAXcB76TOFKQYHLadWu0zvygQX/jGHi3fjX7RFEOLeYdXSi9dxAKoJ75M43Il7t
         gNCu0p9MXcsEhdc+KdC29Rh359vrAvJGpdJjdAn92xTrP5GMjEKOvl2vB++cPWfpFjiD
         S1+p6r5+by6RHdt28f1S6kt8VvjKVoeCbkzyT7KhnZekv7mA+7ZOkiu5c9Vpt6tQ70Hc
         K61g==
X-Gm-Message-State: AOAM532iSXzIueYVuozlnEYl7gC0RdQJ+EYuV5wqwB8u8IfotfmRZceV
        4TecfbBIfhypSC31BMdknjHj/zls0+Gdq0RI5/0=
X-Google-Smtp-Source: ABdhPJz5SGQURytXXPsX9CPPUXIJHXCXv56wb4f4uqNg9iNfNFq2eF3UrOyYFipczB4s376u8KM+p4qE/saBGzhiTEg=
X-Received: by 2002:a25:1e89:: with SMTP id e131mr38682542ybe.459.1614062599742;
 Mon, 22 Feb 2021 22:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20210212205642.620788-1-me@ubique.spb.ru> <20210212205642.620788-5-me@ubique.spb.ru>
In-Reply-To: <20210212205642.620788-5-me@ubique.spb.ru>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Feb 2021 22:43:08 -0800
Message-ID: <CAEf4BzbbwTeVqP0D_UmYMamfWqp0JSO6TSr_TS-7aoxa-xW3Jg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/4] selftests/bpf: Add unit tests for
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

On Fri, Feb 12, 2021 at 12:57 PM Dmitrii Banshchikov <me@ubique.spb.ru> wrote:
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
>  .../bpf/prog_tests/global_func_args.c         |  60 ++++++++
>  .../bpf/prog_tests/test_global_funcs.c        |   8 ++
>  .../selftests/bpf/progs/test_global_func10.c  |  29 ++++
>  .../selftests/bpf/progs/test_global_func11.c  |  19 +++
>  .../selftests/bpf/progs/test_global_func12.c  |  21 +++
>  .../selftests/bpf/progs/test_global_func13.c  |  24 ++++
>  .../selftests/bpf/progs/test_global_func14.c  |  21 +++
>  .../selftests/bpf/progs/test_global_func15.c  |  22 +++
>  .../selftests/bpf/progs/test_global_func16.c  |  22 +++
>  .../selftests/bpf/progs/test_global_func9.c   | 132 ++++++++++++++++++
>  .../bpf/progs/test_global_func_args.c         |  91 ++++++++++++
>  11 files changed, 449 insertions(+)
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

[...]

> diff --git a/tools/testing/selftests/bpf/progs/test_global_func11.c b/tools/testing/selftests/bpf/progs/test_global_func11.c
> new file mode 100644
> index 000000000000..28488047c849
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_global_func11.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <stddef.h>
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +struct S {
> +       int x;
> +};
> +
> +__noinline int foo(const struct S *s)
> +{
> +       return s ? bpf_get_prandom_u32() < s->x : 0;
> +}
> +
> +SEC("cgroup_skb/ingress")
> +int test_cls(struct __sk_buff *skb)
> +{
> +       return foo(skb);

This needs (void *) cast. It currently generates compilation warning:

progs/test_global_func11.c:18:13: warning: incompatible pointer types
passing 'struct __sk_buff *' to parameter of type 'const struct S *'
[-Wincompatible-pointer-types]
        return foo(skb);
                   ^~~
progs/test_global_func11.c:10:36: note: passing argument to parameter 's' here
__noinline int foo(const struct S *s)
                                   ^

Please send a follow-up patch.

> +}

[...]
