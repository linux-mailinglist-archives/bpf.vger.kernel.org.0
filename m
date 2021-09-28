Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CAC41BA8A
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 00:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbhI1Wr6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 18:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhI1Wr5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Sep 2021 18:47:57 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5252EC06161C
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 15:46:17 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id f133so1005686yba.11
        for <bpf@vger.kernel.org>; Tue, 28 Sep 2021 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uZFqcdNiZCiJSjgkz+nLo3Y2EPBNFKbUiQHg3MtGkSE=;
        b=OwcbwGQO1xEv+/v2fjvAbJP1kKJCtLht/c9UGF4c+YDgQy8MslmTjBW98HlYAoGK9J
         VWV3VbJDkhfxHGwbmzRiDDy6eK2YSVQedGhnFMGAHeOFrqmmWdOBQwmr+UquIS+zkPyV
         w4By7c9BZPWiw/QqfIBqoV7Pa6izw3pQQQpqbC9uEsiYi/fZwwiVB+cdIk9wAQe8xfI4
         nnQnK5pyCaQawKQbl4rlx1fhKP/Bmk5PZaSbq5wm2whBIvOb2TbLiZz5TfB5czD3kzMs
         dD8tfNltrJ/ITvdEUx2LITGAmIAHbab4q89vO4j2uqQ3ObAEJ7y4WRxJQyoPOgb0Rtb9
         ZZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uZFqcdNiZCiJSjgkz+nLo3Y2EPBNFKbUiQHg3MtGkSE=;
        b=ngExG80+UUkO2ufVgnWMgBlFA8+67CqN031iOcGa77y3dQjU1Wk4MDNJhV/+pyzmyR
         Vsh5HoeR1aM/cGUBgsvSErp7m7J33+tIA6k6RRSSw1I+FGeJYIR30DYkoZ3w6cjl2lJe
         PKRoEK8ypj0V+rBPggmGAREEvu59s5Lmur2AuwwTHMva/K7sKQYp5T3rDN8v1TLxXfiF
         AD2xq6lspuA0DvUK5bNFeKe9CoetQNai1eleCJ8yU1WUE2RAzlPLw9vvDj1/w5ui0USV
         m8Xf5RaMbD5JKRXrITxcGSMnNEgJvg+db2kTe9o/oo7W1t6XXja5sBSsbhoOKx6Lw/ou
         qo2w==
X-Gm-Message-State: AOAM531kTkaVlB/RFKaupuu8OXfC8gR23WXXBiSfSLs3XCR3O/VRahbQ
        VSF/Zfz2ooI9vr99lH1SRKH6kektBpY628gqOV+XaaF9
X-Google-Smtp-Source: ABdhPJyyYOAq/yJR6bgqQHZG5ESUBsYUO1+EY4C7YqArfj0hnFtLMVgBiouRkpq4a4+hNLoMfykm5K21Dp8c5u0xiOU=
X-Received: by 2002:a25:1dc4:: with SMTP id d187mr7815905ybd.455.1632869176424;
 Tue, 28 Sep 2021 15:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210927170519.806505-1-yhs@fb.com> <CAEf4BzZG+qGoLdgtUTx208AP6MM4qMsBZE1Ua_in1ycA__QJEg@mail.gmail.com>
 <c9d610e7-eb5b-ba8e-2b2d-6c37eea57ef7@fb.com>
In-Reply-To: <c9d610e7-eb5b-ba8e-2b2d-6c37eea57ef7@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Sep 2021 15:46:05 -0700
Message-ID: <CAEf4BzY004LfARDVMHUmNh97CjTTVWSvtBSLwpESo+qEBkbNaA@mail.gmail.com>
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

