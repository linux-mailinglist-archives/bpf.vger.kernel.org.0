Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDB64F4D8A
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 03:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379839AbiDEXpd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Apr 2022 19:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457938AbiDERAj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 13:00:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1DEBC0B;
        Tue,  5 Apr 2022 09:58:40 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x16so7269171pfa.10;
        Tue, 05 Apr 2022 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZAVOxKCn1rSRBeHkGZiJCt2gkjQ/XAx8tCfYXVtiNfE=;
        b=BCmXM1EPbsht9Le2RBBahOAvfdS8skESRKaGokKX4zH1mid2b3gkPH+7yeaMUotIkX
         NbGdGgZUpeiJ3gcEyuIX9YmL6aKRHI0Ro2BaiZ6XjqRP2m7CKlHSuUHTMLX2NSIG2dm5
         HsJwWqgby3b4336TPjsBa5UN9sDUtcgVUND+DX6y7CTnOXnjiuvnfz0xyouIucQQx+EI
         nXE6toJv/NMiDw3WCfZ71mrl7R7Bvu+SZDhsJUQUr2Zwo+xGSeq99721WuG2hKNGZbNe
         wmZS8BuxXvE1kG9ToDalW5HUMb0OuCMOkXO0tPwEiirJb0Sipb6N3gnGMjvO1qWAdbK8
         GaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZAVOxKCn1rSRBeHkGZiJCt2gkjQ/XAx8tCfYXVtiNfE=;
        b=TX6DxWo/6bmRXGnKmJ/u8tK9QHEfnhjVJO5PNn5VogMbLjcTyDntaKwu8/caN7Qnw7
         fUNkb9SWRwiACWr+99Ranss199s8VtRfTYwxJNCuEbb/M/wMd85KL15Tz/x408goKWKM
         6FRiasGcT+UIVAGsFhFSghTH/i9TEmbcDsfDuBUP2tPRz+Nd1J7oIAs67pIwlvzVKfR/
         8UaoRe8ahSoKnOFWRe4aXj/7BeSLhra53pnEP82jbJMCHjnOoFuc7uCkmYYU6nQOXBWN
         QMItESM4oaAfKMsHwoHIyHvDAKJW94zQqTT+R8fzeNxqWF240BG7710y7NF8Y2F2F0YG
         yUHQ==
X-Gm-Message-State: AOAM530fJhgg7s6Zl5HjUu7cKXtMISkAMDqJ0FaZZ/AdZ9LaoUfbc79T
        0p4zBQ+lcxFrk+SMJ77Lb1dopikzFK9HWB4TskK52FJ2
X-Google-Smtp-Source: ABdhPJyU0FDyxgvY/9mKwmMNiabrAzWrvWBv7HU1olSNnJVsJwHglQaOPHoTBWnW8V0XuaupQcIHHAgWxERG2jXlLBk=
X-Received: by 2002:a05:6a00:1c9e:b0:4fa:d946:378b with SMTP id
 y30-20020a056a001c9e00b004fad946378bmr4548697pfw.46.1649177919721; Tue, 05
 Apr 2022 09:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220405075531.GB30877@worktop.programming.kicks-ass.net>
In-Reply-To: <20220405075531.GB30877@worktop.programming.kicks-ass.net>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 5 Apr 2022 09:58:28 -0700
Message-ID: <CAADnVQJ1_9sBqRngG_J+84whx9j7d7qOSzMaJvhc0evDBQfE3w@mail.gmail.com>
Subject: Re: [PATCH] x86,bpf: Avoid IBT objtool warning
To:     Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

On Tue, Apr 5, 2022 at 12:55 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Clang can inline emit_indirect_jump() and then folds constants, which
> results in:
>
>   | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x6a4: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
>   | vmlinux.o: warning: objtool: emit_bpf_dispatcher()+0x67d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x40
>   | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x386: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20
>   | vmlinux.o: warning: objtool: emit_bpf_tail_call_indirect()+0x35d: relocation to !ENDBR: .text.__x86.indirect_thunk+0x20
>
> Suppress the optimization such that it must emit a code reference to
> the __x86_indirect_thunk_array[] base.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/net/bpf_jit_comp.c |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -412,6 +412,7 @@ static void emit_indirect_jump(u8 **ppro
>                 EMIT_LFENCE();
>                 EMIT2(0xFF, 0xE0 + reg);
>         } else if (cpu_feature_enabled(X86_FEATURE_RETPOLINE)) {
> +               OPTIMIZER_HIDE_VAR(reg);
>                 emit_jump(&prog, &__x86_indirect_thunk_array[reg], ip);
>         } else
>  #endif

Looks good. Please cc bpf@vger and all bpf maintainers in the future.
We can take it through the bpf tree if you prefer.
