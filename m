Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF1D1949A1
	for <lists+bpf@lfdr.de>; Thu, 26 Mar 2020 21:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgCZU4N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Mar 2020 16:56:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55295 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgCZU4L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Mar 2020 16:56:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id c81so8581543wmd.4
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2020 13:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rwP6omks5Bq+LZp/QxgHU372BSlee6s0/LxcH04vRKs=;
        b=d6ksKOlgjbYjHrVyYgr77zwbHRp74js8GAmnFUAI8mm/lTiINEMzxp7PaJXycUlOTU
         Uw1xjwoet+9XZXNdqC1mbPWkMasfasXrMXkRoHUQjmtBUg30B8ixojhM0HPEy+61M79Z
         qW98UrwAc73NokYHzWtTDFvcBKJZ1PdzlbetU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rwP6omks5Bq+LZp/QxgHU372BSlee6s0/LxcH04vRKs=;
        b=EeeHk3XDuDbhwXRLsQtOBd4st4cKt7iMKznch81lwceP0fs5xxB7LHKEl9QtpMcH/J
         okpvmY8X72uqGIK/+3GmLU6xyPAv0uHca4k66irvi4cAn1T42TYHgmD1eQlgv9E6Rc24
         uKV2WupB4AAwZR7JsaSekAjYmldOT5ugCq5ZFZiqVd0wGJhzHWnOOSTh5OcSflSpQTJw
         W6UJnEGE4jn+DhDtexevbAEu+vXhoAOliuph5ApJYs/JZcPkXut3nBwCouqcXrVwUwE6
         nLwpzcHEtpvTUMTAtIAgwZUjDNpu1DZf/r9WnesaGNyqCapeAhilvik8g6hekMzswW/0
         D9Ug==
X-Gm-Message-State: ANhLgQ058l3hzZf3lEwEuZPdV24AkHNcuezM0BrFSNABTYWkMyItLEj0
        MTnzzvBRq2na51N76uX5lwOyXw==
X-Google-Smtp-Source: ADFU+vvJZFuES+hj74DJVNA+Egz9nA9OgldTpa60/W1NvhpyzxaZwZox17cgsEQKdYnkbSyR8a7Nvw==
X-Received: by 2002:adf:e492:: with SMTP id i18mr6162954wrm.316.1585256167215;
        Thu, 26 Mar 2020 13:56:07 -0700 (PDT)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id 127sm5388422wmd.38.2020.03.26.13.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:56:06 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Thu, 26 Mar 2020 21:56:04 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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
Subject: Re: [PATCH bpf-next v7 8/8] bpf: lsm: Add Documentation
Message-ID: <20200326205604.GC15273@chromium.org>
References: <20200326142823.26277-1-kpsingh@chromium.org>
 <20200326142823.26277-9-kpsingh@chromium.org>
 <CAEf4BzZ=qCNVbGqRfkgS-rfsODQaAzjQOErN8U9RH4Eu-HuD8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZ=qCNVbGqRfkgS-rfsODQaAzjQOErN8U9RH4Eu-HuD8Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks for the reviews!

On 26-Mär 12:31, Andrii Nakryiko wrote:
> On Thu, Mar 26, 2020 at 7:29 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Document how eBPF programs (BPF_PROG_TYPE_LSM) can be loaded and
> > attached (BPF_LSM_MAC) to the LSM hooks.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > Reviewed-by: Brendan Jackman <jackmanb@google.com>
> > Reviewed-by: Florent Revest <revest@google.com>
> > Reviewed-by: Thomas Garnier <thgarnie@google.com>
> > ---
> 
> This needs another pass and re-reading, has a bunch of outdated info :)

Indeed :)

