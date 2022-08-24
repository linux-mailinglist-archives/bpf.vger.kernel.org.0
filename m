Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB365A0387
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 23:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbiHXV6s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 17:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbiHXV6q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 17:58:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE6776457;
        Wed, 24 Aug 2022 14:58:44 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so23791084edd.4;
        Wed, 24 Aug 2022 14:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=g2Ey6Q0UqOsLnQOmjv2tGRZLeR87hKYQCnLG8faintQ=;
        b=deMdKeS2iMfX2/ewJNTskKo/vTYbZLffgfxH7kmVLkWZvsIOFrlhHmoruwuwGR7yZp
         P6VwibVdkF50yBRVGj0QKrknjWq1k1JsASd7SPmvvJVHxck5tSWzO0hZZjxQr28g5Dr2
         yTTESG5DwFqjwI0Fv1kNAgvZ4hloz5bJX2NTQAgyKqMbrobUlLr4yo0eHortCNbDtGZB
         cUcqdMXpFOyv0mdegg4LLI5tgbSjxhOW/qGrw5ACiz63xsCw6Yx4jBwN25EvPnNhxo7d
         ycRDiPSv4ZGedjvV+qDtpcyyRcDj4c5rMzP8zeujARAtuRVcCOUG3HLCb44n67MHREaZ
         RxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=g2Ey6Q0UqOsLnQOmjv2tGRZLeR87hKYQCnLG8faintQ=;
        b=K24jQiFSFjeZQANa6m9Iu+NNJUfUmdOcez4gT6vMS1E3SI/iugjgC128diDwo0tq1k
         g9QZ1RvzFFMTheaWTTK2CWQF8u+hrDtJhxkMSaPsD3WnXo5v1US+Sb2/PWXaOnJuOi4Q
         6s3uRITDUJe0SsSqaevMJoB9100rymVZjMtCWcKv6kfJSIhGhua6ExXldNvVr4ffFlnF
         hl+a2UeoJN4mNi+FfrM74bDOD+REbYTcnhDUC/keef3ngctswagkJu9qMvhSAlJ2wacI
         FWvn0AE4UT4utPm2OkHgS1n/upxnQgNa43TqjONZ8JpM4NEgPthwhpB4pEltEXJXNmFk
         lGRQ==
X-Gm-Message-State: ACgBeo1Df5iPO55dcyp/NwedIlfswVqNkS45l9FoiCcQMB/JkX15a6Vu
        Htf/unOWe5KWS3ncE+Dz8pTmwjJN1dVZLCYpBfI=
X-Google-Smtp-Source: AA6agR5X3JEZVxh4hWjYJ1kmS5OICYG3yZflh0TDEPsAO08md9aiklSrJ2KitGHFjmmhyJ+BQMSq9v7SQIQuKQ9PeGk=
X-Received: by 2002:a05:6402:24a4:b0:440:8c0c:8d2b with SMTP id
 q36-20020a05640224a400b004408c0c8d2bmr762970eda.311.1661378323177; Wed, 24
 Aug 2022 14:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220818221212.464487-1-void@manifault.com> <20220818221212.464487-4-void@manifault.com>
In-Reply-To: <20220818221212.464487-4-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Aug 2022 14:58:31 -0700
Message-ID: <CAEf4BzZkzZacR7ziFf2orNk2znNqhJhBTDGhSOtGNvB2z4moJQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] bpf: Add libbpf logic for user-space ring buffer
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 18, 2022 at 3:12 PM David Vernet <void@manifault.com> wrote:
>
> Now that all of the logic is in place in the kernel to support user-space
> produced ringbuffers, we can add the user-space logic to libbpf. This
> patch therefore adds the following public symbols to libbpf:
>
> struct user_ring_buffer *
> user_ring_buffer__new(int map_fd,
>                       const struct user_ring_buffer_opts *opts);
> void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size);
> void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
>                                          __u32 size, int timeout_ms);
> void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample);
> void user_ring_buffer__discard(struct user_ring_buffer *rb,
> void user_ring_buffer__free(struct user_ring_buffer *rb);
>
> A user-space producer must first create a struct user_ring_buffer * object
> with user_ring_buffer__new(), and can then reserve samples in the
> ringbuffer using one of the following two symbols:
>
> void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size);
> void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
>                                          __u32 size, int timeout_ms);
>
> With user_ring_buffer__reserve(), a pointer to an @size region of the
> ringbuffer will be returned if sufficient space is available in the buffer.
> user_ring_buffer__reserve_blocking() provides similar semantics, but will
> block for up to @timeout_ms in epoll_wait if there is insufficient space in
> the buffer. This function has the guarantee from the kernel that it will
> receive at least one event-notification per invocation to
> bpf_ringbuf_drain(), provided that at least one sample is drained, and the
> BPF program did not pass the BPF_RB_NO_WAKEUP flag to bpf_ringbuf_drain().
>
> Once a sample is reserved, it must either be committed to the ringbuffer
> with user_ring_buffer__submit(), or discarded with
> user_ring_buffer__discard().
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  tools/lib/bpf/libbpf.c        |  10 +-
>  tools/lib/bpf/libbpf.h        |  21 +++
>  tools/lib/bpf/libbpf.map      |   6 +
>  tools/lib/bpf/libbpf_probes.c |   1 +
>  tools/lib/bpf/ringbuf.c       | 327 ++++++++++++++++++++++++++++++++++
>  5 files changed, 363 insertions(+), 2 deletions(-)
>

