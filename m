Return-Path: <bpf+bounces-32089-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0AB9074E4
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12A631C2167E
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 14:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDAD14534B;
	Thu, 13 Jun 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+MGreyN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF510F1;
	Thu, 13 Jun 2024 14:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288143; cv=none; b=I/LXOhLkejtTXG0ZgwywcQQhwEwEkHVuwYSdHH+5hsVMAPyAkYBh9LlLmgDJ84XZEs5xJzUKo/WEPyktEvoK+PNPxEJFgZCpPfMuMXa/2tUDnXrBvb7J7CSM8YbHE3r4wlt2mn8aavlUTv6cPNo0uOqdKu+LwiE7AX667icojxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288143; c=relaxed/simple;
	bh=JzDvvJIFsoEa8Pp8qeuXMOIfuGTZA2pY6sCk2zTKjoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWirorQgDcLZRe7ruvxGvRn35k8Xt9W82r2gw2msw6AiJP3Yit2dbjOOhVEy0J4iH38FgkPSsj3Vriniwz+eZCalPKz3N+qZ6Ru14+CXmWXJtesAFngC5ICXZCxFLPntg7ydaKoZCezoxO4lJcKpj/T8hKeSG8iQ+GNz7BqNIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+MGreyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB66CC2BBFC;
	Thu, 13 Jun 2024 14:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718288142;
	bh=JzDvvJIFsoEa8Pp8qeuXMOIfuGTZA2pY6sCk2zTKjoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c+MGreyNpxLjoAxhXsbjTrGiU1ZiPyaiegSPRV4Pnh1kzeM1z2qs69/qzeNLEN9Zl
	 eXWi/qnxmfvJR9zLgQlFgddLCCOnXIWsBIBVq7TeeQFf0t1fN6QAmjO5WIRAv/dBMl
	 TuPrmVQifdEhwNF+s9/mNTt1vaXjf+g1UbCqT9ebYbIF3pfKPvjVccIPTxqXWeG1VL
	 tJN9Z16KipjklAv9syKzfciXDEgM/+nMFzcdv9XP33gfgUOICDHyE6nkDg81ordhIy
	 8q3rbHRx2voGajA9vsaty6RlNzwoa7s/icxWGNjLgYiYJgnu2jvldp03BSixKLnifw
	 SzDji6l+ihKlg==
Date: Thu, 13 Jun 2024 11:15:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Nick Terrell <terrelln@fb.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org, coresight@lists.linaro.org,
	rust-for-linux@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v1 0/7] Refactor perf python module build
Message-ID: <Zmr_CfhYsvKePZFt@x1>
References: <20240612183205.3120248-1-irogers@google.com>
 <bdf1ab6e-b887-4182-a0ae-7653bd835907@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdf1ab6e-b887-4182-a0ae-7653bd835907@arm.com>

On Thu, Jun 13, 2024 at 10:27:15AM +0100, James Clark wrote:
> On 12/06/2024 19:31, Ian Rogers wrote:
> > Refactor the perf python module build to instead of building C files
> > it links libraries. To support this make static libraries for tests,
> > ui, util and pmu-events. Doing this allows fewer functions to be
> > stubbed out, importantly parse_events is no longer stubbed out which
> > will improve the ability to work with heterogeneous cores.
> > 
> > Patches 1 to 5 add static libraries for existing parts of the perf
> > build.
> > 
> > Patch 6 adds the python build using libraries rather than C source
> > files.
> > 
> > Patch 7 cleans up the python dependencies and removes the no longer
> > needed python-ext-sources.
> > 
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> 
> It does require a clean build to avoid some -fPIC errors presumably
> because not everything that requires it gets rebuilt, for anyone who
> gets stuck on that.

We need to find a way to avoid requiring the 'make clean' :-/

- Arnaldo
 
> > Ian Rogers (7):
> >   perf ui: Make ui its own library
> >   perf pmu-events: Make pmu-events a library
> >   perf test: Make tests its own library
> >   perf bench: Make bench its own library
> >   perf util: Make util its own library
> >   perf python: Switch module to linking libraries from building source
> >   perf python: Clean up build dependencies
> > 
> >  tools/perf/Build                              |  14 +-
> >  tools/perf/Makefile.config                    |   5 +
> >  tools/perf/Makefile.perf                      |  66 ++-
> >  tools/perf/arch/Build                         |   4 +-
> >  tools/perf/arch/arm/Build                     |   4 +-
> >  tools/perf/arch/arm/tests/Build               |   8 +-
> >  tools/perf/arch/arm/util/Build                |  10 +-
> >  tools/perf/arch/arm64/Build                   |   4 +-
> >  tools/perf/arch/arm64/tests/Build             |   8 +-
> >  tools/perf/arch/arm64/util/Build              |  20 +-
> >  tools/perf/arch/csky/Build                    |   2 +-
> >  tools/perf/arch/csky/util/Build               |   6 +-
> >  tools/perf/arch/loongarch/Build               |   2 +-
> >  tools/perf/arch/loongarch/util/Build          |   8 +-
> >  tools/perf/arch/mips/Build                    |   2 +-
> >  tools/perf/arch/mips/util/Build               |   6 +-
> >  tools/perf/arch/powerpc/Build                 |   4 +-
> >  tools/perf/arch/powerpc/tests/Build           |   6 +-
> >  tools/perf/arch/powerpc/util/Build            |  24 +-
> >  tools/perf/arch/riscv/Build                   |   2 +-
> >  tools/perf/arch/riscv/util/Build              |   8 +-
> >  tools/perf/arch/s390/Build                    |   2 +-
> >  tools/perf/arch/s390/util/Build               |  16 +-
> >  tools/perf/arch/sh/Build                      |   2 +-
> >  tools/perf/arch/sh/util/Build                 |   2 +-
> >  tools/perf/arch/sparc/Build                   |   2 +-
> >  tools/perf/arch/sparc/util/Build              |   2 +-
> >  tools/perf/arch/x86/Build                     |   6 +-
> >  tools/perf/arch/x86/tests/Build               |  20 +-
> >  tools/perf/arch/x86/util/Build                |  42 +-
> >  tools/perf/bench/Build                        |  46 +-
> >  tools/perf/scripts/Build                      |   4 +-
> >  tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
> >  .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
> >  tools/perf/tests/Build                        | 140 +++----
> >  tools/perf/tests/workloads/Build              |  12 +-
> >  tools/perf/ui/Build                           |  18 +-
> >  tools/perf/ui/browsers/Build                  |  14 +-
> >  tools/perf/ui/tui/Build                       |   8 +-
> >  tools/perf/util/Build                         | 394 +++++++++---------
> >  tools/perf/util/arm-spe-decoder/Build         |   2 +-
> >  tools/perf/util/cs-etm-decoder/Build          |   2 +-
> >  tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
> >  tools/perf/util/intel-pt-decoder/Build        |   2 +-
> >  tools/perf/util/perf-regs-arch/Build          |  18 +-
> >  tools/perf/util/python-ext-sources            |  53 ---
> >  tools/perf/util/python.c                      | 271 +++++-------
> >  tools/perf/util/scripting-engines/Build       |   4 +-
> >  tools/perf/util/setup.py                      |  33 +-
> >  49 files changed, 612 insertions(+), 722 deletions(-)
> >  delete mode 100644 tools/perf/util/python-ext-sources
> > 

