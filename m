Return-Path: <bpf+bounces-77561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7DCEB05C
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 03:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D731301830B
	for <lists+bpf@lfdr.de>; Wed, 31 Dec 2025 02:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCBB2E2852;
	Wed, 31 Dec 2025 02:05:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213A41754;
	Wed, 31 Dec 2025 02:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767146741; cv=none; b=i5rimJFXK2pJSCOLDDYEiuXptJGHXK+0XeYLdklDdHa7VRMGcfWMzntb6G1wm6kyecSPZ9HpvzJKwfPYP0Oirm8JkiYia9XPEROuqybpYufE61XB6wwCWZa+iuCRvGvyoPQLm+Q8aufgjXutXMUisRz9qs9kAp1UlnwfX5L+31s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767146741; c=relaxed/simple;
	bh=OA/thkzRWprQjGt1o4/4Li7MBUje/rmi1f2/R/xTboU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sayZ+oq1NEkQRh5CYNWuYayVOfj5XxJ8l8LlKBAeuekU0/EFdbXSxeUaOh8mb8NDQZY9o5OSE8tGRET/O9FC5ShH3wP1uHxRN6FD4ixPdd8ar0p2mgX2sHgk3SeAmPWnkkdAUewVTWVYpk4ozc8eh3Uln1dhgZj1vCMkxBClJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dgtZN6M8qzKHMKm;
	Wed, 31 Dec 2025 10:05:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BCDE94058D;
	Wed, 31 Dec 2025 10:05:30 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP2 (Coremail) with SMTP id Syh0CgB3kYDnhFRpTFw_CA--.53654S2;
	Wed, 31 Dec 2025 10:05:28 +0800 (CST)
Message-ID: <0c441710-5250-4706-ba81-b6b4b1277313@huaweicloud.com>
Date: Wed, 31 Dec 2025 10:05:27 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan
 <puranjay@kernel.org>, Anton Protopopov <a.s.protopopov@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20251227081033.240336-1-xukuohai@huaweicloud.com>
 <CAADnVQKJk7pGW50JHj6tZAeHLxCbgmHBdhwZCY4NT-6MTg7=sQ@mail.gmail.com>
From: Xu Kuohai <xukuohai@huaweicloud.com>
In-Reply-To: <CAADnVQKJk7pGW50JHj6tZAeHLxCbgmHBdhwZCY4NT-6MTg7=sQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB3kYDnhFRpTFw_CA--.53654S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4rZr47JFWxAry3CFWfKrg_yoW8Aw1fpF
	4DJ34j9rWDCr4kCr4xWF1jkFW3trsxG3W5Grs3J343Ca1a9r93KF4Iqa1akFnrKFZ5C3yU
	XF4j9asYka1jyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 12/31/2025 2:20 AM, Alexei Starovoitov wrote:
> On Fri, Dec 26, 2025 at 11:49 PM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>
>> From: Xu Kuohai <xukuohai@huawei.com>
>>
>> When BTI is enabled, the indirect jump selftest triggers BTI exception:
>>
>> Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
>> ...
>> Call trace:
>>   bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
>>   bpf_prog_run_pin_on_cpu+0x140/0x464
>>   bpf_prog_test_run_syscall+0x274/0x3ac
>>   bpf_prog_test_run+0x224/0x2b0
>>   __sys_bpf+0x4cc/0x5c8
>>   __arm64_sys_bpf+0x7c/0x94
>>   invoke_syscall+0x78/0x20c
>>   el0_svc_common+0x11c/0x1c0
>>   do_el0_svc+0x48/0x58
>>   el0_svc+0x54/0x19c
>>   el0t_64_sync_handler+0x84/0x12c
>>   el0t_64_sync+0x198/0x19c
>>
>> This happens because no BTI instruction is generated by the JIT for
>> indirect jump targets.
>>
>> Fix it by emitting BTI instruction for every possible indirect jump
>> targets when BTI is enabled. The targets are identified by traversing
>> all instruction arrays of jump table type used by the BPF program,
>> since indirect jump targets can only be read from instruction arrays
>> of jump table type.
> 
> earlier you said:
> 
>> As Anton noted, even though jump tables are currently the only type
>> of instruction array, users may still create insn_arrays that are not
>> used as jump tables. In such cases, there is no need to emit BTIs.
> 
> yes, but it's not worth it to make this micro optimization in JIT.
> If it's in insn_array just emit BTI unconditionally.
> No need to do this filtering.
>

Hmm, that is what the v1 version does. Please take a look. If it’s okay,
I’ll resend a rebased version.

v1: https://lore.kernel.org/bpf/20251127140318.3944249-1-xukuohai@huaweicloud.com/

> pw-bot: cr