[...]

> +LIBBPF_API struct user_ring_buffer *
> +user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts);
> +LIBBPF_API void *user_ring_buffer__reserve(struct user_ring_buffer *rb,
> +                                          __u32 size);
> +
> +LIBBPF_API void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
> +                                                   __u32 size,
> +                                                   int timeout_ms);
> +LIBBPF_API void user_ring_buffer__submit(struct user_ring_buffer *rb,
> +                                        void *sample);
> +LIBBPF_API void user_ring_buffer__discard(struct user_ring_buffer *rb,
> +                                         void *sample);
> +LIBBPF_API void user_ring_buffer__free(struct user_ring_buffer *rb);
> +

Let's make sure that all the relevant comments and description of
inputs/outputs/errors are documented here. These doccomments go to
https://libbpf.readthedocs.io/en/latest/api.html


also, please make sure that declarations that fit within 100
characters stay on single line, it's much more readable that way

>  /* Perf buffer APIs */
>  struct perf_buffer;
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 2b928dc21af0..40c83563f90a 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -367,4 +367,10 @@ LIBBPF_1.0.0 {

now that 1.0 is released, this will have to go into a new LIBBPF_1.1.0
section (which inherits from LIBBPF_1.0.0)

>                 libbpf_bpf_map_type_str;
>                 libbpf_bpf_prog_type_str;
>                 perf_buffer__buffer;
> +               user_ring_buffer__discard;
> +               user_ring_buffer__free;
> +               user_ring_buffer__new;
> +               user_ring_buffer__reserve;
> +               user_ring_buffer__reserve_blocking;
> +               user_ring_buffer__submit;
>  };

[...]

