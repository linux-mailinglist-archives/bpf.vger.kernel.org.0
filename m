Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320155B0A2D
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 18:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiIGQdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 12:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiIGQdf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 12:33:35 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90E09F8F3
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 09:33:33 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bj14so8035466wrb.12
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 09:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4rNxGZClM+AOboRJNQMJuz69LOqh9OQDobU79RJiGNY=;
        b=vgBXhBOiCSVa/WEBFzNA626iDwUvf+waoqeE9atCZ6mpLbDVRRszn+vFKlw5lkoBe7
         PU9P8X+h84zdVr1RjS3OMxiePsYC7M1tTL1k4hbvPyBDBKb8cOMtfmwBXpMGoWAzw3Ur
         i72LCAFbRXCfQBUqZAFcY2+wY5v4g8X+/1T8HnbfnmuuKtZ6PKunw2CP3dDLOsylzzSu
         d9u5koXVvXwEWrCDnhunyRlaImeLbzrFyqzJgiz9jdQ6PKUu/K9aLKrn+QeRbewvp9SD
         3E/kxVllZwuppvXjxL7tM+otaP1fNLwZliV+fe1AKd4Bx2h2FEli0FDKWFuYkz1BOlHQ
         QQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4rNxGZClM+AOboRJNQMJuz69LOqh9OQDobU79RJiGNY=;
        b=CoZAI1bj1EL4liR+dKKBZcfgfkEGeW8u4QEw9RXdh9J5636d76wWJv1bgicS4PXaNB
         qBbGZwmIeJXAR3nbluO6dr5JCvuj0S0O8lyPRQOgoMJmEQ0xWe1Kt27XjxaXxQHmUeNo
         uovlTYrnCkL7oVAzp3sgETWb07epTjtxI4Idkmihg/B6hBe95U77jvh56DgOHY9k0Zts
         UHX81r7HMWWrQ2LJ4gH3OINIEhJ1nm6WPtLVAd2BvVrISprzSq1/YoeAZN1qTvx3MKL6
         YgW4YdyZeAn+Zk9wegumEkiJQbTN3w1OB1AhOyrNWcTBDU40ZlEyyeu2TPH+B7w/cTvo
         8piw==
X-Gm-Message-State: ACgBeo0LQo2aSNjeYAk8vNwEEGRNfWj5pE99W8crQbRvKZzZMBuJlPbd
        JFnjXhUDYsWk9Xjd4p/3Rltndg==
X-Google-Smtp-Source: AA6agR6iQLq+PgMMv2FujrvotkysMis7Aw1qOI2XN7pm5vS3sBnRQpmwXz3PWD0SLWetQXbzkOFhOg==
X-Received: by 2002:adf:d209:0:b0:228:6298:f288 with SMTP id j9-20020adfd209000000b002286298f288mr2595214wrh.386.1662568412423;
        Wed, 07 Sep 2022 09:33:32 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id f1-20020a7bcd01000000b003a35516ccc3sm19325350wmj.26.2022.09.07.09.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 09:33:31 -0700 (PDT)
Message-ID: <ca16b420-a4ae-9f9c-1f60-2e2b8df6b4a0@isovalent.com>
Date:   Wed, 7 Sep 2022 17:33:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH bpf-next 6/7] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
Content-Language: en-GB
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20220906133613.54928-1-quentin@isovalent.com>
 <20220906133613.54928-7-quentin@isovalent.com>
 <CAADnVQJ3K7cLTz9tiEEevyhuYVCO6BfB5NhAssReyYU7MNAyKw@mail.gmail.com>
 <f0d9d219-3e5b-94bc-3c90-897da8d27b12@isovalent.com>
 <CAADnVQKJCwMbvkY5ZNX7KLiB9YT35TK_S_cFH61csm1P2phDDw@mail.gmail.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <CAADnVQKJCwMbvkY5ZNX7KLiB9YT35TK_S_cFH61csm1P2phDDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/09/2022 17:10, Alexei Starovoitov wrote:
> On Wed, Sep 7, 2022 at 7:20 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>
>> On 07/09/2022 00:46, Alexei Starovoitov wrote:
>>> On Tue, Sep 6, 2022 at 6:36 AM Quentin Monnet <quentin@isovalent.com> wrote:
>>>>
>>>> Naturally, the display of disassembled instructions comes with a few
>>>> minor differences. Here is a sample output with libbfd (already
>>>> supported before this patch):
>>>>
>>>>     # bpftool prog dump jited id 56
>>>>     bpf_prog_6deef7357e7b4530:
>>>>        0:   nopl   0x0(%rax,%rax,1)
>>>>        5:   xchg   %ax,%ax
>>>>        7:   push   %rbp
>>>>        8:   mov    %rsp,%rbp
>>>>        b:   push   %rbx
>>>>        c:   push   %r13
>>>>        e:   push   %r14
>>>>       10:   mov    %rdi,%rbx
>>>>       13:   movzwq 0xb0(%rbx),%r13
>>>>       1b:   xor    %r14d,%r14d
>>>>       1e:   or     $0x2,%r14d
>>>>       22:   mov    $0x1,%eax
>>>>       27:   cmp    $0x2,%r14
>>>>       2b:   jne    0x000000000000002f
>>>>       2d:   xor    %eax,%eax
>>>>       2f:   pop    %r14
>>>>       31:   pop    %r13
>>>>       33:   pop    %rbx
>>>>       34:   leave
>>>>       35:   ret
>>>>       36:   int3
>>>>
>>>> LLVM supports several variants that we could set when initialising the
>>>> disassembler, for example with:
>>>>
>>>>     LLVMSetDisasmOptions(*ctx,
>>>>                          LLVMDisassembler_Option_AsmPrinterVariant);
>>>>
>>>> but the default printer is kept for now. Here is the output with LLVM:
>>>>
>>>>     # bpftool prog dump jited id 56
>>>>     bpf_prog_6deef7357e7b4530:
>>>>        0:   nopl    (%rax,%rax)
>>>>        5:   nop
>>>>        7:   pushq   %rbp
>>>>        8:   movq    %rsp, %rbp
>>>>        b:   pushq   %rbx
>>>>        c:   pushq   %r13
>>>>        e:   pushq   %r14
>>>>       10:   movq    %rdi, %rbx
>>>>       13:   movzwq  176(%rbx), %r13
>>>>       1b:   xorl    %r14d, %r14d
>>>>       1e:   orl     $2, %r14d
>>>>       22:   movl    $1, %eax
>>>>       27:   cmpq    $2, %r14
>>>>       2b:   jne     2
>>>>       2d:   xorl    %eax, %eax
>>>>       2f:   popq    %r14
>>>
>>> If I'm reading the asm correctly the difference is significant.
>>> jne 0x2f was an absolute address and jmps were easy
>>> to follow.
>>> While in llvm disasm it's 'jne 2' ?! What is 2 ?
>>> 2 bytes from the next insn of 0x2d ?
>>
>> Yes, that's it. Apparently, this is how the operand is encoded, and
>> libbfd does the translation to the absolute address:
>>
>>     # bpftool prog dump jited id 7868 opcodes
>>     [...]
>>       2b:   jne    0x000000000000002f
>>             75 02
>>     [...]
>>
>> The same difference is observable between objdump and llvm-objdump on an
>> x86-64 binary for example, although they usually have labels to refer to
>> ("jne     -22 <_obstack_memory_used+0x7d0>"), making the navigation
>> easier. The only mention I could find of that difference is a report
>> from 2013 [0].
>>
>> [0] https://discourse.llvm.org/t/llvm-objdump-disassembling-jmp/29584/2
>>
>>> That is super hard to read.
>>> Is there a way to tune/configure llvm disasm?
>>
>> There's a function and some options to tune it, but I tried them and
>> none applies to converting the jump operands.
>>
>>     int LLVMSetDisasmOptions(LLVMDisasmContextRef DC, uint64_t Options);
>>
>>     /* The option to produce marked up assembly. */
>>     #define LLVMDisassembler_Option_UseMarkup 1
>>     /* The option to print immediates as hex. */
>>     #define LLVMDisassembler_Option_PrintImmHex 2
>>     /* The option use the other assembler printer variant */
>>     #define LLVMDisassembler_Option_AsmPrinterVariant 4
>>     /* The option to set comment on instructions */
>>     #define LLVMDisassembler_Option_SetInstrComments 8
>>     /* The option to print latency information alongside instructions */
>>     #define LLVMDisassembler_Option_PrintLatency 16
>>
>> I found that LLVMDisassembler_Option_AsmPrinterVariant read better,
>> although in my patch I kept the default output which looked closer to
>> the existing from libbfd. Here's what the option produces:
>>
>>     bpf_prog_6deef7357e7b4530:
>>        0:   nop     dword ptr [rax + rax]
>>        5:   nop
>>        7:   push    rbp
>>        8:   mov     rbp, rsp
>>        b:   push    rbx
>>        c:   push    r13
>>        e:   push    r14
>>       10:   mov     rbx, rdi
>>       13:   movzx   r13, word ptr [rbx + 180]
>>       1b:   xor     r14d, r14d
>>       1e:   or      r14d, 2
>>       22:   mov     eax, 1
>>       27:   cmp     r14, 2
>>       2b:   jne     2
>>       2d:   xor     eax, eax
>>       2f:   pop     r14
>>       31:   pop     r13
>>       33:   pop     rbx
>>       34:   leave
>>       35:   re
>>
>> But the jne operand remains a '2'. I'm not aware of any option to change
>> it in LLVM's disassembler :(.
> 
> Hmm. llvm-objdump -d test_maps
> looks fine:
>   41bfcb: e8 6f f7 ff ff                   callq    0x41b73f
> <find_extern_btf_id>
> 
> the must be something llvm disasm is missing when you feed raw bytes
> into it.
> Please keep investigating. In this form I'm afraid it's no go.

OK, I'll keep looking
