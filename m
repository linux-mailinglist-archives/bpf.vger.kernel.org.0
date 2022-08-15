Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA00594E0E
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 03:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiHPBct (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Aug 2022 21:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239271AbiHPBcd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Aug 2022 21:32:33 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D491DCF07
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 14:23:18 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31f661b3f89so104386707b3.11
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9KhVfQiZJTB3iS7qqWimw3uVdUCxrYOOCMBmJwoMmuw=;
        b=rLDnYs+cSgwcHUYZv4MvAtP/5HUPrfFGM5rmRWdVhc4iH6gq7H72nxbrV33WkLPhzt
         UEFHFRWATCK99jcKcP5jKDJ5ElSOk2QaPislIjjpfht369gCetrkbYqbJ3qQJJAkfqKf
         qs4wmBSwQ0miE9wzxyGpiYW6KUb5T9A2uJYbVjFa1m8h0JeEbwc/ljp2wJWxeTZjxciP
         vKoqGGQ22pY8CmL6RqkH5z6zwTeu60IV7FEha+XKrRUh0sfo9NKbHAOcm1sY9XfNX+2z
         fy9Oj9ZNTFh8wfuNW82/4R+I1lB2pL61aaEh1JOWmfZ6X1WEGFhx0adoHEJr9xJ9DV5k
         OmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9KhVfQiZJTB3iS7qqWimw3uVdUCxrYOOCMBmJwoMmuw=;
        b=Nx017CC3W+KZwr8tvjyyBxknajEOkN8UhXiJPpR/N2KBU7q24IQXdSp7Tr4goDBj6V
         oI7J0whEtdty62NZVvkrCEhw3wg3TOObHN64+cQ7qoyBYHAzy7GplWda0vtwfwmvHT5b
         eOk7ceC4tHlQmNPLu2zr1PSNEnOPFtmvTdUx6kUgIe6HFqfSb7XuVU2Qi0MlzHWYiarg
         FkuQ5The8qwj2mthtm9FC46xz/4yPX5MoJj7oWxoHELqRDJiCr8nwdrxhXnraiSlM5fT
         4J+DjTn4sE3clj8HCJc/aPCuy9CRYwvQyL7NF+4yApuf3wM6QDP7egRWflfc+ZGbE8nb
         2+jA==
X-Gm-Message-State: ACgBeo3qXkTNCNGiRb1SoJpEWSMx88KJcGuT3Lrf8c8NJYqNwYcG9Zny
        Ud/Ss+WFGEA0qYBihUa8ai1OoYCg+CYKPM1P53qnDA==
X-Google-Smtp-Source: AA6agR682dvuatokW7knjcwIrb+8aNj7MGDj3a2VmHDgPr7GabbB5JTF8iMuNh7U/sVZT0oqVOjKoc8QiQGBjpnQoQQ=
X-Received: by 2002:a81:4806:0:b0:32f:f84c:f30a with SMTP id
 v6-20020a814806000000b0032ff84cf30amr7606881ywa.107.1660598595646; Mon, 15
 Aug 2022 14:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220811234941.887747-1-void@manifault.com> <20220811234941.887747-3-void@manifault.com>
In-Reply-To: <20220811234941.887747-3-void@manifault.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 15 Aug 2022 14:23:04 -0700
Message-ID: <CA+khW7jW6mgu2+DZyJMSX1beRYk917S=824NLFG7M5D1+2F57w@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] bpf: Add bpf_user_ringbuf_drain() helper
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, joannelkoong@gmail.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com, kernel-team@fb.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 11, 2022 at 4:50 PM David Vernet <void@manifault.com> wrote:
>
> Now that we have a BPF_MAP_TYPE_USER_RINGBUF map type, we need to add a
> helper function that allows BPF programs to drain samples from the ring
> buffer, and invoke a callback for each. This patch adds a new
> bpf_user_ringbuf_drain() helper that provides this abstraction.
>
> In order to support this, we needed to also add a new PTR_TO_DYNPTR
> register type to reflect a dynptr that was allocated by a helper function
> and passed to a BPF program. The verifier currently only supports
> PTR_TO_DYNPTR registers that are also DYNPTR_TYPE_LOCAL and MEM_ALLOC.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
[...]
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index c0f3bca4bb09..73fa6ed12052 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
[...]
> +static int __bpf_user_ringbuf_poll(struct bpf_ringbuf *rb, void **sample,
> +                                  u32 *size)
> +{
> +       unsigned long cons_pos, prod_pos;
> +       u32 sample_len, total_len;
> +       u32 *hdr;
> +       int err;
> +       int busy = 0;
> +
> +       /* If another consumer is already consuming a sample, wait for them to
> +        * finish.
> +        */
> +       if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
> +               return -EBUSY;
> +
> +       /* Synchronizes with smp_store_release() in user-space. */
> +       prod_pos = smp_load_acquire(&rb->producer_pos);
> +       /* Synchronizes with smp_store_release() in
> +        * __bpf_user_ringbuf_sample_release().
> +        */
> +       cons_pos = smp_load_acquire(&rb->consumer_pos);
> +       if (cons_pos >= prod_pos) {
> +               atomic_set(&rb->busy, 0);
> +               return -ENODATA;
> +       }
> +
> +       hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
> +       sample_len = *hdr;
> +

rb->data and rb->mask better be protected by READ_ONCE.

> +       /* Check that the sample can fit into a dynptr. */
> +       err = bpf_dynptr_check_size(sample_len);
> +       if (err) {
> +               atomic_set(&rb->busy, 0);
> +               return err;
> +       }
> +
> +       /* Check that the sample fits within the region advertised by the
> +        * consumer position.
> +        */
> +       total_len = sample_len + BPF_RINGBUF_HDR_SZ;
> +       if (total_len > prod_pos - cons_pos) {
> +               atomic_set(&rb->busy, 0);
> +               return -E2BIG;
> +       }
> +
> +       /* Check that the sample fits within the data region of the ring buffer.
> +        */
> +       if (total_len > rb->mask + 1) {
> +               atomic_set(&rb->busy, 0);
> +               return -E2BIG;
> +       }
> +
> +       /* consumer_pos is updated when the sample is released.
> +        */
> +
> +       *sample = (void *)((uintptr_t)rb->data +
> +                          (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
> +       *size = sample_len;
> +
> +       return 0;
> +}
> +
> +static void
> +__bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size,
> +                                 u64 flags)
> +{
> +
> +
> +       /* To release the ringbuffer, just increment the producer position to
> +        * signal that a new sample can be consumed. The busy bit is cleared by
> +        * userspace when posting a new sample to the ringbuffer.
> +        */
> +       smp_store_release(&rb->consumer_pos, rb->consumer_pos + size +
> +                         BPF_RINGBUF_HDR_SZ);
> +
> +       if (flags & BPF_RB_FORCE_WAKEUP || !(flags & BPF_RB_NO_WAKEUP))
> +               irq_work_queue(&rb->work);
> +
> +       atomic_set(&rb->busy, 0);
> +}

atomic_set() doesn't imply barrier, so it could be observed before
smp_store_release(). So the paired smp_load_acquire could observe
rb->busy == 0 while seeing the old consumer_pos. At least, you need
smp_mb__before_atomic() as a barrier before atomic_set. Or smp_wmb()
to ensure all _writes_ complete when see rb->busy == 0.

Similarly rb->work could be observed before smp_store_release.

Is it possible for __bpf_user_ringbuf_sample_release to be called
concurrently? If yes, there are races. Because the load of
rb->consumer_pos is not protected by smp_load_acquire, they are not
synchronized with this smp_store_release. Concurrently calling
__bpf_user_ringbuf_sample_release may cause both threads getting stale
consumer_pos values.



> +
> +BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> +          void *, callback_fn, void *, callback_ctx, u64, flags)
> +{
> +       struct bpf_ringbuf *rb;
> +       long num_samples = 0, ret = 0;
> +       int err;
> +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> +       u64 wakeup_flags = BPF_RB_NO_WAKEUP | BPF_RB_FORCE_WAKEUP;
> +
> +       if (unlikely(flags & ~wakeup_flags))
> +               return -EINVAL;
> +
> +       /* The two wakeup flags are mutually exclusive. */
> +       if (unlikely((flags & wakeup_flags) == wakeup_flags))
> +               return -EINVAL;
> +
> +       rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
> +       do {
> +               u32 size;
> +               void *sample;
> +
> +               err = __bpf_user_ringbuf_poll(rb, &sample, &size);
> +
> +               if (!err) {
> +                       struct bpf_dynptr_kern dynptr;
> +
> +                       bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL,
> +                                       0, size);
> +                       ret = callback((uintptr_t)&dynptr,
> +                                      (uintptr_t)callback_ctx, 0, 0, 0);
> +
> +                       __bpf_user_ringbuf_sample_release(rb, size, flags);
> +                       num_samples++;
> +               }
> +       } while (err == 0 && num_samples < 4096 && ret == 0);
> +
> +       return num_samples;
> +}
> +
> +const struct bpf_func_proto bpf_user_ringbuf_drain_proto = {
> +       .func           = bpf_user_ringbuf_drain,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_CONST_MAP_PTR,
> +       .arg2_type      = ARG_PTR_TO_FUNC,
> +       .arg3_type      = ARG_PTR_TO_STACK_OR_NULL,
> +       .arg4_type      = ARG_ANYTHING,
> +};
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 970ec5c7ce05..211322b3317b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -561,6 +561,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>                 [PTR_TO_BUF]            = "buf",
>                 [PTR_TO_FUNC]           = "func",
>                 [PTR_TO_MAP_KEY]        = "map_key",
> +               [PTR_TO_DYNPTR]         = "dynptr_ptr",
>         };
>
>         if (type & PTR_MAYBE_NULL) {
> @@ -5662,6 +5663,12 @@ static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK }
>  static const struct bpf_reg_types const_str_ptr_types = { .types = { PTR_TO_MAP_VALUE } };
>  static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE } };
>  static const struct bpf_reg_types kptr_types = { .types = { PTR_TO_MAP_VALUE } };
> +static const struct bpf_reg_types dynptr_types = {
> +       .types = {
> +               PTR_TO_STACK,
> +               PTR_TO_DYNPTR | MEM_ALLOC | DYNPTR_TYPE_LOCAL,
> +       }
> +};
>
>  static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>         [ARG_PTR_TO_MAP_KEY]            = &map_key_value_types,
> @@ -5688,7 +5695,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>         [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
>         [ARG_PTR_TO_TIMER]              = &timer_types,
>         [ARG_PTR_TO_KPTR]               = &kptr_types,
> -       [ARG_PTR_TO_DYNPTR]             = &stack_ptr_types,
> +       [ARG_PTR_TO_DYNPTR]             = &dynptr_types,
>  };
>
>  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> @@ -6031,6 +6038,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 err = check_mem_size_reg(env, reg, regno, true, meta);
>                 break;
>         case ARG_PTR_TO_DYNPTR:
> +               /* We only need to check for initialized / uninitialized helper
> +                * dynptr args if the dynptr is not MEM_ALLOC, as the assumption
> +                * is that if it is, that a helper function initialized the
> +                * dynptr on behalf of the BPF program.
> +                */
> +               if (reg->type & MEM_ALLOC)
> +                       break;
>                 if (arg_type & MEM_UNINIT) {
>                         if (!is_dynptr_reg_valid_uninit(env, reg)) {
>                                 verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> @@ -6203,7 +6217,9 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>                         goto error;
>                 break;
>         case BPF_MAP_TYPE_USER_RINGBUF:
> -               goto error;
> +               if (func_id != BPF_FUNC_user_ringbuf_drain)
> +                       goto error;
> +               break;
>         case BPF_MAP_TYPE_STACK_TRACE:
>                 if (func_id != BPF_FUNC_get_stackid)
>                         goto error;
> @@ -6323,6 +6339,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
>                 if (map->map_type != BPF_MAP_TYPE_RINGBUF)
>                         goto error;
>                 break;
> +       case BPF_FUNC_user_ringbuf_drain:
> +               if (map->map_type != BPF_MAP_TYPE_USER_RINGBUF)
> +                       goto error;
> +               break;
>         case BPF_FUNC_get_stackid:
>                 if (map->map_type != BPF_MAP_TYPE_STACK_TRACE)
>                         goto error;
> @@ -6878,6 +6898,29 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
>         return 0;
>  }
>
> +static int set_user_ringbuf_callback_state(struct bpf_verifier_env *env,
> +                                          struct bpf_func_state *caller,
> +                                          struct bpf_func_state *callee,
> +                                          int insn_idx)
> +{
> +       /* bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void
> +        *                        callback_ctx, u64 flags);
> +        * callback_fn(struct bpf_dynptr_t* dynptr, void *callback_ctx);
> +        */
> +       __mark_reg_not_init(env, &callee->regs[BPF_REG_0]);
> +       callee->regs[BPF_REG_1].type = PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_ALLOC;
> +       __mark_reg_known_zero(&callee->regs[BPF_REG_1]);
> +       callee->regs[BPF_REG_2] = caller->regs[BPF_REG_3];
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
>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  {
>         struct bpf_verifier_state *state = env->cur_state;
> @@ -7156,7 +7199,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>         struct bpf_reg_state *regs;
>         struct bpf_call_arg_meta meta;
>         int insn_idx = *insn_idx_p;
> -       bool changes_data;
> +       bool changes_data, mem_alloc_dynptr;
>         int i, err, func_id;
>
>         /* find function prototype */
> @@ -7323,22 +7366,34 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 }
>                 break;
>         case BPF_FUNC_dynptr_data:
> +               mem_alloc_dynptr = false;
>                 for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>                         if (arg_type_is_dynptr(fn->arg_type[i])) {
> +                               struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
> +
>                                 if (meta.ref_obj_id) {
>                                         verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
>                                         return -EFAULT;
>                                 }
> -                               /* Find the id of the dynptr we're tracking the reference of */
> -                               meta.ref_obj_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> +
> +                               mem_alloc_dynptr = reg->type & MEM_ALLOC;
> +                               if (!mem_alloc_dynptr)
> +                                       /* Find the id of the dynptr we're
> +                                        * tracking the reference of
> +                                        */
> +                                       meta.ref_obj_id = stack_slot_get_id(env, reg);
>                                 break;
>                         }
>                 }
> -               if (i == MAX_BPF_FUNC_REG_ARGS) {
> +               if (!mem_alloc_dynptr && i == MAX_BPF_FUNC_REG_ARGS) {
>                         verbose(env, "verifier internal error: no dynptr in bpf_dynptr_data()\n");
>                         return -EFAULT;
>                 }
>                 break;
> +       case BPF_FUNC_user_ringbuf_drain:
> +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +                                       set_user_ringbuf_callback_state);
> +               break;
>         }
>
>         if (err)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index ee04b71969b4..76909f43fc0e 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5354,6 +5354,12 @@ union bpf_attr {
>   *     Return
>   *             Current *ktime*.
>   *
> + * long bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx, u64 flags)
> + *     Description
> + *             Drain samples from the specified user ringbuffer, and invoke the
> + *             provided callback for each such sample.
> + *     Return
> + *             An error if a sample could not be drained.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5565,6 +5571,7 @@ union bpf_attr {
>         FN(tcp_raw_check_syncookie_ipv4),       \
>         FN(tcp_raw_check_syncookie_ipv6),       \
>         FN(ktime_get_tai_ns),           \
> +       FN(bpf_user_ringbuf_drain),     \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> --
> 2.37.1
>
