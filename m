Return-Path: <bpf+bounces-48154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A830A0493D
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 19:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33EC18865AA
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E1B1EF09E;
	Tue,  7 Jan 2025 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IC2msdfc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E0186E40
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 18:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736274688; cv=none; b=sKV5vRMY3+7oEhFW9+2RzcYHQT5lVNyYeU/7TJX+tp3gyG+dwpEqcoYUC359nrTHfEhZSIvtPcN5wdLE8le2WkwAU9sNTfmpIZNwFU37nDILKAIacrwr5Cc+c+XRv4PZ7KHm7aBdyupCaBjUWv7BqLzZnnodwduXHRi2FfKW4Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736274688; c=relaxed/simple;
	bh=V8PjDbrA0VZ4LvROpcX3ogGlKxj1aHP3YXy8Vs0t3Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYSLzMwWOJjYwyZb8xXWx3W7XN6fkPQxoRa1hsYvAjPROw8ahEIA/DV13EZah40NoLKXKix/1Gkq8w9ayBKSZWqRhLHCpNN7g86RqCIMsKoFeVjc402u8KcqhLK+FWkvJH4BXhtkn/jyHhqm/VmUNIqGXGwJtoMyEETw8WtAhPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IC2msdfc; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a814c54742so5805ab.1
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 10:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736274684; x=1736879484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IZmCERbL1GmUWWKlKf1Fkap/8PoZZun7MNTEJAlgeo=;
        b=IC2msdfc5JwiHzf4gLPt5YwIRwG0+OuCUUScOTaGsSL/fuDR1UIHr5BoSY3bGFwq+z
         06MIqSgFjImqhp4vPiDyX7Er6V4a7l7A2ruNvnIyocVpZxpQxJfPTbxSIYUuDSYpcu+s
         WS5mdAymUEBDDCLsa/FW1WrVBWZS1zpzgTXJDDMRyOgZ6O23Hglt9Wj0Dgt0VpN78mIZ
         zUHLE5dnGXq7f17zxpv8SKzttmaTsBqRCYjiEh7lqg3cbTUXXodYVVcg8sFrcCKiaehW
         /H3poZa4f8MXU2+/BycWFlzTUxWoYdfQFTSraI5n7Xj2dU7FaxU5ooibNlcHE1642mqw
         6Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736274684; x=1736879484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IZmCERbL1GmUWWKlKf1Fkap/8PoZZun7MNTEJAlgeo=;
        b=su1/e8tOL7lf/I7KEsC7M7b3o9xOmfdfwBuuU4GOmEX8pfqjW6WuIxvDdWpXeG0VoC
         83mTAaa2CYmsoywU07sqNEgTEzDGLiBPTGF0E3weS98b7FV0RhFYsp63lv3zTqvoSm7W
         7pypsIStdbP5JKtBx6S3vI2Hoy7OXHiQMAkcSr8aluf3GMV57nnVQJy6rSWwMtUc+sHa
         zsMgdQ0Mi8uS9qQvt/9Kyay/y3MwmoDmwzTWIK+vH6qKjr6km9wfWjrWrNlWvA9lh3FE
         3zmt/IGBnYxrIetarvKiSV0g27+qtqUaBAjwfvQcv9eSQSTcciIos1DNGETOauDYwRKZ
         cXgg==
X-Forwarded-Encrypted: i=1; AJvYcCW0qu6CyWfF/YeWQotzsTSFQ3bcwksemddP56yd0lszxwtXXYQSr9YAuLLMMPgSdkWjU0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWtN0aLRl6vJG6WBhgZK6ojBWpF7+79//vVzLnpS1rUaVLgSz
	/w0Mo3NOo38qiqM5EE4ZlXQwrGYXJCsHXOgad9N1aqvu+59YdHMvODy8ESpCyXddA+OtbwTBjca
	wziXg2yYFMoajm76XCGOwUib6AwOU4y90FEX+
X-Gm-Gg: ASbGncs6sVUKsEfeEGBkmxYdhBT989A0S5jNNf7TkYXEgN6FJwWJDhJpWJLzNJeijji
	Jmi5K8QqTvZfK3DbrGzOMByAh+X8XHfnsi4fN6SjkbcMzphiLjQcDcGjIfb+ymixsPENM4w==
