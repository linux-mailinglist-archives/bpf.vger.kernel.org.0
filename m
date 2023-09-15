Return-Path: <bpf+bounces-10135-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 091CF7A15A5
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 07:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA86282586
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 05:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BE24C8D;
	Fri, 15 Sep 2023 05:46:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB38D3D6A
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 05:46:52 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A037B2722
	for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 22:46:50 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6c0d6fef60cso1032119a34.1
        for <bpf@vger.kernel.org>; Thu, 14 Sep 2023 22:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694756810; x=1695361610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CZRQ4CQ6CK+YkV5XceF78ucYRwapU0IqEIE5QvZWaU=;
        b=Zz+uMINPeTq/PinHIQ6ze0FrNAmyBRdXSSBPWVQKf4y+ALbKu2w4HqPU/p3ae9qmGb
         VzJ6xWNvRQnmeXYvL4V941hWdV8OUORhreFef9ybd3XWnagY4kFHG2lp4HN7amAzoXmd
         NipFyr2+4dP3RH6MW1x58aU0Fzg+FYWnwuF2qjCpS1wz+TIjmXMaEmnsem5snXTuAUrW
         o34gcjGhU5fB+e4zNZ/q7P2U1d/pzfgsU91e2arzXSjUSFul1XiXzGwo+JarxiIFjhlk
         2ZJNKUFTCHmkz9MEmZa/LK4ljxOLA8iVn0W+kONL9UMP9sO5xjyX+DP0/AM0MMS05Z7W
         vdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694756810; x=1695361610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/CZRQ4CQ6CK+YkV5XceF78ucYRwapU0IqEIE5QvZWaU=;
        b=cys5tgpyhkyGT2QdqtpvjxQ8dcm5P+vhol0tUiDsWARR91kUiou5Bp1vitSprD4jbg
         e5FzJJ3yx1eAuG0a30JpnGVjbkRqbztmNxth7HJGroy5YNj4XtCrsQFY7Ya370ZWaFCN
         wSAm79ff9YRvKopqo6xf56ESn8PYar2nEcb+Ioco8HkD87THey1ShZRPBfQ75bBOFyT7
         0OoKHMNIX1S202I7aX3X4pEoW64fnljAcafsp1dPwu26JVaA8vxKmb7ayLdJLZOrnmql
         vDdEZ4G7OrqrG4DWFEbK1BXPTslPFSqNbKLAmwrDEvzY+PZdYuUWD7m6VbUZA6QJzBGG
         7dlw==
X-Gm-Message-State: AOJu0YyTj/LZ6yQ7RmUHTufgfjWA3FGql6vurUf+w8h4x/IgXPB/u22r
	69ECUOGBRxUZXAwbMV+iJOby0g==
X-Google-Smtp-Source: AGHT+IEAf62T3zogBmbVWVikOJPTGmIh1M7XLPIKHovm7Mf2QTBEXIlgbiBNth20Wm493LlEXcFXGQ==
X-Received: by 2002:a9d:7316:0:b0:6bc:63ca:a245 with SMTP id e22-20020a9d7316000000b006bc63caa245mr579623otk.10.1694756809901;
        Thu, 14 Sep 2023 22:46:49 -0700 (PDT)
Received: from [10.84.145.144] ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id j4-20020aa78dc4000000b00686fe7b7b48sm2190209pfr.121.2023.09.14.22.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 22:46:49 -0700 (PDT)
Message-ID: <8f388b8f-bc19-5ad1-00ee-e67cdcdd9d4f@bytedance.com>
Date: Fri, 15 Sep 2023 13:46:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [External] Re: [PATCH bpf-next v2 5/6] bpf: teach the verifier to
 enforce css_iter and process_iter in RCU CS
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
 <20230912070149.969939-6-zhouchuyi@bytedance.com>
 <4c15c9fc-7c9f-9695-5c67-d3f214d04bd9@bytedance.com>
 <1f9cae15-979c-c049-78a9-f89d5cd1b53e@bytedance.com>
 <CAEf4BzZ18pjmav45mxhQ9eigJuAWnowgSm=+c==8dY0AUm2WdQ@mail.gmail.com>
From: Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <CAEf4BzZ18pjmav45mxhQ9eigJuAWnowgSm=+c==8dY0AUm2WdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello.

