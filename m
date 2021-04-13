Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF3035E7B8
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 22:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348271AbhDMUqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 16:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhDMUqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 16:46:12 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BB4C061574
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 13:45:52 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id e14so16711102lfn.11
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 13:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4IA+sQlmaJfycHTcpTBUe9inc5pY7EO3TnLX/gUs0Y=;
        b=faWiALq3i1HWXQQZj9QNmShFSKjMDap7Hv0RKhAa6V01sn3A5TAKS+MsTtGWPWOAbU
         PO3EyhIscqQ439BbNjlYf4vv/BGzk/GlAVyW8A/bCWum6QSykC6hfGQ521sBdAKz+t/R
         vXRHQ7d501beKqPHoP8R86OY73c0q8MZQcgKX9b/Enl5TdrY8ngUPyxRhaTRW42pfteC
         /vEX8wH5ejd2TyA3gcMgI7vedEq6/zmBRuzPhwiZy2/yQ18tIySc8ToCZbK3C03yKLnl
         1EKDVFFbW2KvXDmvDwRWa+2xF++gwVMZDZvOjQ2BLxpF3v0Th4mpjdg/T1gRcWpiAzV2
         gY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4IA+sQlmaJfycHTcpTBUe9inc5pY7EO3TnLX/gUs0Y=;
        b=R3pvKtQySto5PApK+G8hJGQWy7/7Ni9Fe38HEtpyzWaXsKjlnRgatUiakA7ULC9Yju
         OpCuNS8b8ku6xtEvw6LwL+YYbv/PAKhmg4VVgWPvvTWd0CuoRjBF7qGdc+srB1yYTguo
         3mVt/7wOdzdl4fyZPwXPgXQ93lH3YDbgVae9fIKvgzDkjCsc7ti2DsNt3Y2IQ8zf/BDG
         jVANezteItuneHfPRcWlajlIFK7NaH6NAaS4WAE17So98ESsMzBjqVaSStRW4HVypKJA
         MC0FoPbZFm1H+nG7BhS+i0YmamhTmswDPkIjkM/7RoAhqiIH0vADCnpDV0PR+Q8WbW1Z
         5YoQ==
X-Gm-Message-State: AOAM533FPSKR/y80hC/4iv533eT42QMEGQc/UNIhvqHzziSmzjBKOfn8
        Qx6z8wCEEUX81vLgA2xpOQU/n/QJUPmBguzbBCazZw==
X-Google-Smtp-Source: ABdhPJxzN56thD16ZKJLzktv+IcFmKFvfq79SXV7bqUOEoXJPSnB1KhotajjpVO5nitOZxnxW33BwDREW7WwE1KA7KE=
X-Received: by 2002:a19:ac09:: with SMTP id g9mr7357836lfc.547.1618346750528;
 Tue, 13 Apr 2021 13:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142905.266942-1-yhs@fb.com> <CAKwvOdkTUFUwq0Uwi4D9-Z9nbg1FfaP1P2oiBsxNn3+ikT9MwA@mail.gmail.com>
 <CAKwvOdkFWe76ggKrLeckS+mzmyQeq6eJBnkQM1bKgEGQBCspSA@mail.gmail.com>
 <e5f5f6b3-64e6-7068-ca72-9f06f3ffda54@fb.com> <CAKwvOdnJsQ-XDcjq=tbXL_iBeJYNk2h8VGwx-sSLWw_LRef6Qg@mail.gmail.com>
 <CAKwvOdkhJgCyEFpXUaMZP4NDho-2YWcNfmF+4P_MprcipB7Ycw@mail.gmail.com> <YHYApbcaa1faflw3@krava>
In-Reply-To: <YHYApbcaa1faflw3@krava>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 13 Apr 2021 13:45:39 -0700
Message-ID: <CAKwvOd=GfdEd_FZXY+yr9e1xzLaGFkvD4QLNb_52wTVFECHaKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Sedat Dilek <sedat.dilek@gmail.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 13, 2021 at 1:36 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Apr 13, 2021 at 11:56:33AM -0700, Nick Desaulniers wrote:
> > On Tue, Apr 13, 2021 at 11:46 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Mon, Apr 12, 2021 at 5:31 PM Yonghong Song <yhs@fb.com> wrote:
> > > >
> > > >
> > > >
> > > > On 4/12/21 5:02 PM, Nick Desaulniers wrote:
> > > > > On Mon, Apr 12, 2021 at 4:58 PM Nick Desaulniers
> > > > > <ndesaulniers@google.com> wrote:
> > > > >>
> > > > >> On Mon, Apr 12, 2021 at 7:29 AM Yonghong Song <yhs@fb.com> wrote:
> > > > >>>
> > > > >>> To build kernel with clang, people typically use
> > > > >>>    make -j60 LLVM=1 LLVM_IAS=1
> > > > >>> LLVM_IAS=1 is not required for non-LTO build but
> > > > >>> is required for LTO build. In my environment,
> > > > >>> I am always having LLVM_IAS=1 regardless of
> > > > >>> whether LTO is enabled or not.
> > > > >>>
> > > > >>> After kernel is build with clang, the following command
> > > > >>> can be used to build selftests with clang:
> > > > >>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1

