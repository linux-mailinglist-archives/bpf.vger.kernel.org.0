Return-Path: <bpf+bounces-70230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD24BB4EC4
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 20:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22F914E2FB3
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 18:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE58A27B33E;
	Thu,  2 Oct 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AryvmF9l"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201FC27B34F;
	Thu,  2 Oct 2025 18:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759430711; cv=none; b=HJXM4CWe58SD8/PyK4+NftGaOKEclrqMxWiWKa01SkRXBZTruOQTvqqipcGH0Gark3dXoh6CvGQYZS4WVf7M7H1Xk6BX+QD6pXXmW1/CLVVzWRxuH01jyWlm0hmQ50NRduXBI8Sarh8X3+buEZ4snxBdfV9zcoER6jCGYQjzIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759430711; c=relaxed/simple;
	bh=N62s52yKQggU+cuuYi8aVyVjhGJr8EhIrUGAee4cmp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1ne+sNAb1V45yrxOyXODKsECvx0tewQvKuRiyhS9xxLRk6bFgNKFn8LJ7Zql1zPzdSeAKnc3Xagjcx7Qx0IYuOXRsXlro2AY/PpzrK59Din9ndrzOHcBNrysU3KOHk6jVmvfb0FAVdEdUUvg3kUx+qazb5zAOgbNuKlfdKC0T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AryvmF9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C967C4CEF5;
	Thu,  2 Oct 2025 18:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759430710;
	bh=N62s52yKQggU+cuuYi8aVyVjhGJr8EhIrUGAee4cmp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AryvmF9lGQP/L+G0e3unybzYiHSOJ2fUdvWii7/gnjZZXyW9KmBkOwf6z3kLP8PtE
	 I2HVWNM+Kw14l27wm9X4KPLngg4CAgqpqBsgeM4TVTQEmh5yN8ubeRmksFFX1yoP7H
	 XBm18QXTcbJ+74i4xFXWHes+VF+dTBM2zHXnkuNrir1HGrb96hpXjHf6VjQiCUMNq3
	 LIQUVuD4H0VMFttdqTT5XlgJdF0vspApLb+QS2yJSHFjYNfBs6vlFdFCCqILUoL+kR
	 4KmK38nF7OqyBGyFVUtorlZ53IylXHsQgZOfM+MEz3I/oV4kkWwbDli/afDLpfmLuL
	 yrf8mKYxja+2A==
Date: Thu, 2 Oct 2025 15:45:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Li Huafei <lihuafei1@huawei.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>, Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev,
	Song Liu <song@kernel.org>
Subject: Re: [PATCH v6 00/15] Support dynamic opening of capstone/llvm
Message-ID: <aN7IMkpl0yQy8a13@x1>
References: <20250929190805.201446-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929190805.201446-1-irogers@google.com>

On Mon, Sep 29, 2025 at 12:07:50PM -0700, Ian Rogers wrote:
> Linking against libcapstone and libLLVM can be a significant increase
> in dependencies and file size if building statically. For something
> like `perf record` the disassembler and addr2line functionality won't
> be used. Support dynamically loading these libraries using dlopen and
> then calling the appropriate functions found using dlsym.

Got the first 5 patches of this series cherry-picked, will test it all
and then consider from 6 onwards.

- Arnaldo
 
