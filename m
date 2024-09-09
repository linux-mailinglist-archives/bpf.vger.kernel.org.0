Return-Path: <bpf+bounces-39267-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4594E971003
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F25752823BA
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 07:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D431B0104;
	Mon,  9 Sep 2024 07:41:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26331AE055;
	Mon,  9 Sep 2024 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725867664; cv=none; b=GePwbjHRNSZXwjgbxnYM4z/T8NtepU/756UvFiBGOMLBWDkrHpJKdYldoCQun8+AkDuC07H16aJeO9s8o2VRyOV6QkLWcOTSr3s+dGv1e1u8I02Hv9eMXF7MZpIknE7ejKwxde+S2WcmGInW6B6zooWvQyEolyMogW/06sblSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725867664; c=relaxed/simple;
	bh=efsDtIFQ4KedIcnHbWYKdOE8wRBQVpEpkrP71DKVSJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SeaKb9CMAxGO9ovAv1OGBiIKcIVWHDpfyBQ6D1O4CMm654hBAOGY/jG7Cr36Osd5yVkg6mKnmBYwg6dYYraVdZUfPiKXXs2x+9cp55Jk0prTfW4832R+XWqClwpuWJSBXXiWjgCFMtdXmSNZc4axLXgTPusu1oojDYg6vTo9BtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X2Jfb3gqlz69Vy;
	Mon,  9 Sep 2024 15:40:55 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 59C31140336;
	Mon,  9 Sep 2024 15:40:59 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 9 Sep 2024 15:40:58 +0800
Message-ID: <2c7e0bb8-0c43-295c-0432-e2fcc80c7d18@huawei.com>
Date: Mon, 9 Sep 2024 15:40:57 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: insn: Simulate nop and push instruction for better
 uprobe performance
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC: Mark Rutland <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mhiramat@kernel.org>, <oleg@redhat.com>,
	<peterz@infradead.org>, <puranjay@kernel.org>, <ast@kernel.org>,
	<andrii@kernel.org>, <xukuohai@huawei.com>, <revest@chromium.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20240814080356.2639544-1-liaochang1@huawei.com>
 <Zr3RN4zxF5XPgjEB@J2N7QTR9R3>
 <f95fc55b-2f17-7333-2eae-52caae46f8b2@huawei.com>
 <8cc13794-30a7-a30b-2ac9-4d151499d184@huawei.com>
 <CAEf4BzbPRX2pTJBmwA081Wj+BqGwrNZytzq+=-ftzRRj=xWM_A@mail.gmail.com>
 <60c6f5cc-6f8c-9335-93b2-eddbe08f9e01@huawei.com>
 <CAEf4BzYVgvNY1Guh0ovgSCsazde8VX26Oi2=22tcYaGGd3dapw@mail.gmail.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <CAEf4BzYVgvNY1Guh0ovgSCsazde8VX26Oi2=22tcYaGGd3dapw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/6 4:17, Andrii Nakryiko 写道:
> On Fri, Aug 30, 2024 at 2:25 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>
>>
>>
>> 在 2024/8/30 3:26, Andrii Nakryiko 写道:
>>> On Tue, Aug 27, 2024 at 4:34 AM Liao, Chang <liaochang1@huawei.com> wrote:
>>>>
>>>> Hi, Mark
>>>>
>>>> Would you like to discuss this patch further, or do you still believe emulating
>>>> STP to push FP/LR into the stack in kernel is not a good idea?
>>>>
>>>
>>> Please send an updated version of your patches taking into account
>>> various smaller issues Mark pointed out. But please keep STP
>>> emulation, I think it's very important, even if it's not covering all
>>> possible uprobe tracing scenarios.
>>
>> OK, I will send it out over the weekend, including an enhancement of STP
>> emuation that addresses the MTE and POE issues Mark mentioned. I hope this
>> will lead to more feedback from him.
>>
> 
> Hey Liao,
> 
> Did you get a chance to prepare and send a new revision of this patch?
Andrii,

Yes, the v2 is on the way, please check it from here.

  https://lore.kernel.org/all/20240909071114.1150053-1-liaochang1@huawei.com/

Due to the issues Mark pointed out, primarily the atomicity and ordering
of STP, and the VMASA features for uprobe-push context, I have remove the
STP simulation and all related bits from v1. But I've been working on a
more complex method to simulate STP that is different with the uaccess
routines used in v1. I'm currently debugging it to ensure everything
functions work correctly. Please allow me more hours to complete it before
sending a separate patch for reviewing, thanks.