> +       /* Map read-write the producer page and data pages. We map the data
> +        * region as twice the total size of the ringbuffer to allow the simple
> +        * reading and writing of samples that wrap around the end of the
> +        * buffer.  See the kernel implementation for details.
> +        */
> +       tmp = mmap(NULL, rb->page_size + 2 * info.max_entries,
> +                  PROT_READ | PROT_WRITE, MAP_SHARED, map_fd, rb->page_size);
> +       if (tmp == MAP_FAILED) {
> +               err = -errno;
> +               pr_warn("user ringbuf: failed to mmap data pages for map fd=%d: %d\n",
> +                       map_fd, err);
> +               return libbpf_err(err);
> +       }
> +
> +       rb->producer_pos = tmp;
> +       rb->data = tmp + rb->page_size;
> +
> +       rb_epoll = &rb->event;
> +       rb_epoll->events = EPOLLOUT;
> +       if (epoll_ctl(rb->epoll_fd, EPOLL_CTL_ADD, map_fd, rb_epoll) < 0) {
> +               err = -errno;
> +               pr_warn("user ringbuf: failed to epoll add map fd=%d: %d\n", map_fd, err);
> +               return libbpf_err(err);

this is internal helper function, so there is no need to use
libbpf_err() helpers, just return errors directly. Only user-facing
functions should make sure to set both errno and return error

> +       }
> +
> +       return 0;
> +}
> +
> +struct user_ring_buffer *
> +user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts)
> +{
> +       struct user_ring_buffer *rb;
> +       int err;
> +
> +       if (!OPTS_VALID(opts, ring_buffer_opts))

user_ring_buffer_opts

> +               return errno = EINVAL, NULL;
> +
> +       rb = calloc(1, sizeof(*rb));
> +       if (!rb)
> +               return errno = ENOMEM, NULL;
> +
> +       rb->page_size = getpagesize();
> +
> +       rb->epoll_fd = epoll_create1(EPOLL_CLOEXEC);
> +       if (rb->epoll_fd < 0) {
> +               err = -errno;
> +               pr_warn("user ringbuf: failed to create epoll instance: %d\n", err);
> +               goto err_out;
> +       }
> +
> +       err = user_ringbuf_map(rb, map_fd);
> +       if (err)
> +               goto err_out;
> +
> +       return rb;
> +
> +err_out:
> +       user_ring_buffer__free(rb);
> +       return errno = -err, NULL;
> +}
> +
> +static void user_ringbuf__commit(struct user_ring_buffer *rb, void *sample, bool discard)
> +{
> +       __u32 new_len;
> +       struct ringbuf_hdr *hdr;
> +
> +       /* All samples are aligned to 8 bytes, so the header will only ever
> +        * wrap around the back of the ringbuffer if the sample is at the
> +        * very beginning of the ringbuffer.
> +        */
> +       if (sample == rb->data)
> +               hdr = rb->data + (rb->mask - BPF_RINGBUF_HDR_SZ + 1);
> +       else
> +               hdr = sample - BPF_RINGBUF_HDR_SZ;

let's avoid extra if in a hot path?

hdr = rb->data + (rb->mask + 1 + (sample - rb->data) -
BPF_RINGBUF_HDR_SZ) & rb->mask;

> +
> +       new_len = hdr->len & ~BPF_RINGBUF_BUSY_BIT;
> +       if (discard)
> +               new_len |= BPF_RINGBUF_DISCARD_BIT;
> +
> +       /* Synchronizes with smp_load_acquire() in __bpf_user_ringbuf_peek() in
> +        * the kernel.
> +        */
> +       __atomic_exchange_n(&hdr->len, new_len, __ATOMIC_ACQ_REL);
> +}
> +
> +/* Discard a previously reserved sample into the ring buffer.  It is not
> + * necessary to synchronize amongst multiple producers when invoking this
> + * function.
> + */
> +void user_ring_buffer__discard(struct user_ring_buffer *rb, void *sample)
> +{
> +       user_ringbuf__commit(rb, sample, true);
> +}
> +
> +/* Submit a previously reserved sample into the ring buffer. It is not
> + * necessary to synchronize amongst multiple producers when invoking this
> + * function.
> + */
> +void user_ring_buffer__submit(struct user_ring_buffer *rb, void *sample)
> +{
> +       user_ringbuf__commit(rb, sample, false);
> +}
> +
> +/* Reserve a pointer to a sample in the user ring buffer. This function is
> + * *not* thread safe, and callers must synchronize accessing this function if
> + * there are multiple producers.
> + *
> + * If a size is requested that is larger than the size of the entire
> + * ringbuffer, errno is set to E2BIG and NULL is returned. If the ringbuffer
> + * could accommodate the size, but currently does not have enough space, errno
> + * is set to ENODATA and NULL is returned.

ENOSPC seems more appropriate for such a situation?

> + *
> + * Otherwise, a pointer to the sample is returned. After initializing the
> + * sample, callers must invoke user_ring_buffer__submit() to post the sample to
> + * the kernel. Otherwise, the sample must be freed with
> + * user_ring_buffer__discard().
> + */

usual complaints about "ringbuffer", feels like a typo


