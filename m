Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C12535B655
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhDKRcC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 13:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKRcC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Apr 2021 13:32:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83629C061574
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 10:31:45 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v123so4208203ioe.10
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 10:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PRG4u+iq0N4iJAYwN08fmE8waBM2qcHrIde26vrhjlQ=;
        b=XQfL+N7EBYB7KiSsrFEIAWa65Q/MDoGed8I0FimU7Nl+EHmRhyWb7heurIuLms5SZM
         jTQiiI08eKk2K5nlg+xjIrUlhpMWWjvY/r5MhJOyVMzUHnUsQGydo2h5TDZRYMmuTELb
         B2hPj507PeMZ5b3JKmG/dPexxbmyaLOZuGNqazxJXYk8W4Bwzas3cyDqU8FdOMaXR4qz
         fZG7LhYH/CEXcEH4/UHAssh3S9NI2ZjRv3ZXPnaA8GLWx1/O7NrmORT4WjLrK95ea1W+
         okDmRJ3YEVzZugnrJjvHd9D/vgZyDEB1ALOiLyQurSxURX5ZV6S2C1ebYHDhy82mrqA2
         Mjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PRG4u+iq0N4iJAYwN08fmE8waBM2qcHrIde26vrhjlQ=;
        b=tYN3bIcctx/R0XDI9XUtl+LTiYYRh7GcnAa+mKSlVpqHheL2GIkd1EhIJ7t8gM1qPe
         NmrVRk3hN8IOgloUFcIorJlw01PE91+cJpYDXBhmLzHH7GEJU7o0v0VOnGPKjLTjeKrA
         UWpIttffu8+oRhGdH08k0qohyBt2Fo/lE5qinlD7IcVpGQgHPvPWUrtcSGfiSRDAWx6L
         3XvO9tKbRcw/MLPa52qWb6LSKG53IFKG6/GqzMy4yhZ7lEWORQgCHDKnVOIYYqmd98OZ
         Q5k3Dj6zL3MAUFTnFJ9qSLtGCkprGJ/m6by9brl5UyHhAjo5GtAtPCtvtDGO6adCCq9U
         kGCA==
X-Gm-Message-State: AOAM530LVrjDq45XmimiN7O+h/vSW9ddbnAye4SlbXX6gxbBL5SHAggJ
        XkcEG6fpB8p2bQ34X3xLbZcCUpgNJvfXp0tJXaqb7aXHvqxW2m77
X-Google-Smtp-Source: ABdhPJy48oxXuFokOfSPpcCB62yUigbY37GyBgMEoAs4keajeo9ryufnJnU2bDv8J77JtMPd89UHwFKE2jRmMvIpK6s=
X-Received: by 2002:a05:6638:2605:: with SMTP id m5mr19497229jat.97.1618162304545;
 Sun, 11 Apr 2021 10:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164940.770304-1-yhs@fb.com>
 <CA+icZUXzCpHWk8Vm5D4ZcCbdd9gqipVD5ALCw6SGTFbYfdJZiA@mail.gmail.com> <7c82c0f5-2a96-7a5c-b090-f26c9351786c@fb.com>
