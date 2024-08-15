Return-Path: <bpf+bounces-37257-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1498952C61
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 12:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3692E28485A
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 10:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F21E1A76B5;
	Thu, 15 Aug 2024 09:58:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DCB17C9BB;
	Thu, 15 Aug 2024 09:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715905; cv=none; b=nR+IMxZNhd4cwwXtZcjjSsnaSu4KtimoVILGaXVVJ8ICRILh17h0udKfUMJr/cQQE6s4BLHk8kAxdYSdCrqnMECL+90qh7BEJSga96na2gEWayvGazju7h6VEXo21V1ncmCJw1J6YLFxDf6wYyAFWp3bad1pK/XooFiJlxqGJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715905; c=relaxed/simple;
	bh=vKo9hspsXvC/ePUKhbA6qWkIsei7vnTadE3TXtNfLwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9Gc/YLmFYJYThNsuS9W+Y+ILksvP/4tEbjp9Y8gCFXs8PXjGeW4QvIsRmqm7hyCctOY/+2u781cchgE2Q3apQ8pu3S3p2byE7cw+5Q54V7CZ+gRgTWFU6LX9GnzxPN2OVwLl8NkShlAGdCdAhTy0Yxvl+CZ+j1rvHG+NOa1iZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EA36169E;
	Thu, 15 Aug 2024 02:58:48 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1154C3F73B;
	Thu, 15 Aug 2024 02:58:19 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:58:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Liao Chang <liaochang1@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org,
	oleg@redhat.com, peterz@infradead.org, puranjay@kernel.org,
	ast@kernel.org, andrii@kernel.org, xukuohai@huawei.com,
	revest@chromium.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] arm64: insn: Simulate nop and push instruction for
 better uprobe performance
Message-ID: <Zr3RN4zxF5XPgjEB@J2N7QTR9R3>
References: <20240814080356.2639544-1-liaochang1@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240814080356.2639544-1-liaochang1@huawei.com>

On Wed, Aug 14, 2024 at 08:03:56AM +0000, Liao Chang wrote:
> As Andrii pointed out, the uprobe/uretprobe selftest bench run into a
> counterintuitive result that nop and push variants are much slower than
> ret variant [0]. The root cause lies in the arch_probe_analyse_insn(),
> which excludes 'nop' and 'stp' from the emulatable instructions list.
> This force the kernel returns to userspace and execute them out-of-line,
> then trapping back to kernel for running uprobe callback functions. This
> leads to a significant performance overhead compared to 'ret' variant,
> which is already emulated.

I appreciate this might be surprising, but does it actually matter
outside of a microbenchmark?

> Typicall uprobe is installed on 'nop' for USDT and on function entry
> which starts with the instrucion 'stp x29, x30, [sp, #imm]!' to push lr
> and fp into stack regardless kernel or userspace binary. 

Function entry doesn't always start with a STP; these days it's often a
BTI or PACIASP, and for non-leaf functions (or with shrink-wrapping in
the compiler), it could be any arbitrary instruction. This might happen
to be the common case today, but there are certain;y codebases where it
is not.

STP (or any instruction that accesses memory) is fairly painful to
emulate because you need to ensure that the correct atomicity and
ordering properties are provided (e.g. an aligned STP should be
single-copy-atomic, but copy_to_user() doesn't guarantee that except by
chance), and that the correct VMSA behaviour is provided (e.g. when
interacting with MTE, POE, etc, while the uaccess primitives don't try
to be 100% equivalent to instructions in userspace).

For those reasons, in general I don't think we should be emulating any
instruction which accesses memory, and we should not try to emulate the
STP, but I think it's entirely reasonable to emulate NOP.

