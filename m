Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1519B595D23
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 15:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiHPNUj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 09:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiHPNU2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 09:20:28 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1DC3342A;
        Tue, 16 Aug 2022 06:20:25 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id a4so8037381qto.10;
        Tue, 16 Aug 2022 06:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=9PgsNxW7umWAoSy6vVUhb0/b4CvO5xxPxUf0Vm3eJZs=;
        b=13/TSJUh8/2zlHUAWYVKNSwZtKH+OHVuSrBDSz6ilGLi1ONIYoA3ZH2Wbz36vGBoUC
         delHZ27Ygb/1v0j409qrYXPEeQY+52+hR5CP/eoOqgMaOIMDIJPFSFyU38sk1caZaTJS
         ZmelAUoEXYpt04YJQ5QWV8dYBHb5UMHvWXhTtKrop8hNUFgHM+hny906/YD0wcIlXGLm
         TKx9ebQCT6BhXFRsr/5VPO7tGgjXPVWgNiT+x8+ZAlkOEEEwY6Q3vB1QwfmVyeOd16zc
         S8CIHWZ18SE2se/C/XnoSYZlveCf2tjy7icqKGSTtH+QFenGcwmB833KwoWuufxFMvdV
         pjKg==
X-Gm-Message-State: ACgBeo0wfyDJi7DNRxfmZrwcTVOduqqOx8YZQv79EiIg6jzzXjq/+1iC
        pFD11jMAhRSd1dIvzxiNCsQ=
X-Google-Smtp-Source: AA6agR4hMKMU1se5WTcUCoIl6XRyYlwfGSNc4NQU7ZgC2TkV1zUgKg+bIXrpWVKeFV5FjeYIEz7dpg==
X-Received: by 2002:a05:622a:164e:b0:344:5cbe:c0f0 with SMTP id y14-20020a05622a164e00b003445cbec0f0mr8625423qtj.631.1660656023711;
        Tue, 16 Aug 2022 06:20:23 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::a5ed])
        by smtp.gmail.com with ESMTPSA id bj25-20020a05620a191900b006b93ef659c3sm5181760qkb.39.2022.08.16.06.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 06:20:23 -0700 (PDT)
Date:   Tue, 16 Aug 2022 08:20:03 -0500
From:   David Vernet <void@manifault.com>
To:     Hao Luo <haoluo@google.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, joannelkoong@gmail.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, martin.lau@linux.dev, sdf@google.com,
        song@kernel.org, yhs@fb.com, kernel-team@fb.com, tj@kernel.org
Subject: Re: [PATCH v2 2/4] bpf: Add bpf_user_ringbuf_drain() helper
Message-ID: <YvuZg7F/IVjozlu8@maniforge.dhcp.thefacebook.com>
References: <20220811234941.887747-1-void@manifault.com>
 <20220811234941.887747-3-void@manifault.com>
 <CA+khW7jW6mgu2+DZyJMSX1beRYk917S=824NLFG7M5D1+2F57w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7jW6mgu2+DZyJMSX1beRYk917S=824NLFG7M5D1+2F57w@mail.gmail.com>
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

On Mon, Aug 15, 2022 at 02:23:04PM -0700, Hao Luo wrote:

Hi Hao,

Thanks for the review.

