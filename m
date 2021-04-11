Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2B535B334
	for <lists+bpf@lfdr.de>; Sun, 11 Apr 2021 12:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbhDKKsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Apr 2021 06:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhDKKsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Apr 2021 06:48:25 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E3FC061574
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 03:48:08 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d2so8474663ilm.10
        for <bpf@vger.kernel.org>; Sun, 11 Apr 2021 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SyuYJ6SWJz7EdQGQpJhE9GWp/Fnf//HKyKFHTv9MEkQ=;
        b=lscUaezelbfZGcSJ5zDjJlTrgAZHFtrWJBhMYeJcXmTEDT78QxhnN+HimK4tbT6YmU
         vxGs43hMQ7Gi/hYTnlg7RJUTILZ/BqsCNVLXbWe5oRpaIudUPAoDRsCnt4r8VgJlxxY4
         awKZcNwj82NO1YHM5LTWJPop/VYdxJBkXBFO+5kUamgtb27Rt89FuZ6tbcqmW2ZBbb9Q
         wZ+C49Zmrdt5ONWSpL5Vqyk4VPseHHLkMwrMGw4mm5RHJp1TDkyh1mgUGwWnm6bOkldQ
         sysRvC5NQYSCiOx77CPsmKBUxeygMoiMNXZvgoHoDJrWZnXnJMoe4CkR/VKW0OqNqIch
         cbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SyuYJ6SWJz7EdQGQpJhE9GWp/Fnf//HKyKFHTv9MEkQ=;
        b=cdS2niQAss5jHyXV9bPKw1v2vbdVBteIBZsNPd4bYQFgGCsh8IMtLsm5+sTYYDtC/E
         t9xNDOR0+K2vmkUN+IoU3jtIxHsk7OEcpNr5hlBOxik9V7diYybwOsYDkNYutf/Oqwp+
         SjaMp1xcc3kQPPs8Wi+OQm7VmlpzbmF/iBQvMdaMuvKMCL8pm7TlQH/3Q2uRpdXtpweI
         wXBviX3XOCWHb91BHsCBsEf5MTT+pHPqo2BaZ/mM0tzN6yps5N00HNbO5Ir9k4FOWDR1
         HO1wCthhg+Jjw4RAjrbst3btaO22gbG3EjJNiyeyE+yhYRFHAfExPAf27M0TMfk5Y+H5
         akCg==
X-Gm-Message-State: AOAM533wGqwgMgP2z37zoS/XwOX1KVSegUWOHqZ6HZZ9G8dCbKpStvPZ
        JpKJorFYGHn8HBugB+cEzkKwAbLUcE33N6gFcsMbgU9ARiD6Gw==
X-Google-Smtp-Source: ABdhPJz2yJpVKa5LGItYY0pBfvdbowShogzM9z8m10KhsCQB8UBCQHPFyfesolX6wswNAe53+F9NixuzhLBjibGex7o=
X-Received: by 2002:a92:603:: with SMTP id x3mr601624ilg.215.1618138088437;
 Sun, 11 Apr 2021 03:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210410164925.768741-1-yhs@fb.com> <20210410164940.770304-1-yhs@fb.com>
In-Reply-To: <20210410164940.770304-1-yhs@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 11 Apr 2021 12:47:32 +0200
Message-ID: <CA+icZUXzCpHWk8Vm5D4ZcCbdd9gqipVD5ALCw6SGTFbYfdJZiA@mail.gmail.com>
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

