Return-Path: <bpf+bounces-78924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AC9D1F8BC
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 15:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ECE953004E2A
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7930D30C37B;
	Wed, 14 Jan 2026 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljgEkqdf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4273093C6
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402409; cv=none; b=h8dl6DYQIVpiD2wQRC2f1f1ITMveEuDEyN+Bv2UBuXRCXfoSKTWQCiEcfHFeMjb7SABFWuIOCMBOorEw9oNXJG7Q7va833pSTYmAoDFIzuTMJ2qDXgfWYQXkYeNJ/wynylXLuwWvPZ53pbAaNLDWXaXklFVGKD/sH5PhYovZJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402409; c=relaxed/simple;
	bh=bJcDWPvJuO2D9xax7MwED4dKERF394QQyln+yKYI1jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WihXY4F+2qSnTXZhgFB7b0MD2d6vs9aSZaa4OKIAsvuK5pFJJ3GJLCURxsp9yaXEA9xTzWJ7E2MitEowiVMJvkQU8+GcfNcEsGoRqDYaaRL5EpXcLLhwMDab/OKJ5l+ZBReDbzyM+sT3GXu5ZWNPulpq8ky4yQ0ptiExKVxFzKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljgEkqdf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779aa4f928so88128575e9.1
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 06:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768402405; x=1769007205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KP5GmZCmlEOZQgvSMOD6VvXA7lPD27gpDehwo20k2jI=;
        b=ljgEkqdficGwHuQBq8XO4927Vhw8NZgBd/hqtd2NvUXYhKNY/tarLGO+Bih6jJyDh3
         WN554GFXZEuVDwAVeZ3iDnePZAuwixsgnC6X4zyrwqILOlj9LtJbk/NIULJyQNlvyT5L
         fddl854/hgeEOvCyyLArLlu2LYXWaKMP7zh3mgb4uJdEGmI9Kvr3qWKGZc0XF+W2oYA1
         6JkhrDaBZpoP9zfEHREV9E9hFW4ouOukylz7YaxSvJm7CrwwuvOR0yAPwOgOHTM4WOKY
         UnTzzgpxjD59TeEGKxIF0yYr2dtKzjhI6fn1u79LkgfoQf6Qdw78yEe334fAAHbhTrd6
         2S8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768402405; x=1769007205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KP5GmZCmlEOZQgvSMOD6VvXA7lPD27gpDehwo20k2jI=;
        b=t2Pknusp6calLmqmw9fUQGqKXnyCZ4K5JXQU+YAQuUu+PspC2KsIhiGJFFvzcuF54V
         Dtn95W4vOCls5CAJAL5DQ+Qz9RPPBflUeeumQzjyoyr1fI+4F1m3UUq37ajRq5tfGL9J
         UNIxhxG06ipISQAqv4wAM1+meAxOSe+SQDvDaiF9VsOTR0Z7ZX7DY4mji2sXtkZis09o
         4XWJcYcRIg97vMBxx8p5XNj5BIMcJRrLGn0lI/R7TDBwLMXwnQN6o5WB7ximw9Z6vbrd
         uJNgqJ4D13L8OwF8ZPdny7PwoedX5kcyVgFZURTd12fS0qbTwnrqNiJwCJP3s+i09lME
         HZkA==
X-Gm-Message-State: AOJu0YwvtMyBQQnH97m1rGEZG6vUCkCr047pphSvg9B/JzN/WNduIm0T
	+g/jYK9iJd/DV/nXKGvt+5GU64HHDc1wyCJiH0JyBBxwdEMJFXS/Mw6m
