Return-Path: <bpf+bounces-77238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B251CD2A08
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 09:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5145300C5DF
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 08:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7692F0C62;
	Sat, 20 Dec 2025 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="C+TRpygV"
X-Original-To: bpf@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ACF1A8F84;
	Sat, 20 Dec 2025 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766218347; cv=none; b=H6w2rOzh6jRo1FyiWpPQOn9k3gcyRQE57bUZoXMgMPtKbgBNZ2cgPf7ciQXAzE76t4qtuB+j+tG0TrKFaP9lhICR+sAVI9x8+30iibK+nhmK6LwPyIMOeEpjkTTSMD/DfgLuhzb0owtHUHqpcDKObRO+F8IR+jEeB5BVhwS8wWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766218347; c=relaxed/simple;
	bh=ppFb7oEG4zVl4+hndjbYuGWoY/oUjitqEVCUVav68vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AM+TPOeb/W06MQ3tkh1WD3/cG2NyOyP/ZMkmWmvufPoNk8wELprqzXbFzVC2k4vqKCgcJgB9CW8EEccDAAULVFykCfPkjzvEpYlUyYvTlrjuItjFDmcw6s+Td5FOhdlbsAOBshrPP/EOZwAMIqovdeT5ZaDtHpZ1hezE9Vq+A6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=C+TRpygV; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=AT2f/E2tSnUYCtK/n6UAgn4xu0StATP6gfkv+vc/Tpg=;
	b=C+TRpygV3prYVZOU7NSz+0JpXAbTBtLUxHJEiKtYPIFzkPcw2R5pK+obXLOFBFAvcKYBVopoo
	Whq4l8tNPjYsyYk2jMB/LtqO+2ENS781xMuKFZKHehGSlXuqTmltzV4gcYKHc4nNYIS8pgzgxgx
	B9W9bkoNsJC1Yl6jyf54fXU=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dYHB04WfgzpSvn;
	Sat, 20 Dec 2025 16:09:28 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id EDCD24056B;
	Sat, 20 Dec 2025 16:12:17 +0800 (CST)
Received: from [10.67.110.198] (10.67.110.198) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 20 Dec 2025 16:12:16 +0800
Message-ID: <98266067-2bc2-4312-84d7-76966c3ebc1e@huawei.com>
Date: Sat, 20 Dec 2025 16:12:09 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] riscv, bpf: fix incorrect usage of
 BPF_TRAMP_F_ORIG_STACK
To: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong
	<menglong8.dong@gmail.com>, <schwab@linux-m68k.org>, <andrii@kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>, <bjorn@kernel.org>,
	<puranjay@kernel.org>, <pjw@kernel.org>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <bpf@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251219142948.204312-1-dongml2@chinatelecom.cn>
 <33977244-1266-4590-af38-e3be3e46d7f4@huawei.com> <8619181.T7Z3S40VBb@7950hx>
