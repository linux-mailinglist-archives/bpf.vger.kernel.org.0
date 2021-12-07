Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA646C329
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 19:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhLGSzz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 13:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236052AbhLGSzy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 13:55:54 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCCC061574
        for <bpf@vger.kernel.org>; Tue,  7 Dec 2021 10:52:23 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v22so62513qtx.8
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 10:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOjknt8bIoMR4hbBZzS5+f7WWs/FsnuN4+iyZssxFuY=;
        b=PqxuGRI4rnVD0jsh76rpEqb+7jObyk4ghczyGp1If+DU80aILA+OUMCgWNoVoJTbMB
         VOBD2Hm/vk+StmUPKp3a6QuK1/fwPX4RUTzejo6t5v8U4FiL+xgmg5+bTpeoB7yiUYgD
         yqDI91MWe7dxW96hC8MOs4CfNFIwnYqiBu5MvdiS7WD/mhKdRv6zNJK1q+guxnipl6rR
         yzpVK5aauvEuQ10bUr0Z8IFrtxf/Y8f9QeZpKLpTWN5f5jWnVW8VyVmZ81d9DrgtO6Te
         zbeoH/GRznJuQhiCJKYxY/lRFBznvSzaQGIhX3bXuVjI5Ba2CQKIFkXwfcwpKzz1suQQ
         7B/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOjknt8bIoMR4hbBZzS5+f7WWs/FsnuN4+iyZssxFuY=;
        b=Y8p3XWj4YnVJtdud7NtU6pHJEgnm30mgw0GQch2Y4PoemHhYWwpExT1AJ8EEBo1lF+
         CDwO2CC5dbxCvyp0P5DirOMImAidqG5bK++3BVuVkVaMw8HmRM5BDG1Of7XiAAn3YrD/
         kaphowTk7ykS8KRpdIlwYkvmMmDkTQe+6CqgM4pJ301Us3AIdYwJWA3zahY5krR6IsSt
         JYAqxE93rD+SQ5u4cCosC6369N/tHaZY9mEks5JNmQHXyc3IzCOMmCA3L7wPPNh5dP9b
         wlMp9DWIoO8pRbKzIqmSE/I+ZvFfsU783rdDVqLBQeazGP8DhrzxWY0fd3H++SxIq6f/
         Z27A==
X-Gm-Message-State: AOAM530cWsas0JD6QHBIX0hb7lzSykC2mmoKillTei887F08RPtn8rUp
        T9UQwKDYtGDJzuVjw6yRsLKiIlrx3W8gvi2BfMqUNg==
X-Google-Smtp-Source: ABdhPJxy16qp4oDbgYcVdmshm2iXT84PtVZIxRte7lbglsXfnASX0s7GGrE8hp79ZZlOXl37uWH7H5uJRSQQTLE1k+U=
X-Received: by 2002:ac8:7d08:: with SMTP id g8mr1442299qtb.142.1638903142894;
 Tue, 07 Dec 2021 10:52:22 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-3-haoluo@google.com>
 <CAEf4BzZUFZQvXm5uNCZ=Y_o2dak+c3jWANz0Q70wt_gyMUChQA@mail.gmail.com>
In-Reply-To: <CAEf4BzZUFZQvXm5uNCZ=Y_o2dak+c3jWANz0Q70wt_gyMUChQA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 7 Dec 2021 10:52:11 -0800
Message-ID: <CA+khW7j_5OWOPY2Q0e-UOP8vcKE4_OeKzE15+xjTOgyGgMSogA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/9] bpf: Replace ARG_XXX_OR_NULL with ARG_XXX
 | PTR_MAYBE_NULL
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Mon, Dec 6, 2021 at 9:45 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> >
> > We have introduced a new type to make bpf_arg composable, by
> > reserving high bits of bpf_arg to represent flags of a type.
> >
> > One of the flags is PTR_MAYBE_NULL which indicates a pointer
> > may be NULL. When applying this flag to an arg_type, it means
> > the arg can take NULL pointer. This patch switches the
> > qualified arg_types to use this flag. The arg_types changed
> > in this patch include:
> >
> > 1. ARG_PTR_TO_MAP_VALUE_OR_NULL
> > 2. ARG_PTR_TO_MEM_OR_NULL
> > 3. ARG_PTR_TO_CTX_OR_NULL
> > 4. ARG_PTR_TO_SOCKET_OR_NULL
> > 5. ARG_PTR_TO_ALLOC_MEM_OR_NULL
> > 6. ARG_PTR_TO_STACK_OR_NULL
> >
> > This patch does not eliminate the use of these arg_types, instead
> > it makes them an alias to the 'ARG_XXX | PTR_MAYBE_NULL'.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  include/linux/bpf.h   | 15 +++++++++------
> >  kernel/bpf/verifier.c | 39 ++++++++++++++-------------------------
> >  2 files changed, 23 insertions(+), 31 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index d8e6f8cd78a2..b0d063972091 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
[...]
> > @@ -5267,10 +5255,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                 err = check_helper_mem_access(env, regno,
> >                                               meta->map_ptr->key_size, false,
> >                                               NULL);
> > -       } else if (arg_type == ARG_PTR_TO_MAP_VALUE ||
> > -                  (arg_type == ARG_PTR_TO_MAP_VALUE_OR_NULL &&
> > -                   !register_is_null(reg)) ||
> > -                  arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> > +       } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE ||
> > +                  base_type(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> > +               if (type_may_be_null(arg_type) && register_is_null(reg))
> > +                       return err;
> > +
>
> small nit: return 0 would make it clear that we successfully checked
> everything (err is going to be zero here, but you need to scroll quite
> a lot up to check this, so it's a bit annoying).
>

Yes, that makes sense. Will do.

> >                 /* bpf_map_xxx(..., map_ptr, ..., value) call:
> >                  * check [value, value + map->value_size) validity
> >                  */
> > --
> > 2.34.1.400.ga245620fadb-goog
> >
