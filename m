Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11CE5B09C4
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 18:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiIGQKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Sep 2022 12:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiIGQKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Sep 2022 12:10:36 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEFA79629
        for <bpf@vger.kernel.org>; Wed,  7 Sep 2022 09:10:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 29so15377313edv.2
        for <bpf@vger.kernel.org>; Wed, 07 Sep 2022 09:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WCxhH5q/nhzQI6hOC0sgDFYxX/x3T1hlHYD9rhRLbhU=;
        b=os/Ytb/kS2FZXnGfh9xzElleEsJ5K9uXAtbWPWoO67YUkX9oLlsOwFCiYropAzupG6
         qqOyK37mMLoOSNT0mNyL8me9ItS7+QsxQXGltuCphNvEn9QlnkNOEBEsQjewV7fe1pnO
         pZnNfR8Z+WPJeXQNtb8FN/8DgdzUjf5bMbfjUflQD1/6qulpV86f7yMYNFysppkQjrJa
         1p9f9kktQM7CnXYqk0YHPeCit/FXUw6zmCPxiXPHboRj+iUG70uikx0DLeEu/P9LJbPC
         kN82eTkdZFDnluIKY5qvKvH0FReizjQhKEM7xLHei0JdNu+VbvjRo7gZlpF9KDv+vzD5
         Edmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WCxhH5q/nhzQI6hOC0sgDFYxX/x3T1hlHYD9rhRLbhU=;
        b=ugPlkm42CcECAFlSWFmabaZ8cQQKXEs8uSTBVt/tW5FpGwpN3STxDPcEriJU9nHEij
         6EO+XwFj/Dw1Bs7Xzq1OcvkRJ0y3Sh2pvRLXofEhAhAufk3dXsijBh+En2GVqXGy22Rg
         kpHLxIVgOt1F7eFHs86On2fE8JmmD/AxI6H9cJLue0gzeEoprYiijIeZtgwYOxgUPGlB
         aouz8qv/CpKM3KRNzz0Yhu24/8m2fSR0rsrGEzPIA4AFYOhYRhUCWGaDxlVkQOMv52cx
         qEaqiRYG+8QzS08qP4DbL6beJa3kZ/nfw6gDydtbEFFTyqelh/xi6HiDfkpK7ZUHBAaw
         me8w==
X-Gm-Message-State: ACgBeo0y//P8OXzuifx+WTZkaI12VwHQa0m3Ygki/+9hS2XfyRflVAtN
        BruWOvZbH3u8N8AVoVswQ6TZuL4rnpNombGlhP0=
X-Google-Smtp-Source: AA6agR4WYs1AtiM+w27YCoRToryCHgcqr0ZskxWxhUDZZKYW9fkPAdljTkIo++7GuUmDb7CY53OW4WSYGfNdBip7Kkc=
X-Received: by 2002:a05:6402:1d48:b0:44e:c6cf:778 with SMTP id
 dz8-20020a0564021d4800b0044ec6cf0778mr3793078edb.421.1662567033120; Wed, 07
 Sep 2022 09:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220906133613.54928-1-quentin@isovalent.com> <20220906133613.54928-7-quentin@isovalent.com>
 <CAADnVQJ3K7cLTz9tiEEevyhuYVCO6BfB5NhAssReyYU7MNAyKw@mail.gmail.com> <f0d9d219-3e5b-94bc-3c90-897da8d27b12@isovalent.com>
