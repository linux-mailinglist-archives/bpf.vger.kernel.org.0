Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270425B4173
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiIIV2e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 17:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIIV2d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 17:28:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF9A1238C5
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 14:28:32 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id nc14so6996843ejc.4
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rhcvaz5g9WazQUf4SdlHn+VHLhAxVJVMIbj+YHEX368=;
        b=G6H3SkRPOJYnck4juJcXAjo95BDVSI5BooYWD8svFPS7TdpI/M/OgHEPPYV1bfp/Eh
         Jm5pMHqKjRS47n+G2HdEYsIx3OFYa2M61ew7AAXzxqv3+lSLx2bvHJ4y2hzbTNlEVly7
         7EFUtlPBc6rwvuRFGFyAVD4ILAaYulDq5UwwuboTbFbn0qJ6UydlqaFwLg92NRu7+8+I
         BP6/g+ZSmkoZPdky4kXlmFAQZJJpvslIEoBfmhLtx5sXL4uXjRX/nnnTpCmIIV8yBFKr
         8S8xnk4UNoR9KSooFlWhkpc1QoioS2v5FMtfdmWMtIH4CK/rqIa3hFuul92rGiJy3c87
         x82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rhcvaz5g9WazQUf4SdlHn+VHLhAxVJVMIbj+YHEX368=;
        b=qOjk68wCCrfXeyvMiJnRoRLNgY8Wgp8O5nZPw2j0HtlfUxWxscNpo9CEfrU0IYSq8i
         YeBTYGBRJbWuVmPLw96FeiCklDwSsbidHnky/yZz3cj7PbNfFweSwAu0r616dpwKftbZ
         Yd6YtB/9g2ZQavB9IE8GQM8xyOPkJBp5ZYoVu0lEcpuC2KUoLYgY53ub6T4bcz+p5hAn
         DtLNLhN9ItPy1u4WFYeopIupGjMKXj38+SIfT2l0Llo8ZAu1Z6fGrAjF5KzoNKmXW+Gx
         pS/LxyRAXCwtudDS0rtIuE/XhX73dNcvLShvgnAQ+COn5onHoGEuC1ps6qUQP/XCgNGB
         LlHQ==
X-Gm-Message-State: ACgBeo3C8XlmUH6CeSwdNFIBlx4MNT5CJNYk0huNLFkzDhhKgqaoLmVX
        t7STMJxbiBE/eH8dy/0LMFpYkXWlFrX5qvzckkU=
X-Google-Smtp-Source: AA6agR7nWCYX2MXATYebG3xgVhJrw66j1ji3PK6rCloilbIoB5MsrSugD4vdUYfspThF1hhoe2D24F7npKyFiQxq/uU=
X-Received: by 2002:a17:907:d19:b0:77b:2fb5:43ec with SMTP id
 gn25-20020a1709070d1900b0077b2fb543ecmr21973ejc.608.1662758910452; Fri, 09
 Sep 2022 14:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com>
 <20220908000254.3079129-4-joannelkoong@gmail.com> <CAPhsuW5+4xdJRTD-m781c=N_Rvu-aVCO-OgKwJi7i9sgNO4BkQ@mail.gmail.com>
In-Reply-To: <CAPhsuW5+4xdJRTD-m781c=N_Rvu-aVCO-OgKwJi7i9sgNO4BkQ@mail.gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Fri, 9 Sep 2022 14:28:19 -0700
Message-ID: <CAJnrk1aVsNHeYwYwPGhB5pCyG2uCvYZbMD+eVCuYb+0Z4fc+kQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
To:     Song Liu <song@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        martin.lau@kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
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

On Fri, Sep 9, 2022 at 8:46 AM Song Liu <song@kernel.org> wrote:
>
> On Thu, Sep 8, 2022 at 1:07 AM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > Add two new helper functions: bpf_dynptr_is_null and
> > bpf_dynptr_is_rdonly.
> >
> > bpf_dynptr_is_null returns true if the dynptr is null / invalid
> > (determined by whether ptr->data is NULL), else false if
> > the dynptr is a valid dynptr.
> >
> > bpf_dynptr_is_rdonly returns true if the dynptr is read-only,
> > else false if the dynptr is read-writable.
>
> Might be a dump question.. Can we just let the bpf program to
> access struct bpf_dynptr? Using a helper for this feel like an
> overkill.
>
> Thanks,
> Song
>

