Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5850C528BE2
	for <lists+bpf@lfdr.de>; Mon, 16 May 2022 19:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbiEPRYE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 May 2022 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiEPRYD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 May 2022 13:24:03 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E2B366B3
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:24:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e15so16706458iob.3
        for <bpf@vger.kernel.org>; Mon, 16 May 2022 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RxMT4EULnAOBlaiygeIZEZLT0aq6KD2uMOk/+vldDg=;
        b=SxbnbDCYoXR9zid23xCZy4AXVUe7FoISd8BE0jGe4fiYFtzWkJIctVkVZDZ6HABSjz
         u//9qGKtP9eONEcSzLWeN0Pvd+riw8McPmELGWKv7TE6uH2yQA/POA63/NGlbR5xuSEM
         iVrHynonTALBx8zWJ1/Gg3++i4co+yWemBbZehuFRNTG3xb6fm/priwCtCncmuEOD1fe
         3OkjIGMe8COMisNwmV9cNuehD3IHgsQkA06xOgt9Jj9cQbYel+GlOpprQkN5dU4qIbid
         J5T2tjUj0Emx4GqTi+b0/TpP2ZidyviGuPftb0MG1hN/Jr5VfY9LwE+YereBjY/4B8zG
         FlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RxMT4EULnAOBlaiygeIZEZLT0aq6KD2uMOk/+vldDg=;
        b=hpq6/zbpmnopmXeFLc4rIWZqwA/ji6JsJw1v2RcbRLD3FA/jiHxebg+8HLyunjSuCq
         f3DzoY6R/UXM1NLk3TUSggpf87fpq4txHG0rQvxkjqqIApm2Bd8hrmKrgdOqsrL4N9qm
         Eqv0PhjFlMaeKFrxCBIIniCXJakQALxVBr3hPU/U27w4xw9/esOuoF7gxXykw3944hzz
         iNa2GDS6AiPr9tVFXzf7KOoOil1cPRfx6CsIBXgtCplTmr+CqiVR0vUws24v34PzZHCL
         29fq1RsGgKxuFpAhHOHlB/FRnChWPVWWQlPkcw3l3ZBlhOYn8AzMmxLXObHCyl1/FOz+
         XVCA==
X-Gm-Message-State: AOAM530yVuED7jMTIH1MM9y4rwirgXPxarGRag88QEL2XKQiv2zf3lNm
        1DZkBppYZtC6yVnoLGmO8K11gsw1Fz/H+chg5cY=
X-Google-Smtp-Source: ABdhPJz8KQWrlV8h8muyat3zHJPUJ0NP3jPg6WhRNajVYyX9rh7gxIdOJnx+KTv+xfuI/im2fnxdxHSytELtqETaDXw=
X-Received: by 2002:a6b:7a05:0:b0:65b:8bd:a969 with SMTP id
 h5-20020a6b7a05000000b0065b08bda969mr8423633iom.95.1652721842423; Mon, 16 May
 2022 10:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220509224257.3222614-1-joannelkoong@gmail.com>
 <20220509224257.3222614-5-joannelkoong@gmail.com> <20220516165627.4a2kdpgzmln5ejew@dev0025.ash9.facebook.com>
In-Reply-To: <20220516165627.4a2kdpgzmln5ejew@dev0025.ash9.facebook.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Mon, 16 May 2022 10:23:51 -0700
Message-ID: <CAJnrk1aGvZ69LTxHbVJjDBxzt0MFcaT9N5hk5d7Oe3=0J=LAWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 4/6] bpf: Add bpf_dynptr_read and bpf_dynptr_write
To:     David Vernet <void@manifault.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
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

