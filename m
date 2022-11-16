Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8819862C558
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 17:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiKPQuf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 11:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239183AbiKPQuP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 11:50:15 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99E85656F
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 08:48:03 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id k1so18481527vsc.13
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 08:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bxmeicDa1pZxbYdY2/CVfLUcqCGClcnTcTe/qaM6Qfo=;
        b=NuWp8JKSubOO1rUutTJE5MObfJWhjIjikiSpDtay6dNknZ2qdmzRg5MyUb/xviKURr
         SQ6eZv5FtCZ295xH6wkD0J2i8zz8LDHp5le0JLMFk+Gc6pypYZ+ulI2qwtHMCedxw5Rb
         pATA8DXZ/w2ZEb0D4lBkcv3rOfqNu/DZekyPXbQ1dbxNy312jFOTXXxVTcEmIvoze9wW
         JdQ28QK/uY3NJ4wyS5cnR1mH06p4T5Sb95RElW4KQF1YTR9k/QkCdH4rIEDbFdjs3bqP
         ZiVE/lnCOdxqHdb0M82aluHsLId+eoQLjD/YfJfxdPOwb32ozK83Nz7NFqmmNhRDYLsh
         uh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bxmeicDa1pZxbYdY2/CVfLUcqCGClcnTcTe/qaM6Qfo=;
        b=2GyIv8a/7scimI7rvK/o+Sm7rZiYNFg8vgehN/Mmq2/BLjQrIKE+YgI2e2Kt+xuwnk
         dgVmwCiKft7FYclrPDqBcIjqWNhUrXS7zmZa0PoiJ6uhIgcbBdIXIHadSK+CeJKMZ+PE
         n00a0nzfnKJ8Ux3ksWynhbA9sVVywbIFCiAnYFGYhqkoHexv91u2t8pQsSfIZL7W1tu9
         mZhv2CNzezVyXWzBuwXHyjxwkHVyf5QhNwiqWdYn8zRjyaFMHxUWL9nfLxfWPpyyq9tX
         B11dypHkQ2ybUREH+ecx6BgbljdglgViLIaiaY35KLwtHfAZVYCtrhmAeL7dV2UwtMfK
         3/zw==
X-Gm-Message-State: ANoB5pmcJx9j9d5t/BucSGVcS1UzBLxG4kMpsXY4uLPldEpw2+REruEs
        NoMOyzUmPDolXNCQWBPVxtnHrh2MF44rD6VHRnY3mg==
X-Google-Smtp-Source: AA0mqf5Xllu22MuRCG5QMCOrozjWlhXZHvf5uBD+qGl2ugHboN11Js66dL+mCDOV/WlRtx7X85QennWsLqdcwIQS4vs=
X-Received: by 2002:a05:6102:523:b0:3aa:7694:a95 with SMTP id
 m3-20020a056102052300b003aa76940a95mr11188560vsa.41.1668617282382; Wed, 16
 Nov 2022 08:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20221116072211.2837834-1-irogers@google.com> <Y3T/fxPOvZgePIEz@kernel.org>
 <Y3UAX3U/cpszMFE7@kernel.org> <CAP-5=fWu2Ywz9rC3fq9GSnASbJu4hyiF4bqyrSDi34Rz6A8y+A@mail.gmail.com>
