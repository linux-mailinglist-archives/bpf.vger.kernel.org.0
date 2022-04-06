Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9F4F6DD7
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 00:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiDFWec (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 18:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiDFWeb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 18:34:31 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8547B33C
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 15:32:33 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id r2so4731186iod.9
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 15:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAGp8ykfHdFmNXRA1g1DSa8JgWSASe4yNksi/voRRWI=;
        b=jXMMEknO4HfHo9skRbEKQPz/kpFUBlp4+DjFE/Vxzr2oK4hziw/9sCuX1hizEk3jDU
         dFs5qr1xA3pB+Or51JRsTEQQ0vMzjh8tEnQjLtUKLbG8f68mjNcVfgu9081TZT7dSCKn
         mYPqhlhYOGtaEJOK6f4yvODswsirqe4SJbJiaxVZMmLbf52p4C7MsEXWHsZHY0GteS8H
         lESiSjvRSjwZAEcte6wE8WXekJjKRdwxQUdDFMvyc9gkDrRIvv+DjEPJYZxhSBINPq9H
         2we4cnKxr0hY6RLAjz5lC9Sfpagzr1MSH2Xof3Ss6ck5OCAh4HNEoIBPFm4Up6YOAdw7
         qN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAGp8ykfHdFmNXRA1g1DSa8JgWSASe4yNksi/voRRWI=;
        b=VHj2ZDiu0jur4/CMoFUYOkDR1FLSCm7I2+bMex40VjcK+shT2qMoW6n1yHF7pDh1qZ
         lVwP8bNYjd2M2aeJRu6My+gPM7B7E4qU7JrgBnjTzwJ6DWjMjVuz7XBAnrY8ZcZ3nH6I
         cxCl72cZJubLQnW/DPKez3UrMAmBgbgnsYgj7DbVohsTjadg5F1HBy71dTqFadMuXYdI
         IIiNINbVWnG0REK37lXZmU5CeFkZN60oszdn4imMKrvSR2f8z0p0kDpRvvgWRLuQznA1
         A792jztxpfOU3/AV1gQxyFcsyi/eQa474BFexq8X8byBCxiHgP8sUXkA57uCvSJiAcZu
         y3bQ==
X-Gm-Message-State: AOAM532BM7ZyiiiFg9a3QG+MU4EBswC+li2BgLQ3UT+BUQ9HoMjWPWVA
        oRDTAryefrOz/qXHV4nId6z82vDXzMDIMVFDzXoiOoN4
X-Google-Smtp-Source: ABdhPJxzDPHaHpG771rkmrMbh1KPWa/F2Vr/CQD8PIaLas5T86GjcAl/xSwHrSp8Yx11MNcVN9PaJsJcn1hUlf2B80Y=
X-Received: by 2002:a05:6602:3c6:b0:63d:cac9:bd35 with SMTP id
 g6-20020a05660203c600b0063dcac9bd35mr5071526iov.144.1649284352900; Wed, 06
 Apr 2022 15:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220402015826.3941317-1-joannekoong@fb.com> <20220402015826.3941317-5-joannekoong@fb.com>
In-Reply-To: <20220402015826.3941317-5-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 15:32:22 -0700
Message-ID: <CAEf4BzYKpxNBsHUt7rEdXnnFgR2xKNLNcx_RZbQxUsheC32vMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] bpf: Add bpf_dynptr_read and bpf_dynptr_write
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Fri, Apr 1, 2022 at 7:00 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> From: Joanne Koong <joannelkoong@gmail.com>
>
> This patch adds two helper functions, bpf_dynptr_read and
> bpf_dynptr_write:
>
> long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset);
>
> long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len);
>
> The dynptr passed into these functions must be valid dynptrs that have
> been initialized.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h            |  6 ++++
>  include/uapi/linux/bpf.h       | 18 +++++++++++
>  kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 18 +++++++++++
>  4 files changed, 98 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index e0fcff9f2aee..cded9753fb7f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2426,6 +2426,12 @@ enum bpf_dynptr_type {
>  #define DYNPTR_MAX_SIZE        ((1UL << 28) - 1)
>  #define DYNPTR_SIZE_MASK       0xFFFFFFF
>  #define DYNPTR_TYPE_SHIFT      29
> +#define DYNPTR_RDONLY_BIT      BIT(28)
> +
> +static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> +{
> +       return ptr->size & DYNPTR_RDONLY_BIT;
> +}
>
>  static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr_kern *ptr)
>  {
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 6a57d8a1b882..16a35e46be90 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5175,6 +5175,22 @@ union bpf_attr {
>   *             After this operation, *ptr* will be an invalidated dynptr.
>   *     Return
>   *             Void.
> + *
> + * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset)
> + *     Description
> + *             Read *len* bytes from *src* into *dst*, starting from *offset*
> + *             into *dst*.
> + *     Return
> + *             0 on success, -EINVAL if *offset* + *len* exceeds the length
> + *             of *src*'s data or if *src* is an invalid dynptr.
> + *
> + * long bpf_dynptr_write(struct bpf_dynptr *dst, u32 offset, void *src, u32 len)
> + *     Description
> + *             Write *len* bytes from *src* into *dst*, starting from *offset*
> + *             into *dst*.
> + *     Return
> + *             0 on success, -EINVAL if *offset* + *len* exceeds the length
> + *             of *dst*'s data or if *dst* is not writeable.

Did you plan to also add a helper to copy from one dynptr to another?
Something like

long bpf_dynptr_copy(struct bpf_dynptr *dst, struct bpf_dyn_ptr *src, u32 len) ?

Otherwise there won't be any way to copy memory from malloc'ed range
to ringbuf, for example, without doing intermediate copy. Not sure
what to do about extra offsets...

>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5374,6 +5390,8 @@ union bpf_attr {
>         FN(dynptr_from_mem),            \
>         FN(malloc),                     \
>         FN(free),                       \
> +       FN(dynptr_read),                \
> +       FN(dynptr_write),               \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index ed5a7d9d0a18..7ec20e79928e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1412,6 +1412,58 @@ const struct bpf_func_proto bpf_dynptr_from_mem_proto = {
>         .arg3_type      = ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL | MEM_UNINIT,
>  };
>
> +BPF_CALL_4(bpf_dynptr_read, void *, dst, u32, len, struct bpf_dynptr_kern *, src, u32, offset)
> +{
> +       int err;
> +
> +       if (!src->data)
> +               return -EINVAL;
> +
> +       err = bpf_dynptr_check_off_len(src, offset, len);

you defined this function in patch #3, but didn't use it there. Let's
move the definition into this patch?

> +       if (err)
> +               return err;
> +
> +       memcpy(dst, src->data + src->offset + offset, len);
> +
> +       return 0;
> +}
> +

[...]
