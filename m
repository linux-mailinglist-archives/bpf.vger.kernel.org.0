Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EDC597C00
	for <lists+bpf@lfdr.de>; Thu, 18 Aug 2022 05:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiHRDGf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 23:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240247AbiHRDG1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 23:06:27 -0400
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8BF5142D;
        Wed, 17 Aug 2022 20:06:26 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id j1so364735qvv.8;
        Wed, 17 Aug 2022 20:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=RDgEoVmmSarhmlMbEJyzA9UImN4LT8sVx+e0kSfp4lk=;
        b=FeReqvJowShkeXUzVBMd3+9BB9N6ftS/mtqQLmiDiGHtD+j84YogMfLUqfeOduIV6E
         JJu7fJ6bDAEmruJVNbymW9+wZyG33+jbj86KFrYl/UYm3eCF9dd2x7HFs5L3aa7Hbrrt
         gR3cFOfY0LKA3ScE/F1Et2H5WqcV22i+F+er7jdwzYcjZz48Ngan1AnyoGFikch1kgdq
         6Nu3x4sZloEYWztHTh55XaABbP6JJEZggaEX1wa0HO4gYpsuMMvnXxsUXCedPWAN2iI7
         iDxmDH6ptOUreoxfYvC0F3lB+LarJ9EaHYluCysnxOjwzSTMLIM+owvp+apnINsP6zdU
         odxg==
X-Gm-Message-State: ACgBeo0Q7INTgmGGRPHnJza12nbf9X7xtJALzQay3dKO+xZDyxADVDfM
        RFhZZYVqWx4MA+E0kwL8n8DCmLpJw7uedyS3
X-Google-Smtp-Source: AA6agR4qzV3WuJsBLJpych3STIfEvJaK1hLBCr/u16wYXdpKUNSw9BZkbmMJ/FdNeQ2+188tk12d+A==
X-Received: by 2002:a05:6214:dcc:b0:495:613d:f516 with SMTP id 12-20020a0562140dcc00b00495613df516mr853054qvt.75.1660791985559;
        Wed, 17 Aug 2022 20:06:25 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::a5ed])
        by smtp.gmail.com with ESMTPSA id az44-20020a05620a172c00b006bb87c4833asm487661qkb.109.2022.08.17.20.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 20:06:25 -0700 (PDT)
Date:   Wed, 17 Aug 2022 22:05:45 -0500
From:   David Vernet <void@manifault.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH 4/5] bpf: Add libbpf logic for user-space ring buffer
Message-ID: <Yv2siYR0STsAem5L@maniforge.dhcp.thefacebook.com>
References: <20220808155341.2479054-1-void@manifault.com>
 <20220808155341.2479054-4-void@manifault.com>
 <CAEf4BzYVLgd=rHaxzZjyv0WJBzBpMqGSStgVhXG9XOHpB7qDRQ@mail.gmail.com>
 <YvaNx8L076scJR4K@maniforge.dhcp.thefacebook.com>
 <CAEf4BzbH-=hifMj9dnGoUkOR-JUkn+wuNMrM2w97FtbjnN=-CQ@mail.gmail.com>
 <Yvz05lW8tCJFKrUO@maniforge.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yvz05lW8tCJFKrUO@maniforge.DHCP.thefacebook.com>
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

On Wed, Aug 17, 2022 at 09:02:14AM -0500, David Vernet wrote:

[...]

