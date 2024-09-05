Return-Path: <bpf+bounces-38956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C885996CF8E
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 08:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0734A1C221D2
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 06:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF46718C345;
	Thu,  5 Sep 2024 06:42:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716A518BC0A;
	Thu,  5 Sep 2024 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725518543; cv=none; b=NJ1dr5ZsOsgEK6HNvbATFvKxxgvoAtQJIzFBWq5AfOqvdaqzGEhKijx5df9E6CALmKocR6hupj2Q4HhOV6ZKs5WArVbh22QulFV7n2+H03AGaSvPkAO6ZSkadaAXa1+O0mS3cT2k68PRiJOrP4MDrhWTDO0hJNRBqnqiP6VLqDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725518543; c=relaxed/simple;
	bh=kPiHS5z3zCVgq97e8z7YTxTwYJd486XIT1F+MFiid3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnRyAO8GbXvF3YneTXbSs2Vaqr71XbB+s/tmtQx3vcduypl9ZabkR/MtA7QuNJYApkV7AMnMDKM97JdFVN19x+dUEwtyAdlEoPSspxIlk4kBo02X21hIXsdSnC5rFevjbHt7JLy2oAGekj5+EkcKTvd6N8yQTF33D8T2bK44kWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WzqXV071Qz4f3js0;
	Thu,  5 Sep 2024 14:42:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 140551A0AA4;
	Thu,  5 Sep 2024 14:42:17 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP2 (Coremail) with SMTP id Syh0CgBHfGHHUtlmsrbFAQ--.19928S2;
	Thu, 05 Sep 2024 14:42:16 +0800 (CST)
Message-ID: <c587edd1-811b-4cc2-8738-a01196bab274@huaweicloud.com>
Date: Thu, 5 Sep 2024 14:42:15 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 2/4] libbpf: Access first syscall argument
 with CO-RE direct read on arm64
Content-Language: en-US
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 netdev@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Puranjay Mohan <puranjay@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240831041934.1629216-1-pulehui@huaweicloud.com>
 <20240831041934.1629216-3-pulehui@huaweicloud.com>
 <CAEf4BzYQx95PzRyivNgGWwL_ytB1=Z8eVGe_ejYHvdiCyjMJzA@mail.gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <CAEf4BzYQx95PzRyivNgGWwL_ytB1=Z8eVGe_ejYHvdiCyjMJzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHfGHHUtlmsrbFAQ--.19928S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4DCFy5JF4ruFyrWrWDXFb_yoW8tw4UpF
	WUCa4UKw18Ww4jkas2gayavF13tws5trnrGF97GasakFyDKr95Wa42qrZ09w4avryUJ3yF
	vr9Fkr18C3W7Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/9/5 4:21, Andrii Nakryiko wrote:
> On Fri, Aug 30, 2024 at 9:17 PM Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>> From: Pu Lehui <pulehui@huawei.com>
>>
>> Currently PT_REGS_PARM1 SYSCALL(x) is consistent with PT_REGS_PARM1_CORE
>> SYSCALL(x), which will introduce the overhead of BPF_CORE_READ(), taking
>> into account the read pt_regs comes directly from the context, let's use
>> CO-RE direct read to access the first system call argument.
>>
>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>> ---
>>   tools/lib/bpf/bpf_tracing.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
>> index e7d9382efeb3..051c408e6aed 100644
>> --- a/tools/lib/bpf/bpf_tracing.h
>> +++ b/tools/lib/bpf/bpf_tracing.h
>> @@ -222,7 +222,7 @@ struct pt_regs___s390 {
>>
>>   struct pt_regs___arm64 {
>>          unsigned long orig_x0;
>> -};
>> +} __attribute__((preserve_access_index));
>>
>>   /* arm64 provides struct user_pt_regs instead of struct pt_regs to userspace */
>>   #define __PT_REGS_CAST(x) ((const struct user_pt_regs *)(x))
>> @@ -241,7 +241,7 @@ struct pt_regs___arm64 {
>>   #define __PT_PARM4_SYSCALL_REG __PT_PARM4_REG
>>   #define __PT_PARM5_SYSCALL_REG __PT_PARM5_REG
>>   #define __PT_PARM6_SYSCALL_REG __PT_PARM6_REG
>> -#define PT_REGS_PARM1_SYSCALL(x) PT_REGS_PARM1_CORE_SYSCALL(x)
>> +#define PT_REGS_PARM1_SYSCALL(x) (((const struct pt_regs___arm64 *)(x))->orig_x0)
> 
> It would probably be best (for consistency) to stick to using
> __PTR_PARM1_SYSCALL_REG instead of hard-coding orig_x0 here, no? I'll
> fix it up while applying. Same for patch #1 and #4.
> 
> It would be great if you can double-check that final patches in
> bpf-next/master compile and work well for arm64, s390x, and RV64 (as I
> can't really test that much locally).

I check that locally with cross-platform vmtest on RV64, it looks good:

Summary: 569/3944 PASSED, 104 SKIPPED, 0 FAILED

and BPF CI meet happy on arm64, s390x.


> 
> 
> 
>>   #define PT_REGS_PARM1_CORE_SYSCALL(x) \
>>          BPF_CORE_READ((const struct pt_regs___arm64 *)(x), __PT_PARM1_SYSCALL_REG)
>>
>> --
>> 2.34.1
>>


