Return-Path: <bpf+bounces-48273-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E51A063D8
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 18:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39A777A238C
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F18620100E;
	Wed,  8 Jan 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9bHZMjV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4196197558;
	Wed,  8 Jan 2025 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736359069; cv=none; b=pnOfxWjyLmE6oycw7hqO+LjzC/rXfRUXL19R8JHtyK/lvyBOewJcIUbuseoI5AvWHZ+9G3gjsClTKpCOTemAZ9LHQth3IjlRqxG3h8ZmptWc/lnW2K1x/yKnVc/JdaF6g+QNU390AcEFHT11ZFV/08UDmzijkBsSGQmuCO7lzek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736359069; c=relaxed/simple;
	bh=P+YhiCnx0Fp70+mXuaY1U/h12ess8tXc7AGuGDtQ7hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcS6x12DWVCD+hhZH8SlThom4/NMA4HrF+/VF3JncFeENx3iDrmGED1HegzE4lms69ZCWpSb0umfLvpwGnuOqE3Ah8vUeTO1KcjGwy9pzeBRD02okpa07k1731llfjKGYOMEh+PWRm/uaAN3BGNA+F83xTrx8kSEAo0bhDdYii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9bHZMjV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DF0C4CED3;
	Wed,  8 Jan 2025 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736359068;
	bh=P+YhiCnx0Fp70+mXuaY1U/h12ess8tXc7AGuGDtQ7hE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d9bHZMjVCr+k/1eiOgqOrnlMilnmf/PXn6MNsroSTQ86uPz253XnM3tlOK3DtplsG
	 0XzccyhCmfJyjVX8/HuHpiFtZZbSlqdCqTBgfzfkp9L3DW1iQxOm9MwPUQnC0HSi+M
	 kT0lzW6YJddSjJ/DdsMZY+m/DIUuva+aEkplaCROg0DIrlu0SybzpfXFJ83pdVVJWl
	 YFLJeyz/pkr9PFbVPlC6U5ClFFhSVKUL9A8AcKtbLDvJwBUAOY6mDQMzLu/mvmVWet
	 jmUvtdCe+5JWXlgxNslVO2K8Uxq3tR4fV/ruEfWCamnpzYFN8Y0f3iDbkdx3IZeg4q
	 4CMidtmZGGL+w==
Date: Wed, 8 Jan 2025 09:57:44 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
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
Subject: Re: [PATCH v5 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z368mNynBTDWPM6R@google.com>
References: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>

Hello,

On Tue, Jan 07, 2025 at 06:07:48PM -0800, Charlie Jenkins wrote:
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

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
> ---
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
>  86 files changed, 4103 insertions(+), 623 deletions(-)
> ---
> base-commit: 034b5b147bf7f44a45e39334725f8633b7ca8c3b
> change-id: 20240913-perf_syscalltbl-6f98defcc6f5
> -- 
> - Charlie
> 

