Return-Path: <bpf+bounces-34365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA3192CC11
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 09:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB821C21321
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C859984047;
	Wed, 10 Jul 2024 07:39:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9816582D9A;
	Wed, 10 Jul 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597190; cv=none; b=O8f1RF8jnhe4otyCJ6s7CEl09cXvibwyWuZXh4GEwwxWdOlsJPnchHUXiCGEPrMWC++yyOMKWKxbaTToyIdOE/SE4PUtTSOf1xLfpqqL/g/1RA6Yb7hNWNoagb7UfZ3P6W2KSuk9aDmyhyFPw2ZTDQxQ3EK2EBr0FVThxaFC0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597190; c=relaxed/simple;
	bh=JhMfW57/9iSZh7BVvOYhsv3aSRrroecUv3Uu8fQSAaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyS1XZc5tz/BW91SqdGnAwjgG5Ykvp4UH+uqEcyzz0SdG8XfgQKxf/quRXPSC5hXIFpyrqgPuFpmGv75ChC1YN+Br4KJnQP1YOJfg+89vzZy5JpDnlXtC+7IcwF2CEZDv5Fc70aqxem1zsNqVkBI91su/DKUapmPmbxUD1H2XMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB18113E;
	Wed, 10 Jul 2024 00:40:09 -0700 (PDT)
