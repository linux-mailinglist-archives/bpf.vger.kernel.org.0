Return-Path: <bpf+bounces-36185-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C2943953
	for <lists+bpf@lfdr.de>; Thu,  1 Aug 2024 01:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11534283824
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 23:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5436D16D334;
	Wed, 31 Jul 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BCeXyPyx"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD03A1A8
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 23:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722467868; cv=none; b=T6rwj8vbiamuvNudlZX599kNj0zDt1jlR+q9KLYZmxYL6aP86bi1Ib8W5Sq/Bz9gbbWC5Riv49WT8KSSvpN/bpTVFYw/uVxRMcg4RwveNfYmyX8DjBXsah8AYh9quLXFP88IEF/IQba8mEgenOabTSX3Emf349RGIgwADOnZhCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722467868; c=relaxed/simple;
	bh=Tvaw7pZJhtEPVYtiDZ4Mykw4mkdqulqvKUs162ane8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=utalg9XntnVmyYlUSw1KQPx+Wvp8CJkytl2fOrHvQPp1x3bxHBC4czFfWPu9oJQfoHfvHvjbqA+WbdRFJgfk9QgZma325OyNKV6d1ZpQWpGx7ZX73u1Q+cjikXuCMCF5ULlJLh0Lve+8s+RBrsiBUYdFc35dPIC17jJERmN07RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BCeXyPyx; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7a658007-31d8-4725-bdea-e8abdde7ce50@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722467864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLw2WIPcBJ27+CQSjNJi2njegZnKUdoSM0ZpxUYDscY=;
	b=BCeXyPyxkP5BNIOwGm7rMVcXfsr6YKC1EUWTsqh6ur+CAtCk842DACj+JIt+CE2VAeiHcb
	0Fb2vmrFeznjv+SNX3GeNMaN0YlFTKMjunXUUYKbmT7ds1iRl/tZLf5Q0hqwHSLdR2so0+
	OgbTswXF2CwJ89LmUxWkNQil+7VqBj4=
Date: Wed, 31 Jul 2024 16:17:36 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Supporting New Memory Barrier Types in BPF
Content-Language: en-GB
To: Peilin Ye <yepeilin@google.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 "Jose E. Marchesi" <jemarch@gnu.org>, bpf <bpf@vger.kernel.org>,
 Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
 Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, David Vernet <dvernet@meta.com>,
 Dave Marchevsky <davemarchevsky@meta.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
 <CAADnVQLLjPe3cnb7RSqHHVAP=4W1mbwTz1OFKq51=TR0utyaJQ@mail.gmail.com>
 <87c8159d-602b-470c-a46c-87f5fd853a23@linux.dev>
 <ZqqiQQWRnz7H93Hc@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZqqiQQWRnz7H93Hc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/31/24 1:44 PM, Peilin Ye wrote:
> Hi Alexei, Yonghong,
>
> On Tue, Jul 30, 2024 at 08:51:15PM -0700, Yonghong Song wrote:
>>>>> This sounds like a compiler bug.
>>>>>
>>>>> Yonghong, Jose,
>>>>> do you know what compilers do for other backends?
>>>>> Is it allowed to convert sycn_fetch_add into sync_add when fetch part is unused?
>>>> This behavior is introduced by the following llvm commit:
>>>> https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d07aa4ca74488615744
>>>>
>>>> Specifically the following commit message:
>>>>
>>>> =======
>>>> Similar to xadd, atomic xadd, xor and xxor (atomic_<op>)
>>>> instructions are added for atomic operations which do not
>>>> have return values. LLVM will check the return value for
>>>> __sync_fetch_and_{add,and,or,xor}.
>>>> If the return value is used, instructions atomic_fetch_<op>
>>>> will be used. Otherwise, atomic_<op> instructions will be used.
>>> So it's a bpf backend bug. Great. That's fixable.
>>> Would have been much harder if this transformation was performed
>>> by the middle end.
>>>
>>>> ======
>>>>
>>>> Basically, if no return value, __sync_fetch_and_add() will use
>>>> xadd insn. The decision is made at that time to maintain backward compatibility.
>>>> For one example, in bcc
>>>>      https://github.com/iovisor/bcc/blob/master/src/cc/export/helpers.h#L1444
>>>> we have
>>>>      #define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
>>>>
>>>> Should we use atomic_fetch_*() always regardless of whether the return
>>>> val is used or not? Probably, it should still work. Not sure what gcc
>>>> does for this case.
>>> Right. We did it for backward compat. Older llvm was
>>> completely wrong to generate xadd for __sync_fetch_and_add.
>>> That was my hack from 10 years ago when xadd was all we had.
>>> So we fixed that old llvm bug, but introduced another with all
>>> good intentions.
>>> Since proper atomic insns were introduced 3 years ago we should
>>> remove this backward compat feature/bug from llvm.
>>> The only breakage is for kernels older than 5.12.
>>> I think that's an acceptable risk.
>> Sounds good, I will remove the backward compat part in llvm20.
> Thanks for confirming!  Would you mind if I fix it myself?  It may
> affect some of the BPF code that we will be running on ARM, so we would
> like to get it fixed sooner.  Also, I would love to gain some
> experience in LLVM development!

Peilin, when I saw your email, I have almost done with the change.
The below is the llvm patch:
   https://github.com/llvm/llvm-project/pull/101428

Please help take a look. You are certainly welcome to do llvm
related work. Just respond earlier to mention you intend to do
a particular llvm patch and we are happy for you to contribute
and will help when you have any questions.

>
> Thanks,
> Peilin Ye
>

