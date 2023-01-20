Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D259675E9C
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 21:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjATUJu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 15:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjATUJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 15:09:49 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC7412875
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:47 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id mg12so16721762ejc.5
        for <bpf@vger.kernel.org>; Fri, 20 Jan 2023 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj/z8HeJKpT17/8QHq3Rpb8Me4DmhEi4GjBeOkXGlD8=;
        b=Unsk8GXNl+xeEASyFSgoNI6yIbklr82xJ4RGFc3N+zzsDu3MYfAqUqZP5i0qmKN2ro
         sVOHvGzkXXdOwkTz1dFq8Q77YPHG4aZiSEC2lxIEX9hzjUALVdVTBYlRvpfDEg2dLyMa
         zivuejCw0kfs/elWY17pJ/xD+kg+gJZkf5HkQSJPe6aqtRk77cWJTqjL0wnmd8d/9swH
         49D9bKCL+46+f/JTP3utM1+lpSgkAN+RII/b95y7sPVs0cH1P0wpugjTisfCqXzdedyQ
         1S0V07fSWP3iEDofmsol7OCB2iFZiPwDXA8UqdHb4BeB7SmONaNiGuE+UwVqSoEFsoV4
         R+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj/z8HeJKpT17/8QHq3Rpb8Me4DmhEi4GjBeOkXGlD8=;
        b=a0AgFFmDrgVk+oPFla6uFkk0fIabBicbMnClf8FEECqknPsP/uv77wJu/f4zP2xh9i
         RaIiu7+Z+kOMwkmtCSTEKsb0SQl5wiw9MaAnJVL4e/KY43p1lAAT/1tcIUbJN9u6r8up
         5vVwTENhnlB2OwnQAHzhUDcw84HLFsVs+ZdwapMnyNNcQzmsdB62FWraXnihz1baLwjI
         XeHRbnQlxfG3ljJwd0m9IR5+UAl2bq6uF7GqOIrmS1srEEBFbV7IjjHtEgX4wAHiNKMO
         Xy/CoseXbT0Hq1sCmDo+f7KLt35XNk7JYyv9+aat4tZ9tjnUuHrYZ3pewm0bZ/2xBDra
         GZtg==
X-Gm-Message-State: AFqh2kpqFBnJj0KMFv+R/qjWM+YlW4U49RWAwfyhgG4X0u1YG5jBFVG3
        NsCZm6+gfDTSY0513AuUaRVttNjF9NUsO2O8rOU=
X-Google-Smtp-Source: AMrXdXtGHqZdx7/NyvHkaX3L3TRlMN5RC1dIbFv0L4cN5o9Ij24D8/+1Un6pVf0LdLZe/+yT5pM4hyDhzORilgMd97c=
X-Received: by 2002:a17:906:1e8c:b0:7fc:4242:f9ea with SMTP id
 e12-20020a1709061e8c00b007fc4242f9eamr1320672ejj.99.1674245386062; Fri, 20
 Jan 2023 12:09:46 -0800 (PST)
MIME-Version: 1.0
References: <20230113083404.4015489-1-andrii@kernel.org> <f810f5c6a43af954464cedbe25d523896a59d500.camel@linux.ibm.com>
 <ed8ce036cd61741170dffe3fa733cd98d1970302.camel@linux.ibm.com> <5f212c293e08e91147b240e2ea41e168344897c9.camel@linux.ibm.com>
In-Reply-To: <5f212c293e08e91147b240e2ea41e168344897c9.camel@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 20 Jan 2023 12:09:34 -0800
Message-ID: <CAEf4BzYzV9-5HwUyoXoiHt2FQ3wWvWNbA=9YukW1YuWG-ZD07A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/25] libbpf: extend [ku]probe and syscall
 argument tracing support
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        Alan Maguire <alan.maguire@oracle.com>,
        Pu Lehui <pulehui@huawei.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Florent Revest <revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 1:52 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Mon, 2023-01-16 at 23:37 +0100, Ilya Leoshkevich wrote:
