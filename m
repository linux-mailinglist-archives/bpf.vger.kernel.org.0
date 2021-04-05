Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485C53546C7
	for <lists+bpf@lfdr.de>; Mon,  5 Apr 2021 20:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhDESc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Apr 2021 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhDESc4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Apr 2021 14:32:56 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EA9C061756;
        Mon,  5 Apr 2021 11:32:49 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r17so3139688ilt.0;
        Mon, 05 Apr 2021 11:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8+8F1JUdxN4l+S06vv3JOUagAiFzQHlDb4tnstiViNs=;
        b=Tr/ZHZLBXir3Fv6qY8eEypp2KOIOQghIYSemLZf+SK7lMogUpChwlVxa3O/mANjNS6
         JGnNslZvIMp1L9ce7K51fi4+Mn2GZu3dHecY/QiywDvLREgkcTx+RhCx28yUMXk9OgbJ
         VAuhI5i5X+Dk8RS5xtX5RdVNI8XcZmWKQSpnjBY/x9PpQ+c9tstdAXYyyucRKO2hzuj5
         Zaq4YuOm+/A58z0Ap5LuH3nUgdELgyxC9iWW5HYBAryWi6NSDlF9ZO2IgyKrSUCSAmCm
         1wlSpROEa2An86znkIKI/hQZfOomHOMIJ03zQ3Ou6c87Y/mRFghLOrFcHPeovqVYzjAN
         7WDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8+8F1JUdxN4l+S06vv3JOUagAiFzQHlDb4tnstiViNs=;
        b=Q0iwJBfM7EVIxzKDMAZERgNhOx8ckpmx4343Dk7lKtR3hYP36n+iIazVtVfiMExV5I
         4zPvnTtzoLo3VXd8BctNMif+eFCazdb4uNNkeoo5ynRa9mWlQZmkNFGdieuH9GHyinCj
         jdr/x0/58im33rZ4K9SWRgLQr8iTQp1QrESsqvXseeWl9ilEGROzScJBsvdQR1FKid6N
         2Y9dzDYutc1pdsLox6sgqO8HG1u24xVYSycoZPs8CtPlpAm5ejxuw5fBZzEjOu6xG+R+
         1uv16dqaGkcInB6X7tJojO2i6mxvlz6NMaFl1USrJ6x9oKYeFQjiLWY3FuuSWhn2kKuY
         ZYzw==
X-Gm-Message-State: AOAM533l8dUK+/6vOartVNDKlHq0XrNQnF+bzHeoEwujHZY9ODAO6Wbx
        kynMgX+R4slpEYqLQG/mYJzfQtETVIBVfKA2aD0=
X-Google-Smtp-Source: ABdhPJyTzqF6m3sYdvQGdAt/aHgRe92TvX/YBUfTNree8P7yTy/ptViTx8C5k7ZgMNHvWneMz0ZMAM2tNO2rRdWJAuo=
X-Received: by 2002:a92:c5c6:: with SMTP id s6mr20235248ilt.186.1617647568885;
 Mon, 05 Apr 2021 11:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
 <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com> <CA+icZUV4fw5GNXFnyOjvajkVFdPhkOrhr3rn5OrAKGujpSrmgQ@mail.gmail.com>
 <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com>
 <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com> <CA+icZUVb_J95Gk2Kf0i8waL6TDfJ2n9JrGbNK_dsN1n8HdcoXQ@mail.gmail.com>
 <458faf4c-7681-13eb-023d-c51f582bfec6@fb.com> <CA+icZUVcQ+vQjc0VavetA3s6jzNhC20dU4Sa9ApBLNXbY=w5wA@mail.gmail.com>
 <b4963c83-df8a-630a-cc78-c72f6a388823@fb.com>
In-Reply-To: <b4963c83-df8a-630a-cc78-c72f6a388823@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 5 Apr 2021 20:32:15 +0200
Message-ID: <CA+icZUVd64WJkX+adNKpGbL+=g-Yn-D-_XwqW_GOt9vp0Fpamw@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf@vger.kernel.org,
        David Blaikie <dblaikie@gmail.com>, kernel-team@fb.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 5, 2021 at 6:17 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/4/21 11:55 PM, Sedat Dilek wrote:
