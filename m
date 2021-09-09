Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE2F7405F9B
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 00:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbhIIWdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhIIWdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Sep 2021 18:33:05 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7ADC061574
        for <bpf@vger.kernel.org>; Thu,  9 Sep 2021 15:31:55 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z5so7100333ybj.2
        for <bpf@vger.kernel.org>; Thu, 09 Sep 2021 15:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AIUb9ODQ7DY9LJR6OGybHtKIU6ZG/v7rZ+XcGbDxDk=;
        b=GdPRE3sZKi0Bjj9cqxZG+pkFgmpN+hNI5hY4fMRZ7Xs++7mmNpqp7E0kF79kuLsyEJ
         xWE7dITm7RC60kk0ziqfyjv0b6PM4fpM0CDRwO1Vj2apy5t0QeVe+Ok4Y+WO5JVBGF7/
         wA66Z9FgmYsUlO3XcXSPnT9WWY2wbDzFPYBJupXqYOuf6BlPexBrwoZilC0QXW4YcuLQ
         Ocee3XhuJAEgCL8Kk0eae9cwAdaNZrGSO3NKGo8cYhU0uRSrEWmb0ZjUcE0gdoEsSdeB
         RMGP9co+gV0SUvUHXPyPf2Xuc5AJVtodEEvDInB68uIFzqh/zM13eNeZ2D4fMuRCZzC7
         9UKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AIUb9ODQ7DY9LJR6OGybHtKIU6ZG/v7rZ+XcGbDxDk=;
        b=RNPuZtgrV0u7ikpq4Do7XZe9Oj2Vzjs1CXZwG8XHTPjzDPcjgNth9ShcPPkI0xQo1T
         xd/OnTSqkWv1HDHtI/ZlgXbhimNY0XLkQBOUyZ0zgTBVQ1iFia09brSIGeJKUyg+u+rN
         hbSlm4FcNoMloQguboMC7XqVMZGRL6fBsMDWN2GxiTisc1qdY9cv1Uv6GbUoCMYxBIse
         OfDWBjKWTmBNTu0Rx1+Hl/eSV7I3247UcE7e2htt6z9svHfhS4TapT8VvLh+rrFE5tdn
         VBvgJaocK+pSCUzMXiaqLwNp+BH6tzcvTH32sz9TpVPiXT4apTeOc6Y7TZuQj6aORiak
         HDlA==
X-Gm-Message-State: AOAM531vba2wUgSme/5TGFGKwu6yTqAMitpjB/5ObL7DDkaNQPLJz9js
        WlTEMQaHzE/F9Gj0xhwJhVKEWahQU39HkOIza+g=
X-Google-Smtp-Source: ABdhPJz0TgHjM6wGx0qARkDhQdwfuzMX2uVm4aedSF/a/h/ENrY5rYRwjqdoaIi91ZMV0WYHXuPdHrmF/sQ4nhsBVcQ=
X-Received: by 2002:a5b:702:: with SMTP id g2mr6803683ybq.307.1631226714345;
 Thu, 09 Sep 2021 15:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210908213226.1871016-1-andrii@kernel.org> <af17df18-73ae-ad25-0803-3dc37a4cc02c@iogearbox.net>
 <CAEf4BzZcfy9f2E2ADvaV5PDXRMxsupePGPdu12ZRjE2wh3Hn1w@mail.gmail.com>
 <CAEf4BzZqc7txCoiV-F0_+oMB9GMv4BTapnef5V1XZk8CC=LpHA@mail.gmail.com> <4287e56e-a91a-1f39-5dae-14ecabe537db@iogearbox.net>
