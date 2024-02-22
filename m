Return-Path: <bpf+bounces-22480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EF85EE79
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 02:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76446B22D9E
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 01:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65359111AC;
	Thu, 22 Feb 2024 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ib1RHhFj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5948F45
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708564322; cv=none; b=Y9gtQ/pIbuqExpN/p0Knzfa1AO3/YjhaEQL8HoFQytHqIOIVyx6v1WcO51Ac0lAiCwUTyQcklBZGWucjQnwtPVoo24Rhxmhol2rNsjvIxjQFB2nE17uuSH7WHM3tXpsvAceNbywwh67l+B9d6lX+i9q+4hE7b87tENsjlOCvufw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708564322; c=relaxed/simple;
	bh=dig9585Q08BWaERKU/d+5ComP4Q9BgvIB0HKFBIv0tg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=sEeeHGNa5GVjpNvzhVMEZEjpFzCcOg012Jqs4rQZx0BwgmPfZwSL0ImYBm9oys6lZ5FS8MqOI53boCzmI+dDdRw6eC4x+pvqWZZnZ1djFf+yJgUX6jYhW9D/eqpcROVKGjXGHJgKPCu5u4Uhj3fWac54W7kx9b+irY9dOGwWGxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ib1RHhFj; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso359736276.0
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 17:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708564319; x=1709169119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNsYuef5BgHinC9jVRaLW1wLGgTyYv6V2x1wyOnYDZI=;
        b=ib1RHhFjRWZM5sm+SxD9dC9ZvpnrxodmTNtixMhNMNKADqi90nKaLCkj/ioMb7kZZX
         J6RLwqPbTG9SBJ76RSO+izZh9YNewVdFExju15Ok0JJGjGsfNgxIcZdkvgGb48aBsc88
         3cuuEqfp3+4Wz9v7oYuQNjksLLqrFl10RhAr/HUcQ7XVizdDnb7iu8w5uaCXrKISGjIA
         bpeiK+w4ZTzDR8jBsO4MuKnZ2GG0tAMn3QjS6TFPHed8MtK0z7nTcEbRgpZcorL0IFB7
         nZPsneoBoN1PHBSs2eHVm5AybIzl6luwqCiCUKsYNJsPflyCNy/OQLvDjozjWVkq3XRx
         DhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708564319; x=1709169119;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNsYuef5BgHinC9jVRaLW1wLGgTyYv6V2x1wyOnYDZI=;
        b=cwRfmABKXwXnMTzlsc6ahleV+gpUJhjT2xjVLe5ndGXbStd0lUmKd6SPdkDeQRI1Rx
         A1CQPQZGWz9DP29L/TMipjB6a5xnx+cttFroE+jANM+IhYcAW+5Jm0B+E+rtjDBp1iCm
         EPnZ9qLNOPFJXkdv8arE4JFf00Sm6+/564hGQye1xzEgG2KlROmkb/9UHOtMU13uGpqJ
         EJ4kjERfeofB/9BgZgUhidWybRj3VpyV+1LZBGVlNl/zLWNj7Dv/G6vktFOL0WCQmRYz
         9TdvNvlnRg1/Wo/zKiHvgYIoRyXldP2SA6gk9TvSfwKMnj3a/pbsfv55pvouLYaKBTDb
         l9oA==
X-Forwarded-Encrypted: i=1; AJvYcCUq5PZpXpJlLGcSuK/xJbn+qHzYphl9cYiRKP9fTdToZK/xrGqgCB7JhKcHyY0g1xnI+qWF6uQLt46giagQrCQD60yN
X-Gm-Message-State: AOJu0Yx3l2W6RxVajxuP4535m8RxJr5xVzLACHzaur65F0kgvswUckYf
	X6r7HskuwkPqcXuYqdo2bPDEZf1v7+8Kj5x9G5uF/qBf5Txup12o
X-Google-Smtp-Source: AGHT+IHM0x4haC1WolnhdDhTo1twGXELSFKOWKyQGwShlj+9/KcWVHegTwGNKqY0DHF2xWAsofIDjw==
X-Received: by 2002:a25:d507:0:b0:dc7:494e:ff33 with SMTP id r7-20020a25d507000000b00dc7494eff33mr461714ybe.7.1708564319275;
        Wed, 21 Feb 2024 17:11:59 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:bc3b:b762:a625:955f? ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id h63-20020a25d042000000b00dc74ac54f5fsm2571731ybg.63.2024.02.21.17.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 17:11:58 -0800 (PST)