> In order to
> improve the performance of handling uprobe for common usecases. This
> patch supports the emulation of Arm64 equvialents instructions of 'nop'
> and 'push'. The benchmark results below indicates the performance gain
> of emulation is obvious.
> 
> On Kunpeng916 (Hi1616), 4 NUMA nodes, 64 Arm64 cores@2.4GHz.
> 
> xol (1 cpus)
> ------------
> uprobe-nop:  0.916 ± 0.001M/s (0.916M/prod)
> uprobe-push: 0.908 ± 0.001M/s (0.908M/prod)
> uprobe-ret:  1.855 ± 0.000M/s (1.855M/prod)
> uretprobe-nop:  0.640 ± 0.000M/s (0.640M/prod)
> uretprobe-push: 0.633 ± 0.001M/s (0.633M/prod)
> uretprobe-ret:  0.978 ± 0.003M/s (0.978M/prod)
> 
> emulation (1 cpus)
> -------------------
> uprobe-nop:  1.862 ± 0.002M/s  (1.862M/prod)
> uprobe-push: 1.743 ± 0.006M/s  (1.743M/prod)
> uprobe-ret:  1.840 ± 0.001M/s  (1.840M/prod)
> uretprobe-nop:  0.964 ± 0.004M/s  (0.964M/prod)
> uretprobe-push: 0.936 ± 0.004M/s  (0.936M/prod)
> uretprobe-ret:  0.940 ± 0.001M/s  (0.940M/prod)
> 
> As shown above, the performance gap between 'nop/push' and 'ret'
> variants has been significantly reduced. Due to the emulation of 'push'
> instruction needs to access userspace memory, it spent more cycles than
> the other.
> 
> [0] https://lore.kernel.org/all/CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com/
> 
> Signed-off-by: Liao Chang <liaochang1@huawei.com>
> ---
>  arch/arm64/include/asm/insn.h            | 21 ++++++++++++++++++
>  arch/arm64/kernel/probes/decode-insn.c   | 18 +++++++++++++--
>  arch/arm64/kernel/probes/decode-insn.h   |  3 ++-
>  arch/arm64/kernel/probes/simulate-insn.c | 28 ++++++++++++++++++++++++
>  arch/arm64/kernel/probes/simulate-insn.h |  2 ++
>  arch/arm64/kernel/probes/uprobes.c       |  2 +-
>  6 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index 8c0a36f72d6f..a246e6e550ba 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -549,6 +549,27 @@ static __always_inline bool aarch64_insn_uses_literal(u32 insn)
>  	       aarch64_insn_is_prfm_lit(insn);
>  }
>  
> +static __always_inline bool aarch64_insn_is_nop(u32 insn)
> +{
> +	/* nop */
> +	return aarch64_insn_is_hint(insn) &&
> +	       ((insn & 0xFE0) == AARCH64_INSN_HINT_NOP);
> +}

This looks fine, but the comment can go.

> +static __always_inline bool aarch64_insn_is_stp_fp_lr_sp_64b(u32 insn)
> +{
> +	/*
> +	 * The 1st instruction on function entry often follows the
> +	 * patten 'stp x29, x30, [sp, #imm]!' that pushing fp and lr
> +	 * into stack.
> +	 */
> +	return aarch64_insn_is_stp_pre(insn) &&
> +	       (((insn >> 30) & 0x03) ==  2) && /* opc == 10 */
> +	       (((insn >>  5) & 0x1F) == 31) && /* Rn  is sp */
> +	       (((insn >> 10) & 0x1F) == 30) && /* Rt2 is x29 */
> +	       (((insn >>  0) & 0x1F) == 29);	/* Rt  is x30 */
> +}

We have accessors for these fields. Please use them.

Regardless, as above I do not think we should have a helper this
specific (with Rn, Rt, and Rt2 values hard-coded) inside <asm/insn.h>.

