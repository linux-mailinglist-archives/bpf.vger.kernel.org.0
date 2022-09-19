Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F154F5BD5AB
	for <lists+bpf@lfdr.de>; Mon, 19 Sep 2022 22:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiISUWO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Sep 2022 16:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiISUWM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Sep 2022 16:22:12 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4D012ABE;
        Mon, 19 Sep 2022 13:22:11 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id ay9so420656qtb.0;
        Mon, 19 Sep 2022 13:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=wDTIaXsCRjka4ASfvY6kZGhR2gLeVg2UBWa2lHdwRY4=;
        b=UR/9VHKYKrqEQpN8hF1rnq2wd6ZDiI4kxN4Q7QDBMqDuGhGaQFKAyE6DBJYKQSE9uH
         TyUh+3jYTll4+K469n8jfZ298I4+KJq5iJJNvj+SYmQXUs/BDP1FINp58XMDT8w/GQjK
         weWz57b2x2/E0D+JIjbJy2ptGaXhFrHkBhndrAYFvhZv9kUKs2KgVl19zhaZlWtGtBOp
         vDMJRqy7Q3+tAxuiF6CTPAfHXqo3XJkQ5mJIDhB9U87/srl9vAgxJJ+Vmsq4inVFw001
         Rlg5eb6Sx3hm/EEoN8X38l98e2saArxVW0zMkx8ZyiVeqrDIFqNceCZuXxK8K52VWl8h
         OjAg==
X-Gm-Message-State: ACrzQf1IzKzYFLR/vcz2NEQcrrUckFLPgmgMNGRT3VvdFRbRTXz+NpCL
        HfEHOg9fb7BFfgoB5rEhdmc=
X-Google-Smtp-Source: AMsMyM6fFbgIGHOiLt58/JyT9PpbxS4Zj/ZDMnC+RgvkvLVkHTrYKfrBYe0FzL4Sx0mP7v4LFBPyhg==
X-Received: by 2002:ac8:5a11:0:b0:35b:a2ec:2b73 with SMTP id n17-20020ac85a11000000b0035ba2ec2b73mr16525582qta.364.1663618930679;
        Mon, 19 Sep 2022 13:22:10 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::148f])
        by smtp.gmail.com with ESMTPSA id c8-20020ac84e08000000b0035ba366cc90sm10893176qtw.15.2022.09.19.13.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 13:22:10 -0700 (PDT)
Date:   Mon, 19 Sep 2022 15:22:09 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, bpf@vger.kernel.org, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v5 3/4] bpf: Add libbpf logic for user-space ring buffer
Message-ID: <YyjPcSoBWYtjYIVj@maniforge.dhcp.thefacebook.com>
References: <20220902234317.2518808-1-void@manifault.com>
 <20220902234317.2518808-4-void@manifault.com>
 <CAEf4Bzbz_7eVSOY0iGp0YkADx80TgZw8cV6NvSm6V1EF=xKo4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzbz_7eVSOY0iGp0YkADx80TgZw8cV6NvSm6V1EF=xKo4A@mail.gmail.com>
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

