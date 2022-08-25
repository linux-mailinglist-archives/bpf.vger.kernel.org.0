Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E0D5A073F
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 04:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiHYC1a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 22:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiHYC13 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 22:27:29 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45ABC923F9
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 19:27:27 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxReIH3gZjHWkJAA--.42101S3;
        Thu, 25 Aug 2022 10:27:20 +0800 (CST)
Subject: Re: [PATCH bpf-next v1 3/4] LoongArch: Add BPF JIT support
To:     Jinyang He <hejinyang@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <1660996260-11337-1-git-send-email-yangtiezhu@loongson.cn>
 <1660996260-11337-4-git-send-email-yangtiezhu@loongson.cn>
 <9a81abf8-27f3-fbbb-f3c4-2e9d071cde40@loongson.cn>
Cc:     bpf@vger.kernel.org, loongarch@lists.linux.dev
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <67d7a98e-43c4-965f-2796-2b64c5272004@loongson.cn>
Date:   Thu, 25 Aug 2022 10:27:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <9a81abf8-27f3-fbbb-f3c4-2e9d071cde40@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxReIH3gZjHWkJAA--.42101S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW7tr4rXF1fAryxXFW7twb_yoW8CF1fpa
        n0grWFkr48JFyjyF1kXr4Dt3yfJrsagF1DCa45KrZ7Ar90qry5KF40k3W5Ka9rG34kZ3Wv
        vr10vr9xWF17CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
        4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbpwZ7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Jinyang,

Thank you very much for your review.

On 08/22/2022 10:50 AM, Jinyang He wrote:
> Hi, Tiezhu,
>

[...]

>> +    emit_insn(ctx, addid, LOONGARCH_GPR_SP, LOONGARCH_GPR_SP,
>> -stack_adjust);
>
> Have you checked the stack size before this, such as in compiler or
> common codes? Is there any chance of overflow 12bits range?
>

MAX_BPF_STACK is 512, BPF program can access up to 512 bytes of stack
space, so it is OK here.

>> +    emit_insn(ctx, sllid, t2, a2, 3);
>> +    emit_insn(ctx, addd, t2, t2, a1);
> alsl.d

[...]

>> +            /* zero-extend 16 bits into 64 bits */
>> +            emit_insn(ctx, sllid, dst, dst, 48);
>> +            emit_insn(ctx, srlid, dst, dst, 48);
> bstrpick.d

[...]

>> +        move_imm32(ctx, t1, imm, false);
> imm = 0 -> t1->zero

[...]

> In BFD_W, BFF_DW cases, if offsets is quadruple and in 16bits range,
> we can use [ld/st]ptr.[w/d].

Good catch, I will modify the related code to save some instructions.

>> +static inline void emit_cond_jmp(struct jit_ctx *ctx, u8 cond, enum
>> loongarch_gpr rj,
>> +                 enum loongarch_gpr rd, int jmp_offset)
>> +{
>> +    cond_jmp_offs26(ctx, cond, rj, rd, jmp_offset);
>
> Why not call cond_jmp_offs16 as a preference?
>

Good question, this is intended to handle some special test cases.

A large PC-relative jump offset may overflow the immediate field of
the native conditional branch instruction, triggering a conversion
to use an absolute jump instead, this jump sequence is particularly
nasty. For now, let us use cond_jmp_offs26() directly to keep it
simple. In the future, maybe we can add support for far branching,
the branch relaxation requires more than two passes to converge,
the code seems too complex to understand, not quite sure whether it
is necessary and worth the extra pain. Anyway, just leave it as is
to enhance code readability now.

I will add code comments to explain the above considerations.

Thanks,
Tiezhu

