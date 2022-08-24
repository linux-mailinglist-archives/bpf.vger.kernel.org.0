Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD21A5A033E
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 23:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239719AbiHXVW7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 17:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiHXVW7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 17:22:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A19167D6;
        Wed, 24 Aug 2022 14:22:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id gb36so35900395ejc.10;
        Wed, 24 Aug 2022 14:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TaxwtaB3HvwyDk1N5cqaeYgh+6j8S3h48VfMZHiNWK0=;
        b=k4Q2ZsvO7WY//nuV97w7Lz1W4Dk4/9Pa5CQrP5MQ7buNkMwHi309Y/G6/9KN0bCRlp
         kPxMZyycO3BqncS8FbCLGfvC4bYLRFRi3XKg3H+XuVYvVlM510sUV8InodnGwBJ+cIDc
         7amdK+tp+2BfKAyIF89V0YQr8Gkh3iJg820ZR2fdb+LIavNiTLADK7gmTBDDNDxdxy0t
         XjNx8ADQzdiPGv9Gi9cHXT/Km4V7Gm2yKUxROK8e/kMrYujYypb8/XOhzZ6e4h7/9sUA
         Lq/O7sHT2YLlRxWydG4bcV+J376VUumvM8loyHyNz4BhmYdOGUY+fbqZbAOs5tvwo5Ki
         ukxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TaxwtaB3HvwyDk1N5cqaeYgh+6j8S3h48VfMZHiNWK0=;
        b=pa1XvSGp+JkswdzJmOLavM1RDjJQsLe5lbsgudiMtz9fe1akGRRXKKdE7Kiii8GJDk
         kk1MQvlTSFwtqU45OM7tTki/y15XjU71CFQPUbvkzAIIVT6XOoM5nOZtWYFfnCJeoFeo
         gyXtrsid6xs09Mk79oJB/CLnpMfUp0x7nOfBXUyemQYDEihT7XFAao6VBtnUmHDx6e9x
         gLo1j4SKFh0itT5/3lPMhHmz9Ap3J1MRp5D0sKMeV1hfITAllWDuV0d96f5e01LNMVsN
         eD/XmWaJHsZjujvzG7ehj2HdG+lH0oJ8NTyVXZOpbcdjvBbPtkr3v64BBUlRal/zaQ5M
         QUZg==
X-Gm-Message-State: ACgBeo2MmadDlMihiwtl4ms1DpiXoKK2FAmBTvuJ7ucgKJnoSYC1loQc
        4vdOHYlsGBVi8at79CMwa0sttJxKzEwbqACIKLM=
X-Google-Smtp-Source: AA6agR69K0DnwqxLOsjVUYt3EvIhvsD2vgcKJQUNSBaIYY4kgSBzisSwK3gRl7UJJu6dB0efRTKhQ0mllq0Nf/b38TI=
X-Received: by 2002:a17:906:8a43:b0:73d:7cc2:245e with SMTP id
 gx3-20020a1709068a4300b0073d7cc2245emr531916ejc.114.1661376175797; Wed, 24
 Aug 2022 14:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220818221212.464487-1-void@manifault.com> <20220818221212.464487-3-void@manifault.com>
