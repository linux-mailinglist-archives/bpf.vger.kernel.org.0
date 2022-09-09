Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666075B3A8F
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 16:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiIIOUH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 10:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiIIOUH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 10:20:07 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B3A476E7;
        Fri,  9 Sep 2022 07:20:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q21so2734427edc.9;
        Fri, 09 Sep 2022 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=il7Ilq03Jy3qK9trP89NQpYDkyj+wCqI9a3iT+1TUqY=;
        b=CYqElaWEXELaTF0ufxRzWiLbFPW1sx7er6sdeedSg0OT1QzYw90hDvOilly9mpWBKW
         zZwb4PN2GpiSsd1vGWcIKFXE8BbOgjLlXuqqLwspWkxafjpkQMWIjYqEJjvIZh7KJ1Nq
         c9AX+m67+KsZYoHJyfiLAh9iGp53sPqNxhIwc5sFv/TeKglFwBvBFquNMDUnwgKOranM
         9dMCJVMR4sr3kRsrtjUj6xaj65KHH5E9baE8mH4Q3muoxyi6oBEPz9AP3jLMbk/qkc9r
         m1KRfTv658tTc7Phr1A2CByAAFqcPc2/k67gI9RviGrkB6WI3bJstTbUg0IMvl+cQrvo
         ghZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=il7Ilq03Jy3qK9trP89NQpYDkyj+wCqI9a3iT+1TUqY=;
        b=CMxfiswvBcDU7fcwwIVFt/cZw9GBtbmYCDmEWPt9Gzy7ye0quqzIt+pc5ViNfvNfAs
         ybPSlOb0J8NUstDj2qI6iF+tgF+4E1tMLHyGSkcyuCRNxDgngjvKSomaOQlHFG2Ed/2m
         Hgw0OloqWhv/d2miY7LU+pIt7QSSLRFFQ2M+t6OGemp9OGU3jh/QfQj7W/CozhSmSJ1o
         FlzJ8L4RAbhqGFXPA2At8XVMs/p69dl+gIYZIKcwbK3KADOrx1KcaMERK5AN/TyXf38B
         8op8B21Bjnj+6AarLgCi5y8+vbECx14desnZoGgxJo+c36+fGR+rUQlPGeiFCwWjQKPF
         NIZw==
X-Gm-Message-State: ACgBeo1dFHDqyi35HVftSiIvF1uo8NB9L0QuCrMSBPwm0ujTp5d5o/p3
        0D2LHAjgtgn6bp+wZo8O59bON/ccyn/WgohqYzo=
X-Google-Smtp-Source: AA6agR5BmgQ4MZaa5djaaXJJtjRYycr9UQxM+gsSsbSBeg4Ttg4dQf/avu7U/6yHtqooywiUj42VL9eT8NWe4ua/Ccw=
X-Received: by 2002:a05:6402:1d48:b0:44e:c6cf:778 with SMTP id
 dz8-20020a0564021d4800b0044ec6cf0778mr11986236edb.421.1662733202729; Fri, 09
 Sep 2022 07:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <166260087224.759381.4170102827490658262.stgit@devnote2>
 <166260088298.759381.11727280480035568118.stgit@devnote2> <20220908050855.w77mimzznrlp6pwe@treble>
 <Yxm2QU1NJIkIyrrU@hirez.programming.kicks-ass.net> <Yxm+QkFPOhrVSH6q@hirez.programming.kicks-ass.net>
 <CAADnVQKWTaXFqYri9VG3ux-CJEBsjAP5PetH6Q1ccS8HoeP28g@mail.gmail.com> <Yxr2TaWaN8VjJ60D@hirez.programming.kicks-ass.net>
In-Reply-To: <Yxr2TaWaN8VjJ60D@hirez.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 9 Sep 2022 07:19:51 -0700
Message-ID: <CAADnVQLqw5o5Pn9Bds03Qse6Y5vSDPj1jyfWesxJOP__kUPXLg@mail.gmail.com>
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

On Fri, Sep 9, 2022 at 1:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Sep 08, 2022 at 07:01:12AM -0700, Alexei Starovoitov wrote:
>
> > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > index c1f6c1c51d99..37f821dee68f 100644
> > > --- a/arch/x86/net/bpf_jit_comp.c
> > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > @@ -419,7 +419,8 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
> > >                 OPTIMIZER_HIDE_VAR(reg);
> > >                 emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
> > >         } else {
> > > -               EMIT2(0xFF, 0xE0 + reg);
> > > +               EMIT2(0xFF, 0xE0 + reg);        /* jmp *%\reg */
> > > +               EMIT1(0xCC);                    /* int3 */
> >
> > Hmm. Why is this unconditional?
> > Shouldn't it be guarded with CONFIG_xx or cpu_feature_enabled ?
> > People that don't care about hw speculation vulnerabilities
> > shouldn't pay the price of increased code size.
>
> Sure, like so then?
>
> ---
> Subject: x86,retpoline: Be sure to emit INT3 after JMP *%\reg
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu, 8 Sep 2022 12:04:50 +0200
>
> Both AMD and Intel recommend using INT3 after an indirect JMP. Make sure
> to emit one when rewriting the retpoline JMP irrespective of compiler
> SLS options or even CONFIG_SLS.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>
>  arch/x86/kernel/alternative.c |    9 +++++++++
>  arch/x86/net/bpf_jit_comp.c   |    4 +++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -453,6 +453,15 @@ static int patch_retpoline(void *addr, s
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
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -419,7 +419,9 @@ static void emit_indirect_jump(u8 **ppro
>                 OPTIMIZER_HIDE_VAR(reg);
>                 emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
>         } else {
> -               EMIT2(0xFF, 0xE0 + reg);
> +               EMIT2(0xFF, 0xE0 + reg);        /* jmp *%\reg */
> +               if (IS_ENABLED(CONFIG_RETPOLINE) || IS_ENABLED(CONFIG_SLS))
> +                       EMIT1(0xCC);            /* int3 */

Looks better. Ack.
