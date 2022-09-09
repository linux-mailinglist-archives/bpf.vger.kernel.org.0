Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32EBB5B42A7
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 00:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiIIWu7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 18:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiIIWu7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 18:50:59 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE546E9140;
        Fri,  9 Sep 2022 15:50:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a70so4614772edf.10;
        Fri, 09 Sep 2022 15:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ddaea6KsAhhjAZKYACOlzIhLsiROzNYXdgJxjRQBMDQ=;
        b=azXG4FPFPuCnzdrFw85LflyOYx47ORkl+U+Oe74JvhngCWIwqfP4TUiW/fAhgzYgXs
         vxTEZsWDIyyCvURSsjbUBrRHBWG+CQQzWcCd1WNBBYtNia7na7l0Wd4Om8mgkNMysvuC
         cJfSJtenXxKVw1OM8R9w3jhQ5Iw4HvB4HNST1Wl52DxVcUv+8HN7UT8NdhIWFwV5JMei
         VEfisF/RPNh2nwjX7Roj4nbXJ5R7uEszNXhdYjgebeQK4jxExRL2GT/OP9vL6Eywu026
         JMBwOknlTNdY78yAhIxVGeruevU/x+OBEE1pxc3cBFsI1DqxuBV8whmjIgeNSewo+j8p
         YQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ddaea6KsAhhjAZKYACOlzIhLsiROzNYXdgJxjRQBMDQ=;
        b=AhoF+E72Ve/tPLIoFk8TitRFK213nAY4Zhx4BRwoYUUbmGFMpcq7/Av8J60OAZq46y
         +RD4YLXbB+YvxW9XOj3jMHP18mRoVLDdItbeRfVWr5gmwaJBB52/KuxR+gaN5ftzWita
         AVbv9feFTZSlaBCh+OIbHjDbpA64J4XMv1I8YIRHNRQvd5G1CJubzf4eaaTusBQKS3v3
         EhxXRLjneNEgkKUsMQxIDodjpPwEw3W4DJywjb0rsYbirmfkacvgQ9vCkmDbd6ZMIQeO
         BxnURgBf5CIKGTyt1nIa7wu7aXAvvnuZM/9Xulf7mhTW7nsfTAfaai2vaEuJ3Qa5XjfD
         +5Ig==
X-Gm-Message-State: ACgBeo0HGxKTzvLZyuwPR1n8AtJzV40ERDwgzhFoOSj/QUEFx0+9mmA3
        7uGTcma7bDAeM+NWRdGOk0rHfSK7dLz6a4JEJ+0=
X-Google-Smtp-Source: AA6agR5q39d8oo+twChOzp8587yPanCFhhRs7uGCGvwJ2AhV4bPVs/7mczuWyPUIFGHU1TeV3eBCYeDCxMT5VNl9W1k=
X-Received: by 2002:a05:6402:5192:b0:44f:2bdf:c075 with SMTP id
 q18-20020a056402519200b0044f2bdfc075mr10580286edd.224.1662763853114; Fri, 09
 Sep 2022 15:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220818221212.464487-1-void@manifault.com> <20220818221212.464487-4-void@manifault.com>
 <CAEf4BzZkzZacR7ziFf2orNk2znNqhJhBTDGhSOtGNvB2z4moJQ@mail.gmail.com> <Yw4TzMPXL41YuZZ6@maniforge.dhcp.thefacebook.com>
In-Reply-To: <Yw4TzMPXL41YuZZ6@maniforge.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 15:50:42 -0700
Message-ID: <CAEf4BzZFhPVicfkjyN4P6mwqmuPZzyfWiGr9wRXTGZYgTBGZbg@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 30, 2022 at 6:42 AM David Vernet <void@manifault.com> wrote:
>
> On Wed, Aug 24, 2022 at 02:58:31PM -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > +LIBBPF_API struct user_ring_buffer *
> > > +user_ring_buffer__new(int map_fd, const struct user_ring_buffer_opts *opts);
> > > +LIBBPF_API void *user_ring_buffer__reserve(struct user_ring_buffer *rb,
> > > +                                          __u32 size);
> > > +
> > > +LIBBPF_API void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb,
> > > +                                                   __u32 size,
> > > +                                                   int timeout_ms);
> > > +LIBBPF_API void user_ring_buffer__submit(struct user_ring_buffer *rb,
> > > +                                        void *sample);
> > > +LIBBPF_API void user_ring_buffer__discard(struct user_ring_buffer *rb,
> > > +                                         void *sample);
> > > +LIBBPF_API void user_ring_buffer__free(struct user_ring_buffer *rb);
> > > +

[...]

> > > +void *user_ring_buffer__reserve_blocking(struct user_ring_buffer *rb, __u32 size, int timeout_ms)
> > > +{
> > > +       int ms_elapsed = 0, err;
> > > +       struct timespec start;
> > > +
> > > +       if (timeout_ms < 0 && timeout_ms != -1)
> > > +               return errno = EINVAL, NULL;
> > > +
> > > +       if (timeout_ms != -1) {
> > > +               err = clock_gettime(CLOCK_MONOTONIC, &start);
> > > +               if (err)
> > > +                       return NULL;
> > > +       }
> > > +
> > > +       do {
> > > +               int cnt, ms_remaining = timeout_ms - ms_elapsed;
> >
> > let's max(0, timeout_ms - ms_elapsed) to avoid negative ms_remaining
> > in some edge timing cases
>
> We actually want to have a negative ms_remaining if timeout_ms is -1. -1
> in epoll_wait() specifies an infinite timeout. If we were to round up to
> 0, it wouldn't block at all.

then I think it's better to special case timeout_ms == -1. My worry
here as I mentioned is edge case timing where ms_elapsed is bigger
than our remaining timeout_ms and we go into <0 and stay blocked for
long time.

So I think it's best to pass `timeout_ms < 0 ? -1 : ms_remaining` and
still do max. But I haven't checked v5 yet, so if you already
addressed this, it's fine.


>
> > > +               void *sample;
> > > +               struct timespec curr;
> > > +
> > > +               sample = user_ring_buffer__reserve(rb, size);
> > > +               if (sample)
> > > +                       return sample;
> > > +               else if (errno != ENODATA)
> > > +                       return NULL;
> > > +
> > > +               /* The kernel guarantees at least one event notification
> > > +                * delivery whenever at least one sample is drained from the
> > > +                * ringbuffer in an invocation to bpf_ringbuf_drain(). Other
> > > +                * additional events may be delivered at any time, but only one
> > > +                * event is guaranteed per bpf_ringbuf_drain() invocation,
> > > +                * provided that a sample is drained, and the BPF program did
> > > +                * not pass BPF_RB_NO_WAKEUP to bpf_ringbuf_drain().
> > > +                */
> > > +               cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, ms_remaining);
> > > +               if (cnt < 0)
> > > +                       return NULL;
> > > +
> > > +               if (timeout_ms == -1)
> > > +                       continue;
> > > +
> > > +               err = clock_gettime(CLOCK_MONOTONIC, &curr);
> > > +               if (err)
> > > +                       return NULL;
> > > +
> > > +               ms_elapsed = ms_elapsed_timespec(&start, &curr);
> > > +       } while (ms_elapsed <= timeout_ms);
> >
> > let's simplify all the time keeping to use nanosecond timestamps and
> > only convert to ms when calling epoll_wait()? Then you can just have a
> > tiny helper to convert timespec to nanosecond ts ((u64)ts.tv_sec *
> > 1000000000 + ts.tv_nsec) and compare u64s directly. WDYT?
>
> Sounds like an improvement to me!
>
> Thanks,
> David
