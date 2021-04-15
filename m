Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843CB36108A
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 18:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhDOQ42 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 12:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbhDOQ41 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Apr 2021 12:56:27 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59062C061574
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 09:56:04 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id o16so27898513ljp.3
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2YpJsG3cS8lt/XF75J73wPnuxvKECBRtOYex18GWDLo=;
        b=L/51qLwoYTCDbyrV4BDrBi6XtnRkPt7Em30tyZ2ObTg+bhhT5S3Afh9RLcRZkt0fLV
         DDH2KwkHwegDOa6ygr+tI9AbBDVhaLHlzSgmtLxEqrxkkq+xQwavXz0fI+PzU/PX8ADp
         lvPEUY4UaLYRi4NJz5KumZgv0z7SNZZ7m5jHhlX+I+HlhyAgIdkE6gU4+2BEBmlanbIL
         5zDk4xldLp1yyJqnJY2WvCUlDu+t+WVylhqOGMZiUotkOTzFrWPXJ1aM5nqr7BWu+rhg
         iUqXVxdAeiiaJtPEmijHdQwfVeMedVGZyZbt6NapE/AYFGffNeAnCHbPADhEgWmFDpre
         Ez5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2YpJsG3cS8lt/XF75J73wPnuxvKECBRtOYex18GWDLo=;
        b=cMYPC9bQVXZVC6y1499NMeV0LtoYFRPariPgtyfECM1IobTjTqdr8WjkxIj+ETm/Zr
         g6saQ8uYWZNrs9r56XzuYXKy5ugIeI61jUlsC8y+PQqgm5l09IlcBtZ5cJCX/SRWiT9Y
         OWpY9QApPBi0cI5fPLKxbQZ5/hUrF39GnNdf1/Z3OnrbwtcZcE+/irEzXGI7nBjNEG9A
         oytnLbgpOM89AhzAIP7RwWnADPd2jpoCvKky4mUVRCdNf4Epy7JEM7fNjIhDlzX/woOO
         XqxM4GIW233ecnHzyNRrLIcWAwO2f+SrEZPJMRPipN10ecvb3fjFlcjeQOtZidB0WhiX
         bqaw==
X-Gm-Message-State: AOAM531aPB2mfPaJ2Dlf92NnmI74PGKYuWPWSKjriB4bQ3kqD+O3Xo/N
        1yK6OAVcTsAs1pm4dDNkoCi7+5+OVUbFaA6vJlzkyw==
X-Google-Smtp-Source: ABdhPJyBm2fLW7g4/jQbgmzuQrz+OAUAJVA8dWD3VJ+LqlRU0K2IT+/jFnro5L/OPS9TyyftOHDNCnN6IKxyes9cTo0=
X-Received: by 2002:a2e:968a:: with SMTP id q10mr101050lji.0.1618505762643;
 Thu, 15 Apr 2021 09:56:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com> <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
 <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com>
 <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com> <CAKwvOdnJsQ-XDcjq=tbXL_iBeJYNk2h8VGwx-sSLWw_LRef6Qg@mail.gmail.com>
 <CAKwvOdkhJgCyEFpXUaMZP4NDho-2YWcNfmF+4P_MprcipB7Ycw@mail.gmail.com>
 <YHYApbcaa1faflw3@krava> <CAKwvOd=GfdEd_FZXY+yr9e1xzLaGFkvD4QLNb_52wTVFECHaKQ@mail.gmail.com>
 <YHbrlsN8UZPWwrzi@krava> <CAEf4Bzb2YcH+dwhMyd5gRsjmzwGjxjjdSbqHn6zkcesF8J7Jwg@mail.gmail.com>
 <YHg+QFL0O5eOHD+7@krava>
