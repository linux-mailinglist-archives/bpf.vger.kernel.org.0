Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B71B5F5FEF
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 06:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiJFELU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 00:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJFELT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 00:11:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10BB5A2CE
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 21:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D733B81A76
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 04:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A08C433D6
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 04:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665029475;
        bh=RMIwIydU7raBUw+RLOrya2+imb3iweGMLPgUPYywS3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NUfJ+QHGdzNbm17NzBBbKGFFXWaZYvsWLDjrEUobNuMAEHlIjf5+zKopnvCtjo3/q
         3W/P/ROMtfaVVo1nHArQAO+BOHjPf6tHhluGelgK9QdaZCBQKqKqL4mTATKl5BjEvI
         dYCvgrCLvy9Hw85wQSKCLHWUwULCJGVW/iSqAdgnfIKKxbbYhiKW5fhsTkbdImHWXh
         CGBwlytMPbOpxS1pWEeoNbOCfI1/YSznpvK83QrvQJkkhAPfvfeVc6cwaHPHcgZCCG
         380YHoAoNN/9ejSzLrMOyYThGpGySbuWrZ+88QsAjIDvu6M1g1rUGdtbozAUS7jPjA
         hVKkBN74Hm3aw==
Received: by mail-lf1-f53.google.com with SMTP id bu25so936969lfb.3
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 21:11:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf3r4RPcmLcpdnH0RKo+plXcHNj+K4hCECbUrnaZ/3Z/sZgeqcgA
        1+YK5yByAM4VTWie67OMlUd/r6U3wX2AfGz/6t99LA==
X-Google-Smtp-Source: AMsMyM6jlvEdqv6V9ZDjK9eYJ8Vf0UShxa/3/fB1WwDRyiwMp9FmtooyN1yDLNcAm3Gcps4ldHtolaCCSUrOSHIEw0o=
X-Received: by 2002:a05:6512:1596:b0:4a2:5de8:410a with SMTP id
 bp22-20020a056512159600b004a25de8410amr985727lfb.627.1665029473198; Wed, 05
 Oct 2022 21:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220927185801.1824838-1-jmeng@fb.com> <20221002051143.831029-1-jmeng@fb.com>
 <20221002051143.831029-3-jmeng@fb.com>
In-Reply-To: <20221002051143.831029-3-jmeng@fb.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 5 Oct 2022 21:11:01 -0700
X-Gmail-Original-Message-ID: <CACYkzJ4RvEZVp5-sybdn2tOuV-h6KyGJRjvEMZWBoqTBVrK1aQ@mail.gmail.com>
Message-ID: <CACYkzJ4RvEZVp5-sybdn2tOuV-h6KyGJRjvEMZWBoqTBVrK1aQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] bpf,x64: use shrx/sarx/shlx when available
To:     Jie Meng <jmeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 1, 2022 at 10:12 PM Jie Meng <jmeng@fb.com> wrote:
>
> Instead of shr/sar/shl that implicitly use %cl, emit their more flexible
> alternatives provided in BMI2 when advantageous; keep using the non BMI2
> instructions when shift count is already in BPF_REG_4/rcx as non BMI2
> instructions are shorter.

This is confusing, you mention %CL in the first sentence and then RCX in the
second sentence. Can you clarify this more here?

Also, It would be good to have some explanations about the
performance benefits here as well.

i.e. a load + store + non vector instruction v/s a single vector instruction
omitting the load. How many cycles do we expect in each case, I do expect the
latter to be lesser, but mentioning it in the commit removes any ambiguity.

