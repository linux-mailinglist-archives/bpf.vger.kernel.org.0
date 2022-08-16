Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE215962DB
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 21:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbiHPTKK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 15:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiHPTKI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 15:10:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12B95E317;
        Tue, 16 Aug 2022 12:10:06 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kb8so20703582ejc.4;
        Tue, 16 Aug 2022 12:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Gb6vrnfJM7OOoBJ6O+s7HjBOdZ7QzrVmt+wFxiArqLQ=;
        b=Ny+x5K0IIsWtmOUZ8oIXcCb/s/DZG4I7Pa5XxQGoWoNlexw7hsOYvEk+T+cjqic+MQ
         Ly7y4K4tc9uVZxHcsN3+9uHstLlefVcCqjN2HDw+U2i1DrJz/gqUhgS1UjUg4vC4NSh7
         sD7THYgyCKjosqxUsp3cpmgd2ygkYSu4qp/F9u1fnAtNZZUtfrlaMakXYdH4Xr0VDi+D
         FXlYMMQ0Uw6rU+pXte5AAits+JyKMwQXWRmEQ3mVi2GgwR/P0H8vbA67y3yKA/RG/jTM
         L0gnyqdwDqQQS0AEXd1XH7JlrRopp/ZCG8nK5vGUqYE7n9m4VY7Nz4SfN9JEA8PjFcjD
         jUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Gb6vrnfJM7OOoBJ6O+s7HjBOdZ7QzrVmt+wFxiArqLQ=;
        b=btl01He5fTYiGJTg5JtdmrjphWjAMbyfbP02tMXbVXaBKx78xuqAUL3fx/fdhDugbB
         zVYYX/qUkVcjnIcIhu7sTjWe+H7HhvtNB1Jzrm65Wj1FRLkfytu2Y7vC/aq5sQeKr29q
         Vrk6F5n/GOSsck/JiRU4+yoiuYoL7xkj6n6dpHBFCja4jFyup9go2GgWxsLTOYI4bqSJ
         ux/fPTH+nzR9R83leIwBA8sEggJRLWHaM+xsqcKP/7X2iCxxpFTRHkFVmj8NuIY1aIEO
         GO6WFKy6UUpsNxsjgVT6gkdbNDAYLYRwig1+1HafTsr3u/yQXFaOT1z+Ix2cwRf7djJv
         QUAg==
X-Gm-Message-State: ACgBeo1QrPTgs2tdrexgadWMfAeSS38A4Zlr8X5tErLGZzAoo2oWQWlE
        mzCcIwxtRmxM395/oGdvjJKDJDW8l9PJNLWRWHo=
X-Google-Smtp-Source: AA6agR4V0jHlQewDLPQ8QxXGNn+w5nBp5qUKWp+JNutWcazUJpXikj1pcbuOC2yqFNHTgg1O6UZivp1Dk8LBMkkR5t8=
X-Received: by 2002:a17:907:6e22:b0:731:152:2504 with SMTP id
 sd34-20020a1709076e2200b0073101522504mr14779162ejc.545.1660677004660; Tue, 16
 Aug 2022 12:10:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155341.2479054-1-void@manifault.com> <20220808155341.2479054-4-void@manifault.com>
 <CAEf4BzYVLgd=rHaxzZjyv0WJBzBpMqGSStgVhXG9XOHpB7qDRQ@mail.gmail.com> <YvaNx8L076scJR4K@maniforge.dhcp.thefacebook.com>
In-Reply-To: <YvaNx8L076scJR4K@maniforge.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Aug 2022 12:09:53 -0700
Message-ID: <CAEf4BzbH-=hifMj9dnGoUkOR-JUkn+wuNMrM2w97FtbjnN=-CQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] bpf: Add libbpf logic for user-space ring buffer
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        joannelkoong@gmail.com, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
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