> > On Mon, 2023-01-16 at 23:09 +0100, Ilya Leoshkevich wrote:
> > > On Fri, 2023-01-13 at 00:33 -0800, Andrii Nakryiko wrote:
> > > > This patch set fixes and extends libbpf's bpf_tracing.h support
> > > > for
> > > > tracing
> > > > arguments of kprobes/uprobes, and syscall as a special case.
> > > >
> > > > Depending on the architecture, anywhere between 3 and 8 arguments
> > > > can
> > > > be
> > > > passed to a function in registers (so relevant to kprobes and
> > > > uprobes), but
> > > > before this patch set libbpf's macros in bpf_tracing.h only
> > > > supported
> > > > up to
> > > > 5 arguments, which is limiting in practice. This patch set
> > > > extends
> > > > bpf_tracing.h to support up to 8 arguments, if architecture
> > > > allows.
> > > > This
> > > > includes explicit PT_REGS_PARMx() macro family, as well as
> > > > BPF_KPROBE() macro.
> > > >
> > > > Now, with tracing syscall arguments situation is sometimes quite
> > > > different.
> > > > For a lot of architectures syscall argument passing through
> > > > registers
> > > > differs
> > > > from function call sequence at least a little. For i386 it
> > > > differs
> > > > *a
> > > > lot*.
> > > > This patch set addresses this issue across all currently
> > > > supported
> > > > architectures and hopefully fixes existing issues. syscall(2)
> > > > manpage
> > > > defines
> > > > that either 6 or 7 arguments can be supported, depending on
> > > > architecture, so
> > > > libbpf defines 6 or 7 registers per architecture to be used to
> > > > fetch
> > > > syscall
> > > > arguments.
> > > >
> > > > Also, BPF_UPROBE and BPF_URETPROBE are introduced as part of this
> > > > patch set.
> > > > They are aliases for BPF_KPROBE and BPF_KRETPROBE (as mechanics
> > > > of
> > > > argument
> > > > fetching of kernel functions and user-space functions are
> > > > identical),
> > > > but it
> > > > allows BPF users to have less confusing BPF-side code when
> > > > working
> > > > with
> > > > uprobes.
> > > >
> > > > For both sets of changes selftests are extended to test these new
> > > > register
> > > > definitions to architecture-defined limits. Unfortunately I don't
> > > > have ability
> > > > to test it on all architectures, and BPF CI only tests 3
> > > > architecture
> > > > (x86-64,
> > > > arm64, and s390x), so it would be greatly appreciated if CC'ed
> > > > people
> > > > can help
> > > > review and test changes on architectures they are familiar with
> > > > (and
> > > > maybe
> > > > have direct access to for testing). Thank you.
> > > >
> > > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > Cc: Pu Lehui <pulehui@huawei.com>
> > > > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > > > Cc: Vladimir Isaev <isaev@synopsys.com>
> > > > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > > > Cc: Kenta Tada <Kenta.Tada@sony.com>
> > > > Cc: Florent Revest <revest@chromium.org>
> > > >
> > > > Andrii Nakryiko (25):
> > > >   libbpf: add support for fetching up to 8 arguments in kprobes
> > > >   libbpf: add 6th argument support for x86-64 in bpf_tracing.h
> > > >   libbpf: fix arm and arm64 specs in bpf_tracing.h
> > > >   libbpf: complete mips spec in bpf_tracing.h
> > > >   libbpf: complete powerpc spec in bpf_tracing.h
> > > >   libbpf: complete sparc spec in bpf_tracing.h
> > > >   libbpf: complete riscv arch spec in bpf_tracing.h
> > > >   libbpf: fix and complete ARC spec in bpf_tracing.h
> > > >   libbpf: complete LoongArch (loongarch) spec in bpf_tracing.h
> > > >   libbpf: add BPF_UPROBE and BPF_URETPROBE macro aliases
> > > >   selftests/bpf: validate arch-specific argument registers limits
> > > >   libbpf: improve syscall tracing support in bpf_tracing.h
> > > >   libbpf: define x86-64 syscall regs spec in bpf_tracing.h
> > > >   libbpf: define i386 syscall regs spec in bpf_tracing.h
> > > >   libbpf: define s390x syscall regs spec in bpf_tracing.h
> > > >   libbpf: define arm syscall regs spec in bpf_tracing.h
> > > >   libbpf: define arm64 syscall regs spec in bpf_tracing.h
> > > >   libbpf: define mips syscall regs spec in bpf_tracing.h
> > > >   libbpf: define powerpc syscall regs spec in bpf_tracing.h
> > > >   libbpf: define sparc syscall regs spec in bpf_tracing.h
> > > >   libbpf: define riscv syscall regs spec in bpf_tracing.h
> > > >   libbpf: define arc syscall regs spec in bpf_tracing.h
> > > >   libbpf: define loongarch syscall regs spec in bpf_tracing.h
> > > >   selftests/bpf: add 6-argument syscall tracing test
> > > >   libbpf: clean up now not needed __PT_PARM{1-6}_SYSCALL_REG
> > > > defaults
> > > >
> > > >  tools/lib/bpf/bpf_tracing.h                   | 301
> > > > +++++++++++++++-
> > > > --
> > > >  .../bpf/prog_tests/test_bpf_syscall_macro.c   |  18 +-
> > > >  .../bpf/prog_tests/uprobe_autoattach.c        |  33 +-
> > > >  tools/testing/selftests/bpf/progs/bpf_misc.h  |  25 ++
> > > >  .../selftests/bpf/progs/bpf_syscall_macro.c   |  26 ++
> > > >  .../bpf/progs/test_uprobe_autoattach.c        |  48 ++-
> > > >  6 files changed, 405 insertions(+), 46 deletions(-)
> > > >
> > >
> > > With the following fixup for 24/25:
>
> [...]
>
> > > Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # s390x
> >
> > While the above fixup works, I realized that it's ugly. It's better
> > to
> > admit that mmap and old_mmap are different syscalls and create a
> > different probe, even if it means duplicating pid filtering code:
>
> [...]
>
> Sorry, I'm being dense. Both fixups defeat the purpose of having this
> test, because they don't use all 6 register arguments. We need to
> choose a different syscall; I believe splice() fits the bill. The other

