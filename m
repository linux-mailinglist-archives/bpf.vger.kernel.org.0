Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFA0628A4A
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 21:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbiKNURP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 15:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiKNURG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 15:17:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1EED80;
        Mon, 14 Nov 2022 12:17:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCA09B81250;
        Mon, 14 Nov 2022 20:17:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23131C433D6;
        Mon, 14 Nov 2022 20:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668457020;
        bh=lArEVRhnhBStJg8lVysI0AXQxfySf17f2xZUNA8QEFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtTVz014n8NvY6nbqwwKhoZ2xNVIXYJFixHk1bHFUjMNV99l+ImUDlMSKp2NbDpP6
         HkwTpHs3t0bDyPSHeTYbZuhfQ5ZP4d3BANOPOl2UWGAGOUHZrIs96mwoQ/X5VEKiAo
         a2eSjLo3SvEmNr3D5jNGR9rBabqwWEtrKv0PmNuFq4ICnoZLi3jtZ5tlkupUTdKsWC
         MAGSwZzhyAhturAJCh8CRFq6lBSOXsiA0d8wWKrHs+6KrWL5FjqXjU+MzpXmd2i59D
         LMR+/bYNBmlMsqYBtOSfpBnU3gN4Ax86RrqNeRSUC7ruqQ4RygiAp+IUK43KN9NTmn
         M1utTd37W/ixA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A96E44034E; Mon, 14 Nov 2022 17:16:57 -0300 (-03)
Date:   Mon, 14 Nov 2022 17:16:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 00/14] Fix perf tools/lib includes
Message-ID: <Y3KiOU/bYokRSENk@kernel.org>
References: <20221109184914.1357295-1-irogers@google.com>
 <CAM9d7ciPe-uR5MdayhUEEK8a-j1QDm50qPffsod9BHdUF5Z-TA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciPe-uR5MdayhUEEK8a-j1QDm50qPffsod9BHdUF5Z-TA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Nov 10, 2022 at 10:10:18AM -0800, Namhyung Kim escreveu:
> Hi Ian,
> 
> On Wed, Nov 9, 2022 at 10:49 AM Ian Rogers <irogers@google.com> wrote:
> >
> > The previous build would add -Itools/lib and get dependencies for
> > libtraceevent, libsubcmd, libsymbol, libapi and libbpf meaning that
> > overriding these libraries would change the link time dependency but
> > the headers would erroneously come from tools/lib. Fix the build to
> > install headers and then depend on these. To reduce exposing internal
> > headers/APIs some clean up is performed. tools/lib/symbol has a
> > Makefile added, while tools/lib/api and tools/lib/subcmd have install
> > targets added. The pattern used for the dependencies in Makefile.perf
> > is modelled on libbpf.
> >
> > The problem and solution were motivated by this issue and discussion:
> > https://lore.kernel.org/lkml/CAEf4BzbbOHQZUAe6iWaehKCPQAf3VC=hq657buqe2_yRKxaK-A@mail.gmail.com/
> >
> > v2. Fix a MANIFEST issue for the source tar ball. Add dependencies for
> >     the installed header files so that the build doesn't overtake
> >     building these dependencies. Both issues reported by Arnaldo
> >     Carvalho de Melo <acme@kernel.org>.
> >
> > Ian Rogers (14):
> >   tools lib api: Add install target
> >   tools lib subcmd: Add install target
> >   perf build: Install libsubcmd locally when building
> >   perf build: Install libapi locally when building
> >   perf build: Install libperf locally when building
> >   perf build: Install libtraceevent locally when building
> >   tools lib api: Add missing install headers
> >   tools lib perf: Add missing install headers
> >   tool lib symbol: Add Makefile/Build
> >   perf build: Install libsymbol locally when building
> >   perf expr: Tidy hashmap dependency
> >   perf thread_map: Reduce exposure of libperf internal API
> >   perf cpumap: Tidy libperf includes
> >   perf build: Use tools/lib headers from install path
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

'make -C tools/perf build-test' is failing, looks like parallelization
woes again:

⬢[acme@toolbox perf]$ getconf _NPROCESSORS_ONLN
32
⬢[acme@toolbox perf]$

⬢[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools/perf build-test
9f22d36a1dd0297a (HEAD -> perf/core) perf build: Use tools/lib headers from install path
make: Entering directory '/var/home/acme/git/perf/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.i0kUDsiQbV
              make_with_gtk2: cd . && make GTK2=1 -j32  DESTDIR=/tmp/tmp.MNcgfeG07c
cd . && make GTK2=1 -j32 DESTDIR=/tmp/tmp.MNcgfeG07c
  BUILD:   Doing 'make -j32' parallel build
  HOSTCC  fixdep.o
  HOSTLD  fixdep-in.o
  LINK    fixdep
Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  GEN     common-cmds.h
  CC      perf-read-vdso32
  CC      dlfilters/dlfilter-test-api-v0.o
  CC      dlfilters/dlfilter-show-cycles.o
  CC      jvmti/libjvmti.o
  CC      jvmti/jvmti_agent.o
  CC      jvmti/libstring.o
  CC      jvmti/libctype.o
  CC      ui/gtk/browser.o
  CC      ui/gtk/hists.o
  CC      ui/gtk/setup.o
  CC      ui/gtk/util.o
  GEN     pmu-events/pmu-events.c
  CC      ui/gtk/helpline.o
  LINK    dlfilters/dlfilter-show-cycles.so
  CC      ui/gtk/progress.o
  CC      ui/gtk/annotate.o
  CC      ui/gtk/zalloc.o
  LINK    dlfilters/dlfilter-test-api-v0.so
  INSTALL headers
  CC      /var/home/acme/git/perf/tools/perf/libsubcmd/exec-cmd.o
  CC      /var/home/acme/git/perf/tools/perf/libsubcmd/help.o
  CC      /var/home/acme/git/perf/tools/perf/libsubcmd/pager.o
  CC      /var/home/acme/git/perf/tools/perf/libsubcmd/parse-options.o
  CC      /var/home/acme/git/perf/tools/perf/libsubcmd/run-command.o
In file included from ui/gtk/hists.c:2:
/var/home/acme/git/perf/tools/perf/util/include/../evlist.h:9:10: fatal error: api/fd/array.h: No such file or directory
    9 | #include <api/fd/array.h>
      |          ^~~~~~~~~~~~~~~~
compilation terminated.
make[6]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: ui/gtk/hists.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC      /var/home/acme/git/perf/tools/perf/libsubcmd/sigchain.o
make -f /var/home/acme/git/perf/tools/build/Makefile.build dir=. obj=libsymbol V=1
In file included from ui/gtk/browser.c:2:
/var/home/acme/git/perf/tools/perf/util/include/../evsel.h:10:10: fatal error: internal/evsel.h: No such file or directory
   10 | #include <internal/evsel.h>
      |          ^~~~~~~~~~~~~~~~~~
compilation terminated.
make[6]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: ui/gtk/browser.o] Error 1
  INSTALL headers
  CC      /var/home/acme/git/perf/tools/perf/libtraceevent/event-parse.o
