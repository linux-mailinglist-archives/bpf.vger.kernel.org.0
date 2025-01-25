Return-Path: <bpf+bounces-49738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA4A1C02A
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 02:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4AFC7A26BE
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 01:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8D61E9B04;
	Sat, 25 Jan 2025 01:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="39xn9xKt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827231E98E8
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737768122; cv=none; b=L8fNny5aQc1deOiRzlA/UE/tGw2Rm3Nb4Pq5iSW6w2r879HANNzWxG/wiL3h4jhb8L2dC6J9xhu5vJd4qBTTtDGYC0B6dV2hy6BqXextOfLzT0Ol0TLhmjyaS2HrPbbh4YTC2C4YvTYYnqDlLXO+engBKBKG8eRfiGq9gL3Dj8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737768122; c=relaxed/simple;
	bh=mvl7jppoRUKsfqiLWTeQhEBHjGCtzH9Q6sk3JCBbVmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnEMzhPTO/rt6bWUqYTrB/YHi0U7rhq4a6QS6DMrN0rAQG98V7YvHCYdxaajuldN28ryxOApitgb0NuTqvX+xPmPT7vnVL4G7n+ncmrmGq29pxTfP1IpkReBUP+a6Q3ue4VJ108Dmqp0yOYt8G7wVxPEA9QIA0kl1TFFwCERAdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=39xn9xKt; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a814c54742so33725ab.1
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 17:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737768117; x=1738372917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4Dw0Af14d5VD4KP5zQApvKAVIF9fxOintASqvIF0jw=;
        b=39xn9xKt81FQpSTe2/ubE6P+HT9P+ai52uPKup6TNRspkTPDF4fHRviw7t1H5Y6vFh
         nRRRFR6wXZaA/sOSMZ/pBMkotVDSlHQPxCPE+cSYEJbXhdYcs9fiAqt4v/QebnzJKfZF
         c6xZGWWShVj6hqcEtHF55B1Dhqn42AqnZ/Y7g9sJj/SCg6WFTSTCTNEvKn+DfbVtHyuw
         SqGExlmkiOVlPx+65C9QlmhfsohGJ3uKvbkYLUklufS7PwtC2WKHmKrFiUo9Yme2OHg8
         CfjXnDV7mUghPiYjDyLiMc6lHpMdtaKfe5CZ+p2AqcEjikJ3WxXxuLxyTFVLVl2h3j7H
         0xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737768117; x=1738372917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Dw0Af14d5VD4KP5zQApvKAVIF9fxOintASqvIF0jw=;
        b=ppOCTeIqMntKyGoNCAT/EQ4WFHZZwb4PvvMzy3b9llgioB07vS0mwHFCBHchqr7/ED
         OLk1Qd/1DWxtpuACAt4UCb6JJCiYjPILd9FWMVZQKt3LYGsncOSmTKiQnYM7B4jxQTF6
         EnHgUJaxgVs4i341u+0XVfya8lsxpBJccTl8HxRM9HNB5IGJ3/E3NtF7/XL26hv05/7O
         bMn0ryozrojzooaOrNRzOjA6BvK/oQFRMaQf3/towKUxoKTwijVIZdObz6ZapZ6WXtjN
         LgmAecbz++eQni1Scf99TB2C78LY+CH+4pVhxSWIIRKdeav5PoAAa7zDLtdS7pW1uYn1
         Ft4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYWrApajbdd+nnUpHji2L3IQDFKfesO6EXLVov3LoXF58e64uOcuC6IUVhRQQM9FD+j4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPkZ5OEtD+aXdaHRr4636A8UAwCqdIU3DSctiQ5oBfMqW37Ok3
	2YJivQRkuRO/JpfOrh1Is5USuTIWx2cXxjfPoc+y8r1xqwLHe9GHxZ83YEdQQzB5OFymjtL/+ps
	VP0RGx/UGxQ2X/Ik0dRVtwOpFURsLs6Fd72Cp
X-Gm-Gg: ASbGncufWtSZ9rayudhanT0xHWxqFflMwXIFdOAffHMB3ueL5clTPQMztoClcmwMCd7
	P1Pp3F4GBFD40kLlOzC2FzyN4j7ZlzBvwCqD6F+aOQg6GUWX8xKO5lZSBZbbGJgl8trdCbYMY6w
	==
X-Google-Smtp-Source: AGHT+IH+xLse/HrnDIgLQh3LVBdfDeL9KywAKmjufkkXLJ/H8Bk//mPVcDLAxYPuySYCShQOAepoxnelQ2d2sdIHYIA=
X-Received: by 2002:a05:6e02:218b:b0:3ce:2f93:a02b with SMTP id
 e9e14a558f8ab-3cfd14dad20mr1281845ab.12.1737768117189; Fri, 24 Jan 2025
 17:21:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122174308.350350-1-irogers@google.com> <20250122174308.350350-8-irogers@google.com>
 <Z5QaJOWZfIrlDEmm@google.com>