在 2023/9/15 07:26, Andrii Nakryiko 写道:
> On Thu, Sep 14, 2023 at 1:56 AM Chuyi Zhou <zhouchuyi@bytedance.com> wrote:
>>
>>
>>
>> 在 2023/9/13 21:53, Chuyi Zhou 写道:
>>> Hello.
>>>
>>> 在 2023/9/12 15:01, Chuyi Zhou 写道:
>>>> css_iter and process_iter should be used in rcu section. Specifically, in
>>>> sleepable progs explicit bpf_rcu_read_lock() is needed before use these
>>>> iters. In normal bpf progs that have implicit rcu_read_lock(), it's OK to
>>>> use them directly.
>>>>
>>>> This patch checks whether we are in rcu cs before we want to invoke
>>>> bpf_iter_process_new and bpf_iter_css_{pre, post}_new in
>>>> mark_stack_slots_iter(). If the rcu protection is guaranteed, we would
>>>> let st->type = PTR_TO_STACK | MEM_RCU. is_iter_reg_valid_init() will
>>>> reject if reg->type is UNTRUSTED.
>>>
>>> I use the following BPF Prog to test this patch:
>>>
>>> SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
>>> int iter_task_for_each_sleep(void *ctx)
>>> {
>>>       struct task_struct *task;
>>>       struct task_struct *cur_task = bpf_get_current_task_btf();
>>>
>>>       if (cur_task->pid != target_pid)
>>>           return 0;
>>>       bpf_rcu_read_lock();
>>>       bpf_for_each(process, task) {
>>>           bpf_rcu_read_unlock();
>>>           if (task->pid == target_pid)
>>>               process_cnt += 1;
>>>           bpf_rcu_read_lock();
>>>       }
>>>       bpf_rcu_read_unlock();
>>>       return 0;
>>> }
>>>
>>> Unfortunately, we can pass the verifier.
>>>
>>> Then I add some printk-messages before setting/clearing state to help
>>> debug:
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index d151e6b43a5f..35f3fa9471a9 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -1200,7 +1200,7 @@ static int mark_stack_slots_iter(struct
>>> bpf_verifier_env *env,
>>>                   __mark_reg_known_zero(st);
>>>                   st->type = PTR_TO_STACK; /* we don't have dedicated reg
>>> type */
>>>                   if (is_iter_need_rcu(meta)) {
>>> +                       printk("mark reg_addr : %px", st);
>>>                           if (in_rcu_cs(env))
>>>                                   st->type |= MEM_RCU;
>>>                           else
>>> @@ -11472,8 +11472,8 @@ static int check_kfunc_call(struct
>>> bpf_verifier_env *env, struct bpf_insn *insn,
>>>                           return -EINVAL;
>>>                   } else if (rcu_unlock) {
>>>                           bpf_for_each_reg_in_vstate(env->cur_state,
>>> state, reg, ({
>>> +                               printk("clear reg_addr : %px MEM_RCU :
>>> %d PTR_UNTRUSTED : %d\n ", reg, reg->type & MEM_RCU, reg->type &
>>> PTR_UNTRUSTED);
>>>                                   if (reg->type & MEM_RCU) {
>>> -                                       printk("clear reg addr : %lld",
>>> reg);
>>>                                           reg->type &= ~(MEM_RCU |
>>> PTR_MAYBE_NULL);
>>>                                           reg->type |= PTR_UNTRUSTED;
>>>                                   }
>>>
>>>
>>> The demsg log:
>>>
>>> [  393.705324] mark reg_addr : ffff88814e40e200
>>>
>>> [  393.706883] clear reg_addr : ffff88814d5f8000 MEM_RCU : 0
>>> PTR_UNTRUSTED : 0
>>>
>>> [  393.707353] clear reg_addr : ffff88814d5f8078 MEM_RCU : 0
>>> PTR_UNTRUSTED : 0
>>>
>>> [  393.708099] clear reg_addr : ffff88814d5f80f0 MEM_RCU : 0
>>> PTR_UNTRUSTED : 0
>>> ....
>>> ....
>>>
>>> I didn't see ffff88814e40e200 is cleared as expected because
>>> bpf_for_each_reg_in_vstate didn't find it.
>>>
>>> It seems when we are doing bpf_read_unlock() in the middle of iteration
>>> and want to clearing state through bpf_for_each_reg_in_vstate, we can
>>> not find the previous reg which we marked MEM_RCU/PTR_UNTRUSTED in
>>> mark_stack_slots_iter().
>>>
>>
>> bpf_get_spilled_reg will skip slots if they are not STACK_SPILL, but in
>> mark_stack_slots_iter() we has marked the slots *STACK_ITER*
>>
>> With the following change, everything seems work OK.
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index a3236651ec64..83c5ecccadb4 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -387,7 +387,7 @@ struct bpf_verifier_state {
>>
>>    #define bpf_get_spilled_reg(slot, frame)                               \
>>           (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             \
>> -         (frame->stack[slot].slot_type[0] == STACK_SPILL))             \
>> +         (frame->stack[slot].slot_type[0] == STACK_SPILL ||
>> frame->stack[slot].slot_type[0] == STACK_ITER))            \
>>            ? &frame->stack[slot].spilled_ptr : NULL)
>>
>> I am not sure whether this would harm some logic implicitly when using
>> bpf_get_spilled_reg/bpf_for_each_spilled_reg in other place. If so,
>> maybe we should add a extra parameter to control the picking behaviour.
>>
>> #define bpf_get_spilled_reg(slot, frame, stack_type)
>>                          \
>>          (((slot < frame->allocated_stack / BPF_REG_SIZE) &&             \
>>            (frame->stack[slot].slot_type[0] == stack_type))              \
>>           ? &frame->stack[slot].spilled_ptr : NULL)
>>
>> Thanks.
> 
> I don't think it's safe to just make bpf_get_spilled_reg, and
> subsequently bpf_for_each_reg_in_vstate and bpf_for_each_spilled_reg
> just suddenly start iterating iterator states and/or dynptrs. At least
> some of existing uses of those assume they are really working just
> with registers.

IIUC, when we are doing bpf_rcu_unlock, we do need to clear the state of 
reg including STACK_ITER.

Maybe here we only need change the logic when using 
bpf_for_each_reg_in_vstate to clear state in bpf_rcu_unlock and keep 
everything else unchanged ?

Thanks.

