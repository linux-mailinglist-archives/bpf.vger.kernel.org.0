Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E276F4F6A37
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 21:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbiDFTqR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbiDFTpy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 15:45:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E4B329253
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 11:33:38 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id z7so4064354iom.1
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zhDntlBAomqhbXQ6P3jfUfbfkPWGTvj59+pI7fLApY=;
        b=Kwj6yytq13zCXAd645xKprFy0Lv4lBfe0mC7MZPhaHjXrLu7GgN0pVSfv1tunTQ/F/
         DqsuiYKW7PGj/Pn6z16UUDjzdVd3Qb1JL4OJh5LdmfirrVmapYiOkrvwE1muVqMZ83fE
         E85366mTyVT/EQvVPnAROkgGVQfpZfi1imSev3hg1pV4HW8zFUGUS2ENP34LFIrwjvYS
         JYSdr5nMqb65SFGB8PJGyGtSfLMRgdgq+MI+R++CgmfkDf6emIgbBN6cRkgZoRMJVlUF
         iJTfX8s+S2tidybisYeckuxkBoJeeyu9qLET9R/sSV12RkmEb+HxENtElNgIlX1mwqR9
         Vriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zhDntlBAomqhbXQ6P3jfUfbfkPWGTvj59+pI7fLApY=;
        b=Z3jWxCepYZWAFDsYmYng/KMt4MRSGxVOg7XvrSBDswLQHIkOsyE6C/1OMKpQkTmtMl
         xf/Ulj872scaSEXobP1EzoHAxWPpBcLRX1SSjsjdIKqQMtTd0W2ZdwJoxDCud7zw7i9h
         d4IzVMLaXj3cuGniVwo+bKCUDezymqS/tVn7K8Ul3nigYTtNSEmTXsB6MHPZXbkHH7Ne
         DPmCaeTvirAY8FqSvNAEgO/Nsfyp8O5kNIxMdM3+pq1jpZGkva2wZbOchGcX+Zk8pOc2
         2ADiDKbAnFRH2wFOaa5fCiXuHEnt+Q1Uubd4JqZOUxitI8EwnwvFCVq4e4HQWgA/Uyiw
         M02Q==
X-Gm-Message-State: AOAM5320C7pL4aLmRw/48D+mTQKA2Ytu85Sc72EOTTha7oDo06NAGc6B
        3/Y/U8QqPQXam3I+FyHE1WcD0S9f8SXOYlDeiYA=
X-Google-Smtp-Source: ABdhPJyECMSwphAXVDslb/GFRqkUKEq46iXW/9u7NsXjuUa+JxvOY3CtimGU4SXNmN+CiLzGmt9Uf1SPRtmyb3RmGnY=
X-Received: by 2002:a6b:8bd7:0:b0:646:2804:5c73 with SMTP id
 n206-20020a6b8bd7000000b0064628045c73mr4521750iod.112.1649270018020; Wed, 06
 Apr 2022 11:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-2-joannekoong@fb.com>