In-Reply-To: <CAP-5=fWu2Ywz9rC3fq9GSnASbJu4hyiF4bqyrSDi34Rz6A8y+A@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Nov 2022 08:47:51 -0800
Message-ID: <CAP-5=fX5X8=-jbj7wo7LZpNhgYzJqPJ1duJbdf2zH3HtPhcdsA@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fix perf tools/lib includes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 8:45 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 16, 2022 at 7:23 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Nov 16, 2022 at 12:19:27PM -0300, Arnaldo Carvalho de Melo escr=
eveu:
> > > Em Tue, Nov 15, 2022 at 11:22:10PM -0800, Ian Rogers escreveu:
> > > > This patch replaces the last on kernel/git/acme/linux.git branch
> > > > perf/tools-libs-includes and fixes the race issue by using the prep=
are
> > > > dependency. pmu-events.c needs this dependency too, as the header
> > > > files it includes also include libperf - using perpare as a depende=
ncy
> > > > rather than $(LIBPERF) is more consistent with the rest of the make=
file.
> > > >
> > > > Ian Rogers (1):
> > > >   perf build: Use tools/lib headers from install path
> > >
> > > Testing.
> >
> > =E2=AC=A2[acme@toolbox perf]$ git log acme/perf/core.. --oneline
> > 0a1e208afdccce71 (HEAD -> perf/tools-libs-includes) perf build: Use too=
ls/lib headers from install path
> > 17ca352f2aff834e perf cpumap: Tidy libperf includes
> > fd3f518fc1140622 perf thread_map: Reduce exposure of libperf internal A=
PI
> > bd560973c5d3b2a3 perf expr: Tidy hashmap dependency
> > 84bec6f0b31fb2ac perf build: Install libsymbol locally when building
> > 160be157eaba2a37 tool lib symbol: Add Makefile/Build
> > a6e8caf5db2e1db8 tools lib perf: Add missing install headers
> > 8d1f68bd76a6517c tools lib api: Add missing install headers
> > ef019df01e207971 perf build: Install libtraceevent locally when buildin=
g
> > 91009a3a9913f275 perf build: Install libperf locally when building
> > 00314c9bca8faad4 perf build: Install libapi locally when building
> > 911920b06e6be3fa perf build: Install libsubcmd locally when building
> > 630ae80ea1dd2536 tools lib subcmd: Add install target
> > a6efaa2c89bf35c3 tools lib api: Add install target
> > =E2=AC=A2[acme@toolbox perf]$
> >
> > =E2=AC=A2[acme@toolbox perf]$ git show
> > commit 0a1e208afdccce7193cbe4031dfd255c89c425d6
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Tue Nov 15 23:22:11 2022 -0800
> >
> >     perf build: Use tools/lib headers from install path
> >
> >     Switch -I from tools/lib to the install path for the tools/lib
> >     libraries. Add the include_headers build targets to prepare target,=
 as