In-Reply-To: <f0d9d219-3e5b-94bc-3c90-897da8d27b12@isovalent.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 7 Sep 2022 09:10:21 -0700
Message-ID: <CAADnVQKJCwMbvkY5ZNX7KLiB9YT35TK_S_cFH61csm1P2phDDw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
To:     Quentin Monnet <quentin@isovalent.com>
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
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 7, 2022 at 7:20 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On 07/09/2022 00:46, Alexei Starovoitov wrote:
> > On Tue, Sep 6, 2022 at 6:36 AM Quentin Monnet <quentin@isovalent.com> wrote:
> >>
> >> Naturally, the display of disassembled instructions comes with a few
> >> minor differences. Here is a sample output with libbfd (already
> >> supported before this patch):
> >>
> >>     # bpftool prog dump jited id 56
> >>     bpf_prog_6deef7357e7b4530:
> >>        0:   nopl   0x0(%rax,%rax,1)
> >>        5:   xchg   %ax,%ax
> >>        7:   push   %rbp
> >>        8:   mov    %rsp,%rbp
> >>        b:   push   %rbx
> >>        c:   push   %r13
> >>        e:   push   %r14
> >>       10:   mov    %rdi,%rbx
> >>       13:   movzwq 0xb0(%rbx),%r13
> >>       1b:   xor    %r14d,%r14d
> >>       1e:   or     $0x2,%r14d
> >>       22:   mov    $0x1,%eax
> >>       27:   cmp    $0x2,%r14
> >>       2b:   jne    0x000000000000002f
> >>       2d:   xor    %eax,%eax
> >>       2f:   pop    %r14
> >>       31:   pop    %r13
> >>       33:   pop    %rbx
> >>       34:   leave
> >>       35:   ret
> >>       36:   int3
> >>
> >> LLVM supports several variants that we could set when initialising the
> >> disassembler, for example with:
> >>
> >>     LLVMSetDisasmOptions(*ctx,
> >>                          LLVMDisassembler_Option_AsmPrinterVariant);
> >>
> >> but the default printer is kept for now. Here is the output with LLVM:
> >>
> >>     # bpftool prog dump jited id 56
> >>     bpf_prog_6deef7357e7b4530:
> >>        0:   nopl    (%rax,%rax)
> >>        5:   nop
> >>        7:   pushq   %rbp
> >>        8:   movq    %rsp, %rbp
> >>        b:   pushq   %rbx
> >>        c:   pushq   %r13
> >>        e:   pushq   %r14
> >>       10:   movq    %rdi, %rbx
> >>       13:   movzwq  176(%rbx), %r13
> >>       1b:   xorl    %r14d, %r14d
> >>       1e:   orl     $2, %r14d
> >>       22:   movl    $1, %eax
> >>       27:   cmpq    $2, %r14
> >>       2b:   jne     2
> >>       2d:   xorl    %eax, %eax
> >>       2f:   popq    %r14
> >
> > If I'm reading the asm correctly the difference is significant.
> > jne 0x2f was an absolute address and jmps were easy
> > to follow.
> > While in llvm disasm it's 'jne 2' ?! What is 2 ?
> > 2 bytes from the next insn of 0x2d ?
>
> Yes, that's it. Apparently, this is how the operand is encoded, and
> libbfd does the translation to the absolute address:
>
>     # bpftool prog dump jited id 7868 opcodes
>     [...]
>       2b:   jne    0x000000000000002f
>             75 02
>     [...]
>
> The same difference is observable between objdump and llvm-objdump on an
> x86-64 binary for example, although they usually have labels to refer to
> ("jne     -22 <_obstack_memory_used+0x7d0>"), making the navigation
> easier. The only mention I could find of that difference is a report
> from 2013 [0].
>
> [0] https://discourse.llvm.org/t/llvm-objdump-disassembling-jmp/29584/2
>
> > That is super hard to read.
> > Is there a way to tune/configure llvm disasm?
>
> There's a function and some options to tune it, but I tried them and
> none applies to converting the jump operands.
>
>     int LLVMSetDisasmOptions(LLVMDisasmContextRef DC, uint64_t Options);
>
>     /* The option to produce marked up assembly. */
>     #define LLVMDisassembler_Option_UseMarkup 1
>     /* The option to print immediates as hex. */
>     #define LLVMDisassembler_Option_PrintImmHex 2
>     /* The option use the other assembler printer variant */
>     #define LLVMDisassembler_Option_AsmPrinterVariant 4
>     /* The option to set comment on instructions */
>     #define LLVMDisassembler_Option_SetInstrComments 8
>     /* The option to print latency information alongside instructions */
>     #define LLVMDisassembler_Option_PrintLatency 16
>
> I found that LLVMDisassembler_Option_AsmPrinterVariant read better,
> although in my patch I kept the default output which looked closer to
> the existing from libbfd. Here's what the option produces:
>
>     bpf_prog_6deef7357e7b4530:
>        0:   nop     dword ptr [rax + rax]
>        5:   nop
>        7:   push    rbp
>        8:   mov     rbp, rsp
>        b:   push    rbx
>        c:   push    r13
>        e:   push    r14
>       10:   mov     rbx, rdi
>       13:   movzx   r13, word ptr [rbx + 180]
>       1b:   xor     r14d, r14d
>       1e:   or      r14d, 2
>       22:   mov     eax, 1
>       27:   cmp     r14, 2
>       2b:   jne     2
>       2d:   xor     eax, eax
>       2f:   pop     r14
>       31:   pop     r13
>       33:   pop     rbx
>       34:   leave
>       35:   re
>
> But the jne operand remains a '2'. I'm not aware of any option to change
> it in LLVM's disassembler :(.

Hmm. llvm-objdump -d test_maps
looks fine:
  41bfcb: e8 6f f7 ff ff                   callq    0x41b73f
<find_extern_btf_id>

the must be something llvm disasm is missing when you feed raw bytes
into it.
Please keep investigating. In this form I'm afraid it's no go.