In-Reply-To: <Z5QaJOWZfIrlDEmm@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 Jan 2025 17:21:45 -0800
X-Gm-Features: AWEUYZnZRMfRLkwVerI_0E5PnY3-__TNq1TbAZZb4C9RM2SoWxPz8TxJV-0K3hw
Message-ID: <CAP-5=fV9LoY4AQjTVC=GNTOYOc_PGBwdP+HC=hMPsY=0ZqpExw@mail.gmail.com>
Subject: Re: [PATCH v3 07/18] perf llvm: Support for dlopen-ing libLLVM.so
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Changbin Du <changbin.du@huawei.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andi Kleen <ak@linux.intel.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:54=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Jan 22, 2025 at 09:42:57AM -0800, Ian Rogers wrote:
> > If perf wasn't built against libLLVM, no HAVE_LIBLLVM_SUPPORT, support
> > dlopen-ing libLLVM.so and then calling the necessary functions by
> > looking them up using dlsym. As the C++ code in llvm-c-helpers used
> > for addr2line is problematic to call using dlsym, build that C++ code
> > against libLLVM.so as a separate shared object, and support dynamic
> > loading of it. This build option is enabled with LIBLLVM_DYNAMIC=3D1
>
> You mean dlopen libllvm is supported only if this build option is used,
> right?  I'm afraid that would also make others hard to use this feature.
> Anyway I think _DYNAMIC is more about static link vs. dynamic link.
> Maybe is LIBLLVM_DLOPEN=3D1 a little better?  Also please add a
> description to Makefile.perf when you add a build option.

Agreed on adding a comment and that LIBLLVM_DYNAMIC name perhaps isn't the =
best.

The situation with the series is that:
1) if libllvm is detected then HAVE_LIBLLVM_SUPPORT is enabled and we
link with LLVM - this matches behavior in the tree currently;
2) if libllvm isn't detected (or NO_LIBLLVM=3D1 is passed to the build)
then we use dlopen for the disassembler in libLLVM.so and for
addr2line in libperf-llvm.so.

We need an option to build libperf-llvm.so and that is what setting
LIBLLVM_DYNAMIC does. We can't determine it by HAVE_LIBLLVM_SUPPORT as
that will link against libllvm and not use dlopen. We can't determine
it by not HAVE_LIBLLVM_SUPPORT, as that indicates dlopen is used but
also that libllvm wasn't feature detected.

So NO_LIBLLVM=3D1 is saying don't link with libllvm, LIBLLVM_DYNAMIC=3D1
is saying, build libperf-llvm.so. Things were done this way to be
compatible with existing build flag behavior.

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/Makefile.config         |  13 ++
> >  tools/perf/Makefile.perf           |  23 ++-
> >  tools/perf/tests/make              |   2 +
> >  tools/perf/util/Build              |   2 +-
> >  tools/perf/util/llvm-c-helpers.cpp | 113 +++++++++++-
> >  tools/perf/util/llvm.c             | 271 +++++++++++++++++++++++++----
> >  6 files changed, 386 insertions(+), 38 deletions(-)
> >
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index cd773fbbc176..5c2814acc5d5 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -963,6 +963,19 @@ ifndef NO_LIBLLVM
> >      NO_LIBLLVM :=3D 1
> >    endif
> >  endif
> > +ifdef LIBLLVM_DYNAMIC
> > +  ifndef NO_LIBLLVM
> > +    $(error LIBLLVM_DYNAMIC should be used with NO_LIBLLVM)
>
> Hmm.. it doesn't seem reasonable to use these two options together.
> Maybe you could force NO_LIBLLVM=3D1 when LIBLLVM_DYNAMIC is used.
>
>
> > +  endif
> > +  $(call feature_check,llvm-perf)
> > +  ifneq ($(feature-llvm-perf), 1)
> > +    $(warning LIBLLVM_DYNAMIC requires libLLVM.so which wasn't feature=
 detected)
>
> Huh?  It's not clear whether you need libLLVM.so or not here.  Can you
> proceed without it?  Why isn't it an error?

It should be an error but I lowered it to a warning to work around
issues with build-test in common with most user errors in
Makefile.config just being warnings.

> Also it looks like it's against the original purpose.  I think you
> wanted dlopen because the library is not available at build time.  But
> now you need it in the build script?

No, the dynamic is saying we want to build libperf-llvm.so for the
sake of addr2line. We want libllvm for that end, we expect regularly
linked llvm support to be disabled.

