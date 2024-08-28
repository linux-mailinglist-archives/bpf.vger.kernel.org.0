Return-Path: <bpf+bounces-38302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EC7962F0F
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A8B8285A83
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 17:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0261A706C;
	Wed, 28 Aug 2024 17:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJIxSWuk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89478161321
	for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724867605; cv=none; b=ihedghFV43dF4wYhVb7DHsO162o3VI3D/Bu3eMmt7JxaiyUtAQORUb1tqD1iIeH8I2DIPR1PPn2F9QVljH1j+IJHfbeDx/gPDo8WIoU++LWxlnJjPpq3iRqpZqfm4idff52BfAx4dZ7z8TFr0OhSpWIR82ztzthASNqa5EK2qRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724867605; c=relaxed/simple;
	bh=SuNKI1VyRAY13NYJ02pVuewS9iaiaHhTltRxAFmaGKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aj9813ArJ1EduPKpb/5H9M+iKLSHdY1MD0PtLpax93s+Pf80omprFC8IK056T3ZDzt5z4nU+rTm0ypAHnhcFr5g2AsHYtrJJYS6R5JlBNvtRLvDqpFxZBHgFNWAOcryWSv9gIRHqixdlNBnNYc0P/jtZsz1dpRz3SaT3Gjy3Z/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJIxSWuk; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-70941cb73e9so3998938a34.2
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724867603; x=1725472403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3+oDKe9sCyinoGilAeMUqdt5hk2UlZk0y5A4d2M2KRE=;
        b=eJIxSWuknWk/Cw+r5/n/iLPPeu9FcrLzquTbIIAU98Wx5JDu8Vs4tZ/nN7ATd1yVqa
         +8D5Hqf9StVqtjGFpR7D/CfwVzm+qVT55gWbPRCt+Ora/7eeK290mxf/vcPDIwUAeAQX
         9MYFv6923iflv07lvse7EC/MsgfGlP5gMAeQgTWF/EW9cNY4z+mVA76kqUf4+Sph2rVf
         XxKuvD3CpZIteRjSsCDVGx7C5BMj0k0WsW/8O/6CKMnOqm/XKMOh1Pnxh4pEhCA40KIB
         vL6JwdUFG/N0z35KNaXmofDmKAZdLUJvxk9mKxcPRBEMw5aVHXIK4NN6jjjiZcrS6zNX
         tXRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724867603; x=1725472403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+oDKe9sCyinoGilAeMUqdt5hk2UlZk0y5A4d2M2KRE=;
        b=chW0xbwxeLaSS0qh9sVMPGPhV30jWc9a3iipS/yciIR/WIoOuqsFT8qnR6/CA9H8+m
         z4F7t+OxYVPzP4jjUP/Xxh+wSIAlP48v5B8z6io3W/UEnQZU7jOs5o5jJCcVzRmXTecY
         EGoFQfAc6wM6XTqNVhLHWUu6cpplXCyfVnbf5mEouYVOIGf5tqw6uNQyu2Ko6VkWyzxA
         1XXzcjMFdKezId5/ZIpSoKuKUQd4ml6P2X0cccoKN8jEK0dghOQUfF/NPZFOEH0ACDEW
         MK1wKuF4I9WtjInkxO6vSyAdhATK8G7KANcE7UQ67w14EcvIdh0rBQ+uWrc8QfwnR36C
         HqTQ==
X-Gm-Message-State: AOJu0YxJbZT+f+BJe6c4SvsWz3kAoW3fuw/JrRirqlmsyjCbyDDTcgtD
	rUNVkZLZ3KKo3lPG1KYbuZ3kdE9uETj8m9RpdnCl8mInAwvYC/sX
X-Google-Smtp-Source: AGHT+IEV8KE/c2uCx3RtHe/79xIjJCwCk09cJoZ+LAoXYo8M709jC6gBjSNxdftUfOnCaU29uenteg==
X-Received: by 2002:a05:6830:91f:b0:70f:591f:6c66 with SMTP id 46e09a7af769-70f5c421fa8mr336239a34.34.1724867603488;
        Wed, 28 Aug 2024 10:53:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:eb36:fa76:806f:699e? ([2600:1700:6cf8:1240:eb36:fa76:806f:699e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70e03b8895fsm2971383a34.71.2024.08.28.10.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 10:53:23 -0700 (PDT)
Message-ID: <a2ceb85b-9878-40a5-b003-cb8943c2282b@gmail.com>
Date: Wed, 28 Aug 2024 10:53:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next v4 5/6] libbpf: define __uptr.
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 andrii@kernel.org, kuifeng@meta.com
References: <20240816191213.35573-1-thinker.li@gmail.com>
 <20240816191213.35573-6-thinker.li@gmail.com>
 <CAEf4BzaDTaF9tQYjY1MSMjs2PwYM_K1XPyPOEPgFwHY-8+tcJg@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAEf4BzaDTaF9tQYjY1MSMjs2PwYM_K1XPyPOEPgFwHY-8+tcJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Thanks for the review.

On 8/27/24 16:13, Andrii Nakryiko wrote:
> On Fri, Aug 16, 2024 at 12:12 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>
>> Make __uptr available to BPF programs to enable them to define uptrs.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/lib/bpf/bpf_helpers.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
>> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
>> index 305c62817dd3..7ff9d947b976 100644
>> --- a/tools/lib/bpf/bpf_helpers.h
>> +++ b/tools/lib/bpf/bpf_helpers.h
>> @@ -185,6 +185,7 @@ enum libbpf_tristate {
>>   #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
>>   #define __kptr __attribute__((btf_type_tag("kptr")))
>>   #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
>> +#define __uptr __attribute__((btf_type_tag("uptr")))
>>
>>   #if defined (__clang__)
>>   #define bpf_ksym_exists(sym) ({                                                \
>> --
>> 2.34.1
>>

