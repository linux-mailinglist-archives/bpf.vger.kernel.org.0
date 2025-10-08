Return-Path: <bpf+bounces-70592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA372BC4F7E
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 14:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383C1402E28
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 12:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9842F257422;
	Wed,  8 Oct 2025 12:49:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A943251795;
	Wed,  8 Oct 2025 12:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927793; cv=none; b=k6Om+gaz7z2+mjMRt5DtPxiBTR+1rXbXst/zslHkUZel/JX7sDJj3R19mg/jNmFcYEFtfJOQEZC0sQCLGa9TILlooPq8vGIKWDLXNzH1XOYJmLP0qot8ki7ji1MOhg95xWDPXmJx7hluwNl5TSEmA5jmRWm8hNJxxvwQJF0ZKrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927793; c=relaxed/simple;
	bh=kSLFQbIOHo+oNwHP7vkPlmwEIpSRzVv/LSXm7gjiU7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sr7Eyfl9RSrUYF+QjguaV2mOn+8gF1KKUBZgajjQ4XO5cIJH+H9ty4LvUMnlg5Zhy0EPrqo9FEjV8Pa7W4qOSB33c9NoMTTx/8NhkOymADoNTRDQ+cpE51Wzx6K4tXPEY3QgRTdv/f6rvH+rL2kZM9/3ZGW+BXLZ0D8RGd/dbIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4chXnB34qkz6M4Zx;
	Wed,  8 Oct 2025 20:46:22 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F15E14033F;
	Wed,  8 Oct 2025 20:49:41 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 8 Oct 2025 15:49:40 +0300
Message-ID: <1940d681-94a6-48fb-b889-cd8f0b91b330@huawei-partners.com>
Date: Wed, 8 Oct 2025 15:49:40 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
To: Yafang Shao <laoar.shao@gmail.com>, Zi Yan <ziy@nvidia.com>
CC: David Hildenbrand <david@redhat.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew
 Morton <akpm@linux-foundation.org>, <baolin.wang@linux.alibaba.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Liam Howlett <Liam.Howlett@oracle.com>,
	<npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
	<usamaarif642@gmail.com>, Matthew Wilcox <willy@infradead.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii
 Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, David
 Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>,
	<21cnbao@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo
	<tj@kernel.org>, <lance.yang@linux.dev>, Randy Dunlap
	<rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>, linux-mm
	<linux-mm@kvack.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
 <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com>
 <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
 <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com>
 <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
 <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com>
 <CALOAHbCS0WvUSsK_rbtU8LTLuz_eynVEa1ULyYmyRcMW_hfZWg@mail.gmail.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <CALOAHbCS0WvUSsK_rbtU8LTLuz_eynVEa1ULyYmyRcMW_hfZWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)

Hi,

