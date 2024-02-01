Return-Path: <bpf+bounces-20948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7E845703
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 13:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E3C1C2979B
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 12:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CCB15DBA4;
	Thu,  1 Feb 2024 12:10:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A8E15DBA1;
	Thu,  1 Feb 2024 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789422; cv=none; b=HshkqnFUz7MjDPiUZf+1i+VAwpgrYTW9pYtKGrRTQAQWtcENoTgDdHwgMi9UWje71u0QgT70JmP0Ld7ixktNEV/r+TBDk/h3kdo88kD2R11L1Pd3AFUDeXjSdlM9OyHyZ7oV9g2mdCEJFJ4W1iSKRl2fAB57EruMU31CQBN4AXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789422; c=relaxed/simple;
	bh=JNYKsO780j+0qZL+A6GIIYdjJohuix8AvlqBpgEuxeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QmkfsZ5bQAPtzWAaChkQJ/9gV1Cw24cWeFyiXb+ACEegr6T3FqB5fhNWNQkHlmw46y5Yy6uLaGIEfgfoFkDHqMqv413YWtiQY9f8TkGMkxQiVm/HVZxBaUWrjw3KaSAjb7vFYjYmISCgUotAUvq73KoHv7+EY5sp5LoeZ2nNOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4TQd5G5vBmz4f3jsJ;
	Thu,  1 Feb 2024 20:10:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0C4031A038B;
	Thu,  1 Feb 2024 20:10:15 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgBHBp4lirtlK9FmCg--.10909S2;
	Thu, 01 Feb 2024 20:10:14 +0800 (CST)
Message-ID: <93209b12-9117-484a-908a-5b138fa2ffb0@huaweicloud.com>
Date: Thu, 1 Feb 2024 20:10:13 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 4/4] riscv, bpf: Mixing bpf2bpf and tailcalls
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: Song Liu <song@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Luke Nelson <luke.r.nels@gmail.com>, Pu Lehui <pulehui@huawei.com>
References: <20240130040958.230673-1-pulehui@huaweicloud.com>
 <20240130040958.230673-5-pulehui@huaweicloud.com>
 <87sf2eohj2.fsf@all.your.base.are.belong.to.us>
 <fab22b9e-7b56-4fef-ba92-bf62ec43007d@huaweicloud.com>
 <878r44mr4g.fsf@all.your.base.are.belong.to.us>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <878r44mr4g.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBHBp4lirtlK9FmCg--.10909S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr18ZF1rKFy8JF17JFyUGFg_yoW8Gr17p3
	ykKa4ayay8Jr45CrnFgF1vqF9Iyrn5tFn8Jrn3Ga1fCrWqgFykGa1Utayj9F98Awn5Jr48
	Xr1qqan3GayYy3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280
	aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/2/1 18:10, Björn Töpel wrote:
> Pu Lehui <pulehui@huaweicloud.com> writes:
> 
>>>> @@ -252,10 +220,7 @@ static void __build_epilogue(bool is_tail_call, struct rv_jit_context *ctx)
>>>>    		emit_ld(RV_REG_S5, store_offset, RV_REG_SP, ctx);
>>>>    		store_offset -= 8;
>>>>    	}
>>>> -	if (seen_reg(RV_REG_S6, ctx)) {
>>>> -		emit_ld(RV_REG_S6, store_offset, RV_REG_SP, ctx);
>>>> -		store_offset -= 8;
>>>> -	}
>>>> +	emit_ld(RV_REG_TCC, store_offset, RV_REG_SP, ctx);
>>>
>>> Why do you need to restore RV_REG_TCC? We're passing RV_REG_TCC (a6) as
>>> an argument at all call-sites, and for tailcalls we're loading from the
>>> stack.
>>>
>>> Is this to fake the a6 argument for the tail-call? If so, it's better to
>>> move it to emit_bpf_tail_call(), instead of letting all programs pay for
>>> it.
>>
>> Yes, we can remove this duplicate load. will do that at next version.
> 
> Hmm, no remove, but *move* right? Otherwise a6 can contain gargabe on
> entering the tailcall?
> 
> Move it before __emit_epilogue() in the tailcall, no?
> 

IIUC, we don't need to load it again. In emit_bpf_tail_call function, we 
load TCC from stack to A6, A6--, then store A6 back to stack. Then 
unwind the current stack and jump to target bpf prog, during this 
period, we did not touch the A6 register, do we still need to load it again?

> 
> Björn


