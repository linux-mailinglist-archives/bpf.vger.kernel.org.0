Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9D645E83
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 17:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLGQQm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 11:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGQQl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 11:16:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C95B5B9
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 08:16:37 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l26so7799840wms.4
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MM1yOB5UEiOpd3UaNHjdZ3NR/CZQlfeR1Sb4tjySqrI=;
        b=CYu/jOEoXnFP4GkrrtNv7ZWEAaFMnC063PUnL0LBgol8RaeGxC87teNSJj6APQrJAs
         JrtnqOk4G3fPcTx0OV2alax1Gnuoztukl1RbpT3wIymqd596aS3EqfXkeumKS08b13gq
         QiNSb+JMnk/fvKtL/mQ10faULFNUYNaiinl+oI2GQ2nI/Yca7Fi9B8VDEThsuEsM+vd0
         fuNJCPTOyB9ejgUF62PVrFC22mVNTrzsuLE2jJSpQte+h4K34HZdIgLjcczOSUgevOPc
         z6k/E6bcGmPJbjw+IAk6nsOkVZwRU6hKOqi8C2KinYvmoxi/WLyBLU88aUMilYPNVQV5
         rvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MM1yOB5UEiOpd3UaNHjdZ3NR/CZQlfeR1Sb4tjySqrI=;
        b=jfiaCPlL20DghJMxEB8w2XzzwMwuSnmwFy2uHaHF8EwnOHRiL8eyV+OIb5/DxmWsHC
         kb9fGuXIYZ178lKGJQR3nkotbKgxFNu6+5e1XQrAsAB5XwZdCKBmbvP+WVivlRZfhc4t
         ZoyJOelhgdidNxIDWTeTyftdKw3l6rw7um58kt9OuHBdE0FJ2UESG2AooZ3j9fGsU+c1
         wU2K3P/kEFXR1OBCKEtit3VZrgmmo1LUv94B/VJWnbi5NaCdhyr4KaXQPNkpFtzY9wJ/
         riyReS/i97NJdvF9G+GDwVy0jS0Xx4XBBcl+8KAAV95GuBNN3IEXhUuMYyPgJzl61Kpa
         YxXQ==
X-Gm-Message-State: ANoB5pk1XYGz1xZvf9m58CyW5a0no+paMHuXBgjtPkJuUTooUCSu18b9
        zLPtidNso0qXBeYpMjLvJ9OaKSLhSZ3PJh+Dtf0PaA==
X-Google-Smtp-Source: AA0mqf7/pl2M6rRotpNkgrI1vOk1YsQpJrgg6dtA6RkzFA5xdJIk7Ij0uudnOEfh/JHK2YuWy4jHfA+QcSIQQEMkv90=
X-Received: by 2002:a1c:7318:0:b0:3cf:cb16:f24a with SMTP id
 d24-20020a1c7318000000b003cfcb16f24amr69333887wmb.182.1670429795392; Wed, 07
 Dec 2022 08:16:35 -0800 (PST)
MIME-Version: 1.0
References: <20221205225940.3079667-1-irogers@google.com> <20221205225940.3079667-3-irogers@google.com>
 <D686CA02-66EC-4191-BCDB-80A11DD60CAC@linux.vnet.ibm.com>
