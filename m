Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B5B34B26B
	for <lists+bpf@lfdr.de>; Sat, 27 Mar 2021 00:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbhCZXBp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 19:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCZXBO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Mar 2021 19:01:14 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F339AC0613AA;
        Fri, 26 Mar 2021 16:01:13 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id m132so7446649ybf.2;
        Fri, 26 Mar 2021 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zzUGJP1gKljXNL+dWzK6bM9klaJMB7DWl3/O8jovtY=;
        b=Jo1prXgd/tzTVfZ1234xBql/h6R3F1XxSiPjSrsXxISNIQ3gpuubLfxTqj/DgiWP4w
         kTCm6y4G7FDmJrnC3+H3LtnetJ3Km01nYVgLVakhGYmHge8E3chaBJnzQSy0oH+gyY7U
         htZSSgFO4RZWimdC60ZRNcN9KCWoxDPZVTUrrJS7cEY5PEOubbxXZShtf5uKypT06cec
         2KNvjXgpYWpDqHD4LHf4ZJFelhGPzWqUkJSZlZFJ0UUFGXHzyvoBjuYnijBMJIJhQOus
         uyjqYbYuarV8c/vO2tH02eCrgOLx0v1JNE7Ao9oelc9/y37fl9tLu95FDo9u21VAhjC2
         kAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zzUGJP1gKljXNL+dWzK6bM9klaJMB7DWl3/O8jovtY=;
        b=M5rHAytnpRRebARxqRHWfFKe1KYoPlJgboqrH612IczwWBqFhM9tHDb5QT62jCrL6S
         XLjGtdDhoJ4LzayT2fSoR4rr4A3f3ij/gTefbhuYRLBdEAg+6bvZLAMFuJRo1z9XjTZf
         CTE0rMy8TniuJ2PbUIdolUi6QNSJC2TYv/9nvqFOuT4wLoK2SaJelsPdKGuEKRmYla3l
         l4YXw0DoYFciF/o1vMNS7EnbYTMpxyNfeqQ4wU+iTA6ACUSYMDvZqfnkJSZUb9MBjH/g
         0NDT4M7Qa2w7yAn3L9mbCBqsWOtGTjf9z1PvIp8nOjIu3krtERJ5l/WThMhK3AcupokT
         vL1g==
X-Gm-Message-State: AOAM531yjTbPbPT5wJoiOYzyXdrYxofDgMN4AFjb2HNlP6S2b5oP+TqP
        6kabOZGLSm0u74gqlpiz7ThrK0FyndQxgQ/zmgo=
X-Google-Smtp-Source: ABdhPJz6hs6GZj16SHLk4GLSBNgRpCP493uX7475s09Gps9tZLqvewzYKmwYF4sXgwQAALwl+JpzmZBe77d6JdKk8eE=
X-Received: by 2002:a25:becd:: with SMTP id k13mr22235164ybm.459.1616799673330;
 Fri, 26 Mar 2021 16:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210324022211.1718762-1-revest@chromium.org> <20210324022211.1718762-5-revest@chromium.org>
In-Reply-To: <20210324022211.1718762-5-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Mar 2021 16:01:02 -0700
Message-ID: <CAEf4BzbCZnLV6mHqqAX9vcEjxtKzu3a9RFCSs9wbmQWw67gXtA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Initialize the bpf_seq_printf
 parameters array field by field
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 23, 2021 at 7:23 PM Florent Revest <revest@chromium.org> wrote:
>
> When initializing the __param array with a one liner, if all args are
> const, the initial array value will be placed in the rodata section but
> because libbpf does not support relocation in the rodata section, any
> pointer in this array will stay NULL.
>
> Fixes: c09add2fbc5a ("tools/libbpf: Add bpf_iter support")
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  tools/lib/bpf/bpf_tracing.h | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
> index f9ef37707888..d9a4c3f77ff4 100644
> --- a/tools/lib/bpf/bpf_tracing.h
> +++ b/tools/lib/bpf/bpf_tracing.h
> @@ -413,6 +413,22 @@ typeof(name(0)) name(struct pt_regs *ctx)                              \
>  }                                                                          \
>  static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>
> +#define ___bpf_fill0(arr, p, x)

can you please double-check that no-argument BPF_SEQ_PRINTF won't
generate a warning about spurious ';'? Maybe it's better to have zero
case as `do {} while(0);` ?

> +#define ___bpf_fill1(arr, p, x) arr[p] = x
> +#define ___bpf_fill2(arr, p, x, args...) arr[p] = x; ___bpf_fill1(arr, p + 1, args)
> +#define ___bpf_fill3(arr, p, x, args...) arr[p] = x; ___bpf_fill2(arr, p + 1, args)
> +#define ___bpf_fill4(arr, p, x, args...) arr[p] = x; ___bpf_fill3(arr, p + 1, args)
> +#define ___bpf_fill5(arr, p, x, args...) arr[p] = x; ___bpf_fill4(arr, p + 1, args)
> +#define ___bpf_fill6(arr, p, x, args...) arr[p] = x; ___bpf_fill5(arr, p + 1, args)
> +#define ___bpf_fill7(arr, p, x, args...) arr[p] = x; ___bpf_fill6(arr, p + 1, args)
> +#define ___bpf_fill8(arr, p, x, args...) arr[p] = x; ___bpf_fill7(arr, p + 1, args)
> +#define ___bpf_fill9(arr, p, x, args...) arr[p] = x; ___bpf_fill8(arr, p + 1, args)
> +#define ___bpf_fill10(arr, p, x, args...) arr[p] = x; ___bpf_fill9(arr, p + 1, args)
> +#define ___bpf_fill11(arr, p, x, args...) arr[p] = x; ___bpf_fill10(arr, p + 1, args)
> +#define ___bpf_fill12(arr, p, x, args...) arr[p] = x; ___bpf_fill11(arr, p + 1, args)
> +#define ___bpf_fill(arr, args...) \
> +       ___bpf_apply(___bpf_fill, ___bpf_narg(args))(arr, 0, args)

cool. this is regular enough to easily comprehend :)

> +
>  /*
>   * BPF_SEQ_PRINTF to wrap bpf_seq_printf to-be-printed values
>   * in a structure.
> @@ -421,12 +437,14 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
>         ({                                                                  \
>                 _Pragma("GCC diagnostic push")                              \
>                 _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")      \
> +               unsigned long long ___param[___bpf_narg(args)];             \
>                 static const char ___fmt[] = fmt;                           \
> -               unsigned long long ___param[] = { args };                   \
> +               int __ret;                                                  \
> +               ___bpf_fill(___param, args);                                \
>                 _Pragma("GCC diagnostic pop")                               \

Let's clean this up a little bit;
1. static const char ___fmt should be the very first
2. _Pragma scope should be minimal necessary, which includes only
___bpf_fill, right?
3. Empty line after int __ret; and let's keep three underscores for consistency.


> -               int ___ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),    \
> -                                           ___param, sizeof(___param));    \
> -               ___ret;                                                     \
> +               __ret = bpf_seq_printf(seq, ___fmt, sizeof(___fmt),         \
> +                                      ___param, sizeof(___param));         \
> +               __ret;                                                      \

but actually you don't need __ret at all, just bpf_seq_printf() here, right?


>         })
>
>  #endif
> --
> 2.31.0.291.g576ba9dcdaf-goog
>
