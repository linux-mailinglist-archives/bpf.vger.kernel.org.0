Return-Path: <bpf+bounces-70872-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 918B0BD7734
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 07:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC12D18A17AB
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 05:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B43628727C;
	Tue, 14 Oct 2025 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P+cxWsPr"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF33273D77
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 05:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760420232; cv=none; b=BdrPuSSbv4hqg5gL2XbodHRFssWJs8H68pye/ZTmPhdezZfTSCKJ/lcs41RDc8NvkYTVY/PO4jGQkIsT222b65BYDzmSrfQa/6As6F8LG4NnpZb2ZeAtJ8kiVTLCD2jPQB2dJLg9BIqS4jx6LPateXIS/SnGSZgdyCTjc52+/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760420232; c=relaxed/simple;
	bh=x6f619sWjWn8VzR+PJyJZc3YLAUI5y2rgeIbQboasNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PWEJJKOJsOQBKjavvQc5MRphOTFN/DGiqmj0t+yqZbbs3VZmH6SnSy85/lwGDVEUN0QrtGDG8BRt4+PJ7up1WFdQ/dH7maU4ENXuqTY5zXDlT8MwsWGh6EpEo50ioxYhQp8cQTcwdj2F4DpSCesS1RwAHP65T1nAPtAUH5+cVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P+cxWsPr; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb3b054b-3c21-4941-800c-4519cae9ce31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760420215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B1m+mNsKlXTM+cfL7n8n0pJBlEVyu9KaA8E5Nvi8xzQ=;
	b=P+cxWsPrR4uWAHtXtXn+Bi9cCf33CTn6ApZExfCCLB+HQpWVnEV7yH6SO2m5PpIoKrp6a2
	+qMZ0VxHsgFVJNVuwkqdFXjjLVSmeLukXKSIkBpoNzjLGcox7HYE9TG3+j5/UO2s/0Ryo0
	baWxsb3QfXHLseF5VDnx8l5os/2u4Q8=
Date: Tue, 14 Oct 2025 13:36:44 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next RFC 0/2] Pass external callchain entry to
 get_perf_callchain
To: Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <olsajiri@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, song@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
References: <20251013174721.2681091-1-chen.dylane@linux.dev>
 <aO1j747N7pkBTBAb@krava> <3cf98c31-4475-4e4a-8ce0-bc9c62922313@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Tao Chen <chen.dylane@linux.dev>
In-Reply-To: <3cf98c31-4475-4e4a-8ce0-bc9c62922313@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/10/14 05:37, Yonghong Song 写道:
> 
> 
> On 10/13/25 1:41 PM, Jiri Olsa wrote:
>> On Tue, Oct 14, 2025 at 01:47:19AM +0800, Tao Chen wrote:
>>> Background
>>> ==========
>>> Alexei noted we should use preempt_disable to protect get_perf_callchain
>>> in bpf stackmap.
>>> https://lore.kernel.org/bpf/CAADnVQ+s8B7-fvR1TNO- 
>>> bniSyKv57cH_ihRszmZV7pQDyV=VDQ@mail.gmail.com
>>>
>>> A previous patch was submitted to attempt fixing this issue. And Andrii
>>> suggested teach get_perf_callchain to let us pass that buffer 
>>> directly to
>>> avoid that unnecessary copy.
>>> https://lore.kernel.org/bpf/20250926153952.1661146-1- 
>>> chen.dylane@linux.dev
>>>
>>> Proposed Solution
>>> =================
>>> Add external perf_callchain_entry parameter for get_perf_callchain to
>>> allow us to use external buffer from BPF side. The biggest advantage is
>>> that it can reduce unnecessary copies.
>>>
>>> Todo
>>> ====
>>> If the above changes are reasonable, it seems that 
>>> get_callchain_entry_for_task
>>> could also use an external perf_callchain_entry.
>>>
>>> But I'm not sure if this modification is appropriate. After all, the
>>> implementation of get_callchain_entry in the perf subsystem seems 
>>> much more
>>> complex than directly using an external buffer.
>>>
>>> Comments and suggestions are always welcome.
>>>
>>> Tao Chen (2):
>>>    perf: Use extern perf_callchain_entry for get_perf_callchain
>>>    bpf: Pass external callchain entry to get_perf_callchain
>> hi,
>> I can't get this applied on bpf-next/master, what do I miss?
> 
> This path is not based on top of latest bpf/bpf-next tree.
> The current diff:
> 
>   struct perf_callchain_entry *
> -get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool 
> user,
> -           u32 max_stack, bool crosstask, bool add_mark)
> +get_perf_callchain(struct pt_regs *regs, struct perf_callchain_entry 
> *external_entry,
> +           u32 init_nr, bool kernel, bool user, u32 max_stack, bool 
> crosstask,
> +           bool add_mark)
>   {
> 
> The actual signature in kernel/events/callchain.c
> 
> struct perf_callchain_entry *
> get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
>                     u32 max_stack, bool crosstask, bool add_mark)
> {
> 
> 
>>
>> thanks,
>> jirka
>>
>>
>>>   include/linux/perf_event.h |  5 +++--
>>>   kernel/bpf/stackmap.c      | 19 +++++++++++--------
>>>   kernel/events/callchain.c  | 18 ++++++++++++------
>>>   kernel/events/core.c       |  2 +-
>>>   4 files changed, 27 insertions(+), 17 deletions(-)
>>>
>>> -- 
>>> 2.48.1
>>>
> 

My mistake. I’ll update the code and resend it.

-- 
Best Regards
Tao Chen