> >     well as pmu-events.c compilation that dependes on libperf.
> >
> >     Signed-off-by: Ian Rogers <irogers@google.com>
> >     Acked-by: Namhyung Kim <namhyung@kernel.org>
> >     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> >     Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> >     Cc: Jiri Olsa <jolsa@kernel.org>
> >     Cc: Mark Rutland <mark.rutland@arm.com>
> >     Cc: Masahiro Yamada <masahiroy@kernel.org>
> >     Cc: Nick Desaulniers <ndesaulniers@google.com>
> >     Cc: Nicolas Schier <nicolas@fjasle.eu>
> >     Cc: Peter Zijlstra <peterz@infradead.org>
> >     Cc: Stephane Eranian <eranian@google.com>
> >     Cc: bpf@vger.kernel.org
> >     Link: http://lore.kernel.org/lkml/20221109184914.1357295-15-irogers=
@google.com
> >     Link: http://lore.kernel.org/lkml/20221116072211.2837834-2-irogers@=
google.com
> >     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index a7f6c0669fae4d24..9cc3c48f32881c8b 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -349,7 +349,6 @@ ifeq ($(DEBUG),0)
> >    endif
> >  endif
> >
> > -INC_FLAGS +=3D -I$(srctree)/tools/lib/perf/include
> >  INC_FLAGS +=3D -I$(src-perf)/util/include
> >  INC_FLAGS +=3D -I$(src-perf)/arch/$(SRCARCH)/include
> >  INC_FLAGS +=3D -I$(srctree)/tools/include/
> > @@ -367,7 +366,6 @@ endif
> >
> >  INC_FLAGS +=3D -I$(src-perf)/util
> >  INC_FLAGS +=3D -I$(src-perf)
> > -INC_FLAGS +=3D -I$(srctree)/tools/lib/
> >
> >  CORE_CFLAGS +=3D -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -D_GNU=
_SOURCE
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 6c1a2a3ccc38195f..dd096aba4430e3e4 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -305,6 +305,7 @@ LIBTRACEEVENT_INCLUDE =3D $(LIBTRACEEVENT_DESTDIR)/=
include
> >  LIBTRACEEVENT =3D $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
> >  export LIBTRACEEVENT
> >  LIBTRACEEVENT_DYNAMIC_LIST =3D $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtrac=
eevent-dynamic-list
> > +CFLAGS +=3D -I$(LIBTRACEEVENT_OUTPUT)/include
> >
> >  #
> >  # The static build has no dynsym table, so this does not work for
> > @@ -322,6 +323,7 @@ LIBAPI_DESTDIR =3D $(LIBAPI_OUTPUT)
> >  LIBAPI_INCLUDE =3D $(LIBAPI_DESTDIR)/include
> >  LIBAPI =3D $(LIBAPI_OUTPUT)/libapi.a
> >  export LIBAPI
> > +CFLAGS +=3D -I$(LIBAPI_OUTPUT)/include
> >
> >  ifneq ($(OUTPUT),)
> >    LIBBPF_OUTPUT =3D $(abspath $(OUTPUT))/libbpf
> > @@ -331,6 +333,7 @@ endif
> >  LIBBPF_DESTDIR =3D $(LIBBPF_OUTPUT)
> >  LIBBPF_INCLUDE =3D $(LIBBPF_DESTDIR)/include
> >  LIBBPF =3D $(LIBBPF_OUTPUT)/libbpf.a
> > +CFLAGS +=3D -I$(LIBBPF_OUTPUT)/include
> >
> >  ifneq ($(OUTPUT),)
> >    LIBSUBCMD_OUTPUT =3D $(abspath $(OUTPUT))/libsubcmd
> > @@ -340,6 +343,7 @@ endif
> >  LIBSUBCMD_DESTDIR =3D $(LIBSUBCMD_OUTPUT)
> >  LIBSUBCMD_INCLUDE =3D $(LIBSUBCMD_DESTDIR)/include
> >  LIBSUBCMD =3D $(LIBSUBCMD_OUTPUT)/libsubcmd.a
> > +CFLAGS +=3D -I$(LIBSUBCMD_OUTPUT)/include
> >
> >  ifneq ($(OUTPUT),)
> >    LIBSYMBOL_OUTPUT =3D $(abspath $(OUTPUT))/libsymbol
> > @@ -349,6 +353,7 @@ endif
> >  LIBSYMBOL_DESTDIR =3D $(LIBSYMBOL_OUTPUT)
> >  LIBSYMBOL_INCLUDE =3D $(LIBSYMBOL_DESTDIR)/include
> >  LIBSYMBOL =3D $(LIBSYMBOL_OUTPUT)/libsymbol.a
> > +CFLAGS +=3D -I$(LIBSYMBOL_OUTPUT)/include
> >
> >  ifneq ($(OUTPUT),)
> >    LIBPERF_OUTPUT =3D $(abspath $(OUTPUT))/libperf
> > @@ -359,6 +364,7 @@ LIBPERF_DESTDIR =3D $(LIBPERF_OUTPUT)
> >  LIBPERF_INCLUDE =3D $(LIBPERF_DESTDIR)/include
> >  LIBPERF =3D $(LIBPERF_OUTPUT)/libperf.a
> >  export LIBPERF
> > +CFLAGS +=3D -I$(LIBPERF_OUTPUT)/include
> >
> >  # python extension build directories
> >  PYTHON_EXTBUILD     :=3D $(OUTPUT)python_ext_build/
> > @@ -691,7 +697,7 @@ build :=3D -f $(srctree)/tools/build/Makefile.build=
 dir=3D. obj
