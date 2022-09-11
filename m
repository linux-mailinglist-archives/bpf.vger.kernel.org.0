Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C315B5114
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 22:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiIKUNo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 16:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIKUNn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 16:13:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC57217E3D
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:13:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e16so12292925wrx.7
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 13:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date;
        bh=jwuPrXwuOJzO9z20Da13LyOc4jGlxGhGmxs+RrbQ+hw=;
        b=hv6hHtnxEQK6s62flnholBq93o+Beq6WSXT3Dn6q1M4rZSk7jDXwoDwMgNXN8ffQr8
         bGhzyWJWkPOO85O+iyTdubpmlb0ptgo3ZplbAi6J8bMue7S5AiHNal/ib8r4gySYt2V2
         kzbVZJih4GfJ4vamzB9i9E10anUVYycWAsmZFD7AfDoI3l/3nTrc422Rbbu7S+BUf5uD
         Pejbvv5232Q98S4M7aaTuPjXtwhxiUZLdWRa+b0/gTBb+gDGdXY5Rhrc8nzCHeC3nHNd
         nS2MiLkgVyEYRr7otZrsnnCnmWPUAzSG2ppWscepogfC5lWeQMZPCAN0fnYinc8cE9qU
         JThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jwuPrXwuOJzO9z20Da13LyOc4jGlxGhGmxs+RrbQ+hw=;
        b=q4Yyend1GuuV5ixcERjn+GwXbNUspGNNi3/GXYoNaMXT4bVOerCSFh61d7K4rKTNPk
         ToSuzYwCXSNN0ttW34hXDRbUeRhwAXRyRyhMvzYaIrdpGmOdT70ke7ylmzcn4MeEFA9s
         /lgQCd84NdnRf0JZz5VScNk91M6R1OLol2OEZqKxrg9gHOrFB3ACwOnmLCbSrgi7plYx
         2jg2uZwufq9hbfDf+ulz8ng1QU6KbangTtQ3GG9hTK3AVs8eyHjcsbhoWJpiVWZhjvtZ
         TZjqpWeTuLgy+Ev3f2X7hJ+hc48HrE558D5RfxiJvoBGM3LELIdLaG/L3UiyrQlG8QUP
         WCqA==
X-Gm-Message-State: ACgBeo1V3nMjf1KkbaTdO/G79iqhrmujOoaGeCa9+QFho0VEjX6O0jst
        0fgHJlL9/w6j7gfE1j3aY10oJA==
X-Google-Smtp-Source: AA6agR48QaZSVE6yZhRtvhe5118YowlTghtP0ByRzWrBZhqHm7WG220517/RiTVTgzUQ/1P/AES3Nw==
X-Received: by 2002:a5d:584e:0:b0:22a:7a88:a400 with SMTP id i14-20020a5d584e000000b0022a7a88a400mr1767580wrf.266.1662927217345;
        Sun, 11 Sep 2022 13:13:37 -0700 (PDT)
Received: from [172.16.10.192] ([185.122.133.20])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b003a5c7a942edsm7751073wmq.28.2022.09.11.13.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 13:13:35 -0700 (PDT)
Message-ID: <02cdc01d-bac0-20cc-945d-7a6a46028cdc@isovalent.com>
Date:   Sun, 11 Sep 2022 21:13:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From:   Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH bpf-next 6/7] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
To:     Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
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
 <ca16b420-a4ae-9f9c-1f60-2e2b8df6b4a0@isovalent.com>
 <ca1d357f-7901-8b01-65c2-a832f49deb81@fb.com>
Content-Language: en-GB
In-Reply-To: <ca1d357f-7901-8b01-65c2-a832f49deb81@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/09/2022 19:02, Yonghong Song wrote:
> 
> 
> On 9/7/22 9:33 AM, Quentin Monnet wrote:
>> On 07/09/2022 17:10, Alexei Starovoitov wrote:
>>> On Wed, Sep 7, 2022 at 7:20 AM Quentin Monnet <quentin@isovalent.com>
>>> wrote:
>>>>
>>>> On 07/09/2022 00:46, Alexei Starovoitov wrote:
>>>>> On Tue, Sep 6, 2022 at 6:36 AM Quentin Monnet
>>>>> <quentin@isovalent.com> wrote:

