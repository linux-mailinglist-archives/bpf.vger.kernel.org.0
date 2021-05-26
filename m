Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1880391D1B
	for <lists+bpf@lfdr.de>; Wed, 26 May 2021 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbhEZQgE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 May 2021 12:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhEZQgC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 May 2021 12:36:02 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CC1C061574;
        Wed, 26 May 2021 09:34:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id b13so2905456ybk.4;
        Wed, 26 May 2021 09:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oboUZq0zA1lLeO/aKIPmZ0lOKXyY5wuhOqnQI3+E4XY=;
        b=lrwBF36OIGwZ7ESvibiu7dqe+PeJr/jKmEmBzZuOJujwInS7ZVet9HXLB/yQFQunlK
         iSkoWX4PNlztCCBApgiFE0jtznOA7RstvQW8yDNuUq1VHzpOKCv6MSXhDeXXY7TfBAKw
         4B5Btszz+4VnwUBJLd+P9uRo2gGxSLE7HDfAYWhvxNZpSrldba7Y65DjHjKz2Wr9MO8Y
         exte0jva59f2hvlGpa2Bm0b0+Fw44q8LAoRXx+axgAyjOmomqcKleYyQRgeBtMEFj79V
         nRFxfdVf5bzENWGh/BfEhHT4hcJYhseRb0aQCNPJj55CXhONoD80zwujOROgyOH/qbTr
         YhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oboUZq0zA1lLeO/aKIPmZ0lOKXyY5wuhOqnQI3+E4XY=;
        b=lKFDn6vCnZpBsUv8vTuGOnUcfKgz3k/RttTFjO6AMirGjPLmuXVP7Mw0Nf3YyJX9rL
         3tFUnVm5ORnj9083B4FVF0XEB+BKhLzOrmi78beC2CW9DPtvnv5QB+miDevFgoJKAMTO
         yOsnjbr+wc27PFck0seSSv/xjhvZpb/7jehoa8aokn9gA+C7R24itMSOOO7fQjHmhP/q
         +ba2mP9KtHfJ1Zn44EKIOtXLG853RBYSBW/aVbpj+bOa5AwoUm8wxBn3dXWpiO+OdroR
         t3T803QRX785Rb04Rq+/YSN1vzpFUsbv7CQ+IzXRe0xRNsDobLnim12JvAB81AxOrSJA
         uJvQ==
X-Gm-Message-State: AOAM533df7bojmI2j8Z5KqAdbH5rPumlAsiWYqxE5XeFiDMdcpm3z/zp
        ASrNX5H1zr2ziHR91YONL+OGsVeiTTePq5EaHMg=
X-Google-Smtp-Source: ABdhPJzMgF683Rsd4CqNeN6iPoK2oOSuVH0ww8cl45qhqnZeOF82GEt2ctZa2kafYOecekzvbKmkT0MaMInVIu1fuQM=
X-Received: by 2002:a25:ba06:: with SMTP id t6mr49612596ybg.459.1622046870139;
 Wed, 26 May 2021 09:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210525201825.2729018-1-revest@chromium.org>
In-Reply-To: <20210525201825.2729018-1-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 May 2021 09:34:19 -0700
Message-ID: <CAEf4BzaHDa5Kujq4S_=0tPvok_ELABp=rwnv_YB4PQvvdy=UnA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] libbpf: Move BPF_SEQ_PRINTF and BPF_SNPRINTF to bpf_helpers.h
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 25, 2021 at 1:18 PM Florent Revest <revest@chromium.org> wrote:
>
> These macros are convenient wrappers around the bpf_seq_printf and
> bpf_snprintf helpers. They are currently provided by bpf_tracing.h which
> targets low level tracing primitives. bpf_helpers.h is a better fit.
>
> The __bpf_narg and __bpf_apply macros are needed in both files so
> provided twice and guarded by ifndefs.
>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  kernel/bpf/preload/iterators/iterators.bpf.c  |  1 -
>  tools/lib/bpf/bpf_helpers.h                   | 70 +++++++++++++++++++
>  tools/lib/bpf/bpf_tracing.h                   | 62 +++-------------
>  .../bpf/progs/bpf_iter_bpf_hash_map.c         |  1 -
>  .../selftests/bpf/progs/bpf_iter_bpf_map.c    |  1 -
>  .../selftests/bpf/progs/bpf_iter_ipv6_route.c |  1 -
>  .../selftests/bpf/progs/bpf_iter_netlink.c    |  1 -
>  .../selftests/bpf/progs/bpf_iter_task.c       |  1 -
>  .../selftests/bpf/progs/bpf_iter_task_btf.c   |  1 -
>  .../selftests/bpf/progs/bpf_iter_task_file.c  |  1 -
>  .../selftests/bpf/progs/bpf_iter_task_stack.c |  1 -
>  .../selftests/bpf/progs/bpf_iter_task_vma.c   |  1 -
>  .../selftests/bpf/progs/bpf_iter_tcp4.c       |  1 -
>  .../selftests/bpf/progs/bpf_iter_tcp6.c       |  1 -
>  .../selftests/bpf/progs/bpf_iter_udp4.c       |  1 -
>  .../selftests/bpf/progs/bpf_iter_udp6.c       |  1 -
>  .../selftests/bpf/progs/test_snprintf.c       |  1 -
>  17 files changed, 80 insertions(+), 67 deletions(-)
>
> diff --git a/kernel/bpf/preload/iterators/iterators.bpf.c b/kernel/bpf/preload/iterators/iterators.bpf.c
> index 52aa7b38e8b8..03af863314ea 100644
> --- a/kernel/bpf/preload/iterators/iterators.bpf.c
> +++ b/kernel/bpf/preload/iterators/iterators.bpf.c
> @@ -2,7 +2,6 @@
>  /* Copyright (c) 2020 Facebook */
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
> -#include <bpf/bpf_tracing.h>
>  #include <bpf/bpf_core_read.h>
>
>  #pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 9720dc0b4605..68d992b30f26 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -158,4 +158,74 @@ enum libbpf_tristate {
>  #define __kconfig __attribute__((section(".kconfig")))
>  #define __ksym __attribute__((section(".ksyms")))
>
> +#ifndef ___bpf_concat
> +#define ___bpf_concat(a, b) a ## b
> +#endif
> +#ifndef ___bpf_apply
> +#define ___bpf_apply(fn, n) ___bpf_concat(fn, n)
> +#endif
> +#ifndef ___bpf_nth
> +#define ___bpf_nth(_, _1, _2, _3, _4, _5, _6, _7, _8, _9, _a, _b, _c, N, ...) N
> +#endif
> +#ifndef ___bpf_narg
> +#define ___bpf_narg(...) \
> +       ___bpf_nth(_, ##__VA_ARGS__, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +#endif
> +#ifndef ___bpf_empty
> +#define ___bpf_empty(...) \
> +       ___bpf_nth(_, ##__VA_ARGS__, N, N, N, N, N, N, N, N, N, N, 0)
> +#endif

___bpf_empty doesn't seem to be used, let's remove it for now?
Otherwise it looks good.

> +
> +#define ___bpf_fill0(arr, p, x) do {} while (0)
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
> +

[...]
