Return-Path: <bpf+bounces-73964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB9EC40B70
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 16:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B2424649
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0E032E153;
	Fri,  7 Nov 2025 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dct8fIZe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421D328312F
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531092; cv=none; b=eC8EHlbWQoS7zWsOldTIqoMoera9u7cHAzXsaBDfwFiW7jGhrE+jqBSoyKAiY11zoSYo4Q0vue6+HO6dT96cm2zVuV7m1DRA7OU3EHHLMC7/KWj9d8iVfhKglt9kBvQU7IsyNqS4cjU0pgwDCYsSBSF5n6dDQtGhf6bisvKgcYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531092; c=relaxed/simple;
	bh=Xg4cQvgobpjIZVfOCIdzXGrVTpop5IMMRxKO31kSTTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1sMsttN0mndd5kz1Q2rjh4R4Mydb0iud3QWXizxFtmnbDu/wt9s8EimLTLw1ZbhUDkp6NeNDue8czk6Y9fFg9WLWCCN85Wlbw7KWGE0LjQ8buVpnKffGuAs1u4Bs4XFZUe8ZSjIb8eMvIFcX7b0sJ0yAffe90tynxx568m0b/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dct8fIZe; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477549b3082so8377645e9.0
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762531088; x=1763135888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTUW8Brp0NPVy1C93ZoLDap7mWH8tplUaBHz9zeWXfs=;
        b=dct8fIZeTMgijB+cobgMu0kKUjTlNClgsiX/ibo/DdvqoPz4ldaWu9L6JKgbfyQcE2
         fZi+GZrUp99v+kGbR4eNUkYdy7MpR2HuA9HOt/BHTiIcd1njTh4EEubdukaXunvul4yO
         zJAc5dF3F4bCOqMn2LIWm4dbvMjgWKckYa2a/XhLMu0vWtM53fp8o0ujj/X2b3yrVf14
         qpwPl3olJpL5D+MYxbzQAu8hwgzveZiH7WO06jlrGtm6hMJEqo9ZdyZlBqS02oLrNNKA
         L1tSgwRLE2gGFFCqVKziZ1FRdajrtOBMgZsLevvAcuVKq6WD0ClPNBeba5WoOKuS/hHv
         Hh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762531088; x=1763135888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FTUW8Brp0NPVy1C93ZoLDap7mWH8tplUaBHz9zeWXfs=;
        b=JbUC6if3rBlcJmoUYTFsWPmNp8gF5FmMowVPmafc+/x5daoURzBD4FUi1rmzXsmTDp
         tUl60enTy9azDLV9wZNkYS8y9JN1bLi4szpuysUfnhmpAMG4eHwvqDAen6YlSZG+bwND
         1rh8wyl4E/iPISxwn6L+trypc4UQ/iYbrrcavVTkVpQvIR6Q3XqaL5XG1WGimpzzDXWg
         eI6N1My3Z8QBnN6T0XkFkM2b/Eqz8KlPB80bNWDeE0o0BAC/lxvQ9Re7GhzjPyvtkNHZ
         ouknjtbLXjGhBTaH72Vf4LSDXuMDEgz0V3DfFgAKyNWqyZVsWd+jOpWxUxzOUjAsuCwi
         LF0w==
X-Gm-Message-State: AOJu0Yxjz4nCPXviTyJbaIsdAM/UgPecMobe+kKZ9zDBe5bEK31G9tal
	6iF50GHjCknamvhcUF/xKguDEFYwfXuhehmaqWl0VVt7UgoVLaX+nNtA
X-Gm-Gg: ASbGncuUHt2UpK0UGDwgbkO+m+jzyd5zadLegQVoTWzjO3dxybUJk6JtPCau+5OExLC
	XMDIu85dMtlgpXPirQZpZlt/+Y9X9TUXjBAz2mLifjUwGb3FwdxmOBiWifg69hzpgObBiMx85ll
	vyQzZf8nsNEVsgcv4zVQW0beRgYmfsrZTNC+16ydM0TDs92mHZs3kaarFFCAeE24Zy1iB33UDqd
	+cuJ8Vv7WNEnaQx1YWdGd4FcnfEl5zXkHT1xvi7JoAlgg9clRShSiI1HBIdfMds6F020KbxTD3l
	BTJW5Vu8B1mMMeK09fNMDl5Q6CnvIZsL4nbNVNO/0dJF27GIs/bIk2lqtSJ3DRtHKM24GDgAQn+
	GhiR8ZnW8qLztxT9pVAKIpQdUnHav/rAa/bMW001j4RmX//aoiqb624WNFz0/JskNF9U/QcGSOV
	Ldx0zkXMES+yFEs5JtWuZjnRx+6Bhd/kHZJtJr1T3VmubDdzaYK6acCBv/QeDD4Ky4
