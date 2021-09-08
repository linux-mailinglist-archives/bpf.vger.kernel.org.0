Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC35403C1F
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351997AbhIHPCk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 11:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351979AbhIHPCW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Sep 2021 11:02:22 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD95EC061575
        for <bpf@vger.kernel.org>; Wed,  8 Sep 2021 08:01:14 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v10so4196165ybq.7
        for <bpf@vger.kernel.org>; Wed, 08 Sep 2021 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqWVtRDMSrpacf29ezygbrIswde+PQ6jNoqCJaacPDo=;
        b=XKYXfTRa8dNY5qYfFmQ4gDy0ZtbzJJ6cyMgr1IKfn9PBW+i2ck5FGDFlLAcHN9k/op
         sLqevRaZ4/d6gxavL7OtRuXRdkm2nfst343KiyJ/rJMTreYCahyIkqFlQ8nFeQGsRaRb
         bqbSfwPwxbSFzx944HfaGUZTbI5tRTyfwcBHrLHmvymh+Z3CPGNhBNxaSmniAsxD6nMa
         oDtL+WZc7vFQv9eib6r+26Sqp6pXOVMMONiQICXSBgDyvECA0S01421gXgFkUHbXsBXR
         yqPQR4NSHu7lzb8bQOqMjO9qs73od1acl4NQAhtS2oAfHppoCLkLKLMXVLEcDOQuU4P6
         QkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqWVtRDMSrpacf29ezygbrIswde+PQ6jNoqCJaacPDo=;
        b=HVwIIhFQu+mR4+IeiJ7C5vMLzYQX7M2ByLB2iI8UyJzojW0Rq4M5ipAIp4hfDaG57e
         mEsQ/QY28pXn3wlPn0QhZ1dGM41FtRG/asAx7G9lxdr+nCjt8+57VKWYa/TRa/Aut5jM
         6bO1qWHIygAn8nkP04+6wXlo4Xm1vD+z2xI/Z7pHtfvyf3v5kwvCQMKZYBgMhd4rkzxa
         dJ3khbZAFlxyJyH4WkNCGF2HTvJPYJgdK+B62XZjUVl6m4NYgMfRPI9hME7abHLXPZnQ
         Rm6/syd7JbkBMMawUPA32cP/4iyeelJ20SGK1wIWUp3G9wRkTSVvqdEkLAAJLPylV13O
         EVzw==
X-Gm-Message-State: AOAM530GV0lrii2DePjKOIh6UkOEeziF6DCOyKeFpsNt8RH/tVg87Muc
        vjHmLyERo0sK6vuOep3KH3L+dVyD0jGQm6hQFc8=
X-Google-Smtp-Source: ABdhPJzQzC8fgNoCs7G4ZbAIWPturEnXCJkAGkpNsX5tbPQBdrY6zWtI8fpssA3x11XG9z6NwMFbP1uRf9I/7aaXW/k=
X-Received: by 2002:a25:65c4:: with SMTP id z187mr5975664ybb.113.1631113274018;
 Wed, 08 Sep 2021 08:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210908065538.1725496-1-andrii@kernel.org> <8ca16967-cba4-6a0c-89e7-6d774d3706b1@iogearbox.net>
In-Reply-To: <8ca16967-cba4-6a0c-89e7-6d774d3706b1@iogearbox.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Sep 2021 08:01:03 -0700
Message-ID: <CAEf4BzY=JqtBXUAnUmaVwr0byX62o2eGh19wft4u7R83EtniAg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] libbpf: add LIBBPF_DEPRECATED_SINCE macro for
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

