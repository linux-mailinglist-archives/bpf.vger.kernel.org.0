Return-Path: <bpf+bounces-48140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE9A0478E
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815E91611F2
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5731F4704;
	Tue,  7 Jan 2025 17:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJx2u2kJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DA91990A7
	for <bpf@vger.kernel.org>; Tue,  7 Jan 2025 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269605; cv=none; b=pi5CgblC5kSGTMAi37ED01Ozt8uYleSye5Ox2p+dFXoEtSZd4sLLny6HrOX+1jfE/63k1aG4OzfFQT5vv2UgJWiD8+NlxjzwauZkiDrnytxvhMdy7b1Q2JTcEfBgC8JD862JOHwm7+H1X5pV8+4SWFQ2dKhDLA9iCJI0YMQQbd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269605; c=relaxed/simple;
	bh=cG85mQSn2tvsOgfgx58hw2GZFPT2TC0S/Gf68kOxGc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tx9Lh1+13HW0qkeV+LszZj6u7QWTcwPup2eRdlv+Z6RxvrUCvuXHXcyjcURIODjJuJeKA3Ac9nBIS4ot3Ek6DgqE5D9eQOydHx633DFx90VwerQiCNy3bGKUePSDUkPwFB91DzEog2w4HsZ/QwzP0B7lYa9AopDVIafCTgilpJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJx2u2kJ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so164597065e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Jan 2025 09:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736269599; x=1736874399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FebZ9P6+12Y1pdGvG8YjCfJnmD9P3Md0S7Wi20YEeow=;
        b=KJx2u2kJaJeB4kY2t5E7qCAR9h436CtOUGzxBZe9KuU1xnjzCGaovtJ63rO1b99fXX
         Om08ZU0T/Z3vEhtLvMlHrx7rMM3BERa8wC4VO02/khg1Hu4S0fX7OtUYBH6rUymYl6NA
         R+i0GHDwRiVStJWWcTiThVQ7nZekWgXq0X6EnQqAFzeTywDh7T124EdT0u3f0DXCraUL
         lOZkHT66uhpRxnAvqxbS1zBraXaA/IPPhhdaUt/LTDuWxtfg8OcN3XqkTiYfryhAUPK/
         dUk9E1fw10e+MIvLIlNPay1kvyHjHFiPpAX89iP5nOvA7aecEHaSURBciz06i2I/YmfR
         NaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736269599; x=1736874399;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FebZ9P6+12Y1pdGvG8YjCfJnmD9P3Md0S7Wi20YEeow=;
        b=OY5o+PsIRW/VR/e2w/NqT5XlnEEDqmY0+IoHeuZLxa0+wOd/jeVW5Ng578NzqG2gFs
         yR+cRgA10zqKIpo9NbUNtsaTyuDGg3THHLxNCMRRxsQN4Wx7N1PlbnRs1qQRZia7XkZ9
         QBS1wYAE3lk0PycJwlJh6DDjyk0I0g6ypiD8Pl67WidqEr8GNe5HaWoDyN/KND+SY2VT
         uEEfQTkizxh9X6Kje3Chi9k96Dh7ZHgTxbge3E1KrI19LIhzpUq3ebpEaVt07+OngSEU
         wFEVnXph2e+G2TePw3k9osbEbCeWCyHoPSJLcknujAA2jVGcz1DGr/UOWRHGVG760Ge3
         Hpxg==
X-Forwarded-Encrypted: i=1; AJvYcCWvf4ePwvYhjp+KJfYv8Xqm+UuP6fAQ6Vnfn5D0JRTf6oSX6QHYdjulQIfq/F06tVlAgxI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzlaz7y/PX+BFuGiF/QwgnVAFr0lHm+n+JrNZyrOCxx8vtExsKf
	IcBckkce3UEKKdTFonExEMuyH38FY/4NWiVT9HSQOewhh5YVXfrBgKb6Y+9boQQ3vauhg9PYwWj
	6
X-Gm-Gg: ASbGncv8wGzxnfds5Gve8AtclL0HHot8GC8Ir8O2MzWOSn7vToVxOxAPsXm99yfYBoE
	KyZq8leYOlysi6HrS9uME7TUUHeUlkjAlhBhy+92RpXTFudH9t4kaKcaaCKlEApfKXLxAls1vMo
	0wks5gQijn+U9kdnBZG6GetCbzyz3HFhTGKOwGDi+rYKwRhEm/DCb0qO+15M6Pj/v7GDJTqx63s
	LICDKg00RFMr6+7PoZezLZtAUAxK16t9nz/sTUgWQ+xL+FmEBok2ORaZdCIc/J1QJw=
X-Google-Smtp-Source: AGHT+IEKnvyCjDyaByMDpYqtrrjEhFnOjlRLb+BDkfL+K8KFlXEghYmBgWXKY8D8DWnwFOa59sp2rg==
X-Received: by 2002:a05:600c:548e:b0:434:f753:600f with SMTP id 5b1f17b1804b1-436686473c2mr537463105e9.19.1736269599620;
        Tue, 07 Jan 2025 09:06:39 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c4b0sm604284745e9.35.2025.01.07.09.06.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 09:06:39 -0800 (PST)
