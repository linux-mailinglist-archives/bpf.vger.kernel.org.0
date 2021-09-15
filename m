Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9160640CDCF
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 22:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhIOUTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOUTm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Sep 2021 16:19:42 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C3CC061574
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 13:18:22 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id c6so8200915ybm.10
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XztQZv+xMjT+NvV0MEIOsLpLYOoeuo5CoaYpFylzB4=;
        b=bRH2WYGlcxGz3gL7XnR85xwLLE9U8COfTOmZweXDhHdQgT5sCAcyFw5rP2YZ88ff+O
         sJg4SkFb8mTR/kBrwG703Vj036ylcangQLMJcpKr9oQmMj9Gpl3UwHm3+0Xr1NxJSYQR
         NtuQmAzR6ISzmO21LtAYu8Ce08MDPL3cGDL2Ykh2kxsXFuXCj8uxTFgiZxg6LubxLEn+
         05WlQ5y3ZEL5n/7yrowefAti3YgqnGOLWNspJ8W79T+pXYU8HXpFIopYDNzBUojQBsny
         9Hzk5NGAhyDjINviUn7zgA++M79sB/hRggpqm/BZCJ3B/D4eaSI5HAcJBwwURq273nEg
         LJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XztQZv+xMjT+NvV0MEIOsLpLYOoeuo5CoaYpFylzB4=;
        b=kfzSXcsUeH6jFNhvD3t0En/EbztEF3yNuoHcE3GGNtBQ99sepOFIBDzgflrmU9qssp
         oOkg3fdZlM68hqQWbmHdTA8wgtfQM8DagFOAe9UVNOUYz7ptgagpYJGXY+mCuPWy4NeU
         CIPrBTLMz3XlAL3U88/CsIb3nxx0k5UFgBYFvpt1qBFfscbvs/CFxqpCbI/GAHy0HXYI
         kDC7CMaDsmJkbb8u39yAJpmwkFPzhqneMqu8Q4h08c1dbQaC/5EyVxbUZPUcryj4Wyi7
         hAZsISp9SIMjiWSvWcJqwRxiI7jFAxsEacPeBkQahmJC7r5vwJ2KKNsNbwrRbSLqQj8u
         y+SQ==
X-Gm-Message-State: AOAM5313BL6mIlNxKSTWf74YuU8ARIq3OfAo9QsmkBeByzbt+zBRPqlP
        ClwGCaCKZCleGvz2xk+uopIrDEAlQHMGBVTj8aBYo0Qx
X-Google-Smtp-Source: ABdhPJwoWVjwORQxsujUTrrlcOMtwP+TNseZJpGKIQx5oVP4KBsbRuBX8NI4IyYkbM0PQ0ni8TFouW8/VEDB3JV+jYw=
X-Received: by 2002:a25:9881:: with SMTP id l1mr2228199ybo.455.1631737102034;
 Wed, 15 Sep 2021 13:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210915021951.117186-1-grantseltzer@gmail.com>
In-Reply-To: <20210915021951.117186-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Sep 2021 13:18:11 -0700
Message-ID: <CAEf4Bzb+nDGth12bYZNjLDonkH6TuswfZhNQxmZJq3YF_w-_2Q@mail.gmail.com>
Subject: Re: [PATCH btf-next v3] libbpf: Add sphinx code documentation comments
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 7:21 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds comments above five functions in btf.h which document
> their uses. These comments are of a format that doxygen and sphinx
> can pick up and render. These are rendered by libbpf.readthedocs.org
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/btf.h | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>

Did a few tweaks and re-flowed the text with vim. Pushed to bpf-next,
thanks! I'll sync all this into Github momentarily.

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4a711f990904..bfbc5e780e0f 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>  /* Copyright (c) 2018 Facebook */
> +/*! \file */
>
>  #ifndef __LIBBPF_BTF_H
>  #define __LIBBPF_BTF_H
> @@ -30,11 +31,77 @@ enum btf_endianness {
>         BTF_BIG_ENDIAN = 1,
>  };
>
> +/**
> + * @brief **btf__free()** frees all data of a BTF object
> + * @param btf BTF object to free
> + */
>  LIBBPF_API void btf__free(struct btf *btf);
>
> +/**
> + * @brief **btf__new()** creates a new instance of a BTF object
> + * from the raw bytes of an ELF's BTF section
> + * @param data raw bytes
> + * @param size number of bytes passed in `data`
> + * @return new instance of BTF object which has to be eventually freed
> + * with **btf__free()**
> + *
> + * On error, error-code-encoded-as-pointer is returned, not a NULL. To
> + * extract error code from such a pointer `libbpf_get_error()` should be
> + * used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
> + * enabled, NULL is returned on error instead. In both cases thread-local
> + * `errno` variable is always set to error code as well.
> + */
>  LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
> +
> +/**
> + * @brief **btf__new_split()** create a new instance of a BTF object from
> + * the provided raw data bytes. It takes another BTF instance, **base_btf**,
> + * which serves as a base BTF, which is extended by types in a newly created
> + * BTF instance
> + * @param data raw bytes
> + * @param size length of raw bytes
> + * @param base_btf the base btf object
> + * @return new instance of BTF object which has to be eventually freed
> + * with **btf__free()**
> + *
> + * On error, error-code-encoded-as-pointer is returned, not a NULL. To
> + * extract error code from such a pointer `libbpf_get_error()` should be
> + * used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
> + * enabled, NULL is returned on error instead. In both cases thread-local
> + * `errno` variable is always set to error code as well.
> + */
>  LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
> +
> +/**
> + * @brief **btf__new_empty()** creates an unpopulated BTF object
> + * Use `btf__add_*()` to populate such BTF object.
> + * @return new instance of BTF object which has to be eventually freed
> + * with **btf__free()**
> + *
> + * On error, error-code-encoded-as-pointer is returned, not a NULL. To
> + * extract error code from such a pointer `libbpf_get_error()` should be
> + * used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
> + * enabled, NULL is returned on error instead. In both cases thread-local
> + * `errno` variable is always set to error code as well.
> + */
>  LIBBPF_API struct btf *btf__new_empty(void);
> +
> +/**
> + * @brief **btf__new_empty_split()** creates an unpopulated
> + * BTF object from an ELF BTF section except with a base BTF
> + * on top of which split BTF should be based
> + * @return new instance of BTF object which has to be eventually freed
> + * with **btf__free()**
> + *
> + * If *base_btf* is NULL, `btf__new_empty_split()` is equivalent to
> + * `btf__new_empty()` and creates non-split BTF.

Added this to btf__new_split() description as well

> + *
> + * On error, error-code-encoded-as-pointer is returned, not a NULL. To
> + * extract error code from such a pointer `libbpf_get_error()` should be
> + * used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
> + * enabled, NULL is returned on error instead. In both cases thread-local
> + * `errno` variable is always set to error code as well.
> + */
>  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
>
>  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
> --
> 2.31.1
>
