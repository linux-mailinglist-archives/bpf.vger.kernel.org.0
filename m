Return-Path: <bpf+bounces-65245-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A801B1DFFD
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 02:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AEC1889786
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 00:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F917BA3;
	Fri,  8 Aug 2025 00:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA8ldpF2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B29CA52
	for <bpf@vger.kernel.org>; Fri,  8 Aug 2025 00:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754613875; cv=none; b=R561Q7C7EuGMzqUeJy3/fmoXWXHSr8dev/Mj2wMJAD201nqwgkt4Z/YxuYxHsoaDbMsgUNjJEQG67WnqHrqfz1aCpgZeLqUCDgeluLGXvxIT5nLyWB8n6RUoVg0LtcntR5e9ecCrqsZSv/T3016LWozX4u7ZY4LZDxDbM8vBnzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754613875; c=relaxed/simple;
	bh=0zEIQUOwitU1c+UQdvX9B/Xhb2L5PmGCMN8dtJ77DIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+BZN6E6pGYibZx//tayL4JfJhMo2fAyM/jKyJtYvFRIO9VxuzqiI5x6EcrdPbr06Xc2RHTac746XhM8AwlNXLtF4J9s6djpEdzL8+Tp8R0VkSSFHVBYk/Nng9bgNF1a3D6sCNrFepgsdTOC3oIkfPZqrpzdKEe0DtO63w2iBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA8ldpF2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b783d851e6so1368759f8f.0
        for <bpf@vger.kernel.org>; Thu, 07 Aug 2025 17:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754613871; x=1755218671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ota4PLUL0x5B9NVbLQQYaI9TtgjQlMbrVtS1LODsGuE=;
        b=cA8ldpF2FD0TsRyWYb3TPUuKsB52g3dqx7N+4fC/5yoBgTqmFTGFGh83Gde9zfgfDQ
         58xDvlaUzW1ZPZYpnci/CMsWrTxlElwW9DcZMZc9hjljiNR2ckZYrGZvRndi96YDiO5u
         AyMrZyHdck72FAJr0EiS9YnXXOzkraEO6Y9ggbJ05LE6KIuB5yFlJlE5w/L+OasfVMXw
         j//3nQfwHP/9bnPhtH+NDbh4rrIfXPEPolp6+Cpype/gG6xEWlB0ghcw/BlRNDQM4ZVj
         ZcOLUGLoegrT30C64eCJOLhFW6Q0fIbLYPKQSifKBxa142eLtJTp0gk/lbFevUhYGUrl
         gLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754613871; x=1755218671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ota4PLUL0x5B9NVbLQQYaI9TtgjQlMbrVtS1LODsGuE=;
        b=StDmJSSAiOkfVan0V4513I/rq0jwCdx2AOldoCpILBJIkSYTltBghhJ7Ps3lc1oHe8
         5tHIBTFndJob3ahXcWQmpTaEiJJpBQlwBFrdG+tieSWX/t1plk2dW+qe3u59eBFWFc/Y
         wu2GMQfnzwdKdy5R2jJOoMkAVv684jA6Jxqqhgter/8TFVweV6lJJu7LTEwRwWu7m1fd
         wUb32gP6epxbc7dFX+gQ1v/RgUjiOT29oISERRlzm3X5y8Vt0L+dapyVxYiouvJS3ibG
         xx4Xr/qV3bMEsHs8CIJBRtZ5s21Bc9RHJ2KYdJJvIGNNNZmC95rEH8hMqtcQeFlTMR1M
         x8Xw==
X-Gm-Message-State: AOJu0Yx72rlFYQJ8SX56LQb4QWjbFXwkzt1RtKXAVvaG971Ey2UHIc0s
	NExYBNGa3heWfILiiKBNAAy0YaO6RxTFcxMssXdo+CMILfXYEfY1OoHG
X-Gm-Gg: ASbGncuaP2u9AT+3vEI+xJQ6rFZfjK9rffJg1AFJ7GqA9IqktvNe/EtJrJAtxx799DG
	fSC8CPxDOZ5Ia/sa7Tkti9ExYcpl6jE7oPLsWKDzag3S0CEMvMFcEgwrlXk4+cTgIHPeq7pmN3q
	Q0DteynMFlhaFEw5w7XbzeCUXesK5aQnC1o7EsKHjGKrwHbmOI1o4vnTWwSb5UWcwZxQrpRWe4v
	aLPoBTcxnOLVGKoDXd6RpMU7+7lTfSgZqlKfnWwO56GE5lsnAHTQ97HV2RaUZBhG1tBrwzY+TR0
	wt7dZnF67ZQq7IWk3frAg99FuijCv1neVl/wjk/e9nOmsz2mrX1afqtqjU5ib9D2QzNJnZqTSxa
	akUZS/2r5eRn19bEN/5t25ah6YkRB/xt7VNYDM7J1oOjvSAcca0ilHXdGAHAIPgkUgUxbSdZ3CF
	gBKarDkA==
