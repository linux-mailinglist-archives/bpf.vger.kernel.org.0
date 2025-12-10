Return-Path: <bpf+bounces-76382-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B327ACB18FE
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 02:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7AC7A3018439
	for <lists+bpf@lfdr.de>; Wed, 10 Dec 2025 01:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D48213E6A;
	Wed, 10 Dec 2025 01:02:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E119B1D88A4;
	Wed, 10 Dec 2025 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765328558; cv=none; b=KqJJLKtKfd882lpb5fOTWlbzFNdMAiGNWGWNdgS0SRrXdFQlau4bPgZZVwCxMs/OVWUA4yuT3rypAANIK7WV66iPIjN9npR2lnO2123+YVnM9GLEfU1O8Y1Xa9Uq7P8q8c6HKy50VAhk6lossR3MLA3irmW6YxurbiMphxlGb3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765328558; c=relaxed/simple;
	bh=Tq4APU8HYImbxLZy7t82goL1G2yf8uU8jSCt3R1y4VY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BGeXNcLOM2YUD3pDm9oLNuKLuPIuKyhAWEBPZ2UdtyzmZIMdeCN5Tfe9SuDt3thEJyrF9PNCYQByM28cXqllVItN775LCo1ZZNFW8PCJqxHOIdKd/Ef4d1QHlBIc+qktiiME9FY7/GqyHpqBV+foV5jRuAFcVJR5SFMhAC2dOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxM9Cgxjhpy9UsAA--.31787S3;
	Wed, 10 Dec 2025 09:02:24 +0800 (CST)
Received: from [10.130.40.83] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxG8GZxjhpZJ1HAQ--.22553S3;
	Wed, 10 Dec 2025 09:02:18 +0800 (CST)
Subject: Re: [PATCH v1 2/2] LoongArch: Enable BPF exception fixup for specific
 ADE subcode
To: Chenghao Duan <duanchenghao@kylinos.cn>, hengqi.chen@gmail.com,
 chenhuacai@kernel.org
Cc: kernel@xen0n.name, zhangtianyang@loongson.cn, masahiroy@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, guodongtai@kylinos.cn, youling.tang@linux.dev,
 jianghaoran@kylinos.cn, vincent.mc.li@gmail.com
References: <20251209093405.1309253-1-duanchenghao@kylinos.cn>
 <20251209093405.1309253-3-duanchenghao@kylinos.cn>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <9ae006cb-5081-20ce-ce29-9ba47dbede40@loongson.cn>
Date: Wed, 10 Dec 2025 09:02:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251209093405.1309253-3-duanchenghao@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxG8GZxjhpZJ1HAQ--.22553S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7try7Zr45Cry3Zr4kAF13trc_yoW8Wr43pF
	4UCF45KFWrGFn7X3ZrJ3y09ry3Ca95Jw47WrsFkr1rCF129r12gr1vy39rXF1Dt3y29rWI
	vF1Fvry0gay3CFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

On 2025/12/9 下午5:34, Chenghao Duan wrote:
> This patch allows the LoongArch BPF JIT to handle recoverable memory
> access errors generated by BPF_PROBE_MEM* instructions.
> 
> When a BPF program performs memory access operations, the instructions
> it executes may trigger ADEM exceptions. The kernel’s built-in BPF
> exception table mechanism (EX_TYPE_BPF) will generate corresponding
> exception fixup entries in the JIT compilation phase; however, the
> architecture-specific trap handling function needs to proactively call
> the common fixup routine to achieve exception recovery.
> 
> do_ade(): fix EX_TYPE_BPF memory access exceptions for BPF programs,
> ensure safe execution.
> 
> Signed-off-by: Chenghao Duan <duanchenghao@kylinos.cn>
> ---
>   arch/loongarch/kernel/traps.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
> index da5926fead4a..9ca8aacc82b8 100644
> --- a/arch/loongarch/kernel/traps.c
> +++ b/arch/loongarch/kernel/traps.c
> @@ -534,8 +534,13 @@ asmlinkage void noinstr do_fpe(struct pt_regs *regs, unsigned long fcsr)
>   
>   asmlinkage void noinstr do_ade(struct pt_regs *regs)
>   {
> -	irqentry_state_t state = irqentry_enter(regs);
> +	irqentry_state_t state;
> +	unsigned int esubcode = FIELD_GET(CSR_ESTAT_ESUBCODE, regs->csr_estat);
> +
> +	if ((esubcode == 1) && fixup_exception(regs))

Please use the existing EXSUBCODE_ADEM macro definition instead of
the magic value 1.

Thanks,
Tiezhu


