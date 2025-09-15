Return-Path: <bpf+bounces-68379-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CE6B57507
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 11:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A32F7A8F5F
	for <lists+bpf@lfdr.de>; Mon, 15 Sep 2025 09:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EEC2F549F;
	Mon, 15 Sep 2025 09:40:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D2F2F8BCD;
	Mon, 15 Sep 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757929200; cv=none; b=GAjwSVPM4J7jntrf5rCEC23dDN5W6aZrXo9+3p2r0mK+C2q8am8HQTs5zN3v1nvR1TNmCGe+YVHOj38b8/CIxUmaXg7I81wcFwCKHRWfTyMm+sPEVB1q9gfLyYf3mhlWFKoJpbS10QyTl1RI4JRJ9YdDMNDPqNSs4bbWPzUhLwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757929200; c=relaxed/simple;
	bh=QAy7zjoSXL8LoSc9mui5Kk8sWwbWDhbvAHdhgzvjixQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYXezNJC8LjQpmFLgo5Y24sGQma2nJrjk6oXzKA0s77HbnzRwm2Rw+rsUQRegoRfiH+Rt/ur1Hujesxc/R5j1+Ula7XKYC4Qk5GTepAJrQqmaaEYH8CbeNgn4E5kRank3OcvdUVVIEBlqfqUzbbcjeSipNHIKKAarxt7jvwxMUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cQKkh1kFCzYQvZv;
	Mon, 15 Sep 2025 17:39:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id C8D6C1A0D20;
	Mon, 15 Sep 2025 17:39:54 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgBX82rn3sdoJxUmCg--.53822S2;
	Mon, 15 Sep 2025 17:39:53 +0800 (CST)
Message-ID: <a806d318-e51b-4e79-8d36-15d9a78af66b@huaweicloud.com>
Date: Mon, 15 Sep 2025 17:39:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 08/10] riscv, bpf: Add ex_insn_off and ex_jmp_off
 for exception table handling
To: Chris Mason <clm@meta.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
References: <20250913155133.657930-1-clm@meta.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20250913155133.657930-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBX82rn3sdoJxUmCg--.53822S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4rKr4fXrWkCFyrWr4xXrb_yoW5Xry8pF
	WUJ3s3AFWvgr1rJasrX3WUJw43Zan09rnrGrn5Wry3JFnIqF1IkF1fKayYya98Cry0gw1r
	ZFWqvryfCas3A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/9/13 23:51, Chris Mason wrote:
> On Sat, 19 Jul 2025 09:17:28 +0000 Pu Lehui <pulehui@huaweicloud.com> wrote:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Add ex_insn_off and ex_jmp_off fields to struct rv_jit_context so that
>> add_exception_handler() does not need to be immediately followed by the
>> instruction to add the exception table. ex_insn_off indicates the offset
>> of the instruction to add the exception table, and ex_jmp_off indicates
>> the offset to jump over the faulting instruction. This is to prepare for
>> adding the exception table to atomic instructions later, because some
>> atomic instructions need to perform zext or other operations.
>>
> 
> Hi everyone,
> 
> I've been working on some patch review automation, and I recently ran it on
> the bpf-next branch.  I don't know the verifier well enough to decide if this
> is a false positive, but Alexei asked me to kick off discussion, so:
> 
>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>> index 8e813809d3054..56b592af53a64 100644
>> --- a/arch/riscv/net/bpf_jit_comp64.c
>> +++ b/arch/riscv/net/bpf_jit_comp64.c
> 
> [ ... ]
> 
>> -static int emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
>> +static void emit_stx(u8 rd, s16 off, u8 rs, u8 size, struct rv_jit_context *ctx)
>>   {
>> -	int insns_start;
>> -
>>   	if (is_12b_int(off)) {
>> -		insns_start = ctx->ninsns;
>> +		ctx->ex_insn_off = ctx->ninsns;
>>   		emit_stx_insn(rd, off, rs, size, ctx);
>> -		return ctx->ninsns - insns_start;
>> +		ctx->ex_jmp_off = ctx->ex_jmp_off;

Hi Chris,

I'm not sure if I have misunderstood your intention, maybe just for 
talking about reviewing automation? But the code I checked in the 
bpf-next branch is inconsistent with yours. The code here in bpf-next is:

`ctx->ex_jmp_off = ctx->ninsns;`

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/riscv/net/bpf_jit_comp64.c?h=next-20250912#n553

> 
> Does this assignment leave ex_jmp_off uninitialized? Looking at emit_ldx()
> and emit_st(), this should probably be "ctx->ex_jmp_off = ctx->ninsns;" to
> match the pattern. Without proper initialization, add_exception_handler()
> might use stale offset values when creating exception table entries for
> the is_12b_int() code path in emit_stx().
> 
>> +		return;
>>   	}
>>   
>>   	emit_imm(RV_REG_T1, off, ctx);
>>   	emit_add(RV_REG_T1, RV_REG_T1, rd, ctx);
>> -	insns_start = ctx->ninsns;
>> +	ctx->ex_insn_off = ctx->ninsns;
>>   	emit_stx_insn(RV_REG_T1, 0, rs, size, ctx);
>> -	return ctx->ninsns - insns_start;
>> +	ctx->ex_jmp_off = ctx->ninsns;
>>   }
> 
> -chris


