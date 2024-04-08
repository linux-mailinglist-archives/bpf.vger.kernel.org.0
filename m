Return-Path: <bpf+bounces-26206-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D87C389CA93
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 19:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D75B2537F
	for <lists+bpf@lfdr.de>; Mon,  8 Apr 2024 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC4143895;
	Mon,  8 Apr 2024 17:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrxBYUyN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05694142906;
	Mon,  8 Apr 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596571; cv=none; b=KK2AX6wdbdKHXVopaU/q2tjzlpcNFgVqPvy0EhQz9f0reh1MqHSt0LYXyNgpie5c0qAPl38QH2PuvDAfURw5sO6f3rvvYF+YSBMyo6tcDbTY1y5ZR1bykOxWX2Vr5N4ZoQwU67IPWGcW568WnnFQwkMREZ8P9xcqS5/bQ48hxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596571; c=relaxed/simple;
	bh=ODR1yO836VkJRy18ra4Y8897Wllpbk6CPY3PXNp5Xsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoUSkQM1dnGveiOJDdJ4L9KorxqfVYQrfGSQ41KI1cBbatq54JnyyZ8xj+dzq7NwsraIatEr31lVBbdkb1WZVGWiDbv99HlewC00UYIwxACofhs61zTxDGi0LukrDlJvHKWh1lUVykUeHOZ+bldPG/ybcW5LtR3gf7Dszl15sJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DrxBYUyN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6114c9b4d83so39009287b3.3;
        Mon, 08 Apr 2024 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712596568; x=1713201368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EsFUR+GlED9jCReR+yg5uXRlVvU8O2Qtf1SNmtOddPE=;
        b=DrxBYUyNtcEKUOSVCtd5K1IS/0GggmUvfTS2p5W1kz0IGEwBPP625hy9oYrSnvROnq
         316R6Cw4XxTDyQ2OfEAOeCXmSlLOb9sNA70v9KE02bICfJURSjZrtX2sTUJnLzB5tjEG
         e2YI24aHRosZJW0grh5MUxF+eGD+IjST8vaXf0h4oqc/eewfDAK2qtjVInA1R4l0uj51
         eZDwWFyfu2WBRsLcubXiHHHsVIrZZB5r/Pkxj3szMoWlkZWqjwnEuzJJ9babmFCAq1wo
         j0krFiYkCOlp355pXxRRO9m1sTZz1geXDI3HezWbdbDn1EVCWuL0PVv9dKji3rGfAc6X
         hydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596568; x=1713201368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsFUR+GlED9jCReR+yg5uXRlVvU8O2Qtf1SNmtOddPE=;
        b=HLnDmd/LgodddonBByDb8JIt+8GM1UA3Ib44pydTMkFJ+mV6hAoE9I10MnApKIIPIK
         sYKLvcpQ8s4T98NkW/ZOjBcwABKzzLiUwdsPsTEElSB0wpokSy/31upqe4SMDbOaoYkt
         PRMlaEVGJ9WtMe4Nrk2RmnSawLc2yA2SfdEszFf41odLK9vs9gNC9ifEnnOEP9sk1Anc
         lO20cwnq9o9sZ8JAVv8xk4kh6ws4qGTaSljlTvaNvLunKVWNRbadEkXKOD1HRF8f7BL0
         NSsEc1ewnSbygqJTxuhR8FR4arYyO419KgmeBth59mqQN87Pa9c+4g+nD9n1qzdGCVtE
         NRVg==
X-Forwarded-Encrypted: i=1; AJvYcCU2pvhdNU6FScJfsu6qnTygGCayrwKhQAvomfSLKlwcNEDat7PymmQcsI/TGJJsfbL5kR37s8WgJsB1hvkKkcdtM1kOUYX20gR6N1apBKTjC+RcrZsf3ucFw24H6xQ6wujSJByB8qza
X-Gm-Message-State: AOJu0YwSLKha2R5twG3seZcN4YbR052Cs4JZolhy1ku8mmmKiDzq7URm
	5Zq33Yj2Y5iSzanTB/JzWazoGzO2c/i5QfWqrGQcwH6LdLNHHeKL
