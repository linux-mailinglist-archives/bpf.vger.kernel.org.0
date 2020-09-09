Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFE2262629
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 06:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgIIEWZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 00:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIIEWZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 00:22:25 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EBCC061573
        for <bpf@vger.kernel.org>; Tue,  8 Sep 2020 21:22:24 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id x10so886668ybj.13
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 21:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lu4qhhYEa2iB2xkeURcc6FK3dkKf3lA8d8MaZBBzmwk=;
        b=Uf5bQ6DFE/Jcj5WpN2n8vJIwIXoEnyQFEatuxsgcQDS0QIULAx+V4T9wTolSlfqU42
         MTpUepZNteIlLYNzI5DAhPGhF65FJg3x1eeTzFa7Hq8px4V/lFN5qOB3p1y5XtuYF12I
         Vq5v4YPiQE60qRg0pamIrrii0tCyLhUDUHi9Vl487D2NTsxP3900HWzU8E1hDBGNuVm4
         tt8O3O4T30XJsIGh5+9JeGhv9MsmHEk8xexG4+WVQP4mLaKBWP2eJtYYX+GPx82347t/
         NHckk7GCMKGFnzl/mzK/8OcmxuEN1JmbZw9MvM9QSQgWyZjY8zjQwcH4At6cXOBARnEh
         BOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lu4qhhYEa2iB2xkeURcc6FK3dkKf3lA8d8MaZBBzmwk=;
        b=LdTNHsyI2lRjISNTgC8BcC8Pw+MtewE015Tabi10IKAQXHswCHfCltmtqIXPJB7uNu
         XkYrAgSl8jfkgQ9v1QgMW2yOQOQaTsNhUdECFsVW2OLFrF9+fmTJ7mEsiZGfyEFUC2i4
         ILhyVFzpTY0zRIb3DhzGhRNY/Il+P6xz3iakeF5Uy9x11idKwGhThCHQ9xiqq9PnM4sS
         63+rIdNT0fT+FTY0bC4d8J+m1Pf90yOaqHL8B8OWMLYTpAsNtYF6X8qYaZKm8/nK9YgU
         CHKC9DJryd/dOY1iJAgxdV/epuZ+hdrjJVHzyLjrQD8ECPeCkvxfmO4UjhIpWvlWjUR9
         ZMXw==
X-Gm-Message-State: AOAM531wKxnFJ4xAk9hBPBBpztYamqEyfNM1Nb3P7U/5HGYWDWgq3t8X
        884dhm544luW7E/LZbVuufe7qc3CvpeIvauyiPs=
X-Google-Smtp-Source: ABdhPJysjEc0y6rtqCBRf2jXu0uVqkT8fEUQGMcIgrSmknlqawu16g7lBZ4jx6YWCJLk9c6bihSfxXWlWZZNtAvYtFo=
X-Received: by 2002:a25:ef43:: with SMTP id w3mr2874181ybm.230.1599625343582;
 Tue, 08 Sep 2020 21:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-5-lmb@cloudflare.com>
In-Reply-To: <20200904112401.667645-5-lmb@cloudflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 8 Sep 2020 21:22:12 -0700
Message-ID: <CAEf4BzaSDWCjCCFQ4mvU2ORVN8CQVHHL4doKipcjo4EC+vm_5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 04/11] bpf: check scalar or invalid register in check_helper_mem_access
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 4, 2020 at 4:29 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> Move the check for a NULL or zero register to check_helper_mem_access. This
> makes check_stack_boundary easier to understand.
>
> Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> ---

Looks good as is, but I'm curious about the question below.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  kernel/bpf/verifier.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 509754c3aa7d..649bcfb4535e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3594,18 +3594,6 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
>         struct bpf_func_state *state = func(env, reg);
>         int err, min_off, max_off, i, j, slot, spi;
>
> -       if (reg->type != PTR_TO_STACK) {
> -               /* Allow zero-byte read from NULL, regardless of pointer type */
> -               if (zero_size_allowed && access_size == 0 &&
> -                   register_is_null(reg))
> -                       return 0;
> -
> -               verbose(env, "R%d type=%s expected=%s\n", regno,
> -                       reg_type_str[reg->type],
> -                       reg_type_str[PTR_TO_STACK]);
> -               return -EACCES;
> -       }
> -
>         if (tnum_is_const(reg->var_off)) {
>                 min_off = max_off = reg->var_off.value + reg->off;
>                 err = __check_stack_boundary(env, regno, min_off, access_size,
> @@ -3750,9 +3738,19 @@ static int check_helper_mem_access(struct bpf_verifier_env *env, int regno,
>                                            access_size, zero_size_allowed,
>                                            "rdwr",
>                                            &env->prog->aux->max_rdwr_access);
> -       default: /* scalar_value|ptr_to_stack or invalid ptr */
> +       case PTR_TO_STACK:
>                 return check_stack_boundary(env, regno, access_size,
>                                             zero_size_allowed, meta);
> +       default: /* scalar_value or invalid ptr */
> +               /* Allow zero-byte read from NULL, regardless of pointer type */
> +               if (zero_size_allowed && access_size == 0 &&
> +                   register_is_null(reg))
> +                       return 0;

Given comment explicitly states "regardless of pointer type",
shouldn't this be checked before we do pointer type-specific checks?

> +
> +               verbose(env, "R%d type=%s expected=%s\n", regno,
> +                       reg_type_str[reg->type],
> +                       reg_type_str[PTR_TO_STACK]);
> +               return -EACCES;
>         }
>  }
>
> --
> 2.25.1
>
