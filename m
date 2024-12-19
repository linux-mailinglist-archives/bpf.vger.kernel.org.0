Return-Path: <bpf+bounces-47313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0FF9F7943
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 11:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3BFC1896DF7
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 10:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A082C222582;
	Thu, 19 Dec 2024 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f2o6FXGQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E742D433A4
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734603066; cv=none; b=F+hdW6xWkCfRULT/8CxR54iEv4RHsISIHsoBfVSdq4G3A2RfhFmfb4o4zBpEqxU9Me8Gwd1NthSyr7WASczHyi0823ZTXEYobBVFbGDFpshzxCG0RM8FRdyUN3n4ULfflThbxkWuVCa6/GqylxJVKr6YmdZxJmY6o5LIxmqsAzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734603066; c=relaxed/simple;
	bh=U2uamB7nvDggxJyjYA4InvO7fuIdtfjFlCEbaOFWfT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXteXHLcKRZofZnEvnneErfMiQVRjs0j0sBmCFOle2NH2CuPlcW0I1Nq+LM9W0oDfthOwJ11zHNS828cSZIWWpFF0k2y+f29gw3ss9pqnUMNVPB75KiQcgkshiS0M2nV6Q32SPlE87i0dZsoE3dxe/n0JXOLDOxeJXB8M7jLeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f2o6FXGQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-432d86a3085so3916885e9.2
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 02:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734603061; x=1735207861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9u8s/FXYIijQ9RtDony/lgbfJqNEodPUwkBuIae3j3U=;
        b=f2o6FXGQyU7Vr0tjU5WTJUm6RFmMl4S2Di4qRcpW6tfl4gV6jVxLUUbtLVtwB0cGGg
         JJ2NpfsuVtK2HI6HKuXFIutcceeTR8rozCn/IA/xAbPRvv6u85Px1KcMiVUAFZJpDvfE
         BPtR9v+D2taW0lAGsw8wFWPlqseYrPYCN9HZ1Pr7j2JlIVhrMFWTMlHtKs4XEx3+qMH1
         zvWvjJElNRXKtKtU/mR7VNfy2l6smU6NP+0EWLVRcvxI36HDZESOJ57HxwhWdJYnCviO
         QXZ8yARme3hB9ueM1ev2M6TvxsIUbdjCpnjfri73HEIA0uGy9EN8l+kOL66oo9veUXja
         xhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734603061; x=1735207861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9u8s/FXYIijQ9RtDony/lgbfJqNEodPUwkBuIae3j3U=;
        b=DjR3TushTjmZxwBMhU8mRQMP4U9gGkvwjdQW9rGyH69/vSkKAQI41tq2cwcWwAycrB
         PICj/RaNVTX/CHQuoU6jdvZY8xymo0qsKOTBpl2OFfg3Ewg9bLy+752tIrDslIK6xtjx
         yAYh41kUeGkI5hznYwlxI71Xy09AlIDsLLkP3KJiRsrSlysYtQ+iNWyjVgMQZDuHeOqa
         DNBjogAglScHWFFe6PIts4Mb0CEl2npHf0mit9XTgVFB7JtnjUK/Xm5JzOxzWiGu/RBt
         kV0LrGH9NESTSolaRA3Ohyv0gw5IRWOkSxWdWZcSqPJ8VjR1RP9qUe5eFYySq/BHrQCX
         rMGg==
X-Forwarded-Encrypted: i=1; AJvYcCXxNgIzLd2OmCsscBLGc/xVbLvXe61aQjvdX3LcWp+7ae73f3kWzkb/DMvWimk2gMFVESo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw6lHNO2FooVpvGzflQMUrkMOlo/tP8xmKFHaUrvuLdcIH5Eki
	VV6ZFX2PqwFu51SBt/XJGAgU2gSFwiuSelP8I3E3V39Wkfo7ycFHUVxX2hFVwcw=
X-Gm-Gg: ASbGncvQA6egmCmSZECg3QhreL5EJf3nkkPnY07bNyLvZcl+Zo2mZ681GkWELodnYFf
	V9qfiI6LmnPTjFz0SgHnCh5QfHRZC/iiC0HHpi0xIp3f7xxJ3dNt1W3pQSRWpFcp2DOwNj6Tmcx
	L5Hnme57F418CYHge1LLUbUad3qY1Lcg+HkkJgGqFiT8lFSuYWACs5cfw2VaML3MrlPap60x87S
	BU9jqW42x0YvEGq+nPfYmkiidt5jy2lxtjjXoWEuo1AzFundNDdriPvISxviSfgQQU=
X-Google-Smtp-Source: AGHT+IHleph6k9/mQwCrpZsyxPVz/5yDa2XHM6jxz3peZNrApOtdEHBZH0tR130iLzOcT4cQ/NPTfg==
X-Received: by 2002:a05:600c:1c97:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-4365c7c8344mr21521065e9.21.1734603061157;
        Thu, 19 Dec 2024 02:11:01 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364b14f241sm68213505e9.1.2024.12.19.02.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 02:11:00 -0800 (PST)