> > +  endif
> > +  CFLAGS +=3D -DHAVE_LIBLLVM_DYNAMIC
> > +  CFLAGS +=3D $(shell $(LLVM_CONFIG) --cflags)
> > +  CXXFLAGS +=3D -DHAVE_LIBLLVM_DYNAMIC
> > +  CXXFLAGS +=3D $(shell $(LLVM_CONFIG) --cxxflags)
> > +endif
> >
> >  ifndef NO_DEMANGLE
> >    $(call feature_check,cxa-demangle)
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 55d6ce9ea52f..eae77f6af59d 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -456,6 +456,12 @@ ifndef NO_JVMTI
> >  PROGRAMS +=3D $(OUTPUT)$(LIBJVMTI)
> >  endif
> >
> > +LIBPERF_LLVM =3D libperf-llvm.so
> > +
> > +ifdef LIBLLVM_DYNAMIC
> > +PROGRAMS +=3D $(OUTPUT)$(LIBPERF_LLVM)
> > +endif
> > +
> >  DLFILTERS :=3D dlfilter-test-api-v0.so dlfilter-test-api-v2.so dlfilte=
r-show-cycles.so
> >  DLFILTERS :=3D $(patsubst %,$(OUTPUT)dlfilters/%,$(DLFILTERS))
> >
> > @@ -1019,6 +1025,16 @@ $(LIBSYMBOL)-clean:
> >       $(call QUIET_CLEAN, libsymbol)
> >       $(Q)$(RM) -r -- $(LIBSYMBOL_OUTPUT)
> >
> > +ifdef LIBLLVM_DYNAMIC
> > +LIBPERF_LLVM_CXXFLAGS :=3D $(call filter-out,-DHAVE_LIBLLVM_DYNAMIC,$(=
CXXFLAGS)) -DHAVE_LIBLLVM_SUPPORT
> > +LIBPERF_LLVM_LIBS =3D -L$(shell $(LLVM_CONFIG) --libdir) $(LIBLLVM) -l=
stdc++
> > +
> > +$(OUTPUT)$(LIBPERF_LLVM): util/llvm-c-helpers.cpp
> > +     $(QUIET_LINK)$(CXX) $(LIBPERF_LLVM_CXXFLAGS) $(LIBPERF_LLVM_LIBS)=
 -shared -o $@ $<
> > +
> > +$(OUTPUT)perf: $(OUTPUT)$(LIBPERF_LLVM)
> > +endif
> > +
> >  help:
> >       @echo 'Perf make targets:'
> >       @echo '  doc            - make *all* documentation (see below)'
> > @@ -1120,6 +1136,11 @@ ifndef NO_JVMTI
> >       $(call QUIET_INSTALL, $(LIBJVMTI)) \
> >               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(libdir_SQ)'; \
> >               $(INSTALL) $(OUTPUT)$(LIBJVMTI) '$(DESTDIR_SQ)$(libdir_SQ=
)';
> > +endif
> > +ifdef LIBLLVM_DYNAMIC
> > +     $(call QUIET_INSTALL, $(LIBPERF_LLVM)) \
> > +             $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(libdir_SQ)'; \
> > +             $(INSTALL) $(OUTPUT)$(LIBPERF_LLVM) '$(DESTDIR_SQ)$(libdi=
r_SQ)';
> >  endif
> >       $(call QUIET_INSTALL, libexec) \
> >               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)=
'
> > @@ -1301,7 +1322,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBC=
MD)-clean $(LIBSYMBOL)-clean $(
> >               -name '\.*.cmd' -delete -o -name '\.*.d' -delete -o -name=
 '*.shellcheck_log' -delete
> >       $(Q)$(RM) $(OUTPUT).config-detected
> >       $(call QUIET_CLEAN, core-progs) $(RM) $(ALL_PROGRAMS) perf perf-r=
ead-vdso32 \
> > -             perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI).so
> > +             perf-read-vdsox32 $(OUTPUT)$(LIBJVMTI) $(OUTPUT)$(LIBPERF=
_LLVM)
> >       $(call QUIET_CLEAN, core-gen)   $(RM)  *.spec *.pyc *.pyo */*.pyc=
 */*.pyo \