In-Reply-To: <20220402015826.3941317-2-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 11:33:27 -0700
Message-ID: <CAEf4BzaHG37qpGKxt9ep62fCDSkyKSSqs8oaKg1M4W-64LNwfw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/7] bpf: Add MEM_UNINIT as a bpf_type_flag
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> Instead of having uninitialized versions of arguments as separate
> bpf_arg_types (eg ARG_PTR_TO_UNINIT_MEM as the uninitialized version
> of ARG_PTR_TO_MEM), we can instead use MEM_UNINIT as a bpf_type_flag
> modifier to denote that the argument is uninitialized.
>
> Doing so cleans up some of the logic in the verifier. We no longer
> need to do two checks against an argument type (eg "if
> (base_type(arg_type) == ARG_PTR_TO_MEM || base_type(arg_type) ==
> ARG_PTR_TO_UNINIT_MEM)"), since uninitialized and initialized
> versions of the same argument type will now share the same base type.
>
> In the near future, MEM_UNINIT will be used by dynptr helper functions
> as well.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h      | 19 +++++++++++--------
>  kernel/bpf/bpf_lsm.c     |  4 ++--
>  kernel/bpf/cgroup.c      |  4 ++--
>  kernel/bpf/helpers.c     | 12 ++++++------
>  kernel/bpf/stackmap.c    |  6 +++---
>  kernel/bpf/verifier.c    | 25 ++++++++++---------------
>  kernel/trace/bpf_trace.c | 20 ++++++++++----------
>  net/core/filter.c        | 26 +++++++++++++-------------
>  8 files changed, 57 insertions(+), 59 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index bdb5298735ce..6f2558da9d4a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -342,7 +342,9 @@ enum bpf_type_flag {
>          */
>         MEM_PERCPU              = BIT(4 + BPF_BASE_TYPE_BITS),
>
> -       __BPF_TYPE_LAST_FLAG    = MEM_PERCPU,
> +       MEM_UNINIT              = BIT(5 + BPF_BASE_TYPE_BITS),
> +
> +       __BPF_TYPE_LAST_FLAG    = MEM_UNINIT,
>  };
>
>  /* Max number of base types. */
> @@ -361,16 +363,11 @@ enum bpf_arg_type {
>         ARG_CONST_MAP_PTR,      /* const argument used as pointer to bpf_map */
>         ARG_PTR_TO_MAP_KEY,     /* pointer to stack used as map key */
>         ARG_PTR_TO_MAP_VALUE,   /* pointer to stack used as map value */
> -       ARG_PTR_TO_UNINIT_MAP_VALUE,    /* pointer to valid memory used to store a map value */
>
> -       /* the following constraints used to prototype bpf_memcmp() and other
> -        * functions that access data on eBPF program stack
> +       /* Used to prototype bpf_memcmp() and other functions that access data
> +        * on eBPF program stack
>          */
>         ARG_PTR_TO_MEM,         /* pointer to valid memory (stack, packet, map value) */
> -       ARG_PTR_TO_UNINIT_MEM,  /* pointer to memory does not need to be initialized,
> -                                * helper function must fill all bytes or clear
> -                                * them in error case.
> -                                */
>
>         ARG_CONST_SIZE,         /* number of bytes accessed from memory */
>         ARG_CONST_SIZE_OR_ZERO, /* number of bytes accessed from memory or 0 */
> @@ -400,6 +397,12 @@ enum bpf_arg_type {
>         ARG_PTR_TO_SOCKET_OR_NULL       = PTR_MAYBE_NULL | ARG_PTR_TO_SOCKET,
>         ARG_PTR_TO_ALLOC_MEM_OR_NULL    = PTR_MAYBE_NULL | ARG_PTR_TO_ALLOC_MEM,
>         ARG_PTR_TO_STACK_OR_NULL        = PTR_MAYBE_NULL | ARG_PTR_TO_STACK,
> +       /* pointer to valid memory used to store a map value */
> +       ARG_PTR_TO_MAP_VALUE_UNINIT     = MEM_UNINIT | ARG_PTR_TO_MAP_VALUE,

seeing how this "alias" is used only in few places, I'd just use
`ARG_PTR_TO_MAP_VALUE | MEM_UNINIT` directly in prototype declaration
and the MEM_UNINIT flag directly in verifier logic.

> +       /* pointer to memory does not need to be initialized, helper function must fill
> +        * all bytes or clear them in error case.
> +        */
> +       ARG_PTR_TO_MEM_UNINIT           = MEM_UNINIT | ARG_PTR_TO_MEM,
>
>         /* This must be the last entry. Its purpose is to ensure the enum is
>          * wide enough to hold the higher bits reserved for bpf_type_flag.

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d175b70067b3..90280d5666be 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5136,8 +5136,7 @@ static int process_timer_func(struct bpf_verifier_env *env, int regno,
>
>  static bool arg_type_is_mem_ptr(enum bpf_arg_type type)
>  {
> -       return base_type(type) == ARG_PTR_TO_MEM ||
> -              base_type(type) == ARG_PTR_TO_UNINIT_MEM;
> +       return base_type(type) == ARG_PTR_TO_MEM;
>  }

Is this helper function even useful anymore? I'd just drop this
function altogether.

>
>  static bool arg_type_is_mem_size(enum bpf_arg_type type)
> @@ -5273,7 +5272,6 @@ static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE }
>  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>         [ARG_PTR_TO_MAP_KEY]            = &map_key_value_types,
>         [ARG_PTR_TO_MAP_VALUE]          = &map_key_value_types,
> -       [ARG_PTR_TO_UNINIT_MAP_VALUE]   = &map_key_value_types,
>         [ARG_CONST_SIZE]                = &scalar_types,
>         [ARG_CONST_SIZE_OR_ZERO]        = &scalar_types,
>         [ARG_CONST_ALLOC_SIZE_OR_ZERO]  = &scalar_types,
> @@ -5287,7 +5285,6 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>         [ARG_PTR_TO_BTF_ID]             = &btf_ptr_types,
>         [ARG_PTR_TO_SPIN_LOCK]          = &spin_lock_types,
>         [ARG_PTR_TO_MEM]                = &mem_types,
> -       [ARG_PTR_TO_UNINIT_MEM]         = &mem_types,
>         [ARG_PTR_TO_ALLOC_MEM]          = &alloc_mem_types,
>         [ARG_PTR_TO_INT]                = &int_ptr_types,
>         [ARG_PTR_TO_LONG]               = &int_ptr_types,
> @@ -5451,8 +5448,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 return -EACCES;
>         }
>
> -       if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE ||
> -           base_type(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> +       if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE) {
>                 err = resolve_map_arg_type(env, meta, &arg_type);
>                 if (err)
>                         return err;
> @@ -5528,8 +5524,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 err = check_helper_mem_access(env, regno,
>                                               meta->map_ptr->key_size, false,
>                                               NULL);
> -       } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE ||
> -                  base_type(arg_type) == ARG_PTR_TO_UNINIT_MAP_VALUE) {
> +       } else if (base_type(arg_type) == ARG_PTR_TO_MAP_VALUE) {
>                 if (type_may_be_null(arg_type) && register_is_null(reg))
>                         return 0;
>
> @@ -5541,7 +5536,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                         verbose(env, "invalid map_ptr to access map->value\n");
>                         return -EACCES;
>                 }
> -               meta->raw_mode = (arg_type == ARG_PTR_TO_UNINIT_MAP_VALUE);
> +               meta->raw_mode = (arg_type == ARG_PTR_TO_MAP_VALUE_UNINIT);
>                 err = check_helper_mem_access(env, regno,
>                                               meta->map_ptr->value_size, false,
>                                               meta);
> @@ -5572,7 +5567,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 /* The access to this pointer is only checked when we hit the
>                  * next is_mem_size argument below.
>                  */
> -               meta->raw_mode = (arg_type == ARG_PTR_TO_UNINIT_MEM);
> +               meta->raw_mode = (arg_type == ARG_PTR_TO_MEM_UNINIT);

aside: raw_mode is a horrible name that communicates literally nothing
towards its semantics (IMO), would be nice to fix that, I'm always
confused by it

>         } else if (arg_type_is_mem_size(arg_type)) {
>                 bool zero_size_allowed = (arg_type == ARG_CONST_SIZE_OR_ZERO);
>

[...]

> @@ -1406,7 +1406,7 @@ static const struct bpf_func_proto bpf_get_stack_proto_tp = {
>         .gpl_only       = true,
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_CTX,
> -       .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
> +       .arg2_type      = ARG_PTR_TO_MEM_UNINIT,
>         .arg3_type      = ARG_CONST_SIZE_OR_ZERO,
>         .arg4_type      = ARG_ANYTHING,
>  };
> @@ -1473,7 +1473,7 @@ static const struct bpf_func_proto bpf_perf_prog_read_value_proto = {
>           .gpl_only       = true,
>           .ret_type       = RET_INTEGER,
>           .arg1_type      = ARG_PTR_TO_CTX,
> -         .arg2_type      = ARG_PTR_TO_UNINIT_MEM,
> +        .arg2_type      = ARG_PTR_TO_MEM_UNINIT,

indentation is off

>           .arg3_type      = ARG_CONST_SIZE,
>  };
>

[...]
