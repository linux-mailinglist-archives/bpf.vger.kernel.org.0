Return-Path: <bpf+bounces-5764-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DCE76012E
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 23:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D29C28143C
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4CD111AD;
	Mon, 24 Jul 2023 21:29:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917C22FB6;
	Mon, 24 Jul 2023 21:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4513C433C7;
	Mon, 24 Jul 2023 21:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690234174;
	bh=fqARBeO4c2YTPeSk975Ka86xirYABo69PGISN4e7vLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3HQrz3JW8g3YO8EdzbLFeYf1mrY/Yawvo/WMzv/qkz0xPca4NstPDjimzDip1S8g
	 nw39gZSxGmRk/c/9EDQOdKC1OGyX0djizdVuLTFy8KdUOepoE2r2QCo6LPi8AD08Hf
	 I5w0NF6wY0diODvSoN3fyDgk+6D5S64SEsHYiv3OB+W2o7cXiOsjJnm0IotuaSmVnJ
	 6ZlSQq/eTQX9HFXKx64wcF/CL79FgOW4P3qpBw22LbkCPDDCgX2G3omtzW7DLv1HNO
	 63kpv6ofoqyMXwxEHg7/ihcB3grujPrtFNhHaB7FDlWXrZRAP344c3DSU2ZU9/Zhkk
	 e3QuQhHl45esQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 22F5240516; Mon, 24 Jul 2023 18:29:31 -0300 (-03)
Date: Mon, 24 Jul 2023 18:29:31 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, Kan Liang <kan.liang@linux.intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Carsten Haitzler <carsten.haitzler@arm.com>,
	Zhengjun Xing <zhengjun.xing@linux.intel.com>,
	James Clark <james.clark@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, maskray@google.com
Subject: Re: [PATCH v1 0/4] Perf tool LTO support
Message-ID: <ZL7tO4pwpfX8n0gZ@kernel.org>
References: <20230724201247.748146-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230724201247.748146-1-irogers@google.com>
X-Url: http://acmel.wordpress.com

Em Mon, Jul 24, 2023 at 01:12:43PM -0700, Ian Rogers escreveu:
> Add a build flag, LTO=1, so that perf is built with the -flto
> flag. Address some build errors this configuration throws up.
> 
> For me on my Debian derived OS, "CC=clang CXX=clang++ LD=ld.lld" works
> fine. With GCC LTO this fails with:
> ```
> lto-wrapper: warning: using serial compilation of 50 LTRANS jobs
> lto-wrapper: note: see the ‘-flto’ option documentation for more information
> /usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel.ro+0x28): undefined reference to `memset_orig'
> /usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel.ro+0x40): undefined reference to `__memset'
> /usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel+0x28): undefined reference to `memcpy_orig'
> /usr/bin/ld: /tmp/ccK8kXAu.ltrans10.ltrans.o:(.data.rel+0x40): undefined reference to `__memcpy'
> /usr/bin/ld: /tmp/ccK8kXAu.ltrans44.ltrans.o: in function `test__arch_unwind_sample':
> /home/irogers/kernel.org/tools/perf/arch/x86/tests/dwarf-unwind.c:72: undefined reference to `perf_regs_load'
> collect2: error: ld returned 1 exit status
> ```
> 
> The issue is that we build multiple .o files in a directory and then
> link them into a .o with "ld -r" (cmd_ld_multi). This early link step
> appears to trigger GCC to remove the .S file definition of the symbol
> and break the later link step (the perf-in.o shows perf_regs_load, for
> example, going from the text section to being undefined at the link
> step which doesn't happen with clang or without LTO). It is possible
> to work around this by taking the final perf link command and adding
> the .o files generated from .S back into it, namely:
> arch/x86/tests/regs_load.o
> bench/mem-memset-x86-64-asm.o
> bench/mem-memcpy-x86-64-asm.o
> 
> A quick performance check and the performance improvements from LTO
> are noticeable:
> 
> Non-LTO
> ```
> $ perf bench internals synthesize
>  # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 202.216 usec (+- 0.160 usec)
>   Average num. events: 51.000 (+- 0.000)
>   Average time per event 3.965 usec
>   Average data synthesis took: 230.875 usec (+- 0.285 usec)
>   Average num. events: 271.000 (+- 0.000)
>   Average time per event 0.852 usec
> ```
> 
> LTO
> ```
> $ perf bench internals synthesize
>  # Running 'internals/synthesize' benchmark:
> Computing performance of single threaded perf event synthesis by
> synthesizing events on the perf process itself:
>   Average synthesis took: 104.530 usec (+- 0.074 usec)
>   Average num. events: 51.000 (+- 0.000)
>   Average time per event 2.050 usec
>   Average data synthesis took: 112.660 usec (+- 0.114 usec)
>   Average num. events: 273.000 (+- 0.000)
>   Average time per event 0.413 usec


Cool stuff! Applied locally, test building now on the container suite.

- Arnaldo

> ```
> 
> Ian Rogers (4):
>   perf stat: Avoid uninitialized use of perf_stat_config
>   perf parse-events: Avoid use uninitialized warning
>   perf test: Avoid weak symbol for arch_tests
>   perf build: Add LTO build option
> 
>  tools/perf/Makefile.config      |  5 +++++
>  tools/perf/tests/builtin-test.c | 11 ++++++++++-
>  tools/perf/tests/stat.c         |  2 +-
>  tools/perf/util/parse-events.c  |  2 +-
>  tools/perf/util/stat.c          |  2 +-
>  5 files changed, 18 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0.487.g6d72f3e995-goog
> 

-- 

- Arnaldo

