Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425F45AF87C
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 01:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIFXqv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 19:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIFXqu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 19:46:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1326E91084
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 16:46:49 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id u6so17183895eda.12
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 16:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=g91flEhela5Feh0HtZSgV5lG9OXw3Fd6Y0Vn/BYNkVY=;
        b=VK3cRaDM7edjepj/j4ML6EQdufKGxLY9iblpriI80Wq56vwYp2dXCWNA7Lf3nEJ2BH
         1qCAxRN0rj564ImFa7kE+1lyEDU4UVMPIejpfMegKbYKZqb4t4TlDP82ATMq/t1Nj+2Q
         54GLuNYcMJwucxZDr/vNzlcxN15kN6Kqkj1SeHxYZcVzLxpJjsIh2jvz+0FWyhXDRSGd
         u6KtxbIp8a+c1xgMB5tXC00ZzwVVlNOZrJiGVUvVYQQlJWzLMFR4GOBXrDtr2b+g1Fhn
         OHfKiSolQogmWVa5ClQUqwhxfg8/cbIEPzCmyFXZ0levL7GFLbO7Svd33SU3VZhzgtmE
         0+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=g91flEhela5Feh0HtZSgV5lG9OXw3Fd6Y0Vn/BYNkVY=;
        b=Tx2WeovxC+Mm3FWgPm/6EhrFCuM8NiIg3sqS8VXMsRqrCsfjS/XA3fAWSQAdSsVFTi
         TbRoE8nzWqjV8Iaab5b/44/xOJ5JMqBod81BXYw2H2vIdR7Bx494tq19AW5RSsg463V4
         J/SdKLLN4CBBqHAznG4yazhkgwzvrOHmUKJ31Lj8fnk3IOhq9CXHWLC7dE8LI6B3ru3Z
         36E96eZhCZDFYGmXsA7cyB9ogPHhtP11LH/HuTwOQnZp6mqnPBHMyrjpIpArT3noWoas
         grTxKGMU+5t5FYILHp15i/HbJmoAWF0muQdxk75on+oZc6Bq/jB4F+KVKf4GzS9X3p1O
         2KaA==
X-Gm-Message-State: ACgBeo1CisustgMSps/SCg93hFWGXNvpCjC2ETVlr42tSttalehA74Jj
        4roGbYMb1dg0ziOAM7rEtaNp0G0xljgmD8eycPg=
X-Google-Smtp-Source: AA6agR58dnopoTuSc86MuiuogXw4GzMUAF4VoXlLn1Y1vyX+RDvfXHnseZZuLlXOnMt0IvDegwYO/UvJtv3/DMr82D4=
X-Received: by 2002:a05:6402:28cd:b0:448:3856:41a3 with SMTP id
 ef13-20020a05640228cd00b00448385641a3mr821087edb.6.1662508007459; Tue, 06 Sep
 2022 16:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220906133613.54928-1-quentin@isovalent.com> <20220906133613.54928-7-quentin@isovalent.com>
In-Reply-To: <20220906133613.54928-7-quentin@isovalent.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Sep 2022 16:46:35 -0700
Message-ID: <CAADnVQJ3K7cLTz9tiEEevyhuYVCO6BfB5NhAssReyYU7MNAyKw@mail.gmail.com>
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

On Tue, Sep 6, 2022 at 6:36 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> Naturally, the display of disassembled instructions comes with a few
> minor differences. Here is a sample output with libbfd (already
> supported before this patch):
>
>     # bpftool prog dump jited id 56
>     bpf_prog_6deef7357e7b4530:
>        0:   nopl   0x0(%rax,%rax,1)
>        5:   xchg   %ax,%ax
>        7:   push   %rbp
>        8:   mov    %rsp,%rbp
>        b:   push   %rbx
>        c:   push   %r13
>        e:   push   %r14
>       10:   mov    %rdi,%rbx
>       13:   movzwq 0xb0(%rbx),%r13
>       1b:   xor    %r14d,%r14d
>       1e:   or     $0x2,%r14d
>       22:   mov    $0x1,%eax
>       27:   cmp    $0x2,%r14
>       2b:   jne    0x000000000000002f
>       2d:   xor    %eax,%eax
>       2f:   pop    %r14
>       31:   pop    %r13
>       33:   pop    %rbx
>       34:   leave
>       35:   ret
>       36:   int3
>
> LLVM supports several variants that we could set when initialising the
> disassembler, for example with:
>
>     LLVMSetDisasmOptions(*ctx,
>                          LLVMDisassembler_Option_AsmPrinterVariant);
>
> but the default printer is kept for now. Here is the output with LLVM:
>
>     # bpftool prog dump jited id 56
>     bpf_prog_6deef7357e7b4530:
>        0:   nopl    (%rax,%rax)
>        5:   nop
>        7:   pushq   %rbp
>        8:   movq    %rsp, %rbp
>        b:   pushq   %rbx
>        c:   pushq   %r13
>        e:   pushq   %r14
>       10:   movq    %rdi, %rbx
>       13:   movzwq  176(%rbx), %r13
>       1b:   xorl    %r14d, %r14d
>       1e:   orl     $2, %r14d
>       22:   movl    $1, %eax
>       27:   cmpq    $2, %r14
>       2b:   jne     2
>       2d:   xorl    %eax, %eax
>       2f:   popq    %r14

If I'm reading the asm correctly the difference is significant.
jne 0x2f was an absolute address and jmps were easy
to follow.
While in llvm disasm it's 'jne 2' ?! What is 2 ?
2 bytes from the next insn of 0x2d ?
That is super hard to read.
Is there a way to tune/configure llvm disasm?
