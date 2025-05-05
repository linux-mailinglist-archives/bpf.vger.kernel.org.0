Return-Path: <bpf+bounces-57330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F473AA8F9D
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 11:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4648E3A727E
	for <lists+bpf@lfdr.de>; Mon,  5 May 2025 09:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3E1F91F6;
	Mon,  5 May 2025 09:31:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D718F1F8733
	for <bpf@vger.kernel.org>; Mon,  5 May 2025 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437480; cv=none; b=rgNA4Co2K6u2jLINe906qNCx6VUhF1/xtjK+XXxJslMdkXc94Ips9ay83mjIdL+KL2UY+dCBKZQUj/9+RchtfLo8O4Ov7WteWXVkwfbcdTWN5+LXei9+/44Bv8sPWKV09EalFfwcpve35y8LBCSltPrhr11iId8SH5fLovWM8do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437480; c=relaxed/simple;
	bh=YLcDOyuMWiNIIqdLA7fQeBXagj2h/7h9kpxtHL/dGyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FWJguii3EHHhmyo9zt0/TKd62UrJS25yGtGDwTBdaHcyNuy9EX5XWyaV6tIJOLlo9U3LNHruiU4RVC3jMoFA+qFnyRlxCVitPmwee61JdFG8S9cb8AocZRXStZtrE+qI63ivTTy4DdE5Hu0iaRAazqFtm2F7kSKOhBti49dMoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZrbNq6RbVz6K9GL;
	Mon,  5 May 2025 17:11:07 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 4ECAA1402F0;
	Mon,  5 May 2025 17:11:15 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 5 May 2025 12:11:14 +0300
Message-ID: <88dd89b9-b2a2-47f7-bc53-1b85004e71da@huawei-partners.com>
Date: Mon, 5 May 2025 12:11:14 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>
CC: Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, <akpm@linux-foundation.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>, David
 Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
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
 <6850ac3f-af96-4cc6-9dd0-926dd3a022c9@huawei-partners.com>
 <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 5/2/2025 8:48 AM, Yafang Shao wrote:
> On Fri, May 2, 2025 at 3:36 AM Gutierrez Asier
> <gutierrez.asier@huawei-partners.com> wrote:
>>
>>
>> On 4/30/2025 8:53 PM, Zi Yan wrote:
>>> On 30 Apr 2025, at 13:45, Johannes Weiner wrote:
>>>
>>>> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
>>>>>>>> If it isn't, can you state why?
>>>>>>>>
>>>>>>>> The main difference is that you are saying it's in a container that you
>>>>>>>> don't control.  Your plan is to violate the control the internal
>>>>>>>> applications have over THP because you know better.  I'm not sure how
>>>>>>>> people might feel about you messing with workloads,
>>>>>>>
>>>>>>> It’s not a mess. They have the option to deploy their services on
>>>>>>> dedicated servers, but they would need to pay more for that choice.
>>>>>>> This is a two-way decision.
>>>>>>
>>>>>> This implies you want a container-level way of controlling the setting
>>>>>> and not a system service-level?
>>>>>
>>>>> Right. We want to control the THP per container.
>>>>
>>>> This does strike me as a reasonable usecase.
>>>>
>>>> I think there is consensus that in the long-term we want this stuff to
>>>> just work and truly be transparent to userspace.
>>>>
>>>> In the short-to-medium term, however, there are still quite a few
>>>> caveats. thp=always can significantly increase the memory footprint of
>>>> sparse virtual regions. Huge allocations are not as cheap and reliable
>>>> as we would like them to be, which for real production systems means
>>>> having to make workload-specifcic choices and tradeoffs.
>>>>
>>>> There is ongoing work in these areas, but we do have a bit of a
>>>> chicken-and-egg problem: on the one hand, huge page adoption is slow
>>>> due to limitations in how they can be deployed. For example, we can't
>>>> do thp=always on a DC node that runs arbitary combinations of jobs
>>>> from a wide array of services. Some might benefit, some might hurt.
>>>>
>>>> Yet, it's much easier to improve the kernel based on exactly such
>>>> production experience and data from real-world usecases. We can't
>>>> improve the THP shrinker if we can't run THP.
>>>>
>>>> So I don't see it as overriding whoever wrote the software running
>>>> inside the container. They don't know, and they shouldn't have to care
>>>> about page sizes. It's about letting admins and kernel teams get
>>>> started on using and experimenting with this stuff, given the very
>>>> real constraints right now, so we can get the feedback necessary to
>>>> improve the situation.
>>>
>>> Since you think it is reasonable to control THP at container-level,
>>> namely per-cgroup. Should we reconsider cgroup-based THP control[1]?
>>> (Asier cc'd)
>>>
>>> In this patchset, Yafang uses BPF to adjust THP global configs based
>>> on VMA, which does not look a good approach to me. WDYT?
>>>
>>>
>>> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com/
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
>>
>> Hi,
>>
>> I believe cgroup is a better approach for containers, since this
>> approach can be easily integrated with the user space stack like
>> containerd and kubernets, which use cgroup to control system resources.
> 
> The integration of BPF with containerd and Kubernetes is emerging as a
> clear trend.
> 

No, eBPF is not used for resource management, it is mainly used by the
network stack (CNI), monitoring and security. All the resource
management by Kubernetes is done using cgroups. You are very unlikely
to convince the Kubernetes community to manage memory resources using
eBPF.

>>
>> However, I pointed out earlier, the approach I suggested has some
>> flaws:
>> 1. Potential polution of cgroup with a big number of knobs
> 
> Right, the memcg maintainers once told me that introducing a new
> cgroup file means committing to maintaining it indefinitely, as these
> interface files are treated as part of the ABI.
> In contrast, BPF kfuncs are considered an unstable API, giving you the
> flexibility to modify them later if needed.
> 
>> 2. Requires configuration by the admin
>>
>> Ideally, as Matthew W. mentioned, there should be an automatic system.
> 
> Take Matthew’s XFS large folio feature as an example—it was enabled
> automatically. A few years ago, when we upgraded to the 6.1.y stable
> kernel, we noticed this new feature. Since it was enabled by default,
> we assumed the author was confident in its stability. Unfortunately,
> it led to severe issues in our production environment: servers crashed
> randomly, and in some cases, we experienced data loss without
> understanding the root cause.
> 
> We began disabling various kernel configurations in an attempt to
> isolate the issue, and eventually, the problem disappeared after
> disabling CONFIG_TRANSPARENT_HUGEPAGE. As a result, we released a new
> kernel version with THP disabled and had to restart hundreds of
> thousands of production servers. It was a nightmare for both us and
> our sysadmins.
> 
> Last year, we discovered that the initial issue had been resolved by this patch:
> https://lore.kernel.org/stable/20241001210625.95825-1-ryncsn@gmail.com/.
> We backported the fix and re-enabled XFS large folios—only to face a
> new nightmare. One of our services began crashing sporadically with
> core dumps. It took us several months to trace the issue back to the
> re-enabled XFS large folio feature. Fortunately, we were able to
> disable it using livepatch, avoiding another round of mass server
> restarts. To this day, the root cause remains unknown. The good news
> is that the issue appears to be resolved in the 6.12.y stable kernel.
> We're still trying to bisect which commit fixed it, though progress is
> slow because the issue is not reliably reproducible.
> 
> In theory, new features should be enabled automatically. But in
> practice, every new feature should come with a tunable knob. That’s a
> lesson we learned the hard way from this experience—and perhaps
> Matthew did too.
> 
>>
>> Anyway, regarding containers, I believe cgroup is a good approach
>> given that the admin or the container management system uses cgroups
>> to set up the containers.
>>
>> --
>> Asier Gutierrez
>> Huawei
>>
> 

-- 
Asier Gutierrez
Huawei


