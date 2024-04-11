Return-Path: <bpf+bounces-26573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092998A1EE5
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 20:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768A51F2BAAA
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 18:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47989205E26;
	Thu, 11 Apr 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2W3Q1ny"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DBA205E1A;
	Thu, 11 Apr 2024 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861357; cv=none; b=FwDO4zfOW126CtMreS2DzCCSnTTa19apaDK7Kkn3+ZxWd7LwyUllnwXpfAXLsmTmR21MHv2ndYVTIjMW/iZTP+d9q7PpO/jbLeDSH1VsaYhVCP/pHb7HF4e5/rzOF3SxRCYCU7StHL9dMuuOhB7T56C0lZwTriTO2PkVyutaek4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861357; c=relaxed/simple;
	bh=btwZaBB3O9DOzxIGcntkdcZ7k2hqJhPj4ghH4mNe4wI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fh3hjxSJiB13Ys28L0i/d3CbyDCHb9QO9xg3n9KAmdevlLZeLxEzJkUT/fl+E4Nf/csrxZiUlUkg8skRmrx1KEKPSuwFOB++sfBJLkX8SZSqfPjtmHTDS9HF3vEbxAqjKy90+U2aNCku7u51gTSt1pnb3DTUbAOyV6qPPQNfWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2W3Q1ny; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8303C072AA;
	Thu, 11 Apr 2024 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712861357;
	bh=btwZaBB3O9DOzxIGcntkdcZ7k2hqJhPj4ghH4mNe4wI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2W3Q1nyYJoRhVUzyfO7KeSpslkVglnHq4a+t58aP1VscgX7VnvdVTGZCQHnlzDiu
	 ++OnT6u2y7tZdWX7n+XgsOYV/6pWXiX4wnHXq+onQQuvN8GFR5u8UyXPPct8UKE7dH
	 0Yf6y5B5dnPAzysyLsrdyZhgQ8G5WT4fo0PoQ29R6CJOdoai4PpCcbx4FW1IkLXJjj
	 fHxph836LAUmTHa1csrZvxMWJPy7HG/mWM7Dot7bJij5xvh7gFKywEGUgWwXGnQkF1
	 hm1XZndryuBU9F+YRwPUbuH4TLdmUyvkKip8UOCtpmx+SH+u4iIfTLFoiTn3Z4v1GK
	 NeRag66+FEHHA==
Date: Thu, 11 Apr 2024 15:49:14 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
	james.clark@arm.com, Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Chenyuan Mi <cymi20@fudan.edu.cn>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Colin Ian King <colin.i.king@gmail.com>,
	Changbin Du <changbin.du@huawei.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Georg =?iso-8859-1?Q?M=FCller?= <georgmueller@gmx.net>,
	Liam Howlett <liam.howlett@oracle.com>, bpf@vger.kernel.org,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/8] perf tools: Fix test "perf probe of function from
 different CU"
Message-ID: <Zhgwqisn3A2GMFpU@x1>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>

On Mon, Apr 08, 2024 at 11:52:22AM +0530, Chaitanya S Prakash wrote:
> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> Defconfig doesn't provide all the necessary configs required for the
> test "perf probe of function from different CU" to run successfully on
> all platforms. Therefore the required configs have been added to
> config fragments to resolve this issue. On further investigation it was
> seen that the Perf treated all files beginning with "/tmp/perf-" as a
> map file despite them always ending in ".map", this caused the test to
> fail when Perf was built with NO_DWARF=1. As the file was parsed as a
> map file, the probe...--funcs command output garbage values instead of
> listing the functions in the binary. After fixing the issue an
> additional check to test the output of the probe...--funcs command has
> been added.
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
> This patch series has been tested on 6.9-rc2 mainline kernel, both on
> arm64 and x86 platforms.
> 
> Changes in V2:
> - Add str_has_suffix() and str_has_prefix() to tools/lib/string.c
> - Delete ends_with() and replace its usage with str_has_suffix()
> - Replace an instance of strtailcmp() with str_has_suffix()
> - Delete strstarts() from tools/include/linux/string.h and replace its
>   usage with str_has_prefix()
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
> Chaitanya S Prakash (8):
>   tools lib: adopt str_has_suffix() from bpftool/gen.c
>   perf util: Delete ends_with() and replace its use with
>     str_has_suffix()
>   perf util: Replace an instance of strtailcmp() by str_has_suffix()
>   tools lib: Adopt str_has_prefix() from kernel
>   tools: Delete strstarts() and replace its usage with str_has_prefix()
>   perf tools: Enable configs required for
>     test_uprobe_from_different_cu.sh
>   perf tools: Only treat files as map files when they have the extension
>     .map
>   perf test: Check output of the probe ... --funcs command
> 
>  tools/include/linux/string.h                  | 12 ++----
>  tools/lib/string.c                            | 42 +++++++++++++++++++
>  tools/lib/subcmd/help.c                       |  2 +-
>  tools/lib/subcmd/parse-options.c              | 18 ++++----
>  tools/objtool/check.c                         |  2 +-