Message-ID: <4f0bcc19-807c-40b0-a30c-309ba775693b@linaro.org>
Date: Thu, 19 Dec 2024 10:10:59 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] perf docs: arm_spe: Document new discard mode
To: Ian Rogers <irogers@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Graham Woodward <graham.woodward@arm.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241217115610.371755-1-james.clark@linaro.org>
 <20241217115610.371755-6-james.clark@linaro.org>
 <CAP-5=fU7RNzvzxBcAQy3RT9Ge3YtqPhDonupNWS7Wgb8HGQkGg@mail.gmail.com>
 <8c15786c-47b6-47ff-b1dc-ecbf32d582fb@linaro.org>
 <CAP-5=fXV6LXrUtvgRKuyurmu5SoSZLTf6MN=+BBXkqv7drvOjg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXV6LXrUtvgRKuyurmu5SoSZLTf6MN=+BBXkqv7drvOjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/12/2024 7:47 pm, Ian Rogers wrote:
> On Wed, Dec 18, 2024 at 2:07 AM James Clark <james.clark@linaro.org> wrote:
>>
>> On 18/12/2024 12:54 am, Ian Rogers wrote:
>>> On Tue, Dec 17, 2024 at 3:56 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>> Document the flag, hint what it's used for and give an example with
>>>> other useful options to get minimal output.
>>>>
>>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>>> ---
>>>>    tools/perf/Documentation/perf-arm-spe.txt | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
>>>> index de2b0b479249..588eead438bc 100644
>>>> --- a/tools/perf/Documentation/perf-arm-spe.txt
>>>> +++ b/tools/perf/Documentation/perf-arm-spe.txt
>>>> @@ -150,6 +150,7 @@ arm_spe/load_filter=1,min_latency=10/'
>>>>      pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
>>>>      store_filter=1      - collect stores only (PMSFCR.ST)
>>>>      ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
>>>> +  discard=1           - enable SPE PMU events but don't collect sample data - see 'Discard mode' (PMBLIMITR.FM = DISCARD)
>>>>
>>>>    +++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
>>>>    than only the execution latency.
>>>> @@ -220,6 +221,16 @@ Common errors
>>>>
>>>>       Increase sampling interval (see above)
>>>>
>>>> +Discard mode
>>>> +~~~~~~~~~~~~
>>>> +
>>>> +SPE PMU events can be used without the overhead of collecting sample data if
>>>> +discard mode is supported (optional from Armv8.6). First run a system wide SPE
>>>> +session (or on the core of interest) using options to minimize output. Then run
>>>> +perf stat:
>>>> +
>>>> +  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
>>>> +  perf stat -e SAMPLE_FEED_LD
>>>
>>> Perhaps clarify this should be an ARM SPE event? It seems strange to
>>> have one perf command affect a later one, the purpose of things like
>>> event multiplexing is to hide the hardware limits. I'd prefer if the
>>> last bit was like:
>>> ```
>>> Then run perf stat with an SPE event on the same PMU:
>>>
>>> perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
>>> perf stat -e arm_spe/SAMPLE_FEED_LD/
>>> ``
>>>
>>> Thanks,
>>> Ian
>>
>> Hi Ian,
>>
>> Confusingly this isn't an SPE event, it is a normal PMU event. The fact
>> that one Perf command affects the other is because these events only
>> count when SPE is enabled. When it's enabled it has an effect on a
>> per-core level which is why in the example I made it simpler by enabling
>> SPE system wide.
>>
>> SPE is an exclusive PMU like Coresight and some others so it can't be
>> affected by multiplexing or anything like that. The SAMPLE_FEED_LD PMU
>> would be, but as long as SPE stays enabled it will count the right thing
>> regardless of multiplexing.
> 
> Thanks James, sorry for my SPE ignorance. I'm smiling about the use of
> the word exclusive. When I was trying to make the tests run in
> parallel I used a file lock - so shared and exclusive. There were a
> lot of issues with that, hence switching to 2 phases in the test,
> parallel then sequential but I kept the "exclusive" tag for want of a
> better word. Perhaps the notion of an exclusive PMU existed previously

Yeah, see PERF_PMU_CAP_EXCLUSIVE. Hopefully it doesn't cause too much 
confusion, the context of test vs PMU should make it clear.

> but maybe I've accidentally invented the term by way of a failed file
> lock experiment :-)
> 
> Presumably the two PMUs side-effecting each other is a known thing. I
> wonder if we can capture this in the documentation. When you say
> "normal PMU event" you mean core PMU events?
> 
> Thanks,
> Ian

It should be a known thing yes, discard mode doesn't change this 
behavior anyway but just makes one use case of it better. I can add 
another section to this SPE manpage about it in a v2, that's probably 
the best place for it.

And yes, I meant core PMU event. I can clarify that the second example 
command is for a core PMU to avoid any doubt.

Thanks
James