X-Google-Smtp-Source: AGHT+IHNa10fB4FJ95UazlNcBVd+Tmgy7lUAHUPnZdx4RSsLUTK21rwahXgyTpm36J2AETfN9ZtTgw==
X-Received: by 2002:a81:de4e:0:b0:615:1860:551 with SMTP id o14-20020a81de4e000000b0061518600551mr8360493ywl.30.1712596568089;
        Mon, 08 Apr 2024 10:16:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:ac67:e262:f006:430? ([2600:1700:6cf8:1240:ac67:e262:f006:430])
        by smtp.gmail.com with ESMTPSA id id14-20020a05690c680e00b00611591acb9fsm1761410ywb.44.2024.04.08.10.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 10:16:07 -0700 (PDT)
Message-ID: <0d32fddd-a128-400b-bf63-2da2b3971669@gmail.com>
Date: Mon, 8 Apr 2024 10:16:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] rethook: Remove warning messages printed for
 finding return address of a frame.
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Kui-Feng Lee <thinker.li@gmail.com>, martin.lau@linux.dev,
 kernel-team@meta.com, andrii@kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kuifeng@meta.com
References: <20240401191621.758056-1-thinker.li@gmail.com>
 <CAEf4BzbbneDHp=sD4+5RmuK=U9vg8Uo_M6XEXdKWrZ_MkjFocw@mail.gmail.com>
 <1bbd6200-bb06-f8d2-c22a-39245425b6b1@iogearbox.net>
 <20240408101326.2392a79de4bfe1e677faeff0@kernel.org>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240408101326.2392a79de4bfe1e677faeff0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/7/24 18:13, Masami Hiramatsu (Google) wrote:
> On Wed, 3 Apr 2024 16:36:25 +0200
> Daniel Borkmann <daniel@iogearbox.net> wrote:
> 
>> On 4/2/24 6:58 PM, Andrii Nakryiko wrote:
>>> On Mon, Apr 1, 2024 at 12:16 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>>>
>>>> rethook_find_ret_addr() prints a warning message and returns 0 when the
>>>> target task is running and not the "current" task to prevent returning an
>>>> incorrect return address. However, this check is incomplete as the target
>>>> task can still transition to the running state when finding the return
>>>> address, although it is safe with RCU.
> 
> Could you tell me more about this last part? This change just remove
> WARN_ON_ONCE() which warns that the user tries to unwind stack of a running
> task. This means the task can change the stack in parallel if the task is
> running on other CPU.
> Does the BPF stop the task? or do you have any RCU magic to copy the stack?


No, the BPF doesn't stop the task or copy the stack. The last part tries
to explain that this function can still return an incorrect address even
with this check. And calling this function on a target task that is not
"current" is safe.  Since you think it is confusing. I will remove this
part.

> 
>>>>
>>>> The issue we encounter is that the kernel frequently prints warning
>>>> messages when BPF profiling programs call to bpf_get_task_stack() on
>>>> running tasks.
> 
> Hmm, WARN_ON_ONCE should print it once, not frequently.

You are right! I should rephrase it. In a firm with a large number of 
hosts, this warning message become a noise.

> 
>>>>
>>>> The callers should be aware and willing to take the risk of receiving an
>>>> incorrect return address from a task that is currently running other than
>>>> the "current" one. A warning is not needed here as the callers are intent
>>>> on it.
>>>>
>>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>>> ---
>>>>    kernel/trace/rethook.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
>>>> index fa03094e9e69..4297a132a7ae 100644
>>>> --- a/kernel/trace/rethook.c
>>>> +++ b/kernel/trace/rethook.c
>>>> @@ -248,7 +248,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
>>>>           if (WARN_ON_ONCE(!cur))
>>>>                   return 0;
>>>>
>>>> -       if (WARN_ON_ONCE(tsk != current && task_is_running(tsk)))
>>>> +       if (tsk != current && task_is_running(tsk))
>>>>                   return 0;
>>>>
>>>
>>> This should probably go through Masami's tree, but the change makes
>>> sense to me, given this is an expected condition.
>>>
>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>
>> Masami, I assume you'll pick this up?
> 
> OK, anyway it will just return 0 if this situation happens, and caller will
> get the trampoline address instead of correct return address in this case.
> I think it does not do any unsafe things. So I agree removing it.
> But I think the explanation is a bit confusing.
> 
> Thank you,
> 
>>
>> Thanks,
>> Daniel
> 
> 

