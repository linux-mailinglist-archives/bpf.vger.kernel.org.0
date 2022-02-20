Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449114BCB72
	for <lists+bpf@lfdr.de>; Sun, 20 Feb 2022 02:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiBTBKl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Feb 2022 20:10:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiBTBKk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Feb 2022 20:10:40 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D639682
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 17:10:20 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id t9so4889048ilf.13
        for <bpf@vger.kernel.org>; Sat, 19 Feb 2022 17:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyNbqa78EHVIO/Qz7mZ9FJNk9T3vamj7Xva8b8hTYuo=;
        b=gXxhKZhRTJFV6TJlpHs/ODSNUJqBLUM8MwFwS7nMCf1WrF9835/WkRIDfJOClGyf/6
         x1jtVVr3cr1DBAtLqATygERmJ/iTBe45Ib5jCWGCwg/Vh28K0PaTRNrSy7KWyy7u2ao/
         p23Y49M5tIl72VkDVv7wwH+jqjVpocSCU9KiMN4QUk0Hbf/L+kxrtsizDxQWAfy02Kae
         IFiukDCyVDBPpIzuTwl8hdNxBdvjCFDj2NTnRlZZqmvRq4jlWEY6DXd962G54TYsCJ1d
         JXumfihLmVUoRJvtqI/tgRE4d+mVSvToQbYSNTa5CqLOJxjAss5OGUaOyvmlCOy93Owj
         APEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyNbqa78EHVIO/Qz7mZ9FJNk9T3vamj7Xva8b8hTYuo=;
        b=zB6BQW/zE68DSGD8Xf0rhjDJzcdQ2gCxK3uczoK+lPvgoKci3m2oRd0UsXCgrt1nbJ
         U4Bcke+hlARrGHcvHizTIoSGhpASPykbRNYMs1p9iZU7LBZ+1pwqQ/pitCGDU8lguwnY
         FIDltKa77jwiENFptGn5ShcUe4eOjId7JzRp2YErzBqhsS9SzYYFvZptBhjIQDW2YNiX
         c053D39bjk8a27PSVXcaLYop2Wq+SzO+A5Vlwinj6UEmGSYFejgRw4hEoZm/NWWGJfMs
         9exxiH/3CsVfj2fUPp2U75e4lovOYlyrBrRlVNvtB2IDoIK+kzvyNGhScCgOh1jSnqDC
         KGYQ==
X-Gm-Message-State: AOAM5313Bx7IAiopItAawuxCsxpBQnd+1pCAgy4l1lPsE+goDmMJlaD4
        H08MHpPhx4UmspYVilZe/lIG+YegJ9QPEYeZzCLuwYZHeeg=
X-Google-Smtp-Source: ABdhPJyBA+t1XGstOwIYkiSYFGiPByX3PTi8/3NPXQGoN16D+86N7+oNMC2AJa/zcUICAQgaxRKuAmgQ6ZTUcXIjAFU=
X-Received: by 2002:a05:6e02:503:b0:2bf:a929:4dc3 with SMTP id
 d3-20020a056e02050300b002bfa9294dc3mr10519674ils.98.1645319419704; Sat, 19
 Feb 2022 17:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20220219003633.1110239-1-mykolal@fb.com>
In-Reply-To: <20220219003633.1110239-1-mykolal@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 19 Feb 2022 17:10:09 -0800
Message-ID: <CAEf4BzbXqnchq5yejT3jhrRLizBRWQcuwb8U43r2-c6GpQEMBg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] Small BPF verifier log improvements
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

On Fri, Feb 18, 2022 at 4:36 PM Mykola Lysenko <mykolal@fb.com> wrote:
>
> In particular:
> 1) remove output of inv for scalars
> 2) remove _value suffixes for umin/umax/s32_min/etc (except map_value)
> 3) remove output of id=0
> 4) remove output of ref_obj_id=0
>
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
> ---

Few nitpicks below, but this is a great improvement!

>  kernel/bpf/verifier.c                         |  72 +++---
>  .../testing/selftests/bpf/prog_tests/align.c  | 218 +++++++++---------
>  .../selftests/bpf/prog_tests/log_buf.c        |   4 +-
>  3 files changed, 156 insertions(+), 138 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d7473fee247c..a43bb0cf4c46 100644
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
> @@ -666,6 +666,15 @@ static void scrub_spilled_slot(u8 *stype)
>                 *stype = STACK_MISC;
>  }
>
> +#define verbose_append(fmt, ...) \
> +({ \
> +       if (is_first_item) \
> +               is_first_item = false; \
> +       else \
> +               verbose(env, ","); \
> +       verbose(env, fmt, __VA_ARGS__); \
> +})
> +

let's move this inside print_verifier_state() and #undef it at the end
of that function, given it should only be used inside it.

I don't know if it's better (it sucks either way that we need to
define extra macro for this, but alternative approach would be to
define separator:

const char *sep = "";

#define verbose_append(fmt, ...) ({ verbose(env, "%s" fmt, sep,
__VA_ARGS__); sep = ","; })

