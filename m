Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5172A5B1FFE
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 16:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiIHOB7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 10:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbiIHOBl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 10:01:41 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE14C7B8E;
        Thu,  8 Sep 2022 07:01:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id e17so16919817edc.5;
        Thu, 08 Sep 2022 07:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PIgZOnWLxGhDY2AlzhWEJFwfiUjj9jrE4apzm43swg0=;
        b=i+weFMy2Xb7yh6NeXB9eFWcQEQ0DFDGzxR0kdM/z6DR/hhID0oezbtsUTFGFY5sb+/
         Y3WujY2+e1IBI8Ql+ZUzCrqLIJ5EhckkHqPaP2blNsibW/1BB+o1cgFNjIi4TcrmvyFx
         ww7s7v4Re24PyHYKZ8ygYACBeZwkggxIqvrIVMTR0jnG/z1dXYHHauCioylvU2D1T9Fv
         sW+VmE93lLbRf/QE3GN+363muLAOwdLPdLR1PEZIwUe+tlNEjZGa5Vk2HrbSXicw+B0O
         7ndzVAA72asvPL9UwqiXQ3GORJn0aeLWfFpo8SI6HAuqKUT1vqbeWfFxnMiE8neVMa8/
         OiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PIgZOnWLxGhDY2AlzhWEJFwfiUjj9jrE4apzm43swg0=;
        b=eMgeuNuXWNwf7mwpj/ZGukXsjGBw8UFjhNLNY2StqKz9cURvfYOJ+cRfL6zigSzrFP
         I9UWXZlZbC2y0bhRHAOdxMDx1J49PasTsRn9Xw41VMbyTduwwjAhh0mQYuTBL5/Ys44S
         7KdRBSzJHrHRfxa7JCW/IlPHy6Euqqw61cL+LgKFfwNBrq3XXUNuSc8bJLIDQdYwrdRF
         urFEUSqcoUxq60HAETMK48Bl/VS3Oc5WCur6bxooIOfPzWWMh8x4TeCdpmjh/djTv4Sx
         WUuSRsHLh87cLWRUpR5VZNVHjeSy4jWLfqobxKs27Vn8zRT+9/ZW7doLj/HCM9L9mzAt
         W2gw==
X-Gm-Message-State: ACgBeo0U/NsAVU/5yXmq0eTIpnoOiRRdYTtPMqBJgp/kEz1wT+1T/UXv
        xpLM0qEVbM/9qfDmmQHbSWcY0JqoDscwipq9Njv/2zkfzOA=
X-Google-Smtp-Source: AA6agR6uZ/xEU5akWWuzv8LR9vlPZw31oEl7JhOh9rc4AJzhQnkhbATyoJ8zzJ6dLedO3pnL14Bewr5DhQCs4lpD6HY=
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id
 et15-20020a056402378f00b0043ad3f579f2mr7409777edb.338.1662645684183; Thu, 08
 Sep 2022 07:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
 <166260088298.759381.11727280480035568118.stgit@devnote2> <20220908050855.w77mimzznrlp6pwe@treble>
 <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net> <Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net>
In-Reply-To: <Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Sep 2022 07:01:12 -0700
Message-ID: <CAADnVQKWTaXFqYri9VG3ux-CJEBsjAP5PetH6Q1ccS8HoeP28g@mail.gmail.com>
Subject: Re: [PATCH] x86,retpoline: Be sure to emit INT3 after JMP *%\reg
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>, X86 ML <x86@kernel.org>
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

On Thu, Sep 8, 2022 at 3:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 08, 2022 at 11:30:41AM +0200, Peter Zijlstra wrote:
> > Let me go do a patch.
>
> ---
> Subject: x86,retpoline: Be sure to emit INT3 after JMP *%\reg
>
> Both AMD and Intel recommend using INT3 after an indirect JMP. Make sure
> to emit one when rewriting the retpoline JMP irrespective of compiler
> SLS options or even CONFIG_SLS.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/alternative.c | 9 +++++++++
>  arch/x86/net/bpf_jit_comp.c   | 3 ++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 62f6b8b7c4a5..68d84cf8e001 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -453,6 +453,15 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
>                 return ret;
>         i += ret;
>
> +       /*
> +        * The compiler is supposed to EMIT an INT3 after every unconditional
> +        * JMP instruction due to AMD BTC. However, if the compiler is too old
> +        * or SLS isn't enabled, we still need an INT3 after indirect JMPs
> +        * even on Intel.
> +        */
> +       if (op == JMP32_INSN_OPCODE && i < insn->length)
> +               bytes[i++] = INT3_INSN_OPCODE;
> +
>         for (; i < insn->length;)
>                 bytes[i++] = BYTES_NOP1;
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index c1f6c1c51d99..37f821dee68f 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -419,7 +419,8 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
>                 OPTIMIZER_HIDE_VAR(reg);
>                 emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
>         } else {
> -               EMIT2(0xFF, 0xE0 + reg);
> +               EMIT2(0xFF, 0xE0 + reg);        /* jmp *%\reg */
> +               EMIT1(0xCC);                    /* int3 */

Hmm. Why is this unconditional?
Shouldn't it be guarded with CONFIG_xx or cpu_feature_enabled ?
People that don't care about hw speculation vulnerabilities
shouldn't pay the price of increased code size.
