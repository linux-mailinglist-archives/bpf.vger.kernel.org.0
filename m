Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4997622127
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 02:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKIBFf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 20:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiKIBFd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 20:05:33 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3068C63CF4
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 17:05:29 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id q9so43045876ejd.0
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 17:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xFXqQY047XYBWypt82Fm3fZZXIzTFgiyjTFsnnBnPZg=;
        b=Y9CdM6W5Z0iJz+mA2/gVG8aC5rUDk39YWTsZyJIsC9NXzj8rFWBNJWAA+6cKbmCjJd
         wm3s38LAs6lYKpg7z0Gmd7nmyciUzrYigoqksB7uynZUTS4O0R23vV0/a3JASobXPBWh
         rR4gkUxCFYPighpVWn2y8MWv+biIWjnNbzussKheu+lrCyYhWDMzyLSbjwS0gj1AaEJV
         Grus4oLD+dl/GwP70Ja66nUI+WG+INn89ucMVHMwfXiLxLfnNK6M8qHodfjgvfLqYiEq
         GeC0lj4UN5rLOZo3K0FFKhtHfej4A7VMbyBEzAm4BYpuv/zMrDKbZMSEitFWYCZbUuKI
         6Y6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFXqQY047XYBWypt82Fm3fZZXIzTFgiyjTFsnnBnPZg=;
        b=JZNynoaZ1vMXNIgijqo+Kdx/RqMcKOqRAsEcl8QxRO8oEPdMCQ+AN/3WXQ2c5kRf6z
         ia3z00F13OX5Tv1GUBvxk5RiAaEn0fvTAmnlT/2V7mW+7PYHp4ub8jnZXmqa4nqlwGM1
         1l1Cz+npOqquvSnYpI7f8738Hi3shcoTTI5nWezSnVea0Rr5ku4PoyXrSB1wxAHErSRb
         xPxrzeQ3PIVOBBCFARISVNCi4s3sOYWzrNFyFYUFQa+D7GKFAb3mJDjgBuuXqc5GDvlZ
         OimeFBgFI5KM7uRrUX/JrXRNhHsGqBNao2FfvXnq5GB+nfulOQh4DvPc7Emj0SyLfPbS
         kctw==
X-Gm-Message-State: ACrzQf2QJQPCmPJ5bVR4VXEjrbpjMtEpt3QYSklUeTjb9QxQUxs3rtTj
        nrYSikbL3TrYREaVLd8QV5z3g99g56ezbhxyL/4=
X-Google-Smtp-Source: AMsMyM6UncjGF4WDxEsdrjqNcPBE7qu0qKnuHP8RNjPmUM2pkIZ0e7l05ag+fqVXaS6YOyLgDtbCn/FNnCNsuQJu1eQ=
X-Received: by 2002:a17:906:fe45:b0:788:15a5:7495 with SMTP id
 wz5-20020a170906fe4500b0078815a57495mr56105955ejb.633.1667955927673; Tue, 08
 Nov 2022 17:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20221107230950.7117-1-memxor@gmail.com> <20221107230950.7117-6-memxor@gmail.com>
 <CAEf4BzZ180YJ+fbynJSR2fXXMVuKZTyginHyRdxydvOm-po7TA@mail.gmail.com>
 <20221108234901.erzrj2b6bsvqkzir@apollo> <CAEf4BzZJBeBr69QFdbj0L_76uViBsJJ1EzTiTFni+eUtTCG9mQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZJBeBr69QFdbj0L_76uViBsJJ1EzTiTFni+eUtTCG9mQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 8 Nov 2022 17:05:15 -0800
Message-ID: <CAADnVQJnHLu30fxj3rpzNNMDseJDk2Rs37e9PrqLQ3n=UEtZcQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 05/25] bpf: Rename MEM_ALLOC to MEM_RINGBUF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
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

On Tue, Nov 8, 2022 at 4:26 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 8, 2022 at 3:49 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > On Wed, Nov 09, 2022 at 04:44:16AM IST, Andrii Nakryiko wrote:
> > > On Mon, Nov 7, 2022 at 3:10 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > >
> > > > Currently, verifier uses MEM_ALLOC type tag to specially tag memory
> > > > returned from bpf_ringbuf_reserve helper. However, this is currently
> > > > only used for this purpose and there is an implicit assumption that it
> > > > only refers to ringbuf memory (e.g. the check for ARG_PTR_TO_ALLOC_MEM
> > > > in check_func_arg_reg_off).
> > > >
> > > > Hence, rename MEM_ALLOC to MEM_RINGBUF to indicate this special
> > > > relationship and instead open the use of MEM_ALLOC for more generic
> > > > allocations made for user types.
> > > >
> > > > Also, since ARG_PTR_TO_ALLOC_MEM_OR_NULL is unused, simply drop it.
> > > >
> > > > Finally, update selftests using 'alloc_' verifier string to 'ringbuf_'.
> > > >
> > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > ---
> > >
> > > Ok, so you are doing what I asked in the previous patch, nice :)
> > >
> > > >  include/linux/bpf.h                               | 11 ++++-------
> > > >  kernel/bpf/ringbuf.c                              |  6 +++---
> > > >  kernel/bpf/verifier.c                             | 14 +++++++-------
> > > >  tools/testing/selftests/bpf/prog_tests/dynptr.c   |  2 +-
> > > >  tools/testing/selftests/bpf/verifier/ringbuf.c    |  2 +-
> > > >  tools/testing/selftests/bpf/verifier/spill_fill.c |  2 +-
> > > >  6 files changed, 17 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index 2fe3ec620d54..afc1c51b59ff 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -488,10 +488,8 @@ enum bpf_type_flag {
> > > >          */
> > > >         MEM_RDONLY              = BIT(1 + BPF_BASE_TYPE_BITS),
> > > >
> > > > -       /* MEM was "allocated" from a different helper, and cannot be mixed
> > > > -        * with regular non-MEM_ALLOC'ed MEM types.
> > > > -        */
> > > > -       MEM_ALLOC               = BIT(2 + BPF_BASE_TYPE_BITS),
> > > > +       /* MEM points to BPF ring buffer reservation. */
> > > > +       MEM_RINGBUF             = BIT(2 + BPF_BASE_TYPE_BITS),
> > >
> > > What do we gain by having ringbuf memory as additional modified flag
> > > instead of its own type like PTR_TO_MAP_VALUE or PTR_TO_PACKET? It
> > > feels like here separate register type is more justified and is less
> > > error prone overall.
> > >
> >
> > I'm not sure it's all that different. It only matters when checking argument
> > during release. We want to ensure it came from ringbuf_reserve. That's all,
> > apart from that it's no different from PTR_TO_MEM. In all other places it's
> > folded and code for PTR_TO_MEM is used. Same idea as PTR_TO_BTF_ID | MEM_ALLOC.
> >
> > But I don't feel too strongly, so if you still think it's better I can make the
> > switch.
>
> Not strongly, but I think having this as a flag is more error prone.
> For cases where ringbuf memory should be treated just as memory, we
> should use the same mechanism we have for MAP_VALUE. But I haven't
> checked how we deal with MAP_VALUE, if that's a special case
> everywhere, in addition to generic PTR_TO_MEM, then fine. But if
> having PTR_TO_RINGBUF_MEM is converted to PTR_TO_MEM generically where
> needed, I'd have dedicated PTR_TO_RINGBUF_MEM.

I don't think we can or at least it's not as easy to generalize
ringbuf mem as map_value.
iirc MEM_ALLOC was there to make sure reserver->commit is the same mem.
That's what MEM_RINGBUF will doing after this patch.