Received: from [10.162.40.89] (a079740.arm.com [10.162.40.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 897D13F766;
	Wed, 10 Jul 2024 00:39:34 -0700 (PDT)
Message-ID: <65aaf9bb-ab2c-4185-b5bb-22a717ac7e73@arm.com>
Date: Wed, 10 Jul 2024 13:09:26 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/10] perf tools: Fix test "perf probe of function
 from different CU"
To: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc: anshuman.khandual@arm.com, james.clark@arm.com,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Chenyuan Mi <cymi20@fudan.edu.cn>,
 Masami Hiramatsu <mhiramat@kernel.org>, Ravi Bangoria
 <ravi.bangoria@amd.com>,
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Colin Ian King <colin.i.king@gmail.com>, Changbin Du
 <changbin.du@huawei.com>, Kan Liang <kan.liang@linux.intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Alexey Dobriyan <adobriyan@gmail.com>,
 =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>,
 Liam Howlett <liam.howlett@oracle.com>, bpf@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
Content-Language: en-US
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
In-Reply-To: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gentle ping, are there any updates on the string clean up patch set?

On 6/1/24 18:29, Chaitanya S Prakash wrote:
> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>
> Perf treated all files beginning with "/tmp/perf-" as a map file despite
> them always ending in ".map", this caused the test "perf probe of
> function from different CU" to fail when Perf was built with NO_DWARF=1.
> As the file was parsed as a map file, the probe...--funcs command output
> garbage values instead of listing the functions in the binary. After
> fixing the issue an additional check to test the output of the
> probe...--funcs command has been added.
>
> Additionally, various functions within the codebase have been refactored
> and restructured. The definition of str_has_suffix() has been adopted
> from tools/bpf/bpftool/gen.c and added to tools/lib/string.c in an
> attempt to make the function more generic. The implementation has been
> retained but the return values have been modified to resemble that of
> str_has_prefix(), i.e., return strlen(suffix) on success and 0 on
> failure. In light of the new addition, "ends_with()", a locally defined
> function used for checking if a string had a given suffix has been
> deleted and str_has_suffix() has replaced its usage. A call to
> strtailcmp() has also been replaced as str_has_suffix() seemed more
> suited for that particular use case.
>
> Finally str_has_prefix() is adopted from the kernel and is added to
> tools/lib/string.c, following which strstarts() is deleted and its use
> has been replaced with str_has_prefix().
>
> This patch series has been tested on 6.10-rc1 mainline kernel, both on
> arm64 and x86 platforms.
>
> Changes in V3:
>
> - Patch adding configs required by "perf probe of function from different
>    CU" was originally part of the series but has been merged in 6.10-rc1.
>    https://github.com/torvalds/linux/commit/6b718ac6874c2233b8dec369a8a377d6c5b638e6
>
> - Restructure patches according to the maintainer trees.
> - Add explanation for why '| grep "foo"' is used.
> - Fix build errors for when perf is built with LLVM=1.
>
> Changes in V2:
> https://lore.kernel.org/all/20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com/
>
> - Add str_has_suffix() and str_has_prefix() to tools/lib/string.c
> - Delete ends_with() and replace its usage with str_has_suffix()
> - Replace an instance of strtailcmp() with str_has_suffix()
> - Delete strstarts() from tools/include/linux/string.h and replace its
>    usage with str_has_prefix()
>
> Changes in V1:
> https://lore.kernel.org/all/20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com/
>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: James Clark <james.clark@arm.com>
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Chenyuan Mi <cymi20@fudan.edu.cn>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> Cc: Colin Ian King <colin.i.king@gmail.com>
> Cc: Changbin Du <changbin.du@huawei.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Alexey Dobriyan <adobriyan@gmail.com>
> Cc: Georg Müller <georgmueller@gmx.net>
> Cc: Liam Howlett <liam.howlett@oracle.com>
> Cc: bpf@vger.kernel.org
> Cc: coresight@lists.linaro.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org
>
> Chaitanya S Prakash (10):
>    tools lib: adopt str_has_suffix() from bpftool/gen.c
>    perf util: Delete ends_with() and replace its use with
>      str_has_suffix()
>    perf util: Replace an instance of strtailcmp() by str_has_suffix()
>    tools lib: Adopt str_has_prefix() from kernel
>    libsubcmd: Replace strstarts() usage with str_has_prefix()
>    objtool: Replace strstarts() usage with str_has_prefix()
>    perf tools: Replace strstarts() usage with str_has_prefix()
>    tools lib: Remove strstarts() as all its usecases have been replaced
>      by str_has_prefix()
>    perf tools: Only treat files as map files when they have the extension
>      .map
>    perf test: Check output of the probe ... --funcs command
>
>   tools/include/linux/string.h                  | 12 ++---
>   tools/lib/string.c                            | 48 +++++++++++++++++++
>   tools/lib/subcmd/help.c                       |  2 +-
>   tools/lib/subcmd/parse-options.c              | 18 +++----
>   tools/objtool/check.c                         |  2 +-
>   tools/perf/arch/arm/util/pmu.c                |  4 +-
>   tools/perf/arch/x86/annotate/instructions.c   | 14 +++---
>   tools/perf/arch/x86/util/env.c                |  2 +-
>   tools/perf/builtin-c2c.c                      |  4 +-
>   tools/perf/builtin-config.c                   |  2 +-
>   tools/perf/builtin-daemon.c                   |  2 +-
>   tools/perf/builtin-ftrace.c                   |  2 +-
>   tools/perf/builtin-help.c                     |  6 +--
>   tools/perf/builtin-kmem.c                     |  2 +-
>   tools/perf/builtin-kvm.c                      | 14 +++---
>   tools/perf/builtin-kwork.c                    | 10 ++--
>   tools/perf/builtin-lock.c                     |  6 +--
>   tools/perf/builtin-mem.c                      |  4 +-
>   tools/perf/builtin-sched.c                    |  6 +--
>   tools/perf/builtin-script.c                   | 30 ++++--------
>   tools/perf/builtin-stat.c                     |  4 +-
>   tools/perf/builtin-timechart.c                |  2 +-
>   tools/perf/builtin-trace.c                    |  6 +--
>   tools/perf/perf.c                             | 12 ++---
>   .../shell/test_uprobe_from_different_cu.sh    |  2 +-
>   tools/perf/tests/symbols.c                    |  2 +-
>   tools/perf/ui/browser.c                       |  2 +-
>   tools/perf/ui/browsers/scripts.c              |  2 +-
>   tools/perf/ui/stdio/hist.c                    |  2 +-
>   tools/perf/util/amd-sample-raw.c              |  4 +-
>   tools/perf/util/annotate.c                    |  2 +-
>   tools/perf/util/callchain.c                   |  2 +-
>   tools/perf/util/config.c                      | 12 ++---
>   tools/perf/util/map.c                         |  8 ++--
>   tools/perf/util/pmus.c                        |  2 +-
>   tools/perf/util/probe-event.c                 |  2 +-
>   tools/perf/util/sample-raw.c                  |  2 +-
>   tools/perf/util/symbol-elf.c                  |  4 +-
>   tools/perf/util/symbol.c                      |  3 +-
>   39 files changed, 148 insertions(+), 117 deletions(-)
>

