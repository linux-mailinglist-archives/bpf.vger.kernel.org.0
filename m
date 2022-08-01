Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB86587142
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 21:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbiHATOo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 15:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiHATOR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 15:14:17 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A94E3DBCB;
        Mon,  1 Aug 2022 12:13:22 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id c185so14122679oia.7;
        Mon, 01 Aug 2022 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=WQ+3RHhtoAPbSDWuqYfpFY25Zd84CR4169xpCTu3CFI=;
        b=JpKnfFrox2guX+mZtcrOG+JNAsl3/H4FOB7Ud27UiLHtY2p9v3QWexiWy2bsivMhsh
         3+u7LUqrNoBzFMhX0etZOv+N47nlJe+DPDXmPNFKycUVy+8V88tTeie7k0Z56yiwmVpB
         ddCy3XO5GjalGgodYhjXu6JoevA0F4vE8OPXZVFVzsiNNjmuL8tCdig2RTdSRIgM9JxL
         JDFAm9hqkmTyNEm81OseefsqfuutiMY4ToGOAvq7T8d0Iiow1HcQlxrM/ciI/lKxxz4b
         T5Md6yC9GE8WTTg+uUlI/Ir+vCkBn8dZZvkT1gvTlTvu8low8SoTENYOTjdfPXP5O2qA
         ZZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=WQ+3RHhtoAPbSDWuqYfpFY25Zd84CR4169xpCTu3CFI=;
        b=kYIGz/9z+nbTxZvxMrm+BIGGgOdSzmfWM4eSQpXqlix6qVlf4VbhaD3QAwP41OcZST
         NNWwUqE2YKa97zVqe5gFqiWG9HFjGFWiBhf1gr6wKxAKeoshcpWrrLAAep/qPyGl3edC
         SEhCa+M0AYlSuIgQo1BiknaVDXTowIPNABRCIPKFxOrx/WpB8T//NC6Maqa4wsbWjjWj
         LgyqgIJTVDleST9MJ2VcrQs5LcHbBIYeeqjK9XnTPOeJ3CY5oGlP98HxihJkhdNmMarR
         +A9Z4fSxdOhE/IP2upP0wCBpwsG+0ookL7X3DhGVnJPFWYZ2Mf5AYFFBo54VIokoWOfj
         FmuA==
X-Gm-Message-State: ACgBeo03RpH7nX0jQEGnDFCDohV2QufZOgPps4OxFu/MSrEYvtn1ZMXp
        C4hwX2q3rcU6vFKhSQ9uMCLWFt0ZST6l03eJo4fWesWxMej/9g==
X-Google-Smtp-Source: AA6agR5JDuJanQECI2+FJtSaSQ6tdeaaO8Vkg5jGqJhPhU+N/26gYHfbwuRI+CMscZ3VNf1PGxaAn8TP6nkVX2gTZXc=
X-Received: by 2002:a05:6808:bd5:b0:33f:dd8:c545 with SMTP id
 o21-20020a0568080bd500b0033f0dd8c545mr3414306oik.252.1659381201405; Mon, 01
 Aug 2022 12:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de> <20220801013834.156015-1-andres@anarazel.de>
In-Reply-To: <20220801013834.156015-1-andres@anarazel.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 1 Aug 2022 21:12:45 +0200
Message-ID: <CA+icZUWasopVhZ449k1F8zG-C0kRbrt4tH+N7JqJO7CotA24Hw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] tools: fix compilation failure caused by
 init_disassemble_info API changes
To:     Andres Freund <andres@anarazel.de>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Ben Hutchings <benh@debian.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 1, 2022 at 3:38 AM Andres Freund <andres@anarazel.de> wrote:
>
> binutils changed the signature of init_disassemble_info(), which now causes
> compilation failures for tools/{perf,bpf} on e.g. debian unstable. Relevant
> binutils commit:
> https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=60a3da00bd5407f07
>
> I first fixed this without introducing the compat header, as suggested by
> Quentin, but I thought the amount of repeated boilerplate was a bit too
> much. So instead I introduced a compat header to wrap the API changes. Even
> tools/bpf/bpftool/jit_disasm.c, which needs its own callbacks for json, imo
> looks nicer this way.
>
> I'm not regular contributor, so it very well might be my procedures are a
> bit off...
>
> I am not sure I added the right [number of] people to CC?
>
> WRT the feature test: Not sure what the point of the -DPACKAGE='"perf"' is,
> nor why tools/perf/Makefile.config sets some LDFLAGS/CFLAGS that are also
> in feature/Makefile and why -ldl isn't needed in the other places. But...
>
> V2:
> - split patches further, so that tools/bpf and tools/perf part are entirely
>   separate
> - included a bit more information about tests I did in commit messages
> - add a maybe_unused to fprintf_json_styled's style argument
>
> V3:
> - don't include dis-asm-compat.h when building without libbfd
>   (Ben Hutchings)
> - don't include compiler.h in dis-asm-compat.h, use (void) casts instead,
>   to avoid compiler.h include due to potential licensing conflict
> - dual-license dis-asm-compat.h, for better compatibility with the rest of
>   bpftool's code (suggested by Quentin Monnet)
> - don't display feature-disassembler-init-styled test
>   (suggested by Jiri Olsa)
> - don't display feature-disassembler-four-args test, I split this for the
>   different subsystems, but maybe that's overkill? (suggested by Jiri Olsa)
>