Content-Language: en-US
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <8619181.T7Z3S40VBb@7950hx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/12/20 15:33, Menglong Dong wrote:
> On 2025/12/20 10:59, Pu Lehui wrote:
>>
>> On 2025/12/19 22:29, Menglong Dong wrote:
>>> The usage of BPF_TRAMP_F_ORIG_STACK in __arch_prepare_bpf_trampoline() is
>>> wrong, and it should be BPF_TRAMP_F_CALL_ORIG, which caused crash as
>>> Andreas reported:
>>>
>>>     Insufficient stack space to handle exception!
>>>     Task stack:     [0xff20000000010000..0xff20000000014000]
>>>     Overflow stack: [0xff600000ffdad070..0xff600000ffdae070]
>>>     CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)
>>>     Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
>>>     epc : copy_from_kernel_nofault+0xa/0x198
>>>      ra : bpf_probe_read_kernel+0x20/0x60
>>>     epc : ffffffff802b732a ra : ffffffff801e6070 sp : ff2000000000ffe0
>>>      gp : ffffffff82262ed0 tp : 0000000000000000 t0 : ffffffff80022320
>>>      t1 : ffffffff801e6056 t2 : 0000000000000000 s0 : ff20000000010040
>>>      s1 : 0000000000000008 a0 : ff20000000010050 a1 : ff60000083b3d320
>>>      a2 : 0000000000000008 a3 : 0000000000000097 a4 : 0000000000000000
>>>      a5 : 0000000000000000 a6 : 0000000000000021 a7 : 0000000000000003
>>>      s2 : ff20000000010050 s3 : ff6000008459fc18 s4 : ff60000083b3d340
>>>      s5 : ff20000000010060 s6 : 0000000000000000 s7 : ff20000000013aa8
>>>      s8 : 0000000000000000 s9 : 0000000000008000 s10: 000000000058dcb0
>>>      s11: 000000000058dca7 t3 : 000000006925116d t4 : ff6000008090f026
>>>      t5 : 00007fff9b0cbaa8 t6 : 0000000000000016
>>>     status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000005
>>>     Kernel panic - not syncing: Kernel stack overflow
>>>     CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(voluntary)
>>>     Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
>>>     Call Trace:
>>>     [<ffffffff8001a1f8>] dump_backtrace+0x28/0x38
>>>     [<ffffffff80002502>] show_stack+0x3a/0x50
>>>     [<ffffffff800122be>] dump_stack_lvl+0x56/0x80
>>>     [<ffffffff80012300>] dump_stack+0x18/0x22
>>>     [<ffffffff80002abe>] vpanic+0xf6/0x328
>>>     [<ffffffff80002d2e>] panic+0x3e/0x40
>>>     [<ffffffff80019ef0>] handle_bad_stack+0x98/0xa0
>>>     [<ffffffff801e6070>] bpf_probe_read_kernel+0x20/0x60
>>>
>>> Just fix it.
>>>
>>> Fixes: 47c9214dcbea ("bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME")
>>> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
>>> Closes: https://lore.kernel.org/bpf/874ipnkfvt.fsf@igel.home/
>>> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>>> ---
>>> v2:
>>> - merge the code
>>> ---
>>>    arch/riscv/net/bpf_jit_comp64.c | 6 ++----
>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
>>> index 5f9457e910e8..37888abee70c 100644
>>> --- a/arch/riscv/net/bpf_jit_comp64.c
>>> +++ b/arch/riscv/net/bpf_jit_comp64.c
>>> @@ -1133,10 +1133,6 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>>    
>>>    	store_args(nr_arg_slots, args_off, ctx);
>>>    
>>> -	/* skip to actual body of traced function */
>>> -	if (flags & BPF_TRAMP_F_ORIG_STACK)
>>
>> Oh, how did this weird flags get in here...
> 
> It's my fault. I wanted to use BPF_TRAMP_F_CALL_ORIG here, and
> a copy-paste mistake happen. They look a little similar :(
> 
>>
>>> -		orig_call += RV_FENTRY_NINSNS * 4;
>>> -
>>>    	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>>>    		emit_imm(RV_REG_A0, ctx->insns ? (const s64)im : RV_MAX_COUNT_IMM, ctx);
>>>    		ret = emit_call((const u64)__bpf_tramp_enter, true, ctx);
>>> @@ -1171,6 +1167,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im,
>>>    	}
>>>    
>>>    	if (flags & BPF_TRAMP_F_CALL_ORIG) {
>>> +		/* skip to actual body of traced function */
>>> +		orig_call += RV_FENTRY_NINSNS * 4;
>>
>>
>> LGTM, let's revert it.
>>
>> Reviewed-by: Pu Lehui <pulehui@huawei.com>
>>
>>>    		restore_args(min_t(int, nr_arg_slots, RV_MAX_REG_ARGS), args_off, ctx);
>>>    		restore_stack_args(nr_arg_slots - RV_MAX_REG_ARGS, args_off, stk_arg_off, ctx);
>>>    		ret = emit_call((const u64)orig_call, true, ctx);
> 
> Andreas suggested that we remove the variable "orig_call" and use
> "func_addr + RV_FENTRY_NINSNS * 4" directly here. But I saw the V2
> is already applied. Hmm...I think it doesn't matter.

no warries. looks nice.

> 
> Thanks!
> Menglong Dong
> 
>>
>>
> 
> 
> 
> 
> 
> 