On 10/8/2025 3:06 PM, Yafang Shao wrote:
> On Wed, Oct 8, 2025 at 7:27 PM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 8 Oct 2025, at 5:04, Yafang Shao wrote:
>>
>>> On Wed, Oct 8, 2025 at 4:28 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 08.10.25 10:18, Yafang Shao wrote:
>>>>> On Wed, Oct 8, 2025 at 4:08 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
>>>>>>> On Mon, Sep 29, 2025 at 10:59 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>>>>>
>>>>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
>>>>>>>> +                                     enum tva_type type,
>>>>>>>> +                                     unsigned long orders)
>>>>>>>> +{
>>>>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
>>>>>>>> +       int bpf_order;
>>>>>>>> +
>>>>>>>> +       /* No BPF program is attached */
>>>>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>>>>>>>> +                     &transparent_hugepage_flags))
>>>>>>>> +               return orders;
>>>>>>>> +
>>>>>>>> +       rcu_read_lock();
>>>>>>>> +       bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
>>>>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
>>>>>>>> +               goto out;
>>>>>>>> +
>>>>>>>> +       bpf_order = bpf_hook_thp_get_order(vma, type, orders);
>>>>>>>> +       orders &= BIT(bpf_order);
>>>>>>>> +
>>>>>>>> +out:
>>>>>>>> +       rcu_read_unlock();
>>>>>>>> +       return orders;
>>>>>>>> +}
>>>>>>>
>>>>>>> I thought I explained it earlier.
>>>>>>> Nack to a single global prog approach.
>>>>>>
>>>>>> I agree. We should have the option to either specify a policy globally,
>>>>>> or more refined for cgroups/processes.
>>>>>>
>>>>>> It's an interesting question if a program would ever want to ship its
>>>>>> own policy: I can see use cases for that.
>>>>>>
>>>>>> So I agree that we should make it more flexible right from the start.
>>>>>
>>>>> To achieve per-process granularity, the struct-ops must be embedded
>>>>> within the mm_struct as follows:
>>>>>
>>>>> +#ifdef CONFIG_BPF_MM
>>>>> +struct bpf_mm_ops {
>>>>> +#ifdef CONFIG_BPF_THP
>>>>> +       struct bpf_thp_ops bpf_thp;
>>>>> +#endif
>>>>> +};
>>>>> +#endif
>>>>> +
>>>>>   /*
>>>>>    * Opaque type representing current mm_struct flag state. Must be accessed via
>>>>>    * mm_flags_xxx() helper functions.
>>>>> @@ -1268,6 +1281,10 @@ struct mm_struct {
>>>>>   #ifdef CONFIG_MM_ID
>>>>>                  mm_id_t mm_id;
>>>>>   #endif /* CONFIG_MM_ID */
>>>>> +
>>>>> +#ifdef CONFIG_BPF_MM
>>>>> +               struct bpf_mm_ops bpf_mm;
>>>>> +#endif
>>>>>          } __randomize_layout;
>>>>>
>>>>> We should be aware that this will involve extensive changes in mm/.
>>>>
>>>> That's what we do on linux-mm :)
>>>>
>>>> It would be great to use Alexei's feedback/experience to come up with
>>>> something that is flexible for various use cases.
>>>
>>> I'm still not entirely convinced that allowing individual processes or
>>> cgroups to run independent progs is a valid use case. However, since
>>> we have a consensus that this is the right direction, I will proceed
>>> with this approach.
>>>
>>>>
>>>> So I think this is likely the right direction.
>>>>
>>>> It would be great to evaluate which scenarios we could unlock with this
>>>> (global vs. per-process vs. per-cgroup) approach, and how
>>>> extensive/involved the changes will be.
>>>
>>> 1. Global Approach
>>>    - Pros:
>>>      Simple;
>>>      Can manage different THP policies for different cgroups or processes.
>>>   - Cons:
>>>      Does not allow individual processes to run their own BPF programs.
>>>
>>> 2. Per-Process Approach
>>>     - Pros:
>>>       Enables each process to run its own BPF program.
>>>     - Cons:
>>>       Introduces significant complexity, as it requires handling the
>>> BPF program's lifecycle (creation, destruction, inheritance) within
>>> every mm_struct.
>>>
>>> 3. Per-Cgroup Approach
>>>     - Pros:
>>>        Allows individual cgroups to run their own BPF programs.
>>>        Less complex than the per-process model, as it can leverage the
>>> existing cgroup operations structure.
>>>     - Cons:
>>>        Creates a dependency on the cgroup subsystem.
>>>        might not be easy to control at the per-process level.
>>
>> Another issue is that how and who to deal with hierarchical cgroup, where one
>> cgroup is a parent of another. Should bpf program to do that or mm code
>> to do that?
> 
> The cgroup subsystem handles this propagation automatically. When a
> BPF program is attached to a cgroup via cgroup_bpf_attach(), it's
> automatically inherited by all descendant cgroups.
> 
> Note: struct-ops programs aren't supported by cgroup_bpf_attach(),
> requiring us to build new attachment mechanisms for cgroup-based
> struct-ops.
> 
>> I remember hierarchical cgroup is the main reason THP control
>> at cgroup level is rejected. If we do per-cgroup bpf control, wouldn't we
>> get the same rejection from cgroup folks?
> 
> Right, it was rejected by the cgroup maintainers [0]
> 
> [0]. https://lore.kernel.org/linux-mm/20241030150851.GB706616@cmpxchg.org/
> 

Yes, the patch was rejected because:

1. It breaks the cgroup hierarchy when 2 siblings have different THP policies
2. Cgroup was designed for resource management not for grouping processes and 
   tune those processes
3. We set a precedent for other people adding new flags to cgroup and 
   potentially polluting cgroups. We may end up with cgroups having tens of 
   different flags, making sysadmin's job more complex

In the MM call I proposed a new mechanism based on limits, something like 
hugetlbfs.

The main issue, still, is that the sysadmins need to set those up, making 
their life more complex.

I remember few participants mentioned the idea of the kernel setting huge page 
consumption automatically using some sort of heuristics. To be honest, I 
haven't have the time to sit and think about it. I would be glad to cooperate
and come up with a feasible solution.

-- 
Asier Gutierrez
Huawei


