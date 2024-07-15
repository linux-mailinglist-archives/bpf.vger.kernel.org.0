Return-Path: <bpf+bounces-34804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571FA931141
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 11:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DBEB23A4B
	for <lists+bpf@lfdr.de>; Mon, 15 Jul 2024 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E57186E4A;
	Mon, 15 Jul 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOqyEQw5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2957218629D
	for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721036078; cv=none; b=AOnowNaD1l/h4JO2j/AlKBWVkbCIhEGWkLxeH8llElqsaCPjQpS+nvUBEW1bIm6wDg9ySUtobU1hxK5XVsJbGUCrHV158gGMf8i1DWPCRK1K8J/qCsEtM3W+Q+Km3lbQchsfZZ14wHy/bWvvC2eZjWw8iSiGgTIOL5neunbhKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721036078; c=relaxed/simple;
	bh=DblMVO9aqtwBOIMCDN53DsnDL730cMk8p+6sYaIdXn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uQSMfkb3wJcbMze6SnnKDRbBdHP5nSgabUBgZQoG5uagR3lX3lohrxBIO/n1I2MbjYt4zU8BI4o2NqswI260FtCxl7mKWt5GPtIsWh/E18Kw9EPSEg3wAVNGaJ0waYrmrzIoZ+HT7cghV5e3RSJereRHj7utX4b2q/9ca7dvFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOqyEQw5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3678fbf4a91so2106613f8f.1
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721036074; x=1721640874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pBLMxnI/Lx/pzC7lmwf3CjH7RX4rMxZZVizZMZ5Npc=;
        b=AOqyEQw5MgTpb3RxbgJaLCwYrqucc+Jj9v+BfXhwjp52VeB0y931Cn5A7DvL9K2otd
         18ZFlBFssUiUmKX/IB/eK1uuUIjfQfY1ADNjI2xhsREFnIye0A4YH/jZUCyut3HA+X4z
         lYq/aNZmYqaziK+JHCONeGZOpnK08EI/bQmLiEEgzb9ZuAlaqQAouffIFzOqFQs9Sxoe
         APkXLML+FZWxNz8n2CSjoueCkyT44TsLRfrgvsAxp/2uurnlW/Q5yXUHADA/tczxrMkI
         jQa7HUVsZcS/gF3DYDbffSnmcqvyusUlD3q/k+HutsDUPbbdygEc/pxLtglNMZDpEHYV
         ENPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721036074; x=1721640874;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pBLMxnI/Lx/pzC7lmwf3CjH7RX4rMxZZVizZMZ5Npc=;
        b=jd0iW5jHbcAhLD5VSbJv6F1lmEyv8rHaVUX2bHGW4h3BgypJVmw15b23afzg6EnZ43
         U5WsVSAgQWOHOZz5aUbjDLRg1NvCJJo7ts4GdajI1eZJVkepHK+ZTWDLedxFZ1HwYWIt
         A2aZ3lWpa+2zAisxaxeKMs6+omzGyNqSzbPIu5mLxhcthV4SSSVQmxYRE3rXMLu17BoU
         UDjdSYzo6XzCaUxGGQBlBouHCR2xKCKvJsODqo4mmTCTs/42cFRnrtXxSjMZ5fkHh+Ow
         0qoLYh4b1SlWUPQusNrDjKdMt+721SCWoYiaID/9VqWYJaY7LOKoH5YeNuHKn+QSYUcD
         AzJg==
X-Forwarded-Encrypted: i=1; AJvYcCVffCrzKkBx4YTC3r9DCf90ja7kBYtCM1HF5S87EJHa3i8m8OUjLAb4q/SVIyxf3R/HKNmO/tVjlJU67gMBFdErR85a
X-Gm-Message-State: AOJu0Yxflnpssm3hRkcDQQ80xnmNvwE1j5IOQHcDmWdlWMqFr2B8BDuU
	6+dUZgINzIc6kjQnrjU32BJXLOmbeEdF5hkSqB62aS46pnQt5fWgqOPp9X/u5RA=
X-Google-Smtp-Source: AGHT+IEn0oRguKzoHALO8WTiJyKz1z++WLdzSOTZhpRLkl6K6+sEdmmnoP+hRMHpXQODC9ciJT6E3g==
X-Received: by 2002:adf:fb86:0:b0:367:434f:ca9a with SMTP id ffacd0b85a97d-367ce5df8d6mr12162537f8f.0.1721036074355;
        Mon, 15 Jul 2024 02:34:34 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36816758620sm3377438f8f.19.2024.07.15.02.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 02:34:33 -0700 (PDT)
