Return-Path: <bpf+bounces-78721-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 87347D1944C
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 15:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 817133061B20
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E0B43921CE;
	Tue, 13 Jan 2026 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvlgySSk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D303921C7
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312698; cv=none; b=SLYAvQfzJ44IVlylou9r/ajLUJRlpemItSX6Hetc+PmwtM+O/j8WTR4yL9K8wPGO6CPHC/v/kZ3xBuedDaNQ+qV6WZBq2YDpBzFXTZEhn7gIpJDhh/rK+JlnD74kjqlj2JPNa9VCrnfCAMIavgDjWvBNqO0w8Dd9i0jaXhM8iIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312698; c=relaxed/simple;
	bh=axXPWmkh8btYQXLesAUAYRfepKccq5Z8oNipHM7JBYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sSujoU1OEu/ppR6iAFi+g+BN7Fq6QVBldpi2TZxAkpAdcVbcajLMzYG5F3zbgIxMsOFEoQoejdsHl8TGh/NCK8n2FgXq91X4VuzSRp+Hm4s9noUd6jR0L5KQ+D9XnmCAxCGB6RlYq7dYATAHsIBxBt3Ccc0f/28qdomEUdSFiGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvlgySSk; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso44080125e9.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 05:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768312696; x=1768917496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EenvMeocALnIgguNJ/MJlTcprMyQ9dSVA2Yv11brfDQ=;
        b=fvlgySSkC8Z2+uvXYmL8iASS4PbIgh6OaRvSar4WImaj35hF2YlpCYfMi5OPL2Zr8X
         TY7JcuT5VP/KWGj4gLIOfR6zhRYUTwQ9QxMgq1Kr3Y9SyqvyiM33JeIoBH3wv13f2gQD
         qHUmpeoXdyRpYT0+u/hutHdGvllmtNAuxfuzIqK16OCvIquV08NcJC3+aJFEcxIuMOL4
         S3RsNVib4PHkJskxaYB9DTyQbGsxCZ9S5nSIziPjhqB6M2J/pNXD/i+eA5OnYlhqk79s
         +oXMvHo8eXk2sj+sydIndbDEc2QyT6a4o/C0gCNCKqzvPAN6t0N6JjIwayirzUxN06dW
         SQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768312696; x=1768917496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EenvMeocALnIgguNJ/MJlTcprMyQ9dSVA2Yv11brfDQ=;
        b=SDXdmtc2BhZC68V7XQfgAXOPDWE1rb3+TGORCP2mBO6XpQAyw5jXPyF+/kyCTbuEGS
         ty0GesH8yRcmD1GyrkWxsYgUWmLgYCGIBWaSO24nqzYx6CgY6oZA8bjUOjkSShdXEgbi
         NQVrwGDi7V5NS4WVSENDBnLeQb2vyFQJzyWEJa17L6h42gOrCslvI+j+CHD+QYCm4hae
         YYgc+rrS/KCh4dCrNDAkGWT/HLde73k1YUGdY2b+lkF5RUqVLE44bam40J+b4Mr0GXOz
         Wub8KpoWlXV1cP4WJKZ/3Lxm/9xe9pnjNtqaxnqvN/svQb2Ysczm+Jf7a2W+YxTSCaqP
         RJVw==
X-Gm-Message-State: AOJu0Yw/rfzhi8Xo1rcz38D5kJmx01FMf1RGEmxPKF0qKfH/HuVCzoae
	SDUhCi8obxPQNGYqcKptjWERMyrTqK+3JWEmDk8S5xXcWa5l8SS00kIe
