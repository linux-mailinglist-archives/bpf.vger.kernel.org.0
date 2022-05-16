Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E795529549
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 01:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347864AbiEPX0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 19:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350380AbiEPX0V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 19:26:21 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D13434B84
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:26:20 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id b11so7647887ilr.4
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 16:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bN6v+QHbgqNtGWpXjoP83AoC7F/6S9DmuIN0DhuHnZQ=;
        b=kIIN7Uv+9CGWW2CWoNZKY+UqIXk+RPIEZbrwtz7bKC/sem8jlW9fnPwOi8WD69OoHQ
         iktuaEmr69vZyNDrbVjxvtl5LLtIz5GnDigPsi5nzsdfd/Lnc8yT21OKa+iYBmo6MiP8
         JsA/XWgSvMwLNGkuvU48LUb98Zm+l7ik+KE/HfOyDmFjMjP6iweUW+0okVEATIaz9tQb
         /YtKuLImS0MwglZTrGo5IA2XmCKGQf8Xc4VlXxN3u9BHEFpRsooV2o6ileCiXGwAvMG2
         AQ0crLbl3Zbsh93Xpn8Bh+jNkYWEyx6OTD6/UQ7lF60ceTzyz63DgEuAltY35cyQ3cMv
         5MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bN6v+QHbgqNtGWpXjoP83AoC7F/6S9DmuIN0DhuHnZQ=;
        b=fgE4UqPZJfXESxGxkRva1+FM9V0j6pVdMz9hkTY+PRePj/2SKq+1aIsorrKd4fe1Ks
         hhzlejxYVhxq2H7zevabowVjTeVtjKRodh2BnLMbJKLLyye4ajl3n1ce6lki0VrMhXX/
         VN7SuqPRusqOaFJRwN7JsKAGXTY2Kd9QOMm6Q+atAUP3rsq9pMuam4djxErdBTnJz2Ge
         iarugiSU9T5HNC5DPMSdOLnwpktLCoWQzhHUkfWaOAsIwC09Cxuw9GwNEXGPxzOAi8+i
         6PfH5/kKVmtPDag0gaNFPsCnAarviXWxRdmT/AS70u3vLaZMXFGRJJQRac2Hfxqoucwq
         /rCA==
X-Gm-Message-State: AOAM531aUocktYaIAL5mXtEsPaRhLr1sFOejDP/KHrtLl7oLYJwHkm8/
        RFL3h1tVzy2GKenHj6H4nR7YSEysYZs+qpmeZxo=
X-Google-Smtp-Source: ABdhPJwScGij+Y7bbRq/hA09dIfOaMfI176gOhX3u/7ISZT7Hex/PvfAEia4rX5r3mX13JakH4h5vDIQURIScfMAGhs=
X-Received: by 2002:a92:cd4c:0:b0:2d1:2ee7:5cef with SMTP id
 v12-20020a92cd4c000000b002d12ee75cefmr1898824ilq.252.1652743579728; Mon, 16
 May 2022 16:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220512074321.2090073-1-davemarchevsky@fb.com> <20220512074321.2090073-4-davemarchevsky@fb.com>
In-Reply-To: <20220512074321.2090073-4-davemarchevsky@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 16 May 2022 16:26:08 -0700
Message-ID: <CAEf4BzaM0SC3D66NC3djt1fsEQcJ-af0-EgPx5UV8YLDLu8ibg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 3/5] libbpf: usdt lib wiring of xmm reads
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Rik van Riel <riel@surriel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Yonghong Song <yhs@fb.com>, Kernel Team <kernel-team@fb.com>
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

