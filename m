Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D9B5EE989
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 00:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbiI1Wlj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 18:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiI1Wli (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 18:41:38 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913C710B23E
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:41:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id sb3so29967701ejb.9
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=iylOFVM+J7jnywGfVlajsF6ZhsJAMC40+DdHbRyzZQM=;
        b=ISyoA7N5qztrn36qby/wv1txh9iAYyAKAMBkSqGmC8rM8fyYsoO5/Xc4FvHQp1zyZD
         QQJSXeiurOKVGSre5Z3sJjN84nTy1AE3/3J5j3QYydYcdFhnIyq5qfiPnXAURwFIzM0R
         6rACeXxtfImFn9+GnJfS7qz8b+hXmjgGerJz9/His3FRM6YTu0txTL1db8uKLPNsTb9w
         7oK34pt/1dlkruncRI/l97lfvfl1GyUCgfYUMWjHhbWa36js7FUgID5PFOMOU/sJofuN
         G37St1Ff4QfpUkUcD7FMcJviZR19JUix5crLEoE44fYHZlQ4QqG5632pCqYoAPKSo2Dv
         m3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iylOFVM+J7jnywGfVlajsF6ZhsJAMC40+DdHbRyzZQM=;
        b=4CX+WCBCRXMlhezlpzpZtk+uu+C82ZdoKXt9zhO9Lt9IL9dCY3rGks+mEQh/cMrKkQ
         mzuG9v5FFfdYcU/ILZ6L/mZpy6oB9nBhNm6+zZuqv2PmKZ/rJq68rxXRrMnqEgZSler9
         Ef8/JUFflMf9Vv9i4hxElv535Zm9mb69RjcD+myWUuGiD3b5NfrMCsyLFQcF8Oo9XkeH
         ZM0Uw18gmwGJbv6eUyMZzA2OHNRTt4/M35F2KHkc3t8xoP0B/+HwOaML/iVuWouzP85i
         YUvnOWr123BV1Qdbv/iOp3NjcsLM9bdyCYqBtXPPNZdSRIceyc+WpjGz6bkeTGnL6sp5
         eafQ==
X-Gm-Message-State: ACrzQf37CqzILGsFfKW/1X8rQzHTUCYgpUTAa0vYAukmtiEtGnaGTz2D
        wO40wLPfYBVwFy4MvD/vy7s+h9f5txN3U1eHaC0=
X-Google-Smtp-Source: AMsMyM5sQLX9fV6XlG652UR3mGDyNEGfgd5HHedAYUDif3/xWBgcVwu+4DK0Q1Vofzpj1bXglnNcqNOStuozp4lp9Vk=
X-Received: by 2002:a17:907:3fa9:b0:782:ed33:df8d with SMTP id
 hr41-20020a1709073fa900b00782ed33df8dmr116800ejc.745.1664404896129; Wed, 28
 Sep 2022 15:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com> <20220908000254.3079129-8-joannelkoong@gmail.com>
In-Reply-To: <20220908000254.3079129-8-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 15:41:23 -0700
Message-ID: <CAEf4Bza2B+LFPm0dtdtfj+_ai5rTzjybHbM2XH_9UnBUF02izg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 7/8] bpf: Add bpf_dynptr_iterator
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        andrii@kernel.org, ast@kernel.org, Kernel-team@fb.com
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

