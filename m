Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C73F5A655E
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 15:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiH3NqC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 09:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbiH3Nph (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 09:45:37 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA510D4CA;
        Tue, 30 Aug 2022 06:44:02 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id j17so8480023qtp.12;
        Tue, 30 Aug 2022 06:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=fZw8MYgngGPI91Wpn1EF1/MRfZ8I6Hgt/2EFyRqW+Ws=;
        b=KuBz3msuxOniYLoXZ3Xm3WV6KAa1SadfXu2Yik86aMNUJajZMtFtrFuavxf/kzxno6
         FiuRrPsjzGRVg80MIhXILQje0gcAumaAMMFpZcHaUVInuuvZWtBxKimQu5+5cTNp5Qi8
         SM59AYXUxwxs1ohLCHftfE+GUxg0YxH50PlNzQ9ohW5oOlpKMHNakI7B/6huiV89APBg
         zd4v7EE9bUoraO0/BVjUkQCoYqsWFtl9j1RiykqgbGusPFnpSUzQh4wjVSgbS98BJYui
         ZpkS650kMAiMGjeU8fJX4cXrdTVYdVVifJOo2oR22YFiCiUR35yUVoiZCLCtyM7iWJ2S
         rdUg==
X-Gm-Message-State: ACgBeo1IpYGFP6hCR19JYK19SczuC8RwSbNrW+/ZY7u3lAgbHp8F78IG
        P0ISJteE9nc4y0gmZeu8+RrqrZ5LszhdVGM7RoI=
X-Google-Smtp-Source: AA6agR6AGnySxRHdF/fDDphgF6MQJALYPM3TRclgZ2yW3zQCyE7OnSdWPFBp0Q8xRUyGO9tbKFUWFw==
X-Received: by 2002:ac8:57d6:0:b0:344:997f:557 with SMTP id w22-20020ac857d6000000b00344997f0557mr14594304qta.345.1661866959615;
        Tue, 30 Aug 2022 06:42:39 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2341])
        by smtp.gmail.com with ESMTPSA id q21-20020a05620a0d9500b006b555509398sm8160787qkl.136.2022.08.30.06.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 06:42:38 -0700 (PDT)
Date:   Tue, 30 Aug 2022 08:42:36 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, joannelkoong@gmail.com, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] bpf: Add libbpf logic for user-space ring buffer
Message-ID: <Yw4TzMPXL41YuZZ6@maniforge.dhcp.thefacebook.com>
References: <20220818221212.464487-1-void@manifault.com>
 <20220818221212.464487-4-void@manifault.com>
 <CAEf4BzZkzZacR7ziFf2orNk2znNqhJhBTDGhSOtGNvB2z4moJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzZkzZacR7ziFf2orNk2znNqhJhBTDGhSOtGNvB2z4moJQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 02:58:31PM -0700, Andrii Nakryiko wrote:

[...]

> > +LIBBPF_API struct user_ring_buffer *
> > +user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts);
> > +LIBBPF_API void *user_ring_buffer__reserve(struct user_ring_buffer *rb,
> > +                                          __u32 size);
> > +
> > +LIBBPF_API void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
> > +                                                   __u32 size,
> > +                                                   int timeout_ms);
> > +LIBBPF_API void user_ring_buffer__submit(struct user_ring_buffer *rb,
> > +                                        void *sample);
> > +LIBBPF_API void user_ring_buffer__discard(struct user_ring_buffer *rb,
> > +                                         void *sample);
> > +LIBBPF_API void user_ring_buffer__free(struct user_ring_buffer *rb);
> > +
> 
> Let's make sure that all the relevant comments and description of
> inputs/outputs/errors are documented here. These doccomments go to
> https://libbpf.readthedocs.io/en/latest/api.html

No problem, I'll add these to the docs.

> also, please make sure that declarations that fit within 100
> characters stay on single line, it's much more readable that way

My mistake, will fix.

