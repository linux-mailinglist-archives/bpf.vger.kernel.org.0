Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FC046C352
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 20:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbhLGTJj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 14:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbhLGTJj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 14:09:39 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8077AC061746
        for <bpf@vger.kernel.org>; Tue,  7 Dec 2021 11:06:08 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id p19so77901qtw.12
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 11:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6wtX8oRkE0II5AlCGiC7oLLyGh9CPLpmHfUwi1ajH0=;
        b=HZyHVcgUuD2lcc1oTXvGBAUMap9UEzk62+HCdbYI60c12cMMNTlQaGdfrq93r2PVVA
         Q/RhWHUd+CcLu/5CIIUXKyHyJY6hGEMVOmNEd4qiEXbQTk/6njaN9fy2kCBD36H6tMHY
         e99JBBryOnwL/ROp8GLzGD8/aUtjjm9H7xLJTihpDT3MVGTZaPmPvoiFL4bnKheMH8Tf
         mbisNXQbUjSQL4xNVMX02VhRU3uEs3L5m2iaMDus+Z6lmxRnb25MQVDG7QqTvw/LZYf5
         T3HQG40kAF08F7nfQ5oZb3Rc8DMELRtKnCpRWPh4ToJfqohYphxkPeROf1vSb8RHxgV7
         QFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6wtX8oRkE0II5AlCGiC7oLLyGh9CPLpmHfUwi1ajH0=;
        b=LITcSWh3FEYwUz12d9FGoD8NJc+CqK0kXcB7U9pUU0te14Pc75T0bcAKabtlHfaUeX
         AUGf87LcFFy5AGxv/mkgzc1eYPabzzt6kaHAp2ob4GaCMIMKUW/wySUOS0CyhLAwwK4s
         iCyH76RldajjYdg3be1y0+0f9Ydbzj6mhCDHtKRzshT+pKreohSS62y976nrA/U9zxM/
         P3lYL0ttddXits2MskEmlsWsKLel3Ekhkv4doQZySwxZCbSjohD8ag4CFiKHBbr2bZlq
         BUnqIOtTfZKcd4zxOtk6OQV4NNTVDGHAcVgjIMq6dGaRqmwQnKyKKmYVu87lWtRr6W0S
         7pxQ==
X-Gm-Message-State: AOAM531IptSDcO+87Cv6muwJe4VOKIuKquXuxcXwA9h7AyhtsHkeLck5
        67f5HgS3Vpv2U+y136S2TqfXAIbmozNCEPZ0o6EQfA==
X-Google-Smtp-Source: ABdhPJwkRMXrUtuoNV6EB6H3Dyq9Uv/XoJktCggsMmndi7d4/2q54ofQy8Do+RJkws7Ub8FwFk15QtvWJasVAX55q80=
X-Received: by 2002:ac8:5b82:: with SMTP id a2mr1495072qta.519.1638903967298;
 Tue, 07 Dec 2021 11:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20211206232227.3286237-1-haoluo@google.com> <20211206232227.3286237-4-haoluo@google.com>
 <CAEf4BzZShouPUqbjr6fzqSy=Lp3Y36KTkFm6OaNSE=N0V9+_Xw@mail.gmail.com>
In-Reply-To: <CAEf4BzZShouPUqbjr6fzqSy=Lp3Y36KTkFm6OaNSE=N0V9+_Xw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 7 Dec 2021 11:05:56 -0800
Message-ID: <CA+khW7ha6xCR8PGdrHpZRbkkFHCqT-V0kSXxzXR47zOz5e46WQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/9] bpf: Replace RET_XXX_OR_NULL with RET_XXX
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

