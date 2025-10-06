Return-Path: <bpf+bounces-70432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9AABBF006
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 20:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5258C3BA756
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 18:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F892D94A6;
	Mon,  6 Oct 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzHuEdSi"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC418DF89;
	Mon,  6 Oct 2025 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759775954; cv=none; b=VcKvqygXFjhJRNanqH9bCYa6zqQkfeyqUOs+b+Yf9Z3Lxk8sWgWJ+n6g7yxtyv3me5QOC3HGrz+p2MZblAMCgwODm64zypDf+Ua8Xng6VaXSfjNbOQIE3OR3BTyfr8UVpWDN2BEVn43te0Ymwy+6xx4h0WLKjGHW1vTIPgD3RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759775954; c=relaxed/simple;
	bh=ZYBGbMiAvRmmZykI4RviAOYJTMl4sMmYDh/NDlSP5v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY9WCYi2CFteH1sQ5g4GQOWH8iEAQJM3+NO6QQluwQtVcQIGp5qtawfR8al+RaqrARDFj6xpd5Zm1e1y4KGgWGaXNwT+YzPwpwAjyByUxRHA9oIGegdlvhMhhxaIR+rWNxaSJ4C6QPYOO7lR+ClPSiZfb7v5s9f28ZCWN1xLzDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzHuEdSi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01326C4CEF5;
	Mon,  6 Oct 2025 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759775953;
	bh=ZYBGbMiAvRmmZykI4RviAOYJTMl4sMmYDh/NDlSP5v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YzHuEdSitbPTGtmCA65o2wQDu+REURCt5h4LPkEvkXD5P4NhaqWSkHCNJwl+hMjeV
	 WNyaLAHLHD9/datVmp5o/TDHkgOAZcx8uObwGR8tGBMSS7/1ncCJwTOObiE1EcKwel
	 qsA3bxRSnsA0In8+tUZAocRvq5ZNK1I/A+cAYXiJMzkpVta9xTp0O27LoamAEJq4mv
	 qfUZ7f9zArShyb6oLloRDR9+WWMMGhXmMKg/5Panwz3Iz7CGUoMTBfU8Pcgd3HFTof
	 ZltJxPpsnax8JAS/XSzAenZGgZ7uGzD7b/Aqn71Fqw3BVUwJgkgN+2g3XPl18zyP7J
	 DyFKsxkIyqP4w==
Date: Mon, 6 Oct 2025 15:39:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH v7 00/11] Capstone/llvm improvements + dlopen support
Message-ID: <aOQMzhBqoL8qs5t2@x1>
References: <20251005212212.2892175-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251005212212.2892175-1-irogers@google.com>

On Sun, Oct 05, 2025 at 02:22:01PM -0700, Ian Rogers wrote:
> Linking against libcapstone and libLLVM can be a significant increase
> in dependencies and file size if building statically. For something
> like `perf record` the disassembler and addr2line functionality won't
> be used. Support dynamically loading these libraries using dlopen and
> then calling the appropriate functions found using dlsym.
> 
> The patch series:
> 1) feature check libLLVM support and avoid always reinitializing the
>    disassembler.
> 2) adds BPF JIT disassembly support to in memory disassemblers (LLVM
>    and capstone) by just directing them at the BPF info linear JIT
>    instructions (note this doesn't support source lines);
> 3) adds fallback to srcline's addr2line so that llvm_addr2line is
>    tried first, then the deprecated libbfd and then the forked command
>    tried next, moving the code for forking out of the main srcline.c
>    file in the process.
> 4) adds perf_ variants of the capstone/llvm functions that will either
>    directly call the function or use dlsym to discover it;
> 
> The addr2line LLVM functionality is written in C++. To avoid linking
> against libLLVM for this, a new LIBLLVM_DYNAMIC option is added where
> the C++ code with the libLLVM dependency will be built into a
> libperf-llvm.so and that dlsym-ed and called against. Ideally LLVM
> would extend their C API to avoid this.
> 
> v7: Refactor now the first 5 patches, that largely moved code around,
>     have landed. Move the dlopen code to the end of the series so that
>     the first 8 patches can be picked improving capstone/LLVM support

So I tentatively picked the first 8 patches, will test it now, hopefully
we can go with it to have BPF annotation...

Wait, will try to fix this one:

⬢ [acme@toolbx perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
                 make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j32  DESTDIR=/tmp/tmp.w26bDGykTM
cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j32 DESTDIR=/tmp/tmp.w26bDGykTM
  BUILD:   Doing 'make -j32' parallel build
<SNIP>
Auto-detecting system features:
...                                   libdw: [ OFF ]
...                                   glibc: [ on  ]
...                                  libelf: [ OFF ]
...                                 libnuma: [ OFF ]
...                  numa_num_possible_cpus: [ OFF ]
...                               libpython: [ OFF ]
...                             libcapstone: [ OFF ]
...                               llvm-perf: [ OFF ]
...                                    zlib: [ OFF ]
...                                    lzma: [ OFF ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ OFF ]
<SNIP>
 CC      tests/api-io.o
  CC      util/sha1.o
  CC      util/smt.o
  LD      util/intel-pt-decoder/perf-util-in.o
  CC      tests/demangle-java-test.o
  CC      util/strbuf.o
  CC      util/string.o
  CC      tests/demangle-ocaml-test.o
  CC      util/strlist.o
  CC      tests/demangle-rust-v0-test.o
  CC      tests/pfm.o
  CC      tests/parse-metric.o
  CC      util/strfilter.o
  CC      tests/pe-file-parsing.o
util/llvm.c: In function ‘init_llvm’:
util/llvm.c:78:17: error: implicit declaration of function ‘LLVMInitializeAllTargetInfos’ [-Wimplicit-function-declaration]
   78 |                 LLVMInitializeAllTargetInfos();
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/llvm.c:79:17: error: implicit declaration of function ‘LLVMInitializeAllTargetMCs’ [-Wimplicit-function-declaration]
   79 |                 LLVMInitializeAllTargetMCs();
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
util/llvm.c:80:17: error: implicit declaration of function ‘LLVMInitializeAllDisassemblers’ [-Wimplicit-function-declaration]
   80 |                 LLVMInitializeAllDisassemblers();
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
util/llvm.c: At top level:
util/llvm.c:73:13: error: ‘init_llvm’ defined but not used [-Werror=unused-function]
   73 | static void init_llvm(void)
      |             ^~~~~~~~~
cc1: all warnings being treated as errors
  CC      tests/expand-cgroup.o
  CC      util/top.o
  CC      tests/perf-time-to-tsc.o
  CC      util/usage.o
make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:86: util/llvm.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC      tests/dlfilter-test.o
  CC      tests/sigtrap.o
  CC      tests/event_groups.o


>     without adding the dlopen code. Rename the cover letter and
>     disassembler cleanup patches.
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
> Ian Rogers (11):
>   perf check: Add libLLVM feature
>   perf llvm: Reduce LLVM initialization
>   perf dso: Move read_symbol from llvm/capstone to dso
>   perf dso: Support BPF programs in dso__read_symbol
>   perf dso: Clean up read_symbol error handling
>   perf disasm: Make ins__scnprintf and ins__is_nop static
>   perf srcline: Fallback between addr2line implementations
>   perf disasm: Remove unused evsel from annotate_args
>   perf capstone: Support for dlopen-ing libcapstone.so
>   perf llvm: Support for dlopen-ing libLLVM.so
>   perf llvm: Mangle libperf-llvm.so function names
> 
>  tools/perf/Documentation/perf-check.txt |   1 +
>  tools/perf/Makefile.config              |  13 +
>  tools/perf/Makefile.perf                |  24 +-
>  tools/perf/builtin-check.c              |   1 +
>  tools/perf/tests/make                   |   2 +
>  tools/perf/util/Build                   |   3 +-
>  tools/perf/util/addr2line.c             | 439 +++++++++++++++++++++
>  tools/perf/util/addr2line.h             |  20 +
>  tools/perf/util/annotate.c              |   1 -
>  tools/perf/util/capstone.c              | 352 ++++++++++++-----
>  tools/perf/util/config.c                |   2 +-
>  tools/perf/util/disasm.c                |  18 +-
>  tools/perf/util/disasm.h                |   4 -
>  tools/perf/util/dso.c                   | 112 ++++++
>  tools/perf/util/dso.h                   |   4 +
>  tools/perf/util/libbfd.c                |   4 +-
>  tools/perf/util/libbfd.h                |   6 +-
>  tools/perf/util/llvm-c-helpers.cpp      | 120 +++++-
>  tools/perf/util/llvm-c-helpers.h        |  24 +-
>  tools/perf/util/llvm.c                  | 374 +++++++++++++-----
>  tools/perf/util/llvm.h                  |   3 -
>  tools/perf/util/srcline.c               | 495 ++----------------------
>  tools/perf/util/srcline.h               |   1 -
>  23 files changed, 1314 insertions(+), 709 deletions(-)
>  create mode 100644 tools/perf/util/addr2line.c
>  create mode 100644 tools/perf/util/addr2line.h
> 
> -- 
> 2.51.0.618.g983fd99d29-goog
> 

