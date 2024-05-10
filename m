Return-Path: <bpf+bounces-29559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E08C2CCD
	for <lists+bpf@lfdr.de>; Sat, 11 May 2024 01:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF7D284837
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 23:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF1E16F26B;
	Fri, 10 May 2024 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR1T0oCl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332CD28F3
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 23:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715382256; cv=none; b=jKiWaOUtAcbyQwIBJ9X6PQa1R9TVW2ZNH7zlW9lRsbWir4/Z/CanxPrJA4vqrI0g0tUL429MShCWtruYlcOQ4QBwT4HBoXKQ0OfbCZsiYVIPfPQX5Ru0zLBlWfvm+AdcRsYoJEkP/wZM6iPs7lwgMGPOZLMp20QeOGDzKzsQG0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715382256; c=relaxed/simple;
	bh=KpTpfZReZf9aqvC9aVP4QXAYC/uVAFiOnZjFJX1xNgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OxIXQg6R/7YUZsiAdAx/mRi69WD8C8jMK0HfyK8vBrzG+tdFoLpFzmViadBEEiD31v/M8EzG3mWDdYc//n1Hc0m9A8seFmDuqHDFY+VUyWN/Wj3qXomJUBPlRc/e0FmFaHqSL6p3pGdCkACY0f/PHuVIAT54NxkyOo2CIYIKbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR1T0oCl; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b295d6b7fbso275946eaf.0
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715382254; x=1715987054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6fSz3vs34zNtzIOdGc0Arsw2gUpE1QOFCRDlBv5lwp8=;
        b=OR1T0oClE3/BUhBU3o/aN3p6DhdpGi8VTJAgQZ0RBSkp0lQINZR6m15epEsJyJu4o8
         JxsMuPweHQmmR4DuqE3HDLMmyi50zh+/2ywK5x8tjUm6mRnQiHA6jGXfE6BBZ/V2udH8
         0C2HdYiiquzFxQVAGqgHxuOL9pGxCHULfSy5lSjtrNoQAajx0NxiQz/6dT72JkobbYbS
         +ywBdAD828CZcuVKkI8ab+6OkicWiebeAm+qE5MVJ/tvlwxvHAS9BZsRzhlxp/g0sES6
         YquhpeKcV9HCdH4hMKadVJ/o1sRaqr/ucalx75O8rcBAFhJUTF3AyO37r2BnJ0CaeJUJ
         4hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715382254; x=1715987054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6fSz3vs34zNtzIOdGc0Arsw2gUpE1QOFCRDlBv5lwp8=;
        b=mwWqLmFJNTqjlHfiZLAdFjBtz9TJVk2mnCVGU7s2FbLjzE3wNrUH6IpVZUENb8ovbO
         U7rmzTvLoulOhrFZVnXQCYUgO+er7BIANhUJTJz8vZJH98IPDKcRRsrksqmamVz2bKt9
         XUIgLMaSntUeSYss4zW+5krT+SCGocGh5ffEDQaZoo0gANO3TeoWfxr1dpHXlf5d1Cb9
         8Qtg6yLQ3CSf6eIxksNx9pNnzK9es+Org7m9ObC9gv2S1Zx9lmJv4+LtXFBeKOqJm1m2
         PF7AWPxvg1ecHtuyHCcYsuNx4w1YD2WRpb4mSZftaXqKmN8AKOrQh4bjHPtjJVfQuLbi
         raXw==
X-Forwarded-Encrypted: i=1; AJvYcCXkwmiinSTsILy/JD9jHlVzR+gmQu8vrbnKzVnZhz7t2eiJIe1l2l/U8GugL02X24ZrCh+aNQIfWMb0O2fsiqMdGT1k
X-Gm-Message-State: AOJu0YwRSMxaRYUGXE/08CqDoXxTJtA2d82+O7riDVLzCK+tZjMuru51
	et4ZeGAPy+4x6t9tR6BM5NGpLKmuU69Kv+VE+b5acQMoxpFUhu7A
