Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04613596257
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiHPSZI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 14:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiHPSZH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 14:25:07 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADA70E7C
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 11:25:05 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-32fd97c199fso148490957b3.6
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 11:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jh5Eur1xH7TUcw/KyH0b+upiru51QcqFI31rJnzh5yc=;
        b=OgbGNkaNr33pOmBPKEY2/zGo3Q2htOs5e2SwlTvvs9Ewx5Kap+vdDhgWiEHwtZjY6p
         rgedUDOvHE0CaFTFZStQkaLAPeO/yePrNMWPwEKYWXYhYFXR3LdpWwj5N90LObmDHnry
         /1+jjairKpXx2/M4LVD2ZmnvEo3dhvtHNJXZsnELBMy5tqeNSAeRPxc/Yfx07LUu6Cus
         agra6s3DaZyTcBhXE0xoRDNBJ9DNSKRQg56gcSSEEC8EZ3YMU1ulLUA/7uSEe/ZhDitT
         Xqveukqk4fdlb6K1NoNs18LgkiYxY1i0H2DGNOkvcTXUCSBqDe8x4d0NHs13QcE2jADW
         9H8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jh5Eur1xH7TUcw/KyH0b+upiru51QcqFI31rJnzh5yc=;
        b=l9WlrUjwXUyWfbTrUszjdZCIud3Pfdi7Vcs4u/pPl8TK/sfBVq2GV+oirzqrcGG1zQ
         9WiQDmhrC+iBrtC1+GbUi5/Yk/Eljf1zelXQ4uZp84iy+QA2iz75DDM+R4/QS8UFDOsc
         Grn0LHjL6hLP3wY1qVjW6VjQqNy3+DVGVsqunUHWA7PrDLpWqa5dvgC6Mi1V5w/2vOTa
         GLZQevx6ASzgRrBW/pdLrcxgzEo+ggV/cTf/0y9kSNInQlYNGiShzebIMtEepKCEQWTy
         5VmuH3VAtPTZl9jtJilguHUQSh4O0MZ/29MDQ/soA5OtOjk7DfCF3AQkD4jXGE5Go0ZW
         gkVw==
X-Gm-Message-State: ACgBeo0SeNmNvviGwl0rTiW6thA5ushN5iCjSVRsisiyZoJl45/+xZIm
        F5Fvg5NylSswbkTk6uDF/Zlsz0H+qz9dDlCLd+4wXg==
X-Google-Smtp-Source: AA6agR6erbFHcUf1QHp9W7LL9pyB5PF+z5gnIylIsjfXeM6tsEJW7hQnCKIJuWmgjPzXmhV5YCZERapiExjJ7GqSkuk=
X-Received: by 2002:a25:9a47:0:b0:680:955c:1487 with SMTP id
 r7-20020a259a47000000b00680955c1487mr16850498ybo.359.1660674304507; Tue, 16
 Aug 2022 11:25:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220811234941.887747-1-void@manifault.com> <20220811234941.887747-3-void@manifault.com>
 <CA+khW7jW6mgu2+DZyJMSX1beRYk917S=824NLFG7M5D1+2F57w@mail.gmail.com> <YvuZg7F/IVjozlu8@maniforge.dhcp.thefacebook.com>
