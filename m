Return-Path: <bpf+bounces-58954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50AAC4473
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 22:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4689317AA8E
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88E519343B;
	Mon, 26 May 2025 20:30:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF82DCC0B
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748291448; cv=none; b=O9rCLcG5wnUpcJ/DxpdWCDkAYngLZE3frmi2DIU3iHbeMU2SEEsdNkjhXe8zEnCEkwevjsiMYiTRqnRLLbk8unvsSVAUyUyRU8yR9MLcp005qjb8MV6gHceRhSRzqURGd++n1DMbtSrT6zSSVQa1pehNW6u1mcgXo2uiQ/N/8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748291448; c=relaxed/simple;
	bh=wiHDaZkOxKp3HTteRfOyfS0gLduVwpSo733sv4GBFIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ebEe7ihbb7tsiJj+Lac+/6Li05qKxUwjaFMfxhtLHrZtNDWWTzLlniip+B9E/wPE7G8LWP687Wk/kfagPoo6XY7qJLyNZDpXzkZKGN820xyA0z1sOvq4nlNLIk7LIy3i5UMAHavc8UtMYYCNv3zNhG01rRXJ7fBwAfQMnmaRYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b5nMR72Gbz67MmR;
	Tue, 27 May 2025 04:25:39 +0800 (CST)
Received: from mscpeml500003.china.huawei.com (unknown [7.188.49.51])
	by mail.maildlp.com (Postfix) with ESMTPS id 61B851402F3;
	Tue, 27 May 2025 04:30:39 +0800 (CST)
Received: from [10.123.123.154] (10.123.123.154) by
 mscpeml500003.china.huawei.com (7.188.49.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 26 May 2025 23:30:38 +0300
Message-ID: <cbe7693f-fc5c-46d1-ac95-29171e3a46c3@huawei-partners.com>
Date: Mon, 26 May 2025 23:30:38 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/5] mm, bpf: BPF based THP adjustment
To: David Hildenbrand <david@redhat.com>, "Liam R. Howlett"
	<Liam.Howlett@oracle.com>, Yafang Shao <laoar.shao@gmail.com>,
	<akpm@linux-foundation.org>, <ziy@nvidia.com>,
	<baolin.wang@linux.alibaba.com>, <lorenzo.stoakes@oracle.com>,
	<npache@redhat.com>, <ryan.roberts@arm.com>, <dev.jain@arm.com>,
	<hannes@cmpxchg.org>, <usamaarif642@gmail.com>, <willy@infradead.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<bpf@vger.kernel.org>, <linux-mm@kvack.org>
References: <20250520060504.20251-1-laoar.shao@gmail.com>
 <CALOAHbDPF+Mxqwh+5ScQFCyEdiz1ghNbgxJKAqmBRDeAZfe3sA@mail.gmail.com>
 <7d8a9a5c-e0ef-4e36-9e1d-1ef8e853aed4@redhat.com>
 <CALOAHbB-KQ4+z-Lupv7RcxArfjX7qtWcrboMDdT4LdpoTXOMyw@mail.gmail.com>
 <c983ffa8-cd14-47d4-9430-b96acedd989c@redhat.com>
 <yzpyagsqw4ryk63zfu3vxvjvrfxldbxm7wx2a3th7okidf7rwv@zsoyiwqtshfc>
 <pzuye3fkj6fj2riyzipqj7u4plwg6sjm2nyw4jkqi57u3g2yp5@jmvn5z2g5i7x>
 <3b792576-6189-4f53-b47f-95875181a656@redhat.com>
Content-Language: en-US
From: Gutierrez Asier <gutierrez.asier@huawei-partners.com>
In-Reply-To: <3b792576-6189-4f53-b47f-95875181a656@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mscpeml100004.china.huawei.com (7.188.51.133) To
 mscpeml500003.china.huawei.com (7.188.49.51)



On 5/26/2025 7:51 PM, David Hildenbrand wrote:
> On 26.05.25 17:54, Liam R. Howlett wrote:
>> * Liam R. Howlett <Liam.Howlett@oracle.com> [250526 10:54]:
>>> * David Hildenbrand <david@redhat.com> [250526 06:49]:
>>>> On 26.05.25 11:37, Yafang Shao wrote:
>>>>> On Mon, May 26, 2025 at 4:14 PM David Hildenbrand <david@redhat.com> wrote:
>>>>>>
>>>>>>> Hi all,
>>>>>>>
>>>>>>> Let’s summarize the current state of the discussion and identify how
>>>>>>> to move forward.
>>>>>>>
>>>>>>> - Global-Only Control is Not Viable
>>>>>>> We all seem to agree that a global-only control for THP is unwise. In
>>>>>>> practice, some workloads benefit from THP while others do not, so a
>>>>>>> one-size-fits-all approach doesn’t work.
>>>>>>>
>>>>>>> - Should We Use "Always" or "Madvise"?
>>>>>>> I suspect no one would choose 'always' in its current state. ;)
>>>>>>
>>>>>> IIRC, RHEL9 has the default set to "always" for a long time.
>>>>>
>>>>> good to know.
>>>>>
>>>>>>
>>>>>> I guess it really depends on how different the workloads are that you
>>>>>> are running on the same machine.
>>>>>
>>>>> Correct. If we want to enable THP for specific workloads without
>>>>> modifying the kernel, we must isolate them on dedicated servers.
>>>>> However, this approach wastes resources and is not an acceptable
>>>>> solution.
>>>>>
>>>>>>
>>>>>>    > Both Lorenzo and David propose relying on the madvise mode. However,>
>>>>>> since madvise is an unprivileged userspace mechanism, any user can
>>>>>>> freely adjust their THP policy. This makes fine-grained control
>>>>>>> impossible without breaking userspace compatibility—an undesirable
>>>>>>> tradeoff.
>>>>>>
>>>>>> If required, we could look into a "sealing" mechanism, that would
>>>>>> essentially lock modification attempts performed by the process (i.e.,
>>>>>> MADV_HUGEPAGE).
>>>>>
>>>>> If we don’t introduce a new THP mode and instead rely solely on
>>>>> madvise, the "sealing" mechanism could either violate the intended
>>>>> semantics of madvise(), or simply break madvise() entirely, right?
>>>>
>>>> We would have to be a bit careful, yes.
>>>>
>>>> Errors from MADV_HUGEPAGE/MADV_NOHUGEPAGE are often ignored, because these
>>>> options also fail with -EINVAL on kernels without THP support.
>>>>
>>>> Ignoring MADV_NOHUGEPAGE can be problematic with userfaultfd.
>>>>
>>>> What you likely really want to do is seal when you configured
>>>> MADV_NOHUGEPAGE to be the default, and fail MADV_HUGEPAGE later.
>>
>> I am also not entirely sure how sealing a non-existing vma would work.
>> We'd have to seal the default flags, but sealing is one way and this
>> surely shouldn't be one way?
> 
> You probably have  mseal() in mind. Just like we wouldn't be using madvise(), we also wouldn't be using mseal().
> 
> It could be a simple mctrl()/whatever option/flag to set the default and no longer allow changing the default and per-VMA flags, unless CAP_SYS_ADMIN or sth like that.
> 

This isn't really TRANSPARENT Huge Pages, since we will require 
the application to determine which memory range will be mapped with 
huge pages.

-- 
Asier Gutierrez
Huawei