Message-ID: <3ec56c4b-6dbc-474d-8e31-5a019dc8a044@linaro.org>
Date: Tue, 7 Jan 2025 17:06:37 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tools build: Fix a number of Wconversion warnings
To: Ian Rogers <irogers@google.com>
Cc: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250106215443.198633-1-irogers@google.com>
 <576a50c8-9ca2-4e2f-9bd8-7d9be4862920@linaro.org>
 <CAP-5=fUZ2QCocFKdLfBoNYC-CQfSAcdbA05OhegKmTt_PLR1WA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUZ2QCocFKdLfBoNYC-CQfSAcdbA05OhegKmTt_PLR1WA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/01/2025 4:11 pm, Ian Rogers wrote:
> On Tue, Jan 7, 2025 at 2:33 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 06/01/2025 9:54 pm, Ian Rogers wrote:
>>> There's some expressed interest in having the compiler flag
>>> -Wconversion detect at build time certain kinds of potential problems:
>>> https://lore.kernel.org/lkml/20250103182532.GB781381@e132581.arm.com/
>>>
>>> As feature detection passes -Wconversion from CFLAGS when set, the
>>> feature detection compile tests need to not fail because of
>>> -Wconversion as the failure will be interpretted as a missing
>>> feature. Switch various types to avoid the -Wconversion issue, the
>>> exact meaning of the code is unimportant as it is typically looking
>>> for header file definitions.
>>>
>>> Signed-off-by: Ian Rogers <irogers@google.com>
>>
>> What's the plan for errors in #includes that we can't modify? I noticed
>> the Perl feature test fails with -Wconversion but can be fixed by
>> disabling the warning:
>>
>>     #pragma GCC diagnostic push
>>     #pragma GCC diagnostic ignored "-Wsign-conversion"
>>     #pragma GCC diagnostic ignored "-Wconversion"
>>     #include <EXTERN.h>
>>     #include <perl.h>
>>     #pragma GCC diagnostic pop
>>
>> Not sure why it needs both those things to be disabled when I only
>> enabled -Wconversion, but it does.
> 
> This change lgtm, I'm not sure how others feel. I don't have a plan, I
> was just following up on Leo's Wconversion comment to see what state
> things were in. The feature tests without these changes pretty much
> break the build (I can live without perl support :-) ) so I thought I
> could move things forward there and then see the state of Wconversion
> with the patch I was working on.
> 
> I'm not sure how others feel about fixing Wconversion in perf, the
> errors are quite noisy imo. The biggest issue imo will be with headers
> shared by tools and the kernel, where kernel people may be vocal on
> the merits of Wconversion.
> 

More warnings are better IMO, but I can't say I have any experience with 
that particular one, whether it's too painful to be useful or not.

And if it's going to require those pragmas all over the place to fully 
enable it maybe it's better to leave it off. Just your change without 
the pragmas makes sense for sporadic manual testing though, and we can 
leave libperl disabled.

>>> ---
>>>    tools/build/feature/test-backtrace.c           | 2 +-
>>>    tools/build/feature/test-bpf.c                 | 2 +-
>>>    tools/build/feature/test-glibc.c               | 2 +-
>>>    tools/build/feature/test-libdebuginfod.c       | 2 +-
>>>    tools/build/feature/test-libdw.c               | 2 +-
>>>    tools/build/feature/test-libelf-gelf_getnote.c | 2 +-
>>>    tools/build/feature/test-libelf.c              | 2 +-
>>>    tools/build/feature/test-lzma.c                | 2 +-
>>>    8 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/tools/build/feature/test-backtrace.c b/tools/build/feature/test-backtrace.c
>>> index e9ddd27c69c3..7962fbad6401 100644
>>> --- a/tools/build/feature/test-backtrace.c
>>> +++ b/tools/build/feature/test-backtrace.c
>>> @@ -5,7 +5,7 @@
>>>    int main(void)
>>>    {
>>>        void *backtrace_fns[10];
>>> -     size_t entries;
>>> +     int entries;
>>>
>>>        entries = backtrace(backtrace_fns, 10);
>>>        backtrace_symbols_fd(backtrace_fns, entries, 1);
>>> diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
>>> index 727d22e34a6e..e7a405f83af6 100644
>>> --- a/tools/build/feature/test-bpf.c
>>> +++ b/tools/build/feature/test-bpf.c
>>> @@ -44,5 +44,5 @@ int main(void)
>>>         * Test existence of __NR_bpf and BPF_PROG_LOAD.
>>>         * This call should fail if we run the testcase.
>>>         */
>>> -     return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
>>> +     return syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr)) == 0;
>>
>> Seems a bit weird to invert some of the return values rather than doing
>> != 0, but as you say, the actual values seem to be unimportant.
>>
>> Reviewed-by: James Clark <james.clark@linaro.org>
> 
> Yeah it was arbitrary and I didn't want to add a stdlib.h dependency
> in a bunch of places for the sake of a definition of NULL. I'm happy
> for things to be done differently if people like.
> 
> Thanks,
> Ian


