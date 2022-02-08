Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE844AE38F
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 23:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386424AbiBHWXD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 17:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387226AbiBHWGp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 17:06:45 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0C0C0612B8
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 14:06:44 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id p11so203622ils.1
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 14:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ro4jkBv5KbYqCqJzSpxJ6/IsNgdcc/t2D847RvDWEvo=;
        b=EEabqDx3omVAd3PVGxrQXkokLmI8FYqmdk1ptQZKMvnm86UHlVUHt5btpgsfICQPVM
         1XNWixcorIcyf2pf8PTAqXz+GfxFezbk7zYjkSb2G/yTZHbxcCF+oYBXwXarEGgA4AVk
         HV6b9uHuWfkA1Sm1+MWdD5jT91R6+jfAZtzIDqfxdsKHJd/tetv1dTBC9mMG4B/cKm6g
         n52GMWIDjaNHST9voUHNJZAixx0/+cPdrHle3XEIDATouyGUU3g7bw2xWqCZvqBDYCGr
         165IXsyFsXO3Lk3Ub34TKsUf81NtYBOfmZ0L0wkz8J/qJrn58GCksiwkLdXQB+1dHNL2
         lPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ro4jkBv5KbYqCqJzSpxJ6/IsNgdcc/t2D847RvDWEvo=;
        b=m21NLspImI2q7Ow5uW9CBwK+ggqb5huanecU0HZ1mgyONhedmOnJDR0sevJhqwsI/m
         7xzh4FkvnHbJK8fTZ/p8yklq8TzB0bJNmVQsEfiNc7PcnYQtuBrKq3Dhpi2RaYZ5kkrD
         zafYdz/zA1ygvdja7nJeDv6L4+27lGqu9K4+m1SQDtXVhtfmu/m12gAvRcz4CRBobOG0
         JsB2GCEXzD3O8pPigb1+rwfkP+0sLOYilFlGVN/ZC9gYVPMVF96K6pjQFU4AjsjUipfx
         FZfZZzkgyHHkasNMhTvhY+X80hk3r5QX+RgzwsB8IjGCHt33eagBUFvi6AQqU0aounn1
         azKg==
X-Gm-Message-State: AOAM5338iZrttvIHeoTrAmzOib1rJkid6Eldn3ZJzuOCQ0RuqR9hAt8d
        U9vyvPTbqT9m9dDropQJgmFIp2DkJHeRr4/LO5U=
X-Google-Smtp-Source: ABdhPJwP2zHhU2G4Tcrj+Er7JLyW9brETzVlWthawo1v7JXcZYm24R6IIvcXiKJ3Dxov9v9L8zQUNmbZYQHfxv0dhGg=
X-Received: by 2002:a05:6e02:1b81:: with SMTP id h1mr3366772ili.239.1644358003929;
 Tue, 08 Feb 2022 14:06:43 -0800 (PST)
