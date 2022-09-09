Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5976B5B4341
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 01:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIIX7o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 19:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiIIX7n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 19:59:43 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB50A1FCFE;
        Fri,  9 Sep 2022 16:59:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 29so4802584edv.2;
        Fri, 09 Sep 2022 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2h7TX7zyfz+iELGyhhuBxOikoKGROoe5cQomBui1i50=;
        b=FjmqSajXZNYr9/HujCEuoxlgmpqiFGONes9RoHPd+5SFHNkoJ2AVBH6s9WHPROHdof
         Z3Hh06fs+bBvZPtrzfbPy+nceTJwK06Ctdk+QZ4yJZcBY/MUpenEDf2QMwpyRT9z8ZlK
         jX0dRw4/6UJMdCRSyT5wIkj+vmQgGEZh4qrUOjiIYm7OgrdU4ovgcY2idkorDDXa4gb5
         QI95cLtOixqYUu5YTMloAZM1dCyANZqBm5mW4gkjjtAYWi7gDAz7UgCxKrGpAM2izMGj
         /XceM6P/l/mNTbMHgCHR2BjR0vqw763oSVbd/xN9PYqyVEosCiYpbfOloI5UD+c3KMqj
         RV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2h7TX7zyfz+iELGyhhuBxOikoKGROoe5cQomBui1i50=;
        b=qvTVi81PyCLpDBNA3RQgMrDy6ObblQhY37PI+jat3krsiI+YT7uf989jadFmgs0wIC
         9qGVl4Z7AvRaA9aVvTDEoDMx8hVxnJw/nHpJ/vikg3o5dzFwUFQK5Udg7BF5lLUss+R4
         Z1jVGGvXZlWP6KMfyxufPloSInLj6ooC793BmN4Q41G5Tc99/UdZ2BeAzNtB6alokJzx
         s7P7II8Ouijgu6SeLJO7pVBHJXskHZ4CDYMURRTw0dm51yKfyIOPzZjCvEWFOvXWvX2a
         GiVv8MmoeGSTgjj8rVJixC1xz//VBaHgq/t++DWJz8BKtXT4iXJoj1xKLkU14u4wsPQt
         MeFQ==
X-Gm-Message-State: ACgBeo2wVrITZT5JeiV+UJ2Y39yeZVjn8IkMAHFiWECfypqLyRdannV5
        JZRjLZBE7rbnWqIeL2yZsuYEhCkIY0SgX8uk/k0=
X-Google-Smtp-Source: AA6agR7BDwB31uM5K6c2JNxClo8g+L1F3YP60QKU43fgMgu+X/yEMEz/lUeupPVx12cyV0U0ST+k86RFaQNjlz8/+tE=
X-Received: by 2002:a05:6402:1712:b0:44d:db03:46f2 with SMTP id
 y18-20020a056402171200b0044ddb0346f2mr13781979edu.260.1662767978547; Fri, 09
 Sep 2022 16:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220902234317.2518808-1-void@manifault.com> <20220902234317.2518808-4-void@manifault.com>
In-Reply-To: <20220902234317.2518808-4-void@manifault.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 16:59:27 -0700
Message-ID: <CAEf4Bzbz_7eVSOY0iGp0YkADx80TgZw8cV6NvSm6V1EF=xKo4A@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] bpf: Add libbpf logic for user-space ring buffer
To:     David Vernet <void@manifault.com>
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
> Now that all of the logic is in place in the kernel to support user-space
> produced ring buffers, we can add the user-space logic to libbpf. This
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
> ring buffer using one of the following two symbols:
>
> void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size);
> void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
>                                          __u32 size, int timeout_ms);
>
> With user_ring_buffer__reserve(), a pointer to a 'size' region of the ring
> buffer will be returned if sufficient space is available in the buffer.
> user_ring_buffer__reserve_blocking() provides similar semantics, but will
> block for up to 'timeout_ms' in epoll_wait if there is insufficient space
> in the buffer. This function has the guarantee from the kernel that it will
> receive at least one event-notification per invocation to
> bpf_ringbuf_drain(), provided that at least one sample is drained, and the
> BPF program did not pass the BPF_RB_NO_WAKEUP flag to bpf_ringbuf_drain().
>
> Once a sample is reserved, it must either be committed to the ring buffer
> with user_ring_buffer__submit(), or discarded with
> user_ring_buffer__discard().
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---
>  tools/lib/bpf/libbpf.c         |  10 +-
>  tools/lib/bpf/libbpf.h         | 105 +++++++++++++
>  tools/lib/bpf/libbpf.map       |  10 ++
>  tools/lib/bpf/libbpf_probes.c  |   1 +
>  tools/lib/bpf/libbpf_version.h |   2 +-
>  tools/lib/bpf/ringbuf.c        | 270 +++++++++++++++++++++++++++++++++
>  6 files changed, 395 insertions(+), 3 deletions(-)
>

