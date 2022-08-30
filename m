Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA95A64B7
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 15:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiH3N3B (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 09:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiH3N2y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 09:28:54 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31E1A2201;
        Tue, 30 Aug 2022 06:28:47 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id x14so4199714qvr.6;
        Tue, 30 Aug 2022 06:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=rlhnTUZroyrKEbb5jORdpvQwWCl1LEqeqXENwrsYij4=;
        b=RZ4TEe6CJT6k6bwGUTOIxxaNeM6MhdXE7K/klqTuC9eCAISOgt103qjNcFE9ldE5kf
         2LRRfg0uTCkHDNuLdzgCKh2XZvWLLVld5N3CMfCmPG/WlCmBLmJLP27qnAvoRBvyYPz7
         1WwmsNiYsc5u7SOerx5uc/6BNuG927bRAjGBflIxiqFWap+z0Wu7ZFQcvuvQHtzcyw/8
         QWeP8EsHxfyxSWfgYeAUqCoAR5AJokyvacilLVn/sAWvViFQjaJP1y9y7gDFUE+eP/xz
         4yQl9lS+se4RPNcH1CB2SOnFQj/42t2HiibWN/pk8bdoSkAK9a4UgnNTZ/cSIQg/66K0
         NJjw==
X-Gm-Message-State: ACgBeo3wCdG+FbbhcOyfMpooEeWwiwt3sTdX+JYt4UyTZzgTuEARbtdz
        d/BXefjBDPItM6OuCPp4UHE=
X-Google-Smtp-Source: AA6agR5xOt5NP2wxNivfU83MkUVVO9IzywVivUjZzh2DffSzrqO+x4rYYWwO68xJxNMFr3oAfupKbA==
X-Received: by 2002:ad4:5742:0:b0:496:b99d:ed6e with SMTP id q2-20020ad45742000000b00496b99ded6emr15014851qvx.56.1661866126086;
        Tue, 30 Aug 2022 06:28:46 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2341])
        by smtp.gmail.com with ESMTPSA id ey26-20020a05622a4c1a00b00344883d3ef8sm6702336qtb.84.2022.08.30.06.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:28:45 -0700 (PDT)
Date:   Tue, 30 Aug 2022 08:28:47 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, joannelkoong@gmail.com, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] bpf: Add bpf_user_ringbuf_drain() helper
Message-ID: <Yw4QjyD9tEB2xNK6@maniforge.dhcp.thefacebook.com>
References: <20220818221212.464487-1-void@manifault.com>
 <20220818221212.464487-3-void@manifault.com>
 <CAEf4BzY6oaCpHmh7x92mhqAVdPNDUe6GLndXHbqHx4i9QzjOsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzY6oaCpHmh7x92mhqAVdPNDUe6GLndXHbqHx4i9QzjOsw@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 02:22:44PM -0700, Andrii Nakryiko wrote:
> > +/* Maximum number of user-producer ringbuffer samples that can be drained in
> > + * a call to bpf_user_ringbuf_drain().
> > + */
> > +#define BPF_MAX_USER_RINGBUF_SAMPLES BIT(17)
> 
> nit: I don't think using BIT() is appropriate here. 128 * 1024 would
> be better, IMO. This is not inherently required to be a single bit
> constant.

No problem, updated.