Message-ID: <c19f822c-a674-4b76-af56-0e3431ef5ea0@linaro.org>
Date: Mon, 15 Jul 2024 10:34:31 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 00/10] perf tools: Fix test "perf probe of function
 from different CU"
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 Namhyung Kim <namhyung@kernel.org>
Cc: anshuman.khandual@arm.com, Josh Poimboeuf <jpoimboe@kernel.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Chenyuan Mi <cymi20@fudan.edu.cn>, Masami Hiramatsu <mhiramat@kernel.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Colin Ian King <colin.i.king@gmail.com>, Changbin Du
 <changbin.du@huawei.com>, Kan Liang <kan.liang@linux.intel.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Alexey Dobriyan <adobriyan@gmail.com>,
 =?UTF-8?Q?Georg_M=C3=BCller?= <georgmueller@gmx.net>,
 Liam Howlett <liam.howlett@oracle.com>, bpf@vger.kernel.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
 <65aaf9bb-ab2c-4185-b5bb-22a717ac7e73@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <65aaf9bb-ab2c-4185-b5bb-22a717ac7e73@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/07/2024 8:39 am, Chaitanya S Prakash wrote:
> Gentle ping, are there any updates on the string clean up patch set?
> 
> On 6/1/24 18:29, Chaitanya S Prakash wrote:
>> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>>
>> Perf treated all files beginning with "/tmp/perf-" as a map file despite
>> them always ending in ".map", this caused the test "perf probe of
>> function from different CU" to fail when Perf was built with NO_DWARF=1.
>> As the file was parsed as a map file, the probe...--funcs command output
>> garbage values instead of listing the functions in the binary. After
>> fixing the issue an additional check to test the output of the
>> probe...--funcs command has been added.
>>
>> Additionally, various functions within the codebase have been refactored
>> and restructured. The definition of str_has_suffix() has been adopted
>> from tools/bpf/bpftool/gen.c and added to tools/lib/string.c in an
>> attempt to make the function more generic. The implementation has been
>> retained but the return values have been modified to resemble that of
>> str_has_prefix(), i.e., return strlen(suffix) on success and 0 on
>> failure. In light of the new addition, "ends_with()", a locally defined
>> function used for checking if a string had a given suffix has been
>> deleted and str_has_suffix() has replaced its usage. A call to
>> strtailcmp() has also been replaced as str_has_suffix() seemed more
>> suited for that particular use case.
>>
>> Finally str_has_prefix() is adopted from the kernel and is added to
>> tools/lib/string.c, following which strstarts() is deleted and its use
>> has been replaced with str_has_prefix().
>>
>> This patch series has been tested on 6.10-rc1 mainline kernel, both on
>> arm64 and x86 platforms.
>>
>> Changes in V3:
>>
>> - Patch adding configs required by "perf probe of function from different
>>    CU" was originally part of the series but has been merged in 6.10-rc1.
>>    
>> https://github.com/torvalds/linux/commit/6b718ac6874c2233b8dec369a8a377d6c5b638e6
>>
>> - Restructure patches according to the maintainer trees.
>> - Add explanation for why '| grep "foo"' is used.
>> - Fix build errors for when perf is built with LLVM=1.
>>
>> Changes in V2:
>> https://lore.kernel.org/all/20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com/
>>
>> - Add str_has_suffix() and str_has_prefix() to tools/lib/string.c
>> - Delete ends_with() and replace its usage with str_has_suffix()
>> - Replace an instance of strtailcmp() with str_has_suffix()
>> - Delete strstarts() from tools/include/linux/string.h and replace its
>>    usage with str_has_prefix()
>>
>> Changes in V1:
>> https://lore.kernel.org/all/20240220042957.2022391-1-ChaitanyaS.Prakash@arm.com/
>>
>> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Cc: James Clark <james.clark@arm.com>
>> Cc: John Garry <john.g.garry@oracle.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Leo Yan <leo.yan@linaro.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Ian Rogers <irogers@google.com>
>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>> Cc: Chenyuan Mi <cymi20@fudan.edu.cn>
>> Cc: Masami Hiramatsu <mhiramat@kernel.org>
>> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
>> Cc: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
>> Cc: Colin Ian King <colin.i.king@gmail.com>
>> Cc: Changbin Du <changbin.du@huawei.com>
>> Cc: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
>> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
>> Cc: Alexey Dobriyan <adobriyan@gmail.com>
>> Cc: Georg Müller <georgmueller@gmx.net>
>> Cc: Liam Howlett <liam.howlett@oracle.com>
>> Cc: bpf@vger.kernel.org
>> Cc: coresight@lists.linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-perf-users@vger.kernel.org
>>
>> Chaitanya S Prakash (10):
>>    tools lib: adopt str_has_suffix() from bpftool/gen.c

