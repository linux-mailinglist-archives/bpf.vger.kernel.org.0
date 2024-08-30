Return-Path: <bpf+bounces-38499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68E596547C
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 03:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156F21C2340D
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 01:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84481803E;
	Fri, 30 Aug 2024 01:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LdKi7r5t"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220871758F
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980241; cv=none; b=Z89GoF1hCRsNy27mjXuQuPja5UdZwSVMwy0dXEgerbwf3Hk3CwPm2O0SngsdRAjoiks0XcuyRjhwPP23jbWlrPi4PDlMDBDS+JBj6OCmz8Od+cH+AOYIHISabJBOcflMpqmWUIUvLLNuUNoXLNYgXDPK6f6i9A3d2eFLgqBAwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980241; c=relaxed/simple;
	bh=bni2f8K1DjyjsLcwJFKwz3Wr5fTRyZ4p5NaC4JWnDpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nr0H7N6CyN+Hrt906GvbZSigF2Pabja92YcAzpDL0UtAtDQiYkc0dVzjyiFbuI2kImFg3DS2iU9q8YDWjqGU/BRw9ta7nRpwl5kJgtV+Pl4SaHMqh+uCgpGqoZCz+uqpWTZyUWg//CEbAU08Eqk4qVne1fgtUJgazYG35ayEvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LdKi7r5t; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d7ca6398-43aa-499a-b9ae-6b6e00a7e72e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724980234;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvKVlPfjc5FkL+CSNqALSKJKQV3SzXeZ4J0ahpTQEqc=;
	b=LdKi7r5tVDzu0oSpEez0wHZ5lz4qDE+lT+0ngTTqGq7gQufyeWnwb34ecTo5qq1xxcqJEV
	ECSVVFmhKwMlN+/hpqQ3GG1OGBFoOR87+/q51ce+uKAWAOU+2b2OEMogklDQ7WDUUCP14o
	s6l016xoA5DV9gOD2QeNmDGyBwhJgcY=
Date: Thu, 29 Aug 2024 18:10:24 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 2/9] bpf: Adjust BPF_JMP that jumps to the 1st
 insn of the prologue
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>,
 kernel-team@meta.com
References: <20240829210833.388152-1-martin.lau@linux.dev>
 <20240829210833.388152-3-martin.lau@linux.dev>
 <cdd2ea1421331cf27e5435ad60b7461936eceab2.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <cdd2ea1421331cf27e5435ad60b7461936eceab2.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/29/24 5:47 PM, Eduard Zingerman wrote:
> On Thu, 2024-08-29 at 14:08 -0700, Martin KaFai Lau wrote:
> 
> [...]
> 
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 261849384ea8..03e974129c05 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -19286,6 +19286,9 @@ static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
>>   	for (i = 0; i < insn_cnt; i++, insn++) {
>>   		u8 code = insn->code;
>>   
>> +		if (tgt_idx <= i && i < tgt_idx + delta)
>> +			continue;
>> +
>>   		if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
>>   		    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
>>   			continue;
>> @@ -19704,6 +19707,9 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
>>   		}
>>   	}
>>   
>> +	if (delta)
>> +		WARN_ON(adjust_jmp_off(env->prog, 0, delta));
> 
> Just noticed this.
> Suppose prologue is three instructions long and no epilogue,
> then cnt == 3 and delta == 2, adjust_jmp_off() would skip instructions
> in range [0..2), while inserted instructions range is [0..2].
> So, this would work only if the last statement in the prologue/epilogue
> generator is:
> 
> 	*insn++ = prog->insnsi[0];
> 
> which seems to be true for prologue generators in the tree,
> but looks a bit unintuitive...

Right, it is the current requirement/setup for the existing gen_prologue. It 
should be obvious to spot if the gen_prologue does not do this and more unlikely 
also somehow needs to jump back to itself.

Thanks for looking at the patches!

> 
>> +
>>   	if (bpf_prog_is_offloaded(env->prog->aux))
>>   		return 0;
>>   
> 
> 


