Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9715B3C52
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 17:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiIIPq0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 11:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiIIPqZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 11:46:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF8E108705
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 08:46:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A45A6205D
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:46:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971A3C43470
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662738382;
        bh=mva1rAMLaFGsm3lps34gDXHdDqOxkQ7NDgfslkXAm7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S0XHGksg9nd+2ER/xa7fZ17zQPRACxMhhCrh6/+23b7IlpO3ErVG/I+W2LUEgVmps
         Knut90ht+zoNraK2SvcnGc8DUq7szy/O/EtTFq9aLpdNS+XICdFZFguPIZ0swzwllj
         S/h0gLwN/RJAxEObPHIknAwuWIeXIfkul+ORFzR+OS1QF5jskqYMomo1mihgBAe/GT
         dk9gae+INIIOYvbek6hr+2FtR0qtgKGPRT/mlZl4EE4ydVLIhAGKRB71Sg0ZxRlUOT
         aN+M93yioXU2U3i+Fh5yn76/0cfL7/TxIYpVFIxI0X+Zax1slM44d41B9HtJw8xVr0
         3oO8YTticzcWw==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1280590722dso4953279fac.1
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 08:46:22 -0700 (PDT)
X-Gm-Message-State: ACgBeo0Uuzi+rQdne9X+hJCURRK0jPPluN3s9+FlTJSpRvro6tWcdtIX
        ec9DVlzwi8X3dHcBz1pn7fSjIF/AwbVuq7/hkpI=
X-Google-Smtp-Source: AA6agR66vS/jLuDY7Angr45845hwXlD68tJtajS9ZnXdD+gQhGRcwBL4tXHweSvX4ABL7XIl/xwqxz5dzbHHCEgdBUE=
X-Received: by 2002:a05:6808:195:b0:342:ed58:52b5 with SMTP id
 w21-20020a056808019500b00342ed5852b5mr4161157oic.22.1662738381554; Fri, 09
 Sep 2022 08:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com> <20220908000254.3079129-4-joannelkoong@gmail.com>
In-Reply-To: <20220908000254.3079129-4-joannelkoong@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 9 Sep 2022 16:46:10 +0100
X-Gmail-Original-Message-ID: <CAPhsuW5+4xdJRTD-m781c=N_Rvu-aVCO-OgKwJi7i9sgNO4BkQ@mail.gmail.com>
Message-ID: <CAPhsuW5+4xdJRTD-m781c=N_Rvu-aVCO-OgKwJi7i9sgNO4BkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/8] bpf: Add bpf_dynptr_is_null and bpf_dynptr_is_rdonly
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        martin.lau@kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 8, 2022 at 1:07 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add two new helper functions: bpf_dynptr_is_null and
> bpf_dynptr_is_rdonly.
>
> bpf_dynptr_is_null returns true if the dynptr is null / invalid
> (determined by whether ptr->data is NULL), else false if
> the dynptr is a valid dynptr.
>
> bpf_dynptr_is_rdonly returns true if the dynptr is read-only,
> else false if the dynptr is read-writable.

Might be a dump question.. Can we just let the bpf program to
access struct bpf_dynptr? Using a helper for this feel like an
overkill.

Thanks,
Song

