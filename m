Return-Path: <bpf+bounces-11015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D24B7B1131
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 05:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id B255E281B5A
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB50538B;
	Thu, 28 Sep 2023 03:30:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F331365
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 03:29:59 +0000 (UTC)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243F7114
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 20:29:58 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-77410032cedso770797185a.1
        for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 20:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695871797; x=1696476597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuGpzWUz7WllqNPIiFw60y239AVC+GmSn3mdK28s17Q=;
        b=MrUXHCgF6csYJaZtGtqH9CzwM3OyIVjou75BAKkQ7RG2fYn2Cc9EUExWhuAg9AaqqR
         IxcdMpfsdTMEwpxA6MyixWsZJz396U9tPOM1dg5AT7p36t+J4XmG0BUqLjmNsQ5fOcrC
         PYRbQsy5jvQJs8oKb3IbAn8fEgTdHwkaHo/Z8JLNd/eFE1Yzofz5R0O5MzyTgRL7WN6K
         lr/Xk7dE+nbHRB9CUNW7Lca8J0UfWHSp8NmbIVx+ZkSn0D1CNyAKiM5P/M3NzJm08L1y
         +MlOaRW4Baqwy/LOo+9oMwJnDCGh1Nj1bXVswS3HcFUPWDrD+6TDC6HeEZWdt7deUhYP
         y1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695871797; x=1696476597;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KuGpzWUz7WllqNPIiFw60y239AVC+GmSn3mdK28s17Q=;
        b=l58iLNQk97Wof4uQy3M3KTsqI/qerCoBiT3EAsSuok3MVSwPOa/foQ/wtCqOaF9piQ
         JsKRjrXDvMofXbS6ItngUuBlpx+Olopkenrs3tdcwgE/8pH52NBsG085y0lnMENDO+c8
         g0HXt+gzXlR5P85cXWLnA8EeyJRw809DBg8H0TmYCs0Ke714b9dq31H/5LMNVfBdavgE
         pWY6O6XM6ckNx2WAQNzTmxuho+EGp5giKjK5CTsV6oVIlN6YOiE/w/1YUH5aZf8svsb9
         3AhyHVWZT674XR88sz31JgCbZS6WSjqL8kdLE/r52iSp0CBwsryXizI5Ji8YAzb/qeHn
         jT3g==
X-Gm-Message-State: AOJu0Ywccxvh9qLV+bsfFDSjFR0pANJFltLnzxb06SLn1no3O6UJ2gfJ
	7TOvLvtQX+WTN/C7K5lgPzeYmQ==
X-Google-Smtp-Source: AGHT+IEyfMhyk45JsD3Dgb9LYtD3L+aE0Fq7RIPQuBa2iSA5NwdKFkK0qzCUM/UGwHr0VcmesJoAGA==
X-Received: by 2002:a05:620a:221a:b0:774:f7b:f0a with SMTP id m26-20020a05620a221a00b007740f7b0f0amr44046qkh.76.1695871797184;
        Wed, 27 Sep 2023 20:29:57 -0700 (PDT)
Received: from [10.255.173.165] ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id j17-20020aa78dd1000000b0068c1ac1784csm12541842pfr.59.2023.09.27.20.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Sep 2023 20:29:56 -0700 (PDT)
Message-ID: <716adfa5-bd5d-3fe2-108c-ff24b2e81420@bytedance.com>
Date: Thu, 28 Sep 2023 11:29:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH bpf-next v3 3/7] bpf: Introduce task open coded iterator
 kfuncs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
 linux-kernel@vger.kernel.org
References: <20230925105552.817513-1-zhouchuyi@bytedance.com>
 <20230925105552.817513-4-zhouchuyi@bytedance.com>
 <CAEf4BzZFBFPMBs6t4GM7GRt-c-Po9KkQqxQ_Zo9vuG=KuqeLzQ@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzZFBFPMBs6t4GM7GRt-c-Po9KkQqxQ_Zo9vuG=KuqeLzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

