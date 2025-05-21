Return-Path: <bpf+bounces-58669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164DFABFD11
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384241BC2D22
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 18:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D077228F533;
	Wed, 21 May 2025 18:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8ZMqJ+K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6E22CBF4
	for <bpf@vger.kernel.org>; Wed, 21 May 2025 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853737; cv=none; b=nc54bipSdFFgjcr6o2G+fBt4iybNW04ZJ0LSw6XqUx9Fu9yO5kRzlcLpmKKyTAFwpsudDdrIMA2unD1WYvdFiFHpuUT7mVZdqZYQkXHjKl3GFfWdJ0FeaNlfd6kt8nmScJ5HVVbp0WzIlGZqiEAt31AL/zuxrX5Bjst33wRfFxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853737; c=relaxed/simple;
	bh=Y8EuP3E51216B36+AzEU7ivGDSkV5t9MpiV/3eVyd8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nTtWzY7I3sAW3Oiue2adtkutvdX2CqRv0Nr0t8p/ah3tXxVkE5xtNY45z35EgdTIUQIyWF0DV7hn/CxzlEVuN0CZI/w83Rx3fOxOvrQ48S5emd8ecs+XZ08pUA9g6aFi7K1aWMCETDa1zvoa9y6YDlTY60wqXJUtPgIjiLqYaxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8ZMqJ+K; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-742af84818cso4348550b3a.1
        for <bpf@vger.kernel.org>; Wed, 21 May 2025 11:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747853735; x=1748458535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lqjJtnk8rbXwBl870QG0TMVHCwMfpPTcVS7ViUajP1Y=;
        b=j8ZMqJ+KcKlFFPRN545tFOJfQwGanBmEiYD3v2YEvIkEy7eZhvT6PgEs6GxHHCaVZM
         vVisx/3NEQX4hT9FW0enuCvgMzvOXahQh4gAx7pyU6gYSD4keRSX4ey37cjpoUec5VVg
         lGVBVCCFN7ZI2N8XI4UfSPIzRg8jr0u/B7UC6K+sohbfzIQUvplDGDyBBf8M5qyCZJUj
         vIYEnfAnYoKjoTmS1EVm6JaDvBycRaKVU/vfIiW09UKMo6Z6IgT/6vLBH2/vEvH7ySQW
         CxsKsLTEuJ/cJujywTTnv9RF6XGkl7pIOo6QRIW8gLvkKPWsoY2tEBQZjcN87/RcYcfi
         hUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747853735; x=1748458535;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lqjJtnk8rbXwBl870QG0TMVHCwMfpPTcVS7ViUajP1Y=;
        b=Fz2L1NVQaFe/btlAx/V6MEk8yhFJtddcY5FRd7iq6mqZcJy5RJIjsxR8B9MsjZtDOy
         +xZ6JB27tleL2O/1nFisQFp/Mo73izFXWLvW8bqF5HqbhY85GvhgBI7SC2RkdswB6HiA
         rn1iKLdjCK3MnR8BYsiuQj7frbk+6NvldlUV8FLYiDx+bHAhi5F6QNQd3EwPy4nuuuEn
         lCPYa8xk/GhbxT832ZgkN1wb6uHtQ1sifeqw2aicgMnbg8DdgqlZT0XQ1bxbYl74CMgO
         1h3XiCEnitpaQ26v6tF16nzMwBGIooV6aNKuwwrD1CFLMe+VQ0Ru6U064bJWal9haSsz
         n5aA==
X-Forwarded-Encrypted: i=1; AJvYcCVlAwt5eZXBTSUukCAJ7CdFRkiPChgS7rA3U4JMDIrY6j6PENhNO4Yg4bXBaEdHsXs0CIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ewtF9KIJvYc+0nWFE0muIHCUH/lynpS3mkSY4gWWZloQPBKs
	Pj4foQCGmYloDdg5FSkJQ+9vfY9Nvr6l7RamRwU0qbvdRl2VCm5SdVL12FtzNylB
X-Gm-Gg: ASbGncu1zy16eWYUGzUWVDbme4X3Pm4cNmmi7F7yN0mU+oh716wPfjSQE0h9LiWJ9lo
	6E+HdAXSP2X5OkSmgHjwb/evFcDNLHXT8eKavcgblr8qxjzdWK0DyIURrWKsJywEF5iHf3e9DKk
	81a9T74gLt3dHZ8mwSa+yKhr0Sb+W8v++8sDU89LnfPydR7KDTC85YjTKI0cvVE9lz2gmEqtZrE
	8M6ULmoM/2spx3jbFnNeNCHT4XSXf6U1isjbBdR7bkIni/m/riyaDX1c5K4MBprs+pyE0STz71X
	rMLkKkSduPu2ahhTg62VQpVg2eKYojtcYsdxjxHvAJpLGVglD8emrPzzYho17lAGnJnTzqefdlx
	j/REi9JMVXWlza3yx
