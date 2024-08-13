Return-Path: <bpf+bounces-37125-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B4A951056
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 01:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 661061C225BB
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 23:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619771AB53B;
	Tue, 13 Aug 2024 23:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFGoZaXg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61023370
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 23:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723590819; cv=none; b=Q8uYqt6jYtuhoGXeEyurvexvm/TJ389LKB3VxvJmdwyuku59fPcBOSImavg37sNu6WUhmLRarRwpAmUJPf7zF2FP5TZqIc93rkzvPklgPhOpE/kQR7xKm9EnGteCbu+RlxYGNIwbUjMNksQ4H5JZKsnTbkcf4JaNjZ6mLeMEH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723590819; c=relaxed/simple;
	bh=CEO5yFrOVxB5oXBkg9t3U45KroWJKu2ttZnGkmoqV+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTn+KDrNWUextltG/wzTwDTcGcqJ91uIVRyyfJztCxlnLEHOn8AKts/si84UUl8jV1rTj2NwN++a7u5Em84qIqtwXos+ZNFcLP5f82nNu+hpKMgY2J/NdjxbEjW3LKiEveUARqVIgqIPAoRgIFo5n8lakjfwLgu6HcRdEbQWxWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFGoZaXg; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e0bf9c7f4f2so5555578276.0
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 16:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723590817; x=1724195617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aGU6I2CAwU5IQEw4Rj/RZydQWii8F1T8qVbeq+7OFM=;
        b=aFGoZaXgA9tKGRFUfHTBY5LfV0xDkEol3IiiZ6WJQV8CJqV3+usWZ3mUcg33kCt7uH
         twIz9PGuVCDNmg+Kbp70rO89LOGr3fcM4QoNZsKNyToslZn6C1XMNfhkCu4r/9TolKNn
         lU7350Ng2/DQnY96ZLniwzpohxnL4/zGaR6fFQWRWp5zqmt+60ptRLlVx57Vzj2eY2KP
         345nJXlbes8BMsqh2IvaNBLq8j0YteYtz+21PV3lEPNfzEnsQ0MEfn4N/7VPGji81ib9
         U2Avzy5UIFi+wNXs26n2B5h+KGfUGUGCrsG/Ib76thMB/mkBGqCJJRE3W48/RWKRQNkx
         nEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723590817; x=1724195617;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aGU6I2CAwU5IQEw4Rj/RZydQWii8F1T8qVbeq+7OFM=;
        b=OJFoYiPAL2U+TE8w3iovKAIdV2tBsHvIBv7oE8/TNnvfBCcdw/uQ0aYhJrchE+/XD/
         evHcgl5ZWbnVsGQd0POW0fpP3U9ys8dhJKiqQmIyaS9oX+bTJBFJOmd+nvMF6ufl8TCF
         XSD50DkP5iw4ILOPgJevvXM3+WG2gB4BhiPgJ7XvndBurnD8E1WqslF2rGtJ1Wwl/uW+
         cgjlHorHyM25NBluAV/Q1RDtAiVUxHqnfsZ3MT1DkfD9i/Da9+pgukebPXYCDAQkdLDo
         Tk/Gvv3F4gumdN+eTk7+DDnQ2QAj3vd5PKji0FKF18b54u/s2HFNmJ+0EIj/tgmgeEvR
         LQVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgx+IBddyHzrMYLD7bSl99/IMx9TlrhTsuOHeXzMr4X57Deyc2f9e5SCaPADOEvn/AnIo8qlaA9rYq1cTjO2rhGBWK
X-Gm-Message-State: AOJu0YwUQhzeIj1uvBDe1qOpAmIZtZKy5OJrdka8NGmcHpYrsctiWoMc
	iAif/oGE+SI9ob/YrBybhmzNQXUzP7ckjBDBqTsbPBDeCpaaFYKO
X-Google-Smtp-Source: AGHT+IEkrfFDNWR8tPgwQJuc9VrRbW3/hEIEIVBnAIVMe4EL5VTXcQojNx3oce+Sp90JNVVhMw12dw==
X-Received: by 2002:a05:6902:208a:b0:e0e:9196:7823 with SMTP id 3f1490d57ef6-e1155ae38c1mr1178747276.30.1723590817123;
        Tue, 13 Aug 2024 16:13:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:6cf8:1240:d241:4a8f:4184:7fb2? ([2600:1700:6cf8:1240:d241:4a8f:4184:7fb2])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0ec8be5d2dsm1731584276.16.2024.08.13.16.13.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Aug 2024 16:13:36 -0700 (PDT)
