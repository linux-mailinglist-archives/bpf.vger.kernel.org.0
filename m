Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9741A6ED
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 07:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhI1FNV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 01:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhI1FNU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 01:13:20 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C37C061575
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 22:11:41 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v10so29088056ybq.7
        for <bpf@vger.kernel.org>; Mon, 27 Sep 2021 22:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DfwUcUMEB3wwW6PlHfZKAvxGPGJwf1W3s8n1lbRG0cM=;
        b=KTrez8W/dW/OVwzvYnZdtX+GA6HkEpwk2kYeBEh4hjUfKTsIFSk5ZLciz7aZMGdq1R
         i2ivDw027KYYW2P00qKpXcEvyVE/z8dyD4hCcz13Y6QiukKAVfhY1mw25AnGg65z4Sqa
         on45lBm/Mo8E0fqbOne2JnIu7UMkb6gxZ/F/aSUsXWjES/IW3ObcmQF4DTq4Y05JbzBv
         IveLLBG8O5H+teVk3j0VsLi0ryLYl66fA6F3FXPFFi6jh/dYwInjAo7E3a764GD37ijW
         0xqchLDVCqmXyr7pUPCT2y0O7mmvmq8FhNNwcj4DeQzOpbV9cK0+DeY2x+Rgnj7kCGR6
         Ke3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DfwUcUMEB3wwW6PlHfZKAvxGPGJwf1W3s8n1lbRG0cM=;
        b=GFLIQH2enrPt0jzk5NQBKE6TR4Tnul3nwWZF9pJmyvn4QB+/R+ApzfJQuHbRYXcy8D
         iJ+gH+44U5h4wIk7fR/n6q9D8NBW5ymiHZmUvApZmlb/e8/E3B/mGQXe7LlUR5c+K4Hh
         jcFWzMx1PDF838GrfmkNCeykLa2e7/Vza+BKICjFe/GNwY7gzahssphbVlSGSkWVIzMl
         Tt6yCCLdOTLCG+51blEJTC00DMViVrB6bdTo9gg9qTEBhic0/goV7c9UcDgLySS4HWUn
         /uCVsvRQDMbRcf8AHaCCiGja45VKxsX7mVNR5kbFtlbe0qcy34ptAzP41xxSfJoc6Tjq
         pD/A==
X-Gm-Message-State: AOAM532abvXsjuCfnhyUDFxn8ea3lDYM/2qAoAhkOpf6y/Zb68joeuPG
        6vbKawE3iFia5KCw4jG4tUp7RyAXlx8hkliLfYQEeZI5wTQ=
X-Google-Smtp-Source: ABdhPJxjomcb1jvCTlHQS9AT7HsRhujK8mSCgCuF+nmlXSPt8efcPnkgYTH51K0DQoUjjbXGrlrOcv6mF3H4qWHDdiI=
X-Received: by 2002:a25:1dc4:: with SMTP id d187mr2602721ybd.455.1632805900864;
 Mon, 27 Sep 2021 22:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210927170519.806505-1-yhs@fb.com>
