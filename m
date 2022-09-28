Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DCF5EE95C
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiI1W3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 18:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiI1W3x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 18:29:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A95357CC
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:29:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id b2so7093374eja.6
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=D2g4lY4TVmPEcXya3+h1zXz3k3p4QMJpbGBy7gZDO+s=;
        b=UatI5lMSHXkTWztIbzds4D27w1Jtbw9ZlBv2/68+VSZxf9vELN8OINQ337tFP5T1vk
         FbzIO+eBV8j9VzkPWqZ7m8x+caxuThAw5i+0mmlamTagPjeIAo/WkpShMdJsoTpgyb4m
         O4uGNjf9OHSsLcR3s+04ZOizwb6jCuazX7Be7Ekevz0hieIFDYPrMrHmW7XOfKPvn6xy
         ny3mZMooX4nD7RO3+qD7q20x+0TVPC3V8hd7IkOQEkt+peeFE7B17WtdoJiq/vwP04Oe
         gMtEtuwL7newoO/lMvN6+tviJ+DZPuP8dCTlD8mphnuEX9upbgrxJ84BZ/m8m5kL82BV
         jRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=D2g4lY4TVmPEcXya3+h1zXz3k3p4QMJpbGBy7gZDO+s=;
        b=bVqO62z7XujZn4F1GpE/4jV1jofd5zTqdrqx4+4YhhxWzMKUHil9cZu6Uz6UdcXjxQ
         T41/5/q97MExVHP5hR+/h0HvPKF3fttZAzVExGdV9iVgYd3MefptDdAz2wGEQL20bNmS
         DD3oj73o/ELU9n6bzPMMZAkR0zufMwpfFiRDugRkTcvHhxQnBn5UMNfAgKftlJqy6qn/
         9j7ns0NYDJ4bTSWp/LACPWGksis5BpC08uBjX32p3sfH9ylPjVSJKazFF2gdvvrQe6wI
         uPFVBhUojBqtMh+pgFmn51jgAYLfH10QlmZ6QbJYsWAaXCFIhxUiBE2LrIOiye79WOQi
         oHZA==
X-Gm-Message-State: ACrzQf1ka8srR32eRLLQgeC7u36N+MD8+50kq0Qy7svFnqdbiWplSKV9
        f+I+svtKftKyFgxr0QtF8ZbOtgr/alOi7lNzZwc=
X-Google-Smtp-Source: AMsMyM5HLwVwrearGTfoE2K05ROoW+8kdg+xsNKXcRkSaV7Ky7+1YR/LNXsR0wrQVUS+wI2zR8MSAyyEH5mQPHHQUbw=
X-Received: by 2002:a17:907:3d86:b0:782:1175:153f with SMTP id
 he6-20020a1709073d8600b007821175153fmr130039ejc.226.1664404189834; Wed, 28
 Sep 2022 15:29:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com> <20220908000254.3079129-6-joannelkoong@gmail.com>
In-Reply-To: <20220908000254.3079129-6-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 15:29:37 -0700
Message-ID: <CAEf4BzYP2exgEXuP1mmA0+w7C+o_UDpDWnJUdHqSiKCoCXdUFQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 5/8] bpf: Add bpf_dynptr_clone
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

On Wed, Sep 7, 2022 at 5:07 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add a new helper, bpf_dynptr_clone, which clones a dynptr.
>
> The cloned dynptr will point to the same data as its parent dynptr,
> with the same type, offset, size and read-only properties.
>
> Any writes to a dynptr will be reflected across all instances
> (by 'instance', this means any dynptrs that point to the same
> underlying data).
>
> Please note that data slice and dynptr invalidations will affect all
> instances as well. For example, if bpf_dynptr_write() is called on an
> skb-type dynptr, all data slices of dynptr instances to that skb
> will be invalidated as well (eg data slices of any clones, parents,
> grandparents, ...). Another example is if a ringbuf dynptr is submitted,
> any instance of that dynptr will be invalidated.
>
> Changing the view of the dynptr (eg advancing the offset or
> trimming the size) will only affect that dynptr and not affect any
> other instances.
>
> One example use case where cloning may be helpful is for hashing or
> iterating through dynptr data. Cloning will allow the user to maintain
> the original view of the dynptr for future use, while also allowing
> views to smaller subsets of the data after the offset is advanced or the
> size is trimmed.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/uapi/linux/bpf.h       |  24 +++++++
>  kernel/bpf/helpers.c           |  23 +++++++
>  kernel/bpf/verifier.c          | 116 +++++++++++++++++++++------------
>  tools/include/uapi/linux/bpf.h |  24 +++++++
>  4 files changed, 147 insertions(+), 40 deletions(-)
>