Message-ID: <3107f476-b844-4dfa-bcf9-c89baa95cb6f@gmail.com>
Date: Tue, 13 Aug 2024 16:13:35 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 2/5] bpf: Handle BPF_KPTR_USER in verifier.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Kernel Team <kernel-team@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240807235755.1435806-1-thinker.li@gmail.com>
 <20240807235755.1435806-3-thinker.li@gmail.com>
 <CAADnVQJdZgJi7=jo+Ur+hL1WtW3x06Zptupk+QOp-mMzSefzYw@mail.gmail.com>
 <00ec1572-9f74-4a01-b30a-4eb03489284e@gmail.com>
 <CAADnVQLLpdRMVJsaVMrUBTyzXBbg+1uxZTs-12n2BXQuSVLK2g@mail.gmail.com>
Content-Language: en-US
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <CAADnVQLLpdRMVJsaVMrUBTyzXBbg+1uxZTs-12n2BXQuSVLK2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/13/24 12:35, Alexei Starovoitov wrote:
> On Tue, Aug 13, 2024 at 9:52 AM Kui-Feng Lee <sinquersw@gmail.com> wrote:
>>
>>
>>
>> On 8/12/24 09:48, Alexei Starovoitov wrote:
>>> On Wed, Aug 7, 2024 at 4:58 PM Kui-Feng Lee <thinker.li@gmail.com> wrote:
>>>>
>>>> Give PTR_MAYBE_NULL | PTR_UNTRUSTED | MEM_ALLOC | NON_OWN_REF to kptr_user
>>>> to the memory pointed by it readable and writable.
>>>>
>>>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>>>> ---
>>>>    kernel/bpf/verifier.c | 11 +++++++++++
>>>>    1 file changed, 11 insertions(+)
>>>>
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index df3be12096cf..84647e599595 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -5340,6 +5340,10 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>>>>           int perm_flags;
>>>>           const char *reg_name = "";
>>>>
>>>> +       if (kptr_field->type == BPF_KPTR_USER)
>>>> +               /* BPF programs should not change any user kptr */
>>>> +               return -EACCES;
>>>> +
>>>>           if (btf_is_kernel(reg->btf)) {
>>>>                   perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
>>>>
>>>> @@ -5483,6 +5487,12 @@ static u32 btf_ld_kptr_type(struct bpf_verifier_env *env, struct btf_field *kptr
>>>>                           ret |= NON_OWN_REF;
>>>>           } else {
>>>>                   ret |= PTR_UNTRUSTED;
>>>> +               if (kptr_field->type == BPF_KPTR_USER)
>>>> +                       /* In oder to access directly from bpf
>>>> +                        * programs. NON_OWN_REF make the memory
>>>> +                        * writable. Check check_ptr_to_btf_access().
>>>> +                        */
>>>> +                       ret |= MEM_ALLOC | NON_OWN_REF;
>>>
>>> UNTRUSTED | MEM_ALLOC | NON_OWN_REF ?!
>>>
>>> That doesn't fit into any of the existing verifier schemes.
>>> I cannot make sense of this part.
>>>
>>> UNTRUSTED | MEM_ALLOC is read only through exceptions logic.
>>> The uptr has to be read/write through normal load/store.
>>
>> I will remove UNTRUSTED and leave MEM_ALLOC and NON_OWN_REF.
>> Does it make sense to you?
> 
> I don't think it fits either.
> MEM_ALLOC | NON_OWN_REF is specific to bpf_rbtree/linklist nodes.
> There are various checks and logic like:
> 1.
>        if (!(type_is_ptr_alloc_obj(reg->type) ||
> type_is_non_owning_ref(reg->type)) &&
>              WARN_ON_ONCE(reg->off))
>            return;
> 2.
> invalidate_non_owning_refs() during unlock
> 
> that shouldn't apply in this case.
> 
> PTR_TO_MEM with specific mem_size fits better.
> Since it's user/kernel shared memory PTR_TO_BTF_ID logic with field walking
> won't work anyway, so opaque array of bytes is better. Which is PTR_TO_MEM.

Make sense!



