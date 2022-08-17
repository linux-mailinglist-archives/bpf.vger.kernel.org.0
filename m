Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110B0597091
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 16:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbiHQOEB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 10:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiHQOD2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 10:03:28 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3889751D;
        Wed, 17 Aug 2022 07:02:49 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id w18so5409234qki.8;
        Wed, 17 Aug 2022 07:02:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xGvnP+cdj8d4VtMasuJ9qa53U1HW/oz4CJM0XoL8DpQ=;
        b=lOiOaS6e7h4vD0B7jSJpY6ndyKSDzVyVSOtkgpMd0CNGivDrFSSdfGczY3l1ZgzTm0
         98Cs3GeG5hLa/G2UaliDkSKvHSLqu7kVK1ROs9PvI9Dfe67jzWL/jB2BWeeESABNHMe3
         xGdTm4w2YKYD5igykgi7PPEB2781qIULkJtNKhZhJHAKDiYrKDs1GI0SoBTTsf0PQY3r
         Jtvdjzq1H/ws+vlAy63bbzsypDHdgypPwiJlbOihqZ1eQo/LuXWZLlaZ5twssfXwWwBE
         7aTm8iU1xG6lwjBZ1NBuHHapxpo13js5gVeYYfonYZws2dnxVgxyYK4qWN0o2hIGAiV0
         ROZg==
X-Gm-Message-State: ACgBeo1ParTKyuC3BIUjBftuY0fBx84qOmibcgu4EDy6RzC0X4qatEK6
        BxKXvoDITzmAmYCL1d0qzaY=
X-Google-Smtp-Source: AA6agR74DS2PNIIKBQpO17xcS4vPE532nPqUfxppaZozIy/EOk3nhyCLshXcmNALm6l8AQDlTqQFDg==
X-Received: by 2002:a37:bb05:0:b0:6b9:629e:f46b with SMTP id l5-20020a37bb05000000b006b9629ef46bmr8604510qkf.521.1660744967470;
        Wed, 17 Aug 2022 07:02:47 -0700 (PDT)
Received: from maniforge.DHCP.thefacebook.com ([2620:10d:c091:480::a5ed])
        by smtp.gmail.com with ESMTPSA id bt14-20020ac8690e000000b00342f6c31da7sm12336226qtb.94.2022.08.17.07.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 07:02:47 -0700 (PDT)
Date:   Wed, 17 Aug 2022 09:02:14 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 4/5] bpf: Add libbpf logic for user-space ring buffer
Message-ID: <Yvz05lW8tCJFKrUO@maniforge.DHCP.thefacebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <20220808155341.2479054-4-void@manifault.com>
 <CAEf4BzYVLgd=rHaxzZjyv0WJBzBpMqGSStgVhXG9XOHpB7qDRQ@mail.gmail.com>
 <YvaNx8L076scJR4K@maniforge.dhcp.thefacebook.com>
 <CAEf4BzbH-=hifMj9dnGoUkOR-JUkn+wuNMrM2w97FtbjnN=-CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbH-=hifMj9dnGoUkOR-JUkn+wuNMrM2w97FtbjnN=-CQ@mail.gmail.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 12:09:53PM -0700, Andrii Nakryiko wrote:
> > > > +void ring_buffer_user__submit(struct ring_buffer_user *rb, void *sample)
> > > > +{
> > > > +       __ring_buffer_user__commit(rb);
> > > > +}
> > >
> > > this made me think that it's probably best to add kernel support for
> > > busy bit anyways (just like for existing ringbuf), so that we can
> > > eventually turn this into multi-producer on user-space side (all we
> > > need is a lock, really). So let's anticipate that on kernel side from
> > > the very beginning
> >
> > Hmm, yeah, fair enough. We have the extra space in the sample header to OR the
> > busy bit, and we already have a 2-stage reserve -> commit workflow, so we might
> > as well. I'll go ahead and add this, and then hopefully someday we can just add
> > a lock, as you mentioned.
> 
> Right. We can probably also just document that reserve() step is the
> only one that needs serialization among multiple producers (and
> currently is required to taken care of by user app), while commit
> (submit/discard) operation is thread-safe and needs no
> synchronization.

Sounds good.

> The only reason we don't add it to libbpf right now is because we are
> unsure about taking explicit dependency on pthread library. But I also
> just found [0], so I don't know, maybe we should use that? I wonder if
> it's supported by musl and other less full-featured libc
> implementations, though.
> 
>   [0] https://www.gnu.org/software/libc/manual/html_node/ISO-C-Mutexes.html

IMHO, and others may disagree, if it's in the C standard it seems like it
should be fair game to add to libbpf? Also FWIW, it looks like musl does
support it.  See mtx_*.c in [0].

[0] https://git.musl-libc.org/cgit/musl/tree/src/thread

That being said, I would like to try and keep this decision outside the
scope of user-ringbuf though, if possible. Would you be OK this landing
as is (modulo further discussion, revisions, etc, of course), and then
we can update this implementation to be multi-producer if and when we've
added something like mtx_t support in a follow-on patch-set?

