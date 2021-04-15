Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B784235FEC2
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 02:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhDOAQh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 20:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhDOAQf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 20:16:35 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAE0C061574
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 17:16:13 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id o10so24128556ybb.10
        for <bpf@vger.kernel.org>; Wed, 14 Apr 2021 17:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ew285OdQiI0j80jrO2r3Y9KT8q9Omi3xd5UieLj/jpU=;
        b=umX9o/CHgbCtrpDFNXbjeCwpc9Cq9116sE8OREEkS/aoFZw9NlrWq/NLDGX8qBKQvd
         UQvGFKCK0kQRyBUdGDSghyMA7X/TfQTmwcO6kY0Jk+RcS1ZM9bCUBtnP6b0SCJrqVyfC
         ZgRS4NSzxDIDxy/dwsg8ICmYHKpJ58h3CkD+XBL/bl6y14FnvzkW2+AOErLlRILv5R8E
         dAGqlxNWMh5KB/VbMxLGnofeF23Qbb0YWHiacLsRcxQ6tumCKlRFhoXWBAWHxBdrjQBS
         hZuYIecWePahaFqLWuViaA5DgDt5Yn/rbpAh5p1qP845NVMI5p7GDwYsqc9k1UkO1Sx7
         2hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ew285OdQiI0j80jrO2r3Y9KT8q9Omi3xd5UieLj/jpU=;
        b=RMJDBXP6zB5DD06TXsElfS1gNc4HDUzVO/cJMFpmhWVaVcKq/cZ1wl6mepJvuWq6y/
         y2TkMEgkYPjnzsPOMeemJ4OHpLFQmuEAZuy98Zsrzdr6sq9a6VQbjKHh5S+Sa7comHnp
         pIG6sOS79rzibw5v28kRRyK+c763g4uC4BkjB4rAz3tEDf/34J0a6IA32vhr9oFy7Lnh
         lK4Z0dtUS1vMixiGwzgm4itsX4V87tDwIryY0eoJwxw6WnnS8leqLa4VtRRhGYnXFvnG
         cCQIn0HZCgoc/rn/lEuBiGfs0bl76SmkOXQXF4tvB04tarpRgF5DzzzzEnMvVvp+8Vbv
         QpZQ==
X-Gm-Message-State: AOAM532rr2JzdLoOas2btgJwTsncfQIkmxexJ8YYVvS0pdm/rvetiSXm
        rMcWW6+xvyynbfGSwQ5pQuvFvxb3E0idJwSG9+c=
X-Google-Smtp-Source: ABdhPJyXrnueHdj7UDy2iYxM3KsnoTAeepqZTFjW6u9NX3K0xNtp4/zwKKYcDE7IeJUVE4GQ3jTXSqFpFYM2+Vv1HXk=
X-Received: by 2002:a25:5b55:: with SMTP id p82mr838380ybb.510.1618445772232;
 Wed, 14 Apr 2021 17:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com> <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
 <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com>
 <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com> <CAKwvOdnJsQ-XDcjq=tbXL_iBeJYNk2h8VGwx-sSLWw_LRef6Qg@mail.gmail.com>
 <CAKwvOdkhJgCyEFpXUaMZP4NDho-2YWcNfmF+4P_MprcipB7Ycw@mail.gmail.com>
 <YHYApbcaa1faflw3@krava> <CAKwvOd=GfdEd_FZXY+yr9e1xzLaGFkvD4QLNb_52wTVFECHaKQ@mail.gmail.com>
 <YHbrlsN8UZPWwrzi@krava>
