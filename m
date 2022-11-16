Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE41262C730
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 19:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiKPSET (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 13:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPSES (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 13:04:18 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1356559FCE
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 10:04:15 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m22so46006852eji.10
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 10:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mU+eRSZ7jlLu3wjQbvgERkcUH3NDzRzo3YM9LB0vefI=;
        b=mc86j/157oVRPwmnMA6C118s7kT2tQT3dzCLJC5Vo5kHJrVoZgB3F5Yb5fQmjX54pS
         HXJbs8uk3K8laTYBg+ABmjmXz/OkLNEJoLiaNjXEe85oJiW3HtKjNlOIvoZqysgn2M/w
         lbOWWu2jVOV8yGc+k9QyqVDzWDwYJMLtgzNT6VBZ4R4tHXuu6JBNjYmWHCmUFMlH3N/r
         u/z960etuabQDxDf72IqMyLP4Jeg/8gViEcia0QijLkoscCrN5vWyRwTdqXJ9IvAp1tJ
         qMz583Eglt3GWARHGu//pnqZOPyeyjXwMyrZEGmQEweKU6yD10s9myYv8ohXgF2CqCD4
         3EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mU+eRSZ7jlLu3wjQbvgERkcUH3NDzRzo3YM9LB0vefI=;
        b=4FmWlAWQigldVgy8GobH0fQqzD/PGO4L1US57bp91mlED2WBthLOo9PH1lOno2xOTr
         itWCqUE7B3l5pxCZi2Rs+YZ8QAdVspuArbMpOfZEa+yJvSHOcKJ3iKJzm8MvMQBVxFyo
         jsUjMh6niLn7Q+pLyDz+3lO8vmiY3UWiYL3nY6Cbe9Hi53gUpnf0EVzW09lXZjLfyY9J
         G6wbhSVLH7WlOSBY2QdpU7O8xH8luXUBtfK/lju5ffwpqMjE/4jPEUXimM+hS+drz6fp
         a4u0PlOirNAV2YkZXip9DgYpII9+OMOwiy4rMs0AHr5MzoUhetgYW2NX9LG7StWqONJ5
         rwdQ==
X-Gm-Message-State: ANoB5pkgwwH6IR4TLlq1bQTQbb8w2iGO2j0Y2o1eGqOQKic9+LJHlCOE
        4eecCvoiQlprqeQGsu2WIG42Ze0hDq4LzvUGDEI=
X-Google-Smtp-Source: AA0mqf5uQDtIvUtb2UZG68RopDSm8AEZ+jXKwgbOdV5Wh67NVGOxRRjglEhUgaTm+oLBdzoGiKq/Y8BqLn5IwLaylXg=
X-Received: by 2002:a17:906:6852:b0:7ac:a2b7:6c96 with SMTP id
 a18-20020a170906685200b007aca2b76c96mr18156089ejs.412.1668621853111; Wed, 16
 Nov 2022 10:04:13 -0800 (PST)
MIME-Version: 1.0
References: <20221115000130.1967465-1-memxor@gmail.com> <20221115000130.1967465-4-memxor@gmail.com>
In-Reply-To: <20221115000130.1967465-4-memxor@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Wed, 16 Nov 2022 10:04:02 -0800
Message-ID: <CAJnrk1ajyqyZFU0szRbRKL57RBTtHfGHC0gvnQNe6NnZrabdyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/7] bpf: Rework process_dynptr_func
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 14, 2022 at 4:01 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Recently, user ringbuf support introduced a PTR_TO_DYNPTR register type
> for use in callback state, because in case of user ringbuf helpers,
> there is no dynptr on the stack that is passed into the callback. To
> reflect such a state, a special register type was created.
>
> However, some checks have been bypassed incorrectly during the addition
> of this feature. First, for arg_type with MEM_UNINIT flag which
> initialize a dynptr, they must be rejected for such register type.
> Secondly, in the future, there are plans to add dynptr helpers that
> operate on the dynptr itself and may change its offset and other
> properties.
>
> In all of these cases, PTR_TO_DYNPTR shouldn't be allowed to be passed
> to such helpers, however the current code simply returns 0.
>
> The rejection for helpers that release the dynptr is already handled.
>
> For fixing this, we take a step back and rework existing code in a way
> that will allow fitting in all classes of helpers and have a coherent
> model for dealing with the variety of use cases in which dynptr is used.
>
> First, for ARG_PTR_TO_DYNPTR, it can either be set alone or together
> with a DYNPTR_TYPE_* constant that denotes the only type it accepts.
>
> Next, helpers which initialize a dynptr use MEM_UNINIT to indicate this
> fact. To make the distinction clear, use MEM_RDONLY flag to indicate
> that the helper only operates on the memory pointed to by the dynptr,
> not the dynptr itself. In C parlance, it would be equivalent to taking
> the dynptr as a point to const argument.
>
> When either of these flags are not present, the helper is allowed to
> mutate both the dynptr itself and also the memory it points to.
> Currently, the read only status of the memory is not tracked in the
> dynptr, but it would be trivial to add this support inside dynptr state
> of the register.
>
> With these changes and renaming PTR_TO_DYNPTR to CONST_PTR_TO_DYNPTR to
> better reflect its usage, it can no longer be passed to helpers that
> initialize a dynptr, i.e. bpf_dynptr_from_mem, bpf_ringbuf_reserve_dynptr.
>
> A note to reviewers is that in code that does mark_stack_slots_dynptr,
> and unmark_stack_slots_dynptr, we implicitly rely on the fact that
> PTR_TO_STACK reg is the only case that can reach that code path, as one
> cannot pass CONST_PTR_TO_DYNPTR to helpers that don't set MEM_RDONLY. In
> both cases such helpers won't be setting that flag.
>
> The next patch will add a couple of selftest cases to make sure this
> doesn't break.
>
> Fixes: 205715673844 ("bpf: Add bpf_user_ringbuf_drain() helper")
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

overall lgtm

Acked-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  include/linux/bpf.h                           |   4 +-
>  include/uapi/linux/bpf.h                      |   8 +-
>  kernel/bpf/btf.c                              |   7 +-
>  kernel/bpf/helpers.c                          |  18 +-
>  kernel/bpf/verifier.c                         | 220 +++++++++++++-----
>  scripts/bpf_doc.py                            |   1 +
>  tools/include/uapi/linux/bpf.h                |   8 +-
>  .../selftests/bpf/prog_tests/user_ringbuf.c   |  10 +-
>  8 files changed, 195 insertions(+), 81 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 798aec816970..dfe45f6caa4f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -709,7 +709,7 @@ enum bpf_reg_type {
>         PTR_TO_MEM,              /* reg points to valid memory region */
>         PTR_TO_BUF,              /* reg points to a read/write buffer */
>         PTR_TO_FUNC,             /* reg points to a bpf program function */
> -       PTR_TO_DYNPTR,           /* reg points to a dynptr */
> +       CONST_PTR_TO_DYNPTR,     /* reg points to a const struct bpf_dynptr */
>         __BPF_REG_TYPE_MAX,
>
>         /* Extended reg_types. */
> @@ -2761,7 +2761,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>                      enum bpf_dynptr_type type, u32 offset, u32 size);
>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>  int bpf_dynptr_check_size(u32 size);
> -u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr);
> +u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr);
>
>  #ifdef CONFIG_BPF_LSM
>  void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index fb4c911d2a03..b7543efd6284 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5290,7 +5290,7 @@ union bpf_attr {
>   *     Return
>   *             Nothing. Always succeeds.
>   *
> - * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset, u64 flags)
> + * long bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr *src, u32 offset, u64 flags)
>   *     Description
>   *             Read *len* bytes from *src* into *dst*, starting from *offset*
>   *             into *src*.
> @@ -5300,7 +5300,7 @@ union bpf_attr {
>   *             of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
>   *             *flags* is not 0.
>   *
> - * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
> + * long bpf_dynptr_write(const struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
>   *     Description
>   *             Write *len* bytes from *src* into *dst*, starting from *offset*
>   *             into *dst*.
> @@ -5310,7 +5310,7 @@ union bpf_attr {
>   *             of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
>   *             is a read-only dynptr or if *flags* is not 0.
>   *
> - * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
> + * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u32 offset, u32 len)
>   *     Description
>   *             Get a pointer to the underlying dynptr data.
>   *
> @@ -5411,7 +5411,7 @@ union bpf_attr {
>   *             Drain samples from the specified user ring buffer, and invoke
>   *             the provided callback for each such sample:
>   *
> - *             long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
> + *             long (\*callback_fn)(const struct bpf_dynptr \*dynptr, void \*ctx);
>   *
>   *             If **callback_fn** returns 0, the helper will continue to try
>   *             and drain the next sample, up to a maximum of
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d02ae2f4249b..ba3b50895f6b 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6568,14 +6568,15 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>                                 }
>
>                                 if (arg_dynptr) {
> -                                       if (reg->type != PTR_TO_STACK) {
> -                                               bpf_log(log, "arg#%d pointer type %s %s not to stack\n",
> +                                       if (reg->type != PTR_TO_STACK &&
> +                                           reg->type != CONST_PTR_TO_DYNPTR) {
> +                                               bpf_log(log, "arg#%d pointer type %s %s not to stack or dynptr\n",
>                                                         i, btf_type_str(ref_t),
>                                                         ref_tname);
>                                                 return -EINVAL;
>                                         }
>
> -                                       if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR, NULL))
> +                                       if (process_dynptr_func(env, regno, ARG_PTR_TO_DYNPTR | MEM_RDONLY, NULL))
>                                                 return -EINVAL;
>                                         continue;
>                                 }
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 283f55bbeb70..714f5c9d0c1f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1398,7 +1398,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
>  #define DYNPTR_SIZE_MASK       0xFFFFFF
>  #define DYNPTR_RDONLY_BIT      BIT(31)
>
> -static bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> +static bool bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
>  {
>         return ptr->size & DYNPTR_RDONLY_BIT;
>  }
> @@ -1408,7 +1408,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
>         ptr->size |= type << DYNPTR_TYPE_SHIFT;
>  }
>
> -u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
> +u32 bpf_dynptr_get_size(const struct bpf_dynptr_kern *ptr)
>  {
>         return ptr->size & DYNPTR_SIZE_MASK;
>  }
> @@ -1432,7 +1432,7 @@ void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
>         memset(ptr, 0, sizeof(*ptr));
>  }
>
> -static int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
> +static int bpf_dynptr_check_off_len(const struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
>  {
>         u32 size = bpf_dynptr_get_size(ptr);
>
> @@ -1477,7 +1477,7 @@ static const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
>         .arg4_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
>  };
>
> -BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src,
> +BPF_CALL_5(bpf_dynptr_read, void *, dst, u32, len, const struct bpf_dynptr_kern *, src,
>            u32, offset, u64, flags)
>  {
>         int err;
> @@ -1500,12 +1500,12 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
>         .ret_type       = RET_INTEGER,
>         .arg1_type      = ARG_PTR_TO_UNINIT_MEM,
>         .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
> -       .arg3_type      = ARG_PTR_TO_DYNPTR,
> +       .arg3_type      = ARG_PTR_TO_DYNPTR | MEM_RDONLY,
>         .arg4_type      = ARG_ANYTHING,
>         .arg5_type      = ARG_ANYTHING,
>  };
>
> -BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
> +BPF_CALL_5(bpf_dynptr_write, const struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
>            u32, len, u64, flags)
>  {
>         int err;
> @@ -1526,14 +1526,14 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
>         .func           = bpf_dynptr_write,
>         .gpl_only       = false,
>         .ret_type       = RET_INTEGER,
> -       .arg1_type      = ARG_PTR_TO_DYNPTR,
> +       .arg1_type      = ARG_PTR_TO_DYNPTR | MEM_RDONLY,
>         .arg2_type      = ARG_ANYTHING,
>         .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
>         .arg4_type      = ARG_CONST_SIZE_OR_ZERO,
>         .arg5_type      = ARG_ANYTHING,
>  };
>
> -BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
> +BPF_CALL_3(bpf_dynptr_data, const struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
>  {
>         int err;
>
> @@ -1554,7 +1554,7 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
>         .func           = bpf_dynptr_data,
>         .gpl_only       = false,
>         .ret_type       = RET_PTR_TO_DYNPTR_MEM_OR_NULL,
> -       .arg1_type      = ARG_PTR_TO_DYNPTR,
> +       .arg1_type      = ARG_PTR_TO_DYNPTR | MEM_RDONLY,
>         .arg2_type      = ARG_ANYTHING,
>         .arg3_type      = ARG_CONST_ALLOC_SIZE_OR_ZERO,
>  };
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 41ef7e4b73e4..c484e632b0cd 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -565,7 +565,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>                 [PTR_TO_BUF]            = "buf",
>                 [PTR_TO_FUNC]           = "func",
>                 [PTR_TO_MAP_KEY]        = "map_key",
> -               [PTR_TO_DYNPTR]         = "dynptr_ptr",
> +               [CONST_PTR_TO_DYNPTR]   = "dynptr",

nit: personally I think "= dynptr_ptr" is more useful here

>         };
>
>         if (type & PTR_MAYBE_NULL) {
> @@ -699,6 +699,27 @@ static bool dynptr_type_refcounted(enum bpf_dynptr_type type)
>         return type == BPF_DYNPTR_TYPE_RINGBUF;
>  }
>
> +static void __mark_dynptr_regs(struct bpf_reg_state *reg1,
> +                              struct bpf_reg_state *reg2,
> +                              enum bpf_dynptr_type type);
> +
> +static void __mark_reg_not_init(const struct bpf_verifier_env *env,
> +                               struct bpf_reg_state *reg);
> +
> +static void mark_dynptr_stack_regs(struct bpf_reg_state *sreg1,
> +                                  struct bpf_reg_state *sreg2,
> +                                  enum bpf_dynptr_type type)
> +{
> +       __mark_dynptr_regs(sreg1, sreg2, type);
> +}
> +
> +static void mark_dynptr_cb_reg(struct bpf_reg_state *reg1,
> +                              enum bpf_dynptr_type type)
> +{
> +       __mark_dynptr_regs(reg1, NULL, type);
> +}
> +
> +
>  static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>                                    enum bpf_arg_type arg_type, int insn_idx)
>  {
> @@ -720,9 +741,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>         if (type == BPF_DYNPTR_TYPE_INVALID)
>                 return -EINVAL;
>
> -       state->stack[spi].spilled_ptr.dynptr.first_slot = true;
> -       state->stack[spi].spilled_ptr.dynptr.type = type;
> -       state->stack[spi - 1].spilled_ptr.dynptr.type = type;
> +       mark_dynptr_stack_regs(&state->stack[spi].spilled_ptr,
> +                              &state->stack[spi - 1].spilled_ptr, type);
>
>         if (dynptr_type_refcounted(type)) {
>                 /* The id is used to track proper releasing */
> @@ -730,8 +750,8 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>                 if (id < 0)
>                         return id;
>
> -               state->stack[spi].spilled_ptr.id = id;
> -               state->stack[spi - 1].spilled_ptr.id = id;
> +               state->stack[spi].spilled_ptr.ref_obj_id = id;
> +               state->stack[spi - 1].spilled_ptr.ref_obj_id = id;
>         }
>
>         return 0;
> @@ -753,25 +773,23 @@ static int unmark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_re
>         }
>
>         /* Invalidate any slices associated with this dynptr */
> -       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type)) {
> -               release_reference(env, state->stack[spi].spilled_ptr.id);
> -               state->stack[spi].spilled_ptr.id = 0;
> -               state->stack[spi - 1].spilled_ptr.id = 0;
> -       }
> -
> -       state->stack[spi].spilled_ptr.dynptr.first_slot = false;
> -       state->stack[spi].spilled_ptr.dynptr.type = 0;
> -       state->stack[spi - 1].spilled_ptr.dynptr.type = 0;
> +       if (dynptr_type_refcounted(state->stack[spi].spilled_ptr.dynptr.type))
> +               WARN_ON_ONCE(release_reference(env, state->stack[spi].spilled_ptr.ref_obj_id));
>
> +       __mark_reg_not_init(env, &state->stack[spi].spilled_ptr);
> +       __mark_reg_not_init(env, &state->stack[spi - 1].spilled_ptr);
>         return 0;
>  }
>
>  static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
> -       int spi = get_spi(reg->off);
> -       int i;
> +       int spi, i;
> +
> +       if (reg->type == CONST_PTR_TO_DYNPTR)
> +               return false;
>
> +       spi = get_spi(reg->off);
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS))
>                 return true;
>
> @@ -787,9 +805,14 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>  static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
> -       int spi = get_spi(reg->off);
> +       int spi;
>         int i;
>
> +       /* This already represents first slot of initialized bpf_dynptr */
> +       if (reg->type == CONST_PTR_TO_DYNPTR)
> +               return true;
> +
> +       spi = get_spi(reg->off);
>         if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
>             !state->stack[spi].spilled_ptr.dynptr.first_slot)
>                 return false;
> @@ -808,15 +831,19 @@ static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg
>  {
>         struct bpf_func_state *state = func(env, reg);
>         enum bpf_dynptr_type dynptr_type;
> -       int spi = get_spi(reg->off);
> +       int spi;
>
>         /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
>         if (arg_type == ARG_PTR_TO_DYNPTR)
>                 return true;
>
>         dynptr_type = arg_to_dynptr_type(arg_type);
> -
> -       return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
> +       if (reg->type == CONST_PTR_TO_DYNPTR) {
> +               return reg->dynptr.type == dynptr_type;
> +       } else {
> +               spi = get_spi(reg->off);
> +               return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
> +       }
>  }
>
>  /* The reg state of a pointer or a bounded scalar was saved when
> @@ -1324,9 +1351,6 @@ static const int caller_saved[CALLER_SAVED_REGS] = {
>         BPF_REG_0, BPF_REG_1, BPF_REG_2, BPF_REG_3, BPF_REG_4, BPF_REG_5
>  };
>
> -static void __mark_reg_not_init(const struct bpf_verifier_env *env,
> -                               struct bpf_reg_state *reg);
> -
>  /* This helper doesn't clear reg->id */
>  static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>  {
> @@ -1389,6 +1413,26 @@ static void mark_reg_known_zero(struct bpf_verifier_env *env,
>         __mark_reg_known_zero(regs + regno);
>  }
>
> +static void __mark_dynptr_regs(struct bpf_reg_state *reg1,
> +                              struct bpf_reg_state *reg2,
> +                              enum bpf_dynptr_type type)

nit: Given that the logic is the same, I think it'd be cleaner if
__mark_dynptr_regs takes 1 bpf_reg_state arg, since in some cases (eg
mark_dynptr_cb_reg) NULL is passed in for reg2 anyways.

> +{
> +       /* reg->type has no meaning for STACK_DYNPTR, but when we set reg for
> +        * callback arguments, it does need to be CONST_PTR_TO_DYNPTR, so simply
> +        * set it unconditionally as it is ignored for STACK_DYNPTR anyway.
> +        */
> +       __mark_reg_known_zero(reg1);
> +       reg1->type = CONST_PTR_TO_DYNPTR;
> +       reg1->dynptr.type = type;
> +       reg1->dynptr.first_slot = true;
> +       if (!reg2)
> +               return;
> +       __mark_reg_known_zero(reg2);
> +       reg2->type = CONST_PTR_TO_DYNPTR;
> +       reg2->dynptr.type = type;
> +       reg2->dynptr.first_slot = false;
> +}
> +
>  static void mark_ptr_not_null_reg(struct bpf_reg_state *reg)
>  {
>         if (base_type(reg->type) == PTR_TO_MAP_VALUE) {
> @@ -5692,20 +5736,62 @@ static int process_kptr_func(struct bpf_verifier_env *env, int regno,
>         return 0;
>  }
>
> +/* Implementation details:
> + *
> + * There are two register types representing a bpf_dynptr, one is PTR_TO_STACK
> + * which points to a stack slot, and the other is CONST_PTR_TO_DYNPTR.
> + *
> + * In both cases we deal with the first 8 bytes, but need to mark the next 8
> + * bytes as STACK_DYNPTR in case of PTR_TO_STACK. In case of
> + * CONST_PTR_TO_DYNPTR, we are guaranteed to get the beginning of the object.
> + *
> + * Mutability of bpf_dynptr is at two levels, one is at the level of struct
> + * bpf_dynptr itself, i.e. whether the helper is receiving a pointer to struct
> + * bpf_dynptr or pointer to const struct bpf_dynptr. In the former case, it can
> + * mutate the view of the dynptr and also possibly destroy it. In the latter
> + * case, it cannot mutate the bpf_dynptr itself but it can still mutate the
> + * memory that dynptr points to.
> + *
> + * The verifier will keep track both levels of mutation (bpf_dynptr's in
> + * reg->type and the memory's in reg->dynptr.type), but there is no support for
> + * readonly dynptr view yet, hence only the first case is tracked and checked.
> + *
> + * This is consistent with how C applies the const modifier to a struct object,
> + * where the pointer itself inside bpf_dynptr becomes const but not what it
> + * points to.
> + *
> + * Helpers which do not mutate the bpf_dynptr set MEM_RDONLY in their argument
> + * type, and declare it as 'const struct bpf_dynptr *' in their prototype.
> + */
>  int process_dynptr_func(struct bpf_verifier_env *env, int regno,
> -                       enum bpf_arg_type arg_type,
> -                       struct bpf_call_arg_meta *meta)
> +                       enum bpf_arg_type arg_type, struct bpf_call_arg_meta *meta)
>  {
>         struct bpf_reg_state *regs = cur_regs(env), *reg = &regs[regno];
>         int argno = regno - 1;
>
> -       /* We only need to check for initialized / uninitialized helper
> -        * dynptr args if the dynptr is not PTR_TO_DYNPTR, as the
> -        * assumption is that if it is, that a helper function
> -        * initialized the dynptr on behalf of the BPF program.
> +       if ((arg_type & (MEM_UNINIT | MEM_RDONLY)) == (MEM_UNINIT | MEM_RDONLY)) {
> +               verbose(env, "verifier internal error: misconfigured dynptr helper type flags\n");
> +               return -EFAULT;
> +       }
> +
I think it' dbe more helpful if the comment block below was placed
before this if statement above, which explains that MEM_UNINIT and
MEM_RDONLY are mutually exclusive.

> +       /* MEM_UNINIT and MEM_RDONLY are exclusive, when applied to a
> +        * ARG_PTR_TO_DYNPTR (or ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_*):
> +        *
> +        *  MEM_UNINIT - Points to memory that is an appropriate candidate for
> +        *               constructing a mutable bpf_dynptr object.
> +        *
> +        *               Currently, this is only possible with PTR_TO_STACK
> +        *               pointing to a region of atleast 16 bytes which doesn't
> +        *               contain an existing bpf_dynptr.
> +        *
> +        *  MEM_RDONLY - Points to a initialized bpf_dynptr that will not be
> +        *               mutated or destroyed. However, the memory it points to
> +        *               may be mutated.
> +        *
> +        *  None       - Points to a initialized dynptr that can be mutated and
> +        *               destroyed, including mutation of the memory it points
> +        *               to.
>          */
> -       if (base_type(reg->type) == PTR_TO_DYNPTR)
> -               return 0;
>         if (arg_type & MEM_UNINIT) {
>                 if (!is_dynptr_reg_valid_uninit(env, reg)) {
>                         verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> @@ -5722,6 +5808,12 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>
>                 meta->uninit_dynptr_regno = regno;
>         } else {
> +               /* For the reg->type == PTR_TO_STACK case, bpf_dynptr is never const */
> +               if (reg->type == CONST_PTR_TO_DYNPTR && !(arg_type & MEM_RDONLY)) {
> +                       verbose(env, "cannot pass pointer to const bpf_dynptr, the helper mutates it\n");
> +                       return -EINVAL;
> +               }
> +
>                 if (!is_dynptr_reg_valid_init(env, reg)) {
>                         verbose(env,
>                                 "Expected an initialized dynptr as arg #%d\n",
> @@ -5729,6 +5821,8 @@ int process_dynptr_func(struct bpf_verifier_env *env, int regno,
>                         return -EINVAL;
>                 }
>
> +               /* Fold MEM_RDONLY, only inspect arg_type */
> +               arg_type &= ~MEM_RDONLY;

nit: it seems cleaner to me to call !is_dynptr_type_expected(env, reg,
arg_type & ~MEM_RDONLY) rather than mutate arg_type

>                 if (!is_dynptr_type_expected(env, reg, arg_type)) {
>                         const char *err_extra = "";
>
> @@ -5874,7 +5968,7 @@ static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } }
>  static const struct bpf_reg_types dynptr_types = {
>         .types = {
>                 PTR_TO_STACK,
> -               PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL,
> +               CONST_PTR_TO_DYNPTR,
>         }
>  };
>
> @@ -6050,12 +6144,15 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>         return __check_ptr_off_reg(env, reg, regno, fixed_off_ok);
>  }
>
> -static u32 stack_slot_get_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +static u32 dynptr_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
> -       int spi = get_spi(reg->off);
> +       int spi;
>
> -       return state->stack[spi].spilled_ptr.id;
> +       if (reg->type == CONST_PTR_TO_DYNPTR)
> +               return reg->ref_obj_id;

nit: extra line here would improve readibility

> +       spi = get_spi(reg->off);
> +       return state->stack[spi].spilled_ptr.ref_obj_id;
>  }
>
>  static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
> @@ -6119,11 +6216,17 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>         if (arg_type_is_release(arg_type)) {
>                 if (arg_type_is_dynptr(arg_type)) {
>                         struct bpf_func_state *state = func(env, reg);
> -                       int spi = get_spi(reg->off);
> +                       int spi;
>
> -                       if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> -                           !state->stack[spi].spilled_ptr.id) {
> -                               verbose(env, "arg %d is an unacquired reference\n", regno);
> +                       if (reg->type == PTR_TO_STACK) {
> +                               spi = get_spi(reg->off);
> +                               if (!is_spi_bounds_valid(state, spi, BPF_DYNPTR_NR_SLOTS) ||
> +                                   !state->stack[spi].spilled_ptr.ref_obj_id) {
> +                                       verbose(env, "arg %d is an unacquired reference\n", regno);
> +                                       return -EINVAL;
> +                               }
> +                       } else {
> +                               verbose(env, "cannot release unowned const bpf_dynptr\n");
>                                 return -EINVAL;
>                         }
>                 } else if (!reg->ref_obj_id && !register_is_null(reg)) {
> @@ -7091,11 +7194,10 @@ static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
>  {
>         /* bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void
>          *                        callback_ctx, u64 flags);
> -        * callback_fn(struct bpf_dynptr_t* dynptr, void *callback_ctx);
> +        * callback_fn(const struct bpf_dynptr_t* dynptr, void *callback_ctx);
>          */
>         __mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
> -       callee->regs[BPF_REG_1].type = PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL;
> -       __mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> +       mark_dynptr_cb_reg(&callee->regs[BPF_REG_1], BPF_DYNPTR_TYPE_LOCAL);
>         callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
>
>         /* unused */
> @@ -7474,7 +7576,13 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>
>         regs = cur_regs(env);
>
> +       /* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
> +        * be reinitialized by any dynptr helper. Hence, mark_stack_slots_dynptr
> +        * is safe to do directly.
> +        */
>         if (meta.uninit_dynptr_regno) {
> +               if (WARN_ON_ONCE(regs[meta.uninit_dynptr_regno].type == CONST_PTR_TO_DYNPTR))
> +                       return -EFAULT;
>                 /* we write BPF_DW bits (8 bytes) at a time */
>                 for (i = 0; i < BPF_DYNPTR_SIZE; i += 8) {
>                         err = check_mem_access(env, insn_idx, meta.uninit_dynptr_regno,
> @@ -7492,15 +7600,22 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>
>         if (meta.release_regno) {
>                 err = -EINVAL;
> -               if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1]))
> +               /* This can only be set for PTR_TO_STACK, as CONST_PTR_TO_DYNPTR cannot
> +                * be released by any dynptr helper. Hence, unmark_stack_slots_dynptr
> +                * is safe to do directly.
> +                */
> +               if (arg_type_is_dynptr(fn->arg_type[meta.release_regno - BPF_REG_1])) {
> +                       if (WARN_ON_ONCE(regs[meta.release_regno].type == CONST_PTR_TO_DYNPTR))
> +                               return -EFAULT;
>                         err = unmark_stack_slots_dynptr(env, &regs[meta.release_regno]);
> -               else if (meta.ref_obj_id)
> +               } else if (meta.ref_obj_id) {
>                         err = release_reference(env, meta.ref_obj_id);
> -               /* meta.ref_obj_id can only be 0 if register that is meant to be
> -                * released is NULL, which must be > R0.
> -                */
> -               else if (register_is_null(&regs[meta.release_regno]))
> +               } else if (register_is_null(&regs[meta.release_regno])) {
> +                       /* meta.ref_obj_id can only be 0 if register that is meant to be
> +                        * released is NULL, which must be > R0.
> +                        */
>                         err = 0;
> +               }
>                 if (err) {
>                         verbose(env, "func %s#%d reference has not been acquired before\n",
>                                 func_id_name(func_id), func_id);
> @@ -7574,11 +7689,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                                         return -EFAULT;
>                                 }
>
> -                               if (base_type(reg->type) != PTR_TO_DYNPTR)
> -                                       /* Find the id of the dynptr we're
> -                                        * tracking the reference of
> -                                        */
> -                                       meta.ref_obj_id = stack_slot_get_id(env, reg);
> +                               /* Find the id of the dynptr we're tracking the reference of */
> +                               meta.ref_obj_id = dynptr_ref_obj_id(env, reg);
>                                 break;
>                         }
>                 }
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index fdb0aff8cb5a..e8d90829f23e 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -752,6 +752,7 @@ class PrinterHelpers(Printer):
>              'struct bpf_timer',
>              'struct mptcp_sock',
>              'struct bpf_dynptr',
> +            'const struct bpf_dynptr',
>              'struct iphdr',
>              'struct ipv6hdr',
>      }
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index fb4c911d2a03..b7543efd6284 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5290,7 +5290,7 @@ union bpf_attr {
>   *     Return
>   *             Nothing. Always succeeds.
>   *
> - * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset, u64 flags)
> + * long bpf_dynptr_read(void *dst, u32 len, const struct bpf_dynptr *src, u32 offset, u64 flags)
>   *     Description
>   *             Read *len* bytes from *src* into *dst*, starting from *offset*
>   *             into *src*.
> @@ -5300,7 +5300,7 @@ union bpf_attr {
>   *             of *src*'s data, -EINVAL if *src* is an invalid dynptr or if
>   *             *flags* is not 0.
>   *
> - * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
> + * long bpf_dynptr_write(const struct bpf_dynptr *dst, u32 offset, void *src, u32 len, u64 flags)
>   *     Description
>   *             Write *len* bytes from *src* into *dst*, starting from *offset*
>   *             into *dst*.
> @@ -5310,7 +5310,7 @@ union bpf_attr {
>   *             of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
>   *             is a read-only dynptr or if *flags* is not 0.
>   *
> - * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
> + * void *bpf_dynptr_data(const struct bpf_dynptr *ptr, u32 offset, u32 len)
>   *     Description
>   *             Get a pointer to the underlying dynptr data.
>   *
> @@ -5411,7 +5411,7 @@ union bpf_attr {
>   *             Drain samples from the specified user ring buffer, and invoke
>   *             the provided callback for each such sample:
>   *
> - *             long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
> + *             long (\*callback_fn)(const struct bpf_dynptr \*dynptr, void \*ctx);
>   *
>   *             If **callback_fn** returns 0, the helper will continue to try
>   *             and drain the next sample, up to a maximum of
> diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> index 02b18d018b36..39882580cb90 100644
> --- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
> @@ -668,13 +668,13 @@ static struct {
>         const char *expected_err_msg;
>  } failure_tests[] = {
>         /* failure cases */
> -       {"user_ringbuf_callback_bad_access1", "negative offset dynptr_ptr ptr"},
> -       {"user_ringbuf_callback_bad_access2", "dereference of modified dynptr_ptr ptr"},
> -       {"user_ringbuf_callback_write_forbidden", "invalid mem access 'dynptr_ptr'"},
> +       {"user_ringbuf_callback_bad_access1", "negative offset dynptr ptr"},
> +       {"user_ringbuf_callback_bad_access2", "dereference of modified dynptr ptr"},
> +       {"user_ringbuf_callback_write_forbidden", "invalid mem access 'dynptr'"},
>         {"user_ringbuf_callback_null_context_write", "invalid mem access 'scalar'"},
>         {"user_ringbuf_callback_null_context_read", "invalid mem access 'scalar'"},
> -       {"user_ringbuf_callback_discard_dynptr", "arg 1 is an unacquired reference"},
> -       {"user_ringbuf_callback_submit_dynptr", "arg 1 is an unacquired reference"},
> +       {"user_ringbuf_callback_discard_dynptr", "cannot release unowned const bpf_dynptr"},
> +       {"user_ringbuf_callback_submit_dynptr", "cannot release unowned const bpf_dynptr"},
>         {"user_ringbuf_callback_invalid_return", "At callback return the register R0 has value"},
>  };
>
> --
> 2.38.1
>
