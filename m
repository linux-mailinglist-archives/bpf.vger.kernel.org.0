Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3AE2F1E70
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 20:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390635AbhAKTBl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 14:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390631AbhAKTBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Jan 2021 14:01:41 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235BDC06179F
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 11:01:01 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id p22so836411edu.11
        for <bpf@vger.kernel.org>; Mon, 11 Jan 2021 11:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tk09PpC+xcogiIm0/9iC7HB+xKYL7YMpkQzA09X3gJI=;
        b=gaWaqsym0Wuvv7s3L+VfphEDAmW8peqlyoG24vVoohje4utDJtwF+dVyLRwcfHH0U/
         MfJUnCBI0wV6ic3B7xgdkYH2E1sxICdvpi8c9kXZE6CiVLv1h1o/bHw9fQ4+UzRwh1pt
         fKQ33o1HcYPNeYGGebMLILKchUVNIlD7PILoD6GjzjqwI4M4Kz2xv0PwmPWu00Yr3evF
         BdCD+AfSW9+/0cjFUcewiEWU8Iu9OTRt4/TrZirlAhrVy8iz7pcZ2UAz74fUPD7HxO94
         v/FBZU2SdY9rTimHSQLsok50m5YO3R9DgjdS9EqoDfD7+DEkhtKLe0qcCrZrT6eYQ7+Q
         u4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tk09PpC+xcogiIm0/9iC7HB+xKYL7YMpkQzA09X3gJI=;
        b=pFT5tBFghOl60DuZDdfdtjwRj4Tkte7XiSg2vPJo338+46OUxNcsXZr3IEoYJ+d8OW
         iDsJS996RFVJ9FXWLynjK3IO6J5uA2uAAPVlAvcw5FfLDreSQVqKCI48e5SXavtyDoBe
         /JFtm6uVQsu0RkeSav8Qe6mF3nFFvrcLhW39ldQJbbmclc9E2eJr6ugM65byx5/YDjX7
         9lOQi1vcbzid3GVgjCzYW2EosJPPlRPBlL2UfkML0ZgdfSEBAbK8LNqgleK5OBWrSLNA
         MONxHCnKD6Ge/qiXw+VEz8WvkzYRxaeU76e1cZjBP3mP2AvhrQwX5lj04IQl8jwTdI+J
         iuZw==
X-Gm-Message-State: AOAM531cpJX1BJW8YF7QR4MTG+jO3wxLYZry1wInc+ddCXMV0q3e/lDY
        p9l9XZrpljN9xc3W3JCWk537wOXvPDhORDUr+PQE/A==
X-Google-Smtp-Source: ABdhPJx75LrfqPJangFBrcQTYj525uA2AwQJo04bik00+wCODnHpgnKkrpc7g2u6+aj8spFO24L46U1wDbDDORCFWmo=
X-Received: by 2002:aa7:d906:: with SMTP id a6mr586168edr.121.1610391659639;
 Mon, 11 Jan 2021 11:00:59 -0800 (PST)
MIME-Version: 1.0
References: <20210108220930.482456-1-andrii@kernel.org> <20210108220930.482456-8-andrii@kernel.org>
In-Reply-To: <20210108220930.482456-8-andrii@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 11 Jan 2021 11:00:48 -0800
Message-ID: <CA+khW7h96UAK44tSg0eFfbNjtRZ72chaXi2DG3KMrnRKuPU7Fg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 7/7] selftests/bpf: test kernel module ksym externs
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by: Hao Luo <haoluo@google.com>


On Fri, Jan 8, 2021 at 2:09 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add per-CPU variable to bpf_testmod.ko and use those from new selftest to
> validate it works end-to-end.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  3 ++
>  .../selftests/bpf/prog_tests/ksyms_module.c   | 33 +++++++++++++++++++
>  .../selftests/bpf/progs/test_ksyms_module.c   | 26 +++++++++++++++
>  3 files changed, 62 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/ksyms_module.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ksyms_module.c
>
> diff --git a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> index 2df19d73ca49..0b991e115d1f 100644
> --- a/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c
> @@ -3,6 +3,7 @@
>  #include <linux/error-injection.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> +#include <linux/percpu-defs.h>
>  #include <linux/sysfs.h>
>  #include <linux/tracepoint.h>
>  #include "bpf_testmod.h"
> @@ -10,6 +11,8 @@
>  #define CREATE_TRACE_POINTS
>  #include "bpf_testmod-events.h"
>
> +DEFINE_PER_CPU(int, bpf_testmod_ksym_percpu) = 123;
> +
>  noinline ssize_t
>  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
>                       struct bin_attribute *bin_attr,
> diff --git a/tools/testing/selftests/bpf/prog_tests/ksyms_module.c b/tools/testing/selftests/bpf/prog_tests/ksyms_module.c
> new file mode 100644
> index 000000000000..7fa3d8b6ca30
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/ksyms_module.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include <test_progs.h>
> +#include <bpf/libbpf.h>
> +#include <bpf/btf.h>
> +#include "test_ksyms_module.skel.h"
> +
> +static int duration;
> +
> +void test_ksyms_module(void)
> +{
> +       struct test_ksyms_module* skel;
> +       struct test_ksyms_module__bss *bss;
> +       int err;
> +
> +       skel = test_ksyms_module__open_and_load();
> +       if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
> +               return;
> +       bss = skel->bss;
> +
> +       err = test_ksyms_module__attach(skel);
> +       if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
> +               goto cleanup;
> +
> +       usleep(1);
> +
> +       ASSERT_EQ(bss->triggered, true, "triggered");
> +       ASSERT_EQ(bss->out_mod_ksym_global, 123, "global_ksym_val");
> +
> +cleanup:
> +       test_ksyms_module__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_module.c b/tools/testing/selftests/bpf/progs/test_ksyms_module.c
> new file mode 100644
> index 000000000000..d6a0b3086b90
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ksyms_module.c
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Facebook */
> +
> +#include "vmlinux.h"
> +
> +#include <bpf/bpf_helpers.h>
> +
> +extern const int bpf_testmod_ksym_percpu __ksym;
> +
> +int out_mod_ksym_global = 0;
> +bool triggered = false;
> +
> +SEC("raw_tp/sys_enter")
> +int handler(const void *ctx)
> +{
> +       int *val;
> +       __u32 cpu;
> +
> +       val = (int *)bpf_this_cpu_ptr(&bpf_testmod_ksym_percpu);
> +       out_mod_ksym_global = *val;
> +       triggered = true;
> +
> +       return 0;
> +}
> +
> +char LICENSE[] SEC("license") = "GPL";
> --
> 2.24.1
>
