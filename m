Return-Path: <bpf+bounces-39485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0260D973DC8
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 349031C25352
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870BE1A2570;
	Tue, 10 Sep 2024 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWMZaZXr"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89611A0734;
	Tue, 10 Sep 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725987203; cv=none; b=qzDfmXrAmm8DnrhLrnmuuiQNKVO5kwg3/LouoVgMKREvFr1+HXWWPeCEQWqz691nlMR+oMAbHvqk3nDP/GKW+kUkrJuF+31PzctcAnZbtwn0Bv9LijlNpqVC7GkC80FYo9avd/QPPez6zOm6XY6pU0OkxoIilX50D1U6DTCnDFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725987203; c=relaxed/simple;
	bh=2Rpn8Njt73fgw3DpGP8vD/PC06yNfALDsBx2YphgNLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHk9Q6ZnEjomp4imXb9aB/bMGbCPWc59uosf3dJNBjVLxfmJq/j2aX1pf8cn6RU308kJlMgPY0FRduWqcHW2iGJG50oygZZAdrMDbjkNf53C27E2Hoq0sss6xUdmxU94Pv2aP03FZO3ltEdP49uZY2lrLXueeWkLwQFoNxc1MQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWMZaZXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0086AC4CEC3;
	Tue, 10 Sep 2024 16:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725987202;
	bh=2Rpn8Njt73fgw3DpGP8vD/PC06yNfALDsBx2YphgNLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dWMZaZXrjxOa5UfU0zNTGeflGVHGoxKjDWGYbqB/N/FZee6+lQ7/X5JRVZc8wEbXF
	 oR7Wr4opmQKKC7N3t0qZFmDw2eZDiQI9f6tHPSvK5vzcXl/PC7IR/81+creMcDPp6t
	 i1kypKi+eNuICldPess4KnvBra2Pu7RqH1ZcFXlb8s3wfAXwV+y33BLlCqS3G2Cs0h
	 KzuAxDt324Tx8+081+QWY8Ci6XCsdftsM0of89hzhribYcrPI48YtNvLWIknTGACgt
	 L+mYBqq0zp6SWGK5lbAc7+ghEbRdaHfM2dItvHNYSxyve9CPdcesWkphFf4Xl9Os07
	 jGSuNnQ2rUGPw==
Message-ID: <b60928c6-19c5-473c-8f13-532ed3fd3b3a@kernel.org>
Date: Tue, 10 Sep 2024 17:53:16 +0100
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
 <b2e813c4-be89-457d-8c38-38849177ec93@kernel.org>
 <307568b9-9b6b-4eaa-973c-8f88538b8545@linaro.org>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <307568b9-9b6b-4eaa-973c-8f88538b8545@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

2024-09-10 16:11 UTC+0100 ~ James Clark <james.clark@linaro.org>
> 
> 
> On 9/10/24 15:27, Quentin Monnet wrote:
>> 2024-09-10 15:04 UTC+0100 ~ James Clark <james.clark@linaro.org>
>>> The new LLVM addr2line feature requires a minimum version of 13 to
>>> compile. Add a feature check for the version so that NO_LLVM=1 doesn't
>>> need to be explicitly added. Leave the existing llvm feature check
>>> intact because it's used by tools other than Perf.
>>>
>>> This fixes the following compilation error when the llvm-dev version
>>> doesn't match:
>>>
>>>    util/llvm-c-helpers.cpp: In function 'char* 
>>> llvm_name_for_code(dso*, const char*, u64)':
>>>    util/llvm-c-helpers.cpp:178:21: error: 
>>> 'std::remove_reference_t<llvm::DILineInfo>' {aka 'struct 
>>> llvm::DILineInfo'} has no member named 'StartAddress'
>>>      178 |   addr, res_or_err->StartAddress ? *res_or_err- 
>>> >StartAddress : 0);
>>>
>>> Fixes: c3f8644c21df ("perf report: Support LLVM for addr2line()")
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/build/Makefile.feature           |  2 +-
>>>   tools/build/feature/Makefile           |  9 +++++++++
>>>   tools/build/feature/test-llvm-perf.cpp | 14 ++++++++++++++
>>>   tools/perf/Makefile.config             |  6 +++---
>>>   4 files changed, 27 insertions(+), 4 deletions(-)
>>>   create mode 100644 tools/build/feature/test-llvm-perf.cpp
>>>
>>> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
>>> index 0717e96d6a0e..427a9389e26c 100644
>>> --- a/tools/build/Makefile.feature
>>> +++ b/tools/build/Makefile.feature
>>> @@ -136,7 +136,7 @@ FEATURE_DISPLAY ?=              \
>>>            libunwind              \
>>>            libdw-dwarf-unwind     \
>>>            libcapstone            \
>>> -         llvm                   \
>>> +         llvm-perf              \
>>
>> Hi! Just a quick question, why remove "llvm" from the list, here?
>>
>> Quentin
> 
> Just because with respect to the linked fixes: commit, it wasn't 
> actually there before. It was added just for addr2line so it should 
> probably be llvm-perf rather than the generic one.
> 
> But yes we can add llvm output if it's useful, but could probably be a 
> separate commit.
> 


It wasn't there before, but you're not removing the rest of the "llvm" 
feature, so I'd expect that part to stay as well? But I don't mind much. 
We use the "llvm" feature in bpftool, but beyond that, I don't 
personally need it to be displayed in tools/build/Makefile.feature, so 
no need to respin for that :)

Thanks,
Quentin