In-Reply-To: <7c82c0f5-2a96-7a5c-b090-f26c9351786c@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 11 Apr 2021 19:31:08 +0200
Message-ID: <CA+icZUWwSg4Nd+AzAMx8Os4iAfs=40zeoYn0eVKg3Cy7fB5Cow@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: fix test_cpp compilation
 failure with clang
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        kernel-team@fb.com, Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Apr 11, 2021 at 7:20 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/11/21 3:47 AM, Sedat Dilek wrote:
> > On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> With clang compiler:
> >>    make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
> >>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> >> the test_cpp build failed due to the failure:
> >>    warning: treating 'c-header' input as 'c++-header' when in C++ mode, this behavior is deprecated [-Wdeprecated]
> >>    clang-13: warning: cannot specify -o when generating multiple output files
> >>
> >> test_cpp compilation flag looks like:
> >>    clang++ -g -Og -rdynamic -Wall -I<...> ... \
> >>    -Dbpf_prog_load=bpf_prog_test_load -Dbpf_load_program=bpf_test_load_program \
> >>    test_cpp.cpp <...>/test_core_extern.skel.h <...>/libbpf.a <...>/test_stub.o \
> >>    -lcap -lelf -lz -lrt -lpthread -o <...>/test_cpp
> >>
> >> The clang++ compiler complains the header file in the command line.
> >> Let us remove the header file from the command line which is not intended
> >> any way, and this fixed the problem.
> >>
> >> Signed-off-by: Yonghong Song <yhs@fb.com>
> >> ---
> >>   tools/testing/selftests/bpf/Makefile | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> >> index 6448c626498f..bbd61cc3889b 100644
> >> --- a/tools/testing/selftests/bpf/Makefile
> >> +++ b/tools/testing/selftests/bpf/Makefile
> >> @@ -481,7 +481,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
> >>   # Make sure we are able to include and link libbpf against c++.
> >>   $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
> >>          $(call msg,CXX,,$@)
> >> -       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
> >> +       $(Q)$(CXX) $(CFLAGS) test_cpp.cpp $(BPFOBJ) $(LDLIBS) -o $@
> >>
> >>   # Benchmark runner
> >>   $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
> >> --
> >> 2.30.2
> >>
> >
> > NOTE: bpf-next might be different from my build-environment.
> >
> > Yonghong, can you please re-test by adding explicitly CXX=g++ to your make line?
> >
> > Here I have:
> >
> > $ grep test_cpp make-log_tools-testing-selftests-bpf_clang_clang++.txt
> > 1907:clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include
> > -I/home/dileks/src/linux-kernel/git/include/generated
> > -I/home/dileks/src/linux-kernel/git/tools/lib
> > -I/home/dileks/src/linux-kernel/git/tools/include
> > -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> > -Wno-unused-command-line-argument -Wno-format-security
> > -Dbpf_prog_load=bpf_prog_test_load
> > -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> > -lcap -lelf -lz -lrt -lpthread -o
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> >
> > This clang++ line does not include <...>/test_core_extern.skel.h ^^^
> >
> > $ grep test_core_extern.skel.h
> > make-log_tools-testing-selftests-bpf_clang_clang++.txt
> > 704:/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/sbin/bpftool
> > gen skeleton /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_co
> > re_extern.o > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
> > 1592:/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/sbin/bpftool
> > gen skeleton /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/no_alu
> > 32/test_core_extern.o >
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/no_alu32/test_core_extern.skel.h
> >
> > Checking test_cpp:
> >
> > $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep extern
> > 0000000000417e50 <cmp_externs>:
> >   417e54: 75 22                         jne     0x417e78 <cmp_externs+0x28>
> >   417e59: 75 10                         jne     0x417e6b <cmp_externs+0x1b>
> >   417e61: 75 21                         jne     0x417e84 <cmp_externs+0x34>
> >   417e69: 75 1e                         jne     0x417e89 <cmp_externs+0x39>
> >   417e87: eb f2                         jmp     0x417e7b <cmp_externs+0x2b>
> >   417e8c: eb ed                         jmp     0x417e7b <cmp_externs+0x2b>
> >
> > $ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern
> > [ EMPTY ]
> >
> > When compiled with g++ in an earlier setup this contained "core_extern".
> >
> > With this version of your patchser it breaks *here* when using CXX=g++
> > (and uses /usr/bin/ld as linker):
> >
> > g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
> > pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
> > -I/home/dileks/src/linux-kernel/git/tools/lib
> > -I/home/dileks/src/linux-kernel/git/tools/include
> > -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> > -Wno-unused-command-line-argument -Wno-format-security
> > -Dbpf_prog_load=bpf_prog_test_load
> > -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> > -lcap -lelf -lz -lrt -lpthread -o
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> >
> > /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
> > relocation R_X86_64_32 against `.rodata.str1.1' ca
> > n not be used when making a PIE object; recompile with -fPIE
> > collect2: error: ld returned 1 exit status
> > make: *** [Makefile:457:
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
> > Error 1
>
> I cannot reproduce the issue with g++ with bpf-next, my command line is
>
> g++ -g -Og -rdynamic -Wall
> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf
> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/include
> -I/home/yhs/work/bpf-next/include/generated
> -I/home/yhs/work/bpf-next/tools/lib
> -I/home/yhs/work/bpf-next/tools/include
> -I/home/yhs/work/bpf-next/tools/include/uapi
> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf
> -Wno-unused-command-line-argument -Wno-format-security
> -Dbpf_prog_load=bpf_prog_test_load
> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> -lcap -lelf -lz -lrt -lpthread -o
> /home/yhs/work/bpf-next/tools/testing/selftests/bpf/test_cpp
>
> I modified to
> g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> -I/home/yhs/work/bpf-next/tools/testing/selftests/bpf ...
> and cannot reproduce the issue.
> The macro HAVE_GENHDR is only effect for test_verifier.
>
>
> Could you try to run the above g++ command by adding
> test_core_extern.skel.h back, something like
>
>  > g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
>  > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>  > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
>  > pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
>  > -I/home/dileks/src/linux-kernel/git/tools/lib
>  > -I/home/dileks/src/linux-kernel/git/tools/include
>  > -I/home/dileks/src/linux-kernel/git/tools/include/uapi
>  > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
>  > -Wno-unused-command-line-argument -Wno-format-security
>  > -Dbpf_prog_load=bpf_prog_test_load
>  > -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
>  > test_core_extern.skel.h
>  >
> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
>  > -lcap -lelf -lz -lrt -lpthread -o
>  > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
>
> The issue could be somewhere else?
>

I have seen all that *skel* was reworked in bpf-next, so this is an issue here.

Adding test_core_extern.skel.h:

$ cd /tools/testing/selftests/bpf/

$ file test_core_extern.skel.h
test_core_extern.skel.h: C source, ASCII text

$ g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
-I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
-I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include
-I/home/dileks/src/linux-kernel/git/include/generated
-I/home/dileks/src/linux-kernel/git/tools/lib
-I/home/dileks/src/linux-kernel/git/tools/include
-I/home/dileks/src/linux-kernel/git/tools/include/uapi
-I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
-Wno-unused-command-line-argument -Wno-format-security
-Dbpf_prog_load=bpf_prog_test_load
-Dbpf_load_program=bpf_test_load_program test_cpp.cpp
test_core_extern.skel.h
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
-lcap -lelf -lz -lrt -lpthread -o
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
/usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
relocation R_X86_64_32 against `.rodata.str1.1' ca
n not be used when making a PIE object; recompile with -fPIE
collect2: error: ld returned 1 exit status

Write that test_cpp.cpp in C :-)?

BTW, did you check (llvm-)objdump output?

$ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern

- Sedat -

> >
> > $ grep test_cpp ../make-log_tools-testing-selftests-bpf_clang_g++.txt
> > | grep test_core_extern.skel.h
> > [ EMPTY ]
> >
> > As said I do NOT use bpf-next.
> >
> > - Sedat -
> >
> >
> >
> > - Sedat -
> >
