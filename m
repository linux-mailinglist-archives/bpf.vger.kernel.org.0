Return-Path: <bpf+bounces-70433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35991BBF015
	for <lists+bpf@lfdr.de>; Mon, 06 Oct 2025 20:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 862D63A9E28
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F82D94B3;
	Mon,  6 Oct 2025 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uRnQqBTZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A44E22424E;
	Mon,  6 Oct 2025 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776095; cv=none; b=bOra2MtsoClseqNtqdNTUJ1JYRsDm2oer05fEJRVShJ6yv+f8i6f99tDWplj2yPpkY1PuESGE9xGCw0a1MyUAWABEAaZ1E+0vcQOftGGeOsW2jC5Sh7nuWaB5ojOusczQkSHKzAAOGsq23VNtJoX5CDXeTzaDaPNkUyoXD2XOPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776095; c=relaxed/simple;
	bh=Sfbdxy0FXU1Gv1JPzvqW17nGSrHGnNGGW4PHQs6NWsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJ/Q2VsRF6HyuzdPb9uP6W6QF/bFiFbp9vEsRDoFpzLx7I49gMHMRuYTNvYC6Tylp2vWRXGaLNZ9QbyBqgS59GtYvle5xYXCH5qXE1OV3bpJgoQOw5ccRA0xMYT7fcnLJ09T/5Y3p7cnGXj3dQMLLYSXTFndui8HiQjn3HkdXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uRnQqBTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCD2C4CEF5;
	Mon,  6 Oct 2025 18:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759776095;
	bh=Sfbdxy0FXU1Gv1JPzvqW17nGSrHGnNGGW4PHQs6NWsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uRnQqBTZACiFUAmA1zsLy/ZupaxoKxZ18dEhVnBTNTJ/t6R8L0Rai0PXqX6z+Dyct
	 UjdOROO7mndDVPDTYSsc4VsVS4SZ7LNQSnb2WohwS+SMPnIuE/QuYDusShSvZeqxVO
	 W9jJ8hazvRRhQ5E82Wm8CYN6Y/WoGSe6iq7VQcOVkwbH1M+ds5svWGoPXZrkoJDrBP
	 29//G92l6HzN5Yc223S0761o+ueao+R6Sf9jcxO9hyLkpQn2KwKOmqXUezu2bdUxlY
	 CEneJC1RFtyA4KIT4KFdXHCqoYOIVORBNIVnQc/yjhiIxPfv21NB6uhZmRywkjAfDS
	 CuAhPelSZn2hA==
Date: Mon, 6 Oct 2025 15:41:32 -0300
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
Message-ID: <aOQNXBje78z-gPpi@x1>
References: <20251005212212.2892175-1-irogers@google.com>
 <aOQMzhBqoL8qs5t2@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aOQMzhBqoL8qs5t2@x1>

On Mon, Oct 06, 2025 at 03:39:13PM -0300, Arnaldo Carvalho de Melo wrote:
> On Sun, Oct 05, 2025 at 02:22:01PM -0700, Ian Rogers wrote:
> > v7: Refactor now the first 5 patches, that largely moved code around,
> >     have landed. Move the dlopen code to the end of the series so that
> >     the first 8 patches can be picked improving capstone/LLVM support
 
> So I tentatively picked the first 8 patches, will test it now, hopefully
> we can go with it to have BPF annotation...
 
> Wait, will try to fix this one:
 
> ⬢ [acme@toolbx perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
>                  make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j32  DESTDIR=/tmp/tmp.w26bDGykTM
> cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j32 DESTDIR=/tmp/tmp.w26bDGykTM
>   BUILD:   Doing 'make -j32' parallel build
> <SNIP>
> Auto-detecting system features:
> ...                                   libdw: [ OFF ]
> ...                                   glibc: [ on  ]
> ...                                  libelf: [ OFF ]
> ...                                 libnuma: [ OFF ]
> ...                  numa_num_possible_cpus: [ OFF ]
> ...                               libpython: [ OFF ]
> ...                             libcapstone: [ OFF ]
> ...                               llvm-perf: [ OFF ]
> ...                                    zlib: [ OFF ]
> ...                                    lzma: [ OFF ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ OFF ]
> <SNIP>
>  CC      tests/api-io.o
>   CC      util/sha1.o
>   CC      util/smt.o
>   LD      util/intel-pt-decoder/perf-util-in.o
>   CC      tests/demangle-java-test.o
>   CC      util/strbuf.o
>   CC      util/string.o
>   CC      tests/demangle-ocaml-test.o
>   CC      util/strlist.o
>   CC      tests/demangle-rust-v0-test.o
>   CC      tests/pfm.o
>   CC      tests/parse-metric.o
>   CC      util/strfilter.o
>   CC      tests/pe-file-parsing.o
> util/llvm.c: In function ‘init_llvm’:
> util/llvm.c:78:17: error: implicit declaration of function ‘LLVMInitializeAllTargetInfos’ [-Wimplicit-function-declaration]
>    78 |                 LLVMInitializeAllTargetInfos();
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/llvm.c:79:17: error: implicit declaration of function ‘LLVMInitializeAllTargetMCs’ [-Wimplicit-function-declaration]
>    79 |                 LLVMInitializeAllTargetMCs();
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
> util/llvm.c:80:17: error: implicit declaration of function ‘LLVMInitializeAllDisassemblers’ [-Wimplicit-function-declaration]
>    80 |                 LLVMInitializeAllDisassemblers();
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> util/llvm.c: At top level:
> util/llvm.c:73:13: error: ‘init_llvm’ defined but not used [-Werror=unused-function]
>    73 | static void init_llvm(void)
>       |             ^~~~~~~~~
> cc1: all warnings being treated as errors
>   CC      tests/expand-cgroup.o
>   CC      util/top.o
>   CC      tests/perf-time-to-tsc.o
>   CC      util/usage.o
> make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:86: util/llvm.o] Error 1
> make[6]: *** Waiting for unfinished jobs....
>   CC      tests/dlfilter-test.o
>   CC      tests/sigtrap.o
>   CC      tests/event_groups.o

Guess this will be enough:

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 565cad1969e5e51f..2ebf1f5f65bf77c7 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -70,6 +70,7 @@ int llvm__addr2line(const char *dso_name __maybe_unused, u64 addr __maybe_unused
 #endif
 }
 
+#ifdef HAVE_LIBLLVM_SUPPORT
 static void init_llvm(void)
 {
 	static bool init;
@@ -90,7 +91,6 @@ static void init_llvm(void)
  * should add some textual annotation for after the instruction. The caller
  * will use this information to add the actual annotation.
  */
-#ifdef HAVE_LIBLLVM_SUPPORT
 struct symbol_lookup_storage {
 	u64 branch_addr;
 	u64 pcrel_load_addr;

