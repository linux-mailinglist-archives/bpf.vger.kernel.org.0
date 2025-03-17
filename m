Return-Path: <bpf+bounces-54216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66847A65A37
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE687A2604
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8564B1EDA19;
	Mon, 17 Mar 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/WnmX+k"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A41A38E3;
	Mon, 17 Mar 2025 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742231544; cv=none; b=MjDj+JTaxiprZ4lzM+pyK2CXKbzi0rimK0wTQontRDHdgN4jYw4hQI/YCNvwrXyUNLO5fVfiQ0LYLNdNvPvk+4MkOdGQ+aD2wA1dlKzab99G8sGupnhuD9S27rr8uVw2J/LTibcN4ksPjTwTIbSSw/TVdEslzPirOVr7ZlmFzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742231544; c=relaxed/simple;
	bh=l+W27dM7NXeV4RLA6dG+8n4yz6qVY2crzVyiZBDBhWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKUosly976bz0nPZspOxljNoRP0+vd71uQQ48JIq0/1uC7BlQg+TKyicQhOaTOf2wkt4TlpFL9yRIxJ8Er9ovVHgC70sAUv+nJ3JQ9ItVEINcpL9O00hXMFC6SJWWc5FBbDFEQbXx4FmyAmbUbkr4bF+590erpcW1zSknmScy18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/WnmX+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06A2CC4CEE3;
	Mon, 17 Mar 2025 17:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742231543;
	bh=l+W27dM7NXeV4RLA6dG+8n4yz6qVY2crzVyiZBDBhWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/WnmX+kb4FDlkpUGzudzPpX2M0zx7/TK/8j7QiB5lwBp7cGNsGkbuFcgjPgShxxH
	 5xi5g48Bkbw6fg34s9Vfm9WPNk7jemERVNTFb4mtDyYNlrr2DFpl7zPLiKL+JrDJWJ
	 AEN5DeEoo2C1sr5uYxg5W+4FodxfpW/dP4V+dx4G57Mfjx3Gs9lJzaTR2b/sUo91iF
	 l+jWCsadGbVsSos1kQJKviG8HnCK0hRZjrT4kDHxD5oV1lJbzX9upY+GmY0qXGvOzB
	 mm5m2f9RZNdBzdDIxmAHzAb2Wt8nNhwiyasie5wrCQA4VwdCO35NDvX4hNWqjt8sC+
	 KjX1Tk3/O58fw==
Date: Mon, 17 Mar 2025 10:12:21 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-trace-devel@vger.kernel.org,
	bpf@vger.kernel.org, Quentin Monnet <qmo@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/1 perf-tools-next] tools features: Don't check for
 libunwind devel files by default
Message-ID: <Z9hX9fubyWFjnpPW@google.com>
References: <Z09zTztD8X8qIWCX@x1>
 <CAP-5=fWqA+Wjr5eb3Mi0MO8KZ01fey6J2d72jJouN+_r_8vbdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWqA+Wjr5eb3Mi0MO8KZ01fey6J2d72jJouN+_r_8vbdA@mail.gmail.com>

CC-ing more people.