Thanks for adding nice doc comments! See below for few minor nits, but
ns_elapsed issue I think is pretty bad and should be fixed.

> @@ -1011,6 +1011,7 @@ LIBBPF_API int bpf_tc_query(const struct bpf_tc_hook *hook,
>
>  /* Ring buffer APIs */
>  struct ring_buffer;
> +struct user_ring_buffer;
>
>  typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
>
> @@ -1030,6 +1031,110 @@ LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
>  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
>  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
>
> +struct user_ring_buffer_opts {
> +       size_t sz; /* size of this struct, for forward/backward compatibility */
> +};
> +
> +#define user_ring_buffer_opts__last_field sz
> +
> +/* @brief **user_ring_buffer__new()** creates a new instance of a user ring
> + * buffer.
> + *
> + * @param map_fd A file descriptor to a BPF_MAP_TYPE_RINGBUF map.

typo: USER_RINGBUF

> + * @param opts Options for how the ring buffer should be created.
> + * @return A user ring buffer on success; NULL and errno being set on a
> + * failure.
> + */
> +LIBBPF_API struct user_ring_buffer *
> +user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts);
> +
> +/* @brief **user_ring_buffer__reserve()** reserves a pointer to a sample in the
> + * user ring buffer.
> + * @param rb A pointer to a user ring buffer.
> + * @param size The size of the sample, in bytes.
> + * @return A pointer to a reserved region of the user ring buffer; NULL, and
> + * errno being set if a sample could not be reserved.
> + *
> + * This function is *not* thread safe, and callers must synchronize accessing
> + * this function if there are multiple producers.  If a size is requested that
> + * is larger than the size of the entire ring buffer, errno will be set to
> + * E2BIG and NULL is returned. If the ring buffer could accommodate the size,
> + * but currently does not have enough space, errno is set to ENOSPC and NULL is
> + * returned.

we might want to mention that returned pointer is 8-byte aligned

> + *
> + * After initializing the sample, callers must invoke
> + * **user_ring_buffer__submit()** to post the sample to the kernel. Otherwise,
> + * the sample must be freed with **user_ring_buffer__discard()**.
> + */
> +LIBBPF_API void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size);
> +

[...]

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

small nit if you are going to resubmit: we stopped using double
underscore naming for internal static functions, so this should be
called user_ringbuf_commit

> +{
> +       __u32 new_len;
> +       struct ringbuf_hdr *hdr;
> +       uintptr_t hdr_offset;
> +

[...]

> +void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb, __u32 size, int timeout_ms)
> +{
> +       int err;
> +       struct timespec start;
> +       __u64 ns_per_ms = 1000000, ns_elapsed = 0, timeout_ns;
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
> +       timeout_ns = timeout_ms * ns_per_ms;
> +       do {
> +               __u64 ns_remaining = timeout_ns - ns_elapsed;
> +               int cnt, ms_remaining;
> +               void *sample;
> +               struct timespec curr;
> +
> +               sample = user_ring_buffer__reserve(rb, size);
> +               if (sample)
> +                       return sample;
> +               else if (errno != ENOSPC)
> +                       return NULL;
> +
> +               ms_remaining = timeout_ms == -1 ? -1 : ns_remaining / ns_per_ms;

ok, so you've special-cased timeout_ms == -1 but still didn't do
max(0, ns_remaining). Can you prove that ns_elapsed will never be
bigger than timeout_ns due to various delays in waking up this thread?
If not, let's please have max(0) otherwise we can accidentally
epoll_wait(-1).

> +               /* The kernel guarantees at least one event notification
> +                * delivery whenever at least one sample is drained from the
> +                * ring buffer in an invocation to bpf_ringbuf_drain(). Other
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
> +               ns_elapsed = ns_elapsed_timespec(&start, &curr);

nit: if you move re-calculation of ms_remaining and ns_remaining to
here, I think overall loop logic will be even more straightforwad. You
can initialize ms_remaining to -1 if timeout_ms < 0 and never
recalculate it, right? Note that you can also do ns_elapsed conversion
to ms right here and then keep everything else in ms (so no need for
timeout_ns, ns_remaining, etc).

> +       } while (ns_elapsed <= timeout_ns);
> +
> +       errno = ENOSPC;
> +       return NULL;
> +}
> --
> 2.37.1
>
