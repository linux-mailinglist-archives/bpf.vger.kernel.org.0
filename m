Return-Path: <bpf+bounces-30974-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E0C8D53AA
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 22:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A71283A50
	for <lists+bpf@lfdr.de>; Thu, 30 May 2024 20:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202D9158A02;
	Thu, 30 May 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E7tyslF7"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AD07406C
	for <bpf@vger.kernel.org>; Thu, 30 May 2024 20:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100357; cv=none; b=GKhsnDD67kKIpoFIL6Ytr5+QlXYjdgNKfaVR987c2/2xRSec859wSKPt38IAwlEW6B/cL4lynOMMcZbqagAHWpiReUh3fS0ltq6ClQtomb1fB4k3kJur+di7K/yXmCJAPQrvKMFFDu1Ca93ErKht4bEopVczmQqbCNkOO5MCH7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100357; c=relaxed/simple;
	bh=mYi7xKAK9dLwS+OPjMEGJK8xIneMe+XaVt0yLI5XNP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btYRhfyOwB0pJ5gy7puIVZcgWaVRj4tIjSl3w/MFSMI6S2uFoWH751n7Og3YJPU0rdzH2lRDStDUpDylqgzCosUJlaAucNbVJX55RmAZc3zfkhrbXfZmjDh/bu/mLR7V84qXYN9O7rSrdMQDmk6RgX4ZNECu7+pcFyV+xnhhQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E7tyslF7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sinquersw@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717100353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d48jGBar9fcnU/PR4ly7MCLgqvniIS3bxr4JP7BbH0I=;
	b=E7tyslF7hV63mKZ04XBzRjVIFa9i+9ZpDbpT3bwYh1hTysxGrByg/YsqS78tOvjJbf+Kzy
	Wgw3BxZdVKbzRyfywXV7DfP0hqfPpVTqTJAno/1uCUHH1g61wtINXHmJsmVkj6uxzE0uvL
	P03+GPbgEnE+RWpef5ucJyEMGMAIcUs=
X-Envelope-To: thinker.li@gmail.com
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: song@kernel.org
X-Envelope-To: kernel-team@meta.com
X-Envelope-To: andrii@kernel.org
X-Envelope-To: kuifeng@meta.com
Message-ID: <eff9d389-ce0c-4c7a-af27-8e5fdebc4d52@linux.dev>
Date: Thu, 30 May 2024 13:19:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 6/8] selftests/bpf: detach a struct_ops link
 from the subsystem managing it.
To: Kuifeng Lee <sinquersw@gmail.com>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
 Kui-Feng Lee <kuifeng@meta.com>
References: <20240524223036.318800-1-thinker.li@gmail.com>
 <20240524223036.318800-7-thinker.li@gmail.com>
 <f0b0e283-9312-4f11-9636-2ea690262180@linux.dev>
 <CAHE2DV0RBf9JbkmngsdKdER5F2KmUXwY_JH44Z09DsY0VNa37A@mail.gmail.com>
 <8818eaa4-b32c-41a6-82c9-6230d635e89f@linux.dev>
 <CAHE2DV2r=RYYp=G5BBSB7Cinab25J+JxcFWXwb_GbZcpxgwVGg@mail.gmail.com>
 <CAHE2DV1CnFdMobG0q5bSJyfide1LcDjfQUXLVd5Ooq55Ncpb+A@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAHE2DV1CnFdMobG0q5bSJyfide1LcDjfQUXLVd5Ooq55Ncpb+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 5/30/24 12:42 PM, Kuifeng Lee wrote:
> On Thu, May 30, 2024 at 12:34 PM Kuifeng Lee <sinquersw@gmail.com> wrote:
>>
>> On Thu, May 30, 2024 at 10:53 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>
>>> [ The mailing list got dropped in your reply, so CC back the list ]
>>>
>>> On 5/29/24 11:05 PM, Kuifeng Lee wrote:
>>>> On Wed, May 29, 2024 at 2:51 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>>>>
>>>>> On 5/24/24 3:30 PM, Kui-Feng Lee wrote:
>>>>>> @@ -832,11 +865,20 @@ static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
>>>>>>         if (ops->test_2)
>>>>>>                 ops->test_2(4, ops->data);
>>>>>>
>>>>>> +     spin_lock(&detach_lock);
>>>>>> +     if (!link_to_detach)
>>>>>> +             link_to_detach = link;
>>>>>
>>>>> bpf_testmod_ops is used in a few different tests now. Can you check if
>>>>> "./test_progs -j <num_of_parallel_workers>" will work considering link_to_detach
>>>>> here is the very first registered link.
>>>>
>>>> Yes, it works.  Since the test in test_struct_ops_modules.c is serial,
>>>> no other test will
>>>> be run simultaneously. And its subtests are run one after another.
>>>
>>> just did a quick search on "bpf_map__attach_struct_ops", how about the other
>>> tests like struct_ops_autocreate.c and test_struct_ops_multi_pages.c ?
>>
>> Got it!
>> I will put all these test to serial. WDYT?

Other than slowing things down, the future new bpf_testmod_ops tests also need 
to remember to serialize. It is not good.

Put a flag in "struct bpf_testmod_ops" to flag it is testing the detach test?

> 
> By the way, even without putting all these tests to serial, it still works.
> The serial ones will be performed without other tests running at
> the background. This test is the only test replying to the notification feature
> so far.

The new detach test added in patch 6 here may work. How about other existing 
tests? afaik, the link_to_detach here could be the link belonging to other 
tests. I don't think those tests expect their link to be detached by the new 
kfunc bpf_dummy_do_link_detach.

> 
>>
>>>
>>>
>>>>
>>>>>
>>>>>> +     spin_unlock(&detach_lock);
>>>>>> +
>>>>>>         return 0;
>>>>>>     }
>>>>>
>>>


