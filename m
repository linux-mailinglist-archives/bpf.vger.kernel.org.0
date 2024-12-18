Return-Path: <bpf+bounces-47225-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD79F625E
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 11:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F231C164A8A
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46A41991AF;
	Wed, 18 Dec 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fK61+wwn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D964165F16
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516471; cv=none; b=uTTY7ezCZm9vUkZfS059Xzo3GSSwIYhWDugQpTGBgQ2XVxxgay3jwak8q0O35pc0CvH/OaW95PQwSiSFk/Yz8anxnX4m5UAcjRxnwGJ4TapFy15p0gSp35preyEtwaqkB5Us+EzFFCqcuMr8KbH6J79FrKBk4CoMWJ8Z6F4jNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516471; c=relaxed/simple;
	bh=EpOaBBpI2gBsXs78FbOMCk5NItVWAikaDlLzqWmHknY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NepVfdPtkj0erMTMRiFRBnMIkzwksTR7l9V8ZoeBlvOTboLasFSvdRzyqqQkPsW1YSBBdvHw+tamEDX7/KUUFEuWafBngVtIhM6YtUCP/LDHnNpWiXBHNdEItlBuNzYw+SzjGv5WdhTmotbpZy6QNFqO74Xj/29kU2bhSkVWsjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fK61+wwn; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43624b2d453so68738685e9.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 02:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734516468; x=1735121268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9P17ieee9B5SlwZSInMZgc5AL5v6w0qOBx6blK3MkC8=;
        b=fK61+wwnjMKKqIRMlYijdPFT2/2FDPUJ1+dYtcqecA0XYsAQIqIHcPgRYTme2nMzea
         HUYiILhc399bG6BHkxlV1TSVhnWdFXjAsRbO3kga1d8jmwvm5eVYltdW5Rf3kxj9F3CN
         tXvlubL6bYkaEnvQ5LR+MX8YaqaFO4dSgiAloGzgLYC7gWE18SPq56KV63Y6fAxbQuPN
         4boT+1G2LWCvNGoWJfbOlzW+qtf2nNlVEXzRirRggmmip/MtYz9aeS2E/e0wEQSqwX0r
         +7g6lcaxcji10wXtaX92J+pIE6EiX8IePuVbJD2OINeK8mE5IBk49lQotbiKZOnArQOh
         Sj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516468; x=1735121268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9P17ieee9B5SlwZSInMZgc5AL5v6w0qOBx6blK3MkC8=;
        b=A4byHoKEOrVKjIjNMei5acZuJLcall6zkOu/34iZbZ5bOjXDgxCWKyNZr2vmSxBfi3
         +7foJ361mGihxsjzwayf93yVbwshqPCGozR++JpUT0gXoaGlmxJVhGOq77EKyDA3waYI
         7sg50fSGuPrvMmhV0TVVSzOPu0+wrRJAYl3+LME3z/naTjwTm4rqInfJDAXHqNioczmX
         af3C6IUdiHv+obHue62edovw0dVzYrwS3cLTqOmdqQd2ldG7HMthlg5KR9fnb2o2/lan
         LnOMo7rtBY4ITqexfe9D0BV8FXX/2TpiftqmfEXAMANPr3xNyOhJs4+LFwa+8vdDl90C
         dSqg==
X-Forwarded-Encrypted: i=1; AJvYcCWMZAlrPmq6Dhqi1pdhJE3UarqAwcv8NlZ6ktLXX3LvwWi+Jb7urvk/lOQERQiV3up8LDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqeQbypomNQ25us6TIWUtnwCnt+t7JYkpE6G7SvQtOvc9XuwNO
	BtQHa8ZCrY4F135GUcj7LJYq5ODKIqf9mbOhJzQQie75aVqSQ4c3O4RiKmhx2Ys=
