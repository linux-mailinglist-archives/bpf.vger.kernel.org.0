Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B75572AA6
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 03:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiGMBKc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 21:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiGMBKa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 21:10:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981A2D0E07
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:10:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sz17so17268844ejc.9
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 18:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcTOkAxvQFt++u/l70fRiL4oJn11MGaNm9vQR6EcLVQ=;
        b=LIFZ9HYYF8RqcWGQ1GdVtUjlXvhKsSQ/U5vc4KgxbIlrP9iWkiQyP13gdFEm7VWP4E
         ksA0SmCeBtmpocXFpdWNRUBsLs+gYwsvlXEPjT5ovwi9+hMC29+N00XlunAz6qe5yDBV
         RwF7WqvrdW8KKqfTrFSTNAQgOAOWRL/wC92ewWdx5/lLuxHGe9wsi1QnPLJ+nhSWCHTA
         i1UL7uqFLcEx2TI1yYhIhNwztywnibwqEsXzIv+Gl3GvO4neestXE/uVfk4MAwY/LbSV
         LfI3Gk/1Iv0SZ5VdOoNwdFm9gPfAvmWXUW95p5Pez+V+fJe142QP8dxoynIBNIgvnskM
         ueFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcTOkAxvQFt++u/l70fRiL4oJn11MGaNm9vQR6EcLVQ=;
        b=O+PyCf929+3wiPUPXkumvHCHC0hN0RqSjbwR16W0FemRwn4G/WpjSwxicH47bsV6lF
         fQbuW7BjTznQY9yCH+AiTGK3/5PLK3+lYAZhYFQPxrJFmjefZICPq/RrZHPnNEIV0JHj
         V7IPhp0LANbl9SKXENZDrM6nYC74uJhXLjGB9RIMS+vf1jIXIHM106tls9oVu3MwqmNc
         /4+LZyDirPNCOCsBwwLGiU35qe0ZYG6HhyfbKRE998G87dWXA45OvPOJN1r1cpUZFxoL
         ZwZuygrT9ihkkMNk5RoPMZAq9msuljAR34ovo8s7MARXSHBG3G40zbWTkWjHnDXoBKN0
         BBqg==
X-Gm-Message-State: AJIora8UE/NfiZVRMeyGn3DI+zi7NuzXYKqtyi0CuMzyrY3ny2XJx0z6
        Xsp4o7Qoh8ynSrrIapkiQDuJ+En2650tuiOE/c8=
X-Google-Smtp-Source: AGRyM1ucbqniFO26hbwwd89+OnMzrQI4fKVyipp3J7P2+sryMx/lOKQjNn7E26ozAAZOPIK+c3RAiSDnStLKueMY84o=
X-Received: by 2002:a17:907:608f:b0:72b:7db9:4dc6 with SMTP id
 ht15-20020a170907608f00b0072b7db94dc6mr828239ejc.463.1657674628151; Tue, 12
 Jul 2022 18:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220712210603.123791-1-joannelkoong@gmail.com> <Ys35McCz+TZEdorp@google.com>
In-Reply-To: <Ys35McCz+TZEdorp@google.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 12 Jul 2022 18:10:17 -0700
Message-ID: <CAJnrk1bVEBXUUjp71+VFaYrRqsDharKRfpvb1theJQ-fP5+EKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: Tidy up verifier check_func_arg()
To:     sdf@google.com
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
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

