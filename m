Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8E25965B8
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiHPXAK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 19:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbiHPXAJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 19:00:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89C7760E8;
        Tue, 16 Aug 2022 16:00:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id uj29so21665748ejc.0;
        Tue, 16 Aug 2022 16:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=R7b4SaVlmFF7hVBPCcH4cfYMCqMKOVFQ3oQ+fun/+SU=;
        b=aI55T4UlX43IvoCwdH8y27UDfjIj63lcOjSQ8IR9i6jB37Ind5V5326+eVnnoMWgtj
         LdF3NmjEJ0HIPeOgLBvpPexsF0CrxWUzC4runpOH8WDlN7IwXOy+VbxugBjs91ZHg3CA
         9XE7nlTQRVCF/uAR+4+8F0+kkeoNc5c3qDVOfwxSAEuGTFZrA9j4dLhzYkk/iBbSLBbQ
         GTGIjRoGe1EncyGHPpGahc+TY2taR6XqOJ7fccngCd8Mky25Leyde4uct62sanmC96Ts
         IwwzzvIM3gwervbkrCvR6X0yqvXFHU4k8Kd6cc9wK7D7xwKftS9W08+zFtunboE6ZnCC
         fYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=R7b4SaVlmFF7hVBPCcH4cfYMCqMKOVFQ3oQ+fun/+SU=;
        b=VolKzUPADL0IFdCj7AYgx3D11Uaa9OfEOL5JcT4dyFIUEAYXX5+QRgRCgMebXvzbfE
         c2tPowD79A6SBycwXrlvpsfHDJtXCp56ggigTP9yXibbbT3ZYvS3NBKTuYNeFUU/yeBb
         tHRMhenj55lEAi66RpLRq7cDkT6423CnkfhBoe3/FdW/DsKI6aK5keRXEIo5QGbNi0nj
         NmLG42IMQFE5BepWVfFSXYUkB+459mg7a/DMbopmPF6ISQgYBw+BrfpkazjaKNfZsMEN
         PO9ZjHD2WkOgp9JGdsOHRdfPmJK3KDcakittnXSAk203xkhL95jazUCP1Xbqh9mizOI0
         1+YA==
X-Gm-Message-State: ACgBeo2/dxWJBMH8zivnuGht/syhs3XMdTwjdeYM1lAu06CcYDZxotTy
        eSs0HCWWHaefyZOADp2HvkPJuHmJ9L+nWEMPUJU=
X-Google-Smtp-Source: AA6agR6cu/EbYKgvQhHRD3V603ECbfqGc2HJsnykpNRvFw119rTio/7BH7I0nt3gZvFWGTUL4L9iWK8sGkxrbatbp28=
X-Received: by 2002:a17:907:3d90:b0:730:a937:fb04 with SMTP id
 he16-20020a1709073d9000b00730a937fb04mr15231375ejc.176.1660690806257; Tue, 16
 Aug 2022 16:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220808155341.2479054-1-void@manifault.com> <20220808155341.2479054-3-void@manifault.com>
 <CAEf4BzZ-m-AUX+1+CGr7nMxMDnT=fjkn8DP9nP21Uts1y7fMyg@mail.gmail.com>
 <YvWi4f1hz/v72Fpc@maniforge.dhcp.thefacebook.com> <CAEf4BzZ6aaFqF0DvhEeKaMfSZiFdMjr3=YzX6oEmz8rCRuSFaA@mail.gmail.com>
 <YvwWvVDN11Wb6j2l@maniforge.DHCP.thefacebook.com>
In-Reply-To: <YvwWvVDN11Wb6j2l@maniforge.DHCP.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 16 Aug 2022 15:59:54 -0700
Message-ID: <CAEf4BzahEq=Ke7yzc8eMvp17avZ8Br-XQKRMe-WdkgoEcy9oVA@mail.gmail.com>
Subject: Re: [PATCH 3/5] bpf: Add bpf_user_ringbuf_drain() helper
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