X-Google-Smtp-Source: AGHT+IHnG9K03np+TfLTfSQ1S7ux75sLhP7jDZ/rzC2JkzTBSqpU5Toq7fqQ208eW27I/2QSmzFD0Q==
X-Received: by 2002:a05:6870:a454:b0:23c:7b6d:38d7 with SMTP id 586e51a60fabf-24172f5e5camr4383113fac.36.1715382254213;
        Fri, 10 May 2024 16:04:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:20fd:6927:f7be:d222? ([2600:1700:6cf8:1240:20fd:6927:f7be:d222])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f0e84867f5sm623743a34.54.2024.05.10.16.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 16:04:13 -0700 (PDT)
Message-ID: <f2d480de-a598-4771-9c72-722dba941e83@gmail.com>
Date: Fri, 10 May 2024 16:04:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 7/9] selftests/bpf: Test kptr arrays and kptrs
 in nested struct fields.
To: Eduard Zingerman <eddyz87@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: kuifeng@meta.com
References: <20240510011312.1488046-1-thinker.li@gmail.com>
 <20240510011312.1488046-8-thinker.li@gmail.com>
 <d8f2fa21a9af5bfcb2acb1addecea435285c40e6.camel@gmail.com>
 <d2b9a943-ca26-404d-899a-c7651ce18a42@gmail.com>
 <62a51fcaddbf5eb8552a96e6a24ded83f8f9fa49.camel@gmail.com>
 <aa0cb7c8-f057-4f51-84c4-2cc9bc4e2edb@gmail.com>
 <a938837ff87adcdebaa58f612395dee06a0ea94a.camel@gmail.com>
 <52912c4f-219a-45d4-bb61-aaeadaf880c5@gmail.com>
 <e65e8c7d387312f4b13a1241376ad6b959f90bf7.camel@gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <e65e8c7d387312f4b13a1241376ad6b959f90bf7.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/10/24 15:57, Eduard Zingerman wrote:
> On Fri, 2024-05-10 at 15:53 -0700, Kui-Feng Lee wrote:
> 
> [...]
> 
>>>>>> Do you mean checking index in the way like the following code?
>>>>>>
>>>>>>      if (array[0] != ref0 || array[1] != ref1 || array[2] != ref2 ....)
>>>>>>        return err;
>>>>>
>>>>> Probably, but I'd need your help here.
>>>>> There goal is to verify that offsets of __kptr's in the 'info' array
>>>>> had been set correctly. Where is this information is used later on?
>>>>> E.g. I'd like to trigger some action that "touches" __kptr at index N
>>>>> and verify that all others had not been "touched".
>>>>> But this "touch" action has to use offset stored in the 'info'.
>>>>
>>>> They are used for verifying the offset of instructions.
>>>> Let's assume we have an array of size 10.
>>>> Then, we have 10 infos with 10 different offsets.
>>>> And, we have a program includes one instruction for each element, 10 in
>>>> total, to access the corresponding element.
>>>> Each instruction has an offset different from others, generated by the
>>>> compiler. That means the verifier will fail to find an info for some of
>>>> instructions if there is one or more info having wrong offset.
>>>
>>> That's a bit depressing, as there would be no way to check if e.g. all
>>> 10 refer to the same offset. Is it possible to trigger printing of the
>> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> How can that happen? Do you mean the compiler does it wrong?
> 
> No, suppose that 'info.offset' is computed incorrectly because of some
> bug in arrays handling. E.g. all .off fields in the infos have the
> same value.
> 
> What is the shape of the test that could catch such bug?
> 

I am not sure if I read you question correctly.

For example, we have 3 correct info.

  [info(offset=0x8), info(offset=0x10), info(offset=0x18)]

And We have program that includes 3 instructions to access the offset 
0x8, 0x10, and 0x18. (let's assume these load instructions would be 
checked against infos)

  load r1, [0x8]
  load r1, [0x10]
  load r1, [0x18]

If everything works as expected, the verifier would accept the program.

Otherwise, like you said, all 3 info are pointing to the same offset.

  [info(0offset=0x8), info(offset=0x8), info(offset=0x8)]

Then, the later two instructions should fail the check.


>>> 'info.offset' to verifier log? E.g. via some 'illegal' action.
>> Yes if necessary!
> 

