Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC80F5E6673
	for <lists+bpf@lfdr.de>; Thu, 22 Sep 2022 17:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiIVPHb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Sep 2022 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiIVPHa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Sep 2022 11:07:30 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCFEE118A
        for <bpf@vger.kernel.org>; Thu, 22 Sep 2022 08:07:29 -0700 (PDT)
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1obNnT-0005tN-E9; Thu, 22 Sep 2022 17:07:27 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1obNnT-0008Ff-9B; Thu, 22 Sep 2022 17:07:27 +0200
Subject: Re: [PATCH bpf-next] bpf,x64: use shrx/sarx/shlx when available
To:     Jie Meng <jmeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org
References: <20220921022143.1405126-1-jmeng@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <a6d54d1e-f525-0351-18bd-647ea3d4814f@iogearbox.net>
Date:   Thu, 22 Sep 2022 17:07:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220921022143.1405126-1-jmeng@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26666/Thu Sep 22 09:54:12 2022)
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/21/22 4:21 AM, Jie Meng wrote:
> Instead of shr/sar/shl that implicitly use %cl, emit their more flexible
> alternatives provided in BMI2
> 
> Signed-off-by: Jie Meng <jmeng@fb.com>
> ---
>   arch/x86/net/bpf_jit_comp.c                | 53 ++++++++++++++++++++++
>   tools/testing/selftests/bpf/verifier/jit.c |  7 +--
>   2 files changed, 57 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index ae89f4143eb4..81a3b34327ae 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -889,6 +889,35 @@ static void emit_nops(u8 **pprog, int len)
>   	*pprog = prog;
>   }
>   
> +static void emit_3vex(u8 **pprog, bool r, bool x, bool b, u8 m,
> +		      bool w, u8 src_reg2, bool l, u8 p)
> +{
> +	u8 *prog = *pprog;
> +	u8 b0 = 0xc4, b1, b2;
> +	u8 src2 = reg2hex[src_reg2];
> +
> +	if (is_ereg(src_reg2))
> +		src2 |= 1 << 3;
> +
> +	/*
> +	 *    7                           0
> +	 *  +---+---+---+---+---+---+---+---+
> +	 *  |~R |~X |~B |         m         |
> +	 *  +---+---+---+---+---+---+---+---+
> +	 */
> +	b1 = (!r << 7) | (!x << 6) | (!b << 5) | (m & 0x1f);
> +	/*
> +	 *    7                           0
> +	 *  +---+---+---+---+---+---+---+---+
> +	 *  | W |     ~vvvv     | L |   pp  |
> +	 *  +---+---+---+---+---+---+---+---+
> +	 */
> +	b2 = (w << 7) | ((~src2 & 0xf) << 3) | (l << 2) | (p & 3);
> +
> +	EMIT3(b0, b1, b2);
> +	*pprog = prog;
> +}
> +
>   #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>   
>   static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
> @@ -1135,7 +1164,31 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>   		case BPF_ALU64 | BPF_LSH | BPF_X:
>   		case BPF_ALU64 | BPF_RSH | BPF_X:
>   		case BPF_ALU64 | BPF_ARSH | BPF_X:
> +			if (boot_cpu_has(X86_FEATURE_BMI2)) {
> +				/* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
> +				bool r = is_ereg(dst_reg);
> +				u8 m = 2; /* escape code 0f38 */
> +				bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
> +				u8 p;
> +
> +				switch (BPF_OP(insn->code)) {
> +				case BPF_LSH:
> +					p = 1; /* prefix 0x66 */
> +					break;
> +				case BPF_RSH:
> +					p = 3; /* prefix 0xf2 */
> +					break;
> +				case BPF_ARSH:
> +					p = 2; /* prefix 0xf3 */
> +					break;
> +				}
> +
> +				emit_3vex(&prog, r, false, r, m,
> +					  w, src_reg, false, p);
> +				EMIT2(0xf7, add_2reg(0xC0, dst_reg, dst_reg));
>   
> +				break;
> +			}
>   			/* Check for bad case when dst_reg == rcx */
>   			if (dst_reg == BPF_REG_4) {
>   				/* mov r11, dst_reg */

Nice!

> diff --git a/tools/testing/selftests/bpf/verifier/jit.c b/tools/testing/selftests/bpf/verifier/jit.c
> index 79021c30e51e..3323b93f0972 100644
> --- a/tools/testing/selftests/bpf/verifier/jit.c
> +++ b/tools/testing/selftests/bpf/verifier/jit.c
> @@ -4,15 +4,16 @@
>   	BPF_MOV64_IMM(BPF_REG_0, 1),
>   	BPF_MOV64_IMM(BPF_REG_1, 0xff),
>   	BPF_ALU64_IMM(BPF_LSH, BPF_REG_1, 1),
> -	BPF_ALU32_IMM(BPF_LSH, BPF_REG_1, 1),
> +	BPF_ALU32_REG(BPF_LSH, BPF_REG_1, BPF_REG_0),
>   	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3fc, 1),
>   	BPF_EXIT_INSN(),
> -	BPF_ALU64_IMM(BPF_RSH, BPF_REG_1, 1),
> +	BPF_ALU64_REG(BPF_RSH, BPF_REG_1, BPF_REG_0),
>   	BPF_ALU32_IMM(BPF_RSH, BPF_REG_1, 1),
>   	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0xff, 1),
>   	BPF_EXIT_INSN(),
>   	BPF_ALU64_IMM(BPF_ARSH, BPF_REG_1, 1),
> -	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x7f, 1),
> +	BPF_ALU32_REG(BPF_ARSH, BPF_REG_1, BPF_REG_0),
> +	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0x3f, 1),

Could you add this as separate commit with adding tests rather than changing
existing ones?

Would also be great to include lib/test_bpf.ko test results into above commit
message given it has more extensive JIT tests than test_verifier.

>   	BPF_EXIT_INSN(),
>   	BPF_MOV64_IMM(BPF_REG_0, 2),
>   	BPF_EXIT_INSN(),
> 

