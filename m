Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEF74A6514
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 20:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiBAThA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 14:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiBATg7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 14:36:59 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F93C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 11:36:59 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id s18so22537312ioa.12
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 11:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CmWZSkV1tjQtjrsqgYDnPzudwQGnysCTX2OAzfb6Qjs=;
        b=jvLdWCg2fUswaxX1A10YuLD1jDp9CSnjO9OuTLoKnJJbPtuaSuOV+Qe0qGVkRjl89q
         V1QGP1ldq9CDWB+IsvFnpsJMFtvw8MCJ7dQWlWuCo7zXgdD5iCISxJJCkR4d0Aqo8QKS
         nzSmrpKxNdyl6dJHA1lU+9QT8vch8aiAUvB5XnD/JRWKENFSfKBCeF99EvyfyaG1Uqnj
         yM0P/19VOlhdFd6EFqiDCxN116uqN5t+/mLm2KPvEuy3/1AJ1r5pn321OWKtzB3WjD8s
         3Q8SgrxiEQzY7FFFcvIaRqwCfxw0NabSXhN9Wz49IPuLxOFX5mEW4GlqyZQs+tyVkz7o
         gvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CmWZSkV1tjQtjrsqgYDnPzudwQGnysCTX2OAzfb6Qjs=;
        b=fa1l1vHNYT9RRgPlrRiE7GUOUPjRi04RJ1ZyL475edsI/L6sDFSmm5glKsVyhXbubZ
         oweRFqP3RgfqT6MZgmbY/qZ7teQlMYYtcG/bKKWgEhlHAEdV+xn8lAAU+uTZGlZIvNHE
         YtAvEX3Hl1rkr5tSE1zjfiSffZhSbpvdT9P4sqX4PSN/xqZ6Uf3Dco5ooKWVxYDUPqha
         6kyeKP73oSdfKsAnf+BHKP9hX5yy9BZuqvUDPG/U/RkZTOj30BYivPqxx6dLRkPwbQYR
         eJHTGcVCLPShU82wZh+w965DhPaHBBBir0wGN70lzqviGqgnKFzlGsmylBymrd1n5f6G
         fxHA==
X-Gm-Message-State: AOAM533FNmFiW0ESt4eUAvoftUT5zLU/evDCenaRYfYFaJ8AKK0Rwxfc
        Ku+gouWvquliQFHHf1UWn99pXvELf++hdbWZo7E=
X-Google-Smtp-Source: ABdhPJyFDhUIfsYTC/6cMbFxGWXo/1IOqEN83Abocb00rQXkoIa7rLWNvlKukJCNDgGaJ4iQkrRWekiBDMoCchDLACE=
X-Received: by 2002:a5e:8406:: with SMTP id h6mr14762433ioj.144.1643744219098;
 Tue, 01 Feb 2022 11:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20220124141622.4378-1-Kenta.Tada@sony.com> <20220124141622.4378-4-Kenta.Tada@sony.com>
 <CAEf4BzZGARxqmCFmGhJduAu+Wsg2t0RVHLXrfX=KuHuhnhv+OA@mail.gmail.com>
In-Reply-To: <CAEf4BzZGARxqmCFmGhJduAu+Wsg2t0RVHLXrfX=KuHuhnhv+OA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Feb 2022 11:36:48 -0800
Message-ID: <CAEf4BzaNjGLAzBWXybmbDHaAa4Sse=aVcn1vWV4GXvUYDXF8hw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] libbpf: Add a test to confirm PT_REGS_PARM4_SYSCALL
To:     Kenta Tada <Kenta.Tada@sony.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
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

+cc Ilya


