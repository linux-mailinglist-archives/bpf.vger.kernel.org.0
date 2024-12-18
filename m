Return-Path: <bpf+bounces-47151-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84F09F5B06
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4DC3188D497
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 00:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA49B193077;
	Wed, 18 Dec 2024 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SZf/iQd5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4EE1E4A6
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480183; cv=none; b=dJ27S2bltQ1INgOL/W0xTFJ+VTn/u1oFij4HXefGuKASaJi/btUL8QVr4B0tBCFl+TG71Vborh4gJshlHmFexojPIwNGPtDjIJugrmri/YPymAI3gP1nrI3IgJVzqPeCj+YS6rRaYzOnmEPQENQTrQeF+/iburMB7wEpVrdDm+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480183; c=relaxed/simple;
	bh=O4GxyQFdOIyJV1L49kn3Jem1+wqCGJGC/aFgCiOqQdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPcGOBo3wFMSJd70L8Jg6qwOUeUrzp9DfYK1KfXHRDOOv4/8GCaqO6wivmI9rOKrzLdeSqr5QCPCAn+RAVGXQN7Up8s3a9WN0zv22xvik+7cbf592JgvrI+yehxnQzikroZxZ29atObFyQhs+GadRg3Cssn/CbbF5+RaZdJyD7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SZf/iQd5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2163b0c09afso52396575ad.0
        for <bpf@vger.kernel.org>; Tue, 17 Dec 2024 16:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734480179; x=1735084979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=drYPh0vWxi017hqs04616YLxIMzEf4VG8/okhwk3080=;
        b=SZf/iQd5cITUBJUUcSpNrjgDbjCktFVm51uMaEq1DhYGlGlh5RLh1RJ/OBPkfbDv/Q
         ZlydN3ef8Mx7XdPiqPuGHMrVvfNXBsdFN/tuVpD69kgpkHr5RdBFevFHbeKEfcWf1grR
         Kwh4B6xwfODlUxtH4bGXC1lExdYqWrRTtYwSCFW1zjoIBz/+nuCJclbr3plAEQy6bIbT
         5XHnhwVi9cXxaQUYPJtMtv5BfEVDwXG/KHy8UZji9eaj1DyHgCF0EOe5fAx4Pq5X8tyV
         5bsHmVR+q6GgQcaTuHMGKfLZJth47MfFWLZaR3PT5qn3LuIQm4Zs8UsGZeyacDpA+BUw
         dxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734480179; x=1735084979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=drYPh0vWxi017hqs04616YLxIMzEf4VG8/okhwk3080=;
        b=L7m7l+JGHQm58q8xI0j80XK+GV2ZPJTYB7METU78/u9NSP5Sc9hP6ECafM30ZoC1K/
         tjfqbsZ5XAZB0r07vdMd6AQ5v7NUCPk/09vjpnJZuV7iRtf3pa2I+RRVJ75suB6xTmtm
         qfGLM28Ew9+QtDbOtrd15fn2/Av0UB8fD332Mz2SZsUNaHuELhY+2PG81MfsYaFBf7f5
         oEWJYkst7avj4ekdCTUWjSEoNsb950IZ3QARf3uOja1+h5Zk+oGBJGihKRY9A22ajCNd
         ykibbnWcwrIf+mqgFx24U+Csgt7AQVnMqgLi7fmmkxTY+xS0sN6dAA++8l6RAzbT5HZQ
         Gexw==
X-Forwarded-Encrypted: i=1; AJvYcCX8OJXZnMz/XFeEnbjTKYkg1xiNapRHRr2e5VzYxTsVZUsrIhZsfn+5MiFU9TDGQn/06F0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySizwffPWNVb4CLX1Gyh0uxKOIIdEU5FZ4X8iqTQORoXIRBTgR
	r1qtScZwObdKEWWHxPsgY9KGTAVTbNArIqfxMUILCsIrmR2GLRh+O81StB+Sw00=
X-Gm-Gg: ASbGncuMUOClo226u3wA6JYZfaYycIQAQ+xMqNknbQOfH8Jmb84gjbLLorxyt7ziKh1
	hkGT9zXsQUWDcFhAwmGLe3Ij69rkda8I0SS/5RmkGZNO81B9cR1klV4efR1OH0iNWDCoZwUV4ep
	mbwkgXEYtsH4vmxap2gWa/4N170o3FbOvpfV1VycsfA0BA9kpxqPfWhjhQusncTHmxCvObPcMXB
	vrBT1AvAfBJ3gBRouXYgfzS+tLQ8MFXiz6mrMnekY3yZJs=