This is a very important helper in practice, looking forward to have
it as part of dynptr API family!

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 4ca07cf500d2..16973fa4d073 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5508,6 +5508,29 @@ union bpf_attr {
>   *     Return
>   *             The offset of the dynptr on success, -EINVAL if the dynptr is
>   *             invalid.
> + *
> + * long bpf_dynptr_clone(struct bpf_dynptr *ptr, struct bpf_dynptr *clone)

const struct bpf_dynptr *ptr to make it clear that ptr is not
modified. We can also use src and dst terminology here for less
ambiguity.

> + *     Description
> + *             Clone an initialized dynptr *ptr*. After this call, both *ptr*
> + *             and *clone* will point to the same underlying data.
> + *
> + *             *clone* must be an uninitialized dynptr.
> + *
> + *             Any data slice or dynptr invalidations will apply equally for
> + *             both dynptrs after this call. For example, if ptr1 is a
> + *             ringbuf-type dynptr with multiple data slices that is cloned to
> + *             ptr2, if ptr2 discards the ringbuf sample, then ptr2, ptr2's
> + *             data slices, ptr1, and ptr1's data slices will all be
> + *             invalidated.
> + *
> + *             This is convenient for getting different "views" to the same
> + *             data. For instance, if one wishes to hash only a particular
> + *             section of data, one can clone the dynptr, advance it to a
> + *             specified offset and trim it to a specified size, pass it
> + *             to the hash function, and discard it after hashing, without
> + *             losing access to the original view of the dynptr.
> + *     Return
> + *             0 on success, -EINVAL if the dynptr to clone is invalid.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5728,6 +5751,7 @@ union bpf_attr {
>         FN(dynptr_is_rdonly),           \
>         FN(dynptr_get_size),            \
>         FN(dynptr_get_offset),          \
> +       FN(dynptr_clone),               \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 62ed27444b73..667f1e213a61 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1762,6 +1762,27 @@ static const struct bpf_func_proto bpf_dynptr_get_offset_proto = {
>         .arg1_type      = ARG_PTR_TO_DYNPTR,
>  };
>
> +BPF_CALL_2(bpf_dynptr_clone, struct bpf_dynptr_kern *, ptr,
> +          struct bpf_dynptr_kern *, clone)
> +{
> +       if (!ptr->data) {
> +               bpf_dynptr_set_null(clone);
> +               return -EINVAL;
> +       }

once we have MALLOC dynptr this will break without appropriate refcnt
bump. Let's have an explicit switch over all types of DYNPTR and error
out on "unknown" (really, forgotten) types of dynptr. Better safe than
having to debug corruptions in production.


> +
> +       memcpy(clone, ptr, sizeof(*clone));

*clone = *ptr?

> +
> +       return 0;
> +}
> +
> +static const struct bpf_func_proto bpf_dynptr_clone_proto = {
> +       .func           = bpf_dynptr_clone,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_DYNPTR,
> +       .arg2_type      = ARG_PTR_TO_DYNPTR | MEM_UNINIT,
> +};
> +
>  const struct bpf_func_proto bpf_get_current_task_proto __weak;
>  const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
>  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
> @@ -1846,6 +1867,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_dynptr_get_size_proto;
>         case BPF_FUNC_dynptr_get_offset:
>                 return &bpf_dynptr_get_offset_proto;
> +       case BPF_FUNC_dynptr_clone:
> +               return &bpf_dynptr_clone_proto;
>         default:
>                 break;
>         }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c312d931359d..8c8c101513f5 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -694,17 +694,38 @@ static enum bpf_dynptr_type arg_to_dynptr_type(enum bpf_arg_type arg_type)
>         }
>  }
>
> +static bool arg_type_is_dynptr(enum bpf_arg_type type)
> +{
> +       return base_type(type) == ARG_PTR_TO_DYNPTR;
> +}
> +
>  static bool dynptr_type_refcounted(enum bpf_dynptr_type type)

just noticed this name, I think it's quite confusing and will get even
more so with MALLOC dynptr. It's not really reference *counted*, more
like verifier *tracks references*, right? Consider renaming this to
avoid this confusion. MALLOC dynptr will be both reference tracked
(internally for verifier) and reference counted (at runtime to keep it
alive).

>  {
>         return type == BPF_DYNPTR_TYPE_RINGBUF;
>  }
>
> -static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> -                                  enum bpf_arg_type arg_type, int insn_idx)
> +static enum bpf_dynptr_type stack_slot_get_dynptr_info(struct bpf_verifier_env *env,
> +                                                      struct bpf_reg_state *reg,
> +                                                      int *ref_obj_id)
>  {
>         struct bpf_func_state *state = func(env, reg);
> -       enum bpf_dynptr_type type;
> -       int spi, i, id;
> +       int spi = get_spi(reg->off);
> +
> +       if (ref_obj_id)
> +               *ref_obj_id = state->stack[spi].spilled_ptr.id;
> +
> +       return state->stack[spi].spilled_ptr.dynptr.type;
> +}
> +
> +static int mark_stack_slots_dynptr(struct bpf_verifier_env *env,
> +                                  const struct bpf_func_proto *fn,
> +                                  struct bpf_reg_state *reg,
> +                                  enum bpf_arg_type arg_type,
> +                                  int insn_idx, int func_id)
> +{
> +       enum bpf_dynptr_type type = BPF_DYNPTR_TYPE_INVALID;
> +       struct bpf_func_state *state = func(env, reg);
> +       int spi, i, id = 0;
>
>         spi = get_spi(reg->off);
>
> @@ -716,7 +737,24 @@ static int mark_stack_slots_dynptr(struct bpf_verifier_env *env, struct bpf_reg_
>                 state->stack[spi - 1].slot_type[i] = STACK_DYNPTR;
>         }
>
> -       type = arg_to_dynptr_type(arg_type);
> +       if (func_id == BPF_FUNC_dynptr_clone) {
> +               /* find the type and id of the dynptr we're cloning and
> +                * assign it to the clone
> +                */
> +               for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> +                       enum bpf_arg_type t = fn->arg_type[i];
> +
> +                       if (arg_type_is_dynptr(t) && !(t & MEM_UNINIT)) {
> +                               type = stack_slot_get_dynptr_info(env,
> +                                                                 &state->regs[BPF_REG_1 + i],

so given we hard-coded BPF_FUNC_dynptr_clone func ID, we know that we
need first argument, so no need for this loop?

> +                                                                 &id);
> +                               break;
> +                       }
> +               }
> +       } else {
> +               type = arg_to_dynptr_type(arg_type);
> +       }
> +
>         if (type == BPF_DYNPTR_TYPE_INVALID)
>                 return -EINVAL;
>

[...]