On Wed, Sep 7, 2022 at 5:07 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add a new helper function, bpf_dynptr_iterator:
>
>   long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn,
>                            void *callback_ctx, u64 flags)
>
> where callback_fn is defined as:
>
>   long (*callback_fn)(struct bpf_dynptr *ptr, void *ctx)
>
> and callback_fn returns the number of bytes to advance the
> dynptr by (or an error code in the case of error). The iteration
> will stop if the callback_fn returns 0 or an error or tries to
> advance by more bytes than available.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 20 ++++++++++++++
>  kernel/bpf/helpers.c           | 48 +++++++++++++++++++++++++++++++---
>  kernel/bpf/verifier.c          | 27 +++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++
>  4 files changed, 111 insertions(+), 4 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 16973fa4d073..ff78a94c262a 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5531,6 +5531,25 @@ union bpf_attr {
>   *             losing access to the original view of the dynptr.
>   *     Return
>   *             0 on success, -EINVAL if the dynptr to clone is invalid.
> + *
> + * long bpf_dynptr_iterator(struct bpf_dynptr *ptr, void *callback_fn, void *callback_ctx, u64 flags)
> + *     Description
> + *             Iterate through the dynptr data, calling **callback_fn** on each
> + *             iteration with **callback_ctx** as the context parameter.
> + *             The **callback_fn** should be a static function and
> + *             the **callback_ctx** should be a pointer to the stack.
> + *             Currently **flags** is unused and must be 0.
> + *
> + *             long (\*callback_fn)(struct bpf_dynptr \*ptr, void \*ctx);
> + *
> + *             where **callback_fn** returns the number of bytes to advance
> + *             the dynptr by or an error. The iteration will stop if **callback_fn**
> + *             returns 0 or an error or tries to advance by more bytes than the
> + *             size of the dynptr.
> + *     Return
> + *             0 on success, -EINVAL if the dynptr is invalid or **flags** is not 0,
> + *             -ERANGE if attempting to iterate more bytes than available, or other
> + *             negative error if **callback_fn** returns an error.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5752,6 +5771,7 @@ union bpf_attr {
>         FN(dynptr_get_size),            \
>         FN(dynptr_get_offset),          \
>         FN(dynptr_clone),               \
> +       FN(dynptr_iterator),            \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 667f1e213a61..519b3da06d49 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1653,13 +1653,11 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
>         .arg3_type      = ARG_CONST_ALLOC_SIZE_OR_ZERO,
>  };
>
> -BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> +/* *ptr* should always be a valid dynptr */
> +static int __bpf_dynptr_advance(struct bpf_dynptr_kern *ptr, u32 len)
>  {
>         u32 size;
>
> -       if (!ptr->data)
> -               return -EINVAL;
> -
>         size = __bpf_dynptr_get_size(ptr);
>
>         if (len > size)
> @@ -1672,6 +1670,14 @@ BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
>         return 0;
>  }
>
> +BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> +{
> +       if (!ptr->data)
> +               return -EINVAL;
> +
> +       return __bpf_dynptr_advance(ptr, len);
> +}
> +
>  static const struct bpf_func_proto bpf_dynptr_advance_proto = {
>         .func           = bpf_dynptr_advance,
>         .gpl_only       = false,
> @@ -1783,6 +1789,38 @@ static const struct bpf_func_proto bpf_dynptr_clone_proto = {
>         .arg2_type      = ARG_PTR_TO_DYNPTR | MEM_UNINIT,
>  };
>
> +BPF_CALL_4(bpf_dynptr_iterator, struct bpf_dynptr_kern *, ptr, void *, callback_fn,
> +          void *, callback_ctx, u64, flags)
> +{
> +       bpf_callback_t callback = (bpf_callback_t)callback_fn;
> +       int nr_bytes, err;
> +
> +       if (!ptr->data || flags)
> +               return -EINVAL;
> +
> +       while (ptr->size > 0) {
> +               nr_bytes = callback((u64)(long)ptr, (u64)(long)callback_ctx, 0, 0, 0);
> +               if (nr_bytes <= 0)
> +                       return nr_bytes;

callback is defined as returning long but here you are silently
truncating it to int. Let's either stick to longs or to ints.

> +
> +               err = __bpf_dynptr_advance(ptr, nr_bytes);

as Kumar pointed out, you can't modify ptr in place, you have to
create a local copy and bpf_dynptr_clone() it (so that for MALLOC
you'll bump refcnt). Then advance and pass it to callback. David has
such local dynptr use case in bpf_user_ringbuf_drain() helper.

> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +

[...]