BR,
Chang

> 
>>>
>>>> Thanks.
>>>>
>>>>
>>>> 在 2024/8/21 15:55, Liao, Chang 写道:
>>>>> Hi, Mark
>>>>>
>>>>> My bad for taking so long to rely, I generally agree with your suggestions to
>>>>> STP emulation.
>>>>>
>>>>> 在 2024/8/15 17:58, Mark Rutland 写道:
>>>>>> On Wed, Aug 14, 2024 at 08:03:56AM +0000, Liao Chang wrote:
>>>>>>> As Andrii pointed out, the uprobe/uretprobe selftest bench run into a
>>>>>>> counterintuitive result that nop and push variants are much slower than
>>>>>>> ret variant [0]. The root cause lies in the arch_probe_analyse_insn(),
>>>>>>> which excludes 'nop' and 'stp' from the emulatable instructions list.
>>>>>>> This force the kernel returns to userspace and execute them out-of-line,
>>>>>>> then trapping back to kernel for running uprobe callback functions. This
>>>>>>> leads to a significant performance overhead compared to 'ret' variant,
>>>>>>> which is already emulated.
>>>>>>
>>>>>> I appreciate this might be surprising, but does it actually matter
>>>>>> outside of a microbenchmark?
>>>>>
>>>>> I just do a simple comparsion the performance impact of single-stepped and
>>>>> emulated STP on my local machine. Three user cases were measured: Redis GET and
>>>>> SET throughput (Request Per Second, RPS), and the time taken to execute a grep
>>>>> command on the "arch_uprobe_copy_xol" string within the kernel source.
>>>>>
>>>>> Redis GET (higher is better)
>>>>> ----------------------------
>>>>> No uprobe: 49149.71 RPS
>>>>> Single-stepped STP: 46750.82 RPS
>>>>> Emulated STP: 48981.19 RPS
>>>>>
>>>>> Redis SET (larger is better)
>>>>> ----------------------------
>>>>> No uprobe: 49761.14 RPS
>>>>> Single-stepped STP: 45255.01 RPS
>>>>> Emulated stp: 48619.21 RPS
>>>>>
>>>>> Grep (lower is better)
>>>>> ----------------------
>>>>> No uprobe: 2.165s
>>>>> Single-stepped STP: 15.314s
>>>>> Emualted STP: 2.216s
>>>>>
>>>>> The result reveals single-stepped STP instruction that used to push fp/lr into
>>>>> stack significantly impacts the Redis and grep performance, leading to a notable
>>>>> notable decrease RPS and increase time individually. So emulating STP on the
>>>>> function entry might be a more viable option for uprobe.
>>>>>
>>>>>>
>>>>>>> Typicall uprobe is installed on 'nop' for USDT and on function entry
>>>>>>> which starts with the instrucion 'stp x29, x30, [sp, #imm]!' to push lr
>>>>>>> and fp into stack regardless kernel or userspace binary.
>>>>>>
>>>>>> Function entry doesn't always start with a STP; these days it's often a
>>>>>> BTI or PACIASP, and for non-leaf functions (or with shrink-wrapping in
>>>>>> the compiler), it could be any arbitrary instruction. This might happen
>>>>>> to be the common case today, but there are certain;y codebases where it
>>>>>> is not.
>>>>>
>>>>> Sure, if kernel, CPU and compiler support BTI and PAC, the entry instruction
>>>>> is definitly not STP. But for CPU and kernel lack of these supports, STP as
>>>>> the entry instruction is still the common case. And I profiled the entry
>>>>> instruction for all leaf and non-leaf function, the ratio of STP is 64.5%
>>>>> for redis, 76.1% for the BPF selftest bench. So I am thinking it is still
>>>>> useful to emulate the STP on the function entry. Perhaps, for CPU and kernel
>>>>> with BTI and PAC enabled, uprobe chooses the slower single-stepping to execute
>>>>> STP for pushing stack.
>>>>>
>>>>>>
>>>>>> STP (or any instruction that accesses memory) is fairly painful to
>>>>>> emulate because you need to ensure that the correct atomicity and
>>>>>> ordering properties are provided (e.g. an aligned STP should be
>>>>>> single-copy-atomic, but copy_to_user() doesn't guarantee that except by
>>>>>> chance), and that the correct VMSA behaviour is provided (e.g. when
>>>>>> interacting with MTE, POE, etc, while the uaccess primitives don't try
>>>>>> to be 100% equivalent to instructions in userspace).
>>>>> Agreed, but I don't think it has to emulate strictly the single-copy-atomic
>>>>> feature of STP that is used to push fp/lr into stack. In most cases, only one
>>>>> CPU will push registers to the same position on stack. And I barely understand
>>>>> why other CPUs would depends on the ordering of pushing data into stack. So it
>>>>> means the atomicity and ordering is not so important for this scenario. Regarding
>>>>> MTE and POE, a similar stragety to BTI and PAC can be applied: for CPUs and kernel
>>>>> with MTE and POE enabled, uprobe chooses the slower single-stepping to execute
>>>>> STP for pushing stack.
>>>>>
>>>>>>
>>>>>> For those reasons, in general I don't think we should be emulating any
>>>>>> instruction which accesses memory, and we should not try to emulate the
>>>>>> STP, but I think it's entirely reasonable to emulate NOP.
>>>>>>
>>>>>>> In order to
>>>>>>> improve the performance of handling uprobe for common usecases. This
>>>>>>> patch supports the emulation of Arm64 equvialents instructions of 'nop'
>>>>>>> and 'push'. The benchmark results below indicates the performance gain
>>>>>>> of emulation is obvious.
>>>>>>>
>>>>>>> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
>>>>>>>
>>>>>>> xol (1 cpus)
>>>>>>> ------------
>>>>>>> uprobe-nop:  0.916 ± 0.001M/s (0.916M/prod)
>>>>>>> uprobe-push: 0.908 ± 0.001M/s (0.908M/prod)
>>>>>>> uprobe-ret:  1.855 ± 0.000M/s (1.855M/prod)
>>>>>>> uretprobe-nop:  0.640 ± 0.000M/s (0.640M/prod)
>>>>>>> uretprobe-push: 0.633 ± 0.001M/s (0.633M/prod)
>>>>>>> uretprobe-ret:  0.978 ± 0.003M/s (0.978M/prod)
>>>>>>>
>>>>>>> emulation (1 cpus)
>>>>>>> -------------------
>>>>>>> uprobe-nop:  1.862 ± 0.002M/s  (1.862M/prod)
>>>>>>> uprobe-push: 1.743 ± 0.006M/s  (1.743M/prod)
>>>>>>> uprobe-ret:  1.840 ± 0.001M/s  (1.840M/prod)
>>>>>>> uretprobe-nop:  0.964 ± 0.004M/s  (0.964M/prod)
>>>>>>> uretprobe-push: 0.936 ± 0.004M/s  (0.936M/prod)
>>>>>>> uretprobe-ret:  0.940 ± 0.001M/s  (0.940M/prod)
>>>>>>>
>>>>>>> As shown above, the performance gap between 'nop/push' and 'ret'
>>>>>>> variants has been significantly reduced. Due to the emulation of 'push'
>>>>>>> instruction needs to access userspace memory, it spent more cycles than
>>>>>>> the other.
>>>>>>>
>>>>>>> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com/
>>>>>>>
>>>>>>> Signed-off-by: Liao Chang <liaochang1@huawei.com>
>>>>>>> ---
>>>>>>>  arch/arm64/include/asm/insn.h            | 21 ++++++++++++++++++
>>>>>>>  arch/arm64/kernel/probes/decode-insn.c   | 18 +++++++++++++--
>>>>>>>  arch/arm64/kernel/probes/decode-insn.h   |  3 ++-
>>>>>>>  arch/arm64/kernel/probes/simulate-insn.c | 28 ++++++++++++++++++++++++
>>>>>>>  arch/arm64/kernel/probes/simulate-insn.h |  2 ++
>>>>>>>  arch/arm64/kernel/probes/uprobes.c       |  2 +-
>>>>>>>  6 files changed, 70 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>>>>>>> index 8c0a36f72d6f..a246e6e550ba 100644
>>>>>>> --- a/arch/arm64/include/asm/insn.h
>>>>>>> +++ b/arch/arm64/include/asm/insn.h
>>>>>>> @@ -549,6 +549,27 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
>>>>>>>            aarch64_insn_is_prfm_lit(insn);
>>>>>>>  }
>>>>>>>
>>>>>>> +static __always_inline bool aarch64_insn_is_nop(u32 insn)
>>>>>>> +{
>>>>>>> +   /* nop */
>>>>>>> +   return aarch64_insn_is_hint(insn) &&
>>>>>>> +          ((insn & 0xFE0) == AARCH64_INSN_HINT_NOP);
>>>>>>> +}
>>>>>>
>>>>>> This looks fine, but the comment can go.
>>>>>
>>>>> Removed.
>>>>>
>>>>>>
>>>>>>> +static __always_inline bool aarch64_insn_is_stp_fp_lr_sp_64b(u32 insn)
>>>>>>> +{
>>>>>>> +   /*
>>>>>>> +    * The 1st instruction on function entry often follows the
>>>>>>> +    * patten 'stp x29, x30, [sp, #imm]!' that pushing fp and lr
>>>>>>> +    * into stack.
>>>>>>> +    */
>>>>>>> +   return aarch64_insn_is_stp_pre(insn) &&
>>>>>>> +          (((insn >> 30) & 0x03) ==  2) && /* opc == 10 */
>>>>>>> +          (((insn >>  5) & 0x1F) == 31) && /* Rn  is sp */
>>>>>>> +          (((insn >> 10) & 0x1F) == 30) && /* Rt2 is x29 */
>>>>>>> +          (((insn >>  0) & 0x1F) == 29);   /* Rt  is x30 */
>>>>>>> +}
>>>>>>
>>>>>> We have accessors for these fields. Please use them.
>>>>>
>>>>> Do you mean aarch64_insn_decode_register()?
>>>>>
>>>>>>
>>>>>> Regardless, as above I do not think we should have a helper this
>>>>>> specific (with Rn, Rt, and Rt2 values hard-coded) inside <asm/insn.h>.
>>>>>
>>>>> If we left necessary of emulation of STP aside, where would the best file to
>>>>> place these hard-coded decoder helper?
>>>>>
>>>>>>
>>>>>>>  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
>>>>>>>  u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
>>>>>>>  u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
>>>>>>> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
>>>>>>> index 968d5fffe233..df7ca16fc763 100644
>>>>>>> --- a/arch/arm64/kernel/probes/decode-insn.c
>>>>>>> +++ b/arch/arm64/kernel/probes/decode-insn.c
>>>>>>> @@ -73,8 +73,22 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
>>>>>>>   *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
>>>>>>>   */
>>>>>>>  enum probe_insn __kprobes
>>>>>>> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
>>>>>>> +arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api,
>>>>>>> +                 bool kernel)
>>>>>>>  {
>>>>>>> +   /*
>>>>>>> +    * While 'nop' and 'stp x29, x30, [sp, #imm]! instructions can
>>>>>>> +    * execute in the out-of-line slot, simulating them in breakpoint
>>>>>>> +    * handling offers better performance.
>>>>>>> +    */
>>>>>>> +   if (aarch64_insn_is_nop(insn)) {
>>>>>>> +           api->handler = simulate_nop;
>>>>>>> +           return INSN_GOOD_NO_SLOT;
>>>>>>> +   } else if (!kernel && aarch64_insn_is_stp_fp_lr_sp_64b(insn)) {
>>>>>>> +           api->handler = simulate_stp_fp_lr_sp_64b;
>>>>>>> +           return INSN_GOOD_NO_SLOT;
>>>>>>> +   }
>>>>>>
>>>>>> With the STP emulation gone, you won't need the kernel parameter here.>
>>>>>>> +
>>>>>>>     /*
>>>>>>>      * Instructions reading or modifying the PC won't work from the XOL
>>>>>>>      * slot.
>>>>>>> @@ -157,7 +171,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
>>>>>>>             else
>>>>>>>                     scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
>>>>>>>     }
>>>>>>> -   decoded = arm_probe_decode_insn(insn, &asi->api);
>>>>>>> +   decoded = arm_probe_decode_insn(insn, &asi->api, true);
>>>>>>>
>>>>>>>     if (decoded != INSN_REJECTED && scan_end)
>>>>>>>             if (is_probed_address_atomic(addr - 1, scan_end))
>>>>>>> diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kernel/probes/decode-insn.h
>>>>>>> index 8b758c5a2062..ec4607189933 100644
>>>>>>> --- a/arch/arm64/kernel/probes/decode-insn.h
>>>>>>> +++ b/arch/arm64/kernel/probes/decode-insn.h
>>>>>>> @@ -28,6 +28,7 @@ enum probe_insn __kprobes
>>>>>>>  arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi);
>>>>>>>  #endif
>>>>>>>  enum probe_insn __kprobes
>>>>>>> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *asi);
>>>>>>> +arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *asi,
>>>>>>> +                 bool kernel);
>>>>>>>
>>>>>>>  #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
>>>>>>> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
>>>>>>> index 22d0b3252476..0b1623fa7003 100644
>>>>>>> --- a/arch/arm64/kernel/probes/simulate-insn.c
>>>>>>> +++ b/arch/arm64/kernel/probes/simulate-insn.c
>>>>>>> @@ -200,3 +200,31 @@ simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
>>>>>>>
>>>>>>>     instruction_pointer_set(regs, instruction_pointer(regs) + 4);
>>>>>>>  }
>>>>>>> +
>>>>>>> +void __kprobes
>>>>>>> +simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
>>>>>>> +{
>>>>>>> +   instruction_pointer_set(regs, instruction_pointer(regs) + 4);
>>>>>>> +}
>>>>>>
>>>>>> Hmm, this forgets to update the single-step state machine and PSTATE.BT,
>>>>>> and that's an extant bug in arch_uprobe_post_xol(). This can be:
>>>>>
>>>>> For emulated instruction, uprobe won't enable single-step mode of CPU,
>>>>> please check the handle_swbp() in kernel/events/uprobes.c:
>>>>>
>>>>>   if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>>>>>           goto out;
>>>>>
>>>>>   if (!pre_ssout(uprobe, regs, bp_vaddr))
>>>>>           return;
>>>>>
>>>>> For emualted instruction, It will skip entire single-stepping and associated
>>>>> exception, which typically begins with pre_ssout() and ends with
>>>>> arch_uprobe_post_xol(). Therefore, using instruction_pointer_set() to emulate
>>>>> NOP is generally not a bad idea.
>>>>>
>>>>>>
>>>>>> | void __kprobes
>>>>>> | simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
>>>>>> | {
>>>>>> |    arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
>>>>>> | }
>>>>>>
>>>>>>> +
>>>>>>> +void __kprobes
>>>>>>> +simulate_stp_fp_lr_sp_64b(u32 opcode, long addr, struct pt_regs *regs)
>>>>>>> +{
>>>>>>> +   long imm7;
>>>>>>> +   u64 buf[2];
>>>>>>> +   long new_sp;
>>>>>>> +
>>>>>>> +   imm7 = sign_extend64((opcode >> 15) & 0x7f, 6);
>>>>>>> +   new_sp = regs->sp + (imm7 << 3);
>>>>>>
>>>>>> We have accessors for these fields, please use them.
>>>>>
>>>>> Do you mean aarch64_insn_decode_immediate()?
>>>>>
>>>>>>
>>>>>>> +
>>>>>>> +   buf[0] = regs->regs[29];
>>>>>>> +   buf[1] = regs->regs[30];
>>>>>>> +
>>>>>>> +   if (copy_to_user((void __user *)new_sp, buf, sizeof(buf))) {
>>>>>>> +           force_sig(SIGSEGV);
>>>>>>> +           return;
>>>>>>> +   }
>>>>>>
>>>>>> As above, this won't interact with VMSA features (e.g. MTE, POE) in the
>>>>>> same way as an STP in userspace, and this will not have the same
>>>>>> atomicity properties as an STP>
>>>>>>> +
>>>>>>> +   regs->sp = new_sp;
>>>>>>> +   instruction_pointer_set(regs, instruction_pointer(regs) + 4);
>>>>>>
>>>>>> Likewise, this sould need ot use arm64_skip_faulting_instruction(),
>>>>>> though as above I think we should drop STP emulation entirely.
>>>>>
>>>>> I explain the reason why using instruction_pointer_set() under your comments
>>>>> for simulate_nop().
>>>>>
>>>>> Thanks.
>>>>>
>>>>>>
>>>>>> Mark.
>>>>>>
>>>>>
>>>>
>>>> --
>>>> BR
>>>> Liao, Chang
>>>>
>>
>> --
>> BR
>> Liao, Chang

-- 
BR
Liao, Chang

