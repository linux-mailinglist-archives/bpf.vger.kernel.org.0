Return-Path: <bpf+bounces-36530-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C33D4949C76
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 01:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603C61F229A1
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 23:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC11B176AD1;
	Tue,  6 Aug 2024 23:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T5uWGXZv"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB9173336
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722987717; cv=none; b=OFlcbr0Tw8jdGXbVCOUzeAgr9ZC6E38spE9opmmReQnXr2mLeTqSTrIHrf0+7OKUpYooTXwRZj4hEf0wG0SM9QtLVL8eyVXnwDNQwcaD8gESQgFeN/j8w/Lai71Oe4aWxkXFZME31ShaomBM3UMTEmldcDbCwxERqaGVvX6AtKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722987717; c=relaxed/simple;
	bh=0y9+NYK/4O8zvl+G1FP/RoyZ8u654RyMPHraYS2kRFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4m96MWsKWcOEOuzRG1GRG6EiuhSrykfYlA7Ct6tnXnj61wxQlTshT5qWtVKjNI3lQ0F+HgMGJBQUuG+eUzz0TBzcoEgpxOF53MU1M/ELG1QnirpRCgoZisYL8FWkMcUoeumbATMIkzRGMuyb7qLmgtbPr17LMC2EuGI+9brvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T5uWGXZv; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a543a32d-7e08-4f65-a8d1-e68dc561e23b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722987712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lEWtiv0zfP+Tx8ol8mUR5/En5l9/5jsnZ+jQvaCiIMY=;
	b=T5uWGXZvrZcxTd2+MefuT+5Xy3rqkF63zwe1+nCGHd8RWat2vPH3s3ZMlO1ieuQb1Q9leV
	7foIn91hq1gUao5JbYj8HW53fa2q+rZb9e/Ma9vjO3EI4KPkEju5Ji5NI0vTEp+ujdGqLR
	o/WjFwpdtioMqvy7914SdV3YB0L6faE=
Date: Tue, 6 Aug 2024 16:41:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 1/6] selftests/bpf: Add traffic monitor
 functions.
To: Kui-Feng Lee <sinquersw@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, sdf@fomichev.me,
 geliang@kernel.org, kuifeng@meta.com
References: <20240731193140.758210-1-thinker.li@gmail.com>
 <20240731193140.758210-2-thinker.li@gmail.com>
 <feab44ce-8218-4e9d-a3f8-8d7109ef32e6@linux.dev>
 <283a022a-6764-4b66-8897-b8a307733e07@gmail.com>
 <9b76fb31-ef12-423a-b36d-30e1359a867a@gmail.com>
 <bbf79ca6-6641-4758-aa6b-71bf45ba5d34@linux.dev>
 <353791e0-d20a-46f5-aad2-4637abd0569c@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <353791e0-d20a-46f5-aad2-4637abd0569c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/24 4:18 PM, Kui-Feng Lee wrote:
> 
> 
> On 8/6/24 15:22, Martin KaFai Lau wrote:
>> On 8/6/24 3:07 PM, Kui-Feng Lee wrote:
>>>
>>>
>>> On 8/1/24 21:35, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 8/1/24 20:43, Martin KaFai Lau wrote:
>>>>> On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
>>>>>> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/ 
>>>>>> selftests/bpf/test_progs.h
>>>>>> index cb9d6d46826b..5d4e61fa26a1 100644
>>>>>> --- a/tools/testing/selftests/bpf/test_progs.h
>>>>>> +++ b/tools/testing/selftests/bpf/test_progs.h
>>>>>> @@ -473,4 +473,20 @@ extern void test_loader_fini(struct test_loader 
>>>>>> *tester);
>>>>>>       test_loader_fini(&tester);                           \
>>>>>>   })
>>>>>> +struct tmonitor_ctx;
>>>>>> +
>>>>>> +#ifdef TRAFFIC_MONITOR
>>>>>> +struct tmonitor_ctx *traffic_monitor_start(const char *netns);
>>>>>> +void traffic_monitor_stop(struct tmonitor_ctx *ctx);
>>>>>> +#else
>>>>>> +static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns)
>>>>>> +{
>>>>>> +    return (struct tmonitor_ctx *)-1;
>>>>>
>>>>> hmm... from peeking patch 3, only NULL is checked.
>>>
>>> When traffic monitor is disable, these two functions are noop.
>>> Returning -1 (not NULL) is convenient for the callers. They don't need
>>> to tell if the error caused by a real error or by the disabled
>>> feature.
>>
>> I pasted the code from patch 3 here only to ensure I understand the above 
>> explanation correctly:
>>
>> +        netns_obj->tmon = traffic_monitor_start(name);
>> +        if (!netns_obj->tmon)
>>              ^^^^^^^^^^^^^^^^
>>
>> +            goto fail;
>>
>> Does it mean the traffic_monitor_start() above will never be called if 
>> TRAFFIC_MONITOR macro is not defined such that traffic_monitor_start() 
>> returning -1 but testing for NULL here does not matter?
> 
> Correct!

Got it. Then I missed some understanding. Can you explain why the above 
traffic_monitor_start() will never be called?