> >  /* Perf buffer APIs */
> >  struct perf_buffer;
> >
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 2b928dc21af0..40c83563f90a 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -367,4 +367,10 @@ LIBBPF_1.0.0 {
> 
> now that 1.0 is released, this will have to go into a new LIBBPF_1.1.0
> section (which inherits from LIBBPF_1.0.0)

Sounds good, I'll do that in v4.

[...]

> > +       /* Map read-write the producer page and data pages. We map the data
> > +        * region as twice the total size of the ringbuffer to allow the simple
> > +        * reading and writing of samples that wrap around the end of the
> > +        * buffer.  See the kernel implementation for details.
> > +        */
> > +       tmp = mmap(NULL, rb->page_size + 2 * info.max_entries,
> > +                  PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, rb->page_size);
> > +       if (tmp == MAP_FAILED) {
> > +               err = -errno;
> > +               pr_warn("user ringbuf: failed to mmap data pages for map fd=%d: %d\n",
> > +                       map_fd, err);
> > +               return libbpf_err(err);
> > +       }
> > +
> > +       rb->producer_pos = tmp;
> > +       rb->data = tmp + rb->page_size;
> > +
> > +       rb_epoll = &rb->event;
> > +       rb_epoll->events = EPOLLOUT;
> > +       if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, rb_epoll) < 0) {
> > +               err = -errno;
> > +               pr_warn("user ringbuf: failed to epoll add map fd=%d: %d\n", map_fd, err);
> > +               return libbpf_err(err);
> 
> this is internal helper function, so there is no need to use
> libbpf_err() helpers, just return errors directly. Only user-facing
> functions should make sure to set both errno and return error

Will fix.

> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +struct user_ring_buffer *
> > +user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts)
> > +{
> > +       struct user_ring_buffer *rb;
> > +       int err;
> > +
> > +       if (!OPTS_VALID(opts, ring_buffer_opts))
> 
> user_ring_buffer_opts

Good catch, will fix.

> > +static void user_ringbuf__commit(struct user_ring_buffer *rb, void *sample, bool discard)
> > +{
> > +       __u32 new_len;
> > +       struct ringbuf_hdr *hdr;
> > +
> > +       /* All samples are aligned to 8 bytes, so the header will only ever
> > +        * wrap around the back of the ringbuffer if the sample is at the
> > +        * very beginning of the ringbuffer.
> > +        */
> > +       if (sample == rb->data)
> > +               hdr = rb->data + (rb->mask - BPF_RINGBUF_HDR_SZ + 1);
> > +       else
> > +               hdr = sample - BPF_RINGBUF_HDR_SZ;
> 
> let's avoid extra if in a hot path?
> 
> hdr = rb->data + (rb->mask + 1 + (sample - rb->data) -
> BPF_RINGBUF_HDR_SZ) & rb->mask;

Nice idea, will do.

> > +
> > +       new_len = hdr->len & ~BPF_RINGBUF_BUSY_BIT;
> > +       if (discard)
> > +               new_len |= BPF_RINGBUF_DISCARD_BIT;
> > +
> > +       /* Synchronizes with smp_load_acquire() in __bpf_user_ringbuf_peek() in
> > +        * the kernel.
> > +        */
> > +       __atomic_exchange_n(&hdr->len, new_len, __ATOMIC_ACQ_REL);
> > +}
> > +
> > +/* Discard a previously reserved sample into the ring buffer.  It is not
> > + * necessary to synchronize amongst multiple producers when invoking this
> > + * function.
> > + */
> > +void user_ring_buffer__discard(struct user_ring_buffer *rb, void *sample)
> > +{
> > +       user_ringbuf__commit(rb, sample, true);
> > +}
> > +
> > +/* Submit a previously reserved sample into the ring buffer. It is not
> > + * necessary to synchronize amongst multiple producers when invoking this
> > + * function.
> > + */
> > +void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample)
> > +{
> > +       user_ringbuf__commit(rb, sample, false);
> > +}
> > +
> > +/* Reserve a pointer to a sample in the user ring buffer. This function is
> > + * *not* thread safe, and callers must synchronize accessing this function if
> > + * there are multiple producers.
> > + *
> > + * If a size is requested that is larger than the size of the entire
> > + * ringbuffer, errno is set to E2BIG and NULL is returned. If the ringbuffer
> > + * could accommodate the size, but currently does not have enough space, errno
> > + * is set to ENODATA and NULL is returned.
> 
> ENOSPC seems more appropriate for such a situation?

For the latter? Hmmm, yeah I suppose I agree, I'll make that adjustment.

> > + *
> > + * Otherwise, a pointer to the sample is returned. After initializing the
> > + * sample, callers must invoke user_ring_buffer__submit() to post the sample to
> > + * the kernel. Otherwise, the sample must be freed with
> > + * user_ring_buffer__discard().
> > + */
> 
> usual complaints about "ringbuffer", feels like a typo

