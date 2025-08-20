Return-Path: <bpf+bounces-66059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3E8B2D2EB
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 06:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A545C2A6340
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 04:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6BC24293B;
	Wed, 20 Aug 2025 04:23:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54481231836
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 04:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755663794; cv=none; b=kqTQtvqBoWmuVgtbb2nZ26MpfXt2k2uVdUyDHcK1ED2MZRL/erzj2vjHHrM/sSy0Ur1/LUw/k/mpYHTfVoj/Mkbhh6N5vbISawYoZXY1hKA7YSK9bdU/AzcOFDldLvkzSKO8N03gwADBfDYaWzxLugrTJm/0xHdlT57SPaSN0Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755663794; c=relaxed/simple;
	bh=B4WSx1hkjtn95J6BwbkXzAJIJRNUKcTF39Bhe9cIedc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OFsrtjxneRkL9Se06arIyqehB9zcZQM6sQ9H6wtBVb3i0ZUdIsjCXevCi49bXlkNwIkAvPOdUa4gSEvImFqIASuW8CpgrzTRDaEPkBqkK524cq6ADg8mVDUts8eB7F8wSHdRXXPJMgNHAX71swxHLXNNKxq1MqQbtLliazI1xSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Dx+tGsTaVoRLkAAA--.1387S3;
	Wed, 20 Aug 2025 12:23:08 +0800 (CST)
Received: from [10.130.10.66] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDx_8OpTaVos_VZAA--.13848S3;
	Wed, 20 Aug 2025 12:23:06 +0800 (CST)
Subject: Re: [PATCH v2] LoongArch: BPF: Fix incorrect return pointer value in
 the eBPF program
To: Haoran Jiang <jianghaoran@kylinos.cn>, loongarch@lists.linux.dev
Cc: bpf@vger.kernel.org, kernel@xen0n.name, chenhuacai@kernel.org,
 hengqi.chen@gmail.com, jolsa@kernel.org, haoluo@google.com, sdf@fomichev.me,
 kpsingh@kernel.org, john.fastabend@gmail.com, yonghong.song@linux.dev,
 song@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, Jinyang He <hejinyang@loongson.cn>
References: <20250815082931.875216-1-jianghaoran@kylinos.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <59d7abe2-c49f-54cc-2095-fee6aa443f6e@loongson.cn>
Date: Wed, 20 Aug 2025 12:23:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250815082931.875216-1-jianghaoran@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx_8OpTaVos_VZAA--.13848S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXw48CryfCry3Zr43ZFWkAFc_yoW5Ar17pr
	ZxAF4kGrs0g348XFyIqanI9r18tF4kurya93srGryUurnxXr95Xr1rKwn8WFZ8Aw1rKF40
	q3Z5ZwnavF4DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j0mhrUUUUU=

On 2025/8/15 下午4:29, Haoran Jiang wrote:
> In some eBPF programs, the return value is a pointer.
> When the kernel call an eBPF program (such as struct_ops),
> it expects a 64-bit address to be returned, but instead a 32-bit value.

With this v2 patch and the v1 patch:

$ sudo modprobe test_bpf
modprobe: ERROR: could not insert 'test_bpf': Invalid argument
$ dmesg -t | grep Summary
test_bpf: Summary: 1039 PASSED, 14 FAILED, [1041/1041 JIT'ed]

Without the patches, all of the tests passed.
This is related with the previous fix:
LoongArch: BPF: Sign-extend return values
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=73c359d1d356

> diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
> index 277d2140676b..20f4fc745bea 100644
> --- a/arch/loongarch/include/asm/inst.h
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -92,6 +92,8 @@ enum reg2i6_op {
>   };
>   
>   enum reg2i12_op {
> +	slti_op         = 0x08,
> +	sltui_op        = 0x09,
>   	addiw_op	= 0x0a,
>   	addid_op	= 0x0b,
>   	lu52id_op	= 0x0c,
> @@ -148,6 +150,8 @@ enum reg3_op {
>   	addd_op		= 0x21,
>   	subw_op		= 0x22,
>   	subd_op		= 0x23,
> +	slt_op          = 0x24,
> +	sltu_op         = 0x25,

Only slt is used in bpf_jit.c,
slti, sltui and sltu can be removed
because they are not used in this patch.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index abfdb6bb5c38..50067be79c4f 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -229,8 +229,21 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
>   	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
>   
>   	if (!is_tail_call) {
> -		/* Set return value */
> -		emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0], 0);
> +		/*
> +		 *  Set return value

It is better to update the comment:

The return value is either a unsigned 32-bit value or a unsigned 64-bit 
address.

> +		 *  Check if the 64th bit in regmap[BPF_REG_0] is 1. If it is,
> +		 *  the value in regmap[BPF_REG_0] is a kernel-space address.
> +
> +		 *  long long val = regmap[BPF_REG_0];
> +		 *  int shift = 0 < val ? 32 : 0;
> +		 *  return (val << shift) >> shift;
> +		 */
> +		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> +		emit_insn(ctx, slt, LOONGARCH_GPR_T0, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_A0);

LOONGARCH_GPR_T0 may be not the expected value 1 if the return value
is a unsigned 32-bit value.

A quick way to verify this issue:

Add "move_imm(ctx, LOONGARCH_GPR_T0, 1, true)" after "slt" to force
LOONGARCH_GPR_T0 as 1 can fix the above failed tests.

The initial conclusion is that if the 64th bit in regmap[BPF_REG_0]
is 1, it can not recognize the value in regmap[BPF_REG_0] must be a
kernel-space address, it may be a unsigned 32-bit return value, for
this case just use addi.w to extend bit 31 into bits 63 through 32
of a5 to a0.

Thanks,
Tiezhu