>  enum aarch64_insn_encoding_class aarch64_get_insn_class(u32 insn);
>  u64 aarch64_insn_decode_immediate(enum aarch64_insn_imm_type type, u32 insn);
>  u32 aarch64_insn_encode_immediate(enum aarch64_insn_imm_type type,
> diff --git a/arch/arm64/kernel/probes/decode-insn.c b/arch/arm64/kernel/probes/decode-insn.c
> index 968d5fffe233..df7ca16fc763 100644
> --- a/arch/arm64/kernel/probes/decode-insn.c
> +++ b/arch/arm64/kernel/probes/decode-insn.c
> @@ -73,8 +73,22 @@ static bool __kprobes aarch64_insn_is_steppable(u32 insn)
>   *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its slot.
>   */
>  enum probe_insn __kprobes
> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api)
> +arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *api,
> +		      bool kernel)
>  {
> +	/*
> +	 * While 'nop' and 'stp x29, x30, [sp, #imm]! instructions can
> +	 * execute in the out-of-line slot, simulating them in breakpoint
> +	 * handling offers better performance.
> +	 */
> +	if (aarch64_insn_is_nop(insn)) {
> +		api->handler = simulate_nop;
> +		return INSN_GOOD_NO_SLOT;
> +	} else if (!kernel && aarch64_insn_is_stp_fp_lr_sp_64b(insn)) {
> +		api->handler = simulate_stp_fp_lr_sp_64b;
> +		return INSN_GOOD_NO_SLOT;
> +	}

With the STP emulation gone, you won't need the kernel parameter here.

> +
>  	/*
>  	 * Instructions reading or modifying the PC won't work from the XOL
>  	 * slot.
> @@ -157,7 +171,7 @@ arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi)
>  		else
>  			scan_end = addr - MAX_ATOMIC_CONTEXT_SIZE;
>  	}
> -	decoded = arm_probe_decode_insn(insn, &asi->api);
> +	decoded = arm_probe_decode_insn(insn, &asi->api, true);
>  
>  	if (decoded != INSN_REJECTED && scan_end)
>  		if (is_probed_address_atomic(addr - 1, scan_end))
> diff --git a/arch/arm64/kernel/probes/decode-insn.h b/arch/arm64/kernel/probes/decode-insn.h
> index 8b758c5a2062..ec4607189933 100644
> --- a/arch/arm64/kernel/probes/decode-insn.h
> +++ b/arch/arm64/kernel/probes/decode-insn.h
> @@ -28,6 +28,7 @@ enum probe_insn __kprobes
>  arm_kprobe_decode_insn(kprobe_opcode_t *addr, struct arch_specific_insn *asi);
>  #endif
>  enum probe_insn __kprobes
> -arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *asi);
> +arm_probe_decode_insn(probe_opcode_t insn, struct arch_probe_insn *asi,
> +		      bool kernel);
>  
>  #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> index 22d0b3252476..0b1623fa7003 100644
> --- a/arch/arm64/kernel/probes/simulate-insn.c
> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> @@ -200,3 +200,31 @@ simulate_ldrsw_literal(u32 opcode, long addr, struct pt_regs *regs)
>  
>  	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
>  }
> +
> +void __kprobes
> +simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	instruction_pointer_set(regs, instruction_pointer(regs) + 4);
> +}

Hmm, this forgets to update the single-step state machine and PSTATE.BT,
and that's an extant bug in arch_uprobe_post_xol(). This can be:

| void __kprobes
| simulate_nop(u32 opcode, long addr, struct pt_regs *regs)
| {
| 	arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
| }

> +
> +void __kprobes
> +simulate_stp_fp_lr_sp_64b(u32 opcode, long addr, struct pt_regs *regs)
> +{
> +	long imm7;
> +	u64 buf[2];
> +	long new_sp;
> +
> +	imm7 = sign_extend64((opcode >> 15) & 0x7f, 6);
> +	new_sp = regs->sp + (imm7 << 3);

We have accessors for these fields, please use them.

> +
> +	buf[0] = regs->regs[29];
> +	buf[1] = regs->regs[30];
> +
> +	if (copy_to_user((void __user *)new_sp, buf, sizeof(buf))) {
> +		force_sig(SIGSEGV);
> +		return;
> +	}

As above, this won't interact with VMSA features (e.g. MTE, POE) in the
same way as an STP in userspace, and this will not have the same
atomicity properties as an STP.

> +
> +	regs->sp = new_sp;
> +	instruction_pointer_set(regs, instruction_pointer(regs) + 4);

Likewise, this sould need ot use arm64_skip_faulting_instruction(),
though as above I think we should drop STP emulation entirely.

Mark.

