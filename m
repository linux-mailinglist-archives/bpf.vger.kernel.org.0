Return-Path: <bpf+bounces-36518-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A10949B45
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5810B22229
	for <lists+bpf@lfdr.de>; Tue,  6 Aug 2024 22:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478F1171658;
	Tue,  6 Aug 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h12pWF76"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E98716EC0B
	for <bpf@vger.kernel.org>; Tue,  6 Aug 2024 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982978; cv=none; b=ausYUOAnytgVKYWlys2VsWprnpECOyMh0J93qAvL44iIcKMlFEN+V6NBFYhaR6jyp+UttBEyIz6lhJNNjQAerZ6Jds1TaBXCQ6ls+H1VMWY7yJpW89rLEDAmcUq+ldcX7UBgVQICwTHFNvjXTGk4+QNHywjBjNRaqQItMItUNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982978; c=relaxed/simple;
	bh=2QLH5BXi0/yZu1QBzjdwabWaHtYxyBUkK7jthsnFvKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzY+tDmPBHUWpzL0jpcp7Xh/IydKft2kSJ+3QYZEicnAyPgCjlAzfQI+pMtStTF86DWF1CURmdI/bVL/RGm96BK6+BMNJA3yzstKmYgBAcpNFRwZKBt3RqS4hyu8QePaGAwAuIsLaiXVKsu6bzvz9DnDarfcEEHiCXaGModF4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h12pWF76; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bbf79ca6-6641-4758-aa6b-71bf45ba5d34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722982974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IgVaaN9i6efbUO9hL023cXearTSOesSXQ2WW1XR5JtQ=;
	b=h12pWF769XbrPhUWNceh5c3cSwYX9PJQHwefJxDXfPPy4VKuDcgxFhqaqf4MmtjiiWls/1
	dD8oFEW8PO4SVCnoxrM1EcR0nxWwihewdz/jRZ9tXyuHywYOP8bo6uEz6Oxc08BNdcPQH1
	/NJ99OuI5stLfKAXXARGwJLzy1IsMyk=
Date: Tue, 6 Aug 2024 15:22:46 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <9b76fb31-ef12-423a-b36d-30e1359a867a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/6/24 3:07 PM, Kui-Feng Lee wrote:
> 
> 
> On 8/1/24 21:35, Kui-Feng Lee wrote:
>>
>>
>> On 8/1/24 20:43, Martin KaFai Lau wrote:
>>> On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
>>>> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/ 
>>>> selftests/bpf/test_progs.h
>>>> index cb9d6d46826b..5d4e61fa26a1 100644
>>>> --- a/tools/testing/selftests/bpf/test_progs.h
>>>> +++ b/tools/testing/selftests/bpf/test_progs.h
>>>> @@ -473,4 +473,20 @@ extern void test_loader_fini(struct test_loader *tester);
>>>>       test_loader_fini(&tester);                           \
>>>>   })
>>>> +struct tmonitor_ctx;
>>>> +
>>>> +#ifdef TRAFFIC_MONITOR
>>>> +struct tmonitor_ctx *traffic_monitor_start(const char *netns);
>>>> +void traffic_monitor_stop(struct tmonitor_ctx *ctx);
>>>> +#else
>>>> +static inline struct tmonitor_ctx *traffic_monitor_start(const char *netns)
>>>> +{
>>>> +    return (struct tmonitor_ctx *)-1;
>>>
>>> hmm... from peeking patch 3, only NULL is checked.
> 
> When traffic monitor is disable, these two functions are noop.
> Returning -1 (not NULL) is convenient for the callers. They don't need
> to tell if the error caused by a real error or by the disabled
> feature.

I pasted the code from patch 3 here only to ensure I understand the above 
explanation correctly:

+		netns_obj->tmon = traffic_monitor_start(name);
+		if (!netns_obj->tmon)
		    ^^^^^^^^^^^^^^^^

+			goto fail;

Does it mean the traffic_monitor_start() above will never be called if 
TRAFFIC_MONITOR macro is not defined such that traffic_monitor_start() returning 
-1 but testing for NULL here does not matter?


