Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284475AFA58
	for <lists+bpf@lfdr.de>; Wed,  7 Sep 2022 05:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiIGDB1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 23:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiIGDBI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 23:01:08 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1805C95B
        for <bpf@vger.kernel.org>; Tue,  6 Sep 2022 20:01:06 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kg20so609476ejc.12
        for <bpf@vger.kernel.org>; Tue, 06 Sep 2022 20:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DAc7mWW3JmhdcvKjCnH0Ud6JzXICTDW5/l0txxxgxlI=;
        b=UZGiiC8aWbdP+yXKUbc1Ii/kB0aJdlXicyQSSpiS68k6UrSB6fz8Z0OMZQ0oNuhKKp
         3uCtL5jUI56eTjff0/neF8UNvEQWWQlUjS9+J462dSTMByb/9lMhoBMHDiHPcvUsT8OA
         46ugqzqdostrT4Xf6v3r6lYe3xfFPbZ+iyLFNYIwFK2HWfHy1PNEcbG2yqgWJGGYLS6d
         sdfaBKVi55TRuweR1UAqzgS1IQeetftHZkIU++LFlZh8AeoGB8f7Od0yqnf8ZGrkvjd8
         HNXbtDwegoBCws2MZvXIJpKl0GqGB72PiHZjZ2g+fkXm+bdu/r5WSS80Y0kzAlwB4KPy
         DREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DAc7mWW3JmhdcvKjCnH0Ud6JzXICTDW5/l0txxxgxlI=;
        b=s33geOIwzfIlJHzXdNAiuPu856fyZfLsC2+tvbdVOAqLtWlPlTl8SC//YGQ/hJCBZK
         727MU+u4w3rIPT5m5/u3BvX6jGs09FWnlvHToTBdvfB+tD95cZbKMgOE2lYy6/OcZBnF
         AkFr93qp4/6Rf7WjjcmDPbsMSIRxDQyoAc0VDGNluoBo2yAlPC1910tbL7oZwYbGAgQp
         Od6xlWNoXDOTkfCYcA9hP0N7HyVvo0KtH/HjetoV5Mc4Y9x4EjT4+mTigsw1Ezi53I9g
         4sviCoSOqdQf2RvsBSmeIFb20L+CyHkdumMfh4caMCLnqtHxm6ZVnz4ci7kchPb4VUsV
         QSag==
X-Gm-Message-State: ACgBeo0LOjGUs13czzfLDVogdJip2WvgmdKsknrkf+kH7p0vPJ7pxar2
        6mQq2OXoDfTI1Mya/Z2n3C5jgDZW13PNd+cvJJv9nbHP
X-Google-Smtp-Source: AA6agR7w4CRQ3NLt1p2SaxNcPBUqEXLup93Tk5My7XuwZcQOdX9ElL/068PT+hUJhCnGHbjJaE0yqN8OQe/yicjssQU=
X-Received: by 2002:a17:906:dc93:b0:742:133b:42c3 with SMTP id
 cs19-20020a170906dc9300b00742133b42c3mr941009ejc.502.1662519664907; Tue, 06
 Sep 2022 20:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220831152641.2077476-1-yhs@fb.com> <20220831152652.2078600-1-yhs@fb.com>
In-Reply-To: <20220831152652.2078600-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Sep 2022 20:00:53 -0700
Message-ID: <CAADnVQKb4Js-57c69Ryfdf3Tu3=Ray_Ovqjm7_2ZHw1LX3qgxg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/8] bpf: x86: Support in-register struct
 arguments in trampoline programs
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Aug 31, 2022 at 8:26 AM Yonghong Song <yhs@fb.com> wrote:
>
> In C, struct value can be passed as a function argument.
> For small structs, struct value may be passed in
> one or more registers. For trampoline based bpf programs,
> this would cause complication since one-to-one mapping between
> function argument and arch argument register is not valid
> any more.
>
> The latest llvm16 added bpf support to pass by values
> for struct up to 16 bytes ([1]). This is also true for
> x86_64 architecture where two registers will hold
> the struct value if the struct size is >8 and <= 16.
> This may not be true if one of struct member is 'double'
> type but in current linux source code we don't have
> such instance yet, so we assume all >8 && <= 16 struct
> holds two general purpose argument registers.
>
> Also change on-stack nr_args value to the number
> of registers holding the arguments. This will
> permit bpf_get_func_arg() helper to get all
> argument values.
>
>  [1] https://reviews.llvm.org/D132144
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 68 +++++++++++++++++++++++++++----------
>  1 file changed, 51 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index c1f6c1c51d99..ae89f4143eb4 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1751,34 +1751,60 @@ st:                     if (is_imm8(insn->off))
>  static void save_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
>                       int stack_size)
>  {
> -       int i;
> +       int i, j, arg_size, nr_regs;
>         /* Store function arguments to stack.
>          * For a function that accepts two pointers the sequence will be:
>          * mov QWORD PTR [rbp-0x10],rdi
>          * mov QWORD PTR [rbp-0x8],rsi
>          */
> -       for (i = 0; i < min(nr_args, 6); i++)
> -               emit_stx(prog, bytes_to_bpf_size(m->arg_size[i]),
> -                        BPF_REG_FP,
> -                        i == 5 ? X86_REG_R9 : BPF_REG_1 + i,
> -                        -(stack_size - i * 8));
> +       for (i = 0, j = 0; i < min(nr_args, 6); i++) {
> +               if (m->arg_flags[i] & BTF_FMODEL_STRUCT_ARG) {
> +                       nr_regs = (m->arg_size[i] + 7) / 8;
> +                       arg_size = 8;
> +               } else {
> +                       nr_regs = 1;
> +                       arg_size = m->arg_size[i];
> +               }

This bit begs for a common helper, but I'm not sure
whether it will look better, so applied as-is.

BPF_PROG2 also feels unusual as an API macro name.
We probably should bikeshed a bit and follow up
if a better name is found.
