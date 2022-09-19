Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716CF5BD5A1
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 22:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiISUTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiISUTl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 16:19:41 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233163E4;
        Mon, 19 Sep 2022 13:19:39 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id f26so348427qto.11;
        Mon, 19 Sep 2022 13:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=RYQmpquO7RMK+MZnOVOuwlpy3aoPB0vFNtWx1nj6E24=;
        b=itaOkIZLW+qu0nNEtM9Nvsn4lO6A5lhspEUUWGruycCVzk37i9GoXJWoccbHrqtGOK
         gWrQt20iPgv0TBVE1Xt57pwPF7xKMizUPJfKnjsNqnPdAmXkqRBwgnnHg5YgV0IweXgc
         mWTyRZ1s55MNxWCpsxMOsYTtq6bKo6tQsSEQ3b77Kf6Px+3wBPvLLiBHeFMRG1gczwUV
         Adli2iM2CTdJGfhRJb0EZSip1rVs1jSvr/D2Nqz1WDst/LH28oDghhgT7z+UUJxcK1yC
         ZXqcDDCwIIpvA1rsOVPRdttzAns2Se91B77rDUE/b6wXpqo5BM3Ml7v7qZeezqLUl7Ez
         D38A==
X-Gm-Message-State: ACrzQf3PhAPLOVXFkev/siE8rYTp+Mk3dFkV+VTiFFaKEYcrjUq3/I/W
        rE3Y1pwNzZ/p0WmmgryBFys=
X-Google-Smtp-Source: AMsMyM4gm9di/w37ZyuXaOZex+pNJo992f6secR54p4R8NUockBIcsqfMSHpBOlqlw5rbsYpFEYxZg==
X-Received: by 2002:ac8:5b88:0:b0:344:52be:4004 with SMTP id a8-20020ac85b88000000b0034452be4004mr16747093qta.201.1663618778366;
        Mon, 19 Sep 2022 13:19:38 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::148f])
        by smtp.gmail.com with ESMTPSA id f7-20020a05622a104700b0035cc86fd8f0sm8274070qte.49.2022.09.19.13.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 13:19:38 -0700 (PDT)
Date:   Mon, 19 Sep 2022 15:19:36 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        bpf@vger.kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 2/4] bpf: Add bpf_user_ringbuf_drain() helper
Message-ID: <YyjO2LspZ3GDELDw@maniforge.dhcp.thefacebook.com>
References: <20220902234317.2518808-1-void@manifault.com>
 <20220902234317.2518808-3-void@manifault.com>
 <CAEf4BzZgv7W=OBi+PogxrvuM1c8QRoZ8O4s347MfKdm-p=qY0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZgv7W=OBi+PogxrvuM1c8QRoZ8O4s347MfKdm-p=qY0w@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 09, 2022 at 04:42:07PM -0700, Andrii Nakryiko wrote:
> On Fri, Sep 2, 2022 at 4:43 PM David Vernet <void@manifault.com> wrote:
> >
> > In a prior change, we added a new BPF_MAP_TYPE_USER_RINGBUF map type which
> > will allow user-space applications to publish messages to a ring buffer
> > that is consumed by a BPF program in kernel-space. In order for this
> > map-type to be useful, it will require a BPF helper function that BPF
> > programs can invoke to drain samples from the ring buffer, and invoke
> > callbacks on those samples. This change adds that capability via a new BPF
> > helper function:
> >
> > bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx,
> >                        u64 flags)
> >
> > BPF programs may invoke this function to run callback_fn() on a series of
> > samples in the ring buffer. callback_fn() has the following signature:
> >
> > long callback_fn(struct bpf_dynptr *dynptr, void *context);
> >
> > Samples are provided to the callback in the form of struct bpf_dynptr *'s,
> > which the program can read using BPF helper functions for querying
> > struct bpf_dynptr's.
> >
> > In order to support bpf_ringbuf_drain(), a new PTR_TO_DYNPTR register
> > type is added to the verifier to reflect a dynptr that was allocated by
> > a helper function and passed to a BPF program. Unlike PTR_TO_STACK
> > dynptrs which are allocated on the stack by a BPF program, PTR_TO_DYNPTR
> > dynptrs need not use reference tracking, as the BPF helper is trusted to
> > properly free the dynptr before returning. The verifier currently only
> > supports PTR_TO_DYNPTR registers that are also DYNPTR_TYPE_LOCAL.
> >
> > Note that while the corresponding user-space libbpf logic will be added in
> > a subsequent patch, this patch does contain an implementation of the
> > .map_poll() callback for BPF_MAP_TYPE_USER_RINGBUF maps. This .map_poll()
> > callback guarantees that an epoll-waiting user-space producer will
> > receive at least one event notification whenever at least one sample is
> > drained in an invocation of bpf_user_ringbuf_drain(), provided that the
> > function is not invoked with the BPF_RB_NO_WAKEUP flag.
> >
> > Sending an event notification for every sample is not an option, as it
> > could cause the system to hang due to invoking irq_work_queue() in
> > too-frequent succession. So as to try and optimize for the common case,
> > however, bpf_user_ringbuf_drain() will also send an event notification
> > whenever a sample being drained causes the ring buffer to no longer be
> > full. This heuristic may not help some user-space producers, as a
> > producer can publish samples of varying size, and there may not be
> > enough space in the ring buffer after the first sample is drained which
> > causes it to no longer be full. In this case, the producer may have to
> > wait until bpf_ringbuf_drain() returns to receive an event notification.
> 
> most of this paragraph should be removed now?