> On Thu, Aug 11, 2022 at 4:50 PM David Vernet <void@manifault.com> wrote:
> >
> > Now that we have a BPF_MAP_TYPE_USER_RINGBUF map type, we need to add a
> > helper function that allows BPF programs to drain samples from the ring
> > buffer, and invoke a callback for each. This patch adds a new
> > bpf_user_ringbuf_drain() helper that provides this abstraction.
> >
> > In order to support this, we needed to also add a new PTR_TO_DYNPTR
> > register type to reflect a dynptr that was allocated by a helper function
> > and passed to a BPF program. The verifier currently only supports
> > PTR_TO_DYNPTR registers that are also DYNPTR_TYPE_LOCAL and MEM_ALLOC.
> >
> > Signed-off-by: David Vernet <void@manifault.com>
> > ---
> [...]
> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index c0f3bca4bb09..73fa6ed12052 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> [...]
> > +static int __bpf_user_ringbuf_poll(struct bpf_ringbuf *rb, void **sample,
> > +                                  u32 *size)
> > +{
> > +       unsigned long cons_pos, prod_pos;
> > +       u32 sample_len, total_len;
> > +       u32 *hdr;
> > +       int err;
> > +       int busy = 0;
> > +
> > +       /* If another consumer is already consuming a sample, wait for them to
> > +        * finish.
> > +        */
> > +       if (!atomic_try_cmpxchg(&rb->busy, &busy, 1))
> > +               return -EBUSY;
> > +
> > +       /* Synchronizes with smp_store_release() in user-space. */
> > +       prod_pos = smp_load_acquire(&rb->producer_pos);
> > +       /* Synchronizes with smp_store_release() in
> > +        * __bpf_user_ringbuf_sample_release().
> > +        */
> > +       cons_pos = smp_load_acquire(&rb->consumer_pos);
> > +       if (cons_pos >= prod_pos) {
> > +               atomic_set(&rb->busy, 0);
> > +               return -ENODATA;
> > +       }
> > +
> > +       hdr = (u32 *)((uintptr_t)rb->data + (uintptr_t)(cons_pos & rb->mask));
> > +       sample_len = *hdr;
> > +
>
> rb->data and rb->mask better be protected by READ_ONCE.

Could you please clarify about the behavior you're protecting against here?
We're just calculating an offset from rb->data, and both rb->data and
rb->mask are set only once when the ringbuffer is first created in
bpf_ringbuf_area_alloc(). I'm not following what we'd be protecting against
by making these volatile, though I freely admit that I may be missing some
weird possible behavior in the compiler.

For what it's worth, in a follow-on version of the patch, I've updated this
read of the sample len to be an smp_load_acquire() to accommodate Andrii's
suggestion [0] that we should support using the busy bit and discard bit in
the header from the get-go, as we do with BPF_MAP_TYPE_RINGBUF ringbuffers.

[0]: https://lore.kernel.org/all/CAEf4BzYVLgd=rHaxzZjyv0WJBzBpMqGSStgVhXG9XOHpB7qDRQ@mail.gmail.com/

> > +       /* Check that the sample can fit into a dynptr. */
> > +       err = bpf_dynptr_check_size(sample_len);
> > +       if (err) {
> > +               atomic_set(&rb->busy, 0);
> > +               return err;
> > +       }
> > +
> > +       /* Check that the sample fits within the region advertised by the
> > +        * consumer position.
> > +        */
> > +       total_len = sample_len + BPF_RINGBUF_HDR_SZ;
> > +       if (total_len > prod_pos - cons_pos) {
> > +               atomic_set(&rb->busy, 0);
> > +               return -E2BIG;
> > +       }
> > +
> > +       /* Check that the sample fits within the data region of the ring buffer.
> > +        */
> > +       if (total_len > rb->mask + 1) {
> > +               atomic_set(&rb->busy, 0);
> > +               return -E2BIG;
> > +       }
> > +
> > +       /* consumer_pos is updated when the sample is released.
> > +        */
> > +
> > +       *sample = (void *)((uintptr_t)rb->data +
> > +                          (uintptr_t)((cons_pos + BPF_RINGBUF_HDR_SZ) & rb->mask));
> > +       *size = sample_len;
> > +
> > +       return 0;
> > +}
> > +
> > +static void
> > +__bpf_user_ringbuf_sample_release(struct bpf_ringbuf *rb, size_t size,
> > +                                 u64 flags)
> > +{
> > +
> > +
> > +       /* To release the ringbuffer, just increment the producer position to
> > +        * signal that a new sample can be consumed. The busy bit is cleared by
> > +        * userspace when posting a new sample to the ringbuffer.
> > +        */
> > +       smp_store_release(&rb->consumer_pos, rb->consumer_pos + size +
> > +                         BPF_RINGBUF_HDR_SZ);
> > +
> > +       if (flags & BPF_RB_FORCE_WAKEUP || !(flags & BPF_RB_NO_WAKEUP))
> > +               irq_work_queue(&rb->work);
> > +
> > +       atomic_set(&rb->busy, 0);
> > +}
> 
> atomic_set() doesn't imply barrier, so it could be observed before
> smp_store_release(). So the paired smp_load_acquire could observe
> rb->busy == 0 while seeing the old consumer_pos. At least, you need
> smp_mb__before_atomic() as a barrier before atomic_set. Or smp_wmb()
> to ensure all _writes_ complete when see rb->busy == 0.

Thanks for catching this. I should have been more careful to not assume the
semantics of atomic_set(), and I see now that you're of course correct that
it's just a WRITE_ONCE() and has no implications at all w.r.t. memory or
compiler barriers. I'll fix this in the follow-on version, and will give
another closer read over memory-barriers.txt and atomic_t.txt.

> Similarly rb->work could be observed before smp_store_release.

Yes, in the follow-on version I'll move the atomic_set() to before the
irq_work_queue() invocation (per Andrii's comment in [1], though that
discussion is still ongoing), and will add the missing
smp_mb__before_atomic(). Thanks again for catching this.

[1]: https://lore.kernel.org/all/CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com/

> Is it possible for __bpf_user_ringbuf_sample_release to be called
> concurrently? If yes, there are races. Because the load of
> rb->consumer_pos is not protected by smp_load_acquire, they are not
> synchronized with this smp_store_release. Concurrently calling
> __bpf_user_ringbuf_sample_release may cause both threads getting stale
> consumer_pos values.

If we add smp_mb__before_atomic() per your proposed fix above, I don't
believe this is an issue. __bpf_user_ringbuf_sample_release() should only
be invoked when a caller has an unreleased sample, and that can only happen
in a serial context due to the protection afforded by the atomic busy bit.

A single caller will not see a stale value, as they must first invoke
__bpf_user_ringbuf_peek(), and then invoke
__bpf_user_ringbuf_sample_release() with the sample they received. The
consumer pos they read in __bpf_user_ringbuf_sample_release() was already
smp_load_acquire()'d in __bpf_user_ringbuf_peek(), so they shouldn't see a
stale value there. We could certainly add another smp_load_acquire() here
for safety, but it would be redundant.

Thanks,
David
