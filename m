Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59798194776
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 20:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCZTcA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 15:32:00 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36152 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTcA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 15:32:00 -0400
Received: by mail-qv1-f67.google.com with SMTP id z13so3694371qvw.3;
        Thu, 26 Mar 2020 12:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nk1SB5/8LQSmbpYsi3niqEIVk46A9habhG3vnn00H68=;
        b=JqDwLSrsPUsyxumNdMb6YmDbm4vfxhkA6Z9VurqB+ZkwBX997TZ662kk+RPzETA2Gz
         xyjjvjkhWYXomf52S5kdN404+WBKPeCWyvNLHUYhxbpmLn9Uz+zZ7vXeGA/phFsV3xjc
         AYLmTIwX00J/O/HeWYh8pEufC7WOSVph6flM+20Lu8jrOPdOp9mtZFLf6dFobOK7Rq/G
         hxpsL0QUWdF4jVnpuskQTJRc+/tV/VpfqFmIsRWV8nETKC0JwRFOsYTUtZNL2dogWlQo
         wHAowE/968glZhXE4CBcalQsgZs2DMcTriVrn0bF43ImlGkdBda2+Pc2KotZKf1OMaps
         Ex3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nk1SB5/8LQSmbpYsi3niqEIVk46A9habhG3vnn00H68=;
        b=Jkhqrg5iM9iTU2PhcsbLn4XP7OJC74QK6sfMOwMW9Ct9k2JtyV+aDl8sOfUTxz1woD
         foNT0KE37wsAmWiVdiuU5/pdoaEGQojfbP17kBXsFkYtw7UE6cEv7igA/fQAF110W5R6
         n0B4ULy1ZdRNdsMH9bxaeSXQsxQtroJevERDUSoYetm6lGFVs8HTzbIoUTEIE8cLkebB
         mVpqKtBT9PxhOHCpyh8JjNE3c51ZJj/f1CE3AeyK1gzojf5Keg8pd61mdw4ycn70zwyd
         Vrr+GJ9L/7Eydg5fTDWLPNZJqoLwWzOiodEwiatRnFsu5sU7pvSivx35FUP0HqCN8lxr
         h7ZQ==
X-Gm-Message-State: ANhLgQ1womXxQWyFvg2vV2AF2fKdh0fORmW3yy6ArIc2612Y8IIrtdjz
        saS45Ze0DcLRLabtxH3vgSe//hCp19mCjgBTQNk=
X-Google-Smtp-Source: ADFU+vuxjG1wJsxFm4wwbZmJnLyOARmhOFj9W+tmINMNnFzM0YREWKetus6PC+eeuCMTF967ZniWJW9LWYD8TPV4U9c=
X-Received: by 2002:a0c:8525:: with SMTP id n34mr9879456qva.224.1585251114701;
 Thu, 26 Mar 2020 12:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200326142823.26277-1-kpsingh@chromium.org> <20200326142823.26277-9-kpsingh@chromium.org>
In-Reply-To: <20200326142823.26277-9-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 26 Mar 2020 12:31:43 -0700
Message-ID: <CAEf4BzZ=qCNVbGqRfkgS-rfsODQaAzjQOErN8U9RH4Eu-HuD8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 8/8] bpf: lsm: Add Documentation
To:     KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-security-module@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 26, 2020 at 7:29 AM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> Document how eBPF programs (BPF_PROG_TYPE_LSM) can be loaded and
> attached (BPF_LSM_MAC) to the LSM hooks.
>
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> Reviewed-by: Thomas Garnier <thgarnie@google.com>
> ---

This needs another pass and re-reading, has a bunch of outdated info :)

>  Documentation/bpf/bpf_lsm.rst | 150 ++++++++++++++++++++++++++++++++++
>  Documentation/bpf/index.rst   |   1 +
>  2 files changed, 151 insertions(+)
>  create mode 100644 Documentation/bpf/bpf_lsm.rst
>
> diff --git a/Documentation/bpf/bpf_lsm.rst b/Documentation/bpf/bpf_lsm.rst
> new file mode 100644
> index 000000000000..2a2c3b4a74d4
> --- /dev/null
> +++ b/Documentation/bpf/bpf_lsm.rst
> @@ -0,0 +1,150 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +.. Copyright (C) 2020 Google LLC.
> +
> +================
> +LSM BPF Programs
> +================
> +
> +These BPF programs allow runtime instrumentation of the LSM hooks by privileged
> +users to implement system-wide MAC (Mandatory Access Control) and Audit
> +policies using eBPF. Since these program end up modifying the MAC policies of
> +the system, they require both ``CAP_MAC_ADMIN`` and also require
> +``CAP_SYS_ADMIN`` for the loading of BPF programs.
> +
> +Structure
> +---------
> +
> +The example shows an eBPF program that can be attached to the ``file_mprotect``
> +LSM hook:
> +
> +.. c:function:: int file_mprotect(struct vm_area_struct *vma, unsigned long reqprot, unsigned long prot);
> +
> +Other LSM hooks which can be instrumented can be found in
> +``include/linux/lsm_hooks.h``.
> +
> +eBPF programs that use :doc:`/bpf/btf` do not need to include kernel headers
> +for accessing information from the attached eBPF program's context. They can
> +simply declare the structures in the eBPF program and only specify the fields
> +that need to be accessed.
> +
> +.. code-block:: c
> +
> +       struct mm_struct {
> +               unsigned long start_brk, brk, start_stack;
> +       } __attribute__((preserve_access_index));
> +
> +       struct vm_area_struct {
> +               unsigned long start_brk, brk, start_stack;
> +               unsigned long vm_start, vm_end;
> +               struct mm_struct *vm_mm;
> +       } __attribute__((preserve_access_index));
> +
> +
> +.. note:: Only the size and the names of the fields must match the type in the
> +         kernel and the order of the fields is irrelevant.

