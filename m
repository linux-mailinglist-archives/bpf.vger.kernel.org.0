Return-Path: <bpf+bounces-58677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDF9ABFDF9
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1BF7A8E7A
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC4C29C35A;
	Wed, 21 May 2025 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y32bxrw1"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE7329B23A
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 20:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859701; cv=none; b=JZFlUNDiFmxGs9XCtq1AzenLSLrLPeWthXj3TRUBQJhaU7J1gS0/SW6Zt9Atl4t4+9seg9WIx6xmFH3zVE1qNT10V5E2H0pm+QWLgaw+ws+lYRYqolZaK/nBEFwr6SKQcxUx2WLctGetJWZ7Aiz+fzKi68QPlMuwXG5/uaGjR4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859701; c=relaxed/simple;
	bh=1QRywkdwbyyZfLXAbkoVPtyyJzd7cIr100MpyTRM/d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdntS3EDP1mjBUqdANVujQznvM+SCSg8K3iQFkxMh2xwq7R+kFKHVVLHKZ7lA6cyihHn8IN8ioLciMcxV1dEnL4h5OJaQ2+ezwZtalQVc+xX/0nD2PnUa8n9j+KtsLelA/HDyHJLeA9bDAuzaSYe/MdROVMp0dp7my9WrLhniRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y32bxrw1; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c0fa9ee-f9dd-4cde-b4fb-6f28ebefc619@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747859696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QOoepDu2lBkmknlFwZckI08mwWNLuQHeb8WGLEw95g=;
	b=Y32bxrw1x81ZdUB/8Rh+WsZSoDejkvyhL9LwNmFpIt1D7n0O0GG1/mS3nB7ZB7bD9QTpgX
	6A+ti8za1bEWjyog+4XsgAFoyphZL6z8jlg3ulWnQR1DYSCiy7of2k50azVItG8qqDaCTP
	I9hJo5B6nU4QIc6d5TnmkNRECP5wNhg=
Date: Wed, 21 May 2025 13:34:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register in
 precision backtracking bookkeeping
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
 <45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/21/25 11:55 AM, Eduard Zingerman wrote:
> [...]
>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 78c97e12ea4e..e73a910e4ece 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -357,6 +357,10 @@ enum {
>>       INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
>>         INSN_F_STACK_ACCESS = BIT(9), /* we need 10 bits total */
>> +
>> +    INSN_F_DST_REG_STACK = BIT(10), /* dst_reg is PTR_TO_STACK */
>> +    INSN_F_SRC_REG_STACK = BIT(11), /* src_reg is PTR_TO_STACK */
>
> INSN_F_STACK_ACCESS can be inferred from INSN_F_DST_REG_STACK
> and INSN_F_SRC_REG_STACK if insn_stack_access_flags() is adjusted
> to track these flags instead. So, can be one less flag/bit.

You are correct, we could have BIT(9) for both INSN_F_STACK_ACCESS and INSN_F_DST_REG_STACK,
and BIT(10) for INSN_F_SRC_REG_STACK. But it makes code a little bit
complicated. I am okay with this if Andrii also thinks it is
worthwhile to do this.

>
>> +    /* total 12 bits are used now. */
>>   };
>>     static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);
>
> [...]
>
>> @@ -4402,6 +4418,8 @@ static int backtrack_insn(struct 
>> bpf_verifier_env *env, int idx, int subseq_idx,
>>                */
>>               return 0;
>>           } else if (BPF_SRC(insn->code) == BPF_X) {
>> +            bool dreg_precise, sreg_precise;
>> +
>>               if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt, sreg))
>>                   return 0;
>>               /* dreg <cond> sreg
>> @@ -4410,8 +4428,16 @@ static int backtrack_insn(struct 
>> bpf_verifier_env *env, int idx, int subseq_idx,
>>                * before it would be equally necessary to
>>                * propagate it to dreg.
>>                */
>> -            bt_set_reg(bt, dreg);
>> -            bt_set_reg(bt, sreg);
>> +            if (!hist)
>> +                return 0;
>> +            dreg_precise = !insn_dreg_stack_ptr(hist->flags);
>> +            sreg_precise = !insn_sreg_stack_ptr(hist->flags);
>> +            if (!dreg_precise && !sreg_precise)
>> +                return 0;
>> +            if (dreg_precise)
>> +                bt_set_reg(bt, dreg);
>> +            if (sreg_precise)
>> +                bt_set_reg(bt, sreg);
>
> This check can be done in a generic way at backtrack_insn() callsite:
> check which register is pointer to stack and remove it from set 
> registers.

Looks like other cases in backtrack_insn() has been handled properly,
so it may still be worthwhile to put the code here.

>
>>           } else if (BPF_SRC(insn->code) == BPF_K) {
>>                /* dreg <cond> K
>>                 * Only dreg still needs precision before
>> @@ -16397,6 +16423,29 @@ static void sync_linked_regs(struct 
>> bpf_verifier_state *vstate, struct bpf_reg_s
>>       }
>>   }
>>   +static int push_cond_jmp_history(struct bpf_verifier_env *env, 
>> struct bpf_verifier_state *state,
>> +                 struct bpf_reg_state *dst_reg, struct bpf_reg_state 
>> *src_reg,
>> +                 u64 linked_regs)
>> +{
>> +    bool dreg_stack_ptr, sreg_stack_ptr;
>> +    int insn_flags;
>> +
>> +    if (!src_reg) {
>> +        if (linked_regs)
>> +            return push_insn_history(env, state, 0, linked_regs);
>> +        return 0;
>> +    }
>
> Nit: this 'if' is not needed, src_reg is always set (it might point to 
> a fake register,
>      but in that case it is a scalar without id).
>
Here, there is a bug here. Thanks for pointing this out. I need to check
BPF_SRC(insn->code) != BPF_X instead of "!src_reg". Basically passing one
more parameter (e.g., faked_sreg) to decide whether src_reg is faked or not.

>
>> +
>> +    dreg_stack_ptr = dst_reg->type == PTR_TO_STACK;
>> +    sreg_stack_ptr = src_reg->type == PTR_TO_STACK;
>> +
>> +    if (!dreg_stack_ptr && !sreg_stack_ptr && !linked_regs)
>> +        return 0;
>> +
>> +    insn_flags = insn_reg_access_flags(dreg_stack_ptr, sreg_stack_ptr);
>> +    return push_insn_history(env, state, insn_flags, linked_regs);
>> +}
>> +
>
> [...]
>


