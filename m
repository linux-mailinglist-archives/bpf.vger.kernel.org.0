Return-Path: <bpf+bounces-36531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA783949CB8
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 02:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36226B22254
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 00:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466738472;
	Wed,  7 Aug 2024 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iljskCdV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FF010E4
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722989844; cv=none; b=RxeL0bkPfSBDlQeQ2/woSPZeyw7Xh0aQJM7pPxylISaVkl3TVVvdo+SaAnSY4r01iK7kF7HU7tWWnMKvffYGRznwLR53k641vYUnSuiepX05ZX+l3l25ba3LqHcF+M7jrPTGwap0HiTY18Az4Iga8E0HhA0/sxwuwx4Ci8YB+v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722989844; c=relaxed/simple;
	bh=sMmSJioYKGkf/Y8kDZ1S+53Aiuf6a3hntMKD8CYSXXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l7qUM6vNQE+JwxOyK6GD848mCYwqPoB1NibZ9jDhitXhVuIeQFaqhUyyoyfiU9HmcgMJtaJexY+Nw6jEJ0geNUrrdH2EFjnlkuMSAzJ6A+TOv/t5KFP3PF7JmMShc0h/ufCn+Uzx9TCdhRujBLi4nnUM2RBrrVNhB/TfNxCl5XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iljskCdV; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-68aa9c894c7so11970287b3.1
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2024 17:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722989842; x=1723594642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4A7MxNzZIq4Bo+EFOhUt9baw3sEXQbup36lqz67J8e0=;
        b=iljskCdVh7/vgVQNt409Ba3mWyt8+p4wH16KbpLhRZ6FiA0swu7A02zKthbP5M4RUX
         MzK9jKUiDWjOXjkoxjTURhv9h7+S7izcf6gddCQhzAo4RNow6YlxcNr3VCEVjQJDTqUC
         9LH+hgI4W/sM5iNkJr31Sm5c+Bt7ZxitgYuZrupF44I8Ja0mjanhVcfK9TjR6PxaoyJJ
         +CdsEI3r9loMElNL9ZDk52QA/8s0qZFlFIqmb1LRj9OS0384OUsnwd1HjJ9mCu5L8n6A
         CSPCFq/2W1+avw0Kzy4uO9/321LNP3FbATteBCIxY3DgNAfbIIvhLFKJGm+vfEMJevks
         w/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722989842; x=1723594642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4A7MxNzZIq4Bo+EFOhUt9baw3sEXQbup36lqz67J8e0=;
        b=gNOewVR9y7ySEe2SVWwFopywZAFSq0jP9l4t1WCPRDYvcIj4+FMJucgNKEQj4ZKajZ
         D/8NeXaBB5MqQR17rn6VNia/iWPLnYoW4AQDYySdHWQtsEfhsvNeGGODv1SAVukdg/8i
         bDJmcsM176dFPruqcb9Dkgr6rtSXV/iFeDIRJImtCdODfOzRjjpl2Y7tLkkwaTefwEtg
         /DcTPriLQjrScyC0xUTw2eOcvCGcRy+apjFNH2pvqmE4jDTXKCqeJXKiu5Odg4cBHQP+
         14n2ARWVIsHCWoK2OtcsdUSg06zRXipV1IENZST2AhPgGjd5JF0HFiDl0EPDVVeo70KV
         yOVA==
X-Gm-Message-State: AOJu0YyicAjKIbS5dgbFDj6OAjydIdd+XLkDaSXi6dzTvlYd0Mhl9gT/
	h8MNAJUH4OAwcq+lydWHtk3+zm/Qa78dZ8gWu3BlXDYiF3xFh+Pe
