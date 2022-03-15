Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBFD4DA267
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 19:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbiCOS1f (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351046AbiCOS1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 14:27:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B25A0A1;
        Tue, 15 Mar 2022 11:26:22 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso3034430pjb.1;
        Tue, 15 Mar 2022 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7eH2Jb47dfLg/8oCD4UksRNTJiYDyRm80Tfb3V3Q38=;
        b=F/SdGCo9FsvcNH1PQHYY2UBgAURRooIyCXG9jvd/tChZf/kX3S1nXSHQrgnL6mnZ6x
         n3b6HH3bOlUhBnrClzTR0PgteoniS4GBH95oLHjAqXEQ+TUbPLaTS0LJZ5vJ8ftJq0B/
         esZ2Y9BX6VI73n5LrEf6zXj5WrrbXumI/ZU/W8t7791wjVnG8qBqPlKbTIsj+kka8Gao
         5+EtvqoKrNnBuP4xjLEp/nW3Dcnv0C60vKxQYp2AwDpqfLvNnk+WEiOWbtbvCsS0AMdn
         mDx1novA7mpN59TtCysoAnasiOS9+zIAtHdz2kX0JaeT7fVc6N9OOaMiGyrJmdZxj1D/
         QvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7eH2Jb47dfLg/8oCD4UksRNTJiYDyRm80Tfb3V3Q38=;
        b=nnpLeULXYkyD4SGkNXebZNfyGXLx4LUjurofBx9GKuhFtMF5+Fehh95u1XqTmIQFuH
         klCg1jPMotb/GGzj102muJh9ZjfXRjghSERzuKew14ykVRZpwkzgET+UMYVXRtf4tYHv
         I6+NVoDd+1lGwMqGhyb7GAgkotvmFXrO7Omox4pWGfATSgbaMLjGXFWwLWkJSJOHBKG+
         6V6N/SrF57kSa+TZr5di7YcSr/iYPKD46diysPvGpg4TXBqAuyJemENdDvNMZgZVdzlx
         wAEn5uTVNUP9dyIdk5CZ0kfFvgmrlzOCpsb2XDZ5srKBwDpFxpRzgv3tVcwsNdgZRgmU
         8yrA==
X-Gm-Message-State: AOAM532lmcAjtTfyn7AXv/BRPle2E8hypoLNlRWXflvFOFh/YwerwPW7
        VF7LlMdsrZR8AcmsYi8nQ6uzZM2tlDv0y9Cy67o=
X-Google-Smtp-Source: ABdhPJzj/IPHcPc1JKJe6GcpufOS24sfagqE6GXJsF/TEAgFn5iFSIgY2nwHXu9p6YxnwrhCpbou0gF9UzVV+uE1sog=
X-Received: by 2002:a17:902:70c6:b0:153:2444:6dcd with SMTP id
 l6-20020a17090270c600b0015324446dcdmr26131355plt.55.1647368781471; Tue, 15
 Mar 2022 11:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <YifZhUVoHLT/76fE@hirez.programming.kicks-ass.net>
 <Yif8nO2xg6QnVQfD@hirez.programming.kicks-ass.net> <20220309190917.w3tq72alughslanq@ast-mbp.dhcp.thefacebook.com>
 <YinGZObp37b27LjK@hirez.programming.kicks-ass.net> <YioBZmicMj7aAlLf@hirez.programming.kicks-ass.net>
 <YionV0+v/cUBiOh0@hirez.programming.kicks-ass.net> <YisnG9lW6kp8lBp3@hirez.programming.kicks-ass.net>
 <CAADnVQJfffD9tH_cWThktCCwXeoRV1XLZq69rKK5vKy_y6BN8A@mail.gmail.com>
 <20220312154407.GF28057@worktop.programming.kicks-ass.net>
 <CAADnVQL7xrafAviUJg47LfvFSJpgZLwyP18Bm3S_KQwRyOpheQ@mail.gmail.com> <20220314204402.rpd5hqzzev4ugtdt@apollo>
In-Reply-To: <20220314204402.rpd5hqzzev4ugtdt@apollo>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Mar 2022 11:26:10 -0700
Message-ID: <CAADnVQ+TMPpwEc_S7ayijzem-SOCQzuAeJAX=3mQXqgTPBW22A@mail.gmail.com>
Subject: Re: [PATCH v4 00/45] x86: Kernel IBT
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>, alyssa.milburn@intel.com,
        Miroslav Benes <mbenes@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
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

On Mon, Mar 14, 2022 at 1:44 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> The crash does not seem to be resurfacing the bug, AFAICT.
>
> [ Note: I have no experience with trampoline code or IBT so what follows might
>         be incorrect. ]
>
> In case of fexit and fmod_ret, we call original function (but skip
> X86_PATCH_SIZE bytes), with ENDBR we must also skip those 4 bytes, but in some
> cases like bpf_fentry_test1, for which this test has fmod_ret prog, compiler
> (gcc 11) emits endbr64, but not for do_init_module, for which we do fexit.
>
> This means for do_init_module module, orig_call += X86_PATCH_SIZE +
> ENDBR_INSN_SIZE would skip more bytes than needed to emit call to original
> function, which explains why I was seeing crash in the middle of
> 'mov edx, 0x10' instruction.
>
> The diff below fixes the problem for me, and allows the test to pass.
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index b98e1c95bcc4..760c9a3c075f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -2031,11 +2031,14 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
>
>         ip_off = stack_size;
>
> -       if (flags & BPF_TRAMP_F_SKIP_FRAME)
> +       if (flags & BPF_TRAMP_F_SKIP_FRAME) {
>                 /* skip patched call instruction and point orig_call to actual
>                  * body of the kernel function.
>                  */
> -               orig_call += X86_PATCH_SIZE + ENDBR_INSN_SIZE;
> +               if (is_endbr(*(u32 *)orig_call))
> +                       orig_call += ENDBR_INSN_SIZE;
> +               orig_call += X86_PATCH_SIZE;
> +       }
>

Thanks Kumar!
The bpf trampoline can attach to both indirect and non-indirect
functions. My understanding is that only indirect targets will have
endbr first insn. So the fix totally makes sense.