On Fri, Sep 09, 2022 at 04:59:27PM -0700, Andrii Nakryiko wrote:
> > @@ -1011,6 +1011,7 @@ LIBBPF_API int bpf_tc_query(const struct bpf_tc_hook *hook,
> >
> >  /* Ring buffer APIs */
> >  struct ring_buffer;
> > +struct user_ring_buffer;
> >
> >  typedef int (*ring_buffer_sample_fn)(void *ctx, void *data, size_t size);
> >
> > @@ -1030,6 +1031,110 @@ LIBBPF_API int ring_buffer__poll(struct ring_buffer *rb, int timeout_ms);
> >  LIBBPF_API int ring_buffer__consume(struct ring_buffer *rb);
> >  LIBBPF_API int ring_buffer__epoll_fd(const struct ring_buffer *rb);
> >
> > +struct user_ring_buffer_opts {
> > +       size_t sz; /* size of this struct, for forward/backward compatibility */
> > +};
> > +
> > +#define user_ring_buffer_opts__last_field sz
> > +
> > +/* @brief **user_ring_buffer__new()** creates a new instance of a user ring
> > + * buffer.
> > + *
> > + * @param map_fd A file descriptor to a BPF_MAP_TYPE_RINGBUF map.
> 
> typo: USER_RINGBUF

Good catch.

> > + * @param opts Options for how the ring buffer should be created.
> > + * @return A user ring buffer on success; NULL and errno being set on a
> > + * failure.
> > + */
> > +LIBBPF_API struct user_ring_buffer *
> > +user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts);
> > +
> > +/* @brief **user_ring_buffer__reserve()** reserves a pointer to a sample in the
> > + * user ring buffer.
> > + * @param rb A pointer to a user ring buffer.
> > + * @param size The size of the sample, in bytes.
> > + * @return A pointer to a reserved region of the user ring buffer; NULL, and
> > + * errno being set if a sample could not be reserved.
> > + *
> > + * This function is *not* thread safe, and callers must synchronize accessing
> > + * this function if there are multiple producers.  If a size is requested that
> > + * is larger than the size of the entire ring buffer, errno will be set to
> > + * E2BIG and NULL is returned. If the ring buffer could accommodate the size,
> > + * but currently does not have enough space, errno is set to ENOSPC and NULL is
> > + * returned.
> 
> we might want to mention that returned pointer is 8-byte aligned

Will do.

> > + *
> > + * After initializing the sample, callers must invoke
> > + * **user_ring_buffer__submit()** to post the sample to the kernel. Otherwise,
> > + * the sample must be freed with **user_ring_buffer__discard()**.
> > + */
> > +LIBBPF_API void *user_ring_buffer__reserve(struct user_ring_buffer *rb, __u32 size);
> > +
> 
> [...]
> 
> > +       err = user_ringbuf_map(rb, map_fd);
> > +       if (err)
> > +               goto err_out;
> > +
> > +       return rb;
> > +
> > +err_out:
> > +       user_ring_buffer__free(rb);
> > +       return errno = -err, NULL;
> > +}
> > +
> > +static void user_ringbuf__commit(struct user_ring_buffer *rb, void *sample, bool discard)
> 
> small nit if you are going to resubmit: we stopped using double
> underscore naming for internal static functions, so this should be
> called user_ringbuf_commit

Will do.

> > +{
> > +       __u32 new_len;
> > +       struct ringbuf_hdr *hdr;
> > +       uintptr_t hdr_offset;
> > +
> 
> [...]
> 
> > +void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb, __u32 size, int timeout_ms)
> > +{
> > +       int err;
> > +       struct timespec start;
> > +       __u64 ns_per_ms = 1000000, ns_elapsed = 0, timeout_ns;
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
> > +       timeout_ns = timeout_ms * ns_per_ms;
> > +       do {
> > +               __u64 ns_remaining = timeout_ns - ns_elapsed;
> > +               int cnt, ms_remaining;
> > +               void *sample;
> > +               struct timespec curr;
> > +
> > +               sample = user_ring_buffer__reserve(rb, size);
> > +               if (sample)
> > +                       return sample;
> > +               else if (errno != ENOSPC)
> > +                       return NULL;
> > +
> > +               ms_remaining = timeout_ms == -1 ? -1 : ns_remaining / ns_per_ms;
> 
> ok, so you've special-cased timeout_ms == -1 but still didn't do
> max(0, ns_remaining). Can you prove that ns_elapsed will never be
> bigger than timeout_ns due to various delays in waking up this thread?
> If not, let's please have max(0) otherwise we can accidentally
> epoll_wait(-1).

Yes you're right, this was an oversight. Thanks for catching this!

> > +               /* The kernel guarantees at least one event notification
> > +                * delivery whenever at least one sample is drained from the
> > +                * ring buffer in an invocation to bpf_ringbuf_drain(). Other
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
> > +               ns_elapsed = ns_elapsed_timespec(&start, &curr);
> 
> nit: if you move re-calculation of ms_remaining and ns_remaining to
> here, I think overall loop logic will be even more straightforwad. You
> can initialize ms_remaining to -1 if timeout_ms < 0 and never
> recalculate it, right? Note that you can also do ns_elapsed conversion
> to ms right here and then keep everything else in ms (so no need for
> timeout_ns, ns_remaining, etc).

Sounds good, let me give this a shot in v6.

Thanks for another detailed review!
