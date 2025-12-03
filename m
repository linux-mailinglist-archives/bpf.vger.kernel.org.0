Return-Path: <bpf+bounces-75971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB8AC9FEEB
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 17:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF95630001B9
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E609432860C;
	Wed,  3 Dec 2025 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KjmL/NCZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D783324B23
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777564; cv=none; b=b4PeslAo7p5ztCcTF7l7oQyB18xKSqxVNuS1EFWy2FFOeUSuNtFlYDQTM9RaF0PC357Q2Izwht1zpLt9uVlaXsNde0JWK7FTBC8vydyPXKRrPJU5L9evFCpyFCQrsfrF0qDLWrRAKzuRPMge8+upDtOi8vfOis+VUbGJb65Oj2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777564; c=relaxed/simple;
	bh=iakk/Jr76m1kJL5Np9IbPtoAP3+T1JvteiA3kLHZ94M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bOxWBl5kjGAWWSdJT39IRWdNaMQRiIKEptmIcTcbIH199eef9m9yxZrVSA5RuD56/D4bnBDKbJBBni1cEbTBvrtMvHFZ8B11WOp5gok48UKdzk7beoQgB10TgiCoorAkB4ACD2XGT22zt37KV23wFP1EoxrpCUqA63sMm++6ugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=fail smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KjmL/NCZ; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c6dbdaced8so4792728a34.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 07:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1764777560; x=1765382360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V34xiYHMBhlRprMCQ3/uOloSz9kB9mYUn7HTGoE0360=;
        b=KjmL/NCZGhpvD+wNtHg6HyH1dhoO5OjQului2xmbn701FQHz574G2PSvbHravx8WsS
         tBT8pqcGZj9+2yIRo7qIG84OD6bRvmEFA57ellbKmSPKhM+NJi8/bMjnFpxWJBKqbAAN
         C6MumKEWg8+DzZ6g2gpIU0O/S2C4UzHOVPdEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764777560; x=1765382360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V34xiYHMBhlRprMCQ3/uOloSz9kB9mYUn7HTGoE0360=;
        b=YNNH5Myr1k/80ajP/6ZYXGmvYW2WGDEhEbIzYKl2GOH5sMK5kGgroIA9JCvnRvqxK/
         jRrByIk72DkIhiYHBjAyjTvIsnSLmPkuicydxrtqTgPxu042E0MrHP6GrlntqC/qBtBo
         8ANVt3m1AcYCG+Wjxb2S8XW+pPjtY9dkzmlEUNxuXZVeodgYogYw3+ckdVSqfg6wilts
         wDQo6wc2aYmwC4DCy7txNlG7y0RQ6KE9Cq4m7lriGjOcv7vB5qXT7uH3eirJQNTqhex+
         NkOd95R6yPXH72gsM6KjMnOfuv0B1c6WYt++us0WuDcc50/K6EzHcdUwEXeGVMRsLxPV
         Ushg==
X-Forwarded-Encrypted: i=1; AJvYcCXNWLucpJPcAeiVtIuMxvpT78g4uD1XcuWDAw006Ubh+wzxqNkwEoDCP96Fi6EXwx3iNLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1WjGz0Kyvl79OlqDN4y91N2rKKxOu/arxfJscdCin2m//XlMW
	Az0gsYj4ftBtQeyM+ZSv7BQp8ICUEnkND+q7dtMjjKZFHsOPPJRZxGlFqpBuNn4RLPI=
X-Gm-Gg: ASbGncv8A0ZlrP3u9+AS9uejbN1FfTTjSh9lxmvue+ny2P2JC0qpBrfvQaag9GcjJRT
	+z2FGvk1qnapL4QgStV2DA4UM0GnpmuDhXRZ2ohPFbdBUUo5nl9553DMTh1zQTJOqSroZx8lZNt
	cv/fV1dSybwTD7JVtZqLGHKkYDZEsltdLeIs20jjyVwumY/7KKr5DYTv7xzW3GKLOPZZGJciM9f
	yMZl9u5VeDfal4iw/cQmssU2tWwVtRnh+Mx9y4y/LRgjsem1lNCzHanwtzqVIhRIYMEe53CYAdP
	jBNO+9C1nFnIbg7L7NjETsQjpy09RrcBnnhVw+2rlvI2lYlvJHspmnrJGuojNniRhrs8qrwo5IF
	5IQHHqJeKVC7v+Z0wFNYOJzCXq7c2HSOtrpdMdwy5q2vKW/XK8jxOLMmftcZqkxhmNYAlypyqyX
	5UX/cAK450seUlBZPCSrYNe3M=
X-Google-Smtp-Source: AGHT+IHZKqU6OwoL05VlFhrm59ANsB5LDQOaT2yu73WegIU0kb05V6z7peIr7y7gMgvG/jBK7FYjzQ==
X-Received: by 2002:a05:6830:4389:b0:7bc:6cc3:a624 with SMTP id 46e09a7af769-7c94dd09ab0mr1682360a34.32.1764777560172;
        Wed, 03 Dec 2025 07:59:20 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c90f5fedbbsm8945257a34.10.2025.12.03.07.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 07:59:19 -0800 (PST)
Message-ID: <a5a1d7bf-04b0-43fb-8f93-781c3534d8fd@linuxfoundation.org>
Date: Wed, 3 Dec 2025 08:59:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/seccomp: fix pointer type mismatch in UPROBE
 test
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>, Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, khalid@kernel.org,
 david.hunter.linux@gmail.com, Jiri Olsa <olsajiri@gmail.com>,
 sam@gentoo.org, shuah <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <aP0-k3vlEEWNUtF8@krava>
 <20251026091232.166638-2-nirbhay.lkd@gmail.com>
 <8e1ff2f1-b45e-4b1f-b545-d433e277607f@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <8e1ff2f1-b45e-4b1f-b545-d433e277607f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/25/25 04:20, Nirbhay Sharma wrote:
> 
> 
> On 10/26/25 2:42 PM, Nirbhay Sharma wrote:
>> Fix compilation error in UPROBE_setup caused by pointer type mismatch
>> in the ternary expression when compiled with -fcf-protection. The
>> probed_uprobe function pointer has the __attribute__((nocf_check))
>> attribute, which causes the conditional operator to fail when combined
>> with the regular probed_uretprobe function pointer:
>>
>>    seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
>>    expression [-Wincompatible-pointer-types]
>>
>> Cast both function pointers to 'const void *' to match the expected
>> parameter type of get_uprobe_offset(), resolving the type mismatch
>> while preserving the function selection logic.
>>
>> This error appears with compilers that enable Control Flow Integrity
>> (CFI) protection via -fcf-protection, such as Clang 19.1.2 (default
>> on Fedora).
>>
>> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
>> ---
>>   tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
>> index 874f17763536..e13ffe18ef95 100644
>> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
>> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
>> @@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
>>           ASSERT_GE(bit, 0);
>>       }
>> -    offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
>> +    offset = get_uprobe_offset(variant->uretprobe ?
>> +        (const void *)probed_uretprobe : (const void *)probed_uprobe);
>>       ASSERT_GE(offset, 0);
>>       if (variant->uretprobe)
> 
> Hi all,
> 
> I'm following up on this patch that fixes the pointer type mismatch in
> UPROBE_setup when building with -fcf-protection. It resolves the
> incompatible-pointer-types error seen with Clang 19.
> 
> Please let me know if there are any comments or some changes needed.
> 

Hi Kees,

Is it okay to take this patch through my tree?

thanks,
-- Shuah


