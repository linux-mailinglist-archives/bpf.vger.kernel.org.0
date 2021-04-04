Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434B835392A
	for <lists+bpf@lfdr.de>; Sun,  4 Apr 2021 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhDDRZ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Apr 2021 13:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhDDRZz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Apr 2021 13:25:55 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65575C0613E6;
        Sun,  4 Apr 2021 10:25:48 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d10so8469457ils.5;
        Sun, 04 Apr 2021 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=kS10I4f86B4zS7CszxsyJyiWHLBIzBv9ppNKPY27ofE=;
        b=pHVURMtQcDfkUnKppoySryYAZfc4jixc+49hX+USHlaBLHckhK0BmaxSclA71Hcu8v
         aFkJLXBjACwoSZKqmLqMmmRPVFfJ4ho45zv6sNRaV3Jrtg6Cfe/o9MelBW7TAy5eQrvr
         1WrUarDLL+QSUMl3TkTY8y6vyb5fW5eHEaefEyiePFhX81HVlhmBeHXk/ARaIBc8CF7/
         C83GDSawbB4wGz5ud2JZ7XxFbMze9GkdraycGqqfQhZMDHdGzOXblf6CWvP8HLA3DH9Z
         QGxaDY/lpTG2/HBttaxfJF+O792oF09iGJKyl2xqOcUmLzRa5DqaYyt8WhFBfRvCD3pT
         wjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=kS10I4f86B4zS7CszxsyJyiWHLBIzBv9ppNKPY27ofE=;
        b=BuFjVsZoZbkknaW24Ljl/L1ku5NkR0OLU9hjMaPPmSRtGiFiiE2iSw20DjxOlSniWW
         Al4cFoZWgIMzVyNDk7W6f0TMFhFWBytotZ1a7Qgv5FLV44T08LCHomGuyIs9x3TXfs/X
         v2Y/786kXCb5z07vOidDMJElkhJgBx7AdHxQFxRBVJUjPsjjUWsOuMIOsP6wFu7idfKB
         vLQJAm2R/IH9cRgkNcnWJSivJzO0TNtgSoyVTS3kRzLxszkslhAAe7lP5vbsHsXi+KP3
         1Oayj7C9dMBEdtFAgaCVPTuwLRPvRa+/5OiBtIkH7owoC48YAPoV9ZEUSICw8Y9w9TCY
         sI/Q==
X-Gm-Message-State: AOAM532juAAcvMXcyhhdc79XFfngEyXicFEPfcE5yLW9t5L2V6+o1SS2
        wEFpi0MSYYbUDWtBfsLX60QwYU/a0+1cqNSGLQE=
X-Google-Smtp-Source: ABdhPJyobKEMl3gcCS4WDVOeRtQSzY6ifZWgiaSNjNhdVZhhuwjyoEgAt+BB1/QR6ahOgnuymjS6+ktwg1wqkO/jwrc=
X-Received: by 2002:a92:c545:: with SMTP id a5mr17256076ilj.209.1617557148270;
 Sun, 04 Apr 2021 10:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210403184158.2834387-1-yhs@fb.com> <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
 <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com> <CA+icZUV4fw5GNXFnyOjvajkVFdPhkOrhr3rn5OrAKGujpSrmgQ@mail.gmail.com>
 <CA+icZUWh6YOkCKG72SndqUbQNwG+iottO4=cPyRRVjaHD2=0qw@mail.gmail.com> <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com>
In-Reply-To: <f706e8b9-77ca-6341-db13-e2a74549576b@fb.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 4 Apr 2021 19:25:11 +0200
Message-ID: <CA+icZUVb_J95Gk2Kf0i8waL6TDfJ2n9JrGbNK_dsN1n8HdcoXQ@mail.gmail.com>
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

