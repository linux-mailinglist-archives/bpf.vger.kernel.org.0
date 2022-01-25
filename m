Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5476849ACA4
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 07:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359246AbiAYGri (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 01:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358494AbiAYGpi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 01:45:38 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA218C055ABC
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 21:05:49 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id r144so313751iod.9
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 21:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=waJ60h1GI1pWhlfwHGw+2AMmkC5dx5vzz+23ORPrMos=;
        b=MRLyzDgT5OZMZLj5NliPGXendXqjxT9Z7C/+4WM/z34/EgIOIyps8dE9s/crl1ot2o
         iR+RrcK6nSOlWtgibwW9pD9c88l35IpbJqEPj4o7AhAIzyBUrUduDdErcsREjn6h9iw1
         SMdXiZVuJVd7fTpQvR64AFpdbj6NZKyqX3LxxkQXtbEOMpZrIpHOcpvk55ov9zVLHSjg
         sof8PZa/iaxbc4JP7du69qgkZNUYwmlr8VZPZAa0Y3O4bt1kUvre72TdijloxWHdM2tg
         Wf08woXoNO2DC0bnp6VkQEq4js6zJ/UaHKuMbdSpTVsoy0Gl3TI8eeoZSPzy6Xj9lUI0
         P7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=waJ60h1GI1pWhlfwHGw+2AMmkC5dx5vzz+23ORPrMos=;
        b=BC896sylNPhA4y9PgffPifjpm93VFHyRxm/xMo5/HJOaHywSmwByufHNYwpg89I4XK
         FM5sYNjsMb8KUrUglws76BCphi6qDAJjJAwlJgRHXY1nnOG612Kzm0zNpYOQr3Qmhd7H
         95n0Tw/AHbo8VhqBcENemAH+nwYKLiZVySM1r6U5JN2Z3K4YkaKPlEE9SJRPtfNuNWO9
         eUqsIke9IHbEzOz9pSw1TJ/fcxSSC12vPLpYvENimTqs8lOO6jF7EUONyBl7pVaTb1So
         Q3mKkjqefNdsBEwNEPvnw62ZyuTUA+1B4hU2ear+eqMkLUYYfdn8LBIyDO/q2QpDNK9+
         aKAA==
X-Gm-Message-State: AOAM530xLCaJfkbqktmZFpIv4wAoAaJLwv+AQzKEpvmINjLFN1a9YwrV
        E62TSoUVczy0ZFhB0R/PCx+kK3ocXw0sn6Zqwgc=
X-Google-Smtp-Source: ABdhPJz0u1fNUe8YQKcZqb4Komv+tHGPH0GRJ4vegczJgp5PSJ4R1QCv1lcr/hgE9sJjYZIUhzlGjeTFH0LnPtcct9M=
X-Received: by 2002:a05:6638:1212:: with SMTP id n18mr5314400jas.93.1643087149133;
 Mon, 24 Jan 2022 21:05:49 -0800 (PST)
MIME-Version: 1.0
References: <20220124141622.4378-1-Kenta.Tada@sony.com> <20220124141622.4378-4-Kenta.Tada@sony.com>
In-Reply-To: <20220124141622.4378-4-Kenta.Tada@sony.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 21:05:38 -0800
Message-ID: <CAEf4BzZGARxqmCFmGhJduAu+Wsg2t0RVHLXrfX=KuHuhnhv+OA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] libbpf: Add a test to confirm PT_REGS_PARM4_SYSCALL
To:     Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
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

+cc Hengqi

On Mon, Jan 24, 2022 at 6:20 AM Kenta Tada <Kenta.Tada@sony.com> wrote:
>
> Add a selftest to verify the behavior of PT_REGS_xxx
> and the CORE variant.
>
> Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> ---
>  .../bpf/prog_tests/test_bpf_syscall_macro.c   | 63 ++++++++++++++++++
>  .../selftests/bpf/progs/bpf_syscall_macro.c   | 64 +++++++++++++++++++
>  2 files changed, 127 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
>  create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> new file mode 100644
> index 000000000000..cfeccd85f40e
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright 2022 Sony Group Corporation */
> +#include <vmlinux.h>
> +
> +#include <bpf/bpf_core_read.h>
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
> +int arg1_core = 0;
> +unsigned long arg2_core = 0;
> +unsigned long arg3_core = 0;
> +unsigned long arg4_core_cx = 0;
> +unsigned long arg4_core = 0;
> +unsigned long arg5_core = 0;
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
> +       /* test for PT_REGS_PARM */
> +       real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
> +       bpf_probe_read_kernel(&orig_arg1, sizeof(orig_arg1), &PT_REGS_PARM1_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg2, sizeof(orig_arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg3, sizeof(orig_arg3), &PT_REGS_PARM3_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg4_cx, sizeof(orig_arg4_cx), &PT_REGS_PARM4(real_regs));
> +       bpf_probe_read_kernel(&orig_arg4, sizeof(orig_arg4), &PT_REGS_PARM4_SYSCALL(real_regs));
> +       bpf_probe_read_kernel(&orig_arg5, sizeof(orig_arg5), &PT_REGS_PARM5_SYSCALL(real_regs));
> +       /* copy all actual args and the wrong arg4 on x86_64 */
> +       arg1 = orig_arg1;
> +       arg2 = orig_arg2;
> +       arg3 = orig_arg3;
> +       arg4_cx = orig_arg4_cx;
> +       arg4 = orig_arg4;
> +       arg5 = orig_arg5;

I don't get why you needed orig_argX variables and then copying them
into argX variables. I changed this to read directly into argX. I
suspect arg1 handling might break on big-endian arches due to int vs
long differences, please check that and send a follow up fix.

Also keep in mind that selftest changes should come with
"selftests/bpf:" subject prefix, not "libbpf:". Fixed that up as well.

Applied to bpf-next, thanks.

Hopefully Hengqi will build his SYSCALL prog wrapper macros on top of
this as a follow up as well.

> +
> +       /* test for the CORE variant of PT_REGS_PARM */
> +       arg1_core = PT_REGS_PARM1_CORE_SYSCALL(real_regs);
> +       arg2_core = PT_REGS_PARM2_CORE_SYSCALL(real_regs);
> +       arg3_core = PT_REGS_PARM3_CORE_SYSCALL(real_regs);
> +       arg4_core_cx = PT_REGS_PARM4_CORE(real_regs);
> +       arg4_core = PT_REGS_PARM4_CORE_SYSCALL(real_regs);
> +       arg5_core = PT_REGS_PARM5_CORE_SYSCALL(real_regs);
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.32.0
>
