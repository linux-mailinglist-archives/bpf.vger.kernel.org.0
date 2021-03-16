Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A825C33CC9B
	for <lists+bpf@lfdr.de>; Tue, 16 Mar 2021 05:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhCPEhE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Mar 2021 00:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbhCPEgh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Mar 2021 00:36:37 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0F7C06174A;
        Mon, 15 Mar 2021 21:36:37 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 133so35503635ybd.5;
        Mon, 15 Mar 2021 21:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kN7lf9pianI3iI8amWxAia6Kwgs6GRh9yvG1FbniCmE=;
        b=HthrGG4ws7cGcA3MlPPYj+ZBKhm6c7t4XEb2CCEY5gtDBHVaFm5JcyzepmD18mdXKp
         2LdmVQyAfjZrEkL43a90TQCcG1fKkreBvRqlOzrpG5iVSbkPPkQNCoVblDxBoUJAfrOW
         I9M58shdnqGnAC99mtLKC+Q6qIsV7Tg5j7zWAUSNkLQDldEFxQn+zhj2IaT0oSI/PCCA
         hZmp/2GGGFgFCRysu8z+vJR0O2YVy5O9PksiY/4kK6GC1i0OLQPq/XPK5yygP6YxgZ3o
         5lMV8w/ckpHxFOmeDiGHjSAXAODxXBSX4ON6MNovhee+fMp/V4Kuhuc8UgIj3/dGOIum
         5Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kN7lf9pianI3iI8amWxAia6Kwgs6GRh9yvG1FbniCmE=;
        b=rNgF7OvKcsLhZfYrP5sDyYREj3QSR07fBjZ4qBaOHYu7G9B1GhVPC7p7YXIJGYDcQy
         35KgGaTWZNp+6UsrW+YufgJWtIhMVb0bwTEDDwUNLVQe+EaMa4AjgntAfPKaT6IbubUd
         CoTgJUfBvADM0oFm3s7r/9rBjBdIlynpOJ0rEvY12EHvvGqanCZwPrlI+IE91IzSmccn
         2XQMM4EL3bum2cFvhSnVMeVjh2jQUBuUkq7T8SdqWK4H4VNy4xq7Z2hE4FsCllkpMJq2
         fPwJBNVDdnAl54L4j9BGLxR43PjfDamHe5JOzvPf2KknArg8IAsakksP7agDE6PlsT+/
         3O0w==
X-Gm-Message-State: AOAM5306u/pCYcxYggYH1MEqTKBR18bq2UxqlcC7ImdH/VzbP7rcjL3P
        U3gE0IgrF8t51IEPxcaqFZpw9ID5mSE8wjGnZyc=
X-Google-Smtp-Source: ABdhPJz8MpszVfbHFA4xs5dBU+YmUyruGxaQpteCQEkwmORYb1MFesPzqSyYTEctHxf7zll9qKga5WBAHcyQwchBWfY=
X-Received: by 2002:a25:c6cb:: with SMTP id k194mr4253818ybf.27.1615869396350;
 Mon, 15 Mar 2021 21:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210310220211.1454516-1-revest@chromium.org> <20210310220211.1454516-4-revest@chromium.org>
In-Reply-To: <20210310220211.1454516-4-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Mar 2021 21:36:25 -0700
Message-ID: <CAEf4BzZmQ3C=DfSRckM0AUXhz2MeghwhF6RLspS2u44sx0LP-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/5] libbpf: Initialize the bpf_seq_printf
 parameters array field by field
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 2:02 PM Florent Revest <revest@chromium.org> wrote:
>
> When initializing the __param array with a one liner, if all args are
> const, the initial array value will be placed in the rodata section but
> because libbpf does not support relocation in the rodata section, any
> pointer in this array will stay NULL.
>
> This is a workaround, ideally the rodata relocation should be supported
> by libbpf but this would require a disproportionate amount of work given
> the actual usecases. (it is very unlikely that one uses a const array of
> relocated addresses)
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  tools/lib/bpf/bpf_tracing.h | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index f9ef37707888..f6a2deb3cd5b 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -413,6 +413,34 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
>  }                                                                          \
>  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>
> +#define ___bpf_build_param0(narg, x)
> +#define ___bpf_build_param1(narg, x) ___param[narg - 1] = x
> +#define ___bpf_build_param2(narg, x, args...) ___param[narg - 2] = x; \
> +                                             ___bpf_build_param1(narg, args)
> +#define ___bpf_build_param3(narg, x, args...) ___param[narg - 3] = x; \
> +                                             ___bpf_build_param2(narg, args)
> +#define ___bpf_build_param4(narg, x, args...) ___param[narg - 4] = x; \
> +                                             ___bpf_build_param3(narg, args)
> +#define ___bpf_build_param5(narg, x, args...) ___param[narg - 5] = x; \
> +                                             ___bpf_build_param4(narg, args)
> +#define ___bpf_build_param6(narg, x, args...) ___param[narg - 6] = x; \
> +                                             ___bpf_build_param5(narg, args)
> +#define ___bpf_build_param7(narg, x, args...) ___param[narg - 7] = x; \
> +                                             ___bpf_build_param6(narg, args)
> +#define ___bpf_build_param8(narg, x, args...) ___param[narg - 8] = x; \
> +                                             ___bpf_build_param7(narg, args)
> +#define ___bpf_build_param9(narg, x, args...) ___param[narg - 9] = x; \
> +                                             ___bpf_build_param8(narg, args)
> +#define ___bpf_build_param10(narg, x, args...) ___param[narg - 10] = x; \
> +                                              ___bpf_build_param9(narg, args)
> +#define ___bpf_build_param11(narg, x, args...) ___param[narg - 11] = x; \
> +                                              ___bpf_build_param10(narg, args)
> +#define ___bpf_build_param12(narg, x, args...) ___param[narg - 12] = x; \
> +                                              ___bpf_build_param11(narg, args)

took me some time to get why the [narg - 12] :) it makes sense, but
then I started wondering why not

#define ___bpf_build_param12(narg, x, args...)
___bpf_build_param11(narg, args); ___param[11] = x

? seems more straightforward, no?

also please keep all of them on single line. And to make lines
shorter, let's call it ___bpf_fillX? I also don't like hard-coded
___param, which is both inflexible and is obscure at the point of use
of this macro. So let's pass it as the first argument?

> +#define ___bpf_build_param(args...) \
> +       unsigned long long ___param[___bpf_narg(args)];                 \
> +       ___bpf_apply(___bpf_build_param, ___bpf_narg(args))(___bpf_narg(args), args)
> +

And here I'd pass array as a parameter and let caller define it, so
macro is literally just filling the array elements, not defining the
array itself and what's the type of elements

>  /*
>   * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
>   * in a structure.
> @@ -422,7 +450,7 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>                 _Pragma("GCC diagnostic push")                              \
>                 _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
>                 static const char ___fmt[] = fmt;                           \
> -               unsigned long long ___param[] = { args };                   \
> +               ___bpf_build_param(args);                                   \
>                 _Pragma("GCC diagnostic pop")                               \
>                 int ___ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),    \
>                                             ___param, sizeof(___param));    \

here you are violating separation of variables and code,
___bpf_build_param is defining a variable, then has code statements,
then you are declaring ___ret after the code. So please split ___ret
definition,

> --
> 2.30.1.766.gb4fecdf3b7-goog
>