In-Reply-To: <D686CA02-66EC-4191-BCDB-80A11DD60CAC@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 7 Dec 2022 08:16:22 -0800
Message-ID: <CAP-5=fV7ruBrzH5-Ze954RHkAfdVMN1khKzSgvdFUzkRqgcuSA@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf build: Use libtraceevent from the system
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 7, 2022 at 5:46 AM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 06-Dec-2022, at 4:29 AM, Ian Rogers <irogers@google.com> wrote:
> >
> > Remove the LIBTRACEEVENT_DYNAMIC and LIBTRACEFS_DYNAMIC. If
> > libtraceevent isn't installed or NO_LIBTRACEEVENT=1 is passed to the
> > build, don't compile in libtraceevent and libtracefs support. This
> > also disables CONFIG_TRACE that controls "perf
> > trace". CONFIG_TRACEEVENT is used to control enablement in
> > Build/Makefiles, HAVE_LIBTRACEEVENT is used in C code. Without
> > HAVE_LIBTRACEEVENT tracepoints are disabled and as such the commands
> > kmem, kwork, lock, sched and timechart are removed. The majority of
> > commands continue to work including "perf test".
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > tools/perf/Build                              | 11 ++-
> > tools/perf/Makefile.config                    | 37 +++----
> > tools/perf/Makefile.perf                      | 99 +------------------
> > tools/perf/arch/x86/util/Build                |  2 +-
> > tools/perf/arch/x86/util/intel-pt.c           |  4 +
> > tools/perf/builtin-annotate.c                 |  2 +
> > tools/perf/builtin-inject.c                   |  8 ++
> > tools/perf/builtin-kmem.c                     |  1 +
> > tools/perf/builtin-kvm.c                      | 12 +--
> > tools/perf/builtin-kwork.c                    |  1 +
> > tools/perf/builtin-record.c                   |  2 +
> > tools/perf/builtin-report.c                   |  9 +-
> > tools/perf/builtin-script.c                   | 19 +++-
> > tools/perf/builtin-timechart.c                |  1 +
> > tools/perf/builtin-trace.c                    |  5 +-
> > tools/perf/builtin-version.c                  |  1 +
> > tools/perf/perf.c                             | 24 +++--
> > .../perf/scripts/python/Perf-Trace-Util/Build |  2 +-
> > tools/perf/tests/Build                        | 12 +--
> > tools/perf/tests/builtin-test.c               |  6 ++
> > tools/perf/tests/parse-events.c               | 20 ++++
> > tools/perf/util/Build                         | 10 +-
> > tools/perf/util/data-convert-bt.c             |  5 +-
> > tools/perf/util/data-convert-json.c           |  9 +-
> > tools/perf/util/evlist.c                      |  6 +-
> > tools/perf/util/evlist.h                      |  4 +
> > tools/perf/util/evsel.c                       | 11 ++-
> > tools/perf/util/evsel.h                       | 12 ++-
> > tools/perf/util/evsel_fprintf.c               |  7 +-
> > tools/perf/util/header.c                      | 19 ++++
> > tools/perf/util/header.h                      |  2 +
> > tools/perf/util/intel-pt.c                    |  7 +-
> > tools/perf/util/parse-events.c                | 15 +++
> > tools/perf/util/parse-events.h                |  1 -
> > tools/perf/util/python.c                      |  4 +
> > tools/perf/util/scripting-engines/Build       |  6 +-
> > .../scripting-engines/trace-event-python.c    |  1 +
> > tools/perf/util/session.c                     |  2 +
> > tools/perf/util/session.h                     |  2 +
> > tools/perf/util/sort.c                        | 60 +++++++++--
> > tools/perf/util/synthetic-events.c            |  6 ++
> > tools/perf/util/trace-event-parse.c           |  2 +
> > tools/perf/util/trace-event-read.c            |  1 +
> > tools/perf/util/trace-event-scripting.c       |  1 +
> > tools/perf/util/trace-event.c                 |  1 -
> > tools/perf/util/trace-event.h                 | 11 ++-
> > 46 files changed, 312 insertions(+), 171 deletions(-)
> >
> > diff --git a/tools/perf/Build b/tools/perf/Build
> > index 496b096153bb..edafe3cb3d07 100644
> > --- a/tools/perf/Build
> > +++ b/tools/perf/Build
> > @@ -5,7 +5,6 @@ perf-y += builtin-diff.o
> > perf-y += builtin-evlist.o
> > perf-y += builtin-ftrace.o
> > perf-y += builtin-help.o
> > -perf-y += builtin-sched.o
> > perf-y += builtin-buildid-list.o
> > perf-y += builtin-buildid-cache.o
> > perf-y += builtin-kallsyms.o
> > @@ -13,11 +12,8 @@ perf-y += builtin-list.o
> > perf-y += builtin-record.o
> > perf-y += builtin-report.o
> > perf-y += builtin-stat.o
> > -perf-y += builtin-timechart.o
> > perf-y += builtin-top.o
> > perf-y += builtin-script.o
> > -perf-y += builtin-kmem.o
> > -perf-y += builtin-lock.o
> > perf-y += builtin-kvm.o
> > perf-y += builtin-inject.o
> > perf-y += builtin-mem.o
> > @@ -25,7 +21,12 @@ perf-y += builtin-data.o
> > perf-y += builtin-version.o
> > perf-y += builtin-c2c.o
> > perf-y += builtin-daemon.o
> > -perf-y += builtin-kwork.o
> > +
> > +perf-$(CONFIG_TRACEEVENT) += builtin-kmem.o
> > +perf-$(CONFIG_TRACEEVENT) += builtin-kwork.o
> > +perf-$(CONFIG_TRACEEVENT) += builtin-lock.o
> > +perf-$(CONFIG_TRACEEVENT) += builtin-sched.o
> > +perf-$(CONFIG_TRACEEVENT) += builtin-timechart.o
> >
> > perf-$(CONFIG_TRACE) += builtin-trace.o
> > perf-$(CONFIG_LIBELF) += builtin-probe.o
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 9cc3c48f3288..b34288cb1900 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -763,18 +763,20 @@ ifndef NO_LIBUNWIND
> >   EXTLIBS += $(EXTLIBS_LIBUNWIND)
> > endif
> >
> > -ifeq ($(NO_SYSCALL_TABLE),0)
> > -  $(call detected,CONFIG_TRACE)
> > -else
> > -  ifndef NO_LIBAUDIT
> > -    $(call feature_check,libaudit)
> > -    ifneq ($(feature-libaudit), 1)
> > -      msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
> > -      NO_LIBAUDIT := 1
> > -    else
> > -      CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
> > -      EXTLIBS += -laudit
> > -      $(call detected,CONFIG_TRACE)
> > +ifneq ($(NO_LIBTRACEEVENT),1)
> > +  ifeq ($(NO_SYSCALL_TABLE),0)
> > +    $(call detected,CONFIG_TRACE)
> > +  else
> > +    ifndef NO_LIBAUDIT
> > +      $(call feature_check,libaudit)
> > +      ifneq ($(feature-libaudit), 1)
> > +        msg := $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev);
> > +        NO_LIBAUDIT := 1
> > +      else
> > +        CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
> > +        EXTLIBS += -laudit
> > +        $(call detected,CONFIG_TRACE)
> > +      endif
> >     endif
> >   endif
> > endif
> > @@ -1182,9 +1184,11 @@ ifdef LIBPFM4
> >   endif
> > endif
> >
> > -ifdef LIBTRACEEVENT_DYNAMIC
> > +# libtraceevent is a recommended dependency picked up from the system.
> > +ifneq ($(NO_LIBTRACEEVENT),1)
> >   $(call feature_check,libtraceevent)
> >   ifeq ($(feature-libtraceevent), 1)
> > +    CFLAGS += -DHAVE_LIBTRACEEVENT
> >     EXTLIBS += -ltraceevent
> >     LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
> >     LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
> > @@ -1192,12 +1196,11 @@ ifdef LIBTRACEEVENT_DYNAMIC
> >     LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
> >     LIBTRACEEVENT_VERSION_CPP := $(shell expr $(LIBTRACEEVENT_VERSION_1) \* 255 \* 255 + $(LIBTRACEEVENT_VERSION_2) \* 255 + $(LIBTRACEEVENT_VERSION_3))
> >     CFLAGS += -DLIBTRACEEVENT_VERSION=$(LIBTRACEEVENT_VERSION_CPP)
> > +    $(call detected,CONFIG_TRACEEVENT)
> >   else
> > -    dummy := $(error Error: No libtraceevent devel library found, please install libtraceevent-devel);
> > +    dummy := $(warning Warning: libtraceevent is missing limiting functionality, please install libtraceevent-dev)
> >   endif
> > -endif
> >
> > -ifdef LIBTRACEFS_DYNAMIC
> >   $(call feature_check,libtracefs)
> >   ifeq ($(feature-libtracefs), 1)
> >     EXTLIBS += -ltracefs
> > @@ -1207,8 +1210,6 @@ ifdef LIBTRACEFS_DYNAMIC
> >     LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
> >     LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
> >     CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
> > -  else
> > -    dummy := $(error Error: No libtracefs devel library found, please install libtracefs-dev);
> >   endif
> > endif
> >
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 6689f644782f..f0e4daeef812 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -128,10 +128,6 @@ include ../scripts/utilities.mak
> > #
> > # Define BUILD_BPF_SKEL to enable BPF skeletons
> > #
> > -# Define LIBTRACEEVENT_DYNAMIC to enable libtraceevent dynamic linking
> > -#
> > -# Define LIBTRACEFS_DYNAMIC to enable libtracefs dynamic linking
> > -#
> >
> > # As per kernel Makefile, avoid funny character set dependencies
> > unexport LC_ALL
> > @@ -242,10 +238,6 @@ sub-make: fixdep
> > else # force_fixdep
> >
> > LIBAPI_DIR      = $(srctree)/tools/lib/api/
> > -ifndef LIBTRACEEVENT_DYNAMIC
> > -LIBTRACEEVENT_DIR = $(srctree)/tools/lib/traceevent/
> > -LIBTRACEEVENT_PLUGINS_DIR = $(LIBTRACEEVENT_DIR)/plugins
> > -endif
> > LIBBPF_DIR      = $(srctree)/tools/lib/bpf/
> > LIBSUBCMD_DIR   = $(srctree)/tools/lib/subcmd/
> > LIBSYMBOL_DIR   = $(srctree)/tools/lib/symbol/
> > @@ -295,31 +287,6 @@ SCRIPT_SH += perf-iostat.sh
> > grep-libs = $(filter -l%,$(1))
> > strip-libs = $(filter-out -l%,$(1))
> >
> > -ifndef LIBTRACEEVENT_DYNAMIC
> > -ifneq ($(OUTPUT),)
> > -  LIBTRACEEVENT_OUTPUT = $(abspath $(OUTPUT))/libtraceevent
> > -else
> > -  LIBTRACEEVENT_OUTPUT = $(CURDIR)/libtraceevent
> > -endif
> > -LIBTRACEEVENT_PLUGINS_OUTPUT = $(LIBTRACEEVENT_OUTPUT)_plugins
> > -LIBTRACEEVENT_DESTDIR = $(LIBTRACEEVENT_OUTPUT)
> > -LIBTRACEEVENT_PLUGINS_DESTDIR = $(LIBTRACEEVENT_PLUGINS_OUTPUT)
> > -LIBTRACEEVENT_INCLUDE = $(LIBTRACEEVENT_DESTDIR)/include
> > -LIBTRACEEVENT = $(LIBTRACEEVENT_OUTPUT)/libtraceevent.a
> > -export LIBTRACEEVENT
> > -LIBTRACEEVENT_DYNAMIC_LIST = $(LIBTRACEEVENT_PLUGINS_OUTPUT)/libtraceevent-dynamic-list
> > -CFLAGS += -I$(LIBTRACEEVENT_OUTPUT)/include
> > -#
> > -# The static build has no dynsym table, so this does not work for
> > -# static build. Looks like linker starts to scream about that now
> > -# (in Fedora 26) so we need to switch it off for static build.
> > -DYNAMIC_LIST_LDFLAGS               = -Xlinker --dynamic-list=$(LIBTRACEEVENT_DYNAMIC_LIST)
> > -LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS = $(if $(findstring -static,$(LDFLAGS)),,$(DYNAMIC_LIST_LDFLAGS))
> > -else
> > -LIBTRACEEVENT_DYNAMIC_LIST =
> > -LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS =
> > -endif
> > -
> > ifneq ($(OUTPUT),)
> >   LIBAPI_OUTPUT = $(abspath $(OUTPUT))/libapi
> > else
> > @@ -381,11 +348,7 @@ export PYTHON_EXTBUILD_LIB PYTHON_EXTBUILD_TMP
> > python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT)python/perf*.so
> >
> > PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
> > -ifndef LIBTRACEEVENT_DYNAMIC
> > -PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBTRACEEVENT) $(LIBAPI)
> > -else
> > PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
> > -endif
> >
> > SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
> >
> > @@ -430,9 +393,6 @@ ifndef NO_LIBBPF
> >     PERFLIBS += $(LIBBPF)
> >   endif
> > endif
> > -ifndef LIBTRACEEVENT_DYNAMIC
> > -  PERFLIBS += $(LIBTRACEEVENT)
> > -endif
> >
> > # We choose to avoid "if .. else if .. else .. endif endif"
> > # because maintaining the nesting to match is a pain.  If
> > @@ -682,9 +642,9 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
> > # Create python binding output directory if not already present
> > _dummy := $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
> >
> > -$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBTRACEEVENT_DYNAMIC_LIST) $(LIBPERF)
> > +$(OUTPUT)python/perf.so: $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(LIBPERF)
> >       $(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
> > -        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS)' \
> > +        CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
> >         $(PYTHON_WORD) util/setup.py \
> >         --quiet build_ext; \
> >       cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
> > @@ -710,8 +670,8 @@ $(PERF_IN): prepare FORCE
> > $(PMU_EVENTS_IN): FORCE prepare
> >       $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
> >
> > -$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) $(LIBTRACEEVENT_DYNAMIC_LIST)
> > -     $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(LIBTRACEEVENT_DYNAMIC_LIST_LDFLAGS) \
> > +$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
> > +     $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
> >               $(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
> >
> > $(GTK_IN): FORCE prepare
> > @@ -797,10 +757,6 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-cmds.h archheaders $(drm_ioc
> >       $(LIBSYMBOL) \
> >       bpf-skel
> >
> > -ifndef LIBTRACEEVENT_DYNAMIC
> > -prepare: $(LIBTRACEEVENT)
> > -endif
> > -
> > $(OUTPUT)%.o: %.c prepare FORCE
> >       $(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=$(build-dir) $@
> >
> > @@ -856,38 +812,6 @@ endif
> >
> > $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
> >
> > -ifndef LIBTRACEEVENT_DYNAMIC
> > -LIBTRACEEVENT_FLAGS += plugin_dir=$(plugindir_SQ) 'EXTRA_CFLAGS=$(EXTRA_CFLAGS)' 'LDFLAGS=$(filter-out -static,$(LDFLAGS))'
> > -
> > -$(LIBTRACEEVENT): FORCE | $(LIBTRACEEVENT_OUTPUT)
> > -     $(Q)$(MAKE) -C $(LIBTRACEEVENT_DIR) O=$(LIBTRACEEVENT_OUTPUT) \
> > -             DESTDIR=$(LIBTRACEEVENT_DESTDIR) prefix= \
> > -             $@ install_headers
> > -
> > -$(LIBTRACEEVENT)-clean:
> > -     $(call QUIET_CLEAN, libtraceevent)
> > -     $(Q)$(RM) -r -- $(LIBTRACEEVENT_OUTPUT)
> > -
> > -libtraceevent_plugins: FORCE | $(LIBTRACEEVENT_PLUGINS_OUTPUT)
> > -     $(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
> > -             DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
> > -             plugins
> > -
> > -libtraceevent_plugins-clean:
> > -     $(call QUIET_CLEAN, libtraceevent_plugins)
> > -     $(Q)$(RM) -r -- $(LIBTRACEEVENT_PLUGINS_OUTPUT)
> > -
> > -$(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
> > -     $(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
> > -             DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
> > -             $(LIBTRACEEVENT_FLAGS) $@
> > -
> > -install-traceevent-plugins: libtraceevent_plugins
> > -     $(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
> > -             DESTDIR=$(DESTDIR_SQ)$(prefix) prefix= \
> > -             $(LIBTRACEEVENT_FLAGS) install
> > -endif
> > -
> > $(LIBAPI): FORCE | $(LIBAPI_OUTPUT)
> >       $(Q)$(MAKE) -C $(LIBAPI_DIR) O=$(LIBAPI_OUTPUT) \
> >               DESTDIR=$(LIBAPI_DESTDIR) prefix= \
> > @@ -1095,10 +1019,6 @@ install-tests: all install-gtk
> >
> > install-bin: install-tools install-tests
> >
> > -ifndef LIBTRACEEVENT_DYNAMIC
> > -install-bin: install-traceevent-plugins
> > -endif
> > -
> > install: install-bin try-install-man
> >
> > install-python_ext:
> > @@ -1124,11 +1044,6 @@ SKELETONS += $(SKEL_OUT)/kwork_trace.skel.h
> > $(SKEL_TMP_OUT) $(LIBAPI_OUTPUT) $(LIBBPF_OUTPUT) $(LIBPERF_OUTPUT) $(LIBSUBCMD_OUTPUT) $(LIBSYMBOL_OUTPUT):
> >       $(Q)$(MKDIR) -p $@
> >
> > -ifndef LIBTRACEEVENT_DYNAMIC
> > -$(LIBTRACEEVENT_OUTPUT) $(LIBTRACEEVENT_PLUGINS_OUTPUT):
> > -     $(Q)$(MKDIR) -p $@
> > -endif
> > -
> > ifdef BUILD_BPF_SKEL
> > BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
> > BPF_INCLUDE := -I$(SKEL_TMP_OUT)/.. -I$(LIBBPF_INCLUDE)
> > @@ -1211,10 +1126,6 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
> >       $(call QUIET_CLEAN, Documentation) \
> >       $(MAKE) -C $(DOC_DIR) O=$(OUTPUT) clean >/dev/null
> >
> > -ifndef LIBTRACEEVENT_DYNAMIC
> > -clean:: $(LIBTRACEEVENT)-clean libtraceevent_plugins-clean
> > -endif
> > -
> > #
> > # To provide FEATURE-DUMP into $(FEATURE_DUMP_COPY)
> > # file if defined, with no further action.
> > @@ -1232,6 +1143,6 @@ FORCE:
> > .PHONY: all install clean config-clean strip install-gtk
> > .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
> > .PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
> > -.PHONY: libtraceevent_plugins archheaders
> > +.PHONY: archheaders
> >
> > endif # force_fixdep
> > diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
> > index dbeb04cb336e..a92644f12eec 100644
> > --- a/tools/perf/arch/x86/util/Build
> > +++ b/tools/perf/arch/x86/util/Build
> > @@ -1,7 +1,7 @@
> > perf-y += header.o
> > perf-y += tsc.o
> > perf-y += pmu.o
> > -perf-y += kvm-stat.o
> > +perf-$(CONFIG_TRACEEVENT) += kvm-stat.o
>
> Hi,
>
> Observed build failure in powerpc with NO_LIBTRACEEVENT due to kvm-stat.c compile fail.
> CONFIG_TRACEEVENT  check is also needed in arch/powerpc/util/Build to fix this. Patch below:
>
> From e06f020f66435649c10fb7d391922f687d5b8206 Mon Sep 17 00:00:00 2001
> From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Date: Wed, 7 Dec 2022 16:46:30 +0530
> Subject: [PATCH] tools/perf/arch/powerpc: Disable kvm-stat when traceevent is
>  disabled
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> commit 407bb16c1a32 ("perf build: Use libtraceevent from the system")
> disables libtraceevent support when f libtraceevent isn't installed
> or NO_LIBTRACEEVENT=1 is passed. Commit added CONFIG_TRACEEVENT check
> for kvm-stat in x86/util/Build. But same has to be added in powerpc
> as well. Otherwise build will fail as below:
>
>         #make NO_LIBTRACEEVENT=1
>         arch/powerpc/util/kvm-stat.c: In function 'hcall_event_get_key':
> arch/powerpc/util/kvm-stat.c:42:20: error: implicit declaration of function 'evsel__intval'; did you mean 'evsel__env'? [-Werror=implicit-function-declaration]
>    42 |         key->key = evsel__intval(evsel, sample, "req");
>       |                    ^~~~~~~~~~~~~
>       |                    evsel__env
>
> Patch adds the check for CONFIG_TRACEEVENT in powerpc/util/Build.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Sorry for missing this.

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/powerpc/util/Build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
> index 0115f3166568..71e57f28abda 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -1,5 +1,5 @@
>  perf-y += header.o
> -perf-y += kvm-stat.o
> +perf-$(CONFIG_TRACEEVENT) += kvm-stat.o
>  perf-y += perf_regs.o
>  perf-y += mem-events.o
>  perf-y += sym-handling.o
> --
> 2.31.1
>
>
> I couldn't functionally check "perf kvm stat"  after this change since there are build issues remaining.
>
> Thanks
> Athira
>
> > perf-y += perf_regs.o
> > perf-y += topdown.o
> > perf-y += machine.o
> > diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> > index af102f471e9f..1e39a034cee9 100644
> > --- a/tools/perf/arch/x86/util/intel-pt.c
> > +++ b/tools/perf/arch/x86/util/intel-pt.c
> > @@ -418,6 +418,7 @@ static int intel_pt_info_fill(struct auxtrace_record *itr,
> >       return 0;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int intel_pt_track_switches(struct evlist *evlist)
> > {
> >       const char *sched_switch = "sched:sched_switch";
> > @@ -439,6 +440,7 @@ static int intel_pt_track_switches(struct evlist *evlist)
> >
> >       return 0;
> > }
> > +#endif
> >
> > static void intel_pt_valid_str(char *str, size_t len, u64 valid)
> > {
> > @@ -829,6 +831,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
> >                                       ptr->have_sched_switch = 2;
> >                       }
> >               } else {
> > +#ifdef HAVE_LIBTRACEEVENT
> >                       err = intel_pt_track_switches(evlist);
> >                       if (err == -EPERM)
> >                               pr_debug2("Unable to select sched:sched_switch\n");
> > @@ -836,6 +839,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
> >                               return err;
> >                       else
> >                               ptr->have_sched_switch = 1;
> > +#endif
> >               }
> >       }
> >
> > diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> > index 517d928c00e3..90458ca6933f 100644
> > --- a/tools/perf/builtin-annotate.c
> > +++ b/tools/perf/builtin-annotate.c
> > @@ -499,7 +499,9 @@ int cmd_annotate(int argc, const char **argv)
> >                       .namespaces = perf_event__process_namespaces,
> >                       .attr   = perf_event__process_attr,
> >                       .build_id = perf_event__process_build_id,
> > +#ifdef HAVE_LIBTRACEEVENT
> >                       .tracing_data   = perf_event__process_tracing_data,
> > +#endif
> >                       .id_index       = perf_event__process_id_index,
> >                       .auxtrace_info  = perf_event__process_auxtrace_info,
> >                       .auxtrace       = perf_event__process_auxtrace,
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index e254f18986f7..3f4e4dd5abf3 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -607,6 +607,7 @@ static int perf_event__repipe_exit(struct perf_tool *tool,
> >       return err;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int perf_event__repipe_tracing_data(struct perf_session *session,
> >                                          union perf_event *event)
> > {
> > @@ -614,6 +615,7 @@ static int perf_event__repipe_tracing_data(struct perf_session *session,
> >
> >       return perf_event__process_tracing_data(session, event);
> > }
> > +#endif
> >
> > static int dso__read_build_id(struct dso *dso)
> > {
> > @@ -807,6 +809,7 @@ static int perf_inject__sched_switch(struct perf_tool *tool,
> >       return 0;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int perf_inject__sched_stat(struct perf_tool *tool,
> >                                  union perf_event *event __maybe_unused,
> >                                  struct perf_sample *sample,
> > @@ -836,6 +839,7 @@ static int perf_inject__sched_stat(struct perf_tool *tool,
> >       build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
> >       return perf_event__repipe(tool, event_sw, &sample_sw, machine);
> > }
> > +#endif
> >
> > static struct guest_vcpu *guest_session__vcpu(struct guest_session *gs, u32 vcpu)
> > {
> > @@ -1961,7 +1965,9 @@ static int __cmd_inject(struct perf_inject *inject)
> >               inject->tool.mmap         = perf_event__repipe_mmap;
> >               inject->tool.mmap2        = perf_event__repipe_mmap2;
> >               inject->tool.fork         = perf_event__repipe_fork;
> > +#ifdef HAVE_LIBTRACEEVENT
> >               inject->tool.tracing_data = perf_event__repipe_tracing_data;
> > +#endif
> >       }
> >
> >       output_data_offset = perf_session__data_offset(session->evlist);
> > @@ -1984,8 +1990,10 @@ static int __cmd_inject(struct perf_inject *inject)
> >                               evsel->handler = perf_inject__sched_switch;
> >                       } else if (!strcmp(name, "sched:sched_process_exit"))
> >                               evsel->handler = perf_inject__sched_process_exit;
> > +#ifdef HAVE_LIBTRACEEVENT
> >                       else if (!strncmp(name, "sched:sched_stat_", 17))
> >                               evsel->handler = perf_inject__sched_stat;
> > +#endif
> >               }
> >       } else if (inject->itrace_synth_opts.vm_time_correlation) {
> >               session->itrace_synth_opts = &inject->itrace_synth_opts;
> > diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> > index ebfab2ca1702..e20656c431a4 100644
> > --- a/tools/perf/builtin-kmem.c
> > +++ b/tools/perf/builtin-kmem.c
> > @@ -35,6 +35,7 @@
> > #include <regex.h>
> >
> > #include <linux/ctype.h>
> > +#include <traceevent/event-parse.h>
> >
> > static int    kmem_slab;
> > static int    kmem_page;
> > diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> > index 7d9ec1bac1a2..641e739c717c 100644
> > --- a/tools/perf/builtin-kvm.c
> > +++ b/tools/perf/builtin-kvm.c
> > @@ -63,7 +63,7 @@ static const char *get_filename_for_perf_kvm(void)
> >       return filename;
> > }
> >
> > -#ifdef HAVE_KVM_STAT_SUPPORT
> > +#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> >
> > void exit_event_get_key(struct evsel *evsel,
> >                       struct perf_sample *sample,
> > @@ -654,7 +654,7 @@ static void print_result(struct perf_kvm_stat *kvm)
> >               pr_info("\nLost events: %" PRIu64 "\n\n", kvm->lost_events);
> > }
> >
> > -#ifdef HAVE_TIMERFD_SUPPORT
> > +#if defined(HAVE_TIMERFD_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> > static int process_lost_event(struct perf_tool *tool,
> >                             union perf_event *event __maybe_unused,
> >                             struct perf_sample *sample __maybe_unused,
> > @@ -742,7 +742,7 @@ static bool verify_vcpu(int vcpu)
> >       return true;
> > }
> >
> > -#ifdef HAVE_TIMERFD_SUPPORT
> > +#if defined(HAVE_TIMERFD_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> > /* keeping the max events to a modest level to keep
> >  * the processing of samples per mmap smooth.
> >  */
> > @@ -1290,7 +1290,7 @@ kvm_events_report(struct perf_kvm_stat *kvm, int argc, const char **argv)
> >       return kvm_events_report_vcpu(kvm);
> > }
> >
> > -#ifdef HAVE_TIMERFD_SUPPORT
> > +#if defined(HAVE_TIMERFD_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> > static struct evlist *kvm_live_event_list(void)
> > {
> >       struct evlist *evlist;
> > @@ -1507,7 +1507,7 @@ static int kvm_cmd_stat(const char *file_name, int argc, const char **argv)
> >       if (strlen(argv[1]) > 2 && strstarts("report", argv[1]))
> >               return kvm_events_report(&kvm, argc - 1 , argv + 1);
> >
> > -#ifdef HAVE_TIMERFD_SUPPORT
> > +#if defined(HAVE_TIMERFD_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> >       if (!strncmp(argv[1], "live", 4))
> >               return kvm_events_live(&kvm, argc - 1 , argv + 1);
> > #endif
> > @@ -1644,7 +1644,7 @@ int cmd_kvm(int argc, const char **argv)
> >               return cmd_top(argc, argv);
> >       else if (strlen(argv[0]) > 2 && strstarts("buildid-list", argv[0]))
> >               return __cmd_buildid_list(file_name, argc, argv);
> > -#ifdef HAVE_KVM_STAT_SUPPORT
> > +#if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> >       else if (strlen(argv[0]) > 2 && strstarts("stat", argv[0]))
> >               return kvm_cmd_stat(file_name, argc, argv);
> > #endif
> > diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> > index 0e02b8098644..dc59d75180d1 100644
> > --- a/tools/perf/builtin-kwork.c
> > +++ b/tools/perf/builtin-kwork.c
> > @@ -23,6 +23,7 @@
> >
> > #include <subcmd/pager.h>
> > #include <subcmd/parse-options.h>
> > +#include <traceevent/event-parse.h>
> >
> > #include <errno.h>
> > #include <inttypes.h>
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index b7fd7ec586fb..7e17374f6c1a 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1701,8 +1701,10 @@ static void record__init_features(struct record *rec)
> >       if (rec->no_buildid)
> >               perf_header__clear_feat(&session->header, HEADER_BUILD_ID);
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (!have_tracepoints(&rec->evlist->core.entries))
> >               perf_header__clear_feat(&session->header, HEADER_TRACING_DATA);
> > +#endif
> >
> >       if (!rec->opts.branch_stack)
> >               perf_header__clear_feat(&session->header, HEADER_BRANCH_STACK);
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index b6d77d3da64f..2ee2ecca208e 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -67,6 +67,10 @@
> > #include <unistd.h>
> > #include <linux/mman.h>
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > +#include <traceevent/event-parse.h>
> > +#endif
> > +
> > struct report {
> >       struct perf_tool        tool;
> >       struct perf_session     *session;
> > @@ -1199,7 +1203,9 @@ int cmd_report(int argc, const char **argv)
> >                       .lost            = perf_event__process_lost,
> >                       .read            = process_read_event,
> >                       .attr            = process_attr,
> > +#ifdef HAVE_LIBTRACEEVENT
> >                       .tracing_data    = perf_event__process_tracing_data,
> > +#endif
> >                       .build_id        = perf_event__process_build_id,
> >                       .id_index        = perf_event__process_id_index,
> >                       .auxtrace_info   = perf_event__process_auxtrace_info,
> > @@ -1660,6 +1666,7 @@ int cmd_report(int argc, const char **argv)
> >                                                 report.range_num);
> >       }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (session->tevent.pevent &&
> >           tep_set_function_resolver(session->tevent.pevent,
> >                                     machine__resolve_kernel_addr,
> > @@ -1668,7 +1675,7 @@ int cmd_report(int argc, const char **argv)
> >                      __func__);
> >               return -1;
> >       }
> > -
> > +#endif
> >       sort__setup_elide(stdout);
> >
> >       ret = __cmd_report(&report);
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index d7ec8c1af293..88888fb885c8 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -62,6 +62,9 @@
> > #include "perf.h"
> >
> > #include <linux/ctype.h>
> > +#ifdef HAVE_LIBTRACEEVENT
> > +#include <traceevent/event-parse.h>
> > +#endif
> >
> > static char const             *script_name;
> > static char const             *generate_script_lang;
> > @@ -2154,12 +2157,12 @@ static void process_event(struct perf_script *script,
> >               perf_sample__fprintf_bts(sample, evsel, thread, al, addr_al, machine, fp);
> >               return;
> >       }
> > -
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (PRINT_FIELD(TRACE) && sample->raw_data) {
> >               event_format__fprintf(evsel->tp_format, sample->cpu,
> >                                     sample->raw_data, sample->raw_size, fp);
> >       }
> > -
> > +#endif
> >       if (attr->type == PERF_TYPE_SYNTH && PRINT_FIELD(SYNTH))
> >               perf_sample__fprintf_synth(sample, evsel, fp);
> >
> > @@ -2283,8 +2286,10 @@ static void process_stat_interval(u64 tstamp)
> >
> > static void setup_scripting(void)
> > {
> > +#ifdef HAVE_LIBTRACEEVENT
> >       setup_perl_scripting();
> >       setup_python_scripting();
> > +#endif
> > }
> >
> > static int flush_scripting(void)
> > @@ -3784,7 +3789,9 @@ int cmd_script(int argc, const char **argv)
> >                       .fork            = perf_event__process_fork,
> >                       .attr            = process_attr,
> >                       .event_update   = perf_event__process_event_update,
> > +#ifdef HAVE_LIBTRACEEVENT
> >                       .tracing_data    = perf_event__process_tracing_data,
> > +#endif
> >                       .feature         = process_feature_event,
> >                       .build_id        = perf_event__process_build_id,
> >                       .id_index        = perf_event__process_id_index,
> > @@ -4215,6 +4222,7 @@ int cmd_script(int argc, const char **argv)
> >       else
> >               symbol_conf.use_callchain = false;
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (session->tevent.pevent &&
> >           tep_set_function_resolver(session->tevent.pevent,
> >                                     machine__resolve_kernel_addr,
> > @@ -4223,7 +4231,7 @@ int cmd_script(int argc, const char **argv)
> >               err = -1;
> >               goto out_delete;
> >       }
> > -
> > +#endif
> >       if (generate_script_lang) {
> >               struct stat perf_stat;
> >               int input;
> > @@ -4259,9 +4267,12 @@ int cmd_script(int argc, const char **argv)
> >                       err = -ENOENT;
> >                       goto out_delete;
> >               }
> > -
> > +#ifdef HAVE_LIBTRACEEVENT
> >               err = scripting_ops->generate_script(session->tevent.pevent,
> >                                                    "perf-script");
> > +#else
> > +             err = scripting_ops->generate_script(NULL, "perf-script");
> > +#endif
> >               goto out_delete;
> >       }
> >
> > diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> > index c36296bb7637..6c629e7d370a 100644
> > --- a/tools/perf/builtin-timechart.c
> > +++ b/tools/perf/builtin-timechart.c
> > @@ -38,6 +38,7 @@
> > #include "util/string2.h"
> > #include "util/tracepoint.h"
> > #include <linux/err.h>
> > +#include <traceevent/event-parse.h>
> >
> > #ifdef LACKS_OPEN_MEMSTREAM_PROTOTYPE
> > FILE *open_memstream(char **ptr, size_t *sizeloc);
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 543c379d2a57..6909cd9f48d1 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -15,7 +15,6 @@
> >  */
> >
> > #include "util/record.h"
> > -#include <traceevent/event-parse.h>
> > #include <api/fs/tracing_path.h>
> > #include <bpf/bpf.h>
> > #include "util/bpf_map.h"
> > @@ -80,6 +79,10 @@
> > #include <linux/ctype.h>
> > #include <perf/mmap.h>
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > +#include <traceevent/event-parse.h>
> > +#endif
> > +
> > #ifndef O_CLOEXEC
> > # define O_CLOEXEC            02000000
> > #endif
> > diff --git a/tools/perf/builtin-version.c b/tools/perf/builtin-version.c
> > index a71f491224da..a886929ec6e5 100644
> > --- a/tools/perf/builtin-version.c
> > +++ b/tools/perf/builtin-version.c
> > @@ -82,6 +82,7 @@ static void library_status(void)
> >       STATUS(HAVE_AIO_SUPPORT, aio);
> >       STATUS(HAVE_ZSTD_SUPPORT, zstd);
> >       STATUS(HAVE_LIBPFM, libpfm4);
> > +     STATUS(HAVE_LIBTRACEEVENT, libtraceevent);
> > }
> >
> > int cmd_version(int argc, const char **argv)
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index 7af135dea1cd..82bbe0ca858b 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -70,20 +70,26 @@ static struct cmd_struct commands[] = {
> >       { "report",     cmd_report,     0 },
> >       { "bench",      cmd_bench,      0 },
> >       { "stat",       cmd_stat,       0 },
> > +#ifdef HAVE_LIBTRACEEVENT
> >       { "timechart",  cmd_timechart,  0 },
> > +#endif
> >       { "top",        cmd_top,        0 },
> >       { "annotate",   cmd_annotate,   0 },
> >       { "version",    cmd_version,    0 },
> >       { "script",     cmd_script,     0 },
> > +#ifdef HAVE_LIBTRACEEVENT
> >       { "sched",      cmd_sched,      0 },
> > +#endif
> > #ifdef HAVE_LIBELF_SUPPORT
> >       { "probe",      cmd_probe,      0 },
> > #endif
> > +#ifdef HAVE_LIBTRACEEVENT
> >       { "kmem",       cmd_kmem,       0 },
> >       { "lock",       cmd_lock,       0 },
> > +#endif
> >       { "kvm",        cmd_kvm,        0 },
> >       { "test",       cmd_test,       0 },
> > -#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
> > +#if defined(HAVE_LIBTRACEEVENT) && (defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT))
> >       { "trace",      cmd_trace,      0 },
> > #endif
> >       { "inject",     cmd_inject,     0 },
> > @@ -91,7 +97,9 @@ static struct cmd_struct commands[] = {
> >       { "data",       cmd_data,       0 },
> >       { "ftrace",     cmd_ftrace,     0 },
> >       { "daemon",     cmd_daemon,     0 },
> > +#ifdef HAVE_LIBTRACEEVENT
> >       { "kwork",      cmd_kwork,      0 },
> > +#endif
> > };
> >
> > struct pager_config {
> > @@ -500,14 +508,18 @@ int main(int argc, const char **argv)
> >               argv[0] = cmd;
> >       }
> >       if (strstarts(cmd, "trace")) {
> > -#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
> > -             setup_path();
> > -             argv[0] = "trace";
> > -             return cmd_trace(argc, argv);
> > -#else
> > +#ifndef HAVE_LIBTRACEEVENT
> > +             fprintf(stderr,
> > +                     "trace command not available: missing libtraceevent devel package at build time.\n");
> > +             goto out;
> > +#elif !defined(HAVE_LIBAUDIT_SUPPORT) && !defined(HAVE_SYSCALL_TABLE_SUPPORT)
> >               fprintf(stderr,
> >                       "trace command not available: missing audit-libs devel package at build time.\n");
> >               goto out;
> > +#else
> > +             setup_path();
> > +             argv[0] = "trace";
> > +             return cmd_trace(argc, argv);
> > #endif
> >       }
> >       /* Look for flags.. */
> > diff --git a/tools/perf/scripts/python/Perf-Trace-Util/Build b/tools/perf/scripts/python/Perf-Trace-Util/Build
> > index 7d0e33ce6aba..f65625a60704 100644
> > --- a/tools/perf/scripts/python/Perf-Trace-Util/Build
> > +++ b/tools/perf/scripts/python/Perf-Trace-Util/Build
> > @@ -1,3 +1,3 @@
> > -perf-y += Context.o
> > +perf-$(CONFIG_TRACEEVENT) += Context.o
> >
> > CFLAGS_Context.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-nested-externs
> > diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> > index 11b69023011b..34ebc009e05a 100644
> > --- a/tools/perf/tests/Build
> > +++ b/tools/perf/tests/Build
> > @@ -6,13 +6,13 @@ perf-y += parse-events.o
> > perf-y += dso-data.o
> > perf-y += attr.o
> > perf-y += vmlinux-kallsyms.o
> > -perf-y += openat-syscall.o
> > -perf-y += openat-syscall-all-cpus.o
> > -perf-y += openat-syscall-tp-fields.o
> > -perf-y += mmap-basic.o
> > +perf-$(CONFIG_TRACEEVENT) += openat-syscall.o
> > +perf-$(CONFIG_TRACEEVENT) += openat-syscall-all-cpus.o
> > +perf-$(CONFIG_TRACEEVENT) += openat-syscall-tp-fields.o
> > +perf-$(CONFIG_TRACEEVENT) += mmap-basic.o
> > perf-y += perf-record.o
> > perf-y += evsel-roundtrip-name.o
> > -perf-y += evsel-tp-sched.o
> > +perf-$(CONFIG_TRACEEVENT) += evsel-tp-sched.o
> > perf-y += fdarray.o
> > perf-y += pmu.o
> > perf-y += pmu-events.o
> > @@ -30,7 +30,7 @@ perf-y += task-exit.o
> > perf-y += sw-clock.o
> > perf-y += mmap-thread-lookup.o
> > perf-y += thread-maps-share.o
> > -perf-y += switch-tracking.o
> > +perf-$(CONFIG_TRACEEVENT) += switch-tracking.o
> > perf-y += keep-tracking.o
> > perf-y += code-reading.o
> > perf-y += sample-parsing.o
> > diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> > index 4c6ae59a4dfd..658449204ce5 100644
> > --- a/tools/perf/tests/builtin-test.c
> > +++ b/tools/perf/tests/builtin-test.c
> > @@ -38,9 +38,11 @@ struct test_suite *__weak arch_tests[] = {
> >
> > static struct test_suite *generic_tests[] = {
> >       &suite__vmlinux_matches_kallsyms,
> > +#ifdef HAVE_LIBTRACEEVENT
> >       &suite__openat_syscall_event,
> >       &suite__openat_syscall_event_on_all_cpus,
> >       &suite__basic_mmap,
> > +#endif
> >       &suite__mem,
> >       &suite__parse_events,
> >       &suite__expr,
> > @@ -51,8 +53,10 @@ static struct test_suite *generic_tests[] = {
> >       &suite__dso_data_cache,
> >       &suite__dso_data_reopen,
> >       &suite__perf_evsel__roundtrip_name_test,
> > +#ifdef HAVE_LIBTRACEEVENT
> >       &suite__perf_evsel__tp_sched_test,
> >       &suite__syscall_openat_tp_fields,
> > +#endif
> >       &suite__attr,
> >       &suite__hists_link,
> >       &suite__python_use,
> > @@ -71,7 +75,9 @@ static struct test_suite *generic_tests[] = {
> >       &suite__thread_maps_share,
> >       &suite__hists_output,
> >       &suite__hists_cumulate,
> > +#ifdef HAVE_LIBTRACEEVENT
> >       &suite__switch_tracking,
> > +#endif
> >       &suite__fdarray__filter,
> >       &suite__fdarray__add,
> >       &suite__kmod_path__parse,
> > diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> > index 3440dd2616b0..dcbfb93287e8 100644
> > --- a/tools/perf/tests/parse-events.c
> > +++ b/tools/perf/tests/parse-events.c
> > @@ -46,6 +46,7 @@ static bool kvm_s390_create_vm_valid(void)
> > }
> > #endif
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int test__checkevent_tracepoint(struct evlist *evlist)
> > {
> >       struct evsel *evsel = evlist__first(evlist);
> > @@ -76,6 +77,7 @@ static int test__checkevent_tracepoint_multi(struct evlist *evlist)
> >       }
> >       return TEST_OK;
> > }
> > +#endif /* HAVE_LIBTRACEEVENT */
> >
> > static int test__checkevent_raw(struct evlist *evlist)
> > {
> > @@ -222,6 +224,7 @@ static int test__checkevent_breakpoint_rw(struct evlist *evlist)
> >       return TEST_OK;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int test__checkevent_tracepoint_modifier(struct evlist *evlist)
> > {
> >       struct evsel *evsel = evlist__first(evlist);
> > @@ -252,6 +255,7 @@ test__checkevent_tracepoint_multi_modifier(struct evlist *evlist)
> >
> >       return test__checkevent_tracepoint_multi(evlist);
> > }
> > +#endif /* HAVE_LIBTRACEEVENT */
> >
> > static int test__checkevent_raw_modifier(struct evlist *evlist)
> > {
> > @@ -453,6 +457,7 @@ static int test__checkevent_pmu(struct evlist *evlist)
> >       return TEST_OK;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int test__checkevent_list(struct evlist *evlist)
> > {
> >       struct evsel *evsel = evlist__first(evlist);
> > @@ -491,6 +496,7 @@ static int test__checkevent_list(struct evlist *evlist)
> >
> >       return TEST_OK;
> > }
> > +#endif
> >
> > static int test__checkevent_pmu_name(struct evlist *evlist)
> > {
> > @@ -762,6 +768,7 @@ static int test__group2(struct evlist *evlist)
> >       return TEST_OK;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int test__group3(struct evlist *evlist __maybe_unused)
> > {
> >       struct evsel *evsel, *leader;
> > @@ -853,6 +860,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
> >
> >       return TEST_OK;
> > }
> > +#endif
> >
> > static int test__group4(struct evlist *evlist __maybe_unused)
> > {
> > @@ -1460,6 +1468,7 @@ static int test__sym_event_dc(struct evlist *evlist)
> >       return TEST_OK;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int count_tracepoints(void)
> > {
> >       struct dirent *events_ent;
> > @@ -1513,6 +1522,7 @@ static int test__all_tracepoints(struct evlist *evlist)
> >
> >       return test__checkevent_tracepoint_multi(evlist);
> > }
> > +#endif /* HAVE_LIBTRACEVENT */
> >
> > static int test__hybrid_hw_event_with_pmu(struct evlist *evlist)
> > {
> > @@ -1642,6 +1652,7 @@ struct evlist_test {
> > };
> >
> > static const struct evlist_test test__events[] = {
> > +#ifdef HAVE_LIBTRACEEVENT
> >       {
> >               .name  = "syscalls:sys_enter_openat",
> >               .check = test__checkevent_tracepoint,
> > @@ -1652,6 +1663,7 @@ static const struct evlist_test test__events[] = {
> >               .check = test__checkevent_tracepoint_multi,
> >               /* 1 */
> >       },
> > +#endif
> >       {
> >               .name  = "r1a",
> >               .check = test__checkevent_raw,
> > @@ -1702,6 +1714,7 @@ static const struct evlist_test test__events[] = {
> >               .check = test__checkevent_breakpoint_w,
> >               /* 1 */
> >       },
> > +#ifdef HAVE_LIBTRACEEVENT
> >       {
> >               .name  = "syscalls:sys_enter_openat:k",
> >               .check = test__checkevent_tracepoint_modifier,
> > @@ -1712,6 +1725,7 @@ static const struct evlist_test test__events[] = {
> >               .check = test__checkevent_tracepoint_multi_modifier,
> >               /* 3 */
> >       },
> > +#endif
> >       {
> >               .name  = "r1a:kp",
> >               .check = test__checkevent_raw_modifier,
> > @@ -1757,11 +1771,13 @@ static const struct evlist_test test__events[] = {
> >               .check = test__checkevent_breakpoint_w_modifier,
> >               /* 2 */
> >       },
> > +#ifdef HAVE_LIBTRACEEVENT
> >       {
> >               .name  = "r1,syscalls:sys_enter_openat:k,1:1:hp",
> >               .check = test__checkevent_list,
> >               /* 3 */
> >       },
> > +#endif
> >       {
> >               .name  = "instructions:G",
> >               .check = test__checkevent_exclude_host_modifier,
> > @@ -1792,11 +1808,13 @@ static const struct evlist_test test__events[] = {
> >               .check = test__group2,
> >               /* 9 */
> >       },
> > +#ifdef HAVE_LIBTRACEEVENT
> >       {
> >               .name  = "group1{syscalls:sys_enter_openat:H,cycles:kppp},group2{cycles,1:3}:G,instructions:u",
> >               .check = test__group3,
> >               /* 0 */
> >       },
> > +#endif
> >       {
> >               .name  = "{cycles:u,instructions:kp}:p",
> >               .check = test__group4,
> > @@ -1807,11 +1825,13 @@ static const struct evlist_test test__events[] = {
> >               .check = test__group5,
> >               /* 2 */
> >       },
> > +#ifdef HAVE_LIBTRACEEVENT
> >       {
> >               .name  = "*:*",
> >               .check = test__all_tracepoints,
> >               /* 3 */
> >       },
> > +#endif
> >       {
> >               .name  = "{cycles,cache-misses:G}:H",
> >               .check = test__group_gh1,
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index ab37f588ee8b..612406311e27 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -69,17 +69,17 @@ perf-y += namespaces.o
> > perf-y += comm.o
> > perf-y += thread.o
> > perf-y += thread_map.o
> > -perf-y += trace-event-parse.o
> > perf-y += parse-events-flex.o
> > perf-y += parse-events-bison.o
> > perf-y += pmu.o
> > perf-y += pmu-flex.o
> > perf-y += pmu-bison.o
> > perf-y += pmu-hybrid.o
> > -perf-y += trace-event-read.o
> > -perf-y += trace-event-info.o
> > -perf-y += trace-event-scripting.o
> > -perf-y += trace-event.o
> > +perf-$(CONFIG_TRACEEVENT) += trace-event-info.o
> > +perf-$(CONFIG_TRACEEVENT) += trace-event-scripting.o
> > +perf-$(CONFIG_TRACEEVENT) += trace-event.o
> > +perf-$(CONFIG_TRACEEVENT) += trace-event-parse.o
> > +perf-$(CONFIG_TRACEEVENT) += trace-event-read.o
> > perf-y += svghelper.o
> > perf-y += sort.o
> > perf-y += hist.o
> > diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> > index c65cdaf6975e..8031b586e813 100644
> > --- a/tools/perf/util/data-convert-bt.c
> > +++ b/tools/perf/util/data-convert-bt.c
> > @@ -19,7 +19,6 @@
> > #include <babeltrace/ctf-writer/event-fields.h>
> > #include <babeltrace/ctf-ir/utils.h>
> > #include <babeltrace/ctf/events.h>
> > -#include <traceevent/event-parse.h>
> > #include "asm/bug.h"
> > #include "data-convert.h"
> > #include "session.h"
> > @@ -36,6 +35,10 @@
> > #include "clockid.h"
> > #include "util/sample.h"
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > +#include <traceevent/event-parse.h>
> > +#endif
> > +
> > #define pr_N(n, fmt, ...) \
> >       eprintf(n, debug_data_convert, fmt, ##__VA_ARGS__)
> >
> > diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> > index 57db59068cb6..ba9d93ce9463 100644
> > --- a/tools/perf/util/data-convert-json.c
> > +++ b/tools/perf/util/data-convert-json.c
> > @@ -27,6 +27,10 @@
> > #include "util/thread.h"
> > #include "util/tool.h"
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > +#include <traceevent/event-parse.h>
> > +#endif
> > +
> > struct convert_json {
> >       struct perf_tool tool;
> >       FILE *out;
> > @@ -217,6 +221,7 @@ static int process_sample_event(struct perf_tool *tool,
> >       }
> >       output_json_format(out, false, 3, "]");
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (sample->raw_data) {
> >               int i;
> >               struct tep_format_field **fields;
> > @@ -236,7 +241,7 @@ static int process_sample_event(struct perf_tool *tool,
> >                       free(fields);
> >               }
> >       }
> > -
> > +#endif
> >       output_json_format(out, false, 2, "}");
> >       return 0;
> > }
> > @@ -313,7 +318,9 @@ int bt_convert__perf2json(const char *input_name, const char *output_name,
> >                       .exit           = perf_event__process_exit,
> >                       .fork           = perf_event__process_fork,
> >                       .lost           = perf_event__process_lost,
> > +#ifdef HAVE_LIBTRACEEVENT
> >                       .tracing_data   = perf_event__process_tracing_data,
> > +#endif
> >                       .build_id       = perf_event__process_build_id,
> >                       .id_index       = perf_event__process_id_index,
> >                       .auxtrace_info  = perf_event__process_auxtrace_info,
> > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > index fbf3192bced9..590d4e77effc 100644
> > --- a/tools/perf/util/evlist.c
> > +++ b/tools/perf/util/evlist.c
> > @@ -290,6 +290,7 @@ struct evsel *evlist__add_aux_dummy(struct evlist *evlist, bool system_wide)
> >       return evsel;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
> > {
> >       struct evsel *evsel = evsel__newtp_idx("sched", "sched_switch", 0);
> > @@ -305,7 +306,8 @@ struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide)
> >
> >       evlist__add(evlist, evsel);
> >       return evsel;
> > -};
> > +}
> > +#endif
> >
> > int evlist__add_attrs(struct evlist *evlist, struct perf_event_attr *attrs, size_t nr_attrs)
> > {
> > @@ -376,6 +378,7 @@ struct evsel *evlist__find_tracepoint_by_name(struct evlist *evlist, const char
> >       return NULL;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > int evlist__add_newtp(struct evlist *evlist, const char *sys, const char *name, void *handler)
> > {
> >       struct evsel *evsel = evsel__newtp(sys, name);
> > @@ -387,6 +390,7 @@ int evlist__add_newtp(struct evlist *evlist, const char *sys, const char *name,
> >       evlist__add(evlist, evsel);
> >       return 0;
> > }
> > +#endif
> >
> > struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affinity *affinity)
> > {
> > diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> > index 16734c6756b3..e5b84ead566c 100644
> > --- a/tools/perf/util/evlist.h
> > +++ b/tools/perf/util/evlist.h
> > @@ -127,7 +127,9 @@ static inline struct evsel *evlist__add_dummy_on_all_cpus(struct evlist *evlist)
> > {
> >       return evlist__add_aux_dummy(evlist, true);
> > }
> > +#ifdef HAVE_LIBTRACEEVENT
> > struct evsel *evlist__add_sched_switch(struct evlist *evlist, bool system_wide);
> > +#endif
> >
> > int evlist__add_sb_event(struct evlist *evlist, struct perf_event_attr *attr,
> >                        evsel__sb_cb_t cb, void *data);
> > @@ -135,7 +137,9 @@ void evlist__set_cb(struct evlist *evlist, evsel__sb_cb_t cb, void *data);
> > int evlist__start_sb_thread(struct evlist *evlist, struct target *target);
> > void evlist__stop_sb_thread(struct evlist *evlist);
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > int evlist__add_newtp(struct evlist *evlist, const char *sys, const char *name, void *handler);
> > +#endif
> >
> > int __evlist__set_tracepoints_handlers(struct evlist *evlist,
> >                                      const struct evsel_str_handler *assocs,
> > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > index 0f617359a82f..ca911856c4b1 100644
> > --- a/tools/perf/util/evsel.c
> > +++ b/tools/perf/util/evsel.c
> > @@ -12,7 +12,6 @@
> > #include <linux/bitops.h>
> > #include <api/fs/fs.h>
> > #include <api/fs/tracing_path.h>
> > -#include <traceevent/event-parse.h>
> > #include <linux/hw_breakpoint.h>
> > #include <linux/perf_event.h>
> > #include <linux/compiler.h>
> > @@ -57,6 +56,10 @@
> >
> > #include <linux/ctype.h>
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > +#include <traceevent/event-parse.h>
> > +#endif
> > +
> > struct perf_missing_features perf_missing_features;
> >
> > static clockid_t clockid;
> > @@ -439,7 +442,9 @@ struct evsel *evsel__clone(struct evsel *orig)
> >                       goto out_err;
> >       }
> >       evsel->cgrp = cgroup__get(orig->cgrp);
> > +#ifdef HAVE_LIBTRACEEVENT
> >       evsel->tp_format = orig->tp_format;
> > +#endif
> >       evsel->handler = orig->handler;
> >       evsel->core.leader = orig->core.leader;
> >
> > @@ -479,6 +484,7 @@ struct evsel *evsel__clone(struct evsel *orig)
> > /*
> >  * Returns pointer with encoded error via <linux/err.h> interface.
> >  */
> > +#ifdef HAVE_LIBTRACEEVENT
> > struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
> > {
> >       struct evsel *evsel = zalloc(perf_evsel__object.size);
> > @@ -516,6 +522,7 @@ struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx)
> > out_err:
> >       return ERR_PTR(err);
> > }
> > +#endif
> >
> > const char *const evsel__hw_names[PERF_COUNT_HW_MAX] = {
> >       "cycles",
> > @@ -2758,6 +2765,7 @@ u16 evsel__id_hdr_size(struct evsel *evsel)
> >       return size;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > struct tep_format_field *evsel__field(struct evsel *evsel, const char *name)
> > {
> >       return tep_find_field(evsel->tp_format, name);
> > @@ -2831,6 +2839,7 @@ u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *n
> >
> >       return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
> > }
> > +#endif
> >
> > bool evsel__fallback(struct evsel *evsel, int err, char *msg, size_t msgsize)
> > {
> > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > index f3485799ddf9..d572be41b960 100644
> > --- a/tools/perf/util/evsel.h
> > +++ b/tools/perf/util/evsel.h
> > @@ -72,7 +72,9 @@ struct evsel {
> >               char                    *name;
> >               char                    *group_name;
> >               const char              *pmu_name;
> > +#ifdef HAVE_LIBTRACEEVENT
> >               struct tep_event        *tp_format;
> > +#endif
> >               char                    *filter;
> >               unsigned long           max_events;
> >               double                  scale;
> > @@ -223,11 +225,14 @@ static inline struct evsel *evsel__new(struct perf_event_attr *attr)
> > }
> >
> > struct evsel *evsel__clone(struct evsel *orig);
> > -struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
> >
> > int copy_config_terms(struct list_head *dst, struct list_head *src);
> > void free_config_terms(struct list_head *config_terms);
> >
> > +
> > +#ifdef HAVE_LIBTRACEEVENT
> > +struct evsel *evsel__newtp_idx(const char *sys, const char *name, int idx);
> > +
> > /*
> >  * Returns pointer with encoded error via <linux/err.h> interface.
> >  */
> > @@ -235,10 +240,13 @@ static inline struct evsel *evsel__newtp(const char *sys, const char *name)
> > {
> >       return evsel__newtp_idx(sys, name, 0);
> > }
> > +#endif
> >
> > struct evsel *evsel__new_cycles(bool precise, __u32 type, __u64 config);
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > struct tep_event *event_format__new(const char *sys, const char *name);
> > +#endif
> >
> > void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
> > void evsel__exit(struct evsel *evsel);
> > @@ -323,6 +331,7 @@ bool evsel__precise_ip_fallback(struct evsel *evsel);
> >
> > struct perf_sample;
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
> > u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name);
> >
> > @@ -330,6 +339,7 @@ static inline char *evsel__strval(struct evsel *evsel, struct perf_sample *sampl
> > {
> >       return evsel__rawptr(evsel, sample, name);
> > }
> > +#endif
> >
> > struct tep_format_field;
> >
> > diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> > index 8c2ea8001329..bd22c4932d10 100644
> > --- a/tools/perf/util/evsel_fprintf.c
> > +++ b/tools/perf/util/evsel_fprintf.c
> > @@ -2,7 +2,6 @@
> > #include <inttypes.h>
> > #include <stdio.h>
> > #include <stdbool.h>
> > -#include <traceevent/event-parse.h>
> > #include "evsel.h"
> > #include "util/evsel_fprintf.h"
> > #include "util/event.h"
> > @@ -13,6 +12,10 @@
> > #include "srcline.h"
> > #include "dso.h"
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > +#include <traceevent/event-parse.h>
> > +#endif
> > +
> > static int comma_fprintf(FILE *fp, bool *first, const char *fmt, ...)
> > {
> >       va_list args;
> > @@ -74,6 +77,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
> >                                        term, (u64)evsel->core.attr.sample_freq);
> >       }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (details->trace_fields) {
> >               struct tep_format_field *field;
> >
> > @@ -96,6 +100,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
> >                       field = field->next;
> >               }
> >       }
> > +#endif
> > out:
> >       fputc('\n', fp);
> >       return ++printed;
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index dc2ae397d400..404d816ca124 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -6,6 +6,7 @@
> > #include <sys/types.h>
> > #include <byteswap.h>
> > #include <unistd.h>
> > +#include <regex.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <linux/compiler.h>
> > @@ -55,6 +56,10 @@
> > #include <linux/ctype.h>
> > #include <internal/lib.h>
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > +#include <traceevent/event-parse.h>
> > +#endif
> > +
> > /*
> >  * magic2 = "PERFILE2"
> >  * must be a numerical value to let the endianness
> > @@ -298,6 +303,7 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
> >       return 0;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int write_tracing_data(struct feat_fd *ff,
> >                             struct evlist *evlist)
> > {
> > @@ -306,6 +312,7 @@ static int write_tracing_data(struct feat_fd *ff,
> >
> >       return read_tracing_data(ff->fd, &evlist->core.entries);
> > }
> > +#endif
> >
> > static int write_build_id(struct feat_fd *ff,
> >                         struct evlist *evlist __maybe_unused)
> > @@ -2394,12 +2401,14 @@ FEAT_PROCESS_STR_FUN(arch, arch);
> > FEAT_PROCESS_STR_FUN(cpudesc, cpu_desc);
> > FEAT_PROCESS_STR_FUN(cpuid, cpuid);
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int process_tracing_data(struct feat_fd *ff, void *data)
> > {
> >       ssize_t ret = trace_report(ff->fd, data, false);
> >
> >       return ret < 0 ? -1 : 0;
> > }
> > +#endif
> >
> > static int process_build_id(struct feat_fd *ff, void *data __maybe_unused)
> > {
> > @@ -3366,7 +3375,9 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
> > const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE];
> >
> > const struct perf_header_feature_ops feat_ops[HEADER_LAST_FEATURE] = {
> > +#ifdef HAVE_LIBTRACEEVENT
> >       FEAT_OPN(TRACING_DATA,  tracing_data,   false),
> > +#endif
> >       FEAT_OPN(BUILD_ID,      build_id,       false),
> >       FEAT_OPR(HOSTNAME,      hostname,       false),
> >       FEAT_OPR(OSRELEASE,     osrelease,      false),
> > @@ -4082,6 +4093,7 @@ static int read_attr(int fd, struct perf_header *ph,
> >       return ret <= 0 ? -1 : 0;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int evsel__prepare_tracepoint_event(struct evsel *evsel, struct tep_handle *pevent)
> > {
> >       struct tep_event *event;
> > @@ -4125,6 +4137,7 @@ static int evlist__prepare_tracepoint_events(struct evlist *evlist, struct tep_h
> >
> >       return 0;
> > }
> > +#endif
> >
> > int perf_session__read_header(struct perf_session *session, int repipe_fd)
> > {
> > @@ -4230,11 +4243,15 @@ int perf_session__read_header(struct perf_session *session, int repipe_fd)
> >               lseek(fd, tmp, SEEK_SET);
> >       }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       perf_header__process_sections(header, fd, &session->tevent,
> >                                     perf_file_section__process);
> >
> >       if (evlist__prepare_tracepoint_events(session->evlist, session->tevent.pevent))
> >               goto out_delete_evlist;
> > +#else
> > +     perf_header__process_sections(header, fd, NULL, perf_file_section__process);
> > +#endif
> >
> >       return 0;
> > out_errno:
> > @@ -4412,6 +4429,7 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
> >       return 0;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > int perf_event__process_tracing_data(struct perf_session *session,
> >                                    union perf_event *event)
> > {
> > @@ -4459,6 +4477,7 @@ int perf_event__process_tracing_data(struct perf_session *session,
> >
> >       return size_read + padding;
> > }
> > +#endif
> >
> > int perf_event__process_build_id(struct perf_session *session,
> >                                union perf_event *event)
> > diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
> > index 2d5e601ba60f..e3861ae62172 100644
> > --- a/tools/perf/util/header.h
> > +++ b/tools/perf/util/header.h
> > @@ -160,8 +160,10 @@ int perf_event__process_event_update(struct perf_tool *tool,
> >                                    union perf_event *event,
> >                                    struct evlist **pevlist);
> > size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp);
> > +#ifdef HAVE_LIBTRACEEVENT
> > int perf_event__process_tracing_data(struct perf_session *session,
> >                                    union perf_event *event);
> > +#endif
> > int perf_event__process_build_id(struct perf_session *session,
> >                                union perf_event *event);
> > bool is_perf_magic(u64 magic);
> > diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> > index e3548ddef254..6d3921627e33 100644
> > --- a/tools/perf/util/intel-pt.c
> > +++ b/tools/perf/util/intel-pt.c
> > @@ -3142,6 +3142,7 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
> >       return 1;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int intel_pt_process_switch(struct intel_pt *pt,
> >                                  struct perf_sample *sample)
> > {
> > @@ -3165,6 +3166,7 @@ static int intel_pt_process_switch(struct intel_pt *pt,
> >
> >       return machine__set_current_tid(pt->machine, cpu, -1, tid);
> > }
> > +#endif /* HAVE_LIBTRACEEVENT */
> >
> > static int intel_pt_context_switch_in(struct intel_pt *pt,
> >                                     struct perf_sample *sample)
> > @@ -3433,9 +3435,12 @@ static int intel_pt_process_event(struct perf_session *session,
> >                       return err;
> >       }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (pt->switch_evsel && event->header.type == PERF_RECORD_SAMPLE)
> >               err = intel_pt_process_switch(pt, sample);
> > -     else if (event->header.type == PERF_RECORD_ITRACE_START)
> > +     else
> > +#endif
> > +     if (event->header.type == PERF_RECORD_ITRACE_START)
> >               err = intel_pt_process_itrace_start(pt, event, sample);
> >       else if (event->header.type == PERF_RECORD_AUX_OUTPUT_HW_ID)
> >               err = intel_pt_process_aux_output_hw_id(pt, event, sample);
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 6502cd679f57..21cce83462b3 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -445,6 +445,7 @@ int parse_events_add_cache(struct list_head *list, int *idx,
> >       return ret;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static void tracepoint_error(struct parse_events_error *e, int err,
> >                            const char *sys, const char *name)
> > {
> > @@ -593,6 +594,7 @@ static int add_tracepoint_multi_sys(struct list_head *list, int *idx,
> >       closedir(events_dir);
> >       return ret;
> > }
> > +#endif /* HAVE_LIBTRACEEVENT */
> >
> > #ifdef HAVE_LIBBPF_SUPPORT
> > struct __add_bpf_event_param {
> > @@ -1143,6 +1145,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
> >               return config_term_common(attr, term, err);
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int config_term_tracepoint(struct perf_event_attr *attr,
> >                                 struct parse_events_term *term,
> >                                 struct parse_events_error *err)
> > @@ -1170,6 +1173,7 @@ static int config_term_tracepoint(struct perf_event_attr *attr,
> >
> >       return 0;
> > }
> > +#endif
> >
> > static int config_attr(struct perf_event_attr *attr,
> >                      struct list_head *head,
> > @@ -1325,6 +1329,7 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
> >                               struct parse_events_error *err,
> >                               struct list_head *head_config)
> > {
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (head_config) {
> >               struct perf_event_attr attr;
> >
> > @@ -1339,6 +1344,16 @@ int parse_events_add_tracepoint(struct list_head *list, int *idx,
> >       else
> >               return add_tracepoint_event(list, idx, sys, event,
> >                                           err, head_config);
> > +#else
> > +     (void)list;
> > +     (void)idx;
> > +     (void)sys;
> > +     (void)event;
> > +     (void)head_config;
> > +     parse_events_error__handle(err, 0, strdup("unsupported tracepoint"),
> > +                             strdup("libtraceevent is necessary for tracepoint support"));
> > +     return -1;
> > +#endif
> > }
> >
> > int parse_events_add_numeric(struct parse_events_state *parse_state,
> > diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> > index 07df7bb7b042..428e72eaafcc 100644
> > --- a/tools/perf/util/parse-events.h
> > +++ b/tools/perf/util/parse-events.h
> > @@ -18,7 +18,6 @@ struct parse_events_error;
> > struct option;
> > struct perf_pmu;
> >
> > -bool have_tracepoints(struct list_head *evlist);
> > bool is_event_supported(u8 type, u64 config);
> >
> > const char *event_type(int type);
> > diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
> > index b5941c74a0d6..728fe2f51759 100644
> > --- a/tools/perf/util/python.c
> > +++ b/tools/perf/util/python.c
> > @@ -417,6 +417,7 @@ static PyObject *pyrf_sample_event__repr(struct pyrf_event *pevent)
> >       return ret;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static bool is_tracepoint(struct pyrf_event *pevent)
> > {
> >       return pevent->evsel->core.attr.type == PERF_TYPE_TRACEPOINT;
> > @@ -486,14 +487,17 @@ get_tracepoint_field(struct pyrf_event *pevent, PyObject *attr_name)
> >
> >       return tracepoint_field(pevent, field);
> > }
> > +#endif /* HAVE_LIBTRACEEVENT */
> >
> > static PyObject*
> > pyrf_sample_event__getattro(struct pyrf_event *pevent, PyObject *attr_name)
> > {
> >       PyObject *obj = NULL;
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (is_tracepoint(pevent))
> >               obj = get_tracepoint_field(pevent, attr_name);
> > +#endif
> >
> >       return obj ?: PyObject_GenericGetAttr((PyObject *) pevent, attr_name);
> > }
> > diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scripting-engines/Build
> > index 0f5ba28339cf..77544d2c447c 100644
> > --- a/tools/perf/util/scripting-engines/Build
> > +++ b/tools/perf/util/scripting-engines/Build
> > @@ -1,5 +1,7 @@
> > -perf-$(CONFIG_LIBPERL)   += trace-event-perl.o
> > -perf-$(CONFIG_LIBPYTHON) += trace-event-python.o
> > +ifeq ($(CONFIG_TRACEEVENT),y)
> > +  perf-$(CONFIG_LIBPERL)   += trace-event-perl.o
> > +  perf-$(CONFIG_LIBPYTHON) += trace-event-python.o
> > +endif
> >
> > CFLAGS_trace-event-perl.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum
> >
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> > index d685a7399ee2..fabba21919b8 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -30,6 +30,7 @@
> > #include <linux/bitmap.h>
> > #include <linux/compiler.h>
> > #include <linux/time64.h>
> > +#include <traceevent/event-parse.h>
> >
> > #include "../build-id.h"
> > #include "../counts.h"
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 1facd4616317..7c021c6cedb9 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -314,7 +314,9 @@ void perf_session__delete(struct perf_session *session)
> >                       evlist__delete(session->evlist);
> >               perf_data__close(session->data);
> >       }
> > +#ifdef HAVE_LIBTRACEEVENT
> >       trace_event__cleanup(&session->tevent);
> > +#endif
> >       free(session);
> > }
> >
> > diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
> > index be5871ea558f..ee3715e8563b 100644
> > --- a/tools/perf/util/session.h
> > +++ b/tools/perf/util/session.h
> > @@ -33,7 +33,9 @@ struct perf_session {
> >       struct auxtrace         *auxtrace;
> >       struct itrace_synth_opts *itrace_synth_opts;
> >       struct list_head        auxtrace_index;
> > +#ifdef HAVE_LIBTRACEEVENT
> >       struct trace_event      tevent;
> > +#endif
> >       struct perf_record_time_conv    time_conv;
> >       bool                    repipe;
> >       bool                    one_mmap;
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index 2e7330867e2e..c7a97b33e134 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -22,7 +22,6 @@
> > #include "srcline.h"
> > #include "strlist.h"
> > #include "strbuf.h"
> > -#include <traceevent/event-parse.h>
> > #include "mem-events.h"
> > #include "annotate.h"
> > #include "event.h"
> > @@ -32,6 +31,10 @@
> > #include <linux/kernel.h>
> > #include <linux/string.h>
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > +#include <traceevent/event-parse.h>
> > +#endif
> > +
> > regex_t               parent_regex;
> > const char    default_parent_pattern[] = "^sys_|^do_page_fault";
> > const char    *parent_pattern = default_parent_pattern;
> > @@ -743,6 +746,7 @@ struct sort_entry sort_time = {
> >
> > /* --sort trace */
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static char *get_trace_output(struct hist_entry *he)
> > {
> >       struct trace_seq seq;
> > @@ -806,6 +810,7 @@ struct sort_entry sort_trace = {
> >       .se_snprintf    = hist_entry__trace_snprintf,
> >       .se_width_idx   = HISTC_TRACE,
> > };
> > +#endif /* HAVE_LIBTRACEEVENT */
> >
> > /* sort keys for branch stacks */
> >
> > @@ -2022,7 +2027,9 @@ static struct sort_dimension common_sort_dimensions[] = {
> >       DIM(SORT_LOCAL_WEIGHT, "local_weight", sort_local_weight),
> >       DIM(SORT_GLOBAL_WEIGHT, "weight", sort_global_weight),
> >       DIM(SORT_TRANSACTION, "transaction", sort_transaction),
> > +#ifdef HAVE_LIBTRACEEVENT
> >       DIM(SORT_TRACE, "trace", sort_trace),
> > +#endif
> >       DIM(SORT_SYM_SIZE, "symbol_size", sort_sym_size),
> >       DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
> >       DIM(SORT_CGROUP, "cgroup", sort_cgroup),
> > @@ -2206,7 +2213,14 @@ bool perf_hpp__is_ ## key ## _entry(struct perf_hpp_fmt *fmt)  \
> >       return hse->se == &sort_ ## key ;                       \
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > MK_SORT_ENTRY_CHK(trace)
> > +#else
> > +bool perf_hpp__is_trace_entry(struct perf_hpp_fmt *fmt __maybe_unused)
> > +{
> > +     return false;
> > +}
> > +#endif
> > MK_SORT_ENTRY_CHK(srcline)
> > MK_SORT_ENTRY_CHK(srcfile)
> > MK_SORT_ENTRY_CHK(thread)
> > @@ -2347,6 +2361,17 @@ static int __sort_dimension__add_hpp_output(struct sort_dimension *sd,
> >       return 0;
> > }
> >
> > +#ifndef HAVE_LIBTRACEEVENT
> > +bool perf_hpp__is_dynamic_entry(struct perf_hpp_fmt *fmt __maybe_unused)
> > +{
> > +     return false;
> > +}
> > +bool perf_hpp__defined_dynamic_entry(struct perf_hpp_fmt *fmt __maybe_unused,
> > +                                  struct hists *hists __maybe_unused)
> > +{
> > +     return false;
> > +}
> > +#else
> > struct hpp_dynamic_entry {
> >       struct perf_hpp_fmt hpp;
> >       struct evsel *evsel;
> > @@ -2621,6 +2646,7 @@ __alloc_dynamic_entry(struct evsel *evsel, struct tep_format_field *field,
> >
> >       return hde;
> > }
> > +#endif /* HAVE_LIBTRACEEVENT */
> >
> > struct perf_hpp_fmt *perf_hpp_fmt__dup(struct perf_hpp_fmt *fmt)
> > {
> > @@ -2633,6 +2659,7 @@ struct perf_hpp_fmt *perf_hpp_fmt__dup(struct perf_hpp_fmt *fmt)
> >               new_hse = memdup(hse, sizeof(*hse));
> >               if (new_hse)
> >                       new_fmt = &new_hse->hpp;
> > +#ifdef HAVE_LIBTRACEEVENT
> >       } else if (perf_hpp__is_dynamic_entry(fmt)) {
> >               struct hpp_dynamic_entry *hde, *new_hde;
> >
> > @@ -2640,6 +2667,7 @@ struct perf_hpp_fmt *perf_hpp_fmt__dup(struct perf_hpp_fmt *fmt)
> >               new_hde = memdup(hde, sizeof(*hde));
> >               if (new_hde)
> >                       new_fmt = &new_hde->hpp;
> > +#endif
> >       } else {
> >               new_fmt = memdup(fmt, sizeof(*fmt));
> >       }
> > @@ -2719,6 +2747,7 @@ static struct evsel *find_evsel(struct evlist *evlist, char *event_name)
> >       return evsel;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > static int __dynamic_dimension__add(struct evsel *evsel,
> >                                   struct tep_format_field *field,
> >                                   bool raw_trace, int level)
> > @@ -2789,13 +2818,13 @@ static int add_all_matching_fields(struct evlist *evlist,
> >       }
> >       return ret;
> > }
> > +#endif /* HAVE_LIBTRACEEVENT */
> >
> > static int add_dynamic_entry(struct evlist *evlist, const char *tok,
> >                            int level)
> > {
> >       char *str, *event_name, *field_name, *opt_name;
> >       struct evsel *evsel;
> > -     struct tep_format_field *field;
> >       bool raw_trace = symbol_conf.raw_trace;
> >       int ret = 0;
> >
> > @@ -2820,6 +2849,7 @@ static int add_dynamic_entry(struct evlist *evlist, const char *tok,
> >               raw_trace = true;
> >       }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (!strcmp(field_name, "trace_fields")) {
> >               ret = add_all_dynamic_fields(evlist, raw_trace, level);
> >               goto out;
> > @@ -2829,6 +2859,7 @@ static int add_dynamic_entry(struct evlist *evlist, const char *tok,
> >               ret = add_all_matching_fields(evlist, field_name, raw_trace, level);
> >               goto out;
> >       }
> > +#endif
> >
> >       evsel = find_evsel(evlist, event_name);
> >       if (evsel == NULL) {
> > @@ -2843,10 +2874,12 @@ static int add_dynamic_entry(struct evlist *evlist, const char *tok,
> >               goto out;
> >       }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (!strcmp(field_name, "*")) {
> >               ret = add_evsel_fields(evsel, raw_trace, level);
> >       } else {
> > -             field = tep_find_any_field(evsel->tp_format, field_name);
> > +             struct tep_format_field *field = tep_find_any_field(evsel->tp_format, field_name);
> > +
> >               if (field == NULL) {
> >                       pr_debug("Cannot find event field for %s.%s\n",
> >                                event_name, field_name);
> > @@ -2855,6 +2888,10 @@ static int add_dynamic_entry(struct evlist *evlist, const char *tok,
> >
> >               ret = __dynamic_dimension__add(evsel, field, raw_trace, level);
> >       }
> > +#else
> > +     (void)level;
> > +     (void)raw_trace;
> > +#endif /* HAVE_LIBTRACEEVENT */
> >
> > out:
> >       free(str);
> > @@ -2955,11 +2992,11 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> >       for (i = 0; i < ARRAY_SIZE(common_sort_dimensions); i++) {
> >               struct sort_dimension *sd = &common_sort_dimensions[i];
> >
> > -             if (strncasecmp(tok, sd->name, strlen(tok)))
> > +             if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
> >                       continue;
> >
> >               for (j = 0; j < ARRAY_SIZE(dynamic_headers); j++) {
> > -                     if (!strcmp(dynamic_headers[j], sd->name))
> > +                     if (sd->name && !strcmp(dynamic_headers[j], sd->name))
> >                               sort_dimension_add_dynamic_header(sd);
> >               }
> >
> > @@ -3009,7 +3046,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> >       for (i = 0; i < ARRAY_SIZE(bstack_sort_dimensions); i++) {
> >               struct sort_dimension *sd = &bstack_sort_dimensions[i];
> >
> > -             if (strncasecmp(tok, sd->name, strlen(tok)))
> > +             if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
> >                       continue;
> >
> >               if (sort__mode != SORT_MODE__BRANCH)
> > @@ -3025,7 +3062,7 @@ int sort_dimension__add(struct perf_hpp_list *list, const char *tok,
> >       for (i = 0; i < ARRAY_SIZE(memory_sort_dimensions); i++) {
> >               struct sort_dimension *sd = &memory_sort_dimensions[i];
> >
> > -             if (strncasecmp(tok, sd->name, strlen(tok)))
> > +             if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
> >                       continue;
> >
> >               if (sort__mode != SORT_MODE__MEMORY)
> > @@ -3339,7 +3376,7 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
> >       for (i = 0; i < ARRAY_SIZE(common_sort_dimensions); i++) {
> >               struct sort_dimension *sd = &common_sort_dimensions[i];
> >
> > -             if (strncasecmp(tok, sd->name, strlen(tok)))
> > +             if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
> >                       continue;
> >
> >               return __sort_dimension__add_output(list, sd);
> > @@ -3357,7 +3394,7 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
> >       for (i = 0; i < ARRAY_SIZE(bstack_sort_dimensions); i++) {
> >               struct sort_dimension *sd = &bstack_sort_dimensions[i];
> >
> > -             if (strncasecmp(tok, sd->name, strlen(tok)))
> > +             if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
> >                       continue;
> >
> >               if (sort__mode != SORT_MODE__BRANCH)
> > @@ -3369,7 +3406,7 @@ int output_field_add(struct perf_hpp_list *list, char *tok)
> >       for (i = 0; i < ARRAY_SIZE(memory_sort_dimensions); i++) {
> >               struct sort_dimension *sd = &memory_sort_dimensions[i];
> >
> > -             if (strncasecmp(tok, sd->name, strlen(tok)))
> > +             if (!sd->name || strncasecmp(tok, sd->name, strlen(tok)))
> >                       continue;
> >
> >               if (sort__mode != SORT_MODE__MEMORY)
> > @@ -3508,6 +3545,9 @@ void reset_output_field(void)
> >
> > static void add_key(struct strbuf *sb, const char *str, int *llen)
> > {
> > +     if (!str)
> > +             return;
> > +
> >       if (*llen >= 75) {
> >               strbuf_addstr(sb, "\n\t\t\t ");
> >               *llen = INDENT;
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> > index 0645795ff080..3ab6a92b1a6d 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -2157,6 +2157,7 @@ int perf_event__synthesize_attr(struct perf_tool *tool, struct perf_event_attr *
> >       return err;
> > }
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> > int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd, struct evlist *evlist,
> >                                       perf_event__handler_t process)
> > {
> > @@ -2203,6 +2204,7 @@ int perf_event__synthesize_tracing_data(struct perf_tool *tool, int fd, struct e
> >
> >       return aligned_size;
> > }
> > +#endif
> >
> > int perf_event__synthesize_build_id(struct perf_tool *tool, struct dso *pos, u16 misc,
> >                                   perf_event__handler_t process, struct machine *machine)
> > @@ -2355,6 +2357,7 @@ int perf_event__synthesize_for_pipe(struct perf_tool *tool,
> >       }
> >       ret += err;
> >
> > +#ifdef HAVE_LIBTRACEEVENT
> >       if (have_tracepoints(&evlist->core.entries)) {
> >               int fd = perf_data__fd(data);
> >
> > @@ -2374,6 +2377,9 @@ int perf_event__synthesize_for_pipe(struct perf_tool *tool,
> >               }
> >               ret += err;
> >       }
> > +#else
> > +     (void)data;
> > +#endif
> >
> >       return ret;
> > }
> > diff --git a/tools/perf/util/trace-event-parse.c b/tools/perf/util/trace-event-parse.c
> > index c9c83a40647c..2d3c2576bab7 100644
> > --- a/tools/perf/util/trace-event-parse.c
> > +++ b/tools/perf/util/trace-event-parse.c
> > @@ -11,6 +11,8 @@
> > #include "trace-event.h"
> >
> > #include <linux/ctype.h>
> > +#include <linux/kernel.h>
> > +#include <traceevent/event-parse.h>
> >
> > static int get_common_field(struct scripting_context *context,
> >                           int *offset, int *size, const char *type)
> > diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
> > index 43146a4ce2fb..1162c49b8082 100644
> > --- a/tools/perf/util/trace-event-read.c
> > +++ b/tools/perf/util/trace-event-read.c
> > @@ -11,6 +11,7 @@
> > #include <sys/stat.h>
> > #include <sys/wait.h>
> > #include <sys/mman.h>
> > +#include <traceevent/event-parse.h>
> > #include <fcntl.h>
> > #include <unistd.h>
> > #include <errno.h>
> > diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> > index 636a010d929b..56175c53f9af 100644
> > --- a/tools/perf/util/trace-event-scripting.c
> > +++ b/tools/perf/util/trace-event-scripting.c
> > @@ -9,6 +9,7 @@
> > #include <stdlib.h>
> > #include <string.h>
> > #include <errno.h>
> > +#include <traceevent/event-parse.h>
> >
> > #include "debug.h"
> > #include "trace-event.h"
> > diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
> > index b3ee651e3d91..8ad75b31e09b 100644
> > --- a/tools/perf/util/trace-event.c
> > +++ b/tools/perf/util/trace-event.c
> > @@ -1,5 +1,4 @@
> > // SPDX-License-Identifier: GPL-2.0
> > -
> > #include <stdio.h>
> > #include <unistd.h>
> > #include <stdlib.h>
> > diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> > index 8f39f5bcb2c2..add6c5d9531c 100644
> > --- a/tools/perf/util/trace-event.h
> > +++ b/tools/perf/util/trace-event.h
> > @@ -2,9 +2,11 @@
> > #ifndef _PERF_UTIL_TRACE_EVENT_H
> > #define _PERF_UTIL_TRACE_EVENT_H
> >
> > -#include <traceevent/event-parse.h>
> > -#include "parse-events.h"
> > +#include <stdbool.h>
> > +#include <stdio.h>
> > +#include <linux/types.h>
> >
> > +struct evlist;
> > struct machine;
> > struct perf_sample;
> > union perf_event;
> > @@ -18,6 +20,11 @@ struct trace_event {
> >       struct tep_plugin_list  *plugin_list;
> > };
> >
> > +typedef char *(tep_func_resolver_t)(void *priv,
> > +                                 unsigned long long *addrp, char **modp);
> > +
> > +bool have_tracepoints(struct list_head *evlist);
> > +
> > int trace_event__init(struct trace_event *t);
> > void trace_event__cleanup(struct trace_event *t);
> > int trace_event__register_resolver(struct machine *machine,
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
> >
>
