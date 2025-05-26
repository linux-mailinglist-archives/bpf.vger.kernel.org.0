Return-Path: <bpf+bounces-58925-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E081AAC3AD5
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D831889806
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776C1DFDB8;
	Mon, 26 May 2025 07:41:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A71DF27D
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 07:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748245305; cv=none; b=VTCD6XaqEZF3WO3+Rf9QwAs1DoVF3ShAJvls/VQkuuq4Aji2Mj0nsD0dENR5OR08hFpvZXj/hIpY/6+cbyC111Tf4RVOiCtAD0MNWvswKEqZoSfiN7nGLHAGeCYUh68EmXphurf6hhV8cF+qqFJUbvW/A/vtuRIJI58lB41YUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748245305; c=relaxed/simple;
	bh=p6wY7hCiixwsHvBL8QVhVF/iM4zmcRMwBL8+YTlDY4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h5et9nXe8kVLlHfBx08n2CtiFS9SfLW6TDSqyrEMr2xbmd/sOuvF8Ny9y4mPqcN9t6enJFmr1QL0/X8sJKRKrarNm+8d0n8js+fuIQE7b9cECGoQT9Q08xln6yj7Q8IPqnECch5hrFbkjfldwkT2mZjPuNkQoH7oziRshXCRpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b5SJ31F83z6M4tJ;
	Mon, 26 May 2025 15:36:35 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id C37181402FE;
	Mon, 26 May 2025 15:41:33 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 10:41:33 +0300
Message-ID: <a03e4e99-bcbd-4279-acc1-34d665e7dcef@huawei-partners.com>
Date: Mon, 26 May 2025 10:41:32 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: Yafang Shao <laoar.shao@gmail.com>, <akpm@linux-foundation.org>,
	<david@redhat.com>, <ziy@nvidia.com>, <baolin.wang@linux.alibaba.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <npache@redhat.com>,
	<ryan.roberts@arm.com>, <dev.jain@arm.com>, <hannes@cmpxchg.org>,
	<usamaarif642@gmail.com>, <willy@infradead.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>
