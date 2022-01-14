Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E39448F1AD
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 21:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiANUt5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 15:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244390AbiANUty (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Jan 2022 15:49:54 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60BDC061574
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 12:49:53 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id e8so9344750ilm.13
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 12:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yRGMO+x07j+GdgxXsWrjYSxXhXOgS6ueQ3Qqf2RlR1Q=;
        b=iHgRJFxnSUEXs6r5dP6RXC9ij4/7fVs/UXQKJES9n7Y/pTZ1n6GZQ3eBHWVKcIsaai
         YYEuDz5/72+5UsdsniJNrmMvJFqc7CAlZuu3Jl9JqwBXd840SW1EYC3HDGm5znr81WOQ
         vajo57V00zPVLzrmCxfCa832Xru3oRHt6IHmL5FmYguBPgkfZ0I5ZYv7fw97XUeZTE2/
         AEkn90OsVav8P5QWPOBh5pjtn9TjTQOyAGeN2T1jOULLMx3Dl0bxIjGoPPlMU3gObQq1
         Ct1q71wjjB0V2IRsDr9P9YDr+p6HG0aIbEuzTZDvq3U/SKmBYuiU3150zA1PJMC5Cboc
         JKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yRGMO+x07j+GdgxXsWrjYSxXhXOgS6ueQ3Qqf2RlR1Q=;
        b=N5tikXw2wRBGn9sWFfOydttk+6gQcUi5r7ZUOVxGKpX1Z+OkSPI3F0VEkpUfVasgma
         XzUZoqNU8tcPy8hLBKOPMcZCCdJN0/UTDzRSRnSVhnFZCNTkyRN7bEZiRRGh2bAWLBIS
         2ZClUlWhC1Py5DWZmXlgQrC3WmKLjvLYp1+Xwe5xbE9bB4mvn/K3MKndEebUu3AVHWvm
         gMEWHvN930TdvXxAjJdh954F0axY3WWOAFKUNRG4IG4jDCXOTOL+FoF6BLRhrvbw5kM5
         MfDUCCIP1DUIMOGdTWsWahMSsBVF2rjFayd3OQAFsMnpC9xeqa4NfNlZiFMQbrJ7wvwp
         xBfA==
X-Gm-Message-State: AOAM530jzS7o8bjWUvu1bHXVcCXB5+CnD2TOwgBvOg6t07kX0G6YJSqi
        0jPMmAfxnzJ4irf6gmPUfl2fgq5yDt/wKDsrZhQ=
X-Google-Smtp-Source: ABdhPJxU4C9GX4C0nzeoC5yecidPS7IatV9/PpzSY36HQC0b2PPDXl81EyXJVDfZy+mqh5gIyvLdyMSLNhcniB6bZPA=
X-Received: by 2002:a05:6e02:190e:: with SMTP id w14mr5815449ilu.98.1642193393323;
 Fri, 14 Jan 2022 12:49:53 -0800 (PST)
MIME-Version: 1.0
References: <TYCPR01MB5936F73E6F6BD9FF338F4FE6F5539@TYCPR01MB5936.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB5936F73E6F6BD9FF338F4FE6F5539@TYCPR01MB5936.jpnprd01.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 14 Jan 2022 12:49:42 -0800
Message-ID: <CAEf4BzawVU-v6E6Z3Br=vNLD4GkpCahtw14HLFhCCPTtd_-nEw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] libbpf: Fix the incorrect register read for
 syscalls on x86_64
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

On Thu, Jan 13, 2022 at 1:06 AM <Kenta.Tada@sony.com> wrote:
>
> Add a selftest to verify the behavior of PT_REGS_xxx.
>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  .../bpf/prog_tests/bpf_syscall_macro_test.c   | 60 +++++++++++++++++++
>  .../bpf/progs/test_bpf_syscall_macro.c        | 52 ++++++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/bpf_syscall_macro_test.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_syscall_macro.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_syscall_macro_test.c b/tools/testing/selftests/bpf/prog_tests/bpf_syscall_macro_test.c
> new file mode 100644
> index 000000000000..cd7133954210
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_syscall_macro_test.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2022 Sony Group Corporation */
> +#include <sys/prctl.h>
> +#include <test_progs.h>
> +#include "test_bpf_syscall_macro.skel.h"
> +
> +void serial_test_bpf_syscall_macro(void)

Let's not add serial tests unnecessarily, keep it parallelized, just
filter by PID in the BPF program (each parallel worker runs in a
different process, so filtering allows multiple tests to co-exist
without interfering, we do it in multiple tests).