> 
> >  Documentation/bpf/bpf_lsm.rst | 150 ++++++++++++++++++++++++++++++++++
> >  Documentation/bpf/index.rst   |   1 +
> >  2 files changed, 151 insertions(+)
> >  create mode 100644 Documentation/bpf/bpf_lsm.rst
> >
> > diff --git a/Documentation/bpf/bpf_lsm.rst b/Documentation/bpf/bpf_lsm.rst
> > new file mode 100644
> > index 000000000000..2a2c3b4a74d4
> > --- /dev/null
> > +++ b/Documentation/bpf/bpf_lsm.rst
> > @@ -0,0 +1,150 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +.. Copyright (C) 2020 Google LLC.
> > +
> > +================
> > +LSM BPF Programs
> > +================
> > +
> > +These BPF programs allow runtime instrumentation of the LSM hooks by privileged
> > +users to implement system-wide MAC (Mandatory Access Control) and Audit
> > +policies using eBPF. Since these program end up modifying the MAC policies of
> > +the system, they require both ``CAP_MAC_ADMIN`` and also require
> > +``CAP_SYS_ADMIN`` for the loading of BPF programs.
> > +
> > +Structure
> > +---------
> > +
> > +The example shows an eBPF program that can be attached to the ``file_mprotect``
> > +LSM hook:
> > +
> > +.. c:function:: int file_mprotect(struct vm_area_struct *vma, unsigned long reqprot, unsigned long prot);
> > +
> > +Other LSM hooks which can be instrumented can be found in
> > +``include/linux/lsm_hooks.h``.
> > +
> > +eBPF programs that use :doc:`/bpf/btf` do not need to include kernel headers
> > +for accessing information from the attached eBPF program's context. They can
> > +simply declare the structures in the eBPF program and only specify the fields
> > +that need to be accessed.
> > +
> > +.. code-block:: c
> > +
> > +       struct mm_struct {
> > +               unsigned long start_brk, brk, start_stack;
> > +       } __attribute__((preserve_access_index));
> > +
> > +       struct vm_area_struct {
> > +               unsigned long start_brk, brk, start_stack;
> > +               unsigned long vm_start, vm_end;
> > +               struct mm_struct *vm_mm;
> > +       } __attribute__((preserve_access_index));
> > +
> > +
> > +.. note:: Only the size and the names of the fields must match the type in the
> > +         kernel and the order of the fields is irrelevant.
> 
> type should match/be compatible as well?

I changed it to simply be:

.. note:: The order of the fields is irrelevant.

> 
> > +
> > +This can be further simplified (if one has access to the BTF information at
> > +build time) by generating the ``vmlinux.h`` with:
> > +
> > +.. code-block:: console
> > +
> > +        # bpftool dump file <path-to-btf-vmlinux> format c > vmlinux.h
> > +
> 
> bpftool btf *dump* file

Done.

> 
> > +.. note:: ``path-to-btf-vmlinux`` can be ``/sys/kernel/btf/vmlinux`` if the
> > +         build environment matches the environment the BPF programs are
> > +         deployed in.
> > +
> > +The ``vmlinux.h`` can then simply be included in the BPF programs without
> > +requiring the definition of the types.
> > +
> > +The eBPF programs can be declared using the``BPF_PROG``
> > +macros defined in `tools/lib/bpf/bpf_tracing.h`_. In this
> > +example:
> > +
> > +       * ``"lsm/file_mprotect"`` indicates the LSM hook that the program must
> > +         be attached to
> > +       * ``mprotect_audit`` is the name of the eBPF program
> > +
> > +.. code-block:: c
> > +
> > +        SEC("lsm/file_mprotect")
> > +        int BPF_PROG(mprotect_audit, struct vm_area_struct *vma,
> > +                     unsigned long reqprot, unsigned long prot, int ret)
> > +       {
> > +                /* Ret is the return value from the previous BPF program
> > +                 * or 0 if it's the first hook.
> > +                 */
> > +                if (ret != 0)
> > +                        return ret;
> > +
> > +               int is_heap;
> > +
> > +               is_heap = (vma->vm_start >= vma->vm_mm->start_brk &&
> > +                          vma->vm_end <= vma->vm_mm->brk);
> > +
> > +               /* Return an -EPERM or write information to the perf events buffer
> > +                * for auditing
> > +                */
> 
> return missing?

Fixed.

> 
> > +       }
> > +
> > +The ``__attribute__((preserve_access_index))`` is a clang feature that allows
> > +the BPF verifier to update the offsets for the access at runtime using the
> > +:doc:`/bpf/btf` information. Since the BPF verifier is aware of the types, it
> > +also validates all the accesses made to the various types in the eBPF program.
> > +
> > +Loading
> > +-------
> > +
> > +eBPF programs can be loaded with the :manpage:`bpf(2)` syscall's
> > +``BPF_PROG_LOAD`` operation or more simply by using the the libbpf helper
> > +``bpf_prog_load_xattr``:
> > +
> > +
> > +.. code-block:: c
> > +
> > +       struct bpf_prog_load_attr attr = {
> > +               .file = "./prog.o",
> > +       };
> > +       struct bpf_object *prog_obj;
> > +       struct bpf_program *prog;
> > +       int prog_fd;
> > +
> > +       bpf_prog_load_xattr(&attr, &prog_obj, &prog_fd);
> 
> Can you please update this to not use deprecated/legacy APIs. Please
> suggest bpf_object__open/bpf_object__load  and/or BPF skeleton as an
> example.