X-Google-Smtp-Source: AGHT+IFo8wH+Y7PVcLF/ww50jt+0SlJoO+o2KA7iOtl/CuuZOeZAQKchvlelfffqrwKtfYEPXxVTBA==
X-Received: by 2002:a17:902:ea0e:b0:216:725c:a122 with SMTP id d9443c01a7336-218d7216c88mr11861725ad.19.1734480178717;
        Tue, 17 Dec 2024 16:02:58 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e5f36dsm64992675ad.210.2024.12.17.16.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 16:02:57 -0800 (PST)
Date: Tue, 17 Dec 2024 16:02:54 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 16/16] perf tools: Remove dependency on libaudit
Message-ID: <Z2IRLtRX6V18ktqq@ghost>
References: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
 <20241216-perf_syscalltbl-v3-16-239f032481d5@rivosinc.com>
 <CAP-5=fUNmqnYBLgOJOT9q6QbnhnDKxDXDEAtC-ZZ6orhXa5x3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUNmqnYBLgOJOT9q6QbnhnDKxDXDEAtC-ZZ6orhXa5x3w@mail.gmail.com>

On Tue, Dec 17, 2024 at 03:36:27PM -0800, Ian Rogers wrote:
> On Mon, Dec 16, 2024 at 10:40 PM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > All architectures now support HAVE_SYSCALL_TABLE_SUPPORT, so the flag is
> > no longer needed. With the removal of the flag, the related
> > GENERIC_SYSCALL_TABLE can also be removed. libaudit was only used as a
> > fallback for when HAVE_SYSCALL_TABLE_SUPPORT was not defined, so
> > libaudit is also no longer needed for any architecture.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  Documentation/admin-guide/workload-tracing.rst |  2 +-
> >  tools/build/feature/Makefile                   |  4 --
> >  tools/build/feature/test-libaudit.c            | 11 ------
> >  tools/perf/Documentation/perf-check.txt        |  1 -
> >  tools/perf/Makefile.config                     | 31 +--------------
> >  tools/perf/Makefile.perf                       | 15 --------
> >  tools/perf/builtin-check.c                     |  1 -
> >  tools/perf/builtin-help.c                      |  2 -
> >  tools/perf/builtin-trace.c                     | 30 ---------------
> >  tools/perf/perf.c                              |  6 +--
> >  tools/perf/tests/make                          |  7 +---
> >  tools/perf/util/env.c                          |  4 +-
> >  tools/perf/util/generate-cmdlist.sh            |  4 +-
> >  tools/perf/util/syscalltbl.c                   | 52 --------------------------
> >  14 files changed, 10 insertions(+), 160 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
> > index b2e254ec8ee846afe78eede74a825b51c6ab119b..6be38c1b9c5bb4be899fd261c6d2911abcf959dc 100644
> > --- a/Documentation/admin-guide/workload-tracing.rst
> > +++ b/Documentation/admin-guide/workload-tracing.rst
> > @@ -83,7 +83,7 @@ scripts/ver_linux is a good way to check if your system already has
> >  the necessary tools::
> >
> >    sudo apt-get build-essentials flex bison yacc
> > -  sudo apt install libelf-dev systemtap-sdt-dev libaudit-dev libslang2-dev libperl-dev libdw-dev
> > +  sudo apt install libelf-dev systemtap-sdt-dev libslang2-dev libperl-dev libdw-dev
> >
> >  cscope is a good tool to browse kernel sources. Let's install it now::
> >
> > diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> > index 043dfd00fce72d8f651ccd9b3265a0183f500e5c..e0b63e9d0251abe6d5eafc6d2f26b940918b16ee 100644
> > --- a/tools/build/feature/Makefile
> > +++ b/tools/build/feature/Makefile
> > @@ -13,7 +13,6 @@ FILES=                                          \
> >           test-gtk2.bin                          \
> >           test-gtk2-infobar.bin                  \
> >           test-hello.bin                         \
> > -         test-libaudit.bin                      \
> >           test-libbfd.bin                        \
> >           test-libbfd-buildid.bin               \
> >           test-disassembler-four-args.bin        \
> > @@ -228,9 +227,6 @@ $(OUTPUT)test-libunwind-debug-frame-arm.bin:
> >  $(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
> >         $(BUILD) -lelf -llzma -lunwind-aarch64
> >
> > -$(OUTPUT)test-libaudit.bin:
> > -       $(BUILD) -laudit
> > -
> >  $(OUTPUT)test-libslang.bin:
> >         $(BUILD) -lslang
> >
> > diff --git a/tools/build/feature/test-libaudit.c b/tools/build/feature/test-libaudit.c
> > deleted file mode 100644
> > index f5b0863fa1ec240795339428d8deed98a946d405..0000000000000000000000000000000000000000
> > --- a/tools/build/feature/test-libaudit.c
> > +++ /dev/null
> > @@ -1,11 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -#include <libaudit.h>
> > -
> > -extern int printf(const char *format, ...);
> > -
> > -int main(void)
> > -{
> > -       printf("error message: %s\n", audit_errno_to_name(0));
> > -
> > -       return audit_open();
> > -}
> > diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documentation/perf-check.txt
> > index 31741499e7867c9b712227f31a2958fd641d474a..e6d2ceeb2ca7de850f41b1baa0375b6f984bb08f 100644
> > --- a/tools/perf/Documentation/perf-check.txt
> > +++ b/tools/perf/Documentation/perf-check.txt
> > @@ -51,7 +51,6 @@ feature::
> >                  dwarf_getlocations      /  HAVE_LIBDW_SUPPORT
> >                  dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
> >                  auxtrace                /  HAVE_AUXTRACE_SUPPORT
> > -                libaudit                /  HAVE_LIBAUDIT_SUPPORT
> >                  libbfd                  /  HAVE_LIBBFD_SUPPORT
> >                  libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
> >                  libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 3f82ba907381049213c055ab10c3fe14d9572073..a57b2364578f57e31476f5041a06a0cd22d8b27e 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -28,20 +28,7 @@ include $(srctree)/tools/scripts/Makefile.arch
> >
> >  $(call detected_var,SRCARCH)
> >
> > -ifneq ($(NO_SYSCALL_TABLE),1)
> > -  NO_SYSCALL_TABLE := 1
> > -
> > -  # architectures that use the generic syscall table scripts
> > -  ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
> > -    NO_SYSCALL_TABLE := 0
> > -    CFLAGS += -DGENERIC_SYSCALL_TABLE
> > -    CFLAGS += -I$(OUTPUT)tools/perf/arch/$(SRCARCH)/include/generated
> > -  endif
> > -
> > -  ifneq ($(NO_SYSCALL_TABLE),1)
> > -    CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
> > -  endif
> > -endif
> > +CFLAGS += -I$(OUTPUT)tools/perf/arch/$(SRCARCH)/include/generated
> >
> >  # Additional ARCH settings for ppc
> >  ifeq ($(SRCARCH),powerpc)
> > @@ -755,21 +742,7 @@ ifndef NO_LIBUNWIND
> >  endif
> >
> >  ifneq ($(NO_LIBTRACEEVENT),1)
> > -  ifeq ($(NO_SYSCALL_TABLE),0)
> > -    $(call detected,CONFIG_TRACE)
> > -  else
> > -    ifndef NO_LIBAUDIT
> > -      $(call feature_check,libaudit)
> > -      ifneq ($(feature-libaudit), 1)
> > -        $(warning No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev)
> > -        NO_LIBAUDIT := 1
> > -      else
> > -        CFLAGS += -DHAVE_LIBAUDIT_SUPPORT
> > -        EXTLIBS += -laudit
> > -        $(call detected,CONFIG_TRACE)
> > -      endif
> > -    endif
> > -  endif
> > +  $(call detected,CONFIG_TRACE)
> >  endif
> >
> >  ifndef NO_LIBCRYPTO
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 2c6a509c800d3037933c9b49e5a7dafbf78fda0c..ab2d075ff3a23350a5eea12508cf0376f1d9f4e8 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -59,8 +59,6 @@ include ../scripts/utilities.mak
> >  #
> >  # Define NO_LIBNUMA if you do not want numa perf benchmark
> >  #
> > -# Define NO_LIBAUDIT if you do not want libaudit support
> > -#
> >  # Define NO_LIBBIONIC if you do not want bionic support
> >  #
> >  # Define NO_LIBCRYPTO if you do not want libcrypto (openssl) support
> > @@ -119,10 +117,6 @@ include ../scripts/utilities.mak
> >  #
> >  # Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
> >  #
> > -# Define NO_SYSCALL_TABLE=1 to disable the use of syscall id to/from name tables
> > -# generated from the kernel .tbl or unistd.h files and use, if available, libaudit
> > -# for doing the conversions to/from strings/id.
> > -#
> >  # Define NO_LIBPFM4 to disable libpfm4 events extension.
> >  #
> >  # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
> > @@ -310,11 +304,7 @@ ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
> >  FEATURE_TESTS := all
> >  endif
> >  endif
> > -# architectures that use the generic syscall table
> > -generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips powerpc s390
> > -ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
> >  include $(srctree)/tools/perf/scripts/Makefile.syscalls
> > -endif
> >  include Makefile.config
> >  endif
> >
> > @@ -1099,11 +1089,6 @@ endif
> >                 $(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
> >         $(call QUIET_INSTALL, perf-iostat) \
> >                 $(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfexec_instdir_SQ)'
> > -ifndef NO_LIBAUDIT
> > -       $(call QUIET_INSTALL, strace/groups) \
> > -               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'; \
> > -               $(INSTALL) trace/strace/groups/* -m 644 -t '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDIR_SQ)'
> > -endif
> >  ifndef NO_LIBPERL
> >         $(call QUIET_INSTALL, perl-scripts) \
> >                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
> > diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> > index 2346536a5ee14f91ecd10bd130a64676e871e1b2..7aed7b9f4f5270527ee1d36327eb6a01f196a46a 100644
> > --- a/tools/perf/builtin-check.c
> > +++ b/tools/perf/builtin-check.c
> > @@ -31,7 +31,6 @@ struct feature_status supported_features[] = {
> >         FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
> >         FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
> >         FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
> > -       FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
> >         FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
> >         FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
> >         FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
> > diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
> > index 0854d3cd9f6a304cd9cb50ad430d5706d91df0e9..7be6fb6df595923c15ae51747d5bf17d867ae785 100644
> > --- a/tools/perf/builtin-help.c
> > +++ b/tools/perf/builtin-help.c
> > @@ -447,9 +447,7 @@ int cmd_help(int argc, const char **argv)
> >  #ifdef HAVE_LIBELF_SUPPORT
> >                 "probe",
> >  #endif
> > -#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT)
> >                 "trace",
> > -#endif
> >         NULL };
> >         const char *builtin_help_usage[] = {
> >                 "perf help [--all] [--man|--web|--info] [command]",
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 6a1a128fe645014d0347ad4ec3e0c9e77ec59aee..0fddf34458db4fe4896d25f427f2ae29cb3aa15f 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2069,30 +2069,11 @@ static int trace__read_syscall_info(struct trace *trace, int id)
> >         const char *name = syscalltbl__name(trace->sctbl, id);
> >         int err;
> >
> > -#ifdef HAVE_SYSCALL_TABLE_SUPPORT
> >         if (trace->syscalls.table == NULL) {
> >                 trace->syscalls.table = calloc(trace->sctbl->syscalls.max_id + 1, sizeof(*sc));
> >                 if (trace->syscalls.table == NULL)
> >                         return -ENOMEM;
> >         }
> > -#else
> > -       if (id > trace->sctbl->syscalls.max_id || (id == 0 && trace->syscalls.table == NULL)) {
> > -               // When using libaudit we don't know beforehand what is the max syscall id
> > -               struct syscall *table = realloc(trace->syscalls.table, (id + 1) * sizeof(*sc));
> > -
> > -               if (table == NULL)
> > -                       return -ENOMEM;
> > -
> > -               // Need to memset from offset 0 and +1 members if brand new
> > -               if (trace->syscalls.table == NULL)
> > -                       memset(table, 0, (id + 1) * sizeof(*sc));
> > -               else
> > -                       memset(table + trace->sctbl->syscalls.max_id + 1, 0, (id - trace->sctbl->syscalls.max_id) * sizeof(*sc));
> > -
> > -               trace->syscalls.table         = table;
> > -               trace->sctbl->syscalls.max_id = id;
> > -       }
> > -#endif
> >         sc = trace->syscalls.table + id;
> >         if (sc->nonexistent)
> >                 return -EEXIST;
> > @@ -2439,18 +2420,7 @@ static struct syscall *trace__syscall_info(struct trace *trace,
> >
> >         err = -EINVAL;
> >
> > -#ifdef HAVE_SYSCALL_TABLE_SUPPORT
> >         if (id > trace->sctbl->syscalls.max_id) {
> > -#else
> > -       if (id >= trace->sctbl->syscalls.max_id) {
> > -               /*
> > -                * With libaudit we don't know beforehand what is the max_id,
> > -                * so we let trace__read_syscall_info() figure that out as we
> > -                * go on reading syscalls.
> > -                */
> > -               err = trace__read_syscall_info(trace, id);
> > -               if (err)
> > -#endif
> >                 goto out_cant_read;
> >         }
> >
> > diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> > index a2987f2cfe1a3958f53239ed1a4eec3f87d7466a..f0617cc41f5fe638986e5d8316a6b3056c2c4bc5 100644
> > --- a/tools/perf/perf.c
> > +++ b/tools/perf/perf.c
> > @@ -84,7 +84,7 @@ static struct cmd_struct commands[] = {
> >  #endif
> >         { "kvm",        cmd_kvm,        0 },
> >         { "test",       cmd_test,       0 },
> > -#if defined(HAVE_LIBTRACEEVENT) && (defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT))
> > +#if defined(HAVE_LIBTRACEEVENT)
> >         { "trace",      cmd_trace,      0 },
> >  #endif
> >         { "inject",     cmd_inject,     0 },
> > @@ -514,10 +514,6 @@ int main(int argc, const char **argv)
> >                 fprintf(stderr,
> >                         "trace command not available: missing libtraceevent devel package at build time.\n");
> >                 goto out;
> > -#elif !defined(HAVE_LIBAUDIT_SUPPORT) && !defined(HAVE_SYSCALL_TABLE_SUPPORT)
> > -               fprintf(stderr,
> > -                       "trace command not available: missing audit-libs devel package at build time.\n");
> > -               goto out;
> >  #else
> >                 setup_path();
> >                 argv[0] = "trace";
> > diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> > index a7fcbd589752a90459815bd21075528c6dfa4d94..0ee94caf9ec19820a94a87dd46a7ccf1cefb844a 100644
> > --- a/tools/perf/tests/make
> > +++ b/tools/perf/tests/make
> > @@ -86,7 +86,6 @@ make_no_libdw_dwarf_unwind := NO_LIBDW_DWARF_UNWIND=1
> >  make_no_backtrace   := NO_BACKTRACE=1
> >  make_no_libcapstone := NO_CAPSTONE=1
> >  make_no_libnuma     := NO_LIBNUMA=1
> > -make_no_libaudit    := NO_LIBAUDIT=1
> >  make_no_libbionic   := NO_LIBBIONIC=1
> >  make_no_auxtrace    := NO_AUXTRACE=1
> >  make_no_libbpf     := NO_LIBBPF=1
> > @@ -97,7 +96,6 @@ make_no_libllvm     := NO_LIBLLVM=1
> >  make_with_babeltrace:= LIBBABELTRACE=1
> >  make_with_coresight := CORESIGHT=1
> >  make_no_sdt        := NO_SDT=1
> > -make_no_syscall_tbl := NO_SYSCALL_TABLE=1
> >  make_no_libpfm4     := NO_LIBPFM4=1
> >  make_with_gtk2      := GTK2=1
> >  make_refcnt_check   := EXTRA_CFLAGS="-DREFCNT_CHECKING=1"
> > @@ -122,10 +120,10 @@ make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX3
> >  # all the NO_* variable combined
> >  make_minimal        := NO_LIBPERL=1 NO_LIBPYTHON=1 NO_GTK2=1
> >  make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
> > -make_minimal        += NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1
> > +make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1
> >  make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1
> >  make_minimal        += NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
> > -make_minimal        += NO_LIBCAP=1 NO_SYSCALL_TABLE=1 NO_CAPSTONE=1
> > +make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
> >
> >  # $(run) contains all available tests
> >  run := make_pure
> > @@ -158,7 +156,6 @@ run += make_no_libdw_dwarf_unwind
> >  run += make_no_backtrace
> >  run += make_no_libcapstone
> >  run += make_no_libnuma
> > -run += make_no_libaudit
> >  run += make_no_libbionic
> >  run += make_no_auxtrace
> >  run += make_no_libbpf
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index e2843ca2edd92ea5fa1c020ae92b183c496e975e..e9a694350671910d537de599071dbe7fcc18ced4 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -474,13 +474,13 @@ const char *perf_env__arch(struct perf_env *env)
> >
> >  const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused, int err __maybe_unused)
> >  {
> > -#if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> > +#if defined(HAVE_LIBTRACEEVENT)
> >         if (env->arch_strerrno == NULL)
> >                 env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
> >
> >         return env->arch_strerrno ? env->arch_strerrno(err) : "no arch specific strerrno function";
> >  #else
> > -       return "!(HAVE_SYSCALL_TABLE_SUPPORT && HAVE_LIBTRACEEVENT)";
> > +       return "!HAVE_LIBTRACEEVENT";
> >  #endif
> >  }
> >
> > diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/generate-cmdlist.sh
> > index 1b5140e5ce9975fac87b2674dc694f9d4e439a5f..6a73c903d69050df69267a8aeaeeac1ed170efe1 100755
> > --- a/tools/perf/util/generate-cmdlist.sh
> > +++ b/tools/perf/util/generate-cmdlist.sh
> > @@ -38,7 +38,7 @@ do
> >  done
> >  echo "#endif /* HAVE_LIBELF_SUPPORT */"
> >
> > -echo "#if defined(HAVE_LIBTRACEEVENT) && (defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT))"
> > +echo "#if defined(HAVE_LIBTRACEEVENT)"
> >  sed -n -e 's/^perf-\([^        ]*\)[   ].* audit*/\1/p' command-list.txt |
> >  sort |
> >  while read cmd
> > @@ -51,7 +51,7 @@ do
> >             p
> >       }' "Documentation/perf-$cmd.txt"
> >  done
> > -echo "#endif /* HAVE_LIBTRACEEVENT && (HAVE_LIBAUDIT_SUPPORT || HAVE_SYSCALL_TABLE_SUPPORT) */"
> > +echo "#endif /* HAVE_LIBTRACEEVENT */"
> >
> >  echo "#ifdef HAVE_LIBTRACEEVENT"
> >  sed -n -e 's/^perf-\([^        ]*\)[   ].* traceevent.*/\1/p' command-list.txt |
> > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> > index 210f61b0a7a264a427ebb602185d3a9da2f426f4..928aca4cd6e9f2f26c5c4fd825b4538c064a4cc3 100644
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -10,20 +10,12 @@
> >  #include <linux/compiler.h>
> >  #include <linux/zalloc.h>
> >
> > -#ifdef HAVE_SYSCALL_TABLE_SUPPORT
> >  #include <string.h>
> >  #include "string2.h"
> >
> > -#if defined(GENERIC_SYSCALL_TABLE)
> >  #include <syscall_table.h>
> >  const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
> >  static const char *const *syscalltbl_native = syscalltbl;
> > -#else
> > -const int syscalltbl_native_max_id = 0;
> > -static const char *const syscalltbl_native[] = {
> > -       [0] = "unknown",
> > -};
> > -#endif
> >
> >  struct syscall {
> >         int id;
> > @@ -131,47 +123,3 @@ int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_g
> >         *idx = -1;
> >         return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
> >  }
> > -
> > -#else /* HAVE_SYSCALL_TABLE_SUPPORT */
> > -
> > -#include <libaudit.h>
> > -
> > -struct syscalltbl *syscalltbl__new(void)
> > -{
> > -       struct syscalltbl *tbl = zalloc(sizeof(*tbl));
> > -       if (tbl)
> > -               tbl->audit_machine = audit_detect_machine();
> 
> struct syscalltbl's audit_machine is now unused, remove?

Good point, thank you! Will remove in next version.

- Charlie

> 
> Thanks,
> Ian
> 
> > -       return tbl;
> > -}
> > -
> > -void syscalltbl__delete(struct syscalltbl *tbl)
> > -{
> > -       free(tbl);
> > -}
> > -
> > -const char *syscalltbl__name(const struct syscalltbl *tbl, int id)
> > -{
> > -       return audit_syscall_to_name(id, tbl->audit_machine);
> > -}
> > -
> > -int syscalltbl__id(struct syscalltbl *tbl, const char *name)
> > -{
> > -       return audit_name_to_syscall(name, tbl->audit_machine);
> > -}
> > -
> > -int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx)
> > -{
> > -       return idx;
> > -}
> > -
> > -int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
> > -                                 const char *syscall_glob __maybe_unused, int *idx __maybe_unused)
> > -{
> > -       return -1;
> > -}
> > -
> > -int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
> > -{
> > -       return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
> > -}
> > -#endif /* HAVE_SYSCALL_TABLE_SUPPORT */
> >
> > --
> > 2.34.1
> >

