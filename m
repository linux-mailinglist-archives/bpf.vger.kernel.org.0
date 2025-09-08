Return-Path: <bpf+bounces-67710-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7317B48F23
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 15:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E26178F6A
	for <lists+bpf@lfdr.de>; Mon,  8 Sep 2025 13:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7C930B50C;
	Mon,  8 Sep 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPTgy5sd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D7130ACE6
	for <bpf@vger.kernel.org>; Mon,  8 Sep 2025 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337218; cv=none; b=eFR2CIx3SYFiJ0VJdOtbUAoZqtb9FX49UStbvAZVJr8/Sli6F19Af7avYcyV4HLdQDWa13aJ0E5Mvo7yPeyIHKl7eCXXCNAB0lWn+DpHHaTvREJfVA3ikFj78EJMvE3UEuJV52mt6MDG6g3ts8e1pS9rDKcBWJcM7SpaWO+QMTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337218; c=relaxed/simple;
	bh=B2Pd9RuDu+6lIxZj8k5vTOkdV92zF8AaXAdsqps6uRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=otcdfJSExSKkbOTVPLFp3fHjj9c6yYo5wh0yOWMDJHTePrlHdp6N0dYn0pHLzVSgmZHq7uCOucu7CQtOPB/yBmjYKyp1H/4Bo/PqA8KvewXqsM3nTRjEJZGwe4QEKiowJLOkdJCPKnQX3rzlmnPEz8XibdA4mk7zsCHCuqt9WS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPTgy5sd; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de221da9cso7561145e9.0
        for <bpf@vger.kernel.org>; Mon, 08 Sep 2025 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757337215; x=1757942015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0TR4u6pDqtqLaHZSkMRpPfp24/cTPnbPHN9g9wSMUg=;
        b=UPTgy5sdkZ33bfyKh8ACJj/lh/DmW0x2C+olLlKfCmuE8w9UqW+LkaYq6nc2RQGURM
         4/ydl9J91oV8EB3jldQTLSv8pYRnNPB3nXwEv7PQ7FNafmD9e+BiPK7B2CGwLCieWjac
         nvnNngg4yVhal/aDyVp7s6r841EukIzFplTyFNtIZyS96lHggIfTzN0j4cqMvutmX0BS
         3HnEuH1a1RxmGACbfS2oIAOZ5hYVO+eR97MwcNyxkuRepNWbFsUOwkPk89RussF5ZXOy
         aedYbZGptfaBn4YCun6kptiIk6VojOec27jt6rQMbVerjgz4EdqJL6npfuKf0Yd/aW8X
         f7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757337215; x=1757942015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0TR4u6pDqtqLaHZSkMRpPfp24/cTPnbPHN9g9wSMUg=;
        b=dRxMpnf5mTgEGUJhOu98rRa+Os+UmZskIVI0dSxWEugos2gWytPTeq3QeYYDfIs2te
         SYsC2OUmY04smy+YbYqjQLREGHLgUVYwsiNm2LPNy//STd/kOsrgGU/8gZj+Ml1BbO6V
         41jsx7h/7j8yE9Sp9Ks4mJ8pjDwlosxCItEz7ltpLcttxRUhz11hoKcwDGO3rkfhlcs5
         qFIkn4uoN+ziZxcuBNZH4VNVEjBzcJEiXnDgvhdTTEqk2uYQnr1c2jIwW5o2Uf9RtiIW
         JvnxYzdQUVVWmAFErpuKfpQ6uIpEkNObtKHDhMTSbPnek7FXU1bFW26CfrTNVdKsIHqM
         3L+A==
X-Forwarded-Encrypted: i=1; AJvYcCUoKRKsAnCBlhkICmd8lYKctCu9Up8exLBXT5gTXIapk8T0lbmVxXhm5pFm9VoTnpKtMig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIcxK8ghswcyDPs+9Uyj8QVd47uPka0zVJKzxbuL8Zp7WSykzm
	b8WhmsWyTns9BStLxe33nrB5JdZGCII3NFjgafOKzqSZ8mgmFJ6i3a/H