>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 20 ++++++++++++++++++
>  kernel/bpf/helpers.c           | 37 +++++++++++++++++++++++++++++++---
>  scripts/bpf_doc.py             |  3 +++
>  tools/include/uapi/linux/bpf.h | 20 ++++++++++++++++++
>  4 files changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3b054553be30..90b6d0744df2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5467,6 +5467,24 @@ union bpf_attr {
>   *     Return
>   *             0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
>   *             trying to trim more bytes than the size of the dynptr.
> + *
> + * bool bpf_dynptr_is_null(struct bpf_dynptr *ptr)
> + *     Description
> + *             Determine whether a dynptr is null / invalid.
> + *
> + *             *ptr* must be an initialized dynptr.
> + *     Return
> + *             True if the dynptr is null, else false.
> + *
> + * bool bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
> + *     Description
> + *             Determine whether a dynptr is read-only.
> + *
> + *             *ptr* must be an initialized dynptr. If *ptr*
> + *             is a null dynptr, this will return false.
> + *     Return
> + *             True if the dynptr is read-only and a valid dynptr,
> + *             else false.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5683,6 +5701,8 @@ union bpf_attr {
>         FN(dynptr_data_rdonly),         \
>         FN(dynptr_advance),             \
>         FN(dynptr_trim),                \
> +       FN(dynptr_is_null),             \
> +       FN(dynptr_is_rdonly),           \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9f356105ab49..8729383d0966 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1398,7 +1398,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
>  #define DYNPTR_SIZE_MASK       0xFFFFFF
>  #define DYNPTR_RDONLY_BIT      BIT(31)
>
> -static bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> +static bool __bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
>  {
>         return ptr->size & DYNPTR_RDONLY_BIT;
>  }
> @@ -1539,7 +1539,7 @@ BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset, void *,
>         enum bpf_dynptr_type type;
>         int err;
>
> -       if (!dst->data || bpf_dynptr_is_rdonly(dst))
> +       if (!dst->data || __bpf_dynptr_is_rdonly(dst))
>                 return -EINVAL;
>
>         err = bpf_dynptr_check_off_len(dst, offset, len);
> @@ -1592,7 +1592,7 @@ void *__bpf_dynptr_data(struct bpf_dynptr_kern *ptr, u32 offset, u32 len, bool w
>         if (err)
>                 return 0;
>
> -       if (writable && bpf_dynptr_is_rdonly(ptr))
> +       if (writable && __bpf_dynptr_is_rdonly(ptr))
>                 return 0;
>
>         type = bpf_dynptr_get_type(ptr);
> @@ -1705,6 +1705,33 @@ static const struct bpf_func_proto bpf_dynptr_trim_proto = {
>         .arg2_type      = ARG_ANYTHING,
>  };
>
> +BPF_CALL_1(bpf_dynptr_is_null, struct bpf_dynptr_kern *, ptr)
> +{
> +       return !ptr->data;
> +}
> +
> +static const struct bpf_func_proto bpf_dynptr_is_null_proto = {
> +       .func           = bpf_dynptr_is_null,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_DYNPTR,
> +};
> +
> +BPF_CALL_1(bpf_dynptr_is_rdonly, struct bpf_dynptr_kern *, ptr)
> +{
> +       if (!ptr->data)
> +               return 0;
> +
> +       return __bpf_dynptr_is_rdonly(ptr);
> +}
> +
> +static const struct bpf_func_proto bpf_dynptr_is_rdonly_proto = {
> +       .func           = bpf_dynptr_is_rdonly,
> +       .gpl_only       = false,
> +       .ret_type       = RET_INTEGER,
> +       .arg1_type      = ARG_PTR_TO_DYNPTR,
> +};
> +
>  const struct bpf_func_proto bpf_get_current_task_proto __weak;
>  const struct bpf_func_proto bpf_get_current_task_btf_proto __weak;
>  const struct bpf_func_proto bpf_probe_read_user_proto __weak;
> @@ -1781,6 +1808,10 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>                 return &bpf_dynptr_advance_proto;
>         case BPF_FUNC_dynptr_trim:
>                 return &bpf_dynptr_trim_proto;
> +       case BPF_FUNC_dynptr_is_null:
> +               return &bpf_dynptr_is_null_proto;
> +       case BPF_FUNC_dynptr_is_rdonly:
> +               return &bpf_dynptr_is_rdonly_proto;
>         default:
>                 break;
>         }
> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
> index d5c389df6045..ecd227c2ea34 100755
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -691,6 +691,7 @@ class PrinterHelpers(Printer):
>              'int',
>              'long',
>              'unsigned long',
> +            'bool',
>
>              '__be16',
>              '__be32',
> @@ -761,6 +762,8 @@ class PrinterHelpers(Printer):
>          header = '''\
>  /* This is auto-generated file. See bpf_doc.py for details. */
>
> +#include <stdbool.h>
> +
>  /* Forward declarations of BPF structs */'''
>
>          print(header)
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 3b054553be30..90b6d0744df2 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -5467,6 +5467,24 @@ union bpf_attr {
>   *     Return
>   *             0 on success, -EINVAL if the dynptr is invalid, -ERANGE if
>   *             trying to trim more bytes than the size of the dynptr.
> + *
> + * bool bpf_dynptr_is_null(struct bpf_dynptr *ptr)
> + *     Description
> + *             Determine whether a dynptr is null / invalid.
> + *
> + *             *ptr* must be an initialized dynptr.
> + *     Return
> + *             True if the dynptr is null, else false.
> + *
> + * bool bpf_dynptr_is_rdonly(struct bpf_dynptr *ptr)
> + *     Description
> + *             Determine whether a dynptr is read-only.
> + *
> + *             *ptr* must be an initialized dynptr. If *ptr*
> + *             is a null dynptr, this will return false.
> + *     Return
> + *             True if the dynptr is read-only and a valid dynptr,
> + *             else false.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5683,6 +5701,8 @@ union bpf_attr {
>         FN(dynptr_data_rdonly),         \
>         FN(dynptr_advance),             \
>         FN(dynptr_trim),                \
> +       FN(dynptr_is_null),             \
> +       FN(dynptr_is_rdonly),           \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> --
> 2.30.2
>