>
> To summarize, when BMI2 is available:
> -------------------------------------------------
>             |   arbitrary dst
> =================================================
> src == ecx  |   shl dst, cl
> -------------------------------------------------
> src != ecx  |   shlx dst, dst, src
> -------------------------------------------------
>
> A concrete example between non BMI2 and BMI2 codegen.  To shift %rsi by
> %rdi:
>
> Without BMI2:
>
>  ef3:   push   %rcx
>         51
>  ef4:   mov    %rdi,%rcx
>         48 89 f9
>  ef7:   shl    %cl,%rsi
>         48 d3 e6
>  efa:   pop    %rcx
>         59
>
> With BMI2:
>
>  f0b:   shlx   %rdi,%rsi,%rsi
>         c4 e2 c1 f7 f6
>
> Signed-off-by: Jie Meng <jmeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 64 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d9ba997c5891..d09c54f3d2e0 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -889,6 +889,48 @@ static void emit_nops(u8 **pprog, int len)
>         *pprog = prog;
>  }
>
> +/* emit the 3-byte VEX prefix */
> +static void emit_3vex(u8 **pprog, bool r, bool x, bool b, u8 m,
> +                     bool w, u8 src_reg2, bool l, u8 p)

Can you please use somewhat more descriptive variable names here?

or add more information about what x, b, m, w, l and p mean?

> +{
> +       u8 *prog = *pprog;
> +       u8 b0 = 0xc4, b1, b2;
> +       u8 src2 = reg2hex[src_reg2];
> +
> +       if (is_ereg(src_reg2))
> +               src2 |= 1 << 3;
> +
> +       /*
> +        *    7                           0
> +        *  +---+---+---+---+---+---+---+---+
> +        *  |~R |~X |~B |         m         |
> +        *  +---+---+---+---+---+---+---+---+
> +        */
> +       b1 = (!r << 7) | (!x << 6) | (!b << 5) | (m & 0x1f);

Some explanation here would help, not everyone is aware of x86 vex encoding :)

> +       /*
> +        *    7                           0
> +        *  +---+---+---+---+---+---+---+---+
> +        *  | W |     ~vvvv     | L |   pp  |
> +        *  +---+---+---+---+---+---+---+---+
> +        */
> +       b2 = (w << 7) | ((~src2 & 0xf) << 3) | (l << 2) | (p & 3);
> +
> +       EMIT3(b0, b1, b2);
> +       *pprog = prog;
> +}
> +
> +/* emit BMI2 shift instruction */
> +static void emit_shiftx(u8 **pprog, u32 dst_reg, u8 src_reg, bool is64, u8 op)
> +{
> +       u8 *prog = *pprog;
> +       bool r = is_ereg(dst_reg);
> +       u8 m = 2; /* escape code 0f38 */
> +
> +       emit_3vex(&prog, r, false, r, m, is64, src_reg, false, op);
> +       EMIT2(0xf7, add_2reg(0xC0, dst_reg, dst_reg));
> +       *pprog = prog;
> +}
> +
>  #define INSN_SZ_DIFF (((addrs[i] - addrs[i - 1]) - (prog - temp)))
>
>  static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image,
> @@ -1135,6 +1177,28 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image, u8 *rw_image
>                 case BPF_ALU64 | BPF_LSH | BPF_X:
>                 case BPF_ALU64 | BPF_RSH | BPF_X:
>                 case BPF_ALU64 | BPF_ARSH | BPF_X:
> +                       /* BMI2 shifts aren't better when shift count is already in rcx */
> +                       if (boot_cpu_has(X86_FEATURE_BMI2) && src_reg != BPF_REG_4) {
> +                               /* shrx/sarx/shlx dst_reg, dst_reg, src_reg */
> +                               bool w = (BPF_CLASS(insn->code) == BPF_ALU64);
> +                               u8 op;
> +
> +                               switch (BPF_OP(insn->code)) {
> +                               case BPF_LSH:
> +                                       op = 1; /* prefix 0x66 */
> +                                       break;
> +                               case BPF_RSH:
> +                                       op = 3; /* prefix 0xf2 */
> +                                       break;
> +                               case BPF_ARSH:
> +                                       op = 2; /* prefix 0xf3 */
> +                                       break;
> +                               }
> +
> +                               emit_shiftx(&prog, dst_reg, src_reg, w, op);
> +
> +                               break;
> +                       }
>
>                         if (src_reg != BPF_REG_4) { /* common case */
>                                 /* Check for bad case when dst_reg == rcx */
> --
> 2.30.2
>
