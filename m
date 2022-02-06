Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DC34AB1C7
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 20:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbiBFTln (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 14:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiBFTlm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 14:41:42 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A20C06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 11:41:42 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c188so14304729iof.6
        for <bpf@vger.kernel.org>; Sun, 06 Feb 2022 11:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7gZzXDtYp/dYjS2TgroABKLshbNB0zr6qSOaTHDsQM=;
        b=VchgyJXbQdS6nL/04DdUDXtRldDFfk24y0GzSf7wz1ZuSszOb9IjCS6F1IZuGYA7jE
         MaJt7plT0Rqg/OQeRcwLeCM77UdcSw7ggB422PLP1bEH+NBLfNJwdIy3TVhd0wDR+3M4
         EFlnUXpJV/hv6RjZDX0ueYG1oxSsfPHPzLOtNI7nRDDZe07mLXXsGQt1zQj483x4SVr1
         2HBTjxuxH3hnSL5VRvoe3N006axcvb8U101kyYz4HqLheVvOnPgzwUEu3YRbFs6t3yYY
         cIDky77e6zbJ+gGMUJ/9+56FiVHHieIoTAJVRTUP+gNUo8z+fX7wE9KWVAra3M8dddm9
         944A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7gZzXDtYp/dYjS2TgroABKLshbNB0zr6qSOaTHDsQM=;
        b=J8prOHYlHXOABBfAcbLio0/1WmQLsXOFMh1/NICFPkz2vARLca+r8FWTxrV30WHf4K
         tVhTe+A/zZyaOjRLqnHHeiuQZcE9k/j4dlzYw/ghvt/4PZTuvaUV93dyld3lj6htZOeC
         jRxTHFPzHF741MiivnOG8VNHT+Ex+PCzZ+NW1Ia18fRLw/kIN18lcSqdqf9I3jdjSxAT
         SUKE4LgGZZENkfTJ6YdyMvDynG+C4gZA0xM52sv8DxaIvkXDyZoIZKO6NBMHSCS/7FEZ
         7Khe42CFfN8why0YwnIjV06D/3PKWYnM8Re0OoFDD/Ryl5vIcrq7ztyULIcSD0UA15Wa
         l48g==
X-Gm-Message-State: AOAM531rhkBHF38yUxZy9GEbgFGWAMTSqAIj+DtqTOf2BY9ioOwFFpQS
        WHSyFAeEyIzSlrWlv9KgqImmcdb8FRDWo2+wwoA=
X-Google-Smtp-Source: ABdhPJzB9RSug5LbyLWAUWgMxVGgterh9XFL1RamT87iT6sAhjS0caYWHeINDXK0SZVQIBM8LKypgHb9yHG/sSKG+uY=
X-Received: by 2002:a05:6638:d88:: with SMTP id l8mr4399324jaj.234.1644176501422;
 Sun, 06 Feb 2022 11:41:41 -0800 (PST)
MIME-Version: 1.0
References: <20220206134051.721574-1-hengqi.chen@gmail.com> <20220206134051.721574-3-hengqi.chen@gmail.com>
In-Reply-To: <20220206134051.721574-3-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 6 Feb 2022 11:41:30 -0800
Message-ID: <CAEf4Bzar7adrCPNBo69QUuhM0ge0GJJ+92bNiN0BmckS3LO5bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: Test BPF_KPROBE_SYSCALL macro
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
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

On Sun, Feb 6, 2022 at 5:41 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> Add tests for the newly added BPF_KPROBE_SYSCALL macro.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/kprobe_syscall.c | 37 +++++++++++++++++++
>  .../selftests/bpf/progs/test_kprobe_syscall.c | 34 +++++++++++++++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
> new file mode 100644
> index 000000000000..0ac89c987024
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kprobe_syscall.c
> @@ -0,0 +1,37 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Hengqi Chen */
> +
> +#include <test_progs.h>
> +#include <sys/prctl.h>
> +#include "test_kprobe_syscall.skel.h"
> +
> +void test_kprobe_syscall(void)
> +{
> +       struct test_kprobe_syscall *skel;
> +       int err;
> +
> +       skel = test_kprobe_syscall__open();
> +       if (!ASSERT_OK_PTR(skel, "test_kprobe_syscall__open"))
> +               return;
> +
> +       skel->rodata->my_pid = getpid();
> +
> +       err = test_kprobe_syscall__load(skel);
> +       if (!ASSERT_OK(err, "test_kprobe_syscall__load"))
> +               goto cleanup;
> +
> +       err = test_kprobe_syscall__attach(skel);
> +       if (!ASSERT_OK(err, "test_kprobe_syscall__attach"))
> +               goto cleanup;
> +
> +       prctl(1, 2, 3, 4, 5);
> +
> +       ASSERT_EQ(skel->bss->option, 1, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->arg2, 2, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->arg3, 3, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->arg4, 4, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->arg5, 5, "BPF_KPROBE_SYSCALL failed");
> +
> +cleanup:
> +       test_kprobe_syscall__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
> new file mode 100644
> index 000000000000..abd59c3d5b59
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2022 Hengqi Chen */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_misc.h"
> +
> +const volatile pid_t my_pid = 0;
> +int option = 0;
> +unsigned long arg2 = 0;
> +unsigned long arg3 = 0;
> +unsigned long arg4 = 0;
> +unsigned long arg5 = 0;
> +
> +SEC("kprobe/" SYS_PREFIX "sys_prctl")
> +int BPF_KPROBE_SYSCALL(prctl_enter, int opt, unsigned long a2,
> +                      unsigned long a3, unsigned long a4, unsigned long a5)
> +{
> +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +
> +       if (pid != my_pid)
> +               return 0;
> +
> +       option = opt;
> +       arg2 = a2;
> +       arg3 = a3;
> +       arg4 = a4;
> +       arg5 = a5;
> +       return 0;
> +}
> +

Let's add all this into progs/bpf_syscall_macro.c and
prog_tests/test_bpf_syscall_macro.c, instead of adding a new selftest.
They are closely related anyways.

> +char _license[] SEC("license") = "GPL";
> --
> 2.30.2
