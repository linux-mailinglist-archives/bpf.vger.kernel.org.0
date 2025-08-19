Return-Path: <bpf+bounces-66025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD7B2CBB6
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 20:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BA597A889F
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 18:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134A423D7EA;
	Tue, 19 Aug 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jrWR7b9k"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3A1C84A0
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755627372; cv=none; b=fpRFo0O54fbD1Ig9OiP7SHACgLrbLhYDrhBOn35YjA0/hLgw3c9ZgUtjyuFSReuEvH+Nd/MV9TgSpwFJ/BygzdCaPuV5ng6IYfow3vJL9BNAJ3ZcXY0UU51m/gc9ZhE+au0uYy1zE6C7k9WUu3JevCqnTHyP60domT5TwjW0gbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755627372; c=relaxed/simple;
	bh=EpDks8ITvM44WtZGhFFJDLDnRZgAfznZ0cizpFX4p7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilYSJDd324ypDhWtLkm9CFfvmw9I8I2ryZLC0RKoGbT4Ivfw2U42PMQY7eMLcRg1jJCYSPeNsyt/ANDis+0hLcc8OOuFrfVqWR4MP+8p5lY/1t/8BNP1E6LE8J/1V5SYg5vcdksC4rk9X0f5pXOxSKo0V/STL3umUTQR31I1ywQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jrWR7b9k; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b0c52f3so28256075e9.3
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 11:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755627368; x=1756232168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nuGJtTAsTtd0/ObUaFOiD0Paj8xDlcMViOrEXsDuXj4=;
        b=jrWR7b9kTiwbmJ+gRIay4tEn18pPVUeYmGHeyRjsdbTDV74gzH2UxvzzopeQsN2jJg
         0NfEzNivBr+UoxoXnuckPdd44so+yBYf26/up06glelPbYtWhsIud+tpMCqbjokBwk6U
         PTzQB/WgKm8hawkhfqkuPPL6fDweldcKGwL/8C365czY8yST1KUmM+lsjAVdKj296l4+
         OA4WiUBrp1UksQKqCdk9h3KKwEkXlWxi14Lo3liiszMw3VPk+gPOwiJKcVP7rE58btzR
         Zu1F0pBO/lZYDHpWPWc8M7foiyNRWPw5kzbbi+phMZ0MRN+bFgBtYF72m9gHZlqU16O4
         Wctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755627368; x=1756232168;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuGJtTAsTtd0/ObUaFOiD0Paj8xDlcMViOrEXsDuXj4=;
        b=SjfmUBAgtqNPZ97VShK8CEorsXIRYEQmfGFlKog1qCh1svTE/ZE7fTVChHWjBRib3C
         /oWvVOJqgz/GhF3suqWnfMTFlhJtmu9MNv1SIXjGBbUrxWeIXdAYIXtsnvquWUx7QLGl
         JZ+reFnYnZRaJs64Tg2kx5+pvxz2VCcowrh3e13+lDq1De6Ckou5X6kQpRqFqUoKmiZr
         KzammnDU1v5m5Q7DQ1v31a3TB+Oa7cjGg9Sxs4Ofgp9jcpQOuFsU0zspmy0CR8BYpJ5j
         X3yh4O/TB7+hgRLbkFw9QtO7YOus52NohzocJRUaFBkWliKKVRxoCVpmAclpVqx3J7eB
         sIrg==
X-Gm-Message-State: AOJu0YzLU8jnMR9NvOPggvRjpHspN/zaK62y2PRyXdyhOr8Iym31v05Q
	jsHmzXtx4k1xPnexWYRaFlYlniiFGJfwWyX3HncOHriw/96XvxP40gfO
X-Gm-Gg: ASbGncsT3YaUl4zDKLfXFDeD1n3pd4uxtAMZA/xTAWxsEBw5FM8PLPsX0UQ8GkJ7QDC
	b3L5Q1UPO5z1j2IgJcqShvFzLAkogPcGYXfQpNxxSdiTbYQ2F/4ZeDxB7nz+CnspCSSmlSuiShy
	sH72TVIQUqFTM+S5vHYP5NfHHEsjsmOhQtst7cB1fn+mum4kn4Todw1uvKP5mDVFBI+K1qZ+DIy
	ATB31INJQz8w/VVcLOd+xDWcFnEcpPeZYXOvkdUmoThTbyNDUzvhlAq2p0QncVNJSwx2HPDXHcd
	18JTUSewUKwRIL6StYWYdS6i5RHD5yX18ulUBYWiRedTzptOaYqvHgBXjQogIceboOgVASqOnMX
	SrmT2O6lYtbvhLN76e4pIsVHleSNKCMd/XW64Lp0=