Sorry, good catch. Will remove in v6.

> I mentioned few things I didn't see last time (or that were added),
> but overall looks good to me.

Hmm, let me know if you remember what this is. After reading through this,
I can't think of anything else that should be added in this commit summary.

[...]

> > +static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
> > +                                     struct poll_table_struct *pts)
> > +{
> > +       struct bpf_ringbuf_map *rb_map;
> > +
> > +       rb_map = container_of(map, struct bpf_ringbuf_map, map);
> > +       poll_wait(filp, &rb_map->rb->waitq, pts);
> > +
> > +       if (ringbuf_avail_data_sz(rb_map->rb) < ringbuf_total_data_sz(rb_map->rb))
> > +               return  EPOLLOUT | EPOLLWRNORM;
> 
> nit: extra space after return

Ack.

[...]

> > +static int __bpf_user_ringbuf_peek(struct bpf_ringbuf *rb, void **sample, u32 *size)
> > +{
> > +       int err, busy = 0;
> > +       u32 hdr_len, sample_len, total_len, flags, *hdr;
> > +       u64 cons_pos, prod_pos;
> > +
> > +       /* If another consumer is already consuming a sample, wait for them to finish. */
> > +       if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
> > +               return -EBUSY;
> > +
> > +       /* Synchronizes with smp_store_release() in user-space producer. */
> > +       prod_pos = smp_load_acquire(&rb->producer_pos);
> > +       if (prod_pos % 8) {
> > +               err = -EINVAL;
> > +               goto err_unlock;
> > +       }
> > +
> > +       /* Synchronizes with smp_store_release() in __bpf_user_ringbuf_sample_release() */
> > +       cons_pos = smp_load_acquire(&rb->consumer_pos);
> > +       if (cons_pos >= prod_pos) {
> > +               err = -ENOSPC;
> 
> funny, this one actually feels like -ENODATA (there is no data to peek
> at, right?). It's different from ENOSPC, as we are not trying to
> enqueue anything. I probably missed it before?

Ah, yeah, that makes sense. I think the value should be ENODATA for a BPF
program trying to read samples when the ring buffer is empty, and ENOSPC
for a user space program trying to post a sample to a ring buffer that
doesn't have enough room. I'll update this to be the case in v6.

[...]

> > +static void __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size, u64 flags)
> > +{
> > +       u64 consumer_pos;
> > +       u32 rounded_size = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> > +
> > +       /* Using smp_load_acquire() is unnecessary here, as the busy-bit
> > +        * prevents another task from writing to consumer_pos after it was read
> > +        * by this task with smp_load_acquire() in __bpf_user_ringbuf_peek().
> > +        */
> > +       consumer_pos = rb->consumer_pos;
> > +        /* Synchronizes with smp_load_acquire() in user-space producer. */
> > +       smp_store_release(&rb->consumer_pos, consumer_pos + rounded_size);
> > +
> > +       /* Prevent the clearing of the busy-bit from being reordered before the
> > +        * storing of the updated rb->consumer_pos value.
> > +        */
> > +       smp_mb__before_atomic();
> > +       atomic_set(&rb->busy, 0);
> > +
> > +       if (flags & BPF_RB_FORCE_WAKEUP)
> > +               irq_work_queue(&rb->work);
> 
> I think this part is new, you decided to define that FORCE_WAKEUP
> sends wakeup after every single consumed sample? I have no strong
> opinion on this, tbh, just wonder if it wasn't enough to do it once
> after drain?

I didn't have a strong reason for doing this other than that I think it
more closely matches the behavior for BPF_MAP_TYPE_RINGBUF (which invokes
irq_work_queue() after every call to bpf_ringbuf_commit() if
BPF_RB_FORCE_WAKEUP is passed). Let's just match that behavior unless we
have a good reason not to? I think that will be more intuitive for users.

> > +}
> > +
> > +BPF_CALL_4(bpf_user_ringbuf_drain, struct bpf_map *, map,
> > +          void *, callback_fn, void *, callback_ctx, u64, flags)
> > +{
> > +       struct bpf_ringbuf *rb;
> > +       long samples, discarded_samples = 0, ret = 0;
> > +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> > +       u64 wakeup_flags = BPF_RB_NO_WAKEUP | BPF_RB_FORCE_WAKEUP;
> > +
> > +       if (unlikely(flags & ~wakeup_flags))
> > +               return -EINVAL;
> > +
> > +       rb = container_of(map, struct bpf_ringbuf_map, map)->rb;
> > +       for (samples = 0; samples < BPF_MAX_USER_RINGBUF_SAMPLES && ret == 0; samples++) {
> > +               int err;
> > +               u32 size;
> > +               void *sample;
> > +               struct bpf_dynptr_kern dynptr;
> > +
> > +               err = __bpf_user_ringbuf_peek(rb, &sample, &size);
> 
> so I also just realized that ringbuf_peek will keep setting/resetting
> busy flag, and in like all the practical case it's a completely
> useless work as we don't intend to have competing consumers, right? So
> maybe move busy bit handling into drain itself and document that peek
> expect busy taken care of?
> 
> This should be noticeable faster when there are multiple records
> consumed in one drain.

Great idea, I'll do this in v6.