>>>>>>      # bpftool prog dump jited id 56
>>>>>>      bpf_prog_6deef7357e7b4530:
>>>>>>         0:   nopl    (%rax,%rax)
>>>>>>         5:   nop
>>>>>>         7:   pushq   %rbp
>>>>>>         8:   movq    %rsp, %rbp
>>>>>>         b:   pushq   %rbx
>>>>>>         c:   pushq   %r13
>>>>>>         e:   pushq   %r14
>>>>>>        10:   movq    %rdi, %rbx
>>>>>>        13:   movzwq  176(%rbx), %r13
>>>>>>        1b:   xorl    %r14d, %r14d
>>>>>>        1e:   orl     $2, %r14d
>>>>>>        22:   movl    $1, %eax
>>>>>>        27:   cmpq    $2, %r14
>>>>>>        2b:   jne     2
>>>>>>        2d:   xorl    %eax, %eax
>>>>>>        2f:   popq    %r14
>>>>>
>>>>> If I'm reading the asm correctly the difference is significant.
>>>>> jne 0x2f was an absolute address and jmps were easy
>>>>> to follow.
>>>>> While in llvm disasm it's 'jne 2' ?! What is 2 ?
>>>>> 2 bytes from the next insn of 0x2d ?
>>>>
>>>> Yes, that's it. Apparently, this is how the operand is encoded, and
>>>> libbfd does the translation to the absolute address:
>>>>
>>>>      # bpftool prog dump jited id 7868 opcodes
>>>>      [...]
>>>>        2b:   jne    0x000000000000002f
>>>>              75 02
>>>>      [...]
>>>>
>>>> The same difference is observable between objdump and llvm-objdump
>>>> on an
>>>> x86-64 binary for example, although they usually have labels to
>>>> refer to
>>>> ("jne     -22 <_obstack_memory_used+0x7d0>"), making the navigation
>>>> easier. The only mention I could find of that difference is a report
>>>> from 2013 [0].
>>>>
>>>> [0] https://discourse.llvm.org/t/llvm-objdump-disassembling-jmp/29584/2
>>>>
>>>>> That is super hard to read.
>>>>> Is there a way to tune/configure llvm disasm?
>>>>
>>>> There's a function and some options to tune it, but I tried them and
>>>> none applies to converting the jump operands.
>>>>
>>>>      int LLVMSetDisasmOptions(LLVMDisasmContextRef DC, uint64_t
>>>> Options);
>>>>
>>>>      /* The option to produce marked up assembly. */
>>>>      #define LLVMDisassembler_Option_UseMarkup 1
>>>>      /* The option to print immediates as hex. */
>>>>      #define LLVMDisassembler_Option_PrintImmHex 2
>>>>      /* The option use the other assembler printer variant */
>>>>      #define LLVMDisassembler_Option_AsmPrinterVariant 4
>>>>      /* The option to set comment on instructions */
>>>>      #define LLVMDisassembler_Option_SetInstrComments 8
>>>>      /* The option to print latency information alongside
>>>> instructions */
>>>>      #define LLVMDisassembler_Option_PrintLatency 16
>>>>
>>>> I found that LLVMDisassembler_Option_AsmPrinterVariant read better,
>>>> although in my patch I kept the default output which looked closer to
>>>> the existing from libbfd. Here's what the option produces:
>>>>
>>>>      bpf_prog_6deef7357e7b4530:
>>>>         0:   nop     dword ptr [rax + rax]
>>>>         5:   nop
>>>>         7:   push    rbp
>>>>         8:   mov     rbp, rsp
>>>>         b:   push    rbx
>>>>         c:   push    r13
>>>>         e:   push    r14
>>>>        10:   mov     rbx, rdi
>>>>        13:   movzx   r13, word ptr [rbx + 180]
>>>>        1b:   xor     r14d, r14d
>>>>        1e:   or      r14d, 2
>>>>        22:   mov     eax, 1
>>>>        27:   cmp     r14, 2
>>>>        2b:   jne     2
>>>>        2d:   xor     eax, eax
>>>>        2f:   pop     r14
>>>>        31:   pop     r13
>>>>        33:   pop     rbx
>>>>        34:   leave
>>>>        35:   re
>>>>
>>>> But the jne operand remains a '2'. I'm not aware of any option to
>>>> change
>>>> it in LLVM's disassembler :(.
>>>
>>> Hmm. llvm-objdump -d test_maps
>>> looks fine:
>>>    41bfcb: e8 6f f7 ff ff                   callq    0x41b73f
>>> <find_extern_btf_id>
>>>
>>> the must be something llvm disasm is missing when you feed raw bytes
>>> into it.
>>> Please keep investigating. In this form I'm afraid it's no go.
>>
>> OK, I'll keep looking
> 
> Quentin, if eventually there is no existing solution for this problem,
> we could improve llvm API to encode branch target in more
> easy-to-understand form.
> 

TL;DR: I figured it out, with no LLVM fix required. I'll send a v2.

---
The details:
In my previous example, I ran on Ubuntu 20.04 with llvm-objdump v10.
Looking at just the v11 with the same command, I get the relative
addresses like in Alexei's output:

    $ llvm-objdump-10 -d /usr/bin/grep | grep -m1 jne
        4f20: 0f 85 e7 0b 00 00             jne     3047 <.text+0xddd>

    $ llvm-objdump-11 -d /usr/bin/grep | grep -m1 jne
        4f20: 0f 85 e7 0b 00 00             jne     0x5b0d <.text+0xddd>

    $ printf '%#x\n' $((0x4f20 + 3047 + 6))
    0x5b0d

The change was introduced between the two versions by the following commits:

    5fad05e80dd0 ("[MCInstPrinter] Pass `Address` parameter to
        MCOI::OPERAND_PCREL typed operands. NFC")
    https://reviews.llvm.org/D76574

    87de9a0786d9 ("[X86InstPrinter] Change printPCRelImm to print the
        target address in hexadecimal form")
    https://reviews.llvm.org/D76580

The first one in particular introduces a PrintBranchImmAsAddress
variable in the MCInstPrinter, and makes llvm-obdump call
"setPrintBranchImmAsAddress(true);".

Now, this function is not exposed to the C interface, llvm-c, that
bpftool would use. Instead, it's available through the more
comprehensive C++ interface that llvm-objdump relies on. I've tried to
replicate these two commits in the MCDisassembler that llvm-c interfaces
with, and succeeded.

But while looking at unit tests to extend it with the relevant checks, I
realised that the existing test would already expect an address instead
of an operand [0]. Turns out that the symbolLookupCallback() callback
defined in the test and passed when creating the disassembler ends up
changing the display so we get the operands as addresses, as we want.

[0]
https://github.com/llvm/llvm-project/blob/llvmorg-15.0.0/llvm/unittests/MC/Disassembler.cpp#L64
---

I validated that this works in bpftool too, and will send v2 with that
change.

P.S. Thank you Niklas for testing!