On Mon, Mar 17, 2025 at 09:09:20AM -0700, Ian Rogers wrote:
> On Tue, Dec 3, 2024 at 1:08 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Since 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather than
> > opt-out"), so we shouldn't by default be testing for its availability at
> > build time in tools/build/features/test-all.c.
> >
> > That test was designed to test the features we expect to be the most
> > common ones in most builds, so if we test build just that file, then we
> > assume the features there are present and will not test one by one.
> >
> > Removing it from test-all.c gets rid of the first impediment for
> > test-all.c to build successfully:
> >
> >   $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
> >   In file included from test-all.c:62:
> >   test-libunwind.c:2:10: fatal error: libunwind.h: No such file or directory
> >       2 | #include <libunwind.h>
> >         |          ^~~~~~~~~~~~~
> >   compilation terminated.
> >   $
> >
> > We then get to:
> >
> >   $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
> >   /usr/bin/ld: cannot find -lunwind-x86_64: No such file or directory
> >   /usr/bin/ld: cannot find -lunwind: No such file or directory
> >   collect2: error: ld returned 1 exit status
> >   $
> >
> > So make all the logic related to setting CFLAGS, LDFLAGS, etc for
> > libunwind to be conditional on NO_LIBWUNWIND=1, which is now the
> > default, now we get a faster build:
> >
> >   $ cat /tmp/build/perf-tools-next/feature/test-all.make.output
> >   $ ldd /tmp/build/perf-tools-next/feature/test-all.bin
> >         linux-vdso.so.1 (0x00007fef04cde000)
> >         libdw.so.1 => /lib64/libdw.so.1 (0x00007fef04a49000)
> >         libpython3.12.so.1.0 => /lib64/libpython3.12.so.1.0 (0x00007fef04478000)
> >         libm.so.6 => /lib64/libm.so.6 (0x00007fef04394000)
> >         libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007fef0436c000)
> >         libtracefs.so.1 => /lib64/libtracefs.so.1 (0x00007fef04345000)
> >         libcrypto.so.3 => /lib64/libcrypto.so.3 (0x00007fef03e95000)
> >         libz.so.1 => /lib64/libz.so.1 (0x00007fef03e72000)
> >         libelf.so.1 => /lib64/libelf.so.1 (0x00007fef03e56000)
> >         libnuma.so.1 => /lib64/libnuma.so.1 (0x00007fef03e48000)
> >         libslang.so.2 => /lib64/libslang.so.2 (0x00007fef03b65000)
> >         libperl.so.5.38 => /lib64/libperl.so.5.38 (0x00007fef037c6000)
> >         libc.so.6 => /lib64/libc.so.6 (0x00007fef035d5000)
> >         liblzma.so.5 => /lib64/liblzma.so.5 (0x00007fef035a0000)
> >         libzstd.so.1 => /lib64/libzstd.so.1 (0x00007fef034e1000)
> >         libbz2.so.1 => /lib64/libbz2.so.1 (0x00007fef034cd000)
> >         /lib64/ld-linux-x86-64.so.2 (0x00007fef04ce0000)
> >         libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007fef03495000)
> >   $
> >
> > Fixes: 13e17c9ff49119aa ("perf build: Make libunwind opt-in rather than opt-out")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: James Clark <james.clark@linaro.org>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Kan Liang <kan.liang@linux.intel.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/build/feature/test-all.c |  5 --
> >  tools/perf/Makefile.config     | 83 ++++++++++++++++++++--------------
> >  2 files changed, 49 insertions(+), 39 deletions(-)
> >
> > diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
> > index 59ef3d7fe6a4e771..80ac297f81967171 100644
> > --- a/tools/build/feature/test-all.c
> > +++ b/tools/build/feature/test-all.c
> > @@ -58,10 +58,6 @@
> >  # include "test-libelf-getshdrstrndx.c"
> >  #undef main
> >
> > -#define main main_test_libunwind
> > -# include "test-libunwind.c"
> > -#undef main
> > -
> >  #define main main_test_libslang
> >  # include "test-libslang.c"
> >  #undef main
> > @@ -184,7 +180,6 @@ int main(int argc, char *argv[])
> >         main_test_libelf_getphdrnum();
> >         main_test_libelf_gelf_getnote();
> >         main_test_libelf_getshdrstrndx();
> > -       main_test_libunwind();
> >         main_test_libslang();
> >         main_test_libbfd();
> >         main_test_libbfd_buildid();
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 2916d59c88cd08b2..0e4f6a860ae25339 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -43,7 +43,9 @@ endif
> >  # Additional ARCH settings for ppc
> >  ifeq ($(SRCARCH),powerpc)
> >    CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
> > -  LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
> > +  ifndef NO_LIBUNWIND
> > +    LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
> > +  endif
> 
> Sorry for missing this patch. Given this, and below, are just
> declaring a variable making it NO_LIBUNWIND conditional feels like
> clutter. I'd suggest just keeping the variable unconditionally and
> making the uses conditional (which of course the patch does).

Agreed, we can leave LIBUNWIND_LIBS setting and make it added only if
NO_LIBUNWIND is not set.

Thanks,
Namhyung