> > On Mon, Apr 5, 2021 at 4:24 AM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 4/4/21 10:25 AM, Sedat Dilek wrote:
> >>> On Sun, Apr 4, 2021 at 6:40 PM Yonghong Song <yhs@fb.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 4/4/21 5:46 AM, Sedat Dilek wrote:
> >> [...]
> >>>>> Next build-error:
> >>>>>
> >>>>> g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> >>>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> >>>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
> >>>>> pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
> >>>>> -I/home/dileks/src/linux-kernel/git/tools/lib
> >>>>> -I/home/dileks/src/linux-kernel/git/tools/include
> >>>>> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> >>>>> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> >>>>> -Dbpf_prog_load=bpf_prog_test_load
> >>>>> -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
> >>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
> >>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> >>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
> >>>>> -lcap -lelf -lz -lrt -lpthread -o
> >>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> >>>>> /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
> >>>>> relocation R_X86_64_32 against `.rodata.str1.1' ca
> >>>>> n not be used when making a PIE object; recompile with -fPIE
> >>>>> collect2: error: ld returned 1 exit status
> >>>>> make: *** [Makefile:455:
> >>>>> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
> >>>>> Error 1
> >>>>> make: Leaving directory
> >>>>> '/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf'
> >>>>>
> >>>>> LOL, I was not aware that there is usage of *** CXX*** in tools
> >>>>> directory (see g++ line and /usr/bin/ld ?).
> >>>>>
> >>>>> So, I changed my $MAKE_OPTS to use "CXX=clang++".
> >>>>
> >>>> In kernel, if LLVM=1 is set, we have:
> >>>>
> >>>> ifneq ($(LLVM),)
> >>>> HOSTCC  = clang
> >>>> HOSTCXX = clang++
> >>>> else
> >>>> HOSTCC  = gcc
> >>>> HOSTCXX = g++
> >>>> endif
> >>>>
> >>>> ifneq ($(LLVM),)
> >>>> CC              = clang
> >>>> LD              = ld.lld
> >>>> AR              = llvm-ar
> >>>> NM              = llvm-nm
> >>>> OBJCOPY         = llvm-objcopy
> >>>> OBJDUMP         = llvm-objdump
> >>>> READELF         = llvm-readelf
> >>>> STRIP           = llvm-strip
> >>>> else
> >>>> CC              = $(CROSS_COMPILE)gcc
> >>>> LD              = $(CROSS_COMPILE)ld
> >>>> AR              = $(CROSS_COMPILE)ar
> >>>> NM              = $(CROSS_COMPILE)nm
> >>>> OBJCOPY         = $(CROSS_COMPILE)objcopy
> >>>> OBJDUMP         = $(CROSS_COMPILE)objdump
> >>>> READELF         = $(CROSS_COMPILE)readelf
> >>>> STRIP           = $(CROSS_COMPILE)strip
> >>>> endif
> >>>>
> >>>> So if you have right path, you don't need to set HOSTCC and HOSTCXX
> >>>> explicitly.
> >>>>
> >>>
> >>> That is all correct with HOSTCXX but there is no CXX=... assignment
> >>> otherwise test_cpp will use g++ as demonstrated.
> >>
> >> This is not a kernel Makefile issue.
> >>
> >> We have:
> >> testing/selftests/bpf/Makefile:CXX ?= $(CROSS_COMPILE)g++
> >>
> >> So you need to explicit add CXX=clang++ when compiling
> >> bpf selftests with LLVM=1 LLVM_IAS=1.
> >>
> >
> > NOPE.
> >
> > $ echo $MAKE $MAKE_OPTS
> > make V=1 LLVM=1 LLVM_IAS=1 CXX=clang++ PAHOLE=/opt/pahole/bin/pahole
> >
> > $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ 2>&1 | tee
> > ../make-log_tools-testing-selftests-bpf_llvm-1-llvm_ias-1_cxx-clang.txt
> >
> > This breaks again like reported before:
> >
> > clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include
> > -I/home/dileks/src/linux-kernel/git/include/generated
> > -I/home/dileks/src/linux-kernel/git/tools/lib
> > -I/home/dileks/src/linux-kernel/git/tools/include
> > -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> > -Dbpf_prog_load=bpf_prog_test_load
> > -Dbpf_load_program=bpf_test_load_program test_cpp.cpp
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
> > -lcap -lelf -lz -lrt -lpthread -o
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> >
> > clang-12: warning: treating 'c-header' input as 'c++-header' when in
> > C++ mode, this behavior is deprecated [-Wdeprecated]
> > clang-12: error: cannot specify -o when generating multiple output files
> > make: *** [Makefile:455:
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
> > Error 1
> > make: Leaving directory
> > '/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf'
> >
> > Do you know some magic CXX flags to be passed?
>
> I tested in my environment. The reason is LC_ALL=C.
> Without LC_ALL=C, make succeeded and with it, test_cpp
> compilation failed. Is it possible for you to drop
> LC_ALL=C for bpf selftests?
>
> The following command succeeded for me:
>     make -C tools/testing/selftests/bpf -j60 LLVM=1 V=1 CXX=clang++ CC=clang
>

First, I tried the exact make invocation ^^^ in my build-environment
but that breaks with the same ERROR.

I did in a second run:

LLVM_TOOLCHAIN_PATH="/opt/llvm-toolchain/bin"
if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
  export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
fi

echo $PATH
/opt/llvm-toolchain/bin:/opt/proxychains-ng/bin:/home/dileks/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

MAKE="make"
MAKE_OPTS="V=1 -j4 LLVM=1 CC=clang CXX=clang++"
MAKE_OPTS="$MAKE_OPTS PAHOLE=/opt/pahole/bin/pahole"

echo $MAKE $MAKE_OPTS
make V=1 -j4 LLVM=1 CC=clang CXX=clang++ PAHOLE=/opt/pahole/bin/pahole

$MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ 2>&1 | tee
../make-log_tools-testing-selftests-bpf.txt

That would have been funny... Drop LC_ALL=C from make line as a fix.

Just curious: Do you see these warnings?

clang-12: warning: argument unused during compilation: '-rdynamic'
[-Wunused-command-line-argument]
clang-12: warning: -lcap: 'linker' input unused [-Wunused-command-line-argument]
clang-12: warning: -lelf: 'linker' input unused [-Wunused-command-line-argument]
clang-12: warning: -lz: 'linker' input unused [-Wunused-command-line-argument]
clang-12: warning: -lrt: 'linker' input unused [-Wunused-command-line-argument]
clang-12: warning: -lpthread: 'linker' input unused
[-Wunused-command-line-argument]
clang-12: warning: -lm: 'linker' input unused [-Wunused-command-line-argument]

Equivalent CFLAGS for '-rdynamic' when CC=clang is used?
Missing LDFLAGS when LD=ld.lld (make LLVM=1) is used?

Last question:
Can you pass LLVM_IAS=1 (means use LLVM/Clang Integrated ASsembler) to
your make line?

Old: make -C tools/testing/selftests/bpf -j60 LLVM=1 V=1 CXX=clang++ CC=clang
New: make -C tools/testing/selftests/bpf -j60 LLVM=1 LLVM_IAS=1 V=1
CXX=clang++ CC=clang

Does it build successfully?

- Sedat -

> >
> > The only solution is to suppress the build of test_cpp (see
> > TEST_GEN_PROGS_EXTENDED):
> >
> > $ git diff tools/testing/selftests/bpf/Makefile
> > diff --git a/tools/testing/selftests/bpf/Makefile
> > b/tools/testing/selftests/bpf/Makefile
> > index 044bfdcf5b74..cf7c7c8f72cf 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -77,8 +77,8 @@ TEST_PROGS_EXTENDED := with_addr.sh \
> > # Compile but not part of 'make run_tests'
> > TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
> >         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
> > -       test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
> > -       xdpxceiver
> > +       test_lirc_mode2_user xdping runqslower bench bpf_testmod.ko xdpxceiver
> > +       # test_cpp # Suppress the build when CXX=clang++ is used
> >
> > TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
> >
> > I have attached both make-logs with and without suppressing the build
> > of test_cpp and the diff.
> >
> > - Sedat -
> >
> >>
> >>>
> [...]
