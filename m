Return-Path: <bpf+bounces-65990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B13B2BE8D
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 12:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C4097A8AA2
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651931AF39;
	Tue, 19 Aug 2025 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wyp2QEof"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166BF3451D3
	for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598273; cv=none; b=AiUZPU4J96wd7V6DwzTd9QzW6gN2hxaUfpAohYZ2pKxGDOaiH9+oskkpvRrU8ibaGRxszoDrvIoBnTUTDUJequdBlG22kAnrIMdUjaw46a6sJ0o0o8q0oymYvk+2xSrVLFZiYNF6CXhG3eMgFSIIGRn1yoUA+jt6uxcD+fxGm5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598273; c=relaxed/simple;
	bh=ZBiIKIpMIVX5Ea8etHG1POuHHBoduypeYIrPrYR05UY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TegvANfonW16JODYRMQOrGBwEraXvNrYvN6FTuwshIvWDiD+Es999dOFTeBrdne1O/SWZRNT7vx81YnhWV8F+t5AlVoa8UaudYpbqGhizol5eEWBznPnj5Ds4SoKvymt5qQRLJbhzMwFm6ZGsBJHcTqvRE81BVfho32LoZ/4whk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wyp2QEof; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so3471914f8f.1
        for <bpf@vger.kernel.org>; Tue, 19 Aug 2025 03:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755598269; x=1756203069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HmdM3IXlCoHz3y6cbIntEEXVkN2Z0YcF/Z1V9nwLjo=;
        b=Wyp2QEofdhgjhczyz7+CR0syG4BHC+ZaedoxxM+AwAGZPdkecfB2iedbNYX5rzW+Eg
         oMx+wNA9jwDRALEiTQfx3ET5VpoqoELUEh0nlLuRTq6DNYPWMlTtt4SXZbUXGZhBv8Ej
         0wKXXNPXYc6sxs4EdAviztvqYwTcTibYMqmT0ncV4BBhIy5ilwKZAg4Jj76gyPv98pQl
         PkwQtSYSHqGpZdUQ7zJpvHUBjEuDkZH+zjbYqJpRaAUJ2UmEKGmoInrn6nAa7iSY9KXN
         EKY4jKPWTBgOYvOAtWoNQAAJIyLlfGt6iJTkyHd1RwPhdmmSbU5xhmQmh4NJIzC3S/nj
         AUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755598269; x=1756203069;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HmdM3IXlCoHz3y6cbIntEEXVkN2Z0YcF/Z1V9nwLjo=;
        b=G7psC5n2zkn1m9PLnqfL9+yWn9u0514SQN28A7aoognwdjbMXc/zgRgRhHxT9VHMD/
         4Q06sonZGgh1e+zI+OiJJrzaCxnREzRHvEFcVVM6qGyRSsNql+haT+HNH3bCH310H+YE
         7vXFIEzz6v/HVFOaO9Ziopt5WzmhJEWm9AN7AdEF48uBu1zejCIUFJy4DbgSEPWM+iCg
         jmvPk0+XA1K52w6VKj4/NwJVVcJyhqJPUW6NjtUFthW9L1Fx2GlXU5pztqcsY198Y7hB
         DtFq44OMu4NG6FoTlC8B9DD6OdHFK6dLzjtz2wUVbBkkUIplM+011mJa0RDsM2VKfVXC
         5TtA==
X-Forwarded-Encrypted: i=1; AJvYcCUU81DXnKDhfFTXsgVP2XSi0z4QoxzesmT1gRttG1CQilDQyi/oWQaqx+ygIBSh3PFdAk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFAaGsJUYuFFGeOQKdocZ8kXWg7ZVvSpma7vIWJaMtVXYM+be
	ZC/IpSHSdJ5saWKwldu3GrTtxZGUDfhJiBocevA1sNHTSrmhvW08bUc7