^ note below

> > > > >>
> > > > >> Thank you for the series Yonghong.  When I test the above command with
> > > > >> your series applied, I observe:
> > > > >> tools/include/tools/libc_compat.h:11:21: error: static declaration of
> > > > >> 'reallocarray' follows non-static declaration
> > > > >> static inline void *reallocarray(void *ptr, size_t nmemb, size_t size)
> > > > >>                      ^
> > > > >> /usr/include/stdlib.h:559:14: note: previous declaration is here
> > > > >> extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
> > > > >>               ^
> > > > >> so perhaps the detection of
> > > > >> COMPAT_NEED_REALLOCARRAY/feature-reallocarray is incorrect?
> > > > >
> > > > > Is this related to _DEFAULT_SOURCE vs _GNU_SOURCE.  via man 3 reallocarray:
> > > > >         reallocarray():
> > > > >             Since glibc 2.29:
> > > > >                 _DEFAULT_SOURCE
> > > > >             Glibc 2.28 and earlier:
> > > > >                 _GNU_SOURCE
> > > > >
> > > >
> > > > You can try the following patch to see whether it works or not.
> > > >
> > > > diff --git a/tools/build/feature/test-reallocarray.c
> > > > b/tools/build/feature/test-reallocarray.c
> > > > index 8f6743e31da7..500cdeca07a7 100644
> > > > --- a/tools/build/feature/test-reallocarray.c
> > > > +++ b/tools/build/feature/test-reallocarray.c
> > > > @@ -1,5 +1,5 @@
> > > >   // SPDX-License-Identifier: GPL-2.0
> > > > -#define _GNU_SOURCE
> > > > +#define _DEFAULT_SOURCE
> > > >   #include <stdlib.h>
> > > >
> > > >   int main(void)
> > > > @@ -7,4 +7,4 @@ int main(void)
> > > >          return !!reallocarray(NULL, 1, 1);
> > > >   }
> > > >
> > > > -#undef _GNU_SOURCE
> > > > +#undef _DEFAULT_SOURCE
> > >
> > > Yeah, I had tried that. No luck though; same error message.  Even:
> > >
> > > $ cat foo.c
> > > #define _DEFAULT_SOURCE
> > > #include <stdlib.h>
> > > void *reallocarray(void *ptr, size_t nmemb, size_t size) { return (void*)0; };
> > > $ clang -c foo.c
> > > $ echo $?
> > > 0
> > >
> > > So I'm not sure precisely what's going on here.  I probably have to go
> > > digging around to understand tools/build/feature/ anyways.  With your
> > > v3 applied, I consistently see:
> > > No zlib found
> > > and yet, I certainly do have zlib on my host.
> > > https://stackoverflow.com/a/54558861
> >
> > Jiri, any tips on how to debug feature detection in
> > tools/build/feature/Makefile?
>
> for quick check, there's output file for each test, like:
>
>         [jolsa@krava feature]$ ls -l *.make.output
>         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-all.make.output
>         -rw-rw-r--. 1 jolsa jolsa 182 Apr  9 15:52 test-bionic.make.output
>         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-cplus-demangle.make.output
>         -rw-rw-r--. 1 jolsa jolsa 145 Apr  9 15:52 test-jvmti.make.output
>         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbabeltrace.make.output
>         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libbpf.make.output
>         -rw-rw-r--. 1 jolsa jolsa   0 Apr  8 20:25 test-libdebuginfod.make.output
>         -rw-rw-r--. 1 jolsa jolsa 193 Apr  9 15:52 test-libunwind-aarch64.make.output
>         -rw-rw-r--. 1 jolsa jolsa 177 Apr  9 15:52 test-libunwind-x86.make.output
>         [jolsa@krava feature]$ cat test-libunwind-aarch64.make.output
>         test-libunwind-aarch64.c:2:10: fatal error: libunwind-aarch64.h: No such file or directory
>             2 | #include <libunwind-aarch64.h>
>               |          ^~~~~~~~~~~~~~~~~~~~~
>         compilation terminated.
>         [jolsa@krava feature]$ cat test-libunwind-x86.make.output
>         test-libunwind-x86.c:2:10: fatal error: libunwind-x86.h: No such file or directory
>             2 | #include <libunwind-x86.h>
>               |          ^~~~~~~~~~~~~~~~~
>
> zlib should be done by:
>         [jolsa@krava feature]$ make test-zlib.bin
>         gcc  -MD -Wall -Werror -o test-zlib.bin test-zlib.c  > test-zlib.make.output 2>&1 -lz
>
>
> I can try to recreate, how do you build?

See note above, I'm similarly running precisely:
$ make LLVM=1 LLVM_IAS=1 -j72 defconfig
$ make LLVM=1 LLVM_IAS=1 -j72 clean
$ make LLVM=1 LLVM_IAS=1 -j72 -C tools/testing/selftests/bpf

-- 
Thanks,
~Nick Desaulniers