On Thu, May 12, 2022 at 12:43 AM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> Handle xmm0,...,xmm15 registers when parsing USDT arguments. Currently
> only the first 64 bits of the fetched value are returned as I haven't
> seen the rest of the register used in practice.
>
> This patch also handles floats in USDT arg spec by ignoring the fact
> that they're floats and considering them scalar. Currently we can't do
> float math in BPF programs anyways, so might as well support passing to
> userspace and converting there.
>
> We can use existing ARG_REG sscanf + logic, adding XMM-specific logic
> when calc_pt_regs_off fails. If the reg is xmm, arg_spec's reg_off is
> repurposed to hold reg_no, which is passed to bpf_get_reg_val. Since the
> helper does the digging around in fxregs_state it's not necessary to
> calculate offset in bpf code for these regs.
>
> NOTE: Changes here cause verification failure for existing USDT tests.
> Specifically, BPF_USDT prog 'usdt12' fails to verify due to too many
> insns despite not having its insn count significantly changed.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  tools/lib/bpf/usdt.bpf.h | 36 ++++++++++++++++++++--------
>  tools/lib/bpf/usdt.c     | 51 ++++++++++++++++++++++++++++++++++++----
>  2 files changed, 73 insertions(+), 14 deletions(-)
>
> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> index 4181fddb3687..7b5ed4cbaa2f 100644
> --- a/tools/lib/bpf/usdt.bpf.h
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -43,6 +43,7 @@ enum __bpf_usdt_arg_type {
>         BPF_USDT_ARG_CONST,
>         BPF_USDT_ARG_REG,
>         BPF_USDT_ARG_REG_DEREF,
> +       BPF_USDT_ARG_XMM_REG,
>  };
>
>  struct __bpf_usdt_arg_spec {
> @@ -129,7 +130,9 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>  {
>         struct __bpf_usdt_spec *spec;
>         struct __bpf_usdt_arg_spec *arg_spec;
> -       unsigned long val;
> +       struct pt_regs *btf_regs;
> +       struct task_struct *btf_task;
> +       struct { __u64 a; __u64 unused; } val = {};
>         int err, spec_id;
>
>         *res = 0;
> @@ -151,7 +154,7 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>                 /* Arg is just a constant ("-4@$-9" in USDT arg spec).
>                  * value is recorded in arg_spec->val_off directly.
>                  */
> -               val = arg_spec->val_off;
> +               val.a = arg_spec->val_off;
>                 break;
>         case BPF_USDT_ARG_REG:
>                 /* Arg is in a register (e.g, "8@%rax" in USDT arg spec),
> @@ -159,7 +162,20 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>                  * struct pt_regs. To keep things simple user-space parts
>                  * record offsetof(struct pt_regs, <regname>) in arg_spec->reg_off.
>                  */
> -               err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +               err = bpf_probe_read_kernel(&val.a, sizeof(val.a), (void *)ctx + arg_spec->reg_off);
> +               if (err)
> +                       return err;
> +               break;
> +       case BPF_USDT_ARG_XMM_REG:

nit: a bit too XMM-specific name here, we probably want to keep it a bit

> +               /* Same as above, but arg is an xmm reg, so can't look
> +                * in pt_regs, need to use special helper.
> +                * reg_off is the regno ("xmm0" -> regno 0, etc)
> +                */
> +               btf_task = bpf_get_current_task_btf();
> +               btf_regs = (struct pt_regs *)bpf_task_pt_regs(btf_task);

I'd like to avoid taking dependency on bpf_get_current_task_btf() for
rare case of XMM register, which makes it impossible to do USDT on
older kernels. It seems like supporting reading registers from current
(and maybe current pt_regs context) should cover a lot of practical
uses.

> +               err = bpf_get_reg_val(&val, sizeof(val),

But regardless of the above, we'll need to use CO-RE to detect support
for this new BPF helper (probably using bpf_core_enum_value_exists()?)
to allow using USDTs on older kernels.


> +                                    ((u64)arg_spec->reg_off + BPF_GETREG_X86_XMM0) << 32,
> +                                    btf_regs, btf_task);
>                 if (err)
>                         return err;
>                 break;
> @@ -171,14 +187,14 @@ int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
>                  * from pt_regs, then do another user-space probe read to
>                  * fetch argument value itself.
>                  */
> -               err = bpf_probe_read_kernel(&val, sizeof(val), (void *)ctx + arg_spec->reg_off);
> +               err = bpf_probe_read_kernel(&val.a, sizeof(val.a), (void *)ctx + arg_spec->reg_off);
>                 if (err)
>                         return err;
> -               err = bpf_probe_read_user(&val, sizeof(val), (void *)val + arg_spec->val_off);
> +               err = bpf_probe_read_user(&val.a, sizeof(val.a), (void *)val.a + arg_spec->val_off);

is the useful value in xmm register normally in lower 64-bits of it?
is it possible to just request reading just the first 64 bits from
bpf_get_reg_val() and avoid this ugly union?

>                 if (err)
>                         return err;
>  #if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
> -               val >>= arg_spec->arg_bitshift;
> +               val.a >>= arg_spec->arg_bitshift;
>  #endif
>                 break;
>         default:

[...]

> +static int calc_xmm_regno(const char *reg_name)
> +{
> +       static struct {
> +               const char *name;
> +               __u16 regno;
> +       } xmm_reg_map[] = {
> +               { "xmm0",  0 },
> +               { "xmm1",  1 },
> +               { "xmm2",  2 },
> +               { "xmm3",  3 },
> +               { "xmm4",  4 },
> +               { "xmm5",  5 },
> +               { "xmm6",  6 },
> +               { "xmm7",  7 },
> +#ifdef __x86_64__
> +               { "xmm8",  8 },
> +               { "xmm9",  9 },
> +               { "xmm10",  10 },
> +               { "xmm11",  11 },
> +               { "xmm12",  12 },
> +               { "xmm13",  13 },
> +               { "xmm14",  14 },
> +               { "xmm15",  15 },

no-x86 arches parse this generically with sscanf(), seems like we can
do this simple approach here as well?


> +#endif
> +       };
> +       int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(xmm_reg_map); i++) {
> +               if (strcmp(reg_name, xmm_reg_map[i].name) == 0)
> +                       return xmm_reg_map[i].regno;
> +       }
> +
>         return -ENOENT;
>  }
>

[...]