> +{
> +       struct test_bpf_syscall_macro *skel = NULL;
> +       int err;
> +       int duration = 0;
> +       int exp_arg1 = 1001;
> +       unsigned long exp_arg2 = 12;
> +       unsigned long exp_arg3 = 13;
> +       unsigned long exp_arg4 = 14;
> +       unsigned long exp_arg5 = 15;
> +
> +       /* check whether it can load program */
> +       skel = test_bpf_syscall_macro__open_and_load();
> +       if (CHECK(!skel, "skel_open_and_load", "skeleton open_and_load failed\n"))
> +               goto cleanup;
> +
> +       /* check whether it can attach kprobe */
> +       err = test_bpf_syscall_macro__attach(skel);
> +       if (CHECK(err, "attach_kprobe", "err %d\n", err))
> +               goto cleanup;
> +
> +       /* check whether args of syscall are copied correctly */
> +       prctl(exp_arg1, exp_arg2, exp_arg3, exp_arg4, exp_arg5);
> +       if (CHECK(skel->bss->arg1 != exp_arg1, "syscall_arg1",
> +                 "exp %d, got %d\n", exp_arg1, skel->bss->arg1)) {
> +               goto cleanup;
> +       }
> +       if (CHECK(skel->bss->arg2 != exp_arg2, "syscall_arg2",
> +                 "exp %ld, got %ld\n", exp_arg2, skel->bss->arg2)) {
> +               goto cleanup;
> +       }
> +       if (CHECK(skel->bss->arg3 != exp_arg3, "syscall_arg3",
> +                 "exp %ld, got %ld\n", exp_arg3, skel->bss->arg3)) {
> +               goto cleanup;
> +       }
> +       /* it cannot copy arg4 when uses PT_REGS_PARM4 on x86_64 */
> +#ifdef __x86_64__
> +       if (CHECK(skel->bss->arg4_cx == exp_arg4, "syscall_arg4_from_cx",
> +                 "exp %ld, got %ld\n", exp_arg4, skel->bss->arg4_cx)) {
> +               goto cleanup;
> +       }
> +#endif
> +       if (CHECK(skel->bss->arg4 != exp_arg4, "syscall_arg4",
> +                 "exp %ld, got %ld\n", exp_arg4, skel->bss->arg4)) {
> +               goto cleanup;
> +       }
> +       if (CHECK(skel->bss->arg5 != exp_arg5, "syscall_arg5",
> +                 "exp %ld, got %ld\n", exp_arg5, skel->bss->arg5)) {
> +               goto cleanup;
> +       }

please use ASSERT_EQ() for all these CHECK()s instead. You also don't
have to goto clean up after each of them, keep them unconditional.

> +
> +cleanup:
> +       test_bpf_syscall_macro__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/test_bpf_syscall_macro.c
> new file mode 100644
> index 000000000000..002889d506cc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_bpf_syscall_macro.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2022 Sony Group Corporation */
> +#include <linux/bpf.h>
> +#include <linux/ptrace.h>
> +
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +#if defined(__TARGET_ARCH_x86)
> +#define SYS_PREFIX "__x64_"
> +#elif defined(__TARGET_ARCH_s390)
> +#define SYS_PREFIX "__s390x_"
> +#elif defined(__TARGET_ARCH_arm64)
> +#define SYS_PREFIX "__arm64_"
> +#else
> +#define SYS_PREFIX ""
> +#endif
> +

Please extract this from test_probe_user.c into a new common helper
under progs/ (e.g., progs/bpf_misc.h or something, can't come up with
a better name). We'll need such a header to fix all the other fentry
and kprobe selftests that use __x86_sys_* attach functions anyways
(btw, help with this clean up would be greatly appreciated as well!)


> +int arg1 = 0;
> +unsigned long arg2 = 0;
> +unsigned long arg3 = 0;
> +unsigned long arg4_cx = 0;
> +unsigned long arg4 = 0;
> +unsigned long arg5 = 0;
> +
> +SEC("kprobe/" SYS_PREFIX "sys_prctl")
> +int BPF_KPROBE(handle_sys_prctl)
> +{
> +       struct pt_regs *real_regs;
> +       int orig_arg1;
> +       unsigned long orig_arg2, orig_arg3, orig_arg4_cx, orig_arg4, orig_arg5;
> +
> +       real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
> +       bpf_probe_read_kernel(&orig_arg1, sizeof(orig_arg1), &PT_REGS_PARM1_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg2, sizeof(orig_arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg3, sizeof(orig_arg3), &PT_REGS_PARM3_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg4_cx, sizeof(orig_arg4_cx), &PT_REGS_PARM4(real_regs));
> +       bpf_probe_read_kernel(&orig_arg4, sizeof(orig_arg4), &PT_REGS_PARM4_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg5, sizeof(orig_arg5), &PT_REGS_PARM5_SYSCALL(real_regs));

This actually shows clearly that we do need _CORE() variants of
_SYSCALL macros. Please add them as well in patch #1.


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
