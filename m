Return-Path: <bpf+bounces-40192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A869697E9EB
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 12:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E31951C212DB
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982A5197A7F;
	Mon, 23 Sep 2024 10:30:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD7197558;
	Mon, 23 Sep 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727087407; cv=none; b=jtrRlUETHwZjwYChPHknm7hy4zvf6zETTA9pV4tv8vMCDc0+K8D+eZb0XoBt0zW9CTlFcfkultRcmcNstzGxlOnQg8NSu6aSAuTz2R7Ur4Bh1IZSNJaCSIoCCSmZoBGot3S8T3hfgfEDaKskY6i42dilOHrD5mxKV6fJb4kiRSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727087407; c=relaxed/simple;
	bh=KtGx5U5GzL7Z/yR+uBlw5VS/+lB7HSxpBr3S7vnjqXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NE3WizXt/OaFRlh+WgSwpVTPser64IO/fRBzIlF/JnfBYvEXX1i2Gp5WehxOpnLEDWEP7f/OxosH79Be+ao2kedV+BPlNcWcHA2bJ+s8nWOPUFr3EUlzlIoemK7gVHw2XrBiHd2FLDxvuMpxnuSxWIVPQs4QbtPJJIlL8O6vCaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XBzkG1xpTz1SC8B;
	Mon, 23 Sep 2024 18:29:10 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 97EC21A016C;
	Mon, 23 Sep 2024 18:29:55 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 23 Sep 2024 18:29:54 +0800
Message-ID: <0939300c-a825-5b46-d86f-72ce89b2b95f@huawei.com>
Date: Mon, 23 Sep 2024 18:29:54 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] uprobes: Improve the usage of xol slots for better
 scalability
To: Andi Kleen <ak@linux.intel.com>
CC: <mhiramat@kernel.org>, <oleg@redhat.com>, <andrii@kernel.org>,
	<peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240918012752.2045713-1-liaochang1@huawei.com>
 <87jzf9b12w.fsf@linux.intel.com>
 <7a6ba3f3-dffa-cdac-73c7-074505ea4b44@huawei.com> <ZuwoUmqXrztp-Mzh@tassilo>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <ZuwoUmqXrztp-Mzh@tassilo>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/19 21:34, Andi Kleen 写道:
>> Sorry, I know nothing about the ThreadSanitizer and related annotation,
>> could you provide some information about it, thanks.
> 
> Documentation/dev-tools/kcsan.rst

Thanks.

> 
>>> Would be good to have some commentary why doing so
>>> many write operations with merely a rcu_read_lock as protection is safe.
>>> It might be safer to put some write type operations under a real lock. 
>>> Also it is unclear how the RCU grace period for utasks is enforced.
>>
>> You are right, but I think using atomic refcount routine might be a more
>> suitable apprach for this scenario. The slot_ret field of utask instance
> 
> Does it really all need to be lockless? Perhaps you can only make the 
> common case lockless, but then only when the list overflows take a lock 
> and avoid a lot of races. That might be good enough for performance.

Agreed, List overflow would happen if new threads were constantly spawned
and hit the breakpoint. I'm not sure how often this occurs in real application.
Even if some applications follow this pattern, I suspect the bottleneck
might shift to another point, like dynamically allocating new utask instances.
At least, for the scalability selftest benchmark, list overflow shouldn't
be a common case.

> 
> If you really want a complex lockless scheme you need very clear documentation
> in comments and commit logs at least.
> 
> Also there should be a test case that stresses the various cases.
> 
> I would just use a lock 

Thanks for the suggestions, I will experiment with a read-write lock, meanwhile,
adding the documentation and testing for the lockless scheme.

>> is used to track the status of insn_slot. slot_ret supports three values.
>> A value of 2 means the utask associated insn_slot is currently in use by
>> uprobe. A value of 1 means the slot is no being used by uprobe. A value
>> of 0 means the slot has been reclaimed. So in some term, the atomic refcount
>> routine test_and_pout_task_slot() also avoid the racing when writing to
>> the utask instance, providing additional status information about insn_slot.
>>
>> BTW, You reminded me that since it might recycle the slot after deleting the
>> utask from the garbage collection list, so it's necessary to use
>> test_and_put_task_slot() to avoid the racing on the stale utask. the correct
>> code might be something like this:
>>
>> @@ -1771,16 +1783,16 @@ static void xol_free_insn_slot(struct task_struct *tsk)
>>
>>         spin_lock_irqsave(&area->list_lock, flags);
>>         list_del_rcu(&tsk->utask->gc);
>> +       /* Ensure the slot is not in use or reclaimed on other CPU */
>> +       if (test_and_put_task_slot(tsk->utask)) {
>> +               clear_bit(tsk->utask->insn_slot, area->bitmap);
>> +               atomic_dec(&area->slot_count);
>> +               tsk->utask->insn_slot = UINSNS_PER_PAGE;
>> +               get_task_slot(tsk->utask);
>> +       }
> 
> I would have expected you would add a if (racing) bail out, assume the
> other CPU will do the work type check but that doesn't seem to be what
> the code is doing.

Sorry, I may not probably get the point clear here, and it would be very
nice if more details are provided for the concern. Do you mean it's necessary
to make the if-body excution exclusive among the CPUs? If that's the case,
I guess the test_and_put_task_slot() is the equvialent to the race condition
check. test_and_put_task_slot() uses a compare and exchange operation on the
slot_ref of utask instance. Regardless of the work type being performed by
other CPU, it will always bail out unless the slot_ref has a value of one,
indicating the utask is free to access from local CPU.

> 
> -Andi
> 
> 

-- 
BR
Liao, Chang

