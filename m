Return-Path: <bpf+bounces-45450-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4C79D5A1D
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 08:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF6CBB220CB
	for <lists+bpf@lfdr.de>; Fri, 22 Nov 2024 07:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925FE1741C6;
	Fri, 22 Nov 2024 07:39:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56C6156C40;
	Fri, 22 Nov 2024 07:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732261196; cv=none; b=pHVTwNHNUYcmLf6pNCwfesjGtRovzm6uKLsHafMQSJdLINBKQWYY1K2Ojq2iWGU3SJRk1uvbVwgCbV6fi6cXu0I3Zt8qyp5mvwutKyEeEivN1yFOAziZwRrTy4RuOk2f7OC6JSHD7rra+bFQeXVaDptyAWD+L2l09oVINbX4wew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732261196; c=relaxed/simple;
	bh=JIco9AWeLSoaR1KYuj+BvTtVCXXIWjicWNQO08uVO7I=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kT/Nwm+4tZMmG0ZxvD/fbAJXxK9/aYMLcYlLYvYpH2gvlknjcIoGOb1/TIH5RIvg7U+Iw8D0lv+zrlYrQk6s3cLweZBzYwMFHwhJ8zHYfXDuVKR9XDVUoIXLe0VU0qeA1jFHnlLRlbq80kRicP9uSiJefxe2b6CTDD3ntYMudEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8CxSOFGNUBnP9xFAA--.5272S3;
	Fri, 22 Nov 2024 15:39:50 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDx+0ZFNUBnH8liAA--.35062S3;
	Fri, 22 Nov 2024 15:39:50 +0800 (CST)
Subject: Re: [PATCH] LoongArch: BPF: Sign-extend return values
To: John Fastabend <john.fastabend@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
References: <20241119065230.19157-1-yangtiezhu@loongson.cn>
 <673fd322ce3ac_1118208b3@john.notmuch>
Cc: loongarch@lists.linux.dev, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <4f6c74e0-dd22-8460-96fa-f408291a3ef8@loongson.cn>
Date: Fri, 22 Nov 2024 15:39:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <673fd322ce3ac_1118208b3@john.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowMDx+0ZFNUBnH8liAA--.35062S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF17Zr45CrWDCrWxAw1rKrX_yoW8Zr1fpr
	9xAa9IyFWDW34jq3ZFy3y5Wr18KrsxWFW3Wa4YgryUXFnIva48Xw18Kws8XFZYvw48Wa4I
	qr90y343Aa1DJacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
	AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
	1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
	uc_UUUUU=

On 11/22/2024 08:41 AM, John Fastabend wrote:
> Tiezhu Yang wrote:
>> (1) Description of Problem:
>>
>> When testing BPF JIT with the latest compiler toolchains on LoongArch,
>> there exist some strange failed test cases, dmesg shows something like
>> this:
>>
>>   # dmesg -t | grep FAIL | head -1
>>   ... ret -3 != -3 (0xfffffffd != 0xfffffffd)FAIL ...

...

>>
>> (5) Final Solution:
>>
>> Keep a5 zero-extended, but explicitly sign-extend a0 (which is used
>> outside BPF land). Because libbpf currently defines the return value
>> of an ebpf program as a 32-bit unsigned integer, just use addi.w to
>> extend bit 31 into bits 63 through 32 of a5 to a0. This is similar
>> with commit 2f1b0d3d7331 ("riscv, bpf: Sign-extend return values").
>>
>> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>  arch/loongarch/net/bpf_jit.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index 7dbefd4ba210..dd350cba1252 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
>> @@ -179,7 +179,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
>>
>>  	if (!is_tail_call) {
>>  		/* Set return value */
>> -		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
>> +		emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0], 0);
>
> Not overly familiar with this JIT but just to check this wont be used
> for BPF 2 BPF calls correct?

I am not sure I understand your comment correctly, but with and without
this patch, the LoongArch JIT uses a5 as a dedicated register for BPF
return values, a5 is kept as zero-extended for bpf2bpf, just make a0
(which is used outside BPF land) as sign-extend, all of the test cases
in test_bpf.ko passed with "echo 1 > /proc/sys/net/core/bpf_jit_enable".

Thanks,
Tiezhu


