Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4855EEA95
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 02:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiI2Acj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 20:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiI2Ach (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 20:32:37 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33F41162DD
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:32:35 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id d1so49897qvs.0
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 17:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=z+mGljvEk4YNd4hkoAaqnLPUbyCn+3rnvYfc5nH3bZ4=;
        b=XagqI07Yo2gxS7yl+zHTW2RtkFEZ8EqyGhCJ5YFnbdA+3iIV2ab1fUnXroxsFa719O
         vq+8qR0Qe1bwib2hFwwK8x7yU0qhnGYcj8otY/B89f4vBvcrrNRoKfQ5BXg8I3nT6AkF
         xwRt1pVA3denjlvGC0K3UHehqTcxNEtn1CNWohHnp+ErM0/MhdJUtGFTFbkgUOZykRvU
         fJKD0Y5+KI810i4v1c70JnIo6LetHMGSFiOJwZcbeKWl4gC2WsdnBGzcE5awrZeLQmGq
         WqkRZNFrHJi89bZqnnbmYWYOkpOkRp7+kanhu/Lr9eLntwdcUOqoN/F4fF1yBGYpNq5+
         5KlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=z+mGljvEk4YNd4hkoAaqnLPUbyCn+3rnvYfc5nH3bZ4=;
        b=F17WgCLjjEid/M3IDNEpwyGibgGddL5VZzfl4aUYrqU1Jlklx8ngXmJFNtC8jaWoZJ
         mVXMdwVmtHtYB22aY1OqVUEswJpBxHZ3D5rTpc7R4rLiOT/HODGwdBol6hIVim+HsYTH
         9iSUV0gyWisIzIh9GxBYRXOkPUUeXE7PRofoov+0Bi6+24eCZIXj8c1JFI85WdUnDHxQ
         l97gveRe8clofXwOWmgAFdsKJSabgAam8HP7zCRqAIvJWaxM2ZV1H33D2YjOuBRhno94
         v6AHHcCuUTkFhCW9TQunyCiDlzaFVWCQAm3jmcaGNlRawW98TlNZdRhX7UYW3NjRBzoa
         1LXw==
X-Gm-Message-State: ACrzQf3g923cgI9ahdoSiT6j012h+YmFA/R+JtLz6Sc7bV7vjV5Vd8QO
        fRRm3R9R4OX9RTie9edsATgfNX91V7qx0J7ZqBI=
X-Google-Smtp-Source: AMsMyM5DuPmHKj4i8qrxcCl/KrVFVL/DvJfTEoAAkrlcKfUg2DgCzuEA9aRXtE9rs0cP6fwjuJPIASPbne2nAZpjDsE=
X-Received: by 2002:a05:6214:c2d:b0:4ac:9892:2a73 with SMTP id
 a13-20020a0562140c2d00b004ac98922a73mr632324qvd.30.1664411554935; Wed, 28 Sep
 2022 17:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-8-joannelkoong@gmail.com> <CAEf4Bza2B+LFPm0dtdtfj+_ai5rTzjybHbM2XH_9UnBUF02izg@mail.gmail.com>
In-Reply-To: <CAEf4Bza2B+LFPm0dtdtfj+_ai5rTzjybHbM2XH_9UnBUF02izg@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 29 Sep 2022 02:31:57 +0200
Message-ID: <CAP01T76bR6zFCCVM=8gQCCqHH12A3Hz2UQ6wg97KhPcO+BeenA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] bpf: Add bpf_dynptr_iterator
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, andrii@kernel.org,
        ast@kernel.org, Kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 29 Sept 2022 at 01:04, Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Sep 7, 2022 at 5:07 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > Add a new helper function, bpf_dynptr_iterator:
> >
> >   long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
> >                            void *callback_ctx, u64 flags)
> >
> > where callback_fn is defined as:
> >
> >   long (*callback_fn)(struct bpf_dynptr *ptr, void *ctx)
> >
> > and callback_fn returns the number of bytes to advance the
> > dynptr by (or an error code in the case of error). The iteration
> > will stop if the callback_fn returns 0 or an error or tries to
> > advance by more bytes than available.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       | 20 ++++++++++++++
> >  kernel/bpf/helpers.c           | 48 +++++++++++++++++++++++++++++++---
> >  kernel/bpf/verifier.c          | 27 +++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++
> >  4 files changed, 111 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 16973fa4d073..ff78a94c262a 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5531,6 +5531,25 @@ union bpf_attr {
> >   *             losing access to the original view of the dynptr.
> >   *     Return
> >   *             0 on success, -EINVAL if the dynptr to clone is invalid.
> > + *
> > + * long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn, void *callback_ctx, u64 flags)
> > + *     Description
> > + *             Iterate through the dynptr data, calling **callback_fn** on each
> > + *             iteration with **callback_ctx** as the context parameter.
> > + *             The **callback_fn** should be a static function and
> > + *             the **callback_ctx** should be a pointer to the stack.
> > + *             Currently **flags** is unused and must be 0.
> > + *
> > + *             long (\*callback_fn)(struct bpf_dynptr \*ptr, void \*ctx);
> > + *
> > + *             where **callback_fn** returns the number of bytes to advance
> > + *             the dynptr by or an error. The iteration will stop if **callback_fn**
> > + *             returns 0 or an error or tries to advance by more bytes than the
> > + *             size of the dynptr.
> > + *     Return
> > + *             0 on success, -EINVAL if the dynptr is invalid or **flags** is not 0,
> > + *             -ERANGE if attempting to iterate more bytes than available, or other
> > + *             negative error if **callback_fn** returns an error.
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)          \
> >         FN(unspec),                     \
> > @@ -5752,6 +5771,7 @@ union bpf_attr {
> >         FN(dynptr_get_size),            \
> >         FN(dynptr_get_offset),          \
> >         FN(dynptr_clone),               \
> > +       FN(dynptr_iterator),            \
> >         /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 667f1e213a61..519b3da06d49 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1653,13 +1653,11 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
> >         .arg3_type      = ARG_CONST_ALLOC_SIZE_OR_ZERO,
> >  };
> >
> > -BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> > +/* *ptr* should always be a valid dynptr */
> > +static int __bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u32 len)
> >  {
> >         u32 size;
> >
> > -       if (!ptr->data)
> > -               return -EINVAL;
> > -
> >         size = __bpf_dynptr_get_size(ptr);
> >
> >         if (len > size)
> > @@ -1672,6 +1670,14 @@ BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> >         return 0;
> >  }
> >
> > +BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> > +{
> > +       if (!ptr->data)
> > +               return -EINVAL;
> > +
> > +       return __bpf_dynptr_advance(ptr, len);
> > +}
> > +
> >  static const struct bpf_func_proto bpf_dynptr_advance_proto = {
> >         .func           = bpf_dynptr_advance,
> >         .gpl_only       = false,
> > @@ -1783,6 +1789,38 @@ static const struct bpf_func_proto bpf_dynptr_clone_proto = {
> >         .arg2_type      = ARG_PTR_TO_DYNPTR | MEM_UNINIT,
> >  };
> >
> > +BPF_CALL_4(bpf_dynptr_iterator, struct bpf_dynptr_kern *, ptr, void *, callback_fn,
> > +          void *, callback_ctx, u64, flags)
> > +{
> > +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> > +       int nr_bytes, err;
> > +
> > +       if (!ptr->data || flags)
> > +               return -EINVAL;
> > +
> > +       while (ptr->size > 0) {
> > +               nr_bytes = callback((u64)(long)ptr, (u64)(long)callback_ctx, 0, 0, 0);
> > +               if (nr_bytes <= 0)
> > +                       return nr_bytes;
>
> callback is defined as returning long but here you are silently
> truncating it to int. Let's either stick to longs or to ints.
>
> > +
> > +               err = __bpf_dynptr_advance(ptr, nr_bytes);
>
> as Kumar pointed out, you can't modify ptr in place, you have to
> create a local copy and bpf_dynptr_clone() it (so that for MALLOC
> you'll bump refcnt). Then advance and pass it to callback. David has
> such local dynptr use case in bpf_user_ringbuf_drain() helper.
>

My solution was a bit overcomplicated because just creating a local
copy doesn't fix this completely, there's still the hole of writing
through arg#0 (which now does not reflect runtime state, as writes at
runtime go to clone while verifier thinks you touched stack slots),
and still allows constructing the infinite loop (because well, you can
overwrite dynptr through it). The 'side channel' of writing to dynptr
slots through callback_ctx is still there as well.

Maybe the infinite loop _can_ be avoided if you clone inside each
iteration, that part isn't very clear.

My reasoning was that when you iterate, the container is always
immutable (to prevent iterator invalidation) while mutability of
elements remains unaffected from that. Setting it in spilled_ptr
covers all bases (PTR_TO_STACK arg#0, access to it through
callback_ctx, etc.).

But I totally agree with you that we should be working on a local copy
inside the helper and leave the original dynptr untouched.
I think then the first arg should not be PTR_TO_STACK but some other
pointer type. Maybe it should be its own register type, and
spilled_ptr should reflect the same register, which allows the dynptr
state that we track to be copied into the callback arg#0 easily.

For the case of writes to the original dynptr that is already broken
right now, we can't track the state of the stack across iterations
correctly anyway so I think that has to be left as is until your N
callbacks rework happens.

wdyt?
