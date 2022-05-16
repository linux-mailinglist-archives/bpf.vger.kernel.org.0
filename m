Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9836F5292BD
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 23:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349043AbiEPVJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349407AbiEPVIq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 17:08:46 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D129617E36
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 13:52:20 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id y12so8973155ior.7
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 13:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hl9g8NCvacMcvA9/MMk3AZ1R7CTd3TA6zXvIdrfnLQM=;
        b=EBqnaT9tnmhYpiVe4l7E2bL4e/iXQNanEFMm58eVFutzzKKu7j8A5TfdIqO92PFY+X
         hjtg/EbKIsulPWHLQvYxDOnmOHT0fT5fX2KGdSpZD0GF4E+ft+gu8onPJOYit/ajUikc
         X3VB3+bxAwVuXy0UlsxX1fy1vPffqjYTIkACBJ/SwrHSszQ71jB/GltIlqsZXDxT4A4I
         nXM8nqK0zgNBl+mLGtlXLHSSZKRC5fJiGW5PVmCiKGkT3eCsbeU7kVmOObxBRGGidHWk
         yO6Dwwq/kxOqAascu8fxS/Qmd24MzrT9o61YJLaBiNy71FmsmaZgFR8QP7xIYhpFnesR
         970w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hl9g8NCvacMcvA9/MMk3AZ1R7CTd3TA6zXvIdrfnLQM=;
        b=TWdbnb3188guwumqRUxB8PFnc/VdwA7/LKngOBNi3KGO5xRDA5PkyjtAwx2VDKw3WQ
         cN/AFQdAeVSL/PbCiM+V/VZPNodZJJEI6La5CS5E32KcvxYbtBkcMqhaBHEJ22hyccG1
         5suNwwIOe9ThWnD7rpP2xOA1ULp56VBujvUF9+yLYi7EKhi1eAiVEMGJ7Kds8/+DiVOg
         BibKIQY2RM3xM2KRuQLq1t/i4132e656A/RF9lM3CmwPQ7DqPPgdHAPgIkmNtQFbUTVw
         ev3/cIzlrr6B8C69rz60S333eHumizMYO7czyNWmuLtaPL0tL/FN4gnQD4frF2QEBG+/
         fMow==
X-Gm-Message-State: AOAM531/XnSESjk6bsaqwUzPEEIwu3+Jtp6wXkDodAkZjERCElm1W9c/
        AjXvJT2EZoM/lwFhsjTwoL3m8pA6MsrLYm2rVyY=
X-Google-Smtp-Source: ABdhPJx84u62TvVoINUQvP9yGTiGLEK+vg+6M8rJyre9knBVvy8vj6FwD8IFPRdI6ZndQT2a3EoD1Mv1Exxkh/EOcJE=
X-Received: by 2002:a05:6638:2647:b0:32b:b7e6:1c68 with SMTP id
 n7-20020a056638264700b0032bb7e61c68mr9938283jat.8.1652734340233; Mon, 16 May
 2022 13:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-3-joannelkoong@gmail.com> <6c0d9917-fcb2-6a74-81d7-4f9421867d76@iogearbox.net>
In-Reply-To: <6c0d9917-fcb2-6a74-81d7-4f9421867d76@iogearbox.net>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 16 May 2022 13:52:09 -0700
Message-ID: <CAJnrk1aHi-ZG06zaisyUZoUUJPhN+bDM+9RsAqN8cM3JjsBJuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add verifier support for dynptrs and
 implement malloc dynptrs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
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

On Wed, May 11, 2022 at 5:05 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 5/10/22 12:42 AM, Joanne Koong wrote:
> [...]
> > @@ -6498,6 +6523,11 @@ struct bpf_timer {
> >       __u64 :64;
> >   } __attribute__((aligned(8)));
> >
> > +struct bpf_dynptr {
> > +     __u64 :64;
> > +     __u64 :64;
> > +} __attribute__((aligned(8)));
> > +
> >   struct bpf_sysctl {
> >       __u32   write;          /* Sysctl is being read (= 0) or written (= 1).
> >                                * Allows 1,2,4-byte read, but no write.
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 8a2398ac14c2..a4272e9239ea 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1396,6 +1396,77 @@ const struct bpf_func_proto bpf_kptr_xchg_proto = {
> >       .arg2_btf_id  = BPF_PTR_POISON,
> >   };
> >
> > +void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
> > +                  u32 offset, u32 size)
> > +{
> > +     ptr->data = data;
> > +     ptr->offset = offset;
> > +     ptr->size = size;
> > +     bpf_dynptr_set_type(ptr, type);
> > +}
> > +
> > +void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
> > +{
> > +     memset(ptr, 0, sizeof(*ptr));
> > +}
> > +
> > +BPF_CALL_3(bpf_dynptr_alloc, u32, size, u64, flags, struct bpf_dynptr_kern *, ptr)
> > +{
> > +     gfp_t gfp_flags = GFP_ATOMIC;
>
> nit: should also have __GFP_NOWARN
>
> I presume mem accounting cannot be done on this one given there is no real "ownership"
> of this piece of mem?
While we figure out the details of memory accounting for allocations,
I will defer the malloc parts of this patchset to the 2nd dynptr
patchset. I will resubmit v5 without malloc-type dynptrs
>
> Was planning to run some more local tests tomorrow, but from glance at selftest side
> I haven't seen sanity checks like these:
>
> bpf_dynptr_alloc(8, 0, &ptr);
> data = bpf_dynptr_data(&ptr, 0, 0);
> bpf_dynptr_put(&ptr);
> *(__u8 *)data = 23;
>
> How is this prevented? I think you do a ptr id check in the is_dynptr_ref_function
> check on the acquire function, but with above use, would our data pointer escape, or
> get invalidated via last put?
>
> Thanks,
> Daniel