nice, thanks for digging that up :) I've applied your suggested
changes (and added Suggested-by tag), thanks! Let's hope v2 will make
it to patchworks and we'll get BPF CI to test all this properly.


> alternatives that I rejected were:
>
> - clone() - argument order is messy;
> - recvfrom() - s390x uses socketcall instead;
> - ipc() - doesn't seem to be available on aarch64.
>
> The following worked for me:
>
> diff --git
> a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> index e18dd82eb801..2900c5e9a016 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
> @@ -1,20 +1,22 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright 2022 Sony Group Corporation */
> +#define _GNU_SOURCE
> +#include <fcntl.h>
>  #include <sys/prctl.h>
> -#include <sys/mman.h>
>  #include <test_progs.h>
>  #include "bpf_syscall_macro.skel.h"
>
>  void test_bpf_syscall_macro(void)
>  {
>         struct bpf_syscall_macro *skel =3D NULL;
> -       int err, page_size =3D getpagesize();
> +       int err;
>         int exp_arg1 =3D 1001;
>         unsigned long exp_arg2 =3D 12;
>         unsigned long exp_arg3 =3D 13;
>         unsigned long exp_arg4 =3D 14;
>         unsigned long exp_arg5 =3D 15;
> -       void *r;
> +       loff_t off_in, off_out;
> +       ssize_t r;
>
>         /* check whether it can open program */
>         skel =3D bpf_syscall_macro__open();
> @@ -71,18 +73,17 @@ void test_bpf_syscall_macro(void)
>         ASSERT_EQ(skel->bss->arg4_syscall, exp_arg4,
> "BPF_KPROBE_SYSCALL_arg4");
>         ASSERT_EQ(skel->bss->arg5_syscall, exp_arg5,
> "BPF_KPROBE_SYSCALL_arg5");
>
> -       r =3D mmap((void *)0x12340000, 3 * page_size, PROT_READ |
> PROT_WRITE,
> -                MAP_PRIVATE, -42, 5 * page_size);
> +       r =3D splice(-42, &off_in, 42, &off_out, 0x12340000,
> SPLICE_F_NONBLOCK);
>         err =3D -errno;
> -       ASSERT_EQ(r, MAP_FAILED, "mmap_res");
> -       ASSERT_EQ(err, -EBADF, "mmap_err");
> +       ASSERT_EQ(r, -1, "splice_res");
> +       ASSERT_EQ(err, -EBADF, "splice_err");
>
> -       ASSERT_EQ(skel->bss->mmap_addr, 0x12340000, "mmap_arg1");
> -       ASSERT_EQ(skel->bss->mmap_length, 3 * page_size, "mmap_arg2");
> -       ASSERT_EQ(skel->bss->mmap_prot, PROT_READ | PROT_WRITE,
> "mmap_arg3");
> -       ASSERT_EQ(skel->bss->mmap_flags, MAP_PRIVATE, "mmap_arg4");
> -       ASSERT_EQ(skel->bss->mmap_fd, -42, "mmap_arg5");
> -       ASSERT_EQ(skel->bss->mmap_offset, 5 * page_size, "mmap_arg6");
> +       ASSERT_EQ(skel->bss->splice_fd_in, -42, "splice_arg1");
> +       ASSERT_EQ(skel->bss->splice_off_in, (__u64)&off_in,
> "splice_arg2");
> +       ASSERT_EQ(skel->bss->splice_fd_out, 42, "splice_arg3");
> +       ASSERT_EQ(skel->bss->splice_off_out, (__u64)&off_out,
> "splice_arg4");
> +       ASSERT_EQ(skel->bss->splice_len, 0x12340000, "splice_arg5");
> +       ASSERT_EQ(skel->bss->splice_flags, SPLICE_F_NONBLOCK,
> "splice_arg6");
>
>  cleanup:
>         bpf_syscall_macro__destroy(skel);
> diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> index c07c5c52d5fc..1a476d8ed354 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> @@ -81,28 +81,28 @@ int BPF_KSYSCALL(prctl_enter, int option, unsigned
> long arg2,
>         return 0;
>  }
>
> -__u64 mmap_addr;
> -__u64 mmap_length;
> -__u64 mmap_prot;
> -__u64 mmap_flags;
> -__u64 mmap_fd;
> -__u64 mmap_offset;
> -
> -SEC("ksyscall/mmap")
> -int BPF_KSYSCALL(mmap_enter, void *addr, size_t length, int prot, int
> flags,
> -                int fd, off_t offset)
> +__u64 splice_fd_in;
> +__u64 splice_off_in;
> +__u64 splice_fd_out;
> +__u64 splice_off_out;
> +__u64 splice_len;
> +__u64 splice_flags;
> +
> +SEC("ksyscall/splice")
> +int BPF_KSYSCALL(splice_enter, int fd_in, loff_t *off_in, int fd_out,
> +                loff_t *off_out, size_t len, unsigned int flags)
>  {
>         pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
>
>         if (pid !=3D filter_pid)
>                 return 0;
>
> -       mmap_addr =3D (__u64)addr;
> -       mmap_length =3D length;
> -       mmap_prot =3D prot;
> -       mmap_flags =3D flags;
> -       mmap_fd =3D fd;
> -       mmap_offset =3D offset;
> +       splice_fd_in =3D fd_in;
> +       splice_off_in =3D (__u64)off_in;
> +       splice_fd_out =3D fd_out;
> +       splice_off_out =3D (__u64)off_out;
> +       splice_len =3D len;
> +       splice_flags =3D flags;
>
>         return 0;
>  }
> --
> 2.39.0
>
> Best regards,
> Ilya
