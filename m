Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BCC41E420
	for <lists+bpf@lfdr.de>; Fri,  1 Oct 2021 00:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344063AbhI3Wvx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Sep 2021 18:51:53 -0400
Received: from www62.your-server.de ([213.133.104.62]:41382 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343860AbhI3Wvx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 18:51:53 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1mW4sS-0005pA-06; Fri, 01 Oct 2021 00:50:08 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1mW4sR-0006zC-Rz; Fri, 01 Oct 2021 00:50:07 +0200
Subject: Re: [PATCH bpf-next] bpf,x64: Save bytes for DIV by reducing reg
 copies
To:     Jie Meng <jmeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org
References: <20210929234702.3927503-1-jmeng@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1770fc45-aee7-bc0d-1c96-7001d5dbe7a1@iogearbox.net>
Date:   Fri, 1 Oct 2021 00:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210929234702.3927503-1-jmeng@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26308/Thu Sep 30 11:04:45 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/30/21 1:47 AM, Jie Meng wrote:
> Instead of unconditionally performing push/pop on rax/rdx in case of
> division/modulo, we can save a few bytes in case of dest register
> being either BPF r0 (rax) or r3 (rdx) since the result is written in
> there anyway.
> 
> Also, we do not need to copy src to r11 unless src is either rax, rdx
> or an immediate.
> 
> Signed-off-by: Jie Meng <jmeng@fb.com>

Thanks for looking into this!

Diff looks correct to me, but it would be nice to add some more details into the commit
description so that this better visualizes before/after which would have helped review
as well, example [0].

   [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ced185824c89b60e65b5a2606954c098320cdfb8

>   arch/x86/net/bpf_jit_comp.c                | 71 +++++++++++++---------
>   tools/testing/selftests/bpf/verifier/jit.c | 28 +++++++++
>   2 files changed, 70 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 20d2d6a1f9de..346b4131d496 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1028,19 +1028,30 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>   		case BPF_ALU64 | BPF_MOD | BPF_X:
>   		case BPF_ALU64 | BPF_DIV | BPF_X:
>   		case BPF_ALU64 | BPF_MOD | BPF_K:
> -		case BPF_ALU64 | BPF_DIV | BPF_K:
> -			EMIT1(0x50); /* push rax */
> -			EMIT1(0x52); /* push rdx */
> -
> -			if (BPF_SRC(insn->code) == BPF_X)
> -				/* mov r11, src_reg */
> -				EMIT_mov(AUX_REG, src_reg);
> -			else
> +		case BPF_ALU64 | BPF_DIV | BPF_K: {
> +			bool is64 = BPF_CLASS(insn->code) == BPF_ALU64;
> +
> +			if (dst_reg != BPF_REG_0)
> +				EMIT1(0x50); /* push rax */
> +			if (dst_reg != BPF_REG_3)
> +				EMIT1(0x52); /* push rdx */
> +
> +			if (BPF_SRC(insn->code) == BPF_X) {
> +				if (src_reg == BPF_REG_0 ||
> +				    src_reg == BPF_REG_3) {
> +					/* mov r11, src_reg */
> +					EMIT_mov(AUX_REG, src_reg);
> +					src_reg = AUX_REG;
> +				}
> +			} else {
>   				/* mov r11, imm32 */
>   				EMIT3_off32(0x49, 0xC7, 0xC3, imm32);
> +				src_reg = AUX_REG;
> +			}
>   
> -			/* mov rax, dst_reg */
> -			EMIT_mov(BPF_REG_0, dst_reg);
> +			if (dst_reg != BPF_REG_0)
> +				/* mov rax, dst_reg */
> +				emit_mov_reg(&prog, is64, BPF_REG_0, dst_reg);
>   
>   			/*
>   			 * xor edx, edx
> @@ -1048,26 +1059,28 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
>   			 */
>   			EMIT2(0x31, 0xd2);
>   
> -			if (BPF_CLASS(insn->code) == BPF_ALU64)
> -				/* div r11 */
> -				EMIT3(0x49, 0xF7, 0xF3);
> -			else
> -				/* div r11d */
> -				EMIT3(0x41, 0xF7, 0xF3);
> -
> -			if (BPF_OP(insn->code) == BPF_MOD)
> -				/* mov r11, rdx */
> -				EMIT3(0x49, 0x89, 0xD3);
> -			else
> -				/* mov r11, rax */
> -				EMIT3(0x49, 0x89, 0xC3);
> -
> -			EMIT1(0x5A); /* pop rdx */
> -			EMIT1(0x58); /* pop rax */
> -
> -			/* mov dst_reg, r11 */
> -			EMIT_mov(dst_reg, AUX_REG);
> +			if (is64)
> +				EMIT1(add_1mod(0x48, src_reg));
> +			else if (is_ereg(src_reg))
> +				EMIT1(add_1mod(0x40, src_reg));
> +			/* div src_reg */
> +			EMIT2(0xF7, add_1reg(0xF0, src_reg));
> +
> +			if (BPF_OP(insn->code) == BPF_MOD &&
> +			    dst_reg != BPF_REG_3)
> +				/* mov dst_reg, rdx */
> +				emit_mov_reg(&prog, is64, dst_reg, BPF_REG_3);
> +			else if (BPF_OP(insn->code) == BPF_DIV &&
> +				 dst_reg != BPF_REG_0)
> +				/* mov dst_reg, rax */
> +				emit_mov_reg(&prog, is64, dst_reg, BPF_REG_0);
> +
> +			if (dst_reg != BPF_REG_3)
> +				EMIT1(0x5A); /* pop rdx */
> +			if (dst_reg != BPF_REG_0)
> +				EMIT1(0x58); /* pop rax */
>   			break;
> +		}
>   
>   		case BPF_ALU | BPF_MUL | BPF_K:
>   		case BPF_ALU64 | BPF_MUL | BPF_K:
> diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/selftests/bpf/verifier/jit.c
> index eedcb752bf70..0f2583f0685a 100644
> --- a/tools/testing/selftests/bpf/verifier/jit.c
> +++ b/tools/testing/selftests/bpf/verifier/jit.c
> @@ -102,6 +102,34 @@
>   	.result = ACCEPT,
>   	.retval = 2,
>   },
> +{
> +	"jit: various div tests",
> +	.insns = {
> +	BPF_LD_IMM64(BPF_REG_2, 0xefeffeULL),
> +	BPF_LD_IMM64(BPF_REG_0, 0xeeff0d413122ULL),
> +	BPF_LD_IMM64(BPF_REG_1, 0xfefeeeULL),
> +	BPF_ALU64_REG(BPF_DIV, BPF_REG_0, BPF_REG_1),
> +	BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_2, 2),
> +	BPF_MOV64_IMM(BPF_REG_0, 1),
> +	BPF_EXIT_INSN(),
> +	BPF_LD_IMM64(BPF_REG_2, 0xaa93ULL),
> +	BPF_ALU64_IMM(BPF_MOD, BPF_REG_1, 0xbeefULL),
> +	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
> +	BPF_MOV64_IMM(BPF_REG_0, 1),
> +	BPF_EXIT_INSN(),
> +	BPF_LD_IMM64(BPF_REG_2, 0x5ee1dULL),
> +	BPF_LD_IMM64(BPF_REG_1, 0xfefeeeULL),
> +	BPF_LD_IMM64(BPF_REG_3, 0x2bULL),
> +	BPF_ALU32_REG(BPF_DIV, BPF_REG_1, BPF_REG_3),

Could you add some more coverage? This only has BPF_DIV + BPF_X, but lets also
add ...

  - BPF_DIV + BPF_K
  - BPF_MOD + BPF_X
  - BPF_MOD + BPF_K

... and corner cases were src == dst reg, for combinations with R0/R3/R<other>.

> +	BPF_JMP_REG(BPF_JEQ, BPF_REG_1, BPF_REG_2, 2),
> +	BPF_MOV64_IMM(BPF_REG_0, 1),
> +	BPF_EXIT_INSN(),
> +	BPF_MOV64_IMM(BPF_REG_0, 2),
> +	BPF_EXIT_INSN(),
> +	},
> +	.result = ACCEPT,
> +	.retval = 2,
> +},
>   {
>   	"jit: jsgt, jslt",
>   	.insns = {
> 

