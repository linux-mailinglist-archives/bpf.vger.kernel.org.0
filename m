Return-Path: <bpf+bounces-48411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78838A07CB3
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028BD3A66FE
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1922206B2;
	Thu,  9 Jan 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAB3w0b8"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7D220682;
	Thu,  9 Jan 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438387; cv=none; b=An9KL5qLxjur7xHj2H2J+MV015uV3riaGVyzR85bxVoXRGsSGatqKOYuUjWwvJpCvlE4T/iT3SEgXz/F0iI9C0HvNOMY02weOvUJUGq+B9rJU7WUxmRHnLYbk+sA+kDYWfDxElSZPsdl52U4gdnHVEQrSh+E7kmlQW14agneeOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438387; c=relaxed/simple;
	bh=HJNa3WcTNFbhoVvvgXMaWosm1o6DRCZTJsqCSgafKU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8vn6tC8zpBmGKgOWMK1a9EoN25dgNV2S3ilu0/Ww+rPH1UxWJv0oqmwio72Xh5gGIMFJsdkiWdtL5DpRxZxtZoa3z5DCK5OXiRRmi9kOkd4eMARthB9ObIVNa7ZNNbQ8MMfjjjx2Tt6vW3NXJzHXrn7NmszkrZ6LS7N2pspeFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAB3w0b8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264CEC4CED2;
	Thu,  9 Jan 2025 15:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736438386;
	bh=HJNa3WcTNFbhoVvvgXMaWosm1o6DRCZTJsqCSgafKU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sAB3w0b8D2GVwS6bbYtXpoy8Tf/Ij5hYbvpU0rg+R//fOC9OlQAS0hZ5Z6oSHl02k
	 7lPrpEZtWG3iAKwxy5/lESSadrrukjPAx5UNk4W0rrN/Jk+n04mbzxQ8xAIbjbCCpY
	 3nHZt7y2IxHyid30emj00qXTlvyO8QoeVlxiNfaaNkColQ8wJYN38+zh0TNbt9hkOf
	 mKtAnU/78noQ0MogoBPHUx3l4Gj+5NRk2ofVZqym06vIvZuEpbuyWwGxCMrr3iW6Ko
	 9HZ3VijUfmLVlVoXUs3f0LONdMaP3EYMdpQPMxLpIIqvHZs2lEQkPHkIXy0gsGrt8H
	 Vid8J90fHw2Ng==
Date: Thu, 9 Jan 2025 12:59:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z3_ybwWW3QZvJ4V6@x1>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>

On Wed, Jan 08, 2025 at 06:36:15PM -0800, Charlie Jenkins wrote:
> Standardize the generation of syscall headers around syscall tables.
> Previously each architecture independently selected how syscall headers
> would be generated, or would not define a way and fallback onto
> libaudit. Convert all architectures to use a standard syscall header
> generation script and allow each architecture to override the syscall
> table to use if they do not use the generic table.
> 
> As a result of these changes, no architecture will require libaudit, and
> so the fallback case of using libaudit is removed by this series.
> 
> Testing:
> 
> I have tested that the syscall mappings of id to name generation works
> as expected for every architecture, but I have only validated that perf
> trace compiles and runs as expected on riscv, arm64, and x86_64.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Ian Rogers <irogers@google.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> ---
> Changes in v6:
> - Use tools/build/Build.include instead of scripts/Kbuild.include
> - Link to v5: https://lore.kernel.org/r/20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com

Passed these, so far, more tests underway:

⬢ [acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
d06826160a982494 (HEAD -> perf-tools-next) perf tools: Remove dependency on libaudit
make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
- tarpkg: ./tests/perf-targz-src-pkg .
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28  DESTDIR=/tmp/tmp.JJT3tvN7bV
              make_with_gtk2: cd . && make GTK2=1 -j28  DESTDIR=/tmp/tmp.BF53V2qpl3
- /home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
         make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.KZuQ0q2Vs6 DESTDIR=/tmp/tmp.0sxMyH91gS
           make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.Y0Mx3KLREI DESTDIR=/tmp/tmp.wg9HCVVLHE
              make_install_O: cd . && make install FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.P0LEBAkW1X DESTDIR=/tmp/tmp.agTavZndFN
  failed to find: etc/bash_completion.d/perf
         make_no_libpython_O: cd . && make NO_LIBPYTHON=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.AQ4uSxhHzq DESTDIR=/tmp/tmp.SyRIMEwTpJ
         make_refcnt_check_O: cd . && make EXTRA_CFLAGS=-DREFCNT_CHECKING=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.boLQpo3gGR DESTDIR=/tmp/tmp.pvNzMWlMJP
 
> Changes in v5:
> - Remove references to HAVE_SYSCALL_TABLE_SUPPORT that were
>   missed/recently introduced
> - Rebase on perf-tools-next
> - Install headers to $(OUTPUT)arch instead of $(OUTPUT)tools/perf/arch
> - Link to v4: https://lore.kernel.org/r/20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com
> 
> Changes in v4:
> - Remove audit_machine member of syscalltbl struct (Ian)
> - Rebase on perf-tools-next
> - Link to v3: https://lore.kernel.org/r/20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com
> 
> Changes in v3:
> - Fix compiliation when OUTPUT is empty
> - Correct unused headers to be .h instead of .c  (Namhyung)
> - Make variable definition of supported archs (Namhyung)
> - Convert += into := for syscalls headers (Namhyung)
> - Link to v2: https://lore.kernel.org/r/20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com
> 
> Changes in v2:
> - Rebase onto 6.13-rc2
> - Fix output path so it generates to /tools/perf/arch properly
> - Link to v1: https://lore.kernel.org/r/20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com
> 
> ---
> Charlie Jenkins (16):
>       perf tools: Create generic syscall table support
>       perf tools: arc: Support generic syscall headers
>       perf tools: csky: Support generic syscall headers
>       perf tools: arm: Support syscall headers
>       perf tools: sh: Support syscall headers
>       perf tools: sparc: Support syscall headers
>       perf tools: xtensa: Support syscall header
>       perf tools: x86: Use generic syscall scripts
>       perf tools: alpha: Support syscall header
>       perf tools: parisc: Support syscall header
>       perf tools: arm64: Use syscall table
>       perf tools: loongarch: Use syscall table
>       perf tools: mips: Use generic syscall scripts
>       perf tools: powerpc: Use generic syscall table scripts
>       perf tools: s390: Use generic syscall table scripts
>       perf tools: Remove dependency on libaudit
> 
>  Documentation/admin-guide/workload-tracing.rst     |   2 +-
>  tools/build/Build.include                          |   2 +
>  tools/build/feature/Makefile                       |   4 -
>  tools/build/feature/test-libaudit.c                |  11 -
>  tools/perf/Documentation/perf-check.txt            |   2 -
>  tools/perf/Makefile.config                         |  39 +-
>  tools/perf/Makefile.perf                           |  12 +-
>  tools/perf/arch/alpha/entry/syscalls/Kbuild        |   2 +
>  .../arch/alpha/entry/syscalls/Makefile.syscalls    |   5 +
>  tools/perf/arch/alpha/entry/syscalls/syscall.tbl   | 504 ++++++++++++++++++++
>  tools/perf/arch/alpha/include/syscall_table.h      |   2 +
>  tools/perf/arch/arc/entry/syscalls/Kbuild          |   2 +
>  .../perf/arch/arc/entry/syscalls/Makefile.syscalls |   3 +
>  tools/perf/arch/arc/include/syscall_table.h        |   2 +
>  tools/perf/arch/arm/entry/syscalls/Kbuild          |   4 +
>  .../perf/arch/arm/entry/syscalls/Makefile.syscalls |   2 +
>  tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 483 +++++++++++++++++++
>  tools/perf/arch/arm/include/syscall_table.h        |   2 +
>  tools/perf/arch/arm64/Makefile                     |  22 -
>  tools/perf/arch/arm64/entry/syscalls/Kbuild        |   3 +
>  .../arch/arm64/entry/syscalls/Makefile.syscalls    |   6 +
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  46 --
>  .../perf/arch/arm64/entry/syscalls/syscall_32.tbl  | 476 +++++++++++++++++++
>  .../perf/arch/arm64/entry/syscalls/syscall_64.tbl  |   1 +
>  tools/perf/arch/arm64/include/syscall_table.h      |   8 +
>  tools/perf/arch/csky/entry/syscalls/Kbuild         |   2 +
>  .../arch/csky/entry/syscalls/Makefile.syscalls     |   3 +
>  tools/perf/arch/csky/include/syscall_table.h       |   2 +
>  tools/perf/arch/loongarch/Makefile                 |  22 -
>  tools/perf/arch/loongarch/entry/syscalls/Kbuild    |   2 +
>  .../loongarch/entry/syscalls/Makefile.syscalls     |   3 +
>  .../arch/loongarch/entry/syscalls/mksyscalltbl     |  45 --
>  tools/perf/arch/loongarch/include/syscall_table.h  |   2 +
>  tools/perf/arch/mips/entry/syscalls/Kbuild         |   2 +
>  .../arch/mips/entry/syscalls/Makefile.syscalls     |   5 +
>  tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 --
>  tools/perf/arch/mips/include/syscall_table.h       |   2 +
>  tools/perf/arch/parisc/entry/syscalls/Kbuild       |   3 +
>  .../arch/parisc/entry/syscalls/Makefile.syscalls   |   6 +
>  tools/perf/arch/parisc/entry/syscalls/syscall.tbl  | 463 +++++++++++++++++++
>  tools/perf/arch/parisc/include/syscall_table.h     |   8 +
>  tools/perf/arch/powerpc/Makefile                   |  25 -
>  tools/perf/arch/powerpc/entry/syscalls/Kbuild      |   3 +
>  .../arch/powerpc/entry/syscalls/Makefile.syscalls  |   6 +
>  .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  39 --
>  tools/perf/arch/powerpc/include/syscall_table.h    |   8 +
>  tools/perf/arch/riscv/Makefile                     |  22 -
>  tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
>  .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
>  tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 --
>  tools/perf/arch/riscv/include/syscall_table.h      |   8 +
>  tools/perf/arch/s390/Makefile                      |  21 -
>  tools/perf/arch/s390/entry/syscalls/Kbuild         |   2 +
>  .../arch/s390/entry/syscalls/Makefile.syscalls     |   5 +
>  tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  32 --
>  tools/perf/arch/s390/include/syscall_table.h       |   2 +
>  tools/perf/arch/sh/entry/syscalls/Kbuild           |   2 +
>  .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |   4 +
>  tools/perf/arch/sh/entry/syscalls/syscall.tbl      | 472 +++++++++++++++++++
>  tools/perf/arch/sh/include/syscall_table.h         |   2 +
>  tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
>  .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
>  tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 514 +++++++++++++++++++++
>  tools/perf/arch/sparc/include/syscall_table.h      |   8 +
>  tools/perf/arch/x86/Build                          |   1 -
>  tools/perf/arch/x86/Makefile                       |  25 -
>  tools/perf/arch/x86/entry/syscalls/Kbuild          |   3 +
>  .../perf/arch/x86/entry/syscalls/Makefile.syscalls |   6 +
>  tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  42 --
>  tools/perf/arch/x86/include/syscall_table.h        |   8 +
>  tools/perf/arch/xtensa/entry/syscalls/Kbuild       |   2 +
>  .../arch/xtensa/entry/syscalls/Makefile.syscalls   |   4 +
>  tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  | 439 ++++++++++++++++++
>  tools/perf/arch/xtensa/include/syscall_table.h     |   2 +
>  tools/perf/builtin-check.c                         |   2 -
>  tools/perf/builtin-help.c                          |   2 -
>  tools/perf/builtin-trace.c                         |  30 --
>  tools/perf/check-headers.sh                        |   9 +
>  tools/perf/perf.c                                  |   6 +-
>  tools/perf/scripts/Makefile.syscalls               |  61 +++
>  tools/perf/scripts/syscalltbl.sh                   |  86 ++++
>  tools/perf/tests/make                              |   7 +-
>  tools/perf/util/env.c                              |   6 +-
>  tools/perf/util/generate-cmdlist.sh                |   4 +-
>  tools/perf/util/syscalltbl.c                       |  90 +---
>  tools/perf/util/syscalltbl.h                       |   1 -
>  tools/scripts/syscall.tbl                          | 409 ++++++++++++++++
>  87 files changed, 4105 insertions(+), 623 deletions(-)
> ---
> base-commit: 034b5b147bf7f44a45e39334725f8633b7ca8c3b
> change-id: 20240913-perf_syscalltbl-6f98defcc6f5
> -- 
> - Charlie

