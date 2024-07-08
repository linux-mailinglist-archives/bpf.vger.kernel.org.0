Return-Path: <bpf+bounces-34072-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53A892A16F
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 13:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5921F2204F
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8317E111;
	Mon,  8 Jul 2024 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNIe+VcE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9892E85E
	for <bpf@vger.kernel.org>; Mon,  8 Jul 2024 11:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439079; cv=none; b=oO8lGDa07Rdp8SAmSJXGdKLBKr/Wc2HGt2sknY24ZmW5E4lxbtixR4yaFyyRJpqwptXCqxmBNhMbjJqwaK5Ey2WdVnjHwR+9f8FE2imO7lltFr8T6KPKOJ+gzUwV211D9FP95A3iQIf6rRtC4v0A9yxR5M2AkF8P2DUhJfNVvrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439079; c=relaxed/simple;
	bh=YG3CutD+pjxR3VUH+H5jPuMMCy2X+Q9Uvs32ms6xh4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=crMmanmdh3uyHPVwJmWrXrG+qenAh7R35o7A66mx0CRNkTU4Rhlns+jj9RcV+FW4wbulmXqZgVgBobDorOUxhYhG73QRNLtipPdPBBHyV+2I+ohveug5h01BQ6JD+QN2VuKJjufXA1k7PFoAmv+q1vlvp+9Y5f4Q+xtAHxb9FMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNIe+VcE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9B2C116B1;
	Mon,  8 Jul 2024 11:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720439079;
	bh=YG3CutD+pjxR3VUH+H5jPuMMCy2X+Q9Uvs32ms6xh4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oNIe+VcERg5FNYylzH8V8Axbk8Kuvzo021KDKcbJFUXmWurFq5XPIG7jfO1L3rg1N
	 dLMAKLJyFrB6iR0Icp7B5lxwFgnMAANN8k5XZT8oBid3uDzIKl/Mx7VNZXe4+7+yS+
	 VZ2T2lN06l4osAYFb/asgYt0h+RYPqPIlgh4jVSIo7mPjN40LEnRKvCSXgGA8M4Laf
	 Yi0+PVUcUg1OMItakXRLVGbiJANKpCdW4oSH422bLlT2Wq2Dq+LWe8TPl+W/j/qCHz
	 L6pL3Tjw3ySpRBIPw+TKEWlgYQImjqQ7vURVQWiwtFEm8JrKVKDwtVVcTtGA3pclVL
	 Hm2Rq9NzXn88w==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, jose.marchesi@oracle.com,
 Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [RFC bpf-next v2 0/9] no_caller_saved_registers attribute for
 helper calls