In-Reply-To: <YHbrlsN8UZPWwrzi@krava>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Apr 2021 17:16:01 -0700
Message-ID: <CAEf4Bzb2YcH+dwhMyd5gRsjmzwGjxjjdSbqHn6zkcesF8J7Jwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 6:18 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Apr 13, 2021 at 01:45:39PM -0700, Nick Desaulniers wrote:
>
> SNIP
>
> > > > >
> > > > > So I'm not sure precisely what's going on here.  I probably have to go
> > > > > digging around to understand tools/build/feature/ anyways.  With your
> > > > > v3 applied, I consistently see:
> > > > > No zlib found
> > > > > and yet, I certainly do have zlib on my host.
> > > > > https://stackoverflow.com/a/54558861
> > > >
> > > > Jiri, any tips on how to debug feature detection in
> > > > tools/build/feature/Makefile?
> > >
> > > for quick check, there's output file for each test, like:
> > >
> > >         [jolsa@krava feature]$ ls -l *.make.output
> > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-all.make.output
> > >         -rw-rw-r--. 1 jolsa jolsa 182 Apr  9 15:52 test-bionic.make.output
> > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-cplus-demangle.make.output
> > >         -rw-rw-r--. 1 jolsa jolsa 145 Apr  9 15:52 test-jvmti.make.output
> > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbabeltrace.make.output
> > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbpf.make.output
> > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libdebuginfod.make.output
> > >         -rw-rw-r--. 1 jolsa jolsa 193 Apr  9 15:52 test-libunwind-aarch64.make.output
> > >         -rw-rw-r--. 1 jolsa jolsa 177 Apr  9 15:52 test-libunwind-x86.make.output
> > >         [jolsa@krava feature]$ cat test-libunwind-aarch64.make.output
> > >         test-libunwind-aarch64.c:2:10: fatal error: libunwind-aarch64.h: No such file or directory
> > >             2 | #include <libunwind-aarch64.h>
> > >               |          ^~~~~~~~~~~~~~~~~~~~~
> > >         compilation terminated.
> > >         [jolsa@krava feature]$ cat test-libunwind-x86.make.output
> > >         test-libunwind-x86.c:2:10: fatal error: libunwind-x86.h: No such file or directory
> > >             2 | #include <libunwind-x86.h>
> > >               |          ^~~~~~~~~~~~~~~~~
> > >
> > > zlib should be done by:
> > >         [jolsa@krava feature]$ make test-zlib.bin
> > >         gcc  -MD -Wall -Werror -o test-zlib.bin test-zlib.c  > test-zlib.make.output 2>&1 -lz
> > >
> > >
> > > I can try to recreate, how do you build?
> >
> > See note above, I'm similarly running precisely:
> > $ make LLVM=1 LLVM_IAS=1 -j72 defconfig
> > $ make LLVM=1 LLVM_IAS=1 -j72 clean
> > $ make LLVM=1 LLVM_IAS=1 -j72 -C tools/testing/selftests/bpf
>
> for some reason I'm stuck with this error on latest bpf-next/master

did you build vmlinux image before building selftests? those enums
should come through vmlinux.h from up-to-date vmlinux

>
> $ make LLVM=1 LLVM_IAS=1 -C tools/testing/selftests/bpf
>
> make[1]: Nothing to be done for 'docs'.
>   CLNG-BPF [test_maps] test_lwt_ip_encap.o
>   CLNG-BPF [test_maps] test_tc_edt.o
>   CLNG-BPF [test_maps] local_storage.o
> progs/local_storage.c:41:15: error: use of undeclared identifier 'BPF_MAP_TYPE_TASK_STORAGE'; did you mean 'BPF_MAP_TYPE_SK_STORAGE'?
>         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>                      BPF_MAP_TYPE_SK_STORAGE
> /home/jolsa/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
> #define __uint(name, val) int (*name)[val]
>                                       ^
> /home/jolsa/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h:10317:2: note: 'BPF_MAP_TYPE_SK_STORAGE' declared here
>         BPF_MAP_TYPE_SK_STORAGE = 24,
>         ^
> 1 error generated.
> make: *** [Makefile:448: /home/jolsa/linux/tools/testing/selftests/bpf/local_storage.o] Error 1
> make: Leaving directory '/home/jolsa/linux/tools/testing/selftests/bpf'
>
>
> jirka
>