On Tue, Sep 28, 2021 at 8:46 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 9/27/21 10:11 PM, Andrii Nakryiko wrote:
> > On Mon, Sep 27, 2021 at 10:05 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> clang build kernel failed the selftest probe_user.
> >>    $ ./test_progs -t probe_user
> >>    $ ...
> >>    $ test_probe_user:PASS:get_kprobe_res 0 nsec
> >>    $ test_probe_user:FAIL:check_kprobe_res wrong kprobe res from probe read: 0.0.0.0:0
> >>    $ #94 probe_user:FAIL
> >>
> >> The test attached to kernel function __sys_connect(). In net/socket.c, we have
> >>    int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
> >>    {
> >>          ......
> >>    }
> >>    ...
> >>    SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
> >>                    int, addrlen)
> >>    {
> >>          return __sys_connect(fd, uservaddr, addrlen);
> >>    }
> >>
> >> The gcc compiler (8.5.0) does not inline __sys_connect() in syscall entry
> >> function. But latest clang trunk did the inlining. So the bpf program
> >> is not triggered.
> >>
> >> To make the test more reliable, let us kprobe the syscall entry function
> >> instead. But x86_64, arm64 and s390 has syscall wrapper and they have
> >> to be handled specially. I also changed the test to use vmlinux.h and CORE
> >> to accommodate relocatable pt_regs structure, similar to
> >> samples/bpf/test_probe_write_user_kern.c.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   .../selftests/bpf/prog_tests/probe_user.c     |  4 +--
> >>   .../selftests/bpf/progs/test_probe_user.c     | 30 +++++++++++++++----
> >>   2 files changed, 26 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> >> index 95bd12097358..52fe157e2a90 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
> >> @@ -3,7 +3,7 @@
> >>
> >>   void test_probe_user(void)
> >>   {
> >> -       const char *prog_name = "kprobe/__sys_connect";
> >> +       const char *prog_name = "handle_sys_connect";
> >>          const char *obj_file = "./test_probe_user.o";
> >>          DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
> >>          int err, results_map_fd, sock_fd, duration = 0;
> >> @@ -18,7 +18,7 @@ void test_probe_user(void)
> >>          if (!ASSERT_OK_PTR(obj, "obj_open_file"))
> >>                  return;
> >>
> >> -       kprobe_prog = bpf_object__find_program_by_title(obj, prog_name);
> >> +       kprobe_prog = bpf_object__find_program_by_name(obj, prog_name);
> >>          if (CHECK(!kprobe_prog, "find_probe",
> >>                    "prog '%s' not found\n", prog_name))
> >>                  goto cleanup;
> >> diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
> >> index 89b3532ccc75..9b3ddbf6289d 100644
> >> --- a/tools/testing/selftests/bpf/progs/test_probe_user.c
> >> +++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
> >> @@ -1,21 +1,39 @@
> >>   // SPDX-License-Identifier: GPL-2.0
> >>
> >> -#include <linux/ptrace.h>
> >> -#include <linux/bpf.h>
> >> -
> >> -#include <netinet/in.h>
> >> +#include "vmlinux.h"
> >>
> >>   #include <bpf/bpf_helpers.h>
> >> +#include <bpf/bpf_core_read.h>
> >>   #include <bpf/bpf_tracing.h>
> >>
> >> +#if defined(__TARGET_ARCH_x86)
> >
> > I mangled this check (locally) to test the #else case, and it failed
> > compilation:
> >
> > progs/test_probe_user.c:24:15: error: expected ')'
> > SEC("kprobe/" SYS_PREFIX "sys_connect")
> >
> > adding #define SYS_PREFIX "" fixes the issue.
> >
> > But I'm also curious:
> >
> > 1. do we need all this arch-specific logic? maybe we can find some
> > other and more stable interface to attach to? e.g., would
> > move_addr_to_kernel() work? it's a global function, so it shouldn't be
> > inlined, right? Or did you intend to also demo the use of
> > PT_REGS_PARM1_CORE() with this?
>
> The following are move_add_to_kernel() call usages:
>
> fs/io_uring.c:  return move_addr_to_kernel(conn->addr, conn->addr_len,
> &io->address);
> fs/io_uring.c:          ret = move_addr_to_kernel(req->connect.addr,
> include/linux/socket.h:extern int move_addr_to_kernel(void __user
> *uaddr, int ulen, struct sockaddr_storage *kaddr);
> net/compat.c:                   err =
> move_addr_to_kernel(compat_ptr(msg.msg_name),
> net/socket.c: * move_addr_to_kernel     -       copy a socket address
> into kernel space
> net/socket.c:int move_addr_to_kernel(void __user *uaddr, int ulen,
> struct sockaddr_storage *kaddr)
> net/socket.c:           err = move_addr_to_kernel(umyaddr, addrlen,
> &address);
> net/socket.c:           ret = move_addr_to_kernel(uservaddr, addrlen,
> &address);
> net/socket.c:           err = move_addr_to_kernel(addr, addr_len, &address);
> net/socket.c:                   err = move_addr_to_kernel(msg.msg_name,
>
> inlining could happen within net/socket.c. Another two use cases are
> fs/io_uring.c and net/compat.c. Using compat syscall may be too complex,
> I assume. Using io_uring with bpf selftest may be a choice but I think
> it makes thing too complicated.

io_uring for this would be overkill

>
> More importantly, assuming in the future the kernel may be compiled
> with LTO, move_addr_to_kernel() might be inlined into fs/io_uring.c.
> So that is the main reason I am using syscall entry point directly.

Yep, makes sense.

>
> You are right, vmlinux.h is generated from the very kernel we are
> testing so we don't need CORE. I added CORE similar to
> samples/bpf/test_probe_write_user_kern.c, but it is not really
> needed here.
>
> >
> > 2. global .rodata variable isn't really necessary. Static one would
> > work just fine and would be eliminated by the compiler at compilation
> > time. Or equivalently just doing #define SYS_WRAPPER 1 for all cases
> > but #else would work as well. I don't mind global var, but I'm just
> > curious if you explicitly wanted to test .rodata global variable in
> > this case?
>
> Good point. This test is not to test .rodata variable. So using macro
> to differentiate different cases is actually better.

Ok, sounds good.

>
> >
> >
> >> +volatile const int syscall_wrapper = 1;
> >> +#define SYS_PREFIX "__x64_"
> >> +#elif defined(__TARGET_ARCH_s390)
> >> +volatile const int syscall_wrapper = 1;
> >> +#define SYS_PREFIX "__s390x_"
> >> +#elif defined(__TARGET_ARCH_arm64)
> >> +volatile const int syscall_wrapper = 1;
> >> +#define SYS_PREFIX "__arm64_"
> >> +#else
> >> +volatile const int syscall_wrapper = 0;
> >> +#endif
> >> +
> >>   static struct sockaddr_in old;
> >>
> >> -SEC("kprobe/__sys_connect")
> >> +SEC("kprobe/" SYS_PREFIX "sys_connect")
> >>   int BPF_KPROBE(handle_sys_connect)
> >>   {
> >> -       void *ptr = (void *)PT_REGS_PARM2(ctx);
> >> +       void *ptr;
> >>          struct sockaddr_in new;
> >>
> >> +       if (syscall_wrapper == 0) {
> >> +               ptr = (void *)PT_REGS_PARM2_CORE(ctx);
> >> +       } else {
> >> +               struct pt_regs *real_regs = (struct pt_regs *)PT_REGS_PARM1_CORE(ctx);
> >> +               ptr = (void *)PT_REGS_PARM2_CORE(real_regs);
> >> +       }
> >> +
> >>          bpf_probe_read_user(&old, sizeof(old), ptr);
> >>          __builtin_memset(&new, 0xab, sizeof(new));
> >>          bpf_probe_write_user(ptr, &new, sizeof(new));
> >> --
> >> 2.30.2
> >>