On Mon, Dec 6, 2021 at 9:51 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 6, 2021 at 3:22 PM Hao Luo <haoluo@google.com> wrote:
> >
> > We have introduced a new type to make bpf_ret composable, by
> > reserving high bits to represent flags.
> >
> > One of the flag is PTR_MAYBE_NULL, which indicates a pointer
> > may be NULL. When applying this flag to ret_types, it means
> > the returned value could be a NULL pointer. This patch
> > switches the qualified arg_types to use this flag.
> > The ret_types changed in this patch include:
> >
> > 1. RET_PTR_TO_MAP_VALUE_OR_NULL
> > 2. RET_PTR_TO_SOCKET_OR_NULL
> > 3. RET_PTR_TO_TCP_SOCK_OR_NULL
> > 4. RET_PTR_TO_SOCK_COMMON_OR_NULL
> > 5. RET_PTR_TO_ALLOC_MEM_OR_NULL
> > 6. RET_PTR_TO_MEM_OR_BTF_ID_OR_NULL
> > 7. RET_PTR_TO_BTF_ID_OR_NULL
> >
> > This patch doesn't eliminate the use of these names, instead
> > it makes them aliases to 'RET_PTR_TO_XXX | PTR_MAYBE_NULL'.
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> >  include/linux/bpf.h   | 19 ++++++++++------
> >  kernel/bpf/helpers.c  |  2 +-
> >  kernel/bpf/verifier.c | 52 +++++++++++++++++++++----------------------
> >  3 files changed, 39 insertions(+), 34 deletions(-)
> >
>
> [...]
>
> > @@ -6570,28 +6570,28 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                                 return -EINVAL;
> >                         }
> >                         regs[BPF_REG_0].type =
> > -                               fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
> > -                               PTR_TO_MEM : PTR_TO_MEM_OR_NULL;
> > +                               (ret_type & PTR_MAYBE_NULL) ?
> > +                               PTR_TO_MEM_OR_NULL : PTR_TO_MEM;
>
> nit: I expected something like (let's use the fact that those flags
> are the same across different enums):
>
> regs[BPF_REG_0].type = PTR_TO_MEM | (ret_type & PTR_MAYBE_NULL);
>

We haven't taught reg_type to recognize PTR_MAYBE_NULL until the next
patch. Patch 4/9 does have the suggested conversion:

regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;

>
> >                         regs[BPF_REG_0].mem_size = tsize;
> >                 } else {
> >                         regs[BPF_REG_0].type =
> > -                               fn->ret_type == RET_PTR_TO_MEM_OR_BTF_ID ?
> > -                               PTR_TO_BTF_ID : PTR_TO_BTF_ID_OR_NULL;
> > +                               (ret_type & PTR_MAYBE_NULL) ?
> > +                               PTR_TO_BTF_ID_OR_NULL : PTR_TO_BTF_ID;
>
> same as above
>
> >                         regs[BPF_REG_0].btf = meta.ret_btf;
> >                         regs[BPF_REG_0].btf_id = meta.ret_btf_id;
> >                 }
> > -       } else if (fn->ret_type == RET_PTR_TO_BTF_ID_OR_NULL ||
> > -                  fn->ret_type == RET_PTR_TO_BTF_ID) {
> > +       } else if (base_type(ret_type) == RET_PTR_TO_BTF_ID) {
> >                 int ret_btf_id;
> >
> >                 mark_reg_known_zero(env, regs, BPF_REG_0);
> > -               regs[BPF_REG_0].type = fn->ret_type == RET_PTR_TO_BTF_ID ?
> > -                                                    PTR_TO_BTF_ID :
> > -                                                    PTR_TO_BTF_ID_OR_NULL;
> > +               regs[BPF_REG_0].type = (ret_type & PTR_MAYBE_NULL) ?
> > +                                                    PTR_TO_BTF_ID_OR_NULL :
> > +                                                    PTR_TO_BTF_ID;
>
> and here
>
>
> >                 ret_btf_id = *fn->ret_btf_id;
> >                 if (ret_btf_id == 0) {
> > -                       verbose(env, "invalid return type %d of func %s#%d\n",
> > -                               fn->ret_type, func_id_name(func_id), func_id);
> > +                       verbose(env, "invalid return type %lu of func %s#%d\n",
> > +                               base_type(ret_type), func_id_name(func_id),
>
> base type returns u32, shouldn't it be %u then?
>

Ack, you are right. When writing this, I know '%lu' will work but
didn't give it much thought. Will use '%u' in v2.

> > +                               func_id);
> >                         return -EINVAL;
> >                 }
> >                 /* current BPF helper definitions are only coming from
> > @@ -6600,8 +6600,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                 regs[BPF_REG_0].btf = btf_vmlinux;
> >                 regs[BPF_REG_0].btf_id = ret_btf_id;
> >         } else {
> > -               verbose(env, "unknown return type %d of func %s#%d\n",
> > -                       fn->ret_type, func_id_name(func_id), func_id);
> > +               verbose(env, "unknown return type %lu of func %s#%d\n",
> > +                       base_type(ret_type), func_id_name(func_id), func_id);
>
> same %u
>
> >                 return -EINVAL;
> >         }
> >
> > --
> > 2.34.1.400.ga245620fadb-goog
> >