X-Gm-Gg: AY/fxX4NDIsfW/UZNeyttC7CUvaux3kXnobloxpE7gOmRrPuWXThwprTiAWbzKAbuaJ
	Sma3WkhIXQRm7lXHodFgNTVXvNzpYkHSvfdlu0OkEw6d7gJQmg/tYQBMQQFXALra+BAS2a/92PQ
	fK53cp4zH1ZhkYkr+9cJB7y9CKBoiNbG0VOFNIg6vr9d5+pjDSBIt8Q9vmLF6WaP8gTlRZM2Ewl
	Zl1ScZvPIoWVUuvh/WO7QV8Kk2KlOisNMnCrRxDZNSPZFyzQU7f+yDSOc5wueMMu/wDhlC+bIiG
	JVHnSsC3ZdioEvgowzlU78kelPkeP7CdJZQsr3najcYKdknqMPp99+/1WflrgVPsQeOci1Wo8v8
	CSpp3HgrCasjtJ8NiO7d6G8JmRJlaAsJ/IYae/Q/vKmt4deYRswG4/dB7ZFip5jL8/ck8zOF8xo
	L2NuMxbjs8sqlOVvKtEOY8iAs+vmXatMONbvDeYT9QcaKfDzFciWQzffosRI8DOSdJiINd9Oc=
X-Received: by 2002:a5d:5d83:0:b0:430:f5ed:83f3 with SMTP id ffacd0b85a97d-4342c4f4ca9mr2873491f8f.9.1768402404742;
        Wed, 14 Jan 2026 06:53:24 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm50864812f8f.39.2026.01.14.06.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 06:53:24 -0800 (PST)
Message-ID: <14ef41d3-778c-4fe1-841a-9caffe8e0ec9@gmail.com>
Date: Wed, 14 Jan 2026 14:53:23 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 05/10] bpf: Enable bpf timer and workqueue use in
 NMI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 memxor@gmail.com, eddyz87@gmail.com, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260107-timer_nolock-v3-0-740d3ec3e5f9@meta.com>
 <20260107-timer_nolock-v3-5-740d3ec3e5f9@meta.com>
 <CAEf4BzYpZPtBFyceDfELDTg8fHFTOC+cqeTvvtWyzOtMqRc5iQ@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYpZPtBFyceDfELDTg8fHFTOC+cqeTvvtWyzOtMqRc5iQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/9/26 22:19, Andrii Nakryiko wrote:
> On Wed, Jan 7, 2026 at 9:49 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Refactor bpf timer and workqueue helpers to allow calling them from NMI
>> context by making all operations lock-free and deferring NMI-unsafe
>> work to irq_work.
>>
>> Previously, bpf_timer_start(), and bpf_wq_start()
>> could not be called from NMI context because they acquired
>> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
>> patch removes these limitations.
>>
>> Key changes:
>>   * Remove bpf_spin_lock from struct bpf_async_kern. Replace locked
>>     operations with atomic cmpxchg() for initialization and xchg() for
>>     cancel and free.
>>   * Add per-async irq_work to defer NMI-unsafe operations (hrtimer_start,
>>     hrtimer_try_to_cancel, schedule_work) from NMI to softirq context.
>>   * Use the lock-free mpmc_cell (added in the previous commit) to pass
>>     operation commands (start/cancel/free) along with their parameters
>>     (nsec, mode) from NMI-safe callers to the irq_work handler.
>>   * Add reference counting to bpf_async_cb to ensure the object stays
>>     alive until all scheduled irq_work completes and the timer/work
>>     callback finishes.
>>   * Move bpf_prog_put() to RCU callback to handle races between
>>     set_callback() and cancel_and_free().
>>
>> This enables BPF programs attached to NMI-context hooks (perf
>> events) to use timers and workqueues for deferred processing.
>>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   kernel/bpf/helpers.c | 288 ++++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 191 insertions(+), 97 deletions(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index dc8ed948321e6c535d2cc2e8f9fbdd0636cdcabf..b90b005a17e1de9c0c62056a665d124b883c6320 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -29,6 +29,7 @@
>>   #include <linux/task_work.h>
>>   #include <linux/irq_work.h>
>>   #include <linux/buildid.h>
>> +#include <mpmc_cell.h>
>>
>>   #include "../../lib/kstrtox.h"
>>
>> @@ -1095,6 +1096,23 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
>>          return (void *)value - round_up(map->key_size, 8);
>>   }
>>
>> +enum bpf_async_type {
>> +       BPF_ASYNC_TYPE_TIMER = 0,
>> +       BPF_ASYNC_TYPE_WQ,
>> +};
>> +
>> +enum bpf_async_op {
>> +       BPF_ASYNC_START,
>> +       BPF_ASYNC_CANCEL,
>> +       BPF_ASYNC_CANCEL_AND_FREE,
>> +};
>> +
>> +struct bpf_async_cmd {
>> +       u64 nsec;
>> +       u32 mode;
>> +       u32 op;
>> +};
>> +
>>   struct bpf_async_cb {
>>          struct bpf_map *map;
>>          struct bpf_prog *prog;
>> @@ -1105,6 +1123,12 @@ struct bpf_async_cb {
>>                  struct work_struct delete_work;
>>          };
>>          u64 flags;
>> +       struct irq_work worker;
>> +       struct bpf_mpmc_cell_ctl ctl;
> nit: I'd call it more meaningful "cmd_cell"
>
>> +       struct bpf_async_cmd cmd[2];
>> +       atomic_t last_seq;
>> +       refcount_t refcnt;
>> +       enum bpf_async_type type;
>>   };
>>
>>   /* BPF map elements can contain 'struct bpf_timer'.
>> @@ -1142,18 +1166,8 @@ struct bpf_async_kern {
>>                  struct bpf_hrtimer *timer;
>>                  struct bpf_work *work;
>>          };
>> -       /* bpf_spin_lock is used here instead of spinlock_t to make
>> -        * sure that it always fits into space reserved by struct bpf_timer
>> -        * regardless of LOCKDEP and spinlock debug flags.
>> -        */
>> -       struct bpf_spin_lock lock;
> we have to leave dummy placeholder instead of preserve bpf_async_kern
> size for ABI compatibility
>
>>   } __attribute__((aligned(8)));
>>
>> -enum bpf_async_type {
>> -       BPF_ASYNC_TYPE_TIMER = 0,
>> -       BPF_ASYNC_TYPE_WQ,
>> -};
>> -
>>   static DEFINE_PER_CPU(struct bpf_hrtimer *, hrtimer_running);
>>
>>   static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
>> @@ -1219,6 +1233,13 @@ static void bpf_async_cb_rcu_free(struct rcu_head *rcu)
>>   {
>>          struct bpf_async_cb *cb = container_of(rcu, struct bpf_async_cb, rcu);
>>
>> +       /*
>> +        * Drop the last reference to prog only after RCU GP, as set_callback()
>> +        * may race with cancel_and_free()
>> +        */
>> +       if (cb->prog)
>> +               bpf_prog_put(cb->prog);
>> +
>>          kfree_nolock(cb);
>>   }
>>
>> @@ -1246,18 +1267,17 @@ static void bpf_timer_delete_work(struct work_struct *work)
>>          call_rcu(&t->cb.rcu, bpf_async_cb_rcu_free);
>>   }
>>
>> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async);
>> +static void bpf_async_irq_worker(struct irq_work *work);
>> +
>>   static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
>>                              enum bpf_async_type type)
>>   {
>> -       struct bpf_async_cb *cb;
>> +       struct bpf_async_cb *cb, *old_cb;
>>          struct bpf_hrtimer *t;
>>          struct bpf_work *w;
>>          clockid_t clockid;
>>          size_t size;
>> -       int ret = 0;
>> -
>> -       if (in_nmi())
>> -               return -EOPNOTSUPP;
>>
>>          switch (type) {
>>          case BPF_ASYNC_TYPE_TIMER:
>> @@ -1270,18 +1290,13 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>>                  return -EINVAL;
>>          }
>>
>> -       __bpf_spin_lock_irqsave(&async->lock);
>>          t = async->timer;
> READ_ONCE()?
>
>> -       if (t) {
>> -               ret = -EBUSY;
>> -               goto out;
>> -       }
>> +       if (t)
>> +               return -EBUSY;
>>
>>          cb = bpf_map_kmalloc_nolock(map, size, 0, map->numa_node);
>> -       if (!cb) {
>> -               ret = -ENOMEM;
>> -               goto out;
>> -       }
>> +       if (!cb)
>> +               return -ENOMEM;
>>
>>          switch (type) {
>>          case BPF_ASYNC_TYPE_TIMER:
>> @@ -1304,9 +1319,19 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>>          cb->map = map;
>>          cb->prog = NULL;
>>          cb->flags = flags;
>> +       cb->worker = IRQ_WORK_INIT(bpf_async_irq_worker);
>> +       bpf_mpmc_cell_init(&cb->ctl, &cb->cmd[0], &cb->cmd[1]);
>> +       refcount_set(&cb->refcnt, 1); /* map's reference */
>> +       atomic_set(&cb->last_seq, 0);
>> +       cb->type = type;
>>          rcu_assign_pointer(cb->callback_fn, NULL);
>>
>> -       WRITE_ONCE(async->cb, cb);
>> +       old_cb = cmpxchg(&async->cb, NULL, cb);
>> +       if (old_cb) {
>> +               /* Lost the race to initialize this bpf_async_kern, drop the allocated object */
>> +               kfree_nolock(cb);
>> +               return -EBUSY;
>> +       }
>>          /* Guarantee the order between async->cb and map->usercnt. So
>>           * when there are concurrent uref release and bpf timer init, either
>>           * bpf_timer_cancel_and_free() called by uref release reads a no-NULL
>> @@ -1317,13 +1342,11 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
>>                  /* maps with timers must be either held by user space
>>                   * or pinned in bpffs.
>>                   */
>> -               WRITE_ONCE(async->cb, NULL);
>> -               kfree_nolock(cb);
>> -               ret = -EPERM;
>> +               __bpf_async_cancel_and_free(async);
>> +               return -EPERM;
>>          }
>> -out:
>> -       __bpf_spin_unlock_irqrestore(&async->lock);
>> -       return ret;
>> +
>> +       return 0;
>>   }
>>
>>   BPF_CALL_3(bpf_timer_init, struct bpf_async_kern *, timer, struct bpf_map *, map,
>> @@ -1354,6 +1377,61 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
>>          .arg3_type      = ARG_ANYTHING,
>>   };
>>
>> +static int bpf_async_schedule_op(struct bpf_async_cb *cb, u32 op, u64 nsec, u32 timer_mode)
>> +{
>> +       struct bpf_mpmc_cell_ctl *ctl = &cb->ctl;
>> +       struct bpf_async_cmd *cmd;
>> +
>> +       cmd = bpf_mpmc_cell_write_begin(ctl);
>> +       if (!cmd)
>> +               return -EBUSY;
>> +
>> +       cmd->nsec = nsec;
>> +       cmd->mode = timer_mode;
>> +       cmd->op = op;
>> +
>> +       bpf_mpmc_cell_write_commit(ctl);
>> +
>> +       if (!refcount_inc_not_zero(&cb->refcnt))
>> +               return -EBUSY;
>> +
>> +       irq_work_queue(&cb->worker);
> if not in NMI and not irq-disabled mode, we should be able to call
> bpf_async_irq_worker() directly here and execute action synchronously
> without irq_work execution. Add TODO so we don't forget to implement
> that before patch set lands?
>
>> +
>> +       return 0;
>> +}
>> +
>> +static int bpf_async_read_op(struct bpf_async_cb *cb, enum bpf_async_op *op,
>> +                            u64 *nsec, u32 *flags)
>> +{
>> +       struct bpf_mpmc_cell_ctl *ctl = &cb->ctl;
>> +       struct bpf_async_cmd *cmd;
>> +       u32 seq, last_seq;
>> +
>> +       do {
>> +               last_seq = atomic_read_acquire(&cb->last_seq);
>> +               cmd = bpf_mpmc_cell_read_begin(ctl, &seq);
>> +
>> +               /* Return -EBUSY if current seq is consumed by another reader */
>> +               if (seq == last_seq)
>> +                       return -EBUSY;
>> +
>> +               *nsec = cmd->nsec;
>> +               *flags = cmd->mode;
>> +               *op = cmd->op;
>> +
>> +       /*
>> +        * Retry read on one of the two conditions:
>> +        *  1. Some writer produced new snapshot while we were reading. Our snapshot may have been
>> +        *     modified, and not consistent.
>> +        *  2. Another reader consumed some snapshot. We need to validate that this snapshot is not
>> +        *     consumed. This prevents duplicate op processing.
>> +        */
>> +       } while (bpf_mpmc_cell_read_end(ctl, seq) == -EAGAIN ||
> can read_end return any other error? If yes, how do we handle? If not,
> why hard-code -EAGAIN here, maybe just `< 0` check?
>
>> +                atomic_cmpxchg_release(&cb->last_seq, last_seq, seq) != last_seq);
> nit: repeat condition is complicated enough (and requires multi-line
> weirdly indented comment), so I'd do:
>
> while (true) {
>     ....
>
>      if (bpf_mpmc_cell_read_end(ctl, seq) < 0)
>          continue;
>      if (atomic_cmpxchg() == last_seq) /* success*/
>          break;
>
>
> (or invert cmpxchg + continue, and then stand-alone break)
>
>> +
>> +       return 0;
>> +}
>> +
>>   static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
>>                                      struct bpf_prog *prog)
>>   {
>> @@ -1395,22 +1473,19 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
>>          .arg2_type      = ARG_PTR_TO_FUNC,
>>   };
>>
>> -BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, flags)
>> +BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, flags)
>>   {
>>          struct bpf_hrtimer *t;
>> -       int ret = 0;
>> -       enum hrtimer_mode mode;
>> +       u32 mode;
>>
>> -       if (in_nmi())
>> -               return -EOPNOTSUPP;
>>          if (flags & ~(BPF_F_TIMER_ABS | BPF_F_TIMER_CPU_PIN))
>>                  return -EINVAL;
>> -       __bpf_spin_lock_irqsave(&timer->lock);
>> -       t = timer->timer;
>> -       if (!t || !t->cb.prog) {
>> -               ret = -EINVAL;
>> -               goto out;
>> -       }
>> +
>> +       guard(rcu)();
>> +
>> +       t = async->timer;
> READ_ONCE()
>
>> +       if (!t || !t->cb.prog)
>> +               return -EINVAL;
>>
>>          if (flags & BPF_F_TIMER_ABS)
>>                  mode = HRTIMER_MODE_ABS_SOFT;
>> @@ -1420,10 +1495,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
>>          if (flags & BPF_F_TIMER_CPU_PIN)
>>                  mode |= HRTIMER_MODE_PINNED;
>>
>> -       hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
>> -out:
>> -       __bpf_spin_unlock_irqrestore(&timer->lock);
>> -       return ret;
>> +       return bpf_async_schedule_op(&t->cb, BPF_ASYNC_START, nsecs, mode);
>>   }
>>
>>   static const struct bpf_func_proto bpf_timer_start_proto = {
>> @@ -1435,17 +1507,6 @@ static const struct bpf_func_proto bpf_timer_start_proto = {
>>          .arg3_type      = ARG_ANYTHING,
>>   };
>>
>> -static void drop_prog_refcnt(struct bpf_async_cb *async)
>> -{
>> -       struct bpf_prog *prog = async->prog;
>> -
>> -       if (prog) {
>> -               bpf_prog_put(prog);
>> -               async->prog = NULL;
>> -               rcu_assign_pointer(async->callback_fn, NULL);
>> -       }
>> -}
>> -
>>   BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
>>   {
>>          struct bpf_hrtimer *t, *cur_t;
>> @@ -1513,27 +1574,16 @@ static const struct bpf_func_proto bpf_timer_cancel_proto = {
>>          .arg1_type      = ARG_PTR_TO_TIMER,
>>   };
>>
>> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *async)
>> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
>>   {
>>          struct bpf_async_cb *cb;
>>
>> -       /* Performance optimization: read async->cb without lock first. */
>> -       if (!READ_ONCE(async->cb))
>> -               return NULL;
>> -
>> -       __bpf_spin_lock_irqsave(&async->lock);
>> -       /* re-read it under lock */
>> -       cb = async->cb;
>> +       cb = xchg(&async->cb, NULL);
>>          if (!cb)
>> -               goto out;
>> -       drop_prog_refcnt(cb);
>> -       /* The subsequent bpf_timer_start/cancel() helpers won't be able to use
>> -        * this timer, since it won't be initialized.
>> -        */
>> -       WRITE_ONCE(async->cb, NULL);
>> -out:
>> -       __bpf_spin_unlock_irqrestore(&async->lock);
>> -       return cb;
>> +               return;
>> +
>> +       /* Consume map's refcnt */
>> +       irq_work_queue(&cb->worker);
> hm... this is subtle (and maybe broken?) irq_work_queue() can be
> ignored here, if there is already another one scheduled, so I think
> your clever idea with CANCEL_AND_FREE being done based on this
> refcount drop is flawed...
>
> CANCEL_AND_FREE has to succeed, so it's out-of-bounds signal that
> shouldn't be going through that command cell, yes. But can't we just
> have a simple one-way bool that will be set to true here (+ memory
> barriers, maybe), and then irq_work_queue() scheduled. If there is irq
> work is scheduled, it will inevitable will see this flag (even if it's
> not our callback), and if not, then irq_work_queue() will successfully
> schedule callback which will also clean up.
Thanks for pointing to this issue.
I don't think we can solve it with a simple bool, because cleanup
should only happen once, and only after refcnt is 0, otherwise we need 
to go
back to states to indicate cleanup initiation and cleanup entering (to 
implement
mutual exclusion of the irq_work callbacks trying to run cleanup).
We can still solve this with the refcnt: Drop reference, if refcnt is not 0,
we successfully released map reference and one of the scheduled irq_work 
callbacks
will cleanup, otherwise we took the last reference, all we need is to 
schedule new irq_work
(which can't fail)

     if (!refcount_dec_and_test(&cb->refcnt))
         return;

     /* We took the last reference, need to schedule cleanup */
     refcount_set(&cb->refcnt, 1);
     irq_work_queue(&cb->worker);

>
> also, same about TODO for irq_work_queue() avoidance
>
>
>>   }
>>
>>   static void bpf_timer_delete(struct bpf_hrtimer *t)
>> @@ -1588,19 +1638,76 @@ static void bpf_timer_delete(struct bpf_hrtimer *t)
>>          }
>>   }
>>
>> +static void bpf_async_process_op(struct bpf_async_cb *cb, u32 op,
>> +                                u64 timer_nsec, u32 timer_mode)
>> +{
>> +       switch (cb->type) {
>> +       case BPF_ASYNC_TYPE_TIMER: {
>> +               struct bpf_hrtimer *t = container_of(cb, struct bpf_hrtimer, cb);
>> +
>> +               switch (op) {
>> +               case BPF_ASYNC_START:
>> +                       hrtimer_start(&t->timer, ns_to_ktime(timer_nsec), timer_mode);
>> +                       break;
>> +               case BPF_ASYNC_CANCEL:
>> +                       hrtimer_try_to_cancel(&t->timer);
>> +                       break;
>> +               case BPF_ASYNC_CANCEL_AND_FREE:
>> +                       bpf_timer_delete(t);
>> +                       break;
>> +               default:
>> +                       break;
>> +               }
>> +               break;
>> +       }
>> +       case BPF_ASYNC_TYPE_WQ: {
>> +               struct bpf_work *w = container_of(cb, struct bpf_work, cb);
>> +
>> +               switch (op) {
>> +               case BPF_ASYNC_START:
>> +                       schedule_work(&w->work);
>> +                       break;
>> +               case BPF_ASYNC_CANCEL_AND_FREE:
>> +                       /*
>> +                        * Trigger cancel of the sleepable work, but *do not* wait for
>> +                        * it to finish.
>> +                        * kfree will be called once the work has finished.
>> +                        */
>> +                       schedule_work(&w->delete_work);
>> +                       break;
>> +               default:
>> +                       break;
>> +               }
>> +               break;
>> +       }
>> +       }
>> +}
>> +
>> +static void bpf_async_irq_worker(struct irq_work *work)
>> +{
>> +       struct bpf_async_cb *cb = container_of(work, struct bpf_async_cb, worker);
>> +       u32 op, timer_mode;
>> +       u64 nsec;
>> +       int err;
>> +
>> +       err = bpf_async_read_op(cb, &op, &nsec, &timer_mode);
>> +       if (err)
>> +               goto out;
>> +
>> +       bpf_async_process_op(cb, op, nsec, timer_mode);
>> +
>> +out:
>> +       if (refcount_dec_and_test(&cb->refcnt))
>> +               bpf_async_process_op(cb, BPF_ASYNC_CANCEL_AND_FREE, 0, 0);
>> +}
>> +
>>   /*
>>    * This function is called by map_delete/update_elem for individual element and
>>    * by ops->map_release_uref when the user space reference to a map reaches zero.
>>    */
>>   void bpf_timer_cancel_and_free(void *val)
>>   {
>> -       struct bpf_hrtimer *t;
>> -
>> -       t = (struct bpf_hrtimer *)__bpf_async_cancel_and_free(val);
>> -       if (!t)
>> -               return;
>> -
>> -       bpf_timer_delete(t);
>> +       __bpf_async_cancel_and_free(val);
>>   }
>>
>>   /* This function is called by map_delete/update_elem for individual element and
>> @@ -1608,19 +1715,7 @@ void bpf_timer_cancel_and_free(void *val)
>>    */
>>   void bpf_wq_cancel_and_free(void *val)
>>   {
>> -       struct bpf_work *work;
>> -
>> -       BTF_TYPE_EMIT(struct bpf_wq);
>> -
>> -       work = (struct bpf_work *)__bpf_async_cancel_and_free(val);
>> -       if (!work)
>> -               return;
>> -       /* Trigger cancel of the sleepable work, but *do not* wait for
>> -        * it to finish if it was running as we might not be in a
>> -        * sleepable context.
>> -        * kfree will be called once the work has finished.
>> -        */
>> -       schedule_work(&work->delete_work);
>> +       __bpf_async_cancel_and_free(val);
>>   }
>>
>>   BPF_CALL_2(bpf_kptr_xchg, void *, dst, void *, ptr)
>> @@ -3093,15 +3188,14 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
>>          struct bpf_async_kern *async = (struct bpf_async_kern *)wq;
>>          struct bpf_work *w;
>>
>> -       if (in_nmi())
>> -               return -EOPNOTSUPP;
>>          if (flags)
>>                  return -EINVAL;
>>          w = READ_ONCE(async->work);
>>          if (!w || !READ_ONCE(w->cb.prog))
>>                  return -EINVAL;
>>
>> -       schedule_work(&w->work);
>> +       bpf_async_schedule_op(&w->cb, BPF_ASYNC_START, 0, 0);
>> +
>>          return 0;
>>   }
>>
>>
>> --
>> 2.52.0
>>


