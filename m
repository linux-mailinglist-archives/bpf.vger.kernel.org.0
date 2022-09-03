Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F51F5ABE6B
	for <lists+bpf@lfdr.de>; Sat,  3 Sep 2022 12:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbiICKL0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Sep 2022 06:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiICKLZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 3 Sep 2022 06:11:25 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F21695E544
        for <bpf@vger.kernel.org>; Sat,  3 Sep 2022 03:11:23 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxTWtEKBNjh2oQAA--.8249S3;
        Sat, 03 Sep 2022 18:11:16 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 3/4] LoongArch: Add BPF JIT support
To:     Huacai Chen <chenhuacai@kernel.org>
References: <1661999249-10258-1-git-send-email-yangtiezhu@loongson.cn>
 <1661999249-10258-4-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4yU2tp=DBGCkdSzp-9bAXXDM4+0iqDgOac+fbgQnsx2A@mail.gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev, Li Xuefeng <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <1a740b5c-041c-85c6-f1d6-bb0b931c0c3e@loongson.cn>
Date:   Sat, 3 Sep 2022 18:11:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAAhV-H4yU2tp=DBGCkdSzp-9bAXXDM4+0iqDgOac+fbgQnsx2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8AxTWtEKBNjh2oQAA--.8249S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXrykXr15CFW8ur1DXFW5ZFb_yoW5CrW3pF
        43KrZ8KF4fGFy3AFyDXr4UXa4akwsIgry7AF15KrykA3yYqryF9FWrK3ZYgas8Cas7Zwn0
        9F4Fyrnru3W5GFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU5IAp7UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 09/03/2022 04:32 PM, Huacai Chen wrote:
> On Thu, Sep 1, 2022 at 10:27 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> BPF programs are normally handled by a BPF interpreter, add BPF JIT
>> support for LoongArch to allow the kernel to generate native code
>> when a program is loaded into the kernel, this will significantly
>> speed-up processing of BPF programs.

[...]

>> +
>> +static inline int emit_cond_jmp(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
>> +                               enum loongarch_gpr rd, int jmp_offset)
>> +{
>> +       /*
>> +        * A large PC-relative jump offset may overflow the immediate field of
>> +        * the native conditional branch instruction, triggering a conversion
>> +        * to use an absolute jump instead, this jump sequence is particularly
>> +        * nasty. For now, use cond_jmp_offs26() directly to keep it simple.
>> +        * In the future, maybe we can add support for far branching, the branch
>> +        * relaxation requires more than two passes to converge, the code seems
>> +        * too complex to understand, not quite sure whether it is necessary and
>> +        * worth the extra pain. Anyway, just leave it as it is to enhance code
>> +        * readability now.
> Oh, no. I don't think this is a very difficult problem, because the
> old version has already solved [1]. Please improve your code and send
> V4.
> BTW, I have committed V3 with some small modifications in
> https://github.com/loongson/linux/commits/loongarch-next, please make
> V4 based on that.
>
> [1] https://github.com/loongson/linux/commit/e20b2353f40cd13720996524e1df6d0ca086eeb8#diff-6d2f4f5a862a5dce12f8eb0feeca095825c4ed1c2e7151b0905fb8d03c98922e
>
> --------code in the old version--------
> static inline void emit_cond_jump(struct jit_ctx *ctx, u8 cond, enum
> loongarch_gpr rj,
>                                   enum loongarch_gpr rd, int jmp_offset)
> {
>         if (is_signed_imm16(jmp_offset))
>                 cond_jump_offs16(ctx, cond, rj, rd, jmp_offset);
>         else if (is_signed_imm26(jmp_offset))
>                 cond_jump_offs26(ctx, cond, rj, rd, jmp_offset);
>         else
>                 cond_jump_offs32(ctx, cond, rj, rd, jmp_offset);
> }
>
> static inline void emit_uncond_jump(struct jit_ctx *ctx, int
> jmp_offset, bool is_exit)
> {
>         if (is_signed_imm26(jmp_offset))
>                 uncond_jump_offs26(ctx, jmp_offset);
>         else
>                 uncond_jump_offs32(ctx, jmp_offset, is_exit);
> }
> --------end of code--------
>
> Huacai
>

Hi Huacai,

This change is to pass the special test cases:
"a new type of jump test where the program jumps forwards
and backwards with increasing offset. It mainly tests JITs where a
relative jump may generate different JITed code depending on the offset
size."

They are introduced in commit a7d2e752e520 ("bpf/tests: Add staggered
JMP and JMP32 tests") after the old internal version you mentioned.

Here, we use the native instructions to enlarge the jump range to 26 bit
directly rather than 16 bit first, and also take no account of more than
26 bit case because there is no native instruction and it needs to emulate.

As the code comment said, this is to enhance code readability now.

Thanks,
Tiezhu

