Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AD447CA71
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 01:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhLVAhP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 19:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbhLVAhP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Dec 2021 19:37:15 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5BAC061574
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 16:37:14 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q5so742443ioj.7
        for <bpf@vger.kernel.org>; Tue, 21 Dec 2021 16:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HgnwF0UodCmTO2Oi7QC00JjdOKO6Cpn7my6He+TCmk=;
        b=iw9gyaf96EAOY+jr09lm4YQid0uWNsHxk2pgAec34K5ZiltMfVQZT/FFXHWUN+PdUU
         QcsGJngoZMMVirGIwD6/RBOZxVymzm58E/XqEyTVnwwnSOZN7p5vAUMJ/+8Sq9CzqpO7
         Ib5VCOJYwAaCfJ1AwasPwIeKyni4Ysqq+ClrZfKNKc97eKb7hlNdz6gBmRh6JQmVHZCy
         HK15CGhTCRRAMsA3veD6p67aTI9V1yPh2v6xjuP3AZBqS5hwb9vxeAFtKPNIuga62TsV
         kEwgI9VN2qV9YL8ISyoK8VwCLLBMyAREoIDSHIlgajrzEzZDSXJPeb9hlC2IUbkakrhZ
         huOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HgnwF0UodCmTO2Oi7QC00JjdOKO6Cpn7my6He+TCmk=;
        b=yz/CZbj5QcqYQVeG0u/Yw1B2dn44z/KsbGw3Jl7aZLxwobxOY0F4FdZMF9kvgRLJ9Z
         QV5SMhKH4fOxYRaYDk4/OYxHExufWWOzr1JPwGfFCVZsLyG5zMw4dSIk805ZbJv1gY5L
         quoD2ZKVg8i1jWJu7jLr0FvgQ9Lm0wnW/fb86OjoFkuAVTvX33QTA+hphYP0zgJvMuO2
         6kLGt7BzraQQrUXN3J/qC8aaqGjkC2fw7T7/YYQFyE450aCiEL8n2jvrHJpmFuHBus/x
         JBSJe2o38x0D/Sp0RrwddIFnE8u4IgXJpnGsQpu1STeQELyURpNdwAW4wOlFjbbJoko2
         KyLA==
X-Gm-Message-State: AOAM532KRrMqJM8bWF8kAkjjYgXqbZC6qK46yZzEcUKB9hHZ/J1Bxu7A
        55hyZVbD9DoUrPwk4x06X7sWfPcLqGi8ITMvH8s=
X-Google-Smtp-Source: ABdhPJyIrpoDdW2SaqNIiTM7q6q8Ye2XP5eWdJb8Pbs9A+IxPahWDxJS7U3eiArKRYOJIUqDDJeBKz5/r24DQd1811Y=
X-Received: by 2002:a05:6638:1193:: with SMTP id f19mr314731jas.237.1640133434263;
 Tue, 21 Dec 2021 16:37:14 -0800 (PST)
MIME-Version: 1.0
References: <20211221055312.3371414-1-hengqi.chen@gmail.com> <20211221055312.3371414-3-hengqi.chen@gmail.com>
In-Reply-To: <20211221055312.3371414-3-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Dec 2021 16:37:03 -0800
Message-ID: <CAEf4BzZ+UHAoAVwgjafAcfZa=c7cSLiLUY8OvpfKk9N4gO7zYQ@mail.gmail.com>
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
> +
> +       ASSERT_GT(fd, 0, "socket failed");
> +       ASSERT_EQ(skel->bss->domain, AF_UNIX, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->type, SOCK_STREAM, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->protocol, 0, "BPF_KPROBE_SYSCALL failed");
> +       ASSERT_EQ(skel->bss->fd, fd, "BPF_KRETPROBE_SYSCALL failed");
> +
> +cleanup:
> +       if (fd)
> +               close(fd);
> +       test_kprobe_syscall__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
> new file mode 100644
> index 000000000000..ecef9d19007c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_kprobe_syscall.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2021 Hengqi Chen */
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_core_read.h>
> +
> +const volatile pid_t my_pid = 0;
> +int domain = 0;
> +int type = 0;
> +int protocol = 0;
> +int fd = 0;
> +
> +SEC("kprobe/__x64_sys_socket")
> +int BPF_KPROBE_SYSCALL(socket_enter, int d, int t, int p)
> +{
> +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +
> +       if (pid != my_pid)
> +               return 0;
> +
> +       domain = d;
> +       type = t;
> +       protocol = p;
> +       return 0;
> +}
> +
> +SEC("kretprobe/__x64_sys_socket")

oh, please also use SYS_PREFIX instead of hard-coding __x64. This is
very x86-64-specific and we have other architectures tested by
selftests, so this makes it automatically fail on non-x86_64.

If you get a chance, try also cleaning up other __x64_ uses in the
selftests as a separate patch. Thank you!

> +int BPF_KRETPROBE_SYSCALL(socket_exit, int ret)
> +{
> +       pid_t pid = bpf_get_current_pid_tgid() >> 32;
> +
> +       if (pid != my_pid)
> +               return 0;
> +
> +       fd = ret;
> +       return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> --
> 2.30.2
