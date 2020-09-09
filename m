Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BBF262CDF
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 12:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIIKLQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 06:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIIKLO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Sep 2020 06:11:14 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7AFC061573
        for <bpf@vger.kernel.org>; Wed,  9 Sep 2020 03:11:13 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x69so1785912oia.8
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2020 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m5r0lq+bVp+bdBuAcY850+ZKYdcvmwZyABG38qYicSM=;
        b=XFKp1QCBn5/uZQP0xFaDejyeEa8JkK72aE0+95j5mlkL7ns6CigDMOyWLgCcYxoZn4
         xi/FmDy2NcgEr8Akn6whN6GNgyiLZII5Fft3WGzUBr/TjfY4uY+z/R4+JgUUbJl4ly1b
         q9XGY3x+ESjflib2ADGlODLt4xZBRGGlJWuao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5r0lq+bVp+bdBuAcY850+ZKYdcvmwZyABG38qYicSM=;
        b=e/r/WJcxVr8hfC/yekUjgwbihBuFcOWkNNgCuai+/jwA95MmQH+TLOmdozM9W5E3bD
         hJTAXF+2HGPlJVuusmIU/gcEck14NXPrbKWVdvR5ha6WImdGa1kQRkve+kTwF9vCGja4
         wrj8ntO8QSc56T3fj/pzdhK44yq9SkpJCaydRv09MeZf815Hg/Cf6jh2qeKWd8uC5Qv2
         IlfHnf0N8JIFSyfzJMWnvzNbhiTJi7RH1eG3fX3OwGeK1X9O6TAYn1kbdkogVoWP/y43
         totIJm0eDiy4Hc/1QZ1aSiJWziw6RrQ9FXR+cMlQzTrzFTCd2VvV6ShcnShgKKUcekxB
         RuyA==
X-Gm-Message-State: AOAM532J9TzitUGOvu2rk+KJk1oKEktXI0tbp6XSVJ+dVwxaBFD2O0Ev
        lZmjZM4Eoa4eLJcpXUTlV3xlERGn+YB6MUiUo5k/wA==
X-Google-Smtp-Source: ABdhPJyidptOpO5wf5usFPIUFm67sJ9wtOTWeF2F7Kc1jmollsn8YepsBhCaki5Mp4FLbss3+01AC4f1E+/pEoyjcVg=
X-Received: by 2002:aca:3e8b:: with SMTP id l133mr134090oia.110.1599646273085;
 Wed, 09 Sep 2020 03:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200904112401.667645-1-lmb@cloudflare.com> <20200904112401.667645-6-lmb@cloudflare.com>
 <CAEf4BzbPJKK+YPTgPmaUVsKg3GQdwJKypfSZXg09M+sY8BzDbQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbPJKK+YPTgPmaUVsKg3GQdwJKypfSZXg09M+sY8BzDbQ@mail.gmail.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 9 Sep 2020 11:11:01 +0100
Message-ID: <CACAyw9-qL5SfsbtYrRcN5wNjzOBUj0Dct2KNQ8J-Tp0KMSNwkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/11] bpf: allow specifying a set of BTF IDs for
 helper arguments
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 9 Sep 2020 at 05:47, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Sep 4, 2020 at 4:30 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
> >
> > Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
> > which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
> > IDs, one for each argument. This array is only accessed up to the highest
> > numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
> > five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
> > is a function pointer that is called by the verifier if present. It gets the
> > actual BTF ID of the register, and the argument number we're currently checking.
> > It turns out that the only user check_arg_btf_id ignores the argument, and is
> > simply used to check whether the BTF ID matches one of the socket types.
> >
> > Replace both of these mechanisms with explicit btf_id_sets for each argument
> > in a function proto. The verifier can now check that a PTR_TO_BTF_ID is one
> > of several IDs, and the code that does the type checking becomes simpler.
> >
> > Add a small optimisation to btf_set_contains for the common case of a set with
> > a single entry.
> >
> > Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
> > ---
>
> You are replacing a more generic and powerful capability with a more
> restricted one because no one is yet using a generic one fully. It
> might be ok and we'll never need a more generic way to check BTF IDs.
> But it will be funny if we will be adding this back soon because a
> static set of BTF IDs don't cut it for some cases :)
>
> I don't mind this change, but I wonder what others think about this.
>
> >  include/linux/bpf.h            | 22 ++++++++++---------
> >  kernel/bpf/bpf_inode_storage.c |  8 +++----
> >  kernel/bpf/btf.c               | 22 ++++++-------------
> >  kernel/bpf/stackmap.c          |  5 +++--
> >  kernel/bpf/verifier.c          | 39 +++++++++++++---------------------
> >  kernel/trace/bpf_trace.c       | 15 +++++++------
> >  net/core/bpf_sk_storage.c      | 10 +++++----
> >  net/core/filter.c              | 31 ++++++++++-----------------
> >  net/ipv4/bpf_tcp_ca.c          | 24 +++++++++------------
> >  9 files changed, 76 insertions(+), 100 deletions(-)
> >
>
> [...]
>
> > diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
> > index 75be02799c0f..d447d2655cce 100644
> > --- a/kernel/bpf/bpf_inode_storage.c
> > +++ b/kernel/bpf/bpf_inode_storage.c
> > @@ -249,9 +249,9 @@ const struct bpf_map_ops inode_storage_map_ops = {
> >         .map_owner_storage_ptr = inode_storage_ptr,
> >  };
> >
> > -BTF_ID_LIST(bpf_inode_storage_btf_ids)
> > -BTF_ID_UNUSED
> > +BTF_SET_START(bpf_inode_storage_btf_ids)
> >  BTF_ID(struct, inode)
> > +BTF_SET_END(bpf_inode_storage_btf_ids)
>
> with your change single-element BTF ID set becomes a very common case,
> so having a simple macro that combines BTF_SET_START + BTF_ID +
> BTF_SET_END in one simple macro would be useful, I think

