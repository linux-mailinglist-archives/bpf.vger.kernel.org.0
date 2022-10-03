Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DA15F35BB
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 20:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiJCSjp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Oct 2022 14:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJCSjm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 14:39:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1C525D
        for <bpf@vger.kernel.org>; Mon,  3 Oct 2022 11:39:37 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c93so6993693edf.11
        for <bpf@vger.kernel.org>; Mon, 03 Oct 2022 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f8ubVkcCxQmNxcPWDl3BIZMBpRe9qGYrEUL6OF1yihk=;
        b=kUveGdRy1XBbBms0aopvsObYBxDpPoE3ow22WRewXRVsyDd9w9Sc2HidQPJWVE94JY
         fRGTHLNWYSWuLja5yjt1/yqOJiMqIzdzPpRvjPEv31kyZoYko+PcJrtq/OUdmyBkvz4V
         7mZEMaVCY+jxyKs3Rswyf0zjNviIB02NVd+NKCFNSRINIQhHmfMnvYS5UmT5/xygb3gX
         ED69OMBmhSNu/B8j4lQ/ll84GE6yJZvNun5yPuKRs2S5MIUSOZfclbVZD84EwOmtCSpG
         gISQADmrrJlCvzDCi38456ZkBMDtxVHqcK/cpc5NeH+aU2k3B2GxOe1iS6q9cF0Jo9a9
         /TGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f8ubVkcCxQmNxcPWDl3BIZMBpRe9qGYrEUL6OF1yihk=;
        b=gwTI5nE/RjkW2M9KLKbDOGgMuhICb8ziV4mjhoylFO5N+NmBZZ7Ao6pGN9eTVq0bvL
         jWq/SuZ1mM+bSA8bumZ/j0Zd35eQ7nKmsuXpkaK57En1OaU0WbPJsC73nr4F/IyNUhv/
         pTW2N7SIhpNgnt/VvyP7b0AwuQ2+eFZBwg9NmZ8WRQk4DNwWeJirLl60ElfuFSQ2LYAc
         Nsox9QaydGoTyQoKOrjL7BtDEIDQqVqUmCt26n3uFF9biVnpwdieuHz8MzNZGEbLK4KB
         Q+ObSoYH6VD3VQIguWZprDUodfpU0v02s7GOaBiAgHsdrsVxrtV7Cym9czbBof4JOll5
         MQKQ==
X-Gm-Message-State: ACrzQf11bKhIdyU6r6bGx8I23KTaLzyV3ViJ4OyUmgUy07cYRn/Jyicp
        xcCLlX8ayPDxU4rgoDrUN/MU7tjTejopmJOC2ms=
X-Google-Smtp-Source: AMsMyM7ESTaf5Iciu8GRu0qkWBEjsze3F5KJnOUNeFNIwb3uFYNBXvq6Ub8i7puE9ne6bZ/Bp4VqgyXOesEdsEzKz7I=
X-Received: by 2002:a05:6402:518e:b0:452:49bc:179f with SMTP id
 q14-20020a056402518e00b0045249bc179fmr20181472edd.224.1664822375783; Mon, 03
 Oct 2022 11:39:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-8-joannelkoong@gmail.com> <CAEf4Bza2B+LFPm0dtdtfj+_ai5rTzjybHbM2XH_9UnBUF02izg@mail.gmail.com>
 <CAP01T76bR6zFCCVM=8gQCCqHH12A3Hz2UQ6wg97KhPcO+BeenA@mail.gmail.com>
 <CAEf4BzaDjBBpmnEoYrTRTr5bEJKFMyPJctqo1q8gHLbrmbPWbA@mail.gmail.com> <CAP01T74gDO6et-CJhX7adETj8JfGwJztu1i_G3JndkCS1KDNcw@mail.gmail.com>
In-Reply-To: <CAP01T74gDO6et-CJhX7adETj8JfGwJztu1i_G3JndkCS1KDNcw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 3 Oct 2022 11:39:22 -0700
Message-ID: <CAEf4Bzb4beTHgVo+G+jehSj8oCeAjRbRcm6MRe=Gr+cajRBwEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] bpf: Add bpf_dynptr_iterator
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
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