X-Google-Smtp-Source: AGHT+IFiwBCBahYctnYPQwHDyNuIZfVMQsiJREPq2lfa8COIKpaXOGX2E3C3VA5MBqBoMjX19ZVHfFlfzZtB/ZEnCqw=
X-Received: by 2002:a05:6e02:1a66:b0:3a7:7d6e:fef9 with SMTP id
 e9e14a558f8ab-3ce333ace12mr3725625ab.27.1736274683382; Tue, 07 Jan 2025
 10:31:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com> <20241218-perf_syscalltbl-v4-16-bc8caef2ca8e@rivosinc.com>
In-Reply-To: <20241218-perf_syscalltbl-v4-16-bc8caef2ca8e@rivosinc.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 10:31:12 -0800
X-Gm-Features: AbW1kvaMbrvxjUhQ4wmMCxXieh5BF7iC3saitrnc0ieAcj07IJJzhm0SMZWJXgw
Message-ID: <CAP-5=fWbOrwt4b2Y79=iqRr5yRC7R6sgpkoQg6jBpGPW2dpPzA@mail.gmail.com>
Subject: Re: [PATCH v4 16/16] perf tools: Remove dependency on libaudit
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 1:25=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> All architectures now support HAVE_SYSCALL_TABLE_SUPPORT, so the flag is
> no longer needed. With the removal of the flag, the related
> GENERIC_SYSCALL_TABLE can also be removed. libaudit was only used as a
> fallback for when HAVE_SYSCALL_TABLE_SUPPORT was not defined, so
> libaudit is also no longer needed for any architecture.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  Documentation/admin-guide/workload-tracing.rst |  2 +-
>  tools/build/feature/Makefile                   |  4 --
>  tools/build/feature/test-libaudit.c            | 11 ------
>  tools/perf/Documentation/perf-check.txt        |  1 -
>  tools/perf/Makefile.config                     | 31 +--------------
>  tools/perf/Makefile.perf                       | 15 --------
>  tools/perf/builtin-check.c                     |  1 -
>  tools/perf/builtin-help.c                      |  2 -
>  tools/perf/builtin-trace.c                     | 30 ---------------
>  tools/perf/perf.c                              |  6 +--
>  tools/perf/tests/make                          |  7 +---
>  tools/perf/util/env.c                          |  4 +-
>  tools/perf/util/generate-cmdlist.sh            |  4 +-
>  tools/perf/util/syscalltbl.c                   | 52 --------------------=
------
>  tools/perf/util/syscalltbl.h                   |  1 -
>  15 files changed, 10 insertions(+), 161 deletions(-)
>
> diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentati=
on/admin-guide/workload-tracing.rst
> index b2e254ec8ee846afe78eede74a825b51c6ab119b..6be38c1b9c5bb4be899fd261c=
6d2911abcf959dc 100644
> --- a/Documentation/admin-guide/workload-tracing.rst
> +++ b/Documentation/admin-guide/workload-tracing.rst
> @@ -83,7 +83,7 @@ scripts/ver_linux is a good way to check if your system=
 already has
