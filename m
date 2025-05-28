Return-Path: <bpf+bounces-59142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9908BAC652A
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 11:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550024E03D4
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 09:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C3247282;
	Wed, 28 May 2025 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNlkQ7jK"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF532CA8
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748423164; cv=none; b=bAUxsYJtNbjGjzHI5xq3h6Qxo1u4wbP9lSckgCXefP+rS0of1iQF9vm98jL+AS19yQuEuS8B4eWArO1eaGnOa5NwMg4E3smxOVQEIBsF8s58dWl1XP7pHbVOULRLV1JXDNqKEd5pJ3vRn9/cJsKUw7jb5iaRaFrlEilGwxfzEyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748423164; c=relaxed/simple;
	bh=mZCbeyhRnJWDT0JQk33ywf7KNjWjKxqBK/FQkBxEN7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C2CAiGXwx3ltSfH/383zWhPCh5heLBSzdqe3lWGgXKIMraJMv8vfVeWrnILTePqoWZcE8ZXiWoL9q0VkIvGE7eOPn4lYkCP+PSOCtocvw0QK5+zAS+9a6XsCtpOmPUiTmc7B7YJeX3yZXM7GvqCIHKJGWexlJeeyTxUIP1znsA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNlkQ7jK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748423161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBMm14X79Tyxe7aSibZ7sOba5LHyb2S9vcqfSqU/yFM=;
	b=GNlkQ7jKHRkFB+j94/SqudMLTs+ZGRb5oxcv/MkqSQfnmD/RYHzJJGx1eJ0Riv2wcLr0no
	GJKbP6i3e0o+sgXivNP3I7qrxTwY/Kwut1q2I7z1mQfpjipWbz5TE7DrzwN5Zw5Zpx+jWA
	EZZVFr5zwH3VDPaEoViITETZ+yp2Xgc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-xLSEQD8dOsyjhEWar6iuKA-1; Wed, 28 May 2025 05:06:00 -0400
X-MC-Unique: xLSEQD8dOsyjhEWar6iuKA-1
X-Mimecast-MFC-AGG-ID: xLSEQD8dOsyjhEWar6iuKA_1748423159
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-442cd12d151so36665055e9.1
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 02:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748423159; x=1749027959;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RBMm14X79Tyxe7aSibZ7sOba5LHyb2S9vcqfSqU/yFM=;
        b=aa7anrSShHnEg4I+lxaz/TsD+wQrkGU9DNZiw9evs1VbeLel7qgku7geQaBkXdaLjd
         h3paQ4sqU0L0Dze1iKaUroZby8yWHcQtMhtL20sHmj3BSgJaT4j8TMgccY1KGzxCeuYZ
         c4Wa9yapGQgPq0aSbtud/Wd1c5anreSUgA0a+ZnnLIhxq/NQlZP6z3yCETpMbSmCby81
         Td5qxKMdQ1S1oH8774bWo8JCJlxF0kPHEpx/UhUiMdroyP96OlMK/ZF3o7iXd4whE7w2
         R8KU87lRE4inGHiVL6Wfgr5sugvWgYFJLJvcRkBDRSr87gQAXlXboJEyr8kmIauUTFNm
         6W5w==
X-Gm-Message-State: AOJu0Yyl12TxTUFax64uBlr9iy1B966YQ7sWIbUjlCwi19+V0y06yUjM
	YpiLrGXXFFmoxX0lCqfeQpKeqvm8jOzWGxO3nPCjI70+oZ+uxhcWsn1Dn7qZKc371WFICfNMOwJ
	jDdljdIUfg4MDLfvSqnXZQuhwPS+eAE65GDZ0tanE3FCoPmnTQcIi
X-Gm-Gg: ASbGncsshEyBpv7uSk0j3avtzC8T0MWDBDH6Ri5PDH5rCZCve453QCdJkeVLJ2+qYoj
	0okgQfWZYSsOtQDADFB1M38oHNI/UFEzeYH3e6T8z4Fxshe8ALHAXfCRPdne0/q0Txm31vb3c0O
	aeCn5KOlu97DFfqS5g60ds7U/hQ/9Uz0Llb/WzZY4FuRiqS7MC6jgC8hULe1KqKXOmI+ZzW3vOu
	NjLavhNzrA9rUicJGvAKamdNa1UtvV5LE9gZkww2R0Y79tfi7EeskNq3zSl8a3WPCYRFIfirzHf
	y7N+bde3IQ9WmdEZmg==
X-Received: by 2002:a05:600c:6297:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-44c91ad6b51mr167038365e9.4.1748423158631;
        Wed, 28 May 2025 02:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4rjnkqdwB9nfkcYCWHZkvx1reBNADwbBPr209wxwZqLgDd8rFhfFqTBNE7BtjdturtfSQfQ==
X-Received: by 2002:a05:600c:6297:b0:43c:fc04:6d35 with SMTP id 5b1f17b1804b1-44c91ad6b51mr167037895e9.4.1748423158089;
        Wed, 28 May 2025 02:05:58 -0700 (PDT)
