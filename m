Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB07D49400B
	for <lists+bpf@lfdr.de>; Wed, 19 Jan 2022 19:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356838AbiASShu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 13:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356837AbiASSht (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 13:37:49 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E20C06161C
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:37:49 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id f24so4053355ioc.0
        for <bpf@vger.kernel.org>; Wed, 19 Jan 2022 10:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=23TLRPFaV8xWlV4PxZ4KJ/AWU/iC3g3ih5HC/zSBPPk=;
        b=h82ElW5mjZiTyRNw/KyiivBgoiwZ4kL2nm+4jgK+Tk8yPFv7eBDlt3HKbAIq1UuxVr
         WpsGSZXrGbYFuvdLIOBygDJMsY17D46D3MvS/rQxzxtKTVjMysLjzQROi8En+VGjr+qd
         xdALGbW0+nJe8sbRls0n0Z4l22aooKqxwpRBITDHxT6mUHNFF8IStVSqwCn80sNi7YJt
         pNfGo2IfISbgNUvbAP9zAR6+Rq5hHi/MZXB7PeoWc9qJ2A2cfsGiQHpAUigcHuKgZRgC
         fzqb2hVuMx+mWXS5hYW9dswgBNJt1qQzWctb6N4ZcKav24UL0k/DqNrDbPWfeOlYmc0g
         vRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=23TLRPFaV8xWlV4PxZ4KJ/AWU/iC3g3ih5HC/zSBPPk=;
        b=k8g7c8YwHp6r9xI4huEO/eFsNiMLrV3q29jc98wpuON/adF/6vRtgHSvhN+cHyjatP
         YTQyvPoGd7XhyuiF+95Z1dm5O6bi5lsUCDDUChoZvChO/gQZt0Q9twUbGy09CZUPVAY/
         K5e8RLHrLw77Kr+SFhinmghu8qmLfLCBkd8oZ0q1iYoCs473AG1IiHcyR2LxbyoGa5Kn
         VKDwe/0uII2wWsltUnbya7UE0ewHZJvQOCtP5xFKfPpjmRyNwFygbktwVJqzBUg1Ipwt
         aeLXxy6to5K9yEpNMLVmQ8cg9suUhflpPhq0iSFLPxJP5eVraymZyAUYLaJaKOtZ0QIZ
         SOcw==
X-Gm-Message-State: AOAM5308ye9l2PFqfVHvmoxHy7ThOwkmAPktccLL/Y6bOT7DqARE/CMj
        PehOeb8FjwIvUIEXIwMHT+ijZMqWopIpWoRL4s973icyyXk=
X-Google-Smtp-Source: ABdhPJxE4qid4cIGHDoogXkEjzhfzUkCVhiZf5wAelucv+5iOQVA3b4sq1KnqTcN1cK9/l0kKn77LWZyjfHgWMkdIn0=
X-Received: by 2002:a05:6638:410a:: with SMTP id ay10mr15341062jab.237.1642617469122;
 Wed, 19 Jan 2022 10:37:49 -0800 (PST)
MIME-Version: 1.0
References: <20220119131209.36092-1-Kenta.Tada@sony.com> <20220119131209.36092-4-Kenta.Tada@sony.com>
In-Reply-To: <20220119131209.36092-4-Kenta.Tada@sony.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Jan 2022 10:37:38 -0800
Message-ID: <CAEf4BzYiokKees3qSN6ObG-8cd_Ovdnf+485nz3OTL_qu=tX6A@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] libbpf: Add a test to confirm PT_REGS_PARM4_SYSCALL
To:     Kenta Tada <Kenta.Tada@sony.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 5:14 AM Kenta Tada <Kenta.Tada@sony.com> wrote:
>
> Add a selftest to verify the behavior of PT_REGS_xxx.
>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  .../bpf/prog_tests/test_bpf_syscall_macro.c   | 49 ++++++++++++++++++
>  .../selftests/bpf/progs/bpf_syscall_macro.c   | 51 +++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> new file mode 100644
> index 000000000000..2f725393195b
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2022 Sony Group Corporation */
> +#include <sys/prctl.h>
> +#include <test_progs.h>
> +#include "bpf_syscall_macro.skel.h"
> +
> +//void serial_bpf_syscall_macro(void)

leftover