X-Google-Smtp-Source: AGHT+IHe9ZMa+xn8w8RHDTlzIFTycCUUv0ALpju+RsRM8WpkYnLbGvBneU/jZjD3ge6HQxExXyzlqA==
X-Received: by 2002:a0d:c986:0:b0:64a:bd29:c5d8 with SMTP id 00721157ae682-6895f60cf53mr167293487b3.2.1722989842125;
        Tue, 06 Aug 2024 17:17:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13? ([2600:1700:6cf8:1240:cfe6:adb2:c0bb:6a13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a1074e5cbsm17511257b3.72.2024.08.06.17.17.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 17:17:21 -0700 (PDT)
Message-ID: <8586dbf6-5d8f-479d-aa8f-ac62ca2345f2@gmail.com>
Date: Tue, 6 Aug 2024 17:17:20 -0700
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
 <353791e0-d20a-46f5-aad2-4637abd0569c@gmail.com>
 <a543a32d-7e08-4f65-a8d1-e68dc561e23b@linux.dev>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <a543a32d-7e08-4f65-a8d1-e68dc561e23b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/6/24 16:41, Martin KaFai Lau wrote:
> On 8/6/24 4:18 PM, Kui-Feng Lee wrote:
>>
>>
>> On 8/6/24 15:22, Martin KaFai Lau wrote:
>>> On 8/6/24 3:07 PM, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 8/1/24 21:35, Kui-Feng Lee wrote:
>>>>>
>>>>>
>>>>> On 8/1/24 20:43, Martin KaFai Lau wrote:
>>>>>> On 7/31/24 12:31 PM, Kui-Feng Lee wrote:
>>>>>>> diff --git a/tools/testing/selftests/bpf/test_progs.h 
>>>>>>> b/tools/testing/ selftests/bpf/test_progs.h
>>>>>>> index cb9d6d46826b..5d4e61fa26a1 100644
>>>>>>> --- a/tools/testing/selftests/bpf/test_progs.h
>>>>>>> +++ b/tools/testing/selftests/bpf/test_progs.h
>>>>>>> @@ -473,4 +473,20 @@ extern void test_loader_fini(struct 
>>>>>>> test_loader *tester);
>>>>>>>       test_loader_fini(&tester);                           \
>>>>>>>   })
>>>>>>> +struct tmonitor_ctx;
>>>>>>> +
>>>>>>> +#ifdef TRAFFIC_MONITOR
>>>>>>> +struct tmonitor_ctx *traffic_monitor_start(const char *netns);
>>>>>>> +void traffic_monitor_stop(struct tmonitor_ctx *ctx);
>>>>>>> +#else
>>>>>>> +static inline struct tmonitor_ctx *traffic_monitor_start(const 
>>>>>>> char *netns)
>>>>>>> +{
>>>>>>> +    return (struct tmonitor_ctx *)-1;
>>>>>>
>>>>>> hmm... from peeking patch 3, only NULL is checked.
>>>>
>>>> When traffic monitor is disable, these two functions are noop.
>>>> Returning -1 (not NULL) is convenient for the callers. They don't need
>>>> to tell if the error caused by a real error or by the disabled
>>>> feature.
>>>
>>> I pasted the code from patch 3 here only to ensure I understand the 
>>> above explanation correctly:
>>>
>>> +        netns_obj->tmon = traffic_monitor_start(name);
>>> +        if (!netns_obj->tmon)
>>>              ^^^^^^^^^^^^^^^^
>>>
>>> +            goto fail;
>>>
>>> Does it mean the traffic_monitor_start() above will never be called 
>>> if TRAFFIC_MONITOR macro is not defined such that 
>>> traffic_monitor_start() returning -1 but testing for NULL here does 
>>> not matter?
>>
>> Correct!
> 
> Got it. Then I missed some understanding. Can you explain why the above 
> traffic_monitor_start() will never be called?
> 

Sorry! Forget my previous word.

In the case that TRAFFIC_MONITOR is not defined,
traffic_monitor_start(name) always returns -1.
So, "!netns_obj->tmon" is always false. "goto fail" is never executed.
That means the test will keep going just like that traffic monitor is
enabled and started correctly.


