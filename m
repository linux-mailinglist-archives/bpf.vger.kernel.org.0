Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E295EE937
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 00:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiI1WPM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 18:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbiI1WPJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 18:15:09 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9A43312
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:15:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id rk17so16725442ejb.1
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 15:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CEFvzVTW3SGsbd4tkZyOnWkESbOKYVOKgck5UTZ5Uf0=;
        b=ljW01gXoDpKaExqu/9sx1gnl+RMcSa9mZkrQ7IjTSo8Urqe9hPdQCRPt37R9QI4O+n
         y5jWeJgIo9AiUJNCJkMW5G2TSVGOue6Y5Bo/khCqL/ZpBqQxFCK4+UoSYEN/iOcraAaC
         D9kAEOTr6XOK3ci0CZ9VG5mmydHt76uaTs0gWY6H5NzfkY3qPRTXAl4doq39bzM8Vm3B
         yylLmV0zBMTvRc8I+Gl2N9AjNug6IbZ++qaINuD0P+omqReyG/+CrMTIY8Idd53+JqwE
         NcZuq1/fkPIyih/GC3DmFR223Ovkk+We9lrlBe6ksCq7suYNp/aqozYq1NddhiGSbDnI
         mwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CEFvzVTW3SGsbd4tkZyOnWkESbOKYVOKgck5UTZ5Uf0=;
        b=k5ISslfVhFV8CpcsaY6UF9xNrICqgIdi207d9behII3RFQ+kl8vqps1CcnpFSmy+vC
         OT2vvTJaXsIewntEwfnvoZ29EB//XPxl9kRyKvwCTi3UgJTQxWQzmD8/pprwR3rDpi8B
         P9a5EY8rsxOIhhOXtZLy65weVj8iT8nUQDzsir7W5JHPa6I/3mmZP4bUbPbaIS19cnW3
         Q5qlehQoaFn7MpW5HvsmipbGIBDRI82G25Fsx1n1tQfJvve44B1ATDwbYuWbGOs4JCDb
         sT4WAzjwOVaYV8dGH8PAoS5v3XPlg5iuteSu1ruNS9ZZX5ckQBNyvVd8lbdJOMHE436y
         PCyw==
X-Gm-Message-State: ACrzQf0Xb15QTkHy4t8nNfrp4q+glFi2glEbDHPA+TW7Knnj9cVZFhKg
        vR7jAHx3jra3uUEjs0jBLTZdB4WTWUjDRrgCmG6JXQ5brLk=
X-Google-Smtp-Source: AMsMyM6iC9sxDTCbF4K0P99W18PA3h5kZDAl/iDDYFveRorAnzbGnACq0De2C6hoMSa0BU0a7ECu32lFMFzLJBikKIw=
X-Received: by 2002:a17:907:72c1:b0:783:34ce:87b9 with SMTP id
 du1-20020a17090772c100b0078334ce87b9mr66730ejc.115.1664403305375; Wed, 28 Sep
 2022 15:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com> <20220908000254.3079129-3-joannelkoong@gmail.com>
In-Reply-To: <20220908000254.3079129-3-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 28 Sep 2022 15:14:53 -0700
Message-ID: <CAEf4BzYqG8paawR5+nkVGpHCVN_Too0Uh=MUGcFOTuKA5eWcSg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] bpf: Add bpf_dynptr_trim and bpf_dynptr_advance
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

