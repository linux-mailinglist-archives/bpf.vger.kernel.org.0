Return-Path: <bpf+bounces-37020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF399504EC
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 14:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB8B1F22FFE
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 12:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0819AD71;
	Tue, 13 Aug 2024 12:30:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3408199397;
	Tue, 13 Aug 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552240; cv=none; b=IYYEiqvBv5t9jV0AQYN0BdJ6Wfh9SHQGo1ua0616vnwm5mDjHukDoluA1DAr/UsvQMoNNda1shy0YS17EOR0NlNlXs9BnRQq6WLy7FcLKP3YvVdF/rUwV2X8e2TRZZ1/hUpajpLwnqYotxr+idyLK0PhOfe7yu9DuCqu9voNQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552240; c=relaxed/simple;
	bh=Ui7mxf+XESXbl2/Tywo0mYfgT4r8ajOKrUstfrEfPZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lQJsh/hklzH53Zwxv6H+8laWxVJfur4fQmj4IgWlTaqp1/4Wr1zxJxElF2bSmGsyw9r9R+Reh85AIQ4eIRzhOXdIqgeVxUjUdGq/6TLk+gt3eXp2bfUtDpLFE8bdFqvFTR/cWBno621kkFYFyb7KTeIrZ5EGiuSPBVVOayFygzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WjrFg6WPxz2CmQ7;
	Tue, 13 Aug 2024 20:25:43 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id AC948180018;
	Tue, 13 Aug 2024 20:30:34 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 13 Aug 2024 20:30:33 +0800
Message-ID: <2971107e-75e7-8438-c858-b95202d7b5ea@huawei.com>
Date: Tue, 13 Aug 2024 20:30:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] uprobes: Remove redundant spinlock in
 uprobe_deny_signal()
To: Oleg Nesterov <oleg@redhat.com>
CC: <mhiramat@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<andrii@kernel.org>, <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240809061004.2112369-1-liaochang1@huawei.com>
 <20240809061004.2112369-2-liaochang1@huawei.com>
 <20240812120738.GC11656@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240812120738.GC11656@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/12 20:07, Oleg Nesterov 写道:
> On 08/09, Liao Chang wrote:
>>
>> Since clearing a bit in thread_info is an atomic operation, the spinlock
>> is redundant and can be removed, reducing lock contention is good for
>> performance.
> 
> My ack still stays, but let me add some notes...
> 
> sighand->siglock doesn't protect clear_bit() per se. It was used to not
> break the "the state of TIF_SIGPENDING of every thread is stable with
> sighand->siglock held" rule.
> 
> But we already have the lockless users of clear_thread_flag(TIF_SIGPENDING)
> (some if not most of them look buggy), and afaics in this (very special)
> case it should be fine.

Oleg, your explaination is more accurate. So I will reword the commit log and
quote some of your note like this:

  Since we already have the lockless user of clear_thread_flag(TIF_SIGPENDING).
  And for uprobe singlestep case, it doesn't break the rule of "the state of
  TIF_SIGPENDING of every thread is stable with sighand->siglock held". So
  removing sighand->siglock to reduce contention for better performance.

> 
> Oleg.
> 
>> Acked-by: Oleg Nesterov <oleg@redhat.com>
>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>> ---
>>  kernel/events/uprobes.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
>> index 73cc47708679..76a51a1f51e2 100644
>> --- a/kernel/events/uprobes.c
>> +++ b/kernel/events/uprobes.c
>> @@ -1979,9 +1979,7 @@ bool uprobe_deny_signal(void)
>>  	WARN_ON_ONCE(utask->state != UTASK_SSTEP);
>>  
>>  	if (task_sigpending(t)) {
>> -		spin_lock_irq(&t->sighand->siglock);
>>  		clear_tsk_thread_flag(t, TIF_SIGPENDING);
>> -		spin_unlock_irq(&t->sighand->siglock);
>>  
>>  		if (__fatal_signal_pending(t) || arch_uprobe_xol_was_trapped(t)) {
>>  			utask->state = UTASK_SSTEP_TRAPPED;
>> -- 
>> 2.34.1
>>
> 
> 

-- 
BR
Liao, Chang

