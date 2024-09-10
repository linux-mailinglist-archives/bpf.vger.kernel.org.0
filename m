Return-Path: <bpf+bounces-39454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CC1973A30
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283B1282170
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548A0195FEF;
	Tue, 10 Sep 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luEyd+qY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20921922DC;
	Tue, 10 Sep 2024 14:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979399; cv=none; b=TOVQzQ+1KPj13RxjS/9kcg4YicDhSYnX/bdaww/7JdcW2/rr4JbbT4LgD6FVAYQyV4w9QSE4nZ/+3jJbDzR5Dxr6bpCPX4uOhomBNEDOpPg9/be4rjkw1qKvIDl2MI3QaiLPUqMwXOUSJRTrk4WncTwC88thHhM0A3wK5Rwn9i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979399; c=relaxed/simple;
	bh=06nEJniau8A/jHLpYeHpdDSJXkabB+IN1TDH7Cwcf/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU052A98/3qXVOHFG1P5WGNlD0S/knAI/WM5692UKTrEWUQrgM9X07zu5b8oZWURPQ/MXnPbk4M7PflYeTTpeyd+Pm7Etq308pmx+6gzm2fXBA7nFUO9tNzz5pHLcXgzFoniTsp+R6plFDUL29qMD+FMti33MKr3YUrrxe5BbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luEyd+qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE6CC4CECE;
	Tue, 10 Sep 2024 14:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725979399;
	bh=06nEJniau8A/jHLpYeHpdDSJXkabB+IN1TDH7Cwcf/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=luEyd+qY11c9BaTv8xtxFPYNl7H+C0HgDXaYfI1T6sM8kCn+KFmxd8vzATF735pr8
	 qBIkuul+76JxAeg8j91liukHpop68wVp0+gp45XeuHvv7xI9O1OQevoTrDN5YMauNT
	 9eu+fbFqNBanAgTEUQ3xa96/nLIOsUSefgwzVrU60/rg2yEle5YeM/aQO6cBxZ+ql6
	 lqkNzzk7ov+BL8+HD6JZRvnIXNnm4Ztt5omrh6U0uqufPk+3jIGPDUbJcqPZE0geDM
	 jF6U65DtXE1poDzfOJrzpyy14Kh+bbMFNfg4r0d5RuqwlXF/vM/+R3lAeE8v1ObuKd
	 zMnNCVSsyCOew==
Date: Tue, 10 Sep 2024 11:43:15 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Quentin Monnet <qmo@kernel.org>
Cc: James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
	sesse@google.com, Peter Zijlstra <peterz@infradead.org>,
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
	Manu Bretelle <chantr4@gmail.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/2] perf build: Autodetect minimum required llvm-dev
 version
Message-ID: <ZuBbAw2jbMwH91Az@x1>
References: <20240910140405.568791-1-james.clark@linaro.org>
 <b2e813c4-be89-457d-8c38-38849177ec93@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b2e813c4-be89-457d-8c38-38849177ec93@kernel.org>

On Tue, Sep 10, 2024 at 03:27:16PM +0100, Quentin Monnet wrote:
> 2024-09-10 15:04 UTC+0100 ~ James Clark <james.clark@linaro.org>
> > The new LLVM addr2line feature requires a minimum version of 13 to
> > compile. Add a feature check for the version so that NO_LLVM=1 doesn't
> > need to be explicitly added. Leave the existing llvm feature check
> > intact because it's used by tools other than Perf.
> > 
> > This fixes the following compilation error when the llvm-dev version
> > doesn't match:
> > 
> >    util/llvm-c-helpers.cpp: In function 'char* llvm_name_for_code(dso*, const char*, u64)':
> >    util/llvm-c-helpers.cpp:178:21: error: 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct llvm::DILineInfo'} has no member named 'StartAddress'
> >      178 |   addr, res_or_err->StartAddress ? *res_or_err->StartAddress : 0);
> > 
> > Fixes: c3f8644c21df ("perf report: Support LLVM for addr2line()")
> > Signed-off-by: James Clark <james.clark@linaro.org>
> > ---
> >   tools/build/Makefile.feature           |  2 +-
> >   tools/build/feature/Makefile           |  9 +++++++++
> >   tools/build/feature/test-llvm-perf.cpp | 14 ++++++++++++++
> >   tools/perf/Makefile.config             |  6 +++---
> >   4 files changed, 27 insertions(+), 4 deletions(-)
> >   create mode 100644 tools/build/feature/test-llvm-perf.cpp
> > 
> > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > index 0717e96d6a0e..427a9389e26c 100644
> > --- a/tools/build/Makefile.feature
> > +++ b/tools/build/Makefile.feature
> > @@ -136,7 +136,7 @@ FEATURE_DISPLAY ?=              \
> >            libunwind              \
> >            libdw-dwarf-unwind     \
> >            libcapstone            \
> > -         llvm                   \
> > +         llvm-perf              \
 
> Hi! Just a quick question, why remove "llvm" from the list, here?

Right, having it here is still interesting, if not for perf, for some
other tool in tools/ that uses this:

⬢[acme@toolbox perf-tools-next]$ cat tools/build/feature/test-llvm.cpp
// SPDX-License-Identifier: GPL-2.0
#include "llvm/Support/ManagedStatic.h"
#include "llvm/Support/raw_ostream.h"
#define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR << 8) + LLVM_VERSION_PATCH)

#if NUM_VERSION < 0x030900
# error "LLVM version too low"
#endif
int main()
{
	llvm::errs() << "Hello World!\n";
	llvm::llvm_shutdown();
	return 0;
}
⬢[acme@toolbox perf-tools-next]$

My understanding about James intention is that for perf we need at least
llvm-dev 13, but he kept the other feature test for other projects.

From Quentin, since this is in tools/build/Makefile.feature, so not perf
specific, maybe it should be somewhere else?

But keeping both in FEATURE_DISPLAY at tools/build/Makefile.feature
may be confusing?

- Arnaldo

