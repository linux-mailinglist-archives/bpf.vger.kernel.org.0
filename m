Return-Path: <bpf+bounces-42996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 710899AD9EE
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 04:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 764AA1C21920
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 02:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F6242AA1;
	Thu, 24 Oct 2024 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gl+E8PRf"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508844D8AD
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729737012; cv=none; b=Mo13BG6fWJqDdcDjvBj5MW1DW5Oc5CKLTb8UEq++tdLW+4TXyBfg7I9OSRXzurV8c5dOFdm1eLmZNXP6bKtyZ6WzWEVWruDJrvn3weJXNSjJkWVCDBUOf1jR6p4Q/bydF4Y2qH5r3zo0Y38tg/Z/cgyqRn0L7VG+JVSrgs6eeLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729737012; c=relaxed/simple;
	bh=XHXnwjR/WT7ydEEXZs+EfOs9PB2MAuypJFtPdr9jJr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJuhdBXEL+oRXf5KLYK7QgsIh9t9h53OKsQ1eTyJywRHF9ZSV1IsdBDCLSAEif/vSF7hE9RyHbcZkYJ1goN80BHgEikZmzmX6zCQIEUXeg4pHvdgbUfkZ9WXD9a9b07Wbaux8chTYvdhY6+QNLy7MJgb2O7/mFHldeOpwHroAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gl+E8PRf; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c3e4f79c-8453-4e2d-b96f-a7ac718843cf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729737006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxhphihRF1EDPTEf2N7U+4VuQPmCsu2iKoZXeY5taBc=;
	b=gl+E8PRfbQJDGy7RINgM1l0Ah/W6MzGQjFoEgDaDy/SCbkhrW2JS0zQwU++WCzv6+c86pF
	AyQsLv99xy5WX6cECgMhzC5Rw+H+zh9SRpLaT7/WOA8fhSupCL8uZtVLr35/Qp4pmjoTW9
	bOzTVFZg2CkgPsbxvZcZMzx2Fz8Hi0w=
Date: Wed, 23 Oct 2024 19:29:57 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf, x64: Propagate tailcall info only for
 tail_call_reachable subprogs
Content-Language: en-GB
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 jolsa@kernel.org, eddyz87@gmail.com, kernel-patches-bot@fb.com
References: <20241021133929.67782-1-leon.hwang@linux.dev>
 <20241021133929.67782-2-leon.hwang@linux.dev>
 <87faf17b-51aa-487f-8d49-bf297a64ffa6@linux.dev>
 <0f61509c-3a00-422a-90f3-89bdfbd20037@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <0f61509c-3a00-422a-90f3-89bdfbd20037@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/21/24 6:46 PM, Leon Hwang wrote:
>
> On 22/10/24 01:49, Yonghong Song wrote:
>> On 10/21/24 6:39 AM, Leon Hwang wrote:
>>> In the x86_64 JIT, when calling a function, tailcall info is
>>> propagated if
>>> the program is tail_call_reachable, regardless of whether the function
>>> is a
>>> subprog, helper, or kfunc. However, this propagation is unnecessary for
>>> not-tail_call_reachable subprogs, helpers, or kfuncs.
>>>
>>> The verifier can determine if a subprog is tail_call_reachable.
>>> Therefore,
>>> it can be optimized to only propagate tailcall info when the callee is
>>> subprog and the subprog is actually tail_call_reachable.
>>>
>>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>>> ---
>>>    arch/x86/net/bpf_jit_comp.c | 4 +++-
>>>    kernel/bpf/verifier.c       | 6 ++++++
>>>    2 files changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>>> index 06b080b61aa57..6ad6886ecfc88 100644
>>> --- a/arch/x86/net/bpf_jit_comp.c
>>> +++ b/arch/x86/net/bpf_jit_comp.c
>>> @@ -2124,10 +2124,12 @@ st:            if (is_imm8(insn->off))
>>>                  /* call */
>>>            case BPF_JMP | BPF_CALL: {
>>> +            bool pseudo_call = src_reg == BPF_PSEUDO_CALL;
>>> +            bool subprog_tail_call_reachable = dst_reg;
>>>                u8 *ip = image + addrs[i - 1];
>>>                  func = (u8 *) __bpf_call_base + imm32;
>>> -            if (tail_call_reachable) {
>>> +            if (pseudo_call && subprog_tail_call_reachable) {
>> Why we need subprog_tail_call_reachable? Does
>>      tail_call_reachable && psueudo_call
>> work the same way?
>>
> 'tail_call_reachable && pseudo_call' works too. However, it will
> propagate tailcall info to subprog even if the subprog is not
> tail_call_reachable.
>
> subprog_tail_call_reachable indicates the subprog requires tailcall info
> from its caller.
> So, 'pseudo_call && subprog_tail_call_reachable' is better.

In verifier.c, we have
   func[i]->aux->tail_call_reachable = env->subprog_info[i].tail_call_reachable;
that is subprog_info tail_call_reachable has been transferred to func[i] tail_call_reachable.

In x86 do_jit() func, we have
   bool tail_call_reachable = bpf_prog->aux->tail_call_reachable

So looks like we do not need verifier.c change here.
Did I miss anything? Could you give a concrete example to show
subprog_tail_call_reachable approach is better than tail_call_reachable?
   

>
> Thanks,
> Leon
>

