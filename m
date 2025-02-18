Return-Path: <bpf+bounces-51790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AADA390FC
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 03:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B811172369
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2025 02:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492CB156F28;
	Tue, 18 Feb 2025 02:54:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF514A4E0;
	Tue, 18 Feb 2025 02:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739847240; cv=none; b=AWHGlUdUUK+omtlYSYcBcXktsQ1q7ESvKVGHCQbEj8p49Kk4RwOklJyl0hILQunGisJ2O27+jGu46XZWS7INtCRulPzXDJYMbNP6OCMOk6GmuXhw2LnJ4NDYIfalhzjF5j1s+WO5bliQwCabcE1MHj74aHsYjvQxwyjxhRYi16k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739847240; c=relaxed/simple;
	bh=493fq42fS56Pd9EQ89l57uN+C+1NmFHr9GOTDqiqx1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bSUqBISD5CmqEazeSMd5g+6eo2DLQMOxqPFaOMET2u4s/+v/rmL8h6qz6PmxlAFPwfhSN2LzLoqubTSOD9JAxM3UZoWUJNqW0/2tftwKfYZYx9AB4XG7KlmJ3NT+sRzuLPzEISDyL8VUNJJFWh5iR7a3xArqGIHrzS4iUOwmBZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YxkZr4BdBzcr0Y;
	Tue, 18 Feb 2025 10:52:20 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id 3EF7E1402C1;
	Tue, 18 Feb 2025 10:53:54 +0800 (CST)
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Feb 2025 10:53:52 +0800
Message-ID: <7dac9afa-9778-187d-8f69-53a7e92bbe97@huawei.com>
Date: Tue, 18 Feb 2025 10:53:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next] uprobes: fix two zero old_folio bugs in
 __replace_page()
To: Oleg Nesterov <oleg@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>, David Hildenbrand
	<david@redhat.com>
CC: Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>, <wangkefeng.wang@huawei.com>, linux-mm
	<linux-mm@kvack.org>
References: <20250217123826.88503-1-tongtiangen@huawei.com>
 <20250217161218.GD8082@redhat.com>
From: Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <20250217161218.GD8082@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemk500005.china.huawei.com (7.202.194.90)



在 2025/2/18 0:12, Oleg Nesterov 写道:
> Can't comment, my understanding of mm/ is not enough these days.
> 
> Just one question...
> 
> On 02/17, Tong Tiangen wrote:
>>
>> Fixes: 7396fa818d62 ("uprobes/core: Make background page replacement logic account for rss_stat counters")
>> Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
> 
> Are you sure this logic was wrong from the very beginning? Just curious.
> 
> Oleg.

Yes, i checked the original code logic, and the put_page() didn't take 
zero pages into account.

Add Morton,Peter and David for discussion.

Thanks,
Tong.

> 
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   kernel/events/uprobes.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 46ddf3a2334d..ff5694acfa68 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -213,7 +213,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>>   		dec_mm_counter(mm, MM_ANONPAGES);
>>   
>>   	if (!folio_test_anon(old_folio)) {
>> -		dec_mm_counter(mm, mm_counter_file(old_folio));
>> +		if (!is_zero_folio(old_folio))
>> +			dec_mm_counter(mm, mm_counter_file(old_folio));
>>   		inc_mm_counter(mm, MM_ANONPAGES);
>>   	}
>>   
>> @@ -227,7 +228,8 @@ static int __replace_page(struct vm_area_struct *vma, unsigned long addr,
>>   	if (!folio_mapped(old_folio))
>>   		folio_free_swap(old_folio);
>>   	page_vma_mapped_walk_done(&pvmw);
>> -	folio_put(old_folio);
>> +	if (!is_zero_folio(old_folio))
>> +		folio_put(old_folio);
>>   
>>   	err = 0;
>>    unlock:
>> -- 
>> 2.25.1
>>
> 
> 
> .

