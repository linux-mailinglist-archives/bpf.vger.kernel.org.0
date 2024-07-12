Return-Path: <bpf+bounces-34619-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8492F4D4
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 07:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA53282CEB
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 05:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FEC17BBE;
	Fri, 12 Jul 2024 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FCz6G+FF"
X-Original-To: bpf@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEB8F9D9
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 05:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720760851; cv=none; b=ui6Lq+jzsNBG8GCOlMSkjW9dbDh5nE0QPJiGkBdfMl4AE/2YRTK5wH6q+gj8vYpGwhDcSJc17IOQXqpJtLy5a/ELlp5g4psb/2Gwdd55K8mJEVqapAAMHHDHGup7WNrDaj8chiYSvwab6/FMnb6Frzt4ehceKomxV6ue47jW218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720760851; c=relaxed/simple;
	bh=mKMJZLdUKDHl4zZWxegKIAKdFFeFaULHD9NM+e3kZTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEXTflFnJEwotV0I6G+FAln0hEj6Q0xONIWp5AYIH1N6lIvJQSZH8ntNI39iFouO5qG5YBqfZA31uiq+ISzheXHlhv9rYl/PyW6rJyi1nIZkJWXBetZBWAHhby4k9aKHDFDVh3QABMoMdRKbq6KFijuJuF5lb0BSl9vOmK514GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FCz6G+FF; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: eddyz87@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720760847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVR3jSkjOIfOnK3dHnBqYqgV8Z1PLMlgb/uQWu+vpz4=;
	b=FCz6G+FFh88hTRnF5lgMS71ASacw63VRWJV0CemgjSfNNm80uPnNCcMxYQtFY4HXjwDfEL
	TrfGfRxEHUKSdxgYp+/ZKzWAGz1kk4ajYWUdMl4CON/rnMyk2ogZPEmJJwC/1iZ5fckNwx
	vQuw1SSP8sfYT/IYjDY5CKQyHCyGzpI=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <d0040ec5-608d-4fc0-903d-0c5e10dfdedc@linux.dev>
Date: Thu, 11 Jul 2024 22:07:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Get better reg range with ldsx and
 32bit compare
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240710042915.1211933-1-yonghong.song@linux.dev>
 <de03d550a466ef98d4adec4778cdfd12bb247ac3.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <de03d550a466ef98d4adec4778cdfd12bb247ac3.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/11/24 3:20 PM, Eduard Zingerman wrote:
> On Tue, 2024-07-09 at 21:29 -0700, Yonghong Song wrote:
>
> [...]
>
>>    14: (81) r1 = *(s32 *)(r0 +0)         ; R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff) refs=2
>>    15: (ae) if w1 < w6 goto pc+4 20: R0=rdonly_mem(id=3,ref_obj_id=2,sz=4) R1=scalar(smin=0xffffffff80000000,smax=smax32=umax32=31,umax=0xffffffff0000001f,smin32=0,var_off=(0x0; 0xffffffff0000001f)) R6=scalar(id=1,smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=32,var_off=(0x0; 0x3f)) R7=0 R8=fp-8 R10=fp0 fp-8=iter_num(ref_id=2,state=active,depth=1) refs=2
> [...]
>
>> The insn #14 is a sign-extenstion load which is related to 'int i'.
>> The insn #15 did a subreg comparision. Note that smin=0xffffffff80000000 and this caused later
>> insn #23 failed verification due to unbounded min value.
>>
>> Actually insn #15 R1 smin range can be better. Before insn #15, we have
>>    R1_w=scalar(smin=0xffffffff80000000,smax=0x7fffffff)
>> With the above range, we know for R1, upper 32bit can only be 0xffffffff or 0.
>> Otherwise, the value range for R1 could be beyond [smin=0xffffffff80000000,smax=0x7fffffff].
>>
>> After insn #15, for the true patch, we know smin32=0 and smax32=32. With the upper 32bit 0xffffffff,
>> then the corresponding value is [0xffffffff00000000, 0xffffffff00000020]. The range is
>> obviously beyond the original range [smin=0xffffffff80000000,smax=0x7fffffff] and the
>> range is not possible. So the upper 32bit must be 0, which implies smin = smin32 and
>> smax = smax32.
>>
>> This patch fixed the issue by adding additional register deduction after 32-bit compare
>> insn such that if the signed 32-bit register range is non-negative and 64-bit smin is
>> {S32/S16/S8}_MIN and 64-bit max is no greater than {U32/U16/U8}_MAX.
>> Here, we check smin with {S32/S16/S8}_MIN since this is the most common result related to
>> signed extension load.
> [...]
>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> ---
>>   kernel/bpf/verifier.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c0263fb5ca4b..3fc557f99b24 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -2182,6 +2182,21 @@ static void __reg_deduce_mixed_bounds(struct bpf_reg_state *reg)
>>   		reg->smin_value = max_t(s64, reg->smin_value, new_smin);
>>   		reg->smax_value = min_t(s64, reg->smax_value, new_smax);
>>   	}
>> +
>> +	/* if s32 range is non-negative and s64 range is in [S32/S16/S8_MIN, <= S32/S16/S8_MAX],
>> +	 * the s64/u64 range can be refined.
>> +	 */
> Hi Yonghong,
>
> Sorry for delayed response, nice patch, it finally clicked for me.
> I'd suggest a slightly different comment, maybe it's just me being
> slow, but it took a while to understand why is this correct.
> How about a text like below:
>
>    Here we would like to handle a special case after sign extending load,
>    when upper bits for a 64-bit range are all 1s or all 0s.
>
>    Upper bits are all 1s when register is in a rage:
>      [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
>    Upper bits are all 0s when register is in a range:
>      [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
>    Together this forms are continuous range:
>      [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
>
>    Now, suppose that register range is in fact tighter:
>      [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
>    Also suppose that it's 32-bit range is positive,
>    meaning that lower 32-bits of the full 64-bit register
>    are in the range:
>      [0x0000_0000, 0x7fff_ffff] (W)
>
>    It so happens, that any value in a range:
>      [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
>    is smaller than a lowest bound of the range (R):
>       0xffff_ffff_8000_0000
>    which means that upper bits of the full 64-bit register
>    can't be all 1s, when lower bits are in range (W).
>
>    Note that:
>    - 0xffff_ffff_8000_0000 == (s64)S32_MIN
>    - 0x0000_0000_ffff_ffff == (s64)S32_MAX
>    These relations are used in the conditions below.

Sounds good. I will add some comments like the above in v2.

>
>> +	if (reg->s32_min_value >= 0) {
>> +		if ((reg->smin_value == S32_MIN && reg->smax_value <= S32_MAX) ||
>> +		    (reg->smin_value == S16_MIN && reg->smax_value <= S16_MAX) ||
>> +		    (reg->smin_value == S8_MIN && reg->smax_value <= S8_MAX)) {
> The explanation above also lands a question, would it be correct to
> replace the checks above by a single one?
>
>    reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX

You are correct, the range check can be better. The following is the related
description in the commit message:

> This patch fixed the issue by adding additional register deduction after 32-bit compare
> insn such that if the signed 32-bit register range is non-negative and 64-bit smin is
> {S32/S16/S8}_MIN and 64-bit max is no greater than {U32/U16/U8}_MAX.
> Here, we check smin with {S32/S16/S8}_MIN since this is the most common result related to
> signed extension load.

The corrent code simply represents the most common pattern.
Since you mention this, I will resive it as below in v2:
    reg->smin_value >= S32_MIN && reg->smin_value < 0 && reg->smax_value <= S32_MAX


>
>> +			reg->smin_value = reg->umin_value = reg->s32_min_value;
>> +			reg->smax_value = reg->umax_value = reg->s32_max_value;
>> +			reg->var_off = tnum_intersect(reg->var_off,
>> +						      tnum_range(reg->smin_value,
>> +								 reg->smax_value));
>> +		}
>> +	}
>>   }
>>   
>>   static void __reg_deduce_bounds(struct bpf_reg_state *reg)

