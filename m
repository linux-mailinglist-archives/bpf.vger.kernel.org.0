Return-Path: <bpf+bounces-10134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4277A14E2
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 06:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C44E1C20B94
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 04:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBEB28EB;
	Fri, 15 Sep 2023 04:48:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D707F
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 04:48:33 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C5270B
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:48:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68fc9e0e22eso1416844b3a.1
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 21:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694753311; x=1695358111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaw28KTVfUJ6JehBcDHQwQvbxT1Y1h2oJS8hyYcKv3o=;
        b=hwMauNz1t6Hk+vCTs2obgkSJdN710d10b8m857rdeSsbfcW1vjzxmNm84zud73+1oS
         TJpReZiM8agqJ9AV4PgqqdpuqWXnJVVQKI/sFGM2FArhcwdmjkPfmdP3c/8P3dD+yAkX
         pMEzXZTgeWUJFfOcWZ0MDFw0fRYjspgaUN9EuGL6CNjeI+XWqmNla2Dx7BwnhbdeAN1S
         KjQE0WzrD/hw46U3dHsS3jYvTx71nFO+7aXUhP/Kj98NjG1aJ0Gqf52cYFf05OysA+re
         qKFY7ODRMGFx7xFHbbQzmjsw4BhAzWBxOhj4Vu+/GalfN6qO3d4Z+TocRtwdjC3Qoxeg
         2DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694753311; x=1695358111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jaw28KTVfUJ6JehBcDHQwQvbxT1Y1h2oJS8hyYcKv3o=;
        b=wKepEw+Whrr3QlWe/zLfjmr4Ocq5qC7jU4NJGXiTZ1g3svglQLViv4yAZyiwtcBTLr
         FbdQphcp9oA28UIQTSKaRUTSNm9+5sKkdte6DiUD2z65Jk5+h3JHIXByV6udGvMoTpwP
         qyWoJckCPqorOUYcT8U22Ti/DZF7eX2GM5AuEXjnE1b2h3HmKOjlmXW8euXVJiv5B035
         a9bf8RdIbUTdoOdzNV9QhfPovQSWa4W4KvLzie6Vx41NHpstQF9e4XoFUYc5aLjUN/LG
         Jdihp3O/vcBVxLjVEnesoitUAOMMIQxhFIPs4XRJ250kYUAWIdhfrwAJjq2azGFVCCHL
         Fv8w==
X-Gm-Message-State: AOJu0YxhLSVS1wAALZ3uai5IMUeoU2eYUKBIfm1SoKdhcTMTbKFGd3Vp
	IlsuxBEHsSQZMU7x4X4UjTEsgw==
X-Google-Smtp-Source: AGHT+IEfxBUt6y27PHg0YE8o2CH5cR/UnHAhf3GZ+zMRDUvNgHhhYdt0IgMzoI2/PHHzIYYIEGsyyQ==
X-Received: by 2002:a05:6a20:f397:b0:10c:7c72:bdf9 with SMTP id qr23-20020a056a20f39700b0010c7c72bdf9mr693462pzb.29.1694753311110;
        Thu, 14 Sep 2023 21:48:31 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b001beef2c9bffsm2447080plg.85.2023.09.14.21.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 21:48:30 -0700 (PDT)
Message-ID: <0175c7e4-7130-c5f5-018f-6ad3341eb9ef@bytedance.com>
Date: Fri, 15 Sep 2023 12:48:24 +0800
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
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello.

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

IIUC, we should define the following task_new kfunc

struct bpf_iter_task_kern {
	struct task_struct *start;
	struct task_struct *cur;	
	unsigned int flag;
} __attribute__((aligned(8)));

__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_css_task *it,
		struct task_struct *start, unsigned int flags)

If we want to iterate all threads of a task, just pass it to *start*,
and if we want to iterating all process in the system, users may need to 
pass a nullptr to the *start*. But it seems current BPF verifier will 
reject the nullptr to task_struct. The error message meybe:
"Possibly NULL pointer passed to trusted argx"

I noticed the __opt annotation in kfunc document. It seems with 
following we can pass the nullptr to *start*

__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_css_task *it,
		void *start__opt, unsigned int flags__szk)

However, in this way, user can pass any invalid pointer to the kfunc 
without verifying. Besides, it seems __opt is only allowed to use with 
__szk together and flags__szk is ambiguous in semantics.

Do you have better ideas? Or I missing something ?

Thanks


