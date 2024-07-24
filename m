Return-Path: <bpf+bounces-35544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5E593B644
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 19:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57206B2199E
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C71615F3FB;
	Wed, 24 Jul 2024 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bV5bDi2P"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D6C2E639
	for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721843781; cv=none; b=PrkmwYVJ46x/Fcm86dZNZspgqmGfubuNIlUb1ujnaXQNfCucFwuMnxf/dhzOL625wJK9UHKgEdubLFMvA9EteebAUXuwyWyjJvAd0IhyoyQH97sXAG1GErgbL8Ytco1rWPO7GfDesDKGKz6oUc9tzzNbTvMEVwDE+DWm2GIXEgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721843781; c=relaxed/simple;
	bh=rbynrB06lcoOwjoZQfKHyzHF22IWnkyiB1QX0ILYmzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q0gCantiohe3d/UApwvApGMD6bvCIl2HctajcMFhKe7VQrV5oKj521dQfUSTBFeTsWjVaD6Ng+J3IXTDWlqRXyzhiK6v9ZrxY8txTkZHpRa02KdxcOu/dmGwmK9gSMrxa4Kkb5j/Dg8Rp4yGxOugYTdn10jg4GGaLRCeksqxDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bV5bDi2P; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <af3644d7-0376-41ca-ae4e-34aa9a45fed6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721843774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VMXYftiiHXufmc4mITBGNNGA5f03qeitvxxBP3LY0U=;
	b=bV5bDi2P+KtPeEAwsoZn9YY4u/MfvG98PePG5tNtYXYBrycmNQVARx7F3AwuUoaDEJm7+H
	sWFcy/uZrZvRgmzOpWY5ycKarFPsf+AAloyT3bz7mib6ARIR85xAJCP3oOR2E+LyldSJU8
	vwoqNWlhfpJVAmYl/su1jhi5uslDgVc=
Date: Wed, 24 Jul 2024 10:56:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <CAEf4BzZUT9fWZrcXN-HVM=ce6thNBCL2RrZ3sTsdMkTzmk=gwQ@mail.gmail.com>
 <036e4320-1e22-4066-bfa5-42b1fa290a39@linux.dev>
 <f12db0b4-bcd4-4fb3-a0cf-35c96c2b549c@linux.dev>
 <CAADnVQLCk9Rccp3UPVzn3qrEzx1kPxqYv4QVWUpw1pSE1PHuZQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQLCk9Rccp3UPVzn3qrEzx1kPxqYv4QVWUpw1pSE1PHuZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 7/24/24 9:54 AM, Alexei Starovoitov wrote:
> On Tue, Jul 23, 2024 at 10:09 PM Yonghong Song <yonghong.song@linux.dev> wrote:
>>
>> Discussed with Andrii. I think the following approach should work.
>> For each non-static prog, the private stack is allocated including
>> that non-static prog and the called static progs. For example,
>>       main_prog
>>          static_prog_1
>>            static_prog_11
>>            global_prog
>>               static_prog_12
>>          static_prog_2
>>
>> So in verifier we calculate stack size for
>>       main_prog
>>          static_prog_1
>>             static_prog_11
>>          static_prog_2
>>    and
>>       global_prog
>>         static_prog_12
>>
>> Let us say the stack size for main_prog like below for each (sub)prog
>>       main_prog // stack size 100
>>          static_prog_1 // stack size 100
>>            static_prog_11 // stack size 100
>>          static_prog_2 // static size 100
>> so total static size is 300 so the private stack size will be 300.
>> So R9 is calculated like below
>>       main_prog
>>         R9 = ... // for tailcall reachable, R9 may be original R9 + offset
>>                  // for non-tailcall reachable, R9 equals the original R9 (based on jit-time allocation).
>>         ...  R9 ...
>>         R9 += 100
>>         static_prog_1
>>            ... R9 ...
>>            R9 += 100
>>            static_prog_11
>>              ... R9 ...
>>            R9 -= 100
>>         R9 -= 100
>>         ... R9 ...
>>         R9 += 100
>>         static_prog_2
>>            ... R9 ...
>>         R9 -= 100
>>
>> Similary, we can calculate R9 offset for
>>       global_prog
>>         static_prog_12
>> as well.
> I don't understand why differentiate static and global surprogs.

Specially handling global subprog is for potential BPF_PROG_TYPE_EXT
prog which may replace global subprog.

Therefore, so private stack, global subprog will terminate
stack accounting to minimize stack usage. If we treat
static/global subprogs the same, and if freplace does happen,
we might allocate more-than-necessary private stack.

freplace probably not a common use case. If it does happen,
the original global subprog may be a stub func which does
not have any stack usage and the freplace prog is the one
implementing the business logic. So from that perspective,
we do not need to differentiate static and global subprogs.

>
> But, mainly, += and -= around the call is suboptimal.
> Can we do it as a normal stack does ?
> Each prog knows how much stack it needs,
> so it can do:
> r9 += stack_depth in the prologue
> and all accesses are done as r9 - off.
> Then to do a call nothing extra is needed.
> The callee will do r9 += its own stack depth.

I thought the += and -= at call site are easier to understand.
But certainly, doing r9 += stack_depth and
r9 -= stack_depth inside the subprog works too.

> Whether private stack growth up or down is tbd.

My current approach is that private stack growth down
similar to normal stack. But we have flexibility
to grow up at frame level.

>
> The challenge is how to supply proper r9 on entry
> into the main prog. Potentially a task for bpf trampoline,
> and kprobe/tp/etc will need special hack in bpf_dispatcher_nop_func.

I have an early hack for bpf trampoline and
bpf_dispatcher_nop_func to pass private stack pointer
as the third argument to the bpf program.
In this particular case, we can just pass private
stack pointer in R9. I will pick this up.



