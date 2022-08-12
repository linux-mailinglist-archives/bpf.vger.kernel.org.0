Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3AE5914C7
	for <lists+bpf@lfdr.de>; Fri, 12 Aug 2022 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbiHLR3R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Aug 2022 13:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiHLR24 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Aug 2022 13:28:56 -0400
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED048B24B7;
        Fri, 12 Aug 2022 10:28:54 -0700 (PDT)
Received: by mail-qk1-f170.google.com with SMTP id n21so1278659qkk.3;
        Fri, 12 Aug 2022 10:28:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=oqz6UIb3JXz4dQo6oXmICNm8SogxJgCT2mC2yu7MzRQ=;
        b=2uoDRj6CeIV19u6M3MeDWwrybcF1X2e2WL5yzkoDhapSu766Br/6ntQZOd43vKNxsB
         8ljj9rjLBENCpLySnOHSFWJkMhaHHRIWgr++z5sSx9yI93bT/+kqa8tU+kp+77AKm/0F
         VpwFQU87lgmgjBGavrGxgcLevKZgY+4ov+QmM0Trb9Shq6I611b84Zkeuh2f79CdKC6Q
         NNJPVV8zOMAtnkAGB0KhRO2Z6WR0eVHllt4FrkBM5aOAgpT8N5pSHEXTNe840CcG1Y6A
         Qr7l4OSsMc/S0GG4reY0kpqkpc8zg0z8WbeaIK8gR1kPPSawoWiyJ6b8QznLT5Gcta/z
         TMSw==
X-Gm-Message-State: ACgBeo0tqYUaXaeGJtvBirLNH8QihtQ9gYcClfUcKHTG0o6D5FvK5m98
        nKlYlonGQwKovj33rPZ73Xpsb+ETe42Yojxg
X-Google-Smtp-Source: AA6agR6lnn6taGlE43qGtfq2+/VAdim8V+wr+W8+QKc7j9phlrLz9EMcrbnVGfq+na93qNttZRGbNg==
X-Received: by 2002:ac8:5706:0:b0:342:fdd6:d59d with SMTP id 6-20020ac85706000000b00342fdd6d59dmr4472876qtw.159.1660325323069;
        Fri, 12 Aug 2022 10:28:43 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::9c4])
        by smtp.gmail.com with ESMTPSA id bb12-20020a05622a1b0c00b0031ef67386a5sm1978301qtb.68.2022.08.12.10.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 10:28:42 -0700 (PDT)
Date:   Fri, 12 Aug 2022 12:28:39 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 4/5] bpf: Add libbpf logic for user-space ring buffer
Message-ID: <YvaNx8L076scJR4K@maniforge.dhcp.thefacebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <20220808155341.2479054-4-void@manifault.com>
 <CAEf4BzYVLgd=rHaxzZjyv0WJBzBpMqGSStgVhXG9XOHpB7qDRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYVLgd=rHaxzZjyv0WJBzBpMqGSStgVhXG9XOHpB7qDRQ@mail.gmail.com>
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

On Thu, Aug 11, 2022 at 04:39:57PM -0700, Andrii Nakryiko wrote:

[...]

> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index fc589fc8eb7c..a10558e79ec8 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> > @@ -639,7 +639,9 @@ static int __bpf_user_ringbuf_poll(struct bpf_ringbuf *rb, void **sample,
> >         if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
> >                 return -EBUSY;
> >
> > -       /* Synchronizes with smp_store_release() in user-space. */
> > +       /* Synchronizes with smp_store_release() in __ring_buffer_user__commit()
> > +        * in user-space.
> > +        */
> 
> let's not hard-code libbpf function names in kernel comments, it's
> still user-space

Fair enough.

> >         prod_pos = smp_load_acquire(&rb->producer_pos);
> >         /* Synchronizes with smp_store_release() in
> >          * __bpf_user_ringbuf_sample_release().
> > @@ -695,6 +697,9 @@ __bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size,
> >         /* To release the ringbuffer, just increment the producer position to
> >          * signal that a new sample can be consumed. The busy bit is cleared by
> >          * userspace when posting a new sample to the ringbuffer.
> > +        *
> > +        * Synchronizes with smp_load_acquire() in ring_buffer_user__reserve()
> > +        * in user-space.
> >          */
> 
> same
> 
> >         smp_store_release(&rb->consumer_pos, rb->consumer_pos + size +
> >                           BPF_RINGBUF_HDR_SZ);
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index 9c1f2d09f44e..f7fe09dce643 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -2367,6 +2367,12 @@ static size_t adjust_ringbuf_sz(size_t sz)
> >         return sz;
> >  }
> >
> > +static bool map_is_ringbuf(const struct bpf_map *map)
> > +{
> > +       return map->def.type == BPF_MAP_TYPE_RINGBUF ||
> > +              map->def.type == BPF_MAP_TYPE_USER_RINGBUF;
> > +}
> > +
> >  static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def)
> >  {
> >         map->def.type = def->map_type;
> > @@ -2381,7 +2387,7 @@ static void fill_map_from_def(struct bpf_map *map, const struct btf_map_def *def
> >         map->btf_value_type_id = def->value_type_id;
> >
> >         /* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
> > -       if (map->def.type == BPF_MAP_TYPE_RINGBUF)
> > +       if (map_is_ringbuf(map))
> >                 map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
> >
> >         if (def->parts & MAP_DEF_MAP_TYPE)
> > @@ -4363,7 +4369,7 @@ int bpf_map__set_max_entries(struct bpf_map *map, __u32 max_entries)
> >         map->def.max_entries = max_entries;
> >
> >         /* auto-adjust BPF ringbuf map max_entries to be a multiple of page size */
> > -       if (map->def.type == BPF_MAP_TYPE_RINGBUF)
> > +       if (map_is_ringbuf(map))
> >                 map->def.max_entries = adjust_ringbuf_sz(map->def.max_entries);
> >
> >         return 0;
> > diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> > index 61493c4cddac..6d1d0539b08d 100644
> > --- a/tools/lib/bpf/libbpf.h
> > +++ b/tools/lib/bpf/libbpf.h
> > @@ -1009,6 +1009,7 @@ LIBBPF_API int bpf_tc_query(const struct bpf_tc_hook *hook,
> >
> >  /* Ring buffer APIs */
> >  struct ring_buffer;
> > +struct ring_buffer_user;
> 
> 
> I know that I'm the one asking to use ring_buffer_user name, but given
> kernel is using USER_RINGBUF and user_ringbuf naming, let's be
> consistent and use user_ring_buffer in libbpf as well. I was
> contemplating uring_buffer, can't make up my mind if it's better or
> not.

Not a problem, I'll revert it back to user_ring_buffer.

> Also ring_buffer_user reads like "user of ring buffer", which adds to
> confusion :)

[...]

> > +static void __user_ringbuf_unmap_ring(struct ring_buffer_user *rb)
> 
> libbpf generally doesn't use double underscore naming pattern, let's
> not do that here as well

Ack.

> > +{
> > +       if (rb->consumer_pos) {
> > +               munmap(rb->consumer_pos, rb->page_size);
> > +               rb->consumer_pos = NULL;
> > +       }
> > +       if (rb->producer_pos) {
> > +               munmap(rb->producer_pos, rb->page_size + 2 * (rb->mask + 1));
> > +               rb->producer_pos = NULL;
> > +       }
> > +}
> > +
> > +void ring_buffer_user__free(struct ring_buffer_user *rb)
> > +{
> > +       if (!rb)
> > +               return;
> > +
> > +       __user_ringbuf_unmap_ring(rb);
> > +
> > +       if (rb->epoll_fd >= 0)
> > +               close(rb->epoll_fd);
> > +
> > +       free(rb);
> > +}
> > +
> > +static int __ring_buffer_user_map(struct ring_buffer_user *rb, int map_fd)
> > +{
> > +
> 
> please don't leave stray empty lines around the code

Sorry, not sure how I missed that.

> > +static void __ring_buffer_user__commit(struct ring_buffer_user *rb)
> > +{
> > +       uint32_t *hdr;
> > +       uint32_t total_len;
> > +       unsigned long prod_pos;
> > +
> > +       prod_pos = *rb->producer_pos;
> > +       hdr = rb->data + (prod_pos & rb->mask);
> > +
> > +       total_len = *hdr + BPF_RINGBUF_HDR_SZ;
> 
> round up to multiple of 8

Will do, and I'll also validate this in the kernel.

> > +
> > +       /* Synchronizes with smp_load_acquire() in __bpf_user_ringbuf_poll() in
> > +        * the kernel.
> > +        */
> > +       smp_store_release(rb->producer_pos, prod_pos + total_len);
> > +}
> > +
> > +/* Discard a previously reserved sample into the ring buffer. Because the user
> > + * ringbuffer is assumed to be single producer, this can simply be a no-op, and
> > + * the producer pointer is left in the same place as when it was reserved.
> > + */
> > +void ring_buffer_user__discard(struct ring_buffer_user *rb, void *sample)
> > +{}
> 
> {
> }

Ack.

> > +
> > +/* Submit a previously reserved sample into the ring buffer.
> > + */
> 
> nit: this is single-line comment

Ack.

> > +void ring_buffer_user__submit(struct ring_buffer_user *rb, void *sample)
> > +{
> > +       __ring_buffer_user__commit(rb);
> > +}
> 
> this made me think that it's probably best to add kernel support for
> busy bit anyways (just like for existing ringbuf), so that we can
> eventually turn this into multi-producer on user-space side (all we
> need is a lock, really). So let's anticipate that on kernel side from
> the very beginning

Hmm, yeah, fair enough. We have the extra space in the sample header to OR the
busy bit, and we already have a 2-stage reserve -> commit workflow, so we might
as well. I'll go ahead and add this, and then hopefully someday we can just add
a lock, as you mentioned.

> > +/* Reserve a pointer to a sample in the user ring buffer. This function is *not*
> > + * thread safe, and the ring-buffer supports only a single producer.
> > + */
> > +void *ring_buffer_user__reserve(struct ring_buffer_user *rb, uint32_t size)
> > +{
> > +       uint32_t *hdr;
> > +       /* 64-bit to avoid overflow in case of extreme application behavior */
> > +       size_t avail_size, total_size, max_size;
> 
> size_t is not guaranteed to be 64-bit, neither is long

Sorry, you're right. I'll just use explicit bit-width types.

> > +       unsigned long cons_pos, prod_pos;
> > +
> > +       /* Synchronizes with smp_store_release() in __bpf_user_ringbuf_poll() in
> > +        * the kernel.
> > +        */
> > +       cons_pos = smp_load_acquire(rb->consumer_pos);
> > +       /* Synchronizes with smp_store_release() in __ring_buffer_user__commit()
> > +        */
> > +       prod_pos = smp_load_acquire(rb->producer_pos);
> > +
> > +       max_size = rb->mask + 1;
> > +       avail_size = max_size - (prod_pos - cons_pos);
> > +       total_size = size + BPF_RINGBUF_HDR_SZ;
> 
> round_up(8)

Ack.

> > +
> > +       if (total_size > max_size || avail_size < total_size)
> > +               return NULL;
> 
> set errno as well?

Will do.

> > +
> > +       hdr = rb->data + (prod_pos & rb->mask);
> > +       *hdr = size;
> 
> I'd make sure that entire 8 bytes of header are zero-initialized, for
> better future extensibility

Will do.

> > +
> > +       /* Producer pos is updated when a sample is submitted. */
> > +
> > +       return (void *)rb->data + ((prod_pos + BPF_RINGBUF_HDR_SZ) & rb->mask);
> > +}
> > +
> > +/* Poll for available space in the ringbuffer, and reserve a record when it
> > + * becomes available.
> > + */
> > +void *ring_buffer_user__poll(struct ring_buffer_user *rb, uint32_t size,
> > +                            int timeout_ms)
> > +{
> > +       int cnt;
> > +
> > +       cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, timeout_ms);
> > +       if (cnt < 0)
> > +               return NULL;
> > +
> > +       return ring_buffer_user__reserve(rb, size);
> 
> it's not clear how just doing epoll_wait() guarantees that we have >=
> size of space available?.. Seems like some tests are missing?

Right now, the kernel only kicks the polling writer once it's drained all
of the samples from the ring buffer. So at this point, if there's not
enough size in the buffer, there would be nothing we could do regardless.
This seemed like reasonable, simple behavior for the initial
implementation. I can make it a bit more intelligent if you'd like, and
return EPOLLRWNORM as soon as there is any space in the buffer, and have
libbpf potentially make multiple calls to epoll_wait() until enough space
has become available.
