Return-Path: <bpf+bounces-39527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81363974300
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 21:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B38B01C250FE
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 19:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5581A7AC6;
	Tue, 10 Sep 2024 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVOSOZiC"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F54417A922;
	Tue, 10 Sep 2024 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995202; cv=none; b=pRGHvoc5Aa5kcsc4mdj2Y+MO+CpZ2P6zp+YdIBKHufG053GYr616ickOa04vh2VFTmY6TiAlj5UB0GC3o15n+FTION3HDUcesaaHlxeeJbA3Dx8eFstpKrAnkckvTR5LCtm1r4kqVaqVQ8nLvNoen1LsJiy4wBjWQcZKLSo7D7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995202; c=relaxed/simple;
	bh=Ul9jDHWGKcBdzpbOj4O7RU6PYDWlFr5RqCIVNG7UVOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uMPPd2zG5msn3Cr5Ck6ZVh0ZT5ok429LP/cNXQxtKgnYyuF8mD5Y0aCTz2JyCR2wFx7vMs4N+6KfckfrKbeHGXinJ3niMa1NSrPFN/lKzMfecGoZgr4tGY9a2CKo9CzAP1RNKRhWG99EvDaMS282oYVr9iET7AUfmCFyRMc3ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVOSOZiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EA9C4CEC4;
	Tue, 10 Sep 2024 19:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725995201;
	bh=Ul9jDHWGKcBdzpbOj4O7RU6PYDWlFr5RqCIVNG7UVOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVOSOZiCswbfLcdQm9Bl76P0KObTxVAy6s1pWxVvLhPdFXFb4sHAFNDQpG8yYClyn
	 Z6+7pdCscYqMFRX+kxRKxgMkU1NAl1m1kWeS1Ujak17v5ZKq4VbiaohjVFqgf2yxgk
	 /qcp7Ep+pJsqC0KRWXxSL3Tqf8XCbOYHjLzmF+HRflEPn0yGWQatYEjC8cxkYnIEDm
	 gmvx9Wm4ftR2E83qrG+xG0MogShoFZwxcMvzbulTPZMouUQEEBh0QfzLJu2k3QmrAe
	 JrXLTM9yiFWpqP1RMV7PQmigkTif/TOwZeNl/UdNvzisQkKEcLcMAo3EZtB/XXhutq
	 tQERftEB4pdvg==
Date: Tue, 10 Sep 2024 16:06:38 -0300
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
Message-ID: <ZuCYvvjJZm3jSQux@x1>
References: <20240910140405.568791-1-james.clark@linaro.org>
 <b2e813c4-be89-457d-8c38-38849177ec93@kernel.org>
 <307568b9-9b6b-4eaa-973c-8f88538b8545@linaro.org>
 <b60928c6-19c5-473c-8f13-532ed3fd3b3a@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b60928c6-19c5-473c-8f13-532ed3fd3b3a@kernel.org>

On Tue, Sep 10, 2024 at 05:53:16PM +0100, Quentin Monnet wrote:
> 2024-09-10 16:11 UTC+0100 ~ James Clark <james.clark@linaro.org>
> > 
> > 
> > On 9/10/24 15:27, Quentin Monnet wrote:
> > > 2024-09-10 15:04 UTC+0100 ~ James Clark <james.clark@linaro.org>
> > > > The new LLVM addr2line feature requires a minimum version of 13 to
> > > > compile. Add a feature check for the version so that NO_LLVM=1 doesn't
> > > > need to be explicitly added. Leave the existing llvm feature check
> > > > intact because it's used by tools other than Perf.
> > > > 
> > > > This fixes the following compilation error when the llvm-dev version
> > > > doesn't match:
> > > > 
> > > >    util/llvm-c-helpers.cpp: In function 'char*
> > > > llvm_name_for_code(dso*, const char*, u64)':
> > > >    util/llvm-c-helpers.cpp:178:21: error:
> > > > 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct
> > > > llvm::DILineInfo'} has no member named 'StartAddress'
> > > >      178 |   addr, res_or_err->StartAddress ? *res_or_err-
> > > > >StartAddress : 0);
> > > > 
> > > > Fixes: c3f8644c21df ("perf report: Support LLVM for addr2line()")
> > > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > > ---
> > > >   tools/build/Makefile.feature           |  2 +-
> > > >   tools/build/feature/Makefile           |  9 +++++++++
> > > >   tools/build/feature/test-llvm-perf.cpp | 14 ++++++++++++++
> > > >   tools/perf/Makefile.config             |  6 +++---
> > > >   4 files changed, 27 insertions(+), 4 deletions(-)
> > > >   create mode 100644 tools/build/feature/test-llvm-perf.cpp
> > > > 
> > > > diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> > > > index 0717e96d6a0e..427a9389e26c 100644
> > > > --- a/tools/build/Makefile.feature
> > > > +++ b/tools/build/Makefile.feature
> > > > @@ -136,7 +136,7 @@ FEATURE_DISPLAY ?=              \
> > > >            libunwind              \
> > > >            libdw-dwarf-unwind     \
> > > >            libcapstone            \
> > > > -         llvm                   \
> > > > +         llvm-perf              \
> > > 
> > > Hi! Just a quick question, why remove "llvm" from the list, here?
> > > 
> > > Quentin
> > 
> > Just because with respect to the linked fixes: commit, it wasn't
> > actually there before. It was added just for addr2line so it should
> > probably be llvm-perf rather than the generic one.
> > 
> > But yes we can add llvm output if it's useful, but could probably be a
> > separate commit.
 
> It wasn't there before, but you're not removing the rest of the "llvm"
> feature, so I'd expect that part to stay as well? But I don't mind much. We
> use the "llvm" feature in bpftool, but beyond that, I don't personally need
> it to be displayed in tools/build/Makefile.feature, so no need to respin for
> that :)

My worry was that something were being removed because it wasn't being
used in tools/perf/ only to realize later that that was being used
somewhere else in tools/.

That is not the case as you reported, so going back to what we had
before the addr2line llvm code being introduced, i.e.:

commit c3f8644c21df9b7db97eb70e08e2826368aaafa0
Author: Steinar H. Gunderson <sesse@google.com>
Date:   Sat Aug 3 17:20:06 2024 +0200

    perf report: Support LLVM for addr2line()

Just did:

+++ b/tools/build/Makefile.feature
@@ -136,6 +136,7 @@ FEATURE_DISPLAY ?=              \
          libunwind              \
          libdw-dwarf-unwind     \
          libcapstone            \
+         llvm                   \
          zlib                   \
          lzma                   \
          get_cpuid              \

So just displaying whatever was detected, and now we display the new
llvm-perf, so that should be ok, probably even for bpftool, its just
requires a newer version of llvm-dev, right?

- Arnaldo

