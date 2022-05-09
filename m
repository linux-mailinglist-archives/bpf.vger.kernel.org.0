Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49055204CB
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbiEIS6N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 14:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbiEIS6M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 14:58:12 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E81595AC
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 11:54:17 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id e194so16312300iof.11
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6by0ZhdKRx4KdkTLc4N7SRkhTiqDSLysqP8gTRIHa0=;
        b=PDFd5BkIlxbbyw+h3xMK/TIygQpoYFH2lQYYm1LmTVo4TsyxFgSjk8EY0gMhyB2t0H
         5b+VmXefs0f1TJf4xxCfaE2U2plMECuv5fnFpC9R64TpaK40nRwhPvV7Y0wd12giEjOo
         PZi7TInXLmYHDdUPQOlU924JP6eFhm4ql6iJOCCQnO05y7/ijYTQLAN+Zsv7Ru/ylBTb
         8Q/QbXd43vJz/HZrrSH8sxUp2mF4aeYY45VeIW6UyI0jmv2rs8Z2Bpkwcr1G7e1d2zYK
         9vWX3Wohvw6NPJtFxtP7Z+DcU+2YJVNqbDxkbhflUNHWc5Hg1udSEfxCxtzhJajWCyI2
         tZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6by0ZhdKRx4KdkTLc4N7SRkhTiqDSLysqP8gTRIHa0=;
        b=Z2Rg2cmXkf93JZUUA9oUTRvmB5OuUa8kkf/brPnem4MkzDFtNUkW5cG/LWh5GuzBA2
         aK62Hdop8wazmdhxy+Nac2zuV0rgiqg9sgp93MNcpJ2fv3r890dhbEPd/D4tFxGqGU3p
         wR91UNKzk0IRtFZnZJvjb/QUDu+/k5N9L9qmDpK7O7AtsTX92riS0Q5tn2jsDJ2jRN4L
         h8Qz+V6+PU+FOVe/4CBXZq8/uFOEb7D5mAMTX0MWTzvEsmU10uTyJzOgnXMnbKap+L8+
         ci1eQ0MvoXC1k3m/xYKIaqxbgdMr5Damq8KFUwshf4sU4ZAE9CFQ2IzlvDD/rD238UDr
         lpOg==
X-Gm-Message-State: AOAM530P5n8kujf684Wm6Oy/VbgYHWaDmF9//HdYEOfLpgyHHmsIVXvt
        QtEVekx68/h7qaLwBvD6Ebj3FdsdNl46L9pX1qI=
X-Google-Smtp-Source: ABdhPJytIc+i2a0A83S5JD6gA8gLvGgDYqG3O0syTrL7gwknQJxXh4jNJjvtWbaZ1712cbDllEQH5zOVvPGs/IvfHAI=
X-Received: by 2002:a05:6638:533:b0:32a:d418:b77b with SMTP id
 j19-20020a056638053300b0032ad418b77bmr7939840jar.237.1652122457109; Mon, 09
 May 2022 11:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220508032117.2783209-1-kuifeng@fb.com> <20220508032117.2783209-2-kuifeng@fb.com>
In-Reply-To: <20220508032117.2783209-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 9 May 2022 11:54:06 -0700
Message-ID: <CAEf4BzYa5sUK5m8-tAS7DRwugaqVdp+1Wvu_DEkRU5TfQtjE+w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 1/5] bpf, x86: Generate trampolines from bpf_tramp_links
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Sat, May 7, 2022 at 8:21 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Replace struct bpf_tramp_progs with struct bpf_tramp_links to collect
> struct bpf_tramp_link(s) for a trampoline.  struct bpf_tramp_link
> extends bpf_link to act as a linked list node.
>
> arch_prepare_bpf_trampoline() accepts a struct bpf_tramp_links to
> collects all bpf_tramp_link(s) that a trampoline should call.
>
> Change BPF trampoline and bpf_struct_ops to pass bpf_tramp_links
> instead of bpf_tramp_progs.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c    | 36 +++++++++--------
>  include/linux/bpf.h            | 36 +++++++++++------
>  include/linux/bpf_types.h      |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/bpf_struct_ops.c    | 69 ++++++++++++++++++++++----------
>  kernel/bpf/syscall.c           | 23 ++++-------
>  kernel/bpf/trampoline.c        | 73 +++++++++++++++++++---------------
>  net/bpf/bpf_dummy_struct_ops.c | 36 ++++++++++++++---
>  tools/bpf/bpftool/link.c       |  1 +
>  tools/include/uapi/linux/bpf.h |  1 +
>  10 files changed, 174 insertions(+), 103 deletions(-)
>

Two things that can be done as a follow up, otherwise LGTM:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> -int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_progs *tprogs,
> -                                     struct bpf_prog *prog,
> +static void bpf_struct_ops_link_release(struct bpf_link *link)
> +{
> +}
> +
> +static void bpf_struct_ops_link_dealloc(struct bpf_link *link)
> +{
> +       kfree(link);

This works by accident because struct bpf_link is at the top of struct
bpf_tramp_link. But to do this properly you'd need container_of() to
get struct bpf_tramp_link and then free that. I don't think it needs a
respin just for this, but please send a follow-up fix.

> +}
> +
> +static const struct bpf_link_ops bpf_struct_ops_link_lops = {
> +       .release = bpf_struct_ops_link_release,
> +       .dealloc = bpf_struct_ops_link_dealloc,
> +};
> +

[...]

> diff --git a/net/bpf/bpf_dummy_struct_ops.c b/net/bpf/bpf_dummy_struct_ops.c
> index d0e54e30658a..41552d6f1d23 100644
> --- a/net/bpf/bpf_dummy_struct_ops.c
> +++ b/net/bpf/bpf_dummy_struct_ops.c
> @@ -72,13 +72,28 @@ static int dummy_ops_call_op(void *image, struct bpf_dummy_ops_test_args *args)
>                     args->args[3], args->args[4]);
>  }
>
> +static void bpf_struct_ops_link_release(struct bpf_link *link)
> +{
> +}
> +
> +static void bpf_struct_ops_link_dealloc(struct bpf_link *link)
> +{
> +       kfree(link);
> +}
> +
> +static const struct bpf_link_ops bpf_struct_ops_link_lops = {
> +       .release = bpf_struct_ops_link_release,
> +       .dealloc = bpf_struct_ops_link_dealloc,
> +};
> +

You already defined this ops struct and release/dealloc implementation
in kernel/bpf/bpf_struct_ops.c, we need to reuse it here. Just make
the bpf_struct_ops.c's non-static and declare it in
include/linux/bpf.h. Again, don't think we need a respin just for
this, it's mostly code hygiene.

>  int bpf_struct_ops_test_run(struct bpf_prog *prog, const union bpf_attr *kattr,
>                             union bpf_attr __user *uattr)
>  {
>         const struct bpf_struct_ops *st_ops = &bpf_bpf_dummy_ops;
>         const struct btf_type *func_proto;
>         struct bpf_dummy_ops_test_args *args;
> -       struct bpf_tramp_progs *tprogs;
> +       struct bpf_tramp_links *tlinks;
> +       struct bpf_tramp_link *link = NULL;
>         void *image = NULL;
>         unsigned int op_idx;
>         int prog_ret;

[...]
