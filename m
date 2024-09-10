Return-Path: <bpf+bounces-39449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5889739D4
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 989122828F2
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C57194A7C;
	Tue, 10 Sep 2024 14:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yl6fWYgy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F272AEF1;
	Tue, 10 Sep 2024 14:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725978447; cv=none; b=b2aGUuH9eZKggqP9AXmqky27e8yqAif11GZKS0ZHKUlf4gUHmuU6l0MbS5SsXYgHarBmhbNntTKYRChxexlhM5yp4TkDeH9f0VGKd6xFGrOSelG5IXsz4O8gbOurdtpryyoogy+95FWfNTmaiP0VTXh7MeLKtIIHxXII1WsDtW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725978447; c=relaxed/simple;
	bh=ZxDk5Fk89zH/bioeL3XOgTPjQDch7841H+ZV7fVipHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ny4ahOSQvWerCXWeRzQgfKTX7XNhfY0SFPrD4eSiczcyW7PBK8VUcaQfBDhnIHi25DL6FsaapdJz2HGGXsRGW0DaR+l2vIdot55b6w/Itkn6CxFtXXu1Qdn19g8uUt9uLqklhzpZZNFbsik+7Uc/EDGRcuwIYrTCetkW8paDiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yl6fWYgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14CB6C4CEC3;
	Tue, 10 Sep 2024 14:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725978447;
	bh=ZxDk5Fk89zH/bioeL3XOgTPjQDch7841H+ZV7fVipHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Yl6fWYgyG+mAfxEu/dFwAgv8LUpgM0zqF/rnitmNqa0iTXaZDx+Da0Vu9a0+B3RAR
	 51HgqNIUoMeo/HIq8f/FTCDU3UEb8IgM6eeS1pArECU/1TiOsXiuWDVsk6TE04ngpq
	 1DXHUzq9FEC6rBI4auR2z+SEpLjRuPTJCXm8O2N/ba6QPHCe0qG3NuuQS86aHu+6sp
	 Kx6IIMMgGL2Ij8T7KjZe1vv2bX9Iwhogy7zFibXOlX+6j30Dbx/AXZ7cubhwUZgC2N
	 daOIRekkXOv5mZ3ZXYDNR5XXhUMJDZRiLEaQk9LTYf5kUuo2xLmDwGseXUmQrkw3Z2
	 +yT5jFlwh+wyw==
Message-ID: <b2e813c4-be89-457d-8c38-38849177ec93@kernel.org>
Date: Tue, 10 Sep 2024 15:27:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf build: Autodetect minimum required llvm-dev
 version
To: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
 sesse@google.com, acme@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Changbin Du <changbin.du@huawei.com>, Guilherme Amadio <amadio@gentoo.org>,
 Leo Yan <leo.yan@arm.com>, Manu Bretelle <chantr4@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
References: <20240910140405.568791-1-james.clark@linaro.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240910140405.568791-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

2024-09-10 15:04 UTC+0100 ~ James Clark <james.clark@linaro.org>
> The new LLVM addr2line feature requires a minimum version of 13 to
> compile. Add a feature check for the version so that NO_LLVM=1 doesn't
> need to be explicitly added. Leave the existing llvm feature check
> intact because it's used by tools other than Perf.
> 
> This fixes the following compilation error when the llvm-dev version
> doesn't match:
> 
>    util/llvm-c-helpers.cpp: In function 'char* llvm_name_for_code(dso*, const char*, u64)':
>    util/llvm-c-helpers.cpp:178:21: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
>      178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
> 
> Fixes: c3f8644c21df ("perf report: Support LLVM for addr2line()")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   tools/build/Makefile.feature           |  2 +-
>   tools/build/feature/Makefile           |  9 +++++++++
>   tools/build/feature/test-llvm-perf.cpp | 14 ++++++++++++++
>   tools/perf/Makefile.config             |  6 +++---
>   4 files changed, 27 insertions(+), 4 deletions(-)
>   create mode 100644 tools/build/feature/test-llvm-perf.cpp
> 
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 0717e96d6a0e..427a9389e26c 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -136,7 +136,7 @@ FEATURE_DISPLAY ?=              \
>            libunwind              \
>            libdw-dwarf-unwind     \
>            libcapstone            \
> -         llvm                   \
> +         llvm-perf              \

Hi! Just a quick question, why remove "llvm" from the list, here?

Quentin

