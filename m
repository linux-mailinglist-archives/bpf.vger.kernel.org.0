Return-Path: <bpf+bounces-32091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B722907621
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 17:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B1B01C2355A
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9B11494C5;
	Thu, 13 Jun 2024 15:10:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3B713C691;
	Thu, 13 Jun 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291450; cv=none; b=GiV/NJHFYXHEFoMvWrCHqzVFlgrooCl+ruSP3Ayy4tQRBUp6EvHqcnF4Gjkv9ET1oqqzMBOv3FVJwIJ4m+phRCKHJK5INsc4AXbtcwkbStJXdt8Cf6dx32rqkE2qm90B3hpg1m8NG//0usg4VMHQs1NMLUSO2gCh9siVYM+Ft4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291450; c=relaxed/simple;
	bh=7NXk+p80KoKxvILnhkPLqOnRPGa7Kr/UOYr9kzKZ6zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Os937KiRPWMsZcQMaUFL4yA2hyBpkk67a3hgbGTT1p1jy0o6+HzsScHxaKqoJRUszR9alkbGPWA066lNsxB90m41HLBSJe8ki7otqbRaq5GlIgzaXUZ8a5CHyOlBtP74T9vsubY65lDwZA6beIrVrUnNECX2DE1Q8Rb0/hJd03A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2DB91FEC;
	Thu, 13 Jun 2024 08:11:11 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ADB23F73B;
	Thu, 13 Jun 2024 08:10:41 -0700 (PDT)
Message-ID: <9814866a-8f9d-4d82-ad2d-4b36203aa196@arm.com>
Date: Thu, 13 Jun 2024 16:10:39 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Refactor perf python module build
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Nick Terrell <terrelln@fb.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Kees Cook <keescook@chromium.org>,
 Andrei Vagin <avagin@google.com>, Athira Jajeev
 <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
 coresight@lists.linaro.org, rust-for-linux@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240612183205.3120248-1-irogers@google.com>
 <bdf1ab6e-b887-4182-a0ae-7653bd835907@arm.com> <Zmr_CfhYsvKePZFt@x1>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <Zmr_CfhYsvKePZFt@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/06/2024 15:15, Arnaldo Carvalho de Melo wrote:
> On Thu, Jun 13, 2024 at 10:27:15AM +0100, James Clark wrote:
>> On 12/06/2024 19:31, Ian Rogers wrote:
>>> Refactor the perf python module build to instead of building C files
>>> it links libraries. To support this make static libraries for tests,
>>> ui, util and pmu-events. Doing this allows fewer functions to be
>>> stubbed out, importantly parse_events is no longer stubbed out which
>>> will improve the ability to work with heterogeneous cores.
>>>
>>> Patches 1 to 5 add static libraries for existing parts of the perf
>>> build.
>>>
>>> Patch 6 adds the python build using libraries rather than C source
>>> files.
>>>
>>> Patch 7 cleans up the python dependencies and removes the no longer
>>> needed python-ext-sources.
>>>
>>
>> Reviewed-by: James Clark <james.clark@arm.com>
>>
>> It does require a clean build to avoid some -fPIC errors presumably
>> because not everything that requires it gets rebuilt, for anyone who
>> gets stuck on that.
> 
> We need to find a way to avoid requiring the 'make clean' :-/
> 
> - Arnaldo
>  

Do we need to make it so that if any of the Makefiles are touched it
does a clean? I'm assuming that was the cause of the issue I experienced
here and that the Makefile and/or Build files aren't mentioned as
dependencies of any target.

>>> Ian Rogers (7):
>>>   perf ui: Make ui its own library
>>>   perf pmu-events: Make pmu-events a library
>>>   perf test: Make tests its own library
>>>   perf bench: Make bench its own library
>>>   perf util: Make util its own library
>>>   perf python: Switch module to linking libraries from building source
>>>   perf python: Clean up build dependencies
>>>
>>>  tools/perf/Build                              |  14 +-
>>>  tools/perf/Makefile.config                    |   5 +
>>>  tools/perf/Makefile.perf                      |  66 ++-
>>>  tools/perf/arch/Build                         |   4 +-
>>>  tools/perf/arch/arm/Build                     |   4 +-
>>>  tools/perf/arch/arm/tests/Build               |   8 +-
>>>  tools/perf/arch/arm/util/Build                |  10 +-
>>>  tools/perf/arch/arm64/Build                   |   4 +-
>>>  tools/perf/arch/arm64/tests/Build             |   8 +-
>>>  tools/perf/arch/arm64/util/Build              |  20 +-
>>>  tools/perf/arch/csky/Build                    |   2 +-
>>>  tools/perf/arch/csky/util/Build               |   6 +-
>>>  tools/perf/arch/loongarch/Build               |   2 +-
>>>  tools/perf/arch/loongarch/util/Build          |   8 +-
>>>  tools/perf/arch/mips/Build                    |   2 +-
>>>  tools/perf/arch/mips/util/Build               |   6 +-
>>>  tools/perf/arch/powerpc/Build                 |   4 +-
>>>  tools/perf/arch/powerpc/tests/Build           |   6 +-
>>>  tools/perf/arch/powerpc/util/Build            |  24 +-
>>>  tools/perf/arch/riscv/Build                   |   2 +-
>>>  tools/perf/arch/riscv/util/Build              |   8 +-
>>>  tools/perf/arch/s390/Build                    |   2 +-
>>>  tools/perf/arch/s390/util/Build               |  16 +-
>>>  tools/perf/arch/sh/Build                      |   2 +-
>>>  tools/perf/arch/sh/util/Build                 |   2 +-
>>>  tools/perf/arch/sparc/Build                   |   2 +-
>>>  tools/perf/arch/sparc/util/Build              |   2 +-
>>>  tools/perf/arch/x86/Build                     |   6 +-
>>>  tools/perf/arch/x86/tests/Build               |  20 +-
>>>  tools/perf/arch/x86/util/Build                |  42 +-
>>>  tools/perf/bench/Build                        |  46 +-
>>>  tools/perf/scripts/Build                      |   4 +-
>>>  tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
>>>  .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
>>>  tools/perf/tests/Build                        | 140 +++----
>>>  tools/perf/tests/workloads/Build              |  12 +-
>>>  tools/perf/ui/Build                           |  18 +-
>>>  tools/perf/ui/browsers/Build                  |  14 +-
>>>  tools/perf/ui/tui/Build                       |   8 +-
>>>  tools/perf/util/Build                         | 394 +++++++++---------
>>>  tools/perf/util/arm-spe-decoder/Build         |   2 +-
>>>  tools/perf/util/cs-etm-decoder/Build          |   2 +-
>>>  tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
>>>  tools/perf/util/intel-pt-decoder/Build        |   2 +-
>>>  tools/perf/util/perf-regs-arch/Build          |  18 +-
>>>  tools/perf/util/python-ext-sources            |  53 ---
>>>  tools/perf/util/python.c                      | 271 +++++-------
>>>  tools/perf/util/scripting-engines/Build       |   4 +-
>>>  tools/perf/util/setup.py                      |  33 +-
>>>  49 files changed, 612 insertions(+), 722 deletions(-)
>>>  delete mode 100644 tools/perf/util/python-ext-sources
>>>