In-Reply-To: <YHg+QFL0O5eOHD+7@krava>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 15 Apr 2021 09:55:50 -0700
Message-ID: <CAKwvOdmozSv4Zb1F_gn+__OZgRmkCsBfkH3dGzVR+nQr0RrePQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Sedat Dilek <sedat.dilek@gmail.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 15, 2021 at 6:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 14, 2021 at 05:16:01PM -0700, Andrii Nakryiko wrote:
> > On Wed, Apr 14, 2021 at 6:18 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Apr 13, 2021 at 01:45:39PM -0700, Nick Desaulniers wrote:
> > >
> > > SNIP
> > >
> > > > > > >
> > > > > > > So I'm not sure precisely what's going on here.  I probably have to go
> > > > > > > digging around to understand tools/build/feature/ anyways.  With your
> > > > > > > v3 applied, I consistently see:
> > > > > > > No zlib found
> > > > > > > and yet, I certainly do have zlib on my host.
> > > > > > > https://stackoverflow.com/a/54558861
> > > > > >
> > > > > > Jiri, any tips on how to debug feature detection in
> > > > > > tools/build/feature/Makefile?
> > > > >
> > > > > for quick check, there's output file for each test, like:
> > > > >
> > > > >         [jolsa@krava feature]$ ls -l *.make.output
> > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-all.make.output
> > > > >         -rw-rw-r--. 1 jolsa jolsa 182 Apr  9 15:52 test-bionic.make.output
> > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-cplus-demangle.make.output
> > > > >         -rw-rw-r--. 1 jolsa jolsa 145 Apr  9 15:52 test-jvmti.make.output
> > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbabeltrace.make.output
> > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbpf.make.output
> > > > >         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libdebuginfod.make.output
> > > > >         -rw-rw-r--. 1 jolsa jolsa 193 Apr  9 15:52 test-libunwind-aarch64.make.output
> > > > >         -rw-rw-r--. 1 jolsa jolsa 177 Apr  9 15:52 test-libunwind-x86.make.output
> > > > >         [jolsa@krava feature]$ cat test-libunwind-aarch64.make.output
> > > > >         test-libunwind-aarch64.c:2:10: fatal error: libunwind-aarch64.h: No such file or directory
> > > > >             2 | #include <libunwind-aarch64.h>
> > > > >               |          ^~~~~~~~~~~~~~~~~~~~~
> > > > >         compilation terminated.
> > > > >         [jolsa@krava feature]$ cat test-libunwind-x86.make.output
> > > > >         test-libunwind-x86.c:2:10: fatal error: libunwind-x86.h: No such file or directory
> > > > >             2 | #include <libunwind-x86.h>
> > > > >               |          ^~~~~~~~~~~~~~~~~
> > > > >
> > > > > zlib should be done by:
> > > > >         [jolsa@krava feature]$ make test-zlib.bin
> > > > >         gcc  -MD -Wall -Werror -o test-zlib.bin test-zlib.c  > test-zlib.make.output 2>&1 -lz
> > > > >
> > > > >
> > > > > I can try to recreate, how do you build?
> > > >
> > > > See note above, I'm similarly running precisely:
> > > > $ make LLVM=1 LLVM_IAS=1 -j72 defconfig
> > > > $ make LLVM=1 LLVM_IAS=1 -j72 clean
> > > > $ make LLVM=1 LLVM_IAS=1 -j72 -C tools/testing/selftests/bpf
> > >
> > > for some reason I'm stuck with this error on latest bpf-next/master
> >
> > did you build vmlinux image before building selftests? those enums
> > should come through vmlinux.h from up-to-date vmlinux
>
> it was there.. but I found the clang/lld I compiled can't link properly,
> which is probably unrelated to the error below, but I need to solve it
> first ;-)

Do you have more info about what command you're running, or what error
you're observing?  The kernel itself is not linking for you?


>
> jirka
>
> >
> > >
> > > $ make LLVM=1 LLVM_IAS=1 -C tools/testing/selftests/bpf
> > >
> > > make[1]: Nothing to be done for 'docs'.
> > >   CLNG-BPF [test_maps] test_lwt_ip_encap.o
> > >   CLNG-BPF [test_maps] test_tc_edt.o
> > >   CLNG-BPF [test_maps] local_storage.o
> > > progs/local_storage.c:41:15: error: use of undeclared identifier 'BPF_MAP_TYPE_TASK_STORAGE'; did you mean 'BPF_MAP_TYPE_SK_STORAGE'?
> > >         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> > >                      ^~~~~~~~~~~~~~~~~~~~~~~~~
> > >                      BPF_MAP_TYPE_SK_STORAGE
> > > /home/jolsa/linux/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:13:39: note: expanded from macro '__uint'
> > > #define __uint(name, val) int (*name)[val]
> > >                                       ^
> > > /home/jolsa/linux/tools/testing/selftests/bpf/tools/include/vmlinux.h:10317:2: note: 'BPF_MAP_TYPE_SK_STORAGE' declared here
> > >         BPF_MAP_TYPE_SK_STORAGE = 24,
> > >         ^
> > > 1 error generated.
> > > make: *** [Makefile:448: /home/jolsa/linux/tools/testing/selftests/bpf/local_storage.o] Error 1
> > > make: Leaving directory '/home/jolsa/linux/tools/testing/selftests/bpf'
> > >
> > >
> > > jirka
> > >
> >
>


-- 
Thanks,
~Nick Desaulniers
