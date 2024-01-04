Return-Path: <bpf+bounces-19062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF23824970
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 21:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D5628885E
	for <lists+bpf@lfdr.de>; Thu,  4 Jan 2024 20:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C7F2C1BF;
	Thu,  4 Jan 2024 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="prIDZ7Xp"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407A2C687
	for <bpf@vger.kernel.org>; Thu,  4 Jan 2024 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cbff1224-39c0-4555-a688-53e921065b97@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704399165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PnHMyn8je3bBJzkNXTYmia/r7sY9xFEKQJZhVil7MXA=;
	b=prIDZ7XpZ6ldZOEyVYd8b5ELDFpYRP+PRFuDsn8/gB+3F+KAFW0wYeaQ0yAOmnyZzTJ3HF
	kZVKKn4OS7QtJunO/FRa5hB6qcK2OGv7xMMHSlVHy+KZHzHA4h27HAA52KmF7nKfHCXZT2
	OhJ2UUThLhOUg4w8a6zwhVdUyIxGPrI=
Date: Thu, 4 Jan 2024 12:12:37 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Track aligned st store as imprecise
 spilled registers
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Martin KaFai Lau <kafai@fb.com>
References: <20240103232617.3770727-1-yonghong.song@linux.dev>
 <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <f4c1ebf73ccf4099f44045e8a5b053b7acdffeed.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/4/24 10:30 AM, Eduard Zingerman wrote:
> On Wed, 2024-01-03 at 15:26 -0800, Yonghong Song wrote:
>
> I missed one thing while looking at this patch, please see below.
>
> [...]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index d4e31f61de0e..cfe7a68d90a5 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -4491,7 +4491,7 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
>>   		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
>>   			state->stack[spi].spilled_ptr.id = 0;
>>   	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
>> -		   insn->imm != 0 && env->bpf_capable) {
>> +		   env->bpf_capable) {
>>   		struct bpf_reg_state fake_reg = {};
>>   
>>   		__mark_reg_known(&fake_reg, insn->imm);
>> @@ -4613,11 +4613,28 @@ static int check_stack_write_var_off(struct bpf_verifier_env *env,
>>   
>>   	/* Variable offset writes destroy any spilled pointers in range. */
>>   	for (i = min_off; i < max_off; i++) {
>> +		struct bpf_reg_state *spill_reg;
>>   		u8 new_type, *stype;
>> -		int slot, spi;
>> +		int slot, spi, j;
>>   
>>   		slot = -i - 1;
>>   		spi = slot / BPF_REG_SIZE;
>> +
>> +		/* If writing_zero and the the spi slot contains a spill of value 0,
>> +		 * maintain the spill type.
>> +		 */
>> +		if (writing_zero && !(i % BPF_REG_SIZE) && is_spilled_scalar_reg(&state->stack[spi])) {
> Talked to Andrii today, and he noted that spilled reg should be marked
> precise at this point.

Could you help explain why?

Looks we did not mark reg as precise with fixed offset as below:

         if (reg && !(off % BPF_REG_SIZE) && register_is_bounded(reg) && env->bpf_capable) {
                 save_register_state(env, state, spi, reg, size);
                 /* Break the relation on a narrowing spill. */
                 if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
                         state->stack[spi].spilled_ptr.id = 0;
         } else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
                    insn->imm != 0 && env->bpf_capable) {

I probably missed something about precision tracking...

>
>> +			spill_reg = &state->stack[spi].spilled_ptr;
>> +			if (tnum_is_const(spill_reg->var_off) && spill_reg->var_off.value == 0) {
>> +				for (j = BPF_REG_SIZE; j > 0; j--) {
>> +					if (state->stack[spi].slot_type[j - 1] != STACK_SPILL)
>> +						break;
>> +				}
>> +				i += BPF_REG_SIZE - j - 1;
>> +				continue;
>> +			}
>> +		}
>> +
>>   		stype = &state->stack[spi].slot_type[slot % BPF_REG_SIZE];
>>   		mark_stack_slot_scratched(env, spi);

