Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BC4325925
	for <lists+bpf@lfdr.de>; Thu, 25 Feb 2021 23:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhBYV6m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Feb 2021 16:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBYV5G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Feb 2021 16:57:06 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DA2C06174A
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 13:56:25 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id c131so6934448ybf.7
        for <bpf@vger.kernel.org>; Thu, 25 Feb 2021 13:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9yYGln318W9BWJAgE8J4+xZ9w6AmLBl+7EN10sCSDU=;
        b=EzNgFaldc3laJ/6ylHkF7mXkhbvBvlF7DHWvcw7bQ3iQlkJdrTdbw33eWg6qoqH8W6
         tuD6S5dYDmSVG2K8ALSz74mVG599+3jC3JPLbzf3GyB1zmG9llAqYE2nDaLm1LwhGkDk
         Gb7R3EnK+qf3WPe/HASbUAtIOOrkP/oSdt3TTpb0wW3hzdeMYNF8lQGFRCWlZGeMd6iG
         sC1lI8QN1V0CfLO6Vr4TaL+VvG28l5h9UVnh079a0FZ3BuONhRwXIovAUlXbJYxlIVy2
         ywnTyFVzuDk/QmdWW4UIddHke/oHUjaIWbpXw0e0pDCpP+UwgOPZdtrZOc/8dOQWDh2A
         UZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9yYGln318W9BWJAgE8J4+xZ9w6AmLBl+7EN10sCSDU=;
        b=XJ6CPtrK2VdrdrW7SlZwGrHFbeZhE41T6xWS2AYuNogxVj0C39mGmqRdvJCQB9tL9+
         U+ezWPE7s+SXvn91prFnsRUjOl7UfqKVSMqn+kJigzxwqn97WneOjYgTkWfShrnO+qn4
         ejyiCZl18faGfnY4wIdKQ7ILtjUMdX07f16c59XAv0RMStMyKadGrvqp5D7sqpWtW56M
         a0TJvtxBR5rEw/XcODLEmStrzwJa8B/vonz2TlqxSjzy6vGadIUf+ZeUfXmCYwRq5dEq
         iQq/RxmsS1TfpKJyllxagFPO/dm30zeu2PKoecTS04w1xQxE+j/g9g+bDVCjTZi3dc1N
         i4WA==
X-Gm-Message-State: AOAM531smI0LHwdATtGKppaOoWP7sMqQ58OSaOtMY/iA3LlY9VrPGtIV
        R33Gxw6PjQEBGPiFNx2HaEadMyHSLjHObasO/ss=
X-Google-Smtp-Source: ABdhPJwKFwa4hZ6IX8U//IfyCVx7LNjs1qQKoeEwQGqT17ljVq7RfjDr8poyZonhbPJwVQA6/4WuK/QIQOvd8nzt2ss=
X-Received: by 2002:a25:abb2:: with SMTP id v47mr7088752ybi.425.1614290184959;
 Thu, 25 Feb 2021 13:56:24 -0800 (PST)
MIME-Version: 1.0
References: <20210225073309.4119708-1-yhs@fb.com> <20210225073310.4120174-1-yhs@fb.com>
In-Reply-To: <20210225073310.4120174-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Feb 2021 13:56:13 -0800
Message-ID: <CAEf4BzaEJKLUDNJyaEYb7e+hd-4eivFCOsTYLRJhzb9XXX86jA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/11] bpf: factor out verbose_invalid_scalar()
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 25, 2021 at 1:35 AM Yonghong Song <yhs@fb.com> wrote:
>
> Factor out the function verbose_invalid_scalar() to verbose
> print if a scalar is not in a tnum range. There is no
> functionality change and the function will be used by
> later patch which introduced bpf_for_each_map_elem().
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  kernel/bpf/verifier.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9cb182e91162..a657860ecba5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -390,6 +390,25 @@ __printf(3, 4) static void verbose_linfo(struct bpf_verifier_env *env,
>         env->prev_linfo = linfo;
>  }
>
> +static void verbose_invalid_scalar(struct bpf_verifier_env *env,
> +                                  struct bpf_reg_state *reg,
> +                                  struct tnum *range, const char *ctx,
> +                                  const char *reg_name)
> +{
> +       char tn_buf[48];
> +
> +       verbose(env, "At %s the register %s ", ctx, reg_name);
> +       if (!tnum_is_unknown(reg->var_off)) {
> +               tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> +               verbose(env, "has value %s", tn_buf);
> +       } else {
> +               verbose(env, "has unknown scalar value");
> +       }
> +       tnum_strn(tn_buf, sizeof(tn_buf), *range);
> +       verbose(env, " should have been in %s\n", tn_buf);
> +}
> +
> +

nit: double empty line

>  static bool type_is_pkt_pointer(enum bpf_reg_type type)
>  {
>         return type == PTR_TO_PACKET ||
> @@ -8455,17 +8474,7 @@ static int check_return_code(struct bpf_verifier_env *env)
>         }
>
>         if (!tnum_in(range, reg->var_off)) {
> -               char tn_buf[48];
> -
> -               verbose(env, "At program exit the register R0 ");
> -               if (!tnum_is_unknown(reg->var_off)) {
> -                       tnum_strn(tn_buf, sizeof(tn_buf), reg->var_off);
> -                       verbose(env, "has value %s", tn_buf);
> -               } else {
> -                       verbose(env, "has unknown scalar value");
> -               }
> -               tnum_strn(tn_buf, sizeof(tn_buf), range);
> -               verbose(env, " should have been in %s\n", tn_buf);
> +               verbose_invalid_scalar(env, reg, &range, "program exit", "R0");
>                 return -EINVAL;
>         }
>
> --
> 2.24.1
>