X-Google-Smtp-Source: AGHT+IHWgNswkxv+CABW5ywxmS6vy4bGJ+OPLt3ifTZZQwsCfS1mlcEMeDSYn3bOOIc8ZMIQFxDsug==
X-Received: by 2002:a05:6a20:12c3:b0:1f5:6abb:7cbb with SMTP id adf61e73a8af0-216219344b9mr34250247637.23.1747853735056;
        Wed, 21 May 2025 11:55:35 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:115c:1:cb3:38cf:dbbe:7f85? ([2620:10d:c090:500::6:8d1a])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8cc59sm9958932a12.40.2025.05.21.11.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 11:55:34 -0700 (PDT)
Message-ID: <45e399c6-74ad-4e58-bfda-06b392d1d28d@gmail.com>
Date: Wed, 21 May 2025 11:55:33 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Do not include stack ptr register in
 precision backtracking bookkeeping
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20250521170409.2772304-1-yonghong.song@linux.dev>
Content-Language: en-CA
From: Eduard Zingerman <eddyz87@gmail.com>
In-Reply-To: <20250521170409.2772304-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 78c97e12ea4e..e73a910e4ece 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -357,6 +357,10 @@ enum {
>   	INSN_F_SPI_SHIFT = 3, /* shifted 3 bits to the left */
>   
>   	INSN_F_STACK_ACCESS = BIT(9), /* we need 10 bits total */
> +
> +	INSN_F_DST_REG_STACK = BIT(10), /* dst_reg is PTR_TO_STACK */
> +	INSN_F_SRC_REG_STACK = BIT(11), /* src_reg is PTR_TO_STACK */

INSN_F_STACK_ACCESS can be inferred from INSN_F_DST_REG_STACK
and INSN_F_SRC_REG_STACK if insn_stack_access_flags() is adjusted
to track these flags instead. So, can be one less flag/bit.

> +	/* total 12 bits are used now. */
>   };
>   
>   static_assert(INSN_F_FRAMENO_MASK + 1 >= MAX_CALL_FRAMES);

[...]

> @@ -4402,6 +4418,8 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>   			 */
>   			return 0;
>   		} else if (BPF_SRC(insn->code) == BPF_X) {
> +			bool dreg_precise, sreg_precise;
> +
>   			if (!bt_is_reg_set(bt, dreg) && !bt_is_reg_set(bt, sreg))
>   				return 0;
>   			/* dreg <cond> sreg
> @@ -4410,8 +4428,16 @@ static int backtrack_insn(struct bpf_verifier_env *env, int idx, int subseq_idx,
>   			 * before it would be equally necessary to
>   			 * propagate it to dreg.
>   			 */
> -			bt_set_reg(bt, dreg);
> -			bt_set_reg(bt, sreg);
> +			if (!hist)
> +				return 0;
> +			dreg_precise = !insn_dreg_stack_ptr(hist->flags);
> +			sreg_precise = !insn_sreg_stack_ptr(hist->flags);
> +			if (!dreg_precise && !sreg_precise)
> +				return 0;
> +			if (dreg_precise)
> +				bt_set_reg(bt, dreg);
> +			if (sreg_precise)
> +				bt_set_reg(bt, sreg);

This check can be done in a generic way at backtrack_insn() callsite:
check which register is pointer to stack and remove it from set registers.

>   		} else if (BPF_SRC(insn->code) == BPF_K) {
>   			 /* dreg <cond> K
>   			  * Only dreg still needs precision before
> @@ -16397,6 +16423,29 @@ static void sync_linked_regs(struct bpf_verifier_state *vstate, struct bpf_reg_s
>   	}
>   }
>   
> +static int push_cond_jmp_history(struct bpf_verifier_env *env, struct bpf_verifier_state *state,
> +				 struct bpf_reg_state *dst_reg, struct bpf_reg_state *src_reg,
> +				 u64 linked_regs)
> +{
> +	bool dreg_stack_ptr, sreg_stack_ptr;
> +	int insn_flags;
> +
> +	if (!src_reg) {
> +		if (linked_regs)
> +			return push_insn_history(env, state, 0, linked_regs);
> +		return 0;
> +	}

Nit: this 'if' is not needed, src_reg is always set (it might point to a 
fake register,
      but in that case it is a scalar without id).

> +
> +	dreg_stack_ptr = dst_reg->type == PTR_TO_STACK;
> +	sreg_stack_ptr = src_reg->type == PTR_TO_STACK;
> +
> +	if (!dreg_stack_ptr && !sreg_stack_ptr && !linked_regs)
> +		return 0;
> +
> +	insn_flags = insn_reg_access_flags(dreg_stack_ptr, sreg_stack_ptr);
> +	return push_insn_history(env, state, insn_flags, linked_regs);
> +}
> +

[...]


