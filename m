Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6662C641
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 18:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiKPRVo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 12:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiKPRVn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 12:21:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1748DCD3;
        Wed, 16 Nov 2022 09:21:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81E77B81E08;
        Wed, 16 Nov 2022 17:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD638C433D6;
        Wed, 16 Nov 2022 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668619299;
        bh=epFRrstzquLlrXcdt7Js4FmWpA8kUko8z4cgrxQhQUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byIiFmrGa1ZSWA8jSos6wGQ33RccisNtkiB0oJ5ccUFEcNvpmBqJTB+46JLLpFJip
         kjIy1WmKRraESYPppHt90DfTmeM7hAt9zODW/l/1VyMbZNFx5HdK9zhoUk5v/LAohB
         G9xiT0Va1aiNnWBT65FnBZJpNXdsYn3dw05Y5nCeBb9EdN3qWWpnXTlr9/TIIZqukM
         08ZTvlrpCw4Pj5BhZA4FlCYIKyKe8OB805nCrMF8G4JMlCm6ZTfkEW4k4SYbVrvigL
         hmYMTtFb4ImqPkW+zPrCF/Tch5Z8C/xC9SVqIVfAoq+DLTeMR7wARUyOYgTIWoiBqg
         6RXa4B1PXbf+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B91F4034E; Wed, 16 Nov 2022 14:21:36 -0300 (-03)
Date:   Wed, 16 Nov 2022 14:21:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 0/1] Fix perf tools/lib includes
Message-ID: <Y3UcILLB2qsm4x7x@kernel.org>
References: <20221116072211.2837834-1-irogers@google.com>
 <Y3T/fxPOvZgePIEz@kernel.org>
 <Y3UAX3U/cpszMFE7@kernel.org>
 <CAP-5=fWu2Ywz9rC3fq9GSnASbJu4hyiF4bqyrSDi34Rz6A8y+A@mail.gmail.com>
 <CAP-5=fX5X8=-jbj7wo7LZpNhgYzJqPJ1duJbdf2zH3HtPhcdsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX5X8=-jbj7wo7LZpNhgYzJqPJ1duJbdf2zH3HtPhcdsA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Nov 16, 2022 at 08:47:51AM -0800, Ian Rogers escreveu:
> On Wed, Nov 16, 2022 at 8:45 AM Ian Rogers <irogers@google.com> wrote:
> >
> > On Wed, Nov 16, 2022 at 7:23 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Nov 16, 2022 at 12:19:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Tue, Nov 15, 2022 at 11:22:10PM -0800, Ian Rogers escreveu:
> > > > > This patch replaces the last on kernel/git/acme/linux.git branch
> > > > > perf/tools-libs-includes and fixes the race issue by using the prepare
> > > > > dependency. pmu-events.c needs this dependency too, as the header
> > > > > files it includes also include libperf - using perpare as a dependency
> > > > > rather than $(LIBPERF) is more consistent with the rest of the makefile.
> > > > >
> > > > > Ian Rogers (1):
> > > > >   perf build: Use tools/lib headers from install path
> > > >
> > > > Testing.
> > >
> > > ⬢[acme@toolbox perf]$ git log acme/perf/core.. --oneline
> > > 0a1e208afdccce71 (HEAD -> perf/tools-libs-includes) perf build: Use tools/lib headers from install path
> > > 17ca352f2aff834e perf cpumap: Tidy libperf includes
> > > fd3f518fc1140622 perf thread_map: Reduce exposure of libperf internal API
> > > bd560973c5d3b2a3 perf expr: Tidy hashmap dependency
> > > 84bec6f0b31fb2ac perf build: Install libsymbol locally when building
> > > 160be157eaba2a37 tool lib symbol: Add Makefile/Build
> > > a6e8caf5db2e1db8 tools lib perf: Add missing install headers
> > > 8d1f68bd76a6517c tools lib api: Add missing install headers
> > > ef019df01e207971 perf build: Install libtraceevent locally when building
> > > 91009a3a9913f275 perf build: Install libperf locally when building
> > > 00314c9bca8faad4 perf build: Install libapi locally when building
> > > 911920b06e6be3fa perf build: Install libsubcmd locally when building
> > > 630ae80ea1dd2536 tools lib subcmd: Add install target
> > > a6efaa2c89bf35c3 tools lib api: Add install target
> > > ⬢[acme@toolbox perf]$
> > >
> > > ⬢[acme@toolbox perf]$ git show
> > > commit 0a1e208afdccce7193cbe4031dfd255c89c425d6
> > > Author: Ian Rogers <irogers@google.com>
> > > Date:   Tue Nov 15 23:22:11 2022 -0800
> > >
> > >     perf build: Use tools/lib headers from install path
> > >
> > >     Switch -I from tools/lib to the install path for the tools/lib
> > >     libraries. Add the include_headers build targets to prepare target, as
> > >     well as pmu-events.c compilation that dependes on libperf.
> > >
> > >     Signed-off-by: Ian Rogers <irogers@google.com>
> > >     Acked-by: Namhyung Kim <namhyung@kernel.org>
> > >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > >     Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > >     Cc: Jiri Olsa <jolsa@kernel.org>
> > >     Cc: Mark Rutland <mark.rutland@arm.com>
> > >     Cc: Masahiro Yamada <masahiroy@kernel.org>
> > >     Cc: Nick Desaulniers <ndesaulniers@google.com>
> > >     Cc: Nicolas Schier <nicolas@fjasle.eu>
> > >     Cc: Peter Zijlstra <peterz@infradead.org>
> > >     Cc: Stephane Eranian <eranian@google.com>
> > >     Cc: bpf@vger.kernel.org
> > >     Link: http://lore.kernel.org/lkml/20221109184914.1357295-15-irogers@google.com
> > >     Link: http://lore.kernel.org/lkml/20221116072211.2837834-2-irogers@google.com
> > >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index a7f6c0669fae4d24..9cc3c48f32881c8b 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -349,7 +349,6 @@ ifeq ($(DEBUG),0)
> > >    endif
> > >  endif
> > >
> > > -INC_FLAGS += -I$(srctree)/tools/lib/perf/include
> > >  INC_FLAGS += -I$(src-perf)/util/include
> > >  INC_FLAGS += -I$(src-perf)/arch/$(SRCARCH)/include
> > >  INC_FLAGS += -I$(srctree)/tools/include/
> > > @@ -367,7 +366,6 @@ endif
> > >
> > >  INC_FLAGS += -I$(src-perf)/util
> > >  INC_FLAGS += -I$(src-perf)
> > > -INC_FLAGS += -I$(srctree)/tools/lib/
> > >
> > >  CORE_CFLAGS += -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE
> > >
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 6c1a2a3ccc38195f..dd096aba4430e3e4 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -305,6 +305,7 @@ LIBTRACEEVENT_INCLUDE = $(LIBTRACEEVENT_DESTDIR)/include
> > >  LIBTRACEEVENT = $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
> > >  export LIBTRACEEVENT
> > >  LIBTRACEEVENT_DYNAMIC_LIST = $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtraceevent-dynamic-list
> > > +CFLAGS += -I$(LIBTRACEEVENT_OUTPUT)/include
> > >
> > >  #
> > >  # The static build has no dynsym table, so this does not work for
> > > @@ -322,6 +323,7 @@ LIBAPI_DESTDIR = $(LIBAPI_OUTPUT)
> > >  LIBAPI_INCLUDE = $(LIBAPI_DESTDIR)/include
> > >  LIBAPI = $(LIBAPI_OUTPUT)/libapi.a
> > >  export LIBAPI
> > > +CFLAGS += -I$(LIBAPI_OUTPUT)/include
> > >
> > >  ifneq ($(OUTPUT),)
> > >    LIBBPF_OUTPUT = $(abspath $(OUTPUT))/libbpf
> > > @@ -331,6 +333,7 @@ endif
> > >  LIBBPF_DESTDIR = $(LIBBPF_OUTPUT)
> > >  LIBBPF_INCLUDE = $(LIBBPF_DESTDIR)/include
> > >  LIBBPF = $(LIBBPF_OUTPUT)/libbpf.a
> > > +CFLAGS += -I$(LIBBPF_OUTPUT)/include
> > >
> > >  ifneq ($(OUTPUT),)
> > >    LIBSUBCMD_OUTPUT = $(abspath $(OUTPUT))/libsubcmd
> > > @@ -340,6 +343,7 @@ endif
> > >  LIBSUBCMD_DESTDIR = $(LIBSUBCMD_OUTPUT)
> > >  LIBSUBCMD_INCLUDE = $(LIBSUBCMD_DESTDIR)/include
> > >  LIBSUBCMD = $(LIBSUBCMD_OUTPUT)/libsubcmd.a
> > > +CFLAGS += -I$(LIBSUBCMD_OUTPUT)/include
> > >
> > >  ifneq ($(OUTPUT),)
> > >    LIBSYMBOL_OUTPUT = $(abspath $(OUTPUT))/libsymbol
> > > @@ -349,6 +353,7 @@ endif
> > >  LIBSYMBOL_DESTDIR = $(LIBSYMBOL_OUTPUT)
> > >  LIBSYMBOL_INCLUDE = $(LIBSYMBOL_DESTDIR)/include
> > >  LIBSYMBOL = $(LIBSYMBOL_OUTPUT)/libsymbol.a
> > > +CFLAGS += -I$(LIBSYMBOL_OUTPUT)/include
> > >
> > >  ifneq ($(OUTPUT),)
> > >    LIBPERF_OUTPUT = $(abspath $(OUTPUT))/libperf
> > > @@ -359,6 +364,7 @@ LIBPERF_DESTDIR = $(LIBPERF_OUTPUT)
> > >  LIBPERF_INCLUDE = $(LIBPERF_DESTDIR)/include
> > >  LIBPERF = $(LIBPERF_OUTPUT)/libperf.a
> > >  export LIBPERF
> > > +CFLAGS += -I$(LIBPERF_OUTPUT)/include
> > >
> > >  # python extension build directories
> > >  PYTHON_EXTBUILD     := $(OUTPUT)python_ext_build/
> > > @@ -691,7 +697,7 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
> > >  $(PERF_IN): prepare FORCE
> > >         $(Q)$(MAKE) $(build)=perf
> > >
> > > -$(PMU_EVENTS_IN): FORCE
> > > +$(PMU_EVENTS_IN): FORCE prepare
> > >         $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
> > >
> > >  $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
> > > @@ -774,6 +780,12 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
> > >         $(rename_flags_array) \
> > >         $(arch_errno_name_array) \
> > >         $(sync_file_range_arrays) \
> > > +       $(LIBAPI) \
> > > +       $(LIBBPF) \
> > > +       $(LIBPERF) \
> > > +       $(LIBSUBCMD) \
> > > +       $(LIBSYMBOL) \
> > > +       $(LIBTRACEEVENT) \
> > >         bpf-skel
> > >
> > >  $(OUTPUT)%.o: %.c prepare FORCE
> > >
> > > ⬢[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools/perf build-test
> > > 0a1e208afdccce71 (HEAD -> perf/tools-libs-includes) perf build: Use tools/lib headers from install path
> > > make: Entering directory '/var/home/acme/git/perf/tools/perf'
> > > - tarpkg: ./tests/perf-targz-src-pkg .
> > >                  make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.YueDE1rSyh
> > >               make_with_gtk2: cd . && make GTK2=1 -j32  DESTDIR=/tmp/tmp.YuHTyobvdL
> > > cd . && make GTK2=1 -j32 DESTDIR=/tmp/tmp.YuHTyobvdL
> > >   BUILD:   Doing 'make -j32' parallel build
> > >   HOSTCC  fixdep.o
> > >   HOSTLD  fixdep-in.o
> > >   LINK    fixdep
> > > Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_regs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_regs.h'
> > > diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/include/uapi/asm/perf_regs.h
> > > Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' differs from latest version at 'arch/arm64/include/asm/cputype.h'
> > > diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h
> > > Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'
> > > diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
> > >
> > > Auto-detecting system features:
> > > ...                                   dwarf: [ on  ]
> > > ...                      dwarf_getlocations: [ on  ]
> > > ...                                   glibc: [ on  ]
> > > ...                                  libbfd: [ on  ]
> > > ...                          libbfd-buildid: [ on  ]
> > > ...                                  libcap: [ on  ]
> > > ...                                  libelf: [ on  ]
> > > ...                                 libnuma: [ on  ]
> > > ...                  numa_num_possible_cpus: [ on  ]
> > > ...                                 libperl: [ on  ]
> > > ...                               libpython: [ on  ]
> > > ...                               libcrypto: [ on  ]
> > > ...                               libunwind: [ on  ]
> > > ...                      libdw-dwarf-unwind: [ on  ]
> > > ...                                    zlib: [ on  ]
> > > ...                                    lzma: [ on  ]
> > > ...                               get_cpuid: [ on  ]
> > > ...                                     bpf: [ on  ]
> > > ...                                  libaio: [ on  ]
> > > ...                                 libzstd: [ on  ]
> > >
> > >   GEN     common-cmds.h
> > >   CC      perf-read-vdso32
> > >   CC      dlfilters/dlfilter-test-api-v0.o
> > >   CC      dlfilters/dlfilter-show-cycles.o
> > >   CC      jvmti/libjvmti.o
> > >   CC      jvmti/jvmti_agent.o
> > >   CC      jvmti/libstring.o
> > >   CC      jvmti/libctype.o
> > >   CC      ui/gtk/browser.o
> > >   CC      ui/gtk/hists.o
> > >   CC      ui/gtk/setup.o
> > >   CC      ui/gtk/util.o
> > >   CC      ui/gtk/helpline.o
> > >   CC      ui/gtk/progress.o
> > >   CC      ui/gtk/annotate.o
> > >   LINK    dlfilters/dlfilter-show-cycles.so
> > >   CC      ui/gtk/zalloc.o
> > >   LINK    dlfilters/dlfilter-test-api-v0.so
> > >   INSTALL headers
> > >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/exec-cmd.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/help.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/pager.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/parse-options.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/run-command.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/sigchain.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/subcmd-config.o
> > >   LD      jvmti/jvmti-in.o
> > >   INSTALL headers
> > > In file included from ui/gtk/hists.c:2:
> > > /var/home/acme/git/perf/tools/perf/util/include/../evlist.h:9:10: fatal error: api/fd/array.h: No such file or directory
> > >     9 | #include <api/fd/array.h>
> > >       |          ^~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > make[6]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: ui/gtk/hists.o] Error 1
> > > make[6]: *** Waiting for unfinished jobs....
> > > In file included from ui/gtk/browser.c:2:
> > > /var/home/acme/git/perf/tools/perf/util/include/../evsel.h:10:10: fatal error: internal/evsel.h: No such file or directory
> > >    10 | #include <internal/evsel.h>
> > >       |          ^~~~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > make[6]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: ui/gtk/browser.o] Error 1
> > > make -f /var/home/acme/git/perf/tools/build/Makefile.build dir=. obj=libsymbol V=1
> > >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent/event-parse.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_jbd2.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_hrtimer.o
> > >   INSTALL headers
> > >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_kmem.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_kvm.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_mac80211.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libperf/core.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libperf/cpumap.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libperf/threadmap.o
> > >   INSTALL headers
> > >   gcc -Wp,-MD,/var/home/acme/git/perf/tools/perf/libsymbol/.kallsyms.o.d -Wp,-MT,/var/home/acme/git/perf/tools/perf/libsymbol/kallsyms.o -Wbad-function-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k -Winit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-prototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat -Wno-type-limits -Wstrict-aliasing=3 -Wshadow -ggdb3 -Wall -Wextra -std=gnu11 -U_FORTIFY_SOURCE -fPIC -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -I/var/home/acme/git/perf/tools/lib -I/var/home/acme/git/perf/tools/include -D"BUILD_STR(s)=#s" -c -o /var/home/acme/git/perf/tools/perf/libsymbol/kallsyms.o kallsyms.c
> > >   CC      /var/home/acme/git/perf/tools/perf/libperf/evsel.o
> > >   LINK    libperf-jvmti.so
> > >   CC      /var/home/acme/git/perf/tools/perf/libperf/evlist.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libperf/mmap.o
> > >   MKDIR   /var/home/acme/git/perf/tools/perf/libapi/fd/
> > >   LD      /var/home/acme/git/perf/tools/perf/libsubcmd/libsubcmd-in.o
> > >   PERF_VERSION = 6.1.rc5.g0a1e208afdcc
> > >   CC      /var/home/acme/git/perf/tools/perf/libperf/zalloc.o
> > >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_jbd2-in.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libperf/xyarray.o
> > >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_hrtimer-in.o
> > >   CC      /var/home/acme/git/perf/tools/perf/libapi/fd/array.o
> > >   GEN     /var/home/acme/git/perf/tools/perf/libbpf/bpf_helper_defs.h
> > >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_kmem-in.o
> > >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_mac80211-in.o
> > >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plugin_kvm-in.o
> > >   INSTALL /var/home/acme/git/perf/tools/perf/libbpf/include/bpf/bpf.h
> > >
> >
> > Looks like the GTK part of the build isn't depending on the prepare
> > step. I'll take a look.
> >
> > Thanks,
> > Ian
> 
> Yep. The target:
> 
> $(GTK_IN): FORCE
> 
> should be:
> 
> $(GTK_IN): FORCE prepare
> 
> Could you try this, or do you want me to resend?

I'll try it, thanks
 
- Arnaldo
