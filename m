Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62FD5B3455
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 11:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiIIJrL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 05:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiIIJrK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 05:47:10 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90D3CF3BF4
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 02:47:09 -0700 (PDT)
Received: from [10.130.0.135] (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxkOCXCxtjqlIVAA--.20658S3;
        Fri, 09 Sep 2022 17:47:04 +0800 (CST)
Subject: Re: [PATCH bpf-next v3 3/4] LoongArch: Add BPF JIT support
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>, Xi Ruoyao <xry111@xry111.site>
References: <1661999249-10258-1-git-send-email-yangtiezhu@loongson.cn>
 <1661999249-10258-4-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4yU2tp=DBGCkdSzp-9bAXXDM4+0iqDgOac+fbgQnsx2A@mail.gmail.com>
 <1a740b5c-041c-85c6-f1d6-bb0b931c0c3e@loongson.cn>
 <CAAhV-H5vfw+Mv=LbQfa4sPHW91Z+ij3R8+LsHZOAiR+u7pJONw@mail.gmail.com>
 <cfc4c2e5-34af-b968-9c44-28e71731bb75@xen0n.name>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev, Li Xuefeng <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <16f24d7c-39c5-8dfa-a45f-61cd7f0e8b5f@loongson.cn>
Date:   Fri, 9 Sep 2022 17:47:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <cfc4c2e5-34af-b968-9c44-28e71731bb75@xen0n.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8CxkOCXCxtjqlIVAA--.20658S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4UKF1DAr4kZry8Jw13urg_yoW7JrWUpF
        W3KFZ8KFs3JFy3AF9Fqw45Xa4ay39xKr13XF15Kry8A3s0qr1FgFWrGr1Y9a4DC34xZr1q
        9F48try3Z3W5AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUgN6JUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 09/09/2022 12:51 AM, WANG Xuerui wrote:
> Hi,
>
> On 9/4/22 17:04, Huacai Chen wrote:
>> On Sat, Sep 3, 2022 at 6:11 PM Tiezhu Yang <yangtiezhu@loongson.cn>
>> wrote:
>>>
>>>
>>> On 09/03/2022 04:32 PM, Huacai Chen wrote:
>>>> On Thu, Sep 1, 2022 at 10:27 AM Tiezhu Yang <yangtiezhu@loongson.cn>
>>>> wrote:
>>>>> BPF programs are normally handled by a BPF interpreter, add BPF JIT
>>>>> support for LoongArch to allow the kernel to generate native code
>>>>> when a program is loaded into the kernel, this will significantly
>>>>> speed-up processing of BPF programs.
>>> [...]
>>>
>>>>> +
>>>>> +static inline int emit_cond_jmp(struct jit_ctx *ctx, u8 cond, enum
>>>>> loongarch_gpr rj,
>>>>> +                               enum loongarch_gpr rd, int jmp_offset)
>>>>> +{
>>>>> +       /*
>>>>> +        * A large PC-relative jump offset may overflow the
>>>>> immediate field of
>>>>> +        * the native conditional branch instruction, triggering a
>>>>> conversion
>>>>> +        * to use an absolute jump instead, this jump sequence is
>>>>> particularly
>>>>> +        * nasty. For now, use cond_jmp_offs26() directly to keep
>>>>> it simple.
>>>>> +        * In the future, maybe we can add support for far
>>>>> branching, the branch
>>>>> +        * relaxation requires more than two passes to converge,
>>>>> the code seems
>>>>> +        * too complex to understand, not quite sure whether it is
>>>>> necessary and
>>>>> +        * worth the extra pain. Anyway, just leave it as it is to
>>>>> enhance code
>>>>> +        * readability now.
>>>> Oh, no. I don't think this is a very difficult problem, because the
>>>> old version has already solved [1]. Please improve your code and send
>>>> V4.
>>>> BTW, I have committed V3 with some small modifications in
>>>> https://github.com/loongson/linux/commits/loongarch-next, please make
>>>> V4 based on that.
>>>>
>>>> [1]
>>>> https://github.com/loongson/linux/commit/e20b2353f40cd13720996524e1df6d0ca086eeb8#diff-6d2f4f5a862a5dce12f8eb0feeca095825c4ed1c2e7151b0905fb8d03c98922e
>>>>
>>>>
>>>> --------code in the old version--------
>>>> static inline void emit_cond_jump(struct jit_ctx *ctx, u8 cond, enum
>>>> loongarch_gpr rj,
>>>>                                    enum loongarch_gpr rd, int
>>>> jmp_offset)
>>>> {
>>>>          if (is_signed_imm16(jmp_offset))
>>>>                  cond_jump_offs16(ctx, cond, rj, rd, jmp_offset);
>>>>          else if (is_signed_imm26(jmp_offset))
>>>>                  cond_jump_offs26(ctx, cond, rj, rd, jmp_offset);
>>>>          else
>>>>                  cond_jump_offs32(ctx, cond, rj, rd, jmp_offset);
>>>> }
>>>>
>>>> static inline void emit_uncond_jump(struct jit_ctx *ctx, int
>>>> jmp_offset, bool is_exit)
>>>> {
>>>>          if (is_signed_imm26(jmp_offset))
>>>>                  uncond_jump_offs26(ctx, jmp_offset);
>>>>          else
>>>>                  uncond_jump_offs32(ctx, jmp_offset, is_exit);
>>>> }
>>>> --------end of code--------
>>>>
>>>> Huacai
>>>>
>>> Hi Huacai,
>>>
>>> This change is to pass the special test cases:
>>> "a new type of jump test where the program jumps forwards
>>> and backwards with increasing offset. It mainly tests JITs where a
>>> relative jump may generate different JITed code depending on the offset
>>> size."
>>>
>>> They are introduced in commit a7d2e752e520 ("bpf/tests: Add staggered
>>> JMP and JMP32 tests") after the old internal version you mentioned.
>>>
>>> Here, we use the native instructions to enlarge the jump range to 26 bit
>>> directly rather than 16 bit first, and also take no account of more than
>>> 26 bit case because there is no native instruction and it needs to
>>> emulate.
>>>
>>> As the code comment said, this is to enhance code readability now.
>> I'm not familiar with bpf, Daniel, Ruoyao and Xuerui, what do you
>> think about it?
>
> I'm not familiar with eBPF JITs either, but from a cursory look it seems
> the readability isn't that bad even for the original version? It is
> clear that the appropriate instructions are selected according to size
> of the immediate. And the current way of doing things doesn't really fix
> the problem, it relies on the fact that *normally* the negative branch
> offset is expressible in 16 bits (actually 18 bits).
>
> So, at the very least, you should keep the fallback logic towards
> cond_jump_offs32. At which point adding back enough code so you're back
> to the original version doesn't sound like it's too much anyway...
>

Hi Huacai and Xuerui,

cond_jump_offs26() has the ability to handle the offs16 range, this
is intended to pass a new type of jump test where the program jumps
forwards and backwards with increasing offset.

The case with larger jump offset is rare, it can fall back to the
interpreter if jit failed.

As we discussed offline, the current implementation is OK,
the committed v3 with some small modifications by Huacai in
https://github.com/loongson/linux/commits/loongarch-next
looks good and works well, no need to do more modifications,
thank you all for your reviews.

Thanks,
Tiezhu