On Sat, Apr 10, 2021 at 6:49 PM Yonghong Song <yhs@fb.com> wrote:
>
> With clang compiler:
>   make -j60 LLVM=1 LLVM_IAS=1  <=== compile kernel
>   make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> the test_cpp build failed due to the failure:
>   warning: treating 'c-header' input as 'c++-header' when in C++ mode, this behavior is deprecated [-Wdeprecated]
>   clang-13: warning: cannot specify -o when generating multiple output files
>
> test_cpp compilation flag looks like:
>   clang++ -g -Og -rdynamic -Wall -I<...> ... \
>   -Dbpf_prog_load=bpf_prog_test_load -Dbpf_load_program=bpf_test_load_program \
>   test_cpp.cpp <...>/test_core_extern.skel.h <...>/libbpf.a <...>/test_stub.o \
>   -lcap -lelf -lz -lrt -lpthread -o <...>/test_cpp
>
> The clang++ compiler complains the header file in the command line.
> Let us remove the header file from the command line which is not intended
> any way, and this fixed the problem.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 6448c626498f..bbd61cc3889b 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -481,7 +481,7 @@ $(OUTPUT)/test_verifier: test_verifier.c verifier/tests.h $(BPFOBJ) | $(OUTPUT)
>  # Make sure we are able to include and link libbpf against c++.
>  $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
>         $(call msg,CXX,,$@)
> -       $(Q)$(CXX) $(CFLAGS) $^ $(LDLIBS) -o $@
> +       $(Q)$(CXX) $(CFLAGS) test_cpp.cpp $(BPFOBJ) $(LDLIBS) -o $@
>
>  # Benchmark runner
>  $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h
> --
> 2.30.2
>

NOTE: bpf-next might be different from my build-environment.

Yonghong, can you please re-test by adding explicitly CXX=g++ to your make line?

Here I have:

$ grep test_cpp make-log_tools-testing-selftests-bpf_clang_clang++.txt
1907:clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
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
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
-lcap -lelf -lz -lrt -lpthread -o
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp

This clang++ line does not include <...>/test_core_extern.skel.h ^^^

$ grep test_core_extern.skel.h
make-log_tools-testing-selftests-bpf_clang_clang++.txt
704:/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/sbin/bpftool
gen skeleton /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_co
re_extern.o > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
1592:/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/sbin/bpftool
gen skeleton /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/no_alu
32/test_core_extern.o >
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/no_alu32/test_core_extern.skel.h

Checking test_cpp:

$ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep extern
0000000000417e50 <cmp_externs>:
 417e54: 75 22                         jne     0x417e78 <cmp_externs+0x28>
 417e59: 75 10                         jne     0x417e6b <cmp_externs+0x1b>
 417e61: 75 21                         jne     0x417e84 <cmp_externs+0x34>
 417e69: 75 1e                         jne     0x417e89 <cmp_externs+0x39>
 417e87: eb f2                         jmp     0x417e7b <cmp_externs+0x2b>
 417e8c: eb ed                         jmp     0x417e7b <cmp_externs+0x2b>

$ /opt/llvm-toolchain/bin/llvm-objdump-12 -Dr test_cpp | grep core_extern
[ EMPTY ]

When compiled with g++ in an earlier setup this contained "core_extern".

With this version of your patchser it breaks *here* when using CXX=g++
(and uses /usr/bin/ld as linker):

g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
-I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
-I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
-I/home/dileks/src/linux-kernel/git/tools/lib
-I/home/dileks/src/linux-kernel/git/tools/include
-I/home/dileks/src/linux-kernel/git/tools/include/uapi
-I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
-Wno-unused-command-line-argument -Wno-format-security
-Dbpf_prog_load=bpf_prog_test_load
-Dbpf_load_program=bpf_test_load_program test_cpp.cpp
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
-lcap -lelf -lz -lrt -lpthread -o
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp

/usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
relocation R_X86_64_32 against `.rodata.str1.1' ca
n not be used when making a PIE object; recompile with -fPIE
collect2: error: ld returned 1 exit status
make: *** [Makefile:457:
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
Error 1

$ grep test_cpp ../make-log_tools-testing-selftests-bpf_clang_g++.txt
| grep test_core_extern.skel.h
[ EMPTY ]

As said I do NOT use bpf-next.

- Sedat -



- Sedat -