No problem, I'll fix that here and in the rest of the patch-set.

> > +void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
> > +{
> > +       __u32 avail_size, total_size, max_size;
> > +       /* 64-bit to avoid overflow in case of extreme application behavior */
> > +       __u64 cons_pos, prod_pos;
> > +       struct ringbuf_hdr *hdr;
> > +
> > +       /* Synchronizes with smp_store_release() in __bpf_user_ringbuf_peek() in
> > +        * the kernel.
> > +        */
> > +       cons_pos = smp_load_acquire(rb->consumer_pos);
> > +       /* Synchronizes with smp_store_release() in user_ringbuf__commit() */
> > +       prod_pos = smp_load_acquire(rb->producer_pos);
> > +
> > +       /* Round up size to a multiple of 8. */
> > +       size = (size + 7) / 8 * 8;
> > +       max_size = rb->mask + 1;
> > +       avail_size = max_size - (prod_pos - cons_pos);
> > +       total_size = size + BPF_RINGBUF_HDR_SZ;
> > +
> > +       if (total_size > max_size)
> > +               return errno = E2BIG, NULL;
> > +
> > +       if (avail_size < total_size)
> > +               return errno = ENODATA, NULL;
> > +
> > +       hdr = rb->data + (prod_pos & rb->mask);
> > +       hdr->len = size | BPF_RINGBUF_BUSY_BIT;
> 
> so I double-checked what kernel ringbuf is doing with size. We still
> record exact user-requested size in header, but all the logic knows
> that it has to be rounded up to closest 8. I think that's best
> behavior because it preserves user-supplied information exactly. So if
> I wanted to reserve and communicate 4 byte sample to my producers,
> they should see that there are 4 bytes of data available, not 8. So
> let's do the same here?

No problem, I'll do this in v4.

> We still should validate that all the positions are multiples of 8, of
> course, as you do in this revision.

Ack.

> > +       hdr->pad = 0;
> > +
> > +       /* Synchronizes with smp_load_acquire() in __bpf_user_ringbuf_peek() in
> > +        * the kernel.
> > +        */
> > +       smp_store_release(rb->producer_pos, prod_pos + total_size);
> > +
> > +       return (void *)rb->data + ((prod_pos + BPF_RINGBUF_HDR_SZ) & rb->mask);
> > +}
> > +
> > +static int ms_elapsed_timespec(const struct timespec *start, const struct timespec *end)
> > +{
> > +       int total, ns_per_ms = 1000000, ns_per_s = ns_per_ms * 1000;
> > +
> > +       if (end->tv_sec > start->tv_sec) {
> > +               total = 1000 * (end->tv_sec - start->tv_sec);
> > +               total += (end->tv_nsec + (ns_per_s - start->tv_nsec)) / ns_per_ms;
> > +       } else {
> > +               total = (end->tv_nsec - start->tv_nsec) / ns_per_ms;
> > +       }
> > +
> 
> hm... this seems overengineered, tbh
> 
> u64 start_ns = (u64)start->tv_sec * 1000000000 + start->tv_nsec;
> u64 end_ns = (u64)end->tv_sec * 1000000000 + start->tv_nsec;
> 
> return (end_ns - start_ns) / 1000000;
> 
> ?

Yeah, this is much simpler. Thanks for the suggestion.

> > +       return total;
> > +}
> > +
> > +/* Reserve a record in the ringbuffer, possibly blocking for up to @timeout_ms
> > + * until a sample becomes available.  This function is *not* thread safe, and
> > + * callers must synchronize accessing this function if there are multiple
> > + * producers.
> > + *
> > + * If @timeout_ms is -1, the function will block indefinitely until a sample
> > + * becomes available. Otherwise, @timeout_ms must be non-negative, or errno
> > + * will be set to EINVAL, and NULL will be returned. If @timeout_ms is 0,
> > + * no blocking will occur and the function will return immediately after
> > + * attempting to reserve a sample.
> > + *
> > + * If @size is larger than the size of the entire ringbuffer, errno is set to
> > + * E2BIG and NULL is returned. If the ringbuffer could accommodate @size, but
> > + * currently does not have enough space, the caller will block until at most
> > + * @timeout_ms has elapsed. If insufficient space is available at that time,
> > + * errno will be set to ENODATA, and NULL will be returned.
> 
> ENOSPC?

Ack.

> > + *
> > + * The kernel guarantees that it will wake up this thread to check if
> > + * sufficient space is available in the ringbuffer at least once per invocation
> > + * of the bpf_ringbuf_drain() helper function, provided that at least one
> > + * sample is consumed, and the BPF program did not invoke the function with
> > + * BPF_RB_NO_WAKEUP. A wakeup may occur sooner than that, but the kernel does
> > + * not guarantee this.
> > + *
> > + * When a sample of size @size is found within @timeout_ms, a pointer to the
> > + * sample is returned. After initializing the sample, callers must invoke
> > + * user_ring_buffer__submit() to post the sample to the ringbuffer. Otherwise,
> > + * the sample must be freed with user_ring_buffer__discard().
> > + */
> 
> so comments like this should go into doccomments for this functions in libbpf.h