On Fri, Aug 12, 2022 at 10:28 AM David Vernet <void@manifault.com> wrote:
>
> On Thu, Aug 11, 2022 at 04:39:57PM -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > > index fc589fc8eb7c..a10558e79ec8 100644
> > > --- a/kernel/bpf/ringbuf.c
> > > +++ b/kernel/bpf/ringbuf.c
> > > @@ -639,7 +639,9 @@ static int __bpf_user_ringbuf_poll(struct bpf_ringbuf *rb, void **sample,
> > >         if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
> > >                 return -EBUSY;
> > >

[...]

> > > +void ring_buffer_user__submit(struct ring_buffer_user *rb, void *sample)
> > > +{
> > > +       __ring_buffer_user__commit(rb);
> > > +}
> >
> > this made me think that it's probably best to add kernel support for
> > busy bit anyways (just like for existing ringbuf), so that we can
> > eventually turn this into multi-producer on user-space side (all we
> > need is a lock, really). So let's anticipate that on kernel side from
> > the very beginning
>
> Hmm, yeah, fair enough. We have the extra space in the sample header to OR the
> busy bit, and we already have a 2-stage reserve -> commit workflow, so we might
> as well. I'll go ahead and add this, and then hopefully someday we can just add
> a lock, as you mentioned.

Right. We can probably also just document that reserve() step is the
only one that needs serialization among multiple producers (and
currently is required to taken care of by user app), while commit
(submit/discard) operation is thread-safe and needs no
synchronization.

The only reason we don't add it to libbpf right now is because we are
unsure about taking explicit dependency on pthread library. But I also
just found [0], so I don't know, maybe we should use that? I wonder if
it's supported by musl and other less full-featured libc
implementations, though.

  [0] https://www.gnu.org/software/libc/manual/html_node/ISO-C-Mutexes.html

>
> > > +/* Reserve a pointer to a sample in the user ring buffer. This function is *not*
> > > + * thread safe, and the ring-buffer supports only a single producer.
> > > + */
> > > +void *ring_buffer_user__reserve(struct ring_buffer_user *rb, uint32_t size)
> > > +{
> > > +       uint32_t *hdr;
> > > +       /* 64-bit to avoid overflow in case of extreme application behavior */
> > > +       size_t avail_size, total_size, max_size;
> >
> > size_t is not guaranteed to be 64-bit, neither is long

[...]

> > > +/* Poll for available space in the ringbuffer, and reserve a record when it
> > > + * becomes available.
> > > + */
> > > +void *ring_buffer_user__poll(struct ring_buffer_user *rb, uint32_t size,
> > > +                            int timeout_ms)
> > > +{
> > > +       int cnt;
> > > +
> > > +       cnt = epoll_wait(rb->epoll_fd, &rb->event, 1, timeout_ms);
> > > +       if (cnt < 0)
> > > +               return NULL;
> > > +
> > > +       return ring_buffer_user__reserve(rb, size);
> >
> > it's not clear how just doing epoll_wait() guarantees that we have >=
> > size of space available?.. Seems like some tests are missing?
>
> Right now, the kernel only kicks the polling writer once it's drained all
> of the samples from the ring buffer. So at this point, if there's not
> enough size in the buffer, there would be nothing we could do regardless.
> This seemed like reasonable, simple behavior for the initial
> implementation. I can make it a bit more intelligent if you'd like, and
> return EPOLLRWNORM as soon as there is any space in the buffer, and have
> libbpf potentially make multiple calls to epoll_wait() until enough space
> has become available.

So this "drain all samples" notion is not great: you can end drain
prematurely and thus not really drain all the data in ringbuf. With
multiple producers there could also be always more data coming in in
parallel. Plus, when in the future we'll have BPF program associated
with such ringbuf on the kernel side, we won't have a notion of
draining queue, we'll be just submitting record and letting kernel
handle it eventually.

So I think yeah, you'd have to send notification when at least one
sample gets consumed. The problem is that it's going to be a
performance hit, potentially, if you are going to do this notification
for each consumed sample. BPF ringbuf gets somewhat around that by
using heuristic to avoid notification if we see that consumer is still
behind kernel when kernel submits a new sample.

I don't know if we can do anything clever here for waiting for some
space to be available...  Any thoughts?

As for making libbpf loop until enough space is available... I guess
that would be the only reasonable implementation, right? I wonder if
calling it "user_ring_buffer__reserve_blocking()" would be a better
name than just "poll", though?
