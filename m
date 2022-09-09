Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9355B4320
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 01:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIIXmW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 19:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiIIXmW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 19:42:22 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF89B24A6;
        Fri,  9 Sep 2022 16:42:20 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id go34so7605782ejc.2;
        Fri, 09 Sep 2022 16:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=E0ImdVtQckUlqL5lFPB/n4FHHLzA/xgj5NP2XYhWId8=;
        b=HI/W8IcxizQCePJ8Hqrk8IR7T0NzS+/JGmVroFNOO2Z4WJINTZ+GE6mEUgvekckLUZ
         lhBL++L2dpFxcAAkGNHkHBYy89aVotK40u7GmIqNOJKkyDLz1Xa89qoQhIGH1mPzLWDz
         DXJSZv75KaGYlyFRKTualyTPdx/pQlYUTILUV8d4ji9NJYQCM/i4+Awd09FREFDUY63q
         +CqdHr1KIN9e/30PahwvZboZpxZGz3qRJtG1V5ylJgNsbz8IHgWgVwoUv5D70qjnbQXm
         x5EhzwkyCr9IDloys0+F6a0TdRy1cFuRaW7UaG3xQ/oLAujQRvxJsE9YlFXUC+1kB3+8
         Wvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=E0ImdVtQckUlqL5lFPB/n4FHHLzA/xgj5NP2XYhWId8=;
        b=kmcqGd50zz9VNBJ+uCkMaefdymjfY+JEgLTxEGiQZ9b3y5paecNGozVVKlwWsuYzah
         7rlwjHihIsion6dJ90E/vUrczHmsFaj7htfbGMY1QWl/i9L8/k5PGRd0lBzveopMxVza
         iQmtVCSQ1iQquqsy78e2CE/7qlH3rOqcgg81WDRP075IWMYQ2l6FElfGh9VX1s8gEMap
         wOCFpFsoF74tQykgYd0YoVviOi2m1wkBidRCHI33uyFt0Mg0CsYvTahpH5Gl/kFhdQJk
         Dp1wpf9Q56pv/eXQ+3lVczgWNelANcec8rUyJJ+HRAxz0wYBMllPP+yvb83IoEcWMUGb
         iORg==
X-Gm-Message-State: ACgBeo0MqqO3PHnb9p+5Iw+6lI9LwnS5yMPQdrmPTXF1yVq9zzbCSsV0
        fXsNX/5I4Gca01OJnsDTy0zQKDbTSKJ50cF19Oc=
X-Google-Smtp-Source: AA6agR4pkd3XGvCYx3k6kAPTSsmkIyRgDzAfzEsugHZ6Gprh81B415b5iw/sy2FFv+cjVNjvHXY29ASg+Vl7SWMnqRE=
X-Received: by 2002:a17:907:7e92:b0:741:5f7e:f1ac with SMTP id
 qb18-20020a1709077e9200b007415f7ef1acmr11700769ejc.176.1662766938977; Fri, 09
 Sep 2022 16:42:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220902234317.2518808-1-void@manifault.com> <20220902234317.2518808-3-void@manifault.com>
In-Reply-To: <20220902234317.2518808-3-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 16:42:07 -0700
Message-ID: <CAEf4BzZgv7W=OBi+PogxrvuM1c8QRoZ8O4s347MfKdm-p=qY0w@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] bpf: Add bpf_user_ringbuf_drain() helper
To:     David Vernet <void@manifault.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, bpf@vger.kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
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

On Fri, Sep 2, 2022 at 4:43 PM David Vernet <void@manifault.com> wrote:
>
> In a prior change, we added a new BPF_MAP_TYPE_USER_RINGBUF map type which
> will allow user-space applications to publish messages to a ring buffer
> that is consumed by a BPF program in kernel-space. In order for this
> map-type to be useful, it will require a BPF helper function that BPF
> programs can invoke to drain samples from the ring buffer, and invoke
> callbacks on those samples. This change adds that capability via a new BPF
> helper function:
>
> bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx,
>                        u64 flags)
>
> BPF programs may invoke this function to run callback_fn() on a series of
> samples in the ring buffer. callback_fn() has the following signature:
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
> whenever a sample being drained causes the ring buffer to no longer be
> full. This heuristic may not help some user-space producers, as a
> producer can publish samples of varying size, and there may not be
> enough space in the ring buffer after the first sample is drained which
> causes it to no longer be full. In this case, the producer may have to
> wait until bpf_ringbuf_drain() returns to receive an event notification.

most of this paragraph should be removed now?

I mentioned few things I didn't see last time (or that were added),
but overall looks good to me.

