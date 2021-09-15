Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5DA40BC7D
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 02:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbhIOANj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 20:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhIOANi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Sep 2021 20:13:38 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B67C061574
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:12:20 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i12so1891116ybq.9
        for <bpf@vger.kernel.org>; Tue, 14 Sep 2021 17:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMwA+IsSvS6VH6do4VIyXA16ySLabEkccBLhEasWS8I=;
        b=WFDOOu6ngrxNfjhYNK7RBP57h9DqeUfq5a43AbVRcW5X57Vv1cUMOAhuvjBNMNyZka
         k+/KqiyMFMyRt6o96btzyb0HVKLCmmh8dAg9dGUoYxFxhM7kMSgeOhevuaVMXrVXtwY2
         /nrnml532isBDTBKXWVxmsDkwwCBtu2PdaVLHMj1/jZHcD7kP8nCFTsw2aBf5ryaJBVJ
         nhor7ItEaZchq0C7kKo5el3vSuWjbwcxdfIOAsYYUCRR9arERHkrQ3YvUJwPR8Lp6U0v
         EY0zdd19lSPrbRj2DT5CTRUG2nfMyabZO70Bvl3aOAw+P9qsNXXbUfMRoJyTs4kCxe/o
         Rg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMwA+IsSvS6VH6do4VIyXA16ySLabEkccBLhEasWS8I=;
        b=YjmQw6DAYQrAX0hbfHnqtat7yilki7heD2rpKwToIGq3KSL7jfP6pcZe6bJz0Y0fqO
         VZfHaIKSWoLVWgQxE8mTWJAVyP/mMT66pk7Yh/vbJYLkCr8iyU7Ppq7Bnr3SKv976xuv
         BswIfZZ7eQVsQti6gY4F+A7CwuVUXZGu87pLkxxsnzqGQ/4pxMRnssYM92dNdFTRHDzy
         ZemQAXJMtqS+t/LAPPh/iQdRSWmnWedylfh9JlF4DjHqRXEyoiCV31UdfAdP+7OoPuEa
         PF4aW8aPUmjo9+TDWQAyDrOYdK/zdpuO7l61p6FogAMB/of0ldtoltfjohumOfEbv7Ue
         XlsA==
X-Gm-Message-State: AOAM531jF4DiPVTjHutsLxMcWga2hquBZ1wAa4T7jENI8eeV2fdGxB7H
        rXfdEfBpySG6CObZRSU6hC1q7A/jvNn7zypqA8o=
X-Google-Smtp-Source: ABdhPJyO71nAGJlh/Cqrtmwk0l71Ep3FPnHsJgsSaNu5EG7otWtB2tee/afi0l9k7w2UjTd1yMXq1eCWF4ocbKE3NLM=
X-Received: by 2002:a25:bbc4:: with SMTP id c4mr2583325ybk.114.1631664738905;
 Tue, 14 Sep 2021 17:12:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210914201642.98734-1-grantseltzer@gmail.com>
In-Reply-To: <20210914201642.98734-1-grantseltzer@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Sep 2021 17:12:07 -0700
Message-ID: <CAEf4BzYO-C1eK1m3ii=SBqG7YPpX=GdYJLbo96nK+Vgx-hp-+g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] Add sphinx code documentation comments
To:     grantseltzer <grantseltzer@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Sep 14, 2021 at 1:17 PM grantseltzer <grantseltzer@gmail.com> wrote:
>
> From: Grant Seltzer <grantseltzer@gmail.com>
>
> This adds comments above five functions in btf.h which document
> their uses. These comments are of a format that doxygen and sphinx
> can pick up and render. These are rendered by libbpf.readthedocs.org
>
> Signed-off-by: Grant Seltzer <grantseltzer@gmail.com>
> ---
>  tools/lib/bpf/btf.h | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 4a711f990904..05e06f0136e3 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -1,5 +1,6 @@
>  /* SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause) */
>  /* Copyright (c) 2018 Facebook */
> +/*! \file */

What's the purpose of this? Is it some sort of description for the entire file?

>
>  #ifndef __LIBBPF_BTF_H
>  #define __LIBBPF_BTF_H
> @@ -30,11 +31,47 @@ enum btf_endianness {
>         BTF_BIG_ENDIAN = 1,
>  };
>
> +/**
> + * @brief **btf__free()** frees all data of a BTF object.
> + * @param btf BTF object to free
> + * @return void

agreed to drop this one

> + */
>  LIBBPF_API void btf__free(struct btf *btf);
>
> +/**
> + * @brief **btf__new()** creates a new instance of a BTF object.
> + * from the raw bytes of an ELF's BTF section
> + * @param data raw bytes
> + * @param size length of raw bytes

reads a bit weird, bytes don't have "length". "Number of bytes passed
in `data`"?

> + * @return new instance of BTF object which has to be eventually freed
> + * with **btf__free()**
> + */
>  LIBBPF_API struct btf *btf__new(const void *data, __u32 size);
> +
> +/**
> + * @brief **btf__new_split()** create a new instance of a BTF object from
> + * the provided raw data bytes. It takes another BTF instance, **base_btf**,
> + * which serves as a base BTF, which is extended by types in a newly created
> + * BTF instance.
> + * @param data raw bytes
> + * @param size length of raw bytes
> + * @param base_btf the base btf object
> + * @return struct btf *

I didn't think I had to leave a suggestion under every such empty @return...

BTW, return documentation is finally a good place where we should
document quirky libbpf error returning behavior. Something like this:

```
On error, error-code-encoded-as-pointer is returned, not a NULL. To
extract error code from such a pointer `libbpf_get_error()` should be
used. If `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is
enabled, NULL is returned on error instead. In both cases thread-local
`errno` variable is always set to error code as well.
```

We should have this remark under every pointer-returning API which has
this error-code-as-ptr logic (not all APIs do).


> + */
>  LIBBPF_API struct btf *btf__new_split(const void *data, __u32 size, struct btf *base_btf);
> +
> +/**
> + * @brief **btf__new_empty()** creates an unpopulated BTF object.

We can add "Use `btf__add_*()` to populate such BTF object.

> + * @return struct btf *

another not described @return

> + */
>  LIBBPF_API struct btf *btf__new_empty(void);
> +
> +/**
> + * @brief **btf__new_empty_split()** creates an unpopulated
> + * BTF object from an ELF BTF section except with a base BTF
> + * on top of which split BTF should be based.

If *base_btf* is NULL, `btf__new_empty_split()` is equivalent to
`btf__new_empty()` and creates non-split BTF.

> + * @return struct btf *

and one more

> + */
>  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
>
>  LIBBPF_API struct btf *btf__parse(const char *path, struct btf_ext **btf_ext);
> --
> 2.31.1
>
