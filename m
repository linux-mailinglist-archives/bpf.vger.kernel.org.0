Return-Path: <bpf+bounces-66139-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C535BB2E9AE
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 02:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD4747BA8F6
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FF41E5B64;
	Thu, 21 Aug 2025 00:49:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE79B1B2186
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 00:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737342; cv=none; b=IL9w5l6S0rH9CiIJhTOKO4WKpAxGxjgDsyhPT0X1c/X0vmW5tbIpKVoG5SD6IwSeaHgIfcpq0ghzwACraicEG2Tr6DfNEMKh7DoM8utzmZb4n2yZldRGzdW5gxYOBSmTmj7Yz+Nw8nu3AuX6fVk+Ehkn2A8OEkJh+VUGLmkQlbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737342; c=relaxed/simple;
	bh=1+aUn81oPITWZVMYkwbZC65h1fH37rWb9oqzIFm/e4g=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hMOQ3w4m0FZ2HQo80rwhPzdsuidyTX3SDLBcSO5nCoJFvemwemKZtx9EuW9GuizKvSX9AH7BdU3IY8B0dH1F/zAaiqFrwXhrIdDKBsBVVW84SvFidsNs3skTU3Xy1+nStK3K1rOmXvlMQ1nmEiiXuT1Gc24Nd+E9/KL/pPSiLiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8BxF9H4bKZoKSsBAA--.2140S3;
	Thu, 21 Aug 2025 08:48:56 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowJDxQ+T1bKZoWkFcAA--.21914S3;
	Thu, 21 Aug 2025 08:48:55 +0800 (CST)
Subject: Re: [PATCH] LoongArch: BPF: Sign extend struct ops return values
 properly
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: chenhuacai@kernel.org, yangtiezhu@loongson.cn, jianghaoran@kylinos.cn,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, vincent.mc.li@gmail.com, bpf@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20250820103956.394955-1-hengqi.chen@gmail.com>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <0cf37a7c-2e14-58f2-1a1e-9311b2e65d4a@loongson.cn>
Date: Thu, 21 Aug 2025 08:48:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250820103956.394955-1-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:qMiowJDxQ+T1bKZoWkFcAA--.21914S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxArW5GFy3Aw1DAryxXFyxZwc_yoW5GF1Dpr
	1jkrW8CFy8try3XaykXr1DKF1ak3Wqq3sxu3429rZ5W3y3XrW5JF1rGr1FkryYkr1DAFyx
	AFs0yw4v93W7GrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HKZJUUUUU==

On 2025-08-20 18:39, Hengqi Chen wrote:

> The ns_bpf_qdisc selftest triggers a kernel panic:
>
[...]
>   
> +/*
> + * Sign-extend the register if necessary
> + */
> +static int sign_extend(struct jit_ctx *ctx, int r, u8 size)
> +{
> +	switch (size) {
> +	case 1:
> +		emit_insn(ctx, sllid, r, r, 56);
> +		emit_insn(ctx, sraid, r, r, 56);
> +		return 0;
> +	case 2:
> +		emit_insn(ctx, sllid, r, r, 48);
> +		emit_insn(ctx, sraid, r, r, 48);
> +		return 0;
Hi, Hengqi,

For sign-extend char or short, we can use `ext.w.b` or `ext.w.h`.


> +	case 4:
> +		emit_insn(ctx, addiw, r, r, 0);
> +		return 0;
> +	case 8:
> +		return 0;
> +	default:
> +		return -1;
> +	}
> +}
> +
>   static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   					 const struct btf_func_model *m, struct bpf_tramp_links *tlinks,
>   					 void *func_addr, u32 flags)
> @@ -1602,8 +1628,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>   	}
>   
>   	for (i = 0; i < fentry->nr_links; i++) {
> -		ret = invoke_bpf_prog(ctx, fentry->links[i], args_off, retval_off,
> -				      run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);
> +		ret = invoke_bpf_prog(ctx, fentry->links[i], m, args_off, retval_off,
> +			      run_ctx_off, flags & BPF_TRAMP_F_RET_FENTRY_RET);
>   		if (ret)
>   			return ret;
>   	}
> @@ -1612,7 +1638,7 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>   		if (!branches)
>   			return -ENOMEM;
>   
> -		invoke_bpf_mod_ret(ctx, fmod_ret, args_off, retval_off, run_ctx_off, branches);
> +		invoke_bpf_mod_ret(ctx, fmod_ret, m, args_off, retval_off, run_ctx_off, branches);
>   	}
>   
>   	if (flags & BPF_TRAMP_F_CALL_ORIG) {
> @@ -1638,7 +1664,8 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>   	}
>   
>   	for (i = 0; i < fexit->nr_links; i++) {
> -		ret = invoke_bpf_prog(ctx, fexit->links[i], args_off, retval_off, run_ctx_off, false);
> +		ret = invoke_bpf_prog(ctx, fexit->links[i], m, args_off,
> +				      retval_off, run_ctx_off, false);
>   		if (ret)
>   			goto out;
>   	}
> @@ -1657,6 +1684,12 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>   	if (save_ret) {
>   		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
>   		emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
> +		if (is_struct_ops) {
> +			move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> +			ret = sign_extend(ctx, LOONGARCH_GPR_A0, m->ret_size);
> +			if (ret)
> +				goto out;
> +		}
>   	}
>   
>   	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);


