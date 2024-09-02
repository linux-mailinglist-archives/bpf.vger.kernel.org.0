Return-Path: <bpf+bounces-38726-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7746F968D11
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 20:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECCA9B21AFB
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 18:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717341C62AE;
	Mon,  2 Sep 2024 18:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GTBDNHj7"
X-Original-To: bpf@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5080514287;
	Mon,  2 Sep 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725300506; cv=none; b=iGalV3Dj4YfFhahYV92a8D8ZrkqUv4x1WCyBVahrJXtIGCEAUmso3GpSBNcqZzh17aecn9FXwCmeYopk1Svk6x4bdAOGSYlpqgfKD3rClJlLqLfAyLGBWYPCxFdnRY15DX6fZ+mtxPjz4Zy70Wo39Woa6+9kYSE827+MdHnhZxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725300506; c=relaxed/simple;
	bh=0W12QeDYJ7tLn/TygJCk1LuRNBEti1l/SOkQQI1YJSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtWJcXUO2bW1QsJxFFNtYsYtW1jyfAXUaxv9YH3CdmwSOrHW1p+IObR4/0JOPp/J39C26g8JnyuTdY6gjHxp5QUCWyet+g6YD7f8RpFA/1w77k1LdZ4WI/ekkN8e009lwlFLxFEKOuR78am0WDeousATs4TFTuOzi4l17EwFq7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=GTBDNHj7; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725300501;
	bh=0W12QeDYJ7tLn/TygJCk1LuRNBEti1l/SOkQQI1YJSM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GTBDNHj7ZuFQ96r3dvGy4U+GSTV7lSg3/ToCYYvxelNqBuzMCu8v+i+D4lza96DWc
	 ikHwdpexy4525OjvIJYOR2Oo/TLPp4UwasFueDmAY7SqNRK2APHBy+d2NdLr0Kn/bD
	 7k1BCfydKVtYX3l/95RUV58oBaOX+6LJbLwOpWaAaaREPOMUINvv2A7mhc2ICeMiWs
	 vYkqc8V7cLWLpEMGCkZs/2nbMBCY11oMUJDT01FWPNqDQxOruCGI2n0v9jHwjNHiKH
	 B52oi+GUy5XE1BWEtRLfzeLsiBAZSu12VNFMdycXKlrJE4P4Z6M7GN+zA8j8zyC31V
	 TQCK6+e8WAwOA==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WyGvn5Jq1z1K5h;
	Mon,  2 Sep 2024 14:08:21 -0400 (EDT)
Message-ID: <9de6ca8f-b3f1-4ebc-a5eb-185532e164e7@efficios.com>
Date: Mon, 2 Sep 2024 14:08:00 -0400
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] cleanup.h: Introduce DEFINE_INACTIVE_GUARD and
 activate_guard
To: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Sean Christopherson <seanjc@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Namhyung Kim <namhyung@kernel.org>, bpf@vger.kernel.org,
 Joel Fernandes <joel@joelfernandes.org>, linux-trace-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>
References: <20240828143719.828968-1-mathieu.desnoyers@efficios.com>
 <20240828143719.828968-3-mathieu.desnoyers@efficios.com>
 <20240902154334.GH4723@noisy.programming.kicks-ass.net>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240902154334.GH4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-09-02 11:43, Peter Zijlstra wrote:
> On Wed, Aug 28, 2024 at 10:37:19AM -0400, Mathieu Desnoyers wrote:
>> To cover scenarios where the scope of the guard differs from the scope
>> of its activation, introduce DEFINE_INACTIVE_GUARD() and activate_guard().
>>
>> Here is an example use for a conditionally activated guard variable:
>>
>> void func(bool a)
>> {
>> 	DEFINE_INACTIVE_GUARD(preempt_notrace, myguard);
>>
>> 	[...]
>> 	if (a) {
>> 		might_sleep();
>> 		activate_guard(preempt_notrace, myguard)();
>> 	}
>> 	[ protected code ]
>> }
> 
> So... I more or less proposed this much earlier:
> 
>    https://lore.kernel.org/all/20230919131038.GC39346@noisy.programming.kicks-ass.net/T/#mb7b84212619ac743dfe4d2cc81decce451586b27
> 
> and Linus took objection to similar patterns. But perhaps my naming
> wasn't right.

Then you suggested something like a "guard_if()":

https://lore.kernel.org/lkml/20231120221524.GD8262@noisy.programming.kicks-ass.net/

which I find really odd because it requires to evaluate the same
condition twice within the function if it is used as guard_if
expression and needed as expression within the rest of the function
flow. I find the original patch with labels and gotos less ugly
than the guard_if().

Hence my proposal to optionally separate the definition from the activation,
which nicely integrates with the existing code flow.

If Linus' objections were mainly about naming, perhaps what I am
suggestion here may be more to his liking ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


