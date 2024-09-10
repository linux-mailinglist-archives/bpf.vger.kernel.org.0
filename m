Return-Path: <bpf+bounces-39450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD01973A0F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FBE81C24782
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7336195B1A;
	Tue, 10 Sep 2024 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbTTzVu4"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379C619413F;
	Tue, 10 Sep 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979100; cv=none; b=nnS2Kyk1Qf2Szc2cfLkQXKKKlBwzbDY9uzNbXIGM3WKH4UvBx/n4XbL61vUhOQIYGwLbZPaDZ8c+B+Uetnh8k2q95oQM3fJstSWMmXV7m2GyXU0Cc7HvWSULN7oEUtJwm9D9LHzBH6IyhYt5BWFQqq7BtQcITIX4mPPuQV9l3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979100; c=relaxed/simple;
	bh=gZQPYlQoZN4iQmKQ//DI0o0kr5xSOqSizyZqGt8UoRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APkoUmJKGQX0GX61KNeNpquW8/xxmP7a+jBVDhmOvHM/EUDl4LJUvJ/9Y+9gSpK0DdfmqPFCpW81wgb/MQgUvtX+DhwSxFd/lfDCCwwGr27akUQIpUHzbKIAJEiBXCf+QWKzgUmcYKPdXEuIilJtfsLm/LU5FgJ5Tb2b30Z/dHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbTTzVu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C57C4CECD;
	Tue, 10 Sep 2024 14:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979099;
	bh=gZQPYlQoZN4iQmKQ//DI0o0kr5xSOqSizyZqGt8UoRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbTTzVu4vQw/QXjahRq6JeYuZxatUW3lEAQINBOFnI2ROwwcd4/nG3HXHwdi6E+1I
	 RDIyGfe8x6xYdtG6JOffa6jzxE2RpklTzJD2WAerdBys2MRuj6EkxxkWIvSWGtTrhU
	 UNbmW2arVT50kHkgjiVofzTJKV+FLqLjZsOmiyJ7gcfxoKSBXN+kGUXG2XKVjKot/p
	 KGVoAyFzC6nLU0nHPWZL4NT+g9dGAEnZqiZI1tC/B69wvmfddwq5HUh4lmvoUykOfq
	 RLshHrVRXtq2ixICQlnf3a4aBUNdMsIOtpBFdtgDjNO3aX95+A9dkgF63z8QYINmXF
	 1m5ylPl+euIig==
Date: Tue, 10 Sep 2024 11:38:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, sesse@google.com,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Guilherme Amadio <amadio@gentoo.org>, Leo Yan <leo.yan@arm.com>,
	Manu Bretelle <chantr4@gmail.com>, Quentin Monnet <qmo@kernel.org>,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] perf build: Autodetect minimum required llvm-dev
 version
Message-ID: <ZuBZ2Qq176_w94Zv@x1>
References: <20240910140405.568791-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240910140405.568791-1-james.clark@linaro.org>

On Tue, Sep 10, 2024 at 03:04:00PM +0100, James Clark wrote:
> The new LLVM addr2line feature requires a minimum version of 13 to
> compile. Add a feature check for the version so that NO_LLVM=1 doesn't
> need to be explicitly added. Leave the existing llvm feature check
> intact because it's used by tools other than Perf.
> 
> This fixes the following compilation error when the llvm-dev version
> doesn't match:
> 
>   util/llvm-c-helpers.cpp: In function 'char* llvm_name_for_code(dso*, const char*, u64)':
>   util/llvm-c-helpers.cpp:178:21: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
>     178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
> 
> Fixes: c3f8644c21df ("perf report: Support LLVM for addr2line()")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  tools/build/Makefile.feature           |  2 +-
>  tools/build/feature/Makefile           |  9 +++++++++
>  tools/build/feature/test-llvm-perf.cpp | 14 ++++++++++++++
>  tools/perf/Makefile.config             |  6 +++---
>  4 files changed, 27 insertions(+), 4 deletions(-)
>  create mode 100644 tools/build/feature/test-llvm-perf.cpp
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 0717e96d6a0e..427a9389e26c 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -136,7 +136,7 @@ FEATURE_DISPLAY ?=              \
>           libunwind              \
>           libdw-dwarf-unwind     \
>           libcapstone            \
> -         llvm                   \
> +         llvm-perf              \
>           zlib                   \
>           lzma                   \
>           get_cpuid              \

There was one leftover on the other patch, I added it here:

⬢[acme@toolbox perf-tools-next]$ git diff
diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 427a9389e26cd203..ffd117135094cc68 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -100,7 +100,6 @@ FEATURE_TESTS_EXTRA :=                  \
          libunwind-debug-frame-aarch64  \
          cxx                            \
          llvm                           \
-         llvm-version                   \
          clang                          \
          libbpf                         \
          libbpf-btf__load_from_kernel_by_id \
⬢[acme@toolbox perf-tools-next]$

