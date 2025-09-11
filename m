Return-Path: <bpf+bounces-68130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14237B532FF
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DFD7B0BBF
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E98E31E0EA;
	Thu, 11 Sep 2025 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDPyXsm7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42147A13A
	for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595636; cv=none; b=OnihkdhsrNBtwklLh91lT5Xf/lOFAc/Egn2mIRhZgK+/BohekeCkem6H0SddFbzSWaF5LIHv4DR1jX9gOn2wSY4liPbM7WPujGrNpYGtrCuItqodTnE3awSlkKfguTUX+6GI51MX/UfdKL2b/JA4OXkUd8kAxCgxP2PF8xXUbD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595636; c=relaxed/simple;
	bh=Uev9tFJf6el4XASN98rZT8IvrdeNF7D26YWzATU6Rxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gbtPeYvtAylci18I98PmcQEAAQCWa0v0t1C3QlYeTFZceM1IR6CZ0V3uG/WALzDG6P+iHLJ6xJqNikGe9nACvrDDsJHcoxTHgjTZUEPuFponCMG1A3w/1AMqDD6uTx5hiq6BGrhaj2ALckroKnlgTvoZXu68EKDvRjtgr3FkSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XDPyXsm7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3e7428c4cbdso543336f8f.0
        for <bpf@vger.kernel.org>; Thu, 11 Sep 2025 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757595632; x=1758200432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6K02gEkp4FY0AuUQUnIeSmVCDV/i1HbGkotmEzOpyz4=;
        b=XDPyXsm7cAxXWfi+rkQcB1nAEIA4S2QxB6WIHZmb5WH1hal4b06kRL7OuDX1wMoidC
         PulYqDv7wmJWm0VUjdMhXrR1/2Hj9LAnRtC8TAfGkX0+j5ipYThPLlRKVR3OUo5fLwNr
         xEJVu/t1hQJuvNSiHCaBiWrt9oNH5WQurgzwHf3v1N+6E7y6w78THwfEnngRaIS46BQf
         OlwO8KFZz57JD8/lVnoM2H1KJizmgwxpOfOoqa+IfHRDz4Sno3TQXBYTCtvQmXNuAR5b
         WzyQFmMQGu2Quv2It2G31E6xETC3mrE7tzKWmOQffYxSl0rZ6WBqP8dL+81Tyy3U50v3
         Efmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757595632; x=1758200432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6K02gEkp4FY0AuUQUnIeSmVCDV/i1HbGkotmEzOpyz4=;
        b=MYVGRtSSWkuqZBCmiLJGReueYeSI5EqsLci65gGqw0xXfBen2wTl7Y2S24J3Q6Vwh/
         BaCfddApVedHqgyde0IDvdNSkz9s9Da/daSC1be+oWBxhanldHLgJdf/Cr3AWMzgG3xA
         z25NVUbDvqVzveTYCi9Es/flgpwk5QUWTKd6LOyqNdDwLLr/jHwFGkjX9ldh9uVwWr0U
         d6eLFHr5GXNfOeFqw9Ixt1tpqNm0LeYwC7rhV8qXiS08FuVL9ONYcjoIIvBOCOm3pysJ
         Uyi9O79ark+3NDd3RtCp/+KJqPYcRbY6XIa2y6e/TePMZB5Y1TRPJca6CAKpyMDUSq+e
         dHaA==
X-Forwarded-Encrypted: i=1; AJvYcCUIyiU2JrhDucumg3jlVkLdnFV+6ToAm3vBM73rzXqmMTX9rKXcKdpcC/DCvcc2XtYEuuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ43zKXx7UIAA/T7xJ70IpdKvty6PiQC3HD0rm/K1zJBr+pXht
	dqWbBrURbqgXwPAMatMzSX5xdoWCl+Mff3Lz16BuAp60GYmQLom2y9cRLRp+by2KvgY=
X-Gm-Gg: ASbGncsYMGnU1m05Ly2KA+8shuUjd375T2dBOT8UqKbbRTLezzrzMrNTxss0YayI/CK
	kmgJLSUM13hYQC6dLcL1M7cTC1lXG84TzDkocXjzyTfQQg0x8KIbRzXgSb9KIwbSLQwNwI5Ypyb
	ueBTSTWv26k+3nFh/WO6/j6oZVazPgUWqQ1Ucq1GuLPNB4F46QV0QdARWnSzdcs+eyILa8h8+sZ
	uD7MR98CrXpwSRK/USVLPzYAfWN4Q8sRu5HsjX9MMXinuf/zgslpaNjPI5CXMERXnFR5Y5cMO6F
	0GtfSrTVKFePgb2NMavajGEpLCvlkCvYdB5nK8SI1qFrUeX6F+PpSArfE2br2OF7wm34lhNHyZJ
	w87hCA0SEXoDEm+QuOlzoTVk4sG0=