> >  $(PERF_IN): prepare FORCE
> >         $(Q)$(MAKE) $(build)=3Dperf
> >
> > -$(PMU_EVENTS_IN): FORCE
> > +$(PMU_EVENTS_IN): FORCE prepare
> >         $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3Dpmu-=
events obj=3Dpmu-events
> >
> >  $(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT=
_DYNAMIC_LIST)
> > @@ -774,6 +780,12 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)commo=
n-cmds.h archheaders $(drm_ioc
> >         $(rename_flags_array) \
> >         $(arch_errno_name_array) \
> >         $(sync_file_range_arrays) \
> > +       $(LIBAPI) \
> > +       $(LIBBPF) \
> > +       $(LIBPERF) \
> > +       $(LIBSUBCMD) \
> > +       $(LIBSYMBOL) \
> > +       $(LIBTRACEEVENT) \
> >         bpf-skel
> >
> >  $(OUTPUT)%.o: %.c prepare FORCE
> >
> > =E2=AC=A2[acme@toolbox perf]$ git log --oneline -1 ; time make -C tools=
/perf build-test
> > 0a1e208afdccce71 (HEAD -> perf/tools-libs-includes) perf build: Use too=
ls/lib headers from install path
> > make: Entering directory '/var/home/acme/git/perf/tools/perf'
> > - tarpkg: ./tests/perf-targz-src-pkg .
> >                  make_static: cd . && make LDFLAGS=3D-static NO_PERF_RE=
AD_VDSO32=3D1 NO_PERF_READ_VDSOX32=3D1 NO_JVMTI=3D1 -j32  DESTDIR=3D/tmp/tm=
p.YueDE1rSyh
> >               make_with_gtk2: cd . && make GTK2=3D1 -j32  DESTDIR=3D/tm=
p/tmp.YuHTyobvdL
> > cd . && make GTK2=3D1 -j32 DESTDIR=3D/tmp/tmp.YuHTyobvdL
> >   BUILD:   Doing 'make -j32' parallel build
> >   HOSTCC  fixdep.o
> >   HOSTLD  fixdep-in.o
> >   LINK    fixdep
> > Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/perf_r=
egs.h' differs from latest version at 'arch/arm64/include/uapi/asm/perf_reg=
s.h'
> > diff -u tools/arch/arm64/include/uapi/asm/perf_regs.h arch/arm64/includ=
e/uapi/asm/perf_regs.h
> > Warning: Kernel ABI header at 'tools/arch/arm64/include/asm/cputype.h' =
differs from latest version at 'arch/arm64/include/asm/cputype.h'
> > diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/c=
putype.h
> > Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/s=
yscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/sy=
scall.tbl'
> > diff -u tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc=
/kernel/syscalls/syscall.tbl
> >
> > Auto-detecting system features:
> > ...                                   dwarf: [ on  ]
> > ...                      dwarf_getlocations: [ on  ]
> > ...                                   glibc: [ on  ]
> > ...                                  libbfd: [ on  ]
> > ...                          libbfd-buildid: [ on  ]
> > ...                                  libcap: [ on  ]
> > ...                                  libelf: [ on  ]
> > ...                                 libnuma: [ on  ]
> > ...                  numa_num_possible_cpus: [ on  ]
> > ...                                 libperl: [ on  ]
> > ...                               libpython: [ on  ]
> > ...                               libcrypto: [ on  ]
> > ...                               libunwind: [ on  ]
> > ...                      libdw-dwarf-unwind: [ on  ]
> > ...                                    zlib: [ on  ]
> > ...                                    lzma: [ on  ]
> > ...                               get_cpuid: [ on  ]
> > ...                                     bpf: [ on  ]
> > ...                                  libaio: [ on  ]
> > ...                                 libzstd: [ on  ]
> >
> >   GEN     common-cmds.h
> >   CC      perf-read-vdso32
> >   CC      dlfilters/dlfilter-test-api-v0.o
> >   CC      dlfilters/dlfilter-show-cycles.o
> >   CC      jvmti/libjvmti.o
> >   CC      jvmti/jvmti_agent.o
> >   CC      jvmti/libstring.o
> >   CC      jvmti/libctype.o
> >   CC      ui/gtk/browser.o
> >   CC      ui/gtk/hists.o
> >   CC      ui/gtk/setup.o
> >   CC      ui/gtk/util.o
> >   CC      ui/gtk/helpline.o
> >   CC      ui/gtk/progress.o
> >   CC      ui/gtk/annotate.o
> >   LINK    dlfilters/dlfilter-show-cycles.so
> >   CC      ui/gtk/zalloc.o
> >   LINK    dlfilters/dlfilter-test-api-v0.so
> >   INSTALL headers
> >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/exec-cmd.o
> >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/help.o
> >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/pager.o
> >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/parse-options.o
> >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/run-command.o
> >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/sigchain.o
> >   CC      /var/home/acme/git/perf/tools/perf/libsubcmd/subcmd-config.o
> >   LD      jvmti/jvmti-in.o
> >   INSTALL headers
> > In file included from ui/gtk/hists.c:2:
> > /var/home/acme/git/perf/tools/perf/util/include/../evlist.h:9:10: fatal=
 error: api/fd/array.h: No such file or directory
> >     9 | #include <api/fd/array.h>
> >       |          ^~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[6]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: ui=
/gtk/hists.o] Error 1
> > make[6]: *** Waiting for unfinished jobs....
> > In file included from ui/gtk/browser.c:2:
> > /var/home/acme/git/perf/tools/perf/util/include/../evsel.h:10:10: fatal=
 error: internal/evsel.h: No such file or directory