LGTM,

Reviewed-by: James Clark <james.clark@arm.com>

The below commit looked like it could be prone to an off by one error 
but I debugged it to confirm that it's ok:

>>    perf util: Delete ends_with() and replace its use with
>>      str_has_suffix()

>>    perf util: Replace an instance of strtailcmp() by str_has_suffix()
>>    tools lib: Adopt str_has_prefix() from kernel
>>    libsubcmd: Replace strstarts() usage with str_has_prefix()
>>    objtool: Replace strstarts() usage with str_has_prefix()
>>    perf tools: Replace strstarts() usage with str_has_prefix()
>>    tools lib: Remove strstarts() as all its usecases have been replaced
>>      by str_has_prefix()
>>    perf tools: Only treat files as map files when they have the extension
>>      .map
>>    perf test: Check output of the probe ... --funcs command
>>
>>   tools/include/linux/string.h                  | 12 ++---
>>   tools/lib/string.c                            | 48 +++++++++++++++++++
>>   tools/lib/subcmd/help.c                       |  2 +-
>>   tools/lib/subcmd/parse-options.c              | 18 +++----
>>   tools/objtool/check.c                         |  2 +-
>>   tools/perf/arch/arm/util/pmu.c                |  4 +-
>>   tools/perf/arch/x86/annotate/instructions.c   | 14 +++---
>>   tools/perf/arch/x86/util/env.c                |  2 +-
>>   tools/perf/builtin-c2c.c                      |  4 +-
>>   tools/perf/builtin-config.c                   |  2 +-
>>   tools/perf/builtin-daemon.c                   |  2 +-
>>   tools/perf/builtin-ftrace.c                   |  2 +-
>>   tools/perf/builtin-help.c                     |  6 +--
>>   tools/perf/builtin-kmem.c                     |  2 +-
>>   tools/perf/builtin-kvm.c                      | 14 +++---
>>   tools/perf/builtin-kwork.c                    | 10 ++--
>>   tools/perf/builtin-lock.c                     |  6 +--
>>   tools/perf/builtin-mem.c                      |  4 +-
>>   tools/perf/builtin-sched.c                    |  6 +--
>>   tools/perf/builtin-script.c                   | 30 ++++--------
>>   tools/perf/builtin-stat.c                     |  4 +-
>>   tools/perf/builtin-timechart.c                |  2 +-
>>   tools/perf/builtin-trace.c                    |  6 +--
>>   tools/perf/perf.c                             | 12 ++---
>>   .../shell/test_uprobe_from_different_cu.sh    |  2 +-
>>   tools/perf/tests/symbols.c                    |  2 +-
>>   tools/perf/ui/browser.c                       |  2 +-
>>   tools/perf/ui/browsers/scripts.c              |  2 +-
>>   tools/perf/ui/stdio/hist.c                    |  2 +-
>>   tools/perf/util/amd-sample-raw.c              |  4 +-
>>   tools/perf/util/annotate.c                    |  2 +-
>>   tools/perf/util/callchain.c                   |  2 +-
>>   tools/perf/util/config.c                      | 12 ++---
>>   tools/perf/util/map.c                         |  8 ++--
>>   tools/perf/util/pmus.c                        |  2 +-
>>   tools/perf/util/probe-event.c                 |  2 +-
>>   tools/perf/util/sample-raw.c                  |  2 +-
>>   tools/perf/util/symbol-elf.c                  |  4 +-
>>   tools/perf/util/symbol.c                      |  3 +-
>>   39 files changed, 148 insertions(+), 117 deletions(-)
>>
> 

