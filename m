Return-Path: <bpf+bounces-18109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D98815DD0
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 08:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE2E1C219E6
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 07:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A824B1854;
	Sun, 17 Dec 2023 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dudb+yz2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA17A17F6
	for <bpf@vger.kernel.org>; Sun, 17 Dec 2023 07:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d9daa5207eso1654948a34.0
        for <bpf@vger.kernel.org>; Sat, 16 Dec 2023 23:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702796974; x=1703401774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eFbs0MQHcfD/y3ij7/zX5vIE6jTB198Mao3eq0YZ8MU=;
        b=Dudb+yz2TgMyYn3a61XaLZiWdCMaw9hAYSEF+aXBV4egIgD6xwJSr3MZNNyaAAd3iN
         +zvp600rjZFaH6PuLJEM+zFw2kfs3hTXkwTCK055MutOTMj19jkOsPr2eGjH32Ec2nvM
         6lbPQIciWZuRvouRF68385LHQjlQLrKw3P46ODVsUNSbJ69LEAUbNsh87UJRt1BKr0C5
         AhQI+nPlcdOC35gunKvFSDpoYPlZRUU5mPKeis2DfED8+sUgPhG0vv9YLSzk6fYJMbwO
         ti+QGTFXbTmsuAPVYhdxOa2X3yX0pt8FQawiNkwJnQlVTG3AQ2FyuewEjjiYZggvox8y
         LNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702796974; x=1703401774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eFbs0MQHcfD/y3ij7/zX5vIE6jTB198Mao3eq0YZ8MU=;
        b=HfCR77yHAQv71B75yJy1aflHR7CGApMn6KeP10rMq7S61sbSl2iVR3WWhUPBNIiLFi
         T5zAWPO7lWy5xO0vSsFrGR8OVOowqfy2p1QWs70qOYzL6T1XsRRH6SqBcBHl5/Sr+6X4
         Se62RfWHvVKLj5vtVumdoYi+Fdt3XSJ50SQYA4sR0pVEvYly8t1ak4uthq2mzysmWh5d
         gsT4aNXJ3QxGYOIJVUxR+ORIUSgvfC18ihvIprTVluxogAZO4LvRcv8Vv45gao52Uku4
         nvz05NFTLBtI2aJHGitIwUX5cWRajOU3wSvd1h1HIKfLge9+kdp7kPSCLfTeBIX2kSCM
         nO6g==
X-Gm-Message-State: AOJu0Yy2Kc6rjOBpWJpScqDx04yex4xatSgsBxtTDE1eWb7z2QB6x++k
	+8rnI3E1BMouLJE1hN1TBTmjZXEta2M=
X-Google-Smtp-Source: AGHT+IHVErE9frMjCf6p5SjgwN45Q5TSHcGdHlh17X9y66kOG6ExqSb65Lb6gIUPVViKWQckQnwKWg==
X-Received: by 2002:a05:6808:211e:b0:3b8:3e9c:af97 with SMTP id r30-20020a056808211e00b003b83e9caf97mr17551942oiw.48.1702796973802;
        Sat, 16 Dec 2023 23:09:33 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf? ([2600:1700:6cf8:1240:bb8c:c0f2:4408:50cf])
        by smtp.gmail.com with ESMTPSA id v139-20020a252f91000000b00dbccadd6dd8sm3460270ybv.59.2023.12.16.23.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Dec 2023 23:09:33 -0800 (PST)
Message-ID: <f6fab268-31e9-44f4-a0ff-9223ad2d01e3@gmail.com>
Date: Sat, 16 Dec 2023 23:09:32 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v13 04/14] bpf: add struct_ops_tab to btf.
Content-Language: en-US
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org, drosen@google.com
References: <20231209002709.535966-1-thinker.li@gmail.com>
 <20231209002709.535966-5-thinker.li@gmail.com>
 <466399be-c571-48af-8f48-8365689d4d20@linux.dev>
 <fc15849b-2f71-420e-aab4-7a20014cba49@gmail.com>
 <44dc6eb4-d524-4180-8970-4eef2a9b9f58@linux.dev>
 <b85024f1-87bd-487e-bfa0-68dae52c9071@gmail.com>
 <c9635b6f-bcfc-4d04-b45b-805ed9710a26@linux.dev>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <c9635b6f-bcfc-4d04-b45b-805ed9710a26@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/16/23 08:48, Martin KaFai Lau wrote:
> On 12/15/23 9:43 PM, Kui-Feng Lee wrote:
>>
>>
>> On 12/15/23 17:19, Martin KaFai Lau wrote:
>>> On 12/15/23 1:42 PM, Kui-Feng Lee wrote:
>>>>
>>>>
>>>> On 12/14/23 18:22, Martin KaFai Lau wrote:
>>>>> On 12/8/23 4:26 PM, thinker.li@gmail.com wrote:
>>>>>> +const struct bpf_struct_ops_desc *btf_get_struct_ops(struct btf 
>>>>>> *btf, u32 *ret_cnt)
>>>>>> +{
>>>>>> +    if (!btf)
>>>>>> +        return NULL;
>>>>>> +    if (!btf->struct_ops_tab)
>>>>>
>>>>>          *ret_cnt = 0;
>>>>>
>>>>> unless the later patch checks the return value NULL before using 
>>>>> *ret_cnt.
>>>>> Anyway, better to set *ret_cnt to 0 if the btf has no struct_ops.
>>>>>
>>>>> The same should go for the "!btf" case above but I suspect the 
>>>>> above !btf check is unnecessary also and the caller should have 
>>>>> checked for !btf itself instead of expecting a list of struct_ops 
>>>>> from a NULL btf. Lets continue the review on the later patches for 
>>>>> now to confirm where the above !btf case might happen.
>>>>
>>>> Checking callers, I didn't find anything that make btf here NULL so 
>>>> far.
>>>
>>>> It is safe to remove !btf check. For the same reason as assigning
>>>> *ret_cnt for safe, this check should be fine here as well, right?
>>>
>>> If for safety, why ref_cnt is not checked for NULL also? The 
>>> userspace passed-in btf should have been checked for NULL long time 
>>> before reaching here. There is no need to be over protective here. It 
>>> would really need a BUG_ON instead if btf was NULL here (don't add a 
>>> BUG_ON though).
>>>
>>> afaict, no function in btf.c is checking the btf argument for NULL also.
>>>
>>>>
>>>> I don't have strong opinion here. What I though is to keep the values
>>>> as it is without any side-effect if the function call fails and if
>>>> possible. And, the callers should not expect the callee to set some
>>>> specific values when a call fails.
>>>
>>> For *ref_cnt stay uninit, there is a bug in patch 10 which exactly 
>>> assumes 0 is set in *ret_cnt when there is no struct_ops. It is a 
>>> good signal on how this function will be used.
>>>
>>> I think it is arguable whether returning NULL here is failure. I 
>>> would argue getting a 0 struct_ops_desc array is not a failure. It is 
>>> why the !btf case confuses the return NULL case to mean a never would 
>>> happen error instead of meaning there is no struct_ops. Taking out 
>>> the !btf case, NULL means there is no struct_ops (instead of 
>>> failure), so 0 cnt.
>>>
>>> Anyhow, either assign 0 to *ret_cnt here, or fix patch 10 to init the 
>>> local cnt 0 and write a warning comment here in btf_get_struct_ops() 
>>> saying ret_cnt won't be set when there is no struct_ops in the btf.
>>
>>
>> I will fix at the patch 10 by setting local cnt 0
>>
>>>
>>> When looking at it again, how about moving the 
>>> bpf_struct_ops_find_*() to btf.c. Then it will avoid the need of the 
>>> new btf_get_struct_ops() function. bpf_struct_ops_find_*() can 
>>> directly use the btf->struct_ops_tab.
>>>
>>
>> I prefer to keep them in bpf_struct_ops.c if it is ok to you.
>> Fixing the initialization issue of bpf_struct_ops_find()
>> should be enough.
> 
> If choosing between fixing the bug in patch 10 and moving them to btf.c, 
> I would avoid patch 10 (and future) bug to begin with by moving them to 
> btf.c. Moving them should be cheap unless there is other dependency that 
> I have overlooked.

Ok! Got it!

> 
>>
>>>
>>>>
>>>>>
>>>>>> +        return NULL;
>>>>>> +
>>>>>> +    *ret_cnt = btf->struct_ops_tab->cnt;
>>>>>> +    return (const struct bpf_struct_ops_desc 
>>>>>> *)btf->struct_ops_tab->ops;
>>>>>> +}
>>>>>
>>>
> 