> +void test_bpf_syscall_macro(void)
> +{
> +       struct bpf_syscall_macro *skel = NULL;
> +       int err;
> +       int exp_arg1 = 1001;
> +       unsigned long exp_arg2 = 12;
> +       unsigned long exp_arg3 = 13;
> +       unsigned long exp_arg4 = 14;
> +       unsigned long exp_arg5 = 15;
> +
> +       /* check whether it can open program */
> +       skel = bpf_syscall_macro__open();
> +       if (!ASSERT_OK_PTR(skel, "bpf_syscall_macro__open"))
> +               return;
> +
> +       skel->rodata->filter_pid = getpid();
> +
> +       /* check whether it can load program */
> +       err = bpf_syscall_macro__load(skel);
> +       if (!ASSERT_OK(err, "bpf_syscall_macro__load"))
> +               goto cleanup;
> +
> +       /* check whether it can attach kprobe */
> +       err = bpf_syscall_macro__attach(skel);
> +       if (!ASSERT_OK(err, "bpf_syscall_macro__attach"))
> +               goto cleanup;
> +
> +       /* check whether args of syscall are copied correctly */
> +       prctl(exp_arg1, exp_arg2, exp_arg3, exp_arg4, exp_arg5);
> +       ASSERT_EQ(skel->bss->arg1, exp_arg1, "syscall_arg1");
> +       ASSERT_EQ(skel->bss->arg2, exp_arg2, "syscall_arg2");
> +       ASSERT_EQ(skel->bss->arg3, exp_arg3, "syscall_arg3");
> +       /* it cannot copy arg4 when uses PT_REGS_PARM4 on x86_64 */
> +#ifdef __x86_64__
> +       ASSERT_NEQ(skel->bss->arg4_cx, exp_arg4, "syscall_arg4_from_cx");
> +#endif

else ASSERT_EQ(arg4_cx and exp_arg4) ?

> +       ASSERT_EQ(skel->bss->arg4, exp_arg4, "syscall_arg4");
> +       ASSERT_EQ(skel->bss->arg5, exp_arg5, "syscall_arg5");
> +
> +cleanup:
> +       bpf_syscall_macro__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> new file mode 100644
> index 000000000000..5a7063de27c3
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2022 Sony Group Corporation */
> +#include <linux/bpf.h>
> +#include <linux/ptrace.h>
> +#include <sys/types.h>
> +#include <unistd.h>

Use #include <vmlinux.h> instead, please

> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +int arg1 = 0;
> +unsigned long arg2 = 0;
> +unsigned long arg3 = 0;
> +unsigned long arg4_cx = 0;
> +unsigned long arg4 = 0;
> +unsigned long arg5 = 0;
> +
> +const volatile pid_t filter_pid = 0;
> +
> +SEC("kprobe/" SYS_PREFIX "sys_prctl")
> +int BPF_KPROBE(handle_sys_prctl)
> +{
> +       struct pt_regs *real_regs;
> +       int orig_arg1;
> +       unsigned long orig_arg2, orig_arg3, orig_arg4_cx, orig_arg4, orig_arg5;
> +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +
> +       if (pid != filter_pid)
> +               return 0;
> +
> +       real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
> +       bpf_probe_read_kernel(&orig_arg1, sizeof(orig_arg1), &PT_REGS_PARM1_SYSCALL(real_regs));

orig_arg1 = PT_REGS_PARM1_CORE_SYSCALL(real_regs);

and same for others (the whole point of _CORE_SYSCALL macros!)


> +       bpf_probe_read_kernel(&orig_arg2, sizeof(orig_arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg3, sizeof(orig_arg3), &PT_REGS_PARM3_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg4_cx, sizeof(orig_arg4_cx), &PT_REGS_PARM4(real_regs));
> +       bpf_probe_read_kernel(&orig_arg4, sizeof(orig_arg4), &PT_REGS_PARM4_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg5, sizeof(orig_arg5), &PT_REGS_PARM5_SYSCALL(real_regs));
> +
> +       /* copy all actual args and the wrong arg4 on x86_64 */
> +       arg1 = orig_arg1;
> +       arg2 = orig_arg2;
> +       arg3 = orig_arg3;
> +       arg4_cx = orig_arg4_cx;
> +       arg4 = orig_arg4;
> +       arg5 = orig_arg5;
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.32.0
>
