Return-Path: <bpf+bounces-36528-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83B9949C40
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 01:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02D3E1C2170C
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 23:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FB9175D36;
	Tue,  6 Aug 2024 23:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RDVKREbG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD06166315
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 23:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722986299; cv=none; b=rcgQhIJSZ5FOtMthigxtF63RZr+rug/CqjY0AV7gWXvlr8ED8cwlChuk8GDBiYGuK5QtMzoNvfo+ryT77RME6Kb3sI7QFPoixOsRuxffMQIU5hZDMWtLWlxjBTZJ5Wo+NltbXFQmaTAdbD6p+av+vfJdGnYDiycWvybiRqJgYME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722986299; c=relaxed/simple;
	bh=WLjOTYUAO5LuZ0t5w7oKpHBE/dMZA9aFN3/RFJJjMjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnhqKso0iQqSDDBZvvWW2T2+6jXc9HuEMAdE2/FeoXOKmlbHkZeufkC8zSEPya/qinulJrbVVaUM73bV5Nx9UE7odeF/KqR8vvTlBsNK2K5AKpqfNQr/YwMDAH3lOI4ksAqWKBrcd5vo67JkZgwP5OEJYVZ0uUwJdq8IQ8Wg6YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RDVKREbG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-68518bc1407so12722657b3.2
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 16:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722986297; x=1723591097; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p4/GxD7HpXD3vvp6ghFFhYXQ86SwriR3aaKTpMNegHM=;
        b=RDVKREbGA1NJZx7isvWsPdJvFgtS25mt6IdcGxrqfzfSqtAnAKcRUrRU9pUbdl0YH8
         IqmL7Vo2tZ02cadWyPf3/3PEJ9a8L7tO9LwWctUdcEbqhY1/nBrgr0Du+nc53oUPLESi
         l9ObaMTtLfqdScvXANDiYVkUkPr4wyLAl/CxDhDvL8A/6XXKGVQiSFfAGzk8VS/Ano5T
         aWDAq0gO7z3xVGdWakw1H1xPpfpfjNAI/+/VXW9frfnVVJOkCfpgqk2FVgUd86ZHN2sE
         ftjm1pslFK3wSoikCuJz/JYxPp/6NdbsbxLxMSNmsH5pK3VRs7rpbcMLuJHYLwD4zKUS
         f2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722986297; x=1723591097;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4/GxD7HpXD3vvp6ghFFhYXQ86SwriR3aaKTpMNegHM=;
        b=Kb/RZ+JaU0YT54T/UgVlop3IrGrdscsleAv0AQlcDgJ/yK0siZFnZHq6OPaHLDL93t
         JwfBt4mU6DDhIGBB3v0kOJ94eSNiAljLZon/80Tqh3FCYYcqd9CMhzjChwRYn+8uKNHx
         nBoDJHzF2k9kCfvc+/dZFFCkLi7rETQ76L3vsx356I8us+yNPqAODDOfu2Ql1EsaPgiy
         lTe40uINKPdkv4q9uoOiMix20ubXU3fa3JRWQnjD6IMAo3bu4E6gbD6RHvAscagWHATa
         Vkry9ptc31pTRhfOc5oHLKHM87JBaLZx53mQMmv59GbaIgir/aODsYpwKhNa3Uk65wbV
         vjVg==
X-Gm-Message-State: AOJu0YzCtjmrkY6vZzzPdP5IZkOBgsF2HEbkly+QifUWnm75zqDyeP6v
	kMHgitRrDJnsPUBjFT6z5GDUxNpmZqEscf/Ih1edJJZiIXBel9T0
X-Google-Smtp-Source: AGHT+IGba8DdOfJWSkCQuHU0Lm5OcyXWRH1VzgDzYyLjRvA6/GqEzlcsBNl20XU4LaJxn6ErmPYGrw==
X-Received: by 2002:a81:6906:0:b0:64b:75d8:5002 with SMTP id 00721157ae682-6895f60d8eemr184764727b3.9.1722986296837;
        Tue, 06 Aug 2024 16:18:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13? ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a137b43easm17161837b3.128.2024.08.06.16.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 16:18:16 -0700 (PDT)
Message-ID: <353791e0-d20a-46f5-aad2-4637abd0569c@gmail.com>
Date: Tue, 6 Aug 2024 16:18:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Martin KaFai Lau <martin.lau@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
 <feab44ce-8218-4e9d-a3f8-8d7109ef32e6@linux.dev>
 <283a022a-6764-4b66-8897-b8a307733e07@gmail.com>
 <9b76fb31-ef12-423a-b36d-30e1359a867a@gmail.com>
 <bbf79ca6-6641-4758-aa6b-71bf45ba5d34@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <bbf79ca6-6641-4758-aa6b-71bf45ba5d34@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/6/24 15:22, Martin KaFai Lau wrote:
> On 8/6/24 3:07 PM, Kui-Feng Lee wrote:
>>
>>
>> On 8/1/24 21:35, Kui-Feng Lee wrote:
>>>
>>>
>>> On 8/1/24 20:43, Martin KaFai Lau wrote:
>>>> On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
>>>>> diff --git a/tools/testing/selftests/bpf/test_progs.h 
>>>>> b/tools/testing/ selftests/bpf/test_progs.h
>>>>> index cb9d6d46826b..5d4e61fa26a1 100644
>>>>> --- a/tools/testing/selftests/bpf/test_progs.h
>>>>> +++ b/tools/testing/selftests/bpf/test_progs.h
>>>>> @@ -473,4 +473,20 @@ extern void test_loader_fini(struct 
>>>>> test_loader *tester);
>>>>>       test_loader_fini(&tester);                           \
>>>>>   })
>>>>> +struct tmonitor_ctx;
>>>>> +
>>>>> +#ifdef TRAFFIC_MONITOR
>>>>> +struct tmonitor_ctx *traffic_monitor_start(const char *netns);
>>>>> +void traffic_monitor_stop(struct tmonitor_ctx *ctx);
>>>>> +#else
>>>>> +static inline struct tmonitor_ctx *traffic_monitor_start(const 
>>>>> char *netns)
>>>>> +{
>>>>> +    return (struct tmonitor_ctx *)-1;
>>>>
>>>> hmm... from peeking patch 3, only NULL is checked.
>>
>> When traffic monitor is disable, these two functions are noop.
>> Returning -1 (not NULL) is convenient for the callers. They don't need
>> to tell if the error caused by a real error or by the disabled
>> feature.
> 
> I pasted the code from patch 3 here only to ensure I understand the 
> above explanation correctly:
> 
> +        netns_obj->tmon = traffic_monitor_start(name);
> +        if (!netns_obj->tmon)
>              ^^^^^^^^^^^^^^^^
> 
> +            goto fail;
> 
> Does it mean the traffic_monitor_start() above will never be called if 
> TRAFFIC_MONITOR macro is not defined such that traffic_monitor_start() 
> returning -1 but testing for NULL here does not matter?

Correct!

