Return-Path: <bpf+bounces-66784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE67B393A7
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 08:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E647AEE63
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 06:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D652727F4;
	Thu, 28 Aug 2025 06:11:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2470C235044
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756361511; cv=none; b=L72VxL1NxrWCHiKoa8AdR0X9Hdyu8LaGAclJCxj+pf/rptxQuv29iBHmKF3oXY1zyJNQHy3ZXg1JOPC+BtL09y5jR3z0/ZSIXyhkP/bHc03TP3ezekHMivjFiLEivUVmYDw2gH3X8SpRMea3X3twDvWVsCn3mB7IiCV3cYrfAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756361511; c=relaxed/simple;
	bh=lwvGpZd9Wc1hAoG7izHSzPzyLxxwH5ozhKZsFkl9ws0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=g6ST9tFnsUecSj/7TAMxwGxKlnWBJULPzOe3lVrc1wKPDyFX2rowbDLz6KVqDUHft15cMk2xu6uLw6WTDkvmb+A2DCMmz3Gg0TqHOa0QVubbLkL7XYR3xE4LW0eykjADa0RtvmDnKrjR+sk1aUemv+6HcImYL2koUL9qlsw+FKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [111.9.175.10])
	by gateway (Coremail) with SMTP id _____8Bx2tEf869otw4EAA--.8168S3;
	Thu, 28 Aug 2025 14:11:43 +0800 (CST)
Received: from [10.136.12.26] (unknown [111.9.175.10])
	by front1 (Coremail) with SMTP id qMiowJAxfcEb869oqs1tAA--.25995S3;
	Thu, 28 Aug 2025 14:11:41 +0800 (CST)
Subject: Re: [PATCH v2 2/3] LoongArch: BPF: Sign extend struct ops return
 values properly
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: chenhuacai@kernel.org, yangtiezhu@loongson.cn, jianghaoran@kylinos.cn,
 duanchenghao@kylinos.cn, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, vincent.mc.li@gmail.com,
 bpf@vger.kernel.org, loongarch@lists.linux.dev
References: <20250827094733.426839-1-hengqi.chen@gmail.com>
 <20250827094733.426839-3-hengqi.chen@gmail.com>
From: Jinyang He <hejinyang@loongson.cn>
Message-ID: <9cf3a423-6d7d-91ae-d9af-3587fad9b70b@loongson.cn>
Date: Thu, 28 Aug 2025 14:11:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250827094733.426839-3-hengqi.chen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJAxfcEb869oqs1tAA--.25995S3
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtFy8Cr4UGr15Ww4fAw1fGrX_yoWxXF48pr
	yjyr48GF48Jr17JF1xAF1UCr15Jrs3AFyUGryxJrWUXr1UXr1UJFy8JrW5GFy5Ar4UJr1x
	Jrn0yw15tF1UJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8m2NtUUUUU==

On 2025-08-27 17:47, Hengqi Chen wrote:

