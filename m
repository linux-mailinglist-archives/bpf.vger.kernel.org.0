Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E786652AED2
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiEQXr5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbiEQXr4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:47:56 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FEB4ECD4
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:47:55 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id s23so506658iog.13
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 16:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T/Fi4/M/EGmplrpa6Jy6M6+BkvnddCT4QMY4XFLd80A=;
        b=iyJzQ+zNigtxJXJyLH3vkbbrMmvKeZYBBNM9Hoy15ASI34UTCnSLTToZgzi9YyqTFa
         cRmWkzbIHefi/E2RTYle4YEfJG+B+KvQ5+PKp3gDwBvW8diA5cYB63ScU/iAn6lIsaSx
         0WpLoTD07x9xOWzhwTin8Fyte8l5oLIhlkaqeY3xGA5HG/bHtka2c/BCNVRYEnUCevmi
         5a3bLFxoqmXzdhJu9HTQ1AanDUYvLlgo7Ra+25nvUQe1rIrGQD4FyvsoPXRZeVdvYKCW
         i9GkyO/112C+dmDGD6zWhmtSvOvtt+BskGQaebKeADUolAt81yzBcnxByQ/LU36PKSVN
         YZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T/Fi4/M/EGmplrpa6Jy6M6+BkvnddCT4QMY4XFLd80A=;
        b=w6QdBmp+WOzkYTtwudtjdrHhDSyskXptxVN6iw5VqwIGeA5dIhKye2c5finngYJVIo
         +q0M1mEsSBJfZ+74c9IZ1hapMefeJhpF0YovgALaHdC0r/5/bbx3a+u6wdodCbr6Gn54
         9Hu5EXFLllgCzTmzUYxYd1/hcOC50bSZpGWOj5o5MrbK6omAAD/OYOqFVmbwUj9kH7XU
         uCDN+7ba4cTd9qYnQq4mY5cGkD8msLUrZRpXkxYhNgzXw2uLe1V3pcTRje1RLJVD0u+j
         dSgxlFPQFYMu0FycNjxJUERJ+z3P1wZGqroQx6pGRW7tR+LWL9l53vH4VXIDsR/NLBtm
         N6yQ==
X-Gm-Message-State: AOAM5302o6JkZIyl0tXXgNCjUKdlmuw4BxrFNZ/DzmI5FiVmZa7BxRHl
        PqXIwY79SdgjCLnZf4/gCVw+D8K2zxDrx34qCMM=
X-Google-Smtp-Source: ABdhPJyeUA+JpImhsodxVR/lgjOzGFI7Baxi/aNsbfr/hG5aoi0Di9YhC5ZZwd14IdJx/JllTx4kxqLJObXSAxqqHLQ=
X-Received: by 2002:a05:6638:2393:b0:32e:319d:c7cc with SMTP id
 q19-20020a056638239300b0032e319dc7ccmr6791724jat.103.1652831275431; Tue, 17
 May 2022 16:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220514031221.3240268-1-yhs@fb.com> <20220514031356.3247576-1-yhs@fb.com>
In-Reply-To: <20220514031356.3247576-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 17 May 2022 16:47:44 -0700
Message-ID: <CAEf4BzZJ-UoVK75tgzh+sFRVw3X+OsGEQHU6iDgpnb=Y3gLrcw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 18/18] docs/bpf: Update documentation for
 BTF_KIND_ENUM64 support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, May 13, 2022 at 8:14 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add BTF_KIND_ENUM64 documentation in btf.rst.
> Also fixed a typo for section number for BTF_KIND_TYPE_TAG
> from 2.2.17 to 2.2.18.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

LGTM, but see pedantic note below

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  Documentation/bpf/btf.rst | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
>

[...]

> +2.2.19 BTF_KIND_ENUM64
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +``struct btf_type`` encoding requirement:
> +  * ``name_off``: 0 or offset to a valid C identifier
> +  * ``info.kind_flag``: 0 for unsigned, 1 for signed
> +  * ``info.kind``: BTF_KIND_ENUM64
> +  * ``info.vlen``: number of enum values
> +  * ``size``: 1/2/4/8
> +
> +``btf_type`` is followed by ``info.vlen`` number of ``struct btf_enum64``.::
> +
> +    struct btf_enum64 {
> +        __u32   name_off;
> +        __u32   val_lo32;
> +        __u32   val_hi32;
> +    };
> +
> +The ``btf_enum64`` encoding:
> +  * ``name_off``: offset to a valid C identifier
> +  * ``val_lo32``: lower 32-bit value for a 64-bit value
> +  * ``val_hi32``: high 32-bit value for a 64-bit value
> +

I presume if size is < 8 then val_hi32 will be sign-extended (i.e.,
0xffffffff for signed enum and negative enumerator values, 0
otherwise), right? Should it be specified here?

>  3. BTF Kernel API
>  =================
>
> --
> 2.30.2
>