>  the necessary tools::
>
>    sudo apt-get build-essentials flex bison yacc
> -  sudo apt install libelf-dev systemtap-sdt-dev libaudit-dev libslang2-d=
ev libperl-dev libdw-dev
> +  sudo apt install libelf-dev systemtap-sdt-dev libslang2-dev libperl-de=
v libdw-dev
>
>  cscope is a good tool to browse kernel sources. Let's install it now::
>
> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
> index 680f9b07150f906c0bae1ab990cc01bb0d6b0de6..cb1e3e2feedf39d7b95442baf=
c87d43dc84a740d 100644
> --- a/tools/build/feature/Makefile
> +++ b/tools/build/feature/Makefile
> @@ -13,7 +13,6 @@ FILES=3D                                          \
>           test-gtk2.bin                          \
>           test-gtk2-infobar.bin                  \
>           test-hello.bin                         \
> -         test-libaudit.bin                      \
>           test-libbfd.bin                        \
>           test-libbfd-buildid.bin               \
>           test-disassembler-four-args.bin        \
> @@ -232,9 +231,6 @@ $(OUTPUT)test-libunwind-debug-frame-arm.bin:
>  $(OUTPUT)test-libunwind-debug-frame-aarch64.bin:
>         $(BUILD) -lelf -llzma -lunwind-aarch64
>
> -$(OUTPUT)test-libaudit.bin:
> -       $(BUILD) -laudit
> -
>  $(OUTPUT)test-libslang.bin:
>         $(BUILD) -lslang
>
> diff --git a/tools/build/feature/test-libaudit.c b/tools/build/feature/te=
st-libaudit.c
> deleted file mode 100644
> index f5b0863fa1ec240795339428d8deed98a946d405..0000000000000000000000000=
000000000000000
> --- a/tools/build/feature/test-libaudit.c
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -#include <libaudit.h>
> -
> -extern int printf(const char *format, ...);
> -
> -int main(void)
> -{
> -       printf("error message: %s\n", audit_errno_to_name(0));
> -
> -       return audit_open();
> -}
> diff --git a/tools/perf/Documentation/perf-check.txt b/tools/perf/Documen=
tation/perf-check.txt
> index 31741499e7867c9b712227f31a2958fd641d474a..e6d2ceeb2ca7de850f41b1baa=
0375b6f984bb08f 100644
> --- a/tools/perf/Documentation/perf-check.txt
> +++ b/tools/perf/Documentation/perf-check.txt
> @@ -51,7 +51,6 @@ feature::
>                  dwarf_getlocations      /  HAVE_LIBDW_SUPPORT
>                  dwarf-unwind            /  HAVE_DWARF_UNWIND_SUPPORT
>                  auxtrace                /  HAVE_AUXTRACE_SUPPORT
> -                libaudit                /  HAVE_LIBAUDIT_SUPPORT
>                  libbfd                  /  HAVE_LIBBFD_SUPPORT
>                  libcapstone             /  HAVE_LIBCAPSTONE_SUPPORT
>                  libcrypto               /  HAVE_LIBCRYPTO_SUPPORT
> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> index 2da9fd705f187a8e4881b3b6ebbe5e0ec8584474..878e4cec8fdefaf6a7ae3c964=
d9c62ebd8d1d149 100644
> --- a/tools/perf/Makefile.config
> +++ b/tools/perf/Makefile.config
> @@ -28,20 +28,7 @@ include $(srctree)/tools/scripts/Makefile.arch
>
>  $(call detected_var,SRCARCH)
>
> -ifneq ($(NO_SYSCALL_TABLE),1)
> -  NO_SYSCALL_TABLE :=3D 1
> -
> -  # architectures that use the generic syscall table scripts
> -  ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
> -    NO_SYSCALL_TABLE :=3D 0
> -    CFLAGS +=3D -DGENERIC_SYSCALL_TABLE
> -    CFLAGS +=3D -I$(OUTPUT)tools/perf/arch/$(SRCARCH)/include/generated
> -  endif
> -
> -  ifneq ($(NO_SYSCALL_TABLE),1)
> -    CFLAGS +=3D -DHAVE_SYSCALL_TABLE_SUPPORT
> -  endif
> -endif
> +CFLAGS +=3D -I$(OUTPUT)tools/perf/arch/$(SRCARCH)/include/generated
>
>  # Additional ARCH settings for ppc
>  ifeq ($(SRCARCH),powerpc)
> @@ -776,21 +763,7 @@ ifndef NO_LIBUNWIND
>  endif
>
>  ifneq ($(NO_LIBTRACEEVENT),1)
> -  ifeq ($(NO_SYSCALL_TABLE),0)
> -    $(call detected,CONFIG_TRACE)
> -  else
> -    ifndef NO_LIBAUDIT
> -      $(call feature_check,libaudit)
> -      ifneq ($(feature-libaudit), 1)
> -        $(warning No libaudit.h found, disables 'trace' tool, please ins=
tall audit-libs-devel or libaudit-dev)
> -        NO_LIBAUDIT :=3D 1
> -      else
> -        CFLAGS +=3D -DHAVE_LIBAUDIT_SUPPORT
> -        EXTLIBS +=3D -laudit
> -        $(call detected,CONFIG_TRACE)
> -      endif
> -    endif
> -  endif
> +  $(call detected,CONFIG_TRACE)
>  endif
>
>  ifndef NO_LIBCRYPTO
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 2c6a509c800d3037933c9b49e5a7dafbf78fda0c..ab2d075ff3a23350a5eea1250=
8cf0376f1d9f4e8 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -59,8 +59,6 @@ include ../scripts/utilities.mak
>  #
>  # Define NO_LIBNUMA if you do not want numa perf benchmark
>  #
> -# Define NO_LIBAUDIT if you do not want libaudit support
> -#
>  # Define NO_LIBBIONIC if you do not want bionic support
>  #
>  # Define NO_LIBCRYPTO if you do not want libcrypto (openssl) support
> @@ -119,10 +117,6 @@ include ../scripts/utilities.mak
>  #
>  # Define LIBBPF_DYNAMIC to enable libbpf dynamic linking.
>  #
> -# Define NO_SYSCALL_TABLE=3D1 to disable the use of syscall id to/from n=
ame tables
> -# generated from the kernel .tbl or unistd.h files and use, if available=
, libaudit
> -# for doing the conversions to/from strings/id.
> -#
>  # Define NO_LIBPFM4 to disable libpfm4 events extension.
>  #
>  # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
> @@ -310,11 +304,7 @@ ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature=
-dump)
>  FEATURE_TESTS :=3D all
>  endif
>  endif
> -# architectures that use the generic syscall table
> -generic_syscall_table_archs :=3D riscv arc csky arm sh sparc xtensa x86 =
alpha parisc arm64 loongarch mips powerpc s390
> -ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
>  include $(srctree)/tools/perf/scripts/Makefile.syscalls
> -endif
>  include Makefile.config
>  endif
>
> @@ -1099,11 +1089,6 @@ endif
>                 $(INSTALL) $(OUTPUT)perf-archive -t '$(DESTDIR_SQ)$(perfe=
xec_instdir_SQ)'
>         $(call QUIET_INSTALL, perf-iostat) \
>                 $(INSTALL) $(OUTPUT)perf-iostat -t '$(DESTDIR_SQ)$(perfex=
ec_instdir_SQ)'
> -ifndef NO_LIBAUDIT
> -       $(call QUIET_INSTALL, strace/groups) \
> -               $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(STRACE_GROUPS_INSTDI=
R_SQ)'; \
> -               $(INSTALL) trace/strace/groups/* -m 644 -t '$(DESTDIR_SQ)=
$(STRACE_GROUPS_INSTDIR_SQ)'
> -endif
>  ifndef NO_LIBPERL
>         $(call QUIET_INSTALL, perl-scripts) \
>                 $(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)=
/scripts/perl/Perf-Trace-Util/lib/Perf/Trace'; \
> diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
> index 2346536a5ee14f91ecd10bd130a64676e871e1b2..7aed7b9f4f5270527ee1d3632=
7eb6a01f196a46a 100644
> --- a/tools/perf/builtin-check.c
> +++ b/tools/perf/builtin-check.c
> @@ -31,7 +31,6 @@ struct feature_status supported_features[] =3D {
>         FEATURE_STATUS("dwarf_getlocations", HAVE_LIBDW_SUPPORT),
>         FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),
>         FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
> -       FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
>         FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
>         FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),
>         FEATURE_STATUS("libcrypto", HAVE_LIBCRYPTO_SUPPORT),
> diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
> index 0854d3cd9f6a304cd9cb50ad430d5706d91df0e9..7be6fb6df595923c15ae51747=
d5bf17d867ae785 100644
> --- a/tools/perf/builtin-help.c
> +++ b/tools/perf/builtin-help.c
> @@ -447,9 +447,7 @@ int cmd_help(int argc, const char **argv)
>  #ifdef HAVE_LIBELF_SUPPORT
>                 "probe",
>  #endif
> -#if defined(HAVE_LIBAUDIT_SUPPORT) || defined(HAVE_SYSCALL_TABLE_SUPPORT=
)
>                 "trace",
> -#endif
>         NULL };
>         const char *builtin_help_usage[] =3D {
>                 "perf help [--all] [--man|--web|--info] [command]",
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 3c46de1a8d79bfe64ad6661929f2bdc98ebba55e..80941db5bd48f11236c759bab=
cc1c545149c8e3f 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -2074,30 +2074,11 @@ static int trace__read_syscall_info(struct trace =
*trace, int id)
>         const char *name =3D syscalltbl__name(trace->sctbl, id);
>         int err;
>
> -#ifdef HAVE_SYSCALL_TABLE_SUPPORT
>         if (trace->syscalls.table =3D=3D NULL) {
>                 trace->syscalls.table =3D calloc(trace->sctbl->syscalls.m=
ax_id + 1, sizeof(*sc));
>                 if (trace->syscalls.table =3D=3D NULL)
>                         return -ENOMEM;
>         }
> -#else
> -       if (id > trace->sctbl->syscalls.max_id || (id =3D=3D 0 && trace->=
syscalls.table =3D=3D NULL)) {
> -               // When using libaudit we don't know beforehand what is t=
he max syscall id
> -               struct syscall *table =3D realloc(trace->syscalls.table, =
(id + 1) * sizeof(*sc));
> -
> -               if (table =3D=3D NULL)
> -                       return -ENOMEM;
> -
> -               // Need to memset from offset 0 and +1 members if brand n=
ew
> -               if (trace->syscalls.table =3D=3D NULL)
> -                       memset(table, 0, (id + 1) * sizeof(*sc));
> -               else
> -                       memset(table + trace->sctbl->syscalls.max_id + 1,=
 0, (id - trace->sctbl->syscalls.max_id) * sizeof(*sc));
> -
> -               trace->syscalls.table         =3D table;
> -               trace->sctbl->syscalls.max_id =3D id;
> -       }
> -#endif
>         sc =3D trace->syscalls.table + id;
>         if (sc->nonexistent)
>                 return -EEXIST;
> @@ -2448,18 +2429,7 @@ static struct syscall *trace__syscall_info(struct =
trace *trace,
>
>         err =3D -EINVAL;
>
> -#ifdef HAVE_SYSCALL_TABLE_SUPPORT
>         if (id > trace->sctbl->syscalls.max_id) {
> -#else
> -       if (id >=3D trace->sctbl->syscalls.max_id) {
> -               /*
> -                * With libaudit we don't know beforehand what is the max=
_id,
> -                * so we let trace__read_syscall_info() figure that out a=
s we
> -                * go on reading syscalls.
> -                */
> -               err =3D trace__read_syscall_info(trace, id);
> -               if (err)
> -#endif
>                 goto out_cant_read;
>         }
>
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index a2987f2cfe1a3958f53239ed1a4eec3f87d7466a..f0617cc41f5fe638986e5d831=
6a6b3056c2c4bc5 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -84,7 +84,7 @@ static struct cmd_struct commands[] =3D {
>  #endif
>         { "kvm",        cmd_kvm,        0 },
>         { "test",       cmd_test,       0 },
> -#if defined(HAVE_LIBTRACEEVENT) && (defined(HAVE_LIBAUDIT_SUPPORT) || de=
fined(HAVE_SYSCALL_TABLE_SUPPORT))
> +#if defined(HAVE_LIBTRACEEVENT)
>         { "trace",      cmd_trace,      0 },
>  #endif
>         { "inject",     cmd_inject,     0 },
> @@ -514,10 +514,6 @@ int main(int argc, const char **argv)
>                 fprintf(stderr,
>                         "trace command not available: missing libtraceeve=
nt devel package at build time.\n");
>                 goto out;
> -#elif !defined(HAVE_LIBAUDIT_SUPPORT) && !defined(HAVE_SYSCALL_TABLE_SUP=
PORT)
> -               fprintf(stderr,
> -                       "trace command not available: missing audit-libs =
devel package at build time.\n");
> -               goto out;
>  #else
>                 setup_path();
>                 argv[0] =3D "trace";
> diff --git a/tools/perf/tests/make b/tools/perf/tests/make
> index a7fcbd589752a90459815bd21075528c6dfa4d94..0ee94caf9ec19820a94a87dd4=
6a7ccf1cefb844a 100644
> --- a/tools/perf/tests/make
> +++ b/tools/perf/tests/make
> @@ -86,7 +86,6 @@ make_no_libdw_dwarf_unwind :=3D NO_LIBDW_DWARF_UNWIND=
=3D1
>  make_no_backtrace   :=3D NO_BACKTRACE=3D1
>  make_no_libcapstone :=3D NO_CAPSTONE=3D1
>  make_no_libnuma     :=3D NO_LIBNUMA=3D1
> -make_no_libaudit    :=3D NO_LIBAUDIT=3D1
>  make_no_libbionic   :=3D NO_LIBBIONIC=3D1
>  make_no_auxtrace    :=3D NO_AUXTRACE=3D1
>  make_no_libbpf     :=3D NO_LIBBPF=3D1
> @@ -97,7 +96,6 @@ make_no_libllvm     :=3D NO_LIBLLVM=3D1
>  make_with_babeltrace:=3D LIBBABELTRACE=3D1
>  make_with_coresight :=3D CORESIGHT=3D1
>  make_no_sdt        :=3D NO_SDT=3D1
> -make_no_syscall_tbl :=3D NO_SYSCALL_TABLE=3D1
>  make_no_libpfm4     :=3D NO_LIBPFM4=3D1
>  make_with_gtk2      :=3D GTK2=3D1
>  make_refcnt_check   :=3D EXTRA_CFLAGS=3D"-DREFCNT_CHECKING=3D1"
> @@ -122,10 +120,10 @@ make_static         :=3D LDFLAGS=3D-static NO_PERF_=
READ_VDSO32=3D1 NO_PERF_READ_VDSOX3
>  # all the NO_* variable combined
>  make_minimal        :=3D NO_LIBPERL=3D1 NO_LIBPYTHON=3D1 NO_GTK2=3D1
>  make_minimal        +=3D NO_DEMANGLE=3D1 NO_LIBELF=3D1 NO_BACKTRACE=3D1
> -make_minimal        +=3D NO_LIBNUMA=3D1 NO_LIBAUDIT=3D1 NO_LIBBIONIC=3D1
> +make_minimal        +=3D NO_LIBNUMA=3D1 NO_LIBBIONIC=3D1
>  make_minimal        +=3D NO_LIBDW_DWARF_UNWIND=3D1 NO_AUXTRACE=3D1 NO_LI=
BBPF=3D1
>  make_minimal        +=3D NO_LIBCRYPTO=3D1 NO_SDT=3D1 NO_JVMTI=3D1 NO_LIB=
ZSTD=3D1
> -make_minimal        +=3D NO_LIBCAP=3D1 NO_SYSCALL_TABLE=3D1 NO_CAPSTONE=
=3D1
> +make_minimal        +=3D NO_LIBCAP=3D1 NO_CAPSTONE=3D1
>
>  # $(run) contains all available tests
>  run :=3D make_pure
> @@ -158,7 +156,6 @@ run +=3D make_no_libdw_dwarf_unwind
>  run +=3D make_no_backtrace
>  run +=3D make_no_libcapstone
>  run +=3D make_no_libnuma
> -run +=3D make_no_libaudit
>  run +=3D make_no_libbionic
>  run +=3D make_no_auxtrace
>  run +=3D make_no_libbpf
> diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> index 919fe6f205937cea11318fbf53f592aab7578040..be3081ff6204aa80f2855f5e4=
184e66412627ad3 100644
> --- a/tools/perf/util/env.c
> +++ b/tools/perf/util/env.c

I think this is missing:
```
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index b917bc18e9fe..cae4f6d63318 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -480,7 +480,7 @@ const char *perf_env__arch(struct perf_env *env)
        return normalize_arch(arch_name);
 }

-#if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
+#if defined(HAVE_LIBTRACEEVENT)
 #include "trace/beauty/arch_errno_names.c"
 #endif
```
as otherwise arch_syscalls__strerrno_function won't be defined below.

Thanks,
Ian

> @@ -482,13 +482,13 @@ const char *perf_env__arch(struct perf_env *env)
>
>  const char *perf_env__arch_strerrno(struct perf_env *env __maybe_unused,=
 int err __maybe_unused)
>  {
> -#if defined(HAVE_SYSCALL_TABLE_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
> +#if defined(HAVE_LIBTRACEEVENT)
>         if (env->arch_strerrno =3D=3D NULL)
>                 env->arch_strerrno =3D arch_syscalls__strerrno_function(p=
erf_env__arch(env));
>
>         return env->arch_strerrno ? env->arch_strerrno(err) : "no arch sp=
ecific strerrno function";
>  #else
> -       return "!(HAVE_SYSCALL_TABLE_SUPPORT && HAVE_LIBTRACEEVENT)";
> +       return "!HAVE_LIBTRACEEVENT";
>  #endif
>  }
>
> diff --git a/tools/perf/util/generate-cmdlist.sh b/tools/perf/util/genera=
te-cmdlist.sh
> index 1b5140e5ce9975fac87b2674dc694f9d4e439a5f..6a73c903d69050df69267a8ae=
aeeac1ed170efe1 100755
> --- a/tools/perf/util/generate-cmdlist.sh
> +++ b/tools/perf/util/generate-cmdlist.sh
> @@ -38,7 +38,7 @@ do
>  done
>  echo "#endif /* HAVE_LIBELF_SUPPORT */"
>
> -echo "#if defined(HAVE_LIBTRACEEVENT) && (defined(HAVE_LIBAUDIT_SUPPORT)=
 || defined(HAVE_SYSCALL_TABLE_SUPPORT))"
> +echo "#if defined(HAVE_LIBTRACEEVENT)"
>  sed -n -e 's/^perf-\([^        ]*\)[   ].* audit*/\1/p' command-list.txt=
 |
>  sort |
>  while read cmd
> @@ -51,7 +51,7 @@ do
>             p
>       }' "Documentation/perf-$cmd.txt"
>  done
> -echo "#endif /* HAVE_LIBTRACEEVENT && (HAVE_LIBAUDIT_SUPPORT || HAVE_SYS=
CALL_TABLE_SUPPORT) */"
> +echo "#endif /* HAVE_LIBTRACEEVENT */"
>
>  echo "#ifdef HAVE_LIBTRACEEVENT"
>  sed -n -e 's/^perf-\([^        ]*\)[   ].* traceevent.*/\1/p' command-li=
st.txt |
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 210f61b0a7a264a427ebb602185d3a9da2f426f4..928aca4cd6e9f2f26c5c4fd82=
5b4538c064a4cc3 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -10,20 +10,12 @@
>  #include <linux/compiler.h>
>  #include <linux/zalloc.h>
>
> -#ifdef HAVE_SYSCALL_TABLE_SUPPORT
>  #include <string.h>
>  #include "string2.h"
>
> -#if defined(GENERIC_SYSCALL_TABLE)
>  #include <syscall_table.h>
>  const int syscalltbl_native_max_id =3D SYSCALLTBL_MAX_ID;
>  static const char *const *syscalltbl_native =3D syscalltbl;
> -#else
> -const int syscalltbl_native_max_id =3D 0;
> -static const char *const syscalltbl_native[] =3D {
> -       [0] =3D "unknown",
> -};
> -#endif
>
>  struct syscall {
>         int id;
> @@ -131,47 +123,3 @@ int syscalltbl__strglobmatch_first(struct syscalltbl=
 *tbl, const char *syscall_g
>         *idx =3D -1;
>         return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
>  }
> -
> -#else /* HAVE_SYSCALL_TABLE_SUPPORT */
> -
> -#include <libaudit.h>
> -
> -struct syscalltbl *syscalltbl__new(void)
> -{
> -       struct syscalltbl *tbl =3D zalloc(sizeof(*tbl));
> -       if (tbl)
> -               tbl->audit_machine =3D audit_detect_machine();
> -       return tbl;
> -}
> -
> -void syscalltbl__delete(struct syscalltbl *tbl)
> -{
> -       free(tbl);
> -}
> -
> -const char *syscalltbl__name(const struct syscalltbl *tbl, int id)
> -{
> -       return audit_syscall_to_name(id, tbl->audit_machine);
> -}
> -
> -int syscalltbl__id(struct syscalltbl *tbl, const char *name)
> -{
> -       return audit_name_to_syscall(name, tbl->audit_machine);
> -}
> -
> -int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx=
)
> -{
> -       return idx;
> -}
> -
> -int syscalltbl__strglobmatch_next(struct syscalltbl *tbl __maybe_unused,
> -                                 const char *syscall_glob __maybe_unused=
, int *idx __maybe_unused)
> -{
> -       return -1;
> -}
> -
> -int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *s=
yscall_glob, int *idx)
> -{
> -       return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
> -}
> -#endif /* HAVE_SYSCALL_TABLE_SUPPORT */
> diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
> index 2b53b7ed25a6affefd3d85012198eab2f2af550c..362411a6d849b1f67ec54b343=
45364c04ad90f89 100644
> --- a/tools/perf/util/syscalltbl.h
> +++ b/tools/perf/util/syscalltbl.h
> @@ -3,7 +3,6 @@
>  #define __PERF_SYSCALLTBL_H
>
>  struct syscalltbl {
> -       int audit_machine;
>         struct {
>                 int max_id;
>                 int nr_entries;
>
> --
> 2.34.1
>