On Mon, Jan 24, 2022 at 9:05 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> +cc Hengqi
>
> On Mon, Jan 24, 2022 at 6:20 AM Kenta Tada <Kenta.Tada@sony.com> wrote:
> >
> > Add a selftest to verify the behavior of PT_REGS_xxx
> > and the CORE variant.
> >
> > Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
> > ---
> >  .../bpf/prog_tests/test_bpf_syscall_macro.c   | 63 ++++++++++++++++++
> >  .../selftests/bpf/progs/bpf_syscall_macro.c   | 64 +++++++++++++++++++
> >  2 files changed, 127 insertions(+)
> >  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> >  create mode 100644 tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> >
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > new file mode 100644
> > index 000000000000..cfeccd85f40e
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright 2022 Sony Group Corporation */
> > +#include <vmlinux.h>
> > +
> > +#include <bpf/bpf_core_read.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> > +#include "bpf_misc.h"
> > +
> > +int arg1 = 0;
> > +unsigned long arg2 = 0;
> > +unsigned long arg3 = 0;
> > +unsigned long arg4_cx = 0;
> > +unsigned long arg4 = 0;
> > +unsigned long arg5 = 0;
> > +
> > +int arg1_core = 0;
> > +unsigned long arg2_core = 0;
> > +unsigned long arg3_core = 0;
> > +unsigned long arg4_core_cx = 0;
> > +unsigned long arg4_core = 0;
> > +unsigned long arg5_core = 0;
> > +
> > +const volatile pid_t filter_pid = 0;
> > +
> > +SEC("kprobe/" SYS_PREFIX "sys_prctl")
> > +int BPF_KPROBE(handle_sys_prctl)
> > +{
> > +       struct pt_regs *real_regs;
> > +       int orig_arg1;
> > +       unsigned long orig_arg2, orig_arg3, orig_arg4_cx, orig_arg4, orig_arg5;
> > +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
> > +
> > +       if (pid != filter_pid)
> > +               return 0;
> > +
> > +       /* test for PT_REGS_PARM */
> > +       real_regs = (struct pt_regs *)PT_REGS_PARM1(ctx);
> > +       bpf_probe_read_kernel(&orig_arg1, sizeof(orig_arg1), &PT_REGS_PARM1_SYSCALL(real_regs));
> > +       bpf_probe_read_kernel(&orig_arg2, sizeof(orig_arg2), &PT_REGS_PARM2_SYSCALL(real_regs));
> > +       bpf_probe_read_kernel(&orig_arg3, sizeof(orig_arg3), &PT_REGS_PARM3_SYSCALL(real_regs));
> > +       bpf_probe_read_kernel(&orig_arg4_cx, sizeof(orig_arg4_cx), &PT_REGS_PARM4(real_regs));
> > +       bpf_probe_read_kernel(&orig_arg4, sizeof(orig_arg4), &PT_REGS_PARM4_SYSCALL(real_regs));
> > +       bpf_probe_read_kernel(&orig_arg5, sizeof(orig_arg5), &PT_REGS_PARM5_SYSCALL(real_regs));
> > +       /* copy all actual args and the wrong arg4 on x86_64 */
> > +       arg1 = orig_arg1;
> > +       arg2 = orig_arg2;
> > +       arg3 = orig_arg3;
> > +       arg4_cx = orig_arg4_cx;
> > +       arg4 = orig_arg4;
> > +       arg5 = orig_arg5;
>
> I don't get why you needed orig_argX variables and then copying them
> into argX variables. I changed this to read directly into argX. I
> suspect arg1 handling might break on big-endian arches due to int vs
> long differences, please check that and send a follow up fix.
>
> Also keep in mind that selftest changes should come with
> "selftests/bpf:" subject prefix, not "libbpf:". Fixed that up as well.
>
> Applied to bpf-next, thanks.

This selftest is failing on s390x (see [0]). Ilya, do you know if
something special needs to be done for s390x for this case?

Here are the two failures:

test_bpf_syscall_macro:FAIL:syscall_arg1 unexpected syscall_arg1:
actual -1 != expected 1001
test_bpf_syscall_macro:FAIL:syscall_arg1_core_variant unexpected
syscall_arg1_core_variant: actual -38 != expected 1001

  [0] https://github.com/libbpf/libbpf/runs/5025905587?check_suite_focus=true

>
> Hopefully Hengqi will build his SYSCALL prog wrapper macros on top of
> this as a follow up as well.
>
> > +
> > +       /* test for the CORE variant of PT_REGS_PARM */
> > +       arg1_core = PT_REGS_PARM1_CORE_SYSCALL(real_regs);
> > +       arg2_core = PT_REGS_PARM2_CORE_SYSCALL(real_regs);
> > +       arg3_core = PT_REGS_PARM3_CORE_SYSCALL(real_regs);
> > +       arg4_core_cx = PT_REGS_PARM4_CORE(real_regs);
> > +       arg4_core = PT_REGS_PARM4_CORE_SYSCALL(real_regs);
> > +       arg5_core = PT_REGS_PARM5_CORE_SYSCALL(real_regs);
> > +
> > +       return 0;
> > +}
> > +
> > +char _license[] SEC("license") = "GPL";
> > --
> > 2.32.0
> >
