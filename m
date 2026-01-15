Return-Path: <bpf+bounces-79129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F348CD27D35
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 19:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7ED73019943
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 18:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4453BC4DF;
	Thu, 15 Jan 2026 18:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiV6XWyj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DE33BBA0F
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503148; cv=none; b=d+2wqyGcAOzZCswrUzqmUyQZPwUshjcia+CF7vdvSAlUp2CbcsxeUvI6wXWJYOkXbh/yLVclpNJuqrzyPcZu3aOLpnF33K3jAUP48TDGqL+WOE8Qhd1fLas6aTl0t3lGZUbDgCMWqgkvmfTSDMF0F+8gw/A0Kab7xXIrDwJwZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503148; c=relaxed/simple;
	bh=TuEFRuqLBOnYedH6bHZA/P5wHxHxsIqISOe/UJTU4FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gfe9RnKWKCgBBVJfZRTO3kFua79LM48QAI/r9mtlYy85mQxk8cdG3gLFc4EuGioFR1ISouI0kdJhptNofLy51mt/ldfyvgfHs8GfNioK3QBS/rML2UjF03NZJzBtw3kKNdcrpqQyl2zwp8u7+wiLECdzn+a8hoTtBmtgc2k5rOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiV6XWyj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47eddddcdcfso7039535e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 10:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503145; x=1769107945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFeXl8zneto1MokIObjVTz/6UgfEQ0ha9IzMl9847FU=;
        b=hiV6XWyjsZDEfUa+xjCd6FxYmqj0qJ6lPA3LhQmFhzdu/h8nk+X8NIZr9SrRcQo/Zo
         eNOtxkTHJCX8VZCUgs7KCBS53Fuw8mG7Q7Hzjq55cfIX8jZHuID0SnjPQuVHUPw+BA7l
         nygKo9nqGNVQBkT7sTkyckeT2HnJAoa8uRYf+eeZG9mJcdSqSgM0A5HXOStPyC7gSmfM
         1eRSuuSGRyHOviC0d1d/xbXCuSOQCF0okjhpAAM/Re6DtEQaKRkHz//QDkYwqUPPpBSV
         R3dDxS2X+mkHw9HI/mfry7w1PRSrLouCHACcLJ3FYPbyBqfG5bf+DYOemeVtHjLGQ29d
         733A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503145; x=1769107945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFeXl8zneto1MokIObjVTz/6UgfEQ0ha9IzMl9847FU=;
        b=xUejYYjalmd3Gzaq6/3slNYc/PrefVJvZxc4fin/GOGnaNUZ7nBd6uv9QlY/TGxxm/
         nezDX+DujhkrBS3njn43gzqEcCYnqORkC+0W2cEUxw9sx4RuPUm7HlU6QJwEtitWlaZL
         KiwPMR0gEvYjORn0PrLvRIe3LrSfq/AvRH2zEgGKub9hvEZdrB8XUHp63JFgJKP+0TKX
         uaYoTvicv0SLKIanhRjQvUV0IT7bfDEP1xOZ4l/ksCHnU4AvNuAYbZzVcWQmZyf/bCQp
         wpgKOvUeRHau6jGEgdwzCOuWLad9YLRQTcMtdPSJ3PVhwF3N9GhVvsCF27E08lDfzdrA
         /h+Q==
X-Gm-Message-State: AOJu0YxuR2Lf7pdnyPPgTXkJdMNLrTTHLAeAZjBcP47UAgb+hH4mSwEy
	kXPzb2W7cFuyoz4Bl/SMVu67mSrNzfc0kMK2hhZvk+XqweEJM5gTCI+s
X-Gm-Gg: AY/fxX6qXJ9zwtXoBJ359N5BMaQkmgWKA3htwl9GgqwnhW8GAYjMr6khtAncmyxbfUE
	X5Lq/gJPE9BgW2U0U7QkJDG2ofqCzKHOVywEZdv8b6HPYaN0retehbN2k6nKsR1nY4nqK0AwnvJ
	QOuFyN4YLbo1zoctmUm0LslYIoR06MnHsNxfPetz1quTaKRNyRhnT8nGSrq8LWLp/Ckol1zbk2k
	JMq6vYcOvAr+aAIXxndGJ/s6hVWjwknht+8Vhln0kb9bXTSJ/j0dTDVa9bw60B3MfE8F+0RsGHv
	FGhHo4oL5lyZioVBrvT9Rc8e44tCvlVC3GXdNl9SqSQ9HtFMbrAFnCRxe0SSl8Lm2iXY2SJiEtU
	PTtRykdGw/jADb8f62C0Vzz7Y2IHs6trjreAJZ/HpM4zcHaJYORTB5TX8EGHilGll4f7r0Iw9fQ
	udqTsE6SobRi9qMuklWhLUEGV5gCQn2KQ=
X-Received: by 2002:a05:600c:1d28:b0:45d:5c71:769a with SMTP id 5b1f17b1804b1-4801eb0d727mr1966235e9.26.1768503144657;
        Thu, 15 Jan 2026 10:52:24 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1131::11fd? ([2620:10d:c092:400::5:2520])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee85e8807sm33760485e9.16.2026.01.15.10.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 10:52:24 -0800 (PST)
Message-ID: <56169b8c-2bba-4a11-95dc-51789ed2c915@gmail.com>
Date: Thu, 15 Jan 2026 18:52:23 +0000
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
 <14ef41d3-778c-4fe1-841a-9caffe8e0ec9@gmail.com>
 <CAEf4BzYDSKHjdr_tLoYgDT6s09S8s2U7vS-v67kP1ZRGDvQhTA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzYDSKHjdr_tLoYgDT6s09S8s2U7vS-v67kP1ZRGDvQhTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/15/26 18:39, Andrii Nakryiko wrote:
