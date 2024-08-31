Return-Path: <bpf+bounces-38662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DC3966FB9
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 08:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A1028458D
	for <lists+bpf@lfdr.de>; Sat, 31 Aug 2024 06:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94FC16726E;
	Sat, 31 Aug 2024 06:16:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02961537BB;
	Sat, 31 Aug 2024 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725084994; cv=none; b=EZfIR+9zIfqh3Oen17kpk1zej32+eObQsqSGbSUmtpq0fsBdoNnKKH6UlMnI4ctKzJyq31tt4P/Y9v/5zCYGCNjZ5+Mwm2YwTeo+ywIiGXZIfWp/Sh1tjC5natPLAW0X0JkpaqLJtW2hfb34rwFgMF95Mf6OZttC1zwgZMapGdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725084994; c=relaxed/simple;
	bh=uyTVwfyUkYvlPQT6w7Qgx1vQWk8gaNI3kobVNYQoRS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+O/uKIIwN/jpUzr2S6pqsFWtYVUkjA9T1LYSd/0dZQfW6enILyS5XP+5CIPlT7PRF8+iPHh5KkmTNWeb1rPwh0y7t/r23mlrDvF/gA6b7kW9Vnvu8uyr3Y4xayCeqfASdMmQZTUczgC9a8OO2pBsgjdP9YmTs2fr1Mr9UKQH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WwlC10ZTjz4f3jXJ;
	Sat, 31 Aug 2024 14:16:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CEE441A018D;
	Sat, 31 Aug 2024 14:16:27 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgD3aYA3tdJmKF_YDA--.28873S2;
	Sat, 31 Aug 2024 14:16:25 +0800 (CST)
Message-ID: <f14d0337-0743-4490-88ba-f6e24f0e547e@huaweicloud.com>
Date: Sat, 31 Aug 2024 14:16:23 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: Fix accessing first syscall argument
 on RV64
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Puranjay Mohan <puranjay@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pu Lehui <pulehui@huawei.com>
References: <20240829133453.882259-1-pulehui@huaweicloud.com>
 <20240829133453.882259-2-pulehui@huaweicloud.com>
 <CAEf4BzbvUQ1HA6GPSF23piqbEBNVDZKZC0rB-X4LgeMpp9svYA@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAEf4BzbvUQ1HA6GPSF23piqbEBNVDZKZC0rB-X4LgeMpp9svYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3aYA3tdJmKF_YDA--.28873S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1UGFWfXF1xXr1rGr15urg_yoW8urWkpr
	W5ta4UKr18Wr42g347Ka12qF13Kr45trsrWF9xWaySkr4Ut3s3G3WaqrWYkF4qqr4kWw4q
	vr9ruw18GF1ayrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/8/31 3:34, Andrii Nakryiko wrote:
> On Thu, Aug 29, 2024 at 6:32 AM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
[SNIP]
>>
>> -#define __PT_PARM1_SYSCALL_REG __PT_PARM1_REG
>> +#define __PT_PARM1_SYSCALL_REG orig_a0
>>   #define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
>>   #define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
>>   #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
>>   #define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
>>   #define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
>> +#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
>> +#define PT_REGS_PARM1_CORE_SYSCALL(x) \
>> +       BPF_CORE_READ((const struct pt_regs___riscv *)(x), __PT_PARM1_SYSCALL_REG)
> 
> I feel like what we did for s390x is a bit suboptimal, so let's (try
> to) improve that and then do the same for RV64.
> 
> What I mean is that PT_REGS_PARMn_SYSCALL macros are used to read
> pt_regs coming directly from context, right? In that case we don't
> need to pay the price of BPF_CORE_READ(), we can just access memory
> directly (but we still need CO-RE relocation!).
> 
> So I think what we should do is
> 
> 1) mark pt_regs___riscv {} with __attribute__((preserve_access_index))
> so that normal field accesses are CO-RE-relocated
> 2) change PT_REGS_PARM1_SYSCALL(x) to be `((const
> struct_pt_regs___riscv *)(x))->orig_a0`, which will directly read
> memory
> 3) keep PT_REGS_PARM1_CORE_SYSCALL() as is
> 
> 
> But having written all the above, I'm not sure whether we allow CO-RE
> relocated direct context accesses (verifier might complain about
> modifying ctx register offset or something). So can you please check
> it either on s390 or RV64 and let me know? I'm not marking it as
> "Changes Requested" for that reason, because that might not work and
> we'll have to do BPF_CORE_READ().

Hi Andrii, thanks for your suggestion, it's really cool. I check that 
work for RV64, and send a new version:

https://lore.kernel.org/bpf/20240831041934.1629216-1-pulehui@huaweicloud.com

> 
>>
>>   #define __PT_RET_REG ra
>>   #define __PT_FP_REG s0
>> --
>> 2.34.1
>>