> The ns_bpf_qdisc selftest triggers a kernel panic:
>
>      CPU 0 Unable to handle kernel paging request at virtual address 0000000000741d58, era == 90000000851b5ac0, ra == 90000000851b5aa4
>      Oops[#1]:
>      CPU: 0 UID: 0 PID: 449 Comm: test_progs Tainted: G           OE       6.16.0+ #3 PREEMPT(full)
>      Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>      Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 2/2/2022
>      pc 90000000851b5ac0 ra 90000000851b5aa4 tp 90000001076b8000 sp 90000001076bb600
>      a0 0000000000741ce8 a1 0000000000000001 a2 90000001076bb5c0 a3 0000000000000008
>      a4 90000001004c4620 a5 9000000100741ce8 a6 0000000000000000 a7 0100000000000000
>      t0 0000000000000010 t1 0000000000000000 t2 9000000104d24d30 t3 0000000000000001
>      t4 4f2317da8a7e08c4 t5 fffffefffc002f00 t6 90000001004c4620 t7 ffffffffc61c5b3d
>      t8 0000000000000000 u0 0000000000000001 s9 0000000000000050 s0 90000001075bc800
>      s1 0000000000000040 s2 900000010597c400 s3 0000000000000008 s4 90000001075bc880
>      s5 90000001075bc8f0 s6 0000000000000000 s7 0000000000741ce8 s8 0000000000000000
>         ra: 90000000851b5aa4 __qdisc_run+0xac/0x8d8
>        ERA: 90000000851b5ac0 __qdisc_run+0xc8/0x8d8
>       CRMD: 000000b0 (PLV0 -IE -DA +PG DACF=CC DACM=CC -WE)
>       PRMD: 00000004 (PPLV0 +PIE -PWE)
>       EUEN: 00000007 (+FPE +SXE +ASXE -BTE)
>       ECFG: 00071c1d (LIE=0,2-4,10-12 VS=7)
>      ESTAT: 00010000 [PIL] (IS= ECode=1 EsubCode=0)
>       BADV: 0000000000741d58
>       PRID: 0014c010 (Loongson-64bit, Loongson-3A5000)
>      Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)]
>      Process test_progs (pid: 449, threadinfo=000000009af02b3a, task=00000000e9ba4956)
>      Stack : 0000000000000000 90000001075bc8ac 90000000869524a8 9000000100741ce8
>              90000001075bc800 9000000100415300 90000001075bc8ac 0000000000000000
>              900000010597c400 900000008694a000 0000000000000000 9000000105b59000
>              90000001075bc800 9000000100741ce8 0000000000000050 900000008513000c
>              9000000086936000 0000000100094d4c fffffff400676208 0000000000000000
>              9000000105b59000 900000008694a000 9000000086bf0dc0 9000000105b59000
>              9000000086bf0d68 9000000085147010 90000001075be788 0000000000000000
>              9000000086bf0f98 0000000000000001 0000000000000010 9000000006015840
>              0000000000000000 9000000086be6c40 0000000000000000 0000000000000000
>              0000000000000000 4f2317da8a7e08c4 0000000000000101 4f2317da8a7e08c4
>              ...
>      Call Trace:
>      [<90000000851b5ac0>] __qdisc_run+0xc8/0x8d8
>      [<9000000085130008>] __dev_queue_xmit+0x578/0x10f0
>      [<90000000853701c0>] ip6_finish_output2+0x2f0/0x950
>      [<9000000085374bc8>] ip6_finish_output+0x2b8/0x448
>      [<9000000085370b24>] ip6_xmit+0x304/0x858
>      [<90000000853c4438>] inet6_csk_xmit+0x100/0x170
>      [<90000000852b32f0>] __tcp_transmit_skb+0x490/0xdd0
>      [<90000000852b47fc>] tcp_connect+0xbcc/0x1168
>      [<90000000853b9088>] tcp_v6_connect+0x580/0x8a0
>      [<90000000852e7738>] __inet_stream_connect+0x170/0x480
>      [<90000000852e7a98>] inet_stream_connect+0x50/0x88
>      [<90000000850f2814>] __sys_connect+0xe4/0x110
>      [<90000000850f2858>] sys_connect+0x18/0x28
>      [<9000000085520c94>] do_syscall+0x94/0x1a0
>      [<9000000083df1fb8>] handle_syscall+0xb8/0x158
>
>      Code: 4001ad80  2400873f  2400832d <240073cc> 001137ff  001133ff  6407b41f  001503cc  0280041d
>
>      ---[ end trace 0000000000000000 ]---
>
> The bpf_fifo_dequeue prog returns a skb which is a pointer.
> The pointer is treated as a 32bit value and sign extend to
> 64bit in epilogue. This behavior is right for most bpf prog
> types but wrong for struct ops which requires LoongArch ABI.
>
> So let's sign extend struct ops return values according to
> the return value spec in function model.
>
> Fixes: 6abf17d690d8 ("LoongArch: BPF: Add struct ops support for trampoline")
> Tested-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> Tested-by: Vincent Li <vincent.mc.li@gmail.com>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>   arch/loongarch/net/bpf_jit.c | 26 ++++++++++++++++++++++++++
>   1 file changed, 26 insertions(+)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index b646c6b73014..c239e5ed0c92 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1448,6 +1448,28 @@ void arch_free_bpf_trampoline(void *image, unsigned int size)
>   	bpf_prog_pack_free(image, size);
>   }
>   
> +/*
> + * Sign-extend the register if necessary
> + */
> +static void sign_extend(struct jit_ctx *ctx, int r, u8 size)
> +{
> +	switch (size) {
> +	case 1:
> +		emit_insn(ctx, extwb, r, r);
> +		break;
> +	case 2:
> +		emit_insn(ctx, extwh, r, r);
> +		break;
> +	case 4:
> +		emit_insn(ctx, addiw, r, r, 0);
> +		break;
> +	case 8:
> +		break;
> +	default:
> +		pr_warn("bpf_jit: invalid size %d for sign_extend\n", size);
> +	}
> +}
> +
>   static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
>   					 const struct btf_func_model *m, struct bpf_tramp_links *tlinks,
>   					 void *func_addr, u32 flags)
> @@ -1654,6 +1676,10 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
>   	if (save_ret) {
>   		emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
>   		emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, -(retval_off - 8));
> +		if (is_struct_ops) {
> +			move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> +			sign_extend(ctx, LOONGARCH_GPR_A0, m->ret_size);
> +		}
>   	}
Hi, Hengqi,

It can be did same as Tiezhu's patch, named "LoongArch: BPF: Optimize
sign-extention mov instructions", which use only one sign-extend 
instruction.

And btw, how about,
if (save_ret) {
   if (is_struct_ops) {
     ld.{d,w,h,b} LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -(retval_off - 8)
     emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, 
-(retval_off - 8)); // I don't know is it needed.
   } else {
     emit_insn(ctx, ldd, LOONGARCH_GPR_A0, LOONGARCH_GPR_FP, -retval_off);
     emit_insn(ctx, ldd, regmap[BPF_REG_0], LOONGARCH_GPR_FP, 
-(retval_off - 8));
   }
}
>   
>   	emit_insn(ctx, ldd, LOONGARCH_GPR_S1, LOONGARCH_GPR_FP, -sreg_off);