On Sun, Apr 4, 2021 at 6:40 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 4/4/21 5:46 AM, Sedat Dilek wrote:
> >> This shows a new build-error:
> >>
> >> clang  -g -D__TARGET_ARCH_x86 -mlittle-endian
> >> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include
> >> -I/home/dileks/src/linux-kernel/git/tools/t
> >> esting/selftests/bpf
> >> -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> >> -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/usr/include
> >> -idirafter /usr/loc
> >> al/include -idirafter /opt/llvm-toolchain/lib/clang/12.0.0/include
> >> -idirafter /usr/include/x86_64-linux-gnu -idirafter /usr/include
> >> -Wno-compare-distinct-pointer-type
> >> s -DENABLE_ATOMICS_TESTS -O2 -target bpf -c
> >> progs/test_sk_storage_tracing.c -o
> >> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_sk_storage_tracing.o-mcpu=v3
> >> progs/test_sk_storage_tracing.c:38:18: error: use of undeclared
> >> identifier 'BPF_TCP_CLOSE'
> >>         if (newstate == BPF_TCP_CLOSE)
> >>                         ^
> >> 1 error generated.
> >> make: *** [Makefile:414:
> >> /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_sk_storage_tracing.o]
> >> Error 1
> >>
> >
> > I was able to fix this by adding appropriate enums from <linux/bpf.h>.
> >
> > $ git diff
> > diff --git a/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
> > b/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
> > index 8e94e5c080aa..3c7508f48ce0 100644
> > --- a/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
> > +++ b/tools/testing/selftests/bpf/progs/test_sk_storage_tracing.c
> > @@ -6,6 +6,28 @@
> > #include <bpf/bpf_core_read.h>
> > #include <bpf/bpf_helpers.h>
> >
> > +/* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> > + * changes between the TCP and BPF versions. Ideally this should never happen.
> > + * If it does, we need to add code to convert them before calling
> > + * the BPF sock_ops function.
> > + */
> > +enum {
> > +       BPF_TCP_ESTABLISHED = 1,
> > +       BPF_TCP_SYN_SENT,
> > +       BPF_TCP_SYN_RECV,
> > +       BPF_TCP_FIN_WAIT1,
> > +       BPF_TCP_FIN_WAIT2,
> > +       BPF_TCP_TIME_WAIT,
> > +       BPF_TCP_CLOSE,
> > +       BPF_TCP_CLOSE_WAIT,
> > +       BPF_TCP_LAST_ACK,
> > +       BPF_TCP_LISTEN,
> > +       BPF_TCP_CLOSING,        /* Now a valid state */
> > +       BPF_TCP_NEW_SYN_RECV,
> > +
> > +       BPF_TCP_MAX_STATES      /* Leave at the end! */
> > +};
> > +
> > struct sk_stg {
> >         __u32 pid;
> >         __u32 last_notclose_state;
> >
> > NOTE: Attached as a diff as Gmail might truncate it.
>
> This bpf-next commit:
>    commit 97a19caf1b1f6a9d4f620a9d51405a1973bd4641
>    Author: Yonghong Song <yhs@fb.com>
>    Date:   Wed Mar 17 10:41:32 2021 -0700
>
>      bpf: net: Emit anonymous enum with BPF_TCP_CLOSE value explicitly
>
> fixed the issue.
>

Cool, looks like the correct fix.

> >
> > [ Q ] Should these enums be in vmlinux.h - if so why are they missing?
> >
> > Next build-error:
> >
> > g++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/b
> > pf/tools/include -I/home/dileks/src/linux-kernel/git/include/generated
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
> > /usr/bin/ld: /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/build/libbpf/libbpf.a(libbpf-in.o):
> > relocation R_X86_64_32 against `.rodata.str1.1' ca
> > n not be used when making a PIE object; recompile with -fPIE
> > collect2: error: ld returned 1 exit status
> > make: *** [Makefile:455:
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
> > Error 1
> > make: Leaving directory
> > '/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf'
> >
> > LOL, I was not aware that there is usage of *** CXX*** in tools
> > directory (see g++ line and /usr/bin/ld ?).
> >
> > So, I changed my $MAKE_OPTS to use "CXX=clang++".
>
> In kernel, if LLVM=1 is set, we have:
>
> ifneq ($(LLVM),)
> HOSTCC  = clang
> HOSTCXX = clang++
> else
> HOSTCC  = gcc
> HOSTCXX = g++
> endif
>
> ifneq ($(LLVM),)
> CC              = clang
> LD              = ld.lld
> AR              = llvm-ar
> NM              = llvm-nm
> OBJCOPY         = llvm-objcopy
> OBJDUMP         = llvm-objdump
> READELF         = llvm-readelf
> STRIP           = llvm-strip
> else
> CC              = $(CROSS_COMPILE)gcc
> LD              = $(CROSS_COMPILE)ld
> AR              = $(CROSS_COMPILE)ar
> NM              = $(CROSS_COMPILE)nm
> OBJCOPY         = $(CROSS_COMPILE)objcopy
> OBJDUMP         = $(CROSS_COMPILE)objdump
> READELF         = $(CROSS_COMPILE)readelf
> STRIP           = $(CROSS_COMPILE)strip
> endif
>
> So if you have right path, you don't need to set HOSTCC and HOSTCXX
> explicitly.
>

That is all correct with HOSTCXX but there is no CXX=... assignment
otherwise test_cpp will use g++ as demonstrated.

> >
> > $ echo $PATH
> > /opt/llvm-toolchain/bin:/opt/proxychains-ng/bin:/home/dileks/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
> >
> > $ echo $MAKE $MAKE_OPTS
> > make V=1 HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
> > CXX=clang++ LD=ld.lld LLVM=1 LLVM_IAS=1 PAHOLE=/opt/pahole/bin/pahole
> >
> > $ clang --version
> > dileks clang version 12.0.0 (https://github.com/llvm/llvm-project.git
> > 04ba60cfe598e41084fb848daae47e0ed910fa7d)
> > Target: x86_64-unknown-linux-gnu
> > Thread model: posix
> > InstalledDir: /opt/llvm-toolchain/bin
> > $ ld.lld --version
> > LLD 12.0.0 (https://github.com/llvm/llvm-project.git
> > 04ba60cfe598e41084fb848daae47e0ed910fa7d) (compatible with GNU
> > linkers)
> >
> > $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/
> >
> > This breaks like this:
> >
> > clang++ -g -rdynamic -Wall -O2 -DHAVE_GENHDR
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftes
> > ts/bpf/tools/include
> > -I/home/dileks/src/linux-kernel/git/include/generated
> > -I/home/dileks/src/linux-kernel/git/tools/lib
> > -I/home/dileks/src/linux-kernel/git/tools/incl
> > ude -I/home/dileks/src/linux-kernel/git/tools/include/uapi
> > -I/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf
> > -Dbpf_prog_load=bpf_prog_test_load -Dbpf_loa
> > d_program=bpf_test_load_program test_cpp.cpp
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_core_extern.skel.h
> > /home/dileks/src/linux-kernel/git/to
> > ols/testing/selftests/bpf/tools/build/libbpf/libbpf.a
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_stub.o
> > -lcap -lelf -lz -lrt -lpthread -o /home
> > /dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp
> > clang-12: warning: treating 'c-header' input as 'c++-header' when in
> > C++ mode, this behavior is deprecated [-Wdeprecated]
> > clang-12: error: cannot specify -o when generating multiple output files
> > make: *** [Makefile:455:
> > /home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/test_cpp]
> > Error 1
> >
> > OK, I see in bpf-next includes several fixes like:
> >
> > commit a0964f526df6facd4e12a4c416185013026eecf9
> > "selftests/bpf: Add multi-file statically linked BPF object file test"
> >
> > ...and to "selftests: xsk".
> >
> > Finally, I was able to build by suppressing the build of "test_cpp"
> > and "xdpxceiver":
> >
> > $ git diff tools/testing/selftests/bpf/Makefile
> > diff --git a/tools/testing/selftests/bpf/Makefile
> > b/tools/testing/selftests/bpf/Makefile
> > index 044bfdcf5b74..d9b19524b2d4 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -77,8 +77,8 @@ TEST_PROGS_EXTENDED := with_addr.sh \
> > # Compile but not part of 'make run_tests'
> > TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
> >         flow_dissector_load test_flow_dissector test_tcp_check_syncookie_user \
> > -       test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
> > -       xdpxceiver
> > +       test_lirc_mode2_user xdping runqslower bench bpf_testmod.ko
> > +       # test_cpp xdpxceiver
> >
> > TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
> >
> > This diff is also attached before Gmail eats it.
> >
> > Yonghong Song as you described your build-environment and checking
> > requirements for clang-13 in bpf-next (see [1]), I am unsure if I want
> > to upgrade LLVM toolchain to v13-git and use bpf-next as the new
> > kernel base.
> > Lemme see if I get LLVM/Clang v13-git from Debian/experimental and/or
> > <apt.llvm.org>.
>
> If you want to run bpf-next, clang v13 definitely recommended.
> But I think if you use clang v13 to run linus linux, you may
> hit DWARF5 DW_OP_addrx as well. But unfortunately you will
> may hit a few selftest issues (e.g., BPF_TCP_CLOSE issue).
>

OK, I started a fresh build with LLVM/Clang v13-git from <apt.llvm.org>...

$ /usr/lib/llvm-13/bin/clang --version
Debian clang version
13.0.0-++20210404092853+c4c511337247-1~exp1~20210404073605.3891
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/lib/llvm-13/bin

...with latest bpf-next as new base.

I applied your/this pahole patch "[PATCH dwarves] dwarf_loader: handle
DWARF5 DW_OP_addrx properly".

Will report later...

- Sedat -

> >
> > [1] https://git.kernel.org/bpf/bpf-next/c/2ba4badca9977b64c966b0177920daadbd5501fe
> > [2] https://git.kernel.org/bpf/bpf-next/c/a0964f526df6facd4e12a4c416185013026eecf9
> >
