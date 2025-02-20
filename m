Return-Path: <bpf+bounces-52076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94382A3D96B
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 13:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D64B17E73A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 12:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 543D11F582A;
	Thu, 20 Feb 2025 12:01:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC411F150B;
	Thu, 20 Feb 2025 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052919; cv=none; b=TE+R2XyazMT+T+oYfCnJWhkhifiY3Km4vQIz99XZkIsU8BsowH+Omxj/t0eezKAEbVeohpCL/FhamJ6BqQ404rNbzEj5RM/95cHaxgM7666dkg0MZyAi0zWiv2ChP/ZNDxT76S2Bo95ZxoXamWPtJlfuX3BlSEdkRb13No4/NtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052919; c=relaxed/simple;
	bh=xC4t5PNFRGnqdbnDdkkrRiU383ecZkkQlQNaoeaxAAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jNqj5JFPaPuuhVa6zTwqI3GwldQn5d5vdKHd9E4sI7PmeuWBwL7aDWNnFd6WFT5/vo9oa3Nf6hMtqRBGwZg0J+bSaBY/R/q4znjuC9ivfECyNc1Ph1ZBUQkB6CU/bL5J9u+Xcy7rs6GJUSFRTE0wvScmsuHg8GbQg3Emmz/hE/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YzBcW1pQBz21mxG;
	Thu, 20 Feb 2025 19:58:51 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id BA519140360;
	Thu, 20 Feb 2025 20:01:52 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Feb 2025 20:01:51 +0800
Message-ID: <85725388-180b-267c-e121-3af1f1b75f94@huawei.com>
Date: Thu, 20 Feb 2025 20:01:50 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Add Morton,Peter and David for discussion//Re: [PATCH -next]
 uprobes: fix two zero old_folio bugs in __replace_page()
To: David Hildenbrand <david@redhat.com>, Oleg Nesterov <oleg@redhat.com>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>, <wangkefeng.wang@huawei.com>, linux-mm
	<linux-mm@kvack.org>
References: <20250217123826.88503-1-tongtiangen@huawei.com>
 <c2924e9e-1a42-a4f6-5066-ea2e15477c11@huawei.com>
 <3b893634-5453-42d0-b8dc-e9d07988e9e9@redhat.com>
 <24a61833-f389-b074-0d9c-d5ad9efc2046@huawei.com>
 <20250219152237.GB5948@redhat.com>
 <34e18c47-e536-48e4-80ca-7c7bbc75ecce@redhat.com>
 <2fe4c4d1-c480-c250-1ba2-1a82caf5d7fa@huawei.com>
 <196fc7d8-30a8-439a-89bd-57353fd98df8@redhat.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <196fc7d8-30a8-439a-89bd-57353fd98df8@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemk500005.china.huawei.com (7.202.194.90)



在 2025/2/20 16:38, David Hildenbrand 写道:
> On 20.02.25 03:31, Tong Tiangen wrote:
>>
>>
>> 在 2025/2/20 0:12, David Hildenbrand 写道:
>>> On 19.02.25 16:22, Oleg Nesterov wrote:
>>>> On 02/18, Tong Tiangen wrote:
>>>>>
>>>>> OK, Before your rewrite last merged, How about i change the 
>>>>> solution to
>>>>> just reject them immediately after get_user_page_vma_remote()？
>>>>
>>>> I agree, uprobe_write_opcode() should simply fail if
>>>> is_zero_page(old_page).
>>>
>>> Yes. That's currently only syzkaller that triggers it, not some sane use
>>> case.
>>
>> OK, change as follows:
>>
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -506,6 +506,12 @@ int uprobe_write_opcode(struct arch_uprobe
>> *auprobe, struct mm_struct *mm,
>>           if (ret <= 0)
>>                   goto put_old;
>>
>> +       if (WARN(is_zero_page(old_page),
> 
> This can likely be triggered by user space, so do not use WARN.

OK,thanks.

Hi Oleg, is that all right?

Thanks,
Tong.

> 

