Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2B059091D
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 01:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiHKXXA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 19:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235268AbiHKXW7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 19:22:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB6A1A47;
        Thu, 11 Aug 2022 16:22:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id j8so36046295ejx.9;
        Thu, 11 Aug 2022 16:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Z2AJqwintXOLtDhz73dm9+tuZkZx/x82WcYpxhpuU9A=;
        b=AtjqvLiIIHgzN0GaYYCDp/e1W5qnUnaseF69QWxY0cNzN5Qy4kmKSug+wAvNCbrL0F
         1eDWr+ZuNvl3KZn9/7QGzaW/DEHaruMmHcvd423Cjz17ReeYE7E9IRblaTBcZty0POg3
         TkjSxFE3USnvr9JuheeTGnCs/tZslY5IEL1D0gfuJ7rf8hoeH7ykNt9Qgkiuw7ZrizdE
         txFnI265Zxxz2ALJCaj1iaTi6P2190OJVuSX5AAZ+oe4gaJ8WFrZLJjrjif9pCB+HLz3
         q1Z+mZ/Ni/6ZQNs5v6xeaxKoJzNi9fXSMNxnbNtgLwvOFkhsuw4mBx0rD80duu1U3x9V
         vU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Z2AJqwintXOLtDhz73dm9+tuZkZx/x82WcYpxhpuU9A=;
        b=jHoPAUq/xGzAUSH3Rb59xJzaO5h7YXLWbawUwk+Rykx3QSifgJWy5YDBOioa68GiuU
         Au26wrJc1DhLfnpmLxx0cLTu00pAiN1Ky6mzmTOACdXDhGQg7gXC0jeXTV0b/juq4+wb
         DaVeMDUJGct7TwTdnD0RqaZheB4Mu6sbgkmR0Qurjm6ZAngbzmvzEOewqc7ZYVLKHRFM
         UKDUmjHzYwgPouCiG0p6HnV7PxFCutBsPFH6KYnIB+5BQLkuZQIyAXSbnuADTcUqff7f
         l6dNqpCiejKbPE1c+RwYN9iWocedAgSnXoaCXcHmO54qkwrYGumcyFTaDconwEM9Rbbv
         5XPQ==
X-Gm-Message-State: ACgBeo3vPIft48AO1qXcGcJnD8SDJjtpykwjfFFIJisP3jxjc/pyA5Pn
        N4wI54DIj25oQ8UnVwkFOnyZkI3e+KjTMVMXvKA=
X-Google-Smtp-Source: AA6agR4nNm8xjWCGLOtY5iEs+AIurjyA7YV6zO5S9xeOHEtgg4VvAUHbKclI4xerlnS4U1K3zlekADySvqXHfakd/VQ=
X-Received: by 2002:a17:907:1361:b0:730:8f59:6434 with SMTP id
 yo1-20020a170907136100b007308f596434mr850350ejb.745.1660260175319; Thu, 11
 Aug 2022 16:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155341.2479054-1-void@manifault.com> <20220808155341.2479054-3-void@manifault.com>
In-Reply-To: <20220808155341.2479054-3-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Aug 2022 16:22:43 -0700
Message-ID: <CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com>
Subject: Re: [PATCH 3/5] bpf: Add bpf_user_ringbuf_drain() helper
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
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

On Mon, Aug 8, 2022 at 8:54 AM David Vernet <void@manifault.com> wrote:
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

This commit message is a bit too laconic. There is a lot of
implications of various parts of this patch, it would be great to
highlight most important ones. Please consider elaborating a bit more.

