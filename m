Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906C051E298
	for <lists+bpf@lfdr.de>; Sat,  7 May 2022 01:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380436AbiEFXwi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 May 2022 19:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356164AbiEFXwh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 May 2022 19:52:37 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C23221836
        for <bpf@vger.kernel.org>; Fri,  6 May 2022 16:48:53 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id c125so9682592iof.9
        for <bpf@vger.kernel.org>; Fri, 06 May 2022 16:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GAvP82MQ+1IOwZlbf0RP0T9+F27ib9iB5cE3N5Nbu+A=;
        b=PwJ4QzeDenh4ryFPgsPnpdL/IO7BaSZIy/SBIhb2s2CAcmqhOybQm3iJkw60giA7Ld
         brUHe0lbsdITy32+HN5C3xS4L57cthX4EEldtlB75CDcTnzT/9t5JaW/fhndUoT3xVnV
         8SZ9ul48Okz752E0dNbvF76TT5U0aIq2dhR9T78AqBXybVQKXrlhD/ftsR+XO7V8sZyO
         If+Fdb2/DJBfjKrRGYw/BfImaVB3OIwX1FRWLfZokq0r/GVa75mgM8R4UpelGHeOz1H8
         mNIIVjhwX26QNryNp73KE658/RPug4RZe+gKSuTCGUQ2kSSZZULFVO0nqoJckBexbJRj
         wBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GAvP82MQ+1IOwZlbf0RP0T9+F27ib9iB5cE3N5Nbu+A=;
        b=Yr5/JqR880ZcVLbZHbVkWRdizvfCH62LFVD40dQ3aWW5q8dZcT/Aa1aG7gS329q7zW
         tnwjBgkSaFbeVh1ajj9UEOEZ8pNzZEO2VzaugDw7AxgaDmmhpgxjmt4ibQN5JNT2Nd6G
         si364Jl8C0cnR0GBYQ3HK13kJfQYpQ4EIO1dSqBf6m4LnhsMoPEdW0R0dinhzDrQjmOq
         oMlXRdfzA29KK04nFkcxwILKLJtS14RXDbtDmZ07TRSITlhT+2YxczsWfp9BfUxUixX/
         LQ453C0SsWCQWXY/I24WaT6L5+HZ/53lTI9cjvDKuU1vSM2ifVTwPdPSU3oh0TCcGJxi
         UpIw==
X-Gm-Message-State: AOAM531PWu5oj5LpjqgLrv68pM0sfCw/bl9lZDsKGismMFWk78mpxFZF
        E7HMBX1IAubH82Gy2FJESth8cICcO24mGx4lIsA=
X-Google-Smtp-Source: ABdhPJzM8ee1k0Ihkmgnw/x+9iXv0Di12AAZds8w+xoX3+MLbxMyiDXflOIwoT2VILyYvym5uwy48SxBC82xrAZCYZE=
X-Received: by 2002:a05:6638:33a1:b0:32b:8e2b:f9ba with SMTP id
 h33-20020a05663833a100b0032b8e2bf9bamr2487666jav.93.1651880932846; Fri, 06
 May 2022 16:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220428211059.4065379-1-joannelkoong@gmail.com> <20220428211059.4065379-5-joannelkoong@gmail.com>
In-Reply-To: <20220428211059.4065379-5-joannelkoong@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 6 May 2022 16:48:41 -0700
Message-ID: <CAEf4BzbVHWOeNH1j9ZoQTKfMXhKTGmpv0AO0+DKrdj6AyjyH3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/6] bpf: Add bpf_dynptr_read and bpf_dynptr_write
To:     Joanne Koong <joannelkoong@gmail.com>
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

On Thu, Apr 28, 2022 at 2:12 PM Joanne Koong <joannelkoong@gmail.com> wrote:
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
>  include/linux/bpf.h            | 16 ++++++++++
>  include/uapi/linux/bpf.h       | 19 ++++++++++++
>  kernel/bpf/helpers.c           | 56 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h | 19 ++++++++++++
>  4 files changed, 110 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 10efbec99e93..b276dbf942dd 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2387,6 +2387,12 @@ enum bpf_dynptr_type {
>  #define DYNPTR_SIZE_MASK       0xFFFFFF
>  #define DYNPTR_TYPE_SHIFT      28
>  #define DYNPTR_TYPE_MASK       0x7
> +#define DYNPTR_RDONLY_BIT      BIT(31)
> +
> +static inline bool bpf_dynptr_is_rdonly(struct bpf_dynptr_kern *ptr)
> +{
> +       return ptr->size & DYNPTR_RDONLY_BIT;
> +}
>
>  static inline enum bpf_dynptr_type bpf_dynptr_get_type(struct bpf_dynptr_kern *ptr)
>  {
> @@ -2408,6 +2414,16 @@ static inline int bpf_dynptr_check_size(u32 size)
>         return size > DYNPTR_MAX_SIZE ? -E2BIG : 0;
>  }
>
> +static inline int bpf_dynptr_check_off_len(struct bpf_dynptr_kern *ptr, u32 offset, u32 len)
> +{
> +       u32 capacity = bpf_dynptr_get_size(ptr) - ptr->offset;

didn't you specify that size excludes offset, so size is a capacity?

  +       /* Size represents the number of usable bytes in the dynptr.
  +        * If for example the offset is at 200 for a malloc dynptr with
  +        * allocation size 256, the number of usable bytes is 56.

> +
> +       if (len > capacity || offset > capacity - len)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data, enum bpf_dynptr_type type,
>                      u32 offset, u32 size);
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 679f960d2514..2d539930b7b2 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5209,6 +5209,23 @@ union bpf_attr {
>   *             'bpf_ringbuf_discard'.
>   *     Return
>   *             Nothing. Always succeeds.
> + *
> + * long bpf_dynptr_read(void *dst, u32 len, struct bpf_dynptr *src, u32 offset)
> + *     Description
> + *             Read *len* bytes from *src* into *dst*, starting from *offset*
> + *             into *src*.
> + *     Return
> + *             0 on success, -EINVAL if *offset* + *len* exceeds the length

this sounds more like E2BIG ?

> + *             of *src*'s data or if *src* is an invalid dynptr.
> + *

[...]
