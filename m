Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64204C0B08
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 05:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiBWEY1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Feb 2022 23:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiBWEY0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Feb 2022 23:24:26 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA333DA4D
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 20:23:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id s1so22957114iob.9
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 20:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VFj2CaE1ZACWXMB3IRfH8zBAYMktKVEGtUCeow+dGnk=;
        b=pepjUSbInRUsn/8PHL1cmpuRNzrjQhNcTd4O4NNhEb8J2+FniSDi6DWMemU3LFH+of
         6RQawA4kurKp8swJsNTfcwGiiB0o9kGKy61nXb2teOxX2ES0Xc+mpkCROZncizGdlk5r
         QYGVYtJRlmoQlPDV2ruJ5KUjHX0CbM6KfqFm3nmKZMw1xQfc4GT8RT+8DUPDCzGQCBTg
         8NopMtnhY6FQoHT1Hw3R98rkUddReNu9Cga/LEQcA7QI5wJPiqOPaH02e+RKdH/yJPLK
         ZurjNbalcPrLydxJxwS7a0BFiitl2LXL30BcYH6NOEZdJbLuDcqqAhSz0bJxr4NtVwX/
         vB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VFj2CaE1ZACWXMB3IRfH8zBAYMktKVEGtUCeow+dGnk=;
        b=S0Bx4Lvs6A0NuCVAgFNAlG5iHVfIjjnvwOaG9s6+VG0rxTbte/UD6K7dZfkDWezgHl
         EQvMMUpDuKAClbaZy9T4J6dldieRpXMY7hAWDjFunwREROJFqnLNaXXGSx3wOpheuRtC
         ddMTVsGTa8BQqfM3g3mEiiE6EvLK1KEI4wLfMqnLtyF0boU3yIj6JgyqgDp+rMP1f8rS
         uOsEjAGx6snlD2mUq/KDdUHO6qe1pAQyg8wCWNRevXLnqX5yCr+BkCB58H/0cdbLAEG1
         VGtfvP04CFlpDxfTByaLeM9rg4qrnxpJ+AQ9BDWuPz6IzTirM3tO8d2CV/FyEYG7jy8c
         XuHA==
X-Gm-Message-State: AOAM5317Ni10EOFbSnZa0Y7Zn/XcfoqIQR0qLLc3Fg98E+IuaeOSUJjQ
        52FtDHSReOgeHbqyXpWYHlXV0fGtQorXsLT3e6H2VL4GKHCHCg==
X-Google-Smtp-Source: ABdhPJw6lkeg9YjNybR0EE7FgKjAnjXH16lKWRbDbAn792FjOU4YGUIV1AH4zs4jCSqAj0gccOqsqreYCWoMSmDgD/w=
X-Received: by 2002:a05:6602:210c:b0:640:7616:d93a with SMTP id
 x12-20020a056602210c00b006407616d93amr18149887iox.154.1645590238654; Tue, 22
 Feb 2022 20:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20220223020645.1169905-1-mykolal@fb.com>
In-Reply-To: <20220223020645.1169905-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 22 Feb 2022 20:23:47 -0800
Message-ID: <CAEf4BzZ=_p7qxRZr3tWJ8rAb3pM1ynd20Tsq7YoH_302xghzgA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] Small BPF verifier log improvements
To:     Mykola Lysenko <mykolal@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Tue, Feb 22, 2022 at 6:07 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> In particular:
> 1) remove output of inv for scalars
> 2) remove _value suffixes for umin/umax/s32_min/etc (except map_value)
> 3) remove output of id=0
> 4) remove output of ref_obj_id=0
>
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---