>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  include/linux/bpf.h            |   6 +-
>  include/uapi/linux/bpf.h       |   8 ++
>  kernel/bpf/helpers.c           |   2 +
>  kernel/bpf/ringbuf.c           | 157 +++++++++++++++++++++++++++++++--
>  kernel/bpf/verifier.c          |  57 +++++++++++-
>  tools/include/uapi/linux/bpf.h |   8 ++
>  6 files changed, 228 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 20c26aed7896..4d0d5f2a3ac8 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -401,7 +401,7 @@ enum bpf_type_flag {
>         /* DYNPTR points to memory local to the bpf program. */
>         DYNPTR_TYPE_LOCAL       = BIT(8 + BPF_BASE_TYPE_BITS),
>
> -       /* DYNPTR points to a ringbuf record. */
> +       /* DYNPTR points to a kernel-produced ringbuf record. */
>         DYNPTR_TYPE_RINGBUF     = BIT(9 + BPF_BASE_TYPE_BITS),
>
>         /* Size is known at compile time. */
> @@ -606,6 +606,7 @@ enum bpf_reg_type {
>         PTR_TO_MEM,              /* reg points to valid memory region */
>         PTR_TO_BUF,              /* reg points to a read/write buffer */
>         PTR_TO_FUNC,             /* reg points to a bpf program function */
> +       PTR_TO_DYNPTR,           /* reg points to a dynptr */
>         __BPF_REG_TYPE_MAX,
>
>         /* Extended reg_types. */
> @@ -2410,6 +2411,7 @@ extern const struct bpf_func_proto bpf_loop_proto;
>  extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
>  extern const struct bpf_func_proto bpf_set_retval_proto;
>  extern const struct bpf_func_proto bpf_get_retval_proto;
> +extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> @@ -2554,7 +2556,7 @@ enum bpf_dynptr_type {
>         BPF_DYNPTR_TYPE_INVALID,
>         /* Points to memory that is local to the bpf program */
>         BPF_DYNPTR_TYPE_LOCAL,
> -       /* Underlying data is a ringbuf record */
> +       /* Underlying data is a kernel-produced ringbuf record */
>         BPF_DYNPTR_TYPE_RINGBUF,
>  };
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index a341f877b230..ca125648d7fd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5332,6 +5332,13 @@ union bpf_attr {
>   *             **-EACCES** if the SYN cookie is not valid.
>   *
>   *             **-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
> + *
> + * long bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx, u64 flags)
> + *     Description
> + *             Drain samples from the specified user ringbuffer, and invoke the
> + *             provided callback for each such sample.

please specify what's the expected signature of callback_fn

> + *     Return
> + *             An error if a sample could not be drained.

Negative error, right? And might be worth it briefly describing what
are the situation(s) when you won't be able to drain a sample?

Also please clarify if having no sample to drain is an error or not?

It's also important to specify that if no error (and -ENODATA
shouldn't be an error, actually) occurred then we get number of
consumed samples back.

>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5542,6 +5549,7 @@ union bpf_attr {
>         FN(tcp_raw_gen_syncookie_ipv6), \
>         FN(tcp_raw_check_syncookie_ipv4),       \
>         FN(tcp_raw_check_syncookie_ipv6),       \
> +       FN(user_ringbuf_drain),         \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 1f961f9982d2..b8097876014c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1647,6 +1647,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_dynptr_write_proto;
>         case BPF_FUNC_dynptr_data:
>                 return &bpf_dynptr_data_proto;
> +       case BPF_FUNC_user_ringbuf_drain:
> +               return &bpf_user_ringbuf_drain_proto;
>         default:
>                 break;
>         }
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 29e2de42df15..fc589fc8eb7c 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -291,16 +291,33 @@ static unsigned long ringbuf_avail_data_sz(struct bpf_ringbuf *rb)
>  }
>
>  static __poll_t ringbuf_map_poll(struct bpf_map *map, struct file *filp,
> -                                struct poll_table_struct *pts)
> +                                struct poll_table_struct *pts,
> +                                bool kernel_producer)
>  {
>         struct bpf_ringbuf_map *rb_map;
> +       bool buffer_empty;
>
>         rb_map = container_of(map, struct bpf_ringbuf_map, map);
>         poll_wait(filp, &rb_map->rb->waitq, pts);
>
> -       if (ringbuf_avail_data_sz(rb_map->rb))
> -               return EPOLLIN | EPOLLRDNORM;
> -       return 0;
> +       buffer_empty = !ringbuf_avail_data_sz(rb_map->rb);
> +
> +       if (kernel_producer)
> +               return buffer_empty ? 0 : EPOLLIN | EPOLLRDNORM;
> +       else
> +               return buffer_empty ? EPOLLOUT | EPOLLWRNORM : 0;
> +}
> +
> +static __poll_t ringbuf_map_poll_kern(struct bpf_map *map, struct file *filp,
> +                                     struct poll_table_struct *pts)
> +{
> +       return ringbuf_map_poll(map, filp, pts, true);
> +}
> +
> +static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
> +                                     struct poll_table_struct *pts)
> +{
> +       return ringbuf_map_poll(map, filp, pts, false);
>  }

This is an even stronger case where I think we should keep two
implementations completely separate. Please keep existing
ringbuf_map_poll as is and just add a user variant as a separate
implementation

