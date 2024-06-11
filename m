Return-Path: <bpf+bounces-31765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3271902E19
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 03:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FCD1C21F1B
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 01:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAFCAD2D;
	Tue, 11 Jun 2024 01:57:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E863CB;
	Tue, 11 Jun 2024 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071023; cv=none; b=Z907CJdFthD0qGWfeTnMGtHdJyNgEUxskdVBi+lv6GyDnlrSrLui/9TL+JCqAJ9lzwQJ7P1cbH47NIZMX2jPtVWZugYokpLmyyhCqHe8gW1LLK7tK9ZGtR8XSJTA5eAsewOU2DNJS3ork0U/u2qRRphLTH/OXICttNOsjN6jrRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071023; c=relaxed/simple;
	bh=Rqwz1rMtbocjuzkpdlY14SlJ71M96bYi5eunpDJIidM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jAaa7Y4ZOnK26Ary57ilme0YtlV4wsrJqT1+opQ6vQd/sLpoxVs5do6ebLOKlBgM0LLGvpuKUW0Q78CXPkSshGEnKt08WSD/kH/qYBaRKcmQ5Uk/Xh7dz4jYLwnDvlts9eEE4T8v/Lt1ekbUvIPkFGrkwFctxEfQd2xDauje1Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VysBm5mRNz1X3Rt;
	Tue, 11 Jun 2024 09:53:04 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 813711A0190;
	Tue, 11 Jun 2024 09:56:51 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 09:56:51 +0800
Message-ID: <57e499a4-e26d-148f-317d-233e873d11b4@huawei.com>
Date: Tue, 11 Jun 2024 09:56:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH] ftrace: Skip __fentry__ location of overridden weak
 functions
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: <rostedt@goodmis.org>, <mcgrof@kernel.org>, <mhiramat@kernel.org>,
	<mark.rutland@arm.com>, <mathieu.desnoyers@efficios.com>,
	<jpoimboe@kernel.org>, <linux-modules@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>
References: <20240607115211.734845-1-zhengyejian1@huawei.com>
 <20240607150228.GR8774@noisy.programming.kicks-ass.net>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20240607150228.GR8774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)

On 2024/6/7 23:02, Peter Zijlstra wrote:
> On Fri, Jun 07, 2024 at 07:52:11PM +0800, Zheng Yejian wrote:
>> ftrace_location() was changed to not only return the __fentry__ location
>> when called for the __fentry__ location, but also when called for the
>> sym+0 location after commit aebfd12521d9 ("x86/ibt,ftrace: Search for
>> __fentry__ location"). That is, if sym+0 location is not __fentry__,
>> ftrace_location() would find one over the entire size of the sym.
>>
>> However, there is case that more than one __fentry__ exist in the sym
>> range (described below) and ftrace_location() would find wrong __fentry__
>> location by binary searching, which would cause its users like livepatch/
>> kprobe/bpf to not work properly on this sym!
>>
>> The case is that, based on current compiler behavior, suppose:
>>   - function A is followed by weak function B1 in same binary file;
>>   - weak function B1 is overridden by function B2;
>> Then in the final binary file:
>>   - symbol B1 will be removed from symbol table while its instructions are
>>     not removed;
>>   - __fentry__ of B1 will be still in __mcount_loc table;
>>   - function size of A is computed by substracting the symbol address of
>>     A from its next symbol address (see kallsyms_lookup_size_offset()),
>>     but because symbol info of B1 is removed, the next symbol of A is
>>     originally the next symbol of B1. See following example, function
>>     sizeof A will be (symbol_address_C - symbol_address_A):
>>
>>       symbol_address_A
>>       symbol_address_B1 (Not in symbol table)
>>       symbol_address_C
>>
>> The weak function issue has been discovered in commit b39181f7c690
>> ("ftrace: Add FTRACE_MCOUNT_MAX_OFFSET to avoid adding weak function")
>> but it didn't resolve the issue in ftrace_location().
>>
>> There may be following resolutions:
> 
> Oh gawd, sodding weak functions again.
> 
> I would suggest changing scipts/kallsyms.c to emit readily identifiable
> symbol names for all the weak junk, eg:
> 
>    __weak_junk_NNNNN
> 

Sorry for the late reply, I just had a long noon holiday :>

scripts/kallsyms.c is compiled and used to handle symbols in vmlinux.o
or vmlinux.a, see kallsyms_step() in scripts/link-vmlinux.sh, those
overridden weak symbols has been removed from symbol table of vmlinux.o
or vmlinux.a. But we can found those symbols from original xx/xx.o file,
for example, the weak free_initmem() in in init/main.c is overridden,
its symbol is not in vmlinx but is still in init/main.o .

How about traversing all origin xx/xx.o and finding all weak junk symbols ?

> That instantly fixes the immediate problem and Steve's horrid hack can
> go away.
> 

Yes, this can be done in same patch series.

> Additionally, I would add a boot up pass that would INT3 fill all such
> functions and remove/invalidate all
> static_call/static_jump/fentry/alternative entry that is inside of them.
> 
> 
> 

--

Thanks,
Zheng Yejian