On Wed, Sep 8, 2021 at 6:01 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 9/8/21 8:55 AM, Andrii Nakryiko wrote:
> > From: Quentin Monnet <quentin@isovalent.com>
> >
> > Introduce a macro LIBBPF_DEPRECATED_SINCE(major, minor, message) to prepare
> > the deprecation of two API functions. This macro marks functions as deprecated
> > when libbpf's version reaches the values passed as an argument.
> >
> > As part of this change libbpf_version.h header is added with recorded major
> > (LIBBPF_MAJOR_VERSION) and minor (LIBBPF_MINOR_VERSION) libbpf version macros.
> > They are now part of libbpf public API and can be relied upon by user code.
> > libbpf_version.h is installed system-wide along other libbpf public headers.
> >
> > Due to this new build-time auto-generated header, in-kernel applications
> > relying on libbpf (resolve_btfids, bpftool, bpf_preload) are updated to
> > include libbpf's output directory as part of a list of include search paths.
> > Better fix would be to use libbpf's make_install target to install public API
> > headers, but that clean up is left out as a future improvement. The build
> > changes were tested by building kernel (with KBUILD_OUTPUT and O= specified
> > explicitly), bpftool, libbpf, selftests/bpf, and resolve_btfids builds. No
> > problems were detected.
> >
> > Note that because of the constraints of the C preprocessor we have to write
> > a few lines of macro magic for each version used to prepare deprecation (0.6
> > for now).
> >
> > Also, use LIBBPF_DEPRECATED_SINCE() to schedule deprecation of
> > btf__get_from_id() and btf__load(), which are replaced by
> > btf__load_from_kernel_by_id() and btf__load_into_kernel(), respectively,
> > starting from future libbpf v0.6. This is part of libbpf 1.0 effort ([0]).
> >
> >    [0] Closes: https://github.com/libbpf/libbpf/issues/278
> >
> > Co-developed-by: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >
> > v1->v2:
> >    - fix bpf_preload build by adding dependency for iterators/iterators.o on
> >      libbpf.a generation (caught by BPF CI);
> [...]
> > @@ -136,7 +140,7 @@ all: fixdep
> >
> >   all_cmd: $(CMD_TARGETS) check
> >
> > -$(BPF_IN_SHARED): force $(BPF_HELPER_DEFS)
> > +$(BPF_IN_SHARED): force $(BPF_GENERATED)
> >       @(test -f ../../include/uapi/linux/bpf.h -a -f ../../../include/uapi/linux/bpf.h && ( \
> >       (diff -B ../../include/uapi/linux/bpf.h ../../../include/uapi/linux/bpf.h >/dev/null) || \
> >       echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'" >&2 )) || true
> > @@ -154,13 +158,19 @@ $(BPF_IN_SHARED): force $(BPF_HELPER_DEFS)
> >       echo "Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'" >&2 )) || true
> >       $(Q)$(MAKE) $(build)=libbpf OUTPUT=$(SHARED_OBJDIR) CFLAGS="$(CFLAGS) $(SHLIB_FLAGS)"
> >
> > -$(BPF_IN_STATIC): force $(BPF_HELPER_DEFS)
> > +$(BPF_IN_STATIC): force $(BPF_GENERATED)
> >       $(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
> >
> >   $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
> >       $(QUIET_GEN)$(srctree)/scripts/bpf_doc.py --header \
> >               --file $(srctree)/tools/include/uapi/linux/bpf.h > $(BPF_HELPER_DEFS)
> >
> > +$(VERSION_HDR): force
> > +     $(QUIET_GEN)echo "/* This file was auto-generated. */" > $@
> > +     @echo "" >> $@
> > +     @echo "#define LIBBPF_MAJOR_VERSION $(LIBBPF_MAJOR_VERSION)" >> $@
> > +     @echo "#define LIBBPF_MINOR_VERSION $(LIBBPF_MINOR_VERSION)" >> $@
> > +
>
> Looks like CI caught a different issue this time with v2 where it cannot find libbpf_version.h:

Yep, I'll keep fixing this. Couldn't repro this locally. But I'm also
going to add a long sleep in libbpf_version.h generation to force this
kind of issue more easily. Sorry for the noise.

>
>    [...]
>      CC       bench_count.o
>      GEN     /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bpf-helpers.rst
>    In file included from /home/runner/work/bpf/bpf/tools/lib/bpf/bpf.h:31,
>                     from /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bench.h:8,
>                     from benchs/bench_count.c:3:
>    /home/runner/work/bpf/bpf/tools/lib/bpf/libbpf_common.h:13:10: fatal error: libbpf_version.h: No such file or directory
>       13 | #include "libbpf_version.h"
>          |          ^~~~~~~~~~~~~~~~~~
>    compilation terminated.
>    make: *** [Makefile:517: /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bench_count.o] Error 1
>    make: *** Waiting for unfinished jobs....
>      GEN     /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bpf-syscall.rst
>    In file included from /home/runner/work/bpf/bpf/tools/lib/bpf/bpf.h:31,
>                     from bench.h:8,
>                     from bench.c:13:
>    /home/runner/work/bpf/bpf/tools/lib/bpf/libbpf_common.h:13:10: fatal error: libbpf_version.h: No such file or directory
>       13 | #include "libbpf_version.h"
>          |          ^~~~~~~~~~~~~~~~~~
>    compilation terminated.
>    make: *** [Makefile:162: /home/runner/work/bpf/bpf/tools/testing/selftests/bpf/bench.o] Error 1
>
> Thanks,
> Daniel
