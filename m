Return-Path: <bpf+bounces-38415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D19964A7E
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 17:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11CB1F2400D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 15:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BDF1B4C3A;
	Thu, 29 Aug 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PncI/bMr"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172231B14F4
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946484; cv=none; b=jXFu9iMD2xeCinL+rwFir8s9shU5hc4tFIdT4s/d9wWDsJKmYplsJrwcAxVsH+r9Nc1gMD2p4LptHHBzneq6pOiuRg9QhJc60idZL6yHWL/nylBjxJpKzF0YJoC/hxRdar7732wBNUamXQ9QMA91ffzbU83WHtdin+zziSNxxIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946484; c=relaxed/simple;
	bh=M1oXa7fTBWFI8IFUApff9iVmN5/0skbcC7AChm1bSdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMxmswMmZejbH5UaIaUAxamt0KXsxboaMq/mzyMkLzcpEyqMpQ/kICBK1xfa55J8896K5w4t3iDGwBa0z5ZRpHPnsUbYVLEr0GLmWYYQAnLHSbL8IRoyCOHosXNfSthp7aCvgG6fCx2NeK5Y3VoCCw+3xl2pDPlv5bY95zrKez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PncI/bMr; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <99b8dc0e-5ef1-49bc-a8c7-0fb0fc4bfa75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724946480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjA3ckQK3bC1zjr7YYb/IshGkMiAhONKBEwFsy0p/Bg=;
	b=PncI/bMr5sQpAdeGHJ0ZnFqGG4S193OKTnqCRg0wY6Q3bI4JIR0J6CP5ayiS68b1ngN7Ds
	+Xh4BEGYuQ4d2HuXc00XK2+uJkZqopOQ+HIsW8JcOzkuOAit9kyzkd+Y5VVo4EdQy0I5pg
	q1zShc11epOkgLm0wRV03olm9sT5Ulg=
Date: Thu, 29 Aug 2024 08:47:52 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf-next 3/9] bpf: Add gen_epilogue to bpf_verifier_ops
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 kernel-team@meta.com
References: <20240827194834.1423815-1-martin.lau@linux.dev>
 <20240827194834.1423815-4-martin.lau@linux.dev>
 <306399911fc4b6241ac6fac7a36eb564210eee15.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <306399911fc4b6241ac6fac7a36eb564210eee15.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/28/24 7:26 PM, Eduard Zingerman wrote:
> On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
>> From: Martin KaFai Lau <martin.lau@kernel.org>
>>
>> This patch adds a .gen_epilogue to the bpf_verifier_ops. It is similar
>> to the existing .gen_prologue. Instead of allowing a subsystem
>> to run code at the beginning of a bpf prog, it allows the subsystem
>> to run code just before the bpf prog exit.
>>
>> One of the use case is to allow the upcoming bpf qdisc to ensure that
>> the skb->dev is the same as the qdisc->dev_queue->dev. The bpf qdisc
>> struct_ops implementation could either fix it up or drop the skb.
>> Another use case could be in bpf_tcp_ca.c to enforce snd_cwnd
>> has sane value (e.g. non zero).
>>
>> The epilogue can do the useful thing (like checking skb->dev) if it
>> can access the bpf prog's ctx. Unlike prologue, r1 may not hold the
>> ctx pointer. This patch saves the r1 in the stack if the .gen_epilogue
>> has returned some instructions in the "epilogue_buf".
>>
>> The existing .gen_prologue is done in convert_ctx_accesses().
>> The new .gen_epilogue is done in the convert_ctx_accesses() also.
>> When it sees the (BPF_JMP | BPF_EXIT) instruction, it will be patched
>> with the earlier generated "epilogue_buf". The epilogue patching is
>> only done for the main prog.
>>
>> Only one epilogue will be patched to the main program. When the
>> bpf prog has multiple BPF_EXIT instructions, a BPF_JA is used
>> to goto the earlier patched epilogue. Majority of the archs
>> support (BPF_JMP32 | BPF_JA): x86, arm, s390, risv64, loongarch,
>> powerpc and arc. This patch keeps it simple and always
>> use (BPF_JMP32 | BPF_JA).
>>
>> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
>> ---
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]
> 
>> @@ -19740,6 +19764,26 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>   			insn->code = BPF_STX | BPF_PROBE_ATOMIC | BPF_SIZE(insn->code);
>>   			env->prog->aux->num_exentries++;
>>   			continue;
>> +		} else if (insn->code == (BPF_JMP | BPF_EXIT) &&
>> +			   epilogue_cnt &&
>> +			   i + delta < subprogs[1].start) {
>> +			/* Generate epilogue for the main prog */
>> +			if (epilogue_idx) {
>> +				/* jump back to the earlier generated epilogue */
>> +				insn_buf[0] = BPF_JMP32_IMM(BPF_JA, 0,
>> +							    epilogue_idx - i - delta - 1, 0);
> 
> Nit: maybe add BPF_GOTOL macro or mention that this is a 'gotol' instruction in the comment?
>       (this is how it is called in llvm).

sgtm.

There is a BPF_JMP_A(OFF). BPF_JMP32_A(IMM) probably will be more consistent 
with the other existing macros.


