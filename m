Return-Path: <bpf+bounces-7769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53E77C0A5
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 21:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A5641C20B1F
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E86CA77;
	Mon, 14 Aug 2023 19:20:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DC1C2CE
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 19:20:34 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E11703
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 12:20:31 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-589c7801d1cso34583257b3.0
        for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 12:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692040831; x=1692645631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uBfnVquCgUlz1NFEVJ8NXL7tsQQyKc1+rr7eQmg4g4k=;
        b=aPvuLbvZtCEq8WbXe5wln9wxL97W90QrXdt1z5OpTzk2VGE6Ebx+vSJXmrb1NEUPEM
         4Wk3Q9Rj+Tb8RAaTEim3CltsZvLNjzYIeUgpd8kD3VimKETTh4HW4KAgTTt6BNyT5TeO
         lQERrmByhV36WzPvuQ2FCdStF2CnLp0L5p15cdTQXsKgNJvMo8oCA7qAQu0oeyGQ9uKv
         0JEbUEKC6GnbrrQkDZKUqHoist6W7dMl8NllOom9PP5c5QAt/gV8NIza9Ftqbp8BGBwr
         uMmSnU1eSHXwhkFsivN3CbEcyVfX+fzXj+3/ldZS3ZkY2/4fwM9j6Tpws863DpRzsa/z
         vb+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692040831; x=1692645631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBfnVquCgUlz1NFEVJ8NXL7tsQQyKc1+rr7eQmg4g4k=;
        b=Uh0gTuPOf1pmDNxVb3zaEpi12C14MqzXyzFmdcnw00JqN1gl/5hOaQ7qqQNShTOTwd
         Cy2SmPKt368lpM0f0I4KVqx4PVZbUSmVlQIZG01TO8D21VDl6mX1/yd92DwPFrvPYKwf
         0JnYgvqoYACI3qTnhb0W1QJsoIy76afAEUxyBPD0LnajWhEb3T8bQFaSJLm6FPhUjaUX
         MZkopLeP1JmzvQUg1YkoG/9yQNRxlZ3fsmxR7QLdrqCv/WdhEYSTBDNE9jf/S+rA3XPo
         bkwC1l6MKOBXSIOSS24+jt9uxQu9MZg0esjuJkOxb7Fr5qiy5rfplXJ+fMIYC81qsI2H
         S7Dw==
X-Gm-Message-State: AOJu0Yzn+d0E//fTSRTpktvO8nHX+lhh79kvF7VUN111EdK4xOAOAsjC
	WEycUAjZ8CRJ++89XNn7LVg=
X-Google-Smtp-Source: AGHT+IH93xN1/EbUiMjug0J8gPct18TrRmslbyLCqWLt1+ZcdiYKaGgABAZct8KSfy1lNz6q88zkmA==
X-Received: by 2002:a25:26c4:0:b0:d4b:ab7b:17ed with SMTP id m187-20020a2526c4000000b00d4bab7b17edmr10237682ybm.4.1692040830752;
        Mon, 14 Aug 2023 12:20:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:5518:1905:5685:939d? ([2600:1700:6cf8:1240:5518:1905:5685:939d])
        by smtp.gmail.com with ESMTPSA id a81-20020a254d54000000b00d0069942a3esm2585711ybb.43.2023.08.14.12.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:20:30 -0700 (PDT)
Message-ID: <b3c8c714-088b-6c9e-5e23-fd1817d8cfae@gmail.com>
Date: Mon, 14 Aug 2023 12:20:28 -0700
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
To: Stanislav Fomichev <sdf@google.com>
Cc: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org, yonghong.song@linux.dev, kuifeng@meta.com
References: <20230811043127.1318152-1-thinker.li@gmail.com>
 <20230811043127.1318152-5-thinker.li@gmail.com> <ZNa+vhzXxYYOzk96@google.com>
 <6a634e79-db63-df29-9d18-93387191f937@gmail.com>
 <0164ca41-01bc-be14-2f99-b1c4400850b8@gmail.com>
 <ZNpfTBh4cC1oW8Cf@google.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZNpfTBh4cC1oW8Cf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/14/23 10:07, Stanislav Fomichev wrote:
> On 08/11, Kui-Feng Lee wrote:
>>
>>
>> On 8/11/23 16:27, Kui-Feng Lee wrote:
>>>
>>>
>>> On 8/11/23 16:05, Stanislav Fomichev wrote:
>>>> On 08/10, thinker.li@gmail.com wrote:
>>>>> From: Kui-Feng Lee <kuifeng@meta.com>
>>>>>
>>>>> Provide bpf_copy_from_user() and bpf_copy_to_user() to the BPF programs
>>>>> attached to cgroup/{set,get}sockopt. bpf_copy_to_user() is a new
>>>>> kfunc to
>>>>> copy data from an kernel space buffer to a user space buffer.
>>>>> They are only
>>>>> available for sleepable BPF programs. bpf_copy_to_user() is only
>>>>> available
>>>>> to the BPF programs attached to cgroup/getsockopt.
>>>>>
>>>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>>>> ---
>>>>>    kernel/bpf/cgroup.c  |  6 ++++++
>>>>>    kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++++
>>>>>    2 files changed, 37 insertions(+)
>>>>>
>>>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>>>> index 5bf3115b265c..c15a72860d2a 100644
>>>>> --- a/kernel/bpf/cgroup.c
>>>>> +++ b/kernel/bpf/cgroup.c
>>>>> @@ -2461,6 +2461,12 @@ cg_sockopt_func_proto(enum bpf_func_id
>>>>> func_id, const struct bpf_prog *prog)
>>>>>    #endif
>>>>>        case BPF_FUNC_perf_event_output:
>>>>>            return &bpf_event_output_data_proto;
>>>>> +
>>>>> +    case BPF_FUNC_copy_from_user:
>>>>> +        if (prog->aux->sleepable)
>>>>> +            return &bpf_copy_from_user_proto;
>>>>> +        return NULL;
>>>>
>>>> If we just allow copy to/from, I'm not sure I understand how the buffer
>>>> sharing between sleepable/non-sleepable works.
>>>>
>>>> Let's assume I have two progs in the chain:
>>>> 1. non-sleepable - copies the buffer, does some modifications; since
>>>>      we don't copy the buffer back after every prog run, the modifications
>>>>      stay in the kernel buffer
>>>> 2. sleepable - runs and just gets the user pointer? does it mean this
>>>>     sleepable program doesn't see the changes from (1)?
>>
>> It is still visible from sleepable programs.  Sleepable programs
>> will receive a pointer to the buffer in the kernel.
>> And, BPF_SOCKOPT_FLAG_OPTVAL_USER is clear.
>>
>>>>
>>>> IOW, do we need some custom sockopt copy_to/from that handle this
>>>> potential buffer location transparently or am I missing something?
>>>>
>>>> Assuming we want to support this at all. If we do, might deserve a
>>>> selftest.
>>>
>>> It is why BPF_SOCKOPT_FLAG_OPTVAL_USER is there.
>>> It helps programs to make a right decision.
>>> However, I am going to remove bpf_copy_from_user()
>>> since we have bpf_so_optval_copy_to() and bpf_so_optval_copy_to_r().
>>> Does it make sense to you?
> 
> Ah, so that's where it's handled. I didn't read that far :-)
> In this case yes, let's have only those helpers.
> 
> Btw, do we also really need bpf_so_optval_copy_to_r? If we are doing
> dynptr, let's only have bpf_so_optval_copy_to version?

Don't you think bpf_so_optval_copy_to_r() is handy to copy
a simple string to the user space?

> 
> I'd also call them something like bpf_sockopt_copy_{to,from}. That
> "_so_optval_" is not super intuitive imho.

Agree!