X-Google-Smtp-Source: AGHT+IF6W71omiFca2cbowK8oSLO/Mt3b967YxmxMPRJ9jYP4oQmvI7pyecTdXMkTAPJ3Cpej8xDlg==
X-Received: by 2002:a05:600c:c491:b0:477:2f7c:3140 with SMTP id 5b1f17b1804b1-4776bcc9cdbmr31740235e9.37.1762531088225;
        Fri, 07 Nov 2025 07:58:08 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7? ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc528sm176777265e9.7.2025.11.07.07.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 07:58:07 -0800 (PST)
Message-ID: <6334ac51-eb49-4ec7-b111-75f5a260ba60@gmail.com>
Date: Fri, 7 Nov 2025 15:58:07 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 5/5] bpf: remove lock from bpf_async_cb
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin Lau <kafai@meta.com>, Kernel Team <kernel-team@meta.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard <eddyz87@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com>
 <20251105-timer_nolock-v2-5-32698db08bfa@meta.com>
 <CAADnVQK250aA9TjoJWwBtRP+e7j254d4CQ=_2Sr=0N0O2G0E2g@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAADnVQK250aA9TjoJWwBtRP+e7j254d4CQ=_2Sr=0N0O2G0E2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/7/25 03:15, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 7:59 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>> +
>> +       guard(rcu)();
>> +
>> +       t = READ_ONCE(async->timer);
>> +       if (!t)
>> +               return -EINVAL;
>> +
>> +       /*
>> +        * Hold ref while scheduling timer, to make sure, we only cancel and free after
>> +        * hrtimer_start().
>> +        */
>> +       if (!bpf_async_tryget(&t->cb))
>> +               return -EINVAL;
>>
>>          if (flags & BPF_F_TIMER_ABS)
>>                  mode = HRTIMER_MODE_ABS_SOFT;
>> @@ -1489,8 +1512,8 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, timer, u64, nsecs, u64, fla
>>                  mode |= HRTIMER_MODE_PINNED;
>>
>>          hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
> This doesn't pass the smell test for me.
> I've seen your reply to Eduard, but
> fundamentally RCU is a replacement for refcnt.
> Protecting an object with both rcu and refcnt
> is extremely unusual and likely indicates that
> something is wrong with rcu or refcnt usage.
> The comment says that extra tryget/put is there to prevent
> the race between timer_start and timer_cancel+free,
> but hrtimer_start/hrtimer_cancel can handle the race.
> Nothing wrong with calling them in parallel.
> The current bpf_timer implementation
> prevents the race, but it's accidental. hrtimer logic can
> deal with it just fine. So tryget/put prevents uaf,
tryget/put is not for preventing uaf in bpf_timer_start(),
but in timer callback. it serializes or mutually excludes
hrtimer_cancel() and hrtimer_start() : hrtimer_cancel() (from 
cancel_and_free())
is either called before the hrtimer_start(), in which case
we don't even attempt to start the timer, as it is freed,
or hrtimer_cancel() is called after hrtimer_start(), which
is good. Relying just on synchronization inside hrtimer
functions, won't do it, we still hay end up
hrtimer_start() on the timer that just has been freed,
so the callback potentially does UAF.
Potentially this can be rewritten without refcnt, by just checking
the state, but I thought refcnt just makes this cleaner.
> but free is also done after call_rcu().
> So the whole thing looks dodgy.
> I bet state transitions can handle the race to
> update cb, while rcu can handle lifetime.
>
> The combination of state transition to BPF_ASYNC_BUSY
> and xchg(prog) also looks weird. Why xchg() is needed
> if BUSY indicates a prog being updated?
> Because bpf_async_swap_prog() is called during the free part?
> Then don't call it there and drop xchg.
Yes, xchg() in bpf_async_swap_prog() is there for if there is
free part running concurrently with set_callback(), both may attempt to
bpf_prog_put(prev);, but only one should. I see your point, though,
let me try to resolve this problem in another way.
>
> Overall I see rcu, refcnt, cmpxchg(state), xchg(prog), cmpxchg(cb)
> used to address various races and life time problems.
> They're different mechanisms and typically are not combined together.
> Mix and match makes them hard to follow and it will be hard to
> change when/if we decide to support in_nmi() here.
> I think the whole algorithm can be rewritten with couple
> more states, then tryget/put can be dropped, and
> xchg(prog) can be dropped too. refcnt will likely not be needed
> anymore. We may need it back to support in_nmi() and
> deferral to irq_work though.
The first reason to add refcnt was that we'll need it for nmi
support via irq_work, anyway. RCU is critical (as far as I understand),
we need it to at least safely read refcnt itself.
>
> Overall I feel we should decide whether we do in_nmi()
> and design the whole thing.
I think we should do in_nmi() (this is the main motivation for this 
project).
I'll need refcnt (for nmi), rcu (for accessing the object at all). Let 
me see if
I can get rid of some of these duplicate mechanisms.

Thanks for the input on this patch!
>
> pw-bot: cr


