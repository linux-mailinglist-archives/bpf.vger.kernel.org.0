Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188D0201D87
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 23:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgFSV5m (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 17:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgFSV5W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jun 2020 17:57:22 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7FC0613EE
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:57:22 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g1so8805876edv.6
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2020 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6JPAp3MPMy2C7nQgCr/hCBLRXeItUchmImM1uX7KpU=;
        b=T9xG2MxyPvTgtAt+l76ynuru+1jde4ob/XRXKNvndkTtf0quMxl/j0HOvwTi08e3bs
         KAyo+95p5cUPknp5YfTcBYOPLbiTSYUTzIh3eMe/9huYT/2AqJsEJgapDQ04tdcn9obE
         w6LvvYZ5MrWqv1xX9SwFvH2BI5hlQVuN69+Xd/zFqQHVGoAvWzg++rjZzoyVFdjS/UVt
         2s1lh7671kTJ2Za5tQVgP780sfwIKdqWKdKc0i9l0B+gZj4fngKZOFocESjXCpSCcqVY
         L4y+aw2qrCXrpKTXnzzOvFJYBi6KWS9zt+8lPzr37g0wPlZiyyQLfpemF76KFvwM5JzN
         QVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6JPAp3MPMy2C7nQgCr/hCBLRXeItUchmImM1uX7KpU=;
        b=SY/P1JVs0FyxrFTY5DikAU2wdCtJRDZ0f6KWHqwxWcU85mbBmYQ5xfjRU1MdrPJ1MA
         3shQRYH8kCuuY6OY+4vJU/ZC5RHyNPIZiCcQyeKRpWRBArv9d1xVVwNldtVoag9upZkR
         +vdt4h4scGizcGVkOtnk1RFezas3tpqHwkCS4H9OWDRS1pB7KUbF5Gz93pBDMhzmgP3W
         5Nd4L3upHwJTc1j6Cr51mPFwQBPh5axjsuvqMH0X9jge0kf4jg0vHBcgqVGRcoM+1y8Y
         qF8TudgSmoQo27j7seCJfJSrjb9uhuWuDtx2l7thEEklWBstNEGPUVLhT8l2m7NV4S5M
         ikpw==
X-Gm-Message-State: AOAM5331LRD3+acraylY6BmyxemmapAS0WPO4MwlEM5ZGpCq4d8kDK2L
        IFI+gjrXzvGNXj/qQTOcBHgvzTgfMEHrv8PPQ2x2aQ==
X-Google-Smtp-Source: ABdhPJxvOL8EmJpjWYWye8qJ4ZYoYCtESyMIqx6n8uRz2hqNXJ4GGwhz9C7pTIsCncIw6GeatictD8iCVw+AHkcBV3I=
X-Received: by 2002:aa7:d952:: with SMTP id l18mr5308985eds.151.1592603840874;
 Fri, 19 Jun 2020 14:57:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200619203026.78267-1-andriin@fb.com> <20200619203026.78267-2-andriin@fb.com>
In-Reply-To: <20200619203026.78267-2-andriin@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 19 Jun 2020 14:57:09 -0700
Message-ID: <CA+khW7ji5gFXh1XN71CUy08+bofu=yKfopgXV7yOuhRkoSr1=w@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/9] libbpf: generalize libbpf externs support
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Only two small places on this version, otherwise it looks good to me.
I can offer my reviewed-by, if need. :)

Thanks for the patch!

Reviewed-by: Hao Luo <haoluo@google.com>

On Fri, Jun 19, 2020 at 1:34 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Switch existing Kconfig externs to be just one of few possible kinds of more
> generic externs. This refactoring is in preparation for ksymbol extern
> support, added in the follow up patch. There are no functional changes
> intended.
>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---

[...]

> @@ -2756,23 +2796,29 @@ static int cmp_externs(const void *_a, const void *_b)

[...]

> +
> +       if (a->type == EXT_KCFG) {
> +               /* descending order by alignment requirements */
> +               if (a->kcfg.align != b->kcfg.align)
> +                       return a->kcfg.align > b->kcfg.align ? -1 : 1;
> +               /* ascending order by size, within same alignment class */
> +               if (a->kcfg.sz != b->kcfg.sz)
> +                       return a->kcfg.sz < b->kcfg.sz ? -1 : 1;
> +               /* resolve ties by name */
> +       }
> +
>         return strcmp(a->name, b->name);
>  }

I assume the comment /* resolve ties by name */ is intended to be
close to strcmp?

> @@ -2818,22 +2864,39 @@ static int bpf_object__collect_externs(struct bpf_object *obj)
>                 ext->name = btf__name_by_offset(obj->btf, t->name_off);
>                 ext->sym_idx = i;
>                 ext->is_weak = GELF_ST_BIND(sym.st_info) == STB_WEAK;
> -               ext->sz = btf__resolve_size(obj->btf, t->type);
> -               if (ext->sz <= 0) {
> -                       pr_warn("failed to resolve size of extern '%s': %d\n",
> -                               ext_name, ext->sz);
> -                       return ext->sz;
> -               }
> -               ext->align = btf__align_of(obj->btf, t->type);
> -               if (ext->align <= 0) {
> -                       pr_warn("failed to determine alignment of extern '%s': %d\n",
> -                               ext_name, ext->align);
> -                       return -EINVAL;
> -               }
> -               ext->type = find_extern_type(obj->btf, t->type,
> -                                            &ext->is_signed);
> -               if (ext->type == EXT_UNKNOWN) {
> -                       pr_warn("extern '%s' type is unsupported\n", ext_name);
> +
> +               ext->sec_btf_id = find_extern_sec_btf_id(obj->btf, ext->btf_id);
> +               if (ext->btf_id <= 0) {
> +                       pr_warn("failed to find BTF for extern '%s' [%d] section: %d\n",
> +                               ext_name, ext->btf_id, ext->sec_btf_id);
> +                       return ext->sec_btf_id;
> +               }

Did you mean "ext->sec_btf_id <= 0" rather than "ext->btf_id <= 0"?