在 2023/9/28 07:20, Andrii Nakryiko 写道:
> On Mon, Sep 25, 2023 at 3:56 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>> This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
>> creation and manipulation of struct bpf_iter_task in open-coded iterator
>> style. BPF programs can use these kfuncs or through bpf_for_each macro to
>> iterate all processes in the system.
>>
>> The API design keep consistent with SEC("iter/task"). bpf_iter_task_new()
>> accepts a specific task and iterating type which allows:
>> 1. iterating all process in the system
>>
>> 2. iterating all threads in the system
>>
>> 3. iterating all threads of a specific task
>> Here we also resuse enum bpf_iter_task_type and rename BPF_TASK_ITER_TID
>> to BPF_TASK_ITER_THREAD, rename BPF_TASK_ITER_TGID to BPF_TASK_ITER_PROC.
>>
>> The newly-added struct bpf_iter_task has a name collision with a selftest
>> for the seq_file task iter's bpf skel, so the selftests/bpf/progs file is
>> renamed in order to avoid the collision.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>>   include/linux/bpf.h                           |  8 +-
>>   kernel/bpf/helpers.c                          |  3 +
>>   kernel/bpf/task_iter.c                        | 96 ++++++++++++++++---
>>   .../testing/selftests/bpf/bpf_experimental.h  |  5 +
>>   .../selftests/bpf/prog_tests/bpf_iter.c       | 18 ++--
>>   .../{bpf_iter_task.c => bpf_iter_tasks.c}     |  0
>>   6 files changed, 106 insertions(+), 24 deletions(-)
>>   rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c => bpf_iter_tasks.c} (100%)
>>
> 
> [...]
> 
>> @@ -692,9 +692,9 @@ static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, struct b
>>   static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info *aux, struct seq_file *seq)
>>   {
>>          seq_printf(seq, "task_type:\t%s\n", iter_task_type_names[aux->task.type]);
>> -       if (aux->task.type == BPF_TASK_ITER_TID)
>> +       if (aux->task.type == BPF_TASK_ITER_THREAD)
>>                  seq_printf(seq, "tid:\t%u\n", aux->task.pid);
>> -       else if (aux->task.type == BPF_TASK_ITER_TGID)
>> +       else if (aux->task.type == BPF_TASK_ITER_PROC)
>>                  seq_printf(seq, "pid:\t%u\n", aux->task.pid);
>>   }
>>
>> @@ -856,6 +856,80 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it)
>>          bpf_mem_free(&bpf_global_ma, kit->css_it);
>>   }
>>
>> +struct bpf_iter_task {
>> +       __u64 __opaque[2];
>> +       __u32 __opaque_int[1];
> 
> this should be __u64 __opaque[3], because struct takes full 24 bytes
> 
>> +} __attribute__((aligned(8)));
>> +
>> +struct bpf_iter_task_kern {
>> +       struct task_struct *task;
>> +       struct task_struct *pos;
>> +       unsigned int type;
>> +} __attribute__((aligned(8)));
>> +
>> +__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struct *task, unsigned int type)
> 
> nit: type -> flags, so we can add a bit more stuff, if necessary
> 
>> +{
>> +       struct bpf_iter_task_kern *kit = (void *)it;
> 
> empty line after variable declarations
> 
>> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) != sizeof(struct bpf_iter_task));
>> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
>> +                                       __alignof__(struct bpf_iter_task));
> 
> and I'd add empty line here to keep BUILD_BUG_ON block separate
> 
>> +       kit->task = kit->pos = NULL;
>> +       switch (type) {
>> +       case BPF_TASK_ITER_ALL:
>> +       case BPF_TASK_ITER_PROC:
>> +       case BPF_TASK_ITER_THREAD:
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       if (type == BPF_TASK_ITER_THREAD)
>> +               kit->task = task;
>> +       else
>> +               kit->task = &init_task;
>> +       kit->pos = kit->task;
>> +       kit->type = type;
>> +       return 0;
>> +}
>> +
>> +__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it)
>> +{
>> +       struct bpf_iter_task_kern *kit = (void *)it;
>> +       struct task_struct *pos;
>> +       unsigned int type;
>> +
>> +       type = kit->type;
>> +       pos = kit->pos;
>> +
>> +       if (!pos)
>> +               goto out;
>> +
>> +       if (type == BPF_TASK_ITER_PROC)
>> +               goto get_next_task;
>> +
>> +       kit->pos = next_thread(kit->pos);
>> +       if (kit->pos == kit->task) {
>> +               if (type == BPF_TASK_ITER_THREAD) {
>> +                       kit->pos = NULL;
>> +                       goto out;
>> +               }
>> +       } else
>> +               goto out;
>> +
>> +get_next_task:
>> +       kit->pos = next_task(kit->pos);
>> +       kit->task = kit->pos;
>> +       if (kit->pos == &init_task)
>> +               kit->pos = NULL;
> 
> I can't say I completely follow the logic (e.g., for
> BPF_TASK_ITER_PROC, why do we do next_task() on first next() call)?
> Can you elabore the expected behavior for various combinations of
> types and starting task argument?
> 

Thanks for the review.

The expected behavior of current implementation is:

BPF_TASK_ITER_PROC:

init_task->first_process->second_process->...->last_process->init_task

We would exit before visiting init_task again.

BPF_TASK_ITER_THREAD:

group_task->first_thread->second_thread->...->last_thread->group_task

We would exit before visiting group_task again.

BPF_TASK_ITER_ALL:

init_task -> first_process -> second_process -> ...
                 |                    |
		-> first_thread..    |
				     -> first_thread

Actually, every next() call, we would return the "pos" which was 
prepared by previous next() call, and use next_task()/next_thread() to 
update kit->pos. Once we meet the exit condition (next_task() return 
init_task or next_thread() return group_task), we would update kit->pos 
to NULL. In this way, when next() is called again, we will terminate the 
iteration.

Here "kit->pos = NULL;" means we would return the last valid "pos" and 
will return NULL in next call to exit from the iteration.

Am I miss something important?

Thanks.




