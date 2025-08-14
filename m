Return-Path: <bpf+bounces-65642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112C3B2661E
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 15:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8FD621E49
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 12:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1F82FD1C5;
	Thu, 14 Aug 2025 12:59:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036FC2FCBF1
	for <bpf@vger.kernel.org>; Thu, 14 Aug 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176392; cv=none; b=AExaYUy8ZdZKQI2bLgDoDB9XG4oX4Vkm6pUwUsKZCZoygRD6Appa2LtlpdjIM7NLVyfUnFEtgUumCcLsBj9PrJIvwK51xjr9zQCkyOkn++LQPv3fBq0DVaBJ0u2dYLxnczBnE1GiHdUeym2+CJtwgNOYgbDtpuHOM9ywg5Dzhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176392; c=relaxed/simple;
	bh=8WaW6S8VyWowk2N44AiG+YQrHgbOn9uWim3TkAEYThc=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fJlYz/eshfYoWuRsJlQwxQRtP2Bddfvi4aRYiJHxh3m1CV1eSUxtkD5Fl/xIA4WISS8JkPcukG1uH8Y1RoXN5PvGB8zJF+d6U1vcGrIUdq0814Y84A4nNXgzUvUsx8xg5FVz+Lq83MiKz53KC1F01ZE9a4K44QUswdAvLVTPRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8AxaeHB3Z1oO8w_AQ--.12496S3;
	Thu, 14 Aug 2025 20:59:45 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowJAxVOS83Z1oMXZLAA--.27399S3;
	Thu, 14 Aug 2025 20:59:43 +0800 (CST)
Subject: Re: [PATCH] LoongArch: BPF: Fix incorrect return pointer value in the
 eBPF program
To: Haoran Jiang <jianghaoran@kylinos.cn>, loongarch@lists.linux.dev
Cc: bpf@vger.kernel.org, kernel@xen0n.name, chenhuacai@kernel.org,
 hengqi.chen@gmail.com, yangtiezhu@loongson.cn, jolsa@kernel.org,
 haoluo@google.com, sdf@fomichev.me, kpsingh@kernel.org,
 john.fastabend@gmail.com, yonghong.song@linux.dev, song@kernel.org,
 eddyz87@gmail.com, martin.lau@linux.dev, andrii@kernel.org,
 daniel@iogearbox.net, ast@kernel.org
References: <20250814013412.108668-1-jianghaoran@kylinos.cn>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <2e3f565b-0c5a-76d0-697f-31f0725de834@loongson.cn>
Date: Thu, 14 Aug 2025 20:59:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250814013412.108668-1-jianghaoran@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJAxVOS83Z1oMXZLAA--.27399S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxury5GFW7uF1kXr4xGr4xXwc_yoW5uF1Upr
	W7uFWkCr48W347WF1Iqa1F9F1akFs3WFW3C34ftrWFvrnxZa4fX3W5K34fuFs8Cw1vqr4f
	Xrn0ya9a9F1kAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

On 2025-08-14 09:34, Haoran Jiang wrote:

> In some eBPF programs, the return value is a pointer.
> When the kernel call an eBPF program (such as struct_ops),
> it expects a 64-bit address to be returned, but instead a 32-bit value.
>
> Before applying this patch:
> ./test_progs -a ns_bpf_qdisc
> CPU 7 Unable to handle kernel paging request at virtual
> address 0000000010440158.
>
> As shown in the following test case,
> bpf_fifo_dequeue return value is a pointer.
> progs/bpf_qdisc_fifo.c
>
> SEC("struct_ops/bpf_fifo_dequeue")
> struct sk_buff *BPF_PROG(bpf_fifo_dequeue, struct Qdisc *sch)
> {
> 	struct sk_buff *skb = NULL;
> 	........
> 	skb = bpf_kptr_xchg(&skbn->skb, skb);
> 	........
> 	return skb;
> }
>
> kernel call bpf_fifo_dequeue：
> net/sched/sch_generic.c
>
> static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
> 				   int *packets)
> {
> 	struct sk_buff *skb = NULL;
> 	........
> 	skb = q->dequeue(q);
> 	.........
> }
> When accessing the skb, an address exception error will occur.
> because the value returned by q->dequeue at this point is a 32-bit
> address rather than a 64-bit address.
>
> After applying the patch：
> ./test_progs -a ns_bpf_qdisc
> Warning: sch_htb: quantum of class 10001 is small. Consider r2q change.
> 213/1   ns_bpf_qdisc/fifo:OK
> 213/2   ns_bpf_qdisc/fq:OK
> 213/3   ns_bpf_qdisc/attach to mq:OK
> 213/4   ns_bpf_qdisc/attach to non root:OK
> 213/5   ns_bpf_qdisc/incompl_ops:OK
> 213     ns_bpf_qdisc:OK
> Summary: 1/5 PASSED, 0 SKIPPED, 0 FAILED
>
> Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
> Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>
> ---
>   arch/loongarch/net/bpf_jit.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index abfdb6bb5c38..7df067a42f36 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -229,8 +229,24 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
>   	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, stack_adjust);
>   
>   	if (!is_tail_call) {
> -		/* Set return value */
> +		/*
> +		 *  Set return value
> +		 *  Check if the 64th bit in regmap[BPF_REG_0] is 1. If it is,
> +		 *  the value in regmap[BPF_REG_0] is a kernel-space address.
> +		 *
> +		 *  t1 = regmap[BPF_REG_0] >> 63
> +		 *  t2 = 1
> +		 *  if(t2 == t1)
> +		 *	move a0 <- regmap[BPF_REG_0]
> +		 *  else
> +		 *	addiw a0 <- regmap[BPF_REG_0] + 0
> +		 */
> +		emit_insn(ctx, srlid, LOONGARCH_GPR_T1, regmap[BPF_REG_0], 63);
> +		emit_insn(ctx, addid, LOONGARCH_GPR_T2, LOONGARCH_GPR_ZERO, 0x1);
> +		emit_cond_jmp(ctx, BPF_JEQ, LOONGARCH_GPR_T1, LOONGARCH_GPR_T2, 3);

Hi, Haoran,

Just for codegen, we have many ways to avoid branch. Follows is a 
possible way.

long long val = regmap[BPF_REG_0];
int shift = 0 < val ? 32 : 0;
return (val << shift) >> shift;

slt    t0, zero, BPF_REG_0
slli.d t0, t0, 5
sll.d  BPF_REG_0, BPF_REG_0, t0
sra.d  BPF_REG_0, BPF_REG_0, t0


>   		emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0], 0);
> +		emit_uncond_jmp(ctx, 2);
> +		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
>   		/* Return to the caller */
>   		emit_insn(ctx, jirl, LOONGARCH_GPR_ZERO, LOONGARCH_GPR_RA, 0);
>   	} else {