Good idea. If Martin's idea pans out I'll add something similar for
BTF_ID_LIST instead.

>
> >
> >  const struct bpf_func_proto bpf_inode_storage_get_proto = {
> >         .func           = bpf_inode_storage_get,
> > @@ -259,9 +259,9 @@ const struct bpf_func_proto bpf_inode_storage_get_proto = {
> >         .ret_type       = RET_PTR_TO_MAP_VALUE_OR_NULL,
> >         .arg1_type      = ARG_CONST_MAP_PTR,
> >         .arg2_type      = ARG_PTR_TO_BTF_ID,
> > +       .arg2_btf_ids   = &bpf_inode_storage_btf_ids,
> >         .arg3_type      = ARG_PTR_TO_MAP_VALUE_OR_NULL,
> >         .arg4_type      = ARG_ANYTHING,
> > -       .btf_id         = bpf_inode_storage_btf_ids,
> >  };
> >
>
> [...]
>
> > @@ -4065,26 +4066,21 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> >         }
> >
> >         if (type == PTR_TO_BTF_ID) {
> > -               bool ids_match = false;
> > +               if (fn->arg_btf_ids[arg])
> > +                       btf_ids = fn->arg_btf_ids[arg];
>
> nit: no need for the if part, just assign directly, even if its NULL

There is a purpose here: btf_ids can be inferred from the arg_type (in
this set PTR_TO_SOCKET). However, function prototype declarations take
precedence over arg_type.

Maybe I should add a comment here? Or prevent this outright? There is
currently no user of this.

>
> >
> > -               if (!fn->check_btf_id) {
> > -                       if (reg->btf_id != meta->btf_id) {
> > -                               ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> > -                                                                meta->btf_id);
> > -                               if (!ids_match) {
> > -                                       verbose(env, "Helper has type %s got %s in R%d\n",
> > -                                               kernel_type_name(meta->btf_id),
> > -                                               kernel_type_name(reg->btf_id), regno);
> > -                                       return -EACCES;
> > -                               }
> > -                       }
> > -               } else if (!fn->check_btf_id(reg->btf_id, arg)) {
> > -                       verbose(env, "Helper does not support %s in R%d\n",
> > -                               kernel_type_name(reg->btf_id), regno);
> > +               if (!btf_ids) {
> > +                       verbose(env, "verifier internal error: missing BTF IDs\n");
> > +                       return -EFAULT;
> > +               }
> >
> > +               if (!btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> > +                                         btf_ids)) {
> > +                       verbose(env, "R%d has incompatible type %s\n", regno,
> > +                               kernel_type_name(reg->btf_id));
> >                         return -EACCES;
> >                 }
> > -               if ((reg->off && !ids_match) || !tnum_is_const(reg->var_off) || reg->var_off.value) {
> > +               if (!tnum_is_const(reg->var_off) || reg->var_off.value) {
> >                         verbose(env, "R%d is a pointer to in-kernel struct with non-zero offset\n",
> >                                 regno);
> >                         return -EACCES;
>
> [...]



-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