On Tue, Jul 12, 2022 at 3:44 PM <sdf@google.com> wrote:
>
> On 07/12, Joanne Koong wrote:
> > This patch does two things:
>
> > 1. For matching against the arg type, the match should be against the
> > base type of the arg type, since the arg type can have different
> > bpf_type_flags set on it.
>
> Does this need a fixes tag? Something around the following maybe:
>
> Fixes: d639b9d13a39 ("bpf: Introduce composable reg, ret and arg types.")
>
> ?
I will add that tag. Thanks!
>
> > 2. Uses switch casing to improve readability + efficiency.
>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >   kernel/bpf/verifier.c | 66 +++++++++++++++++++++++++------------------
> >   1 file changed, 38 insertions(+), 28 deletions(-)
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 328cfab3af60..26e7e787c20a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -5533,17 +5533,6 @@ static bool arg_type_is_mem_size(enum bpf_arg_type
> > type)
> >              type == ARG_CONST_SIZE_OR_ZERO;
> >   }
>
> > -static bool arg_type_is_alloc_size(enum bpf_arg_type type)
> > -{
> > -     return type == ARG_CONST_ALLOC_SIZE_OR_ZERO;
> > -}
> > -
> > -static bool arg_type_is_int_ptr(enum bpf_arg_type type)
> > -{
> > -     return type == ARG_PTR_TO_INT ||
> > -            type == ARG_PTR_TO_LONG;
> > -}
> > -
> >   static bool arg_type_is_release(enum bpf_arg_type type)
> >   {
> >       return type & OBJ_RELEASE;
> > @@ -5929,7 +5918,8 @@ static int check_func_arg(struct bpf_verifier_env
> > *env, u32 arg,
> >               meta->ref_obj_id = reg->ref_obj_id;
> >       }
>
> > -     if (arg_type == ARG_CONST_MAP_PTR) {
> > +     switch (base_type(arg_type)) {
> > +     case ARG_CONST_MAP_PTR:
> >               /* bpf_map_xxx(map_ptr) call: remember that map_ptr */
> >               if (meta->map_ptr) {
> >                       /* Use map_uid (which is unique id of inner map) to reject:
> > @@ -5954,7 +5944,8 @@ static int check_func_arg(struct bpf_verifier_env
> > *env, u32 arg,
> >               }
> >               meta->map_ptr = reg->map_ptr;
> >               meta->map_uid = reg->map_uid;
> > -     } else if (arg_type == ARG_PTR_TO_MAP_KEY) {
> > +             break;
> > +     case ARG_PTR_TO_MAP_KEY:
> >               /* bpf_map_xxx(..., map_ptr, ..., key) call:
> >                * check that [key, key + map->key_size) are within
> >                * stack limits and initialized
> > @@ -5971,7 +5962,8 @@ static int check_func_arg(struct bpf_verifier_env
> > *env, u32 arg,
> >               err = check_helper_mem_access(env, regno,
> >                                             meta->map_ptr->key_size, false,
> >                                             NULL);
> > -     } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE) {
> > +             break;
> > +     case ARG_PTR_TO_MAP_VALUE:
> >               if (type_may_be_null(arg_type) && register_is_null(reg))
> >                       return 0;
>
> > @@ -5987,14 +5979,16 @@ static int check_func_arg(struct bpf_verifier_env
> > *env, u32 arg,
> >               err = check_helper_mem_access(env, regno,
> >                                             meta->map_ptr->value_size, false,
> >                                             meta);
> > -     } else if (arg_type == ARG_PTR_TO_PERCPU_BTF_ID) {
> > +             break;
> > +     case ARG_PTR_TO_PERCPU_BTF_ID:
> >               if (!reg->btf_id) {
> >                       verbose(env, "Helper has invalid btf_id in R%d\n", regno);
> >                       return -EACCES;
> >               }
> >               meta->ret_btf = reg->btf;
> >               meta->ret_btf_id = reg->btf_id;
> > -     } else if (arg_type == ARG_PTR_TO_SPIN_LOCK) {
> > +             break;
> > +     case ARG_PTR_TO_SPIN_LOCK:
> >               if (meta->func_id == BPF_FUNC_spin_lock) {
> >                       if (process_spin_lock(env, regno, true))
> >                               return -EACCES;
> > @@ -6005,12 +5999,15 @@ static int check_func_arg(struct bpf_verifier_env
> > *env, u32 arg,
> >                       verbose(env, "verifier internal error\n");
> >                       return -EFAULT;
> >               }
> > -     } else if (arg_type == ARG_PTR_TO_TIMER) {
> > +             break;
> > +     case ARG_PTR_TO_TIMER:
> >               if (process_timer_func(env, regno, meta))
> >                       return -EACCES;
> > -     } else if (arg_type == ARG_PTR_TO_FUNC) {
> > +             break;
> > +     case ARG_PTR_TO_FUNC:
> >               meta->subprogno = reg->subprogno;
> > -     } else if (base_type(arg_type) == ARG_PTR_TO_MEM) {
> > +             break;
> > +     case ARG_PTR_TO_MEM:
> >               /* The access to this pointer is only checked when we hit the
> >                * next is_mem_size argument below.
> >                */
> > @@ -6020,11 +6017,14 @@ static int check_func_arg(struct bpf_verifier_env
> > *env, u32 arg,
> >                                                     fn->arg_size[arg], false,
> >                                                     meta);
> >               }
> > -     } else if (arg_type_is_mem_size(arg_type)) {
> > -             bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
> > -
> > -             err = check_mem_size_reg(env, reg, regno, zero_size_allowed, meta);
> > -     } else if (arg_type_is_dynptr(arg_type)) {
> > +             break;
> > +     case ARG_CONST_SIZE:
> > +             err = check_mem_size_reg(env, reg, regno, false, meta);
> > +             break;
> > +     case ARG_CONST_SIZE_OR_ZERO:
> > +             err = check_mem_size_reg(env, reg, regno, true, meta);
> > +             break;
> > +     case ARG_PTR_TO_DYNPTR:
> >               if (arg_type & MEM_UNINIT) {
> >                       if (!is_dynptr_reg_valid_uninit(env, reg)) {
> >                               verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> > @@ -6058,21 +6058,28 @@ static int check_func_arg(struct bpf_verifier_env
> > *env, u32 arg,
> >                               err_extra, arg + 1);
> >                       return -EINVAL;
> >               }
> > -     } else if (arg_type_is_alloc_size(arg_type)) {
> > +             break;
> > +     case ARG_CONST_ALLOC_SIZE_OR_ZERO:
> >               if (!tnum_is_const(reg->var_off)) {
> >                       verbose(env, "R%d is not a known constant'\n",
> >                               regno);
> >                       return -EACCES;
> >               }
> >               meta->mem_size = reg->var_off.value;
> > -     } else if (arg_type_is_int_ptr(arg_type)) {
> > +             break;
> > +     case ARG_PTR_TO_INT:
> > +     case ARG_PTR_TO_LONG:
> > +     {
> >               int size = int_ptr_type_to_size(arg_type);
>
> >               err = check_helper_mem_access(env, regno, size, false, meta);
> >               if (err)
> >                       return err;
> >               err = check_ptr_alignment(env, reg, 0, size, true);
> > -     } else if (arg_type == ARG_PTR_TO_CONST_STR) {
> > +             break;
> > +     }
> > +     case ARG_PTR_TO_CONST_STR:
> > +     {
> >               struct bpf_map *map = reg->map_ptr;
> >               int map_off;
> >               u64 map_addr;
> > @@ -6111,9 +6118,12 @@ static int check_func_arg(struct bpf_verifier_env
> > *env, u32 arg,
> >                       verbose(env, "string is not zero-terminated\n");
> >                       return -EINVAL;
> >               }
> > -     } else if (arg_type == ARG_PTR_TO_KPTR) {
> > +             break;
> > +     }
> > +     case ARG_PTR_TO_KPTR:
> >               if (process_kptr_func(env, regno, meta))
> >                       return -EACCES;
> > +             break;
> >       }
>
> >       return err;
> > --
> > 2.30.2
>
