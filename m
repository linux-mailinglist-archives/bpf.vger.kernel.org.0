Return-Path: <bpf+bounces-37019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE26A9504E9
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 14:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F68B2614C
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 12:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDA3199E91;
	Tue, 13 Aug 2024 12:30:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224EB1607B9;
	Tue, 13 Aug 2024 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552230; cv=none; b=qpfP59jM3oprhm1CmKMfsM/jzbAxc6+MDSjErrotYKaxm2QVYhkU3IhtHSpKKpZnqSeNjK6Yom/dnZbiE8n+tDxpAoJ+y43xEUj24fNv69OSZmydEKAyOEBIi0jpFCyiw8sLOupXCx/Z5cm1I5V9ZKL0q/tKvWbVtXEtCaGkv+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552230; c=relaxed/simple;
	bh=k+B6a/OYe5z/Hgaunm8r4FWv+m/OJDOSGoSAm7gTw+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ae7CZoi8MVK+1MU+94V+UCL6HUat+K69Aiz2L6nXejq1J5O5fy4IIj8ipFj+8gLlxd0lA8b0mLGGvbJz+wOcXZ7bXuqO7iw0dAAMZVgqqXSccgP7LodoCSLhT3Hk17vrJ9AK1MCdZWMXkLQnsmGrMj9aRjFTr+A35Fse2eUc6hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WjrLV33flzyPFL;
	Tue, 13 Aug 2024 20:29:54 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 37A6C1800A6;
	Tue, 13 Aug 2024 20:30:23 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 13 Aug 2024 20:30:22 +0800
Message-ID: <1f40c2c1-1cf3-0fea-5e2b-38bde0f2fb2c@huawei.com>
Date: Tue, 13 Aug 2024 20:30:21 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] uprobes: Remove the spinlock within
 handle_singlestep()
To: Oleg Nesterov <oleg@redhat.com>
CC: <mhiramat@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<andrii@kernel.org>, <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240809061004.2112369-1-liaochang1@huawei.com>
 <20240809061004.2112369-3-liaochang1@huawei.com>
 <20240812112929.GB11656@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240812112929.GB11656@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/12 19:29, Oleg Nesterov 写道:
> On 08/09, Liao Chang wrote:
>>
>> --- a/include/linux/uprobes.h
>> +++ b/include/linux/uprobes.h
>> @@ -75,6 +75,7 @@ struct uprobe_task {
>>  
>>  	struct uprobe			*active_uprobe;
>>  	unsigned long			xol_vaddr;
>> +	bool				deny_signal;
> 
> Ack, but... I can't believe I am arguing with the naming ;)
> Can we have a better name for this flag?
> 
> 	utask->signal_denied ?
> 	utask->restore_sigpending ?

I prefer the name "signal_denied" as it more accurately reflects
what happened.

> 
> or just
> 
> 	utask->sigpending ?
> 
> utask->deny_signal looks as if handle_singlestep/whatever should
> "deny" the pending signal cleared by uprobe_deny_signal(), while
> it fact it should restore TIF_SIGPENDING.

Make sense. I will change the name in v3.

> 
> Oleg.
> 
>>  
>>  	struct return_instance		*return_instances;
>>  	unsigned int			depth;
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 76a51a1f51e2..77934fbd1370 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -1979,6 +1979,7 @@ bool uprobe_deny_signal(void)
>>  	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
>>  
>>  	if (task_sigpending(t)) {
>> +		utask->deny_signal = true;
>>  		clear_tsk_thread_flag(t, TIF_SIGPENDING);
>>  
>>  		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
>> @@ -2288,9 +2289,10 @@ static void handle_singlestep(struct uprobe_task *utask, struct pt_regs *regs)
>>  	utask->state = UTASK_RUNNING;
>>  	xol_free_insn_slot(current);
>>  
>> -	spin_lock_irq(&current->sighand->siglock);
>> -	recalc_sigpending(); /* see uprobe_deny_signal() */
>> -	spin_unlock_irq(&current->sighand->siglock);
>> +	if (utask->deny_signal) {
>> +		set_thread_flag(TIF_SIGPENDING);
>> +		utask->deny_signal = false;
>> +	}
>>  
>>  	if (unlikely(err)) {
>>  		uprobe_warn(current, "execute the probed insn, sending SIGILL.");
>> -- 
>> 2.34.1
>>
> 
> 

-- 
BR
Liao, Chang