X-Google-Smtp-Source: AGHT+IEursWnnBafp7olT0TYgqG82PrB6GwXoUpfkMqdlYDXc9m9R2Rde/dyi9rfVWq/7SfkN//gEQ==
X-Received: by 2002:a05:6000:26ce:b0:3a6:d349:1b52 with SMTP id ffacd0b85a97d-3c32c52bd7dmr10676f8f.21.1755627368099;
        Tue, 19 Aug 2025 11:16:08 -0700 (PDT)
Received: from [172.17.139.130] ([163.114.131.192])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c16fasm4624050f8f.35.2025.08.19.11.16.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 11:16:07 -0700 (PDT)
Message-ID: <7a40bdcc-3905-4fa2-beac-c7612becabb7@gmail.com>
Date: Tue, 19 Aug 2025 19:13:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/4] bpf: task work scheduling kfuncs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20250815192156.272445-1-mykyta.yatsenko5@gmail.com>
 <20250815192156.272445-4-mykyta.yatsenko5@gmail.com>
 <CAP01T751FPiuZv5yBMeHSAmFmywc7L3iY=jYLb992YOp_94pRQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAP01T751FPiuZv5yBMeHSAmFmywc7L3iY=jYLb992YOp_94pRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/19/25 15:18, Kumar Kartikeya Dwivedi wrote:
> On Fri, 15 Aug 2025 at 21:22, Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
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
>>   * bpf_task_work_acquire() - Attempts to take ownership of the context,
>>   pointed by passed struct bpf_task_work, allocates new context if none
>>   exists yet.
>>   * bpf_task_work_callback() – Invoked when the actual task_work runs.
>>   * bpf_task_work_irq() – An intermediate step (runs in softirq context)
>> to enqueue task work.
>>   * bpf_task_work_cancel_and_free() – Cleanup for deleted BPF map entries.
> Can you elaborate on why the bouncing through irq_work context is necessary?
> I think we should have this info in the commit log.
> Is it to avoid deadlocks with task_work locks and/or task->pi_lock?
yes, mainly to avoid locks in NMI.
>
>> Flow of successful task work scheduling
>>   1) bpf_task_work_schedule_* is called from BPF code.
>>   2) Transition state from STANDBY to PENDING, marks context is owned by
>>   this task work scheduler
>>   3) irq_work_queue() schedules bpf_task_work_irq().
>>   4) Transition state from PENDING to SCHEDULING.
>>   4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>>   transitions to SCHEDULED.
>>   5) Task work calls bpf_task_work_callback(), which transition state to
>>   RUNNING.
>>   6) BPF callback is executed
>>   7) Context is cleaned up, refcounts released, context state set back to
>>   STANDBY.
>>
>> bpf_task_work_context handling
>> The context pointer is stored in bpf_task_work ctx field (u64) but
>> treated as an __rcu pointer via casts.
>> bpf_task_work_acquire() publishes new bpf_task_work_context by cmpxchg
>> with RCU initializer.
>> Read under the RCU lock only in bpf_task_work_acquire() when ownership
>> is contended.
>> Upon deleting map value, bpf_task_work_cancel_and_free() is detaching
>> context pointer from struct bpf_task_work and releases resources
>> if scheduler does not own the context or can be canceled (state ==
>> STANDBY or state == SCHEDULED and callback canceled). If task work
>> scheduler owns the context, its state is set to FREED and scheduler is
>> expected to cleanup on the next state transition.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
> This is much better now, with clear ownership between free path and
> scheduling path, I mostly have a few more comments on the current
> implementation, plus one potential bug.
>
> However, the more time I spend on this, the more I feel we should
> unify all this with the two other bpf async work execution mechanisms
> (timers and wq), and simplify and deduplicate a lot of this under the
> serialized async->lock. I know NMI execution is probably critical for
> this primitive, but we can replace async->lock with rqspinlock to
> address that, so that it becomes safe to serialize in any context.
> Apart from that, I don't see anything that would negate reworking all
> this as a case of BPF_TASK_WORK for bpf_async_kern, modulo internal
> task_work locks that have trouble with NMI execution (see later
> comments).
>
> I also feel like it would be cleaner if we split the API into 3 steps:
> init(), set_callback(), schedule() like the other cases, I don't see
> why we necessarily need to diverge, and it simplifies some of the
> logic in schedule().
> Once every state update is protected by a lock, all of the state
> transitions are done automatically and a lot of the extra races are
> eliminated.
>
> I think we should discuss whether this was considered and why you
> discarded this approach, otherwise the code is pretty complex, with
> little upside.
> Maybe I'm missing something obvious and you'd know more since you've
> thought about all this longer.
As for API, I think having 1 function for scheduling callback is cleaner
then having 3 which are always called in the same order anyway. Most of 
the complexity
comes from synchronization, not logic, so not having to do the same 
synchronization in
init(), set_callback() and schedule() seems like a benefit to me.
Let me check if using rqspinlock going to make things simpler. We still 
need states to at least know if cancellation is possible and to flag 
deletion to scheduler, but using a lock will make code easier to 
understand.
>
>>   kernel/bpf/helpers.c | 270 +++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 260 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index d2f88a9bc47b..346ae8fd3ada 100644
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
>> @@ -3701,6 +3703,226 @@ __bpf_kfunc int bpf_strstr(const char *s1__ign, const char *s2__ign)
>>
>>   typedef void (*bpf_task_work_callback_t)(struct bpf_map *map, void *key, void *value);
>>
>> +enum bpf_task_work_state {
>> +       /* bpf_task_work is ready to be used */
>> +       BPF_TW_STANDBY = 0,
>> +       /* irq work scheduling in progress */
>> +       BPF_TW_PENDING,
>> +       /* task work scheduling in progress */
>> +       BPF_TW_SCHEDULING,
>> +       /* task work is scheduled successfully */
>> +       BPF_TW_SCHEDULED,
>> +       /* callback is running */
>> +       BPF_TW_RUNNING,
>> +       /* associated BPF map value is deleted */
>> +       BPF_TW_FREED,
>> +};
>> +
>> +struct bpf_task_work_context {
>> +       /* the map and map value associated with this context */
>> +       struct bpf_map *map;
>> +       void *map_val;
>> +       /* bpf_prog that schedules task work */
>> +       struct bpf_prog *prog;
>> +       /* task for which callback is scheduled */
>> +       struct task_struct *task;
>> +       enum task_work_notify_mode mode;
>> +       enum bpf_task_work_state state;
>> +       bpf_task_work_callback_t callback_fn;
>> +       struct callback_head work;
>> +       struct irq_work irq_work;
>> +       struct rcu_head rcu;
>> +} __aligned(8);
>> +
>> +static struct bpf_task_work_context *bpf_task_work_context_alloc(void)
>> +{
>> +       struct bpf_task_work_context *ctx;
>> +
>> +       ctx = bpf_mem_alloc(&bpf_global_ma, sizeof(struct bpf_task_work_context));
>> +       if (ctx)
>> +               memset(ctx, 0, sizeof(*ctx));
>> +       return ctx;
>> +}
>> +
>> +static void bpf_task_work_context_free(struct rcu_head *rcu)
>> +{
>> +       struct bpf_task_work_context *ctx = container_of(rcu, struct bpf_task_work_context, rcu);
>> +       /* bpf_mem_free expects migration to be disabled */
>> +       migrate_disable();
>> +       bpf_mem_free(&bpf_global_ma, ctx);
>> +       migrate_enable();
>> +}
>> +
>> +static bool task_work_match(struct callback_head *head, void *data)
>> +{
>> +       struct bpf_task_work_context *ctx = container_of(head, struct bpf_task_work_context, work);
>> +
>> +       return ctx == data;
>> +}
>> +
>> +static void bpf_task_work_context_reset(struct bpf_task_work_context *ctx)
>> +{
>> +       bpf_prog_put(ctx->prog);
>> +       bpf_task_release(ctx->task);
>> +}
>> +
>> +static void bpf_task_work_callback(struct callback_head *cb)
>> +{
>> +       enum bpf_task_work_state state;
>> +       struct bpf_task_work_context *ctx;
>> +       u32 idx;
>> +       void *key;
>> +
>> +       ctx = container_of(cb, struct bpf_task_work_context, work);
>> +
>> +       /*
>> +        * Read lock is needed to protect map key and value access below, it has to be done before
>> +        * the state transition
>> +        */
>> +       rcu_read_lock_trace();
>> +       /*
>> +        * This callback may start running before bpf_task_work_irq() switched the state to
>> +        * SCHEDULED so handle both transition variants SCHEDULING|SCHEDULED -> RUNNING.
>> +        */
>> +       state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_RUNNING);
>> +       if (state == BPF_TW_SCHEDULED)
> ... and let's say we have concurrent cancel_and_free here, we mark
> state BPF_TW_FREED.
>
>> +               state = cmpxchg(&ctx->state, BPF_TW_SCHEDULED, BPF_TW_RUNNING);
>> +       if (state == BPF_TW_FREED) {
> ... and notice it here now ...
>
>> +               rcu_read_unlock_trace();
>> +               bpf_task_work_context_reset(ctx);
>> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
> ... then I presume this is ok, because the cancel of tw in
> cancel_and_free will fail?
yes, if cancellation succeeds, callback will not be called.
If it fails, cancel_and_free does not do anything, except changing
the state and callback does the cleanup.
> Maybe add a comment here that it's interlocked with the free path.
>
>> +               return;
>> +       }
>> +
>> +       key = (void *)map_key_from_value(ctx->map, ctx->map_val, &idx);
>> +       migrate_disable();
>> +       ctx->callback_fn(ctx->map, key, ctx->map_val);
>> +       migrate_enable();
>> +       rcu_read_unlock_trace();
>> +       /* State is running or freed, either way reset. */
>> +       bpf_task_work_context_reset(ctx);
>> +       state = cmpxchg(&ctx->state, BPF_TW_RUNNING, BPF_TW_STANDBY);
>> +       if (state == BPF_TW_FREED)
>> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
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
>> +       state = cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING);
>> +       if (state == BPF_TW_FREED)
>> +               goto free_context;
>> +
>> +       err = task_work_add(ctx->task, &ctx->work, ctx->mode);
>> +       if (err) {
>> +               bpf_task_work_context_reset(ctx);
>> +               state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
>> +               if (state == BPF_TW_FREED)
>> +                       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
>> +               return;
>> +       }
>> +       state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
>> +       if (state == BPF_TW_FREED && task_work_cancel_match(ctx->task, task_work_match, ctx))
>> +               goto free_context; /* successful cancellation, release and free ctx */
>> +       return;
>> +
>> +free_context:
>> +       bpf_task_work_context_reset(ctx);
>> +       call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
>> +}
>> +
>> +static struct bpf_task_work_context *bpf_task_work_context_acquire(struct bpf_task_work *tw,
>> +                                                                  struct bpf_map *map)
>> +{
>> +       struct bpf_task_work_context *ctx, *old_ctx;
>> +       enum bpf_task_work_state state;
>> +       struct bpf_task_work_context __force __rcu **ppc =
>> +               (struct bpf_task_work_context __force __rcu **)&tw->ctx;
>> +
>> +       /* ctx pointer is RCU protected */
>> +       rcu_read_lock_trace();
>> +       ctx = rcu_dereference(*ppc);
>> +       if (!ctx) {
>> +               ctx = bpf_task_work_context_alloc();
>> +               if (!ctx) {
>> +                       rcu_read_unlock_trace();
>> +                       return ERR_PTR(-ENOMEM);
>> +               }
>> +               old_ctx = unrcu_pointer(cmpxchg(ppc, NULL, RCU_INITIALIZER(ctx)));
>> +               /*
>> +                * If ctx is set by another CPU, release allocated memory.
>> +                * Do not fail, though, attempt stealing the work
>> +                */
>> +               if (old_ctx) {
>> +                       bpf_mem_free(&bpf_global_ma, ctx);
>> +                       ctx = old_ctx;
>> +               }
>> +       }
>> +       state = cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING);
>> +       /*
>> +        * We can unlock RCU, because task work scheduler (this codepath)
>> +        * now owns the ctx or returning an error
>> +        */
>> +       rcu_read_unlock_trace();
>> +       if (state != BPF_TW_STANDBY)
>> +               return ERR_PTR(-EBUSY);
>> +       return ctx;
>> +}
>> +
>> +static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work *tw,
>> +                                 struct bpf_map *map, bpf_task_work_callback_t callback_fn,
>> +                                 struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
>> +{
>> +       struct bpf_prog *prog;
>> +       struct bpf_task_work_context *ctx = NULL;
>> +       int err;
>> +
>> +       BTF_TYPE_EMIT(struct bpf_task_work);
>> +
>> +       prog = bpf_prog_inc_not_zero(aux->prog);
>> +       if (IS_ERR(prog))
>> +               return -EBADF;
>> +
>> +       if (!atomic64_read(&map->usercnt)) {
>> +               err = -EBADF;
>> +               goto release_prog;
>> +       }
> Please add a comment on why lack of ordering between load of usercnt
> and load of tw->ctx is safe, in presence of a parallel usercnt
> dec_and_test and ctx xchg.
> See __bpf_async_init for similar race.
I think I see what you mean, let me double check this.
>
>> +       task = bpf_task_acquire(task);
>> +       if (!task) {
>> +               err = -EPERM;
>> +               goto release_prog;
>> +       }
>> +       ctx = bpf_task_work_context_acquire(tw, map);
>> +       if (IS_ERR(ctx)) {
>> +               err = PTR_ERR(ctx);
>> +               goto release_all;
>> +       }
>> +
>> +       ctx->task = task;
>> +       ctx->callback_fn = callback_fn;
>> +       ctx->prog = prog;
>> +       ctx->mode = mode;
>> +       ctx->map = map;
>> +       ctx->map_val = (void *)tw - map->record->task_work_off;
>> +       init_irq_work(&ctx->irq_work, bpf_task_work_irq);
>> +       init_task_work(&ctx->work, bpf_task_work_callback);
>> +
>> +       irq_work_queue(&ctx->irq_work);
>> +
>> +       return 0;
>> +
>> +release_all:
>> +       bpf_task_release(task);
>> +release_prog:
>> +       bpf_prog_put(prog);
>> +       return err;
>> +}
>> +
>>   /**
>>    * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL mode
>>    * @task: Task struct for which callback should be scheduled
>> @@ -3711,13 +3933,11 @@ typedef void (*bpf_task_work_callback_t)(struct bpf_map *map, void *key, void *v
>>    *
>>    * Return: 0 if task work has been scheduled successfully, negative error code otherwise
>>    */
>> -__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task,
>> -                                             struct bpf_task_work *tw,
>> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
>>                                                struct bpf_map *map__map,
>> -                                             bpf_task_work_callback_t callback,
>> -                                             void *aux__prog)
>> +                                             bpf_task_work_callback_t callback, void *aux__prog)
>>   {
>> -       return 0;
>> +       return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
>>   }
>>
>>   /**
>> @@ -3731,19 +3951,47 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task,
>>    *
>>    * Return: 0 if task work has been scheduled successfully, negative error code otherwise
>>    */
>> -__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task,
>> -                                             struct bpf_task_work *tw,
>> +__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
>>                                                struct bpf_map *map__map,
>> -                                             bpf_task_work_callback_t callback,
>> -                                             void *aux__prog)
>> +                                             bpf_task_work_callback_t callback, void *aux__prog)
>>   {
>> -       return 0;
>> +       enum task_work_notify_mode mode;
>> +
>> +       mode = task == current && in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
>> +       return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, mode);
>>   }
>>
>>   __bpf_kfunc_end_defs();
>>
>>   void bpf_task_work_cancel_and_free(void *val)
>>   {
>> +       struct bpf_task_work *tw = val;
>> +       struct bpf_task_work_context *ctx;
>> +       enum bpf_task_work_state state;
>> +
>> +       /* No need do rcu_read_lock as no other codepath can reset this pointer */
>> +       ctx = unrcu_pointer(xchg((struct bpf_task_work_context __force __rcu **)&tw->ctx, NULL));
>> +       if (!ctx)
>> +               return;
>> +       state = xchg(&ctx->state, BPF_TW_FREED);
>> +
>> +       switch (state) {
>> +       case BPF_TW_SCHEDULED:
>> +               /* If we can't cancel task work, rely on task work callback to free the context */
>> +               if (!task_work_cancel_match(ctx->task, task_work_match, ctx))
> This part looks broken to me.
> You are calling this path
> (update->obj_free_fields->cancel_and_free->cancel_and_match) in
> possibly NMI context.
> Which means we can deadlock if we hit the NMI context prog in the
> middle of task->pi_lock critical section.
> That's taken in task_work functions
> The task_work_cancel_match takes the pi_lock.
Good point, thanks. I think this could be solved in 2 ways:
  * Don't cancel, rely on callback dropping the work
  * Cancel in another irq_work
I'll probably go with the second one.
>
>> +                       break;
>> +               bpf_task_work_context_reset(ctx);
>> +               fallthrough;
>> +       case BPF_TW_STANDBY:
>> +               call_rcu_tasks_trace(&ctx->rcu, bpf_task_work_context_free);
>> +               break;
>> +       /* In all below cases scheduling logic should detect context state change and cleanup */
>> +       case BPF_TW_SCHEDULING:
>> +       case BPF_TW_PENDING:
>> +       case BPF_TW_RUNNING:
>> +       default:
>> +               break;
>> +       }
>>   }
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> @@ -3769,6 +4017,8 @@ BTF_ID_FLAGS(func, bpf_rbtree_first, KF_RET_NULL)
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