MIME-Version: 1.0
References: <20220208051635.2160304-1-iii@linux.ibm.com> <20220208051635.2160304-4-iii@linux.ibm.com>
In-Reply-To: <20220208051635.2160304-4-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Feb 2022 14:06:32 -0800
Message-ID: <CAEf4BzYO+5+bbqv2ESuZnZfP2YOpGAAeLF5izg_Go4p4in4U2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 03/14] selftests/bpf: Compile
 bpf_syscall_macro test also with user headers
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 7, 2022 at 9:16 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Verify that using linux/ptrace.h instead of vmlinux.h works fine.
> Since without vmlinux.h and with CO-RE it's not possible to access the
> first syscall argument on arm64 and s390x, and any syscall arguments on
> Intel, skip the corresponding checks.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  ...call_macro.c => test_bpf_syscall_macro_common.h} |  8 +++++++-
>  .../bpf/prog_tests/test_bpf_syscall_macro_kernel.c  | 13 +++++++++++++
>  .../bpf/prog_tests/test_bpf_syscall_macro_user.c    | 13 +++++++++++++
>  ...f_syscall_macro.c => bpf_syscall_macro_common.h} |  8 ++++++--
>  .../selftests/bpf/progs/bpf_syscall_macro_kernel.c  |  4 ++++
>  .../selftests/bpf/progs/bpf_syscall_macro_user.c    | 10 ++++++++++
>  6 files changed, 53 insertions(+), 3 deletions(-)
>  rename tools/testing/selftests/bpf/prog_tests/{test_bpf_syscall_macro.c => test_bpf_syscall_macro_common.h} (89%)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_kernel.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_user.c
>  rename tools/testing/selftests/bpf/progs/{bpf_syscall_macro.c => bpf_syscall_macro_common.h} (87%)
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro_kernel.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro_user.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_common.h
> similarity index 89%
> rename from tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> rename to tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_common.h
> index f5f4c8adf539..9f2a395abff7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_common.h
> @@ -2,7 +2,6 @@
>  /* Copyright 2022 Sony Group Corporation */
>  #include <sys/prctl.h>
>  #include <test_progs.h>
> -#include "bpf_syscall_macro.skel.h"
>
>  void test_bpf_syscall_macro(void)
>  {
> @@ -46,7 +45,13 @@ void test_bpf_syscall_macro(void)
>         ASSERT_EQ(skel->bss->arg5, exp_arg5, "syscall_arg5");
>
>         /* check whether args of syscall are copied correctly for CORE variants */
> +#if defined(__BPF_SYSCALL_MACRO_KERNEL_SKEL_H__) || \
> +               (!defined(__s390__) && !defined(__aarch64__) && \
> +                !defined(__i386__) && !defined(__x86_64__))

All this is horrible, please no. I think we have better ways to do it
with CO-RE.

>         ASSERT_EQ(skel->bss->arg1_core, exp_arg1, "syscall_arg1_core_variant");
> +#endif
> +#if defined(__BPF_SYSCALL_MACRO_KERNEL_SKEL_H__) || \
> +               (!defined(__i386__) && !defined(__x86_64__))
>         ASSERT_EQ(skel->bss->arg2_core, exp_arg2, "syscall_arg2_core_variant");
>         ASSERT_EQ(skel->bss->arg3_core, exp_arg3, "syscall_arg3_core_variant");
>         /* it cannot copy arg4 when uses PT_REGS_PARM4_CORE on x86_64 */
> @@ -57,6 +62,7 @@ void test_bpf_syscall_macro(void)
>  #endif
>         ASSERT_EQ(skel->bss->arg4_core, exp_arg4, "syscall_arg4_core_variant");
>         ASSERT_EQ(skel->bss->arg5_core, exp_arg5, "syscall_arg5_core_variant");
> +#endif
>
>  cleanup:
>         bpf_syscall_macro__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_kernel.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_kernel.c
> new file mode 100644
> index 000000000000..7ceabd62bb0f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_kernel.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "bpf_syscall_macro_kernel.skel.h"
> +
> +void test_bpf_syscall_macro_kernel(void);
> +
> +#define test_bpf_syscall_macro test_bpf_syscall_macro_kernel
> +#define bpf_syscall_macro bpf_syscall_macro_kernel
> +#define bpf_syscall_macro__open bpf_syscall_macro_kernel__open
> +#define bpf_syscall_macro__load bpf_syscall_macro_kernel__load
> +#define bpf_syscall_macro__attach bpf_syscall_macro_kernel__attach
> +#define bpf_syscall_macro__destroy bpf_syscall_macro_kernel__destroy
> +
> +#include "test_bpf_syscall_macro_common.h"
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_user.c b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_user.c
> new file mode 100644
> index 000000000000..f31558f14e7e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro_user.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "bpf_syscall_macro_user.skel.h"
> +
> +void test_bpf_syscall_macro_user(void);
> +
> +#define test_bpf_syscall_macro test_bpf_syscall_macro_user
> +#define bpf_syscall_macro bpf_syscall_macro_user
> +#define bpf_syscall_macro__open bpf_syscall_macro_user__open
> +#define bpf_syscall_macro__load bpf_syscall_macro_user__load
> +#define bpf_syscall_macro__attach bpf_syscall_macro_user__attach
> +#define bpf_syscall_macro__destroy bpf_syscall_macro_user__destroy
> +
> +#include "test_bpf_syscall_macro_common.h"
> diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h
> similarity index 87%
> rename from tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> rename to tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h
> index f5c6ef2ff6d1..8717605358d3 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_common.h
> @@ -1,7 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright 2022 Sony Group Corporation */
> -#include <vmlinux.h>
> -
>  #include <bpf/bpf_core_read.h>
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
> @@ -46,12 +44,18 @@ int BPF_KPROBE(handle_sys_prctl)
>         bpf_probe_read_kernel(&arg5, sizeof(arg5), &PT_REGS_PARM5_SYSCALL(real_regs));
>
>         /* test for the CORE variant of PT_REGS_PARM */
> +#if defined(__KERNEL__) || defined(__VMLINUX_H__) || \
> +               (!defined(bpf_target_s390) && !defined(bpf_target_arm64) && \
> +                !defined(bpf_target_x86))
>         arg1_core = PT_REGS_PARM1_CORE_SYSCALL(real_regs);
> +#endif
> +#if defined(__KERNEL__) || defined(__VMLINUX_H__) || !defined(bpf_target_x86)
>         arg2_core = PT_REGS_PARM2_CORE_SYSCALL(real_regs);
>         arg3_core = PT_REGS_PARM3_CORE_SYSCALL(real_regs);
>         arg4_core_cx = PT_REGS_PARM4_CORE(real_regs);
>         arg4_core = PT_REGS_PARM4_CORE_SYSCALL(real_regs);
>         arg5_core = PT_REGS_PARM5_CORE_SYSCALL(real_regs);
> +#endif
>
>         return 0;
>  }
> diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro_kernel.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_kernel.c
> new file mode 100644
> index 000000000000..1affac21266d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_kernel.c
> @@ -0,0 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +
> +#include "bpf_syscall_macro_common.h"
> diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro_user.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_user.c
> new file mode 100644
> index 000000000000..1c078d528e8c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro_user.c
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/ptrace.h>
> +#include <linux/types.h>
> +#include <sys/types.h>
> +
> +#include "bpf_syscall_macro_common.h"
> +
> +#if defined(__KERNEL__) || defined(__VMLINUX_H__)
> +#error This test must be compiled with userspace headers
> +#endif
> --
> 2.34.1
>
