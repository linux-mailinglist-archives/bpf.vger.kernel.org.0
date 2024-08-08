Return-Path: <bpf+bounces-36677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C894BD86
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 14:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1D41C21DF7
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 12:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1015518C357;
	Thu,  8 Aug 2024 12:31:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D3126F1E;
	Thu,  8 Aug 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723120308; cv=none; b=ras1GuuW0HuZHfw+x14BIvzwVkEHFUlddwrg8nusa+B1hcjXJ1eno9hhU92h8LXxqSsbPpZtG5MdUYSuQdewIHJ7XNDtMdZut1AICL9R+g3wJxWuS7Bg7d0qd9U3+5lPMFhKWl7YUOnZt4Est5pBb4QRB8MwVdDOnczfSS7cXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723120308; c=relaxed/simple;
	bh=7eFGyhPBfMimZiYKIipLyg12iyy4PiwCbWoukxqAAOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AAmE3c3+n25kyr0kj2384rxbMHyRvuOYiLz94i1PPVkm1/zobWW02HzeOIA/k9x0fuIwZK2RLCttddB7P7aLlfi0dIQI1L0kEPXbAlnFQQXBXWEfgadM4lM/BBuLfaMqVKRzxn3BiYBNTSE/9NDMTrZtnV9F912NtNNW+vEM2+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WfmbV41FjzpTBS;
	Thu,  8 Aug 2024 20:30:30 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 48E351800A1;
	Thu,  8 Aug 2024 20:31:42 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 8 Aug 2024 20:31:40 +0800
Message-ID: <ef7b6889-7e15-1ff3-c7a5-b3c6dabb13d4@huawei.com>
Date: Thu, 8 Aug 2024 20:31:40 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] uprobes: Improve scalability by reducing the contention
 on siglock
To: Oleg Nesterov <oleg@redhat.com>
CC: <mhiramat@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <kan.liang@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-perf-users@vger.kernel.org>, <bpf@vger.kernel.org>, Andrii Nakryiko
	<andrii@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt
	<rostedt@goodmis.org>, <paulmck@kernel.org>
References: <20240801082407.1618451-1-liaochang1@huawei.com>
 <20240801140639.GE4038@redhat.com>
 <51a756b7-3c2f-9aeb-1418-b38b74108ee6@huawei.com>
 <20240802092406.GC12343@redhat.com>
 <0c69ef28-26d8-4b6e-fa78-2211a7b84eca@huawei.com>
 <20240806172529.GC20881@redhat.com> <20240807101746.GA27715@redhat.com>
 <3bb87fb4-c32e-0a35-0e93-5e1971fe8268@huawei.com>
 <20240808102837.GC8020@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240808102837.GC8020@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/8/8 18:28, Oleg Nesterov 写道:
> On 08/08, Liao, Chang wrote:
>>
>>   - pre_ssout() resets the deny signal flag
>>
>>   - uprobe_deny_signal() sets the deny signal flag when TIF_SIGPENDING is cleared.
>>
>>   - handle_singlestep() check the deny signal flag and restore TIF_SIGPENDING if necessary.
>>
>> Does this approach look correct to you,do do you have any other way to implement the "flag"?
> 
> Yes. But I don't think pre_ssout() needs to clear this flag. handle_singlestep() resets/clears
> state, active_uprobe, frees insn slot. So I guess we only need
> 
> 
> --- x/kernel/events/uprobes.c
> +++ x/kernel/events/uprobes.c
> @@ -2308,9 +2308,10 @@ static void handle_singlestep(struct upr
>  	utask->state = UTASK_RUNNING;
>  	xol_free_insn_slot(current);
>  
> -	spin_lock_irq(&current->sighand->siglock);
> -	recalc_sigpending(); /* see uprobe_deny_signal() */
> -	spin_unlock_irq(&current->sighand->siglock);
> +	if (utask->xxx) {
> +		set_thread_flag(TIF_SIGPENDING);
> +		utask->xxx = 0;
> +	}

Agree, if no more discussion about this flag, I will just send v2 today.

Thanks.

>  
>  	if (unlikely(err)) {
>  		uprobe_warn(current, "execute the probed insn, sending SIGILL.");
> 
> and that is all.
> 
> Oleg.
> 
> 

-- 
BR
Liao, Chang

