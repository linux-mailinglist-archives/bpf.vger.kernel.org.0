Return-Path: <bpf+bounces-73395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CEA1C2E78B
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 00:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA7844F2619
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 23:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812C630DD10;
	Mon,  3 Nov 2025 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1OPMehH"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0575A30B517;
	Mon,  3 Nov 2025 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762213658; cv=none; b=t5Oh2BAWlAOMZKBuwRXCPLaCfhCmUxHU7K24QeEzc3hwTlgbU5YOXKp0k3sjAU4g8Lx+N758l93+mae5eClwr3MHGgzre8cjSL2hLvKSVHV1pmf1rIIyOv///Q/jECsl+MiBYFiBRyaiiRDjFToi11cIY+DxxwbDVSQuKfnrhBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762213658; c=relaxed/simple;
	bh=++5v+qj/aQU606vtiHtyIuKVbu0YqW3mLq98xG0aOlc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=YCrMqBuLDku/eYdCIE8yKK+3uxucjHyCAr0xdmEKBo0LLA/h0/LBJK2rAL73X3J1dfIseudQDKq5vVPKVIbsRu4gMnn55Xm/zlEq7wNK+gt/sgEvgBZ3n5BvzWAvsuFJiypI8R05cdjZR19+7jACm34N0xXZ10UtbnY5GL7zqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1OPMehH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD8EC4AF09;
	Mon,  3 Nov 2025 23:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762213657;
	bh=++5v+qj/aQU606vtiHtyIuKVbu0YqW3mLq98xG0aOlc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=d1OPMehH7wY3/3U4ttsVgFxUE/l8RnvtHnBSqm2044DJ65S9hEurs19c+zv0gRTdd
	 hayKTFb7HSNP7A8MyOOf0topQIEV5EzTEvESEM0v7xKfLfQ2JP0hA0RSnQQLzo9shZ
	 ED3BfUCVfCHs1mUBa8F49Or/ge9dtcIG3r0b4V4zOZ5KqsyUgFRdU0FUU1DGsZN2R2
	 OVpSF/y5LBAyha7QOTZuJojW+fDFBlIPzlyV33f1pJwqsJz5IqbL0jep7K87AM4/4l
	 2OFmKvG9ISJ4Y9SMOX7ABNCCfcLsRIK8oY2uJ/kEGLeBCjl9pMGnokXxXSpOn/skvA
	 0V3ZhRdKn1J7A==
Content-Type: multipart/mixed; boundary="===============7051654016357934767=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bb44afd60873d171a8482032e466d2827018486ecd13b4047df74632d2df4950@mail.kernel.org>
In-Reply-To: <20251103220924.36371-3-jolsa@kernel.org>
References: <20251103220924.36371-3-jolsa@kernel.org>
Subject: Re: [PATCHv2 2/4] x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,mhiramat@kernel.org,rostedt@goodmis.org,jpoimboe@kernel.org
Cc: peterz@infradead.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,x86@kernel.org,yhs@fb.com,songliubraving@fb.com,andrii@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  3 Nov 2025 23:47:37 +0000 (UTC)

--===============7051654016357934767==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 93156ac4f..b08c95872 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -56,6 +56,11 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
>  	return &arch_ftrace_regs(fregs)->regs;
>  }
>
> +#define arch_ftrace_partial_regs(regs) do {	\
> +	regs->flags &= ~X86_EFLAGS_FIXED;	\
> +	regs->cs = __KERNEL_CS;			\
> +} while (0)
> +

Can arch_ftrace_partial_regs read uninitialized regs->flags?

In return_to_handler, the ftrace_regs structure is allocated on the
stack but only a few fields are initialized (RAX, RDX, RBP, RSP).
The EFLAGS/flags field is never written before
arch_ftrace_partial_regs reads it:

arch/x86/kernel/ftrace_64.S return_to_handler:
    subq $(FRAME_SIZE), %rsp    # Allocate ftrace_regs on stack
    movq %rax, RAX(%rsp)
    movq %rdx, RDX(%rsp)
    movq %rbp, RBP(%rsp)
    movq %rsp, RSP(%rsp)
    # No initialization of EFLAGS field

Then ftrace_partial_regs()->arch_ftrace_partial_regs() executes:
    regs->flags &= ~X86_EFLAGS_FIXED;

This reads the uninitialized flags field. Stack allocations contain
garbage, so regs->flags will have whatever data was previously on
the stack. The &= operation produces undefined results when operating
on uninitialized memory.

For comparison, ftrace_regs_caller explicitly initializes EFLAGS:
    movq MCOUNT_REG_SIZE(%rsp), %rcx
    movq %rcx, EFLAGS(%rsp)

Should return_to_handler initialize regs->flags to 0 (or another
appropriate value) before arch_ftrace_partial_regs modifies it?

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19051288274

--===============7051654016357934767==--