[...]

> > > > +/* Poll for available space in the ringbuffer, and reserve a record when it
> > > > + * becomes available.
> > > > + */
> > > > +void *ring_buffer_user__poll(struct ring_buffer_user *rb, uint32_t size,
> > > > +                            int timeout_ms)
> > > > +{
> > > > +       int cnt;
> > > > +
> > > > +       cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, timeout_ms);
> > > > +       if (cnt < 0)
> > > > +               return NULL;
> > > > +
> > > > +       return ring_buffer_user__reserve(rb, size);
> > >
> > > it's not clear how just doing epoll_wait() guarantees that we have >=
> > > size of space available?.. Seems like some tests are missing?
> >
> > Right now, the kernel only kicks the polling writer once it's drained all
> > of the samples from the ring buffer. So at this point, if there's not
> > enough size in the buffer, there would be nothing we could do regardless.
> > This seemed like reasonable, simple behavior for the initial
> > implementation. I can make it a bit more intelligent if you'd like, and
> > return EPOLLRWNORM as soon as there is any space in the buffer, and have
> > libbpf potentially make multiple calls to epoll_wait() until enough space
> > has become available.
> 
> So this "drain all samples" notion is not great: you can end drain
> prematurely and thus not really drain all the data in ringbuf.With
> multiple producers there could also be always more data coming in in
> parallel. Plus, when in the future we'll have BPF program associated
> with such ringbuf on the kernel side, we won't have a notion of
> draining queue, we'll be just submitting record and letting kernel
> handle it eventually.

I don't disagree with any of your points. I think what we'll have to
decide-on is a trade-off between performance and usability. As you pointed
out, if we only kick user-space once the ringbuffer is empty, that imposes
the requirement on the kernel that it will always drain the ringbuffer.
That might not even be possible though if we have multiple producers
posting data in parallel.

More on this below, but the TL;DR is that I agree with you, and I think
having a model where we kick user-space whenever a sample is consumed from
the buffer is a lot easier to reason about, and probably our only option if
our plan is to make the ringbuffer MPMC. I'll make this change in v3.

> So I think yeah, you'd have to send notification when at least one
> sample gets consumed. The problem is that it's going to be a
> performance hit, potentially, if you are going to do this notification
> for each consumed sample. BPF ringbuf gets somewhat around that by
> using heuristic to avoid notification if we see that consumer is still
> behind kernel when kernel submits a new sample.

Something perhaps worth pointing out here is that this heuristic works
because the kernel-producer ringbuffer is MPSC. If it were MPMC, we'd
potentially have the same problem you pointed out above where you'd never
wake up an epoll-waiter because other consumers would drain the buffer, and
by the time the kernel got around to posting another sample, could observe
that consumer_pos == producer_pos, and either wouldn't wake up anyone on
the waitq, or wouldn't return any events from ringbuf_map_poll(). If our
intention is to make user-space ringbuffers MPMC, it becomes more difficult
to use these nice heuristics.

> I don't know if we can do anything clever here for waiting for some
> space to be available...  Any thoughts?

Hmmm, yeah, nothing clever is coming to mind. The problem is that we can't
make assumptions about why user-space would be epoll-waiting on the
ringbuffer because because it's a producer, and the user-space producer is
free to post variably sized samples.

For example, I was initially considering whether we could do a heuristic
where we notify the producer only if the buffer was previously full /
producer_pos was ringbuf size away from consumer_pos when we drained a
sample, but that doesn't work at all because there could be space in the
ringbuffer, but user-space is epoll-waiting for *more* space to become
available for some large sample that it wants to publish.

I think the only options we have are:

1. Send a notification (i.e. schedule bpf_ringbuf_notify() using
   irq_work_queue(), and then return EPOLLOUT | EPOLLWRNORM if
   the ringbuffer is not full), every time a sample is drained.

2. Keep the behavior in v1, wherein we have a contract that the kernel will
   always eventually drain the ringbuffer, and will kick user-space when the
   buffer is empty. I think a requirement here would also be that the
   ringbuffer would be SPMC, or we decide that it's acceptable for some
   producers to sleep indefinitely if other producers keep reading samples,
   and that the caller just needs to be aware of this as a possibility.

My two cents are that we go with (1), and then consider our options later
if we need to optimize.

> As for making libbpf loop until enough space is available... I guess
> that would be the only reasonable implementation, right? I wonder if
> calling it "user_ring_buffer__reserve_blocking()" would be a better
> name than just "poll", though?

I went with user_ring_buffer__poll() to match the complementary function
for the user-space consumer function for kernel-producer ringbuffers:
ring_buffer__poll(). I personally prefer
user_ring_buffer__reserve_blocking() because the fact that it's doing an
epoll-wait is entirely an implementation detail. I'll go ahead and make
that change in v3.

Thanks,
David
