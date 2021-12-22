Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD0947CA46
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 01:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbhLVAe0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 19:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhLVAeZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 19:34:25 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7E5C061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 16:34:25 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id z26so712539iod.10
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 16:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYR0lSf9TmmMk65SxZgDN9d6ebL8hkH2jGS7+vxBIBA=;
        b=TWDAqGjxfGAToErMCHTJ5lw7PMb/K7TmJB+XPBFQvn2/KIO8fNDx5s8YuV17BeUZSV
         VqZdC0SqQJGCLdaFQMCpPjUmI/zJWGRv9RkbO5L/V+tZ0cUlyTYuoiTVVCpr89YK3KE+
         6tVvTydN2dH3iddtAl0rTwKRHQjijZtnKjQG8t6YAYXJ63hlJKaOEGG93YETAPAI4DNm
         OCOnbynzJOwoGEtSz3R6eunAvQ36Vp+9ODcilY08YRoLMbjvXZmmFCrbqWcIBIGWQxg8
         w45g4EvyRPQBwBjjl5ZsxaLzFhXhy7LcnOcHRGnOzO16xlDKXBPJZoRb2aMmsAzbe4/L
         89dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYR0lSf9TmmMk65SxZgDN9d6ebL8hkH2jGS7+vxBIBA=;
        b=1AoW6rQ/kXOCA37giWDoWTuIuaIh+RvjPc1OSa6PzvFaMCyf3TKp/HIligCiz/YUet
         p+N4bptun3TZ0Ehz2/Tb2R61e5ln6g107vQAwRtTy4x+Rfos8G4pU0RVPKYOt4OU2TPr
         TrovkPycOCxmCyrOb8f1IuWYPfejx2ygSWJsPxZNTD4UXe30eYBDB3npdDA/Bx4TX6+O
         UyP02P+NbabK8rM3vYW8D4f8q11n6nnoNWm4WZYmy01EZrtC5uTRZzeg7dXPVoIAdSAy
         MByNe4pWJXTVGaxE8K1WiFV9NhiW5UaCp+fr7VoSUs3yt+yotld1qJiWYIR3uko1z5sX
         Qk3g==
X-Gm-Message-State: AOAM530u1Oeh4N8tGGw2WSRpIJH0UCx0QK541LS8scDvIKiZNl6P20cM
        8iDeF18aVqgbflekWTm0sYJ5IPq3CDqeiHKPoRWOFVfY
X-Google-Smtp-Source: ABdhPJztevFSKo6DI3jaT+rpAoKMxqZl7OMhgheLKVG/9OeQIWhHBQBHNnvl732nbhCLalerRphgrR1Avy43xvbI9Hw=
X-Received: by 2002:a6b:3b51:: with SMTP id i78mr280698ioa.63.1640133264534;
 Tue, 21 Dec 2021 16:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20211221055312.3371414-1-hengqi.chen@gmail.com> <20211221055312.3371414-3-hengqi.chen@gmail.com>
In-Reply-To: <20211221055312.3371414-3-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Dec 2021 16:34:13 -0800
Message-ID: <CAEf4BzarZ4yrtHcnbHrMwgEEhER7v5U8Hj1Qv0_eutQ2fGJSJA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Test BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL
 macros
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 20, 2021 at 9:54 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add tests for the newly added BPF_KPROBE_SYSCALL/BPF_KRETPROBE_SYSCALL macros.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/kprobe_syscall.c | 40 ++++++++++++++++++
>  .../selftests/bpf/progs/test_kprobe_syscall.c | 41 +++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
> new file mode 100644
> index 000000000000..a1fad70bbb69
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include <test_progs.h>
> +#include <sys/types.h>
> +#include <sys/socket.h>
> +#include "test_kprobe_syscall.skel.h"
> +
> +void test_kprobe_syscall(void)
> +{
> +       struct test_kprobe_syscall *skel;
> +       int err, fd = 0;
> +
> +       skel = test_kprobe_syscall__open();
> +       if (!ASSERT_OK_PTR(skel, "could not open BPF object"))

"could not open BPF object" is not an error message, it's an
identifier of what you are checking (skel here).  If assertion fails,
we'll see something like: "<identifier> is not a valid pointer". So
please pick it properly here and below.

> +               return;
> +
> +       skel->rodata->my_pid = getpid();
> +
> +       err = test_kprobe_syscall__load(skel);
> +       if (!ASSERT_OK(err, "could not load BPF object"))
> +               goto cleanup;
> +
> +       err = test_kprobe_syscall__attach(skel);
> +       if (!ASSERT_OK(err, "could not attach BPF object"))
> +               goto cleanup;
> +
> +       fd = socket(AF_UNIX, SOCK_STREAM, 0);

maybe use something non-zero for the 3rd argument? Also see discussion
on previous patch, let's test something that has at least 4 arguments.

> +
> +       ASSERT_GT(fd, 0, "socket failed");

see comment below, it should be GE

> +       ASSERT_EQ(skel->bss->domain, AF_UNIX, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->type, SOCK_STREAM, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->protocol, 0, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->fd, fd, "BPF_KRETPROBE_SYSCALL failed");
> +
> +cleanup:
> +       if (fd)

it's highly unlikely, but for FDs the check should be >= 0

> +               close(fd);
> +       test_kprobe_syscall__destroy(skel);
> +}

[...]
