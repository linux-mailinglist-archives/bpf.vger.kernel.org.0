Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD3158D307
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 06:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiHIEzi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 00:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiHIEzh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 00:55:37 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFAB51DA53
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 21:55:34 -0700 (PDT)
Received: from [10.130.0.63] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxIM+_6PFi3cUKAA--.34602S3;
        Tue, 09 Aug 2022 12:55:28 +0800 (CST)
Subject: Re: [RFC PATCH 3/5] LoongArch: Add BPF JIT support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
References: <1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn>
 <1660013580-19053-4-git-send-email-yangtiezhu@loongson.cn>
From:   Qing Zhang <zhangqing@loongson.cn>
Message-ID: <ab694f5c-10df-8c90-b8e5-a20368fb9b7d@loongson.cn>
Date:   Tue, 9 Aug 2022 12:55:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1660013580-19053-4-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9DxIM+_6PFi3cUKAA--.34602S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4UWFW8Wr1DJF1fCw4xCrg_yoWrCF4kp3
        ZxKF4fGFyjq3W7tFn3Xryjvr98GwsagF4DWry7Jr48GryDZa4rGF1UKF1fGayDJrWkJr18
        Zrn0krnFkr1Dt37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUfcTPUUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
Tiezhu

On 2022/8/9 上午10:52, Tiezhu Yang wrote:
> BPF programs are normally handled by a BPF interpreter, add BPF JIT
> support for LoongArch to allow the kernel to generate native code
> when a program is loaded into the kernel, this will significantly
> speed-up processing of BPF programs.
> 
> Co-developed-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/loongarch/Kbuild        |    1 +
>   arch/loongarch/Kconfig       |    1 +
>   arch/loongarch/net/Makefile  |    7 +
>   arch/loongarch/net/bpf_jit.c | 1119 ++++++++++++++++++++++++++++++++++++++++++
>   arch/loongarch/net/bpf_jit.h |  946 +++++++++++++++++++++++++++++++++++
>   5 files changed, 2074 insertions(+)
>   create mode 100644 arch/loongarch/net/Makefile
>   create mode 100644 arch/loongarch/net/bpf_jit.c
>   create mode 100644 arch/loongarch/net/bpf_jit.h
> 
> diff --git a/arch/loongarch/Kbuild b/arch/loongarch/Kbuild
> +
[...]
> +/*
> + * eBPF prog stack layout:
> + *
> + *                                        high
> + * original $sp ------------> +-------------------------+ <--LOONGARCH_GPR_FP
> + *                            |           $ra           |
> + *                            +-------------------------+
> + *                            |           $fp           |
> + *                            +-------------------------+
> + *                            |           $s0           |
> + *                            +-------------------------+
> + *                            |           $s1           |
> + *                            +-------------------------+
> + *                            |           $s2           |
> + *                            +-------------------------+
> + *                            |           $s3           |
> + *                            +-------------------------+
> + *                            |           $s4           |
> + *                            +-------------------------+
> + *                            |           $s5           |
> + *                            +-------------------------+ <--BPF_REG_FP
> + *                            |  prog->aux->stack_depth |
> + *                            |        (optional)       |
> + * current $sp -------------> +-------------------------+
> + *                                        low
> + */
> +static void build_prologue(struct jit_ctx *ctx)
> +{
> +	int stack_adjust = 0, store_offset, bpf_stack_adjust;
> +
> +	bpf_stack_adjust = round_up(ctx->prog->aux->stack_depth, 16);
> +
> +	stack_adjust += sizeof(long); /* LOONGARCH_GPR_RA */
> +	stack_adjust += sizeof(long); /* LOONGARCH_GPR_FP */
> +	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S0 */
> +	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S1 */
> +	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S2 */
> +	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S3 */
> +	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S4 */
> +	stack_adjust += sizeof(long); /* LOONGARCH_GPR_S5 */
> +
> +	stack_adjust = round_up(stack_adjust, 16);
> +	stack_adjust += bpf_stack_adjust;

Maybe get the size of stack_adjust can be combined together, and only 
need one comment.

Thanks,
Qing
> +	/*
> +	 * First instruction initializes the tail call count (TCC).
> +	 * On tail call we skip this instruction, and the TCC is
> +	 * passed in REG_TCC from the caller.
> +	 */
> +	emit_insn(ctx, addid, REG_TCC, LOONGARCH_GPR_ZERO, MAX_TAIL_CALL_CNT);
> +
> +	emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP, -stack_adjust);
> +
> +	store_offset = stack_adjust - sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_RA, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S0, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S1, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S2, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S3, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S4, LOONGARCH_GPR_SP, store_offset);
> +
> +	store_offset -= sizeof(long);
> +	emit_insn(ctx, std, LOONGARCH_GPR_S5, LOONGARCH_GPR_SP, store_offset);
> +
> +	emit_insn(ctx, addid, LOONGARCH_GPR_FP, LOONGARCH_GPR_SP, stack_adjust);
> +
> +	if (bpf_stack_adjust)
> +		emit_insn(ctx, addid, regmap[BPF_REG_FP], LOONGARCH_GPR_SP, bpf_stack_adjust);
> +
> +	/*
> +	 * Program contains calls and tail calls, so REG_TCC need
> +	 * to be saved across calls.
> +	 */
> +	if (seen_tail_call(ctx) && seen_call(ctx))
> +		move_reg(ctx, TCC_SAVED, REG_TCC);
> +
> +	ctx->stack_size = stack_adjust;
> +}