X-Google-Smtp-Source: AGHT+IHAjvtJYqMNBVzmtU/wcEJdznb9uRrmVRExl/WpFOvxOjxZ05J9ECjEet6ukbmrs/EaxCp85Q==
X-Received: by 2002:a05:6000:26ca:b0:3b7:9bfe:4f6f with SMTP id ffacd0b85a97d-3b900b7be30mr683136f8f.44.1754613870868;
        Thu, 07 Aug 2025 17:44:30 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9? ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583ff76sm111275295e9.5.2025.08.07.17.44.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 17:44:30 -0700 (PDT)
Message-ID: <b4f88016-8eaa-4297-9816-e2855817aa8a@gmail.com>
Date: Fri, 8 Aug 2025 01:44:29 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 3/4] bpf: task work scheduling kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250806144554.576706-1-mykyta.yatsenko5@gmail.com>
 <20250806144554.576706-4-mykyta.yatsenko5@gmail.com>
 <CAP01T76ZArSz8r8z2q3J-76N=cQrPh_YBcyMog6VVHcfUNssJg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAP01T76ZArSz8r8z2q3J-76N=cQrPh_YBcyMog6VVHcfUNssJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/7/25 19:55, Kumar Kartikeya Dwivedi wrote:
> On Wed, 6 Aug 2025 at 16:46, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Implementation of the bpf_task_work_schedule kfuncs.
>>
>> Main components:
>>   * struct bpf_task_work_context – Metadata and state management per task
>> work.
>>   * enum bpf_task_work_state – A state machine to serialize work
>>   scheduling and execution.
>>   * bpf_task_work_schedule() – The central helper that initiates
>> scheduling.
>>   * bpf_task_work_callback() – Invoked when the actual task_work runs.
>>   * bpf_task_work_irq() – An intermediate step (runs in softirq context)
>> to enqueue task work.
>>   * bpf_task_work_cancel_and_free() – Cleanup for deleted BPF map entries.
>>
>> Flow of task work scheduling
>>   1) bpf_task_work_schedule_* is called from BPF code.
>>   2) Transition state from STANDBY to PENDING.
>>   3) irq_work_queue() schedules bpf_task_work_irq().
>>   4) Transition state from PENDING to SCHEDULING.
>>   4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>>   transitions to SCHEDULED.
>>   5) Task work calls bpf_task_work_callback(), which transition state to
>>   RUNNING.
>>   6) BPF callback is executed
>>   7) Context is cleaned up, refcounts released, state set back to
>>   STANDBY.
>>
>> Map value deletion
>> If map value that contains bpf_task_work_context is deleted, BPF map
>> implementation calls bpf_task_work_cancel_and_free().
>> Deletion is handled by atomically setting state to FREED and
>> releasing references or letting scheduler do that, depending on the
>> last state before the deletion:
>>   * SCHEDULING: release references in bpf_task_work_cancel_and_free(),
>>   expect bpf_task_work_irq() to cancel task work.
>>   * SCHEDULED: release references and try to cancel task work in
>>   bpf_task_work_cancel_and_free().
>>    * other states: one of bpf_task_work_irq(), bpf_task_work_schedule(),
>>    bpf_task_work_callback() should cleanup upon detecting the state
>>    switching to FREED.
>>
>> The state transitions are controlled with atomic_cmpxchg, ensuring:
>>   * Only one thread can successfully enqueue work.
>>   * Proper handling of concurrent deletes (BPF_TW_FREED).
>>   * Safe rollback if task_work_add() fails.
>>
> In general I am not sure why we need so many acquire/release pairs.
> Why not use test_and_set_bit etc.? Or simply cmpxchg?
> What ordering of stores are we depending on that merits
> acquire/release ordering?
> We should probably document explicitly.
>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 188 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 186 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 516286f67f0d..4c8b1c9be7aa 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -25,6 +25,8 @@
>>   #include <linux/kasan.h>
>>   #include <linux/bpf_verifier.h>
>>   #include <linux/uaccess.h>
>> +#include <linux/task_work.h>
>> +#include <linux/irq_work.h>
>>
>>   #include "../../lib/kstrtox.h"
>>
>> @@ -3702,6 +3704,160 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
>>
>>   typedef void (*bpf_task_work_callback_t)(struct bpf_map *, void *, void *);
>>
>> +enum bpf_task_work_state {
>> +       /* bpf_task_work is ready to be used */
>> +       BPF_TW_STANDBY = 0,
>> +       /* bpf_task_work is getting scheduled into irq_work */
>> +       BPF_TW_PENDING,
>> +       /* bpf_task_work is in irq_work and getting scheduled into task_work */
>> +       BPF_TW_SCHEDULING,
>> +       /* bpf_task_work is scheduled into task_work successfully */
>> +       BPF_TW_SCHEDULED,
>> +       /* callback is running */
>> +       BPF_TW_RUNNING,
>> +       /* BPF map value storing this bpf_task_work is deleted */
>> +       BPF_TW_FREED,
>> +};
>> +
>> +struct bpf_task_work_context {
>> +       /* map that contains this structure in a value */
>> +       struct bpf_map *map;
>> +       /* bpf_task_work_state value, representing the state */
>> +       atomic_t state;
>> +       /* bpf_prog that schedules task work */
>> +       struct bpf_prog *prog;
>> +       /* task for which callback is scheduled */
>> +       struct task_struct *task;
>> +       /* notification mode for task work scheduling */
>> +       enum task_work_notify_mode mode;
>> +       /* callback to call from task work */
>> +       bpf_task_work_callback_t callback_fn;
>> +       struct callback_head work;
>> +       struct irq_work irq_work;
>> +} __aligned(8);
> I will echo Alexei's comments about the layout. We cannot inline all
> this in map value.
> Allocation using an init function or in some control function is
> probably the only way.
>
>> +
>> +static bool task_work_match(struct callback_head *head, void *data)
>> +{
>> +       struct bpf_task_work_context *ctx = container_of(head, struct bpf_task_work_context, work);
>> +
>> +       return ctx == data;
>> +}
>> +
>> +static void bpf_reset_task_work_context(struct bpf_task_work_context *ctx)
>> +{
>> +       bpf_prog_put(ctx->prog);
>> +       bpf_task_release(ctx->task);
>> +       rcu_assign_pointer(ctx->map, NULL);
>> +}
>> +
>> +static void bpf_task_work_callback(struct callback_head *cb)
>> +{
>> +       enum bpf_task_work_state state;
>> +       struct bpf_task_work_context *ctx;
>> +       struct bpf_map *map;
>> +       u32 idx;
>> +       void *key;
>> +       void *value;
>> +
>> +       rcu_read_lock_trace();
>> +       ctx = container_of(cb, struct bpf_task_work_context, work);
>> +
>> +       state = atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_RUNNING);
>> +       if (state == BPF_TW_SCHEDULED)
>> +               state = atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULED, BPF_TW_RUNNING);
>> +       if (state == BPF_TW_FREED)
>> +               goto out;
> I am leaving out commenting on this, since I expect it to change per
> later comments.
>
>> +
>> +       map = rcu_dereference(ctx->map);
>> +       if (!map)
>> +               goto out;
>> +
>> +       value = (void *)ctx - map->record->task_work_off;
>> +       key = (void *)map_key_from_value(map, value, &idx);
>> +
>> +       migrate_disable();
>> +       ctx->callback_fn(map, key, value);
>> +       migrate_enable();
>> +
>> +       /* State is running or freed, either way reset. */
>> +       bpf_reset_task_work_context(ctx);
>> +       atomic_cmpxchg_release(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY);
>> +out:
>> +       rcu_read_unlock_trace();
>> +}
>> +
>> +static void bpf_task_work_irq(struct irq_work *irq_work)
>> +{
>> +       struct bpf_task_work_context *ctx;
>> +       enum bpf_task_work_state state;
>> +       int err;
>> +
>> +       ctx = container_of(irq_work, struct bpf_task_work_context, irq_work);
>> +
>> +       rcu_read_lock_trace();
> What's the idea behind rcu_read_lock_trace? Let's add a comment.
>
>> +       state = atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING);
>> +       if (state == BPF_TW_FREED) {
>> +               bpf_reset_task_work_context(ctx);
>> +               goto out;
>> +       }
>> +
>> +       err = task_work_add(ctx->task, &ctx->work, ctx->mode);
> Racy, SCHEDULING->FREE state claim from cancel_and_free will release ctx->task.
Thanks for pointing this out, I missed that case.
>
>> +       if (err) {
>> +               state = atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_PENDING);
> Races here look fine, since we don't act on FREED (for this block
> atleast), cancel_and_free doesn't act on seeing PENDING,
> so there is interlocking.
>
>> +               if (state == BPF_TW_SCHEDULING) {
>> +                       bpf_reset_task_work_context(ctx);
>> +                       atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
>> +               }
>> +               goto out;
>> +       }
>> +       state = atomic_cmpxchg_release(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
>> +       if (state == BPF_TW_FREED)
>> +               task_work_cancel_match(ctx->task, task_work_match, ctx);
> It looks like there is a similar race condition here.
> If BPF_TW_SCHEDULING is set, cancel_and_free may invoke and attempt
> bpf_task_release() from bpf_reset_task_work_context().
> Meanwhile, we will access ctx->task here directly after seeing BPF_TW_FREED.
Yeah, we should release task_work in this function in case SCHEDULING 
gets transitioned into FREED.
>
>> +out:
>> +       rcu_read_unlock_trace();
>> +}
>> +
>> +static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work_context *ctx,
>> +                                 struct bpf_map *map, bpf_task_work_callback_t callback_fn,
>> +                                 struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
>> +{
>> +       struct bpf_prog *prog;
>> +
>> +       BTF_TYPE_EMIT(struct bpf_task_work);
>> +
>> +       prog = bpf_prog_inc_not_zero(aux->prog);
>> +       if (IS_ERR(prog))
>> +               return -EPERM;
>> +
>> +       if (!atomic64_read(&map->usercnt)) {
>> +               bpf_prog_put(prog);
>> +               return -EPERM;
>> +       }
>> +       task = bpf_task_acquire(task);
>> +       if (!task) {
>> +               bpf_prog_put(prog);
>> +               return -EPERM;
>> +       }
>> +
>> +       if (atomic_cmpxchg_acquire(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
> If we are reusing map values, wouldn't a freed state stay perpetually freed?
> I.e. after the first delete of array elements etc. it becomes useless.
> Every array map update would invoke a cancel_and_free.
> Who resets it?
I'm not sure I understand the question, the idea is that if element is 
deleted from map, we
transition state to FREED and make sure refcounts of the task and prog 
are released.

An element is returned into STANDBY state after task_work is completed 
or failed, so it can be reused.
Could you please elaborate on the scenario you have in mind?
>
>
>
>> +               bpf_task_release(task);
>> +               bpf_prog_put(prog);
>> +               return -EBUSY;
>> +       }
>> +
>> +       ctx->task = task;
>> +       ctx->callback_fn = callback_fn;
>> +       ctx->prog = prog;
>> +       ctx->mode = mode;
>> +       init_irq_work(&ctx->irq_work, bpf_task_work_irq);
>> +       init_task_work(&ctx->work, bpf_task_work_callback);
>> +       rcu_assign_pointer(ctx->map, map);
>> +
>> +       irq_work_queue(&ctx->irq_work);
>> +
>> +       return 0;
>> +}
>> +
>>   /**
>>    * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL mode
>>    * @task: Task struct for which callback should be scheduled
>> @@ -3718,7 +3874,8 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task,
>>                                                bpf_task_work_callback_t callback,
>>                                                void *aux__prog)
>>   {
>> -       return 0;
>> +       return bpf_task_work_schedule(task, (struct bpf_task_work_context *)tw, map__map,
>> +                                     callback, aux__prog, TWA_SIGNAL);
>>   }
>>
>>   /**
>> @@ -3738,13 +3895,38 @@ __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task,
>>                                                bpf_task_work_callback_t callback,
>>                                                void *aux__prog)
>>   {
>> -       return 0;
>> +       enum task_work_notify_mode mode;
>> +
>> +       mode = task == current && in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
>> +       return bpf_task_work_schedule(task, (struct bpf_task_work_context *)tw, map__map,
>> +                                     callback, aux__prog, mode);
>>   }
>>
>>   __bpf_kfunc_end_defs();
>>
>>   void bpf_task_work_cancel_and_free(void *val)
>>   {
>> +       struct bpf_task_work_context *ctx = val;
>> +       enum bpf_task_work_state state;
>> +
>> +       state = atomic_xchg(&ctx->state, BPF_TW_FREED);
>> +       switch (state) {
>> +       case BPF_TW_SCHEDULED:
>> +               task_work_cancel_match(ctx->task, task_work_match, ctx);
>> +               fallthrough;
>> +       /* Scheduling codepath is trying to schedule task work, reset context here. */
>> +       case BPF_TW_SCHEDULING:
>> +               bpf_reset_task_work_context(ctx);
>> +               break;
>> +       /* work is not initialized, mark as freed and exit */
>> +       case BPF_TW_STANDBY:
>> +       /* The context is in interim state, scheduling logic should cleanup. */
>> +       case BPF_TW_PENDING:
>> +       /* Callback is already running, it should reset context upon finishing. */
>> +       case BPF_TW_RUNNING:
>> +       default:
>> +               break;
>> +       }
>>   }
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3770,6 +3952,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_rbtree_root, KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_rbtree_left, KF_RET_NULL)
>>   BTF_ID_FLAGS(func, bpf_rbtree_right, KF_RET_NULL)
>> +BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
>> +BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
>>
>>   #ifdef CONFIG_CGROUPS
>>   BTF_ID_FLAGS(func, bpf_cgroup_acquire, KF_ACQUIRE | KF_RCU | KF_RET_NULL)
>> --
>> 2.50.1
>>
>>


