Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC5740BDAB
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 04:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhIOCTW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 22:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhIOCTW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 22:19:22 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE21DC061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 19:18:03 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id d10so438006vke.10
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 19:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awHlA3biOFIdC3pl/hV6/Q4L2rePJtQpGF3wUead+/4=;
        b=MLQin915E3wTWOQpFxSNRySH7LxYp9quDi8bOBS+PikgUpiRpJQ27Zu/BsLEenoanR
         oV1uhlPUfoMZkJaFfJailZXymr/Nvmpt9SzqCd9ifQJnmlZ7yfJjDlr0KPRGk4//dKc0
         vY2abCVZc4WTWKXHVerMwoJYgQfCVxG+Ga9fTcYEke2aU+S1PX9+ZoZOJm60ftYpt590
         hBzZSFDex9ODvhpqn5hA8wnee3E+XPNY+WHvXkIiPGyhuzcNPhYErDc27nQ+KfGegMPM
         NgQndB0A3t9bZjDKBz6EnfWVFBgmBDqYcrxlXGoSOum0DMJJpA1crVv3pZRhn3QNiGfj
         zuDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awHlA3biOFIdC3pl/hV6/Q4L2rePJtQpGF3wUead+/4=;
        b=eXm1BesWxi505BBrWJX8OB2u4dYdE9ozdkozkca1knkeOX8PZkUtkvZnF87DleX1/D
         bph5SXMcB/3xlj+vrjwM1zeyDYRLvIuWwHMUGyDWvpa8MU7J+PO1uZBCvd5Q6jC6X+y6
         a94Sqr9nCtLwAqo7n/tvLqim8iZrQngdLik7uDdeIheeHHpMRVuD+6mDeNFe7XaxVit4
         PTyMM4cZsonu1mqFLUup9C34ahQHc/Al2Da3eXO9r8cypg/dZFcQtCmQSJ+JTAG6cJz6
         oKOuJSGBmeybbsh8vSc7QcTtd1g4PPLVOuITxOtuG6WL1Rdm4Ls3yK7GenCXzkczNBDC
         4lkg==
X-Gm-Message-State: AOAM533FYFL1gdBVR1d3P/1yPHMgnMWaWIZN8JW0T6E7kQRW3rgjEsln
        oy1vtdwNwRDKK7EYTJGFrpHDicmqm9/tjQp+5bA=
X-Google-Smtp-Source: ABdhPJxipl0tP2z1tb92WWR0dmiwbMVl+60RTs3y4N5K7zcD6FN1q7epzG2mmMpDrApMt6d3WOkmEGU1sPkGeLJhL84=
X-Received: by 2002:a1f:23d0:: with SMTP id j199mr1685027vkj.21.1631672281322;
 Tue, 14 Sep 2021 19:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210914201642.98734-1-grantseltzer@gmail.com> <CAEf4BzYO-C1eK1m3ii=SBqG7YPpX=GdYJLbo96nK+Vgx-hp-+g@mail.gmail.com>
In-Reply-To: <CAEf4BzYO-C1eK1m3ii=SBqG7YPpX=GdYJLbo96nK+Vgx-hp-+g@mail.gmail.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Tue, 14 Sep 2021 22:17:50 -0400
Message-ID: <CAO658oVvt9ii=J=zySnHm_LdHCrsFTTG2=yv5R4apRgJNDHM9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] Add sphinx code documentation comments
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 8:12 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Sep 14, 2021 at 1:17 PM grantseltzer <grantseltzer@gmail.com> wrote:
> >
> > From: Grant Seltzer <grantseltzer@gmail.com>
> >
> > This adds comments above five functions in btf.h which document
> > their uses. These comments are of a format that doxygen and sphinx
> > can pick up and render. These are rendered by libbpf.readthedocs.org
> >
> > Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> > ---
> >  tools/lib/bpf/btf.h | 37 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index 4a711f990904..05e06f0136e3 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -1,5 +1,6 @@
> >  /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
> >  /* Copyright (c) 2018 Facebook */
> > +/*! \file */
>
> What's the purpose of this? Is it some sort of description for the entire file?

Correct, we need to explicitly add the file to be tracked by doxygen
in order for function links to work.

>
> >
> >  #ifndef __LIBBPF_BTF_H
> >  #define __LIBBPF_BTF_H
> > @@ -30,11 +31,47 @@ enum btf_endianness {
> >         BTF_BIG_ENDIAN = 1,
> >  };
> >
> > +/**
> > + * @brief **btf__free()** frees all data of a BTF object.
> > + * @param btf BTF object to free
> > + * @return void
>
> agreed to drop this one
>
> > + */
> >  LIBBPF_API void btf__free(struct btf *btf);
> >
> > +/**
> > + * @brief **btf__new()** creates a new instance of a BTF object.
> > + * from the raw bytes of an ELF's BTF section
> > + * @param data raw bytes
> > + * @param size length of raw bytes
>
> reads a bit weird, bytes don't have "length". "Number of bytes passed
> in `data`"?
>
> > + * @return new instance of BTF object which has to be eventually freed
> > + * with **btf__free()**
> > + */
> >  LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
> > +
> > +/**
> > + * @brief **btf__new_split()** create a new instance of a BTF object from
> > + * the provided raw data bytes. It takes another BTF instance, **base_btf**,
> > + * which serves as a base BTF, which is extended by types in a newly created
> > + * BTF instance.
> > + * @param data raw bytes
> > + * @param size length of raw bytes
> > + * @param base_btf the base btf object
> > + * @return struct btf *
>
> I didn't think I had to leave a suggestion under every such empty @return...
>
> BTW, return documentation is finally a good place where we should
> document quirky libbpf error returning behavior. Something like this:
>
> ```
> On error, error-code-encoded-as-pointer is returned, not a NULL. To
> extract error code from such a pointer `libbpf_get_error()` should be
> used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
> enabled, NULL is returned on error instead. In both cases thread-local
> `errno` variable is always set to error code as well.
> ```
>
> We should have this remark under every pointer-returning API which has
> this error-code-as-ptr logic (not all APIs do).
>
>
> > + */
> >  LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
> > +
> > +/**
> > + * @brief **btf__new_empty()** creates an unpopulated BTF object.
>
> We can add "Use `btf__add_*()` to populate such BTF object.
>
> > + * @return struct btf *
>
> another not described @return
>
> > + */
> >  LIBBPF_API struct btf *btf__new_empty(void);
> > +
> > +/**
> > + * @brief **btf__new_empty_split()** creates an unpopulated
> > + * BTF object from an ELF BTF section except with a base BTF
> > + * on top of which split BTF should be based.
>
> If *base_btf* is NULL, `btf__new_empty_split()` is equivalent to
> `btf__new_empty()` and creates non-split BTF.
>
> > + * @return struct btf *
>
> and one more
>
> > + */
> >  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
> >
> >  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
> > --
> > 2.31.1
> >