> > > > > +/* Poll for available space in the ringbuffer, and reserve a record when it
> > > > > + * becomes available.
> > > > > + */
> > > > > +void *ring_buffer_user__poll(struct ring_buffer_user *rb, uint32_t size,
> > > > > +                            int timeout_ms)
> > > > > +{
> > > > > +       int cnt;
> > > > > +
> > > > > +       cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, timeout_ms);
> > > > > +       if (cnt < 0)
> > > > > +               return NULL;
> > > > > +
> > > > > +       return ring_buffer_user__reserve(rb, size);
> > > >
> > > > it's not clear how just doing epoll_wait() guarantees that we have >=
> > > > size of space available?.. Seems like some tests are missing?
> > >
> > > Right now, the kernel only kicks the polling writer once it's drained all
> > > of the samples from the ring buffer. So at this point, if there's not
> > > enough size in the buffer, there would be nothing we could do regardless.
> > > This seemed like reasonable, simple behavior for the initial
> > > implementation. I can make it a bit more intelligent if you'd like, and
> > > return EPOLLRWNORM as soon as there is any space in the buffer, and have
> > > libbpf potentially make multiple calls to epoll_wait() until enough space
> > > has become available.
> > 
> > So this "drain all samples" notion is not great: you can end drain
> > prematurely and thus not really drain all the data in ringbuf.With
> > multiple producers there could also be always more data coming in in
> > parallel. Plus, when in the future we'll have BPF program associated
> > with such ringbuf on the kernel side, we won't have a notion of
> > draining queue, we'll be just submitting record and letting kernel
> > handle it eventually.
> 
> I don't disagree with any of your points. I think what we'll have to
> decide-on is a trade-off between performance and usability. As you pointed
> out, if we only kick user-space once the ringbuffer is empty, that imposes
> the requirement on the kernel that it will always drain the ringbuffer.
> That might not even be possible though if we have multiple producers
> posting data in parallel.
> 
> More on this below, but the TL;DR is that I agree with you, and I think
> having a model where we kick user-space whenever a sample is consumed from
> the buffer is a lot easier to reason about, and probably our only option if
> our plan is to make the ringbuffer MPMC. I'll make this change in v3.
> 
> > So I think yeah, you'd have to send notification when at least one
> > sample gets consumed. The problem is that it's going to be a
> > performance hit, potentially, if you are going to do this notification
> > for each consumed sample. BPF ringbuf gets somewhat around that by
> > using heuristic to avoid notification if we see that consumer is still
> > behind kernel when kernel submits a new sample.
> 
> Something perhaps worth pointing out here is that this heuristic works
> because the kernel-producer ringbuffer is MPSC. If it were MPMC, we'd
> potentially have the same problem you pointed out above where you'd never
> wake up an epoll-waiter because other consumers would drain the buffer, and
> by the time the kernel got around to posting another sample, could observe
> that consumer_pos == producer_pos, and either wouldn't wake up anyone on
> the waitq, or wouldn't return any events from ringbuf_map_poll(). If our
> intention is to make user-space ringbuffers MPMC, it becomes more difficult
> to use these nice heuristics.
> 
> > I don't know if we can do anything clever here for waiting for some
> > space to be available...  Any thoughts?
> 
> Hmmm, yeah, nothing clever is coming to mind. The problem is that we can't
> make assumptions about why user-space would be epoll-waiting on the
> ringbuffer because because it's a producer, and the user-space producer is
> free to post variably sized samples.
> 
> For example, I was initially considering whether we could do a heuristic
> where we notify the producer only if the buffer was previously full /
> producer_pos was ringbuf size away from consumer_pos when we drained a
> sample, but that doesn't work at all because there could be space in the
> ringbuffer, but user-space is epoll-waiting for *more* space to become
> available for some large sample that it wants to publish.
> 
> I think the only options we have are:
> 
> 1. Send a notification (i.e. schedule bpf_ringbuf_notify() using
>    irq_work_queue(), and then return EPOLLOUT | EPOLLWRNORM if
>    the ringbuffer is not full), every time a sample is drained.
> 
> 2. Keep the behavior in v1, wherein we have a contract that the kernel will
>    always eventually drain the ringbuffer, and will kick user-space when the
>    buffer is empty. I think a requirement here would also be that the
>    ringbuffer would be SPMC, or we decide that it's acceptable for some
>    producers to sleep indefinitely if other producers keep reading samples,
>    and that the caller just needs to be aware of this as a possibility.
> 
> My two cents are that we go with (1), and then consider our options later
> if we need to optimize.

Unfortunately this causes the system to hang because of how many times
we're invoking irq_work_queue() in rapid succession.

So, I'm not sure that notifying the user-space producer after _every_
sample is going to work. Another option that occurred to me, however, is to
augment the initial approach taken in v1. Rather than only sending a
notification when the ringbuffer is empty, we could instead guarantee that
we'll always send a notification when bpf_ringbuf_drain() is called and at
least one message was consumed. This is slightly stronger than our earlier
guarantee because we may send a notification even if the ringbuffer is only
partially drained, and it avoids some of the associated pitfalls that you
pointed out (e.g. that a BPF program is now responsible for always draining
the ringbuffer in order to ensure that an epoll-waiting user-space producer
will always be woken up).

The down-side of this is that it still may not be aggressive enough in
waking up user-space producers who could have had data to post as soon as
space was available in the ringbuffer. It won't potentially cause them to
block indefinitely as the first approach did, but they'll still have to
wait for the end of bpf_ringbuf_drain() to be woken up, when they could
potentially have been woken up sooner to start publishing samples. It's
hard to say whether this will be prohibitive to the feature being usable,
but in my opinion it's more useful to have this functionality (and make its
behavior very clearly described in comments and the public documentation
for the APIs) in an imperfect form than to not have it at all.

Additionally, a plus-side to this approach is that it gives us some
flexibility to send more event notifications if we want to. For example, we
could add a heuristic where we always send a notification if the buffer was
previously full before a sample was consumed (in contrast to always
invoking irq_work_queue() _whenever_ a sample is consumed), and then always
send a notification at the end of bpf_ringbuf_drain() to catch any
producers who were waiting for a larger sample than what was afforded by
the initial heuristic notification. I think this should address the likely
common use-case of samples being statically sized (so posting an event as
soon as the ringbuffer is no longer empty should almost always be
sufficient).

We discussed this offline, so I'll go ahead and implement it for the next
version. One thing we didn't discuss was the example heuristic described
above, but I'm going to include that because it seems like the
complementary behavior to what we do for kernel-producer ringbuffers. If
folks aren't a fan, we can remove it in favor of only sending a single
notification in bpf_ringbuf_drain().

Thanks,
David
