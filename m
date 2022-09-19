Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213A95BC0C3
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 02:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiISAIK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 18 Sep 2022 20:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiISAIJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 18 Sep 2022 20:08:09 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A381571C
        for <bpf@vger.kernel.org>; Sun, 18 Sep 2022 17:08:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id d16so14058585ils.8
        for <bpf@vger.kernel.org>; Sun, 18 Sep 2022 17:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SPr+saAU39u7vmsm/onbIRqU7Z1zDVGv3XLHjk1XYgk=;
        b=ZE+Cw9UlkvnVx6cZFBu2bOdQ+327E2S+bqPS5ycKL0b+7RAifznOYBbhssX5jjpvja
         1UA9HagrDNxoK84JQ65k47NlRT8z1V90oQguxhE55LrgpRtRis4snG/3ygZnECVO8OH/
         +9+4/92LhJmddkeslr7gI0HpbywVvNBv6CtVNKwCDP5yqB8+h8h8o+tx+DByfVn4EP11
         zPIXA5Rj/gDtjtJDYKbHTOv9eUVVVTkO9+MRwy6Whvlj13Xqkm9kyFKSxtf/l0UJMI9I
         36bO/RYYRnfBvwzc1ivZO/4SUcdilwAPGT13u+xHId7TjYtMG/FliUodCf2OO6BxkJ8o
         e8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SPr+saAU39u7vmsm/onbIRqU7Z1zDVGv3XLHjk1XYgk=;
        b=VOVpfBs5eEYvXzI/bL5gQ3zfKTeC0xI3+htCB/txafWPuQDu3Xn2cY4lq2WtM0QEoI
         Nm/MnAWWxMT3dqDaOMMup+qQClTkFavx+eJQ5ShpXnHq6fIioDIrC3AXtCEiIo98G7Ui
         Scc32YIIsolvCM76cQi38ePx0Jrqe0I5Mt9bWn+lvhe9mEmOeseBL9WUm9WmuSA7tLq8
         n3PsQkknLJgXdeAPGlS+Udnw2T3TabQLR942Rm/ngZJFgDsq9laXUy6jGG2NlqtX7WvV
         Pvd/DYLwIv/pqLKvtROSGMrTn5krznFMrijbk3wbXJXCAYs5a7m6eCBEFyjl8nl+Py3S
         EixA==
X-Gm-Message-State: ACrzQf2TNg992PVVJtD6oautD64Kg9vZivpjDtbBoW724nXPz/7EzVzR
        P7S3kOkkuXkam73dhgLAqla7kvHVrdbrkEzxocw=
X-Google-Smtp-Source: AMsMyM4jcCNn505+lvqsf/T/SwujANGdgxh4gG39Cjy3DjUG+D74qolfloIUMI+K7Vm898EKvcmIdev+Ww2mAxTKA3g=
X-Received: by 2002:a05:6e02:1a86:b0:2f5:96eb:52d2 with SMTP id
 k6-20020a056e021a8600b002f596eb52d2mr1537835ilv.91.1663546087781; Sun, 18 Sep
 2022 17:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com> <20220908000254.3079129-8-joannelkoong@gmail.com>
In-Reply-To: <20220908000254.3079129-8-joannelkoong@gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 19 Sep 2022 02:07:32 +0200
Message-ID: <CAP01T76YjXcxYsYue5Sxyp+Ppa3XR3nQq2nz8gV9VnWcD6Tdgg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] bpf: Add bpf_dynptr_iterator
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        andrii@kernel.org, ast@kernel.org, Kernel-team@fb.com
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

On Thu, 8 Sept 2022 at 02:16, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add a new helper function, bpf_dynptr_iterator:
>
>   long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
>                            void *callback_ctx, u64 flags)
>
> where callback_fn is defined as:
>
>   long (*callback_fn)(struct bpf_dynptr *ptr, void *ctx)
>
> and callback_fn returns the number of bytes to advance the
> dynptr by (or an error code in the case of error). The iteration
> will stop if the callback_fn returns 0 or an error or tries to
> advance by more bytes than available.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---

This is buggy as is.

A user can just reinitialize the dynptr from inside the callback, and
then you will never stop advancing it inside your helper, therefore an
infinite loop can be constructed. The stack frame of the caller is
accessible using callback_ctx.