X-Gm-Gg: AY/fxX7A5v6QxAKpZtoMOiVf6rMtNDYBt+BEhehtaFgULfeAVqHfh/psX/hnJzP91si
	y+dyFrP2z8rG2tgRoX83SN4/94CiKmnk93iaszEKDxfzJW3EYmqe2Z2oY3qYOjiB/byqZMqFZM8
	HvV6gCpJvh9UrzLCeLp+hqX4NgWhJZnbHHYmQQoTZ7De5SEocXC5N10jhIVyhbQbrqxAPEoNSpE
	6w2MK/7IP6WfpUgtnYP6Tjr2xv5SPlRVlzm9niNg9fhj8FkbS9ZyMeWOybCLPf6XNoVTyfu1il5
	kgRGAHom4KBFVKtlgxrdMGPx8wBHDSli5j4MIbfQWmTxQhJ10+yHKbbhk9NV1H2NRGOcA7vElxQ
	AD3TOV/cZo6Vqe/7eclhH+IFul2vna+FHSL0QeGk9l7B31xchpwIoYbZMjElQz7q5afwjIHCgC1
	bhCS4IFmMbLwd/I+u0f6DV0MoFLfut6RUblyFI14sbOw==
X-Google-Smtp-Source: AGHT+IGkqPXi3Y9rt5Xfbu5D/Hf7xrK9TUw6Bgs/rCz3KPz74bCfqXPr8dDlZL9gTWLeHY5EBCyr+A==
X-Received: by 2002:a05:600c:c117:b0:477:b0b9:312a with SMTP id 5b1f17b1804b1-47d84b0a293mr185403125e9.7.1768312695424;
        Tue, 13 Jan 2026 05:58:15 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1131::1042? ([2620:10d:c092:400::5:51be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47eda93feb3sm37697545e9.13.2026.01.13.05.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 05:58:14 -0800 (PST)
Message-ID: <386e3d10-c2a9-4bc1-bf7a-c88d7c90fe44@gmail.com>
Date: Tue, 13 Jan 2026 13:58:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 01/10] bpf: Refactor __bpf_async_set_callback()
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 memxor@gmail.com, eddyz87@gmail.com, yatsenko@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260107-timer_nolock-v3-1-740d3ec3e5f9@meta.com>
 <b24f940a2d2e990dc39154bc606665b36e1630fde457032d64f2a2ee5c0f4b45@mail.kernel.org>
 <CAEf4BzZxZbUjBS2v-SO8Z_g_hxbrZy9JTVYTdryE0OzZx7PSyg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzZxZbUjBS2v-SO8Z_g_hxbrZy9JTVYTdryE0OzZx7PSyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/9/26 22:18, Andrii Nakryiko wrote:
> On Wed, Jan 7, 2026 at 10:22 AM <bot+bpf-ci@kernel.org> wrote:
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index 9eaa4185e0a7..954bd61310a6 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -1355,55 +1355,36 @@ static const struct bpf_func_proto bpf_timer_init_proto = {
>>>   };
>>>
>>>   static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback_fn,
>>> -                                 struct bpf_prog_aux *aux, unsigned int flags,
>>> -                                 enum bpf_async_type type)
>>> +                                 struct bpf_prog *prog)
>>>   {
>>> -     struct bpf_prog *prev, *prog = aux->prog;
>>> -     struct bpf_async_cb *cb;
>>> -     int ret = 0;
>>> +     struct bpf_prog *prev;
>>> +     struct bpf_async_cb *cb = async->cb;
>>>
>>> -     if (in_nmi())
>>> -             return -EOPNOTSUPP;
>>> -     __bpf_spin_lock_irqsave(&async->lock);
>>> -     cb = async->cb;
>>> -     if (!cb) {
>>> -             ret = -EINVAL;
>>> -             goto out;
>>> -     }
>>> +     if (!cb)
>>> +             return -EPERM;
>> A small concern: the error code changed from -EINVAL to -EPERM. The verifier
>> comment at kernel/bpf/verifier.c mentions that non-initialized timers
>> "will return -EINVAL". Is the error code change intentional, and should
>> the verifier comment be updated?
>>
> good AI, I asked the same
>
>>> -     if (!atomic64_read(&cb->map->usercnt)) {
>>> -             /* maps with timers must be either held by user space
>>> -              * or pinned in bpffs. Otherwise timer might still be
>>> -              * running even when bpf prog is detached and user space
>>> -              * is gone, since map_release_uref won't ever be called.
>>> -              */
>>> -             ret = -EPERM;
>>> -             goto out;
>>> -     }
>> The usercnt check is removed here. The check still exists in
>> __bpf_async_init(), so a timer cannot be initialized when usercnt is zero.
>> But can there be issues if set_callback is called after usercnt drops to
>> zero on an already-initialized timer? The old code would fail with -EPERM,
>> while the new code proceeds.
>>
> Wasn't this discussed earlier, Mykyta? Do you remember the conclusion?
>
>>> -     prev = cb->prog;
>>> -     if (prev != prog) {
>>> -             /* Bump prog refcnt once. Every bpf_timer_set_callback()
>>> -              * can pick different callback_fn-s within the same prog.
>>> -              */
>>> -             prog = bpf_prog_inc_not_zero(prog);
>>> -             if (IS_ERR(prog)) {
>>> -                     ret = PTR_ERR(prog);
>>> -                     goto out;
>>> +     do {
>>> +             if (prog) {
>>> +                     prog = bpf_prog_inc_not_zero(prog);
>>> +                     if (IS_ERR(prog))
>>> +                             return PTR_ERR(prog);
>>>                }
>>> +
>>> +             prev = xchg(&cb->prog, prog);
>>> +             rcu_assign_pointer(cb->callback_fn, callback_fn);
>> Is there a potential race between these two operations? Consider two
>> concurrent callers (with programs P and Q) racing:
>>
>> 1. Thread A: xchg stores P into cb->prog
>> 2. Thread B: xchg stores Q into cb->prog, gets P back
>> 3. Thread B: rcu_assign_pointer stores FB (Q's callback)
>> 4. Thread B: bpf_prog_put(P), B's check passes, B exits
>> 5. Thread A: rcu_assign_pointer stores FA (P's callback), overwrites FB
>> 6. Thread A: check fails (cb->prog is Q, not P), retries
>>
>> After step 5, cb->prog holds Q (with Q's reference) but cb->callback_fn
>> points to FA (from P). If P's refcount drops to zero elsewhere and P is
>> freed, would the timer callback FA become a dangling pointer?
> AI is not completely wrong here, IMO. No, there is no use-after-free
> just yet because program is RCU protected, so we don't have dangling
> pointer just yet.
>
> But. That bpf_prog_inc_not_zero() on retry will fail if P's program
> refcount dropped to zero already. And then once we exit, we'll have
> Q+FA combo, which is not good.
>
> So I think we need to do one bpf_prog_inc_not_zero() outside of the
> loop once and keep that extra ref until we exit. And then instead of
> bpf_prog_inc_not_zero(prog) inside the loop, we do unconditional
> bpf_prog_inc(), which we *know* has to succeed. Less error handling
> inside the loop as well.
>
> Thoughts?
Sounds right, alternatively, we may try to reset both prog and callback
to NULL if prog's refcnt can't be incremented.
>
>> The bpf_timer_cb() function reads cb->callback_fn and calls it directly
>> without verifying it corresponds to cb->prog. The cb->prog field holds
>> the reference keeping the program alive, but if the callback pointer is
>> from a different program that may have been freed, this could be a problem.
>>
>>> +
>>>                if (prev)
>>> -                     /* Drop prev prog refcnt when swapping with new prog */
>>>                        bpf_prog_put(prev);
>>> -             cb->prog = prog;
>>> -     }
>>> -     rcu_assign_pointer(cb->callback_fn, callback_fn);
>>> -out:
>>> -     __bpf_spin_unlock_irqrestore(&async->lock);
>>> -     return ret;
>>> +
>>> +     } while (READ_ONCE(cb->prog) != prog || READ_ONCE(cb->callback_fn) != callback_fn);
>>> +
>>> +     return 0;
>>>   }
>> [ ... ]
>>
>>
>> ---
>> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
>> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>>
>> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20791345842


