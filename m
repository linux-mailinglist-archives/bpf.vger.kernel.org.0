Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD8F264DD3
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 20:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgIJSxU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 14:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgIJSvs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 14:51:48 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F270C061573
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 11:51:42 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h206so4716758ybc.11
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2020 11:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xwsk4F7DUhzMzMPRnl04ued23KSydPQ1g3B192uJ1os=;
        b=Q//idA7S/siI2Ij+/mKu05BjboFITdpaDxYotfsRrLE1btXoCd4wiiTBVbgKePjn2o
         I3wiGzTR9wItMPNIr90nW8NlKCN9UuFKS0iQiOfPAmtRUl5XVKtqHnKRDzuTmlcKjfux
         +9PgRGIFHWTInLkgdN3eldqHABqRBEiT4+xiqyyQHIaDmRFIqTafP3uhF4NIebmBi2/S
         zgDVFFM0UYHtC8q5f9yqQV0mbd0mciHu8srisU/tmbvngbVjz2DN4n06oPtCdpshwEzm
         8fPVTG2/CcMAqrw3AO7uAZQFaB0sVlb2GteddjCAUp40P8NZ0SntJiAbtD9xY5H5tBto
         FY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xwsk4F7DUhzMzMPRnl04ued23KSydPQ1g3B192uJ1os=;
        b=EJkcNtUCpMVPX/gHQI7foTmj6PViXPCG8qCNj5T7scUzeVoGBj9lwCu45WnVAiWlM7
         TaSp/4Wkj4sezYk2ivbsx6ynbJb9DVuTRhDiO1LefLBN+rmIMCSUrfP58Gk0tFqgcn0K
         5MesruO4N8pTRwgnMD66K+R/Zf+jKrhWr883i19DI1oDJvOYKhm036v7Yn2RkrfvqeeD
         23zgyMFBqZF6pWXYczaiqmQ5/w2MeWeR2BKNWlCuj8uvIsMbp0KRbfOOw/C6QIEn5wbL
         WCARtojib8YQd2RBxTlVs5SfH334xea4zJyVIJiqrjKs1Wq6SPJEej7WIZqo6VeBRo3m
         pbPQ==
X-Gm-Message-State: AOAM530ZQp7nHAbPeKsPWjqUttMyyJbvis2suSRNnUZAHVJ7tZKkV88X
        2DV6bcZoOaY8DuBXqysPlLGNrmRt3lX1vuc6VnM=
X-Google-Smtp-Source: ABdhPJzx5aL37QejP/dzW55cqymKuIgD9pwuuYYr1uBqXGWXoqmfsU8UdFANpE7YBi53oQZB/cGoBsToe4Gs3Rv8myA=
X-Received: by 2002:a25:e655:: with SMTP id d82mr15943687ybh.347.1599763901530;
 Thu, 10 Sep 2020 11:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200909171155.256601-1-lmb@cloudflare.com> <20200909171155.256601-5-lmb@cloudflare.com>
 <20200909200309.psebk7iweqmugkcu@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200909200309.psebk7iweqmugkcu@kafai-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 10 Sep 2020 11:51:30 -0700