X-Google-Smtp-Source: AGHT+IGq8rqA+k3RKGl/sU6BFCggRB85QSN4RZ9bx5hBV1Bj59utOir0PZkfMb+C5GQLZ6LkmpaYlA==
X-Received: by 2002:a05:6000:178d:b0:3dc:1a9c:2e7f with SMTP id ffacd0b85a97d-3e75e0e51damr2584373f8f.8.1757595631818;
        Thu, 11 Sep 2025 06:00:31 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd691sm2468335f8f.32.2025.09.11.06.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:00:30 -0700 (PDT)
Message-ID: <055e677e-2a2f-4c56-abe0-9a437dc14d69@linaro.org>
Date: Thu, 11 Sep 2025 14:00:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] Legacy hardware/cache events as json
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <20250828205930.4007284-1-irogers@google.com>
 <21d108f2-db8e-457a-bbef-89d18e8d7601@linaro.org>
 <CAP-5=fVbtL=eL5bCFzz06g86Sk3nBsxUmgwZ3c5UY7z5hwmoLA@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVbtL=eL5bCFzz06g86Sk3nBsxUmgwZ3c5UY7z5hwmoLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/09/2025 4:00 pm, Ian Rogers wrote:
> On Wed, Sep 10, 2025 at 4:14 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 28/08/2025 9:59 pm, Ian Rogers wrote:
>>> Mirroring similar work for software events in commit 6e9fa4131abb
>>> ("perf parse-events: Remove non-json software events"). These changes
>>> migrate the legacy hardware and cache events to json.  With no hard
>>> coded legacy hardware or cache events the wild card, case
>>> insensitivity, etc. is consistent for events. This does, however, mean
>>> events like cycles will wild card against all PMUs. A change doing the
>>> same was originally posted and merged from:
>>> https://lore.kernel.org/r/20240416061533.921723-10-irogers@google.com
>>> and reverted by Linus in commit 4f1b067359ac ("Revert "perf
>>> parse-events: Prefer sysfs/JSON hardware events over legacy"") due to
>>> his dislike for the cycles behavior on ARM with perf record. Earlier
>>> patches in this series make perf record event opening failures
>>> non-fatal and hide the cycles event's failure to open on ARM in perf
>>> record, so it is expected the behavior will now be transparent in perf
>>> record on ARM. perf stat with a cycles event will wildcard open the
>>> event on all PMUs.
>>
>> Hi Ian,
>>
>> Briefly testing perf record and perf stat seem to work now. i.e "perf
>> record -e cycles" doesn't fail and just skips the uncore cycles event.
>> And "perf stat" now includes the uncore cycles event which I think is
>> harmless.
> 
> Thanks for confirming this.
> 
>> But there are a few perf test failures. For example "test event parsing":
>>
>>     evlist after sorting/fixing: 'arm_cmn_0/cycles/,{cycles,cache-
>>       misses,branch-misses}'
>>     FAILED tests/parse-events.c:1589 wrong number of entries
>>     Event test failure: test 57 '{cycles,cache-misses,branch-
>>       misses}:e'running test 58 'cycles/name=name/'
> 
> I suspect the easiest fix for this is to change "cycles" to the
> "cpu-cycles" legacy hardware event for this test. The test has always
> had issues on ARM due to hardcoded expectations of the core PMU being
> "cpu".
> 
>> The tests "Perf time to TSC" and "Use a dummy software event to keep
>> tracking" are using libperf to open the cycles event as a sampling event
>> which now fails. It seems like we've fixed Perf record to ignore this
>> failure, but we didn't think about libperf until now.
> 
> I'm not clear on the connection here. libperf doesn't do event parsing
> and so there are no changes in tools/lib/perf. If a test has an
> expectation that "cycles" is a core event, again we can change it to
> "cpu-cycles" as a workaround for ARM. As "cycles" will wildcard now,
> we don't want that behavior in say API probing as we'll end up never
> lazily processing the PMUs. That code has been altered in these
> changes to specify the core PMU. For tests it is less of an issue and
> so the changes are more limited.
> 
> Thanks,
> Ian

Sure makes sense if there's an easy fix for the tests, we can do that. I 
suppose the main reason I mentioned it was that the tests might be 
highlighting that other genuine non-Perf and non-test users would see 
the same breakage though.