Received: from [10.43.17.17] ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eac8ad3csm911162f8f.53.2025.05.28.02.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 02:05:57 -0700 (PDT)
Message-ID: <ffd8b763-1d5d-4959-b5dd-2e7bd7558c7c@redhat.com>
Date: Wed, 28 May 2025 11:05:56 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string
 operations
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>
References: <cover.1746598898.git.vmalik@redhat.com>
 <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
 <aBx8Zjux0bSgtV04@google.com>
 <CAADnVQ+pru+0cTbk-YXpAb4SdZeS+NL2TjLAXcrQya0RxBjFpg@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQ+pru+0cTbk-YXpAb4SdZeS+NL2TjLAXcrQya0RxBjFpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/9/25 18:39, Alexei Starovoitov wrote:
> On Thu, May 8, 2025 at 2:42 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
>>
>> On Wed, May 07, 2025 at 08:40:38AM +0200, Viktor Malik wrote:
>>> String operations are commonly used so this exposes the most common ones
>>> to BPF programs. For now, we limit ourselves to operations which do not
>>> copy memory around.
>>>
>>> Unfortunately, most in-kernel implementations assume that strings are
>>> %NUL-terminated, which is not necessarily true, and therefore we cannot
>>> use them directly in the BPF context. Instead, we open-code them using
>>> __get_kernel_nofault instead of plain dereference to make them safe and
>>> limit the strings length to XATTR_SIZE_MAX to make sure the functions
>>> terminate. When __get_kernel_nofault fails, functions return -EFAULT.
>>> Similarly, when the size bound is reached, the functions return -E2BIG.
>>
>> Curious, why was XATTR_SIZE_MAX chosen as the upper bounds here? Just
>> an arbitrary value that felt large enough?
>>
>>> At the moment, strings can be passed to the kfuncs in three forms:
>>> - string literals (i.e. pointers to read-only maps)
>>> - global variables (i.e. pointers to read-write maps)
>>> - stack-allocated buffers
>>>
>>> Note that currently, it is not possible to pass strings from the BPF
>>> program context (like function args) as the verifier doesn't treat them
>>> as neither PTR_TO_MEM nor PTR_TO_BTF_ID.
>>>
>>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>> ---
>>>  kernel/bpf/helpers.c | 440 +++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 440 insertions(+)
>>>
>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>> index e3a2662f4e33..8fb7c2ca7ac0 100644
>>> --- a/kernel/bpf/helpers.c
>>> +++ b/kernel/bpf/helpers.c
>>> @@ -23,6 +23,7 @@
>>>  #include <linux/btf_ids.h>
>>>  #include <linux/bpf_mem_alloc.h>
>>>  #include <linux/kasan.h>
>>> +#include <linux/uaccess.h>
>>>
>>>  #include "../../lib/kstrtox.h"
>>>
>>> @@ -3194,6 +3195,433 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
>>>       local_irq_restore(*flags__irq_flag);
>>>  }
>>>
>>> +/* Kfuncs for string operations.
>>> + *
>>> + * Since strings are not necessarily %NUL-terminated, we cannot directly call
>>> + * in-kernel implementations. Instead, we open-code the implementations using
>>> + * __get_kernel_nofault instead of plain dereference to make them safe.
>>> + */
>>
>> Returning an -EFAULT error code for supplied arguments which are
>> deemed to be invalid is just a very weird semantic IMO. As a BPF
>> program author, I totally wouldn't expect a BPF kfunc to return
>> -EINVAL if I had supplied it something that it couldn't quite possibly
>> handle to begin with. Look at the prior art, being pre-existing BPF
>> kfuncs, and you'll see how they handle invalidly supplied arguments. I
>> totally understand that attempting to dereference a NULL-pointer would
>> ultimately result in a fault being raised, so it may feel rather
>> natural to also report an -EFAULT error code upon doing some
>> NULL-pointer checks that hold true, but from an API usability POV it
>> just seems awkward and wrong.
> 
> I mostly agree with the above.
> 
> On the first look, all the checks like:
> +       if (!s || !accept)
> +               return ERR_PTR(-EFAULT);
> 
> looks like a premature optimization, since
> __get_kernel_nofault() will handle it just fine.
> 
> But there is a different reason to do it and the error code
> should probably be different.
> 
> Consider that copy_from_kernel_nofault() has the following check
> that is meaningful on several architectures including x86:
>         if (!copy_from_kernel_nofault_allowed(src, size))
>                 return -ERANGE;
> 
> It's there to avoid accidentally reading user addresses and
> NULL is one such user address.

Ah, that explains why I was getting pagefaults when passing NULL,
despite using `guard(pagefault)()`. Thanks for the context.

> 
> Doing it for every pointer inside the loop will hurt performance,
> but doing it once in the beginning maybe ok?
> If we want to optimize it we can introduce the helper:
> 
> static bool copy_maybe_allowed(const void *ptr)
> {
> #ifdef CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>   if ((unsigned long)ptr < TASK_SIZE)
>      return false;
> #else
>   if (!ptr)
>      return false;
> #endif
>   return true;
> }
> 
> and modify above as:
>   if (!copy_maybe_allowed(s) || !copy_maybe_allowed(accept))
>     return ERR_PTR(-ERANGE);
> 
> bikeshed: shorter/better name for helper..

Is there any reason why `copy_from_kernel_nofault_allowed(ptr, 1)` will
not do here?

Thanks!
Viktor