On Tue, Aug 16, 2022 at 3:14 PM David Vernet <void@manifault.com> wrote:
>
> On Tue, Aug 16, 2022 at 11:57:10AM -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > index a341f877b230..ca125648d7fd 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -5332,6 +5332,13 @@ union bpf_attr {
> > > > >   *             **-EACCES** if the SYN cookie is not valid.
> > > > >   *
> > > > >   *             **-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
> > > > > + *
> > > > > + * long bpf_user_ringbuf_drain(struct bpf_map *map, void *callback_fn, void *ctx, u64 flags)
> > > > > + *     Description
> > > > > + *             Drain samples from the specified user ringbuffer, and invoke the
> > > > > + *             provided callback for each such sample.
> > > >
> > > > please specify what's the expected signature of callback_fn
> > >
> > > Will do, unfortunatley we're inconsistent in doing this in other helper
> > > functions, so it wasn't clear from context.
> >
> > That means we missed it for other helpers. The idea was to always
> > specify expected signature in UAPI comment, ideally we fix all the
> > missing cases.
>
> Agreed -- I'll take care of that as a follow-on patch-set.
>
> > > Agreed, I'll add a check and selftest for this.
> >
> > Yep, consider also adding few tests where user-space intentionally
> > breaks the contract to make sure that kernel stays intact (if you
> > already did that, apologies, I haven't looked at selftests much).
>
> The only negative tests I currently have from user-space are verifying
> that mapping permissions are correctly enforced. Happy to add some more
> that tests boundaries for other parts of the API -- I agree that's both
> useful and prudent.
>
> > > > > +       /* Synchronizes with smp_store_release() in
> > > > > +        * __bpf_user_ringbuf_sample_release().
> > > > > +        */
> > > > > +       cons_pos = smp_load_acquire(&rb->consumer_pos);
> > > > > +       if (cons_pos >= prod_pos) {
> > > > > +               atomic_set(&rb->busy, 0);
> > > > > +               return -ENODATA;
> > > > > +       }
> > > > > +
> > > > > +       hdr = (u32 *)((uintptr_t)rb->data + (cons_pos & rb->mask));
> > > > > +       sample_len = *hdr;
> > > >
> > > > do we need smp_load_acquire() here? libbpf's ring_buffer
> > > > implementation uses load_acquire here
> > >
> > > I thought about this when I was first adding the logic, but I can't
> > > convince myself that it's necessary and wasn't able to figure out why we
> > > did a load acquire on the len in libbpf. The kernel doesn't do a store
> > > release on the header, so I'm not sure what the load acquire in libbpf
> > > actually accomplishes. I could certainly be missing something, but I
> > > _think_ the important thing is that we have load-acquire / store-release
> > > pairs for the consumer and producer positions.
> >
> > kernel does xchg on len on the kernel side, which is stronger than
> > smp_store_release (I think it was Paul's suggestion instead of doing
> > explicit memory barrier, but my memories are hazy for exact reasons).
>
> Hmmm, yeah, for the kernel-producer ringbuffer, I believe the explicit
> memory barrier is unnecessary because:
>
> o The smp_store_release() on producer_pos provides ordering w.r.t.
>   producer_pos, and the write to hdr->len which includes the busy-bit
>   should therefore be visibile in libbpf, which does an
>   smp_load_acquire().
> o The xchg() when the sample is committed provides full barriers before
>   and after, so the consumer is guaranteed to read the written contents of
>   the sample IFF it also sees the BPF_RINGBUF_BUSY_BIT as unset.
>
> I can't see any scenario in which a barrier would add synchronization not
> already provided, though this stuff is tricky so I may have missed
> something.
>
> > Right now this might not be necessary, but if we add support for busy
> > bit in a sample header, it will be closer to what BPF ringbuf is doing
> > right now, with producer position being a reservation pointer, but
> > sample itself won't be "readable" until sample header is updated and
> > its busy bit is unset.
>
> Regarding this patch, after thinking about this more I _think_ I do need
> an xchg() (or equivalent operation with full barrier semantics) in
> userspace when updating the producer_pos when committing the sample.
> Which, after applying your suggestion (which I agree with) of supporting
> BPF_RINGBUF_BUSY_BIT and BPF_RINGBUF_DISCARD_BIT from the get-go, would
> similarly be an xchg() when setting the header, paired with an
> smp_load_acquire() when reading the header in the kernel.


right, I think __atomic_store_n() can be used in libbpf for this with
seq_cst ordering


>
> > > Yeah, I thought about this. I don't think there's any problem with clearing
> > > busy before we schedule the irq_work_queue(). I elected to do this to err
> > > on the side of simpler logic until we observed contention, but yeah, let me
> > > just do the more performant thing here.
> >
> > busy is like a global lock, so freeing it ASAP is good, so yeah,
> > unless there are some bad implications, let's do it early
>
> Ack.
>
> [...]
>
> > > > > +                       ret = callback((u64)&dynptr,
> > > > > +                                       (u64)(uintptr_t)callback_ctx, 0, 0, 0);
> > > > > +
> > > > > +                       __bpf_user_ringbuf_sample_release(rb, size, flags);
> > > > > +                       num_samples++;
> > > > > +               }
> > > > > +       } while (err == 0 && num_samples < 4096 && ret == 0);
> > > > > +
> > > >
> > > > 4096 is pretty arbitrary. Definitely worth noting it somewhere and it
> > > > seems somewhat low, tbh...
> > > >
> > > > ideally we'd cond_resched() from time to time, but that would require
> > > > BPF program to be sleepable, so we can't do that :(
> > >
> > > Yeah, I knew this would come up in discussion. I would love to do
> > > cond_resched() here, but as you said, I don't think it's an option :-/ And
> > > given the fact that we're calling back into the BPF program, we have to be
> > > cognizant of things taking a while and clogging up the CPU. What do you
> > > think is a more reasonable number than 4096?
> >
> > I don't know, tbh, but 4096 seems pretty low. For bpf_loop() we allow
> > up to 2mln iterations. I'd bump it up to 64-128K range, probably. But
> > also please move it into some internal #define'd constant, not some
> > integer literal buried in a code
>
> Sounds good to me. Maybe at some point we can make this configurable, or
> something. If bpf_loop() allows a hard-coded number of iterations, I think
> it's more forgivable to do the same here. I'll bump it up to 128k and move
> it into a constant so it's not a magic number.
>
> > >
> > > [...]
> > >
> > > > >         case ARG_PTR_TO_DYNPTR:
> > > > > +               /* We only need to check for initialized / uninitialized helper
> > > > > +                * dynptr args if the dynptr is not MEM_ALLOC, as the assumption
> > > > > +                * is that if it is, that a helper function initialized the
> > > > > +                * dynptr on behalf of the BPF program.
> > > > > +                */
> > > > > +               if (reg->type & MEM_ALLOC)
> > > >
> > > > Isn't PTR_TO_DYNPTR enough indication? Do we need MEM_ALLOC modifier?
> > > > Normal dynptr created and used inside BPF program on the stack are
> > > > actually PTR_TO_STACK, so that should be enough distinction? Or am I
> > > > missing something?
> > >
> > > I think this would also work in the current state of the codebase, but IIUC
> > > it relies on PTR_TO_STACK being the only way that a BPF program could ever
> > > allocate a dynptr. I was trying to guard against the case of a helper being
> > > added in the future that e.g. returned a dynamically allocated dynptr that
> > > the caller would eventually need to release in another helper call.
> > > MEM_ALLOC seems like the correct modifier to more generally denote that the
> > > dynptr was externally allocated.  If you think this is overkill I'm totally
> > > fine with removing MEM_ALLOC. We can always add it down the road if we add
> > > a new helper that requires it.
> > >
> >
> > Hm.. I don't see a huge need for more flags for this, so I'd keep it
> > simple for now and if in the future we do have such a use case, we'll
> > address it at that time?
>
> Sounds good to me.
>
> Thanks,
> David