>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  include/linux/bpf.h            |  11 +-
>  include/uapi/linux/bpf.h       |  36 ++++++
>  kernel/bpf/helpers.c           |   2 +
>  kernel/bpf/ringbuf.c           | 199 ++++++++++++++++++++++++++++++++-
>  kernel/bpf/verifier.c          |  61 +++++++++-
>  tools/include/uapi/linux/bpf.h |  36 ++++++
>  6 files changed, 334 insertions(+), 11 deletions(-)
>

[...]

> -static __poll_t ringbuf_map_poll(struct bpf_map *map, struct file *filp,
> -                                struct poll_table_struct *pts)
> +static u32 ringbuf_total_data_sz(const struct bpf_ringbuf *rb)
> +{
> +       return rb->mask + 1;
> +}
> +
> +static __poll_t ringbuf_map_poll_kern(struct bpf_map *map, struct file *filp,
> +                                     struct poll_table_struct *pts)
>  {
>         struct bpf_ringbuf_map *rb_map;
>
> @@ -301,13 +323,26 @@ static __poll_t ringbuf_map_poll(struct bpf_map *map, struct file *filp,
>         return 0;
>  }
>
> +static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
> +                                     struct poll_table_struct *pts)
> +{
> +       struct bpf_ringbuf_map *rb_map;
> +
> +       rb_map = container_of(map, struct bpf_ringbuf_map, map);
> +       poll_wait(filp, &rb_map->rb->waitq, pts);
> +
> +       if (ringbuf_avail_data_sz(rb_map->rb) < ringbuf_total_data_sz(rb_map->rb))
> +               return  EPOLLOUT | EPOLLWRNORM;

nit: extra space after return


> +       return 0;
> +}
> +
>  BTF_ID_LIST_SINGLE(ringbuf_map_btf_ids, struct, bpf_ringbuf_map)
>  const struct bpf_map_ops ringbuf_map_ops = {
>         .map_meta_equal = bpf_map_meta_equal,
>         .map_alloc = ringbuf_map_alloc,
>         .map_free = ringbuf_map_free,
>         .map_mmap = ringbuf_map_mmap_kern,
> -       .map_poll = ringbuf_map_poll,
> +       .map_poll = ringbuf_map_poll_kern,
>         .map_lookup_elem = ringbuf_map_lookup_elem,
>         .map_update_elem = ringbuf_map_update_elem,
>         .map_delete_elem = ringbuf_map_delete_elem,
> @@ -321,6 +356,7 @@ const struct bpf_map_ops user_ringbuf_map_ops = {
>         .map_alloc = ringbuf_map_alloc,
>         .map_free = ringbuf_map_free,
>         .map_mmap = ringbuf_map_mmap_user,
> +       .map_poll = ringbuf_map_poll_user,
>         .map_lookup_elem = ringbuf_map_lookup_elem,
>         .map_update_elem = ringbuf_map_update_elem,
>         .map_delete_elem = ringbuf_map_delete_elem,
> @@ -362,7 +398,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
>                 return NULL;
>
>         len = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> -       if (len > rb->mask + 1)
> +       if (len > ringbuf_total_data_sz(rb))
>                 return NULL;
>
>         cons_pos = smp_load_acquire(&rb->consumer_pos);
> @@ -509,7 +545,7 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, u64, flags)
>         case BPF_RB_AVAIL_DATA:
>                 return ringbuf_avail_data_sz(rb);
>         case BPF_RB_RING_SIZE:
> -               return rb->mask + 1;
> +               return ringbuf_total_data_sz(rb);
>         case BPF_RB_CONS_POS:
>                 return smp_load_acquire(&rb->consumer_pos);
>         case BPF_RB_PROD_POS:
> @@ -603,3 +639,156 @@ const struct bpf_func_proto bpf_ringbuf_discard_dynptr_proto = {
>         .arg1_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_RINGBUF | OBJ_RELEASE,
>         .arg2_type      = ARG_ANYTHING,
>  };
> +
> +static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *size)
> +{
> +       int err, busy = 0;
> +       u32 hdr_len, sample_len, total_len, flags, *hdr;
> +       u64 cons_pos, prod_pos;
> +
> +       /* If another consumer is already consuming a sample, wait for them to finish. */
> +       if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
> +               return -EBUSY;
> +
> +       /* Synchronizes with smp_store_release() in user-space producer. */
> +       prod_pos = smp_load_acquire(&rb->producer_pos);
> +       if (prod_pos % 8) {
> +               err = -EINVAL;
> +               goto err_unlock;
> +       }
> +
> +       /* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
> +       cons_pos = smp_load_acquire(&rb->consumer_pos);
> +       if (cons_pos >= prod_pos) {
> +               err = -ENOSPC;

funny, this one actually feels like -ENODATA (there is no data to peek
at, right?). It's different from ENOSPC, as we are not trying to
enqueue anything. I probably missed it before?

> +               goto err_unlock;
> +       }
> +
> +       hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
> +       /* Synchronizes with smp_store_release() in user-space producer. */
> +       hdr_len = smp_load_acquire(hdr);
> +       flags = hdr_len & (BPF_RINGBUF_BUSY_BIT | BPF_RINGBUF_DISCARD_BIT);
> +       sample_len = hdr_len & ~flags;
> +       total_len = round_up(sample_len + BPF_RINGBUF_HDR_SZ, 8);
> +
> +       /* The sample must fit within the region advertised by the producer position. */
> +       if (total_len > prod_pos - cons_pos) {
> +               err = -EINVAL;
> +               goto err_unlock;
> +       }
> +
> +       /* The sample must fit within the data region of the ring buffer. */
> +       if (total_len > ringbuf_total_data_sz(rb)) {
> +               err = -E2BIG;
> +               goto err_unlock;
> +       }
> +
> +       /* The sample must fit into a struct bpf_dynptr. */
> +       err = bpf_dynptr_check_size(sample_len);
> +       if (err) {
> +               err = -E2BIG;
> +               goto err_unlock;
> +       }
> +
> +       if (flags & BPF_RINGBUF_DISCARD_BIT) {
> +               /* If the discard bit is set, the sample should be skipped.
> +                *
> +                * Update the consumer pos, and return -EAGAIN so the caller
> +                * knows to skip this sample and try to read the next one.
> +                */
> +               smp_store_release(&rb->consumer_pos, cons_pos + total_len);
> +               err = -EAGAIN;
> +               goto err_unlock;
> +       }
> +
> +       if (flags & BPF_RINGBUF_BUSY_BIT) {
> +               err = -ENOSPC;
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
> +       u64 consumer_pos;
> +       u32 rounded_size = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> +
> +       /* Using smp_load_acquire() is unnecessary here, as the busy-bit
> +        * prevents another task from writing to consumer_pos after it was read
> +        * by this task with smp_load_acquire() in __bpf_user_ringbuf_peek().
> +        */
> +       consumer_pos = rb->consumer_pos;
> +        /* Synchronizes with smp_load_acquire() in user-space producer. */
> +       smp_store_release(&rb->consumer_pos, consumer_pos + rounded_size);
> +
> +       /* Prevent the clearing of the busy-bit from being reordered before the
> +        * storing of the updated rb->consumer_pos value.
> +        */
> +       smp_mb__before_atomic();
> +       atomic_set(&rb->busy, 0);
> +
> +       if (flags & BPF_RB_FORCE_WAKEUP)
> +               irq_work_queue(&rb->work);

I think this part is new, you decided to define that FORCE_WAKEUP
sends wakeup after every single consumed sample? I have no strong
opinion on this, tbh, just wonder if it wasn't enough to do it once
after drain?

> +}
> +
> +BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> +          void *, callback_fn, void *, callback_ctx, u64, flags)
> +{
> +       struct bpf_ringbuf *rb;
> +       long samples, discarded_samples = 0, ret = 0;
> +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> +       u64 wakeup_flags = BPF_RB_NO_WAKEUP | BPF_RB_FORCE_WAKEUP;
> +
> +       if (unlikely(flags & ~wakeup_flags))
> +               return -EINVAL;
> +
> +       rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
> +       for (samples = 0; samples < BPF_MAX_USER_RINGBUF_SAMPLES && ret == 0; samples++) {
> +               int err;
> +               u32 size;
> +               void *sample;
> +               struct bpf_dynptr_kern dynptr;
> +
> +               err = __bpf_user_ringbuf_peek(rb, &sample, &size);

so I also just realized that ringbuf_peek will keep setting/resetting
busy flag, and in like all the practical case it's a completely
useless work as we don't intend to have competing consumers, right? So
maybe move busy bit handling into drain itself and document that peek
expect busy taken care of?

This should be noticeable faster when there are multiple records
consumed in one drain.


> +               if (err) {
> +                       if (err == -ENOSPC) {
> +                               break;
> +                       } else if (err == -EAGAIN) {
> +                               discarded_samples++;
> +                               continue;
> +                       } else {
> +                               ret = err;
> +                               goto schedule_work_return;
> +                       }
> +               }
> +

[...]

>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  {
>         struct bpf_verifier_state *state = env->cur_state;
> @@ -7343,12 +7386,18 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
>         case BPF_FUNC_dynptr_data:
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
> +                               if (base_type(reg->type) != PTR_TO_DYNPTR)
> +                                       /* Find the id of the dynptr we're
> +                                        * tracking the reference of
> +                                        */
> +                                       meta.ref_obj_id = stack_slot_get_id(env, reg);
>                                 break;
>                         }
>                 }

Joanne, I'd appreciate it if you could take a look at dynptr bits and
ack if it looks good to you, thanks!

> @@ -7357,6 +7406,10 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
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
