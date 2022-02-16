Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5021B4B8CCE
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 16:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbiBPPqN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 10:46:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiBPPqM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 10:46:12 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900472A795F
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 07:45:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z17so2282098plb.9
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 07:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38bOAEvnk4iPZfBa+aLYD9w17ZNPqXSV9SL+MTPgINs=;
        b=cIHP3rTCoiMDVBGJwMMFYGauJc7nyjjMhdqW/l8EpeHTxPpK4sIZrp7QUmCGZ5YoQr
         vZcMb1bJWf5TdIyjeRR3iG5kbxs4EOk4v/6wrodQP02nBxQujxKqyKsVP7FVe7w5fIOb
         Xi4qFdHHF/wn+pFwwL6GPAAe2t/7eObyv+uemeBpUVH0tpwT0jQMX6Qd6QntLJOoFdb4
         MEOcsLJYLTKMj7sshmpKvtsNTx782ayEinGRIiMn5MfcHdctZrAjRw7HfGS0TI5EcrbK
         LKf/Ue3UXgKPy5zy5HsLdZeepu1BmuMNcVQR+l6S9RM0hH0hx4C1h2LE88e6D+Y2DfQB
         ofkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38bOAEvnk4iPZfBa+aLYD9w17ZNPqXSV9SL+MTPgINs=;
        b=ibXSP0MPKnvJu/Uhe11o9Li/+G0n9TSV0hJcpI5391LOmh7Hm1A4tEtyfPhS2Bw+7S
         64VpuiD7dgF0ZX355+8rLMpOTORdLAz/VIBHWBw7rD3OpoeJ2GvA+QtiDhX+rmw7PTkx
         dhbcLfm2/TB0p3sdIErbevaAl17J3zLCgjsJGcm0Z9YL4wdLjzoGeDIaVHZx3pUtLKX4
         c6w1qzXPYNJK1/zG0567JC5J4dmJF/4S9S98aubaL0Wp3B0ktre8ZRtoCrpGEqnDZacQ
         xqVY+eSOQPnGq9yIVdSlVmQAuc+U2pbIz8SD4mTU69ttUbuxHkfkS6Je6y1VGhVPKMWb
         uUsw==
X-Gm-Message-State: AOAM531tama/zo8uMa4D7MWeOQ2BPyGr4n3M4Cxr3ZZMssENLLIHPUQK
        i8KjnYAWY+va/+bcNVmwjj423OHdOiHLGL9Ls54=
X-Google-Smtp-Source: ABdhPJyNmmKG4mHEwrfEc5KgJ6mqMtogX+fMmO2/+r4BQrBIC7W2NctsdP2MvWXxeGbU3sNbNOEniwpVZqlQTdOCUac=
X-Received: by 2002:a17:902:ce12:b0:14e:e18e:80a4 with SMTP id
 k18-20020a170902ce1200b0014ee18e80a4mr3038183plg.34.1645026358897; Wed, 16
 Feb 2022 07:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20220216091323.513596-1-memxor@gmail.com>
In-Reply-To: <20220216091323.513596-1-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 16 Feb 2022 07:45:47 -0800
Message-ID: <CAADnVQLnurHLFZY3tL+SL9MgnJj63JKx8KjTwSS0mzsNN6JJTw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix crash due to OOB access when reg->type > __BPF_REG_TYPE_MAX
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Hao Luo <haoluo@google.com>
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

On Wed, Feb 16, 2022 at 1:13 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> When commit e6ac2450d6de ("bpf: Support bpf program calling kernel
> function") added kfunc support, it defined reg2btf_ids as a cheap way to
> translate the verifier reg type to the appropriate btf_vmlinux BTF ID,
> however commit c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with
> PTR_TO_XXX | PTR_MAYBE_NULL") moved the __BPF_REG_TYPE_MAX from the last
> member of bpf_reg_type enum to after the base register types, and
> defined other variants using type flag composition. However, now, the
> direct usage of reg->type to index into reg2btf_ids may no longer fall
> into __BPF_REG_TYPE_MAX range, and hence lead to out of bounds access
> and kernel crash on dereference of bad pointer.
...
> [   20.488393] RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000524156
> [   20.489045] RBP: ffffffffa398c6d4 R08: ffffffffa14dd991 R09: 0000000000000000
> [   20.489696] R10: fffffbfff484f31c R11: 0000000000000001 R12: ffff888007bf8600
> [   20.490377] R13: ffff88800c2f6078 R14: 0000000000000000 R15: 0000000000000001
> [   20.491065] FS:  00007fe06ae70740(0000) GS:ffff88808cc00000(0000) knlGS:0000000000000000
> [   20.491782] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   20.492272] CR2: 0000000000524156 CR3: 000000000902a004 CR4: 0000000000770ef0
> [   20.492925] PKRU: 55555554

Please do not include a full kernel dump in the commit log.
It provides no value.
The first paragraph was enough.

> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Hao Luo <haoluo@google.com>
> Fixes: c25b2ae13603 ("bpf: Replace PTR_TO_XXX_OR_NULL with PTR_TO_XXX | PTR_MAYBE_NULL")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/btf.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e16dafeb2450..416345798e0a 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5568,13 +5568,21 @@ int btf_check_type_match(struct bpf_verifier_log *log, const struct bpf_prog *pr
>         return btf_check_func_type_match(log, btf1, t1, btf2, t2);
>  }
>
> -static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
> +static u32 *reg2btf_ids(enum bpf_reg_type type)
> +{
> +       switch (type) {
>  #ifdef CONFIG_NET
> -       [PTR_TO_SOCKET] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> -       [PTR_TO_SOCK_COMMON] = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> -       [PTR_TO_TCP_SOCK] = &btf_sock_ids[BTF_SOCK_TYPE_TCP],
> +       case PTR_TO_SOCKET:
> +               return &btf_sock_ids[BTF_SOCK_TYPE_SOCK];
> +       case PTR_TO_SOCK_COMMON:
> +               return &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON];
> +       case PTR_TO_TCP_SOCK:
> +               return &btf_sock_ids[BTF_SOCK_TYPE_TCP];
>  #endif
> -};
> +       default:
> +               return NULL;
> +       }
> +}
>
>  /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
>  static bool __btf_type_is_scalar_struct(struct bpf_verifier_log *log,
> @@ -5688,7 +5696,7 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>                         }
>                         if (check_ptr_off_reg(env, reg, regno))
>                                 return -EINVAL;
> -               } else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids[reg->type])) {
> +               } else if (is_kfunc && (reg->type == PTR_TO_BTF_ID || reg2btf_ids(reg->type))) {

Just use reg2btf_ids[base_type(reg->type)] instead?