For example (modifying your selftest)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c
b/tools/testing/selftests/bpf/progs/dynptr_success.c
index 22164ad6df9d..a9e78316c508 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -540,6 +540,19 @@ struct iter_ctx {

 static int iter_callback(struct bpf_dynptr *ptr, struct iter_ctx *ctx)
 {
+       struct map_value *map_val;
+       int key = 0;
+
+       map_val = bpf_map_lookup_elem(&array_map2, &key);
+       if (!map_val) {
+               return 0;
+       }
+
+       *(void **)ptr = 0;
+       *((void **)ptr + 1) = 0;
+       bpf_dynptr_from_mem(map_val, 2, 0, ptr);
+       return 1;
+
        if (ctx->trigger_err_erange)
                return bpf_dynptr_get_size(ptr) + 1;

... leads to a lockup.

It doesn't have to be ringbuf_reserver_dynptr, it can just be
dynptr_from_mem, which also gets around reference state restrictions
inside callbacks.

You cannot prevent overwriting dynptr stack slots in general. Some of
them don't have to be released. It would be prohibitive for stack
reuse.

So it seems like you need to temporarily mark both the slots as
immutable for the caller stack state during exploration of the
callback.
Setting some flag in r1 for callback is not enough (as it can reload
PTR_TO_STACK of caller stack frame pointing at dynptr from
callback_ctx). It needs to be set in spilled_ptr.

Then certain operations modifying the view of the dynptr do not accept
dynptr with that type flag set (e.g. trim, advance, init functions).
While for others which only operate on the underlying view, you fold
the flag (e.g. read/write/dynptr_data).

It is the difference between struct bpf_dynptr *, vs const struct
bpf_dynptr *, we need to give the callback access to the latter.
I.e. it should still allow accessing the dynptr's view, but not modifying it.

And at the risk of sounding like a broken record (and same suggestion
as Martin in skb/xdp v6 set), the view's mutability should ideally
also be part of the verifier's state. That doesn't preclude runtime
tracking later, but there seems to be no strong motivation for that
right now.

>  include/uapi/linux/bpf.h       | 20 ++++++++++++++
>  kernel/bpf/helpers.c           | 48 +++++++++++++++++++++++++++++++---
>  kernel/bpf/verifier.c          | 27 +++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++
>  4 files changed, 111 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 16973fa4d073..ff78a94c262a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5531,6 +5531,25 @@ union bpf_attr {
>   *             losing access to the original view of the dynptr.
>   *     Return
>   *             0 on success, -EINVAL if the dynptr to clone is invalid.
> + *
> + * long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn, void *callback_ctx, u64 flags)
> + *     Description
> + *             Iterate through the dynptr data, calling **callback_fn** on each
> + *             iteration with **callback_ctx** as the context parameter.
> + *             The **callback_fn** should be a static function and
> + *             the **callback_ctx** should be a pointer to the stack.
> + *             Currently **flags** is unused and must be 0.
> + *
> + *             long (\*callback_fn)(struct bpf_dynptr \*ptr, void \*ctx);
> + *
> + *             where **callback_fn** returns the number of bytes to advance
> + *             the dynptr by or an error. The iteration will stop if **callback_fn**
> + *             returns 0 or an error or tries to advance by more bytes than the
> + *             size of the dynptr.
> + *     Return
> + *             0 on success, -EINVAL if the dynptr is invalid or **flags** is not 0,
> + *             -ERANGE if attempting to iterate more bytes than available, or other
> + *             negative error if **callback_fn** returns an error.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5752,6 +5771,7 @@ union bpf_attr {
>         FN(dynptr_get_size),            \
>         FN(dynptr_get_offset),          \
>         FN(dynptr_clone),               \
> +       FN(dynptr_iterator),            \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 667f1e213a61..519b3da06d49 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1653,13 +1653,11 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
>         .arg3_type      = ARG_CONST_ALLOC_SIZE_OR_ZERO,
>  };
>
> -BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> +/* *ptr* should always be a valid dynptr */
> +static int __bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u32 len)
>  {
>         u32 size;
>
> -       if (!ptr->data)
> -               return -EINVAL;
> -
>         size = __bpf_dynptr_get_size(ptr);
>
>         if (len > size)
> @@ -1672,6 +1670,14 @@ BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
>         return 0;
>  }
>
> +BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> +{
> +       if (!ptr->data)
> +               return -EINVAL;
> +
> +       return __bpf_dynptr_advance(ptr, len);
> +}
> +
>  static const struct bpf_func_proto bpf_dynptr_advance_proto = {
>         .func           = bpf_dynptr_advance,
>         .gpl_only       = false,
> @@ -1783,6 +1789,38 @@ static const struct bpf_func_proto bpf_dynptr_clone_proto = {
>         .arg2_type      = ARG_PTR_TO_DYNPTR | MEM_UNINIT,
>  };
>
> +BPF_CALL_4(bpf_dynptr_iterator, struct bpf_dynptr_kern *, ptr, void *, callback_fn,
> +          void *, callback_ctx, u64, flags)
> +{
> +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> +       int nr_bytes, err;
> +
> +       if (!ptr->data || flags)
> +               return -EINVAL;
> +
> +       while (ptr->size > 0) {
> +               nr_bytes = callback((u64)(long)ptr, (u64)(long)callback_ctx, 0, 0, 0);
> +               if (nr_bytes <= 0)
> +                       return nr_bytes;
> +
> +               err = __bpf_dynptr_advance(ptr, nr_bytes);
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct bpf_func_proto bpf_dynptr_iterator_proto = {
> +       .func           = bpf_dynptr_iterator,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_DYNPTR,
> +       .arg2_type      = ARG_PTR_TO_FUNC,
> +       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> +       .arg4_type      = ARG_ANYTHING,
> +};
> +
>  const struct bpf_func_proto bpf_get_current_task_proto __weak;
>  const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
>  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
> @@ -1869,6 +1907,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_dynptr_get_offset_proto;
>         case BPF_FUNC_dynptr_clone:
>                 return &bpf_dynptr_clone_proto;
> +       case BPF_FUNC_dynptr_iterator:
> +               return &bpf_dynptr_iterator_proto;
>         default:
>                 break;
>         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2eb2a4410344..76108cd4ed85 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6901,6 +6901,29 @@ static int set_map_elem_callback_state(struct bpf_verifier_env *env,
>         return 0;
>  }
>
> +static int set_dynptr_iterator_callback_state(struct bpf_verifier_env *env,
> +                                             struct bpf_func_state *caller,
> +                                             struct bpf_func_state *callee,
> +                                             int insn_idx)
> +{
> +       /* bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
> +        * void *callback_ctx, u64 flags);
> +        *
> +        * callback_fn(struct bpf_dynptr *ptr, void *callback_ctx);
> +        */
> +       callee->regs[BPF_REG_1] = caller->regs[BPF_REG_1];
> +       callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
> +       callee->callback_ret_range = tnum_range(0, U64_MAX);
> +
> +       /* unused */
> +       __mark_reg_not_init(env, &callee->regs[BPF_REG_3]);
> +       __mark_reg_not_init(env, &callee->regs[BPF_REG_4]);
> +       __mark_reg_not_init(env, &callee->regs[BPF_REG_5]);
> +
> +       callee->in_callback_fn = true;
> +       return 0;
> +}
> +
>  static int set_loop_callback_state(struct bpf_verifier_env *env,
>                                    struct bpf_func_state *caller,
>                                    struct bpf_func_state *callee,
> @@ -7472,6 +7495,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>
>                 break;
>         }
> +       case BPF_FUNC_dynptr_iterator:
> +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +                                       set_dynptr_iterator_callback_state);
> +               break;
>         }
>
>         if (err)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 16973fa4d073..ff78a94c262a 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5531,6 +5531,25 @@ union bpf_attr {
>   *             losing access to the original view of the dynptr.
>   *     Return
>   *             0 on success, -EINVAL if the dynptr to clone is invalid.
> + *
> + * long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn, void *callback_ctx, u64 flags)
> + *     Description
> + *             Iterate through the dynptr data, calling **callback_fn** on each
> + *             iteration with **callback_ctx** as the context parameter.
> + *             The **callback_fn** should be a static function and
> + *             the **callback_ctx** should be a pointer to the stack.
> + *             Currently **flags** is unused and must be 0.
> + *
> + *             long (\*callback_fn)(struct bpf_dynptr \*ptr, void \*ctx);
> + *
> + *             where **callback_fn** returns the number of bytes to advance
> + *             the dynptr by or an error. The iteration will stop if **callback_fn**
> + *             returns 0 or an error or tries to advance by more bytes than the
> + *             size of the dynptr.
> + *     Return
> + *             0 on success, -EINVAL if the dynptr is invalid or **flags** is not 0,
> + *             -ERANGE if attempting to iterate more bytes than available, or other
> + *             negative error if **callback_fn** returns an error.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5752,6 +5771,7 @@ union bpf_attr {
>         FN(dynptr_get_size),            \
>         FN(dynptr_get_offset),          \
>         FN(dynptr_clone),               \
> +       FN(dynptr_iterator),            \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> --
> 2.30.2
>
