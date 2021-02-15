Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB9C31C3FC
	for <lists+bpf@lfdr.de>; Mon, 15 Feb 2021 23:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbhBOWVj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Feb 2021 17:21:39 -0500
Received: from www62.your-server.de ([213.133.104.62]:52966 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBOWVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Feb 2021 17:21:38 -0500
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lBmEi-000AoD-2g; Mon, 15 Feb 2021 23:20:56 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lBmEh-0000MZ-SI; Mon, 15 Feb 2021 23:20:55 +0100
Subject: Re: [PATCH bpf-next] bpf: x86: Explicitly zero-extend rax after
 32-bit cmpxchg
To:     Brendan Jackman <jackmanb@google.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
References: <20210215171208.1181305-1-jackmanb@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <44912664-5c0b-8d95-de01-c87b1e8a846c@iogearbox.net>
Date:   Mon, 15 Feb 2021 23:20:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210215171208.1181305-1-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26081/Mon Feb 15 13:19:24 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/15/21 6:12 PM, Brendan Jackman wrote:
> As pointed out by Ilya and explained in the new comment, there's a
> discrepancy between x86 and BPF CMPXCHG semantics: BPF always loads
> the value from memory into r0, while x86 only does so when r0 and the
> value in memory are different.
> 
> At first this might sound like pure semantics, but it makes a real
> difference when the comparison is 32-bit, since the load will
> zero-extend r0/rax.
> 
> The fix is to explicitly zero-extend rax after doing such a CMPXCHG.
> 
> Note that this doesn't generate totally optimal code: at one of
> emit_atomic's callsites (where BPF_{AND,OR,XOR} | BPF_FETCH are
> implemented), the new mov is superfluous because there's already a
> mov generated afterwards that will zero-extend r0. We could avoid
> this unnecessary mov by just moving the new logic outside of
> emit_atomic. But I think it's simpler to keep emit_atomic as a unit
> of correctness (it generates the correct x86 code for a certain set
> of BPF instructions, no further knowledge is needed to use it
> correctly).
> 
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Fixes: 5ffa25502b5a ("bpf: Add instructions for atomic_[cmp]xchg")
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>   arch/x86/net/bpf_jit_comp.c                   | 10 +++++++
>   .../selftests/bpf/verifier/atomic_cmpxchg.c   | 25 ++++++++++++++++++
>   .../selftests/bpf/verifier/atomic_or.c        | 26 +++++++++++++++++++
>   3 files changed, 61 insertions(+)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 79e7a0ec1da5..7919d5c54164 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -834,6 +834,16 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
>   
>   	emit_insn_suffix(&prog, dst_reg, src_reg, off);
>   
> +	if (atomic_op == BPF_CMPXCHG && bpf_size == BPF_W) {
> +		/*
> +		 * BPF_CMPXCHG unconditionally loads into R0, which means it
> +		 * zero-extends 32-bit values. However x86 CMPXCHG doesn't do a
> +		 * load if the comparison is successful. Therefore zero-extend
> +		 * explicitly.
> +		 */
> +		emit_mov_reg(&prog, false, BPF_REG_0, BPF_REG_0);

How does the situation look on other archs when they need to implement this in future?
Mainly asking whether it would be better to instead to move this logic into the verifier
instead, so it'll be consistent across all archs.

> +	}
> +
>   	*pprog = prog;
>   	return 0;
>   }
> diff --git a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> index 2efd8bcf57a1..6e52dfc64415 100644
> --- a/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> +++ b/tools/testing/selftests/bpf/verifier/atomic_cmpxchg.c
> @@ -94,3 +94,28 @@
>   	.result = REJECT,
>   	.errstr = "invalid read from stack",
>   },
> +{
> +	"BPF_W cmpxchg should zero top 32 bits",
> +	.insns = {
> +		/* r0 = U64_MAX; */
> +		BPF_MOV64_IMM(BPF_REG_0, 0),
> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_0, 1),
> +		/* u64 val = r0; */
> +		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_0, -8),
> +		/* r0 = (u32)atomic_cmpxchg((u32 *)&val, r0, 1); */
> +		BPF_MOV32_IMM(BPF_REG_1, 1),
> +		BPF_ATOMIC_OP(BPF_W, BPF_CMPXCHG, BPF_REG_10, BPF_REG_1, -8),
> +		/* r1 = 0x00000000FFFFFFFFull; */
> +		BPF_MOV64_IMM(BPF_REG_1, 1),
> +		BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 32),
> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
> +		/* if (r0 != r1) exit(1); */
> +		BPF_JMP_REG(BPF_JEQ, BPF_REG_0, BPF_REG_1, 2),
> +		BPF_MOV32_IMM(BPF_REG_0, 1),
> +		BPF_EXIT_INSN(),
> +		/* exit(0); */
> +		BPF_MOV32_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	},
> +	.result = ACCEPT,
> +},
> diff --git a/tools/testing/selftests/bpf/verifier/atomic_or.c b/tools/testing/selftests/bpf/verifier/atomic_or.c
> index 70f982e1f9f0..e0811eb11542 100644
> --- a/tools/testing/selftests/bpf/verifier/atomic_or.c
> +++ b/tools/testing/selftests/bpf/verifier/atomic_or.c
> @@ -75,3 +75,29 @@
>   	},
>   	.result = ACCEPT,
>   },
> +{
> +	"BPF_W atomic or should zero top 32 bits",
> +	.insns = {
> +		/* r1 = U64_MAX; */
> +		BPF_MOV64_IMM(BPF_REG_1, 0),
> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_1, 1),
> +		/* u64 val = r0; */
> +		BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_1, -8),
> +		/* r1 = (u32)atomic_sub((u32 *)&val, 1); */
> +		BPF_MOV32_IMM(BPF_REG_1, 2),
> +		BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH, BPF_REG_10, BPF_REG_1, -8),
> +		/* r2 = 0x00000000FFFFFFFF; */
> +		BPF_MOV64_IMM(BPF_REG_2, 1),
> +		BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 32),
> +		BPF_ALU64_IMM(BPF_SUB, BPF_REG_2, 1),
> +		/* if (r2 != r1) exit(1); */
> +		BPF_JMP_REG(BPF_JEQ, BPF_REG_2, BPF_REG_1, 2),
> +		/* BPF_MOV32_IMM(BPF_REG_0, 1), */
> +		BPF_MOV64_REG(BPF_REG_0, BPF_REG_1),
> +		BPF_EXIT_INSN(),
> +		/* exit(0); */
> +		BPF_MOV32_IMM(BPF_REG_0, 0),
> +		BPF_EXIT_INSN(),
> +	},
> +	.result = ACCEPT,
> +},
> 
> base-commit: 5e1d40b75ed85ecd76347273da17e5da195c3e96
> 

