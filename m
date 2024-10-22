Return-Path: <bpf+bounces-42722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9049A95A5
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 03:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A6FB21330
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9234D8CF;
	Tue, 22 Oct 2024 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lgJOCrqb"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7860317993
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561598; cv=none; b=NndPbmLeiI0/PpYwou5Q/9U2yySX5ir+ol6SWZ+n58OR4p9VpThnSMj0s+3xh4K4m9eKc2m7IxRz3+oYbyvS5woijFgg9kgQTrAjhaJUo8ZFyn4PCiSp7IaCJ8Shrl/dN2t/aeh9OpLoy2TEo8Pe+zEWgB5Kc01V6B7N7TaYHww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561598; c=relaxed/simple;
	bh=AzE8fYotIum1oWdGLMn7crbHnaUEkMFZL232IOQeR7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/WJgj86TblbUY8Pf4M2gPTJQjylVVUOq/15/UYZq4LHmmnv/ScCQQs6y2dCx4U3nXPLLCgNoklK7r1CduK201BniqRNfO4HypavnbjA0ce+sXyV78OjYqvoaKiNPAZMP02L3bDhetvwum/GqNsIq3bm+OZSS10JeGyGgZYBtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lgJOCrqb; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0f61509c-3a00-422a-90f3-89bdfbd20037@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729561592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ry3br5BFbDWeH/Tp4jOgN3WpdVS73dULoPmS6fyRyg=;
	b=lgJOCrqbe9MJC+9r+bxiOg8aVyT18h+AXOk6d2zNQ/PH/0vZKpvqaIy+VLM0nwQ6NsmkXe
	6+zcglJtfm2zJKT5rTQy6On4AaEfFwq3xmu+aFXv+oj/ndeVXsXZR4PzAbHk3Rv9C2mmLl
	dFhjhfAeRb3dsC3E7MYGrTjHCiYNI4o=
Date: Tue, 22 Oct 2024 09:46:18 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf, x64: Propagate tailcall info only for
 tail_call_reachable subprogs
Content-Language: en-US
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 jolsa@kernel.org, eddyz87@gmail.com, kernel-patches-bot@fb.com
References: <20241021133929.67782-1-leon.hwang@linux.dev>
 <20241021133929.67782-2-leon.hwang@linux.dev>
 <87faf17b-51aa-487f-8d49-bf297a64ffa6@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <87faf17b-51aa-487f-8d49-bf297a64ffa6@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 22/10/24 01:49, Yonghong Song wrote:
> 
> On 10/21/24 6:39 AM, Leon Hwang wrote:
>> In the x86_64 JIT, when calling a function, tailcall info is
>> propagated if
>> the program is tail_call_reachable, regardless of whether the function
>> is a
>> subprog, helper, or kfunc. However, this propagation is unnecessary for
>> not-tail_call_reachable subprogs, helpers, or kfuncs.
>>
>> The verifier can determine if a subprog is tail_call_reachable.
>> Therefore,
>> it can be optimized to only propagate tailcall info when the callee is
>> subprog and the subprog is actually tail_call_reachable.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 4 +++-
>>   kernel/bpf/verifier.c       | 6 ++++++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 06b080b61aa57..6ad6886ecfc88 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -2124,10 +2124,12 @@ st:            if (is_imm8(insn->off))
>>                 /* call */
>>           case BPF_JMP | BPF_CALL: {
>> +            bool pseudo_call = src_reg == BPF_PSEUDO_CALL;
>> +            bool subprog_tail_call_reachable = dst_reg;
>>               u8 *ip = image + addrs[i - 1];
>>                 func = (u8 *) __bpf_call_base + imm32;
>> -            if (tail_call_reachable) {
>> +            if (pseudo_call && subprog_tail_call_reachable) {
> 
> Why we need subprog_tail_call_reachable? Does
>     tail_call_reachable && psueudo_call
> work the same way?
> 

'tail_call_reachable && pseudo_call' works too. However, it will
propagate tailcall info to subprog even if the subprog is not
tail_call_reachable.

subprog_tail_call_reachable indicates the subprog requires tailcall info
from its caller.
So, 'pseudo_call && subprog_tail_call_reachable' is better.

Thanks,
Leon


