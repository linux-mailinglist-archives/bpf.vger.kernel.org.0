Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375A137B1AB
	for <lists+bpf@lfdr.de>; Wed, 12 May 2021 00:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKWiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 18:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKWiF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 18:38:05 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD52C061574
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:36:58 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id v39so28397797ybd.4
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhaiaVTpiRSyLCAmzZzfNqTwI0aNUZDgx4fn0ALIAFQ=;
        b=H/5ckexrkXN/WLF5xHnx0Vk6j5yXVrRdP9pBUpnG11KDD1R9egXcxD8CQEB2R0vdDl
         ZBFH+eKCpYZDlq5mF5zE3NynkFHJRFUTXr9HGCSnl8g9pOkSbzLNwrWMeR5N0duoXRhE
         5lCOt4jbXa9hC9y8ktl4sRQGGx/m4U6+YtbbBszc4+zE/8p5YionWlFxThfxZ/7prmNr
         dvAxHs7r5i5Fb3W4eD/li0UQeSchUxlYSBVYKYBcmInUAv3aCcsLCTWg95Zy39mS8JoK
         9EOUbX5LEI+i9/t7xd+o8rzL8WbQ2JLWZCXNmEejW13fRMi08hHRSPyGf5ASoyYmowHb
         zZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhaiaVTpiRSyLCAmzZzfNqTwI0aNUZDgx4fn0ALIAFQ=;
        b=UbdOx7ptWe+agLtHrm10PBw5snMIYSnKIPoTBQ0guRhTv1M9Pra+aqDmC6hq6sMX5p
         6bfwFCsdMz2jczLoPR8Irj/pKaUMZ5YPIVhk1TqYKOdsX6AQswh11DyTxOJpEAGoeEHw
         /jGTe1IVXCiSX724sn3FF8E1LBk31ILIX+IOTixUtYKXfBZN5qmFKCivZVV9eYLU/rgF
         3dq7HCbDeyPDaz+AP/EyHZJlnwlKBD8uXWzD4v7NejOmOeL2FiWEfHDYgcK+AKM1sh/W
         JsVanRXhzhdr4DvyRvcBM+fJZJ9+aj6pdEQl3LBRNsZnZ37+qQzpADqvh+5pbVpnR+9M
         gDqA==
X-Gm-Message-State: AOAM532JC/4COa/1dQjEqBJhJT3DcH1ce5UBPg80Q+OHvgmbzERxv0il
        2jSNb0JrKANmNAnwcBPZM6i+3AUOJaJYyIUc+zY=
X-Google-Smtp-Source: ABdhPJx9hkH5lTbp81H4eKl/13E9LYAuDhzQRIg9DSjx3QI8IvgQmKtvY8YVwHwr4Tdm6KDCs+jMJ7fz2MTVMJByiSE=
X-Received: by 2002:a25:1455:: with SMTP id 82mr43385630ybu.403.1620772617469;
 Tue, 11 May 2021 15:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210508034837.64585-1-alexei.starovoitov@gmail.com> <20210508034837.64585-6-alexei.starovoitov@gmail.com>
In-Reply-To: <20210508034837.64585-6-alexei.starovoitov@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 11 May 2021 15:36:46 -0700
Message-ID: <CAEf4BzagS-_nZHJEH0w14BKNiTX-9P-KQFfCphnysrDgQJggeA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 05/22] selftests/bpf: Test for syscall program type
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 7, 2021 at 8:48 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> bpf_prog_type_syscall is a program that creates a bpf map,
> updates it, and loads another bpf program using bpf_sys_bpf() helper.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

One stray CHECK() below, otherwise looks good.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  .../selftests/bpf/prog_tests/syscall.c        | 49 +++++++++++++
>  tools/testing/selftests/bpf/progs/syscall.c   | 71 +++++++++++++++++++
>  2 files changed, 120 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/syscall.c
>  create mode 100644 tools/testing/selftests/bpf/progs/syscall.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/syscall.c b/tools/testing/selftests/bpf/prog_tests/syscall.c
> new file mode 100644
> index 000000000000..fb376c112f0c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/syscall.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +#include <test_progs.h>
> +#include "syscall.skel.h"
> +
> +struct args {
> +       __u64 log_buf;
> +       __u32 log_size;
> +       int max_entries;
> +       int map_fd;
> +       int prog_fd;
> +};
> +
> +void test_syscall(void)
> +{
> +       static char verifier_log[8192];
> +       struct args ctx = {
> +               .max_entries = 1024,
> +               .log_buf = (uintptr_t) verifier_log,
> +               .log_size = sizeof(verifier_log),
> +       };
> +       struct bpf_prog_test_run_attr tattr = {
> +               .ctx_in = &ctx,
> +               .ctx_size_in = sizeof(ctx),
> +       };
> +       struct syscall *skel = NULL;
> +       __u64 key = 12, value = 0;
> +       __u32 duration = 0;
> +       int err;
> +
> +       skel = syscall__open_and_load();
> +       if (CHECK(!skel, "skel_load", "syscall skeleton failed\n"))

ASSERT_OK_PTR?

> +               goto cleanup;
> +
> +       tattr.prog_fd = bpf_program__fd(skel->progs.bpf_prog);
> +       err = bpf_prog_test_run_xattr(&tattr);
> +       ASSERT_EQ(err, 0, "err");
> +       ASSERT_EQ(tattr.retval, 1, "retval");
> +       ASSERT_GT(ctx.map_fd, 0, "ctx.map_fd");
> +       ASSERT_GT(ctx.prog_fd, 0, "ctx.prog_fd");
> +       ASSERT_OK(memcmp(verifier_log, "processed", sizeof("processed") - 1),
> +                 "verifier_log");
> +
> +       err = bpf_map_lookup_elem(ctx.map_fd, &key, &value);
> +       ASSERT_EQ(err, 0, "map_lookup");
> +       ASSERT_EQ(value, 34, "map lookup value");
> +cleanup:
> +       syscall__destroy(skel);
> +}

[...]