X-Gm-Gg: ASbGnctqqPVVQERjZi3rNLk6UAns83FbKmk4WM2Tnby6l5hJfDQVw266sgW0Fi6GMmB
	Ed3mhWCKegjrKlK3WCWZldwzETEiVCfak3o13o9tGK9CFVkLqT7/AqhbzAn3vGDpZEMuDlFFna5
	Aece/DiyAXv1pFj9ZII+x8AkNyKQih087Rm0dYpzg9F25OF83o5BYAs2e3sFOaYtHamPOQ/teZ7
	LlMhdVzDo66NYs6WeliVpmNfNknB7nPvzODPx900FTj408LxAypJ7XcWgzYT6CjXeE=
X-Google-Smtp-Source: AGHT+IHC2RZ1yHVWgEcKRYnXsTSt7w3TIR3YVn7d27iergCOQv1IMX81+xjenYwudQOzwGcr5LlErg==
X-Received: by 2002:a05:600c:3b14:b0:434:fec5:4ed1 with SMTP id 5b1f17b1804b1-436553fe571mr14370955e9.26.1734516467662;
        Wed, 18 Dec 2024 02:07:47 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80613a9sm13518151f8f.101.2024.12.18.02.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 02:07:47 -0800 (PST)
Message-ID: <8c15786c-47b6-47ff-b1dc-ecbf32d582fb@linaro.org>
Date: Wed, 18 Dec 2024 10:07:45 +0000
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fU7RNzvzxBcAQy3RT9Ge3YtqPhDonupNWS7Wgb8HGQkGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/12/2024 12:54 am, Ian Rogers wrote:
> On Tue, Dec 17, 2024 at 3:56 AM James Clark <james.clark@linaro.org> wrote:
>>
>> Document the flag, hint what it's used for and give an example with
>> other useful options to get minimal output.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   tools/perf/Documentation/perf-arm-spe.txt | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Documentation/perf-arm-spe.txt
>> index de2b0b479249..588eead438bc 100644
>> --- a/tools/perf/Documentation/perf-arm-spe.txt
>> +++ b/tools/perf/Documentation/perf-arm-spe.txt
>> @@ -150,6 +150,7 @@ arm_spe/load_filter=1,min_latency=10/'
>>     pct_enable=1        - collect physical timestamp instead of virtual timestamp (PMSCR.PCT) - requires privilege
>>     store_filter=1      - collect stores only (PMSFCR.ST)
>>     ts_enable=1         - enable timestamping with value of generic timer (PMSCR.TS)
>> +  discard=1           - enable SPE PMU events but don't collect sample data - see 'Discard mode' (PMBLIMITR.FM = DISCARD)
>>
>>   +++*+++ Latency is the total latency from the point at which sampling started on that instruction, rather
>>   than only the execution latency.
>> @@ -220,6 +221,16 @@ Common errors
>>
>>      Increase sampling interval (see above)
>>
>> +Discard mode
>> +~~~~~~~~~~~~
>> +
>> +SPE PMU events can be used without the overhead of collecting sample data if
>> +discard mode is supported (optional from Armv8.6). First run a system wide SPE
>> +session (or on the core of interest) using options to minimize output. Then run
>> +perf stat:
>> +
>> +  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
>> +  perf stat -e SAMPLE_FEED_LD
> 
> Perhaps clarify this should be an ARM SPE event? It seems strange to
> have one perf command affect a later one, the purpose of things like
> event multiplexing is to hide the hardware limits. I'd prefer if the
> last bit was like:
> ```
> Then run perf stat with an SPE event on the same PMU:
> 
> perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/null &
> perf stat -e arm_spe/SAMPLE_FEED_LD/
> ``
> 
> Thanks,
> Ian

Hi Ian,

Confusingly this isn't an SPE event, it is a normal PMU event. The fact 
that one Perf command affects the other is because these events only 
count when SPE is enabled. When it's enabled it has an effect on a 
per-core level which is why in the example I made it simpler by enabling 
SPE system wide.

SPE is an exclusive PMU like Coresight and some others so it can't be 
affected by multiplexing or anything like that. The SAMPLE_FEED_LD PMU 
would be, but as long as SPE stays enabled it will count the right thing 
regardless of multiplexing.

THanks
James




