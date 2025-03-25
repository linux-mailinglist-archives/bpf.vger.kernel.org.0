Return-Path: <bpf+bounces-54696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5DDA70669
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9F818974B1
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C225745A;
	Tue, 25 Mar 2025 16:13:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97F31990AB
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742919217; cv=none; b=iNIoaTJXYR+fbhcQjo3gUiqvSA1nMT+gpdPdN6XvIjcZ2FOkBfPktcGAtCfCFUyoBN7D0F98a6AMUNXGxxLAGNCtyDEqxeuFUWWPzTYvJudeJIadVjAYiG+0q0rFSezDZp/Dz5IcBba7Jj8acTNR005zkcg0dutsd0E8mXEuLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742919217; c=relaxed/simple;
	bh=ixx6E+DR2ZGc82gUWQsG6noF4rzzyQb66sJxUdJtYOw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dymp2wL8eBD9beRbKw4+6DW1ALEDRpKgXvoi00nxe9FLh/gZ8AO1AsbUDJlqm3GJ4+LQHLgoN71bcTq0R3stVLrbIc/gzL8h+SF3nF9qX56TsZrHDS72a+81LsLr0fZVFe6FD+JVbLzOoLQquT2QRlJN0YyuGqO7Y+S3akeZgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.112.165.186])
	by gateway (Coremail) with SMTP id _____8Cxqmor1uJnfu+lAA--.17294S3;
	Wed, 26 Mar 2025 00:13:31 +0800 (CST)
Received: from [192.168.100.199] (unknown [36.112.165.186])
	by front1 (Coremail) with SMTP id qMiowMDxu8Qp1uJnHcpfAA--.19362S3;
	Wed, 26 Mar 2025 00:13:30 +0800 (CST)
Message-ID: <98a786e6-4c07-c6d0-38ae-bc5c5f7eb1f2@loongson.cn>
Date: Wed, 26 Mar 2025 00:13:32 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] LoongArch: BPF: Don't override subprog's return value
Content-Language: en-US
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org
Cc: chenhuacai@kernel.org, john.fastabend@gmail.com
References: <20250325141046.38347-1-hengqi.chen@gmail.com>
 <d4870294-86c2-c458-3b2d-b581afcd9fa9@loongson.cn>
In-Reply-To: <d4870294-86c2-c458-3b2d-b581afcd9fa9@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxu8Qp1uJnHcpfAA--.19362S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF15AFWUtFWkuF1kJrWkGrX_yoW8trW5pr
	ykAF98CrWjgr1rXF17tr18XFy8KF43tw17u3Wjya48Ar15ZryFqr4jgw1FgFn8Cw48Xr18
	Xr10vF1fZF1DJagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
	AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
	14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
	WIevJa73UjIFyTuYvjxU2nYFDUUUU

On 3/26/25 00:07, Tiezhu Yang wrote:
> On 3/25/25 22:10, Hengqi Chen wrote:
>> The verifier test `calls: div by 0 in subprog` triggers a panic at the
>> ld.bu instruction. The ld.bu insn is trying to load byte from memory
>> address returned by the subprog. The subprog actually set the correct
>> address at the a5 register (dedicated register for BPF return values).
>> But at commit 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
>> we also sign extended a5 to the a0 register (return value in LoongArch).
>> For function call insn, we later propagate the a0 register back to a5
>> register. This is right for native calls but wrong for bpf2bpf calls
>> which expect zero-extended return value in a5 register. So only move a0
>> to a5 for native calls (i.e. non-BPF_PSEUDO_CALL).
>>
>> Fixes: 73c359d1d356 ("LoongArch: BPF: Sign-extend return values")
>> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
>> ---
>>   arch/loongarch/net/bpf_jit.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
>> index a06bf89fed67..73ff1a657aa5 100644
>> --- a/arch/loongarch/net/bpf_jit.c
>> +++ b/arch/loongarch/net/bpf_jit.c
>> @@ -907,7 +907,9 @@ static int build_insn(const struct bpf_insn *insn, 
>> struct jit_ctx *ctx, bool ext
>>           move_addr(ctx, t1, func_addr);
>>           emit_insn(ctx, jirl, LOONGARCH_GPR_RA, t1, 0);
>> -        move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
>> +
>> +        if (insn->src_reg != BPF_PSEUDO_CALL)
>> +            move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_A0);
>>           break;
>>       /* tail call */
> 
> In my opinion, it is better to give a test case and show the test
> result without and with this change.
> 
> The test case should be put in the commit message at least and then
> added into tools/testing/selftests/bpf or lib/test_bpf.c if not exist.

Oh, it seems that there is a test case `calls: div by 0 in subprog`, so
it will be great to add a test case in lib/test_bpf.c to test bpf jit if
possible.

Thanks,
Tiezhu


