Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57634F9FFE
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 01:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbiDHXJh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 19:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbiDHXJc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 19:09:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E5121A88D
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 16:07:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bq30so4645034lfb.3
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 16:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+BuQ54kmoLDllpUTeJESfWy7GBELmXiY3qcpMNcS5v0=;
        b=Pat1U3iG4x7/yzX9mk0mLAyKjvvftuS5CYVjWQwKIneaFSDFXdiwFKsXcveh1PZ8Bg
         4xNxQruxkdCI20mQr/yQYox5b7SnB1A4B9F6+f7vx4iIxbbOrGT9J2nMXrv4zskc67KU
         oqfOYfmnJk2nSitVx1mSMaU2+FJG5AcdhLqnG5f4vrbs0l8EiKueNEe25T/fScJJ6pHW
         cFBaCDMU0KRQsVGPkB3L0Ws1JsEQpc1s3gNWMGVVjum90EBLIxjsCz2GfJpgTIma+86j
         0wfvU8zLARcix6KtpYFkrFVXO6SEv7C8fB0pLRa3rcI1Xpa7j8nGKLCP9KBNeF4w/gSP
         wakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+BuQ54kmoLDllpUTeJESfWy7GBELmXiY3qcpMNcS5v0=;
        b=PiBP4cZdlalDFMDh3PUdl7HLz5iGix/qtLaC8jgoGrk0keyR9z0+ncqSKxMBt1Eo7p
         zYCBMxoY0Y3B+pz9bNFm/fcDExPU0f8uY9uE1oMp/FPFNyW7DFMnWsA46nGiDCmF/dKu
         hXACWi+WafSmqlsUPD3GZh5LzQmouOWCrUbG9Ho42jIKmnnElBzLAtsflYmmlzHl8HzM
         ooGpkV9jGrujYcEzT67FRkKIjqYXwPwyAQeBI8pBVchM0MEyN6L/HdQ1SHsBqo22U4Ag
         1FxZnlWSusW8PDXLFMyo9UOnurhDvdOLCP3kxZx0jWruIZgdG0aSGX7YciAJEwvg7c//
         dEIw==
X-Gm-Message-State: AOAM532Xv7oSRxj5p61gcOd0BxumnZt4arWZb4KCTa9UkqOH2I29ixjI
        t5dORPTwJVNimCiMoxE5vZ9yuZMP8WkOBwpCqkM=
X-Google-Smtp-Source: ABdhPJxS7uJvMRIfKN9EPX3cmZhZuNX02boUFH4IhmZZjc5hlzxMISq6eivnnVrqBK+8flLYaZfkRXyTm7nzRJntrn0=
X-Received: by 2002:a05:6512:c18:b0:44a:9992:28bc with SMTP id
 z24-20020a0565120c1800b0044a999228bcmr14049664lfu.641.1649459245060; Fri, 08
 Apr 2022 16:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-5-joannekoong@fb.com>
 <CAEf4BzYKpxNBsHUt7rEdXnnFgR2xKNLNcx_RZbQxUsheC32vMQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYKpxNBsHUt7rEdXnnFgR2xKNLNcx_RZbQxUsheC32vMQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 8 Apr 2022 16:07:14 -0700
Message-ID: <CAJnrk1bSXgpPLK-e-fu6UyFypAY=EGmeDh-7ftj3ekMwf4DNuw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] bpf: Add bpf_dynptr_read and bpf_dynptr_write
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannekoong@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Wed, Apr 6, 2022 at 3:32 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
> >
> > From: Joanne Koong <joannelkoong@gmail.com>
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
> >  include/linux/bpf.h            |  6 ++++
> >  include/uapi/linux/bpf.h       | 18 +++++++++++
> >  kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
> >  tools/include/uapi/linux/bpf.h | 18 +++++++++++
> >  4 files changed, 98 insertions(+)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index e0fcff9f2aee..cded9753fb7f 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2426,6 +2426,12 @@ enum bpf_dynptr_type {
> >  #define DYNPTR_MAX_SIZE        ((1UL << 28) - 1)
> >  #define DYNPTR_SIZE_MASK       0xFFFFFFF
> >  #define DYNPTR_TYPE_SHIFT      29
> > +#define DYNPTR_RDONLY_BIT      BIT(28)
> > +
> > +static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> > +{
> > +       return ptr->size & DYNPTR_RDONLY_BIT;
> > +}
> >
> >  static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr_kern *ptr)
> >  {
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 6a57d8a1b882..16a35e46be90 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5175,6 +5175,22 @@ union bpf_attr {
> >   *             After this operation, *ptr* will be an invalidated dynptr.
> >   *     Return
> >   *             Void.
> > + *
> > + * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset)
> > + *     Description
> > + *             Read *len* bytes from *src* into *dst*, starting from *offset*
> > + *             into *dst*.
> > + *     Return
> > + *             0 on success, -EINVAL if *offset* + *len* exceeds the length
> > + *             of *src*'s data or if *src* is an invalid dynptr.
> > + *
> > + * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len)
> > + *     Description
> > + *             Write *len* bytes from *src* into *dst*, starting from *offset*
> > + *             into *dst*.
> > + *     Return
> > + *             0 on success, -EINVAL if *offset* + *len* exceeds the length
> > + *             of *dst*'s data or if *dst* is not writeable.
>
> Did you plan to also add a helper to copy from one dynptr to another?
> Something like
>
> long bpf_dynptr_copy(struct bpf_dynptr *dst, struct bpf_dyn_ptr *src, u32 len) ?
>
> Otherwise there won't be any way to copy memory from malloc'ed range
> to ringbuf, for example, without doing intermediate copy. Not sure
> what to do about extra offsets...
Yes! I plan for the 3rd patchset in this dynptr series to be around
convenience helpers, which will include bpf_dynptr_copy.
For the offsets, I was thinking just copy from src data + src internal
offset to dst data + dst internal offset, where there will also be
dynptr helper functions that can be called to adjust offsets
>
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)          \
> >         FN(unspec),                     \
> > @@ -5374,6 +5390,8 @@ union bpf_attr {
> >         FN(dynptr_from_mem),            \
> >         FN(malloc),                     \
> >         FN(free),                       \
> > +       FN(dynptr_read),                \
> > +       FN(dynptr_write),               \
> >         /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index ed5a7d9d0a18..7ec20e79928e 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1412,6 +1412,58 @@ const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
> >         .arg3_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
> >  };
> >
> > +BPF_CALL_4(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src, u32, offset)
> > +{
> > +       int err;
> > +
> > +       if (!src->data)
> > +               return -EINVAL;
> > +
> > +       err = bpf_dynptr_check_off_len(src, offset, len);
>
> you defined this function in patch #3, but didn't use it there. Let's
> move the definition into this patch?
Sounds great!
>
> > +       if (err)
> > +               return err;
> > +
> > +       memcpy(dst, src->data + src->offset + offset, len);
> > +
> > +       return 0;
> > +}
> > +
>
> [...]