Message-ID: <d45c29e9-d772-4f4d-a50e-6e1bcdc3d27b@gmail.com>
Date: Wed, 21 Feb 2024 17:11:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 2/3] bpf: Check cfi_stubs before registering a
 struct_ops type.
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, thinker.li@gmail.com
Cc: kuifeng@meta.com, bpf@vger.kernel.org, ast@kernel.org, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
References: <20240221075213.2071454-1-thinker.li@gmail.com>
 <20240221075213.2071454-3-thinker.li@gmail.com>
 <8e6e79d6-e003-446b-bc36-b6a4500f802b@linux.dev>
 <286d36e1-1d1e-49d3-93d6-d29b402e6009@gmail.com>
In-Reply-To: <286d36e1-1d1e-49d3-93d6-d29b402e6009@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/21/24 15:13, Kui-Feng Lee wrote:
> 
> 
> On 2/21/24 10:25, Martin KaFai Lau wrote:
>> On 2/20/24 11:52 PM, thinker.li@gmail.com wrote:
>>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>>
>>> Recently, cfi_stubs were introduced. However, existing struct_ops types
>>> that are not in the upstream may not be aware of this, resulting in 
>>> kernel
>>> crashes. By rejecting struct_ops types that do not provide cfi_stubs 
>>> during
>>> registration, these crashes can be avoided.
>>>
>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>> ---
>>>   kernel/bpf/bpf_struct_ops.c | 17 +++++++++++++++++
>>>   1 file changed, 17 insertions(+)
>>>
>>> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
>>> index 0d7be97a2411..c1c502caae08 100644
>>> --- a/kernel/bpf/bpf_struct_ops.c
>>> +++ b/kernel/bpf/bpf_struct_ops.c
>>> @@ -302,6 +302,11 @@ int bpf_struct_ops_desc_init(struct 
>>> bpf_struct_ops_desc *st_ops_desc,
>>>       }
>>>       sprintf(value_name, "%s%s", VALUE_PREFIX, st_ops->name);
>>> +    if (!st_ops->cfi_stubs) {
>>> +        pr_warn("struct %s has no cfi_stubs\n", st_ops->name);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>>       type_id = btf_find_by_name_kind(btf, st_ops->name,
>>>                       BTF_KIND_STRUCT);
>>>       if (type_id < 0) {
>>> @@ -339,6 +344,7 @@ int bpf_struct_ops_desc_init(struct 
>>> bpf_struct_ops_desc *st_ops_desc,
>>>       for_each_member(i, t, member) {
>>>           const struct btf_type *func_proto;
>>> +        u32 moff;
>>>           mname = btf_name_by_offset(btf, member->name_off);
>>>           if (!*mname) {
>>> @@ -361,6 +367,17 @@ int bpf_struct_ops_desc_init(struct 
>>> bpf_struct_ops_desc *st_ops_desc,
>>>           if (!func_proto)
>>>               continue;
>>> +        moff = __btf_member_bit_offset(t, member) / 8;
>>> +        err = st_ops->check_member ?
>>> +            st_ops->check_member(t, member, NULL) : 0;
>>
>> I don't think it is necessary to make check_member more complicated by 
>> taking
>> NULL prog. The struct_ops implementer then needs to handle this extra 
>> NULL
>> prog case.
>>
>> Have you thought about Alexei's earlier suggestion in v3 to reuse the 
>> NULL
>> member in cfi_stubs to flag unsupported member and remove the 
>> unsupported_ops[]
>> from bpf_tcp_ca.c?
>>
>> If the verifier can consistently reject loading unsupported bpf prog, 
>> it will
>> not reach the bpf_struct_ops_map_update_elem and then hits the NULL 
>> member
>> in cfi_stubs during map_update_elem.
>>
> 
> Ok! I misunderstood previously. I will go this way.
> 

According to the off-line discussion, the changes for unsupported_ops[]
should be in a separate patchset. The check of (void
**)(st_ops->cfi_stubs + moff)) will be removed. Changes of check_member
should be removed as well.