Message-ID: <CAEf4BzYg1jEwYiaKLv5Aaypx4AWnH_ACZk-zwibxUY=ByEXB3g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 04/11] bpf: allow specifying a BTF ID per
 argument in function protos
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 9, 2020 at 1:05 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Sep 09, 2020 at 06:11:48PM +0100, Lorenz Bauer wrote:
> > Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
> > which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
> > IDs, one for each argument. This array is only accessed up to the highest
> > numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
> > five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
> > is a function pointer that is called by the verifier if present. It gets the
> > actual BTF ID of the register, and the argument number we're currently checking.
> > It turns out that the only user check_arg_btf_id ignores the argument, and is
> > simply used to check whether the BTF ID has a struct sock_common at it's start.
> >
> > Replace both of these mechanisms with an explicit BTF ID for each argument
> > in a function proto. Thanks to btf_struct_ids_match this is very flexible:
> > check_arg_btf_id can be replaced by requiring struct sock_common.
>
> [ ... ]
>
> >  BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, ctx,
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c997f81c500b..7182c6e3eada 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -238,7 +238,6 @@ struct bpf_call_arg_meta {
> >       u64 msize_max_value;
> >       int ref_obj_id;
> >       int func_id;
> > -     u32 btf_id;
> >  };
> >
> >  struct btf *btf_vmlinux;
> > @@ -4002,29 +4001,23 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >                               goto err_type;
> >               }
> >       } else if (arg_type == ARG_PTR_TO_BTF_ID) {
> > -             bool ids_match = false;
> > +             const u32 *btf_id = fn->arg_btf_id[arg];
> >
> >               expected_type = PTR_TO_BTF_ID;
> >               if (type != expected_type)
> >                       goto err_type;
> > -             if (!fn->check_btf_id) {
> > -                     if (reg->btf_id != meta->btf_id) {
> > -                             ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> > -                                                              meta->btf_id);
> > -                             if (!ids_match) {
> > -                                     verbose(env, "Helper has type %s got %s in R%d\n",
> > -                                             kernel_type_name(meta->btf_id),
> > -                                             kernel_type_name(reg->btf_id), regno);
> > -                                     return -EACCES;
> > -                             }
> > -                     }
> > -             } else if (!fn->check_btf_id(reg->btf_id, arg)) {
> > -                     verbose(env, "Helper does not support %s in R%d\n",
> > -                             kernel_type_name(reg->btf_id), regno);
> >
> > +             if (!btf_id) {
> > +                     verbose(env, "verifier internal error: missing BTF ID\n");
> check_func_proto() could be a better place for this check.
>
> > +                     return -EFAULT;
> > +             }
> > +
> > +             if (!btf_struct_ids_match(&env->log, reg->off, reg->btf_id, *btf_id)) {
> > +                     verbose(env, "R%d has incompatible type %s\n", regno,
> > +                             kernel_type_name(reg->btf_id));
> >                       return -EACCES;
> >               }
> > -             if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
> > +             if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
> Removing "(reg->off && !ids_match)" looks fine to me since it is
> checked in btf_struct_ids_match().  Just want to highlight here
> to get more attention.


Yeah, I looked at this previously and this seems correct. Now
btf_struct_ids_match() is called unconditionally, so reg->var_off != 0
that doesn't match the desired BTF ID will cause failure above.

>
>
> >                       verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
> >                               regno);
> >                       return -EACCES;
> > @@ -4892,11 +4885,6 @@ static int check_helper_call(struct bpf_verifier_env *env, int func_id, int insn
> >       meta.func_id = func_id;
> >       /* check args */
> >       for (i = 0; i < 5; i++) {
> > -             if (!fn->check_btf_id) {
> > -                     err = btf_resolve_helper_id(&env->log, fn, i);
> > -                     if (err > 0)
> > -                             meta.btf_id = err;
> > -             }
> >               err = check_func_arg(env, i, &meta, fn);
> >               if (err)
> >                       return err;
>
> [ ... ]
>
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index a0d1a3265b71..442a34a7ee2b 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
> > @@ -357,6 +357,7 @@ const struct bpf_func_proto bpf_sk_storage_get_proto = {
> >       .ret_type       = RET_PTR_TO_MAP_VALUE_OR_NULL,
> >       .arg1_type      = ARG_CONST_MAP_PTR,
> >       .arg2_type      = ARG_PTR_TO_SOCKET,
> > +     .arg2_btf_id    = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> This change is not needed.  It is not taking ARG_PTR_TO_BTF_ID.
>
> >       .arg3_type      = ARG_PTR_TO_MAP_VALUE_OR_NULL,
> >       .arg4_type      = ARG_ANYTHING,
> >  };
> > @@ -377,21 +378,18 @@ const struct bpf_func_proto bpf_sk_storage_delete_proto = {
> >       .ret_type       = RET_INTEGER,
> >       .arg1_type      = ARG_CONST_MAP_PTR,
> >       .arg2_type      = ARG_PTR_TO_SOCKET,
> > +     .arg2_btf_id    = &btf_sock_ids[BTF_SOCK_TYPE_SOCK_COMMON],
> Same here.
>
> >  };
> >
> > -BTF_ID_LIST(sk_storage_btf_ids)
> > -BTF_ID_UNUSED
> > -BTF_ID(struct, sock)
> > -
> >  const struct bpf_func_proto sk_storage_get_btf_proto = {
> >       .func           = bpf_sk_storage_get,
> >       .gpl_only       = false,
> >       .ret_type       = RET_PTR_TO_MAP_VALUE_OR_NULL,
> >       .arg1_type      = ARG_CONST_MAP_PTR,
> >       .arg2_type      = ARG_PTR_TO_BTF_ID,
> > +     .arg2_btf_id    = &btf_sock_ids[BTF_SOCK_TYPE_SOCK],
> +1 in reusing btf_sock_ids.
>
> Others lgtm.
