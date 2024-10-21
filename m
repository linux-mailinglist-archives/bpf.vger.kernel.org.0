Return-Path: <bpf+bounces-42608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1949A6783
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 14:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176601C222F8
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E921EB9F2;
	Mon, 21 Oct 2024 12:04:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A51EABC3;
	Mon, 21 Oct 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729512242; cv=none; b=cnkh0Zj+ltBWYUMeuDr39ZqGkeoC/JGbP6V0p8HSIKgO/4sxbNTUvSxClUhmjGrG84oU7cWmhbtJ7EfJNJ4oEbOGG2qZ46mfnccc0T6WcTfQH87hpzsxleOFfakkDev91vl76lS+6TrXhmyfQ22hD1EEpuwrHx6Xkmrg+f39+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729512242; c=relaxed/simple;
	bh=MexqYOOCFAKTWp7wFixbyK1Hi5aI+zLK7LGUYsL1zjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XrUaWGJVa1avsWdihAs7W/H0Ee7dcGVy1tbcmZTpQafLpBLvrFGzoOLbHOFWhaGJTvReMhGMXpuaN5C5bK+UqGO+4R9+vrtsG4vLCBIT1xE/fkW8eafmkW+KvpOSldTZB0JDoeB/Ch77qETzq9ODUcEJZxrseZOvctGJ5pL+1AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XXDSQ5FcBzpX4d;
	Mon, 21 Oct 2024 20:01:58 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 1A15518005F;
	Mon, 21 Oct 2024 20:03:56 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 21 Oct 2024 20:03:55 +0800
Message-ID: <895ce437-d6b1-46ba-b06f-e422f58a03cb@huawei.com>
Date: Mon, 21 Oct 2024 20:03:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] uprobes: Improve the usage of xol slots for better
 scalability
To: Oleg Nesterov <oleg@redhat.com>
CC: <ak@linux.intel.com>, <mhiramat@kernel.org>, <andrii@kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240927094549.3382916-1-liaochang1@huawei.com>
 <20240927171838.GA15877@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240927171838.GA15877@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200013.china.huawei.com (7.221.188.133)

Oleg,

My bad to take so long to reply. I have recently returned from a long vacation.

在 2024/9/28 1:18, Oleg Nesterov 写道:
> On 09/27, Liao Chang wrote:
>>
>> +int recycle_utask_slot(struct uprobe_task *utask, struct xol_area *area)
>> +{
>> +	int slot = UINSNS_PER_PAGE;
>> +
>> +	/*
>> +	 * Ensure that the slot is not in use on other CPU. However, this
>> +	 * check is unnecessary when called in the context of an exiting
>> +	 * thread. See xol_free_insn_slot() called from uprobe_free_utask()
>> +	 * for more details.
>> +	 */
>> +	if (test_and_put_task_slot(utask)) {
>> +		list_del(&utask->gc);
>> +		clear_bit(utask->insn_slot, area->bitmap);
>> +		atomic_dec(&area->slot_count);
>> +		utask->insn_slot = UINSNS_PER_PAGE;
>> +		refcount_set(&utask->slot_ref, 1);
> 
> This lacks a barrier, CPU can reorder the last 2 insns
> 
> 		refcount_set(&utask->slot_ref, 1);
> 		utask->insn_slot = UINSNS_PER_PAGE;
> 
> so the "utask->insn_slot == UINSNS_PER_PAGE" check in xol_get_insn_slot()
> can be false negative.

Good catcha! Would an atomic_set() with release ordering be sufficient here
instead of smp_mb()?

> 
>> +static unsigned long xol_get_insn_slot(struct uprobe_task *utask,
>> +				       struct uprobe *uprobe)
>>  {
>>  	struct xol_area *area;
>>  	unsigned long xol_vaddr;
>> @@ -1665,16 +1740,46 @@ static unsigned long xol_get_insn_slot(struct uprobe *uprobe)
>>  	if (!area)
>>  		return 0;
>>
>> -	xol_vaddr = xol_take_insn_slot(area);
>> -	if (unlikely(!xol_vaddr))
>> +	/*
>> +	 * The racing on the utask associated slot_ref can occur unless the
>> +	 * area runs out of slots. This isn't a common case. Even if it does
>> +	 * happen, the scalability bottleneck will shift to another point.
>> +	 */
> 
> I don't understand the comment, I guess it means the race with
> recycle_utask_slot() above.
> >> +	if (!test_and_get_task_slot(utask))

Exactly, While introducing another refcount operation here might seem like
a downside, the potential racing on it should be less than the ones on
xol_area->bitmap and xol_area->slot_count(which you've already optimized).

>>  		return 0;
> 
> No, we can't do this. xol_get_insn_slot() should never fail.
> 
> OK, OK, currently xol_get_insn_slot() _can_ fail, but only if get_xol_area()
> fails to allocate the memory. Which should "never" happen and we can do nothing
> in this case anyway.

Sorry, I haven't trace the exact path where xol_get_insn_slot() fails. I suspect
it might repeatedly trigger BRK exceptions before get_xol_area() successfully
returns. Please correct me if I am wrong.

> 
> But it certainly must not fail if it races with another thread, this is insane.

Agreed, it is somewhat costly when race fails. I suggest that it allocates a new
slot upon the race fails instead of returning 0.

> 
> And. This patch changes the functions which ask for cleanups. I'll try to send
> a couple of simple patches on Monday.

Thank you for pointing that out, I must have missed some patches while I was on
vacation, I will carefully review the mailing list to ensure that this patch can
work with any recent cleanups.

> 
> Oleg.
> 
> 

-- 
BR
Liao, Chang


