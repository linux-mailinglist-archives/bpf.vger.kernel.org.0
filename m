Return-Path: <bpf+bounces-57145-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED797AA6426
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9A53B4EC9
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 19:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9DB227E98;
	Thu,  1 May 2025 19:36:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3E2248AE
	for <bpf@vger.kernel.org>; Thu,  1 May 2025 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746128195; cv=none; b=uHnepwWhngbJfa+j5x/p8SCArFl6Io/zxsnOd4AFSLCHx5pBEcrZnJ3VhnVVWBOuhxOYkmplkfwY1PE7/IXIjtahQLA0DEFxgUAkjkwk80EP+Zm6rJagVFfyMjIse1R8PZ16Th0SY+1wmws3ofE1EXb8w1WQTHeKBoN5EOnytdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746128195; c=relaxed/simple;
	bh=+HxE+wy+w7PX/bMX1Dw8ytfyal4O47v8wvNwj/SIAvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lFldMQ0BNXgZ6rhtB3Kp5idnY1WVUF6T4h80gXSfXqDUPBI798MBsLiTi6rE1oShzIe1lfx2muECRyv11L1t7boLNxkJIIexGyogpEhDQl05X4fwb+PZc3UJ/uErdkQxnWnuv5rMQe7RnZMiROamcwh7w3ioz2P8gzMkm+ICkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZpPPg17pbz6L4wk;
	Fri,  2 May 2025 03:34:15 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 785E514038F;
	Fri,  2 May 2025 03:36:24 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 1 May 2025 22:36:23 +0300
Message-ID: <6850ac3f-af96-4cc6-9dd0-926dd3a022c9@huawei-partners.com>
Date: Thu, 1 May 2025 22:36:23 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>
CC: Yafang Shao <laoar.shao@gmail.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, David Hildenbrand
	<david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	<bpf@vger.kernel.org>, <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
 <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
 <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
 <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
 <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
 <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>
 <20250430174521.GC2020@cmpxchg.org>
 <84DE7C0C-DA49-4E4F-9F66-E07567665A53@nvidia.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <84DE7C0C-DA49-4E4F-9F66-E07567665A53@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100004.china.huawei.com (7.188.51.133) To
 mscpeml500003.china.huawei.com (7.188.49.51)


On 4/30/2025 8:53 PM, Zi Yan wrote:
> On 30 Apr 2025, at 13:45, Johannes Weiner wrote:
> 
>> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
>>>>>> If it isn't, can you state why?
>>>>>>
>>>>>> The main difference is that you are saying it's in a container that you
>>>>>> don't control.  Your plan is to violate the control the internal
>>>>>> applications have over THP because you know better.  I'm not sure how
>>>>>> people might feel about you messing with workloads,
>>>>>
>>>>> It’s not a mess. They have the option to deploy their services on
>>>>> dedicated servers, but they would need to pay more for that choice.
>>>>> This is a two-way decision.
>>>>
>>>> This implies you want a container-level way of controlling the setting
>>>> and not a system service-level?
>>>
>>> Right. We want to control the THP per container.
>>
>> This does strike me as a reasonable usecase.
>>
>> I think there is consensus that in the long-term we want this stuff to
>> just work and truly be transparent to userspace.
>>
>> In the short-to-medium term, however, there are still quite a few
>> caveats. thp=always can significantly increase the memory footprint of
>> sparse virtual regions. Huge allocations are not as cheap and reliable
>> as we would like them to be, which for real production systems means
>> having to make workload-specifcic choices and tradeoffs.
>>
>> There is ongoing work in these areas, but we do have a bit of a
>> chicken-and-egg problem: on the one hand, huge page adoption is slow
>> due to limitations in how they can be deployed. For example, we can't
>> do thp=always on a DC node that runs arbitary combinations of jobs
>> from a wide array of services. Some might benefit, some might hurt.
>>
>> Yet, it's much easier to improve the kernel based on exactly such
>> production experience and data from real-world usecases. We can't
>> improve the THP shrinker if we can't run THP.
>>
>> So I don't see it as overriding whoever wrote the software running
>> inside the container. They don't know, and they shouldn't have to care
>> about page sizes. It's about letting admins and kernel teams get
>> started on using and experimenting with this stuff, given the very
>> real constraints right now, so we can get the feedback necessary to
>> improve the situation.
> 
> Since you think it is reasonable to control THP at container-level,
> namely per-cgroup. Should we reconsider cgroup-based THP control[1]?
> (Asier cc'd)
> 
> In this patchset, Yafang uses BPF to adjust THP global configs based
> on VMA, which does not look a good approach to me. WDYT?
> 
> 
> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com/
> 
> --
> Best Regards,
> Yan, Zi

Hi,

I believe cgroup is a better approach for containers, since this 
approach can be easily integrated with the user space stack like 
containerd and kubernets, which use cgroup to control system resources.

However, I pointed out earlier, the approach I suggested has some 
flaws:
1. Potential polution of cgroup with a big number of knobs
2. Requires configuration by the admin

Ideally, as Matthew W. mentioned, there should be an automatic system.

Anyway, regarding containers, I believe cgroup is a good approach 
given that the admin or the container management system uses cgroups 
to set up the containers.

-- 
Asier Gutierrez
Huawei