On Wed, Sep 7, 2022 at 5:10 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add two new helper functions: bpf_dynptr_trim and bpf_dynptr_advance.
>
> bpf_dynptr_trim decreases the size of a dynptr by the specified
> number of bytes (offset remains the same). bpf_dynptr_advance advances
> the offset of the dynptr by the specified number of bytes (size
> decreases correspondingly).
>
> One example where trimming / advancing the dynptr may useful is for
> hashing. If the dynptr points to a larger struct, it is possible to hash
> an individual field within the struct through dynptrs by using
> bpf_dynptr_advance+trim.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 16 +++++++++
>  kernel/bpf/helpers.c           | 63 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 16 +++++++++
>  3 files changed, 95 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index cce3356765fc..3b054553be30 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5453,6 +5453,20 @@ union bpf_attr {
>   *             dynptr is invalid or if the offset and length is out of bounds
>   *             or in a paged buffer for skb-type dynptrs or across fragments
>   *             for xdp-type dynptrs.
> + *
> + * long bpf_dynptr_advance(struct bpf_dynptr *ptr, u32 len)
> + *     Description
> + *             Advance a dynptr by *len*.

This might be a bit to succinct a description. "Advance dynptr's
internal offset by *len* bytes."?

> + *     Return
> + *             0 on success, -EINVAL if the dynptr is invalid, -ERANGE if *len*
> + *             exceeds the bounds of the dynptr.
> + *
> + * long bpf_dynptr_trim(struct bpf_dynptr *ptr, u32 len)
> + *     Description
> + *             Trim a dynptr by *len*.

Similar as above, something like "Reduce the size of memory pointed to
by dynptr by *len* without changing offset"?

> + *     Return
> + *             0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
> + *             trying to trim more bytes than the size of the dynptr.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5667,6 +5681,8 @@ union bpf_attr {
>         FN(dynptr_from_skb),            \
>         FN(dynptr_from_xdp),            \
>         FN(dynptr_data_rdonly),         \
> +       FN(dynptr_advance),             \
> +       FN(dynptr_trim),                \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 30a59c9e5df3..9f356105ab49 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1423,6 +1423,13 @@ static u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
>         return ptr->size & DYNPTR_SIZE_MASK;
>  }
>
> +static void bpf_dynptr_set_size(struct bpf_dynptr_kern *ptr, u32 new_size)
> +{
> +       u32 metadata = ptr->size & ~DYNPTR_SIZE_MASK;
> +
> +       ptr->size = new_size | metadata;
> +}
> +
>  int bpf_dynptr_check_size(u32 size)
>  {
>         return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
> @@ -1646,6 +1653,58 @@ static const struct bpf_func_proto bpf_dynptr_data_proto = {
>         .arg3_type      = ARG_CONST_ALLOC_SIZE_OR_ZERO,
>  };
>
> +BPF_CALL_2(bpf_dynptr_advance, struct bpf_dynptr_kern *, ptr, u32, len)
> +{
> +       u32 size;
> +
> +       if (!ptr->data)
> +               return -EINVAL;
> +
> +       size = bpf_dynptr_get_size(ptr);
> +
> +       if (len > size)
> +               return -ERANGE;
> +
> +       ptr->offset += len;
> +
> +       bpf_dynptr_set_size(ptr, size - len);

Kind of weird that offset is adjusted directly through field, but size
is set through helper.

One idea is to have (internal) helper that *increments* offset and
*decrements* size as one step. You can move all the error checking
inside it, instead of duplicating. E.g., something like this signature

static int bpf_dynptr_adjust(struct btf_dynptr_kern *ptr, u32 off_inc,
u32 sz_dec);

This increment/decrement is a bit surprising, but we don't allow size
to grow and offset to decrement, so this makes sense from that point
of view.

With that, we'll just do

return bpf_dynptr_adjust(ptr, len, len);

> +
> +       return 0;
> +}
> +
> +static const struct bpf_func_proto bpf_dynptr_advance_proto = {
> +       .func           = bpf_dynptr_advance,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_DYNPTR,
> +       .arg2_type      = ARG_ANYTHING,
> +};
> +
> +BPF_CALL_2(bpf_dynptr_trim, struct bpf_dynptr_kern *, ptr, u32, len)
> +{
> +       u32 size;
> +
> +       if (!ptr->data)
> +               return -EINVAL;
> +
> +       size = bpf_dynptr_get_size(ptr);
> +
> +       if (len > size)
> +               return -ERANGE;
> +
> +       bpf_dynptr_set_size(ptr, size - len);

and here we can just do

return bpf_dynptr_adjust(ptr, 0, len);

> +
> +       return 0;
> +}
> +
> +static const struct bpf_func_proto bpf_dynptr_trim_proto = {
> +       .func           = bpf_dynptr_trim,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_DYNPTR,
> +       .arg2_type      = ARG_ANYTHING,
> +};

[...]