>  static void print_verifier_state(struct bpf_verifier_env *env,
>                                  const struct bpf_func_state *state,
>                                  bool print_all)
> @@ -693,65 +702,74 @@ static void print_verifier_state(struct bpf_verifier_env *env,
>                         /* reg->off should be 0 for SCALAR_VALUE */
>                         verbose(env, "%lld", reg->var_off.value + reg->off);
>                 } else {
> +                       bool is_first_item = true;
> +
>                         if (base_type(t) == PTR_TO_BTF_ID ||
>                             base_type(t) == PTR_TO_PERCPU_BTF_ID)
>                                 verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
> -                       verbose(env, "(id=%d", reg->id);
> -                       if (reg_type_may_be_refcounted_or_null(t))
> -                               verbose(env, ",ref_obj_id=%d", reg->ref_obj_id);
> +
> +                       verbose(env, "(");
> +
> +                       if (reg->id) {
> +                               verbose(env, "id=%d", reg->id);
> +                               is_first_item = false;

should be also verbose_append?

> +                       }
> +
> +                       if (reg_type_may_be_refcounted_or_null(t) && reg->ref_obj_id)
> +                               verbose_append("ref_obj_id=%d", reg->ref_obj_id);
>                         if (t != SCALAR_VALUE)
> -                               verbose(env, ",off=%d", reg->off);
> +                               verbose_append("off=%d", reg->off);
>                         if (type_is_pkt_pointer(t))
> -                               verbose(env, ",r=%d", reg->range);
> +                               verbose_append("r=%d", reg->range);
>                         else if (base_type(t) == CONST_PTR_TO_MAP ||
>                                  base_type(t) == PTR_TO_MAP_KEY ||
>                                  base_type(t) == PTR_TO_MAP_VALUE)
> -                               verbose(env, ",ks=%d,vs=%d",
> -                                       reg->map_ptr->key_size,
> -                                       reg->map_ptr->value_size);
> +                               verbose_append("ks=%d,vs=%d",
> +                                              reg->map_ptr->key_size,
> +                                              reg->map_ptr->value_size);
>                         if (tnum_is_const(reg->var_off)) {
>                                 /* Typically an immediate SCALAR_VALUE, but
>                                  * could be a pointer whose offset is too big
>                                  * for reg->off
>                                  */
> -                               verbose(env, ",imm=%llx", reg->var_off.value);
> +                               verbose_append("imm=%llx", reg->var_off.value);
>                         } else {
>                                 if (reg->smin_value != reg->umin_value &&
>                                     reg->smin_value != S64_MIN)
> -                                       verbose(env, ",smin_value=%lld",
> -                                               (long long)reg->smin_value);
> +                                       verbose_append("smin=%lld",
> +                                                      (long long)reg->smin_value);

a bunch of these should fit within 100 character single line, given
the code churn anyways, let's "straighten" those wrapped lines where
possible? if we go with something shorter than "verbose_append" even
more lines would fit (verbose_add, don't know, naming is hard).

>                                 if (reg->smax_value != reg->umax_value &&
>                                     reg->smax_value != S64_MAX)
> -                                       verbose(env, ",smax_value=%lld",
> -                                               (long long)reg->smax_value);
> +                                       verbose_append("smax=%lld",
> +                                                      (long long)reg->smax_value);
>                                 if (reg->umin_value != 0)
> -                                       verbose(env, ",umin_value=%llu",
> -                                               (unsigned long long)reg->umin_value);
> +                                       verbose_append("umin=%llu",
> +                                                      (unsigned long long)reg->umin_value);
>                                 if (reg->umax_value != U64_MAX)
> -                                       verbose(env, ",umax_value=%llu",
> -                                               (unsigned long long)reg->umax_value);
> +                                       verbose_append("umax=%llu",
> +                                                      (unsigned long long)reg->umax_value);
>                                 if (!tnum_is_unknown(reg->var_off)) {
>                                         char tn_buf[48];
>
>                                         tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> -                                       verbose(env, ",var_off=%s", tn_buf);
> +                                       verbose_append("var_off=%s", tn_buf);
>                                 }
>                                 if (reg->s32_min_value != reg->smin_value &&
>                                     reg->s32_min_value != S32_MIN)
> -                                       verbose(env, ",s32_min_value=%d",
> -                                               (int)(reg->s32_min_value));
> +                                       verbose_append("s32_min=%d",
> +                                                      (int)(reg->s32_min_value));
>                                 if (reg->s32_max_value != reg->smax_value &&
>                                     reg->s32_max_value != S32_MAX)
> -                                       verbose(env, ",s32_max_value=%d",
> -                                               (int)(reg->s32_max_value));
> +                                       verbose_append("s32_max=%d",
> +                                                      (int)(reg->s32_max_value));
>                                 if (reg->u32_min_value != reg->umin_value &&
>                                     reg->u32_min_value != U32_MIN)
> -                                       verbose(env, ",u32_min_value=%d",
> -                                               (int)(reg->u32_min_value));
> +                                       verbose_append("u32_min=%d",
> +                                                      (int)(reg->u32_min_value));
>                                 if (reg->u32_max_value != reg->umax_value &&
>                                     reg->u32_max_value != U32_MAX)
> -                                       verbose(env, ",u32_max_value=%d",
> -                                               (int)(reg->u32_max_value));
> +                                       verbose_append("u32_max=%d",
> +                                                      (int)(reg->u32_max_value));
>                         }
>                         verbose(env, ")");
>                 }

[...]
