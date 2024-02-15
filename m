Return-Path: <bpf+bounces-22050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A2F855926
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 04:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355D42909FD
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 03:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12286FB0;
	Thu, 15 Feb 2024 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TsFGJ0XL"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8EB5398
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966454; cv=none; b=WLVSOKYn2JogJyhtJ8dyBaNwwYBSyUCPsQHLXbpzFh1BhBMnEBG7Q6wU8nyhU/mavM7A87o90mBa1up6MivMmL7UEbeckaoOUjxBOmJ7Kn/hnVPLMeyFGSI1Ckzyt2nd9+UkvsbJND9FnBA9kMk5WxtpGncOYQyDC2pyUc1hWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966454; c=relaxed/simple;
	bh=iWTjOwhllXjQc9b84748H0YbmSvOj1ddaEZYy3Wodos=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kG3P1MDk8t5nPdGTBtiHjoNKmX+BS+uKLjJRIMX+Xs88sqUW7eJ90UEfQ5QqM7n/9a25uAh/P5lJDPZMmXw1zyC2vWjRRJmI0lQY6gy4l6nceSLuDIg1niW6b4rAfI6kcCl3G2mFYeLcshsWyt5DJV66Q1nxq2BsIz+hUqqwths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TsFGJ0XL; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <77fbe6f8-b1df-44a2-a177-d3b9faba5482@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707966449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p77/DaUTwYPoKQzXGliqzeByk1ybNdKc+Kp24OgIFNw=;
	b=TsFGJ0XLo56agIwU895W68esWa6UoQblPuYWNcwvKMZcRaESIs3ExBkpjfkuFgdLcMKzdb
	W9UTLmkjhv7KE8hxEZE9PRzV4d3ZNYUiB+rFRCEmBJ8A853NxN+Zkjh4i431H8WMxUerTv
	3qGPgoYgpyGJTwKefKxnrgxW4LK0dqY=
Date: Wed, 14 Feb 2024 19:07:14 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [LSF/MM/BPF TOPIC] Segmented Stacks for BPF Programs
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, David Vernet <void@manifault.com>,
 lsf-pc <lsf-pc@lists.linux-foundation.org>
References: <a15f6a20-c902-4057-a1a9-8259a225bb8b@linux.dev>
 <CAADnVQJwN_NvjM2121urjutY3FqtzHxNWyGPWQzyzhCmFmDDzQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAADnVQJwN_NvjM2121urjutY3FqtzHxNWyGPWQzyzhCmFmDDzQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2/14/24 6:20 PM, Alexei Starovoitov wrote:
> On Wed, Feb 14, 2024 at 11:53 AM Yonghong Song <yonghong.song@linux.dev> wrote:
>> For each active kernel thread, the thread stack size is 2*PAGE_SIZE ([1]).
>> Each bpf program has a maximum stack size 512 bytes to avoid
>> overflowing the thread stack. But nested bpf programs may post
>> a challenge to avoid stack overflow.
>>
>> For example, currently we already allow nested bpf
>> programs esp in tracing, i.e.,
>>     Prog_A
>>       -> Call Helper_B
>>         -> Call Func_C
>>           -> fentry program is called due to Func_C.
>>             -> Call Helper_D and then Func_E
>>               -> fentry due to Func_E
>>                 -> ...
>> If we have too many bpf programs in the chain and each bpf program
>> has close to 512 byte stack size, it could overflow the kernel thread
>> stack.
>>
>> Another more practical potential use case is from a discussion between
>> Alexei and Tejun. It is possible for a complex scheduler like sched-ext,
>> we could have BPF prog hierarchy like below:
>>                          Prog_1 (at system level)
>>             Prog_Numa_1    Prog_Numa_2 ...  Prog_Numa_4
>>          Prog_LLC_1 Prog_LLC_2 ...
>>        Prog_CPU_1 ...
>>
>> Basically, the top bpf program (Prog_1) will call Prog_Numa_* programs
>>
>> through a kfunc to collect information from programs in each numa node.
>> Each Prog_Numa_* program will call Prog_LLC_* programs to collect
>> information from programs in each llc domain in that particular
>> numa node, etc. The same for Prog_LLC_* vs. Prog_CPU_*.
>> Now we have four level nested bpf programs.
>>
>> The proposed approach is to allocate stack from heap for
>> each bpf program. That way, we do not need to worry about
>> kernel stack overflow. Such an approach is called
>> segmented stacks ([2]) in clang/gcc/go etc.
>>
>> Obviously there are some drawbacks for segmented stack approach:
>>    - some performance degradation, so this approach may not for everyone.
>>    - stack backtracking,  kernel changes are necessary.
> I suspect segmented stacks the way compilers do them are not suitable
> for bpf progs, since they break backtraces and backtrace is a crucial
> feature that must work even when there are kernel bugs.
> How about we keep call/ret, save/restore of callee saved regs
> in the normal stack, but use a parallel memory (per-cpu or some other)
> for bpf prog needs. What bpf prog thinks of stack will be in that memory
> while the call chain will remain correct.
>  From bpf prog pov the stack is where bpf_reg_r10 points to.
> It doesn't have to be in the kernel stack. Shadow memory will work.

Thanks for suggestions. Make sense. This will resolve backtrace
issue. Let me experiment with this approach.

>
> Let's also call it something else than "segmented stack" to avoid
> confusion.

Indeed, "segmented stack" terminoloty is not appropriate any more since 
the original stack is backtracable. Will think of a different one.


