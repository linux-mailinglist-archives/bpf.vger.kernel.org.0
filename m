Return-Path: <bpf+bounces-15718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF937F54F6
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 00:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF7B1C20BB8
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 23:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCF82137F;
	Wed, 22 Nov 2023 23:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvYJhvVR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EA0BC
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 15:47:32 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b843fea0dfso235031b6e.3
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700696851; x=1701301651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RN44jNH8D0YRnNCczizAkC25tHC+wOD4XVqEeP1pydI=;
        b=HvYJhvVR9RcBXkHAtbTi7oXYnOtsDXHmH7P+J4dFEBE8jmP0OU6+vNvkCDWu6JR1GD
         Ur0LFTRGuJELvyogVsuOMZLbvt1eTQgUtmvWUgs653LYo9vp1rJm7h2WwFxNlSssRQye
         HQQOXsyOWIcHdtwMR/pagJR8gQAZIU7DinazQik0tjMbFJTv1DTsMynyDVjlT198VWzi
         BcAjqtWqKewDnr5K3tGeuf0JbuA9HxhFsXbxU09SLSzhqYMLbI/g5/e5au2zSjXSef5K
         zOWnEHRzzHQF+NIMCEoyQvXsIoX43s8R6hglYA7ABnMTmcuBtpBOl/cmmcJwGSv9+P8R
         aQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700696851; x=1701301651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RN44jNH8D0YRnNCczizAkC25tHC+wOD4XVqEeP1pydI=;
        b=N1i8UI3oiunQQBBb7tGLG1dMxsItD4NgHjYIUxFdFXicQikFcY+DBTiEpOdF3gElyQ
         yOgTyfwMCPq/a2OvH40HFri+NYDCwkUZUv0pXdtQ+c79Rd9kyt3D12hy1IUBF0fxHpWL
         w/SsZAV/7DBGqLYzgDsjXcJz8WA6GL7UwlrJbfRjWblbekxdWtGFkmnU7jfkzZnmvwPb
         6ibLX6FBdki9YZ8EDiANu7dSGHjwywbyCwZAznEF3Hf3ZkNYV4hALfgyC2LUtP1mLYMu
         939MBtyER6oYLGZfigUY68UhxE75iJTAkQUo+AsDiHOqlESfKzSJP6dgSepCh0F4f/rl
         4GJQ==
X-Gm-Message-State: AOJu0Yw0jRPTNozyo7y9EeUdD3t3TiaMU2Sk45vjYcdHNoR6FhNWpv0z
	CSZQQVUMYZk3h4z0rUi91wE=
X-Google-Smtp-Source: AGHT+IF3aAd9HLEuvTMujTkp0feoqqtyNqSNUtl/nhxM3EZrMG/O9paa9VKOLOVcH5FzdJPkX6kc4g==
X-Received: by 2002:a05:6808:23d6:b0:3b8:45a3:917c with SMTP id bq22-20020a05680823d600b003b845a3917cmr2315145oib.23.1700696851408;
        Wed, 22 Nov 2023 15:47:31 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:5a79:4034:522e:2b90? ([2600:1700:6cf8:1240:5a79:4034:522e:2b90])
        by smtp.gmail.com with ESMTPSA id d14-20020a05680813ce00b003b2e2d134a5sm10820oiw.35.2023.11.22.15.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 15:47:30 -0800 (PST)
Message-ID: <bdb45ec6-e9dd-4a25-947c-dfa8059d10cb@gmail.com>
Date: Wed, 22 Nov 2023 15:47:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v11 09/13] bpf: validate value_type
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231106201252.1568931-1-thinker.li@gmail.com>
 <20231106201252.1568931-10-thinker.li@gmail.com>
 <4218c215-a8f9-8efb-6958-d7cbb4d792a3@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <4218c215-a8f9-8efb-6958-d7cbb4d792a3@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/9/23 18:11, Martin KaFai Lau wrote:
> On 11/6/23 12:12 PM, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> A value_type should consist of three components: refcnt, state, and data.
>> refcnt and state has been move to struct bpf_struct_ops_common_value to
>> make it easier to check the value type.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   include/linux/bpf.h         | 14 ++++++
>>   kernel/bpf/bpf_struct_ops.c | 93 ++++++++++++++++++++++++-------------
>>   2 files changed, 74 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index c287f42b2e48..48e97a255945 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -3231,4 +3231,18 @@ static inline bool bpf_is_subprog(const struct 
>> bpf_prog *prog)
>>       return prog->aux->func_idx != 0;
>>   }
>> +#ifdef CONFIG_BPF_JIT
> 
> There is an existing "#if defined(CONFIG_BPF_JIT) && 
> defined(CONFIG_BPF_SYSCALL)" above and a few bpf_struct_ops_*() has 
> already been there. Does it need another separate one which is only 
> CONFIG_BPF_JIT here?
> 
>> +enum bpf_struct_ops_state {
>> +    BPF_STRUCT_OPS_STATE_INIT,
>> +    BPF_STRUCT_OPS_STATE_INUSE,
>> +    BPF_STRUCT_OPS_STATE_TOBEFREE,
>> +    BPF_STRUCT_OPS_STATE_READY,
>> +};
>> +
>> +struct bpf_struct_ops_common_value {
>> +    refcount_t refcnt;
>> +    enum bpf_struct_ops_state state;
>> +};
> 
> Do the struct and enum really need to be in ifdef?
> 
>> +#endif /* CONFIG_BPF_JIT */
>> +
> 
I just removed this pair of #if-else.
You are right! They are not necessary.

