Return-Path: <bpf+bounces-43130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1E9AF78F
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 04:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D30E61C21E38
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 02:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FACB189F45;
	Fri, 25 Oct 2024 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wPvXp6xq"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AAF225DA
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729823868; cv=none; b=Gp0PbcMF3PCqLH9oSya2rf86SWDkD+flW8RDtn6gVoXN8/Pu9ArhfN76l96XHAAq5lCbxeepz9zsVCGyMlpieRT0ZaLC91SG6Q+Q6hL7zB3EZdVzNUZ3JiEgvO98mLdKeguG5nHlAAjY4ExE2WQq2CI6GkxkOb38hv5OB0ITl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729823868; c=relaxed/simple;
	bh=oCDqtzzq1WmrAd2KbGKue4dOh+1UHWTya7l1bGo/pAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gl6n1dbVRdx9b/TIRL0W4kLo/VI0zCGiasT/q5j1Of+Rd7oz1wLs0GkekPrez6VxR5ThOMtiH9KQ23vvZtJRL9YxGwMQwbKVr97NzOUDzv38BLnwavHohNL+vOgKuSetefSYcVDeeOZ66FyMYzHenPmPjTWDo7yk9AG70Kh1RZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wPvXp6xq; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6f2c4bed-0b9c-48f7-886f-81e9df0155e7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729823862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6YMGzBRFNqMsV1ec7cLGd4b9mG3UgxSE/vhPIc7vqCU=;
	b=wPvXp6xqcFCHWLK/3pZRHvT4yFi5jcHZYsY6Z6H8hj1LKp28A0GQGEiRz6rhB7pM0KpwB0
	TUyceckG5rHFTVt92MknjFVA+Bjd551BOa0hqWTSmhu1P6RNIy3VJ7qgEAfYexIRMb479S
	H0xYumNvzZcpiWzheZdaQO9RqU1sysM=
Date: Fri, 25 Oct 2024 10:37:35 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf, x64: Propagate tailcall info only for
 tail_call_reachable subprogs
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Eddy Z <eddyz87@gmail.com>,
 kernel-patches-bot@fb.com
References: <20241021133929.67782-1-leon.hwang@linux.dev>
 <20241021133929.67782-2-leon.hwang@linux.dev>
 <CAADnVQKO3rdaVrNOcLbm=kmue4orurcRTuskgrdze_=ExS2A7g@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKO3rdaVrNOcLbm=kmue4orurcRTuskgrdze_=ExS2A7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 25/10/24 06:09, Alexei Starovoitov wrote:
> On Mon, Oct 21, 2024 at 6:39 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>> In the x86_64 JIT, when calling a function, tailcall info is propagated if
>> the program is tail_call_reachable, regardless of whether the function is a
>> subprog, helper, or kfunc. However, this propagation is unnecessary for
>> not-tail_call_reachable subprogs, helpers, or kfuncs.
>>
>> The verifier can determine if a subprog is tail_call_reachable. Therefore,
>> it can be optimized to only propagate tailcall info when the callee is
>> subprog and the subprog is actually tail_call_reachable.
>>
>> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
>> ---
>>  arch/x86/net/bpf_jit_comp.c | 4 +++-
>>  kernel/bpf/verifier.c       | 6 ++++++
>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index 06b080b61aa57..6ad6886ecfc88 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -2124,10 +2124,12 @@ st:                     if (is_imm8(insn->off))
>>
>>                         /* call */
>>                 case BPF_JMP | BPF_CALL: {
>> +                       bool pseudo_call = src_reg == BPF_PSEUDO_CALL;
>> +                       bool subprog_tail_call_reachable = dst_reg;
>>                         u8 *ip = image + addrs[i - 1];
>>
>>                         func = (u8 *) __bpf_call_base + imm32;
>> -                       if (tail_call_reachable) {
>> +                       if (pseudo_call && subprog_tail_call_reachable) {
>>                                 LOAD_TAIL_CALL_CNT_PTR(bpf_prog->aux->stack_depth);
>>                                 ip += 7;
>>                         }
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index f514247ba8ba8..6e7e42c7bc7b1 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19990,6 +19990,12 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>>                         insn[0].imm = (u32)addr;
>>                         insn[1].imm = addr >> 32;
>>                 }
>> +
>> +               if (bpf_pseudo_call(insn))
>> +                       /* In the x86_64 JIT, tailcall information can only be
>> +                        * propagated if the subprog is tail_call_reachable.
>> +                        */
>> +                       insn->dst_reg = env->subprog_info[subprog].tail_call_reachable;
> 
> I really don't like hacking flags into dst_reg.
> We already abuse insn->off which is ugly too,
> but at least we clean insns later after JIT.
> 
> I'd rather live with this tail call inefficiency than abuse insns
> fields further.
> 

OK, let us use 'pseudo_call && tail_call_reachable' in x86 JIT to avoid
touching 'insn->dst_reg'.

Thanks,
Leon

> pw-bot: cr