type should match/be compatible as well?

> +
> +This can be further simplified (if one has access to the BTF information at
> +build time) by generating the ``vmlinux.h`` with:
> +
> +.. code-block:: console
> +
> +        # bpftool dump file <path-to-btf-vmlinux> format c > vmlinux.h
> +

bpftool btf *dump* file

> +.. note:: ``path-to-btf-vmlinux`` can be ``/sys/kernel/btf/vmlinux`` if the
> +         build environment matches the environment the BPF programs are
> +         deployed in.
> +
> +The ``vmlinux.h`` can then simply be included in the BPF programs without
> +requiring the definition of the types.
> +
> +The eBPF programs can be declared using the``BPF_PROG``
> +macros defined in `tools/lib/bpf/bpf_tracing.h`_. In this
> +example:
> +
> +       * ``"lsm/file_mprotect"`` indicates the LSM hook that the program must
> +         be attached to
> +       * ``mprotect_audit`` is the name of the eBPF program
> +
> +.. code-block:: c
> +
> +        SEC("lsm/file_mprotect")
> +        int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
> +                     unsigned long reqprot, unsigned long prot, int ret)
> +       {
> +                /* Ret is the return value from the previous BPF program
> +                 * or 0 if it's the first hook.
> +                 */
> +                if (ret != 0)
> +                        return ret;
> +
> +               int is_heap;
> +
> +               is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> +                          vma->vm_end <= vma->vm_mm->brk);
> +
> +               /* Return an -EPERM or write information to the perf events buffer
> +                * for auditing
> +                */

return missing?

> +       }
> +
> +The ``__attribute__((preserve_access_index))`` is a clang feature that allows
> +the BPF verifier to update the offsets for the access at runtime using the
> +:doc:`/bpf/btf` information. Since the BPF verifier is aware of the types, it
> +also validates all the accesses made to the various types in the eBPF program.
> +
> +Loading
> +-------
> +
> +eBPF programs can be loaded with the :manpage:`bpf(2)` syscall's
> +``BPF_PROG_LOAD`` operation or more simply by using the the libbpf helper
> +``bpf_prog_load_xattr``:
> +
> +
> +.. code-block:: c
> +
> +       struct bpf_prog_load_attr attr = {
> +               .file = "./prog.o",
> +       };
> +       struct bpf_object *prog_obj;
> +       struct bpf_program *prog;
> +       int prog_fd;
> +
> +       bpf_prog_load_xattr(&attr, &prog_obj, &prog_fd);

Can you please update this to not use deprecated/legacy APIs. Please
suggest bpf_object__open/bpf_object__load  and/or BPF skeleton as an
example.

> +
> +Attachment to LSM Hooks
> +-----------------------
> +
> +The LSM allows attachment of eBPF programs as LSM hooks using :manpage:`bpf(2)`
> +syscall's ``BPF_PROG_ATTACH`` operation or more simply by

BPF_PROG_ATTACH is incorrect, it's RAW_TRACEPOINT_OPEN, isn't it?

> +using the libbpf helper ``bpf_program__attach_lsm``. In the code shown below
> +``prog`` is the eBPF program loaded using ``BPF_PROG_LOAD``:
> +
> +.. code-block:: c
> +
> +       struct bpf_link *link;
> +
> +       link = bpf_program__attach_lsm(prog);
> +
> +The program can be detached from the LSM hook by *destroying* the ``link``
> +link returned by ``bpf_program__attach_lsm``:
> +
> +.. code-block:: c
> +
> +       link->destroy();

that's not how it works in C ;)

bpf_link__destroy(link);

> +
> +Examples
> +--------
> +
> +An example eBPF programs can be found in
> +`tools/testing/selftests/bpf/progs/lsm.c`_ and the corresponding
> +userspace code in `tools/testing/selftests/bpf/prog_tests/test_lsm.c`_
> +
> +.. Links
> +.. _tools/lib/bpf/bpf_tracing.h:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/lib/bpf/bpf_tracing.h
> +.. _tools/testing/selftests/bpf/progs/lsm.c:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm.c
> +.. _tools/testing/selftests/bpf/progs/lsm_void_hook.c:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm_void_hook.c
> +.. _tools/testing/selftests/bpf/prog_tests/test_lsm.c:
> +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> index 7be43c5f2dcf..f99677f3572f 100644
> --- a/Documentation/bpf/index.rst
> +++ b/Documentation/bpf/index.rst
> @@ -45,6 +45,7 @@ Program types
>     prog_cgroup_sockopt
>     prog_cgroup_sysctl
>     prog_flow_dissector
> +   bpf_lsm
>
>
>  Testing and debugging BPF
> --
> 2.20.1
>
