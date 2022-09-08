Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0355B23FD
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiIHQyF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 12:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiIHQxj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 12:53:39 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63068A50E2
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1662655872; bh=6rntCE9dXBNSFS5I+DqUbsib3Q8FiCqlcnV09DyYO8k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QqmkQIoKV27YBXmyYvx1s7Qwjy2qL/PRqcK3qzYXqVKJpGH7ujt17XTyNl5INihOv
         XBrtBEGTa9cySF8l72gVttG+EVlX52dBiLRHr79JGLveT0RPlqCXSBjnYQNgQuweJf
         iDvnNwstIkzN04o8H+UIQwcgFQBpoNiNIL2hTSvk=
Received: from [192.168.9.172] (unknown [101.88.26.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id BAE55600BD;
        Fri,  9 Sep 2022 00:51:11 +0800 (CST)
Message-ID: <cfc4c2e5-34af-b968-9c44-28e71731bb75@xen0n.name>
Date:   Fri, 9 Sep 2022 00:51:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:106.0) Gecko/20100101
 Thunderbird/106.0a1
Subject: Re: [PATCH bpf-next v3 3/4] LoongArch: Add BPF JIT support
Content-Language: en-US
To:     Huacai Chen <chenhuacai@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        WANG Xuerui <git@xen0n.name>, Xi Ruoyao <xry111@xry111.site>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        loongarch@lists.linux.dev, Li Xuefeng <lixuefeng@loongson.cn>
References: <1661999249-10258-1-git-send-email-yangtiezhu@loongson.cn>
 <1661999249-10258-4-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4yU2tp=DBGCkdSzp-9bAXXDM4+0iqDgOac+fbgQnsx2A@mail.gmail.com>
 <1a740b5c-041c-85c6-f1d6-bb0b931c0c3e@loongson.cn>
 <CAAhV-H5vfw+Mv=LbQfa4sPHW91Z+ij3R8+LsHZOAiR+u7pJONw@mail.gmail.com>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <CAAhV-H5vfw+Mv=LbQfa4sPHW91Z+ij3R8+LsHZOAiR+u7pJONw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 9/4/22 17:04, Huacai Chen wrote:
> On Sat, Sep 3, 2022 at 6:11 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>>
>> On 09/03/2022 04:32 PM, Huacai Chen wrote:
>>> On Thu, Sep 1, 2022 at 10:27 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>>> BPF programs are normally handled by a BPF interpreter, add BPF JIT
>>>> support for LoongArch to allow the kernel to generate native code
>>>> when a program is loaded into the kernel, this will significantly
>>>> speed-up processing of BPF programs.
>> [...]
>>
>>>> +
>>>> +static inline int emit_cond_jmp(struct jit_ctx *ctx, u8 cond, enum loongarch_gpr rj,
>>>> +                               enum loongarch_gpr rd, int jmp_offset)
>>>> +{
>>>> +       /*
>>>> +        * A large PC-relative jump offset may overflow the immediate field of
>>>> +        * the native conditional branch instruction, triggering a conversion
>>>> +        * to use an absolute jump instead, this jump sequence is particularly
>>>> +        * nasty. For now, use cond_jmp_offs26() directly to keep it simple.
>>>> +        * In the future, maybe we can add support for far branching, the branch
>>>> +        * relaxation requires more than two passes to converge, the code seems
>>>> +        * too complex to understand, not quite sure whether it is necessary and
>>>> +        * worth the extra pain. Anyway, just leave it as it is to enhance code
>>>> +        * readability now.
>>> Oh, no. I don't think this is a very difficult problem, because the
>>> old version has already solved [1]. Please improve your code and send
>>> V4.
>>> BTW, I have committed V3 with some small modifications in
>>> https://github.com/loongson/linux/commits/loongarch-next, please make
>>> V4 based on that.
>>>
>>> [1] https://github.com/loongson/linux/commit/e20b2353f40cd13720996524e1df6d0ca086eeb8#diff-6d2f4f5a862a5dce12f8eb0feeca095825c4ed1c2e7151b0905fb8d03c98922e
>>>
>>> --------code in the old version--------
>>> static inline void emit_cond_jump(struct jit_ctx *ctx, u8 cond, enum
>>> loongarch_gpr rj,
>>>                                    enum loongarch_gpr rd, int jmp_offset)
>>> {
>>>          if (is_signed_imm16(jmp_offset))
>>>                  cond_jump_offs16(ctx, cond, rj, rd, jmp_offset);
>>>          else if (is_signed_imm26(jmp_offset))
>>>                  cond_jump_offs26(ctx, cond, rj, rd, jmp_offset);
>>>          else
>>>                  cond_jump_offs32(ctx, cond, rj, rd, jmp_offset);
>>> }
>>>
>>> static inline void emit_uncond_jump(struct jit_ctx *ctx, int
>>> jmp_offset, bool is_exit)
>>> {
>>>          if (is_signed_imm26(jmp_offset))
>>>                  uncond_jump_offs26(ctx, jmp_offset);
>>>          else
>>>                  uncond_jump_offs32(ctx, jmp_offset, is_exit);
>>> }
>>> --------end of code--------
>>>
>>> Huacai
>>>
>> Hi Huacai,
>>
>> This change is to pass the special test cases:
>> "a new type of jump test where the program jumps forwards
>> and backwards with increasing offset. It mainly tests JITs where a
>> relative jump may generate different JITed code depending on the offset
>> size."
>>
>> They are introduced in commit a7d2e752e520 ("bpf/tests: Add staggered
>> JMP and JMP32 tests") after the old internal version you mentioned.
>>
>> Here, we use the native instructions to enlarge the jump range to 26 bit
>> directly rather than 16 bit first, and also take no account of more than
>> 26 bit case because there is no native instruction and it needs to emulate.
>>
>> As the code comment said, this is to enhance code readability now.
> I'm not familiar with bpf, Daniel, Ruoyao and Xuerui, what do you
> think about it?

I'm not familiar with eBPF JITs either, but from a cursory look it seems 
the readability isn't that bad even for the original version? It is 
clear that the appropriate instructions are selected according to size 
of the immediate. And the current way of doing things doesn't really fix 
the problem, it relies on the fact that *normally* the negative branch 
offset is expressible in 16 bits (actually 18 bits).

So, at the very least, you should keep the fallback logic towards 
cond_jump_offs32. At which point adding back enough code so you're back 
to the original version doesn't sound like it's too much anyway...

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