X-Gm-Gg: ASbGncvgJFYedBdU7514LgFzNCvkrx8i8LXiYhFFWcvKRFOHUmxGXcNrESUxw3H22Vw
	Wtd9iM1chqkUM85zFrIVXa1yfQJaj78ua/25586mR1ayVaQ1Gof39BX07+RcwJHwgSxJuN0RPxA
	EHDAhmfRpRB0YwUwWzKpWYIef7dxlV+8KjF7UfvE4/laiuLI/vC7wji9RpUxRy3qpMdkdAaHfLb
	+q/qR+ZoF1SKmiNkxPt293lDybK6GAjU/+03/2RuRqd5H/AvXxCfWLOJhH0+EB+wtxDkv5Y/eJ5
	q6SOAbjGtM/zyB+jFiL28IjFim9ycXffxPwXyCPhjvkkeOUcXYhrkOwuW+QDTbJmTKKWUAHlg/h
	HTQ0BZ+fZGkbhQlPxO28L14h2fdgh2fMCMeBaeXmCpQ9c+ECCT+hljhVLFGvEW/0=
X-Google-Smtp-Source: AGHT+IEHU07U35fknSJmJ3Nsltwvqgk+LQy9cx7at/G41iQyNxHUZWczquZt8Dzk4+PXh8WLUjidbA==
X-Received: by 2002:a05:600c:1993:b0:45c:b5eb:b0c6 with SMTP id 5b1f17b1804b1-45ddde80fd3mr71529975e9.5.1757337214983;
        Mon, 08 Sep 2025 06:13:34 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:3b00:aa66:6df5:e693? ([2620:10d:c092:500::5:c63f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd0869b33sm201789515e9.9.2025.09.08.06.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 06:13:34 -0700 (PDT)
Message-ID: <4330e66c-59c0-4d1f-8401-de13b54342e8@gmail.com>
Date: Mon, 8 Sep 2025 14:13:33 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/7] bpf: task work scheduling kfuncs
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com,
 kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
References: <20250905164508.1489482-1-mykyta.yatsenko5@gmail.com>
 <20250905164508.1489482-7-mykyta.yatsenko5@gmail.com>
 <aa9dcf55f1ed26c140f83fdde8312304efb80099.camel@gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <aa9dcf55f1ed26c140f83fdde8312304efb80099.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/25 21:22, Eduard Zingerman wrote:
> On Fri, 2025-09-05 at 17:45 +0100, Mykyta Yatsenko wrote:
>
> [...]
>
>> A small state machine and refcounting scheme ensures safe reuse and
>> teardown:
>>   STANDBY -> PENDING -> SCHEDULING -> SCHEDULED -> RUNNING -> STANDBY
> Nit: state machine is actually a bit more complex:
>
>    digraph G {
>      scheduling  -> running    [label="callback 1"];
>      scheduled   -> running    [label="callback 2"];
>      running     -> standby    [label="callback 3"];
>      pending     -> scheduling [label="irq 1"];
>      scheduling  -> standby    [label="irq 2"];
>      scheduling  -> scheduled  [label="irq 3"];
>      standby     -> pending    [label="acquire_ctx"];
>    
>      freed      -> freed [label="cancel_and_free"];
>      pending    -> freed [label="cancel_and_free"];
>      running    -> freed [label="cancel_and_free"];
>      scheduled  -> freed [label="cancel_and_free"];
>      scheduling -> freed [label="cancel_and_free"];
>      standby    -> freed [label="cancel_and_free"];
>    }
>
> [...]
>
I'll update the description to contain proper graph.
>> Flow of successful task work scheduling
>>   1) bpf_task_work_schedule_* is called from BPF code.
>>   2) Transition state from STANDBY to PENDING, marks context is owned by
>>   this task work scheduler
>>   3) irq_work_queue() schedules bpf_task_work_irq().
>>   4) Transition state from PENDING to SCHEDULING.
>>   4) bpf_task_work_irq() attempts task_work_add(). If successful, state
>>   transitions to SCHEDULED.
> Nit: "4" repeated two times.
>
>>   5) Task work calls bpf_task_work_callback(), which transition state to
>>   RUNNING.
>>   6) BPF callback is executed
>>   7) Context is cleaned up, refcounts released, context state set back to
>>   STANDBY.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 319 ++++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 317 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index 109cb249e88c..418a0a211699 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> [...]
>
>> +static void bpf_task_work_cancel(struct bpf_task_work_ctx *ctx)
>> +{
>> +	/*
>> +	 * Scheduled task_work callback holds ctx ref, so if we successfully
>> +	 * cancelled, we put that ref on callback's behalf. If we couldn't
>> +	 * cancel, callback is inevitably run or has already completed
>> +	 * running, and it would have taken care of its ctx ref itself.
>> +	 */
>> +	if (task_work_cancel_match(ctx->task, task_work_match, ctx))
> Will `task_work_cancel(ctx->task, ctx->work)` do the same thing here?
I think so, yes, thanks for checking.
>
>> +		bpf_task_work_ctx_put(ctx);
>> +}
> [...]
>
>> +static void bpf_task_work_irq(struct irq_work *irq_work)
>> +{
>> +	struct bpf_task_work_ctx *ctx = container_of(irq_work, struct bpf_task_work_ctx, irq_work);
>> +	enum bpf_task_work_state state;
>> +	int err;
>> +
>> +	guard(rcu_tasks_trace)();
>> +
>> +	if (cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_SCHEDULING) != BPF_TW_PENDING) {
>> +		bpf_task_work_ctx_put(ctx);
>> +		return;
>> +	}
> Why are separate PENDING and SCHEDULING states needed?
> Both indicate that the task had not been yet but is ready to be
> submitted to task_work_add(). So, on a first glance it seems that
> merging the two won't change the behaviour, what do I miss?
Yes, this is right, we may drop SCHEDULING state, it does not change any 
behavior compared to PENDING.
The state check before task_work_add is needed anyway, so we won't 
remove much code here.
I kept it just to be more consistent: with every state check we also 
transition state machine forward.
>
>> +	err = task_work_add(ctx->task, &ctx->work, ctx->mode);
>> +	if (err) {
>> +		bpf_task_work_ctx_reset(ctx);
>> +		/*
>> +		 * try to switch back to STANDBY for another task_work reuse, but we might have
>> +		 * gone to FREED already, which is fine as we already cleaned up after ourselves
>> +		 */
>> +		(void)cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_STANDBY);
>> +
>> +		/* we don't have RCU protection, so put after switching state */
>> +		bpf_task_work_ctx_put(ctx);
>> +	}
>> +
>> +	/*
>> +	 * It's technically possible for just scheduled task_work callback to
>> +	 * complete running by now, going SCHEDULING -> RUNNING and then
>> +	 * dropping its ctx refcount. Instead of capturing extra ref just to
>> +	 * protected below ctx->state access, we rely on RCU protection to
>> +	 * perform below SCHEDULING -> SCHEDULED attempt.
>> +	 */
>> +	state = cmpxchg(&ctx->state, BPF_TW_SCHEDULING, BPF_TW_SCHEDULED);
>> +	if (state == BPF_TW_FREED)
>> +		bpf_task_work_cancel(ctx); /* clean up if we switched into FREED state */
>> +}
> [...]
>
>> +static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work *tw,
>> +							   struct bpf_map *map)
>> +{
>> +	struct bpf_task_work_ctx *ctx;
>> +
>> +	/* early check to avoid any work, we'll double check at the end again */
>> +	if (!atomic64_read(&map->usercnt))
>> +		return ERR_PTR(-EBUSY);
>> +
>> +	ctx = bpf_task_work_fetch_ctx(tw, map);
>> +	if (IS_ERR(ctx))
>> +		return ctx;
>> +
>> +	/* try to get ref for task_work callback to hold */
>> +	if (!bpf_task_work_ctx_tryget(ctx))
>> +		return ERR_PTR(-EBUSY);
>> +
>> +	if (cmpxchg(&ctx->state, BPF_TW_STANDBY, BPF_TW_PENDING) != BPF_TW_STANDBY) {
>> +		/* lost acquiring race or map_release_uref() stole it from us, put ref and bail */
>> +		bpf_task_work_ctx_put(ctx);
>> +		return ERR_PTR(-EBUSY);
>> +	}
>> +
>> +	/*
>> +	 * Double check that map->usercnt wasn't dropped while we were
>> +	 * preparing context, and if it was, we need to clean up as if
>> +	 * map_release_uref() was called; bpf_task_work_cancel_and_free()
>> +	 * is safe to be called twice on the same task work
>> +	 */
>> +	if (!atomic64_read(&map->usercnt)) {
>> +		/* drop ref we just got for task_work callback itself */
>> +		bpf_task_work_ctx_put(ctx);
>> +		/* transfer map's ref into cancel_and_free() */
>> +		bpf_task_work_cancel_and_free(tw);
>> +		return ERR_PTR(-EBUSY);
>> +	}
> I don't understand how the above check is useful.
> Is map->usercnt protected from being changed during execution of
> bpf_task_work_schedule()?
> There are two such checks in this function, so apparently it is not.
> Then what's the point of checking usercnt value if it can be
> immediately changed after the check?
BPF map implementation calls bpf_task_work_cancel_and_free() for each 
value when map->usercnt goes to 0.
We need to make sure that after mutating map value (attaching a ctx, 
setting state and refcnt), we do not
leak memory to a newly allocated ctx.
If bpf_task_work_cancel_and_free() runs concurrently with 
bpf_task_work_acquire_ctx(), there is a chance that map cleans up the 
value first and then we attach a ctx with refcnt=2, memory will leak. 
Alternatively, if map->usercnt is set to 0 right after this check, we 
are guaranteed to have the initialized context attached already, so the 
refcnts will be properly decremented (once by 
bpf_task_work_cancel_and_free()
and once by bpf_task_work_irq() and clean up is safe).

In other words, initialization of the ctx in struct bpf_task_work is 
multi-step operation, those steps could be
interleaved with cancel_and_free(), in such case the value may leak the 
ctx. Check map->usercnt==0 after initialization,
to force correct cleanup preventing the leak. Calling cancel_and_free() 
for the same value twice is safe.
>
>> +
>> +	return ctx;
>> +}
>> +
>> +static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work *tw,
>> +				  struct bpf_map *map, bpf_task_work_callback_t callback_fn,
>> +				  struct bpf_prog_aux *aux, enum task_work_notify_mode mode)
>> +{
>> +	struct bpf_prog *prog;
>> +	struct bpf_task_work_ctx *ctx;
>> +	int err;
>> +
>> +	BTF_TYPE_EMIT(struct bpf_task_work);
>> +
>> +	prog = bpf_prog_inc_not_zero(aux->prog);
>> +	if (IS_ERR(prog))
>> +		return -EBADF;
>> +	task = bpf_task_acquire(task);
>> +	if (!task) {
>> +		err = -EPERM;
> Nit: Why -EPERM? bpf_task_acquire() returns NULL if task->rcu_users
>       is zero, does not seem to be permission related.
Right, this probably should be -EBADF.
>> +		goto release_prog;
>> +	}
>> +
>> +	ctx = bpf_task_work_acquire_ctx(tw, map);
>> +	if (IS_ERR(ctx)) {
>> +		err = PTR_ERR(ctx);
>> +		goto release_all;
>> +	}
>> +
>> +	ctx->task = task;
>> +	ctx->callback_fn = callback_fn;
>> +	ctx->prog = prog;
>> +	ctx->mode = mode;
>> +	ctx->map = map;
>> +	ctx->map_val = (void *)tw - map->record->task_work_off;
>> +	init_task_work(&ctx->work, bpf_task_work_callback);
>> +	init_irq_work(&ctx->irq_work, bpf_task_work_irq);
>> +
>> +	irq_work_queue(&ctx->irq_work);
>> +	return 0;
>> +
>> +release_all:
>> +	bpf_task_release(task);
>> +release_prog:
>> +	bpf_prog_put(prog);
>> +	return err;
>> +}
>> +
> [...]


