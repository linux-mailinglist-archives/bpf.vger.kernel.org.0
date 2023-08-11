Return-Path: <bpf+bounces-7622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C7B779B59
	for <lists+bpf@lfdr.de>; Sat, 12 Aug 2023 01:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AAE28164A
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 23:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54163D3A9;
	Fri, 11 Aug 2023 23:31:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB2329D4
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 23:31:30 +0000 (UTC)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ABCE77
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:31:29 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-583fe10bb3cso27050737b3.2
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 16:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691796688; x=1692401488;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StpTR692gZchn729yEh6jalGSGqjJsjai3PYqDElyV0=;
        b=TBI2+gKxyjucP6r4MEUxVnzRSEyE2AGllF+44Tlok5mIQSilpmwGAo8nXfDq1oRNud
         1rtppFu+MjC9TlLxE2zaeHfAeHi+R4rJTpMqTePRH7PSRQgeOuUiV57v4h5dn6E/LGx2
         S2cdz3Ru3unUOe+uW1L3x5hUdcv23sf4gy1MkSjXGFFkPBILUcXDQ4NyYHOYI65E/yc8
         4/PyLmOXFxtYkTq16IRVqkVSy1JQfKQhluODiQbu+C+ehUlPZYl26a7jmbYurBNllPB1
         1asBGnyULUZAC8E7oCo0+A6TEhQ3nysTQ9jIsBMUWBILvvO0VkHFE0TxUwW6jhgHK1T2
         POYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691796688; x=1692401488;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=StpTR692gZchn729yEh6jalGSGqjJsjai3PYqDElyV0=;
        b=eoF/JAvvY5UrT6p7c8rgpsZBwKVBrmZC8fUilRggFaAsXbLZVbse1xSgZhDECFJr0z
         avWEoFIqDMZLCXdrc9y2BXM7GzadNSvuTxb0ev7bnidIyu3JecGbWvgeqAKK9sA2kaqz
         +0QXGVlon0/9E0sKUPMyNVq4wZRRUGGUPTq5GbAPNW+j/iMYPzNr74KnOVmbSoSNxfGN
         mAeVJJTDD+N/W/3Jy6uKZRzDr54w3VAp7VB/aMoiYoBIPUNeemyrwqWvpi9kjdZaeWH9
         Ew3ATEjVomceEa5zktfdXPzkZJ62RNE3IF/hVaDp0mGb3+QjM2pyX3MfXbX+jdWZWdse
         shHw==
X-Gm-Message-State: AOJu0YxUpgO5T1laqHxrXiEinltL8aHMAthmeLxarD45IGHJ0AMKcGXO
	sf+i5kN9ZLyN/5EoTNs/7erW580coSs=
X-Google-Smtp-Source: AGHT+IHldVpv0+Xv9NZOd4zjJTitZ0VJhRvZ+hYEPz8UXzKQBt437UMOdSWxM+Z9mhEc33yG//USNA==
X-Received: by 2002:a05:690c:c01:b0:586:9ccb:b5ad with SMTP id cl1-20020a05690c0c0100b005869ccbb5admr4094446ywb.46.1691796688625;
        Fri, 11 Aug 2023 16:31:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:680f:f8a3:c49b:84db? ([2600:1700:6cf8:1240:680f:f8a3:c49b:84db])
        by smtp.gmail.com with ESMTPSA id z125-20020a0dd783000000b00561e7639ee8sm1302241ywd.57.2023.08.11.16.31.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 16:31:28 -0700 (PDT)
Message-ID: <0164ca41-01bc-be14-2f99-b1c4400850b8@gmail.com>
Date: Fri, 11 Aug 2023 16:31:26 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next v2 4/6] bpf: Provide bpf_copy_from_user() and
 bpf_copy_to_user().
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Stanislav Fomichev <sdf@google.com>, thinker.li@gmail.com
Cc: bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 yonghong.song@linux.dev, kuifeng@meta.com
References: <20230811043127.1318152-1-thinker.li@gmail.com>
 <20230811043127.1318152-5-thinker.li@gmail.com> <ZNa+vhzXxYYOzk96@google.com>
 <6a634e79-db63-df29-9d18-93387191f937@gmail.com>
In-Reply-To: <6a634e79-db63-df29-9d18-93387191f937@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/11/23 16:27, Kui-Feng Lee wrote:
> 
> 
> On 8/11/23 16:05, Stanislav Fomichev wrote:
>> On 08/10, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <kuifeng@meta.com>
>>>
>>> Provide bpf_copy_from_user() and bpf_copy_to_user() to the BPF programs
>>> attached to cgroup/{set,get}sockopt. bpf_copy_to_user() is a new 
>>> kfunc to
>>> copy data from an kernel space buffer to a user space buffer. They 
>>> are only
>>> available for sleepable BPF programs. bpf_copy_to_user() is only 
>>> available
>>> to the BPF programs attached to cgroup/getsockopt.
>>>
>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>> ---
>>>   kernel/bpf/cgroup.c  |  6 ++++++
>>>   kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++++
>>>   2 files changed, 37 insertions(+)
>>>
>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>> index 5bf3115b265c..c15a72860d2a 100644
>>> --- a/kernel/bpf/cgroup.c
>>> +++ b/kernel/bpf/cgroup.c
>>> @@ -2461,6 +2461,12 @@ cg_sockopt_func_proto(enum bpf_func_id 
>>> func_id, const struct bpf_prog *prog)
>>>   #endif
>>>       case BPF_FUNC_perf_event_output:
>>>           return &bpf_event_output_data_proto;
>>> +
>>> +    case BPF_FUNC_copy_from_user:
>>> +        if (prog->aux->sleepable)
>>> +            return &bpf_copy_from_user_proto;
>>> +        return NULL;
>>
>> If we just allow copy to/from, I'm not sure I understand how the buffer
>> sharing between sleepable/non-sleepable works.
>>
>> Let's assume I have two progs in the chain:
>> 1. non-sleepable - copies the buffer, does some modifications; since
>>     we don't copy the buffer back after every prog run, the modifications
>>     stay in the kernel buffer
>> 2. sleepable - runs and just gets the user pointer? does it mean this
>>    sleepable program doesn't see the changes from (1)?

It is still visible from sleepable programs.  Sleepable programs
will receive a pointer to the buffer in the kernel.
And, BPF_SOCKOPT_FLAG_OPTVAL_USER is clear.

>>
>> IOW, do we need some custom sockopt copy_to/from that handle this
>> potential buffer location transparently or am I missing something?
>>
>> Assuming we want to support this at all. If we do, might deserve a
>> selftest.
> 
> It is why BPF_SOCKOPT_FLAG_OPTVAL_USER is there.
> It helps programs to make a right decision.
> However, I am going to remove bpf_copy_from_user()
> since we have bpf_so_optval_copy_to() and bpf_so_optval_copy_to_r().
> Does it make sense to you?

