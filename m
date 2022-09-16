Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0AD5BB3D6
	for <lists+bpf@lfdr.de>; Fri, 16 Sep 2022 23:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiIPVKE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Sep 2022 17:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIPVKE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Sep 2022 17:10:04 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FD930541
        for <bpf@vger.kernel.org>; Fri, 16 Sep 2022 14:10:02 -0700 (PDT)
Received: from sslproxy04.your-server.de ([78.46.152.42])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1oZIax-000EUA-Pu; Fri, 16 Sep 2022 23:09:55 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1oZIax-000OJW-Cy; Fri, 16 Sep 2022 23:09:55 +0200
Subject: Re: [PATCH bpf-next v2 6/8] bpftool: Add LLVM as default library for
 disassembling JIT-ed programs
To:     Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@corigine.com>,
        Simon Horman <simon.horman@corigine.com>
References: <20220911201451.12368-1-quentin@isovalent.com>
 <20220911201451.12368-7-quentin@isovalent.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <00d4de2e-c7ac-7aa5-9d31-868d73af4fe2@iogearbox.net>
Date:   Fri, 16 Sep 2022 23:09:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20220911201451.12368-7-quentin@isovalent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26660/Fri Sep 16 09:57:04 2022)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/11/22 10:14 PM, Quentin Monnet wrote:
> To disassemble instructions for JIT-ed programs, bpftool has relied on
> the libbfd library. This has been problematic in the past: libbfd's
> interface is not meant to be stable and has changed several times. For
> building bpftool, we have to detect how the libbfd version on the system
> behaves, which is why we have to handle features disassembler-four-args
> and disassembler-init-styled in the Makefile. When it comes to shipping
> bpftool, this has also caused issues with several distribution
> maintainers unwilling to support the feature (see for example Debian's
> page for binutils-dev, which ships libbfd: "Note that building Debian
> packages which depend on the shared libbfd is Not Allowed." [0]).
> 
> For these reasons, we add support for LLVM as an alternative to libbfd
> for disassembling instructions of JIT-ed programs. Thanks to the
> preparation work in the previous commits, it's easy to add the library
> by passing the relevant compilation options in the Makefile, and by
> adding the functions for setting up the LLVM disassembler in file
> jit_disasm.c.

Could you add more context around the LLVM lib? The motivation is that libbfd's
interface is not meant to be stable and has changed several times. How does this
look on the LLVM's library side? Also, for the 2nd part, what is Debian's stance
related to the LLVM lib? Would be good if both is explained in the commit message.
Right now it mainly reads 'that libbfd has all these issues, so we're moving to
something else', so would be good to provide more context to the ready why the
'something else' is better than current one.

> Naturally, the display of disassembled instructions comes with a few
> minor differences. Here is a sample output with libbfd (already
> supported before this patch):
> 
>      # bpftool prog dump jited id 56
>      bpf_prog_6deef7357e7b4530:
>         0:   nopl   0x0(%rax,%rax,1)
>         5:   xchg   %ax,%ax
>         7:   push   %rbp
>         8:   mov    %rsp,%rbp
>         b:   push   %rbx
>         c:   push   %r13
>         e:   push   %r14
>        10:   mov    %rdi,%rbx
>        13:   movzwq 0xb4(%rbx),%r13
>        1b:   xor    %r14d,%r14d
>        1e:   or     $0x2,%r14d
>        22:   mov    $0x1,%eax
>        27:   cmp    $0x2,%r14
>        2b:   jne    0x000000000000002f
>        2d:   xor    %eax,%eax
>        2f:   pop    %r14
>        31:   pop    %r13
>        33:   pop    %rbx
>        34:   leave
>        35:   ret
> 
> LLVM supports several variants that we could set when initialising the
> disassembler, for example with:
> 
>      LLVMSetDisasmOptions(*ctx,
>                           LLVMDisassembler_Option_AsmPrinterVariant);
> 
> but the default printer is used for now. Here is the output with LLVM:
> 
>      # bpftool prog dump jited id 56
>      bpf_prog_6deef7357e7b4530:
>         0:   nopl    (%rax,%rax)
>         5:   nop
>         7:   pushq   %rbp
>         8:   movq    %rsp, %rbp
>         b:   pushq   %rbx
>         c:   pushq   %r13
>         e:   pushq   %r14
>        10:   movq    %rdi, %rbx
>        13:   movzwq  180(%rbx), %r13
>        1b:   xorl    %r14d, %r14d
>        1e:   orl     $2, %r14d
>        22:   movl    $1, %eax
>        27:   cmpq    $2, %r14
>        2b:   jne     0x2f
>        2d:   xorl    %eax, %eax
>        2f:   popq    %r14
>        31:   popq    %r13
>        33:   popq    %rbx
>        34:   leave
>        35:   retq
> 
> The LLVM disassembler comes as the default choice, with libbfd as a
> fall-back.
> 
> Of course, we could replace libbfd entirely and avoid supporting two
> different libraries. One reason for keeping libbfd is that, right now,
> it works well, we have all we need in terms of features detection in the
> Makefile, so it provides a fallback for disassembling JIT-ed programs if
> libbfd is installed but LLVM is not. The other motivation is that libbfd
> supports nfp instruction for Netronome's SmartNICs and can be used to
> disassemble offloaded programs, something that LLVM cannot do. If
> libbfd's interface breaks again in the future, we might reconsider
> keeping support for it.
> 
> [0] https://packages.debian.org/buster/binutils-dev
> 
> Signed-off-by: Quentin Monnet <quentin@isovalent.com>
> Tested-by: Niklas Söderlund <niklas.soderlund@corigine.com>

Thanks,
Daniel
