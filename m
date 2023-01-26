Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5471567C18E
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 01:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjAZA1a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Jan 2023 19:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjAZA1Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Jan 2023 19:27:24 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730C251C74
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 16:26:46 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id vw16so1043285ejc.12
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u98h8cfsFfxGnm4Y44QGAhHGSL7pFEISymHSFJvP4Kw=;
        b=WpUVT92cHADta6o27FgyQS1/XV/0w+Jil2duq6CPbU4JF+gQxyPiwNE+Ug4zgpxN8o
         qpo5Q4rfMPBQv++S8+lguf/pVf4qIiNtbRUoHlkw3//4ss60NR/fWHvc2suwKJeSnVGn
         OCaThowXXC/WRn7SGXPwWpBRJM7Wwr9v71XbUwhx7ZdDK9mna4EoahkA7/XnohbAs+KJ
         hC3Vu7D17giYT1ZR0sfanWw/siHHUUoExSBzqw27fiMe6TQx0Nev+MC+8ZJ+hua7dQix
         +9+W5rsZMnhkpPIbM1rjAU6PGJ4WN4JIssEwse5sriHDWTq9hCeLIuElMZe2LgYtvXN1
         78jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u98h8cfsFfxGnm4Y44QGAhHGSL7pFEISymHSFJvP4Kw=;
        b=GFIogH5kYXlQABfdQ6MAZonT0kKKgnrKynGs0FbXsU66duBGzxmVHKIOSArxXF7uto
         zYELSgvpwrlVxvlPVeel4GQQdY3GvvPMaNKE0jfdlpObmgmSyX462qcX8IVHcQF9XHlM
         FAKU6upHOyJFplZr9vneVvUHA2texObRNdzFBfRQR/BnqEIAC9sGaoLxXOVxgWHoUgs/
         aCUhgyWfv1/ijbqUu19s1H4AvUN/A3kJ6DDxnIP2qDHDhUqxzAVlouM8hifsfSsw1Omq
         dHUJMmOgp8Pb5C6IdlbUMCRR/7dmnSSq2E5O0imZzDq8tQSWoMvoz34qjncufzOXwrCn
         1ahA==
X-Gm-Message-State: AO0yUKW9L8WdjYiKoGdrzmfSMdClkWCrW68hUgFOwuGrhBP/3HOj5nLf
        d1OqeRy4ERrQbOcGFnr1H0HBENoTNcLguW7/r74=
X-Google-Smtp-Source: AK7set/uAdqYP0BIuWi1HYF0yoOJtBPURDhH4BKEFJGsnvsKxPz2W7EWOJxyufRjtduEpjalmeKRudQZTShVrnfkjHE=
X-Received: by 2002:a17:906:f1cd:b0:878:4854:fc97 with SMTP id
 gx13-20020a170906f1cd00b008784854fc97mr462575ejb.296.1674692803056; Wed, 25
 Jan 2023 16:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20230125213817.1424447-1-iii@linux.ibm.com> <20230125213817.1424447-18-iii@linux.ibm.com>
In-Reply-To: <20230125213817.1424447-18-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 25 Jan 2023 16:26:31 -0800
Message-ID: <CAEf4BzamdUMpNeryWa2gGP6KB8uTs5sZTNnU3kMkvJFdchNRiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 17/24] libbpf: Read usdt arg spec with bpf_probe_read_kernel()
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Loading programs that use bpf_usdt_arg() on s390x fails with:
>
>     ; switch (arg_spec->arg_type) {
>     139: (61) r1 = *(u32 *)(r2 +8)
>     R2 unbounded memory access, make sure to bounds check any such access

can you show a bit longer log? we shouldn't just  use
bpf_probe_read_kernel for this. I suspect strategically placed
barrier_var() calls will solve this. This is usually an issue with
compiler reordering operations and doing actual check after it already
speculatively adjusted pointer (which is technically safe and ok if we
never deref that pointer, but verifier doesn't recognize such pattern)

>
> The bound checks seem to be already in place in the C code, and maybe
> it's even possible to add extra bogus checks to placate LLVM or the
> verifier. Take a simpler approach and just use a helper.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  tools/lib/bpf/usdt.bpf.h | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index fdfd235e52c4..ddfa2521ab67 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -116,7 +116,7 @@ __weak __hidden
>  int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>  {
>         struct __bpf_usdt_spec *spec;
> -       struct __bpf_usdt_arg_spec *arg_spec;
> +       struct __bpf_usdt_arg_spec arg_spec;
>         unsigned long val;
>         int err, spec_id;
>
> @@ -133,21 +133,24 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>         if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec->arg_cnt)
>                 return -ENOENT;
>
> -       arg_spec = &spec->args[arg_num];
> -       switch (arg_spec->arg_type) {
> +       err = bpf_probe_read_kernel(&arg_spec, sizeof(arg_spec), &spec->args[arg_num]);
> +       if (err)
> +               return err;
> +
> +       switch (arg_spec.arg_type) {
>         case BPF_USDT_ARG_CONST:
>                 /* Arg is just a constant ("-4@$-9" in USDT arg spec).
> -                * value is recorded in arg_spec->val_off directly.
> +                * value is recorded in arg_spec.val_off directly.
>                  */
> -               val = arg_spec->val_off;
> +               val = arg_spec.val_off;
>                 break;
>         case BPF_USDT_ARG_REG:
>                 /* Arg is in a register (e.g, "8@%rax" in USDT arg spec),
>                  * so we read the contents of that register directly from
>                  * struct pt_regs. To keep things simple user-space parts
> -                * record offsetof(struct pt_regs, <regname>) in arg_spec->reg_off.
> +                * record offsetof(struct pt_regs, <regname>) in arg_spec.reg_off.
>                  */
> -               err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +               err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec.reg_off);
>                 if (err)
>                         return err;
>                 break;
> @@ -155,18 +158,18 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>                 /* Arg is in memory addressed by register, plus some offset
>                  * (e.g., "-4@-1204(%rbp)" in USDT arg spec). Register is
>                  * identified like with BPF_USDT_ARG_REG case, and the offset
> -                * is in arg_spec->val_off. We first fetch register contents
> +                * is in arg_spec.val_off. We first fetch register contents
>                  * from pt_regs, then do another user-space probe read to
>                  * fetch argument value itself.
>                  */
> -               err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +               err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec.reg_off);
>                 if (err)
>                         return err;
> -               err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
> +               err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec.val_off);
>                 if (err)
>                         return err;
>  #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> -               val >>= arg_spec->arg_bitshift;
> +               val >>= arg_spec.arg_bitshift;
>  #endif
>                 break;
>         default:
> @@ -177,11 +180,11 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>          * necessary upper arg_bitshift bits, with sign extension if argument
>          * is signed
>          */
> -       val <<= arg_spec->arg_bitshift;
> -       if (arg_spec->arg_signed)
> -               val = ((long)val) >> arg_spec->arg_bitshift;
> +       val <<= arg_spec.arg_bitshift;
> +       if (arg_spec.arg_signed)
> +               val = ((long)val) >> arg_spec.arg_bitshift;
>         else
> -               val = val >> arg_spec->arg_bitshift;
> +               val = val >> arg_spec.arg_bitshift;
>         *res = val;
>         return 0;
>  }
> --
> 2.39.1
>
