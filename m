Return-Path: <bpf+bounces-8187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0B17833C0
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 22:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A663E280F6E
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 20:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E92F1172F;
	Mon, 21 Aug 2023 20:38:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA134C9E
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 20:38:52 +0000 (UTC)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACAA133;
	Mon, 21 Aug 2023 13:38:46 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-58c4f61ca12so41935147b3.3;
        Mon, 21 Aug 2023 13:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692650325; x=1693255125;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZMgIfl4a5s3HRnRSJTF8h2TABZodak2uL9lblu+IJo=;
        b=fLgfDhIAR/p4F/Zykqv+z69ELyxRjGEw6+0cD2CLB0jaXYz/mCbEnB89kP2dorQ/45
         RN0A+KkYw1/ELezzr/0qZZ1Fo7ji9YD2Ca/6bujpSW4+0jVvSLcXffH9xdL8seOAorit
         46hDDSp7D+aOvoGTE4qhB+BFiFMTP8UOoYU41gzTxhE0qnYUciAi5N76DWP+WagdzGxT
         724xVajMxjDQrN118BAWl6BzajhZsRS3D7rpOJn9aoxTm7suarR44k2C3Ctl9iJ2P+rO
         hcaN0xptB+p8FDg1sUZiHMpfdkgCYnWWKWQ0JE2ewKw3pyvuVVa3yRb6b2CRSOVspNjE
         GhWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692650325; x=1693255125;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZMgIfl4a5s3HRnRSJTF8h2TABZodak2uL9lblu+IJo=;
        b=GqMYqK3PLr7fruL+CvBVE2petaOiIVzPybXmp2jX317ET0Mar+vrcBs5trOlHfVlbU
         ESvZQDFEplvueno8/JEVE5J8gC1AvRh9iPSjjNcl9DQg/JbztI1+O2qbFGW00LzY72TR
         4nz6kX7cjPFrPInWbyZyFbX/lkxnUrHzt7tLrnptpq85sqsb0aaNlbyaI/9IEL1bZkbq
         7hYLnoqmkIT0haj/0oUW+L5w0TQ0OIqezrtMr7gAYXqhS6fgMdlRFk83lR3KPGFLDnOq
         S3/eDTsflLSTKVf8bWVfAccT6MiUxxLPjwoEaWOosfcTythptu7Cg6GB05rH4vU7qt2v
         9XmA==
X-Gm-Message-State: AOJu0Yyo6t7gqjL8DEcQdVd04xufW9eN/KBDJS5OcL2FbORPyvKaToqd
	EsiLgsafaPJU2W9p4JZjM8I=
X-Google-Smtp-Source: AGHT+IGmAWSbZKNdlpuAfEO99J7PRSxpOz1KPy8TOobrkGmaiECWg13F6HBHmCaSgeR1oRW1HgK1Uw==
X-Received: by 2002:a0d:d94e:0:b0:56c:e706:2e04 with SMTP id b75-20020a0dd94e000000b0056ce7062e04mr9188569ywe.0.1692650325321;
        Mon, 21 Aug 2023 13:38:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:62f2:baa4:a7c0:4986? ([2600:1700:6cf8:1240:62f2:baa4:a7c0:4986])
        by smtp.gmail.com with ESMTPSA id j189-20020a816ec6000000b0058fafe95f98sm1697946ywc.114.2023.08.21.13.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 13:38:44 -0700 (PDT)
Message-ID: <1c0c57da-6b2b-f12d-f397-4ddd467bb57c@gmail.com>
Date: Mon, 21 Aug 2023 13:38:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 get/put_task_struct
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Oleg Nesterov <oleg@redhat.com>, Yonghong Song <yhs@fb.com>,
 Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
 Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230821150909.GA2431@redhat.com>
 <20230821200311.GA22497@redhat.com>
 <17b47be9-d3bd-e475-906b-26b73eb920bd@gmail.com>
In-Reply-To: <17b47be9-d3bd-e475-906b-26b73eb920bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/21/23 13:32, Kui-Feng Lee wrote:
> 
> 
> On 8/21/23 13:03, Oleg Nesterov wrote:
>> get_pid_task() makes no sense, the code does put_task_struct() soon 
>> after.
>> Use find_task_by_pid_ns() instead of find_pid_ns + get_pid_task and kill
>> kill put_task_struct(), this allows to do get_task_struct() only once
>> before return.
>>
>> While at it, kill the unnecessary "if (!pid)" check in the "if (!*tid)"
>> block, this matches the next usage of find_pid_ns() + get_pid_task() in
>> this function.
>>
>> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>> ---
>>   kernel/bpf/task_iter.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
>> index 4d1125108014..1589ec3faded 100644
>> --- a/kernel/bpf/task_iter.c
>> +++ b/kernel/bpf/task_iter.c
>> @@ -42,9 +42,6 @@ static struct task_struct 
>> *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>>       if (!*tid) {
>>           /* The first time, the iterator calls this function. */
>>           pid = find_pid_ns(common->pid, common->ns);
>> -        if (!pid)
>> -            return NULL;
>> -
>>           task = get_pid_task(pid, PIDTYPE_TGID);
>>           if (!task)
>>               return NULL;
>> @@ -66,17 +63,12 @@ static struct task_struct 
>> *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>>           return task;
>>       }
>> -    pid = find_pid_ns(common->pid_visiting, common->ns);
>> -    if (!pid)
>> -        return NULL;
>> -
>> -    task = get_pid_task(pid, PIDTYPE_PID);
>> +    task = find_task_by_pid_ns(common->pid_visiting, common->ns);
>>       if (!task)
>>           return NULL;
>>   retry:
>>       next_task = next_thread(task);
>> -    put_task_struct(task);
> 
> It called get_task_struct() against this task to hold a refcount at the
> previous time calling this function. When will it release the refcount?


Oh! I missed the fact that the caller will handle it.

> 
>>       saved_tid = *tid;
>>       *tid = __task_pid_nr_ns(next_task, PIDTYPE_PID, common->ns);
>> @@ -88,7 +80,6 @@ static struct task_struct 
>> *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>>           return NULL;
>>       }
>> -    get_task_struct(next_task);
>>       common->pid_visiting = *tid;
>>       if (skip_if_dup_files && task->files == 
>> task->group_leader->files) {
>> @@ -96,6 +87,7 @@ static struct task_struct 
>> *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>>           goto retry;
>>       }
>> +    get_task_struct(next_task);
>>       return next_task;
>>   }

