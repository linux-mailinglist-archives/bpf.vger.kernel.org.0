Return-Path: <bpf+bounces-48235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829BEA057A0
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 11:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAD6162668
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2025 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786FC1F76C7;
	Wed,  8 Jan 2025 10:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mYXutmIW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADA71F2361
	for <bpf@vger.kernel.org>; Wed,  8 Jan 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330903; cv=none; b=PPvHOICs25RoDIV3PI8HylgvrndCIxLvsVqhDg6ksZjp5cVwjWZOumMpTuthcWPTZtZDrhzQ+Y6xXcll+ZSQR9LRBxy9GC3BQHmKzSt1lpw7fykQVOBl90GH3MBvT8vMQ/PQFPOig8JxCfjI86uSAv2IXvlPYCq+C1MD8kw9Yug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330903; c=relaxed/simple;
	bh=O1LT66HGYw2JwtyHTynUEGAnjLq5x1K99vutGXXKDK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W7I/AS6OTTtJupzlwLpaOucfGC2pW3bwYkFWPcM9u2MapJDT10tIPPUQ0HUEMkqOHfjAfeoA9mW87fYhmm6sL6nNo71kScR2bKzMymkBWmsdI17IZ0nVaYOV7T9UVPB8YiUYVSVQ5vjrluX51/dDkvrERqpiv8GTsapERfU1mTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mYXutmIW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso110566085e9.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2025 02:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736330899; x=1736935699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YjY6+zjtyOIX1iyK/8QhOIQrcr0euu2ifQ2NruT64Tw=;
        b=mYXutmIW2/hWG9PIWs9MIGURAkNux2eajHHalqDUgWN5IcYdOA5nY9kJ4v2bj7c+Z6
         wGoDoSkc/2Zvmbv7N+1Njy/M5Vhr8fkj9LMshk8z4ulJSGYrrf1p1NArFn+MHvz3Jb4f
         lEXsOZVcOSY7UVPeVjskRLpyYznapdrShUV5VxU3iEDINHWy1FhTQ/+XKg7s/RJochFV
         OZZ5V12z2BmlYdWqn8I9anEezp5utvhvHYrdHwcEYjgPilbgZlBy8gxs1cjkPOnDTrQZ
         U8t6YT5oF0pw2/uePzAuPAwUZqs1c1VM68Zjb5NFLSZ/1ORDPpL3azNt0M0HYuc5iwIO
         OAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736330899; x=1736935699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YjY6+zjtyOIX1iyK/8QhOIQrcr0euu2ifQ2NruT64Tw=;
        b=Hgsp9mIa/xpxWPp5U6zi1UbFahHGudlBl1l4GHygW78oL9tF3GDn9g3N65H2Phwa8d
         2K5kekqw8FF2EYEwZz+U9uuJDQZZcZ76ta/YdGGBol/88ar1IiGyu7rWw8v+QB2BRn08
         m5m4Y7+70ScQddQMjtVWEMc+4qOJ1n3J5uICGshw/rhnMbeunEEUttljebn1qfLRn2kL
         b58+CNiUw+7ef3gdym9xeAYFe+kg7neVoJmg6M1DSWucR3CNnE5xNllyWtBahWjZkVOx
         fIUSzOhXGCQiQoWNrLHtD4IF956gX2PtBV/K9ziXb5WWWQBSwH5/HIq77PUH5Bak+sr6
         MDsg==
X-Forwarded-Encrypted: i=1; AJvYcCX8g4Pfar+z1srZ7cTPfJCclVWXSOXkxrGYg8TxGBnGTqc4Uch0GdL8eQhsDoLO7FAiWuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuhtTGd28YqtPoMmLe3KoQOXiuTtz6Q+sPxOvfdcVKLtyowAG
	YIN6BcWl50Jm3nmCSu1+5VRZ5MngtLKDSN783lgmo1xa2PMsjHMrufF6vrEW3Es=
X-Gm-Gg: ASbGncv0lKAq0jPoSb6O3f4Q70pMaSGa87HgyJfsp7jQlIeyApb+1h3ix9vXso/KspK
	nezlK2sETTF2yMREYA4QdvAUSsomLh/Ob//HNnsXtfQ8lhQxk7MWSOX14SFwXxdjrTOVOr8g4vl
	rEnHF1kMfr5DKnOqweVttDmcjCWrD2EG2HPQwpCjt47EO29rZQ5IK+37FghpknCkZ/Oskb17L/F
	WXX7wTf3wU+6uk5b/gWZfOEBGrSItfAaV+b/nEvnjbu1qXZylQ8nY+T826VGXSC08s=
