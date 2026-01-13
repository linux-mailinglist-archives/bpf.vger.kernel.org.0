Return-Path: <bpf+bounces-78735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 114B3D1A20C
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 17:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C370301473A
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BB1387366;
	Tue, 13 Jan 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkkFHQHT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5B138E5F2
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768320849; cv=none; b=AWQv4+YiO0Hy1zKpR+LADsXC0Y9ApCaaFxNHd8TBlIdo7RWKKFYka6AFlS2j4Fu3ZVpKDCjsKRxgsLYXvJlqeYM8mLuvzdj0682beNzcGkQ/j+omsFYlVlcghTB3ZzEl20xP/rNxnOAqb0AUqVw+PIL8OllW+o2MnO1KrqsDS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768320849; c=relaxed/simple;
	bh=Aj3HD/VpEXsMdp8lh13TZEWDifOPx43NyHbhRJhXeDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZPiVaCoCe8YnhcJ4A7FcYMrBfdy21Fij2wajUNEKn+UAz7UTNq4YZcPx6lsgxQvFQLqFTJBIKdFhSWgICPIDQYdK0qM+56UZlF+D+Wwtp+FSi3yGdMc184jAz2eUCH+fkKco8OXhzHAqFssoJfCLwPJJ9cQEdtWYs0Pn/xup0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkkFHQHT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so65094605e9.2
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 08:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768320843; x=1768925643; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zYfRSSjlSNaP5v3wkjNKMVyqs3OQ6jB3wWqwnWe1Yqg=;
        b=NkkFHQHT6VVSLHK35RuC7BVs44lcXaQhPLD8aPEv0/PLek8vlVGVnS/2I1yXUE+fCJ
         bFTn7OKhIEgv99HwUAfwiukcvY65NM35YAAYctQ70hhLR8JAmMR/WAS4HuyzVzfPXuPG
         wNFw2BRH6oZSAKu9dwhAekeFNY6+sSCj3AG1XBRB1mkSjROJnnjyEFaITIQepKhjgPPX
         ph103G0JbD6WXcCmWxKe6SpEilfVqxOMv3xDeWfp5uTsaxJQFvFrB7ipzqXbvD9VbyYh
         v19PwAtSfYNdBCm0D+au/f0tuo8ZtReg1HNYjjag3diBqlpQj7WBCOZAsZ6odDAk9wbB
         D/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768320843; x=1768925643;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYfRSSjlSNaP5v3wkjNKMVyqs3OQ6jB3wWqwnWe1Yqg=;
        b=RivumngZ7SV6bDgWTbBKTwTTHb0466G34pXcRBPp9xBw8ULdEAlvmsXi2lkYVMLTRk
         M8ZtwBpwbkgSLkegfUhkEnOV2mJHcE1+Vto+LAyfq4ttHa3z1O3cxJa/LGhwyjIX+lvB
         K0uACcIogeaOBoZ5MDzBEE408hB7Uj1bsZN/kvopEdEQ4utVRPrbAf+b5YfHYBJzTOCU
         so5dwIhX+q5yTkcTGP4q6Lcc7rKD9lo4Dh0uOv+yI/YHSeSWtBSjnirITMfpPVUWson/
         mhPdHF+IGx2kimoNaK9bguQkzaUNZ0pqFiWv12/HhLGVsybaQbndHGP82z/CObhSkO+f
         +wbw==
X-Gm-Message-State: AOJu0Yw4A7blp/3HNsfS1Lt6IzV9QCi9ICEdoSJbU7T5HgvKFJ/Zybd2
	rPq2yuL0D49X5DPKlvEhfXbaPt1lfXN6ZS1+e4Luj2NeiSO/1QK4OR6a
X-Gm-Gg: AY/fxX6ELgZ3IpLV+VMajilhoGKUEEW0tfZr5sn4Kq3Rk7GiU9ZgrpB4hLofCd96rKs
	dfKqHYypj0sb3IAdyshSOV6TwphJaMC66GdO0otUCpXTsc+zA0jMls7X0q6o6E5ySkKsZA1mlSb
	jdlqZa1FXL8NKy1nzZiLtKAZodVSIlo6t9FhG/yib4S4H8Y3O6LcWYT7vgZ8MnRyzGx9zaJ0a0f
	qFNVWupdXkemBrZXZA9p9E/1ED3PdQUtSDK6Iqf3W+EB1oAPXbasdNHiv/JwSShaIH46Ni9IRoA
	vCZiKn0Ov5ihUpCgryoMb/kAGpXHAkCOFc4Tfmqkm8ZM4v0R6rjW9PJ5pfe0mKtiiFPndGf1wiY
	/Jhl5Eb4Izsm3NKPDPE3nuMD9ZoxjRnutgz//+N+4i4ZSQM8wqa7jvR5enwvOJts+cumB4+BwbZ
	KDHI7A/w13fUmFQF4cbskVYRQrYluyOuA=
X-Google-Smtp-Source: AGHT+IFu8Ih9/j1w0PDlLxzv9X7FbxF51LW7MPWrrbSTf+Y919z9/ZeyZ5z4+mVoawyJ8qWdzhaMdw==
X-Received: by 2002:a05:600c:3556:b0:477:6374:6347 with SMTP id 5b1f17b1804b1-47d84b3bb18mr273539765e9.22.1768320842738;
        Tue, 13 Jan 2026 08:14:02 -0800 (PST)
Received: from ?IPV6:2620:10d:c0c3:1131::1042? ([2620:10d:c092:400::5:51be])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee0bae24dsm3233855e9.1.2026.01.13.08.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 08:14:02 -0800 (PST)
Message-ID: <0149734c-91e8-474b-99da-b0f20efb2329@gmail.com>
Date: Tue, 13 Jan 2026 16:14:01 +0000
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
I think what I missed is to put rcu lock in this function, because the
last prog reference is put in the rcu callback (the change this patchset 
introduces).
This way we make sure that whatever is set here will be put if map's 
usercount goes to 0.
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
>
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


