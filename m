Return-Path: <bpf+bounces-21534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8224784E91A
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166F31F313B1
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D5A381D9;
	Thu,  8 Feb 2024 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RzVmuChS"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B538385
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421511; cv=none; b=NqXKN3s6NSilSvgTTFUfCuElxAYoNZ82gIkeql/9zPVUH+0cD2hH6OjfTXlW8n5ixZybmql13Ic5zaexWb1pJgJ54TfrIK0JOgwhIvNvUYiZy6ovLkbF2yjenY/uUvGaBW+pkh7wG/kWfFX0mBhjLxjWLz2fhNhVAVwe5RKXwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421511; c=relaxed/simple;
	bh=csAhjerKkvLYTsThIdGULRmcEFeLAE1qFXGl4mzQ1T4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+a5LJJHn9qEFccEoJhMuazMwHcUq3PCLo6f5YZo4HaDUKsCBxYuI2CukL3mBel+0xhhG8qvBXXjc/xYC1kytBHuRZ3/xC0Ry9yC8dc81C4a6S+h/3t+WA2o2mhnDrO9t9njhrUu9mS0HUkdRk8lcYGjUbPYS/rW21ZMAoMXg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RzVmuChS; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <005d58f9-77da-48bf-b13b-7e40a1f933c3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707421503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bSFRjs7/iDDkejEtv6YEV/IpJuo1Fwdjx93qplEY9L4=;
	b=RzVmuChShXtZx+n9flfwe/qbKNGGlWG0FjyBdIpLcQN+HfdzvVSpUh6CjTXUsj2CbkTwxl
	LfWXXxaTCSyobrbIUk3cp2uPXCzP7qHLUwFeWvF0tAAjK1i/ZGjRxDEMLC3NUNAIoGkEEP
	gO1FCCyy46VpMMVs4vqnQMV2Y1+sl5c=
Date: Thu, 8 Feb 2024 11:44:57 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
Content-Language: en-GB
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 Yonghong Song <yhs@meta.com>,
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
 <514b171d-8a3c-4134-a0b4-9b6531b3fc38@linux.dev> <87a5oadboq.fsf@oracle.com>
 <875xyydbir.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <875xyydbir.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/8/24 11:03 AM, Jose E. Marchesi wrote:
>>> On 2/8/24 10:04 AM, Yonghong Song wrote:
>>>> On 2/8/24 8:51 AM, Jose E. Marchesi wrote:
>>>>>> On Thu, 2024-02-08 at 16:35 +0100, Jose E. Marchesi wrote:
>>>>>> [...]
>>>>>>
>>>>>>> If the compiler generates assembly code the same code for
>>>>>>> profile2.c for
>>>>>>> before and after, that means that the loop does _not_ get
>>>>>>> unrolled when
>>>>>>> profiler.inc.h is built with -O2 but without #pragma unroll.
>>>>>>>
>>>>>>> But what if #pragma unroll is used?  If it unrolls then, that
>>>>>>> would mean
>>>>>>> that the pragma does something more than -funroll-loops/-O2.
>>>>>>>
>>>>>>> Sorry if I am not making sense.  Stuff like this confuses me to no end
>>>>>>> ;)
>>>>>> Sorry, I messed up while switching branches :(
>>>>>> Here are the correct stats:
>>>>>>
>>>>>> | File            | insn # | insn # |
>>>>>> |                 | before |  after |
>>>>>> |-----------------+--------+--------|
>>>>>> | profiler1.bpf.o |  16716 |   4813 |
>>>>> This means:
>>>>>
>>>>> - With both `#pragma unroll' and -O2 we get 16716 instructions.
>>>>> - Without `#pragma unroll' and with -O2 we get 4813 instructions.
>>>>>
>>>>> Weird.
>>>> Thanks for the analysis. I can reproduce with vs. without '#pragma
>>>> unroll' at -O2
>>>> level, the number of generated insns is indeed different, quite
>>>> dramatically
>>>> as the above numbers. I will do some checking in compiler.
>>> Okay, a quick checking compiler found that
>>>    - with "#pragma unroll" means no profitability test and do full
>>>     unroll as instructed
>>
>> I don't think clang's `#pragma unroll' does full unroll.
>>
>> On one side, AFAIK `pragma unroll' is supposed to be equivalent to
>> `pragma clang loop(enable)', which is different to `pragma clang loop
>> unroll(full)'.
>>
>> On the other, if you replace `pragma unroll' with `pragma clang loop
>> unroll(full)' in the BPF selftests you will get branch instruction
>> overflows.

You are correct. I did series of examples, and find with "#pragma unroll",
clang may do:
   - full unroll (smaller body, less trip count), or
     Loop Unroll: F[kprobe__proc_sys_write] Loop %for.body.i
       Loop Size = 40
       Exiting block %if.then23.i: TripCount=0, TripMultiple=1, BreakoutTrip=1
       Exiting block %for.inc.i: TripCount=10, TripMultiple=0, BreakoutTrip=0
     COMPLETELY UNROLLING loop %for.body.i with trip count 10!
   - partial unroll (for a loop with trip count 10000000), or
     Loop Unroll: F[foo] Loop %for.body
       Loop Size = 16
       partially unrolling with count: 1000
       Exiting block %for.body: TripCount=10000000, TripMultiple=0, BreakoutTrip=0
     UNROLLING loop %for.body by 1000!
   - no unrolling (for a loop with huge body) and issue warning like
     t.c:2:5: warning: loop not unrolled: the optimizer was unable to perform the requested transformation; the transformation
     might be disabled or specified as part of an unsupported transformation ordering [-Wpass-failed=transform-warning]

With '#pragma unroll', the compiler will do (more strict?) profitability analysis and looks like
by default will not do partial inlining:

   Loop Unroll: F[kprobe__proc_sys_write] Loop %for.body.i
     Loop Size = 40
   Starting LoopUnroll profitability analysis...
    Analyzing iteration 0
   Adding cost of instruction (iteration 0):   call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %__r15.i) #7, !dbg !30496
   Adding cost of instruction (iteration 0):   call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %__t16.i) #7, !dbg !30497
   Adding cost of instruction (iteration 0):   %67 = call ptr @llvm.bpf.passthrough.p0.p0(i32 38, ptr %66)
   Adding cost of instruction (iteration 0):   %66 = getelementptr i8, ptr %17, i64 %65
   Adding cost of instruction (iteration 0):   %65 = load i64, ptr @"llvm.task_struct:0:4656$0:171", align 8
   Can't analyze cost of loop with call
     will not try to unroll partially because -unroll-allow-partial not given

>>
>> What criteria `pragma unroll' in clang uses in order to determine how
>> much it unrolls the loop, compared to -O2|-funroll-loops, I don't know.

There are some heuristics in the compiler. I do not know exact algorithm
either.

> This makes me wonder, asking from ignorance: what is the benefit/point
> for BPF programs to partially unroll a loop?  I would have said either
> we unroll them completely in order to avoid verification problems, or we
> don't unroll them because the verifier is supposed to handle it the way
> it is written...

In early days, partial unrolling probably for better performance but
complete unrolling may exceed insn limit 4K. Later on the insn limit
is increased....

Anyway, I think you patch looks good based on current discussion.
I will ack it.

>
>>>    - without "#pragma unroll" mean compiler will do profitability for full unroll,
>>>      if compiler thinks full unroll is not profitable, there will be no unrolling.
>>>
>>> So for gcc, even users saying '#pragma unroll', gcc still do
>>> profitability test?
>> GCC doesn't support `#pragma unroll'.
>>
>> Hence in my original patch the macro __pragma_unroll expands to nothing
>> with GCC.  That will lead to the compiler perhaps not unrolling the loop
>> even with -O2|-funroll-loops.
>>
>>>>>> | profiler2.bpf.o |   2088 |   2050 |
>>>>> - Without `#pragma unroll' and with -O2 we get 2088 instructions.
>>>>> - With `#pragma loop unroll(disable)' and with -O2 we get 2050
>>>>>     instructions.
>>>>>
>>>>> Also surprising.
>>>>>
>>>>>> | profiler3.bpf.o |   4465 |   1690 |

