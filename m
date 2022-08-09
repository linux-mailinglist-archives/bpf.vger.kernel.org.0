Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B158D286
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 06:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiHID4p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 23:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiHID4o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 23:56:44 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8646415A10
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 20:56:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Ax+szx2vFi5rgKAA--.18728S3;
        Tue, 09 Aug 2022 11:56:34 +0800 (CST)
Subject: Re: [RFC PATCH 3/5] LoongArch: Add BPF JIT support
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <1660013580-19053-1-git-send-email-yangtiezhu@loongson.cn>
 <1660013580-19053-4-git-send-email-yangtiezhu@loongson.cn>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
From:   Jinyang He <hejinyang@loongson.cn>
Message-ID: <2d5a385e-b126-34d7-bf5b-ce8f13e9501b@loongson.cn>
Date:   Tue, 9 Aug 2022 11:56:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1660013580-19053-4-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Ax+szx2vFi5rgKAA--.18728S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uF4xZFyDKF43Wr13Wr18AFb_yoW8uw4xpF
        4jyrn3Kr48Jr93JF93t3y5ur13Jrs3WrZagF1ayrZ7Ga15X3s5C34rKw1vyFWxGw18GF4v
        q3Zayw1xW3Z8GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
        1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
        64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
        0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
        IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2rcTDUUUU
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 08/09/2022 10:52 AM, Tiezhu Yang wrote:

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
[...]
> +static inline void emit_ldbu(union loongarch_instruction *insn,
> +			     enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
> +{
> +	insn->reg2i12_format.opcode = ldbu_op;
> +	insn->reg2i12_format.immediate = imm;
> +	insn->reg2i12_format.rd = rd;
> +	insn->reg2i12_format.rj = rj;
> +}
> +
> +static inline void emit_ldhu(union loongarch_instruction *insn,
> +			     enum loongarch_gpr rd, enum loongarch_gpr rj, int imm)
> +{
> +	insn->reg2i12_format.opcode = ldhu_op;
> +	insn->reg2i12_format.immediate = imm;
> +	insn->reg2i12_format.rd = rd;
> +	insn->reg2i12_format.rj = rj;
> +}
> +
Hi, Tiezhu,

These emit_* functions are similar to each other. I'd suggest that
using macro warpper them and keep them in 'inst.h'.

One of ways like follows,

#define DEF_EMIT_REG2I12_FORMAT(NAME,OP) \
static inline void emit_##NAME(union loongarch_instruction *insn, \
                  enum loongarch_gpr rd, enum loongarch_gpr rj, int imm) \
{ \
     insn->reg2i12_format.opcode = OP; \
     insn->reg2i12_format.immediate = imm; \
     insn->reg2i12_format.rd = rd; \
     insn->reg2i12_format.rj = rj; \
}

DEF_EMIT_REG2I12_FORMAT(ldbu, ldbu_op)
DEF_EMIT_REG2I12_FORMAT(ldhu, ldhu_op)
...
[...]

Thanks,
Jinyang