In-Reply-To: <20220818221212.464487-3-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Aug 2022 14:22:44 -0700
Message-ID: <CAEf4BzY6oaCpHmh7x92mhqAVdPNDUe6GLndXHbqHx4i9QzjOsw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] bpf: Add bpf_user_ringbuf_drain() helper
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, joannelkoong@gmail.com, tj@kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Aug 18, 2022 at 3:12 PM David Vernet <void@manifault.com> wrote:
>
> In a prior change, we added a new BPF_MAP_TYPE_USER_RINGBUF map type which
> will allow user-space applications to publish messages to a ringbuffer that
> is consumed by a BPF program in kernel-space. In order for this map-type to
> be useful, it will require a BPF helper function that BPF programs can
> invoke to drain samples from the ringbuffer, and invoke callbacks on those
> samples. This change adds that capability via a new BPF helper function:
>
> bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx,
>                        u64 flags)
>
> BPF programs may invoke this function to run callback_fn() on a series of
> samples in the ringbuffer. callback_fn() has the following signature:
>
> long callback_fn(struct bpf_dynptr *dynptr, void *context);
>
> Samples are provided to the callback in the form of struct bpf_dynptr *'s,
> which the program can read using BPF helper functions for querying
> struct bpf_dynptr's.
>
> In order to support bpf_ringbuf_drain(), a new PTR_TO_DYNPTR register
> type is added to the verifier to reflect a dynptr that was allocated by
> a helper function and passed to a BPF program. Unlike PTR_TO_STACK
> dynptrs which are allocated on the stack by a BPF program, PTR_TO_DYNPTR
> dynptrs need not use reference tracking, as the BPF helper is trusted to
> properly free the dynptr before returning. The verifier currently only
> supports PTR_TO_DYNPTR registers that are also DYNPTR_TYPE_LOCAL.
>
> Note that while the corresponding user-space libbpf logic will be added in
> a subsequent patch, this patch does contain an implementation of the
> .map_poll() callback for BPF_MAP_TYPE_USER_RINGBUF maps. This .map_poll()
> callback guarantees that an epoll-waiting user-space producer will
> receive at least one event notification whenever at least one sample is
> drained in an invocation of bpf_user_ringbuf_drain(), provided that the
> function is not invoked with the BPF_RB_NO_WAKEUP flag.
>
> Sending an event notification for every sample is not an option, as it
> could cause the system to hang due to invoking irq_work_queue() in
> too-frequent succession. So as to try and optimize for the common case,
> however, bpf_user_ringbuf_drain() will also send an event notification
> whenever a sample being drained causes the ringbuffer to no longer be
> full. This heuristic may not help some user-space producers, as a
> producer can publish samples of varying size, and there may not be
> enough space in the ringbuffer after the first sample is drained which
> causes it to no longer be full. In this case, the producer may have to
> wait until bpf_ringbuf_drain() returns to receive an event notification.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  include/linux/bpf.h            |  11 +-
>  include/uapi/linux/bpf.h       |  36 ++++++
>  kernel/bpf/helpers.c           |   2 +
>  kernel/bpf/ringbuf.c           | 210 ++++++++++++++++++++++++++++++++-
>  kernel/bpf/verifier.c          |  72 +++++++++--
>  tools/include/uapi/linux/bpf.h |  36 ++++++
>  6 files changed, 352 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a627a02cf8ab..515d712fd4a5 100644
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
> @@ -1333,6 +1334,11 @@ struct bpf_array {
>  #define BPF_MAP_CAN_READ       BIT(0)
>  #define BPF_MAP_CAN_WRITE      BIT(1)
>
> +/* Maximum number of user-producer ringbuffer samples that can be drained in
> + * a call to bpf_user_ringbuf_drain().
> + */
> +#define BPF_MAX_USER_RINGBUF_SAMPLES BIT(17)

nit: I don't think using BIT() is appropriate here. 128 * 1024 would
be better, IMO. This is not inherently required to be a single bit
constant.

> +
>  static inline u32 bpf_map_flags_to_cap(struct bpf_map *map)
>  {
>         u32 access_flags = map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
> @@ -2411,6 +2417,7 @@ extern const struct bpf_func_proto bpf_loop_proto;
>  extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
>  extern const struct bpf_func_proto bpf_set_retval_proto;
>  extern const struct bpf_func_proto bpf_get_retval_proto;
> +extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>
>  const struct bpf_func_proto *tracing_prog_func_proto(
>    enum bpf_func_id func_id, const struct bpf_prog *prog);
> @@ -2555,7 +2562,7 @@ enum bpf_dynptr_type {
>         BPF_DYNPTR_TYPE_INVALID,
>         /* Points to memory that is local to the bpf program */
>         BPF_DYNPTR_TYPE_LOCAL,
> -       /* Underlying data is a ringbuf record */
> +       /* Underlying data is a kernel-produced ringbuf record */
>         BPF_DYNPTR_TYPE_RINGBUF,
>  };
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3aee7681fa68..25c599d9adf8 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5356,6 +5356,41 @@ union bpf_attr {
>   *     Return
>   *             Current *ktime*.
>   *
> + * long bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx, u64 flags)
> + *     Description
> + *             Drain samples from the specified user ringbuffer, and invoke the
> + *             provided callback for each such sample:
> + *
> + *             long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
> + *
> + *             If **callback_fn** returns 0, the helper will continue to try
> + *             and drain the next sample, up to a maximum of
> + *             BPF_MAX_USER_RINGBUF_SAMPLES samples. If the return value is 1,
> + *             the helper will skip the rest of the samples and return. Other
> + *             return values are not used now, and will be rejected by the
> + *             verifier.
> + *     Return
> + *             The number of drained samples if no error was encountered while
> + *             draining samples. If a user-space producer was epoll-waiting on
> + *             this map, and at least one sample was drained, they will
> + *             receive an event notification notifying them of available space
> + *             in the ringbuffer. If the BPF_RB_NO_WAKEUP flag is passed to
> + *             this function, no wakeup notification will be sent. If there
> + *             are no samples in the ringbuffer, 0 is returned.
> + *
> + *             On failure, the returned value is one of the following:
> + *
> + *             **-EBUSY** if the ringbuffer is contended, and another calling
> + *             context was concurrently draining the ringbuffer.
> + *
> + *             **-EINVAL** if user-space is not properly tracking the
> + *             ringbuffer due to the producer position not being aligned to 8

s/ringbuffer/ring buffer/ everywhere to be more human-readable and
consistent with bpf_ringbuf_xxx() descriptions?

> + *             bytes, a sample not being aligned to 8 bytes, the producer
> + *             position not matching the advertised length of a sample, or the
> + *             sample size being larger than the ringbuffer.
> + *
> + *             **-E2BIG** if user-space has tried to publish a sample that
> + *             cannot fit within a struct bpf_dynptr.


"sample size being larger than the ringbuffer" is documented above for
-EINVAL, so it's ambiguous if it's E2BIG or EINVAL?

>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5567,6 +5602,7 @@ union bpf_attr {
>         FN(tcp_raw_check_syncookie_ipv4),       \
>         FN(tcp_raw_check_syncookie_ipv6),       \
>         FN(ktime_get_tai_ns),           \
> +       FN(user_ringbuf_drain),         \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 3c1b9bbcf971..9141eae0ca67 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1661,6 +1661,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_dynptr_write_proto;
>         case BPF_FUNC_dynptr_data:
>                 return &bpf_dynptr_data_proto;
> +       case BPF_FUNC_user_ringbuf_drain:
> +               return &bpf_user_ringbuf_drain_proto;
>         default:
>                 break;
>         }
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> index 0a8de712ecbe..3818398e57de 100644
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -38,6 +38,22 @@ struct bpf_ringbuf {
>         struct page **pages;
>         int nr_pages;
>         spinlock_t spinlock ____cacheline_aligned_in_smp;
> +       /* For user-space producer ringbuffers, an atomic_t busy bit is used to
> +        * synchronize access to the ringbuffer in the kernel, rather than the
> +        * spinlock that is used for kernel-producer ringbuffers. This is done
> +        * because the ringbuffer must hold a lock across a BPF program's

ditto about ringbuffer -> ring buffer (though here it's probably fine
to just use short ringbuf), Gmail also doesn't like "ringbuffer" ;)

> +        * callback:
> +        *
> +        *    __bpf_user_ringbuf_peek() // lock acquired
> +        * -> program callback_fn()
> +        * -> __bpf_user_ringbuf_sample_release() // lock released
> +        *
> +        * It is unsafe and incorrect to hold an IRQ spinlock across what could
> +        * be a long execution window, so we instead simply disallow concurrent
> +        * access to the ringbuffer by kernel consumers, and return -EBUSY from
> +        * __bpf_user_ringbuf_peek() if the busy bit is held by another task.
> +        */

[...]

> +       if (flags & BPF_RINGBUF_DISCARD_BIT) {
> +               /* If the discard bit is set, the sample should be ignored, and
> +                * we can instead try to read the next one.
> +                *
> +                * Synchronizes with smp_load_acquire() in the user-space
> +                * producer, and smp_load_acquire() in
> +                * __bpf_user_ringbuf_peek() above.
> +                */
> +               smp_store_release(&rb->consumer_pos, cons_pos + total_len);
> +               goto retry;

so given fast enough user-space producer, we can make kernel spend a
lot of time looping and retrying here if we just commit discarded
samples. And we won't be taking into account
BPF_MAX_USER_RINGBUF_SAMPLES for those discards. That seems like a bit
of a hole in the logic... would it be better to return with -EAGAIN
for discard samples and let drain logic skip over them?

> +       }
> +
> +       if (flags & BPF_RINGBUF_BUSY_BIT) {
> +               err = -ENODATA;
> +               goto err_unlock;
> +       }
> +
> +       *sample = (void *)((uintptr_t)rb->data +
> +                          (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
> +       *size = sample_len;
> +       return 0;
> +
> +err_unlock:
> +       atomic_set(&rb->busy, 0);
> +       return err;
> +}
> +
> +static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
> +{
> +       u64 producer_pos, consumer_pos;
> +
> +       /* Synchronizes with smp_store_release() in user-space producer. */
> +       producer_pos = smp_load_acquire(&rb->producer_pos);
> +
> +       /* Using smp_load_acquire() is unnecessary here, as the busy-bit
> +        * prevents another task from writing to consumer_pos after it was read
> +        * by this task with smp_load_acquire() in __bpf_user_ringbuf_peek().
> +        */
> +       consumer_pos = rb->consumer_pos;
> +        /* Synchronizes with smp_load_acquire() in user-space producer. */
> +       smp_store_release(&rb->consumer_pos, consumer_pos + size + BPF_RINGBUF_HDR_SZ);
> +
> +       /* Prevent the clearing of the busy-bit from being reordered before the
> +        * storing of the updated rb->consumer_pos value.
> +        */
> +       smp_mb__before_atomic();
> +       atomic_set(&rb->busy, 0);
> +
> +       if (!(flags & BPF_RB_NO_WAKEUP)) {
> +               /* As a heuristic, if the previously consumed sample caused the
> +                * ringbuffer to no longer be full, send an event notification
> +                * to any user-space producer that is epoll-waiting.
> +                */
> +               if (producer_pos - consumer_pos == ringbuf_total_data_sz(rb))

I'm a bit confused here. This will be true only if user-space producer
filled out entire ringbuf data *exactly* to the last byte with a
single record. Or am I misunderstanding this?

If my understanding is correct, how is this a realistic use case and
how does this heuristic help at all?

> +                       irq_work_queue(&rb->work);
> +
> +       }
> +}
> +
> +BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> +          void *, callback_fn, void *, callback_ctx, u64, flags)
> +{
> +       struct bpf_ringbuf *rb;
> +       long num_samples = 0, ret = 0;
> +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> +       u64 wakeup_flags = BPF_RB_NO_WAKEUP;
> +
> +       if (unlikely(flags & ~wakeup_flags))

hm... so if we specify BPF_RB_FORCE_WAKEUP we'll reject this? Why? Why
not allow both? And why use u64 variable to store BPF_RB_NO_WAKEUP
constant, just use constant right here?

> +               return -EINVAL;
> +
> +       rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
> +       do {
> +               int err;
> +               u32 size;
> +               void *sample;
> +               struct bpf_dynptr_kern dynptr;
> +

[...]

> @@ -7323,22 +7366,35 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>                 }
>                 break;
>         case BPF_FUNC_dynptr_data:
> +               helper_allocated_dynptr = false;
>                 for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
>                         if (arg_type_is_dynptr(fn->arg_type[i])) {
> -                               if (meta.ref_obj_id) {
> -                                       verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
> +                               struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
> +
> +                               if (helper_allocated_dynptr || meta.ref_obj_id) {
> +                                       verbose(env, "verifier internal error: multiple dynptrs not supported\n");
>                                         return -EFAULT;
>                                 }
> -                               /* Find the id of the dynptr we're tracking the reference of */
> -                               meta.ref_obj_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> +
> +                               if (base_type(reg->type) == PTR_TO_DYNPTR)
> +                                       helper_allocated_dynptr = true;
> +                               else
> +                                       /* Find the id of the dynptr we're
> +                                        * tracking the reference of
> +                                        */
> +                                       meta.ref_obj_id = stack_slot_get_id(env, reg);
>                                 break;
>                         }
>                 }
> -               if (i == MAX_BPF_FUNC_REG_ARGS) {
> +               if (!helper_allocated_dynptr && i == MAX_BPF_FUNC_REG_ARGS) {

we still expect to get to break in the loop above, right? so there is
no need to special-case !helper_allocated_dynptr, is there?

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

[...]
