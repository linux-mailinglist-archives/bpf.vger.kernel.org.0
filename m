Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821675B3BEE
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 17:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiIIPbP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiIIPbN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 11:31:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD58D2B00
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 08:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABB75B82550
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A59C433D6
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662737365;
        bh=lsCypRRO5kvygDOF45hdKz5QPad1rpxVOJFlTTKBzfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X9PQRu0Povf9J3ejeBFmqlsdqXC6ciwOLtCto6S7zQqcJm4L97GzeQyNLRo1QLVxF
         UkMwsHVCjiO/oturC9JPhpswQhy2CHj6audNgxVahB18GuVhUi3kpb8l35mF1kICVb
         1BQ5VzCWJGyHp/8BmNWVz8xlxwNphbYj+Vo+1IK76gl7UvUkDSh1qYWc5w4AbOaYVc
         536Fo3Z8uXxSCTuRtrU8vLfflnTqDRV6H4K9jMzM4OZCX6spuGU9bED5LWds4nBKOL
         P5gpLx4RoKmBL8nfdXZ0bqkBvHAf0hcz8vVWdobHZ06/Y5zZvxjd5X8eo+I42Psxrq
         CL93AYwnbWT7A==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-127d10b4f19so4738842fac.9
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 08:29:25 -0700 (PDT)
X-Gm-Message-State: ACgBeo06+6qvOnEPDerJmDygcRL761ZzEumGWOpz0y7J84K9l6FVnNQS
        um7O2iGT4YJcy/DcO+11p2xpPvchjVdwHmZqMlQ=
X-Google-Smtp-Source: AA6agR7cSVIi63Ut0hUxUv7bDF2abB7hQI/u5QQmETirnM/5uT4C/4N9OBTBBzX0H3y9hdti9smaqx7+tXd+jhfVwdM=
X-Received: by 2002:a05:6870:3127:b0:11c:8c2c:9015 with SMTP id
 v39-20020a056870312700b0011c8c2c9015mr5045152oaa.31.1662737364381; Fri, 09
 Sep 2022 08:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220908000254.3079129-1-joannelkoong@gmail.com> <20220908000254.3079129-2-joannelkoong@gmail.com>
In-Reply-To: <20220908000254.3079129-2-joannelkoong@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 9 Sep 2022 16:29:13 +0100
X-Gmail-Original-Message-ID: <CAPhsuW4kKjpPLJueKH1_jqpJp2XqaCZPr5X+dS6G=5JXpqFqwg@mail.gmail.com>
Message-ID: <CAPhsuW4kKjpPLJueKH1_jqpJp2XqaCZPr5X+dS6G=5JXpqFqwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Add bpf_dynptr_data_rdonly
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

On Thu, Sep 8, 2022 at 1:10 AM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Add a new helper bpf_dynptr_data_rdonly
>
> void *bpf_dynptr_data_rdonly(struct bpf_dynptr *ptr, u32 offset, u32 len);
>
> which gets a read-only pointer to the underlying dynptr data.
>
> This is equivalent to bpf_dynptr_data(), except the pointer returned is
> read-only, which allows this to support both read-write and read-only
> dynptrs.
>
> One example where this will be useful is for skb dynptrs where the
> program type only allows read-only access to packet data. This API will
> provide a way to obtain a data slice that can be used for direct reads.
>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 15 +++++++++++++++
>  kernel/bpf/helpers.c           | 32 ++++++++++++++++++++++++++------
>  kernel/bpf/verifier.c          |  7 +++++--
>  tools/include/uapi/linux/bpf.h | 15 +++++++++++++++
>  4 files changed, 61 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c55c23f25c0f..cce3356765fc 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5439,6 +5439,20 @@ union bpf_attr {
>   *             *flags* is currently unused, it must be 0 for now.
>   *     Return
>   *             0 on success, -EINVAL if flags is not 0.
> + *
> + * void *bpf_dynptr_data_rdonly(struct bpf_dynptr *ptr, u32 offset, u32 len)
> + *     Description
> + *             Get a read-only pointer to the underlying dynptr data.
> + *
> + *             This is equivalent to **bpf_dynptr_data**\ () except the
> + *             pointer returned is read-only, which allows this to support
> + *             both read-write and read-only dynptrs. For more details on using
> + *             the API, please refer to **bpf_dynptr_data**\ ().
> + *     Return
> + *             Read-only pointer to the underlying dynptr data, NULL if the
> + *             dynptr is invalid or if the offset and length is out of bounds
> + *             or in a paged buffer for skb-type dynptrs or across fragments
> + *             for xdp-type dynptrs.
>   */
>  #define __BPF_FUNC_MAPPER(FN)          \
>         FN(unspec),                     \
> @@ -5652,6 +5666,7 @@ union bpf_attr {
>         FN(ktime_get_tai_ns),           \
>         FN(dynptr_from_skb),            \
>         FN(dynptr_from_xdp),            \
> +       FN(dynptr_data_rdonly),         \
>         /* */
>
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index befafae34a63..30a59c9e5df3 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1572,7 +1572,7 @@ static const struct bpf_func_proto bpf_dynptr_write_proto = {
>         .arg5_type      = ARG_ANYTHING,
>  };
>
> -BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
> +void *__bpf_dynptr_data(struct bpf_dynptr_kern *ptr, u32 offset, u32 len, bool writable)
>  {
>         enum bpf_dynptr_type type;
>         void *data;
> @@ -1585,7 +1585,7 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
>         if (err)
>                 return 0;

Let's return NULL for void* type.

>
> -       if (bpf_dynptr_is_rdonly(ptr))
> +       if (writable && bpf_dynptr_is_rdonly(ptr))
>                 return 0;
ditto
>
>         type = bpf_dynptr_get_type(ptr);
> @@ -1610,13 +1610,31 @@ BPF_CALL_3(bpf_dynptr_data, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len
>                 /* if the requested data in across fragments, then it cannot
>                  * be accessed directly - bpf_xdp_pointer will return NULL
>                  */
> -               return (unsigned long)bpf_xdp_pointer(ptr->data,
> -                                                     ptr->offset + offset, len);
> +               return bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
>         default:
> -               WARN_ONCE(true, "bpf_dynptr_data: unknown dynptr type %d\n", type);
> +               WARN_ONCE(true, "__bpf_dynptr_data: unknown dynptr type %d\n", type);

Let's use __func__ so we don't have to change this again.

WARN_ONCE(true, "%s: unknown dynptr type %d\n", __func__, type);

Thanks,
Song

[...]
