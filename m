Return-Path: <bpf+bounces-21521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E726184E7C1
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36488B224EA
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555491CD2E;
	Thu,  8 Feb 2024 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZFE6ImEV"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9408C1A
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417367; cv=none; b=f8nY4BykougFK4LWVxvu9UGsCy/Se6wau65yfxFT8Usv+OEUuT/4Xd0fudZyg9PfixvScs0lMalWTBCR/o7V+mE+qtaRJ/ngceJEE/+NIegPp//9ONxT0FzLqShcrq/6AJx4rFLyqjXRj+hQEeP1Sts0tGdckXdO8GIUYCbBylg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417367; c=relaxed/simple;
	bh=owANP3D9CUpnE0Ti9oPGA9WoK7MEvikNfoSfw2nFNes=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AKf+MhkUURFzfS6NR8V/96YAwltQwhtwaXHr6jyRG+OAmgLbf40bw/Sh/mRElhSLo2149WumzzyFQxJCOVfCSJ0zyEGm8F8H7GXWsL4yA3h7kQiLDmr0Ns5HAH/uPjGZ0ST+2Bi24CaiCan2VLCeh6ssGfSaqzqzu6UNVlAgifg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZFE6ImEV; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <514b171d-8a3c-4134-a0b4-9b6531b3fc38@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707417363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HHcFqN1Ab8TrTT2/gFsWybDz7sx8v/hlmJP9MiQezec=;
	b=ZFE6ImEV9Zcb3EWonTNqvNLjbXqWNiyE6FFUZGksDBmjIxV6C7dvj7SO2DrHuhBrfwPt8u
	bmdLumO6ro1YsyMS/lCnxYlQmcSfR168qQkrWivE9tXob6kWp/ssv0EEkIbPfD5gqKocyg
	gO1EzsuFAX+XncGHXmyKIAmBoUp2eUg=
Date: Thu, 8 Feb 2024 10:35:55 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, david.faust@oracle.com,
 cupertino.miranda@oracle.com
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
 <c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev> <87h6ijfayj.fsf@oracle.com>
 <87wmrfdsk7.fsf@oracle.com>
 <4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
 <87o7crdmjn.fsf@oracle.com>
 <eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
 <87il2zdl43.fsf@oracle.com>
 <7d2b05bf2e7ae7c95807ac4b2a9664f203facbfe.camel@gmail.com>
 <871q9mew62.fsf@oracle.com> <8297be08-cd05-4f08-8bb2-5956f13bbd25@linux.dev>
In-Reply-To: <8297be08-cd05-4f08-8bb2-5956f13bbd25@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/8/24 10:04 AM, Yonghong Song wrote:
>
> On 2/8/24 8:51 AM, Jose E. Marchesi wrote:
>>> On Thu, 2024-02-08 at 16:35 +0100, Jose E. Marchesi wrote:
>>> [...]
>>>
>>>> If the compiler generates assembly code the same code for 
>>>> profile2.c for
>>>> before and after, that means that the loop does _not_ get unrolled 
>>>> when
>>>> profiler.inc.h is built with -O2 but without #pragma unroll.
>>>>
>>>> But what if #pragma unroll is used?  If it unrolls then, that would 
>>>> mean
>>>> that the pragma does something more than -funroll-loops/-O2.
>>>>
>>>> Sorry if I am not making sense.  Stuff like this confuses me to no end
>>>> ;)
>>> Sorry, I messed up while switching branches :(
>>> Here are the correct stats:
>>>
>>> | File            | insn # | insn # |
>>> |                 | before |  after |
>>> |-----------------+--------+--------|
>>> | profiler1.bpf.o |  16716 |   4813 |
>> This means:
>>
>> - With both `#pragma unroll' and -O2 we get 16716 instructions.
>> - Without `#pragma unroll' and with -O2 we get 4813 instructions.
>>
>> Weird.
>
> Thanks for the analysis. I can reproduce with vs. without '#pragma 
> unroll' at -O2
> level, the number of generated insns is indeed different, quite 
> dramatically
> as the above numbers. I will do some checking in compiler.

Okay, a quick checking compiler found that
   - with "#pragma unroll" means no profitability test and do full unroll as instructed
   - without "#pragma unroll" mean compiler will do profitability for full unroll,
     if compiler thinks full unroll is not profitable, there will be no unrolling.

So for gcc, even users saying '#pragma unroll', gcc still do profitability test?

>
>>
>>> | profiler2.bpf.o |   2088 |   2050 |
>> - Without `#pragma unroll' and with -O2 we get 2088 instructions.
>> - With `#pragma loop unroll(disable)' and with -O2 we get 2050
>>    instructions.
>>
>> Also surprising.
>>
>>> | profiler3.bpf.o |   4465 |   1690 |
>