> +void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size)
> +{
> +       __u32 avail_size, total_size, max_size;
> +       /* 64-bit to avoid overflow in case of extreme application behavior */
> +       __u64 cons_pos, prod_pos;
> +       struct ringbuf_hdr *hdr;
> +
> +       /* Synchronizes with smp_store_release() in __bpf_user_ringbuf_peek() in
> +        * the kernel.
> +        */
> +       cons_pos = smp_load_acquire(rb->consumer_pos);
> +       /* Synchronizes with smp_store_release() in user_ringbuf__commit() */
> +       prod_pos = smp_load_acquire(rb->producer_pos);
> +
> +       /* Round up size to a multiple of 8. */
> +       size = (size + 7) / 8 * 8;
> +       max_size = rb->mask + 1;
> +       avail_size = max_size - (prod_pos - cons_pos);
> +       total_size = size + BPF_RINGBUF_HDR_SZ;
> +
> +       if (total_size > max_size)
> +               return errno = E2BIG, NULL;
> +
> +       if (avail_size < total_size)
> +               return errno = ENODATA, NULL;
> +
> +       hdr = rb->data + (prod_pos & rb->mask);
> +       hdr->len = size | BPF_RINGBUF_BUSY_BIT;

so I double-checked what kernel ringbuf is doing with size. We still
record exact user-requested size in header, but all the logic knows
that it has to be rounded up to closest 8. I think that's best
behavior because it preserves user-supplied information exactly. So if
I wanted to reserve and communicate 4 byte sample to my producers,
they should see that there are 4 bytes of data available, not 8. So
let's do the same here?

We still should validate that all the positions are multiples of 8, of
course, as you do in this revision.

> +       hdr->pad = 0;
> +
> +       /* Synchronizes with smp_load_acquire() in __bpf_user_ringbuf_peek() in
> +        * the kernel.
> +        */
> +       smp_store_release(rb->producer_pos, prod_pos + total_size);
> +
> +       return (void *)rb->data + ((prod_pos + BPF_RINGBUF_HDR_SZ) & rb->mask);
> +}
> +
> +static int ms_elapsed_timespec(const struct timespec *start, const struct timespec *end)
> +{
> +       int total, ns_per_ms = 1000000, ns_per_s = ns_per_ms * 1000;
> +
> +       if (end->tv_sec > start->tv_sec) {
> +               total = 1000 * (end->tv_sec - start->tv_sec);
> +               total += (end->tv_nsec + (ns_per_s - start->tv_nsec)) / ns_per_ms;
> +       } else {
> +               total = (end->tv_nsec - start->tv_nsec) / ns_per_ms;
> +       }
> +

hm... this seems overengineered, tbh

u64 start_ns = (u64)start->tv_sec * 1000000000 + start->tv_nsec;
u64 end_ns = (u64)end->tv_sec * 1000000000 + start->tv_nsec;

return (end_ns - start_ns) / 1000000;

?

> +       return total;
> +}
> +
> +/* Reserve a record in the ringbuffer, possibly blocking for up to @timeout_ms
> + * until a sample becomes available.  This function is *not* thread safe, and
> + * callers must synchronize accessing this function if there are multiple
> + * producers.
> + *
> + * If @timeout_ms is -1, the function will block indefinitely until a sample
> + * becomes available. Otherwise, @timeout_ms must be non-negative, or errno
> + * will be set to EINVAL, and NULL will be returned. If @timeout_ms is 0,
> + * no blocking will occur and the function will return immediately after
> + * attempting to reserve a sample.
> + *
> + * If @size is larger than the size of the entire ringbuffer, errno is set to
> + * E2BIG and NULL is returned. If the ringbuffer could accommodate @size, but
> + * currently does not have enough space, the caller will block until at most
> + * @timeout_ms has elapsed. If insufficient space is available at that time,
> + * errno will be set to ENODATA, and NULL will be returned.

ENOSPC?

> + *
> + * The kernel guarantees that it will wake up this thread to check if
> + * sufficient space is available in the ringbuffer at least once per invocation
> + * of the bpf_ringbuf_drain() helper function, provided that at least one
> + * sample is consumed, and the BPF program did not invoke the function with
> + * BPF_RB_NO_WAKEUP. A wakeup may occur sooner than that, but the kernel does
> + * not guarantee this.
> + *
> + * When a sample of size @size is found within @timeout_ms, a pointer to the
> + * sample is returned. After initializing the sample, callers must invoke
> + * user_ring_buffer__submit() to post the sample to the ringbuffer. Otherwise,
> + * the sample must be freed with user_ring_buffer__discard().
> + */

so comments like this should go into doccomments for this functions in libbpf.h

> +void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb, __u32 size, int timeout_ms)
> +{
> +       int ms_elapsed = 0, err;
> +       struct timespec start;
> +
> +       if (timeout_ms < 0 && timeout_ms != -1)
> +               return errno = EINVAL, NULL;
> +
> +       if (timeout_ms != -1) {
> +               err = clock_gettime(CLOCK_MONOTONIC, &start);
> +               if (err)
> +                       return NULL;
> +       }
> +
> +       do {
> +               int cnt, ms_remaining = timeout_ms - ms_elapsed;

let's max(0, timeout_ms - ms_elapsed) to avoid negative ms_remaining
in some edge timing cases

> +               void *sample;
> +               struct timespec curr;
> +
> +               sample = user_ring_buffer__reserve(rb, size);
> +               if (sample)
> +                       return sample;
> +               else if (errno != ENODATA)
> +                       return NULL;
> +
> +               /* The kernel guarantees at least one event notification
> +                * delivery whenever at least one sample is drained from the
> +                * ringbuffer in an invocation to bpf_ringbuf_drain(). Other
> +                * additional events may be delivered at any time, but only one
> +                * event is guaranteed per bpf_ringbuf_drain() invocation,
> +                * provided that a sample is drained, and the BPF program did
> +                * not pass BPF_RB_NO_WAKEUP to bpf_ringbuf_drain().
> +                */
> +               cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, ms_remaining);
> +               if (cnt < 0)
> +                       return NULL;
> +
> +               if (timeout_ms == -1)
> +                       continue;
> +
> +               err = clock_gettime(CLOCK_MONOTONIC, &curr);
> +               if (err)
> +                       return NULL;
> +
> +               ms_elapsed = ms_elapsed_timespec(&start, &curr);
> +       } while (ms_elapsed <= timeout_ms);

let's simplify all the time keeping to use nanosecond timestamps and
only convert to ms when calling epoll_wait()? Then you can just have a
tiny helper to convert timespec to nanosecond ts ((u64)ts.tv_sec *
1000000000 + ts.tv_nsec) and compare u64s directly. WDYT?

> +
> +       errno = ENODATA;
> +       return NULL;
> +}
> --
> 2.37.1
>