On Mon, May 16, 2022 at 9:56 AM David Vernet <void@manifault.com> wrote:
>
> On Mon, May 09, 2022 at 03:42:55PM -0700, Joanne Koong wrote:
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
> > index 8fbe739b0dec..6f4fa0627620 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2391,6 +2391,12 @@ enum bpf_dynptr_type {
> >  #define DYNPTR_SIZE_MASK     0xFFFFFF
> >  #define DYNPTR_TYPE_SHIFT    28
> >  #define DYNPTR_TYPE_MASK     0x7
> > +#define DYNPTR_RDONLY_BIT    BIT(31)
> > +
> > +static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> > +{
> > +     return ptr->size & DYNPTR_RDONLY_BIT;
> > +}
> >
> >  static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr_kern *ptr)
> >  {
> > @@ -2412,6 +2418,16 @@ static inline int bpf_dynptr_check_size(u32 size)
> >       return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> >  }
> >
> > +static inline int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
> > +{
> > +     u32 size = bpf_dynptr_get_size(ptr);
> > +
> > +     if (len > size || offset > size - len)
> > +             return -E2BIG;
> > +
> > +     return 0;
> > +}
>
> Does this need to be in bpf.h? Or could it be brought into helpers.c as a
> static function? I don't think there's any harm in leaving it here, but at
> first glance it seems like a helper function that doesn't really need to be
> exported.
I will move this function back to helpers.c
>
> > +
> >  void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
> >                    u32 offset, u32 size);
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 679f960d2514..f0c5ca220d8e 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5209,6 +5209,23 @@ union bpf_attr {
> >   *           'bpf_ringbuf_discard'.
> >   *   Return
> >   *           Nothing. Always succeeds.
> > + *
> > + * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset)
> > + *   Description
> > + *           Read *len* bytes from *src* into *dst*, starting from *offset*
> > + *           into *src*.
> > + *   Return
> > + *           0 on success, -E2BIG if *offset* + *len* exceeds the length
> > + *           of *src*'s data, -EINVAL if *src* is an invalid dynptr.
> > + *
> > + * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len)
> > + *   Description
> > + *           Write *len* bytes from *src* into *dst*, starting from *offset*
> > + *           into *dst*.
> > + *   Return
> > + *           0 on success, -E2BIG if *offset* + *len* exceeds the length
> > + *           of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
> > + *           is a read-only dynptr.
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)                \
> >       FN(unspec),                     \
> > @@ -5411,6 +5428,8 @@ union bpf_attr {
> >       FN(ringbuf_reserve_dynptr),     \
> >       FN(ringbuf_submit_dynptr),      \
> >       FN(ringbuf_discard_dynptr),     \
> > +     FN(dynptr_read),                \
> > +     FN(dynptr_write),               \
> >       /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 2d6f2e28b580..7206b9e5322f 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1467,6 +1467,58 @@ const struct bpf_func_proto bpf_dynptr_put_proto = {
> >       .arg1_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_MALLOC | OBJ_RELEASE,
> >  };
> >
> > +BPF_CALL_4(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src, u32, offset)
> > +{
> > +     int err;
> > +
> > +     if (!src->data)
> > +             return -EINVAL;
> > +
> > +     err = bpf_dynptr_check_off_len(src, offset, len);
> > +     if (err)
> > +             return err;
> > +
> > +     memcpy(dst, src->data + src->offset + offset, len);
> > +
> > +     return 0;
> > +}
> > +
> > +const struct bpf_func_proto bpf_dynptr_read_proto = {
> > +     .func           = bpf_dynptr_read,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_UNINIT_MEM,
> > +     .arg2_type      = ARG_CONST_SIZE_OR_ZERO,
> > +     .arg3_type      = ARG_PTR_TO_DYNPTR,
> > +     .arg4_type      = ARG_ANYTHING,
>
> I think what you have now is safe / correct, but is there a reason that we
> don't use ARG_CONST_SIZE_OR_ZERO for both the len and the offset, given
> that they're both bound by the size of a memory region? Same question
> applies to the function proto for bpf_dynptr_write() as well.
I think it offers more flexibility as an API if the offset doesn't
have to be statically known (eg the program can use an offset that is
set by the userspace application).
>
> > +};
> > +
> > +BPF_CALL_4(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset, void *, src, u32, len)
> > +{
> > +     int err;
> > +
> > +     if (!dst->data || bpf_dynptr_is_rdonly(dst))
> > +             return -EINVAL;
> > +
> > +     err = bpf_dynptr_check_off_len(dst, offset, len);
> > +     if (err)
> > +             return err;
> > +
> > +     memcpy(dst->data + dst->offset + offset, src, len);
> > +
> > +     return 0;
> > +}
> > +
> > +const struct bpf_func_proto bpf_dynptr_write_proto = {
> > +     .func           = bpf_dynptr_write,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_DYNPTR,
> > +     .arg2_type      = ARG_ANYTHING,
> > +     .arg3_type      = ARG_PTR_TO_MEM | MEM_RDONLY,
> > +     .arg4_type      = ARG_CONST_SIZE_OR_ZERO,
> > +};
> > +
>
> [...]
>
> Overall looks great.
