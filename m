Return-Path: <bpf+bounces-40101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A7297C905
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 14:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D4C1F229DA
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 12:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8716319DF47;
	Thu, 19 Sep 2024 12:20:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2751B18893D;
	Thu, 19 Sep 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748454; cv=none; b=kIj/pMLTI1cUE4GMYVz7i6/fbwKk1zNuMW34PU/DPlo1DD64o+PNMRRKlj/U2rc5TeUgDz4lXmGPH5oeHQtWquX9JSqnhjynmkaplECT2KBcDcd/v6OZCv/Ne/tQtKx/VDojOdCPvBKH9Q/Hd0LTx7dhTY926RI6lSjuPzAkM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748454; c=relaxed/simple;
	bh=oTYc/p2t/iTSK5+cXS3Sc0LDuFrjEIBTQIdwaJDT9C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HeQ7Xj1sKNDad7xQZh7R4OJFBCvhflj4xPFz9GgkvWbjYGi6a0VsDo//VJC0Kz1MbpRZqvzOS0wLeWbt+XvygMIvKmbIN6zfvvUHtesppCZm3ep+CveeeX8h4ZfqegPCsfrne+gTnKsNYnITCGv114I69n0tbi3lGunvnrNdG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X8ZLT5NVFzpVsg;
	Thu, 19 Sep 2024 20:18:41 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 8EC1218010F;
	Thu, 19 Sep 2024 20:20:45 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 19 Sep 2024 20:20:44 +0800
Message-ID: <7a6ba3f3-dffa-cdac-73c7-074505ea4b44@huawei.com>
Date: Thu, 19 Sep 2024 20:20:43 +0800
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
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <87jzf9b12w.fsf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/18 20:25, Andi Kleen 写道:
> Liao Chang <liaochang1@huawei.com> writes:
>> +
>> +/*
>> + * xol_recycle_insn_slot - recycle a slot from the garbage collection list.
>> + */
>> +static int xol_recycle_insn_slot(struct xol_area *area)
>> +{
>> +	struct uprobe_task *utask;
>> +	int slot = UINSNS_PER_PAGE;
>> +
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(utask, &area->gc_list, gc) {
>> +		/*
>> +		 * The utask associated slot is in-use or recycling when
>> +		 * utask associated slot_ref is not one.
>> +		 */
>> +		if (test_and_put_task_slot(utask)) {
>> +			slot = utask->insn_slot;
>> +			utask->insn_slot = UINSNS_PER_PAGE;
>> +			clear_bit(slot, area->bitmap);
>> +			atomic_dec(&area->slot_count);
>> +			get_task_slot(utask);
> 
> Doesn't this need some annotation to make ThreadSanitizer happy?

Hi, Andi

Sorry, I know nothing about the ThreadSanitizer and related annotation,
could you provide some information about it, thanks.

> Would be good to have some commentary why doing so
> many write operations with merely a rcu_read_lock as protection is safe.
> It might be safer to put some write type operations under a real lock. 
> Also it is unclear how the RCU grace period for utasks is enforced.

You are right, but I think using atomic refcount routine might be a more
suitable apprach for this scenario. The slot_ret field of utask instance
is used to track the status of insn_slot. slot_ret supports three values.
A value of 2 means the utask associated insn_slot is currently in use by
uprobe. A value of 1 means the slot is no being used by uprobe. A value
of 0 means the slot has been reclaimed. So in some term, the atomic refcount
routine test_and_pout_task_slot() also avoid the racing when writing to
the utask instance, providing additional status information about insn_slot.

BTW, You reminded me that since it might recycle the slot after deleting the
utask from the garbage collection list, so it's necessary to use
test_and_put_task_slot() to avoid the racing on the stale utask. the correct
code might be something like this:

@@ -1771,16 +1783,16 @@ static void xol_free_insn_slot(struct task_struct *tsk)

        spin_lock_irqsave(&area->list_lock, flags);
        list_del_rcu(&tsk->utask->gc);
+       /* Ensure the slot is not in use or reclaimed on other CPU */
+       if (test_and_put_task_slot(tsk->utask)) {
+               clear_bit(tsk->utask->insn_slot, area->bitmap);
+               atomic_dec(&area->slot_count);
+               tsk->utask->insn_slot = UINSNS_PER_PAGE;
+               get_task_slot(tsk->utask);
+       }
        spin_unlock_irqrestore(&area->list_lock, flags);
        synchronize_rcu();

If I've made any mistakes about RCU usage, please don't hesitate to corret me.
Thank you in advance.

> 
> 
> -Andi
> 

-- 
BR
Liao, Chang

