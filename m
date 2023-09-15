Return-Path: <bpf+bounces-10149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E316C7A21E2
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB851C20F94
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 15:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9AD1097D;
	Fri, 15 Sep 2023 15:04:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976230CF0
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 15:04:03 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACED271C
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 08:03:57 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf1935f6c2so16623975ad.1
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694790237; x=1695395037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYaTEiec+VTKSIfvTEBOea2V06zSSSiqn+piG2v1UMY=;
        b=PMuxnMhb32gX7gC1k8o+3kYuHVnbWmoAEFoD8bkfrqKt6TdH4lCTL8LArPXVa7XZaO
         watcEU1rfP4JpgIkWRulNd17mS6rt8rIhd3jLsbc6o4WRZNpyEHDRWdISQPTT8wtPOZC
         TuTFGsFcW0kN3MoNzo6YdVg/fFossXfN3zX5srnPl93r/d5OvTqsZ/DCAYv75vBUbiOp
         3m/r38YxcQWeXXl0bEOO5zumhI6OsS0pfSdsbuuDk+H/UvOJYvLyp9CKzur1g/j6KVs2
         WXzY42AJLjpt6I7zYnfEz14ZeKbbxNtaBKFyeYW6KcKGci3KKjN1xy38wpRy/Ez2ZbnO
         bZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694790237; x=1695395037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VYaTEiec+VTKSIfvTEBOea2V06zSSSiqn+piG2v1UMY=;
        b=uHTdxTGsxdW2y3OKKv9BctxoC0MH4j2Rrtq3nUhSlz2ibm7aNuIfVCBbdKQD03zh6r
         cMmKzXQr4nja8j2XAexg+SowQM2rYSgSusJrfUiVTAcgJT6LffC3+ruCB/sX1sEJ+kBF
         X6Mix31AQPGcVeio9iz6rLZWbzfqW9hMnS8jKBn1h3Rp6ajtFXEIEl6M+D6JK9N44dW9
         3wFixbzG9ppm/AzwnGgYkZOk9t/kWNHJyk1Et09WKUeAT4LkzeYYWPyoP/wIfESS5Z0u
         YUyob0T+fegO62ay6Wcs1owjLVG3fMuOjhqA8ELiod+RwjtBx3aIilT/RmFjqfcvAuBe
         +KWg==
X-Gm-Message-State: AOJu0YyJuTL0T90TNSuv/lykhPeb1zMn7M+ePzPafa7lReaQsWLmEVqv
	1G30hiP9hVMX15DHF8likTVOWcTGDfoE4Sgh1jg=
X-Google-Smtp-Source: AGHT+IG7yPkHkH4Ec5YHVK6WB9g0C+AWUASnwVaFsz01N8/vP+da6nD4AmscR53xEkuCQ8BiUF7gPw==
X-Received: by 2002:a17:902:e80b:b0:1bc:3908:14d with SMTP id u11-20020a170902e80b00b001bc3908014dmr7842218plg.2.1694790236600;
        Fri, 15 Sep 2023 08:03:56 -0700 (PDT)
Received: from [10.5.75.238] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id q6-20020a17090311c600b001bbb25dd3a7sm3607798plh.187.2023.09.15.08.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 08:03:55 -0700 (PDT)
Message-ID: <30eadbff-8340-a721-362b-ff82de03cb9f@bytedance.com>
Date: Fri, 15 Sep 2023 23:03:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v2 3/6] bpf: Introduce process open coded
 iterator kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-4-zhouchuyi@bytedance.com>
 <CAEf4BzbsBUGiPJ+_RG3c3WdEWNQy2b6h60kLDREcXDsNp3E0_Q@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzbsBUGiPJ+_RG3c3WdEWNQy2b6h60kLDREcXDsNp3E0_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/9/15 07:26, Andrii Nakryiko 写道:
> On Tue, Sep 12, 2023 at 12:02 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This patch adds kfuncs bpf_iter_process_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_process in open-coded iterator
>> style. BPF programs can use these kfuncs or through bpf_for_each macro to
>> iterate all processes in the system.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/uapi/linux/bpf.h       |  4 ++++
>>   kernel/bpf/helpers.c           |  3 +++
>>   kernel/bpf/task_iter.c         | 29 +++++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h |  4 ++++
>>   tools/lib/bpf/bpf_helpers.h    |  5 +++++
>>   5 files changed, 45 insertions(+)
>>
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index de02c0971428..befa55b52e29 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -7322,4 +7322,8 @@ struct bpf_iter_css_task {
>>          __u64 __opaque[1];
>>   } __attribute__((aligned(8)));
>>
>> +struct bpf_iter_process {
>> +       __u64 __opaque[1];
>> +} __attribute__((aligned(8)));
>> +
>>   #endif /* _UAPI__LINUX_BPF_H__ */
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index d6a16becfbb9..9b7d2c6f99d1 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2507,6 +2507,9 @@ BTF_ID_FLAGS(func, bpf_iter_num_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_new, KF_ITER_NEW)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_next, KF_ITER_NEXT | KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_iter_css_task_destroy, KF_ITER_DESTROY)
>> +BTF_ID_FLAGS(func, bpf_iter_process_new, KF_ITER_NEW)
>> +BTF_ID_FLAGS(func, bpf_iter_process_next, KF_ITER_NEXT | KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_iter_process_destroy, KF_ITER_DESTROY)
>>   BTF_ID_FLAGS(func, bpf_dynptr_adjust)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>>   BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index d8539cc05ffd..9d1927dc3a06 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -851,6 +851,35 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
>>          kfree(kit->css_it);
>>   }
>>
>> +struct bpf_iter_process_kern {
>> +       struct task_struct *tsk;
>> +} __attribute__((aligned(8)));
>> +
> 
> Few high level thoughts. I think it would be good to follow
> SEC("iter/task") naming and approach. Open-coded iterators in many
> ways are in-kernel counterpart to iterator programs, so keeping them
> close enough within reason is useful for knowledge transfer.
> 
> SEC("iter/task") allows to:
> a) iterate all threads in the system
> b) iterate all threads for a given TGID
> c) it also allows to "iterate" a single thread or process, but that's
> a bit less relevant for in-kernel iterator, but we can still support
> them, why not?
> 
> I'm not sure if it supports iterating all processes (as in group
> leaders of each task group) in the system, but if it's possible I
> think we should support it at least for open-coded iterator, seems
> like a very useful functionality.
> 
> So to that end, let's design a small set of input arguments for
> bpf_iter_process_new() that would allow to specify this as flags +
> either (optional) struct task_struct * pointer to represent
> task/process or PID/TGID.
> 

Another concern from Alexei was the readability of the API of open-coded 
in BPF Program[1].

bpf_for_each(task, curr) is straightforward. Users can easily understand 
that this API does the same thing as 'for_each_process' in kernel.

However, if we keep the approach of SEC("iter/task")

enum ITER_ITEM {
	ITER_TASK,
	ITER_THREAD,
}

__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_process *it, struct 
task_struct *group_task, enum ITER_ITEM type)

the API have to chang:


bpf_for_each(task, curr, NULL, ITERATE_TASK) // iterate all process in 
the  system
bpf_for_each(task, curr, group_leader, ITERATE_THREAD) // iterate all 
thread of group_leader
bpf_for_each(task, curr, NULL, ITERATE_THREAD) //iterate all threads of 
all the process in the system

Useres may guess what are this API actually doing....

So, I'm thinking if we can add a layer of abstraction to hide the 
details from the users:

#define bpf_for_each_process(task) \
	bpf_for_each(task, curr, NULL, ITERATE_TASK)


It would be nice if you could give me some better suggestions.

Thanks!

[1] 
https://lore.kernel.org/lkml/CAADnVQLbDWUxFen-RS67C86sOE5DykEPD8xyihJ2RnG1WEnTQg@mail.gmail.com/