> On Wed, Jan 14, 2026 at 6:53 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> On 1/9/26 22:19, Andrii Nakryiko wrote:
>>> On Wed, Jan 7, 2026 at 9:49 AM Mykyta Yatsenko
>>> <mykyta.yatsenko5@gmail.com> wrote:
>>>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>>>
>>>> Refactor bpf timer and workqueue helpers to allow calling them from NMI
>>>> context by making all operations lock-free and deferring NMI-unsafe
>>>> work to irq_work.
>>>>
>>>> Previously, bpf_timer_start(), and bpf_wq_start()
>>>> could not be called from NMI context because they acquired
>>>> bpf_spin_lock and called hrtimer/schedule_work APIs directly. This
>>>> patch removes these limitations.
>>>>
>>>> Key changes:
>>>>    * Remove bpf_spin_lock from struct bpf_async_kern. Replace locked
>>>>      operations with atomic cmpxchg() for initialization and xchg() for
>>>>      cancel and free.
>>>>    * Add per-async irq_work to defer NMI-unsafe operations (hrtimer_start,
>>>>      hrtimer_try_to_cancel, schedule_work) from NMI to softirq context.
>>>>    * Use the lock-free mpmc_cell (added in the previous commit) to pass
>>>>      operation commands (start/cancel/free) along with their parameters
>>>>      (nsec, mode) from NMI-safe callers to the irq_work handler.
>>>>    * Add reference counting to bpf_async_cb to ensure the object stays
>>>>      alive until all scheduled irq_work completes and the timer/work
>>>>      callback finishes.
>>>>    * Move bpf_prog_put() to RCU callback to handle races between
>>>>      set_callback() and cancel_and_free().
>>>>
>>>> This enables BPF programs attached to NMI-context hooks (perf
>>>> events) to use timers and workqueues for deferred processing.
>>>>
>>>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>>>> ---
>>>>    kernel/bpf/helpers.c | 288 ++++++++++++++++++++++++++++++++++-----------------
>>>>    1 file changed, 191 insertions(+), 97 deletions(-)
>>>>
> please trim irrelevant parts to shorten distractions in email
>
> [...]
>
>>>> -static struct bpf_async_cb *__bpf_async_cancel_and_free(struct bpf_async_kern *async)
>>>> +static void __bpf_async_cancel_and_free(struct bpf_async_kern *async)
>>>>    {
>>>>           struct bpf_async_cb *cb;
>>>>
>>>> -       /* Performance optimization: read async->cb without lock first. */
>>>> -       if (!READ_ONCE(async->cb))
>>>> -               return NULL;
>>>> -
>>>> -       __bpf_spin_lock_irqsave(&async->lock);
>>>> -       /* re-read it under lock */
>>>> -       cb = async->cb;
>>>> +       cb = xchg(&async->cb, NULL);
>>>>           if (!cb)
>>>> -               goto out;
>>>> -       drop_prog_refcnt(cb);
>>>> -       /* The subsequent bpf_timer_start/cancel() helpers won't be able to use
>>>> -        * this timer, since it won't be initialized.
>>>> -        */
>>>> -       WRITE_ONCE(async->cb, NULL);
>>>> -out:
>>>> -       __bpf_spin_unlock_irqrestore(&async->lock);
>>>> -       return cb;
>>>> +               return;
>>>> +
>>>> +       /* Consume map's refcnt */
>>>> +       irq_work_queue(&cb->worker);
>>> hm... this is subtle (and maybe broken?) irq_work_queue() can be
>>> ignored here, if there is already another one scheduled, so I think
>>> your clever idea with CANCEL_AND_FREE being done based on this
>>> refcount drop is flawed...
>>>
>>> CANCEL_AND_FREE has to succeed, so it's out-of-bounds signal that
>>> shouldn't be going through that command cell, yes. But can't we just
>>> have a simple one-way bool that will be set to true here (+ memory
>>> barriers, maybe), and then irq_work_queue() scheduled. If there is irq
>>> work is scheduled, it will inevitable will see this flag (even if it's
>>> not our callback), and if not, then irq_work_queue() will successfully
>>> schedule callback which will also clean up.
>> Thanks for pointing to this issue.
>> I don't think we can solve it with a simple bool, because cleanup
>> should only happen once, and only after refcnt is 0, otherwise we need
>> to go
>> back to states to indicate cleanup initiation and cleanup entering (to
>> implement
>> mutual exclusion of the irq_work callbacks trying to run cleanup).
> I meant bool as a command indicator of sorts, which is just part of
> the solution. We do have reader's mutual exclusion with last_seq,
> don't we? And the idea was that once the winning reader notices that
> shutdown was requested, they can perform it and make sure that
> subsequent readers (if there are any scheduled) would do nothing.
> E.g., by setting last_seq to some special large value to indicate "we
> are done, no more commands will be accepted".
Winning reader that runs cleanup can't tell other pending readers to not
do anything, because after cleanup we can't guarantee that the bpf_async_cb
is not freed, other readers have to access it, that's why we have refcnt 
that
is the mechanism to make sure the last reader does cleanup.
>
> But let me go and read the latest version and refresh what's going on
> there in my mind.
>
>> We can still solve this with the refcnt: Drop reference, if refcnt is not 0,
>> we successfully released map reference and one of the scheduled irq_work
>> callbacks
>> will cleanup, otherwise we took the last reference, all we need is to
>> schedule new irq_work
>> (which can't fail)
>>
>>       if (!refcount_dec_and_test(&cb->refcnt))
>>           return;
>>
>>       /* We took the last reference, need to schedule cleanup */
>>       refcount_set(&cb->refcnt, 1);
>>       irq_work_queue(&cb->worker);
>>
> [...]