CC: <bpf@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 5/25/2025 6:01 AM, Yafang Shao wrote:
> On Tue, May 20, 2025 at 2:05 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>
>> Background
>> ----------
>>
>> At my current employer, PDD, we have consistently configured THP to "never"
>> on our production servers due to past incidents caused by its behavior:
>>
>> - Increased memory consumption
>>   THP significantly raises overall memory usage.
>>
>> - Latency spikes
>>   Random latency spikes occur due to more frequent memory compaction
>>   activity triggered by THP.
>>
>> These issues have made sysadmins hesitant to switch to "madvise" or
>> "always" modes.
>>
>> New Motivation
>> --------------
>>
>> We have now identified that certain AI workloads achieve substantial
>> performance gains with THP enabled. However, we’ve also verified that some
>> workloads see little to no benefit—or are even negatively impacted—by THP.
>>
>> In our Kubernetes environment, we deploy mixed workloads on a single server
>> to maximize resource utilization. Our goal is to selectively enable THP for
>> services that benefit from it while keeping it disabled for others. This
>> approach allows us to incrementally enable THP for additional services and
>> assess how to make it more viable in production.
>>
>> Proposed Solution
>> -----------------
>>
>> For this use case, Johannes suggested introducing a dedicated mode [0]. In
>> this new mode, we could implement BPF-based THP adjustment for fine-grained
>> control over tasks or cgroups. If no BPF program is attached, THP remains
>> in "never" mode. This solution elegantly meets our needs while avoiding the
>> complexity of managing BPF alongside other THP modes.
>>
>> A selftest example demonstrates how to enable THP for the current task
>> while keeping it disabled for others.
>>
>> Alternative Proposals
>> ---------------------
>>
>> - Gutierrez’s cgroup-based approach [1]
>>   - Proposed adding a new cgroup file to control THP policy.
>>   - However, as Johannes noted, cgroups are designed for hierarchical
>>     resource allocation, not arbitrary policy settings [2].
>>
>> - Usama’s per-task THP proposal based on prctl() [3]:
>>   - Enabling THP per task via prctl().
>>   - As David pointed out, neither madvise() nor prctl() works in "never"
>>     mode [4], making this solution insufficient for our needs.
>>
>> Conclusion
>> ----------
>>
>> Introducing a new "bpf" mode for BPF-based per-task THP adjustments is the
>> most effective solution for our requirements. This approach represents a
>> small but meaningful step toward making THP truly usable—and manageable—in
>> production environments.
>>
>> This is currently a PoC implementation. Feedback of any kind is welcome.
>>
>> Link: https://lore.kernel.org/linux-mm/20250509164654.GA608090@cmpxchg.org/ [0]
>> Link: https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.asier@huawei-partners.com/ [1]
>> Link: https://lore.kernel.org/linux-mm/20250430175954.GD2020@cmpxchg.org/ [2]
>> Link: https://lore.kernel.org/linux-mm/20250519223307.3601786-1-usamaarif642@gmail.com/ [3]
>> Link: https://lore.kernel.org/linux-mm/41e60fa0-2943-4b3f-ba92-9f02838c881b@redhat.com/ [4]
>>
>> RFC v1->v2:
>> The main changes are as follows,
>> - Use struct_ops instead of fmod_ret (Alexei)
>> - Introduce a new THP mode (Johannes)
>> - Introduce new helpers for BPF hook (Zi)
>> - Refine the commit log
>>
>> RFC v1: https://lwn.net/Articles/1019290/
>>
>> Yafang Shao (5):
>>   mm: thp: Add a new mode "bpf"
>>   mm: thp: Add hook for BPF based THP adjustment
>>   mm: thp: add struct ops for BPF based THP adjustment
>>   bpf: Add get_current_comm to bpf_base_func_proto
>>   selftests/bpf: Add selftest for THP adjustment
>>
>>  include/linux/huge_mm.h                       |  15 +-
>>  kernel/bpf/cgroup.c                           |   2 -
>>  kernel/bpf/helpers.c                          |   2 +
>>  mm/Makefile                                   |   3 +
>>  mm/bpf_thp.c                                  | 120 ++++++++++++
>>  mm/huge_memory.c                              |  65 ++++++-
>>  mm/khugepaged.c                               |   3 +
>>  tools/testing/selftests/bpf/config            |   1 +
>>  .../selftests/bpf/prog_tests/thp_adjust.c     | 175 ++++++++++++++++++
>>  .../selftests/bpf/progs/test_thp_adjust.c     |  39 ++++
>>  10 files changed, 414 insertions(+), 11 deletions(-)
>>  create mode 100644 mm/bpf_thp.c
>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
>>
>> --
>> 2.43.5
>>
> 
> Hi all,
> 
> Let’s summarize the current state of the discussion and identify how
> to move forward.
> 
> - Global-Only Control is Not Viable
> We all seem to agree that a global-only control for THP is unwise. In
> practice, some workloads benefit from THP while others do not, so a
> one-size-fits-all approach doesn’t work.
> 
> - Should We Use "Always" or "Madvise"?
> I suspect no one would choose 'always' in its current state. ;)
> Both Lorenzo and David propose relying on the madvise mode. However,
> since madvise is an unprivileged userspace mechanism, any user can
> freely adjust their THP policy. This makes fine-grained control
> impossible without breaking userspace compatibility—an undesirable
> tradeoff.
> Given these limitations, the community should consider introducing a
> new "admin" mode for privileged THP policy management.
> 
> - Can the Kernel Automatically Manage THP Without User Input?
> In practice, users define their own success metrics—such as latency
> (RT), queries per second (QPS), or throughput—to evaluate a feature’s
> usefulness. If a feature fails to improve these metrics, it provides
> no practical value.
> Currently, the kernel lacks visibility into user-defined metrics,
> making fully automated optimization impossible (at least without user
> input). More importantly, automatic management offers no benefit if it
> doesn’t align with user needs.

I don't think that using things like RPS or QPS is the right way.
These metrics can be affected by many factors like network issues, 
garbage collectors in the user space (JVM, golang, etc.) and many other
things out of our control. Even noisy neighbors can slow down a service.

> Exception: For kernel-enforced changes (e.g., the page-to-folio
> transition), users must adapt regardless. But THP tuning requires
> flexibility—forcing automation without measurable gains is
> counterproductive.
> (Please correct me if I’ve overlooked anything.)
> 

-- 
Asier Gutierrez
Huawei


