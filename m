Return-Path: <bpf+bounces-65380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D7B21649
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 22:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319DA176511
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 20:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A3A2D9EED;
	Mon, 11 Aug 2025 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiMkrGT+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645862D97A1
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754943199; cv=none; b=BG60zX2zZxAVY5WpttwschZgI8/hpe/tSiQfAAGa7rDa/7TdvX8yoTjsxdLEiJD4fO9BvMS4sXCXWihnawaZW1wyPkwHzyw3xhGHZHZKWnsuJ7G+6/+szorTaKLZDfC877VbA5dDCF0gedV+n+moSRxj+iBuD8bCMOuwW43B93k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754943199; c=relaxed/simple;
	bh=28DOfV/coTljM+Ez3l+HBdeN4QGlXdQlWo8jgjKTFZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLPkpeEvOuFJjdlpnGJQsepXgSUpvd0pcEFQaz3r8RpMLpSS7N310jieDZtiyMoLORNkLQocSlSNMilB1E0D38gaEJcfC5OJ2SBXHbXY0JM+lWPhNXlro+2NH1zoWt1YDYPn4H6mnG932JyeQcpjTdQpg9/CpeHSorumSnJ3FrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiMkrGT+; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b8db5e9b35so2908018f8f.1
        for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 13:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754943195; x=1755547995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ap9C5zvy6xsTDVLhST0yDg1v5KfeWjBovpViApCp0EU=;
        b=GiMkrGT+e0w9n7JwWQqTTDYJ8FElMYPsGa50HhSrkBosfMz9yEx2ziy+KCzz5Bex0B
         NsN0cBF6b3fd+oJiSaJmhbCWZEarsFIzjc8o2rqZ+QT3ZejtHVDIZ11ujPXamlg1wrCI
         d1oT/kgxamurzvo8Il3jVdXuj7HoHH1whoZmcm28YEY4aPP22vjYq1KWrTXiF6/ptHvr
         xBwNkMA6wi6scB3agVbDu3cvaFLGMT+NWFOrScYbWF750u6Hk80LvUxsXEPHkalnMnxS
         iZr/LbheFWoWxdd0/Mzo6TdambWyR7aVIswU/eCuoZ3nbsQPKjcHwp2/ZNsw/HIUC7lL
         l4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754943195; x=1755547995;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ap9C5zvy6xsTDVLhST0yDg1v5KfeWjBovpViApCp0EU=;
        b=KNRtT4WCoqi57aqAIZ3Wr6JhVQC1ipKlDmyZ8TUn2Hr90F1L5bPdjwchMwIpTDaIbs
         mmR39PjwdGKzu5qMcwP2evC2JknKVg/WsaDcplDAX7XLOfvR7nxIy6KsQiDPRBFSpkYC
         MHBlW1eBt+QkbFrq1BlZzfz6hJxbKKK6ga/J305XeZ/nMaRdv3UOxWJPY3fBqGMS3UTR
         vjimDLZ7yFuM+TBZhQNSIoykfW/4BvZ51Nuf9cvJyAIUzhRuYWVD7xRch12cerSTK8xt
         I7TTbyZXHXYDk5ZNLsDOPc16vk4FZfX0T4bKVTWBWzhDwbiuIk49F33bTA7cv42pjum2
         4Amg==
X-Gm-Message-State: AOJu0YypBV+Rw1IEbo+tgnvMDPyH2eilQjg0QYRlNyfmFf40FLWAR7/3
	PHFHMew3UFFHh9vgeWHdg/zoMh6ZqEraG7JR/ZEO2eO6LvwUOyn2JrkY
X-Gm-Gg: ASbGncsk778f1Pbo75pqjxSPiXYqsPpouwxr6O9OXkQkEzTrMUgguzY7xeICKiW/erl
	yUg8Oo8ORpR8Md4lBbBxLCmCZhZy3saTS6zbmC7BCxU3G/MCOK4N3TypVj3llc25zc3KWj7RsT4
	dyJ9nTzJWM5/YsGDoBakCnPVrX5e/4GPrQwR8SmTBtVlpCcO0hfVSU4TQL7UCTIiq+sl9F3n4Lu
	bizAf3bZtkUOFYGy4qTs46fAUFC7lRpZT1WZM5fnEt2kOMpaJVFSL2HQ2ygzD9y2zSc4xSquyxd
	OGKf2o+qsXMbUl7gGm5zSWw+6Q7Sibxe1r5WH24HATimgBVdTZ82H0LPvtxZaElfpR2WSwGqKqQ
	T8Pyu+Hfhf55fsU6uADx+XDk3hscRPcVukZheLp2Bx/GijQCoLxCW3Kx7hAgnWAAVN6Uo