> > +
> >  static inline u32 bpf_map_flags_to_cap(struct bpf_map *map)
> >  {
> >         u32 access_flags = map->map_flags & (BPF_F_RDONLY_PROG | BPF_F_WRONLY_PROG);
> > @@ -2411,6 +2417,7 @@ extern const struct bpf_func_proto bpf_loop_proto;
> >  extern const struct bpf_func_proto bpf_copy_from_user_task_proto;
> >  extern const struct bpf_func_proto bpf_set_retval_proto;
> >  extern const struct bpf_func_proto bpf_get_retval_proto;
> > +extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
> >
> >  const struct bpf_func_proto *tracing_prog_func_proto(
> >    enum bpf_func_id func_id, const struct bpf_prog *prog);
> > @@ -2555,7 +2562,7 @@ enum bpf_dynptr_type {
> >         BPF_DYNPTR_TYPE_INVALID,
> >         /* Points to memory that is local to the bpf program */
> >         BPF_DYNPTR_TYPE_LOCAL,
> > -       /* Underlying data is a ringbuf record */
> > +       /* Underlying data is a kernel-produced ringbuf record */
> >         BPF_DYNPTR_TYPE_RINGBUF,
> >  };
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 3aee7681fa68..25c599d9adf8 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5356,6 +5356,41 @@ union bpf_attr {
> >   *     Return
> >   *             Current *ktime*.
> >   *
> > + * long bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx, u64 flags)
> > + *     Description
> > + *             Drain samples from the specified user ringbuffer, and invoke the
> > + *             provided callback for each such sample:
> > + *
> > + *             long (\*callback_fn)(struct bpf_dynptr \*dynptr, void \*ctx);
> > + *
> > + *             If **callback_fn** returns 0, the helper will continue to try
> > + *             and drain the next sample, up to a maximum of
> > + *             BPF_MAX_USER_RINGBUF_SAMPLES samples. If the return value is 1,
> > + *             the helper will skip the rest of the samples and return. Other
> > + *             return values are not used now, and will be rejected by the
> > + *             verifier.
> > + *     Return
> > + *             The number of drained samples if no error was encountered while
> > + *             draining samples. If a user-space producer was epoll-waiting on
> > + *             this map, and at least one sample was drained, they will
> > + *             receive an event notification notifying them of available space
> > + *             in the ringbuffer. If the BPF_RB_NO_WAKEUP flag is passed to
> > + *             this function, no wakeup notification will be sent. If there
> > + *             are no samples in the ringbuffer, 0 is returned.
> > + *
> > + *             On failure, the returned value is one of the following:
> > + *
> > + *             **-EBUSY** if the ringbuffer is contended, and another calling
> > + *             context was concurrently draining the ringbuffer.
> > + *
> > + *             **-EINVAL** if user-space is not properly tracking the
> > + *             ringbuffer due to the producer position not being aligned to 8
> 
> s/ringbuffer/ring buffer/ everywhere to be more human-readable and
> consistent with bpf_ringbuf_xxx() descriptions?

Done.

> > + *             bytes, a sample not being aligned to 8 bytes, the producer
> > + *             position not matching the advertised length of a sample, or the
> > + *             sample size being larger than the ringbuffer.
> > + *
> > + *             **-E2BIG** if user-space has tried to publish a sample that
> > + *             cannot fit within a struct bpf_dynptr.
> 
> "sample size being larger than the ringbuffer" is documented above for
> -EINVAL, so it's ambiguous if it's E2BIG or EINVAL?

Good point. I'll return -E2BIG for both cases.

> >   */
> >  #define __BPF_FUNC_MAPPER(FN)          \
> >         FN(unspec),                     \
> > @@ -5567,6 +5602,7 @@ union bpf_attr {
> >         FN(tcp_raw_check_syncookie_ipv4),       \
> >         FN(tcp_raw_check_syncookie_ipv6),       \
> >         FN(ktime_get_tai_ns),           \
> > +       FN(user_ringbuf_drain),         \
> >         /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 3c1b9bbcf971..9141eae0ca67 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1661,6 +1661,8 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >                 return &bpf_dynptr_write_proto;
> >         case BPF_FUNC_dynptr_data:
> >                 return &bpf_dynptr_data_proto;
> > +       case BPF_FUNC_user_ringbuf_drain:
> > +               return &bpf_user_ringbuf_drain_proto;
> >         default:
> >                 break;
> >         }
> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index 0a8de712ecbe..3818398e57de 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> > @@ -38,6 +38,22 @@ struct bpf_ringbuf {
> >         struct page **pages;
> >         int nr_pages;
> >         spinlock_t spinlock ____cacheline_aligned_in_smp;
> > +       /* For user-space producer ringbuffers, an atomic_t busy bit is used to
> > +        * synchronize access to the ringbuffer in the kernel, rather than the
> > +        * spinlock that is used for kernel-producer ringbuffers. This is done
> > +        * because the ringbuffer must hold a lock across a BPF program's
> 
> ditto about ringbuffer -> ring buffer (though here it's probably fine
> to just use short ringbuf), Gmail also doesn't like "ringbuffer" ;)

I won't pretend to be better at spelling than an AI ;-). Updated to
ring buffer here and in the rest of the file.

> > +        * callback:
> > +        *
> > +        *    __bpf_user_ringbuf_peek() // lock acquired
> > +        * -> program callback_fn()
> > +        * -> __bpf_user_ringbuf_sample_release() // lock released
> > +        *
> > +        * It is unsafe and incorrect to hold an IRQ spinlock across what could
> > +        * be a long execution window, so we instead simply disallow concurrent
> > +        * access to the ringbuffer by kernel consumers, and return -EBUSY from
> > +        * __bpf_user_ringbuf_peek() if the busy bit is held by another task.
> > +        */
> 
> [...]
> 
> > +       if (flags & BPF_RINGBUF_DISCARD_BIT) {
> > +               /* If the discard bit is set, the sample should be ignored, and
> > +                * we can instead try to read the next one.
> > +                *
> > +                * Synchronizes with smp_load_acquire() in the user-space
> > +                * producer, and smp_load_acquire() in
> > +                * __bpf_user_ringbuf_peek() above.
> > +                */
> > +               smp_store_release(&rb->consumer_pos, cons_pos + total_len);
> > +               goto retry;
> 
> so given fast enough user-space producer, we can make kernel spend a
> lot of time looping and retrying here if we just commit discarded
> samples. And we won't be taking into account
> BPF_MAX_USER_RINGBUF_SAMPLES for those discards. That seems like a bit
> of a hole in the logic... would it be better to return with -EAGAIN
> for discard samples and let drain logic skip over them?

I like that idea. I originally had us loop over
BPF_MAX_USER_RINGBUF_SAMPLES times, but then decided to change it to this
as it seemed like a simpler and sufficient solution. In hindsight I agree
that it's incorrect to potentially allow user-space cause the kernel to
busy loop like this. I'll update this to return -EAGAIN and let the drain
logic deal with it.

> > +       }
> > +
> > +       if (flags & BPF_RINGBUF_BUSY_BIT) {
> > +               err = -ENODATA;
> > +               goto err_unlock;
> > +       }
> > +
> > +       *sample = (void *)((uintptr_t)rb->data +
> > +                          (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
> > +       *size = sample_len;
> > +       return 0;
> > +
> > +err_unlock:
> > +       atomic_set(&rb->busy, 0);
> > +       return err;
> > +}
> > +
> > +static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
> > +{
> > +       u64 producer_pos, consumer_pos;
> > +
> > +       /* Synchronizes with smp_store_release() in user-space producer. */
> > +       producer_pos = smp_load_acquire(&rb->producer_pos);
> > +
> > +       /* Using smp_load_acquire() is unnecessary here, as the busy-bit
> > +        * prevents another task from writing to consumer_pos after it was read
> > +        * by this task with smp_load_acquire() in __bpf_user_ringbuf_peek().
> > +        */
> > +       consumer_pos = rb->consumer_pos;
> > +        /* Synchronizes with smp_load_acquire() in user-space producer. */
> > +       smp_store_release(&rb->consumer_pos, consumer_pos + size + BPF_RINGBUF_HDR_SZ);
> > +
> > +       /* Prevent the clearing of the busy-bit from being reordered before the
> > +        * storing of the updated rb->consumer_pos value.
> > +        */
> > +       smp_mb__before_atomic();
> > +       atomic_set(&rb->busy, 0);
> > +
> > +       if (!(flags & BPF_RB_NO_WAKEUP)) {
> > +               /* As a heuristic, if the previously consumed sample caused the
> > +                * ringbuffer to no longer be full, send an event notification
> > +                * to any user-space producer that is epoll-waiting.
> > +                */
> > +               if (producer_pos - consumer_pos == ringbuf_total_data_sz(rb))
> 
> I'm a bit confused here. This will be true only if user-space producer
> filled out entire ringbuf data *exactly* to the last byte with a
> single record. Or am I misunderstanding this?

I think you're misunderstanding. This will indeed only be true if the ring
buffer was full (to the last byte as you said) before the last sample was
consumed, but it doesn't have to have been filled with a single record.
We're just checking that producer_pos - consumer_pos is the total size of
the ring buffer, but there can be many samples between consumer_pos and
producer_pos for that to be the case.

> If my understanding is correct, how is this a realistic use case and
> how does this heuristic help at all?

Though I think you may have misunderstood the heuristic, some more
explanation is probably warranted nonetheless. This heuristic being useful
relies on two assumptions:

1. It will be common for user-space to publish statically sized samples.

I think this one is pretty unambiguously true, especially considering that
BPF_MAP_TYPE_RINGBUF was put to great use with statically sized samples for
quite some time. I'm open to hearing why that might not be the case.

2. The size of the ring buffer is a multiple of the size of a sample.

This one I think is a bit less clear. Users can always size the ring buffer
to make sure this will be the case, but whether or not that will be
commonly done is another story.

I'm fine with removing this heuristic for now if it's unclear that it's
serving a common use-case. We can always add it back in later if we want
to.

> > +                       irq_work_queue(&rb->work);
> > +
> > +       }
> > +}
> > +
> > +BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> > +          void *, callback_fn, void *, callback_ctx, u64, flags)
> > +{
> > +       struct bpf_ringbuf *rb;
> > +       long num_samples = 0, ret = 0;
> > +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> > +       u64 wakeup_flags = BPF_RB_NO_WAKEUP;
> > +
> > +       if (unlikely(flags & ~wakeup_flags))
> 
> hm... so if we specify BPF_RB_FORCE_WAKEUP we'll reject this? Why? Why
> not allow both? And why use u64 variable to store BPF_RB_NO_WAKEUP
> constant, just use constant right here?

I thought it was prudent to reject it because I observed the kernel hang if
we scheduled too much work in irq_work_queue() while draining samples. I'm
now unable to repro this even after aggressively writing samples and
scheduling work with irq_work_queue(), so let me remove this restriction.
I'm not sure what's changed, but I was able to reproduce this 100% of the
time before, and now not at all. Perhaps there was some other issue in the
kernel that's since been fixed.

> > +               return -EINVAL;
> > +
> > +       rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
> > +       do {
> > +               int err;
> > +               u32 size;
> > +               void *sample;
> > +               struct bpf_dynptr_kern dynptr;
> > +
> 
> [...]
> 
> > @@ -7323,22 +7366,35 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >                 }
> >                 break;
> >         case BPF_FUNC_dynptr_data:
> > +               helper_allocated_dynptr = false;
> >                 for (i = 0; i < MAX_BPF_FUNC_REG_ARGS; i++) {
> >                         if (arg_type_is_dynptr(fn->arg_type[i])) {
> > -                               if (meta.ref_obj_id) {
> > -                                       verbose(env, "verifier internal error: meta.ref_obj_id already set\n");
> > +                               struct bpf_reg_state *reg = &regs[BPF_REG_1 + i];
> > +
> > +                               if (helper_allocated_dynptr || meta.ref_obj_id) {
> > +                                       verbose(env, "verifier internal error: multiple dynptrs not supported\n");
> >                                         return -EFAULT;
> >                                 }
> > -                               /* Find the id of the dynptr we're tracking the reference of */
> > -                               meta.ref_obj_id = stack_slot_get_id(env, &regs[BPF_REG_1 + i]);
> > +
> > +                               if (base_type(reg->type) == PTR_TO_DYNPTR)
> > +                                       helper_allocated_dynptr = true;
> > +                               else
> > +                                       /* Find the id of the dynptr we're
> > +                                        * tracking the reference of
> > +                                        */
> > +                                       meta.ref_obj_id = stack_slot_get_id(env, reg);
> >                                 break;
> >                         }
> >                 }
> > -               if (i == MAX_BPF_FUNC_REG_ARGS) {
> > +               if (!helper_allocated_dynptr && i == MAX_BPF_FUNC_REG_ARGS) {
> 
> we still expect to get to break in the loop above, right? so there is
> no need to special-case !helper_allocated_dynptr, is there?

Yes, sorry about that silly mistake, not sure what I was thinking. I'll fix
this in V4.

> >                         verbose(env, "verifier internal error: no dynptr in bpf_dynptr_data()\n");
> >                         return -EFAULT;
> >                 }
> >                 break;
> > +       case BPF_FUNC_user_ringbuf_drain:
> > +               err = __check_func_call(env, insn, insn_idx_p, meta.subprogno,
> > +                                       set_user_ringbuf_callback_state);
> > +               break;
> >         }
> >
> >         if (err)
> 
> [...]

Thanks,
David