Hi Andres,

Just made a quick test & run with some custom patchset and LLVM-15 RC1:

[ REPRODUCER ]

LLVM_MVER="15"

##LLVM_TOOLCHAIN_PATH="/usr/lib/llvm-${LLVM_MVER}/bin"
LLVM_TOOLCHAIN_PATH="/opt/llvm/bin"
if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
   export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
fi

PYTHON_VER="3.10"
MAKE="make"
MAKE_OPTS="V=1 -j1 HOSTCC=clang-$LLVM_MVER HOSTLD=ld.lld
HOSTAR=llvm-ar CC=clang-$LLVM_MVER LD=ld.lld AR=llvm-ar
STRIP=llvm-strip"

echo "LLVM MVER ........ $LLVM_MVER"
echo "Path settings .... $PATH"
echo "Python version ... $PYTHON_VER"
echo "make line ........ $MAKE $MAKE_OPTS"

LANG=C LC_ALL=C make -C tools/perf clean 2>&1 | tee ../make-log_perf-clean.txt

LANG=C LC_ALL=C $MAKE $MAKE_OPTS -C tools/perf
PYTHON=python${PYTHON_VER} install-bin 2>&1 | tee
../make-log_perf-install_bin_python${PYTHON_VER}_llvm${LLVM_MVER}.txt

Looks good.

$ ~/bin/perf -vv
perf version 5.19.0
                dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
   dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
        syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
               libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
           debuginfod: [ OFF ]  # HAVE_DEBUGINFOD_SUPPORT
               libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
              libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
              libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
            libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
             libslang: [ on  ]  # HAVE_SLANG_SUPPORT
            libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
            libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
   libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                 zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                 lzma: [ on  ]  # HAVE_LZMA_SUPPORT
            get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                  bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                  aio: [ on  ]  # HAVE_AIO_SUPPORT
                 zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
              libpfm4: [ OFF ]  # HAVE_LIBPFM

[ Test on Intel Sandybridge CPU ]

$ echo 0 | sudo tee /proc/sys/kernel/kptr_restrict
/proc/sys/kernel/perf_event_paranoid
0

$ ~/bin/perf test 10 93 94 95
10: PMU events                                                      :
10.1: PMU event table sanity                                        : Ok
10.2: PMU event map aliases                                         : Ok
10.3: Parsing of PMU event table metrics                            : Ok
10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
93: perf all metricgroups test                                      : Ok
94: perf all metrics test                                           : Ok
95: perf all PMU test                                               : Ok

Feel free to add my:

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # LLVM v15.0.0-rc1 (x86-64)

Regards,
-Sedat-

> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Sedat Dilek <sedat.dilek@gmail.com>
> Cc: Quentin Monnet <quentin@isovalent.com>
> CC: Ben Hutchings <benh@debian.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20220622181918.ykrs5rsnmx3og4sv@alap3.anarazel.de
> Link: https://lore.kernel.org/lkml/CA+icZUVpr8ZeOKCj4zMMqbFT013KJz2T1csvXg+VSkdvJH1Ubw@mail.gmail.com
>
> Andres Freund (8):
>   tools build: Add feature test for init_disassemble_info API changes
>   tools build: Don't display disassembler-four-args feature test
>   tools include: add dis-asm-compat.h to handle version differences
>   tools perf: Fix compilation error with new binutils
>   tools bpf_jit_disasm: Fix compilation error with new binutils
>   tools bpf_jit_disasm: Don't display disassembler-four-args feature
>     test
>   tools bpftool: Fix compilation error with new binutils
>   tools bpftool: Don't display disassembler-four-args feature test
>
>  tools/bpf/Makefile                            |  7 ++-
>  tools/bpf/bpf_jit_disasm.c                    |  5 +-
>  tools/bpf/bpftool/Makefile                    |  8 ++-
>  tools/bpf/bpftool/jit_disasm.c                | 42 +++++++++++---
>  tools/build/Makefile.feature                  |  4 +-
>  tools/build/feature/Makefile                  |  4 ++
>  tools/build/feature/test-all.c                |  4 ++
>  .../feature/test-disassembler-init-styled.c   | 13 +++++
>  tools/include/tools/dis-asm-compat.h          | 55 +++++++++++++++++++
>  tools/perf/Makefile.config                    |  8 +++
>  tools/perf/util/annotate.c                    |  7 ++-
>  11 files changed, 138 insertions(+), 19 deletions(-)
>  create mode 100644 tools/build/feature/test-disassembler-init-styled.c
>  create mode 100644 tools/include/tools/dis-asm-compat.h
>
> --
> 2.37.0.3.g30cc8d0f14
>