> >    10 | #include <internal/evsel.h>
> >       |          ^~~~~~~~~~~~~~~~~~
> > compilation terminated.
> > make[6]: *** [/var/home/acme/git/perf/tools/build/Makefile.build:97: ui=
/gtk/browser.o] Error 1
> > make -f /var/home/acme/git/perf/tools/build/Makefile.build dir=3D. obj=
=3Dlibsymbol V=3D1
> >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent/event-parse.=
o
> >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_jbd2.o
> >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_hrtimer.o
> >   INSTALL headers
> >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_kmem.o
> >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_kvm.o
> >   CC      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_mac80211.o
> >   CC      /var/home/acme/git/perf/tools/perf/libperf/core.o
> >   CC      /var/home/acme/git/perf/tools/perf/libperf/cpumap.o
> >   CC      /var/home/acme/git/perf/tools/perf/libperf/threadmap.o
> >   INSTALL headers
> >   gcc -Wp,-MD,/var/home/acme/git/perf/tools/perf/libsymbol/.kallsyms.o.=
d -Wp,-MT,/var/home/acme/git/perf/tools/perf/libsymbol/kallsyms.o -Wbad-fun=
ction-cast -Wdeclaration-after-statement -Wformat-security -Wformat-y2k -Wi=
nit-self -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wno-=
system-headers -Wold-style-definition -Wpacked -Wredundant-decls -Wstrict-p=
rototypes -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat -=
Wno-type-limits -Wstrict-aliasing=3D3 -Wshadow -ggdb3 -Wall -Wextra -std=3D=
gnu11 -U_FORTIFY_SOURCE -fPIC -Werror -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_=
BITS=3D64 -I/var/home/acme/git/perf/tools/lib -I/var/home/acme/git/perf/too=
ls/include -D"BUILD_STR(s)=3D#s" -c -o /var/home/acme/git/perf/tools/perf/l=
ibsymbol/kallsyms.o kallsyms.c
> >   CC      /var/home/acme/git/perf/tools/perf/libperf/evsel.o
> >   LINK    libperf-jvmti.so
> >   CC      /var/home/acme/git/perf/tools/perf/libperf/evlist.o
> >   CC      /var/home/acme/git/perf/tools/perf/libperf/mmap.o
> >   MKDIR   /var/home/acme/git/perf/tools/perf/libapi/fd/
> >   LD      /var/home/acme/git/perf/tools/perf/libsubcmd/libsubcmd-in.o
> >   PERF_VERSION =3D 6.1.rc5.g0a1e208afdcc
> >   CC      /var/home/acme/git/perf/tools/perf/libperf/zalloc.o
> >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_jbd2-in.o
> >   CC      /var/home/acme/git/perf/tools/perf/libperf/xyarray.o
> >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_hrtimer-in.o
> >   CC      /var/home/acme/git/perf/tools/perf/libapi/fd/array.o
> >   GEN     /var/home/acme/git/perf/tools/perf/libbpf/bpf_helper_defs.h
> >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_kmem-in.o
> >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_mac80211-in.o
> >   LD      /var/home/acme/git/perf/tools/perf/libtraceevent_plugins/plug=
in_kvm-in.o
> >   INSTALL /var/home/acme/git/perf/tools/perf/libbpf/include/bpf/bpf.h
> >
>
> Looks like the GTK part of the build isn't depending on the prepare
> step. I'll take a look.
>
> Thanks,
> Ian

Yep. The target:

$(GTK_IN): FORCE

should be:

$(GTK_IN): FORCE prepare

Could you try this, or do you want me to resend?

Thanks,
Ian