X-Gm-Gg: ASbGncvPM0eKBx9LR3LpoeWXCcdO5HhJt6myRIHhi/JB4JTWd6Yxv/MaKAqdYj9Oo9H
	Y8B0q0W+QDCuC6dMoFgHBc17IFeS5UCHpF2427qFkYL5NE+82TUN88272UbiJ9m+goiJA+k9mYT
	uebEtiP2Tc3rnlyTO1l7GMUyGifSPf+8Nmu7mFYwbMdo2TWesq3mt+iFlxPiraRzh7/z/teqsDM
	IJb/hP4PeciRnCnLjsWN8Tru38m8SXhdhivQqIwsSbYb5tgVxBm3QfKjJ6rtw6ZHFESQ/mVMIB2
	ilR6awoNP5zQXgjTY8QTu3OTHAAIMhXr1KYfAjldY86udVlVPlX7a7PsPO5yrQvd2kKI6tomg4n
	jBTxTtoPHciqf479h2nPM5L+KkHkMCGOcK2hBuDBe7cJyZ92hyzyp44w6e1vGa9J80l4EpcFLO9
	gMKlEj/g==
X-Google-Smtp-Source: AGHT+IFXF3f1sapMa8ONCpGVfGr9sEWq4cBWD19yqnxWJGavX43hKO03sMmwP8WGlfFa4I/vhMstsg==
X-Received: by 2002:a05:6000:40c9:b0:3a3:7ba5:93a5 with SMTP id ffacd0b85a97d-3c0eae581e1mr1350735f8f.26.1755598268935;
        Tue, 19 Aug 2025 03:11:08 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:1449:d619:96c0:8e08? ([2620:10d:c092:500::4:ba2b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c57aa0sm3091124f8f.66.2025.08.19.03.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 03:11:08 -0700 (PDT)
Message-ID: <c855bb8b-4395-4235-8786-3a271252c455@gmail.com>
Date: Tue, 19 Aug 2025 11:11:05 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 mm-new 1/5] mm: thp: add support for BPF based THP
 order selection
Content-Language: en-GB
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, hannes@cmpxchg.org, gutierrez.asier@huawei-partners.com,
 willy@infradead.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, ameryhung@gmail.com, rientjes@google.com,
 bpf@vger.kernel.org, linux-mm@kvack.org
References: <20250818055510.968-1-laoar.shao@gmail.com>
 <20250818055510.968-2-laoar.shao@gmail.com>
 <0caf3e46-2b80-4e7c-91aa-9d7ed5fe4db9@gmail.com>
 <CALOAHbAzQmqxcJ7HU+gsdX4+iEj0U=E5mS8nXF8OYW9QxuXSLA@mail.gmail.com>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <CALOAHbAzQmqxcJ7HU+gsdX4+iEj0U=E5mS8nXF8OYW9QxuXSLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/08/2025 04:08, Yafang Shao wrote:
>> Hi Yafang,
>>
>> From the coverletter, one of the potential usecases you are trying to solve for is if global policy
>> is "never", but the workload want THPs (either always or on madvise basis). But over here,
>> MMF_VM_HUGEPAGE will never be set so in that case mm_flags_test(MMF_VM_HUGEPAGE, oldmm) will
>> always evaluate to false and the get_sugested_order call doesnt matter?
> 
> See the replyment in another thread.
> 
>>
>>
>>
>>>               __khugepaged_enter(mm);
>>>  }
>>>
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index 4108bcd96784..d10089e3f181 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -924,6 +924,18 @@ config NO_PAGE_MAPCOUNT
>>>
>>>         EXPERIMENTAL because the impact of some changes is still unclear.
>>>
>>> +config EXPERIMENTAL_BPF_ORDER_SELECTION
>>> +     bool "BPF-based THP order selection (EXPERIMENTAL)"
>>> +     depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
>>> +
>>> +     help
>>> +       Enable dynamic THP order selection using BPF programs. This
>>> +       experimental feature allows custom BPF logic to determine optimal
>>> +       transparent hugepage allocation sizes at runtime.
>>> +
>>> +       Warning: This feature is unstable and may change in future kernel
>>> +       versions.
>>> +
>>
>>
>> I know there was a discussion on this earlier, but my opinion is that putting all of this
>> as experiment with warnings is not great. No one will be able to deploy this in production
>> if its going to be removed, and I believe thats where the real usage is.
> 
> See the replyment in another thread.
> 
>>
>>>  endif # TRANSPARENT_HUGEPAGE
>>>
>>>  # simple helper to make the code a bit easier to read
>>> diff --git a/mm/Makefile b/mm/Makefile
>>> index ef54aa615d9d..cb55d1509be1 100644
>>> --- a/mm/Makefile
>>> +++ b/mm/Makefile
>>> @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
>>>  obj-$(CONFIG_NUMA) += memory-tiers.o
>>>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>>>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>>> +obj-$(CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION) += bpf_thp.o
>>>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>>>  obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
>>>  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
>>> diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
>>> new file mode 100644
>>> index 000000000000..2b03539452d1
>>> --- /dev/null
>>> +++ b/mm/bpf_thp.c
>>> @@ -0,0 +1,186 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +#include <linux/bpf.h>
>>> +#include <linux/btf.h>
>>> +#include <linux/huge_mm.h>
>>> +#include <linux/khugepaged.h>
>>> +
>>> +struct bpf_thp_ops {
>>> +     /**
>>> +      * @get_suggested_order: Get the suggested THP orders for allocation
>>> +      * @mm: mm_struct associated with the THP allocation
>>> +      * @vma__nullable: vm_area_struct associated with the THP allocation (may be NULL)
>>> +      *                 When NULL, the decision should be based on @mm (i.e., when
>>> +      *                 triggered from an mm-scope hook rather than a VMA-specific
>>> +      *                 context).
>>> +      *                 Must belong to @mm (guaranteed by the caller).
>>> +      * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)
>>> +      * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
>>> +      * @orders: Bitmask of requested THP orders for this allocation
>>> +      *          - PMD-mapped allocation if PMD_ORDER is set
>>> +      *          - mTHP allocation otherwise
>>> +      *
>>> +      * Rerurn: Bitmask of suggested THP orders for allocation. The highest
>>> +      *         suggested order will not exceed the highest requested order
>>> +      *         in @orders.
>>
>> If we want to make this generic enough so that it doesnt change, should we allow suggested order to
>> exceed highest requested order?
> 
> The maximum requested order is determined by the callsite. For example:
> - PMD-mapped THP uses PMD_ORDER
> - mTHP uses (PMD_ORDER - 1)
> 
> We must respect this upper bound to avoid undefined behavior.

Ack, makes sense.
> 
>>
>>> +      */
>>> +     int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>>> +                                u64 vma_flags, enum tva_type tva_flags, int orders) __rcu;
>>> +};
>>> +
>>> +static struct bpf_thp_ops bpf_thp;
>>> +static DEFINE_SPINLOCK(thp_ops_lock);
>>> +
>>> +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>>> +                     u64 vma_flags, enum tva_type tva_flags, int orders)
>>> +{
>>> +     int (*bpf_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>>> +                                u64 vma_flags, enum tva_type tva_flags, int orders);
>>> +     int suggested_orders = orders;
>>> +
>>> +     /* No BPF program is attached */
>>> +     if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>>> +                   &transparent_hugepage_flags))
>>> +             return suggested_orders;
>>> +
>>> +     rcu_read_lock();
>>> +     bpf_suggested_order = rcu_dereference(bpf_thp.get_suggested_order);
>>> +     if (!bpf_suggested_order)
>>> +             goto out;
>>
>>
>> My rcu API knowledge is not the best, but maybe we could do:
>>
>> if (!rcu_access_pointer(bpf_thp.get_suggested_order))
>>         return suggested_orders;
>>
> 
> There might be a race here.  The current rcu_access_pointer() check
> occurs outside the RCU read-side critical section, meaning the
> protected pointer could be freed between the check and use.
> Therefore, we must perform the NULL check within the RCU read critical
> section when dereferencing the pointer:
> 

Ack, makes sense.