X-Google-Smtp-Source: AGHT+IEooIF54gsk3jahNouWim6OSEwrTxZe3lz/SjZC1Alo685cYS0K7XQoA2+w4Yr7AW/VRBTE0A==
X-Received: by 2002:a05:6000:310f:b0:3b7:7c3b:1073 with SMTP id ffacd0b85a97d-3b911014a84mr697079f8f.52.1754943194262;
        Mon, 11 Aug 2025 13:13:14 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325:ecc:2975:dca1:e79? ([2620:10d:c092:600::1:50de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e0bfc79fsm31187086f8f.56.2025.08.11.13.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 13:13:13 -0700 (PDT)
Message-ID: <38e750e0-9bdf-461f-b270-79cbe5c121df@gmail.com>
Date: Mon, 11 Aug 2025 21:13:11 +0100
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
 <b4f88016-8eaa-4297-9816-e2855817aa8a@gmail.com>
 <CAP01T74foMvntpkj9iTE38WRgiCpGWMK_5XQStb+qkDuv=YMYA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAP01T74foMvntpkj9iTE38WRgiCpGWMK_5XQStb+qkDuv=YMYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/9/25 04:04, Kumar Kartikeya Dwivedi wrote:
> On Fri, 8 Aug 2025 at 02:44, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>> On 8/7/25 19:55, Kumar Kartikeya Dwivedi wrote:
>>> On Wed, 6 Aug 2025 at 16:46, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Implementation of the bpf_task_work_schedule kfuncs.
>>>>
>>>> Main components:
>>>>    * struct bpf_task_work_context – Metadata and state management per task
>>>> work.
>>>>    * enum bpf_task_work_state – A state machine to serialize work
>>>>    scheduling and execution.
>>>>    * bpf_task_work_schedule() – The central helper that initiates
>>>> scheduling.
>>>>    * bpf_task_work_callback() – Invoked when the actual task_work runs.
>>>>    * bpf_task_work_irq() – An intermediate step (runs in softirq context)
>>>> to enqueue task work.
>>>>    * bpf_task_work_cancel_and_free() – Cleanup for deleted BPF map entries.
>>>>
>>>> Flow of task work scheduling
>>>>    1) bpf_task_work_schedule_* is called from BPF code.
>>>>    2) Transition state from STANDBY to PENDING.
>>>>    3) irq_work_queue() schedules bpf_task_work_irq().
>>>>    4) Transition state from PENDING to SCHEDULING.
>>>>    4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>>>>    transitions to SCHEDULED.
>>>>    5) Task work calls bpf_task_work_callback(), which transition state to
>>>>    RUNNING.
>>>>    6) BPF callback is executed
>>>>    7) Context is cleaned up, refcounts released, state set back to
>>>>    STANDBY.
>>>>
>>>> Map value deletion
>>>> If map value that contains bpf_task_work_context is deleted, BPF map
>>>> implementation calls bpf_task_work_cancel_and_free().
>>>> Deletion is handled by atomically setting state to FREED and
>>>> releasing references or letting scheduler do that, depending on the
>>>> last state before the deletion:
>>>>    * SCHEDULING: release references in bpf_task_work_cancel_and_free(),
>>>>    expect bpf_task_work_irq() to cancel task work.
>>>>    * SCHEDULED: release references and try to cancel task work in
>>>>    bpf_task_work_cancel_and_free().
>>>>     * other states: one of bpf_task_work_irq(), bpf_task_work_schedule(),
>>>>     bpf_task_work_callback() should cleanup upon detecting the state
>>>>     switching to FREED.
>>>>
>>>> The state transitions are controlled with atomic_cmpxchg, ensuring:
>>>>    * Only one thread can successfully enqueue work.
>>>>    * Proper handling of concurrent deletes (BPF_TW_FREED).
>>>>    * Safe rollback if task_work_add() fails.
>>>>
>>> In general I am not sure why we need so many acquire/release pairs.
>>> Why not use test_and_set_bit etc.? Or simply cmpxchg?
>>> What ordering of stores are we depending on that merits
>>> acquire/release ordering?
>>> We should probably document explicitly.
>>>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>>>    kernel/bpf/helpers.c | 188 ++++++++++++++++++++++++++++++++++++++++++-
>>>>    1 file changed, 186 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>> index 516286f67f0d..4c8b1c9be7aa 100644
>>>> --- a/kernel/bpf/helpers.c
>>>> +++ b/kernel/bpf/helpers.c
>>>> @@ -25,6 +25,8 @@
>>>>    #include <linux/kasan.h>
>>>>    #include <linux/bpf_verifier.h>
>>>>    #include <linux/uaccess.h>
>>>> +#include <linux/task_work.h>
>>>> +#include <linux/irq_work.h>
>>>>
>>>>    #include "../../lib/kstrtox.h"
>>>>
>>>> @@ -3702,6 +3704,160 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
>>>>
>>>>    typedef void (*bpf_task_work_callback_t)(struct bpf_map *, void *, void *);
>>>>
>>>> +enum bpf_task_work_state {
>>>> +       /* bpf_task_work is ready to be used */
>>>> +       BPF_TW_STANDBY = 0,
>>>> +       /* bpf_task_work is getting scheduled into irq_work */
>>>> +       BPF_TW_PENDING,
>>>> +       /* bpf_task_work is in irq_work and getting scheduled into task_work */
>>>> +       BPF_TW_SCHEDULING,
>>>> +       /* bpf_task_work is scheduled into task_work successfully */
>>>> +       BPF_TW_SCHEDULED,
>>>> +       /* callback is running */
>>>> +       BPF_TW_RUNNING,
>>>> +       /* BPF map value storing this bpf_task_work is deleted */
>>>> +       BPF_TW_FREED,
>>>> +};
>>>> +
>>>> +struct bpf_task_work_context {
>>>> +       /* map that contains this structure in a value */
>>>> +       struct bpf_map *map;
>>>> +       /* bpf_task_work_state value, representing the state */
>>>> +       atomic_t state;
>>>> +       /* bpf_prog that schedules task work */
>>>> +       struct bpf_prog *prog;
>>>> +       /* task for which callback is scheduled */
>>>> +       struct task_struct *task;
>>>> +       /* notification mode for task work scheduling */
>>>> +       enum task_work_notify_mode mode;
>>>> +       /* callback to call from task work */
>>>> +       bpf_task_work_callback_t callback_fn;
>>>> +       struct callback_head work;
>>>> +       struct irq_work irq_work;
>>>> +} __aligned(8);
>>> I will echo Alexei's comments about the layout. We cannot inline all
>>> this in map value.
>>> Allocation using an init function or in some control function is
>>> probably the only way.
>>>
>>>> +
>>>> +static bool task_work_match(struct callback_head *head, void *data)
>>>> +{
>>>> +       struct bpf_task_work_context *ctx = container_of(head, struct bpf_task_work_context, work);
>>>> +
>>>> +       return ctx == data;
>>>> +}
>>>> +
>>>> +static void bpf_reset_task_work_context(struct bpf_task_work_context *ctx)
>>>> +{
>>>> +       bpf_prog_put(ctx->prog);
>>>> +       bpf_task_release(ctx->task);
>>>> +       rcu_assign_pointer(ctx->map, NULL);
>>>> +}
>>>> +
>>>> +static void bpf_task_work_callback(struct callback_head *cb)
>>>> +{
>>>> +       enum bpf_task_work_state state;
>>>> +       struct bpf_task_work_context *ctx;
>>>> +       struct bpf_map *map;
>>>> +       u32 idx;
>>>> +       void *key;
>>>> +       void *value;
>>>> +
>>>> +       rcu_read_lock_trace();
>>>> +       ctx = container_of(cb, struct bpf_task_work_context, work);
>>>> +
>>>> +       state = atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_RUNNING);
>>>> +       if (state == BPF_TW_SCHEDULED)
>>>> +               state = atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULED, BPF_TW_RUNNING);
>>>> +       if (state == BPF_TW_FREED)
>>>> +               goto out;
>>> I am leaving out commenting on this, since I expect it to change per
>>> later comments.
>>>
>>>> +
>>>> +       map = rcu_dereference(ctx->map);
>>>> +       if (!map)
>>>> +               goto out;
>>>> +
>>>> +       value = (void *)ctx - map->record->task_work_off;
>>>> +       key = (void *)map_key_from_value(map, value, &idx);
>>>> +
>>>> +       migrate_disable();
>>>> +       ctx->callback_fn(map, key, value);
>>>> +       migrate_enable();
>>>> +
>>>> +       /* State is running or freed, either way reset. */
>>>> +       bpf_reset_task_work_context(ctx);
>>>> +       atomic_cmpxchg_release(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY);
>>>> +out:
>>>> +       rcu_read_unlock_trace();
>>>> +}
>>>> +
>>>> +static void bpf_task_work_irq(struct irq_work *irq_work)
>>>> +{
>>>> +       struct bpf_task_work_context *ctx;
>>>> +       enum bpf_task_work_state state;
>>>> +       int err;
>>>> +
>>>> +       ctx = container_of(irq_work, struct bpf_task_work_context, irq_work);
>>>> +
>>>> +       rcu_read_lock_trace();
>>> What's the idea behind rcu_read_lock_trace? Let's add a comment.
>>>
>>>> +       state = atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING);
>>>> +       if (state == BPF_TW_FREED) {
>>>> +               bpf_reset_task_work_context(ctx);
>>>> +               goto out;
>>>> +       }
>>>> +
>>>> +       err = task_work_add(ctx->task, &ctx->work, ctx->mode);
>>> Racy, SCHEDULING->FREE state claim from cancel_and_free will release ctx->task.
>> Thanks for pointing this out, I missed that case.
>>>> +       if (err) {
>>>> +               state = atomic_cmpxchg_acquire(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_PENDING);
>>> Races here look fine, since we don't act on FREED (for this block
>>> atleast), cancel_and_free doesn't act on seeing PENDING,
>>> so there is interlocking.
>>>
>>>> +               if (state == BPF_TW_SCHEDULING) {
>>>> +                       bpf_reset_task_work_context(ctx);
>>>> +                       atomic_cmpxchg_release(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
>>>> +               }
>>>> +               goto out;
>>>> +       }
>>>> +       state = atomic_cmpxchg_release(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
>>>> +       if (state == BPF_TW_FREED)
>>>> +               task_work_cancel_match(ctx->task, task_work_match, ctx);
>>> It looks like there is a similar race condition here.
>>> If BPF_TW_SCHEDULING is set, cancel_and_free may invoke and attempt
>>> bpf_task_release() from bpf_reset_task_work_context().
>>> Meanwhile, we will access ctx->task here directly after seeing BPF_TW_FREED.
>> Yeah, we should release task_work in this function in case SCHEDULING
>> gets transitioned into FREED.
>>>> +out:
>>>> +       rcu_read_unlock_trace();
>>>> +}
>>>> +
>>>> +static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work_context *ctx,
>>>> +                                 struct bpf_map *map, bpf_task_work_callback_t callback_fn,
>>>> +                                 struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
>>>> +{
>>>> +       struct bpf_prog *prog;
>>>> +
>>>> +       BTF_TYPE_EMIT(struct bpf_task_work);
>>>> +
>>>> +       prog = bpf_prog_inc_not_zero(aux->prog);
>>>> +       if (IS_ERR(prog))
>>>> +               return -EPERM;
>>>> +
>>>> +       if (!atomic64_read(&map->usercnt)) {
>>>> +               bpf_prog_put(prog);
>>>> +               return -EPERM;
>>>> +       }
>>>> +       task = bpf_task_acquire(task);
>>>> +       if (!task) {
>>>> +               bpf_prog_put(prog);
>>>> +               return -EPERM;
>>>> +       }
>>>> +
>>>> +       if (atomic_cmpxchg_acquire(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
>>> If we are reusing map values, wouldn't a freed state stay perpetually freed?
>>> I.e. after the first delete of array elements etc. it becomes useless.
>>> Every array map update would invoke a cancel_and_free.
>>> Who resets it?
>> I'm not sure I understand the question, the idea is that if element is
>> deleted from map, we
>> transition state to FREED and make sure refcounts of the task and prog
>> are released.
>>
>> An element is returned into STANDBY state after task_work is completed
>> or failed, so it can be reused.
>> Could you please elaborate on the scenario you have in mind?
> I guess I am confused about where we will go from FREED to STANDBY, if
> we set it to BPF_TW_FREED in cancel_and_free.
> When you update an array map element, we always do
> bpf_obj_free_fields. Typically, this operation leaves the field in a
> reusable state.
> I don't see a FREED->STANDBY transition (after going from
> [SCHEDULED|SCHEDULING]->FREED, only RUNNING->STANDBY in the callback.
I see your point, arraymap does not overwrite those special fields on 
update, thanks!