X-Google-Smtp-Source: AGHT+IFu99ytHjTbRlZvRSjYKF3KyW4IOwcR6xJDGsiYoktyTX+cpKyAZe0Elx/55d+bPtnX5LCY0A==
X-Received: by 2002:a5d:5f52:0:b0:385:fcfb:8d4f with SMTP id ffacd0b85a97d-38a872deb1amr1964341f8f.21.1736330899266;
        Wed, 08 Jan 2025 02:08:19 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a88825167sm787846f8f.78.2025.01.08.02.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2025 02:08:18 -0800 (PST)
Message-ID: <ccab556d-5d08-49f9-8039-a8c507a7a0e1@linaro.org>
Date: Wed, 8 Jan 2025 10:08:16 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] perf: arm_spe: Add format option for discard mode
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 irogers@google.com, yeoreum.yun@arm.com, mark.rutland@arm.com,
 robh@kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Graham Woodward <graham.woodward@arm.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20241224104414.179365-1-james.clark@linaro.org>
 <20241224104414.179365-2-james.clark@linaro.org>
 <20250107173950.GA8111@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250107173950.GA8111@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/01/2025 5:39 pm, Will Deacon wrote:
> On Tue, Dec 24, 2024 at 10:44:08AM +0000, James Clark wrote:
>> FEAT_SPEv1p2 (optional from Armv8.6) adds a discard mode that allows all
>> SPE data to be discarded rather than written to memory. Add a format
>> bit for this mode.
>>
>> If the mode isn't supported, the format bit isn't published and attempts
>> to use it will result in -EOPNOTSUPP. Allocating an aux buffer is still
>> allowed even though it won't be written to so that old tools continue to
>> work, but updated tools can choose to skip this step.
>>
>> Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   drivers/perf/arm_spe_pmu.c | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
>> index fd5b78732603..9aaf3f98e6f5 100644
>> --- a/drivers/perf/arm_spe_pmu.c
>> +++ b/drivers/perf/arm_spe_pmu.c
>> @@ -193,6 +193,9 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
>>   #define ATTR_CFG_FLD_store_filter_CFG		config	/* PMSFCR_EL1.ST */
>>   #define ATTR_CFG_FLD_store_filter_LO		34
>>   #define ATTR_CFG_FLD_store_filter_HI		34
>> +#define ATTR_CFG_FLD_discard_CFG		config	/* PMBLIMITR_EL1.FM = DISCARD */
>> +#define ATTR_CFG_FLD_discard_LO			35
>> +#define ATTR_CFG_FLD_discard_HI			35
>>   
>>   #define ATTR_CFG_FLD_event_filter_CFG		config1	/* PMSEVFR_EL1 */
>>   #define ATTR_CFG_FLD_event_filter_LO		0
>> @@ -216,6 +219,7 @@ GEN_PMU_FORMAT_ATTR(store_filter);
>>   GEN_PMU_FORMAT_ATTR(event_filter);
>>   GEN_PMU_FORMAT_ATTR(inv_event_filter);
>>   GEN_PMU_FORMAT_ATTR(min_latency);
>> +GEN_PMU_FORMAT_ATTR(discard);
>>   
>>   static struct attribute *arm_spe_pmu_formats_attr[] = {
>>   	&format_attr_ts_enable.attr,
>> @@ -228,9 +232,15 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
>>   	&format_attr_event_filter.attr,
>>   	&format_attr_inv_event_filter.attr,
>>   	&format_attr_min_latency.attr,
>> +	&format_attr_discard.attr,
>>   	NULL,
>>   };
>>   
>> +static bool discard_unsupported(struct arm_spe_pmu *spe_pmu)
>> +{
>> +	return spe_pmu->pmsver < ID_AA64DFR0_EL1_PMSVer_V1P2;
>> +}
> 
> Why not add a new SPE_PMU_FEAT_* for this and handle it in a similar
> way to other optional hardware features?
> 
> Will

Hmmm good point, I'm not sure why I didn't do it that way. Possibly 
because it's only based off pmsver which is already saved, whereas the 
other feats are based off reading PMSIDR which is thrown away. But I can 
add SPE_PMU_FEAT_DISCARD.

Thanks
James