Ack.

> > +void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb, __u32 size, int timeout_ms)
> > +{
> > +       int ms_elapsed = 0, err;
> > +       struct timespec start;
> > +
> > +       if (timeout_ms < 0 && timeout_ms != -1)
> > +               return errno = EINVAL, NULL;
> > +
> > +       if (timeout_ms != -1) {
> > +               err = clock_gettime(CLOCK_MONOTONIC, &start);
> > +               if (err)
> > +                       return NULL;
> > +       }
> > +
> > +       do {
> > +               int cnt, ms_remaining = timeout_ms - ms_elapsed;
> 
> let's max(0, timeout_ms - ms_elapsed) to avoid negative ms_remaining
> in some edge timing cases

We actually want to have a negative ms_remaining if timeout_ms is -1. -1
in epoll_wait() specifies an infinite timeout. If we were to round up to
0, it wouldn't block at all.

> > +               void *sample;
> > +               struct timespec curr;
> > +
> > +               sample = user_ring_buffer__reserve(rb, size);
> > +               if (sample)
> > +                       return sample;
> > +               else if (errno != ENODATA)
> > +                       return NULL;
> > +
> > +               /* The kernel guarantees at least one event notification
> > +                * delivery whenever at least one sample is drained from the
> > +                * ringbuffer in an invocation to bpf_ringbuf_drain(). Other
> > +                * additional events may be delivered at any time, but only one
> > +                * event is guaranteed per bpf_ringbuf_drain() invocation,
> > +                * provided that a sample is drained, and the BPF program did
> > +                * not pass BPF_RB_NO_WAKEUP to bpf_ringbuf_drain().
> > +                */
> > +               cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, ms_remaining);
> > +               if (cnt < 0)
> > +                       return NULL;
> > +
> > +               if (timeout_ms == -1)
> > +                       continue;
> > +
> > +               err = clock_gettime(CLOCK_MONOTONIC, &curr);
> > +               if (err)
> > +                       return NULL;
> > +
> > +               ms_elapsed = ms_elapsed_timespec(&start, &curr);
> > +       } while (ms_elapsed <= timeout_ms);
> 
> let's simplify all the time keeping to use nanosecond timestamps and
> only convert to ms when calling epoll_wait()? Then you can just have a
> tiny helper to convert timespec to nanosecond ts ((u64)ts.tv_sec *
> 1000000000 + ts.tv_nsec) and compare u64s directly. WDYT?

Sounds like an improvement to me!

Thanks,
David