> 
> Other than this:
> Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks,
> Ian
> 
> >  endif
> >
> >  # Additional ARCH settings for x86
> > @@ -53,25 +55,35 @@ ifeq ($(SRCARCH),x86)
> >    ifeq (${IS_64_BIT}, 1)
> >      CFLAGS += -DHAVE_ARCH_X86_64_SUPPORT
> >      ARCH_INCLUDE = ../../arch/x86/lib/memcpy_64.S ../../arch/x86/lib/memset_64.S
> > -    LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
> > +    ifndef NO_LIBUNWIND
> > +      LIBUNWIND_LIBS = -lunwind-x86_64 -lunwind -llzma
> > +    endif
> >      $(call detected,CONFIG_X86_64)
> >    else
> > -    LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
> > +    ifndef NO_LIBUNWIND
> > +      LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
> > +    endif
> >    endif
> >  endif
> >
> >  ifeq ($(SRCARCH),arm)
> > -  LIBUNWIND_LIBS = -lunwind -lunwind-arm
> > +  ifndef NO_LIBUNWIND
> > +    LIBUNWIND_LIBS = -lunwind -lunwind-arm
> > +  endif
> >  endif
> >
> >  ifeq ($(SRCARCH),arm64)
> >    CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
> > -  LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
> > +  ifndef NO_LIBUNWIND
> > +    LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
> > +  endif
> >  endif
> >
> >  ifeq ($(SRCARCH),loongarch)
> >    CFLAGS += -I$(OUTPUT)arch/loongarch/include/generated
> > -  LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
> > +  ifndef NO_LIBUNWIND
> > +    LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
> > +  endif
> >  endif
> >
> >  ifeq ($(ARCH),s390)
> > @@ -80,7 +92,9 @@ endif
> >
> >  ifeq ($(ARCH),mips)
> >    CFLAGS += -I$(OUTPUT)arch/mips/include/generated
> > -  LIBUNWIND_LIBS = -lunwind -lunwind-mips
> > +  ifndef NO_LIBUNWIND
> > +    LIBUNWIND_LIBS = -lunwind -lunwind-mips
> > +  endif
> >  endif
> >
> >  ifeq ($(ARCH),riscv)
> > @@ -121,16 +135,18 @@ ifdef LIBUNWIND_DIR
> >    $(foreach libunwind_arch,$(LIBUNWIND_ARCHS),$(call libunwind_arch_set_flags,$(libunwind_arch)))
> >  endif
> >
> > -# Set per-feature check compilation flags
> > -FEATURE_CHECK_CFLAGS-libunwind = $(LIBUNWIND_CFLAGS)
> > -FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
> > -FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
> > -FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
> > -
> > -FEATURE_CHECK_LDFLAGS-libunwind-arm += -lunwind -lunwind-arm
> > -FEATURE_CHECK_LDFLAGS-libunwind-aarch64 += -lunwind -lunwind-aarch64
> > -FEATURE_CHECK_LDFLAGS-libunwind-x86 += -lunwind -llzma -lunwind-x86
> > -FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64
> > +ifndef NO_LIBUNWIND
> > +  # Set per-feature check compilation flags
> > +  FEATURE_CHECK_CFLAGS-libunwind = $(LIBUNWIND_CFLAGS)
> > +  FEATURE_CHECK_LDFLAGS-libunwind = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
> > +  FEATURE_CHECK_CFLAGS-libunwind-debug-frame = $(LIBUNWIND_CFLAGS)
> > +  FEATURE_CHECK_LDFLAGS-libunwind-debug-frame = $(LIBUNWIND_LDFLAGS) $(LIBUNWIND_LIBS)
> > +
> > +  FEATURE_CHECK_LDFLAGS-libunwind-arm += -lunwind -lunwind-arm
> > +  FEATURE_CHECK_LDFLAGS-libunwind-aarch64 += -lunwind -lunwind-aarch64
> > +  FEATURE_CHECK_LDFLAGS-libunwind-x86 += -lunwind -llzma -lunwind-x86
> > +  FEATURE_CHECK_LDFLAGS-libunwind-x86_64 += -lunwind -llzma -lunwind-x86_64
> > +endif
> >
> >  FEATURE_CHECK_LDFLAGS-libcrypto = -lcrypto
> >
> > @@ -734,26 +750,25 @@ ifeq ($(dwarf-post-unwind),1)
> >    $(call detected,CONFIG_DWARF_UNWIND)
> >  endif
> >
> > -ifndef NO_LOCAL_LIBUNWIND
> > -  ifeq ($(SRCARCH),$(filter $(SRCARCH),arm arm64))
> > -    $(call feature_check,libunwind-debug-frame)
> > -    ifneq ($(feature-libunwind-debug-frame), 1)
> > -      $(warning No debug_frame support found in libunwind)
> > +ifndef NO_LIBUNWIND
> > +  ifndef NO_LOCAL_LIBUNWIND
> > +    ifeq ($(SRCARCH),$(filter $(SRCARCH),arm arm64))
> > +      $(call feature_check,libunwind-debug-frame)
> > +      ifneq ($(feature-libunwind-debug-frame), 1)
> > +        $(warning No debug_frame support found in libunwind)
> > +        CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME
> > +      endif
> > +    else
> > +      # non-ARM has no dwarf_find_debug_frame() function:
> >        CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME
> >      endif
> > -  else
> > -    # non-ARM has no dwarf_find_debug_frame() function:
> > -    CFLAGS += -DNO_LIBUNWIND_DEBUG_FRAME
> > +    EXTLIBS += $(LIBUNWIND_LIBS)
> > +    LDFLAGS += $(LIBUNWIND_LIBS)
> > +  endif
> > +  ifeq ($(findstring -static,${LDFLAGS}),-static)
> > +    # gcc -static links libgcc_eh which contans piece of libunwind
> > +    LIBUNWIND_LDFLAGS += -Wl,--allow-multiple-definition
> >    endif
> > -  EXTLIBS += $(LIBUNWIND_LIBS)
> > -  LDFLAGS += $(LIBUNWIND_LIBS)
> > -endif
> > -ifeq ($(findstring -static,${LDFLAGS}),-static)
> > -  # gcc -static links libgcc_eh which contans piece of libunwind
> > -  LIBUNWIND_LDFLAGS += -Wl,--allow-multiple-definition
> > -endif
> > -
> > -ifndef NO_LIBUNWIND
> >    CFLAGS  += -DHAVE_LIBUNWIND_SUPPORT
> >    CFLAGS  += $(LIBUNWIND_CFLAGS)
> >    LDFLAGS += $(LIBUNWIND_LDFLAGS)
> > --
> > 2.47.0
> >