Try not mixing things that are maintained by different people into the
same patch kit, for instance, in my case its failing with:

Cover: ./v2_20240408_chaitanyas_prakash_perf_tools_fix_test_perf_probe_of_function_from_different_cu.cover
 Link: https://lore.kernel.org/r/20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com
 Base: not specified
       git am ./v2_20240408_chaitanyas_prakash_perf_tools_fix_test_perf_probe_of_function_from_different_cu.mbx
⬢[acme@toolbox perf-tools-next]$        git am ./v2_20240408_chaitanyas_prakash_perf_tools_fix_test_perf_probe_of_function_from_different_cu.mbx
Applying: tools lib: adopt str_has_suffix() from bpftool/gen.c
Applying: perf util: Delete ends_with() and replace its use with str_has_suffix()
Applying: perf util: Replace an instance of strtailcmp() by str_has_suffix()
Applying: tools lib: Adopt str_has_prefix() from kernel
Applying: tools: Delete strstarts() and replace its usage with str_has_prefix()
error: patch failed: tools/objtool/check.c:2535
error: tools/objtool/check.c: patch does not apply
Patch failed at 0005 tools: Delete strstarts() and replace its usage with str_has_prefix()
hint: Use 'git am --show-current-patch=diff' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
⬢[acme@toolbox perf-tools-next]$

So I'm checking if removing the objtool part makes this work.

- Arnaldo

>  tools/perf/arch/arm/util/pmu.c                |  4 +-
>  tools/perf/arch/x86/annotate/instructions.c   | 14 +++----
>  tools/perf/arch/x86/util/env.c                |  2 +-
>  tools/perf/builtin-c2c.c                      |  4 +-
>  tools/perf/builtin-config.c                   |  2 +-
>  tools/perf/builtin-daemon.c                   |  2 +-
>  tools/perf/builtin-ftrace.c                   |  2 +-
>  tools/perf/builtin-help.c                     |  6 +--
>  tools/perf/builtin-kmem.c                     |  2 +-
>  tools/perf/builtin-kvm.c                      | 14 +++----
>  tools/perf/builtin-kwork.c                    | 10 ++---
>  tools/perf/builtin-lock.c                     |  6 +--
>  tools/perf/builtin-mem.c                      |  4 +-
>  tools/perf/builtin-sched.c                    |  6 +--
>  tools/perf/builtin-script.c                   | 30 ++++---------
>  tools/perf/builtin-stat.c                     |  4 +-
>  tools/perf/builtin-timechart.c                |  2 +-
>  tools/perf/builtin-trace.c                    |  6 +--
>  tools/perf/perf.c                             | 12 +++---
>  tools/perf/tests/config-fragments/config      |  3 ++
>  .../shell/test_uprobe_from_different_cu.sh    |  2 +-
>  tools/perf/tests/symbols.c                    |  2 +-
>  tools/perf/ui/browser.c                       |  2 +-
>  tools/perf/ui/browsers/scripts.c              |  2 +-
>  tools/perf/ui/stdio/hist.c                    |  2 +-
>  tools/perf/util/amd-sample-raw.c              |  4 +-
>  tools/perf/util/annotate.c                    |  2 +-
>  tools/perf/util/callchain.c                   |  2 +-
>  tools/perf/util/config.c                      | 12 +++---
>  tools/perf/util/map.c                         |  8 ++--
>  tools/perf/util/pmus.c                        |  2 +-
>  tools/perf/util/probe-event.c                 |  2 +-
>  tools/perf/util/sample-raw.c                  |  2 +-
>  tools/perf/util/symbol-elf.c                  |  4 +-
>  tools/perf/util/symbol.c                      |  4 +-
>  40 files changed, 146 insertions(+), 117 deletions(-)
> 
> -- 
> 2.30.2
> 
> 