>
>  BTF_ID_LIST_SINGLE(ringbuf_map_btf_ids, struct, bpf_ringbuf_map)
> @@ -309,7 +326,7 @@ const struct bpf_map_ops ringbuf_map_ops = {
>         .map_alloc = ringbuf_map_alloc,
>         .map_free = ringbuf_map_free,
>         .map_mmap = ringbuf_map_mmap_kern,
> -       .map_poll = ringbuf_map_poll,
> +       .map_poll = ringbuf_map_poll_kern,
>         .map_lookup_elem = ringbuf_map_lookup_elem,
>         .map_update_elem = ringbuf_map_update_elem,
>         .map_delete_elem = ringbuf_map_delete_elem,
> @@ -323,6 +340,7 @@ const struct bpf_map_ops user_ringbuf_map_ops = {
>         .map_alloc = ringbuf_map_alloc,
>         .map_free = ringbuf_map_free,
>         .map_mmap = ringbuf_map_mmap_user,
> +       .map_poll = ringbuf_map_poll_user,
>         .map_lookup_elem = ringbuf_map_lookup_elem,
>         .map_update_elem = ringbuf_map_update_elem,
>         .map_delete_elem = ringbuf_map_delete_elem,
> @@ -605,3 +623,132 @@ const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto = {
>         .arg1_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
>         .arg2_type      = ARG_ANYTHING,
>  };
> +
> +static int __bpf_user_ringbuf_poll(struct bpf_ringbuf *rb, void **sample,
> +                                  u32 *size)

"poll" part is quite confusing as it has nothing to do with epoll and
the other poll implementation. Maybe "peek"? It peek into next sample
without consuming it, seems appropriate

nit: this declaration can also stay on single line

> +{
> +       unsigned long cons_pos, prod_pos;
> +       u32 sample_len, total_len;
> +       u32 *hdr;
> +       int err;
> +       int busy = 0;

nit: combine matching types:

u32 sample_len, total_len, *hdr;
int err, busy = 0;

> +
> +       /* If another consumer is already consuming a sample, wait for them to
> +        * finish.
> +        */
> +       if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
> +               return -EBUSY;
> +
> +       /* Synchronizes with smp_store_release() in user-space. */
> +       prod_pos = smp_load_acquire(&rb->producer_pos);

I think we should enforce that prod_pos is a multiple of 8

> +       /* Synchronizes with smp_store_release() in
> +        * __bpf_user_ringbuf_sample_release().
> +        */
> +       cons_pos = smp_load_acquire(&rb->consumer_pos);
> +       if (cons_pos >= prod_pos) {
> +               atomic_set(&rb->busy, 0);
> +               return -ENODATA;
> +       }
> +
> +       hdr = (u32 *)((uintptr_t)rb->data + (cons_pos & rb->mask));
> +       sample_len = *hdr;

do we need smp_load_acquire() here? libbpf's ring_buffer
implementation uses load_acquire here


> +
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

round up to closest multiple of 8? All the pointers into ringbuf data
area should be 8-byte aligned

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

nit: unnecessary empty line

and please keep single-line comments as single-line, no */ on separate
line in such case

> +       *sample = (void *)((uintptr_t)rb->data +
> +                          ((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
> +       *size = sample_len;
> +
> +       return 0;
> +}
> +
> +static void
> +__bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size,
> +                                 u64 flags)

try to keep single lines if they are under 100 characters

> +{
> +
> +

empty lines, why?

> +       /* To release the ringbuffer, just increment the producer position to
> +        * signal that a new sample can be consumed. The busy bit is cleared by
> +        * userspace when posting a new sample to the ringbuffer.
> +        */
> +       smp_store_release(&rb->consumer_pos, rb->consumer_pos + size +
> +                         BPF_RINGBUF_HDR_SZ);
> +
> +       if (flags & BPF_RB_FORCE_WAKEUP || !(flags & BPF_RB_NO_WAKEUP))

please use () around bit operator expressions

> +               irq_work_queue(&rb->work);
> +
> +       atomic_set(&rb->busy, 0);

set busy before scheduling irq_work? why delaying?

> +}
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

we don't check this for existing ringbuf, so maybe let's keep it
consistent? FORCE_WAKEUP is just stronger than NO_WAKEUP

> +
> +       rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
> +       do {
> +               u32 size;
> +               void *sample;
> +
> +               err = __bpf_user_ringbuf_poll(rb, &sample, &size);
> +

nit: don't keep empty line between function call and error check

> +               if (!err) {

so -ENODATA is a special error and you should stop if you get that.
But for any other error we should propagate error back, not just
silently consuming it

maybe

err = ...
if (err) {
    if (err == -ENODATA)
      break;
    return err;
}

?

> +                       struct bpf_dynptr_kern dynptr;
> +
> +                       bpf_dynptr_init(&dynptr, sample, BPF_DYNPTR_TYPE_LOCAL,
> +                                       0, size);

we should try to avoid unnecessary re-initialization of dynptr, let's
initialize it once and then just update data and size field inside the
loop?


> +                       ret = callback((u64)&dynptr,
> +                                       (u64)(uintptr_t)callback_ctx, 0, 0, 0);
> +
> +                       __bpf_user_ringbuf_sample_release(rb, size, flags);
> +                       num_samples++;
> +               }
> +       } while (err == 0 && num_samples < 4096 && ret == 0);
> +

4096 is pretty arbitrary. Definitely worth noting it somewhere and it
seems somewhat low, tbh...

ideally we'd cond_resched() from time to time, but that would require
BPF program to be sleepable, so we can't do that :(


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
> index 4a9562c62af0..99dfdc3ed187 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -555,6 +555,7 @@ static const char *reg_type_str(struct bpf_verifier_env *env,
>                 [PTR_TO_BUF]            = "buf",
>                 [PTR_TO_FUNC]           = "func",
>                 [PTR_TO_MAP_KEY]        = "map_key",
> +               [PTR_TO_DYNPTR]         = "dynptr_ptr",
>         };
>
>         if (type & PTR_MAYBE_NULL) {
> @@ -5656,6 +5657,12 @@ static const struct bpf_reg_types stack_ptr_types = { .types = { PTR_TO_STACK }
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
> @@ -5682,7 +5689,7 @@ static const struct bpf_reg_types *compatible_reg_types[__BPF_ARG_TYPE_MAX] = {
>         [ARG_PTR_TO_CONST_STR]          = &const_str_ptr_types,
>         [ARG_PTR_TO_TIMER]              = &timer_types,
>         [ARG_PTR_TO_KPTR]               = &kptr_types,
> -       [ARG_PTR_TO_DYNPTR]             = &stack_ptr_types,
> +       [ARG_PTR_TO_DYNPTR]             = &dynptr_types,
>  };
>
>  static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
> @@ -6025,6 +6032,13 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                 err = check_mem_size_reg(env, reg, regno, true, meta);
>                 break;
>         case ARG_PTR_TO_DYNPTR:
> +               /* We only need to check for initialized / uninitialized helper
> +                * dynptr args if the dynptr is not MEM_ALLOC, as the assumption
> +                * is that if it is, that a helper function initialized the
> +                * dynptr on behalf of the BPF program.
> +                */
> +               if (reg->type & MEM_ALLOC)

Isn't PTR_TO_DYNPTR enough indication? Do we need MEM_ALLOC modifier?
Normal dynptr created and used inside BPF program on the stack are
actually PTR_TO_STACK, so that should be enough distinction? Or am I
missing something?

> +                       break;
>                 if (arg_type & MEM_UNINIT) {
>                         if (!is_dynptr_reg_valid_uninit(env, reg)) {
>                                 verbose(env, "Dynptr has to be an uninitialized dynptr\n");
> @@ -6197,7 +6211,9 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
> @@ -6317,6 +6333,10 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
> @@ -6901,6 +6921,29 @@ static int set_find_vma_callback_state(struct bpf_verifier_env *env,
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
> @@ -7345,6 +7388,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                         }
>                 }
>                 break;
> +       case BPF_FUNC_user_ringbuf_drain:
> +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> +                                       set_user_ringbuf_callback_state);
> +               break;
>         }
>
>         if (err)
> @@ -7477,11 +7524,15 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 /* Find the id of the dynptr we're acquiring a reference to */
>                 for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>                         if (arg_type_is_dynptr(fn->arg_type[i])) {
> +                               struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
> +
>                                 if (dynptr_id) {
>                                         verbose(env, "verifier internal error: multiple dynptr args in func\n");
>                                         return -EFAULT;
>                                 }
> -                               dynptr_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> +
> +                               if (!(reg->type & MEM_ALLOC))
> +                                       dynptr_id = stack_slot_get_id(env, reg);

this part has changed in bpf-next

>                         }
>                 }
>                 /* For release_reference() */
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index ce0ce713faf9..e5e4ab12177c 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5332,6 +5332,13 @@ union bpf_attr {
>   *             **-EACCES** if the SYN cookie is not valid.
>   *
>   *             **-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
> + *
> + * long bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx, u64 flags)
> + *     Description
> + *             Drain samples from the specified user ringbuffer, and invoke the
> + *             provided callback for each such sample.
> + *     Return
> + *             An error if a sample could not be drained.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5542,6 +5549,7 @@ union bpf_attr {
>         FN(tcp_raw_gen_syncookie_ipv6), \
>         FN(tcp_raw_check_syncookie_ipv4),       \
>         FN(tcp_raw_check_syncookie_ipv6),       \
> +       FN(bpf_user_ringbuf_drain),     \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> --
> 2.30.2
>