In-Reply-To: <20210927170519.806505-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Sep 2021 22:11:30 -0700
Message-ID: <CAEf4BzZG+qGoLdgtUTx208AP6MM4qMsBZE1Ua_in1ycA__QJEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix probe_user test failure with
 clang build kernel
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 27, 2021 at 10:05 AM Yonghong Song <yhs@fb.com> wrote:
>
> clang build kernel failed the selftest probe_user.
>   $ ./test_progs -t probe_user
>   $ ...
>   $ test_probe_user:PASS:get_kprobe_res 0 nsec
>   $ test_probe_user:FAIL:check_kprobe_res wrong kprobe res from probe read: 0.0.0.0:0
>   $ #94 probe_user:FAIL
>
> The test attached to kernel function __sys_connect(). In net/socket.c, we have
>   int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
>   {
>         ......
>   }
>   ...
>   SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
>                   int, addrlen)
>   {
>         return __sys_connect(fd, uservaddr, addrlen);
>   }
>
> The gcc compiler (8.5.0) does not inline __sys_connect() in syscall entry
> function. But latest clang trunk did the inlining. So the bpf program
> is not triggered.
>
> To make the test more reliable, let us kprobe the syscall entry function
> instead. But x86_64, arm64 and s390 has syscall wrapper and they have
> to be handled specially. I also changed the test to use vmlinux.h and CORE
> to accommodate relocatable pt_regs structure, similar to
> samples/bpf/test_probe_write_user_kern.c.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  .../selftests/bpf/prog_tests/probe_user.c     |  4 +--
>  .../selftests/bpf/progs/test_probe_user.c     | 30 +++++++++++++++----
>  2 files changed, 26 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> index 95bd12097358..52fe157e2a90 100644
> --- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
> +++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> @@ -3,7 +3,7 @@
>
>  void test_probe_user(void)
>  {
> -       const char *prog_name = "kprobe/__sys_connect";
> +       const char *prog_name = "handle_sys_connect";
>         const char *obj_file = "./test_probe_user.o";
>         DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
>         int err, results_map_fd, sock_fd, duration = 0;
> @@ -18,7 +18,7 @@ void test_probe_user(void)
>         if (!ASSERT_OK_PTR(obj, "obj_open_file"))
>                 return;
>
> -       kprobe_prog = bpf_object__find_program_by_title(obj, prog_name);
> +       kprobe_prog = bpf_object__find_program_by_name(obj, prog_name);
>         if (CHECK(!kprobe_prog, "find_probe",
>                   "prog '%s' not found\n", prog_name))
>                 goto cleanup;
> diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
> index 89b3532ccc75..9b3ddbf6289d 100644
> --- a/tools/testing/selftests/bpf/progs/test_probe_user.c
> +++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
> @@ -1,21 +1,39 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -#include <linux/ptrace.h>
> -#include <linux/bpf.h>
> -
> -#include <netinet/in.h>
> +#include "vmlinux.h"
>
>  #include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
>  #include <bpf/bpf_tracing.h>
>
> +#if defined(__TARGET_ARCH_x86)

I mangled this check (locally) to test the #else case, and it failed
compilation:

progs/test_probe_user.c:24:15: error: expected ')'
SEC("kprobe/" SYS_PREFIX "sys_connect")

adding #define SYS_PREFIX "" fixes the issue.

But I'm also curious:

1. do we need all this arch-specific logic? maybe we can find some
other and more stable interface to attach to? e.g., would
move_addr_to_kernel() work? it's a global function, so it shouldn't be
inlined, right? Or did you intend to also demo the use of
PT_REGS_PARM1_CORE() with this?

2. global .rodata variable isn't really necessary. Static one would
work just fine and would be eliminated by the compiler at compilation
time. Or equivalently just doing #define SYS_WRAPPER 1 for all cases
but #else would work as well. I don't mind global var, but I'm just
curious if you explicitly wanted to test .rodata global variable in
this case?


> +volatile const int syscall_wrapper = 1;
> +#define SYS_PREFIX "__x64_"
> +#elif defined(__TARGET_ARCH_s390)
> +volatile const int syscall_wrapper = 1;
> +#define SYS_PREFIX "__s390x_"
> +#elif defined(__TARGET_ARCH_arm64)
> +volatile const int syscall_wrapper = 1;
> +#define SYS_PREFIX "__arm64_"
> +#else
> +volatile const int syscall_wrapper = 0;
> +#endif
> +
>  static struct sockaddr_in old;
>
> -SEC("kprobe/__sys_connect")
> +SEC("kprobe/" SYS_PREFIX "sys_connect")
>  int BPF_KPROBE(handle_sys_connect)
>  {
> -       void *ptr = (void *)PT_REGS_PARM2(ctx);
> +       void *ptr;
>         struct sockaddr_in new;
>
> +       if (syscall_wrapper == 0) {
> +               ptr = (void *)PT_REGS_PARM2_CORE(ctx);
> +       } else {
> +               struct pt_regs *real_regs = (struct pt_regs *)PT_REGS_PARM1_CORE(ctx);
> +               ptr = (void *)PT_REGS_PARM2_CORE(real_regs);
> +       }
> +
>         bpf_probe_read_user(&old, sizeof(old), ptr);
>         __builtin_memset(&new, 0xab, sizeof(new));
>         bpf_probe_write_user(ptr, &new, sizeof(new));
> --
> 2.30.2
>
