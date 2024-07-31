Return-Path: <bpf+bounces-36113-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84069942530
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 05:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715A31C210E4
	for <lists+bpf@lfdr.de>; Wed, 31 Jul 2024 03:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79E1805E;
	Wed, 31 Jul 2024 03:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BpuDEK/C"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5DAC8FF
	for <bpf@vger.kernel.org>; Wed, 31 Jul 2024 03:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722397888; cv=none; b=dfsB2NOqgKil6F/Xkbg5jJJ2rPLxuOdMGXeyoMdbw90+zSlaqAyeAOsXfEaala5rPyBViSNP9U569qRsmPuzkMNrbUvZBGXMmfKnl/XozcfRZMlW9jqp8wbj8mbCYOJrs51WTAuoVRRh+ZPCq0mLnzd9uasj4O73LD+i/H12E6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722397888; c=relaxed/simple;
	bh=UCGAJ+G9HCF86ot0B6UOgtzTEsIP+HbRmg/e2h58EQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zqe4YL0tuA342SH7pUJQt6nZNpHpGh39JYyc4e6EJSrw99zAGDT/qiVik7/AHjsOaG4wy8PSouciRRRbAMtrrgVVefCCwLzhWZWtdm8u0irqsM7oKS5n5E6/NvWXe5hDosBcNx7l2yo6qybZJqHqd0f9n6jwDdFfOBSohlTeHT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BpuDEK/C; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87c8159d-602b-470c-a46c-87f5fd853a23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722397883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wddVJE6yg8ZM2Ychzsa/9DJQpIFvARs3avpyUCFRhr4=;
	b=BpuDEK/CDjfQQc7y1iz+BzDva+CE4lCDVcrrm51DJ6qCUicrBmnzeufwMGB9IAQIuDLtSr
	GSw4JqaebJce251Hf8AA++tO2Br9UjZ79RUGj0xzZj2d20Yd0MyKrfIxMv1O6SC9zrGEDp
	OK/ucjLsX8chuT8kEZCs+GicbyM6dxM=
Date: Tue, 30 Jul 2024 20:51:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Supporting New Memory Barrier Types in BPF
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Peilin Ye <yepeilin@google.com>, "Jose E. Marchesi" <jemarch@gnu.org>,
 bpf <bpf@vger.kernel.org>, Josh Don <joshdon@google.com>,
 Barret Rhoden <brho@google.com>, Neel Natu <neelnatu@google.com>,
 Benjamin Segall <bsegall@google.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 David Vernet <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>
References: <20240729183246.4110549-1-yepeilin@google.com>
 <CAADnVQJqGzH+iT9M8ajT62H9+kAw1RXAdB42G3pvcLKPVmy8tg@mail.gmail.com>
 <24b57380-c829-4033-a7b1-06a4ed413a49@linux.dev>
 <CAADnVQLLjPe3cnb7RSqHHVAP=4W1mbwTz1OFKq51=TR0utyaJQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLLjPe3cnb7RSqHHVAP=4W1mbwTz1OFKq51=TR0utyaJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/30/24 6:19 PM, Alexei Starovoitov wrote:
> On Mon, Jul 29, 2024 at 10:14 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>> This sounds like a compiler bug.
>>>
>>> Yonghong, Jose,
>>> do you know what compilers do for other backends?
>>> Is it allowed to convert sycn_fetch_add into sync_add when fetch part is unused?
>> This behavior is introduced by the following llvm commit:
>> https://github.com/llvm/llvm-project/commit/286daafd65129228e08a1d07aa4ca74488615744
>>
>> Specifically the following commit message:
>>
>> =======
>> Similar to xadd, atomic xadd, xor and xxor (atomic_<op>)
>> instructions are added for atomic operations which do not
>> have return values. LLVM will check the return value for
>> __sync_fetch_and_{add,and,or,xor}.
>> If the return value is used, instructions atomic_fetch_<op>
>> will be used. Otherwise, atomic_<op> instructions will be used.
> So it's a bpf backend bug. Great. That's fixable.
> Would have been much harder if this transformation was performed
> by the middle end.
>
>> ======
>>
>> Basically, if no return value, __sync_fetch_and_add() will use
>> xadd insn. The decision is made at that time to maintain backward compatibility.
>> For one example, in bcc
>>     https://github.com/iovisor/bcc/blob/master/src/cc/export/helpers.h#L1444
>> we have
>>     #define lock_xadd(ptr, val) ((void)__sync_fetch_and_add(ptr, val))
>>
>> Should we use atomic_fetch_*() always regardless of whether the return
>> val is used or not? Probably, it should still work. Not sure what gcc
>> does for this case.
> Right. We did it for backward compat. Older llvm was
> completely wrong to generate xadd for __sync_fetch_and_add.
> That was my hack from 10 years ago when xadd was all we had.
> So we fixed that old llvm bug, but introduced another with all
> good intentions.
> Since proper atomic insns were introduced 3 years ago we should
> remove this backward compat feature/bug from llvm.
> The only breakage is for kernels older than 5.12.
> I think that's an acceptable risk.

Sounds good, I will remove the backward compat part in llvm20.


