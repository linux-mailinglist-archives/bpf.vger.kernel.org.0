Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18152036C
	for <lists+bpf@lfdr.de>; Mon,  9 May 2022 19:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239471AbiEIRUD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 May 2022 13:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbiEIRUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 May 2022 13:20:00 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEAB286F7
        for <bpf@vger.kernel.org>; Mon,  9 May 2022 10:16:04 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2f7d621d1caso152195917b3.11
        for <bpf@vger.kernel.org>; Mon, 09 May 2022 10:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYvLWuxdTiC9+Fpl75sQW57+xHuX6XRQtZDGAOWeo4g=;
        b=l51ozzVsA4PU7hHw+eeLpAVaAgJM4HTUK2yj/srLyYqQh7LvEOrFDWyCZz9/AwrLbK
         +X3ZtaTVSt/kJg3kQ/ZyjGAZbC5uYCA52DbFJHMxlwyY4M8LpUjqw3TGgabCw4wHZDh9
         /3iY16wLl145btZaBxSuZq8fg2u8LmO0KN3ZPjb6tCgaGesJvtXM0OUws9F0rf+pVIdg
         QwqrFmyga6ha+4HxhBrJ0fcLx0hSo225ub21d5KefbSDTlXUfA3/YGGjzEGn5WNqvGxc
         b/xhq4lc/qSiTFKOSj2+0I4IOPToT1JjUHS0KsTBcPfpi3iv5Njg6kLYfSUWx9Zmz1K4
         I7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYvLWuxdTiC9+Fpl75sQW57+xHuX6XRQtZDGAOWeo4g=;
        b=6vF1Cc7KUYlNxrJquGHg2IP8Uvnq9Hnc8KEzA5YFrqUZNxm8bTk+q7qVIvmUWzSEnb
         F85mrxq7YbGSA2t0/vgziB1yh6B4B6+hEyue4CkeGNCze1FPe6/dXn7iEZe5IWDcd1PB
         UiDKV0ABHnkFJ8nmo+bz6S74L+llo++Z3t2i8FU8ubXd39nzCygdHuzyF+xumYi74E0R
         4/Z10Ccvqg9rLanr5GAcoYGSl16mAqe0C131Uk8T1nXiWtszYpA3+2B3CT3rWdAAUJ7d
         SUIjIfWdX5MvaDnTwODvMi1oHgQ5wsBOAUNOR+ivY76v/MKXgmnS5XGsXc94EOChiE4g
         no/A==
X-Gm-Message-State: AOAM533VnL1311kfw0BK3WI5l4yU3mo/qgZ1nhpfuj7Lo0VQ5SlubHw8
        Vg6qlXEVi0MRZn1N9Kn1V5FT2demc/Hekfpyoys=
X-Google-Smtp-Source: ABdhPJzHbPS8g0kmiGHsu42CkpmsB90P7LYrwxmLhfvSZkwG9JZwk2ahs67K/6L6xSgk28bQjIwxp8QviiJImMf4Wfk=
X-Received: by 2002:a81:1812:0:b0:2f7:b66f:bf3d with SMTP id
 18-20020a811812000000b002f7b66fbf3dmr16174260ywy.263.1652116563854; Mon, 09
 May 2022 10:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com>
 <20220428211059.4065379-5-joannelkoong@gmail.com> <CAEf4BzbVHWOeNH1j9ZoQTKfMXhKTGmpv0AO0+DKrdj6AyjyH3w@mail.gmail.com>
In-Reply-To: <CAEf4BzbVHWOeNH1j9ZoQTKfMXhKTGmpv0AO0+DKrdj6AyjyH3w@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 9 May 2022 10:15:53 -0700
Message-ID: <CAJnrk1bSzFwbm1n249egtjWToN+HtKak5QBM2P3brHsqTbJQgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Add bpf_dynptr_read and bpf_dynptr_write
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Fri, May 6, 2022 at 4:48 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > This patch adds two helper functions, bpf_dynptr_read and
> > bpf_dynptr_write:
> >
> > long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset);
> >
> > long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len);
> >
> > The dynptr passed into these functions must be valid dynptrs that have
> > been initialized.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/linux/bpf.h            | 16 ++++++++++
> >  include/uapi/linux/bpf.h       | 19 ++++++++++++
> >  kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 19 ++++++++++++
> >  4 files changed, 110 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 10efbec99e93..b276dbf942dd 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2387,6 +2387,12 @@ enum bpf_dynptr_type {
> >  #define DYNPTR_SIZE_MASK       0xFFFFFF
> >  #define DYNPTR_TYPE_SHIFT      28
> >  #define DYNPTR_TYPE_MASK       0x7
> > +#define DYNPTR_RDONLY_BIT      BIT(31)
> > +
> > +static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> > +{
> > +       return ptr->size & DYNPTR_RDONLY_BIT;
> > +}
> >
> >  static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr_kern *ptr)
> >  {
> > @@ -2408,6 +2414,16 @@ static inline int bpf_dynptr_check_size(u32 size)
> >         return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> >  }
> >
> > +static inline int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
> > +{
> > +       u32 capacity = bpf_dynptr_get_size(ptr) - ptr->offset;
>
> didn't you specify that size excludes offset, so size is a capacity?
Yes, bpf_dynptr_get_size(ptr) is the capacity. I will fix this for v4
>
>   +       /* Size represents the number of usable bytes in the dynptr.
>   +        * If for example the offset is at 200 for a malloc dynptr with
>   +        * allocation size 256, the number of usable bytes is 56.
>
> > +
> > +       if (len > capacity || offset > capacity - len)
> > +               return -EINVAL;
> > +
> > +       return 0;
> > +}
> > +
> >  void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
> >                      u32 offset, u32 size);
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 679f960d2514..2d539930b7b2 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5209,6 +5209,23 @@ union bpf_attr {
> >   *             'bpf_ringbuf_discard'.
> >   *     Return
> >   *             Nothing. Always succeeds.
> > + *
> > + * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset)
> > + *     Description
> > + *             Read *len* bytes from *src* into *dst*, starting from *offset*
> > + *             into *src*.
> > + *     Return
> > + *             0 on success, -EINVAL if *offset* + *len* exceeds the length
>
> this sounds more like E2BIG ?
I'll change this to -E2BIG here and in bpf_dynptr_write
>
> > + *             of *src*'s data or if *src* is an invalid dynptr.
> > + *
>
> [...]