LGTM, thanks.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c                         |  59 ++---
>  .../testing/selftests/bpf/prog_tests/align.c  | 218 +++++++++---------
>  .../selftests/bpf/prog_tests/log_buf.c        |   4 +-
>  3 files changed, 143 insertions(+), 138 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d7473fee247c..91154806715d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -539,7 +539,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>         char postfix[16] = {0}, prefix[32] = {0};
>         static const char * const str[] = {
>                 [NOT_INIT]              = "?",
> -               [SCALAR_VALUE]          = "inv",
> +               [SCALAR_VALUE]          = "",
>                 [PTR_TO_CTX]            = "ctx",
>                 [CONST_PTR_TO_MAP]      = "map_ptr",
>                 [PTR_TO_MAP_VALUE]      = "map_value",
> @@ -693,66 +693,71 @@ static void print_verifier_state(struct bpf_verifier_env *env,
>                         /* reg->off should be 0 for SCALAR_VALUE */
>                         verbose(env, "%lld", reg->var_off.value + reg->off);
>                 } else {
> +                       const char *sep = "";
> +
>                         if (base_type(t) == PTR_TO_BTF_ID ||
>                             base_type(t) == PTR_TO_PERCPU_BTF_ID)
>                                 verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
> -                       verbose(env, "(id=%d", reg->id);
> -                       if (reg_type_may_be_refcounted_or_null(t))
> -                               verbose(env, ",ref_obj_id=%d", reg->ref_obj_id);
> +                       verbose(env, "(");
> +
> +/*
> + * _a stands for append, was shortened to avoid multiline statements below. this macro is used to
> + * output a comma separated list of attributes
> + */
> +#define verbose_a(fmt, ...) ({ verbose(env, "%s" fmt, sep, __VA_ARGS__); sep = ","; })

it's a very local macro so it probably doesn't matter all that much,
but a bit more readable name could be verbose_attr() or even just
log_attr(). I'll leave it up to Alexei and Daniel to decide if they'd
like to change it.

> +
> +                       if (reg->id)
> +                               verbose_a("id=%d", reg->id);
> +                       if (reg_type_may_be_refcounted_or_null(t) && reg->ref_obj_id)
> +                               verbose_a("ref_obj_id=%d", reg->ref_obj_id);
>                         if (t != SCALAR_VALUE)
> -                               verbose(env, ",off=%d", reg->off);
> +                               verbose_a("off=%d", reg->off);
>                         if (type_is_pkt_pointer(t))
> -                               verbose(env, ",r=%d", reg->range);
> +                               verbose_a("r=%d", reg->range);
>                         else if (base_type(t) == CONST_PTR_TO_MAP ||
>                                  base_type(t) == PTR_TO_MAP_KEY ||
>                                  base_type(t) == PTR_TO_MAP_VALUE)
> -                               verbose(env, ",ks=%d,vs=%d",
> -                                       reg->map_ptr->key_size,
> -                                       reg->map_ptr->value_size);
> +                               verbose_a("ks=%d,vs=%d",
> +                                         reg->map_ptr->key_size,
> +                                         reg->map_ptr->value_size);
>                         if (tnum_is_const(reg->var_off)) {
>                                 /* Typically an immediate SCALAR_VALUE, but
>                                  * could be a pointer whose offset is too big
>                                  * for reg->off
>                                  */
> -                               verbose(env, ",imm=%llx", reg->var_off.value);
> +                               verbose_a("imm=%llx", reg->var_off.value);
>                         } else {
>                                 if (reg->smin_value != reg->umin_value &&
>                                     reg->smin_value != S64_MIN)
> -                                       verbose(env, ",smin_value=%lld",
> -                                               (long long)reg->smin_value);
> +                                       verbose_a("smin=%lld", (long long)reg->smin_value);
>                                 if (reg->smax_value != reg->umax_value &&
>                                     reg->smax_value != S64_MAX)
> -                                       verbose(env, ",smax_value=%lld",
> -                                               (long long)reg->smax_value);
> +                                       verbose_a("smax=%lld", (long long)reg->smax_value);
>                                 if (reg->umin_value != 0)
> -                                       verbose(env, ",umin_value=%llu",
> -                                               (unsigned long long)reg->umin_value);
> +                                       verbose_a("umin=%llu", (unsigned long long)reg->umin_value);
>                                 if (reg->umax_value != U64_MAX)
> -                                       verbose(env, ",umax_value=%llu",
> -                                               (unsigned long long)reg->umax_value);
> +                                       verbose_a("umax=%llu", (unsigned long long)reg->umax_value);
>                                 if (!tnum_is_unknown(reg->var_off)) {
>                                         char tn_buf[48];
>
>                                         tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> -                                       verbose(env, ",var_off=%s", tn_buf);
> +                                       verbose_a("var_off=%s", tn_buf);
>                                 }
>                                 if (reg->s32_min_value != reg->smin_value &&
>                                     reg->s32_min_value != S32_MIN)
> -                                       verbose(env, ",s32_min_value=%d",
> -                                               (int)(reg->s32_min_value));
> +                                       verbose_a("s32_min=%d", (int)(reg->s32_min_value));
>                                 if (reg->s32_max_value != reg->smax_value &&
>                                     reg->s32_max_value != S32_MAX)
> -                                       verbose(env, ",s32_max_value=%d",
> -                                               (int)(reg->s32_max_value));
> +                                       verbose_a("s32_max=%d", (int)(reg->s32_max_value));
>                                 if (reg->u32_min_value != reg->umin_value &&
>                                     reg->u32_min_value != U32_MIN)
> -                                       verbose(env, ",u32_min_value=%d",
> -                                               (int)(reg->u32_min_value));
> +                                       verbose_a("u32_min=%d", (int)(reg->u32_min_value));
>                                 if (reg->u32_max_value != reg->umax_value &&
>                                     reg->u32_max_value != U32_MAX)
> -                                       verbose(env, ",u32_max_value=%d",
> -                                               (int)(reg->u32_max_value));
> +                                       verbose_a("u32_max=%d", (int)(reg->u32_max_value));
>                         }
> +#undef verbose_a
> +
>                         verbose(env, ")");
>                 }
>         }

[...]