In-Reply-To: <20240704102402.1644916-1-eddyz87@gmail.com>
References: <20240704102402.1644916-1-eddyz87@gmail.com>
Date: Mon, 08 Jul 2024 11:44:30 +0000
Message-ID: <mb61psewk3y75.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> This RFC seeks to allow using no_caller_saved_registers gcc/clang
> attribute with some BPF helper functions (and kfuncs in the future).
>
> As documented in [1], this attribute means that function scratches
> only some of the caller saved registers defined by ABI.
> For BPF the set of such registers could be defined as follows:
> - R0 is scratched only if function is non-void;
> - R1-R5 are scratched only if corresponding parameter type is defined
>   in the function prototype.
>
> The goal of the RFC is to implement no_caller_saved_registers
> (nocsr for short) in a backwards compatible manner:
> - for kernels that support the feature, gain some performance boost
>   from better register allocation;
> - for kernels that don't support the feature, allow programs execution
>   with minor performance losses.
>
> To achieve this, use a scheme suggested by Alexei Starovoitov:
> - for nocsr calls clang allocates registers as-if relevant r0-r5
>   registers are not scratched by the call;
> - as a post-processing step, clang visits each nocsr call and adds
>   spill/fill for every live r0-r5;
> - stack offsets used for spills/fills are allocated as minimal
>   stack offsets in whole function and are not used for any other
>   purposes;
> - when kernel loads a program, it looks for such patterns
>   (nocsr function surrounded by spills/fills) and checks if
>   spill/fill stack offsets are used exclusively in nocsr patterns;
> - if so, and if current JIT inlines the call to the nocsr function
>   (e.g. a helper call), kernel removes unnecessary spill/fill pairs;
> - when old kernel loads a program, presence of spill/fill pairs
>   keeps BPF program valid, albeit slightly less efficient.
>
> Corresponding clang/llvm changes are available in [2].
>
> The patch-set uses bpf_get_smp_processor_id() function as a canary,
> making it the first helper with nocsr attribute.
>
> For example, consider the following program:
>
>   #define __no_csr __attribute__((no_caller_saved_registers))
>   #define SEC(name) __attribute__((section(name), used))
>   #define bpf_printk(fmt, ...) bpf_trace_printk((fmt), sizeof(fmt), __VA_ARGS__)
>
>   typedef unsigned int __u32;
>
>   static long (* const bpf_trace_printk)(const char *fmt, __u32 fmt_size, ...) = (void *) 6;
>   static __u32 (*const bpf_get_smp_processor_id)(void) __no_csr = (void *)8;
>
>   SEC("raw_tp")
>   int test(void *ctx)
>   {
>           __u32 task = bpf_get_smp_processor_id();
>   	bpf_printk("ctx=%p, smp=%d", ctx, task);
>   	return 0;
>   }
>
>   char _license[] SEC("license") = "GPL";
>
> Compiled (using [2]) as follows:
>
>   $ clang --target=bpf -O2 -g -c -o nocsr.bpf.o nocsr.bpf.c
>   $ llvm-objdump --no-show-raw-insn -Sd nocsr.bpf.o
>     ...
>   3rd parameter for printk call     removable spill/fill pair
>   .--- 0:       r3 = r1                             |
> ; |       __u32 task = bpf_get_smp_processor_id();  |
>   |    1:       *(u64 *)(r10 - 0x8) = r3 <----------|
>   |    2:       call 0x8                            |
>   |    3:       r3 = *(u64 *)(r10 - 0x8) <----------'
> ; |     bpf_printk("ctx=%p, smp=%d", ctx, task);
>   |    4:       r1 = 0x0 ll
>   |    6:       r2 = 0xf
>   |    7:       r4 = r0
>   '--> 8:       call 0x6
> ;       return 0;
>        9:       r0 = 0x0
>       10:       exit
>
> Here is how the program looks after verifier processing:
>
>   # bpftool prog load ./nocsr.bpf.o /sys/fs/bpf/nocsr-test
>   # bpftool prog dump xlated pinned /sys/fs/bpf/nocsr-test
>   int test(void * ctx):
>   ; int test(void *ctx)
>      0: (bf) r3 = r1               <--------- 3rd printk parameter
>   ; __u32 task = bpf_get_smp_processor_id();
>      1: (b4) w0 = 197132           <--------- inlined helper call,
>      2: (bf) r0 = r0               <--------- spill/fill pair removed
>      3: (61) r0 = *(u32 *)(r0 +0)  <---------
>   ; bpf_printk("ctx=%p, smp=%d", ctx, task);
>      4: (18) r1 = map[id:13][0]+0
>      6: (b7) r2 = 15
>      7: (bf) r4 = r0
>      8: (85) call bpf_trace_printk#-125920
>   ; return 0;
>      9: (b7) r0 = 0
>     10: (95) exit
>
> [1] https://clang.llvm.org/docs/AttributeReference.html#no-caller-saved-registers
> [2] https://github.com/eddyz87/llvm-project/tree/bpf-no-caller-saved-registers
>
> Change list:
> - v1 -> v2:
>   - assume that functions inlined by either jit or verifier
>     conform to no_caller_saved_registers contract (Andrii, Puranjay);
>   - allow nocsr rewrite for bpf_get_smp_processor_id()
>     on arm64 and riscv64 architectures (Puranjay);
>   - __arch_{x86_64,arm64,riscv64} macro for test_loader;
>   - moved remove_nocsr_spills_fills() inside do_misc_fixups() (Andrii);
>   - moved nocsr pattern detection from check_cfg() to a separate pass
>     (Andrii);
>   - various stylistic/correctness changes according to Andrii's
>     comments.
>
> Revisions:
> - v1 https://lore.kernel.org/bpf/20240629094733.3863850-1-eddyz87@gmail.com/
>
> Eduard Zingerman (9):
>   bpf: add a get_helper_proto() utility function
>   bpf: no_caller_saved_registers attribute for helper calls
>   bpf, x86, riscv, arm: no_caller_saved_registers for
>     bpf_get_smp_processor_id()

Ran the selftest on riscv-64 on qemu:

    root@rv-tester:~/bpf# uname -a
    Linux rv-tester 6.10.0-rc2 #27 SMP Mon Jul  8 09:58:20 UTC 2024 riscv64 riscv64 riscv64 GNU/Linux
    root@rv-tester:~/bpf# ./test_progs -a verifier_nocsr/canary_arm64_riscv64
    #496/2   verifier_nocsr/canary_arm64_riscv64:OK
    #496     verifier_nocsr:OK
    Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Tested-by: Puranjay Mohan <puranjay@kernel.org> #riscv64

Thanks,
Puranjay

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIoEARYKADIWIQQ3wHGvVs/5bdl78BKwwPkjG3B2nQUCZovRHxQccHVyYW5qYXlA
a2VybmVsLm9yZwAKCRCwwPkjG3B2nSEeAP9Z8w0ukOliebTdfOokCq6JSe6mgl87
p59Mo+/zXHqF4wD6A/Km4Qea7z87BexOsoZCah76xrDQGcHSNVteGsX3RA4=
=4kTl
-----END PGP SIGNATURE-----
--=-=-=--