> The patch series:
> 1) moves the capstone, LLVM and libbfd code to their own C files,
> 2) simplifies a little the capstone code;
> 3) adds perf_ variants of the functions that will either directly call
>    the function or use dlsym to discover it;
> 4) adds BPF JIT disassembly support to in memory disassemblers (LLVM
>    and capstone) by just directing them at the BPF info linear JIT
>    instructions (note this doesn't support source lines);
> 5) adds fallback to srcline's addr2line so that llvm_addr2line is
>    tried first, then the deprecated libbfd and then the forked command
>    tried next, moving the code for forking out of the main srcline.c
>    file in the process.
> 
> The addr2line LLVM functionality is written in C++. To avoid linking
> against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
> the C++ code with the libLLVM dependency will be built into a
> libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
> would extend their C API to avoid this.
> 
> v6: Refactor the libbfd along with capstone and LLVM, previous patch
>     series had tried to avoid this by just removing the deprecated
>     BUILD_NONDISTRO code. Remove the libtracefs removal into its own
>     patch.
> v5: Rebase and comment typo fix.
> v4: Rebase and addition of a patch removing an unused struct variable.
> v3: Add srcline addr2line fallback trying LLVM first then forking a
>     process. This came up in conversation with Steinar Gunderson
>     <sesse@google.com>.
>     Tweak the cover letter message to try to address Andi Kleen's
>     <ak@linux.intel.com> feedback that the series doesn't really
>     achieve anything.
> v2: Add mangling of the function names in libperf-llvm.so to avoid
>     potential infinite recursion. Add BPF JIT disassembly support to
>     LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
>     series from:
>     https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
>     Some other minor additional clean up.
> 
> Ian Rogers (15):
>   perf map: Constify objdump offset/address conversion APIs
>   perf capstone: Move capstone functionality into its own file
>   perf llvm: Move llvm functionality into its own file
>   perf libbfd: Move libbfd functionality to its own file
>   perf capstone: Remove open_capstone_handle
>   perf capstone: Support for dlopen-ing libcapstone.so
>   perf llvm: Support for dlopen-ing libLLVM.so
>   perf llvm: Mangle libperf-llvm.so function names
>   perf dso: Move read_symbol from llvm/capstone to dso
>   perf dso: Support BPF programs in dso__read_symbol
>   perf llvm: Disassemble cleanup
>   perf dso: Clean up read_symbol error handling
>   perf disasm: Make ins__scnprintf and ins__is_nop static
>   perf srcline: Fallback between addr2line implementations
>   perf disasm: Remove unused evsel from annotate_args
> 
>  tools/perf/Makefile.config         |  14 +
>  tools/perf/Makefile.perf           |  24 +-
>  tools/perf/builtin-script.c        |   2 -
>  tools/perf/tests/make              |   2 +
>  tools/perf/util/Build              |   7 +-
>  tools/perf/util/addr2line.c        | 439 ++++++++++++++++
>  tools/perf/util/addr2line.h        |  20 +
>  tools/perf/util/annotate.c         |   1 -
>  tools/perf/util/capstone.c         | 682 +++++++++++++++++++++++++
>  tools/perf/util/capstone.h         |  24 +
>  tools/perf/util/config.c           |   2 +-
>  tools/perf/util/disasm.c           | 645 ++----------------------
>  tools/perf/util/disasm.h           |   6 +-
>  tools/perf/util/disasm_bpf.c       | 195 --------
>  tools/perf/util/disasm_bpf.h       |  12 -
>  tools/perf/util/dso.c              | 112 +++++
>  tools/perf/util/dso.h              |   4 +
>  tools/perf/util/libbfd.c           | 600 ++++++++++++++++++++++
>  tools/perf/util/libbfd.h           |  83 ++++
>  tools/perf/util/llvm-c-helpers.cpp | 120 ++++-
>  tools/perf/util/llvm-c-helpers.h   |  24 +-
>  tools/perf/util/llvm.c             | 484 ++++++++++++++++++
>  tools/perf/util/llvm.h             |  21 +
>  tools/perf/util/map.c              |  19 +-
>  tools/perf/util/map.h              |   6 +-
>  tools/perf/util/print_insn.c       | 117 +----
>  tools/perf/util/srcline.c          | 772 ++---------------------------
>  tools/perf/util/srcline.h          |   9 +-
>  tools/perf/util/symbol-elf.c       | 100 +---
>  tools/perf/util/symbol.c           | 131 -----
>  30 files changed, 2745 insertions(+), 1932 deletions(-)
>  create mode 100644 tools/perf/util/addr2line.c
>  create mode 100644 tools/perf/util/addr2line.h
>  create mode 100644 tools/perf/util/capstone.c
>  create mode 100644 tools/perf/util/capstone.h
>  delete mode 100644 tools/perf/util/disasm_bpf.c
>  delete mode 100644 tools/perf/util/disasm_bpf.h
>  create mode 100644 tools/perf/util/libbfd.c
>  create mode 100644 tools/perf/util/libbfd.h
>  create mode 100644 tools/perf/util/llvm.c
>  create mode 100644 tools/perf/util/llvm.h
> 
> -- 
> 2.51.0.570.gb178f27e6d-goog
> 