> >               $(OUTPUT)common-cmds.h TAGS tags cscope* $(OUTPUT)PERF-VE=
RSION-FILE \
> >               $(OUTPUT)FEATURE-DUMP $(OUTPUT)util/*-bison* $(OUTPUT)uti=
l/*-flex* \
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index 0ee94caf9ec1..44d76eacce49 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -93,6 +93,7 @@ make_libbpf_dynamic :=3D LIBBPF_DYNAMIC=3D1
> >  make_no_libbpf_DEBUG :=3D NO_LIBBPF=3D1 DEBUG=3D1
> >  make_no_libcrypto   :=3D NO_LIBCRYPTO=3D1
> >  make_no_libllvm     :=3D NO_LIBLLVM=3D1
> > +make_libllvm_dynamic :=3D NO_LIBLLVM=3D1 LIBLLVM_DYNAMIC=3D1
> >  make_with_babeltrace:=3D LIBBABELTRACE=3D1
> >  make_with_coresight :=3D CORESIGHT=3D1
> >  make_no_sdt      :=3D NO_SDT=3D1
> > @@ -162,6 +163,7 @@ run +=3D make_no_libbpf
> >  run +=3D make_no_libbpf_DEBUG
> >  run +=3D make_no_libcrypto
> >  run +=3D make_no_libllvm
> > +run +=3D make_libllvm_dynamic
> >  run +=3D make_no_sdt
> >  run +=3D make_no_syscall_tbl
> >  run +=3D make_with_babeltrace
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 6fe0b5882c97..eb00c599e179 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -27,6 +27,7 @@ perf-util-y +=3D find_bit.o
> >  perf-util-y +=3D get_current_dir_name.o
> >  perf-util-y +=3D levenshtein.o
> >  perf-util-y +=3D llvm.o
> > +perf-util-y +=3D llvm-c-helpers.o
> >  perf-util-y +=3D mmap.o
> >  perf-util-y +=3D memswap.o
> >  perf-util-y +=3D parse-events.o
> > @@ -239,7 +240,6 @@ perf-util-$(CONFIG_CXX_DEMANGLE) +=3D demangle-cxx.=
o
> >  perf-util-y +=3D demangle-ocaml.o
> >  perf-util-y +=3D demangle-java.o
> >  perf-util-y +=3D demangle-rust.o
> > -perf-util-$(CONFIG_LIBLLVM) +=3D llvm-c-helpers.o
> >
> >  ifdef CONFIG_JITDUMP
> >  perf-util-$(CONFIG_LIBELF) +=3D jitdump.o
> > diff --git a/tools/perf/util/llvm-c-helpers.cpp b/tools/perf/util/llvm-=
c-helpers.cpp
> > index 004081bd12c9..5a6f76e6b705 100644
> > --- a/tools/perf/util/llvm-c-helpers.cpp
> > +++ b/tools/perf/util/llvm-c-helpers.cpp
> > @@ -5,17 +5,23 @@
> >   * macros (e.g. noinline) that conflict with compiler builtins used
> >   * by LLVM.
> >   */
> > +#ifdef HAVE_LIBLLVM_SUPPORT
> >  #pragma GCC diagnostic push
> >  #pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLV=
M <=3D 15 */
> >  #include <llvm/DebugInfo/Symbolize/Symbolize.h>
> >  #include <llvm/Support/TargetSelect.h>
> >  #pragma GCC diagnostic pop
> > +#endif
> >
> > +#if !defined(HAVE_LIBLLVM_SUPPORT) || defined(HAVE_LIBLLVM_DYNAMIC)
> > +#include <dlfcn.h>
> > +#endif
> >  #include <inttypes.h>
> >  #include <stdio.h>
> >  #include <sys/types.h>
> >  #include <linux/compiler.h>
> >  extern "C" {
> > +#include "debug.h"
> >  #include <linux/zalloc.h>
> >  }
> >  #include "llvm-c-helpers.h"
> > @@ -23,14 +29,33 @@ extern "C" {
> >  extern "C"
> >  char *dso__demangle_sym(struct dso *dso, int kmodule, const char *elf_=
name);
> >
> > +#ifdef HAVE_LIBLLVM_SUPPORT
> >  using namespace llvm;
> >  using llvm::symbolize::LLVMSymbolizer;
> > +#endif
> > +
> > +#if !defined(HAVE_LIBLLVM_SUPPORT) && defined(HAVE_LIBLLVM_DYNAMIC)
>
> Like I said, it'd be simpler if you could make HAVE_LIBLLVM_SUPPORT and
> HAVE_LIBLLVM_DYNAMIC (or _DLOPEN) mutually exclusive.
>
> And the same argument for the code organization.

I think you're missing the point that we (not strictly) need
libperf-llvm.so. The reason being is that the llvm-c-helpers depend on
the C++ LLVM API. The LLVM C API does a fine job of exposing the
disassembler which is why in llvm.c in the shim code without linking
against libllvm we can just dlsym into it. llvm-c-helpers is really a
simple LLVM addr2line implementation using the LLVM C++ headers.
Perhaps a better name than llvm-c-helpers.cpp would be
llvm-addr2line.cpp, maybe libperf-llvm.so should be
libperf-llvm-addr2line.so. llvm-c-helpers.cpp/llvm-addr2line.cpp is
either going to get called by perf's C code via an extern "C" API or
in the dlopen case the extern "C" API will do the dlopen/dlsym. The
function called by dlsym isn't all the LLVM C++ API shimmed, using
dlsym with C++ code at best isn't great. Instead the same
llvm-c-helpers.cpp/llvm-addr2line.cpp code is compiled as a .so
exposing the extern "C" API function with a slightly mangled name.
This means we have perf's C code calling libperf-llvm.so extern "C"
code, libperf-llvm.so is dynamically linked against libLLVM.so (not
dlopen-ing it as its all C++ code).

Thanks,
Ian

> > +static void *perf_llvm_c_helpers_dll_handle(void)
> > +{
> > +     static bool dll_handle_init;
> > +     static void *dll_handle;
> > +
> > +     if (!dll_handle_init) {
> > +             dll_handle_init =3D true;
> > +             dll_handle =3D dlopen("libperf-llvm.so", RTLD_LAZY);
> > +             if (!dll_handle)
> > +                     pr_debug("dlopen failed for libperf-llvm.so\n");
> > +     }
> > +     return dll_handle;
> > +}
> > +#endif
> >
> >  /*
> >   * Allocate a static LLVMSymbolizer, which will live to the end of the=
 program.
> >   * Unlike the bfd paths, LLVMSymbolizer has its own cache, so we do no=
t need
> >   * to store anything in the dso struct.
> >   */
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> >  static LLVMSymbolizer *get_symbolizer()
> >  {
> >       static LLVMSymbolizer *instance =3D nullptr;
> > @@ -49,8 +74,10 @@ static LLVMSymbolizer *get_symbolizer()
> >       }
> >       return instance;
> >  }
> > +#endif
> >
> >  /* Returns 0 on error, 1 on success. */
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> >  static int extract_file_and_line(const DILineInfo &line_info, char **f=
ile,
> >                                unsigned int *line)
> >  {
> > @@ -69,13 +96,15 @@ static int extract_file_and_line(const DILineInfo &=
line_info, char **file,
> >               *line =3D line_info.Line;
> >       return 1;
> >  }
> > +#endif
> >
> >  extern "C"
> > -int llvm_addr2line(const char *dso_name, u64 addr,
> > -                char **file, unsigned int *line,
> > -                bool unwind_inlines,
> > -                llvm_a2l_frame **inline_frames)
> > +int llvm_addr2line(const char *dso_name __maybe_unused, u64 addr __may=
be_unused,
> > +                char **file __maybe_unused, unsigned int *line __maybe=
_unused,
> > +                bool unwind_inlines __maybe_unused,
> > +                llvm_a2l_frame **inline_frames __maybe_unused)
> >  {
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> >       LLVMSymbolizer *symbolizer =3D get_symbolizer();
> >       object::SectionedAddress sectioned_addr =3D {
> >               addr,
> > @@ -135,8 +164,33 @@ int llvm_addr2line(const char *dso_name, u64 addr,
> >                       return 0;
> >               return extract_file_and_line(*res_or_err, file, line);
> >       }
> > +#elif defined(HAVE_LIBLLVM_DYNAMIC)
> > +     static bool fn_init;
> > +     static int (*fn)(const char *dso_name, u64 addr,
> > +                      char **file, unsigned int *line,
> > +                      bool unwind_inlines,
> > +                      llvm_a2l_frame **inline_frames);
> > +
> > +     if (!fn_init) {
> > +             void * handle =3D perf_llvm_c_helpers_dll_handle();
> > +
> > +             if (!handle)
> > +                     return 0;
> > +
> > +             fn =3D reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm=
_addr2line"));
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for llvm_addr2line\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return 0;
> > +     return fn(dso_name, addr, file, line, unwind_inlines, inline_fram=
es);
> > +#else
> > +     return 0;
> > +#endif
> >  }
> >
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> >  static char *
> >  make_symbol_relative_string(struct dso *dso, const char *sym_name,
> >                           u64 addr, u64 base_addr)
> > @@ -158,10 +212,13 @@ make_symbol_relative_string(struct dso *dso, cons=
t char *sym_name,
> >                       return strdup(sym_name);
> >       }
> >  }
> > +#endif
> >
> >  extern "C"
> > -char *llvm_name_for_code(struct dso *dso, const char *dso_name, u64 ad=
dr)
> > +char *llvm_name_for_code(struct dso *dso __maybe_unused, const char *d=
so_name __maybe_unused,
> > +                      u64 addr __maybe_unused)
> >  {
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> >       LLVMSymbolizer *symbolizer =3D get_symbolizer();
> >       object::SectionedAddress sectioned_addr =3D {
> >               addr,
> > @@ -175,11 +232,34 @@ char *llvm_name_for_code(struct dso *dso, const c=
har *dso_name, u64 addr)
> >       return make_symbol_relative_string(
> >               dso, res_or_err->FunctionName.c_str(),
> >               addr, res_or_err->StartAddress ? *res_or_err->StartAddres=
s : 0);
> > +#elif defined(HAVE_LIBLLVM_DYNAMIC)
> > +     static bool fn_init;
> > +     static char *(*fn)(struct dso *dso, const char *dso_name, u64 add=
r);
> > +
> > +     if (!fn_init) {
> > +             void * handle =3D perf_llvm_c_helpers_dll_handle();
> > +
> > +             if (!handle)
> > +                     return NULL;
> > +
> > +             fn =3D reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm=
_name_for_code"));
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for llvm_name_for_code\n")=
;
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return NULL;
> > +     return fn(dso, dso_name, addr);
> > +#else
> > +     return 0;
> > +#endif
> >  }
> >
> >  extern "C"
> > -char *llvm_name_for_data(struct dso *dso, const char *dso_name, u64 ad=
dr)
> > +char *llvm_name_for_data(struct dso *dso __maybe_unused, const char *d=
so_name __maybe_unused,
> > +                      u64 addr __maybe_unused)
> >  {
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> >       LLVMSymbolizer *symbolizer =3D get_symbolizer();
> >       object::SectionedAddress sectioned_addr =3D {
> >               addr,
> > @@ -193,4 +273,25 @@ char *llvm_name_for_data(struct dso *dso, const ch=
ar *dso_name, u64 addr)
> >       return make_symbol_relative_string(
> >               dso, res_or_err->Name.c_str(),
> >               addr, res_or_err->Start);
> > +#elif defined(HAVE_LIBLLVM_DYNAMIC)
> > +     static bool fn_init;
> > +     static char *(*fn)(struct dso *dso, const char *dso_name, u64 add=
r);
> > +
> > +     if (!fn_init) {
> > +             void * handle =3D perf_llvm_c_helpers_dll_handle();
> > +
> > +             if (!handle)
> > +                     return NULL;
> > +
> > +             fn =3D reinterpret_cast<decltype(fn)>(dlsym(handle, "llvm=
_name_for_data"));
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for llvm_name_for_data\n")=
;
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return NULL;
> > +     return fn(dso, dso_name, addr);
> > +#else
> > +     return 0;
> > +#endif
> >  }
> > diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
> > index ddc737194692..f6a8943b7c9d 100644
> > --- a/tools/perf/util/llvm.c
> > +++ b/tools/perf/util/llvm.c
> > @@ -1,5 +1,6 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include "llvm.h"
> > +#include "llvm-c-helpers.h"
> >  #include "annotate.h"
> >  #include "debug.h"
> >  #include "dso.h"
> > @@ -7,17 +8,243 @@
> >  #include "namespaces.h"
> >  #include "srcline.h"
> >  #include "symbol.h"
> > +#include <dlfcn.h>
> >  #include <fcntl.h>
> > +#include <inttypes.h>
> >  #include <unistd.h>
> >  #include <linux/zalloc.h>
> >
> > -#ifdef HAVE_LIBLLVM_SUPPORT
> > -#include "llvm-c-helpers.h"
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> >  #include <llvm-c/Disassembler.h>
> >  #include <llvm-c/Target.h>
> > +#else
> > +typedef void *LLVMDisasmContextRef;
> > +typedef int (*LLVMOpInfoCallback)(void *dis_info, uint64_t pc, uint64_=
t offset,
> > +                               uint64_t op_size, uint64_t inst_size,
> > +                               int tag_type, void *tag_buf);
> > +typedef const char *(*LLVMSymbolLookupCallback)(void *dis_info,
> > +                                             uint64_t reference_value,
> > +                                             uint64_t *reference_type,
> > +                                             uint64_t reference_pc,
> > +                                             const char **reference_na=
me);
> > +#define LLVMDisassembler_ReferenceType_InOut_None 0
> > +#define LLVMDisassembler_ReferenceType_In_Branch 1
> > +#define LLVMDisassembler_ReferenceType_In_PCrel_Load 2
> > +#define LLVMDisassembler_Option_PrintImmHex 2
> > +#define LLVMDisassembler_Option_AsmPrinterVariant 4
> > +const char *llvm_targets[] =3D {
> > +     "AMDGPU",
> > +     "ARM",
> > +     "AVR",
> > +     "BPF",
> > +     "Hexagon",
> > +     "Lanai",
> > +     "LoongArch",
> > +     "Mips",
> > +     "MSP430",
> > +     "NVPTX",
> > +     "PowerPC",
> > +     "RISCV",
> > +     "Sparc",
> > +     "SystemZ",
> > +     "VE",
> > +     "WebAssembly",
> > +     "X86",
> > +     "XCore",
> > +     "M68k",
> > +     "Xtensa",
> > +};
> > +#endif
> > +
> > +#if !defined(HAVE_LIBLLVM_SUPPORT) || defined(HAVE_LIBLLVM_DYNAMIC)
> > +static void *perf_llvm_dll_handle(void)
> > +{
> > +     static bool dll_handle_init;
> > +     static void *dll_handle;
> > +
> > +     if (!dll_handle_init) {
> > +             dll_handle_init =3D true;
> > +             dll_handle =3D dlopen("libLLVM.so", RTLD_LAZY);
> > +             if (!dll_handle)
> > +                     pr_debug("dlopen failed for libLLVM.so\n");
> > +     }
> > +     return dll_handle;
> > +}
> > +#endif
> > +
> > +#if !defined(HAVE_LIBLLVM_SUPPORT) || defined(HAVE_LIBLLVM_DYNAMIC)
> > +static void *perf_llvm_dll_fun(const char *fmt, const char *target)
> > +{
> > +     char buf[128];
> > +     void *fn;
> > +
> > +     snprintf(buf, sizeof(buf), fmt, target);
> > +     fn =3D dlsym(perf_llvm_dll_handle(), buf);
> > +     if (!fn)
> > +             pr_debug("dlsym failed for %s\n", buf);
> > +
> > +     return fn;
> > +}
> > +#endif
> > +
> > +static void perf_LLVMInitializeAllTargetInfos(void)
> > +{
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> > +     LLVMInitializeAllTargetInfos();
> > +#else
> > +     /* LLVMInitializeAllTargetInfos is a header file function not ava=
ilable as a symbol. */
> > +     static bool done_init;
> > +
> > +     if (done_init)
> > +             return;
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(llvm_targets); i++) {
> > +             void (*fn)(void) =3D perf_llvm_dll_fun("LLVMInitialize%sT=
argetInfo",
> > +                                                  llvm_targets[i]);
> > +
> > +             if (!fn)
> > +                     continue;
> > +             fn();
> > +     }
> > +     done_init =3D true;
> > +#endif
> > +}
> > +
> > +static void perf_LLVMInitializeAllTargetMCs(void)
> > +{
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> > +     LLVMInitializeAllTargetMCs();
> > +#else
> > +     /* LLVMInitializeAllTargetMCs is a header file function not avail=
able as a symbol. */
> > +     static bool done_init;
> > +
> > +     if (done_init)
> > +             return;
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(llvm_targets); i++) {
> > +             void (*fn)(void) =3D perf_llvm_dll_fun("LLVMInitialize%sT=
argetMC",
> > +                                                  llvm_targets[i]);
> > +
> > +             if (!fn)
> > +                     continue;
> > +             fn();
> > +     }
> > +     done_init =3D true;
> > +#endif
> > +}
> > +
> > +static void perf_LLVMInitializeAllDisassemblers(void)
> > +{
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> > +     LLVMInitializeAllDisassemblers();
> > +#else
> > +     /* LLVMInitializeAllDisassemblers is a header file function not a=
vailable as a symbol. */
> > +     static bool done_init;
> > +
> > +     if (done_init)
> > +             return;
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(llvm_targets); i++) {
> > +             void (*fn)(void) =3D perf_llvm_dll_fun("LLVMInitialize%sD=
isassembler",
> > +                                                  llvm_targets[i]);
> > +
> > +             if (!fn)
> > +                     continue;
> > +             fn();
> > +     }
> > +     done_init =3D true;
> > +#endif
> > +}
> > +
> > +static LLVMDisasmContextRef perf_LLVMCreateDisasm(const char *triple_n=
ame, void *dis_info,
> > +                                             int tag_type, LLVMOpInfoC=
allback get_op_info,
> > +                                             LLVMSymbolLookupCallback =
symbol_lookup)
> > +{
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> > +     return LLVMCreateDisasm(triple_name, dis_info, tag_type, get_op_i=
nfo, symbol_lookup);
> > +#else
> > +     static bool fn_init;
> > +     static LLVMDisasmContextRef (*fn)(const char *triple_name, void *=
dis_info,
> > +                                     int tag_type, LLVMOpInfoCallback =
get_op_info,
> > +                                     LLVMSymbolLookupCallback symbol_l=
ookup);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_llvm_dll_handle(), "LLVMCreateDisasm");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for LLVMCreateDisasm\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return NULL;
> > +     return fn(triple_name, dis_info, tag_type, get_op_info, symbol_lo=
okup);
> > +#endif
> > +}
> > +
> > +static int perf_LLVMSetDisasmOptions(LLVMDisasmContextRef context, uin=
t64_t options)
> > +{
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> > +     return LLVMSetDisasmOptions(context, options);
> > +#else
> > +     static bool fn_init;
> > +     static int (*fn)(LLVMDisasmContextRef context, uint64_t options);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_llvm_dll_handle(), "LLVMSetDisasmOption=
s");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for LLVMSetDisasmOptions\n=
");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return 0;
> > +     return fn(context, options);
> > +#endif
> > +}
> > +
> > +static size_t perf_LLVMDisasmInstruction(LLVMDisasmContextRef context,=
 uint8_t *bytes,
> > +                                     uint64_t bytes_size, uint64_t pc,
> > +                                     char *out_string, size_t out_stri=
ng_size)
> > +{
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> > +     return LLVMDisasmInstruction(context, bytes, bytes_size, pc, out_=
string, out_string_size);
> > +#else
> > +     static bool fn_init;
> > +     static int (*fn)(LLVMDisasmContextRef context, uint8_t *bytes,
> > +                     uint64_t bytes_size, uint64_t pc,
> > +                     char *out_string, size_t out_string_size);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_llvm_dll_handle(), "LLVMDisasmInstructi=
on");
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for LLVMDisasmInstruction\=
n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return 0;
> > +     return fn(context, bytes, bytes_size, pc, out_string, out_string_=
size);
> > +#endif
> > +}
> > +
> > +static void perf_LLVMDisasmDispose(LLVMDisasmContextRef context)
> > +{
> > +#if defined(HAVE_LIBLLVM_SUPPORT) && !defined(HAVE_LIBLLVM_DYNAMIC)
> > +     LLVMDisasmDispose(context);
> > +#else
> > +     static bool fn_init;
> > +     static int (*fn)(LLVMDisasmContextRef context);
> > +
> > +     if (!fn_init) {
> > +             fn =3D dlsym(perf_llvm_dll_handle(), "LLVMDisasmDispose")=
;
> > +             if (!fn)
> > +                     pr_debug("dlsym failed for LLVMDisasmDispose\n");
> > +             fn_init =3D true;
> > +     }
> > +     if (!fn)
> > +             return;
> > +     fn(context);
> >  #endif
> > +}
> > +
> >
> > -#ifdef HAVE_LIBLLVM_SUPPORT
> >  static void free_llvm_inline_frames(struct llvm_a2l_frame *inline_fram=
es,
> >                                   int num_frames)
> >  {
> > @@ -29,14 +256,12 @@ static void free_llvm_inline_frames(struct llvm_a2=
l_frame *inline_frames,
> >               zfree(&inline_frames);
> >       }
> >  }
> > -#endif
> >
> >  int llvm__addr2line(const char *dso_name __maybe_unused, u64 addr __ma=
ybe_unused,
> >                    char **file __maybe_unused, unsigned int *line __may=
be_unused,
> >                    struct dso *dso __maybe_unused, bool unwind_inlines =
__maybe_unused,
> >                    struct inline_node *node __maybe_unused, struct symb=
ol *sym __maybe_unused)
> >  {
> > -#ifdef HAVE_LIBLLVM_SUPPORT
> >       struct llvm_a2l_frame *inline_frames =3D NULL;
> >       int num_frames =3D llvm_addr2line(dso_name, addr, file, line,
> >                                       node && unwind_inlines, &inline_f=
rames);
> > @@ -64,9 +289,6 @@ int llvm__addr2line(const char *dso_name __maybe_unu=
sed, u64 addr __maybe_unused
> >       free_llvm_inline_frames(inline_frames, num_frames);
> >
> >       return num_frames;
> > -#else
> > -     return -1;
> > -#endif
> >  }
> >
> >  void dso__free_a2l_llvm(struct dso *dso __maybe_unused)
> > @@ -75,7 +297,6 @@ void dso__free_a2l_llvm(struct dso *dso __maybe_unus=
ed)
> >  }
> >
> >
> > -#if defined(HAVE_LIBLLVM_SUPPORT)
> >  struct find_file_offset_data {
> >       u64 ip;
> >       u64 offset;
> > @@ -139,7 +360,6 @@ read_symbol(const char *filename, struct map *map, =
struct symbol *sym,
> >       free(buf);
> >       return NULL;
> >  }
> > -#endif
> >
> >  /*
> >   * Whenever LLVM wants to resolve an address into a symbol, it calls t=
his
> > @@ -149,7 +369,6 @@ read_symbol(const char *filename, struct map *map, =
struct symbol *sym,
> >   * should add some textual annotation for after the instruction. The c=
aller
> >   * will use this information to add the actual annotation.
> >   */
> > -#ifdef HAVE_LIBLLVM_SUPPORT
> >  struct symbol_lookup_storage {
> >       u64 branch_addr;
> >       u64 pcrel_load_addr;
> > @@ -170,12 +389,10 @@ symbol_lookup_callback(void *disinfo, uint64_t va=
lue,
> >       *ref_type =3D LLVMDisassembler_ReferenceType_InOut_None;
> >       return NULL;
> >  }
> > -#endif
> >
> >  int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
> >                            struct annotate_args *args __maybe_unused)
> >  {
> > -#ifdef HAVE_LIBLLVM_SUPPORT
> >       struct annotation *notes =3D symbol__annotation(sym);
> >       struct map *map =3D args->ms.map;
> >       struct dso *dso =3D map__dso(map);
> > @@ -197,9 +414,9 @@ int symbol__disassemble_llvm(const char *filename, =
struct symbol *sym,
> >       if (args->options->objdump_path)
> >               return -1;
> >
> > -     LLVMInitializeAllTargetInfos();
> > -     LLVMInitializeAllTargetMCs();
> > -     LLVMInitializeAllDisassemblers();
> > +     perf_LLVMInitializeAllTargetInfos();
> > +     perf_LLVMInitializeAllTargetMCs();
> > +     perf_LLVMInitializeAllDisassemblers();
> >
> >       buf =3D read_symbol(filename, map, sym, &len, &is_64bit);
> >       if (buf =3D=3D NULL)
> > @@ -215,15 +432,14 @@ int symbol__disassemble_llvm(const char *filename=
, struct symbol *sym,
> >                         args->arch->name);
> >       }
> >
> > -     disasm =3D LLVMCreateDisasm(triplet, &storage, 0, NULL,
> > -                               symbol_lookup_callback);
> > +     disasm =3D perf_LLVMCreateDisasm(triplet, &storage, 0, NULL,
> > +                                    symbol_lookup_callback);
> >       if (disasm =3D=3D NULL)
> >               goto err;
> >
> >       if (args->options->disassembler_style &&
> >           !strcmp(args->options->disassembler_style, "intel"))
> > -             LLVMSetDisasmOptions(disasm,
> > -                                  LLVMDisassembler_Option_AsmPrinterVa=
riant);
> > +             perf_LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option=
_AsmPrinterVariant);
> >
> >       /*
> >        * This needs to be set after AsmPrinterVariant, due to a bug in =
LLVM;
> > @@ -231,7 +447,7 @@ int symbol__disassemble_llvm(const char *filename, =
struct symbol *sym,
> >        * forget about the PrintImmHex flag (which is applied before if =
both
> >        * are given to the same call).
> >        */
> > -     LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_PrintImmHex)=
;
> > +     perf_LLVMSetDisasmOptions(disasm, LLVMDisassembler_Option_PrintIm=
mHex);
> >
> >       /* add the function address and name */
> >       scnprintf(disasm_buf, sizeof(disasm_buf), "%#"PRIx64" <%s>:",
> > @@ -256,9 +472,9 @@ int symbol__disassemble_llvm(const char *filename, =
struct symbol *sym,
> >               storage.branch_addr =3D 0;
> >               storage.pcrel_load_addr =3D 0;
> >
> > -             ins_len =3D LLVMDisasmInstruction(disasm, buf + offset,
> > -                                             len - offset, pc,
> > -                                             disasm_buf, sizeof(disasm=
_buf));
> > +             ins_len =3D perf_LLVMDisasmInstruction(disasm, buf + offs=
et,
> > +                                                  len - offset, pc,
> > +                                                  disasm_buf, sizeof(d=
isasm_buf));
> >               if (ins_len =3D=3D 0)
> >                       goto err;
> >               disasm_len =3D strlen(disasm_buf);
> > @@ -314,13 +530,8 @@ int symbol__disassemble_llvm(const char *filename,=
 struct symbol *sym,
> >       ret =3D 0;
> >
> >  err:
> > -     LLVMDisasmDispose(disasm);
> > +     perf_LLVMDisasmDispose(disasm);
> >       free(buf);
> >       free(line_storage);
> >       return ret;
> > -#else // HAVE_LIBLLVM_SUPPORT
> > -     pr_debug("The LLVM disassembler isn't linked in for %s in %s\n",
> > -              sym->name, filename);
> > -     return -1;
> > -#endif
> >  }
> > --
> > 2.48.1.262.g85cc9f2d1e-goog
> >