Not a dumb question at all, this is an interesting idea :) Right now
the struct bpf_dynptr is opaque from the bpf program side but if we
were to expose it (it'd still be read-only in the program), the
program could directly get offset and whether it's null, but would
need to do some manipulation to determine the size (since the last few
bits of 'size' stores the dynptr type and rd-only) and rd-only. I see
the advantages of either approach - personally I think it's cleaner if
the struct is completely opaque from the program side but I don't feel
strongly about it. If the worry is the overhead of needing a helper
for each, maybe another idea is to conflate them into 1 general
bpf_dynptr_get_info helper that returns offset, size, is_null, and
rd-only status?


> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  include/uapi/linux/bpf.h       | 20 ++++++++++++++++++
> >  kernel/bpf/helpers.c           | 37 +++++++++++++++++++++++++++++++---
> >  scripts/bpf_doc.py             |  3 +++
> >  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++
> >  4 files changed, 77 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 3b054553be30..90b6d0744df2 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5467,6 +5467,24 @@ union bpf_attr {
> >   *     Return
> >   *             0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
> >   *             trying to trim more bytes than the size of the dynptr.
> > + *
> > + * bool bpf_dynptr_is_null(struct bpf_dynptr *ptr)
> > + *     Description
> > + *             Determine whether a dynptr is null / invalid.
> > + *
> > + *             *ptr* must be an initialized dynptr.
> > + *     Return
> > + *             True if the dynptr is null, else false.
> > + *
> > + * bool bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
> > + *     Description
> > + *             Determine whether a dynptr is read-only.
> > + *
> > + *             *ptr* must be an initialized dynptr. If *ptr*
> > + *             is a null dynptr, this will return false.
> > + *     Return
> > + *             True if the dynptr is read-only and a valid dynptr,
> > + *             else false.
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)          \
> >         FN(unspec),                     \
> > @@ -5683,6 +5701,8 @@ union bpf_attr {
> >         FN(dynptr_data_rdonly),         \
> >         FN(dynptr_advance),             \
> >         FN(dynptr_trim),                \
> > +       FN(dynptr_is_null),             \
> > +       FN(dynptr_is_rdonly),           \
> >         /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index 9f356105ab49..8729383d0966 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1398,7 +1398,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
> >  #define DYNPTR_SIZE_MASK       0xFFFFFF
> >  #define DYNPTR_RDONLY_BIT      BIT(31)
> >
> > -static bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> > +static bool __bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> >  {
> >         return ptr->size & DYNPTR_RDONLY_BIT;
> >  }
> > @@ -1539,7 +1539,7 @@ BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset, void *,
> >         enum bpf_dynptr_type type;
> >         int err;
> >
> > -       if (!dst->data || bpf_dynptr_is_rdonly(dst))
> > +       if (!dst->data || __bpf_dynptr_is_rdonly(dst))
> >                 return -EINVAL;
> >
> >         err = bpf_dynptr_check_off_len(dst, offset, len);
> > @@ -1592,7 +1592,7 @@ void *__bpf_dynptr_data(struct bpf_dynptr_kern *ptr, u32 offset, u32 len, bool w
> >         if (err)
> >                 return 0;
> >
> > -       if (writable && bpf_dynptr_is_rdonly(ptr))
> > +       if (writable && __bpf_dynptr_is_rdonly(ptr))
> >                 return 0;
> >
> >         type = bpf_dynptr_get_type(ptr);
> > @@ -1705,6 +1705,33 @@ static const struct bpf_func_proto bpf_dynptr_trim_proto = {
> >         .arg2_type      = ARG_ANYTHING,
> >  };
> >
> > +BPF_CALL_1(bpf_dynptr_is_null, struct bpf_dynptr_kern *, ptr)
> > +{
> > +       return !ptr->data;
> > +}
> > +
> > +static const struct bpf_func_proto bpf_dynptr_is_null_proto = {
> > +       .func           = bpf_dynptr_is_null,
> > +       .gpl_only       = false,
> > +       .ret_type       = RET_INTEGER,
> > +       .arg1_type      = ARG_PTR_TO_DYNPTR,
> > +};
> > +
> > +BPF_CALL_1(bpf_dynptr_is_rdonly, struct bpf_dynptr_kern *, ptr)
> > +{
> > +       if (!ptr->data)
> > +               return 0;
> > +
> > +       return __bpf_dynptr_is_rdonly(ptr);
> > +}
> > +
> > +static const struct bpf_func_proto bpf_dynptr_is_rdonly_proto = {
> > +       .func           = bpf_dynptr_is_rdonly,
> > +       .gpl_only       = false,
> > +       .ret_type       = RET_INTEGER,
> > +       .arg1_type      = ARG_PTR_TO_DYNPTR,
> > +};
> > +
> >  const struct bpf_func_proto bpf_get_current_task_proto __weak;
> >  const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
> >  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
> > @@ -1781,6 +1808,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
> >                 return &bpf_dynptr_advance_proto;
> >         case BPF_FUNC_dynptr_trim:
> >                 return &bpf_dynptr_trim_proto;
> > +       case BPF_FUNC_dynptr_is_null:
> > +               return &bpf_dynptr_is_null_proto;
> > +       case BPF_FUNC_dynptr_is_rdonly:
> > +               return &bpf_dynptr_is_rdonly_proto;
> >         default:
> >                 break;
> >         }
> > diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> > index d5c389df6045..ecd227c2ea34 100755
> > --- a/scripts/bpf_doc.py
> > +++ b/scripts/bpf_doc.py
> > @@ -691,6 +691,7 @@ class PrinterHelpers(Printer):
> >              'int',
> >              'long',
> >              'unsigned long',
> > +            'bool',
> >
> >              '__be16',
> >              '__be32',
> > @@ -761,6 +762,8 @@ class PrinterHelpers(Printer):
> >          header = '''\
> >  /* This is auto-generated file. See bpf_doc.py for details. */
> >
> > +#include <stdbool.h>
> > +
> >  /* Forward declarations of BPF structs */'''
> >
> >          print(header)
> > diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> > index 3b054553be30..90b6d0744df2 100644
> > --- a/tools/include/uapi/linux/bpf.h
> > +++ b/tools/include/uapi/linux/bpf.h
> > @@ -5467,6 +5467,24 @@ union bpf_attr {
> >   *     Return
> >   *             0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
> >   *             trying to trim more bytes than the size of the dynptr.
> > + *
> > + * bool bpf_dynptr_is_null(struct bpf_dynptr *ptr)
> > + *     Description
> > + *             Determine whether a dynptr is null / invalid.
> > + *
> > + *             *ptr* must be an initialized dynptr.
> > + *     Return
> > + *             True if the dynptr is null, else false.
> > + *
> > + * bool bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
> > + *     Description
> > + *             Determine whether a dynptr is read-only.
> > + *
> > + *             *ptr* must be an initialized dynptr. If *ptr*
> > + *             is a null dynptr, this will return false.
> > + *     Return
> > + *             True if the dynptr is read-only and a valid dynptr,
> > + *             else false.
> >   */
> >  #define __BPF_FUNC_MAPPER(FN)          \
> >         FN(unspec),                     \
> > @@ -5683,6 +5701,8 @@ union bpf_attr {
> >         FN(dynptr_data_rdonly),         \
> >         FN(dynptr_advance),             \
> >         FN(dynptr_trim),                \
> > +       FN(dynptr_is_null),             \
> > +       FN(dynptr_is_rdonly),           \
> >         /* */
> >
> >  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> > --
> > 2.30.2
> >
