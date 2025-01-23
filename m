Return-Path: <bpf+bounces-49615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CD3A1AC3F
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 23:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E1B3AE73C
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C321CC8A7;
	Thu, 23 Jan 2025 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrPhXtFT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97F81CAA9F;
	Thu, 23 Jan 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669595; cv=none; b=sVIXR+ZtEA/x+B9xRoBN2FrB0/hqYxugiQmNaS3cHScsvbatgFuyss517Y7lIufRKMfZv59SO71KyO3yWtDVswZsy7P9NmNpeesNIIIqtqGzodnQRfKfSrnPThwsIsdHQXjtl872rLQ7qAt+iyaDrZqnVfXp5j6nBC/9KfcdLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669595; c=relaxed/simple;
	bh=7HfuRwOci0npR8VvcikkAMI6UruTBlIu1KOOQZMuSAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdJUjnULLwABC+Mk4+7iPM2tvpoMoRyoyOk6F0PO5MHJRFK2FCwQ0M5/jMXzuJQAHLjlzu7aaLcHOpQ77scnC2HbICdW6yUcvwRoJWwzrP5IEz6W+0p8SyveGJ7fQLZA8uJ5DySSRP4SkDPBmutYShRED7c0RvMZjftxxHmoy/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrPhXtFT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E6DC4CED3;
	Thu, 23 Jan 2025 21:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737669594;
	bh=7HfuRwOci0npR8VvcikkAMI6UruTBlIu1KOOQZMuSAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrPhXtFTCTibMceFtt6oNsiO4GBSbQiM7yKFnFq5ZUJlH9iz21CTZomhG/++Rb4K8
	 tcjJn0XYe2ZnAjmH2wZi6ovFZTXKP2ttSFtHCmrsTzmpDJ0RlW6aMrXOrTGXMNwc68
	 xm2/CSbVx/WrIGLhI/NB4ZKxzrel93tWpdC2s3cRlDhMuztJyY2Hd38BThEDJ0qqur
	 033khf43sW9fuD7u0ZqJTD8TT+SEZm3+OeQEYrEBV51povVplBSq0ORKz24/3y731/
	 bixl2EO+tIT+YqqNVXLoM2n0D1wXOmtebOUmmftOqvcUhzX6Q+MkCA/0UQHM0a8b6u
	 wnzSquZhzLidQ==
Date: Thu, 23 Jan 2025 13:59:51 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Aditya Gupta <adityag@linux.ibm.com>,
	"Steinar H. Gunderson" <sesse@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Changbin Du <changbin.du@huawei.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Li Huafei <lihuafei1@huawei.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev, Song Liu <song@kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 00/17] Support dynamic opening of capstone/llvm remove
 BUILD_NONDISTRO
Message-ID: <Z5K712McgLXkN6aR@google.com>
References: <20250122062332.577009-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250122062332.577009-1-irogers@google.com>

On Tue, Jan 21, 2025 at 10:23:15PM -0800, Ian Rogers wrote:
> Linking against libcapstone and libLLVM can be a significant increase
> in dependencies and size of memory footprint. For something like `perf
> record` the disassembler and addr2line functionality won't be
> used. Support dynamically loading these libraries using dlopen and
> then calling the appropriate functions found using dlsym.

It's not clear from the description how you would use dlopen/dlsym.
Based on an offline discussion, you want to leave the current linking
model as is, and to support dlopen/dlsym when it's NOT detected at
build-time, right?

For that, you need to carry some definitions of the functions and types
for the used APIs.  But I'm not sure if it's right to carry them in the
perf code base.

> 
> BUILD_NONDISTRO is used to build perf against the license incompatible
> libbfd and libiberty libraries. As this has been opt-in for nearly 2
> years, commit dd317df07207 ("perf build: Make binutil libraries opt
> in"), remove the code to simplify the code base.

This part can be a separate series.

> 
> The patch series:
> 1) does some initial clean up;
> 2) moves the capstone and LLVM code to their own C files,
> 3) simplifies a little the capstone code;

I like changes up to this in general.  Let me take a look at the
patches.

Thanks,
Namhyung


