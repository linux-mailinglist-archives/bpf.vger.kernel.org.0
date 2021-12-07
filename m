Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F7A46B2A1
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 06:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhLGFzD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 00:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhLGFzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 00:55:03 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A755EC061746
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 21:51:33 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id f9so37850198ybq.10
        for <bpf@vger.kernel.org>; Mon, 06 Dec 2021 21:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ytf4siw3wbjhZKTxGmbXnkxalWvVdjWKA/SwxO8SVos=;
        b=TtwhCBkEw6bSP3fhlw5hq71KYBlkfI0HebMjxncsbKX+mSbIuZJaykV8FcC49+T8V3
         vpkV4DOUqKzU+/otmsadUUOAouFfwqS6cpOKPYU7MVoSlTsy2qrL6fyP8Wos4AcMwJtw
         JCdi+UBPUmDEtyS1LKd2iyMX/P3YEXGJBRLm/l81jdz4ZIsWFDEllHdGf8azqoN5Eexp
         JwMmT6YjKbkvoWdFDCEnxw7aR58iiikuq1l4EGvC3jDEOgwLQLrbMaE2xfDfzH3dxVdb
         kebbEpseTmFMr3zAZdIXiqzT0KQiYUIUhSHG+9buw0jrZuv6Q8SVjRyB+WLLNk3wFPsN
         Td1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ytf4siw3wbjhZKTxGmbXnkxalWvVdjWKA/SwxO8SVos=;
        b=gx6LxpgwA0vYI0i/vyJj4nwdH2jrChQ/KWIkJGbNpqJl9dlWGNT3ZxymHIxgIw5sEC
         rumugf+rU81BLz71a6tbppEQZHtv59rv7WxwMSEoZQK5uZcpm19oGnS7YdhGo5IcLZe+
         30DWHmAQOGQQNFDSQdn1FvLKL7uoereRGHcyrwVgxigrfBax18c0lnPTz9osXyEAv82p
         tY4jJC7GIqcfokx5la+lXrybZXpOohW954qJ/rqJ4ghpNkjc59964zYmxN1Eaxk9VvBL
         gkCYUXTRLBSCPLGaVS5Bw8w4PB6KvJgP+yu2oruXROQOl81k0xv41FVnHC2Es5bfG39T
         WLZw==
X-Gm-Message-State: AOAM532W+1KnARKY6rbjazqe9Yhl4mAGDXNJRMzT1A8AV9a0tCJspIsv
        y6MRmvL+n18nqfVUQerTCXIVPGw/E01z8o03HqA=
X-Google-Smtp-Source: ABdhPJzn1Yz1MrSLS2ZcUJAYdNd42mCW8gULGaS70nANwMfTF7ntr6FBujtHmCRgauaqOXopU1NS0Pwyle4zLzsLQfs=
X-Received: by 2002:a25:54e:: with SMTP id 75mr46311196ybf.393.1638856292842;
 Mon, 06 Dec 2021 21:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-4-haoluo@google.com>
In-Reply-To: <20211206232227.3286237-4-haoluo@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 6 Dec 2021 21:51:21 -0800
Message-ID: <CAEf4BzZShouPUqbjr6fzqSy=Lp3Y36KTkFm6OaNSE=N0V9+_Xw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/9] bpf: Replace RET_XXX_OR_NULL with RET_XXX
 | PTR_MAYBE_NULL
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
>
> We have introduced a new type to make bpf_ret composable, by
> reserving high bits to represent flags.
>
> One of the flag is PTR_MAYBE_NULL, which indicates a pointer
> may be NULL. When applying this flag to ret_types, it means
> the returned value could be a NULL pointer. This patch
> switches the qualified arg_types to use this flag.
> The ret_types changed in this patch include:
>
> 1. RET_PTR_TO_MAP_VALUE_OR_NULL
> 2. RET_PTR_TO_SOCKET_OR_NULL
> 3. RET_PTR_TO_TCP_SOCK_OR_NULL
> 4. RET_PTR_TO_SOCK_COMMON_OR_NULL
> 5. RET_PTR_TO_ALLOC_MEM_OR_NULL
> 6. RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL
> 7. RET_PTR_TO_BTF_ID_OR_NULL
>
> This patch doesn't eliminate the use of these names, instead
> it makes them aliases to 'RET_PTR_TO_XXX | PTR_MAYBE_NULL'.
>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  include/linux/bpf.h   | 19 ++++++++++------
>  kernel/bpf/helpers.c  |  2 +-
>  kernel/bpf/verifier.c | 52 +++++++++++++++++++++----------------------
>  3 files changed, 39 insertions(+), 34 deletions(-)
>

[...]

> @@ -6570,28 +6570,28 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                                 return -EINVAL;
>                         }
>                         regs[BPF_REG_0].type =
> -                               fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
> -                               PTR_TO_MEM : PTR_TO_MEM_OR_NULL;
> +                               (ret_type & PTR_MAYBE_NULL) ?
> +                               PTR_TO_MEM_OR_NULL : PTR_TO_MEM;

nit: I expected something like (let's use the fact that those flags
are the same across different enums):

regs[BPF_REG_0].type = PTR_TO_MEM | (ret_type & PTR_MAYBE_NULL);


>                         regs[BPF_REG_0].mem_size = tsize;
>                 } else {
>                         regs[BPF_REG_0].type =
> -                               fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
> -                               PTR_TO_BTF_ID : PTR_TO_BTF_ID_OR_NULL;
> +                               (ret_type & PTR_MAYBE_NULL) ?
> +                               PTR_TO_BTF_ID_OR_NULL : PTR_TO_BTF_ID;

same as above

>                         regs[BPF_REG_0].btf = meta.ret_btf;
>                         regs[BPF_REG_0].btf_id = meta.ret_btf_id;
>                 }
> -       } else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL ||
> -                  fn->ret_type == RET_PTR_TO_BTF_ID) {
> +       } else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
>                 int ret_btf_id;
>
>                 mark_reg_known_zero(env, regs, BPF_REG_0);
> -               regs[BPF_REG_0].type = fn->ret_type == RET_PTR_TO_BTF_ID ?
> -                                                    PTR_TO_BTF_ID :
> -                                                    PTR_TO_BTF_ID_OR_NULL;
> +               regs[BPF_REG_0].type = (ret_type & PTR_MAYBE_NULL) ?
> +                                                    PTR_TO_BTF_ID_OR_NULL :
> +                                                    PTR_TO_BTF_ID;

and here


>                 ret_btf_id = *fn->ret_btf_id;
>                 if (ret_btf_id == 0) {
> -                       verbose(env, "invalid return type %d of func %s#%d\n",
> -                               fn->ret_type, func_id_name(func_id), func_id);
> +                       verbose(env, "invalid return type %lu of func %s#%d\n",
> +                               base_type(ret_type), func_id_name(func_id),

base type returns u32, shouldn't it be %u then?

> +                               func_id);
>                         return -EINVAL;
>                 }
>                 /* current BPF helper definitions are only coming from
> @@ -6600,8 +6600,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 regs[BPF_REG_0].btf = btf_vmlinux;
>                 regs[BPF_REG_0].btf_id = ret_btf_id;
>         } else {
> -               verbose(env, "unknown return type %d of func %s#%d\n",
> -                       fn->ret_type, func_id_name(func_id), func_id);
> +               verbose(env, "unknown return type %lu of func %s#%d\n",
> +                       base_type(ret_type), func_id_name(func_id), func_id);

same %u

>                 return -EINVAL;
>         }
>
> --
> 2.34.1.400.ga245620fadb-goog
>