On Sun, Oct 2, 2022 at 9:46 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, 29 Sept 2022 at 02:43, Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Sep 28, 2022 at 5:32 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Thu, 29 Sept 2022 at 01:04, Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 7, 2022 at 5:07 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > >
> > > > > Add a new helper function, bpf_dynptr_iterator:
> > > > >
> > > > >   long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
> > > > >                            void *callback_ctx, u64 flags)
> > > > >
> > > > > where callback_fn is defined as:
> > > > >
> > > > >   long (*callback_fn)(struct bpf_dynptr *ptr, void *ctx)
> > > > >
> > > > > and callback_fn returns the number of bytes to advance the
> > > > > dynptr by (or an error code in the case of error). The iteration
> > > > > will stop if the callback_fn returns 0 or an error or tries to
> > > > > advance by more bytes than available.
> > > > >
> > > > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > > > ---
> > > > >  include/uapi/linux/bpf.h       | 20 ++++++++++++++
> > > > >  kernel/bpf/helpers.c           | 48 +++++++++++++++++++++++++++++++---
> > > > >  kernel/bpf/verifier.c          | 27 +++++++++++++++++++
> > > > >  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++
> > > > >  4 files changed, 111 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > > > index 16973fa4d073..ff78a94c262a 100644
> > > > > --- a/include/uapi/linux/bpf.h
> > > > > +++ b/include/uapi/linux/bpf.h
> > > > > @@ -5531,6 +5531,25 @@ union bpf_attr {
> > > > >   *             losing access to the original view of the dynptr.
> > > > >   *     Return
> > > > >   *             0 on success, -EINVAL if the dynptr to clone is invalid.
> > > > > + *
> > > > > + * long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn, void *callback_ctx, u64 flags)
> > > > > + *     Description
> > > > > + *             Iterate through the dynptr data, calling **callback_fn** on each
> > > > > + *             iteration with **callback_ctx** as the context parameter.
> > > > > + *             The **callback_fn** should be a static function and
> > > > > + *             the **callback_ctx** should be a pointer to the stack.
> > > > > + *             Currently **flags** is unused and must be 0.
> > > > > + *
> > > > > + *             long (\*callback_fn)(struct bpf_dynptr \*ptr, void \*ctx);
> > > > > + *
> > > > > + *             where **callback_fn** returns the number of bytes to advance
> > > > > + *             the dynptr by or an error. The iteration will stop if **callback_fn**
> > > > > + *             returns 0 or an error or tries to advance by more bytes than the
> > > > > + *             size of the dynptr.
> > > > > + *     Return
> > > > > + *             0 on success, -EINVAL if the dynptr is invalid or **flags** is not 0,
> > > > > + *             -ERANGE if attempting to iterate more bytes than available, or other
> > > > > + *             negative error if **callback_fn** returns an error.
> > > > >   */
> > > > >  #define __BPF_FUNC_MAPPER(FN)          \
> > > > >         FN(unspec),                     \
> > > > > @@ -5752,6 +5771,7 @@ union bpf_attr {
> > > > >         FN(dynptr_get_size),            \
> > > > >         FN(dynptr_get_offset),          \
> > > > >         FN(dynptr_clone),               \
> > > > > +       FN(dynptr_iterator),            \
> > > > >         /* */
> > > > >
> > > > >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > index 667f1e213a61..519b3da06d49 100644
> > > > > --- a/kernel/bpf/helpers.c
> > > > > +++ b/kernel/bpf/helpers.c
> > > > > @@ -1653,13 +1653,11 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
> > > > >         .arg3_type      = ARG_CONST_ALLOC_SIZE_OR_ZERO,
> > > > >  };
> > > > >
> > > > > -BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> > > > > +/* *ptr* should always be a valid dynptr */
> > > > > +static int __bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u32 len)
> > > > >  {
> > > > >         u32 size;
> > > > >
> > > > > -       if (!ptr->data)
> > > > > -               return -EINVAL;
> > > > > -
> > > > >         size = __bpf_dynptr_get_size(ptr);
> > > > >
> > > > >         if (len > size)
> > > > > @@ -1672,6 +1670,14 @@ BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> > > > > +{
> > > > > +       if (!ptr->data)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       return __bpf_dynptr_advance(ptr, len);
> > > > > +}
> > > > > +
> > > > >  static const struct bpf_func_proto bpf_dynptr_advance_proto = {
> > > > >         .func           = bpf_dynptr_advance,
> > > > >         .gpl_only       = false,
> > > > > @@ -1783,6 +1789,38 @@ static const struct bpf_func_proto bpf_dynptr_clone_proto = {
> > > > >         .arg2_type      = ARG_PTR_TO_DYNPTR | MEM_UNINIT,
> > > > >  };
> > > > >
> > > > > +BPF_CALL_4(bpf_dynptr_iterator, struct bpf_dynptr_kern *, ptr, void *, callback_fn,
> > > > > +          void *, callback_ctx, u64, flags)
> > > > > +{
> > > > > +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> > > > > +       int nr_bytes, err;
> > > > > +
> > > > > +       if (!ptr->data || flags)
> > > > > +               return -EINVAL;
> > > > > +
> > > > > +       while (ptr->size > 0) {
> > > > > +               nr_bytes = callback((u64)(long)ptr, (u64)(long)callback_ctx, 0, 0, 0);
> > > > > +               if (nr_bytes <= 0)
> > > > > +                       return nr_bytes;
> > > >
> > > > callback is defined as returning long but here you are silently
> > > > truncating it to int. Let's either stick to longs or to ints.
> > > >
> > > > > +
> > > > > +               err = __bpf_dynptr_advance(ptr, nr_bytes);
> > > >
> > > > as Kumar pointed out, you can't modify ptr in place, you have to
> > > > create a local copy and bpf_dynptr_clone() it (so that for MALLOC
> > > > you'll bump refcnt). Then advance and pass it to callback. David has
> > > > such local dynptr use case in bpf_user_ringbuf_drain() helper.
> > > >
> > >
> > > My solution was a bit overcomplicated because just creating a local
> > > copy doesn't fix this completely, there's still the hole of writing
> > > through arg#0 (which now does not reflect runtime state, as writes at
> > > runtime go to clone while verifier thinks you touched stack slots),
> > > and still allows constructing the infinite loop (because well, you can
> > > overwrite dynptr through it). The 'side channel' of writing to dynptr
> > > slots through callback_ctx is still there as well.
> > >
> > > Maybe the infinite loop _can_ be avoided if you clone inside each
> > > iteration, that part isn't very clear.
> > >
> > > My reasoning was that when you iterate, the container is always
> > > immutable (to prevent iterator invalidation) while mutability of
> > > elements remains unaffected from that. Setting it in spilled_ptr
> > > covers all bases (PTR_TO_STACK arg#0, access to it through
> > > callback_ctx, etc.).
> > >
> > > But I totally agree with you that we should be working on a local copy
> > > inside the helper and leave the original dynptr untouched.
> > > I think then the first arg should not be PTR_TO_STACK but some other
> > > pointer type. Maybe it should be its own register type, and
> > > spilled_ptr should reflect the same register, which allows the dynptr
> > > state that we track to be copied into the callback arg#0 easily.
> >
> > Right, something like what David Vernet did with his
> > bpf_user_ringbuf_drain() helper that passes kernel-only (not
> > PTR_TO_STACK) dynptr into callback. If that implementation has the
> > same hole (being able to be modified), we should fix it the same way
> > in both cases, by not allowing this for PTR_TO_DYNPTR (or whatever the
> > new reg type is called).
> >
>
> Sorry for the late response.
>
> Somehow I missed that series entirely. Yes, we should reuse that register type,
> and it does seem like it needs to check for MEM_UNINIT to prevent
> reinitialization. I'm rolling that fix into
> my dynptr series that I'm sending next week, since it would lead to
> lots of conflicts otherwise.
> Then this set can use the same approach.

Sounds good, thanks!