> 4) adds perf_ variants of the functions that will either directly call
>    the function or use dlsym to discover it;
> 5) adds BPF JIT disassembly support to LLVM and capstone disassembly;
> 6) removes the BUILD_NONDISTRO code, reduces scope and removes what's possible.
> 
> The addr2line LLVM functionality is written in C++. To avoid linking
> against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
> the C++ code with the libLLVM dependency will be built into a
> libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
> would extend their C API to avoid this.
> 
> The libbfd BPF disassembly supported source lines, this wasn't ported
> to the capstone and LLVM disassembly.
> 
> v2: Add mangling of the function names in libperf-llvm.so to avoid
>     potential infinite recursion. Add BPF JIT disassembly support to
>     LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
>     series from:
>     https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
>     Some other minor additional clean up.
> 
> Ian Rogers (17):
>   perf build: Remove libtracefs configuration
>   perf map: Constify objdump offset/address conversion APIs
>   perf capstone: Move capstone functionality into its own file
>   perf llvm: Move llvm functionality into its own file
>   perf capstone: Remove open_capstone_handle
>   perf capstone: Support for dlopen-ing libcapstone.so
>   perf llvm: Support for dlopen-ing libLLVM.so
>   perf llvm: Mangle libperf-llvm.so function names
>   perf dso: Move read_symbol from llvm/capstone to dso
>   perf dso: Support BPF programs in dso__read_symbol
>   perf llvm: Disassemble cleanup
>   perf dso: Clean up read_symbol error handling
>   perf build: Remove libbfd support
>   perf build: Remove libiberty support
>   perf build: Remove unused defines
>   perf disasm: Remove disasm_bpf
>   perf disasm: Make ins__scnprintf and ins__is_nop static
> 
>  tools/perf/Documentation/perf-check.txt |   1 -
>  tools/perf/Makefile.config              |  90 +---
>  tools/perf/Makefile.perf                |  35 +-
>  tools/perf/builtin-check.c              |   1 -
>  tools/perf/builtin-script.c             |   2 -
>  tools/perf/tests/Build                  |   1 -
>  tools/perf/tests/builtin-test.c         |   1 -
>  tools/perf/tests/make                   |   4 +-
>  tools/perf/tests/pe-file-parsing.c      | 101 ----
>  tools/perf/tests/tests.h                |   1 -
>  tools/perf/util/Build                   |   5 +-
>  tools/perf/util/annotate.h              |   1 -
>  tools/perf/util/capstone.c              | 682 ++++++++++++++++++++++++
>  tools/perf/util/capstone.h              |  24 +
>  tools/perf/util/demangle-cxx.cpp        |  22 +-
>  tools/perf/util/disasm.c                | 632 +---------------------
>  tools/perf/util/disasm.h                |   5 +-
>  tools/perf/util/disasm_bpf.c            | 195 -------
>  tools/perf/util/disasm_bpf.h            |  12 -
>  tools/perf/util/dso.c                   |  98 ++++
>  tools/perf/util/dso.h                   |   4 +
>  tools/perf/util/llvm-c-helpers.cpp      | 120 ++++-
>  tools/perf/util/llvm-c-helpers.h        |  24 +-
>  tools/perf/util/llvm.c                  | 489 +++++++++++++++++
>  tools/perf/util/llvm.h                  |  24 +
>  tools/perf/util/map.c                   |  19 +-
>  tools/perf/util/map.h                   |   6 +-
>  tools/perf/util/print_insn.c            | 117 +---
>  tools/perf/util/srcline.c               | 306 +----------
>  tools/perf/util/srcline.h               |   6 +
>  tools/perf/util/symbol-elf.c            |  95 ----
>  tools/perf/util/symbol.c                | 135 -----
>  tools/perf/util/symbol.h                |   4 -
>  33 files changed, 1552 insertions(+), 1710 deletions(-)
>  delete mode 100644 tools/perf/tests/pe-file-parsing.c
>  create mode 100644 tools/perf/util/capstone.c
>  create mode 100644 tools/perf/util/capstone.h
>  delete mode 100644 tools/perf/util/disasm_bpf.c
>  delete mode 100644 tools/perf/util/disasm_bpf.h
>  create mode 100644 tools/perf/util/llvm.c
>  create mode 100644 tools/perf/util/llvm.h
> 
> -- 
> 2.48.0.rc2.279.g1de40edade-goog
> 