In-Reply-To: <YvuZg7F/IVjozlu8@maniforge.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 16 Aug 2022 11:24:53 -0700
Message-ID: <CA+khW7iKX9Xr6fkSwsbWPoXr_wY5NhupKaWhr0MwsMfB2u3Fgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] bpf: Add bpf_user_ringbuf_drain() helper
To:     David Vernet <void@manifault.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, joannelkoong@gmail.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com, kernel-team@fb.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 6:20 AM David Vernet <void@manifault.com> wrote:
>
> On Mon, Aug 15, 2022 at 02:23:04PM -0700, Hao Luo wrote:
>
> Hi Hao,
>
> Thanks for the review.
>
> > On Thu, Aug 11, 2022 at 4:50 PM David Vernet <void@manifault.com> wrote:
> > >
> > > Now that we have a BPF_MAP_TYPE_USER_RINGBUF map type, we need to add a
> > > helper function that allows BPF programs to drain samples from the ring
> > > buffer, and invoke a callback for each. This patch adds a new
> > > bpf_user_ringbuf_drain() helper that provides this abstraction.
> > >
> > > In order to support this, we needed to also add a new PTR_TO_DYNPTR
> > > register type to reflect a dynptr that was allocated by a helper function
> > > and passed to a BPF program. The verifier currently only supports
> > > PTR_TO_DYNPTR registers that are also DYNPTR_TYPE_LOCAL and MEM_ALLOC.
> > >
> > > Signed-off-by: David Vernet <void@manifault.com>
> > > ---
> > [...]
> > > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > > index c0f3bca4bb09..73fa6ed12052 100644
> > > --- a/kernel/bpf/ringbuf.c
> > > +++ b/kernel/bpf/ringbuf.c
> > [...]
> > > +static int __bpf_user_ringbuf_poll(struct bpf_ringbuf *rb, void **sample,
> > > +                                  u32 *size)
> > > +{
> > > +       unsigned long cons_pos, prod_pos;
> > > +       u32 sample_len, total_len;
> > > +       u32 *hdr;
> > > +       int err;
> > > +       int busy = 0;
> > > +
> > > +       /* If another consumer is already consuming a sample, wait for them to
> > > +        * finish.
> > > +        */
> > > +       if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
> > > +               return -EBUSY;
> > > +
> > > +       /* Synchronizes with smp_store_release() in user-space. */
> > > +       prod_pos = smp_load_acquire(&rb->producer_pos);
> > > +       /* Synchronizes with smp_store_release() in
> > > +        * __bpf_user_ringbuf_sample_release().
> > > +        */
> > > +       cons_pos = smp_load_acquire(&rb->consumer_pos);
> > > +       if (cons_pos >= prod_pos) {
> > > +               atomic_set(&rb->busy, 0);
> > > +               return -ENODATA;
> > > +       }
> > > +
> > > +       hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
> > > +       sample_len = *hdr;
> > > +
> >
> > rb->data and rb->mask better be protected by READ_ONCE.
>
> Could you please clarify about the behavior you're protecting against here?
> We're just calculating an offset from rb->data, and both rb->data and
> rb->mask are set only once when the ringbuffer is first created in
> bpf_ringbuf_area_alloc(). I'm not following what we'd be protecting against
> by making these volatile, though I freely admit that I may be missing some
> weird possible behavior in the compiler.
>

Sorry, I missed the fact that rb->data and rb->mask are set only once.
I thought rb->data also moved somewhere.

My mental model is: normally for accessing shared data, if there is no
clear critical section protected by locks or mutex etc, I would wrap
them in READ_ONCE and WRITE_ONCE. But here, if it's read-only, it
should be ok IMHO.

> For what it's worth, in a follow-on version of the patch, I've updated this
> read of the sample len to be an smp_load_acquire() to accommodate Andrii's
> suggestion [0] that we should support using the busy bit and discard bit in
> the header from the get-go, as we do with BPF_MAP_TYPE_RINGBUF ringbuffers.
>
> [0]: https://lore.kernel.org/all/CAEf4BzYVLgd=rHaxzZjyv0WJBzBpMqGSStgVhXG9XOHpB7qDRQ@mail.gmail.com/
>
> > > +       /* Check that the sample can fit into a dynptr. */
> > > +       err = bpf_dynptr_check_size(sample_len);
> > > +       if (err) {
> > > +               atomic_set(&rb->busy, 0);
> > > +               return err;
> > > +       }
> > > +
> > > +       /* Check that the sample fits within the region advertised by the
> > > +        * consumer position.
> > > +        */
> > > +       total_len = sample_len + BPF_RINGBUF_HDR_SZ;
> > > +       if (total_len > prod_pos - cons_pos) {
> > > +               atomic_set(&rb->busy, 0);
> > > +               return -E2BIG;
> > > +       }
> > > +
> > > +       /* Check that the sample fits within the data region of the ring buffer.
> > > +        */
> > > +       if (total_len > rb->mask + 1) {
> > > +               atomic_set(&rb->busy, 0);
> > > +               return -E2BIG;
> > > +       }
> > > +
> > > +       /* consumer_pos is updated when the sample is released.
> > > +        */
> > > +
> > > +       *sample = (void *)((uintptr_t)rb->data +
> > > +                          (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
> > > +       *size = sample_len;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void
> > > +__bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size,
> > > +                                 u64 flags)
> > > +{
> > > +
> > > +
> > > +       /* To release the ringbuffer, just increment the producer position to
> > > +        * signal that a new sample can be consumed. The busy bit is cleared by
> > > +        * userspace when posting a new sample to the ringbuffer.
> > > +        */
> > > +       smp_store_release(&rb->consumer_pos, rb->consumer_pos + size +
> > > +                         BPF_RINGBUF_HDR_SZ);
> > > +
> > > +       if (flags & BPF_RB_FORCE_WAKEUP || !(flags & BPF_RB_NO_WAKEUP))
> > > +               irq_work_queue(&rb->work);
> > > +
> > > +       atomic_set(&rb->busy, 0);
> > > +}
> >
> > atomic_set() doesn't imply barrier, so it could be observed before
> > smp_store_release(). So the paired smp_load_acquire could observe
> > rb->busy == 0 while seeing the old consumer_pos. At least, you need
> > smp_mb__before_atomic() as a barrier before atomic_set. Or smp_wmb()
> > to ensure all _writes_ complete when see rb->busy == 0.
>
> Thanks for catching this. I should have been more careful to not assume the
> semantics of atomic_set(), and I see now that you're of course correct that
> it's just a WRITE_ONCE() and has no implications at all w.r.t. memory or
> compiler barriers. I'll fix this in the follow-on version, and will give
> another closer read over memory-barriers.txt and atomic_t.txt.
>

No problem. These things are tricky.

> > Similarly rb->work could be observed before smp_store_release.
>
> Yes, in the follow-on version I'll move the atomic_set() to before the
> irq_work_queue() invocation (per Andrii's comment in [1], though that
> discussion is still ongoing), and will add the missing
> smp_mb__before_atomic(). Thanks again for catching this.
>
> [1]: https://lore.kernel.org/all/CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com/
>
> > Is it possible for __bpf_user_ringbuf_sample_release to be called
> > concurrently? If yes, there are races. Because the load of
> > rb->consumer_pos is not protected by smp_load_acquire, they are not
> > synchronized with this smp_store_release. Concurrently calling
> > __bpf_user_ringbuf_sample_release may cause both threads getting stale
> > consumer_pos values.
>
> If we add smp_mb__before_atomic() per your proposed fix above, I don't
> believe this is an issue. __bpf_user_ringbuf_sample_release() should only
> be invoked when a caller has an unreleased sample, and that can only happen
> in a serial context due to the protection afforded by the atomic busy bit.
>

Right. I gave it more thought after publishing the comment yesterday.
There are two parts of synchronization: sync between multi producers
and sync between producer and consumer. It looks like multi producers
are serialized by the atomic busy bit. We need to fix the barrier. The
sync between producer and consumer is weaker, using the lockless
primitives like store_release/load_acquire. It should be fine.


> A single caller will not see a stale value, as they must first invoke
> __bpf_user_ringbuf_peek(), and then invoke
> __bpf_user_ringbuf_sample_release() with the sample they received. The
> consumer pos they read in __bpf_user_ringbuf_sample_release() was already
> smp_load_acquire()'d in __bpf_user_ringbuf_peek(), so they shouldn't see a
> stale value there. We could certainly add another smp_load_acquire() here
> for safety, but it would be redundant.
>
> Thanks,
> David