Simplified and modernized this section as:


Loading
-------

eBPF programs can be loaded with the :manpage:`bpf(2)` syscall's
``BPF_PROG_LOAD`` operation:

.. code-block:: c

	struct bpf_object *obj;

	obj = bpf_object__open("./my_prog.o");
	bpf_object__load(obj);

This can be simplified by using a skeleton header generated by ``bpftool``:

.. code-block:: console

	# bpftool gen skeleton my_prog.o > my_prog.skel.h

and the program can be loaded by including ``my_prog.skel.h`` and using
the generated helper, ``my_prog__open_and_load``.

Attachment to LSM Hooks
-----------------------

The LSM allows attachment of eBPF programs as LSM hooks using :manpage:`bpf(2)`
syscall's ``BPF_RAW_TRACEPOINT_OPEN`` operation or more simply by
using the libbpf helper ``bpf_program__attach_lsm``.

The program can be detached from the LSM hook by *destroying* the ``link``
link returned by ``bpf_program__attach_lsm`` using ``bpf_link__destroy``.

One can also use the helpers generated in ``my_prog.skel.h`` i.e.
``my_prog__attach`` for attachment and ``my_prog__destroy`` for cleaning up.

</end>

If this looks okay, I will send a v8 with this updated and other
fixes.

- KP

> 
> > +
> > +Attachment to LSM Hooks
> > +-----------------------
> > +
> > +The LSM allows attachment of eBPF programs as LSM hooks using :manpage:`bpf(2)`
> > +syscall's ``BPF_PROG_ATTACH`` operation or more simply by
> 
> BPF_PROG_ATTACH is incorrect, it's RAW_TRACEPOINT_OPEN, isn't it?

Correct, updated. Thanks!

> 
> > +using the libbpf helper ``bpf_program__attach_lsm``. In the code shown below
> > +``prog`` is the eBPF program loaded using ``BPF_PROG_LOAD``:
> > +
> > +.. code-block:: c
> > +
> > +       struct bpf_link *link;
> > +
> > +       link = bpf_program__attach_lsm(prog);
> > +
> > +The program can be detached from the LSM hook by *destroying* the ``link``
> > +link returned by ``bpf_program__attach_lsm``:
> > +
> > +.. code-block:: c
> > +
> > +       link->destroy();
> 
> that's not how it works in C ;)

Oops, I incorrectly picked it up from link->destroy(link); and wrote
something stupid.

> 
> bpf_link__destroy(link);

Updated in the snippet posted above.

- KP

> 
> > +
> > +Examples
> > +--------
> > +
> > +An example eBPF programs can be found in
> > +`tools/testing/selftests/bpf/progs/lsm.c`_ and the corresponding
> > +userspace code in `tools/testing/selftests/bpf/prog_tests/test_lsm.c`_
> > +
> > +.. Links
> > +.. _tools/lib/bpf/bpf_tracing.h:
> > +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/lib/bpf/bpf_tracing.h
> > +.. _tools/testing/selftests/bpf/progs/lsm.c:
> > +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm.c
> > +.. _tools/testing/selftests/bpf/progs/lsm_void_hook.c:
> > +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/progs/lsm_void_hook.c
> > +.. _tools/testing/selftests/bpf/prog_tests/test_lsm.c:
> > +   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/tools/testing/selftests/bpf/prog_tests/test_lsm.c
> > diff --git a/Documentation/bpf/index.rst b/Documentation/bpf/index.rst
> > index 7be43c5f2dcf..f99677f3572f 100644
> > --- a/Documentation/bpf/index.rst
> > +++ b/Documentation/bpf/index.rst
> > @@ -45,6 +45,7 @@ Program types
> >     prog_cgroup_sockopt
> >     prog_cgroup_sysctl
> >     prog_flow_dissector
> > +   bpf_lsm
> >
> >
> >  Testing and debugging BPF
> > --
> > 2.20.1
> >
