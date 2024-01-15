Return-Path: <bpf+bounces-19526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BACCD82D8E4
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 13:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68A51C218FF
	for <lists+bpf@lfdr.de>; Mon, 15 Jan 2024 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663622C6A9;
	Mon, 15 Jan 2024 12:26:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32602C68C;
	Mon, 15 Jan 2024 12:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TDBG8161jz4f3kpX;
	Mon, 15 Jan 2024 20:26:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CD0E01A0171;
	Mon, 15 Jan 2024 20:26:43 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgB3fG6DJKVlY6KqAw--.51273S2;
	Mon, 15 Jan 2024 20:26:43 +0800 (CST)
Message-ID: <c33984f0-57dc-4833-a96d-164425fc7578@huaweicloud.com>
Date: Mon, 15 Jan 2024 20:26:43 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 6/6] riscv, bpf: Optimize bswap insns with Zbb
 support
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>,
 Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20230919035839.3297328-1-pulehui@huaweicloud.com>
 <20230919035839.3297328-7-pulehui@huaweicloud.com>
 <87pm22mu79.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <87pm22mu79.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3fG6DJKVlY6KqAw--.51273S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw15ZF1kZrW7WF4fKrW8Crg_yoW5urWfpa
	s8Kr4rCay8trsrt34DWa1jgw43GF43tFnFvr1fJFZ5JrWjvr48G3WUKr4FkryUAryfCa15
	uF1DKrnIk3WUKFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2023/9/28 19:08, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Optimize bswap instructions by rev8 Zbb instruction conbined with srli
>> instruction. And Optimize 16-bit zero-extension with Zbb support.
>>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   arch/riscv/net/bpf_jit.h        | 67 +++++++++++++++++++++++++++++++++
>>   arch/riscv/net/bpf_jit_comp64.c | 50 +-----------------------
>>   2 files changed, 69 insertions(+), 48 deletions(-)
>>
>> diff --git a/arch/riscv/net/bpf_jit.h b/arch/riscv/net/bpf_jit.h
>> index 944bdd6e4..a04eed672 100644
>> --- a/arch/riscv/net/bpf_jit.h
>> +++ b/arch/riscv/net/bpf_jit.h
>> @@ -1135,12 +1135,79 @@ static inline void emit_sextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
>>   	emit_addiw(rd, rs, 0, ctx);
>>   }
>>   
>> +static inline void emit_zexth(u8 rd, u8 rs, struct rv_jit_context *ctx)
>> +{
>> +	if (rvzbb_enabled()) {
>> +		emit(rvzbb_zexth(rd, rs), ctx);
>> +	} else {
>> +		emit_slli(rd, rs, 48, ctx);
>> +		emit_srli(rd, rd, 48, ctx);
>> +	}
>> +}
>> +
> 
> Prefer early-exit.
> 
>>   static inline void emit_zextw(u8 rd, u8 rs, struct rv_jit_context *ctx)
>>   {
>>   	emit_slli(rd, rs, 32, ctx);
>>   	emit_srli(rd, rd, 32, ctx);
>>   }
>>   
>> +static inline void emit_bswap(u8 rd, s32 imm, struct rv_jit_context *ctx)
>> +{
>> +	if (rvzbb_enabled()) {
>> +		int bits = 64 - imm;
>> +
>> +		emit(rvzbb_rev8(rd, rd), ctx);
>> +		if (bits)
>> +			emit_srli(rd, rd, bits, ctx);
>> +	} else {
>> +		emit_li(RV_REG_T2, 0, ctx);
>> +
>> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
>> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
>> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
>> +		emit_srli(rd, rd, 8, ctx);
>> +		if (imm == 16)
>> +			goto out_be;
>> +
>> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
>> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
>> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
>> +		emit_srli(rd, rd, 8, ctx);
>> +
>> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
>> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
>> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
>> +		emit_srli(rd, rd, 8, ctx);
>> +		if (imm == 32)
>> +			goto out_be;
>> +
>> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
>> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
>> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
>> +		emit_srli(rd, rd, 8, ctx);
>> +
>> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
>> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
>> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
>> +		emit_srli(rd, rd, 8, ctx);
>> +
>> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
>> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
>> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
>> +		emit_srli(rd, rd, 8, ctx);
>> +
>> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
>> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
>> +		emit_slli(RV_REG_T2, RV_REG_T2, 8, ctx);
>> +		emit_srli(rd, rd, 8, ctx);
>> +out_be:
>> +		emit_andi(RV_REG_T1, rd, 0xff, ctx);
>> +		emit_add(RV_REG_T2, RV_REG_T2, RV_REG_T1, ctx);
>> +
>> +		emit_mv(rd, RV_REG_T2, ctx);
>> +	}
>> +}
> 
> Definitely early-exit for this one!
> 
> This function really show-cases why ZBB is nice! ;-)
> 
> I'll take the next rev of series for a test!
> 

Okay, the relevant modifications will be presented in v3 and will be 
sent soon.

> 
> Björn