In-Reply-To: <4287e56e-a91a-1f39-5dae-14ecabe537db@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Sep 2021 15:31:43 -0700
Message-ID: <CAEf4BzaNSG1w_CuYVoK7WSntKsr4mzTr99K6jPVeSm_-2cbwZw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] libbpf: add LIBBPF_DEPRECATED_SINCE macro for
 scheduling API deprecations
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 9, 2021 at 2:43 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 9/9/21 8:08 PM, Andrii Nakryiko wrote:
> > On Thu, Sep 9, 2021 at 9:37 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >> On Thu, Sep 9, 2021 at 5:58 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >>> On 9/8/21 11:32 PM, Andrii Nakryiko wrote:
> >>>> From: Quentin Monnet <quentin@isovalent.com>
> >>>>
> >>>> Introduce a macro LIBBPF_DEPRECATED_SINCE(major, minor, message) to prepare
> >>>> the deprecation of two API functions. This macro marks functions as deprecated
> >>>> when libbpf's version reaches the values passed as an argument.
> >>>>
> >>>> As part of this change libbpf_version.h header is added with recorded major
> >>>> (LIBBPF_MAJOR_VERSION) and minor (LIBBPF_MINOR_VERSION) libbpf version macros.
> >>>> They are now part of libbpf public API and can be relied upon by user code.
> >>>> libbpf_version.h is installed system-wide along other libbpf public headers.
> >>>>
> >>>> Due to this new build-time auto-generated header, in-kernel applications
> >>>> relying on libbpf (resolve_btfids, bpftool, bpf_preload) are updated to
> >>>> include libbpf's output directory as part of a list of include search paths.
> >>>> Better fix would be to use libbpf's make_install target to install public API
> >>>> headers, but that clean up is left out as a future improvement. The build
> >>>> changes were tested by building kernel (with KBUILD_OUTPUT and O= specified
> >>>> explicitly), bpftool, libbpf, selftests/bpf, and resolve_btfids builds. No
> >>>> problems were detected.
> >>>>
> >>>> Note that because of the constraints of the C preprocessor we have to write
> >>>> a few lines of macro magic for each version used to prepare deprecation (0.6
> >>>> for now).
> >>>>
> >>>> Also, use LIBBPF_DEPRECATED_SINCE() to schedule deprecation of
> >>>> btf__get_from_id() and btf__load(), which are replaced by
> >>>> btf__load_from_kernel_by_id() and btf__load_into_kernel(), respectively,
> >>>> starting from future libbpf v0.6. This is part of libbpf 1.0 effort ([0]).
> >>>>
> >>>>     [0] Closes: https://github.com/libbpf/libbpf/issues/278
> >>>>
> >>>> Co-developed-by: Quentin Monnet <quentin@isovalent.com>
> >>>> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> >>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> >>>> ---
> >>>> v2->v3:
> >>>>     - adding `sleep 10` revealed two more missing dependencies in resolve_btfids
> >>>>       and selftest/bpf's bench, which were fixed (BPF CI);
> >>>> v1->v2:
> >>>>     - fix bpf_preload build by adding dependency for iterators/iterators.o on
> >>>>       libbpf.a generation (caught by BPF CI);
> >>>>
> >>>>    kernel/bpf/preload/Makefile          |  7 +++++--
> >>>>    tools/bpf/bpftool/Makefile           |  4 ++++
> >>>>    tools/bpf/resolve_btfids/Makefile    |  6 ++++--
> >>>>    tools/lib/bpf/Makefile               | 24 +++++++++++++++++-------
> >>>>    tools/lib/bpf/btf.h                  |  2 ++
> >>>>    tools/lib/bpf/libbpf_common.h        | 19 +++++++++++++++++++
> >>>>    tools/testing/selftests/bpf/Makefile |  4 ++--
> >>>>    7 files changed, 53 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/kernel/bpf/preload/Makefile b/kernel/bpf/preload/Makefile
> >>>> index 1951332dd15f..ac29d4e9a384 100644
> >>>> --- a/kernel/bpf/preload/Makefile
> >>>> +++ b/kernel/bpf/preload/Makefile
> >>>> @@ -10,12 +10,15 @@ LIBBPF_OUT = $(abspath $(obj))
> >>>>    $(LIBBPF_A):
> >>>>        $(Q)$(MAKE) -C $(LIBBPF_SRCS) O=$(LIBBPF_OUT)/ OUTPUT=$(LIBBPF_OUT)/ $(LIBBPF_OUT)/libbpf.a
> >>>>
> >>>> -userccflags += -I $(srctree)/tools/include/ -I $(srctree)/tools/include/uapi \
> >>>> +userccflags += -I$(LIBBPF_OUT) -I $(srctree)/tools/include/ \
> >>>> +     -I $(srctree)/tools/include/uapi \
> >>>>        -I $(srctree)/tools/lib/ -Wno-unused-result
> >>>>
> >>>>    userprogs := bpf_preload_umd
> >>>>
> >>>> -clean-files := $(userprogs) bpf_helper_defs.h FEATURE-DUMP.libbpf staticobjs/ feature/
> >>>> +clean-files := $(userprogs) libbpf_version.h bpf_helper_defs.h FEATURE-DUMP.libbpf staticobjs/ feature/
> >>>> +
> >>>> +$(obj)/iterators/iterators.o: $(LIBBPF_A)
> >>>>
> >>>>    bpf_preload_umd-objs := iterators/iterators.o
> >>>>    bpf_preload_umd-userldlibs := $(LIBBPF_A) -lelf -lz
> >>>
> >>> One small issue I ran into by accident while testing:
> >>>
> >>> [root@linux bpf-next]# make -j8 kernel/bpf/
> >>>     SYNC    include/config/auto.conf.cmd
> >>>     DESCEND objtool
> >>>     CALL    scripts/atomic/check-atomics.sh
> >>>     CALL    scripts/checksyscalls.sh
> >>>     CC      kernel/bpf/syscall.o
> >>>     AR      kernel/bpf/preload/built-in.a
> >>>     CC [M]  kernel/bpf/preload/bpf_preload_kern.o
> >>>     CC [U]  kernel/bpf/preload/iterators/iterators.o
> >>> In file included from ./tools/lib/bpf/libbpf.h:20,
> >>>                    from kernel/bpf/preload/iterators/iterators.c:10:
> >>> ./tools/lib/bpf/libbpf_common.h:13:10: fatal error: libbpf_version.h: No such file or directory
> >>>      13 | #include "libbpf_version.h"
> >>>         |          ^~~~~~~~~~~~~~~~~~
> >>> compilation terminated.
> >>> make[3]: *** [scripts/Makefile.userprogs:43: kernel/bpf/preload/iterators/iterators.o] Error 1
> >>> make[3]: *** Waiting for unfinished jobs....
> >>> make[2]: *** [scripts/Makefile.build:540: kernel/bpf/preload] Error 2
> >>> make[2]: *** Waiting for unfinished jobs....
> >>> make[1]: *** [scripts/Makefile.build:540: kernel/bpf] Error 2
> >>> make: *** [Makefile:1872: kernel] Error 2
> >>>
> >>> For me it was the case where tools/lib/bpf/ was already built _before_ this patch
> >>> was applied, then I applied it, and just ran make -j8 kernel/bpf/ where the above
> >>> can then be reproduced. I'd assume that as-is, this would affect many folks on update.
> >>
> >> We had a similar issue even before these changes with resolve_btfids
> >> build, because Kbuild doesn't record dependency on libbpf build
> >> properly. I'll see how hard it is to record that in a non-intrusive
> >> way for both resolve_btfids and preload/iterators, because doing `make
> >> resolve_btfids_clean` or, worse, `make clean` isn't great.
> >
> > Hm... I can't repro this. Both preload/iterators and resolve_btfids
> > have $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile)
> > dependency which will trigger libbpf rebuild if any of libbpf source
> > files changes. I added `sleep 1000` and everything under kernel/bpf is
> > blocked on this until libbpf build completes. For full kernel build it
> > also shouldn't happen because we build resolve_btfids first before
> > proceeding to building other files and resolve_btfids should trigger
> > libbpf build.
> >
> > I assume `make clean kernel/bpf` fixed the issue for you in that case?
>
> No, fixing on that node was done via re-building libbpf via tools/lib/bpf/.
>
> > Also, how did you build tools/lib/bpf before running `make -j8 kernel/bpf`?
>
> Basically just i) cd tools/lib/bpf, ii) make clean, iii) make, then applying
> the patch, and then running make -j8 kernel/bpf. I just tried on a different
> build node with newer user space, and there it indeed triggers a rebuild of
> libbpf. On my laptop where I was running into this it didn't. I would suspect
> a potential diff in make's behavior (not seen in GNU Make 4.3, seen in GNU
> Make 4.2.1, fwiw). Anyway, for this niche case, manual rebuild of tools/lib/bpf
> does it ... given it's neither seen in your case nor on newer uspace, I took
> it in, lets see how it goes. Thanks!

Yeah, thanks! Please let me know if you do run into this again
somewhere, though.

>
> > Honestly, hard to tell how this happens without being able to repro
> > this. So far everything seems to be working for me. I've tried with
> > and without the KBUILD_OUTPUT envvar set. I also tried O=<path>.
> >
> >>>
> >>> Thanks,
> >>> Daniel
>
